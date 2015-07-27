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
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
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

    <div class="mymember_info">
      <div class="mymember_order_search">
        <a class="a001" href="/user/comment/list">全部评论</a>
        
        <div class="clear"></div>
      </div>
      
        <table class="mymember_evaluate">
            <tr>
                <th colspan="2">商品信息</th>
                <th width="200">评价状态</th>
            </tr>
            <#if comment_page??>
                <#list comment_page.content as comment>
                <tr>
                    <td>
                       <a href="/goods/${comment.goodsId}">
                            <img src="${comment.goodsCoverImageUri!''}" width="50" height="50" title="${comment.goodsTitle!''}">                                             </a>                                        </td>
                    <td>
                       <a target="_blank" href="/goods/${comment.goodsId}">${comment.goodsTitle!''}</a>
                    </td>
                    <td>
                        我的评论：${comment.content!''}
                        <br>
                        ${comment.commentTime!''}
                        <br>
                        <#if comment.isReplied>
                        ${comment.reply!''}
                        <#else>
                        （暂无回复）
                        </#if>    
                    </td>
                </tr>   
                </#list>
            </#if>  
        </table>
      
      <div class="myclear" style="height:10px;"></div>
      <div class="mymember_page">
        <#if comment_page??>
            <#assign continueEnter=false>
            <#if comment_page.totalPages gt 0>
                <#list 1..comment_page.totalPages as page>
                    <#if page <= 3 || (comment_page.totalPages-page) < 3 || (comment_page.number+1-page)?abs<3 >
                        <#if page == comment_page.number+1>
                            <a class="mysel" href="javascript:;">${page}</a>
                        <#else>
                            <a href="/user/comment/list?page=${page-1}&keywords=${keywords!''}">${page}</a>
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
    </div><!--mymember_info END-->

  </div><!--mymember_center END-->
  
<div class="myclear"></div>
</div>
<!--mymember END-->
<div class="clear h40"></div>
<#include "/client/common_footer.ftl" />
</div>
</body>
</html>




  











