package com.hzot.isim.controller.project.serverManage;

import com.baomidou.mybatisplus.entity.Column;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.entity.meta.ServiceMetadataClass;
import com.hzot.isim.entity.meta.SysNameList;
import com.hzot.isim.entity.service.ServiceApplicationInfo;
import com.hzot.isim.entity.service.ServiceInfo;
import com.hzot.isim.entity.service.ServiceInterfaceInfo;
import com.hzot.isim.util.PageList;
import org.apache.commons.lang3.StringUtils;
import org.springframework.ui.Model;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: ServiceBaseController
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-11 15:19
 */
public class ServiceBaseController extends BaseController {

    protected PageList baseServiceInfoList(EntityWrapper<ServiceInfo> entityWrapper,Map<String,Object> filter,Page page){
        entityWrapper = entityWrapper==null? new EntityWrapper<>():entityWrapper;
        for(String key : filter.keySet()){
            entityWrapper.like(key, (String)filter.get(key));
        }
        PageList pageList = new PageList();
        Page<Map<String, Object>> pageInfo = serviceInfoService.selectMapsPage(page,entityWrapper);
        setPageInfo(pageList,pageInfo,page.getCurrent(),page.getSize());
        formatResultList(pageInfo.getRecords());
        //设置创建者及更新者
        setCreatorUpdaterByMap(pageInfo);
        return pageList;
    }

    /**
     *@Description: 格式化列表查询结果集
     *@Param: []
     *@Author: lolipopjy
     *@date: 2019/10/24 15:54
     *@return:
     */
    protected void formatResultList(List<Map<String,Object>> datas){
        for(Map<String,Object> data : datas){
            //服务所属分类
            String serviceSecondClass = (String) data.get("serviceSecondClass");
            ServiceMetadataClass metadataClass = serviceMetadataClassService.selectById(serviceSecondClass);
            if(metadataClass!=null){
                data.put("serviceSecondClass",metadataClass.getName());
            }
            //服务所属系统
            String serviceSystem = (String) data.get("serviceSystem");
            SysNameList sys = sysNameListService.getSysNameListById(serviceSystem);
            if(sys!=null){
                data.put("serviceSystem",sys.getName());
            }
            //获取应用状态
            String serviceId = (String) data.get("id");
            ServiceApplicationInfo info = serviceApplicationInfoService.getByServiceId(serviceId);
            if(info!=null){
                data.put("appStatus",info.getStatus());
            }
            //获取服务类型
            ServiceInterfaceInfo serviceInterfaceInfo = serviceInterfaceInfoService.getByServiceId(serviceId);
            if(serviceInterfaceInfo!=null){
                data.put("serviceType",serviceInterfaceInfo.getServiceType());
            }

        }
    }


    /**
     *@Description: 获取界面所需下拉框的数据
     *@Param: [model]
     *@Author: lolipopjy
     *@date: 2019/10/24 17:14
     *@return:
     */
    protected void getSelectOptionList(Model model){
        //所属分类
        List<ServiceMetadataClass> serviceClassList = serviceMetadataClassService.getMetaFirstLevel();
        model.addAttribute("serviceClassList",serviceClassList);
        //所属系统
        List<Map<String,Object>> sysNameList = sysNameListService.getSysNameListSelectOption();
        model.addAttribute("sysNameList",sysNameList);
    }

}
