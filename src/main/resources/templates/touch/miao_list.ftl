<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>团购列表</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="list_top">
<table class="main">
  <tr>
    <td <#if !type??>class="sel"</#if> ><a href="/touch/promotion/miao">正在进行</a></td>
    <td <#if type?? && type=="ongoing">class="sel"</#if> ><a href="/touch/promotion/miao?type=ongoing">即将开始</a></td>
    <td <#if type?? && type=="passed">class="sel"</#if> ><a href="/touch/promotion/miao?type=passed">往期回顾</a></td>   
  </tr>
</table>
</div>
<div class="clear35"></div>
<div class="main">
    <#if miao_goods_page??>
        <#list miao_goods_page.content as item>
        <script>
$(document).ready(function(){
    setInterval("timer${item_index}()",1000);
});

function timer${item_index}()
{
<#if item.isFlashSale && item.flashSaleStartTime < .now && item.flashSaleStopTime gt .now>
    var ts = (new Date(${item.flashSaleStopTime?string("yyyy")}, 
                parseInt(${item.flashSaleStopTime?string("MM")}, 10)-1, 
                ${item.flashSaleStopTime?string("dd")}, 
                ${item.flashSaleStopTime?string("HH")}, 
                ${item.flashSaleStopTime?string("mm")}, 
                ${item.flashSaleStopTime?string("ss")})) - (new Date());//计算剩余的毫秒数
    if (0 == ts)
    {
        window.location.reload();
    }
    
    var date = new Date();
    var dd = parseInt(ts / 1000 / 60 / 60 / 24, 10);//计算剩余的天数
    var hh = parseInt(ts / 1000 / 60 / 60 % 24, 10);//计算剩余的小时数
    var mm = parseInt(ts / 1000 / 60 % 60, 10);//计算剩余的分钟数
    var ss = parseInt(ts / 1000 % 60, 10);//计算剩余的秒数
    dd = checkTime(dd);
    hh = checkTime(hh);
    mm = checkTime(mm);
    ss = checkTime(ss);
    
    $("#lday${item_index}").html(dd);
    $("#lhour${item_index}").html(hh);
    $("#lmin${item_index}").html(mm);
    $("#lsec${item_index}").html(ss);
</#if>
}

function checkTime(i)  
{  
    if (i < 10) {  
        i = "0" + i;  
    }  
    return i;  
}
</script>
            <a class="phone_list" href="/touch/goods/${item.id?c!''}?qiang=1">
                <b><img src="${item.coverImageUri!''}" width="90" height="90"/></b>
                <p class="p1">${item.title!''}</p>
                <p>${item.subTitle!''}</p>
                <p class="fl">累计评价：<span class="red">${item.totalComments!'0'}条</span></p>
          <#--      <p class="daojishi" id="timeLeft${item_index}"></p> -->
                <p class="daojishi"><span class="sp1" id="lday${item_index}">0</span><span class="fl" style="padding-top:5px">天</span><span class="sp1" id="lhour${item_index}">0</span><span class="fl"> : </span><span class="sp1" id="lmin${item_index}">0</span><span class="fl"> : </span><span class="sp1" id="lsec${item_index}">0</b><span class="fl"> : </span></span>
                <p class="p2 ta-r mt20">抢拍价￥<#if item.flashSalePrice??>${item.flashSalePrice?string("0.00")}</#if></p>
                <div class="clear"></div>
            </a>
        </#list>
    </#if>
 <#--> <a class="grey_more" href="#"><img src="images/more.png" /></a> -->
  <div class="clear20"></div>
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
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/promotion/miao">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
