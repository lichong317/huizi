<#if order_page??>
        <#list order_page.content as order>
            <div class="myorder_list">        
                <h2>订单编号&nbsp; <a href="/touch/user/order?id=${order.id?c}">${order.orderNumber!''}</a><span><#if order.orderTime??>${order.orderTime[0..8]?default("")}</#if></span></h2>
                <#if order.orderGoodsList??>
                    <#list order.orderGoodsList as ordergoods>
                        <a class="a1" href="/touch/goods/${ordergoods.goodsId?c}">
                             <span class="sp1"><img src="${ordergoods.goodsCoverImageUri!''}" width="62" height="62"/></span>
                             <p class="mb10">${ordergoods.goodsTitle!''}</p>
                             <p>单价：<span class="sc">￥<#if ordergoods.price??>${ordergoods.price?string("0.00")}</#if></span>&nbsp;&nbsp;数量：${ordergoods.quantity!'0'}</p>
                             <div class="clear"></div>
                        </a>
                    </#list>
                </#if>
               
                <p style="width:90%; float:left; margin:10px; font-size:0.8em;">共<span>${order.orderGoodsList?size}</span>件商品，合计:&nbsp;&nbsp;<span class="red">¥<#if order.totalPrice??>${order.totalPrice?string("0.00")}</#if></span>元</p>
                <span style="width:100%; float:left; ">
                <#if order.statusId==2 >
                    <a href="/order/dopay/${order.id?c}" class="a2">去付款</a>
                    <a href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()" class="a2">取消订单</a>
                <#elseif order.statusId==1>
                    <a href="/touch/user/cancel/direct?id=${order.id?c}" onClick="cancelConfirm()" class="a2">取消订单</a>  
                <#elseif order.statusId==4>
                    <a href="javascript:orderReceive(${order.id?c});" onClick="receiveConfirm()" class="a2">确认收货</a>
                <#elseif order.statusId==5>
                    <a href="/touch/user/comment/list?keywords=${order.orderNumber!''}" class="a2">去评价</a> 
                <#elseif order.statusId==6>
                    <a href="/touch/user/return/list?keywords=${order.orderNumber!''}" class="a2" style="width:35%">申请返修/退换货</a>
                    <a href="/touch/user/order/delete?id=${order.id?c}" onClick="deleteConfirm()" class="a2">删除订单</a>
                <#elseif order.statusId==7>
                    <a href="/touch/user/return/list?keywords=${order.orderNumber!''}" class="a2" style="width:35%">申请返修/退换货</a> 
                    <a href="/touch/user/order/delete?id=${order.id?c}" onClick="deleteConfirm()" class="a2">删除订单</a> 
                </#if>
                </span>
                <div class="clear"></div>
            </div>
        </#list>
    </#if>