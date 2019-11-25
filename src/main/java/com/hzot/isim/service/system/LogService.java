package com.hzot.isim.service.system;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.system.Log;

import java.util.List;

/**
 * <p>
 * 系统日志 服务类
 * </p>
 *
 * @author system_user
 * @since 2018-01-13
 */
public interface LogService extends IService<Log> {

    public List<Integer> selectSelfMonthData();

}
