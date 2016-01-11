<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>惠之店</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="copyright" content="" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<!--[if IE 6]>
<script type="text/javascript" src="/client/js/DD_belatedPNG_0.0.8a.js" ></script>
<script>
DD_belatedPNG.fix('.,img,background');
</script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
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
    
    productImgShow("proshowimg","li","proshowmenu","sel",396,396);
    checkBoxShow("assort_menu","a","assort_sum","li","sel");
    topTitFloat("detail_tit",1250,"detail_tit_sel");
});
</script>
<style>
.full404{ width:100%; height:auto; overflow:hidden; padding-top:120px; text-align:center; padding-bottom:50px;}
.page404{ height:auto; overflow:hidden;}
.Ptitle{ display:block; width:100%; height:36px; font-size:24px; color:#ff4454; text-align:center;}
.Pback{ font-size:12px; cursor:pointer;}
.Pother i{ display:block; width:100%; height:310px; padding:20px; background:url(/client/images/404.png) no-repeat center; margin-left:-20px;}

</style>

</head>

<body>
<#include "/client/common_header.ftl" />

<div class="clear h20"></div>

<section class="full404" data-minHeight="640">
    <article class="page404 mid">
        <p class="Ptitle">对不起，您访问的页面不存在！</p>
        <a class="Pback" href="/" title="">返回到您之前浏览的页面</a>
        <p class="Pother">
            <i></i>
        </p>
        
    </article>
</section>






<div class="clear h40"></div>
<#include "/client/common_footer.ftl" />

</body>
</html>
