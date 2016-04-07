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
  <h2>下级用户</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<h3 class="mainbox pt20 pb10 lh5 fs25 whitebg">下级用户<b class="red fs4 ml10"><#if user?? && user.totalLowerUsers??>${user.totalLowerUsers}</#if></b></h3>

<#if junioruser_page??>
      <#list junioruser_page.content as item>
      	  <section class="followlist center mt20">
			  <a class="box01" href="/touch/user/lowerusers/order/list?lowerusername=${item.username}">
			    <p class="textover">${item.username}</p>
			    <span>${item.userLevelTitle!''}</span>
			  </a>
			  <div class="box02">
			    <p><span class="c9 mr10">消费总额</span>￥${item.totalSpendCash!'0'}</p>
			    <p class=" mt20"><span class="c9 mr10">返利总额</span>￥${item.totalCashRewardsToUpuser!'0'}</p>
			  </div>
			  <a class="box03" href="/touch/user/lowerusers/order/list?lowerusername=${item.username}">查看订单 </a>
			  <div class=" clear"></div>
		  </section>
      </#list>
</#if>

<div class="clear h02"></div>
<p class="center ta-r">
  <#if junioruser_page??>
        <#if junioruser_page.number+1 == 1>
            <a class="c9 mr30" href="javascript:;"><span>上一页</span></a>
        <#else>
            <a href="/user/junioruser/list?page=${junioruser_page.number-1}" class="mr30">上一页</a>
        </#if>  
        
        <#if junioruser_page.number+1 == junioruser_page.totalPages || junioruser_page.totalPages==0>
              <a  href="javascript:;"><span>下一页</span></a>
        <#else>
              <a href="/user/junioruser/list?page=${junioruser_page.number+1}"><span>下一页</span></a>
        </#if>  
    </#if>
</p>

<div class="clear h03"></div>
  
</body>
</html>
