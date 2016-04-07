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

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>支付成功</h2>
  <a href="/touch/user/order/list/0" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="clear" style="height:2rem;"></div>
<p class="red fs35 lh4 ta-c mb20">您已成功付款￥${order.totalPrice?string('0.00')}元</p>
<p class="c9 ta-c">订单编号为：<a href="/touch/user/order?id=${order.id?c!''}" style="color: #FF0000;">${order.orderNumber!''}</a></p>
<p class="c9 ta-c">我们将尽快安排发货，请您耐心等候</p>

<div class="clear" style="height:1.5rem;"></div>
<div class="ta-c">
  <a class="redbg white inblock ta-c w30 h06 lh6" href="/touch/user/order/list/0">查看我的订单</a>
  <a class="darkbg white inblock ta-c w30 h06 lh6 ml30" href="/touch">回首页逛逛</a>
</div>



  
</body>
</html>
