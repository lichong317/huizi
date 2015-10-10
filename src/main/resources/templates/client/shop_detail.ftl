<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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
    menuDownList("mainnavdown","#navdown",".a2","sel");
    
    productImgShow("proshowimg","li","proshowmenu","sel",396,396);
    checkBoxShow("assort_menu","a","assort_sum","li","sel");
    topTitFloat("detail_tit",1250,"detail_tit_sel");
});
</script>
</head>

<body>
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<div class="clear h20"></div>
<div class="main">
  <div class="dituxiangxi">
  <div class="pro_box">
    <section class="proinfo_left">
      <menu id="proshowimg">
        <#if shop?? && shop.showPictures??>
            <#list shop.showPictures?split(",") as uri>
                <#if uri != "" >
                       <li><img src="${uri!""}" /></li>
                </#if>
            </#list>
        </#if>       
      </menu>
      <div class="clear h15"></div>
      <menu id="proshowmenu"></menu>
      <div class="clear"></div>

    </section><!--proinfo_left END-->
    
    <section class="proinfo_right">
    <#if shop??>
      <h3>${shop.title!''}</h3>
      <div class="pro_price">
        
        <p class="p1">
         ${shop.address!''}
        </p>
         <p class="p1">
         所在区域：${shop.city!''}${shop.disctrict!''}
        </p>
         <p class="p1">
        营业时间：${shop.openTimeSpan!''}
        </p>
         <p class="p1">
        门店客服：${shop.serviceTele!''}
        </p>
         <p class="p1">
        投诉电话：${shop.complainTele!''}
        </p>
      </div><!--pro_price END-->
      <table class="pro_choose">
        
        <tr>
          <td colspan="2">
            <!--<input type="submit" class="sub" value="立即购买" />-->
            <a class="sub" style="text-align:center;">地址发送到手机</a>
            <div class="clear"></div>
          </td>
        </tr>
      </table>
    </#if>  
    </section><!--proinfo_right END-->
    <div class="clear h20"></div>
  </div>
  <div class="clear"></div>
  
  </div>
      <div class="clear h20"></div>
</div>
<div class="clear h40"></div>

<#include "/client/common_footer.ftl" />
<!--底部结束-->

</body>
</html>
