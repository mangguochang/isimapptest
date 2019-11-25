package com.hzot.isim.service.impl.system;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import com.hzot.isim.dao.system.SysUserDao;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.service.system.SysUserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Set;

/**
 * @ClassName: SysUserServiceImpl
 * @Description: 系统用户实现类
 * @Author: lolipopjy
 * @Date: 2019-06-27 17:33
 */
@Service("userService")
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUser> implements SysUserService {


	/*
	 * 获取未标记为删除的用户
	 */
	@Override
	public SysUser findUserByLoginName(String name) {
		// TODO Auto-generated method stub
		Map<String,Object> map = Maps.newHashMap();
		map.put("loginName", name);
		SysUser u = baseMapper.selectUserByMap(map);
		return u;
	}


	@Override
	public SysUser findUserById(String id) {
		// TODO Auto-generated method stub
		Map<String,Object> map = Maps.newHashMap();
		map.put("id", id);
		return baseMapper.selectById(id);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class)
	public SysUser saveUser(SysUser user) {
//		ToolUtil.entryptPassword(user);
		user.setLocked(false);
		baseMapper.insert(user);
		//保存用户角色关系
		if(user.getRoleLists().size()>0){
			this.saveUserRoles(user.getId(),user.getRoleLists());
		}
		return findUserById(user.getId());
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class)
	public SysUser updateUser(SysUser user) {
		baseMapper.updateById(user);
		//先解除用户跟角色的关系
		this.dropUserRolesByUserId(user.getId());
		this.saveUserRoles(user.getId(),user.getRoleLists());
		return user;
	}

	@Transactional(readOnly = false, rollbackFor = Exception.class)
	@Override
	public void saveUserRoles(String id, Set<SysRole> roleSet) {
		baseMapper.saveUserRoles(id,roleSet);
	}

	@Transactional(readOnly = false, rollbackFor = Exception.class)
	@Override
	public void saveRoleUsers(String roleId, Set<SysUser> userSet) {
		baseMapper.saveRoleUsers(roleId,userSet);
	}

	@Transactional(readOnly = false, rollbackFor = Exception.class)
	@Override
	public void dropUserRolesByUserId(String id) {
		baseMapper.dropUserRolesByUserId(id);
	}

	@Override
	public int userCount(String param) {
		EntityWrapper<SysUser> wrapper = new EntityWrapper<>();
		wrapper.eq("login_name",param).or().eq("email",param).or().eq("mobile_num",param);
		int count = baseMapper.selectCount(wrapper);
		return count;
	}

	@Transactional(readOnly = false, rollbackFor = Exception.class)
	@Override
	public void deleteUser(SysUser user) {
		user.setDelFlag(true);
		user.updateById();
	}

	/**
	 * 查询用户拥有的每个菜单具体数量
	 * @return
	 */
	@Override
	public Map selectUserMenuCount() {
		return baseMapper.selectUserMenuCount();
	}

    @Override
    public Page<Map<String, Object>> getRoleUserInfoLayui(Page<Map<String, Object>> page, Map<String,Object> map) {
		return page.setRecords(this.baseMapper.getRoleUserInfoLayui(page,map));
    }

    @Override
    public Page<Map<String, Object>> getRoleUserInfoUnselectedLayui(Page<Map<String, Object>> page, Map<String,Object> map) {
		return page.setRecords(this.baseMapper.getRoleUserInfoUnselectedLayui(page,map));
    }

	@Transactional(readOnly = false, rollbackFor = Exception.class)
	@Override
	public void dropUserRolesById(Map<String, Object> map) {
		this.baseMapper.dropUserRolesById(map);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class)
	public void updateUserInfo(SysUser user) {
		this.baseMapper.updateUserInfo(user);
	}

	@Transactional(readOnly = false, rollbackFor = Exception.class)
	@Override
	public void dropUserMenus(String id) {
		baseMapper.dropUserMenus(id);
	}
}
