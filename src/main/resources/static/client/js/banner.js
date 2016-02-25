function bannerCartoon(_boxid,_part,_numid,_carsp,_speed,_lastid,_nextid){
	var _box = $("#"+_boxid);
	var _arr = _box.find(_part);
	var _length = _arr.length;
	var _numbox = $("#"+_numid);
	var _index = 0;
	_arr.eq(_index).css("display","block").siblings().css("display","none");
	
	//轮播数字
	var _numstr = "<span class='numsel'>1</span>";
	for(var i=2;i<_length+1;i++){
		_numstr += "<span>"+i+"</span>";
		}
	_numbox.html(_numstr);
	var _numarr = _numbox.find("span");
	
	var _nextgo = function(){
		_index++;
		if(_index >= _length){ _index = 0;}
		_arr.stop(true,true);
		_arr.eq(_index).fadeIn(_carsp).siblings().fadeOut(_carsp);
		_numarr.eq(_index).addClass('numsel').siblings().removeClass('numsel');
	};//END
	var _lastgo = function(){
		_index--;
		if(_index < 0){ _index = _length-1;}
		_arr.stop(true,true);
		_arr.eq(_index).fadeIn(_carsp).siblings().fadeOut(_carsp);
		_numarr.eq(_index).addClass('numsel').siblings().removeClass('numsel');
	};//END
	
	var _cartoon = setInterval(_nextgo,_speed);
	_box.hover(function(){
		clearInterval(_cartoon);
		},function(){
			_cartoon = setInterval(_nextgo,_speed);
			});
	_numarr.hover(function(){
		_index = $(this).index();
		_arr.stop(true,true);
		_arr.eq(_index).fadeIn(_carsp).siblings().fadeOut(_carsp);
		_numarr.eq(_index).addClass('numsel').siblings().removeClass('numsel');
		});
}