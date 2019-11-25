package com.hzot.isim.controller.project.serverManage;

import com.hzot.isim.BaseTestClass;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.service.ServiceAuthInfo;
import com.hzot.isim.service.service.ServiceAuthInfoService;
import com.hzot.isim.util.RestResponse;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.UUID;

import static org.junit.Assert.*;

public class ServiceInfoAuthorizationControllerTest extends BaseTestClass {

    @Autowired
    private ServiceAuthInfoService authInfoService;

    private ServiceAuthInfo serviceAuthInfo;

    @Before
    public void setUp() throws Exception {
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        serviceAuthInfo = new ServiceAuthInfo();
        serviceAuthInfo.setId(EntityIdPrefix.SERVICE_AUTH_INFO+ UUID.randomUUID().toString());
        authInfoService.insert(serviceAuthInfo);
    }

    @After
    public void tearDown() throws Exception {
        authInfoService.deleteById(serviceAuthInfo);
    }

    @Test
    public void list() throws Exception {
        getPage("/service/authorization/list");
    }

    @Test
    public void listData() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("pageNumber","1");
        params.add("pageSize","10");

        RestResponse data = getRestDataByPost("/service/authorization/list",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void authorize() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",serviceAuthInfo.getId());

        RestResponse data = getRestDataByPost("/service/authorization/authorize",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void reject() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",serviceAuthInfo.getId());

        RestResponse data = getRestDataByPost("/service/authorization/reject",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void cancel() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",serviceAuthInfo.getId());

        RestResponse data = getRestDataByPost("/service/authorization/cancel",params);
        Assert.assertTrue(data.isSuccess());
    }
}