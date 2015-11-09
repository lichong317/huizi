
<#if contrast_goods_list?? && contrast_goods_list?size gt 0>
<table class="duibilan">
<tbody>
    <tr>
        <td style="background:#333;" width="10%">
            <h3>对比栏</h3>
        </td>
        <#if contrast_goods_list?size == 1>
        	<td width="20%">
                    <a href="/goods/${contrast_goods_list[0].goodsId?c}"><img src="${contrast_goods_list[0].goodsCoverImageUri!''}" />
                    <p>
                        ${contrast_goods_list[0].goodsTitle!''}
                    </p>
                    <span class="red">¥<#if contrast_goods_list[0].price??>${contrast_goods_list[0].price?string("0.00")}</#if></span>
                    </a>
                    <span><a href="javascript:deleteContrastgoods('${contrast_goods_list[0].id?c}')">删除</a></span>
       		</td>
       		<td width="20%">
       			<h2>2</h2>
       			<p>您还可以添加</p>
       		</td>
       		<td width="20%">
       			<h2>3</h2>
       			<p>您还可以添加</p>
       		</td>
       		<td width="20%">
       			<h2>4</h2>
       			<p>您还可以添加</p>
       		</td>
       	<#elseif contrast_goods_list?size == 2>
       		<#list contrast_goods_list as item>
       			<td width="20%">
                    <a href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" />
                    <p>
                        ${item.goodsTitle!''}
                    </p>
                    <span class="red">¥<#if item.price??>${item.price?string("0.00")}</#if></span>
                    </a>
                    <span><a href="javascript:deleteContrastgoods('${item.id?c}')">删除</a></span>
       			</td>
       		</#list>
       		<td width="20%">
       			<h2>3</h2>
       			<p>您还可以添加</p>
       		</td>
       		<td width="20%">
       			<h2>4</h2>
       			<p>您还可以添加</p>
       		</td>
       	<#elseif contrast_goods_list?size == 3>
       		<#list contrast_goods_list as item>
       			<td width="20%">
                    <a href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" />
                    <p>
                        ${item.goodsTitle!''}
                    </p>
                    <span class="red">¥<#if item.price??>${item.price?string("0.00")}</#if></span>
                    </a>
                    <span><a href="javascript:deleteContrastgoods('${item.id?c}')">删除</a></span>
       			</td>
       		</#list>      		
       		<td width="20%">
       			<h2>4</h2>
       			<p>您还可以添加</p>
       		</td>
       	<#elseif contrast_goods_list?size gt 3>
	       	<#list contrast_goods_list as item>
	       		<#if item_index < 4>
	       			<td width="20%">
	                    <a href="/goods/${item.goodsId?c}"><img src="${item.goodsCoverImageUri!''}" />
	                    <p>
	                        ${item.goodsTitle!''}
	                    </p>
	                    <span class="red">¥<#if item.price??>${item.price?string("0.00")}</#if></span>
	                    </a>
	                    <span><a href="javascript:deleteContrastgoods('${item.id?c}')">删除</a></span>
	       			</td>
	       		</#if>
	       	</#list> 
		</#if>
        <td style="background:#FFF;" width="10%">
            <#if contrast_goods_list?size gt 1>
            	<h3><a style="width:100px; height:30px; line-height:30px; background:#ff4454; float:left; color:#FFF;" href="/contrast/goods/detail?categoryId=${contrast_goods_list[0].categoryId!''}">对比</a></h3>
            <#else>
            	<h3><a style="width:100px; height:30px; line-height:30px; background:#888888; float:left; color:#FFF;" href="javascript:;">对比</a></h3>
            </#if>
            <a style="text-align:center;" href="javascript:deleteContrastgoods()">清空对比栏</a>
        </td>
    </tr>
</tbody>
</table>
</#if>