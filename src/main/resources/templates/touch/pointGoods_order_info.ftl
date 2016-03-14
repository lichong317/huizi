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
  <h2>订单确认</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<form id="form1" name="form1" action="/touch/pointGoods/order/submit" method="post">
<section class="car_address mb20">
  <input id="input-address-id" type="hidden" name="addressId" value="<#if default_address??>${default_address.id?c}</#if>" datatype="n" nullmsg="请选择收货地址!"/>
  <a href="/touch/user/address/list?pointGoodsId=${goods.id?c}">
     <!--使用默认地址-->
     <#if default_address?? >
         <p class="c6 w100"><span class="absolute-r">${default_address.receiverMobile!''}</span>收货人：${default_address.receiverName!''}</p>
         <p class="c6 lh3 pt10 fs2">收货地址：${default_address.detailAddress!''}</p>
     <#else>
         <p class="c6 lh3 pt10 fs2">添加收货地址</p>
     </#if>
  </a>
</section>


	<a href="/touch/pointGoods/${goods.id?c}" class="prolist mainbox bot-border whitebg">
		  <b class="img"><img src="${goods.coverImageUri!''}" /></b>
		  <section>
		  <p class="h07 oh lh3" style="height:30px">${goods.title!''}</p>
		  <p class="c8 mt10">兑换积分：${goods.pointUse!''}</p>
		  <p class="c8">数量：1</p>
		  </section>
		  <div class="clear"></div>
	</a>


<div class="clear h02"></div>
<#-->
<div class="checkdown whitebg">
  <a class="a1" href="javascript:void(0);" onClick="$(this).next().slideToggle(200);">配送方式<p class="red">大件免邮</p></a>
  <section>
  	<#if >
    <p><input type="radio" />我是选项之类的文字</p>
    <p><input type="radio" />我是选项之类的文字</p>
    <p><input type="radio" />我是选项之类的文字</p>
  </section>
</div>  -->

<div class="checkdown whitebg">
  <a class="a1" href="javascript:void(0);" onClick="$(this).next().slideToggle(200);">选择支付方式<p class="red" id="payTitle">未选择</p></a>
  <section>
  	<#if pay_type_list??>
  		<#list pay_type_list as pay_type>
  			<#if pay_type.title!="货到付款">
  			<p >
  				<input type="radio" name="payTypeId" value="${pay_type.id?c}" datatype="n" onclick="choosePay('${pay_type.title!''}')"/>${pay_type.title!''}
  			</p>
  			</#if>
  		</#list>
  	</#if>
  </section>
</div>
<script>
	function choosePay(title){
		$("#payTitle").text(title);
	}
</script>

<div class="checkdown whitebg">
 
</script>
</div>
<span style="display:none" id="virtualCurrencyfee">0.00</span>
<div class="checkdown whitebg">
  <div class="a1" >是否开具发票
	  <div class="box02">
	  	<input type="radio" id="isNeedInvoice" name="isNeedInvoice" value="1"/>是 
	  	<input type="radio" id="isNeedInvoicenot" checked="checked" name="isNeedInvoice" value="0" />否
	  </div>
  </div> 
</div>

<!-- 运费 -->
<input type="hidden" name="totalPostage" value="${totalPostage!'0'}">
<input type="hidden" name="goodsId" value="${goods.id?c}">

<section class="center mt20 lh4">
  <span class="absolute-l fs3">商品1件</span>
  <p class="ta-r">兑换积分<span class="red ml20"><b >${goods.pointUse!''}</b></span></p>
  <p class="ta-r">运费<span class="red ml20">+ ￥<b id="deliveryFee">${totalPostage!'0'}</b></span></p>
  <p class="ta-r">总计（含运费）<span class="red ml20">= ￥<b id="totalPrice">${totalPostage!'0'}</b></span></p>
</section>


<div class="carfoot_bg clear"></div>
<footer class="carfoot mainbox">
  <p class="pb20 pt20 fs3 lh4">总价<span class="red ml10 mr10">￥<b id="totalPriceBottom">${totalPostage!'0'}</b></span></p>
  <input type="submit" value="确认" class="sub" />
</footer>
 </form>  
</body>
</html>
