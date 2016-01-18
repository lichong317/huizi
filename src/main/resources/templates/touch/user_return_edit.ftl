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
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){  
     //初始化表单验证
    $(".commentForm").Validform({
        tiptype: 3,
        success:function(){
        //alert("申请成功，我们将尽快处理。")
        ct.alert({
              text: "申请成功，我们将尽快处理",
              type: "alert"
        });
        }
    });
});   
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>申请</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<div class="main">
    <#if order_goods??>
    <a class="phone_list" href="/touch/goods/${order_goods.goodsId?c}">
        <b><img src="${order_goods.goodsCoverImageUri}" width="95" height="95"/></b>
        <p class="p1">${order_goods.goodsTitle!''}</p>
        <p>${order_goods.goodsSubTitle!''}</p>
        <p class="fl">购买数量：<span class="red">${order_goods.quantity!''}</span></p>
        <p class="p2 ta-r mt20">￥${order_goods.price?string("0.00")}</p>
        <div class="clear"></div>
    </a>
    </#if>
</div>
<div class="clear20"></div>
<#if has_returned?? && has_returned>
    <div class="mainbox myassess">
        <b><font>* </font>问题描述：</b>
        <textarea>${return.reason!''}</textarea>
        <p class="pt10 pb10 w100">
            <input type="radio" disabled="disabled" <#if has_returned??&&has_returned&&return.isReturn?? && return.isReturn> checked="checked"</#if>/>退货
            <input type="radio" disabled="disabled" <#if has_returned??&&has_returned&&return.isReturn?? && !return.isReturn>checked="checked"</#if>/>换货            
        </p> 
        <h3 style="text-align:right;color:#666;margin:20px 0;">状态：<#if return.statusId ==1><span style="color:#0060aa;text-align:right;">已处理</span><#else><span style="color:#fd3e3e;text-align:right;">待处理</span></#if></h3>       
    </div>
<#else>
<form class="commentForm" action="/touch/user/return/save" method="post">
    <input type="hidden" name="id" value="${orderId?c}" />
    <input type="hidden" name="goodsId" value="${goodsId?c}" />
    <input type="hidden" name="telephone" value="${telephone}" />
    <div class="mainbox myassess">
        <b><font>* </font>问题描述：</b>
        <textarea name="reason"></textarea>
        <p class="pt10 pb10 w100">
            <input type="radio" datatype="*" name="isReturn" value="true" />退货
            <input type="radio" datatype="*" name="isReturn" value="false" />换货            
        </p> 
        <input type="submit" value="提交" class="sub" />
    </div>
  <div class="clear20"></div>
</form> 
</#if>
<!--main END-->

<#if !app??>
<section class="botmain">
  <div class="main">
  <div class="center">
   <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout" onclick="logout()">退出</a>
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
    <a class="fs09" href="/user">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div> 
</#if>
</body>
</html>
