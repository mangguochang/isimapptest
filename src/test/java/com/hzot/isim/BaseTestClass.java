package com.hzot.isim;

import com.alibaba.fastjson.JSON;
import com.hzot.isim.util.RestResponse;
import org.junit.Assert;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

/**
 * @ClassName: BaseTestClass
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-11-21 09:42
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = ISIMApplication.class)
@WebAppConfiguration
public class BaseTestClass {

    @Autowired
    protected WebApplicationContext webApplicationContext;

    protected MockMvc mockMvc;

    /**
    *@Description: 通过GET请求获取请求页面
    *@Param: [urlTemplate]
    *@Author: lolipopjy
    *@date: 2019/11/21 9:55
    *@return:
    */
    public void getPage(String urlTemplate) throws Exception {
        MvcResult mvcResult= mockMvc.perform(MockMvcRequestBuilders.get(urlTemplate)
                .accept(MediaType.TEXT_HTML_VALUE))
                //是否打印内容到控制台
                //.andDo(print())
                .andReturn();
        int status = mvcResult.getResponse().getStatus();
        Assert.assertEquals(200,status);
    }

    /**
    *@Description: 通过GET请求获取请求页面
    *@Param: [urlTemplate, params]
    *@Author: lolipopjy
    *@date: 2019/11/21 10:11
    *@return:
    */
    public void getPage(String urlTemplate,MultiValueMap<String,String> params) throws Exception {
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get(urlTemplate)
                .accept(MediaType.APPLICATION_JSON).params(params))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andDo(print())
                .andReturn();
        int status = mvcResult.getResponse().getStatus();
        Assert.assertEquals(200,status);
    }


    /**
     *@Description: 通过POST请求获取请求数据
     *@Param: [urlTemplate, params]
     *@Author: lolipopjy
     *@date: 2019/11/21 9:55
    *@return:
    */
    public MvcResult getDataByPost(String urlTemplate, MultiValueMap<String,String> params) throws Exception {
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post(urlTemplate)
                .accept(MediaType.APPLICATION_JSON).params(params))
                .andExpect(MockMvcResultMatchers.status().isOk())
                //是否打印内容到控制台
                //.andDo(print())
                .andReturn();
        return mvcResult;
    }


    /**
     *@Description: 通过POST请求获取请求数据
     *@Param: [urlTemplate, requestJson]
     *@Author: lolipopjy
     *@date: 2019/11/21 10:08
     *@return:
     */
    public MvcResult getDataByPost(String urlTemplate,String requestJson) throws Exception {
        MvcResult mvcResult= mockMvc.perform(MockMvcRequestBuilders
                .post(urlTemplate)
                .contentType(MediaType.APPLICATION_JSON)
                .content(requestJson))
                .andDo(print())
                .andReturn();
        return mvcResult;
    }


    /**
     *@Description: 通过GET请求获取请求数据
     *@Param: [urlTemplate, params]
     *@Author: lolipopjy
     *@date: 2019/11/21 15:55
     *@return:
     */
    public MvcResult getDataByGet(String urlTemplate,MultiValueMap<String,String> params) throws Exception {
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get(urlTemplate)
                .accept(MediaType.APPLICATION_JSON).params(params))
                .andExpect(MockMvcResultMatchers.status().isOk())
                //是否打印内容到控制台
                //.andDo(print())
                .andReturn();
        return mvcResult;
    }

    /**
    *@Description: 通过POST请求获取请求数据
    *@Param: [urlTemplate, params]
    *@Author: lolipopjy
    *@date: 2019/11/21 9:55
    *@return:
    */
    public RestResponse getRestDataByPost(String urlTemplate,MultiValueMap<String,String> params) throws Exception {
        MvcResult mvcResult = getDataByPost(urlTemplate,params);
        int status = mvcResult.getResponse().getStatus();
        String content = mvcResult.getResponse().getContentAsString();
        RestResponse data = JSON.parseObject(content,RestResponse.class);
        Assert.assertEquals(200,status);
        return data;
    }

    /**
     *@Description: 通过POST请求获取请求数据
     *@Param: [urlTemplate, requestJson]
     *@Author: lolipopjy
     *@date: 2019/11/21 10:08
     *@return:
     */
    public RestResponse getRestDataByPost(String urlTemplate,String requestJson) throws Exception {
        MvcResult mvcResult= getDataByPost(urlTemplate,requestJson);
        int status = mvcResult.getResponse().getStatus();
        String content = mvcResult.getResponse()
                .getContentAsString();
        RestResponse data = JSON.parseObject(content,RestResponse.class);
        Assert.assertEquals(200,status);
        return data;
    }

    /**
     *@Description: 通过GET请求获取请求数据
     *@Param: [urlTemplate, params]
     *@Author: lolipopjy
     *@date: 2019/11/21 15:55
     *@return:
     */
    public RestResponse getRestDataByGet(String urlTemplate,MultiValueMap<String,String> params) throws Exception {
        MvcResult mvcResult = getDataByGet(urlTemplate,params);
        int status = mvcResult.getResponse().getStatus();
        String content = mvcResult.getResponse()
                .getContentAsString();
        RestResponse data = JSON.parseObject(content,RestResponse.class);
        Assert.assertEquals(200,status);
        return data;
    }
}
