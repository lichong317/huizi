<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>惠资生活</title>
<meta name="keywords" content="惠资生活" />
<meta name="description" content="惠资生活" />
<meta name="copyright" content="惠资生活 版权所有" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/css/gwc.css" rel="stylesheet" type="text/css" />
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/jquery.cityselect.js"></script>
<script src="/client/js/lhgdialog.js"></script>
<script src="/client/js/order_info.js"></script>
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
<!-- header结束 -->

<!--mymember-->
<div class="myclear"></div>
<div class="mymember_out">
    <div class="gwcbg">
        <div class="main mt10">
            <div class="weizhi"> <span>您现在的位置：</span><a href="/">首页</a>&gt;<a href="#">订单提交</a> </div>
            <div class="s_gwc3 mt10"><span >1、我的购物车</span><span>2、我的订单信息</span><span id="colorfff">3、提交成功</span></div>
        </div> 
     <div class="main">
        <div class="buy_ok">
          <div class="fll mt40 mr25"> <img src="/client/images/zq.png" /></div>
          <div class="fll">
            <div class="ok_a haoh"><span>感谢您，订单提交成功！ </span></div>
            <div class="pt10 haoh color666"><span>订单号：<#if order??>${order.orderNumber!''}</#if></span></div>
            <div class="pt10 haoh color666"><span>货到付款：<strong class="f24"><#if order??>${order.totalPrice?string("0.00")}</#if></strong>元</span></div>
            
            <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_tieba" data-cmd="tieba" title="分享到百度贴吧"></a><a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></div>
            <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin","tieba","sqq"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin","tieba","sqq"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
        </script><br />
            <div class="pt10 fll"> <a href="/" class="c9">继续去浏览商品 》</a></div>
          </div>
          
          <div class="flr">
            
            <p><img src="<#if site??>${site.wxQrCode!''}</#if>"  width="81" height="81"/></p>
            <p class="pt5">关注官方微信<br /></p>
          </div>
        </div>
     </div> 
      
     <div class="main">
        <div class="sx_list2">
          <h4>购买此商品的人还购买了</h4>
          <#if recommend_goods_page?? && recommend_goods_page.content?size gt 0>
                <#list recommend_goods_page.content as goods>
                        <ul>
                            <#if goods_index <5>
                                  <li>
                                       <a href="/goods/${goods.id?c}"><img src="${goods.coverImageUri!''}" height="190" width="190" title="${goods.title!''} ${goods.subTitle!''}"/>
                                       <p>${goods.title!''} ${goods.subTitle!''}</p>
                                       <b>￥${goods.salePrice?string("0.00")}</b> </a>
                                  </li>
                            </#if> 
                        </ul>
                </#list>
          </#if>
          
          <div class="clear"></div>
        <div class="mt40"></div>
        </div>
     </div> 
      
 </div>                     
<!--主体结束-->
<#include "/client/common_footer.ftl" />

</body>
</html>
<!--结束-->