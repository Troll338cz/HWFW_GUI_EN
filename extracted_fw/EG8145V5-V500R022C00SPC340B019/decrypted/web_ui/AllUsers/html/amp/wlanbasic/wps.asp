<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlanwps_language, cfg_wlancfgdetail_language, cfg_wlancfgother_language);%>"></script>
<script language="javascript" src="/html/amp/common/wlan_list.asp"></script>
<script language="javascript" src="./refreshTime.asp"></script>

<title>WPS</title>
<script language="JavaScript" >
// begin

var WPSPinChgF = '<%HW_WEB_GetWPSPinChgF();%>';
var WPSPinChgF2g = WPSPinChgF.split(',')[0];
var WPSPinChgF5g = WPSPinChgF.split(',')[4];

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

var ssidIdx = -1;

function stWpsPin(domain, X_HW_ConfigMethod, DevicePassword, X_HW_PinGenerator, Enable ,X_HW_APPinEnable)
{
    this.domain = domain;
    this.X_HW_ConfigMethod = X_HW_ConfigMethod;
    this.DevicePassword = DevicePassword;
    this.X_HW_PinGenerator = X_HW_PinGenerator;
    this.Enable = Enable;
	this.X_HW_APPinEnable = X_HW_APPinEnable;
}

function stWlan(domain,name,enable,ssid,wlHide,DeviceNum,wmmEnable,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                KeyIndex,EncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,WPARekey,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable, LowerLayers,
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
    this.LowerLayers = LowerLayers;
    this.X_HW_WAPIEncryptionModes = X_HW_WAPIEncryptionModes;
    this.X_HW_WAPIAuthenticationMode = X_HW_WAPIAuthenticationMode;
    this.X_HW_WAPIServer = X_HW_WAPIServer;
    this.X_HW_WAPIPort = X_HW_WAPIPort;
}
var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|LowerLayers|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort,stWlan);%>;

var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,X_HW_ConfigMethod|DevicePassword|X_HW_PinGenerator|Enable|X_HW_APPinEnable,stWpsPin,STATUS);%>;

var wlanArrLen = WlanArr.length - 1;

for (i=0; i < wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
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

function stLanDevice(domain, WlanCfg, Wps2)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
    this.Wps2 = Wps2;
}

var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable|X_HW_Wps2Enable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];

var enbl = LanDevice.WlanCfg;
var Wps2 = LanDevice.Wps2;
var WlanCus = '<%HW_WEB_GetWlanCus();%>';
var WpsCapa = WlanCus.split(',')[0];

var WPS20AuthSupported = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.WPS20AuthSupported.Enable);%>';
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

// end
var wpsSsidInst = 'NONE';
function stWpsConfig(wlcWpsEnable, wlcWpsMethod, wlcWpsPinGenerator, wlcWpsPinNumber,wlcWpsAPPinEnable)
{
	this.Enable = wlcWpsEnable;
	this.Method = wlcWpsMethod;
	this.Generator = wlcWpsPinGenerator;
	this.pin = wlcWpsPinNumber;
	this.APPinEnable = wlcWpsAPPinEnable;
}

function getWlcInstByDomainName(wpsDomainName)
{
	var wlcInstIndex = 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1'.length - 1;

	return wpsDomainName.charAt(wlcInstIndex);
}

var wpsConfigs = new Array(8);
function getWpsPath(wlcInst)
{
	if (!(0< wlcInst && wlcInst <= 8))
	{
		return 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + '1' + '.WPS';
	}
	return 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + wlcInst + '.WPS';
}
function LoadResource()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (cfg_wlanwps_language[b.getAttribute("BindText")]) 
        {
            b.innerHTML = cfg_wlanwps_language[b.getAttribute("BindText")];
        }
    }
}

function IsWpsConfigDisplay(wlcIndex)
{

    var beanconType = WlanArr[wlcIndex].BeaconType;
    var AuthMode;
    var EncryMode;

    if ('None' == beanconType || 'Basic' == beanconType)
    {
    	AuthMode = WlanArr[wlcIndex].BasicAuthenticationMode;
    	EncryMode = WlanArr[wlcIndex].BasicEncryptionModes;
    }

    if ('WPA' == beanconType)
    {
    	AuthMode = WlanArr[wlcIndex].WPAAuthenticationMode;
    	EncryMode = WlanArr[wlcIndex].WPAEncryptionModes;
    }
    if ('WPA2' == beanconType || '11i' == beanconType)
    {
    	AuthMode = WlanArr[wlcIndex].IEEE11iAuthenticationMode;
    	EncryMode = WlanArr[wlcIndex].IEEE11iEncryptionModes;
    }

    if ('WPAand11i' == beanconType || 'WPA/WPA2' == beanconType)
    {
    	AuthMode = WlanArr[wlcIndex].X_HW_WPAand11iAuthenticationMode;
    	EncryMode = WlanArr[wlcIndex].X_HW_WPAand11iEncryptionModes;
    }
	

    if ('PSKAuthentication' == AuthMode)
    {
        if (((Wps2 == 1) && (EncryMode == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }

        if (((Wps2 == 1) && (beanconType == 'WPA')) || (WpsCapa == 0))
        {
        	return false;
        }

        if(0 == wps1Cap)
        {
            if(('WPA2' == beanconType || '11i' == beanconType || 'WPAand11i' == beanconType || 'WPA/WPA2' == beanconType) && (EncryMode == 'AESEncryption' || EncryMode == 'TKIPandAESEncryption'))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        return true;
    }

    return false;
}

function wpsSsidChange()
{
	ssidIdx = getSelectVal('selectwpsssid');

	if ('NONE' == ssidIdx)
	{
		setCheck('wpsEnable', 0);
		disableWpsMethods(1);
	}
	else
	{
	    setCheck('wpsEnable', 1);
		disableWpsMethods(0);
    }
}
function EnableWps()
{

	if (0 == getCheckVal('wpsEnable'))
	{
		disableWpsMethods(1);
		setDisable('selectwpsssid', 1);
	}
	else
	{
		setDisable('selectwpsssid', 0);
	}   
}

function CheckWPSandSSIDHide(wlcLoop)
{
    var wlHide = 0;

    wlHide = WlanArr[wlcLoop].wlHide;
	  
	  
    if((0 == wlHide)&&(1 == getCheckVal('wpsEnable')))
	{      
             return false;
	}

    return true;
    
}


function EnablePbc()
{
    var pbcEnable = getCheckVal('pbcEnable');
    var wlcInst = 1;
    if (('PushButton' == wpsConfigs[wlcInst - 1].Method )&&( 1 == pbcEnable))
    {
		{
			setDisable('wpspbcpair', 0);
		}
    }
    else
	{
		   setDisable('wpspbcpair', 1);
	}

}

function EnableApPin()
{
	if (0 == getCheckVal('apPinEnable'))
	{
		setDisable('wpsappingenerate', 1);
	}
	else
	{
		setDisable('wpsappingenerate', 0);
	}
		
}

function RadioEnableByBand(band)
{
    if(0 == WlanEnable[0].enable)
    {
        return false;
    }
    if(band == "2G")
    {
        return enbl2G;
    }
    else if(band == "5G")
    {
        return enbl5G;
    }
    return false;
}

function GenerateApPin()
{
    var wpsEnable = getCheckVal('wpsEnable');
    var wpsApPinEnable = getCheckVal('apPinEnable');
    if ((wpsEnable == 0) || ('NONE' == ssidIdx) || (wpsApPinEnable == 0))
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wps_enable_note']);
        return;
    }

    var freq = "2G";
	var wlcInst = 1;

	if ('BOTH' != ssidIdx)
	{
		wlcInst = ssidIdx;
	}

	if (0 == isBand2G(wlcInst))
	{
		freq = "5G";
	}
    
	var appin = changeToPinNumber(computePinInteger(), 8);
	setText('wpsappin',appin);
	
	if (ValidateChecksum(parseInt(appin, 10)) != 0)
	{
	  AlertEx(cfg_wlancfgother_language['amp_clientpin_invalid']);
	  return false;
	}
    var Form = new webSubmitForm();

	Form.addParameter('z.X_HW_ConfigMethod','Lable');
	Form.addParameter('z.X_HW_PinGenerator','AP');
	Form.addParameter('z.DevicePassword',parseInt(appin, 10));
	Form.addParameter('z.X_HW_APPinEnable',1);
	if ('BOTH' == ssidIdx)
	{
		Form.setAction('set.cgi?z=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.WPS&RequestFile=html/amp/wlanbasic/wps.asp' );
	}
	else
	{
		Form.setAction('set.cgi?z=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + wlcInst + '.WPS&RequestFile=html/amp/wlanbasic/wps.asp' );
	}
 
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
    if(false == checkWpsCondition(freq))
    {
        return;
    }
    
    Form.submit();
    setDisable("wpsappingenerate", 1);
}

function PairStaPin()
{
    var wpsEnable = getCheckVal('wpsEnable');
    if ((wpsEnable == 0) || ('NONE' == ssidIdx))
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wps_enable_note']);
        return;
    }

    var freq = "2G";
	var wlcInst = 1;

	if ('BOTH' != ssidIdx)
	{
		wlcInst = ssidIdx;
	}

	if (0 == isBand2G(wlcInst))
	{
		freq = "5G";
	}

    var clientPinNum = getValue('wpsstapin');
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
	top.WlanSTAPIN = pinNum;
    var Form = new webSubmitForm();

	Form.addParameter('z.X_HW_ConfigMethod','Lable');
	Form.addParameter('z.X_HW_PinGenerator','STA');
	Form.addParameter('z.DevicePassword',parseInt(pinNum, 10));	
	
    Form.setAction('set.cgi?z=' + getWpsPath(ssidIdx) + '&RequestFile=html/amp/wlanbasic/wps.asp' );
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    if(false ==checkWpsCondition(freq))
    {
        return;
    }
    
    Form.submit();
	
}

function checkWpsCondition(freq)
{
	var wlcloop = 0;
	var wlcloop2_4g = 0;
	var wlcloop_5g = 0;
	
	for(var loop=0;loop < WlanArr.length-1;loop++)
	{
		var wlanIndex = getWlcInstByDomainName(WlanArr[loop].domain);
		if(wlanIndex == ssidIdx)
		{
			wlcloop = loop;
			break;
		}
	}

    var SsidEnable = WlanArr[wlcloop].enable;
    var enableSsid1 = 1;
    var enableSsid5 = 1;
    
    var enable2GRadio = 1;
    var enable5GRadio = 1;
    var enableRadio = 1;

    var enableHideSsid1 = 1;
    var enableHideSsid5 = 1;
    var enableHide = 1;

    if ('BOTH' == ssidIdx)
    {
        for(loop=0;loop < WlanArr.length-1;loop++)
		{
            if(WlanArr[loop].name == 'ath0')
            {
                enableSsid1 = WlanArr[loop].enable;
                enable2GRadio = RadioEnableByBand("2G");
                enableHideSsid1 = WlanArr[loop].wlHide;
				wlcloop2_4g = loop;
            }

            if(WlanArr[loop].name == 'ath4')
            {
                enableSsid5 = WlanArr[loop].enable;
                enable5GRadio = RadioEnableByBand("5G");
                enableHideSsid5 = WlanArr[loop].wlHide;
				wlcloop_5g = loop;
            }
		}
        
		SsidEnable = enableSsid1&enableSsid5;
		enableRadio = enable2GRadio&enable5GRadio;
		enableHide = enableHideSsid1&enableHideSsid5;
      
    }
	
	if (('BOTH' == ssidIdx) && ('BOTH' == freq))
	{
		if(false == CheckWPSandSSIDHide(wlcloop2_4g) || (0 == enableHide))
		{
			AlertEx(cfg_wlancfgother_language['amp_wps_on_help']);
			return false;
		}
		
		if(false == CheckWPSandSSIDHide(wlcloop_5g) || (0 == enableHide))
		{
			AlertEx(cfg_wlancfgother_language['amp_wps_on_help']);
			return false;
		}
		
		if(IsWpsConfigDisplay(wlcloop2_4g) == false)
		{
			AlertEx(cfg_wlanwps_language['amp_wlan_wps_config_not_support']);
			return false;
		}
	
		if(IsWpsConfigDisplay(wlcloop_5g) == false)
		{
			AlertEx(cfg_wlanwps_language['amp_wlan_wps_config_not_support']);
			return false;
		}
		
		if((0 == SsidEnable)|| (RadioEnableByBand("2G") == false) || (RadioEnableByBand("5G") == false) || (false == enableRadio))
		{
			AlertEx(cfg_wlanwps_language['amp_wlan_wps_config_not_support']);
			return false;
		} 
		return true;
	}
	
	if(false == CheckWPSandSSIDHide(wlcloop) || (0 == enableHide))
    {
        AlertEx(cfg_wlancfgother_language['amp_wps_on_help']);
        return false;
    }

    if(IsWpsConfigDisplay(wlcloop) == false)
    {
        AlertEx(cfg_wlanwps_language['amp_wlan_wps_config_not_support']);
        return false;
    }

    if((0 == SsidEnable)|| (RadioEnableByBand(freq) == false) ||(false == enableRadio))
    {
        AlertEx(cfg_wlanwps_language['amp_wlan_wps_config_not_support']);
        return false;
    }  

    return true;
    
}

function PairPbc()
{
    var wpsEnable = getCheckVal('wpsEnable');
    var wpsPbcEnable = getCheckVal('pbcEnable');
	var freq = "2G";
	var wlcInst = 1;
    if ((wpsEnable == 0) || ('NONE' == ssidIdx) || (wpsPbcEnable == 0))
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wps_enable_note']);
        return;
    }

	if ('BOTH' != ssidIdx)
	{
		wlcInst = ssidIdx;
	}

	if (0 == isBand2G(wlcInst))
	{
		freq = "5G";
	}
	if ('BOTH' == ssidIdx)
	{
		freq = 'BOTH';
	}
	
    if(false ==checkWpsCondition(freq))
    {
        return;
    }
    
    if (ConfirmEx(cfg_wlancfgdetail_language['amp_wps_start'])) 
    {
        var Form = new webSubmitForm();     
        Form.setAction('WpsPBC.cgi?freq=' + freq + '&RequestFile=html/amp/wlanbasic/wps.asp');
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

function closeWps(Form)
{
	var formAtion = "set.cgi?";
	for (var inst = 1; inst <= wpsConfigs.length; inst++)
	{
		if (null == wpsConfigs[inst - 1])
		{
			continue;
		}

		Form.addParameter("z" + inst+".Enable", 0);
		formAtion += "z" + inst + "=" + getWpsPath(inst) + "&";
	}

	formAtion += "RequestFile=html/amp/wlanbasic/wps.asp";
	Form.setAction(formAtion);

	return;
}

function isBand2G(wlcInst)
{
    var band2GLowlayer = "InternetGatewayDevice.LANDevice.1.WiFi.Radio.1";
	var wlcDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlcInst; 

	for (var loop = 0; loop < WlanArr.length - 1; loop++)
	{
		if (wlcDomain == WlanArr[loop].domain)
		{
		    if (band2GLowlayer == WlanArr[loop].LowerLayers)
	    	{
	    		return 1;
	    	}
		    break;
		}
	}

	return 0;
}
function addWpsMethodPara(Form, wlcInst)
{
    var pbcEnable= getCheckVal('pbcEnable');
    var apPinEnable= getCheckVal('apPinEnable');
    if (1 == pbcEnable)
    {
        Form.addParameter("z" + wlcInst +".X_HW_ConfigMethod", 'PushButton');
		Form.addParameter("z" + wlcInst +".X_HW_APPinEnable", apPinEnable);
        return;
    }
    
    if (1 == apPinEnable)
    {
        Form.addParameter("z" + wlcInst +".X_HW_ConfigMethod", 'Lable');
        Form.addParameter("z" + wlcInst +".X_HW_PinGenerator", 'AP');

		
        return;
    }
	
	Form.addParameter("z" + wlcInst +".X_HW_APPinEnable", apPinEnable);
	
	Form.addParameter("z" + wlcInst +".X_HW_ConfigMethod", 'Lable');
	Form.addParameter("z" + wlcInst +".X_HW_PinGenerator", 'STA');

    return;
}

function setPSKwarningSug()
{	
	var wpsappinwarning = getElementById('wpsappinwarning');
	wpsappinwarning.innerHTML = cfg_wlanwps_language['amp_wlan_wps_default_pin_warning'];
	wpsappinwarning.style.color = '#ff0000';
}

function getWlanPortNumber(name)
{
    var length = name.length;
    var number;
    var str = parseInt(name.charAt(length-1));
    return str;
}

function showPSKwarningSug(wlanInst)
{
    var ifindex = 0;
	setDisplay("wpsappinwarning",0);
	if((wlanInst == 'BOTH') || (wlanInst == 'NONE'))
	{
		if(0 == WPSPinChgF5g)
		{
			setDisplay("wpsappinwarning",1);
			setPSKwarningSug();
		}
	}
	else
	{
	    for (var wlcloop = 0; wlcloop < WlanArr.length - 1; wlcloop++)
		{	
			var wlcInst = getWlcInstByDomainName(WlanArr[wlcloop].domain);
			if(wlcInst == wlanInst)
			{
				ifindex = getWlanPortNumber(WlanArr[wlcloop].name);
				break;
			}
		}
		
		if(0 == WPSPinChgF.split(',')[ifindex])
		{
			setDisplay("wpsappinwarning",1);
			setPSKwarningSug();
		}
	}
}

function IsWpsSupport(wlcIndex)
{
    var beanconType = WlanArr[wlcIndex].BeaconType;
    var AuthMode;
    var EncryMode;
	var pskMode = 0;

	if ('None' == beanconType || 'Basic' == beanconType)
	{
		AuthMode = WlanArr[wlcIndex].BasicAuthenticationMode;
		EncryMode = WlanArr[wlcIndex].BasicEncryptionModes;
	}
	
	if ('WPA' == beanconType)
	{
		AuthMode = WlanArr[wlcIndex].WPAAuthenticationMode;
		EncryMode = WlanArr[wlcIndex].WPAEncryptionModes;
		pskMode = 1;
	}
	if ('WPA2' == beanconType || '11i' == beanconType)
	{
		AuthMode = WlanArr[wlcIndex].IEEE11iAuthenticationMode;
		EncryMode = WlanArr[wlcIndex].IEEE11iEncryptionModes;
		pskMode = 1;
	}
	
	if ('WPAand11i' == beanconType || 'WPA/WPA2' == beanconType)
	{
		AuthMode = WlanArr[wlcIndex].X_HW_WPAand11iAuthenticationMode;
		EncryMode = WlanArr[wlcIndex].X_HW_WPAand11iEncryptionModes;
		pskMode = 1;
	}
	
    if ('1' == WPS20AuthSupported && AuthMode == 'None')
    {
        return true;
    }

    if (1 == pskMode)
    {
        if (((Wps2 == 1) && (EncryMode == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }

        if (((Wps2 == 1) && (beanconType == 'WPA')) || (WpsCapa == 0))
        {
        	return false;
        }
		
		var FreqBand = '2G';
		if (0 == isBand2G(wlcIndex))
		{
			FreqBand = '5G';
		}
		initWlanCap(FreqBand);
		
        if(0 == wps1Cap)
        {
            if((('WPA2' == beanconType || '11i' == beanconType || 'WPAand11i' == beanconType || 'WPAandWAP2' == beanconType)) 
				&& (AuthMode == 'PSKAuthentication') && ((EncryMode == 'AESEncryption')||(EncryMode == 'TKIPandAESEncryption')))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        return true;
    }

    return false;
}

function enableBoth(Form)
{
	var formAtion = "set.cgi?";
	for (var inst = 1; inst <= wpsConfigs.length; inst++)
	{
		if (null == wpsConfigs[inst - 1])
		{
			continue;
		}

		if ((1 != inst) && (5 != inst))
		{
			Form.addParameter("z" + inst+".Enable", 0);
			formAtion += "z" + inst + "=" + getWpsPath(inst) + "&";
		}
		
	}

	for (var inst = 1; inst <= wpsConfigs.length; inst++)
	{
		if (null == wpsConfigs[inst - 1])
		{
			continue;
		}

		if ((1 == inst) || (5 == inst))
		{
                Form.addParameter("z" + inst+".Enable", 1);
                    addWpsMethodPara(Form, inst);
			formAtion += "z" + inst + "=" + getWpsPath(inst) + "&";
		}
	}

	formAtion += "RequestFile=html/amp/wlanbasic/wps.asp";
	Form.setAction(formAtion);

	return;
}

function enableOneSsid(Form)
{
	var formAtion = "set.cgi?";
	for (var inst = 1; inst <= wpsConfigs.length; inst++)
	{
		if (null == wpsConfigs[inst - 1])
		{
			continue;
		}

		if ((ssidIdx != inst))
		{
			Form.addParameter("z" + inst+".Enable", 0);
			formAtion += "z" + inst + "=" + getWpsPath(inst) + "&";
		}
		
	}

	for (var inst = 1; inst <= wpsConfigs.length; inst++)
	{
		if (null == wpsConfigs[inst - 1])
		{
			continue;
		}

		if ((ssidIdx == inst))
		{
			Form.addParameter("z" + inst+".Enable", 1);
                    addWpsMethodPara(Form, inst);
			formAtion += "z" + inst + "=" + getWpsPath(inst) + "&";
		}
	}

	formAtion += "RequestFile=html/amp/wlanbasic/wps.asp";
	Form.setAction(formAtion);

	return;
}

function IsBothSupportWps()
{   
    var wlanNum = WlanArr.length - 1;	
    for (var wlcloop = 0; wlcloop < wlanNum; wlcloop++)
    {
	    if(true == IsWpsSupport(wlcloop))
		{
		   continue;
		}
		else
		{
		   return false;
		}
		
	}	
	return true;
}

function WpsSubmit()
{
    var Form = new webSubmitForm();	
	if ((0 == getCheckVal('wpsEnable')) || ('NONE' == ssidIdx))
	{
		closeWps(Form);
	}
	else if ('BOTH' == ssidIdx)
	{   
        if(false == IsBothSupportWps())
        {
            AlertEx(cfg_wlanwps_language['amp_wlan_wps_unbothwps']);
			return;
		}
 	
	    enableBoth(Form);

	}
	else
	{
	    enableOneSsid(Form);
	}
	
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function disableAllElem(elemEnable)
{
	setDisable('wpsEnable', elemEnable);
	setDisable('btnApplySubmit', elemEnable);
	disableWpsMethods(elemEnable);
}

function disableWpsMethods(methodEnable)
{
	setDisable('wpspbcpair', methodEnable);
	setDisable('wpsappingenerate', methodEnable);
	setDisable('wpsstapinpair', methodEnable);
}

function updateUI()
{
    setCheck('pbcEnable', 0);
    setCheck('apPinEnable', 0);
    
     if ('NONE' == ssidIdx)
    {
        return;
    }

    var wlcInst = 1;
    if ('BOTH' != ssidIdx)
    {
        wlcInst = ssidIdx;
    }

    if ('PushButton' == wpsConfigs[wlcInst - 1].Method)
    {
        setCheck('pbcEnable', 1);
    }
	
	if (('Lable' == wpsConfigs[wlcInst - 1].Method) && ('AP' == wpsConfigs[wlcInst - 1].Generator))
	{
		setCheck('apPinEnable', 1);
	}
    
	if ('BOTH' != ssidIdx)
	{
		if(1 == wpsConfigs[wlcInst - 1].APPinEnable)
		{
			setCheck('apPinEnable', 1);
		}
	}
	else
	{
		if(1 == wpsConfigs[4].APPinEnable)
		{
			setCheck('apPinEnable', 1);
		}
	}
	
	if(0 == getCheckVal('pbcEnable'))
	{
		setDisable('wpspbcpair',1);
	}
	else
	{
		setDisable('wpspbcpair',0);
	}
	
	if(0 == getCheckVal('apPinEnable'))
	{
		setDisable('wpsappingenerate',1);
	}
	else
	{
		setDisable('wpsappingenerate',0);
	}
}

function zeroFill(num,size)
{  
   if(num == 0)
   {
      return "";
   }
   var s = "000000000" + num;
   return s.substr(s.length-size);
}

function LoadFrame()
{
	var wpsSsidNum = 0;
	var staPin  = 0;
	for (var loop = 0; loop < wpsPinNum.length - 1; loop++)
	{
		var wlcInst = getWlcInstByDomainName(wpsPinNum[loop].domain);
		wpsConfigs[wlcInst - 1] = new stWpsConfig(wpsPinNum[loop].Enable, wpsPinNum[loop].X_HW_ConfigMethod, wpsPinNum[loop].X_HW_PinGenerator, wpsPinNum[loop].DevicePassword, wpsPinNum[loop].X_HW_APPinEnable);
		if (1 == wpsConfigs[wlcInst - 1].Enable)
		{
			wpsSsidNum++;
			ssidIdx = wlcInst;
		}
	}
	if (wpsSsidNum > 0)
	{
		setCheck('wpsEnable', 1);
		setDisable('selectwpsssid', 0);
		disableWpsMethods(0);	
	}
	else
	{
		setCheck('wpsEnable', 0);
		setDisable('selectwpsssid', 1);
		disableWpsMethods(1);
	}

	setDisable('wpsappin', 1);
	if (0 == wpsSsidNum)
	{
		ssidIdx = 'NONE';
		disableWpsMethods(1);
	}
	else if (2 == wpsSsidNum)
	{
		ssidIdx = 'BOTH';
		setText('wpsappin', changeToPinNumber(wpsConfigs[4].pin, 8));
	}
	else
	{
		setText('wpsappin', changeToPinNumber(wpsConfigs[ssidIdx - 1].pin, 8));
	}
	setSelect('selectwpsssid', ssidIdx);
    staPin = zeroFill(top.WlanSTAPIN,8);
	setText("wpsstapin", staPin);

    updateUI();
	showPSKwarningSug(ssidIdx);
	if (0 == enbl)
	{
		disableAllElem(1);
	}
}
</script>
</head>

<body class="mainbody" onload="LoadResource();LoadFrame();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("WPS", GetDescFormArrayById(cfg_wlanwps_language, "amp_wlan_wps_header"), GetDescFormArrayById(cfg_wlanwps_language, "amp_wlan_wps_title"), false);
</script>
<div class="title_spread"></div>
<table width="100%" border="0"  cellpadding="0" cellspacing="0" >
  <tr>
    <td><table width="100%" border="0"  cellpadding="0" cellspacing="0" >
      <tr>
        <td  BindText='amp_wlan_wps_function' class="table_title"></td>
        <td  class="table_right" align="right" width="20%"><input type='checkbox' name='wpsEnable' id='wpsEnable' onClick='EnableWps();' >
								<script>document.write(cfg_wlanwps_language['amp_wlan_wps_enable']);  </script></input></td>
      </tr>
      <tr>
        <td BindText='amp_wlan_wps_applyto' class="table_title"></td>
        <td  align="right" class="table_right" width="20%"><label>
          <select name="selectwpsssid" id="selectwpsssid" onChange="wpsSsidChange()">
		  <option value="NONE">
			<script language="JavaScript" >
        			document.write(cfg_wlanwps_language['amp_wlan_wps_none']);
			</script>
		  </option>
          <script language="JavaScript" >
          if ('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>' == '1')
          {
		  	document.write("<option value='BOTH'>" +cfg_wlanwps_language['amp_wlan_wps_both']+"</option>");
			  for (var wlcloop = 0; wlcloop < WlanArr.length - 1; wlcloop++)
			  {
			  	if (false == IsWpsSupport(wlcloop))
		  		{
		  			continue;
		  		}
			  	var wlcInst = getWlcInstByDomainName(WlanArr[wlcloop].domain);
				if((2 == wlcInst )||( 6 == wlcInst))
			    {
				    continue;
				}
				var band = "(2.4G)";
			  	if (0 == isBand2G(wlcInst))
		  		{
		  			band = "(5G)";
		  		}
			  	document.write("<option value=" + wlcInst + ">" + htmlencode(WlanArr[wlcloop].ssid) + band +"</option>");
			  }
          }
		  else
		  {
			  for (var wlcloop = 0; wlcloop < WlanArr.length - 1; wlcloop++)
			  { 
			    var wlcInst = getWlcInstByDomainName(WlanArr[wlcloop].domain);
				if(2 == wlcInst)
				{
				   continue;
				}
			  	document.write("<option value=" + getWlcInstByDomainName(WlanArr[wlcloop].domain) + ">" + WlanArr[wlcloop].ssid +"</option>");
			  }
		  }
          </script >
          </select>
        </label></td>
      </tr>
      <tr>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
  <td></tr>
  <tr>
    <td><table width="100%" border="0" >
      <tr class="tabal_head">
        <td class="block_title"BindText='amp_wlan_wps_pbctitle'></td>
      </tr>
      <tr>
        <td><table width="100%" border="0"  cellpadding="0" cellspacing="0" >
          <tr>
            <td colspan="2"BindText='amp_wlan_wps_pbcdesc'></td>
          </tr>
          <tr>
            <td  BindText='amp_wlan_wps_pbcenable' class="table_title"></td>
            <td align="right" class="table_right" width="20%"><div align="right"><input type='checkbox' name='pbcEnable' id='pbcEnable' onClick='EnablePbc();' checked>
								<script>document.write(cfg_wlanwps_language['amp_wlan_wps_enable']);  </script></input></div></td>
          </tr>
          <tr>
            <td BindText='amp_wlan_wps_pairin2minute' class="table_title"></td>
            <td align="right" class="table_right" width="20%"><label>
              <button type="button" name="wpspbcpair" id="wpspbcpair" onclick="PairPbc();">
              <script>document.write(cfg_wlanwps_language['amp_wlan_wps_pair']);  </script></button>
            </label></td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
            </tr>
        </table></td>
      </tr>
    </table>
    <table width="100%" border="0">
      <tr class="tabal_head">
        <td class="block_title" BindText='amp_wlan_wps_appin_title'></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr>
            <td colspan="2" BindText='amp_wlan_wps_appin_desc'></td>
          </tr>
          <tr>
            <td BindText='amp_wlan_wps_appin_enable' class="table_title"></td>
            <td align="right" class="table_right" width="20%"><div align="right"><input type='checkbox' name='apPinEnable' id='apPinEnable' onClick='EnableApPin();' checked>
								<script>document.write(cfg_wlanwps_language['amp_wlan_wps_enable']);  </script></input></div></td>
          </tr>
          <tr>
            <td BindText='amp_wlan_wps_appin_value' class="table_title"></td>
            <td align="right" class="table_right" width="20%"><input type="text" name="wpsappin" id="wpsappin" /></td>
          </tr>
		  <tr>
            <td class="table_right" colspan="2" id="wpsappinwarning"></td>
          </tr>
          <tr>
            <td BindText='amp_wlan_wps_appin_generate' class="table_title"></td>
            <td align="right" class="table_right" width="20%"><button type="button" name="wpsappingenerate" id="wpsappingenerate" onclick='GenerateApPin();'>
            <script>document.write(cfg_wlanwps_language['amp_wlan_wps_btn_generate']);  </script></button></td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
            </tr>
        </table></td>
      </tr>
    </table>
    <table width="100%" border="0">
      <tr class="tabal_head">
        <td class="block_title" BindText='amp_wlan_wps_stapin_title'></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr>
            <td colspan="2" BindText='amp_wlan_wps_stapin_desc'></td>
          </tr>
          <tr>
            <td BindText='amp_wlan_wps_stapin_value' class="table_title"></td>
            <td align="right" class="table_right" width="20%"><label>
              <input type="text" name="wpsstapin" id="wpsstapin" />
            </label></td>
          </tr>
          <tr>
            <td BindText='amp_wlan_wps_pairin2minute' class="table_title"></td>
            <td align="right" class="table_right"><button type="button" name="wpsstapinpair" id="wpsstapinpair" onclick='PairStaPin();'>
            <script>document.write(cfg_wlanwps_language['amp_wlan_wps_pair']);  </script></button></td>
          </tr>

        </table></td>
      </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
      <tr><td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr>
            <td class="table_submit"  align="right">
              <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="WpsSubmit();"><script>document.write(cfg_wlanwps_language['amp_wlan_wps_apply']);</script></button>
              <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="LoadFrame();"><script>document.write(cfg_wlanwps_language['amp_wlan_wps_cancel']);</script></button>
            </td>
          </tr>
        </table>
        </td> 
      </tr>
    </table>	

    </td>
  </tr>
</table>
</body>
</html>
