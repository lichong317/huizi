<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>回复咨询</title>
<script type="text/javascript" src="/mag/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/mag/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/mag/js/lhgdialog.js"></script>
<script type="text/javascript" src="/mag/js/layout.js"></script>
<link href="/mag/style/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
    $(function () {
        //初始化表单验证
        $("#form1").initValidform();
    });
</script>
</head>

<body class="mainbody"><div class="" style="left: 0px; top: 0px; visibility: hidden; position: absolute;"><table class="ui_border"><tbody><tr><td class="ui_lt"></td><td class="ui_t"></td><td class="ui_rt"></td></tr><tr><td class="ui_l"></td><td class="ui_c"><div class="ui_inner"><table class="ui_dialog"><tbody><tr><td colspan="2"><div class="ui_title_bar"><div class="ui_title" unselectable="on" style="cursor: move;"></div><div class="ui_title_buttons"><a class="ui_min" href="javascript:void(0);" title="最小化" style="display: inline-block;"><b class="ui_min_b"></b></a><a class="ui_max" href="javascript:void(0);" title="最大化" style="display: inline-block;"><b class="ui_max_b"></b></a><a class="ui_res" href="javascript:void(0);" title="还原"><b class="ui_res_b"></b><b class="ui_res_t"></b></a><a class="ui_close" href="javascript:void(0);" title="关闭(esc键)" style="display: inline-block;">×</a></div></div></td></tr><tr><td class="ui_icon" style="display: none;"></td><td class="ui_main" style="width: auto; height: auto;"><div class="ui_content" style="padding: 10px;"></div></td></tr><tr><td colspan="2"><div class="ui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="ui_r"></td></tr><tr><td class="ui_lb"></td><td class="ui_b"></td><td class="ui_rb" style="cursor: se-resize;"></td></tr></tbody></table></div>
<form name="form1" method="post" action="/Verwalter/user/withdraw/save" id="form1">
<div>
<input type="hidden" name="__VIEWSTATE" value="">
<input type="hidden" name="userWithdrawId" value="${userWithdrawId!""}">
</div>
<!--导航栏-->
<div class="location">
  <a href="/Verwalter/user/withdraw/list?statusId=${statusId!""}" class="back"><i></i><span>返回列表页</span></a>
  <a href="/Verwalter/center" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>分销(商城)用户</span>
  <i class="arrow"></i>
  <span>提现列表</span>
  <i class="arrow"></i>
  <span>提现审核</span>
</div>
<div class="line10"></div>
<!--/导航栏-->

<!--内容-->
<div class="content-tab-wrap">
  <div id="floatHead" class="content-tab">
    <div class="content-tab-ul-wrap">
      <ul>
        <li><a href="javascript:;" onclick="tabs(this);" class="selected">提现审核</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="tab-content">
  <dl>
    <dt>用户名</dt>
    <dd><#if user_withdraw??>${user_withdraw.username!""}</#if></dd>
  </dl>
  
  <dl>
    <dt>用户当前余额</dt>
    <dd>
    	<#if user?? && user.roleId?? && user.roleId == 1>
    		<span style="color:red">￥<#if user.totalCashRewards??>${user.totalCashRewards?string("0.00")}</#if></span>
    	<#elseif user?? && user.roleId?? && user.roleId == 2>
  	  	 <span style="color:red">￥<#if user.virtualCurrency??>${user.virtualCurrency?string("0.00")}</#if></span>
  	  	<#elseif user?? && user.roleId?? && user.roleId == 3>
  	  	 <span style="color:red">￥<#if user.directSaleCashRewards??>${user.directSaleCashRewards?string("0.00")}</#if></span>
    	</#if>
    </dd>
  </dl>
  
  <dl>
    <dt>真实姓名</dt>
    <dd><#if user_withdraw??>${user_withdraw.realName!""}</#if></dd>
  </dl>
  <dl>
    <dt>提现金额</dt>
    <dd><#if user_withdraw??>${user_withdraw.totalWithdraw?string("0.00")}</#if></dd>
  </dl>
  <dl>
    <dt>提现时间</dt>
    <dd><#if user_withdraw??>${user_withdraw.withdrawTime!""}</#if></dd>
  </dl>
  <dl>
    <dt>开户行</dt>
    <dd><#if user_withdraw??>${user_withdraw.bankName!""}</#if></dd>
  </dl>
  <dl>
    <dt>银行卡号</dt>
    <dd><#if user_withdraw??>${user_withdraw.bankCardNumber!""}</#if></dd>
  </dl>
  <dl>
    <dt>手机号码</dt>
    <dd><#if user_withdraw??>${user_withdraw.mobile!''}</#if></dd>
  </dl>
  <dl>
    <dt>审核状态</dt>
    <dd>
      <div class="rule-multi-radio multi-radio">
        <span style="display: none;">
            <input type="radio" name="statusId" value="1" <#if user_withdraw?? && user_withdraw.statusId?? && user_withdraw.statusId==1>checked="checked"</#if>>
            <label>已审核</label>
            <input type="radio" name="statusId" value="0" <#if !user_withdraw?? || !user_withdraw.statusId?? || user_withdraw.statusId==0>checked="checked"</#if>>
            <label>待审核</label>
        </span>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>备注</dt>
    <dd>
      <textarea name="reply" rows="2" cols="20" class="input normal"><#if user_consult??>${user_consult.reply!""}</#if></textarea>
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