package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: ServiceRequestParams
 * @Description: 服务基本信息-请求参数
 * @Author: lolipopjy
 * @Date: 2019-10-22 15:54
 */
@TableName("service_request_params")
public class ServiceRequestParams extends DataEntity<ServiceRequestParams> {

    private static final long serialVersionUID = 1L;

    /**
     * 所属服务
     */
    @TableField("service_id")
    private String serviceId;

    /**
     * 参数类型
     */
    @TableField("param_type")
    private String paramType;

    /**
     * 参数名称
     */
    @TableField("param_name")
    private String paramName;

    /**
     * 是否必须
     */
    @TableField("required")
    private String required;

    /**
     * 类型
     */
    @TableField("type")
    private String type;

    /**
     * 描述
     */
    @TableField("description")
    private String description;

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getParamType() {
        return paramType;
    }

    public void setParamType(String paramType) {
        this.paramType = paramType;
    }

    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName;
    }

    public String getRequired() {
        return required;
    }

    public void setRequired(String required) {
        this.required = required;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

