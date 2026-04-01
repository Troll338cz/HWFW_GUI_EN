<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link rel="stylesheet" type="text/css" href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" />
<link rel="stylesheet" type="text/css" href="/Cuscss/<%HW_WEB_GetCusSource(mainpage.css);%>" />
<link rel="shortcut icon" href="../images/singtel.ico" />
<link rel="Bookmark" href="../images/singtel.ico" />
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
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var IGMPEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_IPTV.IGMPEnable);%>';

function GetToken()
{
	return MainPageToken;
}

function ErrorDiages()
{
	window.parent.onMenuChange("OntCheck");
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
	if (('IPv6' == wan.ProtocolType) && ("CONNECTED" == ipv6wanStatus) && ('' != GetIPv6Address(wan, ipv6addlist)))
	{
		existAddr = true;
	}
	if (('IPv4/IPv6' == wan.ProtocolType)
		&&(("CONNECTED" == wan.Status.toUpperCase() && '' != wan.IPv4IPAddress) || ("CONNECTED" == ipv6wanStatus && '' != GetIPv6Address(wan, ipv6addlist))))
	{
		existAddr = true;
	}

	return existAddr;
}

function GetInternetWanDiagResult(wan, ipv6wanlist, ipv6addlist)
{
	if(true == IsExitIPAddress(wan, ipv6wanlist, ipv6addlist))
	{
		return statusEnum["InternetWanSuccess"];
	}
	else
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
}

function GetInternetWanstate(wanlist, ipv6wanlist, ipv6addlist, IsOpticalOk)
{
	var InternetDiagStatus = "";
	if (false == IsOpticalOk)
	{
		return statusEnum["OpticalFail"];
	}

	var InternetWanList = new Array();
	for (var i = 0, j = 0; i < wanlist.length; i++)
	{
		if(('IP_Routed' == wanlist[i].Mode)
			&& (wanlist[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
			&& ("1" == wanlist[i].Enable))
		{
			InternetWanList[j] = wanlist[i];
			j++;
		}
	}
	
	if(InternetWanList.length == 0)
	{
		return statusEnum["NoInternetWan"];
	}
	else if(InternetWanList.length == 1)
	{
		return  GetInternetWanDiagResult(InternetWanList[0], ipv6wanlist, ipv6addlist);
	}
	else
	{
		if(statusEnum["InternetWanSuccess"] == GetInternetWanDiagResult(InternetWanList[0], ipv6wanlist, ipv6addlist))
		{
			return statusEnum["InternetWanSuccess"];
		}
		else
		{
			InternetDiagStatus = GetInternetWanDiagResult(InternetWanList[0], ipv6wanlist, ipv6addlist);
		}
		
		for(var k = 1; k < InternetWanList.length; k++)
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

		case statusEnum["NoInternetWan"]:
		case statusEnum["InternetWanSuccess"]:
		case statusEnum["OtherReason"]:
			IsInterNetOk = true;
			break;

		case statusEnum["PPPoEInternetWanFail"]:
		case statusEnum["DHCPInternetWanFail"]:
			IsInterNetOk = false;
			break;

		default:
			break;
	}

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
		if (1 == parseInt(var_singtel))
		{
			setHtmlValue("InterNetStatusTextDiv", framedesinfo["mainpage003a"]);
		}
		else
		{
		setHtmlValue("InterNetStatusTextDiv", framedesinfo["mainpage003"]);
		}
		$("#InterNetStatusTextDiv").css("color", "#FFFFFF");
		//$("#ErrorDiagesButton").css("color", "black");
		setDivShowHide("block", "ErrorDiages");
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

		if(true == IsSupportWifi() && true == IsSupportVoice())
		{
			setHtmlValue("wifinumspan", framedesinfo['mainpage010'] + "(" + WifiDevNum + ")");
			setHtmlValue("linenumspan", framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
		}
		else if(true == IsSupportWifi() && false == IsSupportVoice())
		{
			setHtmlValue("wifinumspan", framedesinfo['mainpage010'] + "(" + WifiDevNum + ")");
			setHtmlValue("phonenumspan", framedesinfo['mainpage011'] + "(" + EthDevNum + ")");
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

function loadframe()
{
	InternetWanDiagnose();
	SetDeviceNum();
	
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
</script>
</head>
<body class="mainpagebody" onload="loadframe();">
<a id="showcenter" href="#Contectdevmngt" style="display:none;">aaa</a>
<div id="mainpage">
<div id="InterNetStatus">
<div id="InterNetStatusTextDiv">
<span id="InterNetDes" class="InternetSpanLeftText" BindText="mainpage001"></span><span id="InterNetStatusText" class="InternetSpanRightText"></span></div>
<div id="ErrorDiages"><input type="button" id="ErrorDiagesButton" class="whitebuttonBlueBgcss buttonwidth_120px_180px" style="padding:5px;" onClick="ErrorDiages(this);" value="" BindText="mainpage004"></div>
</div>

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
<div id = "Restarttext" class="portspantext2" BindText="mainpage015"></div>
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
</div><!-- end of wifidevCnt -->

<div id="linedevCnt">
<div id="linedevIcon"></div>
</div><!-- end of linedevCnt -->

<div id="phonedevCnt">
<div id="phonedevIcon"></div>
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
</body>
<script type="text/javascript">
ParseBindTextByTagName(framedesinfo, "span", 1);
ParseBindTextByTagName(framedesinfo, "div", 1);
ParseBindTextByTagName(framedesinfo, "input", 2);
</script>
</html>