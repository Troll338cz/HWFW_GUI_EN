var adjustPosition = {
	STATE: ['', 'stateBad', 'statePoor', 'stateGood', ''],
	COLOR: ['black', '#e54545', '#ff9400', '#5ccbb1', '#e54545'],
	TITLE: [
		'POSITION_SIGNAL',
		'POSITION_BAD_SIGNAL',
		'POSITION_POOR_SIGNAL',
		'POSITION_GOOD_SIGNAL',
		'POSITION_OFFLINE'
	],
	CONTENT: [
		'<div style="text-align: center; text-indent: 0;">'+getResource("POSITION_WAITING")+'</div>',
		getResource("POSITION_BAD_PROMPT")+'<br/>'+getResource("POSITION_WAIT_PROMPT"),
		getResource("POSITION_BAD_PROMPT")+'<br/>'+getResource("POSITION_WAIT_PROMPT"),
		'<div style="text-align: center; text-indent: 0;">'+getResource("POSITION_GOOD_PROMPT")+'</div>',
		'<div>'+getResource("POSITION_OFFLINE_PROMPT1")+'</div><div>'+getResource("POSITION_OFFLINE_PROMPT2")+'</div>'
	],
	index: 0,
	ajaxTimer: null,
	top: 0,
	
	initEvent: function(){
		$('#backIcon').on('click', function(){
			window.location.href = "../../phone.html";
		});
		$('#btn').on('click', function(){
			if(adjustPosition.index === 0){//置灰
				return;
			}else if(adjustPosition.index === 4){//重试
				adjustPosition.index = 0;
				adjustPosition.loadPage();
				adjustPosition.initPageData();
			}else{
				var checked = sessionStorage.getItem('checked');
				if(checked === 'true'){
					checked = true;
				}else if(checked === 'false'){
					checked = false;
				}
				if(checked){// 选中30天内不再提醒，调用接口
					adjustPosition.sendAjaxGetReq("/notice/servlet?cmd=cancelAttention", function(data){
						adjustPosition.jumpToSuccess();
					}, function(data) {
						adjustPosition.ajaxError('cancelAttention fail');
					});
				}else{//不选中30天内不再提醒，调用接口
					adjustPosition.sendAjaxGetReq("/notice/servlet?cmd=confirm", function(data){
						adjustPosition.jumpToSuccess();
					}, function(data) {
						adjustPosition.ajaxError('confirm fail');
					});
				}
			}
		});
	},
	
	initPageData: function(){
		var mac = sessionStorage.getItem('mac');
		adjustPosition.ajaxTimer = setInterval(function(){//每隔10秒请求一次
			adjustPosition.sendAjaxGetReq("/notice/servlet?cmd=getApSignalStrength&mac="+mac, function(data) {
				if(data.data && data.data.status == 1){//AP离线
					$('.bottom p').html(getResource('POSITION_OFFLINE')).css('color', '#999');
		            $('.strength').html('');
		            $('.suggest').html('');
		            $('#state').css('display','none');
		            $("#outer").attr('class', '');
		            $('#center_img').css('display', 'none');
		            $('#center_img').prev('i').css('display', 'none');
				}else if(data.data && data.data.status == 0){//AP在线
					$('#state').css('display','block');
					$('#center_img').css('display', 'block');
		            $('#center_img').prev('i').css('display', 'block');
					adjustPosition.handleApStrengthData(data.data);
				}
			}, function(data) {
				adjustPosition.ajaxError('getApSignalStrength fail');
			});
		}, 10000);
	},
	
	handleApStrengthData: function(data){
		var top = 0;
		var positionX = 0;
		var picture = '';
		var RSSI = Number(data.signalStrength);
		if (RSSI > -30) {
            RSSI = -30;
            top = 34;
            positionX = 0;
            picture = 'near';
        }
        if (RSSI < -120) {
            RSSI = -120;
            top = 0;
            positionX = 100;
            picture = 'far';
        }
        if (RSSI > -66) {
        	$('.bottom p').html(getResource('NEAR_POSITION')).css('color', '#ff9400');
        	$('.strength').html(getResource('NEAR_SIGNAL'));
            $('.suggest').html(getResource('POSITION_WAIT_PROMPT'));
            adjustPosition.index = 2;//中
            top = 17-(RSSI + 30)*17/36;
            positionX = -(RSSI + 30) / (35 / 25);
            picture = 'near';
        } else if (RSSI > -74) {
        	$('.bottom p').html(getResource('MODERATE_POSITION')).css('color', '#5ccbb1');
            $('.strength').html(getResource('GOOD_SIGNAL'));
            $('.suggest').html('&nbsp;');
            adjustPosition.index = 3;//好
            top = 34-(RSSI+66)*17/8;
            positionX = -(RSSI + 65) / (8 / 50) + 25;
            picture = 'mezzo';
        } else {
        	$('.bottom p').html(getResource('FAR_POSITION')).css('color', '#e54545');
            $('.strength').html(getResource('BAD_SIGNAL'));
            $('.suggest').html(getResource('POSITION_WAIT_PROMPT'));
            adjustPosition.index = 1;//差
            top = 17*(RSSI + 120)/46;
            positionX = -(RSSI + 73) / (46 / 25) + 75;
            picture = 'far';
        }
        adjustPosition.top = top;
        $("#center_img").attr('src', "../image/ap.png");
        $('.center_top div i').css({
            'background': 'url("../image/'+picture+'.png")',
            'backgroundSize': '0.6rem 0.6rem',
            'left': positionX + '%'
        })
        $('.center_top div img').css({'left': positionX + '%'});
		adjustPosition.loadPage();
	},
	
	loadPage: function(){
		var index = adjustPosition.index;
		$('#state').attr('class', adjustPosition.STATE[index]).css('top', adjustPosition.top+'%');
		
		if(0 === index){
			$('#btn').html(getResource("POSITION_FINISHED")).removeClass('clickable').css('background', '#999');
			$("#outer").attr('class', 'rotate');
		}else if(4 === index){
			$('#btn').html(getResource("POSITION_RETRY")).addClass('clickable').css('background', '#0099ff');
			$("#outer").attr('class', '');
		}else{
			$('#btn').html(getResource("POSITION_FINISHED")).addClass('clickable').css('background', '#0099ff');
			$("#outer").attr('class', 'rotate');
		}
	},
	
	sendAjaxGetReq: function(url, successCB, errorCB) {
		$.ajax({
			url: url,
			type: "GET",
			dataType: "json",
			success: function(data) {
				if(!data||(data.code!=0)){
					if(data.code == -1 && data.message == 'get rssi fail!'){
						adjustPosition.index = 4;
						clearInterval(adjustPosition.ajaxTimer);
						adjustPosition.loadPage();
					}else{
						adjustPosition.ajaxError('data fail');
					}
				}else{
					successCB(data);
				}
			},
			error: function(data) {
				errorCB(data);
			}
		});
	},
	
	ajaxError: function(data){
      console.log(data);
	},
	
	jumpToSuccess: function(){
		sessionStorage.setItem('checked', null);
		sessionStorage.setItem('mac', null);
		window.location.href = "success.html";
	}
};

$(function(){
	$("title").html(getResource('INDEX_REPOSITION_AP'));
	loadLanguage();
	$('.strength').html(getResource('POSITION_SIGNAL'));
    $('.suggest').html(getResource('POSITION_WAITING'));
	adjustPosition.loadPage();
	updateCss();
	adjustPosition.initPageData();
	adjustPosition.initEvent();
	
	adjustPosition.dotTimer1 = setInterval(function(){
		$('#state').attr('class', '');
	}, 500);
	adjustPosition.dotTimer2 = setInterval(function(){
		$('#state').attr('class', adjustPosition.STATE[adjustPosition.index]).css('top', adjustPosition.top+'%');
	}, 1000);
});

function updateCss() {
    $("#left_img").attr('src', "../image/router.png");
    $("#right_img").attr('src', "../image/facility.png");

    if (language !== 'zh' && language !== 'en' && language !== 'ar') {
        $('.top').css('height', '10.7rem');
    }

    if (language === 'en') {
        $('.bottom p').css({'lineHeight': '0.7rem', 'paddingTop': '0.6rem'})
        $('.top').css({'height': 'auto', 'paddingBottom': '0.2rem'})
        $('.bottom .place .left span').css({transform: 'translateX(-0.3rem)'})
    }
}