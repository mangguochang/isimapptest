package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.dao.service.ServiceInfoDao;
import com.hzot.isim.entity.service.ServiceInfo;
import com.hzot.isim.service.service.ServiceInfoService;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

/**
 * @ClassName: ServiceInfoServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-22 14:27
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceInfoServiceImpl extends ServiceImpl<ServiceInfoDao, ServiceInfo> implements ServiceInfoService {


    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public ServiceInfo insertOrUpdateById(ServiceInfo info) {
        ServiceInfo newInfo = null;
        String serviceId = "";
        if(StringUtils.isBlank(info.getId())){
            serviceId = EntityIdPrefix.SERVICE_INFO+ UUID.randomUUID().toString();
            info.setId(serviceId);
            this.insert(info);
            newInfo = info;
        }else{
            ServiceInfo oldServiceInfo = this.selectById(info.getId());
            //更新服务名称
            oldServiceInfo.setServiceName(info.getServiceName());
            //设置服务版本
            oldServiceInfo.setVersion(info.getVersion());
            //设置服务所属分类
            oldServiceInfo.setServiceClass(info.getServiceClass());
            //设置服务所属分类-二级分类
            oldServiceInfo.setServiceSecondClass(info.getServiceSecondClass());
            //设置功能描述
            oldServiceInfo.setDescription(info.getDescription());
            //设置服务系统
            oldServiceInfo.setServiceSystem(info.getServiceSystem());
            this.updateById(oldServiceInfo);
            newInfo = oldServiceInfo;
        }

        return newInfo;
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void applyDeploy(String serviceId) throws Exception {
        ServiceInfo info = this.selectById(serviceId);
        if(info!=null){
            info.setDeploymentStatus(ServiceInfo.toBeDeployed);
            this.updateById(info);
        }else{
            throw new Exception("该服务不存在");
        }
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void reject(String serviceId) throws Exception {
        ServiceInfo info = this.selectById(serviceId);
        if(info!=null){
            info.setDeploymentStatus(ServiceInfo.reject);
            this.updateById(info);
        }else{
            throw new Exception("该服务不存在");
        }
    }

    @Override
    public Page<Map<String, Object>> getDeployedServiceInfoByUserPage(Page<Map<String, Object>> page, Map<String, Object> map) {
        return page.setRecords(this.baseMapper.getDeployedServiceInfoByUserPage(page,map));
    }

}
