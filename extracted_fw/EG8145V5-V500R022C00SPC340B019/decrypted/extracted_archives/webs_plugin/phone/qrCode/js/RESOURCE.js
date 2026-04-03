
/*中文国际化资源*/
var rCN = {
	"QRCODE_TITLE": "山东联通宽带二维码自助诊断报障",
	"QRCODE_TIP_CONTENT": "很抱歉，联通公司检测到您的家庭网络出现链接问题，请按照下面的方法步骤操作，我们将及时为您修复。",
	"QRCODE_BD_ACCOUNT": "宽带账号：",
	"QRCODE_FAULT_CODE": "故障代码：",
	"QRCODE_TIP_COZIESTTIPS": "温馨提示：",
	"QRCODE_TIP_COZIESTTIPSDESC": "请先关闭手机WIFI，再通过手机扫描二维码或点击二维码进行诊断报障。",
	"QRCODE_TIP_COZIESTTIPSDESC2": "如无法扫描二维码，请拨打9600169宽带专家热线或10010客服热线，感谢您的配合。",
};

/*英文国际化资源*/
var rEN = {
	"QRCODE_TITLE": "山东联通宽带二维码自助诊断报障",
	"QRCODE_TIP_CONTENT": "很抱歉，联通公司检测到您的家庭网络出现链接问题，请按照下面的方法步骤操作，我们将及时为您修复。",
	"QRCODE_BD_ACCOUNT": "宽带账号：",
	"QRCODE_FAULT_CODE": "故障代码：",
	"QRCODE_TIP_COZIESTTIPS": "温馨提示：",
	"QRCODE_TIP_COZIESTTIPSDESC": "请先关闭手机WIFI，再通过手机扫描二维码或点击二维码进行诊断报障。",
	"QRCODE_TIP_COZIESTTIPSDESC2": "如无法扫描二维码，请拨打9600169宽带专家热线或10010客服热线，感谢您的配合。",
};

var REGU = {
	isWindowsPhone: /(?:Windows Phone)/,
	isSymbian: /(?:SymbianOS)/,
	isAndroid: /(?:Android)/,
	isFireFox: /(?:Firefox)/,
	isPad: /(?:iPad|PlayBook)/,
	isMobile: /(?:Mobile)/,
	isPhone: /(?:iPhone)/,
	isTablet: /(?:Tablet)/,
};

var language = getLanguage();
function getLanguage() {
	var lang = navigator.language || navigator.userLanguage;// 常规浏览器语言和IE浏览器
	lang = lang.substr(0, 2);// 截取lang前2位字符
	if (lang == 'zh') {
		return 'zh';
	} else {
		return 'en';
	}
};

var resource = null;
function getResource(key) {
	switch (language) {
		case "zh":
			resource = rCN;
			break;
		case "en":
			resource = rEN;
			break;
		default:
			resource = rCN;
			break;
	};
	var result = resource[key];
	return result;
};

function loadLanguage() {
	var spanArray = document.getElementsByTagName("span");
	for (let i = 0; i < spanArray.length; i++) {
		if (spanArray[i].getAttribute("key")) {
			var key = spanArray[i].getAttribute("key")
			spanArray[i].innerHTML = getResource(key);
		}
	}
};

function reguCheck(regu, testValue) {
	return regu.test(testValue);
};

function getIsPhoneOrPc() {
	var isPhoneOrPc = 'PC';
	var uaInfo = navigator.userAgent;
	var isWindowsPhone = reguCheck(REGU.isWindowsPhone, uaInfo);
	var isSymbian = isWindowsPhone || reguCheck(REGU.isSymbian, uaInfo);
	var isFireFox = reguCheck(REGU.isFireFox, uaInfo);
	var isAndroid = reguCheck(REGU.isAndroid, uaInfo);
	var isTablet = reguCheck(REGU.isPad, uaInfo) || (isFireFox && reguCheck(REGU.isTablet, uaInfo)) || (isAndroid && !reguCheck(REGU.isMobile, uaInfo));
	var isPhone = !isTablet && reguCheck(REGU.isPhone, uaInfo);
	var isPc = !isSymbian && !isPhone && !isAndroid;

	if (isAndroid || isPhone) {
		isPhoneOrPc = 'Phone';
	} else if (isPc) {
		isPhoneOrPc = 'PC';
	} else {
		isPhoneOrPc = 'PC';
	}
	return isPhoneOrPc;
}

/**
 * 动态加载CSS
 * @param {*} url 
 */
function dynamicLoadCss(url) {
	var head = document.getElementsByTagName('head')[0];
	var link = document.createElement('link');
	link.type = 'text/css';
	link.rel = 'stylesheet';
	link.href = url;
	head.appendChild(link);
}

