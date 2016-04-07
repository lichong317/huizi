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
<link href="/touch/css/validform.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    $("#form1").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
               //alert("修改成功");
                //window.location.reload();
                ct.alert({
                    text: "修改成功",
                    type: "alert"
                });
                window.location.href="/touch/user"
            }
            else
            {
                ct.alert({
                    text: data.msg,
                    type: "alert"
                });
                //win_yes(data.msg);   
                window.location.href="/touch/login";
            }
        }
    });
});
</script>
</head>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>修改密码</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<form id="form1" action="/touch/user/password" method="post" style="margin:0 10px;">
    <input name="__STATE" type="hidden" value="${user.password}"/>
    <input type="password" class="text h07 lh7 fabg border w80 mga block ti1 mt40" placeholder="请输入原始密码" name="oldPassword" datatype="*" errormsg="原始密码不正确" recheck="__STATE"/>
    <input type="password" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="请输入新密码" name="newPassword" datatype="s6-20"/>
    <input type="password" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="请再次输入密码" datatype="*" recheck="newPassword"/>
    
    <div class="clear h09"></div>
    <input type="submit" value="完成" class="sub combtn mga w80 h07 lh7 white redbg" />
    <div class="clear h03"></div>
  
</body>
</html>
