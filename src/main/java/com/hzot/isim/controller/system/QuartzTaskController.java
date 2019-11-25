package com.hzot.isim.controller.system;

import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.entity.system.QuartzTask;
import com.hzot.isim.service.system.QuartzTaskService;
import org.quartz.CronExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.util.LayerData;
import com.hzot.isim.util.RestResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletRequest;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * <p>
 * 定时任务  前端控制器
 * </p>
 *
 * @author system_user
 * @since 2018-01-24
 */
@Controller
@RequestMapping("/admin/quartzTask")
public class QuartzTaskController {
    private static final Logger LOGGER = LoggerFactory.getLogger(QuartzTaskController.class);


    @Autowired
    private QuartzTaskService quartzTaskService;

    @GetMapping("list")
    @SysLog("跳转定时任务列表")
    public String list(){
        return "admin/quartzTask/list";
    }

    @PostMapping("list")
    @ResponseBody
    public LayerData<QuartzTask> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                      @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                      ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<QuartzTask> layerData = new LayerData<>();
        EntityWrapper<QuartzTask> wrapper = new EntityWrapper<>();
        if(!map.isEmpty()){
            String name = (String) map.get("name");
            if(StringUtils.isNotBlank(name)) {
                wrapper.like("name",name);
            }else{
                map.remove("name");
            }

            String status = (String) map.get("status");
            if(StringUtils.isNotBlank(status)) {
                wrapper.eq("status",status);
            }else{
                map.remove("status");
            }

        }
        Page<QuartzTask> pageData = quartzTaskService.queryList(wrapper,new Page<>(page,limit));
        layerData.setData(pageData.getRecords());
        layerData.setCount(pageData.getTotal());
        return layerData;
    }

    @GetMapping("add")
    public String add(){
        return "admin/quartzTask/add";
    }

    @PostMapping("add")
    @SysLog("保存新增定时任务数据")
    @ResponseBody
    public RestResponse add(QuartzTask quartzTask){
        quartzTask.setId("quartzId:"+ UUID.randomUUID().toString());
        try {
            Boolean isValid = CronExpression.isValidExpression(quartzTask.getCron());
            if(!isValid){
                return RestResponse.failure("任务表达式不符合规范");
            }
            quartzTaskService.saveQuartzTask(quartzTask);
        }catch (Exception e){
            return RestResponse.failure(e.getMessage());
        }
        return RestResponse.success();
    }

    @GetMapping("edit")
    public String edit(String id,Model model){
        QuartzTask quartzTask = quartzTaskService.selectById(id);
        model.addAttribute("quartzTask",quartzTask);
        return "admin/quartzTask/edit";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存编辑定时任务数据")
    public RestResponse edit(QuartzTask quartzTask){
        if(StringUtils.isBlank(quartzTask.getId())){
            return RestResponse.failure("ID不能为空");
        }
        try {
            Boolean isValid = CronExpression.isValidExpression(quartzTask.getCron());
            if(!isValid){
                return RestResponse.failure("任务表达式不符合规范");
            }
            quartzTaskService.updateQuartzTask(quartzTask);
        }catch (Exception e){
            e.printStackTrace();
            return RestResponse.failure(e.getMessage());
        }
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除定时任务数据")
    public RestResponse delete(@RequestParam(value = "ids[]",required = false)List<String> ids){
        if(null == ids || 0 == ids.size()){
            return RestResponse.failure("ID不能为空");
        }
        quartzTaskService.deleteBatchTasks(ids);
        return RestResponse.success();
    }

    /**
     * 暂停选中的定时任务
     * @param ids 任务ID List
     * @return
     */
    @PostMapping("paush")
    @ResponseBody
    public RestResponse paush(@RequestParam(value = "ids[]",required = false)List<String> ids){
        if(null == ids || 0 == ids.size()){
            return RestResponse.failure("ID不能为空");
        }
        quartzTaskService.paush(ids);
        return RestResponse.success();
    }

    /**
     * 恢复选中的定时任务运行
     * @param ids 任务ID List
     * @return
     */
    @PostMapping("resume")
    @ResponseBody
    public RestResponse resume(@RequestParam(value = "ids[]",required = false)List<String> ids){
        if(null == ids || 0 == ids.size()){
            return RestResponse.failure("ID不能为空");
        }
        quartzTaskService.resume(ids);
        return RestResponse.success();
    }

    /**
     * 立即执行选中的定时任务
     * @param ids 任务ID List
     * @return
     */
    @PostMapping("run")
    @ResponseBody
    public RestResponse run(@RequestParam(value = "ids[]",required = false)List<String> ids){
        if(null == ids || 0 == ids.size()){
            return RestResponse.failure("ID不能为空");
        }
        quartzTaskService.run(ids);
        return RestResponse.success();
    }

}