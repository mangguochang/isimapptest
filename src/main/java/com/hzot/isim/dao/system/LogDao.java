package com.hzot.isim.dao.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.hzot.isim.entity.system.Log;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统日志 Mapper 接口
 * </p>
 *
 * @author system_user
 * @since 2018-01-14
 */
public interface LogDao extends BaseMapper<Log> {

    List<Map> selectSelfMonthData();
}
