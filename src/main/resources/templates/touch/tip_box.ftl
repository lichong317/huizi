<script type="text/javascript">
    
        function win_yes(text,func){
            var he = ($(window).height() - $('.win_yn div').height())/2 - 50;
            $('.win_yn div').css({marginTop:he});   
            $('.win_yn').fadeIn(600);
            $("#title").html(text);
            $("#yes").attr("onclick",func);
        };
        
        function win_no(){  
            $('.win_yn').fadeOut(600);
        };

    
</script>
        <style>
            .win_yn{
                position: fixed;
                left: 0px;
                top: 0px;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.3);
            }
            .win_yn div{
                width:300px;
                height: 140px;
                margin: auto;
                border-radius: 8px;
                background:white;
            }
            .win_yn div p{
                float: left;
                width: 100%;
                margin-top: 20px;
                line-height: 30px;
                font-size: 1.2em;
                color: #333333;
                text-align: center;
            }
            .win_yn div span{
                float: left;
                width: 72%;
                padding: 0 14%;
            }
            .win_yn div span label{
                float: right;
                width: 60px;
                height: 28px;
                margin-top: 20px;
                line-height: 28px;
                color: white;
                text-align: center;
                border: white 1px solid;
                border-radius: 6px;
                background: url(/touch/img/btn01.png) no-repeat center;
            }
</style>
<div class="win_yn" style="display:none;">
        <div>                   
            <p id="title"></p>
            <span>
                <label onclick="win_no();">确定</label>
            </span>             
        </div>
</div>