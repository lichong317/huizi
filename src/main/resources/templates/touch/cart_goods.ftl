<#if cart_goods_list?? && cart_goods_list?size gt 0>
    <#assign allChecked=true >
    <#assign totalGoods=0>
    <#assign totalPrice=0>
    <#list cart_goods_list as cg>
         <div class="prolist mainbox bot-border whitebg">
              <a href="/touch/goods/${cg.goodsId?c}" class="img"><img src="${cg.goodsCoverImageUri!''}" /></a>
              <section>
              <p class="h07 oh">${cg.goodsTitle!''}</p>
              <div class="numbox mt10 mb10"><a href="javascript:minusNum(${cg.id?c});"></a><input class="text" type="text" value="${cg.quantity!''}" disabled="disabled"/><a class="num01" href="javascript:addNum(${cg.id?c});"></a></div>
              <p class="red">￥${(cg.price*cg.quantity)?string("0.00")}</p>
              </section>
              <div class="clear"></div>
              <a class="del" href="javascript:delCartItem(${cg.id?c});"><img src="/touch/images/del.png" /></a>
         </div>
         <#if cg.isSelected>
               <#assign totalGoods=totalGoods+cg.quantity>
               <#assign totalPrice=totalPrice+cg.price*cg.quantity>
         </#if>
    </#list>
    <div class="carfoot_bg clear"></div>
    <footer class="carfoot mainbox">
      <p class="pt20 pb10"><#if cart_goods_list??>${cart_goods_list?size}</#if>件商品</p>
      <p class="pb20">合计<span class="red ml10 mr10">￥<#if cart_goods_list??>${totalPrice?string("0.00")}</#if></span>不含运费</p>
      <input type="submit" value="去结算" class="sub" onclick="window.location.href='/touch/order/info<#if shareId??>?shareId=${shareId}</#if>'"/>
    </footer>
<#else>
     <div>
        <p style="text-align:center">购物车空空的哦，去看看心意的商品吧！</p>
        <p style="text-align:center"><a class="blue" href="/touch/">马上去购物>>  </a></p>
    </div>
</#if>


