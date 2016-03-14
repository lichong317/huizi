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
    //menuCheckShow("checkmenu","li","checksum","li","sel",0);//选项卡效果
});

function redEnvelopeGet(redenvelopeId){
    var username = $("#username").val();
    //var redenvelopeId = $("#redenvelopeId").val();
    $.ajax({
                type: "post",
                url: "/touch/user/redenvelope/get",
                data: { "username": username, "redenvelopeId": redenvelopeId },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                        $("#getRedenvelope").css("display", "none");
                        if(data.isGetPrize == true){
                           // $("#getRedenvelopeTrue").css("display", "block");
                        }else{
                            //$("#getRedenvelopeFalse").css("display", "block");
                        }                                               
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

<body class="eeebg">

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>我的红包</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>
<section class="listhead tabfix w100 myorderhead">
  <menu>
    <li <#if status_id?? && status_id==2 >class="sel"</#if>>
      <a href="/touch/user/redenvelope/list?statusId=2">已领取红包</a>
    </li>
    <li <#if status_id?? && status_id==1 >class="sel"</#if>>
      <a href="/touch/user/redenvelope/list?statusId=1">可领取红包</a>
    </li>
  </menu>
</section>
    <input id="username" style="display:none" value="<#if user??>${user.username}</#if>">
   <#if redenvelope_page??>
        <#list redenvelope_page.content as item>
              <a href="/touch/user/redenvelope/list?statusId=2&redenvelopeId=${item.id?c}" <#if !item.isGet?? || !item.isGet>onclick="redEnvelopeGet(${item.id?c})"</#if>class="redbag mt20">
                  <h3><span class="red absolute-r">￥50</span>${item.typeTitle!''}</h3>
                  <p class="mt20 c9"><span class="red absolute-r"><#if item.isGet>查看<#else>拆开</#if>>> </span>发放日期：<#if item.sendTime??>${item.sendTime?string("yyyy-MM-dd")}</#if></p>
              </a>
        </#list>
   </#if>    

<div class="clear h03"></div>

<!--弹出层-->
<#if tdRedEnvelope??>
<aside class="winbg" >
  <div class="myself_ts">
    
    <#if tdRedEnvelope?? && !tdRedEnvelope.isGetPrize && tdRedEnvelope.isGet >
        <p class="ta-c pt20 lh5"><b class="red fs35">下手太慢！</b></p>
        <p class="ta-c">红包被抢光了</p>
    <#else>
        <p class="ta-c pt20 lh5">已成功领取<b class="red fs35">${tdRedEnvelope.typeTitle!''}</b></p>
        <#if tdRedEnvelope.redEnvelopeType == 0>
            <p class="ta-c">奖励积分${tdRedEnvelope.prizePoints!''}！</p>
        <#elseif tdRedEnvelope.redEnvelopeType == 1>
            <p class="ta-c">奖励优惠券${tdRedEnvelope.couponTitle!''}！</p>
        <#elseif tdRedEnvelope.redEnvelopeType == 2>
            <p class="ta-c">奖励商品${tdRedEnvelope.goodsTitle!''}！</p>
        </#if>
    </#if>
    <div class="clear h05"></div>
    <a class="sub w90 mga lh6 h06 ta-c white redbg block fs3 bor-rad" href="javascript:void(0);" onClick="$(this).parent().parent().fadeOut(200);">返回</a>
  </div>
</aside>
</#if>  
</body>
</html>
