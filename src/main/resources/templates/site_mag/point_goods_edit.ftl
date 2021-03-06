<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mag/style/idialog.css" rel="stylesheet" id="lhgdialoglink">
<title>编辑信息</title>
<script type="text/javascript" src="/mag/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/mag/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/mag/js/lhgdialog.js"></script>
<script type="text/javascript" src="/mag/js/WdatePicker.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.queue.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.handlers.js"></script>
<script type="text/javascript" charset="utf-8" src="/mag/js/kindeditor-min.js"></script>
<script type="text/javascript" charset="utf-8" src="/mag/js/zh_CN.js"></script>
<script type="text/javascript" src="/mag/js/layout.js"></script>

<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<link href="/mag/style/WdatePicker.css" rel="stylesheet" type="text/css">
<link href="/mag/style/style.css" rel="stylesheet" type="text/css">
<link href="/mag/style/default.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
    //初始化表单验证
    $("#form1").initValidform();

    //初始化编辑器
    var editor = KindEditor.create('.editor', {
        width: '98%',
        height: '350px',
        resizeType: 1,
        uploadJson: '/Verwalter/editor/upload?action=EditorFile',
        fileManagerJson: '/Verwalter/editor/upload?action=EditorFile',
        allowFileManager: true
    });
    
    //初始化上传控件
    $(".upload-img").each(function () {
        $(this).InitSWFUpload({ 
            sendurl: "/Verwalter/upload", 
            flashurl: "/mag/js/swfupload.swf"
        });
    });
    
    $(".upload-show360").each(function () {
        $(this).InitSWFUpload_show360({ 
            btntext: "批量上传", 
            btnwidth: 66, 
            single: false, 
            water: true, 
            thumbnail: true, 
            filesize: "5120", 
            sendurl: "/Verwalter/upload", 
            flashurl: "/mag/js/swfupload.swf", 
            filetypes: "*.jpg;*.jpge;*.png;*.gif;" 
        });
    });

    //（缩略图）
    var txtPic = $("#txtImgUrl").val();
    if (txtPic == "" || txtPic == null) {
        $("#thumb_ImgUrl_show1").hide();
    }
    else {
        $("#thumb_ImgUrl_show1").html("<ul><li><div class='img-box1'><img src='" + txtPic + "' bigsrc='" + txtPic + "' /></div></li></ul>");
        $("#thumb_ImgUrl_show1").show();
    }

    $("#txtImgUrl").blur(function () {
        var txtPic = $("#txtImgUrl").val();
        if (txtPic == "" || txtPic == null) {
            $("#thumb_ImgUrl_show1").hide();
        }
        else {
            $("#thumb_ImgUrl_show1").html("<ul><li><div class='img-box1'><img src='" + txtPic + "' bigsrc='" + txtPic + "' /></div></li></ul>");
            $("#thumb_ImgUrl_show1").show();
        }
    });
    
    //设置封面图片的样式
    $(".photo-list ul li .img-box img").each(function () {
        if ($(this).attr("src") == $("#hidFocusPhoto").val()) {
            $(this).parent().addClass("selected");
        }
    });
    
    // 根据类型载入参数
    $("#categoryId").change(function(){
        $.ajax({
            url : '/Verwalter/goods/edit/parameter/'+$(this).val(),
            type : 'POST',
            success : function(res) {
                $("#id-param-sec").html(res);
            }
        });
    });   

});
</script>
</head>
<body class="mainbody">
<form method="post" action="/Verwalter/pointGoods/save" id="form1">
<div>
<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="${__EVENTTARGET!""}" />
<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="${__EVENTARGUMENT!""}" />
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="${__VIEWSTATE!""}" />
</div>
<input name="menuId" type="text" value='${mid!""}' style="display:none;">
<input name="channelId" type="text" value='${cid!""}' style="display:none">
<input name="id" type="text" value='<#if goods??>${goods.id?c}</#if>' style="display:none">
<!--导航栏-->
<div class="location">
    <a href="/Verwalter/pointGoods/list" class="back"><i></i><span>
        返回列表页</span></a> 
    <a href="/Verwalter/center" class="home">
    <i></i><span>首页</span></a>
    <i class="arrow"></i>
    <span>编辑信息</span>
</div>
<div class="line10">
</div>
<!--/导航栏-->
    <!--内容-->
    <div class="content-tab-wrap">
        <div id="floatHead" class="content-tab">
            <div class="content-tab-ul-wrap" >
                <ul>
                    <li><a href="javascript:;" onclick="tabs(this);" class="selected">基本信息</a></li>
                    <li><a href="javascript:;" onclick="tabs(this);" class="">扩展选项</a></li>
                    <li><a href="javascript:;" onclick="tabs(this);" class="">详细描述</a></li>
                    <li><a href="javascript:;" onclick="tabs(this);" class="">价格与库存</a></li>
                    <li><a href="javascript:;" onclick="tabs(this);" class="">SEO选项</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div id="id-first-tab" class="tab-content" style="display: block;">
 <#--       <dl>
            <dt>所属类别</dt>
            <dd>
                <div class="rule-single-select">
                    <select name="categoryId" id="categoryId" datatype="*" sucmsg=" ">
                        <#if !goods??>
                        <option value="">请选择类别...</option>
                        </#if>
                        <#if category_list??>
                            <#list category_list as c>
                                <option value="${c.id!""}" <#if goods?? && goods.categoryId==c.id>selected="selected"</#if>><#if c.layerCount?? && c.layerCount gt 1><#list 1..(c.layerCount-1) as a>　</#list>├ </#if>${c.title!""}</option>
                            </#list>
                        </#if>
                    </select>
                </div>
            </dd>
        </dl>  -->
        <dl>
            <dt>显示状态</dt>
            <dd>
                <div class="rule-multi-radio multi-radio">
                    <span>
                        <input type="radio" name="isOnSale" value="1" <#if goods??==false || goods.isOnSale==true>checked="checked"</#if>>
                        <label>上架</label>
                        <input type="radio" name="isOnSale" value="0" <#if goods?? && goods.isOnSale?? && goods.isOnSale==false>checked="checked"</#if>>
                        <label>下架</label>
                    </span>
                </div>
            </dd>
        </dl>
<#--        <dl>
            <dt>推荐类型</dt>
            <dd>
                <div class="rule-multi-checkbox multi-checkbox">
                    <span>
                        <input id="cblItem_0" type="checkbox" name="isRecommendIndex" <#if goods?? && goods.isRecommendIndex?? && goods.isRecommendIndex==true>checked="checked"</#if>>
                        <label for="cblItem_0">首页推荐</label>
                        <input id="cblItem_1" type="checkbox" name="isRecommendType" <#if goods?? && goods.isRecommendType?? && goods.isRecommendType==true>checked="checked"</#if>>
                        <label for="cblItem_1">分类推荐</label>
                        <input id="cblItem_2" type="checkbox" name="isHot" <#if goods?? && goods.isHot?? && goods.isHot==true>checked="checked"</#if>>
                        <label for="cblItem_2">热销</label>
                        <input id="cblItem_3" type="checkbox" name="isNew" <#if goods?? && goods.isNew?? && goods.isNew==true>checked="checked"</#if>>
                        <label for="cblItem_3">新品</label>
                        <input id="cblItem_4" type="checkbox" name="isSpecialPrice" <#if goods?? && goods.isSpecialPrice?? && goods.isSpecialPrice==true>checked="checked"</#if>>
                        <label for="cblItem_4">特价</label>
                        
                    </span>
                </div>
            </dd>
        </dl>  -->
        <dl>
            <dt>是否免邮</dt>
            <dd>
                <div class="rule-multi-radio multi-radio">
                    <span>                                               
                        <input type="radio" name="isFeeNot" value="1" <#if goods??==false || goods?? && goods.isFeeNot?? && goods.isFeeNot==true>checked="checked"</#if>>
                        <label for="cblItem_4">是</label>
                        <input type="radio" name="isFeeNot" value="0" <#if goods?? && goods.isFeeNot?? && goods.isFeeNot==false>checked="checked"</#if>>
                        <label for="cblItem_4">否</label>
                    </span>
                </div>
            </dd>
        </dl>
        <dl>
            <dt>邮费</dt>
            <dd>
                <input name="postage" type="text" value="<#if goods??>${goods.postage!""}<#else>0</#if>" id="postage" class="input txt100" datatype="n" sucmsg=" ">
                <span class="Validform_checktip">*免邮商品不计算邮费</span>
            </dd>
        </dl>
 <#--       <dl>
            <dt>满额免邮</dt>
            <dd>
                <input name="maxPostage" type="text" value="<#if goods??>${goods.maxPostage!""}<#else>200</#if>" id="maxPostage" class="input txt100" datatype="n" sucmsg=" ">
                <span class="Validform_checktip">*购满一定金额免邮</span>
            </dd>
        </dl> -->
        <dl>
            <dt>排序数字</dt>
            <dd>
                <input name="sortId" type="text" value="<#if goods??>${goods.sortId!""}<#else>99</#if>" id="txtSortId" class="input txt100" datatype="n" sucmsg=" ">
                <span class="Validform_checktip">*数字，越小越向前</span>
            </dd>
        </dl>
        
        <dl>
            <dt>封面图片</dt>
            <dd>
                <input id="txtImgUrl" name="coverImageUri" type="text" value="<#if goods??>${goods.coverImageUri!""}</#if>" class="input normal upload-path">
                <div class="upload-box upload-img"></div>
                <div id="thumb_ImgUrl_show1" class="photo-list thumb_ImgUrl_show">
                </div>
            </dd>
        </dl>
        
        <div id="id-param-sec">
            <#if goods??>
                <#include "/site_mag/goods_category_param_list.ftl" />
            </#if>
        </div>
    </div>
    <div class="tab-content" style="display: none;">
 <#-->       <dl>
            <dt>商品名称</dt>
            <dd>
                <input name="name" type="text" value="<#if goods??>${goods.name!""}</#if>" class="input normal" datatype="*2-100" sucmsg=" ">
                <span class="Validform_checktip">*标题最多100个字符</span>
            </dd>
        </dl>  -->
        
        <dl>
            <dt>商品标题</dt>
            <dd>
                <input name="title" type="text" value="<#if goods??>${goods.title!""}</#if>" class="input normal" datatype="*2-100" sucmsg=" ">
                <span class="Validform_checktip">*标题最多100个字符</span>
            </dd>
        </dl>
        
        <dl>
            <dt>商品副标题</dt>
            <dd>
                <input name="subTitle" type="text" value="<#if goods??>${goods.subTitle!""}</#if>" class="input normal" datatype="*2-255" sucmsg=" ">
                <span class="Validform_checktip">*标题最多255个字符</span>
            </dd>
        </dl>
        <dl>
            <dt>服务</dt>
            <dd>
                <textarea name="service" rows="2" cols="20" class="input" datatype="*0-255" sucmsg=" "><#if goods??>${goods.service!""}</#if></textarea>
                <span class="Validform_checktip">255个字符以内</span>
            </dd>
        </dl>
  <#--      <dl>
            <dt>促销</dt>
            <dd>
                <textarea name="promotion" rows="2" cols="20" class="input" datatype="*0-255" sucmsg=" "><#if goods??>${goods.promotion!""}</#if></textarea>
                <span class="Validform_checktip">255个字符以内</span>
            </dd>
        </dl>  -->
        <dl>
            <dt>配置</dt>
            <dd>
                <textarea name="configuration" rows="2" cols="20" class="input" datatype="*0-255" sucmsg=" "><#if goods??>${goods.configuration!""}</#if></textarea>
                <span class="Validform_checktip">255个字符以内</span>
            </dd>
        </dl>
        <dl>
            <dt>上架时间</dt>
            <dd>
                <div class="input-date">
                    <input name="onSaleTime" type="text" value="<#if goods??>${goods.onSaleTime!""}</#if>" class="input date" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',lang:'zh-cn'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" ">
                    <i>日期</i>
                </div>
                <span class="Validform_checktip">不选择默认为当前时间</span>
            </dd>
        </dl>
    </div>
    
    <div class="tab-content" style="display: none;">
        <dl id="div_show360_container">
            <dt>展示图片</dt>
            <dd>
                <div class="upload-box upload-show360"></div>
                <div class="photo-list_show360">
                    <ul>
                        <#if goods?? && goods.showPictures??>
                            <#list goods.showPictures?split(",") as uri>
                                <#if uri != "">
                                <li>
                                    <input type="hidden" name="hid_photo_name_show360" value="0|${uri!""}|${uri!""}">
                                    <div class="img-box">
                                        <img src="${uri!""}" bigsrc="${uri!""}">
                                    </div>
                                    <a href="javascript:;" onclick="delImg(this);">删除</a>
                                </li>
                                </#if>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </dd>
        </dl>
        
        <dl>
            <dt>详细参数</dt>
            <dd>
                <textarea name="paramDetail" class="editor"><#if goods??>${goods.paramDetail!""}</#if></textarea>
            </dd>
        </dl>
        
        <dl>
            <dt>详细描述</dt>
            <dd>
                <textarea name="detail" class="editor"><#if goods??>${goods.detail!""}</#if></textarea>
            </dd>
        </dl>
        <dl>
            <dt>售后服务</dt>
            <dd>
                <textarea name="afterMarketService" class="editor"><#if goods??>${goods.afterMarketService!""}</#if></textarea>
            </dd>
        </dl>
    </div>
    
    <div class="tab-content" style="display: none;">
<#--        
        <dl>
            <dt>成本价</dt>
            <dd>
                <input name="costPrice" type="text" value="<#if goods?? && goods.costPrice??>${goods.costPrice?string("#.##")}<#else>0</#if>" class="input normal" datatype="/^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/" sucmsg=" ">
                <span class="Validform_checktip">成本价，不在前台显示</span>
            </dd>
        </dl>
        <dl>
            <dt>市场价</dt>
            <dd>
                <input name="marketPrice" type="text" value="<#if goods?? && goods.marketPrice??>${goods.marketPrice?string("#.##")}<#else>0</#if>" class="input normal" datatype="/^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/" sucmsg=" ">
                <span class="Validform_checktip">市场价格</span>
            </dd>
        </dl>
        <dl>
            <dt>出厂价</dt>
            <dd>
                <input id="outFactoryPrice" name="outFactoryPrice" type="text" value="<#if goods?? && goods.outFactoryPrice??>${goods.outFactoryPrice?string("0.##")}<#else>0</#if>" class="input normal" datatype="/^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/" sucmsg=" ">
                <span class="Validform_checktip">*商品出厂价</span>
            </dd>
        </dl>
-->
        <dl>
            <dt>兑换所需积分</dt>
            <dd>
                <input name="pointUse" type="text" value="<#if goods?? && goods.pointUse??>${goods.pointUse?c}<#else>0</#if>" class="input normal" datatype="n" sucmsg=" ">
                <span class="Validform_checktip">兑换商品所需积分</span>
            </dd>
        </dl>
        <#if warehouse_list??>
        <dl>
            <dt>所在仓库</dt>
            <dd>
                <div class="rule-single-select">
                    <select name="warehouseId" datatype="*0-100" sucmsg=" ">
                        <option value="" <#if !warehouse_list??>selected="selected"</#if>>请选择类别...</option>
                        <#list warehouse_list as w>
                            <option value="${w.id!""}" <#if goods.warehouseId?? && goods.warehouseId==w.id>selected="selected"</#if>>${w.title!""}</option>
                        </#list>
                    </select>
                </div>
            </dd>
        </dl>
        </#if>
        <dl>
            <dt>库存余量</dt>
            <dd>
                <input name="leftNumber" type="text" value="<#if goods?? && goods.leftNumber??>${goods.leftNumber?c!"1"}<#else>1</#if>" class="input normal" datatype="n" sucmsg=" ">
                <span class="Validform_checktip">库存为0时显示为缺货</span>
            </dd>
        </dl>
        <dl>
            <dt>销量</dt>
            <dd>
                <input name="soldNumber" type="text" value="<#if goods?? && goods.soldNumber??>${goods.soldNumber?c!"0"}<#else>0</#if>" class="input normal" datatype="n" sucmsg=" ">
                <span class="Validform_checktip">商品已销售数量</span>
            </dd>
        </dl>
    </div>
    
    
    <div class="tab-content" style="display: none;">
        <dl>
            <dt>SEO标题</dt>
            <dd>
                <input name="seoTitle" type="text" maxlength="255" id="txtSeoTitle" value="<#if goods??>${goods.seoTitle!""}</#if>" class="input normal" datatype="*0-100" sucmsg=" ">
                <span class="Validform_checktip">255个字符以内</span>
            </dd>
        </dl>
        <dl>
            <dt>SEO关健字</dt>
            <dd>
                <textarea name="seoKeywords" rows="2" cols="20" id="txtSeoKeywords" class="input" datatype="*0-255" sucmsg=" "><#if goods??>${goods.seoKeywords!""}</#if></textarea>
                <span class="Validform_checktip">以“,”逗号区分开，255个字符以内</span>
            </dd>
        </dl>
        <dl>
            <dt>SEO描述</dt>
            <dd>
                <textarea name="seoDescription" rows="2" cols="20" id="txtSeoDescription" class="input" datatype="*0-255" sucmsg=" "><#if goods??>${goods.seoDescription!""}</#if></textarea>
                <span class="Validform_checktip">255个字符以内</span>
            </dd>
        </dl>
    </div>
    
    
    
    <!--/内容-->
    <!--工具栏-->
    <div class="page-footer">
        <div class="btn-list">
            <input type="submit" name="btnSubmit" value="提交保存" id="btnSubmit" class="btn">
            <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript:history.back(-1);">
        </div>
        <div class="clear">
        </div>
    </div>
    <!--/工具栏-->
    </form>
</body>
</html>