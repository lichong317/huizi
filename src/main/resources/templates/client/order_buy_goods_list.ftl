<table>
    <tbody>
        <#assign totalQuantity=0>
        <#assign totalPrice=0>
        <#if selected_goods_list??>
            <#list selected_goods_list as sg>
                <tr>
                    <td class="gwc1_lm2_a0"><#if sg.goodsId??>${sg.goodsId?c}</#if></td>
                    <td class="gwc1_lm2_a1">
                        <span><a href="/goods/<#if sg.goodsId??>${sg.goodsId?c}</#if>"><img src="${sg.goodsCoverImageUri!''}" width="76" height="76"></a></span>
                        <p><a href="/goods/<#if sg.goodsId??>${sg.goodsId?c}</#if>"></a></p>
                        <p><a href="/goods/<#if sg.goodsId??>${sg.goodsId?c}</#if>">${sg.goodsTitle!''}</a></p>
                    </td>
                    <td class="gwc1_lm2_b1"><span>￥${sg.price?string("0.00")}</span></td>
                    <td class="gwc1_lm2_c1">
                        <div class="ds content_nr_3_jg2">
                        <a class="quantity-minus" href="/order/buygoods/minus?gid=<#if sg.goodsId??>${sg.goodsId?c}</#if><#if shareId??>&shareId=${shareId?c}</#if>"><img src="/client/images/slj.png" width="20" height="20"></a>
                        <input type="text" class="content_zj" disabled="disabled" value="${sg.quantity!''}">
                        <a class="quantity-plus" href="/order/buygoods/plus?gid=<#if sg.goodsId??>${sg.goodsId?c}</#if><#if shareId??>&shareId=${shareId?c}</#if>"><img src="/client/images/sljj.png" width="20" height="20"></a>
                        </div>
                    </td>
                    <td class="gwc1_lm2_b1"><span>￥${(sg.price*sg.quantity)?string("0.00")}</span></td>
                </tr>
                <#assign totalQuantity=totalQuantity+sg.quantity>
                <#assign totalPrice=totalPrice+(sg.price*sg.quantity)>
            </#list>
        </#if>
    </tbody>
</table>