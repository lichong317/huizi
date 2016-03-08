<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if goods??>${goods.seoTitle!''}-惠之店</#if></title>
<meta name="keywords" content="${goods.seoKeywords!''}">
<meta name="description" content="${goods.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
  searchTextClear(".comserch_text","搜索关键字","#999","#333");
  indexBanner("box","sum",300,5000,"pronum");
  
   $("#id-minus").click(function(){
        var q = parseInt($("#quantity").val());
        
        if (q > 1)
        {
            $("#quantity").val(q-1);
        }
        
        $("#addCart").attr("href", "/cart/init?id=${goods.id?c}&m=1&quantity=" + $("#quantity").val()<#if shareId??>+"&shareId=${shareId}"</#if> );
    });
    
    $("#id-plus").click(function(){
        var q = parseInt($("#quantity").val());
        <#if goods.leftNumber??>
            if (q < ${goods.leftNumber?c})
            {
                $("#quantity").val(q+1);
            }
            else
            {
                alert("已达到库存最大值");
                //ct.alert({
                    //text: "已达到库存最大值",
                    //type: "alert"
                //});
            }
        <#else>
            $("#quantity").val(q+1);
        </#if>
        $("#addCart").attr("href", "/cart/init?id=${goods.id?c}&m=1&quantity=" + $("#quantity").val()<#if shareId??>+"&shareId=${shareId}"</#if> );
    
    });
});

function addCollect(goodsId)
{
    if (undefined == goodsId)
    {
        return;
    }
    
    $.ajax({
        type:"post",
        url:"/touch/user/collect/add",
        data:{"goodsId": goodsId},
        dataType: "json",
        success:function(res){
             if(res.code==0){
                $("#addCollect").removeClass("pro_share");
                $("#addCollect").addClass("pro_share1");
                
            }
            //alert(res.message);
            //ct.alert({
                    //text: res.message,
                    //type: "alert"
           // });
            
            // 需登录
            if (res.code==1)
            {
                setTimeout(function(){
                    window.location.href = "/touch/login";
                }, 1000); 
            }
        }
    });
}
</script>

</head>

<body>
<div class="maintop_bg"></div>
<header class="maintop">
  <div class="main">
    <p>商品详情</p>
    <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
    <a class="a4" href="/touch"><img src="/touch/images/home.png" height="22" /></a>
  </div>
</header>
<section id="box">
  <ul id="sum">
    <#if goods.showPictures??>
        <#list goods.showPictures?split(",") as uri>
            <#if ""!=uri>
                <li><img src="${uri!''}" /></li>
            </#if>
        </#list>
    </#if>
  </ul>
  <div class="clear"></div>
</section>
<div class="main" style="z-index:10;">
    <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
    <p class="mainbox1 timebox" style="text-align:center">剩余时间：<b id="lday">0</b>天<b id="lhour">0</b>时<b id="lmin">0</b>分<b id="lsec">0</b>秒</p>
<script>
$(document).ready(function(){
    setInterval("timer()",1000);
});

function timer()
{
    var ts = (new Date(${goods.flashSaleStopTime?string("yyyy")}, 
                parseInt(${goods.flashSaleStopTime?string("MM")}, 10)-1, 
                ${goods.flashSaleStopTime?string("dd")}, 
                ${goods.flashSaleStopTime?string("HH")}, 
                ${goods.flashSaleStopTime?string("mm")}, 
                ${goods.flashSaleStopTime?string("ss")})) - (new Date());//计算剩余的毫秒数
                
    var allts = (new Date(${goods.flashSaleStopTime?string("yyyy")}, 
                parseInt(${goods.flashSaleStopTime?string("MM")}, 10)-1, 
                ${goods.flashSaleStopTime?string("dd")}, 
                ${goods.flashSaleStopTime?string("HH")}, 
                ${goods.flashSaleStopTime?string("mm")}, 
                ${goods.flashSaleStopTime?string("ss")}))
               - (new Date(${goods.flashSaleStartTime?string("yyyy")}, 
                parseInt(${goods.flashSaleStartTime?string("MM")}, 10)-1, 
                ${goods.flashSaleStartTime?string("dd")}, 
                ${goods.flashSaleStartTime?string("HH")}, 
                ${goods.flashSaleStartTime?string("mm")}, 
                ${goods.flashSaleStartTime?string("ss")}));//总共的毫秒数
                
    if (0 == ts)
    {
        window.location.reload();
    }
    
    var date = new Date();
    var dd = parseInt(ts / 1000 / 60 / 60 / 24, 10);//计算剩余的天数
    var hh = parseInt(ts / 1000 / 60 / 60 % 24, 10);//计算剩余的小时数
    var mm = parseInt(ts / 1000 / 60 % 60, 10);//计算剩余的分钟数
    var ss = parseInt(ts / 1000 % 60, 10);//计算剩余的秒数
    if(ss < 0){
        ss = 0;
    }
    if(mm < 0){
        mm = 0;
    }
    if(hh < 0){
        hh = 0;
    }
    if(dd < 0){
        dd = 0;
    }
    dd = checkTime(dd);
    hh = checkTime(hh);
    mm = checkTime(mm);
    ss = checkTime(ss);
    
    $("#lday").html(dd);
    $("#lhour").html(hh);
    $("#lmin").html(mm);
    $("#lsec").html(ss);
                    
    var price = ${goods.flashSalePrice?string("0.00")} * ts / allts;
    if(price < 1){
        price = 1;
    }
    var s_x = Math.round(price).toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    
    $("#currPrice").html("￥：" + s_x);
}

function checkTime(i)  
{  
    if (i < 10) {  
        i = "0" + i;  
    }  
    return i;  
}
</script>
<#elseif qiang?? && qiang != 1 && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>
<p class="mainbox1 timebox" style="text-align:center">剩余时间：<b id="lday">0</b>天<b id="lhour">0</b>时<b id="lmin">0</b>分<b id="lsec">0</b>秒</p>
<script>
$(document).ready(function(){
    setInterval("timer()",1000);
});

function timer()
{
    var ts = (new Date(${goods.groupSaleStopTime?string("yyyy")}, 
                parseInt(${goods.groupSaleStopTime?string("MM")}, 10)-1, 
                ${goods.groupSaleStopTime?string("dd")}, 
                ${goods.groupSaleStopTime?string("HH")}, 
                ${goods.groupSaleStopTime?string("mm")}, 
                ${goods.groupSaleStopTime?string("ss")})) - (new Date());//计算剩余的毫秒数
                
    var allts = (new Date(${goods.groupSaleStopTime?string("yyyy")}, 
                parseInt(${goods.groupSaleStopTime?string("MM")}, 10)-1, 
                ${goods.groupSaleStopTime?string("dd")}, 
                ${goods.groupSaleStopTime?string("HH")}, 
                ${goods.groupSaleStopTime?string("mm")}, 
                ${goods.groupSaleStopTime?string("ss")}))
               - (new Date(${goods.groupSaleStartTime?string("yyyy")}, 
                parseInt(${goods.groupSaleStartTime?string("MM")}, 10)-1, 
                ${goods.groupSaleStartTime?string("dd")}, 
                ${goods.groupSaleStartTime?string("HH")}, 
                ${goods.groupSaleStartTime?string("mm")}, 
                ${goods.groupSaleStartTime?string("ss")}));//总共的毫秒数
                
    if (0 == ts)
    {
        window.location.reload();
    }
    
    var date = new Date();
    var dd = parseInt(ts / 1000 / 60 / 60 / 24, 10);//计算剩余的天数
    var hh = parseInt(ts / 1000 / 60 / 60 % 24, 10);//计算剩余的小时数
    var mm = parseInt(ts / 1000 / 60 % 60, 10);//计算剩余的分钟数
    var ss = parseInt(ts / 1000 % 60, 10);//计算剩余的秒数
    if(ss < 0){
        ss = 0;
    }
    if(mm < 0){
        mm = 0;
    }
    if(hh < 0){
        hh = 0;
    }
    if(dd < 0){
        dd = 0;
    }
    dd = checkTime(dd);
    hh = checkTime(hh);
    mm = checkTime(mm);
    ss = checkTime(ss);
    
    $("#lday").html(dd);
    $("#lhour").html(hh);
    $("#lmin").html(mm);
    $("#lsec").html(ss);
                    
    var price = ${goods.groupSalePrice?string("0.00")} * ts / allts;
    if(price < 1){
        price = 1;
    }
    var s_x = Math.round(price).toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    
    $("#currPrice").html("￥：" + s_x);
}

function checkTime(i)  
{  
    if (i < 10) {  
        i = "0" + i;  
    }  
    return i;  
}
</script>
</#if>
  <#if goods??>
      <a  class="<#if tdUserCollect??>pro_share1<#else>pro_share</#if>" id="addCollect" href="javascript:addCollect(${goods.id?c});">关注</a>
      <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
          <h3 class="protext red">抢拍价：￥<#if goods.flashSalePrice??>${goods.flashSalePrice?string("0.00")}</#if><del class="unl-lt c9 fs07 ml10">￥<#if goods.marketPrice??>${goods.marketPrice?string("0.00")}</#if></del></h3>
      <#elseif qiang?? && qiang != 1 && goods.groupSaleStartTime?? && goods.groupSaleStartTime < .now && goods.groupSaleStopTime?? && goods.groupSaleStopTime gt .now>
          <h3 class="protext red">团购价：￥<#if goods.groupSalePrice??>${goods.groupSalePrice?string("0.00")}</#if><del class="unl-lt c9 fs07 ml10">￥<#if goods.marketPrice??>${goods.marketPrice?string("0.00")}</#if></del></h3>
      <#else>
          <h3 class="protext red">￥<#if goods.salePrice??>${goods.salePrice?string("0.00")}</#if><del class="unl-lt c9 fs07 ml10">￥<#if goods.marketPrice??>${goods.marketPrice?string("0.00")}</#if></del></h3>
      </#if>   
      <p class="center fs09 mb10">${goods.title!''}</p>
      <p class="center fs07 mb10" style=" color:#999;">${goods.subTitle!''}</p>
      
      <div class="protext">
        <#if goods.giftList??>
            <#list goods.giftList as gifts>
                <#if gifts_index <4>
                    <p class="center fs07 red mb10"><span style="background:#F00; color:#FFF; margin-right:10px;">【赠品】</span>${gifts.goodsTitle!''}<span class="fr"><a href="/touch/goods/${gifts.goodsId?c}">查看详情</a></span></p>
                </#if>
            </#list>
        </#if>
      <div class="clear20"></div>    
      <table>
          <#if total_select??>
            <#if 1==total_select>
                <tr>
                  <th>${select_one_name!''}：</th>
                  <td>
                    <#if select_one_goods_list??>
                    <#list select_one_goods_list as item>
                        <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectOneValue}</a>
                    </#list>
                    </#if>
                  </td>
                </tr>
            <#elseif 2==total_select>
                <tr>
                    <th>${select_one_name!''}</th>
                    <td>
                        <#if select_one_goods_list??>
                        <#list select_one_goods_list as item>
                            <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectOneValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_two_name!''}</th>
                    <td>
                        <#if select_two_goods_list??>
                        <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="sel"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectTwoValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
            <#elseif 3==total_select>
                <tr>
                    <th>${select_one_name!''}</th>
                    <td>
                        <#if select_one_goods_list??>
                        <#list select_one_goods_list as item>
                            <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectOneValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_two_name!''}</th>
                    <td>
                        <#if select_two_goods_list??>
                        <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="sel"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectTwoValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_three_name!''}</th>
                    <td>
                        <#if select_three_goods_list??>
                        <#list select_three_goods_list as item>
                            <a <#if item.selectThreeValue==three_selected>class="sel"</#if> href="<#if qiang??>#<#else>/touch/goods/${item.id?c}</#if>">${item.selectThreeValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
            </#if>
        </#if>
        </table>
      </div>
  </#if>
  <a class="protext" href="/touch/goods/comment/<#if goods??>${goods.id?c}</#if>">商品评价（${comment_count!'0'}）</a>
    <menu class="protext">
    <a class="a1" href="/touch/goods/consult/<#if goods??>${goods.id?c}</#if>"><span>商品咨询（${total_consults!'0'}）</span></a>
    <div class="clear"></div>
  </menu>

  <a class="protext" style=" border-top: 1px solid #eee;" href="/touch/goods/param/${goods.id?c}">规格参数</a>
  <a class="protext" href="/touch/goods/detail/${goods.id?c}">图文详情</a>
 
</div>
<!--main END-->
<#if !app??>
<section class="botmain">
  <div class="main">
  <div class="center">
   <#if username??>
        <a href="/touch/user">${username!''}</a>
        <span>|</span>
        <a href="/touch/logout" onclick="logout()">退出</a>
    <#else>
        <a href="/touch/login">登录</a>
        <span>|</span>
        <a href="/touch/reg">注册</a>
    </#if>    
  </div>
  </div>
</section>

  <p class="ta-c mb10">
    <a class="fc fs09" href="#">触屏版</a>
    <span>&nbsp;|&nbsp;</span>
    <a class="fs09" href="/goods/<#if goodsId??>${goodsId?c}</#if>">电脑版</a>
  </p>
  <p class="ta-c fs08 c7">${site.copyright!''} </p> 
  <p class="ta-c fs08 c7">${site.icpNumber!''}</p> 
</#if>
<div class="buyfoot_bg"></div>
  <footer class="buyfoot">
     <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
        <div class="mainbox">
            <div class="buynum">
                <a disabled="disabled" href="javascript:;">+</a>
                <a class="a1" disabled="disabled" href="javascript:;">-</a>
                <input type="text" disabled="disabled" class="text" value="1" />
            </div>
            <#if goods.flashSaleLeftNumber gt 0>
                <a id="addCart" class="fr" href="/touch/order/buy/qiang?gid=${goods.id?c}<#if shareId??>&shareId=${shareId}</#if>">立即购买</a>
            <#else>
                <a id="addCart" class="fr" href="#">抢购结束</a>
            </#if>
            <div class="clear"></div>
        </div>
     <#elseif qiang?? && qiang == 3 && goods.groupSaleStartTime?? && goods.groupSaleStartTime < .now && goods.groupSaleStopTime?? && goods.groupSaleStopTime gt .now>
        <div class="mainbox">
            <div class="buynum">
                <a disabled="disabled" href="javascript:;">+</a>
                <a class="a1" disabled="disabled" href="javascript:;">-</a>
                <input type="text" disabled="disabled" class="text" value="1" />
            </div>
            <#if goods.groupSaleLeftNumber gt 0>
                <a id="addCart" class="fr" href="/touch/order/buy/tuan?gid=${goods.id?c}<#if shareId??>&shareId=${shareId}</#if>">立即购买</a>
            <#else>
                <a id="addCart" class="fr" href="#">团购结束</a>
            </#if>
            <div class="clear"></div>
        </div>
     <#else>
       <div class="mainbox">
            <div class="buynum">
                <a id="id-minus" href="javascript:;">-</a>
                <a class="a1"id="id-plus" href="javascript:;">+</a>
                <input type="text" id="quantity" class="text" value="1" />
            </div>
            <#if goods.leftNumber gt 0>
                <a id="addCart" class="fr" href="/cart/init?id=${goods.id?c}&m=1<#if qiang??>&qiang=${qiang}</#if><#if shareId??>&shareId=${shareId}</#if>">加入购物车</a>
            <#else>
                <a id="addCart" class="fr" href="#">库存不足</a>
            </#if>
            <div class="clear"></div>
      </div>
    </#if>
</footer>
</body>
</html>
