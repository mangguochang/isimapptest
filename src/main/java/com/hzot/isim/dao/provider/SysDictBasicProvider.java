package com.hzot.isim.dao.provider;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: SysDictBasicProvider
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-07-01 10:02
 */
public class SysDictBasicProvider {

    /**
    *@Description:分页过滤查询数据字典
    *@Param: [para]
    *@Author: lolipopjy
    *@date: 2019/7/1 10:03
    *@return:
    */
    public String getDictByPage(Map<String, Object> params){
        String baseSQL = "SELECT dict.*,dict.create_by as createId ,dict.update_by as updateId,p.label as \"parentNode\" ,p.id as \"parentId\"  FROM sys_dict dict left join sys_dict p on p.id=dict.parent_id ";
        Map<String,Object> map = (Map<String, Object>) params.get("map");
        String label=(String)map.get("label");
        baseSQL += " where 1=1 ";
        if(StringUtils.isNotBlank(label)){
            baseSQL += " and dict.label  like '%"+label+"%'";
        }
        String code = (String) map.get("code");
        if(StringUtils.isNotBlank(code)) {
            baseSQL += " and dict.code like '%"+code+"%'";
        }
        String parentId = (String) map.get("parentId");
        if(StringUtils.isNotBlank(parentId)) {
            baseSQL += " and dict.parent_id ='"+parentId+"'";
        }
        baseSQL +=" order by dict.create_time,dict.sort desc";
        return baseSQL;
    }


    public String getLinkedCodeInfo(Map<String, Object> params){
        List<String> subSQL = new ArrayList<>();
        //组织机构表
        subSQL.add(" select 1 from frame_organization where org_type = dict.code ");
        //组织机构内设部门表
        subSQL.add("select 1 from frame_org_dept where dept_type = dict.code");
        //业务架构-业务域
        subSQL.add("select 1 from frame_business where bus_type = dict.code");
        //业务架构登记-业务域-业务事项
        subSQL.add("select 1 from frame_business_item where item_type = dict.code");
        //业务架构登记-用户视图
        subSQL.add("select 1 from frame_user_view where view_type = dict.code");
        //业务架构登记-用户视图-视图组成
        subSQL.add("select 1 from frame_user_view_item where item_type = dict.code");
        //数据架构登记-概念主题
        subSQL.add("select 1 from frame_data_virtual_theme where vtheme_type = dict.code or vtheme_modeling_type = dict.code");
        //数据架构登记-逻辑实体-实体属性
        subSQL.add("select 1 from frame_data_logic_entity_item where le_item_type = dict.code");
        //应用架构登记-物理子系统
        subSQL.add("select 1 from frame_app_physical_sub_system where pss_level = dict.code or " +
                " pss_stage = dict.code or  pss_dev_model = dict.code");
        //应用架构登记-物理子系统-应用功能
        subSQL.add("select 1 from frame_app_pss_function where func_class = dict.code ");
        //应用架构登记-物理子系统-集成需求
        subSQL.add("select 1 from frame_app_pss_demand where demand_complexity = dict.code or demand_priority  = dict.code ");
        //知识库管理
        subSQL.add("select 1 from frame_attachment where att_type = dict.code ");

        StringBuffer sql = new StringBuffer();
        sql.append("select * from ( ");
        sql.append("select code from sys_dict dict where   ");
        for(int i = 0; i<subSQL.size();i++){
            if(i == 0){
                sql.append(" exists ("+subSQL.get(i)+") ");
            }else{
                sql.append(" or exists ("+subSQL.get(i)+") ");
            }
        }
        sql.append(" ) dictAll where dictAll.code = #{code} ");
        System.out.println(sql.toString());
        return sql.toString();
    }

}



