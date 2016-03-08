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
    
});

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

<body class="eeebg">
<header class="comhead">
  <h2>商品咨询</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="/touch" class="a1"><img src="/touch/images/home.png" /></a>
</header>
<div class="comheadbg"></div>
    
    <input id="goodsId" name="goodsId" value="<#if goodsId??>${goodsId?c}</#if>" type="hidden"> 
    <p class="w90 mga c7 pt30 pb10 fs3">我要咨询：</p>
    <textarea id="content" name="content" class="leave_area" placeholder="请输入咨询内容。。。"></textarea>
    <input id="btn_submit" type="submit" class="h08 lh8 w90 white redbg block mga sub bor-rad mt20 fs3" value="提交" />
    <div class="clear h04"></div>
    
    <#if consult_page??>
         <#list consult_page.content as item>
              <section class="pro_leave mainbox bot-border pt20 pb20 whitebg">
                  <h3 class="c9 pb10"><b class="userName">${item.username!''}</b>&nbsp;&nbsp;&nbsp;&nbsp;<#if item.consultTime??>${item.consultTime?string("yyyy-MM-dd")}</#if></h3>
                  <p class="pb10">${item.content!''}</p>
                  <p class="pb10"><span class="red">商家回复：</span>${item.reply!''}</p>
              </section>
         </#list>
    </#if>
    
<div class="clear h02"></div>
<p class="center ta-r">
    <#if consult_page??>
        <#if consult_page.number+1 == 1>
            <a class="c9 mr30" href="javascript:;"><span>上一页</span></a>
        <#else>
            <a href="/touch/goods/consult/${goodsId?c}?page=${consult_page.number-1}" class="mr30">上一页</a>
        </#if>  
        
        <#if consult_page.number+1 == consult_page.totalPages || consult_page.totalPages==0>
              <a  href="javascript:;"><span>下一页</span></a>
        <#else>
              <a href="/touch/goods/consult/${goodsId?c}?page=${consult_page.number+1}"><span>下一页</span></a>
        </#if>  
    </#if>
</p>
<div class="clear h03"></div>
  
</body>
</html>
