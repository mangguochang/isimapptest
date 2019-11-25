package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.dao.service.ServiceRequestParamsDao;
import com.hzot.isim.entity.service.ServiceRequestParams;
import com.hzot.isim.service.service.ServiceRequestParamsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ClassName: ServiceRequestParamsServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-22 16:01
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceRequestParamsServiceImpl extends ServiceImpl<ServiceRequestParamsDao, ServiceRequestParams> implements ServiceRequestParamsService {


}
