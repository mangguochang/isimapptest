package com.hzot.isim.service.impl.system;

import com.hzot.isim.entity.system.QuartzTaskLog;
import com.hzot.isim.dao.system.QuartzTaskLogDao;
import com.hzot.isim.service.system.QuartzTaskLogService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 任务执行日志 服务实现类
 * </p>
 *
 * @author system_user
 * @since 2018-01-25
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class QuartzTaskLogServiceImpl extends ServiceImpl<QuartzTaskLogDao, QuartzTaskLog> implements QuartzTaskLogService {

}
