<#if cart_goods_list?? && cart_goods_list?size gt 0>
    <#assign allChecked=true >
    <#assign totalGoods=0>
    <#assign totalPrice=0>
    <#list cart_goods_list as cg>
        <section class="carlist">
            <b><img src="${cg.goodsCoverImageUri!''}" width="152" height="100"/></b>
            <p><a href="/touch/goods/${cg.goodsId?c}">${cg.goodsTitle!''}</a></p>
            <#--><p class="pb5">规格：<span>MAX70-原装脚架</span></p>-->
            <p class="pb5"><span> </span></p>
            <div class="num">
                <span class="fl">数量：</span>
                <a href="javascript:minusNum(${cg.id?c});">-</a><input type="text" value="${cg.quantity!''}" /><a href="javascript:addNum(${cg.id?c});">+</a>
                <div class="clear"></div>
            </div>
            <p class="sc fr mt5" ><span class="sc">￥${cg.price?string("0.00")}</span>×<span>${cg.quantity!'1'}</span></p>
            <div class="clear"></div>
            <a class="a1" href="javascript:delCartItem(${cg.id?c});"><img src="/touch/images/delete.png" width="30" /></a>
            <#if cg.isSelected>
                <#assign totalGoods=totalGoods+cg.quantity>
                <#assign totalPrice=totalPrice+cg.price*cg.quantity>
            </#if>
        </section>  
    </#list>
    
   <footer class="mainfoot">
    <div class="main" style="background:#35424e;">
      <section class="car_price">
        <h3>合计：<span class="sc">￥<#if cart_goods_list??>${totalPrice?string("0.00")}</#if></span>（共<span><#if cart_goods_list??>${cart_goods_list?size}</#if></span>件商品）</h3>
        <a href="/touch/order/info<#if shareId??>?shareId=${shareId}</#if>">结算（<#if cart_goods_list??>${cart_goods_list?size}</#if>）</a>
        <div class="clear"></div>
      </section>
    </div>
  </footer>
<#else>
    <div>
        <p style="text-align:center">购物车空空的哦，去看看心意的商品吧！</p>
        <p style="text-align:center"><a class="blue" href="/touch/">马上去购物>>  </a></p>
    </div>
</#if>