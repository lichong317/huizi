<!DOCTYPE html><head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/style/pplist.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
    <!--html5兼容-->
    <!--[if lt ie 9]> 
        <script src="/client/js/html5.js"></script> 
    <![endif]-->
    <!--html5兼容结束-->

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
</script>
</head>


<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<!--mymember-->
<div class="main">
    <div class="wrapper">
  <div class="breadcrumb"><a href="/">首页</a> &gt; <span>全部分类</span></div>
</div>
<div class="wrapper">
      <#if top_cat_list??>
           <#list top_cat_list as item>
           <#if item_index < 4>
           <div class="mod-cate-head"><h1>${item.title!''}相关产品品牌</h1> <span>共有<#if ("second_level_"+item_index+"_cat_list")?eval?? >${("second_level_"+item_index+"_cat_list")?eval?size}</#if>个产品线</span></div>                
                <div class="mod-cate-box mod-cate-brand">
                    <#if ("second_level_"+item_index+"_cat_list")?eval?? >
                        <#list ("second_level_"+item_index+"_cat_list")?eval as secondLevelItem>
                             <#if secondLevelItem_index%2 == 0>
                                <ul class="cate-item clearfix">
                                    <li>
                                        <h3><i></i><a href="/list/${secondLevelItem.id?c}">${secondLevelItem.title!''}</a></h3>
                                        <div class="subcate-list">
                                            <#if ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval?? >
                                                <#list ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval as thirdLevelItem>
                                                    <a href="/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a>
                                                </#list>
                                                <a href="/list/${secondLevelItem.id?c}">更多»</a>
                                            </#if>                                            
                                        </div>
                                    </li>
                             <#else>
                                    <li>
                                        <h3><i></i><a href="/list/${secondLevelItem.id?c}">${secondLevelItem.title!''}</a></h3>
                                        <div class="subcate-list">
                                            <#if ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval?? >
                                                <#list ("third_level_"+item_index+secondLevelItem_index+"_cat_list")?eval as thirdLevelItem>
                                                    <a href="/list/${thirdLevelItem.id?c}">${thirdLevelItem.title!''}</a>
                                                </#list>
                                                <a href="/list/${secondLevelItem.id?c}">更多»</a>
                                            </#if>                                            
                                        </div>
                                    </li>
                                </ul>
                             </#if>                            
                        </#list>                       
                    </#if>                   
               </div>
          </#if>
          </#list>
      </#if>
</div>
</div>
<div class="clear35"></div>
<!--mymember END-->
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>