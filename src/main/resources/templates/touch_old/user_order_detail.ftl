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

<script>

function cancelConfirm() {
    if (!confirm("未付款可直接取消，是否确认取消订单？")) {
        window.event.returnValue = false;
    }
}

</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>订单详情</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<#if order??>
<section class="whitebg">
  <menu class="myorder_info mainbox"> 
    <p><span class="c7">订单日期：</span>${order.orderTime!''}</p>
    <p><span class="c7">订单总价：</span><#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></p>    
    <p><span class="c7">订单编号：</span>${order.orderNumber!''}<span class="fc">
        <#if order.statusId == 1>（待确认）
        <#elseif order.statusId == 2>（待付款）
        <#elseif order.statusId == 3>（待发货）
        <#elseif order.statusId == 4>（待收货）
        <#elseif order.statusId == 5>（待评价）
        <#elseif order.statusId == 6>（已完成）
        <#elseif order.statusId == 7>（已取消）
        </#if>
    </span>
    </p>
    <p><span class="c7">支付方式：</span>${order.payTypeTitle!''}<span class="red">
        <#if order.statusId == 1 || order.statusId == 2 >（未支付）
        </#if>
    </span></p>
    <p><span class="c7">配送方式：</span>${order.deliverTypeTitle!''}</p>
  </menu>
</section>

<div class="clearh"></div>
<section class="whitebg" style="margin-top:1px;">
  <menu class="myorder_info mainbox">
    <p><span class="c7">收货人：</span>${order.shippingName!''}</p>
    <p><span class="c7">手机号码：</span>${order.shippingPhone!''}</p>
    <p><span class="c7">地址：</span>${order.shippingAddress!''}</p>
    <p><span class="c7">发票抬头：</span><#if order.isNeedInvoice>${order.invoiceTitle!''}</#if></p>
  </menu>
</section>
<div class="main">
<div class="myorder_list">
    <#if order.orderGoodsList??>
        <#list order.orderGoodsList as item>
            <a class="a1" href="/touch/goods/${item.goodsId?c}">
              <span class="sp1"><img src="${item.goodsCoverImageUri!''}" /></span>
              <p class="mb10">${item.goodsTitle!''}</p>
              <p>单价：<span class="sc">￥<#if item.price??>${item.price?string("0.00")}</#if></span>&nbsp;&nbsp;数量：${item.quantity!''}</p>
              <div class="clear"></div>
            </a>
        </#list>
    </#if>   
    <div class="clear"></div>
  </div>
</div>

<section class="whitebg" style="margin-top:1px;">
  <menu class="myorder_info mainbox">
    <p><span class="c7">商品总金额：</span><#if order.totalGoodsPrice??>${order.totalGoodsPrice?string("0.00")}</#if></p>
    <p><span class="c7">邮费：</span><#if order.deliverTypeFee??>${order.deliverTypeFee?string("0.00")}</#if></p>
    <#if order.virtualCurrencyUse?? && order.virtualCurrencyUse gt 0>
        <p><span class="c7">虚拟货币抵用：</span><#if order.virtualCurrencyUse??>${order.virtualCurrencyUse?string("0.00")}</#if></p>
    </#if>
    <#if order.pointUse?? && order.pointUse gt 0>
        <p><span class="c7">积分抵用：</span><#if order.pointUse??>${order.pointUse?string("0.00")}</#if></p>
    </#if>
    <#if order.couponUse?? && order.couponUse gt 0>
        <p><span class="c7">优惠券抵用：</span><#if order.couponUse??>${order.couponUse?string("0.00")}</#if></p>
    </#if>
    <#--><p><span class="c7">服务费：</span>云南省昆明市西山区</p> 
    <p><span class="c7">优惠：</span>￥${order.totalPrice - order.totalGoodsPrice - order.deliverTypeFee!0}</p>-->
    <p class="mt10"><span class="c9">应付总额：</span><span class="red fs11">￥<#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></span></p>
  </menu>
</section>
<!--main END-->

<#if !app??>
<section class="botmain">
  <div class="main">
  <div class="center">
    <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout" onclick="logout()">退出</a>
    <#else>
        <a href="/touch/login">登录</a>
        <span>|</span>
        <a href="/touch/reg">注册</a>
    </#if>
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
</#if>
<footer class="buyfoot">
  <div class="mainbox">
    <#if order.statusId==2>
        <#if order.payTypeTitle == "微信支付">
               <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb309b01e273cd1cf&redirect_uri=http://www.huizhidian.com/touch/order/dopay&response_type=code&scope=snsapi_base&state=${order.id?c}#wechat_redirect" class="fl">去付款</a>
        <#else>
               <a href="/order/dopay/${order.id?c}" class="fl">去付款</a>
        </#if>
    </#if>
    <#if order.statusId==2 || order.statusId==1>
        <a class="fr" href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()">取消订单</a>
    </#if>
    <div class="clear"></div>
  </div>
</#if>
</body>
</html>
