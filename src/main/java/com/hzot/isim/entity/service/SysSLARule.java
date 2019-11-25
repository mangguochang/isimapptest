package com.hzot.isim.entity.service;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: SysSLARule
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-16 13:48
 */
@TableName("sys_sla_rule")
public class SysSLARule  extends DataEntity<SysSLARule> {

    private static final long serialVersionUID = 1L;


    /**
     * 规则名称
     */
    @TableField("rule_name")
    private String ruleName;

    /**
     * 失败重试次数
     */
    @TableField("fail_retry_time")
    private String failRetryTime;

    /**
     * 链接超时时间
     */
    @TableField("link_over_time")
    private String linkOverTime;

    /**
     * 请求超时时间
     */
    @TableField("request_over_time")
    private String requestOverTime;

    /**
     * 响应超时时间
     */
    @TableField("response_over_time")
    private String responseOverTime;

    public String getRuleName() {
        return ruleName;
    }

    public void setRuleName(String ruleName) {
        this.ruleName = ruleName;
    }

    public String getFailRetryTime() {
        return failRetryTime;
    }

    public void setFailRetryTime(String failRetryTime) {
        this.failRetryTime = failRetryTime;
    }

    public String getLinkOverTime() {
        return linkOverTime;
    }

    public void setLinkOverTime(String linkOverTime) {
        this.linkOverTime = linkOverTime;
    }

    public String getRequestOverTime() {
        return requestOverTime;
    }

    public void setRequestOverTime(String requestOverTime) {
        this.requestOverTime = requestOverTime;
    }

    public String getResponseOverTime() {
        return responseOverTime;
    }

    public void setResponseOverTime(String responseOverTime) {
        this.responseOverTime = responseOverTime;
    }
}
