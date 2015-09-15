<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link href="/client/style/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/style/master.css" rel="stylesheet" type="text/css" />
<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />

<#--><script type="text/javascript" src="/client/js/html5.js"></script>
<script src="/client/js/header.js"></script> -->
<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/list.js"></script>
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
    //menuDownList("mainnavdown","#navdown",".a2","sel");
    
    chooseMoreShow();
        
});
</script>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<article id="main">
   <div class="ipp1 top">
        <dd>您当前位置：<a href="/">首页</a> > <a href="/info/list/10" class="hover_zy">${menu_name!''}</a></dd>
    </div> 
    
    <div class="clear"></div>
    <!--面包屑结束-->
    
    <div id="Content" class="mt20 fl">
        <div class="newlistL">
        <div class="newlistnav">
            <h1>${menu_name!''}</h1>
            <ul class="newlistnavS">
                <#if info_category_list??>
                    <#list info_category_list as item>
                        <li><a href="/info/list/${mid}?catId=${item.id?c}"><#list 1..item.layerCount as x>&nbsp;&nbsp;</#list>${item.title!''}</a></li>
                    </#list>
                </#if>
            </ul>
        </div>
        <#--
        <div class="newindexMRFT">
        <h1 class="newindexMRFTH3"><dl><dd>最近添加</dd><dt></dt></dl></h1>
        <ul class="newindexMRFTM3">
            <#if latest_info_page??>
                <#list latest_info_page.content as item>
                    <li>
                        <a href="/info/content/${item.id}?mid=${mid}"><img src="${item.imgUrl!''}" width="70" height="67" /></a>
                        <dl>
                            <dd>
                                <a href="/info/content/${item.id}?mid=${mid}">${item.title!''}</a>
                            </dd>
                            <dt>
                                <#if item.content??>
                                    ${item.content!''}
                                </#if>
                            </dt>
                        </dl>
                    </li>
                </#list>
            </#if>
        </ul>
        </div>
        -->
        
        </div>
        <div class="newlistR">
        <h1 class="newlistRT"><img src="/client/images/home.png" width="25" height="25" /> ${menu_name!''} </h1>
        <ul class="newlisttxtB">
            <#if info_page??>
                <#list info_page.content as item>
                    <li><a href="/info/content/${item.id?c}?mid=${mid?c}">${item.title!''}<span>${item.createTime?string('yyyy-MM-dd')}</span></a></li>
                </#list>
            </#if>
        </ul>
        <#-- 分页开始 -->
        <div class="page clearfix mt20 fr">
            <span class="p-skip">
                <#if info_page??>
                <em>共<b>${info_page.totalElements!'0'}</b>条记录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<#if info_page.totalPages gt 0>${info_page.number+1}<#else>0</#if>/${info_page.totalPages}页</em>
                </#if>
            </span>
            <div id="J_bottomPage" class="p-wrap">
                <span class="p-num">
                <#if info_page??>
                    <#assign continueEnter=false>
                    <#if info_page.number+1 == 1>
                        <a class="pn-prev disabled"><i>&lt;</i><em>上一页</em></a>
                    <#else>
                        <a href="/info/list/${mid?c}?catId=${catId?c}&page=${info_page.number-1}" class="pn-prev disabled"><i>&lt;</i><em>上一页</em></a>
                    </#if>
                    
                    <#if info_page.totalPages gt 0>
                        <#list 1..info_page.totalPages as page>
                            <#if page <= 3 || (info_page.totalPages-page) < 3 || (info_page.number+1-page)?abs<3 >
                                <#if page == info_page.number+1>
                                    <a href="javascript:;" class="curr">${page}</a>
                                <#else>
                                    <a href="/info/list/${mid?c}?catId=${catId?c}&page=${page}" class="hide">${page}</a> <#-- ${page} -->
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
                        <a href="javascript:;" class="pn-next disabled"><em>下一页</em><i>&gt;</i></a>
                    <#else>
                        <a href="/info/list/${mid?c}?catId=${info_page.number+1}" class="pn-next"><em>下一页</em><i>&gt;</i></a>
                    </#if>
                </#if>
                </span>
            </div>
        </div>  
        <#-- 分页结束 -->
        </div>
       <div class="cle"></div>
       
</article>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
