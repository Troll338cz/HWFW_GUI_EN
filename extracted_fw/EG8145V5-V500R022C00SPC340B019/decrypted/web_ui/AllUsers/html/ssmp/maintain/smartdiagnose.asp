<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link href="../../../Cuscss/<%HW_WEB_GetCusSource(ontdinagse.css);%>" rel="stylesheet" type="text/css" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/ontstate.asp"></script> 
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<style type="text/css">
a.redlink{
	margin-left:10px;
	color:#ff5555;
	cursor:pointer;
}

a.redlink:hover{
	text-decoration:underline;
}

a.redlink:active{
	text-decoration:underline;
}

a.greenlink{
	margin-left:10px;
	color:#45c954;
	cursor:text;
}

a.greenlink:hover{
	text-decoration:none;
}
a.greenlink:active{
	text-decoration:none;
}
.buttonwidth_120px_200px{
    width:auto;
}
</style>
<script language="JavaScript" type="text/javascript">
var WanList = GetWanList();
var IPv6AddressList = new Array();
var IPv6WanInfoList = new Array();
var statusEnum = {"NoInternetWan" : "0", "InternetWanSuccess" : "1", "PPPoEInternetWanFail" : "2", "DHCPInternetWanFail" : "3", "OpticalFail" : "4", "OtherReason" : "5", "PPPoEInternetManual" : "6"};
var SdDevStatus="none";
var CLICK_INIT_FLAG="None";
var CLICK_START_FLAG="START";
var CLICK_TERMINAL_FLAG="TERMIANL";
var EQUIPTEST_FLAG="EquipTest";
var EquipTestClickFlag= "<%HW_WEB_GetRunState("EquipTest");%>";



var EquipTestResultInfo = {};
var PhyResult = new Array();
var EquipShowStr = '';
var IsInternetWanOk = false;
var IsEquipTestOk = false;
var wifiResult = null;

var IsVoipTestOk = false;
var IsPwdTestOk = false;
var IsInternetTestOk = false;
var IsStbTestOK = false;
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var IsSupportpon2lan = '<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var isDoubleWLAN = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var DiagnoseToken='';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var MngtTelmex = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TELMEX);%>';
var IsBin5 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_IS_BIN5);%>';

var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var var_singtel_hg8244hs = '<%HW_WEB_GetFeatureSupport(VOICE_FT_WEB_SINGTEL_HG8244HS);%>';
var ShowISPSsidFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_CU);%>';
var IsAPFlagfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';
var apghnfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var JumpMode = '<%HW_WEB_JumpMode();%>';
var ghndiagnoserseult = '<%HW_WEB_GhnLinkStatus();%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var isPTVDF = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>";
var isPTVDFB = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDFB);%>";
var var_Support_Inner_SD = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_INNER_SDCARD);%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var aprepeater = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var aprepEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.AutoSelectSlaveApUpPort);%>';
var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
var STBPORT_NOT_EXIST = 0;
var STBPORTUP = 1;
var IS_WAN_ENABLE = 1;

var PreTxMultPackets = 0;
var PreTxUnitPackets = 0;
var passwordStrength2g;
var passwordStrength5g;

var BeginSendMcastFrameTime = 0;

if(1 != ApModeValue && 1 == aprepEnable)
{
	if(3 == aprepeater)
	{
		ApModeValue = 2;
	}
	else if(8 == aprepeater)
	{
		ApModeValue = 3;
	}
}

function stModifyUserInfo(domain,ModifyPasswordFlag)
{
	this.domain = domain;
	this.ModifyPasswordFlag = ModifyPasswordFlag;
}

function stResult(domain,Result)
{
	this.domain = domain;
	this.Result = Result;
}

var StatusPrompt = new Array();
var VoipSupport = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
var TotalTestResult = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.VSPA.TotalTestResult.{i},Result, stResult);%>;
var stOnlineStatusInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>';

var TestState = "<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.VSPA.TotalTest.TestState);%>";
var UserEthInfos = new Array();

var TimerHandle ="";

var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, ModifyPasswordFlag, stModifyUserInfo);%>;
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var bztlf = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_BZTLF);%>';
var videomode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_VideoCoverService.VideoCoverEnable);%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';

if (('SONET_HN8255Ws' == CfgMode) || ('JAPAN_HN8255Ws' == CfgMode))
{
	VoipSupport = 0;
}

try{
	if( 0 == stModifyUserInfos[0].Enable && (undefined != stModifyUserInfos[1] && null != stModifyUserInfos[1]))
	{
		var PwdModifyFlag = stModifyUserInfos[1].ModifyPasswordFlag;
	}
	else
	{
		var PwdModifyFlag = stModifyUserInfos[0].ModifyPasswordFlag;
	}
}catch(e){
	var PwdModifyFlag = stModifyUserInfos[0].ModifyPasswordFlag;
}
if(1 == bztlf)
{
	PwdModifyFlag = stModifyUserInfos[1].ModifyPasswordFlag;
}

function GEInfo(domain,Status)
{
	this.domain		= domain;
	this.Status 	= Status; 
}

var GeInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Link,GEInfo);%>;
function IsOpticalNomal()
{
	return wifiResult != null && wifiResult.opticInfo == "ok";
}

function IsOLTRegistered()
{
	return wifiResult != null && wifiResult.regStatus == "ok";
}

function SetFlag(flag,value)
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : "RUNSTATE_FLAG.value="+value +"&x.X_HW_Token="+DiagnoseToken,
		url : "complex.cgi?RUNSTATE_FLAG="+flag,
		success : function(data) {
		},
		complete: function (XHR, TS) {
			XHR=null;
		}
	});
}

function GetEquipInfo()
{
	PhyResult[0] = EquipTestResultInfo.Port1Result;
	PhyResult[1] = EquipTestResultInfo.Port2Result;
	PhyResult[2] = EquipTestResultInfo.Port3Result;
	PhyResult[3] = EquipTestResultInfo.Port4Result;
	PhyResult[4] = EquipTestResultInfo.Port5Result;
	PhyResult[5] = EquipTestResultInfo.Port6Result;
}

function GetFinalEquipTestResult()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "/html/bbsp/maintenance/getEquipTestResultsmart.asp",
		success : function(data) {
		EquipTestResultInfo = dealDataWithFun(data);
		GetEquipInfo();
		EquipTestResult();
		},
		complete: function (XHR, TS) {
			XHR = null;
		}
	});
}

function GetCurrentStbPacket()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "/html/bbsp/maintenance/getStbDiagnoseResult.asp",
		success : function(data) {
			UserEthInfos = dealDataWithFun(data);
		}
	});
	
}

function IsIPTVWanExist()
{
    var i;
	
	for(i=0; i <= WanList.length - 1; i++)
	{
		if((WanList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0)
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0)
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0))
		{
			return true;
		}
	}
	
	return false;
}

function IsIPTVWanEnable()
{
	for(i=0; i <= WanList.length - 1; i++)
	{
		if(((WanList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0)
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0)
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0))
				&& (IS_WAN_ENABLE == WanList[i].Enable))
		{
			return true;
		}
	}
	return false;
}

function IsIPTVWanConnected()
{
	var i;
	
	for(i=0; i <= WanList.length - 1; i++)
	{
		if(("CONNECTED" == WanList[i].Status.toString().toUpperCase())
				&& ((WanList[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >=0) 
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >=0)
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0))
                && (GetOntState() == "ONLINE"))
		{
			return true;
		}
	}
	
	return false;
}

function IsStbIPTVRunning()
{
	GetCurrentStbPacket();
	
	var StbResultEnd = new Date();
	if((Math.abs(UserEthInfos[stbport - 1].SendMcastFrame - PreTxMultPackets) < (StbResultEnd.getTime() - BeginSendMcastFrameTime)/1000 * 100)
		&& (Math.abs(UserEthInfos[stbport - 1].SendUcastFrame - PreTxUnitPackets) < (StbResultEnd.getTime() - BeginSendMcastFrameTime)/1000 * 100))
	{
		return false;
	}
	return true;
}

function IsStbportUp()
{
	if(STBPORTUP == GeInfos[stbport - 1].Status)
	{
		return true;
	}
	return false;
}

function DisplayResultBackground(IsOKResult, LinePicID)
{
	SetDotLine(LinePicID, IsOKResult);
	document.getElementById(LinePicID).style.display = "block";
	var SelectedPic = (IsOKResult ? "url('../../../images/ok.jpg') no-repeat": "url('../../../images/redwarning.jpg') no-repeat");
	document.getElementById("stbpic").style.background = SelectedPic;
}

function GetStbTestResult()
{			
	var bool_flags = IsStbportUp();	
	
	DisplayResultBackground(bool_flags, "stbinnersublinepic");	
	if(bool_flags)
	{
		getElement('stbinnerstatus').innerHTML = SmartDiagnoseLgeDes['s3015'];			
	}
	else
	{
		getElement('stbinnerstatus').innerHTML = SmartDiagnoseLgeDes['s3016'];	
		return;
	}
		
	bool_flags	= (IsIPTVWanExist() & IsIPTVWanEnable());
	DisplayResultBackground(bool_flags, "WANConfigsublinepic");
	if(bool_flags)
	{
		getElement('IPTVWAnstatus').innerHTML = SmartDiagnoseLgeDes['s3017'];
	}
	else
	{		
		getElement('IPTVWAnstatus').innerHTML = SmartDiagnoseLgeDes['s3018'];	
		return;
	}
			
	bool_flags = IsIPTVWanConnected();
	DisplayResultBackground(bool_flags, "WANConfigsublinepic");
	if(bool_flags)
	{
		getElement('IPTVWAnstatus').innerHTML = SmartDiagnoseLgeDes['s3019'];
	}
	else
	{
		getElement('IPTVWAnstatus').innerHTML = SmartDiagnoseLgeDes['s3020'];
		return;
	}
	
	IsStbTestOK = IsStbIPTVRunning();
	DisplayResultBackground(IsStbTestOK, "IPTVWANsublinepic");
	if(IsStbTestOK)
	{
		getElement('stbstatus').innerHTML = SmartDiagnoseLgeDes['s3021'];
	}
	else
	{
		getElement('stbstatus').innerHTML = SmartDiagnoseLgeDes['s3022'];
		return;
	}
		
}

function GetSdDevTestResult()
{
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "/html/ssmp/maintain/getSdDevTestStatus.asp",
		success : function(data) {				
			SdDevStatus = dealDataWithFun(data);
		},
		complete: function (XHR, TS) {
			XHR = null;
		}
	});
	
}

function OnSetSdCheckResult()
{

	if ( "0" == SdDevStatus)
	{
		document.getElementById('onthardwaresd').innerHTML = htmlencode(SmartDiagnoseLgeDes['s3011']);
		SetDotLine("hwsublinesdpic", true);
	}
	else if ( "1" == SdDevStatus)
	{
		document.getElementById('onthardwaresd').innerHTML = htmlencode(SmartDiagnoseLgeDes['s3012']);
		SetDotLine("hwsublinesdpic", false);
	}
	else if ( "2" == SdDevStatus)
	{
		document.getElementById('onthardwaresd').innerHTML = htmlencode(SmartDiagnoseLgeDes['s3013']);
		SetDotLine("hwsublinesdpic", false);
	}
	else
	{	
		document.getElementById('onthardwaresd').style.display = "none";
		document.getElementById('hwsublinesd').style.display = "none";
		document.getElementById('hwsublinesd').style.backgroundColor = "#F0F0F2";
		document.getElementById('hwsublinesdpic').style.display = "none";
		document.getElementById('hwsublinesdpic').style.backgroundImage = "none";
	}
	
}

function GetEquipTestResult()
{
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "/html/bbsp/maintenance/getEquipTestResultsmart.asp",
		success : function(data) {
		EquipTestResultInfo = dealDataWithFun(data);
		GetEquipInfo();
		EquipTestResult();
		},
		complete: function (XHR, TS) {
			XHR = null;
		}
	});
}

function ParseSelfTestResult(SelfTestResult, PhyResult)
{
	var result = "";
	var resulttemp = "";
	if (SelfTestResult.SD5113Result.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s2000'];
	}

	if (SelfTestResult.WifiResult.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s2001'];
	}

	if (SelfTestResult.LswResult.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s2001'];
	}

	if (SelfTestResult.CodecResult.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s2004'];
	}

	if (SelfTestResult.OpticResult.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s2004'];
	}

	for (i = 0; i < 6; i++)
	{
		if (PhyResult[i].indexOf("Failed") >= 0)
		{
			resulttemp = "ETH" + (i+1) + SmartDiagnoseLgeDes['s2005'];
			result += resulttemp;
		}
	}
	if (SelfTestResult.ExtRfResult.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s1901'];
	}
	
	if (SelfTestResult.DECTResult.indexOf("Failed") >= 0)
	{
		result += SmartDiagnoseLgeDes['s1902'];
	}
	return result;
}

function ParseLinkTestResult(rawresult)
{
	var result = "";
	var resulttemp = "";
	var nochecknum = 0;
	portres = rawresult.split(";");

	for (i =0; i < 12; i++)
	{
		innerres = portres[i].split(":");
		finalres = innerres[1];

		if (finalres.indexOf("NoCheck") >= 0)
		{
			nochecknum++;
			continue;
		}

		if (!(i % 2))
		{
			if (finalres.indexOf("Failed") >= 0)
			{
				if (true == var_singtel)
				{
					resulttemp = "511X ETH" + (i + 2)/2 + SmartDiagnoseLgeDes['s2006a'];
				}
				else
				{
				resulttemp = "511X ETH" + (i + 2)/2 + SmartDiagnoseLgeDes['s2006'];
				}
				result += resulttemp;
			}
		}
		else
		{
			if (finalres.indexOf("Failed") >= 0)
			{
				if (true == var_singtel)
				{
					resulttemp = "ETH" + (i + 1)/2 + SmartDiagnoseLgeDes['s2007a'];
				}
				else
				{
				resulttemp = "ETH" + (i + 1)/2 + SmartDiagnoseLgeDes['s2007'];
				}
				result += resulttemp;
			}
		}
	}

	if (nochecknum == 12)
	{
		result = "NoCheck";
	}
	return result;
}

function EquipTestResult()
{
	var ShowStr = "";
	if ('new Array(null)' == EquipTestResultInfo.LinkTestResult)
	{
		if (true == logo_singtel)
		{
			ShowStr = SmartDiagnoseLgeDes['s2008a'];
		}
		else if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
		{
			ShowStr = SmartDiagnoseLgeDes['s2008_xd'];
		}
		else
		{
			ShowStr = SmartDiagnoseLgeDes['s2008'];
		}		
		if ( "0" != SdDevStatus && true == var_Support_Inner_SD )
		{
			document.getElementById("hwpic").style.background = "url('../../../images/redwarning.jpg') no-repeat";
			IsEquipTestOk = false;		
		}
		else
		{
			document.getElementById("hwpic").style.background = "url('../../../images/ok.jpg') no-repeat";		
			IsEquipTestOk = true;
		}
		
		SetDotLine("hwsublinepic", true);
		IsEquipTestOk = true;
		EquipShowStr = ShowStr;
		document.getElementById('onthardware').innerHTML = htmlencode(EquipShowStr);
		return ShowStr;
	}

	LinkResult = ParseLinkTestResult(EquipTestResultInfo.LinkTestResult);
	EquipFinalStr = ParseSelfTestResult(EquipTestResultInfo, PhyResult) + LinkResult;

	if (EquipFinalStr == "")
	{
		if (true == logo_singtel)
		{
			ShowStr = SmartDiagnoseLgeDes['s2008a'];
		}
		else
		{	
			if(smartlanfeature == 1){
				ShowStr = SmartDiagnoseLgeDes['s2008lan'];
			}
			else if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
			{
				ShowStr = SmartDiagnoseLgeDes['s2008_xd'];
			}
			else
			{
				ShowStr = SmartDiagnoseLgeDes['s2008'];
			}
		}
		
		SetDotLine("hwsublinepic", true);
		
		if ( "0" != SdDevStatus && true == var_Support_Inner_SD )
		{
			document.getElementById("hwpic").style.background = "url('../../../images/redwarning.jpg') no-repeat";
			IsEquipTestOk = false;			
		}
		else
		{
			document.getElementById("hwpic").style.background = "url('../../../images/ok.jpg') no-repeat";		
			IsEquipTestOk = true;
		}
	}
	else
	{
		if (true == logo_singtel)
		{
			ShowStr = SmartDiagnoseLgeDes['s2009b'];
		}
		else
		{
			if(smartlanfeature == 1){
				ShowStr = SmartDiagnoseLgeDes['s2009lan'];
			}
			else{
				ShowStr = SmartDiagnoseLgeDes['s2009'];
			}
		}
		document.getElementById("hwpic").style.background = "url('../../../images/redwarning.jpg') no-repeat";
		SetDotLine("hwsublinepic", false);
	}

	if (LinkResult.indexOf("NoCheck") >= 0)
	{
		ShowStr = "";
	}

	if ('' == ShowStr || "" != EquipFinalStr || ( "0" != SdDevStatus && true == var_Support_Inner_SD ))
	{
		IsEquipTestOk = false;
	}
	else
	{
		IsEquipTestOk = true;
	}

	EquipShowStr = ShowStr;
	document.getElementById('onthardware').innerHTML = htmlencode(EquipShowStr);
	
	if (true == var_Support_Inner_SD)
	{
		OnSetSdCheckResult();
	}

	return ShowStr;
}

function OnEquipCheck()
{
	var lanid = "";
	EquipShowStr = '';
	EquipTestClickFlag = CLICK_START_FLAG;
	EquipTestResultInfo = ajaxGetAspData('/html/bbsp/common/EquipTestResultsmart.asp');
	GetEquipInfo();

	if (EquipTestResultInfo.SD5113Result.indexOf("OK") >= 0)
	{
		for (i = 0; i < 6; i++)
		{
			if (PhyResult[i].indexOf("OK") >= 0)
			{
				lanid += "" + (i +1);
			}
		}
	}

	var ConfigParaList = new Array(new stSpecParaArray("x.portid",lanid, 0),
								   new stSpecParaArray("RUNSTATE_FLAG.value",CLICK_START_FLAG, 0));
	var Parameter = {};
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = ConfigParaList;

	var ConfigUrl = "complexajax.cgi?x=InternetGatewayDevice.X_HW_DEBUG.BBSP.ExtendPortTransCheck&RUNSTATE_FLAG=" + EQUIPTEST_FLAG + '&RequestFile=/html/ssmp/maintain/smartdiagnose.asp';
	HWSetAction("ajax", ConfigUrl, Parameter, DiagnoseToken);
}

function setInternetStatus()
{
	var internetstatus = '';
	var AllWanInfo = '';
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : '&x.X_HW_Token='+ DiagnoseToken,
		url : "/html/bbsp/common/getwanlist.asp",
		success : function(data) {
			AllWanInfo = dealDataWithFun(data);
			WanList = AllWanInfo.WanList;
			IPv6AddressList = AllWanInfo.IPv6AddressList;
			IPv6WanInfoList = AllWanInfo.IPv6WanInfoList;
			internetstatus = GetInternetWanstate(WanList, IPv6WanInfoList, IPv6AddressList);
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

function IsExistIPAddress(wan, ipv6wanlist, ipv6addlist)
{
	var existAddr = false;
	var ipv6Wan = GetIPv6WanInfo(wan.MacId, ipv6wanlist);

	if (('IPv4' == wan.ProtocolType) && ("CONNECTED" == wan.Status.toUpperCase()) && ('' != wan.IPv4IPAddress))
	{
		existAddr = true;
	}
    if ((wan.ProtocolType == 'IPv6') && (ipv6Wan.ConnectionStatus.toUpperCase() == "CONNECTED")) {
		existAddr = true;
	}
    if ((wan.ProtocolType == 'IPv4/IPv6') &&
        (((wan.Status.toUpperCase() == "CONNECTED") && (wan.IPv4IPAddress != '')) || (ipv6Wan.ConnectionStatus.toUpperCase() == "CONNECTED"))) {
		existAddr = true;
	}

	return existAddr;
}

function GetInternetWanDiagResult(wan, ipv6wanlist, ipv6addlist)
{
	if(true == IsExistIPAddress(wan, ipv6wanlist, ipv6addlist))
	{
		return statusEnum["InternetWanSuccess"];
	}
	else
	{
		if ('PPPoE' == wan.EncapMode)
		{
			if(('Manual' == wan.ConnectionTrigger) && ('0' == wan.ConnectionControl))
			{
			    return statusEnum["PPPoEInternetManual"];
			}
			else
			{
			    return statusEnum["PPPoEInternetWanFail"];
			}
		}
		else if ('IPoE' == wan.EncapMode)
		{
			if ((wan.IPv4Enable == 1 && "STATIC" == wan.IPv4AddressMode.toUpperCase())
			    || (wan.IPv6Enable == 1 && "STATIC" == wan.IPv6AddressMode.toUpperCase())) {
				return statusEnum["StaticInternetWanFail"];
			}			
			return statusEnum["DHCPInternetWanFail"];
		}
	}
}

function GetInternetWanstate(wanlist, ipv6wanlist, ipv6addlist)
{
	var InternetDiagStatus = "";

    if (videomode == 1)
    {
        if ((ApModeValue == 2) && (GeInfos[GeInfos.length-2].Status == 1))
        {
            return statusEnum["OtherReason"];
        }
        else if ((ApModeValue == 3) && (stOnlineStatusInfo == 1))
        {
            return statusEnum["OtherReason"];
        }
        else
        {
            return statusEnum["OpticalFail"];
        }
    }

	if(1 != smartlanfeature)
	{
		var IsOpticalOk = IsOpticalNomal();
		var IsOLTRegOk = IsOLTRegistered();
		if ((false == IsOpticalOk) || (false == IsOLTRegOk))
		{
			if(3 != CurrentUpMode && 1 == IsSupportpon2lan){
			return statusEnum["OpticalFail"];
			}
		}
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
	var ValueDivId = ('1' == smartlanfeature || 3 == CurrentUpMode) ? "span_optic" : "ontwanstatus";
	var LineDivId = ('1' == smartlanfeature || 3 == CurrentUpMode) ? "ampsublinepic" : "wanstatusublinepic";
	
	switch(internetstatus)
	{
		case statusEnum["OpticalFail"]:
			SetDotLine(LineDivId, false);
			if (true == var_singtel)
			{
				document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s1900a'];
			}
			else
			{
				document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s1900'];
			}
			IsInterNetOk = false;
			break;

		case statusEnum["NoInternetWan"]:
			if("1" == stOnlineStatusInfo)
			{
				SetDotLine(LineDivId, true);
				document.getElementById(ValueDivId).innerHTML = "--";
				IsInternetWanOk = true;
			}
			else
			{
				SetDotLine(LineDivId, false);
				document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s1900'];
				IsInternetWanOk = false;
			}
			break;
			
		case statusEnum["OtherReason"]:
			SetDotLine(LineDivId, true);
			document.getElementById(ValueDivId).innerHTML = "--";
			IsInternetWanOk = true;
			break;

		case statusEnum["InternetWanSuccess"]:
			if (ApModeValue =="2" || ApModeValue == "3" || apghnfeature == "1")
			{
				SetDotLine(LineDivId, true);
				document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2010ap'];
				IsInternetWanOk = true;												
			}
			else
			{
				SetDotLine(LineDivId, true);
				document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2010'];
				IsInternetWanOk = true;
			}		
			break;

		case statusEnum["PPPoEInternetWanFail"]:
				if (ApModeValue =="2" || ApModeValue == "3" || apghnfeature == "1")
				{
						SetDotLine(LineDivId, false);
						document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s1900ap'];
						IsInternetWanOk = false;												
				}
				else
				{
					SetDotLine(LineDivId, false);
					document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2011'];
					IsInternetWanOk = false;
				}		
			break;

		case statusEnum["DHCPInternetWanFail"]:
				if (ApModeValue =="2" || ApModeValue == "3" || apghnfeature == "1")
				{
					SetDotLine(LineDivId, false);
					document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s1900ap'];
					IsInternetWanOk = false;											

				}
				else
				{
					SetDotLine(LineDivId, false);
					document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2012'];
					IsInternetWanOk = false;
				}		
			break;
			
		case statusEnum["PPPoEInternetManual"]:
			SetDotLine(LineDivId, false);
			document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s3023'];
			IsInternetWanOk = false;
			break;

		default:
			break;
	}
}

function IsWiFiPwdSecurityHigh()
{
	return wifiResult!=null && wifiResult.wifiPwdSecurity=='high';
}

function SetDotLine(id, flag)
{
	var bg;
	var clr;
	if (flag)
	{
		bg = 'greendotline.jpg';
		clr = "#84C802";
	}
	else
	{
		bg = 'reddotline.jpg';
		clr = "#F16262";
	}
	document.getElementById(id).style.background="url('../../../images/" + bg + "') no-repeat bottom";
	document.getElementById(id.substr(0, id.length-3)).style.background=clr;
}

function SetPwdLv(dotId, spanId, linkId)
{
	SetDotLine(dotId, true);
	document.getElementById(spanId).innerHTML = SmartDiagnoseLgeDes['s2023'];
	document.getElementById(linkId).removeAttribute("href");
	document.getElementById(linkId).onclick = function(){};
	$("#"+linkId).removeClass("redlink");
	$("#"+linkId).addClass("greenlink");
}

function IsStbportExist()
{
	if(STBPORT_NOT_EXIST != stbport )
	{
		return true;
	}
	
	return false;
}

function SetDisplayStbframecontent()
{
	document.getElementById("stbframecontent").style.display  = "";
	if(	"none" == document.getElementById("voipframecontent").style.display)
	{
		document.getElementById("stbframecontent").style.marginTop = "195px";
		document.getElementById("stbframecontent").style.marginLeft = "388px";
	}
	else
	{
		document.getElementById("diagnoseframebg").style.height = "600px";
	}
	
}

function DisplayDiagResult()
{
	GetFinalEquipTestResult();
	WiFiDiagnose();
	setInternetStatus();
	

	setDisable('btndiagnose', 0);
	top.UpgradeFlag = 0;
	document.getElementById("diagnoseframebg").style.display  = "block";
	document.getElementById("divdiagnose").style.display  = "";
	document.getElementById('btndiagnose').value = SmartDiagnoseLgeDes['s2019'];
	document.getElementById("interneticon").style.display  = "";
	document.getElementById("routericon").style.display  = "";
	document.getElementById("homedevonicon").style.display  = "";
	document.getElementById("internetgrayicon1").style.display  = "";
	document.getElementById("internetgrayicon2").style.display  = "";
	document.getElementById("internetgrayicon3").style.display  = "none";
	document.getElementById("interneticon").src= "../../../images/interneton.jpg";
	if (true == var_singtel)
	{
		document.getElementById("routericon").src= "../../../images/routeronnowifi.jpg";
	}
	else
	{
		document.getElementById("routericon").src= "../../../images/routeron.jpg";
	}
	document.getElementById("homedevonicon").src= "../../../images/homedevon.jpg";

	if(false == IsInternetWanOk)
	{
		document.getElementById("erroricon").style.display  = "";
	}
	
	if (('1' == smartlanfeature) || (3 == CurrentUpMode))
	{
		if (true == IsInternetWanOk)
		{
			document.getElementById("wanstatuspic").style.background = "url('../../../images/ok.jpg') no-repeat";
			IsInternetTestOk = true;
		}
		else
		{
			document.getElementById("wanstatuspic").style.background = "url('../../../images/redwarning.jpg') no-repeat";
		}
	}
	
	else
	{
		if ((true == IsOLTRegistered()) && (true == IsOpticalNomal()) && (true == IsInternetWanOk))
		{
			document.getElementById("wanstatuspic").style.background = "url('../../../images/ok.jpg') no-repeat";
			IsInternetTestOk = true;
		}
		else
		{
			document.getElementById("wanstatuspic").style.background = "url('../../../images/redwarning.jpg') no-repeat";
		}
	}

	document.getElementById("pwdframecontent").style.display  = "";
	document.getElementById("netframecontent").style.display  = "";
	document.getElementById("voipframecontent").style.display  = "";
	document.getElementById("hardwareframecontent").style.display  = "";
	document.getElementById("diagnoseresult").style.display  = "";

	setDisplay('userpwdsafe', 1);

	if (parseInt(PwdModifyFlag, 10) != 0)
	{
		if (true == IsWiFiPwdSecurityHigh() || false == isWlanSupport())
		{
			document.getElementById("pwdpic").style.background = "url('../../../images/ok.jpg') no-repeat";
			IsPwdTestOk = true;
		}
		SetPwdLv("pwdsublinepic", 'levelExt', "pwdlevel");
	}

	if ((VoipSupport == 0) || ((logo_singtel == true) && (var_singtel_hg8244hs == false)) ||
		(isPTVDF == 1) || (isPTVDFB == 1))
	{
		document.getElementById("voipframecontent").style.display  = "none";
		IsVoipTestOk = true;
	}
	else
	{
		VoipGatewayStatusInof();
	}
	
	if(true == IsStbportExist())
	{
		
		SetDisplayStbframecontent();
		
		GetStbTestResult();
	}
	else
	{
		IsStbTestOK = true; 
	}


	if(!IsPwdTestOk || !IsVoipTestOk || !IsEquipTestOk || !IsInternetTestOk || !IsStbTestOK)
	{
		if (true == var_singtel)
		{
			getElement('resultTxt').innerHTML = SmartDiagnoseLgeDes['s2018a'];
		}
		else
		{
		getElement('resultTxt').innerHTML = SmartDiagnoseLgeDes['s2018'];
		}
	}
	else
	{
		getElement('resultTxt').innerHTML = SmartDiagnoseLgeDes['s2017'];
	}
}

function Ondiagresult()
{
	if (true == var_Support_Inner_SD)
	{
		GetSdDevTestResult();
	}
	
	GetEquipTestResult();
	WiFiDiagnose();
	setInternetStatus();

	if(CLICK_START_FLAG == EquipTestClickFlag)
	{
		if ("" == EquipShowStr)
		{
			EquipTestClickFlag = CLICK_START_FLAG;
			SetFlag(EQUIPTEST_FLAG,CLICK_START_FLAG);
		}
		else
		{
			EquipTestClickFlag = CLICK_TERMINAL_FLAG;
			SetFlag(EQUIPTEST_FLAG,CLICK_TERMINAL_FLAG);
		}
	}

	if ( 1 == VoipSupport )
	{
		getvoiptestresult();
		if( (TestState.toString().indexOf("Complete") >= 0 ) &&( CLICK_TERMINAL_FLAG == EquipTestClickFlag ))
		{
			clearInterval(TimerHandle);
			setTimeout("DisplayDiagResult()",8000);
		}
	}
	else
	{
		if( ( CLICK_TERMINAL_FLAG == EquipTestClickFlag ))
		{
			clearInterval(TimerHandle);
			setTimeout("DisplayDiagResult()",8000);
		}
	}
}

function HWGetToken()
{
	var tokenstring="";
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "/html/ssmp/common/GetRandToken.asp",
		success : function(data) {
			tokenstring = data;
		}
	});

	return tokenstring;
}

function onbtndiagnose()
{
	setDisable('btndiagnose', 1);
	top.UpgradeFlag = 2;
	TestState = "";
	document.getElementById("divdiagnose").style.display  = "";
	document.getElementById('btndiagnose').value = SmartDiagnoseLgeDes['s2016'];
	document.getElementById("erroricon").style.display  = "none";

	document.getElementById("interneticon").style.display  = "";
	document.getElementById("routericon").style.display  = "";
	document.getElementById("homedevonicon").style.display  = "";
	document.getElementById("pwdframecontent").style.display  = "none";
	document.getElementById("netframecontent").style.display  = "none";
	document.getElementById("voipframecontent").style.display  = "none";
	document.getElementById("hardwareframecontent").style.display  = "none";
	document.getElementById("stbframecontent").style.display  = "none";
	document.getElementById("diagnoseresult").style.display  = "none";

	document.getElementById("internetgrayicon1").style.display  = "none";
	document.getElementById("internetgrayicon2").style.display  = "none";
	document.getElementById("internetgrayicon3").style.display  = "";

	document.getElementById("interneticon").src= "../../../images/interneton.jpg";
	if (true == var_singtel)
	{
		document.getElementById("routericon").src= "../../../images/routeronnowifi.jpg";
	}
	else
	{
	document.getElementById("routericon").src= "../../../images/routeron.jpg";
	}
	document.getElementById("homedevonicon").src= "../../../images/homedevon.jpg";

	DiagnoseToken = HWGetToken();
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : '&x.X_HW_Token='+ DiagnoseToken,
		url : "HWDiagnoseOpt.cgi?&RequestFile=/html/ssmp/maintain/smartdiagnose.asp",
		success : function(data) {
		}
	});

	OnEquipCheck();

	if(1 == VoipSupport)
	{
		setvoipCgi();
	}

	if(true == IsStbportExist())
	{
		GetCurrentStbPacket();
		PreTxMultPackets = UserEthInfos[stbport - 1].SendMcastFrame;
		PreTxUnitPackets = UserEthInfos[stbport - 1].SendUcastFrame;
		
		var StbResultBegin = new Date();
		BeginSendMcastFrameTime  = StbResultBegin.getTime();
	}
	else
	{
		IsStbTestOK = true; 
	}

	TimerHandle = setInterval('Ondiagresult()', 5000);
}

function setvoipCgi()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : getDataWithToken('x.TestState=Requested'),
		url : "SetTestState.cgi?x=InternetGatewayDevice.X_HW_DEBUG.VSPA.TotalTest" + "&RequestFile=/html/ssmp/maintain/smartdiagnose.asp",
		success : function(data) {
		}
	});
}

function getvoiptestresult()
{
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "/html/ssmp/common/GetVoipTestState.asp",
		success : function(data) {
			TestState = data;
		}
	});


	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "/html/ssmp/common/GetVoipTestResult.asp",
		success : function(data) {
			TotalTestResult = dealDataWithFun(data);
		}
	});
}

function VoipGatewayStatusInof()
{
	var inormalNUM = 0;
	var Index =1;
	var iCountPort = 0;
	var iErrorCount = 0;
	var strPort = 0;
	var strLOOP_ABNORMAL =0;
	var errorcode;
	var strConfigurationInfo =0;
	var iCountConfigurationPort =0;
	var Status = "";
	var StatusTmp = "";

	for(Index; Index < TotalTestResult.length; Index++)
	{
		if (TotalTestResult[Index-1].Result == 0)
		{
			inormalNUM++;
			continue;
		}
		else if(2 == TotalTestResult[Index-1].Result)
		{
			iCountConfigurationPort++ ;
			if(iCountConfigurationPort > 1)
			{
				strConfigurationInfo += ',';
				strConfigurationInfo += Index;
			}
			else
			{
				strConfigurationInfo += Index;
			}
			errorcode ="607";
		}
		else if(4 == TotalTestResult[Index-1].Result)
		{
			iCountPort++ ;
			if(iCountPort > 1)
			{
				strPort += ',';
				strPort += Index;
			}
			else
			{
				strPort += Index;
			}

			errorcode ="608";
		}
		else if(5 == TotalTestResult[Index-1].Result)
		{
			iErrorCount++;
			if(iErrorCount > 1)
			{
				strLOOP_ABNORMAL += ',';
				strLOOP_ABNORMAL += Index;
			}
			else
			{
				strLOOP_ABNORMAL += Index;
			}

			errorcode ="699";
		}
		else
		{
			errorcode ="600";
		}

	}

	if( inormalNUM == TotalTestResult.length -1 )
	{
		getElement('voicestatus').innerHTML = SmartDiagnoseLgeDes['s3001'];
		document.getElementById("voippic").style.background = "url('../../../images/ok.jpg') no-repeat";
		SetDotLine("voipsublinepic", true);
		IsVoipTestOk = true;
	}
	else
	{
		document.getElementById("voippic").style.background = "url('../../../images/redwarning.jpg') no-repeat";
		SetDotLine("voipsublinepic", false);

		for(Index=1; Index < TotalTestResult.length; Index++)
		{
			if(0 == TotalTestResult[Index-1].Result)
			{
				StatusTmp = SmartDiagnoseLgeDes['s3001'];
			}
			else if(1 == TotalTestResult[Index-1].Result)
			{
				StatusTmp = SmartDiagnoseLgeDes['s3003'];
			}
			else if(2 == TotalTestResult[Index-1].Result)
			{
				StatusTmp = SmartDiagnoseLgeDes['s3004'];
			}
			else if(3 == TotalTestResult[Index-1].Result)
			{
				StatusTmp = SmartDiagnoseLgeDes['s3005'];
			}
			else if(4 == TotalTestResult[Index-1].Result)
			{
				StatusTmp = SmartDiagnoseLgeDes['s3006'];
			}
			else if(5 == TotalTestResult[Index-1].Result)
			{
				if (true == var_singtel)
				{
					StatusTmp = SmartDiagnoseLgeDes['s3007a'];
				}
				else
				{
				StatusTmp = SmartDiagnoseLgeDes['s3007'];
				}
			}
			else if(6 == TotalTestResult[Index-1].Result)
			{
				if (true == var_singtel)
				{
					StatusTmp = SmartDiagnoseLgeDes['s3008a'];
				}
				else
				{
				StatusTmp = SmartDiagnoseLgeDes['s3008'];
				}
			}
			else if(8 == TotalTestResult[Index-1].Result)
			{
				StatusTmp = SmartDiagnoseLgeDes['s3010'];
			}
			else
			{
				StatusTmp = SmartDiagnoseLgeDes['s3009'];
			}

			Status = Status + SmartDiagnoseLgeDes['s3002'] + Index +  ":" + StatusTmp + "<br>";
		}

		Status = htmlencode(Status);
        getElement('voicestatus').innerHTML = Status.replace(new RegExp(/(&lt;br&gt;)/g),"<br>");
	}
}

function isWlanSupport()
{
	var flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
	return flag == 1;
}

function SetPwdWifiLv(dotId, spanId, linkId, strenth)
{
    SetDotLine(dotId, true);
    document.getElementById(spanId).innerHTML = (strenth == "high") ? SmartDiagnoseLgeDes['s2023'] : SmartDiagnoseLgeDes['s2023_med'];
    document.getElementById(linkId).removeAttribute("href");
    document.getElementById(linkId).onclick = function(){};
    $("#"+linkId).removeClass("redlink");
    $("#"+linkId).addClass("greenlink");
}

function WiFiDiagnoseResult()
{
	if(null == wifiResult)
		reutrn ;

    if (isWlanSupport()) {
        setDisplay('wifisublinepic', 1);
        setDisplay('wifiSafe', 1);

        passwordStrength2g = wifiResult.PWD_2G_Security;
        passwordStrength5g = wifiResult.PWD_5G_Security;
        if (wifiResult.wifiPwdSecurity != 'low') {
            SetPwdWifiLv('wifisublinepic', 'wifipwdsafe_level', 'a_wifipwdsafe', wifiResult.wifiPwdSecurity);
        }
    } else {
        setDisplay('wifisublinepic', 0);
        setDisplay('wifiSafe', 0);
    }

	if ('1' != smartlanfeature)
	{

		if(3 != CurrentUpMode)
		{
			var opticOk = wifiResult.opticInfo == "ok";
			if (true == var_singtel)
			{
				$('#span_optic').html(opticOk ? SmartDiagnoseLgeDes['s2025'] : SmartDiagnoseLgeDes['s2026a']);
			}
			else
			{
					$('#span_optic').html(opticOk ? SmartDiagnoseLgeDes['s2025'] : SmartDiagnoseLgeDes['s2026']);
			}
			SetDotLine('ampsublinepic', opticOk);

			var oltOk = wifiResult.regStatus == "ok";
				$('#ampolt').html(oltOk ? SmartDiagnoseLgeDes['s2027'] : SmartDiagnoseLgeDes['s2028']);
			SetDotLine('ampoltstatusublinepic', oltOk);
			if ('1' == IsBin5)
			{
				setDisplay("wanstatusublinepic", 0);	
				setDisplay("div_wanstat", 0);	
			}
			
		}
		else
		{
			setDisplay("ampoltstatusublinepic", 0);
			setDisplay("wanstatusublinepic", 0);	
			setDisplay("div_wanstat", 0);	
			setDisplay("div_ampolt", 0);	
		}
	}
	else
	{
		setDisplay("ampoltstatusublinepic", 0);
		setDisplay("wanstatusublinepic", 0);	
		setDisplay("div_wanstat", 0);	
		setDisplay("div_ampolt", 0);			
	}
}

function WiFiDiagnose()
{
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "/html/amp/common/getSmartDiagnoseResult.asp",
		success : function(data) {
			wifiResult = dealDataWithFun(data);
			WiFiDiagnoseResult();
		},
		complete: function (XHR, TS) {
			XHR = null;
		}
	});
}

function loadframe()
{
	top.UpgradeFlag = 0;
	document.getElementById("diagnoseframebg").style.display  = "none";
	document.getElementById("divdiagnose").style.display  = "";
	document.getElementById("interneticon").style.display  = "";
	document.getElementById("routericon").style.display  = "";
	document.getElementById("homedevonicon").style.display  = "";
	document.getElementById("internetgrayicon1").style.display  = "";
	document.getElementById("internetgrayicon2").style.display  = "";
	document.getElementById("ampoltstatusublinepic").style.display  = "";
	document.getElementById("wanstatusublinepic").style.display  = "";	
	document.getElementById("div_wanstat").style.display  = "";	 
	document.getElementById("div_ampolt").style.display  = "";	
	document.getElementById('btndiagnose').value = SmartDiagnoseLgeDes['s2015'];
	
	if ( 'ZAIN' == CfgMode.toUpperCase())
	{
		document.getElementById("resultTxt").style.color  = "#e0218a";
	}
	if (false == var_Support_Inner_SD)
	{
		document.getElementById('onthardwaresd').style.display = "none";
		document.getElementById('hwsublinesd').style.display = "none";
		document.getElementById('hwsublinesd').style.backgroundColor = "#F0F0F2";
		document.getElementById('hwsublinesdpic').style.display = "none";
		document.getElementById('hwsublinesdpic').style.backgroundImage = "none";
	}
}


function GetHpa(MainName,type)
{
	var menuItems = top.Frame.menuItems;	
	for(var i in menuItems)
	{		
		if(MainName == menuItems[i].name)
		{
			if("JumpIndex"==type)
			{
				return menuItems.length - i;
			}
			else
			{
				return i;
			}
			
		}
	}
	
	return -1;
}

function GetZpa(MainName, SubItemName)
{	

	var Hpa = GetHpa(MainName,"FindChild");
	if(Hpa == -1)
	{
		return -1;
	}
	
	var subItems = top.Frame.menuItems[Hpa].subMenus;
	for(var i in subItems)
	{
		if(SubItemName == subItems[i].name)
		{	
			return i;
		}
	}
	
	return -1;
}

function GetUrl(MainName, SubItemName)
{
	var Hpa = GetHpa(MainName,"FindChild");
	if(Hpa == -1)
	{
		return null;
	}
	
	var subItems = top.Frame.menuItems[Hpa].subMenus;
	for(var i in subItems)
	{
		if(SubItemName == subItems[i].name)
		{	
			return subItems[i].url;
		}
	}
	
	return null;
}

function CommonPwdJumpMode()
{
	var MainName = SmartDiagnoseLgeDes['s2029pwd'];
	var SubItemName = SmartDiagnoseLgeDes['s2029pwdc'];

	var hpa = GetHpa(MainName, "JumpIndex");
	var zpa = GetZpa(MainName, SubItemName);
	var jumpurl = GetUrl(MainName, SubItemName);
	if(hpa != -1 && zpa != -1 && null != jumpurl)
	{
		top.Frame.showjump(hpa, zpa);
	}
	
	if(jumpurl.substring(0,1) == "/")
	{	
		window.location='../../..' + jumpurl;
	}
	else
	{
		window.location='../../../' + jumpurl;
	}	
}

function CommonWifiJumpMode()
{
	var MainName = SmartDiagnoseLgeDes['s2029wifi'];
	var SubItemName = SmartDiagnoseLgeDes['s2029wific'];
	if (isDoubleWLAN == 1) {
		if ((passwordStrength2g != "low") && (passwordStrength5g == "low")) {
			SubItemName = SmartDiagnoseLgeDes['s2029wifidou5g'];
		} else {
			SubItemName = SmartDiagnoseLgeDes['s2029wifidou'];
		}
	}
	var hpa = GetHpa(MainName, "JumpIndex");
	var zpa = GetZpa(MainName, SubItemName);
	var jumpurl = GetUrl(MainName, SubItemName);
	if(hpa != -1 && zpa != -1 && null != jumpurl)
	{
		top.Frame.showjump(hpa, zpa);
	}
	
	if(jumpurl.substring(0,1) == "/")
	{	
		window.location='../../..' + jumpurl;
	}
	else
	{
		window.location='../../../' + jumpurl;
	}	
}

function onpwdchange()
{
	if (curUserType == 0) {
		alert(SmartDiagnoseLgeDes['s2040']);
		return;
	}
	if((parseInt(PwdModifyFlag,10) != 0))
	{
		return;
	}
	
	if(2 == JumpMode || 1 == JumpMode)
	{
		 top.Frame.changeMenuShow('Menu1_Managemen','Menu2_Mng_User','Menu3_MU_User');
	}
	else if(4 == JumpMode || 5 == JumpMode)
	{
		CommonPwdJumpMode();
	}
	else if(6 == JumpMode)
	{
		window.parent.onMenuChange("userconfig");
	}
}

function wifipwdchange() {
    if ((JumpMode == 2) || (JumpMode == 1)) {
        if (isDoubleWLAN == 1) {
            if ((passwordStrength2g != "low") && (passwordStrength5g == "low")) {
                top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_WLAN','Menu3_NW_Basic_5G');
            } else {
                top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_WLAN','Menu3_NW_Basic_2G');
            }
        } else {
            top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_WLAN','Menu3_NW_Basic');
        }
    } else if ((JumpMode == 4) || (JumpMode == 5)) {
        CommonWifiJumpMode();
    } else if (JumpMode == 6) {
        if (isDoubleWLAN == 1) {
            if ((passwordStrength2g != "low") && (passwordStrength5g == "low")) {
                window.parent.onMenuChange("wlan5basic");
            } else {
                window.parent.onMenuChange("wlan2basic");
            }
        } else {
                window.parent.onMenuChange("wlanconfig");
        }
    }
}

if (ApModeValue > 0)
{	
	if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
	{
		var arr = ['s2008_xd','s2008lan','s2009_xd','s2009lan','s2014a','s2014lan'];
	}
	else
	{
		var arr = ['s2008','s2008lan','s2009','s2009lan','s2014a','s2014lan'];
	}  
	var aparr = ['s1900','s2010','s2013'];
	for (var i = 0; i < arr.length; i++) 
	{
		SmartDiagnoseLgeDes[arr[i]] = SmartDiagnoseLgeDes[arr[i] + "ap"];
	}
	if (ApModeValue == 2 || ApModeValue == 3 || apghnfeature == 1)
	{
		for (var j = 0; j < aparr.length; j++) 
		{
			SmartDiagnoseLgeDes[aparr[j]] = SmartDiagnoseLgeDes[aparr[j] + "ap"];
		}
	}		
}
</script>
</head>
<body onload="loadframe();">
	<div id="diagnose">
		<div class="diagnosePageTitle"><span id="diagnoseTitleText" BindText="s2029"></span></div>
		<div class="iconarea">
			<img id="interneticon"  style="display:none;" class="icon0" src="../../../images/internetoff.jpg">
			<img id="routericon"    style="display:none;" class="icon1" src="../../../images/routeroff.jpg">
			<script type="text/javascript">
				if (true == var_singtel)
				{
					document.getElementById("routericon").src= "../../../images/routeroffnowifi.jpg";
				}
				else
				{
					document.getElementById("routericon").src= "../../../images/routeroff.jpg";
				}
			</script>
			<img id="homedevonicon" style="display:none;" class="icon1" src="../../../images/homedevoff.jpg">
		</div>
		<div class="pointlink">
			<img id="internetgrayicon1" class="point0" style="display:none;" src="../../../images/graylink.jpg">
			<img id="internetgrayicon2" class="point1" style="display:none;" src="../../../images/graylink.jpg">
		</div>
		<div class="pointlink">
			<img id="internetgrayicon3" style="display:none;" src="../../../images/actionpress.gif">
		</div>
		<div class="pointlink linkfault">
			<img id="erroricon" style="display:none;" src="../../../images/error.jpg">
		</div>

		<div class="divdiagnose" id="divdiagnose" style="display:none;">
			<input type="button" id="btndiagnose" class="ApplyButtoncss buttonwidth_120px_200px" onClick="onbtndiagnose();" value="">
		</div>
	</div>

	<div id="diagnoseresult" style="display:none;">
		<div style="margin-left:63px;border:1px dashed #BBBBBB;width:620px;height:80px;">
			<div style="margin-top:25px;text-align:center;font-weight:bold;font-size:21px;border:none;color:#808080;">
				<span id="resultTxt"></span>
			</div>
		</div>
	</div>

	<div id="diagnoseframebg">
		<div id="pwdframecontent" class="diagnosearea" style="margin-left:28px;display:none;">
			<div class="diagnosecontentbg"><img id="pwdsafepic" src="../../../images/pwdsafebg.jpg"></div>
			<div class="warningbg" id="pwdpic"></div>
			<div class="diagnosetitle"><span id="pwdsafe" BindText="s2020"></span></div>
			<div class="sublinebg" id="pwdsublinepic">
				<div class="subline" id="pwdsubline"></div>
			</div>
			<div class="sublinebg" id="wifisublinepic" style="margin-top:85px;display:none;">
				<div class="subline" id="wifisubline"></div>
			</div>
			<div class="diagnosecontent" id="userpwdsafe" style="display:none;">
				<span id="ontpwdsafe" BindText="s2021"></span>
				<a class="redlink" id="pwdlevel" href="#" onClick="onpwdchange();">
					<span id="levelExt" BindText="s2022"></span>
				</a>
			</div>
			<div class="diagnosecontent" id="wifiSafe" style="margin-top:105px;display:none;">
				<span id="wifipwdsafe" BindText="s2024"></span>
				<a class="redlink" id="a_wifipwdsafe" href="#" onClick="wifipwdchange();">
					<span id="wifipwdsafe_level" BindText="s2022"></span>
				</a>
				<span id="wifipwdsafe_low_notice" style="margin-left:5px; color:#808080; font-size:12px; font-weight: normal; display:none;"></span>
			</div>
		</div>

		<div id="netframecontent" class="diagnosearea" style="margin-left:388px;display:none;">
			<div class="diagnosecontentbg"><img id="" src="../../../images/netstusbg.jpg"></div>
			<div class="warningbg" id="wanstatuspic"></div>
			<div class="diagnosetitle"><span id="wanstatus" style="width: 260px;display: block;" BindText="s2013"></span></div>
			<div class="sublinebg" id="ampsublinepic">
				<div class="subline" id="ampsubline"></div>
			</div>
			<div class="sublinebg" id="ampoltstatusublinepic" style="margin-top:85px;display:none;">
				<div class="subline" id="ampoltstatusubline"></div>
			</div>
			<div class="sublinebg" id="wanstatusublinepic" style="margin-top:120px;display:none;">
				<div class="subline" id="wanstatusubline"></div>
			</div>
			<div class="diagnosecontent" id="opticOn" style="margin-top:70px;">
				<span id="span_optic"></span>
			</div>
			<div class="diagnosecontent" id="div_ampolt" style="margin-top:105px;display:none;">
				<span id="ampolt"></span>
			</div>
			<div class="diagnosecontent" id="div_wanstat" style="margin-top:140px;display:none;">
				<span id="ontwanstatus"></span>
			</div>
		</div>

		<div id="hardwareframecontent" class="diagnosearea" style="margin-top:195px;margin-left:28px;display:none;">
			<div class="diagnosecontentbg"><img id="imghw" src="../../../images/hardwarebg.jpg"></div>
			<script type="text/javascript">
				if (true == var_singtel)
				{
					document.getElementById("imghw").src= "../../../images/hardwarebgnowifi.jpg";
				}
				else
				{
					document.getElementById("imghw").src= "../../../images/hardwarebg.jpg";
				}
			</script>
			<div class="warningbg" id="hwpic"></div>
			<div class="diagnosetitle">
				<span id="hardware">
					<script>
					if (true == logo_singtel)
					{
						document.write(SmartDiagnoseLgeDes['s2014a']);
					}
					else
					{	
						if(smartlanfeature == 1){
							document.write(SmartDiagnoseLgeDes['s2014lan']);
						}
						else{
							document.write(SmartDiagnoseLgeDes['s2014']);
						}
						
					}
					</script>
				</span>
			</div>
			<div class="sublinebg" id="hwsublinepic">
				<div class="subline" id="hwsubline"></div>
			</div>
			<div class="diagnosecontent"><span id="onthardware"></span></div>
			
			<div class="sublinebg" id="hwsublinesdpic" style="padding-top:35px;">
				<div class="subline" id="hwsublinesd"></div>
			</div>
			<div class="diagnosecontent" style="padding-top: 35px;"><span id="onthardwaresd"></span></div>			
		</div>

		<div id="voipframecontent" class="diagnosearea" style="margin-top:195px;margin-left:388px;display:none;">
			<div class="diagnosecontentbg"><img id="pwdsafepic" src="../../../images/voipstusbg.jpg"></div>
			<div class="warningbg" id="voippic"></div>
			<div class="diagnosetitle"><span><script>document.write(SmartDiagnoseLgeDes['s3000']);</script></span></div>
			<div class="sublinebg" id="voipsublinepic">
				<div class="subline" id="voipsubline"></div>
			</div>
			<div class="diagnosecontent"><span id="voicestatus"></span></div>
		</div>
		
		<div id="stbframecontent" class="diagnosearea" style="margin-top:390px;margin-left:28px;display:none;">
			<div class="diagnosecontentbg"><img id="" src="../../../images/stbstusbg.png"></div>
			<div class="warningbg" id="stbpic"></div>
			<div class="diagnosetitle"><span><script>document.write(SmartDiagnoseLgeDes['s3014']);</script></span></div>			
			<div class="sublinebg" id="stbinnersublinepic">
				<div class="subline" id="stbinnersubline"></div>
			</div>
			<div class="sublinebg" id="WANConfigsublinepic" style="margin-top:85px;display:none;">
				<div class="subline" id="WANConfigsubline"></div>
			</div>
			<div class="sublinebg" id="IPTVWANsublinepic" style="margin-top:120px;display:none;">
				<div class="subline" id="IPTVWANsubline"></div>
			</div>			
			<div class="diagnosecontent"><span id="stbinnerstatus"></span></div>
			<div class="diagnosecontent" style="margin-top: 105px;"><span id="IPTVWAnstatus"></span></div>
			<div class="diagnosecontent" style="margin-top: 140px;"><span id="stbstatus"></span></div>
		</div>
	</div>

	<script type="text/javascript">
		ParseBindTextByTagName(SmartDiagnoseLgeDes, "span",  1);
		ParseBindTextByTagName(SmartDiagnoseLgeDes, "input", 2);
	</script>
</body>
</html>
