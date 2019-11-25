package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.dao.service.ServiceResponseParamsDao;
import com.hzot.isim.entity.service.ServiceResponseParams;
import com.hzot.isim.service.service.ServiceResponseParamsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ClassName: ServiceResponseParamsServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-23 14:25
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceResponseParamsServiceImpl extends ServiceImpl<ServiceResponseParamsDao, ServiceResponseParams> implements ServiceResponseParamsService {


}
