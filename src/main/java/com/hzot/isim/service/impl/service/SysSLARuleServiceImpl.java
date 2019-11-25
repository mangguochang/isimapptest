package com.hzot.isim.service.impl.service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.dao.service.SysSLARuleDao;
import com.hzot.isim.entity.service.SysSLARule;
import com.hzot.isim.service.service.SysSLARuleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ClassName: SysSLARuleServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-16 13:56
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysSLARuleServiceImpl extends ServiceImpl<SysSLARuleDao, SysSLARule> implements SysSLARuleService {







}
