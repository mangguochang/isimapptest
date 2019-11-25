package com.hzot.isim.service.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.service.ServiceAuthInfo;

import java.util.Map;

/**
 * @ClassName: ServiceAuthInfoService
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-12 17:19
 */
public interface ServiceAuthInfoService extends IService<ServiceAuthInfo> {

    void apply(String serviceId) throws Exception;

    void cancel(String serviceId) throws Exception;

    void reject(String serviceId) throws Exception;

    ServiceAuthInfo getByServiceId(String serviceId);

    void authorize(String serviceId) throws Exception;

    Page<Map<String,Object>> getServiceAuthInfoByPage(Page<Map<String, Object>> page, Map<String,Object> map);

}
