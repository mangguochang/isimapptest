package com.hzot.isim.controller.project.userManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;


@RequestMapping("/user")
@Controller
public class UserController extends BaseController {

    @GetMapping("userList")
    public String userList(HttpServletRequest request) {

        return "user/userlist";
    }


    @PostMapping("list")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize,
                             @RequestParam(value = "pageNumber",defaultValue = "1")Integer pageNumber,
                             String loginName, String realName,
                             ServletRequest request){

        PageList pageList=new PageList();
        EntityWrapper<SysUser> userEntityWrapper = new EntityWrapper<>();
            if(StringUtils.isNotBlank(loginName)) {
                userEntityWrapper.like("login_name", loginName);
            }
            if(StringUtils.isNotBlank(realName)) {
                userEntityWrapper.like("real_name", realName);
            }
        Page<SysUser> pageInfo = sysUserService.selectPage(new Page<>(pageNumber,pageSize),userEntityWrapper);
        setPageInfo(pageList,pageInfo,pageSize,pageNumber);
        //设置创建者及更新者
        setCreatorUpdater(pageInfo);
        return  RestResponse.success().setData(pageList);
    }



}
