<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />

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
    
    productImgShow("proshowimg","li","proshowmenu","sel",396,396);
    checkBoxShow("assort_menu","a","assort_sum","li","sel");
    topTitFloat("detail_tit",1250,"detail_tit_sel");
    
     //初始化表单验证
    $("#form1").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback:function(data){
            if(data.code == 0){
                alert("发送成功！");
                window.location.reload();
            }else{
                alert(data.msg);
            }
        }
    });
});

function showDialog()
{       
    $("#checkDialog").css("display", "block");
}

function hideDialog()
{
    $("#checkDialog").css("display", "none");
}
function sendAddress(){
    var id = <#if shop??>"${shop.id?c}"</#if>;
    $.ajax({
                type: "post",
                url: "/shop/sendAddress",
                data: { "id": id},
                dataType: "json",
                success: function (data) { 
                    if (data.code == 0) {
                       alert("发送成功！请注意查收");
                       $("#sendAddress").removeAttr("href");
                    } else {
                        alert(data.msg);
                    }
                }
            });
}

</script>
</head>

<body>
<#include "/client/common_header.ftl" />
<!-- header结束 -->


<style>
.logintop p { float:right; display:inline-block;_display:inline; padding:0 0 0 50px; height:80px; line-height:80px; margin-left:40px;}
.logintop p.p1 { background:url(../images/liebiao_44.png) no-repeat left center;}
.logintop p.p2 { background:url(../images/liebiao_41.png) no-repeat left center;}
.logintop p.p3 { background:url(../images/liebiao_39.png) no-repeat left center;}
.logingbg { width:100%; min-width:1200px; margin:0 auto; background:url(../images/login_bg.png) no-repeat center bottom; padding:30px 0;}
.loginbox { width:400px; background:#fff; margin:0 auto; padding:20px 50px;}
.loginbox p { margin:10px 0 5px;}
.loginbox textarea {width:100%;height:80px;text-align:left;}
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
<div id="checkDialog" class="mianfeilingqutanchu" style="display: none;position: fixed; top: 0px; left: 0px;">
    <div class="mianfeilingqutanchu_dl">
        <section class="loginbox">
            <a class="fr" style="z-index:999999999; /* margin-top:50px; */ margin-left: 410px;position: absolute;" href="javascript:hideDialog();"><img src="/client/images/20150407114113116_easyicon_net_71.8756476684.png" width="25" height="25"></a>
            <form id="form1" action="/shop/sendAddress" method="post">
                <input type="hidden" name="id" value="<#if shop??>${shop.id?c}</#if>">
                <span class="Validform_checktip">免费短信发送</span>               
                <p><b style="color: #FF0000;">*</b> 手机号码</p>
                <input class="text" name="mobile" value="" type="text" datatype="m"  nullmsg="请输入正确手机号"/>
                <p><b style="color: #FF0000;">*</b> 短信内容</p>
                <textarea name="content" disabled="disablied" class="input" datatype="*0-255" sucmsg=" "><#if shop??> 您查询的${shop.title!''}
 地址：${shop.address!''}
 电话：${shop.serviceTele!''}
 手机导航访问：http://www.huizhidian.com/touch/shop/list</#if></textarea>

                <p><b style="color: #FF0000;">*</b> 验证码</p>
                <input class="text fl" name="code" type="text" style="width:35%;" datatype="s4-4" errormsg="请填写4位字符"/>
                <img src="/code" onclick="this.src = '/code?date='+Math.random();" id="yzm" height="37" style="padding-left: 55px;"/>
                
                         
                <div class="clear h40"></div>
                <input type="submit" class="sub" value="确认发送" />
                <div class="clear h20"></div>
            </form>
        </section>
    </div>
</div>

<div class="clear h20"></div>
<div class="main">
  <div class="dituxiangxi">
  <div class="pro_box">
    <section class="proinfo_left">
      <menu id="proshowimg">
        <#if shop?? && shop.showPictures??>
            <#list shop.showPictures?split(",") as uri>
                <#if uri != "" >
                       <li><img src="${uri!""}" /></li>
                </#if>
            </#list>
        </#if>       
      </menu>
      <div class="clear h15"></div>
      <menu id="proshowmenu"></menu>
      <div class="clear"></div>

    </section><!--proinfo_left END-->
    
    <section class="proinfo_right">
    <#if shop??>
      <h3>${shop.title!''}</h3>
      <div class="pro_price">
        
        <p class="p1">
         ${shop.address!''}
        </p>
         <p class="p1">
         所在区域：${shop.city!''}${shop.disctrict!''}
        </p>
         <p class="p1">
        营业时间：${shop.openTimeSpan!''}
        </p>
         <p class="p1">
        门店客服：${shop.serviceTele!''}
        </p>
         <p class="p1">
        投诉电话：${shop.complainTele!''}
        </p>
      </div><!--pro_price END-->
      <table class="pro_choose">
        
        <tr>
          <td colspan="2">
            <!--<input type="submit" class="sub" value="立即购买" />-->
            <a id="sendAddress" href="javascript:showDialog();" class="sub" style="text-align:center;">地址发送到手机</a>
            <div class="clear"></div>
          </td>
        </tr>
      </table>
    </#if>  
    </section><!--proinfo_right END-->
    <div class="clear h20"></div>
  </div>
  <div class="clear"></div>
  
  </div>
      <div class="clear h20"></div>
</div>
<div class="clear h40"></div>

<#include "/client/common_footer.ftl" />
<!--底部结束-->

</body>
</html>
