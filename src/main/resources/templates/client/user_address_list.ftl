<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>惠资生活</title>
<meta name="keywords" content="惠资生活" />
<meta name="description" content="惠资生活" />
<meta name="copyright" content="惠资生活 版权所有" />
<link href="/client/css/layout.css" rel="stylesheet" type="text/css" />
<link href="/client/css/style.css" rel="stylesheet" type="text/css" />
<link href="/client/css/common.css" rel="stylesheet" type="text/css" />
<link href="/client/css/mymember.css" rel="stylesheet" type="text/css" />
<!--<link href="/client/css/member.css" rel="stylesheet" type="text/css" />-->
<script src="/client/js/jquery-1.9.1.min.js"></script>
<script src="/client/js/Validform_v5.3.2_min.js"></script>
<script src="/client/js/common.js"></script>
<script src="/client/js/ljs-v1.01.js"></script>
<script src="/client/js/mymember.js"></script>
<script src="/client/js/jquery.cityselect.js"></script>

<script type="text/javascript">
$(function () {

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
    
    $("#address").citySelect({
        nodata:"none",
        <#if address?? && address.province??>prov: "${address.province!''}",</#if>
        <#if address?? && address.city??>city: "${address.city!''}",</#if>
        <#if address?? && address.disctrict??>dist: "${address.disctrict!''}",</#if>
        required:false
    }); 
});
</script>  

</head>
<body>
<!-- header开始 -->
<#include "/client/common_header.ftl" />
<!-- header结束 -->
<div class="mymember_out">
  <div class="mymember_main">
    <div class="myclear" style="height:20px;"></div>
    <#include "/client/common_user_menu.ftl" />
    <#-- 左侧菜单结束 -->
    <!--mymember_menu END-->
    
    <div class="mymember_mainbox">
      <div class="mymember_info mymember_info02">
        <h3>收货地址</h3>
        
		
		<div class="haoh pt15 geren_rig">
        <table class="center_tab">
          <tbody>
          <tr>
            <th>收货人</th>
            <th>地区</th>
            <th>邮政编码</th>
            <th>联系电话</th>
            <th>详细地址</th>
            <th>操作</th>
          </tr>
          
          <#if address_list??>
            <#list address_list as address>
                <tr>
                    <td>${address.receiverName!''}</td>
                    <td>${address.province!''}${address.city!''}${address.disctrict!''}</td>
                    <td>${address.postcode!''}</td>
                    <td>${address.receiverMobile!''}</td>
                    <td>${address.detailAddress!''}</td>
                    <td>
                      <p><a href="/user/address/update?id=${address.id?c}">修改</a></p>
                      <p><a href="/user/address/delete?id=${address.id?c}">删除</a></p>
                    </td>
                  </tr>
            </#list>
          </#if>
        </tbody></table>
        
    <div class="h40"></div>
    <h4>增加/修改</h4>
    <form method="post" action="/user/address/save" id="form1">
    <table class="mymember_address">
      <input class="mytext" name="addressId" type="hidden" value="<#if address??>${address.id?c}</#if>">
      <tbody>
      <tr>
        <th>收货人：</th>
        <td>
            <input class="mytext" name="receiverName" datatype="*2-128" errormsg="最少两个字符！" value="<#if address??>${address.receiverName}</#if>" type="text">
            <span class="Validform_checktip">*收货人姓名</span>
        </td>
      </tr>
      <tr>
        <th>地区：</th>
        <td>
          <div id="address">
          <select name="province" class="prov" style="width: 100px;" datatype="*"></select>
          <select name="city" class="city" style="width: 100px;" datatype="*"></select>
          <select name="disctrict" class="dist" style="width: 100px;" datatype="*0-10"></select>
          </div>
        </td>
      </tr>
      <tr>
        <th>详细地址：</th>
        <td>
            <input class="mytext" name="detailAddress" datatype="*2-128" errormsg="最少两个字符！" value="<#if address??>${address.detailAddress}</#if>" type="text">
            <span class="Validform_checktip">*详细地址</span>
        </td>
      </tr>
      <tr>
        <th>邮政编码：</th>
        <td>
            <input class="mytext" name="postcode" datatype="p" errormsg="邮政编码为6位数字！" value="<#if address??>${address.postcode}</#if>" type="text">
            <span class="Validform_checktip">*邮政编码</span>
        </td>
      </tr>
      <tr>
        <th>联系电话：</th>
        <td>
            <input class="mytext" name="receiverMobile" datatype="n8-12" errormsg="请输入正确的电话号码格式！" value="<#if address??>${address.receiverMobile}</#if>" type="text">
            <span class="Validform_checktip">*电话号码</span>
        </td>
      </tr>
      <tr>
        <th></th>
        <td><input class="mysub" type="submit" value="保存"></td>
      </tr>
    </tbody>
    </table>
    
    </form>
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
