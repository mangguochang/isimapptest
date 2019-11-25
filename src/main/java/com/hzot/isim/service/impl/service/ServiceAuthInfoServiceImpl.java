package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.base.MySysUser;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.dao.service.ServiceAuthInfoDao;
import com.hzot.isim.entity.service.ServiceAuthInfo;
import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.jwt.JWTUtil;
import com.hzot.isim.service.service.ServiceAuthInfoService;
import com.hzot.isim.service.system.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @ClassName: ServiceAuthInfoServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-12 17:20
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceAuthInfoServiceImpl extends ServiceImpl<ServiceAuthInfoDao, ServiceAuthInfo> implements ServiceAuthInfoService {

    @Autowired
    protected SysUserService sysUserService;

    @Autowired
    public JWTUtil jwtUtil;

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void apply(String serviceId) throws Exception {
        ServiceAuthInfo authInfo = getServiceAuthInfoByServiceId(serviceId);
        if(authInfo!=null){
            Integer authStatus = authInfo.getAuthStatus();
            //允许被拒绝/被取消的重新申请
            if(ServiceAuthInfo.cancel==authStatus||ServiceAuthInfo.reject==authStatus){
                authInfo.setAuthStatus(ServiceAuthInfo.apply);
                this.updateById(authInfo);
            }else{
                throw new Exception("不能重复申请");
            }
        }else{
            ServiceAuthInfo info = new ServiceAuthInfo();
            info.setId(EntityIdPrefix.SERVICE_AUTH_INFO+ UUID.randomUUID().toString());
            info.setServiceId(serviceId);
            info.setAuthStatus(ServiceAuthInfo.apply);
            this.insert(info);
        }
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void cancel(String id) throws Exception {
        ServiceAuthInfo authInfo = this.selectById(id);
        if(authInfo!=null){
            authInfo.setAuthStatus(ServiceAuthInfo.cancel);
            this.updateById(authInfo);
        }else{
            throw new Exception("该服务不存在");
        }
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void reject(String id) throws Exception {
        ServiceAuthInfo authInfo = this.selectById(id);
        if(authInfo!=null){
            authInfo.setAuthStatus(ServiceAuthInfo.reject);
            this.updateById(authInfo);
        }else{
            throw new Exception("该服务不存在");
        }
    }

    @Override
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void authorize(String id) throws Exception {
        ServiceAuthInfo authInfo = this.selectById(id);
        if(authInfo!=null){
            authInfo.setAuthStatus(ServiceAuthInfo.approved);
            authInfo.setAuthorizationTime(new Date());
            //JWT加密
            SysUser user = sysUserService.selectById(authInfo.getCreateId());
            if(user!=null){
                String token = jwtUtil.getTaiTicket(user.getLoginName());
                authInfo.setAuthorizationCode(token);
            }
            this.updateById(authInfo);
        }else {
            throw new Exception("该服务申请不存在");
        }
    }

    @Override
    public Page<Map<String,Object>> getServiceAuthInfoByPage(Page<Map<String, Object>> page, Map<String,Object> map) {
        return page.setRecords(this.baseMapper.getServiceAuthInfoByPage(page,map));
    }

    /*
    *@Description: 通过服务ID获取服务授权信息
    *@Param: [serviceId]
    *@Author: lolipopjy
    *@date: 2019/11/19 15:05
    *@return:
    */
    private ServiceAuthInfo getServiceAuthInfoByServiceId(String serviceId){
        ServiceAuthInfo authInfo = null;
        EntityWrapper<ServiceAuthInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("create_by", MySysUser.id());
        wrapper.eq("service_id", serviceId);
        List<ServiceAuthInfo> list = this.selectList(wrapper);
        if(list.size()>0){
            authInfo = list.get(0);
        }
        return authInfo;
    }

    @Override
    public ServiceAuthInfo getByServiceId(String serviceId) {
        EntityWrapper<ServiceAuthInfo> wrapper = new EntityWrapper<>();
        wrapper.eq("service_id",serviceId);
        List<ServiceAuthInfo> list = this.selectList(wrapper);
        if(list.size()>0){
            return list.get(0);
        }else{
            return null;
        }
    }
}
