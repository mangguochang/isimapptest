package com.hzot.isim.entity.system;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * <p>
 * 任务执行日志
 * </p>
 *
 * @author system_user
 * @since 2018-01-25
 */
@TableName("quartz_task_log")
public class QuartzTaskLog extends DataEntity<QuartzTaskLog> {

    private static final long serialVersionUID = 1L;

    /**
     * 任务ID
     */
	@TableField("job_id")
	private String jobId;
    /**
     * 定时任务名称
     */
	private String name;
    /**
     * 定制任务执行类
     */
	@TableField("target_bean")
	private String targetBean;
    /**
     * 定时任务执行方法
     */
	@TableField("trget_method")
	private String trgetMethod;
    /**
     * 执行参数
     */
	private String params;
    /**
     * 任务状态
     */
	private Integer status;
    /**
     * 异常消息
     */
	private String error;
    /**
     * 执行时间
     */
	private Integer times;

	/**
	 * 删除标记（Y：正常；N：删除；A：审核；）
	 */
	@TableField(value = "del_flag")
	protected Boolean delFlag;

	public String getJobId() {
		return jobId;
	}

	public void setJobId(String jobId) {
		this.jobId = jobId;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}
	public Integer getTimes() {
		return times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	public Boolean getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Boolean delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return "QuartzTaskLog{" +
			", jobId=" + jobId +
			", name=" + name +
			", targetBean=" + targetBean +
			", trgetMethod=" + trgetMethod +
			", params=" + params +
			", status=" + status +
			", error=" + error +
			", times=" + times +
			"}";
	}
}
