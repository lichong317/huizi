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
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>

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

function showComplainTr(i, j)
{
    $("#comment-tr" + i + j).toggleClass("hide");
}

</script>
</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<!--mymember-->
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
        <div class="mymember_order_search"> <a class="a001" href="#">投诉</a>
          <form action ="/user/complain/list">
               <input class="mysub" type="submit" value="查询" />
               <input class="mytext" name="keywords" type="text" onFocus="if(value=='商品名称、订单编号') {value=''}" onBlur="if (value=='') {value='商品名称、订单编号'}"  value="商品名称、订单编号" />
          </form>
          <div class="clear"></div>
        </div>
        <table align="left">
          <tr class="mymember_infotab_tit01">
            <th width="70">订单号</th>
            <th>商品信息</th>
            <th width="80">下单时间 </th>
			 <th width="80">操作 </th>
          </tr>
          <tr >
          <#if complain_page??>
          	<#list complain_page.content as item>
          		<#--<#if item.statusId gt 2 && item.statusId != 5>-->
            <td ><a href="/user/order?id=${item.id?c}">${item.orderNumber}</a></td>
            <td align="left"><table width="100" border="0"  align=left>
                <tr>
                <#list item.orderGoodsList as og>
                     <td><img width="50" height="50" title="${og.goodsTitle!''}" src="${og.goodsCoverImageUri}" /> 
                     </td>
                </#list>
                </tr>
              </table></td>
            <td ><p>${item.orderTime?string("yyyy-MM-dd")}</p>
              <p>${item.orderTime?string("HH-mm-ss")}</p></td>
			  <td><a href="javascript:evaluateShow('mymember_eva${item.id?c}','mymember_evabox');">我要投诉</a></td>
          </tr>
		     <tr id="mymember_eva${item.id?c}" class="mymember_evabox">
          <td class="td004" colspan="4">
            <form class="complainForm${item.id?c}" action="/user/complain/add">
            <input type="hidden" name="orderId" value=${item.id?c} />
            <input type="hidden" name="orderNumber" value=${item.orderNumber} />
            <span style="position:absolute;right:88px;top:-13px;"><img src="/client/images/mymember/arrow06.gif" /></span>
            <div class="mymember_eva_div">
			涉及订单：${item.orderNumber!''}&nbsp;&nbsp;&nbsp;&nbsp;投诉类型： <select name="type">
              <option value="产品相关">产品相关</option>
              <option value="价格相关">价格相关</option>
              <option value="服务相关">服务相关</option>
              <option value="物流相关">物流相关</option>
              <option value="其他相关">其它相关</option>
            </select>
          
            </div>
            <div class="mymember_eva_div">
              <b><font>* </font>投诉内容：</b>
              <textarea name="content" datatype="*5-255"></textarea>
            </div>         
            <div class="mymember_eva_div">
              <input class="mysub" type="submit" value="提交我的投诉" />
            </div>
            </form>
          </td>
        </tr>
<script>        
        $(document).ready(function(){  
     //初始化表单验证
    $(".complainForm${item.id?c}").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
                alert("提交投诉成功");
                window.location.reload();
            }
            else
            {
                alert(data.message);
            }
        }
    });
});         
</script>
     <#--   </#if> -->
        </#list>
        </#if>
		  
        </table>
        <div class="myclear" style="height:10px;"></div>
        <div class="mymember_page"> 
        		<#--<a class="mysel" href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a> -->
        		
        		<#if complain_page??>
                <#assign continueEnter=false>
                <#if complain_page.totalPages gt 0>
                    <#list 1..complain_page.totalPages as page>
                        <#if page <= 3 || (complain_page.totalPages-page) < 3 || (complain_page.number+1-page)?abs<3 >
                            <#if page == complain_page.number+1>
                                <a class="mysel" href="javascript:;">${page}</a>
                            <#else>
                                <a href="/user/complain/list?page=${page-1}&keywords=${keywords!''}">${page}</a>
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
      <!--mymember_info END-->

      <!--mymember_info END-->
      <script type="text/javascript">
      $(document).ready(function(){
         mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
    });
    </script>
    </div>

    <!--mymember_center END-->
          <#include "/client/user_maylike.ftl" />
  </div>
  
  <!--mymember_main END-->
  <div class="myclear"></div>

</div>

<!--mymember END-->
      <#include "/client/common_footer.ftl" />
</div>

</body>
</html>