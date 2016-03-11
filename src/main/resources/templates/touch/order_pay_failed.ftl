<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title>惠之店</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="copyright" content="" />
<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    
});
</script>
</head>

<body>
<header class="comhead">
  <h2>支付失败</h2>
  <a href="/touch/user/order/list/0" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="clear" style="height:2rem;"></div>
<p class="red fs35 lh4 ta-c mb20">付款失败！</p>
<p class="c9 ta-c">订单编号为：<a href="/touch/user/order?id=${order.id?c}" style="color: #ff4454;">${order.orderNumber!''}</a></p>
<p class="c9 ta-c"><#if order??>付款失败，或者支付结果验证失败，如果订单已经成功支付，请联系客服处理！<#else>找不到对应的订单！</#if></p>

<div class="clear" style="height:1.5rem;"></div>
<div class="ta-c">
  <a class="redbg white inblock ta-c w30 h06 lh6" href="/touch/user/order/list/0">查看我的订单</a>
  <a class="darkbg white inblock ta-c w30 h06 lh6 ml30" href="/touch">回首页逛逛</a>
</div>



  
</body>
</html>
