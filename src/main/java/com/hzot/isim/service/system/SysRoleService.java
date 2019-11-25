package com.hzot.isim.service.system;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.system.SysRole;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author system_user
 * @since 2017-10-31
 */
public interface SysRoleService extends IService<SysRole> {

    SysRole saveRole(SysRole role);

    SysRole getRoleById(String id);

    void updateRole(SysRole role);

    void deleteRole(SysRole role);

    void dropRoleMenus(String id);

    Integer getRoleNameCount(String name);

    List<SysRole> selectAll();

    List<String> getRoleIdByUserId(String userId);

    List<SysRole> getRoleByUserId(String userId);

    List<Map<String,Object>> getAllRoleInofByUserId(String userId);

    public void dropRoleUsers(SysRole role);

    Boolean isManager(String loginName);
	
}
