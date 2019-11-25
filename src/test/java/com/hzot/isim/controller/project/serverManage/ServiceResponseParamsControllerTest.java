package com.hzot.isim.controller.project.serverManage;

import com.hzot.isim.BaseTestClass;
import com.hzot.isim.util.RestResponse;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import static org.junit.Assert.*;

public class ServiceResponseParamsControllerTest extends BaseTestClass {

    @Before
    public void setUp() throws Exception {
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void list() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("pageNumber","1");
        params.add("pageSize","10");

        RestResponse data = getRestDataByPost("/service/response/list",params);
        Assert.assertTrue(data.isSuccess());
    }
}