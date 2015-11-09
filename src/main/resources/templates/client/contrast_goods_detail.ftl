<!DOCTYPE html>

<head>
<meta charset="utf-8">
<title><#if site??>${site.seoTitle!''}-</#if>惠之店</title>
<meta name="keywords" content="${site.seoKeywords!''}">
<meta name="description" content="${site.seoDescription!''}">
<meta name="copyright" content="${site.copyright!''}" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="css/member.css" rel="stylesheet" type="text/css" />-->
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
    
    
});
</script>
<style>
/*publish time:2013-05-23 16:33 yk*/
*html{background-image:url(about:blank);}
/*pcomprare*/
#pcomprare{margin-bottom:10px;}
#pcomprare .tab{position:relative;z-index:1;border:1px solid #ddd;border-bottom:none;margin-bottom:0;background:#f7f7f7;}
#pcomprare .tab li{float:left;display:block;width:132px;height:31px;margin-left:10px;text-align:left;font:normal 15px/31px \5fae\8f6f\96c5\9ed1;color:#333;}
#pcomprare .tab li.curr{cursor:default;color:#333;}
/*tb-1*/
.tb-1{width:1200px;;margin-top:-1px;border-collapse:collapse;border:1px solid #ddd;border-top:none;table-layout:fixed;}
.tb-1 th,.tb-1 td{padding:8px 10px;border:1px solid #ddd;line-height:20px;word-wrap:break-word;}
.tb-1 th{width:84px;padding-left:30px;text-align:left;font-weight:normal;color:#999;}
.tb-1 td{overflow:hidden;width:195px;text-align:center;vertical-align:top;}
.tb-1 thead tr{background:#F7F7F7 url(i/20130425B.png) no-repeat 10px 50%;}
.tb-1 thead tr.active{background:#F7F7F7 url(i/20130425C.png) no-repeat 10px 50%;}
.tb-1 thead th{font-size:14px;color:#E4393C;}
.tb-1 thead td{background:#F7F7F7 none;}
.tb-1 tbody tr.differ{background:#EBFBE2;}
.tb-1 tbody tr.hover{background:#F7F7F7;}
.tb-1 tbody .no-contrast{padding:70px 0px 5px;text-align:center;font-family:"微软雅黑";font-size:25px;color:#ccc;}
.tb-1 tbody .add-contrast{text-align:center;}
.tb-1 tbody .p-price td{font-family:verdana;font-size:14px;font-weight:bold;color:#E4393C;}
.tb-1 tbody .brand td{color:#005EA7;}
.tb-1 .inner{width:250px;background:#fff;line-height:22px;}
.tb-1 .inner caption{background:#F7F7F7;font-weight:bold;text-align:center;color:#333;}
.tb-1 .inner th,.tb-1 .inner td{padding:0px;border:none;text-align:left;}
.tb-1 .inner th{width:80px;padding:0px;font-weight:normal;color:#999;}
.tb-1 .inner td{width:170px;color:#333;}
.tb-1 a:link,.tb-1 a:visited{color:#005EA7;}
.tb-1 a:hover{color:#c00;}
.tb-1 span,.tb-1 span a:link,.tb-1 span a:visited{color:#E4393C;}
.nobor tbody th,.nobor tbody td{ border-width:0px 1px 0px 0px;}
/*tool*/
#tool,#tool a.setup,#compare_highlight,#compare_equal,#locate,#static{background-image:url(i/20130425A.png);background-repeat:no-repeat;}
#tool{position:fixed;bottom:0px;left:50%;z-index:1;width:602px;height:52px;margin:10px 0px 0px -301px;background-position:0 0;}
*html #tool{position:absolute;top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)));zoom:1;}
#tool .con,#locate,#static{position:relative;}
#tool .con{display:block;width:340px;height:34px;padding:13px 0px 0px 130px;background-position:-53px 0;line-height:34px;}
#locate,#static{float:right;right:30px;top:13px;cursor:pointer;width:85px;height:25px;}
#locate{background-position:0 -79px;}
#static{display:none;background-position:-86px -79px;}
#tool a.setup{float:left;width:92px;height:25px;padding-left:21px;margin-right:10px;background-position:-224px -53px;line-height:24px;text-align:center;color:#fff;}
#tool a.setup:hover{text-decoration:none;}
#tool a.setup b{float:right;display:none;width:12px;height:34px;}
#tool #compare_highlight{padding-left:24px;background-position:0 -53px;}
#tool #compare_equal{padding-left:24px;background-position:-124px -53px;}
/*root61*/
.root61 .tb-1{width:1208px;}
.root61 .tb-1 td{width:250px;}
</style>
</head>
<body>
<#include "/client/common_header.ftl" />
<!--mymember--> 
<!--mymember-->

<div class="w main" style="width:1210px;" id="pcomprare">
    <ul class="tab">
        <li class="curr">基本信息对比</li>
    </ul>
    <div class="tabcon">
        <table class="tb-1">
            <tbody>
                <tr class="" style="background-color: rgb(255, 255, 255);">
                    <th>商品图片</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                            <td>
                                <a href="/goods/${item.id?c}" rel="nofollow"><img src="${item.coverImageUri!''}" width="100" height="100" ks_mark="y"></a>
                                <div><a href="/goods/${item.id?c}" rel="nofollow">${item.title!''}</a></div>
                            </td>
                        </#list>
                    </#if>
                </tr>
                <tr class="p-price">
                    <th>惠之店价格</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td><strong>￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></strong></td>
                        </#list>
                    </#if>                   
                </tr>
                <tr class="brand">
                    <th>所属品牌</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td>${item.brandTitle!'--'}</td>
                        </#list>
                    </#if>                 
                </tr>
                <tr class="">
                    <th>库存数量</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td>${item.leftNumber!'--'}</td>
                        </#list>
                    </#if>
                </tr>
                <tr class="">
                    <th>服务</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td>${item.service!'--'}</td>
                        </#list>
                    </#if>
                </tr>    
                <tr class="">
                    <th>配置</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td>${item.configuration!'--'}</td>
                        </#list>
                    </#if>
                </tr>    
                <tr class="">
                    <th>促销</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td>${item.promotion!'--'}</td>
                        </#list>
                    </#if>
                </tr>                 
            </tbody>
        </table>
        <table class="tb-1 tb_compare">
            <thead title="点击这里折叠/展开" style="cursor: pointer; background: url() 10px 50% no-repeat;">
                <tr>
                    <th><div class="">主体参数</div></th>
                    <#if goods_list??>
                        <#list goods_list as item>
                            <td>                 
                                <div><a href="/goods/${item.id?c}" rel="nofollow">${item.title!'--'}</a></div>
                            </td>
                        </#list>
                    </#if>                
                </tr>
            </thead>
            <tbody>
                <tr class="">                       
                    <th>产品品牌</th>
                    <#if goods_list??>
                        <#list goods_list as item>
                           <td>${item.brandTitle!'--'}</td>
                        </#list>
                    </#if>  
                </tr>
                <#if paramList??>
                    <#list paramList as item>
                        <tr class="">                       
                            <th>${item.title!''}</th>
                            <#if goods_list??>
                                <#list goods_list as goods>
                                    <#if goods.paramList?? && goods.paramList[item_index]??>
                                        <td>${goods.paramList[item_index].value!'--'}</td>
                                    </#if>                                                                  
                                </#list>
                            </#if>                            
                        </tr>
                    </#list>
                </#if>
                
            </tbody>
        </table>
       
        <div id="tool" style="position: static; margin: 10px auto 0px;">
            <div id="locate" title="点击取消固定" style="display: none;"></div>
            <div id="static" title="点击固定工具条" style="display: block;"></div>
            <div class="con"> <a href="#" id="compare_highlight" class="setup" style="width:99px;" clstag="shangpin|keycount|compare|gaoliang"><b></b>高亮显示不同项</a> <a href="#" id="compare_equal" class="setup" style="width:75px;" clstag="shangpin|keycount|compare|yincang"><b></b>隐藏相同项</a> </div>
        </div>
    </div>
    <div class="mc tabcon hide">2</div>
</div>

<!--mymember END-->
<#include "/client/common_footer.ftl" />
</body>
</html>