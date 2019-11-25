package com.hzot.isim.dao.provider;

import org.apache.commons.lang3.StringUtils;

import java.util.Map;

/**
 * @ClassName: ServiceInfoBasicProvider
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-18 14:38
 */
public class ServiceInfoBasicProvider {

    /**
    *@Description: 分页过滤查询服务授权信息
    *@Param: [params]
    *@Author: lolipopjy
    *@date: 2019/11/18 14:39
    *@return:
    */
    public String getServiceAuthInfoByPage(Map<String, Object> params){
        String baseSql = "select auth.id,auth.authorization_code authorizationCode," +
                " auth.authorization_time authorizationTime," +
                " auth.create_time createTime," +
                " auth.create_by createId," +
                " auth.auth_status authStatus," +
                " info.id serviceId," +
                " info.service_system serviceSystem," +
                " info.service_name serviceName ," +
                " info.service_class serviceClass, " +
                " info.service_second_class serviceSecondClass, " +
                " sii.service_type serviceType " +
                " from service_auth_info auth ,service_info info ,service_interface_info sii" +
                " where  auth.service_id = info.id and sii.service_id = info.id order by auth.create_time desc";
        return baseSql;
    }

    /**
    *@Description: 分页过滤查询已发布的服务信息
    *@Param: [params]
    *@Author: lolipopjy
    *@date: 2019/11/18 14:39
    *@return:
    */
    public String getDeployedServiceInfoByUserPage(Map<String, Object> params){
        Map<String,Object> map = (Map<String, Object>) params.get("map");
        String userId = "";
        if(map.containsKey("userId")){
            userId = (String) map.get("userId");
        }
        String baseSql = "select info.id," +
                " info.service_name serviceName ," +
                " info.service_second_class serviceSecondClass," +
                " info.service_system serviceSystem," +
                " sai.id authId , " +
                " sai.authorization_code authorizationCode , " +
                " sai.auth_status authStatus , " +
                " sai.create_time createTime  " +
                " from  service_info info left join service_auth_info sai  " +
                " on info.id = sai.service_id and sai.create_by = '"+userId+"' " +
                " left join service_interface_info sii on sii.service_id = info.id " +
                //获取已经发布/更新发布的服务信息
                " where info.deployment_status is not null and info.deployment_status = 1 or info.deployment_status = 2  " +
                " order by info.create_time desc";
        return baseSql;
    }
}
