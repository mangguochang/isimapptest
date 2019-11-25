package com.hzot.isim.controller.project.connectorManage;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.hzot.isim.BaseTestClass;
import com.hzot.isim.entity.connector.DatabaseConnector;
import com.hzot.isim.service.connector.DatabaseConnectorService;
import com.hzot.isim.util.RestResponse;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

public class DatabaseConnectorControllerTest extends BaseTestClass {

    @Autowired
    private DatabaseConnectorService connectorService;

    @Autowired
    DataSourceProperties dataSource;


    private DatabaseConnector connector;

    @Before
    public void setUp() throws Exception{
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        //新建临时测试对象
        connector = connectorService.saveDatabseInfo(new DatabaseConnector());
    }

    @After
    public void tearDown() throws Exception {
        //删除测试所建的对象
        connectorService.deleteById(connector.getId());
    }

    @Test
    public void list() throws Exception{
        getPage("/dbConn/list");
    }

    @Test
    public void listData() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("pageNumber","1");
        params.add("pageSize","10");

        RestResponse data = getRestDataByPost("/dbConn/list",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void add() throws Exception {
        getPage("/dbConn/add");
    }

    @Test
    public void addData() throws Exception {
        DatabaseConnector dbInfo =  new DatabaseConnector();
        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(dbInfo);

        RestResponse data = getRestDataByPost("/dbConn/add",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void edit() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",connector.getId());

        getPage("/dbConn/edit",params);
    }

    @Test
    public void editData() throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(connector);

        RestResponse data = getRestDataByPost("/dbConn/edit",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void delete() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",connector.getId());

        RestResponse data = getRestDataByPost("/dbConn/delete",params);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void deleteSome() throws Exception {
        List<DatabaseConnector> connectors = new ArrayList<>();
        connectors.add(connector);

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(connectors);

        RestResponse data =  getRestDataByPost("/dbConn/deleteSome",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void testLink() throws Exception {
        //获取项目配置的数据库连接地址，测试数据库连通性
        DatabaseConnector connector = getLocalDB();

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(connector);

        RestResponse data = getRestDataByPost("/dbConn/testLink",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void testLinkById() throws Exception {
        connectorService.updateDatabseInfo(getLocalDB());

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",connector.getId());

        RestResponse data = getRestDataByPost("/dbConn/testLinkById",params);
        Assert.assertTrue(data.isSuccess());

    }


    @Test
    public void getDBInfoByType() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("dbType",connector.getDbType());

        RestResponse data = getRestDataByPost("/dbConn/getDBInfoByType",params);
        Assert.assertTrue(data.isSuccess());
    }

    private DatabaseConnector getLocalDB(){
        //获取项目配置的数据库连接地址，测试数据库连通性
        URI uri = URI.create(dataSource.getUrl().substring(5));
        String path = uri.getPath();
        connector.setDbName(path.substring(1,path.length()));
        connector.setDbType(uri.getScheme());
        connector.setHost(uri.getHost());
        connector.setPort(uri.getPort());
        connector.setUserName(dataSource.getUsername());
        connector.setPassword(dataSource.getPassword());
        return connector;
    }

}