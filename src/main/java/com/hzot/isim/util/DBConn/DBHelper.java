package com.hzot.isim.util.DBConn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * @ClassName: DBHelperl
 * @Description: TODO
 * @Author: lolipopjy
 * @Date: 2019-10-21 10:19
 */
public class DBHelper {

    private static Logger logger = LoggerFactory.getLogger(DBHelper.class);
//    public static Connection conn=null;
    /**
     * @author Liyg
     * @description 创建ORACLE连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @return
     */
    public static Connection initOracle(String jdbcurl, String username, String password, boolean autoCommit) throws Exception {
        Connection conn=null;
        Class.forName("oracle.jdbc.driver.OracleDriver");
        //连接数据库
        conn = DriverManager.getConnection(jdbcurl, username, password);
        conn.setAutoCommit(autoCommit);
        return conn;
    }

    /**
     * @author Liyg
     * @description 创建DB2连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @return
     */
    public static Connection initDB2(String jdbcurl, String username, String password, boolean autoCommit) throws Exception {
        Connection conn=null;
        Driver driver=(Driver) Class.forName("com.ibm.db2.jcc.DB2Driver").newInstance();
        //连接数据库
        DriverManager.registerDriver(driver);
        conn = DriverManager.getConnection(jdbcurl, username, password);
        conn.setAutoCommit(autoCommit);
        return conn;
    }

    /**
     * @author Liyg
     * @description 创建MYSQL连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @return
     */
    public static Connection initMysql(String jdbcurl, String username, String password, boolean autoCommit) throws Exception {
        Connection conn=null;
        Class.forName("com.mysql.jdbc.Driver");
        //连接数据库
        conn = DriverManager.getConnection(jdbcurl, username, password);
        conn.setAutoCommit(autoCommit);
        return conn;
    }

    /**
     * @author Liyg
     * @description 创建SQLServer连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @return
     */
    public static Connection initSQLServer(String jdbcurl, String username, String password, boolean autoCommit) throws Exception {
        Connection conn=null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // 连接数据库
        conn = DriverManager.getConnection(jdbcurl, username, password);
        conn.setAutoCommit(autoCommit);
        return conn;
    }


    /**
     * @author zk
     * @description 创建GreenPlum连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @return
     */
    public static Connection initGreenPlum(String jdbcurl, String username, String password, boolean autoCommit) throws Exception {
        Connection conn=null;
        Class.forName("com.pivotal.jdbc.GreenplumDriver");
        //conn = DriverManager.getConnection("jdbc:pivotal:greenplum://192.168.229.146:5432;DatabaseName=database", "gpadmin", "111");
        conn = DriverManager.getConnection(jdbcurl,username, password);
        conn.setAutoCommit(autoCommit);
//            logger.debug("GreenPlum DATABASE: Connection success!");
        return conn;
    }

    /**
     * @author zk
     * @description 创建HIVE连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @return
     */
    public static Connection initHIVE(String jdbcurl, String username, String password, boolean autoCommit) throws Exception {
        Connection conn=null;
        Class.forName("org.apache.hadoop.hive.jdbc.HiveDriver");
        //conn = DriverManager.getConnection("jdbc:pivotal:greenplum://192.168.229.146:5432;DatabaseName=database", "gpadmin", "111");
        conn = DriverManager.getConnection(jdbcurl,username, password);
        conn.setAutoCommit(autoCommit);
        return conn;
    }
    /**
     * @author Liyg
     * @description 根据传入的数据源类型，创建Connection连接信息
     * @param jdbcurl
     * @param username
     * @param password
     * @param autoCommit
     * @param dbtype
     * @return
     */
    public static Connection intiConnection(String jdbcdriver,String jdbcurl, String username, String password, boolean autoCommit, String dbtype) throws Exception {
        Connection conn = null;
        Class.forName(jdbcdriver);
        // 连接数据库
        conn = DriverManager.getConnection(jdbcurl, username, password);
        conn.setAutoCommit(autoCommit);
        return conn;
    }

    /**
     * 关闭数据库
     * @author Liyg
     * @param conn
     * @param pstmt
     */
    public static void closeDB(Connection conn, PreparedStatement pstmt,ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            rs = null;

            if (pstmt != null) {
                pstmt.close();
            }
            pstmt = null;

            if (conn != null) {
                conn.close();
            }
            conn = null;
        } catch (Exception ee) {
//            logger.info("关闭数据库操作异常：" + ee.getMessage());
            logger.error("数据源关闭失败",ee);
        }
    }

}
