<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>系统用户列表--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel = "shortcut icon" href="${base}/static/images/logo.ico">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/user.css" media="all" />
</head>
<body class="childrenBody">
<fieldset class="layui-elem-field">
    <legend>用户检索</legend>
    <div class="layui-field-box">
    <form class="layui-form">
        <div class="layui-form-item" style="display: inline-table;width: 40%;">

            <label class="layui-form-label">登录账号</label>
            <div class="layui-input-block" style="width: 50%;margin-bottom: 10px;">
                <input type="text" name="s_loginName"  autocomplete="off" class="layui-input">
            </div>

            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-block" style="width: 50%;margin-bottom: 10px;">
                <select name="s_deptCode">
                    <option value=""></option>
                    <#if deptList?? && deptList?size gt 0>
                        <#list deptList as node>
                            <option value="${node.value}">${node.label}</option>
                        </#list>
                    </#if>
                </select>
            </div>

        </div>

        <div class="layui-form-item" style="display: inline-table;width: 40%;">

            <label class="layui-form-label">真实姓名</label>
            <div class="layui-input-block" style="width: 50%;margin-bottom: 10px;">
                <input type="s_realName" name="s_realName"  autocomplete="off" class="layui-input">
            </div>

            <label class="layui-form-label">账号状态</label>
            <div class="layui-input-block" style="width: 50%;margin-bottom: 10px;">
                <select name="s_locked">
                    <option value=""></option>
                    <option value="0">启用</option>
                    <option value="1">停用</option>
                </select>
            </div>

        </div>

        <div class="layui-inline">
            <a class="layui-btn" lay-submit="" lay-filter="searchForm">查询</a>
        </div>

        <div class="layui-inline">
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>


        <div class="layui-form-item" style="padding: 9px 40px">
            <div class="layui-inline">
                <a class="layui-btn layui-btn-normal" data-type="createUser">新增用户</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-normal" data-type="deleteUser">删除用户</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-normal" data-type="manageMenu">菜单权限管理</a>
            </div>
        </div>

    </form>
    </div>
</fieldset>
<div class="layui-form users_list">
    <table class="layui-table" id="test" lay-filter="demo"></table>
    <#--序号-->
    <script type="text/html" id="indexTpl">
        {{d.LAY_TABLE_INDEX+1}}
    </script>
    <#--部门类型格式化-->
    <script type="text/html" id="deptList">
        <#list deptList as r>
            {{#  if(d.deptCode == "${r.value}"){ }}
            <span>${r.label}</span>
            {{#  } }}
        </#list>
    </script>
    <script type="text/html" id="userStatus">
        <!-- 账号状态 -->
        {{#  if(d.delFlag == false){ }}
        <span class="layui-badge layui-bg-green">正常</span>
        {{#  } else { }}
        <span class="layui-badge layui-bg-gray">停用</span>
        {{#  } }}
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="view">查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    </script>
</div>
<div id="page"></div>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script type="text/javascript" src="${base}/static/js/tools.js"></script>
<script>
    layui.use(['layer','form','table'], function() {
        var layer = layui.layer,
                $ = layui.jquery,
                form = layui.form,
                table = layui.table,
                t;                  //表格数据变量

        t = {
            elem: '#test',
            url:'${base}/admin/system/user/list',
            method:'post',
            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'], //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                groups: 2, //只显示 1 个连续页码
                first: "首页", //显示首页
                last: "尾页", //显示尾页
                limits:[3,10, 20, 30]
            },
            width: $(parent.window).width()-243,
            cols: [[
                {type:'checkbox'},
                {title: '序号',templet: '#indexTpl',width:'5%'},
                {field:'loginName', title: '登录账号',width:'10%'},
                {field:'realName',  title: '真实姓名',width:'10%'},
                {field:'deptCode',  title: '所属部门',    width:'17.5%',templet:'#deptList'},
                {field:'email',     title: '电子邮箱',    width:'14%' },
                {field:'mobileNum',       title: '手机号码',    width:'11%'},
                {field:'locked',       title: '账号状态',    width:'7%',templet:'#userStatus'},
                {field:'createTime',  title: '注册时间',width:'12%',templet:'<div>{{ layui.laytpl.toDateString(d.createTime,"yyyy-MM-dd HH:mm") }}</div>',unresize: true}, //单元格内容水平居中
                {fixed: 'right', title:'操作', width: '10%', align: 'center',toolbar: '#barDemo'}
            ]]
        };
        table.render(t);

        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                var editIndex = layer.open({
                    title : "编辑用户",
                    type : 2,
                    area: ['500px', '620px'],
                    content : "${base}/admin/system/user/edit?id="+data.id,
                    success : function(layero, index){
                        // setTimeout(function(){
                        //     layer.tips('点击此处返回会员列表', '.layui-layer-setwin .layui-layer-close', {
                        //         tips: 3
                        //     });
                        // },500);
                    }
                });
                layer.full(editIndex);
            }else if (obj.event === 'view'){
                var detailIndex = layer.open({
                    title : "用户详细信息",
                    type : 2,
                    area: ['500px', '620px'],
                    content : "${base}/admin/system/user/detail?id="+data.id,
                    success : function(layero, index){
                        // setTimeout(function(){
                        //     layer.tips('点击此处返回会员列表', '.layui-layer-setwin .layui-layer-close', {
                        //         tips: 3
                        //     });
                        // },500);
                    }
                });
                layer.full(detailIndex);
            }
        });

        var active={
            manageMenu : function(){
                var checked = table.checkStatus("test").data;
                if(checked.length!=1){
                    layer.msg("请选择一个授权对象")
                    return;
                }
                var addIndex = layer.open({
                    title : "菜单权限",
                    type : 2,
                    area: ['300px', '420px'],
                    content : "${base}/admin/system/menu/menuTreeUser",
                    success : function(layero, addIndex){

                    }
                });
            }
        };

        $('.layui-inline .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //搜索
        form.on("submit(searchForm)",function(data){
            t.where = data.field;
            table.reload('test', t);
            return false;
        });

        //改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
        $(window).resize(function(){
            var index = $("[id^='layui-layer'").attr("times");
            var winType = $("[id^='layui-layer"+index+"'").attr("type");
            //dialog（删除）不充满整个屏幕
            var title = $("[id^='layui-layer"+index+"'").find(".layui-layer-title").text();
            if(index!=null&&winType!="dialog"&&title!='菜单权限'){
                layer.full(index);
            }
        });

    });
</script>
</body>
</html>