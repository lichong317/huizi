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
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  $(document).ready(function(){    
    $("#form1").Validform({
        tiptype: 3
    });
});
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>找回密码</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<!--main-->
<div class="main"  style="width:90%">
 <form id="form1" method="post" action="/touch/login/retrieve_step3">
    <p style="margin-left:10px">请输入新密码</p>
    <div class="logintext logintext_y" style="width:86%; background:#FFF;">
    <input name="password" type="password" class="" value="" />
    </div>
    <div class="clear h20"></div>
    <p style="margin-left:10px">请确认输入密码</p>
    <div class="logintext logintext_y" style="width:86%; background:#FFF;">
    <input type="password" datatype="*" recheck="password" class="" value="" />
    </div>
    <div class="clear"></div>
    <input type="submit" class="loginbtn" value="完成" />
 </form>
</div>
<div class="clear40"></div>




<!--main END-->

<#if !app??>
   <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/login">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
