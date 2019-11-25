package com.hzot.isim.dao.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.hzot.isim.entity.system.SysRole;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author system_user
 * @since 2017-10-31
 */
public interface SysRoleDao extends BaseMapper<SysRole> {

    @Select("select * from sys_role where id = #{id}")
    SysRole selectRoleById(@Param("id") String id);

    void dropRoleMenus(@Param("roleId")String roleId);

    void dropRoleUsers(@Param("roleId")String roleId);

    @Select("select role.* from sys_role role , sys_user_role urole where role.id = urole.role_id and urole.user_id = #{userId}")
    List<SysRole> getRoleByUserId(String userId);

    @Select("select role.id as value ,role.role_name as label from sys_role role order by create_time ")
    List<Map<String, Object>> getAllRoleInofByUserId(String userId);

    @Select("select srole.* from sys_role srole,sys_user_role urole,sys_user suser  where suser.id = urole.user_id and urole.role_id = srole.id "+
            " and suser.login_name = #{loginName} and srole.role_type = 0 ")
    List<SysRole> isManager(String loginName);
}