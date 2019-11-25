package com.hzot.isim.service.meta;


import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.meta.SysNameList;

import java.util.List;
import java.util.Map;

/**
 *@Description: 外围系统列表信息 服务类
 *@Author: lolipopjy
 *@date: 2019/10/24 16:38
 */
public interface SysNameListService extends IService<SysNameList> {

    SysNameList getSysNameListById(String id);

    List<Map<String,Object>> getSysNameListSelectOption();

}
