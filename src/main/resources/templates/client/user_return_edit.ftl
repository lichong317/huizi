
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
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

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
<script type="text/javascript">
$(function () {
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3,
        success:function(){
        alert("申请成功，我们将尽快处理。")
        }
    });
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
        退换货——服务单明细
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                        <th width="260" style="text-align:center;">商品名称</th>
                        <th width="170" style="text-align:center;">销售方式</th>
                        <th width="105" style="text-align:center;">购买数量</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <ul class="list-proinfo" id="removeTheSingleGife">
                            <li class="fore1">
                                <a href="http://item.jd.com/1448733811.html" target="_blank">
                                    <img height="50" width="50" title="${order_goods.goodsTitle!''}-${order_goods.goodsSubTitle!''}"
                                         src="${order_goods.goodsCoverImageUri!''}" data-img="1" alt="">
                                </a><div class="p-info"><a href="/goods/${order_goods.goodsId!''}" target="_blank">${order_goods.goodsTitle!''}</a></div>
                            </li>
                       </ul>
                    </td>                  
                    <td>
							${order_goods.goodsSaleType!'-'}
			        </td>
                    <td>${order_goods.quantity!'1'}</td>
                </tr>
                </tbody>
            </table>
            <form action ="/user/return/save" id="form1" method="post">
			<table width="100%" border="0">
			  <tr>
			    <td> <span style="position:absolute;right:88px;top:-13px;"><img src="/client/images/mymember/arrow06.gif" /></span>
			            <input type="hidden" name="id" value="${orderId}" />
			            <input type="hidden" name="goodsId" value="${goodsId}" />
			            <input type="hidden" name="telephone" value="${telephone}" />
			            <div style="height:30px;margin-top:30px;">
			           		  <label style="float:left;margin-left:200px;"><input type="radio" name="isReturn" value="true" <#if has_returned??&&has_returned&&return.isReturn?? && return.isReturn> checked="checked" </#if>/>退货</label>
			                  <label style="float:left;margin-left:30px;"><input type="radio" datatype="*" name="isReturn" value="false" <#if has_returned??&&has_returned&&return.isReturn?? && !return.isReturn> checked="checked" </#if>/>换货</label>
			             </div>
			             <div  class="mymember_eva_div">
			             	<b><font>* </font>数量：</b>
			                <input type="text" name="returnNumber" datatype="*" nullmsg="请填写退换货的数量" style="width:24px;"   <#if has_returned?? &&has_returned>value="${return.returnNumber!''}" disabled="disabled"</#if> />
			            </div>
			            <div class="mymember_eva_div">
			              <b><font>* </font>问题描述：</b>
			              <#if has_returned?? &&has_returned>
			              	<textarea name="reason" disabled="disabled">${return.reason!''}</textarea>
			              	<h3 style="text-align:right;color:#666;margin:20px 0;">状态：<#if return.statusId ==1><span style="color:#0060aa;text-align:right;">已处理</span><#else><span style="color:#fd3e3e;text-align:right;">待处理</span></#if></h3>
			              <#else>	
			             	 <textarea name="reason" datatype="*5-255"></textarea>
			             	 </div>
			            <div class="mymember_eva_div">
			              <input class="mysub" type="submit" value="提交" />
			            </div>
			              </#if>
			            
			      </td>
			  </tr>
			</table>
			</form>      
        <div class="myclear" style="height:10px;"></div>
      </div>
      <!--mymember_info END-->
     	<#include "/client/user_maylike.ftl" />
      <!--mymember_info END-->
      <script type="text/javascript">
      $(document).ready(function(){
         mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
    });
    </script>
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