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
<script type="text/javascript" src="/client/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script src="/touch/js/message.js"></script>

<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="101277681" data-redirecturi="http://www.huizhidian.com/login/qq_login_return" charset="utf-8"></script>

<script type="text/javascript">
  $(document).ready(function(){
        //记住密码    
    
    $("#txt_loginId")[0].focus();
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3
    });
    $(function(){
        $("#btn_login").click(function(){
            //saveUserInfo();
            login();
        }); 
    });

    document.onkeydown = function(event){
        if((event.keyCode || event.which) == 13){
            //saveUserInfo();
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
 

</script>
</head>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>登录</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="clear h07"></div>
<a class="loginlogo" href="/touch/"><img src="/touch/images/member/logo.png" /></a>
<div class="clear h05"></div>

<input id="txt_loginId" type="text" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请输入用户名/手机号" />
<input id="txt_loginPwd" type="password" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请输入密码" />
<p class="w80 mga mt20 pb10">
  <a href="/touch/login/password_retrieve" class="absolute-r red">忘记密码？</a>
  <a href="/touch/loginMobile" class="red">手机验证登录</a>
</p>

<input id="btn_login" type="submit" class="h08 lh8 w80 white redbg block mga sub bor-rad mt20 fs3" value="登录" />
<input onclick="window.location.href='/touch/regid'" type="submit" class="h08 lh8 w80 redborbtn mga sub bor-rad mt20 fs3" value="注册" />
<div class="clear h06"></div>
<p class="w80 mga">其他方式登录</p>
<#--<a class="login_qq" href="javascript:;" ><img src="/touch/images/member/qq.png" /><p>QQ登录</p></a> -->
<div style="text-align:center;display:block;width:100%;;"><span id="qqLoginBtn">12312</span></div>
<script type="text/javascript">
    QC.Login({
       btnId:"qqLoginBtn"    //插入按钮的节点id
});
</script>

<div class="clear h03"></div>
  
</body>
</html>
