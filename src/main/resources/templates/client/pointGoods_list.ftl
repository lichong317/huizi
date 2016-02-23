<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>惠之店</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="copyright" content="" />
<!--[if IE]>
   <script src="js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
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
    menuDownList("mainnavdown","#navdown",".a2","sel");
    
    chooseMoreShow();
    
    
});

function btnPageSubmit() 
{
    var page = $('#iPageNum').val();
    if (isNaN(page) || page=="" ){ page = 1 }
    window.location.href = "/pointGoods/list?page="
    + (page - 1);
}
</script>
</head>

<body>
<#include "/client/common_header.ftl" />

<style>
  .jfbanner img{width: 100%;height: auto;}
  .jifendhsp img{width: 263px; height: 263px; border:solid 1px #e8e8e8;margin:7px;}
  .jifendhsp{width: 280px; height: 402px; float: left; border:solid 1px #afafaf; margin:9px;}
  .jifendhsp:hover{border:1px solid #eee; box-shadow:0px 2px 0px #ccc;}
  .jifendhsp p{margin:0 12px; line-height: 30px; height: 60px; overflow: hidden; border-bottom: dashed 1px #e8e8e8;}
  .jifengm a{float: right;
    margin-right: 12px;
    background: #ff4454;
    color: #FFF;
    padding: 5px 10px;
    margin-top: 11px;}
  .jifengm a:hover{background:#4d99e5;}
</style>

<div class="clear"></div>
 <#-- <div class="jfbanner">
    <img src="images/jfsc_02.png">
  </div> -->
  <div class="clear h30"></div>
<div class="main">
    <#if goods_page??>
        <#list goods_page.content as tdPointGoods>
            <div class="jifendhsp">
                <a href="/pointGoods/${tdPointGoods.id?c}">
                  <img src="${tdPointGoods.coverImageUri!''}" width="265" height="265">
                  <p>${tdPointGoods.title!''}</p></a>
                <span class="jifenjiage" style="
                    float: left;
                    font-size: 24px;
                    color: #ff4454;
                    line-height: 50px;
                    margin-left: 12px;
                ">${tdPointGoods.pointUse!'0'}积分</span>
                <span class="jifengm"><a href="/pointGoods/order/info?pointGoodsId=${tdPointGoods.id?c}" >立即兑换</a></span>
            </div>
        </#list>
    </#if>

<div class="clear h30"></div>
      <div class="pagebox">
      <div class="num">
       <#if goods_page??>
            <#assign continueEnter=false>
            <#if goods_page.number+1 == 1>
                <a class="a1 a0" href="javascript:;"><span>上一页</span></a>
            <#else>
                <a class="a1 " href="/pointGoods/list?page=${goods_page.number-1}"><span>上一页</span></a>
            </#if>
            
            <#if goods_page.totalPages gt 0>
                <#list 1..goods_page.totalPages as page>
                    <#if page <= 3 || (goods_page.totalPages-page) < 3 || (goods_page.number+1-page)?abs<3 >
                        <#if page == goods_page.number+1>
                            <a class="sel" href="javascript:;">${page}</a>
                        <#else>
                            <a href="/pointGoods/list?page=${page-1}">${page}</a> <#-- ${page} -->
                        </#if>
                        <#assign continueEnter=false>
                    <#else>
                        <#if !continueEnter>
                            <span> ... </span>
                            <#assign continueEnter=true>
                        </#if>
                    </#if>
                </#list>
            </#if>
            
            <#if goods_page.number+1 == goods_page.totalPages || goods_page.totalPages==0>
                <a class="a2 a0" href="javascript:;"><span>下一页</span></a>
            <#else>
                <a class="a2" href="/pointGoods/list?page=${goods_page.number+1}"><span>下一页</span></a>
            </#if>
        </#if>
        <span> 共<b>${goods_page.totalPages}</b>页 </span>
      </div>
      <div class="page">
        <input class="sub" type="submit" onclick="javascript:btnPageSubmit();" value="确定" />
        <span>页</span>
        <input class="text" type="text" value="${pageId + 1}" id="iPageNum"/>
        <span>到第</span>
      </div>
      <div class="clear"></div>
    </div><!--pagebox END-->

</div>


  

<div class="clear h40"></div>
<#include "/client/common_footer.ftl" />
</div>
</body>
</html>
