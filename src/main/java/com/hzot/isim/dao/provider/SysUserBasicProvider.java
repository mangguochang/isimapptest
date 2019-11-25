package com.hzot.isim.dao.provider;

import org.apache.commons.lang3.StringUtils;

import java.util.Map;

/**
 * @ClassName: SysDictBasicProvider
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-07-01 10:02
 */
public class SysUserBasicProvider {

    /**
    *@Description:分页过滤查询角色选中的人员信息
    *@Param: [para]
    *@Author: lolipopjy
    *@date: 2019/7/18 14:11
    *@return:
    */
    public String getRoleUserInfoLayui(Map<String, Object> params){
        String baseSQL =
                "select suser.id,suser.login_name as loginName,suser.real_name as realName from sys_user suser ,sys_user_role urole  " +
                "where suser.id = urole.user_id and urole.role_id = #{map.roleId} " ;
        Map<String,Object> map = (Map<String, Object>) params.get("map");
        if(!map.isEmpty()){
            String loginName = (String) map.get("loginName");
            if(StringUtils.isNotBlank(loginName)) {
                baseSQL +=" and suser.login_name  LIKE CONCAT('%',#{map.loginName},'%')";
            }
            String realName = (String) map.get("realName");
            if(StringUtils.isNotBlank(realName)) {
                baseSQL +=" and suser.real_name  LIKE CONCAT('%',#{map.realName},'%')";
            }
        }
        baseSQL +="  group by suser.id,suser.login_name  order by suser.sort desc ";
        return baseSQL;
    }

    /**
    *@Description:分页过滤查询角色未选中的人员信息
    *@Param: [para]
    *@Author: lolipopjy
    *@date: 2019/7/18 17:56
    *@return:
    */
    public String getRoleUserInfoUnselectedLayui(Map<String, Object> params){
        String baseSQL =
                " select puser.id ,puser.login_name as loginName ,puser.real_name as realName from sys_user puser where not exists  " +
                "(select suser.id,suser.login_name from sys_user suser ,sys_user_role urole  " +
                "where suser.id = urole.user_id and urole.role_id =  #{map.roleId} and  puser.id = suser.id ) " ;
        Map<String,Object> map = (Map<String, Object>) params.get("map");
        if(!map.isEmpty()){
            String loginName = (String) map.get("loginName");
            if(StringUtils.isNotBlank(loginName)) {
                baseSQL +=" and puser.login_name  LIKE CONCAT('%',#{map.loginName},'%') ";
            }
            String realName = (String) map.get("realName");
            if(StringUtils.isNotBlank(realName)) {
                baseSQL +=" and puser.real_name  LIKE CONCAT('%',#{map.realName},'%') ";
            }
        }
        baseSQL+=" order by puser.sort desc  ";
        return baseSQL;
    }

}



