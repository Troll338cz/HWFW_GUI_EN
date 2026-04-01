var indexObj = {
	getCheckResultIndex: null,
	startCheckIndex: null,
	checkTaskId: '',
	showPage1: true,
	checkCount: 0,
	percent: 0,
	percentIndex: null,
	
	renderPage: function(){
		if(indexObj.showPage1){
			$("#page1").css('display', 'block');
			$("#page2").css('display', 'none');
			clearInterval(indexObj.percentIndex);
			indexObj.percent = 0;
		}else{
			$("#page1").css('display', 'none');
			$("#page2").css('display', 'block');
			indexObj.percentIndex = setInterval(function(){
				if(indexObj.percent <= 60){
					indexObj.percent+= 3;
				}else if(indexObj.percent <= 80){
					indexObj.percent+= 1;
				}else if(indexObj.percent <= 90){
					indexObj.percent+= 0.1;
				}else if(indexObj.percent <= 95){
					indexObj.percent+= 0.05;
				}else{
					clearInterval(indexObj.percentIndex);
				}
				$('.progressPercent').css('width', indexObj.percent+'%');
			}, 100);
		}
	},
	
	fullProgressBar: function(){
		indexObj.percent = 100;
		$('.progressPercent').css('width', indexObj.percent+'%');
	},
	
	getCheckResult: function(){
		var checkTaskId = this.checkTaskId;
		indexObj.startCheckIndex = setTimeout(function(){
			sendAjaxGetReq('/diagnosis/servlet?cmd=getCheckResult&checkTaskId='+checkTaskId, function(data){
				if(data.data && data.data.status == 0){//体检成功
					sessionStorage.setItem('checkResultList', JSON.stringify(data.data.checkResultList || []));
					sessionStorage.setItem('getCheckResultStatus', 'success');
					clearTimeout(indexObj.getCheckResultIndex);
					indexObj.fullProgressBar();
					window.location.href = "diagnose/html/diagnoseResult.html";
				}else if(data.data && data.data.status == 1){//体检失败
					sessionStorage.setItem('checkResultList', JSON.stringify(data.data.checkResultList || []));
					sessionStorage.setItem('getCheckResultStatus', 'error');
					clearTimeout(indexObj.getCheckResultIndex);
					window.location.href = "diagnose/html/diagnoseResult.html";
				}else if(data.data && data.data.status == 2 || data.data.status == 3){//2:体检中, 3:未开始
					if(indexObj.checkCount >= 5){
						sessionStorage.removeItem('checkResultList');
						sessionStorage.setItem('getCheckResultStatus', 'error');
						clearTimeout(indexObj.getCheckResultIndex);
						window.location.href = "diagnose/html/diagnoseResult.html";
					}else{
						indexObj.checkCount++;
						indexObj.getCheckResultIndex = setTimeout(function(){
							indexObj.getCheckResult();
						}, 2000);
					}
				}else if(data.data.status == 4){//4体检结果网络正常
					sessionStorage.removeItem('checkResultList');
					sessionStorage.setItem('getCheckResultStatus', 'no-problem');
					clearTimeout(indexObj.getCheckResultIndex);
					window.location.href = "diagnose/html/diagnoseResult.html";
				}else{
					ajaxError();
				}
			}, function(){
				ajaxError();
			});
		}, 2000);
	}
}

$(function(){
	$("title").html(getResource('INDEX_BTN'));
	loadLanguage();
	
	var url = location.search;
	var checkTaskId = '';
	var arr = url .split('&');
	if (arr[0].search('checkTaskId') >= 0) {
	    checkTaskId = arr[0].split('=')[1];
	 }
	if(checkTaskId){
		indexObj.showPage1 = false;
		indexObj.checkTaskId = checkTaskId;
		indexObj.getCheckResult();
	}
	indexObj.renderPage();
	$("#btn").click(function(){
		indexObj.checkTaskId = '';
		sendAjaxGetReq('/diagnosis/servlet?cmd=startCheck', function(data){
			if(data.data && data.data.status == 0){
				indexObj.showPage1 = false;
				indexObj.renderPage();
				indexObj.checkTaskId = data.data.checkTaskId;
				indexObj.getCheckResult();
			}else{
				ajaxError();
			}
		}, function(){
				ajaxError();
		});
	});
	
	$("#cancelCheck").click(function(){
		var checkTaskId = indexObj.checkTaskId;
		sendAjaxGetReq('/diagnosis/servlet?cmd=cancelCheck&checkTaskId='+checkTaskId, function(data){
			if(data.data && data.data.status == 0){
				indexObj.checkCount = 0;
				clearTimeout(indexObj.startCheckIndex);
				clearTimeout(indexObj.getCheckResultIndex);
				indexObj.getCheckResultIndex = null;
				indexObj.showPage1 = true;
				indexObj.renderPage();
			}else{
				ajaxError();
			}
		}, function(){
				ajaxError();
		});
	});
});

function sendAjaxGetReq(url, successCB, errorCB) {
	$.ajax({
		url: url,
		type: "GET",
		dataType: "json",
		success: function(data) {
			if(!data||data.code!=0){
				ajaxError();
			}else{
				successCB(data);
			}
		},
		error: function(data) {
			errorCB(data);
		}
	});
}

function ajaxError(){
	if(indexObj.showPage1){
		indexObj.showPage1 = false;
		indexObj.renderPage();
	}
	indexObj.checkCount = 0;
	sessionStorage.setItem('getCheckResultStatus', 'error');
	setTimeout(function(){
		window.location.href = 'diagnose/html/diagnoseResult.html';
	}, 2000);
}