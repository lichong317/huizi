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
<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script>
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
            alert("请输入正确的手机号");
            return;
        }
        
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
                alert("error");
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
    <p>注册</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <span style="color: #F00"><#if errCode??>
            <#if errCode==1>
                验证码错误
            <#elseif errCode==4>
                短信验证码错误
            </#if>
        </#if></span>
  <form id="form1" method="post" action="/touch/reg">
      <input name="shareId" type="hidden" value="">   
      
      
      <div class="logintext">    
        <input placeholder="请输入用户名" name="username" datatype="s6-20" ajaxurl="/reg/check/username" class="login_ts01" type="text" style="font-family:'微软雅黑';" value="" />
      </div>
      
      <div class="logintext logintext01">
        <input placeholder="请输入密码" name="password" class="login_ts02" type="password" value="" datatype="s6-20" style="font-family:'微软雅黑';" />
      </div>
      
      <div class="logintext logintext01">
        <input placeholder="请确认密码" class="login_ts02" type="password" value="" datatype="*" recheck="password" style="font-family:'微软雅黑';" />
      </div>
      
      <div class="logintext logintext01">
        <input placeholder="手机验证" name="mobile" class="login_ts02" type="password" value="" datatype="m" ajaxurl="/reg/check/mobile" style="font-family:'微软雅黑';" />
      </div>
      
      <div class="logintext03">
        <input placeholder="短信验证码" class="login_ts03"  name="smsCode" datatype="s4-4" errormsg="请填写4位字符" type="text" style="font-family:'微软雅黑';" value="" />
      </div>
        <input id="smsCodeBtn" onclick="javascript:;" readOnly="true"  class="loginbtn fl" value="发送验证码" style="width:40%; margin-right:3%; margin-left:5%; float:right; font-size:0.8em;" />
    <div class="clear20"></div>  
      
      
    <input class="orange_btn " type="submit" value="立即注册" style="margin-top: 15px; font-family:'微软雅黑';">
   </form>
<div class="center mt15 pb15">
    <a class="absolute-l fs08 c9 fr" href="/touch/info/content/13?mid=10">注册既表示您同意<span class="red">《惠之店网上商城用户协议》</span></a>
  </div>  
  <p class="center c9 fs08 pt15">其他方式登录</p>
  <table class="login_check">
    <tr>
      <td><img style="margin-left:40%;" src="/touch/images/dddl_03.png" /><a href="#">微信登录</a></td>
      <td><img style="margin-left:40%;" src="/touch/images/dddl_06.png" /><a href="#">支付宝登录</a></td>
      <td><img style="margin-left:40%;" src="/touch/images/dddl_09.png" /><a href="#">QQ登录</a></td>
    </tr>
  </table>
</div>
<!--main END-->


  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/reg">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
