 <!DOCTYPE html><head>
<meta charset="utf-8"><title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />

<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script type="text/javascript" src="/client/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<script type="text/javascript">
 var seed=60;    //60秒  
 var t1=null; 
 
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
    
     //记住密码
                if ($.cookie("rmbUser") == "true") { 
                    $("#rmbUser").attr("checked", true); 
                    $("#txt_loginId").val($.cookie("userName")); 
                    $("#txt_loginPwd").val($.cookie("passWord")); 
                } 
                
                //$("#txt_loginId")[0].focus();

                $(function(){
                    $("#btn_login").click(function(){
                        saveUserInfo();
                        login();
                    }); 
                });
            
                 $(function(){
                    $("#btn_login1").click(function(){
                        //saveUserInfo();
                        loginMobile();
                    }); 
                });
                
               // document.onkeydown = function(event){
                   // if((event.keyCode || event.which) == 13){
                       // saveUserInfo();
                       // login();
                    //}
                   //}
               
                $("#dyMobileButton").bind("click", function() {  
        
                var mob = $('#usermobile').val();
        
                var re = /^1\d{10}$/;
                
                if (!re.test(mob)) {
                    alert("请输入正确的手机号");
                    return;
                }
                
                // 判断用户是否存在
                $.ajax({
                            type: "post",
                            url: "/reg/check/mobile",
                            data: { "param": mob},
                            dataType: "json",
                            success: function (data) {
                                if (data.status == "n") {
                                    $.ajax({  
                                            url : "/reg/smscode",  
                                            async : true,  
                                            type : 'GET',  
                                            data : {"mobile": mob},  
                                            success : function(data) {  
                                                            
                                                 if(data.statusCode == '000000')
                                                            {  
                                                                t1 = setInterval(tip, 1000);  
                                                            }
                                                            else
                                                            {
                                                                $("#dyMobileButton").removeAttr("disabled");
                                                            }
                                                        },  
                                                   error : function(XMLHttpRequest, textStatus,  
                                                                errorThrown) {  
                                                            alert("发送失败");
                                                        }  
                                              
                                    });
                                } else {
                                    alert("此用户名不存在");
                                }
                            }
                        });
                                       
                });
});
                   
            
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
                                    if (data.hasRedenvelope == 1){
                                        alert("有新红包！请到个人中心领取");
                                    }        
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
            
             function loginMobile(){
                    var mobile = $("#usermobile").val();
                    var code = $("#yzmcode").val();
                    
                    var re = /^1\d{10}$/;
        
                    if (!re.test(mobile)) {
                        alert("请输入正确的手机号");
                        return;
                    }
                    
                    $.ajax({
                            type: "post",
                            url: "loginmobile",
                            data: { "mobile": mobile, "code": code },
                            dataType: "json",
                            success: function (data) {
                                if (data.code == 0) {
                                    if (data.hasRedenvelope == 1){
                                        alert("有新红包！请到个人中心领取");
                                    }        
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
            
            function enableBtn()
            {  
                $("#dyMobileButton").removeAttr("disabled");   
            } 
            
            function tip() 
            {  
                seed--;  
                if (seed < 1) 
                {  
                    enableBtn();  
                    seed = 60;  
                    $("#dyMobileButton").val('点击获取短信验证码');  
                    var t2 = clearInterval(t1);  
                } else {  
                    $("#dyMobileButton").val(seed + "秒后重新获取");  
                }  
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

<#--<section class="denglu_center" style="margin-left:10px">
  <div>
     <ul>
            <#if service_item_list??>
                  <li style="float:left;">
                       <#list service_item_list as item>
                            <#if item_index <4>
                                <a href="javascript:;"><img src="${item.logo!''}" width="38" height="38"/><span>${item.title!''}</span></a>
                            </#if>
                       </#list>
                  </li>
            </#if>
     </ul>   
  </div>
</section>-->
    </div>
    </div>
 <div class="clear"></div>   
    <div class="main">
    <style>
    .zhuce-tab {
  cursor: pointer;
  font-size: 16px;
  color: #999;
  display: inline-block;
  font-family: 'Microsoft YaHei';
}
.zhuce-tab .xz {
  border-top: solid 2px #ff4454;
  font-size: 16px;
  color: #666;
  background: #fff;
}
.zhuce-tab ul li {
  float: left;
  height: 40px;
  line-height: 40px;
  padding: 0 20px;
}
.reg dl dd {
  margin-left: 110px;
}
.reg dl dt {
  color: #999;
  float: left;
  height: 30px;
  line-height: 30px;
  text-align: right;
  width: 100px;
}
.login_wrap {
  background: #fff url(/client/images/dsds.png) no-repeat 540px center;
  border: solid 8px #f0f0f0;
  height: 400px;
  margin-bottom: 20px;
  width:1000px;
  margin:0 auto;
}
.reg dl dt i {
  color: #f33;
  font-style: normal;
  font-weight: 400;
}
.reg dl {
  line-height: 30px;
  margin-top: 8px;
  min-height: 30px;
}
.reg dl dd button {
  background: #ff4454;
  border: 0;
  border-radius: 3px;
  color: #fff;
  cursor: pointer;
  font-size: 14px;
  font-weight: bold;
  height: 40px;
  width: 160px;
}
.reg dl dd input[type=text], .reg dl dd input[type=password] {
  border: solid 1px #ccc;
  border-radius: 2px;
  box-shadow: inset 0 2px #f3f3f3;
  height: 28px;
  line-height: 28px\9;
  text-indent: 5px;
  width: 240px;
}
.reg dl dd em {
  color: #999;
  font-style: normal;
  font-weight: 400;
  margin-left: 10px;
}
#codedl {
  display: none;
}
.regtip {
  margin-top: 10px;
  text-shadow: 0 1px 0 #fff;
}
.right {
  float: left;
  margin-left: 20px;
}
div {
  display: block;
}
.regtip a {
  background: #9c3;
  color: #fff;
  margin-left: 5px;
  padding: 2px;
  text-shadow: none;
}
    </style>
<div class="login_wrap">
            <div class="zhuce-tab">
                <ul id="tableLogin">
                    <li class="xz">快速登录</li>
                    <li class="">账号密码登录</li>
                </ul>
            </div>
            <script>          
                $(function(){
                    $("#tableLogin li").click(function(){
                        if($(this).hasClass("xz")){
                            return;
                        }else{
                            $(".tableLoginreg").css("display","none");
                            
                            $(".tableLoginreg").eq($(this).index()).css("display","block");
                            $(this).addClass("xz").siblings().removeClass("xz");
                        }
                    }); 
                });
            </script>
            
            <div class="xxknr" id="xxknr">
                <div class="reg tableLoginreg" style="display: block;">
                    <dl>
                        <dt><i>*</i>手机号码</dt>
                        <dd>
                            <input type="text" id="usermobile" >
                        </dd>
                    </dl>
                   <#-->  <dl id="codedl">
                        <dt><i>*</i>验证码</dt>
                        <dd>
                            <input type="text" id="yzmcode" style="width: 120px;"><img id="vCodeImg" src="/ImgCode.aspx?t=64.54859382938594" width="80" height="30" style="margin: 0 10px; vertical-align: middle;" onclick=" this.src = '/ImgCode.aspx?t=' + Math.random() * 100 "><a>看不清楚？换一张</a></dd>
                    </dl> -->
                    <dl>
                        <dt><i>*</i>短信验证码</dt>
                        <dd>
                            <input type="text" id="yzmcode" style="width: 120px;">
                            <input id="dyMobileButton" type="button" class="sub" value="发送验证码" style="text-align:center;width: 15%; border-radius: 3px; margin-left:10px; background: #1c2b38; color: #fff; line-height: 35px; height: 35px;" />
                            </dd>
                    </dl>

                    <dl>
                        <dt></dt>
                        <dd>
                          <#-->  <input name="" id="mmprovision" type="checkbox" checked="checked" style="margin-right: 5px; vertical-align: middle;"><label for="mmprovision" style="color: #999;">记住密码</label></dd> -->
                            <dd><a href="/login/password_retrieve" class="showyhzt" style=" margin: 0 5px;">忘记密码？</a></dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd>
                            <button id="btn_login1">登录</button></dd>
                    </dl>
                </div>
                <div class="reg tableLoginreg" style="display: none;">
                    <dl>
                        <dt><i>*</i>用户名/手机号</dt>
                        <dd>
                            <input type="text" id="txt_loginId" ></dd>
                    </dl>
                    <dl>
                        <dt><i>*</i>密码</dt>
                        <dd>
                            <input type="password" id="txt_loginPwd"></dd>
                    </dl>

                    <dl>
                        <dt></dt>
                        <dd>
                            <input name="" id="rmbUser" type="checkbox" checked="checked" style="margin-right: 5px; vertical-align: middle;"><label for="mmprovision" style="color: #999;">记住密码</label></dd>
                            <dd><a href="/login/password_retrieve" class="showyhzt" style=" margin: 0 5px;">忘记密码？</a></dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd>
                            <button  id="btn_login">登录</button></dd>
                    </dl>
                </div>
                <div class="login_r item" style="width: 415px;
  float: left;
  padding-left: 65px;
  padding-top: 20px;
  color: #999;">
  
  <style>
  .item table td a i {
  background:url(/client/images/login.png) no-repeat;
}
.item table td a i.weixin {
  background-position: -170px -40px;
}
.item table td a i {
  width: 24px;
  height: 24px;
  display: inline-block;
  vertical-align: middle;
}
.item table td a i.qq {
  background-position: -9px -40px;
}
.item table td a i.alipay {
  background-position: -124px -40px;
}
  </style>
             <table width="300" border="0" cellpadding="5" cellspacing="0">
                  <tbody>
                  <tr style="height:30px;">合作账号登录:</tr>
                <tr><td><a style="text-decoration:none" href="/weixin/login"><i class="weixin"></i>&nbsp;&nbsp;微信</a></td>
                    <td><a style="text-decoration:none" href="https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101277681&redirect_uri=http://www.huizhidian.com/login/qq_login_return"><i class="qq"></i>&nbsp;&nbsp;QQ</a></td>
                    <!-- <td><a style="text-decoration:none" href="user.php?act=oath&type=weibo"><i class="sina"></i>&nbsp;&nbsp;新浪</a></td> -->
                    <#--><td><a style="text-decoration:none" href="/login/alipay_login"><i class="alipay"></i>&nbsp;&nbsp;支付宝</a></td> -->
                  </tr>
                </tbody></table>
             </div>
                
                
            </div>
            <div class="clear15"></div>
            <div class="regtip right">还没有惠之店网上商城账号？现在就<a href="/reg">注册</a></div>
        </div>          
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
