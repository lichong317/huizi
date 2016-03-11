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

<body >

<header class="comhead">
  <h2>申请退换货</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="main">
  <div class="clear15"></div>
  
  <#if return_page??>
    <#list return_page.content as order>
         <section class="mainbox bot-border lh5 whitebg">
              <p class="w100 c8">
                <span class="absolute-r"><#if order.orderTime??>${order.orderTime?string("yyyy-MM-dd")}</#if></span>
                订单编号：${order.orderNumber!''}
              </p>
            </section>
            <#if order.orderGoodsList??>
                 <#list order.orderGoodsList as ordergoods>
                      <a href="/touch/goods/${ordergoods.goodsId?c}" class="prolist mainbox bot-border whitebg">
                          <b class="img"><img src="${ordergoods.goodsCoverImageUri!''}" /></b>
  
                          <section>
                          <p class="h07 oh">${ordergoods.goodsTitle!''}</p>
                          <p class="mt20 c9" style="width:170px;">单价：￥<#if ordergoods.price??>${ordergoods.price?string("0.00")}</#if>&nbsp;&nbsp;&nbsp;&nbsp;数量：${ordergoods.quantity!'0'}</p>
                          </section>
                          
                          <div class="clear"></div>
                      </a>
                      <section class="mainbox whitebg lh5 h05 pt10 pb10">
                      <p class="w100 ta-r">
                      <#if ordergoods.isReturnApplied?? && ordergoods.isReturnApplied>
                                    <a class="inblock pr10 pl10 redbg white ml10 bor-rad" href="/touch/user/return/${order.id?c}?id=${ordergoods.id?c}" >查看</a>                                    
                          <#else>
                                    <a class="inblock pr10 pl10 redbg white ml10 bor-rad" href="/touch/user/return/${order.id?c}?id=${ordergoods.id?c}" >申请</a>                                    
                          </#if>
                      </p>
                      </section>
                 </#list>
            </#if>           
           
    </#list>
  </#if>   
 
</div><!--main END-->

</body>
</html>
