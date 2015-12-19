function randomnum(smin, smax) {// 获取2个值之间的随机数
	var Range = smax - smin;
	var Rand = Math.random();
	return (smin + Math.round(Rand * Range));
}

var isOver = false; // 判断奖品是否送完

function runzp(data) {
	//var data = '[{"id":1,"prize":"一等奖","v":1.0},{"id":2,"prize":"二等奖","v":2.0},{"id":3,"prize":"三等奖","v":18.0}]';// 奖项json
	//var obj = eval('(' + data + ')');
	var obj = data;
	var result = randomnum(1, 100);
	var line = 0;
	var temp = 0;
	var returnobj = "0";
	var index = 0;
	
	var angle = 330;
	var message = "";
	var myreturn = new Object;
    
	//alert("随机数"+result);
	for ( var i = 0; i < obj.length; i++) {
		var obj2 = obj[i];
		var c = parseFloat(obj2.probability);
		temp = temp + c;
		line = 100 - temp;
		if (c != 0) {
			if (result > line && result <= (line + c)) {
				index = i;
				// alert(i+"中奖"+line+"<result"+"<="+(line + c));
				returnobj = obj2;
				var username = $("#username").text();
				//alert(username);
				$.ajax({
		             type: "post",
		             url: "/lottery/getPrize",
		             data: {"username":username,"id":obj2.id },
		             dataType: "json",
		             success: function (data) {
		                 if (data.code == 0) {
		                    
		                 } else {
		                     //alert(data.msg);
		                	 isOver = true;	
		                	 myreturn.isOver = isOver;	
		                 }
		             }
		        });
				break;
			}
		}
	}
	
	if (returnobj != "0") {// 有奖
		message = "恭喜中奖了";
		var angle0 = [ 344, 373 ];
		var angle1 = [ 226, 256 ];
		var angle2 = [ 109, 136 ];
		switch (index) {
		case 0:// 一等奖
			var r0 = randomnum(angle0[0], angle0[1]);
			angle = r0;
			break;
		case 1:// 二等奖
			var r1 = randomnum(angle1[0], angle1[1]);
			angle = r1;
			break;
		case 2:// 三等奖
			var r2 = randomnum(angle2[0], angle2[1]);
			angle = r2;
			break;
		}
		myreturn.prize = returnobj.title;
		myreturn.isWin = true;
	} else {// 没有
		message = "再接再厉";
		var angle3 = [ 17, 103 ];
		var angle4 = [ 197, 220 ];
		var angle5 = [ 259, 340 ];
		var r = randomnum(3, 5);
		var angle;
		switch (r) {
		case 3:
			var r3 = randomnum(angle3[0], angle3[1]);
			angle = r3;
			break;
		case 4:
			var r4 = randomnum(angle4[0], angle4[1]);
			angle = r4;
			break;
		case 5:
			var r5 = randomnum(angle5[0], angle5[1]);
			angle = r5;
			break;
		}
		myreturn.prize = "继续努力!";
		myreturn.isWin = false;
	}
	myreturn.angle = angle;
	myreturn.message = message;
	
	return myreturn;
}