<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠资生活</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<#--
图片 -->
<script type="text/javascript" src="/mag/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.queue.js"></script>
<script type="text/javascript" src="/client/js/swfupload.imghandlers.js"></script>

<style>
/*上传样式*/
.upload-box{float:left;margin-left:20%; background:rgb(255,68,4);color:#fff;position:relative; display:inline-block; height:32px; line-height:32px;vertical-align:middle; *display:inline;overflow: hidden;}
.upload-box .upload-btn{ width: 100px;color:#fff;
height:32px; 
line-height:32px; 
background-color: #e6e6e6;
cursor: pointer;
font-size: 14px;
font-weight:bold;
background: url(skin_icons.png) 0px -834px no-repeat;
text-align:center;
position:relative;
padding-top:4px;
}
	.upload-box .upload-progress{ position:absolute; top:0; left:0; padding:2px 5px; width:115px; height:26px; border:1px solid #d7d7d7; background:#fff; overflow:hidden; }
	.upload-box .upload-progress .txt{ display:block; padding-right:10px; font-weight:normal; font-style:normal; font-size:11px; line-height:18px; height:18px; text-overflow:ellipsis; overflow:hidden; }
	.upload-box .upload-progress .bar{ position:relative; display:block; width:112px; height:4px; border:1px solid #1da76b; }
	.upload-box .upload-progress .bar b{ display:block; width:0%; height:4px; font-weight:normal; text-indent:-99em; background:#28B779; overflow:hidden; }
	.upload-box .upload-progress .close{position:absolute; display:block; top:1px; right:1px; width:14px; height:14px; text-indent:-99em; background:url(skin_icons.png) -112px -168px no-repeat; cursor:pointer; overflow:hidden; }
.upload-box .upload-btn:hover{background-color:rgb(52,153,217);}
.photo-list_show360 ul{margin-top:75px;}
.photo-list_show360 ul li{width:110px;height:130px;float:left;}
.photo-list_show360 img{width:100px;height:100px;}
</style>

<!--[if IE]>
   <script src="/client/js/html5.js"></script>
<![endif]-->
<!--[if IE 6]>
<script type="text/javascript" src="/client/js/DD_belatedPNG_0.0.8a.js" ></script>
<script>
DD_belatedPNG.fix('.,img,background');
</script>
<![endif]-->
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
    
  //初始化上传控件
    $(".upload-show360").each(function () {
        $(this).InitSWFUpload_show360({ 
            btntext: "上传图片",
            btnwidth: 66,
            btnstyle:".btnText{font-family: 微软雅黑; font-size: 14px;line-height:32px;color:#ffffff;text-align:center;}",
            single: false, 
            water: true, 
            thumbnail: true, 
            filesize: "5120", 
            sendurl: "/user/upload", 
            flashurl: "/mag/js/swfupload.swf", 
            filetypes: "*.jpg;*.jpge;*.png;*.gif;" 
        });
    });
});

function showCommentTr(i, j)
{
    $("#comment-tr" + i + j).toggleClass("hide");
}


function commentJump()
{
    window.location.href="/user/comment/list?statusId=" + $("#commentTypeSelect").val();
}
</script>
</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->

<div class="myclear"></div>
<div class="mymember_out">
<div class="mymember_main">
  <!--mymember_head END-->
  <div class="myclear" style="height:20px;"></div>
    <#-- 左侧菜单 -->
    <#include "/client/common_user_menu.ftl" />
    <#-- 左侧菜单结束 -->
    
  <div class="mymember_mainbox">

    <div class="mymember_info">
      <div class="mymember_order_search">
        <a class="a001" href="/user/comment/list">商品评价/晒单</a>
        
        <select id="commentTypeSelect" onchange="javascript:commentJump();">
            <option value="0" <#if statusId==0>selected="selected"</#if>>待评价</option>
            <option value="1" <#if statusId==1>selected="selected"</#if>>已评价</option>                          
        </select>
      </div>
      
        <table class="mymember_evaluate">
            <tr>
                <th colspan="2">商品信息</th>
                <th width="200">购买时间</th>
                <th width="200">评价状态</th>
            </tr>
            <#if order_page??>
                <#list order_page.content as order>
                    <#if order.orderGoodsList??>
                        <#list order.orderGoodsList as item>
                            <tr>
                                <td class="td001" width="70">
                                   <a href="/goods/${item.goodsId?c}">
                                        <img src="${item.goodsCoverImageUri!''}" width="50" height="50" title="${item.goodsTitle!''}">
                                   </a>                                       
                                </td>
                                <td class="td002">
                                   <a target="_blank" href="/goods/${item.goodsId?c}">${item.goodsTitle!''}</a>
                                </td>
                                <td>
                                    ${order.orderTime?string("yyyy-MM-dd")}  
                                </td>
                                <td class="td003">
                                    <#if item.isCommented?? && item.isCommented>
                                        <a href="javascript:showCommentTr(${order_index}, ${item_index});">已评价</a>
                                    <#else>
                                        <a href="javascript:showCommentTr(${order_index}, ${item_index});">发表评价</a>
                                    </#if>
                                </td>
                            </tr>
                            <#if item.isCommented?? && item.isCommented>
                                <#if ("comment_" + order.id + "_" + item.id)?eval??>
                                    <#assign comt=("comment_" + order.id + "_" + item.id)?eval>
                                    <tr id="comment-tr${order_index}${item_index}" class="hide">
                                        <td class="td004" colspan="4">
                                            <span style="position:absolute;right:88px;top:-13px;">
                                                <img src="/client/images/mymember/arrow06.gif">
                                            </span>
                                            <#if comt.reply?? && comt.reply != "">
                                            	<div class="mymember_eva_div">
						                       	  	<b><font>* </font>商家回复：</b>
						                       	  	<textarea disabled="disabled">${comt.reply!''}</textarea>
						                       	</div>  	
					                       	</#if>	
                                            <div class="mymember_eva_div">
                                              <b><font>* </font>评分：</b>
                                              <div class="myclear"></div>
                                              <a class="a001" href="javascript:;"><img src="/client/images/mymember/<#if comt.goodsStar?? && comt.goodsStar gt 0>star02.png<#else>star01.png</#if>"></a>
                                              <a class="a001" href="javascript:;"><img src="/client/images/mymember/<#if comt.goodsStar?? && comt.goodsStar gt 1>star02.png<#else>star01.png</#if>"></a>
                                              <a class="a001" href="javascript:;"><img src="/client/images/mymember/<#if comt.goodsStar?? && comt.goodsStar gt 2>star02.png<#else>star01.png</#if>"></a>
                                              <a class="a001" href="javascript:;"><img src="/client/images/mymember/<#if comt.goodsStar?? && comt.goodsStar gt 3>star02.png<#else>star01.png</#if>"></a>
                                              <a class="a001" href="javascript:;"><img src="/client/images/mymember/<#if comt.goodsStar?? && comt.goodsStar gt 4>star02.png<#else>star01.png</#if>"></a>
                                              <div class="myclear"></div>
                                            </div>
   
                                            <div class="mymember_eva_div">
                                              <b><font>* </font>评价：</b>
                                              <textarea disabled="disabled">${comt.content!''}</textarea>
                                              <#if comt?? && comt.showPictures??>
					                            <#list comt.showPictures?split(",") as uri>
					                                <#if uri != "">
					                                <li style="width:110px;height:110px;float:left;">
					                                    <input type="hidden" name="hid_photo_name_show360" value="0|${uri!""}|${uri!""}">
					                                    <div class="img-box">
					                                        <img style="margin-top:10px;width:100px;height:100px;" src="${uri!""}" bigsrc="${uri!""}">
					                                    </div>
					                                </li>
					                                </#if>
					                            </#list>
					                       	  </#if>
                                            </div>
                                        </td>
                                    </tr>
                                </#if>
                            <#else>
                            <tr id="comment-tr${order_index}${item_index}" class="hide">
                                        <td class="td004" colspan="4">
                                          <span style="position:absolute;right:88px;top:-13px;"><img src="/client/images/mymember/arrow06.gif" /></span>
                                          <form class="commentForm${order_index}${item_index}" action="/user/comment/add" method="post">
                                          <input type="hidden" name="orderId" value=${order.id?c} />
                                          <input type="hidden" name="ogId" value=${item.id?c} />
                                          <input type="hidden" name="goodsId" value=${item.goodsId?c} />

                                            <div class="mymember_eva_div">
                                              <b><font>* </font>评分：</b>
                                              <div class="myclear"></div>
                                              <input id="goodsStar${order_index}${item_index}" name="goodsStar" type="hidden" value="1" datatype="n" nullmsg="请点击进行评价"/>
                                              <a class="goodsStar${order_index}${item_index} a001" href="javascript:starChange${order_index}${item_index}('goodsStar', 1);"><img src="/client/images/mymember/star01.png"></a>
                                              <a class="goodsStar${order_index}${item_index} a001" href="javascript:starChange${order_index}${item_index}('goodsStar', 2);"><img src="/client/images/mymember/star01.png"></a>
                                              <a class="goodsStar${order_index}${item_index} a001" href="javascript:starChange${order_index}${item_index}('goodsStar', 3);"><img src="/client/images/mymember/star01.png"></a>
                                              <a class="goodsStar${order_index}${item_index} a001" href="javascript:starChange${order_index}${item_index}('goodsStar', 4);"><img src="/client/images/mymember/star01.png"></a>
                                              <a class="goodsStar${order_index}${item_index} a001" href="javascript:starChange${order_index}${item_index}('goodsStar', 5);"><img src="/client/images/mymember/star01.png"></a>
                                              <div class="myclear"></div>
                                            </div>
                                            <div class="mymember_eva_div">
                                              <b><font>* </font>心得：</b>
                                              <textarea name="content" datatype="*5-255" nullmsg="请输入评价内容"></textarea>
                                            </div>
                                            <div class="mymember_eva_div">
                                                <#-- 上传图片 zhangji -->
                                                <div class="upload-box upload-show360"></div>
                                                <input style="float:right;margin-right:20%;" class="mysub" type="submit" value="发表评论">
								                <div class="photo-list_show360">
								                    <ul>
								            
								                    </ul>
								                </div>
                                            	<#-- 上传图片 end -->
                                              
                                            </div>
                                            </form>
                                        </td></tr>
 <script src="/client/js/Validform_v5.3.2_min.js"></script>
<script>  
$(document).ready(function(){  
     //初始化表单验证
    $(".commentForm${order_index}${item_index}").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
                alert("提交评论成功");
                window.location.reload();
            }
            else
            {
                alert(data.message);
            }
        }
    });
});                                                 
// 改变星级
function starChange${order_index}${item_index}(type, stars)
{
    if (null == type || null == stars)
    {
        return;
    }
    
    var starCount = parseInt(stars);
    
    // 商品满意度
    if ("goodsStar" == type)
    {
        $("#goodsStar${order_index}${item_index}").val(starCount);
        switch(starCount)
        {
        case 1:
            $("a.goodsStar${order_index}${item_index}").eq(0).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(1).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(2).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(3).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(4).html('<img src="/client/images/mymember/star01.png" />');
            break;
        case 2:
            $("a.goodsStar${order_index}${item_index}").eq(0).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(1).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(2).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(3).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(4).html('<img src="/client/images/mymember/star01.png" />');
            break;
        case 3:
            $("a.goodsStar${order_index}${item_index}").eq(0).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(1).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(2).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(3).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(4).html('<img src="/client/images/mymember/star01.png" />');
            break;
        case 4:
            $("a.goodsStar${order_index}${item_index}").eq(0).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(1).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(2).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(3).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(4).html('<img src="/client/images/mymember/star01.png" />');
            break;
        case 5:
            $("a.goodsStar${order_index}${item_index}").eq(0).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(1).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(2).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(3).html('<img src="/client/images/mymember/star02.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(4).html('<img src="/client/images/mymember/star02.png" />');
            break;
        default:
            $("a.goodsStar${order_index}${item_index}").eq(0).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(1).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(2).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(3).html('<img src="/client/images/mymember/star01.png" />');
            $("a.goodsStar${order_index}${item_index}").eq(4).html('<img src="/client/images/mymember/star01.png" />');    
        }
    }
}
</script>
                            </#if>                           
                        </#list>
                    </#if>
                </#list>
            </#if>
        </table>
      
      <div class="myclear" style="height:10px;"></div>
      <div class="mymember_page">
        <#if order_page??>
            <#assign continueEnter=false>
            <#if order_page.totalPages gt 0>
                <#list 1..order_page.totalPages as page>
                    <#if page <= 3 || (order_page.totalPages-page) < 3 || (order_page.number+1-page)?abs<3 >
                        <#if page == order_page.number+1>
                            <a class="mysel" href="javascript:;">${page}</a>
                        <#else>
                            <a href="/user/comment/list?page=${page-1}&statusId=${statusId!''}">${page}</a>
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
    </div><!--mymember_info END-->

  </div><!--mymember_center END-->
  
<div class="myclear"></div>
</div>
<!--mymember END-->
<div class="clear h40"></div>
<#include "/client/common_footer.ftl" />
</div>
</body>
</html>




  











