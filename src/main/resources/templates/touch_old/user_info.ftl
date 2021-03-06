<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script src="/touch/js/jquery.cityselect.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
     $("#address").citySelect({
        nodata:"none",
        <#if user?? && user.province??>prov: "${user.province!''}",</#if>
        <#if user?? && user.city??>city: "${user.city!''}",</#if>
        <#if user?? && user.disctrict??>dist: "${user.disctrict!''}",</#if>
        required:false
    }); 
});
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>个人信息填写</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<div class="main">
<form id="form1" action="/touch/user/info" method="post">
    <p class="address">姓名</p>
    <input name="realName"   type="text" class="address"  value="${user.realName!''}" />
    <p class="address">性别</p>
    <p class="address">
      <input type="radio" name="sex" value="男" <#if user.sex?? && user.sex=="男">checked="checked" </#if> /><span>男</span>
      <input type="radio" name="sex" class="ml20" value="女" <#if user.sex?? && user.sex=="女">checked="checked" </#if> /><span>女</span>
    </p>
    <p class="address">电话</p>
    <input type="text" name="mobile" class="address" value="${user.mobile!''}" />
    <p class="address">邮箱</p>
    <input type="text" name="email" class="address" value="${user.email!''}" />
    <p class="address">地址</p>
    <div id="address" class="address">
         <select id="prov" name="province" class="prov fl"></select>
         <select id="city" name="city" class="city fr"></select>
         <div class="clear"></div>
         <select id="dist" name="disctrict" class="dist" style="width:100%;"></select>
    </div>
    
    <input type="submit" class="greenbtn fs11" style="width:90%; font-family:'微软雅黑';" value="保存" />
</form>
</div>
<div class="clear30"></div>

<!--main END-->

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
    <a class="absolute-r" href="javascript:$('html,body').animate({scrollTop:0},500);">返回顶部</a>
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user/order/list/0">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div>
</#if>
</body>
</html>
