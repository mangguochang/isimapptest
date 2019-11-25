package com.hzot.isim.controller.project.template;

import com.hzot.isim.base.BaseController;
import com.hzot.isim.entity.service.ServiceApplicationInfo;
import com.hzot.isim.entity.service.ServiceCamelInfo;
import com.hzot.isim.entity.service.ServiceInfo;
import com.hzot.isim.entity.service.ServiceInterfaceInfo;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@RequestMapping("/gits")
@Controller
public class GitTemplateController extends BaseController {


    @Value("${ansibleTemplate.ansibleBasepath}")
    private String  ansibleBasepath;

    @Value("${ansibleTemplate.configbashpath}")
    private String  configbashpath;

    @Value("${ansibleTemplate.hostSuffix}")
    private String  hostSuffix;

    @Value("${ansibleTemplate.targetPath}")
    private String targetPath;

    @Value("${ansibleTemplate.hosturl}")
    private String hosturl;

    @Value("${ansibleTemplate.restGit}")
    private String  restGit;

    @Value("${ansibleTemplate.dbGit}")
    private String  dbGit;

    @Value("${ansibleTemplate.wsdlGit}")
    private String  wsdlGit;

    /**
     * 执行restful模板
     * @return
     */
    @RequestMapping("/rest")
    @ResponseBody
    public RestResponse rest(String serviceId) throws IOException {
        RestResponse restResponse = new RestResponse();
        if(StringUtils.isBlank(serviceId)){
            return RestResponse.failure("服务ID不能未空");
        }

        //服务更新类型
        String type = "";
        //获取服务基本信息
        ServiceInfo serviceInfo = serviceInfoService.selectById(serviceId);
        //如果发布时间为空，则为新增
        if(serviceInfo.getDeploymentTime()==null){
            type = "add";
        }else{
            type = "edit";
        }

        //获取服务接口信息
        ServiceInterfaceInfo  servInterfaceInfo= serviceInterfaceInfoService.getByServiceId(serviceId);
        if(servInterfaceInfo==null){
            return RestResponse.failure("服务不存在");
        }
        //获取服务类型
        String servType= servInterfaceInfo.getServiceType();
      /*  if(!servType.equals("rest")){
            return RestResponse.failure("服务类型不是restful");
        }*/
        //获取服务的应用信息
        ServiceApplicationInfo appInfo= serviceApplicationInfoService.getByServiceId(serviceId);
        //获取配置信息
        ServiceCamelInfo servCamelInfo= serviceCamelInfoService.getByServiceId(serviceId);
        if(servCamelInfo==null){
            return RestResponse.failure("服务未配置");
        }

        //应用名称
        String appName=appInfo.getApplicationName();
        //应用命名空间
        String appNameSpace=StringUtils.isBlank(appInfo.getNamespace())?"corepanel":appInfo.getNamespace();
        //应用路由前缀
        String appHostName=appInfo.getApplicationHostName()+hostSuffix;

       String proInfo= servCamelInfo.getPropertiesInfo();
       //为配置文件增加随机内容，避免内容不变的情况下git无法自动提交

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        proInfo+=" \n ####   "+df.format(new Date());
        if(StringUtils.isBlank(proInfo)){
            return RestResponse.failure("服务配置信息不存在");
        }


        //临时组合文件目录
        File file = new File(configbashpath);
        if (!file.exists()) {
            file.mkdirs();
        }

        file = new File(targetPath);
        if (!file.exists()) {
            file.mkdirs();
        }

       String  servTypeTemp=servType.equals("db")?"dbTemplate":(servType.equals("soap")?"WSDLTemplate":"RestTemplate");
        file = new File(targetPath+servTypeTemp);
        if (!file.exists()) {
            file.mkdirs();
        }

        String  filePath=configbashpath+servTypeTemp+"/"+appName;
        String  filename="application.properties";
        boolean flag=createConfig(servType,appName,proInfo,filePath,filename);

        if("rest".equals(servInterfaceInfo.getServiceType())){
            restResponse = runScript(getScript( type, servType, appName, appHostName, appNameSpace,
                    ansibleBasepath+"restdevV1.yml",
                    ansibleBasepath+"restdevV2.yml",hosturl,restGit));
        }else if("db".equals(servInterfaceInfo.getServiceType())){
            String componentInfo= servCamelInfo.getComponentInfo();
            String  componetConfig="componetConfig.properties";
            createConfig(servType,appName,componentInfo,filePath,componetConfig);
            restResponse = runScript(getScript( type, servType, appName, appHostName, appNameSpace,
                    ansibleBasepath+"dbdevV1.yml",
                    ansibleBasepath+"dbdevV2.yml",hosturl,dbGit));
        }else if("soap".equals(servInterfaceInfo.getServiceType())){
            String componentInfo= servCamelInfo.getCxfInfo();
            String  componetConfig="cxfEndpointConfig.xml";
            createConfig(servType,appName,componentInfo,filePath,componetConfig);
            restResponse = runScript(getScript( type, servType, appName, appHostName, appNameSpace,
                    ansibleBasepath+"soapdevV1.yml"
                    ,ansibleBasepath+"soapdevV1.yml",hosturl,wsdlGit));
        }else{
            restResponse = RestResponse.failure("服务类型不在指定范围内");
        }

        //根据是否调用成功更新发布状态
        Boolean isSuccess = restResponse.isSuccess();
        if(isSuccess){
            if("add".equalsIgnoreCase(type)){
                serviceInfo.setDeploymentStatus(ServiceInfo.deployed);
            }else if("edit".equalsIgnoreCase(type)){
                serviceInfo.setDeploymentStatus(ServiceInfo.updateDeployed);
            }
            serviceInfo.setDeploymentTime(new Date());
            serviceInfoService.updateById(serviceInfo);
        }

        return restResponse;
    }





    //获取 执行脚本
    public String[] getScript(String type,String servType,String appName,
                                  String appHostName,String appNameSpace ,String templaceFileOne,
                              String templaceFileTwo,String hosturl,String gitUrl){

        servType=servType.equals("db")?"dbTemplate":(servType.equals("soap")?"WSDLTemplate":"RestTemplate");

        if(type.equals("add")){
            String[] ansible_run =
                    {"ansible-playbook", templaceFileOne,
                            "--extra-vars",
                            "{'data':'"+servType+"'," +
                                    " 'branch':'"+appName+"', " +
                                    " 'appname':'"+appName+"'," +
                                    " 'url':'"+appHostName+"'," +
                                    " 'namespace':'"+appNameSpace+"','hosturl':'"+hosturl+"'" +
                                     ",'giturl':'"+gitUrl+"' }"};

            return  ansible_run;

        }else{
            String[] ansible_run =
                    {"ansible-playbook", templaceFileTwo,
                            "--extra-vars",
                            "{'data':'"+servType+"'," +
                                    " 'branch':'"+appName+"', " +
                                    " 'appname':'"+appName+"'," +
                                    " 'url':'"+appHostName+"'," +
                                    " 'namespace':'"+appNameSpace+"','hosturl':'"+hosturl+"'" +
                                    ",'giturl':'"+gitUrl+"' }"};

            return  ansible_run;
        }
    }




    //创建配置文件
    public boolean createConfig(String servType,String appName,String proInfo,
                             String filePath,String filename) throws IOException {

        //将字符串写到指定的目录下
        File file = new File(filePath);
        //如果文件夹不存在  就创建一个空的文件夹
        if (!file.exists()) {
            file.mkdirs();
        }

        File file2 = new File(filePath, filename);
        //如果文件不存在  就创建一个空的文件
        if (!file2.exists()) {
            try {
                file2.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        FileOutputStream fos = new FileOutputStream(filePath + "/" + filename);
        byte[] bytes = proInfo.getBytes();
        //将byte数组中的所有数据全部写入
        fos.write(bytes);
        //关闭流
        fos.close();

        return true;
    }

    //执行脚本并输出脚本日志
    public RestResponse runScript(String[] ansible_run){
        try
        {
            Runtime runtime = Runtime.getRuntime();
            final Process process = runtime.exec(ansible_run);

            StreamHandler errorStreamHandler = new StreamHandler(process.getErrorStream(), "ERROR");
            errorStreamHandler.start();
            StreamHandler outputStreamHandler = new StreamHandler(process.getInputStream(), "STDOUT");
            outputStreamHandler.start();

        }catch (IOException ex)
        {
            return RestResponse.failure(ex.getMessage());
        }

        return  RestResponse.success();
    }


}
