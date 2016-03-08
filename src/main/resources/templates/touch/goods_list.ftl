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
        url:"/touch/list/more/${categoryId!'1'}-${orderId?c!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-" + pageIdx,
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
    <li <#if orderId==0><#if sort_id_list[0]==0>class="sel"<#else>class="sel"</#if></#if>>
      <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-0<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==0><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><#if orderId==0><#if sort_id_list[0]==0><span>综合</span><#else><span style="display:inline-block; padding-left:0.2rem; background:url(/touch/images/sorting02.png) no-repeat left center; background-size:auto 0.2rem;">综合</span></#if><#else>综合</#if></a>
    </li>
    <li <#if orderId==1><#if sort_id_list[1]==0>class="sel"<#else>class="sel"</#if></#if>>
      <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-1<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==1><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><#if orderId==1><#if sort_id_list[1]==0><span>价格</span><#else><span style="display:inline-block; padding-left:0.2rem; background:url(/touch/images/sorting02.png) no-repeat left center; background-size:auto 0.2rem;">价格</span></#if><#else>价格</#if></a>
    </li>
    <li <#if orderId==2><#if sort_id_list[2]==0>class="sel"<#else>class="sel"</#if></#if>>
      <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-2<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==2><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><#if orderId==2><#if sort_id_list[2]==0><span>销量</span><#else><span style="display:inline-block; padding-left:0.2rem; background:url(/touch/images/sorting02.png) no-repeat left center; background-size:auto 0.2rem;">销量</span></#if><#else>销量</#if></a>
    </li>
    <li >
      <a href="javascript:;" onclick="$('.winbg').fadeToggle(200);">筛选</a>
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


<aside class="winbg" style="display:none">
  <div class="choosebox">
    <a class="close" href="javascript:void(0);" onClick="$(this).parent().parent().fadeOut(200);"><img src="/touch/images/close.png" /></a>
    <section class="tit" id="choose_tit">商品筛选<input type="submit" value="确 定" class="sub" /></section>
    <section class="con" id="choose_con">
      <h3>品牌：</h3>
      <#if brand_list??>
          <a <#if brandIndex==0>class="a1 a1sel"<#else>class="a1"</#if> href="${categoryId!'0'}-0<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>">全部</a>
          <#list brand_list as brand>
               <#if brand_index < 6>
                    <a <#if brandIndex==brand_index+1>class="a1 a1sel"<#else>class="a1"</#if> href="${categoryId!'0'}-${brand_index+1}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>">${brand.title?trim!''}</a>
               </#if>              
          </#list>
      </#if>
      
      <#if param_list??>
       <#list param_list as param>
           <h3>${param.title!""}：</h3>
           <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex><#if param_index==pindex_index>-0<#else>-${pindex!'0'}</#if></#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if param_index_list[param_index]==0>class="a1 a1sel"<#else>class="a1"</#if>>全部</a>
           <#if param.valueList??>
                    <#list param.valueList?split(",") as value>
                            <#if value!="" && value_index < 6>
                                <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex><#if param_index==pindex_index>-${value_index+1}<#else>-${pindex!'0'}</#if></#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if param_index_list[param_index]==value_index+1>class="a1 a1sel"<#else>class="a1"</#if>>${value?trim!""}</a>
                            </#if>
                    </#list>
            </#if>
       </#list>
      </#if>
      <div class="clear h03" style="height:0.8rem"></div>
    </section>
    <div class="w100 h05" id="choose_bot"></div>
  </div>
</aside>

  
</body>
</html>
