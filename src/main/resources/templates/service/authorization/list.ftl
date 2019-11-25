<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>服务接口审批列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">


    <link href="${base}/static/project/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${base}/static/project/plugins/bootstrapvalidator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="${base}/static/project/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${base}/static/project/css/animate.css" rel="stylesheet">
    <link href="${base}/static/project/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${base}/static/project/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${base}/static/project/plugins/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet" />
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/project/plugins/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="${base}/static/project/plugins/bootstrap-switch/css/bootstrap-switch.min.css">
    <link href="${base}/static/project/css/common.css" rel="stylesheet">
    <style type="text/css" media="screen">
        /*编辑器css*/
        .ace_editor {
            /*position: relative !important;*/
            border: 1px solid lightgray;
            border-radius:5px;
            margin: auto;
            height: 800px;
            width: 80%;
        }
        /*设置文本超出隐藏*/
        .contant {
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
            width: 100px;
            overflow: hidden;
        }
    </style>

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>服务接口审批管理</h5>
                </div>
                <div class="ibox-content">
                    <button type="button" class="btn btn-sm btn-default" onclick="addService()">新增服务接口审批</button>
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
                                                    <input type="text" name="s_serviceName" placeholder="请输入服务名称" id="s_serviceName" class="form-control">
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

<!--查看-->
<div class="modal inmodal fade" id="serviceModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">查看服务信息</h4>
            </div>
            <div class="modal-body">
                <div class="tabs-container">
                    <ul id="serviceInfoTab" class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#tab-1" aria-expanded="true"> 服务基本信息</a>
                        </li>
                        <li class="">
                            <a data-toggle="tab" href="#tab-2" aria-expanded="false">接口基本信息</a>
                        </li>
                        <li class="">
                            <a data-toggle="tab" href="#tab-3" aria-expanded="false">应用基本信息</a>
                        </li>
                        <li class="" id="camelBase" style="display: none" >
                            <a data-toggle="tab" href="#tab-4" aria-expanded="false">camel基本信息</a>
                        </li>
                        <li class="" id="camelDB" style="display: none">
                            <a data-toggle="tab" href="#tab-5" aria-expanded="false">camel DB配置</a>
                        </li>
                        <li class="" id="camelSOAP" style="display: none">
                            <a data-toggle="tab" href="#tab-6" aria-expanded="false">camel CXF配置</a>
                        </li>
                        <li class="">
                            <a data-toggle="tab" href="#tab-7" aria-expanded="false">服务授权信息</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <#--服务基本ixnxi-->
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <form class="form-horizontal" id="serviceForm">

                                    <input type="hidden" name="id" placeholder="" class="form-control">

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">服务名称：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="serviceName" placeholder="" class="form-control">
                                        </div>
                                        <label class="col-sm-2 control-label">版本：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="version" placeholder="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">所属分类：</label>
                                        <div class="col-sm-4">
                                            <select class="form-control m-b" onchange="showSecondClass()" id="serviceClass" name="serviceClass">
                                                <option value="">--请选择--</option>
                                                <#if serviceClassList?? && serviceClassList?size gt 0>
                                                    <#list serviceClassList as obj>
                                                        <option value="${obj.id}">${obj.name}</option>
                                                    </#list>
                                                </#if>
                                            </select>
                                        </div>
                                        <label class="col-sm-2 control-label">二级分类：</label>
                                        <div class="col-sm-4">
                                            <select class="form-control m-b" id="serviceSecondClass" name="serviceSecondClass"></select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">所属系统：</label>
                                        <div class="col-sm-4">
                                            <select class="form-control m-b" id="serviceSystem" name="serviceSystem">
                                                <option value="">--请选择--</option>
                                                <#if sysNameList?? && sysNameList?size gt 0>
                                                    <#list sysNameList as sys>
                                                        <option value="${sys.id}">${sys.name}</option>
                                                    </#list>
                                                </#if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">功能说明：</label>
                                        <div class="col-sm-10">
                                            <textarea name="description" placeholder="" class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">请求参数：</label>
                                        <div class="col-sm-10">
                                            <table id="tb_request"></table>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">返回参数：</label>
                                        <div class="col-sm-10">
                                            <table id="tb_response"></table>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <#--接口基本信息-->
                        <div id="tab-2" class="tab-pane">
                            <div class="panel-body">
                                <form class="form-horizontal"  id="interfaceForm">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">请求方接口ID：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="requestObjId" placeholder="" readonly class="form-control">
                                        </div>
                                        <label class="col-sm-2 control-label">业务场景描述：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="description" placeholder="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">服务类型：</label>
                                        <div class="col-sm-4">
                                            <select name="serviceType" class="form-control m-b">
                                                <option value="db">数据库</option>
                                                <option value="soap">SOAP</option>
                                                <option value="rest" selected="">OPEN API</option>
                                            </select>
                                        </div>
                                        <label class="col-sm-2 control-label">编辑模式：</label>
                                        <div class="col-sm-4">
                                            <select name="editType" class="form-control m-b">
                                                <option value="form">表单模式</option>
                                                <option value="properties">文本模式</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div id="divFormDB" style="display: none">
                                        <span>数据库选择</span>
                                        <hr>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">数据库类型：</label>
                                            <div class="col-sm-4">
                                                <select name="dbType" class="form-control m-b">
                                                    <option value="">--请选择--</option>
                                                    <option value="Oracle">Oracle</option>
                                                    <option value="SQLServer">SQL Server</option>
                                                    <option value="MySQL">MySQL</option>
                                                </select>
                                            </div>
                                            <label class="col-sm-2 control-label">数据库地址：</label>
                                            <div class="col-sm-4">
                                                <select name="dbHost" class="form-control m-b"></select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">操作：</label>
                                            <div class="col-sm-4">
                                                <select name="dbOperateType" class="form-control m-b">
                                                    <option value="">--请选择--</option>
                                                    <option value="select">select</option>
                                                    <option value="insert">insert</option>
                                                    <option value="update">update</option>
                                                    <option value="delete">delete</option>
                                                    <option value="procedure">procedure</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">SQL语句：</label>
                                            <div class="col-sm-10">
                                                <textarea name="sql" class="form-control"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="divFormSoap" style="display: none">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">wsdl路径：</label>
                                            <div class="col-sm-9" style="display: inline-flex;">
                                                <input type="text" id="wsdlUrl" name="wsdlUrl" placeholder="" class="form-control">
                                                <button type="button" id="wsdlBt" class="btn btn-default btn-sm" onclick="loadFunc()">获取方法</button>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">方法名：</label>
                                            <div class="col-sm-10">
                                                <select class="form-control m-b form-control" id="wsdlFunc" name="wsdlFunc"></select>
                                                <#--cxfEndpointConfig.xml 配置信息-->
                                                <#--cxf.adress-->
                                                <input type="hidden" name="camel.wsdl.url">
                                                <input type="hidden" name="camel.wsdl.serviceName">
                                                <input type="hidden" name="camel.wsdl.endpointName">
                                                <#--cxf.xmlns:ns1-->
                                                <#--<input type="hidden" name="camel.wsdl.targetNamespace">-->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Content-Type：</label>
                                            <div class="col-sm-4">
                                                <#--WSDL模板发送给目标WSDL服务器的头部Content-Type属性值-->
                                                <input type="text" name="camel.wsdl.request.header.content-Type" placeholder="text/xml;charset=utf-8" class="form-control">
                                            </div>
                                            <label class="col-sm-2 control-label">XmlnsWeb：</label>
                                            <div class="col-sm-4">
                                                <#--WSDL模板程序拼装标签名称-->
                                                <input type="text" name="camel.wsdl.xmlnsWeb" placeholder="WSDL模板程序拼装标签名称" class="form-control">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">TargetNamespace：</label>
                                            <div class="col-sm-4">
                                                <#--WSDL目标服务的命名空间-->
                                                <input type="text" name="camel.wsdl.targetNamespace" placeholder="WSDL目标服务的命名空间" class="form-control" readonly>
                                            </div>
                                            <label class="col-sm-2 control-label">JsonNode：</label>
                                            <div class="col-sm-4">
                                                <#-- WSDL服务返回数据后，指定返回的JSON节点-->
                                                <input type="text" name="camel.wsdl.return.jsonNode" placeholder=" WSDL服务返回数据后，指定返回的JSON节点" class="form-control">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">替换节点配置：</label>
                                            <div class="col-sm-10">
                                                <#--WSDL服务返回数据后，需要替换的节点配置（需要替换掉的特殊字符）-->
                                                <input type="text" name="camel.json.format.split.str" data-toggle="tooltip" data-placement="top"
                                                       title="WSDL服务返回数据后，需要替换的节点配置（需要替换掉的特殊字符）"
                                                       placeholder="@xmlns:;@msdata:;@minOccurs:;@xs:;@diffgr:;diffgr:;@" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div id="divFormOpenAPI" style="display: none">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">OPEN API路径：</label>
                                            <div class="col-sm-9" style="display: inline-flex;">
                                                <input type="text" id="openAPIUrl" name="openAPIUrl" placeholder="" class="form-control">
                                                <button type="button" id="openAPIBt" class="btn btn-default btn-sm" onclick="loadFuncSwagger();">获取方法</button>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">方法名：</label>
                                            <div class="col-sm-10">
                                                <select class="form-control m-b" id="openAPIFunc" name="openAPIFunc"></select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">请求地址：</label>
                                            <div class="col-sm-4">
                                                <#--Rest组件请求目标接口的URL-->
                                                <input type="text" name="camel.request.url" placeholder="" class="form-control" readonly>
                                            </div>
                                            <label class="col-sm-2 control-label">请求超时时间：</label>
                                            <div class="col-sm-4">
                                                <#--Rest组件请求超时时间-->
                                                <input type="text" name="camel.request.timeout" placeholder="" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div id="divFormCamelInfo" style="display: none">
                                        <#--公共配置部分-->
                                        <span>Camel应用信息</span>
                                        <hr>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">应用名称：</label>
                                            <div class="col-sm-4">
                                                <input type="text" name="spring.application.name" placeholder="openshift-template-app" class="form-control">
                                            </div>
                                            <label class="col-sm-2 control-label">应用端口：</label>
                                            <div class="col-sm-4">
                                                <input type="text" name="server.port" placeholder="8089" class="form-control">
                                            </div>
                                        </div>
                                        <span>Camel Rest组件配置信息</span>
                                        <hr>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">端口：</label>
                                            <div class="col-sm-4">
                                                <input type="text" name="camel.rest.port" placeholder="8080" class="form-control">
                                            </div>
                                            <label class="col-sm-2 control-label">Api接口标题：</label>
                                            <div class="col-sm-4">
                                                <input type="text" name="camel.rest.api-property[api.title]" placeholder="User API" class="form-control">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Api接口版本号：</label>
                                            <div class="col-sm-4">
                                                <input type="text" name="camel.rest.api-property[api.version]" placeholder="1.0.0" class="form-control">
                                            </div>
                                            <label class="col-sm-2 control-label">根节点名称：</label>
                                            <div class="col-sm-4">
                                                <input type="text" name="xml.elementName" placeholder="Person" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">授权码：</label>
                                        <div class="col-sm-9" style="display: inline-flex;">
                                            <input type="text" name="accessToken" placeholder="" class="form-control">
                                            <button type="button" class="btn btn-default btn-sm">获取授权码</button>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">标签：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="tag" placeholder="" class="form-control">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <#--应用基本信息-->
                        <div id="tab-3" class="tab-pane">
                            <div class="panel-body">
                                <form class="form-horizontal" id="appForm">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">应用名称：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="applicationName" placeholder="" class="form-control">
                                        </div>
                                        <label class="col-sm-2 control-label">应用域名：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="applicationHostName" placeholder="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">项目空间：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="namespace" placeholder="" class="form-control">
                                        </div>
                                        <label class="col-sm-2 control-label">容器运行内存：</label>
                                        <div class="col-sm-4">
                                            <input type="text" name="memoryLimit" placeholder="单位：（M）" class="form-control">
                                            <#--<span style="display: flex;align-items: center;">M</span>-->
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <#--camel基本信息-->
                        <div id="tab-4" class="tab-pane">
                            <div class="panel-body">
                                <div id="editorA" style="width: 100%;"></div>
                            </div>
                        </div>
                        <#--camel componetConfig基本信息-->
                        <div id="tab-5" class="tab-pane">
                            <div class="panel-body">
                                <div id="editorB" style="width: 100%;"></div>
                            </div>
                        </div>
                        <#--camel componetConfig基本信息-->
                        <div id="tab-6" class="tab-pane">
                            <div class="panel-body">
                                <div id="editorC" style="width: 100%;"></div>
                            </div>
                        </div>
                        <#--服务授权信息-->
                        <div id="tab-7" class="tab-pane">
                            <div class="panel-body">
                                <form class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">请求编号：</label>
                                        <div class="col-sm-4">
                                            <input type="nodeName" placeholder="" class="form-control">
                                        </div>
                                        <label class="col-sm-2 control-label">请求部门：</label>
                                        <div class="col-sm-4">
                                            <input type="nodeName" placeholder="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">请求时间：</label>
                                        <div class="col-sm-4">
                                            <input type="nodeName" placeholder="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-10" style="float: right;">
                                            <button type="button" class="btn btn-default btn-sm">查询</button>
                                            <button type="button" class="btn btn-sm btn-info">重置</button>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <table class="table table-bordered">
                                                <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>请求编号</th>
                                                    <th>服务名称</th>
                                                    <th>请求来源</th>
                                                    <th>授权状态</th>
                                                    <th>请求时间</th>
                                                    <th>授权时间</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>20191012001</td>
                                                    <td>服务1</td>
                                                    <td>来源1</td>
                                                    <td>已授权</td>
                                                    <td style="text-align: center;">2019-10-01 15:09:49</td>
                                                    <td style="text-align: center;">2019-10-01 15:09:49</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>20191012002</td>
                                                    <td>服务2</td>
                                                    <td>来源2</td>
                                                    <td>已授权</td>
                                                    <td style="text-align: center;">2019-10-02 15:09:49</td>
                                                    <td style="text-align: center;">2019-10-02 15:09:49</td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>20191012003</td>
                                                    <td>服务3</td>
                                                    <td>来源3</td>
                                                    <td>未授权</td>
                                                    <td style="text-align: center;">2019-10-03 15:09:49</td>
                                                    <td style="text-align: center;">2019-10-03 15:09:49</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


<!-- 全局js -->
<script src="${base}/static/project/js/jquery.min.js?v=2.1.4"></script>
<script src="${base}/static/project/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${base}/static/project/plugins/bootstrapvalidator/js/bootstrapValidator.js"></script>
<script src="${base}/static/project/plugins/bootstrapvalidator/js/language/zh_CN.js"></script>
<script src="${base}/static/project/plugins/jeditable/jquery.jeditable.js"></script>


<script src="${base}/static/project/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${base}/static/project/plugins/bootstrap3-editable/js/bootstrap-editable.js"></script>
<script src="${base}/static/project/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script src="${base}/static/project/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="${base}/static/project/plugins/bootstrap-table/editable/bootstrap-table-editable.js"></script>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script src="${base}/static/project/plugins/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
<script src="${base}/static/project/plugins/ace/1.2.6/js/ace.js" ></script>
<script src="${base}/static/project/plugins/ace/1.2.6/js/ext-language_tools.js" ></script>
<script src="${base}/static/project/plugins/bootstrap-switch/js/bootstrap-switch.min.js" ></script>
<!-- 自定义js -->
<script src="${base}/static/project/js/content.js?v=1.0.0"></script>
<script src="${base}/static/project/common.js?v=1.0.0"></script>

<script>
	//添加鼠标悬浮提示
    $(function () { $("[data-toggle='tooltip']").tooltip(); });

    //==== 代码编辑器初始化 ====
    //引入语言工具
    ace.require("ace/ext/language_tools");
    var editorA = ace.edit("editorA");
    //选择主题
    editorA.setTheme("ace/theme/twilight");
    //选择语言
    editorA.session.setMode("ace/mode/properties");
    //各项设置
    editorA.setOptions({
        enableBasicAutocompletion : true,
        enableSnippets : true,
        enableLiveAutocompletion : true
    });

    var editorB = ace.edit("editorB");
    //选择主题
    editorB.setTheme("ace/theme/twilight");
    //选择语言
    editorB.session.setMode("ace/mode/properties");
    //各项设置
    editorB.setOptions({
        enableBasicAutocompletion : true,
        enableSnippets : true,
        enableLiveAutocompletion : true
    });

    var editorC = ace.edit("editorC");
    //选择主题
    editorC.setTheme("ace/theme/twilight");
    //选择语言
    editorC.session.setMode("ace/mode/xml");
    //各项设置
    editorC.setOptions({
        enableBasicAutocompletion : true,
        enableSnippets : true,
        enableLiveAutocompletion : true
    });


    function setCamelInfoValue(serviceId,serviceType) {
        $.ajax({
            url:"${base}/service/camel/getCamelProperties",
            type:"POST",
            data:{
                serviceId:serviceId,
                serviceType:serviceType
            },
            dataType:"json",
            success:function(data){
                var el = document.getElementById("editorA");
                el.env.editor.setValue(data, 1);
            }
        })
    }

    function setCamelComponentInfoValue(serviceId) {
        $.ajax({
            url: "${base}/service/camel/getCamelComponentProperties",
            type: "POST",
            data: {
                serviceId: serviceId
            },
            dataType: "json",
            success: function (data) {
                var el = document.getElementById("editorB");
                el.env.editor.setValue(data, 1);
            }
        })
    }

    function setCamelCxfConfigValue(serviceId) {
        $.ajax({
            url: "${base}/service/camel/getCamelCxfConfigPropertiesInfo",
            type: "POST",
            data: {
                serviceId: serviceId
            },
            dataType: "json",
            success: function (data) {
                var el = document.getElementById("editorC");
                el.env.editor.setValue(data, 1);
            }
        })
    }


    function clearEditor(){
        var elA = document.getElementById("editorA");
        elA.env.editor.setValue("", 1);
        var elB = document.getElementById("editorB");
        elB.env.editor.setValue("", 1);
        var elC = document.getElementById("editorC");
        elC.env.editor.setValue("", 1);
    }
</script>

<script>
    $(function(){

        //服务类型
        $("[name='serviceType']").change(function(){
            showContentByEditType();
        });

        //服务类型
        $("[name='editType']").change(function(){
            showContentByEditType();
        });

        //数据库类型
        $("[name='dbType']").change(function(){
            //根据数据库类型获取该类型下的数据库信息
            var value = $(this).val();
            if(isNotBlank(value)){
                //通过数据库类型获取数据库地址选项
                getDBInfSelectOptionByType(value,null);
            }
        })

        //wsdl方法选择
        $("[name='wsdlFunc']").change(function(){
            var locationURI = $("#wsdlFunc :checked" ).attr("locationURI");
            var targetNamespace = $("#wsdlFunc :checked" ).attr("targetNamespace");
            var serviceName = $("#wsdlFunc :checked" ).attr("serviceName");
            var portName = $("#wsdlFunc :checked" ).attr("portName");

            $("[name='camel.wsdl.targetNamespace']").val(targetNamespace);
            //cxf.adress
            $("[name='camel.wsdl.url']").val(locationURI);
            $("[name='camel.wsdl.serviceName']").val(serviceName);
            $("[name='camel.wsdl.endpointName']").val(portName);
            // $("[name='cxf.xmlns:ns1']").val(targetNamespace);
        })

        //openAPI方法选择
        $("[name='openAPIFunc']").change(function(){
            var pathurl = $("#openAPIFunc :checked" ).attr("pathurl");
            $("[name='camel.request.url']").val(pathurl);
        })

        //弹窗消失时，清除表单所有校验css
        $('#serviceModal').on('hide.bs.modal', function () {
            //清除编辑器
            clearEditor()
            //初始化数据库信息
            initDBType();
            //隐藏服务类型选项选择展示
            $("[id^='divForm']").hide();
            //隐藏camel配置信息
            $("[id^='camel']").hide();
        });

    })

    $(document).ready(function () {
        //禁止表单编辑
        disableForm("",true);

        //初始化表格,动态从服务器加载数据
        $("#table_list").bootstrapTable({
            //使用get请求到服务器获取数据
            method: "POST",
            //必须设置，不然request.getParameter获取不到请求参数
            contentType: "application/x-www-form-urlencoded",
            //获取数据的Servlet地址
            url: "${base}/service/authorization/list",
            uniqueId:'id',
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
                    title: "服务名称",
                    field: "serviceName"
                // },{
                //     title: "所属系统",
                //     field: "serviceSystem"
                // },{
                //     title: "所属分类",
                //     field: "serviceSecondClass"
                },{
                    title: "服务类型",
                    field: "serviceType"
                },{
                    title: "授权状态",
                    field: "authStatus",
                    align: 'center',
                    formatter: function (value, row, index) {
                        var status = "";
                        if(value==0){
                            status = "待授权";
                        }else if(value==1){
                            status = "已授权";
                        }else if(value==-1){
                            status = "已拒绝";
                        }else if(value==-2){
                            status = "已取消";
                        }
                        return status;
                    }
                },{
                    title: "授权码(点击复制)",
                    field: "authorizationCode",
                    formatter: function(value, row, index) {
                        if(isBlank(value)){
                            return;
                        }
                        return "<div class=\"contant\" onclick=\"execClick();\" oncopy=\"execCopy(event,this);\">"+value+"</div>";
                    }
                },{
                    title: "授权时间",
                    field: "authorizationTime",
                    formatter: function (value, row, index) {
                        if(isBlank(value)){
                            return "";
                        }
                        return format(value);
                    }
                },{
                    title: "申请人",
                    field: "createUser.realName"
                },{
                    title: "创建时间",
                    field: "createTime",
                    formatter: function (value, row, index) {
                        if(isBlank(value)){
                            return "";
                        }
                        return format(value);
                    }
                },{
                    title: "操作",
                    field: "--",
                    formatter: function (value, row, index) {
                        var btns = '<div class="button-center">';
                        if(row.authStatus==0){
                            btns +=    '<button type="button" class="btn btn-sm btn-info" onclick="authorize(\''+row.id+'\')">授权</button>';
                            btns +=    '<button type="button" class="btn btn-sm btn-danger" onclick="reject(\''+row.id+'\')">拒绝</button>';
                        }else if(row.authStatus==1){
                            btns +=    '<button type="button" class="btn btn-sm btn-danger" onclick="cancel(\''+row.id+'\')">取消</button>';
                        }
                        btns +=    '<button type="button" class="btn btn-sm btn-default" onclick="testDBLink(\''+row.id+'\')">连接测试</button>';
                        btns +=    '<button type="button" class="btn btn-sm btn-default" onclick="getServiceById(\''+row.serviceId+'\')">查看</button>';
                        btns +=    '</div>'
                        return btns;
                    }
                }]
        });


    });


    //得到查询的参数
    function queryParams (params) {
        var temp = {  //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            pageSize: params.pageSize,  //页面大小
            pageNumber: params.pageNumber, //页码
            serviceName: $("#s_serviceName").val()
        };
        return temp;
    }

    var state;

    function getServiceById(serviceId) {
        //清除服务基本信息
        $("#serviceForm").clearForm();
        //清除接口基本信息
        $("#interfaceForm").clearForm();
        //清除应用基本信息
        $("#appForm").clearForm();
        state = false;
        $(".modal-title").text("查看服务接口审批");
        $.ajax({
            type:"GET",
            url:"${base}/service/deployment/edit?id="+serviceId,
            dataType:"json",
            success:function(result){
                var data = result.data;
                if(result.success){
                    //设置服务基本信息
                    if(data.serviceInfo){
                        $("#serviceForm").setForm(data.serviceInfo);
                    }
                    //设置服务-接口基本信息
                    if(data.serviceInterfaceInfo){
                        $("#interfaceForm").setForm(data.serviceInterfaceInfo);
                    }
                    //设置服务-应用基本信息
                    if(data.serviceApplicationInfo){
                        $("#appForm").setForm(data.serviceApplicationInfo);
                    }
                    $('#serviceModal').modal();
                    //显示第一个Tab
                    changeTab(1);
                    //刷新所有下拉框
                    //$('.selectpicker').selectpicker('refresh');
                    //初始化所属分类下拉框
                    initServiceClass(data.serviceInfo);
                    //初始化请求参数表格
                    requestTable(serviceId);
                    //初始化返回参数表格
                    responseTable(serviceId);
                    //初始化接口信息-服务类型
                    initServiceType(data.serviceInterfaceInfo);
                    //设置camel application配置信息
                    // setCamelInfoValue(serviceId,data.serviceInterfaceInfo.serviceType);
                    //设置camel component配置信息
                    // setCamelComponentInfoValue(serviceId);
                    //设置camel cxf配置信息
                    // setCamelCxfConfigValue(serviceId);
                }else{
                    layer.msg(result.message);
                }
            },
            error:function(jqXHR){
                layer.msg("发生错误："+ jqXHR.status);
            }
        });

    }

    //授权
    function authorize(id){
        $.ajax({
            type:'post',
            url:'${base}/service/authorization/authorize',
            data:{
                id:id
            },
            dateType:'json',
            success:function(result){
                if(result.success){
                    layer.msg("授权成功");
                    window.location.reload(true);
                }else{
                    layer.msg(result.message);
                }
            }
        });
    }

    //授权
    function cancel(id){
        $.ajax({
            type:'post',
            url:'${base}/service/authorization/cancel',
            data:{
                id:id
            },
            dateType:'json',
            success:function(result){
                if(result.success){
                    layer.msg("取消授权成功");
                    window.location.reload(true);
                }else{
                    layer.msg(result.message);
                }
            }
        });
    }

    //初始化请求参数表格
    function requestTable(serviceId){
        $('#tb_request').bootstrapTable('destroy');
        var url = "";
        if(isNotBlank(serviceId)){
            url = "${base}/service/request/list?serviceId="+serviceId;
        }
        $("#tb_request").bootstrapTable({
            idField: "Id",
            showRefresh: true,
            clickToSelect: true,
            //使用get请求到服务器获取数据
            method: "POST",
            //必须设置，不然request.getParameter获取不到请求参数
            contentType: "application/x-www-form-urlencoded",
            //获取数据的Servlet地址
            url: url,
            //唯一识别ID，用于获取行数据或删除行
            uniqueId:'index',
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
            columns: [{
                title: '序号',
                field: 'index',
                align: 'center',
                formatter: function (value, row, index) {
                    //增加index字段，用于作为删除行数据标识
                    row.index = index+1;
                    var pageSize = $('#tb_request').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#tb_request').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: "paramType",
                title: "参数类型",
                editable: {
                    type: 'select',
                    title: '参数类型',
                    source:[{value:"1",text:"通用参数"},{value:"2",text:"私有参数"}],
                    validate: function (v) {
                        if (!v) return '参数类型不能为空';

                    }
                }
            }, {
                field: "paramName",
                title: "参数名称",
                formatter :function (value, row, index) {
                    if (typeof (value) == 'undefined') {
                        return "";
                    } else {
                        return value;
                    }
                },
                editable: {
                    type: 'text',
                    title: '参数名称',
                    validate: function (v) {
                        if (!v) return '参数名称不能为空';

                    }
                }
            }, {
                field: "required",
                title: "是否必须",
                editable: {
                    type: 'select',
                    title: '是否必须',
                    source:[{value:"1",text:"是"},{value:"0",text:"否"}],
                    validate: function (v) {
                        if (!v) return '用户名不能为空';

                    }
                }
            }, {
                field: "type",
                title: "类型",
                editable: {
                    type: 'select',
                    title: '类型',
                    source:[{value:"1",text:"字符型"},{value:"2",text:"数值型"},{value:"3",text:"日期型"}],
                    validate: function (v) {
                        if (!v) return '类型不能为空';
                    }
                }
            }, {
                field: "description",
                title: "描述",
                editable: {
                    type: 'text',
                    title: '描述',
                    validate: function (v) {
                        if (!v) return '描述不能为空';

                    }
                }
            },{
                title: "操作",
                field: "--",
                formatter: function (value, row, index) {
                    var btns = '<div class="button-center">';
                    btns += '<button type="button" class="btn btn-sm btn-danger" onclick="removeRequestTableRow(' + index + ')">删除</button>';
                    btns += '</div>'
                    return btns;
                }
            }]
        });
    }

    //初始化返回参数表格
    function responseTable(serviceId){
        $('#tb_response').bootstrapTable('destroy');
        var url = "";
        if(isNotBlank(serviceId)){
            url = "${base}/service/response/list?serviceId="+serviceId;
        }
        $("#tb_response").bootstrapTable({
            idField: "Id",
            showRefresh: true,
            clickToSelect: true,
            //使用get请求到服务器获取数据
            method: "POST",
            //必须设置，不然request.getParameter获取不到请求参数
            contentType: "application/x-www-form-urlencoded",
            //获取数据的Servlet地址
            url: url,
            //唯一识别ID，用于获取行数据或删除行
            uniqueId:'index',
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
            columns: [{
                title: '序号',
                field: 'index',
                align: 'center',
                formatter: function (value, row, index) {
                    //增加index字段，用于作为删除行数据标识
                    row.index = index+1;
                    var pageSize = $('#tb_request').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#tb_request').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: "paramName",
                title: "参数名称",
                formatter :function (value, row, index) {
                    if (typeof (value) == 'undefined') {
                        return "";
                    } else {
                        return value;
                    }
                },
                editable: {
                    type: 'text',
                    title: '参数名称',
                    validate: function (v) {
                        if (!v) return '参数名称不能为空';

                    }
                }
            },{
                field: "description",
                title: "描述",
                editable: {
                    type: 'text',
                    title: '描述',
                    validate: function (v) {
                        if (!v) return '描述不能为空';

                    }
                }
            },{
                title: "操作",
                field: "--",
                formatter: function (value, row, index) {
                    var btns = '<div class="button-center">';
                    btns += '<button type="button" class="btn btn-sm btn-danger" onclick="removeResponseTableRow(' + index + ')">删除</button>';
                    btns += '</div>'
                    return btns;
                }
            }]
        });
    }

    //初始化所属分类
    function initServiceClass(data) {
        //默认选中
        if(data!=null&&isNotBlank(data.serviceClass)){
            //$("[name='serviceClass']").selectpicker('val',data.serviceClass);
            $("[name='serviceClass']").val(data.serviceClass);
            showSecondClass(data.serviceSecondClass);
        }else{
            $("[name='serviceSecondClass']").html("");
            //$("[name='serviceSecondClass']").selectpicker('refresh');
        }
    }

    //初始化数据库类型
    function initDBType(data) {
        //默认选中
        if(data!=null&&isNotBlank(data.dbType)){
            //$("[name='dbType']").selectpicker('val',data.dbType);
            $("[name='dbType']").val(data.dbType);
            getDBInfSelectOptionByType(data.dbType,data.dbHost);
        }else{
            $("[name='dbHost']").html("");
            //$("[name='dbHost']").selectpicker('refresh');
        }
    }

    //初始化接口信息-服务类型
    function initServiceType(data) {
        var type = $("[name='serviceType']").val();
        if(type=="db"){
            //$('#dbType').selectpicker('val',data.dbType);
            $('#dbType').val(data.dbType);
            getDBInfSelectOptionByType(data.dbType,data.dbHost);
            //显示camelDB
            $("#camelDB").show();
        }else if(type=="soap"){
            loadFunc(data.wsdlFunc);
        }else if(type=="rest"){
            loadFuncSwagger(data.openAPIFunc);
        }
        $("[name='serviceType']").trigger("change");
    }

    function showSecondClass(serviceSecondClass) {
        var pid = $("[name='serviceClass']").val();
        $.ajax({
            method:"post",
            url: '${base}/metadata/getChildMetaById',
            data:{
                pid: pid
            },
            success:function (result) {
                var str = '<option value="">--请选择--</option>';
                if(result.success) {
                    for (var i = 0; i < result.data.length; i++) {
                        str += '<option value=' + result.data[i].id + '>' + result.data[i].name + '</option>';
                    }
                }
                $("[name='serviceSecondClass']").html(str);
                //$("[name='serviceSecondClass']").selectpicker('refresh');
                //默认选中
                if(isNotBlank(serviceSecondClass)){
                    //$("[name='serviceSecondClass']").selectpicker('val',serviceSecondClass);
                    $("[name='serviceSecondClass']").val(serviceSecondClass);
                }
                $('#serviceSecondClass').trigger("change")
            }
        });
    }

    function getDBInfSelectOptionByType(dbType,dbId){
        $.ajax({
            method:"post",
            url: '${base}/dbConn/getDBInfoByType',
            data:{
                dbType: dbType
            },
            success:function (result) {
                var str = '<option value="">--请选择--</option>';
                if(result.success) {
                    for (var i = 0; i < result.data.length; i++) {
                        str += '<option value=' + result.data[i].id + '>' + result.data[i].host + '</option>';
                    }
                }
                $("[name='dbHost']").html(str);
                //$("[name='dbHost']").selectpicker('refresh');
                //默认选中
                if(isNotBlank(dbId)){
                    //$("[name='dbHost']").selectpicker('val',dbId);
                    $("[name='dbHost']").val(dbId);
                }
                $('#dbHost').trigger("change")
            }
        });
    }

    function changeTab(index) {
        $('#serviceInfoTab a[href="#tab-'+index+'"]').tab('show');
        // $('#serviceInfoTab li:eq(0) a').tab('show')
    }

    function loadFuncSwagger(value){
        var editType = $("[name='editType']").val();
        //文本模式不加载
        if(editType=="properties"){
            return;
        }
        var openAPIUrl = $('#openAPIUrl').val();
        if(openAPIUrl==''){
            layer.msg('请输入swagger路径');
            return;
        }
        var re = /^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+/;
        if(!re.test(openAPIUrl)){
            layer.msg('swagger路径格式不正确');
            return;
        }
        $.ajax({
            type:'post',
            url:'${base}/service/deployment/getFuncSwagger',
            data:{
                openAPIUrl:openAPIUrl
            },
            dateType:'json',
            success:function(result){
                if(result.success){
                    var data = result.data;
                    if(data.status==0){
                        layer.msg(data.data);
                        return;
                    }
                    var swaggerMsg = data.data;
                    $('#openAPIFunc').empty();
                    if(swaggerMsg.length>0){
                        var option = "<option value=''>--请选择--</option>";
                        for(var i=0;i<swaggerMsg.length;i++){
                            var optName = swaggerMsg[i].optName;
                            var pathStr = swaggerMsg[i].pathStr;
                            var pathURL = swaggerMsg[i].pathURL;
                            var method = swaggerMsg[i].method;
                            option += '<option value="'+pathStr+'" method="'+method+'" pathURL="'+pathURL+'">'+pathStr+' 【'+method+'】 '+optName+'</option>';
                        }
                        $('#openAPIFunc').append(option);
                        // $('#servUrl').val($('#openAPIFunc').find('option:selected').attr('pathURL'));
                        if(isNotBlank(value)){
                            //$('#openAPIFunc').selectpicker('val',value);
                            $('#openAPIFunc').val(value);
                        }
                        //$("[name='openAPIFunc']").selectpicker('refresh');
                    }
                }
            }
        });
    }

    function loadFunc(value){
        var editType = $("[name='editType']").val();
        //文本模式不加载
        if(editType=="properties"){
            return;
        }
        var wsdlUrl = $('#wsdlUrl').val();
        if(wsdlUrl==''){
            layer.msg('请输入wsdl路径');
            return;
        }
        var re = /^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+/;
        if(!re.test(wsdlUrl)){
            layer.msg('wsdl路径格式不正确');
            return;
        }
        $.ajax({
            type:'post',
            url:'${base}/service/deployment/getFuncWsdl',
            data:{
                wsdlUrl:wsdlUrl
            },
            dateType:'json',
            success:function(result){
                var data = result.data;
                if(data.status==0){
                    layer.msg(data);
                    return;
                }
                var wsdlMsg = data;
                $('#wsdlFunc').empty();
                var options = "<option value=''>--请选择--</option>";
                if(Object.keys(wsdlMsg).length>0){
                    for(var i in wsdlMsg){
                        for(var key in wsdlMsg[i]){
                            var opts = wsdlMsg[i][key];
                            for(var j in opts){
                                for(var k in opts[j]){
                                    var optName = opts[j][k].optName;
                                    var locationURI = opts[j][k].locationURI;
                                    var targetNamespace = opts[j][k].targetNamespace;
                                    var serviceName = opts[j][k].serviceName;
                                    var portName = opts[j][k].portName;
                                    options += '<option value="'+j+':'+optName+'"serviceName="'+serviceName+'" targetNamespace="'+targetNamespace+'" locationURI="'+locationURI+'" portName="'+portName+'">'+j+'&nbsp; '+optName+'</option>';
                                }
                            }
                        }
                    }
                }
                $('#wsdlFunc').append(options);
                if(isNotBlank(value)){
                    // $('#wsdlFunc').selectpicker('val',value);
                    $('#wsdlFunc').val(value);
                }
                //$("[name='wsdlFunc']").selectpicker('refresh');
            }
        });
    }


    //根据编辑模式显示配置信息内容
    function showContentByEditType(){
        //获取服务ID
        var serviceId = $("[name='id']").val();
        //获取选中的服务类型
        var serviceType = $("[name='serviceType']").val();
        //获取编辑模式
        var editType = $("[name='editType']").val();
        if(isNotBlank(serviceType,editType)){
            //选择数据库
            if(editType=="form"){
                //表单模式修改配置
                switchDivFormByServiceType(serviceType);
            }else if(editType=="properties"){
                //文本模式修改配置
                switchTabByServiceType(serviceId,serviceType);
            }
        }else if(isBlank(serviceType)){
            layer.msg("请选择服务类型");
            return;
        }else if(isBlank(editType)){
            layer.msg("请选择编辑模式");
            return;
        }
    }

    function switchDivFormByServiceType(serviceType){
        $("[id^='camel']").hide();
        $("[id^='divForm']").hide();
        $("#divFormCamelInfo").show();
        if(serviceType=="db"){
            //选择DB
            $("#divFormDB").show();
        }else if(serviceType=="soap"){
            //选择SOAP
            $("#divFormSoap").show();

        }else if(serviceType=="rest"){
            //选择rest
            $("#divFormOpenAPI").show();
        }
    };

    //根据服务类型切换Tab
    function switchTabByServiceType(serviceId,serviceType){
        $("[id^='camel']").hide();
        $("[id^='divForm']").hide();
        $("#camelBase").show();
        if(serviceType=="db"){
            $("#camelDB").show();
            //设置camel component配置信息
            setCamelComponentInfoValue(serviceId);
        }else if(serviceType=="soap"){
            $("#camelSOAP").show();
            //设置camel cxf配置信息
            setCamelCxfConfigValue(serviceId);
        }else if(serviceType=="rest"){
            $("#camelDB").hide();
        }
        //设置camel application配置信息
        setCamelInfoValue(serviceId,serviceType);

    }

    function reject(id){
        $.ajax({
            type:'post',
            url:'${base}/service/authorization/reject',
            data:{
                id:id
            },
            dateType:'json',
            success:function(result){
                if(result.success){
                    layer.msg("更新成功");
                    window.location.reload(true);
                }else{
                    layer.msg(result.message);
                }
            }
        });

    }

    function serach() {
        $("#table_list").bootstrapTable('refresh');
    }

</script>
<!-- Page-Level Scripts -->




</body>

</html>
