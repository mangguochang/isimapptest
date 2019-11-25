package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: ServiceCamelInfo
 * @Description: camel配置信息
 * @Author: lolipopjy
 * @Date: 2019-10-31 16:38
 */
@TableName("service_camel_info")
public class ServiceCamelInfo extends DataEntity<ServiceCamelInfo> {

    private static final long serialVersionUID = 1L;

    /**
     * camel application.properties配置信息
     */
    @TableField("properties_info")
    private String propertiesInfo;

    /**
     * camel componetConfig.properties配置信息
     */
    @TableField("component_info")
    private String componentInfo;

    /**
     * camel cxfEndpointConfig.xml配置信息
     */
    @TableField("cxf_info")
    private String cxfInfo;

    /**
     * 所属服务
     */
    @TableField("service_id")
    private String serviceId;

    /**
     * camel配置文件类型
     */
    @TableField("properties_type")
    private String propertiesType;


    public String getPropertiesInfo() {
        return propertiesInfo;
    }

    public void setPropertiesInfo(String propertiesInfo) {
        this.propertiesInfo = propertiesInfo;
    }

    public String getComponentInfo() {
        return componentInfo;
    }

    public void setComponentInfo(String componentInfo) {
        this.componentInfo = componentInfo;
    }

    public String getCxfInfo() {
        return cxfInfo;
    }

    public void setCxfInfo(String cxfInfo) {
        this.cxfInfo = cxfInfo;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getPropertiesType() {
        return propertiesType;
    }

    public void setPropertiesType(String propertiesType) {
        this.propertiesType = propertiesType;
    }
}
