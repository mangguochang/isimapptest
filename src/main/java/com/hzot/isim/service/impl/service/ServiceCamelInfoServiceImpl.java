package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.dao.service.ServiceCamelInfoDao;
import com.hzot.isim.entity.service.ServiceCamelInfo;
import com.hzot.isim.service.service.ServiceCamelInfoService;
import com.hzot.isim.util.properties.SafeProperties;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.dom4j.*;
import org.dom4j.io.SAXReader;
import org.dom4j.tree.DefaultElement;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.ResourceUtils;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @ClassName: ServiceCamelInfoServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-31 16:44
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceCamelInfoServiceImpl extends ServiceImpl<ServiceCamelInfoDao, ServiceCamelInfo> implements ServiceCamelInfoService {

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public ServiceCamelInfo insertOrUpdateById(ServiceCamelInfo info) {
        ServiceCamelInfo newInfo = null;
        String id = "";
        ServiceCamelInfo oldServiceCamelInfo = this.getByServiceId(info.getServiceId());
        if(oldServiceCamelInfo==null){
            id = EntityIdPrefix.SERVICE_CAMEL_INFO+ UUID.randomUUID().toString();
            info.setId(id);
            this.insert(info);
            newInfo = info;
        }else{
            //不更新主键
            info.setId(oldServiceCamelInfo.getId());
            //不更新所属服务
            info.setServiceId(oldServiceCamelInfo.getServiceId());
            //不更新创建人
            info.setCreateId(oldServiceCamelInfo.getCreateId());
            //不更新创建时间
            info.setCreateTime(oldServiceCamelInfo.getCreateTime());
            this.updateById(info);
            newInfo = info;
        }

        return newInfo;
    }

    @Override
    public ServiceCamelInfo getByServiceId(String serviceId) {
        EntityWrapper<ServiceCamelInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("service_id",serviceId);
        List<ServiceCamelInfo> list = this.selectList(wrapper);
        if(list.size()>0){
            return list.get(0);
        }else{
            return null;
        }
    }

    @Override
    public String getCamelProperties(String serviceId, String serviceType) {
        String content = "";
        if(StringUtils.isNotBlank(serviceId)){
            ServiceCamelInfo serviceCamelInfo = getByServiceId(serviceId);
            //获取对应类型的properties数据
            if(serviceCamelInfo!=null&&serviceType!=null&&serviceType.equalsIgnoreCase(serviceCamelInfo.getPropertiesType())){
                content = serviceCamelInfo.getPropertiesInfo();
            }else{
                content = getDefaultCamelPropertiesInfo(serviceType);
            }
        }else{
            content = getDefaultCamelPropertiesInfo(serviceType);
        }
        return content==null?"":content;
    }

    @Override
    public String getCamelComponentProperties(String serviceId) {
        String content = "";
        if(StringUtils.isNotBlank(serviceId)){
            ServiceCamelInfo serviceCamelInfo = getByServiceId(serviceId);
            if(serviceCamelInfo!=null){
                content = serviceCamelInfo.getComponentInfo();
            }else{
                content = getDefaultCamelComponentPropertiesInfo();
            }
        }else{
            content = getDefaultCamelComponentPropertiesInfo();
        }
        return content==null?"":content;
    }

    @Override
    public String getCamelCxfConfigPropertiesInfo(String serviceId) {
        String content = "";
        if(StringUtils.isNotBlank(serviceId)){
            ServiceCamelInfo serviceCamelInfo = getByServiceId(serviceId);
            if(serviceCamelInfo!=null){
                content = serviceCamelInfo.getCxfInfo();
            }else{
                content = getDefaultCamelCxfConfigPropertiesInfo();
            }
        }else{
            content = getDefaultCamelCxfConfigPropertiesInfo();
        }
        return content==null?"":content;
    }

    @Override
    public String getDefaultCamelPropertiesInfo(String serviceType) {
        String content = "";
        String resourceLocation = "";
        if("db".equalsIgnoreCase(serviceType)){
            resourceLocation = "camelTemplate/db/application.properties";
        }else if("soap".equalsIgnoreCase(serviceType)){
            resourceLocation = "camelTemplate/soap/application.properties";
        }else if("rest".equalsIgnoreCase(serviceType)){
            resourceLocation = "camelTemplate/rest/application.properties";
        }else{
            return "";
        }
        try {
            ClassPathResource classPathResource = new ClassPathResource(resourceLocation);
            byte[]  byteArray = FileCopyUtils.copyToByteArray(classPathResource.getInputStream());
            content = new String(byteArray);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    @Override
    public String getDefaultCamelComponentPropertiesInfo() {
        String content = "";
        try {
            ClassPathResource classPathResource = new ClassPathResource("camelTemplate/db/componetConfig.properties");
            byte[]  byteArray = FileCopyUtils.copyToByteArray(classPathResource.getInputStream());
            content = new String(byteArray);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;

    }

    @Override
    public String getDefaultCamelCxfConfigPropertiesInfo() {
        String content = "";
        try {
            ClassPathResource classPathResource = new ClassPathResource("camelTemplate/soap/cxfEndpointConfig.xml");
            byte[]  byteArray = FileCopyUtils.copyToByteArray(classPathResource.getInputStream());
            content = new String(byteArray);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    /**
     *@Description: 替换 application.properties
     *@Param: [serviceId, templateInfo]
     *@Author: lolipopjy
     *@date: 2019/11/6 18:28
     *@return:
     */
    @Override
    public String replaceApplicationPropeties(String serviceId,String serviceType,Map<String, Object> templateInfo,Boolean loadDefalut) {
        String propertiesString = "";
        try {
            ServiceCamelInfo camelInfo = getByServiceId(serviceId);
            String propertiesInfo = "";
            //如果为空或者需要加载默认值则获取默认模板
            if(camelInfo==null||loadDefalut||StringUtils.isBlank(camelInfo.getPropertiesInfo())){
                propertiesInfo = getDefaultCamelPropertiesInfo(serviceType);
            }else{
                camelInfo.getPropertiesInfo();
            }
            propertiesString =  replaceProperties(propertiesInfo,templateInfo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return propertiesString;
    }

    /**
    *@Description: 替换DB component.properties
    *@Param: [serviceId, templateInfo]
    *@Author: lolipopjy
    *@date: 2019/11/6 18:28
    *@return:
    */
    @Override
    public String replaceComponentPropeties(String serviceId, Map<String, Object> templateInfo,Boolean loadDefalut) {
        String propertiesString = "";
        try {
            ServiceCamelInfo camelInfo = getByServiceId(serviceId);
            String componentInfo = "";
            //如果为空或者需要加载默认值则获取默认模板
            if(camelInfo==null||loadDefalut|| StringUtils.isBlank(camelInfo.getComponentInfo())){
                ClassPathResource classPathResource = new ClassPathResource("camelTemplate/db/componetConfig.properties");
                byte[]  byteArray = FileCopyUtils.copyToByteArray(classPathResource.getInputStream());
                componentInfo = new String(byteArray);
            }else{
                componentInfo = camelInfo.getComponentInfo();
            }
            propertiesString =  replaceProperties(componentInfo,templateInfo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return propertiesString;
    }

    @Override
    public String replaceCxfConfig(String serviceId, Map<String, Object> templateInfo,Boolean loadDefalut) {
        String xmlString = "";
        try {
            String address = (String) templateInfo.get("camel.wsdl.url");
            String serviceName = (String) templateInfo.get("camel.wsdl.serviceName");
            String endpointName = (String) templateInfo.get("camel.wsdl.endpointName");
            String xmlns_ns1 = (String) templateInfo.get("camel.wsdl.targetNamespace");
            String wsdlUrl = (String) templateInfo.get("wsdlUrl");
            ServiceCamelInfo camelInfo = getByServiceId(serviceId);
            Map<String,Object> map = new HashMap();
            map.put("xsi", "http://www.w3.org/2001/XMLSchema-instance");
            map.put("cxf", "http://camel.apache.org/schema/cxf");
            map.put("xmlns", "http://www.springframework.org/schema/beans");
            SAXReader saxReader = new SAXReader(new DocumentFactory());
            saxReader.getDocumentFactory().setXPathNamespaceURIs(map);
            Document document = null;
            InputStream input = null;
            //如果为空或者需要加载默认值则获取默认模板
            if(camelInfo==null||loadDefalut||StringUtils.isBlank(camelInfo.getCxfInfo())){
                ClassPathResource classPathResource = new ClassPathResource("camelTemplate/soap/cxfEndpointConfig.xml");
                input = classPathResource.getInputStream();
            }else{
                input = new ByteArrayInputStream(camelInfo.getCxfInfo().getBytes());
            }
            document = saxReader.read(input);
            List<DefaultElement> cxfEndpoint = document.selectNodes("/beans//cxf:cxfEndpoint");
            if(cxfEndpoint.size()>0){
                Element element = cxfEndpoint.get(0);
                String namespace_ns1 = "ns1";
                //获取命名空间“ns1”
                Namespace namespace = element.getNamespaceForPrefix(namespace_ns1);
                //删除命名空间
                element.remove(namespace);
                //添加新的命名空间
                element.addNamespace(namespace_ns1,xmlns_ns1);
                Attribute addressA = element.attribute("address");
                Attribute serviceNameA = element.attribute("serviceName");
                Attribute endpointNameA = element.attribute("endpointName");
                addressA.setValue(address);
                serviceNameA.setValue(namespace_ns1+":"+serviceName);
                endpointNameA.setValue(namespace_ns1+":"+endpointName);
            }
            //获取包含wsdlURL的entry节点
            List<DefaultElement> entryWSDLlist = document.selectNodes("//*[@key='wsdlURL']");
            if(entryWSDLlist.size()>0){
                Element element = entryWSDLlist.get(0);
                //修改entry节点的value属性
                Attribute value = element.attribute("value");
                value.setValue(wsdlUrl);
            }
            xmlString = document.asXML();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return xmlString;
    }

    /**
    *@Description: 替换properties配置信息
    *@Param: [propertiesInfo, templateInfo]
    *@Author: lolipopjy
    *@date: 2019/11/6 18:27
    *@return:
    */
    private String replaceProperties(String propertiesInfo ,Map<String, Object> templateInfo){
        String propertiesString = "";
        try {
            SafeProperties properties = new SafeProperties();
            InputStream is = new ByteArrayInputStream(propertiesInfo.getBytes());
            properties.load(is);
            properties.replaceAll(templateInfo);
            OutputStream outputStream = new ByteArrayOutputStream();
            properties.store(outputStream,null);
            propertiesString =  outputStream.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return propertiesString;
    }


}
