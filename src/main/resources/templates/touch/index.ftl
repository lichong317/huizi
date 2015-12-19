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
<script type="text/javascript">
  $(document).ready(function(){
   indexBanner("box","sum",300,5000,"num");
});
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <table class="indextop">
      <tr>
        <td class="pt10" width="35%"><img src="/touch/images/images/index_03.png" height="50%" /></td>
        <td style="padding-top:7px;">
        <form action="/touch/search" method="get">
          <div class="topsearch"><input class="text" type="text" name="keywords"/><input class="sub" type="submit" value=" " /></div>
        </form>
        </td>
      </tr>
    </table> 
    <a class="a2" href="#"><img src="/touch/images/images/yo_03.png" height="33" /></a>
  </div>
</header>

<section id="box">
  <ul id="sum">
    <#if banner_ad_list??>
        <#list banner_ad_list as item>
            <li><a href="${item.linkUri!''}"><img src="${item.fileUri!''}" width="343" height="160"/></a></li>
        </#list>
    </#if>   
  </ul>
  <div class="clear"></div>
</section><!--我是banner-->

<div class="main">
  <div class="clear10"></div>
  <section class="index_part">
    <table class="comtab indexnav">
      <tr>
        <td><a class="a1" href="/touch/user">会员中心</a></td>
        <td><a class="a2" href="/touch/user/order/list/0">我的订单</a></td>
        <td><a class="a3" href="/touch/cart">购物车</a></td>
        <td><a class="a4" href="/touch/shop/list">门店查询</a></td>
        <td><a class="a5" href="#">客户端</a></td>
      </tr>
    </table>
  </section>
  <section class="index_part">
    
    <table class="index_list">
      <tbody><tr>
        <td rowspan="2">
        <#if top_ad_list??>
            <#list top_ad_list as item>
                <#if item_index < 1>
                  <a href="${item.linkUri!''}">
                    <p class="ta-c"><img src="${item.fileUri!''}" width="154" height="248"></p>
                  </a>
                </#if>
            </#list>
        </#if>
        </td>
        <td>
        <#if top_ad_list??>
            <#list top_ad_list as item>
                <#if item_index gt 0 && item_index < 2>
                  <a href="${item.linkUri!''}">
                    <p class="ta-r"><img src="${item.fileUri!''}" width="154" height="100"></p>
                  </a>
                </#if>
            </#list>
        </#if>          
        </td>
      </tr>
      <tr>
        <td>
        <#if top_ad_list??>
            <#list top_ad_list as item>
                <#if item_index gt 1 && item_index < 3>
                  <a href="${item.linkUri!''}">
                    <p class="ta-l"><img src="${item.fileUri!''}" width="154" height="138"></p>
                  </a>
                </#if>
            </#list>
        </#if>          
        </td>
      </tr>
    </tbody></table>
    
  </section>
  <section class="index_part">
    <h3 class="index_tit">
      <b></b>
      <span class="fl">热卖推荐</span>
      <p class="clear"></p>
      <a class="a1" href="/touch/category/list">更多+</a>
    </h3>
    
    <table class="index_list">    
      <tr>
      <#if hot_sale_list??>
        <#list hot_sale_list as item>
            <#if item_index gt 2 && item_index < 6>
            <td>
              <a href="/touch/goods/${item.id?c}">
                <p class="ta-c"><img src="${item.coverImageUri!''}" width="90" height="90" /></p>
                <p style=" height: 40px;overflow: hidden;">${item.name!''}</p>
                <span class="red">¥：<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></span>
              </a>
            </td>
            </#if>
        </#list>
      </#if>      
      </tr>
    </table>
    
  </section>
  
  <section class="index_part">
    <h3 class="index_tit">
      <b></b>
      商品推荐
    </h3>
        <table class="index_list_b"/>
        <tr>
        <#if goodsRecommend_ad_list??>
            <#list goodsRecommend_ad_list as item>
                <#if item_index < 2>
                <td>
                  <a href="${item.linkUri!''}">
                    <div class="se${item_index}"><p>${item.title!''}</p></div>
                    <div class="se${item_index}bg"><span>${item.subtitle!''}</span></div>
                    <p class="ta-c"><img src="${item.fileUri!''}" width="163" height="75" /></p>
                  </a>
                </td>
                </#if>
            </#list>
        </#if>
      </tr>   
      </table> 
    <table class="index_list_b">    
      <tr>
      <#if goodsRecommend_ad_list??>
          <#list goodsRecommend_ad_list as item>
               <#if item_index gt 1 && item_index < 5>
                   <td>
                      <a href="${item.linkUri!''}">
                        <div class="se${item_index}"><p>${item.title!''}</p></div>
                       <div class="se${item_index}bg"><span>${item.subtitle!''}</span></div>
                        <p class="ta-c"><img src="${item.fileUri!''}" width="109" height="90" /></p>
                      </a>
                   </td>
               </#if>
          </#list>
      </#if>
      </tr>
    </table>
    
  </section>
  
  <section class="index_part">
    <h3 class="index_tit">
      <b></b>
      精选分类
      <a class="a1" href="/touch/category/list">更多+</a>
    </h3>
    
    <table class="index_list">
<#-->    <#if top_cat_list??>
        <#list top_cat_list as item>
            <#if item_index % 2 == 0>
                <tr>
                    <td>
                      <a href="/touch/list/${item.id?c}">
                        <div class="fenleiwenzi"><h4>${item.title!''}</h4>
                        <p>${item.subtitle!''}</p></div>
                        <div class="fenleitupian">
                        <p class="ta-r"><img src="${item.imgUrl!''}"width="39" height="39" /></p>
                      </div>
                      </a>
                    </td>
            <#else>
                    <td>
                      <a href="/touch/list/${item.id?c}">
                        <div class="fenleiwenzi"><h4>${item.title!''}</h4>
                        <p>${item.subtitle!''}</p></div>
                        <div class="fenleitupian">
                        <p class="ta-r"><img src="${item.imgUrl!''}"width="39" height="39" /></p>
                      </div>
                      </a>
                    </td>
                </tr>
            </#if>
        </#list>
    </#if>   -->  
    <#if selection_ad_list??>
        <#list selection_ad_list as item>
            <#if item_index % 2 == 0>
                <tr>
                    <td>
                      <a href="${item.linkUri!''}">
                        <div class="fenleiwenzi"><h4 style=" height: 17px;overflow: hidden;">${item.title!''}</h4>
                        <p style=" height: 20px;overflow: hidden;">${item.subtitle!''}</p></div>
                        <div class="fenleitupian">
                        <p class="ta-r"><img src="${item.fileUri!''}"width="39" height="39" /></p>
                      </div>
                      </a>
                    </td>
            <#else>
                    <td>
                      <a href="${item.linkUri!''}">
                        <div class="fenleiwenzi"><h4 style=" height: 17px;overflow: hidden;">${item.title!''}</h4>
                        <p style=" height: 20px;overflow: hidden;">${item.subtitle!''}</p></div>
                        <div class="fenleitupian">
                        <p class="ta-r"><img src="${item.fileUri!''}"width="39" height="39" /></p>
                      </div>
                      </a>
                    </td>
                </tr>
            </#if>
        </#list>
    </#if>  
  </table>
    
  </section>
  
    <section class="index_part">
    <h3 class="index_tit">
      <b></b>
      <span class="fl">热卖排行</span>
      <p class="clear"></p>
      <a class="a1" href="/touch/category/list">更多+</a>
    </h3>
    
    <table class="index_list">
      <tr>
      <#if hot_sale_list??>
        <#list hot_sale_list as item>
            <#if item_index < 3>
            <td>
              <a href="/touch/goods/${item.id?c}">
                <p class="ta-c"><img src="${item.coverImageUri!''}" width="90" height="90"  /></p>
                <p style=" height: 40px;overflow: hidden;">${item.name!''}</p>
                <span class="red">¥：<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></span>
              </a>
            </td>
            </#if>
        </#list>
      </#if>           
      </tr>
    </table>
    
  </section>
  
  
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
    <a class="fs09" href="/">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div>
<aside class="check_more" style="display:;">
  <div class="list">
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
    <a href="#">我是地区名字</a>
  </div>
</aside>
</body>
</html>
