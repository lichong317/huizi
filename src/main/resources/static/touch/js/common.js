//页面计算问题
function setRootSize() {
	var deviceWidth = document.documentElement.clientWidth; 
	if(deviceWidth>640){deviceWidth = 640;}  
	document.documentElement.style.fontSize = deviceWidth / 6.4 + 'px';
}
setRootSize();
window.addEventListener('resize', function () {
    setRootSize();
}, false);
$(document).ready(function(){
	setRootSize();
});

//首页banner效果 - 本效果由昆明天度网络IRIS原创制作
function indexBanner(boxid,sumid,_go,_speed,numid){
	var startX,startY,endX,endY;//定义判断变量
	var _box = document.getElementById(boxid);
	var _sum = $("#"+sumid);
	var _arr = $("#"+sumid+" li");
	var _length = _arr.length;
	var _index = 0;
	var _nexti = 0;
	
	_sum.append(_sum.html());
	_arr = $("#"+sumid+" li");
	
	var _str = "<div id='"+numid+"'><a href='javascript:void(0);' class='sel'></a>";
	for(var i=1;i<_length;i++){
		_str += "<a href='javascript:void(0);'></a>";
		}
	_str += "</div>";
	$("#"+boxid).append(_str);
	var _num = $("#"+numid+" a");
	
	//计算宽度
    //var _width = $(window).width();
	var _width = $("#"+boxid).width();
	var _resize = function(){
		_width = $("#"+boxid).width();
		_arr.width(_width);
		var _move = -_width * _index;
		_sum.css("left",_move+"px");
		};
	_resize();
	$(window).resize(function(){_resize();});
	
	var nextImg = function(){
		_index++;
		_nexti++;
		
		if(_index >= _length){
			_index = 0;
			}
		if(_nexti > _length){
			_nexti = _index;
			_sum.css("left","0px");
			}
		if(_sum.is(":animated")){
			_sum.stop(true,true);
			}
		var _move = -_width * _nexti;
		_sum.animate({left:_move+"px"},_go);
		_num.eq(_index).addClass("sel").siblings().removeClass("sel");
	};
	
	var lastImg = function(){
		_index--;
		_nexti--;
		
		if(_index < 0){
			_index = _length-1;
			}
		if(_nexti < 0){
			var _m = -_width * _length;
			_sum.css("left",_m+"px");
			_nexti = _index;
			}
		if(_sum.is(":animated")){
			_sum.stop(true,true);
			}
		var _move = -_width * _nexti;
		_sum.animate({left:_move+"px"},_go);
		_num.eq(_index).addClass("sel").siblings().removeClass("sel");
	};
	
	var cartoon = setInterval(nextImg,_speed);
	
	var touchStart = function(event){
		clearInterval(cartoon);
		var touch = event.touches[0];
		endX = 0;
		endY = 0;
        startX = touch.pageX;
		startY = touch.pageY;
		};
	var touchMove = function(event){
		var touch = event.touches[0];
		var endPos = {x:startX-touch.pageX,y:startY-touch.pageY};
		var isScrolling = Math.abs(endPos.x)< Math.abs(endPos.y) ? 1:0;//isScrolling为1时，表示纵向滑动，0为横向滑动
		if(isScrolling === 0){
			event.preventDefault();//这里很重要！！！
			endX = (startX-touch.pageX);
		    //endY = (startY-touch.pageY);
			}
		};
	var touchEnd = function(event){
		if(endX > 50){
			nextImg();
			}
		if(endX < -50){
			lastImg();
			}
		cartoon = setInterval(nextImg,_speed);
		};
	
	_box.addEventListener("touchstart", touchStart, false);
    _box.addEventListener("touchmove", touchMove, false);
    _box.addEventListener("touchend", touchEnd, false);
	
}//该方法结束

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

//高度计算 - 本效果由昆明天度网络IRIS原创制作
function winShowHeight(boxid,_height){
	var _nowh;
	var _heightadd = function(){
		_nowh = $(window).height() - _height;
		$(boxid).height(_nowh);
		};
    _heightadd();
	$(window).resize(function(){
		_heightadd();
		});
}

//选项卡部分
function menuCheckShow(menuid,mname,sumid,sname,_hover,_starnum){
	var _menu = $("#"+menuid).find(mname);
	var _arr = $("#"+sumid).find(sname);
	var _index = _starnum;
	_menu.eq(_index).addClass(_hover).siblings().removeClass(_hover);
	_arr.eq(_index).css("display","block").siblings().css("display","none");
	_menu.hover(function(){
		_index = $(this).index();
		_menu.eq(_index).addClass(_hover).siblings().removeClass(_hover);
	_arr.eq(_index).css("display","block").siblings().css("display","none");
		});
	_menu.click(function(){
		_index = $(this).index();
		_menu.eq(_index).addClass(_hover).siblings().removeClass(_hover);
	_arr.eq(_index).css("display","block").siblings().css("display","none");
		});
}

//评价星星效果
function reviewsBox(boxid,_name,_hover){
	var _box = $(boxid);
	var _arr = _box.find(_name);
	var _index = 0;
	var _now = _box.find("."+_hover).length;
	
	var _checkNow = function(_num){
		_arr.removeClass(_hover);
			for(var i=0;i<=_num;i++){
			  _arr.eq(i).addClass(_hover);
			  }
		};//fun END
	_arr.hover(function(){
		_index = $(this).index();
		_checkNow(_index);
		},function(){
			_checkNow(_now-1);
			});
	_arr.click(function(){
		    _now = $(this).index();
		    for(var i=0;i<=_now;i++){
			  _arr.eq(i).addClass(_hover);
			  }
			_now += 1;
		});
}

//横向左右滑动
function listInfeedMove(boxid,_sum,_name,_num){
	var startX,startY,endX,endY;//定义判断变量
	var _box = $("#"+boxid);
	var _thesum = _box.find(_sum);
	var _arr = _box.find(_name);
	var _length = _arr.length;
	var _width = _box.width();
	var _index = 0;
	var _out = document.getElementById(boxid);
	
	//设置必要属性
	_box.css({"overflow":"hidden"});
	_thesum.css({"width":"99999px","position":"relative","left":"0"});
	_arr.css({"float":"left","display":"block"});
	
	var widthwin = function(){
		_width = _box.width()/_num;
		_arr.width(_width);
		var _mm = -_index*_width;
		_thesum.css({"left":_mm+"px"});
	};
	widthwin();
	$(window).resize(function(){widthwin();});
	
	//移动的主要方法
	var movenav = function(){
		if(_thesum.is(":animated")){_thesum.stop(true,true);}
		var _mm = -_index*_width;
		_thesum.animate({left:_mm+"px"},200);
	};
	
	var _nextnav = function(){
		_index++;
		if(_index > _length-_num){_index = _length-_num;}
		if(_length > _num){
			movenav();
			}
		};
	var _lastnav = function(){
		_index--;
		if(_index < 0){_index = 0;}
		if(_length > _num){
			movenav();
			}
		};
	
	var touchStart = function(event){
		var touch = event.touches[0];
		endX = 0;
		endY = 0;
        startX = touch.pageX;
		startY = touch.pageY;
		};
	var touchMove = function(event){
		var touch = event.touches[0];
		var endPos = {x:startX-touch.pageX,y:startY-touch.pageY};
		var isScrolling = Math.abs(endPos.x)< Math.abs(endPos.y) ? 1:0;//isScrolling为1时，表示纵向滑动，0为横向滑动
		if(isScrolling === 0){
			event.preventDefault();//这里很重要！！！
			endX = (startX-touch.pageX);
		    //endY = (startY-touch.pageY);
			}
		};
	var touchEnd = function(event){
		if(endX > 50){
			_nextnav();
			}
		if(endX < -50){
			_lastnav();
			}
		};
	
	_out.addEventListener("touchstart", touchStart, false);
    _out.addEventListener("touchmove", touchMove, false);
    _out.addEventListener("touchend", touchEnd, false);
	
}

function menuClassHeight(boxid,_name01,_name02){
	var _nowh;
	var _height01 = $(_name01).height();
	var _height02 = $(_name02).height();
	var _heightadd = function(){
		_height01 = $(_name01).height();
		_height02 = $(_name02).height();
		_nowh = $(window).height() - _height01 - _height02;
		$(boxid).height(_nowh);
		};
    _heightadd();
	$(window).resize(function(){
		_heightadd();
		});
}

//抽奖效果
var _awardbool = true;
function awardCartoon(_endnum){
	var _box = $("#awardbox");
	var _arr = new Array();
	var _nowbg = "awardnow";
	
	if(_awardbool){
	_awardbool = false;
	for(var i=1;i<=10;i++){
		var _one = _box.find(".awardpart"+i);
		_one.removeClass(_nowbg);
		_arr.push(_one);	
	}
	
	var _index = 0;
	_arr[_index].addClass(_nowbg);
	
	var _max = _arr.length * 5 + _endnum;
	var _circle = 0;
	var _nextgo = function(){
		_arr[_index].removeClass(_nowbg);
		_index ++;
		if(_index >= _arr.length ){ _index = 0; }
		_arr[_index].addClass(_nowbg);
		
		//判断停留
		_circle++;
		if(_circle >= _max){
			clearInterval(_cartoon);
			_awardbool = true;
			}
	};
	
	var _cartoon = setInterval(_nextgo,40);
	}//END if	
}

