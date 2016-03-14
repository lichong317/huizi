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

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    $(".addresslist .a1").each(function(i){
        $(".addresslist .a1").eq(i).click(function(){
            $(".addresslist .a1").removeClass('a1sel');
            $(".addresslist .a1").eq(i).addClass('a1sel');
        });
               
    });
    
});

function changeDefault(id){
     $.ajax({
                type: "post",
                url: "/touch/user/address/ajax/changedefault",
                data: { "id": id},
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {

                    } else {
                        //alert(data.message);
                        ct.alert({
                                text: data.message,
                                type: "alert"
                        });
                    }
                }
     });
}
</script>
</head>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>收货地址</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<#if address_list??>
    <#list address_list as item>
        <div class="addresslist">
             <a class="a1" href="javascript:changeDefault(${item.id?c});">
                <i></i>
                <h3>收货人：${item.receiverName!''}<span>&nbsp;&nbsp;&nbsp;${item.receiverMobile!''}</span></h3>
                <p><span>收货地址：</span>${item.detailAddress!''}</p>
             </a>             
             <a class="a2" href="/touch/user/address/delete?id=${item.id?c}&pointGoodsId=${pointGoodsId!''}"><img src="/touch/images/member/del.png" /></a>
        </div>
    </#list>
</#if>

<div class="clear h05"></div>
<a class="redborbtn h06 lh6 w40 mga bor-rad" href="/touch/user/addressAdd<#if pointGoodsId??>?pointGoodsId=${pointGoodsId?c}</#if>">添加新地址</a>

<div class="clear h130"></div>
<footer class="addressfoot">
  <input type="submit" value="确认" class="sub" <#if pointGoodsId??>onclick="window.location.href='/touch/pointGoods/order/info?pointGoodsId=${pointGoodsId?c}'"<#else>onclick="window.location.href='/touch/order/info'"</#if>/>
</footer>
  
</body>
</html>
