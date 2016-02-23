<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if goods??>${goods.seoTitle!''}-</#if>惠之店</title>

<meta name="keywords" content="${goods.seoKeywords!''}">
<meta name="description" content="${goods.seoDescription!''}">
<meta name="copyright" content="惠之店" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script> 
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/goods.js"></script>
<script src="/client/js/goods_comment_consult.js"></script>

<script src="/touch/js/jquery.swipebox.min.js"></script>

<link rel="stylesheet" href="/touch/css/swipebox.css">

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
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
            if (q < ${goods.leftNumber?c})
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
        var quantity = $("#quantity").val();
        
        if (isNaN(quantity) || quantity== "" ) { quantity = 1 }
         
        window.location.href="/order/buy/normal?gid=${goods.id?c}&quantity=" + quantity + "<#if shareId??>&shareId=${shareId}</#if>";     
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

function addContrastgoods(id){
    var goodsId= id;
    var categoryId = $("#goodscategoryId").val();
    
    $.ajax({
            type:"post",
            url:"/contrast/goods/add",
            data:{"goodsId":goodsId, "categoryId":categoryId},
            success:function(data){
                $("#contrastGoods").html(data);
            }
     });
}

function deleteContrastgoods(id){
    var goodsId= id;
    var categoryId = $("#goodscategoryId").val();
    
    $.ajax({
            type:"post",
            url:"/contrast/goods/delete",
            data:{"id":goodsId, "categoryId":categoryId},
            success:function(data){
                $("#contrastGoods").html(data);
            }
     });
}
</script>

</head>

<body>
<!-- 商品对比 -->
<div id ="contrastGoods">
    <#include "/client/contrast_goods.ftl" />
</div>

<#include "/client/common_header.ftl" />

<div class="clear h20"></div>
     <div class="main">
        <div class="weizhi">
        <span><a href="/">首页</a></span>
            >积分商品
            > <span>${goods.title!''}</span>
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
                   <!-- JiaThis Button BEGIN -->
                   <#-->      <div class="jiathis_style">
                        <a class="jiathis_button_qzone"></a>
                        <a class="jiathis_button_tsina"></a>
                        <a class="jiathis_button_tqq"></a>
                        <a class="jiathis_button_renren"></a>
                        <a class="jiathis_button_weixin"></a>
                        <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
                        </div>
                        <script type="text/javascript" >
                        var jiathis_config={
                            url:"http://116.55.230.207:8008/goods/${goods.id?c}<#if qiang??><#if user??>?qiang=${qiang?c}&shareId=${user.id?c}<#else>?qiang=${qiang?c}</#if><#else><#if user??>?shareId=${user.id?c}</#if></#if>",
                            summary:"",
                            title:"惠之店##${goods.title!''}",
                            shortUrl:false,
                            hideMore:false
                        }
                        </script>
                        <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                    <!-- JiaThis Button END -->
                    
                  <div class="bdsharebuttonbox" style="float:left;">
                    <a href="#" class="bds_more" data-cmd="more"></a>
                    <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                    <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                    <a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
                    <a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网">
                    </a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                  </div>
<script>
                window._bd_share_config={
                "common":{
                    "bdSnsKey":{},
                    "bdText":"惠之店##${goods.title!''}", bdUrl:"http://www.huizhidian.com/touch/", "bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},
                    "share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
                                       
                    <div class="clear"></div>
              </div>
        </section><!--proinfo_left END-->
    
    <section class="proinfo_right">
      <h3>${goods.title!''}</h3>
 <#-->     <input type="button" value="对比" onclick="addContrastgoods('${goods.id?c}')"> -->
 <#--     <a href="javascript:;" onclick="addContrastgoods('${goods.id?c}')" style="
                        position: absolute;
                        right: 163px;
                        background: #f0f0f0;
                        border: solid 1px#ccc;
                        padding: 9px 30px;
                        z-index: 2;
                        bottom: 5px;
                        border-radius: 20px;">对比</a> -->
      <input type="hidden" id="goodscategoryId" value="${goods.categoryId!''}">
      <h4 class="red">${goods.subTitle!''}</h4>

      <div class="pro_price">

              <span>兑换积分：</span>
              <span class="red fs24 lh30 mr20"><#if goods.pointUse??>${goods.pointUse?c}</#if>&nbsp积分</span>
         <#--     <span class="unl-th c9">￥：<#if goods.marketPrice??>${goods.marketPrice?string("0.00")}</#if></span> -->
              <p class="p1">
                  <span>服务信息：</span>
                  <span class="red">
                    ${goods.service!''}
                  </span>
              </p>
            
      </div><!--pro_price END-->

      <table class="pro_choose">
        
        <tr>
        <th>服务支持：</th>
         <td>
          <#if GoodsService_item_list??>                                                       
            <#list GoodsService_item_list as item>      
              <#if item_index < 4 >             
                <img src="${item.logo!''}" width="26" height="26" style="vertical-align:middle;float: left;">                                                                  
                <div style="height: 26px;display: inline-block;line-height: 30px;color:#333333;float: left;margin-right: 40px;margin-left: 10px;">${item.title!''}</div>                                 
              </#if>
            </#list>
          </#if>
          </td>
        </tr>
        <tr>
          <th>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</th>
          <td>
            <input name="quantity" disabled="disabled" type="text" id="quantity" value="1" class="text" />
            <div class="plus">
                <#if qiang?? && qiang==1 && goods.flashSaleStartTime < .now && goods.flashSaleStopTime gt .now>
                    <a id="" href="javascript:;">+</a>
                    <a id="" href="javascript:;">-</a>
                <#elseif qiang?? && qiang!=1 && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>
                    <a id="" href="javascript:;">+</a>
                    <a id="" href="javascript:;">-</a>
                <#else>
                    <a id="" href="javascript:;">+</a>
                    <a id="" href="javascript:;">-</a>
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

             <#if goods.leftNumber gt 0>
                    <a id="" href="/pointGoods/order/info?pointGoodsId=${goods.id?c}" class="sub">立即兑换</a>
                    <#--<input type="submit" class="sub sub01" onclick="javascript:buyNow()" value="立即购买" /> -->
             <#else>
                    <a id="" href="javascript:;" class="sub">库存不足</a>
             </#if>    

            <!--<input type="submit" class="sub" onclick="addCart()" value="加入购物车" />  -->
            <#---->
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
  
  <div class="column_right" style="margin-top:20px">
    <div class="detail_tit" id="detail_tit">
      <div class="out">
        <menu>
          <a href="#detail_tit" tid="0" class="sel stab">商品介绍</a>
          <a href="#detail_tit" tid="1" class="stab">规格参数</a>
          <a href="#detail_tit" tid="2" class="stab">售后服务</a>
          <div class="clear"></div>
        </menu>
      </div>
    </div><!--detail_tit END-->
    
    <div id="tab0" class="php_z">
        ${goods.detail!''}
    </div>
        
    <div id="tab1" class="php_z" style="display:none;">
        ${goods.paramDetail!''}
    </div>
    
    <div id="tab2" class="php_z" style="display:none;">
        ${goods.afterMarketService!''}
    </div>
    
    <div class="clear h10"></div>
    
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
