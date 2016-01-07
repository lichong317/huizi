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

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>优惠券</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <div class="clear15"></div>
  
  <table class="jifen">       
      <tr>
            <td>面值</td>
            <td>所需消费金额</td>
            <td>使用限制</td>
            <td colspan="2">状态</td>
            <#--<th align="left">&nbsp;</th> -->
      </tr>      
      <#if coupan_list??>
                <#list coupan_list as item>
                    <tr>
                      <td>￥${item.price?string("0.00")!'' } </td>
                      <td> ￥${item.price?string("0.00")!'' } </td>
                      <td> ${item.typeDescription!'' } </td>
                      <td> 
                      <a title="${item.getTime?string("yyyy-MM-dd")!'' }至${item.expireTime?string("yyyy-MM-dd")!'' }">
                          <#if item.isUsed?? && item.isUsed>
                             已使用  
                          <#elseif item.hourLeft gt 0 >
                                  <#if item.dateLeft lt 4 &&  item.dateLeft gt -1>
                                    即将到期（<b style="color:red;">${ item.hourLeft?c!'' }&nbsp;</b>小时）
                                  <#elseif  item.dateLeft gt 3>
                                     还有<b style="color:green;">&nbsp;${item.dateLeft?c!''}&nbsp;</b>天到期
                                  </#if>
                          <#elseif item.hourLeft lt 0 ||item.hourLeft = 0>
                              已过期 
                          </#if>  
                      </a>
                          
                      </td>
                      <td><a href="/touch"  class="ftx-05" target="_blank">去购物&gt;</a><br />
                        <a  href="javascript:coupondel(${item.id?c},${listId?c});" class="ftx-05 dellink"  <#if (!item.isUsed??||!item.isUsed)&&item.hourLeft gt 0>onclick="javascript:coupondelcfm();"</#if> >删除</a> </td>
                    </tr>
                </#list>
      </#if>        
  </table>  
  
</div><!--main END-->
<#if !app??>
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
    <a class="fs09" href="/user/coupon/list/0">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div>
</#if>
</body>
</html>
