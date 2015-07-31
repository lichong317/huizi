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
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
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
    
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3
    });
});
</script>
</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<article id="main" class="mt15">
    <div class="left fl">
        <div class="m" id="succeed">
            <div class="corner tl"></div>
            <div class="corner tr"></div>
            <div class="corner bl"></div>
            <div class="corner br"></div>
            <div class="success">
                <div class="success-b">
                    <h3>商品已成功加入购物车！</h3>
                </div>
            <span id="initCart_next_go">
                <a class="btn-1" href="/cart">去购物车结算</a>
                <span class="ml10">您还可以 <a class="ftx-05" href="/">继续购物</a></span>
            </span></div>
        </div><!--succeed end-->
    </div> 
</article>
<!--主体结束-->

<#include "/client/common_footer.ftl" />
</body>
</html>
<!--结束-->
