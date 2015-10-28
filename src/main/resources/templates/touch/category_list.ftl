<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script>
    function showCategory(index){
        var id = index;
        
        if ($("#table"+id).css("display")=="none"){
            $("#table"+id).css("display", "");
        }else{
            $("#table"+id).css("display", "none");
        }
        
    }
</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>商品类别</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="main">
  <#if top_cat_list??>
       <#list top_cat_list as item>
            <a class="menu_tit menu_tit_sel" href="javascript:showCategory(${item_index});"><span>${item.title!''}</span></a>
            <#if ("second_level_"+item_index+"_cat_list")?eval??>
                <table id="table${item_index}" class="comtab menu_tab" style="display:none">
                    <tr>
                        <td><a href="/touch/list/${item.id?c}">全部</a></td>
                    <#list ("second_level_"+item_index+"_cat_list")?eval as secondLevelItem>
                        <#if secondLevelItem_index ==0>
                             <td><a href="/touch/list/${secondLevelItem.id?c}">${secondLevelItem.title!''}</a></td>
                        <#else>
                             <tr>
                                <td><a href="/touch/list/${secondLevelItem.id?c}">${secondLevelItem.title!''}</a></td>                       
                        </#if>
                        <#if ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval?? >
                               <#list ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval as thirdLevelItem>
                                     <#if thirdLevelItem_index%3 ==0>
                                         <tr>
                                            <td><a href="/touch/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a></td>
                                    <#elseif thirdLevelItem_index%3 ==1>
                                         <td><a href="/touch/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a></td>
                                    <#elseif thirdLevelItem_index%3 ==2>
                                            <td><a href="/touch/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a></td>
                                         </tr>
                                    </#if>
                               </#list>
                        </#if>
                    </#list>
                </table>
            </#if>
       </#list>  
  </#if>
  
  <div class="clear20"></div>
</div>
<!--main END-->

<section class="botmain">
  <div class="main">
  <div class="center">
   <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout">退出</a>
    <#else>
        <a href="/touch/login">登录</a>
        <span>|</span>
        <a href="/touch/reg">注册</a>
    </#if> 
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
