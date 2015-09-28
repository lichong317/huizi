<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script src="/touch/js/jquery.cityselect.js"></script>
<script src="/touch/js/order_info.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
        
    //初始化表单验证
    //$("#form1").initValidform();
    
    $("#form1").Validform({
        btnSubmit:"#btn_sub",
        tiptype:4
    });

    $("#address").citySelect({
        nodata:"none",
        <#if address?? && address.province??>prov: "${address.province!''}",</#if>
        <#if address?? && address.city??>city: "${address.city!''}",</#if>
        <#if address?? && address.disctrict??>dist: "${address.disctrict!''}",</#if>
        required:false
    }); 
    
    $("#idPointUse").change(function(){
        var point = $.trim($(this).val());
        if (isNaN(point) || point=="") { point = 0 }
        
        var price = $.trim($("#idTotalPriceSteady").val());
        if (isNaN(price) || price=="") { price = 0 }
        
        <#if total_point_limit?? && user.totalPoints?? && total_point_limit gt user.totalPoints>
        <#assign point_limit=user.totalPoints />
        <#else>
        <#assign point_limit=total_point_limit />
        </#if>
        
        if (parseInt(point) > ${point_limit!'0'})
        {
            alert("最多可使用(${point_limit!'0'})个积分");
            $(this).val(0);
            $("#totalPrice").html(price);
        }
        else
        {
            var totalPrice = parseFloat(price);
            var pointPrice = parseFloat(point);
            
            if (totalPrice > pointPrice)
            {
                $("#totalPrice").html(totalPrice-pointPrice);
            }
            else
            {
                $("#totalPrice").html(0);
            }
        }
    }); 
});

function formsubmit(){
  var myform=document.getElementById("form1");
  myform.submit();
}
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>购物车</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/menu.png" height="22" /></a>
  </div>
</header>

<form id="form1" name="form1" action="/touch/order/submit" method="post">
<div class="mainbox">
  <p class="address">收货地址：<span class="fr" ><a id="addAddress" style="border:none !important;"href="javascript:;">新增收货地址</a></span></p>
   <section class="address_list">
   <input id="input-address-id" type="hidden" name="addressId" value="" datatype="n" nullmsg="请选择收货地址!"/>
       <#if user.shippingAddressList?? && user.shippingAddressList?size gt 0>
            <#list user.shippingAddressList as address>
                <a href="javascript:;" class="selAddress" aid="${address.id?c}">
                <p>姓名：${address.receiverName!''}<span>邮编：${address.postcode!''}</span></p>
                <p>手机号码：${address.receiverMobile!''}</p>
                <p>省市：${address.province!''}${address.city!''}${address.disctrict!''}</p>
                <p>详细地址：${address.detailAddress!''}</p>
                </a> 
            </#list>
       </#if>        
   </section>
  
  <div id="addressForm" class="hide">
      <p  class="address">收货人姓名</p>
      <input id="receiverName" type="text" class="address" value="" />
      <p class="address">收货人电话</p>
      <input id="mobile" type="text" class="address" value="" />
      <p class="address">邮编</p>
      <input id="postcode" type="text" class="address" value="" />
      <p class="address">收货地址</p>
      <div id="address" class="address">                    
          <select id="prov" name="province" class="prov fl"></select>
          <select id="city" name="city" class="city fr"></select>
          <div class="clear"></div>
          <select id="dist" name="disctrict" class="dist" style="width:100%;"></select>
          <textarea id="detailAdd" ></textarea>
      </div>
        
      <input id="addAddressSubmit" type="button" class="greenbtn fs11" style="width:90%; font-family:'微软雅黑';" value="确认添加" />
  </div>
  
  <p class="address">选择优惠券：</p>
  <div class="address">
    <select style="width:100%;"><option>无可用优惠券</option></select>
  </div>
  <p class="address">发票信息：</p>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <span>是否开具发票：</span>
  <input type="radio" name="isNeedInvoice" value="1" datatype="n" nullmsg="请选择是否开具发票!"><span>是</span>&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="radio" checked="checked" name="isNeedInvoice" value="0" datatype="n" nullmsg="请选择是否开具发票!"><span>否</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
  <input type="text" name="invoiceTitle"  class="address" value="" placeholder="发票抬头"/>
  
  <p class="address">选择支付方式：</p>
  <ul class="paystyle">
    <#if pay_type_list??>
        <#list pay_type_list as pay_type>
            <li><input type="radio" name="payTypeId" datatype="n" value="${pay_type.id?c}" nullmsg="请选择支付方式!" /><span><img src="${pay_type.coverImageUri!''}" height="30" /></span></li>
        </#list>
    </#if>
  </ul>
  
  <p class="address">选择配送方式：</p>
  <ul class="paystyle">
    <#if delivery_type_list??>
        <#list delivery_type_list as item>
            <li><input type="radio" name="deliveryTypeId" datatype="n" value="${item.id?c}" nullmsg="请选择支付方式!" />${item.title!''}</li>
        </#list>
    </#if>
  </ul>
  
  <div class="clear"></div>
  <p class="address">留言：</p>
  <input type="text" name="userRemarkInfo" class="address" value="" />
  <p class="address ta-r">共${totalQuantity!'0'}件商品，合计<span class="red">￥${totalPrice?string("0.00")}</span></p>
</div><!--main END-->
<div class="clear70"></div>
<footer class="mainfoot">
<div class="main" style="background:#35424e;">
<section class="car_price">
    <h3>合计：<span class="sc">￥${totalPrice?string("0.00")}</span>（共<span>${totalQuantity!'0'}</span>件商品）</h3>
  
    <a id="btn_sub" href="javascript:;">提交订单（${totalQuantity!'0'}）</a> 
    <div class="clear"></div>
  </section>
  </div>
  </footer>
 </form>
</body>
</html>
