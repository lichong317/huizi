<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
      <div class="mymember_info mymember_info02">
        <div class="mymember_order_search"> 
            <a class="a001" href="/user/return/list">取消订单记录 </a>
            <div class="clear"></div>
        </div>
        
        <table align="left">
            <tr class="mymember_infotab_tit01">
			  <th width="70">订单编号</th>
	          <th>订单商品</th>
	          <th width="70">提交时间</th>
	          <th width="80">支付明细</th>
			  <th width="80">退款状态</th>         
	          <th width="60">操作</th>
            </tr>
            <#if cancel_page??>
                <#list cancel_page.content as return>
                    <tr>
                    	<td>${return.orderNumber!'' }</td>
                      <td class="td001"><a href="/goods/${return.goodsId!'' }"><img src="${return.goodsCoverImageUri!''}" /></a></td>
			          <td class="td003">
			            <p>${return.cancelApplyTime?string("yyyy-MM-dd")!'' }</p>
			            <p>${return.cancelApplyTime?string("HH:mm:ss")!'' }</p>
			          </td>
			          <td>订单支付金额：￥${return.totalGoodsPrice?string(0.00)!'' }</td>
					  <td><#if return.statusId==7>已完成<#else>未完成</#if></td>         
			          <td><a href="/user/cancel?id=${return.id?c!''}">查看</a></td>	
                    </tr>
                </#list>
            </#if>
        </table>
        <div class="myclear" style="height:10px;"></div>
        <div class="mymember_page">
            <#if cancel_page??>
                <#assign continueEnter=false>
                <#if cancel_page.totalPages gt 0>
                    <#list 1..cancel_page.totalPages as page>
                        <#if page <= 3 || (cancel_page.totalPages-page) < 3 || (cancel_page.number+1-page)?abs<3 >
                            <#if page == cancel_page.number+1>
                                <a class="mysel" href="javascript:;">${page}</a>
                            <#else>
                                <a href="/user/cancel/list?page=${page-1}">${page}</a>
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

<#include "/client/user_maylike.ftl" />
    </div>
    <!--mymember_center END-->
  </div>
  <!--mymember_main END-->
  <div class="myclear"></div>
</div>
<!--mymember END-->

<#include "/client/common_footer.ftl" />

</div>
</body>
</html>