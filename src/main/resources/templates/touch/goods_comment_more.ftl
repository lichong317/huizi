 <#if comment_page??>
         <#list comment_page.content as item>
              <section class="pro_leave mainbox bot-border pt20 pb20">
                 <h3><p class="absolute-r c9"><b class="userName">${item.username!''}</b>&nbsp;&nbsp;&nbsp;&nbsp;${item.commentTime?string("yyyy-MM-dd")}</p>
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 0>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 1>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 2>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 3>star01.png<#else>star02.png</#if>" />
                  <img src="/touch/images/<#if item.goodsStar?? && item.goodsStar gt 4>star01.png<#else>star02.png</#if>" />
                  </h3>
                  <p class="pb10">${item.content!''}</p>
                  <p class="pb10"><span class="red">商家回复：</span><#if item.isReplied?? && item.isReplied>${item.reply!''}</#if></p>
              </section>
         </#list>
    </#if>