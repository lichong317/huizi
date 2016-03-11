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

<body class="eeebg">
<header class="comhead">
  <h2>门店查询</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
</header>
<div class="comheadbg"></div>

<#if shop_list??>
     <#list shop_list.content as item>
     	  <div class="shoplist center mt20">
			  <a href="/touch/shop/${item.id?c}" class="block w100"><img src="${item.imageUri!''}" class="w100" height="230"/></a>
			  <h3 class="w90 mga pt10 pb10 bot-border fs3">${item.title!''}<#if item.isFlagShip?? && item.isFlagShip><span class="red">(旗舰店)</span></#if></h3>
			  <p class="p1"><span>地址：</span>${item.address!''}</p>
			  <p class="p2"><span>客服QQ：</span>${item.qq!''}</p>
			  <p class="p3"><span>联系电话：</span>${item.serviceTele!''}</p>
			  <section class="w90 ta-r mga pt20">
			    <a href="tel://${item.serviceTele}" class="a1">一键呼叫</a>
			    <a href="/touch/shop/${item.id?c}" class="a2">地图导航</a>
			  </section>
		  </div>
     </#list>
</#if>
<div class="clear h03"></div>
  
</body>
</html>
