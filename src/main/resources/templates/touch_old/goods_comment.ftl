<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
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

  <!-- 用户名中间变为*号  2015-8-4 15:38:18 mdj  -->
$(document).ready(function(){
    getElement();
});
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

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>评价列表</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="list_top">
<table class="main">
  <tr>
    <td <#if !stars?? || stars?? && stars==0>class="sel"</#if>><a href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>">全部（<span>${comment_count!'0'}</span>）</a></td>
    <td <#if stars?? && stars==3>class="sel"</#if>><a href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>?stars=3">好评（<span>${three_star_comment_count!'0'}</span>）</a></td>
    <td <#if stars?? && stars==2>class="sel"</#if>><a href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>?stars=2">中评（<span>${two_star_comment_count!'0'}</span>）</a></td>
    <td <#if stars?? && stars==1>class="sel"</#if>><a href="/touch/goods/comment/<#if goodsId??>${goodsId?c}</#if>?stars=1">差评（<span>${one_star_comment_count!'0'}</span>）</a></td>
  </tr>
</table>
</div>
<div class="clear35"></div>
<ul class="main myassesslist">
<menu id="goods-menu">
    <#if comment_page??>
         <#list comment_page.content as item>
              <li>
                <p>${item.content!''}</p>
                <#if item.isReplied?? && item.isReplied>
                    <p class="p2">商家回复：${item.reply!''}</p>
                </#if>
                <p class="c9">用户名：<b class="userName">${item.username!''}</b><span>时间：${item.commentTime?string("yyyy-MM-dd")}</span></p>
              </li>
         </#list>
    </#if>
</menu>
</ul>

  <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>
<!--main END-->

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
  </div>
  </div>
</section>
  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/goods/<#if goodsId??>${goodsId?c}</#if>">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
