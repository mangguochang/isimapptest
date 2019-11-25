package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.dao.service.ServiceApplicationInfoDao;
import com.hzot.isim.entity.service.ServiceApplicationInfo;
import com.hzot.isim.service.service.ServiceApplicationInfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

/**
 * @ClassName: ServiceApplicationInfoServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-01 14:20
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceApplicationInfoServiceImpl extends ServiceImpl<ServiceApplicationInfoDao, ServiceApplicationInfo> implements ServiceApplicationInfoService {


    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public ServiceApplicationInfo insertOrUpdateById(ServiceApplicationInfo info) {
        ServiceApplicationInfo newInfo = null;
        String id = "";
        ServiceApplicationInfo oldServiceApplicationInfo = this.getByServiceId(info.getServiceId());
        if(oldServiceApplicationInfo==null){
            id = EntityIdPrefix.SERVICE_APP_INFO+ UUID.randomUUID().toString();
            info.setId(id);
            this.insert(info);
            newInfo = info;
        }else{
            //不更新主键
            info.setId(oldServiceApplicationInfo.getId());
            //不更新所属服务
            info.setServiceId(oldServiceApplicationInfo.getServiceId());
            //不更新创建人
            info.setCreateId(oldServiceApplicationInfo.getCreateId());
            //不更新创建时间
            info.setCreateTime(oldServiceApplicationInfo.getCreateTime());
            this.updateById(info);
            newInfo = info;
        }

        return newInfo;
    }

    @Override
    public ServiceApplicationInfo getByServiceId(String serviceId) {
        EntityWrapper<ServiceApplicationInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("service_id",serviceId);
        List<ServiceApplicationInfo> list = this.selectList(wrapper);
        if(list.size()>0){
            return list.get(0);
        }else{
            return null;
        }
    }

    @Override
    public Boolean isExistsSameApplicationName(String serviceId, String name) {
        EntityWrapper<ServiceApplicationInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("application_name",name);
        if(StringUtils.isNotBlank(serviceId)){
            wrapper.ne("service_id",serviceId);
        }
        List<ServiceApplicationInfo> infos = this.selectList(wrapper);
        if(infos.size()>0){
            return true;
        }
        return false;
    }

    @Override
    public Boolean isExistsSameApplicationHostName(String serviceId, String name) {
        EntityWrapper<ServiceApplicationInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("application_hostname",name);
        if(StringUtils.isNotBlank(serviceId)){
            wrapper.ne("service_id",serviceId);
        }
        List<ServiceApplicationInfo> infos = this.selectList(wrapper);
        if(infos.size()>0){
            return true;
        }
        return false;
    }
}
