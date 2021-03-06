<div class="mymember_menu">
    <div class="mymember_menu_part">
        <a class="mymember_menu_tit" href="/user/order/list/0"><img src="/client/images/mymember/menu01.png" />订单中心</a>
        <div>
            <a href="/user/order/list/0">我的订单</a>
   <!--         <a href="/user/order/list/1">待确认订单</a>
            <a href="/user/order/list/2">待付款订单</a> 
            <a href="/user/order/list/4">待收货订单</a> 
            <a href="/user/order/list/7">待评价订单</a>
            <a href="/user/order/list/7">取消订单记录</a>
         -->
            <a href="/user/comment/list">评价结单</a>
            <a href="/user/cancel/list">取消订单记录</a>
        </div>
    </div>
    
    <div class="mymember_menu_part">
        <a class="mymember_menu_tit" href="/user/collect/list"><img src="/client/images/mymember/menu02.png" />关注中心</a>
        <div>
            <a href="/user/collect/list">关注商品</a>
            <a href="/user/recent/list">浏览历史</a>
        </div>
    </div>
    
    <div class="mymember_menu_part">
        <a class="mymember_menu_tit" href="/user/point/list"><img src="/client/images/mymember/menu03.png" />资产中心</a>
        <div>
            <a href="/user/coupon/list/0">优惠券</a>
            <a href="/user/point/list">积分</a>
            <a href="/user/redenvelope/list">红包</a>
            <a href="/user/myprize/list">我的奖品</a>
            <#if user?? && user.roleId?? && user.roleId == 1>
                <a href="/user/junioruser/list">下级用户</a>
                <a href="/user/account/info">账户信息</a>
            </#if>
            <#if user?? && user.roleId?? && user.roleId == 2>
                <a href="/user/mall/account/info">账户信息</a>
            </#if>
            <#if user?? && user.roleId?? && user.roleId == 3>
                <a href="/user/mall/account/info">账户信息</a>
            </#if>
        </div>
    </div>
    
    <div class="mymember_menu_part">
        <a class="mymember_menu_tit" href="/user/return/list"><img src="/client/images/mymember/menu04.png" />客户服务</a>
        <div>
            <a href="/user/return/list">返修退换货</a>
            <a href="/user/complain/list">我的投诉</a>
            <a href="/user/consult/list">购买咨询</a>
        </div>
    </div>
    
    <div class="mymember_menu_part">
        <a class="mymember_menu_tit" href="/user/info"><img src="/client/images/mymember/menu05.png" />设置</a>
        <div>
            <a href="/user/info">个人信息</a>
            <a href="/user/password">修改密码</a>
            <#--<a href="#">修改绑定手机</a> -->
            <a href="/user/address/list">收货地址</a>
        </div>
    </div>
</div>