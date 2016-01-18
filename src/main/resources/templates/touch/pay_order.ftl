<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="copyright" content="" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!--css-->
<link rel="stylesheet" type="text/css" href="/touch/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/touch/css/style.css"/>

<script src="/touch/js/message.js"></script>
<link href="/touch/css/message.css" rel="stylesheet" type="text/css" />

<script src="/touch/js/jquery-1.9.1.min.js"></script>
<script src="/touch/js/common.js"></script>
<script language="javascript" src="http://res.mail.qq.com/mmr/static/lib/js/jquery.js" type="text/javascript"></script>
<script language="javascript" src="http://res.mail.qq.com/mmr/static/lib/js/lazyloadv3.js" type="text/javascript"></script>
<script type="text/javascript">
function onBridgeReady(){
    var data = {
            "appId": "${appId}", //公众号名称，由商户传入
            "timeStamp": "${timeStamp}", //时间戳
            "nonceStr": "${nonceStr}", //随机串
            "package": "${package}",//扩展包
            "signType": "MD5", //微信签名算法：MD5
            "paySign": "${paySign}" //微信签名
        };
   WeixinJSBridge.invoke(
       'getBrandWCPayRequest', data,
       function(res){
           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
            //alert("支付成功");
            ct.alert({
                    text: "支付成功",
                    type: "alert"
            });
            
            window.location.href="/touch/user/order?id=${orderId?c}";
             // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
           }
           else if (res.err_msg == "get_brand_wcpay_request:cancel")
           {
               //alert("取消支付！");
               ct.alert({
                    text: "取消支付！",
                    type: "alert"
               });
               window.location.href="/touch/user/order?id=${orderId?c}";
           }
           else{
               //alert("支付失败！");
               ct.alert({
                    text: "支付失败！",
                    type: "alert"
               });
               window.location.href="/touch/user/order?id=${orderId?c}";
           }
       }
   );
}


</script>

<title>惠之店</title>
</head>
<body>

    <!-- 头部 -->
    <div class="maintop_bg"></div>
    <header class="maintop">
      <div class="main">
        <p>确认支付</p>
        <a class="a1" href="javascript:history.go(-1);"><img src="/touch/images/back.png" height="22" /><span style=" top:-5px !important;">返回</span></a>
      </div>
    </header>
    <!-- 头部 END -->

    <!-- 支付 -->
    <!--main-->
    <div class="main">
      <p style="font-size: 16px; padding: 10px;">订单号：</p>
    
      <p style="font-size: 16px; font-weight: bold; padding: 10px; border-bottom: solid 2px #f1f1f1; line-height: 40px; color: #5fc325;">${order.orderNumber!''}</p>
      
      <p style="font-size: 16px; padding: 10px;">支付金额：￥<span style="color:red">${order.totalPrice?string('0.00')}</span></p>
      
      <p style="font-size: 16px; padding: 10px;">支付方式：<span style="color: #8f8f8f;">请在30分钟内完成支付</span></p>
    
      <p style="font-size: 16px; font-weight: bold; padding: 10px; border-bottom: solid 2px #f1f1f1; line-height: 145px; height: 94px;  text-align: center; background: url(/touch/images/iconfont-weixinzhifu.png) no-repeat center top;background-size: 50px; margin-top: 15px;">
      微信支付</p>
    
      <div style="text-align: center; margin-top: 20px;"><a style="  line-height: 40px; background:#5fc325; color: #FFF;  padding: 8px 51px;text-align: center;  " href="javascript:onBridgeReady();">立即支付</a></div>
    </div>

    <!-- 支付 END -->

</body>
</html>