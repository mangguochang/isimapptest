package com.hzot.isim.controller.system;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.base.MySysUser;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.util.LayerData;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by system_user on 2017/11/21.
 *
 */
@Controller
@RequestMapping("admin/system/user")
public class SysUserConteroller extends BaseController{
    private static final Logger LOGGER = LoggerFactory.getLogger(SysUserConteroller.class);

    @GetMapping("list")
    @SysLog("跳转系统用户列表页面")
    public String list(Model model){
        return "admin/system/user/list";
    }

    @PostMapping("list")
    @ResponseBody
    public LayerData<SysUser> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                   @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                   ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<SysUser> userLayerData = new LayerData<>();
        EntityWrapper<SysUser> userEntityWrapper = new EntityWrapper<>();
        userEntityWrapper.orderBy("dept_code,sort");
        if(!map.isEmpty()){
            String loginName = (String) map.get("loginName");
            if(StringUtils.isNotBlank(loginName)) {
                userEntityWrapper.like("login_name", loginName);
            }
            String deptCode = (String) map.get("deptCode");
            if(StringUtils.isNotBlank(deptCode)) {
                userEntityWrapper.eq("dept_code", deptCode);
            }
            String realName = (String) map.get("realName");
            if(StringUtils.isNotBlank(realName)) {
                userEntityWrapper.like("real_name", realName);
            }
            String locked = (String) map.get("locked");
            if(StringUtils.isNotBlank(locked)) {
                userEntityWrapper.eq("locked", locked);
            }
        }
        Page<SysUser> userPage = sysUserService.selectPage(new Page<>(page,limit),userEntityWrapper);
        //设置创建者及更新者
        setCreatorUpdater(userPage);
        userLayerData.setCount(userPage.getTotal());
        userLayerData.setData(userPage.getRecords());
        return  userLayerData;
    }



    @GetMapping("edit")
    public String edit(String id,Model model){
        SysUser user = sysUserService.findUserById(id);
        if(user!=null){
            List<String> roleIdList = roleService.getRoleIdByUserId(id);
            user.setRoleIdList(roleIdList);
            List<Map<String, Object>> roleList = roleService.getAllRoleInofByUserId(id);
            model.addAttribute("user",user);
            model.addAttribute("roleList",roleList);
        }
        return "admin/system/user/edit";
    }

    @GetMapping("detail")
    public String detail(String id,Model model){
        SysUser user = sysUserService.findUserById(id);
        if(user!=null){
            List<String> roleIdList = roleService.getRoleIdByUserId(id);
            user.setRoleIdList(roleIdList);
            List<Map<String, Object>> roleList = roleService.getAllRoleInofByUserId(id);
            model.addAttribute("user",user);
            model.addAttribute("roleList",roleList);
        }
        return "admin/system/user/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("更新系统用户数据")
    public RestResponse edit(@RequestBody  SysUser user){
        if(StringUtils.isBlank(user.getId())){
            return RestResponse.failure("用户ID不能为空");
        }
        if(user.getRoleIdList() == null || user.getRoleIdList().size() == 0){
            return  RestResponse.failure("用户角色至少选择一个");
        }
        SysUser oldUser = sysUserService.findUserById(user.getId());
        if(StringUtils.isNotBlank(user.getEmail())){
            if(!user.getEmail().equals(oldUser.getEmail())){
                if(sysUserService.userCount(user.getEmail())>0){
                    return RestResponse.failure("该邮箱已被使用");
                }
            }
        }
        if(StringUtils.isNotBlank(user.getMobileNum())){
            if(!user.getMobileNum().equals(oldUser.getMobileNum())) {
                if (sysUserService.userCount(user.getMobileNum()) > 0) {
                    return RestResponse.failure("该手机号已经被绑定");
                }
            }
        }
        //更新用户数据
        oldUser.setMobileNum(user.getMobileNum());
        oldUser.setEmail(user.getEmail());
        oldUser.setSort(user.getSort());
        Set<SysRole> newRoleList = new HashSet<>();
        for(String roleId : user.getRoleIdList()){
            SysRole role = new SysRole();
            role.setId(roleId);
            newRoleList.add(role);
        }
        oldUser.setRoleLists(newRoleList);
        sysUserService.updateUser(oldUser);
        return RestResponse.success();
    }


    @GetMapping("changePassword")
    public String changePassword(){
        //跳转到修改密码界面
        return "admin/system/user/changePassword";
    }

    @GetMapping("userinfo")
    public String toEditMyInfo(Model model){
        String userId = MySysUser.id();
        SysUser user = sysUserService.findUserById(userId);
        model.addAttribute("userinfo",user);
        return "admin/system/user/userInfo";
    }

    @PostMapping("saveUserinfo")
    @SysLog("系统用户个人信息修改")
    @ResponseBody
    public RestResponse saveUserInfo(@RequestBody SysUser user){
        if(StringUtils.isBlank(user.getId())){
            return RestResponse.failure("用户ID不能为空");
        }
        if(StringUtils.isBlank(user.getLoginName())){
            return RestResponse.failure("登录名不能为空");
        }
        SysUser oldUser = sysUserService.findUserById(user.getId());
        if(StringUtils.isNotBlank(user.getEmail())){
            if(!user.getEmail().equals(oldUser.getEmail())){
                if(sysUserService.userCount(user.getEmail())>0){
                    return RestResponse.failure("该邮箱已被使用");
                }
            }
        }
        if(StringUtils.isNotBlank(user.getMobileNum())){
            if(!user.getMobileNum().equals(oldUser.getMobileNum())) {
                if (sysUserService.userCount(user.getMobileNum()) > 0) {
                    return RestResponse.failure("该手机号已经被绑定");
                }
            }
        }
        //不允许修改登录名，真实姓名，所属部门
        user.setLoginName(oldUser.getLoginName());
        user.setRealName(oldUser.getRealName());
        sysUserService.updateUserInfo(user);
        return RestResponse.success();
    }

}
