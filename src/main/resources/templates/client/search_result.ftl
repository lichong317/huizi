<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="<#if site??>${site.copyright!''}</#if>" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/list.js"></script>
<script src="/client/js/goods.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<script>
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
    var url = '/list/' + $('#urlcoll').val();
    if (price != "0-0") { url += "_" + price; }
    location.href = url;
}
function btnPageSubmit() 
{
    window.location.href = "/search?keywords=${keywords!''}&page="
    + (parseInt($('#iPageNum').val()) - 1);
}
</script>
</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="clear h20"></div>

<div class="main">
    <div class="weizhi">
        <span><a href="/">首页</a></span>
        > <a href="javascript:;" class="hover_zy">搜索结果</a>
    </div>
    
    <section class="column_left mt20">
        <h3 class="tit">热卖排行</h3>
        <menu class="border-df">
            <#if most_sold_list??>
                <#list most_sold_list as item>
                    <#if item_index < 5>
                        <a class="scan" href="/goods/${item.id?c}">
                            <img src="${item.coverImageUri!''}" height="80" width="80" title="${item.title!''} ${item.subTitle!''}"/>
                            <div class="num1">${item_index+1}</div>
                            <p>${item.title!""} ${item.version!""} ${item.color!""} ${item.capacity!""}</p>
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
                        <a href="/goods/${item.id?c}">${item.title!""} ${item.version!""} ${item.color!""} ${item.capacity!""}</a>
                        <p class="fs18 red ta-c">￥${item.salePrice?string("0.00")}</p>
                    </li>
                  </#if>
                </#list>
            </#if>
        </menu>
    </section><!--column_left END-->
      <div class="column_right mt20">
        <div class="clear h20"></div>
         <section class="column_px">     
              <div class="fr">
                
                <#if goods_page.number+1 == goods_page.totalPages || goods_page.totalPages==0>
                    <a href="javascript:;"><img src="/client/images/content/page_n.png" height="11" /></a>
                <#else>
                    <a href="/search?keywords=${keywords!''}&page=${goods_page.number+1}"><img src="/client/images/content/page_n.png" height="11" /></a> <#-- goods_page.number+1 -->
                </#if>
                        
                <#if goods_page.number+1 == 1>
                    <a href="javascript:;"><img src="/client/images/content/page_l.png" height="11" /></a>
                <#else>
                    <a href="/search?keywords=${keywords!''}&page=${goods_page.number-1}"><img src="/client/images/content/page_l.png" height="11" /></a> <#-- goods_page.number-1 -->
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
                        <a class="block h40" href="/goods/${goods.id?c}">${goods.title!""} ${goods.version!""} ${goods.color!""} ${goods.capacity!""}</a>
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
                            <a class="a1 a0" href="/search?keywords=${keywords!''}&page=${goods_page.number-1}"><span>上一页</span></a>
                        </#if>
                        
                        <#if goods_page.totalPages gt 0>
                            <#list 1..goods_page.totalPages as page>
                                <#if page <= 3 || (goods_page.totalPages-page) < 3 || (goods_page.number+1-page)?abs<3 >
                                    <#if page == goods_page.number+1>
                                        <a class="sel" href="javascript:;">${page}</a>
                                    <#else>
                                        <a href="/search?keywords=${keywords!''}&page=${page-1}">${page}</a> <#-- ${page} -->
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
                            <a class="a2" href="/search?keywords=${keywords!''}&page=${goods_page.number+1}"><span>下一页</span></a>
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
        </div>
        <!--右边结束-->
        <div class="clear"></div>
 </div>  
<!--主体结束-->
<article id="main">
<#--
  <div class="look fl mt20">
    	<h4><b>|</b>大家都在看</h4>
      <ul class="mt15">
       	  <li>
          <a href="#"><img src="/client/images/img3.jpg" width="220" height="220"></a>
          <dd>￥99.00<del>￥198.00</del></dd>
          <p><a href="#">蕾丝连衣裙女2015春装新款韩版修身气质裙子娃娃领雪纺短袖连衣裙 粉紫色 XL</a></p>
          </li>
       	  <li>
          <a href="#"><img src="/client/images/img3.jpg" width="220" height="220"></a>
          <dd>￥99.00<del>￥198.00</del></dd>
          <p><a href="#">蕾丝连衣裙女2015春装新款韩版修身气质裙子娃娃领雪纺短袖连衣裙 粉紫色 XL</a></p>
          </li>
       	  <li>
          <a href="#"><img src="/client/images/img3.jpg" width="220" height="220"></a>
          <dd>￥99.00<del>￥198.00</del></dd>
          <p><a href="#">蕾丝连衣裙女2015春装新款韩版修身气质裙子娃娃领雪纺短袖连衣裙 粉紫色 XL</a></p>
          </li>
       	  <li>
          <a href="#"><img src="/client/images/img3.jpg" width="220" height="220"></a>
          <dd>￥99.00<del>￥198.00</del></dd>
          <p><a href="#">蕾丝连衣裙女2015春装新款韩版修身气质裙子娃娃领雪纺短袖连衣裙 粉紫色 XL</a></p>
          </li>
       	  <li>
          <a href="#"><img src="/client/images/img3.jpg" width="220" height="220"></a>
          <dd>￥99.00<del>￥198.00</del></dd>
          <p><a href="#">蕾丝连衣裙女2015春装新款韩版修身气质裙子娃娃领雪纺短袖连衣裙 粉紫色 XL</a></p>
          </li>
      </ul>
    </div>
-->
</article>
<!--大家都在看结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
