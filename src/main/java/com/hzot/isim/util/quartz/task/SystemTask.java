package com.hzot.isim.util.quartz.task;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.hzot.isim.entity.service.ServiceApplicationInfo;
import com.hzot.isim.service.service.ServiceApplicationInfoService;
import com.hzot.isim.service.service.ServiceInfoService;
import com.hzot.isim.util.HttpClientUtils;
import com.xiaoleilu.hutool.log.Log;
import com.xiaoleilu.hutool.log.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Created by system_user on 2018/1/26.
 * todo: 系统定时任务
 */
@Component("systemTask")
public class SystemTask {
    private static Log log = LogFactory.get();


    @Value("${remote.getBCStatusURL}")
    private String getBCStatusURL;

    @Autowired
    private ServiceInfoService serviceInfoService;

    @Autowired
    private ServiceApplicationInfoService serviceApplicationInfoService;

    /**
    *@Description: 同步应用发布信息
    *@Param: []
    *@Author: lolipopjy
    *@date: 2019/11/01 17:30
    *@return:
    */
    public void syncBCStatus(String id){
        Map<String, Object> data = HttpClientUtils.getBCStatus(getBCStatusURL);
//        String mapS = "{\"wsdlservice\":\"Complete\",\"testno14\":\"Complete\",\"testno10\":\"Complete\",\"testno9\":\"Failed\"}";
//        Map<String,Object> data =JSON.parseObject(mapS,Map.class);
        for(String appName : data.keySet()){
            EntityWrapper<ServiceApplicationInfo> wrapper = new EntityWrapper<>();
            wrapper.eq("application_name",appName);
            List<ServiceApplicationInfo> serviceInfos = serviceApplicationInfoService.selectList(wrapper);
            if(serviceInfos.size()>0){
                ServiceApplicationInfo appInfo = serviceInfos.get(0);
                if(appInfo!=null){
                    appInfo.setStatus((String) data.get(appName));
                    serviceApplicationInfoService.updateById(appInfo);
                }
            }
        }
    }


}
