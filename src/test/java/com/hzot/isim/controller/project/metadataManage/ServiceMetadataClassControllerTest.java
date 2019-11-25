package com.hzot.isim.controller.project.metadataManage;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.hzot.isim.BaseTestClass;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.connector.DatabaseConnector;
import com.hzot.isim.entity.meta.ServiceMetadataClass;
import com.hzot.isim.service.meta.ServiceMetadataClassService;
import com.hzot.isim.util.RestResponse;
import org.junit.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static org.junit.Assert.*;

public class ServiceMetadataClassControllerTest extends BaseTestClass {

    @Autowired
    private ServiceMetadataClassService serviceMetadataClassService;

    private ServiceMetadataClass serviceMetadataClass;

    //add方法新建对象名称
    private static String metaName;

    @Before
    public void setUp() throws Exception {
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        //新建临时测试对象
        serviceMetadataClass = new ServiceMetadataClass();
        serviceMetadataClass.setId(EntityIdPrefix.SYS_META_CLASS+UUID.randomUUID().toString());
        serviceMetadataClassService.insert(serviceMetadataClass);
    }

    @After
    public void tearDown() throws Exception {
        serviceMetadataClassService.deleteById(serviceMetadataClass);
        if(metaName!=null){
            //删除add()方法新建的对象
            Map<String,Object> filter = new HashMap<>();
            filter.put("name",metaName);
            serviceMetadataClassService.deleteByMap(filter);
        }
    }


    @Test
    public void list() throws Exception {
        getPage("/metadata/list");
    }

    @Test
    public void listData() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();

        RestResponse data = getRestDataByPost("/metadata/list",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void add() throws Exception {
        //新建测试对象
        metaName = "test:"+ UUID.randomUUID().toString();
        ServiceMetadataClass metadataClass = new ServiceMetadataClass();
        metadataClass.setName(metaName);

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(metadataClass);

        RestResponse data = getRestDataByPost("/metadata/add",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void edit() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",serviceMetadataClass.getId());

        RestResponse data = getRestDataByGet("/metadata/edit",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void editData() throws Exception {
        serviceMetadataClass.setName("测试服务元数据");

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(serviceMetadataClass);
        RestResponse data = getRestDataByPost("/metadata/edit",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void delete() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",serviceMetadataClass.getId());

        RestResponse data = getRestDataByPost("/metadata/delete",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void getMetaFirstLevel() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();

        RestResponse data = getRestDataByPost("/metadata/getMetaFirstLevel",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void getChildMetaById() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("pid",serviceMetadataClass.getId());

        RestResponse data = getRestDataByPost("/metadata/getChildMetaById",params);
        Assert.assertTrue(data.isSuccess());

    }
}