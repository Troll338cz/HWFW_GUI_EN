<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlanguestwifi_language, cfg_wlancfgother_language, cfg_wlancfgdetail_language, vdf_wlan_basic_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(errdes.html);%>"></script>
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
<title>Guest WiFi</title>
<script language="JavaScript" type="text/javascript">

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var DoubleWlanFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var IsNos = "<%HW_WEB_GetFeatureSupport(FT_WLAN_NOS2WIFI);%>";

function stGuestWifi(domain,SSID_IDX,PortIsolation,Duration,UpRateLimit,DownRateLimit,AutoGenFlag)
{
	this.domain = domain;
    this.SSID_IDX = SSID_IDX;
	this.PortIsolation = PortIsolation;
	this.Duration = Duration;
	this.UpRateLimit = UpRateLimit;
	this.DownRateLimit = DownRateLimit;
	this.AutoGenFlag = AutoGenFlag;
}

var GuestWifi = new Array();

var wep1password;

var GuestWifiArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.{i},SSID_IDX|PortIsolation|Duration|UpRateLimit|DownRateLimit|AutoGenFlag,stGuestWifi);%>;
var GuestWifiArrLen = GuestWifiArr.length - 1;

for(var i=0; i <GuestWifiArrLen; i++)
{
    GuestWifi[i] = new stGuestWifi();
    GuestWifi[i] = GuestWifiArr[i];
}

function sldcinfo(domain,startIP,endIP,enable,description)
{
	this.domain		= domain;
	this.startIP    = startIP;
	this.endIP      = endIP;
	this.enable		= enable;
    this.description = description;
}

var SlaveDhcpInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i}.,MinAddress|MaxAddress|Enable|X_HW_Description,sldcinfo);%>;

var GuestWifiFlag = 0;
var difSubNet = 0;

for (var i=0;i < SlaveDhcpInfo.length-1;i++)
{
    if (SlaveDhcpInfo[i].description =="guestwifi")
    {
        SlaveDhcpInfo[0] = SlaveDhcpInfo[i];
        GuestWifiFlag = 1;
    }
}

function stipaddr(domain,enable,ipaddr,subnetmask)
{
	this.domain		= domain;
	this.enable		= enable;
	this.ipaddr		= ipaddr;
	this.subnetmask	= subnetmask;	
}
var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,stipaddr);%>;
if (LanIpInfos[1] == null)
{
    LanIpInfos[1] = new stipaddr("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2", "", "", ""); 
}
function madcinfo(domain,minaddress,maxaddress,enable)
{
	this.domain		= domain;
	this.minaddress = minaddress;
	this.maxaddress = maxaddress;
	this.enable		= enable;
}
var MainDhcpInfo= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,MinAddress|MaxAddress|DHCPServerEnable,madcinfo);%>;

function stWlan(domain,name,enable,SSID,SSIDAdvertisementEnabled,DeviceNum,wmmEnable,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                KeyIndex,EncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,WPARekey,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable, LowerLayers,
                X_HW_WAPIEncryptionModes,X_HW_WAPIAuthenticationMode,X_HW_WAPIServer,X_HW_WAPIPort, X_HW_Standard)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.SSID = SSID;
    this.SSIDAdvertisementEnabled = SSIDAdvertisementEnabled;
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
    this.mode = X_HW_Standard;
}
var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|LowerLayers|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort|X_HW_Standard,stWlan);%>;
var WlanWifi = WlanArr[0];
var submitLan = LanIpInfos[0];
if (null == WlanWifi)
{
	WlanWifi = new stWlan("","","","","","","","","","","","","","","","","","","","","","","","","","","","","11n");
}
function stPreSharedKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}
var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;

var wlanArrLen = WlanArr.length - 1;

for (i=0; i < wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}

var wlanloop = 0;
var wlanloopMap = {};
var enable2G = 0;
var enable5G = 0;
var guestWifi2G = '';
var guestWifi5G = '';
var index2g = 0;
var index5g = 0;

for(var loop=0;loop < WlanArr.length-1;loop++)
{
	if(WlanArr[loop].name == 'ath1')
	{
		enable2G = WlanArr[loop].enable;
		wlanloopMap['ath1'] = loop;
		guestWifi2G = WlanArr[loop];
		index2g = loop;
	}
		
	if(WlanArr[loop].name == 'ath5')
	{
		enable5G = WlanArr[loop].enable;
		wlanloopMap['ath5'] = loop;
		guestWifi5G = WlanArr[loop];
		index5g = loop;
	}
}

function getInstIdByDomain(domain)
{
    if ('' != domain)
    {
        return parseInt(domain.charAt(domain.length - 1));    
    }
}

function getinstbyath(name)
{
	for(loop=0;loop < WlanArr.length-1;loop++)
	{
		if(WlanArr[loop].name == name)
		{
			return getInstIdByDomain(WlanArr[loop].domain);
		}
	}
	return -1;
}

function getwlanloopbyath(name)
{
	for(loop=0;loop < WlanArr.length-1;loop++)
	{
		if(WlanArr[loop].name == name)
		{
			return loop;
		}
	}
	return -1;
}

function GetWepKeyIndex(name)
{
	for(loop=0;loop < WlanArr.length-1;loop++)
	{
		if(WlanArr[loop].name == name)
		{
			return Wlan[loop].KeyIndex;
		}
	}
	return -1;
}

var wlaninst = 0;
var wlaninstext = 0;

function ShowOrHideText(checkBoxId, passwordId, textId)
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

function changeauthandpassword(value)
{
	displayPasswordEnable();
    if (value == 'open')
    {
		setDisplay("wpakeyInfo", 0);
				
        setText('pwd_ssidpassword', "");
        setText('txt_ssidpassword', "");
    }
    else
    {	
		setDisplay("wpakeyInfo", 1);
		
		if(1 == IfAutoGen())
		{
			if((1 == GuestInst)||(3 == GuestInst))
			{
				setText('pwd_ssidpassword',wpakey2G);           
				setText('txt_ssidpassword',wpakey2G);
			}
			else
			{
				setText('pwd_ssidpassword',wpakey5G);           
				setText('txt_ssidpassword',wpakey5G);
			}
		}
		else
		{
			if((1 == GuestInst)||(3 == GuestInst))
			{
				setText('pwd_ssidpassword',wpaPskKey[index2g].value);           
				setText('txt_ssidpassword',wpaPskKey[index2g].value);
			}
			else
			{
				setText('pwd_ssidpassword',wpaPskKey[index5g].value);           
				setText('txt_ssidpassword',wpaPskKey[index5g].value);
			}
		}
    }
}

function checkModifyAutoGenKey()
{
	if(1 == IfAutoGen())
	{
		if((1 == GuestInst)||(3 == GuestInst))
		{
			if(wpakey2G ==getValue('txt_ssidpassword'))
			{
				if (ConfirmEx(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_modify_key'])) 
				{
					return false;
				}
			}
		}
		else
		{	
			if(wpakey5G ==getValue('txt_ssidpassword'))
			{
				if (ConfirmEx(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_modify_key'])) 
				{
					return false;
				}
			}
		}
	}
	return true;
}

function IsLessThan(lip, rip)
{
	var ladress = lip.split('.');
	var radress = rip.split('.');
	var ladnum = 0;
	var radnum = 0;
	
	for(var i = 0; i < 4; i++)
	{
		ladnum = ladnum + parseInt(ladress[i], 10);
		radnum = radnum + parseInt(radress[i], 10);
	}

	if(ladnum <= radnum)
	{
	    return true;
	}
	return false;
}


function CheckGusetWifiIP(sourceIP)
{

    if (!isValidIpAddress(sourceIP)) 
    {
       AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
       return false;
    }

    if (isSameSubNet(sourceIP,LanIpInfos[0].subnetmask,LanIpInfos[0].ipaddr,LanIpInfos[0].subnetmask))
    {
        if (isBroadcastIp(sourceIP, LanIpInfos[0].subnetmask))
        {
           AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
           return false;
        }        
        submitLan = LanIpInfos[0];
        return LanIpInfos[0].ipaddr;
    }
    else if (isSameSubNet(sourceIP,LanIpInfos[1].subnetmask,LanIpInfos[1].ipaddr,LanIpInfos[1].subnetmask))
    {
        if (isBroadcastIp(sourceIP, LanIpInfos[1].subnetmask))
        {
           AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
           return false;
        }   
             
        submitLan = LanIpInfos[1];

        return LanIpInfos[1].ipaddr;
    }
	else
	{	
		if (isBroadcastIp(sourceIP, LanIpInfos[1].subnetmask) || isBroadcastIp(sourceIP, LanIpInfos[0].subnetmask))
        {
           AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
           return false;
        } 
		submitLan = LanIpInfos[1];
		difSubNet = 1;
		submitLan.ipaddr = sourceIP.split(".")[0] + '.' + sourceIP.split(".")[1] +"." + sourceIP.split(".")[2] + ".1";
        return LanIpInfos[1].ipaddr;
    }
    
    return true;    
}

function CheckStEdIp()
{
    var startIP = getValue("StartIPaddress");
    var EndIP = getValue("EndIPaddress");

    if (CheckGusetWifiIP(startIP) ==  false)
    {
        return false;
    }

    if (CheckGusetWifiIP(EndIP) ==  false)
    {
        return false;
    }

	if (!(isEndGTEStart(EndIP, startIP))) 
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipgeqstartip']);
		return false;
	}
	
    if (CheckGusetWifiIP(startIP) == LanIpInfos[0].ipaddr)
    {
        if(((IsLessThan(MainDhcpInfo[0].minaddress, getValue("EndIPaddress")) && IsLessThan(getValue("StartIPaddress"), MainDhcpInfo[0].minaddress)) || 
            (IsLessThan(MainDhcpInfo[0].minaddress, getValue("StartIPaddress")) && IsLessThan(getValue("EndIPaddress"), MainDhcpInfo[0].maxaddress))))
        {
           AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolinmianpool']);
           return false;
        }
    }
    else
    {
        return true;
    }   

	return true;
}

function funProtectionmodeSelect()
{
	$("#checkinfo5Row").css("display", "none");
	var value = getSelectVal('wlAuthMode');
	changeauthandpassword(value);
}

var broadenable2g = 0;
var broadenable5g = 0;
var setBroadFlag = 0;

function SetWifiBroadcastEnable()
{
	setBroadFlag = 1;
	if((GuestInst == 1)||(GuestInst == 3))
	{
		broadenable2g = 1 - broadenable2g;
		if(broadenable2g == 1)
		{
			$("#swithicon").attr("src", "../../../images/checkon.jpg");
		}
		else
		{
			$("#swithicon").attr("src", "../../../images/checkoff.jpg");
		}
	}
	else
	{
		broadenable5g = 1 - broadenable5g;
		if(broadenable5g == 1)
		{
			$("#swithicon").attr("src", "../../../images/checkon.jpg");
		}
		else
		{
			$("#swithicon").attr("src", "../../../images/checkoff.jpg");
		}
	}

}

function getWifiBroadcastEnable()
{
	if((GuestInst == 1)||(GuestInst == 3))
	{
		return broadenable2g;
	}
	else
	{
		return broadenable5g;
	}
}

function CheckStreamRateValue()
{ 
    var UpstreamRate = getValue('wlUpRate');
    var DownstreamRate = getValue('wlDownRate');

    if(!isInteger(UpstreamRate))
    {
        AlertEx(cfg_wlanguestwifi_language['amp_uprate_int']);
        return false;
    }

    if( (parseInt(UpstreamRate,10) < 0) || (parseInt(UpstreamRate,10) > 4094) )
    {
        AlertEx(cfg_wlanguestwifi_language['amp_uprate_out_range']);
        return false;
    }

    if(!isInteger(DownstreamRate))
    {
        AlertEx(cfg_wlanguestwifi_language['amp_downrate_int']);
        return false;
    }

    if( (parseInt(DownstreamRate,10) < 0) || (parseInt(DownstreamRate,10) > 4094) )
    {
        AlertEx(cfg_wlanguestwifi_language['amp_downrate_out_range']);
        return false;
    }

    return true;
}

function checkDuration()
{
	var durationTime = getValue('ActivationTimeLimit');
	if(!isInteger(durationTime))
    {
        return false;
    }
	if(parseInt(durationTime,10) < 0)
    {
        return false;
    }
	return true;
}

function checkRadioEnable()
{
	var ratioEnable2g = RadioEnableByBand("2G");
	var ratioEnable5g = RadioEnableByBand("5G");
	
	if(ratioEnable2g == false)
	{
		if((1 == GuestInst)||(3 == GuestInst))
		{
			return false;
		}
	}
	if(ratioEnable5g == false)
	{
		if((2 == GuestInst)||(3 == GuestInst))
		{
			return false;
		}
	}
	return true;
}

function getWlanPortNumber(name)
{
    var length = name.length;
    var number;
    var str = parseInt(name.charAt(length-1));
    return str;
}

function SSIDcheck()
{
	var ssidname = getValue('ssidname');
	ssidname = ltrim(ssidname);
	if(ssidname == '')
	{
		AlertEx(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_checkssid']);
		return false;
	}
	
	
	if (1 == GuestInst)
	{
		for (var i = 0; i < Wlan.length; i++)
		{	
			if ((getWlanPortNumber(Wlan[i].name)<= 3) && wlanloopMap['ath1'] != i && Wlan[i].ssid == ssidname)
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_exist_ptvdf']);
				return false;
			}
		}
	}
	else if (2 == GuestInst)
	{
		for (var i = 0; i < Wlan.length; i++)
		{	
			if ((getWlanPortNumber(Wlan[i].name) > 3) && wlanloopMap['ath5'] != i && Wlan[i].ssid == ssidname)
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_exist_ptvdf']);
				return false;
			}
		}
	}
	else
	{
		for (var i = 0; i < Wlan.length; i++)
		{	
			if ((getWlanPortNumber(Wlan[i].name)<= 3) && wlanloopMap['ath1'] != i && Wlan[i].ssid == ssidname)
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_exist_ptvdf']);
				return false;
			}
			
			if ((getWlanPortNumber(Wlan[i].name) > 3) && wlanloopMap['ath5'] != i && Wlan[i].ssid == ssidname)
			{
				AlertEx(cfg_wlancfgother_language['amp_ssid_exist_ptvdf']);
				return false;
			}
		}
	}
	
	return true;
}

function getbeaconandkey(Form,inst)
{
	var value = getSelectVal('wlAuthMode');
	
	var pskpassword;
	
	var txtpskpassword =  getValue('txt_ssidpassword');
	var pswpskpassword =  getValue('pwd_ssidpassword');
	if ((isFireFox4 == 1) && (pswpskpassword == ''))
	{
		pswpskpassword = wpapskpassword;
	}
		
	if(value == 'open')
	{
		Form.addParameter('x' + inst + '.BeaconType','Basic');
		Form.addParameter('x' + inst + '.BasicAuthenticationMode','None');
		Form.addParameter('x' + inst + '.BasicEncryptionModes','None');
	}
	else if(value == 'wpa-psk')
	{
		Form.addParameter('x' + inst + '.BeaconType','WPA');
		Form.addParameter('x' + inst + '.WPAAuthenticationMode','PSKAuthentication');
		
		if ((pswpskpassword != "********") || (pskPsdModFlag == true) || (1 == curUserType))
		{
			Form.addParameter('z' + inst + '.PreSharedKey', pswpskpassword);
		}    
	}
	else if(value == 'wpa2-psk')
	{
		Form.addParameter('x' + inst + '.BeaconType','11i');
		Form.addParameter('x' + inst + '.IEEE11iAuthenticationMode','PSKAuthentication');
		if ((pswpskpassword != "********") || (pskPsdModFlag == true) || (1 == curUserType))
		{
			Form.addParameter('z' + inst +  '.PreSharedKey', pswpskpassword);
		}  
	}
	else if(value == 'wpa/wpa2-psk')
	{
		Form.addParameter('x' + inst + '.BeaconType','WPAand11i');
		Form.addParameter('x' + inst + '.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
		if ((pswpskpassword != "********") || (pskPsdModFlag == true) || (1 == curUserType))
		{
			Form.addParameter('z' + inst + '.PreSharedKey', pswpskpassword);
		}  
	}
}

function AddAutoGenPara(Form,inst,GuestInst)
{
	if((1 == IfAutoGen())&&(1 == DoubleWlanFlag))
	{
		if(1 == GuestInst)
		{
			Form.addParameter('z' + inst + '.PreSharedKey', wpakey5G);
			Form.addParameter('x' +inst+ '.SSID', guestrandomssid5G);
		}
		else
		{
			Form.addParameter('z' + inst + '.PreSharedKey', wpakey2G);
			Form.addParameter('x' +inst+ '.SSID', guestrandomssid2G);
		}
	}
}

function AddOpenAuthKey(Form,inst,wpakey)
{
	var value = getSelectVal('wlAuthMode');	
	if(1 == IfAutoGen())
	{
		if(value == 'open')
		{
			Form.addParameter('z' + inst + '.PreSharedKey', wpakey);	
		}
	}
}

function AddWlanPara(Form,inst,enable)
{
    Form.addParameter('x' +inst+ '.SSID', getValue('ssidname'));
	Form.addParameter('x' +inst+ '.SSIDAdvertisementEnabled', enable);
}

function AddGuestPara(Form,GuestInst,wlaninst)
{
	Form.addParameter('y'+GuestInst+'.SSID_IDX', wlaninst);
	Form.addParameter('y'+GuestInst+'.Duration', parseInt(getValue('ActivationTimeLimit'),10));
	Form.addParameter('y'+GuestInst+'.UpRateLimit', parseInt(getValue('wlUpRate'), 10));
	Form.addParameter('y'+GuestInst+'.DownRateLimit', parseInt(getValue('wlDownRate'), 10));
	getAutoGenFlag(Form);
}

function getAutoGenFlag(Form)
{
	if((1 == SetAutoGenFlag)
		||((0 == IfAutoGen()) && (0 == GuestWifi[0].AutoGenFlag)))
	{
		Form.addParameter('y'+1+'.AutoGenFlag', 1);
		if(1 == DoubleWlanFlag)
		{
			Form.addParameter('y'+2+'.AutoGenFlag', 1);
		}
	}
}

function PasswordCheck()
{
	var value = getSelectVal('wlAuthMode');

	if ((value == 'wpa-psk') || (value == 'wpa2-psk') || (value == 'wpa/wpa2-psk'))
	{
		var PskKey = getValue('txt_ssidpassword');
		if (false == isValidWPAPskKey(PskKey))
		{
			AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
			return false;
		}
	}
}

function GetAjaxStr(Result)
{
    var i = 0;
    var errorCodeArray = new Array('0xf7301034');
    try{
    
        var ResultInfo = JSON.parse(hexDecode(Result));

        if (str.toLowerCase() == "0xf7301034")
        {
            setDisable('btnApplySubmit', 0);
            AlertEx(cfg_wlanguestwifi_language["bbsp_gstwfIPcollide"] + getValue("StartIPaddress")+"-" +getValue("EndIPaddress") + cfg_wlanguestwifi_language["bbsp_gstwfIPcollide1"]);
            return;
        }

        var errData = errLanguage['s' + ResultInfo.error];
        if ('string' != typeof(errData))
        {
            errData = errLanguage['s0xf7205001'];
        }

        AlertEx(errData);
    }catch(e){
    
        errData = errLanguage['s0xf7205001'];
        AlertEx(errData);
    }
}

function getGuestInst()
{
	if (showRadio == '2.4GHz')
	{
		GuestInst = 1;
		wlaninst = getinstbyath("ath1");
		wlanloop = wlanloopMap['ath1'];
		if (DoubleWlanFlag == '1')
		{
			wlaninstext = getinstbyath("ath5");
		}
		else
		{
			wlaninstext = wlaninst;
		}
	}
	else if (showRadio == '5GHz')
	{
		GuestInst = 2;
		wlaninstext = getinstbyath("ath1");
		wlaninst = getinstbyath("ath5");
		wlanloop = wlanloopMap['ath5'];	
	}
	else
	{
		GuestInst = 3;
		wlaninst = getinstbyath("ath1");
		wlaninstext = getinstbyath("ath5");
		wlanloop = wlanloopMap['ath1'];
	}
}

function isGuestWiFiEnable()
{
	if (getCheckVal('EnableGuestWifi') == 1)
	{
		if (DoubleWlanFlag == '1')
		{
			if (GuestInst == 3 && getCheckVal('wlEnable') == 1)
			{
				return 1;
			}
		
			if ((GuestInst == 1 && (getCheckVal('wlEnable') == 1 || enable5G == 1))
					|| (GuestInst == 2 && (getCheckVal('wlEnable') == 1 || enable2G == 1)))
			{
				return 1;
			}
		}
		else 
		{
			if (getCheckVal('wlEnable') == 1)
			{
				return 1;
			}
		}
	}
	
	return 0;
}

function getSourceInterfacePath(path1,path2)
{
	var path = '';
	
	if((GuestInst == 3)&&(path1 != '')&&(path2 != ''))
	{
        path = path1 + ',' + path2;
    }
    else
    {	
		if (getCheckVal('wlEnable') == 1)
		{
			if (DoubleWlanFlag == 1)
			{
				if ((GuestInst == 1) && (enable5G == 1) && (path1 != '')&&(path2 != ''))
				{
					path = path1 + ',' + path2;
				}
				else if ((GuestInst == 2) && (enable2G == 1) && (path1 != '')&&(path2 != ''))
				{
					path = path2 + ',' + path1;
				}
				else
				{
					path = path1;
				}
			}
			else 
			{
				path = path1;
			}
		}
        else
		{
			path = path2;
		}
    }
	
	return path;
}	

function btnApplySubmit()
{
	getGuestInst();

	if(false == PasswordCheck())
	{
		return;
	}

	if(false == SSIDcheck())
	{
		return;
	}

	if(false == checkRadioEnable())
	{
		AlertEx(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_checkradio']);
		return;
	}
		
	if (false == checkDuration())
    {
        return;
    }
	
	if (false == CheckStreamRateValue())
    {
        return;
    }
	
	if(1 == isGuestWiFiEnable())
	{
		if(false == CheckStEdIp())
		{
			return;
		}
	}
	
	if(false == checkModifyAutoGenKey())
	{
		return;
	}
	
	var Form = new webSubmitForm();
	
	var BroadEnable = 0;
	if(setBroadFlag == 1)
	{
		BroadEnable = getWifiBroadcastEnable();
		setBroadFlag = 0;
	}
	else
	{
		BroadEnable = Wlan[wlanloop].SSIDAdvertisementEnabled;
	}
	
	if((GuestInst == 1)||(GuestInst == 2))
	{
		getbeaconandkey(Form,wlaninst);

		AddWlanPara(Form,wlaninst,BroadEnable);
		AddAutoGenPara(Form,wlaninstext,GuestInst);
		
		if(GuestInst == 1)
		{
			AddOpenAuthKey(Form,wlaninst,wpakey2G);
			
			if(1 == DoubleWlanFlag)
			{	
				AddOpenAuthKey(Form,wlaninstext,wpakey5G);
			}
		}
		else
		{
			AddOpenAuthKey(Form,wlaninst,wpakey5G);
			AddOpenAuthKey(Form,wlaninstext,wpakey2G);
		}		
		
		if(0 == getCheckVal('EnableGuestWifi'))
		{
			Form.addParameter('x' +wlaninst+ '.Enable', 0);
			if (DoubleWlanFlag == '1')
			{	
				Form.addParameter('x'+wlaninstext+'.Enable', 0);
			}
		}
		else
		{
			Form.addParameter('x' +wlaninst+ '.Enable', getCheckVal('wlEnable'));
			
			if(GuestInst == 1)
			{
				if (DoubleWlanFlag == '1')
				{
					Form.addParameter('x'+wlaninstext+'.Enable', enable5G);
				}
			}
			else
			{
				Form.addParameter('x'+wlaninstext+'.Enable', enable2G);
			}
		}
		AddGuestPara(Form,GuestInst,wlaninst);
	}
	else
	{
		getbeaconandkey(Form,wlaninst);
		getbeaconandkey(Form,wlaninstext);
		AddWlanPara(Form,wlaninst,BroadEnable);
		AddWlanPara(Form,wlaninstext,BroadEnable);
		AddGuestPara(Form,1,wlaninst);
		AddGuestPara(Form,2,wlaninstext);
		
		if(0 == getCheckVal('EnableGuestWifi'))
		{
			Form.addParameter('x' +wlaninst+ '.Enable', 0);
			Form.addParameter('x'+wlaninstext+'.Enable', 0);
		}
		else
		{
			Form.addParameter('x' +wlaninst+ '.Enable', getCheckVal('wlEnable'));
			Form.addParameter('x'+wlaninstext+'.Enable', getCheckVal('wlEnable'));
		}
	}

    setDisable('btnApplySubmit', 1);

    if (isGuestWiFiEnable() == 0)
    {
        if (GuestWifiFlag != 0)
        {
            Form.addParameter('set_p.Enable', '0');
            Form.setAction('complex.cgi?&set_p=' + SlaveDhcpInfo[0].domain.substr(0,SlaveDhcpInfo[0].domain.length-1)
                + '&x'+ wlaninst + '=' + getWlanPath(wlaninst)
                + '&x'+ wlaninstext + '=' + getWlanPath(wlaninstext)
                + getGuestPath(GuestInst) 
                + getWlanPskPath()
                + '&RequestFile=html/amp/wlanbasic/VDFWlanGuestWifi.asp');            
        }
        else
        {
            Form.setAction('complex.cgi?'
                            + '&x'+ wlaninst + '=' + getWlanPath(wlaninst)
                            + '&x'+ wlaninstext + '=' + getWlanPath(wlaninstext)
                            + getGuestPath(GuestInst)
                            + getWlanPskPath()
                            + '&RequestFile=html/amp/wlanbasic/VDFWlanGuestWifi.asp');             
        }
        
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));

        Form.submit();
    }
    else
    {
        if (GuestWifiFlag == 0)
        {
            var SL = GetSSIDList();
            var path1 = '';
            var path2 = '';
            var path = '';
            var SubmitParaForm = "";
            
            for(var i = 0; i < SL.length; i++)
            {
                if(wlaninst == getWlanInstFromDomain(SL[i].domain))
                {
                    path1 = SL[i].domain;
                }

                if(wlaninstext == getWlanInstFromDomain(SL[i].domain))
                {
                    path2 = SL[i].domain;
                }
            }
            
			path = getSourceInterfacePath(path1, path2);

            SubmitParaForm += "Add_p.Enable=1";
            SubmitParaForm += "&Add_p.MinAddress=" + getValue('StartIPaddress');
            SubmitParaForm += "&Add_p.MaxAddress=" + getValue('EndIPaddress');
            SubmitParaForm += "&Add_p.IPRouters=" + submitLan.ipaddr;
            SubmitParaForm += "&Add_p.SubnetMask=" + submitLan.subnetmask;
            SubmitParaForm += "&Add_p.DHCPLeaseTime=" + "3600";
            SubmitParaForm += "&Add_p.X_HW_Description=guestwifi";
            SubmitParaForm += "&set_p.IPInterfaceIPAddress=192.168.2.1";
            SubmitParaForm += "&Add_p.PoolOrder=1";
            SubmitParaForm += "&Add_p.SourceInterface=" + FormatUrlEncode(path);

            for (var i = 0;i < Form.oForm.length; i++)
            {
                SubmitParaForm += "&" + Form.oForm[i].name + "=" + FormatUrlEncode(Form.oForm[i].value);
            }
            
            $.ajax({
                type : "POST",
                async : true,
                cache : false,
                data : SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
                url : 'complexajax.cgi?'
                        + '&x'+ wlaninst + '=' + getWlanPath(wlaninst)
                        + '&x'+ wlaninstext + '=' + getWlanPath(wlaninstext)
                        + getGuestPath(GuestInst) 
                        + getWlanPskPath()
                        + '&set_p=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                        + '&Add_p=' + 'InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool'
                        + '&RequestFile=html/amp/wlanbasic/VDFWlanGuestWifi.asp',
                success : function(data) {

                    setDisable('btnApplySubmit', 0);

                    GetAjaxStr(data);
            }});                      
        }
        else
        {
			if (!difSubNet){
				Form.addParameter('w.Enable', '1');
				Form.addParameter('w.MinAddress', getValue('StartIPaddress'));
				Form.addParameter('w.MaxAddress', getValue('EndIPaddress'));
				Form.addParameter('w.IPRouters',  submitLan.ipaddr);
				Form.addParameter('w.SubnetMask', submitLan.subnetmask);
				Form.addParameter('w.X_HW_Description',"guestwifi");
				Form.addParameter('w.PoolOrder',"1");
				var SL = GetSSIDList();
				var path1 = '';
				var path2 = '';
				var path = '';
				for(var i = 0; i < SL.length; i++)
				{
					if(wlaninst == getWlanInstFromDomain(SL[i].domain))
					{
						path1 = SL[i].domain;
					}
					if(wlaninstext == getWlanInstFromDomain(SL[i].domain))
					{
						path2 = SL[i].domain;
					}
				}
				path = getSourceInterfacePath(path1, path2);
				Form.addParameter('w.SourceInterface', path);
				Form.addParameter('x.X_HW_Token', getValue('onttoken'));
				Form.setAction('set.cgi?'
								+ '&x'+ wlaninst + '=' + getWlanPath(wlaninst)
								+ '&x'+ wlaninstext + '=' + getWlanPath(wlaninstext)
								+ getGuestPath(GuestInst) 
								+ '&w=' + SlaveDhcpInfo[0].domain.substr(0,SlaveDhcpInfo[0].domain.length-1)
								+ getWlanPskPath()
								+ '&RequestFile=html/amp/wlanbasic/VDFWlanGuestWifi.asp');
				Form.submit();
				setDisable('btnApplySubmit', 1);						
			}
			else
			{
				var SubmitParaForm = "z.IPInterfaceIPAddress=" + submitLan.ipaddr;
				$.ajax({
					type : "POST",
					async : true,
					cache : false,
					data : SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
					url : 'set.cgi?'
							+ '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
							+ '&RequestFile=html/amp/wlanbasic/VDFWlanGuestWifi.asp',
				success : function(data) {
				Form.addParameter('w.Enable', '1');
				Form.addParameter('w.MinAddress', getValue('StartIPaddress'));
				Form.addParameter('w.MaxAddress', getValue('EndIPaddress'));
				Form.addParameter('w.IPRouters',  submitLan.ipaddr);
				Form.addParameter('w.SubnetMask', submitLan.subnetmask);
				Form.addParameter('w.X_HW_Description',"guestwifi");
				Form.addParameter('w.PoolOrder',"1");

				var SL = GetSSIDList();
				var path1 = '';
				var path2 = '';
				var path = '';
				
				for(var i = 0; i < SL.length; i++)
				{
					if(wlaninst == getWlanInstFromDomain(SL[i].domain))
					{
						path1 = SL[i].domain;
					}

					if(wlaninstext == getWlanInstFromDomain(SL[i].domain))
					{
						path2 = SL[i].domain;
					}
				}

				path = getSourceInterfacePath(path1, path2);
			   
				Form.addParameter('w.SourceInterface', path);

				Form.addParameter('x.X_HW_Token', getValue('onttoken'));

				Form.setAction('set.cgi?'
								+ '&x'+ wlaninst + '=' + getWlanPath(wlaninst)
								+ '&x'+ wlaninstext + '=' + getWlanPath(wlaninstext)
								+ getGuestPath(GuestInst) 
								+ '&w=' + SlaveDhcpInfo[0].domain.substr(0,SlaveDhcpInfo[0].domain.length-1)
								+ getWlanPskPath()
								+ '&RequestFile=html/amp/wlanbasic/VDFWlanGuestWifi.asp');            

				Form.submit();
				setDisable('btnApplySubmit', 1);
				}});			
			}			
		}
    }
}

function getWlanPath(wlcInst)
{
	if (!(0< wlcInst && wlcInst < 8))
	{
		return 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + '2';
	}
	return 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + wlcInst;
}

function getWlanPskPath()
{
	if((GuestInst == 1)||(GuestInst == 2))
	{
		if((1 == IfAutoGen())&&(1 == DoubleWlanFlag))
		{
			return '&z' + wlaninst + '=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ wlaninst+ '.PreSharedKey.1'+
			'&z' + wlaninstext + '=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ wlaninstext+ '.PreSharedKey.1';
			
		}
		else
		{
			return '&z' + wlaninst + '=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ wlaninst+ '.PreSharedKey.1';
		}
	}
	else
	{
		return '&z' + wlaninst + '=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ wlaninst+ '.PreSharedKey.1' + 
				'&z' + wlaninstext + '=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ wlaninstext+ '.PreSharedKey.1';
	}
}

function getGuestPath(GuestInst)
{
	if((GuestInst == 1)||(GuestInst == 2))
	{
		if((1 == IfAutoGen())&&(1 == DoubleWlanFlag))
		{
			return '&y1' + '=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1'+ 
			'&y2'+ '=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.2';
		}
		else
		{
			return '&y' + GuestInst + '=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.'+ GuestInst;
		}
	}
	else
	{
		return '&y' + '1' + '=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.'+ '1' +'&y' + '2' + '=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.'+ '2';
	}
}

function cancelValue()
{
	$("#checkinfo5Row").css("display", "none");
	LoadFrame();
}

function displayPasswordEnable()
{
	if(0 == curUserType)
	{
		setCheck('displaypassword',0);
		setDisable('displaypassword',1);
	}
	else
	{
		setDisable('displaypassword',0);
	}
}

function wlanSetSelect(id, val)
{
	setSelect(id, val);
}

function beaconTypeChange(authMode,wlanloop)
{
	if (authMode == 'Basic')
	{
		var BasicAuthenticationMode = Wlan[wlanloop].BasicAuthenticationMode;
		if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem'))
		{
			wlanSetSelect('wlAuthMode','open');
			setDisplay('wpakeyInfo', 0);
		}
	}
	else if(authMode == 'WPA')
	{
            setDisplay("wpakeyInfo", 1);
            wlanSetSelect('wlAuthMode','wpa-psk');
            setText('pwd_ssidpassword',wpaPskKey[wlanloop].value); 
			setText('txt_ssidpassword',wpaPskKey[wlanloop].value);
            wpapskpassword = wpaPskKey[wlanloop].value; 
	}
	else if((authMode == 'WPA2')||(authMode == '11i'))
	{
            setDisplay("wpakeyInfo", 1);
            wlanSetSelect('wlAuthMode','wpa2-psk');
            setText('pwd_ssidpassword',wpaPskKey[wlanloop].value); 
            wpapskpassword = wpaPskKey[0].value; 
            setText('txt_ssidpassword',wpaPskKey[wlanloop].value);    
	}
	else if((authMode == 'WPAand11i')||(authMode == 'WPA/WPA2'))
	{
            setDisplay("wpakeyInfo", 1);
            wlanSetSelect('wlAuthMode','wpa/wpa2-psk');
            setText('pwd_ssidpassword',wpaPskKey[wlanloop].value); 
            wpapskpassword = wpaPskKey[0].value; 
            setText('txt_ssidpassword',wpaPskKey[wlanloop].value);
	}
	else
	{
		    wlanSetSelect('wlAuthMode','open');
			setDisplay('wpakeyInfo', 0);
	}
	
	if (1 == getCheckVal('displaypassword'))
    {
        setDisplay('pwd_ssidpassword', 0);
        setDisplay('txt_ssidpassword', 1);
    }
    else
    {
        setDisplay('pwd_ssidpassword', 1);
        setDisplay('txt_ssidpassword', 0);
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

var GuestInst = 1;
function showGuestwifiInfo(radio)
{
	showRadio = radio;
	var loop = 0;
	if('2.4GHz' == radio)
	{
		loop = wlanloopMap['ath1'];
		GuestInst = 1;
	}
	else if ('5GHz' == radio)
	{
		loop = wlanloopMap['ath5'];
		GuestInst = 2;
	}
	else
	{
		loop = wlanloopMap['ath1'];
		GuestInst = 3;
	}
   
	InitGuestWifiInfo(loop, radio);
	displayPasswordEnable();
   
	if(1 == IfAutoGen())
	{
		if(('2.4GHz' == radio) || ('2.4GHz/5GHz' == radio))
		{
			selectRadioDisplayRandomSsidAndKey('2G');
		}
		else
		{
			selectRadioDisplayRandomSsidAndKey('5G');
		}
	}
}

function selectRadioDisplayRandomSsidAndKey(radio)
{
	if(1 == DoubleWlanFlag)
	{
		if('2G' == radio)
		{
			setText('ssidname',guestrandomssid2G);
			setText('pwd_ssidpassword',wpakey2G);           
			setText('txt_ssidpassword',wpakey2G);
		}
		else if('5G' == radio)
		{
			setText('ssidname',guestrandomssid5G);
			setText('pwd_ssidpassword',wpakey5G);           
			setText('txt_ssidpassword',wpakey5G);
		}
	}
}

var pskPsdModFlag = false;
var wep1PsdModFlag = false;

function InitGuestWifiInfo(wlanloop, radio)
{
    setText('ssidname', Wlan[wlanloop].SSID);
	setCheck('wlEnable', Wlan[wlanloop].enable);
	setCheck('displaypassword', 0); 
	
	var authMode = Wlan[wlanloop].BeaconType;
	beaconTypeChange(authMode,wlanloop); 
	
	$('#pwd_ssidpassword').bind("propertychange input", function(){ 
	if(getValue('pwd_ssidpassword') != "********") 
	{
		pskPsdModFlag = true;
	} 
	} );
		
	if(Wlan[wlanloop].SSIDAdvertisementEnabled == 1)
	{
		$("#swithicon").attr("src", "../../../images/checkon.jpg");
	}
	else
	{
		$("#swithicon").attr("src", "../../../images/checkoff.jpg");
	}
	

	if(('2.4GHz' == radio)||('2.4GHz/5GHz' == radio))
	{
		setText('ActivationTimeLimit', GuestWifi[0].Duration);
		setText('wlUpRate', GuestWifi[0].UpRateLimit);
		setText('wlDownRate', GuestWifi[0].DownRateLimit);
	}
	else
	{
		setText('ActivationTimeLimit', GuestWifi[1].Duration);
		setText('wlUpRate', GuestWifi[1].UpRateLimit);
		setText('wlDownRate', GuestWifi[1].DownRateLimit);
	}

	if(GuestWifiFlag == 0)
	{
		setText('StartIPaddress', "192.168.2.2");
		setText('EndIPaddress', "192.168.2.254"); 
	}
	else
	{
		setText('StartIPaddress', SlaveDhcpInfo[0].startIP);
		setText('EndIPaddress', SlaveDhcpInfo[0].endIP);
	
	}
}

function GetEnableGuestInst()
{
	return wlanloopMap['ath1'];
}

function EnableGuestWifi()
{
	if (0 == WlanEnable[0].enable) {
		setCheck('EnableGuestWifi',0); 
		setDisplay('GuestWifiInfo',0);
		AlertEx(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_checkradio']);
		return;
	}
	
	var GuestWifi5GSSID;
	var GuestWifi2GSSID;
	
	if(0 == getCheckVal('EnableGuestWifi'))
	{
		setDisplay('GuestWifiInfo',0);
	}
	else
	{
		setDisplay('GuestWifiInfo',1);
		AutoGenSsidAndKey();
	}
	isShowWlEnable();
}

function isWlanSame()
{

	if (DoubleWlanFlag != 1)
	{
		return false;
	}
	
	if(1 == IfAutoGen())
	{
		return true;
	}
	
	if (guestWifi2G.SSID != guestWifi5G.SSID)
	{
		return false;
	}
	
	if (guestWifi2G.enable != guestWifi5G.enable)
	{
		return false;
	}
	
	if (guestWifi2G.SSIDAdvertisementEnabled != guestWifi5G.SSIDAdvertisementEnabled)
	{
		return false;
	}
	
	if (guestWifi2G.BeaconType != guestWifi5G.BeaconType)
	{
		return false;
	}
	
	if ((guestWifi2G.BeaconType == 'Basic')|| (guestWifi5G.BeaconType == 'None'))
	{
		if (guestWifi2G.BasicAuthenticationMode != guestWifi5G.BasicAuthenticationMode 
			|| guestWifi2G.BasicEncryptionModes != guestWifi5G.BasicEncryptionModes)
		{
			return false;
		}
	}
	else if (guestWifi2G.BeaconType == 'WPA')
	{
		if (guestWifi2G.WPAAuthenticationMode != guestWifi5G.WPAAuthenticationMode)
		{	
			return false;
		}
	}
	else if ((guestWifi2G.BeaconType == '11i') || (guestWifi2G.BeaconType == 'WPA2'))
	{
		if (guestWifi2G.IEEE11iAuthenticationMode != guestWifi5G.IEEE11iAuthenticationMode)
		{	
			return false;
		}
	}
	else if ((guestWifi2G.BeaconType == 'WPAand11i') || (guestWifi2G.BeaconType == 'WPA/WPA2'))
	{
		if (guestWifi2G.X_HW_WPAand11iAuthenticationMode != guestWifi5G.X_HW_WPAand11iAuthenticationMode)
		{	
			return false;
		}
	}
	
	if ((guestWifi2G.BeaconType == 'WPA') || (guestWifi2G.BeaconType == '11i') || (guestWifi2G.BeaconType == 'WPA2')
		||(guestWifi2G.BeaconType == 'WPAand11i') || (guestWifi2G.BeaconType == 'WPA/WPA2'))
	{
		if (guestWifi2G.WPAAuthenticationMode == 'PSKAuthentication')
		{
			if (wpaPskKey[index2g].value != wpaPskKey[index5g].value)
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
		else 
		{	
			if (guestWifi2G.RadiusKey != guestWifi5G.RadiusKey)
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
	}
	
	if ((GuestWifi[0].Duration != GuestWifi[1].Duration)
		||(GuestWifi[0].UpRateLimit != GuestWifi[1].UpRateLimit)
		||(GuestWifi[0].DownRateLimit != GuestWifi[1].DownRateLimit))
	{
		return false;
	}
	
	return true;
}

function LoadGuestWifiInfo()
{
	if (((enable5G == 1) || (enable2G == 1)) && (WlanEnable[0].enable == 1))
	{
		setCheck('EnableGuestWifi',1);
		setDisplay('GuestWifiInfo',1);
	}
	else
	{
		setCheck('EnableGuestWifi',0);
		setDisplay('GuestWifiInfo',0);
	}
	
	if (isWlanSame())
	{
		setCheck('splitSSID', 0); 
	}
	else 
	{
		setCheck('splitSSID', 1); 
	}
	
	SplitSSID();
		
	if (DoubleWlanFlag == 1)
	{
		setDisplay('DivSplitSSID',1);
	}
	else
	{
		setDisplay('DivSplitSSID',0);
		setDisplay('splitDiv',0);
	}
}

function InitBroadEnable()
{
	var loopAth1 = wlanloopMap['ath1'];
	broadenable2g = WlanArr[loopAth1].SSIDAdvertisementEnabled;
	
	if (DoubleWlanFlag == 1)
	{
		var loopAth5 = wlanloopMap['ath5'];
		broadenable5g = WlanArr[loopAth5].SSIDAdvertisementEnabled;
	}
}

function GetPrivateSSID(athindex)
{
	for (var i = 0; i < Wlan.length; i++)
	{
		if(getWlanPortNumber(Wlan[i].name) == athindex)
		{
			if(Wlan[i].SSID.length > 26)
			{
				return Wlan[i].SSID.substring(0,26);
			}
			else
			{
				return Wlan[i].SSID;
			}
		}
	}
}

var wpakey2G;
var wpakey5G;
var guestrandomssid2G;
var guestrandomssid5G;

var DefaultKeyFlag = 0;

function GetDefaultKeyFlag()
{
	DefaultKeyFlag = '<%HW_WEB_GetKeyIsDefault();%>'; 
	if(1 == DefaultKeyFlag)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IfAutoGen()
{
	if((0 == GuestWifi[0].AutoGenFlag)
	&&(true == GetDefaultKeyFlag())
	&&(enable5G != 1)&&(enable2G != 1))
	{
		return true;
	}
	else
	{
		return false;
	}
}

var SetAutoGenFlag = 0;
function AutoGenSsidAndKey()
{
	if(1 == IfAutoGen())
	{
		SetAutoGenFlag = 1;
		guestrandomssid2G = GetPrivateSSID(0)+"-Guest";
		wpakey2G = '<%HW_WEB_GetRandomKey();%>';
		displayRandomSsidAndKey();
			
		if(1 == DoubleWlanFlag)
		{
			guestrandomssid5G = GetPrivateSSID(4)+"-Guest";
			wpakey5G = '<%HW_WEB_GetRandomKey();%>';
		}	
	}
}

function displayRandomSsidAndKey()
{
	setText('ssidname',guestrandomssid2G);
	setText('pwd_ssidpassword',wpakey2G);           
	setText('txt_ssidpassword',wpakey2G);
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

function psdStrength5(id)
{
	var checkid= "pwdvalue5";
	pwdStrengthcheck(id,checkid);
}

var showRadio = '2.4GHz';

function isShowWlEnable()
{
	if ((1 == getCheckVal('splitSSID')) && (1 == DoubleWlanFlag)) {
		setDisplay('TrWlEnable', 1);
		setDisable('wlEnable', 0);
	} else {
		setCheck('wlEnable', getCheckVal('EnableGuestWifi'));
		setDisplay('TrWlEnable', 0);
		setDisable('wlEnable', 1);
	}
}

function SplitSSID()
{
	if (1 == getCheckVal('splitSSID'))
	{
		setDisplay('splitDiv', 1);
		showGuestwifiInfo('2.4GHz');
	}
	else
	{
		setDisplay('splitDiv', 0);
		showGuestwifiInfo('2.4GHz/5GHz');
	}
	isShowWlEnable();
}

function switchTab(TableN)
{	
    for (var i = 1; i <= 2; i++)
    {
        if ("tab" + i == TableN) 
        {
            getElementById(TableN).style.backgroundColor = "#f6f6f6";
        }
        else
        {
            getElementById("tab" + i).style.backgroundColor = "";
        }
    }
	
	if ("tab1" == TableN)
    {
		showGuestwifiInfo('2.4GHz');
	}
    else
    {
		showGuestwifiInfo('5GHz');
    }
}

var IsNeedAdvancedSet = 0;
function OnAdvancedSet()
{
    IsNeedAdvancedSet = 1 - IsNeedAdvancedSet;
    setDisplay('DivAdvanceSet', IsNeedAdvancedSet);
}

function LoadFrame()
{
	$("#checkinfo5Row").css("display", "none");
	if (IsPtVdf ==1 || IsNos == 1)
	{
		var pwdcheck5 = document.getElementById('checkinfo5');
		pwdcheck5.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd5" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></span> </div></div>';
	}

	var loop = GetEnableGuestInst();
	LoadGuestWifiInfo();
	InitGuestWifiInfo(loop, '2.4GHz');
	displayPasswordEnable();
	InitBroadEnable();
}
</script>
</head>
<body class="mainbody" onload="LoadFrame();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("Guest WiFi", GetDescFormArrayById(cfg_wlanguestwifi_language, "amp_wlan_ptvdf_guestwifi_header"), GetDescFormArrayById(cfg_wlanguestwifi_language, "amp_wlan_ptvdf_guestwifi_tittle"), false);
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height5p"></td></tr>
</table>
<div id="GuestWifiDetail" >
	<div>
		<input type="checkbox" name="EnableGuestWifi" id="EnableGuestWifi" onclick="EnableGuestWifi()"; value="OFF"/>
		<script> document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_enable']);</script>
	</div>
	<div id="GuestWifiInfo" style = 'display:none'>
	<div id = 'DivSplitSSID' style = 'display:none;'>
		<input type='checkbox' name='splitSSID' id='splitSSID' onClick='SplitSSID();'/>
		<script>document.write(vdf_wlan_basic_language["amp_wlan_basic_split_ssid"]);</script>
	</div>
	<div id = 'splitDiv' style = 'display:none;'>
		<div>
			<table id="tableinfo" width="100%" height="100%" style="border-spacing: 0px;">
				<tr class="head_title">
					<td width="20%" id="tab1" onclick="switchTab('tab1');" style="background-color:#f6f6f6"><script>document.write('2.4G');</script></td>
					<td width="20%" id="tab2" onclick="switchTab('tab2');"><script>document.write('5G');</script></td>
				</tr>
			</table>
		</div>
	</div>	
	<table height="50" cellspacing="1" cellpadding="0" width="100%" border="0" class="tabal_noborder_bg">	
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script> document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_ssid']);</script></td>
			<td class="table_right width_per75">
				<label>
					<input type="text" name="ssidname" id="ssidname" class="tb_input" maxlength="32"/>
				</label>
				<font class="color_red">*</font>
			</td>
		</tr >
		<tr class="tabal_01" id="TrWlEnable">
          <td class="table_submit width_per25"><script> document.write(cfg_wlancfgdetail_language['amp_link_status']);</script></td>
          <td class="table_right width_per75">
			<label>
				<input type='checkbox' id='wlEnable' name='wlEnable' value="ON">
			</label>
		  </td>
        </tr>
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_security']);</script></td>
			<td class="table_right width_per75">
				<select name="wlAuthMode" id="wlAuthMode" onchange="funProtectionmodeSelect();">
				<script>
					document.write('<option value='+'wpa-psk'+'>' +"WPA"+'</option>');
					document.write('<option value='+'wpa2-psk'+'>' +"WPA2"+'</option>');
					document.write('<option value='+'wpa/wpa2-psk'+'>' +"WPA+WPA2"+'</option>');
					document.write('<option value='+'open'+'>' +"OPEN"+'</option>');
				</script>
				</select>
			</td>
		</tr >
		
		<tr id='wpakeyInfo' class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_password']);</script></td>
			<td class="table_right width_per75">	
				<input class="textbox" type='password' autocomplete='off' id='pwd_ssidpassword' name='pwd_ssidpassword' onchange="wpapskpassword=getValue('pwd_ssidpassword');getElById('txt_ssidpassword').value=wpapskpassword;"/>
			    <input class="textbox" type='text' id='txt_ssidpassword' name='txt_ssidpassword' maxlength='64' style='display:none' onchange="wpapskpassword=getValue('txt_ssidpassword');getElById('pwd_ssidpassword').value=wpapskpassword;"/>
				<script></script><font class="color_red">*</font>
				<input type="checkbox" name="displaypassword" id="displaypassword" value='on' onClick="ShowOrHideText('displaypassword', 'pwd_ssidpassword', 'txt_ssidpassword');"/>
				<script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_displaypassword']);</script>
			</td>
		</tr >

		<tr id = "checkinfo5Row" style="display:none;">
          <td id = "checkinfotite5" class="table_title width_per25" ><script>document.write(cfg_wlancfgdetail_language['amp_wpa_psk_strength']);</script></td>
		  <td id = "checkinfo5" class="table_title"></td>
			<script>		
			$('#pwd_ssidpassword').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo5Row").css("display", "");
					$("#psd_checkpwd5").css("display", "block");
					psdStrength5("pwd_ssidpassword");
				}
			});	
			$('#txt_ssidpassword').on('keyup',function(){
				if (PwdTipsFlag ==1)
				{
					$("#checkinfo5Row").css("display", "");
					$("#psd_checkpwd5").css("display", "block");
					psdStrength5("txt_ssidpassword");
				}
			});	
			</script>
        </tr>
		
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_broadcast']);</script></td>
			<td class="table_right width_per75">
			<div class="contentItem contentSwitchicon">
			<img height="20px;"  src="../../../images/checkon.jpg" id="swithicon" onClick='SetWifiBroadcastEnable();'/></div></td>
		</tr>
		</table>
		
		<div class="tabal_noborder_bg">
			<input type="button" id="AdvanceSetButtion" class="NewDelbuttoncss" onclick="OnAdvancedSet()">
			<script>
				getElementById('AdvanceSetButtion').value = cfg_wlanguestwifi_language['amp_guestwifi_advancedset'];
			</script>
			</input>
		</div>
		<div id = 'DivAdvanceSet' style='display:none;'>
		<table height="50" cellspacing="1" cellpadding="0" width="100%" border="0" class="tabal_noborder_bg">
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_time']);</script></td>
			<td class="table_right width_per75">
				<label>
					<input type="text" name="ActivationTimeLimit" id="ActivationTimeLimit" />
				</label><font class="color_red">*</font>
				 <script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_minutes']);</script>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_upspeed']);</script></td>
			<td class="table_right width_per75">
				<label>
					<input type="text" name="wlUpRate" id="wlUpRate" />
				</label><font class="color_red">*</font>
				<script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_speedcontext']);</script>
			</td>

		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_downspeed']);</script></td>
			<td class="table_right width_per75">
				<label>
					<input type="text" name="wlDownRate" id="wlDownRate" />
				</label><font class="color_red">*</font>
				<script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_speedcontext']);</script>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script> document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_startip']);</script></td>
			<td class="table_right width_per75">
				<label>
					<input type="text" name="StartIPaddress" id="StartIPaddress" />
				</label><font class="color_red">*</font>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per25"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_endip']);</script></td>
			<td class="table_right width_per75">
				<label>
					<input type="text" name="EndIPaddress" id="EndIPaddress" />
				</label><font class="color_red">*</font>
			</td>
		</tr >
	</table>
	</div>
	</div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
      <tr><td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr>
            <td class="table_submit width_per25"></td>
            <td class="table_submit">
              <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="btnApplySubmit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
              <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="cancelValue();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
            </td>
          </tr>
        </table>
        </td> 
      </tr>
    </table>
</div>

</body>
</html>
