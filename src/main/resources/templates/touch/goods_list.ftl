<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if productCategory??>${productCategory.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="<#if productCategory??>${productCategory.seoKeywords!''}</#if>">
<meta name="description" content="<#if productCategory??>${productCategory.seoDescription!''}</#if>">
<meta name="copyright" content="<#if site??>${site.copyright!''}</#if>" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
  
});

var pageIdx = 1;
function loadMore()
{
    $.ajax({
        type:"post",
        url:"/touch/list/more/${categoryId!'1'}-${orderId?c!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-" + pageIdx,
        success:function(data){
            if ("" == data)
            {
                $("#a-more").css("display", "none");
            }
            else
            {
                $("#goods-menu").append(data);
                pageIdx++;
            }
        }
    });
}
</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p><#if productCategory??>${productCategory.title!''}</#if></p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="#" onclick="$('#classwin').fadeToggle(200);"><img src="/touch/images/menu.png" height="22" /></a>
  </div>
</header>

<style type="text/css">
  
  
.classwin {display: none;position:fixed; right:0; top:0;margin-top: 50px; z-index:50; background:rgba(0,0,0,0.8); width:100%; height:100%;}
.classwin .bg {position:absolute; width:39px; height:30px; right:0; top:8px;color:#fff;z-index: 1;cursor: pointer;}
.classbox {width:26%; height:100%; background:#1c2b38;float: left;text-align: left;overflow: auto;}
.classbox menu{}
.classbox menu a { display:block;line-height:40px; text-align:right; font-size:0.9em; color:#FFF;padding-right:14%;}
.classbox menu .active{color:#fff;background:#1f1f1f;border-left: solid 4px #C20120;}

.ftenlst{height: 100%;margin-left: 26%;overflow: auto;}
.ftenlst .term{height: auto;padding-left: 20px;margin-bottom: 26px;}
.ftenlst .term a{height: 40px;line-height: 40px;color:#fff;font-size:0.8em;}
.ftenlst .term .sel{margin: 3px;height: 34px;line-height: 34px;background-color: rgba(234, 202, 52, 0.35);border-radius: 3px;border: 1px solid rgba(255,255,255,0.2);margin-right: 10px;}
.ftenlst .termover{width: 80%;margin-top:35px;margin: 0 auto;}
.ftenlst .termover span{display: block;color:#fff;font-size:0.8em;height: 30px;line-height: 30px;}
.ftenlst .termover p{display: block;width:45%;height: 30px;line-height: 30px;color:#1f1f1f;font-size:0.9em;background:#f7ecc0;text-align:center;border-radius: 5px;}
.ftenlst .termover .select_submit{ border:none; display: block;width: 45%;height: 30px;line-height: 30px;color: #1f1f1f;font-size: 0.9em;background: #f7ecc0;text-align: center;border-radius: 5px;-webkit-appearance: none;}
.ftenlst .termover .qcqb{width:45%;height: 30px;line-height: 30px;color:#1f1f1f;font-size:0.9em;background:#f7ecc0;text-align:center;border-radius: 5px;display:none;}
.ftenlst .termover a{display: inline-block;margin:0 10px;color:#fff;font-size:0.8em;height: 30px;line-height: 30px;border:1px solid #bfbfbf;border-radius: 5px;text-align:center;padding: 0 10px;float: left;margin-bottom: 10px;}
.ftenlst .optinfo {padding: 5px;}
.ftenlst .optinfo span {margin: 2px;}
.ftenlst .optinfo a {margin: 4px;white-space: nowrap;border: 1px solid #ccc;border-radius: 3px;display: inline-block; padding: 2px 4px;color:#fff;}
.ftenlst ol.active {display: block;}
.ftenlst ol {display: none;width:80%;}
.iocerse{z-index:99; position:fixed; left:0; bottom:0; width:74%;padding:10px 0; height:auto;background:#383737;margin-left: 26%;overflow: auto; max-height: 158px;}
.ftenlst .term .sel{margin: 3px;height: 34px;line-height: 34px;background-color: rgb(97, 97, 94);border-radius: 3px;border: 1px solid rgba(255,255,255,0.2);margin-right: 10px;}

.termover{width: 80%;margin-top:35px;margin: 0 auto;}
.termover span{display: block;color:#fff;font-size:0.8em;height: 30px;line-height: 30px;}
.termover p{display: block;width:45%;height: 30px;line-height: 30px;color:#fff;font-size:0.9em;background:#FF4454;text-align:center;border-radius: 5px;}
.termover .select_submit{ border:none; display: block;width: 45%;height: 30px;line-height: 30px;color: #1f1f1f;font-size: 0.9em;background: #f7ecc0;text-align: center;border-radius: 5px;-webkit-appearance: none;}
.termover .qcqb{width:45%;height: 30px;line-height: 30px;color:#1f1f1f;font-size:0.9em;background:#f7ecc0;text-align:center;border-radius: 5px;display:none;}
.termover a{display: inline-block;margin:0 10px;color:#fff;font-size:0.8em;height: 30px;line-height: 30px;border:1px solid #bfbfbf;border-radius: 5px;text-align:center;padding: 0 10px;float: left;margin-bottom: 10px;}
.optinfo {padding: 5px;}
.optinfo span {margin: 2px;color:#fff;}
.optinfo a {margin: 4px;white-space: nowrap;border: 1px solid #ccc;border-radius: 3px;display: inline-block; padding: 2px 4px;color:#fff;font-size: 0.8em;border-radius: 3px;}
.ftenlst ol {width: 100%;padding-top: 35px;}
.classbox menu {padding-top: 35px;}
.ftenlst .term{padding-left: 0px;}
.ftenlst .term a {padding-left: 26px;}
.ftenlst .term .sel {background: #fff;border:0;color:#000;}
.iocerse{background: none;}
.ftenlst .term a{
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
color: rgb(255, 255, 255);
cursor: pointer;
display: block;
font-family: 微软雅黑, Arial, Helvetica, sans-serif;
font-size: 12.8000001907349px;
height: 40px;
line-height: 40px;
padding-left: 26px;
position: relative;
text-align: left
}

</style>

<!-- 筛选 -->
<aside class="classwin" id="classwin">
  <p class="bg" onclick="$('#classwin').fadeOut(200);"><img src="/touch/images/close_03.png" height="30" border="0" alt=""></p> 
  <div class="classbox">
    <menu>
    <a class="active" href="javascript:void(0);" onclick="tab(1)" id="tb_1">品牌</a>
    <#if param_list??>
        <#list param_list as param>
            <#if param_index < 7>
                <a href="javascript:void(0);" onclick="tab(${param_index + 2})" id="tb_${param_index + 2}" class="">${param.title!""}</a>
            </#if>
        </#list>
    </#if>
    </menu>
  </div>
  <script type="text/javascript"> 
    function tab(id){
      for(i=1;i<=10;i++){
        if(id == i){
        document.getElementById("co_"+i).className="active";
        document.getElementById("tb_"+i).className="active";
        }else{

        document.getElementById("co_"+i).className="";
        document.getElementById("tb_"+i).className="";

        }

      }

    }
  </script> 

  <div class="ftenlst" id="listright" style="height: 459px;">
   <ol id="co_1" class="active">
    <nav class="term">     
      <#if brand_list??>
          <a href="${categoryId!'0'}-0<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if brandIndex==0>class="sel"</#if>>全部</a>
          <#list brand_list as brand>
               <#if brand_index < 6>
                    <a href="${categoryId!'0'}-${brand_index+1}<#list param_index_list as pindex>-${pindex!'0'}</#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if brandIndex==brand_index+1>class="sel"</#if>>${brand.title?trim!''}</a>
               </#if>              
          </#list>
      </#if>

    </nav>
   </ol>
   <#if param_list??>
       <#list param_list as param>
            <ol id="co_${param_index + 2}" class="">
                <nav class="term">
                  <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex><#if param_index==pindex_index>-0<#else>-${pindex!'0'}</#if></#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if param_index_list[param_index]==0>class="sel"</#if>>全部</a>
                  <#if param.valueList??>
                        <#list param.valueList?split(",") as value>
                            <#if value!="" && value_index < 6>
                                <a href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex><#if param_index==pindex_index>-${value_index+1}<#else>-${pindex!'0'}</#if></#list>-${orderId!'0'}<#if sort_id_list??><#list sort_id_list as sortId>-${sortId!'0'}</#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>" <#if param_index_list[param_index]==value_index+1>class="sel"</#if>>${value?trim!""}</a>
                            </#if>
                        </#list>
                  </#if>
                </nav>
           </ol>
       </#list>
   </#if>
  </div>
     <div id="" class="iocerse">
      <div class="termover">
      <div>
        <p class="fr" onclick="window.location.href='/touch/list/${categoryId!'0'}'">清空条件</p>
      <#--  <p class="fr">确定筛选</p> -->
        <div class="clear"></div>
      </div>
     </div>
     <div class="optinfo">
       <span>已筛选条件：</span><!-- <span class="optempty">暂无筛选条件</span> -->
       <#if brand_list??>
                <#list brand_list as brand>
                    <#if brandIndex==brand_index+1>
                        <a href="#">
                            ${brand.title?trim!''}
                        </a>
                    </#if>
                </#list>
       </#if>
       <#if param_list??>
                <#list param_list as param>
                    <#if param.valueList??>
                        <#list param.valueList?split(",") as value>
                            <#if value!="">
                                <#if param_index_list[param_index]==value_index+1>
                                    <a href="#">
                                        ${param.title!""}：
                                        ${value?trim!""}
                                    </a>
                                </#if>
                            </#if>
                        </#list>
                    </#if>
               </#list>
        </#if>   

     </div>

   </div>
  <div class="clear"></div>
</aside>
<!-- 筛选结束 -->

<div class="list_top">
<table class="main">
  <tr>    
    <td <#if orderId==0><#if sort_id_list[0]==0>class="sel"<#else>class="sel"</#if></#if>><a  href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-0<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==0><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>综合</span></a></td>
    <td <#if orderId==1><#if sort_id_list[1]==0>class="sel"<#else>class="sel"</#if></#if>><a  href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-1<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==1><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>价格</span></a></td>
    <td <#if orderId==2><#if sort_id_list[2]==0>class="sel"<#else>class="sel"</#if></#if>><a  href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-2<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==2><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>销量</span></a></td>
    <td <#if orderId==3><#if sort_id_list[3]==0>class="sel"<#else>class="sel"</#if></#if>><a  href="${categoryId!'0'}-${brandIndex!'0'}<#list param_index_list as pindex>-${pindex!'0'}</#list>-3<#if sort_id_list??><#list sort_id_list as sortId><#if sortId_index==3><#if sortId==0>-1<#else>-0</#if><#else>-${sortId!'0'}</#if></#list></#if>-${pageId!'0'}-${leftId!'0'}<#if priceLow?? && priceHigh??>_${priceLow?string("#.##")}-${priceHigh?string("#.##")}</#if>"><span>评价</span></a></td>
  </tr>
</table>
</div>
<div class="clear35"></div>
<div class="main"  >
    <menu id="goods-menu">
        <#if goods_page??>
            <#list goods_page.content as item>
                <a class="phone_list" href="/touch/goods/${item.id?c!''}">
                    <b><img src="${item.coverImageUri!''}" width="91" height="91"/></b>
                    <p class="p1">${item.title!''}</p>
                    <p>${item.subTitle!''}</p>
                    <p class="fl">累计评价：<span class="red">${item.totalComments!'0'}条</span></p>
                    <p class="p2 ta-r mt20">￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></p>
                    <div class="clear"></div>
                </a>
            </#list>
        </#if>  
    </menu>
  <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>
  <div class="clear20"></div>
</div><!--main END-->

<#if !app??>
<section class="botmain">
  <div class="main">
  <div class="center">
    <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout" onclick="logout()">退出</a>
    <#else>
        <a href="/touch/login">登录</a>
        <span>|</span>
        <a href="/touch/reg">注册</a>
    </#if> 
    <a class="absolute-r" href="javascript:$('html,body').animate({scrollTop:0},500);">返回顶部</a>     
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="/touch">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
