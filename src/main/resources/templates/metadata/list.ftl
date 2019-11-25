<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>元数据列表</title>
    <meta name="keywords" content="">

    <link rel="shortcut icon" href="favicon.ico">


    <link href="${base}/static/project/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${base}/static/project/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${base}/static/project/css/animate.css" rel="stylesheet">
    <link href="${base}/static/project/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${base}/static/project/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/project/plugins/jquery-treegird/0.2.0/css/jquery.treegrid.css">
    <link href="${base}/static/project/css/common.css" rel="stylesheet">


</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>服务元数据管理</h5>
                </div>
                <div class="ibox-content">
                    <button type="button" class="btn btn-sm btn-default" onclick="addMeta()">新增根元数据</button>
                    <hr>
                    <div class="row row-lg">
                        <div class="col-sm-12">
                            <!-- Example Card View -->
                            <table id="table"></table>
                            <!-- End Example Card View -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--新增/修改元数据-->
<div class="modal inmodal fade" id="metaModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">新增元数据</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="metaForm">
                    <input type="hidden" name="id" value="">

                    <div class="form-group" id="parentMetaDiv" style="display:none;">
                        <label class="col-sm-3 control-label">上级元数据：</label>
                        <div class="col-sm-8">
                            <input type="hidden" name="pid">
                            <input type="text" name="pName" class="form-control" disabled>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">元数据名称：</label>
                        <div class="col-sm-8">
                            <input type="text" name="name" placeholder="请输入元数据名称" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">元数据描述：</label>
                        <div class="col-sm-8">
                            <input type="text" name="description" placeholder="请输入元数据描述" class="form-control">
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

<script src="${base}/static/project/plugins/bootstrap-table/1.12.0/extensions/treegrid/bootstrap-table-treegrid.js"></script>
<script src="${base}/static/project/plugins/jquery-treegird/0.2.0/js/jquery.treegrid.min.js"></script>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<!-- 自定义js -->
<script src="${base}/static/project/js/content.js?v=1.0.0"></script>
<script src="${base}/static/project/common.js?v=1.0.0"></script>


<!-- Page-Level Scripts -->
<script type="text/javascript">
    var $table = $('#table');

    $(function() {

        $table.bootstrapTable({
            //使用get请求到服务器获取数据
            method: "POST",
            //获取数据的Servlet地址striped: true,
            sidePagination: 'server',
            url: "${base}/metadata/list",
            idField: 'id',
            uniqueId:'id',
            //条纹
            striped: true,
            dataType: 'json',
            responseHandler: function (res) {
                //将服务端你的数据转换成bootstrap table 能接收的类型
                if(res.success){
                    return {"data": res.data}
                }else{
                    return {"data":[{}]}
                }
            },
            columns: [
                { field: 'check',  checkbox: true, formatter: function (value, row, index) {
                        if (row.check == true) {
                            // console.log(row.serverName);
                            //设置选中
                            return {  checked: true };
                        }
                    }
                },
                { field: 'name',  title: '元数据名称' },
                { field: 'description', title: '描述', sortable: true, align: 'center'},
                {
                    field: 'createTime', title: '创建时间', align: 'center', formatter: function (value, row, index) {
                        return format(value);
                    }
                },
                { field: 'operate', title: '操作', align: 'center', events : operateEvents, formatter: 'operateFormatter' },
            ],

            // bootstrap-table-treegrid.js 插件配置 -- start

            //在哪一列展开树形
            treeShowField: 'name',
            //指定父id列
            parentIdField: 'pid',

            onResetView: function(data) {
                //console.log('load');
                $table.treegrid({
                    initialState: 'collapsed',// 所有节点都折叠
                    // initialState: 'expanded',// 所有节点都展开，默认展开
                    treeColumn: 1,
                    // expanderExpandedClass: 'glyphicon glyphicon-minus',  //图标样式 -号
                    // expanderCollapsedClass: 'glyphicon glyphicon-plus',  //图标样式 +号
                    onChange: function() {
                        $table.bootstrapTable('resetWidth');
                    }
                });

                //只展开树形的第一级节点
                $table.treegrid('getRootNodes').treegrid('expand');

            },
            onCheck:function(row){
                var datas = $table.bootstrapTable('getData');
                // 勾选子类
                selectChilds(datas,row,"id","pid",true);

                // 勾选父类
                selectParentChecked(datas,row,"id","pid")

                // 刷新数据
                $table.bootstrapTable('load', datas);
            },

            onUncheck:function(row){
                var datas = $table.bootstrapTable('getData');
                selectChilds(datas,row,"id","pid",false);
                $table.bootstrapTable('load', datas);
            },
            // bootstrap-table-treetreegrid.js 插件配置 -- end
        });
    });

    // 格式化按钮
    function operateFormatter(value, row, index) {

        if(row.pid ==null){
        return [
            '<button type="button" class="btn btn-w-m btn-default" style="margin-right:15px;" onclick="addMeta(\''+row.id+'\')"><i class="fa fa-plus" ></i>&nbsp;新增子元数据</button>',
            '<button type="button" class="btn btn-w-m btn-success" style="margin-right:15px;" onclick="getMetaById(\''+row.id+'\')"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>',
            '<button type="button" class="btn btn-w-m btn-danger" style="margin-right:15px;" onclick="deleteMeta(\''+row.id+'\')"><i class="fa fa-trash-o" ></i>&nbsp;删除</button>'
        ].join('');
        }else{
            return [
                '<button type="button" class="btn btn-w-m btn-default" style="margin-right:15px;" disabled="disabled"><i class="fa fa-plus" ></i>&nbsp;新增子元数据</button>',
                '<button type="button" class="btn btn-w-m btn-success" style="margin-right:15px;" onclick="getMetaById(\''+row.id+'\')"><i class="fa fa-pencil-square-o" ></i>&nbsp;修改</button>',
                '<button type="button" class="btn btn-w-m btn-danger" style="margin-right:15px;" onclick="deleteMeta(\''+row.id+'\')"><i class="fa fa-trash-o" ></i>&nbsp;删除</button>'
            ].join('');

        }

    }
    // 格式化类型
    function typeFormatter(value, row, index) {
        if (value === 'menu') {  return '菜单';  }
        if (value === 'button') {  return '按钮'; }
        if (value === 'api') {  return '接口'; }
        return '-';
    }
    // 格式化状态
    function statusFormatter(value, row, index) {
        if (value === 1) {
            return '<span class="label label-success">正常</span>';
        } else {
            return '<span class="label label-default">锁定</span>';
        }
    }

    //初始化操作按钮的方法
    window.operateEvents = {
        'click .RoleOfadd': function (e, value, row, index) {
            add(row.id);
        },
        'click .RoleOfdelete': function (e, value, row, index) {
            del(row.id);
        },
        'click .RoleOfedit': function (e, value, row, index) {
            update(row.id);
        }
    };
</script>
<script>
    /**
     * 选中父项时，同时选中子项
     * @param datas 所有的数据
     * @param row 当前数据
     * @param id id 字段名
     * @param pid 父id字段名
     */
    function selectChilds(datas,row,id,pid,checked) {
        for(var i in datas){
            if(datas[i][pid] == row[id]){
                datas[i].check=checked;
                selectChilds(datas,datas[i],id,pid,checked);
            };
        }
    }

    function selectParentChecked(datas,row,id,pid){
        for(var i in datas){
            if(datas[i][id] == row[pid]){
                datas[i].check=true;
                selectParentChecked(datas,datas[i],id,pid);
            };
        }
    }

    function test() {
        var selRows = $table.bootstrapTable("getSelections");
        if(selRows.length == 0){
            alert("请至少选择一行");
            return;
        }

        var postData = "";
        $.each(selRows,function(i) {
            postData +=  this.id;
            if (i < selRows.length - 1) {
                postData += "， ";
            }
        });
        alert("你选中行的 id 为："+postData);

    }

    function add(id) {
        alert("add 方法 , id = " + id);
    }
    function del(id) {
        alert("del 方法 , id = " + id);
    }
    function update(id) {
        alert("update 方法 , id = " + id);
    }

    //窗口状态
    var state;
    function addMeta(id) {
        state = true;
        $("#metaForm").clearForm();
        if(id==null){
            $("#parentMetaDiv").hide();
            $(".modal-title").text("新增根元数据");
        }else{
            $("#parentMetaDiv").show();
            var row = $('#table').bootstrapTable('getRowByUniqueId',id);
            $("[name='pName']").val(row==null?'根节点':row.name);
            $("[name='pid']").val(row==null?'':row.id);
            $(".modal-title").text("新增元数据");
        }
        $('#metaModal').modal();
    }

    function getMetaById(id) {
        var row = $('#table').bootstrapTable('getRowByUniqueId',id);
        var pRow;
        if(row.pid!=""&&row.pid!=null){
            pRow = $('#table').bootstrapTable('getRowByUniqueId',row.pid);
        }
        state = false;
        $("[name='pName']").val(pRow==null?'根节点':pRow.name);
        $("[name='description']").val(row.description);
        $("#parentMetaDiv").show();
        $(".modal-title").text("修改元数据");
        $.ajax({
            type:"GET",
            url:"${base}/metadata/edit?id="+id,
            dataType:"json",
            success:function(data){
                if(data.success){
                    $("#metaForm").setForm(data.data);
                    $('#metaModal').modal();
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
            saveMeta();
        }else{
            updateMeta();
        }
    }

    function saveMeta(){
        $.ajax({
            type:"POST",
            url:"${base}/metadata/add",
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

    function updateMeta(){
        $.ajax({
            type:"POST",
            url:"${base}/metadata/edit",
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

    function deleteMeta(id) {
        layer.confirm("你确定要删除该元数据吗？",{btn:['确定','取消']},
            function(){
                $.post("${base}/metadata/delete",{"id":id},function (res){
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

</script>




</body>

</html>
