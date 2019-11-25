package com.hzot.isim.controller.system;

import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.entity.system.QuartzTaskLog;
import com.hzot.isim.service.system.QuartzTaskLogService;
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
import java.util.Map;

/**
 * <p>
 * 任务执行日志  前端控制器
 * </p>
 *
 * @author system_user
 * @since 2018-01-25
 */
@Controller
@RequestMapping("/admin/quartzTaskLog")
public class QuartzTaskLogController {
    private static final Logger LOGGER = LoggerFactory.getLogger(QuartzTaskLogController.class);

    @Autowired
    private QuartzTaskLogService quartzTaskLogService;

    @GetMapping("list")
    @SysLog("跳转任务执行日志列表")
    public String list(){
        return "admin/quartzTaskLog/list";
    }

    @PostMapping("list")
    @ResponseBody
    public LayerData<QuartzTaskLog> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                         @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                         ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<QuartzTaskLog> layerData = new LayerData<>();
        EntityWrapper<QuartzTaskLog> wrapper = new EntityWrapper<>();
        if(!map.isEmpty()){
            String name = (String) map.get("name");
            if(StringUtils.isNotBlank(name)) {
                wrapper.like("name",name);
            }else{
                map.remove("name");
            }

        }
        Page<QuartzTaskLog> pageData = quartzTaskLogService.selectPage(new Page<>(page,limit),wrapper);
        layerData.setData(pageData.getRecords());
        layerData.setCount(pageData.getTotal());
        return layerData;
    }

    @GetMapping("add")
    public String add(){
        return "admin/quartzTaskLog/add";
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(QuartzTaskLog quartzTaskLog){
        quartzTaskLogService.insert(quartzTaskLog);
        return RestResponse.success();
    }

    @GetMapping("edit")
    public String edit(String id,Model model){
        QuartzTaskLog quartzTaskLog = quartzTaskLogService.selectById(id);
        model.addAttribute("quartzTaskLog",quartzTaskLog);
        return "admin/quartzTaskLog/edit";
    }

    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(QuartzTaskLog quartzTaskLog){
        if(StringUtils.isBlank(quartzTaskLog.getId())){
            return RestResponse.failure("ID不能为空");
        }
        quartzTaskLogService.updateById(quartzTaskLog);
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除任务执行日志数据")
    public RestResponse delete(@RequestParam(value = "id",required = false)String id){
        if(StringUtils.isBlank(id)){
            return RestResponse.failure("ID不能为空");
        }
        QuartzTaskLog quartzTaskLog = quartzTaskLogService.selectById(id);
        quartzTaskLog.setDelFlag(true);
        quartzTaskLogService.updateById(quartzTaskLog);
        return RestResponse.success();
    }

}