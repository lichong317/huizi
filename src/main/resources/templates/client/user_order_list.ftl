<!DOCTYPE html>
<head>
<style>
#add_id{
    position:fixed;
    left:0px;
    top:0px;
    z-index:999999;
    width:100%;
    height:100%
}
#kuaidi100{
    margin:auto;
    margin-top:300px;
};

</style>
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
	
	$("#add_id").click(function(){
         $(this).css({display:'none'});
    })  
	
});

function receiveConfirm() {
    if (!confirm("检查货物质量并确认收货？")) {
        window.event.returnValue = false;
    }
}


function cancelConfirm() {
    if (!confirm("未付款可直接取消，是否确认取消订单？")) {
        window.event.returnValue = false;
    }
}

function orderReceive(id)
{
	 $.ajax({
            type:"post",
            url:"/user/order/receive",
            data:{
                "id":id
            },
            success:function(res) {
                if (0 == res.code)
                {
                	alert(res.message);
                    window.location.href= "/user/comment/list";
                }
                else
                {
                    alert(res.message);
                    if (res.message = "请登录！！")
                    {
                    window.location.href="/login"
                    }
                }
            }
        });
}

function recruitment(orderId){

     $.ajax({
            type:"post",
            url:"/order/recruitment",
            data:{
                "orderid":orderId
            },
            success:function(res) {
                if (0 == res.code)
                {
                    $("#kuaidi100").attr('src',res.expressUri);
                    $("#add_id").css("display", "block");
                }
                else
                {
                    alert(res.msg);                    
                }
            }
        });
}

</script>

</head>
<body>
<div id='add_id' style="display:none;">    
     <iframe style="display:block;" name="kuaidi100" id="kuaidi100" src="http://www.kuaidi100.com/kuaidiresult?id=22601109" width="550" height="380" marginwidth="0" marginheight="0" 
          hspace="0" vspace="0" frameborder="0" scrolling="no">
     </iframe>
</div>
<#include "/client/common_header.ftl" />

<div class="myclear"></div>
<div class="mymember_out">
<div class="mymember_main">
  <div class="myclear" style="height:20px;"></div>
  
  <#-- 左侧菜单 -->
  <#include "/client/common_user_menu.ftl" />
  <#-- 左侧菜单结束 -->
  <form name="form1" action="/user/order/list/${status_id}" method="POST" style="float:left;width:82%;">
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
  <div class="mymember_mainbox" style="float:left;width:100%">
    <div class="mymember_info mymember_info02">
      <div class="mymember_order_search" style="*+overflow:hidden;">
        <a class="a001" href="/user/order/list/${status_id?c}">
            <#if status_id==0>
                全部订单
            <#elseif status_id==1>
                待确认订单
            <#elseif status_id==2>
                待付款订单
            <#elseif status_id==3>
                待发货订单
            <#elseif status_id==4>
                待收货订单
            <#elseif status_id==4>
                待评价订单
            <#elseif status_id==6>
                已完成订单
            <#elseif status_id==7>
                已取消订单
            </#if>
        </a>
         <select name="statusId" onchange="javascript:location.href=this.value;">
            <option value="/user/order/list/0" <#if !status_id?? || status_id==0>selected="selected"</#if>>所有订单</option>
            <option value="/user/order/list/1" <#if status_id==1>selected="selected"</#if>>待确认订单</option>
            <option value="/user/order/list/2" <#if status_id==2>selected="selected"</#if>>待付款订单</option>
            <option value="/user/order/list/3" <#if status_id==3>selected="selected"</#if>>待发货订单</option>
            <option value="/user/order/list/4" <#if status_id==4>selected="selected"</#if>>待收货订单</option> 
            <option value="/user/order/list/5" <#if status_id==5>selected="selected"</#if>>待评价订单</option>             
            <option value="/user/order/list/6" <#if status_id==6>selected="selected"</#if>>已完成订单</option>     
            <option value="/user/order/list/7" <#if status_id==7>selected="selected"</#if>>已取消订单</option>    
        </select>
      </div>
        <table>
            <tr class="mymember_infotab_tit01">
                <th>订单信息</th>
                <th width="70">收货人</th>
                <th width="80">订单金额</th>
                <th width="80">
                    <select name="timeId" onchange="javascript:setTimeout(__doPostBack('statusId',''), 0)">
                        <option value="0" <#if !time_id?? || time_id==0>selected="selected"</#if>>所有订单</option>
                        <option value="1" <#if time_id==1>selected="selected"</#if>>最近一个月</option>
                        <option value="3" <#if time_id==3>selected="selected"</#if>>最近三个月</option>
                        <option value="6" <#if time_id==6>selected="selected"</#if>>最近半年</option>
                        <option value="12" <#if time_id==12>selected="selected"</#if>>最近一年</option>                              
                    </select>
                </th>
                <th width="80"></th>
                <th width="60">操作</th>
            </tr>
           
            <#if order_page??>
                <#list order_page.content as order>
                    <tr>
                      <th colspan="7">订单编号：<a href="/user/order?id=${order.id?c}">${order.orderNumber!''}</a></th>
                    </tr>
                    <tr>
                      <td class="td001">
                        <#list order.orderGoodsList as og>
                            <a href="/goods/${og.goodsId?c}"><img src="${og.goodsCoverImageUri}"></a>
                        </#list>
                      </td>
                      <td>${order.shippingName!''}</td>
                      <td>
                        <p>￥${order.totalPrice?string("#.##")}</p>
                        <p>${order.payTypeTitle!''}</p>
                      </td>
                      <td class="td003">
                        ${order.orderTime!''}
                      </td>
                      <td>
                        <p>
                            <#if order.statusId==1>
                                待确认
                            <#elseif order.statusId==2>
                                待付款
                            <#elseif order.statusId==3>
                                待发货
                            <#elseif order.statusId==4>
                             <#--   <h4>正在出库</h4>
                                    <a class="mymember_infotab_show" href="#" onMouseOver="hoverShowInfo('showinfo01')">进度</a>
                                    <div class="mymember_info_show" id="showinfo01">
                                      <i><img src="/client/images/mymember/arrow04.gif" /></i>
                                      <a href="javascript:closeShowInfo();"><img src="/client/images/mymember/close.png" /></a>
                                      <h5>
                                        <span>处理时间</span>
                                        处理信息              </h5>
                                      <p>
                                        <span>2015-02-23 13:11:28</span>
                                        您提交了订单，请等待系统进行确认。              </p>
                                      <p>
                                        <span>2015-02-23 13:11:28</span>
                                        您提交了订单，请等待系统进行确认。              </p>
                                      <p>
                                        <span>2015-02-23 13:11:28</span>
                                        您提交了订单，请等待系统进行确认。              </p>
                                    </div>  -->
                                    <h4><a href="javascript:recruitment(${order.id?c});" style="color:red">快递查询</a></h4>
                            <#elseif order.statusId==5>
                                待评价
                            <#elseif order.statusId==6>
                                已完成
                            <#elseif order.statusId==7>
                                已取消    
                            </#if>
                        </p>
                      </td>
                      <td class="td003"> 
	                     <#if order.statusId == 7>
	                    	<p><a href="/user/cancel?id=${order.id?c}">查看</a></p>
	                    <#elseif order.statusId == 2>	
	                        <p><a href="/order/dopay/${order.id?c}">去付款</a></p>
	                    <#else>
	                        <p><a href="/user/order?id=${order.id?c}">查看</a></p>
	                    </#if>    
                        <#if order.statusId == 1||order.statusId ==2>
                        	<p><a href="/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()">取消订单</a></p>
                        <#elseif order.statusId==3>
                          <#--  <p><a href="/user/cancel/edit?id=${order.id?c}">取消订单</a></p>-->	
                        <#elseif order.statusId==4>
                            <p><a href="javascript:orderReceive(${order.id?c});" onClick="receiveConfirm()">确认收货</a></p>	 
                        <#elseif order.statusId==5>
                            <p><a href="/user/comment/list?keywords=${order.orderNumber!''}">评价晒单</a></p>
                        <#elseif order.statusId == 4 ||order.statusId==5 || order.statusId == 6>   
                            <p><a href="/user/return/list?keywords=${order.orderNumber!''}">申请返修/退换货</a></p>
                        <#elseif order.statusId==2>
                            <p><a href="/order/dopay/${order.id?c}">去付款</a></p>
                        </#if>
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
                            <a href="/user/order/list/${statusId}?page=${page-1}&timeId=${time_id}&keywords=${keywords!''}">${page}</a>
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




  











