<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
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
  <h2>订单提交</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="clear" style="height:2rem;"></div>
<p class="red fs35 lh4 ta-c mb20">订单提交成功! </p>
<p class="c9 ta-c">订单编号为：<a href="/touch/user/order?id=${order.id?c!''}" style="color: #FF0000;">${order.orderNumber!''}</a></p>
<p class="c9 ta-c"> 支付方式：<strong class="f24" style="color:red">${order.payTypeTitle!''}</strong></p>
<#if order.totalPrice == 0>
            <p class="c9 ta-c">订单金额￥${order.totalPrice?string('0.00')} 
            <span style="color:red">无须支付</span></p>
<#else>
            <p class="c9 ta-c">应付金额￥${order.totalPrice?string('0.00')} 
                <#--<a class="blue" href="/touch/order/dopay/${order.id?c}" style="color: #FF0000;">点击支付</a> -->
                <#if order.payTypeTitle == "微信支付">
                       <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb309b01e273cd1cf&redirect_uri=http://www.huizhidian.com/touch/order/dopay&response_type=code&scope=snsapi_base&state=${order.id?c}#wechat_redirect" class="blue" style="color: #FF0000;">点击支付</a>
                <#else>
                       <a href="/order/dopay/${order.id?c}" class="blue" style="color: #FF0000;">点击支付</a>
                </#if>
            </p>
</#if>
<p class="c9 ta-c">您还可以
            <a class="blue" style="color: #FF0000;" href="/touch/user/order?id=${order.id?c!''}">查看订单详情</a></p>
<div class="clear" style="height:1.5rem;"></div>
<div class="ta-c">
  <a class="redbg white inblock ta-c w30 h06 lh6" href="/touch/user/order/list/0">查看我的订单</a>
  <a class="darkbg white inblock ta-c w30 h06 lh6 ml30" href="/touch">回首页逛逛</a>
</div>



  
</body>
</html>
