﻿<!DOCTYPE html>
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
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
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
                    window.location.reload();
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
</script>
</head>
<body>
<#include "/client/common_header.ftl" />

<div class="myclear"></div>
<div class="mymember_out">
<div class="mymember_main">
  <!--mymember_head END-->
  <div class="myclear" style="height:20px;"></div>
  
  <#-- 左侧菜单 -->
  <#include "/client/common_user_menu.ftl" />
  <#-- 左侧菜单结束 -->
  
  <div class="mymember_center">
    <div class="mymember_info mymember_info01">
      <table>
        <tr>
          <th width="150" rowspan="2">
          <a class="mymember_header" onclick="changeHeads();"><img src="${user.headImageUri!'/mag/style/user_avatar.png'}" width="100px" height="100px"/></a></th>
               <script>
                        function changeHeads(){
                            var filebutton = document.getElementById("filebutton");
                            filebutton.click();
                        }
                        function getFile(){
                            document.getElementById("uploadImgForm").submit();
                            
                        }
              </script>
          <td><a href="/user/order/list/2"><img src="/client/images/mymember/buy01.png" />待付款：<span>${total_unpayed!0}</span></a></td>
          <td><a href="/user/order/list/3"><img src="/client/images/mymember/buy02.png" />待发货：<span>${total_undelivered!0}</span></a></td>
          <th rowspan="2" class="mymember_fen">
            <a href="/user/point/list"><img src="/client/images/mymember/buy05.png" /><p>积分：<span>${user.totalPoints!0}</span></p></a>
          </th>
        </tr>
        <tr>
          <td><a href="/user/order/list/4"><img src="/client/images/mymember/buy03.png" />待收货：<span>${total_unreceived!'0'}</span></a></td>
          <td><a href="/user/order/list/6"><img src="/client/images/mymember/buy04.png" />已完成：<span>${total_finished!'0'}</span></a></td>
        </tr>
      </table>
    </div>
                <form id="uploadImgForm" enctype="multipart/form-data" action="/user/center/headImg" method="post">
                    <input style="display:none" name="Filedata" type="file" onchange="getFile();" id="filebutton">
                </from>
    <div class="mymember_info mymember_info02">
    <h3>我的订单<a href="/user/order/list/0">查看全部订单</a></h3>
        <table width="100%">              
        <#if order_page??>
            <#list order_page.content as order>
                <#if order_index < 5>
                <tr>
                    <th colspan="7">订单编号：<a href="/user/order?id=${order.id?c}">${order.orderNumber!''}</a></th>
                </tr>
                <tr>
                    <td colspan="2" align="left" >
                        <#if order.orderGoodsList??>
                            <#list order.orderGoodsList as og>
                                <#if og_index <4>
                                    <a href="/goods/${og.goodsId?c}"><img src="${og.goodsCoverImageUri!''}" alt="${og.goodsTitle!''}" width="50" align="left" /></a>
                                </#if>
                            </#list>
                        </#if>
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
                                <h4>正在出库</h4>
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
                                    </div>        
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
                        <#if order.statusId == 1 ||order.statusId ==2>
                        	<p><a href="/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()">取消订单</a></p>
                        <#elseif order.statusId==3>
                            <p><a href="/user/cancel/edit?id=${order.id?c}">取消订单</a></p>	
                        <#elseif order.statusId==4>
                            <p><a href="javascript:orderReceive(${order.id?c});" onClick="receiveConfirm()">确认收货</a></p>	 
                        <#elseif order.statusId==5>
                            <p><a href="/user/comment/list?keywords=${order.orderNumber!''}">评价晒单</a></p>
                        <#elseif order.statusId == 4 ||order.statusId==5 || order.statusId == 6>   
                            <p><a href="/user/return/list?keywords=${order.orderNumber!''}">申请返修/退换货</a></p>
                        <#elseif order.statusId==2>
                            <p><a href="/order/dopay/${order.id?c}"">去付款</a></p>
                        </#if>        
                    </td>
                </tr>
                </#if>
            </#list>
        </#if> 
        </table>
    </div>
    
    <div class="mymember_info mymember_info02">
	 <h3>我关注的商品</h3>
      <div id="mymember_gzbox">
        <ul>
            <li>
            <#if collect_page??>
                <#list collect_page.content as cgoods>                                  
                    <a class="mymember_gzlist" href="/goods/${cgoods.goodsId?c!''}">
                        <img src="${cgoods.goodsCoverImageUri!''}" alt="${cgoods.goodsTitle!''}" />
                        <p style="overflow: hidden;height: 20px;">${cgoods.goodsTitle!''}</p>
                        <h6>￥${cgoods.goodsSalePrice?string("#.##")}</h6>
                    </a>                                  
                </#list>
            </#if>
            </li>
        </ul>
        <div class="myclear"></div>
        <a id="mymember_gznext" href="javascript:;"><img src="/client/images/mymember/arrow02.jpg" /></a>
      </div>
    </div>
  </div>
  
  <div class="mymember_hot">
    <div class="mymember_hot_part">
      <h3>会员推荐</h3>
      <h4 id="mymember_right_menu">
      </h4>
      <ul id="mymember_right_check">
        <li>
        <#if recommend_goods_page??>
            <#list recommend_goods_page.content as item>                
                  <a class="mymember_hot_list" href="/goods/${item.id?c}">
                    <img src="${item.coverImageUri!''}" />
                    <p style="overflow: hidden;height: 40px;">${item.title!''}</p>
                    <b>￥${item.salePrice?string("0.00")}</b>
                  </a>                
            </#list>
        </#if>
        </li>
      </ul>
    </div><!--mymember_hot_part END-->
    
    <div class="mymember_hot_part">
        <h3>浏览历史</h3>
        <div id="mymember_storybox">
            <ul>
                <li>
                <#if recent_page??>
                    <#list recent_page.content as rgoods>
                        <a class="mymember_hot_story" href="/goods/${rgoods.goodsId}">
                            <img src="${rgoods.goodsCoverImageUri!''}" />
                            <p>￥${rgoods.goodsSalePrice?string("#.##")}</p>
                        </a>
                    </#list>
                </#if>
                </li>
            </ul>
            <div class="myclear"></div>
            <a id="mymember_story_next" href="javascript:;"><img src="/client/images/mymember/arrow02.jpg" /></a>
        </div>
        <div class="myclear"></div>
    </div><!--mymember_hot_part END-->
</div><!--mymember_hot END-->
    
<div class="myclear"></div>
</div>
<script type="text/javascript">
      $(document).ready(function(){
         mymemberMenuCheck("mymember_right_menu","a","mymember_right_check","li","mysel");
		 mymemberRightMove("mymember_storybox",70,90,"mymember_story_next",15,3,"a");
		 mymemberRightMove("mymember_gzbox",205,241,"mymember_gznext",15,3,"a");
		 mymemberRightMove("mymember_shinebox",205,310,"mymember_shinenext",15,3,"div");
      });
</script>

<!--mymember END-->



</div>
<div class="gogo" style="width:100%;clear:both;overflow:hidden;*+margin-left:-560px;+margin-top:-200px;">
<div class="down1">
   <section class="index_center">
        <table>
           <tbody>
                <#if service_item_list??>
                    <tr>
                        <#list service_item_list as item>
                            <#if item_index <4>
                            <td>
                                <a href="javascript:;"><img src="${item.logo!''}" width="55" height="55"/>${item.title!''}<br>${item.description!''}</a>
                            </td>
                            </#if>
                        </#list>
                    </tr>
                </#if>
           </tbody>     
        </table>
    </section><!--index_center END-->
    <div class="clear"></div>
    <div class="main">
        <ul>
            <#if help_level0_cat_list??>
                <#list help_level0_cat_list as items>
                    <li class="downli"><a href="/info/list/${help_id!'1'}?catId=${items.id?c!''}">${items.title!''}</a>
                           <ul>
                                 <#if items_index <7 >
                                       <#if ("help_"+items_index+"_article_list")?eval?? >
                                                <#list ("help_"+items_index+"_article_list")?eval as item> 
                                                        <li><a href="/info/content/${item.id?c!''}?mid=${help_id!'1'}">${item.title!''}</a></li>
                                                </#list> 
                                       </#if> 
                                 </#if>
                           </ul>
                    </li>
                </#list>
            </#if>
 
        </ul>

    </div>
</div>
<div class="down2">
    <div class=" erweima main">

        <div class="saoyisao">
            <img src="<#if site??>${site.androidQrCode!''}</#if>" width="81" height="81"/>
            <h3><a href="#">安卓客户端</a></h3> 
        </div>
      
        <div class="saoyisao">
            <img src="<#if site??>${site.iOsQrCode!''}</#if>" width="81" height="81" />
            <h3><a href="#">IOS客户端</a></h3> 
        </div>
    
        <div class="saoyisao">
            <img src="<#if site??>${site.wxQrCode!''}</#if>" width="81" height="81" />
            <h3><a href="#">微信公众号</a></h3> 
        </div>     
        <div class="mendian">
            <img src="/client/images/hzd_52.png" width="87" height="71"/>
            <h3><a href="/shop/list">门店查询</a></h3>
        </div>
        <div class="dizhi">
            <p>
                <span><#if site??>${site.company!''}</#if></span><br>
                <span>地址：</span><#if site??>${site.address!''}</#if><br>
                <span>电话：</span><#if site??>${site.telephone!''}</#if><br>
            </p>
        </div>
    </div>
</div>
<div class="down3">
    <div class="main">
          <ul class="downwenzi">
        
           <#if about_us_list??>
                <#list about_us_list as item>
                       <#if item_has_next>
                             <li><a href="/info/list/${about_id!'0'}?catId=${item.id?c!''}">${item.title!''}</a>丨</li>
                         <#else>
                             <li><a href="/info/list/${about_id!'0'}?catId=${item.id?c!''}">${item.title!''}</a></li>   
                       </#if>
                       
                </#list>
           </#if>
        
          </ul>
        <div class="clear"></div>
          <p>
 
              <#if site??>${site.copyright!''}</#if> 
              <br />
              ${site.address!''} 电话：${site.telephone!''}

              <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>
          </p>
    </div>
</div>
</div>
</body>
</html>




  











