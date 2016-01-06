<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="format-detection"content="telephone=no"/>

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>我的二维码</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>

<section class="memberhead main">
   <#if user??>
      <a onclick="changeHeads();"><img src="${user.headImageUri!''}" width="100px" height="100px"/></a>
                     <script>
                        function changeHeads(){
                            var filebutton = document.getElementById("filebutton");
                            filebutton.click();
                        }
                        function getFile(){
                            document.getElementById("uploadImgForm").submit();
                            
                        }
                    </script>
                    <form id="uploadImgForm" enctype="multipart/form-data" action="/touch/user/center/headImg" method="post">
                        <input style="display:none" name="Filedata" type="file" onchange="getFile();" id="filebutton">
                    </from>
      <p class="white fs08 lh20 ta-c">${user.username!''}</p>
   </#if>
</section>

<section class="main membertop mt10 mb10" >
  <menu>
       
  </menu>
</section>

<menu class="main memberlist" style="text-align:center;">
    <img src="${user.qrCodeUri!''}" >
</menu>
<div class=" tuichu main">


<!--main END-->

<p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/user">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''}</p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</body>
</html>
s