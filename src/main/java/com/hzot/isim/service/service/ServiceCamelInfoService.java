package com.hzot.isim.service.service;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.service.ServiceCamelInfo;

import java.util.Map;

public interface ServiceCamelInfoService extends IService<ServiceCamelInfo> {

    ServiceCamelInfo insertOrUpdateById(ServiceCamelInfo info);

    ServiceCamelInfo getByServiceId(String serviceId);

    String getCamelProperties(String serviceId,String serviceType);

    String getCamelComponentProperties(String serviceId);

    String getCamelCxfConfigPropertiesInfo(String serviceId);

    String getDefaultCamelPropertiesInfo(String serviceType);

    String getDefaultCamelComponentPropertiesInfo();

    String getDefaultCamelCxfConfigPropertiesInfo();

    String replaceApplicationPropeties(String serviceId,String serviceType,Map<String, Object> templateInfo,Boolean loadDefalut);

    String replaceComponentPropeties(String serviceId,Map<String, Object> templateInfo,Boolean loadDefalut);

    String replaceCxfConfig(String serviceId,Map<String, Object> templateInfo,Boolean loadDefalut);

}
