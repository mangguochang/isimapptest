package com.hzot.isim.entity.system;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

import java.util.Set;

/**
 * 系统角色表
 */
@TableName("sys_role")
public class SysRole extends DataEntity<SysRole> {

    private static final long serialVersionUID = 1L;

    /**
     * 角色编码
     */
	@TableField("role_code")
	private String roleCode;
    /**
     * 角色名称
     */
	@TableField("role_name")
	private String roleName;
    /**
     * 角色描述
     */
	@TableField("role_desc")
	private String roleDesc;
    /**
     * 角色类型
     */
	@TableField("role_type")
	private String roleType;

	@TableField(exist = false)
	private Set<SysUser> userSet;


	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Set<SysUser> getUserSet() {
		return userSet;
	}

	public void setUserSet(Set<SysUser> userSet) {
		this.userSet = userSet;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
}
