package com.hzot.isim.controller.project.connectorManage;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.entity.connector.DatabaseConnector;
import com.hzot.isim.util.DBConn.DoConnection;
import com.hzot.isim.util.PageList;
import com.hzot.isim.util.RestResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: DatabaseConnectorController
 * @Description: 数据库连接器
 * @Author: lolipopjy
 * @Date: 2019-10-18 10:15
 */
@RequestMapping("/dbConn")
@Controller
public class DatabaseConnectorController extends BaseController {

    @GetMapping("list")
    @SysLog("跳转到数据库连接器列表")
    public String list(Model model){
        return "dbConn/list";
    }

    @PostMapping("list")
    @ResponseBody
    public RestResponse list(@RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize,
                         @RequestParam(value = "pageNumber",defaultValue = "1")Integer pageNumber,
                         String loginName, String realName,
                         ServletRequest request){

        PageList pageList=new PageList();
        EntityWrapper<DatabaseConnector> wrapper = new EntityWrapper<>();
        wrapper.orderBy("create_time",true);
        Page<DatabaseConnector> pageInfo = dbConnectorService.selectPage(new Page<>(pageNumber,pageSize),wrapper);
        setPageInfo(pageList,pageInfo,pageSize,pageNumber);
        //设置创建者及更新者
        setCreatorUpdater(pageInfo);
        return  RestResponse.success().setData(pageList);
    }

    @GetMapping("add")
    public String add(Model model){
        return "dbConn/add";
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("保存新增数据库数据")
    public RestResponse add(@RequestBody DatabaseConnector dbInfo){
        dbConnectorService.saveDatabseInfo(dbInfo);
        return RestResponse.success();
    }

    @GetMapping("edit")
    @ResponseBody
    public RestResponse edit(String id){
        DatabaseConnector dbInfo = dbConnectorService.getDatabseInfoById(id);
        return RestResponse.success().setData(dbInfo);
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存编辑数据库数据")
    public RestResponse edit(@RequestBody DatabaseConnector dbInfo){
        if(StringUtils.isBlank(dbInfo.getId())){
            return RestResponse.failure("数据库ID不能为空");
        }
        DatabaseConnector oldRole = dbConnectorService.getDatabseInfoById(dbInfo.getId());
        dbConnectorService.updateDatabseInfo(dbInfo);
        return RestResponse.success();
    }


    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除数据库数据")
    public RestResponse delete(@RequestParam(value = "id",required = false)String id){
        if( StringUtils.isBlank(id)){
            return RestResponse.failure("数据库ID不能为空");
        }
        DatabaseConnector dbInfo = dbConnectorService.getDatabseInfoById(id);
        dbConnectorService.deleteById(dbInfo);
        return RestResponse.success();
    }

    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("多选删除数据库数据")
    public RestResponse deleteSome(@RequestBody List<DatabaseConnector> dbInfos){
        if(dbInfos == null || dbInfos.size()==0){
            return RestResponse.failure("请选择需要删除的数据库");
        }
        for (DatabaseConnector r : dbInfos){
            dbConnectorService.deleteDatabseInfo(r);
        }
        return RestResponse.success();
    }

    @PostMapping("testLink")
    @ResponseBody
    @SysLog("测试数据库连接")
    public RestResponse testLink(@RequestBody DatabaseConnector dbInfo){
        String msg = "";
        Boolean isSuccess = false;
        try {
            Connection conn = DoConnection
                    .connection(dbInfo.getDbType(),dbInfo.getsType(),"",
                            dbInfo.getHost(),dbInfo.getPort(),dbInfo.getDbName(),dbInfo.getUserName(),dbInfo.getPassword());
            if(conn!=null){
                msg = "连接成功";
                isSuccess = true;
                conn.close();
            }else {
                msg = "连接失败";
                isSuccess = false;
            }
        } catch (Exception e) {
            msg = "连接失败:"+e.getLocalizedMessage();
            isSuccess = false;
            e.printStackTrace();
        }
        if(isSuccess){
            return RestResponse.success();
        }else {
            return RestResponse.failure(msg);
        }
    }

    @PostMapping("testLinkById")
    @ResponseBody
    @SysLog("测试数据库连接")
    public RestResponse testLinkById(String id){
        DatabaseConnector dbInfo = dbConnectorService.getDatabseInfoById(id);
        String msg = "";
        Boolean isSuccess = false;
        try {
            Connection conn = DoConnection
                    .connection(dbInfo.getDbType(),dbInfo.getsType(),"",
                            dbInfo.getHost(),dbInfo.getPort(),dbInfo.getDbName(),dbInfo.getUserName(),dbInfo.getPassword());
            if(conn!=null){
                msg = "连接成功";
                isSuccess = true;
                conn.close();
            }else {
                msg = "连接失败";
                isSuccess = false;
            }
        } catch (Exception e) {
            msg = "连接失败:"+e.getLocalizedMessage();
            isSuccess = false;
            e.printStackTrace();
        }
        if(isSuccess){
            return RestResponse.success();
        }else {
            return RestResponse.failure(msg);
        }
    }


    @PostMapping("getDBInfoByType")
    @ResponseBody
    @SysLog("根据数据库类型获取数据库信息")
    public RestResponse getDBInfoByType(String dbType){
        EntityWrapper<DatabaseConnector> wrapper = new EntityWrapper<>();
        wrapper.setSqlSelect("id,host");
        wrapper.eq("db_type",dbType);
        List<Map<String, Object>> dbInfo = dbConnectorService.selectMaps(wrapper);
        return RestResponse.success().setData(dbInfo);
    }


}
