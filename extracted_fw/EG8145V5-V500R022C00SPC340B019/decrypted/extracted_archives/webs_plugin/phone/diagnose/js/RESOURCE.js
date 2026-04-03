
/*中文国际化资源*/
var rCN = {
	"INDEX_WARN_MESSAGE": "对不起，网关出现网络问题无法访问网页，请进行一键诊断。",
	"INDEX_BTN": "一键诊断",
	"FOOTER_COPYRIGHT": "华为网关提供技术支持",
	
	"DIAGNOSE_TITTLE": "华为网关网络诊断中",
	"DIAGNOSE_TITTLE_TOP": "诊断中",
	"DIAGNOSE_INTERNET": "Internet",
	"DIAGNOSE_ROUTER": "网关",
	"DIAGNOSE_TERMINAL": "终端",
	"DIAGNOSING": "正在进行网络诊断，请稍后···",
	"CANCEL_CHECK": "取消诊断",
	
	"RESULT_COMPLETED": "故障诊断完成！",
	"RESULT_TITLE": "诊断完成",
	"RESULT_FAIL": "故障诊断失败/取消！",
	"RE_DIAGNOSE": "重新诊断",
	"SOLUTION_ADVICE": "解决建议",
	"DIAGNOSE_OK": "当前网络正常！"
};

/*英文国际化资源*/
var rEN = {
	"INDEX_WARN_MESSAGE": "Sorry, the gateway cannot access the web page due to a network problem. Please perform quick diagnosis.",
	"INDEX_BTN": "Quick diagnosis",
	"FOOTER_COPYRIGHT": "Powered by Huawei gateways",
	
	"DIAGNOSE_TITTLE": "Diagnosing Huawei gateway network...",
	"DIAGNOSE_TITTLE_TOP": "Diagnosing...",
	"DIAGNOSE_INTERNET": "Internet",
	"DIAGNOSE_ROUTER": "Gateway",
	"DIAGNOSE_TERMINAL": "STA",
	"DIAGNOSING": "Diagnosing network... Please wait.",
	"CANCEL_CHECK": "Cancel",
	
	"RESULT_COMPLETED": "Fault diagnosis completed.",
	"RESULT_TITLE": "Diagnosis completed.",
	"RESULT_FAIL": "Fault diagnosis failed or is canceled.",
	"RE_DIAGNOSE": "Once again",
	"SOLUTION_ADVICE": "Handling suggestion",
	"DIAGNOSE_OK": "Network normal"
};

var language = getLanguage();
function getLanguage(){
	var lang = navigator.language||navigator.userLanguage;//常规浏览器语言和IE浏览器
    lang = lang.substr(0, 2);//截取lang前2位字符
    if(lang == 'zh'){
    	return 'zh';
    }else{
    	return 'en';
    }
};

var resource = null;
function getResource(key){
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

function loadLanguage(){
	var spanArray = document.getElementsByTagName("span");
    for (let i = 0; i < spanArray.length; i++) {
        if (spanArray[i].getAttribute("key")) {
            var key = spanArray[i].getAttribute("key")
            spanArray[i].innerHTML = getResource(key);
        }
    }
};
