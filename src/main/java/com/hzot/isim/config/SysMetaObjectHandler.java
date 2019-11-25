package com.hzot.isim.config;

import com.baomidou.mybatisplus.mapper.MetaObjectHandler;
import com.hzot.isim.base.MySysUser;
import org.apache.ibatis.reflection.MetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * mybatisplus自定义填充公共字段 ,即没有传的字段自动填充
 * @author chen
 */
@Component
public class SysMetaObjectHandler extends MetaObjectHandler {

    private Logger logger = LoggerFactory.getLogger(getClass());

    //新增填充
    @Override
    public void insertFill(MetaObject metaObject) {
        logger.info("正在调用该insert填充字段方法");
        Object createTime = getFieldValByName("createTime",metaObject);
        Object createId = getFieldValByName("createId",metaObject);
        Object updateTime = getFieldValByName("updateTime",metaObject);
        Object updateId = getFieldValByName("updateId",metaObject);


        if (null == createTime) {
            setFieldValByName("createTime", new Date(),metaObject);
        }
        if (null == createId) {
            if(MySysUser.CurrentUser() != null) {
                setFieldValByName("createId", MySysUser.id(), metaObject);
            }
        }
        if (null == updateTime) {
            setFieldValByName("updateTime", new Date(),metaObject);
        }
        if (null == updateId) {
            if(MySysUser.CurrentUser() != null) {
                setFieldValByName("updateId", MySysUser.id(), metaObject);
            }
        }
    }

    //更新填充
    @Override
    public void updateFill(MetaObject metaObject) {
        logger.info("正在调用该update填充字段方法");
        setFieldValByName("updateTime",new Date(), metaObject);
        Object updateId = getFieldValByName("updateId",metaObject);
        if (null == updateId) {
            setFieldValByName("updateId", MySysUser.id(), metaObject);
        }
    }
}
