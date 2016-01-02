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
  
});

var pageIdx = 1;
function loadMore()
{
    $.ajax({
        type:"post",
        url:"/touch/user/order/list/more/${status_id!'0'}?page=" + pageIdx,
        success:function(data){
            if ("" == data)
            {
                $("#a-more").css("display", "none");
            }
            else
            {
                $("#goods-menu").append(data);
                pageIdx++;
            }
        }
    });
}

function receiveConfirm() {
    if (!confirm("检查货物质量并确认收货？")) {
        window.event.returnValue = false;
    }
}


function cancelConfirm() {
    if (!confirm("未付款可直接取消，是否确认取消订单？")) {
        window.event.returnValue = false;
    }
}

function deleteConfirm() {
    if (!confirm("是否确认删除订单？")) {
        window.event.returnValue = false;
    }
}

function orderReceive(id)
{
     $.ajax({
            type:"post",
            url:"/touch/user/order/receive",
            data:{
                "id":id
            },
            success:function(res) {
                if (0 == res.code)
                {
                    alert(res.message);
                    window.location.reload();
                }
                else
                {
                    alert(res.message);
                    if (res.message = "请登录！！")
                    {
                    window.location.href="/login"
                    }
                }
            }
        });
}
</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>我的订单</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <div class="clear15"></div>
  <table class="content_check">
    <tr>
      <td>
        <a <#if !status_id?? || status_id==0>class="a2 sel"<#else>class="a2"</#if>  href="/touch/user/order/list/0">全部订单</a>
      </td>
      <td>
        <a <#if status_id?? && status_id==2>class="a2 sel"<#else>class="a2"</#if>  href="/touch/user/order/list/2">待付款</a>
      </td>
      <td class="two-border">
        <a <#if status_id?? && status_id==4>class="a2 sel"<#else>class="a2"</#if>  href="/touch/user/order/list/4">待收货</a>
      </td>
      <td>
        <a <#if status_id?? && status_id==5>class="a2 sel"<#else>class="a2"</#if>  href="/touch/user/order/list/5">待评价</a>
      </td>
    </tr>
  </table>
  
  <menu id="goods-menu">
    <#if order_page??>
        <#list order_page.content as order>
            <div class="myorder_list">        
                <h2>订单编号&nbsp;<a href="/touch/user/order?id=${order.id?c}"> ${order.orderNumber!''}</a><span><#if order.orderTime??>${order.orderTime[0..8]?default("")}</#if></span></h2>
                <#if order.orderGoodsList??>
                    <#list order.orderGoodsList as ordergoods>
                        <a class="a1" href="/touch/goods/${ordergoods.goodsId?c}">
                             <span class="sp1"><img src="${ordergoods.goodsCoverImageUri!''}" width="62" height="62"/></span>
                             <p class="mb10">${ordergoods.goodsTitle!''}</p>
                             <p>单价：<span class="sc">￥<#if ordergoods.price??>${ordergoods.price?string("0.00")}</#if></span>&nbsp;&nbsp;数量：${ordergoods.quantity!'0'}</p>
                             <div class="clear"></div>
                        </a>
                    </#list>
                </#if>
               
                <p style="width:90%; float:left; margin:10px; font-size:0.8em;">共<span>${order.orderGoodsList?size}</span>件商品，合计:&nbsp;&nbsp;<span class="red">¥<#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></span>元</p>
                <span style="width:100%; float:left; ">
                <#if order.statusId==2 >
                    <a href="/order/dopay/${order.id?c}" class="a2">去付款</a>
                    <a href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()" class="a2">取消订单</a>
                <#elseif order.statusId==1>
                    <a href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()" class="a2">取消订单</a>  
                <#elseif order.statusId==4>
                    <a href="javascript:orderReceive(${order.id?c});" onClick="receiveConfirm()" class="a2">确认收货</a>
                <#elseif order.statusId==5>
                    <a href="/touch/user/comment/list?keywords=${order.orderNumber!''}" class="a2">去评价</a> 
                <#elseif order.statusId==6>
                    <a href="/touch/user/return/list?keywords=${order.orderNumber!''}" class="a2" style="width:35%">申请返修/退换货</a>
                    <a href="/touch/user/order/delete?id=${order.id?c}" onClick="deleteConfirm()" class="a2">删除订单</a>
                <#elseif order.statusId==7>
                    <#--><a href="/touch/user/return/list?keywords=${order.orderNumber!''}" class="a2" style="width:35%">申请返修/退换货</a>  -->
                    <a href="/touch/user/order/delete?id=${order.id?c}" onClick="deleteConfirm()" class="a2">删除订单</a> 
                </#if>
                </span>
                <div class="clear"></div>
            </div>
        </#list>
    </#if>
       
  </menu>
  
  <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>
  
</div><!--main END-->

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
    <a class="absolute-r" href="javascript:$('html,body').animate({scrollTop:0},500);">返回顶部</a>
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user/order/list/0">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div>
</body>
</html>
