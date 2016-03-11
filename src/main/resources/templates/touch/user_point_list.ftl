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
</script>
</head>

<body class="eeebg">
<header class="comhead">
  <h2>我的积分</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="mainbox pt20 pb20 whitebg">
  <p class="ta-c pb10">可用积分</p>
  <p class="ta-c red h06 lh6 fs5"><#if point_page?? && point_page.content?? && point_page.content[0]??>${point_page.content[0].totalPoint!'0'}<#else>0</#if></p>
</div>

<section class="tabfix center scoretab mt30">
  <menu>
    <a href="/touch/pointGoods/list"><img src="/touch/images/member/score01.png" /><p>查看可兑换的礼品>></p></a>
    <a href="#"><img src="/touch/images/member/score02.png" /><p>积分抽奖>></p></a>
  </menu>
</section>

<h3 class="center mt30 scoretit mb20"><p>积分记录</p></h3>
<ul class="scoresum center">
  <li class="li01">
    <p>日期</p>
    <p>收入/支出</p>
    <p>详细说明</p>
  </li>
  <#if point_page??>
      <#list point_page.content as point>
            <li>
                <p class="c9"><#if point.pointTime??>${point.pointTime?string("yyyy-MM-dd")}</#if></p>
                <p class="red"><#if point.point??><#if point.point gt 0>+</#if>${point.point}</#if></p>
                <p class="c9">${point.detail!''}</p>
            </li>
      </#list>
  </#if>
</ul>
<div class="clear h02"></div>
<p class="center ta-r">
    <#if point_page??>
        <#if point_page.number+1 == 1>
            <a class="c9 mr30" href="javascript:;"><span>上一页</span></a>
        <#else>
            <a href="/touch/user/point/list?page=${point_page.number-1}" class="mr30">上一页</a>
        </#if>  
        
        <#if point_page.number+1 == point_page.totalPages || point_page.totalPages==0>
              <a  href="javascript:;"><span>下一页</span></a>
        <#else>
              <a href="/touch/user/point/list?page=${point_page.number+1}"><span>下一页</span></a>
        </#if>  
    </#if>
</p>

<div class="clear h03"></div>
  
</body>
</html>
