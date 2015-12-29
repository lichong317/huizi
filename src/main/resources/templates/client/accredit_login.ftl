<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<style>
.righta{float:right;}
.lefta{float:left;}
.contenta{ padding:20px 0; padding:25px; background:#fff; border-radius:5px; width:80%; margin-left:15%;}
.contenta h3{ font-size:18px; color:#999;font-family: 'Microsoft YaHei'; padding:20px 0; height:20px;}
.contenta button{ padding:10px 15px; border:0; background:#ff4454; color:#fff}
.contenta i{ width:5px; height:20px; display:inline-block; background:#ff4454; margin-right:10px; vertical-align:middle}
.contenta .lefta{ line-height:45px;}
.contenta .lefta input{ height:25px; border:1px solid #ececec; padding:2px 5px; width:150px; line-height:25px;}
.contenta .lefta span{ width:100px; text-align:right; display:inline-block}
.contenta .lefta button{ margin-left:100px;border-radius:3px;}
.contenta .righta{ border-left:1px solid #ececec; padding:10px 30px;}
.contenta .righta p{ color:#BDBABA; padding:20px 0}
.contenta .righta button{ margin-left:130px; width:200px; margin-top:15px; border-radius:3px;}
</style>
<script type="text/javascript">
$(document).ready(function(){
    //searchTextClear(".text01","用户名/邮箱/手机号","#999","#555");  
});
function otherlogin(){    
    window.location.href = "/login/alipay_accredit/<#if qq??>${qq}<#else>zfb</#if>?thirdparty_username=${alipay_user_id!''}";
} 
   
function cliLogin(){
        var username = $("#txtUser").val();
        var password = $("#Userpwd").val();      
        <#if qq??>
             var type = "qq";
        <#else>
             var type = "zfb";
        </#if>
        var alipayuser_id = $("#alipayuser_id").val();
        $.ajax({
                type: "post",
                url: "/login",               
                data: {"username": username, "password": password, "alipayuser_id": alipayuser_id, "type": type},
                dataType: "json",
                success: function (data) { 
                <!-- 修改 -->
                    if (data.role == 2){
                        window.location.href="/user/diysite/order/list/0";
                    }    
                    else if (data.code == 0) {
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
   
</script>
</head>

<body>
    <div class="w1065">
        <div class="denglutop">
            <div class="denglulogo"><a href="/"><img src="<#if site??>${site.logoUri!''}</#if>"></a></div>
            <ul class="new_add">
                <#if service_item_list??>
                    <#list service_item_list as item>
                        <li>
                            <div>
                             <img src="${item.logo!''}" width="38" height="38">
                            </div>
                            <span>${item.title!''}</span>
                        </li>
                    </#list>
                </#if>
            </ul>
        </div>
    </div>
<div class="main">
    <!--QQ登录显示用户在Qzone的昵称-->
    <#if nickName??><p style=" width: 360px;text-align: right;">惠之店欢迎您：${nickName}</p></#if>
    <input type="hidden" name="mouseposY" id="alipayuser_id" value="${alipay_user_id!''}">
<div class="contenta">
            <div class="lefta">
                <h3><i></i>绑定已有账号</h3>
               <span> 用户名：</span><input type="text" id="txtUser"><br>
                <span>密码：</span><input type="password" id="Userpwd"><br>
                <button onclick="cliLogin()">确定绑定</button>
            </div>
            <div class="righta">
               <h3><i></i>授权登陆并绑定</h3>
                <button onclick="otherlogin()">授权登陆并绑定</button> 
                <p>
                    <b>说明：</b>【授权登陆并绑定】会自动帮您创建一个账户，账户名按照固定格式生成
                    

                </p>
            </div>
            <div class="clear"></div>
       </div><!--logingbg END-->
</div>


 <div class="clear"></div>
        <div class="w1065">
    <div class="w1059 downbq">
          <ul class="downwenzi">
              <#if about_us_list??>
                   <#list about_us_list as item>
                        <#if item_index < 5>
                            <li><a href="/info/list/${about_id!'1'}?catId=${item.id?c!''}">${item.title!''}</a>丨</li>
                        </#if>
                   </#list>
              </#if>             
          </ul>
    <div class="clear"></div>
  <div><#if site??>${site.copyright!''}</#if><#if site??>${site.icpNumber!''}</#if></div>
  <div><span><a title="网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>支持：<a title="网站建设" href="http://www.ynyes.com" target="_blank">天度网络</a></span></div>
</div>
</div>
</body>
</html>
