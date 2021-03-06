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
  <a href="/touch/user" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<section class="listhead tabfix w100 myorderhead">
  <menu>
    <li class="sel">
      <a href="javascript:void(0);">可以使用</a>
    </li>
    <li>
      <a href="/touch/user/coupon/list/2">已经失效</a>
    </li>
  </menu>
</section>

<div class="whitebg mainbox pt20 pb20 mt20">
  <a href="/touch/user/get/coupon" class="redbg white block ta-c fs3 h08 lh8">领取更多优惠券>></a>
</div>

<#if coupan_list??>
    <#list coupan_list as item>
		<a href="/touch/user/coupon/edit?couponId=${item.id?c}" class="ticket center mt20">
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
