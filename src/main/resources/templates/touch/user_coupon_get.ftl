<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title>暂无标题</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="copyright" content="" />
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
	
});
</script>
</head>

<body class="eeebg">
<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>我的优惠券</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<img src="/touch/images/quan_ad.png" class="w100" />

<#if coupon_type_list??>
    <#list coupon_type_list as item>
		<a href="#" class="ticket center mt20">
			<#-- 计算剩余优惠券数量 -->
      	 	<#assign couponCount=0>
            <#if ("coupon_" + item.id + "_list")?eval?? >                               
	           <#list ("coupon_" + item.id + "_list")?eval as coupon>                                                                 
	            	<#assign couponCount=couponCount+coupon.leftNumber>
	           </#list>
            </#if>
            <#-- 计算结束 -->
			<section>
				<#--<h3>全场通用</h3>-->
				<h4>${item.title!''}</h4>
			</section>
			<div class="num">
				<i></i>
				<h3>￥${item.price?string("0.00")}<span>可抵用${item.price?string("0.00")}</span></h3>
			</div>
			<div class="clear"></div>
		</a>
		<div class="ticketbot center">
			<img src="/touch/images/quan.png" class="w100" />
			<#if ("coupon_" + item.id + "_list")?eval?? >                               
               <#list ("coupon_" + item.id + "_list")?eval as coupon>       
					<input type="button" value="立即领取" class="sub" onclick="javascript:getCoupon(${coupon.id?c}, ${couponCount!'0'});" />
				</#list>
			</#if>
		</div>
	</#list>
</#if>
<div class="clear h03"></div>
  
</body>
<script>
	function getCoupon(couponId,count){
		if(0 === count){
			alert("优惠券已领完！");
			return;
		}
		
		$.ajax({
			url : "/touch/user/get/coupon/add",
			type : "post",
			data : {
				username : <#if user??>"${user.username!''}"<#else>""</#if>,
				couponId : couponId
			},
			success:function(res){
				if (res.status==0) {
	                alert("领取优惠券成功");
	                window.location.reload();
	            }else {
	                alert(res.message);
	            }
			}
		});
	}
</script>
</html>
