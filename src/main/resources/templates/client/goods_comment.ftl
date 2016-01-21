<script type="text/javascript">
$(document).ready(function(){

<#if comment_page??>
<#list comment_page.content as item>
    <#if item.showPictures??>
    var the_one${item_index} = {
          "boxid":"onebox${item_index}", //最外层id
          "sumid":"onesum${item_index}", //包裹列表的id
          "stylename":"onepart",//内部滚动的标签class
          "boxwidth":60,//外层宽
          "boxheight":60,//外层高
          "objwidth":60,//单个个体宽度
          "objheight":60,//单个个体高度
          "autogo":true,//是否开启自动滚动
          "gospeed":2000,//滚动速度
          "speed":200, // 滚动间隔速度
          "leftid":"oneleft",//左箭头id
          "rightid":"oneright"//右箭头id
        };//the_one END
        $.ljs_gundong.oneLeft(the_one${item_index});
        </#if>
</#list>
</#if>
});
</script>
<div id="comment-list"> 
    <menu class="pro_eval w100">
        <h3 class="tit">
            <input type="radio" <#if !stars?? || stars?? && stars==0>checked="checked"</#if> onclick="javascript:getCommentByStars(${goodsId?c}, 0, 0);"/><span>全部评价（${comment_count!'0'}）</span>
            <input type="radio" <#if stars?? && stars==3>checked="checked"</#if> onclick="javascript:getCommentByStars(${goodsId?c}, 3, 0);"/><span>好评（${three_star_comment_count!'0'}）</span>
            <input type="radio" <#if stars?? && stars==2>checked="checked"</#if> onclick="javascript:getCommentByStars(${goodsId?c}, 2, 0);"/><span>中评（${two_star_comment_count!'0'}）</span>
            <input type="radio" <#if stars?? && stars==1>checked="checked"</#if> onclick="javascript:getCommentByStars(${goodsId?c}, 1, 0);"/><span>差评（${one_star_comment_count!'0'}）</span>
        </h3>
        
        <#if comment_page??>
            <#list comment_page.content as item>
            <script type="text/javascript">
                jQuery(function($) {
                    $(".swipebox${item_index}").swipebox();
                });
            </script>
            <li style="padding: 20px 1px 15px 13%;width: 87%;">
                <a class="a1" href="javascript:;" style="width: 90px;"><img src="${item.userHeadUri!''}" width="85" height="85"/><p class="userName">${item.username!''}</p></a>
                <p class="pb10" style="height: 51px;overflow: hidden;">${item.content!''}</p>
                <#if item.isReplied?? && item.isReplied>
                    <p class="ta-r red pt10" style="text-align: left;padding-top: 3px;">商家回复：${item.reply!''}</p>
                </#if>
                <p class="c9 ml20" style="text-align: right;">${item.commentTime?string("yyyy-MM-dd")}</p>
                
                <#if item.showPictures??>
                  <#list item.showPictures?split(",") as uri>
                         <#if ""!=uri>

                               <a href="${uri}" class="swipebox${item_index}" title="My Caption">
                                    <img src="${uri}" width="80px;" height="80px;" alt="image">
                               </a>
                         
                         </#if>
                </#list>
            </#if>
            </li>
            </#list>
        </#if>      
    </menu>
    <div class="clear h20"></div>
    <div class="page-orange">
        <#assign continueEnter=false>
        <#if comment_page.number+1 == 1>
            <a href="javascript:;" class="disabled">上一页</a>
        <#else>
            <a href="javascript:getCommentByStars(${goodsId?c}, ${stars!'0'}, ${comment_page.number-1});">上一页</a>
        </#if>
        
        <#if comment_page.totalPages gt 0>
            <#list 1..comment_page.totalPages as page>
                <#if page <= 3 || (comment_page.totalPages-page) < 3 || (comment_page.number+1-page)?abs<3 >
                    <#if page == comment_page.number+1>
                        <a class="sel" href="javascript:;"">${page}</a>
                    <#else>
                        <a href="javascript:getCommentByStars(${goodsId?c}, ${stars!'0'}, ${page-1});">${page}</a>
                    </#if>
                    <#assign continueEnter=false>
                <#else>
                    <#if !continueEnter>
                        <span class="sp1">……</span>
                        <#assign continueEnter=true>
                    </#if>
                </#if>
            </#list>
        </#if>
        
        <#if comment_page.number+1 == comment_page.totalPages || comment_page.totalPages==0>
            <a class="pn-next" href="javascript:;">下一页</a>
        <#else>
            <a class="pn-next" href="javascript:getCommentByStars(${goodsId?c}, ${stars!'0'}, ${comment_page.number+1});">下一页</a>
        </#if>
    </div>
    <div class="clear h20"></div>
</div> 