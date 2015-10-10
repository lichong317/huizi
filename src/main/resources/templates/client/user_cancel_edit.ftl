
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
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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
        取消订单
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                        <th width="230" style="text-align:center;">订单编号</th>
                        <th width="100" style="text-align:center;">商品总价</th>
                        <th width="100" style="text-align:center;">订单总价</th>
                        <th width="105" style="text-align:center;">下单时间</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
							${order.orderNumber!''}
			        </td>
                    <td>
                       		 ￥${order.totalGoodsPrice?string("#.##")!'0'}
                    </td>                  
                    <td>
                       		 ￥${order.totalPrice?string("#.##")!'0'}
                    </td>       
                    <td>${order.orderTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                </tr>
                </tbody>
            </table>
            <form action ="/user/cancel/save" id="form1" method="post">
			<table width="100%" border="0">
			  <tr>
			    <td> <span style="position:absolute;right:88px;top:-13px;"><img src="/client/images/mymember/arrow06.gif" /></span>
			            <input type="hidden" name="id" value="${orderId?c}" />
			            <div class="mymember_eva_div">
			              <b><font>* </font>取消原因：</b>
			              <#if order.isCancel?? &&order.isCancel>
			              	 <textarea name="cancelReason" datatype="*2-255" disabled="disabled" >${order.cancelReason!''}</textarea>
			             </div>
			              <div class="mymember_eva_div">
			              <h3>已提交申请</h3>
			              <#else>	 
			             	 <textarea name="cancelReason" datatype="*2-255"></textarea>
			             	 </div>
			              <div class="mymember_eva_div">
			              <input class="mysub" type="submit" value="提交" />
			              </#if>
			            </div>
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