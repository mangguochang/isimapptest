<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/common.css" media="all" />
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <style type="text/css">
        .layui-form-item .layui-inline{ min-width:15%; float:left; margin-right:0; }
        .layui-form-item .role-box {
            position: relative;
        }

    </style>
</head>
<body class="childrenBody">


<form class="layui-form" style="width: 80%;margin: 0px auto;">

    <div class="layui-form-item">

        <label class="layui-form-label required">角色编号</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="roleCode" lay-verify="required">
        </div>

    </div>

    <div class="layui-form-item">

        <label class="layui-form-label required">角色名称</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="roleName" lay-verify="required">
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
            <textarea name="roleDesc" class="layui-textarea"></textarea>
        </div>

    </div>

    <div class="layui-form-item" >
        <div class="layui-input-block" style="text-align: center;">
            <button class="layui-btn" lay-submit="" lay-filter="addRole" style="width: 100px;">确定</button>
            <a class="layui-btn" onclick="closeILayerBt()" style="width: 100px;background: lightgrey;">返回</a>
        </div>
    </div>
</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    Array.prototype.contains = function ( needle ) {
        for (i in this) {
            if (this[i] == needle) return true;
        }
        return false;
    };
    layui.use(['form','layer','jquery'], function(){
        var form = layui.form,
            layer = layui.layer,
                $ = layui.jquery;
        form.on('checkbox(roleMenu)',function(data){
            var v = data.elem.getAttribute("data-parentIds"),
            myarr=v.split(",");
            var child = $(data.elem).parents('form').find('input[type="checkbox"]');
            if(data.elem.checked){//勾选的时候的动作,父栏目层级全部勾选
                child.each(function(index, item){
                    if(myarr.contains(item.value)){
                        item.checked = data.elem.checked;
                    }
                });
            }else{ //取消选择的时候，子栏目层级全部取消选择
                child.each(function(index, item){
                    //获取每一个checkbox的 父栏目ID组
                    var r = item.getAttribute("data-parentIds"),
                    noarr = r.split(",");
                    if(noarr.contains(data.value)){
                        item.checked = data.elem.checked;
                    }
                });
            }
            form.render('checkbox');
        });
        form.on('submit(addRole)',function(data){
            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            $.ajax({
                type:"POST",
                url:"${base}/admin/system/role/add",
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(data.field),
                success:function(res){
                    layer.close(loadIndex);
                    if(res.success){
                        parent.layer.msg("用户添加成功！",{time:1000},function(){
                            //刷新父页面
                            parent.location.reload();
                        });
                    }else{
                        layer.msg(res.message);
                    }
                }
            });
            return false;
        });
    });

</script>
</body>
</html>