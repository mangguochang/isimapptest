package com.hzot.isim.entity.meta;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: ServiceMetadataClass
 * @Description: 服务元数据分类表
 * @Author: lolipopjy
 * @Date: 2019-10-17 09:58
 */
@TableName("service_metadata_class")
public class ServiceMetadataClass extends DataEntity<ServiceMetadataClass> {

    private static final long serialVersionUID = 1L;

    /**
     * 元数据名称
     */
    @TableField("name")
    private String name;

    /**
     * 描述
     */
    @TableField("description")
    private String description;

    /**
     * 上级元数据ID
     */
    @TableField("pid")
    private String pid;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }
}
