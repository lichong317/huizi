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
  <h2>消息中心</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<section class="listhead tabfix w100 myorderhead">
  <menu>
    <li <#if typeId?? && typeId == 0>class="sel"</#if>>
      <a href="/touch/message/list?typeId=0">公告（${count_announcement!'0'}）</a>
    </li>
    <li <#if typeId?? && typeId == 1>class="sel"</#if>>
      <a href="/touch/message/list?typeId=1">系统消息（${count_system!'0'}）</a>
    </li>
  </menu>
</section>
<div class="clear h02"></div>

<#if typeId?? && typeId == 0>
    <#if message_page?? && message_page.content?size gt 0>
        <#list message_page.content as item>
            <a href="/touch/message/edit?messageId=${item.id?c}" class="news_gg">
              <h3>${item.title!''}</h3>
              <p class="fs2 c9">${item.createTime!''}</p>
              <p class="c8 pt10">${item.brief!''}</p>
            </a>
        </#list>   
    <#else>
        <div class="clear" style="height:2rem;"></div>
        <p class="ta-c"><img src="/touch/images/none.png" style="width:1.5rem;" /></p>
        <p class="ta-c pt20 c9">暂无消息</p>  
    </#if>
<#elseif typeId?? && typeId == 1>
    <#if message_page?? && message_page.content?size gt 0>
        <#list message_page.content as item>
            <a href="/touch/message/edit?messageId=${item.id?c}" class="news_xt">
              <h3 class="fs3">${item.title!''}</h3>
              <p class="fs2 c9">${item.createTime!''}</p>
              <p class="c9">${item.brief!''}</p>
            </a>
        </#list>
    <#else>
        <div class="clear" style="height:2rem;"></div>
        <p class="ta-c"><img src="/touch/images/none.png" style="width:1.5rem;" /></p>
        <p class="ta-c pt20 c9">暂无消息</p> 
    </#if>
</#if>

<div class="clear h03"></div>
  
</body>
</html>
