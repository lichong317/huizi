<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="format-detection"content="telephone=no"/>

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />


</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>会员中心</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<section class="memberhead main">
   <#if user??>
   
      <a onclick="changeHeads();"><img src="${user.headImageUri!''}" width="100px" height="100px"/></a>
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
      <p class="white fs08 lh20 ta-c">${user.username!''}</p>
   </#if>
</section>

<section class="main membertop mt10 mb10" >
  <menu style="background:none">
    <a href="/touch/user/order/list/2"><img src="/touch/images/huiyuan_05.png" height="48" /><p>待付款</p>
        <div class="num" style="width: 18px;height: 21px;background: #ff4454;position: absolute;right: 10%;border-radius: 50%;top: 0;z-index: 9;color: #fff;    
        text-align: center; padding-left: 2px; padding-right: 2px; line-height: 21px;    
        font-family: Arial, Helvetica, sans-serif;    font-size: 10px;    -webkit-text-size-adjust: none;    font-weight: bold;"><#if total_unpayed??>${total_unpayed!''}</#if></div>       
    </a>
    <a href="/touch/user/order/list/4"><img src="/touch/images/huiyuan_07.png" height="48" /><p>待收货</p>
        <div class="num" style="width: 18px;height: 21px;background: #ff4454;position: absolute;right: 10%;border-radius: 50%;top: 0;z-index: 9;color: #fff;    
        text-align: center; padding-left: 2px; padding-right: 2px; line-height: 21px;    
        font-family: Arial, Helvetica, sans-serif;    font-size: 10px;    -webkit-text-size-adjust: none;    font-weight: bold;"><#if total_unreceived??>${total_unreceived!''}</#if></div>
    </a>
    <a href="/touch/user/order/list/5"><img src="/touch/images/huiyuan_09.png" height="48" /><p>待评价</p>
        <div class="num" style="width: 18px;height: 21px;background: #ff4454;position: absolute;right: 10%;border-radius: 50%;top: 0;z-index: 9;color: #fff;    
        text-align: center; padding-left: 2px; padding-right: 2px; line-height: 21px;    
        font-family: Arial, Helvetica, sans-serif;    font-size: 10px;    -webkit-text-size-adjust: none;    font-weight: bold;"><#if total_uncommented??>${total_uncommented!''}</#if></div>
    </a>
    <a href="/touch/user/order/list/6"><img src="/touch/images/huiyuan_11.png" height="48" /><p>维修/售后</p>
        <div class="num" style="width: 18px;height: 21px;background: #ff4454;position: absolute;right: 10%;border-radius: 50%;top: 0;z-index: 9;color: #fff;    
        text-align: center; padding-left: 2px; padding-right: 2px; line-height: 21px;    
        font-family: Arial, Helvetica, sans-serif;    font-size: 10px;    -webkit-text-size-adjust: none;    font-weight: bold;"><#if total_finished??>${total_finished!''}</#if></div>
    </a>
  </menu>
  
  <menu class="hycd">
    <a href="/touch/user/order/list/0"><img src="/touch/images/huiyuan_24.png" height="48"><p>全部订单</p></a>
    <a href="/touch/user/point/list"><img src="/touch/images/huiyuan_27.png" height="48"><p>我的积分</p></a>
    <a href="/touch/user/coupon/list/0"><img src="/touch/images/huiyuan_30.png" height="48"><p>我的优惠券</p></a>
    <a href="/touch/user/redenvelope/list"><img src="/touch/images/huiyuan_32.png" height="48"><p>我的红包</p></a>
</menu>
</section>

<menu class="main memberlist">
<#--  <a href="/touch/user/order/list/0">全部订单<img style="float:right; margin-top:13px;" src="/touch/images/arrow04.png" /></a>
  <a href="/touch/user/point/list">我的积分（${user.totalPoints!0}）<img style="float:right; margin-top:13px;" src="" /></a>
  <a href="/touch/user/coupon/list/0">我的优惠券<img style="float:right; margin-top:13px;" src="" /></a> 
  <a href="/touch/user/collect/list">我的收藏<img style="float:right; margin-top:13px;" src="" /></a>
  <a href="/touch/user/redenvelope/list">我的红包<img style="float:right; margin-top:13px;" src="" /></a> 
  <a href="/touch/user/info">个人信息设置<img style="float:right; margin-top:13px;" src="" /></a>
<#--  <#if user?? && user.roleId?? && user.roleId == 1> -->
<#--    <a href="/touch/user/center/qrcode">我的二维码<img style="float:right; margin-top:13px;" src="" /></a>
    <a href="/touch/user/password">密码修改<img style="float:right; margin-top:13px;" src="" /></a> -->
    
    <a href="/touch/user/collect/list">
        <img src="/touch/images/shoucang.png" style="position: relative;width: 20px;height: 20px;top: 3px;left: -15px;">我的收藏
        <img src="/touch/images/arrow04.png" style="position: relative;float: right;right: -15px;top: 11px;">
    </a>
    <a href="/touch/user/info">
        <img src="/touch/images/geren.png" style="position: relative; width: 20px;height: 20px;top: 3px;left: -15px;">个人信息设置
        <img src="/touch/images/arrow04.png" style="position: relative;float: right; right: -15px;top: 11px;">
    </a>
    <a href="/touch/user/center/qrcode">
        <img src="/touch/images/erweima.png" style="position: relative;width: 20px;height: 20px;top: 3px;left: -15px;">我的二维码
        <img src="/touch/images/arrow04.png" style="position: relative;float: right;right: -15px;top: 11px;">
    </a>
    <a href="/touch/user/password">
        <img src="/touch/images/mima.png" style="position: relative;width: 20px;height: 20px;top: 3px;left: -15px;">密码修改
        <img src="/touch/images/arrow04.png" style="position: relative;float: right;right: -15px;top: 11px;">
    </a>
   

</menu> 
<div class=" tuichu main">
<a href="/touch/logout" onclick="logout()">退出</a> </div>

<!--main END-->

<#if !app??>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
