package com.hzot.isim.controller.project.serverManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.entity.service.ServiceResponseParams;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletRequest;

/**
 * @ClassName: ServiceResponseParamsController
 * @Description: 服务基本信息-返回参数
 * @Author: lolipopjy
 * @Date: 2019-10-23 14:16
 */
@RequestMapping("/service/response")
@Controller
public class ServiceResponseParamsController extends BaseController {

    @PostMapping("list")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "1")Integer pageSize,
                             @RequestParam(value = "pageNumber",defaultValue = "10")Integer pageNumber,
                             String serviceId, ServletRequest request){

        PageList pageList = new PageList();
        EntityWrapper<ServiceResponseParams> entityWrapper = new EntityWrapper<>();
        if(StringUtils.isNotBlank(serviceId)) {
            entityWrapper.eq("service_id", serviceId);
        }
        Page<ServiceResponseParams> pageInfo = serviceResponseParamsService.selectPage(new Page<>(pageNumber,pageSize),entityWrapper);
        setPageInfo(pageList,pageInfo,pageSize,pageNumber);
        //设置创建者及更新者
        setCreatorUpdater(pageInfo);
        return  RestResponse.success().setData(pageList);
    }


}
