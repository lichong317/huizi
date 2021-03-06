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

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
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
    menuDownList("mainnavdown","#navdown",".a2","sel");
    
    chooseMoreShow();
        
});
</script>

</head>

<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="clear h20"></div>

    <!--liebiaoye-->
    <div class="main">
        <div class="weizhi">
            <span><a href="/">首页</a></span>><span><a href="/info/list/${mid!''}" >${menu_name!''}</a> > <a href="javascrip:;" class="hover_zy">内容</a></span>
        </div>
        <#if info??>
            <div class="clear h15"></div>
            <div class="wenzhangxiangxi">            
                <h3>${info.title!''}</h3>
                <p style="text-align:center">作者：${info.author!''}&nbsp;&nbsp;&nbsp;来源：${info.source!''}</p>
                <p style="text-align:center">${info.createTime!''}　</p>
                <p>${info.content!''}</p>   
            </div>
        </#if>
        <div class="clear h30"></div>
        <div class="next">
            <div class="shang"><#if prev_info??><a href="/info/content/${prev_info.id?c}?mid=${prev_info.menuId?c}">上一篇:${prev_info.title!''}</a></#if></div>
            <div class="xia"><#if next_info??><a href="/info/content/${next_info.id?c}?mid=${next_info.menuId?c}">下一篇:${next_info.title!''}</a></#if></div>
        </div>
        <!--分页-->
    
    </div>
  <div class="clear h40"></div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
