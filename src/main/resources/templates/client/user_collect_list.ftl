<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />

<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>

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
	
	mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
});
</script>
</head>
<body>
<#include "/client/common_header.ftl" />

<div class="myclear"></div>
<div class="mymember_out">
<div class="mymember_main">
    
    <!--mymember_head END-->
    <div class="myclear" style="height:20px;"></div>
  
    <#-- 左侧菜单 -->
    <#include "/client/common_user_menu.ftl" />
    <#-- 左侧菜单结束 -->
    
    <form name="form1" action="/user/collect/list" method="POST">  
<script type="text/javascript">
var theForm = document.forms['form1'];
if (!theForm) {
    theForm = document.form1;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.submit();
    }
}
</script>
    <div class="mymember_mainbox">
        <div class="mymember_info mymember_info02">
            <div class="mymember_order_search"> 
                <a class="a001" href="/user/collect/list">关注商品</a>
                <input class="mysub" type="submit" value="查询">
                <input class="mytext" type="text" name="keywords" onfocus="if(value=='商品名称') {value=''}" onblur="if (value=='') {value='商品名称'}" value="${keywords!'商品名称'}">
                <div class="clear"></div>
            </div>
            <table>
                <tr class="mymember_infotab_tit01">
            <th colspan="3">商品</th>
            <th width="80">金额</th>
          <#-->  <th width="80">库存</th> -->
            <th width="70">操作</th>
                </tr>
                <#if collect_page??>
                    <#list collect_page.content as cg>
                        <tr id="tr_1424195166">
                       	    <td width=10><input id="yu_1424195166" name="r" type="checkbox" value="1424195166" class="check" onClick="cancelCheck(1424195166)"/></td>
                            <td>
                                <a href="/goods/${cg.goodsId?c}" target="_blank">
                                    <strong><img width="100" height="100" src="${cg.goodsCoverImageUri!''}"></strong>
                                </a>
                            </td>
                            <td class="tb01">
                                <a href="/goods/${cg.goodsId?c}" target="_blank"  clstag="homepage|keycount|guanzhu|shangpin01">${cg.goodsTitle!''}</a>
                            </td>
                            <td class="tb02">￥${cg.goodsSalePrice?string("#.##")}</td>
                           <#--> <td>${cg.leftNumber!''}</td> -->
                            <td>
                                <p><a href="/cart/init?id=${cg.goodsId?c!''}" target="_blank">加入购物车</a></p>
                                <p><a href="/user/collect/del?id=${cg.goodsId?c!''}">取消关注</a></p>
                            </td>
                          </tr>
                    </#list>
                </#if>
            </table>
            <div class="myclear" style="height:10px;"></div>
            <div class="mymember_page">
                <#if collect_page??>
                    <#assign continueEnter=false>
                    <#if collect_page.totalPages gt 0>
                        <#list 1..collect_page.totalPages as page>
                            <#if page <= 3 || (collect_page.totalPages-page) < 3 || (collect_page.number+1-page)?abs<3 >
                                <#if page == collect_page.number+1>
                                    <a class="mysel" href="javascript:;">${page}</a>
                                <#else>
                                    <a href="/user/collect/list?page=${page-1}&keywords=${keywords!''}">${page}</a>
                                </#if>
                                <#assign continueEnter=false>
                            <#else>
                                <#if !continueEnter>
                                    <b class="pn-break">&hellip;</b>
                                    <#assign continueEnter=true>
                                </#if>
                            </#if>
                        </#list>
                    </#if>
                </#if>
            </div>
        </div>
        
        <div class="mymember_info">
      <h3 id="mymember_likecheck">
        <#if reco_page0??>
        	<a class="mysel" href="/list/${categoryId0!'' }" title="进入“${categoryTitle0!''}”商品分类">&nbsp;</a>
        </#if>
        <#if reco_page1??>
        	<a href="/list/${categoryId1!'' }" title="进入“${categoryTitle1!''}”商品分类">&nbsp;</a>
        </#if>        
        <#if reco_page2??>
        	<a href="/list/${categoryId2!'' }" title="进入“${categoryTitle2!''}”商品分类">&nbsp;</a>
        </#if>
        <span>猜你喜欢</span>  
      </h3>
      <ul id="mymember_likelist">
          <li>
          	  <#if reco_page0??>
	              <#list reco_page0.content as item>
	              	<#if item_index lt 4>
			          <a href="/goods/${item.id?c!''}" title="${item.subTitle!'' }">
			          <img src="${item.coverImageUri!'' }" width="208" height="208"/>
			           <p>${item.title!'' }</p>
			           <p>￥<span>${item.salePrice?string(0.00)!'' }</span></p>						
			           <i>已售${item.soldNumber!'' }件</i>
			          </a>
			          </#if>
	          	  </#list>
              </#if>
        </li>
        <li>
          	  <#if reco_page1??>
	              <#list reco_page1.content as item>
	              	<#if item_index lt 4>
			          <a href="/goods/${item.id?c!'' }">
			          <img src="${item.coverImageUri!'' }"width="208" height="208" />
			           <p>${item.title!'' }</p>
			           <p>￥<span>${item.salePrice?string(0.00)!'' }</span></p>						
			           <i>已售${item.soldNumber!'' }件</i>
			          </a>
			       </#if>   
	          	  </#list>
              </#if>
        </li>
        <li>
          	  <#if reco_page2??>
	              <#list reco_page2.content as item>
	              	<#if item_index lt 4>
			          <a href="/goods/${item.id?c!'' }">
			          <img src="${item.coverImageUri!'' }" width="208" height="208"/>
			           <p>${item.title!'' }</p>
			           <p>￥<span>${item.salePrice?string(0.00)!'' }</span></p>						
			           <i>已售${item.soldNumber!'' }件</i>
			          </a>
			        </#if>  
	          	  </#list>
              </#if>
        </li>
      </ul>
      <div class="myclear"></div>
    </div><!--mymember_info END-->
<script type="text/javascript">
$(document).ready(function(){
    mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
});
</script>


    </div>
    </form>
    <div class="myclear"></div>
          <#include "/client/user_maylike.ftl" />
</div>

<!--mymember_main END-->
<div class="myclear"></div>
  
</div>
         
<!--mymember END-->

<#include "/client/common_footer.ftl" />

</div>
</body>
</html>