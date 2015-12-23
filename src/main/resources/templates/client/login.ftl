 <!DOCTYPE html><head>
<meta charset="utf-8">
<title>惠资生活</title>
<meta name="keywords" content="惠资生活" />
<meta name="description" content="惠资生活" />
<meta name="copyright" content="惠资生活 版权所有" />

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
  background: #fff url(/client/images/dsds.png) no-repeat right center;
  border: solid 8px #f0f0f0;
  height: 380px;
  margin-bottom: 20px;
  width:960px;
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
  float: right;
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

            $(document).ready(function(){    
                //记住密码
                if ($.cookie("rmbUser") == "true") { 
                    $("#rmbUser").attr("checked", true); 
                    $("#txt_loginId").val($.cookie("userName")); 
                    $("#txt_loginPwd").val($.cookie("passWord")); 
                } 
                
                $("#txt_loginId")[0].focus();

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
                
                document.onkeydown = function(event){
                    if((event.keyCode || event.which) == 13){
                       // saveUserInfo();
                       // login();
                    }
                   }
               
               
                $("#dyMobileButton").bind("click", function() {  
        
                var mob = $('#usermobile').val();
        
                var re = /^1\d{10}$/;
                
                if (!re.test(mob)) {
                    alert("请输入正确的手机号");
                    return;
                }
                        
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
            </script>
            <div class="regtip right">还没有惠之店网上商城账号？现在就<a href="/reg">注册</a></div>
            <div class="xxknr" id="xxknr">
                <div class="reg tableLoginreg" style="display: block;">
                    <dl>
                        <dt><i>*</i>手机号码</dt>
                        <dd>
                            <input type="text" id="usermobile">
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
            </div>

        </div>          
    </div>
    
        <div class="clear"></div>
        <div class="w1065">
        <div class="h30"></div>
    <div class="w1059 downbq">
          <ul class="downwenzi">
          <li><a href="#">公司简介</a>丨</li>
          <li><a href="#">联系我们</a>丨</li>
          <li><a href="#">招贤纳士</a>丨</li>
          <li><a href="#">合作伙伴</a>丨</li>
          <li><a href="#">广告合作</a></li>
          </ul>
    <div class="clear"></div>
  <#if site??>${site.copyright!''}</#if><a style="color:#222222" href="#"><#if site??>${site.icpNumber!''}</#if></a>
          <span class="flr"><a title="网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>支持：<a title="网站建设" href="http://www.ynyes.com" target="_blank">天度网络</a></span>
</div>
</div>
</body>
