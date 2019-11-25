package com.hzot.isim.entity.meta;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: SysNameList
 * @Description: 外围系统列表信息
 * @Author: lolipopjy
 * @Date: 2019-10-24 16:15
 */
@TableName("sys_name_list")
public class SysNameList extends DataEntity<SysNameList> {

    private static final long serialVersionUID = 1L;

    /**
     * 系统名称
     */
    @TableField("name")
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
