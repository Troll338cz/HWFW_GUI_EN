/* eslint-disable */
$(function () {
	loadLanguage();
	var isPhoneOrPc = getIsPhoneOrPc();
	var cssPCUrl = './qrCode/css/qrCodeCssPc.css';
	var cssPhoneUrl = './qrCode/css/qrCodeCssPhone.css';
	var qrCodeSize = 18;
	if (isPhoneOrPc === 'Phone') {
		dynamicLoadCss('./common/base.css');
		dynamicLoadCss(cssPhoneUrl);
		qrCodeSize = 18;
	} else if (isPhoneOrPc === 'PC') {
		dynamicLoadCss(cssPCUrl);
		qrCodeSize = 32;
	}

	sendAjaxGetReq('/notice/servlet?cmd=getQrCodeInfo', function (resp) {
		if (resp && resp.code == 0) {
			var qrcodeUrl = resp.data.qrcode;
			var bdAccount = '';
			var faultCode = '';
			var indexOfBdAccount = qrcodeUrl.indexOf("&bdAccount=");
			var indexOfFaultCode = qrcodeUrl.indexOf("&loid=");
			bdAccount = qrcodeUrl.substring(indexOfBdAccount + 11, indexOfFaultCode);
			bdAccount = defendXSS(bdAccount);
			var arr = qrcodeUrl.split('&');
			for (var i = 0; i < arr.length; i++) {
				if (arr[i].search('faultCode') >= 0) {
					faultCode = arr[i].split('=')[1];
				}
			}
			faultCode = defendXSS(faultCode);
			$("#qrCodeBAccTitleVal").html(bdAccount);
			$("#qrCodefaultCodeVal").html(faultCode);
			document.getElementById('qrCodeImg').innerHTML = createQrcode(qrcodeUrl, qrCodeSize, 'M', "Byte", "UTF-8");
			var divQrCodeImg = document.getElementById("qrCodeImg");
			var divQrCodeLOGO = document.getElementById("qrCodeLOGO");
			divQrCodeImg.onclick = (function (param) {
				window.location.href = qrcodeUrl;
			})
			divQrCodeLOGO.onclick = (function (param) {
				window.location.href = qrcodeUrl;
			})
		} else {
			console.log("getQrCodeInfo error");
		}
	}, function () {
		console.log("getQrCodeInfo error");
	});
});

function sendAjaxGetReq(url, successCB, errorCB) {
	$.ajax({
		url: url,
		type: "GET",
		dataType: "json",
		success: function (data) {
			if (!data || data.code != 0) {
				console.log("error");
			} else {
				successCB(data);
			}
		},
		error: function (data) {
			errorCB(data);
		}
	});
}

function createQrcode(text, typeNumber, errorCorrectionLevel, mode, mb) {
	qrcode.stringToBytes = qrcode.stringToBytesFuncs[mb];
	var qr = qrcode(typeNumber || 4, errorCorrectionLevel || 'M');
	qr.addData(text, mode);
	qr.make();
	return qr.createImgTag();
};