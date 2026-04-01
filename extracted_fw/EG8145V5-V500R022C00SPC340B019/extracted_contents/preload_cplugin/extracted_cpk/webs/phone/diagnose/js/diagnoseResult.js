/* eslint-disable */
$(function(){
	$("title").html(getResource('RESULT_TITLE'));
	loadLanguage();
	var language = getLanguage();
	var status = sessionStorage.getItem('getCheckResultStatus');
	if(status == 'success'){
		$("#banner").css("height", "auto");
		$(".disconnect").css("display", "block");
		$("#btn").removeClass('okBtn');
		$(".completed").html(getResource('RESULT_COMPLETED'));
		$('#result_ok').css("display", "none");
	}else if(status == 'error'){
		$("#banner").css("height", "auto");
		$(".disconnect").css("display", "block");
		$("#btn").removeClass('okBtn');
		$(".completed").html(getResource('RESULT_FAIL'));
		$('#result_ok').css("display", "none");
	}else if(status == 'no-problem'){
		$("#lineLeft").removeClass("offline");
		$("#banner").css("height", "100%");
		$("#btn").addClass('okBtn');
		$('#result_ok').css("display", "block");
	}
	
	var checkResultList = sessionStorage.getItem('checkResultList');
	if(checkResultList && JSON.parse(checkResultList)){
		checkResultList = JSON.parse(checkResultList);
		var result = '';
		for(var i = 0; i < checkResultList.length; i++){
			var item = checkResultList[i];
			var problemName = language==='en'?item.problemNameEn:item.problemName;
			problemName = defendXSS(problemName);
			var fixGuide = language==='en'?item.fixGuideEn:item.fixGuide;
			const fixGuideArr = fixGuide.split('<br>');
			let newFixGuide = '';
			for (const fixGuideArrEle of fixGuideArr) {
				let fixGuideEle = defendXSS(fixGuideArrEle);
				newFixGuide += fixGuideEle + '<br>';
			}
			result += '<div class="problem">\
							<div class="title"><span class="badge">'+(i+1)+'</span>'+problemName+'</div>\
							<div class="advice">'+getResource("SOLUTION_ADVICE")+'</div>\
							<div class="item">'+newFixGuide+'</div>\
						</div>';
		}
		$("#content").html(result);
	}
	
	$("#btn").click(function(){
		sendAjaxGetReq('/diagnosis/servlet?cmd=startCheck', function(data){
			if(data.data && data.data.status == 0){
				sessionStorage.removeItem('checkResultList');
				sessionStorage.removeItem('getCheckResultStatus');
				window.location.href = "../../diagnose.html?checkTaskId="+data.data.checkTaskId;
			}else{
				ajaxError();
			};
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
	window.location.href = '../../diagnose.html';
}