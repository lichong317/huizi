<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
        //处理用户名
    getElement();
});

var pageIdx = 1;
function loadMore()
{
    $.ajax({
        type:"post",
        url:"/touch/goods/comment/more/<#if goodsId??>${goodsId?c}</#if>",
        data: { "page": pageIdx},
        dataType: "json",
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


/**
 * 获取要隐藏用户名的元素
 * @author mdj
 */
function getElement(){
    var pElement = $(".userName").toArray();
    for(var i = 0;i < pElement.length;i++)
    {
       var originName = pElement[i].innerHTML;
       var name =  changeName(originName);
       pElement[i].innerText=name;
    }
}
/**
 * 隐藏用户名
 * @author mdj
 */
function changeName(p)
{
    var temp = p;
    if(temp.length == 11)
    {
        var changeStr = temp.substring(3, 7);
        temp = temp.replace(changeStr,"****");
    }
    else
    {
        var startStr = "";
        var strLength = temp.length;
        for (var i = 0; i < strLength - 4; i++)
        {
            startStr += "*";
        }
        var changeStr = temp.substring(2, strLength - 2)

        temp = temp.replace(changeStr, startStr);
    }
    return temp;
}
</script>
</head>

<style>
.grey_more{ width:94%;
    display:block;
    border:none;
    font-family:"微软雅黑";
    font-size:1em;
    cursor:pointer;
    text-align:center;
    color:#fff;
    line-height:40px;
    height:40px;
    margin:20px auto 30px;}
</style>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>商品评价</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<section class="tabfix w100 evalmenu">
  <menu>
    <a <#if !stars?? || stars?? && stars==0>class="sel"</#if>href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>">全部评价<p>${comment_count!'0'}</p></a>
    <a <#if stars?? && stars==3>class="sel"</#if> href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>?stars=3">好评<p>${three_star_comment_count!'0'}</p></a>
    <a <#if stars?? && stars==2>class="sel"</#if> href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>?stars=2">中评<p>${two_star_comment_count!'0'}</p></a>
    <a <#if stars?? && stars==1>class="sel"</#if> href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>?stars=1">差评<p>${one_star_comment_count!'0'}</p></a>
  </menu>
</section>

<div class="w100 bot-border h02"></div>
<menu id="goods-menu">
    <#if comment_page??>
         <#list comment_page.content as item>
              <section class="pro_leave mainbox bot-border pt20 pb20">
                 <h3><p class="absolute-r c9"><b class="userName">${item.username!''}</b>&nbsp;&nbsp;&nbsp;&nbsp;${item.commentTime?string("yyyy-MM-dd")}</p>
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 0>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 1>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 2>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 3>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 4>star01.png<#else>star02.png</#if>" />
                  </h3>
                  <p class="pb10">${item.content!''}</p>
                  <p class="pb10"><span class="red">商家回复：</span><#if item.isReplied?? && item.isReplied>${item.reply!''}</#if></p>
              </section>
         </#list>
    </#if>
</menu>
    <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>
<div class="clear h03"></div>
  
</body>
</html>
