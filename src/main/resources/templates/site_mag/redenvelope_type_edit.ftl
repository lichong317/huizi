<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mag/style/idialog.css" rel="stylesheet" id="lhgdialoglink">
<title>编辑优惠券类型</title>
<script type="text/javascript" src="/mag/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/mag/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/mag/js/lhgdialog.js"></script>
<script type="text/javascript" src="/mag/js/layout.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.queue.js"></script>
<script type="text/javascript" src="/mag/js/swfupload.handlers.js"></script>
<link href="/mag/style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(function () {
    //初始化表单验证
    $("#form1").initValidform();
    
    //初始化上传控件
    $(".upload-img").each(function () {
        $(this).InitSWFUpload({ 
            sendurl: "/Verwalter/upload", 
            flashurl: "/mag/js/swfupload.swf"
        });
    });
    
    //（缩略图）
    var txtPic = $("#txtImgUrl").val();
    if (txtPic == "" || txtPic == null) {
        $(".thumb_ImgUrl_show").hide();
    }
    else {
        $(".thumb_ImgUrl_show").html("<ul><li><div class='img-box1'><img src='" + txtPic + "' bigsrc='" + txtPic + "' /></div></li></ul>");
        $(".thumb_ImgUrl_show").show();
    }
});
</script>
</head>

<body class="mainbody">
<form name="form1" method="post" action="/Verwalter/redenvelopeType/save" id="form1">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="${__VIEWSTATE!""}">
<input name="redenvelopeTypeId" type="text" value='<#if redenvelopeType??>${redenvelopeType.id?c}</#if>' style="display:none">
</div>

<!--导航栏-->
<div class="location">
  <a href="/Verwalter/redenvelopeType/list" class="back"><i></i><span>返回列表页</span></a>
  <a href="/Verwalter/center" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <a href="/Verwalter/redenvelopeType/list"><span>红包类型</span></a>
  <i class="arrow"></i>
  <span>编辑红包类型</span>
</div>
<div class="line10"></div>
<!--/导航栏-->

<!--内容-->
<div class="content-tab-wrap">
  <div id="floatHead" class="content-tab">
    <div class="content-tab-ul-wrap">
      <ul>
        <li><a href="javascript:;" onclick="tabs(this);" class="selected">编辑信息</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="tab-content">
  <dl>
    <dt>红包名称</dt>
    <dd>
        <input name="title" type="text" value="<#if redenvelopeType??>${redenvelopeType.title!""}</#if>" class="input normal" datatype="*2-100" sucmsg=" "> 
        <span class="Validform_checktip">*名称</span>
    </dd>
  </dl>
  
  <dl>
      <dt>红包类型</dt>
      <dd>
            <div class="rule-single-select">
            <select name="redEnvelopeType" datatype="*" sucmsg=" ">
                <option value="" <#if !redenvelopeType?? || !redenvelopeType.redEnvelopeType??>selected="selected"</#if>>请选择</option>
                <option value="0" <#if redenvelopeType?? && redenvelopeType.redEnvelopeType == 0>selected="selected"</#if>>赠送积分</option>
                <option value="1" <#if redenvelopeType?? && redenvelopeType.redEnvelopeType == 1>selected="selected"</#if>>赠送优惠券</option>                
            </select>
            </div>
      </dd>
  </dl>
  
  <dl>
       <dt>红包数量</dt>
       <dd>
             <input name="prizeNumber" type="text" value="<#if redenvelopeType?? && redenvelopeType.prizeNumber??>${redenvelopeType.prizeNumber?c!"1"}<#else>1</#if>" class="input normal" datatype="n" sucmsg=" ">
             <span class="Validform_checktip">红包数量</span>
       </dd>
  </dl>
  
  <dl>
       <dt>红包余量</dt>
       <dd>
             <input name="leftNumber" type="text" value="<#if redenvelopeType?? && redenvelopeType.leftNumber??>${redenvelopeType.leftNumber?c!"1"}<#else>1</#if>" class="input normal" datatype="n" sucmsg=" ">
             <span class="Validform_checktip">为0时红包失效</span>
       </dd>
  </dl>
  
  <dl>
      <dt>奖励积分数量</dt>
      <dd>
          <input name="prizePoints" type="text" value="<#if redenvelopeType?? && redenvelopeType.prizePoints?? >${redenvelopeType.prizePoints!'0'}<#else>0</#if>" class="input normal" datatype="/^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/" sucmsg=" ">
          <span class="Validform_checktip">奖励用户积分数，仅对积分类奖品有效</span>
      </dd>
  </dl>
  
   <dl>
        <dt>奖励优惠券类型</dt>
        <dd>
            <div class="rule-single-select">
            <select name="couponTypeId" datatype="n0-5">
                <option <#if redenvelopeType?? && redenvelopeType.couponTypeId??><#else>selected="selected"</#if> value="">请选择</option>
                <#if tdcouponType_list??>
                    <#list tdcouponType_list as item>
                        <option value="${item.id?c}" <#if redenvelopeType?? && redenvelopeType.couponTypeId?? && item.id==redenvelopeType.couponTypeId>selected="selected"</#if> >${item.title!''}</option>
                    </#list>
                </#if>
            </select>
            </div>
            <span class="Validform_checktip">奖励优惠券类型，仅对优惠券类奖品有效</span>
        </dd>
    </dl>
  <dl>
    
 <dl>
    <dt>奖项图片</dt>
    <dd>
        <input id="txtImgUrl" name="picUri" type="text" datatype="*" value="<#if prizeCategory??>${prizeCategory.picUri!""}</#if>" class="input normal upload-path">
        <div class="upload-box upload-img"></div>
        <div class="photo-list thumb_ImgUrl_show"></div>
        <span class="Validform_checktip"></span>
    </dd>
  </dl> 
  
  <dl>
    <dt>排序数字</dt>
    <dd>
      <input name="sortId" type="text" value="<#if redenvelopeType??>${redenvelopeType.sortId!""}<#else>99</#if>" class="input small" datatype="n" sucmsg=" ">
      <span class="Validform_checktip">*数字，越小越向前</span>
    </dd>
  </dl>
  
  <dl>
    <dt>描述说明</dt>
    <dd>
      <textarea name="description" rows="2" cols="20" class="input normal"><#if redenvelopeType??>${redenvelopeType.description!""}</#if></textarea>
      <span class="Validform_checktip"></span>
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
  <div class="clear"></div>
</div>
<!--/工具栏-->
</form>


</body></html>