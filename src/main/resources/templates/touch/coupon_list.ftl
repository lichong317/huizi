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
    indexBanner("box","sum",300,5000,"pronum");
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

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>优惠券</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<section id="box">
  <ul id="sum">
    <#if coupon_type_list??>
        <#list coupon_type_list as coupontype>
            <#if coupontype_index < 3>
            <#if coupontype.picUri??>
                <li><img src="${coupontype.picUri!''}" height="240"/></li>
            </#if>
            </#if>
        </#list>
    </#if>
  </ul>
  <div class="clear"></div>
</section>

<div class="main">
  <div class="clear10"></div>
  <section class="index_part">
    <table class="comtab indexnav">
      <tr>
        <td><a class="a1" href="/touch/user/coupon/list/0">我的优惠券</a></td>       
        <td><a class="a3" href="/touch/cart">购物车</a></td>
        <td><a class="a2" href="#">使用规则</a></td>
      </tr>
    </table>
  </section>
  <section class="index_part">
  
  <#if coupon_type_list??>
        <#list coupon_type_list as coupontype>
            <div class="myorder_list"> 
                <a href="/touch/coupon/get?couponTypeId=${coupontype.id?c}"><img src="${coupontype.picUri!''}" width="100%" height="200"></a>
            </div>
        </#list>
  </#if>
  
  
</div>
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
    <a class="fs09" href="/coupon/list">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
</body>
</html>
