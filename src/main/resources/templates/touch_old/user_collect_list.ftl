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

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>收藏列表</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">

<#if collect_page?? && collect_page.content?size gt 0>
    <#list collect_page.content as cg>
        <section class="carlist">
            <a href="/touch/goods/${cg.goodsId?c}"><b><img src="${cg.goodsCoverImageUri!''}" width="97" height="97"/></b></a>
            <p>${cg.goodsTitle!''}</p>
            <p class="sc fr mt5" ><span class="sc">￥${cg.goodsSalePrice?string("#.##")}</span></p>
            <div class="clear"></div>
            <a class="a1" href="/touch/user/collect/del?id=${cg.goodsId?c!''}"><img src="/touch/images/delete.png" width="30" /></a>
        </section>
    </#list>
<#else>
    <div>
        <p style="text-align:center">您还没有收藏商品哦！</p>
        <p style="text-align:center"><a class="blue" href="/touch/">马上去购物>>  </a></p>
    </div>
</#if>
      
<!--main END-->

<#if !app??>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user/collect/list">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
