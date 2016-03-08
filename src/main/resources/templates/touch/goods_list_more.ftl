 <#if goods_page??>
        <#list goods_page.content as item>
            <a href="/touch/goods/${item.id?c!''}" class="prolist mainbox bot-border">
              <b class="img"><img src="${item.coverImageUri!''}" /></b>
              <section>
              <p class="h07 oh">${item.title!''}</p>
              <p class="red mt20">￥<#if item.salePrice??>${item.salePrice?string("0.00")}</#if></p>
              </section>
              <div class="clear"></div>
            </a>
        </#list>
    </#if>