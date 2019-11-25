<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>数据库连接器列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">


    <link href="${base}/static/project/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${base}/static/project/plugins/bootstrapvalidator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="${base}/static/project/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${base}/static/project/css/animate.css" rel="stylesheet">
    <link href="${base}/static/project/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${base}/static/project/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link href="${base}/static/project/css/common.css" rel="stylesheet">


</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>数据库连接器管理</h5>
                </div>
                <div class="ibox-content">
                    <button type="button" class="btn btn-sm btn-default" onclick="addDB()">新增数据库连接器</button>
                    <p>

                    </p>
                    <hr>
                    <div class="row row-lg">
                        <div class="col-sm-12">
                            <!-- Example Card View -->
                            <div class="example-wrap">
                                <div class="example">
                                    <div class="fixed-table-toolbar">
                                        <div class="pull-right search">

                                            <form  class="form-inline">
                                                <div class="form-group">
                                                    <input type="text" name="s_alias" placeholder="请输入别名" id="s_alias" class="form-control">
                                                </div>

                                                <div class="form-group">
                                                    <input type="text" name="s_dbName" placeholder="请输入数据库名称" id="s_dbName" class="form-control">
                                                </div>

                                                <button class="btn btn-white" type="button" onclick="serach()">搜索</button>
                                            </form>
                                        </div>

                                    </div>
                                    <table id="table_list"></table>
                                </div>
                            </div>
                            <!-- End Example Card View -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--新增或修改-->
<div class="modal inmodal fade" id="dbModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">新增数据库连接器</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="dbForm">
                    <input type="hidden" name="id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 control-label">数据库别名：</label>
                        <div class="col-sm-8">
                            <input type="text" name="alias" placeholder="请输入数据库别名" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">数据库类型：</label>
                        <div class="col-sm-8">
                            <select name="dbType">
                                <option value="Oracle">Oracle</option>
                                <option value="SQLServer">SQL Server</option>
                                <option value="MySQL">MySQL</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">数据库地址：</label>
                        <div class="col-sm-8">
                            <input type="text" name="host" placeholder="请输入数据库地址" class="form-control">
                        </div>
                    </div>

                    <div class="form-group" style="display: none" id="sTypeDiv">
                        <label class="col-sm-3 control-label"></label>
                        <div class="col-sm-8">
                            SID:<input type="radio" name="sType" value="sid" style="margin-right: 70px;margin-left: 10px;">
                            ServerName:<input type="radio" name="sType" value="serverName" style="margin-right: 70px;margin-left: 10px;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">数据库名称：</label>
                        <div class="col-sm-8">
                            <input type="text" name="dbName" placeholder="请输入数据库名称" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">端口：</label>
                        <div class="col-sm-8">
                            <input type="text" name="port" placeholder="请输入端口" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户名：</label>
                        <div class="col-sm-8">
                            <input type="text" name="userName" placeholder="请输入用户名" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-8">
                            <input type="password" name="password" placeholder="请输入密码" class="form-control">
                        </div>
                    </div>

                    <#--<div class="form-group">-->
                        <#--<label class="col-sm-3 control-label">测试语句：</label>-->
                        <#--<div class="col-sm-8">-->
                            <#--<textarea type="text" name="testSql" placeholder="请输入测试语句" class="form-control"></textarea>-->
                        <#--</div>-->
                    <#--</div>-->

                    <div class="form-group">
                        <label class="col-sm-3 control-label">连接测试：</label>
                        <div class="col-sm-8">
                            <button type="button" class="btn btn-info" onclick="testDBInfo()" >测试</button>
                            <span id="testRs"></span>
                        </div>
                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveOrUpdate()">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 全局js -->
<script src="${base}/static/project/js/jquery.min.js?v=2.1.4"></script>
<script src="${base}/static/project/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${base}/static/project/plugins/bootstrapvalidator/js/bootstrapValidator.js"></script>
<script src="${base}/static/project/plugins/bootstrapvalidator/js/language/zh_CN.js"></script>
<script src="${base}/static/project/plugins/jeditable/jquery.jeditable.js"></script>


<script src="${base}/static/project/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${base}/static/project/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script src="${base}/static/project/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<!-- 自定义js -->
<script src="${base}/static/project/js/content.js?v=1.0.0"></script>
<script src="${base}/static/project/common.js?v=1.0.0"></script>


<!-- Page-Level Scripts -->
<script>
    $(function(){
        $("[name='dbType']").change(function(){
            var value = $(this).val();
            if(value=="Oracle"){
                //选择oracle 显示sid/servername
                $("#sTypeDiv").show();
            }else{
                //选择非oracle 显示sid/servername
                $("#sTypeDiv").hide();
                //取消选中的sid/servername
                $("[name='sType']").prop('checked', false);
            }

        })
        initValidator();

        $('#dbModal').on('hide.bs.modal', function () {
            resetValidator();
        });

    })

    $(document).ready(function () {
        //初始化表格,动态从服务器加载数据
        $("#table_list").bootstrapTable({
            //使用get请求到服务器获取数据
            method: "POST",
            //必须设置，不然request.getParameter获取不到请求参数
            contentType: "application/x-www-form-urlencoded",
            //获取数据的Servlet地址
            url: "${base}/dbConn/list",
            uniqueId:'id',
            //表格显示条纹
            striped: true,
            //启动分页
            pagination: true,
            //每页显示的记录数
            pageSize: 10,
            //当前第几页
            pageNumber: 1,
            //记录数可选列表
            pageList: [5, 10, 15, 20, 25],
            //是否启用查询
            search:false,
            //是否启用详细信息视图
            // detailView:false,
            //detailFormatter:detailFormatter,
            //表示服务端请求
            sidePagination: "server",
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType: "undefined",
            queryParams: queryParams,
            //json数据解析
            responseHandler: function(res) {
                var data = {"content":0,"totalElements":0};
                if(res.success){
                    data = res.data;
                }
                return {
                    "rows": data.content,
                    "total": data.totalElements
                };

            },
            //数据列
            columns: [
            {
                title: '序号',
                field: '',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#table_list').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#table_list').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            },{
                title: "别名",
                field: "alias"
            },{
                title: "数据库名称",
                field: "dbName"
            },{
                title: "数据库地址",
                field: "host"
            },{
                title: "数据库类型",
                field: "dbType",
                formatter: function (value, row, index) {
                    var dbType = "";
                    if(value=="Oracle"){
                        dbType = "Oracle";
                    }else if(value=="SQLServer"){
                        dbType = "SQL Server";
                    }else if(value=="MySQL"){
                        dbType = "MySQL";
                    }
                    return value;
                }
            },{
                title: "是否连通",
                field: "connStatus"
            },{
                title: "操作",
                field: "--",
                formatter: function (value, row, index) {
                    var btns = '<div class="button-center">';
                    btns +=    '<button type="button" class="btn btn-sm btn-default" onclick="testDBLink(\''+row.id+'\')">连接测试</button>';
                    btns +=    '<button type="button" class="btn btn-sm btn-default" onclick="getDBById(\''+row.id+'\')">修改</button>';
                    btns +=    '<button type="button" class="btn btn-sm btn-danger" onclick="deleteDB(\''+row.id+'\')">删除</button>';
                    btns +=    '</div>'
                    return btns;
                }
            }]
        });

        //得到查询的参数
        function queryParams (params) {
            var temp = {  //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                pageSize: params.pageSize,  //页面大小
                pageNumber: params.pageNumber, //页码
                name: $("#s_alias").val(),
                dbName:$("#s_dbName").val()

            };
            return temp;
        };

        function serach() {
            $("#table_list").bootstrapTable('refresh');
        }

    });

    var state;
    function addDB() {
        state = true;
        $(".modal-title").text("新增数据库连接器");
        $("#dbForm").clearForm();
        $('#dbModal').modal();
    }

    function getDBById(roleId) {
        $("#dbForm").clearForm();
        state = false;
        $(".modal-title").text("修改数据库连接器");
        $.ajax({
            type:"GET",
            url:"${base}/dbConn/edit?id="+roleId,
            dataType:"json",
            success:function(data){
                if(data.success){
                    $("#dbForm").setForm(data.data);
                    //初始化数据库连接器
                    $("[name='dbType']").trigger("change");
                    $("[name='sType']").trigger("change");
                    $('#dbModal').modal();
                }else{
                    layer.msg(data.message);
                }
            },
            error:function(jqXHR){
                layer.msg("发生错误："+ jqXHR.status);
            }
        });

    }

    function saveOrUpdate() {
        if(!validate()){
            return;
        }
        if(state){
            saveDB();
        }else{
            updateDB();
        }
    }

    function saveDB(){
        $.ajax({
            type:"POST",
            url:"${base}/dbConn/add",
            dataType:"json",
            contentType:"application/json",
            data:JSON.stringify($("form").serializeObject()),
            success:function(res){
                if(res.success){
                    layer.msg("添加成功",{time: 1000},function(){
                        window.location.reload(true);
                    });
                }else{
                    layer.msg(res.message);
                }
            }
        });
    }

    function updateDB(){
        $.ajax({
            type:"POST",
            url:"${base}/dbConn/edit",
            dataType:"json",
            contentType:"application/json",
            data:JSON.stringify($("form").serializeObject()),
            success:function(res){
                if(res.success){
                    layer.msg("更新成功",{time: 1000},function(){
                        window.location.reload(true);
                    });
                }else{
                    layer.msg(res.message);
                }
            }
        });
    }

    function deleteDB(dbId) {
        layer.confirm("你确定要删除该数据库连接器吗？",{btn:['确定','取消']},
            function(){
                $.post("${base}/dbConn/delete",{"id":dbId},function (res){
                    if(res.success){
                        layer.msg("删除成功",{time: 1000},function(){
                            window.location.reload();
                        });
                    }else{
                        layer.msg(res.message);
                    }

                });
            }
        )
    }

    //数据库连接测试
    function testDBInfo() {
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });
        $.ajax({
            type:"POST",
            url:"${base}/dbConn/testLink",
            dataType:"json",
            contentType:"application/json",
            data:JSON.stringify($("form").serializeObject()),
            success:function(res){
                if(res.success){
                    layer.msg("连接成功",{time: 1000},function(){
                        $("#testRs").text("连接成功");
                    });
                }else{
                    layer.msg(res.message);
                    $("#testRs").text(res.message);
                }
                layer.close(index);
            }
        });
    }

    //数据库连接测试
    function testDBLink(id){
        var index = layer.load(1, {
            shade: [0.1,'#fff'] //0.1透明度的白色背景
        });

        var row = $('#table_list').bootstrapTable('getRowByUniqueId',id);
        $.ajax({
            type:"POST",
            url:"${base}/dbConn/testLinkById",
            dataType:"json",
            data:{id:id},
            success:function(res){
                if(res.success){
                    row.connStatus = "连接成功";
                }else{
                    row.connStatus = "连接失败";
                    layer.msg(res.message);
                }
                layer.close(index);
                $('#table_list').bootstrapTable('updateRow', {
                    id: id,
                    row: row
                });
            }
        });

    }

    //初始化校验信息
    function initValidator() {
        $('#dbForm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                alias: {//别名
                    validators: {
                        notEmpty: {
                            default: ''
                        }
                    }
                },
                dbType: {//数据库类型
                    validators: {
                        notEmpty: {
                            default: ''
                        }
                    }
                },
                sType: {//sid/serverName
                    validators: {
                        notEmpty: {
                            default: ''
                        }
                    }
                },
                dbName: {//数据库名称
                    validators: {
                        notEmpty: {
                            default: ''
                        }
                    }
                },
                host: {//数据库地址
                    validators: {
                        notEmpty: {
                            default: ''
                        }
                    }
                },
                port: {//端口
                    validators: {
                        notEmpty: {
                            default: '端口不能为空'
                        },
                        integer: {
                            default: ''
                        },
                        between: {
                            min:1,
                            max:65535,
                            default: ''
                        }
                    }
                },
                userName: {
                    validators: {
                        notEmpty: {
                            default: 'The username is required and cannot be empty'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            default: ''
                        }
                    }
                }
            }
        });
    }

    //清除校验
    function resetValidator() {
        //清除模态窗口校验样式
        $('#dbForm').data('bootstrapValidator').resetForm(true);
        //清除连接校验
        $("#testRs").text("");
    }

    //表单必填校验
    function validate() {
        var bootstrapValidator = $("#dbForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        return bootstrapValidator.isValid();
    }

    function serach() {
        $("#table_list").bootstrapTable('refresh');
    }

</script>




</body>

</html>
