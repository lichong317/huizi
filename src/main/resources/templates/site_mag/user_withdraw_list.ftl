<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mag/style/idialog.css" rel="stylesheet" id="lhgdialoglink">
<title>用户管理</title>
<script type="text/javascript" src="/mag/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/mag/js/lhgdialog.js"></script>
<script type="text/javascript" src="/mag/js/layout.js"></script>
<link href="/mag/style/pagination.css" rel="stylesheet" type="text/css">
<link href="/mag/style/style.css" rel="stylesheet" type="text/css">
</head>

<body class="mainbody"><div class="" style="left: 0px; top: 0px; visibility: hidden; position: absolute;"><table class="ui_border"><tbody><tr><td class="ui_lt"></td><td class="ui_t"></td><td class="ui_rt"></td></tr><tr><td class="ui_l"></td><td class="ui_c"><div class="ui_inner"><table class="ui_dialog"><tbody><tr><td colspan="2"><div class="ui_title_bar"><div class="ui_title" unselectable="on" style="cursor: move;"></div><div class="ui_title_buttons"><a class="ui_min" href="javascript:void(0);" title="最小化" style="display: inline-block;"><b class="ui_min_b"></b></a><a class="ui_max" href="javascript:void(0);" title="最大化" style="display: inline-block;"><b class="ui_max_b"></b></a><a class="ui_res" href="javascript:void(0);" title="还原"><b class="ui_res_b"></b><b class="ui_res_t"></b></a><a class="ui_close" href="javascript:void(0);" title="关闭(esc键)" style="display: inline-block;">×</a></div></div></td></tr><tr><td class="ui_icon" style="display: none;"></td><td class="ui_main" style="width: auto; height: auto;"><div class="ui_content" style="padding: 10px;"></div></td></tr><tr><td colspan="2"><div class="ui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="ui_r"></td></tr><tr><td class="ui_lb"></td><td class="ui_b"></td><td class="ui_rb" style="cursor: se-resize;"></td></tr></tbody></table></div>
<form name="form1" method="post" action="/Verwalter/user/withdraw/list" id="form1">
<div>
<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="${__EVENTTARGET!""}">
<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="${__EVENTARGUMENT!""}">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="${__VIEWSTATE!""}" >
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
<div class="location" style="position: static; top: 0px;">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a href="/Verwalter/center" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>分销(商城)用户</span>
  <i class="arrow"></i>
  <span>提现列表</span>  
</div>
<!--/导航栏-->

<!--工具栏-->
<div class="toolbar-wrap">
  <div id="floatHead" class="toolbar" style="position: static; top: 42px;">
    <div class="l-list">
      <ul class="icon-list">
        <#--<li><a onclick="return ExePostBack('btnVerify','通过审核后退换货将生效，是否继续？');" class="save" href="javascript:__doPostBack('btnVerify','')"><i></i><span>审核</span></a></li>-->
        <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
        <li><a onclick="return ExePostBack('btnDelete');" id="btnDelete" class="del" href="javascript:__doPostBack('btnDelete','')"><i></i><span>删除</span></a></li>
      </ul>
     <#-- <div class="menu-list">
        <div class="rule-single-select single-select">
        <select name="statusId" onchange="javascript:setTimeout(__doPostBack('statusId',''), 0)" style="display: none;">
            <option <#if !statusId??>selected="selected"</#if> value="">所有状态</option>
            <option <#if statusId?? && statusId==0>selected="selected"</#if> value="0">待审核</option>
            <option <#if statusId?? && statusId==1>selected="selected"</#if> value="1">已审核</option>
        </select>
        </div>
      </div> -->
    </div>
   <#--> <div class="r-list">
      <input name="keywords" type="text" class="keyword" value="${keywords!""}">
      <a id="lbtnSearch" class="btn-search" href="javascript:__doPostBack('btnSearch','')">查询</a>
    </div> -->
  </div>
</div>
<!--/工具栏-->

<!--列表-->

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
  <tbody>
  <tr class="odd_bg">
    <th width="8%">选择</th>
    <th align="center">用户名</th>
    <th align="center">用户类型</th>
    <th align="center" width="10%">真实姓名</th>
    <th align="center" width="6%">提现金额</th>
    <th align="center" width="5%">提现时间</th>
    <th align="center" width="12%">开户行</th>
    <th align="center" width="3%">银行卡号</th>
    <th width="12%">手机号码</th>
    <th width="8%">是否审核</th>
    <th width="8%">操作</th>
  </tr>

    <#if withdraw_page??>
        <#list withdraw_page.content as withdraw>
            <tr>
                <td align="center">
                    <span class="checkall" style="vertical-align:middle;">
                        <input id="listChkId" type="checkbox" name="listChkId" value="${withdraw_index}" >
                    </span>
                    <input type="hidden" name="listId" id="listId" value="${withdraw.id?c}">
                </td>
                <td align="center">${withdraw.username!""}</td>
                <td align="center">
                <#if  withdraw.roleId?? && withdraw.roleId == 1>
                    分销会员
                <#elseif withdraw.roleId?? && withdraw.roleId == 2>
                                             商城会员
                <#elseif withdraw.roleId?? && withdraw.roleId == 3>
                                            直营会员
                </#if>
                </td>
                <td align="center">${withdraw.realName!""}</td>
                <td align="center">${withdraw.totalWithdraw?string("0.00")}</td>
                <td align="center">${withdraw.withdrawTime!""}</td>
                <td align="center">${withdraw.bankName!""}</td>
                <td align="center">${withdraw.bankCardNumber!""}</td>
                <td align="center">${withdraw.mobile!''}</td>             
                <td align="center">
                    <#if withdraw.statusId?? && withdraw.statusId==0>
                        待审核
                    <#elseif withdraw.statusId?? && withdraw.statusId==1>
                        已审核
                    </#if>
                </td>
                <td align="center">
                <#if withdraw.statusId?? && withdraw.statusId==0>
                    <a href="/Verwalter/user/withdraw/edit?id=${withdraw.id?c}">修改</a>
                </#if>
                </td>
            </tr>
        </#list>
    </#if>
     
</tbody>
</table>

<!--/列表-->

<!--内容底部-->
<#assign PAGE_DATA=withdraw_page />
<#include "/site_mag/list_footer.ftl" />
<!--/内容底部-->
</form>


</body></html>