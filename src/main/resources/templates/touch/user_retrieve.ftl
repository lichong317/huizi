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
<script src="/client/js/Validform_v5.3.2_min.js"></script>

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
      
      
      $("#btnSubmit").bind("click", function() {  
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
            
            var password = $('#password').val();
            var password1 = $('#password1').val();
            
            if (password.length < 6 )
            {
                ct.alert({
                        text: "密码长度需大于6位",
                        type: "alert"
                });
                return;
            }
            
            if(password != password1 ){
                ct.alert({
                        text: "请确认密码",
                        type: "alert"
                });
                return;
            }
            
            var code =  $('#smscode').val();
            
             $.ajax({  
                        url : "/touch/login/password_retrieve",  
                        async : true,  
                        type : 'POST',  
                        data : {"mobile": mob, "code": code, "password": password},  
                        success : function(data) {  
                            if(data.code == 0){
                                ct.alert({
                                        text: "密码修改成功",
                                        type: "alert"
                                });
                                window.location.href="/touch/user";
                            }else{
                                ct.alert({
                                        text: data.msg,
                                        type: "alert"
                                });
                            }
                        }
             });
      }); 
});

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

<style>

.Validform_checktip{line-height:20px; height:20px; overflow:hidden; color:red; font-size:12px; margin-left:10%;}


#Validform_msg{color:#7d8289; font: 12px/1.5 tahoma, arial, \5b8b\4f53, sans-serif; width:280px; -webkit-box-shadow:2px 2px 3px #aaa; -moz-box-shadow:2px 2px 3px #aaa; background:#fff; position:absolute; top:0px; right:50px; z-index:99999; display:none;filter: progid:DXImageTransform.Microsoft.Shadow(Strength=3, Direction=135, Color='#999999'); box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);}
#Validform_msg .iframe{ position:absolute; left:0px; top:-1px; z-index:-1; }
#Validform_msg .Validform_title{ position:relative; line-height:35px; height:35px; text-align:left; font-weight:bold; padding:0 10px; color:#fff; background:#33B5E5; }
#Validform_msg a.Validform_close:link,#Validform_msg a.Validform_close:visited{ line-height:30px; position:absolute; right:10px; top:0px; color:#fff; text-decoration:none; }
#Validform_msg a.Validform_close:hover{color:#ccc;}
#Validform_msg .Validform_info{padding:10px;border:1px solid #bbb; border-top:none; text-align:left;}


</style>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>找回密码</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="clear h05"></div>

    <input id="mobileNumber" name="mobile" type="text" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请输入手机号" />
    <section class="w80 mga mt20 login_yzm">
      <input id="smscode" name="smscode" datatype="s4-4" type="text" class="h08 lh8 border ti1 block fl" placeholder="请输入验证码" />
      <input id="smsCodeBtn" type="button" class="sub fr block ta-c h08 lh8 darkbg white" value="发送验证码" style="width:40%; margin-right:3%; margin-left:5%; float:right; font-size:0.8em;" />
      <div class="clear"></div>
    </section>
    
    <input id="password" name="password" type="password" datatype="s6-20" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="新密码" />
    <input id="password1" type="password" datatype="*" recheck="password" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="确认密码" />
    
    <input id="btnSubmit" type="submit" class="h08 lh8 w80 white redbg block mga sub bor-rad mt40 fs3" value="提交" />
    
</body>
</html>
