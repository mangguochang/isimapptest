package com.hzot.isim.service.impl.meta;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.dao.meta.SysNameListDao;
import com.hzot.isim.entity.meta.SysNameList;
import com.hzot.isim.service.meta.SysNameListService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: SysNameListServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-24 16:43
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysNameListServiceImpl extends ServiceImpl<SysNameListDao, SysNameList> implements SysNameListService {

    @Override
    public SysNameList getSysNameListById(String id) {
        return this.selectById(id);
    }

    @Override
    public List<Map<String, Object>> getSysNameListSelectOption() {
        EntityWrapper<SysNameList> wrapper = new EntityWrapper<>();
        wrapper.setSqlSelect("id,name");
        return this.selectMaps(wrapper);
    }


}
