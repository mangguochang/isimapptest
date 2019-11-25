package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: ServiceInterfaceInfo
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-25 16:38
 */
@TableName("service_interface_info")
public class ServiceInterfaceInfo extends DataEntity<ServiceInterfaceInfo> {

    private static final long serialVersionUID = 1L;

    /**
     * 所属服务
     */
    @TableField("service_id")
    private String serviceId;

    /**
     * 请求方接口ID
     */
    @TableField("request_obj_id")
    private String requestObjId;

    /**
     * 业务场景描述
     */
    @TableField("description")
    private String description;

    /**
     * 服务类型
     */
    @TableField("service_type")
    private String serviceType;

    /**
     * 编辑模式
     */
    @TableField("edit_type")
    private String editType;

    /**
     * 数据库类型
     */
    @TableField("db_type")
    private String dbType;

    /**
     * 数据库地址
     */
    @TableField("db_host")
    private String dbHost;

    /**
     * 数据库操作类型
     */
    @TableField("db_operate_type")
    private String dbOperateType;

    /**
     * SQL语句
     */
    @TableField("sql")
    private String sql;

    /**
     * wsdl路径
     */
    @TableField("wsdl_url")
    private String wsdlUrl;

    /**
     * wsdl方法
     */
    @TableField("wsdl_func")
    private String wsdlFunc;

    /**
     * OpenAPI地址
     */
    @TableField("openapi_url")
    private String openAPIUrl;

    /**
     * OpenAPI方法
     */
    @TableField("openapi_func")
    private String openAPIFunc;

    /**
     * 授权码
     */
    @TableField("access_token")
    private String accessToken;

    /**
     * 标签
     */
    @TableField("tag")
    private String tag;

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getRequestObjId() {
        return requestObjId;
    }

    public void setRequestObjId(String requestObjId) {
        this.requestObjId = requestObjId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getEditType() {
        return editType;
    }

    public void setEditType(String editType) {
        this.editType = editType;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }

    public String getDbHost() {
        return dbHost;
    }

    public void setDbHost(String dbHost) {
        this.dbHost = dbHost;
    }

    public String getDbOperateType() {
        return dbOperateType;
    }

    public void setDbOperateType(String dbOperateType) {
        this.dbOperateType = dbOperateType;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getWsdlUrl() {
        return wsdlUrl;
    }

    public void setWsdlUrl(String wsdlUrl) {
        this.wsdlUrl = wsdlUrl;
    }

    public String getWsdlFunc() {
        return wsdlFunc;
    }

    public void setWsdlFunc(String wsdlFunc) {
        this.wsdlFunc = wsdlFunc;
    }

    public String getOpenAPIUrl() {
        return openAPIUrl;
    }

    public void setOpenAPIUrl(String openAPIUrl) {
        this.openAPIUrl = openAPIUrl;
    }

    public String getOpenAPIFunc() {
        return openAPIFunc;
    }

    public void setOpenAPIFunc(String openAPIFunc) {
        this.openAPIFunc = openAPIFunc;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
