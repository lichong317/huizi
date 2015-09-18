<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />    
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  $(document).ready(function(){
	menuDownList("top_phone","#top_phonelist",".a1","sel");
	phoneListMore();//单独下拉
    menuDownList("top_order","#top_orderlist",".a4","sel");//顶部下拉
	searchTextClear(".toptext","请输入品牌或商品名称","#999","#666");
	searchTextClear(".bottext","查看所有门店","#fff","#fff");
	checkNowHover("shopping_down","shopping_sel");
	navDownList("navdown","li",".nav_showbox");
	//menuDownList("mainnavdown","#navdown",".a2","sel");
	
	chooseMoreShow();
		
});
</script>
</head>
<body>
<div class="maintop">
<section class="main">
    <h1>亲，欢迎来到惠之店网上商城</h1>
    <p class="p2"><#if site??>${site.telephone!''}</#if></p>
    <p class="p3">服务热线：</p>
   <menu id="top_phone">
      <a class="a1" href="javascript:;">手机惠之店</a>
      <div class="clear"></div>
      <ul class="phone_sum" id="top_phonelist">
        <li style="padding-top:10px;"><a href="<#if site??>${site.touchUri!'/'}</#if>"><span class="phoneico01">触屏版</span></a></li>
        <li><a href="javascript:;"><span class="phoneico03">iPhone</span></a></li>
        <li style="border-bottom:1px solid #eee; padding-bottom:10px;"><a href="javascript:;"><span class="phoneico04">Android</span></a></li>
        <li class="phone_sum_more">
          <p>
            <span>扫描二维码下载iPhone客户端</span>
            <span class="mt5"><img src="<#if site??>${site.iOsQrCode!''}</#if>" /></span>
          </p>
          <p>
            <span>扫描二维码下载Android客户端</span>
            <span class="mt5"><img src="<#if site??>${site.androidQrCode!''}</#if>" /></span>
          </p>
        </li>
      </ul>
    </menu>
    <#if username??>
        <a class="a" href="/user" style="float:left; color:#ff4040;">${username}<i></i></a>
        <a class="a" href="/logout" style="float:left;">退出<i></i></a>
    <#else>
        <a class="a" href="/login" style="float:left; color:#ff4040;" target="_blank">登陆<i></i></a>
        <a class="a" href="/reg" style="float:left;" target="_blank">注册<i></i></a>
    </#if>
    <a class="a2" href="#">在线咨询</a>
    <a class="a3" href="/user">会员俱乐部</a>
    <a class="z-in10" href="/info/list/12">帮助中心</a>
    <a class="a4" href="/user/order/list/0">我的订单<i></i></a>
    <div class="clear"></div>
</section>
</div>

<div class="main top1 pb20">
<div class="clear"></div>
<div class="logo"><a href="/"><img src="<#if site??>${site.logoUri!''}</#if>" border="0" /></a></div>
<div class="ssbox">
    <div class="clear"></div>
    <form action="/search" method="get">
        <input type="text" class="ss_txt" name="keywords"/>
        <input type="submit" class="ss_btn" value="" />
    </form>
    <div class="clear"></div>
    <p>
        <#if keywords_list??>
            <#list keywords_list as item>
                <a href="${item.linkUri!''}">${item.title}</a>
            </#list>
        </#if>
    </p>
</div>
        <div id="shopping_down" class="shopping_box">
         <span class="sp1"><#if cart_goods_list??>${cart_goods_list?size}<#else>0</#if></span>
         <a class="a1" href="/cart">去购物车结算<i></i></a>
<menu>
      <#if cart_goods_list?? && cart_goods_list?size gt 0>
<script>
function delItem(id)
{
    if (null == id)
    {
        return;
    }
    
    $.ajax({
        type:"post",
        url:"/cart/del",
        data:{"id": id},
        success:function(data){
            location.reload();
        }
    });
}
</script>
          <#assign totalGoods=0>
          <#assign totalPrice=0>
          <h2>最新加入的商品</h2>
          <!-- lc-->
          <#list cart_goods_list as item>
                    <div class="shopping_list">
                        <div class="clear"></div>
                        <a class="a2" href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" /></a>
                        <a class="a3" href="/goods/${item.goodsId?c}">${item.goodsTitle!''}</a>
                        <p>￥<#if item.price??>${item.price?string("0.00")} x ${item.quantity!''}</#if><a href="javascript:delItem(${item.id?c});">删除</a></p>
                        <div class="clear"></div>
                    </div>                  
                        <#if item.price??>
                            <#assign totalPrice=totalPrice+item.price*item.quantity>
                        </#if>                 
          </#list>
                  <h4 class="shopping_price">
                                                                             共<#if cart_goods_list??>${cart_goods_list?size}<#else>0</#if>件商品 &nbsp;&nbsp;共计<span class="fw-b">￥${totalPrice?string("0.00")}</span>
                    <a href="/cart">去结算</a>
                  </h4>
      <#else>
        <h3 class="ta-c pa15 fs14 fw400">购物车中还没有商品，赶紧选购吧！</h3>
      </#if>
    </menu>
</div>
  <div class="clear"></div>
</div>

<aside class="floatbox">
  <a href="#" title="微信客服"><img src="/client/images/float_ico01.png" width="42" height="42" alt="微信客服" /><span><img src="/client/images/hzd_55.png" /></span></a>
  <a href="#" title="在线咨询"><img src="/client/images/float_ico02.png" width="42" height="42" alt="在线咨询" /></a>
  <a href="#" title="新浪微博"><img src="/client/images/float_ico03.png" width="42" height="42" alt="新浪微博" /></a>
  <a href="#" title="服务热线"><img src="/client/images/float_ico04.png" width="42" height="42" alt="服务热线" /><span><img src="/client/images/hzd_55.png" /></span></a>
  <a href="#" title="到顶部"><img src="/client/images/float_ico05.png" width="42" height="42" alt="到顶部" /></a>
</aside>

	<!--导航-->
	<div class="daohang">
    <nav class="navbox">
       <section class="navlist" id="mainnavdown">
            <a href="javascript:;" class="a2">全部商品分类</a>
            <ul class="navlistout" id="navdown">
                <#if top_cat_list??>
                    <#list top_cat_list as item>
                       <#if item_index < 9>
                        <li>
                            <h3 class="${item.callIndex}"><img src="${item.imgUrl}" /><a href="/list/${item.id?c}">${item.title!''}</a></h3>
                
                            <div class="nav_showbox">
                                <i class="bg"></i>
                                <div class="clear"></div>
                                  <#if ("nav_"+item_index+"_ad_list")?eval??> 
                                     <table class="nav_right"> 
                                          <#list ("nav_"+item_index+"_ad_list")?eval as aditem> 
                                                <#if aditem_index < 4 >                                                           
                                                      <tr>
                                                           <td colspan="2" class="pt10"><a href="${aditem.linkUri!''}"><img src="${aditem.fileUri!''}" width="166" height="129"/></a></td>
                                                      </tr>
                                                </#if>
                                          </#list>                                                    
                                     </table>
                                   </#if>
                                <#if ("second_level_"+item_index+"_cat_list")?eval?? >
                                    <table class="nav_more">
                                        <#list ("second_level_"+item_index+"_cat_list")?eval as secondLevelItem>
                                            <tr>
                                                <th width="90"><span><a href="/list/${secondLevelItem.id?c}">${secondLevelItem.title!''}</a></span></th>
                                                <td>
                                                    <#if ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval?? >
                                                        <#list ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval as thirdLevelItem>
                                                            <a href="/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a>
                                                        </#list>
                                                    </#if>
                                                </td>
                                            </tr>
                                        </#list>
                                    </table>
                                </#if>
                                
                                <div class="clear"></div>
                            </div>
                        </li>
                        </#if>
                    </#list>
                </#if>
            </ul><!--navlistout END-->
        </section>
        <#if navi_item_list??>
            <#list navi_item_list as item>
                <a class="a1" href="${item.linkUri!''}">${item.title!''}</a>
            </#list>
        </#if>  
   </nav>
</div>
<div class="clear"></div>
	<!--banner-->
	<div class="banner">
		<#if banner_ad_list??>
               <#list banner_ad_list as item>
                    <a href="${item.linkUri!''}" style="display:block;background:url(${item.fileUri!''}) no-repeat center;width:1920px;height:450px;"></a>
               </#list>
        </#if>
</div>
    

	<div class="main">
		<menu class="index_zx">
			<h3>惠资讯<a href="/info/list/10">更多</a></h3>
			<ul>
			   <#if latest_news_page??>
                 <#list latest_news_page.content as item>
                    <#if item_index < 7>
                      <li>
                <!--         <a href="#">${item.title!''}</a>  -->
                         <#if item.title?length lt 21>
                            <a href="/info/content/${item.id?c}?mid=${item.menuId?c}">${item.title?default("")}</a>
                             <#else>
                            <a href="/info/content/${item.id?c}?mid=${item.menuId?c}" title="${item.title}">${item.title[0..17]?default("")}...</a>
                         </#if>
                      </li>
                    </#if>
                 </#list>
               </#if>
			</ul>
			<h3>惠生活</h3>
			<table>
				<tbody>
					<tr>
						<td>
							<a href="#"><img src="client/images/hzd_66.png"><p>话费充值</p></a>
						</td>
						<td>
							<a href="#"><img src="client/images/hzd_67.png"><p>电影票</p></a>
						</td>
						<td>
							<a href="#"><img src="client/images/hzd_68.png"><p>彩票</p></a>
						</td>
					</tr>
					<tr>
						<td>
							<a href="#"><img src="client/images/hzd_69.png"><p>水电缴费</p></a>
						</td>
						<td>
							<a href="#"><img src="client/images/hzd_70.png"><p>宽带</p></a>
						</td>
						<td>
							<a href="#"><img src="client/images/hzd_71.png"><p>门票</p></a>
						</td>
					</tr>
				</tbody>
			</table>
		</menu>
		<div class="clear"></div>
	</div>
	
	<!--楼层浮动-->



	<!--楼层主要内容-->
	<section class="main">
		<table class="index_tj">
			<tbody>
			<#if top_ad_list??>	
	     	    <tr>	    
                <#list top_ad_list as item>      
			     <#if item_index < 3> 
			       
			        <td class="td${item_index+1}"><a href="${item.linkUri!''}">
                         <img src="${item.fileUri!''}" width="210" height="150" style="position:absolute;right:10px; top:45px;">
                         <p class="p1">${item.title!''}</p>
                         <p class="p2">${item.subtitle!''}</p> 
                         <p class="p3">${item.mark!''}</p>
                         </a>
                     </td>                          
                 </#if>                
				</#list>
				</tr>
				  <tr>      
                <#list top_ad_list as item>            
                 <#if item_index gt 2 && item_index<6> 
                   
                    <td class="td${item_index+1}"><a href="${item.linkUri!''}">
                         <img src="${item.fileUri!''}" width="210" height="150" style="position:absolute;right:10px; top:45px;">
                         <p class="p1">${item.title!''}</p>
                         <p class="p2">${item.subtitle!''}</p> 
                         <p class="p3">${item.mark!''}</p>
                         </a>
                     </td>                          
                 </#if>                
                </#list>
                </tr>
            </#if>
			</tbody>
		</table>
		<div class="clear"></div>
		<!--1楼-->
		<div class="index_onetit">1F&nbsp;&nbsp;&nbsp;&nbsp;家用电器</div>
		<div class="index_one">
			<menu class="index_one_list">
			    <#if domesticAppliance_cat_list??>
			         <#assign total_index =0>
			         <#list domesticAppliance_cat_list as item>
			             <#if total_index < 16>
    			             <a href="/list/${item.id?c}">${item.title!''}</a>
    			             <#assign total_index = total_index+1>
    			             <#if ("second_level_" + item_index + "domesticAppliance_cat_list")?eval??>
    			                 <#list ("second_level_" + item_index + "domesticAppliance_cat_list")?eval as seconditem>
    			                     <#if total_index < 16>
        			                     <a href="/list/${item.id?c}">${seconditem.title!''}</a>
        			                     <#assign total_index = total_index+1>
    			                     </#if>
    			                 </#list>			                 
    			             </#if>
    			         </#if>
			         </#list>
			    </#if>				
			</menu>
			<div class="index_litbanner">
			    <#if OneFlittle_ad_list??>
			        <#list OneFlittle_ad_list as item>
			            <#if item_index < 1>
			                <a href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="210" height="218"></a>
			            </#if>
			        </#list>
			    </#if>
			</div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
					    <#if OneFtransverse_ad_list??>
					       <#list OneFtransverse_ad_list as item>
					           <#if item_index < 2>
					               <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
					           </#if>
					       </#list>
					    </#if>
					    <#if OneFvertical_ad_list??>
					       <#list OneFvertical_ad_list as item>		
					           <#if item_index < 1>				
						          <td rowspan="2"><a href="${item.linkUri!'#'}" class="a2"><img src="${item.fileUri!''}" width="330" height="442"></a></td>
						       </#if>
						   </#list>
						</#if>
					</tr>
					<tr>
						<#if OneFtransverse_ad_list??>
                           <#list OneFtransverse_ad_list as item>
                               <#if item_index gt 1 && item_index <4>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<#if OneFbottom_ad_list??>
		   <#list OneFbottom_ad_list as item>
		      <#if item_index < 1>
		          <a class="index_ad" href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="1200" height="100"></a>
		      </#if>
		   </#list>
		</#if>
		<!--2楼-->
		<div class="index_twotit">2F&nbsp;&nbsp;&nbsp;&nbsp;电脑</div>
		<div class="index_two">
			<menu class="index_two_list">
				 <#if computer_cat_list??>
                     <#assign total_index =0>
                     <#list computer_cat_list as item>
                         <#if total_index < 16>
                             <a href="/list/${item.id?c}">${item.title!''}</a>
                             <#assign total_index = total_index+1>
                             <#if ("second_level_" + item_index + "computer_cat_list")?eval??>
                                 <#list ("second_level_" + item_index + "computer_cat_list")?eval as seconditem>
                                     <#if total_index < 16>
                                         <a href="/list/${item.id?c}">${seconditem.title!''}</a>
                                         <#assign total_index = total_index+1>
                                     </#if>
                                 </#list>                            
                             </#if>
                         </#if>
                     </#list>
                </#if>  
			</menu>
			<div class="index_litbanner">
                <#if twoFlittle_ad_list??>
                    <#list twoFlittle_ad_list as item>
                        <#if item_index < 1>
                            <a href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="210" height="218"></a>
                        </#if>
                    </#list>
                </#if>
            </div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<#if twoFvertical_ad_list??>
                           <#list twoFvertical_ad_list as item>     
                               <#if item_index < 1>             
                                  <td rowspan="2"><a href="${item.linkUri!'#'}" class="a2"><img src="${item.fileUri!''}" width="330" height="442"></a></td>
                               </#if>
                           </#list>
                        </#if>
						<#if twoFtransverse_ad_list??>
                           <#list twoFtransverse_ad_list as item>
                               <#if item_index < 2>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
					<tr>
						<#if twoFtransverse_ad_list??>
                           <#list twoFtransverse_ad_list as item>
                               <#if item_index gt 1 && item_index <4>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<!--3楼-->
		<div class="index_threetit">3F&nbsp;&nbsp;&nbsp;&nbsp;摄影</div>
		<div class="index_three">
			<menu class="index_three_list">
				<#if shoot_cat_list??>
                     <#assign total_index =0>
                     <#list shoot_cat_list as item>
                         <#if total_index < 16>
                             <a href="/list/${item.id?c}">${item.title!''}</a>
                             <#assign total_index = total_index+1>
                             <#if ("second_level_" + item_index + "shoot_cat_list")?eval??>
                                 <#list ("second_level_" + item_index + "shoot_cat_list")?eval as seconditem>
                                     <#if total_index < 16>
                                         <a href="/list/${item.id?c}">${seconditem.title!''}</a>
                                         <#assign total_index = total_index+1>
                                     </#if>
                                 </#list>                            
                             </#if>
                         </#if>
                     </#list>
                </#if>  
			</menu>
			<div class="index_litbanner">
                <#if threeFlittle_ad_list??>
                    <#list threeFlittle_ad_list as item>
                        <#if item_index < 1>
                            <a href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="210" height="218"></a>
                        </#if>
                    </#list>
                </#if>
            </div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<#if threeFtransverse_ad_list??>
                           <#list threeFtransverse_ad_list as item>
                               <#if item_index < 1>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
						<#if threeFvertical_ad_list??>
                           <#list threeFvertical_ad_list as item>     
                               <#if item_index < 1>             
                                  <td rowspan="2"><a href="${item.linkUri!'#'}" class="a2"><img src="${item.fileUri!''}" width="330" height="442"></a></td>
                               </#if>
                           </#list>
                        </#if>
						<#if threeFtransverse_ad_list??>
                           <#list threeFtransverse_ad_list as item>
                               <#if item_index gt 0 && item_index < 2>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
					<tr>
						<#if threeFtransverse_ad_list??>
                           <#list threeFtransverse_ad_list as item>
                               <#if item_index gt 1 && item_index < 4>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<#if threeFbottom_ad_list??>
           <#list threeFbottom_ad_list as item>
              <#if item_index < 1>
                  <a class="index_ad" href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="1200" height="100"></a>
              </#if>
           </#list>
        </#if>
		<!--4楼-->
		<div class="index_fourtit">4F&nbsp;&nbsp;&nbsp;&nbsp;食品酒水</div>
		<div class="index_four">
			<menu class="index_four_list">
				<#if FoodDrinks_cat_list??>
                     <#assign total_index =0>
                     <#list FoodDrinks_cat_list as item>
                         <#if total_index < 16>
                             <a href="/list/${item.id?c}">${item.title!''}</a>
                             <#assign total_index = total_index+1>
                             <#if ("second_level_" + item_index + "FoodDrinks_cat_list")?eval??>
                                 <#list ("second_level_" + item_index + "FoodDrinks_cat_list")?eval as seconditem>
                                     <#if total_index < 16>
                                         <a href="/list/${item.id?c}">${seconditem.title!''}</a>
                                         <#assign total_index = total_index+1>
                                     </#if>
                                 </#list>                            
                             </#if>
                         </#if>
                     </#list>
                </#if>  
			</menu>
			<div class="index_litbanner">
                <#if fourFlittle_ad_list??>
                    <#list fourFlittle_ad_list as item>
                        <#if item_index < 1>
                            <a href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="210" height="218"></a>
                        </#if>
                    </#list>
                </#if>
            </div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<#if fourFvertical_ad_list??>
                           <#list fourFvertical_ad_list as item>     
                               <#if item_index < 1>             
                                  <td rowspan="2"><a href="${item.linkUri!'#'}" class="a2"><img src="${item.fileUri!''}" width="330" height="442"></a></td>
                               </#if>
                           </#list>
                        </#if>
                        <#if fourFtransverse_ad_list??>
                           <#list fourFtransverse_ad_list as item>
                               <#if item_index < 2>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
					<tr>
						<#if fourFtransverse_ad_list??>
                           <#list fourFtransverse_ad_list as item>
                               <#if item_index gt 1 && item_index <4>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear"></div>
		<!--5楼-->
		<div class="index_fivetit">5F&nbsp;&nbsp;&nbsp;&nbsp;手机</div>
		<div class="index_five">
			<menu class="index_five_list">
				<#if phone_cat_list??>
                     <#assign total_index =0>
                     <#list phone_cat_list as item>
                         <#if total_index < 16>
                             <a href="/list/${item.id?c}">${item.title!''}</a>
                             <#assign total_index = total_index+1>
                             <#if ("second_level_" + item_index + "phone_cat_list")?eval??>
                                 <#list ("second_level_" + item_index + "phone_cat_list")?eval as seconditem>
                                     <#if total_index < 16>
                                         <a href="/list/${item.id?c}">${seconditem.title!''}</a>
                                         <#assign total_index = total_index+1>
                                     </#if>
                                 </#list>                            
                             </#if>
                         </#if>
                     </#list>
                </#if>  
			</menu>
			<div class="index_litbanner">
                <#if fiveFlittle_ad_list??>
                    <#list fiveFlittle_ad_list as item>
                        <#if item_index < 1>
                            <a href="${item.linkUri!'#'}"><img src="${item.fileUri!''}" width="210" height="218"></a>
                        </#if>
                    </#list>
                </#if>
            </div>
		</div>
		<div class="index_tab">
			<table>
				<tbody>
					<tr>
						<#if fiveFtransverse_ad_list??>
                           <#list fiveFtransverse_ad_list as item>
                               <#if item_index < 2>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
						<#if fiveFvertical_ad_list??>
                           <#list fiveFvertical_ad_list as item>     
                               <#if item_index < 1>             
                                  <td rowspan="2"><a href="${item.linkUri!'#'}" class="a2"><img src="${item.fileUri!''}" width="330" height="442"></a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
					<tr>
						<#if fiveFtransverse_ad_list??>
                           <#list fiveFtransverse_ad_list as item>
                               <#if item_index gt 1 && item_index <4>
                                   <td><a href="${item.linkUri!'#'}" class="a1">
                                        <p class="p1"><b>${item.title!''}</b></p>
                                        <p class="p2">${item.subtitle!''}</p>
                                        <img src="${item.fileUri!''}" width="170" height="153">
                                    </a></td>
                               </#if>
                           </#list>
                        </#if>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear h60"></div>
	</section>

	<!--页脚-->
	<#include "/client/common_footer.ftl" />
</body>
</html>