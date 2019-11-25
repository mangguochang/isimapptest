<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人资料--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel = "shortcut icon" href="${base}/static/images/logo.ico">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/user.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/common.css" media="all" />
    <style>
        .userFace{
            display: block;
            width: 200px;
            height: 200px;
            margin: 0 auto;
            margin-bottom: 15px;
        }
        .layui-form-item .layui-input-inline{
            width: 287px;
        }
    </style>
</head>
<body class="childrenBody">
<form class="layui-form">
    <div class="layui-row">
        <div  style="width: 80%;margin: 0px auto;height: 440px;">
            <div class="user_right">
                <input class="layui-hide" name="id" value="${userinfo.id}"/>

                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">登录账号</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.loginName}" name="loginName" disabled class="layui-input layui-disabled">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">昵称</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.nickName}" name="nickName" class="layui-input">
                        </div>
                    </div>

                </div>

                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">真实姓名</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.realName}" name="realName" disabled class="layui-input layui-disabled">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">出生日期</label>
                        <div class="layui-input-inline">
                            <input type="text"  name="birthday"  id="birthday" lay-verify="date" placeholder="yyyy-MM-dd"  autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>

                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">性别</label>
                        <div class="layui-input-inline">
                            <input type="radio" name="sex"  value="0" title="男"<#if (userinfo.sex == 0)> checked="" </#if>>
                            <input type="radio" name="sex"  value="1" title="女"<#if (userinfo.sex == 1)> checked="" </#if>>
                        </div>
                    </div>


                    <div class="layui-inline">
                        <label class="layui-form-label">职务</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.position}" name="position" class="layui-input">
                        </div>
                    </div>

                </div>

                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">所属部门</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.dept.deptName}" name="deptName" disabled class="layui-input layui-disabled">
                        </div>
                    </div>

                </div>

                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">电子邮箱</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.email}" name="email"  class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">手机号码</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.mobileNum}" name="mobileNum"  class="layui-input" >
                        </div>
                    </div>

                </div>


                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">联系地址</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.address}" name="address" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">邮政编码</label>
                        <div class="layui-input-inline">
                            <input type="text" value="${userinfo.postCode}" name="postCode" class="layui-input">
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div style="width: 80%;margin: 0px auto;">
            <div class="layui-form-item">
                <div class="layui-input-block" style="text-align: center;">
                    <button class="layui-btn" lay-submit="" lay-filter="changeUser" style="width: 100px;">确定</button>
                    <button type="button" class="layui-btn layui-btn-primary restuserinfo" style="width: 100px;">重置</button>
                </div>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer','upload','laydate'],function() {
        var form = layui.form,
                $ = layui.jquery,
                upload = layui.upload,
                laydate = layui.laydate,
                layer = layui.layer;
        //生日
        laydate.render({
            elem: '#birthday',
            value: '${(userinfo.birthday?string("yyyy-MM-dd"))!}',
            trigger: 'click'
        });

        //普通图片上传
        upload.render({
            elem: '#test1',
            url: '${base}/file/upload/',
            field: 'test',
            before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#userFace').attr('src', result); //图片链接（base64）
                });
                layer.load(2, {
                    shade: [0.3, '#333']
                });
            },
            done: function (res) {
                layer.closeAll('loading');
                //如果上传失败
                if (res.success === false) {
                    return layer.msg('上传失败');
                }else{
                    layer.msg("上传成功",{time:1000},function () {
                        $("input[name='icon']").val(res.data.url);
                    })
                }
            }
        });

        form.on("submit(changeUser)",function (data) {
            if(data.field.id == null){
                layer.msg("用户ID不存在");
                return false;
            }
            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            $.ajax({
                type:"POST",
                url:"${base}/admin/system/user/saveUserinfo",
                dataType:"json",
                contentType:"application/json",
                data:JSON.stringify(data.field),
                success:function(res){
                    layer.close(loadIndex);
                    if(res.success){
                        layer.msg("您的个人信息保存成功",{time:1000},function () {
                            location.reload();
                        });
                    }else{
                        layer.msg(res.message,{time:1000});
                    }
                }
            });
            <#--$.post("${base}/admin/system/user/saveUserinfo",data.field,function(res){-->
                <#--layer.close(loadIndex);-->
                <#--if(res.success){-->
                    <#--parent.layer.msg("您的个人信息保存成功！",{time:1500},function(){-->
                        <#--parent.location.reload();-->
                    <#--});-->
                <#--}else{-->
                    <#--layer.msg(res.message);-->
                <#--}-->
            <#--});-->
            return false;
        });

        $(".restuserinfo").on("click",function () {
            window.location.reload();
        });

        // 回显下拉框
        form.render(); //更新全部
        form.render('select'); //刷新select选择框渲染

    });
</script>
</body>
</html>