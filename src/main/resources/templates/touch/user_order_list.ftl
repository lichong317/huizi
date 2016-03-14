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
    
});


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
                    //alert(res.message);
                    ct.alert({
                        text: res.message,
                        type: "alert"
                    });
                    window.location.reload();
                }
                else
                {
                    //alert(res.message);
                    ct.alert({
                        text: res.message,
                        type: "alert"
                    });
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

<body class="eeebg">

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>我的订单</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<section class="listhead tabfix w100 myorderhead">
  <menu>
    <li <#if !status_id?? || status_id==0>class="sel"</#if>>
      <a href="/touch/user/order/list/0">全部</a>
    </li>
    <li <#if !status_id?? || status_id==2>class="sel"</#if>>
      <a href="/touch/user/order/list/2">待付款</a>
    </li>
    <li <#if !status_id?? || status_id==4>class="sel"</#if>>
      <a href="/touch/user/order/list/4">待收货</a>
    </li>
    <li <#if !status_id?? || status_id==5>class="sel"</#if>>
      <a href="/touch/user/order/list/5">待评价</a>
    </li>
    <li <#if !status_id?? || status_id==6>class="sel"</#if>>
      <a href="/touch/user/order/list/6">维修售后</a>
    </li>
  </menu>
</section>

<#if order_page?? && order_page.content?size gt 0>
     <#list order_page.content as order>
           <section class="mainbox bot-border lh5 whitebg">
              <p class="w100 c8">
                <span class="absolute-r"><#if order.orderTime??>${order.orderTime?string("yyyy-MM-dd")}</#if></span>
                订单编号：${order.orderNumber!''}
              </p>
            </section>
            <#if order.orderGoodsList??>
                 <#list order.orderGoodsList as ordergoods>
                      <a href="/touch/goods/${ordergoods.goodsId?c}" class="prolist mainbox bot-border whitebg">
                          <b class="img"><img src="${ordergoods.goodsCoverImageUri!''}" /></b>
                          <section>
                          <p class="h07 oh">${ordergoods.goodsTitle!''}</p>
                          <p class="mt20 c9">单价：￥<#if ordergoods.price??>${ordergoods.price?string("0.00")}</#if>&nbsp;&nbsp;&nbsp;&nbsp;数量：${ordergoods.quantity!'0'}</p>
                          </section>
                          <div class="clear"></div>
                      </a>
                 </#list>
            </#if>
            <p class="mainbox ta-r whitebg lh6">共计${order.orderGoodsList?size}件商品，合计<span class="red">￥<#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></span>元</p>
            <section class="mainbox whitebg lh5 h05 pt10 pb10">
              <p class="w100 ta-r">
                 <#if order.statusId==2 >
                      <span class="red absolute-l">待付款</span>
                      <a href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()"  class="inblock pr10 pl10 border ml10 bor-rad">取消订单</a>
                      <#if order.payTypeTitle == "微信支付">
                           <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb309b01e273cd1cf&redirect_uri=http://www.huizhidian.com/touch/order/dopay&response_type=code&scope=snsapi_base&state=${order.id?c}#wechat_redirect" class="inblock pr10 pl10 redbg white ml10 bor-rad">去付款</a>
                      <#else>
                           <a href="/order/dopay/${order.id?c}" class="inblock pr10 pl10 redbg white ml10 bor-rad">去付款</a>
                      </#if>
                 <#elseif order.statusId==1>
                      <span class="red absolute-l">待确认</span>
                      <a href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()"  class="inblock pr10 pl10 border ml10 bor-rad">取消订单</a>
                 <#elseif order.statusId==4>
                      <span class="red absolute-l">待收货</span>
                      <a href="javascript:orderReceive(${order.id?c});" onClick="receiveConfirm()"  class="inblock pr10 pl10 redbg white ml10 bor-rad">确认收货</a>
                 <#elseif order.statusId==5>
                      <span class="red absolute-l">待评价</span>
                      <a href="/touch/user/comment/edit?orderId=${order.id?c}"  class="inblock pr10 pl10 redbg white ml10 bor-rad">去评价</a>
                 <#elseif order.statusId==6>
                      <span class="red absolute-l">已完成</span>
                      <a href="/touch/user/return/list?keywords=${order.orderNumber!''}"  class="inblock pr10 pl10 redbg white ml10 bor-rad">售后</a>
                      <a href="/touch/user/order/delete?id=${order.id?c}" onClick="deleteConfirm()"  class="inblock pr10 pl10 redbg white ml10 bor-rad">删除订单</a>
                 <#elseif order.statusId==7>
                      <a href="/touch/user/order/delete?id=${order.id?c}" onClick="deleteConfirm()"  class="inblock pr10 pl10 redbg white ml10 bor-rad">删除订单</a>
                 </#if>
              </p>
            </section>
            <div class="clear h02"></div>
     </#list>
<#else>
    <div class="clear" style="height:2rem;"></div>
    <p class="ta-c"><img src="/touch/images/member/kong.png" style="width:1.2rem;" /></p>
    <p class="ta-c pt10">您还没有相关订单</p>
</#if>

<div class="clear h03"></div>
  
</body>
</html>
