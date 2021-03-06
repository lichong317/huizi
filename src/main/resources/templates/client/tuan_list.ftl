<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script src="/client/js/header.js"></script>
<script type="text/javascript" src="/client/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/client/js/common.js"></script>
<script type="text/javascript" src="/client/js/ljs-v1.01.js"></script>
<script type="text/javascript" src="/client/js/list.js"></script>

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

<!-- 团购倒计时-->
function checkTime(i)    
            {    
               if (i < 10) {    
                   i = "0" + i;    
                }    
               return i;    
            }    

</script>

</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<div class="clear h20"></div>
   <!--团购列表内容-->
   <div class="main">
        <div class="weizhi">
            <span><a href="/">首页</a></span>><span>团购</span>
        </div>
        <div class="bulk_list">                            
              <#if tuan_goods_page?? && tuan_goods_page.content?size gt 0>
                  <ul>
                      <#list tuan_goods_page.content as goods>
                         <script>
                                   $(document).ready(function(){
                                            setInterval("timer${goods_index}()",1000);
                                       });
                                                        
                                          function timer${goods_index}()
                                            {
                                              <#if goods.isGroupSale && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>
                                                var ts = (new Date(${goods.groupSaleStopTime?string("yyyy")}, 
                                                parseInt(${goods.groupSaleStopTime?string("MM")}, 10)-1, 
                                                ${goods.groupSaleStopTime?string("dd")}, 
                                                ${goods.groupSaleStopTime?string("HH")}, 
                                                ${goods.groupSaleStopTime?string("mm")}, 
                                                ${goods.groupSaleStopTime?string("ss")})) - (new Date());//计算剩余的毫秒数
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
                                                $("#timeLeft${goods_index}").html("剩余时间：<b>"
                                                                            +"<#if goods.groupSaleStartTime?? && goods.groupSaleStopTime??>"
                                                                            +"<#if goods.groupSaleStopTime gt .now>"
                                                                            + dd + "</b>天<b>"
                                                                            + hh + "</b>时<b>"
                                                                            + mm + "</b>分<b>"
                                                                            + ss + "</b>秒"
                                                                            +"<#else>"
                                                                            +"团购已结束"
                                                                            +"</#if>"
                                                                            +"</#if>"
                                                                            +"<span>"
                                                                            +<#if goods.soldNumber??&&goods.soldNumber != 0>${goods.soldNumber!''}<#else>35</#if> + "人已购买"  
                                                                            +"</span>" );
                                                </#if>       
                                             }
                                             
                           </script>
                      
                           <li>
                               <div class="clear"></div>
                               <div class="left_pic">
                                    <a href="/goods/${goods.id?c}?qiang=3"><img src="${goods.groupSaleImage!''}" width="396" height="307" ></a>
                               </div>
                               <div class="right_infor"> 
                                    <div class="infor_top">
                                          <h4>${goods.title!''}</h4>
                                          <p>${goods.subTitle!''}</p>
                                          <div class="price">
                                                <div class="clear"></div>
                                                <div class="sk fl">
                                                      <p>团购价：</p>
                                                      <p class="redp">¥：<#if goods.groupSalePrice??>${goods.groupSalePrice?string("0.00")}</#if></p>
                                                </div>
                                                <div class="op fr">
                                                      <p>原价：</p>
                                                      <p class="dep">¥：<#if goods.salePrice??>${goods.salePrice?string("0.00")}</#if></p>
                                                </div>
                                                <div class="clear"></div>
                                          </div>
                                    </div>
                                    <div class="infor_bottom">
                                              
                                                <p id="timeLeft${goods_index}" class="p1 mb20">剩余时间：  </p>
                                                <div class="buybtn">
                                                      <#if GoodsService_item_list??>                                                       
                                                            <#list GoodsService_item_list as item>
                                                                 <#if item_index < 4 > 
                                                                        <img src="${item.logo!''}" width="38" height="38" style="vertical-align:middle">                                                                  
                                                                        <a href="javascript:;" style="height: 38px;
                                                                        display: inline-block;line-height: 40px;color:#333333;font-size: 14px;margin-right: 40px;">${item.title!''}</a>                                                                    
                                                                 </#if>
                                                            </#list>                                                            
                                                      </#if>                                                  
                                                      <#if goods.groupSaleStartTime?? && goods.groupSaleStopTime??>
                                                          <#if goods.groupSaleStartTime gt .now>
                                                               <a href="javascript:;" class="soon">即将开始</a>
                                                          <#elseif goods.groupSaleStopTime < .now>
                                                               <a href="javascript:;" class="finish">团购结束</a>
                                                          <#else>
                                                               <a href="/order/buy/tuan?gid=<#if goods??>${goods.id?c}</#if>" class="buy">立即团购</a>
                                                          </#if>
                                                      </#if>
                                                </div>
                                          
                                    </div> 
                               </div> 
                               <div class="clear"></div>  
                           </li>
                      </#list>
                  </ul>
                 <#else>
                      <div style="text-align: center; padding: 15px;">正在扩充中，敬请期待！</div>
              </#if> 
         </div>
          <div class="pagebox">
              <div class="num">
                <#if tuan_goods_page??>
                    <#assign continueEnter=false>
                    <#if tuan_goods_page.number+1 == 1>
                        <a class="a1 a0" href="javascript:;"><span>上一页</span></a>
                    <#else>
                        <a class="a1 a0" href="/promotion/tuan?page=${tuan_goods_page.number-1}"><span>上一页</span></a>
                    </#if>
                    
                    <#if tuan_goods_page.totalPages gt 0>
                        <#list 1..tuan_goods_page.totalPages as page>
                            <#if page <= 3 || (tuan_goods_page.totalPages-page) < 3 || (tuan_goods_page.number+1-page)?abs<3 >
                                <#if page == tuan_goods_page.number+1>
                                    <a class="sel" href="javascript:;">${page}</a>
                                <#else>
                                    <a href="/promotion/tuan?page=${page}">${page}</a> <#-- ${page} -->
                                </#if>
                                <#assign continueEnter=false>
                            <#else>
                                <#if !continueEnter>
                                    <span> ... </span>
                                    <#assign continueEnter=true>
                                </#if>
                            </#if>
                        </#list>
                    </#if>
                    
                    <#if tuan_goods_page.number+1 == tuan_goods_page.totalPages || tuan_goods_page.totalPages==0>
                        <a class="a2" href="javascript:;"><span>下一页</span></a>
                    <#else>
                        <a class="a2" href="/promotion/tuan?page=${tuan_goods_page.number+1}"><span>下一页</span></a>
                    </#if>
                </#if>
                <span> 共<#if tuan_goods_page.totalPages gt 0>${tuan_goods_page.number+1}<#else>0</#if>/${tuan_goods_page.totalPages}页 </span>
              </div>
              <div class="page">
                <input class="sub" type="submit" onclick="javascript:window.location='/promotion/tuan?page='+(parseInt($('#iPageNum').val())-1);" value="确定" />
                <span>页</span>
                <input class="text" type="text" value="${page!'1'}" id="iPageNum"/>
                <span>到第</span>
              </div>
              <div class="clear"></div>
            </div><!--pagebox END-->              
      </div>           
</div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
