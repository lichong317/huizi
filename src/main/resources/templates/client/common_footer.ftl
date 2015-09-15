
<div class="down1">
   <section class="index_center">
        <table>
           <tbody>
                <#if service_item_list??>
                    <tr>
                        <#list service_item_list as item>
                            <#if item_index <4>
                            <td>
                                <a href="javascript:;"><img src="${item.logo!''}" width="55" height="55"/>${item.title!''}<br>${item.description!''}</a>
                            </td>
                            </#if>
                        </#list>
                    </tr>
                </#if>
           </tbody>     
        </table>
    </section><!--index_center END-->
    <div class="clear"></div>
    <div class="main">
        <ul>
            <#if help_level0_cat_list??>
                <#list help_level0_cat_list as items>
                    <li class="downli"><a href="/info/list/${help_id!'0'}?catId=${items.id?c!''}">${items.title!''}</a>
                           <ul>
                                 <#if items_index <7 >
                                       <#if ("help_"+items_index+"_article_list")?eval?? >
                                                <#list ("help_"+items_index+"_article_list")?eval as item> 
                                                        <li><a href="/info/list/${help_id!'0'}?catId=${item.id?c!''}">${item.title!''}</a></li>
                                                </#list> 
                                       </#if> 
                                 </#if>
                           </ul>
                    </li>
                </#list>
            </#if>
 
        </ul>

    </div>
</div>
<div class="down2">
    <div class=" erweima main">

        <div class="saoyisao">
            <img src="<#if site??>${site.androidQrCode!''}</#if>" width="81" height="81"/>
            <h3><a href="#">安卓客户端</a></h3> 
        </div>
      
        <div class="saoyisao">
            <img src="<#if site??>${site.iOsQrCode!''}</#if>" width="81" height="81" />
            <h3><a href="#">IOS客户端</a></h3> 
        </div>
    
        <div class="saoyisao">
            <img src="<#if site??>${site.wxQrCode!''}</#if>" width="81" height="81" />
            <h3><a href="#">微信公众号</a></h3> 
        </div>     
        <div class="mendian">
            <img src="/client/images/hzd_52.png" width="87" height="71"/>
            <h3><a href="#">点击查询</a></h3>
        </div>
        <div class="dizhi">
            <p>
                <span><#if site??>${site.company!''}</#if></span><br>
                <span>地址：</span><#if site??>${site.address!''}</#if><br>
                <span>电话：</span><#if site??>${site.telephone!''}</#if><br>
            </p>
        </div>
    </div>
</div>
<div class="down3">
    <div class="main">
          <ul class="downwenzi">
        
           <#if about_us_list??>
                <#list about_us_list as item>
                       <#if item_has_next>
                             <li><a href="/info/list/${about_id!'0'}?catId=${item.id?c!''}">${item.title!''}</a>丨</li>
                         <#else>
                             <li><a href="/info/list/${about_id!'0'}?catId=${item.id?c!''}">${item.title!''}</a></li>   
                       </#if>
                       
                </#list>
           </#if>
        
          </ul>
        <div class="clear"></div>
          <p>
 
              <#if site??>${site.copyright!''}</#if> 
              <br />
              ${site.address!''} 电话：${site.telephone!''}

              <span class="flr"><a title="云南网站建设" href="http://www.ynyes.com" target="_blank">网站建设</a>技术支持：<a title="云南网站建设" href="http://www.ynyes.com" target="_blank">昆明天度网络公司</a></span>
          </p>
    </div>
</div>