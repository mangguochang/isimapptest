// 序列号表单
jQuery.prototype.serializeObject=function(){
    var obj=new Object();
    $.each(this.serializeArray(),function(index,param){
        if(!(param.name in obj)){
            obj[param.name]=param.value;
        }
    });
    return obj;
};

//form表单自动赋值
$.fn.setForm = function(jsonValue) {
    var obj=this;
    $.each(jsonValue, function (name, ival) {
        var $oinput = obj.find("input[name='" + name + "']");
        if($oinput==undefined){
            return true;
        }else if ($oinput.attr("type")== "radio" || $oinput.attr("type")== "checkbox"){
            $oinput.each(function(){
                if(Object.prototype.toString.apply(ival) == '[object Array]'){//是复选框，并且是数组
                    for(var i=0;i<ival.length;i++){
                        if($(this).val()==ival[i])
                            $(this).prop("checked", "checked");
                    }
                }else{
                    if($(this).val()==ival)
                        $(this).prop("checked", "checked");
                }
            });
        }else if($oinput.attr("type")== "textarea"){//多行文本框
            obj.find("[name='"+name+"']").html(ival);
        }else{
            obj.find("[name='"+name+"']").val(ival);
        }
    });
};

/**
 * 将指定的form表单上的input、select、textarea的数据清除，隐藏框作为参数可选输入true/false或者是样式属性
 */
$.fn.clearForm = function(includeHidden) {
    if(includeHidden==null){
        includeHidden = true;
    }
    return this.each(function() {
        $('input,select,textarea', this).clearFields(includeHidden);    //this表示设置上下文环境，有多个表单时只作用指定的表单
    });
};

$.fn.clearFields = $.fn.clearInputs = function(includeHidden) {
    var re = /^(?:color|date|datetime|email|month|number|password|range|search|tel|text|time|url|week)$/i; // 正则表达式匹配type属性
    return this.each(function() {
        var t = this.type, tag = this.tagName.toLowerCase(); //获取元素的type属性和标签
        if (re.test(t) || tag == 'textarea') {
            this.value = '';
        }
        else if (t == 'checkbox' || t == 'radio') {
            this.checked = false;
        }
        else if (tag == 'select') {
            this.selectedIndex = -1;
        }
        else if (t == "file") {
            if (/MSIE/.test(navigator.userAgent)) {
                $(this).replaceWith($(this).clone(true));
            } else {
                $(this).val('');
            }
        }
        else if (includeHidden) {
            if ( (includeHidden === true && /hidden/.test(t)) ||
                (typeof includeHidden == 'string' && $(this).is(includeHidden)) ) {   //true 、false或者样式属性
                this.value = '';
            }
        }
    });
};

var layer;
layui.use(['layer','form','table'], function() {
    layer = layui.layer,
        $ = layui.jquery,
        form = layui.form,
        table = layui.table;
})

function format(timestamp){
    //timestamp是整数，否则要parseInt转换,不会出现少个0的情况
    var time = new Date(timestamp);
    var year = time.getFullYear();
    var month = time.getMonth()+1;
    var date = time.getDate();
    var hours = time.getHours();
    var minutes = time.getMinutes();
    var seconds = time.getSeconds();
    return year+'-'+add0(month)+'-'+add0(date)+' '+add0(hours)+':'+add0(minutes)+':'+add0(seconds);
}

function add0(m) {
    return m < 10 ? '0' + m : m
}

//获取UUID
function guid() {
    function S4() {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
}

//是否为空 isBlank("")==>true;  isBlank(null)==>true; isBlank({})==>true
function isBlank(){
    var arguments = arguments;
    //如果上级方法是isNotBlank，则获取其参数集
    var parentFunc = "";
    if(isBlank.caller){
        var caller = isBlank.caller.toString();
        var re = /function\s*(\w*)/i;
        var matches = re.exec(caller);//方法名
        var parentFunc = matches[1];
        if(parentFunc=="isNotBlank"){
            arguments = isBlank.caller.arguments;
        }
    }
    for(var i in arguments){
        var arg = arguments[i];
        if(arg==null){
            return true;
        }else if(typeof(arg)=="string"){
            if(arg==""||arg==null){
                return true;
            }
        }else if(typeof(arg)=="object"){
            if(arg==null){
                return true;
            }else if(Object.keys(arg).length==0){
                return true;
            }
        }
    }
    return false;
}

function isNotBlank() {
    return !isBlank(arguments);
}

function disableForm(formId,isDisabled) {
    var attr="disable";
    if(!isDisabled){
        attr="enable";
    }
    var content = "";
    if(isNotBlank(formId)){
        content = "[id='"+formId+"']";
    }
    $("form"+content+" :text").attr("disabled",isDisabled);
    $("form"+content+" textarea").attr("disabled",isDisabled);
    $("form"+content+" select").attr("disabled",isDisabled);
    $("form"+content+" :radio").attr("disabled",isDisabled);
    $("form"+content+" :checkbox").attr("disabled",isDisabled);
}

//点击复制
function execClick(){
    document.execCommand("copy");
}

function execCopy(event,thisDiv){
    if(isIE()){
        if(window.clipboardData){
            window.clipboardData.setData("Text", thisDiv.textContent);
            //window.clipboardData.getData("Text")
            layer.msg("复制成功");
        }
    }else{
        event.preventDefault();
        if (event.clipboardData) {
            event.clipboardData.setData("text/plain", thisDiv.textContent);
            // layer.msg(event.clipboardData.getData("text"));
            layer.msg("复制成功");
        }
    }
}

function isIE(){
    var input = window.document.createElement ("input");
    //"!window.ActiveXObject" is evaluated to true in IE11
    if (window.ActiveXObject === undefined) return null;
    if (!window.XMLHttpRequest) return 6;
    if (!window.document.querySelector) return 7;
    if (!window.document.addEventListener) return 8;
    if (!window.atob) return 9;
    //"!window.document.body.dataset" is faster but the body is null when the DOM is not
    //ready. Anyway, an input tag needs to be created to check if IE is being
    //emulated
    if (!input.dataset) return 10;
    return 11;
}