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
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var seed=60;    //60秒  
var t1=null; 

$(document).ready(function(){
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3
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
        
       var yzmcode =$.trim($('#yzmcode').val());
        $.ajax({
            url : '/reg/checkYzmcode',
            type : 'POST',
            data : {"yzmcode": yzmcode}, 
            success : function(data) {
                if(data.code == 0){
                     $("#smsCodeBtn").attr("disabled","disabled"); 
        
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
                }else{
                    //$("#yzmerror").css("display", "block");
                    //alert("您输入的图片验证码不正确");
                    ct.alert({
                         text: "您输入的图片验证码不正确",
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
<header class="comhead">
  <h2>手机快速注册</h2>
  <a href="#" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a3">登录</a>
</header>
<div class="comheadbg"></div>

<div class="clear h07"></div>
<a class="loginlogo" href="/touch/"><img src="/touch/images/member/logo.png" /></a>
<div class="clear h05"></div>

<form id="form1" method="post" action="/touch/regquick">
     <span style="color: #F00"><#if errCode??>
                        <#if errCode==1>
                            短信验证码错误
                        <#elseif errCode==4>
                            验证码错误               
                        </#if>
                    </#if></span>
    <input name="shareId" type="hidden" value="${share_id!''}">
    <div>
        <input id="mobileNumber" name="mobile" datatype="s6-20" ajaxurl="/reg/check/mobile" type="text" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请输入手机号" />
    </div>    
  <#--  <input type="text" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请输入密码" />
    <input type="text" class="w80 mga mt20 h08 lh8 border ti1 block" placeholder="请确认密码" /> -->
    <section class="w80 mga mt20 login_yzm">
      <input id="yzmcode" name="code" datatype="s4-4" errormsg="请填写4位字符" type="text" class="h08 lh8 border ti1 block fl" placeholder="请输入验证码" />
      <div style="width:40%; text-align:center; margin-right:3%; margin-left:5%; float:right; margin-top:0px;"><img src="/code" height="40" onclick="this.src = '/code?date='+Math.random();"/></div>
      <div class="clear"></div>
    </section>
    <section class="w80 mga mt20 login_yzm">
      <input  name="smscode" datatype="s4-4" errormsg="请填写4位字符" type="text" class="h08 lh8 border ti1 block fl" placeholder="请输入验证码" />
      <input type="button" id="smsCodeBtn"  class="sub fr block ta-c h08 lh8 darkbg white" value="发送验证码" style="width:40%; margin-right:3%; margin-left:5%; float:right; font-size:0.8em;" />
      <div class="clear"></div>
    </section>
    
    <p class="w80 mga mt40">
      <a href="/touch/regid" class="red">账号注册</a>
    </p>

    <input type="submit" class="h08 lh8 w80 white redbg block mga sub bor-rad mt20 fs3" value="立即注册" />
    <p class="fs2 c9 w80 mga pt10">*注册即表示您同意<a class="red" href="/touch/info/content/13?mid=10">《惠资生活网上商城用户协议》</a></p>
    <div class="clear h03"></div>

</form>  
</body>
</html>
