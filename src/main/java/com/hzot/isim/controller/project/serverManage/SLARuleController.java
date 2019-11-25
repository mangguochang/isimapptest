package com.hzot.isim.controller.project.serverManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.service.SysSLARule;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * @ClassName: SLARuleController
 * @Description: 服务治理-SLA规则
 * @Author: lolipopjy
 * @Date: 2019-10-16 11:11
 */
@RequestMapping("/service")
@Controller
public class SLARuleController extends BaseController {

    @GetMapping("sla/slaList")
    public String slaList(HttpServletRequest request)  {
        return "service/sla/slaList";
    }

    @PostMapping("sla/slaList")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "1")Integer pageSize,
                         @RequestParam(value = "pageNumber",defaultValue = "10")Integer pageNumber,
                         String ruleName,ServletRequest request){

        PageList pageList = new PageList();
        EntityWrapper<SysSLARule> entityWrapper = new EntityWrapper<>();
        if(StringUtils.isNotBlank(ruleName)) {
            entityWrapper.like("rule_name", ruleName);
        }
        Page<SysSLARule> pageInfo = slaRuleService.selectPage(new Page<>(pageNumber,pageSize),entityWrapper);
        setPageInfo(pageList,pageInfo,pageSize,pageNumber);
        //设置创建者及更新者
        setCreatorUpdater(pageInfo);
        return  RestResponse.success().setData(pageList);
    }

    @PostMapping("sla/add")
    @SysLog("新增SLA规则")
    @ResponseBody
    public RestResponse add(@RequestBody SysSLARule rule){
        rule.setId(EntityIdPrefix.SYS_SLA+ UUID.randomUUID().toString());
        slaRuleService.insert(rule);
        return RestResponse.success();
    }

    @GetMapping("sla/edit")
    @ResponseBody
    public RestResponse edit(String id){
        SysSLARule rule = slaRuleService.selectById(id);
        return RestResponse.success().setData(rule);
    }

    @PostMapping("sla/edit")
    @ResponseBody
    @SysLog("更新SLA规则数据")
    public RestResponse edit(@RequestBody SysSLARule rule){
        slaRuleService.updateById(rule);
        return RestResponse.success();
    }

    @PostMapping("sla/delete")
    @ResponseBody
    @SysLog("删除SLA规则数据")
    public RestResponse delete(@RequestParam(value = "id",required = false)String id){
        if( StringUtils.isBlank(id)){
            return RestResponse.failure("规则ID不能为空");
        }
        SysSLARule rule = slaRuleService.selectById(id);
        if(rule!=null){
            slaRuleService.deleteById(id);
        }else{
            return RestResponse.failure("该规则不存在");
        }
        return RestResponse.success();
    }
}
