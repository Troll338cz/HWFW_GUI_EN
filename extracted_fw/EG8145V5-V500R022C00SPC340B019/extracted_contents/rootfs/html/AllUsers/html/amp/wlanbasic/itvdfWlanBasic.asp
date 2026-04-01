<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>

<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, IT_VDF_wlan_basic_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, IT_VDF_wlan_basic_language, cfg_wlancfgadvance_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>

<title>General</title>
<script language="JavaScript" type="text/javascript">
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

function stWlan(domain,enable,name,ssid,BeaconType,BasicEncrypt,BasicAuth,KeyIndex,EncryptionLevel,WPAEncrypt,WPAAuth,IEEE11iEncrypt,IEEE11iAuth,WPAand11iEncrypt,WPAand11iAuth, wlHide, mode)
{
    this.domain = domain;
    this.enable = enable;
    this.name = name;
    this.ssid = ssid;
    this.BeaconType = BeaconType;    
    this.BasicAuthenticationMode = BasicAuth;
	this.BasicEncryptionModes = BasicEncrypt; 
    this.KeyIndex = KeyIndex;
    this.EncypBit = EncryptionLevel;	
    this.WPAAuthenticationMode = WPAAuth;
	this.WPAEncryptionModes = WPAEncrypt;    
    this.IEEE11iAuthenticationMode = IEEE11iAuth;
	this.IEEE11iEncryptionModes = IEEE11iEncrypt;
	this.X_HW_WPAand11iAuthenticationMode = WPAand11iAuth;
	this.X_HW_WPAand11iEncryptionModes = WPAand11iEncrypt;
	this.wlHide = wlHide;
	this.mode = mode;
}

function stLanDevice(domain, WlanCfg, Wps2)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
    this.Wps2 = Wps2;
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

function stWpsPin(domain, Enable)
{
    this.domain = domain;
    this.Enable = Enable;
}

var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,Enable,stWpsPin,STATUS);%>;

var WlanInfo = new Array();
WlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Enable|Name|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|SSIDAdvertisementEnabled|X_HW_Standard,stWlan,STATUS);%>;  
for (var i = 0; i <  WlanInfo.length; i++)
{
	if(null == WlanInfo[i])
	{
		WlanInfo.splice(i,1);
	}
}

var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey|KeyPassphrase,stPreSharedKey);%>;

var ssidIndex2G = 1;
var ssidIndex5G = 5;
var WlanInfo2G;
var WlanInfo5G = '-1';
var WlanInfoArray = new Array();

for(var i = 0; i < WlanInfo.length; i++)
{
	if (1 == getWlanInstFromDomain(WlanInfo[i].domain))
	{
		WlanInfo2G = WlanInfo[i];
		if (1 == WlanInfo2G.enable)
		{
			WlanInfoArray.push(WlanInfo2G);
		}
		
		continue;
	}
	else if (1 == DoubleFreqFlag && 5 == getWlanInstFromDomain(WlanInfo[i].domain))
	{
		WlanInfo5G = WlanInfo[i];
		if (1 == WlanInfo5G.enable)
		{
			WlanInfoArray.push(WlanInfo5G);
		}
		
		continue;
	}
}


var wpsPinNum2G;
var wpsPinNum5G = '-1';
for(var i = 0; i < wpsPinNum.length - 1; i++)
{
	if (1 == getWlanInstFromDomain(wpsPinNum[i].domain))
	{
		wpsPinNum2G = wpsPinNum[i];
		continue;
	}
	else if (1 == DoubleFreqFlag && 5 == getWlanInstFromDomain(wpsPinNum[i].domain))
	{
		wpsPinNum5G = wpsPinNum[i];
		continue;
	}
}

var WlanInfoArray2G = new Array();
var WlanInfoArray5G = new Array();
var ssidStart2G = 0;
var ssidEnd2G = 3;
var ssidStart5G = 4;
var ssidEnd5G = 7;
for (var i = 0; i < WlanInfo.length; i++ )
{
	var athindex = getWlanPortNumber(WlanInfo[i].name);
    if (( athindex >= ssidStart2G )&&( athindex <= ssidEnd2G ))	
	{
		WlanInfoArray2G.push(WlanInfo[i]);
	}
	else if (( athindex >= ssidStart5G )&&( athindex <= ssidEnd5G )) 
	{
		WlanInfoArray5G.push(WlanInfo[i]);
	}
}

var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable|X_HW_Wps2Enable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];

var enbl = LanDevice.WlanCfg;
var Wps2 = LanDevice.Wps2;
var WlanCus = '<%HW_WEB_GetWlanCus();%>';
var WpsCapa = WlanCus.split(',')[0];

var wps1Cap2G = parseInt(capInfo.charAt(3));
var wps1Cap5G = parseInt(capInfo.charAt(3 + capInfo.length/2));

var wep1password;
var wep2password;
var wep3password;
var wep4password;
var wpapskpassword;
var wep1PsdModFlag = false;
var wep2PsdModFlag = false;
var wep3PsdModFlag = false;
var wep4PsdModFlag = false;
var pskPsdModFlag = false;
	
var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
if (null != g_keys)
{
    wep1password = g_keys[0];
    wep2password = g_keys[1];
    wep3password = g_keys[2];
    wep4password = g_keys[3];
}

var freValArr = { '2.4G' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_2G"], 
	              '5G' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_5G"], 
	              'both' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_both"]
	            };	
					
var freVal;
function setSelShow(obj)
{
	var text = obj.innerHTML;
	var dropdownShowId =  obj.offsetParent.firstChild.id;
	
	$('#'+dropdownShowId).html(text);
	SetClickFlag(false);
	$('#'+dropdownShowId).css("background-image","url('../../../images/arrow-down.png')");
}

function frenquencySelValue(obj)
{
	setSelShow(obj);
	freVal = obj.getAttribute('dataValue');
	SelFrenChange();
}

function setFrenquencySel()
{
	var frenquencyArr = new Array();
	for (var key in freValArr)
	{
		frenquencyArr.push([freValArr[key],key]);
	}
	
	var DefaultValue = frenquencyArr[0];
	createWlanDropdown("SelFrenquency", DefaultValue, "220px", frenquencyArr, "frenquencySelValue(this);");
}

var authModeValArr = { 'off' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_off"], 
					   'wpa-psk' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_wpapsk"], 
					   'wpa2-psk' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_wpa2psk"],
					   'wpa/wpa2-psk' : IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_wpawpa2psk"]
					 };	
				
var authModeVal;
function authModeSelValue(obj)
{
	setSelShow(obj);
	authModeVal = obj.getAttribute('dataValue');
	authModeChange();
}

function setAuthModeSel()
{
	var authModeArr = new Array();
	for (var key in authModeValArr)
	{
		authModeArr.push([authModeValArr[key],key]);
	}

	var DefaultValue = authModeArr[0];
	createWlanDropdown("wlAuthMode", DefaultValue, "220px", authModeArr, "authModeSelValue(this);");
}

function SetImgValue(Buttonid, ButtonValue)
{
	var Btnelement = getElementById(Buttonid);
	if(null == Btnelement)
	{
		return;
	}

	if(1 == ButtonValue)
	{
		Btnelement.src="../../../images/checkon.gif";
		Btnelement.value = 1;
	}
	else
	{
		Btnelement.src="../../../images/checkoff.gif";
		Btnelement.value = 0;
	}	
}

function changeImg(element)
{
	if (element.src.match("checkon"))
	{
		element.src="../../../images/checkoff.gif";
		element.value = 0;
	}
	else
	{
		element.src="../../../images/checkon.gif";
		element.value = 1;
	}
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

function IsWpsConfig( )
{
	var AuthMode = authModeVal;
    var EncryMode;
	
    if (IsAuthModePsk(AuthMode))
    {
		if (AuthMode == 'wpa-psk')
        {
            EncryMode = WlanInfoArray[0].WPAEncryptionModes;
        }
        else if (AuthMode == 'wpa2-psk')
        {
            EncryMode = WlanInfoArray[0].IEEE11iEncryptionModes;
        }
        else
        {
            EncryMode = WlanInfoArray[0].X_HW_WPAand11iEncryptionModes;
        }
		
        if (((Wps2 == 1) && (EncryMode == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }
		
		if (((Wps2 == 1) && (AuthMode == 'wpa')) || (WpsCapa == 0))
        {
        	return false;
        }

        if(0 == wps1Cap2G)
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

function wlHideChange(a)
{
	changeImg(a);
	var WpsEnable = wpsPinNum2G.Enable;
	if ('5G' == freVal)
	{
		WpsEnable = wpsPinNum5G.Enable;
	}

	if((1 == WpsEnable) && (0 == getValue('wlHide')) && (true == IsWpsConfig()))
	{
		AlertEx(IT_VDF_wlan_basic_language['amp_bcastssid_off_help']);
		changeImg(a);
	}
}

function EnableSubmit(a)
{
	changeImg(a);
	var Form = new webSubmitForm();
    var enable = getValue('wlEnbl');
    
    setDisable('applyButton', enable);
    setDisable('cancelButton', enable);
	
	Form.addParameter('x.X_HW_WlanEnable',enable);
    Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1'
                                + '&RequestFile=html/amp/wlanbasic/itvdfWlanBasic.asp');
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function wlanSetSelect(id, val)
{
	setSelect(id, val);
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

function displaywepkey()
{   
	var band = freVal;
    var ssidIdx = 0;
	if('5G' == band)
	{
		ssidIdx = 1;
	}
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

function beaconTypeChange(band)
{
	setDisplay('wpakeyInfo', 0);			
    setDisplay('wepkeyInfo', 0);
	var pskKeyIndex = 0;
	if('5g' == band)
	{
		pskKeyIndex = 1;
	}
	
	var wlaninfo = WlanInfoArray[0];
	var authMode = wlaninfo.BeaconType;

    if (authMode == 'Basic')
    {
        var BasicAuthenticationMode = wlaninfo.BasicAuthenticationMode;
        var BasicEncryptionModes = wlaninfo.BasicEncryptionModes;
        if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem'))
        {
            if (BasicEncryptionModes == 'None')
            {
				setDropdownSelVal('wlAuthMode', authModeValArr['off']);
				authModeVal = 'off';
                setDisplay('wepkeyInfo', 0);
				setDisplay('wpakeyInfo', 0);
            } 
            else
            {
				setDropdownSelVal('wlAuthMode', authModeValArr['wep']);
				authModeVal = 'wep';
                var level = getEncryLevel(wlaninfo.EncypBit);
                setDisplay('wepkeyInfo', 1);
				setDisplay('wpakeyInfo', 0);
                wlanSetSelect('wlKeyBit', parseInt(level)+24);
                wlanSetSelect('wlKeyIndex',wlaninfo.KeyIndex);
                displaywepkey();
            }
        }
        else
        {
            var level = getEncryLevel(wlaninfo.EncypBit);
            setDisplay('wepkeyInfo', 1);
			setDisplay('wpakeyInfo', 0);
			setDropdownSelVal('wlAuthMode', authModeValArr['wep']);
			authModeVal = 'wep';
            wlanSetSelect('wlKeyBit', parseInt(level)+24);
            wlanSetSelect('wlKeyIndex',wlaninfo.KeyIndex);
            displaywepkey();
        }
    }
    else if (authMode == 'WPA')
    {
		setDisplay('wepkeyInfo', 0);
		setDisplay('wpakeyInfo', 1);
		setDropdownSelVal('wlAuthMode', authModeValArr['wpa-psk']);
		authModeVal = 'wpa-psk';
		setText('wlWpaPsk',wpaPskKey[pskKeyIndex].value); 
		wpapskpassword = wpaPskKey[pskKeyIndex].value; 
		setText('twlWpaPsk',wpaPskKey[pskKeyIndex].value);
    }
    else if ((authMode == '11i') || (authMode == 'WPA2') )
    {
		setDisplay('wepkeyInfo', 0);
		setDisplay('wpakeyInfo', 1);
		setDropdownSelVal('wlAuthMode', authModeValArr['wpa2-psk']);
		authModeVal = 'wpa2-psk';
		setText('wlWpaPsk',wpaPskKey[pskKeyIndex].value); 
		wpapskpassword = wpaPskKey[pskKeyIndex].value; 
		setText('twlWpaPsk',wpaPskKey[pskKeyIndex].value);
    }
    else if ((authMode == 'WPAand11i')|| (authMode == 'WPA/WPA2'))
    {
		setDisplay('wepkeyInfo', 0);
		setDisplay('wpakeyInfo', 1);
		setDropdownSelVal('wlAuthMode', authModeValArr['wpa/wpa2-psk']);
		authModeVal = 'wpa/wpa2-psk';
		setText('wlWpaPsk',wpaPskKey[pskKeyIndex].value); 
		wpapskpassword = wpaPskKey[pskKeyIndex].value; 
		setText('twlWpaPsk',wpaPskKey[pskKeyIndex].value);

    }
    else
    {   
		setDisplay('wepkeyInfo', 0);
		setDisplay('wpakeyInfo', 0);
		setDropdownSelVal('wlAuthMode', authModeValArr['off']);
		authModeVal = 'off';
    }
}
	
function authModeChange()
{
	setDisplay('wpakeyInfo', 0);			
    setDisplay('wepkeyInfo', 0); 
	var authMode = authModeVal;	
	var band = freVal;
	var ssidIdx = 0;
	if('5G' == band)
	{
		ssidIdx = 1;
	}
	var wlaninfo = WlanInfoArray[0];
    switch (authMode)
    {
        case 'off':                  
			setDisplay('wepkeyInfo', 0);
			setDisplay('wpakeyInfo', 0);
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
            break;
          
        case 'wep':
            var level = getEncryLevel(wlaninfo.EncypBit);
            var mode = wlaninfo.mode;
            
            if ((mode == "11n") || (mode == "11ac") || (mode == "11aconly"))
            {                  
                  setDisplay('wepkeyInfo', 0); 
				  setDisplay('wpakeyInfo', 0);				  
            }
            else
            {                  
                setDisplay('wepkeyInfo', 1);
				setDisplay('wpakeyInfo', 0);
				wlanSetSelect('wlKeyBit', parseInt(level)+24);
				wlanSetSelect('wlKeyIndex', wlaninfo.KeyIndex);
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

        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
            setDisplay('wepkeyInfo', 0);
			setDisplay('wpakeyInfo', 1);
			setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
			wpapskpassword = wpaPskKey[ssidIdx].value; 
			setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            break;
	
        default:
            break;
    }
	
}

function wlKeyBitChange()
{
	
}

function SelFrenChange()
{
	var BandFreq = freVal;
	var tdSsidTitle = getElementById('ssidTitle');
	var spanWifiTitle = getElementById('SpanWifiTitle');
	
	if('2.4G' == BandFreq)
	{
		spanWifiTitle.innerText = '';
		spanWifiTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_main'] + ' ('  + IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_2G'] + ')';
		tdSsidTitle.innerText = '';
		tdSsidTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix'];
	}
	else if ('5G' == BandFreq)
	{
		spanWifiTitle.innerText = '';
		spanWifiTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_main'] + ' ('  + IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_5G'] + ')';
		tdSsidTitle.innerText = '';
		tdSsidTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix_5G'];
	}
	else
	{
		spanWifiTitle.innerText = '';
		spanWifiTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_main'];
		tdSsidTitle.innerText = '';
		tdSsidTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix'];
	}
}

function keyIndexChange(iSelect)
{
	var keyIndex;
    
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

function setSSIDText(frenquency)
{
	var ssidName = WlanInfoArray[0].ssid;
	if ("5G" == frenquency)
	{
		if (ssidName.indexOf(IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix_5G']) != -1) 
		{
			ssidName = ssidName.substring(14);
		}
	}
	else 
	{
		if (ssidName.indexOf(IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix']) != -1)
		{
			ssidName = ssidName.substring(9);
		}
	}
	
	setText('wlSsid', ssidName);
}

function InitWifiInfo()
{
	var band = 0;
	if (1 == WlanInfo2G.enable && 0 == WlanInfo5G.enable)
	{
		band = '2g';
	}
	else if (0 == WlanInfo2G.enable && 1 == WlanInfo5G.enable)
	{
		band = '5g';
	}
	else if (1 == WlanInfo2G.enable && 1 == WlanInfo5G.enable)
	{
		band = '25g';
	}
	
	var wlaninfo = WlanInfoArray[0];
	var tdSsidTitle = getElementById('ssidTitle');
	var spanWifiTitle = getElementById('SpanWifiTitle');
	var frenquency;
	if ('2g' == band)
	{
		spanWifiTitle.innerText = '';
		spanWifiTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_main'] + ' (' + IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_2G'] + ')';
		tdSsidTitle.innerText = '';
		tdSsidTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix'];
		frenquency = '2.4G';
	}
	else if ('5g' == band)
	{
		spanWifiTitle.innerText = '';
		spanWifiTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_main'] + ' (' + IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_5G'] + ')';
		tdSsidTitle.innerText = '';
		tdSsidTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix_5G'];
		frenquency = '5G';
	}
	else if ('25g' == band)
	{
		spanWifiTitle.innerText = '';
		spanWifiTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_main'];
		tdSsidTitle.innerText = '';
		tdSsidTitle.innerText = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix'];
		frenquency = 'both';
	}
	
	setSSIDText(frenquency);
	SetImgValue('wlHide', wlaninfo.wlHide);
	
	setDropdownSelVal('SelFrenquency', freValArr[frenquency]);
	freVal = frenquency;
	
	BindPsdModifyEvent();
	
	beaconTypeChange(band); 
}

function getWlanPortNumber(name)
{
    var length = name.length;
    var number;
    var str = parseInt(name.charAt(length-1));
    return str;
}

function ComposeSsidName(name)
{
	var BandFreq = freVal;
	var ssidName = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix'] + name;
	if("5G" == BandFreq)
	{
		ssidName = IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix_5G'] + name;
	}
	
	return ssidName;
}

function getinstbyath(name)
{
	for(loop=0;loop < WlanInfo.length-1;loop++)
	{
		if(WlanInfo[loop].name == name)
		{
			return getInstIdByDomain(WlanInfo[loop].domain);
		}
	}
	return -1;
}

function CheckExistSsid(wlanInfoArray, idIndex)
{
	var BandFreq = freVal;
	for (i = 0; i < wlanInfoArray.length; i++)
	{
		if (idIndex != 0)
		{
			if (getWlanInstFromDomain(wlanInfoArray[i].domain) == idIndex)
			{
				continue;
			}
		}
		else 
		{
			if (getWlanInstFromDomain(wlanInfoArray[i].domain) == ssidIndex2G || getWlanInstFromDomain(wlanInfoArray[i].domain) == ssidIndex5G)
			{
				continue;
			}
		}
		
		if (wlanInfoArray[i].ssid == ssid)
		{
			AlertEx(IT_VDF_wlan_basic_language['amp_ssid_exist']);
			return false;
		}	
	}

	return true;
}

function AddParaSsid(Form, ssidIndex)
{   
    var HideVal = getValue('wlHide');
	Form.addParameter('x' + ssidIndex + '.SSIDAdvertisementEnabled',HideVal);
	
    var ssid = getValue('wlSsid');
	ssid = ComposeSsidName(ssid);
    ssid = ltrim(ssid);
    if (ssid == '')
    {
        AlertEx(IT_VDF_wlan_basic_language['amp_empty_ssid']);
        return false;
    }
    if (ssid.length > 32)
    {
	
        AlertEx(IT_VDF_wlan_basic_language['amp_ssid_check1'] + ssid + IT_VDF_wlan_basic_language['amp_ssid_too_long']);
        return false;
    }

	if (isValidAscii(ssid) != '')
	{
		AlertEx(IT_VDF_wlan_basic_language['amp_ssid_check1'] + ssid + IT_VDF_wlan_basic_language['amp_ssid_invalid'] + isValidAscii(ssid));
		return false;
	}

	var BandFreq = freVal;
	var wlanInfoArray;
	var idIndex = 0;
	if("2.4G" == BandFreq)
	{
		wlanInfoArray = WlanInfoArray2G;
		idIndex = ssidIndex2G;
	}
	else if ("5G" == BandFreq) 
	{
		wlanInfoArray = WlanInfoArray5G;
		idIndex = ssidIndex5G;
	}
	else
	{
		wlanInfoArray = WlanInfo;
	}
	
	if (false == CheckExistSsid(wlanInfoArray,idIndex))
	{
		return false;
	}
  
    Form.addParameter('x' + ssidIndex +'.SSID',ssid);
	return true;
}


function AddParaAuthAndPwd(Form, ssidIndex)
{
	var AuthMode = authModeVal;	
	if(AuthMode == 'off')
	{
		Form.addParameter('x' + ssidIndex + '.BeaconType','Basic');
		Form.addParameter('x' + ssidIndex + '.BasicAuthenticationMode','None');
		Form.addParameter('x' + ssidIndex + '.BasicEncryptionModes','None');
	}
	else if(AuthMode == 'wep')
	{
		var KeyBit = getSelectVal('wlKeyBit');
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
		var vKey = 0;

		var keyIndex = getSelectVal('wlKeyIndex');
		for (vKey = 0; vKey < 4; vKey++)
		{
		   if (vKey == 0)
		   {
			   val = wlKeys1;
		   }
		   else if (vKey == 1)
		   {
			   val = wlKeys2;
		   }
		   else if (vKey == 2)
		   {
			   val = wlKeys3;
		   }
		   else
		   {
			   val = wlKeys4;
		   }

		   if ( val != '' && val != null)
		   { 
			   if ( KeyBit == '128' )
			   {
				   if (isValidKey(val, 13) == false )
				   {
					   AlertEx(IT_VDF_wlan_basic_language['amp_key_check1'] + val + IT_VDF_wlan_basic_language['amp_key_invalid1']);
					   return false;
				   }
			   }
			   else
			   {
				   if (isValidKey(val, 5) == false )
				   {
					   AlertEx(IT_VDF_wlan_basic_language['amp_key_check1'] + val + IT_VDF_wlan_basic_language['amp_key_invalid2']);
					   return false;
				   }
			   }
		   }
		   else
		   {
			   AlertEx(IT_VDF_wlan_basic_language['amp_key_invalid3']);
			   return false;
		   }
		}
		Form.addParameter('x' + ssidIndex + '.BeaconType','Basic');
		Form.addParameter('x' + ssidIndex + '.BasicEncryptionModes','WEPEncryption');
		Form.addParameter('x' + ssidIndex + '.BasicAuthenticationMode','SharedAuthentication');
		Form.addParameter('x' + ssidIndex + '.WEPEncryptionLevel',(KeyBit-24)+'-bit');
		Form.addParameter('x' + ssidIndex + '.WEPKeyIndex', keyIndex);
		
		if (wifiPasswordMask == '1')
		{
			if (KeyBit == '128')
			{
				if ( (wlKeys1 != "*************") || (wep1PsdModFlag == true) )
				{
					
					Form.addParameter('y1' + ssidIndex + '.WEPKey', wlKeys1);
				}

				if ( (wlKeys2 != "*************") || (wep2PsdModFlag == true) )
				{
					Form.addParameter('y2' + ssidIndex + '.WEPKey', wlKeys2);
				}

				if ( (wlKeys3 != "*************") || (wep3PsdModFlag == true) )
				{
					Form.addParameter('y3' + ssidIndex + '.WEPKey', wlKeys3);
				}

				if ( (wlKeys4 != "*************") || (wep4PsdModFlag == true) )
				{
					Form.addParameter('y4' + ssidIndex + '.WEPKey', wlKeys4);
				}
			}
			else
			{
				if ( (wlKeys1 != "*****") || (wep1PsdModFlag == true) )
				{
					Form.addParameter('y1' + ssidIndex + '.WEPKey', wlKeys1);
				}

				if ( (wlKeys2 != "*****") || (wep2PsdModFlag == true) )
				{
					Form.addParameter('y2' + ssidIndex + '.WEPKey', wlKeys2);
				}

				if ( (wlKeys3 != "*****") || (wep3PsdModFlag == true) )
				{
					Form.addParameter('y3' + ssidIndex + '.WEPKey', wlKeys3);
				}

				if ( (wlKeys4 != "*****") || (wep4PsdModFlag == true) )
				{
					Form.addParameter('y4' + ssidIndex + '.WEPKey', wlKeys4);
				}
			} 
		}
		else
		{
			Form.addParameter('y1' + ssidIndex + '.WEPKey', wlKeys1);
			Form.addParameter('y2' + ssidIndex + '.WEPKey', wlKeys2);
			Form.addParameter('y3' + ssidIndex + '.WEPKey', wlKeys3);
			Form.addParameter('y4' + ssidIndex + '.WEPKey', wlKeys4);
		}
	}
	else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        var value = getValue('wlWpaPsk');
		if ((isFireFox4 == 1) && (value == ''))
		{
			value = wpapskpassword;
		}
		
        if (value == '')
        {
            AlertEx(IT_VDF_wlan_basic_language['amp_empty_para']);
            return false;
        }
		 if (isValidWPAPskKey(value) == false)
		{
			AlertEx(IT_VDF_wlan_basic_language['amp_wpskey_invalid']);
			return false;
		}
		
		if (wifiPasswordMask == '1')
		{
			if ( (value != "********") || (pskPsdModFlag == true) )
			{
				Form.addParameter('z' + ssidIndex + '.PreSharedKey',value);
			}			 
		}
		else
		{
			Form.addParameter('z' + ssidIndex + '.PreSharedKey',value);
		}
		
		if(AuthMode == 'wpa-psk')
		{
			Form.addParameter('x' + ssidIndex + '.BeaconType','WPA');
			Form.addParameter('x' + ssidIndex + '.WPAAuthenticationMode','PSKAuthentication');   
		}
		else if(AuthMode == 'wpa2-psk')
		{
			Form.addParameter('x' + ssidIndex + '.BeaconType','11i');
			Form.addParameter('x' + ssidIndex + '.IEEE11iAuthenticationMode','PSKAuthentication');
		}
		else if(AuthMode == 'wpa/wpa2-psk')
		{
			Form.addParameter('x' + ssidIndex + '.BeaconType','WPAand11i');
			Form.addParameter('x' + ssidIndex + '.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
		}
	}
	return true;
}

function AddParaWlanEnable(Form, ssidIndex, enable)
{
	Form.addParameter('x' + ssidIndex + '.Enable', enable);
}

function FormSetAction(Form)
{
	var AuthMode = authModeVal;
	if(AuthMode == 'off')
	{
		Form.setAction('set.cgi?'
				+ 'x'+ ssidIndex2G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G
				+ '&x'+ ssidIndex5G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G
				+ '&RequestFile=html/amp/wlanbasic/itvdfWlanBasic.asp');
	}
	else if(AuthMode == 'wep')
	{
		Form.setAction('set.cgi?'
				+ 'x'+ ssidIndex2G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G
				+ '&y1' + ssidIndex2G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G + '.WEPKey.1'
				+ '&y2' + ssidIndex2G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G + '.WEPKey.2'
				+ '&y3' + ssidIndex2G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G + '.WEPKey.3'
				+ '&y4' + ssidIndex2G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G + '.WEPKey.4'
				+ '&x'+ ssidIndex5G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G
				+ '&y1' + ssidIndex5G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G + '.WEPKey.1'
				+ '&y2' + ssidIndex5G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G + '.WEPKey.2'
				+ '&y3' + ssidIndex5G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G + '.WEPKey.3'
				+ '&y4' + ssidIndex5G+ '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G + '.WEPKey.4'
				+ '&RequestFile=html/amp/wlanbasic/itvdfWlanBasic.asp');
	}
	else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk') 
	{
		Form.setAction('set.cgi?'
				+ 'x'+ ssidIndex2G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G
				+ '&z'+ ssidIndex2G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex2G + '.PreSharedKey.1'
				+ '&x'+ ssidIndex5G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G
				+ '&z'+ ssidIndex5G + '=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + ssidIndex5G + '.PreSharedKey.1'
				+ '&RequestFile=html/amp/wlanbasic/itvdfWlanBasic.asp');
	}
}

function AddParameter1(Form, ssidIndex)
{
		if(false == AddParaSsid(Form, ssidIndex))
		{  
			return false;
		}
		if(false == AddParaAuthAndPwd(Form, ssidIndex))
		{  
			return false;
		}
		AddParaWlanEnable(Form, ssidIndex, 1);
		return true;
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
	var Form = new webSubmitForm();
	var BandFreq = freVal;
	if("2.4G" == BandFreq)
	{
		if(false == AddParameter1(Form, ssidIndex2G))
		{
			setDisable('btnApplySubmit',0);
			setDisable('cancel',0);    
			return;
		}
		AddParaWlanEnable(Form, ssidIndex5G, 0);
		FormSetAction(Form);
	}
	else if("5G" == BandFreq)
	{
		if(false == AddParameter1(Form, ssidIndex5G))
		{
			setDisable('btnApplySubmit',0);
			setDisable('cancel',0);    
			return;
		}
		AddParaWlanEnable(Form, ssidIndex2G, 0);
		FormSetAction(Form);
	}
	else if("both" == BandFreq)
	{
		if(false == AddParameter1(Form, ssidIndex2G))
		{
			setDisable('btnApplySubmit',0);
			setDisable('cancel',0);    
			return;
		}
		if(false == AddParameter1(Form, ssidIndex5G))
		{
			setDisable('btnApplySubmit',0);
			setDisable('cancel',0);    
			return;
		}
		FormSetAction(Form);
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
	setDisable('btnApplySubmit', 1);
}

function LoadBtnBindText()
{
    var all = document.getElementsByTagName("input");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (IT_VDF_wlan_basic_language[b.getAttribute("BindText")]) 
        {
            b.value = IT_VDF_wlan_basic_language[b.getAttribute("BindText")];
        }
    }
}

function cancelValue()
{
	InitWifiInfo();
}

function LoadFrame()	
{
	LoadBtnBindText();
	setDisplay('keyInfo', 1);
	SetImgValue('wlEnbl', enbl);
	setDisplay('wlanBasicCfg', enbl);
	setDisplay('SSIDProtectionChange', enbl);
	setDisplay('DivApply', enbl);
	InitWifiInfo();
	setDisplay('content', 1);
}

function ShowOrHideText(checkBoxId, passwordId, textId, value)
{
    if (1 == getCheckVal(checkBoxId))
    {
        setDisplay(passwordId, 0);
        setDisplay(textId, 1);
    }
    else
    {
        setDisplay(passwordId, 1);
        setDisplay(textId, 0);
    }
}

</script>

<style type="text/css">
.h3-content {
  padding-bottom: inherit;
}

.btn-apply-color {
	background-color: #b141ad !important;
}

.row .left{
  float: none;
}

.img_btn img{
width:60px;
height:30px;
}

.light-font{
	font-weight: 400;
}

[type="checkbox"]:not(:checked),
[type="checkbox"]:checked {
  left: -9999px;
  position: absolute;
}
</style>

</head>
<body class="mainbody" onLoad="LoadFrame();">
	<div>
		<div id="content" class="content-general" style="display:none">
			<h1>
				<span class="language-string">
					<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_settings"]);</script>
				</span>
			</h1>
			<h2>
				<span class="language-string">
					<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_subtitle"]);</script>
				</span>
			</h2>
	
			<div class="h3-content">
				<div class="row">
					<div class="left"><script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_network"]);</script>
					</div>
					<div class="right img_btn">
						<img id="wlEnbl" onclick="EnableSubmit(this)"/>
					</div>
				</div>
			</div>	
	
			<div id="wlanBasicCfg" class="wifiOnOff">
				<h3>
					<span class="language-string">
						<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_Setup"]);</script>
					</span>	
				</h3>
				<div class="h3-wrapper-content">
					<div class="h3-inside-content width50 paddingRight15">
						<div class="h3-content" style="margin-left: 0px">
							<div id="name-wifi" class="row">
								<div class="split-ssid-off" id="wifi-mixed">
									<div class="left">
										<span id='SpanWifiTitle' class="language-string">
											<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_main"]);</script>
										</span>                                
									</div>
								</div>
							</div>		
							
                            <div class = "h3-content" style="margin-left: 0px">
							  <div class = "row light-font" >
								<div class="left line "><script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_ssid"]);</script>
								</div>			
								<div class="right line light-font">
								  <div id="ssidTitle"><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_wifi_ssid_prefix']);</script></div>
								  <input id="wlSsid" class="ssid-textfield" value="Mustermann Family" type="text" style="width:220px !important">
								</div>
							  </div>
                            </div>
							
							<div class="h3-content" style="margin-left: 0px">
								<div class="row light-font">
									<div class="left line"><script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_broadcast"]);</script>
									</div>
									<div class="right line img_btn">								
										<img id='wlHide' onclick="wlHideChange(this)"/>
									</div>
								</div>
							</div>	
							                              
							<div class="h3-content" style="margin-left: 0px">
                                <div class="row light-font">
                                    <div class="left line">
                                        <span class="language-string">
											<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_frequency"]);</script>
										</span>                                            
									</div>
                                    <div class="right line" style="width:550px; position: relative; height:50px;">
										<div class="iframeDropLog">
										<div id="SelFrenquency" class="IframeDropdown" style="left: 59%;top: 5px; z-index: 99;">
											<script>
												setFrenquencySel();
											</script>
										</div>
										</div>
									</div>
                                </div>
                            </div>
											
                            <div class="h3-content" style="margin-left: 0px">
                                <div class="row light-font">
                                    <div class="left line">
                                        <span class="language-string">
											<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_protection_mode"]);</script>
										</span>                                            
									</div>
                                    <div class="right line" style = "width:300px; position: relative; height:50px;">
										<div class="iframeDropLog">
                                        <div id="wlAuthMode" class="IframeDropdown" style="left: 26.5%;top: 5px; z-index: 9;">
                                            <script>
												setAuthModeSel();
											</script>
                                        </div>
										</div>
                                    </div>
                                </div>
                            </div>
		
							<div id = 'wepkeyInfo'>
								<div class="h3-content">
									<div class="row light-font">
										<div class="left line">
											<span class="language-string">
												<script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_keylen']);</script>
											</span>
										</div>
										<div class="right line">
											<select id="wlKeyBit" onChange='wlKeyBitChange()'>
												<option value="128" selected><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_128key']);</script></option>
												<option value="64"><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_64key']);</script></option>
											</select>
										</div>
									</div>
								</div>
							
								<div class="h3-content">
									<div class="row light-font">
										<div class="left line">
											<span class="language-string">
												<script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_key_index']);</script>
											</span>                                            
										</div>
										<div class="right line">
											<select id="wlKeyIndex" size='1' onChange='keyIndexChange(0)'>
												<script language="JavaScript" type="text/javascript">
												for (var i = 1; i < 5 ; i++)
												{
													document.write("<option value=" + i + ">" + i + "</option>");
												}
												</script>
											</select>
										</div>
									</div>
								</div>
							 
								<div class = "h3-content">
									<div class = "row light-font">
										<div class="left line"><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_key1']);</script>
										</div>			
										<div class="right line">
											<script language="JavaScript" type="text/javascript">
												if (g_keys[0] != null)
												{
													document.write("<input type='password' autocomplete='off' id='wlKeys1' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>")
													document.write("<input type='text' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>");
												}
											</script>
										</div>
									</div>
								</div>
						 
								<div class = "h3-content">
									<div class = "row light-font">
										<div class="left line"><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_key2']);</script>
										</div>			
										<div class="right line">
											<script language="JavaScript" type="text/javascript">
												if(g_keys[1] != null)
												{
													document.write("<input type='password' autocomplete='off' id='wlKeys2' name='wlKeys2' size='20' maxlength=26 onchange=\"wep2password=getValue('wlKeys2');getElById('twlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1])+ "'>")
													document.write("<input type='text' id='twlKeys2' name='twlKeys2' size='20' maxlength=26  style='display:none'  onchange=\"wep2password=getValue('twlKeys2');getElById('wlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1]) + "'>");
												}
											</script>
										</div>
									</div>
								</div>
						 
								<div class = "h3-content">
									<div class = "row light-font">
										<div class="left line"><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_key3']);</script>
										</div>			
										<div class="right line">
											<script language="JavaScript" type="text/javascript">
												if(g_keys[2] != null)
												{
													document.write("<input type='password' autocomplete='off' id='wlKeys3' name='wlKeys3' size='20' maxlength=26 onchange=\"wep3password=getValue('wlKeys3');getElById('twlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>")
													document.write("<input type='text' id='twlKeys3' name='twlKeys3' size='20' maxlength=26  style='display:none' onchange=\"wep3password=getValue('twlKeys3');getElById('wlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>");
												}
											</script>
										</div>
									</div>
								</div>
						 
								<div class = "h3-content">
									<div class = "row light-font">
										<div class="left line"><script>document.write(IT_VDF_wlan_basic_language['amp_wlangeneral_encrypt_key4']);</script>
										</div>			
										<div class="right line">
											<script language="JavaScript" type="text/javascript">
												if(g_keys[3] != null)
												{
													document.write("<input type='password' autocomplete='off' id='wlKeys4' name='wlKeys4' size='20' maxlength=26 onchange=\"wep4password=getValue('wlKeys4');getElById('twlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>")
													document.write("<input type='text' id='twlKeys4' name='twlKeys4' size='20' maxlength=26  style='display:none' onchange=\"wep4password=getValue('twlKeys4');getElById('wlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>");
												}
											</script>
										</div>
									</div>
								</div>	
						 
								<div class = "h3-content">
									<div class = "row" style="text-align: right;">
										<div class="right light-font" >
											<span>
												<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_display"]);</script>
											</span>   
										</div >
										<div class="right" >
											<input class="checkbox checkbox-unchecked show-hide-pw" style="display:none" type="checkbox" id='displaywlKeys' value='on' onClick="ShowOrHideText('displaywlKeys', 'wlKeys1', 'twlKeys1', wep1password);ShowOrHideText('displaywlKeys', 'wlKeys2', 'twlKeys2', wep2password);ShowOrHideText('displaywlKeys', 'wlKeys3', 'twlKeys3', wep3password);ShowOrHideText('displaywlKeys', 'wlKeys4', 'twlKeys4', wep4password);">
											<label for="displaywlKeys"></label>
										</div>
									</div>
								</div>	
							</div>
						 
							<div id='wpakeyInfo'>   
								<div class="h3-content" style="margin-left: 0px">
									<div class="row light-font">
										<div class="left line">
											<span><script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_pwd"]);</script>
											</span>
										</div>
										<div class="right line" style="width: 301px;">
											<input type='password' autocomplete='off' id='wlWpaPsk' name='wlWpaPsk' size='20' maxlength='64' class="amp_font" style="width:220px !important" onchange="wpapskpassword=getValue('wlWpaPsk');getElById('twlWpaPsk').value=wpapskpassword;" />
											<input type='text' id='twlWpaPsk' name='twlWpaPsk' size='20' maxlength='64' class="amp_font" style='display:none; width:220px !important' onchange="wpapskpassword=getValue('twlWpaPsk');getElById('wlWpaPsk').value=wpapskpassword;"/>
										</div>    
									</div>
								</div>
							
								<div class="h3-content" style="margin-left: 0px">
									<div class = "row" style="text-align: right;">
										<div class="right" >
											<span>
												<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_display"]);</script>
											</span>   
										</div >
										<div class="right" >
											<input type="checkbox" id="displaypassword" value='on' onClick="ShowOrHideText('displaypassword', 'wlWpaPsk', 'twlWpaPsk');">
												<label for="displaypassword"></label>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
        
			<div id="SSIDProtectionChange" class="message info message-info">
				<span class="language-string">
					<script>document.write(IT_VDF_wlan_basic_language["amp_wlangeneral_wifi_sug"]);</script></span>       
			</div>
			
			<div id='DivApply' class="apply-cancel clearfix">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<input type="button" BindText="amp_btn_cancel" class="button button-cancel" id="cancel" onClick="cancelValue()">
				<input type="button" BindText="amp_btn_apply" class="button button-apply btn-apply-color" id="btnApplySubmit" onClick="ApplySubmit()">
			</div>

			<div style="display: none;" class="blackBackground">
				&nbsp;
			</div>
		</div>
	</div>
</body>
</html>
