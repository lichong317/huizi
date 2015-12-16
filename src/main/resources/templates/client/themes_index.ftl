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
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
<link href="/client/style/channel.css" rel="stylesheet" type="text/css" />
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

function checkTime(i)  
{  
    if (i < 10) {  
        i = "0" + i;  
    }  
    return i;  
}

</script>
</head>
<boby>
    <!--最顶部-->
    <#include "/client/themes_header.ftl" />
    
    <div class="clear h20"></div>
    
    <!--liebiaoye-->
    <div class="main">
        <div class="left" style="margin-top:-24px;">
            <div id="sortlist" class="m">
            <#-->    <div class="mt">
                    <h2><#if top_cat??>${top_cat.title!''}</#if></h2>
                </div>  -->
                <div class="mc">
                    <#if second_level_cat_list??>
                        <#list second_level_cat_list as secondcat>
                            <#if secondcat_index < 6>
                                 <div class="item fore1">
                                    <h3> <s class="i1"></s><a href="/list/${secondcat.id?c}">${secondcat.title!''}</a> </h3>
                                    <div class="con">
                                        <#if ("third_level_" + secondcat_index + "_cat_list")?eval??>
                                            <#list ("third_level_" + secondcat_index + "_cat_list")?eval as thirdcat>
                                                <#if thirdcat_index < 4>
                                                    <a href="/list/${thirdcat.id?c}" title="${thirdcat.title!''}">${thirdcat.title!''}</a> 
                                                </#if>
                                            </#list>
                                        </#if>                                        
                                        
                                    </div>
                                </div>
                            </#if>
                        </#list>
                        <span class="clr"></span> 
                    </#if>                   
                </div>
            </div>
        </div>
        <div class="flmiddle">
            <div class="fenleibanner"> 
                <i style="background:#FFF; width:20px; position:absolute; right:5px; border-radius:50%; bottom:5px; text-indent:4px; z-index:1;}"><a href="#">3</a></i> 
                <i style="background:#FFF; width:20px; position:absolute; right:35px; border-radius:50%; bottom:5px; z-index:1; text-indent:4px;}"><a href="#">2</a></i> 
                <i style="background:#FFF; width:20px; position:absolute; right:65px; border-radius:50%; bottom:5px; z-index:1; text-indent:4px;}"><a href="#">1</a></i> 
                <a href="#"><img src="/client/images/themes/565d413eN682e4375.jpg" width="730" height="270" /></a> 
            </div>
            <div class="clear10"></div>
            <div class="fllb">              
                <ul>
                    <#if index_sale_list??>
                    <#list index_sale_list as item>
                        <#if item_index < 4>
                            <li class="flsel">${item.categoryTitle!''}</li>
                        </#if>
                    </#list>
                    </#if>
                </ul>
            </div>
            <div class="flspzs">
                <ul>
                    <#if index_sale_list??>
                    <#list index_sale_list as item>
                        <#if item_index < 4>
                            <li> <a href="/goods/${item.id?c}"><img src="${item.coverImageUri!''}" width="160" height="160" /></a>
                            <div class="clear20"></div>
                            <p ><a href="/goods/${item.id?c}">${item.title!''}</a></p>
                            <span class="red">¥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></span> </li>
                        </#if>
                    </#list>
                    </#if>
                   
                </ul>
            </div>
        </div>
        <div class="right">
            <div class="tongzhia">
                <h4 style="text-indent:12px;">惠资讯</h4>
                <ul>
                    <#if latest_news_page??>
                        <#list latest_news_page.content as item>
                            <#if item_index < 4>
                                 <#if item.title?length lt 21>
                                    <li><a href="/info/content/${item.id?c}?mid=${item.menuId?c}">${item.title?default("")}</a></li>
                                     <#else>
                                    <li><a href="/info/content/${item.id?c}?mid=${item.menuId?c}" title="${item.title}">
                                    <#if item.title?length lt 18>
                                        ${item.title!''}
                                    <#else>
                                        ${item.title[0..17]?default("")}...
                                    </#if>
                                    </a></li>
                                 </#if>
                            </#if>
                        </#list>
                    </#if>
                   
                </ul>
                <div class="pssm"><a href="#"><img src="/client/images/themes/20120921B.jpg" width="244" height="44" /></a></div>
            </div>
            <div class="xianshiqg">
                <h4 style="line-height:32px; text-indent:12px;">限时抢购</h4>
                <#if miao_goods_page??>
                    <#list miao_goods_page.content as item>
                        <#if item_index < 2>
<script>
$(document).ready(function(){
    <#if item.flashSaleStartTime gt .now>
        $("#timeLeft${item_index}").html("尚未开始");
    <#elseif item.flashSaleStopTime < .now>
        $("#timeLeft${item_index}").html("已经结束");
    <#else>
        setInterval("timer${item_index}()",1000);        
    </#if>
});

function timer${item_index}()
{
<#if item.isFlashSale && item.flashSaleStartTime < .now && item.flashSaleStopTime gt .now>
    var ts = (new Date(${item.flashSaleStopTime?string("yyyy")}, 
                parseInt(${item.flashSaleStopTime?string("MM")}, 10)-1, 
                ${item.flashSaleStopTime?string("dd")}, 
                ${item.flashSaleStopTime?string("HH")}, 
                ${item.flashSaleStopTime?string("mm")}, 
                ${item.flashSaleStopTime?string("ss")})) - (new Date());//计算剩余的毫秒数
                
    var allts = (new Date(${item.flashSaleStopTime?string("yyyy")}, 
                parseInt(${item.flashSaleStopTime?string("MM")}, 10)-1, 
                ${item.flashSaleStopTime?string("dd")}, 
                ${item.flashSaleStopTime?string("HH")}, 
                ${item.flashSaleStopTime?string("mm")}, 
                ${item.flashSaleStopTime?string("ss")}))
               - (new Date(${item.flashSaleStartTime?string("yyyy")}, 
                parseInt(${item.flashSaleStartTime?string("MM")}, 10)-1, 
                ${item.flashSaleStartTime?string("dd")}, 
                ${item.flashSaleStartTime?string("HH")}, 
                ${item.flashSaleStartTime?string("mm")}, 
                ${item.flashSaleStartTime?string("ss")}));//总共的毫秒数
                
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
    // 不显示天数
    hh = hh + dd * 24;
    $("#timeLeft${item_index}").html("剩余<span>" + hh + "</span>"
                                     +"小时<span>"+ mm + "</span>"
                                     +"分<span>"+ ss + "</span>秒");
                    
    
</#if>
}
</script>                        
                          <div class="xsqgone">
                            <p id="timeLeft${item_index}">剩余<span>0</span>小时<span>0</span>分<span>0</span>秒</p>
                            <a href="/goods/${item.id?c}?qiang=1"><img src="${item.groupSaleImage!''}" width="100" height="100" /></a>
                            <p style="line-height:24px; height:24px; overflow:hidden; padding:0 10px;"><a href="/goods/${item.id?c}?qiang=1">${item.title!''}</a></p>
                            <span style="color:#ff4454;">¥<#if item.flashSalePrice??>${item.flashSalePrice?string("0.00")}</#if></span> </div>       
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
        <div class="clear20"></div>
        <div class="pplb">
            <ul>
                <#if brand_list??>
                    <#list brand_list as brand>
                        <#if brand_index < 10>
                            <li><a href="/list/${categoryId!'0'}-${brand_index+1}"><img src="${brand.logoUri!''}" width="90" height="28" /></a></li>
                        </#if>
                    </#list>
                </#if>
                
            </ul>
        </div>
        <div class="clear20"></div>
        <div class="flgg">
            <ul>
                <li><a href="#"><img src="/client/images/themes/565f0c78Nd33650a5.jpg" width="390" height="70" /></a></li>
                <li><a href="#"><img src="/client/images/themes/565f0c78Nd33650a5.jpg" width="390" height="70" /></a></li>
                <li><a href="#"><img src="/client/images/themes/565f0c78Nd33650a5.jpg" width="390" height="70" /></a></li>
            </ul>
        </div>
        <div class="clear30"></div>
        <#if second_level_cat_list??>
            <#list second_level_cat_list as item>
                <div class="fllc">           
                    <div class="fllt">
                        <div class="fllcbtlt">
                            <h2>${item.title!''}</h2>
                            <div class="extra">
                                <#if ("third_level_" + item_index + "_cat_list")?eval??>
                                    <#list ("third_level_" + item_index + "_cat_list")?eval as thirdcat>
                                        <#if thirdcat_index < 10>
                                            <a title="${thirdcat.title!''}" href="/list${thirdcat.id?c}">${thirdcat.title!''}</a>
                                        </#if>
                                    </#list>                                   
                                </#if> 
                            </div>
                        </div>
                        <#if ("second_level"+ item_index +"_hot_list")?eval??>
                            <#list ("second_level"+ item_index +"_hot_list")?eval as secondgoods>
                                <#if secondgoods_index < 1>
                                        <div class="fllcleft"> <a href="/goods/${secondgoods.id?c}"><img src="${secondgoods.coverImageUri!''}" width="280" height="280" /></a>
                                            <div class="p-info">
                                                <div class="p-name"><a href="/goods/${secondgoods.id?c}" style="">${secondgoods.title!''}</a></div>
                                                <div class="p-price" sku="2178830"><strong>￥<#if secondgoods.salePrice??>${secondgoods.salePrice?string("0.00")}</#if></strong></div>
                                                <div class="p-market"></div>
                                                <div class="p-sale">热卖</div>
                                                <div class="goumai"><a href="/goods/${secondgoods.id?c}">立即购买</a></div>
                                            </div>
                                        </div>                                                                                                            
                                </#if>
                            </#list>
                        </#if>
                        <div class="fllclert">
                            <ul style="margin-left:7px;">
                                <#if ("second_level"+ item_index +"_hot_list")?eval??>
                                    <#list ("second_level"+ item_index +"_hot_list")?eval as secondgoods>
                                        <#if secondgoods_index gt 0 && secondgoods_index < 7>
                                            <li> <a href="/goods/${secondgoods.id?c}"><img src="${secondgoods.coverImageUri!''}" width="130" height="130" />
                                            <p>${secondgoods.title!''}</p>
                                            <span class="red">¥<#if secondgoods.salePrice??>${secondgoods.salePrice?string("0.00")}</#if></span></a> </li>
                                        </#if>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                </div>
                <div class="flrt">
                    <div class="flrtbt">
                        <h4>排行榜</h4>
                    </div>
                    <ul class="tabcon" data-widget="tab-content" >
                        <#if ("second_level"+ item_index +"_sale_list")?eval??>
                            <#list ("second_level"+ item_index +"_sale_list")?eval as goods>
                                <#if goods_index < 3>
                                     <li class="fore1 fore"><span class="i1">1</span>
                                        <div class="p-img"><a href="/goods/${goods.id?c}" title="${goods.title!''}"><img width="50" height="50" alt="${goods.title!''}" data-img="1" src="${goods.coverImageUri!''}" class="err-product" ks_mark="y"></a></div>
                                        <div class="p-name"><a href="/goods/${goods.id?c}" target="_blank" title="${goods.title!''}">${goods.title!''}</a><font class="1978056" color="#ff6600"></font></div>
                                        <div class="p-price" sku="1978056"><strong>￥<#if goods.salePrice??>${goods.salePrice?string("0.00")}</#if></strong></div>
                                    </li>
                                </#if>
                            </#list>
                        </#if>                      
                    </ul>
                    <div class="flrtgg">
                    <img src="/client/images/themes/565722feN7e4d3f7a.jpg" width="248" height="140" />
                    </div>
                </div>
            </div>
            <div class="clear30"></div>
            </#list>            
        </#if>
        
        <#if categoryId?? && categoryId == 7>
        <div class="clear30"></div>
        <div class="flsxk">
            <h4>厨卫电器</h4>
            <div class="flsxkkk">
                <ul>
                    <li>
                    <a href="/list/299">
                    <img src="/client/images/themes/cat_04.jpg" width="100" height="100" />
                    <p>热水器</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/298">
                    <img src="/client/images/themes/cat_02.jpg" width="100" height="100" />
                    <p>烟灶</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/294">
                    <img src="/client/images/themes/cat_05.jpg" width="100" height="100" />
                    <p>洗衣机</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/301">
                    <img src="/client/images/themes/cat_03.jpg" width="100" height="100" />
                    <p>冰箱</p>
                    </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="flsxk">
        <h4>家装精选</h4>
            <div class="flsxkkk">
                <ul>
                    <li>
                    <a href="/list/292">
                    <img src="/client/images/themes/hzd_28.png" width="100" height="100" />
                    <p>电视</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/293">
                    <img src="/client/images/themes/cat_01.jpg" width="100" height="100" />
                    <p>空调</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/35">
                    <img src="/client/images/themes/cat_10.jpg" width="100" height="100" />
                    <p>配件</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/295">
                    <img src="/client/images/themes/cat_06.jpg" width="100" height="100" />
                    <p>家庭影院</p>
                    </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="flsxk">
            <h4>智能生活</h4>
            <div class="flsxkkk">
                <ul>
                    <li>
                    <a href="/list/307">
                    <img src="/client/images/themes/cat_11.png" width="100" height="100" />
                    <p>扫地机器人</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/297">
                    <img src="/client/images/themes/cat_08.jpg" width="100" height="100" />
                    <p>音响</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/296">
                    <img src="/client/images/themes/cat_09.jpg" width="100" height="100" />
                    <p>DVD播放机</p>
                    </a>
                    </li>
                    <li>
                    <a href="/list/300">
                    <img src="/client/images/themes/cat_07.jpg" width="100" height="100" />
                    <p>消毒柜</p>
                    </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="zxzs">
            <h4>装修馆知识</h4>
                <ul>
                	<#if fitment_page??>
                		<#list fitment_page.content as item>
                			<#if item_index < 9>
                				<li>
			                    <a href="/info/content/${item.id?c}?mid=${item.menuId?c}">
			                    <p>${item.title!''}</p>
			                    </a>
			                    </li>
                			</#if>
                		</#list>
                	</#if>
                   
                </ul>
        </div>
        </#if>
        <div class="clear30"></div>
        
    <#-->
        <div class="fljpsd">
        <h4>精品晒单</h4>
        <ul>
        <li>
        <a href="#">
        <img src="images/5643f3d3N95cb0393.jpg" width="160" height="160" />
        <p>好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了</p>
        </a>
        </li>
        <li>
        <a href="#">
        <img src="images/5643f3d3N95cb0393.jpg" width="160" height="160" />
        <p>好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了</p>
        </a>
        </li>
        <li>
        <a href="#">
        <img src="images/5643f3d3N95cb0393.jpg" width="160" height="160" />
        <p>好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了</p>
        </a>
        </li>
        <li>
        <a href="#">
        <img src="images/5643f3d3N95cb0393.jpg" width="160" height="160" />
        <p>好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了</p>
        </a>
        </li>
        <li>
        <a href="#">
        <img src="images/5643f3d3N95cb0393.jpg" width="160" height="160" />
        <p>好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了</p>
        </a>
        </li>
        <li>
        <a href="#">
        <img src="images/5643f3d3N95cb0393.jpg" width="160" height="160" />
        <p>好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了好的不得了</p>
        </a>
        </li>
        </ul>
        </div>
        <div class="clear"></div>-->
                    </div>
    <div class="clear h40"></div> 
    <#include "/client/common_footer.ftl" />
</boby>
</html>