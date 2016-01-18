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


<script type="text/javascript">

  $(function(){
    
        $("#btn_nextstep").click(function(){
            check();
        });
         
    });
    
  document.onkeydown = function(event){
    if((event.keyCode || event.which) == 13){
        check();
    }
   }
   
  function check(){
        var username = $("#txt_loginId").val();
        var code = $("#code").val();
        
        if (username.length < 6 )
        {
            //alert("用户名长度输入不足");
            ct.alert({
                    text: "用户名长度输入不足",
                    type: "alert"
            });
            return;
        }
        $.ajax({
                type: "post",
                url: "/login/password_retrieve",
                data: { "username": username, "code": code },
                dataType: "json",
                success: function (data) { 
                <!-- 修改 -->                       
                     if (data.code == 0) {
          
                            window.location.href="/touch/login/retrieve_step2";
               
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
<div class="main" style="width:90%">
    <div class="logintext">
        <input type="text" class="logintext01" value="" id="txt_loginId" name="username" placeholder="请输入用户名/手机号"/>
    </div>
    <div class="logintext logintext_y">
        <input type="text" class="logintext_p" id="code" name="code" value="" placeholder="请输入验证码"/>
    </div>
        <a href="#" class="login_yzm" style=" margin-top: 10px" ><img src="/code"  onclick="this.src = '/code?date='+Math.random();"/></a>
    <div class="clear"></div>
    <input id="btn_nextstep" type="submit" class="loginbtn" value="下一步" />
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
