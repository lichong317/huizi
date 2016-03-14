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

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2><#if tdMessage?? && tdMessage.title?? &&tdMessage.title?length gt 13>${tdMessage.title[0..13]?default("")}...<#else>${tdMessage.title!''}</#if></h2> 
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<#if tdMessage??>
    <h3 class="ta-c center fs3 pt30 pb10">${tdMessage.title!''}</h3>
    <p class="c8 ta-c pb20"><#if tdMessage.createTime??>${tdMessage.createTime?string("yyyy-MM-dd")}</#if></p>
    <article class="mainbox eeebg pt20 pb20 lh4">
      ${tdMessage.content!''}
      <div class="clear h02"></div>
    </article>
</#if>

  
</body>
</html>
