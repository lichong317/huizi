<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>惠资生活</title>
<title><#if goods??>${goods.seoTitle!''}-</#if>云南车有同盟商贸有限公司</title>
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
        
        $("#addCart").attr("href", "/cart/init?id=${goods.id}&quantity=" + $("#quantity").val() + "<#if goods.isGroupSale && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>&qiang=1</#if>");
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
        $("#addCart").attr("href", "/cart/init?id=${goods.id}&quantity=" + $("#quantity").val() + "<#if goods.isGroupSale && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>&qiang=1</#if>");
    
    });
});
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
            > <span><a href="/list/${category.id}">${category.title!""}</a></span>
        </#list>
    </#if>
    > <span>${goods.name!''}</span>
</div>
<div class="pro_box">
    <section class="proinfo_left">
      <menu id="proshowimg">
        <li><img src="/client/images/images/spxq_03.png" /></li>
        <li><img src="/client/images/images/spxq_03.png" /></li>
        <li><img src="/client/images/images/spxq_03.png" /></li>
        <li><img src="/client/images/images/spxq_03.png" /></li>
      </menu>
      <div class="clear h20"></div>
      <menu id="proshowmenu"></menu>
      <div class="clear h20"></div>
      
      <div class="pro_share">
        <span>分享：</span>
        <a href="#"><img src="/client/images/content/share01.png" /></a>
        <a href="#"><img src="/client/images/content/share02.png" /></a>
        <a href="#"><img src="/client/images/content/share03.png" /></a>
        <a href="#"><img src="/client/images/content/share04.png" /></a>
        <a href="#"><img src="/client/images/content/share05.png" /></a>
        <span class="ml20">商品编号：06001</span>
        <a class="a1" href="javascript:addCollect(${goods.id});">关注该商品</a>
        <div class="clear"></div>
      </div>
    </section><!--proinfo_left END-->
    
    <section class="proinfo_right">
      <h3>${goods.title!''}</h3>
      <h4 class="red">${goods.subTitle!''}</h4>
      <div class="pro_price">
        <p class="p1">
          <span>价格：</span>
          <span class="red fs24 lh30 mr20">￥<#if goods.salePrice??>${goods.salePrice?string("0.00")}</#if></span>
        </p>
        <p class="p1">
          <span>服务：</span>
          <span class="red">${goods.service!''}</span>
        </p>
        
      </div><!--pro_price END-->
      <table class="pro_choose">
        <#if total_select??>
            <#if 1==total_select>
                <tr>
                  <th>${select_one_name!''}：</th>
                  <td>
                    <#if select_one_goods_list??>
                    <#list select_one_goods_list as item>
                        <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="/goods/${item.id}">${item.selectOneValue}</a>
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
                            <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="/goods/${item.id}">${item.selectOneValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_two_name!''}</th>
                    <td>
                        <#if select_two_goods_list??>
                        <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="sel"</#if> href="/goods/${item.id}">${item.selectTwoValue}</a>
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
                            <a <#if item.selectOneValue==one_selected>class="sel"</#if> href="/goods/${item.id}">${item.selectOneValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_two_name!''}</th>
                    <td>
                        <#if select_two_goods_list??>
                        <#list select_two_goods_list as item>
                            <a <#if item.selectTwoValue==two_selected>class="sel"</#if> href="/goods/${item.id}">${item.selectTwoValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <th>${select_three_name!''}</th>
                    <td>
                        <#if select_three_goods_list??>
                        <#list select_three_goods_list as item>
                            <a <#if item.selectThreeValue==three_selected>class="sel"</#if> href="/goods/${item.id}">${item.selectThreeValue}</a>
                        </#list>
                        </#if>
                    </td>
                </tr>
            </#if>
        </#if>
        <tr>
          <th>服务支持：</th>
          <td>
            <a class="a1" href="javascript:;">上门安装</a>
            <a class="a1 a2" href="javascript:;">无忧退换货</a>
            <a class="a1 a3" href="javascript:;">全国联保</a>
            <div class="clear"></div>
          </td>
        </tr>
        <tr>
          <th>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</th>
          <td>
            <input name="quantity" type="text" id="quantity" value="1" class="text" />
            <div class="plus">
                <a id="id-plus" href="javascript:;">+</a>
                <a id="id-minus" href="javascript:;">-</a>
            </div>
            <div class="clear"></div>
          </td>
        </tr>
        <tr>
          <th></th>
          <td>
            <input type="submit" class="sub" value="加入购物车" />
            <a id="addCart" href="/cart/init?id=${goods.id}<#if goods.isGroupSale && goods.groupSaleStartTime < .now && goods.groupSaleStopTime gt .now>&qiang=1</#if>">加入购物车</a>
            <div class="clear"></div>
          </td>
        </tr>
      </table>
      
      <div class="sys">
        <p><img src="/client/images/images/spxq_06.png" /></p>
        <p class="pt5">关注官方微信<br />获10元优惠码</p>
      </div>
    </section><!--proinfo_right END-->
    <div class="clear h20"></div>
  </div>
  <section class="pro_assort">
    <menu id="assort_menu">
      <a class="sel" href="#">推荐配套</a>
      <div class="clear"></div>
    </menu>
    <ul id="assort_sum">
      <li>
        <#if goods.combList?? && goods.combList?size gt 0>
            <#list goods.combList as item>
                <div class="part">
                    <a href="/goods/${item.goodsId}"><img src="${item.coverImageUri!''}" width="114" height="114"/></a>
                    <p style="height: 40px; overflow: hidden;">${item.goodsTitle!''}</p>
                    <p class="p1">
                        <input type="checkbox" class="comb-current-price"/>
                        <span>${item.currentPrice?string("0.00")}</span>
                    </p>
                </div>
                <#if item_index+1 < comb_list?size>
                    <p class="part"><img src="/client/images/content/pro_plus.png" /></p>
                </#if>
            </#list>
        </#if>
        

        <div class="part01">
          <p>搭配价：￥<span class="red">2350.00</span></p>
          <p>参考价：<span class="unl-th">￥2500.00</span></p>
          <input class="sub" type="submit" value="立即购买" />
        </div>
        <div class="clear"></div>
      </li>
    </ul>
    <div class="clear"></div>
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
    
    <section class="pro_mytext" id="pro_mytext">
        <#if username??>
            <form id="commentForm" action="javascript:submitComment();">
                <input type="hidden" name="goodsId" value=${goods.id} />
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
                <input type="hidden" name="goodsId" value=${goods.id} />
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
                        <a class="scan" href="/goods/${item.id}">
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
                    <a href="/goods/${item.goodsId}"><img src="${item.goodsCoverImageUri!''}" title="${item.goodsTitle!''}"/></a>
                    <a href="/goods/${item.goodsId}">${item.goodsTitle!''}</a>
                    <p class="fs18 red ta-c">￥<#if item.goodsSalePrice??>${item.goodsSalePrice?string("0.00")}</#if></p>
                </li>
                </#list>
            </#if>
        </menu>

  </section><!--column_left END-->
  
</div>
<div class="clear h40"></div>

<#include "/client/common_footer.ftl" />

</div>

</body>
</html>
