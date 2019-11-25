package com.hzot.isim.dao.service;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.dao.provider.ServiceInfoBasicProvider;
import com.hzot.isim.entity.service.ServiceAuthInfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.SelectProvider;

import java.util.List;
import java.util.Map;

public interface ServiceAuthInfoDao extends BaseMapper<ServiceAuthInfo> {

    @SelectProvider(type= ServiceInfoBasicProvider.class,method="getServiceAuthInfoByPage")
    List<Map<String,Object>> getServiceAuthInfoByPage(@Param(value="page") Page<Map<String, Object>> page, @Param(value="map") Map<String,Object> map);


}
