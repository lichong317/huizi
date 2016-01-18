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
<script src="/client/js/Validform_v5.3.2_min.js"></script>

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
        tiptype:4
    });

    $("#address").citySelect({
        nodata:"none",
        prov: "云南",
        city: "昆明",
        <#if address?? && address.disctrict??>dist: "${address.disctrict!''}",</#if>
        required:false
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

<form id="form1" name="form1" action="/touch/order/buysubmit" method="post">
<input name="shareId" type="hidden" value="${shareId!''}">
<div class="mainbox">
  <p class="address">收货地址：<span class="fr" ><a id="addAddress" style="border:none !important;"href="javascript:;">新增收货地址</a></span></p>
  <section class="address_list">
   <input id="input-address-id" type="hidden" name="addressId" value="" datatype="n" nullmsg="请选择收货地址!"/>
       <#if user.shippingAddressList?? && user.shippingAddressList?size gt 0>
            <#list user.shippingAddressList as address>
                <a href="javascript:;" class="selAddress" aid="${address.id?c}">
                <p>姓名：${address.receiverName!''}<span>邮编：${address.postcode!''}</span></p>
                <p>手机号码：${address.receiverMobile!''}</p>
                <p>省市：<span id="addressprovince">${address.province!''}</span>
                       <span id="addresscity">${address.city!''}</span>
                       <span id="addressdisctrict">${address.disctrict!''}</span></p>
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
          <select id="prov" class="prov fl"></select>
          <select id="city" class="city fr"></select>
          <div class="clear"></div>
          <select id="dist" class="dist" style="width:100%;" onchange="javascript:checkaddress()"></select>
          <lable id = "notcodaddress" style="display: none ">不支持货到付款</lable>
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
  
  <p class="address">选择支付方式：</p>
  <ul class="paystyle">
    <#if pay_type_list??>
        <#list pay_type_list as pay_type>
             <li <#if pay_type.title="货到付款">id="idPayFaceToFace"</#if>><input onclick="changepaytype(this)" tn="${pay_type.title!''}" type="radio" name="payTypeId" datatype="*" value="${pay_type.id?c}" nullmsg="请选择支付方式!" />
            <#--<span><img src="${pay_type.coverImageUri!''}" height="30" /></span> -->
            <span>${pay_type.title!''}</span>
            </li>
        </#list>
        <script>
                                    function changepaytype(paytype){
                                        //alert(paytype.getAttribute("tn"));
                                       if(paytype.getAttribute("tn") == "货到付款"){                                      
                                           var province = $("#addressprovince").text();
                                           var city = $("#addresscity").text();
                                           var disctrict = $("#addressdisctrict").text();

                                           if('' != province){
                                               $.ajax({
                                                    type: "post",
                                                    url: "/order/codDistrict",
                                                    data: { "province": province, "city": city, "disctrict": disctrict},
                                                    dataType: "json",
                                                    success: function (data) {
                                                        if (data.code == 0) {
                                                          
                                                        } else {
                                                            //alert(data.msg);
                                                            ct.alert({
                                                                    text: data.msg,
                                                                    type: "alert"
                                                            });
                                                        }
                                                    }
                                                });
                                           }else{
                                               //alert("请选择收货地址！");
                                               ct.alert({
                                                      text: "请选择收货地址！",
                                                      type: "alert"
                                               });
                                           }
                                       }
                                    }
                                </script>
    </#if>
  </ul>

<#-->  
  <p class="address">选择配送方式：</p>
  <ul class="paystyle">
    <#if delivery_type_list??>
        <#list delivery_type_list as item>
            <li><input type="radio" name="deliveryTypeId" datatype="n" value="${item.id?c}" nullmsg="请选择支付方式!" />${item.title!''}</li>
        </#list>
    </#if>
  </ul>
-->  
  <div class="clear"></div>
  <p class="address">留言：</p>
  <input type="text" name="userRemarkInfo" class="address" value="" />

  <#assign totalQuantity=0>
    <#assign totalPrice=0>
    <#if buy_goods_list??>
            <table class="car_list">
            <tr>
                <th style="text-align:center;" colspan="2">商品信息</th>
                <th>价格</th>
                <th>数量</th>
                <th>合计</th>
            </tr>
            <#list buy_goods_list as sg>
                <#assign totalQuantity=totalQuantity+sg.quantity>
                <#assign totalPrice=totalPrice+(sg.price*sg.quantity)>
                <tr>
                    <td width="110"><a href="/touch/goods/${sg.goodsId?c}?qiang=1"><img src="${sg.goodsCoverImageUri!''}" width="100" height="100"/></a></td>
                    <td width="300" style="text-align:left;"><a href="/touch/goods/${sg.goodsId?c}?qiang=1">${sg.goodsTitle!''}</a></td>
                    <td width="110" style="text-align:left;"><#if sg.price??>${sg.price?string("0.00")}</#if></td>
                    <td width="100" style="text-align:left;">×${sg.quantity!''}</td>
                    <td class="red ml100">￥<#if sg.price?? && sg.quantity??>${(sg.price * sg.quantity)?string("0.00")}</#if></td>
                </tr>
            </#list>
            </table>
        </#if>
        
  <p class="address ta-r">共<#if totalQuantity??>${totalQuantity!'0'}</#if>件商品，合计￥<span id="totalFee" class="red">${totalPrice?string('0.00')}</span></p>  
</div><!--main END-->
<div class="clear70"></div>
<footer class="mainfoot">
<div class="main" style="background:#35424e;">
<section class="car_price">
    <input type="hidden" name="totalPostage" value="${totalPostage!'0'}">
    <h3>合计(含运费)：<span class="sc">￥${(totalPrice+totalPostage)?string("0.00")}</span>
         + 运费（<span>¥<b id="deliveryFee">${totalPostage!'0'}</b></span><#if totalPostagefeenot??>&nbsp;免邮￥（${totalPostagefeenot}）</#if>）
                            （共<span>${totalQuantity!'0'}</span>件商品）</h3>
  
    <a id="btn_sub" href="javascript:;">提交订单（${totalQuantity!'0'}）</a> 
    <div class="clear"></div>
  </section>
  </div>
  </footer>
 </form>
 <div style="height:130px;display:block"></div>
</body>
</html>
