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
<script type="text/javascript">
$(document).ready(function(){
    menuClassHeight("#choose_con","#choose_tit","#choose_bot");
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

<style>
.grey_more{ width:94%;
    display:block;
    border:none;
    font-family:"微软雅黑";
    font-size:1em;
    cursor:pointer;
    text-align:center;
    color:#fff;
    line-height:40px;
    height:40px;
    margin:20px auto 30px;}
</style>

<body>
<header class="comhead">
   <form action="/touch/search" method="get">
      <section class="topsearch">   
        <input name="keywords" type="text" class="text" placeholder="搜索关键字" />
        <input type="submit" class="sub" value=" " /> 
      </section>
  </form>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="#" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<section class="listhead tabfix w100">
  <menu>
    <li <#if st==0>class="sel"<#else></#if>>
      <a href="/touch/search?keywords=${keywords!''}&page=0&st=0&<#if sd?? && sd==0>sd=1<#else>sd=0</#if>"><#if st==0><#if sd=0><span>销量</span><#else><span style="display:inline-block; padding-left:0.2rem; background:url(/touch/images/sorting02.png) no-repeat left center; background-size:auto 0.2rem;">销量</span></#if><#else>销量</#if></a>
    </li>
    <li <#if st==1>class="sel"<#else></#if>>
      <a href="/touch/search?keywords=${keywords!''}&page=0&st=1&<#if sd?? && sd==0>sd=1<#else>sd=0</#if>"><#if st==1><#if sd=0><span>价格</span><#else><span style="display:inline-block; padding-left:0.2rem; background:url(/touch/images/sorting02.png) no-repeat left center; background-size:auto 0.2rem;">价格</span></#if><#else>价格</#if></a>
    </li>
    <li <#if st==2>class="sel"<#else></#if>>
      <a href="/touch/search?keywords=${keywords!''}&page=0&st=2&<#if sd?? && sd==0>sd=1<#else>sd=0</#if>"><#if st==2><#if sd=0><span>上架时间</span><#else><span style="display:inline-block; padding-left:0.2rem; background:url(/touch/images/sorting02.png) no-repeat left center; background-size:auto 0.2rem;">上架时间</span></#if><#else>上架时间</#if></a>
    </li>
  </menu>
</section>


<menu id="goods-menu">
    <#if goods_page??>
        <#list goods_page.content as item>
            <a href="/touch/goods/${item.id?c!''}" class="prolist mainbox bot-border">
              <b class="img"><img src="${item.coverImageUri!''}" /></b>
              <section>
              <p class="h07 oh">${item.title!''}</p>
              <p class="red mt20">￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></p>
              </section>
              <div class="clear"></div>
            </a>
        </#list>
    </#if>   
</menu>
    <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>

  
</body>
</html>
