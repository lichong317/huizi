<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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
            <a class="a001" href="/user/return/list">申请返修/退换货</a>
            <form action="/user/return/list" method="post">
            	<input type="hidden" name="timeId" value="${time_id!''}"/>
          		<input class="mysub" type="submit" value="查询" />
          		<input class="mytext" type="text" name="keywords" onFocus="if(value=='订单编号') {value=''}" onBlur="if (value=='') {value='订单编号'}"  value="订单编号" />
            </form>
            <div class="clear"></div>
        </div>
        
        <table align="left">
            <tr class="mymember_infotab_tit01">
			  <th width="70">订单编号</th>
	          <th>订单商品</th>
              <th width="80"> <select>
                  <option value="0" selected>下单时间</option>
                  <option value="1" >最近一个月</option>
                  <option value="3">最近三个月</option>
                  <option value="6">最近六个月</option>
                  <option value="12">今年内</option>
                </select>
              </th>
            </tr>
            <#if return_page??>
                <#list return_page.content as return>
                    <tr>
                    	<td>${return.orderNumber!'' }</td>
                      <td class="td001">
	                      <table width="100" border="0"  align=left>
		                      <tr>
		                      <#list return.orderGoodsList as og>
			                      <td>
				                      <a href="/goods/${og.goodsId?c!'' }"><img width="50" height="50" src="${og.goodsCoverImageUri!''}" title="${og.goodsTitle!''}"/></a><br/>
				                      <#if og.isReturnApplied?? &&og.isReturnApplied>
				                      	<a href="/user/return/${return.id?c}?id=${og.id?c}" title="点击查看详情">已申请</a>
				                      <#else>	
				                      	<a href="/user/return/${return.id?c}?id=${og.id?c}" title="点击申请退换货">申请</a>
				                      </#if>	
			                      </td>
			                    </#list>
		                      </tr>
	                      </table>
                      </td>

			          <td class="td003">
			            <p>${return.orderTime?string("yyyy-MM-dd")!'' }</p>
			            <p>${return.orderTime?string("HH:mm:ss")!'' }</p>
			          </td>

                    </tr>
                </#list>
            </#if>
        </table>
        <div class="myclear" style="height:10px;"></div>
        <div class="mymember_page">
            <#if return_page??>
                <#assign continueEnter=false>
                <#if return_page.totalPages gt 0>
                    <#list 1..return_page.totalPages as page>
                        <#if page <= 3 || (return_page.totalPages-page) < 3 || (return_page.number+1-page)?abs<3 >
                            <#if page == return_page.number+1>
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