<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script src="/touch/js/cart.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
  
});
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>订单</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<!--header END-->

<div id="main" class="page-main">
    <div class="car_success">
        <p class="fc fs30 lh40 pb10">订单提交成功! </p>
        <p> 订单号：<a href="/touch/user/order?id=${order.id?c!''}" style="color: #FF0000;">${order.orderNumber!''}</a></p>
        <p> 货到付款：<strong class="f24" style="color:red"><#if order??>${order.totalPrice?string("0.00")}</#if></strong>元</p>       
        <p>您还可以
            <a class="blue" style="color: #FF0000;" href="/touch/user/order?id=${order.id?c!''}">查看订单详情</a></p>
    </div>
</div>

</body>
</html>
