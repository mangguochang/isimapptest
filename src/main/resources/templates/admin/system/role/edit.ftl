<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>角色修改--layui后台管理模板</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/common.css" media="all" />
    <style type="text/css">
        .layui-form-item .layui-inline{ min-width:15%; float:left; margin-right:0 }
        .layui-form-item .role-box {
            position: relative;
        }
    </style>
</head>
<body class="childrenBody">
<form class="layui-form" style="width: 80%;margin: 0px auto;">

    <div class="layui-form-item">
        <input type="hidden" name="id" value="${role.id}">

        <label class="layui-form-label required">角色编号</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="roleCode" value="${role.roleCode}" lay-verify="required">
        </div>

    </div>

    <div class="layui-form-item">

        <label class="layui-form-label required">角色名称</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="roleName"value="${role.roleName}"  lay-verify="required">
        </div>

    </div>

    <div class="layui-form-item">

        <label class="layui-form-label required">角色类型</label>
        <div class="layui-input-block">
            <select name="roleType">
                <option value=""></option>
                <option value="0">管理员</option>
                <option value="1">服务提供方开发者</option>
                <option value="2">服务使用方开发者</option>
            </select>
        </div>

    </div>

    <div class="layui-form-item">

        <label class="layui-form-label required">角色描述</label>
        <div class="layui-input-block">
            <textarea name="roleDesc" class="layui-textarea">${role.roleDesc}</textarea>
        </div>

    </div>

    <div class="layui-form-item" >
        <div class="layui-input-block" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="editRole" style="width: 100px;">确定</button>
            <a class="layui-btn" onclick="closeILayerBt()" style="width: 100px;background: lightgrey;">返回</a>
        </div>
    </div>
</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script>
    Array.prototype.contains = function ( needle ) {
        for (i in this) {
            if (this[i] == needle) return true;
        }
        return false;
    };
    layui.use(['form','jquery','layer'],function(){
        var form = layui.form,
                $    = layui.jquery,
                layer = layui.layer;

        form.on("submit(editRole)",function(data){
            if(data.field.id == null){
                layer.msg("用户ID不存在");
                return false;
            }

            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            $.ajax({
                type:"POST",
                url:"${base}/admin/system/role/edit",
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(data.field),
                success:function(res){
                    layer.close(loadIndex);
                    if(res.success){
                        parent.layer.msg("角色修改成功！",{time:1000},function(){
                            //刷新父页面
                            parent.location.reload();
                        });
                    }else{
                        layer.msg(res.message,{time:1000},function(){
                            //刷新本页面
                            //location.reload();
                        });

                    }
                }
            });
            return false;
        });

        // 回显下拉框
        $("[name='roleType']").val("${role.roleType}");
        form.render(); //更新全部
        form.render('select'); //刷新select选择框渲染
    });

</script>
</body>
</html>