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

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />

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
        
});

function redEnvelopeGet(){
    var username = $("#username").val();
    var redenvelopeId = $("#redenvelopeId").val();
    $.ajax({
                type: "post",
                url: "/user/redenvelope/get",
                data: { "username": username, "redenvelopeId": redenvelopeId },
                dataType: "json",
                success: function (data) {
                    if (data.code == 0) {
                        $("#getRedenvelope").css("display", "none");
                        if(data.isGetPrize == true){
                            $("#getRedenvelopeTrue").css("display", "block");
                        }else{
                            $("#getRedenvelopeFalse").css("display", "block");
                        }                                               
                    } else {
                        alert(data.message);
                    }
                }
     });
}

</script>
</head>
<boby>
    <!--最顶部-->
    <#include "/client/common_header.ftl" />
    <!--liebiaoye-->
    <div class="main">
        <!--红包 -->
        <input id="redenvelopeId" style="display:none" value="<#if tdRedEnvelope??>${tdRedEnvelope.id?c}</#if>">
        <input id="username" style="display:none" value="<#if user??>${user.username}</#if>">
        <section class="redback">
            <div class="redbackWrap">
                <p class="RBheader">
                    <img src="<#if user??>${user.headImageUri!''}</#if>" width="83" height="83"/>
                </p>
                <!--领取 -->
                <#if tdRedEnvelope?? && !tdRedEnvelope.isGet>
                    <div class="RBno" id ="getRedenvelope">
                        <p class="RBtitle">惠之店给您发了一个红包！</p>
                        <p class="RBinfo">恭喜发财，万事如意</p>            
                        <a class="RBopen" href="javascript:redEnvelopeGet()" title="拆红包"><span class="r5">拆红包</span><i class="r5"></i></a>
                    </div>
                    <div class="RBno" id ="getRedenvelopeFalse" style="display:none">
                        <p class="RBinfo">下手太慢，红包已被抢光了！</p>            
                        <a class="RBopen" href="/user" title="返回个人中心"><span class="r5">返回个人中心</span><i class="r5"></i></a>
                    </div>
                    <div class="RBno" id ="getRedenvelopeTrue" style="display:none">
                        <p class="RBinfo">成功领取<span>${tdRedEnvelope.typeTitle!''}</span>红包!</p>
                        <#if tdRedEnvelope.redEnvelopeType == 0>
                             <p class="RBtitle">奖励积分${tdRedEnvelope.prizePoints!''}！</p>
                        <#elseif tdRedEnvelope.redEnvelopeType == 1>
                             <p class="RBtitle">奖励优惠券${tdRedEnvelope.couponTitle!''}！</p>
                        <#elseif tdRedEnvelope.redEnvelopeType == 2>
                             <p class="RBtitle">奖励商品${tdRedEnvelope.goodsTitle!''}！</p>
                        </#if>            
                        <a class="RBopen" href="/user/redenvelope/list?statusId=2" title="返回"><span class="r5">返回</span><i class="r5"></i></a>
                    </div>
                 <#else>
                    <#if tdRedEnvelope?? && !tdRedEnvelope.isGetPrize && tdRedEnvelope.isGet>
                        <div class="RBno">
                            <p class="RBinfo">下手太慢，红包已被抢光了！</p>            
                            <a class="RBopen" href="/user" title="返回"><span class="r5">返回</span><i class="r5"></i></a>
                        </div>
                    <#else>
                        <div class="RBno" >
                            <p class="RBinfo">成功领取<span>${tdRedEnvelope.typeTitle!''}</span>红包!</p>
                            <#if tdRedEnvelope.redEnvelopeType == 0>
                                 <p class="RBtitle">奖励积分${tdRedEnvelope.prizePoints!''}！</p>
                            <#elseif tdRedEnvelope.redEnvelopeType == 1>
                                 <p class="RBtitle">奖励优惠券${tdRedEnvelope.couponTitle!''}！</p>
                            <#elseif tdRedEnvelope.redEnvelopeType == 2>
                                 <p class="RBtitle">奖励商品${tdRedEnvelope.goodsTitle!''}！</p>
                            </#if>            
                            <a class="RBopen" href="/user/redenvelope/list?statusId=2" title="返回"><span class="r5">返回</span><i class="r5"></i></a>
                        </div>
                    </#if>
                 </#if>
            </div>
        </section>
        <!--红包结束 -->
   </div>
  <div class="clear h40"></div>

<#include "/client/common_footer.ftl" />
</boby>
</html>