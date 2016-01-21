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
<link rel="shortcut icon" href="/client/images/little_logo.ico" />
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
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
    
    //初始化表单验证
    $("#form1").Validform({
        tiptype: 3
    });
});

function showDialog()
{       
    $("#checkDialog").css("display", "block");
}

function hideDialog()
{
    $("#checkDialog").css("display", "none");
}
</script>
</head>
<style>
.logintop p { float:right; display:inline-block;_display:inline; padding:0 0 0 50px; height:80px; line-height:80px; margin-left:40px;}
.logintop p.p1 { background:url(../images/liebiao_44.png) no-repeat left center;}
.logintop p.p2 { background:url(../images/liebiao_41.png) no-repeat left center;}
.logintop p.p3 { background:url(../images/liebiao_39.png) no-repeat left center;}
.logingbg { width:100%; min-width:1200px; margin:0 auto; background:url(../images/login_bg.png) no-repeat center bottom; padding:30px 0;}
.loginbox { width:400px; background:#fff; margin:0 auto; padding:20px 50px;}
.loginbox p { margin:10px 0 5px;}
.loginbox .text { width:100%; height:35px; line-height:35px; border:1px solid #ddd;}
.loginbox .yzm01 { float:left; width:100px; height:37px; background:#0551a5; color:#fff; margin-left:10px;}
.loginbox .yzm02 { float:right; line-height:37px;}
.loginbox .sub { width:100%; border-radius:3px; background:#ff2727; color:#fff; line-height:35px; height:35px;}
.loginbox .sub:hover { background:#333;}
.loginfoot { width:100%; padding:100px 0 15px; text-align:center;} 
.loginfoot nav a { margin:0 20px;}
.loginfoot nav { padding:0 0 20px;}
.loginfoot p { padding-bottom:5px;}
.loginfoot p a { color:#555;}

</style>
<body>
<div id="checkDialog" class="mianfeilingqutanchu" style="display: none;position: fixed; top: 0px; left: 0px;">
    <div class="mianfeilingqutanchu_dl">
        <section class="loginbox">
            <a class="fr" style="z-index:999999999; /* margin-top:50px; */ margin-left: 410px;position: absolute;" href="javascript:hideDialog();"><img src="/client/images/20150407114113116_easyicon_net_71.8756476684.png" width="25" height="25"></a>
            <form id="form1" action="/user/withdraw/request" method="post">
                <span class="Validform_checktip">请填写提现信息</span>               
                <p><b style="color: #FF0000;">*</b> 提现金额(提现金额必须大于 <#if site?? && site.minWithdraw??>${site.minWithdraw?c}</#if> 才能通过审核)</p>
                <input class="text" name="withdraw" value="" type="text" datatype="n"  nullmsg="请输入金额"/>
                <p><b style="color: #FF0000;">*</b> 真实姓名</p>
                <input class="text" name="realName" value="<#if user??>${user.realName!''}</#if>" type="text" datatype="*"  nullmsg="请输入姓名"/>
                <p><b style="color: #FF0000;">*</b> 开户行</p>
                <input class="text" name="bankTitle" value="<#if user??>${user.bankTitle!''}</#if>" type="text" datatype="*" nullmsg="请输入开户行" />
                <p><b style="color: #FF0000;">*</b> 银行卡号</p>
                <input class="text" name="bankCardCode" value="<#if user??>${user.bankCardCode!''}</#if>" type="password" datatype="n" nullmsg="请输入卡号" errormsg="请输入正确的卡号"/>
                <p><b style="color: #FF0000;">*</b> 手机号</p>
                <input class="text" name="mobile" value="<#if user??>${user.mobile!''}</#if>" type="text" datatype="m" nullmsg="请输入手机号" errormsg="请输入正确的手机号"/>
                         
                <div class="clear h40"></div>
                <input type="submit" class="sub" value="提交申请" />
                <div class="clear h20"></div>
            </form>
        </section>
    </div>
</div>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="mymember_out">
  <div class="mymember_main">
    <div class="myclear" style="height:20px;"></div>
    <#include "/client/common_user_menu.ftl" />
    <#-- 左侧菜单结束 -->
    <div class="mymember_mainbox">
      <div class="mymember_info mymember_info02">
            <div class="usermain04">
                <div class="separationInfo sepBasic">
                 <h4>
                     账户信息<span id="TellToUser"></span>
                 </h4>
                </div>
               <#if user??> 
                    <p style="padding-top:10px">虚拟币余额:&nbsp;&nbsp;￥<b class="red"><#if user.virtualCurrency??>${user.virtualCurrency?string("0.00")}</#if></b></p>
                    <#--><p style="padding-top:10px">冻结金额:&nbsp;&nbsp;￥<b class="red"><#if user.frozenCapital??>${user.frozenCapital?string("0.00")}</#if></b></p> -->
                    <p style="padding-top:10px">可提现金额:&nbsp;&nbsp;￥<b class="red"><#if user.virtualCurrency?? &&  user.frozenCapital??>${(user.virtualCurrency - user.frozenCapital)?string("0.00")}</#if></b></p>
                    <HR style="BORDER-RIGHT: 1px dashed; BORDER-TOP: 1px dashed; BORDER-LEFT: 1px dashed; WIDTH: 590px; BORDER-BOTTOM: 1px dashed" color=#ffffff SIZE=3 align=center>
                    <p style="padding-top:10px">默认银行卡号:&nbsp;&nbsp;<#if user.bankCardCode?? && user.bankCardCode?length gt 19>${user.bankCardCode[0..4]?default("")}****${user.bankCardCode[17..19]?default("")}<#elseif user.bankCardCode?? && user.bankCardCode?length gt 4>${user.bankCardCode[0..4]?default("")}****</#if></p>           
                    <p style="padding-top:10px">默认开户行名称:&nbsp;&nbsp;${user.bankTitle!''}</p>
                    <a style="width:120px; margin:10px 20%; height:30px; text-align:center;padding-top:3px;
                              background:#13b5b1; color:#FFF; border-radius:20px; 
                              display:block; *float:left;"  href="javascript:showDialog()">申请提现</a>
                    
                <div class="separationInfo sepBasic">
                 <h4>
                     提现记录<span id="TellToUser"></span>
                 </h4>
                </div>
                 <table>
                    <tr class="mymember_infotab_tit01">
                        <th width="60">序号</th>
                        <th width="100">用户名</th>
                        <th width="100">真实姓名</th>
                        <th width="80">提现金额</th>
                        <th width="80">提现时间</th>
                        <th width="80">开户行</th>
                        <th width="90">银行卡号</th>
                        <th width="90">手机号码</th>
                        <th width="90">是否审核</th>                                
                    </tr>
                   <#if withdraw_page??>
        <#list withdraw_page.content as withdraw>
            <tr>
                <td align="center">
                    ${withdraw_index+1}
                </td>
                <td align="center">${withdraw.username!""}</td>
                <td align="center">${withdraw.realName!""}</td>
                <td align="center">${withdraw.totalWithdraw?string("0.00")}</td>
                <td align="center">${withdraw.withdrawTime!""}</td>
                <td align="center">${withdraw.bankName!""}</td>
                <td align="center">${withdraw.bankCardNumber!""}</td>
                <td align="center">${withdraw.mobile!''}</td>             
                <td align="center">
                    <#if withdraw.statusId?? && withdraw.statusId==1>
                        已审核
                    <#else>
                        未审核
                    </#if>
                </td>
                
            </tr>
        </#list>
    </#if>
                </table>
                <div class="myclear" style="height:10px;"></div>
            <div class="mymember_page">
                <#if withdraw_page??>
                    <#assign continueEnter=false>
                    <#if withdraw_page.totalPages gt 0>
                        <#list 1..withdraw_page.totalPages as page>
                            <#if page <= 3 || (withdraw_page.totalPages-page) < 3 || (withdraw_page.number+1-page)?abs<3 >
                                <#if page == withdraw_page.number+1>
                                    <a class="mysel" href="javascript:;">${page}</a>
                                <#else>
                                    <a href="/user/account/info?page=${page-1}">${page}</a>
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
               </#if> 
          </div>
      </div>
      <!--mymember_info END-->
      
    </div>
    <!--mymember_center END-->
    <div class="myclear"></div>
  </div>
  <!--mymember_main END-->
  <div class="myclear"></div>
</div>
<!--主体结束-->
<#include "/client/common_footer.ftl" />
</body>
</html>
<!--结束-->
