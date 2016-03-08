<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if productCategory??>${productCategory.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="<#if productCategory??>${productCategory.seoKeywords!''}</#if>">
<meta name="description" content="<#if productCategory??>${productCategory.seoDescription!''}</#if>">
<meta name="copyright" content="<#if site??>${site.copyright!''}</#if>" />
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
        url:"/touch/search?keywords=${keywords!''}&page=" + pageIdx + "&st=${st!''}&sd=${sd!''}",
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
</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>搜索结果</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="list_top">
<table class="main">
  <tr>    
    <td <#if st==0>class="sel"</#if>><a  href="/touch/search?keywords=${keywords!''}&page=0&st=0&<#if sd?? && sd==0>sd=1<#else>sd=0</#if>"><span>价格</span></a></td>
    <td <#if st==1>class="sel"</#if>><a  href="/touch/search?keywords=${keywords!''}&page=0&st=1&<#if sd?? && sd==0>sd=1<#else>sd=0</#if>"><span>销量</span></a></td>
    <td <#if st==2>class="sel"</#if>><a  href="/touch/search?keywords=${keywords!''}&page=0&st=2&<#if sd?? && sd==0>sd=1<#else>sd=0</#if>"><span>上架时间</span></a></td>
  </tr>
</table>
</div>
<div class="clear35"></div>
<div class="main"  >
    <menu id="goods-menu">
        <#if goods_page??>
            <#list goods_page.content as item>
                <a class="phone_list" href="/touch/goods/${item.id?c!''}">
                    <b><img src="${item.coverImageUri!''}" width="91" height="91"/></b>
                    <p class="p1">${item.title!''}</p>
                    <p>${item.subTitle!''}</p>
                    <p class="fl">累计评价：<span class="red">${item.totalComments!'0'}条</span></p>
                    <p class="p2 ta-r mt20">￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></p>
                    <div class="clear"></div>
                </a>
            </#list>
        </#if>  
    </menu>
  <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>
  <div class="clear20"></div>
</div><!--main END-->

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
    <a class="fs09" href="/">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
