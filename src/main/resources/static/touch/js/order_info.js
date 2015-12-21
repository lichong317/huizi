$(document).ready(function(){
    
    var selectAddress = function()
    {
        $(this).parent().siblings().children("a").removeClass("sel");
        $(this).addClass("sel");
        $("#input-address-id").val($(this).attr("aid"));
        
      //判断是否支持货到付款
        var addressId = $(this).attr("aid");
        $.ajax({
            type: "post",
            url: "/order/codDistrict",
            data: { "addressId": addressId},
            dataType: "json",
            success: function (data) {
                    if (data.code == 0) {
                         $("#notcodaddress1").css("display", "none");
                         $("#idPayFaceToFace").css("display", "block");
                    } else {
                         $("#notcodaddress1").css("display", "block");
                         $("#idPayFaceToFace").css("display", "none");
                    }
             }
        });
    }
    
    // 选择地址
    $(".selAddress").click(selectAddress);
    
    // 配送方式切换
    $("#deliveryTypeSelect").change(function(){
        var deliPrice = parseFloat($(this).find("option:selected").attr("price"));
        var curPrice = parseFloat($("#currentPrice").html());
        var couponPrice = parseFloat($("#couponFeee").html());
        var pointPrice = parseFloat($("#idPointUse").val());
        
        $("#deliveryFee").html(deliPrice);
        if(curPrice + deliPrice < couponPrice + pointPrice){
        	$("#totalPrice").html(0);
        }
        $("#totalPrice").html(curPrice + deliPrice - couponPrice - pointPrice);
    });
    
    // 新增地址
    $("#addAddress").click(function(){
        $("#addressForm").toggleClass("hide");
    });
    
    $("#addAddressSubmit").click(function(){
        var receiverName = $("#receiverName").val();
        var prov = $("#prov").val();
        var city = $("#city").val();
        var dist = $("#dist").val();
        var detail = $("#detailAdd").val();
        var postcode = $("#postcode").val();
        var mobile = $("#mobile").val();
        
        if (undefined == receiverName || "" == receiverName)
        {
            alert("收货人不能为空");
            $("#receiverName").focus();
            return;
        }
        
        if (undefined == prov || "" == prov)
        {
            alert("省市不能为空");
            $("#prov").focus();
            return;
        }
        
        if (undefined == city || "" == city)
        {
            alert("省市不能为空");
            $("#city").focus();
            return;
        }
        
        if (undefined == detail || "" == detail)
        {
            alert("详细地址不能为空");
            $("#detailAdd").focus();
            return;
        }
        
        if (undefined == mobile || "" == mobile)
        {
            alert("联系电话不能为空");
            $("#mobile").focus();
            return;
        }
        
        $.ajax({
            type:"post",
            url:"/user/address/ajax/add",
            data:{
                "receiverName": receiverName, 
                "prov": prov,
                "city": city,
                "dist": dist,
                "detail": detail,
                "postcode": postcode,
                "mobile": mobile 
            },
            
            success:function(res) {
                if (0 == res.code)
                {
                    window.location.reload();
                }
                else
                {
                    alert(res.message);
                }
            }
        });
    });
    
    
});