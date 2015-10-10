<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link href="/client/style/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/style/master.css" rel="stylesheet" type="text/css" />
<link href="/client/style/mymember.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<script type="text/javascript" src="/client/js/html5.js"></script>
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/header.js"></script>
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<!--[if IE 6]>
<script type="text/javascript" src="/client/js/DD_belatedPNG_0.0.8a.js" ></script>
<script>
DD_belatedPNG.fix('.,img,background');
</script>
<![endif]-->
</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="mymember_out">
  <div class="mymember_main">
    <div class="myclear" style="height:20px;"></div>
    <#include "/client/common_user_menu.ftl" />
    <#-- 左侧菜单结束 -->
    <div class="mymember_mainbox">
      <div class="mymember_info mymember_info02">
          <div class="separationInfo sepBasic">
                <h5> 我的银行卡 <span id="TellToUser"></span> </h5>
         </div>
         <div id="J_ccbCobrandedcardEmpty" class="card-layout ml20">
             <div class="card-header CCB"><i class="bankicon"></i>${user.bankTitle!''}</div>
             <div class="card-msg clearfix"><div class="card-style card-hui">${user.bankCardCode!''}</div>
             <div class="card-operation"><a href="javascript:void(0);">&nbsp;&nbsp;申请更换</a></div></div>
             <div class="card-txt">购物可享9.8折，还有购物专区等特权优惠 </div>
         </div>
         <div class="clear"></div>
      </div>
      <!--mymember_info END-->
      
    </div>
    <!--mymember_center END-->
    <div class="myclear"></div>
  </div>
  <!--mymember_main END-->
  <div class="myclear"></div>
</div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
<script type="text/javascript">
    $(document).ready(function(){
        mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
        mymemberMenuCheck("mymember_right_menu","a","mymember_right_check","li","mysel");
        mymemberRightMove("mymember_storybox",70,90,"mymember_story_next",15,3,"a");
        mymemberRightMove("mymember_gzbox",205,241,"mymember_gznext",15,3,"a");
        mymemberRightMove("mymember_shinebox",205,310,"mymember_shinenext",15,3,"div");
      });
</script>
</body>
</html>
<!--结束-->
