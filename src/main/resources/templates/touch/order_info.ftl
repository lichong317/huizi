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
	//检查是否支持货到付款
    checkCod()
    
    $("#virtualCurrency").change(function(){

        var virtualCurrency  = parseFloat($.trim($(this).val()));
        if (isNaN(virtualCurrency) || virtualCurrency=="") { virtualCurrency = 0 }
        
        <#if user?? &&  user.roleId??>
            <#if user.roleId == 1 >
                <#if user.totalCashRewards??>
                    <#assign virtual_limit = user.totalCashRewards />
                <#else>
                    <#assign virtual_limit = 0 />
                </#if>
            <#elseif user.roleId == 2>
                <#if user.virtualCurrency??>
                    <#assign virtual_limit = user.virtualCurrency />
                <#else>
                    <#assign virtual_limit = 0 />
                </#if>
            <#else>
                 <#assign virtual_limit = 0 />
            </#if>
        </#if>
        
        var deliPrice =  parseFloat($("#deliveryFee").html());
        var couponFee =  parseFloat($("#couponFeee").html()); 
        var currentPrice = parseFloat($("#currentPrice").html());        
        
        if(virtualCurrency > ${virtual_limit?c}){
            alert("账户余额不足！");
            $(this).val(0);
            $("#virtualCurrencyfee").html(0);
            if(couponFee > currentPrice + deliPrice){
                $("#totalPrice").html(0);
                $("#totalPriceBottom").html(0);
            }else{
                $("#totalPrice").html(currentPrice + deliPrice - couponFee);
                $("#totalPriceBottom").html(currentPrice + deliPrice - couponFee);
            }
        }
        else{
                       
            $("#virtualCurrencyfee").html(virtualCurrency);
            
            if(currentPrice + deliPrice >  couponFee + virtualCurrency){
                $("#totalPrice").html(currentPrice + deliPrice - couponFee - virtualCurrency);
                $("#totalPriceBottom").html(currentPrice + deliPrice - couponFee - virtualCurrency);
            }
            else{
                $("#totalPrice").html(0);
                $("#totalPriceBottom").html(0);
            }
        }        
        
    });
});

function couponChange(price)
{
    var couponFee = parseFloat(price);
    
    if (undefined == couponFee)
    {
        couponFee = 0;
    }
    
    var currentPrice = parseFloat($("#currentPrice").html());
    //var payTypeFee = parseFloat($("#payTypeFee").html());
    //var pointFee = parseFloat($("#idPointUse").val());
    var deliPrice =  parseFloat($("#deliveryFee").html());
    var virtualCurrency = parseFloat($("#virtualCurrencyfee").html());

    $("#couponFeee").html(couponFee);
    $("#couponFee").html(couponFee);
    if( couponFee + virtualCurrency> currentPrice + deliPrice){
        $("#totalPrice").html(0);
        $("#totalPriceBottom").html(0);
    }
    else{
        $("#totalPrice").html(currentPrice + deliPrice - couponFee - virtualCurrency);
        $("#totalPriceBottom").html(currentPrice + deliPrice - couponFee - virtualCurrency);
    }
    
}

function checkCod(){
	var addressId = $("#input-address-id").val();
        $.ajax({
            type: "post",
            url: "/order/codDistrict",
            data: { "addressId": addressId},
            dataType: "json",
            success: function (data) {
                    if (data.code == 0) {
                         //$("#notcodaddress1").css("display", "none");
                         $("#idPayFaceToFace").css("display", "block");
                    } else {
                        // $("#notcodaddress1").css("display", "block");
                         $("#idPayFaceToFace").css("display", "none");
                    }
             }
        });
}
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
<form id="form1" name="form1" action="/touch/order/submit" method="post">
<section class="car_address mb20">
  <input id="input-address-id" type="hidden" name="addressId" value="<#if default_address??>${default_address.id?c}</#if>" datatype="n" nullmsg="请选择收货地址!"/>
  <a href="/touch/user/address/list">
     <!--使用默认地址-->
     <#if default_address?? >
         <p class="c6 w100"><span class="absolute-r">${default_address.receiverMobile!''}</span>收货人：${default_address.receiverName!''}</p>
         <p class="c6 lh3 pt10 fs2">收货地址：${default_address.detailAddress!''}</p>
     <#else>
         <p class="c6 lh3 pt10 fs2">添加收货地址</p>
     </#if>
  </a>
</section>

<#if selected_goods_list??>
	<#list selected_goods_list as item>
		<a href="/touch/goods/${item.goodsId?c}" class="prolist mainbox bot-border whitebg">
		  <b class="img"><img src="${item.goodsCoverImageUri!''}" /></b>
		  <section>
		  <p class="h07 oh lh3" style="height:30px">${item.goodsTitle!''}</p>
		  <p class="c8 mt10">单价：￥<#if item.price??>${item.price?string("0.00")}</#if></p>
		  <p class="c8">数量：${item.quantity!''}</p>
		  </section>
		  <div class="clear"></div>
		</a>
	</#list>
</#if>

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
  			<p <#if pay_type.title="货到付款">id="idPayFaceToFace"</#if>>
  				<input type="radio" name="payTypeId" value="${pay_type.id?c}" datatype="n" onclick="choosePay('${pay_type.title!''}')"/>${pay_type.title!''}
  			</p>
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
  <a class="a1" href="javascript:void(0);" onClick="$(this).next().slideToggle(200);">使用优惠券<p class="red" id="couponTitle">未选择</p></a>
  <section>
  	  <#if coupon_list??>
  	  	   <#list coupon_list as item>
  	  	   		<p><input type="radio" name="couponId" value="${item.id?c}" onclick="chooseCoupon('${item.typeTitle!''}');couponChange(${item.price!''});"/>${item.typeTitle!''}</p>
  	  	   </#list>
  	  </#if>
  </section>
<script>
	function chooseCoupon(title){
		$("#couponTitle").text(title);
	}
</script>
</div>
<#if user?? &&user.roleId?? && user.roleId == 2>
	<div class="checkdown whitebg">
	  <div class="a1" >使用虚拟币<div class="box01">可用余额<br/>￥${user.virtualCurrency!''}元</div><input type="text" class="text text01" value="" id="virtualCurrency" name="virtualCurrency"/></div> 
	</div>
</#if>

<#if user?? &&user.roleId?? && user.roleId == 1>
	<div class="checkdown whitebg">
	  <div class="a1" >使用返现金额<div class="box01">可用余额<br/>￥${user.totalCashRewards!''}元</div><input type="text" class="text text01" value="" id="virtualCurrency" name="virtualCurrency"/></div> 
	</div>
</#if>
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

<section class="center mt20 lh4">
  <span class="absolute-l fs3">商品${totalQuantity!'0'}件</span>
  <p class="ta-r">商品价格<span class="red ml20">+ ￥<b id="currentPrice">${totalPrice?string("0.00")}</b></span></p>
  <p class="ta-r">运费<span class="red ml20">+ ￥<b id="deliveryFee">${totalPostage!'0'}</b></span></p>
  <p class="ta-r">优惠券抵扣<span class="red ml20">- ￥<b id="couponFeee">0</b></span></p>
  <p class="ta-r">总计（含运费）<span class="red ml20">= ￥<b id="totalPrice">${(totalPrice+totalPostage)?string("0.00")}</b></span></p>
</section>


<div class="carfoot_bg clear"></div>
<footer class="carfoot mainbox">
  <p class="pb20 pt20 fs3 lh4">总价<span class="red ml10 mr10">￥<b id="totalPriceBottom">${(totalPrice+totalPostage)?string("0.00")}</b></span></p>
  <input type="submit" value="确认" class="sub" />
</footer>
 </form>  
</body>
</html>
