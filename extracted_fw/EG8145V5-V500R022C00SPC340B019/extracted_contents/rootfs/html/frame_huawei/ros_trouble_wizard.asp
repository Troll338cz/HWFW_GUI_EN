<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="/html/amp/common/wlan_list.asp"></script>
<script language="JavaScript" src="/html/amp/common/wlan_extended.asp"></script>
<script language="JavaScript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="JavaScript" src="/html/bbsp/common/wan_list.asp"></script>
<style type="text/css">
.mainbody {
	margin: 0px;
	padding: 0px;
	border-width: 0px;
	text-align: left;
	vertical-align: center;
	margin-left: auto;
	margin-right: auto;
	margin-top: 80px;
	width: 955px;
	height: 600px;
}
</style>
<script language="JavaScript" type="text/javascript">
var waniplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_LANBIND,Lan1Enable|Lan2Enable|Lan3Enable|Lan4Enable,stLanbindInfo);%>;
var wanppplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_LANBIND,Lan1Enable|Lan2Enable|Lan3Enable|Lan4Enable,stLanbindInfo);%>;
var curWandomain = "";
var curEnterStyle = "";
var RouteStatus = '<%HW_WEB_GetRouteStatus();%>';

var redirectUrl = '<%HW_WEB_GetSPEC(SPEC_ROS_REDIRECT_URL.STRING);%>';

var ploamPwdSetFlag = false;

var wlan1 = null;
var wlan5 = null;

var wlan5_exist = false;
var encryTypeArr = new Array();
var pwdNoticeArr = new Array("pwd_2g_notice", "pwd_5g_notice");
var wifi2g_enable;
var wifi5g_enable;
var psk1 = "";
var psk5 = "";
var wep1 = "";
var wep5 = "";

var url = '';
var g_ParameterList = '';
var g_CurPage = '';
var g_NextPage = '';

function WANIP(domain,ConnectionStatus,ExternalIPAddress, X_HW_SERVICELIST,ConnectionType,X_HW_TR069FLAG)
{
  this.domain 	= domain;
  this.ConnectionStatus 	= ConnectionStatus;	
		
  if(ConnectionType == 'IP_Bridged')
  {
  	this.ExternalIPAddress	= '';
  }
  else
  {
    this.ExternalIPAddress	= ExternalIPAddress;
  }
  
  this.X_HW_SERVICELIST = X_HW_SERVICELIST;
  this.X_HW_TR069FLAG = X_HW_TR069FLAG;
	
}

function WANPPP(domain,ConnectionStatus,ExternalIPAddress, X_HW_SERVICELIST,ConnectionType,X_HW_TR069FLAG)
{
  this.domain	= domain;
  this.ConnectionStatus	= ConnectionStatus;	
	
  if (ConnectionType == 'PPPoE_Bridged')
  {  
  	this.ExternalIPAddress	= '';	  
  }
  else
  {
    this.ExternalIPAddress= ExternalIPAddress;
  }	 
  this.X_HW_SERVICELIST = X_HW_SERVICELIST;
  this.X_HW_TR069FLAG = X_HW_TR069FLAG;
}

var WanIp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i},ConnectionStatus||ExternalIPAddress|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANIP);%>;
var WanPpp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},ConnectionStatus|ExternalIPAddress|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANPPP);%>;

function CheckValidInternetWan()
{
	for (i=0; WanIp.length > 1 && i<WanIp.length - 1; i++)
	{
		if (WanIp[i].ConnectionStatus=="Connected")
		{
			if ((WanIp[i].X_HW_SERVICELIST).indexOf("INTERNET") != -1)
			{
				return 1;
			}
		}
	}
	
	for (i=0; WanPpp.length > 1 && i<WanPpp.length - 1; i++)
	{
		if (WanPpp[i].ConnectionStatus=="Connected")
		{
			if ((WanPpp[i].X_HW_SERVICELIST).indexOf("INTERNET") != -1)
			{
				return 1;
			}
		}
	}
	
	return 0;
}

function RefreshWanInfo()
{
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		timeout : 3000,
		url : "./GetRegWanIp.asp",
		success : function(data) {
			WanIp = dealDataWithFun(data);
		}
	});	

	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		timeout : 3000,
		url : "./GetRegWanPpp.asp",
		success : function(data) {
			WanPpp = dealDataWithFun(data);
		}
	});
}

function stTimeInfo(domain,Enable,ntp1,ntp2,ZoneName,SynInterval,WanName,DstUsed,StartDate,EndDate,StartDate_EX,EndDate_EX)
{
	this.domain = domain;
	this.Enable = Enable;
	this.ntp1   = ntp1;
	this.ntp2   = ntp2;
	this.ZoneName    = ZoneName.toString().replace(/&#39;/g, "\'");
	this.SynInterval = SynInterval;
	this.WanName   = WanName;
	this.DstUsed   = DstUsed;
	this.StartDate = StartDate;
	this.EndDate   = EndDate;
	this.StartDate_EX = StartDate_EX;
	this.EndDate_EX   = EndDate_EX;
}

var TimeInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Time,Enable|NTPServer1|NTPServer2|LocalTimeZoneName|X_HW_SynInterval|X_HW_WanName|DaylightSavingsUsed|DaylightSavingsStart|DaylightSavingsEnd|X_HW_DaylightSavingsStartDate|X_HW_DaylightSavingsEndDate,stTimeInfo);%>;

var TimeInfo = TimeInfos[0];

var timeZonesEng = new Array(' GMT-12:00  International Date Line West',
 ' GMT-11:00  Midway Island, Samoa',
 ' GMT-10:00  Hawaii',
 ' GMT-09:00  Alaska',
 ' GMT-08:00  Pacific Time, Tijuana',
 ' GMT-07:00  Arizona, Mazatlan',
 ' GMT-07:00  Chihuahua, La Paz',
 ' GMT-07:00  Mountain Time',
 ' GMT-06:00  Central America',
 ' GMT-06:00  Central Time',
 ' GMT-06:00  Guadalajara, Mexico City, Monterrey',
 ' GMT-06:00  Saskatchewan',
 ' GMT-05:00  Bogota, Lima, Quito',
 ' GMT-05:00  Eastern Time',
 ' GMT-05:00  Indiana',
 ' GMT-04:00  Atlantic Time',
 ' GMT-04:00  Caracas, La Paz',
 ' GMT-04:00  Santiago',
 ' GMT-03:30  Newfoundland',
 ' GMT-03:00  Brasilia',
 ' GMT-03:00  Buenos Aires, Georgetown',
 ' GMT-03:00  Greenland',
 ' GMT-02:00  Mid-Atlantic',
 ' GMT-01:00  Azores',
 ' GMT-01:00  Cape Verde Is.',
 ' GMT  Casablanca, Monrovia',
 ' GMT  Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London',
 ' GMT+01:00  Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
 ' GMT+01:00  Belgrade, Bratislava, Budapest, Ljubljana, Prague',
 ' GMT+01:00  Brussels, Copenhagen, Madrid, Paris',
 ' GMT+01:00  Sarajevo, Skopje, Warsaw, Zagreb',
 ' GMT+01:00  West Central Africa',
 ' GMT+02:00  Athens, Istanbul, Minsk',
 ' GMT+02:00  Bucharest',
 ' GMT+02:00  Cairo',
 ' GMT+02:00  Harare, Pretoria',
 ' GMT+02:00  Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius',
 ' GMT+02:00  Jerusalem',
 ' GMT+03:00  Baghdad',
 ' GMT+03:00  Kaliningrad',
 ' GMT+03:00  Kuwait, Riyadh',
 ' GMT+03:00  Nairobi',
 ' GMT+03:00  Moscow, St. Petersburg, Volgograd',
 ' GMT+03:30  Tehran',
 ' GMT+04:00  Abu Dhabi, Muscat',
 ' GMT+04:00  Baku, Tbilisi, Yerevan',
 ' GMT+04:30  Kabul',
 ' GMT+05:00  Islamabad, Karachi, Tashkent',
 ' GMT+05:30  Chennai, Kolkata, Mumbai, New Delhi',
 ' GMT+05:45  Kathmandu',
 ' GMT+06:00  Almaty',
 ' GMT+06:00  Astana, Dhaka',
 ' GMT+06:00  Ekaterinburg',
 ' GMT+06:00  Sri Jayawardenepura',
 ' GMT+06:30  Rangoon',
 ' GMT+07:00  Bangkok, Hanoi, Jakarta',
 ' GMT+07:00  Novosibirsk',
 ' GMT+08:00  Beijing, Chongqing, Hong Kong, Urumqi',
 ' GMT+08:00  Krasnoyarsk',
 ' GMT+08:00  Kuala Lumpur, Singapore',
 ' GMT+08:00  Perth',
 ' GMT+08:00  Taipei',
 ' GMT+08:00  Ulaan Bataar',
 ' GMT+09:00  Irkutsk',
 ' GMT+09:00  Osaka, Sapporo, Tokyo',
 ' GMT+09:00  Seoul',
 ' GMT+09:30  Adelaide',
 ' GMT+09:30  Darwin',
 ' GMT+10:00  Brisbane',
 ' GMT+10:00  Canberra, Melbourne, Sydney',
 ' GMT+10:00  Guam, Port Moresby',
 ' GMT+10:00  Hobart',
 ' GMT+10:00  Yakutsk',
 ' GMT+11:00  Solomon Is., New Caledonia',
 ' GMT+11:00  Vladivostok',
 ' GMT+12:00  Auckland, Wellington',
 ' GMT+12:00  Fiji, Kamchatka, Marshall Is.',
 ' GMT+12:00  Magadan',
 ' GMT+13:00  Nuku\'alofa');

function getTimeZoneIndex(timeZoneName)
{
	var i = 0, ret = 4;

	for ( var i = 0; i < timeZonesEng.length; i++ )
	{
		if ( timeZonesEng[i].search(timeZoneName) != -1 )
			break;
	}

	if (i < timeZonesEng.length)
		ret = i;

	return ret;
}

var tz_name = TimeInfo.ZoneName;

function stDeviceInfo(domain,SerialNumber,HardwareVersion,SoftwareVersion,ModelName,VendorID,ReleaseTime,Mac,Description,ManufactureInfo)
{
this.domain= domain;
this.SerialNumber= SerialNumber;
this.HardwareVersion= HardwareVersion;
this.SoftwareVersion= SoftwareVersion;
this.ModelName= ModelName;
this.VendorID= VendorID;
this.ReleaseTime = ReleaseTime;
this.Mac= Mac;
this.Description= Description;
this.ManufactureInfo= ManufactureInfo;
}

var deviceInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|HardwareVersion|SoftwareVersion|ModelName|X_HW_VendorId|X_HW_ReleaseTime|X_HW_LanMac|Description|ManufactureInfo, stDeviceInfo);%>;
deviceInfos = deviceInfos[0];

if(window.location.href.indexOf("cfgwizard.asp?") > 0)
{
	var currentUrl = window.location.href;
	var tempId = (currentUrl.split("?"))[1];
	if(tempId != "")
	{
		curEnterStyle = "Link";
	}
}
else
{
	curEnterStyle = "Direct";
}
	
function GetLanguageDesc(Name)
{
    return CfgguideLgeDes[Name];
}

function IsWlanAvailable()
{
	if(1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>')
	{
		return true;
	}
	else
	{
		return false;
	}
}

function stLanbindInfo(domain,lan1enable,lan2enable,lan3enable,lan4enable)
{
    this.domain = domain;
    this.lan1enable = lan1enable;
    this.lan2enable = lan2enable;
    this.lan3enable = lan3enable;
    this.lan4enable = lan4enable;
}

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stPreSharedKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function getWlan()
{
    wlan1 = getFirstSSIDInst(1, allWlanInfo);

    allPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;
    allWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;

	if(allPsk.length == 0 || allWep.length == 0)
	{
		return;
	}
	
    if(null != wlan1)
    {
        psk1 = getPsk(wlan1.InstId, allPsk);
        wep1 = getWep(wlan1.InstId, wlan1.KeyIndex, allWep);
    }

    if(1 == DoubleFreqFlag)
    {
        wlan5 = getFirstSSIDInst(2, allWlanInfo);
        wlan5_exist = (null != wlan5);

        if(wlan5_exist)
        {
            psk5 = getPsk(wlan5.InstId, allPsk);
            wep5 = getWep(wlan5.InstId, wlan5.KeyIndex, allWep);
        }
    }
}

function initWlanEncType(wlan)
{
    var idx = wlan==wlan1?0:1;
    
    if(wlan.BeaconType == 'Basic')
    {
        if(wlan.BasicEncryptionModes == 'WEPEncryption')
        {
            encryTypeArr[idx] = "wep";
        }
        else
        {
            encryTypeArr[idx] = "none";
        }
    }
    else
    {
        encryTypeArr[idx] = "psk";
    }
}

function setPwdText(idx)
{
    var txtId = idx?"txt_5g_wifipwd":"txt_2g_wifipwd";
    if(encryTypeArr[idx] == "none")
    {
        setText(txtId, "");
    }
    else
    {
        var pwd = (encryTypeArr[idx] == "wep")?(idx?wep5:wep1):(idx?psk5:psk1);
        setText(txtId, pwd);
    }
}

function checkWlanPara(wlan)
{
    var wlanInst = wlan.InstId;
    var idx = wlan==wlan1?0:1;
    var pwd = idx?getValue("txt_5g_wifipwd"):getValue("txt_2g_wifipwd");
    var ssid = idx?getValue("txt_5g_wifiname"):getValue("txt_2g_wifiname");
    
    if(!CheckSsid(ssid))
    {
      return false;
    }
    
    wlan.ssid = ssid;
    if(checkSSIDExist(wlan, allWlanInfo))
        return false;
    
    if(encryTypeArr[idx] == "wep")
    {    
        if(!checkWep(pwd, wlan.WEPEncryptionLevel))
            return false;
    }
    else
    {
        if(!CheckPsk(pwd))
        {
           return false;
        }
    }
    
    return true;
}

function Wlan_AddRadioPara(form)
{
	if(wlan1 != null)
	{
		var radioEnabled = getCheckVal("wlan_2g_enable");
		if(enbl2G != radioEnabled)
		{
			g_ParameterList += '&r1.Enable=' + radioEnabled;
			url += 'r1=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&';
		}
	}

	if(wlan5 != null)
	{
		var radioEnabled = getCheckVal("wlan_5g_enable");
		if(1 == DoubleFreqFlag && enbl5G != radioEnabled)
		{
			g_ParameterList += '&r2.Enable=' + radioEnabled;
			url += 'r2=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2&';
		}	
	}
}

function setRadioEnable(Band)
{
    setDisplay('wlaninfo_' + Band + '_detail', getCheckVal('wlan_' + Band + '_enable'));
}

function radioChooseMode()
{
	var ModeVal = getRadioVal('wizard1Mode');
	if('1' == ModeVal)
	{
		setDisplay("Wizard1Panel",0);
	}
	else
	{
		setDisplay("Wizard1Panel",1);
	}
}

function stNormalUserInfo(UserName, ModifyPasswordFlag)
{
    this.UserName = UserName;
    this.ModifyPasswordFlag = ModifyPasswordFlag;	
}

var UserInfo = <%HW_WEB_GetNormalUserInfo(stNormalUserInfo);%>;

var sptUserName = UserInfo[0].UserName;

var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';

function CheckPwdIsComplex(str)
{
	var i = 0;
    if (str.length < pwdLen)
	{
		return false;
	}
	
	if (!CompareString(str,sptUserName) )
	{
		return false;
	}
	
	if ( isLowercaseInString(str) || isUppercaseInString(str))
	{
		i++;
	}
	
	if ( isDigitInString(str) )
	{
		i++;
	}
	
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function checkOpticInfo(param)
{
    g_OpticInfo = GetOpticInfo();
    if(g_OpticInfo != "--" && g_OpticInfo != "")
    {
        if('wizard_5_1' == param)
        {
            if(0 != g_TH_CheckOptic)
            {
                clearInterval(g_TH_CheckOptic);
                g_TH_CheckOptic = 0;
            }

            $("#btn_WaitOpticNormal").removeAttr("disabled");
            ShowNextStep("wizard_5_1", "wizard_4_1_2");
        }
        
        return true;
    }
    
    return false;
}

function LoadFrame()
{
    document.cookie = 'Cookie=default;path=/';

    setDisplay("wizard_5_1", 1);
    return;
}

function isAscii(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch <= ' ' || ch > '~' )
        {
            return false;
        }
    }
    return true;
}

function GetOntOnlineStatus()
{
    var ONTOnLineStatus = null;
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/ssmp/common/GetOnlineStatus.asp",
        success : function(data) {
            ONTOnLineStatus = parseInt(data);
        }
    });
    
    return ONTOnLineStatus;
}

var indextoken = '<%HW_WEB_GetToken();%>';
var UpgradeFlag = 0;
var g_TH_CheckOnline = 0;
var g_CheckOnline_Inter = 5000;
var g_CheckOnline_Timeout = 60000;
var g_CheckOnline_TimeLeft = g_CheckOnline_Timeout;
var g_TH_WaitStatus = 0;
var g_online = GetOntOnlineStatus();
//g_online = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>';
var g_result = <%HW_WEB_GetCWMPRebootFlag();%>;
var g_opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>';
var g_TH_CheckOptic = 0;
var g_OpticRetryTime = 3;
var g_OpticRetry_Timeout = g_CheckOnline_Inter*3;
var g_wizard_1_1_jump_flag = 0;
top.EnterWizardFlag = 0;

function getTimeZoneName(idx)
{
var str = timeZonesEng[idx];
var ret = '';

if ( idx != 25 && idx != 26 )
ret = str.substr(12);
else
ret = str.substr(6);

return ret;
}

function ChangeAsciitoHex(passwd)
{
    var hexstr = "";
var temp = "";
var code = 0;
for (var i = 0; i < passwd.length; i++)
{
     code = parseInt(passwd.charCodeAt(i));
 if (code < 16)
 {
     hexstr += "0";
 hexstr += code.toString(16);
 } 
 else
 {
     hexstr += code.toString(16);
 }
}

return hexstr;
}

function HwAjaxGetPara(ObjPath, ParameterList)
{
	var Result = null;
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/getajax.cgi?' + ObjPath + "&RequestFile=/ros_trouble_wizard.asp",
		data: ParameterList,
		success : function(data) {
			 Result  = data;
		}
	});
	
	return Result;
}

function HwAjaxSetPara(ObjPath, ParameterList)
{
    var Result = null;
      $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/ActiveBss.cgi?' + ObjPath + "&RequestFile=/ros_trouble_wizard.asp",
        data: getDataWithToken(ParameterList),
        success : function(data) {
             Result  = data;
             
             if('' != g_NextPage)
             {
                ShowNextStep(g_CurPage, g_NextPage);
                g_NextPage = '';
             }
        }
    });
    
    return Result;
}

function SubmitPloamCode()
{
    if(false == ploamPwdSetFlag)
    {
        return;
    }
    
	var password = ChangeAsciitoHex(getValue('Wizard_password_0_1_password'));
	var path = "x=InternetGatewayDevice.DeviceInfo";
	//var paralist = "x.X_HW_ForceSet=1&x.X_HW_PonHexPassword=" + password + "&x.X_HW_Token=" + indextoken;
	var paralist = "x.X_HW_ForceSet=1&x.X_HW_PonHexPassword=" + password;	
	HwAjaxSetPara(path, paralist);
}

function StartOntAuth()
{
    SubmitPloamCode();
    
    g_CheckOnline_TimeLeft = g_CheckOnline_Timeout;
    
    g_TH_WaitStatus = setInterval("OnlineWaitTime()", 1000);
    g_TH_CheckOnline = setInterval("CheckPonInfoStatus('wizard_4_1_1')", g_CheckOnline_Inter);
    
    var TimerHandle = setTimeout("CancelGetPONStatus(1)", g_CheckOnline_Timeout);
}

function ShowNextStep(HideId,ShowId)
{
    if(ShowId == "wizard_4_1_1")
    {
        var password = ChangeAsciitoHex(getValue('Wizard_password_0_1_password'));
    	if(true == ploamPwdSetFlag && password.length != 20)
    	{
    	    AlertEx(CfgguideLgeDes['s3001']);
            return false;
    	}
        
        $("#p_wait_sec").html(RosWizardDes["s4111a"] + " < " + 60 + " > " + RosWizardDes["s4111b"]);

    	$("#"+HideId).css("display", "none");
        $("#"+ShowId).css("display", "block");
		
        StartOntAuth();
    }
    else
    {
        $("#"+HideId).css("display", "none");
        $("#"+ShowId).css("display", "block");
    }
}

function CloseFirstStartRedirect()
{
	var Result = null;
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : './close_force_direct.asp',
		success : function(data) {
			 Result  = data;
		}
	});
	
	return Result;
}

function StartWizard()
{
	RefreshWanInfo();
	var ValidInternetWan = CheckValidInternetWan();
	
    if(1 == ValidInternetWan)
	{
	    g_NextPage = 'wizard_4_1';
		
		CloseFirstStartRedirect();
	}
	else
	{
	    g_NextPage = 'wizard_4_2';
	}
	
	if(wlan1 == null)
	{
		g_CurPage = 'wizard_1_2';
		ShowNextStep(g_CurPage, g_NextPage);
	}
	else
	{
		g_CurPage = 'wizard_3_1';
		ShowNextStep('wizard_1_2','wizard_3_1');
	}
}

function GetOpticInfo()
{
    var ONTOnLineStatus = null;
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/ssmp/common/GetOpticInfo.asp",
        success : function(data) {
            ONTOnLineStatus = hexDecode(data);
        }
    });
    
    return ONTOnLineStatus;
}

function GetCWMPRebootFlag()
{
	var Result = null;
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : './GetCWMPRebootFlag.asp',
		success : function(data) {
			 Result  = data;
		}
	});
	
	return Result;
}

function CancelGetPONStatus(IsTimeOut)
{
    if(0 != g_TH_CheckOnline)
    {
        clearInterval(g_TH_CheckOnline);
        g_TH_CheckOnline = 0;
    }    
    
    if(0 != g_TH_WaitStatus)
    {
        clearInterval(g_TH_WaitStatus);
        g_TH_WaitStatus = 0;
    }
        
    if("1" == IsTimeOut)
    {
        if(0 == g_online)
        {
            if(false == ploamPwdSetFlag)
            {
                ploamPwdSetFlag = true;
                ShowNextStep("wizard_4_1_1", "wizard_0_1");
                
                return;
            }
            
            ShowNextStep("wizard_4_1_1", "wizard_5_2");
            return;
        }
		
		if (0 == g_result)
		{
            ShowNextStep("wizard_4_1_1", "wizard_4_2");
            return;
		}
    }
    
    return;
}

function CheckPonInfoStatus(curPage)
{   
    g_online = GetOntOnlineStatus();
    
    if(1 == g_online)
    {
        {
            if("wizard_4_1_1" == curPage)
            {
				g_result = GetCWMPRebootFlag();
				if (1 == g_result)
				{
				    if(0 != g_TH_CheckOnline)
        			{
        				clearInterval(g_TH_CheckOnline);
        				g_TH_CheckOnline = 0;
        			}
					
					g_wizard_1_1_jump_flag = 0;
					ShowNextStep("wizard_4_1_1", "wizard_1_1");
					CancelGetPONStatus(0);				
				}

            }
            else if("wizard_5_1" == curPage)
            {
                $("#btn_WaitOpticNormal").removeAttr("disabled");
                ShowNextStep("wizard_5_1", "wizard_4_1_2");
            }
        }
    }
}

function OnlineWaitTime()
{
	g_CheckOnline_TimeLeft -= 1000;
    var sec = g_CheckOnline_TimeLeft/1000;
    $("#p_wait_sec").html(RosWizardDes["s4111a"] + " < " + sec + " > " + RosWizardDes["s4111b"]);
}

function WaitOpticNormal_TimeOutHandle()
{	
    $("#btn_WaitOpticNormal").removeAttr("disabled");
    if(0 != g_TH_CheckOptic)
    {
        clearInterval(g_TH_CheckOptic);
        g_TH_CheckOptic = 0;
    }
            
    if(0 == g_OpticRetryTime)
    {
        ShowNextStep("wizard_5_1", (checkOpticInfo('') == true) ? "wizard_4_1_2" :"wizard_5_2");
    }
}

function WaitOpticNormal()
{
    g_OpticRetryTime--;
    $("#btn_WaitOpticNormal").attr("disabled", "disabled");
    g_TH_CheckOptic = setInterval("checkOpticInfo('wizard_5_1')", g_CheckOnline_Inter);
    var TimerHandle = setTimeout("WaitOpticNormal_TimeOutHandle()", g_OpticRetry_Timeout);
}
 
function NextStep4()
{
    ShowNextStep("wizard_1_1", "wizard_3_1");
}


function Wlan_Pre()
{
    ShowNextStep("wizard_3_1", "wizard_1_1");
}

function Wlan_Next()
{
    var checkFlag = true;
    
    if(null != wlan1)
    {
        checkFlag = checkWlanPara(wlan1);
    }
    
    if(checkFlag && null != wlan5)
    {
        checkFlag = checkWlanPara(wlan5);
    }
    
    if(checkFlag)
    {
        ApplySubmit_3_1();
    }
}

function Wlan_AddPara(wlan)
{
    if((null == wlan) || (0 == getCheckVal("wlan_" + (wlan==wlan1 ? "2g" : "5g") + "_enable")))
    {
        return;
    }
    
    var wlanInst = wlan.InstId;
    var idx = wlan==wlan1?0:1;
    var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;
    var pwd = idx?getValue("txt_5g_wifipwd"):getValue("txt_2g_wifipwd");
	var pwdOld = (encryTypeArr[idx] == "wep")?(idx?wep5:wep1):(idx?psk5:psk1);
    var ssid = idx?getValue("txt_5g_wifiname"):getValue("txt_2g_wifiname");
	
	if(pwd != pwdOld)
	{
		if(encryTypeArr[idx] == "wep")
		{
			var wep1Domain = wlanDomain + ".WEPKey." + wlan.KeyIndex;

			g_ParameterList += '&wep'+idx+'.WEPKey=' + pwd;
			url += "wep"+idx+"="+wep1Domain+"&";
		}
		else
		{
			var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration."+wlanInst+".PreSharedKey.1";

			g_ParameterList += '&psk'+idx+'.PreSharedKey=' + pwd;
			url += "psk"+idx+"="+pskDomain+"&";
		}
	}
    
    if(encryTypeArr[idx] == "none")
    {
        g_ParameterList += '&w'+idx+'.BeaconType=WPAand11i';
        g_ParameterList += '&w'+idx+'.X_HW_WPAand11iAuthenticationMode=PSKAuthentication';
        g_ParameterList += '&w'+idx+'.X_HW_WPAand11iEncryptionModes=TKIPandAESEncryption';
    }
    
    g_ParameterList += '&w'+idx+'.SSID=' + ssid;
    
    url += "w"+idx+"="+wlanDomain+"&";
    
    return true;
}

function Sntp_AddPara()
{
	var cboTimeZone = document.getElementById('Wizard_password04_05_drop');
	var TimeZone = getTimeZoneName(cboTimeZone.selectedIndex);
	
	g_ParameterList += "&t.LocalTimeZoneName=" + TimeZone;
	url += 't=InternetGatewayDevice.Time&';
}

function NormalPwd_AddPara()
{
	g_ParameterList += "&x.Password=" + getValue("Wizard_password_1_1_password_0");
	url += 'x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1&';
}

function ApplySubmit_1_1()
{
    url = '';
    g_ParameterList = '';
    
    Sntp_AddPara();
    NormalPwd_AddPara();
    
    //g_ParameterList += "&x.X_HW_Token=" + indextoken;
    g_ParameterList = g_ParameterList.substring(1);
    
    if(url.length > 1)
    {
        url = url.substring(0, url.length-1);
    }
    
    HwAjaxSetPara(url, g_ParameterList);
}

function ApplySubmit_3_1()
{
    url = '';
    g_ParameterList = '';
    
    Wlan_AddPara(wlan1);
    Wlan_AddPara(wlan5);
    
    Wlan_AddRadioPara();
	
    //g_ParameterList += "&x.X_HW_Token=" + indextoken;
    g_ParameterList = g_ParameterList.substring(1);
    
    if(url.length > 1)
    {
        url = url.substring(0, url.length-1);
    }
    
    HwAjaxSetPara(url, g_ParameterList);
}

function screen_1_1_ok()
{
	var password0 = getValue("Wizard_password_1_1_password_0");
	var password1 = getValue("Wizard_password_1_1_password_1");

	if((password0.length == 0) || (password1.length == 0))
	{
		alert("Password can not be empty!");
		return;
	}
	
	if(password0 != password1)
	{
		alert("New password does not equal confirm password!");
		return;
	}
	
	if(!CheckPwdIsComplex(password0))
	{
		AlertEx(RosWizardDes["s1102"]);
		return false;
	}	
	
	ApplySubmit_1_1();
	
	if (0 == g_wizard_1_1_jump_flag)
	{
		ShowNextStep('wizard_1_1','wizard_1_2');
	}
	else
	{
		window.location.href="../../../index.asp";	
	}
	
	return;
}

function JumpToIndex()
{
	window.location.href="../../../index.asp";
	return;
}

function Jump_4_2()
{
	g_wizard_1_1_jump_flag = 1;
	
	ShowNextStep('wizard_4_2','wizard_1_1');
	
	return;
}

function Jump_5_1()
{
	g_result = GetCWMPRebootFlag();
	if (1 == g_result)
	{
		window.location.href="../../../index.asp";	
	}
	else
	{
		g_wizard_1_1_jump_flag = 0;
	
		ShowNextStep('wizard_5_1','wizard_1_1');
	}
	
	return;
}

function Jump_5_2()
{
	g_result = GetCWMPRebootFlag();
	if (1 == g_result)
	{
		window.location.href="../../../index.asp";	
	}
	else
	{
		g_wizard_1_1_jump_flag = 1;
	
		ShowNextStep('wizard_5_2','wizard_1_1');
	}
	
	return;
}

function RedirectToRT()
{
	for (i=0; i<5; i++)
	{
		GetOpticInfo();
	}

	window.location = redirectUrl;
	return;
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">

<div><img src="../../../images/ros_logo.gif" /></div>

<div id="wizard_0_1" style="display:none;">

<div style="border:thin dashed #000000;padding:20px;margin-top:20px;">
<p style="text-align:center"><script>document.write(RosWizardDes["s0100"]);</script></p>
</div>

<table width="100%" height = "60px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<table width="100%" height = "100px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
		<div style="border:thin dashed #000000;padding:10px;margin-top:20px;width:50%;" align="center"">

		<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
		  <tr> 
			<td><script>document.write(RosWizardDes["s0101"]);</script></td> 
			<td><input name='Wizard_password_0_1_password' type='text' id="Wizard_password_0_1_password" maxlength="10" size="30" /></td> 
		  </tr> 
		</table> 

		</div>	
	</td> 
  </tr> 
</table> 

<table width="100%" height = "60px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
      <input name="Wizard_button_0_1_button" id="Wizard_button_0_1_button" type="button" onClick="ShowNextStep('wizard_0_1','wizard_4_1_1');" value="" BindText="s0102" />
	</td> 
  </tr> 
</table> 

</div> 

<div id="wizard_1_1" style="display:none"> 

<div style="border:thin dashed #000000;padding:20px;margin-top:20px;">
<p style="text-align:center">Этот маршрутизатор идеально подходит для домашних сетей и малого офиса. Встроенный мастер быстрой настройки поможет Вам подготовить маршрутизатор для подключения к сети Ростелеком. Пожалуйста следуйте указаниям мастера быстрой настройки шаг за шагом.
</p>
</div>

<table id="table_timezone" style="margin-top:30px;" width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> 
<td width="25%"><label id = "Title_wizard4_lable2">Выбор часового пояса:</label></td> 
<td width="75%">
<select id="Wizard_password04_05_drop" class="selectdefcss" realtype="DropDownList" bindfield="x.LocalTimeZoneName" size="1" maxlength="20">
<option value=" GMT-12:00  International Date Line West"> GMT-12:00  International Date Line West</option>
<option value=" GMT-11:00  Midway Island, Samoa"> GMT-11:00  Midway Island, Samoa</option>
<option value=" GMT-10:00  Hawaii"> GMT-10:00  Hawaii</option><option value=" GMT-09:00  Alaska"> GMT-09:00  Alaska</option>
<option value=" GMT-08:00  Pacific Time, Tijuana"> GMT-08:00  Pacific Time, Tijuana</option>
<option value=" GMT-07:00  Arizona, Mazatlan"> GMT-07:00  Arizona, Mazatlan</option>
<option value=" GMT-07:00  Chihuahua, La Paz"> GMT-07:00  Chihuahua, La Paz</option>
<option value=" GMT-07:00  Mountain Time"> GMT-07:00  Mountain Time</option>
<option value=" GMT-06:00  Central America"> GMT-06:00  Central America</option>
<option value=" GMT-06:00  Central Time"> GMT-06:00  Central Time</option>
<option value=" GMT-06:00  Guadalajara, Mexico City, Monterrey"> GMT-06:00  Guadalajara, Mexico City, Monterrey</option>
<option value=" GMT-06:00  Saskatchewan"> GMT-06:00  Saskatchewan</option>
<option value=" GMT-05:00  Bogota, Lima, Quito"> GMT-05:00  Bogota, Lima, Quito</option>
<option value=" GMT-05:00  Eastern Time"> GMT-05:00  Eastern Time</option>
<option value=" GMT-05:00  Indiana"> GMT-05:00  Indiana</option>
<option value=" GMT-04:00  Atlantic Time"> GMT-04:00  Atlantic Time</option>
<option value=" GMT-04:00  Caracas, La Paz"> GMT-04:00  Caracas, La Paz</option>
<option value=" GMT-04:00  Santiago"> GMT-04:00  Santiago</option>
<option value=" GMT-03:30  Newfoundland"> GMT-03:30  Newfoundland</option>
<option value=" GMT-03:00  Brasilia"> GMT-03:00  Brasilia</option>
<option value=" GMT-03:00  Buenos Aires, Georgetown"> GMT-03:00  Buenos Aires, Georgetown</option>
<option value=" GMT-03:00  Greenland"> GMT-03:00  Greenland</option>
<option value=" GMT-02:00  Mid-Atlantic"> GMT-02:00  Mid-Atlantic</option>
<option value=" GMT-01:00  Azores"> GMT-01:00  Azores</option>
<option value=" GMT-01:00  Cape Verde Is."> GMT-01:00  Cape Verde Is.</option>
<option value=" GMT  Casablanca, Monrovia"> GMT  Casablanca, Monrovia</option>
<option value=" GMT  Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London"> GMT  Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London</option>
<option value=" GMT+01:00  Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"> GMT+01:00  Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna</option>
<option value=" GMT+01:00  Belgrade, Bratislava, Budapest, Ljubljana, Prague"> GMT+01:00  Belgrade, Bratislava, Budapest, Ljubljana, Prague</option>
<option value=" GMT+01:00  Brussels, Copenhagen, Madrid, Paris"> GMT+01:00  Brussels, Copenhagen, Madrid, Paris</option>
<option value=" GMT+01:00  Sarajevo, Skopje, Warsaw, Zagreb"> GMT+01:00  Sarajevo, Skopje, Warsaw, Zagreb</option>
<option value=" GMT+01:00  West Central Africa"> GMT+01:00  West Central Africa</option>
<option value=" GMT+02:00  Athens, Istanbul, Minsk"> GMT+02:00  Athens, Istanbul, Minsk</option>
<option value=" GMT+02:00  Bucharest"> GMT+02:00  Bucharest</option>
<option value=" GMT+02:00  Cairo"> GMT+02:00  Cairo</option>
<option value=" GMT+02:00  Harare, Pretoria"> GMT+02:00  Harare, Pretoria</option>
<option value=" GMT+02:00  Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius"> GMT+02:00  Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius</option>
<option value=" GMT+02:00  Jerusalem"> GMT+02:00  Jerusalem</option>
<option value=" GMT+03:00  Baghdad"> GMT+03:00  Baghdad</option>
<option value=" GMT+03:00  Kaliningrad"> GMT+03:00  Kaliningrad</option>
<option value=" GMT+03:00  Kuwait, Riyadh"> GMT+03:00  Kuwait, Riyadh</option>
<option value=" GMT+03:00  Nairobi"> GMT+03:00  Nairobi</option>
<option value=" GMT+03:00  Moscow, St. Petersburg, Volgograd"> GMT+03:00  Moscow, St. Petersburg, Volgograd</option>
<option value=" GMT+03:30  Tehran"> GMT+03:30  Tehran</option>
<option value=" GMT+04:00  Abu Dhabi, Muscat"> GMT+04:00  Abu Dhabi, Muscat</option>
<option value=" GMT+04:00  Baku, Tbilisi, Yerevan"> GMT+04:00  Baku, Tbilisi, Yerevan</option>
<option value=" GMT+04:30  Kabul"> GMT+04:30  Kabul</option>
<option value=" GMT+05:00  Islamabad, Karachi, Tashkent"> GMT+05:00  Islamabad, Karachi, Tashkent</option>
<option value=" GMT+05:30  Chennai, Kolkata, Mumbai, New Delhi"> GMT+05:30  Chennai, Kolkata, Mumbai, New Delhi</option>
<option value=" GMT+05:45  Kathmandu"> GMT+05:45  Kathmandu</option>
<option value=" GMT+06:00  Almaty"> GMT+06:00  Almaty</option>
<option value=" GMT+06:00  Astana, Dhaka"> GMT+06:00  Astana, Dhaka</option>
<option value=" GMT+06:00  Ekaterinburg"> GMT+06:00  Ekaterinburg</option>
<option value=" GMT+06:00  Sri Jayawardenepura"> GMT+06:00  Sri Jayawardenepura</option>
<option value=" GMT+06:30  Rangoon"> GMT+06:30  Rangoon</option>
<option value=" GMT+07:00  Bangkok, Hanoi, Jakarta"> GMT+07:00  Bangkok, Hanoi, Jakarta</option>
<option value=" GMT+07:00  Novosibirsk"> GMT+07:00  Novosibirsk</option>
<option value=" GMT+08:00  Beijing, Chongqing, Hong Kong, Urumqi"> GMT+08:00  Beijing, Chongqing, Hong Kong, Urumqi</option>
<option value=" GMT+08:00  Krasnoyarsk"> GMT+08:00  Krasnoyarsk</option>
<option value=" GMT+08:00  Kuala Lumpur, Singapore"> GMT+08:00  Kuala Lumpur, Singapore</option>
<option value=" GMT+08:00  Perth"> GMT+08:00  Perth</option>
<option value=" GMT+08:00  Taipei"> GMT+08:00  Taipei</option>
<option value=" GMT+08:00  Ulaan Bataar"> GMT+08:00  Ulaan Bataar</option>
<option value=" GMT+09:00  Irkutsk"> GMT+09:00  Irkutsk</option>
<option value=" GMT+09:00  Osaka, Sapporo, Tokyo"> GMT+09:00  Osaka, Sapporo, Tokyo</option>
<option value=" GMT+09:00  Seoul"> GMT+09:00  Seoul</option>
<option value=" GMT+09:30  Adelaide"> GMT+09:30  Adelaide</option>
<option value=" GMT+09:30  Darwin"> GMT+09:30  Darwin</option>
<option value=" GMT+10:00  Brisbane"> GMT+10:00  Brisbane</option>
<option value=" GMT+10:00  Canberra, Melbourne, Sydney"> GMT+10:00  Canberra, Melbourne, Sydney</option>
<option value=" GMT+10:00  Guam, Port Moresby"> GMT+10:00  Guam, Port Moresby</option>
<option value=" GMT+10:00  Hobart"> GMT+10:00  Hobart</option>
<option value=" GMT+10:00  Yakutsk"> GMT+10:00  Yakutsk</option>
<option value=" GMT+11:00  Solomon Is., New Caledonia"> GMT+11:00  Solomon Is., New Caledonia</option>
<option value=" GMT+11:00  Vladivostok"> GMT+11:00  Vladivostok</option>
<option value=" GMT+12:00  Auckland, Wellington"> GMT+12:00  Auckland, Wellington</option>
<option value=" GMT+12:00  Fiji, Kamchatka, Marshall Is."> GMT+12:00  Fiji, Kamchatka, Marshall Is.</option>
<option value=" GMT+12:00  Magadan"> GMT+12:00  Magadan</option>
<option value=" GMT+13:00  Nuku'alofa"> GMT+13:00  Nuku'alofa</option>
</select>
</td> 
</tr>
</table>

<div style="border:thin dashed #000000;padding:20px;margin-top:20px;margin-bottom:20px;"><p style="text-align:center">Для Вашей безопасности, пожалуйста измените пароль роутера, установленный по умолчанию. Введите новый пароль и подтверждение в поле ниже и нажмите кнопку «ОК» для продолжения</p></div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td width="25%"><script>document.write(RosWizardDes["s1100"]);</script></td>
		<td rowspan="2" width="75%">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="27%">
						<input name='Wizard_password_1_1_password_0' type="password" id="Wizard_password_1_1_password_0" size="15" autocomplete="off" />
					</td>	
				</tr>
				<tr>
					<td width="27%">
					<input name='Wizard_password_1_1_password_1' type='password' id="Wizard_password_1_1_password_1" size="15" autocomplete="off" />
					</td>	
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td class="table_left" width="25%"><script>document.write(RosWizardDes["s1101"]);</script></td>
	</tr>
</table>
<table width="100%" height="40" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
  <td>
  </td> 
  </tr> 
</table> 
<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
      <input name="Wizard_button_1_1_button" id="Wizard_button_1_1_button" type="button" onClick="screen_1_1_ok();"  value="OK" />
	</td> 
  </tr> 
</table> 
</div>

<div id="wizard_1_2" style="display:none">

<div style="border:thin dashed #000000;padding:20px;margin-top:20px;">
<p style="text-align:center"><B><script>document.write(RosWizardDes["s1200"]);</script></B></p>
<p style="text-align:center">Вы можете настроить маршрутизатор самостоятельно или при помощи встроенного мастера быстрой настройки.</p>
</div>

<table width="100%" height = "200px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="wizard1_table2"> 
  <tr align="center">
	<td>
	 <input id="Wizard_button_1_2_1" type="button" onClick="StartWizard();" value="" BindText="s1201" /> 
	<td>
	<td>
	 <input id="Wizard_button_1_2_2" type="button" onClick="JumpToIndex();" value="" BindText="s1202" /> 
	<td>
  </tr>         
</table>

</div>

<div id="wizard_3_1" style="display:none">

<table width="100%" height = "50px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<div id="wlaninfo_note" width="100%" style="float: right; width: 50%; text-align: center; border:thin dashed #000000; padding:50px; margin:20px 0px 20px 0px;">
    <span><script>document.write(RosWizardDes["s3101"]);</script></span>
</div>

<table id="wlaninfo_2g" width="100%" border="0" cellpadding="5" cellspacing="0" style="display:none;">
    <tr> 
        <td width="30%"><script>document.write(RosWizardDes["s3102"]);</script></td>
        <td width="70%"><input type='checkbox' id='wlan_2g_enable' onclick='setRadioEnable("2g");'/></td>
    </tr>
</table>
<table id="wlaninfo_2g_detail" width="100%" border="0" cellpadding="5" cellspacing="0" style="display:none;">
    <tr> 
        <td width="30%"><script>document.write(RosWizardDes["s3103"]);</script></td>
        <td width="70%"><input id='txt_2g_wifiname' /></td>
    </tr>
    <tr> 
        <td width="30%"><script>document.write(RosWizardDes["s3104"]);</script></td>
        <td width="70%"><input id='txt_2g_wifipwd' /></td>
    </tr>
</table>

<table id="wlaninfo_5g" width="100%" border="0" cellpadding="5" cellspacing="0" style="display:none;">
    <tr> 
        <td width="30%"><script>document.write(RosWizardDes["s3105"]);</script></td>
        <td width="70%"><input type='checkbox' id='wlan_5g_enable' onclick='setRadioEnable("5g");'/></td>
    </tr>
</table>
<table id="wlaninfo_5g_detail" width="100%" border="0" cellpadding="5" cellspacing="0" style="display:none;">    
    <tr> 
        <td width="30%"><script>document.write(RosWizardDes["s3106"]);</script></td>
        <td width="70%"><input id='txt_5g_wifiname' /></td>
    </tr>
    <tr> 
        <td width="30%"><script>document.write(RosWizardDes["s3107"]);</script></td>
        <td width="70%"><input id='txt_5g_wifipwd' /></td>
    </tr>
</table>

<table width="100%" height = "50px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="wizard1_table2"> 
  <tr align="center">
    <td>
     <input id="Wizard_button_3_1_1" type="button" onClick="Wlan_Pre();"  value="Back" BindText="s3108" /> 
    <td>
    <td>
     <input id="Wizard_button_3_1_2" type="button" onClick="Wlan_Next();"  value="Continue" BindText="s0102" /> 
    <td>
  </tr>         
</table>

</div>

<div id="wizard_4_1" style="display:none">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><p style="text-align:center;color:green;font-size:30px"><script>document.write(RosWizardDes["s4100"]);</script></p><td>
	</tr>
	<tr height="20px">
		<td><td>
	</tr>	
	<tr align="center">
		<td>
      	<input name="Wizard_button2_2_button" id="Wizard_button_4_1_button" type="button" onClick="RedirectToRT();"  value="" BindText="s4101" /> 
		</td>
	</tr>
</table>

</div>

<div id="wizard_4_1_1" style="display:none">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr align="center">
        <td><p style="text-align:center;color:green;font-size:30px"><script>document.write(RosWizardDes["s4110"]);</script></p><td>
    </tr>
    <tr align="center">
        <td><p id="p_wait_sec" style="text-align:center;color:green;font-size:30px"><script>document.write(RosWizardDes["s4111a"]);</script> < 60 > <script>document.write(RosWizardDes["s4111b"]);</script></p><td>
    </tr>    
    <tr align="center">
        <td><p style="text-align:center;color:red;font-size:30px"><script>document.write(RosWizardDes["s4112"]);</script></p><td>
    </tr>
</table>

</div>

<div id="wizard_4_1_2" style="display:none">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><p style="text-align:center;color:green;font-size:30px"><script>document.write(RosWizardDes["s4113"]);</script></p><td>
	</tr>
	<tr height="20px">
		<td><td>
	</tr>	
	<tr align="center">
		<td>
      	<input name="Wizard_button2_2_button" id="Wizard_button_4_1_button" type="button" onClick="RedirectToRT();"  value="" BindText="s4101" /> 
		</td>
	</tr>
</table>

</div>

<div id="wizard_4_2" style="display:none">
<p style="text-align:center;font-size:30px;color:red"><B><script>document.write(RosWizardDes["s4202"]);</script></B></p>
<div style="border:thin dashed #000000;padding:20px;margin-top:20px;">
<p style="text-align:center"><script>document.write(RosWizardDes["s4200"]);</script></p>
</div>

<table width="100%" height = "100px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr align="center">
		<td>
      	<input name="Wizard_button_4_2_button" id="Wizard_button_4_2_button" type="button" onClick="JumpToIndex();" value="" BindText="s4201" /> 
		</td>
	</tr>
</table>
</div>

<div id="wizard_5_1" style="display:none">
<p style="text-align:center;font-size:30px;color:red"><B><script>document.write(RosWizardDes["s5101"]);</script></B></p>
<div style="border:thin dashed #000000;padding:20px;margin-top:20px;">
<p style="text-align:center"><script>document.write(RosWizardDes["s5100"]);</script></p>
</div>

<table width="100%" height = "50px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table> 

<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
		<div><img src="../../../images/lose_pon1.jpg" align="center"/></div>
	</td> 
  </tr> 
</table> 

<table width="100%" height = "50px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr align="center">
        <td>
          <input name="Wizard_button_5_1_0_button" id="btn_WaitOpticNormal" type="button" onClick="WaitOpticNormal();" value="" BindText="s0102" /> 
        </td>
        <td>
          <input name="Wizard_button_5_1_1_button" id="Wizard_button_5_1_1_button" type="button" onClick="JumpToIndex();" value="" BindText="s1202" /> 
        </td>        
    </tr>
</table>
</div>

<div id="wizard_5_2" style="display:none">
<p style="text-align:center;font-size:20px;color:red"><B><script>document.write(RosWizardDes["s5210"]);</script></B></p>
<div style="border:thin dashed #000000;padding:20px;margin-top:20px;">
<p style="text-align:center"><script>document.write(RosWizardDes["s5200"]);</script></p>
</div>

<table width="100%" height = "50px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
  <tr height="40px"> 
    <td width="25%"><script>document.write(RosWizardDes["s5201"]);</script></td>
	<td width="25%"><script>document.write(deviceInfos.HardwareVersion);</script></td>
	<td width="25%"><script>document.write(RosWizardDes["s5205"]);</script></td>
	<td width="25%"><script>document.write(deviceInfos.ModelName);</script></td>
  </tr>
  <tr height="40px"> 
    <td><script>document.write(RosWizardDes["s5202"]);</script></td>
	<td><script>document.write(deviceInfos.SoftwareVersion);</script></td>
    <td><script>document.write(RosWizardDes["s5206"]);</script></td>
	<td></td>
  </tr>
  <tr height="40px"> 
    <td><script>document.write(RosWizardDes["s5203"]);</script></td>
	<td>
        <script>
            if(PPPWanList!=null && PPPWanList.length>1)
            {
                document.write(PPPWanList[0].MACAddress);
            }
        </script>
    </td>
    <td><script>document.write(RosWizardDes["s5207"]);</script></td>
	<td><script>document.write(deviceInfos.SerialNumber);</script></td>
  </tr>
  <tr height="40px"> 
    <td><script>document.write(RosWizardDes["s5204"]);</script></td>
	<td><script>document.write(g_opticInfo);</script></td>
    <td><script>document.write(RosWizardDes["s5208"]);</script></td>
	<td>Not registered</td>
  </tr>   
</table>

<table width="100%" height = "50px" border="0" cellspacing="1" cellpadding="0"> 
  <tr> 
    <td align="center"> 
	</td> 
  </tr> 
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr align="center">
		<td>
      	<input name="Wizard_button_5_2_0_button" id="Wizard_button_5_2_0_button" type="button" onClick="JumpToIndex();" value="" BindText="s1202" /> 
		</td>
	</tr>
</table>

</div>
<script>
ParseBindTextByTagName(RosWizardDes, "div",   1);
ParseBindTextByTagName(RosWizardDes, "input", 2);
</script> 

</body>
</html>
