<script>
function move()
{
    $('html,body').animate({scrollTop:0},500);
}
</script> 
<div class="maintop">
<section class="main">
    <h1>亲，欢迎来到惠之店网上商城</h1>
    <p class="p2"><#if site??>${site.telephone!''}</#if></p>
    <p class="p3">服务热线：</p>
    <menu id="top_phone">
      <a class="a1" href="javascript:;">手机惠之店</a>
      <div class="clear"></div>
      <ul class="phone_sum" id="top_phonelist">
        <li style="padding-top:10px;"><a href="<#if site??>${site.touchUri!'/'}</#if>"><span class="phoneico01">触屏版</span></a></li>
        <li><a href="javascript:;"><span class="phoneico03">iPhone</span></a></li>
        <li style="border-bottom:1px solid #eee; padding-bottom:10px;"><a href="javascript:;"><span class="phoneico04">Android</span></a></li>
        <li class="phone_sum_more">
          <p>
            <span>扫描二维码下载iPhone客户端</span>
            <span class="mt5"><img src="<#if site??>${site.iOsQrCode!''}</#if>" /></span>
          </p>
          <p>
            <span>扫描二维码下载Android客户端</span>
            <span class="mt5"><img src="<#if site??>${site.androidQrCode!''}</#if>" /></span>
          </p>
        </li>
      </ul>
    </menu>
    <#if username??>
        <a class="a" href="/user" style="float:left; color:#ff4040;">${username}<i></i></a>
        <a class="a" href="/logout" style="float:left;">退出<i></i></a>
    <#else>
        <a class="a" href="/login" style="float:left; color:#ff4040;" target="_blank">登录<i></i></a>
        <a class="a" href="/reg<#if shareId??>?shareId=${shareId}"</#if>" style="float:left;" target="_blank">注册<i></i></a>
    </#if>
    <a class="a2" href="http://wpa.qq.com/msgrd?v=3&uin=${site.qq!''}&site=qq&menu=yes">在线咨询</a>
    <a class="a3" href="/user">会员俱乐部</a>
    <a class="z-in10" href="/info/list/12">帮助中心</a>
    <a class="a4" href="/user/order/list/0">我的订单<i></i></a>
    <div class="clear"></div>
</section>
</div>
<div class="top">
<div class="main top1">
<#--<div class="logo"><a href="/"><img src="<#if site??>${site.logoUri!''}</#if>" border="0" /></a></div> -->
<div class="logo"><a href="/" title="惠之店网上商城"><img src="<#if site??>${site.logoUri!''}</#if>" alt="惠之店网上商城" /></a></div>
<div class="ssbox">
    <div class="clear"></div>
    <form action="/search" method="get">
        <input type="text" class="ss_txt" name="keywords"/>
        <input type="submit" class="ss_btn" value="" />
    </form>
    <div class="clear"></div>
    <p>
        <#if keywords_list??>
            <#list keywords_list as item>
                <a href="${item.linkUri!''}">${item.title}</a>
            </#list>
        </#if>
    </p>
</div>
        
    <div id="shopping_down" class="shopping_box">
        <span class="sp1"><#if cart_goods_list??>${cart_goods_list?size}<#else>0</#if></span>
        <a class="a1" href="/cart">去购物车结算<i></i></a>
<menu>
      <#if cart_goods_list?? && cart_goods_list?size gt 0>
<script>
function delItem(id)
{
    if (null == id)
    {
        return;
    }
    
    $.ajax({
        type:"post",
        url:"/cart/del",
        data:{"id": id},
        success:function(data){
            location.reload();
        }
    });
}

</script>
          <#assign totalGoods=0>
          <#assign totalPrice=0>
          <h2>最新加入的商品</h2>
          <!-- lc-->
          <#list cart_goods_list as item>
                    <div class="shopping_list">

                        <div class="clear"></div>
                        <a class="a2" href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" /></a>
                        <a class="a3" href="/goods/${item.goodsId?c}">${item.goodsTitle!''}</a>
                        <p>￥<#if item.price??>${item.price?string("0.00")} x ${item.quantity!''}</#if><a href="javascript:delItem(${item.id?c});">删除</a></p>
                        <div class="clear"></div>
                    </div>                  
                        <#if item.price??>
                            <#assign totalPrice=totalPrice+item.price*item.quantity>
                        </#if>                 
          </#list>
                  <h4 class="shopping_price">
                                                                             共<#if cart_goods_list??>${cart_goods_list?size}<#else>0</#if>件商品 &nbsp;&nbsp;共计<span class="fw-b">￥${totalPrice?string("0.00")}</span>
                    <a href="/cart">去结算</a>
                  </h4>
      <#else>
        <h3 class="ta-c pa15 fs14 fw400">购物车中还没有商品，赶紧选购吧！</h3>
      </#if>
    </menu>
    </div>
</div>
</div>
<div class="daohang">

<nav class="navbox">
  <section class="navlist" id="mainnavdown">
    <a href="/productCategory/all" class="a2">全部商品分类</a>
    <ul class="navlistout" id="navdown" style="display:none;">
        <#if top_cat_list??>
            <#list top_cat_list as item>
            <#if item_index < 9>
            <li>
                <h3 class="${item.callIndex}"><img src="${item.imgUrl}" /><a href="/themes?categoryId=${item.id?c}">${item.title!''}</a></h3>
                    <div class="nav_showbox">
                    <i class="bg"></i>
                    <div class="clear"></div>
                          <#if ("nav_"+item_index+"_ad_list")?eval??> 
                             <table class="nav_right"> 
                                  <#list ("nav_"+item_index+"_ad_list")?eval as aditem> 
                                        <#if aditem_index < 4 >                                                           
                                              <tr>
                                                   <td colspan="2" class="pt10"><a href="${aditem.linkUri!''}"><img src="${aditem.fileUri!''}" width="166" height="129"/></a></td>
                                              </tr>
                                        </#if>
                                  </#list>                                                    
                             </table>
                           </#if>
                    <#if ("second_level_"+item_index+"_cat_list")?eval?? >
                        <table class="nav_more">
                            <#list ("second_level_"+item_index+"_cat_list")?eval as secondLevelItem>
                                <tr>
                                    <th width="90"><span><a href="/list/${secondLevelItem.id?c}">${secondLevelItem.title!''}</a></span></th>
                                    <td>
                                        <#if ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval?? >
                                            <#list ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval as thirdLevelItem>
                                                <a href="/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a>
                                            </#list>
                                        </#if>
                                    </td>
                                </tr>
                            </#list>
                        </table>
                    </#if>
                  <div class="clear"></div>
                </div>
            </li>
            </#if>
           </#list>
        </#if>
    </ul><!--navlistout END-->
    </section>
    <#if navi_item_list??>
        <#list navi_item_list as item>
          <#if item_index < 11>
            <a class="a1" href="${item.linkUri!''}">${item.title!''}</a>
          </#if>
        </#list>
    </#if> 
</nav>
</div>
<!-- 浮动 -->
<style>
.floatbox a.a1{background:url(/client/images/float_ico01.png) no-repeat center; width:42px; height:42px;}
.floatbox a.a1:hover{background:url(/client/images/float_ico011.png) no-repeat center; width:42px; height:42px; }
.floatbox a.a2{background:url(/client/images/float_ico03.png) no-repeat center; width:42px; height:42px;}
.floatbox a.a2:hover{background:url(/client/images/float_ico033.png) no-repeat center; width:42px; height:42px; }
.floatbox a.a3{background:url(/client/images/float_ico04.png) no-repeat center; width:42px; height:42px;}
.floatbox a.a3:hover{background:url(/client/images/float_ico044.png) no-repeat center; width:42px; height:42px; }
.floatbox a.a4{background:url(/client/images/float_ico02.png) no-repeat center; width:42px; height:42px;}
.floatbox a.a4:hover{background:url(/client/images/float_ico022.png) no-repeat center; width:42px; height:42px; }
.floatbox a.a5{background:url(/client/images/float_ico05.png) no-repeat center; width:42px; height:42px;}
.floatbox a.a5:hover{background:url(/client/images/float_ico055.png) no-repeat center; width:42px; height:42px; }
</style>
<aside class="floatbox"> 
  <a class="a1" href="/cart" title="购物车"><span>购物车</span></a>
  <a class="a2" href="/user/collect/list" title="我的关注"><span>我的关注</span></a>
  <a class="a3" href="/user/recent/list" title="我的足迹"><span>我的足迹</span></a>
  <a class="a4" href="http://wpa.qq.com/msgrd?v=3&uin=${site.qq!''}&site=qq&menu=yes" title="在线客服"><span>在线客服</span></a>
   <a class="a5" href="javascript:move();" title="回到顶部"><span>回到顶部</span></a>
</aside>