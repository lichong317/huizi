<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if goods??>${goods.seoTitle!''}</#if>-惠之店</title>
<meta name="keywords" content="${goods.seoKeywords!''}">
<meta name="description" content="${goods.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
  
});
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>图文详情</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<!--header END-->

${goods.detail!''}

<div class="clear"></div>

<#if !app??>
<section class="botmain">
  <div class="main">
  <div class="center">
   <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout" onclick="logout()">退出</a>
    <#else>
        <a href="/touch/login">登录</a>
        <span>|</span>
        <a href="/touch/reg">注册</a>
    </#if>    
  </div>
  </div>
</section>
<p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/goods/<#if goodsId??>${goodsId?c}</#if>">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p>
</#if>
</body>
</html>
