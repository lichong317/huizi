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

<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/gwc.js"></script>
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
<div class="gwcbg">
    <div class="main mt10">
        <div class="weizhi"> 
            <span>您现在的位置：</span>
            <a href="#">首页</a>&gt;<a href="#">手机产品</a>&gt;<a href="#">手机筛选</a> 
        </div>
        <div class="s_gwc1 mt10">
            <span id="colorfff">1、我的购物车</span><span>2、我的订单信息</span><span>3、支付成功</span>
        </div>
    </div>
    
    <div id="main" class="page-main">
        <#include "/client/cart_goods.ftl" />
    </div>

</div>
<!--mymember END-->

<#include "/client/common_footer.ftl" />

</div>
</body>
</html>




  











