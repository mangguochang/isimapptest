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

            </div>

            <div class="layui-form-item" style="display: inline-table;width: 40%;">

                <label class="layui-form-label">真实姓名</label>
                <div class="layui-input-block" style="width: 50%;margin-bottom: 10px;">
                    <input type="s_realName" name="s_realName"  autocomplete="off" class="layui-input">
                </div>

            </div>

            <div class="layui-inline">
                <a class="layui-btn" lay-submit="" lay-filter="searchForm">查询</a>
            </div>

            <div class="layui-inline">
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>

            <div class="layui-form-item" style="padding-left: 40px;">
                <div class="layui-inline">
                    <a class="layui-btn layui-btn-normal" data-type="addToRole">添加到角色</a>
                </div>
            </div>

        </form>
    </div>
</fieldset>
<div class="layui-form users_list">
    <table class="layui-table" id="test" lay-filter="test"></table>
    <#--序号-->
    <script type="text/html" id="indexTpl">
        {{d.LAY_TABLE_INDEX+1}}
    </script>
</div>
<div id="page"></div>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script type="text/javascript" src="${base}/static/js/tools.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script>
    var gloable_pm_codes = new Array();// 勾选的pm_code集合
    var gloable_pm_names = new Array();
    var gloable_pm_full = new Array();
    var table_data = new Array();// 表格数据缓存

    layui.use(['layer','form','table'], function() {
        var layer = layui.layer,
            $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            t;                  //表格数据变量

        t = {
            elem: '#test',
            url:'${base}/admin/system/role/member/add',
            method:'post',
            where:{s_roleId:'${roleId}'},
            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'], //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                groups: 2, //只显示 1 个连续页码
                first: "首页", //显示首页
                last: "尾页", //显示尾页
                limits:[3,10, 20, 30]
            },
            width: $(parent.window).width()-40,
            cols: [[
                {type:'checkbox'},
                {title: '序号',templet: '#indexTpl',width:'15%'},
                {field:'loginName', title: '登录账号'},
                {field:'realName',  title: '真实姓名'}
            ]],
            done:function(res,curr,count){
                // 设置换页勾选之前的
                table_data = res.data;
                //在缓存中找到PM_CODE ,然后设置data表格中的选中状态
                //循环所有数据，找出对应关系，设置checkbox选中状态
                for (var i = 0; i < res.data.length; i++) {
                    for (var j = 0; j < gloable_pm_codes.length; j++) {
                        if (res.data[i].id == gloable_pm_codes[j]) {
                            //这里才是真正的有效勾选
                            res.data[i]["LAY_CHECKED"] = 'true';
                            //找到对应数据改变勾选样式，呈现出选中效果
                            var index = res.data[i]['LAY_TABLE_INDEX'];
                            $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').prop('checked', true);
                            $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').next().addClass('layui-form-checked');
                        }
                    }
                }
                //设置全选checkbox的选中状态，只有改变LAY_CHECKED的值， table.checkStatus才能抓取到选中的状态
                var checkStatus = table.checkStatus('test');
                if (checkStatus.isAll) {
                    $(' .layui-table-header th[data-field="0"] input[type="checkbox"]').prop('checked', true);
                    $('.layui-table-header th[data-field="0"] input[type="checkbox"]').next().addClass('layui-form-checked');
                }
            }
        };
        //复选框选中监听,将选中的id 设置到缓存数组,或者删除缓存数组
        table.on('checkbox(test)', function (obj) {
            if (obj.checked == true) {
                if (obj.type == 'one') {
                    var single = new Array();
                    single.push(obj.data);
                    addToCache(single);
                } else {
                    addToCache(table_data);
                }
            } else {
                if (obj.type == 'one') {
                    // for (var i = 0; i < gloable_pm_codes.length; i++) {
                    //     if (gloable_pm_codes[i] == obj.data.id) {
                    //         gloable_pm_codes.remove(i);
                    //         gloable_pm_names.remove(i);
                    //     }
                    // }
                    var single = new Array();
                    single.push(obj.data);
                    removeCache(single);
                } else {
                        // for (var j = 0; j < table_data.length; j++) {
                        //     var index = gloable_pm_codes.indexOf(table_data[j].id);
                        //     if (index>=0) {
                        //         gloable_pm_codes.remove(index);
                        //         gloable_pm_names.remove(index);
                        //     }
                        // }
                    removeCache(table_data)
                }
            }
        });
        //删除数组自定义函数
        Array.prototype.remove = function (dx) {
            if (isNaN(dx) || dx > this.length) {
                return false;
            }
            for (var i = 0, n = 0; i < this.length; i++) {
                if (this[i] != this[dx]) {
                    this[n++] = this[i]
                }
            }
            this.length -= 1
        }

        table.render(t);

        var active={
            //批量添加到角色
            addToRole : function(){
                // var checkStatus = table.checkStatus('test'),
                //      data = checkStatus.data;
                data = gloable_pm_full;
                if(data.length > 0){
                    layer.confirm("你确定要添加到角色吗？",{btn:['确定','取消']},
                        function(){
                            var  addindex = layer.msg('添加中，请稍候',{icon: 16,time:false,shade:0.8});
                            $.ajax({
                                type:"POST",
                                url:"${base}/admin/system/role/addSomeMember?roleId=${roleId}",
                                dataType:"json",
                                contentType:"application/json",
                                data:JSON.stringify(data),
                                success:function(res){
                                    layer.close( addindex);
                                    if(res.success){
                                        layer.msg("添加成功",{time: 1000},function(){
                                            table.reload('test', t);
                                            closeILayerBt()
                                        });
                                    }else{
                                        layer.msg(res.message);
                                    }
                                }
                            });
                        }
                    )
                }else{
                    layer.msg("请选择需要添加到角色的人员",{time:1000});
                }
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

    });

    function addToCache(table_data){
        for (var i = 0; i < table_data.length; i++) {
            if (gloable_pm_codes.indexOf(table_data[i].id)<0) {
                gloable_pm_codes.push(table_data[i].id);
                gloable_pm_names.push(table_data[i].loginName);
                gloable_pm_full.push(table_data[i]);
            }
        }
    }

    function removeCache(table_data){
        for (var j = 0; j < table_data.length; j++) {
            var index = gloable_pm_codes.indexOf(table_data[j].id);
            if (index>=0) {
                gloable_pm_codes.remove(index);
                gloable_pm_names.remove(index);
                gloable_pm_full.remove(index);
            }
        }
    }
</script>
</body>
</html>