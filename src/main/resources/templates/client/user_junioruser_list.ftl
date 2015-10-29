<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
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
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<div class="myclear"></div>
<div class="mymember_out">
  <div class="mymember_main">
    <!--mymember_head END-->
    <div class="myclear" style="height:20px;"></div>
    <#-- 左侧菜单 -->
    <#include "/client/common_user_menu.ftl" />
    <#-- 左侧菜单结束 -->
  
    <div class="mymember_mainbox">
      <div class="mymember_info mymember_info02">
        <div class="mymember_order_search"> 下级用户 (<#if user?? && user.totalLowerUsers??>${user.totalLowerUsers}</#if>)人
            <div class="clear"></div>
        </div>
        <table class="tb-void">
            <tr bgcolor="#CCCCCC" >
                <td>序号</td>
                <td>用户名</td>
                <td>用户级别</td>
                <td>消费总额</td>
                <td>返利总额</td>
                <td>操作</td>
            </tr>
            <#if junioruser_page??>
                <#list junioruser_page.content as item>
                    <tr>
                        <td><span class="ftx03">${item_index+1}</span></td>
                        <td>
                            <a href="/user/lowerusers/order/list?lowerusername=${item.username}"><span class="ftx-02">${item.username}</span> </a>
                        </td>
                        <td>${item.userLevelTitle!''}</td>
                        <td>${item.totalSpendCash!'0'}</td>
                        <td>${item.totalCashRewardsToUpuser!'0'}</td>
                        <td> <a href="/user/lowerusers/order/list?lowerusername=${item.username}">查看订单</a></td>
                    </tr>
                </#list>
            </#if>   
        </table>
        <div class="myclear" style="height:10px;"></div>
        <div class="mymember_page">
            <#if junioruser_page??>
                <#assign continueEnter=false>
                <#if junioruser_page.totalPages gt 0>
                    <#list 1..junioruser_page.totalPages as page>
                        <#if page <= 3 || (junioruser_page.totalPages-page) < 3 || (junioruser_page.number+1-page)?abs<3 >
                            <#if page == junioruser_page.number+1>
                                <a class="mysel" href="javascript:;">${page}</a>
                            <#else>
                                <a href="/user/junioruser/list?page=${page-1}">${page}</a>
                            </#if>
                            <#assign continueEnter=false>
                        <#else>
                            <#if !continueEnter>
                                <b class="pn-break">&hellip;</b>
                                <#assign continueEnter=true>
                            </#if>
                        </#if>
                    </#list>
                </#if>
            </#if>
        </div>
      </div>
      <!--mymember_info END-->
                <#include "/client/user_maylike.ftl" />
<script type="text/javascript">
$(document).ready(function(){
     mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
});
</script>
    </div>
    <!--mymember_center END-->
    <div class="myclear"></div>
  </div>
  <!--mymember_main END-->
  <div class="myclear"></div>
</div>
<!--mymember END-->

<#include "/client/common_footer.ftl" />

</div>
</body>
</html>