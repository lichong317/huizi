<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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

 <!-- header开始 -->
<#include "/client/common_header.ftl" />
<!--header结束-->
<div class="mymember_out">
<div class="mymember_main">
  <div class="myclear" style="height:20px;"></div>
  <#-- 左侧菜单 -->
  <#include "/client/common_user_menu.ftl" />
  <#-- 左侧菜单结束 -->
  
  <div class="mymember_mainbox">
    <div class="mymember_info mymember_info04">
      <h3>取消订单记录</h3>
      <dl>
        <dt>订单编号：${order.orderNumber!''}&nbsp;&nbsp;&nbsp;&nbsp; 取消进度：完成&nbsp;&nbsp;&nbsp;&nbsp; 支付总额：<span>￥<#if order??>${order.totalPrice?string("#.##")}</#if></span></dt>
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
    版权所有2015 惠之店 保留所有权利 <br>
    Copyright ©  2015 bangonggou.com.cn All Rights Reserved <a style="color:#FFF" href="#">滇ICP备2-20140075</a>
          <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>
</div>
</div>

</div>
</body>
</html>




  











