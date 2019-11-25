package com.hzot.isim.controller.project.serverManage;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.hzot.isim.BaseTestClass;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.service.ServiceCamelInfo;
import com.hzot.isim.entity.service.SysSLARule;
import com.hzot.isim.service.service.SysSLARuleService;
import com.hzot.isim.util.RestResponse;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static org.junit.Assert.*;

public class SLARuleControllerTest extends BaseTestClass {

    @Autowired
    private SysSLARuleService sysSLARuleService;

    private SysSLARule sysSLARule;

    private String ruleName;

    @Before
    public void setUp() throws Exception {
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        //新建临时测试对象
        sysSLARule = new SysSLARule();
        sysSLARule.setId(EntityIdPrefix.SYS_SLA+ UUID.randomUUID().toString());
        sysSLARuleService.insert(sysSLARule);
    }

    @After
    public void tearDown() throws Exception {
        sysSLARuleService.deleteById(sysSLARule);
        if(ruleName!=null){
            //删除add()方法新建的对象
            Map<String,Object> filter = new HashMap<>();
            filter.put("rule_name",ruleName);
            sysSLARuleService.deleteByMap(filter);
        }
    }

    @Test
    public void slaList() throws Exception {
        getPage("/service/sla/slaList");
    }

    @Test
    public void list() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("pageNumber","1");
        params.add("pageSize","10");

        RestResponse data = getRestDataByPost("/service/sla/slaList",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void add() throws Exception {
        ruleName = "temp:"+UUID.randomUUID().toString();
        SysSLARule sysSLARule = new SysSLARule();
        sysSLARule.setRuleName(ruleName);

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(sysSLARule);

        RestResponse data = getRestDataByPost("/service/sla/add",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void edit() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",sysSLARule.getId());

        RestResponse data = getRestDataByGet("/service/sla/edit",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void editData() throws Exception {
        sysSLARule.setRuleName("更新规则名称");

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(sysSLARule);

        RestResponse data = getRestDataByPost("/service/sla/edit",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void delete() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",sysSLARule.getId());

        RestResponse data = getRestDataByPost("/service/sla/delete",params);
        Assert.assertTrue(data.isSuccess());
    }
}