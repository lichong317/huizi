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

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<style type="text/css">
    .box li{display: none;}
</style>
<script type="text/javascript">
$(document).ready(function(){
    var aBtn = $('.tabfix li');
    var aBox = $('.box .param');
    aBtn.each(function(i){
        aBtn.eq(i).click(function(){
            aBox.hide();
            aBox.eq(i).show();
            aBtn.removeClass('sel');
            aBtn.eq(i).addClass('sel');
        });
    });
});
</script>
</head>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>图文详情</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<section class="tabfix pro_mmenu pro_mmenu01 w100 mb20">
  <menu>
    <li class="sel"><a href="#">图文详情</a></li>
    <li ><a href="#">规格参数</a></li>
    <li><a href="#">售后服务</a></li>
  </menu>
</section>
<ul class="box">
    <li class="param" style="display: block;">
        <#if goods??>
            ${goods.detail!''}
        </#if>
    </li>
    <li class="param">
        <#if goods??>
            ${goods.paramDetail!''}
        </#if>
    </li>
    <li class="param">
        <#if goods??>
            ${goods.afterMarketService!''}
        </#if>
    </li>
</ul>
<div class="clear"></div>
  
</body>
</html>
