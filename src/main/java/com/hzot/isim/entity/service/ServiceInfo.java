package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;
import io.swagger.models.auth.In;

import java.util.Date;

/**
 * @ClassName: ServiceInfo
 * @Description: 服务信息
 * @Author: lolipopjy
 * @Date: 2019-10-22 14:03
 */
@TableName("service_info")
public class ServiceInfo extends DataEntity<ServiceInfo> {

    private static final long serialVersionUID = 1L;

    //发布状态，待发布（待发布审批）
    public static final Integer toBeDeployed = 0;

    //发布状态，拒绝
    public static final Integer reject = -1;

    //发布状态，已发布
    public static final Integer deployed = 1;

    //发布状态，更新发布信息
    public static final Integer updateDeployed = 2;

    /**
     * 服务名称
     */
    @TableField("service_name")
    private String serviceName;

    /**
     * 所属系统
     */
    @TableField("service_system")
    private String serviceSystem;

    /**
     * 所属分类
     */
    @TableField("service_class")
    private String serviceClass;

    /**
     * 所属分类-二级
     */
    @TableField("service_second_class")
    private String serviceSecondClass;

    /**
     * 服务发布状态（0-未发布，1已发布，2更新发布）
     */
    @TableField("deployment_status")
    private Integer deploymentStatus;

    /**
     * 发布时间
     */
    @TableField("deployment_time")
    private Date deploymentTime;

    /**
     * 版本
     */
    @TableField("version")
    private String version;

    /**
     * 功能说明
     */
    @TableField("description")
    private String description;


    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceSystem() {
        return serviceSystem;
    }

    public void setServiceSystem(String serviceSystem) {
        this.serviceSystem = serviceSystem;
    }

    public String getServiceClass() {
        return serviceClass;
    }

    public String getServiceSecondClass() {
        return serviceSecondClass;
    }

    public void setServiceSecondClass(String serviceSecondClass) {
        this.serviceSecondClass = serviceSecondClass;
    }

    public void setServiceClass(String serviceClass) {
        this.serviceClass = serviceClass;
    }

    public Integer getDeploymentStatus() {
        return deploymentStatus;
    }

    public void setDeploymentStatus(Integer deploymentStatus) {
        this.deploymentStatus = deploymentStatus;
    }

    public Date getDeploymentTime() {
        return deploymentTime;
    }

    public void setDeploymentTime(Date deploymentTime) {
        this.deploymentTime = deploymentTime;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
