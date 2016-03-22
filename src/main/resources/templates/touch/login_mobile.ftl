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

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var seed=60;    //60秒  
var t1=null; 
$(document).ready(function(){
     $(function(){
                    $("#btn_login").click(function(){
                        //saveUserInfo();
                        loginMobile();
                    }); 
     });
    
     $("#smsCodeBtn").bind("click", function() {  
        
        var mob = $('#mobileNumber').val();
        
        var re = /^1\d{10}$/;
        
        if (!re.test(mob)) {
            //alert("请输入正确的手机号");
            ct.alert({
                    text: "请输入正确的手机号",
                    type: "alert"
            });
            return;
        }
        
        $.ajax({  
                        url : "/reg/smscode",  
                        async : true,  
                        type : 'GET',  
                        data : {"mobile": mob},  
                        success : function(data) {  
                                        
                             if(data.statusCode == '000000')
                                        {  
                                            t1 = setInterval(tip, 1000);  
                                        }
                                        else
                                        {
                                            $("#smsCodeBtn").removeAttr("disabled");
                                        }
                                    },  
                               error : function(XMLHttpRequest, textStatus,  
                                            errorThrown) {  
                                        //alert("发送失败");
                                        ct.alert({
                                                text: "发送失败",
                                                type: "alert"
                                        });
                                    }  
                          
                });
               
      }); 
});


 function loginMobile(){
                    var mobile = $("#mobileNumber").val();
                    var code = $("#smscode").val();
                    
                    var re = /^1\d{10}$/;
        
                    if (!re.test(mobile)) {
                        //alert("请输入正确的手机号");
                        ct.alert({
                                text: "请输入正确的手机号",
                                type: "alert"
                        });
                        return;
                    }
                    
                    $.ajax({
                            type: "post",
                            url: "/touch/loginmobile",
                            data: { "mobile": mobile, "code": code },
                            dataType: "json",
                            success: function (data) {
                                if (data.code == 0) {
                                    if (data.hasRedenvelope == 1){
                                        //alert("有新红包！请到个人中心领取");
                                        ct.alert({
                                                text: "有新红包！请到个人中心领取",
                                                type: "alert"
                                        });
                                    }        
                                    var url = document.referrer;

                                    if(undefined==url || ""==url){
                                        window.location.href="/touch";
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

function enableBtn()
{  
    $("#smsCodeBtn").removeAttr("disabled");   
} 

function tip() 
{  
    seed--;  
    if (seed < 1) 
    {  
        enableBtn();  
        seed = 60;  
        $("#smsCodeBtn").val('获取短信验证码');  
        var t2 = clearInterval(t1);  
    } else {  
        $("#smsCodeBtn").val(seed + "秒后重新获取");  
    }  
} 
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

<input id="mobileNumber" type="text" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请输入手机号" />
<section class="w80 mga mt20 login_yzm">
  <input id="smscode" type="text" class="h08 lh8 border ti1 block fl" placeholder="请输入验证码" />
  <input id="smsCodeBtn" type="submit" class="sub fr block ta-c h08 lh8 darkbg white" value="发送验证码" style="width:40%; margin-right:3%; margin-left:5%; float:right; font-size:0.8em;" />
  <#--<a id="smsCodeBtn" class="sub fr block ta-c h08 lh8 darkbg white" href="#">发送验证码</a> -->
  <div class="clear"></div>
</section>

<p class="w80 mga mt20 pb10">
  <a href="/touch/login/password_retrieve" class="absolute-r red">忘记密码？</a>
  <a href="/touch/login" class="red">用户名密码登录</a>
</p>

<input id="btn_login"  type="submit" class="h08 lh8 w80 white redbg block mga sub bor-rad mt20 fs3" value="登录" />
<input onclick="window.location.href='/touch/regid'" type="submit" class="h08 lh8 w80 redborbtn mga sub bor-rad mt20 fs3" value="注册" />
<div class="clear h06"></div>
<p class="w80 mga">其他方式登录</p>
<a class="login_qq" href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101277681&redirect_uri=http://www.huizhidian.com/login/qq_login_return"><img src="/touch/images/member/qq.png" /><p>QQ登录</p></a>
<div class="clear h03"></div>
  
</body>
</html>
