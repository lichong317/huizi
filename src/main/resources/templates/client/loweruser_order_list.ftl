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
<#include "/client/common_header.ftl" />

<div class="myclear"></div>
<div class="mymember_out">
<div class="mymember_main">
  <div class="myclear" style="height:20px;"></div>
  
  <#-- 左侧菜单 -->
  <#include "/client/common_user_menu.ftl" />
  <#-- 左侧菜单结束 -->
  <form name="form1" action="/user/lowerusers/order/list" method="POST">
<script type="text/javascript">
    var theForm = document.forms['form1'];
    if (!theForm) {
        theForm = document.form1;
    }
    function __doPostBack(eventTarget, eventArgument) {
        if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
            theForm.submit();
        }
    }
</script>
  <div class="mymember_mainbox">
    <div class="mymember_info mymember_info02">
      <div class="mymember_order_search">
        <a class="a001" href="javascript:;">
            订单列表
        </a>        
      </div>
        <table>
            <tr class="mymember_infotab_tit01">
                <th>订单信息</th>
                <th width="80">订单金额</th>
                <th width="80">返利比例</th>
                <th width="80">返利金额</th>
                <th width="80">状态</th>               
            </tr>    
            <#if order_page??>
                <#list order_page.content as order>
                    <tr>
                      <th colspan="7">订单编号：<a href="javascript:;">${order.orderNumber!''}</a></th>
                    </tr>
                    <tr>
                      <td class="td001">
                        <#list order.orderGoodsList as og>
                            <a href="/goods/${og.goodsId?c}"><img src="${og.goodsCoverImageUri}"></a>
                        </#list>
                      </td>
                      <td>
                        <p>￥${order.totalPrice?string("0.00")}</p>                       
                      </td>
                      <td class="td003">
                        <#if setting?? && setting.returnRation??>
                        	${setting.returnRation}
                        </#if>
                      </td>
                      <td>
                        <#if setting?? && setting.returnRation??>
                        	${setting.returnRation * order.totalPrice}
                        </#if>
                      </td>
                      <td class="td003"> 
	                    已返现
                      </td>
                    </tr>
                </#list>
            </#if>
        </table>
        <div class="myclear" style="height:10px;"></div>
        <div class="mymember_page">
            <#if order_page??>
            <#assign continueEnter=false>
            <#if order_page.totalPages gt 0>
                <#list 1..order_page.totalPages as page>
                    <#if page <= 3 || (order_page.totalPages-page) < 3 || (order_page.number+1-page)?abs<3 >
                        <#if page == order_page.number+1>
                            <a class="mysel" href="javascript:;">${page}</a>
                        <#else>
                            <a href="/user/lowerusers/order/list?page=${page-1}">${page}</a>
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
    </form>
</div>
  
<div class="myclear"></div>
</div>
<!--mymember END-->

<div class="clear h40"></div>
<#include "/client/common_footer.ftl" />
</div>
</body>
</html>




  











