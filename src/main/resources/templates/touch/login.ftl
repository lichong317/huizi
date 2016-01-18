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
<script type="text/javascript" src="/client/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  $(document).ready(function(){
        //记住密码
    if ($.cookie("rmbUser") == "true") { 
        $("#rmbUser").attr("checked", true); 
        $("#txt_loginId").val($.cookie("userName")); 
        $("#txt_loginPwd").val($.cookie("passWord")); 
    } 
    
    
    $("#txt_loginId")[0].focus();
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3
    });
    $(function(){
        $("#btn_login").click(function(){
            saveUserInfo();
            login();
        }); 
    });

    document.onkeydown = function(event){
        if((event.keyCode || event.which) == 13){
            saveUserInfo();
            login();
        }
       }
   
    function login(){
        var username = $("#txt_loginId").val();
        var password = $("#txt_loginPwd").val();
        
        if (username.length < 6 || password.length < 6)
        {
            //alert("用户名或密码长度输入不足");
            ct.alert({
                    text: "用户名或密码长度输入不足",
                    type: "alert"
            });
            return;
        }
        
        $.ajax({
                type: "post",
                url: "/touch/login",
                data: { "username": username, "password": password },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                        var url = document.referrer;
                        if(undefined==url || ""==url){
                            window.location.href="/touch/user";
                        }else{
                            window.location.href = url; 
                        }
                    } else {
                        //alert(data.msg);
                        ct.alert({
                                text: data.msg,
                                type: "alert"
                        });
                    }
                }
            });
    }
 });
 
//保存用户信息 
function saveUserInfo() { 
    if (document.getElementById("rmbUser").checked==true) { 
        var userName = $("#txt_loginId").val(); 
        var passWord = $("#txt_loginPwd").val(); 
        $.cookie("rmbUser", "true", { expires: 7 }); // 存储一个带7天期限的 cookie 
        $.cookie("userName", userName, { expires: 7 }); // 存储一个带7天期限的 cookie 
        $.cookie("passWord", passWord, { expires: 7 }); // 存储一个带7天期限的 cookie 
    } 
    else { 
        $.cookie("rmbUser", "false", { expires: -1 }); 
        $.cookie("userName", '', { expires: -1 }); 
        $.cookie("passWord", '', { expires: -1 }); 
    } 
}      
 
</script> 
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>登录</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch/reg">快速注册</a>
  </div>
</header>

<div class="main">
  <div class="logintext">
    <input id="txt_loginId" class="login_ts01" type="text" style="font-family:'微软雅黑';" value="" placeholder="/用户名/手机号"/>
  </div>
  <div class="logintext logintext01">
    <input id="txt_loginPwd" class="login_ts02" type="password" value="" style="font-family:'微软雅黑';" placeholder="密码"/>
  </div>
 <div class="clear20"></div>
  <a href="/touch/loginMobile" style="
    font-size: 0.8em;
    color: #ff4454;
    margin-left: 18px;
">手机验证登录</a>  
  
  
<input class="orange_btn " id="btn_login" type="submit" value="立即登录" style="margin-top: 15px; font-family:'微软雅黑';">
<div class="center mt15 pb15">
    <input id="rmbUser" type="checkbox" />
    <span class="fs08 c9">记住我</span>
    <a class="absolute-r fs08 c9 fr" href="/touch/login/password_retrieve">忘记密码？</a>
  </div>  
  <p class="center c9 fs08 pt15">其他方式登录</p>
  <table class="login_check">
    <tr>
      <#-- <td><img style="margin-left:40%;" src="/touch/images/dddl_03.png" /><a href="#">微信登录</a></td> -->
      <td><img style="margin-left:40%;" src="/touch/images/dddl_06.png" /><a href="/login/alipay_login">支付宝登录</a></td>
      <td><img style="margin-left:40%;" src="/touch/images/dddl_09.png" /><a href="/qq/login">QQ登录</a></td>
    </tr>
  </table>
</div>
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
