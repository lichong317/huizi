jQuery(function($) {
    var contentEditor;
    
    // 商品详情编辑框
    KindEditor.ready(function(K) {
        window.gk = K;
        contentEditor = K.create('textarea[name="contentArea"]', {
            allowFileManager : false,
            uploadJson: "/admin/product/upload"
        });
    });
    
	// 新增
	$("#id-new").click(function() {
	    $("#id-table").addClass("hide");
	    $("#id-add").removeClass("hide");
	});
	
	// 返回上一级
	$(".back").click(function() {
	    $("#id-table").siblings().addClass("hide");
	    $("#id-table").removeClass("hide");
	});
	
	// 全选
	$("#id-all-check").click(function() {
	    $(".tr-check").prop("checked", true);
	});
	
	// 反选
	$("#id-all-uncheck").click(function() {
	    $(".tr-check").prop("checked", false);
	});
	
	// 删除选中
	$("#id-delete").click(function(){
	    var items = $(".tr-check:checked");
	    var i;
	    var str="";
	    
	    for (i=0; i<items.length; i++)
	    {
	        str += items.eq(i).val();
	        str += ",";
	    }
	    
	    if ("" == str)
	    {
	        return;
	    }
	            
	    $.ajax({
	        url : '/admin/info/delete/',
	        type : 'POST',
	        success : function() {
	            location.reload();
	        }
	    }); // ajax
	});

	// 每页数量
	var pageSize = 15;
	
	//分页
	$("#id-pagination").pagination($("#id-total-num").val(), {
		num_display_entries : 2, 
		num_edge_entries : 3,
		current_page : 0,
		items_per_page : pageSize,
		prev_text : "上一页",
		next_text : "下一页",
		showGo:true,
		showSelect:true,
		callback : function(pageIndex) {
			$.ajax({
				type:"GET",
				url:"/admin/info/page/" + pageIndex,
				success:function(data){
					$("#id-tbody").html(data);
				}
			});
		}
		
	});

    $("#add-submit").click(function(){
        
        var formData = new FormData($('#fm-add')[0]);
        var contentContent = contentEditor.html();
        
        // 填充商品详情
        formData.append("content", contentContent);
        
        $.ajax({
            url : '/admin/info/save',
            type : 'POST',
            data : formData,
            async : false,
            cache : false,
            contentType : false,
            processData : false,
            success : function(res) {
                if (0 == res.code) {
                    alert("添加成功");
                    location.reload();
                } else {
                    alert(res.message);
                }
            }
        }); // ajax
     
    });
});
	
// 删除参数
function destroy(id) {
    if (window.confirm('确定要删除吗？')) {

        $.ajax({
            url : '/admin/info/delete/'+id,
            type : 'POST',
            success : function() {
                location.reload();
            }
        });

        return true;
    } else {
        return false;
    }
}

function modify(id) {

    $.ajax({
        url : '/admin/info/modify/'+id,
        type : 'POST',
        success : function(data) {	
            $("#id-modify").siblings().addClass("hide");
            $("#id-modify").html(data);
            $("#id-modify").removeClass("hide");
            
            // 返回上一级
            $(".back").click(function() {
                $("#id-table").siblings().addClass("hide");
                $("#id-table").removeClass("hide");
            });
            
            var mContentEditor;
            
            mContentEditor = window.gk.create('textarea[name="mContentArea"]', {
                allowFileManager : false,
                uploadJson: "/admin/product/upload",
                afterCreate: function()
                {
                    this.html(window.pcontent);
                }
            });
            
            $("#modify-submit").click(function(){
                var formData = new FormData($('#fm-modify')[0]);
                var contentContent = mContentEditor.html();
                
                // 填充商品详情
                formData.append("content", contentContent);
                
                $.ajax({
                    url : '/admin/info/save',
                    type : 'POST',
                    data : formData,
                    async : false,
                    cache : false,
                    contentType : false,
                    processData : false,
                    success : function(res) {
                        if (0 == res.code) {
                            alert("修改成功");
                            location.reload();
                        } else {
                            alert(res.message);
                        }
                    }
                }); // ajax
            });
        }
    });
                                                           
}


