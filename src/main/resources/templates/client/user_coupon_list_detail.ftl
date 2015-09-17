        <div class="mymember_order_search"><a class="a001" href="/user/coupon/list/0">全部</a><a class="a001" href="/user/coupon/list/1">未使用</a> <a class="a001" href="/user/coupon/list/2">已使用</a> <a class="a001" href="/user/coupon/list/3">已过期</a>
          <div class="clear"></div>
        </div>
<table class="tb-void tb-coupon">
          <colgroup>
          <col width="90px"/>
          <col width="90px"/>
          <col width="270px"/>
          <col width="120px"/>
          <col width="150px"/>
          <col width="86px" />
          </colgroup>
          <thead>
            <tr>
              <th>面值</th>
              <th>所需消费金额</th>
              <th>使用限制</th>
              <th>状态</th>
              <th align="left">&nbsp;</th>
            </tr>
          </thead>
          <tbody >
            <#if coupan_list??>
            	<#list coupan_list as item>
		            <tr>
		              <td>￥${item.price?string("0.00")!'' } </td>
		              <td> ￥${item.price?string("0.00")!'' } </td>
		              <td> ${item.typeDescription!'' } </td>
		              <td> 
		              <a title="${item.getTime?string("yyyy-MM-dd")!'' }至${item.expireTime?string("yyyy-MM-dd")!'' }">
			              <#if item.isUsed?? && item.isUsed>
			             	 已使用  
			              <#elseif item.hourLeft gt 0 >
					              <#if item.dateLeft lt 4 &&  item.dateLeft gt -1>
					                即将到期（<b style="color:red;">${ item.hourLeft?c!'' }&nbsp;</b>小时）
					              <#elseif  item.dateLeft gt 3>
					                 还有<b style="color:green;">&nbsp;${item.dateLeft?c!''}&nbsp;</b>天到期
					              </#if>
	          		      <#elseif item.hourLeft lt 0 ||item.hourLeft = 0>
		                	  已过期 
		                  </#if>  
			          </a>
			              
		              </td>
		              <td><a href="/"  class="ftx-05" target="_blank">去购物&gt;</a><br />
		                <a  href="javascript:coupondel(${item.id?c},${listId?c});" class="ftx-05 dellink"  <#if (!item.isUsed??||!item.isUsed)&&item.hourLeft gt 0>onclick="javascript:coupondelcfm();"</#if> >删除</a> </td>
		            </tr>
		        </#list>
		    </#if>        
          </tbody>
        </table>
                <div class="myclear" style="height:10px;"></div>