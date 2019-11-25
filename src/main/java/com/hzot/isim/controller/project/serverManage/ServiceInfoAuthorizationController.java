package com.hzot.isim.controller.project.serverManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.entity.service.ServiceAuthInfo;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: ServiceInfoAuthorizationController
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-12 16:54
 */
@RequestMapping("/service/authorization")
@Controller
public class ServiceInfoAuthorizationController extends ServiceBaseController {

    @GetMapping("list")
    public String list(Model model)  {
        getSelectOptionList(model);
        return "service/authorization/list";
    }

    /**
    *@Description: 服务申请授权信息
    *@Param: [pageSize, pageNumber, request]
    *@Author: lolipopjy
    *@date: 2019/11/19 15:26
    *@return:
    */
    @PostMapping("list")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "1")Integer pageSize,
                         @RequestParam(value = "pageNumber",defaultValue = "10")Integer pageNumber,
                         ServletRequest request){
        PageList pageList = new PageList();
        Map<String, Object> filter = WebUtils.getParametersStartingWith(request, "s_");
        EntityWrapper<ServiceAuthInfo> entityWrapper = new EntityWrapper<>();
        for(String key : filter.keySet()){
            entityWrapper.like(key, (String)filter.get(key));
        }
        Page<Map<String, Object>> pageInfo = serviceAuthInfoService.getServiceAuthInfoByPage(new Page<>(pageNumber,pageSize),filter);
        setPageInfo(pageList,pageInfo,pageNumber,pageSize);
        formatResultList(pageInfo.getRecords());
        //设置创建者及更新者
        setCreatorUpdaterByMap(pageInfo);
        return RestResponse.success().setData(pageList);
    }

    @PostMapping("authorize")
    @ResponseBody
    public RestResponse authorize(String id){
        RestResponse response = null;
        try {
            serviceAuthInfoService.authorize(id);
            response = RestResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            response = RestResponse.failure(e.getMessage());
        }
        return response;
    }

    @PostMapping("reject")
    @ResponseBody
    public RestResponse reject(String id){
        RestResponse response = null;
        try {
            serviceAuthInfoService.reject(id);
            response = RestResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            response = RestResponse.failure(e.getMessage());
        }
        return response;
    }

    @PostMapping("cancel")
    @ResponseBody
    public RestResponse cancel(String id){
        RestResponse response = null;
        try {
            serviceAuthInfoService.cancel(id);
            response = RestResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            response = RestResponse.failure(e.getMessage());
        }
        return response;
    }

}
