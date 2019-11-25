package com.hzot.isim.service.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.service.ServiceInfo;

import java.util.Map;

public interface ServiceInfoService extends IService<ServiceInfo> {

    ServiceInfo insertOrUpdateById(ServiceInfo info);

    void applyDeploy(String serviceId) throws Exception;

    void reject(String serviceId) throws Exception;

    Page<Map<String,Object>> getDeployedServiceInfoByUserPage(Page<Map<String, Object>> page, Map<String,Object> map);

}
