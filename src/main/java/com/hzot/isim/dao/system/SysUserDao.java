package com.hzot.isim.dao.system;


import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.dao.provider.SysUserBasicProvider;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.entity.system.SysUser;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author system_user
 * @since 2017-10-31
 */
public interface SysUserDao extends BaseMapper<SysUser> {
	SysUser selectUserByMap(Map<String, Object> map);

	void saveUserRoles(@Param("userId")String id, @Param("roleIds")Set<SysRole> roles);

	void dropUserRolesByUserId(@Param("userId")String userId);

	void dropUserRolesById(Map<String,Object> map);

	Map selectUserMenuCount();

	@SelectProvider(type= SysUserBasicProvider.class,method="getRoleUserInfoLayui")
    List<Map<String, Object>> getRoleUserInfoLayui(@Param(value="page") Page<Map<String,Object>> page, @Param(value="map") Map<String,Object> map);

	@SelectProvider(type= SysUserBasicProvider.class,method="getRoleUserInfoUnselectedLayui")
    List<Map<String, Object>> getRoleUserInfoUnselectedLayui(@Param(value="page") Page<Map<String,Object>> page, @Param(value="map") Map<String,Object> map);

	void saveRoleUsers(@Param("roleId")String id, @Param("userIds")Set<SysUser> userSet);

	@Update("update sys_user set nick_name=#{user.nickName},mobile_num=#{user.mobileNum},email=#{user.email}" +
			",sex=#{user.sex},birthday=#{user.birthday},address=#{user.address},post_code=#{user.postCode}," +
			"position=#{user.position},icon=#{user.icon} where id=#{user.id}")
	public Integer updateUserInfo(@Param("user")SysUser user);

	void dropUserMenus(@Param("userId")String userId);
}