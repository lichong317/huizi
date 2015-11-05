

<#if cart_goods_list?? && cart_goods_list?size gt 0>
    <div class="main">
        <div class="gwc1_lm mt20">
            <table>
                <tr>
                    <td>商品信息</td>
                    <td>单价</td>
                    <td>数量</td>
                    <td>合计</td>
                    <td>操作</td>
                </tr>
            </table>
        </div>
        
        <#assign allChecked=true >
        <#assign totalGoods=0>
        <#assign totalPrice=0>

        <div class="gwc1_lm2">
            <table>
            <#list cart_goods_list as cg>
                <tr>
                    <td class="gwc1_lm2_a">
                        <input type="checkbox" class="fll duoxuank" cgid="${cg.id?c}" <#if cg.isSelected>checked="checked"<#else><#assign allChecked=false></#if>>
                        <span>
                         <#if cg.qiang??&&cg.qiang==1>
                            <a href="/goods/${cg.goodsId?c}?qiang=1"><img src="${cg.goodsCoverImageUri!''}" width="76" height="76"></a>
                         <#elseif cg.qiang??&&cg.qiang!=1>
                            <a href="/goods/${cg.goodsId?c}?qiang=3"><img src="${cg.goodsCoverImageUri!''}" width="76" height="76"></a>
                         <#else>
                            <a href="/goods/${cg.goodsId?c}"><img src="${cg.goodsCoverImageUri!''}" width="76" height="76"></a>
                         </#if>
                        </span>
                        <p><a href="goods/${cg.goodsId?c}"><p>${cg.goodsTitle!''}</p></a></td>
                    <td class="gwc1_lm2_b"><span>￥${cg.price?string("0.00")}</span></td>
                    <td class="gwc1_lm2_c">
                        <div class="ds content_nr_3_jg2">
                            <#if cg.quantity==1>
                                <span class="fl"><img src="/client/images/slj.png" width="20" height="20"></span>
                            <#else>
                                <a href="javascript:void(0);" class="fl num_minus" cgid="${cg.id?c}"><img src="/client/images/slj.png" width="20" height="20"></a>
                            </#if>
                            <input type="text" class="content_zj" value="${cg.quantity!''}">
                            <#if cg.qiang??&&cg.qiang==1>
                                <span class="fr num_add"><img src="/client/images/sljj.png" width="20" height="20"></span>
                            <#else>
                                <a href="javascript:void(0);" class="fr num_add" cgid="${cg.id?c}">
                                    <img src="/client/images/sljj.png" width="20" height="20">
                                </a>
                            </#if>
                        </div></td>
                    <td class="gwc1_lm2_b"><span>￥${(cg.price*cg.quantity)?string("0.00")}</span></td>
                    <td class="gwc1_lm2_d"><input type="button" class="gwc_delete" cgid="${cg.id?c}" value="删除商品"></td>
                    <#if cg.isSelected>
                        <#assign totalGoods=totalGoods+cg.quantity>
                        <#assign totalPrice=totalPrice+cg.price*cg.quantity>
                    </#if>
                </tr>
            </#list>
            </table>
        </div>
    </div>

    <div class="main">
        <div class="s_gwc1zj_left fll mt12">
            <p id="p-all-select"><input id="all-select" type="checkbox" class="fll" style="margin-top:4px;" <#if allChecked>checked="checked" sid="1"<#else>sid="0"</#if>>全选</p>
        </div>
        <div class="s_gwc1zj flr">
            <p>商品<span> <#if cart_goods_list??>${totalGoods!'0'}</#if> </span>件  总价：
            <span>¥<#if cart_goods_list??>${totalPrice?string("0.00")}</#if></span>  商品总计(不含运费)： 
            <span>¥<#if cart_goods_list??>${totalPrice?string("0.00")}</#if></span> </p>
        </div>
    </div>

    <div class="clear"></div>

    <div class="main">
        <div class="s_gwc1zja">
            <div class="fll s_gwc1zja_1">
                <a href="/"> << 继续购物 </a></div><div class="flr s_gwc1zja_2"><a onclick="goNext(${totalGoods!0})" href="javascript:void(0);" title="去结算">去结算 </a>
            </div>
        </div>
        <div class="h40"></div>
    </div>
<#else>
    <div class="buy_ok">
        <div class="car_kong">
            <p class="fc fs18 pb10">购物车空空的哦，去看看心意的商品吧！</p>
            <div class="pt10 font13">看看 <a href="/user/order/list/0" style=" color:#da090b">已买到商品</a> </div>
            <div class="pt10 font13">看看 <a href="/user/collect/list" style=" color:#da090b">我的收藏夹</a> </div>
          </div>
    </div>
</#if>