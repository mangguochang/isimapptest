package com.hzot.isim.util.properties;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.Properties;

/**
 * @ClassName: PropertiesUtil
 * @Description: 读取properties的工具类
 * @Author: lolipopjy
 * @Date: 2019-10-31 15:37
 */
public class PropertiesUtil {
    /**
     * 读取properties
     *
     * @param name 需要读取的文件路径
     * @return Properties
     */
    public static Properties getReadAbleProperties(String name) {

        InputStream ins = PropertiesUtil.class.getResourceAsStream(name);

        // 生成properties对象
        Properties props = new OrderedProperties();
        BufferedReader bf = new BufferedReader(new InputStreamReader(ins));
        try {
            props.load(bf);
            Iterator<String> it = props.stringPropertyNames().iterator();
            while (it.hasNext()) {
                String key = it.next();
                String value  = props.getProperty(key);
                System.out.println(key+":"+value);
            }
            ins.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }

        return props;

    }

}
