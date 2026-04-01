function stWlan(domain, enable, name) {
	this.domain = domain;
	this.enable = enable;
	this.name = name;
}

function stWlanWifi(domain, X_HW_Standard) {
	this.domain = domain;
	this.X_HW_Standard = X_HW_Standard;
}

function ONTInfo(domain, ONTID, Status) {
	this.domain = domain;
	this.ONTID = ONTID;
	this.Status = Status;
}

function getResult()
{
	var ontInfos = <% HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT, Ontid|State, ONTInfo);%>;
	var WlanInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, Enable|Name, stWlan);%>;
	var wlanArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, X_HW_Standard, stWlanWifi);%>;
	var wlanEnbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';
	var radioEnable1 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.Radio.1.Enable);%>';
	var radioEnable2 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.Radio.2.Enable);%>';
	var allLedState1 = "<%WEB_GetAllLedState("1");%>";
	var allLedState2 = "<%WEB_GetAllLedState("2");%>";

	var obj = new Object();

	obj.ontInfos = ontInfos;
	obj.WlanInfo = WlanInfo;
	obj.wlanArr = wlanArr;
	obj.wlanEnbl = wlanEnbl;
	obj.radioEnable1 = radioEnable1;
	obj.radioEnable2 = radioEnable2;
	obj.allLedState1 = allLedState1;
	obj.allLedState2 = allLedState2;

	return obj;
}

getResult();