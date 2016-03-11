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

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    menuClassHeight("#choose_con","#choose_tit","#choose_bot");
    menuCheckShow("pro_mmenu","li","pro_msum","section","sel",0);
    indexBanner("box","sum",300,5000,"pronum");//Banner
    indexBanner("morebox01","moresum01",300,10000,"morenum01");//Banner
    indexBanner("morebox02","moresum02",300,10000,"morenum02");//Banner
  
});


</script>
</head>


<body>
<header class="comhead">
  <h2>积分商品详情</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="/touch/cart" class="a1"><img src="/touch/images/info03.png" /></a>
</header>
<div class="comheadbg"></div>
    <section id="box" class="bannerbox bot-border">
      <ul id="sum" class="bannersum">
        <#if goods.showPictures??>
            <#list goods.showPictures?split(",") as uri>
                <#if ""!=uri>
                    <li><img src="${uri!''}" /></li>
                </#if>
            </#list>
        </#if>
      </ul>
      <div class="clear"></div>
    </section><!--我是banner-->
<div class="clear h02"></div>
<#if goods??>
    <h3 class="center fs35 pb10 lh4">${goods.title!''}</h3>
    <p class="center c9 lh3 pb20">${goods.subTitle!''}</p>
    <p class="lh4 fs35 mainbox bot-border pb20">兑换积分<span class="red mr10">&nbsp;<#if goods.pointUse??>${goods.pointUse?c}积分</#if></span><span class="unl-th c9"></span></p>
    
    <div class="procheck mainbox top-border bot-border mt20">
      <span class="c9 mr20">促销</span>
      <span class="inblock pl10 pr10 bor-rad redbg white mr10">积分兑换</span>
    </div>
    <a class="procheck mainbox bot-border" onclick="$('.winbg').fadeToggle(200);">
      <span class="c9 mr20">已选</span>
      <#if goods??>
         ${goods.title!''}                  
      </#if>
    </a>
<#--    <a class="procheck mainbox bot-border">
      <span class="c9 mr20">送至</span>
      <span class="pro_pace">云南 昆明市 西山区</span>
      <span class="red ml10">现货</span>
    </a>  -->
    <div class="procheck mainbox bot-border">
      <span class="c9 mr20">服务</span>
      <a class="pro_server" href="#"><img src="/touch/images/info04.png" />正品保障</a>
      <a class="pro_server" href="#"><img src="/touch/images/info05.png" />闪电发货</a>
      <a class="pro_server" href="#"><img src="/touch/images/info06.png" />售后保障</a>
    </div>
</#if>
<a class="procheck mainbox bot-border top-border mt20 mb20" href="/touch/goods/detail/${goods.id?c}">
  <span class="c9 mr20">图文详情/规格参数/售后服务</span>
</a>
<#--
<a class="procheck mainbox top-border" href="/touch/goods/comment/<#if goods??>${goods.id?c}</#if>">
  <span class="c9 mr20 fs3">商品评价</span>
  <p class="c9 pro_com">${comment_count!'0'}人评价<span class="red ml10"><#if three_star_comment_count?? && comment_count?? && comment_count != 0>${(three_star_comment_count/comment_count * 100) ?string("0")}</#if>%好评</span></p>
</a>
<div class="center top-border"></div>
    <#if comment_page??>
        <#list comment_page.content as item>
            <#if item_index < 3>
                <section class="pro_leave center pt30">
                  <h3><p class="absolute-r c9"><b class="userName">${item.username!''}</b>&nbsp;&nbsp;&nbsp;&nbsp;${item.commentTime?string("yyyy-MM-dd")}</p>
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 0>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 1>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 2>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 3>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 4>star01.png<#else>star02.png</#if>" />
                  </h3>
                  <p class="pb10">${item.content!''}</p>
                  <p class="pb10"><span class="red">商家回复：</span><#if item.isReplied?? && item.isReplied>${item.reply!''}</#if></p>
                </section>
            </#if>
        </#list>
    </#if>

<div class="w100 bot-border h03"></div>
<a href="/touch/goods/consult/<#if goods??>${goods.id?c}</#if>" class="redborbtn w80 mga lh7 h07 mt20 mb20 fs3">商品咨询</a>

-->
<section class="tabfix pro_mmenu w100">
  <menu id="pro_mmenu">
    <li class="sel"><a href="#">热卖排行</a></li>
    <li><a href="#">浏览记录</a></li>
  </menu>
</section>
<div class="clear h03"></div>
<div id="pro_msum">
    <section id="morebox01" class="morebox bot-border">
      <ul id="moresum01" class="bannersum">
        <li>
            <#if hot_list??>
                <#list hot_list as item>
                    <#if item_index < 6>
                        <a class="a1" href="/touch/goods/${item.id?c}">
                            <img src="${item.coverImageUri!''}" width="80" height="80"/>
                            <p>${item.title!''}</p>
                            <span>￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></span>
                        </a>
                    </#if>
                </#list>
            </#if>
          <div class="clear"></div>
        </li>
        <li>
            <#if hot_list??>
                <#list hot_list as item>
                    <#if item_index gt 5 && item_index < 12>
                        <a class="a1" href="/touch/goods/${item.id?c}">
                            <img src="${item.coverImageUri!''}" width="80" height="80"/>
                            <p>${item.title!''}</p>
                            <span>￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></span>
                        </a>
                    </#if>
                </#list>
            </#if>
          <div class="clear"></div>
        </li>
      </ul>
      <div class="clear"></div>
    </section><!--我是banner-->
    <section id="morebox02" class="morebox bot-border">
      <ul id="moresum02" class="bannersum">
        <li>
            <#if recent_page??>
                <#list recent_page.content as item>
                    <#if item_index < 6>
                        <a class="a1" href="/touch/goods/${item.id?c}">
                           <img src="${item.goodsCoverImageUri!''}" width="80" height="80"/>
                            <p>${item.title!''}</p>
                            <span>￥<#if item.goodsSalePrice??>${item.goodsSalePrice?string("0.00")}</#if></span>
                        </a>
                    </#if>
                </#list>
            </#if>
          <div class="clear"></div>
        </li>
        <li>
           <#if recent_page??>
                <#list recent_page.content as item>
                    <#if item_index gt 5 && item_index < 12>
                        <a class="a1" href="/touch/goods/${item.id?c}">
                            <img src="${item.goodsCoverImageUri!''}" width="80" height="80"/>
                            <p>${item.title!''}</p>
                            <span>￥<#if item.goodsSalePrice??>${item.goodsSalePrice?string("0.00")}</#if></span>
                        </a>
                    </#if>
                </#list>
            </#if>
          <div class="clear"></div>
        </li>
      </ul>
      <div class="clear"></div>
    </section><!--我是banner-->
</div>

<div class="clear h11"></div>
<footer class="profoot">  
  <a class="a2 ml10" href="/touch/cart"><span>购物车</span></a>
  <#if goods.leftNumber gt 0>
     <a class="a3" href="/touch/pointGoods/order/info?pointGoodsId=${goods.id?c}" ><span>立即兑换</span></a>
  <#else>
     <a class="a3" href="javascript:;" ><span>库存不足</span></a>      
  </#if>
  <div class="clear"></div>
</footer>

<aside class="winbg" style="display:none">
  <div class="choosebox">
    <a class="close" href="javascript:void(0);" onClick="$(this).parent().parent().fadeOut(200);"><img src="/touch/images/close.png" /></a>
    <input id="choose_tit" type="submit" value="加入购物车" class="sub addcarbtn" />
    <section class="con" id="choose_con">
      <div class="prochoose"><b><img src="${goods.coverImageUri!''}" /></b></div>
      <div class="prochoose_bg"></div>
      <#if total_select??>
          <#if 1==total_select>
               <h3>${select_one_name!''}：</h3>
               <#if select_one_goods_list??>
                    <#list select_one_goods_list as item>
                        <a <#if item.selectOneValue==one_selected>class="a2 a1sel"<#else>class="a2"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectOneValue}</a>
                    </#list>
               </#if>
          <#elseif 2==total_select>
               <h3>${select_one_name!''}：</h3>
               <#if select_one_goods_list??>
                    <#list select_one_goods_list as item>
                        <a <#if item.selectOneValue==one_selected>class="a2 a1sel"<#else>class="a2"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectOneValue}</a>
                    </#list>
               </#if>
               
               <h3>${select_two_name!''}：</h3>
               <#if select_two_goods_list??>
                     <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="a2 a1sel"<#else>class="a2"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectTwoValue}</a>
                     </#list>
               </#if>
          <#elseif 3==total_select>
               <h3>${select_one_name!''}：</h3>
               <#if select_one_goods_list??>
                    <#list select_one_goods_list as item>
                        <a <#if item.selectOneValue==one_selected>class="a2 a1sel"<#else>class="a2"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectOneValue}</a>
                    </#list>
               </#if>
               
               <h3>${select_two_name!''}：</h3>
               <#if select_two_goods_list??>
                     <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="a2 a1sel"<#else>class="a2"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectTwoValue}</a>
                     </#list>
               </#if>
               
               <h3>${select_three_name!''}：</h3>
               <#if select_three_goods_list??>
                     <#list select_three_goods_list as item>
                            <a <#if item.selectThreeValue==three_selected>class="a2 a1sel"<#else>class="a2"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectThreeValue}</a>
                     </#list>
               </#if>
          </#if>
      </#if>
      <div class="clear h03"></div>
    </section>
    <div class="w100" id="choose_bot"></div>
  </div>
</aside>
  
</body>
</html>
