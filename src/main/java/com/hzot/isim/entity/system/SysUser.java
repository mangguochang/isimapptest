package com.hzot.isim.entity.system;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.FieldStrategy;
import com.google.common.collect.Sets;
import com.hzot.isim.base.DataEntity;

import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * <p>
 *
 * </p>
 *
 */
@TableName("sys_user")
public class SysUser extends DataEntity<SysUser> {

    private static final long serialVersionUID = 1L;

    /**
     * 登录名
     */
	@TableField("login_name")
	private String loginName;

    /**
     * 昵称
     */
	@TableField(value = "nick_name")
	private String nickName;

    /**
     * 真实姓名
     */
	@TableField(value = "real_name")
	private String realName;

    /**
     * 密码
     */
	private String password;
    /**
     * shiro加密盐
     */
	private String salt;
    /**
     * 手机号码
     */
	@TableField(value = "mobile_num")
	private String mobileNum;

    /**
     * 邮箱地址
     */
	@TableField(value = "email")
	private String email;

    /**
     * 性别
     */
	@TableField(value = "sex")
	private String sex;

    /**
     * 生日
     */
	@TableField(value = "birthday")
	private Date birthday;

	/**
     * 联系地址
     */
	@TableField(value = "address")
	private String address;

	/**
	 * 邮政编码
	 */
	@TableField(value = "post_code")
	private String postCode;

	/**
	 * 位置
	 */
	@TableField(value = "position")
	private String position;


	/**
	 * 账户是否锁定
	 */
	@TableField(value = "locked")
	private Boolean locked;

	/**
	 * 排序
	 */
	@TableField(value = "sort")
	private Integer sort;



	@TableField(strategy= FieldStrategy.IGNORED)
	private String icon;

	@TableField(exist=false)
	private List<String> roleIdList;

	@TableField(exist=false)
	private Set<SysRole> roleLists = Sets.newHashSet();


	/**
	 * 删除标记（Y：正常；N：删除；A：审核；）
	 */
	@TableField(value = "del_flag")
	protected Boolean delFlag;


	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	@JSONField(serialize=false)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@JSONField(serialize=false)
	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getMobileNum() {
		return mobileNum;
	}

	public void setMobileNum(String mobileNum) {
		this.mobileNum = mobileNum;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Boolean getLocked() {
		return locked;
	}

	public void setLocked(Boolean locked) {
		this.locked = locked;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public List<String> getRoleIdList() {
		return roleIdList;
	}

	public void setRoleIdList(List<String> roleIdList) {
		this.roleIdList = roleIdList;
	}

	public Set<SysRole> getRoleLists() {
		return roleLists;
	}

	public void setRoleLists(Set<SysRole> roleLists) {
		this.roleLists = roleLists;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Boolean getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Boolean delFlag) {
		this.delFlag = delFlag;
	}
}
