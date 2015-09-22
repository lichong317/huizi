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

<script type="text/javascript">
$(document).ready(function(){
   $("#btn_submit").click(function(){
        var goodsId = $("#goodsId").val();
        var content = $("#content").val();
        
        if (content.length < 1 )
        {
            alert("请输入咨询内容！");
            return;
        }
        
        $.ajax({
                type: "post",
                url: "/touch/user/consult/add",
                data: { "goodsId": goodsId, "content": content },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                       alert("提交成功！请等待审核");
                    } else {
                        alert(data.message);
                    }
                }
            });
   });
});

var pageIdx = 1;
function loadMore()
{
    $.ajax({
        type:"post",
        url:"/touch/goods/consult/more/<#if goodsId??>${goodsId?c}</#if>",
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
</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>商品咨询</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<div class="mainbox myassess pt20">
<!-- <form id="form1" method="post" action="/touch/user/consult/add"> -->
     <p style="color: #F00"><#if res??>${res.message!''}</#if></p>
     <input id="goodsId" name="goodsId" value="<#if goodsId??>${goodsId?c}</#if>" type="hidden"> 
     <textarea id="content" name="content" placeholder="请输入咨询内容。。。">
     </textarea>
     <div class="clear10"></div>
     <input id="btn_submit" type="submit" value="提交" class="sub" />
     <div class="clear20"></div>
<!--  </form> -->
</div>

<ul class="main myassesslist">
    <menu id="goods-menu">
        <#if consult_page??>
            <#list consult_page.content as item>
                 <li>
                    <p class="p1">${item.username!''} ${item.content!''}</p>
                    <#if item.isReplied?? && item.isReplied>
                    <p class="p2">商家回复：${item.reply!''}</p>
                    </#if>
                 </li>
            </#list>
        </#if>
    </menu>
</ul>

    <a id="a-more" class="grey_more" href="javascript:loadMore();"><img src="/touch/images/more.png" /></a>

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
    <a class="fs09" href="/goods/<#if goodsId??>${goodsId?c}</#if>">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
