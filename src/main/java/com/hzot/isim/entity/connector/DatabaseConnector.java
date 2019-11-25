package com.hzot.isim.entity.connector;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.hzot.isim.base.DataEntity;

/**
 * @ClassName: DatabaseConnector
 * @Description: 数据库连接器
 * @Author: lolipopjy
 * @Date: 2019-10-18 10:21
 */
@TableName("database_connector")
public class DatabaseConnector extends DataEntity<DatabaseConnector> {



    /**
     * 数据库别名
     */
    @TableField("alias")
    private String alias;

    /**
     * 数据库类型
     */
    @TableField("db_type")
    private String dbType;

    /**
     * 数据库地址
     */
    @TableField("host")
    private String host;

    /**
     * 数据库名称
     */
    @TableField("db_name")
    private String dbName;

    /**
     * 数据库用户名
     */
    @TableField("user_name")
    private String userName;

    /**
     * 数据库密码
     */
    @TableField("password")
    private String password;

    /**
     * 数据库端口
     */
    @TableField("port")
    private Integer port;

    /**
     * 测试语句
     */
    @TableField("test_sql")
    private String testSql;

    /**
     * Oracle 连接类型sid/serverName
     */
    @TableField("s_type")
    private String sType;

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getPort() {
        return port;
    }

    public void setPort(Integer port) {
        this.port = port;
    }

    public String getTestSql() {
        return testSql;
    }

    public void setTestSql(String testSql) {
        this.testSql = testSql;
    }

    public String getsType() {
        return sType;
    }

    public void setsType(String sType) {
        this.sType = sType;
    }

}
