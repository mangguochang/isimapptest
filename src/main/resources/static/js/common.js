
//关闭包含当前iframe的layer窗口
function closeILayerBt() {
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index); //再执行关闭
}


