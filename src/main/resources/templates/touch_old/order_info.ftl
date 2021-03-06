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
<script src="/touch/js/jquery.cityselect.js"></script>
<script src="/touch/js/order_info.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/touch/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
        
    //初始化表单验证
    //$("#form1").initValidform();
    
    $("#form1").Validform({
        btnSubmit:"#btn_sub",
        tiptype:1
    });

    $("#address").citySelect({
        nodata:"none",
        prov: "云南",
        city: "昆明",
        <#if address?? && address.disctrict??>dist: "${address.disctrict!''}",</#if>
        required:false
    }); 
    
    $("#idPointUse").change(function(){
        var point = parseFloat($.trim($(this).val()));
        if (isNaN(point) || point=="") { point = 0 }
        
        var price = $.trim($("#idTotalPriceSteady").val());
        if (isNaN(price) || price=="") { price = 0 }
        
        <#if total_point_limit?? && user.totalPoints?? && total_point_limit gt user.totalPoints>
        <#assign point_limit=user.totalPoints />
        <#else>
        <#assign point_limit=total_point_limit />
        </#if>
        
        var deliPrice =  parseFloat($("#deliveryFee").html());
        var couponFee =  parseFloat($("#couponFeee").html()); 
        var currentPrice = parseFloat($("#currentPrice").html());
        var virtualCurrency = parseFloat($("#virtualCurrencyfee").html());
        if (parseInt(point) > ${point_limit!'0'})
        {
            alert("最多可使用(${point_limit!'0'})个积分");
            
            $(this).val(0);
            if(couponFee + virtualCurrency> currentPrice + deliPrice){
                $("#totalPrice").html(0);
            }else{
                $("#totalPrice").html(currentPrice + deliPrice - couponFee - virtualCurrency);
            }
        }
        else
        {
            //var totalPrice = parseFloat(price);
            var pointPrice = parseFloat(point);
            
            if (currentPrice + deliPrice > pointPrice + couponFee + virtualCurrency)
            {
                $("#totalPrice").html(currentPrice + deliPrice - pointPrice - couponFee - virtualCurrency);
            }
            else
            {
                $("#totalPrice").html(0);
            }
        }
    }); 
    
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
        
        var pointFee = parseFloat($("#idPointUse").val());
        
        if(virtualCurrency > ${virtual_limit?c}){
            alert("账户余额不足！");
            $(this).val(0);
            $("#virtualCurrencyfee").html(0);
            if(couponFee + pointFee> currentPrice + deliPrice){
                $("#totalPrice").html(0);
            }else{
                $("#totalPrice").html(currentPrice + deliPrice - couponFee - pointFee);
            }
        }
        else{
                       
            $("#virtualCurrencyfee").html(virtualCurrency);
            
            if(currentPrice + deliPrice > pointFee + couponFee + virtualCurrency){
                $("#totalPrice").html(currentPrice + deliPrice - pointFee - couponFee - virtualCurrency);
            }
            else{
                $("#totalPrice").html(0);
            }
        }        
        
    });
});

function couponChange()
{
    var couponFee = parseFloat($("#couponSelect option:selected").attr("fee"));
    
    if (undefined == couponFee)
    {
        couponFee = 0;
    }
    
    var currentPrice = parseFloat($("#currentPrice").html());
    //var payTypeFee = parseFloat($("#payTypeFee").html());
    var pointFee = parseFloat($("#idPointUse").val());
    var deliPrice =  parseFloat($("#deliveryFee").html());
    var virtualCurrency = parseFloat($("#virtualCurrencyfee").html());

    $("#couponFeee").html(couponFee);
    $("#couponFee").html(couponFee);
    if(pointFee + couponFee + virtualCurrency> currentPrice + deliPrice){
        $("#totalPrice").html(0);
    }
    else{
        $("#totalPrice").html(currentPrice + deliPrice - pointFee - couponFee - virtualCurrency);
    }
    
}

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
              <div>
                <a href="javascript:;" class="selAddress" aid="${address.id?c}">
                <p>姓名：${address.receiverName!''}<span>邮编：${address.postcode!''}</span></p>
                <p>手机号码：${address.receiverMobile!''}</p>
                <p>备用号码：${address.receiverTelephone!''}</p>
                <p>省市：<span id="addressprovince">${address.province!''}</span>
                       <span id="addresscity">${address.city!''}</span>
                       <span id="addressdisctrict">${address.disctrict!''}</span></p>
                <p>详细地址：${address.detailAddress!''}</p>
                </a>
              </div> 
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
          <select id="dist" name="disctrict" class="dist" style="width:100%;" onchange="javascript:checkaddress()"></select>
          <span id = "notcodaddress" style="display: none ;color:red">不支持货到付款</span>
                      <script>
                         function checkaddress(){
                             var province = $("#prov").val();
                             var city = $("#city").val();
                             var disctrict = $("#dist").val(); 
                             
                             $.ajax({
                                      type: "post",
                                      url: "/order/codDistrict",
                                      data: { "province": province, "city": city, "disctrict": disctrict},
                                      dataType: "json",
                                      success: function (data) {
                                              if (data.code == 0) {
                                                   $("#notcodaddress").css("display", "none");       
                                              } else {
                                                   $("#notcodaddress").css("display", "block");
                                              }
                                       }
                             });
                         }
                      </script>
          <textarea id="detailAdd" ></textarea>
      </div>
        
      <input id="addAddressSubmit" type="button" class="greenbtn fs11" style="width:90%; font-family:'微软雅黑';" value="确认添加" />
  </div>
  
  <p class="address">选择优惠券：</p>
  <div class="address">
    <select style="width:100%;" id="couponSelect" name="couponId"  onchange="couponChange();">
        <#if coupon_list??>
             <option value="" fee="0">不使用优惠券</option>
             <#list coupon_list as item>
                    <option value="${item.id?c}" fee="${item.price!''}">${item.typeTitle!''}</option>
             </#list>
        </#if>
    </select>
  </div>
  <p class="address">发票信息：</p>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <span>是否开具发票：</span>
  <input type="radio" id="isNeedInvoice" name="isNeedInvoice" value="1" datatype="n" nullmsg="请选择是否开具发票!"><span>是</span>&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="radio" id="isNeedInvoicenot" checked="checked" name="isNeedInvoice" value="0" datatype="n" nullmsg="请选择是否开具发票!"><span>否</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                            
  <input type="text" id="invoiceTitle" style="display:none" name="invoiceTitle"  class="address" value="" placeholder="发票抬头"/>
<script>
     $(document).ready(function(){
            $("#isNeedInvoice").change(function(){
                var ischecked = $(this).val();
                $("#invoiceTitle").css("display", "block");
                
            });
            
            $("#isNeedInvoicenot").change(function(){
                var ischecked = $(this).val();
                $("#invoiceTitle").css("display", "none");
                
            });
     });
</script>  
  
  
  <p class="address">选择支付方式：  <span id = "notcodaddress1" style="display: none;margin-left:10px;color:#ef0000;">不支持货到付款</span></p>
  <ul class="paystyle">
    <#if pay_type_list??>
        <#list pay_type_list as pay_type>
            <#if app?? && pay_type.title="微信支付">
            <#else>
                <li <#if pay_type.title="货到付款">id="idPayFaceToFace"</#if>>
                    <input  tn="${pay_type.title!''}" type="radio" <#if pay_type.title="支付宝支付">checked="checked"</#if> name="payTypeId" datatype="n"  value="${pay_type.id?c}" nullmsg="请选择支付方式!" />
                    <#--<span><img src="${pay_type.coverImageUri!''}" height="30" /></span> -->
                    <span>${pay_type.title!''}</span>
                </li>
            </#if>
        </#list>
        <script>
                                    function changepaytype(paytype){
                                        //alert(paytype.getAttribute("tn"));
                                       if(paytype.getAttribute("tn") == "货到付款"){                                      
                                           
                                           var addressId = $("#input-address-id").val();
                                           
                                           var $browsers = $("input[name=payTypeId]");
                                           if('' != addressId){
                                               $.ajax({
                                                    type: "post",
                                                    url: "/order/codDistrict",
                                                    data: {"addressId": addressId},
                                                    dataType: "json",
                                                    success: function (data) {
                                                        if (data.code == 0) {
                                                           
                                                        } else {
                                                            $browsers.attr("checked",false); 
                                                            alert(data.msg);
                                                        }
                                                    }
                                                });
                                           }else{
                                               alert("请选择收货地址！");
                                               $browsers.attr("checked",false);
                                           }
                                       }
                                    }
                                </script>
    </#if>
  </ul>
  
 <#-- <p class="address">选择配送方式：</p>
  <ul class="paystyle">
    <#if delivery_type_list??>
        <#list delivery_type_list as item>
            <li><input type="radio" name="deliveryTypeId" datatype="n" value="${item.id?c}" nullmsg="请选择支付方式!" />${item.title!''}</li>
        </#list>
    </#if>
  </ul> -->
<#-->  <p class="address">选择配送方式：</p>
  <div class="address">
    <select style="width:100%;" id="deliveryTypeSelect" name="deliveryTypeId" datatype="n" nullmsg="请选择配送方式">
           <option value="" price="0">请选择</option>
           <#if delivery_type_list??>
                 <#list delivery_type_list as delivery_type>
                         <option value="${delivery_type.id?c!''}" price="${delivery_type.fee?string("#.##")}">${delivery_type.title!''}</option>
                 </#list>
           </#if>
    </select>
  </div> -->
  
  <#if user?? &&user.roleId?? && user.roleId == 2>
      <p class="address">使用虚拟币：</p>
      <input type="text" class="address" id="virtualCurrency" name="virtualCurrency" value="" >
      &nbsp;&nbsp;&nbsp;&nbsp;
      <span class="orange">可用余额：￥<b id="">${user.virtualCurrency!''}</b>元</span>
  </#if>
  <span style="display:none" id="virtualCurrencyfee">0.00</span>
  
  
  <div class="clear"></div>
  <p class="address">留言：</p>
  <input type="text" name="userRemarkInfo" class="address" value="" />
  <#--><p class="address ta-r">共${totalQuantity!'0'}件商品，合计<span class="red">￥${totalPrice?string("0.00")}</span></p> -->
</div><!--main END-->
<div class="clear70"></div>
<footer class="orderfoot" style="z-index:56">
<div class="main" style="background:#35424e;">
<section class="car_price" >
    
    <input type="hidden" name="totalPostage" value="${totalPostage!'0'}">
    
    <#--><h3>合计：<span class="sc">￥${totalPrice?string("0.00")}</span>（共<span>${totalQuantity!'0'}</span>件商品）</h3>-->
    <h3 style="font-size:0.75em; float:left;width:100%;font-weight:400;">共${totalQuantity!'0'}件商品，
              商品价格（<span>¥<b id="currentPrice">${totalPrice?string("0.00")}</b></span>)
    + 运费（<span>¥<b id="deliveryFee">${totalPostage!'0'}</b></span><#if totalPostagefeenot??>&nbsp;免邮￥（${totalPostagefeenot}）</#if>）
    - 优惠券抵扣（<span>¥<b id="couponFeee">0</b></span>）
    - 积分抵扣（<span>¥<input id="idPointUse" name="pointUse" style="width:30px; text-align:center;" value="0"/></span>）    
    = 总计(含运费)： <span>¥<b id="totalPrice">${(totalPrice+totalPostage)?string("0.00")}</b></span>
    </h3>
    <a id="btn_sub" href="javascript:;">提交订单（${totalQuantity!'0'}）</a> 
    <#--<input type="submit" value="提交订单" class="input_zy"></input>-->
    <div class="clear"></div>
  </section>
  </div>
  </footer>
 </form>
 <div style="height:130px;display:block; z-index:55" ></div>
</body>
</html>
