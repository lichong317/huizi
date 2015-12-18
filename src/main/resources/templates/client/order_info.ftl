<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/css/gwc.css" rel="stylesheet" type="text/css" />
<link href="/client/style/bankLogo.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/jquery.cookie.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/jquery.cityselect.js"></script>
<script src="/client/js/lhgdialog.js"></script>
<script src="/client/js/order_info.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	menuDownList("top_phone","#top_phonelist",".a1","sel");
	phoneListMore();//单独下拉
    menuDownList("top_order","#top_orderlist",".a4","sel");//顶部下拉
	searchTextClear(".toptext","请输入品牌或商品名称","#999","#666");
	searchTextClear(".bottext","查看所有门店","#fff","#fff");
	checkNowHover("shopping_down","shopping_sel");
	navDownList("navdown","li",".nav_showbox");
	menuDownList("mainnavdown","#navdown",".a2","sel");
	
	chooseMoreShow();
	
	//初始化表单验证
	//$("#form1").initValidform();
	
    $("#form1").Validform({
        tiptype: 1
    });

    $("#address").citySelect({
        nodata:"none",
        prov: "云南",
        city: "昆明",
        <#if address?? && address.disctrict??>dist: "${address.disctrict!''}",</#if>
        required:false
    }); 
           
    //积分修改
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

        var virtualCurrency  = $.trim($(this).val());
        if (isNaN(virtualCurrency) || virtualCurrency=="") { virtualCurrency = 0 }
        
        <#if user?? &&  user.roleId??>
            <#if user.roleId == 1>
                <#assign virtual_limit = user.totalCashRewards />
            <#else>
                <#assign virtual_limit = user.virtualCurrency />
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



var forPaymentFllow = true;
</script>
</head>
<body>
<#include "/client/common_header.ftl" />

<!--mymember-->
<div class="myclear"></div>

<div class="mymember_out">
    <div class="gwcbg">
    
        <div class="main mt10">
            <div class="weizhi"> 
                <span>您现在的位置：</span>
                <a href="/">首页</a> &gt; <a href="/order/info">核对订单</a>
            </div>
                
            <div class="s_gwc2 mt10">
                <span >1、我的购物车</span>
                <span id="colorfff">2、我的订单信息</span>
                <span>3、支付成功</span>
            </div>
        </div>
        
        <div id="main-form">
        <form id="form1" name="form1" action="/order/submit" method="post">
            <div class="main mt15">
                <div class="s_gwc2_1">
                    <div class="s_gwc2_1_a">
                        <p><span>收货地址</span></p>
                        <p><a id="addAddress" href="javascript:;">新增收货地址</a></p>
                    </div>
    
                    <div class="gwc2_psfs555">
                        <input id="input-address-id" type="hidden" name="addressId" value="" datatype="n" nullmsg="请选择收货地址!"/>
                        <#if user.shippingAddressList?? && user.shippingAddressList?size gt 0>
                            <#list user.shippingAddressList as address>
                                <div class="s_gwc2_1_b">
                                    <a class="selAddress" href="javascript:void(0);" aid="${address.id?c}">
                                        <p>收货人：${address.receiverName!''}</p>
                                        <p>收货地址：<span id="addressprovince">${address.province!''}</span>
                                                 <span id="addresscity">${address.city!''}</span>
                                                 <span id="addressdisctrict">${address.disctrict!''}</span>${address.detailAddress!''}</p>
                                        <p>联系方式：${address.receiverMobile!''}</p>
                                        <p>备用号码：${address.receiverTelephone!''}</p>
                                    </a>
                                </div>
                            </#list>
                        </#if>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            
            <div id="addressForm" class="new-address hide">
                <table class="mymember_address">
                  <tbody>
                  <tr>
                    <th>收货人*：</th>
                    <td>
                        <input class="mytext" id="receiverName" value="" type="text" >
                        <span>收货人姓名</span>
                    </td>
                  </tr>
                  <tr>
                    <th>地区*：</th>
                    <td>
                      <div id="address">
                      <select id="prov" class="prov" style="width: 100px; float:left;margin-right:5px;"></select>
                      <select id="city" class="city" style="width: 100px;float:left;margin-right:5px;"></select>
                      <select id="dist" class="dist" style="width: 150px;float:left;" onchange="javascript:checkaddress()"></select>
                      <lable id = "notcodaddress" style="display: none;float:left;margin-left:5px;color:#ef0000;">不支持货到付款</lable>
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
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th>详细地址*：</th>
                    <td>
                        <input class="mytext" id="detailAdd" value="" type="text" >
                    </td>
                  </tr>
                  <tr>
                    <th>邮政编码*：</th>
                    <td>
                        <input class="mytext" id="postcode" value="" type="text">
                    </td>
                  </tr>
                  <tr>
                    <th>联系电话*：</th>
                    <td>
                        <input class="mytext" id="mobile" value="" type="text">
                    </td>
                  </tr>
                  <tr>
                    <th>备用号码*：</th>
                    <td>
                        <input class="mytext" id="spareMobile" value="" type="text">
                    </td>
                  </tr>
                  <tr>
                    <th></th>
                    <td><input id="addAddressSubmit" class="mysub" type="button" value="保存"></td>
                  </tr>
                </tbody>
                </table>
            </div>
    
            <span id = "notcodaddress1" style="display: none;margin-left:350px;color:#ef0000; margin-top:10px">不支持货到付款</span>
            <div class="main mt15">
                <div class="s_gwc3_1">
                    <div class="s_gwc3_1_a">
                        <p><span>支付方式</span></p>
                    </div>
                    
                    <div class="gwc_3zf">
                        <ul>
                            <#if pay_type_list??>
                                <#list pay_type_list as pay_type>
                                    <li>
                                        <input onclick="changepaytype(this)" tn="${pay_type.title!''}" name="payTypeId" class="input-pay-type" type="radio" datatype="n" value="${pay_type.id?c!''}" nullmsg="请选择支付方式!">
                                        <span>${pay_type.title!''}</span>
                                    </li>
                                </#list>
                                <script>
                                    function changepaytype(paytype){
                                        //alert(paytype.getAttribute("tn"));
                                       if(paytype.getAttribute("tn") == "货到付款"){  
                                                                           
                                          var addressId = $("#input-address-id").val();
                                           var $browsers = $("input[name=payTypeId]");
                                           if(''!= addressId){
                                               $.ajax({
                                                    type: "post",
                                                    url: "/order/codDistrict",
                                                    data: { "addressId": addressId},
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
                                       }else{
                                           // $(".input_zy").attr("disabled", false);
                                       }
                                    }
                                </script>
                            </#if>
                        </ul>
                    </div>
                </div>
            </div> 
    
       <#-- <div class="clear h20"></div>
        <#assign maxMethodCount=5/>
        <#assign changePayMethod=false/>
        <#include "/client/paybox_common.ftl" />
        <div class="clear h10"></div> -->
        
   <#-->         <div class="main mt15">
                <div class="s_gwc3_1">
                    <div class="s_gwc3_1_a">
                        <p><span>配送方式</span></p>
                    </div>
                    <div class="invoice">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <select id="deliveryTypeSelect" name="deliveryTypeId" datatype="n" nullmsg="请选择配送方式">
                            <option value="" price="0">请选择</option>
                            <#if delivery_type_list??>
                                <#list delivery_type_list as delivery_type>
                                    <option value="${delivery_type.id?c!''}" price="${delivery_type.fee?string("#.##")}">${delivery_type.title!''}</option>
                                </#list>
                            </#if>
                        </select>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>说明：</span><input type="text" name="userRemarkInfo" class="fapiaolan">
                    </div>
                </div>
            </div> -->
    
            <div class="main mt15">
                <div class="s_gwc3_1">
                    <div class="s_gwc3_1_a">
                        <p><span>发票信息</span></p>
                    </div>
                    <div class="invoice">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>是否开具发票：</span>
                        <input type="radio" name="isNeedInvoice" value="1" datatype="n" nullmsg="请选择是否开具发票!"><span>是</span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" checked="checked" name="isNeedInvoice" value="0" datatype="n" nullmsg="请选择是否开具发票!"><span>否</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>发票抬头：</span>
                        <input type="text" name="invoiceTitle" class="fapiaolan">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>发票内容：由惠资生活直接开具</span>
                    </div>
                </div>
            </div>
    
            <div class="main mt15">
                <div class="s_gwc4_1">
                    <div class="s_gwc4_1_a">
                        <p><span>商品信息</span></p>
                    </div>
                    
                    <div class="gwc2_psfs">
                        <div class="gwc1_lm ">
                            <table>
                                <tr>
                                    <td width="100">商品编号</td>
                                    <td>商品信息</td>
                                    <td>单价</td>
                                    <td>数量</td>
                                    <td>合计</td>
                                </tr>
                            </table>
                        </div>
                        
                        <div id="goodsListDiv" class="gwc1_lm2">
                            <#include "/client/order_info_goods_list.ftl" />
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
    
            
            <div class="main mt15">
                <div class="s_gwc3_1">
                    <div class="s_gwc3_1_a">
                        <p><span>我的优惠劵</span></p>
                    </div>
                    <div class="invoice">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <select id="couponSelect" name="couponId"  onchange="couponChange();">
                            <#if coupon_list??>
                                <option value="" fee="0">不使用优惠券</option>
                                <#list coupon_list as item>
                                    <option value="${item.id?c}" fee="${item.price!''}">${item.typeTitle!''}</option>
                                </#list>
                            </#if>
                        </select>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span class="orange">抵用金额：￥<b id="couponFeee">0.00</b>元</span>
                    </div>
                </div>
            </div>
            <#if user?? &&user.roleId?? && user.roleId == 2>
                <div class="main mt15">
                    <div class="s_gwc3_1">
                        <div class="s_gwc3_1_a">
                            <p><span>使用虚拟币</span></p>
                        </div>
                        <div class="invoice">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" id="virtualCurrency" name="virtualCurrency" value="" >
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <span class="orange">可用余额：￥<b id="">${user.virtualCurrency!''}</b>元</span>
                            
                        </div>
                    </div>
                </div>
            </#if>
             <#if user?? &&user.roleId?? && user.roleId == 1>
                <div class="main mt15">
                    <div class="s_gwc3_1">
                        <div class="s_gwc3_1_a">
                            <p><span>使用返现金额</span></p>
                        </div>
                        <div class="invoice">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" id="virtualCurrency" name="virtualCurrency" value="" >
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <span class="orange">可用余额：￥<b id="">${user.totalCashRewards!''}</b>元</span>
                            
                        </div>
                    </div>
                </div>
            </#if>
            <span style="display:none" id="virtualCurrencyfee">0.00</span>
    <#-->   
            <div class="main mt15">
                <div class="s_gwc3_1">
                    <div class="s_gwc3_1_a">
                        <p><span>商品备注</span></p>
                    </div>
                    <div class="gwc_3zf11 fll">
                        <textarea class="input12"  onfocus="if(value=='留言内容') {value=''}" onblur="if (value=='') {value='留言内容'}"  value="留言内容"  id="et_contact_message" name="userRemarkInfo">留言内容</textarea>
                    </div>
                    <div class="clear"></div>
                </div>
            </div> -->
            
            <input type="hidden" name="totalPostage" value="${totalPostage!'0'}">
            <div class="main">
                <div class="s_gwc1zj flr">
                    <input id="idTotalPriceSteady" type="hidden" value="${(totalPrice)?string("#.##")}" />
                    <p>商品<span id="idTotalQuantity">${totalQuantity!'0'}</span>件  总价：商品价格（<span>¥<b id="currentPrice">${totalPrice?string("0.00")}</b></span>)
                     + 运费（<span>¥<b id="deliveryFee">${totalPostage!'0'}</b></span><#if totalPostagefeenot??>&nbsp;免邮￥（${totalPostagefeenot}）</#if>）
                     - 积分抵扣（<span>￥<input id="idPointUse" name="pointUse" style="width:30px; text-align:center;" value="0"/></span>）
                     = 商品总计(含运费)： <span>¥<b id="totalPrice">${(totalPrice+delivery_fee!0)?string("0.00")}</b></span> </p>
                </div>
            </div>
            <div class="clear"></div>
            
            <div class="main">
                <div class="s_gwc1zja">
                    <div class="flr s_gwc1zja_2">
                        <input type="submit" value="提交订单" class="input_zy"></input>
                    </div>
                </div>
                <div class="h40"></div>
            </div>
        </form>
        </div>
    </div>
    
    <#include "/client/common_footer.ftl" />

</div>
</body>
</html>




  











