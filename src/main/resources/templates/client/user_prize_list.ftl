<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
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
        <div class="mymember_order_search">奖品记录
            <div class="clear"></div>
        </div>
        <table class="tb-void">
    		<tr bgcolor="#CCCCCC" >
    			<td>抽奖日期</td>
                <td>奖项</td>
                <td>奖品</td>                
    		</tr>
            <#if prize_page??>
                <#list prize_page.content as prize>
                    <tr>
                        <td><span class="ftx03">${prize.getTime!''}</span></td>
                        <td>
                            <span class="ftx-02">${prize.typeTitle!''}</span>                                                            </td>
                        </td>
                        <td><#if prize.prizeType == 0>
                                    <em>${prize.typeTitle!''}积分${prize.prizePoints!''}个</em>
                                <#elseif prize.prizeType == 1>
                                    <em>${prize.typeTitle!''}${prize.couponTitle!''}</em>
                                <#elseif prize.prizeType == 2>
                                    <em>${prize.typeTitle!''}${prize.goodsTitle!''}</em>
                                </#if>  </td>                       
                    </tr>
                </#list>
            </#if>   
        </table>
        <div class="myclear" style="height:10px;"></div>
        <div class="mymember_page">
            <#if prize_page??>
                <#assign continueEnter=false>
                <#if prize_page.totalPages gt 0>
                    <#list 1..prize_page.totalPages as page>
                        <#if page <= 3 || (prize_page.totalPages-page) < 3 || (prize_page.number+1-page)?abs<3 >
                            <#if page == prize_page.number+1>
                                <a class="mysel" href="javascript:;">${page}</a>
                            <#else>
                                <a href="/user/myprize/list?page=${page-1}">${page}</a>
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