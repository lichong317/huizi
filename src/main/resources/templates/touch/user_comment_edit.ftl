<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Language" content="zh-CN">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<meta name="viewport" content="initial-scale=1,maximum-scale=1,minimum-scale=1">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">

<link href="/touch/css/common.css" rel="stylesheet" type="text/css" />
<link href="/touch/css/style.css" rel="stylesheet" type="text/css" />


<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
    <#if order_goods_list??>
        <#list order_goods_list as item>
              reviewsBoxnew("#reviewsbox0","a","sel");//评价星星
        </#list>
    </#if>
    
});

function reviewsBoxnew(boxid,_name,_hover){
    var _box = $(boxid);
    var _arr = _box.find(_name);
    var _index = 0;
    var _now = _box.find("."+_hover).length;
    
    var _checkNow = function(_num){
        _arr.removeClass(_hover);
            for(var i=0;i<=_num;i++){
              _arr.eq(i).addClass(_hover);
              }
        };//fun END
    _arr.hover(function(){
        _index = $(this).index();
        _checkNow(_index);
        },function(){
            _checkNow(_now-1);
            });
    _arr.click(function(){
            _now = $(this).index();
            
            // 添加部分
            $(this).siblings(".goodsStar").eq(0).val(_now + 1);
            
            for(var i=0;i<=_now;i++){
              _arr.eq(i).addClass(_hover);
              }
            _now += 1;
        });
}
</script>
</head>

<style>
.Validform_checktip{line-height:20px; height:20px; overflow:hidden; color:red; font-size:12px; margin-left:10%;}


#Validform_msg{color:#7d8289; font: 12px/1.5 tahoma, arial, \5b8b\4f53, sans-serif; width:280px; -webkit-box-shadow:2px 2px 3px #aaa; -moz-box-shadow:2px 2px 3px #aaa; background:#fff; position:absolute; top:0px; right:50px; z-index:99999; display:none;filter: progid:DXImageTransform.Microsoft.Shadow(Strength=3, Direction=135, Color='#999999'); box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);}
#Validform_msg .iframe{ position:absolute; left:0px; top:-1px; z-index:-1; }
#Validform_msg .Validform_title{ position:relative; line-height:35px; height:35px; text-align:left; font-weight:bold; padding:0 10px; color:#fff; background:#33B5E5; }
#Validform_msg a.Validform_close:link,#Validform_msg a.Validform_close:visited{ line-height:30px; position:absolute; right:10px; top:0px; color:#fff; text-decoration:none; }
#Validform_msg a.Validform_close:hover{color:#ccc;}
#Validform_msg .Validform_info{padding:10px;border:1px solid #bbb; border-top:none; text-align:left;}


</style>
<body class="eeebg">

<!-- top_menu -->
<#include "/touch/top_menu.ftl" />

<header class="comhead">
  <h2>评价订单</h2>
  <a href="javascript:history.go(-1);" class="a2"><img src="/touch/images/back.png" /></a>
  <a href="javascript:void(0);" onClick="$('#mainfoot').fadeToggle(200);" class="a1"><img src="/touch/images/menu.png" /></a>
</header>
<div class="comheadbg"></div>

<#if order_goods_list??>
    <#list order_goods_list as item>
        <#if ("comment_"+item_index)?eval??>
             <div class="prolist mainbox bot-border whitebg">
              <a class="img" href="/touch/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" /></a>
              <section>
              <p class="h07 oh">${item.goodsTitle!''}</p>
              <p class="pt10 pb10 w100 mt10">
                  <input type="radio" name="stars" value="3" disabled="disabled" <#if ("comment_"+item_index)?eval.stars?? && ("comment_"+item_index)?eval.stars==3>checked="checked"</#if>/>好评
                  <input type="radio" name="stars" value="2" disabled="disabled" <#if ("comment_"+item_index)?eval.stars?? && ("comment_"+item_index)?eval.stars==2>checked="checked"</#if>/>中评
                  <input type="radio" name="stars" value="1" disabled="disabled" <#if ("comment_"+item_index)?eval.stars?? && ("comment_"+item_index)?eval.stars==1>checked="checked"</#if>/>差评
              </p>
              <div class="reviewsout mt20">
              
                <span class="c9">评分：</span>
                  <menu id="" class="reviewsbox">
                    <a href="javascript:void(0);" <#if ("comment_"+item_index)?eval.stars gt 0>class="sel"</#if>>&nbsp;</a>
                    <a href="javascript:void(0);" <#if ("comment_"+item_index)?eval.stars gt 1>class="sel"</#if>>&nbsp;</a>
                    <a href="javascript:void(0);" <#if ("comment_"+item_index)?eval.stars gt 2>class="sel"</#if>>&nbsp;</a>
                    <a href="javascript:void(0);" <#if ("comment_"+item_index)?eval.stars gt 3>class="sel"</#if>>&nbsp;</a>
                    <a href="javascript:void(0);" <#if ("comment_"+item_index)?eval.stars gt 4>class="sel"</#if>>&nbsp;</a>                   
                  </menu><!--我是评价星星-->                
              </div>
              </section>
              <div class="clear h01"></div>
              <textarea class="reviews_area" placeholder="评价内容" disabled="disabled">${("comment_"+item_index)?eval.content!''}</textarea>
              <#--<p class="ta-r"><input type="submit" value="评价" class="sub redbg w30 white h05 lh5 bor-rad mt10" /></p> -->
            </div>
        <#else>
        <form class="commentForm${item_index}" action="/touch/user/comment/add" method="post">
            <input type="hidden" name="orderId" value=<#if order??>${order.id?c}</#if> />
            <input type="hidden" name="ogId" value=${item.id?c} />
            <input type="hidden" name="goodsId" value=${item.goodsId?c} />
            <div class="prolist mainbox bot-border whitebg">
              <a class="img" href="/touch/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" /></a>
              <section>
              <p class="h07 oh">${item.goodsTitle!''}</p>
              <p class="pt10 pb10 w100 mt10">
                  <input type="radio" name="stars" value="3" datatype="n" nullmsg="点击进行评价"/>好评
                  <input type="radio" name="stars" value="2" datatype="n" nullmsg="点击进行评价"/>中评
                  <input type="radio" name="stars" value="1" datatype="n" nullmsg="点击进行评价"/>差评
              </p>
              <div class="reviewsout mt20">
              
                <span class="c9">评分：</span>
                  <menu id="reviewsbox${item_index}" class="reviewsbox">
                    <a href="javascript:void(0);" class="sel">&nbsp;</a>
                    <a href="javascript:void(0);" class="sel">&nbsp;</a>
                    <a href="javascript:void(0);" class="sel">&nbsp;</a>
                    <a href="javascript:void(0);" class="sel">&nbsp;</a>
                    <a href="javascript:void(0);" class="sel">&nbsp;</a>
                    <input class="goodsStar" id="goodsStar${item_index}" name="goodsStar" type="hidden" value="5" datatype="n" nullmsg="请评价星级"/>
                  </menu><!--我是评价星星-->                
              </div>
              </section>
              <div class="clear h01"></div>
              <textarea class="reviews_area" placeholder="评价内容" name="content" datatype="*5-255" nullmsg="请输入评价内容"></textarea>
              <p class="ta-r"><input type="submit" value="评价" class="sub redbg w30 white h05 lh5 bor-rad mt10" /></p>
            </div>
        </form>
<script>  
$(document).ready(function(){  
     //初始化表单验证
    $(".commentForm${item_index}").Validform({
        tiptype: 4,
        ajaxPost:true,
        callback: function(data) {
            if (data.code==0)
            {
                 ct.alert({
                        text: "提交评论成功",
                        type: "alert"
                    });
                window.location.reload();
            }
            else
            {
                alert(data.message);
            }
        }
    });

}); 

</script>
          </#if>
    </#list>
</#if>
 
<div class="clear h03"></div>
  
</body>
</html>
