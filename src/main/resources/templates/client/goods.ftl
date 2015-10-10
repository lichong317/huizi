<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if goods??>${goods.seoTitle!''}-</#if>惠资生活</title>

<meta name="keywords" content="${goods.seoKeywords!''}">
<meta name="description" content="${goods.seoDescription!''}">
<meta name="copyright" content="惠资生活" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script> 
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/goods.js"></script>
<script src="/client/js/goods_comment_consult.js"></script>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

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
	   
	$("#id-minus").click(function(){
        var q = parseInt($("#quantity").val());
        
        if (q > 1)
        {
            $("#quantity").val(q-1);
        }
        
        $("#addCart").attr("href", "/cart/init?id=${goods.id?c}&quantity=" + $("#quantity").val()<#if shareId??>+"&shareId=${shareId}"</#if>); 
    });
    
    $("#id-plus").click(function(){
        var q = parseInt($("#quantity").val());
        
        <#if goods.leftNumber??>
            if (q < ${goods.leftNumber!'0'})
            {
                $("#quantity").val(q+1);
            }
            else
            {
                alert("已达到库存最大值");
            }
        <#else>
            $("#quantity").val(q+1);
        </#if>
        $("#addCart").attr("href", "/cart/init?id=${goods.id?c}&quantity=" + $("#quantity").val()<#if shareId??>+"&shareId=${shareId}"</#if>); 
    
    });
    
     $("#zhAddCart").click(function(){
        var str = "";
        $(".comboCheckBox:checked").each(function(){
            str += $(this).attr("zpid");
            str += ",";
        });
        var href = "/order/buy/comb?gid=" + ${goods.id?c} + "&zhid=" + str<#if shareId??>+"&shareId=${shareId}"</#if>;
        
        window.location = href;
        
    });
});

    function addCart(){
        var q = parseInt($("#quantity").val());
        window.location.href="/cart/init?id=${goods.id?c}&quantity="+q+"<#if qiang??>&qiang=${qiang}</#if>";       
    }
    function buyNow(){
        window.location.href="/order/buy/normal?gid=<#if goods??>${goods.id?c}</#if>";     
    }

    function combSelect(self, price, originPrice)
    {
        var count = parseInt($("#combCount").html());
        var currentPrice = parseFloat($("#combCurrentPrice").html());
        var combOriginPrice = parseFloat($("#combOriginPrice").html());
        var combSavePrice = parseFloat($("#combSave").html());
        
        // 选中
        if (self.checked)
        {
            $("#combCount").html(count+1);
            $("#combCurrentPrice").html(currentPrice + price);
            $("#combOriginPrice").html(combOriginPrice + originPrice);
            $("#combSave").html(combSavePrice + originPrice - price);
        }
        // 取消选中
        else
        {
            $("#combCount").html(count-1);
            $("#combCurrentPrice").html(currentPrice - price);
            $("#combOriginPrice").html(combOriginPrice - originPrice);
            $("#combSave").html(combSavePrice - originPrice + price);
        }
    }
    
    function clearSelect()
    {
        $("#combCount").html(0);
        $("#combCurrentPrice").html(${goods.salePrice?string("0.00")});
        $("#combOriginPrice").html(${goods.salePrice?string("0.00")});
        $("#combSave").html(0);
        
        $(".comboCheckBox").attr("checked", false);
    }
    
    <!-- 用户名中间变为*号  2015-8-4 15:38:18 mdj  -->
$(document).ready(function(){
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
</script>
</head>

<body>
<#include "/client/common_header.ftl" />

<div class="clear h20"></div>
     <div class="main">
        <div class="weizhi">
        <span><a href="/">首页</a></span>
            <#if category_tree_list??>
                <#list category_tree_list as category>
                    > <span><a href="/list/${category.id?c}">${category.title!""}</a></span>
                </#list>
            </#if>
            > <span>${goods.name!''}</span>
        </div>
    <div class="pro_box">
        <section class="proinfo_left">
              <menu id="proshowimg">
                <#if goods.showPictures??>
                <#list goods.showPictures?split(",") as uri>
                    <#if ""!=uri && uri_index < 4>
                        <li><img src="${uri!''}" /></li>
                    </#if>
                </#list>
                </#if>
              </menu>
              <div class="clear h20"></div>
                 <menu id="proshowmenu"></menu>
              <div class="clear h20"></div>
              
              <div class="pro_share">
                 <#-->   <span>分享：</span>
                    <a href="#"><img src="/client/images/content/share01.png" /></a>
                    <a href="#"><img src="/client/images/content/share02.png" /></a>
                    <a href="#"><img src="/client/images/content/share03.png" /></a>
                    <a href="#"><img src="/client/images/content/share04.png" /></a>
                    <a href="#"><img src="/client/images/content/share05.png" /></a>
                   -->
                    <!-- JiaThis Button BEGIN -->
                <#--    <div class="jiathis_style">
                        <a class="jiathis_button_qzone"></a>
                        <a class="jiathis_button_tsina"></a>
                        <a class="jiathis_button_tqq"></a>
                        <a class="jiathis_button_weixin"></a>
                        <a class="jiathis_button_renren"></a>
                        <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
                    </div>
                    <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>  -->
                    <!-- JiaThis Button BEGIN -->
                        <div class="jiathis_style">
                        <a class="jiathis_button_qzone"></a>
                        <a class="jiathis_button_tsina"></a>
                        <a class="jiathis_button_tqq"></a>
                        <a class="jiathis_button_renren"></a>
                        <a class="jiathis_button_weixin"></a>
                        <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
                        </div>
                        <script type="text/javascript" >
                        var jiathis_config={
                            url:"http://192.168.20.80:8080/goods/${goods.id?c}<#if qiang??><#if user??>?qiang=${qiang?c}&shareId=${user.id?c}<#else>?qiang=${qiang?c}</#if><#else><#if user??>?shareId=${user.id?c}</#if></#if>",
                            summary:"",
                            title:"惠资生活##${goods.title!''}",
                            shortUrl:false,
                            hideMore:false
                        }
                        </script>
                        <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                    <!-- JiaThis Button END -->
                    
                  <!-- JiaThis Button END -->
                    <span class="ml10">商品编码：${goods.code!''}</span>
                    <a class="a1" href="javascript:addCollect(${goods.id?c});">关注该商品</a>
                    <div class="clear"></div>
              </div>
        </section><!--proinfo_left END-->
    
    <section class="proinfo_right">
      <h3>${goods.title!''}</h3>
      <h4 class="red">${goods.subTitle!''}</h4>
     <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
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
      <div class="pro_price">
          <p class="p1">
              <span>原价</span>
              <span class="unl-th c9">￥：${goods.salePrice?string("0.00")}</span>
            </p>
          <p class="p1">
              <span>秒杀价</span>
              <span class="red fs24 lh30 mr20">￥：${goods.flashSalePrice?string("0.00")}</span>
            </p>
    <!--        <p class="p1">
              <span class="mr10">实时价格</span>
              <span class="red fs24 lh30 mr20" id="currPrice">￥：0.00</span>
            </p> -->
            <p class="p1">
              <span >剩余时间</span>
              <span class="red mr10 ml10" id="lday">0</span>天<span class="red mr10 ml10" id="lhour">0</span>时<span class="red ml10 mr10" id="lmin">0</span>分<span class="red ml10 mr10" id="lsec">0</span>秒
            </p>
      </div>
      <#else>  
      <div class="pro_price">
        <p class="p1">         
          <#if qiang?? && qiang != 1 && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>
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
                <span>团购价格：</span>
                <span class="red fs24 lh30 mr20">￥：<#if goods.groupSalePrice??>${goods.groupSalePrice?string("0.00")}</#if></span>
                <span class="unl-th c9">￥：<#if goods.marketPrice??>${goods.marketPrice?string("0.00")}</#if></span>
              <p class="p1">
                  <span >剩余时间</span>
                  <span class="red mr10 ml10" id="lday">0</span>天<span class="red mr10 ml10" id="lhour">0</span>时<span class="red ml10 mr10" id="lmin">0</span>分<span class="red ml10 mr10" id="lsec">0</span>秒
              </p>
          <#else>
              <span>价格：</span>
                <span class="red fs24 lh30 mr20">￥：<#if goods.salePrice??>${goods.salePrice?string("0.00")}</#if></span>
                <span class="unl-th c9">￥：<#if goods.marketPrice??>${goods.marketPrice?string("0.00")}</#if></span>
                <p class="p1">
                  <span>促销信息：</span>
                  <span class="red">
                    ${goods.promotion!''}
                  </span>
                </p>
          </#if>
           
        </p>
            
      </div><!--pro_price END-->
      </#if>
      <table class="pro_choose">
        <#if total_select??>
            <#if 1==total_select>
                <tr>
                  <th>${select_one_name!''}：</th>
                  <td>
                    <#if select_one_goods_list??>
                    <#list select_one_goods_list as item>
                        <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="/goods/${item.id?c}">${item.selectOneValue}</a>
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
                            <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="/goods/${item.id?c}">${item.selectOneValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_two_name!''}</th>
                    <td>
                        <#if select_two_goods_list??>
                        <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="sel"</#if> href="/goods/${item.id?c}">${item.selectTwoValue}</a>
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
                            <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="/goods/${item.id?c}">${item.selectOneValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_two_name!''}</th>
                    <td>
                        <#if select_two_goods_list??>
                        <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="sel"</#if> href="/goods/${item.id?c}">${item.selectTwoValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_three_name!''}</th>
                    <td>
                        <#if select_three_goods_list??>
                        <#list select_three_goods_list as item>
                            <a <#if item.selectThreeValue==three_selected>class="sel"</#if> href="/goods/${item.id?c}">${item.selectThreeValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
            </#if>
        </#if>
        <tr>
        <th>服务支持：</th>
         <td>
          <#if GoodsService_item_list??>                                                       
            <#list GoodsService_item_list as item>      
              <#if item_index < 4 >             
                <img src="${item.logo!''}" width="26" height="26" style="vertical-align:middle">                                                                  
                <div style="height: 26px;display: inline-block;line-height: 30px;color:#333333;">${item.title!''}</div>                                 
              </#if>
            </#list>
          </#if>
          </td>
        </tr>
        <tr>
          <th>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</th>
          <td>
            <input name="quantity" type="text" id="quantity" value="1" class="text" />
            <div class="plus">
                <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
                    <a id="" href="javascript:;">+</a>
                    <a id="" href="javascript:;">-</a>
                <#elseif qiang?? && qiang!=1 && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>
                    <a id="" href="javascript:;">+</a>
                    <a id="" href="javascript:;">-</a>
                <#else>
                    <a id="id-plus" href="javascript:;">+</a>
                    <a id="id-minus" href="javascript:;">-</a>
                </#if>   
            </div>
            <span class="fl ml10">库存
             <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
                    ${goods.flashSaleLeftNumber!'0'}
                <#elseif qiang?? && qiang!=1 && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>
                    ${goods.groupSaleLeftNumber!'0'}
                <#else>
                    ${goods.leftNumber!'0'}
            </#if> 
                                              件</span>
            <div class="clear"></div>
          </td>
        </tr>
        <tr>
          <th></th>
          <td>
            <#if qiang?? && goods.flashSaleLeftNumber?? && goods.groupSaleLeftNumber??>
                <#if qiang==1 && goods.flashSaleLeftNumber gt 0>
                     <a id="addCart" href="/order/buy/qiang?gid=${goods.id?c}<#if shareId??>&shareId=${shareId}</#if>" class="sub">立即购买</a>
                <#elseif qiang!=1 && goods.groupSaleLeftNumber gt 0>
                     <a id="addCart" href="/order/buy/tuan?gid=${goods.id?c}<#if shareId??>&shareId=${shareId}</#if>" class="sub">立即购买</a>
                <#else>
                     <a id="addCart" href="#" class="sub">库存不足</a>   
                </#if>
            <#else>
                <#if goods.leftNumber gt 0>
                    <a id="addCart" href="/cart/init?id=${goods.id?c}<#if shareId??>&shareId=${shareId}</#if>" class="sub">加入购物车</a>
                <#else>
                    <a id="addCart" href="#" class="sub">库存不足</a>
                </#if>    
            </#if>
            <!--<input type="submit" class="sub" onclick="addCart()" value="加入购物车" />  -->
            <#--><input type="submit" class="sub sub01" onclick="buyNow()" value="立即购买" />-->
            <div class="clear"></div>
          </td>
        </tr>
      </table>
      
      <div class="sys">
        <p><img src="<#if site??>${site.wxQrCode!''}</#if>"  width="108" height="108"/></p>
        <p class="pt5">关注官方微信<br /></p>
      </div>
    </section><!--proinfo_right END-->
    <div class="clear h20"></div>
  </div>
  <section class="pro_assort">
    <menu id="assort_menu">
      <a class="sel" href="#">推荐配套</a>
      <div class="clear"></div>
    </menu>
    <#if qiang??>    
    <#else>
    <ul id="assort_sum">
      <li style="display: none;">
        <div class="part">
          <a href="/goods/${goods.id?c}"><img src="${goods.coverImageUri!''}" width="140" height="140" /></a>
          <p style="height: 37px; overflow: hidden;">${goods.title!''}</p>
          <p class="p1"><span>￥<#if goods.salePrice??>${goods.salePrice?string("0.00")}</#if></span></p>
        </div>
        <p class="part"><img src="/client/images/images/spxq_36.png" /></p>
        <aside class="partside">
            <div class="partside_out">
                <#if goods.combList?? && goods.combList?size gt 0>
                    <#list goods.combList as item>
                      <#if item_index < 4 >
                        <div class="part">
                            <a href="/goods/${item.goodsId?c}"><img src="${item.coverImageUri!''}" width="140" height="140"/></a>
                            <p style="height: 37px; overflow: hidden;">${item.goodsTitle!''}</p>
                            <p class="p2"><del>￥${item.goodsPrice?string("0.00")}</del></p>
                            <p class="p1">
                                <input type="checkbox" class="comboCheckBox" zpid="${item.id?c}" onclick="javascript:combSelect(this, ${item.currentPrice?string("0.00")}, ${item.goodsPrice?string("0.00")});"/>
                                <span>￥${item.currentPrice?string("0.00")}</span>
                            </p>
                        </div>
                        <#if item_index+1 < goods.combList?size> 
                            <p class="part"><img src="/client/images/images/spxq_36.png" /></p>                   
                        </#if>
                      </#if>
                    </#list>
                </#if>
          </div>
        </aside>
        <p class="part"><img src="/client/images/images/dengyu_03.png" width="30"/></p>
        <div class="part01">       
          <p>组合价：￥<span class="red" id="combCurrentPrice">${goods.salePrice?string("0.00")}</span></p>
          <p>原价：￥<span class="unl-th" id="combOriginPrice">${goods.salePrice?string("0.00")}</span></p>       
          <input id="zhAddCart" class="sub" type="submit" value="立即购买" />
        </div>
        <div class="clear"></div>
      </li>
    </ul>
    <div class="clear"></div>
    </#if>
  </section>
  <div class="column_right">
    <div class="detail_tit" id="detail_tit">
      <div class="out">
        <menu>
          <a href="#detail_tit" tid="0" class="sel stab">商品介绍</a>
          <a href="#detail_tit" tid="1" class="stab">规格参数</a>
          <a href="#detail_tit" tid="2" class="stab">售后服务</a>
          <a href="#detail_tit" tid="3" class="stab">商品评价</a>
          <a href="#consult-sec" tid="4" class="stab">商品咨询</a>
          <div class="clear"></div>
        </menu>
      </div>
    </div><!--detail_tit END-->
    
    <div id="tab0" class="php_z">
        <#--
        <article class="detail_essay">
          <p class="ta-c"><img src="images/images/spxq_41.png" /></p>
        </article>
        -->
        ${goods.detail!''}
    </div>
        
    <div id="tab1" class="php_z" style="display:none;">
        <table class="detail_tab">
            <#if goods.paramList??>
                <#list goods.paramList as param>
                    <#if param_index % 3 == 0 >
                        <tr>
                            <td>${param.paramName!''}: ${param.value!''}</td>
                            <#if goods.paramList?size gt param_index+1 >
                                <td>${goods.paramList[param_index+1].paramName!''}: ${goods.paramList[param_index+1].value!''}</td>
                            </#if>
                            <#if goods.paramList?size gt param_index+2 >
                                <td>${goods.paramList[param_index+2].paramName!''}: ${goods.paramList[param_index+2].value!''}</td>
                            </#if>
                        </tr>  
                    </#if>
                </#list>
            </#if>
        </table>
    </div>
    
    <div id="tab2" class="php_z" style="display:none;">
        ${goods.afterMarketService!''}
    </div>
    
    <div class="clear h10"></div>
    
 <#-->   <section class="pro_mytext" id="pro_mytext">
        <#if username??>
            <form id="commentForm" action="javascript:submitComment();">
                <input type="hidden" name="goodsId" value=${goods.id?c} />
                <div class="pb20">
                    <span class="fs18 mr20">我要评价</span>
                    <input class="ml20" type="radio" name="stars" value="3" datatype="n" nullmsg="请点击进行评价"/><span class="mr20"> 好评</span>
                    <input type="radio" name="stars" value="2" datatype="n" nullmsg="请点击进行评价"/><span class="mr20"> 中评</span>
                    <input type="radio" name="stars" value="1" datatype="n" nullmsg="请点击进行评价"/><span class="mr20"> 差评</span>
                </div>
                <div class="area">
                    <textarea name="content" datatype="*5-255" nullmsg="请输入评价内容"></textarea>
                </div>
                <div class="pt10 pb10">
                    <div class="clear"></div>
                </div>
                <input class="sub" type="submit" value="提交评价" />
            </form>
            <#else>
                <div>请 <a href="/login">登录</a> 以发表评论</div>
            </#if>
    </section><!--pro_mytext END-->
    
    <div class="clear h20"></div>
    
    <#include "/client/goods_comment.ftl" />
    
    <div id="consult-sec" class="clear h20"></div>
    
    <section class="pro_myseek">
        <#if username??>
            <form id="consultForm" action="javascript:submitConsult();">
                <input type="hidden" name="goodsId" value=${goods.id?c} />
                <h3 class="lh30 fs18 fw400 pb10">购买咨询</h3>
                <menu>
                    <textarea name="content" datatype="*5-255" nullmsg="请输入咨询内容"></textarea>
                </menu>
                <p>温馨提示：我们将尽快回复您的咨询。</p>
                <div class="clear"></div>
                <input class="sub" type="submit" value="马上提问" />
            </form>
        <#else>
            <div>请 <a href="/login">登录</a> 以进行咨询</div>
        </#if>
    </section><!--pro_myseek END-->
    
    <#include "/client/goods_consult.ftl" />
    
    
  </div>
  <section class="column_left mt20">
       <h3 class="tit">热卖排行</h3>
        <menu class="border-df">
          <#if hot_list??>
                <#list hot_list as item>
                    <#if item_index < 5>
                        <a class="scan" href="/goods/${item.id?c}">
                            <img src="${item.coverImageUri!''}" title="${item.title!''} ${item.subTitle!''}"/>
                            <div class="num1">${item_index+1}</div>
                            <p style="overflow: hidden; height: 61px;">${item.title!""}</p>
                            <p class="red">￥${item.salePrice?string("0.00")}</p>
                        </a>
                    </#if>
                </#list>
            </#if>
        </menu>
      <h3 class="tit">浏览记录</h3>
        <menu class="border-df">
            <#if recent_page??>
                <#list recent_page.content as item>
                <li>
                    <a href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" title="${item.goodsTitle!''}"/></a>
                    <a href="/goods/${item.goodsId?c}">${item.goodsTitle!''}</a>
                    <p class="fs18 red ta-c">￥<#if item.goodsSalePrice??>${item.goodsSalePrice?string("0.00")}</#if></p>
                </li>
                </#list>
            </#if>
        </menu>

  </section><!--column_left END-->
  
</div>
<div class="clear h40"></div>

<#include "/client/common_footer.ftl" />

</body>
</html>
