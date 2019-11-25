package com.hzot.isim.entity.VO;

import com.hzot.isim.entity.service.*;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: ServiceInfoVO
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-23 15:13
 */
public class ServiceInfoVO implements Serializable {

    /**
     * 服务基本信息
     */
    private ServiceInfo serviceInfo;

    /**
     * 服务基本信息-请求参数
     */
    private List<ServiceRequestParams> serviceRequestParams;

    /**
     * 服务基本信息-返回参数
     */
    private List<ServiceResponseParams> serviceResponseParams;

    /**
     * 服务-接口基本信息
     */
    private ServiceInterfaceInfo serviceInterfaceInfo;

    /**
     * 服务-应用基本信息
     */
    private ServiceApplicationInfo serviceApplicationInfo;

    /**
     * 服务-接口基本信息
     */
    private ServiceCamelInfo serviceCamelInfo;

    /**
     * 服务-模板配置信息
     */
    private Map<String,Object> templateInfo;






    public ServiceInfo getServiceInfo() {
        return serviceInfo;
    }

    public void setServiceInfo(ServiceInfo serviceInfo) {
        this.serviceInfo = serviceInfo;
    }

    public List<ServiceRequestParams> getServiceRequestParams() {
        return serviceRequestParams;
    }

    public void setServiceRequestParams(List<ServiceRequestParams> serviceRequestParams) {
        this.serviceRequestParams = serviceRequestParams;
    }

    public List<ServiceResponseParams> getServiceResponseParams() {
        return serviceResponseParams;
    }

    public void setServiceResponseParams(List<ServiceResponseParams> serviceResponseParams) {
        this.serviceResponseParams = serviceResponseParams;
    }

    public ServiceInterfaceInfo getServiceInterfaceInfo() {
        return serviceInterfaceInfo;
    }

    public void setServiceInterfaceInfo(ServiceInterfaceInfo serviceInterfaceInfo) {
        this.serviceInterfaceInfo = serviceInterfaceInfo;
    }

    public ServiceApplicationInfo getServiceApplicationInfo() {
        return serviceApplicationInfo;
    }

    public void setServiceApplicationInfo(ServiceApplicationInfo serviceApplicationInfo) {
        this.serviceApplicationInfo = serviceApplicationInfo;
    }

    public ServiceCamelInfo getServiceCamelInfo() {
        return serviceCamelInfo;
    }

    public void setServiceCamelInfo(ServiceCamelInfo serviceCamelInfo) {
        this.serviceCamelInfo = serviceCamelInfo;
    }

    public Map<String, Object> getTemplateInfo() {
        return templateInfo;
    }

    public void setTemplateInfo(Map<String, Object> templateInfo) {
        this.templateInfo = templateInfo;
    }
}
