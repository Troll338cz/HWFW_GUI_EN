<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"/>
<link rel="stylesheet" type="text/css" href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" />
<link rel="stylesheet" type="text/css" href="/Cuscss/<%HW_WEB_GetCusSource(mainpage.css);%>" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<script language="javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='/Cusjs/<%HW_WEB_CleanCache_Resource(InitFormCus.js);%>'></script>
<script language="javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/GetLanUserDevInfo.asp"></script>
<script language="javascript" src="/html/bbsp/common/lanuserinfo.asp"></script>
<script language="javascript" src="/Cusjs/<%HW_WEB_CleanCache_Resource(mainpagesrc.asp);%>"></script>
<script language="JavaScript" src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var UserName = '<%HW_WEB_GetCurUserName();%>';
var MainPageToken = "<%HW_WEB_GetToken();%>";
var IsInterNetOk = false;
var VoipLineInfo;
var WanList = new Array();
var statusEnum = {"NoInternetWan" : "0", "InternetWanSuccess" : "1", "PPPoEInternetWanFail" : "2", "DHCPInternetWanFail" : "3", "OpticalFail" : "4", "OtherReason" : "5"};
var IPv6AddressList = new Array();
var IPv6WanInfoList = new Array();
var wifiResult = null;
document.title = ProductName;
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var stOnlineStatusInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>';
//var wlanupmodeRFBand = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_WLANConfiguration.RFBand);%>';
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>';
var apghnfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var IGMPEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_IPTV.IGMPEnable);%>';
var ghndiagnoserseult = '<%HW_WEB_GhnLinkStatus();%>';
var apgetwan = "";

var aprepeater = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var aprepEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.AutoSelectSlaveApUpPort);%>';

var ProductType = '<%HW_WEB_GetProductType();%>';

var videomode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_VideoCoverService.VideoCoverEnable);%>';
var upMode = '<%HW_WEB_GetUpMode();%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var autoadapt = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AUTO_ADAPT);%>';
var adaptResult = '<%HW_WEB_GetCModeAdaptValue();%>';
var IsBin5 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_IS_BIN5);%>';
var IsSupportBridgeWan = "<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>";
var dslStatus='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Status);%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var tedataFlag = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
var htFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var isMegacableFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
var isOnlyL2 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_LSW_WEB_CUT);%>';
var dethmaxisap = '<%HW_WEB_GetFeatureSupport(FT_DETHMAXIS_APMODE);%>';

if (["TOTALPLAY", "TOTALPLAY2"].indexOf(CfgMode.toUpperCase()) >= 0) {
    var ispStaInfo = '<%WEB_GetIspStaInfo();%>';
    var ispStaInfoJson = JSON.parse(ispStaInfo);
}

function stIspWlan(domain, SSID_IDX)
{
    this.domain = domain;
    this.SSID_IDX = SSID_IDX;
}
var IspWlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.X_HW_WLANForISP.{i}, SSID_IDX, stIspWlan, EXTEND);%>;
function isSsidForIsp(index)
{
    if (IspWlanInfo == null) {
        return 0;
    }
    for (var i = 0; i < (IspWlanInfo.length - 1); i++) {
        if (IspWlanInfo[i].SSID_IDX == index) {
            return 1;
        }
    }

    return 0;
}


if(autoadapt == 1)
{
	curChangeMode = 4;
}

function stRepeaterInfo(SSID,BSSID,Channel,Rate_RX,Rate_TX,MCS_RX,MCS_TX,ChannelWidth,RSSI)
{
	this.SSID = SSID;
	this.BSSID = BSSID;
    this.Channel = Channel;
    this.Rate_RX = Rate_RX;
	this.Rate_TX = Rate_TX;
	this.MCS_RX = MCS_RX;
	this.MCS_TX = MCS_TX;
	this.ChannelWidth = ChannelWidth;
	this.RSSI = RSSI;
}

function GetEthLinkStatus(domain, Status)
{
	this.domain	= domain;
	this.Status = Status; 
}
var EthLinkStatus = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig, Link, GetEthLinkStatus);%>;
if(1 != curChangeMode && 1 == aprepEnable)
{
	if(3 == aprepeater)
	{
		curChangeMode = 2;
	}
	else if(8 == aprepeater)
	{
		curChangeMode = 3;
	}
}

function GetToken()
{
	return MainPageToken;
}

function ErrorDiages()
{
    if ((((htFlag == "1") || (isMegacableFlag == "1")) && (curUserType != "0")) || (CfgMode.toUpperCase() == 'CLARODR')) {
        return false;
    } else {	   
        window.parent.onMenuChange("OntCheck");
    }
}

function IsOpticalNomal()
{
	if ((wifiResult!=null) && (wifiResult.opticInfo == "ok") && (wifiResult.regStatus == "ok"))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function InternetWanDiagnose()
{
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		data : '&x.X_HW_Token='+ MainPageToken,
		url : "/html/amp/common/getSmartDiagnoseResult.asp",
		success : function(data) {
			wifiResult = dealDataWithFun(data);
			var IsOpticalOk = IsOpticalNomal();
			setInternetStatus(IsOpticalOk);
		},
		complete: function (XHR, TS) {
			XHR = null;
		}
	});
}

function setInternetStatus(IsOpticalOk)
{
	var internetstatus = '';
	var AllWanInfo = '';
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		data : '&x.X_HW_Token='+ MainPageToken,
		url : "/html/bbsp/common/getwanlist.asp",
		success : function(data) {
			AllWanInfo = dealDataWithFun(data);
			WanList = AllWanInfo.WanList;
			IPv6AddressList = AllWanInfo.IPv6AddressList;
			IPv6WanInfoList = AllWanInfo.IPv6WanInfoList;
			internetstatus = GetInternetWanstate(WanList, IPv6WanInfoList, IPv6AddressList, IsOpticalOk);
			Oninternetstatus(internetstatus);
		}
	});
}

function GetIPv6AddressList(WanInstanceId, ipv6addlist)
{
	var List = new Array();
	var Count = 0;

	for (var i = 0; i < ipv6addlist.length; i++)
	{
		if(ipv6addlist[i] == null)
			continue;

		if (ipv6addlist[i].WanInstanceId != WanInstanceId)
			continue;

		List[Count++] = ipv6addlist[i];
	}

	return List;
}

function GetIPv6Address(wan, ipv6addlist)
{
	var AddressList = GetIPv6AddressList(wan.MacId, ipv6addlist);
	var AddressHtml = "";
	for (var m = 0; m < AddressList.length; m++)
	{
		if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
		{
			if (wan.Enable == "1")
			{
				if(AddressHtml == '')
					AddressHtml += AddressList[m].IPAddress;
				else
					AddressHtml += "<br>" + AddressList[m].IPAddress;
			}
		}
	}
	return AddressHtml;
}

function GetIPv6WanInfo(WanInstanceId, ipv6wanlist)
{
	for (var i = 0; i < ipv6wanlist.length; i++)
	{
		if (ipv6wanlist[i] != null)
		{
			if (ipv6wanlist[i].WanInstanceId == WanInstanceId)
			{
				return ipv6wanlist[i];
			}
		}
	}
}

function IsExitIPAddress(wan, ipv6wanlist, ipv6addlist)
{
	var existAddr = false;
	var ipv6Wan = GetIPv6WanInfo(wan.MacId, ipv6wanlist);
	var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());

	if (('IPv4' == wan.ProtocolType) && ("CONNECTED" == wan.Status.toUpperCase()) && ('' != wan.IPv4IPAddress))
	{
		existAddr = true;
	}
    if ((wan.ProtocolType == 'IPv6') && (ipv6wanStatus == "CONNECTED")) {
		existAddr = true;
	}
    if ((wan.ProtocolType == 'IPv4/IPv6') &&
        (((wan.Status.toUpperCase() == "CONNECTED") && (wan.IPv4IPAddress != '')) || (ipv6wanStatus == "CONNECTED"))) {
		existAddr = true;
	}

	return existAddr;
}

function IsExistBridgeWan(wan)
{
	if (wan.Mode != 'IP_Bridged') {
		return false;
	}
	if (wan.Status.toUpperCase() != 'CONNECTED') {
		return false;
	}

	return true;
}

function GetInternetWanDiagResult(wan, ipv6wanlist, ipv6addlist)
{
	if ((IsExitIPAddress(wan, ipv6wanlist, ipv6addlist) == true) ||
		(IsExistBridgeWan(wan) == true))
	{
		return statusEnum["InternetWanSuccess"];
	}
	else if (wan.Mode == 'IP_Routed')
	{
		if ('PPPoE' == wan.EncapMode)
		{
			return statusEnum["PPPoEInternetWanFail"];
		}
		else if ('IPoE' == wan.EncapMode)
		{
			return statusEnum["DHCPInternetWanFail"];
		}
	}
	else
	{
		return statusEnum["NoInternetWan"];
	}
}


function GetInternetWanstate(wanlist, ipv6wanlist, ipv6addlist, IsOpticalOk)
{
	var InternetDiagStatus = "";

    if (videomode == 1)
    {
        if ((curChangeMode == 2) && (EthLinkStatus[EthLinkStatus.length-2].Status == 1))
        {
            return statusEnum["OtherReason"];
        }
        else if ((curChangeMode == 3) && (stOnlineStatusInfo == 1))
        {
            return statusEnum["OtherReason"];
        }
        else
        {
            return statusEnum["OpticalFail"];
        }
    }

	if ((false == IsOpticalOk) &&  (1 != smartlanfeature)&&( '2' != ProductType))
	{
		if('3' != upMode){
			return statusEnum["OpticalFail"];
		}
	}

	if (wanlist.length == 0)
	{
		return statusEnum["NoAnyWan"];
	}

	var InternetWanList = new Array();
	for (var i = 0, j = 0; i < wanlist.length; i++)
	{
		if (((wanlist[i].Mode== 'IP_Routed') || (wanlist[i].Mode == 'IP_Bridged'))
			&& (wanlist[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
			&& ("1" == wanlist[i].Enable))
		{
			InternetWanList[j] = wanlist[i];
			j++;
		}
	}

	if (InternetWanList.length == 0)
	{
		return statusEnum["NoInternetWan"];
	}
	else if(InternetWanList.length == 1)
	{
		return  GetInternetWanDiagResult(InternetWanList[0], ipv6wanlist, ipv6addlist);
	}
	else
	{
		if (statusEnum["InternetWanSuccess"] == GetInternetWanDiagResult(InternetWanList[0], ipv6wanlist, ipv6addlist))
		{
			return statusEnum["InternetWanSuccess"];
		}
		else
		{
			InternetDiagStatus = GetInternetWanDiagResult(InternetWanList[0], ipv6wanlist, ipv6addlist);
		}

		for (var k = 1; k < InternetWanList.length; k++)
		{
			if(statusEnum["InternetWanSuccess"] == GetInternetWanDiagResult(InternetWanList[k], ipv6wanlist, ipv6addlist))
			{
				InternetDiagStatus = statusEnum["InternetWanSuccess"];
				break;
			}

		}
		return InternetDiagStatus;
	}

	return statusEnum["OtherReason"];
}


function Oninternetstatus(internetstatus)
{
	switch(internetstatus)
	{
		case statusEnum["OpticalFail"]:
			IsInterNetOk = false;
			break;
		case statusEnum["NoAnyWan"]:
			IsInterNetOk = false;
			if(isOnlyL2 == 1){
				IsInterNetOk = true;
			}
			break;

		case statusEnum["InternetWanSuccess"]:
		case statusEnum["OtherReason"]:
			IsInterNetOk = true;
			apgetwan = true;
			break;

		case statusEnum["NoInternetWan"]:
			if ((ProductType == '2') && (IsSupportBridgeWan == 1))
			{
				IsInterNetOk = (dslStatus == "Up") ? true : false;
			}
			else
			{
				IsInterNetOk = (stOnlineStatusInfo == "1") ? true : false;
			}
			break;
		case statusEnum["PPPoEInternetWanFail"]:
		case statusEnum["DHCPInternetWanFail"]:
			IsInterNetOk = false;
			apgetwan = false;
			break;
		default:
			break;
	}

	DiagnoseAPShow();

	if(true == IsInterNetOk)
	{
		setHtmlValue("InterNetStatusText", framedesinfo["mainpage002"]);
		setDivShowHide("hide", "ErrorDiages");
		$("#InterNetStatus").css("background-color", "#F6FBFC");
		$("#InterNetStatus").css("background", "#F6FBFC");
		$("#InterNetStatus").css("border-bottom", "1px solid #A6A6A6");
		if(true == IsSupportWifi())
		{
			$("#InternetLineTop").css("background", "url( ../images/interneticonLineTop.jpg) no-repeat center");
			$("#InternetLineBottom").css("background", "url( ../images/interneticonLineBottom.jpg) no-repeat center");
		}
		else
		{
			$("#NowifiInternetLineTop").css("background", "url( ../images/internetmidlinetop.jpg) no-repeat center");
			$("#NowifiInternetLineBottom").css("background", "url( ../images/internetmidlinebutton.jpg) no-repeat center");
		}
	}
	else
	{	
		if(("1" == IsBin5 || "1" == IsSupportBridgeWan) &&  "1" == stOnlineStatusInfo)
		{
			setHtmlValue("InterNetStatusText", framedesinfo["mainpage002"]);
			setDivShowHide("hide", "ErrorDiages");
			$("#InterNetStatus").css("background-color", "#F6FBFC");
			$("#InterNetStatus").css("background", "#F6FBFC");
			$("#InterNetStatus").css("border-bottom", "1px solid #A6A6A6");
			
			$("#NowifiInternetLineTop").css("background", "url( ../images/internetmidlinetop.jpg) no-repeat center");
			$("#NowifiInternetLineBottom").css("background", "url( ../images/internetmidlinebutton.jpg) no-repeat center");
		}
		else
		{
			var InterNetStatusText = (1 == parseInt(var_singtel) ? framedesinfo["mainpage003a"]:framedesinfo["mainpage003"]);
			setHtmlValue("InterNetStatusTextDiv", InterNetStatusText);	
			$("#InterNetStatusTextDiv").css("color", "#FFFFFF");
			if ((((htFlag == "1") || (isMegacableFlag == "1")) && (curUserType != "0")) || (CfgMode.toUpperCase() == 'CLARODR')) {
			    setDivShowHide("hide", "ErrorDiages");
			} else {
			    setDivShowHide("block", "ErrorDiages");
			}
			$("#InterNetStatus").css("background", "url( ../images/interneterr.jpg) no-repeat center");
			$("#InterNetStatus").css("border", "none");
			
			if(true == IsSupportWifi())
			{
				$("#InternetLineTop").css("background", "url( ../images/internet_errtop.jpg) no-repeat center");
				$("#InternetLineBottom").css("background", "url( ../images/internet_err.jpg) no-repeat center");
			}
			else
			{
				$("#NowifiInternetLineTop").css("background", "url( ../images/internetmidtop_err.gif) no-repeat center");
				$("#NowifiInternetLineBottom").css("background", "url( ../images/intermiderrbottom.gif) no-repeat center");
			}

            if (dethmaxisap == "1") {
                setDivShowHide("hide", "ErrorDiages");
            }
        }
    }
}
function GetVoipLine()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : '&x.X_HW_Token='+ MainPageToken,
		url : "/html/voip/status/getVoipLine.asp",
		success : function(data){
			VoipLineInfo = dealDataWithFun(data);
			//alert(VoipLineInfo.length);
		}
	});
}

function SetDeviceNum()
{
	var VoipLineNum = 0;
	var EthDevNum = 0;
	var WifiDevNum = 0;
	GetLanUserInfo(function(para1, para2)
	{
		UserDevinfo = para2;
		var WifiDev = new Array();
		var EthDev = new Array();

		for (var i=0; (null !=UserDevinfo && UserDevinfo.length > 0 && i < UserDevinfo.length-1); i++)
		{
            if (["TOTALPLAY", "TOTALPLAY2"].indexOf(CfgMode.toUpperCase()) >= 0) {
                var skipFlag = 0;
                for (var j = 0; j < ispStaInfoJson.length; j++) {
                    if (UserDevinfo[i].MacAddr.toLowerCase() == ispStaInfoJson[j].ispStaMac.toLowerCase()) {
                        skipFlag = 1;
                        break;
                    }
                }
                if (skipFlag == 1) {
                    continue;
                }
            }

			if(UserDevinfo[i].PortType.toUpperCase() == "ETH" || UserDevinfo[i].PortType.toUpperCase() == "ONU")
			{
			    if ((UserDevinfo[i].DevStatus == "Offline") && (CfgMode == 'DAUM2WIFI')) {
					continue;
				}
				EthDev[EthDevNum] = new USERDevice("","","","","","","","","","");
				EthDev[EthDevNum] = UserDevinfo[i];
				EthDevNum++;

			}
			else if(UserDevinfo[i].PortType.toUpperCase() == "WIFI")
			{
				if ((UserDevinfo[i].DevStatus == "Offline") && (CfgMode == 'DAUM2WIFI')) {
					continue;
				}

				if (UserDevinfo[i].PortType.toUpperCase().indexOf("WIFI") >=0) {
					var ssidindex = UserDevinfo[i].Port;
					ssidindex = ssidindex.charAt(ssidindex.length-1);
					if (isSsidForIsp(ssidindex) == 1) {
						continue;
					}
				}

				WifiDev[WifiDevNum] = new USERDevice("","","","","","","","","","");
				WifiDev[WifiDevNum] = UserDevinfo[i];
				WifiDevNum++;
			}
		}

		if(true == IsSupportWifi() && true == IsSupportVoice())
		{
			setHtmlValue("wifinumspan", framedesinfo['mainpage010'] + "(" + WifiDevNum + ")");
			setHtmlValue("linenumspan", framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
		}
		else if(true == IsSupportWifi() && false == IsSupportVoice())
		{
			setHtmlValue("wifinumspan", framedesinfo['mainpage010'] + "(" + WifiDevNum + ")");
			setHtmlValue("linenumspan", framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
		}
		else if(false == IsSupportWifi() && true == IsSupportVoice())
		{
			setHtmlValue("wifinumspan", framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
		}
		else
		{
			setHtmlValue("linenumspan", framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
		}

		if(SingtelMode == 1)
		{
			setHtmlValue("wifinumspan", framedesinfo['mainpage018'] + "(" + EthDevNum + ")");
		}

		if(IsSupportVoice())
		{
			//VoipLineNum = AllLine.length - 1;
			GetVoipLine();
			try{
				VoipLineNum = VoipLineInfo.length - 1;
			}catch(e){VoipLineNum = 0;}
			setHtmlValue("phonenumspan", framedesinfo['mainpage012'] + "(" + VoipLineNum + ")");
		}
	});
}

function setStepClass(id, css)
{
	$("#" + id).removeClass(id);
	$("#" + id).addClass(css);
}
function DiagnoseghnResult()
{
	var diagnreslut = ghndiagnoserseult.split(",");
	if (diagnreslut[0] == 0)
	{
		setStepClass("ghndianright","ghntoroute");
	}
	if (diagnreslut[1] == 0)
	{
		setStepClass("ghndianerror","ghntorep");
	}
}

function DiagnoseRepResult()
{
	if (!apgetwan)
	{
		setStepClass("rewifipic241","rewifitogetway");
		$("#rewificontent241").css("visibility", "hidden");
				
		var SSID = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_WLANConfiguration.SSID);%>';
		if (SSID != '' && SSID != undefined)
		{
			getElementById('configtitle1').innerHTML = 'SSID:' + htmlencode(SSID);
		}
		else
		{
			getElementById('configtitle1').innerHTML = framedesinfo['mainpage050'];
		}
						
		$("#configtitle1").css({'font-size':'14px','margin-top':'70px','margin-left':'75px','width':'110px','word-break':'break-all','text-align':'center'});
	}
	else 
	{
		var RepeaterInfo = new stRepeaterInfo(<%HW_WEB_RepeaterinfoGet();%>);
		if (RepeaterInfo.Channel < 15)	
		//if (wlanupmodeRFBand == '2.4GHz')
		{
			getElementById('rewificontent241').innerHTML = framedesinfo['mainpage031'];
		}
		else 
		{
			getElementById('rewificontent241').innerHTML = framedesinfo['mainpage032'];
		}
		
		$("#rewificontent241").css("visibility", "visible");
	}
}

function DiagnoseAPResult()
{
	if (!apgetwan)
	{
		setStepClass("apdianright","aptogetway");
	}
}


function DiagnoseAPShow()
{
	if (apghnfeature == 1)
	{
		DiagnoseghnResult();
		return;
	}
	if (curChangeMode=='2')
	{
		DiagnoseAPResult();
	}else if (curChangeMode=='3')
	{
		DiagnoseRepResult();
	}

}

function loadframe()
{
	InternetWanDiagnose();
	SetDeviceNum();


	if (tedataFlag == "1") {
	    $("#RestartIcon").css("display","none");
	    $("#Restarttext").css("display","none");	
	}

	if ((CfgMode.toUpperCase() == "DAUM2WIFI") || (CfgMode.toUpperCase() == "PERUCLARO")) {
		document.getElementById("InterNetStatus").style.display = "none";
	}
	if (IsSupportBridgeWan == 1)
    {
        document.getElementById("InterNetStatus").style.display="none";
    }

    if ((IsBin5 == "1") || (IsSupportBridgeWan == "1")) {
		document.getElementById('wifidevline').style.display ='none';
		document.getElementById('wifidevCnt').style.display ='none';
		document.getElementById('wifidevCntSpan').style.display ='none';
		
		document.getElementById('wifidevIcon').style.display ='block';
        $(".rtwuxian1").css("display","none");
		document.getElementById('phonedevIcon').style.display ='block';
		$(".rtyouxian1").css("display","none");
		document.getElementById("oldrouter").style.display="block";
	}
	else
	{
		if (('SONET_HN8255Ws' == CfgMode) || ('JAPAN_HN8255Ws' == CfgMode))
		{
			document.getElementById('phonedevIcon').style.display ='none';
			document.getElementById('phonedevline').style.display ='none';
			document.getElementById('phonedevCntSpan').style.display ='none';
		}
		else
		{
			document.getElementById('phonedevIcon').style.display ='block';
		}
		document.getElementById('wifidevIcon').style.display ='block';
        $(".rtwuxian1").css("display","none");
		$(".rtyouxian1").css("display","none");
		document.getElementById("oldrouter").style.display="block";
	}
	
	if ((((htFlag == "1") || (isMegacableFlag == "1")) && (curUserType != "0")) || (CfgMode.toUpperCase() == 'CLARODR')) {
	    setDivShowHide("hide", "ErrorDiages");	
	}
}

function adjustParentHeight(containerID, newHeight)
{
	if ((navigator.appName.indexOf("Internet Explorer") == -1)
		&& (containerID == "ContectdevmngtPage"))
	{
		var height = document.body.scrollHeight;
		$("#mainpage").css("height", height);
	}
	$("#" + containerID).css("height", newHeight + "px");
	//window.parent.adjustParentHeight();
}

function wifiModeShow(){
	$("#wifimode").show();
}

function wifiModehide(){
	$("#wifimode").hide();
}

function quitcur(){
	$("#wifimode").hide();
}

function devfunction()
{
	document.getElementById("cmodeiframe").style.display="block";
	$("iframe#Showcmodediv").attr("src", "../html/ssmp/deviceinfo/deviceinfo.asp");
}

function DivYXfun()
{
	document.getElementById("cmodeiframe").style.display="block";
	$("iframe#Showcmodediv").attr("src", "../html/bbsp/userdevinfo/userdevinfosmart.asp?type=linedev");
	ShowAPDeviceNum();
}

function DivWXfun()
{
	document.getElementById("cmodeiframe").style.display="block";
	$("iframe#Showcmodediv").attr("src", "../html/bbsp/userdevinfo/userdevinfosmart.asp?type=wifidev");
	ShowAPDeviceNum();
}

function Div24fun()
{
	document.getElementById("cmodeiframe").style.display="block";
	$("iframe#Showcmodediv").attr("src", "../html/amp/wlaninfo/wlanapstatus.asp?type=2.4G");
}

function Div241fun()
{
	if (!apgetwan)
	{
		return;
	}
	
	document.getElementById("cmodeiframe").style.display="block";
	$("iframe#Showcmodediv").attr("src", "../html/amp/wlaninfo/wlanrepeaterinfo.asp");
}

function Div5fun()
{
	document.getElementById("cmodeiframe").style.display="block";
	$("iframe#Showcmodediv").attr("src", "../html/amp/wlaninfo/wlanapstatus.asp?type=5G");
}

function ShowAPDeviceNum()
{
	if(apghnfeature == 1){

		SetAPDeviceNum("ghnwxdev","ghnyxdev");
		return;
	}

	if(curChangeMode=='2'){

		SetAPDeviceNum("apwxdev","apyxdev");

	}else if(curChangeMode=='3'){

		SetAPDeviceNum("rewxdev","reyxdev");
	}
}

function SetAPDeviceNum(wirelessid,wiredid)
{
	var EthDevNum = 0;
	var WifiDevNum = 0;
	GetLanUserInfo(function(para1, para2)
	{
		UserDevinfo = para2;
		var WifiDev = new Array();
		var EthDev = new Array();

		for (var i=0; (null !=UserDevinfo && UserDevinfo.length > 0 && i < UserDevinfo.length-1); i++)
		{
			if(UserDevinfo[i].PortType.toUpperCase() == "ETH")
			{
				EthDev[EthDevNum] = new USERDevice("","","","","","","","","","");
				EthDev[EthDevNum] = UserDevinfo[i];
				EthDevNum++;

			}
			else if(UserDevinfo[i].PortType.toUpperCase() == "WIFI")
			{
				WifiDev[WifiDevNum] = new USERDevice("","","","","","","","","","");
				WifiDev[WifiDevNum] = UserDevinfo[i];
				WifiDevNum++;
			}
		}
		setHtmlValue(wirelessid, framedesinfo['mainpage010'] + "(" + WifiDevNum + ")");
		setHtmlValue(wiredid, framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
	});
}
function ResetONT()
{
	var Title = ResetLgeDes["s0601"];
	if(ConfirmEx(Title))
	{
		setDisable('btnReboot',1);

		var Form = new webSubmitForm();

		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
								+ '&RequestFile=../CustomApp/mainpage.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}
function RestoreONT()
{
	var Title = RestoreLgeDes["s0a01"];
	if(ConfirmEx(Title))
	{
		var Form = new webSubmitForm();

		setDisable('btnRestoreDftCfg', 1);
		Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/accoutcfg/ontmngt.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}
</script>

</head>
<body class="mainpagebody" onload="loadframe();" style="position: relative;">

<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">

<a id="showcenter" href="#Contectdevmngt" style="display:none;">aaa</a>

<div id="InterNetStatus">
<div id="InterNetStatusTextDiv">
<span id="InterNetDes" class="InternetSpanLeftText" BindText="mainpage001"></span><span id="InterNetStatusText" class="InternetSpanRightText"></span></div>
<script>
if (curLanguage.toUpperCase() == 'BRASIL') {
    document.write('<div id="ErrorDiages"><input type="button" id="ErrorDiagesButton" class="whitebuttonBlueBgcss buttonwidth_120px_200px" style="padding:5px;" onClick="ErrorDiages(this);" value="" BindText="mainpage004"></div>');
} else {
    document.write('<div id="ErrorDiages"><input type="button" id="ErrorDiagesButton" class="whitebuttonBlueBgcss buttonwidth_120px_180px" style="padding:5px;" onClick="ErrorDiages(this);" value="" BindText="mainpage004"></div>');
}
</script>
</div>

<div id ="oldrouter" style="display:none;">
<div id="mainpage">
<div id="Internet">
<div id="InternetIconinfo">
<div id="InternetIcon"></div>
<div id="InternetTextId" class="InternetText"><span id="InternetTextspan" BindText="mainpage005"></span></div>
</div><!-- end of InternetIconinfo -->
<div id="InternetLineTop"></div>
</div><!-- end of Internet -->

<div id="NowifiInternet">
<div id="nowifiInternetTextId" class="InternetText"><span id="nowifiInternetTextspan" BindText="mainpage005"></span></div>
<div id="NowifiInternetIcon"></div>
<div id="NowifiInternetLineTop"></div>
<div id="nowifiinternetstatusinfo">
<div id="NowifiInternetPointer"></div>
<div id="nowifiinternettop" class="showtop"></div>
<div id="nowifiinternetinfo" class="internetinfo">
<iframe id="nowifiInternetSrc" frameborder="0" height="100%" marginheight="0" marginwidth="0" width="100%" scrolling="no"></iframe>
</div>
<div id="nowifiinternetbottom" class="showbottom"></div>
</div>
<div id="NowifiInternetLineBottom"></div>
</div>

<div id="internetstatusinfo">
<div id="internetpointer"></div>
<div id="internettop" class="showtop"></div>
<div id="internetinfo" class="internetinfo">
<iframe id="InternetSrc" frameborder="0" height="100%" marginheight="0" marginwidth="0" width="100%" scrolling="no"></iframe>
</div>
<div id="internetbottom" class="showbottom"></div>
</div><!-- end of internetstatusinfo -->

<div id="middiv">
<div id="InternetLineBottom"></div>
<div id="WIFIIconInfo">
<div id="WIFIIcon">
<div id="WIFIText"><span id="WIFITextspan" BindText="mainpage006"></span></div>
</div>
<div id="WIFILine"></div>
</div><!-- end of WIFIConfig -->
</div><!-- end of middiv -->

<div id="ConfigWifiInfo">
<div id="ConfigWifiInfopointer"></div>
<div id="ConfigWifitop" class="showtop"></div>
<div id="ConfigWifiPage">
<iframe id="ConfigWifiPageSrc" frameborder="0" height="100%" marginheight="0" marginwidth="0" width="100%" scrolling="no"></iframe>
</div>
<div id="ConfigWifibottom" class="showbottom"></div>
</div><!-- end of ConfigWifiInfo -->

<div id="routerconfig">
<div id="router">
<div id="routericon">
<div id="routerclick"></div>
<div id = "usbport">
<div id = "usbportIcon"></div>
<div id = "usbporttext" class="portspantext">USB</div>
</div><!-- end of usbport -->
<div id="RestartDiv">
<div id = "RestartIcon"></div>
<script>
  if (CfgMode.toUpperCase == "TTNET2") {
    document.write('<div id = "Restarttext" class="portspantext2" BindText="mainpage015b"></div>')
  } else {
    document.write('<div id = "Restarttext" class="portspantext2" BindText="mainpage015"></div>')
  }
</script>
</div><!-- end of RestartDiv -->
</div><!-- end of routericon -->
</div><!-- end of router -->

<div id="routermngt" name="routermngt">
<div id ="routermngtpointer"></div>
<div id="routermngttop" class="showtop"></div>
<div id="routermngtpage">
<iframe id="routermngtpageSrc" frameborder="0" height="100%" marginheight="0" marginwidth="0" width="100%" scrolling="no"></iframe>
</div>
<div id="routermngtbottom" class="showbottom"></div>
</div><!-- end of routermngt -->

<div id="usbsamba" name="usbsamba">
<div id ="usbsambapointer"></div>
<div id="usbsambatop" class="showtop"></div>
<div id="usbsambapage">
<iframe id="usbsambapageSrc" frameborder="0" height="100%" marginheight="0" marginwidth="0" width="100%" scrolling="no"></iframe>
</div>
<div id="usbsambabottom" class="showbottom"></div>
</div><!-- end of usbsamba -->

<div id="Contectdevlineinfo">
<div id="wifidevline"></div>
<div id="linedevline"></div>
<div id="phonedevline"></div>
</div><!-- end of Contectdevlineinfo -->

<div id="ContectDevDetails">
<div id="wifidevCnt">
<div id="wifidevIcon"></div>

<div class="rtwuxian1" style="" onmouseover="this.className='rtwuxian2'" onmouseout="this.className='rtwuxian1'" ></div>

</div><!-- end of wifidevCnt -->

<div id="linedevCnt">
<div id="linedevIcon"></div>
</div><!-- end of linedevCnt -->

<div id="phonedevCnt">
<div id="phonedevIcon"></div>

<div class="rtyouxian1" style="" onmouseover="this.className='rtyouxian2'" onmouseout="this.className='rtyouxian1'"></div>

</div><!-- end of phonedevCnt -->
</div><!-- end of ContectDevDetails -->

<div id="ContectNumDetails">
<div id="wifidevCntSpan"><span id="wifinumspan"></span></div>
<div id="linedevCntSpan"><span id="linenumspan"></span></div>
<div id="phonedevCntSpan"><span id="phonenumspan"></span></div>
</div><!-- end of ContectNumDetails -->
</div> <!-- end of routerconfig -->

<div id="CntPointer">
<div id="wifidevCntPointer"></div>
<div id="linedevCntPointer"></div>
<div id="phonedevCntPointer"></div>
</div><!-- end of CntPointer -->
<div id="Contectdevmngt" name="Contectdevmngt">
<div id="devmngttop" class="showtop"></div>
<div id="ContectdevmngtPage">
<iframe id="ContectdevmngtPageSrc" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no"></iframe>
</div>
<div id="devmngtbottom" class="showbottom"></div>
</div><!-- end of Contectdevmngt -->

<div id="MainPpageSpace">
</div><!-- end of MainPpageSpace -->

</div><!-- end of mainpage -->
<br>
<br>
<div id="wifimode" style="display:none;">
<div id="wifipage" >
	<span id="quitIcon" onclick="quitcur();"></span>
</div>
</div>
</div>


<div id="newAccessPoint" style="display:none;">

	<div id="apInterPics">
		<div id="apgatewaydiv">
			<div id="apgatewaypic"></div>
			<div id="apgatewaycontent" BindText="mainpage029"></div>
		</div>
		<div id="apdianline">
			<div id="apdianright" class="apdianright"></div>
		</div>
		<div id="apdiv">
			<div class="accesspoint1" onClick="devfunction();" onmouseover="this.className='accesspoint2'" onmouseout="this.className='accesspoint1'"></div>
			<div id="apcontent" BindText="mainpage030"></div>
		</div>
		<div id="apwifidiv24" >
			<div id="apwifipic24" onClick="Div24fun();"></div>
			<div id="apwificontent24" BindText="mainpage031"></div>
		</div>
		<div id="apshuline"></div>
		<div id="apwifidiv5">
			<div id="apwifipic5" onClick="Div5fun();"></div>
			<div id="apwificontent5" BindText="mainpage032"></div>
		</div>
		<div class="clear"></div>
		<div id="apdivs">
			<div id="apxulines">
				<div id="apwifipic1"></div>
			</div>
			<div id="apshilines">
				<div id="apwificon"></div>
			</div>
		</div>
		<div id="apdevices">
		<div id="apwuxiandev">
			<div class="apwuxian1" onClick="DivWXfun();" onmouseover="this.className='apwuxian2'" onmouseout="this.className='apwuxian1'" ></div>
			<div id="apwxdev" style="" BindText="mainpage037"></div>
		</div>
		<div id="apyouxiandev">
			<div class="apyouxian1" onClick="DivYXfun();" onmouseover="this.className='apyouxian2'" onmouseout="this.className='apyouxian1'"></div>
			<div id="apyxdev" BindText="mainpage038"></div>
		</div>
		</div>
	</div>
</div>

<div id="newRangeExtender" style="display:none;">
	<div id="reInterPics">
		<div id="regatewaydiv">
			<div id="regatewaypic"></div>
			<div id="regatewaycontent" BindText="mainpage034"></div>
		</div>
		<div id="rexuline">
			<div id="configtitle1"></div>
		</div>
		<div id="rewifidiv241">
			<div id="rewifipic241" class="rewifipic241" onClick="Div241fun();"></div>
			<div id="rewificontent241" style="visibility:hidden;" BindText="mainpage031"></div>
		</div>
		<div id="rexuline"></div>
		<div id="rediv">
			<div class="accesspoint1" onClick="devfunction();" onmouseover="this.className='accesspoint2'" onmouseout="this.className='accesspoint1'"></div>
			<div id="recontent" BindText="mainpage035"></div>
		</div>
		<div id="rewifidiv242">
			<div id="rewifipic242" onClick="Div24fun();"></div>
			<div id="rewificontent242" BindText="mainpage031"></div>
		</div>
		<div id="reshuline"></div>
		<div id="rewifidiv5">
			<div id="wifipic5" onClick="Div5fun();"></div>
			<div id="rewificontent5" BindText="mainpage032"></div>
		</div>
		<div class="clear"></div>
		<div id="redivs">
			<div id="rexulines">
				<div id="rewifipic1"></div>
			</div>
			<div id="reshilines">
				<div id="rewificon"></div>
			</div>
		</div>
		<div id="redevices">
		<div id="rewuxiandev">
			<div class="rewuxian1" onClick="DivWXfun();" onmouseover="this.className='rewuxian2'" onmouseout="this.className='rewuxian1'"></div>
			<div id="rewxdev" style="" BindText="mainpage037"></div>
		</div>
		<div id="reyouxiandev">
			<div class="reyouxian1" onClick="DivYXfun();" onmouseover="this.className='reyouxian2'" onmouseout="this.className='reyouxian1'"></div>
			<div id="reyxdev" BindText="mainpage038"></div>
		</div>
		</div>
	</div>
</div>

<div id="newRangeExtenderGhn" style="display:none;">
	<div id="ghnInterPics">
		<div id="ghngatewaydiv">
			<div id="ghngatewaypic"></div>
			<div id="ghngatewaycontent" BindText="mainpage034"></div>
		</div>
		<div id="ghndianline">
			<div id="ghndianright" class="ghndianright"></div>
		</div>
		<div id="ghndiv1" style="">
			<div id="ghnwifipic1"></div>
			<div id="ghnwificontent" BindText="mainpage039"></div>
		</div>
		<div id="ghndianline">
			<div id="ghndianerror" class="ghndianerror"></div>
		</div>
		<div id="ghndiv2">
			<div class="ghnpic1" onClick="devfunction();" onmouseover="this.className='ghnpic2'" onmouseout="this.className='ghnpic1'"></div>
			<div id="ghncontent" BindText="mainpage035"></div>
		</div>
		<div id="ghndiv24">
			<div id="ghnpic24" onClick="Div24fun();"></div>
			<div id="ghncontent24" BindText="mainpage031"></div>
		</div>
		<div id="ghnshuline"></div>
		<div id="ghndiv5">
			<div id="ghnpic5" onClick="Div5fun();"></div>
			<div id="ghncontent5" BindText="mainpage032"></div>
		</div>
		<div class="clear"></div>

		<div id="ghndivs">
			<div id="ghnxulines">
				<div id="ghndivpic1"></div>
			</div>
			<div id="ghnshilines">
				<div id="ghnwificon"></div>
			</div>
		</div>
		<div id="ghndevices">
		<div id="ghnwuxiandev">
			<div class="ghnwuxian1" onClick="DivWXfun();" onmouseover="this.className='ghnwuxian2'" onmouseout="this.className='ghnwuxian1'"></div>
			<div id="ghnwxdev" BindText="mainpage037"></div>
		</div>
		<div id="ghnyouxiandev">
			<div class="ghnyouxian1" onClick="DivYXfun();" onmouseover="this.className='ghnyouxian2'" onmouseout="this.className='ghnyouxian1'"></div>
			<div id="ghnyxdev" BindText="mainpage038"></div>
		</div>
		</div>
	</div>
</div>

	<div id="cmodeiframe" style="margin-top:220px;display:none;" >
		<iframe id="Showcmodediv" frameborder="0" width="100%" height="610px" marginheight="0" marginwidth="0" src="" style="overflow-y: scroll;"></iframe>
	</div>
</body>
<script type="text/javascript">
	ParseBindTextByTagName(framedesinfo, "span", 1);
	ParseBindTextByTagName(framedesinfo, "div", 1);
	ParseBindTextByTagName(framedesinfo, "input", 2);
</script>
</html>
