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


<#--<script type="text/javascript" src="/client/js/jQueryRotate.2.2cj.js"></script> -->
<script type="text/javascript" src="/client/js/awardRotate.js"></script>
<script type="text/javascript" src="/client/js/script_cj.js"></script>
<script type="text/javascript" src="/client/js/jquery.easing.min.js"></script>
<script type="text/javascript" src="/client/js/jquery.easing.js"></script>
<script type="text/javascript" src="/client/js/jquery.easing.compatibility.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
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
    
    //处理用户名
    getElement();
        
});

function signin(){
    
    var username = $("#username").text();
     $.ajax({
            type: "post",
            url: "/lottery/signin",
            data: { "username": username },
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                   window.location.reload();
                } else {
                    alert(data.msg);
                }
            }
    });
}


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

//抽奖效果
var _awardbool = true;
function awardCartoon(_endnum){
    var _box = $("#awardbox");
    var _arr = new Array();
    var _nowbg = "awardnow";
    var _oldbg = "oldbg";
    
    if(_awardbool){
    _awardbool = false;
    for(var i=1;i<=10;i++){
        var _one = _box.find(".awardpart"+i);		
        _one.removeClass(_nowbg);
        _one.addClass(_oldbg);
        _arr.push(_one);    
    }
    
    var _index = 0;
    _arr[_index].removeClass(_oldbg);
    _arr[_index].addClass(_nowbg);
    
    var _max = _arr.length * 5 + _endnum;
    var _circle = 0;
    var _nextgo = function(){
        _arr[_index].removeClass(_nowbg);
        _arr[_index].addClass(_oldbg);
        
        _index ++;
        if(_index >= _arr.length ){ _index = 0; }
        _arr[_index].removeClass(_oldbg);
        _arr[_index].addClass(_nowbg);
        
        //判断停留
        _circle++;
        if(_circle >= _max){
            clearInterval(_cartoon);
            _awardbool = true;
            }
    };
    
    var _cartoon = setInterval(_nextgo,40);
    }//END if   
}

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
                                
                var username = $("#username").text();
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

<style>
.awardnow {background:#d44a4a;}
.oldbg {background:#fff;}
</style>

<boby>
    <!--最顶部-->
    <#include "/client/common_header.ftl" />
    
<div class="clear h20"></div>

    <!--liebiaoye-->
    <div class="container">
   <section class="firstScreen">
    <div class="inner">
      <div class="firstScreen_left">
      <#if user??>
        <div class="c_info"> <img class="e_head" src="${user.headImageUri!''}" width="66" height="66" alt="头像">
          <h4><b id="username">${user.username!''}</b></h4>
          <span> <a href="#" target="_blank"> <b>${user.userLevelTitle!''}</b> </a> </span> </div>
        <div class="c_grow"> <span>
         <b>成长状态</b> 
         <a href="/user" target="_blank">查看详细&gt;&gt;</a> 
         <#if tdUserLevelnext??>
           </span> <i><em class="J_range" data-max="300" data-val="112" style="width: <#if tdUserLevelnext.requiredConsumption?? && user.totalSpendCash??>${user.totalSpendCash/tdUserLevelnext.requiredConsumption}</#if>%;"></em></i>         
           <#--><p>还差<em><#if tdUserLevelnext.requiredConsumption?? && user.totalSpendCash??>${tdUserLevelnext.requiredConsumption - user.totalSpendCash}</#if></em>成长值升级为<em>${tdUserLevelnext.title!''}</em>，升级后，每天可领取<em>积分${tdUserLevelnext.signinPoints!''}个</em>。</p>-->
           <p>还差<em>99</em>成长值升级为<em>${tdUserLevelnext.title!''}</em>，升级后，每天可领取<em>积分${tdUserLevelnext.signinPoints!'1'}个</em>。</p>
         <#else>
            </span> <i><em class="J_range" data-max="300" data-val="112" style="width: 100%;"></em></i>  
         </#if>
        </div>
        <div class="c_aidou"> 
             <span> <b>积分：</b> <em>${user.totalPoints!'0'}</em> </span>
             <#if user.isSignin?? && user.isSignin>
                <a class="e_receive J_receive S_gray" href="javascript:;">今日已签到</a>
             <#else>
                <a class="e_receive J_receive S_red" href="javascript:signin();">马上签到</a>
             </#if>
        </div>
      </#if>
        <div class="c_getAidou J_getAidou">
          <div class="g_btns"> <a href="#" target="_blank">签到赚积分</a> <a href="#" target="_blank">查看积分规则</a> </div>
          <#--<div class="l_mobile"> <a href="javascript:;"> <span class="g_text"> <b>手机每天也可以签到领取积分</b> <i></i> </span> <span class="g_code"> <img src="/client/images/erweima.jpg" alt="" width="150" height="150"> <em>扫一扫手机签到更方便</em> </span> </a> </div>-->
          <div class="l_mobile"> <a href="javascript:;"> <span class="g_text"> <b>赶快参与抽奖吧>></i> </span></a> </div>
        </div>
      </div>
      
      <div class="firstScreen_center">
        <div class="u_aidouCarousel J_carousel">
          <div class="u_screen J_screen">
            <ol class="u_film J_film" style="width: 100000px;">
              <li class="u_film_item"> <a href="#" target="_blank"><img src="/client/images/ee.jpg" alt="" width="730" height="277"></a> </li>
            </ol>
          </div>
          <div class="u_page J_page" style="display: none;"> <a href="javascript:;" class="S_current"></a> </div>
        </div>
        <nav class="g_moudleNav"> <a class="s_1 J_playLottery" href="javascript:;"></a> <a class="s_2" href="#" target="_blank"></a> <a class="s_3 J_playPuzzle" href="javascript:;"></a> </nav>
      </div>
    </div>
  </section>
  
  <section class="u_lottery J_lotteryArea">
    <div class="inner">
      <h2 class="t_h2"><em>抽奖专区</em></h2>
      <div class="u_lottery_left" id="awardbox">
        <div class="g_about"> <a class="e_begin J_beginLottery" href="javascript:;"  id ="pointer">抽&nbsp;奖</a> <span>可抽奖次数<em class="J_lotteryNum" id ="lotteryNumber"><#if user??>${(5-user.lotteryNumber!'0')}</#if></em>次</span> <a class="e_check J_checkPrize" href="javascript:;">查看我的奖品&gt;&gt;</a> </div>
        <ol class="c_prizes J_prizes">
            <#if prizeCategory??>
                <#list prizeCategory as item>
                    <li class="awardpart${item_index + 1} s_${item_index + 1} oldbg"  data-name="${item.title!''}"><img src="${item.picUri!''}" alt="${item.title!''}"></li>
                </#list>
            </#if> 
            <li class="s_10 " data-name="感谢参与"><img src="/client/images/7c.jpg" alt="感谢参与"></li>    
        </ol>
        <div class="b_lotteryTips J_lotteryTips S_winning winbg1" style="display: none;"> <a class="t_close s_tips J_closeTips" href="javascript:;"></a>
          <div class="g_tips">
            <h3 class="J_winPrize">今天的抽奖机会已经用完，明天再来吧！好礼天天等你拿</h3>
            <h2>很遗憾</h2>
            <p class="J_failTips">还差一点点就抽到了，继续加油哦~</p>
          </div>
          <div class="g_btns"> <a class="J_continueLottery" href="javascript:;" onClick="window.location.reload();">返回&gt;&gt;</a> <a class="J_checkPrize" href="javascript:;">我的奖品&gt;&gt;</a> </div>
        </div>
        <div class="b_lotteryTips J_lotteryTips S_winning winbg2" style="display: none;"> <a class="t_close s_tips J_closeTips" href="javascript:;"></a>
          <div class="g_tips">
            <h3 class="J_winPrize">您的积分余额不足！</h3>
            <h2>很遗憾</h2>
            <p class="J_failTips">还差一点点就抽到了，继续加油哦~</p>
          </div>
          <div class="g_btns"> <a class="J_continueLottery" href="javascript:;" onClick="window.location.reload();">返回&gt;&gt;</a> <a class="J_checkPrize" href="javascript:;">我的奖品&gt;&gt;</a> </div>
        </div>
        <div class="b_lotteryTips J_lotteryTips S_winning winbg3" style="display: none;"> <a class="t_close s_tips J_closeTips" href="javascript:;"></a>
          <div class="g_tips">
            <h3 class="J_winPrize">与大奖擦肩而过，感谢您的参与！</h3>
            <h2>很遗憾</h2>
            <p class="J_failTips">还差一点点就抽到了，继续加油哦~</p>
          </div>
          <div class="g_btns"> <a class="J_continueLottery" href="javascript:;" onClick="window.location.reload();">继续抽奖&gt;&gt;</a> <a class="J_checkPrize" href="javascript:;">我的奖品&gt;&gt;</a> </div>
        </div>
        <div class="b_lotteryTips J_lotteryTips S_winning winbg4" style="display: none;"> <a class="t_close s_tips J_closeTips" href="javascript:;"></a>
          <div class="g_tips">
            <h3 class="J_winPrize" id="prizeTitle">积分50个</h3>
            <h2>很遗憾</h2>
            <p class="J_failTips">还差一点点就抽到了，继续加油哦~</p>
          </div>
          <div class="g_btns"> <a class="J_continueLottery" href="javascript:;" onClick="window.location.reload();">继续抽奖&gt;&gt;</a> <a class="J_checkPrize" href="javascript:;">我的奖品&gt;&gt;</a> </div>
        </div>
       <#-- <div class="b_myPrizes J_myPrizes"> <a class="t_close s_prizes J_closeMyPrizes" href="javascript:;"></a>
          <h4>我的奖品</h4>
          <ol class="J_prizeList">
          </ol>
          <div class="pagination J_pagination"> <a class="J_first" href="javascript:;" data-id="1">首页</a> <a class="J_prev" href="javascript:;" data-id="1">上页</a> <a class="J_page" href="javascript:;" data-id="1">1</a> <a class="J_next" href="javascript:;" data-id="1">下页</a> <a class="J_last" href="javascript:;" data-id="1">尾页</a> </div>
        </div>  -->
      </div>
      <div class="u_lottery_right">
        <header>
          <h3>分享给朋友：</h3>
          <!-- JiaThis Button BEGIN -->
          <div class="bshare-custom icon-medium-plus mt15 mb10"><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
          <!-- JiaThis Button END --> 
        </header>
        <div class="c_lucky">
          <h3><em>幸运用户</em></h3>
          <ol class="J_luckyUser">
            <#if luckydog_page??>
              <#list luckydog_page.content as item>
                   <#if item_index < 10>
                        <li style="display: list-item;">
                             <b>${item.username!''}</b> 
                             <span>抽中了：
                                <#if item.prizeType == 0>
                                    <em>${item.typeTitle!''}积分${item.prizePoints!''}个</em>
                                <#elseif item.prizeType == 1>
                                    <em>${item.typeTitle!''}${item.couponTitle!''}</em>
                                <#elseif item.prizeType == 2>
                                    <em>${item.typeTitle!''}${item.goodsTitle!''}</em>
                                </#if>                                
                             </span> 
                        </li>
                   </#if>
              </#list>
          </#if>     
          </ol>
        </div>
      </div>
    </div>
  </section>
  <#--
  <section class="u_weekPrize">
    <div class="inner">
      <h2 class="t_h2 s_yellow"><em>本期大奖</em></h2>
          <div class="c_goods s_fl"> <a class="e_img" href="#" target="_blank"><img src="/client/images/hzd_61.png" alt="" width="214" height="214"></a>
            <h3><a href="#" target="_blank">苹果iPhone 6 </a></h3>
            <span>价值：<em>￥5200.00</em></span> <a class="e_check" href="#" target="_blank">查看详情</a> 
          </div>
          <div class="c_goods s_fl"> <a class="e_img" href="#" target="_blank"><img src="/client/images/hzd_61.png" alt="" width="214" height="214"></a>
            <h3><a href="#" target="_blank">苹果iPhone 6 </a></h3>
            <span>价值：<em>￥5200.00</em></span> <a class="e_check" href="#" target="_blank">查看详情</a>
          </div>
    </div>
  </section> -->
  <section class="u_rules">
    <div class="inner">
      <h2 class="t_h2 s_pink"><em>抽奖规则</em></h2>
      <ol>
        <li>1、商城注册用户，每天登录抽奖页面，即可免费获得5次幸运抽奖机会，每次抽奖将消耗<#if site??>${site.lotteryPoints!''}</#if>积分，中奖名单在本页实时公布；</li>
        <li>2、抽中积分的用户，系统会即时发放到你的个人账户，详情请查看<a href="#" target="_blank">积分明细</a>；</li>
        <li>3、抽中优惠券以及实物奖的用户，系统将以优惠券形式发放到你的个人账户，详情请点击查看<a href="#" target="_blank">我的奖品</a>；</li>
        <li>4、所有奖品不能折现、不能替换，图片仅供参考，请以实物为准；</li>
        <li>5、本次活动最终解释权归惠之店所有。</li>
      </ol>
    </div>
  </section>
</div>
  <div class="clear h40"></div>

<#include "/client/common_footer.ftl" />
</boby>
</html>






