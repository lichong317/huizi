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

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />


<script>
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
                                            text: "有新红包！请到个人中心领取",
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
        $("#smsCodeBtn").val('点击获取短信验证码');  
        var t2 = clearInterval(t1);  
    } else {  
        $("#smsCodeBtn").val(seed + "秒后重新获取");  
    }  
} 
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>登录</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch/reg">快速注册</a>
  </div>
</header>

<div class="main">
  <div class="logintext">
    <input placeholder="请输入手机号码" id="mobileNumber" class="login_ts01" type="text" style="font-family:'微软雅黑';" value="" />
  </div>
   <#--> <div class="logintext03">
    <input placeholder="请输入验证码" class="login_ts03" type="text" style="font-family:'微软雅黑';" value="" />
  </div>
    <div style="width:40%; text-align:center; margin-right:3%; margin-left:5%; float:right; margin-top:17px;"><img src="images/22222.jpg" height="40" /></div>
<div class="clear"></div> -->
  <div class="logintext03">
    <input placeholder="短信验证码" id="smscode" class="login_ts03" type="text" style="font-family:'微软雅黑';" />
  </div>
    <input id="smsCodeBtn" type="submit" class="loginbtn fl" value="发送验证码" style="width:40%; margin-right:3%; margin-left:5%; float:right; font-size:0.8em;" />
  <div class="clear20"></div>
  <a href="/touch/login" style="
    font-size: 0.8em;
    color: #ff4454;
    margin-left: 18px;
">账号密码登录</a>  
  
  
<input class="orange_btn " id="btn_login"  type="submit" value="立即登录" style="margin-top: 15px; font-family:'微软雅黑';">
<div class="center mt15 pb15">
    <input type="radio" />
    <span class="fs08 c9">记住我</span>
    <a class="absolute-r fs08 c9 fr" href="/touch/login/password_retrieve">忘记密码？</a>
  </div>  
  <p class="center c9 fs08 pt15">其他方式登录</p>
  <table class="login_check">
    <tr>
      <#--<td><img style="margin-left:40%;" src="images/dddl_03.png" /><a href="#">微信登录</a></td> -->
      <td><img style="margin-left:40%;" src="images/dddl_06.png" /><a href="/login/alipay_login">支付宝登录</a></td>
      <td><img style="margin-left:40%;" src="images/dddl_09.png" /><a href="/qq/login">QQ登录</a></td>
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
