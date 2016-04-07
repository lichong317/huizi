<!doctype html>
<html>
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

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    //处理用户名
    getElement();    
});


/**
 * 获取要隐藏用户名的元素
 * @author mdj
 */
function getElement(){
    var pElement = $(".userName").toArray();
    for(var i = 0;i < pElement.length;i++)
    {
       var originName = pElement[i].innerHTML;
       var name =  changeName(originName);
       pElement[i].innerText=name;
    }
}
/**
 * 隐藏用户名
 * @author mdj
 */
function changeName(p)
{
    var temp = p;
    if(temp.length == 11)
    {
        var changeStr = temp.substring(3, 7);
        temp = temp.replace(changeStr,"****");
    }
    else
    {
        var startStr = "";
        var strLength = temp.length;
        for (var i = 0; i < strLength - 4; i++)
        {
            startStr += "*";
        }
        var changeStr = temp.substring(2, strLength - 2)

        temp = temp.replace(changeStr, startStr);
    }
    return temp;
}



/***抽奖***/

function showAlert(index){
    $(".winbg"+index).css("display", "block");
}

var bRotate = false;

$(function(){
    var animatetemp = 0;
 
    var data1;
    $.ajax({
             type: "post",
             url: "/lottery/getPrizeType",
             data: { },
             dataType: "json",
             success: function (data) {
                 if (data.code == 0) {
                     data1 = data.prizeCategory;
                 } else {
                     alert("出错了！");
                 }
             }
     });
     
     $('#pointer').click(function (){
        if(bRotate)return;
        bRotate = !bRotate;
        $.ajax({
            type : 'post',
            url : '/lottery/minPoint',
            data :{ },
            dateType : "json",
            success :function(data)
            {
               
               if(data.code==1)
                {
                    //alert(data.msg);
                    showAlert(1);
                    bRotate = !bRotate;
                    return;
               }
               if(data.code==2)
                {
                    //alert(data.msg);
                    showAlert(2);
                    bRotate = !bRotate;
                    return;
               }               
               
               //更改抽奖次数
               var lotteryNumber = parseFloat($("#lotteryNumber").text());
               $("#lotteryNumber").text(lotteryNumber-1);
               
               var a = runzp(data1);                       
               
               awardCartoon(a.angle);
               
               if(a.angle == 9){
                    setTimeout("showAlert(3)",3500); 
               }
                             
               if(a.isOver == true){                    
                    setTimeout("showAlert(2)",3500);
               }else{
                  if(a.angle != 9){
                    $("#prizeTitle").text(a.prize);
                    $("#prizeInfo").text(a.message);
                    setTimeout("showAlert(4)",3500); 
                  }                      
               }                                                                                               
               setTimeout("changeState()",3500); 
                            
            }
        })

  
     });     
                    
     var rotateTimeOut = function (){
        $('#rotate').rotate({
            angle:0,
            animateTo:2160,
            duration:8000,
            callback:function (){
                alert('网络超时，请检查您的网络设置！');
            }
        });
    };
   
   
});

 var changeState = function (){
        bRotate = !bRotate;
    }


function randomnum(smin, smax) {// 获取2个值之间的随机数
    var Range = smax - smin;
    var Rand = Math.random();
    return (smin + Math.round(Rand * Range));
}
function rnd(n, m){
    return Math.floor(Math.random()*(m-n+1)+n)
}

function runzp(data) {
    var obj = data;
    var result = randomnum(1, 100);
    var line = 0;
    var temp = 0;
    var returnobj = "0";
    var index = 0;
    
    var angle = 9;
    var message = "";
    var myreturn = new Object;
    
    //alert("随机数"+result);
    for ( var i = 0; i < obj.length; i++) {
        var obj2 = obj[i];
        var c = parseFloat(obj2.probability);
        temp = temp + c;
        line = 100 - temp;
        if (c != 0) {
            if (result > line && result <= (line + c)) {
                index = i;
                // alert(i+"中奖"+line+"<result"+"<="+(line + c));
                if (null != obj2.leftNumber && obj2.leftNumber > 0){
                    returnobj = obj2;
                }else{
                    break;
                }
                                
                var username = $("#username").val();
                //alert(username);
                $.ajax({
                     type: "post",
                     url: "/lottery/getPrize",
                     data: {"username":username,"id":obj2.id },
                     dataType: "json",
                     success: function (data) {
                         if (data.code == 0) {
                            
                         } else {
                             //alert(data.msg);
                             isOver = true; 
                             myreturn.isOver = isOver;  
                         }
                     }
                });
                break;
            }
        }
    }
    
    if (returnobj != "0") {// 有奖
        if(returnobj.prizeType == 2){
            message = "我们会在尽快安排工作人员联系您！";
        }else{
            message = "奖品已发放到您的账户中，请注意查收!";
        }
        

        angle = index;

        myreturn.prize = returnobj.title;
        myreturn.isWin = true;
    } else {// 没有
        message = "再接再厉";
        angle = 9;
        
        myreturn.prize = "继续努力!";
        myreturn.isWin = false;
    }
    myreturn.angle = angle;
    myreturn.message = message;
    
    return myreturn;
}
</script>
</head>

<body class="awardout">
<header class="comhead">
  <h2>幸运抽奖</h2>
  <a href="/touch/user/point/list" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="/touch/" class="a1"><img src="/touch/images/home.png" /></a>
</header>
<div class="comheadbg"></div>

<div class="awardtit">
    <input type="hidden" id="username" value="<#if user??>${user.username!''}</#if>">
  可抽奖次数<b class="fs5 ml10 mr10" id ="lotteryNumber"><#if user?? && user.lotteryNumber??>${(5-user.lotteryNumber)}<#else>5</#if></b>次
  <a href="/touch/user/myprize/list">查看我的奖品</a>
</div>

<article class="awardbox" id="awardbox">
  <table>
    <tr>
        <#if prizeCategory??>
            <#list prizeCategory as item>
                <#if item_index < 3>
                    <td class="awardpart${item_index + 1} "><img src="${item.picUri!''}" /></td>
                </#if>
            </#list>
        </#if>
    </tr>
    <tr>

        <td class="awardpart10"><img src="/touch/images/award/award07.png" /></td>

        <td style="background:#ff8585;" rowspan="2"><a class="awardbtn" id ="pointer"><img src="/touch/images/award/award06.png" /></a></td><!--此处onClick="awardCartoon(9);" 便是调用抽奖效果的方法，其中括号里的参数是抽奖效果最后停留的奖品位置，参数为索引值，此处建议取0-9-->
        <#if prizeCategory?? && prizeCategory?size gt 3>
               <td class="awardpart4"><img src="${prizeCategory[3].picUri!''}" /></td>
        </#if>
    </tr>
    <tr>
        <#if prizeCategory?? && prizeCategory?size gt 8>
               <td class="awardpart9"><img src="${prizeCategory[8].picUri!''}" /></td>
        </#if>
        <#if prizeCategory?? && prizeCategory?size gt 4>
               <td class="awardpart5"><img src="${prizeCategory[4].picUri!''}" /></td>
        </#if>
    </tr>
    <tr>
        <#if prizeCategory?? && prizeCategory?size gt 7>          
              <td class="awardpart8"><img src="${prizeCategory[7].picUri!''}" /></td>
        </#if> 
        <#if prizeCategory?? && prizeCategory?size gt 6>          
              <td class="awardpart7"><img src="${prizeCategory[6].picUri!''}" /></td>
        </#if> 
        <#if prizeCategory?? && prizeCategory?size gt 5>          
              <td class="awardpart6"><img src="${prizeCategory[5].picUri!''}" /></td>
        </#if> 
    </tr>
  </table>
</article>

<div class="clear h04"></div>

<section class="finallybox center">
  <img src="/touch/images/award/re01.png" class="w100 block" />
    <#if luckydog_page??>
        <#list luckydog_page.content as item>
            <#if item_index < 10>
                <p><em class="userName">${item.username!''}</em><span style="width:100px; height:30px; overflow:hidden">
                                <#if item.prizeType == 0>
                                    <em>积分${item.prizePoints!''}个</em>
                                <#elseif item.prizeType == 1>
                                    <em>${item.couponTitle!''}</em>
                                <#elseif item.prizeType == 2>
                                    <em >${item.goodsTitle!''}</em>
                                </#if>     
                                </span>
                </p>
            </#if>
        </#list>
    </#if>
  <img src="/touch/images/award/re02.png" class="w100 block" />
</section>
<div class="clear h05"></div>
<p class="center"><img src="/touch/images/award/gz.png" class="w100" /></p>
<article class="lh4 w90 mga actcolor pt20">
         1、商城注册用户，每天登录抽奖页面，即可免费获得5次幸运抽奖机会，每次抽奖将消耗<#if site??>${site.lotteryPoints!''}</#if>积分，中奖名单在本页实时公布<br>
         2、抽中积分的用户，系统会即时发放到你的个人账户<br>
         3、抽中优惠券以及实物奖的用户，系统将以优惠券形式发放到你的个人账户<br>
         4、所有奖品不能折现、不能替换，图片仅供参考，请以实物为准<br>
         5、本次活动最终解释权归惠之店所有
</article>
<div class="clear h03"></div> 

<!--弹出层-->
<aside class="winbg1" style="display:none;position:absolute;left:0px;top:14%;width:100%;">
  <div class="promptbox">
    <img class="tit" src="/touch/images/award/tit03.png" />
    <p class="ta-c">今天的抽奖机会已经用完，明天再来吧！好礼天天等你拿</p>
    <a class="a1" href="#" onClick="$(this).parent().parent().fadeOut(200);">返回</a>
  </div>
</aside>

<aside class="winbg2" style="display:none;position:absolute;left:0px;top:14%;width:100%;">
  <div class="promptbox">
    <img class="tit" src="/touch/images/award/tit03.png" />
    <p class="ta-c">您的积分余额不足！</p>
    <a class="a1" href="#" onClick="$(this).parent().parent().fadeOut(200);">返回</a>
  </div>
</aside>

<aside class="winbg3" style="display:none;position:absolute;left:0px;top:14%;width:100%;">
  <div class="promptbox">
    <img class="tit" src="/touch/images/award/tit02.png" />
    <p class="ta-c">与大奖擦肩而过，感谢您的参与！<br/>再接再厉！</p>
    <a class="a1" href="#" onClick="$(this).parent().parent().fadeOut(200);">再来一次</a>
    <a class="a2" href="/touch">感觉不会再爱了，回首页逛逛</a>
  </div>
</aside>

<aside class="winbg4" style="display:none;position:absolute;left:0px;top:14%;width:100%;">
  <div class="promptbox">
    <img class="tit" src="/touch/images/award/tit01.png" />
    <h4 class="fs3 pa20 white w70 ta-c mga mb30" >获得<span id="prizeTitle">5元优惠券</span></h4>
    <h6 class="w90 mga fs25 mb20" id ="prizeInfo">奖品已发放到您的账户中，请注意查收</h6>
    <a class="a1" href="#" onClick="window.location.reload();">确定</a>
  </div>
</aside>

<aside class="winbg5" style="display:none;position:absolute;left:0px;top:14%;width:100%;">
  <div class="promptbox">
    <img class="tit" src="/touch/images/award/tit03.png" />
    <p class="ta-c">奖品已经抽完啦！</p>
    <a class="a1" href="#" onClick="$(this).parent().parent().fadeOut(200);">返回</a>
  </div>
</aside>
</body>
</html>
