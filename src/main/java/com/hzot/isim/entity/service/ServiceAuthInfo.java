package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

import java.util.Date;

/**
 * @ClassName: ServiceAuthInfo
 * @Description: 服务使申请授权表
 * @Author: lolipopjy
 * @Date: 2019-11-12 17:14
 */
@TableName("service_auth_info")
public class ServiceAuthInfo extends DataEntity<ServiceInfo> {

    private static final long serialVersionUID = 1L;

    public static final Integer approved = 1;
    public static final Integer reject = -1;
    public static final Integer cancel = -2;
    public static final Integer apply = 0;

    /**
     * 服务Id
     */
    @TableField("service_id")
    private String serviceId;

    /**
     * 授权码
     */
    @TableField("authorization_code")
    private String authorizationCode;

    /**
     * 授权时间
     */
    @TableField("authorization_time")
    private Date authorizationTime;

    /**
     * 申请状态（0：待审批，1：通过，-1：拒绝）
     */
    @TableField("auth_status")
    private Integer authStatus;

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getAuthorizationCode() {
        return authorizationCode;
    }

    public void setAuthorizationCode(String authorizationCode) {
        this.authorizationCode = authorizationCode;
    }

    public Date getAuthorizationTime() {
        return authorizationTime;
    }

    public void setAuthorizationTime(Date authorizationTime) {
        this.authorizationTime = authorizationTime;
    }

    public Integer getAuthStatus() {
        return authStatus;
    }

    public void setAuthStatus(Integer authStatus) {
        this.authStatus = authStatus;
    }
}
