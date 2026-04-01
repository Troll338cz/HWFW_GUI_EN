<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />       
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title></title>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>      
<style type="text/css">
input.Diagnose_btn_style {
    border-radius: 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.6);
    font-size: 16px;
    font-weight: bold;
    padding: 0 20px;
    height: 34px;
    line-height: 34px;
	margin-right: 10px;
	background-color: #f5f5f5;
    border: 1px solid #e6e4e4;
    cursor: pointer;
}
div.diagnose_row{
    display: table-row;
    line-height: 24px;
    width: 100%;
}
.diagnose_align{
    display: table-cell;
    padding-top: 20px;
    padding-bottom: 20px;
}
.diagnose_inputAlign{
    display: table-cell;
    text-align: right;
    padding-top: 20px;
    padding-bottom: 20px;	
}
.diagnose_align span{
	padding-left:40px;
	display: block;
}
.h3-content {
    margin-left: 40px;
    width: 94.8%;
    display: table;
}
input[type="text"], input[type="password"] {
    border-radius: 4px;
    box-shadow: 0 1px 2px 1px #767676 inset;
    color: #767676;
    font-size: 16px;
    line-height: 24px;
    padding: 7px 14px;
    box-sizing: border-box;
    background-color: #f5f5f5;
    border: 1px solid #e6e4e4;
    cursor: pointer;	
}
.diagnose_result {
    border: 1px solid #f4f4f4;
}
.popup.tL.diagnose-InProgressPopUp {
    width: 90%;
    margin: auto;
    height: auto;
    overflow: hidden;
}
.popup.tL.diagnose-InProgressPopUp {
    width: 90%;
    margin: auto;
    height: 80px;
    margin-top: 85px;
}
.diagnose_result_progress {
    float: left;
    margin-top: 30px;
	margin-left: 140px;
}

.closeBtn {
    float: right;
    margin: 12px;
	cursor: pointer;
}
#diagnose {
width:100%;
height:271px;
margin:0px auto;
background-color:#fff;
}

.iconarea{
width:94%;
height:112px;
margin-top:60px;
text-align:center;
position:absolute;
}

.diagnosePageTitle{
width:80%;
padding: 15px 0px 10px 0px;
font-size:14px;
font-family:"微软雅黑";
color: #ECA417;
margin-left:50px;
position:absolute;
}
.icon0{
/*width:112px;
height:112px;
margin-left:168px;
position:absolute;
display:none;*/
}
.icon1{
margin-left:112px;
}

.pointlink{
width:94%;
margin-top:100px;
text-align:center;
position:absolute;
}

.linkfault{
text-align:left;
padding-left:204px;
}

.point0{
/*width:100%;
height:8px;
margin-top:52px;
text-align:center;
position:absolute;*/
}
.point1{
    margin-left:92px;
}

#internetgrayicon3{
    margin-top:5px;
}

.divdiagnose{
	width:100%;
	margin-top:190px;
	font-size:14px;
	text-align:center;
	position:absolute;
}

#diagnoseresult {
	width:100%;
	height:120px;
	font-family:"微软雅黑";
	margin:0px auto;
	background-color:#fff;
}

#diagnoseresult .warningtxtbg{
	height:20px;
	text-align:center;
	position:absolute;
}

#diagnoseframebg {
	width:100%;
	height:400px;
	padding-top:25px;
	font-family:"微软雅黑";
	background-color:#fff;
}

#diagnoseframebg .diagnosearea{
	width:322px;
	height:180px;
	background-color:#f0f0f2;
	position:absolute;
}

#diagnoseframebg .warningbg{
	float:left;
	margin:30px;
	margin-top:24px;
	padding:0px;
	width:26px;
	height:26px;
	background:url(../../../images/redwarning.jpg) no-repeat;
	position:absolute;
}
#diagnoseframebg .sublinebg{
	float:left;
	margin:38px;
	margin-top:50px;
	padding:0px;
	width:11px;
	height:35px;
	background:url(../../../images/reddotline.jpg) no-repeat bottom;
	position:absolute;
}

#diagnoseframebg .sublinebg .subline{
	float:top;
	margin:0px 5px;
	padding:0px;
	width:1px;
	height:25px;
	background-color:#F16262;
}

#diagnoseframebg .diagnosetitle{
	float:left;
	margin-left:70px;
	margin-top:26px;
	font-size:16px;
	font-weight:bolder;
	color:#808080;
	position:absolute;
}

#diagnoseframebg .diagnosecontent{
	float:left;
	width:240px;
	margin-left:70px;
	margin-top:70px;
	font-size:12px;
	line-height: 15px;
	/*font-weight:bolder;*/
	color:#808080;
	position:absolute;
}
.diagnosecontent span {
    width: 240px;
    display: block;
}
#diagnoseframebg .diagnosecontentbg{
	width:120px;
	height:116px;
	margin-top:50px;
	margin-left:200px;
	position:absolute;
}
div#divdiagnose input {
    border-radius: 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.6);
    font-size: 16px;
    font-weight: bold;
    padding: 0 20px;
    height: 34px;
    line-height: 34px;
    background-color: #f5f5f5;
    border: 1px solid #e6e4e4;
    cursor: pointer;
    margin-right: 10px;
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
var DiagnoseToken='';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var var_singtel_hg8244hs = '<%HW_WEB_GetFeatureSupport(VOICE_FT_WEB_SINGTEL_HG8244HS);%>';
var ShowISPSsidFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_CU);%>';
var JumpMode = 6;
//JumpMode = 1 移动
//JumpMode = 2 电信
//JumpMode = 3 联通
//JumpMode = 4 中国区通用
//JumpMode = 5 海外通用
//JumpMode = 6 10G PON
var var_Support_Inner_SD = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_INNER_SDCARD);%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';

var STBPORT_NOT_EXIST = 0;
var STBPORTUP = 1;
var IS_WAN_ENABLE = 1;

var PreTxMultPackets = 0;

var BeginSendMcastFrameTime = 0;

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


var TestState = "<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.VSPA.TotalTest.TestState);%>";
var UserEthInfos = new Array();

var TimerHandle ="";

var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, ModifyPasswordFlag, stModifyUserInfo);%>;
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var bztlf = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_BZTLF);%>';

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
		async : true,
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
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0))
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
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0))
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
				|| (WanList[i].ServiceList.toString().toUpperCase().indexOf("OTHER") >=0)))
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
	if(Math.abs(UserEthInfos[stbport - 1].SendMcastFrame - PreTxMultPackets) < (StbResultEnd.getTime() - BeginSendMcastFrameTime)/1000 * 100)
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
		document.getElementById('onthardwaresd').display = "none";
		document.getElementById('hwsublinesd').display = "none";
		document.getElementById('hwsublinesd').style.backgroundColor = "#F0F0F2";
		document.getElementById('hwsublinesdpic').display = "none";
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
				result += resulttemp;
				}
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
			elseif((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
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
			else if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
			{
				ShowStr = SmartDiagnoseLgeDes['s2009_xd'];
			}
			else
			{
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

	var ConfigUrl = "complexajax.cgi?x=InternetGatewayDevice.X_HW_DEBUG.BBSP.ExtendPortTransCheck&RUNSTATE_FLAG=" + EQUIPTEST_FLAG + '&RequestFile=/html/ssmp/maintain/diagnoseUtility.asp';
	HWSetAction("ajax", ConfigUrl, Parameter, DiagnoseToken);
}

function setInternetStatus()
{
	var internetstatus = '';
	var AllWanInfo = '';
	$.ajax({
		type : "POST",
		async : true,
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

function IsExitIPAddress(wan, ipv6wanlist, ipv6addlist)
{
	var existAddr = false;
	var ipv6Wan = GetIPv6WanInfo(wan.MacId, ipv6wanlist);

	if (('IPv4' == wan.ProtocolType) && ("CONNECTED" == wan.Status.toUpperCase()) && ('' != wan.IPv4IPAddress))
	{
		existAddr = true;
	}
	if (('IPv6' == wan.ProtocolType) && ("CONNECTED" == ipv6Wan.ConnectionStatus.toUpperCase()) && ('' != GetIPv6Address(wan, ipv6addlist)))
	{
		existAddr = true;
	}
	if (('IPv4/IPv6' == wan.ProtocolType)
		&&(("CONNECTED" == wan.Status.toUpperCase() && '' != wan.IPv4IPAddress) || ("CONNECTED" == ipv6Wan.ConnectionStatus.toUpperCase() && '' != GetIPv6Address(wan, ipv6addlist))))
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
			return statusEnum["DHCPInternetWanFail"];
		}
	}
}

function GetInternetWanstate(wanlist, ipv6wanlist, ipv6addlist)
{
	var InternetDiagStatus = "";
	if(1 != smartlanfeature)
	{
		var IsOpticalOk = IsOpticalNomal();
		var IsOLTRegOk = IsOLTRegistered();
		if ((false == IsOpticalOk) || (false == IsOLTRegOk))
		{
			return statusEnum["OpticalFail"];
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
	var ValueDivId = ('1' == smartlanfeature) ? "span_optic" : "ontwanstatus";
	var LineDivId = ('1' == smartlanfeature) ? "ampsublinepic" : "wanstatusublinepic";
	
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
		case statusEnum["OtherReason"]:
			SetDotLine(LineDivId, true);
			document.getElementById(ValueDivId).innerHTML = "--";
			IsInternetWanOk = true;
			break;

		case statusEnum["InternetWanSuccess"]:
			SetDotLine(LineDivId, true);
			document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2010'];
			IsInternetWanOk = true;
			break;

		case statusEnum["PPPoEInternetWanFail"]:
			SetDotLine(LineDivId, false);
			document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2011'];
			IsInternetWanOk = false;
			break;

		case statusEnum["DHCPInternetWanFail"]:
			SetDotLine(LineDivId, false);
			document.getElementById(ValueDivId).innerHTML = SmartDiagnoseLgeDes['s2012'];
			IsInternetWanOk = false;
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
		document.getElementById("stbframecontent").style.marginTop = "210px";
		document.getElementById("stbframecontent").style.marginLeft = "372px";
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
	document.getElementById("diagnosecontent_btn").style.display  = "block";
	document.getElementById("divdiagnose").style.display  = "";
	document.getElementById('diagnoseTitleText').innerText = SmartDiagnoseLgeDes['s4007'];
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
	
	if (('1' == smartlanfeature))
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

	if ((0 == VoipSupport) || ((true == logo_singtel) && (false == var_singtel_hg8244hs)))
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
		url : "../common/GetRandToken.asp",
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
	document.getElementById("diagnoseframebg").style.display  = "none";
	document.getElementById("diagnosecontent_btn").style.display  = "none";
	document.getElementById('diagnoseTitleText').innerText = SmartDiagnoseLgeDes['s4006'];
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
		url : "HWDiagnoseOpt.cgi?&RequestFile=html/ssmp/maintain/diagnoseUtility.asp",
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
		url : "SetTestState.cgi?x=InternetGatewayDevice.X_HW_DEBUG.VSPA.TotalTest" + "&RequestFile=html/ssmp/maintain/diagnoseUtility.asp",
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
		url : "../common/GetVoipTestState.asp",
		success : function(data) {
			TestState = data;
		}
	});


	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "../common/GetVoipTestResult.asp",
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

function WiFiDiagnoseResult()
{
	if(null == wifiResult)
		reutrn ;

	if(isWlanSupport())
	{
		setDisplay('wifisublinepic', 1);
		setDisplay('wifiSafe', 1);

		var wifiPwdHigh = wifiResult.wifiPwdSecurity=='high';
		if(wifiPwdHigh)
		{
			SetPwdLv('wifisublinepic', 'wifipwdsafe_level', 'a_wifipwdsafe');
		}
	}
	else
	{
		setDisplay('wifisublinepic', 0);
		setDisplay('wifiSafe', 0);
	}
	
	if ('1' != smartlanfeature)
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
	
	if (false == var_Support_Inner_SD)
	{
		document.getElementById('onthardwaresd').display = "none";
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
		window.parent.onMenuChange("StatusSupportId", "PasswordID");
	}
}

function wifipwdchange()
{	
	if(2 == JumpMode || 1 == JumpMode)
	{
		 top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_WLAN','Menu3_NW_Basic');
	}
	else if(4 == JumpMode || 5 == JumpMode)
	{
		CommonWifiJumpMode();
	}
	else if(6 == JumpMode)
	{
		window.parent.onMenuChange("StatusSupportId", "GeneralID");
	}
	
}
</script>

</head>
<body onload="loadframe();">
	<h1 BindText="s4000"></h1>
	<div id="content" class="content-diagnostic-utility">
		<h2>
			<span style="padding-left:0;"  BindText="s4001"></span>
		</h2>
		<h3>
			<span style="padding-left:0;"  BindText="s4002"></span>
		</h3>
		<div class="">
			<div class="diagnose_row">
				<div class="diagnose_align">
					<span  BindText="s4003"></span>      
				</div>
			</div>
		</div>
		<div class="h3-content no-padding-bottom">
			<div class="diagnose_row">
				<div class="diagnose_inputAlign" id="diagnose_inputAlign">
				   <input class="Diagnose_btn_style" id="Diagnose_click" BindText="s4005" type="button">
				</div>
			</div>
			<div class="diagnose_result" style="display:none;">			
				<!-- Diagnose PopUps -->				
				<div class="popup tL diagnose-InProgressPopUp" style="display:none;">
					<div class="diagnose_result_progress">
						<div id="progress-bar-thinking-box">
							<img src="../../../images/icon-thinking.gif" alt="Loading..."> 
						</div>
					</div>
					<p class="title" style="line-height:82px;float: left; margin-left: 10px;">
						<span class="language-string" name="PAGE_DIAGNOSTIC_UTILITY_POPUP_DIAGNOSIS_PROGRESS" BindText="s4004"></span>  
					</p>
				</div>
				
				<!-- Diagnose PopUps  other -->				
				<div id="diagnose" style="display:block;">
					<div class="diagnosePageTitle" style="padding:25px 0 10px 0;">
						<span id="diagnoseTitleText" style="color: #e60000; font-size: 20px; padding-left: 20px;" BindText="s4004"></span>
					</div>
					<div class="iconarea">
						<img id="interneticon" class="icon0" src="../../../images/internetoff.jpg">
						<img id="routericon" class="icon1" src="../../../images/routeroff.jpg">
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
						<img id="homedevonicon" class="icon1" src="../../../images/homedevoff.jpg">
					</div>
					<div class="pointlink">
						<img id="internetgrayicon1" class="point0" src="../../../images/graylink.jpg">
						<img id="internetgrayicon2" class="point1" src="../../../images/graylink.jpg">
					</div>
					<div class="pointlink">
						<img id="internetgrayicon3" style="display:none;" src="../../../images/actionpress.gif">
					</div>
					<div class="pointlink linkfault">
						<img id="erroricon" style="display:none;" src="../../../images/error.jpg">
					</div>

					<div class="divdiagnose" id="divdiagnose">
						<input type="button" id="btndiagnose" class="buttonwidth_120px_200px" onclick="onbtndiagnose();" value="One-Click Diagnosis">
					</div>
					<div class="closeBtn" onClick="closeButton();">
						<img id="" class="" width="16" height="16" src="../../../images/missedcall.png">
					</div>
				</div>
				
				<div id="diagnoseresult" style="display:none;">
					<div style="margin-left:24px;border:1px dashed #BBBBBB;width:670px;height:80px;">
						<div style="margin-top:25px;text-align:center;font-weight:bold;font-size:21px;border:none;color:#808080; margin: 25px auto; width: 600px; ">
							<span id="resultTxt"></span>
						</div>
					</div>
				</div>				
				
				<div id="diagnoseframebg" style="padding-top:0px; overflow:hidden; display:none;">
					<div id="pwdframecontent" class="diagnosearea" style="margin-left:25px; margin-top:15px; display:none;">
						<div class="diagnosecontentbg">
							<img id="pwdsafepic" src="../../../images/pwdsafebg.jpg">
						</div>
						<div class="warningbg" id="pwdpic"></div>
						<div class="diagnosetitle">
							<span id="pwdsafe" BindText="s2020"></span>
						</div>
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

					<div id="netframecontent" class="diagnosearea" style="margin-left:372px; margin-top:15px; display:none;">
						<div class="diagnosecontentbg">
							<img id="" src="../../../images/netstusbg.jpg">
						</div>
						<div class="warningbg" id="wanstatuspic"></div>
						<div class="diagnosetitle">
							<span id="wanstatus" BindText="s2013"></span>
						</div>
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

					<div id="hardwareframecontent" class="diagnosearea" style="margin-top:210px;margin-left:25px;display:none;">
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
									else if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
									{
										document.write(SmartDiagnoseLgeDes['s2014_dsl']);
									}
									else
									{
										document.write(SmartDiagnoseLgeDes['s2014']);
									}							
								}
								</script>
							</span>
						</div>
						<div class="sublinebg" id="hwsublinepic">
							<div class="subline" id="hwsubline"></div>
						</div>
						<div class="diagnosecontent">
							<span id="onthardware"></span>
						</div>
						
						<div class="diagnosecontent" style="padding-top: 35px;">
							<span id="onthardwaresd"></span>
						</div>			
					</div>

					<div id="voipframecontent" class="diagnosearea" style="margin-top:210px;margin-left:372px;display:none;">
						<div class="diagnosecontentbg">
							<img id="pwdsafepic" src="../../../images/voipstusbg.jpg">
						</div>
						<div class="warningbg" id="voippic"></div>
						<div class="diagnosetitle">
							<span>
							<script>document.write(SmartDiagnoseLgeDes['s3000']);</script>
							</span>
						</div>
						<div class="sublinebg" id="voipsublinepic">
							<div class="subline" id="voipsubline"></div>
						</div>
						<div class="diagnosecontent">
							<span id="voicestatus"></span>
						</div>
					</div>
					
					<div id="stbframecontent" class="diagnosearea" style="margin-top:405px;margin-left:25px;display:none;">
						<div class="diagnosecontentbg">
							<img id="" src="../../../images/stbstusbg.png">
						</div>
						<div class="warningbg" id="stbpic"></div>
						<div class="diagnosetitle">
							<span>
								<script>document.write(SmartDiagnoseLgeDes['s3014']);</script>
							</span>
						</div>			
						<div class="sublinebg" id="stbinnersublinepic">
							<div class="subline" id="stbinnersubline"></div>
						</div>
						<div class="sublinebg" id="WANConfigsublinepic" style="margin-top:85px;display:none;">
							<div class="subline" id="WANConfigsubline"></div>
						</div>
						<div class="sublinebg" id="IPTVWANsublinepic" style="margin-top:120px;display:none;">
							<div class="subline" id="IPTVWANsubline"></div>
						</div>			
						<div class="diagnosecontent">
							<span id="stbinnerstatus"></span>
						</div>
						<div class="diagnosecontent" style="margin-top: 105px;">
							<span id="IPTVWAnstatus"></span>
						</div>
						<div class="diagnosecontent" style="margin-top: 140px;">
							<span id="stbstatus"></span>
						</div>
					</div>	
				</div>	
				<div id="diagnosecontent_btn" class="h3-content no-padding-bottom" style="display:none;">
					<div class="diagnose_row" id="diagnose_display">
						<div class="diagnose_inputAlign">
							<input class="Diagnose_btn_style" id="Diagnose_btn" type="button" style="margin-left: 552px; background: none repeat scroll 0 0 #9c2aa0; color:#fff;" BindText="s4008">
						</div>
					</div>
				</div>			
			</div>		
		
		
		
		</div>				
		<script type="text/javascript">
		
			$("#Diagnose_click").click(function(){
				$(".diagnose_result").fadeIn(500);
				$("#diagnose_inputAlign").hide();
				setDisable('ItvdfPingApply',1);
				setDisable('Target',1);
			})						
		</script>
		<script type="text/javascript">
			ParseBindTextByTagName(SmartDiagnoseLgeDes, "span",  1);
			ParseBindTextByTagName(SmartDiagnoseLgeDes, "h1",  1);
			ParseBindTextByTagName(SmartDiagnoseLgeDes, "input", 2);
		</script>
		<script type="text/javascript">
			function closeButton(){
				$(".diagnose_result").hide();
				$("#diagnose_inputAlign").show();
				setDisable('ItvdfPingApply',0);
				setDisable('Target',0);			
			}
		</script>
		<script type="text/javascript">
			$("#Diagnose_btn").click(function(){
				$(".diagnose_result").fadeOut();
				$("#diagnose_inputAlign").show();
				setDisable('ItvdfPingApply',0);
				setDisable('Target',0);			
			})	
		</script>
	</div>
	
<div id="diagnoseItvdfPing"> 
	<iframe id="functioncontent" frameborder="0" height="50px" marginheight="0" marginwidth="0" scrolling="no" src="/html/bbsp/maintenance/diagnoseitvdf.asp" width="100%"></iframe> 
</div> 
<script type="text/javascript">
var UpgradeHeigthHandle = setInterval("setIframeHeight('functioncontent');", 50);
function setIframeHeight(iframeid)
{ 
try{
var iframe = document.getElementById(iframeid);

if(iframe.attachEvent)
{ 
try{
var doc = iframe.contentDocument || iframe.document;
var newheigth = iframe.contentWindow.document.documentElement.scrollHeight;
var Bodyheigth = document.body.clientHeight; 
}catch(e){
var newheigth = 50;
return;
}

newheigth = newheigth > 50 ? newheigth : 50;
newheigth = Bodyheigth < 50 ? 50 : newheigth;

iframe.attachEvent("onload", function(){
iframe.height = newheigth;
return;
});


iframe.height = newheigth;
return;
}
else
{
try{
var newheigth = iframe.contentDocument.body.scrollHeight;
var doc = iframe.contentDocument || iframe.document;
var Bodyheigth = document.body.clientHeight; 
newheigth = newheigth > 50 ? newheigth : 50;
newheigth = Bodyheigth < 50 ? 50 : newheigth;
}catch(e){
return ;
}

iframe.onload = function(){
iframe.height = newheigth;
return;
};
iframe.height = newheigth;
return; 
} 
}catch(e){
return;
}
}
</script>
</body>
</html>
