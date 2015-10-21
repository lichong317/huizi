<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>

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
    
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
                alert("修改成功");
                window.location.reload();
            }
            else
            {
                alert(data.msg);
                window.location.href="/login"
            }
        }
    });
});
</script>
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
            <div class="usermain04">
                <div class="separationInfo sepBasic">
                 <h5>
                     修改密码
                     <span id="TellToUser"></span>
                 </h5>
                </div>
                <form id="form1" action="/user/password" method="post">
                    <input name="__STATE" type="hidden" value="${user.password}"/>
                    <div class="zhanghao_dlxx main2">
                        <ul>
                          <li class="title">原始密码：</li>
                          <li class="xxlr">
                            <input name="oldPassword" type="password"  class="xxinp" value="" datatype="*" errormsg="原始密码不正确" recheck="__STATE"/>
                            <span class="Validform_checktip"></span>
                          </li>
                          <li class="title">新密码：</li>
                          <li class="xxlr">
                            <input name="newPassword" type="password"  class="xxinp" value="" datatype="*6-18"/>
                            <span class="Validform_checktip"></span>
                          </li>
                          <li class="title">再次输入密码：</li>
                          <li class="xxlr">
                            <input type="password"  class="xxinp" value="" datatype="*" recheck="newPassword" />
                            <span class="Validform_checktip"></span>
                          </li>
                          <li class="xxlr3 main2"><span class="tijiaobox">
                            <input type="submit" value="确认"  class="submit-button btn_07 pulse-shrink"/>
                          </span></li>
                        </ul>
                        <div style="clear:both;"></div>
                    </div>
                </form>
          </div>
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
</body>
</html>
<!--结束-->
