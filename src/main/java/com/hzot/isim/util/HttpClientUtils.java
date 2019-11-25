package com.hzot.isim.util;

import com.alibaba.fastjson.JSON;
import org.apache.commons.httpclient.Cookie;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.http.client.params.ClientPNames;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;


/**
 * @ClassName: HttpClientUtils
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-07-14 14:20
 */
public class HttpClientUtils {

    /**
    *@Description:
    *@Param: [loginUrl(登陆 Url), userUrl(需登陆后访问的 Url)]
    *@Author: lolipopjy
    *@date: 2019/7/15 10:08
    *@return:
    */
    public static Map<String, Object> getBCStatus(String url){
        Map<String, Object> data = new HashMap<>();
        try {
            data  = getDataList(url,null);

        }catch (Exception e) {
            e.printStackTrace();
        }

        return data;
    }

    private static String doGet(String url) throws  Exception{
        HttpClient httpClient = new HttpClient();
        // Get请求
        GetMethod getMethod = new GetMethod(url);
        httpClient.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
        httpClient.executeMethod(getMethod);
        // 返回数据
        String text = getMethod.getResponseBodyAsString();
        return text;
    }

    private static String doPost(StringBuffer token,String url,HttpClient httpClient,Map<String,Object> params) throws  Exception{
        // Post请求
        PostMethod postMethod = new PostMethod(url);
        httpClient.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);

        Set<String> keySet = params.keySet();
        NameValuePair[] values = new NameValuePair[keySet.size()];
        int i = 0;
        for(String key : keySet){
            values[i] =new NameValuePair(key, String.valueOf(params.get(key)));
            i++;
        }
        // 每次访问需授权的网址时需带上前面的 cookie 作为通行证
        postMethod.setRequestHeader("Cookie", token.toString());
        postMethod.setRequestBody(values);
        httpClient.executeMethod(postMethod);

        // 返回数据
        String text = postMethod.getResponseBodyAsString();
        return text;
    }


    private static StringBuffer getCookies(Cookie[] cookies){
        StringBuffer Cookies = new StringBuffer();
        for (Cookie c : cookies) {
            Cookies.append(c.toString() + ";");
        }
        return Cookies;
    }


    private static Map<String, Object>  getDataList(String url,Map<String,Object> params){
        Map data = new HashMap();
        try {
            HttpClient httpClient = new HttpClient();
            String responseText = "";
            responseText = doGet(url);
            data = JSON.parseObject(responseText);
        }catch (Exception e){
            e.printStackTrace();
        }
        return data;
    }

    public static void main(String[] args) {
        getBCStatus("http://corepanel-s2i-test-corepanel.apps.cluster-244a.244a.sandbox1824.opentlc.com/getBCStatus");
    }
}