package com.hzot.isim.util.swagger;

import com.alibaba.fastjson.JSON;
import io.swagger.models.*;
import io.swagger.models.parameters.BodyParameter;
import io.swagger.models.parameters.Parameter;
import io.swagger.models.properties.Property;
import io.swagger.parser.Swagger20Parser;

import java.util.*;

/**
 * @ClassName: SwaggerUtil
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-28 21:21
 */
public class SwaggerUtil {


    public static List<Map<String,Object>> getSwaggerMsg(String swaggerPath) throws Exception{
        Swagger20Parser swagger20Parser = new Swagger20Parser();
        Swagger swagger = swagger20Parser.read(swaggerPath, null);
        String basePath = swagger.getBasePath();
        String host = swagger.getHost();
        Map<String, Path> paths = swagger.getPaths();
        List<Map<String,Object>> bindList = new ArrayList<Map<String,Object>>();
        for(Map.Entry<String, Path> entry : paths.entrySet()){
            String pathStr = entry.getKey();
            Path path = entry.getValue();

            if(host==null){
                int s = swaggerPath.indexOf("/",swaggerPath.indexOf("://")+3);
                host = swaggerPath.substring(swaggerPath.indexOf("://")+3,s);
            }
            String pathURL = "http://" + host + basePath + pathStr;

            Map<HttpMethod, Operation> operationMap =path.getOperationMap();
            for(HttpMethod method : operationMap.keySet()){
                Operation operation = operationMap.get(method);
                if(operation != null){
                    String operationName = operation.getSummary();
                    Map<String,Object> optMap = new HashMap<String,Object>();
                    optMap.put("optName", operationName);
                    optMap.put("method", method.name());
                    optMap.put("optDes", operation.getDescription());
                    optMap.put("pathURL", pathURL);
                    optMap.put("pathStr", pathStr);
                    optMap.put("operation", operation);
                    optMap.put("definitions", swagger.getDefinitions());

                    //====解析方法请求参数
//                    List<Parameter> parameters = operation.getParameters();
//                    System.out.println("方法名："+pathURL);
//                    System.out.println("方法类型："+method.name());
//                    for(Parameter parameter : parameters){
//                        String paramterPath = parameter.getIn();
//                        String paramterName = parameter.getName();
//                        String access = parameter.getAccess();
//                        System.out.println("参数位置/类型："+paramterPath);
//                        //解析请求所需参数
//                        if(parameter instanceof BodyParameter){
//                            BodyParameter bodyParameter = (BodyParameter) parameter;
//                            Model model = bodyParameter.getSchema();
//                            if(bodyParameter.getSchema() instanceof RefModel){
//                                model = (RefModel)model;
//                                String refPath = ((RefModel) model).get$ref();
//                                String[] refArry = refPath.split("/");
//                                if(refArry[1].equalsIgnoreCase("definitions")){
//                                    Map<String, Model> definitions = swagger.getDefinitions();
//                                    for(String key : definitions.keySet()){
//                                        if(key.equalsIgnoreCase(refArry[2])){
//                                            Model model1 = definitions.get(key);
//                                            Map<String, Property> properties = model1.getProperties();
//                                        }
//                                    }
//                                }
//                            }
//                            String ref = model.getReference();
//                            System.out.println("");
//                        }
//                        System.out.println("参数名称："+paramterName);
//                    }
                    bindList.add(optMap);
                }
            }
        }
        return bindList;
    }
}
