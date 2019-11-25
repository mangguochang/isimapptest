package com.hzot.isim.entity.system;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.FieldStrategy;
import com.hzot.isim.base.DataEntity;

/**
 * <p>
 * 定时任务
 * </p>
 *
 * @author system_user
 * @since 2018-01-24
 */
@TableName("quartz_task")
public class QuartzTask extends DataEntity<QuartzTask> {

    private static final long serialVersionUID = 1L;

	/**
	 * 任务调度参数key
	 */
    @TableField(exist = false)
	public static final String JOB_PARAM_KEY = "JOB_PARAM_KEY";
    /**
     * 任务名称
     */
	private String name;
    /**
     * 任务表达式
     */
	private String cron;
    /**
     * 执行的类
     */
	@TableField("target_bean")
	private String targetBean;
    /**
     * 执行方法
     */
	@TableField("trget_method")
	private String trgetMethod;
    /**
     * 执行参数
     */
	private String params;
    /**
     * 任务状态 0:正常  1：暂停
     */
	private Integer status;

	/**
     * 备注
     */
    @TableField(strategy= FieldStrategy.IGNORED)
	private String remarks;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCron() {
		return cron;
	}

	public void setCron(String cron) {
		this.cron = cron;
	}

	public String getTargetBean() {
		return targetBean;
	}

	public void setTargetBean(String targetBean) {
		this.targetBean = targetBean;
	}

	public String getTrgetMethod() {
		return trgetMethod;
	}

	public void setTrgetMethod(String trgetMethod) {
		this.trgetMethod = trgetMethod;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
