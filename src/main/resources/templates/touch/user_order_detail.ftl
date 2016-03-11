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

function cancelConfirm() {
    if (!confirm("未付款可直接取消，是否确认取消订单？")) {
        window.event.returnValue = false;
    }
}
</script>
</head>

<body class="eeebg">
<header class="comhead">
  <h2>订单详情</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<section class="whitebg mainbox pt20 pb20 c8 lh4 bot-border">
  <p>订单日期：<span class="c3"><#if order.orderTime??>${order.orderTime?string("yyyy-MM-dd")}</#if></span></p>
  <p>订单总价：<span class="red">￥<#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></span></p>
  <p>订单编号：<span class="c3">${order.orderNumber!''}</span></p>
  <p>支付方式：<span class="c3">${order.payTypeTitle!''}</span></p>
  <p>配送方式：<span class="c3">${order.deliverTypeTitle!''}</span></p>
</section>
<section class="whitebg mainbox pt20 pb20 c8 lh4 bot-border">
  <p>收货人：<span class="c3">${order.shippingName!''}</span></p>
  <p>手机号码：<span class="c3">${order.shippingPhone!''}</span></p>
  <p>收货地址：<span class="c3">${order.shippingAddress!''}</span></p>
</section>
<div class="clear h02"></div>

<#if order.orderGoodsList??>
    <#list order.orderGoodsList as item>
    <div class="prolist mainbox bot-border whitebg">
    	<a href="/touch/goods/${item.goodsId?c}" class="img">
		  <b ><img src="${item.goodsCoverImageUri!''}" /></b> </a>
		  <section>
		  <p class="h07 oh lh3" style="height:30px">${item.goodsTitle!''}</p>
		  <p class="c8 mt10">单价：￥<#if item.price??>${item.price?string("0.00")}</#if></p>
		  <p class="c8">数量：${item.quantity!''}</p>
		  </section>
		  <div class="clear"></div>
		  <#if order.statusId==6>
		  	<a class="sh redborbtn bor-rad" href="/touch/user/return/list?keywords=${order.orderNumber!''}">申请售后</a>
		  </#if>
	</div>	
    </#list>
</#if>

<div class="clear h02"></div>

<section class="center lh4">
  <p><span class="inblock w30 ta-r">商品价格</span><span class="red ml20">+ ￥<#if order.totalGoodsPrice??>${order.totalGoodsPrice?string("0.00")}</#if></span></p>
  <p><span class="inblock w30 ta-r">运费</span><span class="red ml20">+ ￥<#if order.deliverTypeFee??>${order.deliverTypeFee?string("0.00")}</#if></span></p>
  <#if order.virtualCurrencyUse?? && order.virtualCurrencyUse gt 0>
  	 <p><span class="inblock w30 ta-r">虚拟货币抵用</span><span class="red ml20">- ￥<#if order.virtualCurrencyUse??>${order.virtualCurrencyUse?string("0.00")}</#if></span></p>
  </#if>
  <#if order.couponUse?? && order.couponUse gt 0>
  	 <p><span class="inblock w30 ta-r">优惠券抵用</span><span class="red ml20">- ￥<#if order.couponUse??>${order.couponUse?string("0.00")}</#if></span></p>
  </#if>
  <p class="mt10"><span class="inblock w30 ta-r fs3">应付总额</span> ：<span class="red ml10 fs3">￥<#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></span></p>
</section>


<div class="carfoot_bg clear"></div>
<footer class="carfoot mainbox ta-r pt20 pb20">
	<#if order.statusId==2 || order.statusId==1>
		<input class="sub sub01" type="submit" value="取消订单" onClick="cancelConfirm(); window.location.href='/touch/user/cancel/direct?id=${order.id?c}'" />
	</#if>
  	<#if order.statusId==2>
        <#if order.payTypeTitle == "微信支付">             
               <input class="sub  sub01 sub02" type="submit" value="去付款" onclick="window.location.href='https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb309b01e273cd1cf&redirect_uri=http://www.huizhidian.com/touch/order/dopay&response_type=code&scope=snsapi_base&state=${order.id?c}#wechat_redirect'"/>
        <#else>        
               <input class="sub  sub01 sub02" type="submit" value="去付款" onclick="window.location.href='/order/dopay/${order.id?c}'"/>
        </#if>
    </#if>
    <#if order.statusId==6>
    	<a class="finishbtn"><span class="red">订单完成</span></a>
    </#if>
</footer>
  
</body>
</html>
