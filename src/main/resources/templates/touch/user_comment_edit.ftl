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
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){  
     //初始化表单验证
    $(".commentForm").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
                alert("提交评论成功");
                window.location.reload();
            }
            else
            {
                alert(data.message);
            }
        }
    });
});   
</script>
</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>评论</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<div class="main">
    <#if tdOrderGoods??>
    <a class="phone_list" href="/touch/goods/${tdOrderGoods.goodsId?c}">
        <b><img src="${tdOrderGoods.goodsCoverImageUri}" width="95" height="95"/></b>
        <p class="p1">${tdOrderGoods.goodsTitle!''}</p>
        <p>${tdOrderGoods.goodsSubTitle!''}</p>
        <p class="fl">购买数量：<span class="red">${tdOrderGoods.quantity!''}</span></p>
        <p class="p2 ta-r mt20">￥${tdOrderGoods.price?string("0.00")}</p>
        <div class="clear"></div>
    </a>
    </#if>
</div>
<div class="clear20"></div>
<#if comment??>
    <div class="mainbox myassess">
        <textarea>${comment.content!''}</textarea>
        <p class="pt10 pb10 w100">
            <input type="radio" disabled="disabled" <#if comment.stars?? && comment.stars==3>checked="checked"</#if>/>好评
            <input type="radio" disabled="disabled" <#if comment.stars?? && comment.stars==2>checked="checked"</#if>/>中评
            <input type="radio" disabled="disabled" <#if comment.stars?? && comment.stars==1>checked="checked"</#if>/>差评
        </p>        
    </div>
<#else>
<form class="commentForm" action="/touch/user/comment/add" method="post">
    <input type="hidden" name="orderId" value=${orderId?c} />
    <input type="hidden" name="ogId" value=${tdOrderGoods.id?c} />
    <input type="hidden" name="goodsId" value=${tdOrderGoods.goodsId?c} />
    <div class="mainbox myassess">
        <textarea name="content">请输入您的评价</textarea>
        <p class="pt10 pb10 w100">
          <input type="radio" name="stars" value="3" datatype="n" nullmsg="请点击进行评价"/>好评
          <input type="radio" name="stars" value="2" datatype="n" nullmsg="请点击进行评价"/>中评
          <input type="radio" name="stars" value="1" datatype="n" nullmsg="请点击进行评价"/>差评
        </p>
        <input type="submit" value="提交" class="sub" />
    </div>
  <div class="clear20"></div>
</form> 
</#if>
<!--main END-->

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
    <a class="fs09" href="/user">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
<div class="clear70"></div> 
</body>
</html>
