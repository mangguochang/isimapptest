package com.hzot.isim.controller.project.serverManage;

import com.hzot.isim.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName: ServiceCamelInfoController
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-14 14:18
 */
@RequestMapping("/service/camel")
@Controller
public class ServiceCamelInfoController extends BaseController {

    /**
     *@Description: 获取服务对应的Camel application.properties配置信息
     *@Param: [serviceId]
     *@Author: lolipopjy
     *@date: 2019/10/31 17:22
     *@return:
     */
    @PostMapping("/getCamelProperties")
    @ResponseBody
    public String getCamelProperties(String serviceId,String serviceType) {
        String content = serviceCamelInfoService.getCamelProperties(serviceId,serviceType);
        return content;
    }

    /**
     *@Description: 获取服务对应的Camel componetConfig.properties配置信息
     *@Param: [serviceId]
     *@Author: lolipopjy
     *@date: 2019/11/1 09:57
     *@return:
     */
    @PostMapping("/getCamelComponentProperties")
    @ResponseBody
    public String getCamelComponentProperties(String serviceId) {
        String content = serviceCamelInfoService.getCamelComponentProperties(serviceId);
        return content;
    }

    /**
     *@Description: 获取服务对应的Camel cxfEndpointConfig.xml配置信息
     *@Param: [serviceId]
     *@Author: lolipopjy
     *@date: 2019/11/1 09:57
     *@return:
     */
    @PostMapping("/getCamelCxfConfigPropertiesInfo")
    @ResponseBody
    public String getCamelCxfConfigPropertiesInfo(String serviceId) {
        String content = serviceCamelInfoService.getCamelCxfConfigPropertiesInfo(serviceId);
        return content;
    }

}
