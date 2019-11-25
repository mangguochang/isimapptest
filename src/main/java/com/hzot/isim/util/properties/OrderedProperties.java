package com.hzot.isim.util.properties;


import java.io.File;
import java.util.*;
/**
 * @ClassName: OrderedProperties
 * @Description: key的顺序按照文件顺序
 * @Author: lolipopjy
 * @Date: 2019-10-31 15:56
 */
public class OrderedProperties extends Properties {

    private static final long serialVersionUID = 4710927773256743817L;

    private final LinkedHashSet<Object> keys = new LinkedHashSet<Object>();

    @Override
    public Enumeration<Object> keys() {
        return Collections.<Object> enumeration(keys);
    }

    @Override
    public Object put(Object key, Object value) {
        keys.add(key);
        return super.put(key, value);
    }

    @Override
    public Set<Object> keySet() {
        return keys;
    }

    @Override
    public Set<String> stringPropertyNames() {
        Set<String> set = new LinkedHashSet<String>();

        for (Object key : this.keys) {
            set.add((String) key);
        }

        return set;
    }
}