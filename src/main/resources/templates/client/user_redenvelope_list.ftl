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
    
    <form name="form1" action="/user/redenvelope/list" method="POST">  
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
                <a class="a001" href="/user/redenvelope/list">红包列表</a>
               <select name="statusId" onchange="javascript:location.href=this.value;">
                    <option value="/user/redenvelope/list/?statusId=0" <#if !status_id?? || status_id==0>selected="selected"</#if>>所有红包</option>
                    <option value="/user/redenvelope/list/?statusId=1" <#if status_id==1>selected="selected"</#if>>未拆开红包</option>
                    <option value="/user/redenvelope/list/?statusId=2" <#if status_id==2>selected="selected"</#if>>已拆开红包</option> 
                </select>
                <div class="clear"></div>
            </div>
            <table>
                <tr class="mymember_infotab_tit01">
            <th colspan="3">红包</th>
            <th width="80">奖励</th>
            <th width="80">发放日期</th>
            <th width="80">领取日期</th>
            <th width="70">操作</th>
                </tr>
                <#if redenvelope_page??>
                    <#list redenvelope_page.content as item>
                        <tr id="tr_1424195166">
                            <td width=10>${item_index}</td>
                            <td class="tb01">
                                <a href="#" target="_blank"  clstag="homepage|keycount|guanzhu|shangpin01">${item.typeTitle!''}</a>
                            </td>
                            <td>
                                <a href="#" target="_blank">
                                    <strong><img width="200" height="100" src="${item.picUri!''}"></strong>
                                </a>
                            </td>                           
                            <#if item.isGet?? && item.isGet>
                                <#if item.redEnvelopeType == 0>
                                        <td>奖励积分${item.prizePoints!''}</td>
                                <#elseif item.redEnvelopeType == 1>
                                        <td><a href="#">${item.couponTitle!''}</a></td>
                                <#elseif item.redEnvelopeType == 2>
                                        <td><a href="#">${item.goodsTitle!''}</a></td>
                                </#if>
                            <#else>
                                <td></td> 
                            </#if> 
                            <td class="tb02"><#if item.sendTime??>${item.sendTime?string("yyyy-MM-dd")}</#if></td>
                            <td class="tb02"><#if item.getTime??>${item.getTime?string("yyyy-MM-dd")}</#if></td>
                            <td>
                                <#if item.isGet>
                                    <p><a href="/user/redenvelope/edit?redenvelopeId=${item.id?c}" >查看</a></p>
                                <#else>
                                    <p><a href="/user/redenvelope/edit?redenvelopeId=${item.id?c}" >拆开</a></p>
                                </#if>
                            </td>
                          </tr>
                    </#list>
                </#if>
            </table>
            <div class="myclear" style="height:10px;"></div>
            <div class="mymember_page">
                <#if redenvelope_page??>
                    <#assign continueEnter=false>
                    <#if redenvelope_page.totalPages gt 0>
                        <#list 1..redenvelope_page.totalPages as page>
                            <#if page <= 3 || (redenvelope_page.totalPages-page) < 3 || (redenvelope_page.number+1-page)?abs<3 >
                                <#if page == redenvelope_page.number+1>
                                    <a class="mysel" href="javascript:;">${page}</a>
                                <#else>
                                    <a href="/user/redenvelope/list?page=${page-1}">${page}</a>
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