
<#if contrast_goods_list??>
<table class="duibilan">
<tbody>
    <tr>
        <td style="background:#333;" width="10%">
            <h3>对比栏</h3>
        </td>
        <#list contrast_goods_list as item>
            <#if item_index < 4>
                <td width="20%">
                    <a href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" />
                    <p>
                        ${item.goodsTitle!''}
                    </p>
                    <span class="red">¥<#if item.price??>${item.price?string("0.00")}</#if></span>
                    </a>
                    <span><a href="#">删除</a></span>
                </td>
            </#if>
        </#list>
       
        <td style="background:#FFF;" width="10%">
            <h3><a style="width:100px; height:30px; line-height:30px; background:#ff4454; float:left; color:#FFF;" href="#">对比</a></h3>
            <a style="text-align:center;" href="#">删除全部</a>
        </td>
    </tr>
</tbody>
</table>
</#if>