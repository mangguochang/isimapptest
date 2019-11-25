package com.hzot.isim.util.wsdl;

/*import com.sun.xml.internal.ws.client.BindingProviderProperties;
import com.sun.xml.internal.ws.developer.JAXWSProperties;*/
import org.json.JSONObject;
import org.json.XML;
import org.w3c.dom.Document;

import javax.xml.namespace.QName;
import javax.xml.soap.*;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.ws.Dispatch;
import javax.xml.ws.Service;
import java.io.StringWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: WebServiceClient
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-28 15:11
 */
public class WebServiceClient {
    String nameSpace = "";
    String wsdlUrl = "";
    String serviceName = "";
    String portName = "";
    String responseName = "";
    String elementName = "";
    int timeout = 20000;

    /**
     * @param nameSpace
     * @param wsdlUrl
     * @param serviceName
     * @param portName
     * @param //elementName
     * @param responseName
     */

    public WebServiceClient(String nameSpace, String wsdlUrl,
                            String serviceName, String portName, String element,
                            String responseName) {
        this.nameSpace = nameSpace;
        this.wsdlUrl = wsdlUrl;
        this.serviceName = serviceName;
        this.portName = portName;
        this.elementName = element;
        this.responseName = responseName;
    }

    /**
     * @param nameSpace
     * @param wsdlUrl
     * @param serviceName
     * @param portName
     * @param responseName
     * @param timeOut      毫秒
     */

    public WebServiceClient(String nameSpace, String wsdlUrl,
                            String serviceName, String portName, String element,
                            String responseName, int timeOut) {
        this.nameSpace = nameSpace;
        this.wsdlUrl = wsdlUrl;
        this.serviceName = serviceName;
        this.portName = portName;
        this.elementName = element;
        this.responseName = responseName;
        this.timeout = timeOut;
    }

    public String sendMessage(Map<String, String> inMsg) throws Exception {
        // 创建URL对象
        URL url = null;
        try {
            url = new URL(wsdlUrl);
        } catch (Exception e) {
            e.printStackTrace();
            return "创建URL对象异常";
        }
        // 创建服务(Service)
        QName sname = new QName(nameSpace, serviceName);
        Service service = Service.create(url, sname);

        // 创建Dispatch对象
        Dispatch<SOAPMessage> dispatch = null;
        try {
            dispatch = service.createDispatch(new QName(nameSpace, portName),
                    SOAPMessage.class, Service.Mode.MESSAGE);
        } catch (Exception e) {
            e.printStackTrace();
            return "创建Dispatch对象异常";
        }

        // 创建SOAPMessage
        try {
            SOAPMessage msg = MessageFactory.newInstance(
                    SOAPConstants.SOAP_1_2_PROTOCOL).createMessage();
            msg.setProperty(SOAPMessage.CHARACTER_SET_ENCODING, "UTF-8");

            SOAPEnvelope envelope = msg.getSOAPPart().getEnvelope();

            // 创建SOAPHeader(不是必需)
            // SOAPHeader header = envelope.getHeader();
            // if (header == null)
            // header = envelope.addHeader();
            // QName hname = new QName(nameSpace, "username", "nn");
            // header.addHeaderElement(hname).setValue("huoyangege");

            // 创建SOAPBody
            SOAPBody body = envelope.getBody();
            QName ename = new QName(nameSpace, elementName, "q0");
            SOAPBodyElement ele = body.addBodyElement(ename);
            // 增加Body元素和值
            for (Map.Entry<String, String> entry : inMsg.entrySet()) {
                ele.addChildElement(new QName(nameSpace, entry.getKey()))
                        .setValue(entry.getValue());
            }

            // 超时设置
     /*       dispatch.getRequestContext().put(
                    BindingProviderProperties.CONNECT_TIMEOUT, timeout);
            dispatch.getRequestContext().put(JAXWSProperties.REQUEST_TIMEOUT,
                    timeout);
*/
            // 通过Dispatch传递消息,会返回响应消息
            SOAPMessage response = dispatch.invoke(msg);

            // 响应消息处理,将响应的消息转换为doc对象
            Document doc = response.getSOAPPart().getEnvelope().getBody()
                    .extractContentAsDocument();
//            String ret = doc.getElementsByTagName(responseName).item(0)
//                    .getTextContent();

            String xmlString = toStringFromDoc(doc);
            System.out.println("XML格式");
            System.out.println(xmlString);
            JSONObject xmlJSONObj = XML.toJSONObject(xmlString);
            System.out.println("JSON格式");
            System.out.println(xmlJSONObj);

//            XMLSerializer xmlSerializer = new XMLSerializer();
//            JSON json = xmlSerializer.read(xml);
//            System.out.println(json);



            return xmlString;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public static String toStringFromDoc(Document document) {
        String result = null;

        if (document != null) {
            StringWriter strWtr = new StringWriter();
            StreamResult strResult = new StreamResult(strWtr);
            TransformerFactory tfac = TransformerFactory.newInstance();
            try {
                javax.xml.transform.Transformer t = tfac.newTransformer();
                t.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
                t.setOutputProperty(OutputKeys.INDENT, "yes");
                t.setOutputProperty(OutputKeys.METHOD, "xml"); // xml, html,
                // text
                t.setOutputProperty(
                        "{http://xml.apache.org/xslt}indent-amount", "4");
                t.transform(new DOMSource(document.getDocumentElement()),
                        strResult);
            } catch (Exception e) {
                System.err.println("XML.toString(Document): " + e);
            }
            result = strResult.getWriter().toString();
            try {
                strWtr.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }
}
