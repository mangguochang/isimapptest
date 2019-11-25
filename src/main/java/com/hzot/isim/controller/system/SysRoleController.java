package com.hzot.isim.controller.system;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.base.BaseController;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by system_user on 2017/12/2.
 * todo:
 */
@Controller
@RequestMapping("admin/system/role")
public class SysRoleController extends BaseController{
    private static final Logger LOGGER = LoggerFactory.getLogger(SysRoleController.class);

    @GetMapping("list")
    @SysLog("跳转角色列表页面")
    public String list(Model model){
        return "admin/system/role/list";
    }

    @PostMapping("list")
    @ResponseBody
    public LayerData<SysRole> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                   @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                   ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<SysRole> roleLayerData = new LayerData<>();
        EntityWrapper<SysRole> roleEntityWrapper = new EntityWrapper<>();
        if(!map.isEmpty()){
            String roleCode = (String) map.get("roleCode");
            if(StringUtils.isNotBlank(roleCode)) {
                roleEntityWrapper.like("role_code", roleCode);
            }
            String roleName = (String) map.get("roleName");
            if(StringUtils.isNotBlank(roleName)) {
                roleEntityWrapper.like("role_name", roleName);
            }
        }
        Page<SysRole> rolePage = roleService.selectPage(new Page<>(page,limit),roleEntityWrapper);
        //设置创建者及更新者
        setCreatorUpdater(rolePage);
        roleLayerData.setCount(rolePage.getTotal());
        roleLayerData.setData(setUserToRole(rolePage.getRecords()));
        return roleLayerData;
    }

    private List<SysRole> setUserToRole(List<SysRole> roles){
        for(SysRole r : roles){
            if(StringUtils.isNotBlank(r.getCreateId())){
                SysUser u = sysUserService.findUserById(r.getCreateId());
                if(StringUtils.isBlank(u.getRealName())){
                    u.setRealName(u.getLoginName());
                }
                r.setCreateUser(u);
            }
            if(StringUtils.isNotBlank(r.getUpdateId())){
                SysUser u  = sysUserService.findUserById(r.getUpdateId());
                if(StringUtils.isBlank(u.getRealName())){
                    u.setRealName(u.getLoginName());
                }
                r.setUpdateUser(u);
            }
        }
        return roles;
    }

    @GetMapping("add")
    public String add(Model model){
        return "admin/system/role/add";
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("保存新增角色数据")
    public RestResponse add(@RequestBody SysRole role){
        if(StringUtils.isBlank(role.getRoleName())){
            return RestResponse.failure("角色名称不能为空");
        }
        if(roleService.getRoleNameCount(role.getRoleName())>0){
            return RestResponse.failure("角色名称已存在");
        }
        roleService.saveRole(role);
        return RestResponse.success();
    }

    @GetMapping("edit")
    public String edit(String id,Model model){
        SysRole role = roleService.getRoleById(id);
        model.addAttribute("role",role);
        return "admin/system/role/edit";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存编辑角色数据")
    public RestResponse edit(@RequestBody SysRole role){
        if(StringUtils.isBlank(role.getId())){
            return RestResponse.failure("角色ID不能为空");
        }
        if(StringUtils.isBlank(role.getRoleName())){
            return RestResponse.failure("角色名称不能为空");
        }
        SysRole oldRole = roleService.getRoleById(role.getId());
        if(!oldRole.getRoleName().equals(role.getRoleName())){
            if(roleService.getRoleNameCount(role.getRoleName())>0){
                return RestResponse.failure("角色名称已存在");
            }
        }
        roleService.updateRole(role);
        return RestResponse.success();
    }


    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除角色数据")
    public RestResponse delete(@RequestParam(value = "id",required = false)String id){
        if( StringUtils.isBlank(id)){
            return RestResponse.failure("角色ID不能为空");
        }
        SysRole role = roleService.getRoleById(id);
        roleService.deleteRole(role);
        return RestResponse.success();
    }

    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("多选删除角色数据")
    public RestResponse deleteSome(@RequestBody List<SysRole> roles){
        if(roles == null || roles.size()==0){
            return RestResponse.failure("请选择需要删除的角色");
        }
        for (SysRole r : roles){
            roleService.deleteRole(r);
        }
        return RestResponse.success();
    }

    @PostMapping("addSomeMember")
    @ResponseBody
    @SysLog("添加成员到角色")
    public RestResponse addSomeMember(@RequestBody Set<SysUser> userList,String roleId){
        if(userList == null || userList.size()==0){
            return RestResponse.failure("请选择需要添加到角色的成员");
        }
        sysUserService.saveRoleUsers(roleId,userList);
        return RestResponse.success();
    }

    @GetMapping("member/list")
    public String member(String roleId,Model model){
        model.addAttribute("roleId",roleId);
        return "admin/system/role/member/list";
    }

    @PostMapping("member/list")
    @ResponseBody
    public LayerData<SysUser> member(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                   @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                   ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<SysUser> userLayerData = new LayerData<>();
        EntityWrapper<SysUser> userEntityWrapper = new EntityWrapper<>();
        if(!map.isEmpty()){
            String loginName = (String) map.get("loginName");
            if(StringUtils.isNotBlank(loginName)) {
                userEntityWrapper.like("login_name", loginName);
            }
            String realName = (String) map.get("realName");
            if(StringUtils.isNotBlank(realName)) {
                userEntityWrapper.like("real_name", realName);
            }
        }
        Page userPage = sysUserService.getRoleUserInfoLayui(new Page<>(page, limit),map);
        //设置创建者及更新者
//        setCreatorUpdater(userPage);
        userLayerData.setCount(userPage.getTotal());
        userLayerData.setData(userPage.getRecords());
        return  userLayerData;
    }

    @GetMapping("member/add")
    public String addMember(String roleId,Model model){
        model.addAttribute("roleId",roleId);
        return "admin/system/role/member/add";
    }

    @PostMapping("member/add")
    @ResponseBody
    public LayerData<SysUser> addMember(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                   @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                   ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<SysUser> userLayerData = new LayerData<>();
        //获取该角色未选中人员的列表
        Page userPage = sysUserService.getRoleUserInfoUnselectedLayui(new Page<>(page, limit),map);
        //设置创建者及更新者
        setCreatorUpdater(userPage);
        userLayerData.setCount(userPage.getTotal());
        userLayerData.setData(userPage.getRecords());
        return  userLayerData;
    }

    @PostMapping("member/delete")
    @ResponseBody
    @SysLog("删除角色成员")
    public RestResponse deleteMember(String roleId,String userId){
        Map<String,Object> map = new HashMap<>();
        map.put("roleId",roleId);
        map.put("userId",userId);
        sysUserService.dropUserRolesById(map);
        return RestResponse.success();
    }


}
