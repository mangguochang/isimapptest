package com.hzot.isim.service.impl.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.dao.service.ServiceInterfaceInfoDao;
import com.hzot.isim.entity.connector.DatabaseConnector;
import com.hzot.isim.entity.VO.ServiceInfoVO;
import com.hzot.isim.entity.service.*;
import com.hzot.isim.service.connector.DatabaseConnectorService;
import com.hzot.isim.service.service.*;
import com.hzot.isim.util.DBConn.DoConnection;
import com.hzot.isim.util.properties.SafeProperties;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @ClassName: ServiceInterfaceInfoServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-25 16:53
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceInterfaceInfoServiceImpl extends ServiceImpl<ServiceInterfaceInfoDao, ServiceInterfaceInfo> implements ServiceInterfaceInfoService {

    //应用域名后缀
    @Value("${ansibleTemplate.hostSuffix}")
    private String  hostSuffix;

    @Autowired
    private ServiceInfoService serviceInfoService;

    @Autowired
    private ServiceRequestParamsService serviceRequestParamsService;

    @Autowired
    private ServiceResponseParamsService serviceResponseParamsService;

    @Autowired
    private ServiceInterfaceInfoService serviceInterfaceInfoService;

    @Autowired
    private DatabaseConnectorService dbConnectorService;

    @Autowired
    private ServiceCamelInfoService serviceCamelInfoService;

    @Autowired
    private ServiceApplicationInfoService serviceApplicationInfoService;

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void saveOrUpdate(ServiceInfoVO serviceInfoVO) throws Exception {
        if(serviceInfoVO==null){
            throw new Exception("该服务不存在");
        }else{
            ServiceInfo info = serviceInfoVO.getServiceInfo();
            String serviceId = info.getId();
            ServiceApplicationInfo serviceApplicationInfo = serviceInfoVO.getServiceApplicationInfo();
            Boolean appNameUnique = serviceApplicationInfoService.isExistsSameApplicationName(serviceId,serviceApplicationInfo.getApplicationName());
            //校验应用名称是否唯一
            if(appNameUnique){
                throw new Exception("应用基本信息-应用名称已存在");
            }
            //校验应用域名是否唯一
            Boolean hostNameUnique = serviceApplicationInfoService.isExistsSameApplicationHostName(serviceId,serviceApplicationInfo.getApplicationHostName());
            if(hostNameUnique){
                throw new Exception("应用基本信息-应用域名已存在");
            }
            //服务基本信息
            ServiceInfo serviceInfo = serviceInfoVO.getServiceInfo();
            ServiceInfo newInfo = serviceInfoService.insertOrUpdateById(serviceInfo);
            serviceId = newInfo.getId();

            //服务基本信息-请求参数
            List<ServiceRequestParams> serviceRequestParams = serviceInfoVO.getServiceRequestParams();
            for(ServiceRequestParams params : serviceRequestParams){
                if(StringUtils.isBlank(params.getId())){
                    params.setId(EntityIdPrefix.SERVICE_INFO_REQ+ UUID.randomUUID().toString());
                }
                params.setServiceId(serviceId);
                serviceRequestParamsService.insertOrUpdate(params);
            }

            //服务基本信息-返回信息
            List<ServiceResponseParams> serviceResponseParams = serviceInfoVO.getServiceResponseParams();
            for(ServiceResponseParams params : serviceResponseParams){
                if(StringUtils.isBlank(params.getId())){
                    params.setId(EntityIdPrefix.SERVICE_INFO_RESP+ UUID.randomUUID().toString());
                }
                params.setServiceId(serviceId);
                serviceResponseParamsService.insertOrUpdate(params);
            }

            //服务-接口基本信息
            ServiceInterfaceInfo serviceInterfaceInfo = serviceInfoVO.getServiceInterfaceInfo();
            ServiceInterfaceInfo oldServiceInterfaceInfo = serviceInterfaceInfoService.getByServiceId(serviceId);
            serviceInterfaceInfo.setServiceId(serviceId);

            //服务-应用基本信息
            serviceApplicationInfo.setServiceId(serviceId);

            //服务camel配置信息
            ServiceCamelInfo serviceCamelInfo = serviceInfoVO.getServiceCamelInfo();
            String serviceType = serviceInterfaceInfo.getServiceType();
            serviceCamelInfo.setPropertiesType(serviceType);
            //改变服务类型，清除properties等配置文件信息
            Boolean loadDefalut = false;
            if(oldServiceInterfaceInfo==null||(!oldServiceInterfaceInfo.getServiceType().equalsIgnoreCase(serviceInterfaceInfo.getServiceType()))){
                loadDefalut = true;
            }

            Map<String,Object> templateInfo = serviceInfoVO.getTemplateInfo();
            //设置应用域名
            String applicationHostName = serviceApplicationInfo.getApplicationHostName();
            templateInfo.put("camel.rest.host",applicationHostName==null?"":applicationHostName+hostSuffix);

            //如果为表单模式，则转为properties配置模式
            if("form".equalsIgnoreCase(serviceInterfaceInfo.getEditType())){
                //模板配置信息
                if("DB".equalsIgnoreCase(serviceType)){
                    //设置application.properties service.action 数据库操作类型
                    templateInfo.put("service.action",serviceInterfaceInfo.getDbOperateType());
                    String sysDatabaseId = (String) templateInfo.get("dbHost");
                    DatabaseConnector connector = dbConnectorService.getDatabseInfoById(sysDatabaseId);
                    String jdbcUrl = "";
                    if(connector!=null){
                        String dbtype = connector.getDbType();
                        String linkType = connector.getsType();
                        String host = connector.getHost();
                        Integer port = connector.getPort();
                        String dbname = connector.getDbName();
                        //修改application.properties
                        templateInfo.put("jdbc.url", DoConnection.getJDBCUrl(dbtype,linkType,host,port,dbname));
                        templateInfo.put("jdbc.username",connector.getUserName());
                        templateInfo.put("jdbc.password",connector.getPassword());

                        //修改componetConfig.properties
                        if("procedure".equalsIgnoreCase(serviceInterfaceInfo.getDbOperateType())){
                            //存储过程 sql-stored:simonupdate(VARCHAR ${headers.num1})
                            templateInfo.put("service.app.sql","sql-stored:"+serviceInterfaceInfo.getSql());
                        }else{
                            templateInfo.put("service.app.sql","sql:"+serviceInterfaceInfo.getSql());
                        }
                        String componentString = serviceCamelInfoService.replaceComponentPropeties(serviceId,templateInfo,loadDefalut);
                        serviceCamelInfo.setComponentInfo(componentString);
                    }
                }else if("SOAP".equalsIgnoreCase(serviceType)){
                    String componentString = serviceCamelInfoService.replaceCxfConfig(serviceId,templateInfo,loadDefalut);
                    serviceCamelInfo.setCxfInfo(componentString);
                }else if("REST".equalsIgnoreCase(serviceType)){
                }
                //更新application.properties配置信息
                String properties =  serviceCamelInfoService.replaceApplicationPropeties(serviceId,serviceType,templateInfo,loadDefalut);
                serviceCamelInfo.setPropertiesInfo(properties);
            }

            if("DB".equalsIgnoreCase(serviceType)){
                //清空无关数据
                serviceInterfaceInfo.setOpenAPIUrl("");
                serviceInterfaceInfo.setOpenAPIFunc("");
                serviceInterfaceInfo.setWsdlUrl("");
                serviceInterfaceInfo.setWsdlFunc("");
                serviceCamelInfo.setCxfInfo(null);
            }else if("SOAP".equalsIgnoreCase(serviceType)){
                //wsdl清空无关数据
                serviceInterfaceInfo.setOpenAPIUrl("");
                serviceInterfaceInfo.setOpenAPIFunc("");
                serviceInterfaceInfo.setDbHost("");
                serviceInterfaceInfo.setDbOperateType("");
                serviceInterfaceInfo.setDbType("");
                serviceInterfaceInfo.setSql("");
                serviceCamelInfo.setComponentInfo(null);
            }else if("REST".equalsIgnoreCase(serviceType)){
                //openapi清空无关数据
                serviceInterfaceInfo.setWsdlUrl("");
                serviceInterfaceInfo.setWsdlFunc("");
                serviceInterfaceInfo.setDbHost("");
                serviceInterfaceInfo.setDbOperateType("");
                serviceInterfaceInfo.setDbType("");
                serviceInterfaceInfo.setSql("");
                serviceCamelInfo.setCxfInfo(null);
                serviceCamelInfo.setComponentInfo(null);
            }else{
                //清空无关数据
                serviceCamelInfo.setPropertiesInfo(null);
                serviceCamelInfo.setCxfInfo(null);
                serviceCamelInfo.setComponentInfo(null);
            }
            serviceCamelInfo.setServiceId(serviceId);

            //保存或更新
            serviceInterfaceInfoService.insertOrUpdateById(serviceInterfaceInfo);
            serviceCamelInfoService.insertOrUpdateById(serviceCamelInfo);
            serviceApplicationInfoService.insertOrUpdateById(serviceApplicationInfo);

        }
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public ServiceInterfaceInfo insertOrUpdateById(ServiceInterfaceInfo info) {
        ServiceInterfaceInfo newInfo = null;
        String id = "";
        ServiceInterfaceInfo oldServiceInterfaceInfo = this.getByServiceId(info.getServiceId());
        if(oldServiceInterfaceInfo==null){
            id = EntityIdPrefix.SERVICE_ITF_INFO+ UUID.randomUUID().toString();
            info.setId(id);
            this.insert(info);
            newInfo = info;
        }else{
            //不更新主键
            info.setId(oldServiceInterfaceInfo.getId());
            //不更新所属服务
            info.setServiceId(oldServiceInterfaceInfo.getServiceId());
            //不更新创建人
            info.setCreateId(oldServiceInterfaceInfo.getCreateId());
            //不更新创建时间
            info.setCreateTime(oldServiceInterfaceInfo.getCreateTime());
            this.updateById(info);
            newInfo = info;
        }

        return newInfo;
    }

    @Override
    public ServiceInterfaceInfo getByServiceId(String serviceId) {
        EntityWrapper<ServiceInterfaceInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("service_id",serviceId);
        List<ServiceInterfaceInfo> list = this.selectList(wrapper);
        if(list.size()>0){
            return list.get(0);
        }else{
            return null;
        }
    }

    @Override
    public Map<String,Object> getServiceInfoById(String serviceId) throws IOException {
        Map<String,Object> data = new HashMap<>();
        ServiceInfoVO vo = new ServiceInfoVO();
        //获取服务基本信息
        ServiceInfo serviceInfo = serviceInfoService.selectById(serviceId);
        vo.setServiceInfo(serviceInfo);
        //获取服务-接口基本信息
        ServiceInterfaceInfo interfaceInfo = serviceInterfaceInfoService.getByServiceId(serviceId);
        vo.setServiceInterfaceInfo(interfaceInfo);
        //获取服务-应用基本信息
        ServiceApplicationInfo applicationInfo = serviceApplicationInfoService.getByServiceId(serviceId);
        vo.setServiceApplicationInfo(applicationInfo);

        data.put("serviceInfo", JSON.toJSON(serviceInfo));
        Map<String,Object> serviceInterfaceInfo = JSON.parseObject(JSON.toJSONString(interfaceInfo),Map.class);

        SafeProperties properties = new SafeProperties();

        //加载Camel配置信息
        ServiceCamelInfo camelInfo =  serviceCamelInfoService.getByServiceId(serviceId);
        String serviceType = interfaceInfo.getServiceType();
        String propertiesInfo = camelInfo.getPropertiesInfo();
        InputStream is = new ByteArrayInputStream(propertiesInfo.getBytes());
        properties.load(is);
        Map<String, Object> propertiesMap = properties.getMap();
        //防止替换serviceInterfaceInfo表单字段
        for(String infoKey : serviceInterfaceInfo.keySet()){
            if(propertiesMap.containsKey(infoKey)){
                propertiesMap.remove(infoKey);
            }
        }
        serviceInterfaceInfo.putAll(propertiesMap);

        data.put("serviceInterfaceInfo",serviceInterfaceInfo);
        data.put("serviceApplicationInfo",JSON.toJSON(applicationInfo));

        return data;
    }
}
