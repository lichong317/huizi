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

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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

<style>
.Validform_checktip{line-height:20px; height:20px; overflow:hidden; color:red; font-size:12px; margin-left:10%;}


#Validform_msg{color:#7d8289; font: 12px/1.5 tahoma, arial, \5b8b\4f53, sans-serif; width:280px; -webkit-box-shadow:2px 2px 3px #aaa; -moz-box-shadow:2px 2px 3px #aaa; background:#fff; position:absolute; top:0px; right:50px; z-index:99999; display:none;filter: progid:DXImageTransform.Microsoft.Shadow(Strength=3, Direction=135, Color='#999999'); box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);}
#Validform_msg .iframe{ position:absolute; left:0px; top:-1px; z-index:-1; }
#Validform_msg .Validform_title{ position:relative; line-height:35px; height:35px; text-align:left; font-weight:bold; padding:0 10px; color:#fff; background:#33B5E5; }
#Validform_msg a.Validform_close:link,#Validform_msg a.Validform_close:visited{ line-height:30px; position:absolute; right:10px; top:0px; color:#fff; text-decoration:none; }
#Validform_msg a.Validform_close:hover{color:#ccc;}
#Validform_msg .Validform_info{padding:10px;border:1px solid #bbb; border-top:none; text-align:left;}


</style>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>申请退换货</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="prolist mainbox  whitebg">
    <#if order_goods??>
        <a class="img" href="/touch/goods/${order_goods.goodsId?c}">
            <img src="${order_goods.goodsCoverImageUri}"/> 
        </a>
        <section>
            <p class="h07 oh">${order_goods.goodsTitle!''}</p>
            <p class="fl mt10">购买数量：<span class="red">${order_goods.quantity!''}</span></p>
            <p class="p2 ta-r mt10 red">￥${(order_goods.price*order_goods.quantity)?string("0.00")}</p>
            <div class="clear"></div>
        </section>
    </#if>
</div>
<div class="clear20"></div>
<#if has_returned?? && has_returned>
        <div class="clear h01"></div>
        <b><font>* </font>问题描述：</b>
        <textarea class="reviews_area" placeholder="评价内容" ><#if return??>${return.reason!''}</#if></textarea>
        <p class="pt10 pb10 w100 mt10">
            <input type="radio" disabled="disabled" <#if has_returned??&&has_returned && return??&&return.isReturn??  && return.isReturn> checked="checked"</#if>/>退货
            <input type="radio" disabled="disabled" <#if has_returned??&&has_returned && return??&&return.isReturn??  && !return.isReturn>checked="checked"</#if>/>换货            
        </p> 
        <h3 style="text-align:right;color:#666;margin:20px 0;">状态：<#if return?? && return.statusId ==1><span style="color:#0060aa;text-align:right;">已处理</span><#else><span style="color:#fd3e3e;text-align:right;">待处理</span></#if></h3>       

<#else>
<form class="commentForm" action="/touch/user/return/save" method="post">
    <input type="hidden" name="id" value="${orderId?c}" />
    <input type="hidden" name="goodsId" value="${goodsId?c}" />
    <input type="hidden" name="telephone" value="${telephone}" />
        <div class="clear h01"></div>
        <b><font>* </font>问题描述：</b>
        <textarea name="reason" class="reviews_area" placeholder="评价内容" datatype="*5-255" nullmsg="请输入评价内容"></textarea>
        <p class="pt10 pb10 w100 mt10">
            <input type="radio" datatype="*" name="isReturn" value="true" />退货
            <input type="radio" datatype="*" name="isReturn" value="false" />换货            
        </p> 
        <p class="ta-r"><input type="submit" value="提交" class="sub redbg w30 white h05 lh5 bor-rad mt10 " /></p>

  <div class="clear20"></div>
</form> 
</#if>
<!--main END-->

</body>
</html>
