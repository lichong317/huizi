//下拉菜单 - 本效果由昆明天度网络IRIS原创制作
function menuDownList(boxid,_showname,_name,_hover){
	var _box = $("#"+boxid);
	var _show = _box.find(_showname);
	var _chek = _box.find(_name);
	_box.hover(function(){
		if(_show.is(":animated")){_show.stop(true,true);}
		_chek.addClass(_hover);
		_show.fadeIn(300);
		},function(){
			if(_show.is(":animated")){_show.stop(true,true);}
			_chek.removeClass(_hover);
		    _show.fadeOut(300);
			});
}
//搜索框部分 - 本效果由昆明天度网络IRIS原创制作
function searchTextClear(_name,_text,color01,color02){
	var _obj = $(_name);
	_obj.val(_text);
	_obj.css("color",color01);
	_obj.click(function(){
		var _now = _obj.val();
		if(_now == _text){
			_obj.val("");
			_obj.css("color",color02);
		}
	});
	_obj.blur(function(){
		var _now = _obj.val();
		if(_now == ""){
			_obj.val(_text);
			_obj.css("color",color01);
		}
	});
}
//加入状态 - 本效果由昆明天度网络IRIS原创制作
function checkNowHover(boxid,_name){
	var _box = $("#"+boxid);
	_box.hover(function(){
		_box.addClass(_name);
		},function(){
			_box.removeClass(_name);
			});
}
//顶部扫描单独下拉 - 本效果由昆明天度网络IRIS原创制作
function phoneListMore(){
	var _sum = $("#top_phonelist");
	var _arr = _sum.find("li");
	var _menu = $(".phone_sum_more");
	var _parr = $(".phone_sum_more p");
	var _index = 0;
	_arr.find("a").hover(function(){
		if(_menu.is(":animated")){_menu.stop(true,true);}
		if(_parr.is(":animated")){_parr.stop(true,true);}
		_index = $(this).parent().index();
		if(_index > 0){
			_menu.fadeIn(200);
			_parr.eq(_index-1).fadeIn(200).siblings().fadeOut(200);
			}
		},function(){
			_menu.fadeOut(200);
			_parr.fadeOut(200);
			});
}

function navDownList(boxid,_sumname,_showname){
	var _box = $("#"+boxid);
	var _arr = _box.find(_sumname);
	var _hover = _box.find(_showname);
	_arr.hover(function(){
		if(_hover.is(":animated")){_hover.stop(true,true);}
		var _height = $(this).height() + 5;
		$(this).find(".bg").height(_height);
		$(this).find(_showname).fadeIn(100);
		},function(){
			if(_hover.is(":animated")){_hover.stop(true,true);}
			_hover.fadeOut(100);
			});
}
//选项卡 - 本效果由昆明天度网络IRIS原创制作
function checkBoxShow(menuid,_mname,sumid,_sname,_hover){
	var _menu = $("#"+menuid);
	var _marr = _menu.find(_mname);
	var _sum = $("#"+sumid);
	var _sarr = _sum.find(_sname);
	var _index = 0;
	_marr.eq(0).addClass(_hover);
	_sarr.eq(0).css("display","block").siblings().css("display","none");
	_marr.hover(function(){
		_index = $(this).index();
		_marr.eq(_index).addClass(_hover).siblings().removeClass(_hover);
		_sarr.eq(_index).css("display","block").siblings().css("display","none");
		});
}
//首页banner - 本效果由昆明天度网络IRIS原创制作
function indexBannerShow(boxid,_bname,numid,_nname,_hover,_speed){
	var _box = $("#"+boxid);
	var _barr = _box.find(_bname);
	var _num = $("#"+numid);
	var _narr = _num.find(_nname);
	var _length = _barr.length;
	var _index = 0;
	var _width = _num.width()/_narr.length;
	_narr.width(_width);
	_narr.eq(_index).addClass(_hover);
	_barr.eq(_index).css("display","block").siblings().css("display","none");
	
	var _show = function(_before,_now){
		_index = _now;
		if(_index >= _length){_index = 0;}
		/*var _math = Math.random() * 10;
		_math = Math.floor(_math);
		var _ww = _num.width()/2;
		if(_math > 5){
			_ww = -1 * _ww;
			};
		_barr.eq(_now).css("z-index","3");
		_barr.eq(_before).animate({top:_ww+"px","opacity":"0.3"},300,function(){
			$(this).css({"z-index":"1","opacity":"1","top":"0"});
			_barr.eq(_now).css("z-index","5");
			});*/
			_narr.eq(_index).addClass(_hover).siblings().removeClass(_hover);
			_barr.eq(_index).fadeIn(400);
			_barr.eq(_before).fadeOut(400);
		};//fun END
		
	var _cartoon = setInterval(function(){
		var _nn = _index;
		_index++;
		_show(_nn,_index);
		},_speed);
	
	//鼠标事件
	_narr.hover(function(){
		clearInterval(_cartoon);
		var _nn = $(this).index();
		if(_nn != _index){
			_show(_index,_nn);
			}
		},function(){
			_cartoon = setInterval(function(){
		var _nn = _index;
		_index++;
		_show(_nn,_index);
		},_speed);
			});
}
//首页专用选项卡 - 本效果由昆明天度网络IRIS原创制作
function indexBoxShow(menuid,_mname,sumid,_sname,_hover){
	var _menu = $("#"+menuid);
	var _marr = _menu.find(_mname);
	var _sum = $("#"+sumid);
	var _sarr = _sum.find(_sname);
	var _index = _marr.length - 1;
	_marr.last().addClass(_hover);
	_marr.last().css("border-left","1px solid #eee");
	_marr.eq(0).css("border-right","1px solid #eee");
	_marr.eq(0).find("span").css("border","none");
	_sarr.last().css("display","block").siblings().css("display","none");
	_marr.hover(function(){
		_index = $(this).index();
		_marr.eq(_index).addClass(_hover).siblings().removeClass(_hover);
		_sarr.eq(_index).css("display","block").siblings().css("display","none");
		});
}
//楼层计算 - 本效果由昆明天度网络IRIS原创制作
function indexFloor(boxid,_name){
	var _box = $("#"+boxid);
	var _arr = _box.find(_name);
	
	var _floornum = function(_obj,_top,_bot){
		$(window).scroll(function(){
		  var _now = $(window).scrollTop();
		  if(_now>=_top && _now<_bot){
		  _obj.addClass("sel").siblings().removeClass("sel");
		  }
	       });
		};//fun END
	
	//_floornum(_arr.eq(0),0,1117);
	_floornum(_arr.eq(0),0,1920);
	_floornum(_arr.eq(1),1920,2100);
	_floornum(_arr.eq(2),2715,2200);
	_floornum(_arr.eq(3),3510,4300);
	_floornum(_arr.eq(4),4300,5400);
	_floornum(_arr.eq(5),5400,6400);
	$(window).scroll(function(){
		var _now = $(window).scrollTop();
		if(_box.is(":animated")){_box.stop(true,true);}
		if(_now > 1017 && _now < 4800){
			_box.fadeIn(200);
			}else{
			_box.fadeOut(200);
			}
		});
	
	var _gofloor = function(_seat){
		//$(window).scrollTop(_seat);
		$("html,body").animate({scrollTop:_seat},300);
		};//fun END
	_arr.eq(0).click(function(){ _gofloor(1127); });
	_arr.eq(1).click(function(){ _gofloor(1920); });
	_arr.eq(2).click(function(){ _gofloor(2715); });
	_arr.eq(3).click(function(){ _gofloor(3510); });
	_arr.eq(4).click(function(){ _gofloor(4300); });
}
//选择类型计算 - 本效果由昆明天度网络IRIS原创制作
function chooseMoreShow(){
	var _arr = $(".choose_box menu");
	var _length = _arr.length;
	if(_length > 4){
		for(var i=4;i<_length;i++){
			_arr.eq(i).css("display","none");
			}
	}//if END
}
function chooseMoreDown(){
	var _arr = $(".choose_box menu");
	var _length = _arr.length;
	if(_length > 4){
		var _str = "<a href='javascript:chooseMoreUp();'>收起选项<img src='/client/images/content/arrow01.png' /></a>";
		$(".choose_more").html(_str);
		var _time = 200;
		for(var i=4;i<_length;i++){
			_time += 100;
			_arr.eq(i).slideDown(_time);
			}
	}
}
function chooseMoreUp(){
	var _arr = $(".choose_box menu");
	var _length = _arr.length;
	if(_length > 4){
		var _str = "<a href='javascript:chooseMoreDown();'>下拉，更多选项<img src='/client/images/content/arrow01.png' /></a>";
		$(".choose_more").html(_str);
		var _time = 200;
		for(var i=4;i<_length;i++){
			_time += 100;
			_arr.eq(i).slideUp(_time);
			}
	}
}

//商品展示 - 本效果由昆明天度网络IRIS原创制作
function productImgShow(boxid,_name,_menuid,_hover,_width,_height){
	var _box = $("#"+boxid);
	var _menu = $("#"+_menuid);
	var _arr = _box.find(_name);
	_menu.html(_box.html());
	var _sum = _menu.find(_name);
	_sum.eq(0).addClass(_hover);
	_arr.eq(0).css("display","block").siblings().css("display","none");
	var _index = 0;
	
	_sum.hover(function(){
		_index = $(this).index();
		_arr.eq(_index).css("display","block").siblings().css("display","none");
		_sum.eq(_index).addClass(_hover).siblings().removeClass(_hover);
		});
	//alert(_arr.length);
	
}

function openMyWin(objid,_speed){
	$("#"+objid).slideToggle(_speed);
}


//图片悬停效果，兼容低版本浏览器-IRIS
function imgShowName(_name,_hover,_style,_start,_end,_speed){
	var _arr = $(_name);
	_arr.find(_hover).css(_style,_start+"px");
	_arr.hover(function(){
		var _obj = $(this).find(_hover);
		if(_obj.is(":animated")){_obj.stop(true,true);}
		eval("_obj.animate({"+_style+":"+_end+"+'px'},_speed);");
		
		},function(){
			var _obj = $(this).find(_hover);
		    if(_obj.is(":animated")){_obj.stop(true,true);}
		    eval("_obj.animate({"+_style+":"+_start+"+'px'},_speed);");
			});
}






//顶部浮动 - 本效果由昆明天度网络IRIS原创制作
function topTitFloat(boxid,_top,_hover){
	var _box = $("#"+boxid);
	$(window).scroll(function(){
		var _now = $(window).scrollTop();
		if(_now > _top){
			_box.addClass(_hover);
			}else {
				_box.removeClass(_hover);
				}
	});
}
//login背景切换 - 本效果由昆明天度网络IRIS原创制作
function loginBgChange(boxid,_name,_speed){
	var _arr = $("#"+boxid+" "+_name);
	var _length = _arr.length;
	var _index = 0;
	_arr.eq(_index).siblings().css({"display":"none","opacity":"0"});
	
	var _nextShow = function(){
		var _last = _index;
		_index++;
		if(_index >= _length){ _index = 0; }
		_arr.eq(_index).css("display","block");
		_arr.eq(_index).animate({"opacity":"1"},500);
		_arr.eq(_last).animate({"opacity":"0"},500,function(){
			_arr.eq(_last).css("display","none");});
		};
	
	setInterval(_nextShow,_speed);
}

//左右箭头滚动 - 本效果由昆明天度网络IRIS原创制作
function arrowListGo(boxid,_sumname,_width,_num,_mga,_name,_lastid,_nextid){
	var _box = $("#"+boxid);
	var _sum =  _box.find(_sumname);
	var _arr = _box.find(_name);
	var _length = _arr.length;
	_box.css({"width":_width+"px","overflow":"hidden"});
	var _ww = (_width/_num)-(_mga*2);
	_arr.css({"width":_ww+"px","margin":"0 "+_mga+"px"});
	var _index = 0;
	
	var _nextGo = function(){
		_index++;
		if(_index > _length-_num){_index = _length-_num;}
		if(_sum.is(":animated")){
            _sum.stop(true,true);
           }
		var _move = -_index*(_mga*2+_ww);
		_sum.animate({left:_move+"px"},300);
	};
	
	var _lastGo = function(){
		_index--;
		if(_index < 0){_index = 0;}
		if(_sum.is(":animated")){
            _sum.stop(true,true);
           }
		var _move = -_index*(_mga*2+_ww);
		_sum.animate({left:_move+"px"},300);
	};
	
	
	
	if(_length > _num){
		$("#"+_nextid).click(function(){ _nextGo(); });
		$("#"+_lastid).click(function(){ _lastGo(); });
		}
}


