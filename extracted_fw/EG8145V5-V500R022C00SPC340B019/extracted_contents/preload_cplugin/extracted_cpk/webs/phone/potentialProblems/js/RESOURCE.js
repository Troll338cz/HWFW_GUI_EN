/**
 * 中文国际化资源
 */
var rCN = {
	/*首页*/
	"INDEX_MESSAGE_TIP": "信息提示",
	"INDEX_POTENTICAL_PROBLEM": "潜在问题",
	"INDEX_POTENTICAL_PROBLEMS": "你的网关存在如下潜在问题：",
	"INDEX_PROBLEM_NAME": "问题名称",
	"INDEX_FIX_GUARD": "修复建议",
	"INDEX_CANCEL": "取消",
	"INDEX_UPPER_SIGNAL_POOR": "AP上行信号差",
	"INDEX_REPOSITION_AP": "调试AP安装位置",
	"INDEX_REPOSITION": "调试位置",
	"INDEX_MESSAGE_REMIND_SET": "信息提醒设置",
	"INDEX_NO_REMIND": "xxx天内不再提醒",
	"INDEX_BTN_OK": "确定",
	"INDEX_AUTO_CLOSE_FAIL": "若本页面无法关闭，请尝试用遥控器上的返回键或主页键进行关闭。",
	/*操作成功页面*/
	"OPRATION_SUCCESS": "操作成功",
	/*调试AP安装位置页面*/
	"POSITION_DEBUGGING": "安装位置调试",
	"POSITION_GOOD": "好",
	"POSITION_POOR": "中",
	"POSITION_BAD": "差",
	"POSITION_SIGNAL": "正在检测当前AP设备信号质量...",
	"POSITION_WAITING": "请稍候",
	"NEAR_SIGNAL": "当前AP（闪点）距离家庭网关太近，建议调整安装位置。",
	"MODERATE_POSITION": "当前AP安装位置适中",
	"GOOD_SIGNAL": "当前AP（闪点）已达到最佳安装位置",
	"FAR_POSITION": "当前AP安装位置太远",
	"NEAR_POSITION": "当前AP安装位置太近",
	"BAD_SIGNAL": "当前AP（闪点）信号较差，建议调整安装位置",
    "POSITION_BAD_SIGNAL": "设备距离网关太远，信号较差",
    "POSITION_BAD_PROMPT": "建议调整安装位置，重新上电测试",
    "POSITION_WAIT_PROMPT": "提示：设备重新上电后，大约需要等待1分钟",
    "POSITION_POOR_SIGNAL": "设备距离网关太近，覆盖范围受限。",
    "POSITION_GOOD_SIGNAL": "设备信号已最佳，可安装",
    "POSITION_GOOD_PROMPT": "设备信号极佳，建议作为参考安装位置",
    "POSITION_OFFLINE": "AP设备已离线",
    "POSITION_OFFLINE_PROMPT1": "请检查设备是否已断电，请重新上电后，等待1分钟，然后点击重试按钮。",
    "POSITION_OFFLINE_PROMPT2": "设备或已不在Wi-Fi信号的覆盖区域，请在信号覆盖的区域内重试。",
    "POSITION_FINISHED": "完成",
    "POSITION_RETRY":"重试",
    "CLOSE": "太近",
    "LIMITED_RANGE": "覆盖范围受限",
    "MODERATE": "适中",
    "COVER": "覆盖刚好",
    "SPEED": "速度刚好",
    "FAR": "太远",
    "SPEED_LIMITED": "传输速度受限"
}

var rEN = {
	/*首页*/
	"INDEX_MESSAGE_TIP": "Notification",
	"INDEX_POTENTICAL_PROBLEM": "Potential issues",
	"INDEX_POTENTICAL_PROBLEMS": "Potential issues that may affect the network",
	"INDEX_PROBLEM_NAME": "Issue name",
	"INDEX_FIX_GUARD": "Suggestion",
	"INDEX_CANCEL": "Cancel",
	"INDEX_UPPER_SIGNAL_POOR": "Weak AP signal",
	"INDEX_REPOSITION_AP": "Relocate the AP.",
	"INDEX_REPOSITION": "Relocate AP",
	"INDEX_MESSAGE_REMIND_SET": "Setting reminder",
	"INDEX_NO_REMIND": "Remind me in xxx days",
	"INDEX_BTN_OK": "OK",
	"INDEX_AUTO_CLOSE_FAIL": "If this page cannot be closed, press the Back or Home key on the remote control to close it.",
	/*操作成功页面*/
	"OPRATION_SUCCESS": "Operation successful.",
	/*调试AP安装位置页面*/
	"POSITION_DEBUGGING": "Optimize AP location",
	"POSITION_GOOD": "Good",
	"POSITION_POOR": "Fair",
	"POSITION_BAD": "Poor",
	"POSITION_SIGNAL": "Testing signal quality of the current AP...",
	"POSITION_WAITING": "Please wait.",
    "NEAR_SIGNAL": "The current AP (flashing point) is too close. You are advised to relocate the AP.",
    "MODERATE_POSITION": "The current AP is in the optimal position.",
	"GOOD_SIGNAL": "The current AP (flashing point) is in the optimal position.",
	"FAR_POSITION": "The current AP is too far.",
	"NEAR_POSITION": "The current AP is too close.",
	"BAD_SIGNAL": "The signal of the current AP (flashing point) is weak. You are advised to relocate the AP.",
    "POSITION_BAD_SIGNAL": "The AP is too far away from the gateway and the signal is poor.",
    "POSITION_BAD_PROMPT": "Relocate the AP and power on it again.",
    "POSITION_WAIT_PROMPT": "Note: Wait for about one minute after the AP is powered on again.",
    "POSITION_POOR_SIGNAL": "The AP is too close to the gateway and the coverage is insufficient.",
    "POSITION_GOOD_SIGNAL": "The AP signal is optimal and you can install it here.",
    "POSITION_GOOD_PROMPT": "The AP signal is excellent and you can take here as the best installation location.",
    "POSITION_OFFLINE": "The AP is offline.",
    "POSITION_OFFLINE_PROMPT1": "Check whether the AP is powered off. If it is powered off, power it on, wait for 1 minute, and click Retry.",
    "POSITION_OFFLINE_PROMPT2": "The AP may be out of the Wi-Fi coverage area. Try again in the Wi-Fi coverage area.",
    "POSITION_FINISHED": "Finished",
    "POSITION_RETRY":"Retry",
    "CLOSE": "Too close",
    "LIMITED_RANGE": "Insufficient coverage",
    "MODERATE": "Optimal",
    "COVER": "Sufficient coverage",
    "SPEED": "High Internet access rate",
    "FAR": "Too far",
    "SPEED_LIMITED": "Low transmission rate",
    "FINISHED": "Finished"
}

var language = getLanguage();
function getLanguage(){
	var lang = navigator.language||navigator.userLanguage;//常规浏览器语言和IE浏览器
    lang = lang.substr(0, 2);//截取lang前2位字符
    if(lang == 'zh'){
    	return 'zh';
    }else{
    	return 'en';
    }
}

var resource = null;
function getResource(key, param){
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
	if(param){
		result = result.replace('xxx', param); 
	}
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
}

function loadCss(name, path){
	var cssHref;
    if (language === 'en') {
        cssHref = path+name+"_en.css";
    } else {
        cssHref = path+name+".css";
    }
    var head = document.getElementsByTagName('head')[0];
    var linkNode = document.createElement("link");
    linkNode.setAttribute("rel", "stylesheet");
    linkNode.setAttribute("type", "text/css");
    linkNode.setAttribute("href", cssHref);
    head.appendChild(linkNode);
};