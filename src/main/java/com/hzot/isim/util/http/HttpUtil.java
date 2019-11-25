package com.hzot.isim.util.http;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hzot.isim.util.PlaceHolderReplaceUtils;
import com.hzot.isim.util.swagger.SwaggerUtil;
import org.apache.commons.httpclient.Cookie;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.http.client.params.ClientPNames;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static java.lang.System.out;

/**
 * @ClassName: HttpUtil
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-29 09:13
 */
public class HttpUtil {

    public static void main(String[] args) {
        try {
//            String url = "http://generator.swagger.io/api/gen/clients/android";
////            // 进行登陆操作
////            Map<String,Object> data = new HashMap<>();
////            GetMethod getMethod = new GetMethod(url);
////            HttpClient httpClient = new HttpClient();
////            httpClient.executeMethod(getMethod);
////            // 返回的数据
////            String responseBody = getMethod.getResponseBodyAsString();
////            System.out.println(responseBody);


//            String url = "http://generator.swagger.io/api/gen/clients/android";
//            String paramsString = "{\n" +
//                    "  \"spec\": {},\n" +
//                    "  \"options\": {\n" +
//                    "    \"additionalProp1\": \"string\",\n" +
//                    "    \"additionalProp2\": \"string\",\n" +
//                    "    \"additionalProp3\": \"string\"\n" +
//                    "  },\n" +
//                    "  \"swaggerUrl\": \"http://petstore.swagger.io/v2/swagger.json\",\n" +
//                    "  \"authorizationValue\": {\n" +
//                    "    \"value\": \"string\",\n" +
//                    "    \"type\": \"string\",\n" +
//                    "    \"keyName\": \"string\"\n" +
//                    "  },\n" +
//                    "  \"securityDefinition\": {\n" +
//                    "    \"type\": \"string\",\n" +
//                    "    \"description\": \"string\"\n" +
//                    "  }\n" +
//                    "}";
////            JSONObject jo = JSON.parseObject(paramsString);
//            Map<String,Object> params = (Map)JSON.parse(paramsString);
//            String response = doPost(url,paramsString);
//            out.println(response);

            List<Map<String,Object>> swaggerMsg =  SwaggerUtil.getSwaggerMsg("https://petstore.swagger.io/v2/swagger.json");
            for(Map<String,Object> data : swaggerMsg){
                out.println(JSON.toJSON(data));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String doPost(String url,String requestFields,String requestBody) throws  Exception{
        if(url.contains("{")&&url.contains("}")){
            Map<String,Object> params = (Map)JSON.parse(requestFields);
            url = PlaceHolderReplaceUtils.replaceWithMap(url,params);
        }
        HttpClient httpClient = new HttpClient();
        // Post请求
        PostMethod postMethod = new PostMethod(url);
        postMethod.setRequestHeader("Content-Type","application/json");
        httpClient.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);

//        Set<String> keySet = params.keySet();
//        NameValuePair[] values = new NameValuePair[keySet.size()];
//        int i = 0;
//        for(String key : keySet){
//            values[i] =new NameValuePair(key, String.valueOf(params.get(key)));
//            i++;
//        }
        RequestEntity se = new StringRequestEntity(requestBody, "application/json", "UTF-8");
        postMethod.setRequestEntity(se);
        // 每次访问需授权的网址时需带上前面的 cookie 作为通行证
//        postMethod.setRequestHeader("Cookie", token.toString());
//        postMethod.setRequestBody(values);
        httpClient.executeMethod(postMethod);

        // 返回数据
        String text = postMethod.getResponseBodyAsString();
        return text;
    }

    public static String doGet(String url,String requestFields) throws  Exception{
        HttpClient httpClient = new HttpClient();
        if(url.contains("{")&&url.contains("}")){
            Map<String,Object> params = (Map)JSON.parse(requestFields);
            url = PlaceHolderReplaceUtils.replaceWithMap(url,params);
        }
        // Get请求
        GetMethod getMethod = new GetMethod(url);
        httpClient.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);


        httpClient.executeMethod(getMethod);

        // 返回数据
        String text = getMethod.getResponseBodyAsString();
        return text;
    }
}
