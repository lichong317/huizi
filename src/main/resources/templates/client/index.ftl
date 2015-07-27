<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site.seoTitle??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="惠资生活" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  $(document).ready(function(){
	menuDownList("top_phone","#top_phonelist",".a1","sel");
	phoneListMore();//单独下拉
    menuDownList("top_order","#top_orderlist",".a4","sel");//顶部下拉
	searchTextClear(".toptext","请输入品牌或商品名称","#999","#666");
	searchTextClear(".bottext","查看所有门店","#fff","#fff");
	checkNowHover("shopping_down","shopping_sel");
	navDownList("navdown","li",".nav_showbox");
	//menuDownList("mainnavdown","#navdown",".a2","sel");
	
	chooseMoreShow();
		
});
</script>
</head>
<body>
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
        <a class="a" href="/login" style="float:left; color:#ff4040;" target="_blank">登陆<i></i></a>
        <a class="a" href="/reg" style="float:left;" target="_blank">注册<i></i></a>
    </#if>
    <a class="a2" href="#">在线咨询</a>
    <a class="a3" href="/user">会员俱乐部</a>
    <a class="z-in10" href="/info/list/12">帮助中心</a>
    <a class="a4" href="/user/order/list/0">我的订单<i></i></a>
    <div class="clear"></div>
</section>
</div>

<div class="main top1 pb20">
<div class="clear"></div>
<div class="logo"><a href="/"><img src="<#if site??>${site.logoUri!''}</#if>" border="0" /></a></div>
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
          <h2>最新加入的商品</h2>
          <h3 class="tit">
            <span>满减</span>
            购满1999元，即可享受满减优惠 小计：￥2888.00
          </h3>
          <div class="shopping_list">
            <div class="clear"></div>
            <a class="a2" href="#"><img src="/client/images/hzd_28.png" /></a>
            <a class="a3" href="#">索尼KDL-50W700B50英寸 全高清 网络智能WIFI液晶电视</a>
            <p>￥2888.00 x1<a href="#">删除</a></p>
            <div class="clear"></div>
          </div>
          <div class="shopping_list">
            <div class="clear"></div>
            <a class="a2" href="#"><img src="/client/images/hzd_28.png" /></a>
            <a class="a3" href="#">索尼KDL-50W700B50英寸 全高清 网络智能WIFI液晶电视</a>
            <p>￥2888.00 x1<a href="#">删除</a></p>
            <div class="clear"></div>
          </div><!--shopping_list END-->
          <h3 class="tit">
            <span>满减</span>
            购满1999元，即可享受满减优惠 小计：￥2888.00
          </h3>
          <div class="shopping_list">
            <div class="clear"></div>
            <a class="a2" href="#"><img src="/client/images/hzd_28.png" /></a>
            <a class="a3" href="#">索尼KDL-50W700B50英寸 全高清 网络智能WIFI液晶电视</a>
            <p>￥2888.00 x1<a href="#">删除</a></p>
            <div class="clear"></div>
          </div><!--shopping_list END-->
          <h4 class="shopping_price">
            共1件商品 &nbsp;&nbsp;共计<span class="fw-b">￥2288.00</span>
            <a href="#">去结算</a>
          </h4>
      <#else>
        <h3 class="ta-c pa15 fs14 fw400">购物车中还没有商品，赶紧选购吧！</h3>
      </#if>
    </menu>
</div>
  <div class="clear"></div>
</div>

<aside class="floatbox">
  <a href="#" title="微信客服"><img src="/client/images/float_ico01.png" width="42" height="42" alt="微信客服" /><span><img src="/client/images/hzd_55.png" /></span></a>
  <a href="#" title="在线咨询"><img src="/client/images/float_ico02.png" width="42" height="42" alt="在线咨询" /></a>
  <a href="#" title="新浪微博"><img src="/client/images/float_ico03.png" width="42" height="42" alt="新浪微博" /></a>
  <a href="#" title="服务热线"><img src="/client/images/float_ico04.png" width="42" height="42" alt="服务热线" /><span><img src="/client/images/hzd_55.png" /></span></a>
  <a href="#" title="到顶部"><img src="/client/images/float_ico05.png" width="42" height="42" alt="到顶部" /></a>
</aside>

	<!--导航-->
	<div class="daohang">
<nav class="navbox">
  <section class="navlist" id="mainnavdown">
    <a href="#" class="a2">全部商品分类</a>
    <ul class="navlistout" id="navdown">
      <li>
        <h3 class="shouji"><img src="/client/images/images/fltp_03.png" /><a href="#">手机大全</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="jiadian"><img src="images/images/fltp_14.png" /><a href="#">家用电器</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="sy"><img src="images/images/fltp_11.png" /><a href="#">摄影摄像</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="jiushui"><img src="images/images/fltp_17.png" /><a href="#">食品酒水</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="diannao"><img src="images/images/fltp_07.png" /><a href="#">电脑办公</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="hzp"><img src="images/images/fltp_24.png" /><a href="#">化妆品</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="yybj"><img src="images/images/fltp_29.png" /><a href="#">医药保健</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="myyp"><img src="images/images/fltp_32.png" /><a href="#">母婴用品</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
      <li>
        <h3 class="yfxb"><img src="images/images/fltp_21.png" /><a href="#">衣服箱包</a></h3>
        <div class="nav_showbox">
          <i class="bg"></i>
          <div class="clear"></div>
          <table class="nav_right">
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
              <td><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2" class="pt10"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
            <tr>
              <td colspan="2"><a href="#"><img src="images/hzd_19.png" /></a></td>
            </tr>
          </table>
          <table class="nav_more">
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span>品牌</span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
          </table>
          <div class="clear"></div>
        </div>
      </li>
    </ul><!--navlistout END-->
  </section>
  <a class="a1" href="#">手机</a>
  <a class="a1" href="#">笔记本</a>
  <a class="a1" href="#">配件</a>
  <a class="a1" href="#">摄影</a>
  <a class="a1" href="#">闪购</a>
  <a class="a1" href="#">团购</a>
  <a class="a1" href="#">母婴</a>
  <a class="a1" href="#">时装</a>
  <a class="a1" href="#">资讯</a>
  <a class="a1" href="#">会员专区</a>
  <a class="a1" href="#">门店</a>
</nav>
</div>
<div class="clear"></div>
	<!--banner-->
	<div class="banner">
		<a href="#" style="display:block;background:url(images/content/banner1.jpg) no-repeat center;width:1920px;height:450px;"></a>
	</div>


	<div class="main">
		<menu class="index_zx">
			<h3>惠咨询<a href="#">更多</a></h3>
			<ul>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
				<li><a href="#">[公告]惠之店启动空净节 渠道优势明显</a></li>
			</ul>
			<h3>惠生活</h3>
			<table>
				<tbody>
					<tr>
						<td>
							<a href="#"><img src="images/hzd_66.png"><p>话费充值</p></a>
						</td>
						<td>
							<a href="#"><img src="images/hzd_67.png"><p>电影票</p></a>
						</td>
						<td>
							<a href="#"><img src="images/hzd_68.png"><p>彩票</p></a>
						</td>
					</tr>
					<tr>
						<td>
							<a href="#"><img src="images/hzd_69.png"><p>水电缴费</p></a>
						</td>
						<td>
							<a href="#"><img src="images/hzd_70.png"><p>宽带</p></a>
						</td>
						<td>
							<a href="#"><img src="images/hzd_71.png"><p>门票</p></a>
						</td>
					</tr>
				</tbody>
			</table>
		</menu>
		<div class="clear"></div>
	</div>
	<!--楼层浮动-->



	<!--楼层主要内容-->
	<section class="main">
		<table class="index_tj">
			<tbody>
				<tr>
					<td class="td1"><a href="#">
						<img src="images/content/tj01.jpg" style="position:absolute;right:10px; top:45px;">
						<p class="p1">乐视超级电视  Max 70</p>
						<p class="p2">70吋超大屏幕</p>
						<p class="p3">24期分期免息</p>
					</a></td>
					<td class="td2"><a href="#">
						<img src="images/content/tj02.jpg" style="position:absolute;right:13px; top:58px;">
						<p class="p1">乐视超级电视  Max 70</p>
						<p class="p2">70吋超大屏幕</p>
						<p class="p3">24期分期免息</p>
					</a></td>
					<td class="td3"><a href="#">
						<img src="images/content/tj03.jpg" style="position:absolute;right:56px; top:12px;">
						<p class="p1">乐视超级电视  Max 70</p>
						<p class="p2">70吋超大屏幕</p>
						<p class="p3">24期分期免息</p>
					</a></td>
				</tr>
				<tr>
					<td class="td4"><a href="#">
						<img src="images/content/tj01.jpg" style="position:absolute;right:10px; top:45px;">
						<p class="p1">乐视超级电视  Max 70</p>
						<p class="p2">70吋超大屏幕</p>
						<p class="p3">24期分期免息</p>
					</a></td>
					<td class="td5"><a href="#">
						<img src="images/content/tj02.jpg" style="position:absolute;right:13px; top:58px;">
						<p class="p1">乐视超级电视  Max 70</p>
						<p class="p2">70吋超大屏幕</p>
						<p class="p3">24期分期免息</p>
					</a></td>
					<td class="td6"><a href="#">
						<img src="images/content/tj03.jpg" style="position:absolute;right:56px; top:12px;">
						<p class="p1">乐视超级电视  Max 70</p>
						<p class="p2">70吋超大屏幕</p>
						<p class="p3">24期分期免息</p>
					</a></td>
				</tr>
			</tbody>
		</table>
		<div class="clear"></div>
		<!--1楼-->
		<div class="index_onetit">1F&nbsp;&nbsp;&nbsp;&nbsp;家用电器</div>
		<div class="index_one">
			<menu class="index_one_list">
				<a href="#">三星</a>
				<a href="#">小米4</a>
				<a href="#">华为</a>
				<a href="#">酷派大神</a>
				<a href="#">小米</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">点放过</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
			</menu>
			<div class="index_litbanner"><img src="images/content/litba.jpg"></div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td rowspan="2"><a href="#" class="a2"><img src="images/content/indexpic1.jpg"></a></td>
					</tr>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<a class="index_ad" href="#">banner广告</a>
		<!--2楼-->
		<div class="index_twotit">2F&nbsp;&nbsp;&nbsp;&nbsp;电脑</div>
		<div class="index_two">
			<menu class="index_two_list">
				<a href="#">三星</a>
				<a href="#">小米4</a>
				<a href="#">华为</a>
				<a href="#">酷派大神</a>
				<a href="#">小米</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">点放过</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
			</menu>
			<div class="index_litbanner"><img src="images/content/litba.jpg"></div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<td rowspan="2"><a href="#" class="a2"><img src="images/content/indexpic1.jpg"></a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<!--3楼-->
		<div class="index_threetit">3F&nbsp;&nbsp;&nbsp;&nbsp;摄影</div>
		<div class="index_three">
			<menu class="index_three_list">
				<a href="#">三星</a>
				<a href="#">小米4</a>
				<a href="#">华为</a>
				<a href="#">酷派大神</a>
				<a href="#">小米</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">点放过</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
			</menu>
			<div class="index_litbanner"><img src="images/content/litba.jpg"></div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td rowspan="2"><a href="#" class="a2"><img src="images/content/indexpic1.jpg"></a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<a class="index_ad" href="#">banner广告</a>
		<!--4楼-->
		<div class="index_fourtit">4F&nbsp;&nbsp;&nbsp;&nbsp;食品酒水</div>
		<div class="index_four">
			<menu class="index_four_list">
				<a href="#">三星</a>
				<a href="#">小米4</a>
				<a href="#">华为</a>
				<a href="#">酷派大神</a>
				<a href="#">小米</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">点放过</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
			</menu>
			<div class="index_litbanner"><img src="images/content/litba.jpg"></div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<td rowspan="2"><a href="#" class="a2"><img src="images/content/indexpic1.jpg"></a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<!--5楼-->
		<div class="index_fivetit">5F&nbsp;&nbsp;&nbsp;&nbsp;手机</div>
		<div class="index_five">
			<menu class="index_five_list">
				<a href="#">三星</a>
				<a href="#">小米4</a>
				<a href="#">华为</a>
				<a href="#">酷派大神</a>
				<a href="#">小米</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">点放过</a>
				<a href="#">三星</a>
				<a href="#">科技新品</a>
				<a href="#">科技新品</a>
				<a href="#">三星</a>
			</menu>
			<div class="index_litbanner"><img src="images/content/litba.jpg"></div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td rowspan="2"><a href="#" class="a2"><img src="images/content/indexpic1.jpg"></a></td>
					</tr>
					<tr>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
						<td><a href="#" class="a1">
							<p class="p1"><b>索尼 3D网络智能WIFI液晶电视</b></p>
							<p class="p2">超窄边框   高清硬屏</p>
							<img src="images/content/indexpic.jpg">
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear h60"></div>
	</section>

	<!--页脚-->
	  <div class="down1">
<section class="index_center">
  <table>
    <tr>
      <td>
        <a href="#"><img src="images/hzd_36.png" />正品保障<br>正品保障，提供发票</a>
      </td>
      <td>
        <a href="images/hzd_39.png"><img src="images/hzd_39.png" />极速物流<br>极速物流，极速达人</a>
      </td>
      <td>
        <a href="#"><img src="images/hzd_42.png" />售后无忧<br>15天无理由退换货</a>
      </td>
      <td>
        <a href="#"><img src="images/hzd_45.png" />特色服务<br>自主维修保养预约</a>
      </td>
    </tr>
  </table>
</section><!--index_center END-->
<div class="clear"></div>

<section class="bot_help main">
  <menu>
    <h3>购物指南</h3>
    <a href="#">购物流程</a>
    <a href="#">发票制度</a>
    <a href="#">账户管理</a>
    <a href="#">会员优惠</a>
  </menu>
  <menu>
    <h3>支付方式</h3>
    <a href="#">订单配送查询</a>
    <a href="#">订单状态说明</a>
    <a href="#">自助取消订单</a>
    <a href="#">自助修改订单</a>
  </menu>
  <menu>
    <h3>购物指南</h3>
    <a href="#">购物流程</a>
    <a href="#">发票制度</a>
    <a href="#">账户管理</a>
    <a href="#">会员优惠</a>
  </menu>
  <menu>
    <h3>购物指南</h3>
    <a href="#">购物流程</a>
    <a href="#">发票制度</a>
    <a href="#">账户管理</a>
    <a href="#">会员优惠</a>
  </menu>
  <menu>
    <h3>购物指南</h3>
    <a href="#">购物流程</a>
    <a href="#">发票制度</a>
    <a href="#">账户管理</a>
    <a href="#">会员优惠</a>
  </menu>

  <div class="clear h20"></div>
</section>
</div>

<div class="down2">
<div class=" erweima main">
<div class="saoyisao">
<img src="images/hzd_55.png" />
<h3><a href="#">安卓客户端</a></h3> </div>
<div class="saoyisao">
<img src="images/hzd_55.png" />
<h3><a href="#">安卓客户端</a></h3> </div>
<div class="saoyisao">
<img src="images/hzd_55.png" />
<h3><a href="#">安卓客户端</a></h3> </div>
<div class="saoyisao">
<img src="images/hzd_55.png" />
<h3><a href="#">安卓客户端</a></h3> </div>
<div class="mendian">
<img src="images/hzd_52.png" />
<h3><a href="#">点击查询</a></h3>
</div>
<div class="dizhi">
<p>
<span>红河蒙自店</span><br>
<span>地址：</span>蒙自市XX街道XX大楼CX号<br>
<span>电话：</span>0871-564531245<br>
</p>
</div>
</div>
</div>

<div class="down3">
<div class="main">
		<div class="clear"></div>
          <ul class="downwenzi">
          <li><a href="#">公司简介</a>丨</li>
          <li><a href="#">联系我们</a>丨</li>
          <li><a href="#">招贤纳士</a>丨</li>
          <li><a href="#">合作伙伴</a>丨</li>
          <li><a href="#">广告合作</a></li>
          </ul>
    <div class="clear"></div>
    版权所有2015 办公狗网上商城 保留所有权利 <br>
    Copyright ©  2015 bangonggou.com.cn All Rights Reserved <a style="color:#FFF" href="#">滇ICP备2-20140075</a>
          <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>
</div>
</div>
</body>
</html>