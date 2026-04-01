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
<style type='text/css'>
  span.language-string {
  padding: 0px 15px;
  display: block;
  height: 40px;
  line-height: 40px;
}
.row.hidden-pw-row {
  width: 132px;
  height: 30px;
  line-height: 30px;
}
</style>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>ptvdfAllWlanBasic</title>
<script language="JavaScript" type="text/javascript">
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var WPAPSKFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_WPAPSK_SUPPORT);%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";

var BaseInstFacKeyChgF = '<%HW_WEB_GetBaseInstFacKeyChgF();%>';
var BaseInstFacKeyChgF2g = BaseInstFacKeyChgF.split(',')[0];
var BaseInstFacKeyChgF5g = BaseInstFacKeyChgF.split(',')[1];

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

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

var wlanpage;
wlanpage = top.WlanBasicPage;
initWlanCap(wlanpage);

var capNum = capInfo.length/2;
var wepCap2G = parseInt(capInfo.charAt(0));
var wepCap5G = parseInt(capInfo.charAt(0 + capNum));
var wps1Cap2G = parseInt(capInfo.charAt(3));

var wps1Cap5G = parseInt(capInfo.charAt(3 + capNum));
var capTkip2G = parseInt(capInfo.charAt(7));
var capTkip5G = parseInt(capInfo.charAt(7 + capNum));
var capWPAPSK2G = parseInt(capInfo.charAt(8));
var capWPAPSK5G = parseInt(capInfo.charAt(8 + capNum));
var capWPAWPA2PSK2G = parseInt(capInfo.charAt(10));
var capWPAWPA2PSK5G = parseInt(capInfo.charAt(10 + capNum));
var capWPAEAP2G = parseInt(capInfo.charAt(9));
var capWPAEAP5G = parseInt(capInfo.charAt(9 + capNum));
var capWPAWPA2EAP2G = parseInt(capInfo.charAt(11));
var capWPAWPA2EAP5G = parseInt(capInfo.charAt(11 + capNum));

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
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,WPARekey,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable, LowerLayers,
                X_HW_WAPIEncryptionModes,X_HW_WAPIAuthenticationMode,X_HW_WAPIServer,X_HW_WAPIPort, X_HW_WPSConfigurated, UAPSDEnable, IsolationEnable)
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
    this.LowerLayers = LowerLayers;
    this.X_HW_WAPIEncryptionModes = X_HW_WAPIEncryptionModes;
    this.X_HW_WAPIAuthenticationMode = X_HW_WAPIAuthenticationMode;
    this.X_HW_WAPIServer = X_HW_WAPIServer;
    this.X_HW_WAPIPort = X_HW_WAPIPort;
    this.X_HW_WPSConfigurated = X_HW_WPSConfigurated;
    this.UAPSDEnable = UAPSDEnable;
    this.IsolationEnable = IsolationEnable;
}

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stPreSharedKey(domain, psk, kpp)
{
    this.domain = domain;
    this.value = psk;

    if('1' == kppUsedFlag)
    {
        this.value = kpp;
    }
}

function stWpsPin(domain, X_HW_ConfigMethod, DevicePassword, X_HW_PinGenerator, Enable)
{
    this.domain = domain;
    this.X_HW_ConfigMethod = X_HW_ConfigMethod;
    this.DevicePassword = DevicePassword;
    this.X_HW_PinGenerator = X_HW_PinGenerator;
    this.Enable = Enable;
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

function stLanDevice(domain, WlanCfg, Wps2)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
    this.Wps2 = Wps2;
}

var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20,stWlanWifi);%>;
var WlanWifi = WlanWifiArr[0];
if (null == WlanWifi)
{
    WlanWifi = new stWlanWifi("","","","","11n","","","","","");
}

var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable|X_HW_Wps2Enable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];

var enbl = LanDevice.WlanCfg;
var Wps2 = LanDevice.Wps2;

var WlanCus = '<%HW_WEB_GetWlanCus();%>';
var WpsCapa = WlanCus.split(',')[0];

var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|LowerLayers|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort|X_HW_WPSConfigurated|UAPSDEnable|IsolationEnable,stWlan);%>;

var wlanArrLen = WlanArr.length - 1;

for (i=0; i < wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}

var index2g = -1;
var index5g = -1;

for (i = 0; i < Wlan.length; i++)
{
   if (0 == getWlanPortNumber(Wlan[i].name))
   {
		index2g = i;
   }
   else if (4 == getWlanPortNumber(Wlan[i].name))
   {
		index5g = i;
   }
}

var curIndex = index2g;

var WlanWifi2G = WlanWifiArr[index2g];
if (null == WlanWifi2G)
{
    WlanWifi2G = new stWlanWifi("","","","","11n","","","","","");
}

var WlanWifi5G = WlanWifiArr[index5g];
if (null == WlanWifi5G)
{
    WlanWifi5G = new stWlanWifi("","","","","11n","","","","","");
}

var curWlanWifi = WlanWifi2G;

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
if (null != g_keys)
{
    wep1password = g_keys[0];
    wep2password = g_keys[1];
    wep3password = g_keys[2];
    wep4password = g_keys[3];
}

var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey|KeyPassphrase,stPreSharedKey);%>;

var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,X_HW_ConfigMethod|DevicePassword|X_HW_PinGenerator|Enable,stWpsPin,STATUS);%>;

var ssidIdx = -1;
var ssidAccessAttr = 'Subscriber';
var currentWlan = new stWlan();

function wlanSetSelect(id, val)
{
	setSelect(id, val);
	
	if(id == 'wlKeyBit')
	{
		wlKeyBitChange();
	}
}
function getWlanPortNumber(name)
{
    var length = name.length;
    var number;
    var str = parseInt(name.charAt(length-1));
    return str;
}

function DisableButtons()
{
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
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

function addAuthModeOption()
{
    var mode = curWlanWifi.mode;
	var mode5G = WlanWifi5G.mode;
	var auth = getSelectVal('wlAuthMode');
	
    var authModes = { 'open' : [cfg_wlancfgdetail_language['amp_auth_open'], 1], 
	                  'shared' : [cfg_wlancfgdetail_language['amp_auth_shared'], (1 == wepCap)], 
	                  'wpa-psk' : [cfg_wlancfgdetail_language['amp_auth_wpapsk'], (1 == capWPAPSK) && ('1' == WPAPSKFlag)], 
	                  'wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1], 
	                  'wpa/wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], (1 == capWPAWPA2PSK)], 
	                  'wpa' : [cfg_wlancfgdetail_language['amp_auth_wpa'], (1 == capWPAEAP)], 
	                  'wpa2' : [cfg_wlancfgdetail_language['amp_auth_wpa2'], 1], 
	                  'wpa/wpa2' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2'], (1 == capWPAWPA2EAP)]
	                };
	
	
	if (((mode == "11n")||(mode == "11ac")||(mode == "11aconly"))
		||(mode5G == "11n")||(mode5G == "11ac")||(mode5G == "11aconly") || (1 != wepCap5G))
	{
		authModes['shared'][1] = 0;
	}
	
	if (0 == capWPAPSK5G)
	{
		authModes['amp_auth_wpapsk'][1] = 0;
	}
	
	if (0 == capWPAWPA2PSK5G)
	{
		authModes['amp_auth_wpawpa2psk'][1] = 0;
	}
	
	if (0 == capWPAEAP5G)
	{
		authModes['amp_auth_wpa'][1] = 0;
	}
	
	if (0 == capWPAWPA2EAP5G)
	{
		authModes['amp_auth_wpawpa2'][1] = 0;
	}
	
	
	InitDropDownListWithSelected('wlAuthMode', authModes, auth);
}

function addEncryMethodOption(type1,type2)
{
    var len = document.forms[0].wlEncryption.options.length;
    var mode = curWlanWifi.mode;
	var mode5G = WlanWifi5G.mode;

    for (i = 0; i < len; i++)
    {
        document.forms[0].wlEncryption.remove(0);
    }
    
    if ((type1 == 0) && (type2 == 0))
    {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
        
        if ((mode == "11n") || (mode == "11ac") || (0 == wepCap) || (mode == "11aconly")
			||(mode5G == "11n") || (mode5G == "11ac") || (0 == wepCap5G) || (mode5G == "11aconly"))
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");        
        }
        else
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
            document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
        }        
    }
    else if ((type1 == 0) && (type2 == 1))
    {        
        if ((mode != "11n") && (mode != "11ac") && (mode != "11aconly") 
			&& (mode5G != "11n") && (mode5G != "11ac") && (mode5G != "11aconly"))
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");             
        }	
    }
    else
    {
        if ((mode == "11n")||(mode == "11aconly")||(mode5G == "11n")||(mode5G == "11aconly"))
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");        
        }
        else
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
            if(('1' == capTkip) && ('1' == capTkip5G))
            {
                document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
                document.forms[0].wlEncryption[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
            }
        }           
    }
}

function openauthwarning()
{
	if (IsPtVdf !=1 )
	{
		return true;
	}
	
	if (ConfirmEx(cfg_wlancfgdetail_language['amp_open_auth_warning']) == false)
	{
		return false;
	}
	
	return true;
}

function authModeChange()
{
    setDisplay("wlEncryMethod",0);
    setDisplay("keyInfo", 0);
    setDisplay("wlRadius", 0);
    setDisplay("wpaGTKRekey", 0);
    setDisplay("wpaPreShareKey", 0);
    setDisable("wlEncryption",0);

    var authMode = getSelectVal('wlAuthMode');      
    
    switch (authMode)
    {
        case 'open':
            setDisplay('wlEncryMethod',1);             
            addEncryMethodOption(0,0);            
                wlanSetSelect('wlEncryption',Wlan[ssidIdx].BasicEncryptionModes);
                var encryMode = getSelectVal('wlEncryption');
                if (encryMode == 'None')
                {
                    setDisplay('keyInfo', 0);
                }
                else
                {                      
                    var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
                    setDisplay('keyInfo', 1); 
                    wlanSetSelect('wlKeyBit', parseInt(level)+24);
                    wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
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
            break;
            
        case 'shared':
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            var mode = curWlanWifi.mode;              
            var mode5G = WlanWifi5G.mode;
			
            if ((mode == "11n") || (mode == "11ac") || (mode == "11aconly")
				||(mode5G == "11n")||(mode5G == "11ac")||(mode5G == "11aconly"))
            {                  
                  setDisplay('wlEncryMethod',0);  
                  setDisplay('keyInfo', 0);                
            }
            else
            {                  
                setDisplay('wlEncryMethod',1); 
                setDisplay('keyInfo', 1);
                addEncryMethodOption(0,1);

                    wlanSetSelect('wlKeyBit', parseInt(level)+24);
                    wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
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
            break;

        case 'wpa':
        case 'wpa2':
        case 'wpa/wpa2':
            setDisplay('wlEncryMethod',1);
            addEncryMethodOption(1,0);
            setDisplay('wlRadius', 1);
            setDisplay('wpaGTKRekey', 1);
                if (authMode == 'wpa')
                {
                    wlanSetSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
                }
                else if (authMode == 'wpa2')
                {
                    wlanSetSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
                    
                }
                else
                {
                    wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
                }
                setText('wlRadiusIPAddr',Wlan[ssidIdx].RadiusServer);
                setText('wlRadiusPort',Wlan[ssidIdx].RadiusPort);
                setText('wlRadiusKey',Wlan[ssidIdx].RadiusKey);
                radiuspassword = Wlan[ssidIdx].RadiusKey; 
                setText('twlRadiusKey',Wlan[ssidIdx].RadiusKey);
                setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey); 
           
            break;

        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
            setDisplay('wlEncryMethod',1);
			addEncryMethodOption(1,0);
            setDisplay('wpaPreShareKey', 1);
            setDisplay('wpaGTKRekey', 1);
            document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wpa_psk");
			
			if (authMode == 'wpa-psk')
            {
                wlanSetSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
            }
            else if (authMode == 'wpa2-psk')
            {
                wlanSetSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
            }
            else
            {
                wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
            }
			
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value);
            wpapskpassword = wpaPskKey[ssidIdx].value;
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey); 

            break;
        default:
            break;
    }
	
	setEncryptSug();
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

function beaconTypeChange(mode)
{
    setDisplay('wlEncryMethod',0);
    setDisplay('keyInfo', 0);
    setDisplay('wlRadius', 0);
    setDisplay('wpaGTKRekey', 0);
    setDisplay('wpaPreShareKey', 0);

    if (mode == 'Basic')
    {
		var BasicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
		var BasicEncryptionModes = Wlan[ssidIdx].BasicEncryptionModes;
		setDisplay('wlEncryMethod',1);
		var mode5G = WlanWifi5G.mode;
        if (BasicEncryptionModes == 'WEPEncryption' && (mode5G == '11n' || mode5G == '11ac' || mode5G == '11aconly')) {
			setDisplay("wlEncryMethod", 1);
			addEncryMethodOption(0, 2);
			setDisplay("wpaPreShareKey", 1);
			setDisplay("wpaGTKRekey", 1);
			wlanSetSelect('wlAuthMode', 'wpa/wpa2-psk');
			wlanSetSelect('wlEncryption', 'TKIPandAESEncryption');
			setText('wlWpaPsk', wpaPskKey[ssidIdx].value);
			wpapskpassword = wpaPskKey[ssidIdx].value;
			setText('twlWpaPsk', wpaPskKey[ssidIdx].value);
			setText('wlWpaGtkRekey', Wlan[ssidIdx].WPARekey);
        } else {
			if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) {
				addEncryMethodOption(0,0);
				wlanSetSelect('wlAuthMode','open');
				wlanSetSelect('wlEncryption',BasicEncryptionModes);
				if (BasicEncryptionModes == 'None') {
					setDisplay('keyInfo', 0);
				} else {
					var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
					setDisplay('keyInfo', 1);
					wlanSetSelect('wlKeyBit', parseInt(level)+24);
					wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
					displaywepkey();
				}
			} else {
				var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
				addEncryMethodOption(0,1);
				setDisplay('keyInfo', 1);
				wlanSetSelect('wlAuthMode','shared');
				wlanSetSelect('wlEncryption',BasicEncryptionModes);
				wlanSetSelect('wlKeyBit', parseInt(level)+24);
				wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
				displaywepkey();
			}
		}
    }
    else if (mode == 'WPA')
    {
        if (Wlan[ssidIdx].WPAAuthenticationMode == 'EAPAuthentication')
        {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wlRadius", 1);
            setDisplay("wpaGTKRekey", 1);
            wlanSetSelect('wlAuthMode','wpa');
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
            setText('wlRadiusIPAddr',Wlan[ssidIdx].RadiusServer);
            setText('wlRadiusPort',Wlan[ssidIdx].RadiusPort);
            setText('wlRadiusKey',Wlan[ssidIdx].RadiusKey);
            radiuspassword = Wlan[ssidIdx].RadiusKey; 
            setText('twlRadiusKey',Wlan[ssidIdx].RadiusKey);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey);
        }
        else
        {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,1);
            setDisplay("wpaPreShareKey", 1);
            setDisplay("wpaGTKRekey", 1);
            wlanSetSelect('wlAuthMode','wpa-psk');
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
            wpapskpassword = wpaPskKey[ssidIdx].value; 
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey);
        }
    }
    else if ((mode == '11i') || (mode == 'WPA2') )
    {
        if (Wlan[ssidIdx].IEEE11iAuthenticationMode == 'EAPAuthentication')
        {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wlRadius", 1);
            setDisplay("wpaGTKRekey", 1);
            wlanSetSelect('wlAuthMode','wpa2');
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
            setText('wlRadiusIPAddr',Wlan[ssidIdx].RadiusServer);
            setText('wlRadiusPort',Wlan[ssidIdx].RadiusPort);
            setText('wlRadiusKey',Wlan[ssidIdx].RadiusKey);
            radiuspassword = Wlan[ssidIdx].RadiusKey; 
            setText('twlRadiusKey',Wlan[ssidIdx].RadiusKey);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey);
        }
        else
        {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,2);
            setDisplay("wpaPreShareKey", 1);
            setDisplay("wpaGTKRekey", 1);
            wlanSetSelect('wlAuthMode','wpa2-psk');
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
            wpapskpassword = wpaPskKey[ssidIdx].value; 
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey); 
        }
    }
    else if ((mode == 'WPAand11i')|| (mode == 'WPA/WPA2'))
    {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication')
        {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wlRadius", 1);
            setDisplay("wpaGTKRekey", 1);
            wlanSetSelect('wlAuthMode','wpa/wpa2');
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
            setText('wlRadiusIPAddr',Wlan[ssidIdx].RadiusServer);
            setText('wlRadiusPort',Wlan[ssidIdx].RadiusPort);
            setText('wlRadiusKey',Wlan[ssidIdx].RadiusKey);
            radiuspassword = Wlan[ssidIdx].RadiusKey; 
            setText('twlRadiusKey',Wlan[ssidIdx].RadiusKey);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey);
        }
        else
        {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(0,2);
            setDisplay("wpaPreShareKey", 1);
            setDisplay("wpaGTKRekey", 1);
            wlanSetSelect('wlAuthMode','wpa/wpa2-psk');
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
            wpapskpassword = wpaPskKey[ssidIdx].value; 
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('wlWpaGtkRekey',Wlan[ssidIdx].WPARekey); 
        }
    }
    else
    {   
        addEncryMethodOption(0,0);
        setDisplay('wlEncryMethod',1);
        wlanSetSelect('wlAuthMode','open');
        wlanSetSelect('wlEncryption','None');
    }
}

function wlKeyBitChange()
{
	var selVal = getSelectVal('wlKeyBit');
	
	if("128" == selVal)
	{
		getElById('span_wep_keynote').innerHTML = cfg_wlancfgdetail_language['amp_encrypt_keynote_128'];
	}
	else
	{
		getElById('span_wep_keynote').innerHTML = cfg_wlancfgdetail_language['amp_encrypt_keynote_64'];
	}
}

function IsAuthModePsk(AuthMode)
{
    if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsWpsConfigDisplay( )
{
    var AuthMode = getSelectVal('wlAuthMode');
    var EncryMode = getSelectVal('wlEncryption');
    
    if ('1' == '<%HW_WEB_GetFeatureSupport(FT_WLAN_MULTI_WPS_METHOD);%>')
    {
	    return false;
    }

    if (IsAuthModePsk(AuthMode))
    {
        if (((Wps2 == 1) && (EncryMode == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }

        if(0 == wps1Cap || (0 == wps1Cap5G))
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

function setEncryptSug()
{
	if ('0' == capTkip || (0 == capTkip5G))
	{
		return;
	}
	
	var encryMode = getSelectVal('wlEncryption');
	var spanEncrypt = getElementById('SpanEncrypt');
	if (encryMode != 'TKIPandAESEncryption')
	{
		spanEncrypt.innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_encry_status'];
		spanEncrypt.style.color = '#ff0000';
	}	
	else 
	{
		spanEncrypt.innerHTML = '';
	}
}

function setPSKwarningSug()
{	
	var pskpasswordwarning = getElementById('pskpasswordwarning');
	pskpasswordwarning.innerHTML = cfg_wlancfgdetail_language['amp_pwd_default_psk_warning'];
	pskpasswordwarning.style.color = '#ff0000';
}

function showPSKwarningSug()
{
	setDisplay("pskpasswordwarning",0);
	var AuthMode = getSelectVal('wlAuthMode');
	if (IsAuthModePsk(AuthMode))
	{
		if(0 == BaseInstFacKeyChgF2g)
		{
			setDisplay("pskpasswordwarning",1);
			setPSKwarningSug();
		}
	}
}

function onMethodChange(isSelected)
{ 
    var authMode = getSelectVal('wlAuthMode');
    var encryMode = getSelectVal('wlEncryption');
	setEncryptSug();
    setDisplay('keyInfo', 0);

    if (authMode == 'open')
    {
        if (encryMode == 'None')
        {
            setDisplay('keyInfo', 0);
        }
        else
        {
			var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            setDisplay('keyInfo', 1);
            wlanSetSelect('wlKeyBit', parseInt(level)+24);
            wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
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
}

function SsidEnable()
{
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
 return str.toString().replace(/(^\s*)/g,""); 
}

function addParameter1(Form)
{   
    Form.addParameter('y' + index2g + '.Enable',getCheckVal('wlEnable'));
    Form.addParameter('y' + index2g + '.SSIDAdvertisementEnabled',getCheckVal('wlHide'));
	
	Form.addParameter('y' + index5g + '.Enable',getCheckVal('wlEnable'));
	Form.addParameter('y' + index5g + '.SSIDAdvertisementEnabled',getCheckVal('wlHide'));
	
	Form.addParameter('z' + '.SsidInst',1);
	Form.addParameter('z' + '.Enable',getCheckVal('wlEnable'));
	Form.addParameter('z' + '.SSIDAdvertisementEnabled',getCheckVal('wlHide'));
	
	Form.addParameter('z' + '.SsidInst5G',5);
	Form.addParameter('z' + '.Enable5G',getCheckVal('wlEnable'));
	Form.addParameter('z' + '.SSIDAdvertisementEnabled5G',getCheckVal('wlHide'));
	
	Form.addParameter('z' + '.WMMEnable',Wlan[index2g].wmmEnable);
	Form.addParameter('z' + '.STAIsolation',Wlan[index2g].IsolationEnable);
	Form.addParameter('z' + '.MaxAssociateNum',Wlan[index2g].DeviceNum);
	Form.addParameter('z' + '.WMMEnable5G',Wlan[index5g].wmmEnable);
	Form.addParameter('z' + '.STAIsolation5G',Wlan[index5g].IsolationEnable);
	Form.addParameter('z' + '.MaxAssociateNum5G',Wlan[index5g].DeviceNum);
	
	
    var ssid = getValue('wlSsid');
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
	
	if (isValidAscii(ssid) != '')
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid'] + isValidAscii(ssid));
        return false;
    }

    for (i = 0; i < Wlan.length; i++)
    {
        if ((getWlanPortNumber(Wlan[i].name)<= 3) && ssidIdx != i && Wlan[i].ssid == ssid)
        {
			AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
			return false;
        }
        
        if ((getWlanPortNumber(Wlan[i].name) > 3) && index5g != i && Wlan[i].ssid == ssid)
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
			return false;
        }
    }

	Form.addParameter('y' + index2g + '.SSID',ssid);
	Form.addParameter('y' + index5g + '.SSID',ssid);
	
	Form.addParameter('z' + '.SSID',ssid);
	Form.addParameter('z' + '.SSID5G',ssid);
}

function addParameter2(Form)
{ 
    var url = '';
    var temp = '';

    var AuthMode = getSelectVal('wlAuthMode');
	var method = getSelectVal('wlEncryption');
	
	if(AuthMode == 'open' && method == 'None')
	{
		if(openauthwarning() == false)
		{
			return false;
		}
	}

    if (AuthMode == 'shared' || AuthMode == 'open')
    {
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

            var keyIndex = getSelectVal('wlKeyIndex');
            for (vKey = 0; vKey < 4; vKey++)
            {
               if (vKey == 0)
               {
                   val = wlKeys1;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key1'];
               }
               else if (vKey == 1)
               {
                   val = wlKeys2;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key2'];
               }
               else if (vKey == 2)
               {
                   val = wlKeys3;
                   KeyDesc = cfg_wlancfgdetail_language['amp_encrypt_key3'];
               }
               else
               {
                   val = wlKeys4;
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
						
            Form.addParameter('y' + index2g + '.WEPEncryptionLevel',(KeyBit-24)+'-bit');
            Form.addParameter('y' + index2g + '.WEPKeyIndex',index);
			Form.addParameter('y' + index5g + '.WEPEncryptionLevel',(KeyBit-24)+'-bit');
            Form.addParameter('y' + index5g + '.WEPKeyIndex',index);
			
			Form.addParameter('z' + '.WEPEncryptionLevel',(KeyBit-24)+'-bit');
            Form.addParameter('z' + '.WEPKeyIndex',index);
			Form.addParameter('z' + '.WEPEncryptionLevel5G',(KeyBit-24)+'-bit');
            Form.addParameter('z' + '.WEPKeyIndex5G',index);
            
            if (wifiPasswordMask == '1')
            {
                if (KeyBit == '128')
                {
                    if ((wlKeys1 != "*************") || (wep1PsdModFlag == true))
                    {
						Form.addParameter('k' + index2g + '1.WEPKey', wlKeys1);
						Form.addParameter('k' + index5g + '1.WEPKey', wlKeys1);
                    }
					
                    if ((wlKeys2 != "*************") || (wep2PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '2.WEPKey', wlKeys2);
						Form.addParameter('k' + index5g + '2.WEPKey', wlKeys2);
                    }

                    if ((wlKeys3 != "*************") || (wep3PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '3.WEPKey', wlKeys3);
						Form.addParameter('k' + index5g + '3.WEPKey', wlKeys3);
                    }

                    if ((wlKeys4 != "*************") || (wep4PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '4.WEPKey', wlKeys4);
						Form.addParameter('k' + index5g + '4.WEPKey', wlKeys4);
                    }
                }
                else
                {
                    if ((wlKeys1 != "*****") || (wep1PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '1.WEPKey', wlKeys1);
						Form.addParameter('k' + index5g + '1.WEPKey', wlKeys1);
                    }

                    if ((wlKeys2 != "*****") || (wep2PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '2.WEPKey', wlKeys2);
						Form.addParameter('k' + index5g + '2.WEPKey', wlKeys2);
                    }

                    if ((wlKeys3 != "*****") || (wep3PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '3.WEPKey', wlKeys3);
						Form.addParameter('k' + index5g + '3.WEPKey', wlKeys3);
                    }

                    if ((wlKeys4 != "*****") || (wep4PsdModFlag == true))
                    {
                        Form.addParameter('k' + index2g + '4.WEPKey', wlKeys4);
						Form.addParameter('k' + index5g + '4.WEPKey', wlKeys4);
                    }
                } 
            }
            else
            {
                Form.addParameter('k' + index2g + '1.WEPKey', wlKeys1);
                Form.addParameter('k' + index2g + '2.WEPKey', wlKeys2);
                Form.addParameter('k' + index2g + '3.WEPKey', wlKeys3);
                Form.addParameter('k' + index2g + '4.WEPKey', wlKeys4);
				Form.addParameter('k' + index5g + '1.WEPKey', wlKeys1);
                Form.addParameter('k' + index5g + '2.WEPKey', wlKeys2);
                Form.addParameter('k' + index5g + '3.WEPKey', wlKeys3);
                Form.addParameter('k' + index5g + '4.WEPKey', wlKeys4);
            }
        }
        
        Form.addParameter('y' + index2g + '.BeaconType','Basic');
		Form.addParameter('y' + index5g + '.BeaconType','Basic');
		
		Form.addParameter('z' + '.BeaconType','Basic');
		Form.addParameter('z' + '.BeaconType5G','Basic');
		
        if (AuthMode == 'open')
        {
			Form.addParameter('y' + index2g + '.BasicAuthenticationMode','None');
            Form.addParameter('y' + index5g + '.BasicAuthenticationMode','None');
			
			Form.addParameter('z' + '.BasicAuthenticationMode','None');
			Form.addParameter('z' + '.BasicAuthenticationMode5G','None');
        }
        else
        {
            Form.addParameter('y' + index2g + '.BasicAuthenticationMode','SharedAuthentication');
			Form.addParameter('y' + index5g + '.BasicAuthenticationMode','SharedAuthentication');
			
			Form.addParameter('z' + '.BasicAuthenticationMode','SharedAuthentication');
			Form.addParameter('z' + '.BasicAuthenticationMode5G','SharedAuthentication');
        }
		
        Form.addParameter('y' + index2g + '.BasicEncryptionModes',getSelectVal('wlEncryption'));
		Form.addParameter('y' + index5g + '.BasicEncryptionModes',getSelectVal('wlEncryption'));
		
		Form.addParameter('z' + '.BasicEncryptionModes',getSelectVal('wlEncryption'));
		Form.addParameter('z' + '.BasicEncryptionModes5G',getSelectVal('wlEncryption'));
    }
    else if (AuthMode == 'wpa' || AuthMode == 'wpa2' || AuthMode == 'wpa/wpa2')
    {
        var wlRadiusKey = getValue('wlRadiusKey');
		if ((isFireFox4 == 1) && (wlRadiusKey == ''))
		{
			wlRadiusKey = radiuspassword;
		}
		
        var wlRadiusIPAddr = getValue('wlRadiusIPAddr');
        var wlRadiusPort = getValue('wlRadiusPort');
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');
        
        if (wlRadiusIPAddr == '' || wlRadiusPort == '' || wlWpaGtkRekey == '' || wlRadiusKey == '')
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
        
        if (AuthMode == 'wpa')
        {
            Form.addParameter('y' + index2g + '.BeaconType','WPA');
            Form.addParameter('y' + index2g + '.WPAAuthenticationMode','EAPAuthentication');
            Form.addParameter('y' + index2g + '.WPAEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('y' + index5g + '.BeaconType','WPA');
            Form.addParameter('y' + index5g + '.WPAAuthenticationMode','EAPAuthentication');
            Form.addParameter('y' + index5g + '.WPAEncryptionModes',getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2')
        {
            Form.addParameter('y' + index2g + '.BeaconType','11i');
            Form.addParameter('y' + index2g + '.IEEE11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y' + index2g + '.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('y' + index5g + '.BeaconType','11i');
            Form.addParameter('y' + index5g + '.IEEE11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y' + index5g + '.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
        }
        else
        {
            Form.addParameter('y' + index2g + '.BeaconType','WPAand11i');
            Form.addParameter('y' + index2g + '.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y' + index2g + '.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('y' + index5g + '.BeaconType','WPAand11i');
            Form.addParameter('y' + index5g + '.X_HW_WPAand11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y' + index5g + '.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        }
        
        if (wifiPasswordMask == '1')
        {
            if ( (wlRadiusKey != "********") || (radPsdModFlag == true) )
            {
                Form.addParameter('y' + index2g + '.X_HW_RadiusKey',wlRadiusKey);
				Form.addParameter('y' + index5g + '.X_HW_RadiusKey',wlRadiusKey);
            }             
        }
        else
        {
           Form.addParameter('y' + index2g + '.X_HW_RadiusKey',wlRadiusKey);
		   Form.addParameter('y' + index5g + '.X_HW_RadiusKey',wlRadiusKey);
        }

        Form.addParameter('y' + index2g + '.X_HW_RadiuServer',wlRadiusIPAddr);
		Form.addParameter('y' + index5g + '.X_HW_RadiuServer',wlRadiusIPAddr);

        wlRadiusPort = parseInt(getValue('wlRadiusPort'),10);
        wlWpaGtkRekey = parseInt(getValue('wlWpaGtkRekey'),10);
        Form.addParameter('y' + index2g + '.X_HW_RadiusPort',wlRadiusPort);
        Form.addParameter('y' + index2g + '.X_HW_GroupRekey',wlWpaGtkRekey);
		Form.addParameter('y' + index5g + '.X_HW_RadiusPort',wlRadiusPort);
        Form.addParameter('y' + index5g + '.X_HW_GroupRekey',wlWpaGtkRekey);
    }
    else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        var value = getValue('wlWpaPsk');
		if ((isFireFox4 == 1) &&  (value == ''))
		{
			value = wpapskpassword;
		}
		
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');

        if (value == '' || wlWpaGtkRekey == '')
        {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }
		
		if (isValidWPAPskKey(value) == false)
		{
            AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
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
        
        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('y' + index2g + '.BeaconType','WPA');
            Form.addParameter('y' + index2g + '.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('y' + index2g + '.WPAEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('y' + index5g + '.BeaconType','WPA');
            Form.addParameter('y' + index5g + '.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('y' + index5g + '.WPAEncryptionModes',getSelectVal('wlEncryption'));
			
			Form.addParameter('z' + '.BeaconType','WPA');
            Form.addParameter('z' + '.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('z' + '.WPAEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('z' + '.BeaconType5G','WPA');
            Form.addParameter('z' + '.WPAAuthenticationMode5G','PSKAuthentication');
            Form.addParameter('z' + '.WPAEncryptionModes5G',getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('y' + index2g + '.BeaconType','11i');
            Form.addParameter('y' + index2g + '.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y' + index2g + '.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('y' + index5g + '.BeaconType','11i');
            Form.addParameter('y' + index5g + '.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y' + index5g + '.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
			
			Form.addParameter('z' + '.BeaconType','11i');
            Form.addParameter('z' + '.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('z' + '.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('z' + '.BeaconType5G','11i');
            Form.addParameter('z' + '.IEEE11iAuthenticationMode5G','PSKAuthentication');
            Form.addParameter('z' + '.IEEE11iEncryptionModes5G',getSelectVal('wlEncryption'));
        } 
        else
        {
            Form.addParameter('y' + index2g + '.BeaconType','WPAand11i');
            Form.addParameter('y' + index2g + '.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y' + index2g + '.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('y' + index5g + '.BeaconType','WPAand11i');
            Form.addParameter('y' + index5g + '.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y' + index5g + '.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
			
			Form.addParameter('z' + '.BeaconType','WPAand11i');
            Form.addParameter('z' + '.MixAuthenticationMode','PSKAuthentication');
            Form.addParameter('z' + '.MixEncryptionModes',getSelectVal('wlEncryption'));
			Form.addParameter('z' + '.BeaconType5G','WPAand11i');
            Form.addParameter('z' + '.MixAuthenticationMode5G','PSKAuthentication');
            Form.addParameter('z' + '.MixEncryptionModes5G',getSelectVal('wlEncryption'));
        } 
        
        if (wifiPasswordMask == '1')
        {
            if ( (value != "********") || (pskPsdModFlag == true) )
            {
                Form.addParameter('k' + index2g + '.PreSharedKey',value);
				Form.addParameter('k' + index5g + '.PreSharedKey',value);
				
				Form.addParameter('z' + '.Key',value);
				Form.addParameter('z' + '.Key5G',value);

                if('1' == kppUsedFlag)
                {
                    Form.addParameter('k' + index2g + '.KeyPassphrase',value);
					Form.addParameter('k' + index5g + '.KeyPassphrase',value);
                }
            }			 
        }
        else
        {
            Form.addParameter('k' + index2g + '.PreSharedKey',value);
			Form.addParameter('k' + index5g + '.PreSharedKey',value);
			
			Form.addParameter('z' + '.Key',value);
			Form.addParameter('z' + '.Key5G',value);

            if('1' == kppUsedFlag)
            {
                Form.addParameter('k' + index2g + '.KeyPassphrase',value);
				Form.addParameter('k' + index5g + '.KeyPassphrase',value);
            }
        }
		
        if (isValidDecimalNum(getValue('wlWpaGtkRekey')) == false)
        {
            AlertEx(cfg_wlancfgdetail_language['amp_wpakey_invalid']);
            return false;
        }

        wlWpaGtkRekey = parseInt(getValue('wlWpaGtkRekey'),10);
        Form.addParameter('y' + index2g + '.X_HW_GroupRekey',wlWpaGtkRekey);
		Form.addParameter('y' + index5g + '.X_HW_GroupRekey',wlWpaGtkRekey);
    }
    else
    {
    }

    return true;
}

function stExtendedWLC(domain, SSIDIndex)
{
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
}

var apExtendedWLC = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC,EXTEND);%>;

function isWifiCoverSsidExt()
{
    for (var j = 0; j < apExtendedWLC.length - 1; j++)
    {
        if ((1 == apExtendedWLC[j].SSIDIndex) || (5 == apExtendedWLC[j].SSIDIndex))
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
	
    if (addParameter1(Form) == false)
    {   
        return;
    }
    
    if (addParameter2(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);
        
        return;
    }
	
	if (enbl2G != enbl5G)
	{
		if(enbl2G == 0)
		{
			Form.addParameter('m.Enable', 1);
		}
		if(enbl5G == 0)
		{
			Form.addParameter('n.Enable', 1);
		}
	}

    var wlandomain2g = Wlan[index2g].domain;
	var wlandomain5g = Wlan[index5g].domain;
    var AuthMode = getSelectVal('wlAuthMode');
	
	var acApConfigPath = 'InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic';  
	
	if (isWifiCoverSsidExt())
	{
		if(AuthMode == 'wpa' || AuthMode == 'wpa2' || AuthMode == 'wpa/wpa2')
		{
			AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_auth']);
			return;
		}
		else if ((AuthMode == 'shared' || AuthMode == 'open') && (getSelectVal('wlEncryption') == 'WEPEncryption'))
		{
			AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_wep']);
			return;
		}
	}

    if (isWifiCoverSsidExt())
    {
        if (false == ConfirmEx(cfg_wificover_basic_language['amp_wificover_ssid_change_notify'])) 
        {
            guiCoverSsidNotifyFlag = 0;      
            return;
        }
    }
	
    if (AuthMode == 'shared' || AuthMode == 'open')
    {
		Url = 'set.cgi?z=' + acApConfigPath;
        Url += '&y' + index2g + '=' + wlandomain2g
			        + '&y' + index5g + '=' + wlandomain5g;
					
        if (getSelectVal('wlEncryption') != 'None')
        {
                Url += '&k' + index2g + '1=' + wlandomain2g + '.WEPKey.1'
                            + '&k' + index2g + '2=' + wlandomain2g + '.WEPKey.2'
                            + '&k' + index2g + '3=' + wlandomain2g + '.WEPKey.3'
                            + '&k' + index2g + '4=' + wlandomain2g + '.WEPKey.4'
							+ '&k' + index5g + '1=' + wlandomain5g + '.WEPKey.1'
                            + '&k' + index5g + '2=' + wlandomain5g + '.WEPKey.2'
                            + '&k' + index5g + '3=' + wlandomain5g + '.WEPKey.3'
                            + '&k' + index5g + '4=' + wlandomain5g + '.WEPKey.4';
        }
        
		Url += '&m=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&n=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
        Url += '&RequestFile=html/amp/wlanbasic/ptvdfAllWlanBasic.asp';
        Form.setAction(Url);
    }
    else if (AuthMode == 'wpa' || AuthMode == 'wpa2' || AuthMode == 'wpa/wpa2')
    {
        Form.setAction('set.cgi?y' + index2g + '=' + wlandomain2g
					+ '&y' + index5g + '=' + wlandomain5g
					+ '&m=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&n=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                    + '&RequestFile=html/amp/wlanbasic/ptvdfAllWlanBasic.asp');
    }
    else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
		Url = 'set.cgi?z=' + acApConfigPath;
		Url += '&y' + index2g + '=' + wlandomain2g + '&y' + index5g + '=' + wlandomain5g;
        Url += '&k' + index2g + '=' + wlandomain2g + '.PreSharedKey.1'
				+ '&k' + index5g + '=' + wlandomain5g + '.PreSharedKey.1';		
		Url += '&m=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&n=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
        Url += '&RequestFile=html/amp/wlanbasic/ptvdfAllWlanBasic.asp';
        Form.setAction(Url);
    }
    else
    {
        Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1'
					+ '&y' + index2g + '=' + wlandomain2g + '&y' + index5g + '=' + wlandomain5g
					+ '&m=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&n=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                    + '&RequestFile=html/amp/wlanbasic/ptvdfAllWlanBasic.asp');
    }

    DisableButtons();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function WlanBasic(enable)
{
    setDisplay('wlanBasicCfg',1);

    if ((1 == enable) && (WlanArr[curIndex] != null))
    {
        ssidIdx = curIndex;
        setDisplay('wlanCfg',1);
        var authMode = Wlan[ssidIdx].BeaconType;
        beaconTypeChange(authMode); 
    }
    else if ((0 == enable))
    {
        setDisplay('wlanCfg',0);
    } 
    else
    {
        setDisplay('ssidDetail', 0);
    }
}

function IsWpsConfig( )
{
    var AuthMode = getSelectVal('wlAuthMode');
    var EncryMode = getSelectVal('wlEncryption');

    if (IsAuthModePsk(AuthMode))
    {
        if (((Wps2 == 1) && (EncryMode == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }
		
		if (((Wps2 == 1) && (AuthMode == 'wpa')) || (WpsCapa == 0))
        {
        	return false;
        }

        if(0 == wps1Cap || (0 == wps1Cap5G))
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

function wlHideChange()
{
    var WpsEnable = wpsPinNum[ssidIdx].Enable;
    if((1 == WpsEnable) && (0 == getCheckVal('wlHide')) && (true == IsWpsConfig()))
    {
        AlertEx(cfg_wlancfgother_language['amp_bcastssid_off_help']);
        setCheck('wlHide',1);
    }
}

function setBasicSug()
{
	setEncryptSug();
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

	if(password1.match(/[a-z]/) && password1.match(/[A-Z]/)) score++;

	if(password1.match(/\d/)) score++;

	if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;

	if (password1.length > 12) score++;

	if(0 == score)
	{
		getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
		getElementById(pwdid).style.width=16.6+"%";
		getElementById(pwdid).style.borderBottom="4px solid #FF0000";
	}

	if(1 == score)
	{
		getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
		getElementById(pwdid).style.width=33.2+"%";
		getElementById(pwdid).style.borderBottom="4px solid #FF0000";
	}
	if(2 == score)
	{
		getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
		getElementById(pwdid).style.width=49.8+"%";
		getElementById(pwdid).style.borderBottom="4px solid #FFA500";
	}
	if(3 == score)
	{
		getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
		getElementById(pwdid).style.width=66.4+"%";
		getElementById(pwdid).style.borderBottom="4px solid #FFA500";
	}
	if(4 == score)
	{
		getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
		getElementById(pwdid).style.width=83+"%";
		getElementById(pwdid).style.borderBottom="4px solid #008000";
	}
	if(5 == score)
	{
		getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
		getElementById(pwdid).style.width=100+"%";
		getElementById(pwdid).style.borderBottom="4px solid #008000";
	}
}

function psdStrength1(id)
{
	var checkid= "pwdvalue1";
	pwdStrengthcheck(id,checkid);
}

function psdStrength2(id)
{
	var checkid= "pwdvalue2";
	pwdStrengthcheck(id,checkid);
}

function psdStrength3(id)
{
	var checkid= "pwdvalue3";
	pwdStrengthcheck(id,checkid);
}

function psdStrength4(id)
{
	var checkid= "pwdvalue4";
	pwdStrengthcheck(id,checkid);
}

function psdStrength5(id)
{
	var checkid= "pwdvalue5";
	pwdStrengthcheck(id,checkid);
}

function LoadFrame()
{    
	$("#checkinfo1Row").css("display", "none");
	if (IsPtVdf ==1 )
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd1" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="amp_pwd_strength_low"></span> </div></div>';
	}	
	
	$("#checkinfo2Row").css("display", "none");
	if (IsPtVdf ==1 )
	{
		var pwdcheck2 = document.getElementById('checkinfo2');
		pwdcheck2.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd2" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue2" BindText="amp_pwd_strength_low"></span></div></div>';
	}	
	
	$("#checkinfo3Row").css("display", "none");
	if (IsPtVdf ==1 )
	{
		var pwdcheck3 = document.getElementById('checkinfo3');
		pwdcheck3.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd3" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue3" BindText="amp_pwd_strength_low"></span></div></div>';
	}	
	
	$("#checkinfo4Row").css("display", "none");
	if (IsPtVdf ==1 )
	{
		var pwdcheck4 = document.getElementById('checkinfo4');
		pwdcheck4.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd4" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue4" BindText="amp_pwd_strength_low"></span></div></div>';
	}	
	
	$("#checkinfo5Row").css("display", "none");
	if (IsPtVdf ==1 )
	{
		var pwdcheck5 = document.getElementById('checkinfo5');
		pwdcheck5.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd5" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></span></div></div>';
	}	
  
	if (enbl == '')
    {
        setDisplay('wlanBasicCfg',0);
    }
    else
    {    
        setDisplay('ConfigForm',1); 
        WlanBasic(enbl);        
    }
        
    document.getElementById('TdSSID').title = ssid;
    document.getElementById('TdHide').title = hide;
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

	if(curIndex >= 0)
    {
        setDisplay('ssidDetail',1);
    }
    else
    {
        setDisplay('ssidDetail',0);
    }
       
    addAuthModeOption();

    if (wifiPasswordMask == 1) {
        BindPsdModifyEvent();
        setDisplay('hidewlRadiusKey', 0);
        setDisplay('hidewlWpaPsk', 0);
        setDisplay('hidewlKeys', 0);
        setDisplay('hideId1', 0);
        setDisplay('hideId2', 0);
        setDisplay('hideId3', 0);
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
        } else if (cfg_wlancfgother_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgother_language[b.getAttribute("BindText")];        
        } else if (cfg_wificover_basic_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wificover_basic_language[b.getAttribute("BindText")];        
        } else {
            ;
        }
    }
	
	setBasicSug();
	
	showPSKwarningSug();
	
	showWlan(WlanArr[curIndex]);
}

var processingState = 0;
function checkProcessingState() {
    processingState = ajaxGetAspData('/html/amp/wlanadv/getProcessState.asp');
    return processingState === '1';
}

function ApplySubmit()
{    
    if (checkProcessingState()) {
        AlertEx(cfg_wlancfgadvance_language['amp_config_busy']);
        return;
    }
	SubmitForm();
}

function showWlan(currentWlan)
{
	ShowSsidEnable(currentWlan);
    setCheck('wlHide', currentWlan.wlHide);
    setText('wlSsid',currentWlan.ssid);
    if (ssidAccessAttr.indexOf('Subscriber') < 0)
	{
		setDisable('wlSsid',1);
    }

    beaconTypeChange(currentWlan.BeaconType);
    setBasicSug();
}

function cancelValue()
{
	$("#checkinfo1Row").css("display", "none");
	$("#checkinfo2Row").css("display", "none");
	$("#checkinfo3Row").css("display", "none");
	$("#checkinfo4Row").css("display", "none");
	$("#checkinfo5Row").css("display", "none");

    var currentWlan = Wlan[index2g];
    showWlan(currentWlan);
	ClearPsdModFlag();
}

var hide = cfg_wlancfgdetail_language['amp_bcastssid_help'];
var authmode = cfg_wlancfgdetail_language['amp_authmode_help'];
var encryption = cfg_wlancfgdetail_language['amp_encrypt_help'];
var ssid = cfg_wlancfgdetail_language['amp_ssid_help'];
var posswordComplexTitle = cfg_wlancfgdetail_language['amp_wlanpasswordcomplex_title'];
</script>
</head>


<body class="" onLoad="LoadFrame(); ">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<div class="title_spread"></div>

<form id="ConfigForm"  style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr >
	<td>
		<div id='wlanBasicCfg'>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_space2">
		<tr ><td class="width_10px"></td></tr>
    </table>

    <div id='wlanCfg'>		
	<div id="list_table_spread" class="list_table_spread" style = 'display:none;'></div>

<div id='ssidDetail'>
<table width="100%" border="0" cellpadding="0" cellspacing="1" id="cfg_table">
  <tr>
    <td colspan="6">

    <table  width="100%" border="0" cellpadding="0" cellspacing="0"><tr class="tabal_head" id="ssid_defail"><td class="block_title" BindText='amp_ssid_detail'></td></tr></table>

    <div id="wlanbasicWeb" class="configborder">
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_link_name'></td>
            <td class="table_right" id="TdSSID">
              <script language="JavaScript" type="text/javascript">
                  document.write('<input type="text" name="wlSsid" id="wlSsid" style="width:123px" maxlength="32">');
              </script>            
              <font class="color_red">*</font><span id="ssidLenTips" class="gray">
              <script>
              var ssidTips = cfg_wlancfgdetail_language['amp_linkname_note'];
              document.write(ssidTips);
              </script>
              </span> 
          </td>
        </tr>

        <tr>
          <td class="table_title width_per25" BindText='amp_link_status'></td>
          <td class="table_right" id="TdEnable">
            <input type='checkbox' id='wlEnable' name='wlEnable' value="ON" onClick="SsidEnable();">
            <span class="gray"> </span></td>
        </tr>

        <tr>
          <td class="table_title width_per25" BindText='amp_bcast_cssid'></td>
          <td class="table_right" id="TdHide">
            <input type='checkbox' id='wlHide' name='wlHide' value="ON" onclick='wlHideChange()'>
            <span class="gray"> </span></td>
        </tr>
		</table>
		<div id='DivFrequency'>
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
				<tr>
					<td class="table_title width_per25"><script>document.write(vdf_wlan_basic_language["amp_wlan_basic_frequency"]);</script></td>
					<td class="table_right">
					<script>document.write(vdf_wlan_basic_language["amp_wlan_basic_both"]);</script>
					</td>
				</tr>
			</table>
		</div>
								
    <div id='securityCfg'>
    <div id='wlAuthModeDiv'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_auth_mode'></td>
          <td class="table_right" id="TdAuth">
            <select id='wlAuthMode' name='wlAuthMode' size="1" onChange='authModeChange()' class="width_180px">
            <script language="JavaScript" type="text/javascript">
                document.write("<option value='open' selected>"+cfg_wlancfgdetail_language['amp_auth_open']+"</option>");
                document.write("<option value='shared'>"+cfg_wlancfgdetail_language['amp_auth_shared']+"</option>");
                document.write("<option value='wpa-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
                document.write("<option value='wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
                document.write("<option value='wpa/wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
                document.write("<option value='wpa'>"+cfg_wlancfgdetail_language['amp_auth_wpa']+"</option>");
                document.write("<option value='wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpa2']+"</option>");
                document.write("<option value='wpa/wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2']+"</option>");
            </script>
            </select> <span class="gray"> </span></td>
        </tr>
      </table>
    </div>

    <div id='wlEncryMethod'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_encrypt_mode'></td>
          <td class="table_right" id="TdEncrypt">
            <select id = 'wlEncryption' name = 'wlEncryption'  size='1'  onChange='onMethodChange(0);' class="width_180px">
            </select>
			<span id="SpanEncrypt" class="gray">  
			</span>
          </td>
        </tr>
      </table>
    </div>

    <div id='keyInfo'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr id="tr_wepKeyBit">
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
            <select id='wlKeyIndex' name='wlKeyIndex' size='1' onChange='' class="width_150px">
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
            if (g_keys[0] != null)
            {
                document.write("<input type='password' autocomplete='off' id='wlKeys1' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>")
                document.write("<input type='text' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>");
            }
            </script> </td>
          <td rowspan="4"  class="table_right"> <font class="color_red">*</font> 
            <input checked type='checkbox' id='hidewlKeys' name='hidewlKeys' value='on' onClick="ShowOrHideText('hidewlKeys', 'wlKeys1', 'twlKeys1', wep1password);ShowOrHideText('hidewlKeys', 'wlKeys2', 'twlKeys2', wep2password);ShowOrHideText('hidewlKeys', 'wlKeys3', 'twlKeys3', wep3password);ShowOrHideText('hidewlKeys', 'wlKeys4', 'twlKeys4', wep4password);"/>
            <span id="hideId1"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
            <span id="span_wep_keynote" class="gray"> <script>document.write(cfg_wlancfgdetail_language['amp_encrypt_keynote']);</script></span> 
          </td>
        </tr>
		<tr id = "checkinfo1Row" style="display:none;">
          <td id = "checkinfotitel" class="table_title width_per25" BindText='amp_encrypt_key1_strength'></td>
		  <td id = "checkinfo1" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys1').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo1Row").css("display", "");
					$("#psd_checkpwd1").css("display", "block");
					psdStrength1("wlKeys1");
				}
			});	
			$('#twlKeys1').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo1Row").css("display", "");
					$("#psd_checkpwd1").css("display", "block");
					psdStrength1("twlKeys1");
				}
			});	
			</script>
        </tr>	

        <tr>
          <td class="table_title width_per25" BindText='amp_encrypt_key2'></td>
          <td class="table_right"> <script language="JavaScript" type="text/javascript">
            if(g_keys[1] != null)
            {
                document.write("<input type='password' id='wlKeys2' autocomplete='off' name='wlKeys2' size='20' maxlength=26 onchange=\"wep2password=getValue('wlKeys2');getElById('twlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1])+ "'>")
                document.write("<input type='text' id='twlKeys2' name='twlKeys2' size='20' maxlength=26  style='display:none'  onchange=\"wep2password=getValue('twlKeys2');getElById('wlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1]) + "'>");
            }
            </script> </td>
		</tr>
		<tr id = "checkinfo2Row" style="display:none;">
          <td id = "checkinfotite2" class="table_title width_per25" BindText='amp_encrypt_key2_strength'></td>
		  <td id = "checkinfo2" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys2').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo2Row").css("display", "");
					$("#psd_checkpwd2").css("display", "block");
					psdStrength2("wlKeys2");
				}
			});	
			$('#twlKeys2').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo2Row").css("display", "");
					$("#psd_checkpwd2").css("display", "block");
					psdStrength2("twlKeys2");
				}
			});	
			</script>

        </tr>
        <tr>
          <td class="table_title width_per25" BindText='amp_encrypt_key3'></td>
          <td class="table_right"> <script language="JavaScript" type="text/javascript">
            if(g_keys[2] != null)
            {
                document.write("<input type='password' autocomplete='off' id='wlKeys3' name='wlKeys3' size='20' maxlength=26 onchange=\"wep3password=getValue('wlKeys3');getElById('twlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>")
                document.write("<input type='text' id='twlKeys3' name='twlKeys3' size='20' maxlength=26  style='display:none' onchange=\"wep3password=getValue('twlKeys3');getElById('wlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>");
            }
            </script> </td>
        </tr>
		<tr id = "checkinfo3Row" style="display:none;">
          <td id = "checkinfotite3" class="table_title width_per25" BindText='amp_encrypt_key3_strength'></td>
		  <td id = "checkinfo3" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys3').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo3Row").css("display", "");
					$("#psd_checkpwd3").css("display", "block");
					psdStrength3("wlKeys3");
				}
			});	
			$('#twlKeys3').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo3Row").css("display", "");
					$("#psd_checkpwd3").css("display", "block");
					psdStrength3("twlKeys3");
				}
			});
			</script>
        </tr>

        <tr>
          <td class="table_title width_per25" BindText='amp_encrypt_key4'></td>
          <td class="table_right"> <script language="JavaScript" type="text/javascript">
            if(g_keys[3] != null)
            {
                document.write("<input type='password' autocomplete='off' id='wlKeys4' name='wlKeys4' size='20' maxlength=26 onchange=\"wep4password=getValue('wlKeys4');getElById('twlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>")
                document.write("<input type='text' id='twlKeys4' name='twlKeys4' size='20' maxlength=26  style='display:none' onchange=\"wep4password=getValue('twlKeys4');getElById('wlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>");
            }
            </script> </td>
		</tr>
		<tr id = "checkinfo4Row" style="display:none;">
          <td id = "checkinfotite4" class="table_title width_per25" BindText='amp_encrypt_key4_strength'></td>
		  <td id = "checkinfo4" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys4').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo4Row").css("display", "");
					$("#psd_checkpwd4").css("display", "block");
					psdStrength4("wlKeys4");
				}
			});	
			$('#twlKeys4').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo4Row").css("display", "");
					$("#psd_checkpwd4").css("display", "block");
					psdStrength4("twlKeys4");
				}
			});	
			</script>

        </tr>
      </table>
    </div>

    <div id='wpaPreShareKey'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" id= "wpa_psk">
          <script>
                  document.write(cfg_wlancfgdetail_language['amp_wpa_psk']);
          </script>
          </td>
          <td class="table_right">
            <input type='password' autocomplete='off' id='wlWpaPsk' name='wlWpaPsk' size='20' maxlength='64' class="amp_font"  onchange="wpapskpassword=getValue('wlWpaPsk');getElById('twlWpaPsk').value=wpapskpassword;" />
            <input type='text' id='twlWpaPsk' name='twlWpaPsk' size='20' maxlength='64' class="amp_font" style='display:none' onchange="wpapskpassword=getValue('twlWpaPsk');getElById('wlWpaPsk').value=wpapskpassword;"/>
            <input checked type="checkbox" id="hidewlWpaPsk" name="hidewlWpaPsk" value="on" onClick="ShowOrHideText('hidewlWpaPsk', 'wlWpaPsk', 'twlWpaPsk', wpapskpassword);"/>
            <span id="hideId2"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
            <font class="color_red">*</font><span class="gray">
            <script>
                document.write(cfg_wlancfgdetail_language['amp_wpa_psknote' + ('1' == kppUsedFlag ? '_63' : '')]);
            </script></span>
			<span class="gray" id = "pskpasswordwarning" style="display:none;"></span></td>
		</tr>
		<tr id = "checkinfo5Row" style="display:none;">
          <td id = "checkinfotite5" class="table_title width_per25" BindText='amp_encrypt_key4_strength'></td>
		  <td id = "checkinfo5" class="table_title"></td>
			<script>		
			$('#wlWpaPsk').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo5Row").css("display", "");
					$("#psd_checkpwd5").css("display", "block");
					psdStrength5("wlWpaPsk");
				}
			});	
			$('#twlWpaPsk').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo5Row").css("display", "");
					$("#psd_checkpwd5").css("display", "block");
					psdStrength5("twlWpaPsk");
				}
			});	
			
			</script>

        </tr>
      </table>
    </div>
    
    <div id='wlRadius'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_srvip'></td>
          <td class="table_right">
              <input type='text' id='wlRadiusIPAddr' name='wlRadiusIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_srvport'></td>
          <td class="table_right">
            <input type='text' id='wlRadiusPort' name='wlRadiusPort' size='20' maxlength='5'>
            <font class="color_red">*</font><span class="gray">
            <script>document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);</script></span> 
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
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
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_wpakey_time'></td>
          <td class="table_right"><input type='text' id='wlWpaGtkRekey' name='wlWpaGtkRekey' size='20' maxlength='10' value='3600' class="amp_font">
            <font class="color_red">*</font><span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_wpakey_timenote']);</script></span></td>
        </tr>
      </table>
    </div>

    </div>

	</div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
      <tr><td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr>
            <td class="table_submit width_per25"></td>
            <td class="table_submit">
              <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="ApplySubmit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
              <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="cancelValue();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
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
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
</body>
</html>
