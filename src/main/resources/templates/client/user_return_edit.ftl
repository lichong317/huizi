
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
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
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script type="text/javascript" src="/client/js/Validform_v5.3.2_min.js"></script>

<script type="text/javascript" src="/mag/js/swfupload.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.queue.js"></script>
<script type="text/javascript" src="/client/js/swfupload.imghandlers.js"></script>

<style>
/*上传样式  zhangji */
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
	
	  //初始化上传控件  zhangji 
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

</script>
<script type="text/javascript">
$(function () {
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3,
        success:function(){
        alert("申请成功，我们将尽快处理。")
        }
    });
});
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
      <div class="mymember_info mymember_info02">
        退换货——服务单明细
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                        <th width="260" style="text-align:center;">商品名称</th>
                        <th width="170" style="text-align:center;">销售方式</th>
                        <th width="105" style="text-align:center;">购买数量</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <ul class="list-proinfo" id="removeTheSingleGife">
                            <li class="fore1">
                                <a href="http://item.jd.com/1448733811.html" target="_blank">
                                    <img height="50" width="50" title="${order_goods.goodsTitle!''}-${order_goods.goodsSubTitle!''}"
                                         src="${order_goods.goodsCoverImageUri!''}" data-img="1" alt="">
                                </a><div class="p-info"><a href="/goods/${order_goods.goodsId!''}" target="_blank">${order_goods.goodsTitle!''}</a></div>
                            </li>
                       </ul>
                    </td>                  
                    <td>
							${order_goods.goodsSaleType!'-'}
			        </td>
                    <td>${order_goods.quantity!'1'}</td>
                </tr>
                </tbody>
            </table>
            <form action ="/user/return/save" id="form1" method="post">
			<table width="100%" border="0">
			  <tr>
			    <td> <span style="position:absolute;right:88px;top:-13px;"><img src="/client/images/mymember/arrow06.gif" /></span>
			            <input type="hidden" name="id" value="${orderId?c}" />
			            <input type="hidden" name="orderGoodsId" value="${orderGoodsId?c}" />
			            <input type="hidden" name="telephone" value="${telephone!''}" />
			            <div style="height:30px;margin-top:30px;">
			           		  <label style="float:left;margin-left:200px;"><input type="radio" name="isReturn" value="true" <#if has_returned??&&has_returned&&return??&&return.isReturn?? && return.isReturn> checked="checked" </#if>/>退货</label>
			                  <label style="float:left;margin-left:30px;"><input type="radio" datatype="*" name="isReturn" value="false" <#if has_returned??&&has_returned&&return??&&return.isReturn?? && !return.isReturn> checked="checked" </#if>/>换货</label>
			             </div>
			             <div  class="mymember_eva_div">
			             	<b><font>* </font>数量：</b>
			                <input type="text" name="returnNumber" datatype="/^([1-${order_goods.quantity!'1'}])$/" nullmsg="请填写退换货的数量" errormsg="数量不能大于购买数量" style="width:24px;"   <#if has_returned?? &&has_returned>value="${return.returnNumber!''}" disabled="disabled"<#else>value="${order_goods.quantity!'1'}"</#if> />
			            </div>
			        <#-->    <div class="mymember_eva_div">
			            <b ><font>* </font>问题类型：</b>
                              <label style="margin-left:10px;"><input type="radio" name="isReturn" value="true" />不喜欢</label>
                              <label style="left;margin-left:30px;"><input type="radio" datatype="*" name="isReturn" value="false" />产品质量有问题</label>
                        </div> -->
			            <div class="mymember_eva_div">
			              <b><font>* </font>问题描述：</b>
			              <#if has_returned?? &&has_returned>
			              	<textarea name="reason" disabled="disabled">${return.reason!''}</textarea>
			              	<h3 style="text-align:right;color:#666;margin:20px 0;">状态：<#if return.statusId ==1><span style="color:#0060aa;text-align:right;">已处理</span><#else><span style="color:#fd3e3e;text-align:right;">待处理</span></#if></h3>
			              	<#if return?? && return.showPictures??>
	                            <#list return.showPictures?split(",") as uri>
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
			              <#else>	
			             	 <textarea name="reason" datatype="*5-255"></textarea>
			             	 </div>
			            <div class="mymember_eva_div">
                                <#-- 上传图片 zhangji -->
                                <div class="upload-box upload-show360"></div>
                                <input style="float:right;margin-right:20%;" class="mysub" type="submit" value="提交">
				                <div class="photo-list_show360">
				                    <ul>
				            
				                    </ul>
				                </div>
                            	<#-- 上传图片 end -->
			            </div>
			              </#if>
			            
			      </td>
			  </tr>
			</table>
			</form>      
        <div class="myclear" style="height:10px;"></div>
      </div>
      <!--mymember_info END-->
     	<#include "/client/user_maylike.ftl" />
      <!--mymember_info END-->
      <script type="text/javascript">
      $(document).ready(function(){
         mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
    });
    </script>
    </div>
    <!--mymember_center END-->
  </div>
  <!--mymember_main END-->
  <div class="myclear"></div>
</div>
<!--mymember END-->
<#include "/client/common_footer.ftl" />

</div>
</body>
</html>