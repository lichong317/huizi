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
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

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

    function delcfm() {
        if (!confirm("确认要删除记录？")) {
            window.event.returnValue = false;
        }
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
  
  <div class="mymember_scan_check">
        <a <#if !categoryId??>class="mysel"</#if> href="/user/recent/list">全部分类</a>
        <#if top_cat_list??>
        	<#list top_cat_list as item>
        		<a <#if categoryId ?? &&categoryId == item.id>class="mysel"</#if> href="/user/recent/list?categoryId=${item.id?c!''}">${item.title!''}</a>
        	</#list>
        </#if>		
  </div>
  
<script type="text/javascript">
$(document).ready(function(){
    memberScanList("scan_line",".mymember_scan");
});
</script>

  <div class="mymember_scan">
    <span id="scan_line"></span>
        <#if recent_page??>
            <#list recent_page.content as rg>
                <#if !lastTime?? || rg.visitTime?string("yyyy-MM-dd") != lastTime?string("yyyy-MM-dd")>
                    <div class="myclear"></div>
                    <#assign lastTime=rg.visitTime>
                    <#if today?string("yyyy-MM-dd") == lastTime?string("yyyy-MM-dd") >
                    	<h3>今天<span>${rg.visitTime?string("yyyy-MM-dd")}</span><a href="/user/recent/delete/0?date=${rg.visitTime?string("yyyy-MM-dd")}" onClick="delcfm()">删除</a><i></i>
                    		<a class="clearall" href="/user/recent/delete/-1?date=${rg.visitTime?string("yyyy-MM-dd")}" onClick="delcfm()">清空历史记录</a>
                    	</h3>
                    <#elseif yesterday?string("yyyy-MM-dd") == lastTime?string("yyyy-MM-dd")>	
                    	<h3>昨天<span>${rg.visitTime?string("yyyy-MM-dd")}</span><a href="/user/recent/delete/0?date=${rg.visitTime?string("yyyy-MM-dd")}" onClick="delcfm()">删除</a><i></i></h3>
           	        <#elseif tdby?string("yyyy-MM-dd") == lastTime?string("yyyy-MM-dd")>	
                    	<h3>前天<span>${rg.visitTime?string("yyyy-MM-dd")}</span><a href="/user/recent/delete/0?date=${rg.visitTime?string("yyyy-MM-dd")}" onClick="delcfm()">删除</a><i></i></h3>
                    <#else>
                    <h3>${rg.visitTime?string("MM月dd日")}<span>${rg.visitTime?string("yyyy-MM-dd")}</span><a href="/user/recent/delete/0?date=${rg.visitTime?string("yyyy-MM-dd")}" onClick="delcfm()">删除</a><i></i></h3>
                    </#if>
                    <div class="myclear"></div>
                </#if>
                <div class="mymember_scanpart">
                  <#--
                  <a class="a001" href="#">
                    <img src="/client/images/mymember/delete.png">
                  </a>
                  -->
                  <a class="a001" href="/user/recent/delete/${rg.id?c}" onClick="delcfm()"><img src="/client/images/mymember/delete.png" /></a>
                  <a href="/goods/${rg.goodsId?c!''}">
                    <img src="${rg.goodsCoverImageUri!''}" width="220" height="220">
                  </a>
                  <p>￥${rg.goodsSalePrice?string("#.##")}</p>
                </div>
            </#list>
        </#if>
    <div class="myclear"></div>
  </div>
  
</div><!--mymember_main END-->
</div>
<!--mymember END-->

<#include "/client/common_footer.ftl" />

</div>
</body>
</html>




  











