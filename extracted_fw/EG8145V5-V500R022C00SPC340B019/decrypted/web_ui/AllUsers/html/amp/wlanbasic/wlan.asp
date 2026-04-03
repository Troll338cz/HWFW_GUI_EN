<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>wireless basic configure</title>
<script language="JavaScript" type="text/javascript">
    
var curUserType='<%HW_WEB_GetUserType();%>';
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var sysUserType='0';
var sptUserType ='1';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var wep1password;
var wep2password;
var wep3password;
var wep4password;
var wpapskpassword;
var radiuspassword;
var wep1PsdModFlag = false;
var wep2PsdModFlag = false;
var wep3PsdModFlag = false;
var wep4PsdModFlag = false;
var pskPsdModFlag = false;
var radPsdModFlag = false;
var wepOrigLen = 0;
var possibleChannels = "";
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var HiLinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var isShowWpa3Eap = 0;

var forbidAddSsid = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_ADD_OR_DEL_SSID_FORBIDDON);%>';
var maxStaNum = '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_STA_NUM.UINT32);%>';
var wallMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_WallModeForChina.Enable);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var scnFT = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SCN_ROAM);%>';
var modifyFlag = '<%HW_WEB_GetFeatureSupport(FT_UNICOM_MODIFYSSIDNAME);%>';
var isFirstFocus_wep1 = true;
var isCheckDfsSignal = '<%HW_WEB_GetDfsSignal();%>';

function onFocusToclearPwd_wep1()
{
    if (isFirstFocus_wep1 && curUserType == sysUserType)
    {
        setText('wlKeys1', "");

        isFirstFocus_wep1 = false;
    }    
}

var isFirstFocus_wep2 = true;
function onFocusToclearPwd_wep2()
{
    if (isFirstFocus_wep2 && curUserType == sysUserType)
    {
        setText('wlKeys2', "");

        isFirstFocus_wep2 = false;
    }    
}

var isFirstFocus_wep3 = true;
function onFocusToclearPwd_wep3()
{
    if (isFirstFocus_wep3 && curUserType == sysUserType)
    {
        setText('wlKeys3', "");

        isFirstFocus_wep3 = false;
    }    
}

var isFirstFocus_wep4 = true;
function onFocusToclearPwd_wep4()
{
    if (isFirstFocus_wep4 && curUserType == sysUserType)
    {
        setText('wlKeys4', "");

        isFirstFocus_wep4 = false;
    }    
}

var isFirstFocus_psk = true;
function onFocusToclearPwd_psk()
{
    if (isFirstFocus_psk && curUserType == sysUserType)
    {
        setText('wlWpaPsk', "");

        isFirstFocus_psk = false;
    }    
}

var isFirstFocus_radius = true;
function onFocusToclearPwd_radius()
{
    if (isFirstFocus_radius && curUserType == sysUserType)
    {
        setText('wlRadiusKey', "");

        isFirstFocus_radius = false;
    }    
}

function GetLanguageDesc(Name)
{
    return cfg_wlancfgdetail_language[Name];
}

function getInstIdByDomain(domain)
{
    if ('' != domain)
    {
        return parseInt(domain.charAt(domain.length - 1));    
    }
}

var TwoSsidCustomizeGroup = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GZCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_NXCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_HUNCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GSCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SZCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_QHCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_HLJCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JXCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_XJCT);%>'
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JLCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_HAINCT);%>'
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_YNCT);%>'
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_CQCT);%>';

var CTCFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_CTC);%>';
var gzcmccFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_GZCMCC);%>';
var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';
var BjcuFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_BJCU);%>';
var WapiFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WAPI);%>';
var ShowFirstSSID = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SHOW_FIRST_SSID);%>';

var CfgMode ='<%HW_WEB_GetCfgMode();%>';

var scnVar = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.Enable);%>';

if (modifyFlag == 1) {
    BjcuFlag = 0;
}

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var wlanpage;
if (location.href.indexOf("wlan.asp??") > 0)
{
    wlanpage = location.href.split("??")[1]; 
    top.WlanBasicPage = wlanpage;
}

wlanpage = top.WlanBasicPage;

initWlanCap(wlanpage);
function ShowOrHideText(checkBoxId, passwordId, textId, value)
{
    if (1 == getCheckVal(checkBoxId))
    {
        setDisplay(passwordId, 1);
        setDisplay(textId, 0);
    }
    else
    {
        setDisplay(passwordId, 0);
        setDisplay(textId, 1);
    }
}

function stWlan(domain,name,enable,ssid,wlHide,DeviceNum,wmmEnable,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                KeyIndex,EncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,WPARekey,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable,
                X_HW_WAPIEncryptionModes,X_HW_WAPIAuthenticationMode,X_HW_WAPIServer,X_HW_WAPIPort)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.wlHide = wlHide;
    this.DeviceNum = DeviceNum;
    this.wmmEnable = wmmEnable;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.KeyIndex = KeyIndex;
    this.EncypBit = EncryptionLevel;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_WPAand11iAuthenticationMode = X_HW_WPAand11iAuthenticationMode;
    this.WPARekey = WPARekey;
    this.RadiusServer = RadiusServer;
    this.RadiusPort = RadiusPort;
    this.RadiusKey = RadiusKey;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.X_HW_WAPIEncryptionModes = X_HW_WAPIEncryptionModes;
    this.X_HW_WAPIAuthenticationMode = X_HW_WAPIAuthenticationMode;
    this.X_HW_WAPIServer = X_HW_WAPIServer;
    this.X_HW_WAPIPort = X_HW_WAPIPort;
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

function stWpsPin(domain, X_HW_ConfigMethod, DevicePassword, X_HW_PinGenerator, Enable)
{
    this.domain = domain;
    this.X_HW_ConfigMethod = X_HW_ConfigMethod;
    this.DevicePassword = DevicePassword;
    this.X_HW_PinGenerator = X_HW_PinGenerator;
    this.Enable = Enable;
}

function stMaxWLAN(idx, lang)
{
    this.MAX_ID = idx;
    this.MAX_ID_LANG = lang;
}

function stIndexMapping(index,portIndex)
{
    this.index = index;
    this.portIndex = portIndex;
}

var SsidNum = '<%HW_WEB_GetSsidNum();%>';
var SsidNum2g = SsidNum.split(',')[0];
var SsidNum5g = SsidNum.split(',')[1];

var enbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';

var currentPageURLFlag;
if (location.href.indexOf("wlan.asp?") > 0)
{
	currentPageURLFlag = document.URL.split('?')[1];
	top.currentPageURLFlag = currentPageURLFlag;
}
currentPageURLFlag = top.currentPageURLFlag;

var wlanpage;
if (DoubleFreqFlag == 1) {
    if (location.href.indexOf("wlan.asp?") > 0) {
        wlanpage = document.URL.split('?')[2]; // 2G 5G
        top.WlanBasicPage = wlanpage;
    }
    wlanpage = top.WlanBasicPage;

    if (wlanpage == '2G') {
        enbl = enbl2G;
    } else if (wlanpage == '5G') {
        enbl = enbl5G;
    }
}

var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort,stWlan);%>;

var wlanArrLen = WlanArr.length - 1;

if (curWebFrame == 'frame_CMCC')
{
    if (1 == TwoSsidCustomizeGroup)
    {
        if (wlanArrLen >= 2)
        {
            wlanArrLen = 2;
        }
    }
    else
    {
        if (wlanArrLen >= 1)
        {
            wlanArrLen = 1;
        }
    }
}
var WlanCus = '<%HW_WEB_GetWlanCus();%>';
var WpsCapa = WlanCus.split(',')[0];

for(i=0; i <wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
if (null != g_keys)
{
    wep1password = g_keys[0];
    wep2password = g_keys[1];
    wep3password = g_keys[2];
    wep4password = g_keys[3];
}

var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;

var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,X_HW_ConfigMethod|DevicePassword|X_HW_PinGenerator|Enable,stWpsPin,STATUS);%>;

var wlanMac = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_WlanMac);%>';

var ssidIdx = -1;
var ssidAccessAttr = 'Subscriber';
var AddFlag = true;
var currentWlan = new stWlan();
var defaultWlan = new stWlan();
var maxWLAN     = new stMaxWLAN(4,'four');



function getWlanPortNumber(name)
{
    var length = name.length;
    var number;
    var str = parseInt(name.charAt(length-1));
    return str;
}

var WlanMap = new Array();
var j = 0;
for (var i = 0; i < Wlan.length; i++)
{
    var portIndex = getWlanPortNumber(Wlan[i].name);
    var wlanInst = getWlanInstFromDomain(Wlan[i].domain);
    
    if (1 == isSsidForIsp(wlanInst))
    {
         continue;
    }
    else
    {
		if (DoubleFreqFlag == 1)
		{
			if (wlanpage == '2G' && portIndex < 4)
			{
				WlanMap[j] = new stIndexMapping(i,portIndex);
				j++;
			}  

			if (wlanpage == '5G' && portIndex >= 4)
			{
				WlanMap[j] = new stIndexMapping(i,portIndex);
				j++;
			}
		}
		else
		{
			WlanMap[j] = new stIndexMapping(i,portIndex);
			j++;
		}
    }
}

if (WlanMap.length >= 2) {
    for (var i = 0; i < WlanMap.length-1; i++) {
        for( var j = 0; j < WlanMap.length - (i + 1); j++) {
            if (WlanMap[j + 1].portIndex < WlanMap[j].portIndex) {
                var middle = WlanMap[j+1];
                WlanMap[j+1] = WlanMap[j];
                WlanMap[j] = middle;
            }
        }
    }
}


function getIndexFromPort(index)
{
    for (var i = 0; i < WlanMap.length; i++)
    {
        if (index == WlanMap[i].portIndex)
        {
            return WlanMap[i].index;
        }
    }
}

function getPortFromIndex(index)
{
    for (var i = 0; i < WlanMap.length; i++)
    {
        if (index == WlanMap[i].index)
        {
            return WlanMap[i].portIndex;
        }
    }
} 

function ValidateChecksum(PIN) 
{
    var accum = 0;
    var iRet;
    accum += 3 * (parseInt(PIN / 10000000) % 10); 
    accum += 1 * (parseInt(PIN / 1000000) % 10); 
    accum += 3 * (parseInt(PIN / 100000) % 10);
    accum += 1 * (parseInt(PIN / 10000) % 10);
    accum += 3 * (parseInt(PIN / 1000) % 10);
    accum += 1 * (parseInt(PIN / 100) % 10);
    accum += 3 * (parseInt(PIN / 10) % 10);
    accum += 1 * (parseInt(PIN / 1) % 10);
    if (0 == (accum % 10))
    {
        iRet = 0;                                 
    }
    else
    {
        iRet = 1;
    }
    return iRet;
} 

function computeDefaultPin()
{
    var pin = 0;
    var datavalue = 0;
    var wlandomain = Wlan[ssidIdx].domain;
    var wlanId = wlandomain.charAt(wlandomain.length - 1);
    
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "WlanWpsPin.asp?&1=1",
            data :"wlanid="+wlanId,
            success : function(data) {
            datavalue = data.split("\r");
            }
        });
    
    pin = datavalue[0];
    return pin;
}

function computePinInteger()
{
    var defaultpin = 0;
    var datavalue = 0;
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "WlanWpsPin.asp?&1=1",
            data :"wlanid="+0,
            success : function(data) {
            datavalue = data.split("\r");
            }
        });
    
    defaultpin = datavalue[0];
    return defaultpin;
}

function DisableButtons()
{
	setDisable('BtnAdd', 1);
    setDisable('BtnRemove', 1);
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	setDisable('btnApplySubmit2', 1);
    setDisable('cancelButton', 1);
}

function getEncryLevel(encrylevel)
{
    var level = '';
    for (var i = 0; i < encrylevel.length; i++)
    {
        if (encrylevel.charAt(i) != '-')
        {
            level += encrylevel.charAt(i);
        }
        else
        {
            break;
        }
    }
    return level;
}

function addwlgModeOption()
{
    var len = document.forms[0].wlgMode.options.length;    
    var wlgmode = getSelectVal('wlgMode'); 
    var isshow11n = 0;    
    var isshow11ac = 0;
    var isshow11ax = cap11ax;
    var index = 0;

    for (i = 0; i < Wlan.length; i++) 
    {
         var BeaconType = Wlan[i].BeaconType;    
       var BasicEncryptionModes =  Wlan[i].BasicEncryptionModes;       
       var WPAEncryptionModes  = Wlan[i].WPAEncryptionModes;
       var IEEE11iEncryptionModes = Wlan[i].IEEE11iEncryptionModes;
       var X_HW_WPAand11iEncryptionModes = Wlan[i].X_HW_WPAand11iEncryptionModes;
		var name = Wlan[i].name;
		var portIndex = parseInt(name.charAt(length-1));
        if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
        {
            if (portIndex < SsidPerBand)
            {
                continue;
            }
        }

        if ("2G" == wlanpage)
        {
            if (portIndex >= SsidPerBand)
            {
                continue;
            }                    
        }
       
       
        if ((BeaconType == "Basic") && (BasicEncryptionModes == "WEPEncryption")) {
           isshow11n += 1;
           isshow11ac += 1;  
        } else if ((BeaconType =="WPA" ) && ((WPAEncryptionModes == "TKIPEncryption") || (WPAEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
        } else if (((BeaconType =="11i") || (BeaconType =="WPA2")) && ((IEEE11iEncryptionModes == "TKIPEncryption") || (IEEE11iEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
        } else if (((BeaconType =="WPAand11i") || (BeaconType =="WPA/WPA2")) && ((X_HW_WPAand11iEncryptionModes == "TKIPEncryption")||(X_HW_WPAand11iEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
        } else if (((BeaconType == "WPA3") || (BeaconType == "WPA2/WPA3")) && ((X_HW_WPAand11iEncryptionModes == "TKIPEncryption") || (X_HW_WPAand11iEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
        }

        if (Wlan[i].wmmEnable == 0) {
            isshow11n += 1;
        }
    }

    for (i = 0; i < len; i++) {
        document.forms[0].wlgMode.remove(0);
    }

    if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
        if (isshow11n > 0) {
            document.forms[0].wlgMode[0] = new Option("802.11a", "11a");
            document.forms[0].wlgMode[1] = new Option("802.11a/n", "11na");
            index = 2;
            if (isshow11ac == 0) {
                document.forms[0].wlgMode[2] = new Option("802.11a/n/ac", "11ac");
                index = 3;
            }
        } else {
            document.forms[0].wlgMode[0] = new Option("802.11a", "11a");
            document.forms[0].wlgMode[1] = new Option("802.11n", "11n");  
            document.forms[0].wlgMode[2] = new Option("802.11a/n", "11na"); 
            index = 3;
            if (isshow11ac == 0) {
                document.forms[0].wlgMode[3] = new Option("802.11a/n/ac", "11ac");
                index = 4;
            }
        }

        if (isshow11ax == 1) {
            document.forms[0].wlgMode[index] = new Option("802.11a/n/ac/ax", "11ax");
        }
    } else {
        if (isshow11n > 0) {
            document.forms[0].wlgMode[0] = new Option("802.11b", "11b");
            document.forms[0].wlgMode[1] = new Option("802.11g", "11g");
            document.forms[0].wlgMode[2] = new Option("802.11b/g", "11bg");
            document.forms[0].wlgMode[3] = new Option("802.11b/g/n", "11bgn");
            index = 4;
        } else {
            document.forms[0].wlgMode[0] = new Option("802.11b", "11b");
            document.forms[0].wlgMode[1] = new Option("802.11g", "11g");
            document.forms[0].wlgMode[2] = new Option("802.11n", "11n");
            document.forms[0].wlgMode[3] = new Option("802.11b/g", "11bg");
            document.forms[0].wlgMode[4] = new Option("802.11b/g/n", "11bgn");
            index = 5;
        }
        if (isshow11ax == 1) {
            document.forms[0].wlgMode[index] = new Option("802.11b/g/n/ax", "11ax");
        }
    }
	
    setSelect('wlgMode',wlgmode);
}

function addAuthModeOption()
{
    var len = document.forms[0].wlAuthMode.options.length;    
    var authMode = getSelectVal('wlAuthMode'); 
    var mode = WlanWifi.mode;
    var index = 0;

    for (i = 0; i < len; i++) {
        document.forms[0].wlAuthMode.remove(0);
    }

    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_open'], "open"); 
    index++;

    if ((mode != "11n") && (mode != "11ac")) {
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_shared'], "shared");
        index++;
    }

    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpapsk'], "wpa-psk");
    index++;
    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa2psk'], "wpa2-psk");
    index++;
    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], "wpa/wpa2-psk");
    index++;

    if (capWpa3 == 1) {
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa3psk'], "wpa3-psk");
        index++;
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk'], "wpa2/wpa3-psk");
        index++;
    }

    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa'], "wpa");
    index++;
    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa2'], "wpa2");
    index++;
    document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpawpa2'], "wpa/wpa2");
    index++;

    if ((capWpa3 == 1) && (isShowWpa3Eap == 1)) {
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa3'], "wpa3");
        index++;
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa2wpa3'], "wpa2/wpa3");
        index++;
    }

    if (((mode != "11n") && (mode != "11ac")) && (WapiFlag == 1)) {
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wapi_psk'], "wapi-psk");
        index++;
        document.forms[0].wlAuthMode[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wapi'], "wapi");
        index++;
    }
    
    setSelect('wlAuthMode',authMode);
}

function addWapiEncryMethodOption()
{
    var len = document.forms[0].wlEncryption.options.length;
    for (i = 0; i < len; i++)
    {
        document.forms[0].wlEncryption.remove(0);
    }
    document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_sms4'], "SMS4");
            
}

function addEncryMethodOption(authMode)
{
    var len = document.forms[0].wlEncryption.options.length;
    var mode = WlanWifi.mode;
    
    for (i = 0; i < len; i++) {
        document.forms[0].wlEncryption.remove(0);
    }
    
    if (authMode == "open") {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");

		if ((mode == "11n") || ("11ac" == mode)) {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
        } else {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
            document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
        }        
    } else if (authMode == "shared") {
        if ((mode != "11n") && (mode != "11ac")) {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
        }           
    } else if (authMode == "wpa3") {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
    } else {
        if (mode == "11n") {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
        } else {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
            document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
            document.forms[0].wlEncryption[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
        }
    }
}

function HideWpsConfig()
{
    setDisplay("wpsPinNumber",0);
    setDisplay("wpsPinNumVal",0);
    setDisplay("wpsAPPinNumVal",0);
    setDisplay('wpsPBCButton',0);
}

function displayWpsConfig()
{
    if (IsWpsConfigDisplay() == false)
    {
        HideWpsConfig();
        return;
    }

    setDisplay('wpsPinNumber',1);
    setCheck('wlWPSEnable',wpsPinNum[ssidIdx].Enable);
    
    if (wpsPinNum[ssidIdx].X_HW_ConfigMethod == 'Lable')
    {
        if (wpsPinNum[ssidIdx].X_HW_PinGenerator == 'AP')
        {
            if (scnFT == 1) {
                if (scnVar == 1) {
                    setDisplay('wpsAPPinNumVal', 0);
                    setDisplay('wpsPBCButton', 1);
                    setDisable('btnWpsPBC', 1);
                } else {
                    setDisplay('wpsAPPinNumVal', 1);
                }
            } else {
                setDisplay('wpsAPPinNumVal', 1);
            }
            setSelect('wlWPSMode','AP-PIN');
            setDisplay('wpsPBCButton',0);
            setDisplay('wpsPinNumVal',0);
            setText('wlSelfPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
        else
        {
            if (scnFT == 1) {
                if (scnVar == 1) {
                    setDisplay('wpsPinNumVal', 0);
                    setDisplay('wpsPBCButton', 1);
                    setDisable('btnWpsPBC', 1);
                } else {
                    setDisplay('wpsPinNumVal', 1);
                }
            } else {
                setDisplay('wpsPinNumVal', 1);
            }
            setSelect('wlWPSMode','PIN');
            setDisplay('wpsPBCButton',0);
            setDisplay('wpsAPPinNumVal',0);
            setText('wlClientPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
    }
    else
    {
        setSelect('wlWPSMode','PBC');
        
        if (getSelectVal('wlWPSMode') == 'PBC')
        {
            setSelect('wlWPSMode','PBC');
            setDisplay('wpsPBCButton',1);
            setDisplay('wpsPinNumVal',0);
            setDisplay('wpsAPPinNumVal',0);

            var wpsEnable = wpsPinNum[ssidIdx].Enable;
            if (1 == wpsEnable)
            {
                setDisable('btnWpsPBC', 0);
            }
            else if (0 == wpsEnable)
            {
                setDisable('btnWpsPBC', 1);
            }
        }
        else
        {
            setSelect('wlWPSMode','AP-PIN');
            setDisplay('wpsPBCButton',0);
            setDisplay('wpsAPPinNumVal',1);
            setDisplay('wpsPinNumVal',0);

            var wpsDefaultPIN = computeDefaultPin()+'';
            setText('wlSelfPinNum',changeToPinNumber(wpsDefaultPIN,8));
        }  
    }
}

function WPSEnable()
{
    var wpsEnable = getCheckVal('wlWPSEnable');
    if (1 == wpsEnable)
    {
        setDisable('btnWpsPBC', 0);
    }
    else if (0 == wpsEnable)
    {
        setDisable('btnWpsPBC', 1);
    }
}

function keyIndexChange(iSelect)
{
    var keyIndex;

    if (1 != TelMexFlag)
    {
        return;
    }
    
    if (0 != iSelect)
    {
        keyIndex = iSelect;
    }
    else
    {
        keyIndex = getSelectVal('wlKeyIndex');
    }    
    
    setDisable("wlKeys1", 1);
    setDisable("twlKeys1", 1); 
    setDisable("wlKeys2", 1);
    setDisable("twlKeys2", 1);
    setDisable("wlKeys3", 1);
    setDisable("twlKeys3", 1);
    setDisable("wlKeys4", 1);
    setDisable("twlKeys4", 1);
    setDisable("wlKeys"+keyIndex, 0);
    setDisable("twlKeys"+keyIndex, 0);
}

function authModeChange()
{   
    setDisplay("wlEncryMethod",0);
    setDisplay("keyInfo", 0);
    setDisplay("wlRadius", 0);
    setDisplay("wpaGTKRekey", 0);
    setDisplay("wpaPreShareKey", 0);
    setDisplay("wpsPinNumber",0);
    setDisplay("wpsPinNumVal",0);
    setDisplay("wpsAPPinNumVal",0);
    setDisplay('wpsPBCButton',0);
    setDisable("wlEncryption",0);
    setDisplay('wlWapi',0); 

    
    var authMode = getSelectVal('wlAuthMode');
    
    switch (authMode)
    {
        case 'open':
            setDisplay('wlEncryMethod',1);
            addEncryMethodOption(authMode);
            if (AddFlag == false)
            {
                setSelect('wlEncryption',Wlan[ssidIdx].BasicEncryptionModes);
                if ((Wlan[ssidIdx].BasicEncryptionModes == 'None') || (WlanWifi.mode == '11n'))
                {
                    setDisplay('keyInfo', 0);
                }
                else
                {                      
                    var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
                    setDisplay('keyInfo', 1); 
                    setSelect('wlKeyBit', parseInt(level)+24);
                    
                    if (1 == TelMexFlag)
                    {
                        keyIndexChange(Wlan[ssidIdx].KeyIndex);
                    }
                    
                    setSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
                    setText('wlKeys1',g_keys[ssidIdx * 4].value); 
                    wep1password = g_keys[ssidIdx * 4].value; 
                    setText('twlKeys1',g_keys[ssidIdx * 4].value);
                    setText('wlKeys2',g_keys[ssidIdx * 4+1].value);
                    wep2password = g_keys[ssidIdx * 4+1].value; 
                    setText('twlKeys2',g_keys[ssidIdx * 4+1].value);
                    setText('wlKeys3',g_keys[ssidIdx * 4+2].value);
                    wep3password = g_keys[ssidIdx * 4+2].value; 
                    setText('twlKeys3',g_keys[ssidIdx * 4+2].value);
                    setText('wlKeys4',g_keys[ssidIdx * 4+3].value);
                    wep4password = g_keys[ssidIdx * 4+3].value; 
                    setText('twlKeys4',g_keys[ssidIdx * 4+3].value);
                }
            }
            else
            {
                setDisplay('keyInfo', 0);
                setSelect('wlEncryption','None');
                setText('wlKeys1','');
                wep1password = ''; 
                setText('twlKeys1','');
                setText('wlKeys2','');
                wep2password = ''; 
                setText('twlKeys2','');
                setText('wlKeys3','');
                wep3password = ''; 
                setText('twlKeys3','');
                setText('wlKeys4','');
                wep4password = ''; 
                setText('twlKeys4','');
            }
            break;
            
        case 'shared':
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            var mode = WlanWifi.mode;

            if ((mode == "11n") || ("11ac" == mode)) {
                setDisplay('wlEncryMethod',0);
                setDisplay('keyInfo', 0);
            } else {
                setDisplay('wlEncryMethod',1); 
                setDisplay('keyInfo', 1);
                addEncryMethodOption(authMode);
                if (AddFlag == false)
                {
                    setSelect('wlKeyBit', parseInt(level)+24);
                
                    if (1 == TelMexFlag)
                    {
                      keyIndexChange(Wlan[ssidIdx].KeyIndex);
                    }
                
                    setSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
                    setText('wlKeys1',g_keys[ssidIdx * 4].value);
                    wep1password = g_keys[ssidIdx * 4].value; 
                    setText('twlKeys1',g_keys[ssidIdx * 4].value);
                    setText('wlKeys2',g_keys[ssidIdx * 4+1].value);
                    wep2password = g_keys[ssidIdx * 4+1].value; 
                    setText('twlKeys2',g_keys[ssidIdx * 4+1].value);
                    setText('wlKeys3',g_keys[ssidIdx * 4+2].value);
                    wep3password = g_keys[ssidIdx * 4+2].value; 
                    setText('twlKeys3',g_keys[ssidIdx * 4+2].value);
                    setText('wlKeys4',g_keys[ssidIdx * 4+3].value);
                    wep4password = g_keys[ssidIdx * 4+3].value; 
                    setText('twlKeys4',g_keys[ssidIdx * 4+3].value);
                }
                else
                {
                    setSelect('wlKeyBit', 128);
                    setText('wlKeys1','');
                    wep1password = ''; setText('twlKeys1','');
                    setText('wlKeys2','');
                    wep2password = ''; setText('twlKeys2','');
                    setText('wlKeys3','');
                    wep3password = ''; setText('twlKeys3','');
                    setText('wlKeys4','');
                    wep4password = ''; setText('twlKeys4','');
                }
            }                  
            break;

        case 'wpa':
        case 'wpa2':
        case 'wpa/wpa2':
        case 'wpa3':
        case 'wpa2/wpa3':
            setDisplay('wlEncryMethod',1);
            if ((authMode == "wpa3") || (authMode == "wpa2/wpa3")) {
                addEncryMethodOption("wpa3");
            } else {
                addEncryMethodOption("enterprise");
            }
            setDisplay('wlRadius', 1);
            setDisplay('wpaGTKRekey', 1);
            if (AddFlag == false)
            {
                if (authMode == 'wpa')
                {
                    setSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
                }
                else if (authMode == 'wpa2')
                {
                    setSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
                }
                else
                {
                    setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
                }
                setText('wlRadiusIPAddr',Wlan[ssidIdx].RadiusServer);
                setText('wlRadiusPort',Wlan[ssidIdx].RadiusPort);
                setText('wlRadiusKey',Wlan[ssidIdx].RadiusKey);
                radiuspassword = Wlan[ssidIdx].RadiusKey; 
                setText('twlRadiusKey',Wlan[ssidIdx].RadiusKey);
                setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey); 
            }
            else
            {
                setText('wlRadiusIPAddr','');
                setText('wlRadiusPort','');
                setText('wlRadiusKey','');
                radiuspassword = ''; 
                setText('twlRadiusKey','');
                setText('wlWpaGtkRekey',''); 
            }
            break;

        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
        case 'wpa3-psk':
        case 'wpa2/wpa3-psk':
            setDisplay('wlEncryMethod',1);
            if ((authMode == "wpa3-psk") || (authMode == "wpa2/wpa3-psk")) {
                document.getElementById("hidewlWpaPsk_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
                addEncryMethodOption("wpa3");
            } else {
                document.getElementById("hidewlWpaPsk_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote'];
                addEncryMethodOption("psk");
            }
            setDisplay('wpaPreShareKey', 1);
            setDisplay('wpaGTKRekey', 1);
            document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wpa_psk");
            if (AddFlag == false)
            {
                if (authMode == 'wpa-psk')
                {
                    setSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
                }
                else if (authMode == 'wpa2-psk')
                {
                    setSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
                }
                else
                {
                    setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
                }
                setText('wlWpaPsk',wpaPskKey[ssidIdx].value);
                wpapskpassword = wpaPskKey[ssidIdx].value;
                setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
                setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey); 
                
                displayWpsConfig();
            }
            else
            {
                setText('wlWpaPsk','');
                setText('wlWpaGtkRekey','');
                wpapskpassword = '';
                setText('twlWpaPsk','');
                
                setCheck('wlWPSEnable',0);
                setDisable('btnWpsPBC', 1);
                if (Wlan.length >= 1)
                {
                    setSelect('wlWPSMode','AP-PIN');
                    setDisplay('wpsPBCButton',0);
                    setDisplay('wpsAPPinNumVal',1);
                    setDisplay('wpsPinNumVal',0);
                    
                    var wpsDefaultPIN = computeDefaultPin()+'';
                    setText('wlSelfPinNum',changeToPinNumber(wpsDefaultPIN,8));
                }
                else
                {
                    setSelect('wlWPSMode','PBC');
                    setDisplay('wpsPBCButton',1);
                    setDisplay('wpsPinNumVal',0);
                    setDisplay('wpsAPPinNumVal',0);
                }
            }
            break;
        case 'wapi-psk':
            setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
            document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wapi_psk");
            setDisable('wlEncryption',1);
            setDisplay("wpaPreShareKey", 1);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            wpapskpassword = wpaPskKey[ssidIdx].value;
            if(AddFlag == false)
            {
                setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
            }
            break;
        case 'wapi':
            setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
            setDisable('wlEncryption',1);
            setDisplay('wlWapi',1); 
            setText('wapiIPAddr',Wlan[ssidIdx].X_HW_WAPIServer);
            setText('wapiPort',Wlan[ssidIdx].X_HW_WAPIPort);
            if(AddFlag == false)
            {
                setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
            }
            break;
        default:
            break;
    }
    
    addwlgModeOption();
} 

function isValidKey(val, size)
{
    var len = val.length;
    var dbSize = size * 2;

    if (isValidAscii(val) != '') {
        return false;
    }

    if (len == size) {
        return true;
    }

    if (len == dbSize) {
        for (i = 0; i < dbSize; i++) {
            if (isHexaDigit(val.charAt(i)) == false) {
                return false;
            }
        }
        return true;
    }

    return false;
}

function wlPinModeChange()
{
    var wpsEnable = wpsPinNum[ssidIdx].Enable;
    if (1 == wpsEnable)
    {
        setDisable('btnWpsPBC', 0);
    }
    else if (0 == wpsEnable)
    {
        setDisable('btnWpsPBC', 1);
    }

    if (getSelectVal('wlWPSMode') == 'PBC')
    {
        setDisplay('wpsPBCButton',1);
        setDisplay('wpsPinNumVal',0);
        setDisplay('wpsAPPinNumVal',0);
    }
    else if (getSelectVal('wlWPSMode') == 'PIN')
    {
        setDisplay('wpsPBCButton',0);
        setDisplay('wpsPinNumVal',1);
        setDisplay('wpsAPPinNumVal',0);
        
        if ((wpsPinNum[ssidIdx].X_HW_ConfigMethod == 'Lable') && (wpsPinNum[ssidIdx].X_HW_PinGenerator == 'STA'))
        {
            setText('wlClientPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
        else
        {
            var wpsDefaultPIN = computeDefaultPin()+'';
            setText('wlClientPinNum',changeToPinNumber(wpsDefaultPIN,8));
        }
    }
    else
    {
        setDisplay('wpsPBCButton',0);
        setDisplay('wpsAPPinNumVal',1);
        setDisplay('wpsPinNumVal',0);
        
        if ((wpsPinNum[ssidIdx].X_HW_ConfigMethod == 'Lable') && (wpsPinNum[ssidIdx].X_HW_PinGenerator == 'AP'))
        {
            setText('wlSelfPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
        else
        {
            var wpsDefaultPIN = computeDefaultPin()+'';
            setText('wlSelfPinNum',changeToPinNumber(wpsDefaultPIN,8));
        }
    }   
}

function OnRegeneratePIN()
{
    var number = computePinInteger();
    setText('wlSelfPinNum', changeToPinNumber(number,8));
}

function OnResetPIN()
{
    var wpsDefaultPIN = computeDefaultPin()+'';
    setText('wlSelfPinNum',changeToPinNumber(wpsDefaultPIN,8));
}

function displaywepkey()
{   
    if (AddFlag == false)
    {
        setText('wlKeys1',g_keys[ssidIdx * 4].value);
        wep1password = g_keys[ssidIdx * 4].value; 
        setText('twlKeys1',g_keys[ssidIdx * 4].value);
        setText('wlKeys2',g_keys[ssidIdx * 4 + 1].value);
        wep2password = g_keys[ssidIdx * 4+1].value; 
        setText('twlKeys2',g_keys[ssidIdx * 4+1].value);
        setText('wlKeys3',g_keys[ssidIdx * 4 + 2].value);
        wep3password = g_keys[ssidIdx * 4+2].value; 
        setText('twlKeys3',g_keys[ssidIdx * 4+2].value);
        setText('wlKeys4',g_keys[ssidIdx * 4 + 3].value);
        wep4password = g_keys[ssidIdx * 4+3].value; 
        setText('twlKeys4',g_keys[ssidIdx * 4+3].value);
    }
    else
    {
        setText('wlKeys1','');
        wep1password = ''; 
        setText('twlKeys1', '');
        setText('wlKeys2','');
        wep2password = ''; 
        setText('twlKeys2', '');
        setText('wlKeys3','');
        wep3password = ''; 
        setText('twlKeys3', '');
        setText('wlKeys4','');
        wep4password = ''; 
        setText('twlKeys4', '');
    }
}

function InitEapAuthShow(wlAuthMode, wlEncryption, authMode) {
    setDisplay("wlEncryMethod", 1);
    addEncryMethodOption(authMode);
    setDisplay("wlRadius", 1);
    setDisplay("wpaGTKRekey", 1);
    setSelect('wlAuthMode', wlAuthMode);
    setSelect('wlEncryption', wlEncryption);
    setText('wlRadiusIPAddr', Wlan[ssidIdx].RadiusServer);
    setText('wlRadiusPort', Wlan[ssidIdx].RadiusPort);
    setText('wlRadiusKey', Wlan[ssidIdx].RadiusKey);
    radiuspassword = Wlan[ssidIdx].RadiusKey; 
    setText('twlRadiusKey', Wlan[ssidIdx].RadiusKey);
    setText('wlWpaGtkRekey', Wlan[ssidIdx].WPARekey);
}

function InitPskAuthShow(wlAuthMode, wlEncryption, authMode) {
    setDisplay("wlEncryMethod", 1);
    addEncryMethodOption(authMode);
    setDisplay("wpaPreShareKey", 1);
    setDisplay("wpaGTKRekey", 1);
    setSelect('wlAuthMode', wlAuthMode);
    setSelect('wlEncryption', wlEncryption);
    setText('wlWpaPsk', wpaPskKey[ssidIdx].value); 
    wpapskpassword = wpaPskKey[ssidIdx].value; 
    setText('twlWpaPsk', wpaPskKey[ssidIdx].value);
    setText('wlWpaGtkRekey', Wlan[ssidIdx].WPARekey);

    displayWpsConfig();
}

function beaconTypeChange(mode)
{
    setDisplay('wlEncryMethod',0);
    setDisplay('keyInfo', 0);
    setDisplay('wlRadius', 0);
    setDisplay('wpaGTKRekey', 0);
    setDisplay('wpaPreShareKey', 0);
    setDisplay('wpsPinNumber',0);
    setDisplay('wpsPinNumVal',0);
    setDisplay('wpsAPPinNumVal',0);
    setDisplay('wpsPBCButton',0);
    setDisplay('wlWapi',0);

    if (mode == 'Basic')
    {
        var BasicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
        var BasicEncryptionModes = Wlan[ssidIdx].BasicEncryptionModes;
        setDisplay('wlEncryMethod',1);
        if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem'))
        {
            addEncryMethodOption('open');
            setSelect('wlAuthMode','open');
            setSelect('wlEncryption',BasicEncryptionModes);
            if (BasicEncryptionModes == 'None')
            {
                setDisplay('keyInfo', 0);
            } 
            else
            {
                var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
                setDisplay('keyInfo', 1);
                setSelect('wlKeyBit', parseInt(level)+24);
                setSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
                displaywepkey();
            }
        }
        else
        {
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            addEncryMethodOption('shared');
            setDisplay('keyInfo', 1);
            setSelect('wlAuthMode','shared');
            setSelect('wlEncryption',BasicEncryptionModes);
            setSelect('wlKeyBit', parseInt(level)+24);
            setSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
            displaywepkey();
        }
    } else if (mode == 'WPA') {
        if (Wlan[ssidIdx].WPAAuthenticationMode == 'EAPAuthentication') {
            InitEapAuthShow('wpa', Wlan[ssidIdx].WPAEncryptionModes, "enterprise");
        } else {
            InitPskAuthShow('wpa-psk', Wlan[ssidIdx].WPAEncryptionModes, "wpa-psk");
        }
    } else if ((mode == '11i') || (mode == 'WPA2')) {
        if (Wlan[ssidIdx].IEEE11iAuthenticationMode == 'EAPAuthentication') {
            InitEapAuthShow('wpa2', Wlan[ssidIdx].IEEE11iEncryptionModes, "enterprise");
        } else {
            InitPskAuthShow('wpa2-psk', Wlan[ssidIdx].IEEE11iEncryptionModes, "wpa2-psk");
        }
    } else if ((mode == 'WPAand11i') || (mode == 'WPA/WPA2')) {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            InitEapAuthShow('wpa/wpa2', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "enterprise");
        } else {
            InitPskAuthShow('wpa/wpa2-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk");
        }
    } else if (mode == 'WPA3') {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            InitEapAuthShow('wpa3', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        } else {
            InitPskAuthShow('wpa3-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        }
    } else if (mode == 'WPA2/WPA3') {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            InitEapAuthShow('wpa2/wpa3', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        } else {
            InitPskAuthShow('wpa2/wpa3-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        }
    }
    else if(mode == 'X_HW_WAPI')
    {
        if(Wlan[ssidIdx].X_HW_WAPIAuthenticationMode == 'WAPIPSK')
        {
            setSelect('wlAuthMode','wapi-psk');
            setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
            document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wapi_psk");
            setDisable('wlEncryption',1);
            setDisplay("wpaPreShareKey", 1);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            wpapskpassword = wpaPskKey[ssidIdx].value; 



            setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
        }
        else
        {
            setSelect('wlAuthMode','wapi');
            setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
            setDisable('wlEncryption',1);
            setDisplay('wlWapi',1); 
            setText('wapiIPAddr',Wlan[ssidIdx].X_HW_WAPIServer);
            setText('wapiPort',Wlan[ssidIdx].X_HW_WAPIPort);
            setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
        }
    }
    else
    {   
        addEncryMethodOption('open');
        setDisplay('wlEncryMethod',1);
        setSelect('wlAuthMode','open');
        setSelect('wlEncryption','None');
    }
    if (((mode == 'WPA3') || (mode == 'WPA2/WPA3')) && (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode != 'EAPAuthentication')) {
        document.getElementById("hidewlWpaPsk_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
    } else {
        document.getElementById("hidewlWpaPsk_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote'];
    }
}

function wlKeyBitChange()
{
    
}

function IsAuthModePsk(AuthMode) {
    if ((AuthMode == 'wpa-psk') || (AuthMode == 'wpa2-psk') || (AuthMode == 'wpa/wpa2-psk') || (AuthMode == 'wpa3-psk') || (AuthMode == 'wpa2/wpa3-psk')) {
        return true;
    } else {
        return false;
    }
}

function IsAuthModeEap(AuthMode) {
    if ((AuthMode == 'wpa') || (AuthMode == 'wpa2') || (AuthMode == 'wpa/wpa2') || (AuthMode == 'wpa3') || (AuthMode == 'wpa2/wpa3')) {
        return true;
    } else {
        return false;
    }
}

function IsWpsConfigDisplay( )
{
    var AuthMode = getSelectVal('wlAuthMode');
    var EncryMode = getSelectVal('wlEncryption');

    if (IsAuthModePsk(AuthMode))
    {
        if (((Wps2 == 1) && (EncryMode == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }

        if(0 == wps1Cap)
        {
            if ((AuthMode == 'wpa-psk') || (EncryMode == 'TKIPEncryption'))
            
            {
                return false;
            }
        }
        
        return true;
    }

    return false;
}

function onMethodChange(isSelected)
{   
    var authMode = getSelectVal('wlAuthMode');
    if (authMode == 'open')
    {
        var var2 = getSelectVal('wlEncryption');

        if (var2 == 'None')
        {
            setDisplay('keyInfo', 0);
        }
        else
        {
            if (AddFlag == false)
            {
                var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
                setDisplay('keyInfo', 1);
                setSelect('wlKeyBit', parseInt(level)+24);
                
                if (1 == TelMexFlag)
                {
                    keyIndexChange(Wlan[ssidIdx].KeyIndex);
                }
                
                setSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
                setText('wlKeys1',g_keys[ssidIdx * 4].value);
                wep1password = g_keys[ssidIdx * 4].value; 
                setText('twlKeys1',g_keys[ssidIdx * 4].value); 
                setText('wlKeys2',g_keys[ssidIdx * 4+1].value);
                wep2password = g_keys[ssidIdx * 4+1].value; 
                setText('twlKeys2',g_keys[ssidIdx * 4+1].value); 
                setText('wlKeys3',g_keys[ssidIdx * 4+2].value);
                wep3password = g_keys[ssidIdx * 4+2].value; 
                setText('twlKeys3',g_keys[ssidIdx * 4+2].value); 
                setText('wlKeys4',g_keys[ssidIdx * 4+3].value);
                wep4password = g_keys[ssidIdx * 4+3].value; 
                setText('twlKeys4',g_keys[ssidIdx * 4+3].value); 
            }
            else
            {
                setDisplay('keyInfo', 1);
                setSelect('wlKeyBit', 128);
                
                if (1 == TelMexFlag)
                {
                    keyIndexChange(Wlan[ssidIdx].KeyIndex);
                }
                
                setSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
                setText('wlKeys1','');
                wep1password = ''; 
                setText('twlKeys1','');
                setText('wlKeys2','');
                wep2password = ''; 
                setText('twlKeys2','');
                setText('wlKeys3','');
                wep3password = ''; 
                setText('twlKeys3','');
                setText('wlKeys4','');
                wep4password = ''; 
                setText('twlKeys4','');
            }
        }
    }
    else
    {
        setDisplay('keyInfo', 0);
    }
	displayWpsConfig();
}

function SsidEnable()
{
    if (true == AddFlag)
    {
        return;
    }
    
    if (Wlan[ssidIdx].X_HW_ServiceEnable == 1)
    {
    }
    else
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_state']);
        setCheck('wlEnable', 0);
    }
    
    return;
}

function ShowSsidEnable(currentWlan)
{
    if (currentWlan.X_HW_ServiceEnable == 1)
    {
        setCheck('wlEnable', currentWlan.enable);
    }
    else
    {
        setCheck('wlEnable', 0);
    }
    
    return;
}

function ltrim(str)
{ 
 return str.replace(/(^\s*)/g,""); 
}


function checkSsidInst(ssid)
{
	for (var jLoop = 0; jLoop < Wlan.length; jLoop++)
	{
		if ((ssid+1) == getWlanInstFromDomain(Wlan[jLoop].domain))
		{
			return false;
		}
	}
	return true;
}

function checkUnicomSSIDName(ssid)
{
    if (modifyFlag == 1) {
        return true;
    }
    if (('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SSID1_STARTWITH_CU);%>' == 1) && (ssidIdx == 0) && (ssid.indexOf("CU_") != 0)) {
        AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cu']);
        return false;
    }
    if (('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_LNCU);%>' == 1) && (ssidIdx == 0) && (ssid.indexOf("lnunicom_") != 0)) {
        AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_lnunicom']);
        return false;
    }
    
    var ssid5G = 0;
    if ((ssidIdx >= 0) && (ssidIdx < Wlan.length)) {
        ssid5G = getWlanInstFromDomain(Wlan[ssidIdx].domain);
    }
    if (('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SSID1_STARTWITH_CU);%>' == 1) && (ssid5G == 5) && (ssid.indexOf("CU_") != 0)) {
        AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cu_5G']);
        return false;
    }
    if (('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_LNCU);%>' == 1) && (ssid5G == 5) && (ssid.indexOf("lnunicom_") != 0)) {
        AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_lnunicom_5G']);
        return false;
    }
    
    if (BjcuFlag == 1) {
        var ssidPortIndex = -1;
        if (ssidIdx == -1) {
            for (var iLoop = 0; iLoop < 8; iLoop++) {
                for (var jLoop = 0; jLoop < Wlan.length; jLoop++) {
                    if (getWlanPortNumber(Wlan[jLoop].name) == iLoop) {
                        break;
                    }
                }
                if ((Wlan.length == jLoop) && (checkSsidInst(iLoop) == true)) {
                    ssidPortIndex = iLoop;
                    break;
                }
            }
        } else {
            ssidPortIndex = getPortFromIndex(ssidIdx);
        }
        if ((ssidPortIndex == 0) && (ssid.indexOf("CU_") != 0)) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cu']);
            return false;
        }
        if ((ssidPortIndex == 1) && (ssid.indexOf("GUEST_") != 0)) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_guest']);
            return false;
        }
        if ((ssidPortIndex == 2) && (ssid.indexOf("STB_") != 0)) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_stb']);
            return false;
        }
    }
    return true;
}

function addParameter1(Form)
{   
    Form.addParameter('y.Enable',getCheckVal('wlEnable'));
    Form.addParameter('y.SSIDAdvertisementEnabled',getCheckVal('wlHide'));
    Form.addParameter('y.WMMEnable',getCheckVal('enableWmm'));
    var ssid;
    
    if (1 == BjcuFlag)
    {
        ssid = getValue('wlSsid1');
        var ssid2 = getValue('wlSsid2');

        var ssidParts = ssid.split('_');
        if (ssidParts.length != 1)
        {
            if(ssidParts[1] != "" )
            {
                ssid = ssid;
            }
            else
            {
                ssid = ssid + ssid2;
            }
        }
    }
    else
    {
        ssid = getValue('wlSsid1');
    }

    ssid = ltrim(ssid);
    if (ssid == '')
    {
        AlertEx(cfg_wlancfgother_language['amp_empty_ssid']);
        return false;
    }

    if (ssid.length > 32)
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
        return false;
    }
    if ((isBponFlag != 1) && (curLanguage.toUpperCase() != "CHINESE"))
    {
        if (isValidAscii(ssid) != '')
        {
            AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid'] + isValidAscii(ssid));
            return false;
        }
    } else {
        if (GetChineseNumLength(ssid) > 32) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
            return false;
        }
    }

    for (i = 0; i < Wlan.length; i++)
    {
		if ((getWlanPortNumber(Wlan[i].name) > 3) && ((1 == DoubleFreqFlag) && ("2G" == wlanpage)) )
        {
            continue;
        }
        
        if ((getWlanPortNumber(Wlan[i].name) <= 3) && ((1 == DoubleFreqFlag) && ("5G" == wlanpage)) )
        {
            continue;
        }

		if ((getWlanPortNumber(Wlan[i].name) > 3) && (1 != DoubleFreqFlag))
        {
            continue;
        }
		
        if (ssidIdx != i)
        {
            if (Wlan[i].ssid == ssid)
            {
                AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
                return false;
            }
        }
        else
        {
            continue;
        }
    }

    if( ((curWebFrame == 'frame_CTCOM') && ('E8C' == CurrentBin.toUpperCase())) 
        && (ssidIdx == 0) && (0 != ssid.indexOf("ChinaNet-")) )
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
        return false;
    }

    if (checkUnicomSSIDName(ssid) != true) {
        return false;
    }

    Form.addParameter('y.SSID', ssid);

    var deviceNum = getValue('X_HW_AssociateNum');
    if (isValidAssoc(deviceNum) == false)
    {
        return false;
    }
	var deviceNumInt = parseInt(getValue('X_HW_AssociateNum'),10);
    Form.addParameter('y.X_HW_AssociateNum',deviceNumInt);
}

function changeToInteger(number,length)
{
    var i;
    for (i = 0; i < number.length; i++)
    {
        if (number.charAt(i) != '0')
        {
            break;
        }
    }
    return number.substr(i,length-i);
}

function changeToPinNumber(number,length)
{
    var pinNumber = '';
    for (var i = 0; i < length-number.length; i++)
    {
        pinNumber += '0';
    }
    pinNumber += number;
    return pinNumber;
}

function addParameter2(Form)
{
    var url = '';
    var temp = '';

    var AuthMode = getSelectVal('wlAuthMode');

    if (AuthMode == 'shared' || AuthMode == 'open')
    {
        var method = getSelectVal('wlEncryption');
        
        if ((AuthMode == 'open' && method != 'None')
            || (AuthMode == 'shared'))
        {
            var KeyBit = getSelectVal('wlKeyBit');
            var index = getSelectVal('wlKeyIndex');
            var wlKeys1 = getValue('wlKeys1');
            var wlKeys2 = getValue('wlKeys2');
            var wlKeys3 = getValue('wlKeys3');
            var wlKeys4 = getValue('wlKeys4');
			if (isFireFox4 == 1)
			{
				if (wlKeys1 == '')
				{
					wlKeys1 = wep1password;
				}
				
				if (wlKeys2 == '')
				{
					wlKeys2 = wep2password;
				}
				
				if (wlKeys3 == '')
				{
					wlKeys3 = wep3password;
				}
				
				if (wlKeys4 == '')
				{
					wlKeys4 = wep4password;
				}
			}
			
            var val;
            var i;
            var vKey = 0;
            var KeyDesc;
            var telmaxWepModFlag = false;

            var keyIndex = getSelectVal('wlKeyIndex');
            for (vKey = 0; vKey < 4; vKey++)
            {
               if (1 == TelMexFlag)
               {
                   if (vKey+1 != keyIndex)
                   {
                       continue;
                   }
               }
               
               if (vKey == 0)
               {
                   val = wlKeys1;
                   telmaxWepModFlag = wep1PsdModFlag;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key1'];
               }
               else if (vKey == 1)
               {
                   val = wlKeys2;
                   telmaxWepModFlag = wep2PsdModFlag;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key2'];
               }
               else if (vKey == 2)
               {
                   val = wlKeys3;
                   telmaxWepModFlag = wep3PsdModFlag;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key3'];
               }
               else
               {
                   val = wlKeys4;
                   telmaxWepModFlag = wep4PsdModFlag;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key4'];
               }

               if ( val != '' && val != null)
               {
                   
                   if ( KeyBit == '128' )
                   {
                       if (isValidKey(val, 13) == false )
                       {
                           AlertEx(cfg_wlancfgdetail_language['amp_key_check1'] + val + cfg_wlancfgdetail_language['amp_key_invalid1']);
                           return false;
                       }
                   }
                   else
                   {
                       if (isValidKey(val, 5) == false )
                       {
                           AlertEx(cfg_wlancfgdetail_language['amp_key_check1'] + val + cfg_wlancfgdetail_language['amp_key_invalid2']);
                           return false;
                       }
                   }
               }
               else
               {
                   AlertEx(cfg_wlancfgdetail_language['amp_key_invalid3']);
                   return false;
               }
            }
            Form.addParameter('y.WEPEncryptionLevel',(KeyBit-24)+'-bit');
            Form.addParameter('y.WEPKeyIndex',index);
            
            if (1 == TelMexFlag)
            {
                if (wifiPasswordMask == '1')
                {
                    if (KeyBit == '128')
                    {
                        if ( (value != "*************") || (telmaxWepModFlag == true) )
                        {
                            Form.addParameter('k1.WEPKey', val);
                        }
                    }
                    else
                    {
                        if ( (value != "*****") || (telmaxWepModFlag == true) )
                        {
                            Form.addParameter('k1.WEPKey', val);
                        }
                    }
                }
                else
                {
                    Form.addParameter('k1.WEPKey', val);
                }
            }
            else
            {
                if (wifiPasswordMask == '1')
                {
                    if (KeyBit == '128')
                    {
                        if ( (wlKeys1 != "*************") || (wep1PsdModFlag == true) || wepOrigLen != getValue('wlKeys1').length)
                        {
                            
                            Form.addParameter('k1.WEPKey', wlKeys1);
                        }

                        if ( (wlKeys2 != "*************") || (wep2PsdModFlag == true) || wepOrigLen != getValue('wlKeys2').length)
                        {
                            Form.addParameter('k2.WEPKey', wlKeys2);
                        }

                        if ( (wlKeys3 != "*************") || (wep3PsdModFlag == true) || wepOrigLen != getValue('wlKeys3').length)
                        {
                            Form.addParameter('k3.WEPKey', wlKeys3);
                        }

                        if ( (wlKeys4 != "*************") || (wep4PsdModFlag == true) || wepOrigLen != getValue('wlKeys4').length)
                        {
                            Form.addParameter('k4.WEPKey', wlKeys4);
                        }
                    }
                    else
                    {
                        if ( (wlKeys1 != "*****") || (wep1PsdModFlag == true) || wepOrigLen != getValue('wlKeys1').length)
                        {
                            Form.addParameter('k1.WEPKey', wlKeys1);
                        }

                        if ( (wlKeys2 != "*****") || (wep2PsdModFlag == true) || wepOrigLen != getValue('wlKeys2').length)
                        {
                            Form.addParameter('k2.WEPKey', wlKeys2);
                        }

                        if ( (wlKeys3 != "*****") || (wep3PsdModFlag == true) || wepOrigLen != getValue('wlKeys3').length)
                        {
                            Form.addParameter('k3.WEPKey', wlKeys3);
                        }

                        if ( (wlKeys4 != "*****") || (wep4PsdModFlag == true) || wepOrigLen != getValue('wlKeys4').length)
                        {
                            Form.addParameter('k4.WEPKey', wlKeys4);
                        }
                    } 
                }
                else
                {
                    Form.addParameter('k1.WEPKey', wlKeys1);
                    Form.addParameter('k2.WEPKey', wlKeys2);
                    Form.addParameter('k3.WEPKey', wlKeys3);
                    Form.addParameter('k4.WEPKey', wlKeys4);
                }
            }
        }
        
        Form.addParameter('y.BeaconType','Basic');
        if (AuthMode == 'open')
        {
            Form.addParameter('y.BasicAuthenticationMode','None');
        }
        else
        {
            Form.addParameter('y.BasicAuthenticationMode','SharedAuthentication');
        }
        Form.addParameter('y.BasicEncryptionModes',getSelectVal('wlEncryption'));
    }
    else if (IsAuthModeEap(AuthMode))
    {
        var wlRadiusKey = getValue('wlRadiusKey');
		if ((isFireFox4 == 1) && (wlRadiusKey == ''))
		{
			wlRadiusKey = radiuspassword;
		}
		
        var wlRadiusIPAddr = getValue('wlRadiusIPAddr');
        var wlRadiusPort = getValue('wlRadiusPort');
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');
        
        if (wlRadiusIPAddr == '' || wlRadiusPort == '' || wlWpaGtkRekey == ''|| wlRadiusKey == '')
        {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }
        
        if (isValidRaiusKey(wlRadiusKey) == false)
        {
            AlertEx(cfg_wlancfgdetail_language['amp_radius_keyinvalid']);
            return false;
        }
        
        if (isAbcIpAddress(wlRadiusIPAddr) == false)
        {
            AlertEx(cfg_wlancfgdetail_language['amp_srvip_invalid']);
            return false;
        }

        if (isValidRadiusPort(wlRadiusPort) == false)
        {
            AlertEx(cfg_wlancfgdetail_language['amp_srvport_invalid']);
            return false;
        }

        if (isInteger(wlWpaGtkRekey) == false || isValidDecimalNum(wlWpaGtkRekey) == false)
        {
            AlertEx(cfg_wlancfgdetail_language['amp_wpakey_invalid']);
            return false;
        }

        if ((parseInt(wlWpaGtkRekey,10) > 86400) || (parseInt(wlWpaGtkRekey,10) < 600))
        {
            AlertEx(cfg_wlancfgdetail_language['amp_wpakey_range']);
            return false;
        }
        
        if (AuthMode == 'wpa') {
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2') {
            Form.addParameter('y.BeaconType','11i');
            Form.addParameter('y.IEEE11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa/wpa2') {
            Form.addParameter('y.BeaconType','WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa3') {
            Form.addParameter('y.BeaconType','WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2/wpa3') {
            Form.addParameter('y.BeaconType','WPA2/WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        }
        
        if (wifiPasswordMask == '1')
        {
            if ( (wlRadiusKey != "********") || (radPsdModFlag == true) )
            {
                Form.addParameter('y.X_HW_RadiusKey',wlRadiusKey);
            }
        }
        else
        {
           Form.addParameter('y.X_HW_RadiusKey',wlRadiusKey);
        }

        Form.addParameter('y.X_HW_RadiuServer',wlRadiusIPAddr);

        wlRadiusPort = parseInt(getValue('wlRadiusPort'),10);
        wlWpaGtkRekey = parseInt(getValue('wlWpaGtkRekey'),10);
        Form.addParameter('y.X_HW_RadiusPort',wlRadiusPort);
        Form.addParameter('y.X_HW_GroupRekey',wlWpaGtkRekey);
    }
    else if ((IsAuthModePsk(AuthMode)) || (AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
        var value = getValue('wlWpaPsk');
		if ((isFireFox4 == 1) &&  (value == ''))
		{
			value = wpapskpassword;
		}
		
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');
        var wapiIP = getValue('wapiIPAddr');
        var wapiPort = getValue('wapiPort');
        

    if (IsAuthModePsk(AuthMode)) {

        if (value == '' || wlWpaGtkRekey == '')
        {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }

        if ((AuthMode == 'wpa3-psk') || (AuthMode == 'wpa2/wpa3-psk')) {
            if ((isValidWPAPskKey(value) == false) || (value.length == 64)) {
                AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid_63']);
                return false;
            }
        } else {
            if (isValidWPAPskKey(value) == false) {
                AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
                return false;
            }
        }

        if (isInteger(wlWpaGtkRekey) == false || isValidDecimalNum(wlWpaGtkRekey) == false)
        {
            AlertEx(cfg_wlancfgdetail_language['amp_wpakey_invalid']);
            return false;
        }

        if ((parseInt(wlWpaGtkRekey,10) > 86400) || (parseInt(wlWpaGtkRekey,10) < 600))
        {
            AlertEx(cfg_wlancfgdetail_language['amp_wpakey_range']);
            return false;
        }
    }

        if (AuthMode == 'wpa-psk') {
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2-psk') {
            Form.addParameter('y.BeaconType','11i');
            Form.addParameter('y.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
        }  else if (AuthMode == 'wpa/wpa2-psk') {
            Form.addParameter('y.BeaconType','WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa3-psk') {
            Form.addParameter('y.BeaconType','WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','SAEAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2/wpa3-psk') {
            Form.addParameter('y.BeaconType','WPA2/WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKandSAEAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } else if(AuthMode == 'wapi') {
            if (isAbcIpAddress(wapiIP) == false) {
                AlertEx(cfg_wlancfgdetail_language['amp_wapisrvip_invalid']);
                return false;
            }
            
            if (isValidRadiusPort(wapiPort) == false) {
                AlertEx(cfg_wlancfgdetail_language['amp_wapisrvport_invalid']);
                return false;
            }
            Form.addParameter('y.BeaconType','X_HW_WAPI');
            Form.addParameter('y.X_HW_WAPIAuthenticationMode','WAPICERT');
            Form.addParameter('y.X_HW_WAPIEncryptionModes','SMS4');
            Form.addParameter('y.X_HW_WAPIServer',wapiIP);
            Form.addParameter('y.X_HW_WAPIPort',wapiPort);
        } else if(AuthMode == 'wapi-psk') {
            if ((value == '') || (wlWpaGtkRekey == '')) {
                AlertEx(cfg_wlancfgother_language['amp_empty_para']);
                return false;
            }
			
            if (isValidWPAPskKey(value) == false) {
                AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
                return false;
            }
            Form.addParameter('y.BeaconType','X_HW_WAPI');
            Form.addParameter('y.X_HW_WAPIAuthenticationMode','WAPIPSK');
            Form.addParameter('y.X_HW_WAPIEncryptionModes','SMS4');
            
        } else {
            Form.addParameter('y.BeaconType','WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } 

        if (wifiPasswordMask == '1')
        {
            if ( (value != "********") || (pskPsdModFlag == true) )
            {
                Form.addParameter('k.PreSharedKey',value);
            }
             
        }
        else
        {
            Form.addParameter('k.PreSharedKey',value);
        }

	    if (isValidDecimalNum(getValue('wlWpaGtkRekey')) == false)
		{
            AlertEx(cfg_wlancfgdetail_language['amp_wpakey_invalid']);
            return false;
        }
		       
		wlWpaGtkRekey = parseInt(getValue('wlWpaGtkRekey'),10);
        Form.addParameter('y.X_HW_GroupRekey',wlWpaGtkRekey);
        
        var wpsEnable = getCheckVal('wlWPSEnable');
        Form.addParameter('z.Enable',wpsEnable);
        
        if (getSelectVal('wlWPSMode')== 'PBC')
        {
            Form.addParameter('z.X_HW_ConfigMethod','PushButton');
        }
        else if (getSelectVal('wlWPSMode')== 'PIN')
        {
        	if (IsWpsConfigDisplay() != false)
        	{
	            var clientPinNum = getValue('wlClientPinNum');
	            if (clientPinNum == '')
	            {
	                AlertEx(cfg_wlancfgother_language['amp_clientpin_empty']);
	                return false;
	            }
	                
	             if (isInteger(clientPinNum) == false)
	             {
	                  AlertEx(cfg_wlancfgother_language['amp_clientpin_int']);
	                  return false;
	              }

	              if (clientPinNum.length != 8)
	              {
	                  AlertEx(cfg_wlancfgother_language['amp_clientpin_8int']);
	                  return false;
	               }

	              if (clientPinNum == 0)
	              {   
	                  AlertEx(cfg_wlancfgother_language['amp_clientpin_invalid']);
	                  return false;
	              }
	                
	              var pinNum = parseInt(changeToInteger(clientPinNum,8));
	              if (ValidateChecksum(parseInt(pinNum, 10)) != 0)
	              {
	                  AlertEx(cfg_wlancfgother_language['amp_clientpin_invalid']);
	                  return false;
	              }
	              Form.addParameter('z.X_HW_ConfigMethod','Lable');
	              Form.addParameter('z.X_HW_PinGenerator','STA');
	              Form.addParameter('z.DevicePassword',parseInt(pinNum, 10));
                }
        }
        else
        {
            var selPinNum = getValue('wlSelfPinNum');
            if (selPinNum == '')
            {
                AlertEx(cfg_wlancfgother_language['amp_localpin_empty']);
                return false;
            }
            
            Form.addParameter('z.X_HW_ConfigMethod','Lable');
            Form.addParameter('z.X_HW_PinGenerator','AP');
            Form.addParameter('z.DevicePassword',parseInt(changeToInteger(selPinNum,8)));
        }        
    }
    else
    {
    }

    return true;
}

var guiCoverSsidNotifyFlag = 0;

function setCoverSsidNotifyFlag(DBvalue, WebValue)
{
    if (DBvalue != WebValue)
    {
        guiCoverSsidNotifyFlag++;
    }
}

function AddParaForCover(Form)
{
    var wlandomain = Wlan[ssidIdx].domain;
    var length = wlandomain.length;
    var wlanInstId = parseInt(wlandomain.charAt(length-1));
    var beaconType = "Basic";
    
    var ssid;
    
    if (1 == BjcuFlag)
    {
        ssid = getValue('wlSsid1');
        var ssid2 = getValue('wlSsid2');

        var ssidParts = ssid.split('_');
        if (ssidParts.length != 1)
        {
            if(ssidParts[1] != "" )
            {
                ssid = ssid;
            }
            else
            {
                ssid = ssid + ssid2;
            }
        }
    }
    else
    {
        ssid = getValue('wlSsid1');
    }

    ssid = ltrim(ssid);

    Form.addParameter('w.SsidInst',wlanInstId);
    
    Form.addParameter('w.SSID',ltrim(ssid));
    setCoverSsidNotifyFlag(Wlan[ssidIdx].ssid, ltrim(ssid));
    
    Form.addParameter('w.Enable',getCheckVal('wlEnable'));

    Form.addParameter('w.Standard',WlanWifi.mode);

    Form.addParameter('w.BasicAuthenticationMode','None');
    Form.addParameter('w.BasicEncryptionModes',getSelectVal('wlEncryption'));
    Form.addParameter('w.WPAAuthenticationMode','EAPAuthentication');
    Form.addParameter('w.WPAEncryptionModes',getSelectVal('wlEncryption'));
    Form.addParameter('w.IEEE11iAuthenticationMode','EAPAuthentication');
    Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
    Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
    Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
    Form.addParameter('w.SSIDAdvertisementEnabled', getCheckVal('wlHide'));
	Form.addParameter('w.WMMEnable', getCheckVal('enableWmm'));
	
    var AuthMode = getSelectVal('wlAuthMode');
    if (AuthMode == 'shared' || AuthMode == 'open')
    {    
        Form.addParameter('w.BeaconType','Basic');
        setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'Basic');
        
        if (AuthMode == 'open')
        {
            Form.addParameter('w.BasicAuthenticationMode','None');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicAuthenticationMode, 'None');
        }
        else
        {
            Form.addParameter('w.BasicAuthenticationMode','SharedAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicAuthenticationMode, 'SharedAuthentication');
        }
        
        Form.addParameter('w.BasicEncryptionModes',getSelectVal('wlEncryption'));
        setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicEncryptionModes, getSelectVal('wlEncryption'));
    } 
    else if (IsAuthModeEap(AuthMode))
    {
        if (AuthMode == 'wpa') {
            Form.addParameter('w.BeaconType','WPA');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA');            
            
            beaconType = "WPA";
            Form.addParameter('w.WPAAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.WPAEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAEncryptionModes, getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2') {
            Form.addParameter('w.BeaconType','11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, '11i');
            
            beaconType = "11i";
            Form.addParameter('w.IEEE11iAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iEncryptionModes, getSelectVal('wlEncryption'));
        } else if  (AuthMode == 'wpa/wpa2') {
            Form.addParameter('w.BeaconType','WPAand11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPAand11i');
            
            beaconType = "WPAand11i";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa3') {
            Form.addParameter('w.BeaconType','WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA3');

            beaconType = "WPA3";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        } else if  (AuthMode == 'wpa2/wpa3') {
            Form.addParameter('w.BeaconType','WPA2/WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA2/WPA3');

            beaconType = "WPA2/WPA3";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        }
    } else if ((IsAuthModePsk(AuthMode)) || (AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
        if (AuthMode == 'wpa-psk') {
            Form.addParameter('w.BeaconType','WPA');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA');
            
            beaconType = "WPA";
            Form.addParameter('w.WPAAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.WPAEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAEncryptionModes, getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2-psk') {
            Form.addParameter('w.BeaconType','11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, '11i');
            
            beaconType = "11i";
            Form.addParameter('w.IEEE11iAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iEncryptionModes, getSelectVal('wlEncryption'));
        }   else if (AuthMode == 'wpa/wpa2-psk') {
            Form.addParameter('w.BeaconType','WPAand11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPAand11i');

            beaconType = "WPAand11i";
            Form.addParameter('w.MixAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'PSKAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa3-psk') {
            Form.addParameter('w.BeaconType','WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA3');

            beaconType = "WPA3";
            Form.addParameter('w.MixAuthenticationMode','SAEAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'SAEAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wpa2/wpa3-psk') {
            Form.addParameter('w.BeaconType','WPA2/WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA2/WPA3');

            beaconType = "WPA2/WPA3";
            Form.addParameter('w.MixAuthenticationMode','PSKandSAEAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'PSKandSAEAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        } else if (AuthMode == 'wapi') {
            Form.addParameter('w.BeaconType','X_HW_WAPI');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'X_HW_WAPI');
            
            beaconType = "X_HW_WAPI";
        } else if (AuthMode == 'wapi-psk') {
            Form.addParameter('w.BeaconType','X_HW_WAPI');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'X_HW_WAPI');
            
            beaconType = "X_HW_WAPI";
        }
    }

    var KeyBit = getSelectVal('wlKeyBit');
    Form.addParameter('w.WEPEncryptionLevel',(KeyBit-24)+'-bit');
    setCoverSsidNotifyFlag(Wlan[ssidIdx].EncypBit, (KeyBit-24)+'-bit');
    
    var keyIndex = getSelectVal('wlKeyIndex');
    Form.addParameter('w.WEPKeyIndex', keyIndex);
   
    var weppsdModifyFLag = false;
    var key;
    if (1 == keyIndex)
    {
        key = getValue('wlKeys1');
		if ((isFireFox4 == 1) && (key == ''))
		{
			key = wep1password;
		}
		
        weppsdModifyFLag = wep1PsdModFlag;
        if (wepOrigLen != key.length)
        {
            weppsdModifyFLag = true;
        }
    }
    else if (2 == keyIndex)
    {
        key = getValue('wlKeys2');
		if ((isFireFox4 == 1) && (key == ''))
		{
			key = wep2password;
		}
	
        weppsdModifyFLag = wep2PsdModFlag;
        if (wepOrigLen != key.length)
        {
            weppsdModifyFLag = true;
        }
    }
    else if (3 == keyIndex)
    {
        key = getValue('wlKeys3');
		if ((isFireFox4 == 1) && (key == ''))
		{
			key = wep3password;
		}
		
        weppsdModifyFLag = wep3PsdModFlag;
        if (wepOrigLen != key.length)
        {
            weppsdModifyFLag = true;
        }
    } 
    else  if (4 == keyIndex)
    {
        key = getValue('wlKeys4');
		if ((isFireFox4 == 1) && (key == ''))
		{
			key = wep4password;
		}
		
        weppsdModifyFLag = wep4PsdModFlag;
        if (wepOrigLen != key.length)
        {
            weppsdModifyFLag = true;
        }
    } 

    if ("Basic" != beaconType)
    {
        key = getValue('wlWpaPsk');
		if ((isFireFox4 == 1) &&  (key == ''))
		{
			key = wpapskpassword;
		}
    }
    
    if (wifiPasswordMask == '1')
    {
        if ("Basic" != beaconType) 
        {
            if ( (key != "********") || (pskPsdModFlag == true) )
            {
                Form.addParameter('w.Key', key);
            }
        }
        else
        {
            if ('WEPEncryption' == getSelectVal('wlEncryption'))
            {
                if (KeyBit == '128')
                {
                    if ( (key != "*************") || (weppsdModifyFLag == true) )
                    {                        
                        Form.addParameter('w.Key', key);
                    }
                }
                else
                {
                    if ( (key != "*****") || (weppsdModifyFLag == true) )
                    {
                        Form.addParameter('w.Key', key);
                    }
                }
            }
        }
    }
    else
    {
        Form.addParameter('w.Key', key);
    }
    

    if ("Basic" != beaconType)
    {
        setCoverSsidNotifyFlag(wpaPskKey[ssidIdx].value, key);
    }
    else
    {
        if (('WEPEncryption' == getSelectVal('wlEncryption')) && (1 <= keyIndex) && (keyIndex <= 4))
        {
            setCoverSsidNotifyFlag(Wlan[ssidIdx].KeyIndex, keyIndex);
            setCoverSsidNotifyFlag(g_keys[ssidIdx * 4 + (keyIndex - 1)].value, key);
        }
    }
    
    return true;
}

function stExtendedWLC(domain, SSIDIndex)
{
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
}

var apExtendedWLC = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC);%>;

function isWifiCoverSsidNotify()
{    
    if (guiCoverSsidNotifyFlag > 0)
    {
        return true;
    }
    return false;
}

function isWifiCoverSsid(wlanInst)
{
    for (var j = 0; j < apExtendedWLC.length - 1; j++)
    {
        if (wlanInst == apExtendedWLC[j].SSIDIndex)
        {
            if (isWifiCoverSsidNotify())
            {
                   return true;            
            }
        }
    }

    return false
}

function isWifiCoverSsidExt(wlanInst)
{
    for (var j = 0; j < apExtendedWLC.length - 1; j++)
    {
        if (wlanInst == apExtendedWLC[j].SSIDIndex)
        {
            return true;            
        }
    }

    return false
}

function SubmitForm()
{
    var Form = new webSubmitForm();
    var Url;
	var busyflag = 0;

    if (addParameter1(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);
        setDisable('btnApplySubmit2', 0);
        setDisable('cancelButton', 0);
        return;
    }
    
    if (addParameter2(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);        
        return;
    }

    if (AddParaForCover(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);        
        return;
    }  
	
    var wlandomain = Wlan[ssidIdx].domain;
    var AuthMode = getSelectVal('wlAuthMode');
	var TempEncryMode = getSelectVal('wlEncryption');
	var wificoverindex = getInstIdByDomain(wlandomain);
    var configAction = 'InternetGatewayDevice.X_HW_DEBUG.WLANConfigAction';
	
	$.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "../common/getSsidProcFlag.asp?&1=1",
            data :"wlanid="+wificoverindex,
            success : function(data) {
            busyflag = data;
            }
        });

	if ('1' == busyflag)
	{
		AlertEx(cfg_wificover_basic_language['amp_wificover_modify_wifipara_synchronizing']);
		return;
	}
	
	if (isWifiCoverSsidExt(wificoverindex)) {
		if (IsAuthModeEap(AuthMode)) {
			AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_auth']);
			return;
		} else if ((AuthMode == 'shared' || AuthMode == 'open') && (TempEncryMode == 'WEPEncryption')) {
			AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_wep']);
			return;
		}
	}

    if (isWifiCoverSsid(getWlanInstFromDomain(wlandomain)))
    {
        if (false == ConfirmEx(cfg_wificover_basic_language['amp_wificover_ssid_change_notify'])) 
        {
            guiCoverSsidNotifyFlag = 0;
            setDisable('btnApplySubmit',0);
            setDisable('cancel',0);        
            return;
        }
    }

    if (AuthMode == 'shared' || AuthMode == 'open')
    {
        if (getSelectVal('wlEncryption') == 'None')
        {
            Form.setAction('set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
                + wlandomain + '&c2=' + configAction + '&RequestFile=html/amp/wlanbasic/wlan.asp');
        }
        else
        {
            if (1 == TelMexFlag)
            {
                Form.setAction('set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
                    + wlandomain + '&k1=' + wlandomain + '.WEPKey.' + getSelectVal('wlKeyIndex')
                    + '&c2=' + configAction + '&RequestFile=html/amp/wlanbasic/wlan.asp');
            }
            else
            {
                Form.setAction('set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain
                    + '&k1=' + wlandomain + '.WEPKey.1'
                    + '&k2=' + wlandomain + '.WEPKey.2'
                    + '&k3=' + wlandomain + '.WEPKey.3'
                    + '&k4=' + wlandomain + '.WEPKey.4'
					+ '&c2=' + configAction
                    + '&RequestFile=html/amp/wlanbasic/wlan.asp');
            }
        } 
    } else if (IsAuthModeEap(AuthMode)) {
        Form.setAction('set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
            + wlandomain + '&c2=' + configAction + '&RequestFile=html/amp/wlanbasic/wlan.asp');
    } else if (IsAuthModePsk(AuthMode)) {
        Url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
            + wlandomain;

        if (IsWpsConfigDisplay() == false) {
            Url += '&k=' + wlandomain + '.PreSharedKey.1';
        } else {
            Url += '&z=' + wlandomain + '.WPS'
                    + '&k=' + wlandomain + '.PreSharedKey.1';
        }

        Url += '&c2=' + configAction + '&RequestFile=html/amp/wlanbasic/wlan.asp';
        Form.setAction(Url);
    } else if((AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
        Form.setAction('set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain
                +'&k=' + wlandomain + '.PreSharedKey.1'                 
                + '&c2=' + configAction + '&RequestFile=html/amp/wlanbasic/wlan.asp');
    } else {
        Form.setAction('set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&x=InternetGatewayDevice.LANDevice.1'
                    + '&y=' + wlandomain + '&c2=' + configAction
                    + '&RequestFile=html/amp/wlanbasic/wlan.asp');
    }

	Form.addParameter('c1.ActionType', 0);
    Form.addParameter('c2.ActionType', 1);
    Form.addParameter('c2.SSIDList', '' + getInstIdByDomain(Wlan[ssidIdx].domain));

    setDisable('btnWpsPBC', 1);
    DisableButtons();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function WpsPBCSubmit()
{
    var wpsEnable = getCheckVal('wlWPSEnable');
    if (wpsEnable == 0)
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wps_enable_note']);
        return;
    }

    if (ConfirmEx(cfg_wlancfgdetail_language['amp_wps_start'])) 
    {
        var Form = new webSubmitForm();
        setDisable('btnWpsPBC', 1);
		if(wlanpage == '2G')
		{			
			Form.setAction('WpsPBC.cgi?freq=2G' + '&RequestFile=html/amp/wlanbasic/wlan.asp');
		}
		else
		{
			Form.setAction('WpsPBC.cgi?freq=5G' + '&RequestFile=html/amp/wlanbasic/wlan.asp');
		}

		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

function check11nAndWmm()
{
    if (WlanWifi.mode == '11n')
    {
        setDisable('enableWmm', 1);
    }
}

function InitWepOriginLen()
{
    wepOrigLen = (g_keys[ssidIdx * 4].value).length;
}

function ClearPsdModFlag()
{
    wep1PsdModFlag = false;
    wep2PsdModFlag = false;
    wep3PsdModFlag = false;
    wep4PsdModFlag = false;
    pskPsdModFlag = false;
    radPsdModFlag = false;
}

        
function BindPsdModifyEvent()
{
    $('#wlKeys1').bind("propertychange input", function(){ 
        var KeyBit = getSelectVal('wlKeyBit');
        if (KeyBit == '128')
        {
            if (getValue('wlKeys1') != "*************")
            {
                wep1PsdModFlag = true;
            }            
        }
        else 
        {
            if(getValue('wlKeys1') != "*****") 
            {
                wep1PsdModFlag = true;
            }
        }
    } );

    $('#wlKeys2').bind("propertychange input", function(){ 
        var KeyBit = getSelectVal('wlKeyBit');
        if ( KeyBit == '128' )
        {
            if (getValue('wlKeys2') != "*************")
            {
                wep2PsdModFlag = true;
            }            
        }
        else 
        {
            if(getValue('wlKeys2') != "*****") 
            {
                wep2PsdModFlag = true;
            }
        }
    } );

    $('#wlKeys3').bind("propertychange input", function(){ 
        var KeyBit = getSelectVal('wlKeyBit');
        if (KeyBit == '128')
        {
            if (getValue('wlKeys3') != "*************")
            {
                wep3PsdModFlag = true;
            }
            
        }
        else 
        {
            if(getValue('wlKeys3') != "*****") 
            {
                wep3PsdModFlag = true;
            }
        }
    } );

    $('#wlKeys4').bind("propertychange input", function(){ 
        var KeyBit = getSelectVal('wlKeyBit');
        if (KeyBit == '128') 
        {
            if (getValue('wlKeys4') != "*************")
            {
                 wep4PsdModFlag = true;
            }
           
        }
        else 
        {
            if (getValue('wlKeys4') != "*****") 
            {
                wep4PsdModFlag = true;
            }
        }
    } );


    $('#wlWpaPsk').bind("propertychange input", function(){ 
        if(getValue('wlWpaPsk') != "********") 
        {
            pskPsdModFlag = true;
        } 
    } );

    $('#wlRadiusKey').bind("propertychange input", function(){ 
        if(getValue('wlRadiusKey') != "********") 
        {
            radPsdModFlag = true;
        }
    } );
}

function pwdStrengthcheck(id,pwdid)
{
    var score = 0;
    var password1 = getElementById(id).value;
    if(password1.length > 8) score++;

    if(password1.match(/[a-z]/)) score++;

    if (password1.match(/[A-Z]/)) score++;

    if(password1.match(/\d/)) score++;

    if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) score++;

    if (password1.length > 12) score++;

    if ((score == 0) || (score == 1)) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=16.6+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FF0000";
    } else if (score == 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=33.2+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FF0000";
    } else if (score == 3) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=49.8+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FFA500";
    } else if (score == 4) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=66.4+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FFA500";
    } else if (score == 5) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=83+"%";
        getElementById(pwdid).style.borderBottom="4px solid #008000";
    } else if (score >= 6) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=100+"%";
        getElementById(pwdid).style.borderBottom="4px solid #008000";
    }
}

function psdStrength1(id) {
    var checkid= "pwdvalue1";
    pwdStrengthcheck(id,checkid);
}

function psdStrength2(id) {
    var checkid= "pwdvalue2";
    pwdStrengthcheck(id,checkid);
}

function psdStrength3(id) {
    var checkid= "pwdvalue3";
    pwdStrengthcheck(id,checkid);
}

function psdStrength4(id) {
    var checkid= "pwdvalue4";
    pwdStrengthcheck(id,checkid);
}

function psdStrength5(id) {
    var checkid= "pwdvalue5";
    pwdStrengthcheck(id,checkid);
}


function LoadFrame()
{
    $("#checkinfo1Row").css("display", "none");
    var pwdcheck1 = document.getElementById('checkinfo1');
    pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd1" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue1" BindText="amp_pwd_strength_low"></div> </div></div>';

    $("#checkinfo2Row").css("display", "none");
    var pwdcheck2 = document.getElementById('checkinfo2');
    pwdcheck2.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd2" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue2" BindText="amp_pwd_strength_low"></div></div></div>';

    $("#checkinfo3Row").css("display", "none");
    var pwdcheck3 = document.getElementById('checkinfo3');
    pwdcheck3.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd3" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue3" BindText="amp_pwd_strength_low"></div></div></div>';

    $("#checkinfo4Row").css("display", "none");
    var pwdcheck4 = document.getElementById('checkinfo4');
    pwdcheck4.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd4" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue4" BindText="amp_pwd_strength_low"></div></div></div>';

    $("#checkinfo5Row").css("display", "none");
    var pwdcheck5 = document.getElementById('checkinfo5');
    pwdcheck5.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd5" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></div></div></div>';

    if (enbl == '')
    {
        setDisplay('wlanBasicCfg',0);
    }
    else
    {   
        setDisplay('wlanBasicCfg',1);
        setCheck('wlEnbl', enbl);

        check11nAndWmm();
        
        if ((1 == enbl) && (WlanArr[0] != null))
        {
            ssidIdx = 0;
            selectLine('record_0');
            setDisplay('wlanCfg',1);
            var authMode = Wlan[ssidIdx].BeaconType;
            beaconTypeChange(authMode); 
        }
        else if (0 == enbl)
        {
            setDisplay('wlanCfg',0);
        }
        else
        {
            setDisplay('ssidDetail', '0');
        }
    }
    
    keyIndexChange(0);
    
    document.getElementById('TdSSID').title = ssid;
    document.getElementById('TdDeviceNum').title = deviceNumber;
    document.getElementById('TdHide').title = hide;
    document.getElementById('TdWMM').title = wmm;
    document.getElementById('TdAuth').title = authmode;
    document.getElementById('TdEncrypt').title = encryption;
    if (g_keys[0] != null)
	{
    	document.getElementById('wlKeys1').title      = posswordComplexTitle;
    	document.getElementById('twlKeys1').title     = posswordComplexTitle;
	}

	if (g_keys[1] != null)
	{
    	document.getElementById('wlKeys2').title      = posswordComplexTitle;
    	document.getElementById('twlKeys2').title     = posswordComplexTitle;
	}

	if (g_keys[2] != null)
	{
    	document.getElementById('wlKeys3').title      = posswordComplexTitle;
    	document.getElementById('twlKeys3').title     = posswordComplexTitle;
	}

	if (g_keys[3] != null)
	{
    	document.getElementById('wlKeys4').title      = posswordComplexTitle;        
    	document.getElementById('twlKeys4').title     = posswordComplexTitle; 
    }  
    document.getElementById('wlWpaPsk').title     = posswordComplexTitle; 
    document.getElementById('twlWpaPsk').title    = posswordComplexTitle;
    document.getElementById('wlRadiusKey').title  = posswordComplexTitle;
    document.getElementById('twlRadiusKey').title = posswordComplexTitle;

    
    if (curLanguage.toUpperCase() == 'CHINESE')
    {
        var HUNCTFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_HUNCT);%>';

        if(((curWebFrame == 'frame_CMCC') && (curUserType == sptUserType)))
        {
            setDisplay("TblBasicParaTitle",1);
        }
        
        if((curUserType != sysUserType) && (1 == CTCFlag))
        {
            getElById("wlPutOutPower").style.display = "none";
            getElById("switchChannel").style.display = "none";
            getElById("div_gMode").style.display = "none";
        }
        
        if (curWebFrame == 'frame_CMCC')
        {
            setDisable('BtnAdd', 1);
            setDisable('BtnRemove',1);
        }
		
		if ((forbidAddSsid == 1) && (curUserType == sptUserType)) {
			setDisable('BtnAdd', 1);
			setDisable('BtnRemove',1);
		}
        
        if ((1 == gzcmccFlag) && ((curUserType == sptUserType)))
        {
            setDisable('BtnAdd', 1);
            setDisable('BtnRemove', 1);    
            setDisable('wlEnbl', 1);
        }

        if (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_NON_FIRST_SSID_FORBIDDON);%>')
        {
            setDisplay('BtnAdd', 0);
            setDisplay('BtnRemove', 0);    
        }
        
        if (1 == HUNCTFlag)
        {
            setDisable("wlEncryption",1);
            setDisable("wlAuthMode",1);
        }
    }
    
    if (WlanMap.length == 0)
    {
        setDisable("btnApplySubmit", 1);
        setDisable("cancel", 1);
        setDisplay('wlSsid2',0);
    }

    LoadMaxNumResource();

    if (wifiPasswordMask == 1) {
        BindPsdModifyEvent();
        setDisplay('hidewlRadiusKey', 0);
        setDisplay('hidewlWpaPsk', 0);
        setDisplay('hidewlKeys', 0);
        setDisplay('hideId1', 0);
        setDisplay('hideId2', 0);
        setDisplay('hideId3', 0);
    }

    InitWallMode();

    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }
        
        if (cfg_wlancfgbasic_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgbasic_language[b.getAttribute("BindText")];
        } else if (cfg_wlancfgdetail_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgdetail_language[b.getAttribute("BindText")];    
        } else if (cfg_wlancfgadvance_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgadvance_language[b.getAttribute("BindText")];    
        } else if (cfg_wlancfgother_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgother_language[b.getAttribute("BindText")];        
        } else if (cfg_wlanzone_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlanzone_language[b.getAttribute("BindText")];        
        }    
    }
}

function InitWallMode() {
    setSelect("wallMode_select", wallMode);
    setDisplay("powerStrenthMode", 1);
    setDisable("wlTxPwr", wallMode);
    if (wallMode == 1) {
        setSelect("wlTxPwr", 100);
    }
}

function WallModeChange() {
    var wallModeVal = getSelectVal('wallMode_select');
    setDisable("wlTxPwr", wallModeVal);
    if (wallModeVal == 1) {
        setSelect("wlTxPwr", 100);
    }
}

function ApplySubmit1()
{
    var Form = new webSubmitForm();   

    if (addParameter1(Form) == false)
    { 
        return;
    }
    
    if (1 == DoubleFreqFlag)
    {
        if ("2G" == wlanpage)
        {
              Form.addParameter('y.LowerLayers', node2G);
        }
        else if ("5G" == wlanpage)
        {
              Form.addParameter('y.LowerLayers', node5G);
        }
    }
	else
	{
		Form.addParameter('y.LowerLayers', node2G);
	}
    
    Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration' 
                   + '&RequestFile=html/amp/wlanbasic/wlan.asp');
    
    DisableButtons();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function ApplySubmit2()
{
    SubmitForm();
}

function ApplySubmit()
{
    if (AddFlag == true)
    {
        ApplySubmit1();
    }
    else
    {       
        ApplySubmit2();
    }
}

function EnableSubmit()
{
    setDisable('wlEnbl', 1);
    AddFlag = false;
    var Form = new webSubmitForm();
    var enable = getCheckVal('wlEnbl');
    
    DisableButtons();
    setDisable('wlEnbl', 1);
    
    if (1 == DoubleFreqFlag)
    {
    	if ("2G" == wlanpage)
        {
            Form.addParameter('x.Enable',enable);

            if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node2G)
            {
				Form.addParameter('x.RadioInst', 1);			
				Form.addParameter('y.Enable',enable);
				
				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
							+ '&RequestFile=html/amp/wlanbasic/wlan.asp');
				} 
            }
            else
            {
				Form.addParameter('x.RadioInst', 2);
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
							+ '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}             
            }
        }
        else if ("5G" == wlanpage)
        {
            Form.addParameter('x.Enable',enable);

            if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node5G)
            {
				Form.addParameter('x.RadioInst', 1);		
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
							+ '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}
            }
            else
            {
				Form.addParameter('x.RadioInst', 2);			
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
							+ '&RequestFile=html/amp/wlanbasic/wlan.asp');
				}                  
            }
        } 
    }
    else
    {
		Form.addParameter('x.Enable', enable);
		Form.addParameter('x.RadioInst', 0);
				
        Form.addParameter('y.X_HW_WlanEnable',enable);
		if(0 == HiLinkRoll)
		{
				Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1'
						+ '&RequestFile=html/amp/wlanbasic/wlan.asp');
		}
		else
		{
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1'
					+ '&RequestFile=html/amp/wlanbasic/wlan.asp');
		} 
	}

	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function BjcuShowWlan(currentWlan)
{
    if (true == AddFlag)
    {
        setText('wlSsid1',currentWlan.ssid);
        setDisable('wlSsid1',0);
        setDisplay('wlSsid2',0);
        setText('wlSsid2',"");
        SetStyleValue("wlSsid1", "width:123px");
    }
    else
    {
        var ssidParts = currentWlan.ssid.split('_');

        if (ssidParts.length == 1)
        {
            setText('wlSsid1',currentWlan.ssid);
            setDisable('wlSsid1',0);
            setDisplay('wlSsid2',0);
            setText('wlSsid2',"");
            SetStyleValue("wlSsid1", "width:123px");
        }
        else
        {
            if(ssidParts[0]=="CU")
            {
                var strSSID1 = ssidParts[0] + "_";
                var strSSID2 = currentWlan.ssid.substr(strSSID1.length,currentWlan.ssid.length);
                setText('wlSsid1',strSSID1);
                setDisable('wlSsid1',1);
                setText('wlSsid2',strSSID2);
                setDisplay('wlSsid2',1);
                SetStyleValue("wlSsid1", "width:25px;border:0");
            }
            else if(ssidParts[0]=="STB")
            {
                var strSSID1 = ssidParts[0] + "_";
                var strSSID2 = currentWlan.ssid.substr(strSSID1.length,currentWlan.ssid.length);
                setText('wlSsid1',strSSID1);
                setDisable('wlSsid1',1);
                setText('wlSsid2',strSSID2);
                setDisplay('wlSsid2',1);
                SetStyleValue("wlSsid1", "width:30px;border:0");
            }
            else if(ssidParts[0]=="GUEST")
            {
                var strSSID1 = ssidParts[0] + "_";
                var strSSID2 = currentWlan.ssid.substr(strSSID1.length,currentWlan.ssid.length);
                setText('wlSsid1',strSSID1);
                setDisable('wlSsid1',1);
                setText('wlSsid2',strSSID2);
                setDisplay('wlSsid2',1);
                SetStyleValue("wlSsid1", "width:48px;border:0");
            }
            else
            {
                setText('wlSsid1',currentWlan.ssid);
                setDisable('wlSsid1',0);
                setDisplay('wlSsid2',0);
                setText('wlSsid2',"");
                SetStyleValue("wlSsid1", "width:123px");
            }
        }
    }
}

function showWlan(currentWlan)
{
    with (document.forms[0])
    {
        ShowSsidEnable(currentWlan);
        setCheck('wlHide', currentWlan.wlHide);
        setText('X_HW_AssociateNum',currentWlan.DeviceNum);
        
        if (1 == BjcuFlag)
        {
            BjcuShowWlan(currentWlan);
        }
        else
        {
            setText('wlSsid1',currentWlan.ssid);
            setDisable('wlSsid1',0);
            setDisplay('wlSsid2',0);
            setText('wlSsid2',"");
            SetStyleValue("wlSsid1", "width:123px");
        }

        setCheck('enableWmm', currentWlan.wmmEnable)
        if (ssidAccessAttr.indexOf('Subscriber') < 0)
        {
            if (1 == BjcuFlag)
            {
                setDisable('wlSsid1',1);
                setDisable('wlSsid2',1);
            }
            else
            {
                setDisable('wlSsid1',1);
            }
        }

        beaconTypeChange(currentWlan.BeaconType);
    }
}

function addWPSModeOption(value)
{
    var len = document.forms[0].wlWPSMode.options.length;
    var existPushBut = 0;
	var pbc_open_2g = 0;
	var pbc_open_5g = 0;
	var pbc_open_2g_index = 0;
	var pbc_open_5g_index = 0;
	var ssidindex = 0;

    for (i = 0; i < len; i++)
    {
        document.forms[0].wlWPSMode.remove(0);
    }
    
    for (i = 0; i < Wlan.length; i++)
    {
        if ((wpsPinNum[i].X_HW_ConfigMethod == 'PushButton') && (true == wpsPinNum[i].Enable) 
        && ((((Wlan[i].BeaconType == 'WPA2') || (Wlan[i].BeaconType == '11i')) && (Wlan[i].IEEE11iAuthenticationMode == 'PSKAuthentication'))
            || ((Wlan[i].BeaconType == 'WPA') && (Wlan[i].WPAAuthenticationMode == 'PSKAuthentication'))
            || (((Wlan[i].BeaconType == 'WPAand11i') || (Wlan[i].BeaconType == 'WPA/WPA2')) && (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'PSKAuthentication'))
            || ((Wlan[i].BeaconType == 'WPA3') && (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'SAEAuthentication'))
            || ((Wlan[i].BeaconType == 'WPA2/WPA3') && (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'PSKandSAEAuthentication')))) {
			ssidindex = getWlanPortNumber(Wlan[i].name);
			
			if ((ssidindex >= 0) && (ssidindex < 4))
			{
				pbc_open_2g = 1;
				pbc_open_2g_index = i;
			}
			
			if (ssidindex >=4)
			{
				pbc_open_5g = 1;
				pbc_open_5g_index = i;
			}
        }
    }

    if (scnFT == 1) {
        if (scnVar == 1) {
            document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pbc'], "PBC");
            return;
        }
    }

	if ((((0 == pbc_open_2g) || ((1 == pbc_open_2g) && (value == pbc_open_2g_index))) && (wlanpage == '2G'))
	|| (((0 == pbc_open_5g) || ((1 == pbc_open_5g) && (value == pbc_open_5g_index)))  && (wlanpage == '5G')))
	{
		document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pbc'], "PBC");
		document.forms[0].wlWPSMode[1] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "PIN");
		document.forms[0].wlWPSMode[2] = new Option(cfg_wlancfgother_language['amp_wpsmode_appin'], "AP-PIN");
	}
	else
	{
		document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "PIN");
		document.forms[0].wlWPSMode[1] = new Option(cfg_wlancfgother_language['amp_wpsmode_appin'], "AP-PIN");
	}
   
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if (temp == 'null')
		{
			if(CuOSGIMode == "1")
			{
				CusetLineHighLight(objTR);
			}
			else
			{
			setLineHighLight(objTR);
			}
		    setControl(-1);
			setDisable('btnApply',0);
			setDisable('btnCancel',0);
		}
        else if (temp == 'no')
        {
            setControl(-2);
            setDisable('btnApply',0);
			setDisable('btnCancel',0);
        }
		else
		{
			var index = parseInt(temp);
			setControl(index);
            if(CuOSGIMode == "1")
			{
				CusetLineHighLight(objTR);
			}
			else
			{
            setLineHighLight(objTR);
			}
			setDisable('btnApply',1);
			setDisable('btnCancel',1);
		}
	}
}

function loadssid(tableRow, maxssidband)
{
    setDisplay('cfg_table', 0);
    if (tableRow.rows.length > 2)
    {
        tableRow.deleteRow(tableRow.rows.length-1);
    }

    if (maxssidband == 4)
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
    }
    else
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_8max']);
    }

    LoadFrame();
}

function setControl(idIndex)
{
    var tableRow = getElement("wlanInst");
    var IsDefaultWlaninst = 1;

    ClearPsdModFlag();

    if (-1 == idIndex)
    {
		if (DoubleFreqFlag == 1)
		{
			if ( (wlanpage == '2G' && SsidNum2g >= 4) || (wlanpage == '5G' && SsidNum5g >= 4) )
			{
				loadssid(tableRow, 4);
				return;
			}
		}
		else
		{
			if ( SsidNum2g >= 4 )
			{
				loadssid(tableRow, 4);
				return;
			}
		}
        
        ssidIdx = -1;
        AddFlag = true;
        currentWlan = new stWlan();
        currentWlan.wlHide = 1;
        currentWlan.wmmEnable = 1;
        currentWlan.ssid = "";

        if (maxStaNum == '64') {
           currentWlan.DeviceNum = 64;
        } else if (maxStaNum == '128') {
            currentWlan.DeviceNum = 128;
        } else if (maxStaNum == '40') {
            currentWlan.DeviceNum = 40;
        } else {
            currentWlan.DeviceNum = 32;
        }

        setDisplay('securityCfg',0);
    }
    else
    {
        setDisplay('cfg_table', 1);
        setDisplay('securityCfg',1);
        ssidIdx = parseInt(WlanMap[idIndex].index);
        AddFlag = false;
        currentWlan = Wlan[ssidIdx];
        
        addWPSModeOption(ssidIdx);    
           
        if (1 == TelMexFlag)
        {
            keyIndexChange(currentWlan.KeyIndex);
        }

        var curWlaninst = getWlanInstFromDomain(currentWlan.domain);
        if ((1 != curWlaninst) && (5 != curWlaninst))
        {
            IsDefaultWlaninst = 0;
        }
    }
    
    showWlan(currentWlan);
    if (AddFlag == false) {
        InitWepOriginLen();
    }

    if ((((IsDefaultWlaninst != 1) && (curWebFrame == 'frame_CMCC')) || (1 == gzcmccFlag)) && (curUserType == sptUserType))
    {
        setDisable('btnApplySubmit', 1);
        setDisable('cancel', 1);
    }
    else
    {
        setDisable('btnApplySubmit', 0);
        setDisable('cancel', 0);
    }

    if (((curWebFrame == 'frame_CMCC') || (1 == gzcmccFlag)) && (curUserType == sptUserType) )
    {
        setDisable('btnApplySubmit2', 1);
        setDisable('cancelButton', 1);
    }
    else
    {
        setDisable('btnApplySubmit2', 0);
        setDisable('cancelButton', 0);    
    }

    if ((curWebFrame == 'frame_UNICOM') || (curWebFrame == 'frame_LNUNICOM')) {          
        CustomsizeCUAvailable();
    }

    if (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_NON_FIRST_SSID_FORBIDDON);%>')
    {
		if(IsDefaultWlaninst != 1) 
		{
			setDisable('btnApplySubmit', 1);
			setDisable('cancel', 1);
		}
		else
		{
			setDisable('btnApplySubmit', 0);
			setDisable('cancel', 0);
		}
    }	
	
	if ((((2 == idIndex) || (3 == idIndex)) || ((1 == idIndex) && (curUserType == sptUserType))) && (CfgMode == 'JLCU')) 
    {
        setDisable('btnApplySubmit', 1);
        setDisable('cancel', 1);
    }	
}

function selectRemoveCnt(curCheck)
{
}

function clickRemove(tabTitle)
{
    btnRemoveWlanCnt();
}

var del_array = '';
function addDeleteDomain(SubmitForm)
{    
    var rml = getElement('rml');    
    if (rml == null)        
        return;
    
    with (document.forms[0])
    {
        if (rml.length > 0)
        {
            for (var i = 0; i < rml.length; i++)
            {
                if (rml[i].checked == true)
                {
                    wlandomain = rml[i].value;       
					var DelInst = wlandomain.substring(wlandomain.length-1);					
					del_array = del_array + DelInst + ",";			
					SubmitForm.addParameter(wlandomain, '');
                }
            }
        }
        else if (rml.checked == true)
        {
            wlandomain = rml.value;
			var DelInst = wlandomain.substring(wlandomain.length-1);
			del_array = del_array + DelInst + ",";
            SubmitForm.addParameter(wlandomain, '');
        }        
    }
}

function delAjaxRequest()
{
	var Form = new webSubmitForm();    
	addDeleteDomain(Form);
	Form.setAction('del.cgi?RequestFile=html/amp/wlanbasic/wlan.asp');
	DisableButtons();	
	
	if (del_array == '')
	{
		return;
	}
	
	del_array = del_array.substring(0, del_array.length-1);
	
	$.ajax({
		 type : "POST",
		 async : true,
		 cache : false,
		 data : "y.DeleteInstArray="+del_array+"&x.X_HW_Token="+getValue('onttoken'),
		 url : "set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.ParallelDelSsid&RequestFile=html/amp/wlanbasic/wlan.asp",
		 success : function(data) {
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
		 },
		 complete: function (XHR, TS) {
			XHR=null;
		 }
	});
}

function btnRemoveWlanCnt()
{
    if (AddFlag == true)
    {
        if (WlanMap.length == 0)
        {
            AlertEx(cfg_wlancfgother_language['amp_ssid_select']);
            return ;
        }
        
       AlertEx(cfg_wlancfgother_language['amp_ssid_del']);
       return;
    }
    var rml = getElement('rml');
    var noChooseFlag = true;    
    if ( rml.length > 0)
    {
        for (var i = 0; i < rml.length; i++)
        {
            if (rml[i].checked == true)
            {
                noChooseFlag = false;
            }
        }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
    }

    if ( noChooseFlag )
    {   
        AlertEx(cfg_wlancfgother_language['amp_ssid_select']);
        return ;
    }

    if (ConfirmEx(cfg_wlancfgother_language['amp_delssid_confirm']) == false)
        return;

	delAjaxRequest();
}

function cancelValue()
{
    $("#checkinfo1Row").css("display", "none");
    $("#checkinfo2Row").css("display", "none");
    $("#checkinfo3Row").css("display", "none");
    $("#checkinfo4Row").css("display", "none");
    $("#checkinfo5Row").css("display", "none");
    if (AddFlag == true)
    {
        var tableRow = getElement("wlanInst");
        selectLine('record_0');
        
        tableRow.deleteRow(tableRow.rows.length-1);
    }
    else
    {
        var currentWlan = Wlan[ssidIdx];
        showWlan(currentWlan);
    } 

    ClearPsdModFlag();
}

function expandMenu()
{
    if (curUserType == sysUserType)
    {
       var menuID = 'link_Admin_3_1';
    }
    else
    {
       var menuID = 'link_User_3_1';
    }
   
    window.parent.frames["menufrm"].clickMenuLink(menuID);
}

var hide = cfg_wlancfgdetail_language['amp_bcastssid_help'];
var wmm = cfg_wlancfgdetail_language['amp_vmm_help'];
var authmode = cfg_wlancfgdetail_language['amp_authmode_help'];
var encryption = cfg_wlancfgdetail_language['amp_encrypt_help'];
var ssid = cfg_wlancfgdetail_language['amp_ssid_help'];
var deviceNumber = cfg_wlancfgdetail_language['amp_devnum_help'];
var posswordComplexTitle = cfg_wlancfgdetail_language['amp_wlanpasswordcomplex_title'];

function stWifi(domain,dtimPeriod,beaconPeriod,rtsThreshold,fragThreshold)
{
    this.domain = domain;
    this.dtimPeriod = dtimPeriod;
    this.beaconPeriod = beaconPeriod;
    this.rtsThreshold = rtsThreshold;
    this.fragThreshold = fragThreshold;
}

function stWlanWifi(domain,name,enable,ssid,mode,channel,power,Country,AutoChannelEnable,channelWidth,PossibleChannels,wmmEnable)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.mode = mode;
    this.channel = channel;
    this.power = power;
    this.RegulatoryDomain = Country;
    this.AutoChannelEnable = AutoChannelEnable;
    this.channelWidth = channelWidth;
    this.PossibleChannels = PossibleChannels;
    this.wmmEnable = wmmEnable;
}

function stLanDevice(domain, WlanCfg, Wps2)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
    this.Wps2 = Wps2;
}
var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable|X_HW_Wps2Enable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];
var Wps2 = LanDevice.Wps2;


var Wifis = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AdvanceConf,DtimPeriod|BeaconPeriod|RTSThreshold|FragThreshold,stWifi);%>;
var Wifi = Wifis[0];

var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|PossibleChannels|WMMEnable,stWlanWifi);%>;
var WlanWifi = WlanWifiArr[0];
if (null == WlanWifi)
{
    WlanWifi = new stWlanWifi("","","","","11n","","","","","","");
}


function WlanWifiInitFor5G()
{
    if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
    {
        for (i=0; i < WlanWifiArr.length - 1; i++)
        {
            if ('ath4' == WlanWifiArr[i].name)
            {
                Wifi = Wifis[i];
                WlanWifi = WlanWifiArr[i];
                break;
            }
        }
    }
}

WlanWifiInitFor5G();



function advanceEnable()
{
    if (getCheckVal('advanceEnbl') == 1)
    {
        setDisplay('adConfig',1);
    }
    else
    {
        setDisplay('adConfig',0);
    }
}

function getPossibleChannels(freq, country, mode, width)
{
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "../common/WlanChannel.asp?&1=1",
            data :"freq="+freq+"&country="+country+"&standard="+mode + "&width="+width,
            success : function(data) {
                possibleChannels = data;
            }
        });
}

function loadChannelListByFreq(freq, country, mode, width)
{
    var len = document.forms[0].wlChannel.options.length;
    var index = 0;
    var i;
    var WebChannel = getSelectVal('wlChannel');
    var WebChannelValid = 0;    

    getPossibleChannels(freq, country, mode, width);
    var ShowChannels = possibleChannels.split(',');

    for (i = 0; i < len; i++)
    {
        document.forms[0].wlChannel.remove(0);
    }

    document.forms[0].wlChannel[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");
    
    for (var j=1; j<=ShowChannels.length; j++)
    {
        if(j==ShowChannels.length)
        {
            for(i = 0; i < ShowChannels[ShowChannels.length-1].length;i++)
            {
                if((ShowChannels[ShowChannels.length-1].charCodeAt(i)< 0x30)||(ShowChannels[ShowChannels.length-1].charCodeAt(i) > 0x39))
                {
                    index = i;
                    break;
                    
                }
            }
            ShowChannels[j-1] = ShowChannels[ShowChannels.length-1].substring(0,index);
        }
        
        if (WebChannel == ShowChannels[j-1])
        {
            WebChannelValid = 1;
        }
        document.forms[0].wlChannel[j] = new Option(ShowChannels[j-1], ShowChannels[j-1]);
    }

    if (1 == WebChannelValid)
    {
        setSelect('wlChannel', WebChannel);
    }
    else
    {
        setSelect('wlChannel', 0);    
    }
}

function loadChannelList(country, mode, width)
{
    var freq = '2G';

    if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
    {
        freq = '5G';
    }

    loadChannelListByFreq(freq, country, mode, width);
}

function ChangeCountry()
{
    var country = getSelectVal('RegulatoryDomain');
    var mode = getValue('wlgMode');
	var Width = getSelectVal('channelWidth');
    loadChannelList(country, mode, Width);
}

function setCountry()
{
    setSelect('RegulatoryDomain', WlanWifi.RegulatoryDomain);
    ChangeCountry();
}

function gModeChange()
{
    var mode = getSelectVal('wlgMode');
    var channelWidth = getSelectVal('channelWidth');
    var channel = getSelectVal('wlChannel');
    var country = getSelectVal('RegulatoryDomain');

    var len = document.forms[0].channelWidth.options.length;
    var lenChannel = document.forms[0].wlChannel.options.length;
    
    if ((14 == channel) && ("11b" != mode))
    {
        setSelect('wlChannel', 0);
    }

    for (i = 0; i < len; i++)
    {
        document.forms[0].channelWidth.remove(0);
    }

    if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
    {
        if (mode == "11a") {
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        } else {
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
            if (mode == "11ac") { 
                document.forms[0].channelWidth[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
                if (capHT160 == 1) {
                    document.forms[0].channelWidth[4] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
                }
            }
            
            if (mode == "11ax") { 
                document.forms[0].channelWidth[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
                document.forms[0].channelWidth[4] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
            }
        }
    }
    else
    {
        if ((mode == "11b") || (mode == "11g") || (mode == "11bg"))
        {    
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");                
        }
        else
        {
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
        }
    }

    setSelect('channelWidth', channelWidth);

    loadChannelList(country, mode, getSelectVal('channelWidth'));
} 

function ChannelChange()
{
}

function ChannelWidthChange()
{
    var country = getSelectVal('RegulatoryDomain');
    var mode = getValue('wlgMode');
    var Width = getSelectVal('channelWidth');
    loadChannelList(country, mode, Width);
}

function LoadFrameWifi()
{        
    if (capBcnInerval == 1) {
        $('#BeaconPeriod').attr('title', cfg_wlancfgadvance_language['amp_beacon_timenote']);
        getElementById('BeaconPeriodRemark').innerHTML = cfg_wlancfgadvance_language['amp_beacon_timenote'];
    } else {
        $('#BeaconPeriod').attr('title', cfg_wlancfgadvance_language['amp_beacon_timenote_bcn']);
        getElementById('BeaconPeriodRemark').innerHTML = cfg_wlancfgadvance_language['amp_beacon_timenote_bcn'];
    }

    if (enbl == 1)
    {
        if (Wifi == null || WlanWifi == null )
        {
            setDisplay('wifiCfg',0);
        }
        else
        {
            loadChannelList(WlanWifi.RegulatoryDomain,WlanWifi.mode, WlanWifi.channelWidth);
            setDisplay('adConfig',1);
            setDisplay('wifiCfg',1);
            setCheck('advanceEnbl',1);
            setSelect('wlTxPwr',WlanWifi.power);
            setSelect('RegulatoryDomain',WlanWifi.RegulatoryDomain);
            setSelect('wlgMode',WlanWifi.mode);
            if (WlanWifi.AutoChannelEnable == 1)
            {
                setSelect('wlChannel',0);
            }
            else
            {   
                setSelect('wlChannel',WlanWifi.channel);
            }
            setSelect('channelWidth',WlanWifi.channelWidth);
            if ((WlanWifi.channelWidth == 4) && (isCheckDfsSignal == 1)) {
                setDisplay('Title_wlan_dfs_tips_lable', 1);
            }

            setText('dtimPeriod',Wifi.dtimPeriod);
            setText('beaconPeriod',Wifi.beaconPeriod);
            setText('rtsThreshold',Wifi.rtsThreshold);
            setText('fragThreshold',Wifi.fragThreshold);
        }
        
        if ((WlanWifi.mode == "11b") || (WlanWifi.mode == "11g") || (WlanWifi.mode == "11bg") || (WlanWifi.mode == "11a")) {
            var len = document.forms[0].channelWidth.options.length;
            for (i = 0; i < len; i++)
            {
                document.forms[0].channelWidth.remove(0);                
            }

            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        } else if ((wlanpage == "5G") && ((WlanWifi.mode == "11na") || (WlanWifi.mode == "11n"))) {
            var len = document.forms[0].channelWidth.options.length; 
            for (i = 0; i < len; i++) {
                if (document.forms[0].channelWidth[i].innerText == cfg_wlancfgadvance_language['amp_chlwidth_auto204080']) {
                    document.forms[0].channelWidth.remove(i); 
                    break;
                }             
            }
        }
    }
    else
    {
        setDisplay('wifiCfg',0);
        setDisplay('adConfig',0);
    }
    
    if (((curWebFrame == 'frame_CMCC') || (1 == gzcmccFlag)) && (curUserType == sptUserType))
    {
        setDisable('btnApplySubmit2', 1);
        setDisable('cancelButton', 1);
    }
    
    addAuthModeOption();
    addwlgModeOption();

    if ((curWebFrame == 'frame_UNICOM') || (curWebFrame == 'frame_LNUNICOM')) {           
        CustomsizeCUAvailable();
    }
}

function CustomsizeCUAvailable()
{
    if ((curUserType != sysUserType) && (CfgMode != 'BJCU' && CfgMode != 'BJUNICOM')) {
        setDisplay('BtnAdd', 0);
        setDisplay('BtnRemove',0);

        setDisplay('wifiCfg',0);
    }
	
	if ((CfgMode == 'JLCU') || (CfgMode == 'HEBCU'))
    {
        setDisplay('BtnAdd', 0);
        setDisplay('BtnRemove',0);
	}

    if (('basic' != currentPageURLFlag) && ('secuty' != currentPageURLFlag) && ('advanced' != currentPageURLFlag))
    {
        currentPageURLFlag = top.unicomWlanPage;
    }
    
    if(currentPageURLFlag == 'basic')
    {    
        setDisplay('tr_wlan_basic_ssid_device_number',0); 
        setDisplay('tr_wlan_basic_ssid_wmm_enable',0);   
        
        setDisplay('securityCfg',0);    
        setDisplay('wlEncryMethod',0); 

        setDisplay('wifiCfg',0);
        setDisplay('adConfig',0); 
        top.unicomWlanPage = 'basic';
    }
    else if(currentPageURLFlag == 'secuty') 
    {
        setDisplay('table_wlan_basic_config',0);
        setDisplay('table_wlan_Enable_check_box',0);
        
        setDisplay('wifiCfg',0);
        setDisplay('adConfig',0); 
		setDisplay('BtnAdd', 0);
        setDisplay('BtnRemove',0);
        top.unicomWlanPage = 'secuty';
    }
	else if (currentPageURLFlag == 'advanced')
    {
        setDisplay('wlanCfg',0);

        setDisplay('tr_wlan_basic_ssid_device_number',0); 
        setDisplay('tr_wlan_basic_ssid_wmm_enable',0);   

        setDisplay('securityCfg',0);    
        setDisplay('wlEncryMethod',0); 
		setDisplay('BtnAdd', 0);
        setDisplay('BtnRemove',0);
        setDisplay('table_wlan_basic_config',0);
        setDisplay('table_wlan_Enable_check_box',0);

        top.unicomWlanPage = 'advanced';
    }



    if (sptUserType == curUserType)
    {
        var td = document.getElementById('TDAmpWlanTitle');
        if (td != null && td.getAttribute("BindText") != null)
        {
            if (currentPageURLFlag == 'basic')
            {
                td.setAttribute('BindText', 'amp_wlan_title_CU_BASIC');
            }
            else
            {
                td.setAttribute('BindText', 'amp_wlan_title_CU_SECUTY');
            }
        }
    }
}

function CancelConfig()
{
    setSelect('wlTxPwr',WlanWifi.power);
    setSelect('RegulatoryDomain',WlanWifi.RegulatoryDomain);
    setSelect('channelWidth',WlanWifi.channelWidth);
    setSelect('wlgMode',WlanWifi.mode);
    
	gModeChange();
	
    if (WlanWifi.AutoChannelEnable == 1)
    {
        setSelect('wlChannel',0);
    }
    else
    {   
        setSelect('wlChannel',WlanWifi.channel);
    }
    
    setText('dtimPeriod',Wifi.dtimPeriod);
    setText('beaconPeriod',Wifi.beaconPeriod);
    setText('rtsThreshold',Wifi.rtsThreshold);
    setText('fragThreshold',Wifi.fragThreshold);
    InitWallMode();
}

function CheckConfigChannel(selChannel) {
    if ((selChannel == 0) || (selChannel == -1)) {
        return false;
    }

    return (selChannel != WlanWifi.channel);
}

function AddSubmitParam(Form,type)
{
    var selChannel = getSelectVal('wlChannel');
    Form.addParameter('y.Channel',selChannel);
    if (selChannel == 0) {
        Form.addParameter('y.AutoChannelEnable',1); 
    } else {
        Form.addParameter('y.AutoChannelEnable',0);
    }

    var wallModeSel = getSelectVal('wallMode_select');
    Form.addParameter('y.X_HW_HT20',getSelectVal('channelWidth')); 
    Form.addParameter('y.RegulatoryDomain',getSelectVal('RegulatoryDomain'));
    if (wallModeSel == 1) {
        Form.addParameter('y.TransmitPower', 100);
    } else {
        Form.addParameter('y.TransmitPower',getSelectVal('wlTxPwr'));
    }
    Form.addParameter('y.X_HW_Standard',getSelectVal('wlgMode'));

    
    Form.addParameter('r.Enable', wallModeSel);
    if ((DoubleFreqFlag == 1) && (wallModeSel == 1)) {
        Form.addParameter('s.TransmitPower', 100);
    }

    if (getCheckVal('advanceEnbl') == 1)
    {
        var dtimPeriod = parseInt(getValue('dtimPeriod'),10);
        var beaconPeriod = parseInt(getValue('beaconPeriod'),10);
        var rtsThreshold = parseInt(getValue('rtsThreshold'),10);
        var fragThreshold = parseInt(getValue('fragThreshold'),10);
        
        Form.addParameter('x.DtimPeriod',dtimPeriod);
        Form.addParameter('x.BeaconPeriod',beaconPeriod);
        Form.addParameter('x.RTSThreshold',rtsThreshold);
        Form.addParameter('x.FragThreshold',fragThreshold);
    } 

    var urlSet = 'set.cgi?';
    var configAction = 'InternetGatewayDevice.X_HW_DEBUG.WLANConfigAction';
    if (!CheckConfigChannel(selChannel)) {
        urlSet += 'c1=' + configAction + '&';
        Form.addParameter('c1.ActionType', 0);
    }

    urlSet += 'r=InternetGatewayDevice.LANDevice.1.WiFi.X_HW_WallModeForChina&';
    if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
        urlSet += 'x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_AdvanceConf&' +
                  'y=' +  WlanWifi.domain + '&' +
                  'z=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2&';
        if (wallModeSel == 1) {
            urlSet += 's=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1&';
        }
    } else {
        urlSet += 'x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_AdvanceConf&' +
                  'y=' +  WlanWifi.domain + '&' +
                  'z=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&';
        if ((DoubleFreqFlag == 1) && (wallModeSel == 1)) {
            urlSet += 's=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5&';
        }  
    }

    if (!CheckConfigChannel(selChannel)) {
        urlSet += 'c2=' + configAction + '&';
        Form.addParameter('c2.ActionType', 1);
        Form.addParameter('c2.SSIDList', '' + getInstIdByDomain(Wlan[ssidIdx].domain));
    }
    urlSet += 'RequestFile=html/amp/wlanbasic/wlan.asp';
    Form.setAction(urlSet);

    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
    setDisable('btnApplySubmit2', 1);
    setDisable('cancelButton', 1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
}

var processingState = 0;
function checkProcessingState() {
    getProcessingState();
    return processingState === '1';
}

function getProcessingState() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../wlanadv/getProcessState.asp",
        success : function(data) {
            processingState = data;
        }
    });
}

function CheckForm(type)
{
    if (checkProcessingState()) {
        AlertEx(cfg_wlancfgadvance_language['amp_config_busy']);
        return false;
    }
    if((getSelectVal('wlTxPwr') == "") || (getSelectVal('RegulatoryDomain') == "") || (getSelectVal('wlChannel') == "") 
        || (getSelectVal('wlgMode') == "") || (getSelectVal('channelWidth') == ""))
    {
        AlertEx(cfg_wlancfgother_language['amp_basic_empty']);
        return false;
    }

    if (getCheckVal('advanceEnbl') == 1)
    {
        var dtimPeriod = getValue('dtimPeriod');
        var beaconPeriod = getValue('beaconPeriod');
        var rtsThreshold = getValue('rtsThreshold');
        var fragThreshold = getValue('fragThreshold'); 
        
        if((dtimPeriod == "") || (beaconPeriod == "")
           || (rtsThreshold == "") || (fragThreshold == ""))
        {
            AlertEx(cfg_wlancfgother_language['amp_advance_empty']);
            return false;
        }

        if(!isPlusInteger(dtimPeriod) || !isValidDecimalNum(dtimPeriod))
        {
            AlertEx(cfg_wlancfgadvance_language['amp_dtimtime_int']);
            return false;
        }
        else
        {
            if((parseInt(dtimPeriod,10) < 1) || (parseInt(dtimPeriod,10) > 255))
            {
                AlertEx(cfg_wlancfgadvance_language['amp_dtimtime_range']);
                return false;
            }
        }           
        
        if(!isPlusInteger(beaconPeriod) || !isValidDecimalNum(beaconPeriod))
        {
            AlertEx(cfg_wlancfgadvance_language['amp_beacon_int']);
            return false;
        }
        else
        {
            var minBeaconPeriod = 100;
            var beaconRangeAlert = '';
            if (capBcnInerval == 1) {
                minBeaconPeriod = 20;
                beaconRangeAlert = cfg_wlancfgadvance_language['amp_beacon_range'];
            } else if (capBcnInerval == 0) {
                minBeaconPeriod = 100;
                beaconRangeAlert = cfg_wlancfgadvance_language['amp_beacon_range_bcn'];
            }

            if ((parseInt(beaconPeriod, 10) < minBeaconPeriod) || (parseInt(beaconPeriod, 10) > 1000)) {
                AlertEx(beaconRangeAlert);
                return false;
            }
        }       
        
        if(!isPlusInteger(rtsThreshold) || !isValidDecimalNum(rtsThreshold))
        {
            AlertEx(cfg_wlancfgadvance_language['amp_rts_int']);
            return false;
        }
        else
        {
            if((parseInt(rtsThreshold,10) < 1) || (parseInt(rtsThreshold,10) > 2346))
            {
                AlertEx(cfg_wlancfgadvance_language['amp_rts_range']);
                return false;
            }
        }
        
        if(!isPlusInteger(fragThreshold) || !isValidDecimalNum(fragThreshold))
        {
            AlertEx(cfg_wlancfgadvance_language['amp_frag_int']);
            return false;
        }
        else
        {
            if((parseInt(fragThreshold,10) < 256) || (parseInt(fragThreshold,10) > 2346))
            {
                AlertEx(cfg_wlancfgadvance_language['amp_frag_range']);
                return false;
            }
        }
    }   

    return true;
}


function wlanWriteTabHeader(tabTitle, width, titleWidth, type)
{
    if (width == null)
        width = "70%";
        
    if (titleWidth == null)
       titleWidth = "120";
            
    var html = 
            "<table width=\"" + width + "\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
            + "<tr>"
            + "<td>"
            + "<table class=\"width_per100\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
            + "<tr class=\"tabal_head\">"
            + " <td class=\"width_per35\" BindText=\"amp_wlan_basic\"><\/td>"
            + "<td class=\"align_right\">"
            + "<table class=\"width_per100\" border=\"0\" cellpadding=\"1\" cellspacing=\"0\">"
            + "<tr class=\"align_right\">";

        html +=  '<td></td><td class="align_right" width="40">'
                 + '<input name="BtnAdd" id="BtnAdd" type="button" class="submit" value="' + cfg_wlancfgother_language['amp_wlan_new'] + '" '
                 + 'onclick="clickAdd(\'' + tabTitle + '\');" />'     
                 + '</td><td class="align_right" width="42">'
                 + '<input name="BtnRemove" id="BtnRemove" type="button" class="submit" value="' + cfg_wlancfgother_language['amp_wlan_del'] + '" ' 
                 + 'onclick="clickRemove(\''
                 + tabTitle + '\');" />'
                 + '</td><td width="3"></td>';
    
        html += "<\/tr>"
                + "<\/table>"
                + "<\/td>"
                + "<\/tr>"
                + "<\/table>"
                + "<\/td>"
                + "<\/tr>"
                + "<tr>"
                + "<td id=\"" + tabTitle + "\">";
    
    document.write(html);
}

function wlanWriteTabCfgHeader(tabTitle, tabWidth,titleWidth)
{
    wlanWriteTabHeader(tabTitle,tabWidth,titleWidth,'cfg');
}

function wlanWriteTabTail()
{
    document.write("<\/td><\/tr><\/table>");
}

function SetStyleValue(Id, Value)
{
    try
    {
        var Div = document.getElementById(Id);
        Div.setAttribute("style", Value);
        Div.style.cssText = Value;
    }
    catch(ex)
    {
    }
}

function LoadMaxNumResource() {
    if (maxStaNum == '128') {
        getElById('SpanDeviceNum').innerHTML = cfg_wlancfgdetail_language['amp_AssociateNum_note_128'];
        getElById('TdDeviceNum').title = cfg_wlancfgdetail_language['amp_devnum_help_128'];
    } else if (maxStaNum == '64') {
        getElById('SpanDeviceNum').innerHTML = cfg_wlancfgdetail_language['amp_AssociateNum_note_64'];
        getElById('TdDeviceNum').title = cfg_wlancfgdetail_language['amp_devnum_help_64'];
    }else if (maxStaNum == '40') {
        getElById('SpanDeviceNum').innerHTML = cfg_wlancfgdetail_language['amp_AssociateNum_note_40'];
        getElById('TdDeviceNum').title = cfg_wlancfgdetail_language['amp_devnum_help_40'];
    }
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();LoadFrameWifi();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
          <td id = 'TDAmpWlanTitle' class="title_common" BindText='amp_wlan_title'></td>
                </tr>
                
                 <tr> 
      <td class="title_common">  
      <div>    
      <table>
          <tr> 
            <td class='width_per15 align_left'><img style="margin-bottom:2px" src="../../../images/icon_01.gif" width="15" height="15" /></td> 
            <td class='width_per85 align_left'><script>document.write(cfg_wlancfgother_language['amp_wlan_note1']);</script></td> 
          </tr>
         </table>
     </div>
          <tr><td><script>document.write("1. " + cfg_wlancfgother_language['amp_wlan_note']);</script></td></tr>
          <tr><td>
            <script>
                if ((capWpa3 == 1) && (isShowWpa3Eap == 1)) {
                    document.write("2. " + cfg_wlancfgother_language['amp_wlan_note4']);
                } else {
                    document.write("2. " + cfg_wlancfgother_language['amp_wlan_note2']);
                }
            </script></td></tr>
       </td> 
    </tr> 
            </table>
        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr ><td class="height15p"></td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr ><td>
<form id="ConfigForm" action="../network/set.cgi">
<div id='wlanBasicCfg'>
<table id = 'table_wlan_Enable_check_box' cellspacing="0" cellpadding="0" width="100%"  >
    <tr>
        <td ><input type='checkbox' name='wlEnbl' id='wlEnbl' onClick='EnableSubmit();' value="ON">
          <script>document.write(cfg_wlancfgother_language['amp_wlan_enable']);</script></input></td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="width_10px"></td></tr>
</table>

<div id='wlanCfg'>
<table id="TblBasicParaTitle"  width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none">
    <tr class="tabal_head">
          <td BindText='amp_wlan_basic'></td>
    </tr>
</table>

<script language="JavaScript" type="text/javascript">
if(!((curWebFrame == 'frame_CMCC') && (curUserType == sptUserType)))
{
    wlanWriteTabCfgHeader('Wireless',"100%");
}
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInst">
    <tr class="head_title">
        <td>&nbsp;</td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_id']);</script></div></td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_name']);</script></div></td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_link']);</script></div></td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_link_devnum']);</script></div></td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_bcast_ssid']);</script></div></td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_security_cfg']);</script></div></td>
    </tr>
    <script language="JavaScript" type="text/javascript">
        var iotSsidInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.SyncIotSsidInst);%>';
        for (var i = 0;i < WlanMap.length; i++)
        {   
          	var mapIndex = parseInt(WlanMap[i].index);
			if (1 != DoubleFreqFlag)
			{
				if (WlanMap[i].portIndex > 3)
                {
                    continue;
                }         
			}
			
			if(1 == ShowFirstSSID)
			{
				if ((WlanMap[i].portIndex != 0)&&(WlanMap[i].portIndex != SsidPerBand))
				{
					continue;
				}
			}

            var curWlanInst = getWlanInstFromDomain(Wlan[mapIndex].domain);
            if (curWlanInst == iotSsidInst) {
                continue;
            }

            if(i%2 == 0)
            {
                document.write('<TR id="record_' + i + '" class="tabal_01" onclick="selectLine(this.id);">');
            }
            else
            {
                document.write('<TR id="record_' + i + '" class="tabal_02" onclick="selectLine(this.id);">');
            }
            if((0 == mapIndex) || (4 == parseInt(WlanMap[i].portIndex)))
            {
                document.write('<TD>' + '<input type="checkbox" name="rml" id="rml"'  + ' value="'+ Wlan[mapIndex].domain + '" onclick="selectRemoveCnt(i);" disabled="true" >' + '</TD>');
            }
            else
            {
                document.write('<TD>' + '<input type="checkbox" name="rml" id="rml"'  + ' value="'+ Wlan[mapIndex].domain + '" onclick="selectRemoveCnt(i);">' + '</TD>');
            }
            document.write('<TD>' + getWlanInstFromDomain(Wlan[mapIndex].domain) + '</TD>');
            document.write('<TD>' + htmlencode(Wlan[mapIndex].ssid)+ '</TD>');
            if ((Wlan[mapIndex].enable == 1) && (Wlan[mapIndex].X_HW_ServiceEnable == 1))
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_ssid_enable'] + '</TD>');
            }
            else
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_ssid_disable'] + '</TD>');
            }
            document.write('<TD>' + Wlan[mapIndex].DeviceNum+ '</TD>');
            if (Wlan[mapIndex].wlHide == 1)
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_bcast_enable'] + '</TD>');
            }
            else
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_bcast_disable'] + '</TD>');
            }
            if ((Wlan[mapIndex].BeaconType == 'Basic' && Wlan[mapIndex].BasicAuthenticationMode == 'None' && Wlan[mapIndex].BasicEncryptionModes == 'None') || (Wlan[mapIndex].BeaconType == 'None'))
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_ssid_disauth'] + '</TD>');
            }
            else
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_ssid_enauth'] + '</TD>');
            }
            document.write('</TR>');
        }
    </script>
</table>
<script language="JavaScript" type="text/javascript">
if(!((curWebFrame == 'frame_CMCC') && (curUserType == sptUserType)))
{
    wlanWriteTabTail();
}    
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height5p"></td></tr>
</table>
<div id="ssidDetail">
<table width="100%" border="0" cellpadding="0" cellspacing="1" id="cfg_table">
 
      <tr>
        <td colspan="6">
            <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr class="tabal_head">
                    <td BindText='amp_ssid_detail'></td>
                </tr>
            </table>
            <table id = 'table_wlan_basic_config' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                  <td class="table_title width_per25" BindText='amp_link_name'></td>
                  <td class="table_right" id="TdSSID">
                      <script language="JavaScript" type="text/javascript">
                          {
                              document.write('<input type="text" name="wlSsid1" id="wlSsid1" maxlength="32">');
                              document.write('<input type="text" name="wlSsid2" id="wlSsid2" style="width:123px" maxlength="32">');                      
                          }
                      </script>            
                      <font class="color_red">*</font><span class="gray">
                      <script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></span> 
                 </td>
                </tr>
                <tr>
                    <td class="table_title width_per25" BindText='amp_link_status'></td>
                    <td class="table_right" id="TdEnable">
                        <input type='checkbox' id='wlEnable' name='wlEnable' value="ON" onClick="SsidEnable();">
                        <span class="gray"> </span></td>
                </tr>
                <tr id = "tr_wlan_basic_ssid_device_number">
                    <td class="table_title width_per25" BindText='amp_link_cdevnum'></td>
                    <td  class="table_right" id="TdDeviceNum">
                        <input type='text' id='X_HW_AssociateNum' name='X_HW_AssociateNum' size='10' class="width_123px">
                        <font class="color_red">*</font><span id='SpanDeviceNum' class="gray"> 
                        <script>document.write(cfg_wlancfgdetail_language['amp_AssociateNum_note']);</script></span> 
                    </td>
                </tr>
                <tr>
                      <td class="table_title width_per25" BindText='amp_bcast_cssid'></td>
                    <td class="table_right" id="TdHide">
                        <input type='checkbox' id='wlHide' name='wlHide' value="ON">
                        <span class="gray"> </span></td>
                </tr>
                <tr id = "tf_wlan_basic_ssid_wmm_enable">
                    <td class="table_title width_per25" BindText='amp_multi_mdia'></td>
                    <td class="table_right" id="TdWMM">
                        <input type='checkbox' id='enableWmm' name='enableWmm'>
                        <span class="gray"></span></td>
                </tr>
            </table>
            <div id='securityCfg'>
            <div id='wlAuthModeDiv'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_auth_mode'></td>
                    <td class="table_right" id="TdAuth">
                        <select id='wlAuthMode' name='wlAuthMode' size="1" onChange='authModeChange()' class="width_150px">
                          <option value="open" selected><script>document.write(cfg_wlancfgdetail_language['amp_auth_open']);</script></option>
                          <option value="shared"><script>document.write(cfg_wlancfgdetail_language['amp_auth_shared']);</script></option>
                          <option value="wpa-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpapsk']);</script></option>
                          <option value="wpa2-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpa2psk']);</script></option>
                          <option value="wpa/wpa2-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']);</script></option>
                          <option value="wpa3-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpa3psk']);</script></option>
                          <option value="wpa2/wpa3-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk']);</script></option>
                          <option value="wpa"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpa']);</script></option>
                          <option value="wpa2"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpa2']);</script></option>
                          <option value="wpa/wpa2"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpawpa2']);</script></option>
                          <script>
                              if (isShowWpa3Eap == 1) {
                                  document.write("<option value='wpa3'>"+cfg_wlancfgdetail_language['amp_auth_wpa3']+"</option>");
                                  document.write("<option value='wpa2/wpa3'>"+cfg_wlancfgdetail_language['amp_auth_wpa2wpa3']+"</option>");
                              }
                              if (WapiFlag == 1) {
                                  document.write("<option value='wapi-psk'>"+cfg_wlancfgdetail_language['amp_auth_wapi_psk']+"</option>");
                                  document.write("<option value='wapi'>"+cfg_wlancfgdetail_language['amp_auth_wapi']+"</option>");
                              }
                          </script>
                        </select> <span class="gray"> </span></td>
                </tr>
            </table>
            </div>

            <div id='wlEncryMethod'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_mode'></td>
                    <td class="table_right" id="TdEncrypt">
                    <select id = 'wlEncryption' name = 'wlEncryption'  size='1'  onChange='onMethodChange(0);' class="width_150px">
                    </select>
                      </td>
                </tr>
            </table>
            </div>

            <div id='keyInfo'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_keylen'></td>
                    <td colspan="2" class="table_right">
                        <select id='wlKeyBit' name='wlKeyBit' size='1' onChange='wlKeyBitChange()' class="width_150px">
                            <option value="128" selected><script>document.write(cfg_wlancfgdetail_language['amp_encrypt_128key']);</script></option>
                            <option value="64"><script>document.write(cfg_wlancfgdetail_language['amp_encrypt_64key']);</script></option>
                        </select>
                      <span class="gray"> <script>document.write(cfg_wlancfgdetail_language['amp_keylen_note']);</script></span> </td>
                </tr>
                <tr>
                    <td class="table_title width_per25" BindText='amp_key_index'></td>
                    <td colspan="2" class="table_right">
                        <select id='wlKeyIndex' name='wlKeyIndex' size='1' onChange='keyIndexChange(0)' class="width_150px">
                        <script language="JavaScript" type="text/javascript">
                            for (var i = 1; i < 5 ; i++)
                            {
                                document.write("<option value=" + i + ">" + i + "</option>");
                            }
                        </script>
                            </select> <span class="gray"> </span> </td>
                </tr>
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key1'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[0] != null)
                        {
                            document.write("<input type='password' autocomplete='off' id='wlKeys1' onfocus='onFocusToclearPwd_wep1()' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>")
                            document.write("<input type='text' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>");
                        }

                    </script> </td>
                    <td rowspan="4"  class="table_right"> <font class="color_red">*</font> 
                      <input checked type='checkbox' id='hidewlKeys' name='hidewlKeys' value='on' onClick="ShowOrHideText('hidewlKeys', 'wlKeys1', 'twlKeys1', wep1password);ShowOrHideText('hidewlKeys', 'wlKeys2', 'twlKeys2', wep2password);ShowOrHideText('hidewlKeys', 'wlKeys3', 'twlKeys3', wep3password);ShowOrHideText('hidewlKeys', 'wlKeys4', 'twlKeys4', wep4password);"/>
                      <span id="hideId1"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
                      <span class="gray"> <script>document.write(cfg_wlancfgdetail_language['amp_encrypt_keynote']);</script></span> 
                    </td>
                </tr>
                <tr id = "checkinfo1Row" style="display:none;">
                    <td id = "checkinfotitel" class="table_title width_per25" BindText='amp_encrypt_key1_strength'></td>
                    <td id = "checkinfo1" class="table_right"></td>
                    <script>
                    $('#wlKeys1').on('keyup',function(){
                        $("#checkinfo1Row").css("display", "");
                        $("#psd_checkpwd1").css("display", "block");
                        psdStrength1("wlKeys1");
                    });
                    $('#twlKeys1').on('keyup',function(){
                        $("#checkinfo1Row").css("display", "");
                        $("#psd_checkpwd1").css("display", "block");
                        psdStrength1("twlKeys1");
                    });
                    </script>
                </tr>
              
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key2'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[1] != null)
                        {
                            document.write("<input type='password' autocomplete='off' id='wlKeys2' onfocus='onFocusToclearPwd_wep2()' name='wlKeys2' size='20' maxlength=26 onchange=\"wep2password=getValue('wlKeys2');getElById('twlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1])+ "'>")
                            document.write("<input type='text' id='twlKeys2' name='twlKeys2' size='20' maxlength=26  style='display:none'  onchange=\"wep2password=getValue('twlKeys2');getElById('wlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1]) + "'>");
                        }

                    </script> </td>
                </tr>
                <tr id = "checkinfo2Row" style="display:none;">
                    <td id = "checkinfotite2" class="table_title width_per25" BindText='amp_encrypt_key2_strength'></td>
                    <td id = "checkinfo2" class="table_right"></td>
                    <script>
                    $('#wlKeys2').on('keyup',function(){
                        $("#checkinfo2Row").css("display", "");
                        $("#psd_checkpwd2").css("display", "block");
                        psdStrength2("wlKeys2");
                    });
                    $('#twlKeys2').on('keyup',function(){
                        $("#checkinfo2Row").css("display", "");
                        $("#psd_checkpwd2").css("display", "block");
                        psdStrength2("twlKeys2");
                    });
                    </script>
                </tr>

                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key3'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[2] != null)
                        {
                            document.write("<input type='password' autocomplete='off' id='wlKeys3' onfocus='onFocusToclearPwd_wep3()' name='wlKeys3' size='20' maxlength=26 onchange=\"wep3password=getValue('wlKeys3');getElById('twlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>")
                            document.write("<input type='text' id='twlKeys3' name='twlKeys3' size='20' maxlength=26  style='display:none' onchange=\"wep3password=getValue('twlKeys3');getElById('wlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>");
                        }

                    </script> </td>
                </tr>
                <tr id = "checkinfo3Row" style="display:none;">
                    <td id = "checkinfotite3" class="table_title width_per25" BindText='amp_encrypt_key3_strength'></td>
                    <td id = "checkinfo3" class="table_right"></td>
                    <script>
                    $('#wlKeys3').on('keyup',function(){
                        $("#checkinfo3Row").css("display", "");
                        $("#psd_checkpwd3").css("display", "block");
                        psdStrength3("wlKeys3");
                    });
                    $('#twlKeys3').on('keyup',function(){
                        $("#checkinfo3Row").css("display", "");
                        $("#psd_checkpwd3").css("display", "block");
                        psdStrength3("twlKeys3");
                    });
                    </script>
                </tr>
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key4'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[3] != null)
                        {
                            document.write("<input type='password' autocomplete='off' id='wlKeys4' onfocus='onFocusToclearPwd_wep4()' name='wlKeys4' size='20' maxlength=26 onchange=\"wep4password=getValue('wlKeys4');getElById('twlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>")
                            document.write("<input type='text' id='twlKeys4' name='twlKeys4' size='20' maxlength=26  style='display:none' onchange=\"wep4password=getValue('twlKeys4');getElById('wlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>");
                        }

                    </script> </td>
                </tr>
                <tr id = "checkinfo4Row" style="display:none;">
                    <td id = "checkinfotite4" class="table_title width_per25" BindText='amp_encrypt_key4_strength'></td>
                    <td id = "checkinfo4" class="table_right"></td>
                    <script>
                    $('#wlKeys4').on('keyup',function(){
                        $("#checkinfo4Row").css("display", "");
                        $("#psd_checkpwd4").css("display", "block");
                        psdStrength4("wlKeys4");
                    });
                    $('#twlKeys4').on('keyup',function(){
                        $("#checkinfo4Row").css("display", "");
                        $("#psd_checkpwd4").css("display", "block");
                        psdStrength4("twlKeys4");
                    });
                    </script>
                </tr>
            </table>
            </div>

    <div id='wpaPreShareKey'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr>
           <td class="table_title width_per25" id= "wpa_psk">
          <script>
          var authMode = getSelectVal('wlAuthMode'); 
          if(authMode == 'wapi-psk')
          {
                  document.write(cfg_wlancfgdetail_language['amp_wapi_psk']);
          }
          else
          {
                  document.write(cfg_wlancfgdetail_language['amp_wpa_psk']);
          }
          </script>
          </td>
          <td class="table_right">
            <input type='password' autocomplete='off' id='wlWpaPsk' name='wlWpaPsk' size='20' maxlength='64' class="amp_font" onfocus="onFocusToclearPwd_psk()"  onchange="wpapskpassword=getValue('wlWpaPsk');getElById('twlWpaPsk').value=wpapskpassword;" />
            <input type='text' id='twlWpaPsk' name='twlWpaPsk' size='20' maxlength='64' class="amp_font" style='display:none' onchange="wpapskpassword=getValue('twlWpaPsk');getElById('wlWpaPsk').value=wpapskpassword;"/>
            <input checked type="checkbox" id="hidewlWpaPsk" name="hidewlWpaPsk" value="on" onClick="ShowOrHideText('hidewlWpaPsk', 'wlWpaPsk', 'twlWpaPsk', wpapskpassword);"/>
            <span id="hideId2"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
            <font class="color_red">*</font><span class="gray" id="hidewlWpaPsk_note"><script>document.write(cfg_wlancfgdetail_language['amp_wpa_psknote']);</script></span></td>
        </tr>
        <tr id = "checkinfo5Row" style="display:none;">
            <td id = "checkinfotite5" class="table_title width_per25" BindText='amp_wpa_psk_strength'></td>
            <td id = "checkinfo5" class="table_right"></td>
            <script>
            $('#wlWpaPsk').on('keyup',function(){
                $("#checkinfo5Row").css("display", "");
                $("#psd_checkpwd5").css("display", "block");
                psdStrength5("wlWpaPsk");
            });
            $('#twlWpaPsk').on('keyup',function(){
                $("#checkinfo5Row").css("display", "");
                $("#psd_checkpwd5").css("display", "block");
                psdStrength5("twlWpaPsk");
            });
            
            </script>
        </tr>
      </table>
    </div>
    
     <div id='wlWapi'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr>
           <td class="table_title width_per25" BindText='amp_wapi_ip'></td>
           <td class="table_right">
              <input type='text' id='wapiIPAddr' name='wapiIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_wapi_port'></td>
           <td class="table_right">
              <input type='text' id='wapiPort' name='wapiPort' size='20' maxlength='15'>
              <font class="color_red">*</font><span class="gray">
              <script>document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);</script></span> 
          </td>
        </tr>
      </table>
    </div>
    
    <div id='wlRadius'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_srvip'></td>
          <td class="table_right">
              <input type='text' id='wlRadiusIPAddr' name='wlRadiusIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>

            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_radius_srvport'></td>
                    <td class="table_right">
                        <input type='text' id='wlRadiusPort' name='wlRadiusPort' size='20' maxlength='5'>
                        <font class="color_red">*</font><span class="gray">
                        <script>document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);</script></span> 
                    </td>
                </tr>
            </table>

            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_radius_sharekey'></td>
                    <td class="table_right">
                        <input type='password' autocomplete='off' id='wlRadiusKey' name='wlRadiusKey' size='20' maxlength='64' class="amp_font" onchange="radiuspassword=getValue('wlRadiusKey');getElById('twlRadiusKey').value=radiuspassword;" />
                        <input type='text' id='twlRadiusKey' name='twlRadiusKey' size='20' maxlength='64' class="amp_font" style='display:none'  onchange="radiuspassword=getValue('twlRadiusKey');getElById('wlRadiusKey').value=radiuspassword;"/>
                        <input checked type="checkbox" id="hidewlRadiusKey" name="hidewlRadiusKey" value="on" onClick="ShowOrHideText('hidewlRadiusKey', 'wlRadiusKey', 'twlRadiusKey', radiuspassword);"/>
                        <font class="color_red">*</font><span class="gray">
                        <span id="hideId3"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
                    </td>
                </tr>
            </table>
            </div>

            <div id='wpaGTKRekey'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_wpakey_time'></td>
                    <td class="table_right"><input type='text' id='wlWpaGtkRekey' name='wlWpaGtkRekey' size='20' maxlength='10' value='3600' class="amp_font">
                    <font class="color_red">*</font><span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_wpakey_timenote']);</script></span></td>
                </tr>
            </table>
            </div>

            <div id='wpsPinNumber'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                        <tr> 
                          <td class="table_title width_per25" BindText='amp_wps_enable'></td>
                          <td class="table_right" id="TdWPSEnable"> <input id='wlWPSEnable' name='wlWPSEnable' type='checkbox' value="ON";"> 
                            <span class="gray"> </span></td>
                        </tr>

                <tr>
                    <td class="table_title width_per25" BindText='amp_wps_mode'></td>
                    <td class="table_right">
                    <select id='wlWPSMode' name='wlWPSMode' size='1' class="width_150px" onchange='wlPinModeChange();'> 
                            </select> </td>
                        </tr> 
           </table>
           </div>

            <div id='wpsPBCButton'>
                <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                  <tr>
                    <td class="table_title width_per25">PBC:</td>
                      <td class="table_right"> 
                        <input name="btnWpsPBC" type="button" class="submit" onClick="WpsPBCSubmit();">    
                            <script language="JavaScript" type="text/javascript">
                                setText('btnWpsPBC',cfg_wlancfgother_language['amp_btn_wpsstart']);
                            </script>
                       </td>
                  </tr>
                </table>
            </div>

           <div id='wpsPinNumVal'>
           <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                          <td class="table_title width_per25">PIN:</td>
                          <td class="table_right"> <input type='text' id='wlClientPinNum' name='wlClientPinNum' size='20' maxlength='8' class="amp_font"> 
                          </td>
                        </tr>
                      </table>
                    </div>
                    
                    <div id='wpsAPPinNumVal'> 
                      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                        <tr> 
                          <td class="table_title width_per25">AP-PIN:</td>
                          <td class="table_right"> <input type='text' id='wlSelfPinNum' name='wlSelfPinNum' size='20' maxlength='8' disabled class="amp_font"> 
                            <button id="RegeneratePIN" name="RegeneratePIN" type="button" class="submit" onclick="OnRegeneratePIN();"/><script>document.write(cfg_wlancfgother_language['amp_reg_pin']);</script></button>
                            <button id="ResetPIN" name="ResetPIN" type="button" class="submit" onclick="OnResetPIN();"/><script>document.write(cfg_wlancfgother_language['amp_reset_pin']);</script></button>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
        <tr><td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
              <tr >
                    <td class="table_submit width_per25"></td>
                    <td class="table_submit">
					    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                        <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="submit" onClick="ApplySubmit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
                        <button id="cancel" name="cancel" type="button" class="submit" onClick="cancelValue();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
                    </td>
                  </tr>
            </table>
        </td> 
      </tr>
  </table>
        </td> 
      </tr>
      </table>

    </div>
</div>

</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td></tr>
</table>
<div id='wifiCfg'>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr class="tabal_head">
        <td BindText='amp_wlan_advance'></td>
    </tr>
</table>

                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                        <tr id="wlPutOutPower">
                            <td class="table_title width_per25" BindText='amp_tx_power'></td>
                            <td  class="table_right">
                                <select id="wlTxPwr" name="wlTxPwr" class="width_150px">
                                    <option value="100"> 100% </option> 
                                    <option value="80"> 80% </option>
                                    <option value="60"> 60% </option>
                                    <option value="40"> 40% </option>
                                    <option value="20"> 20% </option>
                                </select>
                            </td>
                        </tr>
                        <tr id="powerStrenthMode" style="display:none;">
                            <td class="table_title width_per25" BindText='amp_wallmode'></td>
                            <td  class="table_right">
                                <select id="wallMode_select" name="wallMode_select" class="width_150px" onChange="WallModeChange();">
                                    <option value='0'><script>document.write(cfg_wlancfgadvance_language['amp_wallmode_standard']);</script></option>
                                    <option value='1'><script>document.write(cfg_wlancfgadvance_language['amp_wallmode_throughwall']);</script></option>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="table_title width_per25" BindText='amp_wlan_zone'></td>
                            <td  class="table_right">
                                <select id="RegulatoryDomain" name="RegulatoryDomain" class="width_150px" onChange="ChangeCountry();">
                    <option value="AL"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AL']);</script></option>
                    <option value="DZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_DZ']);</script></option>
                    <option value="AR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AR']);</script></option>
                    <option value="AM"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AM']);</script></option>
                    <option value="AU"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AU']);</script></option>
                    <option value="AT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AT']);</script></option>
                    <option value="AZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AZ']);</script></option>
                    <option value="BH"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BH']);</script></option>
                    <option value="BY"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BY']);</script></option>
                    <option value="BE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BE']);</script></option>
                    <option value="BZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BZ']);</script></option>
                    <option value="BO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BO']);</script></option>
                    <option value="BA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BA']);</script></option>
                    <option value="BR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BR']);</script></option>
                    <option value="BN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BN']);</script></option>
                    <option value="BG"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BG']);</script></option>
                    <option value="BF"><script>document.write(cfg_wlanzone_language['amp_wlanzone_BF']);</script></option>
                    <option value="CA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CA']);</script></option>
					<option value="CB"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CB']);</script></option>
                    <option value="CL"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CL']);</script></option>
                    <option value="CN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CN']);</script></option>
                    <option value="CO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CO']);</script></option>
                    <option value="CR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CR']);</script></option>
                    <option value="CI"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CI']);</script></option>
                    <option value="HR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_HR']);</script></option>
                    <option value="CY"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CY']);</script></option>
                    <option value="CZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CZ']);</script></option>
                    <option value="DK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_DK']);</script></option>
                    <option value="DO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_DO']);</script></option>
                    <option value="EC"><script>document.write(cfg_wlanzone_language['amp_wlanzone_EC']);</script></option>
                    <option value="EG"><script>document.write(cfg_wlanzone_language['amp_wlanzone_EG']);</script></option>
                    <option value="SV"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SV']);</script></option>
                    <option value="EE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_EE']);</script></option>
                    <option value="FK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_FK']);</script></option>
                    <option value="FI"><script>document.write(cfg_wlanzone_language['amp_wlanzone_FI']);</script></option>
                    <option value="FR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_FR']);</script></option>
                    <option value="GE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_GE']);</script></option>
                    <option value="DE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_DE']);</script></option>
                    <option value="GR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_GR']);</script></option>
                    <option value="GT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_GT']);</script></option>
                    <option value="HN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_HN']);</script></option>
                    <option value="HK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_HK']);</script></option>
                    <option value="HU"><script>document.write(cfg_wlanzone_language['amp_wlanzone_HU']);</script></option>
                    <option value="IS"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IS']);</script></option>
                    <option value="IN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IN']);</script></option>
                    <option value="ID"><script>document.write(cfg_wlanzone_language['amp_wlanzone_ID']);</script></option>
                    <option value="IR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IR']);</script></option>
                    <option value="IQ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IQ']);</script></option>
                    <option value="IE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IE']);</script></option>
                    <option value="IL"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IL']);</script></option>
                    <option value="IT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_IT']);</script></option>
                    <option value="JM"><script>document.write(cfg_wlanzone_language['amp_wlanzone_JM']);</script></option>
                    <option value="JP"><script>document.write(cfg_wlanzone_language['amp_wlanzone_JP']);</script></option>
                    <option value="JO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_JO']);</script></option>
                    <option value="KZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_KZ']);</script></option>
                    <option value="KE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_KE']);</script></option>
                    <option value="KW"><script>document.write(cfg_wlanzone_language['amp_wlanzone_KW']);</script></option>
                    <option value="LV"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LV']);</script></option>
                    <option value="LB"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LB']);</script></option>
                    <option value="LR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LR']);</script></option>
                    <option value="LI"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LI']);</script></option>
                    <option value="LT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LT']);</script></option>
                    <option value="LU"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LU']);</script></option>
                    <option value="MO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MO']);</script></option>
                    <option value="MK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MK']);</script></option>
                    <option value="MY"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MY']);</script></option>
                    <option value="MT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MT']);</script></option>
                    <option value="MX"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MX']);</script></option>
                    <option value="MD"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MD']);</script></option>
                    <option value="MC"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MC']);</script></option>
                    <option value="MA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_MA']);</script></option>
                    <option value="NP"><script>document.write(cfg_wlanzone_language['amp_wlanzone_NP']);</script></option>
                    <option value="NL"><script>document.write(cfg_wlanzone_language['amp_wlanzone_NL']);</script></option>
                    <option value="AN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AN']);</script></option>
                    <option value="NZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_NZ']);</script></option>
                    <option value="NI"><script>document.write(cfg_wlanzone_language['amp_wlanzone_NI']);</script></option>
                    <option value="NO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_NO']);</script></option>
                    <option value="NG"><script>document.write(cfg_wlanzone_language['amp_wlanzone_NG']);</script></option>
                    <option value="OM"><script>document.write(cfg_wlanzone_language['amp_wlanzone_OM']);</script></option>
                    <option value="PK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PK']);</script></option>
                    <option value="PA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PA']);</script></option>
                    <option value="PG"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PG']);</script></option>
                    <option value="PY"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PY']);</script></option>
                    <option value="PE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PE']);</script></option>
                    <option value="PH"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PH']);</script></option>
                    <option value="PL"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PL']);</script></option>
                    <option value="PT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PT']);</script></option>
                    <option value="PR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_PR']);</script></option>
                    <option value="QA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_QA']);</script></option>
                    <option value="RO"><script>document.write(cfg_wlanzone_language['amp_wlanzone_RO']);</script></option>
                    <option value="RU"><script>document.write(cfg_wlanzone_language['amp_wlanzone_RU']);</script></option>
                    <option value="SA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SA']);</script></option>
                    <option value="SG"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SG']);</script></option>
                    <option value="SK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SK']);</script></option>
                    <option value="SI"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SI']);</script></option>
                    <option value="SR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SR']);</script></option>
                    <option value="ZA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_ZA']);</script></option>
                    <option value="ES"><script>document.write(cfg_wlanzone_language['amp_wlanzone_ES']);</script></option>
                    <option value="LK"><script>document.write(cfg_wlanzone_language['amp_wlanzone_LK']);</script></option>
                    <option value="SE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SE']);</script></option>
                    <option value="CH"><script>document.write(cfg_wlanzone_language['amp_wlanzone_CH']);</script></option>
                    <option value="SY"><script>document.write(cfg_wlanzone_language['amp_wlanzone_SY']);</script></option>
                    <option value="TW"><script>document.write(cfg_wlanzone_language['amp_wlanzone_TW']);</script></option>
                    <option value="TH"><script>document.write(cfg_wlanzone_language['amp_wlanzone_TH']);</script></option>
                    <option value="TT"><script>document.write(cfg_wlanzone_language['amp_wlanzone_TT']);</script></option>
                    <option value="TN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_TN']);</script></option>
                    <option value="TR"><script>document.write(cfg_wlanzone_language['amp_wlanzone_TR']);</script></option>
                    <option value="UA"><script>document.write(cfg_wlanzone_language['amp_wlanzone_UA']);</script></option>
                    <option value="AE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_AE']);</script></option>
                    <option value="GB"><script>document.write(cfg_wlanzone_language['amp_wlanzone_GB']);</script></option>
                    <option value="US"><script>document.write(cfg_wlanzone_language['amp_wlanzone_US']);</script></option>
                    <option value="UY"><script>document.write(cfg_wlanzone_language['amp_wlanzone_UY']);</script></option>
                    <option value="UZ"><script>document.write(cfg_wlanzone_language['amp_wlanzone_UZ']);</script></option>
                    <option value="VE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_VE']);</script></option>
                    <option value="VN"><script>document.write(cfg_wlanzone_language['amp_wlanzone_VN']);</script></option>
                    <option value="YE"><script>document.write(cfg_wlanzone_language['amp_wlanzone_YE']);</script></option>
                    <option value="ZW"><script>document.write(cfg_wlanzone_language['amp_wlanzone_ZW']);</script></option>
                                </select>
                            </td>
                        </tr>
                        <tr id='switchChannel'>
                            
                    <td class="table_title width_per25" BindText='amp_wlan_channel'></td>
                            <td class="table_right">
                                <select id='wlChannel' name='wlChannel' size="1" onChange="ChannelChange()" class="width_150px">
                                </select>
                            </td>
                        </tr>
                        <tr id='switchChannelWidth'>
                            
                    <td class="table_title width_per25" BindText='amp_channel_width'></td>
                            <td class="table_right">
                                <select id='channelWidth' name='channelWidth' size="1" onChange="ChannelWidthChange()" class="width_150px">
                                    <script>
                                    if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
                                        document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                                        document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                                        document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
                                        document.forms[0].channelWidth[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
                                        if (capHT160 == 1) {
                                            document.forms[0].channelWidth[4] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
                                        }
                                    } else {
                                        document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                                        document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                                        document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
                                    }
                                    </script>
                                    <label id="Title_wlan_dfs_tips_lable" class="gray" style="display:none">
                                        <script>
                                            document.write("检测到雷达信号，频宽退避为80M频宽");
                                        </script>
                                    </label>
                                </select>
                            </td>
                        </tr>
                        <tr id="div_gMode">
                            <td class="table_title width_per25" BindText='amp_channel_mode'></td>
                            <td class="table_right">
                              <select id="wlgMode" name="wlgMode" size="1" class="width_150px" onchange="gModeChange()">
                                <option value="11a"> 802.11a</option>
                                <option value="11na"> 802.11a/n</option> 
                                <option value="11ac"> 802.11a/n/ac</option>
                                <option value="11b"> 802.11b</option>
                                <option value="11g"> 802.11g</option>
                                <option value="11n"> 802.11n</option>
                                <option value="11bg"> 802.11b/g</option>
                                <option value="11bgn" selected> 802.11b/g/n</option>
                                <option value="11ax"> 802.11b/g/n/ax</option>
                                <option value="11ax"> 802.11a/n/ac/ax</option>
                              </select>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                        <tr id="div_para0" style="display:none">
                        <td class="table_title width_per25" BindText='amp_advance_config'></td>
                        <td class="table_right">
                        <input type='checkbox' id='advanceEnbl' name='advanceEnbl' onClick='advanceEnable();' value="OFF">
                        </td>
                           </tr>                    
                    </table>
                    <div id="adConfig">
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                        <tr id="div_para1">
                            <td class="table_title width_per25" BindText='amp_dtim_time'></td>
                            <td class="table_right">
                                <input type='text' id='dtimPeriod' name='dtimPeriod' size='10' class="width_150px">
                  <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_dtim_timenote']);</script></span> </td>
                        </tr>
                        <tr id="div_para2">
                            <td class="table_title width_per25" BindText='amp_beacon_time'></td>
                            <td class="table_right">
                                <input type='text' id='beaconPeriod' name='beaconPeriod' size='10' class="width_150px">
                        <span class="gray" id='BeaconPeriodRemark'><script>document.write(cfg_wlancfgadvance_language['amp_beacon_timenote']);</script></span></td>
                        </tr>
                        <tr id="div_para3">
                            <td class="table_title width_per25" BindText='amp_rts_threshold'></td>
                            <td class="table_right">
                                <input type='text' id='rtsThreshold' name='rtsThreshold' size='10' class="width_150px">
                        <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_rts_thresholdnote']);</script></span></td>
                        </tr>
                        <tr id="div_para4">
                            <td class="table_title width_per25" BindText='amp_frag_threshold'></td>
                            <td class="table_right">
                                <input type='text' id='fragThreshold' name='fragThreshold' size='10' class="width_150px">
            <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_frag_thresholdnote']);</script></span></td>
                        </tr>
                    </table>
                    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
        <tr><td>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
                        <tr >
                            <td class="table_submit width_per25"></td>
                            
              <td class="table_submit"> 
              <button id="btnApplySubmit2" name="btnApplySubmit2" type="button" class="submit" onClick="Submit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
                <button id="cancelButton" name="cancelButton" type="button" class="submit" onClick="CancelConfig();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
                          </td>
                          </tr>
                      </table>
  </td>
  </tr>
  </table>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="width_10px"></td></tr>
  </table> 
  
</div>

</form>
</td></tr>
</table>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
