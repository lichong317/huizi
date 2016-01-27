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
</head>
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

function btnPageSubmit() 
{
    window.location.href = "/info/list/${mid!'10'}?catId=${catId!'0'}&page="+(parseInt($('#iPageNum').val()) - 1);
}
</script>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="clear h20"></div>

    <!--liebiaoye-->
    <div class="main">
        <div class="weizhi">
            <span><a href="#">首页</a></span>><span>文章列表</span>
        </div>
        <div class="clear h15"></div>
        <menu class="help_menu">
            <h3>资讯</h3>
                <#if informationcatList??>
                    <#list informationcatList as item>
                        <#if item.id == catId>
                            <a class="sel" href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        <#else>
                            <a href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        </#if>
                    </#list>
                </#if>           
            <h3>帮助中心</h3>
                <#if helpcatList??>
                    <#list helpcatList as item>
                        <#if item.id == catId>
                            <a class="sel" href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        <#else>
                            <a href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        </#if>
                    </#list>
                </#if>
            <h3>关于我们</h3>
                <#if aboutuscatList??>
                    <#list aboutuscatList as item>
                        <#if item.id == catId>
                            <a class="sel" href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        <#else>
                            <a href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        </#if>
                    </#list>
                </#if>
            <h3>联系我们</h3>
                <#if contactuscatList??>
                    <#list contactuscatList as item>
                        <#if item.id == catId>
                            <a class="sel" href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        <#else>
                            <a href="/info/list/${item.menuId?c}?catId=${item.id?c}">${item.title!''}</a>
                        </#if>
                    </#list>
                </#if>
        </menu>

        <div class="wenzhangliebiao">
    <style>
    .wenzhangliebiao{width: 948px;}
    .wenzhangliebiao img{width: 150px; height: 150px; float: left;}
    .wenzhangliebiao a{width:446px !important; float: left;}
    .wenzhangliebiao li{background: #f9f9f9; border-bottom: none !important; width: 446px; height: 150px; float: left; margin:10px 10px; line-height: 30px;}
    .wenzhangliebiao li:hover{background: #FF4454; color: #fff;}
    .wenzhangliebiao a:hover{color: #FFF;}
    .wenzhangliebiao p{width: 285px; float:right;}
    </style>
            <ul>
                <#if info_page??>
                    <#list info_page.content as item>
                        <li>
                            <a href="/info/content/${item.id?c}?mid=${item.menuId?c}">
                                <img src="${item.imgUrl!''}">
                                <p style="height: 60px; overflow: hidden; font-weight: bold;"> ${item.title!''}</p>
                                <p style="height: 60px; overflow: hidden;">${item.brief!''}</p>
                                <p style="text-align: right; padding-right: 10px;">${item.createTime!''}</p>
                                <#--&nbsp;&nbsp;&nbsp;<span>浏览次数：${item.viewCount!'0'}</span> -->
                            </a>
                        </li>
                    </#list>
                </#if>           
            </ul>
        </div>
    <!--分页-->
    <div class="clear"></div>
    <div class="pagebox">
       <div class="num">
          <#if info_page??>
                <#assign continueEnter=false>
                <#if info_page.number+1 == 1>
                    <a href="javascript:;">上一页</a>
                <#else>
                    <a href="/info/list/${mid}?catId=${catId}&page=${info_page.number-1}">上一页</a>
                </#if>
                
                <#if info_page.totalPages gt 0>
                    <#list 1..info_page.totalPages as page>
                        <#if page <= 3 || (info_page.totalPages-page) < 3 || (info_page.number+1-page)?abs<3 >
                            <#if page == info_page.number+1>
                                <a href="javascript:;" class="sel">${page}</a>
                            <#else>
                                <a href="/info/list/${mid}?catId=${catId}&page=${page-1}">${page}</a>
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
                
                <#if info_page.number+1 == info_page.totalPages || info_page.totalPages==0>
                    <a href="javascript:;">下一页</a>
                <#else>
                    <a href="/info/list/${mid}?catId=${info_page.number+1}">下一页</a>
                </#if>
                <span class="sp1">共${info_page.totalPages!'0'}页</span>
            </#if>
        </div>
        <div class="page">
        <input class="sub" type="submit" onclick="javascript:btnPageSubmit();" value="确定" />
        <span>页</span>
        <input class="text" type="text" value="${pageId + 1}" id="iPageNum"/>
        <span>到第</span>
      </div>
    </div>
  </div>
  <div class="clear h40"></div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
