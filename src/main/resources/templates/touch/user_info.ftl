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
<header class="comhead">
  <h2>个人信息</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
</header>
<div class="comheadbg"></div>

<form id="form1" action="/touch/user/info" method="post">
    <input name="realName" type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt40" placeholder="真实姓名" value="${user.realName!''}"/>
    <div class="sexchoose w80 mga mt20 h07 lh7">
      <span class="fl">性别</span>
          <#--<a class="sel" href="javascript:void(0);" onClick="$(this).toggleClass('sel');">男</a>
          <a href="javascript:void(0);" onClick="$(this).toggleClass('sel');">女</a> -->
          <input type="radio" name="sex" class="ml20" value="男" <#if user.sex?? && user.sex=="男">checked="checked" </#if> /><span>男</span>
          <input type="radio" name="sex" class="ml20" value="女" <#if user.sex?? && user.sex=="女">checked="checked" </#if> /><span>女</span>
      <div class="clear"></div>
    </div>
    <input type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="电子邮箱" name="email" value="${user.email!''}"/>
    <input type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="手机号码" name="mobile" value="${user.mobile!''}"/>
    
    <div class="clear h08"></div>
    <p class="w80 mga c9 mb10"><span class="absolute-r">${user.registerTime!''}</span>注册时间</p>
    <p class="w80 mga c9 mb10"><span class="absolute-r">${user.lastLoginTime!''}</span>最后登录时间</p>
    
    <div class="clear h130"></div>
    <footer class="addressfoot">
      <input type="submit" value="确认" class="sub" />
    </footer>
</form>  
</body>
</html>
