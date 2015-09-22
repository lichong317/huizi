<#if consult_page??>
            <#list consult_page.content as item>
                 <li>
                    <p class="p1">${item.username!''} ${item.content!''}</p>
                    <#if item.isReplied?? && item.isReplied>
                    <p class="p2">商家回复：${item.reply!''}</p>
                    </#if>
                 </li>
            </#list>
        </#if>