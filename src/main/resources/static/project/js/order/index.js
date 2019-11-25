// 订单类型
function orderTypeFormatter(value, row, index) {
    if (value == 'TICKET') {
        return '<span class="label label-danger">微信购票</span>';
    }
    if (value == 'GOODS') {
        return '<span class="label label-danger">购买套餐</span>';
    }
    if (value == 'VIPTICKET') {
        return '<span class="label label-danger">会员卡购票</span>';
    }
    if (value == 'OPENVIP') {
        return '<span class="label label-danger">开通会员卡</span>';
    }
    if (value == 'RECHARGE') {
        return '<span class="label label-danger">会员卡充值</span>';
    }
    if (value == 'COUPONTICKET') {
        return '<span class="label label-danger">优惠券购票</span>';
    }
    if (value == 'VIPCOUPON') {
        return '<span class="label label-danger">卡券购票</span>';
    }
    if (value == 'REFUND') {
        return '<span class="label label-danger">退款</span>';
    }
}

// 订单状态
function orderStatusFormatter(value, row, index) {
    if (value == 'CREATE') {
        return '<span class="label label-danger">创建/未支付</span>';
    }
    if (value == 'PAY') {
        return '<span class="label label-danger">已支付</span>';
    }
    if (value == 'REFUNDING') {
        return '<span class="label label-danger">退款中</span>';
    }
    if (value == 'REFUNDFAIL') {
        return '<span class="label label-danger">退款失败</span>';
    }
    if (value == 'REFUND') {
        return '<span class="label label-danger">退款完成</span>';
    }
    if (value == 'ORDEREND') {
        return '<span class="label label-danger">订单结束</span>';
    }
    if (value == 'INVALID') {
        return '<span class="label label-danger">未支付过期无效订单</span>';
    }
}