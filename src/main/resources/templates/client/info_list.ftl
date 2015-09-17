<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<!--[if IE]>
   <script src="js/html5.js"></script>
<![endif]-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>

<link href="/client/style/common.css" rel="stylesheet" type="text/css" />
<link href="/client/style/cartoon.css" rel="stylesheet" type="text/css" />
<link href="/client/style/style.css" rel="stylesheet" type="text/css" />
</head>
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
</script>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="clear h20"></div>
<!--liebiaoye-->
    <div class="main">
        <div class="weizhi">
            <span><a href="#">首页</a></span>><span>团购秒杀</span>
        </div>
        <div class="clear h15"></div>
        <div class="wenzhangliebiao">
        <ul>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        <li>
        <a href="#">杜绝“中国式剩宴”—— 对舌尖上浪费的思考</a>2015.06.03
        </li>
        </ul>
        </div>
    <!--分页-->
    <div class="pagebox">
      <div class="num">
        <a class="a1 a0" href="#"><span>上一页</span></a>
        <a class="sel" href="#">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <span> ... </span>
        <a href="#">45</a>
        <a class="a2" href="#"><span>下一页</span></a>
        <span> 共<b>45</b>页 </span>
      </div>
      <div class="page">
        <input class="sub" type="submit" value="确定" />
        <span>页</span>
        <input class="text" type="text" value="1" />
        <span>到第</span>
      </div>
      <div class="clear"></div>
    </div>
    </div>
  <div class="clear h40"></div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
<!--底部结束-->
</body>
</html>
