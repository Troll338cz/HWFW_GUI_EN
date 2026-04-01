<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type="text/css">
.nomargin {
	margin-left: 0px;
	margin-right:0px;
	margin-top: 0px;
}
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, portmapping_language, lanservicecfg_language);%>"></script>
<script language="javascript" src="../../bbsp/common/lanmodelist.asp"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="JavaScript" type="text/javascript">
var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
var LANPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.MultiSrvPortList.PhyPortName);%>'.toUpperCase();
var WLANInfoList = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, SSIDReference, stWLANInfo);%>';
if (WLANInfoList !== '') {
  WLANInfoList= dealDataWithStr(WLANInfoList);
} else {
  WLANInfoList= new Array(null);
}
var WanIpList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i}, ConnectionType|Name|X_HW_SERVICELIST|X_HW_BindPhyPortInfo|X_HW_IPv4Enable|X_HW_IPv6Enable,stWANIP);%>;
var WanPppList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},ConnectionType|Name|X_HW_SERVICELIST|X_HW_BindPhyPortInfo|X_HW_IPv4Enable|X_HW_IPv6Enable,stWANPPP);%>;
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var RegNewPageFlag = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT_NEW);%>";
var RegPageFlag = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var SupportIPv6 = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>";
var E8CRONGHEFlag = '<%HW_WEB_GetFeatureSupport(FT_SHMP_RONGHE);%>';
var UpportDetectFlag ='<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var upMode = '<%HW_WEB_GetUpMode();%>';
var TopoInfo = TopoInfoList[0];
var lanPortNum = '<%GetLanPortNum();%>';
var APInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}, APMacAddr, APInfo);%>;
var APSetInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APService.MultiSrvPortList.AP.{i}, Mac|StbPort, APSetInfo);%>;
var Advancedconfig = "<%HW_WEB_GetFeatureSupport(FT_IPTV_PORT_ADVANCE_CONFIG);%>";
var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
var MAINUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_MainUpPort);%>'.toUpperCase();
var CurrentMAINUpInfo = "";
var CurrentIPTVUpInfo = "";
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
GetIPTVPortInfo();
GetMAINPortInfo();
var fttrmain = "<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>";
var IsCTRG = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CTRG);%>';
var APMacSelectList = new Array();
var TableName = "APConfigList";
var selectIndex = -1;
var numpara = "";
APMacSelectList[0] = portmapping_language['bbsp_hostName_select'];
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var currentBin = '<%HW_WEB_GetBinMode();%>';
var isSupportWLAN = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
}

function TopoInfo(Domain, EthNum, SSIDNum) {   
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}

function stConfigPort(domain,X_HW_MainUpPort) {
	this.domain = domain;
	this.X_HW_MainUpPort = X_HW_MainUpPort;
}

function GetIPTVPortInfo() {
	if (IPTVUpPortInfo.length != 0) {
		var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
		var tempIPTVUpList = tempIPTVUpValue.split(".");
		CurrentIPTVUpInfo = tempIPTVUpList[0];
	}
}

function GetMAINPortInfo() {
	if (MAINUpPortInfo.length != 0) {
		var tempMAINUpList = MAINUpPortInfo.split(".");
		CurrentMAINUpInfo = tempMAINUpList[0];
	}
}

function wifiConfig() {
    if (isSupportWLAN == 0) {
        return;
    }
    Form = window.parent.parent.wifiForm;
    Form.submit();
}

function PortNextPage() {
    if ((IsCTRG == 1) && (currentBin.toUpperCase() != "COMMON")) {
        window.top.location = "/CustomApp/Aindex.asp"
        return;
    }

    if (var_singtel == true) {
        if (TypeWord_com == "COMMON") {
            window.top.location = "/index.asp";
        } else {
            window.top.location = "/mainpage.asp";
        }
    } else {
        window.top.location = "/index.asp";
    }
}

function onindexpage(val)
{
    if (isSupportWLAN == 0) {
        AddConfigFlag();
    }
    if ((fttrmain == 1) && (window.parent.isGuidePage == 1) && (curUserType == 1)) {
        wifiConfig();
    }
    setTimeout("PortNextPage()", 300);
}

function stWANIP(domain, ConnectionType, Name, X_HW_SERVICELIST, X_HW_BindPhyPortInfo, X_HW_IPv4Enable, X_HW_IPv6Enable) {
	this.domain 	  = domain;
	this.ConnectionType = ConnectionType;
	this.Name = Name;
	this.ServiceList = X_HW_SERVICELIST;
	this.BindPhyPort  = X_HW_BindPhyPortInfo;
	this.IPv4Enable = X_HW_IPv4Enable;
    this.IPv6Enable = X_HW_IPv6Enable;
	if (0 == SupportIPv6) {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }
}

function stWANPPP(domain, ConnectionType, Name, X_HW_SERVICELIST, X_HW_BindPhyPortInfo, X_HW_IPv4Enable, X_HW_IPv6Enable) {
	this.domain 	  = domain;
	this.ConnectionType = ConnectionType;
	this.Name = Name;
	this.ServiceList = X_HW_SERVICELIST;
	this.BindPhyPort  = X_HW_BindPhyPortInfo;
	this.IPv4Enable = X_HW_IPv4Enable;
    this.IPv6Enable = X_HW_IPv6Enable;
	if (0 == SupportIPv6) {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }
}

GetLANPortListInfo();

function stWLANInfo(Domain, SSIDReference) {
	this.Domain = Domain;
    this.SSIDReference = SSIDReference.replace("Device.WiFi.SSID.", "SSID");;
}

function APInfo(domain, APMacAddr) {
	this.domain = domain;
	this.APMacAddr = APMacAddr;
}

function APSetInfo(domain, Mac, StbPort) {
	this.domain = domain;
	this.Mac = Mac;
	this.StbPort = StbPort;

}

function DisableLanAndSSID(BindPhyPort) {
	var i;
	var tempLanList = BindPhyPort.split(",");
	for (i = 0; i < tempLanList.length; i++)
	{
		if ((RegPageFlag == 0) && (RegNewPageFlag == 1)) {	
			setCheck(tempLanList[i], 0);
		}
		setDisable(tempLanList[i], 1);
	}
}

function DisplayLanAndSSID(BindPhyPort) {
	var i;
	var tempLanList = BindPhyPort.split(",");
	for (i = 0; i < tempLanList.length; i++) {
		if ((RegPageFlag == 0) && (RegNewPageFlag == 1)) {	
			setCheck(tempLanList[i], 0);
		}
		setDisplay("Div_" + tempLanList[i], 0);
	}
}

function EnableLanAndSSID(BindPhyPort) {
	var i;
	var tempLanList = BindPhyPort.split(",");
	for (i = 0; i < tempLanList.length; i++)
	{
		setDisable(tempLanList[i], 0);
	}
}

function InitWANPhyPort() {
	var i = 0;
	if ((RegPageFlag == 0) && (RegNewPageFlag == 1)) {
		if ((WanIpList.length == 1) && (WanPppList.length == 1)) {
			for (var i = 1; i <= 8; i++)
			{
				setCheck("LAN"+i, 0);
				setDisable("LAN"+i, 1);
			}
			for (var i = 1; i <= 8; i++)
			{
				setCheck("SSID"+i, 0);
				setDisable("SSID"+i, 1);
			}
		} else {	
			for (i = 0; i < WanIpList.length -1; i++)
			{	
				if ((WanIpList[i].BindPhyPort != "") && (WanIpList[i].ConnectionType == "IP_Routed") && (WanIpList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (WanIpList[i].IPv6Enable.toUpperCase() == 0)
					&& (WanIpList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") < 0 )) {
					EnableLanAndSSID(WanIpList[i].BindPhyPort);
				}
				else if (WanIpList[i].BindPhyPort != "" && WanIpList[i].ConnectionType == "IP_Bridged" && (WanIpList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0 || WanIpList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0) && WanIpList[i].IPv6Enable.toUpperCase() == 0) {
					EnableLanAndSSID(WanIpList[i].BindPhyPort);
				} else {
					DisableLanAndSSID(WanIpList[i].BindPhyPort);
				}
			}
			for (i = 0; i < WanPppList.length -1; i++)
			{			
				if ((WanPppList[i].BindPhyPort != "") && ((WanPppList[i].ConnectionType == "IP_Routed") || (WanPppList[i].ConnectionType == "PPPoE_Routed")) && (WanPppList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (WanPppList[i].IPv6Enable.toUpperCase() == 0)
					&& (WanPppList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") < 0 )) {
					EnableLanAndSSID(WanPppList[i].BindPhyPort);
				}
				else if (WanPppList[i].BindPhyPort != "" && WanPppList[i].ConnectionType == "PPPoE_Bridged" && (WanPppList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0 || WanPppList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0) && WanPppList[i].IPv6Enable.toUpperCase() == 0) {
					EnableLanAndSSID(WanPppList[i].BindPhyPort);
				} else {
					DisableLanAndSSID(WanPppList[i].BindPhyPort);
				}
			}
		}
		for (var i = 1; i <= 8; i++)
		{
			if (getElById("LAN"+i).disabled == true) {
				setCheck("LAN"+i, 0);
			}
		}
		for (var i = 1; i <= 8; i++)
		{
			if (getElById("SSID"+i).disabled == true) {
				setCheck("SSID"+i, 0);
			}
		}
	} else {
		for (i = 0; i < WanIpList.length -1; i++)
		{
			if (WanIpList[i].BindPhyPort != "" && WanIpList[i].ConnectionType == "IP_Routed" && WanIpList[i].ServiceList.toUpperCase().indexOf("INTERNET") >= 0) {
				DisableLanAndSSID(WanIpList[i].BindPhyPort);
			}
		}
		
		for (i = 0; i < WanPppList.length -1; i++)
		{
			if (WanPppList[i].BindPhyPort != "" && WanPppList[i].ConnectionType == "IP_Routed" && WanPppList[i].ServiceList.toUpperCase().indexOf("INTERNET") >= 0) {
				DisableLanAndSSID(WanPppList[i].BindPhyPort);
			}
		}
	}
}

function GetLANPortListInfo() {
	var tempLANPortValue = "";
	var tempLANPortList = LANPortInfo.split(",");
	var CurLANPortList = new Array();
	for (var i = 0; i < tempLANPortList.length; i++)
	{		
		if (tempLANPortList[i].indexOf(LANPath.toUpperCase()) != -1) {
			tempLANPortValue = tempLANPortList[i].replace(LANPath.toUpperCase(), "LAN");
		} else {
			tempLANPortValue = tempLANPortList[i].replace(SSIDPath.toUpperCase(), "SSID");
		}

		var tempLANPortInfoList = tempLANPortValue.split(".");
		CurLANPortList[i] = tempLANPortInfoList[0];
	}
	
	self.parent.CurrentLANPortList = CurLANPortList;
}

function InitLANPortFromValue() {
	setCheck("LAN1", 0);
	setCheck("LAN2", 0);
	setCheck("LAN3", 0);
	setCheck("LAN4", 0);
	setCheck("LAN5", 0);
    setCheck("LAN6", 0);
    setCheck("LAN7", 0);
    setCheck("LAN8", 0);
	setCheck("SSID1", 0);
	setCheck("SSID2", 0);
	setCheck("SSID3", 0);
	setCheck("SSID4", 0);
	setCheck("SSID5", 0);
	setCheck("SSID6", 0);
	setCheck("SSID7", 0);
	setCheck("SSID8", 0);
	setDisable("SSID1", 1);
	setDisable("SSID2", 1);
	setDisable("SSID3", 1);
	setDisable("SSID4", 1);
	setDisable("SSID5", 1);
	setDisable("SSID6", 1);
	setDisable("SSID7", 1);
	setDisable("SSID8", 1);

	if (notSupportPON == "1") {
        setDisplay("Div_LAN4", 0);
	}
	for(var i = 0; i < self.parent.CurrentLANPortList.length; i++)
	{
		setCheck(self.parent.CurrentLANPortList[i].toUpperCase(), 1);
	}
	
	for(i = 0; i < WLANInfoList.length - 1; i++)
	{
		setDisable(WLANInfoList[i].SSIDReference, 0);
	}
		
	return;
}

function LANPortSubmit() {
	var tempLANID = "";
	var tempLANValue = "";
	var tempSSIDID = "";
	var tempSSIDValue = "";
	var tempLANPortValue = "";
	var iCount = 0;
	var i = 0;
	for (i = 1; i <= TopoInfo.EthNum; i++) {
		tempLANID = "LAN" + i;
		tempLANValue = LANPath + i;
		if (1 == getCheckVal(tempLANID)) {
			if (iCount == 0) {
				tempLANPortValue = tempLANValue;
			} else {	
				tempLANPortValue = tempLANPortValue + "," + tempLANValue;
			}
			iCount = iCount + 1;
		}
	}

	for (i = 1; i <= self.parent.TopoInfo.SSIDNum; i++)
	{
		tempSSIDID = "SSID" + i;
		tempSSIDValue = SSIDPath + i;
		if (1 == getCheckVal(tempSSIDID)) {
			if (iCount == 0) {
				tempLANPortValue = tempSSIDValue;
			} else {	
				tempLANPortValue = tempLANPortValue + "," + tempSSIDValue;
			}
			iCount = iCount + 1;
		}
	}
    if (fttrmain == '1') {
        if (getCheckVal("PON1") == 1) {
            if (tempLANPortValue == "") {
                tempLANPortValue = "PON1";
            } else {
                tempLANPortValue = tempLANPortValue + ",PON1";
            }
        }
    }
	
	var Form = new webSubmitForm();
	Form.addParameter('x.PhyPortName', tempLANPortValue);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_APService.MultiSrvPortList' + '&RequestFile=html/bbsp/lanservicecfg/lanportcfg.asp');
	Form.submit();
	return;
}

function LANPortCancle() {
	LoadFrame();
	return;
}

function InitLANPortShow() {
	for (var i = 1; i <= 8; i++) {
		setDisable("LAN"+i, 1);
	}
	for (var i = 1; i <= 8; i++) {
		setDisable("SSID"+i, 1);
	}
}

function InitAPInfoForm() {
	if (APInfoList.length - 1 == 0) {
	   selectLine('record_no');
	   setDisplay('form_APConfigInfo',0);
	} else {
	   selectLine(TableName + '_record_0');
	   setDisplay('form_APConfigInfo', 0);
	}
	setDisable('btnApply_ex',0);
	setDisable('cancel',0);

	if(isValidMacAddress(numpara) == true) {
		clickAdd(TableName + '_head');
		setText('li_APMACAddr', numpara);
	}
	
	checkboxfunc();
	setDisable('li_APMACAddr',1);
	selectIndex = 0;
}

function LoadFrame() {
	InitLANPortFromValue();
	if ((RegPageFlag == 0) && (RegNewPageFlag == 1)) {
		InitLANPortShow();
		InitWANPhyPort();
	}
	setDisplay('div_APInfo', 0);
	DisableLanAndSSID(CurrentMAINUpInfo);
	DisplayLanAndSSID(CurrentIPTVUpInfo);
	if(Advancedconfig == 1) {
		InitAPInfoForm();
	}

	if (window.parent.isGuidePage) {		
		$(".mainbody").css("background-color", "#FFFFFF");
		$("#APInfo").css("margin-left", "0");
		$("#APInfo_content").css("color", "#666666");
		top.setDisplay("framepageContent", 1);
	}

	return;
}

function APMACSelectChange() {
	var index = getSelectVal('APMACSelect');
    if (index == 0) { 
        setText('li_APMACAddr', "");
		setText('li_stbPort', "LAN2");
    } else {
        setText('li_APMACAddr', APInfoList[index - 1].APMacAddr);
		setText('li_stbPort', "LAN2");
		for (var i = 0; i < APSetInfoList.length - 1; i++) {
			if (APSetInfoList[i].Mac.toUpperCase() == APInfoList[index - 1].APMacAddr.toUpperCase()) {
				setText('li_stbPort', APSetInfoList[i].StbPort);
			} 
		}
    }
}

function CheckForm() {   
    var macAddress = getElement('li_APMACAddr').value;
    
	if (macAddress == '') {
		AlertEx(lanservicecfg_language['bbsp_lanservice_choose_ap_macisreq']);
        return false;
    }

    for (var i = 0; i < APSetInfoList.length - 1; i++) {
		if (macAddress.toUpperCase() != APSetInfoList[i].Mac.toUpperCase()) {
			continue;
		} else {
			selectIndex = i; 
			break;
		}
    }
    return true;
}

function AddSubmitParam() {
	if (false == CheckForm()) {
		return;
	}
    var APSpecCfgParaList = new Array(new stSpecParaArray("x.Mac", getValue('li_APMACAddr'), 1),
                                      new stSpecParaArray("x.StbPort", getValue('li_stbPort'), 1));
	var url = '';
    if( selectIndex == -1 ) {
		 url = 'add.cgi?x=InternetGatewayDevice.X_HW_APService.MultiSrvPortList.AP'
		                        + '&RequestFile=html/bbsp/lanservicecfg/lanportcfg.asp';
	} else {
	     url = 'set.cgi?x=' + APSetInfoList[selectIndex].domain
							+ '&RequestFile=html/bbsp/lanservicecfg/lanportcfg.asp';
	}
	
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = APConfigFormList;
	Parameter.SpecParaPair = APSpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	HWSetAction(null, url, Parameter, tokenvalue);	
	
    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
}

function checkStbPort() {
	var stbPortList = getValue('li_stbPort');
	var tmplist = stbPortList.split(",");
	var portlist = new Array();
	var EthNum = TopoInfo.EthNum;
	for (var i = 1; i <= EthNum; i++) {
		portlist[i -1] = "LAN" + i;
	}
	
	for (var i = 0; i < (tmplist.length); i++) {
		if(portlist.indexOf(tmplist[i].toUpperCase()) == -1)
			return false;
	}
	return true;
}

function SubmitEx() {
	if (false == checkStbPort()) {
		 AlertEx(lanservicecfg_language['bbsp_lanservice_choose_ap_porterror']);
		return;
	}
    AddSubmitParam();
}

function setCtlDisplay(record) {
    setText('li_APMACAddr', record.Mac);
    setText('li_stbPort', record.StbPort);
    setSelect('APMACSelect', '0');
}

function setControl(index) {   
    var record;
    selectIndex = index;
    if (index == -1) {
	    if (APSetInfoList.length >= 16 + 1) {
            setDisplay('form_APConfigInfo', 0);
            return;
        } else {
            record = new APSetInfo('', '', '');
            setDisplay('form_APConfigInfo', 1);
            setCtlDisplay(record);
        }
	}
    else if (index == -2) {
        setDisplay('form_APConfigInfo', 0);
    } else {
	    record = APSetInfoList[index];
        setDisplay('form_APConfigInfo', 1);
        setCtlDisplay(record);
	}
    setDisable('btnApply_ex',0);
    setDisable('cancel',0);
}

function CancelValue() {   
    if (selectIndex == -1) {
        var tableRow = getElement(TableName);

        if (tableRow.rows.length == 1) {
        }
        else if (tableRow.rows.length == 2) {
		   setDisplay('form_APConfigInfo',0);
        } else {
            tableRow.deleteRow(tableRow.rows.length - 1);
            selectLine(TableName + '_record_0');
        }
    } else {
        setText('li_APMACAddr', APSetInfoList[selectIndex].Mac);
        setText('li_stbPort', APSetInfoList[selectIndex].StbPort);
    }
}

function CreateDeviceNameSelectinfo() {
	if (APInfoList.length > 1) {
		for (var i = 0, j = 1; i < (APInfoList.length - 1); i++) {
			APMacSelectList[j] = APInfoList[i].APMacAddr;
			j++;
		}
	}
    var output = '';
    for (i = 0; i < APMacSelectList.length; i++) {
        output = '<option value="' + i + '" title="' + htmlencode(APMacSelectList[i]) + '">' + GetStringContent(htmlencode(APMacSelectList[i]), 30) + '</option>';
        $("#APMACSelect").append(output);
    } 
}

function removeClick() {
   var rml = getElement('rml');
  
   if (rml == null)
   	   return;
 
   var Form = new webSubmitForm();

   var k;	   
   if (rml.length > 0) {
      for (k = 0; k < rml.length; k++) {
         if ( rml[k].checked == true ) {
			 Form.addParameter(rml[k].value,'');
		 }	
      }
   }  
   else if ( rml.checked == true ) {
	  Form.addParameter(rml.value,'');
   }
   Form.addParameter('x.X_HW_Token', getValue('onttoken'));	  
   Form.setAction('del.cgi?RequestFile=html/bbsp/lanservicecfg/lanportcfg.asp.asp');
   Form.submit();
}

function OnDeleteButtonClick(TableID) { 
    if ((APSetInfoList.length - 1) == 0) {
	    AlertEx(lanservicecfg_language['bbsp_lanservice_choose_ap_noapfilter']);
	    return;
	}

	if (selectIndex == -1) {
	    AlertEx(lanservicecfg_language['bbsp_lanservice_choose_ap_saveapfilter']);
	    return;
	}

    var CheckBoxList = document.getElementsByName(TableName+'rml');
	var Form = new webSubmitForm();
	var Count = 0;
	for (var i = 0; i < CheckBoxList.length; i++) {
		if (CheckBoxList[i].checked != true) {
			continue;
		}
		
		Count++;
		Form.addParameter(CheckBoxList[i].value,'');
	}
	if (Count <= 0) {
		AlertEx(lanservicecfg_language['bbsp_lanservice_choose_ap_selectapfilter']);
		return;
	}

	if (ConfirmEx(lanservicecfg_language['bbsp_lanservice_choose_ap_filterconfirm1']) == false) {
		document.getElementById("DeleteButton").disabled = false;
		return;
	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_APService.MultiSrvPortList.AP' + '&RequestFile=html/bbsp/lanservicecfg/lanportcfg.asp');
	Form.submit();
	setDisable('DeleteButton',1);
	setDisable('btnApply_ex',1);
	setDisable('cancel',1);
}
			
function APConfigListselectRemoveCnt(val) {

}

function AddConfigFlag()
{
	if ((IsCTRG == 1) && (currentBin.toUpperCase() != "COMMON")) {
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=/CustomApp/Aindex.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
		 ;
		}
		}); 
	} else {
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
		 ;
		}
		}); 
	}
	
}

var changeUrl = "";
function PortGuideNext() {
    if ((IsCTRG == 1) && (currentBin.toUpperCase() != "COMMON")) {
        window.top.location = "/CustomApp/Aindex.asp";
        return;
    }
    top.onchangestep(changeUrl);
}

function guideNext(val)
{
    changeUrl = val;
    AddConfigFlag();
    if ((fttrmain == 1) && (curUserType == 0) && (IsCTRG == 1)) {
        wifiConfig();
    }
    setTimeout("PortGuideNext()", 300);
}

function guideSkip(val)
{
    changeUrl = val;
    AddConfigFlag();
    if ((fttrmain == 1) && (curUserType == 0) && (IsCTRG == 1)) {
        wifiConfig();
    }
    setTimeout("PortGuideNext()", 300);
}

function checkboxfunc() {
	if(Advancedconfig != 1) {
		return;
	}
	
	if(LANPortInfo.length > 0) {
		setDisplay('div_APInfo', 1);
	} else {
		setDisplay('div_APInfo', 0);
	}
}

</script>
</head>
<body  class="mainbody nomargin" onload="LoadFrame();">
    <form id="LANPortConfigForm" style="display:block">
        <table id="table_LANPortInfo" width="100%" border="0" align="center" cellpadding="0" cellspacing="1" > 
            <tr id="LANPortID" class='align_left'> 
            <td class="LanBg">
                <div id="Div_LAN1"> 
                    <input type="checkbox" id="LAN1" name="cb_Lan1" value="LAN1" onClick="checkboxfunc();">LAN1</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN2"> 
                    <input type="checkbox" id="LAN2" name="cb_Lan2" value="LAN2" onClick="checkboxfunc();">LAN2</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN3"> 
                    <input type="checkbox" id="LAN3" name="cb_Lan3" value="LAN3" onClick="checkboxfunc();">LAN3</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN4"> 
                    <input type="checkbox" id="LAN4" name="cb_Lan4" value="LAN4" onClick="checkboxfunc();">LAN4</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN5"> 
                    <input type="checkbox" id="LAN5" name="cb_Lan5" value="LAN5" onClick="checkboxfunc();">LAN5</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN6"> 
                    <input type="checkbox" id="LAN6" name="cb_Lan6" value="LAN6" onClick="checkboxfunc();">LAN6</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN7"> 
                    <input type="checkbox" id="LAN7" name="cb_Lan7" value="LAN7" onClick="checkboxfunc();">LAN7</input>
                </div> 
            </td>
            <td class="LanBg">
                <div id="Div_LAN8"> 
                    <input type="checkbox" id="LAN8" name="cb_Lan8" value="LAN8" onClick="checkboxfunc();">LAN8</input>
                </div> 
			</td>
            <td class="LanBg">
                <div id="Div_PON1"> 
                    <input type="checkbox" id="PON1" name="cb_pon1" value="PON1" onClick="checkboxfunc();">PON1</input>
                </div> 
            </td>
            </tr>
        <script>
        var EthNum = TopoInfo.EthNum;
        for (var i = 1; i <= 8; i++) {
            if (E8CRONGHEFlag == 1) {
                setDisplay("Div_LAN"+3, 0);
            }

            if (i > EthNum) {
                setDisplay("Div_LAN"+i, 0);
            }
		}
        if(fttrmain == '0') {
            setDisplay("Div_PON1", 0);
        }
        </script>
		</table>

		<table id="table_SSIDPortInfo" width="100%" border="0" align="center" cellpadding="0" cellspacing="1" > 
		  <tr id="SSIDPortID" class='align_left'> 
			<td class="LanBg">
				<div id="Div_SSID1"> 
					<input type="checkbox" id="SSID1" name="cb_Ssid1" value="SSID1" onClick="checkboxfunc();">SSID1</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID2"> 
					<input type="checkbox" id="SSID2" name="cb_Ssid2" value="SSID2" onClick="checkboxfunc();">SSID2</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID3"> 
					<input type="checkbox" id="SSID3" name="cb_Ssid3" value="SSID3" onClick="checkboxfunc();">SSID3</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID4"> 
					<input type="checkbox" id="SSID4" name="cb_Ssid4" value="SSID4" onClick="checkboxfunc();">SSID4</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID5"> 
					<input type="checkbox" id="SSID5" name="cb_Ssid5" value="SSID5" onClick="checkboxfunc();">SSID5</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID6"> 
					<input type="checkbox" id="SSID6" name="cb_Ssid6" value="SSID6" onClick="checkboxfunc();">SSID6</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID7"> 
					<input type="checkbox" id="SSID7" name="cb_Ssid7" value="SSID7" onClick="checkboxfunc();">SSID7</input>
				</div> 
			</td>
			<td class="LanBg">
				<div id="Div_SSID8"> 
					<input type="checkbox" id="SSID8" name="cb_Ssid8" value="SSID8" onClick="checkboxfunc();">SSID8</input>
				</div> 
			</td>
          </tr>
		  <script>
		  var SSIDNum = self.parent.TopoInfo.SSIDNum;
		  var i;
		  for (i = 1; i <= 8; i++)
		  {
			  if (i > SSIDNum)
			  {
				setDisplay("Div_SSID"+i, 0);
			  }
		  }
		  </script>
		</table>
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("LANPortConfigForm", null);
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			HWParsePageControlByID("LANPortConfigForm", TableClass, lanservicecfg_language, null);
		</script>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<script language="JavaScript" type="text/javascript">
					if (window.parent.isGuidePage) {
						document.write('<td class="table_submit width_per40"></td>');
					} else {
						document.write('<td class="table_submit width_per30"></td>');
					}
				</script>
				<td class="table_submit" id="btlanportapply">
					<button type="button" name="btnLANPortApply"  id="btnLANPortApply"  class="ApplyButtoncss  buttonwidth_100px" onClick='LANPortSubmit()'><script>document.write(lanservicecfg_language['bbsp_lanservice_lanportapply']);</script></button> 
					<button type="button" name="btnLANPortCancle" id="btnLANPortCancle" class="CancleButtonCss buttonwidth_100px" onClick='LANPortCancle()'><script>document.write(lanservicecfg_language['bbsp_lanservice_lanportcancle']);</script></button> 
				</td>
			</tr>
		</table>
	</form>
	<br><br>
	<div class="title_spread"></div>
	<div id="div_APInfo">
		<div id="ChooseApHeadID" style="display:block">
			<table width="100%" height="0" border="0" cellpadding="0" cellspacing="0">
				<script language="JavaScript" type="text/javascript">
				if (window.parent.isGuidePage == 1) {
					document.write('<div id="APInfo" class="PageTitle">');
					document.write('<div id="APInfo_title" class="PageTitle_title">' + lanservicecfg_language["bbsp_lanservice_choose_apcfg"] + '</div>');
					document.write('<div id="APInfo_content" class="PageTitle_content">' + lanservicecfg_language["bbsp_lanservice_choose_ap_note3"] + '</div></div>');
				} else {
					var apnote = lanservicecfg_language['bbsp_lanservice_choose_ap_note1'];
					var LanServiceSummaryArray = new Array( new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_choose_ap_title1")),
														new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice__note")),
														new stSummaryInfo("text",apnote),
											null);
					HWCreatePageHeadInfo("APInfo", lanservicecfg_language["bbsp_lanservice_choose_ap_note2"], LanServiceSummaryArray, true);
				}
			   </script>
			</table>
		</div>
		<script language="JavaScript" type="text/javascript">
			var APConfiglistInfo = new Array(new stTableTileInfo("Empty", "", "DomainBox"),
													new stTableTileInfo("bbsp_lanservice_choose_ap_mac1", "", "Mac"),
													new stTableTileInfo("bbsp_lanservice_choose_ap_port1", "", "StbPort"), null);
			var ColumnNum = 3;
			var ShowButtonFlag = true;
			var APTableConfigInfoList = new Array();
			var TableDataInfo = HWcloneObject(APSetInfoList, 1);
			HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, APConfiglistInfo, lanservicecfg_language, null);
		</script>

		<form id="form_APConfigInfo" style="display:none;"> 
			<div class="list_table_spread"></div>
			<table border="0" cellpadding="0" cellspacing="1"  width="100%">
				<li id="li_APMACAddr" RealType="TextOtherBox" DescRef="bbsp_lanservice_choose_ap_mac" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="17" InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'APMACSelect'},{AttrName:'class',AttrValue:'Select_2 restrict_dir_ltr'}]}]"/>
				<li id="li_stbPort" RealType="TextBox" DescRef="bbsp_lanservice_choose_ap_port" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="Empty" MaxLength="64" InitValue="Empty" />
			</table>
			<script language="JavaScript" type="text/javascript">
				APConfigFormList = HWGetLiIdListByForm("form_APConfigInfo", null);
				HWParsePageControlByID("form_APConfigInfo", TableClass, lanservicecfg_language, null);
			</script>
			 <table cellpadding="0" cellspacing="0" width="100%" class="table_button"> 
				  <tr > 
					<td class='width_per30'></td> 
					<td class="table_submit">
					  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
					  <button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="SubmitEx();"><script>document.write(lanservicecfg_language['bbsp_lanservice_iptvupapply']);</script></button> 
					  <button id='Cancel' name="cancel" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelValue();"><script>document.write(lanservicecfg_language['bbsp_lanservice_iptvupcancle']);</script></button> </td> 
				  </tr> 
				  <tr> 
					  <td  style="display:none"> <input type='text'> </td> 
				  </tr>          
			</table> 
		</form>
	</div>
	 
	<script>
		if (window.parent.isGuidePage) {
			document.write('<table cellpadding="0" cellspacing="0" width="100%" >');
			document.write('<tr ><td class="table_submit width_per40"></td>');

			if ((window.parent.fttrmainflag == 1) && (window.parent.curUserType == 0)) {
				if ((IsCTRG == 1) && (currentBin.toUpperCase() != "COMMON")) {
					document.write('<td class="table_submit"' + '<input type="hidden" name="gd_onttoken" id="gd_hwonttoken" value="<%HW_WEB_GetToken();%>">');
					document.write('<input id="guidewificfg" type="button" class="CancleButtonCss buttonwidth_100px" style="margin-left:0px;" BindText="" name="/html/amp/wlanbasic/guidewificfg.asp?cfgguide=1" onClick="top.onchangestep(this);">');
					getElById('guidewificfg').value = lanservicecfg_language['bbsp_lanservice_prestep'];
					document.write('<input id="bbsp_skip" type="button" class="CancleButtonCss buttonwidth_100px"  BindText="" name="/html/ssmp/bss/guidebssinfo.asp" onClick="guideSkip(this);"></td></tr></table>');
					getElById('bbsp_skip').value = lanservicecfg_language['bbsp_lanservice_guideover'];
				} else {
					document.write('<td class="table_submit"' + '<input type="hidden" name="gd_onttoken" id="gd_hwonttoken" value="<%HW_WEB_GetToken();%>">');
					document.write('<input id="guidewancfg" type="button" class="CancleButtonCss buttonwidth_100px" style="margin-left:0px;" BindText="" name="/html/bbsp/wan/wan.asp?cfgguide=1" onClick="top.onchangestep(this);">');
					getElById('guidewancfg').value = lanservicecfg_language['bbsp_lanservice_prestep'];
					document.write('<input id="guidecfgdone" type="button" class="ApplyButtoncss buttonwidth_100px" BindText="" name="/html/ssmp/bss/guidebssinfo.asp" onClick="guideNext(this);">');
					document.write('<input id="bbsp_skip" type="button" class="CancleButtonCss buttonwidth_100px"  BindText="" name="/html/ssmp/bss/guidebssinfo.asp" onClick="guideSkip(this);"></td></tr></table>');
					getElById('guidecfgdone').value = lanservicecfg_language['bbsp_lanservice_nexttep'];
					getElById('bbsp_skip').value = lanservicecfg_language['bbsp_lanservice_skip'];
				}
			} else {
				document.write('<td class="table_submit"' + '<input type="hidden" name="gd_onttoken" id="gd_hwonttoken" value="<%HW_WEB_GetToken();%>">');
				document.write('<input id="guidesyscfg" type="button" class="CancleButtonCss buttonwidth_100px" style="margin-left:0px;" BindText="" name="/html/ssmp/accoutcfg/guideaccountcfg.asp" onClick="top.onchangestep(this);">');
				getElById('guidesyscfg').value = lanservicecfg_language['bbsp_lanservice_prestep'];
				document.write('<input id="guidecfgdone" type="button" class="ApplyButtoncss buttonwidth_100px" BindText="" name="/html/ssmp/cfgguide/userguidecfgdone.asp" onClick="onindexpage(this);">');
				document.write('<input id="bbsp_skip" type="button" class="CancleButtonCss buttonwidth_100px"  BindText="" name="/html/ssmp/cfgguide/userguidecfgdone.asp" onClick="onindexpage(this);"></td> </tr></table>');
				getElById('guidecfgdone').value = lanservicecfg_language['bbsp_lanservice_nexttep'];
				getElById('bbsp_skip').value = lanservicecfg_language['bbsp_lanservice_skip'];
			}
		}
	</script>
<script language="JavaScript" type="text/javascript">
CreateDeviceNameSelectinfo();
getElById('APMACSelect').onchange = function() {
	APMACSelectChange();
}
</script>
</body>
</html>