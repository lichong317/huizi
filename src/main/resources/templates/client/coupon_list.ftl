<!DOCTYPE html><head>
<meta charset="utf-8">

<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
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

<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
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
                alert("领取优惠券成功");
                window.location.reload();
            }
            else
            {
                alert(data.message);
            }
        }
    });
});

function showDialog(id)
{
        
    $("#couponId").val(id);
    
    $("#checkDialog").css("display", "block");
}

function hideDialog()
{
    $("#checkDialog").css("display", "none");
}
</script>
</head>

<style>
.logintop p { float:right; display:inline-block;_display:inline; padding:0 0 0 50px; height:80px; line-height:80px; margin-left:40px;}
.logintop p.p1 { background:url(../images/liebiao_44.png) no-repeat left center;}
.logintop p.p2 { background:url(../images/liebiao_41.png) no-repeat left center;}
.logintop p.p3 { background:url(../images/liebiao_39.png) no-repeat left center;}
.logingbg { width:100%; min-width:1200px; margin:0 auto; background:url(../images/login_bg.png) no-repeat center bottom; padding:30px 0;}
.loginbox { width:400px; background:#fff; margin:0 auto; padding:20px 50px;}
.loginbox p { margin:10px 0 5px;}
.loginbox .text { width:100%; height:35px; line-height:35px; border:1px solid #ddd;}
.loginbox .yzm01 { float:left; width:100px; height:37px; background:#0551a5; color:#fff; margin-left:10px;}
.loginbox .yzm02 { float:right; line-height:37px;}
.loginbox .sub { width:100%; border-radius:3px; background:#ff2727; color:#fff; line-height:35px; height:35px;}
.loginbox .sub:hover { background:#333;}
.loginfoot { width:100%; padding:100px 0 15px; text-align:center;} 
.loginfoot nav a { margin:0 20px;}
.loginfoot nav { padding:0 0 20px;}
.loginfoot p { padding-bottom:5px;}
.loginfoot p a { color:#555;}

</style>
<body>
<div id="checkDialog" class="mianfeilingqutanchu" style="display: none;position: fixed; top: 0px; left: 0px;">
                  <div class="mianfeilingqutanchu_dl">
                        <section class="loginbox">
                        <form id="form1" action="/coupon/request" method="post">
                          <input id="couponId" name="couponId" class="text" type="hidden" value="" datatype="n" nullmsg="优惠券已被领完"/>
                          <a class="fr" style="z-index:999999999; /* margin-top:50px; */ margin-left: 410px;position: absolute;" href="javascript:hideDialog();"><img src="/client/images/mymember/delete.png"></a>                                                   
                          <span class="Validform_checktip">请填写领取信息</span>
                          <p>请输入验证码</p>
                          <div class="clear"></div>
                          <input class="text fl" type="text" name="code" style="width:35%;" datatype="*4-4" nullmsg="请输入验证码" errormsg="验证码为4位字符"/>
                          <img src="/code" onclick="this.src = '/code?date='+Math.random();" id="yzm" height="37" style="padding-left:40px" title="点击更换另一张"/>
                          
                          <div class="clear h15"></div>
                          <p class="pb10">
                                <span class="absolute-r"><a href="/reg">免费注册</a> | <a href="/login">登录</a></span>
                          </p>
                          <div class="clear h40"></div>
                          <input type="submit" class="sub" value="免费领取" />
                          <div class="clear h20"></div>
                        </form>
                      </section>
                  </div>
</div>
  
<#include "/client/common_header.ftl" />                
<!--mymember-->
<div class="main">
<#if coupon_type_list??>
    <#list coupon_type_list as item>
    <div class="mianfeilingqu">
        <div class="mianfeilingqu_left">
            <img src="${item.picUri!''}" width="874" height="350" />
            <div class="clear"></div>
            <#assign couponCount=0>
            <#if ("coupon_" + item.id + "_list")?eval?? >                               
                   <#list ("coupon_" + item.id + "_list")?eval as coupon>                                                                 
                            <#assign couponCount=couponCount+coupon.leftNumber>
                   </#list>
            </#if>
            <div class="zongshushengyu">
            <p class="mt5">总数剩余：<span class="red">${couponCount!'0'}</span>张</p>
            </div>
            <div class="clear"></div>
            <div class="linquanniu">
            <#if ("coupon_" + item.id + "_list")?eval?? >                               
                   <#list ("coupon_" + item.id + "_list")?eval as coupon>                                                                 
                            <a href="javascript:showDialog(${coupon.id?c});">点击领取</a> </div>
                   </#list>
            </#if>
              
            </div>
            <div class="mianfeilingqu_right">
                <h3>领取用户</h3>
                <ul>
                    <ul>
                        <#if ("distributed_coupon_" + item.id + "_list")?eval?? >
                            <#list ("distributed_coupon_" + item.id + "_list")?eval as distributedCoupon>
                                <#if distributedCoupon_index < 10>
                                <li><span class="red">
                                    <#if distributedCoupon.mobile??>
                                        <#if distributedCoupon.mobile?length gt 8>
                                            ${distributedCoupon.mobile[0..6]?default("")}****
                                        </#if>
                                    </#if>
                                    </span>
                                    <span class="fr">
                                    <#if distributedCoupon.getTime??>
                                        ${distributedCoupon.getTime?string("yyyy.MM.dd")}
                                    </#if>
                                    </span>
                                </li>
                                </#if>
                            </#list>
                        </#if> 
                    </ul>
                </ul>
        
        </div>
    </div>
    </#list>
</#if>

</div>
<div class="clear35"></div>
<!--mymember END-->

<#include "/client/common_footer.ftl" />
</body>
</html>