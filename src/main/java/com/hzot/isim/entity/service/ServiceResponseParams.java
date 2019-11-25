package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: ServiceResponseParams
 * @Description: 服务基本信息-返回参数
 * @Author: lolipopjy
 * @Date: 2019-10-23 14:19
 */
@TableName("service_response_params")
public class ServiceResponseParams extends DataEntity<ServiceResponseParams> {

    private static final long serialVersionUID = 1L;

    /**
     * 所属服务
     */
    @TableField("service_id")
    private String serviceId;

    /**
     * 参数名称
     */
    @TableField("param_name")
    private String paramName;

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

    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

