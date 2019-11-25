package com.hzot.isim.service.service;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.VO.ServiceInfoVO;
import com.hzot.isim.entity.service.ServiceInfo;
import com.hzot.isim.entity.service.ServiceInterfaceInfo;

import java.io.IOException;
import java.util.Map;

public interface ServiceInterfaceInfoService extends IService<ServiceInterfaceInfo> {

    void saveOrUpdate(ServiceInfoVO serviceInfoVO) throws Exception;

    ServiceInterfaceInfo insertOrUpdateById(ServiceInterfaceInfo info);

    ServiceInterfaceInfo getByServiceId(String serviceId);

    Map<String,Object> getServiceInfoById(String serviceId) throws IOException;

}
