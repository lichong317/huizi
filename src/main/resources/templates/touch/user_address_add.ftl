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
<script src="/touch/js/jquery.cityselect.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    $("#address").citySelect({
        nodata:"none",
        <#if address?? && address.disctrict??>prov: "${address.province!''}",<#else>prov: "云南",</#if>
        <#if address?? && address.disctrict??>city: "${address.city!''}",</#if>
        <#if address?? && address.disctrict??>dist: "${address.disctrict!''}",</#if>
        required:false
    });
    
     $("#addAddressSubmit").click(function(){
        var receiverName = $("#receiverName").val();
        var prov = $("#prov").val();
        var city = $("#city").val();
        var dist = $("#dist").val();
        var detail = $("#detailAdd").val();
        var postcode = $("#postcode").val();
        var mobile = $("#mobile").val();
        
        var addressId = $("#addressId").val();
        var manage = $("#manage").val();
        manage
        if (undefined == receiverName || "" == receiverName)
        {
            //alert("收货人不能为空");
            ct.alert({
                   text: "收货人不能为空",
                   type: "alert"
            });
            $("#receiverName").focus();
            return;
        }
        
        if (undefined == prov || "" == prov)
        {
            //alert("省市不能为空");
            ct.alert({
                   text: "省市不能为空",
                   type: "alert"
            });
            $("#prov").focus();
            return;
        }
        
        if (undefined == city || "" == city)
        {
            //alert("省市不能为空");
            ct.alert({
                   text: "省市不能为空",
                   type: "alert"
            });
            $("#city").focus();
            return;
        }
        
        if (undefined == detail || "" == detail)
        {
            //alert("详细地址不能为空");
            ct.alert({
                   text: "详细地址不能为空",
                   type: "alert"
            });
            $("#detailAdd").focus();
            return;
        }
        
        if (undefined == mobile || "" == mobile)
        {        
            ct.alert({
                   text: "联系电话不能为空",
                   type: "alert"
            });           
                        
            $("#mobile").focus();
            return;
        }
        
        var re = /^1\d{10}$/;
        
        if (!re.test(mobile)) {
             ct.alert({
                      text: "请输入正确的手机号",
                      type: "alert"
             });
             $("#mobile").focus();
             return;
        }
        
        $.ajax({
            type:"post",
            url:"/touch/user/address/ajax/add",
            data:{
                "manage":manage,
                "addressId": addressId,
                "receiverName": receiverName, 
                "prov": prov,
                "city": city,
                "dist": dist,
                "detail": detail,
                "postcode": postcode,
                "mobile": mobile 
            },
            
            success:function(res) {
                if (0 == res.code)
                {                  
                    window.location.href="/touch/user/address/list<#if pointGoodsId??>?pointGoodsId=${pointGoodsId?c}</#if>";
                }
                else if(2 == res.code){
                    window.location.href="/touch/user/addressManage";
                }
                else
                {
                    ct.alert({
                           text: res.message,
                           type: "alert"
                    });
                }
            }
        });
    });
    
});
</script>
</head>

<body>
<header class="comhead">
  <h2>编辑收货地址</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
</header>
<div class="comheadbg"></div>

<input type="hidden" id="addressId" value="<#if address??>${address.id?c}</#if>">
<input type="hidden" id="manage" value="${manage!''}">

<input id="receiverName" type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt40" placeholder="收货人姓名" value="<#if address??>${address.receiverName!''}</#if>"/>
<input id="mobile" type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="手机号码" value="<#if address??>${address.receiverMobile!''}</#if>"/>
<input id="postcode" type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="邮政编码" value="<#if address??>${address.postcode!''}</#if>"/>
<section class="tabfix w80 mga address_sel mt20" >
  <menu id="address" class="address" >
    <li><select id="prov" class="prov"></select></li>
    <li><select id="city" class="city"></select></li>
    <li><select id="dist" class="dist"></select></li>
  </menu>
</section>
<textarea id="detailAdd" class="pt20 pb20 w80 mga h09 border block mt20 ti1 fabg" placeholder="详细地址" ><#if address??>${address.detailAddress!''}</#if></textarea>

<div class="clear h130"></div>
<footer class="addressfoot">
  <input id="addAddressSubmit" type="submit" value="保存" class="sub" />
</footer>
  
</body>
</html>