<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mag/style/idialog.css" rel="stylesheet" id="lhgdialoglink">
<title>奖项</title>
<script type="text/javascript" src="/mag/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/mag/js/lhgdialog.js"></script>
<script type="text/javascript" src="/mag/js/layout.js"></script>
<link href="/mag/style/pagination.css" rel="stylesheet" type="text/css">
<link href="/mag/style/style.css" rel="stylesheet" type="text/css">
</head>

<body class="mainbody">
<form name="form1" method="post" action="/Verwalter/redenvelope/list" id="form1">
<div>
<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="${__EVENTTARGET!""}">
<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="${__EVENTARGUMENT!""}">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="${__VIEWSTATE!""}">
</div>
<script type="text/javascript">
var theForm = document.forms['form1'];
if (!theForm) {
    theForm = document.form1;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
</script>
<!--导航栏-->
<div class="location">
  <a href="/Verwalter/redenvelope/list" class="back"><i></i><span>返回列表页</span></a>
  <a href="/Verwalter/center" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>红包发放列表</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div class="toolbar-wrap">
  <div id="floatHead" class="toolbar">
    <div class="l-list">
      <ul class="icon-list">
        <#--><li><a class="add" href="/Verwalter/prizecategory/edit"><i></i><span>新增</span></a></li> -->
        <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
        <#--><li><a id="btnSave" class="save" href="javascript:__doPostBack('btnSave','')"><i></i><span>保存</span></a></li> -->
        <li><a onclick="return ExePostBack('btnDelete');" id="btnDelete" class="del" href="javascript:__doPostBack('btnDelete','')"><i></i><span>删除</span></a></li>
      </ul>
    </div>
  </div>
</div>
<!--/工具栏-->

<!--列表-->

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
  <tbody>
  <tr class="odd_bg">
    <th width="8%">选择</th>
    <th align="left">发放用户</th>
    <th align="left" width="17%">奖品</th>
    <th align="center" width="17%">发放日期</th> 
    <th align="left" width="17%">是否领取</th> 
    <th align="center" width="17%">领取日期</th> 
    <#--><th align="left" width="12%">排序</th>
    <th width="10%">操作</th>-->
  </tr>

    <#if TdRedEnvelope_page??>
        <#list TdRedEnvelope_page.content as item>
            <tr>
                <td align="center">
                    <span class="checkall" style="vertical-align:middle;">
                        <input id="listChkId" type="checkbox" name="listChkId" value="${item_index}" >
                    </span>
                    <input type="hidden" name="listId" id="listId" value="${item.id?c}">
                </td>
                <td>${item.username!''}</td>
                <#if item.redEnvelopeType == 0>
                    <td>奖励积分${item.prizePoints!''}</td>
                <#elseif item.redEnvelopeType == 1>
                    <td><a href="/Verwalter/coupon/type/edit<#if item.couponTypeId??>?id=${item.couponTypeId?c}</#if>">${item.couponTitle!''}</a></td>
                <#elseif item.redEnvelopeType == 2>
                    <td><a href="/Verwalter/goods/edit<#if item.goodsId??>?id=${item.goodId?c}</#if>">${item.goodsTitle!''}</a></td>
                </#if>               
                <td align="center"><#if item.sendTime??>${item.sendTime?string("yyyy-MM-dd HH:mm:ss")}</#if></td>
                <td>
                    <#if item.isGet??>
                        <#if item.isGet>
                                                                                                  已领取
                        <#else>
                                                                                                  未领取
                        </#if>
                    </#if>
                </td>
                <td align="center"><#if item.getTime??>${item.getTime?string("yyyy-MM-dd HH:mm:ss")}</#if></td>
              </tr>
        </#list>
    </#if>
 
  </tbody>
</table>

<!--/列表-->

<!--内容底部-->
<#assign PAGE_DATA=TdRedEnvelope_page />
<#include "/site_mag/list_footer.ftl" />
<!--/内容底部-->
</form>

</body></html>