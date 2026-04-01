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

var WapiFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WAPI);%>';
var aWiFiCustFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_FEATURE_AWIFI);%>';
var aWiFiSSID2GInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AWiFi_SSID.SSID2GINST);%>';
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var MngtJsCmcc = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCMCC);%>';
var MngtGdCmcc = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GDCMCC);%>';
var TianyiFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CTRG);%>';
var QhctFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_QHCT);%>'
var isCTNetopen = '<%HW_WEB_IsCTNetOpen();%>';
var ScctFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>'
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var HiLinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var wep1password;
var wpapskpassword;
var radiuspassword;
var wep1PsdModFlag = false;
var pskPsdModFlag = false;
var radPsdModFlag = false;
var wepOrigLen = 0;
var isShowWpa3Eap = 0;

var isFirstFocusPsk = true;
function OnFocusToclearPwd_psk()
{
	if (isFirstFocusPsk && wifiPasswordMask == '1') {
		setText('WlanPassword_password', "");
		isFirstFocusPsk = false;
	}    
}

var g_flags = new Array();
g_flags[0] = 0;
g_flags[1] = 0;
g_flags[2] = 0;
var desc_show = "点击显示密码";
var desc_hide = "点击隐藏密码";

var SsidPerBand = '<%HW_WEB_GetSPEC(AMP_SPEC_SSID_NUM_MAX_BAND.UINT32);%>';

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

function GetLanguageDesc(Name)
{
    return cfg_wlancfgdetail_language[Name];
}

var wlanpage;
if (location.href.indexOf("e8cWlanBasic.asp?") > 0)
{
	wlanpage = location.href.split("?")[1]; 
	top.WlanBasicPage = wlanpage;
}

wlanpage = top.WlanBasicPage;

var capWpa3 = 0;
var capInfo = '<%HW_WEB_GetSupportAttrMask();%>';
function initWlanCap(wlanpage) {
    if((capInfo == null) || (capInfo == '') || (capInfo.length < capNum*2)) {
        return ;
    }

    var capNum = capInfo.length/2;
    var baseIdx = capNum * ((wlanpage == "5G") ? 1 : 0);

    capWpa3 = parseInt(capInfo.charAt(35 + baseIdx));
}

function ShowOrHideText(flag, checkBoxId, passwordId, textId, value)
{
    if (1 == g_flags[flag])
    {
		getElById(checkBoxId).innerHTML = desc_show;
        setDisplay(passwordId, 1);
        setDisplay(textId, 0);
		g_flags[flag] = 0;		
    }
    else
    {
		getElById(checkBoxId).innerHTML = desc_hide;
        setDisplay(passwordId, 0);
        setDisplay(textId, 1);
		g_flags[flag] = 1;
    }
}

function stWlan(domain,name,enable,ssid,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                KeyIndex,EncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable, LowerLayers,
				X_HW_WAPIEncryptionModes,X_HW_WAPIAuthenticationMode,X_HW_WAPIServer,X_HW_WAPIPort,SSIDAdvertisementEnabled,WMMEnable,X_HW_AssociateNum,IsolationEnable)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
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
    this.RadiusServer = RadiusServer;
    this.RadiusPort = RadiusPort;
    this.RadiusKey = RadiusKey;
	this.X_HW_ServiceEnable = X_HW_ServiceEnable;
	this.LowerLayers = LowerLayers;
	this.X_HW_WAPIEncryptionModes = X_HW_WAPIEncryptionModes;
	this.X_HW_WAPIAuthenticationMode = X_HW_WAPIAuthenticationMode;
	this.X_HW_WAPIServer = X_HW_WAPIServer;
	this.X_HW_WAPIPort = X_HW_WAPIPort;
	this.SSIDAdvertisementEnabled = SSIDAdvertisementEnabled;
	this.WMMEnable = WMMEnable;
	this.X_HW_AssociateNum = X_HW_AssociateNum;
	this.IsolationEnable = IsolationEnable;
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

function stWlanWifi(domain,name,enable,ssid,mode,channel,power,Country,AutoChannelEnable,channelWidth)
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
}


var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20,stWlanWifi);%>;
var WlanWifi = WlanWifiArr[0];
if (null == WlanWifi)
{
	WlanWifi = new stWlanWifi("","","","","11n","","","","","");
}

var enbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';

var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|LowerLayers|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort|SSIDAdvertisementEnabled|WMMEnable|X_HW_AssociateNum|IsolationEnable,stWlan);%>;

var wlanArrLen = WlanArr.length - 1;

for (i=0; i < wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
if (null != g_keys)
{
	wep1password = g_keys[0];
}

var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;

var wlanMac = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_WlanMac);%>';

var ssidIdx = -1;
var ssidAccessAttr = 'Subscriber';
var AddFlag = true;
var currentWlan = new stWlan();
var maxSingleWLAN     = new stMaxWLAN(4,'four');
var maxDoubleWLAN     = new stMaxWLAN(8,'eight');



var uiFirstRecordFor5G = 0;
var RecordFor5G = 0;
var flag5Ghide = 0;
function FirstRecordFor5G()
{
	if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
	{
		for (var loop = 0; loop < WlanMap.length; loop++)
		{
			if (WlanMap[loop].portIndex > SsidPerBand-1)
			{
				uiFirstRecordFor5G = parseInt(getIndexFromPort(WlanMap[loop].portIndex));
				WlanWifi = WlanWifiArr[uiFirstRecordFor5G];	
				RecordFor5G = loop;
				break;
			}
		}
	}	
}

var uiFirstRecordFor2G = 0;
var RecordFor2G = 0;
function FirstRecordFor2G()
{
	if ((1 == DoubleFreqFlag) && ("2G" == wlanpage))
	{
		for (var loop = 0; loop < WlanMap.length; loop++)
		{
			if (WlanMap[loop].portIndex < SsidPerBand)
			{
				uiFirstRecordFor2G = parseInt(getIndexFromPort(WlanMap[loop].portIndex));
				WlanWifi = WlanWifiArr[uiFirstRecordFor2G];			
				RecordFor2G = loop;
				break;
			}
		}
	}	
}

var uiTotal2gNum = 0;
var uiTotal5gNum = 0;
var uiTotalNum = 0;
function Total2gNum()
{
	uiTotal2gNum = 0;
	uiTotal5gNum = 0;
	uiTotalNum = Wlan.length;

	for (var loop = 0; loop < Wlan.length; loop++)
	{
		if ('' == Wlan[loop].name)
		{
			continue;
		}
		
		if (getWlanPortNumber(Wlan[loop].name) > SsidPerBand-1)
		{
			uiTotal5gNum++;
		}
		else
		{
			uiTotal2gNum++;
		}
	}
}
var ShowISPSsidFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SHOW_ISPSSID);%>';

var WlanMap = new Array();
var j = 0;
for (var i = 0; i < Wlan.length; i++)
{
    var index = getWlanPortNumber(Wlan[i].name);
    var wlanInst = getWlanInstFromDomain(Wlan[i].domain);

    if ((isSsidForIsp(wlanInst) == 1) && (1 != ShowISPSsidFlag))
    {
     	continue;
    }
    else
    {
   		WlanMap[j] = new stIndexMapping(i,index);
   		j++;
    }
}

if (WlanMap.length >= 2)
{
    for (var i = 0; i < WlanMap.length-1; i++)
    {
        for( var j =0; j < WlanMap.length-i-1; j++)
        {
            if (WlanMap[j+1].portIndex < WlanMap[j].portIndex)
            {
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

var auth_none = "NONE";
var auth_wep = "WEP";
var auth_wpa_psk = "WPA-PSK";
var auth_wpa2_psk = "WPA2-PSK";
var auth_wpawpa2_psk = "WPA-PSK/WPA2-PSK";
var auth_wpa3_psk = "WPA3-SAE";
var auth_wpa = cfg_wlancfgdetail_language['amp_auth_wpa'];
var auth_wpa2 = cfg_wlancfgdetail_language['amp_auth_wpa2'];
var auth_wpawpa2 = cfg_wlancfgdetail_language['amp_auth_wpawpa2'];
var auth_wpa3 = "WPA3 Enterprise";
var auth_wpa2wpa3 = "WPA2/WPA3 Enterprise";
if (CurrentBin.toUpperCase() == "E8C") {
    var wpa3Notes = "推荐使用WPA3-SAE Transition认证模式";
    var auth_wpa2wpa3_psk = "WPA3-SAE Transition";
} else {
    var wpa3Notes = "推荐使用WPA2-PSK/WPA3-SAE认证模式";
    var auth_wpa2wpa3_psk = "WPA2-PSK/WPA3-SAE";
}

var encrypt_none = "NONE";
var encrypt_open = "OPEN";
var encrypt_share = "SHARE";
var encrypt_both = "OPEN+SHARE";
var encrypt_tkip = "TKIP";
var encrypt_aes = "AES";
var encrypt_tkipaes = "TKIP+AES";

function addAuthModeOption()
{
    var len = document.forms[0].WlanAuthMode_select.options.length;    
    var authMode = getSelectVal('WlanAuthMode_select'); 
    var mode = WlanWifi.mode; 
    
    for (i = 0; i < len; i++)
    {
        document.forms[0].WlanAuthMode_select.remove(0);
    }
    initWlanCap(wlanpage);
    var index = 0;
    document.forms[0].WlanAuthMode_select[0] = new Option(auth_none, "open");
    index++;
    if ((mode != "11n") && (mode != "11ac")) {
        document.forms[0].WlanAuthMode_select[index] = new Option(auth_wep, "shared");
        index++;
    }
    document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa_psk, "wpa-psk");
    index++;
    document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa2_psk, "wpa2-psk");
    index++;
    document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpawpa2_psk, "wpa/wpa2-psk");
    index++;
    if (capWpa3 == 1) {
        document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa3_psk, "wpa3-psk");
        index++;
        document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa2wpa3_psk, "wpa2/wpa3-psk");
        index++;
    }
    document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa, "wpa");
    index++;
    document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa2, "wpa2");
    index++;
    document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpawpa2, "wpa/wpa2");
    index++;
    if ((capWpa3 == 1) && (isShowWpa3Eap == 1)) {
        document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa3, "wpa3");
        index++;
        document.forms[0].WlanAuthMode_select[index] = new Option(auth_wpa2wpa3, "wpa2/wpa3");
        index++;
    }
    if (((mode != "11n") && (mode != "11ac")) && (WapiFlag == 1)) {
        document.forms[0].WlanAuthMode_select[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wapi_psk'], "wapi-psk");
        index++;
        document.forms[0].WlanAuthMode_select[index] = new Option(cfg_wlancfgdetail_language['amp_auth_wapi'], "wapi");
        index++;
    }

    setSelect('WlanAuthMode_select',authMode);
}

function addWapiEncryMethodOption()
{
	var len = document.forms[0].WlanPwdMode_select.options.length;
	for (i = 0; i < len; i++)
    {
        document.forms[0].WlanPwdMode_select.remove(0);
    }
	document.forms[0].WlanPwdMode_select[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_sms4'], "SMS4");
			
}

function addEncryMethodOption(type1,type2)
{
    var len = document.forms[0].WlanPwdMode_select.options.length;
    var mode = WlanWifi.mode;
    var authMode = getSelectVal('WlanAuthMode_select');
    
    for (i = 0; i < len; i++)
    {
        document.forms[0].WlanPwdMode_select.remove(0);
    }

    if ((type1 == 0) && (type2 == 0))
    {
    }
    else if ((type1 == 0) && (type2 == 1))
    {
    }
    else
    {
        if ((authMode == "wpa3") || (authMode == "wpa2/wpa3") || (authMode == "wpa3-psk") || (authMode == "wpa2/wpa3-psk")) {
            document.forms[0].WlanPwdMode_select[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
        } else {
            if (mode == "11n") {
                document.forms[0].WlanPwdMode_select[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");    	
            } else {
                document.forms[0].WlanPwdMode_select[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
                document.forms[0].WlanPwdMode_select[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
                document.forms[0].WlanPwdMode_select[2] = new Option(encrypt_tkipaes, "TKIPandAESEncryption");
            }
        }
    }
}

function GetWepEncrypt(BasicAuthenticationMode)
{
	if ((BasicAuthenticationMode == 'None') ||(BasicAuthenticationMode == 'OpenSystem'))
	{
		return 'OpenSystem';
	}
	else if ((BasicAuthenticationMode == 'SharedAuthentication') ||(BasicAuthenticationMode == 'SharedKey'))
	{
		return 'SharedKey';
	}
	else
	{
		return 'Both';
	}
}

function ClearPsdModFlag()
{
    wep1PsdModFlag = false;
    pskPsdModFlag = false;
    radPsdModFlag = false;
}

function authModeChange()
{   
	ClearPsdModFlag();
	
    setDisplay("wlEncryMethod",0);
	setDisplay("wlEncryWep",0);
    setDisplay("keyInfo", 0);
    setDisplay("wlRadius", 0);
    setDisplay("wpaPreShareKey", 0);
    setDisable("WlanPwdMode_select",0);
	setDisplay('wlWapi',0);

    var authMode = getSelectVal('WlanAuthMode_select');      

    switch (authMode)
    {
        case 'open':
            break;

        case 'shared':
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            var mode = WlanWifi.mode;              
            
            if (mode == "11n")
            {
            }
            else
            {
				setDisplay("wlEncryWep",1);
                setDisplay('keyInfo', 1);
                if (AddFlag == false)
                {
					setSelect('WlanWepPwd_select', GetWepEncrypt(Wlan[ssidIdx].BasicAuthenticationMode));
                    setSelect('WlanKeyBit_select', parseInt(level)+24);
                    setText('wlKeys1',g_keys[ssidIdx * 4].value);
                    wep1password = g_keys[ssidIdx * 4].value; 
                    setText('twlKeys1',g_keys[ssidIdx * 4].value);
                }
                else
                {
					setSelect('WlanWepPwd_select', 'Both');
                    setSelect('WlanKeyBit_select', 128);
                    setText('wlKeys1','');
                    wep1password = ''; setText('twlKeys1','');
                }
            }			      
            break;

        case 'wpa':
        case 'wpa2':
        case 'wpa/wpa2':
        case 'wpa3':
        case 'wpa2/wpa3':
			setDisplay('wlEncryMethod',1);
			addEncryMethodOption(1,0);
            setDisplay('wlRadius', 1);
            if (AddFlag == false)
            {
                if (authMode == 'wpa')
                {
                    setSelect('WlanPwdMode_select',Wlan[ssidIdx].WPAEncryptionModes);
                }
                else if (authMode == 'wpa2')
                {
                    setSelect('WlanPwdMode_select',Wlan[ssidIdx].IEEE11iEncryptionModes);
                }
				else
				{
				    setSelect('WlanPwdMode_select',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
				}
                setText('wlRadiusIPAddr',Wlan[ssidIdx].RadiusServer);
                setText('wlRadiusPort',Wlan[ssidIdx].RadiusPort);
                setText('wlRadiusKey',Wlan[ssidIdx].RadiusKey);
				radiuspassword = Wlan[ssidIdx].RadiusKey; 
				setText('twlRadiusKey',Wlan[ssidIdx].RadiusKey);
            }
            else
            {
                setText('wlRadiusIPAddr','');
                setText('wlRadiusPort','');
                setText('wlRadiusKey','');
				radiuspassword = ''; 
				setText('twlRadiusKey','');
            }
            break;

        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
        case 'wpa3-psk':
        case 'wpa2/wpa3-psk':
            setDisplay('wlEncryMethod',1);
            addEncryMethodOption(1,0);

            if ((authMode == "wpa3-psk") || (authMode == "wpa2/wpa3-psk")) {
                document.getElementById("wpa_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
            } else {
                document.getElementById("wpa_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote'];
            }

            setDisplay('wpaPreShareKey', 1);
            if (AddFlag == false)
            {
                if (authMode == 'wpa-psk')
                {
                    setSelect('WlanPwdMode_select',Wlan[ssidIdx].WPAEncryptionModes);
                }
				else if (authMode == 'wpa2-psk')
                {
                    setSelect('WlanPwdMode_select',Wlan[ssidIdx].IEEE11iEncryptionModes);
                }
                else
                {
                    setSelect('WlanPwdMode_select',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
                }
                setText('WlanPassword_password',wpaPskKey[ssidIdx].value);
				wpapskpassword = wpaPskKey[ssidIdx].value;
				setText('tWlanPassword_password',wpaPskKey[ssidIdx].value);
            }
            else
            {
                setText('WlanPassword_password','');
				wpapskpassword = '';
				setText('tWlanPassword_password','');
            }
            break;
		case 'wapi-psk':
			setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
			document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wapi_psk");
			setDisable('WlanPwdMode_select',1);
			setDisplay("wpaPreShareKey", 1);
			setText('WlanPassword_password',wpaPskKey[ssidIdx].value);
			setText('tWlanPassword_password',wpaPskKey[ssidIdx].value);
			wpapskpassword = wpaPskKey[ssidIdx].value;
			if(AddFlag == false)
			{

				setSelect('WlanPwdMode_select',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
			}
			break;
		case 'wapi':
			setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
			setDisable('WlanPwdMode_select',1);
			setDisplay('wlWapi',1); 
			setText('wapiIPAddr',Wlan[ssidIdx].X_HW_WAPIServer);
			setText('wapiPort',Wlan[ssidIdx].X_HW_WAPIPort);
			if(AddFlag == false)
			{
				setSelect('WlanPwdMode_select',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
			}
			break;
        default:
            break;
    }
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

function displaywepkey()
{   
    if (AddFlag == false)
    {
        setText('wlKeys1',g_keys[ssidIdx * 4].value);
		wep1password = g_keys[ssidIdx * 4].value; 
		setText('twlKeys1',g_keys[ssidIdx * 4].value);
    }
    else
    {
        setText('wlKeys1','');
		wep1password = ''; 
		setText('twlKeys1', '');
    }
}

function initEapAuthShow(wlAuthMode, wlEncryption) {
	setDisplay("wlEncryMethod", 1);
	addEncryMethodOption(1, 0);
	setDisplay("wlRadius", 1);
	setSelect('WlanAuthMode_select', wlAuthMode);
	setSelect('WlanPwdMode_select', wlEncryption);
	setText('wlRadiusIPAddr', Wlan[ssidIdx].RadiusServer);
	setText('wlRadiusPort', Wlan[ssidIdx].RadiusPort);
	setText('wlRadiusKey', Wlan[ssidIdx].RadiusKey);
	radiuspassword = Wlan[ssidIdx].RadiusKey; 
	setText('twlRadiusKey', Wlan[ssidIdx].RadiusKey);
}

function initPskAuthShow(wlAuthMode, wlEncryption, index1, index2) {
	setDisplay("wlEncryMethod", 1);
	addEncryMethodOption(index1, index2);
	setDisplay("wpaPreShareKey", 1);
	setSelect('WlanAuthMode_select', wlAuthMode);
	setSelect('WlanPwdMode_select', wlEncryption);
	setText('WlanPassword_password', wpaPskKey[ssidIdx].value); 
	wpapskpassword = wpaPskKey[ssidIdx].value; 
	setText('tWlanPassword_password', wpaPskKey[ssidIdx].value);
}

function beaconTypeChange(mode)
{
    setDisplay('wlEncryMethod',0);
	setDisplay("wlEncryWep",0);
    setDisplay('keyInfo', 0);
    setDisplay('wlRadius', 0);
    setDisplay('wpaPreShareKey', 0);
	setDisplay('wlWapi',0);
    
    if (mode == 'Basic')
    {
        var BasicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
        var BasicEncryptionModes = Wlan[ssidIdx].BasicEncryptionModes;
        if (BasicEncryptionModes == 'None')
	    {
            setSelect('WlanAuthMode_select','open');
        }
        else
        {
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
			setDisplay("wlEncryWep",1);
            setDisplay('keyInfo', 1);
            setSelect('WlanAuthMode_select','shared');
            setSelect('WlanWepPwd_select',GetWepEncrypt(BasicAuthenticationMode));
            setSelect('WlanKeyBit_select', parseInt(level)+24);
			WlanKeyBit_selectChange();
            displaywepkey();
        }
    } else if (mode == 'WPA') {
        if (Wlan[ssidIdx].WPAAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa', Wlan[ssidIdx].WPAEncryptionModes);
        } else {
            initPskAuthShow('wpa-psk', Wlan[ssidIdx].WPAEncryptionModes, 1, 1);
        }
    } else if ((mode == '11i') || (mode == 'WPA2')) {
        if (Wlan[ssidIdx].IEEE11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa2', Wlan[ssidIdx].IEEE11iEncryptionModes);
        } else {
            initPskAuthShow('wpa2-psk', Wlan[ssidIdx].IEEE11iEncryptionModes, 1, 2);
        }
    } else if ((mode == 'WPAand11i') || (mode == 'WPA/WPA2')) {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa/wpa2', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
        } else {
            initPskAuthShow('wpa/wpa2-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, 0, 2);
        }
    } else if (mode == 'WPA3') {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa3', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
        } else {
            initPskAuthShow('wpa3-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, 0, 2);
        }
    } else if (mode == 'WPA2/WPA3') {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa2/wpa3', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
        } else {
            initPskAuthShow('wpa2/wpa3-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, 0, 2);
        }
    }
	else if(mode == 'X_HW_WAPI')
	{
		if(Wlan[ssidIdx].X_HW_WAPIAuthenticationMode == 'WAPIPSK')
		{
			setSelect('WlanAuthMode_select','wapi-psk');
			setDisplay('wlEncryMethod',1);             
            		addWapiEncryMethodOption();  
			
			setDisable('WlanPwdMode_select',1);
			setDisplay("wpaPreShareKey", 1);
			document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wapi_psk");
			setText('WlanPassword_password',wpaPskKey[ssidIdx].value);
			setText('tWlanPassword_password',wpaPskKey[ssidIdx].value);
			wpapskpassword = wpaPskKey[ssidIdx].value; 



			setSelect('WlanPwdMode_select',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
		}
		else
		{
			setSelect('WlanAuthMode_select','wapi');
			setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
			setDisable('WlanPwdMode_select',1);
			setDisplay('wlWapi',1); 
			setText('wapiIPAddr',Wlan[ssidIdx].X_HW_WAPIServer);
			setText('wapiPort',Wlan[ssidIdx].X_HW_WAPIPort);
		}
	}
    else
    {
        setSelect('WlanAuthMode_select','open');
    }

    if ((Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode != 'EAPAuthentication') && ((mode == 'WPA3') || (mode == 'WPA2/WPA3'))) {
        document.getElementById("wpa_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
    } else {
        document.getElementById("wpa_note").innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote'];
    }
}

function WlanKeyBit_selectChange()
{
	var desc;
	
    if (getSelectVal('WlanKeyBit_select') == 128)
	{
		desc = "128位无线网络密钥需输入13个ASCII字符或26个十六进制数";
	}
	else
	{
		desc = "64位无线网络密钥需输入5个ASCII字符或10个十六进制数";
	}

	getElById("Title_wlan_key_tips_lable").innerHTML = desc;
}

function onMethodChange(isSelected)
{   
	var authMode = getSelectVal('WlanAuthMode_select');
	if (authMode == 'open')
	{
    	var var2 = getSelectVal('WlanPwdMode_select');

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
                setSelect('WlanKeyBit_select', parseInt(level)+24);

                setText('wlKeys1',g_keys[ssidIdx * 4].value);
				wep1password = g_keys[ssidIdx * 4].value; 
				setText('twlKeys1',g_keys[ssidIdx * 4].value);
            }
            else
            {
                setDisplay('keyInfo', 1);
                setSelect('WlanKeyBit_select', 128);

                setText('wlKeys1','');
				wep1password = ''; 
				setText('twlKeys1','');
            }
        }
	}
    else
    {
        setDisplay('keyInfo', 0);
    }
}

function onWepChange()
{

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

function IsCharandNum(str)
{
    var prefix='';
	var postfix = '-5G';
	var endPos = str.length;
	var ErrorNote = "SSID-1 “CMCC-”前缀后面只允许输入由0-9、a-z、A-Z等组成的字符串。";
	
	if (0 == getWlanPortNumber(currentWlan.name))
	{
		prefix = "CMCC-";
	}
	
	if ((1 == DoubleFreqFlag) && (SsidPerBand == getWlanPortNumber(currentWlan.name)))
	{
		prefix = "CMCC-";
		
		endPos = str.length - postfix.length;
		if (endPos != str.lastIndexOf(postfix))
		{
			endPos = str.length;
		}
		
		ErrorNote = "SSID-5 “CMCC-”前缀后面只允许输入由0-9、a-z、A-Z等组成的字符串，并且允许以“-5G”结尾。";
	}

	for( var i = prefix.length; i < endPos; i++ )
	{ 
		if(str.charAt(i) < '0' || str.charAt(i) > '9')
		{
			if(str.charAt(i) < 'a' || str.charAt(i) > 'z')
			{
				if(str.charAt(i) < 'A' || str.charAt(i) > 'Z')
				{
					AlertEx(ErrorNote);
					return false;	
				}
			}
		}
	}
	
	return true;
}

function addParameter1(Form)
{   
    Form.addParameter('y.Enable',getCheckVal('wlEnable'));
    var ssid;
    ssid = ltrim(getValue('WlanSsid_text'));
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

    if('E8C' != CurrentBin.toUpperCase() && (isBponFlag != 1) && (curLanguage.toUpperCase() != "CHINESE") && (CfgMode.toUpperCase() != 'SCCMCC_RMS'))
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
        if ((getWlanPortNumber(Wlan[i].name) > SsidPerBand-1) && ((1 == DoubleFreqFlag) && ("2G" == wlanpage)) )
        {
            continue;
        }
        
        if ((getWlanPortNumber(Wlan[i].name) <= SsidPerBand-1) && ((1 == DoubleFreqFlag) && ("5G" == wlanpage)) )
        {
            continue;
        }
        
		if ((getWlanPortNumber(Wlan[i].name) > SsidPerBand-1) && ((1 != DoubleFreqFlag)) )
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
    
	if ('E8C' == CurrentBin.toUpperCase() && ('0' == TianyiFlag || '1' == ScctFlag) && (fttrFlag != 1))
	{
		if((0 == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("ChinaNet-")) )
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
			return false;
		}

		if (1 == DoubleFreqFlag)
		{
			if((SsidPerBand == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("ChinaNet-")) )
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet_5G']);
				return false;
			}
		}
	}
	
	if ('E8C' == CurrentBin.toUpperCase() && '1' == isCTNetopen && 'GDGCT' == CfgMode && (fttrFlag != 1))
	{
		if((0 == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("ChinaNet-")) )
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
			WlanSsid_text.focus();
			return false;
		}

		if (1 == DoubleFreqFlag)
		{
			if((SsidPerBand == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("ChinaNet-")) )
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet_5G']);
				WlanSsid_text.focus();
				return false;
			}
		}
	}
	
    if ((CurrentBin.toUpperCase() == 'CMCC') && (CfgMode.toUpperCase() != 'SHYDZHQ_RMS') && (MngtJsCmcc != 1) && (fttrFlag != 1) &&
        (CfgMode.toUpperCase() != 'SCCMCC_RMS')) {
        if ((getWlanPortNumber(currentWlan.name)) == 0 && (ssid.indexOf("CMCC-") != 0)) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cmcc']);
            return false;
        }

        if (DoubleFreqFlag == 1) {
            if ((getWlanPortNumber(currentWlan.name)) == SsidPerBand && (ssid.indexOf("CMCC-") != 0)) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cmcc_5G']);
                return false;
            }
        }
    }
	
	if ('SHXCNCATV' == CfgMode.toUpperCase())
	{
		if((0 == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("sxbctvnet-")) )
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_shxcncatv']);
			return false;
		}

		if (1 == DoubleFreqFlag)
		{
			if((SsidPerBand == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("sxbctvnet-")) )
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_shxcncatv_5G']);
				return false;
			}
		}
	}

	if (('1' == aWiFiCustFlag) && (aWiFiSSID2GInst == getWlanInstFromDomain(currentWlan.domain)))
	{
		if (0 != ssid.indexOf("aWiFi-"))
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_awifi']);
			return false;
		}	
	}
	
    Form.addParameter('y.SSID',ssid);
}

function isAuthModeEnterprise(AuthMode) {
	if ((AuthMode == 'wpa') || (AuthMode == 'wpa2') || (AuthMode == 'wpa/wpa2') || (AuthMode == 'wpa3') || (AuthMode == 'wpa2/wpa3')) {
		return true;
	} else {
		return false;
	}
}

function isAuthModePreSharedKey(AuthMode) {
	if ((AuthMode == 'wpa-psk') || (AuthMode == 'wpa2-psk') || (AuthMode == 'wpa/wpa2-psk') || (AuthMode == 'wpa3-psk') || (AuthMode == 'wpa2/wpa3-psk')) {
		return true;
	} else {
		return false;
	}
}

function addParameter2(Form)
{ 
    var url = '';
    var temp = '';

    var AuthMode = getSelectVal('WlanAuthMode_select');

	if (AuthMode == 'open')
	{
		Form.addParameter('y.BeaconType','None');
		Form.addParameter('y.BasicAuthenticationMode','OpenSystem');
		Form.addParameter('y.BasicEncryptionModes','None');
	}
    else if (AuthMode == 'shared')
    {
        var KeyBit = getSelectVal('WlanKeyBit_select');
		var index = 1;
		var wlKeys1 = getValue('wlKeys1');
		if ((isFireFox4 == 1) && (wlKeys1 == ''))
		{
			wlKeys1 = wep1password;
		}
		
		var val;
		var i;
		var vKey = 0;
		var KeyDesc;

		for (vKey = 0; vKey < 1; vKey++)
		{
		   if (vKey == 0)
		   {
			   val = wlKeys1;
			   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key1'];
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

        if (wifiPasswordMask == '1')
        {
            if (KeyBit == '128')
            {
                if ( (wlKeys1 != "*************") || (wep1PsdModFlag == true) || wepOrigLen != getValue('wlKeys1').length)
                {
                    Form.addParameter('k1.WEPKey', wlKeys1);
                    Form.addParameter('k2.WEPKey', wlKeys1);
                    Form.addParameter('k3.WEPKey', wlKeys1);
                    Form.addParameter('k4.WEPKey', wlKeys1);  
                }
            }
            else
            {
                if ( (wlKeys1 != "*****") || (wep1PsdModFlag == true)  || wepOrigLen != getValue('wlKeys1').length)
                {
                    Form.addParameter('k1.WEPKey', wlKeys1);
                    Form.addParameter('k2.WEPKey', wlKeys1);
                    Form.addParameter('k3.WEPKey', wlKeys1);
                    Form.addParameter('k4.WEPKey', wlKeys1);
                }
            }
        }
        else
        {
            Form.addParameter('k1.WEPKey', wlKeys1);
            Form.addParameter('k2.WEPKey', wlKeys1);
            Form.addParameter('k3.WEPKey', wlKeys1);
            Form.addParameter('k4.WEPKey', wlKeys1);  
        }

        
        Form.addParameter('y.BeaconType','Basic');
		Form.addParameter('y.BasicAuthenticationMode',getSelectVal('WlanWepPwd_select'));
        Form.addParameter('y.BasicEncryptionModes','WEPEncryption');
    } else if (isAuthModeEnterprise(AuthMode)) {
        var wlRadiusKey = getValue('wlRadiusKey');
		if ((isFireFox4 == 1) && (wlRadiusKey == ''))
		{
			wlRadiusKey = radiuspassword;
		}
		
        var wlRadiusIPAddr = getValue('wlRadiusIPAddr');
        var wlRadiusPort = getValue('wlRadiusPort');
        
        if (wlRadiusIPAddr == '' || wlRadiusPort == '' || wlRadiusKey == '')
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
        
        if (AuthMode == 'wpa') {
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa2') {
            Form.addParameter('y.BeaconType','11i');
            Form.addParameter('y.IEEE11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.IEEE11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa/wpa2') {
		    Form.addParameter('y.BeaconType','WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if  (AuthMode == 'wpa3') {
            Form.addParameter('y.BeaconType','WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if  (AuthMode == 'wpa2/wpa3') {
            Form.addParameter('y.BeaconType','WPA2/WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
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
        Form.addParameter('y.X_HW_RadiusPort',wlRadiusPort);
    } else if ((isAuthModePreSharedKey(AuthMode)) || (AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
        var value = getValue('WlanPassword_password');
		if ((isFireFox4 == 1) && (value == ''))
		{
			value = wpapskpassword;
		}
		
		var wapiIP = getValue('wapiIPAddr');
		var wapiPort = getValue('wapiPort');
		

		if (isAuthModePreSharedKey(AuthMode)) {
	
			if (value == '')
			{
				AlertEx(cfg_wlancfgother_language['amp_empty_para']);
				return false;
			}

            if ((isValidWPAPskKey(value) == false) || (((AuthMode == 'wpa3-psk') || (AuthMode == 'wpa2/wpa3-psk')) && (value.length == 64))) {
                AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
                return false;
            }
		}
		
        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('WlanPwdMode_select'));
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('y.BeaconType','11i');
            Form.addParameter('y.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.IEEE11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa/wpa2-psk') {
            Form.addParameter('y.BeaconType','WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa3-psk') {
            Form.addParameter('y.BeaconType','WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','SAEAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa2/wpa3-psk') {
            Form.addParameter('y.BeaconType','WPA2/WPA3');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKandSAEAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
        }
		else if(AuthMode == 'wapi')
		{
			if (isAbcIpAddress(wapiIP) == false)
			{
				AlertEx(cfg_wlancfgdetail_language['amp_wapisrvip_invalid']);
				return false;
			}
			
			if (isValidRadiusPort(wapiPort) == false)
			{
				AlertEx(cfg_wlancfgdetail_language['amp_wapisrvport_invalid']);
				return false;
			}
			Form.addParameter('y.BeaconType','X_HW_WAPI');
			Form.addParameter('y.X_HW_WAPIAuthenticationMode','WAPICERT');
			Form.addParameter('y.X_HW_WAPIEncryptionModes','SMS4');
			Form.addParameter('y.X_HW_WAPIServer',wapiIP);
			Form.addParameter('y.X_HW_WAPIPort',parseInt(getValue('wapiPort')),10);
		}
		else if(AuthMode == 'wapi-psk')
		{
			 if (value == '')
			{
				AlertEx(cfg_wlancfgother_language['amp_empty_para']);
				return false;
			}

			if (isValidWPAPskKey(value) == false)
			{
				AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
				return false;
			}
			Form.addParameter('y.BeaconType','X_HW_WAPI');
			Form.addParameter('y.X_HW_WAPIAuthenticationMode','WAPIPSK');
			Form.addParameter('y.X_HW_WAPIEncryptionModes','SMS4');
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

    return false;
}

var isSet5Gflag = 0;
var ssid5GIndex = 0;
function IsFirstSsidEqual() {
    var ssid2G = '';
    var ssid5G = '';
    for (var i = 0; i < Wlan.length; i++) {
        if (getInstIdByDomain(Wlan[i].domain) == 1) {
            ssid2G = Wlan[i].ssid;
        }

        if (getInstIdByDomain(Wlan[i].domain) == parseInt(ssidStart5G) + 1) {
            ssid5G = Wlan[i].ssid;
            ssid5GIndex = i;
        }
    }

    if (ssid2G == ssid5G) {
        return true;
    }

    return false;
}

function IsSetSsid5G(wlandomain) {
    var tempEncryMode = getSelectVal('WlanPwdMode_select');
    var authMode = getSelectVal('WlanAuthMode_select');
    if ((fttrFlag == 1) && (DoubleFreqFlag != 1) && (getInstIdByDomain(wlandomain) == 1) && 
        (tempEncryMode != 'WEPEncryption') && (!isAuthModeEnterprise(authMode)) && 
        (authMode != 'wapi') && (authMode != 'wapi-psk') && (HiLinkRoll == 1) && 
        (IsFirstSsidEqual() == true)) {
        isSet5Gflag = 1;
        return true;
    }

    isSet5Gflag = 0;
    return false;
}

function IsSsid5GExist(ssid) {
    for (var i = 0; i < Wlan.length; i++) {
        if (getWlanPortNumber(Wlan[i].name) <= ssidEnd2G) {
            continue;
        }

        if (i != ssid5GIndex) {
            if (Wlan[i].ssid == ssid) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
                return false;
            }
        }
    }

    return true;
}

function AddParameter5G(wlandomain, Form) {
    if (IsSetSsid5G(wlandomain) == true) {
        var formLength = Form.oForm.length;
        for (var i = 0; i < formLength; i++) {
            if (Form.oForm[i].name == 'y.SSID') {
                if (IsSsid5GExist(Form.oForm[i].value) == false) {
                    return false;
                }
            }

            var name = Form.oForm[i].name.split('.');
            if (name[0] == 'z') {
                continue;
            }

            var newName; 
            if (name[0] == 'w') {
                newName = Form.oForm[i].name + '5G';
                if (newName == 'w.SsidInst5G') {
                    Form.addParameter(newName, parseInt(ssidStart5G) + 1);
                    continue;
                }

                if (newName == 'w.Standard5G') {
                    continue;
                }
            } else {
                newName = name[0].toUpperCase() + '.' + name[1];
            }

            Form.addParameter(newName, Form.oForm[i].value);
        }
    }

    return true;
}

function AddParaForCover(Form)
{
    var wlandomain = Wlan[ssidIdx].domain;
    var length = wlandomain.length;
    var wlanInstId = parseInt(wlandomain.charAt(length-1));
    var beaconType = "Basic";

    Form.addParameter('w.SsidInst',wlanInstId);
    
    Form.addParameter('w.SSID',ltrim(getValue('WlanSsid_text')));
    setCoverSsidNotifyFlag(Wlan[ssidIdx].ssid, ltrim(getValue('WlanSsid_text')));
    
    Form.addParameter('w.Enable',getCheckVal('wlEnable'));

    Form.addParameter('w.Standard',WlanWifi.mode);

    Form.addParameter('w.BasicAuthenticationMode','None');
    Form.addParameter('w.BasicEncryptionModes','WEPEncryption');
    Form.addParameter('w.WPAAuthenticationMode','EAPAuthentication');
    Form.addParameter('w.WPAEncryptionModes',getSelectVal('WlanPwdMode_select'));
    Form.addParameter('w.IEEE11iAuthenticationMode','EAPAuthentication');
    Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
    Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
    Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
	Form.addParameter('w.SSIDAdvertisementEnabled',Wlan[ssidIdx].SSIDAdvertisementEnabled);
	Form.addParameter('w.WMMEnable',Wlan[ssidIdx].WMMEnable);
	Form.addParameter('w.MaxAssociateNum',Wlan[ssidIdx].X_HW_AssociateNum);
	Form.addParameter('w.STAIsolation',Wlan[ssidIdx].IsolationEnable);
    
    var AuthMode = getSelectVal('WlanAuthMode_select');
	if (AuthMode == 'open')
	{
		Form.addParameter('w.BeaconType','None');
		setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'None'); 
		
		Form.addParameter('w.BasicAuthenticationMode','OpenSystem');
		setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicAuthenticationMode, 'OpenSystem'); 
		
		Form.addParameter('w.BasicEncryptionModes','None');
		setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicEncryptionModes, 'None'); 
	}
    else if (AuthMode == 'shared')
	{
		Form.addParameter('w.BeaconType','Basic');
		setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'Basic'); 
		
		Form.addParameter('w.BasicAuthenticationMode',getSelectVal('WlanWepPwd_select'));
		setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicAuthenticationMode, getSelectVal('WlanWepPwd_select')); 
		
        Form.addParameter('w.BasicEncryptionModes','WEPEncryption');
		setCoverSsidNotifyFlag(Wlan[ssidIdx].BasicEncryptionModes, 'WEPEncryption'); 
	} else if (isAuthModeEnterprise(AuthMode)) {
        if (AuthMode == 'wpa')
        {
            Form.addParameter('w.BeaconType','WPA');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA');            
            
            beaconType = "WPA";
            Form.addParameter('w.WPAAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.WPAEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAEncryptionModes, getSelectVal('WlanPwdMode_select'));
        }
        else if (AuthMode == 'wpa2')
        {
            Form.addParameter('w.BeaconType','11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, '11i');
            
            beaconType = "11i";
            Form.addParameter('w.IEEE11iAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa/wpa2') {
            Form.addParameter('w.BeaconType','WPAand11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPAand11i');
            
            beaconType = "WPAand11i";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa3') {
            Form.addParameter('w.BeaconType','WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA3');

            beaconType = "WPA3";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa2/wpa3') {
            Form.addParameter('w.BeaconType','WPA2/WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA2/WPA3');

            beaconType = "WPA2/WPA3";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        }
    } else if ((isAuthModePreSharedKey(AuthMode)) || (AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('w.BeaconType','WPA');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA');
            
            beaconType = "WPA";
            Form.addParameter('w.WPAAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.WPAEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAEncryptionModes, getSelectVal('WlanPwdMode_select'));
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('w.BeaconType','11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, '11i');
            
            beaconType = "11i";
            Form.addParameter('w.IEEE11iAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa/wpa2-psk') {
            Form.addParameter('w.BeaconType','WPAand11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPAand11i');

            beaconType = "WPAand11i";
            Form.addParameter('w.MixAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'PSKAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa3-psk') {
            Form.addParameter('w.BeaconType','WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA3');

            beaconType = "WPA3";
            Form.addParameter('w.MixAuthenticationMode','SAEAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'SAEAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        } else if (AuthMode == 'wpa2/wpa3-psk') {
            Form.addParameter('w.BeaconType','WPA2/WPA3');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA2/WPA3');

            beaconType = "WPA2/WPA3";
            Form.addParameter('w.MixAuthenticationMode','PSKandSAEAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'PSKandSAEAuthentication');

            Form.addParameter('w.MixEncryptionModes',getSelectVal('WlanPwdMode_select'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('WlanPwdMode_select'));
        }
        else if(AuthMode == 'wapi')
        {
            Form.addParameter('w.BeaconType','X_HW_WAPI');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'X_HW_WAPI');
            
            beaconType = "X_HW_WAPI";
            
        }
        else if(AuthMode == 'wapi-psk')
        {
            Form.addParameter('w.BeaconType','X_HW_WAPI');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'X_HW_WAPI');
            
            beaconType = "X_HW_WAPI";
        }
    }
    var KeyBit = getSelectVal('WlanKeyBit_select');    
    Form.addParameter('w.WEPEncryptionLevel',(KeyBit-24)+'-bit');
    setCoverSsidNotifyFlag(Wlan[ssidIdx].EncypBit, (KeyBit-24)+'-bit');
    
    //var keyIndex = getSelectVal('wlKeyIndex');
    var keyIndex = 1;
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

    if ("Basic" != beaconType)
    {
        key = getValue('WlanPassword_password');
		if ((isFireFox4 == 1) && (key == ''))
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
            if ('WEPEncryption' == getSelectVal('WlanPwdMode_select'))
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
        if (('WEPEncryption' == getSelectVal('WlanPwdMode_select')) && (1 <= keyIndex) && (keyIndex <= 4))
        {
            setCoverSsidNotifyFlag(Wlan[ssidIdx].KeyIndex, keyIndex);
            setCoverSsidNotifyFlag(g_keys[ssidIdx * 4 + (keyIndex - 1)].value, key);
        }
    }
    
    return true;
}

function SubmitForm()
{
    var Form = new webSubmitForm();
	var busyflag = 0;

    if (addParameter1(Form) == false)
    {
		setDisable('Save_button',0);
    	setDisable('Cancel_button',0);	
		return;
    }
    
    if (addParameter2(Form) == false)
    {
		setDisable('Save_button',0);
    	setDisable('Cancel_button',0);	    
        return;
    }
    
    if (AddParaForCover(Form) == false)
    {
    	setDisable('Save_button',0);
    	setDisable('Cancel_button',0);     
        return;
    }
    
    var wlandomain = Wlan[ssidIdx].domain;
    var AuthMode = getSelectVal('WlanAuthMode_select');
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
	if (isWifiCoverSsidExt(wificoverindex))
	{
		if (isAuthModeEnterprise(AuthMode)) {
			AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_auth']);
			return;
		} else if (AuthMode == 'shared') {
			AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_wep']);
			return;
		}
	}
	
    if (isWifiCoverSsid(getWlanInstFromDomain(wlandomain)))
    {
        if (false == ConfirmEx(cfg_wificover_basic_language['amp_wificover_ssid_change_notify'])) 
        {
            guiCoverSsidNotifyFlag = 0;
            setDisable('Save_button',0);
            setDisable('Cancel_button',0);           
            return;
        }
    }      

    if (AddParameter5G(wlandomain, Form) == false) {
        return;
    }

	var url;

	if (AuthMode == 'open')
	{
		url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain;
	}
    else if (AuthMode == 'shared')
    {
        url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain
                    + '&k1=' + wlandomain + '.WEPKey.1'
                    + '&k2=' + wlandomain + '.WEPKey.2'
                    + '&k3=' + wlandomain + '.WEPKey.3'
                    + '&k4=' + wlandomain + '.WEPKey.4';
        if (isSet5Gflag == 1) {
            url += '&Y=' + Wlan[ssid5GIndex].domain;
        }
    } else if (isAuthModeEnterprise(AuthMode)) {
        url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain;
    } else if (isAuthModePreSharedKey(AuthMode)) {
        url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain
                    + '&k=' + wlandomain + '.PreSharedKey.1';
        if (isSet5Gflag == 1) {
            url += '&Y=' + Wlan[ssid5GIndex].domain + '&K=' + Wlan[ssid5GIndex].domain + '.PreSharedKey.1';
        }
    }
	else if(AuthMode == 'wapi' || AuthMode == 'wapi-psk')
	{
		url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain
		   		+'&k=' + wlandomain + '.PreSharedKey.1';
	}
    else
    {
		url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&x=InternetGatewayDevice.LANDevice.1'
                    + '&y=' + wlandomain;
    }

	if (('1' == aWiFiCustFlag) && (aWiFiSSID2GInst == getWlanInstFromDomain(wlandomain)) 
		&& (Wlan[ssidIdx].ssid != ltrim(getValue('WlanSsid_text'))))
	{
		url += '&z=InternetGatewayDevice.X_HW_DEBUG.aWiFi';
	}
	
	url += '&c2=' + configAction + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp';
	Form.setAction(url);

	Form.addParameter('c1.ActionType', 0);
    Form.addParameter('c2.ActionType', 1);
    Form.addParameter('c2.SSIDList', '' + getInstIdByDomain(Wlan[ssidIdx].domain));

    setDisable('Save_button',1);
    setDisable('Cancel_button',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function WlanBasic(enable)
{
	setDisplay('wlanBasicCfg',1);
	setCheck('WlanEnable_checkbox', enable);	

	if (((enable == 1) || ((enable == 0) && (fttrFlag == 1))) && (WlanArr[0] != null)) {
    	ssidIdx = 0;

		if ((1 == DoubleFreqFlag) && ("5G" == wlanpage) && (uiTotal5gNum > 0))
		{
			FirstRecordFor5G();
			selectLine('record_' + RecordFor5G);

		}
        else if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && ((uiTotal2gNum > 0)))
        {
			FirstRecordFor2G();
			selectLine('record_' + RecordFor2G);
        }
		else if (uiTotalNum > 0)
		{
			selectLine('record_0');	
		}
	
    	setDisplay('wlanCfg',1);
    	var authMode = Wlan[ssidIdx].BeaconType;
		beaconTypeChange(authMode); 
	}
	else
	{
    	setDisplay('wlanCfg',0);
	}
}

function BindPsdModifyEvent()
{
    $('#wlKeys1').bind("propertychange input", function(){ 
        var KeyBit = getSelectVal('WlanKeyBit_select');
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

    $('#WlanPassword_password').bind("propertychange input", function(){ 
        if(getValue('WlanPassword_password') != "********") 
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

function LoadFrame()
{
    $("#checkinfo4Row").css("display", "none");
    var pwdcheck4 = document.getElementById('checkinfo4');
    pwdcheck4.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd4" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue4" BindText="amp_pwd_strength_low"></div></div></div>';

    $("#checkinfo5Row").css("display", "none");
    var pwdcheck5 = document.getElementById('checkinfo5');
    pwdcheck5.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd5" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><div style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></div></div></div>';

	var flag5G =0;
	var flag2G =0;

	Total2gNum();

	if (enbl == '')
    {
        setDisplay('wlanBasicCfg',0);
    }
    else
    {
		setDisplay('ConfigForm',1); 
        if (1 == DoubleFreqFlag)
		{
		    FirstRecordFor5G();
			
            if ('2G' == wlanpage)
            {
                WlanBasic(enbl2G);
            }

            if ('5G' == wlanpage)
            {
                WlanBasic(enbl5G);
            }
		}
		else
		{
			WlanBasic(enbl);
		}		
    }

	if (1 == DoubleFreqFlag)
	{
		if("2G" == wlanpage)
		{
			for(var j = 0; j < WlanMap.length; j++)
			{
				if(WlanMap[j].portIndex < SsidPerBand )
				{
					flag2G++
				}
			}
			if(flag2G > 0)
			{
				setDisplay('ssidDetail',1);
			}
			else
			{
				setDisplay('ssidDetail',0);
			}
		}

		if("5G" == wlanpage)
		{
			for(var j = 0; j < WlanMap.length; j++)
			{
				if(WlanMap[j].portIndex >= SsidPerBand )
				{
					flag5G++
				}
			}
			if(flag5G > 0)
			{
				setDisplay('ssidDetail',1);
			}
			else
			{
				setDisplay('ssidDetail',0);
			}
		}
	}
	else 
    {
		if(0 == WlanMap.length)
		{
        	setDisplay('ssidDetail',0);
		}
    }

    addAuthModeOption();

	WlanKeyBit_selectChange();

	if (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_HUNCT);%>')
	{
		setDisable("WlanPwdMode_select",1);
		setDisable("WlanAuthMode_select",1);
	}

    if (wifiPasswordMask == 1) {
        BindPsdModifyEvent();
        setDisplay('hidewlRadiusKey', 0);
        setDisplay('hidewlKeys', 0);
        setDisplay('CheckoutPassword_button', 0);
    }
	
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

	if (g_keys[0] != null)
    {
        document.getElementById('wlKeys1').title = posswordComplexTitle;
        document.getElementById('twlKeys1').title = posswordComplexTitle;  
    } 
    document.getElementById('WlanPassword_password').title = posswordComplexTitle;
    document.getElementById('tWlanPassword_password').title = posswordComplexTitle;
    document.getElementById('wlRadiusKey').title = posswordComplexTitle;
    document.getElementById('twlRadiusKey').title = posswordComplexTitle;	
}

function ApplySubmit1()
{
    var Form = new webSubmitForm();   

    if (addParameter1(Form) == false)
    {
        setDisable('Save_button',0);
        setDisable('Cancel_button',0);	
        return;
    }
    
	if (1 == DoubleFreqFlag)
	{
		if ("2G" == wlanpage)
		{
  			Form.addParameter('y.LowerLayers', node2G);
			Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration'
	               					+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');	
		}
		else if ("5G" == wlanpage)
		{
  			Form.addParameter('y.LowerLayers', node5G);
			Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration'
	              					 + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
		}
		else
		{}

	}
	else
	{
        Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration' 
	                       + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
	}

    setDisable('Save_button',1);
    setDisable('Cancel_button',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

var processingState = 0;
function checkProcessingState() {
    processingState = ajaxGetAspData('/html/amp/wlanadv/getProcessState.asp');
    return processingState === '1';
}

function ApplySubmit2()
{
    if (checkProcessingState()) {
        AlertEx(cfg_wlancfgadvance_language['amp_config_busy']);
        return;
    }
    SubmitForm();
}

function ApplySubmit()
{
    if (AddFlag == true)
    {
        setDisable('BtnAdd', 1);
        setDisable('BtnRemove', 1);
        setDisable('Save_button',1);
        setDisable('Cancel_button',1);

        ApplySubmit1();
    }
    else
    {
        ApplySubmit2();
    }
}

function EnableSubmit()
{
    setDisable('WlanEnable_checkbox', 1);
    AddFlag = false;
    var Form = new webSubmitForm();
    var enable = getCheckVal('WlanEnable_checkbox');
	
    setDisable('Save_button', 1);
    setDisable('Cancel_button', 1);
	
    if (1 == DoubleFreqFlag)
    {
        if ("2G" == wlanpage)
        {
			Form.addParameter('x.Enable', enable);
		    if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node2G)
		    {
				Form.addParameter('x.RadioInst', 1);			
				Form.addParameter('y.Enable',enable);
				
				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
							+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}
		    }
		    else
		    {
				Form.addParameter('x.RadioInst', 2);
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
							+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
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
                                    + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
							+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}
		    }
		    else
		    {
				Form.addParameter('x.RadioInst', 2);			
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
							+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
				}    
		    }
        }
		else
		{
		
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
						+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
		}
		else
		{
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1'
					+ '&RequestFile=html/amp/wlanbasic/e8cWlanBasic.asp');
		} 
    }
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function showWlan(currentWlan)
{
    with (document.forms[0])
    {
        ShowSsidEnable(currentWlan);
        setText('WlanSsid_text',currentWlan.ssid);
        if (ssidAccessAttr.indexOf('Subscriber') < 0)
        {
            setDisable('WlanSsid_text',1);
        }

        beaconTypeChange(currentWlan.BeaconType);
    }
}

function setControl(idIndex)
{   
    if (-1 == idIndex)
    {   
        if (1 == SingleFreqFlag)
		{
			if (Wlan.length >= maxSingleWLAN.MAX_ID)
			{
				setDisplay('cfg_table', 0);
				AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
				return;
			}
		}
		else if (1 == DoubleFreqFlag)
		{
			Total2gNum();

			if ("2G" == wlanpage)
			{
				if ((uiTotal2gNum >= SsidPerBand) || (uiTotalNum >= SsidPerBand*2))
				{
					setDisplay('cfg_table', 0);
					AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
					return;
				}
			}
			
			else if("5G" == wlanpage)
			{
				if ((uiTotal5gNum >= SsidPerBand) || (uiTotalNum >= SsidPerBand*2))
				{
					setDisplay('cfg_table', 0);
					AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
					return;
				}
			}
		}
   	
        ssidIdx = -1;
        AddFlag = true;

        currentWlan = new stWlan('','','','',1,32,1,'','','','','','','','','','','','','','','');

        setDisplay('ssidDetail', 1);
        setDisplay('securityCfg',0);
    }
    else
    {
        setDisplay('cfg_table', 1);
        setDisplay('securityCfg',1);
        ssidIdx = parseInt(WlanMap[idIndex].index);
        AddFlag = false;
		
        currentWlan = Wlan[ssidIdx];
    }

    showWlan(currentWlan);
    wepOrigLen = (g_keys[ssidIdx * 4].value).length;
    setDisable('Save_button', 0);
    setDisable('Cancel_button', 0);

	var curWlanInst = getWlanInstFromDomain(currentWlan.domain);
	
    if (((1 == isSsidForIsp(curWlanInst)) && (1 == ShowISPSsidFlag))
        || (2 == curWlanInst && 1 == QhctFlag && 0 == currentWlan.enable))
	{
		if (1 != MngtGdCmcc)
		{
			setDisable('Save_button', 1);
			setDisable('Cancel_button', 1);
		}
		
	}


    ClearPsdModFlag();
	if (1 == MngtJsCmcc && 1 != curWlanInst && 5 != curWlanInst)
	{
		setDisable('Save_button', 1);
       	setDisable('Cancel_button', 1);		
	}
}

function selectRemoveCnt(curCheck)
{
}

function Cancel_buttonValue()
{
    $("#checkinfo4Row").css("display", "none");
    $("#checkinfo5Row").css("display", "none");
	var temp1 =0;
	var temp2 =0;
    if (AddFlag == true)
    {
        var tableRow = getElement("wlanInst");
		if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
		{
			FirstRecordFor5G();
			selectLine('record_' + RecordFor5G);
			
			for(var i = 0; i < WlanMap.length; i++)
			{
				if(WlanMap[i].portIndex >SsidPerBand-1)
				{
					temp1++;
				}
			}
			if(temp1==0)
			{
				setDisplay('ssidDetail',0);
			}
		}
		else if((1 == DoubleFreqFlag) && ("2G" == wlanpage))
		{
			FirstRecordFor2G();
			selectLine('record_' + RecordFor2G);
			
			for(var j = 0; j < WlanMap.length; j++)
			{
				if(WlanMap[j].portIndex < SsidPerBand)
				{
					temp2++;
				}
			}
			if(temp2==0)
			{
				setDisplay('ssidDetail',0);
			}
           
        }
		else
		{
			selectLine('record_0');
		}
        
        tableRow.deleteRow(tableRow.rows.length-1);
    }
    else
    {
        var currentWlan = Wlan[ssidIdx];
        showWlan(currentWlan);
    }

    ClearPsdModFlag();
}

var authmode = cfg_wlancfgdetail_language['amp_authmode_help'];
var encryption = cfg_wlancfgdetail_language['amp_encrypt_help'];
var ssid = cfg_wlancfgdetail_language['amp_ssid_help'];
var posswordComplexTitle = cfg_wlancfgdetail_language['amp_wlanpasswordcomplex_title'];

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

function psdStrength5(id) {
    var checkid= "pwdvalue5";
    pwdStrengthcheck(id,checkid);
}

function psdStrength4(id) {
    var checkid= "pwdvalue4";
    pwdStrengthcheck(id,checkid);
}

</script>
<style>
.row.hidden-pw-row {
  width: 132px;
  height: 30px;
  line-height: 30px;
}
</style>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr> 
		<td class="table_head" width="100%">无线基本配置</td> 
	</tr>

	<tr> 
		<td height="5"></td> 
	</tr>

    <tr>
      <td class="prompt">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
			    <td class="title_common">
					<script language="JavaScript">
					if((1 == DoubleFreqFlag) && ("2G" == wlanpage))
					{
						document.write(cfg_wlancfgother_language['amp_wlanbasic_title_2G']);
					}
					else if((1 == DoubleFreqFlag) && ("5G" == wlanpage))
					{
						document.write(cfg_wlancfgother_language['amp_wlanbasic_title_5G']);
					}
					else
					{
						document.write("说明：可设置无线的基本功能，" +
						"包括启用/禁用无线连接、设置无线网络SSID以及无线安全配置、指定加入无线网络是否需要网络密钥及密钥强度等基本功能(在无线网络功能关闭时，此页面内容可能为空)。");
					}
                    </script>
					<label id="Title_wlan_common_set_lable" class="title_common">					
					</label>                    
				</td>
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
          <tr><td class="title_common"><script>document.write("1. " + cfg_wlancfgother_language['amp_wlan_note']);</script></td></tr>
          <tr><td class="title_common">
                <script>
                    initWlanCap(wlanpage);
                    if ((capWpa3 == 1) && (isShowWpa3Eap == 1)) {
                        document.write("2. " + cfg_wlancfgother_language['amp_wlan_note4']);
                    } else {
                        document.write("2. " + cfg_wlancfgother_language['amp_wlan_note2']);
                    }
                </script>
          </td></tr>
       </td> 
    </tr> 
        </table>
      </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_space1">
    <tr ><td class="height15p"></td></tr>
</table>

<form id="ConfigForm" action="../network/set.cgi" style="display:none">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr ><td>
  
    <div id='wlanBasicCfg'>
    <div id='wlanswitch'>
    <table cellspacing="0" cellpadding="0" width="100%" id="wlanOnOff">
      <tr>
        <td><input type='checkbox' name='WlanEnable_checkbox' id='WlanEnable_checkbox' onClick='EnableSubmit();' value="ON">
          启用无线网络</input></td>
      </tr>
    </table>
  	</div>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_space2">
      <tr ><td class="width_10px"></td></tr>
    </table>

    <div id='wlanCfg'>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInst">
      <tr class="table_title" align="center">
        <td>&nbsp;</td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_id']);</script></div></td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_name']);</script></div></td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_link']);</script></div></td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_security_cfg']);</script></div></td>
      </tr>
        <script language="JavaScript" type="text/javascript">
        var iotSsidInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.SyncIotSsidInst);%>';
        for (var i = 0;i < WlanMap.length; i++)
        {   
			if ('' == Wlan[i].name)
			{
				continue;
			}                            

            var mapIndex = parseInt(getIndexFromPort(WlanMap[i].portIndex));

			if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
            {
                if (WlanMap[i].portIndex < SsidPerBand)
                {
                    continue;
                }
            }
					
			if ((1 == DoubleFreqFlag) && ("2G" == wlanpage))
            {
                if (WlanMap[i].portIndex > SsidPerBand-1)
                {
                    continue;
                }					
            }
			
			if (1 != DoubleFreqFlag)
			{
				if (WlanMap[i].portIndex > SsidPerBand-1)
                {
                    continue;
                }         
			}
			
            if (getWlanInstFromDomain(Wlan[mapIndex].domain) == aWiFiSSID2GInst && aWiFiCustFlag == '1' && curUserType != '0')
            {
                continue;
            }

            if (getWlanInstFromDomain(Wlan[mapIndex].domain) == iotSsidInst) {
                continue;
            } 

            document.write('<TR id="record_' + i  + '" class="tabal_01" onclick="selectLine(this.id);">');

            if ((0 == WlanMap[i].portIndex) || (4 == WlanMap[i].portIndex))
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

            if ((Wlan[mapIndex].BeaconType == 'Basic' && Wlan[mapIndex].BasicEncryptionModes == 'None') || (Wlan[mapIndex].BeaconType == 'None'))
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

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height5p"></td></tr>
</table>

<div id='ssidDetail'>
<table width="100%" border="0" cellpadding="0" cellspacing="1" id="cfg_table">
  <tr>
    <td colspan="6">
	
	<table  width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr class="tabal_head" id="ssid_defail">
          <td BindText='amp_ssid_detail'></td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25">SSID:&nbsp;</td>
            <td class="table_right" id="TdSSID">
              <input type="text" name="WlanSsid_text" id="WlanSsid_text" style="width:123px" maxlength="32">
              <font class="color_red">*</font><span class="gray">
              <script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></span> 
          </td>
        </tr>

        <tr>
          <td class="table_left width_per25" BindText='amp_link_status'></td>
          <td class="table_right" id="TdEnable">
            <input type='checkbox' id='wlEnable' name='wlEnable' value="ON" onClick="SsidEnable();">
            <span class="gray"> </span></td>
        </tr>
      </table>

    <div id='securityCfg'>
    <div id='WlanAuthMode_selectDiv'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25">认证模式:&nbsp;</td>
          <td class="table_right" id="TdAuth">
            <select id='WlanAuthMode_select' name='WlanAuthMode_select' size="1" onChange='authModeChange()' style = "width:145px">
            <script language="JavaScript" type="text/javascript">
            document.write("<option value='open' selected>"+cfg_wlancfgdetail_language['amp_auth_open']+"</option>");
            document.write("<option value='shared'>"+cfg_wlancfgdetail_language['amp_auth_shared']+"</option>");
            document.write("<option value='wpa-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
            document.write("<option value='wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
            document.write("<option value='wpa/wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
            document.write("<option value='wpa3-psk'>" + auth_wpa3_psk + "</option>");
            document.write("<option value='wpa2/wpa3-psk'>" + auth_wpa2wpa3_psk + "</option>");
            document.write("<option value='wpa'>"+cfg_wlancfgdetail_language['amp_auth_wpa']+"</option>");
            document.write("<option value='wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpa2']+"</option>");
            document.write("<option value='wpa/wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2']+"</option>");
            if (isShowWpa3Eap == 1) {
                document.write("<option value='wpa3'>" + auth_wpa3 + "</option>");
                document.write("<option value='wpa2/wpa3'>" + auth_wpa2wpa3 + "</option>");
            }

			if(1 == WapiFlag)
			{
				document.write("<option value='wapi-psk'>"+cfg_wlancfgdetail_language['amp_auth_wapi_psk']+"</option>");
				document.write("<option value='wapi'>"+cfg_wlancfgdetail_language['amp_auth_wapi']+"</option>");
			}
            </script>			
            </select> <span class="gray"> </span>
			<label id="Title_wlan_authentication_tips_lable" class="title_common">
                <script>
                    if ((capWpa3 == 1) && (isShowWpa3Eap == 1)) {
                        document.write(wpa3Notes);
                    } else {
                        document.write("推荐使用WPA-PSK/WPA2-PSK认证模式");
                    }
                </script>
			</label>
		</td>
        </tr>
      </table>
    </div>

    <div id='wlEncryMethod'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25" BindText='amp_encrypt_mode'>加密方式:&nbsp;</td>
          <td class="table_right" id="TdEncrypt">
            <select id = 'WlanPwdMode_select' name = 'WlanPwdMode_select'  size='1'  onChange='onMethodChange(0);' style = "width:145px">
            </select>
			<label id="Title_wlan_tkip+aes_tips_lable" class="title_common">
                <script>
                    if ((capWpa3 == 1) && (isShowWpa3Eap == 1)) {
                        document.write("推荐使用AES加密方式");
                    } else {
                        document.write("推荐使用TKIP+AES加密方式");
                    }
                </script>
			</label>
          </td>
        </tr>
      </table>
    </div>

	<div id='wlEncryWep'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25">WEP加密:&nbsp;</td>
          <td class="table_right" id="TdEncrypt">
            <select id = 'WlanWepPwd_select' name = 'WlanWepPwd_select'  size='1'  onChange='onWepChange(0);' style = "width:145px">
				<option value="OpenSystem" selected>OPEN</option>
				<option value="SharedKey">SHARE</option>
				<option value="Both">OPEN+SHARE</option>
            </select>
			<label id="Title_wlan_open+share_tips_lable" class="title_common">
			  	推荐使用OPEN+SHARE加密
			</label>
          </td>
        </tr>
      </table>
    </div>

    <div id='keyInfo'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25">加密长度:&nbsp;</td>
          <td class="table_right">
              <select id='WlanKeyBit_select' name='WlanKeyBit_select' size='1' onChange='WlanKeyBit_selectChange()' style = "width:145px">
                <option value="128" selected><script>document.write(cfg_wlancfgdetail_language['amp_encrypt_128key']);</script></option>
                <option value="64"><script>document.write(cfg_wlancfgdetail_language['amp_encrypt_64key']);</script></option>
              </select>
			  <label id="Title_wlan_key_tips_lable" class="title_common">
			  </label>
		 </td>
        </tr>

        <tr>
          <td class="table_left  width_per25">无线网络密钥:&nbsp;</td>
          <td class="table_right"> <script language="JavaScript" type="text/javascript">
            if (g_keys[0] != null)
            {
                document.write("<input type='password' autocomplete='off' id='wlKeys1' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>")
                document.write("<input type='text' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>");
            }
            </script>
			<font class="color_red">*</font>
		  	<button type='button' id='hidewlKeys' name='hidewlKeys' class="submit" onClick="ShowOrHideText(0, 'hidewlKeys', 'wlKeys1', 'twlKeys1', wep1password);"/>		 	
				<script>document.write(desc_show);</script>
			</button>
		  </td>
        </tr>
        <tr id = "checkinfo4Row" style="display:none;">
            <td id = "checkinfotite4" class="table_left width_per25" BindText='amp_wpa_psk_strength'></td>
            <td id = "checkinfo4" class="table_right"></td>
            <script>
            $('#wlKeys1').on('keyup',function(){
                $("#checkinfo4Row").css("display", "");
                $("#psd_checkpwd4").css("display", "block");
                psdStrength4("wlKeys1");
            });
            $('#twlKeys1').on('keyup',function(){
                $("#checkinfo4Row").css("display", "");
                $("#psd_checkpwd4").css("display", "block");
                psdStrength4("twlKeys1");
            });
            </script>
        </tr>
        </table>
    </div>

    <div id='wpaPreShareKey'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25" id= "wpa_psk">
		  <script>
		  var authMode = getSelectVal('WlanAuthMode_select'); 
		  if(authMode == 'wapi-psk')
		  {
		  		document.write(cfg_wlancfgdetail_language['amp_wapi_psk']);
		  }
		  else
		  {
		  		document.write("无线网络密钥:&nbsp;");
		  }
		  </script>
		  </td>
          <td class="table_right">
            <input type='password' autocomplete='off' id='WlanPassword_password' name='WlanPassword_password' size='20' maxlength='64' class="amp_font" onfocus="OnFocusToclearPwd_psk()" onchange="wpapskpassword=getValue('WlanPassword_password');getElById('tWlanPassword_password').value=wpapskpassword;" />
            <input type='text' id='tWlanPassword_password' name='tWlanPassword_password' size='20' maxlength='64' class="amp_font" style='display:none' onchange="wpapskpassword=getValue('tWlanPassword_password');getElById('WlanPassword_password').value=wpapskpassword;"/>
			<font class="color_red">*</font><span class="gray">
			<button type="button" id="CheckoutPassword_button" name="CheckoutPassword_button" class="submit" onClick="ShowOrHideText(1, 'CheckoutPassword_button', 'WlanPassword_password', 'tWlanPassword_password', wpapskpassword);">
				<script>document.write(desc_show);</script>
			</button>		
			<span id = "wpa_note">
				<script>document.write(cfg_wlancfgdetail_language['amp_wpa_psknote']);</script><
			/span>
			</span>
		 </td>
        </tr>
        <tr id = "checkinfo5Row" style="display:none;">
          <td id = "checkinfotite5" class="table_left width_per25" BindText='amp_wpa_psk_strength'></td>
          <td id = "checkinfo5" class="table_right"></td>
            <script>
            $('#WlanPassword_password').on('keyup',function(){
                $("#checkinfo5Row").css("display", "");
                $("#psd_checkpwd5").css("display", "block");
                psdStrength5("WlanPassword_password");
            });
            $('#tWlanPassword_password').on('keyup',function(){
                $("#checkinfo5Row").css("display", "");
                $("#psd_checkpwd5").css("display", "block");
                psdStrength5("tWlanPassword_password");
            });
            
            </script>

        </tr>
      </table>
    </div>

	 <div id='wlWapi'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
           <td class="table_left width_per25" BindText='amp_wapi_ip'></td>
           <td class="table_right">
              <input type='text' id='wapiIPAddr' name='wapiIPAddr' size='20' maxlength='15'>
			  <font class="color_red">*</font>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25" BindText='amp_wapi_port'></td>
           <td class="table_right">
              <input type='text' id='wapiPort' name='wapiPort' size='20' maxlength='15'>
			  <font class="color_red">*</font><span class="gray">
			  <script>document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);</script></span> 
          </td>
        </tr>
      </table>
    </div>

    <div id='wlRadius'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25" BindText='amp_radius_srvip'></td>
          <td class="table_right">
              <input type='text' id='wlRadiusIPAddr' name='wlRadiusIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25" BindText='amp_radius_srvport'></td>
          <td class="table_right">
            <input type='text' id='wlRadiusPort' name='wlRadiusPort' size='20' maxlength='5'>
            <font class="color_red">*</font><span class="gray">
            <script>document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);</script></span> 
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_left width_per25" BindText='amp_radius_sharekey'></td>

          <td class="table_right">
            <input type='password' id='wlRadiusKey' autocomplete='off' name='wlRadiusKey' size='20' maxlength='64' class="amp_font" onchange="radiuspassword=getValue('wlRadiusKey');getElById('twlRadiusKey').value=radiuspassword;" />
            <input type='text' id='twlRadiusKey' name='twlRadiusKey' size='20' maxlength='64' class="amp_font" style='display:none'  onchange="radiuspassword=getValue('twlRadiusKey');getElById('wlRadiusKey').value=radiuspassword;"/>
            <font class="color_red">*</font><span class="gray">
            <button type="button" id="hidewlRadiusKey" name="hidewlRadiusKey" class="submit" onClick="ShowOrHideText(2, 'hidewlRadiusKey', 'wlRadiusKey', 'twlRadiusKey', radiuspassword);"/>
            <script>document.write(desc_show);</script>
            </button></span>
          </td>
        </tr>
      </table>
    </div>

</div>
	
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
      <tr><td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr align="right">
            <td class="table_submit width_per25"></td>
            <td class="table_submit">
			  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <button id="Save_button" name="Save_button" type="button" class="submit" onClick="ApplySubmit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_sure']);</script></button>
              <button id="Cancel_button" name="Cancel_button" type="button" class="submit" onClick="Cancel_buttonValue();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
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

</td></tr>
</table>
</form>

<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
