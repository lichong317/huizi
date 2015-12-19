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
    <p>评价订单</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <div class="clear15"></div>
  <table class="content_check">
    <tr>
      <td>
        <a <#if !statusId?? || statusId??&&statusId==0>class="a2 sel"<#else>class="a2"</#if> href="/touch/user/comment/list?statusId=0">未评价订单</a>
      </td>
      <td class="two-border">
        <a <#if statusId?? && statusId==1>class="a2 sel"<#else>class="a2"</#if> href="/touch/user/comment/list?statusId=1">已评价订单</a> 
      </td>     
    </tr>
  </table>
  <#if order_page??>
    <#list order_page.content as order>
        <div class="myorder_list">
            <h2>订单编号&nbsp; <a href="/touch/user/order?id=${order.id?c}"> ${order.orderNumber!''}</a><span><#if order.orderTime??>${order.orderTime[0..8]?default("")}</#if></span></h2>            
            <#if order.orderGoodsList??>
                  <#list order.orderGoodsList as ordergoods>
                        <div class="comment" href="/touch/goods/${ordergoods.goodsId?c}">
                             <span style="float:left;display:inline-block;width:20%;"><img src="${ordergoods.goodsCoverImageUri!''}" width="62" height="62"/></span> 
                             <p class="mb10">${ordergoods.goodsTitle!''}</p>
                             <p>单价：<span class="sc">￥<#if ordergoods.price??>${ordergoods.price?string("0.00")}</#if></span>&nbsp;&nbsp;数量：${ordergoods.quantity!'0'}</p>
                              <#if ordergoods.isCommented?? && ordergoods.isCommented>
                                    <a class="a4" href="/touch/user/comment/edit?goodsId=${ordergoods.id?c}&orderId=${order.id?c}" >查看评价</a>                                    
                              <#else>
                                    <a class="a4" href="/touch/user/comment/edit?goodsId=${ordergoods.id?c}&orderId=${order.id?c}" >评价商品</a>                                    
                              </#if>
                             <div class="clear"></div>
                        </div>         
                  </#list>
            </#if>
        </div>
    </#list>
  </#if>   
  
</div><!--main END-->

<section class="botmain">
  <div class="main">
  <div class="center">
    <a class="absolute-r" href="javascript:$('html,body').animate({scrollTop:0},500);">返回顶部</a>
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user/order/list/0">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div>
</body>
</html>
