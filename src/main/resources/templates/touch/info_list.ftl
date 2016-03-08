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
<script type="text/javascript">
$(document).ready(function(){
    
});
</script>
</head>

<body class="eeebg">
<header class="comhead">
  <h2>惠资讯</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="mainbox whitebg">
<section class="tabfix w100 newsclass">
  <menu>
    <#if menu_list??>
        <#list menu_list as item>
            <#if item_index < 4>
                <a <#if item.id == mid>class="sel"</#if> href="/touch/info/list/${item.id?c}">${item.title!''}</a>
            </#if>
        </#list>
    </#if>
  </menu>
</section>
</div>

<#if Article_ad_list??>
    <#list Article_ad_list as item>
        <#if item_index < 1>
            <a class="block w100 mt10" href="${item.linkUri!''}"><img class="block w100" src="${item.fileUri!''}" width="320" height="100"/></a>
        </#if>
    </#list>
<#else>
    <a class="block w100 mt10" href="#"><img class="block w100" src="/touch/images/pictures/banner02.png" /></a>
</#if>

<#if info_page??>
    <#list info_page.content as item>
        <#if item_index < 5>
            <a class="newslist center mt10" href="/touch/info/content/${item.id?c}?mid=${mid!''}">
              <img class="img" src="<#if item.imgUrl?? && item.imgUrl == ''>/touch/images/logo.png<#else>${item.imgUrl!'/touch/images/logo.png'}</#if>" width="96" height="64"/>
              <p class="tit">${item.title!''}</p>
              <div class="info"><p><#if item.createTime??>${item.createTime?string("yyyy-MM-dd")}</#if><span>${menu_name!''}</span><p></div>
            </a>
        </#if>
    </#list>
</#if>

<#if Article_ad_list??>
    <#list Article_ad_list as item>
        <#if item_index gt 0 && item_index < 2>
            <a class="block w100 mt10" href="${item.linkUri!''}"><img class="block w100" src="${item.fileUri!''}" width="320" height="100"/></a>
        </#if>
    </#list>

</#if>

<#if info_page??>
    <#list info_page.content as item>
        <#if item_index gt 4 >
            <a class="newslist center mt10" href="/touch/info/content/${item.id?c}?mid=${mid!''}">
              <img class="img" src="<#if item.imgUrl?? && item.imgUrl == ''>/touch/images/logo.png<#else>${item.imgUrl!'/touch/images/logo.png'}</#if>" width="96" height="64"/>
              <p class="tit">${item.title!''}</p>
              <div class="info"><p><#if item.createTime??>${item.createTime?string("yyyy-MM-dd")}</#if><span>${menu_name!''}</span><p></div>
            </a>
        </#if>
    </#list>
</#if>

<div class="clear h02"></div>    
<div class="mainfoot_bg"></div>
<footer class="tabfix mainfoot">
  <menu>
    <a href="/touch"><img src="/touch/images/foot01.png" /><p>首页</p></a>
    <a class="sel" href="#"><img src="/touch/images/foot02.png" /><p>资讯</p></a>
    <a href="/touch/category/list"><img src="/touch/images/foot03.png" /><p>分类搜索</p></a>
    <a href="/touch/cart/"><img src="/touch/images/foot04.png" /><p>购物车</p></a>
    <a href="/touch/user/"><img src="/touch/images/foot05.png" /><p>会员中心</p></a>
  </menu>
</footer>
  
</body>
</html>
