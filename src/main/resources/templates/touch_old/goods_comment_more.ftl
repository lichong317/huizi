<#if comment_page??>
         <#list comment_page.content as item>
              <li>
                <p>${item.content!''}</p>
                <#if item.isReplied?? && item.isReplied>
                    <p class="ta-r red pt10">商家回复：${item.reply!''}</p>
                </#if>
                <p class="c9">用户名：<b class="userName">${item.username!''}</b><span>时间：${item.commentTime?string("yyyy-MM-dd")}</span></p>
              </li>
         </#list>
    </#if>