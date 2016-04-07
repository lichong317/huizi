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
<script type="text/javascript">
$(document).ready(function(){
    
});
</script>
</head>

<body class="eeebg">

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>账户信息</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="w100 pt20 pb20 whitebg bot-border">
  <p class="mymoney">可消费金额：
  	  <#if user.roleId?? && user.roleId == 1>
  	 	 <span class="red lh5 fs35 block mt10">￥<#if user.totalCashRewards??>${user.totalCashRewards?string("0.00")}</#if></span>
  	  <#elseif user.roleId?? && user.roleId == 2>
  	  	 <span class="red lh5 fs35 block mt10">￥<#if user.virtualCurrency??>${user.virtualCurrency?string("0.00")}</#if></span>
  	  <#elseif user.roleId?? && user.roleId == 3>
         <span class="red lh5 fs35 block mt10">￥<#if user.directSaleCashRewards??>${user.directSaleCashRewards?string("0.00")}</#if></span>
  	  </#if>
  </p>
  <p class="mymoney">可提现金额：
  	  <#if user.roleId?? && user.roleId == 1>
  		 <span class="red lh5 fs35 block mt10">￥<#if user.totalCashRewards?? &&  user.cashRewardsFrozen??><#if user.totalCashRewards < user.cashRewardsFrozen>${user.totalCashRewards?string("0.00")}<#else>${(user.totalCashRewards - user.cashRewardsFrozen)?string("0.00")}</#if></#if></span>
  	  <#elseif user.roleId?? && user.roleId == 2>
  	  	 <span class="red lh5 fs35 block mt10">￥<#if user.virtualCurrency?? &&  user.frozenCapital??><#if user.virtualCurrency < user.frozenCapital>${user.virtualCurrency?string("0.00")} <#else>${(user.virtualCurrency - user.frozenCapital)?string("0.00")}</#if></#if></span>
  	  <#elseif user.roleId?? && user.roleId == 3>
  	     <span class="red lh5 fs35 block mt10">￥<#if user.directSaleCashRewards??>${user.directSaleCashRewards?string("0.00")}</#if></span>
  	  </#if>
  </p>
  <div class="clear"></div>
</div>
<div class="w100 pt30 pb30 whitebg">
  <section class="w90 mga">
    <p>默认开户银行：${user.bankTitle!''}</p>
    <p>默认银行卡号：<#if user.bankCardCode?? && user.bankCardCode?length gt 19>${user.bankCardCode[0..4]?default("")}****${user.bankCardCode[17..19]?default("")}<#elseif user.bankCardCode?? && user.bankCardCode?length gt 4>${user.bankCardCode[0..4]?default("")}****</#if></p>    
    <a href="/touch/user/withdraw/edit" class="greenbtn fs3 mt30 w40 h06 lh6 bor-rad">申请提现</a>
  </section>
</div>

<h3 class="center mt30 scoretit mb20"><p>提现记录</p></h3>
   <#if withdraw_page??>
   		<#list withdraw_page.content as withdraw>
   			<section class="history_tx center mb10">
			  <h3><span class="absolute-l">${withdraw.withdrawTime!""}</span>提现金额<span class="fs3 ml10">${withdraw.totalWithdraw?string("0.00")}</span></h3>
			  <p><span class="c9 mr10 ta-r">真实姓名</span>${withdraw.realName!""}</p>
			  <p><span class="c9 mr10 ta-r">开户行</span>${withdraw.bankName!""}</p>
			  <p><span class="c9 mr10 ta-r">银行卡</span> <#if withdraw.bankCardNumber?? && withdraw.bankCardNumber?length gt 18>${withdraw.bankCardNumber[0..4]?default("")}****${withdraw.bankCardNumber[16..18]?default("")}<#elseif withdraw.bankCardNumber?? && withdraw.bankCardNumber?length gt 4>${withdraw.bankCardNumber[0..4]?default("")}****</#if>				  
              </p>              
			  <p><span class="c9 mr10 ta-r">手机号码</span>${withdraw.mobile!''}
			     <b> <#if withdraw.statusId?? && withdraw.statusId==1>
                        已审核
                    <#else>
                        未审核
                    </#if>
                  </b>
			  </p>
			</section>
   		</#list>
   </#if>

<div class="clear h02"></div>
<p class="center ta-r">
  <#if withdraw_page??>
        <#if withdraw_page.number+1 == 1>
            <a class="c9 mr30" href="javascript:;"><span>上一页</span></a>
        <#else>
            <a href="/touch/user/account/info?page=${withdraw_page.number-1}" class="mr30">上一页</a>
        </#if>  
        
        <#if withdraw_page.number+1 == withdraw_page.totalPages || withdraw_page.totalPages==0>
              <a  href="javascript:;"><span>下一页</span></a>
        <#else>
              <a href="/touch/user/account/info?page=${withdraw_page.number+1}"><span>下一页</span></a>
        </#if>  
    </#if>
</p>
<div class="clear h03"></div>
  
</body>
</html>
