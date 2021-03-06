<!doctype html>
<html >
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    $("#form1").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
               //alert("修改成功");
                //window.location.reload();
                ct.alert({
                    text: "修改成功",
                    type: "alert"
                });
                window.location.href="/touch/user"
            }
            else
            {
                ct.alert({
                    text: data.msg,
                    type: "alert"
                });  
                window.location.href="/touch/login";
            }
        }
    });
    
     $("#btnSubmit").click(function(){
        var realName = $("#realName").val();
        var sex = $("input[name='sex']:checked").val();
        var email = $("#email").val();
        var mobile = $("#mobile").val();
        var bankTitle = $("#bankTitle").val();
        var bankCardCode = $("#bankCardCode").val(); 
          
        if (undefined == email || "" == email)
        {
            //alert("省市不能为空");
            ct.alert({
                   text: "邮箱不能为空",
                   type: "alert"
            });
            $("#email").focus();
            return;
        }
        
        var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        
        if (!filter.test(email)) {
            ct.alert({
                      text: "请输入正确的邮箱",
                      type: "alert"
             });
             $("#email").focus();
             return;
        }
        
        if (undefined == mobile || "" == mobile)
        {        
            ct.alert({
                   text: "联系电话不能为空",
                   type: "alert"
            });           
                        
            $("#mobile").focus();
            return;
        }
        
        var re = /^1\d{10}$/;
        
        if (!re.test(mobile)) {
             ct.alert({
                      text: "请输入正确的手机号",
                      type: "alert"
             });
             $("#mobile").focus();
             return;
        }
               
        
        $.ajax({
            type:"post",
            url:"/touch/user/info",
            data:{
                "realName":realName,
                "sex": sex,
                "email": email, 
                "mobile": mobile,
                "bankTitle": bankTitle,
                "bankCardCode": bankCardCode,
            },
            
            success:function(res) {
                if (0 == res.code)
                {                  
                    ct.alert({
                           text: "修改成功",
                           type: "alert"
                    });
                }
                else
                {
                    ct.alert({
                           text: res.msg,
                           type: "alert"
                    });
                }
            }
        });
    });
});

function changeBank(){
	$("#bankCardCode").val($("#bankCardCodetext").val());
}

</script>
</head>

<style>
.Validform_checktip{line-height:20px; height:20px; overflow:hidden; color:red; font-size:12px; margin-left:30%}


#Validform_msg{color:#7d8289; font: 12px/1.5 tahoma, arial, \5b8b\4f53, sans-serif; width:280px; -webkit-box-shadow:2px 2px 3px #aaa; -moz-box-shadow:2px 2px 3px #aaa; background:#fff; position:absolute; top:0px; right:50px; z-index:99999; display:none;filter: progid:DXImageTransform.Microsoft.Shadow(Strength=3, Direction=135, Color='#999999'); box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);}
#Validform_msg .iframe{ position:absolute; left:0px; top:-1px; z-index:-1; }
#Validform_msg .Validform_title{ position:relative; line-height:35px; height:35px; text-align:left; font-weight:bold; padding:0 10px; color:#fff; background:#33B5E5; }
#Validform_msg a.Validform_close:link,#Validform_msg a.Validform_close:visited{ line-height:30px; position:absolute; right:10px; top:0px; color:#fff; text-decoration:none; }
#Validform_msg a.Validform_close:hover{color:#ccc;}
#Validform_msg .Validform_info{padding:10px;border:1px solid #bbb; border-top:none; text-align:left;}   
</style>

<body>

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>个人信息</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<#--<form id="form1" action="/touch/user/info" method="post" > -->
    <input id="realName" name="realName" type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt40" placeholder="真实姓名" value="${user.realName!''}"/>
    <div class="sexchoose w80 mga mt20 h07 lh7">
      <span class="fl">性别</span>
          <#--<a class="sel" href="javascript:void(0);" onClick="$(this).toggleClass('sel');">男</a>
          <a href="javascript:void(0);" onClick="$(this).toggleClass('sel');">女</a> -->
          <input type="radio" name="sex" class="ml20" value="男" <#if user.sex?? && user.sex=="男">checked="checked" </#if> /><span>男</span>
          <input type="radio" name="sex" class="ml20" value="女" <#if user.sex?? && user.sex=="女">checked="checked" </#if> /><span>女</span>
      <div class="clear"></div>
    </div>
    <input type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="电子邮箱" id="email" name="email" value="${user.email!''}"/>
    <input type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="手机号码" id="mobile" name="mobile" value="${user.mobile!''}"/>
    
    <input type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="默认开户行" id="bankTitle" name="bankTitle" value="${user.bankTitle!''}"/>
    <input type="text" class="text h07 lh7 fabg border w80 mga block ti1 mt20" placeholder="默认银行卡号" id="bankCardCodetext" onchange="changeBank();" value="<#if user?? ><#if  user.bankCardCode?? && user.bankCardCode?length gt 18>${user.bankCardCode[0..4]?default("")}****${user.bankCardCode[16..18]?default("")}<#elseif user.bankCardCode?? && user.bankCardCode?length gt 4>${user.bankCardCode[0..4]?default("")}****</#if></#if>"/>    
    <input type="hidden" id="bankCardCode" name="bankCardCode" value="<#if user??>${user.bankCardCode!''}</#if>">
    <div class="clear h08"></div>
    <p class="w80 mga c9 mb10"><span class="absolute-r">${user.registerTime!''}</span>注册时间</p>
    <p class="w80 mga c9 mb10"><span class="absolute-r">${user.lastLoginTime!''}</span>最后登录时间</p>
    
    <#--<div class="clear h130"></div> -->
    <div style="height:0.3rem"></div>
    <footer class="addressfoot">
      <input id="btnSubmit" type="submit" value="确认" class="sub" />
    </footer>
<#--</form>  -->
</body>
</html>
