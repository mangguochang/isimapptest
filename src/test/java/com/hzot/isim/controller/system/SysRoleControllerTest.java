package com.hzot.isim.controller.system;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.hzot.isim.BaseTestClass;
import com.hzot.isim.constant.EntityIdPrefix;
import com.hzot.isim.entity.system.SysRole;
import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.service.system.SysRoleService;
import com.hzot.isim.service.system.SysUserService;
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

import java.util.*;

public class SysRoleControllerTest extends BaseTestClass {

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysUserService sysUserService;

    private String roleName;

    private SysRole sysRole;

    private List<SysUser> users;

    @Before
    public void setUp() throws Exception {
        //初始化mock
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        //新建临时测试对象
        sysRole = new SysRole();
        sysRole.setId(EntityIdPrefix.SYS_ROLE+ UUID.randomUUID().toString());
        sysRoleService.insert(sysRole);
    }

    @After
    public void tearDown() throws Exception {
        sysRoleService.deleteById(sysRole);
        if(users!=null){
            sysUserService.deleteBatchIds(users);
        }
    }

    @Test
    public void list() throws Exception {
        getPage("/admin/system/role/list");
    }

    @Test
    public void listData() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("pageNumber","1");
        params.add("pageSize","10");

        MvcResult mvcResult = getDataByPost("/service/authorization/list",params);
        int status = mvcResult.getResponse().getStatus();
        Assert.assertEquals(200,status);
    }

    @Test
    public void add() throws Exception {
        getPage("/admin/system/role/add");
    }

    @Test
    public void addData() throws Exception {
        roleName = "temp:"+ UUID.randomUUID().toString();
        SysRole sysRole = new SysRole();
        sysRole.setRoleName(roleName);

        String requestJson = JSON.toJSONString(sysRole);
        getRestDataByPost("/admin/system/role/add",requestJson);
    }

    @Test
    public void edit() throws Exception {
        getPage("/admin/system/role/edit");
    }

    @Test
    public void editData() throws Exception {SysRole sysRole = new SysRole();
        sysRole.setRoleName("update name "+roleName);

        String requestJson = JSON.toJSONString(sysRole);
        getRestDataByPost("/admin/system/role/add",requestJson);
    }

    @Test
    public void delete() throws Exception {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("id",sysRole.getId());

        getRestDataByPost("/admin/system/role/delete",params);
    }

    @Test
    public void deleteSome() throws Exception {
        List<SysRole> roles = new ArrayList<>();
        roles.add(sysRole);

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(roles);

        RestResponse data =  getRestDataByPost("/admin/system/role/deleteSome",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void addSomeMember() throws Exception {
        Map<String,Object> params = new HashMap<>();
        SysUser user = new SysUser();
        user.setId(EntityIdPrefix.SYS_USER+UUID.randomUUID().toString());
        users.add(user);
        sysUserService.insertBatch(users);

        params.put("userList",users);
        params.put("roleId",sysRole.getId());

        ObjectMapper mapper = new ObjectMapper();
        ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
        String requestJson = ow.writeValueAsString(params);

        RestResponse data =  getRestDataByPost("/admin/system/role/addSomeMember",requestJson);
        Assert.assertTrue(data.isSuccess());
    }

    @Test
    public void member() {
    }

    @Test
    public void member1() {
    }

    @Test
    public void addMember() {
    }

    @Test
    public void addMember1() {
    }

    @Test
    public void deleteMember() {
    }
}