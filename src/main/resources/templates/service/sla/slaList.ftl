<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>SLA规则列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">


    <link href="${base}/static/project/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
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
                    <h5>SLA规则管理</h5>
                </div>
                <div class="ibox-content">
                    <#--<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#ruleModal">新增</button>-->
                    <button type="button" class="btn btn-sm btn-default" onclick="addRule()">新增规则</button>
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
                                                    <input type="text" placeholder="规则名称" id="s_roleCode" class="form-control">
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
<div class="modal inmodal fade" id="ruleModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">新增SLA规则</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="ruleForm">
                    <input type="hidden" name="id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 control-label">规则名称：</label>
                        <div class="col-sm-8">
                            <input type="text" name="ruleName" placeholder="请输入规则名称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">失败重试(次数)：</label>
                        <div class="col-sm-8">
                            <input type="text" name="failRetryTime" placeholder="请输入失败重试次数" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">链接超时(毫秒)：</label>
                        <div class="col-sm-8">
                            <input type="text" name="linkOverTime" placeholder="请输入链接超时(毫秒)" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">请求超时(毫秒)：</label>
                        <div class="col-sm-8">
                            <input type="text" name="requestOverTime" placeholder="请输入请求超时(毫秒)" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">响应超时(毫秒)：</label>
                        <div class="col-sm-8">
                            <input type="text" name="responseOverTime" placeholder="请输入响应超时(毫秒)" class="form-control">
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
    $(document).ready(function () {
        //初始化表格,动态从服务器加载数据
        $("#table_list").bootstrapTable({
            //使用get请求到服务器获取数据
            method: "POST",
            //必须设置，不然request.getParameter获取不到请求参数
            contentType: "application/x-www-form-urlencoded",
            //获取数据的Servlet地址
            url: "${base}/service/sla/slaList",
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
                title: "规则名称",
                field: "ruleName"
            },{
                title: "失败重试(次数)",
                field: "failRetryTime"
            },{
                title: "链接超时时间（毫秒）",
                field: "linkOverTime"
            },{
                title: "请求超时时间（毫秒）",
                field: "requestOverTime"
            },{
                title: "响应超时时间（毫秒）",
                field: "responseOverTime"
            },{
                title: "创建人",
                field: "createUser.realName"
            },{
                title: "创建时间",
                field: "createTime",
                formatter: function (value, row, index) {
                    return format(value);
                }
            },{
                title: "操作",
                field: "--",
                formatter: function (value, row, index) {
                    var btns = '<div class="button-center">';
                    btns +=    '<button type="button" class="btn btn-sm btn-default" onclick="getRuleById(\''+row.id+'\')">修改</button>';
                    btns +=    '<button type="button" class="btn btn-sm btn-danger" onclick="deleteRule(\''+row.id+'\')">删除</button>';
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
                roleCode: $("#s_roleCode").val(),
                roleName:$("#s_roleName").val()

            };
            return temp;
        };

        function serach() {
            $("#table_list").bootstrapTable('refresh');
        }

    });

    var state;
    function addRule() {
        state = true;
        $(".modal-title").text("新增SLA规则");
        $("#ruleForm").clearForm();
        $('#ruleModal').modal();
    }

    function getRuleById(roleId) {
        state = false;
        $("#dbForm").clearForm();
        $(".modal-title").text("修改SLA规则");
        $.ajax({
            type:"GET",
            url:"${base}/service/sla/edit?id="+roleId,
            dataType:"json",
            success:function(data){
            if(data.success){
                $("#ruleForm").setForm(data.data);
                $('#ruleModal').modal();
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
        if(state){
            saveRule();
        }else{
            updateRule();
        }
    }

    function saveRule(){
        $.ajax({
            type:"POST",
            url:"${base}/service/sla/add",
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

    function updateRule(){
        $.ajax({
            type:"POST",
            url:"${base}/service/sla/edit",
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

    function deleteRule(ruleId) {
        layer.confirm("你确定要删除该规则吗？",{btn:['确定','取消']},
            function(){
                $.post("${base}/service/sla/delete",{"id":ruleId},function (res){
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

    function serach() {
        $("#table_list").bootstrapTable('refresh');
    }

</script>




</body>

</html>
