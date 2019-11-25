package com.hzot.isim.controller.project.serverManage;

import com.hzot.isim.BaseTestClass;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.meta.ServiceMetadataClass;
import com.hzot.isim.entity.service.ServiceCamelInfo;
import com.hzot.isim.service.service.ServiceCamelInfoService;
import com.hzot.isim.util.RestResponse;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static org.junit.Assert.*;

public class ServiceCamelInfoControllerTest extends BaseTestClass {

    @Autowired
    private ServiceCamelInfoService camelInfoService;

    private ServiceCamelInfo serviceCamelInfo;


    @Before
    public void setUp() throws Exception {
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        //新建临时测试对象
        serviceCamelInfo = new ServiceCamelInfo();
        serviceCamelInfo.setId(EntityIdPrefix.SERVICE_CAMEL_INFO+ UUID.randomUUID().toString());
        camelInfoService.insert(serviceCamelInfo);
    }

    @After
    public void tearDown() throws Exception {
        camelInfoService.deleteById(serviceCamelInfo);
    }

    @Test
    public void getCamelProperties() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("serviceId",serviceCamelInfo.getServiceId());
        params.add("serviceType",serviceCamelInfo.getPropertiesType());

        MvcResult mvcResult = getDataByPost("/service/camel/getCamelProperties",params);
    }

    @Test
    public void getCamelComponentProperties() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("serviceId",serviceCamelInfo.getServiceId());

        MvcResult mvcResult = getDataByPost("/service/camel/getCamelComponentProperties",params);
    }

    @Test
    public void getCamelCxfConfigPropertiesInfo() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("serviceId",serviceCamelInfo.getServiceId());

        MvcResult mvcResult = getDataByPost("/service/camel/getCamelCxfConfigPropertiesInfo",params);

    }
}