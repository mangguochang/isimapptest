package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: ServiceApplicationInfo
 * @Description: 服务应用信息
 * @Author: lolipopjy
 * @Date: 2019-11-01 14:12
 */
@TableName("service_application_info")
public class ServiceApplicationInfo extends DataEntity<ServiceApplicationInfo> {

    private static final long serialVersionUID = 1L;

    /**
     * 应用名称
     */
    @TableField("application_name")
    private String applicationName;

    /**
     * 应用域名
     */
    @TableField("application_hostname")
    private String applicationHostName;

    /**
     * 项目空间
     */
    @TableField("namespace")
    private String namespace;

    /**
     * 容器运行内存
     */
    @TableField("memory_limit")
    private Integer memoryLimit;

    /**
     * 应用状态
     */
    @TableField("status")
    private String status;

    /**
     * 所属服务
     */
    @TableField("service_id")
    private String serviceId;

    public String getApplicationName() {
        return applicationName;
    }

    public void setApplicationName(String applicationName) {
        this.applicationName = applicationName;
    }

    public String getApplicationHostName() {
        return applicationHostName;
    }

    public void setApplicationHostName(String applicationHostName) {
        this.applicationHostName = applicationHostName;
    }

    public String getNamespace() {
        return namespace;
    }

    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }

    public Integer getMemoryLimit() {
        return memoryLimit;
    }

    public void setMemoryLimit(Integer memoryLimit) {
        this.memoryLimit = memoryLimit;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }
}
