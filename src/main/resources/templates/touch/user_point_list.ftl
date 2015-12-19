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
<script src="/client/js/mymember.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>积分明细</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <div class="clear15"></div>
  <p class="lh40"> 积分记录 可用积分<span class="red"><#if point_page?? && point_page.content?? && point_page.content[0]??>${point_page.content[0].totalPoint!'0'}<#else>0</#if></span>个 
       <div class="clear"></p>
  </div>
  <table class="jifen">
        <tr>
                <td>日期</td>
                <td>收入/支出</td>
                <td>涉及订单号</td>
                <td>详细说明</td>
        </tr>

      <#if point_page??>
            <#list point_page.content as point>
                  <tr>
                        <td style="">${point.pointTime[0..8]?default("")}</td>
                        <td>
                            <#if point.point??><#if point.point gt 0>+</#if>${point.point}</#if>                                                          </td>
                        </td>
                        <td>${point.orderNumber!''}</td>
                        <td>${point.detail!''}</td>
                   </tr>
            </#list>
      </#if>       
  </table>  
  
</div><!--main END-->

<section class="botmain">
  <div class="main">
  <div class="center">
    <a class="absolute-r" href="javascript:$('html,body').animate({scrollTop:0},500);">返回顶部</a>
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user/point/list">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div>
</body>
</html>
