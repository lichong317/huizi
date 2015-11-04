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

<style type="text/css">
   html,#allmap {width: 100%; height:100%; margin:0;font-family:"微软雅黑";}     <#-- 去掉了body @by zhangji-->
   .dituliebiao_rt{width:743px; margin-top:20px; height:673px;float:right;}
   .dituliebiao_lt{ margin-top:20px;}
   .dituliebiao_lt{width:457px; height:673px; overflow:hidden; float:left;}
   .fr{float:right;}                <#--  @by zhangji-->
</style>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=lwRXRetipHPGz8y6lzUlUZfc"></script>

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
    
    productImgShow("proshowimg","li","proshowmenu","sel",396,396);
    checkBoxShow("assort_menu","a","assort_sum","li","sel");
    topTitFloat("detail_tit",1250,"detail_tit_sel");
    
     <#if shop_list?? && shop_list?size gt 0>
        loadMap(${shop_list.content[0].longitude!'102.718072'}, ${shop_list.content[0].latitude!'25.048034'},<#if shop_list.content[0].isFlagShip?? && shop_list.content[0].isFlagShip>1<#else>0</#if>);
     </#if>
});

function loadMap(x, y, z)
{
    // 百度地图API功能
    /*
    var map = new BMap.Map("allmap");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(x, y), 16);  // 初始化地图,设置中心点坐标和地图级别
    
    map.setCurrentCity("昆明");          // 设置地图显示的城市 此项是必须设置的
    
    map.addOverlay(new BMap.Marker(new BMap.Point(x, y)); // 创建点
    */
    
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(x, y);
    map.centerAndZoom(point, 16);
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    var marker = new BMap.Marker(new BMap.Point(x, y)); // 创建点
    map.addOverlay(marker);
    if(z == 1){
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    }
}
</script>
</head>

<body>
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<div class="clear h20"></div>
<div class="main">
<div class="weizhi">
<span><a href="/">首页</a></span>><span><a href="/shop/list">门店列表</a>
</div>
<div class="dituliebiao">
   <div class="clear"></div>
   <div class="dituliebiao_lt">
     
   <ul style="overflow-y: auto; height: 607px; width: 459px; overflow-x: hidden;">
   <#if shop_list??>
       <#list shop_list.content as item>
            <li>
               <div class="mendiantupian"><a href="/shop/${item.id?c}"><img src="${item.imageUri!''}" width="137" height="104" /></a></div>
               <div class="mendianditu_rt">
                   <h4><a href="/shop/${item.id?c}">${item.title!''}<#if item.isFlagShip?? && item.isFlagShip><span class="red">(旗舰店)</span></#if></a></h4>
                   <p>${item.address!''}</p>
                   <p>服务电话：<span>${item.serviceTele!''}</span><p>
                   <p class="dianouweizhi"><a href="javascript:;" onclick="loadMap(<#if item.longitude??>${item.longitude?string("0.000000")}<#else>110</#if>, <#if item.latitude??>${item.latitude?string("0.000000")}<#else>39</#if>,<#if item.isFlagShip?? && item.isFlagShip>1<#else>0</#if>);">店铺位置</a></p>
               </div>
           </li>
       </#list>
   </#if>   
   </ul>
   </div>
    <div class="dituliebiao_rt fr">
        <div id="allmap" width="743" height="650";>      
        </div>
    </div>  
  </div>
</div>
<div class="clear h40"></div>

<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
