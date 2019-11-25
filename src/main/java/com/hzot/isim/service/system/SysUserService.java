package com.hzot.isim.service.system;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.entity.system.SysUser;

import java.util.Map;
import java.util.Set;

/**
 * <p>
 *  服务类
 * </p>
 */
public interface SysUserService extends IService<SysUser> {

	SysUser findUserByLoginName(String name);

	SysUser findUserById(String id);

	SysUser saveUser(SysUser user);

	SysUser updateUser(SysUser user);

	void saveUserRoles(String id,Set<SysRole> roleSet);

	void saveRoleUsers(String roleId, Set<SysUser> userSet);

	void dropUserRolesByUserId(String id);

	int userCount(String param);

	void deleteUser(SysUser user);

	Map selectUserMenuCount();

	public Page<Map<String, Object>> getRoleUserInfoLayui(Page<Map<String, Object>> page, Map<String,Object> map);

	public Page<Map<String, Object>> getRoleUserInfoUnselectedLayui(Page<Map<String, Object>> page, Map<String,Object> map);

	void dropUserRolesById(Map<String,Object> map);

	public void updateUserInfo(SysUser user);

	void dropUserMenus(String id);
}
