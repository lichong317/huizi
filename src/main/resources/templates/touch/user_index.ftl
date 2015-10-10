<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>会员中心</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<section class="memberhead main">
   <#if user??>
      <a href="#"><img src="${user.headImageUri!''}" /></a>
      <p class="white fs08 lh20 ta-c">${user.username!''}</p>
   </#if>
</section>

<section class="main membertop mt10 mb10" >
  <menu>
    <a href="/touch/user/order/list/2"><img src="/touch/images/huiyuan_05.png" height="48" /><p>待付款（<#if total_unpayed??>${total_unpayed!''}</#if>）</p></a>
    <a href="/touch/user/order/list/4"><img src="/touch/images/huiyuan_07.png" height="48" /><p>待收货（<#if total_unreceived??>${total_unreceived!''}</#if>）</p></a>
    <a href="/touch/user/order/list/5"><img src="/touch/images/huiyuan_09.png" height="48" /><p>待评价（<#if total_uncommented??>${total_uncommented!''}</#if>）</p></a>
    <a href="/touch/user/order/list/6"><img src="/touch/images/huiyuan_11.png" height="48" /><p>维修/售后（<#if total_finished??>${total_finished!''}</#if>）</p></a>
  </menu>
</section>

<menu class="main memberlist">
  <a href="/touch/user/order/list/0">全部订单<img style="float:right; margin-top:13px;" src="/touch/images/arrow04.png" /></a>
  <a href="/touch/user/point/list">我的积分（${user.totalPoints!0}）<img style="float:right; margin-top:13px;" src="/touch/images/arrow04.png" /></a>
  <a href="/touch/user/coupon/list/0">我的优惠券<img style="float:right; margin-top:13px;" src="/touch/images/arrow04.png" /></a>
  <a href="/touch/user/collect/list">我的收藏<img style="float:right; margin-top:13px;" src="/touch/images/arrow04.png" /></a>
  <a href="/touch/user/info">个人信息设置<img style="float:right; margin-top:13px;" src="/touch/images/arrow04.png" /></a>
</menu>
<div class=" tuichu main">
<a href="/touch/logout">退出</a> </div>

<!--main END-->


  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
