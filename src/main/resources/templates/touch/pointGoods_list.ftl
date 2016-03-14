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
  <h2>积分兑换</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<a class="block w100 mb20"><img src="/touch/images/pictures/banner03.png" class="w100" /></a>

<#if goods_page??>
      <#list goods_page.content as tdPointGoods>
      		<a href="/touch/pointGoods/${tdPointGoods.id?c}" class="prolist mainbox bot-border whitebg">
			  <b class="img"><img src="${tdPointGoods.coverImageUri!''}" /></b>
			  <section>
			  <p class="h07 oh">${tdPointGoods.title!''}</p>
			  <p class="red mt20">${tdPointGoods.pointUse!'0'}分</p>
			  </section>
			  <div class="clear"></div>
			</a>
      </#list>
</#if>

<div class="clear h02"></div>
<p class="center ta-r">
  <#if goods_page??>
        <#if goods_page.number+1 == 1>
            <a class="c9 mr30" href="javascript:;"><span>上一页</span></a>
        <#else>
            <a href="/touch/pointGoods/list?page=${goods_page.number-1}" class="mr30">上一页</a>
        </#if>  
        
        <#if goods_page.number+1 == goods_page.totalPages || goods_page.totalPages==0>
              <a  href="javascript:;"><span>下一页</span></a>
        <#else>
              <a href="/touch/pointGoods/list?page=${goods_page.number+1}"><span>下一页</span></a>
        </#if>  
    </#if>
</p>

<div class="clear h03"></div>
  
</body>
</html>
