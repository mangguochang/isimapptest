package com.hzot.isim.service.service;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.service.ServiceApplicationInfo;

public interface ServiceApplicationInfoService extends IService<ServiceApplicationInfo> {


    ServiceApplicationInfo insertOrUpdateById(ServiceApplicationInfo info);

    ServiceApplicationInfo getByServiceId(String serviceId);

    Boolean isExistsSameApplicationName(String serviceId,String name);

    Boolean isExistsSameApplicationHostName(String serviceId,String name);


}
