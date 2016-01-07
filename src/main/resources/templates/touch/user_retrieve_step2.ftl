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

<script>
$(document).ready(function(){
    var pElement = $("#mobile").toArray();
    for(var i = 0;i < pElement.length;i++)
    {
       var originName = pElement[i].innerHTML
       var name =  changeName(originName)
       pElement[i].innerText=name;
    }

});

 function changeName(p)
{
    var temp = p
    if(temp.length == 11)
    {
        var changeStr = temp.substring(3, 7)
        temp = temp.replace(changeStr,"****")
    }
    else
    {
        var startStr = ""
        var strLength = temp.length;
        for (var i = 0; i < strLength - 4; i++)
        {
            startStr += "*";
        }
        var changeStr = temp.substring(2, strLength - 2)

        temp = temp.replace(changeStr, startStr)
    }
    return temp;
}


var seed=60;    //60秒  
var t1=null; 

$(document).ready(function(){
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3
    });
     
    $("#smsCodeBtn").bind("click", function() {  
        
        var mob = <#if user??>${user.mobile!''}</#if>;
        
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
    <p>找回密码</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<!--main-->
<div class="main">
<span style="color: #F00"><#if errCode??>
            <#if errCode==1>
                验证码错误
            <#elseif errCode==4>
                短信验证码错误
            </#if>
        </#if></span>
  <style>
.h15{height: 15px;}
  </style>
<form id="form1" method="post" action="/touch/login/retrieve_step2">
    <select style="width: 100%; height: 40px;margin-bottom: 20px;"><option>注册时填写的手机号</option></select>
    <div class="clear h20"></div>
  
    <p class="fs09">用户名:&nbsp;&nbsp;<span class="red"><#if user??>${user.username}</#if></span></p>
    <div class="clear h15"></div>
    <p class="fs09">手机号:&nbsp;&nbsp;<span class="red">
                                    <#if user.mobile??>
                                        <#if user.mobile?length gt 8>
                                            ${user.mobile[0..6]?default("")}****
                                        </#if>
                                    <#else>
                                        ************
                                    </#if></span></p>
    <div class="clear h15"></div>
    <p class="fs09">请输入短信验证码</p>
 
    <div class="logintext05 " style="background:#FFF;;">
        <input name="smsCode" type="text" class="logintext02" style="background: none;border: 1px solid #ccc;
      width: 100%;
      height: 40px;" value="" />
    </div>
    <input id="smsCodeBtn" type="button" class="sub" style="width: 40%;text-align:center;
  border-radius: 3px;
  margin-top: 20px;
  background: #1c2b38;
  color: #fff;
  line-height: 35px;
  height: 35px;" value="点击获取短信验证码" />
    <div class="clear"></div>
    <input type="submit" class="loginbtn" value="下一步" />
</div>
 </form>
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
