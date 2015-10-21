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
<link href="/client/css/gwc.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

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
<!--header结束-->
<div class="mymember_out">
<div class="mymember_main">
  <div class="myclear" style="height:20px;"></div>
  <#-- 左侧菜单 -->
  <#include "/client/common_user_menu.ftl" />
  <#-- 左侧菜单结束 -->
  
  <div class="mymember_mainbox">
    <div class="mymember_info mymember_info04">
      <h3>订单详细</h3>
      <dl>
        <dt>订单编号：${order.orderNumber!''}&nbsp;&nbsp;&nbsp;&nbsp; 下单时间：${order.orderTime!''}&nbsp;&nbsp;&nbsp;&nbsp;当前进度：
            <#if order??>
                <#if order.statusId==1>
                    待确认
                <#elseif order.statusId==2>
                    待付款
                <#elseif order.statusId==3>
                    待发货
                <#elseif order.statusId==4>
                    待收货
                <#elseif order.statusId==5>
                    待评价    
                <#elseif order.statusId==6>
                    已完成
                <#elseif order.statusId==7>
                    已取消                   
                </#if>
            </#if>
        </dt>
        <dt>
            支付总额：<span>￥<#if order??>${order.totalPrice?string("#.##")}</#if></span>
        </dt>
        <dd>
            <#if order??>
                <#if order.statusId==1>
                    请稍等，我们将尽快确认您的订单。
                <#elseif order.statusId==2>
                    亲爱的客户，请付款。
                <#elseif order.statusId==3>
                    亲爱的客户，我们将尽快为您发货。
                <#elseif order.statusId==4>
                    亲爱的客户，商品已发出，请检查商品包装完整。
                <#elseif order.statusId==6>
                    亲爱的客户，此订单已交易成功。
                </#if>
            </#if>
        </dd>
      </dl>
      <div class="mymember_green">
        <#if order??>
            <#if order.statusId==2>
                <p><i></i>订单付款</p>
                <p><i></i><b></b>卖家发货</p>
                <p><i></i><b></b>确认收货</p>
                <p><i></i><b></b>完成</p>
            <#elseif order.statusId==3>
                <p class="mysel"><i></i>订单付款</p>
                <p><i></i><b></b>卖家发货</p>
                <p><i></i><b></b>确认收货</p>
                <p><i></i><b></b>完成</p>
            <#elseif order.statusId==4>
                <p class="mysel"><i></i>订单付款</p>
                <p class="mysel"><i></i><b></b>卖家发货</p>
                <p><i></i><b></b>确认收货</p>
                <p><i></i><b></b>完成</p>
            <#elseif order.statusId==6>
                <p class="mysel"><i></i>订单付款</p>
                <p class="mysel"><i></i><b></b>卖家发货</p>
                <p class="mysel"><i></i><b></b>确认收货</p>
                <p class="mysel"><i></i><b></b>完成</p>
            </#if>
        </#if>
        
        <div class="clear"></div>
      </div>
    </div><!--mymember_info END-->
    
    <#--
    <div class="mymember_info mymember_info04">
      <h3>发货追踪<a id="mymember_order02" href="javascript:myOrderShow('mymember_order02','mymember_ordersum02');">展开</a></h3>
      
      <table id="mymember_ordersum02">
        <tbody><tr>
          <th width="150">处理时间</th>
          <th>处理信息</th>
          <th width="100">操作人</th>
        </tr>
        <tr>
          <td>2015-02-22 18:22</td>
          <td>您的货物已发出</td>
          <td>系统</td>
        </tr>
        <tr>
          <td>2015-02-22 18:22</td>
          <td>到北京中转站</td>
          <td>客户</td>
        </tr>
        <tr>
          <td>2015-02-22 18:22</td>
          <td>您的申请已取消！</td>
          <td>客户</td>
        </tr>
      </tbody></table>
    </div>
    -->
    <div class="mymember_info mymember_info04">
      <h3>订单详细信息<a id="mymember_order01" href="javascript:myOrderShow('mymember_order01','mymember_ordersum01');">展开</a></h3>
      
      <table id="mymember_ordersum01" class="mymember_sq_tab">
        <tbody>
        <tr>
          <th width="100">订单编号</th>
          <td><#if order??>${order.orderNumber!''}</#if></td>
        </tr>
        <tr>
          <th>订单总额</th>
          <td>
            总额:
            <font color="#ff1000">￥<#if order??>${order.totalPrice?string("0.00")}</#if></font>
            &nbsp;&nbsp;=&nbsp;&nbsp;商品总金额:￥${order.totalGoodsPrice?string("0.00")}
            &nbsp;&nbsp;+&nbsp;&nbsp;配送费用:￥${order.deliverTypeFee?string("0.00")}
            &nbsp;&nbsp;-&nbsp;&nbsp;积分抵扣:￥${order.pointUse!'0'}
            &nbsp;&nbsp;&nbsp;&nbsp;支付方式：${order.payTypeTitle!''}
          </td>
        </tr>
        <tr>
          <th>配送详情</th>
          <td>配送地址：${order.shippingAddress!''}&nbsp;&nbsp;&nbsp;&nbsp; 配送方式：${order.deliverTypeTitle!''}&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <th>联系方式</th>
          <td>联系人：<#if order??>${order.shippingName!''}</#if> &nbsp;&nbsp;&nbsp;&nbsp; 联系电话：${order.shippingPhone!''}</td>
        </tr>
      </tbody></table>
    </div><!--mymember_info END-->
    
    <div class="mymember_info mymember_info02">
      <table>
        <tbody>
        <tr class="mymember_infotab_tit01">
          <th colspan="2">商品信息</th>
          <th>单价</th>
          <th>数量</th>
        </tr>   
        <#if order?? && order.orderGoodsList??>
            <#list order.orderGoodsList as og>
                <tr>
                  <td width="60" class="td001">
                    <a href="/goods/${og.goodsId?c}"><img src="${og.goodsCoverImageUri}"></a>
                  </td>
                  <td><a href="/goods/${og.goodsId?c}">${og.goodsTitle}</a></td>
                  <td>${og.price?string("#.##")}</td>
                  <td>${og.quantity!''}</td>
                </tr>
            </#list>
        </#if>
      </tbody></table>
      
    </div><!--mymember_info END-->

    </div><!--mymember_mainbox END-->

  <div class="myclear"></div>  
</div><!--mymember_main END-->
<div class="myclear"></div>
</div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
</body>
</html>
<!--结束-->
