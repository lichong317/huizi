<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
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
        tiptype: 3
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
                     基本信息<span id="TellToUser"></span>
                 </h5>
                </div>
                <form id="form1" action="/user/info" method="post">
                <div class="zhanghao_dlxx main2">
                    <ul>
                      <li class="title">真实姓名：</li>
                      <li class="xxlr">
                        <input name="realName" type="text"  class="xxinp" id="textfield" value="${user.realName!''}" size="33"/>
                        <span class="Validform_checktip">真实姓名</span>
                      </li>
                      <li class="title">性别：</li>
                      <li class="xxlr">
                        <input type="radio" id="pcUserman" name="sex" class="pcUserRaman" value="男" <#if user.sex?? && user.sex=="男">checked="checked" </#if>/>
                        <label for="pcUserman">&nbsp;男</label>
                        
                        <input type="radio" id="pcUserwoman" name="sex" value="女" <#if user.sex?? && user.sex=="女">checked="checked" </#if>/>
                        <label for="pcUserwoman">&nbsp;女</label>
                        
                        <span class="Validform_checktip"></span>
                      </li>
                      <li class="title">电子邮箱：</li>
                      <li class="xxlr">
                        <input type="text" name="email" datatype="e" class="xxinp" id="textfield2" value="${user.email!''}"/>
                        <span class="Validform_checktip">*邮箱地址</span>
                      </li>
                      <li class="title">手机：</li>
                      <li class="xxlr">
                        <input type="text" name="mobile" datatype="m" class="xxinp" id="textfield" value="${user.mobile!''}"/>
                        <span class="Validform_checktip">*手机号码</span>
                      </li>
                      <li class="title2 gray">注册时间：</li>
                      <li class="xxlr2 gray">${user.registerTime!''}</li>
                      <li class="title2 gray">最后登录时间：</li>
                      <li class="xxlr2 gray">${user.lastLoginTime!''}</li>
                      <li class="title main2">&nbsp;</li>
                      <li class="xxlr3 main2"><span class="tijiaobox">
                        <input type="submit" value="确认" style="margin:0;"  class="submit-button btn_07 pulse-shrink"/>
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
