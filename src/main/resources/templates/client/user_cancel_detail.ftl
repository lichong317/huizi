<!DOCTYPE html>
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
<!--header结束-->
<div class="mymember_out">
<div class="mymember_main">
  <div class="myclear" style="height:20px;"></div>
  <#-- 左侧菜单 -->
  <#include "/client/common_user_menu.ftl" />
  <#-- 左侧菜单结束 -->
  
  <div class="mymember_mainbox">
    <div class="mymember_info mymember_info04">
      <h3>取消订单记录</h3>
      <dl>
        <dt>订单编号：${order.orderNumber!''}&nbsp;&nbsp;&nbsp;&nbsp; 取消进度：完成&nbsp;&nbsp;&nbsp;&nbsp; 支付总额：<span>￥<#if order??>${order.totalPrice?string("#.##")}</#if></span></dt>
        <dd>
             <#if order??>
                <#if order.statusId==7&&order.isRefund??&&order.isRefund>
                    亲爱的客户，此订单已取消成功。
                </#if>    
                <#if order.statusId==3&& order.isCancel&&order.isCancel??>
                    亲爱的客户，请稍等，正在处理。
                 </#if>    
                <#if order.statusId==7&&order.isRefund??&&!order.isRefund||order.statusId == 7&&!order.isRefund??>
                    亲爱的客户，订单已取消，正在为您退款
                </#if>
            </#if>
        </dd>
      </dl>
      <div class="mymember_green">
            <#if order??>
                <#if order.statusId==7&&order.isRefund??&&order.isRefund>
				        <p class="mysel"><i></i>提交申请</p>
				        <p class="mysel"><i></i><b></b>取消处理</p>
				        <p class="mysel"><i></i><b></b>退款处理</p>
				        <p class="mysel"><i></i><b></b>完成</p>
				 </#if>
                 <#if order.statusId==3&& order.isCancel&&order.isCancel??>
                    	<p class="mysel"><i></i>提交申请</p>
				        <p class="mysel"><i></i><b></b>取消处理</p>
				        <p><i></i><b></b>退款处理</p>
				        <p><i></i><b></b>完成</p>
				</#if>        
                <#if order.statusId==7&&order.isRefund??&&!order.isRefund||order.statusId == 7&&!order.isRefund??>
                    <p class="mysel"><i></i>提交申请</p>
				        <p class="mysel"><i></i><b></b>取消处理</p>
				        <p class="mysel"><i></i><b></b>退款处理</p>
				        <p><i></i><b></b>完成</p>
                </#if>
            </#if>
        <div class="clear"></div>
      </div>
    </div><!--mymember_info END-->
    
    <div class="mymember_info mymember_info04">
      <h3>取消申请进度<a id="mymember_order02" href="javascript:myOrderShow('mymember_order02','mymember_ordersum02');">展开</a></h3>
      
      <table id="mymember_ordersum02">
        <tr>
          <th width="150">处理时间</th>
          <th>处理信息</th>
          <th width="100">操作人</th>
        </tr>
        <#if order.cancelApplyTime??&&order.statusId == 7 &&!order.refundTime??>
         <tr>
          <td>${order.cancelApplyTime!''}</td>
          <td>未付款订单已取消！</td>
          <td>客户</td>
        </tr>
        <#else>
	        <#if order.cancelApplyTime??>
	        <tr>
	          <td>${order.cancelApplyTime!''}</td>
	          <td>提交申请！</td>
	          <td>客户</td>
	        </tr>
	        </#if>
	        <#if order.cancelTime??>
	        <tr>
	          <td>${order.cancelTime!''}</td>
	          <td>订单已取消！</td>
	          <td>商家</td>
	        </tr>
	        </#if>
	        <#if order.refundTime??>
	        <tr>
	          <td>${order.refundTime!''}</td>
	          <td>商家已退款，订单取消完成！</td>
	          <td>商家</td>
	        </tr>
	        </#if>
	    </#if>    
      </table>
    </div><!--mymember_info END-->
    
    <div class="mymember_info mymember_info04">
      <h3>申请单详细信息<a id="mymember_order01" href="javascript:myOrderShow('mymember_order01','mymember_ordersum01');">展开</a></h3>
      
      <table id="mymember_ordersum01" class="mymember_sq_tab">
        <tr>
          <th width="100">订单编号</th>
          <td>${order.orderNumber!''}</td>
        </tr>
        <tr>
          <th>支付明细</th>
          <td>支付总额：<font color="#ff1000">￥<#if order??>${order.totalPrice?string("0.00")}</#if></font></td>
        </tr>
        <#if order.cancelReason??>
        <tr>
          <th>退款金额</th>
          <td>￥${order.refund?string("0.00")!'0.00'}</td>
        </tr>
        <tr>
          <th>取消原因</th>
          <td>${order.cancelReason!''}</td>
        </tr>
        </#if>
        <tr>
          <th>联系方式</th>
          <td>联系人：${order.shippingName!''} &nbsp;&nbsp; 联系电话：${order.shippingPhone!''}</td>
        </tr>
      </table>
    </div><!--mymember_info END-->

    </div><!--mymember_mainbox END-->

  <div class="myclear"></div>  
</div><!--mymember_main END-->
<div class="myclear"></div>
</div>
<!--mymember END-->

<#include "/client/common_footer.ftl" />
</body>
</html>




  











