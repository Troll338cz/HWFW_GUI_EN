/* eslint-disable */
$(function(){
	$("title").html(getResource('INDEX_POTENTICAL_PROBLEM'));
	sessionStorage.setItem('checked', null);
	sessionStorage.setItem('mac', null);
	loadLanguage();
	
	if(!isNotTV()){//电视机给出提示
		$('#tvMessage').html(getResource('INDEX_AUTO_CLOSE_FAIL'));
	}

	//获取问题列表
	sendAjaxGetReq("/notice/getNotificationData", function(data){
		handleNotificationData(data);
	}, function(data) {
		ajaxError('getNotificationData fail');
	});
	
	//查询并回填提醒间隔
	sendAjaxGetReq("/notice/getConfig", function(data) {
		if(data && data.code == 0 && data.data && data.data.repeatInterval){
			$("#ignore30").attr('checked', true);
			$("#index_no_remind").html(getResource('INDEX_NO_REMIND', Math.floor(data.data.repeatInterval/24)));
		}else{
			$("#ignore30").attr('checked', false);
			$("#index_no_remind").html(getResource('INDEX_NO_REMIND', 30));
		}
	}, function(data) {
		$("#ignore30").attr('checked', false);
		$("#index_no_remind").html(getResource('INDEX_NO_REMIND', 30));
	});

	$("#btnOk").on('click', function() {
		// 选中xxx天内不再提醒，调用接口
		if($('input[type="checkbox"]').is(':checked')) {
			sendAjaxGetReq("/notice/servlet?cmd=cancelAttention", function(data){
				jumpToSuccess();
			}, function(data) {
				ajaxError('cancelAttention fail');
			});
		} else { //不选中xxx天内不再提醒，调用接口
			sendAjaxGetReq("/notice/servlet?cmd=confirm", function(data){
				jumpToSuccess();
			}, function(data) {
				ajaxError('confirm fail');
			});
		}
	})
});

function sendAjaxGetReq(url, successCB, errorCB) {
	$.ajax({
		url: url,
		type: "GET",
		dataType: "json",
		success: function(data) {
			if(!data||data.code!=0){
				ajaxError('data fail');
			}else{
				successCB(data);
			}
		},
		error: function(data) {
			errorCB(data);
		}
	});
}

function adjustPosition(mac){
	window.location.href = "potentialProblems/html/adjustPosition.html";
	var checked = $('input[type="checkbox"]').is(':checked');
	sessionStorage.setItem('checked', checked);//是否勾选xxx天内不再提醒
	sessionStorage.setItem('mac', mac);//有多个ap时，当前调整位置的是哪个ap
}

function jumpToSuccess(){
	window.location.href = "potentialProblems/html/success.html";
}

function handleNotificationData(notificationData) {
	if(notificationData && notificationData.data) {
		var data = notificationData.data;
	}

	var problemDetails = [];
	if(data) {
		var language = getLanguage();
		for(var i = 0; i < data.length; i++) {
			var problemName = language==='en'?data[i].problemNameEn:data[i].problemName;
			problemName = defendXSS(problemName);
			var fixGuide = language==='en'?data[i].fixGuideEn:data[i].fixGuide;
			const fixGuideArr = fixGuide.split('<br>');
			let newFixGuide = '';
			for (const fixGuideArrEle of fixGuideArr) {
				let fixGuideEle = defendXSS(fixGuideArrEle);
				newFixGuide += fixGuideEle + '<br>';
			}
			var btn = '';
			if(data[i].popupsName.indexOf("APSignalStrengthPoor") === 0){
				var index1 = data[i].popupsName.indexOf('(');
				var index2 = data[i].popupsName.indexOf(')');
				var mac = data[i].popupsName.substring(index1+1, index2);
				mac = defendXSS(mac);
				btn = '<div class="btn" onClick="adjustPosition(\''+mac+'\')">'+getResource("INDEX_REPOSITION")+'</div></li></ul>';
			}
			var item = '<ul id="problemDetails"><li><span id="problemNum">' + (i + 1) + '</span>'+problemName+'</span></li><li class="advice"><span class="adviceTittle">'+getResource("INDEX_FIX_GUARD")+'</span><div>' + newFixGuide + '</div>' + btn;
			problemDetails.push(item);
		}
	}
	$("#showProblem").html(problemDetails);
}

function ajaxError(data){
	console.log(data);
}

function isMatchScreen() { //探测屏幕大小
	var dpi_x = document.getElementById('dpi').offsetWidth;
	var dpi_y = document.getElementById('dpi').offsetHeight;
	var width = screen.width / dpi_x;
	var height = screen.height / dpi_y;

	//15inch 为iPad的最大尺寸
	var MatchScreen = (width <= 15) && (width <= 15);
	return MatchScreen;
}

function isNotTV() {//是否不是电视
	return detectOs.isIos() || detectOs.isMac() || detectOs.isWindows() || detectOs.isLinux() || (detectOs.isAndroid() && isMatchScreen());
}

var detectOs = { //获取浏览器信息
	getUserAgent: function(){
		return navigator.userAgent;
	},
	getPlatform: function(){
		return navigator.platform;
	},
	isIos: function(){
		return /iPhone|iPad|iPod/.test(detectOs.getPlatform());
	},
	isAndroid: function(){
		return /Android/.test(detectOs.getUserAgent());
	},
	isBlackBerry: function(){
		return /BlackBerry/.test(detectOs.getPlatform());
	},
	isMac: function(){
		return /Mac/.test(detectOs.getPlatform());
	},
	isWindows: function(){
		return /Win/.test(detectOs.getPlatform());
	},
	isLinux: function(){
		return /Linux/.test(detectOs.getPlatform()) && !detectOs.isAndroid();
	},
	get: function(){
		if(detectOs.isIos()) return 'iOS';
		if(detectOs.isAndroid()) return 'Android';
		if(detectOs.isBlackBerry()) return 'BlackBerry';
		if(detectOs.isMac()) return 'Mac';
		if(detectOs.isWindows()) return 'Windows';
		if(detectOs.isLinux()) return 'Linux';
		return 'Unknown';
	}
}