<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>惠资生活</title>
<meta name="keywords" content="惠资生活" />
<meta name="description" content="惠资生活" />
<meta name="copyright" content="惠资生活 版权所有" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>

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
</script>
</head>
<body>
<div class="maintop">
<section class="main">
    <h1>亲，欢迎来到惠资生活网上商城</h1>
    <p class="p2">400-1234-567	</p>
    <p class="p3">服务热线：</p>
    <menu id="top_phone">
      <a class="a1" href="#">手机惠之店</a>
      <div class="clear"></div>
      <ul class="phone_sum" id="top_phonelist">
        <li style="padding-top:10px;"><a href="#"><span class="phoneico01">触屏版</span></a></li>
        <li><a href="#"><span class="phoneico02">公众平台</span></a>
  
        </li>
        <li><a href="#"><span class="phoneico03">iPhone</span></a></li>
        <li style="border-bottom:1px solid #eee; padding-bottom:10px;"><a href="#"><span class="phoneico04">Android</span></a></li>
        <li class="phone_sum_more">
          <p>
            <span>客户端抓侧即送10元豪礼</span>
            <span class="mt5"><img src="images/hzd_55.png" /></span>
          </p>
          <p>
            <span>客户端抓侧即送10元豪礼</span>
            <span class="mt5"><img src="images/hzd_55.png" /></span>
          </p>
          <p>
            <span>客户端抓侧即送10元豪礼</span>
            <span class="mt5"><img src="images/hzd_55.png" /></span>
          </p>
        </li>
      </ul>
    </menu>
    
    
    <a class="a2" href="#">在线咨询</a>
    <a class="a3" href="#">会员俱乐部</a>
    <a class="z-in10" href="#">帮助中心</a>
    <a class="a4" href="#">我的订单<i></i></a>
      <a class="a" href="#" style="float:left; color:#ff4040;">登陆<i></i></a>
      <a class="a" href="#" style="float:left;">注册<i></i></a>
    <div class="clear"></div>
  </section>
</div>
<div class="top">
<div class="main top1">
<div class="logo"><a href="#"><img src="images/hzd_11.png" border="0" /></a></div>
<div class="ssbox">
        <div class="clear"></div>
        <input type="text" class="ss_txt"  />
        <input type="submit" class="ss_btn" value="" />
        <div class="clear"></div>
        <p><a href="#">打印机</a><a href="#">打印机</a><a href="#">打印机</a><a href="#">打印机</a></p>
        </div>
        
        <div id="shopping_down" class="shopping_box">
    <span class="sp1">5</span>
    <a class="a1" href="#">去购物车结算<i></i></a>
    <menu>
      <!--<h3 class="ta-c pa15 fs14 fw400">购物车中还没有商品，赶紧选购吧！</h3>-->
      <h2>最新加入的商品</h2>
      <h3 class="tit">
        <span>满减</span>
        购满1999元，即可享受满减优惠 小计：￥2888.00
      </h3>
      <div class="shopping_list">
        <div class="clear"></div>
        <a class="a2" href="#"><img src="images/hzd_28.png" /></a>
        <a class="a3" href="#">索尼KDL-50W700B50英寸 全高清 网络智能WIFI液晶电视</a>
        <p>￥2888.00 x1<a href="#">删除</a></p>
        <div class="clear"></div>
      </div>
      <div class="shopping_list">
        <div class="clear"></div>
        <a class="a2" href="#"><img src="images/hzd_28.png" /></a>
        <a class="a3" href="#">索尼KDL-50W700B50英寸 全高清 网络智能WIFI液晶电视</a>
        <p>￥2888.00 x1<a href="#">删除</a></p>
        <div class="clear"></div>
      </div>
      <div class="shopping_list">
        <div class="clear"></div>
        <a class="a2" href="#"><img src="images/hzd_28.png" /></a>
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
        <a class="a2" href="#"><img src="images/hzd_28.png" /></a>
        <a class="a3" href="#">索尼KDL-50W700B50英寸 全高清 网络智能WIFI液晶电视</a>
        <p>￥2888.00 x1<a href="#">删除</a></p>
        <div class="clear"></div>
      </div><!--shopping_list END-->
      <h4 class="shopping_price">
        共1件商品 &nbsp;&nbsp;共计<span class="fw-b">￥2288.00</span>
        <a href="#">去结算</a>
      </h4>
    </menu>
  </div>
</div>
</div>
<!-- 浮动 -->
<aside class="floatbox">
  <a href="#" title="微信客服"><img src="images/float_ico01.png" width="42" height="42" alt="微信客服" /><span><img src="images/hzd_55.png" /></span></a>
  <a href="#" title="在线咨询"><img src="images/float_ico02.png" width="42" height="42" alt="在线咨询" /></a>
  <a href="#" title="新浪微博"><img src="images/float_ico03.png" width="42" height="42" alt="新浪微博" /></a>
  <a href="#" title="服务热线"><img src="images/float_ico04.png" width="42" height="42" alt="服务热线" /><span><img src="images/hzd_55.png" /></span></a>
  <a href="#" title="到顶部"><img src="images/float_ico05.png" width="42" height="42" alt="到顶部" /></a>
</aside>
<div class="daohang">

<nav class="navbox">
  <section class="navlist" id="mainnavdown">
    <a href="#" class="a2">全部商品分类</a>
    <ul class="navlistout" id="navdown" style="display:none;">
      <li>
        <h3 class="shouji"><img src="images/images/fltp_03.png" /><a href="#">手机大全</a></h3>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>

                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
              </td>
            </tr>
            <tr>
              <th width="90"><span><a href="#">品牌</a></span></th>
              <td>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
                <a href="#">苹果</a>
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
<!--mymember-->
<div class="myclear"></div>
<div class="mymember_out">
<div class="mymember_main">
  <!--mymember_head END-->
  <div class="myclear" style="height:20px;"></div>
  <div class="mymember_menu">
    <div class="mymember_menu_part">
      <a class="mymember_menu_tit" href="#"><img src="images/mymember/menu01.png" />订单中心</a>
      <div>
        <a href="#">我的订单</a>
        <a href="#">评价结单</a>
        <a href="#">取消订单记录</a>
      </div>
    </div><!--mymember_menu_part END-->
    <div class="mymember_menu_part">
      <a class="mymember_menu_tit" href="#"><img src="images/mymember/menu02.png" />关注中心</a>
      <div>
        <a href="#">关注的商品</a>
        <a href="#">浏览历史</a>
      </div>
    </div><!--mymember_menu_part END-->
    <div class="mymember_menu_part">
      <a class="mymember_menu_tit" href="#"><img src="images/mymember/menu03.png" />资产中心</a>
      <div>
        <a href="#">优惠券</a>
        <a href="#">积分</a>
      </div>
    </div><!--mymember_menu_part END-->
    <div class="mymember_menu_part">
      <a class="mymember_menu_tit" href="#"><img src="images/mymember/menu04.png" />客户服务</a>
      <div>
        <a href="#">返修退换货</a>
        <a href="#">我的投诉</a>
        <a href="#">购买咨询</a>
      </div>
    </div><!--mymember_menu_part END-->
    <div class="mymember_menu_part">
      <a class="mymember_menu_tit" href="#"><img src="images/mymember/menu05.png" />设置</a>
      <div>
        <a href="#">个人信息</a>
        <a href="#">收货地址</a>
      </div>
    </div><!--mymember_menu_part END-->
  </div><!--mymember_menu END-->
  
  <div class="mymember_mainbox">
    <div class="mymember_info mymember_info04">
      <h3>取消订单记录</h3>
      <dl>
        <dt>订单编号：8768545223&nbsp;&nbsp;&nbsp;&nbsp; 取消进度：完成&nbsp;&nbsp;&nbsp;&nbsp; 支付总额：<span>￥5200.00</span></dt>
        <dd>亲爱的客户，此订单已取消成功。</dd>
      </dl>
      <div class="mymember_green">
        <p class="mysel"><i></i>提交申请</p>
        <p class="mysel"><i></i><b></b>取消处理</p>
        <p class="mysel"><i></i><b></b>退款处理</p>
        <p><i></i><b></b>完成</p>
        <div class="clear"></div>
      </div>
    </div><!--mymember_info END-->
    
    <div class="mymember_info mymember_info04">
      <h3>取消申请进度<a id="mymember_order02" href="javascript:myOrderShow('mymember_order02','mymember_ordersum02');">展开</a></h3>
      
      <table id="mymember_ordersum02">
        <tr>
          <th width="150">处理时间</th>
          <th>处理信息</th>
          <th width="100">操作人</th>
        </tr>
        <tr>
          <td>2015-02-22 18:22</td>
          <td>您的申请已取消！</td>
          <td>客户</td>
        </tr>
        <tr>
          <td>2015-02-22 18:22</td>
          <td>您的申请已取消！</td>
          <td>客户</td>
        </tr>
        <tr>
          <td>2015-02-22 18:22</td>
          <td>您的申请已取消！</td>
          <td>客户</td>
        </tr>
      </table>
    </div><!--mymember_info END-->
    
    <div class="mymember_info mymember_info04">
      <h3>申请单详细信息<a id="mymember_order01" href="javascript:myOrderShow('mymember_order01','mymember_ordersum01');">展开</a></h3>
      
      <table id="mymember_ordersum01" class="mymember_sq_tab">
        <tr>
          <th width="100">订单编号</th>
          <td>888888888888888</td>
        </tr>
        <tr>
          <th>支付明细</th>
          <td>支付总额：<font color="#ff1000">￥2250.00</font></td>
        </tr>
        <tr>
          <th>取消原因</th>
          <td></td>
        </tr>
        <tr>
          <th>联系方式</th>
          <td>联系人：张小二 &nbsp;&nbsp; 联系电话：201555415744</td>
        </tr>
      </table>
    </div><!--mymember_info END-->

    </div><!--mymember_mainbox END-->

  <div class="myclear"></div>  
</div><!--mymember_main END-->
<div class="myclear"></div>
</div>
<!--mymember END-->

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
<div class="main">
<ul>
<li class="downli"><a href="#">购物指南</a>
<ul>
  <li><a href="#">购物流程</a></li>
<li><a href="#">发票制度</a></li>
<li><a href="#">账户管理</a></li>
<li><a href="#">会员优惠</a></li>
</ul>
</li>
<li class="downli"><a href="#">支付方式</a>
<ul>
  <li><a href="#">订单配送查询</a></li>
<li><a href="#">订单状态说明</a></li>
<li><a href="#">自助取消订单</a></li>
<li><a href="#">自助修改订单</a></li>
</ul>
</li>
<li class="downli"><a href="#">订单服务</a>
<ul>
  <li><a href="#">配送范围及免邮标准</a></li>
<li><a href="#">当日递/次日达</a></li>
<li><a href="#">订单自提</a></li>
<li><a href="#">验货与签收</a></li>
</ul>
</li>
<li class="downli"><a href="#">配送方式</a>
<ul>
  <li><a href="#">货到付款</a></li>
<li><a href="#">网上支付</a></li>
<li><a href="#">礼品卡支付</a></li>
<li><a href="#">银行转账</a></li>
</ul>
</li>
<li class="downli"><a href="#">退换货</a>
<ul>
  <li><a href="#">货到付款</a></li>
<li><a href="#">网上支付</a></li>
<li><a href="#">礼品卡支付</a></li>
<li><a href="#">银行转账</a></li>
</ul>
</li>
<li class="downli"><a href="#">商家服务</a>
<ul>
  <li><a href="#">货到付款</a></li>
<li><a href="#">网上支付</a></li>
<li><a href="#">礼品卡支付</a></li>
<li><a href="#">银行转账</a></li>
</ul>
</li>

</ul>
</div>
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
          <ul class="downwenzi">
          <li><a href="#">公司简介</a>丨</li>
          <li><a href="#">联系我们</a>丨</li>
          <li><a href="#">招贤纳士</a>丨</li>
          <li><a href="#">合作伙伴</a>丨</li>
          <li><a href="#">广告合作</a></li>
          </ul>
    <div class="clear"></div>
    版权所有2015 惠资生活 保留所有权利 <br>
    Copyright ©  2015 bangonggou.com.cn All Rights Reserved <a style="color:#FFF" href="#">滇ICP备2-20140075</a>
          <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>
</div>
</div>

</div>
</body>
</html>




  











