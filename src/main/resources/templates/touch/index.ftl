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
    indexBanner("box","sum",300,5000,"num");//Banner
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
  <a href="#" class="logo"><img src="/touch/images/logo.png" /></a>
  <a href="/touch/message/list" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

    <section id="box" class="bannerbox">
      <ul id="sum" class="bannersum">
      <#if banner_ad_list??>
        <#list banner_ad_list as item>
            <#if item_index < 4>
                <li><a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a></li>
            </#if>
        </#list>
      </#if>
      </ul>
      <div class="clear"></div>
    </section><!--我是banner-->

<section class="center tabfix indexnav">
  <nav>
    <#if touch_navi_item_list??>
        <#list touch_navi_item_list as item>
            <#if item_index < 4>
                <li><a href="${item.linkUri!''}"><img src="${item.iconUri!''}" style="width:50px" height="50"/><p>${item.title!''}</p></a></li>
            </#if>
        </#list>
    </#if>
  </nav>
  <nav>
    <#if touch_navi_item_list??>
        <#list touch_navi_item_list as item>
            <#if item_index gt 3 && item_index < 8>
                <li><a href="${item.linkUri!''}"><img src="${item.iconUri!''}" style="width:50px" height="50"/><p>${item.title!''}</p></a></li>
            </#if>
        </#list>
    </#if>
  </nav>
</section>
<div class="clear h02"></div>

<div class="mainbox eeebg pt20 pb20">
  <table class="index_sg">
    <#if top_ad_list??>
        <tr>
        <#list top_ad_list as item>
             <#if item_index < 2>                  
                  <#if item_index == 0>                      
                         <th rowspan="2">
                            <img class="tit" src="/touch/images/index/indextit01.png" />
                            <a href="${item.linkUri!''}">
                               <img src="${item.fileUri!''}"/>
                            </a>
                         </th>
                  <#else>
                         <td>
                            <a href="${item.linkUri!''}">
                               <img src="${item.fileUri!''}" />
                            </a>
                         </td>                      
                  </#if>
            </#if>
        </#list>
        </tr>
        <tr>
            <#list top_ad_list as item>
                <#if item_index ==2>
                     <td>
                           <a href="${item.linkUri!''}">
                               <img src="${item.fileUri!''}" />
                           </a>
                     </td> 
                </#if>
            </#list>
        </tr>
    </#if>
  </table>
</div>

<#if goodsCategory_ad_list??>
    <#list goodsCategory_ad_list as item>   
        <#if item_index < 1>
            <a href="${item.linkUri!''}" class="w100 block"><img class="w100 block" src="${item.fileUri!''}" /></a>
        </#if>
    </#list>    
</#if>

<div class="w100 h02 eeebg"></div>

<a class="indextit" href="#"><p class="blue">推荐商品</p></a>
<section class="tabfix w100 indexlist">
  <menu>
    <#if goodsRecommend_ad_list??>
        <#list goodsRecommend_ad_list as item>
            <#if item_index < 2>
                <a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a>                
            </#if>
        </#list>
    </#if>
  </menu>
</section>
<section class="tabfix w100 indexlist">
  <menu>
    <#if goodsRecommend_ad_list??>
        <#list goodsRecommend_ad_list as item>
            <#if item_index gt 1 && item_index < 5>
                <a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a>                
            </#if>
        </#list>
    </#if>
  </menu>
</section>

<div class="w100 h02 eeebg"></div>

<#if goodsCategory_ad_list??>
    <#list goodsCategory_ad_list as item>   
        <#if item_index== 1>
            <a href="${item.linkUri!''}" class="w100 block"><img class="w100 block" src="${item.fileUri!''}" /></a>
        </#if>
    </#list>    
</#if>
<div class="w100 h02 eeebg"></div>

<a class="indextit indextit01" href="#"><p class="red">人气新品</p></a>
<#if goodsHot_ad_list??>
    <section class="tabfix w100 indexlist">
      <menu>
        <#list goodsHot_ad_list as item>
            <#if item_index < 2>
                <a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a>
            </#if>
        </#list>
      </menu>
    </section>
    <section class="tabfix w100 indexlist">
      <menu>
        <#list goodsHot_ad_list as item>
            <#if item_index gt 1 && item_index < 4>
                <a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a>
            </#if>
        </#list>
      </menu>
    </section>
</#if>
<div class="w100 h02 eeebg"></div>
<#if goodsCategory_ad_list??>
    <#list goodsCategory_ad_list as item>   
        <#if item_index == 2>
            <a href="${item.linkUri!''}" class="w100 block"><img class="w100 block" src="${item.fileUri!''}" /></a>
        </#if>
    </#list>    
</#if>
<div class="w100 h02 eeebg"></div>

<a class="indextit indextit02" href="#"><p class="orange">精品推荐</p></a>
<table class="w100 indexpro">
<#if selection_ad_list??>
  <tr>
    <#list selection_ad_list as item>
        <#if item_index ==0>
            <td rowspan="2"><a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a></td>           
        <#elseif item_index ==1>
            <td colspan="2"><a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a></td>
        </#if>
    </#list>
  </tr>
  <tr>
    <#list selection_ad_list as item>  
        <#if item_index gt 1 && item_index < 4>  
            <td><a href="${item.linkUri!''}"><img src="${item.fileUri!''}" /></a></td>
        </#if>
    </#list>
  </tr>
</#if>
</table>
<div class="w100 h06 eeebg"></div>

<section class="botlogin">
  <#if username??>
        <a href="/touch/user">${username!''}</a> | <a href="/touch/logout">退出</a>
  <#else>
       <a href="/touch/login">登录</a> | <a href="/touch/regid">注册</a>
  </#if>
  <a class="a1" href="javascript:$('html,body').animate({scrollTop:0},500);">TOP</a>
</section>

<#if !app??>

<p class="ta-c pt20 fs3"><a href="#">触屏版</a><a class="ml40" href="/">电脑版</a></p>
<p class="ta-c pb20 c6 center lh3 pt10">${site.copyright!''}</p>


<div class="mainfoot_bg"></div>
<footer class="tabfix mainfoot">
  <menu>
    <a class="sel" href="#"><img src="/touch/images/foot01.png" /><p>首页</p></a>
    <a href="/touch/info/list/10"><img src="/touch/images/foot02.png" /><p>资讯</p></a>
    <a href="/touch/category/list"><img src="/touch/images/foot03.png" /><p>分类搜索</p></a>
    <a href="/touch/cart/"><img src="/touch/images/foot04.png" /><p>购物车</p></a>
    <a href="/touch/user"><img src="/touch/images/foot05.png" /><p>会员中心</p></a>
  </menu>
</footer>
</#if> 
</body>
</html>
