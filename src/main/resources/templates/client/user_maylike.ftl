    <div class="mymember_info">
      <h3 id="mymember_likecheck">
        <#if reco_page0??>
        	<a class="mysel" href="/list/${categoryId0?c!'' }" title="进入“${categoryTitle0!''}”商品分类">&nbsp;</a>
        </#if>
        <#if reco_page1??>
        	<a href="/list/${categoryId1?c!'' }" title="进入“${categoryTitle1!''}”商品分类">&nbsp;</a>
        </#if>        
        <#if reco_page2??>
        	<a href="/list/${categoryId2?c!'' }" title="进入“${categoryTitle2!''}”商品分类">&nbsp;</a>
        </#if>
        <span>猜你喜欢</span>  
      </h3>
      <ul id="mymember_likelist">
          <li>
          	  <#if reco_page0??>
	              <#list reco_page0.content as item>
	              	<#if item_index lt 4>
			          <a href="/goods/${item.id?c!''}" title="${item.subTitle!'' }">
			          <img src="${item.coverImageUri!'' }" width="208" height="208"/>
			           <p>${item.title!'' }</p>
			           <p>￥<span>${item.salePrice?string(0.00)!'' }</span></p>						
			           <i>已售${item.soldNumber!'' }件</i>
			          </a>
			          </#if>
	          	  </#list>
              </#if>
        </li>
        <li>
          	  <#if reco_page1??>
	              <#list reco_page1.content as item>
	              	<#if item_index lt 4>
			          <a href="/goods/${item.id?c!'' }">
			          <img src="${item.coverImageUri!'' }"width="208" height="208" />
			           <p>${item.title!'' }</p>
			           <p>￥<span>${item.salePrice?string(0.00)!'' }</span></p>						
			           <i>已售${item.soldNumber!'' }件</i>
			          </a>
			       </#if>   
	          	  </#list>
              </#if>
        </li>
        <li>
          	  <#if reco_page2??>
	              <#list reco_page2.content as item>
	              	<#if item_index lt 4>
			          <a href="/goods/${item.id?c!'' }">
			          <img src="${item.coverImageUri!'' }" width="208" height="208"/>
			           <p>${item.title!'' }</p>
			           <p>￥<span>${item.salePrice?string(0.00)!'' }</span></p>						
			           <i>已售${item.soldNumber!'' }件</i>
			          </a>
			        </#if>  
	          	  </#list>
              </#if>
        </li>
      </ul>
      <div class="myclear"></div>
    </div><!--mymember_info END-->
<script type="text/javascript">
$(document).ready(function(){
    mymemberMenuCheck("mymember_likecheck","a","mymember_likelist","li","mysel");
});
</script>