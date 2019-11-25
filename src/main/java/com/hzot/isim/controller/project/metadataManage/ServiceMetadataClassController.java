package com.hzot.isim.controller.project.metadataManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.meta.ServiceMetadataClass;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RequestMapping("/metadata")
@Controller
public class ServiceMetadataClassController extends BaseController {

    @GetMapping("list")
    public String list(Model model)  {
        return "metadata/list";
    }

    @PostMapping("list")
    @ResponseBody
    public RestResponse list(){
        EntityWrapper<ServiceMetadataClass> wrapper = new EntityWrapper<>();
        wrapper.orderBy("create_time",true);
        List<ServiceMetadataClass> list = serviceMetadataClassService.selectList(wrapper);
        return  RestResponse.success().setData(list);
    }

    @PostMapping("add")
    @SysLog("新增元数据分类")
    @ResponseBody
    public RestResponse add(@RequestBody ServiceMetadataClass meta){
        meta.setId(EntityIdPrefix.SYS_META_CLASS+ UUID.randomUUID().toString());
        serviceMetadataClassService.insert(meta);
        return RestResponse.success();
    }

    @GetMapping("edit")
    @ResponseBody
    public RestResponse edit(String id){
        ServiceMetadataClass rule = serviceMetadataClassService.selectById(id);
        return RestResponse.success().setData(rule);
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("更新元数据分类")
    public RestResponse edit(@RequestBody ServiceMetadataClass meta){
        serviceMetadataClassService.updateById(meta);
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除元数据分类")
    public RestResponse delete(@RequestParam(value = "id",required = false)String id){
        if( StringUtils.isBlank(id)){
            return RestResponse.failure("元数据分类ID不能为空");
        }
        ServiceMetadataClass meta = serviceMetadataClassService.selectById(id);
        if(meta!=null){
            serviceMetadataClassService.deleteById(id);
        }else{
            return RestResponse.failure("该元数据分类不存在");
        }
        return RestResponse.success();
    }

    @PostMapping("getMetaFirstLevel")
    @SysLog("获取元数据分类第一层")
    @ResponseBody
    public RestResponse getMetaFirstLevel(){
        List<ServiceMetadataClass> metadataList = serviceMetadataClassService.getMetaFirstLevel();
        return RestResponse.success().setData(metadataList);
    }

    @PostMapping("getChildMetaById")
    @SysLog("获取子元数据分类")
    @ResponseBody
    public RestResponse getChildMetaById(String pid){
        EntityWrapper<ServiceMetadataClass> wrapper = new EntityWrapper<>();
        wrapper.eq("pid",pid);
        List<ServiceMetadataClass> metadataList = serviceMetadataClassService.selectList(wrapper);
        return RestResponse.success().setData(metadataList);
    }


}
