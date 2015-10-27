<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if productCategory??>${productCategory.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="<#if productCategory??>${productCategory.seoKeywords!''}</#if>">
<meta name="description" content="<#if productCategory??>${productCategory.seoDescription!''}</#if>">
<meta name="copyright" content="<#if site??>${site.copyright!''}</#if>" />
<!--[if IE]>
   <script type="text/javascript" src="/client/js/html5.js"></script>
<![endif]-->
<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/list.js"></script>
<script src="/client/js/goods.js"></script>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script type="text/javascript">
  $(document).ready(function(){
	menuDownList("top_phone","#top_phonelist",".a1","sel");
	phoneListMore();//单独下拉
    menuDownList("top_order","#top_orderlist",".a4","sel");//顶部下拉
	searchTextClear(".toptext","请输入品牌或商品名称","#999","#666");
	searchTextClear(".bottext","查看所有门店","#fff","#fff");
	checkNowHover("shopping_down","shopping_sel");
	navDownList("navdown","li",".nav_showbox");
	menuDownList("mainnavdown","#navdown",".a2","sel");
	
	chooseMoreShow();	
});

function setprice() {
    var p1 = $.trim($('#ParamFiltern_price1').val()), p2 = $.trim($('#ParamFiltern_price2').val())
    if (isNaN(p1) || p1=="") { p1 = 0 }
    if (isNaN(p2) || p2== "") { p2 = 0 }
    var price = p1 + '-' + p2;
    var url = "/list/${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}";
    if (price != "0-0") { url += "_" + price; }
    location.href = url;
}

function btnPageSubmit() 
{
    var page = $('#iPageNum').val();
    if (isNaN(page) || page=="" ){ page = 1 }
    window.location.href = "${categoryId!'0'}-${brandIndex!0}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-"
    + (page - 1)
    + "-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string('#.##')}-${priceHigh?string('#.##')}</#if>";
}
</script>
</head>

<body>
<#include "/client/common_header.ftl" />

<div class="clear h20"></div>

<div class="main">
<div class="weizhi">
    <span><a href="/">首页</a></span>
    <#if category_tree_list??>
        <#list category_tree_list as category>
            > <span><a href="/list/${category.id}">${category.title!""}</a></span>
        </#list>
    </#if>
</div>
<section class="column_left mt20">
    <h3 class="tit">热卖排行</h3>
    <menu class="border-df">
        <#if most_sold_list??>
            <#list most_sold_list as item>
                <#if item_index < 5>
                    <a class="scan" href="/goods/${item.id?c}">
                        <img src="${item.coverImageUri!''}" height="80" width="80"  title="${item.title!''} ${item.subTitle!''}"/>
                        <div class="num1">${item_index+1}</div>
                        <p style="overflow: hidden;height: 60px;">${item.title!""} </p>
                        <p class="red">￥${item.salePrice?string("0.00")}</p>
                    </a>
                </#if>
            </#list>
        </#if>
    </menu>
    <h3 class="tit">新品推荐</h3>
    <menu class="border-df">
        <#if newest_list??>
            <#list newest_list as item>
              <#if item_index < 4>
                <li>
                    <a href="/goods/${item.id?c}"><img src="${item.coverImageUri!''}" height="177" width="177" title="${item.title!''} ${item.subTitle!''}"/></a>
                    <a href="/goods/${item.id?c}" style="overflow: hidden;height: 60px;">${item.title!""} ${item.version!""} ${item.color!""} ${item.capacity!""}</a>
                    <p class="fs18 red ta-c">￥${item.salePrice?string("0.00")}</p>
                </li>
              </#if>
            </#list>
        </#if>
    </menu>
</section><!--column_left END-->
  
  <div class="column_right mt20">
    <h3 class="screen_clear">
      商品筛选
      <a class="a1" href="${categoryId!'0'}-0<#list param_index_list as pindex>-0</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-0">清空筛选条件</a>
    </h3>
    <table class="screen_tab">
    <#-- 品牌开始 -->
    <#if brand_list??>
        <tr>
            <td><a href="${categoryId!'0'}-0<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if brandIndex==0>class="sel"</#if>>全部品牌</a></td>
            <#list brand_list as brand>
                <#if brand_index < 13>
                    <#if brand_index%7 ==5>
                        <td><a href="${categoryId!'0'}-${brand_index+1}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if brandIndex==brand_index+1>class="flhover"</#if>><img src="${brand.logoUri!''}"  height="34" width="96" title="${brand.title?trim!''}" alt="${brand.title?trim!''}"/></a></td>
                        </tr>
                    <#elseif brand_index%7 ==6>
                        <tr>
                        <td><a href="${categoryId!'0'}-${brand_index+1}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if brandIndex==brand_index+1>class="flhover"</#if>><img src="${brand.logoUri!''}"  height="34" width="96" title="${brand.title?trim!''}" alt="${brand.title?trim!''}"/></a></td>                    
                    <#else>
                        <td><a href="${categoryId!'0'}-${brand_index+1}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if brandIndex==brand_index+1>class="flhover"</#if>><img src="${brand.logoUri!''}"  height="34" width="96" title="${brand.title?trim!''}" alt="${brand.title?trim!''}"/></a></td> 
                    </#if>
                </#if>
            </#list>
        
    </#if>
    <#-- 品牌结束 -->
    </table>
    <section class="choose_box">
        <#-- 参数开始 -->
        <#if param_list??>
            <#list param_list as param>
                <menu>
                    <h4>${param.title!""}：</h4>
                    <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex><#if param_index==pindex_index>-0<#else>-${pindex!'0'}</#if></#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if param_index_list[param_index]==0>class="sel"</#if>>全部</a>
                    <#if param.valueList??>
                        <#list param.valueList?split(",") as value>
                            <#if value!="">
                                <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex><#if param_index==pindex_index>-${value_index+1}<#else>-${pindex!'0'}</#if></#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if param_index_list[param_index]==value_index+1>class="sel"</#if>>${value?trim!""}</a>
                            </#if>
                        </#list>
                    </#if>
                </menu>
            </#list>
        </#if>
        <#-- 参数结束 -->
        
        <#if param_list?? && param_list?size gt 4>
            <div class="choose_more"><a href="javascript:chooseMoreDown();">下拉，更多选项<img src="/client/images/content/arrow01.png" /></a></div>
        </#if>
    </section><!--choose_box-->
    <div class="clear h20"></div>
    
    <section class="column_px">
      <menu>
        <a <#if orderId==0><#if sort_id_list[0]==0>class="sel01"<#else>class="sel02"</#if></#if> href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-0<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==0><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>销量</span></a>
        <a <#if orderId==1><#if sort_id_list[1]==0>class="sel01"<#else>class="sel02"</#if></#if> href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-1<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==1><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>价格</span></a>
        <a <#if orderId==2><#if sort_id_list[2]==0>class="sel01"<#else>class="sel02"</#if></#if> href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-2<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==2><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>上架时间</span></a>  
        <a <#if orderId==3><#if sort_id_list[3]==0>class="sel01"<#else>class="sel02"</#if></#if> href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-3<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==3><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>人气</span></a> 
        <a <#if orderId==4><#if sort_id_list[4]==0>class="sel01"<#else>class="sel02"</#if></#if> href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-4<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==4><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>评价</span></a>     
        <div class="sxtjBox">
                    <span>价格范围：</span>
                    <input type="text" id="ParamFiltern_price1" class="jgqj_txt" value="<#if priceLow??>${priceLow?string("#.##")}</#if>"/>
                    <span>--</span>
                    <input type="text" id="ParamFiltern_price2" class="jgqj_txt" value="<#if priceHigh??>${priceHigh?string("#.##")}</#if>"/>
                    <input type="submit" class="jgqj_btn" onclick="setprice()" value="确定" />
        </div>
      </menu>
      <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-<#if !leftId?? || leftId==0>1<#else>0</#if><#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><b <#if leftId?? && leftId==1>class="zyon"<#else>class="zy"</#if> ></b></a>
      <div class="dd">仅显示有货</div>
      <div class="fr">
        
        <#if goods_page.number+1 == goods_page.totalPages || goods_page.totalPages==0>
            <a href="javascript:;"><img src="/client/images/content/page_n.png" height="11" /></a>
        <#else>
            <a href="${categoryId!'0'}-${brandIndex!0}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${goods_page.number+1}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><img src="/client/images/content/page_n.png" height="11" /></a> <#-- goods_page.number+1 -->
        </#if>
                
        <#if goods_page.number+1 == 1>
            <a href="javascript:;"><img src="/client/images/content/page_l.png" height="11" /></a>
        <#else>
            <a href="${categoryId!'0'}-${brandIndex!0}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${goods_page.number-1}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><img src="/client/images/content/page_l.png" height="11" /></a> <#-- goods_page.number-1 -->
        </#if>
        <span><font class="fc"><#if goods_page.totalPages==0>0<#else>${goods_page.number+1}</#if></font>/${goods_page.totalPages!"0"}页</span>
      </div>
      <div class="clear"></div>
    </section>
    
    <ul class="column_sum">
        <#if goods_page?? && goods_page.content?size gt 0>
            <#list goods_page.content as goods>
                <li>
                    <a class="a1" href="/goods/${goods.id?c}"><img src="${goods.coverImageUri!''}" height="210" width="210" title="${goods.title!''} ${goods.subTitle!''}"/></a>
                    <a class="block h40" href="/goods/${goods.id?c}" style="overflow: hidden;height: 40px;">${goods.title!""} ${goods.version!""} ${goods.color!""} ${goods.capacity!""}</a>
                    <p class="fs26 lh35 red">￥${goods.salePrice?string("0.00")}</p>
                    <span class="pl"><img src="/client/images/images/pl_07.png" /></span>
                    <p class="fs12 lh13"><span><a href="/goods/${goods.id?c}#commentDiv">${goods.totalComments!"0"}</a></span>条</p>
                    <div>
                      <a class="a2" href="/cart/init?id=${goods.id?c}" target="_blank">加入购物车</a>
                      <a class="a3" href="javascript:addCollect(${goods.id?c});">收藏</a>
                      <p class="clear"></p>
                    </div>
                </li>
            </#list>
        <#else>
                <div style="text-align: center; padding: 15px;">此类商品正在扩充中，敬请期待！</div>
        </#if>   
    </ul>
    <div class="clear h20"></div>
       
    <div class="pagebox">
      <div class="num">
        <#if goods_page??>
            <#assign continueEnter=false>
            <#if goods_page.number+1 == 1>
                <a class="a1 a0" href="javascript:;"><span>上一页</span></a>
            <#else>
                <a class="a1 a0" href="${categoryId!'0'}-${brandIndex!0}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${goods_page.number-1}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>上一页</span></a>
            </#if>
            
            <#if goods_page.totalPages gt 0>
                <#list 1..goods_page.totalPages as page>
                    <#if page <= 3 || (goods_page.totalPages-page) < 3 || (goods_page.number+1-page)?abs<3 >
                        <#if page == goods_page.number+1>
                            <a class="sel" href="javascript:;">${page}</a>
                        <#else>
                            <a href="${categoryId!'0'}-${brandIndex!0}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${page-1}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>">${page}</a> <#-- ${page} -->
                        </#if>
                        <#assign continueEnter=false>
                    <#else>
                        <#if !continueEnter>
                            <span> ... </span>
                            <#assign continueEnter=true>
                        </#if>
                    </#if>
                </#list>
            </#if>
            
            <#if goods_page.number+1 == goods_page.totalPages || goods_page.totalPages==0>
                <a class="a2" href="javascript:;"><span>下一页</span></a>
            <#else>
                <a class="a2" href="${categoryId!'0'}-${brandIndex!0}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${goods_page.number+1}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>下一页</span></a>
            </#if>
        </#if>
        <span> 共<b>${goods_page.totalPages}</b>页 </span>
      </div>
      <div class="page">
        <input class="sub" type="submit" onclick="javascript:btnPageSubmit();" value="确定" />
        <span>页</span>
        <input class="text" type="text" value="${pageId + 1}" id="iPageNum"/>
        <span>到第</span>
      </div>
      <div class="clear"></div>
    </div><!--pagebox END-->
    
  </div><!--column_right END-->
  
</div>
<div class="clear h40"></div>

<#include "/client/common_footer.ftl" />

</div>

</body>
</html>
