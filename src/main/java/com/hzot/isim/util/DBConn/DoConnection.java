package com.hzot.isim.util.DBConn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;

/**
 * @ClassName: DoConnection
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-21 10:17
 */
public class DoConnection {

    private static Logger logger = LoggerFactory.getLogger(DoConnection.class);

    public static Connection connection(String dbtype,String linkType,String tns,String host,Integer port,String dbname,String username,String password) throws Exception {
        Connection conn = null;

        String jdbcurl = getJDBCUrl(dbtype,linkType,host,port,dbname);
        if ("ORACLE".equals(dbtype.toUpperCase())) {
            conn =DBHelper.initOracle(jdbcurl,username,password, false);

        } else if ("MYSQL".equals(dbtype.toUpperCase())) {
            conn =DBHelper.initMysql(jdbcurl, username,password, false);

        } else if ("DB2".equals(dbtype.toUpperCase())) {
            conn =DBHelper.initDB2(jdbcurl, username,password, false);

        } else if ("SQLSERVER".equals(dbtype.toUpperCase())) {
            conn =DBHelper.initSQLServer(jdbcurl, username,password, false);

        }else {
            throw new Exception("不支持的数据库类型");
        }

        return conn;
    }

    public static void close(Connection conn){
        if (conn != null) {
            DBHelper.closeDB(conn, null, null);
        } else {
            DBHelper.closeDB(conn, null, null);
        }
    }

    public static String getJDBCUrl(String dbtype,String linkType,String host,Integer port,String dbname){
        String jdbcurl = "";
        if ("ORACLE".equals(dbtype.toUpperCase())) {
            if("sid".equals(linkType)){
                jdbcurl = "jdbc:oracle:thin:@" + host + ":"
                        + port + ":" + dbname;
            }else{
                jdbcurl = "jdbc:oracle:thin:@" + host + ":"
                        + port + "/" + dbname;
            }

        } else if ("MYSQL".equals(dbtype.toUpperCase())) {
            jdbcurl = "jdbc:mysql://" + host + ":"
                    + port + "/" + dbname
                    + "?useUnicode=true&characterEncoding=utf-8";

        } else if ("DB2".equals(dbtype.toUpperCase())) {
            jdbcurl = "jdbc:db2://" + host + ":"
                    + port + "/" + dbname;

        } else if ("SQLSERVER".equals(dbtype.toUpperCase())) {
            jdbcurl = "jdbc:sqlserver://" + host + ":"
                    + port + ";DatabaseName=" + dbname;

        }
        return jdbcurl;
    }

    public static void main(String[] args)  {
//        try {
////            Connection conn = DoConnection
////                    .connection("mysql","sid","",
////                            "192.168.8.124","3306","isim","root","root");
//            Connection conn = DoConnection
//                    .connection("oracle","单节点","",
//                            "192.168.8.124","3306","isim","root","root");
//            if(conn!=null){
//                System.out.println("连接成功");
//                conn.close();
//            }else {
//                System.out.println("连接失败");
//            }
//        } catch (Exception e) {
//            System.out.println("发生失败："+e.getMessage());
//            e.printStackTrace();
//        }

    }
}
