package com.hzot.isim.base;

import com.hzot.isim.entity.system.SysUser;
import org.apache.shiro.util.ThreadContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 *@Description:
 *@Param:
 *@Author: lolipopjy
 *@date: 2019/11/14 17:07
 *@return:
 */
public class MySysUser {

    /**
     * 取出Shiro中的当前用户LoginName.
     */
    public static String icon() {
        return CurrentUser().getIcon();
    }

    public static String id() {
        //调度时获取不到当前用户
        if(CurrentUser()==null){
            return null;
        }
        return CurrentUser().getId();
    }

    public static String loginName() {
        return CurrentUser().getLoginName();
    }

    public static String realName(){
        return CurrentUser().getRealName();
    }

    public static SysUser CurrentUser() {
        SysUser user = null;
        try {
            HttpServletRequest request = ((ServletRequestAttributes)
                    RequestContextHolder.getRequestAttributes()).getRequest();
            user = (SysUser)request.getSession().getAttribute("currentUser");
            //调度时获取不到当前用户
            if(user==null&&ThreadContext.getSubject()==null){
                return null;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }
}
