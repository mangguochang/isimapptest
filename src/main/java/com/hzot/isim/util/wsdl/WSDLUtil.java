package com.hzot.isim.util.wsdl;

import com.ibm.wsdl.BindingOperationImpl;
import com.ibm.wsdl.PortImpl;
import com.ibm.wsdl.extensions.http.HTTPAddressImpl;
import com.ibm.wsdl.extensions.soap.SOAPAddressImpl;
import com.ibm.wsdl.extensions.soap.SOAPOperationImpl;
import com.ibm.wsdl.extensions.soap12.SOAP12AddressImpl;
import com.ibm.wsdl.extensions.soap12.SOAP12OperationImpl;
import org.reficio.ws.builder.core.Wsdl;
import org.reficio.ws.legacy.SoapLegacyFacade;
import sun.misc.BASE64Encoder;

import javax.wsdl.Binding;
import javax.wsdl.Service;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;
/**
 * @ClassName: WSDLUtil
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-28 18:59
 */
public class WSDLUtil {

    public static String getWsdlURL(String wsdlUrl, String wsdlUsername, String wsdlPwd) throws IOException {
        PrintWriter out = null;
        InputStream in = null;
        FileOutputStream os = null;
        byte[] buffer = new byte[4*1024];
        int read;
        String path = UUID.randomUUID().toString();
        try {
            URL realUrl = new URL(wsdlUrl);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            String auth = wsdlUsername + ":" + wsdlPwd;
            conn.setRequestProperty("Authorization", "Basic " + new BASE64Encoder().encode(auth.getBytes()));
//			// 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            //设置超时
            conn.setConnectTimeout(30000);
            conn.setReadTimeout(30000);
            // 定义BufferedReader输入流来读取URL的响应
            in = conn.getInputStream();
            os = new FileOutputStream(path);
            while((read = in.read(buffer)) > 0){
                os.write(buffer, 0, read);
            }
        } catch (IOException e) {
            throw e;
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
                if(os!=null){
                    os.close();
                }
            }
            catch(IOException ex){
                throw ex;
            }
        }
        return "file:///" + new File(path).getAbsolutePath();
    }

    public static List<Map<String, List<Map<String,String>>>> getWsdlMsg(String wsdlPath){
        List<Map<String,List<Map<String,String>>>> bindList = new ArrayList<Map<String,List<Map<String,String>>>>();
        Wsdl wsdl = Wsdl.parse(wsdlPath);
        try {
            SoapLegacyFacade soapFacade = new SoapLegacyFacade(new URL(wsdlPath));
            Collection<Service> services = soapFacade.getServices();
            if (services != null) {
                for(Service service: services){
                    String serviceName = service.getQName().getLocalPart();
                    String targetNamespace = service.getQName().getNamespaceURI();
                    Map<String,Object> map = service.getPorts();
                    for(String portName : map.keySet()){
                        PortImpl port = (PortImpl)map.get(portName);
                        List portExtensibilityElements = port.getExtensibilityElements();
                        //获取soap:address属性location
                        String locationURI = "";
                        if(portExtensibilityElements.size()>0){
                            Object object = portExtensibilityElements.get(0);
                            if(object instanceof SOAP12AddressImpl){
                                SOAP12AddressImpl operation = (SOAP12AddressImpl) object;
                                locationURI = operation.getLocationURI();
                            }else if(object instanceof SOAPAddressImpl){
                                SOAPAddressImpl operation = (SOAPAddressImpl) object;
                                locationURI = operation.getLocationURI();
                            }else if(object instanceof HTTPAddressImpl){
                                HTTPAddressImpl operation = (HTTPAddressImpl) object;
                                locationURI = operation.getLocationURI();
                            }
                        }
                        Binding bing  = port.getBinding();
                        List<BindingOperationImpl> operationList = bing.getBindingOperations();
                        Map<String,List<Map<String,String>>> bindMap = new HashMap<String,List<Map<String,String>>>();
                        List<Map<String,String>> optList = new ArrayList<Map<String,String>>();
                        for(int j=0;j<operationList.size();j++){
                            BindingOperationImpl sOpt = operationList.get(j);
                            String optName = sOpt.getOperation().getName();
                            //获取soap:operation属性location
                            String soapAction = "";
                            List extensibilityElements = sOpt.getExtensibilityElements();
                            if(extensibilityElements.size()>0){
                                Object object =  extensibilityElements.get(0);
                                if(object instanceof SOAP12OperationImpl){
                                    SOAP12OperationImpl operation = (SOAP12OperationImpl) object;
                                    soapAction = operation.getSoapActionURI();
                                }else if(object instanceof SOAPOperationImpl){
                                    SOAPOperationImpl operation = (SOAPOperationImpl) object;
                                    soapAction = operation.getSoapActionURI();
                                }
                            }
                            Map<String,String> optMap = new HashMap<String,String>();
                            optMap.put("locationURI", locationURI);
                            optMap.put("targetNamespace", targetNamespace);
                            optMap.put("optName", optName);
                            optMap.put("portName", portName);
                            optMap.put("serviceName", serviceName);
                            optMap.put("soapAction", soapAction);
                            optList.add(optMap);
                        }
                        bindMap.put(portName, optList);
                        bindList.add(bindMap);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bindList;
    }

    public static void deleteWsdlFile(String wsdlUrl){
        wsdlUrl = wsdlUrl.replace("file:///", "");
        File file = new File(wsdlUrl);
        file.delete();
    }
}
