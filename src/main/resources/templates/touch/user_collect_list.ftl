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

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>我的收藏</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<#if collect_page?? && collect_page.content?size gt 0>
    <#list collect_page.content as cg>
        <div class="prolist mainbox bot-border whitebg">
          <a class="img" href="/touch/goods/${cg.goodsId?c}"><img src="${cg.goodsCoverImageUri!''}" /></a>
          <section>
          <a class="h07 oh block" href="/touch/goods/${cg.goodsId?c}">${cg.goodsTitle!''}</a>
          <p class="red mt20">￥${cg.goodsSalePrice?string("#.##")}<a class="sc_del" href="/touch/user/collect/del?id=${cg.goodsId?c!''}"><img src="/touch/images/del.png" /></a></p>
          </section>
          <div class="clear"></div>
        </div>
    </#list>
<#else>
    <div>
        <p style="text-align:center">您还没有收藏商品哦！</p>
        <p style="text-align:center"><a class="blue" href="/touch/">马上去购物>>  </a></p>
    </div>
</#if>

<div class="clear h03"></div>
  
</body>
</html>
