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
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/mymember.js"></script>

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
    <div class="w1065">
    <div class="denglutop">
<div class="denglulogo"><a href="/"><img src="<#if site??>${site.logoUri!''}</#if>"></a></div>
<section class="denglu_center">
  <table>
    <tbody>
            <#if service_item_list??>
                  <tr>
                       <#list service_item_list as item>
                            <#if item_index <4>
                            <td>
                                <a href="javascript:;"><img src="${item.logo!''}" width="38" height="38"/>${item.title!''}</a>
                            </td>
                            </#if>
                       </#list>
                  </tr>
            </#if>
     </tbody>   
  </table>
</section>
    </div>
 <div class="clear"></div>   
    <div class="dl">
<div class="loginbox">
  <div class="login_r"> 
    <form id="form1" method="post" action="/reg">
        <div>
            <span class="Validform_checktip">请输入用户名/邮箱/手机号码</span>
            <input type="text" name="username" class="login_txt1" datatype="s6-20" ajaxurl="/reg/check/username" value = "${username!''}"/>
        </div>
        
        <div>
            <span class="Validform_checktip">请输入密码</span>
            <input type="password" name="password" class="login_txt2" datatype="s6-20"/>
        </div>
        
        <div>
            <span class="Validform_checktip">请确认密码</span>
            <input type="password" class="login_txt2" datatype="*" recheck="password"/>
        </div>
        
        <div>
            <span class="Validform_checktip"><#if errCode?? && 1==errCode>验证码错误<#else>请填写验证码</#if></span>
            <input type="text" class="login_txt2" name="code" style="width:170px; float:left" datatype="s4-4" errormsg="请填写4位字符"/>
            <img src="/code" onclick="this.src = '/code?date='+Math.random();" id="yzm" />
        
        </div>
        <div class="clear"></div>

        <p>
            <span class="Validform_checktip">请同意协议</span>
            <label><input name="" type="checkbox" value="" datatype="*"/>&nbsp;我已认真阅读并同意</label>&nbsp;&nbsp;<b class="wj"><a href="#">《惠资生活用户协议》</a></b>
        </p>
        <p class="mt15">已有账号<b class="zc"><a href="/login">立即登录</a></b></p>
        <input type="submit" class="login_btn" value="立即注册"/>
    </form>
  </div>
</div>
</div>
    
<div class="clear"></div>
<div class="h30"></div>
<div class="w1059 downbq">
    <div class="clear"></div>
    <#if site??>${site.copyright!''}</#if>
    <a style="color:#222222" href="#"><#if site??>${site.icpNumber!''}</#if></a>
    <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>
</div>
</div>
    </div>
</body>
</html>