package com.hzot.isim.service.impl.system;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.service.system.SysRoleService;
import com.hzot.isim.dao.system.SysRoleDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author system_user
 * @since 2017-10-31
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysRoleServiceImpl extends ServiceImpl<SysRoleDao, SysRole> implements SysRoleService {

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public SysRole saveRole(SysRole role) {
        role.setId(EntityIdPrefix.SYS_ROLE + UUID.randomUUID().toString());
        baseMapper.insert(role);
        return role;
    }

    @Override
    public SysRole getRoleById(String id) {
        SysRole role = baseMapper.selectRoleById(id);
        return role;
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void updateRole(SysRole role) {
        baseMapper.updateById(role);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteRole(SysRole role) {
        baseMapper.deleteById(role);
        baseMapper.dropRoleMenus(role.getId());
        baseMapper.dropRoleUsers(role.getId());
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void dropRoleMenus(String id) {
        baseMapper.dropRoleMenus(id);
    }

    @Override
    public Integer getRoleNameCount(String name) {
        EntityWrapper<SysRole> wrapper = new EntityWrapper<>();
        wrapper.eq("role_name",name);
        return baseMapper.selectCount(wrapper);
    }

    @Override
    public List<SysRole> selectAll() {
        EntityWrapper<SysRole> wrapper = new EntityWrapper<>();
        List<SysRole> roleList = baseMapper.selectList(wrapper);
        return roleList;
    }

    @Override
    public List<SysRole> getRoleByUserId(String userId) {
        List<SysRole> roleList =  this.baseMapper.getRoleByUserId(userId);
        return roleList;
    }

    @Override
    public List<Map<String, Object>> getAllRoleInofByUserId(String userId) {
        List<Map<String, Object>>  roleList =  this.baseMapper.getAllRoleInofByUserId(userId);
        return roleList;
    }

    @Override
    public List<String> getRoleIdByUserId(String userId) {
        List<String> roleIdList = new ArrayList<>();
        List<SysRole> roleList =  this.baseMapper.getRoleByUserId(userId);
        for(SysRole role : roleList){
            roleIdList.add(role.getId());
        }
        return roleIdList;
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void dropRoleUsers(SysRole role) {
        baseMapper.dropRoleUsers(role.getId());
    }

    @Override
    public Boolean isManager(String loginName) {
        List<SysRole> managerRoleList = this.baseMapper.isManager(loginName);
        if(managerRoleList.size()>0){
            return true;
        }
        return false;
    }

}
