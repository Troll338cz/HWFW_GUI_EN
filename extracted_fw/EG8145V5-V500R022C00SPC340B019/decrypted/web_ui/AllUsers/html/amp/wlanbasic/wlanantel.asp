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
<script language="javascript" src="../../ssmp/common/refreshTime.asp"></script>
<title>wireless basic configure</title>
<script language="JavaScript" type="text/javascript">
    
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var sptUserType ='1';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var wpapskpassword;
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var wlanpage;
if (location.href.indexOf("wlanantel.asp?") > 0) {
    wlanpage = location.href.split("?")[1]; 
    top.WlanBasicPage = wlanpage;
}
wlanpage = top.WlanBasicPage;
initWlanCap(wlanpage);

function GetLanguageDesc(Name)
{
    return cfg_wlancfgdetail_language[Name];
}

var CfgMode ='<%HW_WEB_GetCfgMode();%>';

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

function stPreSharedKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}


function stIndexMapping(index,portIndex)
{
    this.index = index;
    this.portIndex = portIndex;
}

var SsidNum = '<%HW_WEB_GetSsidNum();%>';
var SsidNum2g = SsidNum.split(',')[0];

var enbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';
var enbl2g = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.Radio.1.Enable);%>';
var enbl5g = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.Radio.2.Enable);%>';

var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort,stWlan);%>;

var wlanArrLen = WlanArr.length - 1;


for(i=0; i <wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}


var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;

var ssidIdx = -1;
var ssidAccessAttr = 'Subscriber';
var AddFlag = true;
var currentWlan = new stWlan();
var defaultWlan = new stWlan();


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
    var index = getWlanPortNumber(Wlan[i].name);
    var wlanInst = getWlanInstFromDomain(Wlan[i].domain);
    
    if (1 == isSsidForIsp(wlanInst))
    {
         continue;
    }
    else
    {
           WlanMap[j] = new stIndexMapping(i,index);
           j++;
    }
}

if (WlanMap.length >= 3)
{
    for (var i = 1; i < WlanMap.length-1; i++)
    {
        for( var j = 2; j < WlanMap.length; j++)
        {
            if (WlanMap[i].portIndex > WlanMap[j].portIndex)
            {
                var middle = WlanMap[i];
                WlanMap[i] = WlanMap[j];
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

function addwlgModeOption()
{
    var len = document.forms[0].wlgMode.options.length;    
    var wlgmode = getSelectVal('wlgMode');         
    
    for (i = 0; i < len; i++) {
        document.forms[0].wlgMode.remove(0);
    }

    if ("5G" == wlanpage) {
        document.forms[0].wlgMode[0] = new Option("802.11a", "11a");
        document.forms[0].wlgMode[1] = new Option("802.11a/n", "11na");
        document.forms[0].wlgMode[2] = new Option("802.11a/an/ac", "11ac");
        document.forms[0].wlgMode[3] = new Option("802.11a/n/ac/ax", "11ax");
    } else {
        document.forms[0].wlgMode[0] = new Option("802.11b", "11b");
        document.forms[0].wlgMode[1] = new Option("802.11b/g", "11bg");
        document.forms[0].wlgMode[2] = new Option("802.11b/g/n", "11bgn");
        document.forms[0].wlgMode[3] = new Option("802.11b/g/n/ax", "11ax");
    }
    setSelect('wlgMode',wlgmode);
}

function addAuthModeOption()
{
    var len = document.forms[0].wlAuthMode.options.length;    
    var authMode = getSelectVal('wlAuthMode'); 
    for (i = 0; i < len; i++)
    {
        document.forms[0].wlAuthMode.remove(0);
    }
    
    document.forms[0].wlAuthMode[0] = new Option(cfg_wlancfgdetail_language['amp_auth_wpapsk'], "wpa-psk");
    document.forms[0].wlAuthMode[1] = new Option(cfg_wlancfgdetail_language['amp_auth_wpa2psk'], "wpa2-psk");
    document.forms[0].wlAuthMode[2] = new Option(cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], "wpa/wpa2-psk");

    setSelect('wlAuthMode',authMode);
}
function addEncryMethodOption(type1,type2)
{
    var len = document.forms[0].wlEncryption.options.length;
    var mode = WlanWifi.mode;
    
    for (i = 0; i < len; i++)
    {
        document.forms[0].wlEncryption.remove(0);
    }
    
    document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
    document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
    document.forms[0].wlEncryption[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");

}



function authModeChange()
{   
    setDisplay("wlEncryMethod",0);
    setDisplay("wpaPreShareKey", 0);
    setDisable("wlEncryption",0);

    var authMode = getSelectVal('wlAuthMode');      
    
    switch (authMode)
    {

        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
            setDisplay('wlEncryMethod',1);
            addEncryMethodOption(1,0);
            setDisplay('wpaPreShareKey', 1);
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

            }
            else
            {
                setText('wlWpaPsk','');
                wpapskpassword = '';
                setText('twlWpaPsk','');
            }
            break;
       
        default:
            break;
    }
    
    addwlgModeOption();
} 

function beaconTypeChange(mode)
{
    setDisplay('wlEncryMethod',0);
    setDisplay('wpaPreShareKey', 0);

    if (mode == 'WPA')
    {
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wpaPreShareKey", 1);
            setSelect('wlAuthMode','wpa-psk');
            setSelect('wlEncryption',Wlan[ssidIdx].WPAEncryptionModes);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
            wpapskpassword = wpaPskKey[ssidIdx].value; 
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);

    }
    else if (mode == '11i')
    {

            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wpaPreShareKey", 1);
            setSelect('wlAuthMode','wpa2-psk');
            setSelect('wlEncryption',Wlan[ssidIdx].IEEE11iEncryptionModes);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
            wpapskpassword = wpaPskKey[ssidIdx].value; 
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            
    }
    else if (mode == 'WPAand11i')
    {
       
            setDisplay("wlEncryMethod",1);
            addEncryMethodOption(1,0);
            setDisplay("wpaPreShareKey", 1);
            setSelect('wlAuthMode','wpa/wpa2-psk');
            setSelect('wlEncryption',Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes);
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value); 
            wpapskpassword = wpaPskKey[ssidIdx].value; 
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);

    }
    else
    {   

    }
}

function wlKeyBitChange()
{
    
}

function onMethodChange(isSelected)
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

function addParameter1(Form)
{   
    Form.addParameter('y.Enable',getCheckVal('wlEnable'));
    var ssid;

    ssid = getValue('wlSsid1');
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

    for (i = 0; i < Wlan.length; i++) {
        if ((getWlanPortNumber(Wlan[i].name) > ssidEnd2G) && ((1 == DoubleFreqFlag) && ("2G" == wlanpage))) {
            continue;
        }
        
        if ((getWlanPortNumber(Wlan[i].name) <= ssidEnd2G) && ((1 == DoubleFreqFlag) && ("5G" == wlanpage))) {
            continue;
        }

        if ((getWlanPortNumber(Wlan[i].name) > ssidEnd2G) && ((1 != DoubleFreqFlag))) {
            continue;
        }

        if (ssidIdx != i) {
            if (Wlan[i].ssid == ssid) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
                return false;
            }
        }
    }

    Form.addParameter('y.SSID', ssid);
}


function addParameter2(Form)
{
    var url = '';
    var temp = '';

    var AuthMode = getSelectVal('wlAuthMode');

        var value = getValue('wlWpaPsk');
        if ((isFireFox4 == 1) &&  (value == ''))
		{
			value = wpapskpassword;
		}
		
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

        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('y.BeaconType','11i');
            Form.addParameter('y.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
        } 
        else
        {
            Form.addParameter('y.BeaconType','WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('y.X_HW_WPAand11iEncryptionModes',getSelectVal('wlEncryption'));
        } 
        
        Form.addParameter('k.PreSharedKey',value);


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

    Form.addParameter('w.SsidInst',wlanInstId);
    
    Form.addParameter('w.SSID', getValue('wlSsid1'));
    setCoverSsidNotifyFlag(Wlan[ssidIdx].ssid, getValue('wlSsid1'));
    
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
	
	Form.addParameter('w.WEPEncryptionLevel', Wlan[ssidIdx].EncypBit);
    Form.addParameter('w.WEPKeyIndex', Wlan[ssidIdx].KeyIndex);
    
    var AuthMode = getSelectVal('wlAuthMode');
    if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('w.BeaconType','WPA');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA');
            
            beaconType = "WPA";
            Form.addParameter('w.WPAAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.WPAEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAEncryptionModes, getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('w.BeaconType','11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, '11i');
            
            beaconType = "11i";
            Form.addParameter('w.IEEE11iAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iEncryptionModes, getSelectVal('wlEncryption'));
        } 
        else
        {
            Form.addParameter('w.BeaconType','WPAand11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPAand11i');

            
            beaconType = "WPAand11i";
            Form.addParameter('w.MixAuthenticationMode','PSKAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'PSKAuthentication');
            
            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
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
    }
    else
    {
        Form.addParameter('w.Key', key);
    }
    

    if ("Basic" != beaconType)
    {
        setCoverSsidNotifyFlag(wpaPskKey[ssidIdx].value, key);
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

function SubmitForm()
{
    var Form = new webSubmitForm();
	var busyflag = 0;
    if (addParameter1(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);    
        return;
    }
    
    if (addParameter2(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);        
        return;
    }
    
    if (addParameter3(Form) == false)
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
	var wificoverindex = getWlanInstFromDomain(wlandomain);

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

    if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        Form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlandomain
                    + '&k=' + wlandomain + '.PreSharedKey.1' 
                    + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');
    }
    else
    {
        Form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&x=InternetGatewayDevice.LANDevice.1'
                    + '&y=' + wlandomain
                    + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');
    }


    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}



function check11nAndWmm()
{
    if (WlanWifi.mode == '11n')
    {
        setDisable('enableWmm', 1);
    }
}

function LoadWlanEnable(enbl) {
    setCheck('wlEnbl', enbl);
    if ((enbl == 1) && (WlanArr[0] != null)) {
        ssidIdx = 0;
        selectLine('record_0');
        setDisplay('wlanCfg', 1);
        setDisplay('applytr', 1);
        var authMode = Wlan[ssidIdx].BeaconType;
        beaconTypeChange(authMode);
    } else if (enbl == 0) {
        setDisplay('wlanCfg', 0);
        setDisplay('applytr', 0);
    } else {
        setDisplay('ssidDetail', '0');
    }

}

function LoadFrame()
{   
    if (enbl == '')
    {
        setDisplay('wlanBasicCfg',0);
        setDisplay('applytr',0);
    }
    else
    {   
        setDisplay('wlanBasicCfg',1);

        check11nAndWmm();
        
        if (DoubleFreqFlag == 1) {
            if (wlanpage == '2G') {
                LoadWlanEnable(enbl2G & enbl);
            }

            if (wlanpage == '5G') {
                LoadWlanEnable(enbl5G & enbl);
            }
        } else {
            LoadWlanEnable(enbl);
        } 
    }
    
    document.getElementById('TdSSID').title = ssid;
    document.getElementById('TdAuth').title = authmode;
    document.getElementById('TdEncrypt').title = encryption;
	document.getElementById('wlWpaPsk').title = posswordComplexTitle; 
    document.getElementById('twlWpaPsk').title = posswordComplexTitle;


    if ('SPANISH' == curLanguage.toUpperCase())
    {
         document.getElementById('wlAuthMode').style.width = '220px';
         document.getElementById('wlEncryption').style.width = '220px';
    }
    
    if (WlanMap.length == 0)
    {
        setDisable("btnApplySubmit", 1);
        setDisable("cancel", 1);
        setDisplay('wlSsid2',0);
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
}

function ApplySubmit1()
{
    var Form = new webSubmitForm();   

    if (addParameter1(Form) == false)
    {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);    
        return;
    }
    Form.addParameter('y.X_HW_AssociateNum',16); 
    Form.addParameter('y.BeaconType','WPAand11i');
    Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
    Form.addParameter('y.X_HW_WPAand11iEncryptionModes','TKIPandAESEncryption');
    Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration' 
                   + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');
    
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
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
        setDisable('BtnAdd', 1);
        setDisable('BtnRemove', 1);
        setDisable('btnApplySubmit',1);
        setDisable('cancel',1);

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
    
    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
    
    if (1 == DoubleFreqFlag)
    {
        if ("2G" == wlanpage)
        {
            Form.addParameter('x.Enable',enable);
            if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node2G)
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/wlanantel.asp'); 
            }
            else
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');              
            }
        }
        else if ("5G" == wlanpage)
        {
            Form.addParameter('x.Enable',enable);
              if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node5G)
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');    
            }
            else
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');              
            }
        }
        else
        {
        
        }        
    }
    else
    {
        Form.addParameter('x.X_HW_WlanEnable',enable);
        Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1'
                                + '&RequestFile=html/amp/wlanbasic/wlanantel.asp');
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}
function showWlan(currentWlan)
{
    with (document.forms[0])
    {
        ShowSsidEnable(currentWlan);
            setText('wlSsid1',currentWlan.ssid);
            setDisable('wlSsid1',0);
            setDisplay('wlSsid2',0);
            setText('wlSsid2',"");
            SetStyleValue("wlSsid1", "width:123px");

        if (ssidAccessAttr.indexOf('Subscriber') < 0)
        {
                setDisable('wlSsid1',1);
        }

        beaconTypeChange(currentWlan.BeaconType);
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
			setLineHighLight(objTR);
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
            setLineHighLight(objTR);
			setDisable('btnApply',1);
			setDisable('btnCancel',1);
		}
	}
}

function loadssid(tableRow, maxssidband)
{
    setDisplay('cfg_table', 0);
    setDisplay('wifiCfg',0);
    setDisplay('applytr',0);
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

    if (-1 == idIndex)
    {
        if (SsidNum2g >= 4)
        {
            loadssid(tableRow, 4);
            return;
        }

        ssidIdx = -1;
        AddFlag = true;

        currentWlan = new stWlan('','','','',1,32,1,'','','','','','','','','','','','','','','');

        setDisplay('securityCfg',0);
        setDisplay('wifiCfg',0);
    }
    else
    {
        setDisplay('cfg_table', 1);
        setDisplay('securityCfg',1);
        setDisplay('wifiCfg',1);
        setDisplay('applytr',1);
        ssidIdx = parseInt(WlanMap[idIndex].index);
        AddFlag = false;
        currentWlan = Wlan[ssidIdx];
        
    }
    
    showWlan(currentWlan);


        setDisable('btnApplySubmit', 0);
        setDisable('cancel', 0);



    if ((idIndex != 0) && (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_NON_FIRST_SSID_FORBIDDON);%>'))
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
                    SubmitForm.addParameter(wlandomain, '');
                }
            }
        }
        else if (rml.checked == true)
        {
            wlandomain = rml.value;
            SubmitForm.addParameter(wlandomain, '');
        }        
    }
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

    var Form = new webSubmitForm();    
    addDeleteDomain(Form);
    Form.setAction('del.cgi?RequestFile=html/amp/wlanbasic/wlanantel.asp');
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function cancelValue()
{
    if (AddFlag == true)
    {
        var tableRow = getElement("wlanInst");
        selectLine('record_0');
        
        tableRow.deleteRow(tableRow.rows.length-1);
        CancelConfig()
    }
    else
    {
        var currentWlan = Wlan[ssidIdx];
        showWlan(currentWlan);
        CancelConfig()
    } 
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


var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|PossibleChannels|WMMEnable,stWlanWifi);%>;
var WlanWifi = null;
var WlanMap = new Array();
for (var i = 0; i < Wlan.length; i++) {
    var index = getWlanPortNumber(Wlan[i].name);
    var wlanInst = getWlanInstFromDomain(Wlan[i].domain);
    if ( ('' == Wlan[i].name) || ( (1 == DoubleFreqFlag) && ( ("5G" == wlanpage && index < 4) || ("2G" == wlanpage && index >= 4) ) ) ) {
        continue;
    } else {
        WlanMap.push(new stIndexMapping(i,index));
    }
}

if(WlanMap.length > 0) {
    WlanMap.sort(function(s1, s2) {
        return s1.portIndex - s2.portIndex;
    });
    ssidIdx = WlanMap[0].index;
    WlanWifi = WlanWifiArr[WlanMap[0].index];
}

if (null == WlanWifi)
{
    WlanWifi = new stWlanWifi("","","","","11n","","","","","","");
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


function gModeChange()
{
    var mode = getSelectVal('wlgMode');
    var channelWidthRestore = getSelectVal('channelWidth');
    var channel = getSelectVal('wlChannel');
    var country = 'US';
		
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

    if ((mode == "11b") || (mode == "11g") || (mode == "11bg") || (mode == "11a"))
    {    
        document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
    }
    else
    {
        if ((CfgMode.toUpperCase() == 'ANTEL') || (CfgMode.toUpperCase() == 'ANTEL2')) {
            if (wlanpage == "5G") {
                document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
                if (mode != "11na") {
                    document.forms[0].channelWidth[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
                    document.forms[0].channelWidth[4] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
                }
            } else {
                document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
            }
        }
        else
        {
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
        }
      
        if ((3 != channelWidthRestore) || (mode == "11ac"))
        {
            setSelect('channelWidth', channelWidthRestore);
        }
        else
        {
            setSelect('channelWidth', 0);
        }
    }

    var width = getValue('channelWidth');
    if (wlanpage == "5G") {
        loadChannelListByFreq('5G', country, mode, width);
    } else {
        loadChannelListByFreq('2G', country, mode, width);
    }
}

function ChangeCountry()
{
	gModeChange();
}

function ChannelChange()
{
}

function ChannelWidthChange()
{
    var len = document.forms[0].channelWidth.options.length;
    var chlWidth = getSelectVal('channelWidth');
    for (i = 0; i < len; i++) {
        document.forms[0].channelWidth.remove(0);
    }
    if (wlanpage == "5G") {
        document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
        document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
        document.forms[0].channelWidth[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
        document.forms[0].channelWidth[4] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
    } else {
        document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
        document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
    }
    ChangeCountry();
    setSelect('channelWidth',chlWidth);
}


function addChlWidthOption()
{
    var len = document.forms[0].channelWidth.options.length;
    var mode = getSelectVal('wlgMode');
    var chlWidth = getSelectVal('channelWidth');
    for (i = 0; i < len; i++) {
        document.forms[0].channelWidth.remove(0);
    }
    if ((mode == "11b") || (mode == "11g") || (mode == "11bg") || (mode == "11a")) {
        document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
    } else {
        if (wlanpage == "5G") {
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
                if (mode != "11na") {
                    document.forms[0].channelWidth[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
                    document.forms[0].channelWidth[4] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
                }
        } else {
            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].channelWidth[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            document.forms[0].channelWidth[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
        }
    }
    setSelect('channelWidth',chlWidth);
}



function loadByEnable(enbl) {

    if (enbl == 1) {
        if (WlanWifi == null ) {
            setDisplay('wifiCfg',0);
        } else {
            if (wlanpage == "5G") {
                loadChannelListByFreq('5G', WlanWifi.RegulatoryDomain,WlanWifi.mode,WlanWifi.channelWidth);
            } else {
                loadChannelListByFreq('2G', WlanWifi.RegulatoryDomain,WlanWifi.mode,WlanWifi.channelWidth);
            }
            setDisplay('adConfig',1);
            setDisplay('wifiCfg',1);
            setSelect('RegulatoryDomain',WlanWifi.RegulatoryDomain);
            setSelect('wlgMode',WlanWifi.mode);
            if (WlanWifi.AutoChannelEnable == 1) {
                setSelect('wlChannel',0);
            } else {
                setSelect('wlChannel',WlanWifi.channel);
            }
            setSelect('channelWidth',WlanWifi.channelWidth);
        }

        if ((WlanWifi.mode == "11b") || (WlanWifi.mode == "11bg")) {
            var len = document.forms[0].channelWidth.options.length;
            for (i = 0; i < len; i++) {
                document.forms[0].channelWidth.remove(0);
            }

            document.forms[0].channelWidth[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        }
    } else {
        setDisplay('wifiCfg',0);
        setDisplay('adConfig',0);
    }
}

function LoadFrameWifi() {
    setDisplay('BtnAdd', 0);
    setDisplay('BtnRemove', 0);

    if (DoubleFreqFlag == 1) {
        if (wlanpage == '2G') {
            loadByEnable(enbl2G & enbl);
        }

        if (wlanpage == '5G') {
            loadByEnable(enbl5G & enbl);
        }
    } else {
        loadByEnable(enbl);
    }

    addChlWidthOption();
    addAuthModeOption();
    addwlgModeOption();

}



function CancelConfig()
{  
	setSelect('channelWidth',WlanWifi.channelWidth);
    setSelect('wlgMode',WlanWifi.mode);
	gModeChange();

	setSelect('channelWidth',WlanWifi.channelWidth);
	ChannelWidthChange();
    
    if (WlanWifi.AutoChannelEnable == 1)
    {
        setSelect('wlChannel',0);
    }
    else
    {   
        setSelect('wlChannel',WlanWifi.channel);
    }
}

function addParameter3(Form)
{
    if (getSelectVal('wlChannel') == 0)
    {
        Form.addParameter('y.Channel',getSelectVal('wlChannel'));
        Form.addParameter('y.AutoChannelEnable',1); 
    }
    else
    {
        Form.addParameter('y.Channel',getSelectVal('wlChannel'));
        Form.addParameter('y.AutoChannelEnable',0);
    }

    Form.addParameter('y.X_HW_HT20',getSelectVal('channelWidth')); 
    Form.addParameter('y.X_HW_Standard',getSelectVal('wlgMode'));
    
    return true;
}

function CheckForm(type)
{
    if((getSelectVal('wlChannel') == "") || (getSelectVal('wlgMode') == "") || (getSelectVal('channelWidth') == ""))
    {
        AlertEx(cfg_wlancfgother_language['amp_basic_empty']);
        return false;
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
            + " <td class=\"width_per35\"><\/td>"
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
          <tr><td><script>document.write("2. " + cfg_wlancfgother_language['amp_wlan_note2']);</script></td></tr>
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
<div id='wlanswitch'>
<table cellspacing="0" cellpadding="0" width="100%" id="wlanOnOff">
  <tr>
    <td><input type='checkbox' name='wlEnbl' id='wlEnbl' onClick='EnableSubmit();' value="ON">
      <script>document.write(cfg_wlancfgother_language['amp_wlan_enable']);  </script></input></td>
  </tr>
</table>
  </div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="width_10px"></td></tr>
</table>

<div id='wlanCfg'>

<script language="JavaScript" type="text/javascript">
wlanWriteTabCfgHeader('Wireless',"100%");
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInst">
    <tr class="head_title">
        <td>&nbsp;</td>
          <td ><div class="align_left"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_id']);</script></div></td>
          <td ><div class="align_left"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_name']);</script></div></td>
          <td ><div class="align_left"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_link']);</script></div></td>
          <td ><div class="align_left"><script>document.write(cfg_wlancfgbasic_language['amp_security_cfg']);</script></div></td>
    </tr>
    <script language="JavaScript" type="text/javascript">
        for (var i = 0;i < WlanMap.length; i++)
        {   
            var mapIndex = parseInt(getIndexFromPort(WlanMap[i].portIndex));
            if(i%2 == 0)
            {
                document.write('<TR id="record_' + i + '" class="tabal_01" onclick="selectLine(this.id);">');
            }
            else
            {
                document.write('<TR id="record_' + i + '" class="tabal_02" onclick="selectLine(this.id);">');
            }
            if ((mapIndex == 0) || ((CfgMode.toUpperCase() == 'ANTEL2') && (i == 0))) {
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
wlanWriteTabTail();
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
            </table>
            <div id='securityCfg'>
            <div id='wlAuthModeDiv'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_auth_mode'></td>
                    <td class="table_right" id="TdAuth">
                        <select id='wlAuthMode' name='wlAuthMode' size="1" onChange='authModeChange()' style = "width:180px">
                          <option value="wpa-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpapsk']);</script></option>
                          <option value="wpa2-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpa2psk']);</script></option>
                          <option value="wpa/wpa2-psk"><script>document.write(cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']);</script></option>
                        </select> <span class="gray"> </span></td>
                </tr>
            </table>
            </div>

            <div id='wlEncryMethod'>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_mode'></td>
                    <td class="table_right" id="TdEncrypt">
                    <select id = 'wlEncryption' name = 'wlEncryption'  size='1'  onChange='onMethodChange(0);' style = "width:180px">
                    </select>
                      </td>
                </tr>
            </table>
            </div>


    <div id='wpaPreShareKey'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr>
           <td class="table_title width_per25" id= "wpa_psk">
          <script>
          var authMode = getSelectVal('wlAuthMode'); 
          document.write(cfg_wlancfgdetail_language['amp_wpa_psk']);
          </script>
          </td>
          <td class="table_right">
            <input type='password' autocomplete='off' id='wlWpaPsk' name='wlWpaPsk' size='20' maxlength='64' class="amp_font"  onchange="wpapskpassword=getValue('wlWpaPsk');getElById('twlWpaPsk').value=wpapskpassword;" />
            <input type='text' id='twlWpaPsk' name='twlWpaPsk' size='20' maxlength='64' class="amp_font" style='display:none' onchange="wpapskpassword=getValue('twlWpaPsk');getElById('wlWpaPsk').value=wpapskpassword;"/>
            <input checked type="checkbox" id="hidewlWpaPsk" name="hidewlWpaPsk" value="on" onClick="ShowOrHideText('hidewlWpaPsk', 'wlWpaPsk', 'twlWpaPsk', wpapskpassword);"/>
            <script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script>
            <font class="color_red">*</font><span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_wpa_psknote']);</script></span></td>
        </tr>
      </table>
    </div>    
        </td> 
      </tr>
      </table>

    </div>
</div>

</div>

<div id='wifiCfg'>

                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                        
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
                                <select id='channelWidth' name='channelWidth' size="1" onChange="ChannelWidthChange()"  class="width_150px">
                                    <option value="0"><script>document.write(cfg_wlancfgadvance_language['amp_chlwidth_auto2040']);</script></option>
                                    <option value="1"><script>document.write(cfg_wlancfgadvance_language['amp_chlwidth_20']);</script></option>
                                    <option value="2"><script>document.write(cfg_wlancfgadvance_language['amp_chlwidth_40']);</script></option>
                                    <option value="3"><script>document.write(cfg_wlancfgadvance_language['amp_chlwidth_auto204080']);</script></option>
                                    <option value="4"><script>document.write(cfg_wlancfgadvance_language['amp_chlwidth_160']);</script></option>
                                </select>
                            </td>
                        </tr>
                        <tr id="div_gMode">
                            <td class="table_title width_per25" BindText='amp_channel_mode'></td>
                            <td class="table_right">
                                <select id="wlgMode" name="wlgMode" size="1" class="width_150px" onchange="gModeChange()">
                                    <option value="11b"> 802.11b</option>
                                    <option value="11g"> 802.11g</option>
                                    <option value="11n"> 802.11n</option>
                                    <option value="11bg"> 802.11b/g</option>
                                    <option value="11bgn" selected> 802.11b/g/n</option> 
                                    <option value="11a" selected> 802.11a</option>
                                    <option value="11na" selected> 802.11a/n</option>
                                    <option value="11ac" selected> 802.11a/an/ac</option>
                                    <option value="11ax" selected> 802.11b/g/n/ax</option>
                                    <option value="11ax" selected> 802.11a/n/ac/ax</option>
                                </select>
                            </td>
                        </tr>
                    </table>
</div>                    
        <table width="100%" border="0" cellpadding="0" cellspacing="0"  >

        <tr><td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
              <tr id='applytr'>
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
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="width_10px"></td></tr>
  </table> 
  

 
</form>
</td></tr>
</table>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
