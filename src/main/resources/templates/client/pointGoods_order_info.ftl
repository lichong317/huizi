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
        <form id="form1" name="form1" action="/pointGoods/order/submit" method="post">
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
                      <span id="notcodaddress" style="display: none;float:left;margin-left:5px;color:#ef0000;">不支持货到付款</span>
                      <script>
                        
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
                    <th>邮政编码：</th>
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
                    <th>备用号码：</th>
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
                                    <#if pay_type.title!="货到付款">
                                    <li>
                                        <input  tn="${pay_type.title!''}" type="radio" name="payTypeId" class="input-pay-type"  datatype="n" value="${pay_type.id?c!''}" nullmsg="请选择支付方式!">
                                        <span>${pay_type.title!''}</span>
                                    </li>
                                    </#if>
                                </#list>
                                <script>

                                </script>
                            </#if>
                        </ul>
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
                                    <td>兑换积分</td>
                                    <td>数量</td>
                                </tr>
                                <#if goods??>
                                <tr>
                                    <td width="100">${goods.id?c}</td>
                                    <td><img src="${goods.coverImageUri!''}" width="76" height="76"><span style="margin-left:10px;">${goods.title!''}</span></td>
                                    <td>${goods.pointUse!''}</td>
                                    <td>1</td>
                                </tr>
                                </#if>
                            </table>
                        </div>
                        
                       <div id="goodsListDiv" class="gwc1_lm2">
                       </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            
            <input type="hidden" name="totalPostage" value="${totalPostage!'0'}">
            <input type="hidden" name="goodsId" value="${goods.id?c}">
            <div class="main">
                <div class="s_gwc1zj flr">
                    <p>商品<span id="idTotalQuantity">1</span>件  总价：兑换积分（<span><b >${goods.pointUse!''}</b></span>)
                     + 运费（<span>¥<b id="deliveryFee">${totalPostage!'0'}</b></span><#if totalPostagefeenot??>&nbsp;免邮￥（${totalPostagefeenot}）</#if>）
                
                     = 商品总计(含运费)： <span>¥<b id="totalPrice">${totalPostage!'0'}</b></span> </p>
                </div>
            </div>
            <div class="clear"></div>
            
            <div class="main">
                <div class="s_gwc1zja">
                    <div class="flr s_gwc1zja_2">
                    	<#if user?? && user.totalPoints?? && goods?? && goods.pointUse?? && user.totalPoints < goods.pointUse>
                    		<input type="button" value="积分余额不足" class="input_zy"></input>
                    	<#else>
                        	<input type="submit" value="提交订单" class="input_zy"></input>
                        </#if>
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




  











