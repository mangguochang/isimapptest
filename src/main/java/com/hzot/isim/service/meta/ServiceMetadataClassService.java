package com.hzot.isim.service.meta;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.meta.ServiceMetadataClass;

import java.util.List;
import java.util.Map;

/**
*@Description: 服务元数据 服务类
*@Author: lolipopjy
*@date: 2019/10/17 10:09
*/
public interface ServiceMetadataClassService extends IService<ServiceMetadataClass> {

    List<ServiceMetadataClass> getMetaFirstLevel();

    List<Map<String,Object>> getSelectOption();

}
