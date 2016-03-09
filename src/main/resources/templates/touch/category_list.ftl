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
    menuClassHeight("#listclass",".mainfoot",".comhead");
});
</script>
</head>

<body>
<header class="comhead">
   <form action="/touch/search" method="get">
      <section class="topsearch">   
        <input name="keywords" type="text" class="text" placeholder="搜索关键字" />
        <input type="submit" class="sub" value=" " /> 
      </section>
   </form>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="listclass" id="listclass">
    <#if top_cat_list??>
        <#list top_cat_list as item>
           <a <#if categoryId?? && item.id == categoryId>class="sel"<#elseif !categoryId?? && item_index == 0>class="sel"</#if> href="/touch/category/list?categoryId=${item.id?c}">${item.title!''}</a>
        </#list>
    </#if>
</div>

<div class="classbox">
    <#if second_level_cat_list??>
        <#list second_level_cat_list as item>
              <h3 class="red tit"><a href="/touch/list/${item.id?c}" class="red">${item.title!''}</a></h3>
              <#if ("third_level_" + item_index + "_cat_list")?eval??>
                   <#list ("third_level_" + item_index + "_cat_list")?eval as secitem>
                        <a class="a1" href="/touch/list/${secitem.id?c}"><img src="${secitem.imgUrl!'/touch/images/pictures/img05.png'}" /><p>${secitem.title!''}</p></a>
                   </#list>
              </#if> 
              <div class="clear"></div>            
        </#list>
        
    </#if>
      <div class="clear h02"></div>  
</div>
    
<div class="mainfoot_bg"></div>
<footer class="tabfix mainfoot">
  <menu>
    <a href="/touch/"><img src="/touch/images/foot01.png" /><p>首页</p></a>
    <a href="/touch/info/list/10"><img src="/touch/images/foot02.png" /><p>资讯</p></a>
    <a class="sel" href="#"><img src="/touch/images/foot03.png" /><p>分类搜索</p></a>
    <a href="/touch/cart/"><img src="/touch/images/foot04.png" /><p>购物车</p></a>
    <a href="/touch/user"><img src="/touch/images/foot05.png" /><p>会员中心</p></a>
  </menu>
</footer>
  
</body>
</html>
