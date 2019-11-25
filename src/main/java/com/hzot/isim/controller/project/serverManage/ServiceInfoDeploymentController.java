package com.hzot.isim.controller.project.serverManage;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.entity.VO.ServiceInfoVO;
import com.hzot.isim.entity.service.ServiceApplicationInfo;
import com.hzot.isim.entity.service.ServiceCamelInfo;
import com.hzot.isim.entity.service.ServiceInfo;
import com.hzot.isim.entity.service.ServiceInterfaceInfo;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import com.hzot.isim.util.http.HttpUtil;
import com.hzot.isim.util.properties.SafeProperties;
import com.hzot.isim.util.swagger.SwaggerUtil;
import com.hzot.isim.util.wsdl.WSDLUtil;
import com.hzot.isim.util.wsdl.WebServiceClient;
import org.apache.commons.lang3.StringUtils;
import org.reficio.ws.builder.core.Wsdl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.wsdl.Definition;
import javax.wsdl.Service;
import javax.wsdl.factory.WSDLFactory;
import javax.wsdl.xml.WSDLReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: ServiceInterfacePublicController
 * @Description: 服务接口发布
 * @Author: lolipopjy
 * @Date: 2019-10-22 10:56
 */
@RequestMapping("/service/deployment")
@Controller
public class ServiceInfoDeploymentController extends ServiceBaseController {

    @GetMapping("list")
    public String list(Model model)  {
        getSelectOptionList(model);
        return "service/deployment/list";
    }

    @PostMapping("list")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "1")Integer pageSize,
                         @RequestParam(value = "pageNumber",defaultValue = "10")Integer pageNumber,
                         String serviceName,ServletRequest request){
        Map filter = WebUtils.getParametersStartingWith(request, "s_");
        EntityWrapper<ServiceInfo> entityWrapper = new EntityWrapper<>();
        //获取待审批及已经审批过的数据
        entityWrapper.isNotNull("deployment_status");
        PageList pageList = baseServiceInfoList(entityWrapper,filter,new Page<>(pageNumber,pageSize));
        return  RestResponse.success().setData(pageList);
    }

    //后台多个对象接收
    @PostMapping("saveOrUpdate")
    @ResponseBody
    public RestResponse saveOrUpdate(@RequestBody(required = true) ServiceInfoVO serviceInfoVO) {
        RestResponse response = null;
        try {
            serviceInterfaceInfoService.saveOrUpdate(serviceInfoVO);
            response = RestResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            response = RestResponse.failure(e.getMessage());
        }
        return response;
    }


    @GetMapping("edit")
    @ResponseBody
    public RestResponse edit(String id){
        Map<String,Object> data = new HashMap<>();
        try {
            data = serviceInterfaceInfoService.getServiceInfoById(id);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return RestResponse.success().setData(data);
    }

    /**
    *@Description: 获取SwaggerURL下的方法
    *@Param: [openAPIUrl, request, response]
    *@Author: lolipopjy
    *@date: 2019/10/28 19:11
    *@return:
    */
    @PostMapping("getFuncSwagger")
    @ResponseBody
    public RestResponse getFuncSwagger(String openAPIUrl, HttpServletRequest request, HttpServletResponse response) throws Exception{
        if(!openAPIUrl.matches("^((https|http|ftp|rtsp|mms)?:\\/\\/)[^\\s]+")){

        }
        Map<String,Object> result = new HashMap<>();
        try{
            List<Map<String,Object>> data = null;
            data = SwaggerUtil.getSwaggerMsg(openAPIUrl);
            result.put("status", 1);
            result.put("data", data);
        }catch(Exception e){
            result.put("status", 0);
            result.put("data", "找不到swagger");
        }finally {
        }
        return RestResponse.success().setData(result);
    }

    /**
    *@Description: 获取WsdlURL下的方法
    *@Param: [wsdlPath, request, response]
    *@Author: lolipopjy
    *@date: 2019/10/28 19:11
    *@return:
    */
    @PostMapping("getFuncWsdl")
    @ResponseBody
    public RestResponse getFuncWsdl(String wsdlUrl, String wsdlUsername,String wsdlPassword,HttpServletRequest request,HttpServletResponse response) throws Exception{
        if(!wsdlUrl.matches("^((https|http|ftp|rtsp|mms)?:\\/\\/)[^\\s]+")){

        }
        Map<String,Object> result = new HashMap<>();
        try{
            if(!"".equals(wsdlUsername) && !"".equals(wsdlPassword)){
                wsdlUrl = WSDLUtil.getWsdlURL(wsdlUrl, wsdlUsername, wsdlPassword);
            }
            List<Map<String,List<Map<String,String>>>> data = null;


            data = WSDLUtil.getWsdlMsg(wsdlUrl);
            result.put("status", 1);
            result.put("data", data);
        }catch(Exception e){
            result.put("status", 0);
            result.put("data", "找不到wsdl");
            e.printStackTrace();
        }finally {
            if(!"".equals(wsdlUsername) && !"".equals(wsdlPassword)){
                WSDLUtil.deleteWsdlFile(wsdlUrl);
            }
        }
        return RestResponse.success().setData(result);
    }


    /**
     * 测试openAPI报文
     * @return
     */
    @PostMapping("testMessage")
    @ResponseBody
    public RestResponse testMessage(String requestBody, String reqTestUrl, String method, String requestFields,HttpServletRequest request, HttpServletResponse response){
        String result = "";
        try {
            if("POST".equalsIgnoreCase(method)){
                result = HttpUtil.doPost(reqTestUrl,requestFields,requestBody);
            }else{
                result = HttpUtil.doGet(reqTestUrl,requestFields);
            }
        } catch (Exception e) {
            result = e.getLocalizedMessage();
        }
        return RestResponse.success().setData(result);
    }

    /**
     * 测试WSDL报文
     * @return
     */
    @PostMapping("testWSDLMessage")
    @ResponseBody
    public RestResponse testWSDLMessage(String wsdlUrl,String portName,String elementName,String params){
        String result = "";

        Wsdl wsdl = Wsdl.parse(wsdlUrl);
        String serviceName = "";
        String nameSpace = "";
        try {
            WSDLFactory wsdlFactory = WSDLFactory.newInstance();
            WSDLReader reader = wsdlFactory.newWSDLReader();
            Definition def = reader.readWSDL(null,wsdlUrl);
            nameSpace = def.getTargetNamespace();
            Map services = def.getServices();
            if (services != null) {
                Iterator svcIter = services.values().iterator();
                Service service = (Service) svcIter.next();
                serviceName = service.getQName().getLocalPart();
            }
        }catch (Exception e){

        }
        String methodName = "";
        if(StringUtils.isNotBlank(elementName)){
            String ele[] = elementName.split(":");
            if(ele!=null&&ele.length>0){
                methodName = ele[1];
            }
        }
        WebServiceClient ws = new WebServiceClient(nameSpace,wsdlUrl,serviceName,portName,methodName,"");

        Map inMsg = new HashMap<String, String>();

        if(StringUtils.isNotBlank(params)){
            inMsg = (Map)JSON.parse(params);
        }
        try {
            result = ws.sendMessage(inMsg);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return RestResponse.success().setData(result);

    }

    @PostMapping("reject")
    @ResponseBody
    public RestResponse reject(String serviceId){
        RestResponse response = null;
        try {
            serviceInfoService.reject(serviceId);
            response = RestResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            response = RestResponse.failure(e.getMessage());
        }
        return response;
    }

}
