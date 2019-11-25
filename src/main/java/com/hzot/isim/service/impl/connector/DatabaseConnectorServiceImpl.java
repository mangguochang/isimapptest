package com.hzot.isim.service.impl.connector;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.dao.connector.DatabaseConnectorDao;
import com.hzot.isim.entity.connector.DatabaseConnector;
import com.hzot.isim.service.connector.DatabaseConnectorService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * @ClassName: DatabaseConnectorServiceImpl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-09 16:57
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class DatabaseConnectorServiceImpl extends ServiceImpl<DatabaseConnectorDao, DatabaseConnector> implements DatabaseConnectorService {

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public DatabaseConnector saveDatabseInfo(DatabaseConnector dbInfo) {
        dbInfo.setId(EntityIdPrefix.SYS_DB_ID + UUID.randomUUID().toString());
        baseMapper.insert(dbInfo);
        return dbInfo;
    }

    @Override
    public DatabaseConnector getDatabseInfoById(String id) {
        DatabaseConnector dbInfo = baseMapper.selectById(id);
        return dbInfo;
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void updateDatabseInfo(DatabaseConnector dbInfo) {
        baseMapper.updateById(dbInfo);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteDatabseInfo(DatabaseConnector dbInfo) {
        baseMapper.deleteById(dbInfo);
    }

}
