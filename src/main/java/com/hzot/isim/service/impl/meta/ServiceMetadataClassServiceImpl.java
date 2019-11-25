package com.hzot.isim.service.impl.meta;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.dao.meta.ServiceMetadataClassDao;
import com.hzot.isim.entity.meta.ServiceMetadataClass;
import com.hzot.isim.service.meta.ServiceMetadataClassService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: ServiceMetadataClassServiceImpl
 * @Description: 服务元数据实现类
 * @Author: lolipopjy
 * @Date: 2019-10-17 10:13
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ServiceMetadataClassServiceImpl extends ServiceImpl<ServiceMetadataClassDao, ServiceMetadataClass> implements ServiceMetadataClassService {

    /**
    *@Description: 获取元数据第一层
    *@Param: []
    *@Author: lolipopjy
    *@date: 2019/10/24 15:19
    *@return:
    */
    @Override
    public List<ServiceMetadataClass> getMetaFirstLevel() {
        EntityWrapper<ServiceMetadataClass> wrapper = new EntityWrapper<>();
        wrapper.isNull("pid");
        return this.selectList(wrapper);
    }

    @Override
    public List<Map<String, Object>> getSelectOption() {
        EntityWrapper<ServiceMetadataClass> wrapper = new EntityWrapper<>();
        wrapper.setSqlSelect("id,name");
        return this.selectMaps(wrapper);
    }

}
