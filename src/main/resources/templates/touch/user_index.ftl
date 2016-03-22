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
	indexBanner("box","sum",300,90000,"myselfnum");//Banner
});
</script>
</head>

<body class="eeebg">
<header class="comhead">
  <h2>个人中心</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="/touch/message/list" class="a1"><img src="/touch/images/search02.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="myhead">
  <a class="a1" href="javascript:;" onclick="changeHeads();"><img src="<#if user.headImageUri?? && user.headImageUri == ''>/touch/images/member/head.png<#else>${user.headImageUri!'/touch/images/member/head.png'}</#if>" /></a>
   <script>
                        function changeHeads(){
                            var filebutton = document.getElementById("filebutton");
                            filebutton.click();
                        }
                        function getFile(){
                            document.getElementById("uploadImgForm").submit();
                            
                        }
    </script>
    <form id="uploadImgForm" enctype="multipart/form-data" action="/touch/user/center/headImg" method="post">
           <input style="display:none" name="Filedata" type="file"  capture="camera" accept="image/*" onchange="getFile();" id="filebutton">
    </from>
  <section>
    <p>${user.username!''}</p>
    <a class="white mt20" href="javascript:;" onclick="$('.winbg').fadeToggle(200);">退出</a>
  </section>
  <h3><#if user.roleId?? && user.roleId==1>分销商<#elseif user.roleId?? && user.roleId==2>商城会员<#else>普通会员</#if>&nbsp;${user.userLevelTitle!''}</h3>
</div>

<h3 class="lh6 h06 mainbox fs3 whitebg mt20 bot-border">我的订单<a class="mytit_more" href="/touch/user/order/list/0">查看全部订单</a></h3>
<section class="myself_nav tabfix w100 mb20">
  <nav>
    <a href="/touch/user/order/list/2"><img src="/touch/images/member/myself01.png" /><p>待付款</p><b <#if total_unpayed?? && total_unpayed gt 99>style="width:0.5rem"</#if>><#if total_unpayed??>${total_unpayed!''}</#if></b></a> 
    <a href="/touch/user/order/list/4"><img src="/touch/images/member/myself02.png" /><p>待收货</p><b><#if total_unreceived??>${total_unreceived!''}</#if></b></a>
    <a href="/touch/user/order/list/5"><img src="/touch/images/member/myself03.png" /><p>待评价</p><b><#if total_uncommented??>${total_uncommented!''}</#if></b></a>
    <a href="/touch/user/order/list/6"><img src="/touch/images/member/myself04.png" /><p>维修售后</p><b><#if total_finished??>${total_finished!''}</#if></b></a>
  </nav>
</section>

<section id="box" class="myselfmenu">
  <ul id="sum">
    <li>
      <div class="tabfix w100">
        <menu>
          <a href="/touch/user/point/list">
            <img src="/touch/images/member/member01.png" /><p>我的积分</p>
          </a>
          <a href="/touch/user/redenvelope/list?statusId=2">
            <img src="/touch/images/member/member02.png" /><p>我的红包</p>
          </a>
          <a href="/touch/user/coupon/list/1">
            <img src="/touch/images/member/member03.png" /><p>我的优惠券</p>
          </a>
        </menu>
        <menu>
          <a href="/touch/user/collect/list">
            <img src="/touch/images/member/member04.png" /><p>我的收藏</p>
          </a>
          <a href="/touch/user/addressManage">
            <img src="/touch/images/member/member05.png" /><p>地址管理</p>
          </a>
          <a href="/touch/user/center/qrcode">
            <img src="/touch/images/member/member06.png" /><p>我的二维码</p>
          </a>
        </menu>
        <menu>
          <a href="/touch/user/info">
            <img src="/touch/images/member/member07.png" /><p>个人信息</p>
          </a>
          <a href="/touch/user/password">
            <img src="/touch/images/member/member10.png" /><p>密码修改</p>
          </a>
          <#if user?? && user.roleId?? && user.roleId !=0>
          <a href="/touch/user/account/info">
            <img src="/touch/images/member/member08.png" /><p>账户信息</p>
          </a>
          </#if>
        </menu>
      </div>
    </li>
    <#if user?? && user.roleId?? && user.roleId ==1>
    <li>
      <div class="tabfix w100">
        <menu>
        <#if user?? && user.roleId?? && user.roleId ==1>
          <a href="/touch/user/junioruser/list">
            <img src="/touch/images/member/member09.png" /><p>下级用户</p>
          </a>
        </#if>
          <a href="#"></a>
          <a href="#"></a>
        </menu>
        <menu>
          <a href="#"></a>
          <a href="#"></a>
          <a href="#"></a>
        </menu>
        <menu>
          <a href="#"></a>
          <a href="#"></a>
          <a href="#"></a>
        </menu>
      </div>
    </li> 
    </#if>  
  </ul>
  <div class="clear"></div>
</section><!--我是banner-->
<div class="clear h03"></div>

<#if !app??>   
<div class="mainfoot_bg"></div>
<footer class="tabfix mainfoot">
  <menu>
    <a href="/touch"><img src="/touch/images/foot01.png" /><p>首页</p></a>
    <a href="/touch/info/list/10"><img src="/touch/images/foot02.png" /><p>资讯</p></a>
    <a href="/touch/category/list"><img src="/touch/images/foot03.png" /><p>分类搜索</p></a>
    <a href="/touch/cart/"><img src="/touch/images/foot04.png" /><p>购物车</p></a>
    <a class="sel" href="#"><img src="/touch/images/foot05.png" /><p>会员中心</p></a>
  </menu>
</footer>
</#if>

<!--弹出层-->
<aside class="winbg" style="display:none">
  <div class="myself_ts">
    <p class="ta-c pt20">确定要退出吗？</p>
    <div class="clear h05"></div>
    <a class="sub w100 lh6 h06 ta-c white redbg block fs3" href="/touch/logout">确认</a>
    <a class="sub w100 lh6 h06 ta-c darkborbtn fs3 mt20" href="javascript:void(0);" onClick="$(this).parent().parent().fadeOut(200);">取消</a>
  </div>
</aside>
  
</body>
</html>
