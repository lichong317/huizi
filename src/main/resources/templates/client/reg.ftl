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

<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/mymember.js"></script>

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
	
	//初始化表单验证
    $("#form1").Validform({
        //btnSubmit:"#regbut"
        tiptype: 3
        
    });
    
    //初始化表单验证
    $("#form2").Validform({
        //btnSubmit:"#regbut2"
        tiptype: 3
        
    });
    
     $("#smsCodeBtn").bind("click", function() {  
        
        var mob = $('#mobileNumber').val();
        
        var re = /^1\d{10}$/;
        
        if (!re.test(mob)) {
            alert("请输入正确的手机号");
            return;
        }
        
        $("#smsCodeBtn").attr("disabled","disabled"); 
        
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
                    $("#smsCodeBtn").removeAttr("disabled");
                }
            },  
            error : function(XMLHttpRequest, textStatus,  
                    errorThrown) {  
                alert("error");
            }  
  
        });
        
      }); 
});

function enableBtn()
{  
    $("#smsCodeBtn").removeAttr("disabled");   
} 

function tip() 
{  
    seed--;  
    if (seed < 1) 
    {  
        enableBtn();  
        seed = 60;  
        $("#smsCodeBtn").val('点击获取短信验证码');  
        var t2 = clearInterval(t1);  
    } else {  
        $("#smsCodeBtn").val(seed + "秒后重新获取");  
    }  
} 
</script>
</head>

<style>
.thickbox {
    position: absolute;
    z-index: 10000002;
    overflow: hidden;
    padding: 0;
    border: 4px solid rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
}
.thicktitle {
    height: 27px;
    padding: 0 10px;
    border: solid #C4C4C4;
    border-width: 1px 1px 0;
    background: #F3F3F3;
    line-height: 27px;
    font-family: arial, "\5b8b\4f53";
    font-size: 14px;
    font-weight: bold;
    color: #333;
}
.thickcon {
    overflow: auto;
    background: #fff;
    border: solid #C4C4C4;
    border-width: 1px;
    padding: 10px;
}
.regist-2013 .btnt .btn-img {
    width: 322px;
    height: 34px;
    line-heiht: 34px;
    background: #e4393c;
    color: #FFF;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
    font-family: "微软雅黑";
    font-size: 16px;
    font-weight: 800;
}
.regist-2013 .btnt {
    width: 322px;
    margin: 20px auto 0;
}
.thickclose:link, .thickclose:visited {
    display: block;
    position: absolute;
    z-index: 100000;
    top: 7px;
    right: 12px;
    overflow: hidden;
    width: 15px;
    height: 15px;
    background: url(/client/images/bg_thickbox.gif) no-repeat 0 -18px;
    font-size: 0;
    line-height: 100px;
}
#protocol-con {
    height: 356px;
    overflow: auto;
    padding: 10px 20px 0 10px;
}
.btn-img {
    cursor: pointer;
    overflow: hidden;
    margin: 0;
    padding: 0;
    border: 0;
    text-align: center;
}
.thickframe {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10000000;
    width: 100%;
    height: 100%;
    background: #000;
    border: 0;
    filter: alpha(opacity = 0);
    opacity: 0;
}
.thickdiv {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10000001;
    width: 100%;
    height: 100%;
    background: #000;
    border: 0;
    filter: alpha(opacity = 15);
    opacity: .15;
}
</style>

<script>
                       // 弹出窗口
function checkwindowshow()
{
    
    $("#tanchuang").css("display", "block");
    $("#tanchuangbackgroud").addClass("thickdiv"); 
    
    //$('html,body').animate({scrollTop:0},500);
}

// 窗口隐藏
function checkwindowhide()
{

    $("#tanchuang").css("display", "none");
    $("#tanchuangbackgroud").removeClass("thickdiv"); 
    
}



</script>

<iframe class="thickframe" id="" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" style="display:none"></iframe>
<div  id="tanchuangbackgroud"></div>
<div class="thickbox" id="tanchuang" style="width: 924px; height: 500px; left: 485.5px; top: 88px; display:none">
    <div class="thicktitle" id="" style="width:922"><span>惠资生活注册协议</span></div>
    <div class="thickcon" id="" style="width: 922px; height: 450px; padding-left: 0px; padding-right: 0px; border-left-width: 1px; border-right-width: 1px;">
        <div class=" regist-2013">
            <div class="regist-bor">
                <div class="mc">
                    <div id="protocol-con">
                        <#if site??>${site.registerNego!''}</#if>
                    </div>
                    <div class="btnt">
                        <input class="btn-img" type="submit" value="同意并继续" onclick="checkwindowhide();"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a href="javascript:checkwindowhide();" id="closeBox" class="thickclose">×</a></div>

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
                    <li class="xz">快速注册</li>
                    <li class="">账号注册</li>
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
            <div class="regtip right">已有惠资生活网上商城账号？现在就<a href="/login.aspx">登录</a></div>
            
            <div class="xxknr" id="xxknr">
                <form id = "form1" method="post" action="/reg">
                        <span style="color: #F00"><#if errCode??>
                        <#if errCode==1>
                            验证码错误
                        <#elseif errCode==4>
                            短信验证码错误
                        </#if>
                    </#if></span>
                    <input name="shareId" type="hidden" value="${share_id!''}">
                <div class="reg tableLoginreg" style="display: block;">
                    <dl>
                        <dt><i>*</i>手机号码</dt>
                        <dd>
                            <input type="text" name="mobile" id="usermobile" datatype="m" ajaxurl="/reg/check/mobile" value="">
                            <span class="Validform_checktip">手机号码非常重要，找回密码及购物都会用到</span>
                        </dd>
                    </dl>
                     <dl id="codedl">
                        <dt><i>*</i>验证码</dt>
                        <dd>
                            <input type="text"  id="yzmcode" style="width: 120px;" ><img id="vCodeImg" src="/ImgCode.aspx?t=64.54859382938594" width="80" height="30" style="margin: 0 10px; vertical-align: middle;" onclick=" this.src = '/ImgCode.aspx?t=' + Math.random() * 100 "><a>看不清楚？换一张</a></dd>
                    </dl>
                    <dl>
                        <dt><i>*</i>短信验证码</dt>
                        <dd>
                            <input type="text" id="phonecode" name="smscode" style="width: 120px;" datatype="s4-4" errormsg="请填写4位字符"><a class="btn" id="getCode" href="">
                                <span id="dyMobileButton">获取短信验证码</span></a>
                            </dd>
                    </dl>


                    <dl>
                        <dt></dt>
                        <dd>
                            <input name="" id="mmprovision" type="checkbox" datatype="*" nullmsg="请阅读协议！" checked="checked" style="margin-right: 5px; vertical-align: middle;">
                            <label for="mmprovision" style="color: #999;">我已认真阅读并同意<a href="javascript:checkwindowshow();" class="showyhzt" style="color: #39f; margin: 0 5px;">《惠资生活用户协议》</a></label></dd>
                    </dl>
                    <dl>
                        <dt></dt>
                        <dd>
                            <button  id="regbut" type="submit">提交注册</button></dd>
                    </dl>
                </div>
                </form>
                
                <form id = "form2" method="post" action="/reg">
                        <span style="color: #F00"><#if errCode??>
                        <#if errCode==3>
                            短信验证码错误
                        </#if>
                    </#if></span>
                    <input name="shareId" type="hidden" value="${share_id!''}">
                    <div class="reg tableLoginreg" style="display: none;">
                        <dl>
                            <dt><i>*</i>用户名</dt>
                            <dd>
                                <input type="text" name="username" autofocus="autofocus" id="userUID" datatype="s6-20" ajaxurl="/reg/check/username" value="" >                       
                                <span class="Validform_checktip">6-20位字母、数字或汉字，请不要输入特殊字符！</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt><i>*</i>密码</dt>
                            <dd>
                                <input type="password" id="userpwd3" name="password" datatype="s6-20">
                                <span class="Validform_checktip">6个字符以上的字母或数字</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt><i>*</i>重复密码</dt>
                            <dd>
                                <input type="password" id="userpwd4" datatype="*" recheck="password">
                                <span class="Validform_checktip">请重复输入密码确认不会输错</span>
                            </dd>
                        </dl>
    
                        <dl>
                            <dt><i>*</i>手机号码</dt>
                            <dd>
                                <input type="text" name="mobile" id="usermobile2" datatype="m" ajaxurl="/reg/check/mobile" value="">
                                <span class="Validform_checktip">手机号码非常重要，找回密码及购物都会用到</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>邮箱地址</dt>
                            <dd>
                                <input type="text" id="usermail" name="email">
                                <span class="Validform_checktip">请填写邮箱，用于找回密码</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>验证码</dt>
                            <dd>
                                <input type="text" id="yzmcode2" name="code" style="width: 120px;" datatype="s4-4" errormsg="请填写4位字符"><img id="vCodeImg2" src="/code" width="80" height="30" style="margin: 0 10px; vertical-align: middle;" onclick=" this.src = 'this.src = '/code?date='+Math.random();"><a href="javascript:void(0)" onclick=" document.getElementById('vCodeImg2').src = '/code?date='+Math.random() * 100 ">看不清楚？换一张</a></dd>
                        </dl>
                        <dl>
                            <dt></dt>
                            <dd>
                                <input name="" id="mmprovision2"  datatype="*" nullmsg="请阅读协议！" type="checkbox" checked="checked" style="margin-right: 5px; vertical-align: middle;">
                                <label for="mmprovision" style="color: #999;">我已认真阅读并同意<a href="javascript:checkwindowshow();" class="showyhzt" style="color: #39f; margin: 0 5px;">《惠资生活用户协议》</a></label></dd>
                        </dl>
                        <dl>
                            <dt></dt>
                            <dd>
                                <button id="regbut2" type="submit">提交注册</button></dd>
                        </dl>
                    </div>
                </form>
            </div>
        </div>			
	</div>
<!--</div> -->
   
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
    <#if site??>${site.copyright!''}</#if><br>
    <a style="color:#222222" href="#"><#if site??>${site.icpNumber!''}</#if></a>
    <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>

</div>
    </div>
</body>
</html>