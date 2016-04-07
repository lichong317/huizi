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

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
	$("#btnSubmit").click(function(){
        var withdraw = $("#withdraw").val();
        var realName = $("#realName").val();
        var bankTitle = $("#bankTitle").val();
        var bankCardCode = $("#bankCardCode").val();
        var mobile = $("#mobile").val();
        
        if (undefined == withdraw || "" == withdraw)
        {
            ct.alert({
                   text: "请输入提现金额",
                   type: "alert"
            });
            $("#withdraw").focus();
            return;
        }
        
        if (undefined == realName || "" == realName)
        {
            ct.alert({
                   text: "请输入真实姓名",
                   type: "alert"
            });
            $("#realName").focus();
            return;
        }
        
        if (undefined == bankTitle || "" == bankTitle)
        {
            ct.alert({
                   text: "请输入开户行",
                   type: "alert"
            });
            $("#bankTitle").focus();
            return;
        }
        
        if (undefined == bankCardCode || "" == bankCardCode)
        {
            ct.alert({
                   text: "请输入银行卡号",
                   type: "alert"
            });
            $("#bankCardCode").focus();
            return;
        }
        
        if (undefined == mobile || "" == mobile)
        {
            ct.alert({
                   text: "联系电话不能为空",
                   type: "alert"
            });
            $("#mobile").focus();
            return;
        }
        
        $.ajax({
            type:"post",
            url:"/touch/user/withdraw/request",
            data:{
                "withdraw": withdraw,
                "realName": realName,
                "bankTitle": bankTitle,
                "bankCardCode": bankCardCode,
                "mobile": mobile 
            },
            
            success:function(res) {
                if (0 == res.code)
                {
                    ct.alert({
                           text: "提交成功！我们会尽快审核",
                           type: "alert"
                    });
                    window.location.href="/touch/user/account/info";
                }
                else
                {
                    ct.alert({
                           text: res.msg,
                           type: "alert"
                    });
                }
            }
        });
    });
});

function changeBank(){
	$("#bankCardCode").val($("#bankCardCodetext").val());
}

</script>
</head>

<body class="eeebg">

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>申请提现</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

	<div class="tx_text mt40">
	  <span>提现金额</span>
	  <input id="withdraw" type="text" class="text" value="" placeholder="请输入提现金额" />
	</div>
	<div class="whitebg pl30 red"><p class="top-border pt10 pb10 pr30">提现金额必须大于100才可以申请成功</p></div>
	<div class="tx_text mt20">
	  <span>开户行</span>
	  <input id="bankTitle" type="text" class="text" value="<#if user??>${user.bankTitle!''}</#if>" placeholder="请输入开户行" />
	</div>
	<div class="tx_text mt20">
	  <span>银行卡</span>
	  <input type="text" class="text" placeholder="默认银行卡号" id="bankCardCodetext" onchange="changeBank();" value="<#if user?? ><#if  user.bankCardCode?? && user.bankCardCode?length gt 18>${user.bankCardCode[0..4]?default("")}****${user.bankCardCode[16..18]?default("")}<#elseif user.bankCardCode?? && user.bankCardCode?length gt 4>${user.bankCardCode[0..4]?default("")}****</#if></#if>"/> 
	  <input id="bankCardCode" type="hidden" class="text" value="<#if user??>${user.bankCardCode!''}</#if>" placeholder="请输入银行卡" />
	</div>
	<div class="tx_text mt20">
	  <span>真实姓名</span>
	  <input id="realName" type="text" class="text" value="<#if user??>${user.realName!''}</#if>" placeholder="请输入真实姓名" />
	</div>
	<div class="tx_text mt20">
	  <span>手机号码</span>
	  <input id="mobile" type="text" class="text" value="<#if user??>${user.mobile!''}</#if>" placeholder="请输入手机号码" />
	</div>
	
	<input id="btnSubmit" type="submit" value="提交申请" class="sub block center redbg bor-rad h07 lh7 white fs3 mt40" />
	<div class="clear h03"></div>


<!--弹出层-->
<#-->
<aside class="winbg">
  <div class="myself_ts" style=" margin-top:7%;">
    <p class="ta-c fs3">请输入银行卡信息</p>
    <p class="pt10 lh4">真实姓名</p>
    <input type="text" class="eeebg h07 lh7 text w100 ti1" value="" />
    <p class="pt10 lh4">开户行</p>
    <input type="text" class="eeebg h07 lh7 text w100 ti1" value="" />
    <p class="pt10 lh4">银行账号</p>
    <input type="text" class="eeebg h07 lh7 text w100 ti1" value="" />
    <div class="clear h04"></div>
    <a class="sub w100 lh6 h06 ta-c white redbg block fs3" href="#">确认</a>
    <a class="sub w100 lh6 h06 ta-c darkborbtn fs3 mt20" href="javascript:void(0);" onClick="$(this).parent().parent().fadeOut(200);">取消</a>
  </div>
</aside>  -->
  
</body>
</html>
