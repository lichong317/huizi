<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/cart.js"></script>
<script src="/client/js/order_info.js"></script>
<script src="/client/js/jquery.cityselect.js"></script>

<#--<link rel="shortcut icon" href="/client/images/cheyou.ico" />-->
<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cytm.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script type="text/javascript">
  $(document).ready(function(){
    menuDownList("top_phone","#top_phonelist",".a1","sel");
    phoneListMore();//单独下拉
    menuDownList("top_order","#top_orderlist",".a4","sel");//顶部下拉
    searchTextClear(".toptext","请输入品牌或商品名称","#999","#666");
    searchTextClear(".bottext","查看所有门店","#fff","#fff");
    checkNowHover("shopping_down","shopping_sel");
    navDownList("navdown","li",".nav_showbox");
    menuDownList("mainnavdown","#navdown",".a2","sel");
   
   
});
</script>
</head>
<body>
<#include "/client/common_header.ftl" />

<div class="main">
   
    <div class="car_success" style="line-height: 40px;">
        <p class="fc fs30 lh40 pb10">订单提交成功! </p>
        <p> 订单号：<a href="/user/order?id=${order.id?c}">${order.orderNumber!''}</a></p>
        <p> 支付方式：${order.payTypeTitle!''}</p>
        <#if order.totalPrice == 0>
            <p>订单金额￥${order.totalPrice?string('0.00')} <span style="color:red">无须支付</span></p>
            <p>您可以 <a class="blue" href="/user/order/list/0" style="
                background: #46a6d6;
                color: #FFF;
                padding: 3px 17px;
                border-radius: 5px;
                margin-left: 15px;
            ">查看订单</a></p>
        <#else>
            <p>应付金额￥${order.totalPrice?string('0.00')} <a class="blue" href="/order/dopay/${order.id?c}" style="background: #ff4454;color: #FFF;text-align: center;padding: 3px 17px;
                border-radius: 5px;
                margin-left: 18px;
            ">点击支付</a></p>
            <p>您可以 <a class="blue" href="/user/order/list/0" style="
                background: #46a6d6;
                color: #FFF;
                padding: 3px 17px;
                border-radius: 5px;
                margin-left: 15px;
            ">查看订单</a></p>
        </#if>
    </div>
  
    <div class="clear"></div> 
</div>

<#include "/client/common_footer.ftl" />
</body>
</html>