<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />

<script>
function redEnvelopeGet(){
    var username = $("#username").val();
    var redenvelopeId = $("#redenvelopeId").val();
    $.ajax({
                type: "post",
                url: "/touch/user/redenvelope/get",
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

<body><!--红包 -->
<section class="redback">
    <div class="redbackWrap">
        <p class="RBheader">
            <img src="<#if user??>${user.headImageUri!''}</#if>" />
        </p>
        <input id="redenvelopeId" style="display:none" value="<#if tdRedEnvelope??>${tdRedEnvelope.id?c}</#if>">
        <input id="username" style="display:none" value="<#if user??>${user.username}</#if>">
        <!--领取 -->
        <#if tdRedEnvelope?? && !tdRedEnvelope.isGet>
                    <div class="RBno" id ="getRedenvelope">
                        <p class="RBtitle">惠资生活给您发了一个红包！</p>
                        <p class="RBinfo">恭喜发财，万事如意</p>            
                        <a class="RBopen" href="javascript:redEnvelopeGet()" title="拆红包"><span class="r5">拆红包</span><i class="r5"></i></a>
                    </div>
                    <div class="RBno" id ="getRedenvelopeFalse" style="display:none">
                        <p class="RBinfo">下手太慢，红包已被抢光了！</p>            
                        <a class="RBopen" href="/touch/user" title="返回个人中心"><span class="r5">返回个人中心</span><i class="r5"></i></a>
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
                        <a class="RBopen" href="/touch/user/redenvelope/list?statusId=2" title="返回"><span class="r5">返回</span><i class="r5"></i></a>
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
                            <a class="RBopen" href="/touch/user/redenvelope/list?statusId=2" title="返回"><span class="r5">返回</span><i class="r5"></i></a>
                        </div>
                    </#if>
                 </#if>
    </div>
</section>
<!--红包结束 -->
</body>
</html>
