<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}" />
<meta name="description" content="${site.seoDescription!''}" />
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/mymember.js"></script>
<script type="text/javascript" src="/client/js/jquery.cookie.js"></script>

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
	
	//记住密码
	if ($.cookie("rmbUser") == "true") { 
        $("#rmbUser").attr("checked", true); 
        $("#txt_loginId").val($.cookie("userName")); 
        $("#txt_loginPwd").val($.cookie("passWord")); 
    } 
	
	chooseMoreShow();
	
		$("#txt_loginId")[0].focus();
	//初始化表单验证
    $("#form1").Validform({
        tiptype: 3
    });
    $(function(){
    	$("#btn_login").click(function(){
    	    saveUserInfo();
    		login();
    	});	
    });

    document.onkeydown = function(event){
        if((event.keyCode || event.which) == 13){
            saveUserInfo();
            login();
        }
       }
   
    function login(){
        var username = $("#txt_loginId").val();
        var password = $("#txt_loginPwd").val();
        
        if (username.length < 6 || password.length < 6)
        {
            alert("用户名或密码长度输入不足");
            return;
        }
        
        $.ajax({
                type: "post",
                url: "login",
                data: { "username": username, "password": password },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                        var url = document.referrer;
                        if(undefined==url || ""==url){
                            window.location.href="/";
                        }else{
                            window.location.href = url; 
                        }
                    } else {
                        alert(data.msg);
                    }
                }
            });
    }
 });
 
 //保存用户信息 
function saveUserInfo() { 
    if (document.getElementById("rmbUser").checked==true) { 
        var userName = $("#txt_loginId").val(); 
        var passWord = $("#txt_loginPwd").val(); 
        $.cookie("rmbUser", "true", { expires: 7 }); // 存储一个带7天期限的 cookie 
        $.cookie("userName", userName, { expires: 7 }); // 存储一个带7天期限的 cookie 
        $.cookie("passWord", passWord, { expires: 7 }); // 存储一个带7天期限的 cookie 
    } 
    else { 
        $.cookie("rmbUser", "false", { expires: -1 }); 
        $.cookie("userName", '', { expires: -1 }); 
        $.cookie("passWord", '', { expires: -1 }); 
    } 
}     
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
    
    <div class="  dl">
    <#if login_ad_list??>
        <#list login_ad_list as item>
                <div class="dllt"><img src="${item.fileUri!''}" width="546" height="328" /></div>
        </#list> 
    </#if>
    <div class="dlrt">
    <div class="loginbox">
      <div class="login_r"> 
        <span>请输入用户名/邮箱/手机号码</span>
        <input id="txt_loginId" type="text" class="login_txt1" />
        <span>请输入密码</span>
        <input id="txt_loginPwd" type="password" class="login_txt2" />
        <p>
          <label>
            <input id="rmbUser" type="checkbox" />
            &nbsp;记住密码</label>
          &nbsp;&nbsp;<b class="wj"><a href="#">忘记密码？</a></b></p>
        <p class="mt15">还不是会员？<b class="zc"><a href="/reg">免费注册</a></b></p>
        <input type="submit"  class="login_btn" id="btn_login" value="立即登录"/>
      </div>
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