package com.hzot.isim.controller.project.roleManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

@RequestMapping("/role")
@Controller
public class RoleController extends BaseController {

    @GetMapping("roleList")
    public String userList(HttpServletRequest request)  {
        return "role/roleList";
    }

    @PostMapping("list")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "1")Integer pageSize,
                             @RequestParam(value = "pageNumber",defaultValue = "10")Integer pageNumber,
                             String roleCode, String roleName,
                             ServletRequest request){

        PageList pageList=new PageList();
        EntityWrapper<SysRole> userEntityWrapper = new EntityWrapper<>();
        if(StringUtils.isNotBlank(roleName)) {
            userEntityWrapper.like("role_name", roleName);
        }
        if(StringUtils.isNotBlank(roleCode)) {
            userEntityWrapper.like("role_code", roleCode);
        }
        Page<SysRole> pageInfo = roleService.selectPage(new Page<>(pageNumber,pageSize),userEntityWrapper);
        setPageInfo(pageList,pageInfo,pageSize,pageNumber);
        return  RestResponse.success().setData(pageList);
    }



}
