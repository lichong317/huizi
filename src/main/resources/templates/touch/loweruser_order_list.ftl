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

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>订单列表</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<#if order_page??>
     <#list order_page.content as order>
     	  <div class="w100 whitebg mb20">
			  <h3 class="mainbox bot-border top-border c9 lh5 fs25">订单编号：${order.orderNumber!''}</h3>
			  <section class="mainbox followimg bot-border">
			  	  <#list order.orderGoodsList as og>
                            <a href="/touch/goods/${og.goodsId?c}"><img src="${og.goodsCoverImageUri}"></a>
                  </#list>
			  </section>
			  <section class="mainbox bot-border pt20 pb20">
			    <p><span class="c9 mr10">订单金额</span>￥${order.totalPrice?string("0.00")}</p>
			    <p><span class="absolute-r fs3">已返现</span><span class="c9 mr10">返利比例</span> 
			    		<#if setting?? && setting.returnRation??>
                        	${setting.returnRation}
                        </#if></p>
			    <p><span class="c9 mr10">返利金额</span>￥
			    	  <#if setting?? && setting.returnRation??>
				              ${setting.returnRation * order.totalPrice}
				      </#if></p>
			  </section>
		  </div>
     </#list>
</#if>

<div class="clear h01"></div>
  
</body>
</html>
