<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户详细--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/common.css" media="all" />
    <link rel="stylesheet" href="${base}/static/layui/formselect/formSelects-v4.css" media="all"/>
    <style type="text/css">
        .layui-form-item .layui-inline{ width:33.333%; float:left; margin-right:0; }
        @media(max-width:1240px){
            .layui-form-item .layui-inline{ width:100%; float:none; }
        }
        .layui-form-item .role-box {
            position: relative;
        }
        .layui-form-item .role-box .jq-role-inline {
            height: 100%;
            overflow: auto;
        }

    </style>
</head>
<body class="childrenBody">
<form class="layui-form" style="width:80%;margin: 0px auto;">

    <input class="layui-hide" name="id" value="${user.id}"/>
    <div class="layui-form-item">
        <label class="layui-form-label required">登录名称</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="loginName" value="${user.loginName}" disabled autocomplete="off" lay-verify="required">
        </div>
    </div>

    <div class="layui-form-item">
            <label class="layui-form-label required">真实姓名</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="realName" value="${user.realName}" disabled autocomplete="off" lay-verify="required">
            </div>
    </div>

    <div class="layui-form-item">
            <label class="layui-form-label required">手机号码</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="mobileNum" disabled value="${user.mobileNum}" autocomplete="off"  lay-verify="required|phone">
            </div>
    </div>

    <div class="layui-form-item">
            <label class="layui-form-label required">电子邮箱</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="email" value="${user.email}" disabled autocomplete="off" lay-verify="required|email">
            </div>
    </div>

    <div class="layui-form-item">
            <label class="layui-form-label required">所属部门</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="deptName" value="${user.dept.deptName}" disabled autocomplete="off" >
            </div>
    </div>

    <div class="layui-form-item">
            <label class="layui-form-label required">分配角色</label>
            <div class="layui-input-block">
                <select name="roleIdList"  xm-select="roleIdList" disabled >
                    <option value=""></option>
                    <#if roleList?? && roleList?size gt 0>
                        <#list roleList as node>
                            <option value="${node.value}">${node.label}</option>
                        </#list>
                    </#if>
                </select>
            </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">显示顺序</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="sort" disabled value="${user.sort}" autocomplete="off" lay-verify="required|number">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">账户状态</label>
        <div class="layui-input-block">
            <#if (user.locked == 1)>
                <input type="text" class="layui-input" value="停用" disabled>
            <#else>
                <input type="text" class="layui-input" value="启用" disabled>
            </#if>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" style="text-align: center;">
            <a class="layui-btn" onclick="closeILayerBt()" style="width: 100px;background: lightgrey;">返回</a>
        </div>
    </div>

</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script>
    //全局定义一次, 加载formSelects
    layui.config({
        base: '${base}/static/layui/formselect/' //此处路径请自行处理, 可以使用绝对路径
    }).extend({
        formSelects: 'formSelects-v4'
    });

    var index = parent.layer.getFrameIndex(window.name); //当前窗口索引
    layui.use(['form','jquery','layer','formSelects'],function(){
        var form = layui.form,
                $    = layui.jquery,
                layer = layui.layer,
                formSelects = layui.formSelects;


        form.on("submit(updateUser)",function(data){

            //选中的角色
            var selected = formSelects.value('roleIdList', 'val');
            data.field.roleIdList = selected;

            if(data.field.id == null){
                layer.msg("用户ID不存在");
                return false;
            }
            //给角色赋值
            delete data.field["roles"];
            var selectRole = [];
            $('input[name="roles"]:checked').each(function(){
                selectRole.push({"id":$(this).val()});
            });
            data.field.roleLists = selectRole;

            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            $.ajax({
                type:"POST",
                url:"${base}/admin/system/user/edit",
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(data.field),
                success:function(res){
                    layer.close(loadIndex);
                    if(res.success){
                        parent.layer.msg("用户编辑成功！",{time:1500},function(){
                            parent.location.reload();
                        });
                    }else{
                        layer.msg(res.message);
                    }
                }
            });
            return false;
        });
        //所属角色（多选）
        var list = [];
        <#list user.roleIdList as r>
        list.push("${r}");
        </#list>
        // 回显下拉框
        formSelects.value('roleIdList',list);
        form.render(); //更新全部
        form.render('select'); //刷新select选择框渲染
    });
</script>
</body>
</html>