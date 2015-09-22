<#if goods_page??>
        <#list goods_page.content as item>
            <a class="phone_list" href="/touch/goods/${item.id?c!''}">
                <b><img src="${item.coverImageUri!''}" width="168" height="168"/></b>
                <p class="p1">${item.title!''}</p>
                <p>${item.subTitle!''}</p>
                <p class="fl">累计评价：<span class="red">${item.totalComments!'0'}条</span></p>
                <p class="p2 ta-r mt20">￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></p>
                <div class="clear"></div>
            </a>
        </#list>
    </#if>  