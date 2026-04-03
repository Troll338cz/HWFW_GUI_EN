<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlanguestwifi_language, cfg_wlancfgdetail_language, cfg_wlancfgother_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>Guest WiFi</title>
<style>	
.TextBox_2
{
	width:63px;  
}
</style>		

<script language="JavaScript" type="text/javascript">
var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var DoubleWlanFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var ClassAIpSupportFlag='<%HW_WEB_GetFeatureSupport(BBSP_FT_SUPPORT_CLASS_A_IP);%>';
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

for(var i=0; i < GuestWifiArrLen; i++)
{
    GuestWifi[i] = new stGuestWifi();
    GuestWifi[i] = GuestWifiArr[i];
}

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

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|LowerLayers|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort|X_HW_Standard,stWlan);%>;
var WlanWifi = WlanArr[0];
if (null == WlanWifi)
{
    WlanWifi = new stWlanWifi("","","","","11n","","","","","");
}

var Wlan = new Array();
var wlanArrLen = WlanArr.length - 1;
for (i=0; i < wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}

function stPreSharedKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

var g_wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

var g_wepKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
if (null != g_wepKey)
{
    wep1password = g_wepKey[0];
    wep2password = g_wepKey[1];
    wep3password = g_wepKey[2];
    wep4password = g_wepKey[3];
}

function GuestPoolAddr(domain,enable,startIP,endIP,IpAddr,SubMask,LeaseTime)
{
	this.domain		= domain;
	this.enable		= enable;
	this.startIP    = startIP;
	this.endIP      = endIP;
	this.IpAddr  	= IpAddr;
	this.SubMask	= SubMask;
	this.LeaseTime	= LeaseTime;	
}
var GuestPoolInfo= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2,Enable|MinAddress|MaxAddress|IPRouters|SubnetMask|DHCPLeaseTime,GuestPoolAddr);%>;
function LanIpAddr(domain,enable,ipaddr,subnetmask)
{
	this.domain		= domain;
	this.enable		= enable;
	this.ipaddr		= ipaddr;
	this.subnetmask	= subnetmask;	
}
var LanIpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,LanIpAddr);%>;
if (LanIpInfos[1] == null)
{
    LanIpInfos[1] = new stipaddr("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2", "", "", ""); 
}
var MainDhcpServer ='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPServerEnable);%>';
function InitLeasedTime()
{
	var LeasedTimeIdArray = ["LeasedTimeUnit"];
	for(var i = 0; i < LeasedTimeIdArray.length; i++)
	{
		var LeasedTimeId = "#" + LeasedTimeIdArray[i];
		$(LeasedTimeId).append('<option value="60">'+ cfg_wlanguestwifi_language['bbsp_minute'] + '</option>');
		$(LeasedTimeId).append('<option value="3600">'+ cfg_wlanguestwifi_language['bbsp_hour'] + '</option>');	
		$(LeasedTimeId).append('<option value="86400">'+ cfg_wlanguestwifi_language['bbsp_day'] + '</option>');	
		$(LeasedTimeId).append('<option value="604800">'+ cfg_wlanguestwifi_language['bbsp_week'] + '</option>');
	}	
}
function setLease(dhcpLease)
{
    var i = 0;
    var timeUnits = 604800;
    var infinite = ((dhcpLease == "-1") || (dhcpLease == "4294967295"));
    for(i = 0; i < 4; i++)
    {
        if (i == 0 )
        {
            timeUnits  = 604800;
        }
        else if (i == 1)
        {
            timeUnits  = 86400;
        }
        else if (i == 2)
        {
            timeUnits  = 3600;
        }
        else
        {
            timeUnits  = 60;                    
        }
        if ( true == isInteger(dhcpLease / timeUnits) )
        {
            break; 
        }          
    }
  	setSelect('LeasedTimeUnit', timeUnits);
	if(infinite)
	{
		setText('LeasedTime', cfg_wlanguestwifi_language['bbsp_gstwfinfinitetime']);
	}
	else
	{
		setText('LeasedTime', dhcpLease /timeUnits);
	}
}
function checkLease(fieldPrompt,LeaseTime,Frag,resourceLangDes)
{
       var errmsg="";
       var field="";
       field=resourceLangDes[fieldPrompt];
       errmsg=new Array("bbsp_lease_invalid","bbsp_lease_num","bbsp_lease_outrange");
       if (LeaseTime == '')
       {
           AlertEx(field+resourceLangDes[errmsg[0]]);
           return false;
       }
      	if(!isInteger(LeaseTime) )
  		{
    	   AlertEx(field+resourceLangDes[errmsg[1]]);
           return false;
        }
        var lease=LeaseTime*Frag;
        if(lease<=0)
      	{
            AlertEx(field+resourceLangDes[errmsg[1]]);
            return false;
        }
        if((lease>604800*10))
      	{
      	    AlertEx(field+resourceLangDes[errmsg[2]]);
            return false;
      	}
        return true;
}
function CheckSartEndIp()
{
    var maninRoute  = LanIpInfos[0].ipaddr;
    var maninMask   = LanIpInfos[0].subnetmask;
	var guestwifiroute = getValue("HostIPaddress");
    var guestwifiMask   = getValue("HostSubMask");
	var IpArr = guestwifiroute.split('.');
    var Maskarr = guestwifiMask.split('.');
	var StartIp = (parseInt(IpArr[3]) & parseInt(Maskarr[3])) + 1;
	var EndIp = ((parseInt(IpArr[3])) | (255 - parseInt(Maskarr[3]))) - 1;
	var StartIpArr = IpArr[0] + '.' + IpArr[1] + '.' + IpArr[2] + '.' + StartIp;
	var EndIpArr = IpArr[0] + '.' + IpArr[1] + '.' + IpArr[2] + '.' + EndIp;
	if((1 == getCheckVal('EnableGuestWifi')) && (0 == MainDhcpServer))
	{
	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfcannotenable']);
   	   return false;
	}
	if (isValidIpAddress(guestwifiroute) == false) 
	{
	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfhostipinvalid']);
   	   return false;
	}
	if (isValidSubnetMask(guestwifiMask) == false) 
	{
	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfhostmaskinvalid']);
   	   return false;
	}
	if ((ClassAIpSupportFlag != 1) && (isMaskOf24BitOrMore(guestwifiMask) == false))
    {
      	AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfhostmaskinvalid']);
		return false;
    }
	if (isBroadcastIp(guestwifiroute, guestwifiMask) == true)
	{
	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfhostipinvalid']);
	   return false;
	}	
	if (true == isSameSubNet(guestwifiroute,guestwifiMask,maninRoute,maninMask))
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfroutepccw1'] +cfg_wlanguestwifi_language['bbsp_gstwfroutepccw2'] + maninRoute);
		return false;
	}
	if (isValidIpAddress(getValue("StartIPaddress")) == false) 
	{
	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
   	   return false;
	}
	if (isBroadcastIp(getValue("StartIPaddress"), guestwifiMask) == true)
	{
	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
	   return false;
	}
	if (false == isSameSubNet(getValue("StartIPaddress"),guestwifiMask,guestwifiroute,guestwifiMask))
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolpccw1'] + cfg_wlanguestwifi_language['bbsp_gstwfpoolpccw2'] + StartIpArr + '~' + EndIpArr);
		return false;
	}
	if (isValidIpAddress(getValue("EndIPaddress")) == false) 
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipinvalid']);
		return false;
	}
	if (isBroadcastIp(getValue("EndIPaddress"), guestwifiMask) == true)
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipinvalid']);
		return false;
	}
	if (false == isSameSubNet(getValue("EndIPaddress"),guestwifiMask,guestwifiroute,guestwifiMask))
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolpccw1'] + cfg_wlanguestwifi_language['bbsp_gstwfpoolpccw2'] + StartIpArr + '~' + EndIpArr);
		return false;
	}
	if (!(isEndGTEStart(getValue("EndIPaddress"), getValue("StartIPaddress")))) 
	{
		AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipgeqstartip']);
		return false;
	}
	return true;
}
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

function beaconTypeChange(authMode,wlanloop)
{
	if (authMode == 'Basic')
	{
		var BasicAuthenticationMode = Wlan[wlanloop].BasicAuthenticationMode;
		if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem'))
		{
			setDisplay('wpakeyInfo', 0);
            setDisplay('wepkeyInfo', 0);
		}
		else
        {
            setDisplay('wpakeyInfo', 0);
            setDisplay('wepkeyInfo', 1);

            var keyIndex = Wlan[wlanloop].KeyIndex;
            setText('wlKeys1', g_wepKey[wlanloop * 4 + (keyIndex - 1)].value);
            setText('twlKeys1', g_wepKey[wlanloop * 4 + (keyIndex - 1)].value);
        }

	}
	else
	{
            setDisplay("wpakeyInfo", 1);
			setDisplay('wepkeyInfo', 0);
            setText('pwd_ssidpassword',g_wpaPskKey[wlanloop].value); 
			setText('txt_ssidpassword',g_wpaPskKey[wlanloop].value);
            wpapskpassword = g_wpaPskKey[wlanloop].value; 
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


function LoadGuestWifiInfo()
{
	if(guestWlanEnable == 1)
	{
		setCheck('EnableGuestWifi',1);
		setDisplay('GuestWifiInfo',1);
		setDisplay('portIsolation',1);
		setDisplay('GuestWifiPoolInfo',1);
		
	}
	else
	{
		setCheck('EnableGuestWifi',0);
		setDisplay('GuestWifiInfo',0);
		setDisplay('portIsolation',0);
		setDisplay('GuestWifiPoolInfo',0);
	}
}

var pskPsdModFlag = false;
var wep1PsdModFlag = false;

var guestWlanEnable = 0;
var guestSsidInst = 2;
var guestWlanIdex = 0;

function GetEnableGuestInst()
{
    for (var loop = 0; loop < WlanArr.length - 1; loop++)
    {
        if (guestSsidInst == getWlanInstFromDomain(Wlan[loop].domain))
        {
            guestWlanIdex = loop;
            guestWlanEnable = Wlan[loop].enable;
        }
    }
}

function bindpwd(index)
{
	$('#pwd_ssidpassword').bind("propertychange input", function(){ 
		if(getValue('pwd_ssidpassword') != "********") 
		{
			pskPsdModFlag = true;
		} 
		} );
		
		$('#wlKeys1').bind("propertychange input", function(){ 
		var KeyBit = Wlan[index].EncrypBit;
		if (KeyBit == '104-bit')
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
}

function InitGuestWifiInfo()
{
    LoadGuestWifiInfo();

    //setText('ssidname', Wlan[guestWlanIdex].SSID);
    beaconTypeChange(Wlan[guestWlanIdex].BeaconType,guestWlanIdex); 
    bindpwd(guestWlanIdex);
	
	setText('ActivationTimeLimit', GuestWifi[0].Duration/60);

    if (1 == GuestWifi[0].PortIsolation)
    {
        setCheck('PortIsolationDisable', 0);
    }
    else
    {
        setCheck('PortIsolationDisable', 1);
    }

}

function displayPasswordEnable()
{
	if(0 == curUserType)
	{
		setCheck('displaypassword',0);
		setCheck('hidewlKeys',0);
		setDisable('displaypassword',1);
		setDisable('hidewlKeys',1);
	}
	else
	{
		setDisable('displaypassword',0);
		setDisable('hidewlKeys',0);
	}
}

function EnableGuestWifi()
{
	if(0 == getCheckVal('EnableGuestWifi'))
	{
		setDisplay('GuestWifiInfo',0);
		setDisplay('portIsolation',0);
		setDisplay('GuestWifiPoolInfo',0);
	}
	else
	{
		setDisplay('GuestWifiInfo',1);
		setDisplay('portIsolation',1);
		setDisplay('GuestWifiPoolInfo',1);
	}
}

function PortIsolationDisable()
{

}

function addPassword(Form)
{
    var beacontype = Wlan[guestWlanIdex].BeaconType;
    var EncryptionMode = Wlan[guestWlanIdex].BasicEncryptionModes;
	var pswpskpassword =  getValue('pwd_ssidpassword');
	if ((isFireFox4 == 1) && (pswpskpassword == ''))
	{
		pswpskpassword = wpapskpassword;
	}
	
	var wlKeys1 = getValue('wlKeys1');
	if ((isFireFox4 == 1) && (wlKeys1 == ''))
	{
		wlKeys1 = wep1password;
	}
	
	var KeyBit = Wlan[guestWlanIdex].EncrypBit;
	
	if((beacontype == 'Basic') && (EncryptionMode == 'WEPEncryption'))
	{	
		if (KeyBit == '104-bit')
		{
			if ( (wlKeys1 != "*************") || (wep1PsdModFlag == true)|| (1 == curUserType) )
			{
				Form.addParameter('m' + '.WEPKey', wlKeys1);
			}
		}
		else
		{
			if ( (wlKeys1 != "*****") || (wep1PsdModFlag == true) || (1 == curUserType))
			{
				Form.addParameter('m' + '.WEPKey', wlKeys1);
			}
		}
	}
    
	if('WPA' == beacontype || '11i' == beacontype || 'WPAand11i' == beacontype)
	{
		if ((pswpskpassword != "********") || (pskPsdModFlag == true) || (1 == curUserType))
		{
			Form.addParameter('k' + '.PreSharedKey', pswpskpassword);
		}  
	}
}

function checkPassword(ssidindex, wepid, pskid)
{
	var beacontype = Wlan[guestWlanIdex].BeaconType;
    var EncryptionMode = Wlan[guestWlanIdex].BasicEncryptionModes;
    var AuthMode = Wlan[guestWlanIdex].BasicAuthenticationMode;
    
	if ((beacontype == 'WPA') || (beacontype == '11i') || (beacontype == 'WAPadn11i'))
	{
		var PskKey = getValue('txt_ssidpassword');

        if (false == isValidWPAPskKey(PskKey))
		{
			AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
			return false;
		}
	}

	if (beacontype == 'Basic' && beacontype == 'WEPEncryption')
	{
		var val = getValue('twlKeys1');
		var KeyBit = Wlan[guestWlanIdex].EncrypBit;
        
		if ( val != '' && val != null)
		{ 
			if ( KeyBit == '104-bit' )
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
}

function addWifiParas(Form)
{
	var STAIsolutionEnable = 1;

    if (1 == getCheckVal('PortIsolationDisable'))
    {
        STAIsolutionEnable = 2;
    }

	addPassword(Form);

	Form.addParameter('x' + '.Enable', getCheckVal('EnableGuestWifi'));

	Form.addParameter('n' + '.SSID_IDX', guestSsidInst);
	Form.addParameter('n' + '.Duration', parseInt(getValue('ActivationTimeLimit'),10) * 60);
	
	Form.addParameter('n' + '.PortIsolation', STAIsolutionEnable);
	
}

function ActivationTimeCheck()
{
	var duration = getValue('ActivationTimeLimit');
	
	if (isPlusInteger(duration) == false || parseInt(duration,10) < 24 || parseInt(duration,10) > 168)
	{
		return false;
	}
	
	return true;
}

function btnApplySubmit()
{
	if(false == checkPassword()) 
	{
		return;
	}

	if(false == ActivationTimeCheck())
	{
		AlertEx("Invalid Activation time limit.");
		return;
	}

	var Form = new webSubmitForm(); 
	
	addWifiParas(Form);
	if (GuestPoolInfo[0] != null)
	{
		if(false == CheckSartEndIp())
		{
			return false;
		}
		var timeLease = getValue('LeasedTime');
		if (false == checkLease("bbsp_gstwfpool",timeLease,getSelectVal('LeasedTimeUnit'),cfg_wlanguestwifi_language))
		{
			return false;
		}
		if(1 == getCheckVal('EnableGuestWifi'))
		{
			Form.addParameter('Pool_y.Enable', '1');
			Form.addParameter('Pool_y.IPInterfaceIPAddress', getValue('HostIPaddress'));
			Form.addParameter('Pool_y.IPInterfaceSubnetMask', getValue('HostSubMask'));
			Form.addParameter('Pool_w.Enable', '0');
			Form.addParameter('Pool_w.MinAddress', getValue('HostIPaddress'));
			Form.addParameter('Pool_w.MaxAddress', getValue('HostIPaddress'));
			Form.addParameter('Pool_z.Enable', '1');
			Form.addParameter('Pool_z.MinAddress', getValue('StartIPaddress'));
			Form.addParameter('Pool_z.MaxAddress', getValue('EndIPaddress'));
			Form.addParameter('Pool_z.IPRouters',  getValue('HostIPaddress'));
			Form.addParameter('Pool_z.SubnetMask', getValue('HostSubMask'));
			Form.addParameter('Pool_z.DHCPLeaseTime', getValue('LeasedTime')*getValue('LeasedTimeUnit'));
			Form.addParameter('Pool_z.X_HW_Description',"guestwifi");
			Form.addParameter('Pool_z.PoolOrder',"1");		
		}
		else
		{
			Form.addParameter('Pool_y.Enable', '0');
			Form.addParameter('Pool_z.Enable', '0');
		}
		LANHostURL = '&Pool_y=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2' 
					+'&Pool_w=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1'
					+'&Pool_z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2';		
	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    var beacontype = Wlan[guestWlanIdex].BeaconType;
    var EncryptionMode = Wlan[guestWlanIdex].BasicEncryptionModes;
    if ((beacontype == 'Basic') && (EncryptionMode == 'WEPEncryption')) {
        Form.setAction('set.cgi?'
                        + '&x=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + guestSsidInst
                        + '&n=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1'
                        + '&k=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ guestSsidInst+ '.PreSharedKey.1'
                        + '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + guestSsidInst + '.WEPKey.1'
                        + LANHostURL
                        + '&RequestFile=html/amp/wlanbasic/OSKGuestWifi.asp');
    } else {
        Form.setAction('set.cgi?'
                        + '&x=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + guestSsidInst
                        + '&n=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1'
                        + '&k=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.'+ guestSsidInst+ '.PreSharedKey.1'
                        + LANHostURL
                        + '&RequestFile=html/amp/wlanbasic/OSKGuestWifi.asp');
    }

	Form.submit();
	setDisable('btnApplySubmit', 1);	
}
function InitBbspGuestWifiInfo()
{	
	setText('HostIPaddress', LanIpInfos[1].ipaddr);
	setText('HostSubMask', LanIpInfos[1].subnetmask);
	if (GuestPoolInfo[0] == null)
	{
			setDisable('HostIPaddress', 1);
			setDisable('HostSubMask', 1);
			setDisable('StartIPaddress', 1);
			setDisable('EndIPaddress', 1);	
			setDisable('LeasedTime', 1);
			setDisable('LeasedTimeUnit', 1);			
	}
	else
	{
		setText('StartIPaddress', GuestPoolInfo[0].startIP);
		setText('EndIPaddress', GuestPoolInfo[0].endIP);
		setLease(GuestPoolInfo[0].LeaseTime);
	}
}

function LoadFrame()
{
	InitBbspGuestWifiInfo();
    GetEnableGuestInst();
    InitGuestWifiInfo();
    displayPasswordEnable();
}

function cancelValue()
{
	LoadFrame();
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
	<tr width="100%" border="0" cellpadding="0" cellspacing="0" >
		<td>
			<input type="checkbox" name="EnableGuestWifi" id="EnableGuestWifi" onclick="EnableGuestWifi()"; value="OFF"/>
			<script> document.write(cfg_wlanguestwifi_language['amp_pccw_guestwifi_enable']);</script>
		</td>
	</tr >	
	<table id="GuestWifiInfo" height="50" cellspacing="1" cellpadding="0" width="100%" border="0" class="tabal_noborder_bg">	
	
		<tr class="tabal_01">
			<td class="table_submit width_per30"><script> document.write(cfg_wlanguestwifi_language['amp_osk_guestwifi_name']);</script></td>
			<td class="table_right width_per70">
				<script language="javascript">
					for (var i = 0; i < WlanArr.length - 1; i++)
					{
						if (2 == getWlanInstFromDomain(Wlan[i].domain))
						{
							document.write(Wlan[i].SSID);
						}
					}	
				</script>
			</td>
		</tr >
				
		<tr name="wepkeyInfo" id='wepkeyInfo' class="tabal_01">	
			<td class="table_submit width_per30"><script>document.write(cfg_wlanguestwifi_language['amp_osk_guestwifi_apwd']);</script>
				<td class="table_right width_per70">
					<script language="JavaScript" type="text/javascript">
						if (g_wepKey[0] != null)
						{
							document.write("<input type='password' autocomplete='off' id='wlKeys1' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_wepKey[4].value) + "'>")
							document.write("<input type='text' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none;'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_wepKey[4].value) + "'>");
						}
					</script>
			    <input type='checkbox' id='hidewlKeys' name='hidewlKeys' value='on' onClick="ShowOrHideText('hidewlKeys', 'wlKeys1', 'twlKeys1');"/>
				<script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_displaypassword']);</script>
				</td>
			</td>
		</tr >
		
		<tr id='wpakeyInfo' class="tabal_01">
			<td class="table_submit width_per30"><script>document.write(cfg_wlanguestwifi_language['amp_osk_guestwifi_apwd']);</script></td>
			<td class="table_right width_per70">	
				<input class="textbox" type='password' autocomplete='off' id='pwd_ssidpassword' name='pwd_ssidpassword' onchange="wpapskpassword=getValue('pwd_ssidpassword');getElById('txt_ssidpassword').value=wpapskpassword;"/>
			    <input class="textbox" type='text' id='txt_ssidpassword' name='txt_ssidpassword' maxlength='64' style='display:none' onchange="wpapskpassword=getValue('txt_ssidpassword');getElById('pwd_ssidpassword').value=wpapskpassword;"/>
				<script></script>
				<input type="checkbox" name="displaypassword" id="displaypassword" value='on' onClick="ShowOrHideText('displaypassword', 'pwd_ssidpassword', 'txt_ssidpassword');"/>
				<script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_displaypassword']);</script>
			</td>
		</tr >
		
		<tr class="tabal_01">
			<td class="table_submit width_per30"><script>document.write(cfg_wlanguestwifi_language['amp_pccw_guestwifi_time']);</script></td>
			<td class="table_right width_per70">
				<label>
					<input type="text" name="ActivationTimeLimit" id="ActivationTimeLimit" />
				</label>
				 <script>document.write(cfg_wlanguestwifi_language['amp_osk_guestwifi_hours']);</script>
			</td>

		</tr >
	</table>
	
	<div id="portIsolation">
		<tr width="100%" border="0" cellpadding="0" cellspacing="0" >
			<td>
				<input type="checkbox" name="PortIsolationDisable" id="PortIsolationDisable" onclick=""; value="OFF"/>
				<script> document.write(cfg_wlanguestwifi_language['amp_osk_guestwifi_StaIsolution']);</script>
			</td>
		</tr >	
	</div>
	
	<table id="GuestWifiPoolInfo" height="50" cellspacing="1" cellpadding="0" width="100%" border="0" class="tabal_noborder_bg">
	<tr class="tabal_01">
			<td class="table_submit width_per30"><script> document.write("Host IP Address");</script></td>
			<td class="table_right width_per70">
				<label>
					<input type="text" name="HostIPaddress" id="HostIPaddress" />
				</label><font class="color_red">*</font>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per30"><script> document.write("Host Subnet Mask");</script></td>
			<td class="table_right width_per70">
				<label>
					<input type="text" name="HostSubMask" id="HostSubMask" />
				</label><font class="color_red">*</font>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per30"><script> document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_startip']);</script></td>
			<td class="table_right width_per70">
				<label>
					<input type="text" name="StartIPaddress" id="StartIPaddress" />
				</label><font class="color_red">*</font>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per30"><script>document.write(cfg_wlanguestwifi_language['amp_wlan_ptvdf_guestwifi_endip']);</script></td>
			<td class="table_right width_per70">
				<label>
					<input type="text" name="EndIPaddress" id="EndIPaddress" />
				</label><font class="color_red">*</font>
			</td>
		</tr >
		<tr class="tabal_01">
			<td class="table_submit width_per30"><script> document.write("Lease Time");</script></td>
			<td class="table_right width_per70">				
					<input type="text" name="LeasedTime" id="LeasedTime" class="TextBox_2"/>
					<select id='LeasedTimeUnit'>
					</select>
					<font class="color_red">*</font>
			</td>
		</tr >
	</table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
      <tr><td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr>
            <td class="table_submit width_per30"></td>
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
<script language="JavaScript" type="text/javascript">
InitLeasedTime();
</script> 
</body>
</html>
