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

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

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

<#include "/touch/tip_box.ftl" />

<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>修改密码</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<!--main-->
<div class="main">
 <form id="form1" action="/touch/user/password" method="post" style="margin:0 10px;">
     <input name="__STATE" type="hidden" value="${user.password}"/>
    <p style="margin-left:10px">原始密码</p>
    <div class="logintext " style="width:95%; background:#FFF;padding-left: 0;">
        <input name="oldPassword" type="password" class="" value="" datatype="*" errormsg="原始密码不正确" recheck="__STATE"/>
    </div>
    <div class="clear h20"></div>
    <p style="margin-left:10px">新密码</p>
    <div class="logintext " style="width:95%; background:#FFF;padding-left: 0;">
        <input name="newPassword" type="password" datatype="*"  class="" value="" />
    </div>
    <p style="margin-left:10px">确认密码</p>
    <div class="logintext " style="width:95%; background:#FFF;padding-left: 0;">
        <input type="password" datatype="*" recheck="newPassword" class="" value="" />
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
