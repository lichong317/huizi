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


<script type="text/javascript" src="/client/js/jQueryRotate.2.2cj.js"></script>
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

</script>

<style type="text/css">
.rotate-con-pan{background:url(/client/images/disk.jpg) no-repeat 0 0;background-size:100% 100%;position:relative;width:480px;height:480px;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box; float:left; margin-left:180px;}
.rotate-con-zhen{width:112px;height:224px;background:url(/client/images/start.png) no-repeat 0 0;background-size:100% 100%;cursor:pointer;position:absolute;left:180px;top:140px;}
</style>



</head>
<boby>
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
           <p>还差<em><#if tdUserLevelnext.requiredConsumption?? && user.totalSpendCash??>${tdUserLevelnext.requiredConsumption - user.totalSpendCash}</#if></em>成长值升级为<em>${tdUserLevelnext.title!''}</em>，升级后，每天可领取<em>积分${tdUserLevelnext.signinPoints!''}个</em>。</p>
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
  
  

<div class="rotate-con-pan">
        <div class="rotate-con-zhen"></div>
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
          <#if luckydog_list??>
              <#list luckydog_list as item>
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

<#if prizeCategory??>
<script type="text/javascript">
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
     
    $(".rotate-con-zhen").rotate({
        bind:{
            click:function(){                 
                var a = runzp(data1);                
                $(this).rotate({
                       duration:3000,               //转动时间
                       angle: animatetemp,          //起始角度
                       animateTo:720+a.angle,      //结束的角度
                       //easing: $.easing.easeOutSine,//动画效果，需加jquery.easing.min.js
                       // easing: $.easing.easeInOutExpo,
                       callback: function(){
                            // alert(a.isOver);
                             if(a.isOver == true){
                                alert("奖品已抽完！");
                             }else{
                                alert(a.prize+a.message);//简单的弹出获奖信息
                                animatetemp = a.angle;
                                if(a.isWin){
                                    window.location.reload();
                                }
                             }                             
                             
                       }
                });                                     
            }
        }
    });
});
</script>
</#if>
<div class="clear"></div>
  <section class="u_weekPrize">
    <div class="inner">
      <h2 class="t_h2 s_yellow"><em>本周大奖</em></h2>
          <div class="c_goods s_fl"> <a class="e_img" href="#" target="_blank"><img src="/client/images/hzd_61.png" alt="" width="214" height="214"></a>
            <h3><a href="#" target="_blank">苹果iPhone 6 </a></h3>
            <span>价值：<em>￥5200.00</em></span> <a class="e_check" href="#" target="_blank">查看详情</a> 
          </div>
          <div class="c_goods s_fl"> <a class="e_img" href="#" target="_blank"><img src="/client/images/hzd_61.png" alt="" width="214" height="214"></a>
            <h3><a href="#" target="_blank">苹果iPhone 6 </a></h3>
            <span>价值：<em>￥5200.00</em></span> <a class="e_check" href="#" target="_blank">查看详情</a>
          </div>
    </div>
  </section>
  <section class="u_rules">
    <div class="inner">
      <h2 class="t_h2 s_pink"><em>抽奖规则</em></h2>
      <ol>
        <li>1、商城注册用户，每天登录抽奖页面，即可免费获得5次幸运抽奖机会，每次抽奖将消耗20积分，中奖名单在本页实时公布；</li>
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