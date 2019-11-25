<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>角色列表</title>
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
                    <h5>角色管理</h5>
                </div>
                <div class="ibox-content">
                    <button type="button" class="btn btn-sm btn-default" onclick="addRole()">新增角色</button>
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

                                                    <input type="text" placeholder="角色编码" id="s_roleCode" class="form-control">
                                                </div>
                                                <div class="form-group">

                                                    <input type="text" placeholder="角色名称" id="s_roleName" class="form-control">
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
            url: "${base}/role/list",
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
                title: "角色编号",
                field: "roleCode"
            },{
                title: "角色名称",
                field: "roleName"
            },{
                title: "角色描述",
                field: "roleDesc"
            },{
                title: "角色类型",
                field: "roleType",
                formatter: function (value, row, index) {
                    if (value == 0) {
                        return "管理员";
                    } else if (value == 1) {
                        return "服务提供方开发者"
                    } else if (value == 2) {
                        return "服务使用方开发者"
                    } else if (value == 3) {
                        return "服务使用/提供方开发者"
                    }
                }
            },{
                title: "操作",
                field: "--",
                formatter: function (value, row, index) {
                    var btns = '<div class="button-center">';
                    btns +=    '<button type="button" class="btn btn-sm btn-default" onclick="editRole(\''+row.id+'\')">修改</button>';
                    btns +=    '<button type="button" class="btn btn-sm btn-info" onclick="roleMember(\''+row.id+'\')">成员</button>';
                    btns +=    '<button type="button" class="btn btn-sm btn-danger" onclick="deleteRole(\''+row.id+'\')">删除</button>';
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
    var layer;
    layui.use(['layer','form','table'], function() {
            layer = layui.layer,
            $ = layui.jquery,
            form = layui.form,
            table = layui.table;
    })

    function addRole() {
        layer.open({
            title : "添加角色",
            type : 2,
            area: ['610px', '420px'],
            content : "${base}/admin/system/role/add",
            success : function(layero, addIndex){
            }
        });
    }

    function editRole(roleId){
        layer.open({
            type: 2,
            title : "编辑角色",
            area: ['610px', '420px'],
            shadeClose: true,
            shade: false,
            content: '${base}/admin/system/role/edit?id='+roleId,
            end: function (index) {
                // $('#table_list').bootstrapTable("refresh");
            }
        });
    }

    function roleMember(roleId) {
        layer.open({
            title : "修改角色成员",
            area: ['820px', '560px'],
            type : 2,
            content : "${base}/admin/system/role/member/list?roleId="+roleId,
            success : function(layero, index){
                // setTimeout(function(){
                //     layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
                //         tips: 3
                //     });
                // },500);
            }
        });
    }

    function deleteRole(roleId) {
        layer.confirm("你确定要删除该角色吗？",{btn:['确定','取消']},
            function(){
                $.post("${base}/admin/system/role/delete",{"id":roleId},function (res){
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
