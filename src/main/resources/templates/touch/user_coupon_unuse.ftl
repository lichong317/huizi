<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title>暂无标题</title>
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

<body class="eeebg">
<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>我的优惠券</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<!--
<article class="center whitebg mt20 pt30 pb30">
  <p class="pl20 pr20 fw-b">优惠券使用规则</p>
  <p class="pt10 pl20 pr20 c9">1、我是规则说明文字吧我是规则说明文字吧我是规则说明文字吧我是规则说明文字吧</p>
  <p class="pt10 pl20 pr20 c9">1、我是规则说明文字吧我是规则说明文字吧我是规则说明文字吧我是规则说明文字吧</p>
  <p class="pt10 pl20 pr20 c9">1、我是规则说明文字吧我是规则说明文字吧我是规则说明文字吧我是规则说明文字吧</p>
</article>
-->

<#if coupan_list??>
    <#list coupan_list as item>
		<a href="/touch/user/coupon/edit?couponId=${item.id?c}" class="ticket ticket01 center mt20">
			<section>
				<#--<h3>全场通用</h3>-->
				<h4>${item.typeTitle!''}</h4>
				<p>期限：<#if item.getTime??>${item.getTime?string("yyyy.MM.dd")}</#if>-<#if item.expireTime??>${item.expireTime?string("yyyy.MM.dd")}</#if></p>
			</section>
			<div class="num">
				<i></i>
				<h3>￥${item.price?string("0.00")}<span>可抵用${item.price?string("0.00")}</span></h3>
			</div>
			<div class="clear"></div>
		</a>
	</#list>
</#if>

<div class="clear h03"></div>
  
</body>
</html>
