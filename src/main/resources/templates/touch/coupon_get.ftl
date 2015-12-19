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

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
    $("#btn_get").click(function(){
        var couponId = $("#couponId").val();
                      
        $.ajax({
                type: "post",
                url: "/touch/coupon/request",
                data: { "couponId": couponId },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                       alert("领取成功！");
                       location.reload();
                    } else {
                        alert(data.message);
                    }
                }
            });
    });
});

</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>优惠券详情</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <div class="clear10"></div>  
  <#if coupon_list??>
        <#list coupon_list as coupon>
            <div class="myorder_list"> 
                <a href="#"><img src="${coupon.typePicUri!''}" width="100%" height="200"></a>
                <div class="clear"></div>                
            </div>
        </#list>
  </#if>
  <#if coupon_list??>
        <#list coupon_list as coupon>
            <input id="couponId" name="couponId" class="text" type="hidden" value="${coupon.id?c}" />
            <p class="center fs09 mb10 mt10">${coupon.typeTitle!''}
            <span style="float:right; margin-right:10px">剩余数量<b class="red"><#if coupon.leftNumber??>${coupon.leftNumber}<#else>0</#if></b></span></p>
            <p class="center fs09 mb10 mt10">有效期：<span class="red">${couponType.totalDays!''}</span>&nbsp; 天   
            <span style="float:right; margin-right:10px">领取人数 <b class="red"><#if distributed_coupon_list??>${distributed_coupon_list?size}<#else>0</#if></b></span></p>
            <hr size=1 style="COLOR:#ff9999;border-style:double;width:490">
            <p class="center fs09 mb10 mt10" style="font-size:0.9em; color:#CDCDCD">优惠券描述</p>
            <p class="center fs09 mb10 ">${couponType.description!''}</p>
        </#list>
  </#if>
  <a style=" width:40%; background:#ff4544; color:#fff; height:30px; line-height:30px; border:none;" id="btn_get" href="javascript:;">立即领取</a>
</div>
<!--main END-->

<section class="botmain">
  <div class="main">
 <div class="center">
    <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout">退出</a>
    <#else>
        <a href="/touch/login">登录</a>
        <span>|</span>
        <a href="/touch/reg">注册</a>
    </#if>      
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/coupon/list">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
