package com.hzot.isim.service.connector;

import com.baomidou.mybatisplus.service.IService;
import com.hzot.isim.entity.connector.DatabaseConnector;

/**
 * @ClassName: DatabaseConnectorService
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-09 16:53
 */
public interface DatabaseConnectorService extends IService<DatabaseConnector> {

    DatabaseConnector saveDatabseInfo(DatabaseConnector dbInfo);

    DatabaseConnector getDatabseInfoById(String id);

    void updateDatabseInfo(DatabaseConnector dbInfo);

    void deleteDatabseInfo(DatabaseConnector dbInfo);


}
