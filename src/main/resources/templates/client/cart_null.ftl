<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/css/gwc.css" rel="stylesheet" type="text/css" />

<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
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
<#include "/client/common_header.ftl" />
<!--mymember-->
<div class="myclear"></div>
<div class="mymember_out">
<div class="gwcbg">
<div class="main mt10">
    <div class="weizhi"> <span>您现在的位置：</span><a href="/">首页</a> &gt; <a href="/cart">购物车</a> &gt; <a href="javascript:;">我的购物车</a></div>
</div>

<div class="clear"></div>

<div class="main">
  
  <div class="clear h30"></div>
  
  <div class="car_kong">
    <p class="fc fs18 pb10">购物车空空的哦，去看看心意的商品吧！</p>
    <div class="pt10 font13">看看 <a href="/user/order/list/0" style=" color:#da090b">已买到商品</a> </div>
    <div class="pt10 font13">看看 <a href="/user/collect/list" style=" color:#da090b">我的收藏夹</a> </div>
  </div>
  
  <div class="clear"></div> 
</div>

</div>
<!--mymember END-->
</div>
<#include "/client/common_footer.ftl" />


</body>
</html>




  











