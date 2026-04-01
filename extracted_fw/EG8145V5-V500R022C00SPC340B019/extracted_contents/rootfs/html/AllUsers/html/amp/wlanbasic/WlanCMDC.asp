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
var possibleChannels = "";
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var telmexSpan = false;
var urlNode = "";
var Form = null;

var hide = cfg_wlancfgdetail_language['amp_bcastssid_help'];
var wmm = cfg_wlancfgdetail_language['amp_vmm_help'];
var authmode = cfg_wlancfgdetail_language['amp_authmode_help'];
var encryption = cfg_wlancfgdetail_language['amp_encrypt_help'];
var ssid = cfg_wlancfgdetail_language['amp_ssid_help'];
var deviceNumber = cfg_wlancfgdetail_language['amp_devnum_help'];
var posswordComplexTitle = cfg_wlancfgdetail_language['amp_wlanpasswordcomplex_title'];
var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';
var MngtJsCmcc = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCMCC);%>';
var ShowISPSsidFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SHOW_ISPSSID);%>';

function GetLanguageDesc(Name)
{
    return cfg_wlancfgdetail_language[Name];
}

var prefix = 'PLDTHOMEFIBR';
var preflag = 0;
if ('PLDT' == CfgMode.toUpperCase())
{
    preflag = 1;
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

var Wlan11acFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_11AC);%>';
var BjcuFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_BJCU);%>';
var WapiFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WAPI);%>';
var FobidChannel5G = '<%HW_WEB_GetFeatureSupport(AMP_FT_WLAN_FOBID_CHANNEL_5G);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';

var CfgMode ='<%HW_WEB_GetCfgMode();%>';

var wlanpage;
if (location.href.indexOf("WlanCMDC.asp?") > 0)
{
    wlanpage = location.href.split("?")[1]; 
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

function stIndexMapping(index,portIndex)
{
    this.index = index;
    this.portIndex = portIndex;
}

function stWifi(domain,dtimPeriod,beaconPeriod,rtsThreshold,fragThreshold)
{
    this.domain = domain;
    this.dtimPeriod = dtimPeriod;
    this.beaconPeriod = beaconPeriod;
}

function stWlanWifi(domain,name,enable,ssid,mode,channel,power,Country,AutoChannelEnable,X_HW_HT20,PossibleChannels,wmmEnable)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.mode = mode;
    this.channel = AutoChannelEnable=="1"?0:channel;
    this.power = power;
    this.RegulatoryDomain = Country;
    this.AutoChannelEnable = AutoChannelEnable;
    this.X_HW_HT20 = X_HW_HT20;
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

var SsidNum = '<%HW_WEB_GetSsidNum();%>';
var SsidNum2g = SsidNum.split(',')[0];
var SsidNum5g = SsidNum.split(',')[1];
var SsidPerBand = '<%HW_WEB_GetSPEC(AMP_SPEC_SSID_NUM_MAX_BAND.UINT32);%>';

var enbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';
var radioEnabled = enbl & enbl2G;
if ( (1 == DoubleFreqFlag) && ('5G' == wlanpage) )
{
	radioEnabled = enbl & enbl5G;
}
		
var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_AssociateNum|WMMEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort,stWlan);%>;

var wlanArrLen = WlanArr.length - 1;

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

var ChannelWidth= '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_CHANNEL_WIDTH);%>';
var WlanModeN = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN_MODE_N);%>';

var ssidIdx = -1;
var ssidAccessAttr = 'Subscriber';
var AddFlag = true;
var currentWlan = new stWlan();
var basic5GIfIndex = SsidPerBand;

function wlanSetSelect(id, val)
{
	var ret = setSelect(id, val);

	if(false == ret)
	{
		var obj = $('#'+id);
		if(obj.length>0 && val!='')
		{
			obj.append("<option value='"+val+"'>"+val+"</option>");
			setSelect(id, val);
		}
	}
	
	if(id == 'wlKeyBit')
	{
		wlKeyBitChange();
	}
}
function wlanGetSelect(id, initVal)
{
	var selVal = getSelectVal(id);

	if(null == initVal)
		return selVal;
	else
		return selVal!="" ? selVal : initVal;
}

function getWlanPortNumber(name)
{
    var length = name.length;
    var number;
    var str = parseInt(name.charAt(length-1));
    return str;
}

var Wifis = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AdvanceConf,DtimPeriod|BeaconPeriod|RTSThreshold|FragThreshold,stWifi);%>;
var Wifi = null;

var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|PossibleChannels|WMMEnable,stWlanWifi);%>;
var WlanWifi = null;

var WlanMap = new Array();
for (var i = 0; i < Wlan.length; i++)
{
    var index = getWlanPortNumber(Wlan[i].name);
    var wlanInst = getWlanInstFromDomain(Wlan[i].domain);
 
    if ( (1 == isSsidForIsp(wlanInst) && 1 != MngtJsCmcc) 
    		|| ('' == Wlan[i].name)
    		|| ( (1 == DoubleFreqFlag) && 
    				( ("5G" == wlanpage && index < 4) 
    					|| ("2G" == wlanpage && index >= 4) ) ) )
    {
         continue;
    }
    else
    {
       WlanMap.push(new stIndexMapping(i,index));
    }
}

if(WlanMap.length > 0)
{
	WlanMap.sort(function(s1, s2)
	    {
	        return s1.portIndex - s2.portIndex;
	    }
	);
	
	ssidIdx = WlanMap[0].index;
	Wifi = Wifis[WlanMap[0].index];
	WlanWifi = WlanWifiArr[WlanMap[0].index];
}

if (null == Wifi)
{
    Wifi = new stWifi("1","100","2346","2346");
}

if (null == WlanWifi)
{
    WlanWifi = new stWlanWifi("","","","","11n","","","","","","");
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
	var mode = wlanGetSelect('X_HW_Standard', WlanWifi.mode);
	var auth = getSelectVal('wlAuthMode');
	
    var authModes = new Array(['open', cfg_wlancfgdetail_language['amp_auth_open'], 1], 
                              ['shared', cfg_wlancfgdetail_language['amp_auth_shared'], 1], 
                              ['wpa-psk', cfg_wlancfgdetail_language['amp_auth_wpapsk'], 1], 
                              ['wpa2-psk', cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1], 
                              ['wpa/wpa2-psk', cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], 1], 
                              ['wpa', cfg_wlancfgdetail_language['amp_auth_wpa'], 1], 
                              ['wpa2', cfg_wlancfgdetail_language['amp_auth_wpa2'], 1], 
                              ['wpa/wpa2', cfg_wlancfgdetail_language['amp_auth_wpawpa2'], 1],
                              ['wapi-psk', cfg_wlancfgdetail_language['amp_auth_wapi_psk'], 1], 
                              ['wapi', cfg_wlancfgdetail_language['amp_auth_wapi'], 1]);

	if ( (mode == "11n") || (1 == TelMexFlag) || (mode == "11ac") )
	{
		authModes[1][2] = 0;
	}
	
	if(1 != WapiFlag)
    {
    	authModes[8][2] = 0;
    	authModes[9][2] = 0;
    }

	InitDropDownList('wlAuthMode', authModes, auth);
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

function addEncryMethodOption(type1,type2)
{
    var len = document.forms[0].wlEncryption.options.length;
    var mode = wlanGetSelect('X_HW_Standard', WlanWifi.mode);
    var encryMode = getSelectVal('wlEncryption');

    $('#wlEncryption').empty();
    
    if ((type1 == 0) && (type2 == 0))
    {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
        
        if ((mode != "11n") && (mode != "11ac") && (1 == wepCap))
        {
            document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
        }        
    }
    else if ((type1 == 0) && (type2 == 1))
    {        
        if ((mode != "11n") && (mode != "11ac") && (1 == wepCap))
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");             
        }           
    }
    else
    {
		document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");        
        if (mode != "11n")
        {
            document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
            document.forms[0].wlEncryption[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
        }           
    }

    setSelect('wlEncryption', encryMode);
}

function stInitOption(value, innerText)
{
	this.value = value;
	this.innerText = innerText;
}

function InitDropDownList(id, valueTextPair, selected)
{
	var obj = $('#' + id);
	if(0==obj.length || null==valueTextPair)
	{
		return ;
	}

	var isSelectedValid = false;

	obj.empty();
	
	$.each(valueTextPair, function(index, entry){
	
			if((2 == entry.length) || (1 == entry[2]))
			{
				obj.append("<option value='" + entry[0] + "'>" + entry[1] + "</option>");
				
				if(!isSelectedValid && selected==entry[0])
		        {
		        	isSelectedValid = true;
		        	setSelect(id, selected);
		        }
			}
		});

	if(!isSelectedValid)
	{
		if('X_HW_Standard' == id)
		{
			X_HW_StandardChange();
		}
	}
}

function InitTransmitPowerList(id)
{
	var ArrayTransmitPower = null;
	
	if(1 == TelMexFlag)
	{
        if ('SPANISH' == curLanguage.toUpperCase())
        {
            ArrayTransmitPower = new Array(["100","Máxima"], ["75","Alto"], ["50","Medio"], ["25","Bajo"]);
        }
        else
        {
            ArrayTransmitPower = new Array(["100","Maximum"], ["75","High"], ["50","Mid"], ["25","Low"]);
        }
	}
    else
	{
        ArrayTransmitPower = new Array(["100","100%"], ["80","80%"], ["60","60%"], ["40","40%"], ["20","20%"]);
	}    

    InitDropDownList(id, ArrayTransmitPower, WlanWifi.power);
}

function InitRegulatoryDomainList(id)
{
	var countryCode = null;
	var ArrayRegulatoryDomain = new Array();
	
    if(1 == DoubleFreqFlag)
	{
		countryCode = new Array("AL", "DZ", "AR", "AU", "AT", "AZ", "BH", "BY", "BE", "BA", "BR", "BN", "BG", "CA", "CL", "CN", "CO", "CR", "HR", "CY", "CZ", "DK", "DO", "EC", "EG", "SV", "EE", "FK", "FI", "FR", "GE", "DE", "GR", "GT", "HN", "HK", "HU", "IS", "IN", "ID", "IR", "IE", "IL", "IT", "JM", "JP", "JO", "KZ", "KE", "KW", "LV", "LB", "LR", "LI", "LT", "LU", "MO", "MK", "MY", "MT", "MX", "MC", "MA", "NP", "NL", "AN", "NZ", "NI", "NO", "OM", "PK", "PA", "PG", "PY", "PE", "PH", "PL", "PT", "PR", "QA", "RO", "RU", "SA", "SG", "SK", "SI", "ZA", "ES", "LK", "SE", "CH", "SY", "TW", "TH", "TT", "TN", "TR", "UA", "AE", "GB", "US", "UY", "VE", "VN", "ZW");
	}else
	{
		countryCode = new Array("AL", "DZ", "AR", "AM", "AU", "AT", "AZ", "BH", "BY", "BE", "BZ", "BO", "BA", "BR", "BN", "BG", "CA", "CL", "CN", "CO", "CR", "HR", "CY", "CZ", "DK", "DO", "EC", "EG", "SV", "EE", "FK", "FI", "FR", "GE", "DE", "GR", "GT", "HN", "HK", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IL", "IT", "JM", "JP", "JO", "KZ", "KE", "KW", "LV", "LB", "LR", "LI", "LT", "LU", "MO", "MK", "MY", "MT", "MX", "MC", "MA", "NP", "NL", "AN", "NZ", "NI", "NO", "OM", "PK", "PA", "PG", "PY", "PE", "PH", "PL", "PT", "PR", "QA", "RO", "RU", "SA", "SG", "SK", "SI", "ZA", "ES", "LK", "SE", "CH", "SY", "TW", "TH", "TT", "TN", "TR", "UA", "AE", "GB", "US", "UY", "UZ", "VE", "VN", "YE", "ZW");
    }

	$.each(countryCode, function(index, value) { 
			ArrayRegulatoryDomain.push([value, cfg_wlanzone_language['amp_wlanzone_'+value]]); 
		}); 

    if (IsCaribbeanReg())
    {
        var insertpos = 0;

   		for (i = 0; i < ArrayRegulatoryDomain.length; i++)
    	{
        	if (ArrayRegulatoryDomain[i][0]== "CA")
        	{
        		insertpos = i + 1;
				break;
        	}
   		}

		if (insertpos == 0)
		{
			insertpos = ArrayRegulatoryDomain.length;
		}
		
        ArrayRegulatoryDomain.splice(insertpos, 0, ["CB", cfg_wlanzone_language['amp_wlanzone_CB']] );
    }

    InitDropDownList(id, ArrayRegulatoryDomain, WlanWifi.RegulatoryDomain);
}

function wmmClick()
{
	InitX_HW_Standard();
}

function checkStandardByEncry()
{
	InitX_HW_Standard();
}

function checkEncryByStandard()
{
	var authMode = getSelectVal('wlAuthMode'); 
	switch(authMode)
	{
	case 'open':
		addEncryMethodOption(0,0);
		break;
	case 'shared':
		addEncryMethodOption(0,1);
		break;
	default:
		addEncryMethodOption(1,0);
		break;
	}
}

function InitX_HW_Standard()
{  
    var isshow11n = 0;    
    var isshow11ac = 0;	   
    var mode = wlanGetSelect('X_HW_Standard', WlanWifi.mode);

	$.each(WlanMap, function(index, wlanInst){

		if(ssidIdx == wlanInst.index)
		{
			return true;
		}

		wlanInst = Wlan[wlanInst.index];
		var BeaconType = wlanInst.BeaconType;    
        var BasicEncryptionModes = wlanInst.BasicEncryptionModes;       
        var WPAEncryptionModes  = wlanInst.WPAEncryptionModes;
        var IEEE11iEncryptionModes = wlanInst.IEEE11iEncryptionModes;
        var X_HW_WPAand11iEncryptionModes = wlanInst.X_HW_WPAand11iEncryptionModes;

        if ((BeaconType == "Basic") && (BasicEncryptionModes == "WEPEncryption"))
        {
           isshow11n = 1;
           isshow11ac =1;
        }
       
        else if ((BeaconType =="WPA" )
                   && ((WPAEncryptionModes == "TKIPEncryption")||(WPAEncryptionModes == "TKIPandAESEncryption")))
        {
           isshow11n = 1;           
        }
       
        else if ( ((BeaconType =="11i" ) || (BeaconType =="WPA2") )
                   && ((IEEE11iEncryptionModes == "TKIPEncryption")||(IEEE11iEncryptionModes == "TKIPandAESEncryption")) )
        {
           isshow11n = 1;           
        }
       
        else if ( ((BeaconType =="WPAand11i" ) || (BeaconType =="WPA/WPA2") )
                   && ((X_HW_WPAand11iEncryptionModes == "TKIPEncryption")||(X_HW_WPAand11iEncryptionModes == "TKIPandAESEncryption")))
        {
           isshow11n = 1;           
        }
        
        if (0 == wlanInst.wmmEnable)
        {
            isshow11n = 1;
        }
	});
	
	var encryType = getSelectVal('wlEncryption');
    if('WEPEncryption' == encryType)
    {
    	isshow11n = 1;
        isshow11ac = 1;
    }
    else if(('TKIPEncryption' == encryType) || ('TKIPandAESEncryption' == encryType))
    {
    	isshow11n = 1;
    }

    if (0 == getCheckVal('enableWmm'))
    {
        isshow11n = 1;
    }

    var modeArr = null;

    if ("5G" == wlanpage)
    {
    	modeArr = new Array(["11a", "802.11a", 1], ["11n", "802.11n", 1], ["11na", "802.11a/n", 1], 
    		          ["11ac", "802.11a/n/ac", 0]);

		if(isshow11n > 0) { modeArr[1][2] = 0; } 
		
		if ((1 == Wlan11acFlag) && (0 == isshow11ac)) { modeArr[3][2] = 1; } 
		
		if(1 == WlanModeN)
		{
		    modeArr[0][2] = 0;
			modeArr[1][2] = 0;
			modeArr[2][2] = 0;
		}
		
    }
    else
    {
    	modeArr = new Array(["11b", "802.11b", 1], ["11g", "802.11g", 1], ["11n", "802.11n", 1], 
    		          ["11bg", "802.11b/g", 1], ["11gn", "802.11g/n", 0], ["11bgn", "802.11b/g/n", 1]);

		if(isshow11n > 0) { modeArr[2][2] = 0; }
		
		if('ANTEL' == CfgMode.toUpperCase())
		{
			modeArr[1][2] = 0;
			modeArr[2][2] = 0;
		}
		else if(1 == WlanModeN)
		{
			modeArr[0][2] = 0;
			modeArr[1][2] = 0;
			modeArr[3][2] = 0;
			modeArr[4][2] = 1;
			modeArr[5][2] = 1;
		}
    }
    
	InitDropDownList('X_HW_Standard', modeArr, mode);
}

function X_HW_StandardChange()
{
    var mode = wlanGetSelect('X_HW_Standard', WlanWifi.mode);
    var channelWidthRestore = wlanGetSelect('X_HW_HT20', WlanWifi.X_HW_HT20);
    var channel = wlanGetSelect('Channel', WlanWifi.channel);
    var country = wlanGetSelect('RegulatoryDomain', WlanWifi.RegulatoryDomain);

    if ((14 == channel) && ("11b" != mode))
    {
        wlanSetSelect('Channel', 0);
    }

    setDisable('enableWmm', ("11n" == mode));

    $('#X_HW_HT20').empty();

    if ((mode == "11b") || (mode == "11g") || (mode == "11bg") || (mode == "11a"))
    {    
        document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
    }
    else
    {
        if (CfgMode.toUpperCase() == 'ANTEL')
        {
            document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
        }
        else
        {
            document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            document.forms[0].X_HW_HT20[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
        }
        
        if ( (1 == Wlan11acFlag) && (1 == DoubleFreqFlag) && ("5G" == wlanpage) && (mode == "11ac") )
        {
            if (country != "RU")
            {
                document.forms[0].X_HW_HT20[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");			
            }
        }

        if ((3 != channelWidthRestore) || (mode == "11ac"))
        {
            wlanSetSelect('X_HW_HT20', channelWidthRestore);
        }
        else
        {
            wlanSetSelect('X_HW_HT20', 0);
        }
    }

	var width = getValue('X_HW_HT20');
    loadChannelList(country, mode, width);
    
    checkEncryByStandard();
}

function InitWlanBasicDropDownList()
{
	InitRegulatoryDomainList("RegulatoryDomain");
	InitTransmitPowerList("wlTxPwr");
	
	InitX_HW_Standard();

	X_HW_StandardChange();
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
            wlanSetSelect('wlWPSMode','AP-PIN');
            setDisplay('wpsPBCButton',0);
            setDisplay('wpsAPPinNumVal',1);
            setDisplay('wpsPinNumVal',0);
            setText('wlSelfPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
        else
        {
            wlanSetSelect('wlWPSMode','PIN');
            setDisplay('wpsPBCButton',0);
            setDisplay('wpsPinNumVal',1);
            setDisplay('wpsAPPinNumVal',0);
            setText('wlClientPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
    }
    else
    {
        wlanSetSelect('wlWPSMode','PBC');
        
        if (getSelectVal('wlWPSMode') == 'PBC')
        {
            wlanSetSelect('wlWPSMode','PBC');
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
            wlanSetSelect('wlWPSMode','AP-PIN');
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
    var mode = wlanGetSelect('X_HW_Standard', WlanWifi.mode);
    
    switch (authMode)
    {
        case 'open':
            setDisplay('wlEncryMethod',1);             
            addEncryMethodOption(0,0);            

            wlanSetSelect('wlEncryption',Wlan[ssidIdx].BasicEncryptionModes);
            if ((Wlan[ssidIdx].BasicEncryptionModes == 'None') || (mode == '11n'))
            {
                setDisplay('keyInfo', 0);
            }
            else
            {      
            	setDisplay('keyInfo', 1); 
            }
            
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            wlanSetSelect('wlKeyBit', parseInt(level)+24);
            
            if (1 == TelMexFlag)
            {
                keyIndexChange(Wlan[ssidIdx].KeyIndex);
            }
            
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

            break;
            
        case 'shared':
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            
            if (mode == "11n")
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
            
                if (1 == TelMexFlag)
                {
                  keyIndexChange(Wlan[ssidIdx].KeyIndex);
                }
            
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
            
            displayWpsConfig();
            
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

            wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
            break;
        case 'wapi':
            setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
            setDisable('wlEncryption',1);
            setDisplay('wlWapi',1); 
            setText('wapiIPAddr',Wlan[ssidIdx].X_HW_WAPIServer);
            setText('wapiPort',Wlan[ssidIdx].X_HW_WAPIPort);
            wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
            break;
        default:
            break;
    }

    checkStandardByEncry();
} 


function onMethodChange(isSelected)
{   
    setDisplay('keyInfo', ('WEPEncryption' == getSelectVal('wlEncryption')));
    checkStandardByEncry();
    displayWpsConfig();
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

function InitAuthMode(mode)
{
	var auth = 'open';
	
    if (mode == 'Basic')
    {
        var BasicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
        var BasicEncryptionModes = Wlan[ssidIdx].BasicEncryptionModes;
        
        if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem'))
        {
        	auth = 'open';
        }
        else
        {
            auth = 'shared';
        }
    }
    else if (mode == 'WPA')
    {
        if (Wlan[ssidIdx].WPAAuthenticationMode == 'EAPAuthentication')
        {
            auth = 'wpa';
        }
        else
        {
            auth = 'wpa-psk';
        }
    }
    else if ((mode == '11i')||(mode == 'WPA2'))
    {
        if (Wlan[ssidIdx].IEEE11iAuthenticationMode == 'EAPAuthentication')
        {
            auth = 'wpa2';
        }
        else
        {
            auth = 'wpa2-psk';
        }
    }
    else if ((mode == 'WPAand11i')||(mode == 'WPA/WPA2'))
    {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication')
        {
            auth = 'wpa/wpa2';
        }
        else
        {
            auth = 'wpa/wpa2-psk';
        }
    }
    else if(mode == 'X_HW_WAPI')
    {
        if(Wlan[ssidIdx].X_HW_WAPIAuthenticationMode == 'WAPIPSK')
        {
            auth = 'wapi-psk';
        }
        else
        {
            auth = 'wapi';
        }
    }

    wlanSetSelect('wlAuthMode', auth);
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

function getSSID()
{
	var ssid;
    
    if (1 == preflag)
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
    
    return ssid;	
}

function addParameter1(Form)
{   
    Form.addParameter('y.Enable',getCheckVal('wlEnable'));
    Form.addParameter('y.SSIDAdvertisementEnabled',getCheckVal('wlHide'));

    var ssid = getSSID();   
    
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

    for (i = 0; i < WlanMap.length; i++)
    {
        if (ssidIdx != WlanMap[i].index)
        {
        	if (Wlan[WlanMap[i].index].ssid == ssid)
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
	
    if (('CMCC' == CurrentBin.toUpperCase()) && (fttrFlag != 1)) {
        if((0 == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("CMCC-"))) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cmcc']);
            return false;
        }

        if (1 == DoubleFreqFlag) {
            if((4 == getWlanPortNumber(currentWlan.name)) && (0 != ssid.indexOf("CMCC-"))) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_cmcc_5G']);
                return false;
            }
        }
    }
	
	if (1 == preflag)
	{
		if((ssidIdx == 0) && (0 != ssid.indexOf("PLDTHOMEFIBR_")))
		{
			alert(cfg_wlancfgother_language['amp_ssid_must_be_pldthomefibr']);
			return false;
		}
	}

    Form.addParameter('y.SSID',ssid);

	return true;
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
                        if ( (wlKeys1 != "*************") || (wep1PsdModFlag == true) )
                        {
                            
                            Form.addParameter('k1.WEPKey', wlKeys1);
                        }

                        if ( (wlKeys2 != "*************") || (wep2PsdModFlag == true) )
                        {
                            Form.addParameter('k2.WEPKey', wlKeys2);
                        }

                        if ( (wlKeys3 != "*************") || (wep3PsdModFlag == true) )
                        {
                            Form.addParameter('k3.WEPKey', wlKeys3);
                        }

                        if ( (wlKeys4 != "*************") || (wep4PsdModFlag == true) )
                        {
                            Form.addParameter('k4.WEPKey', wlKeys4);
                        }
                    }
                    else
                    {
                        if ( (wlKeys1 != "*****") || (wep1PsdModFlag == true) )
                        {
                            Form.addParameter('k1.WEPKey', wlKeys1);
                        }

                        if ( (wlKeys2 != "*****") || (wep2PsdModFlag == true) )
                        {
                            Form.addParameter('k2.WEPKey', wlKeys2);
                        }

                        if ( (wlKeys3 != "*****") || (wep3PsdModFlag == true) )
                        {
                            Form.addParameter('k3.WEPKey', wlKeys3);
                        }

                        if ( (wlKeys4 != "*****") || (wep4PsdModFlag == true) )
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
    else if (AuthMode == 'wpa' || AuthMode == 'wpa2' || AuthMode == 'wpa/wpa2')
    {
        var wlRadiusKey = getValue('wlRadiusKey');
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
     
        if (AuthMode == 'wpa')
        {
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2')
        {
            Form.addParameter('y.BeaconType','11i');
            Form.addParameter('y.IEEE11iAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
        }
        else
        {
            Form.addParameter('y.BeaconType','WPAand11i');
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
 //       Form.addParameter('y.X_HW_GroupRekey',wlWpaGtkRekey);
    }
    else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk'||AuthMode == 'wapi'||AuthMode == 'wapi-psk')
    {
        var value = getValue('wlWpaPsk');
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');
        var wapiIP = getValue('wapiIPAddr');
        var wapiPort = getValue('wapiPort');
        

    if(AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {

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
            Form.addParameter('y.X_HW_WAPIPort',wapiPort);
        }
        else if(AuthMode == 'wapi-psk')
        {
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
            Form.addParameter('y.BeaconType','X_HW_WAPI');
            Form.addParameter('y.X_HW_WAPIAuthenticationMode','WAPIPSK');
            Form.addParameter('y.X_HW_WAPIEncryptionModes','SMS4');
            
        }
        else
        {
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
//        Form.addParameter('y.X_HW_GroupRekey',wlWpaGtkRekey);
        
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

    Form.addParameter('w.SsidInst',wlanInstId);
    
    Form.addParameter('w.SSID',ltrim(getSSID()));
    setCoverSsidNotifyFlag(Wlan[ssidIdx].ssid, ltrim(getSSID()));
    
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
    else if (AuthMode == 'wpa' || AuthMode == 'wpa2' || AuthMode == 'wpa/wpa2')
    {
        if (AuthMode == 'wpa')
        {
            Form.addParameter('w.BeaconType','WPA');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPA');            
            
            beaconType = "WPA";
            Form.addParameter('w.WPAAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.WPAEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].WPAEncryptionModes, getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2')
        {
            Form.addParameter('w.BeaconType','11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, '11i');
            
            beaconType = "11i";
            Form.addParameter('w.IEEE11iAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.IEEE11iEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].IEEE11iEncryptionModes, getSelectVal('wlEncryption'));
        }
        else
        {
            Form.addParameter('w.BeaconType','WPAand11i');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].BeaconType, 'WPAand11i');
            
            beaconType = "WPAand11i";
            Form.addParameter('w.MixAuthenticationMode','EAPAuthentication');
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'EAPAuthentication');
            
            Form.addParameter('w.MixEncryptionModes',getSelectVal('wlEncryption'));
            setCoverSsidNotifyFlag(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, getSelectVal('wlEncryption'));
        }
    }
    else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk'|| AuthMode == 'wapi'|| AuthMode == 'wapi-psk')
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
        weppsdModifyFLag = wep1PsdModFlag;
    }
    else if (2 == keyIndex)
    {
        key = getValue('wlKeys2');
        weppsdModifyFLag = wep2PsdModFlag;
    }
    else if (3 == keyIndex)
    {
        key = getValue('wlKeys3');
        weppsdModifyFLag = wep3PsdModFlag;
    } 
    else  if (4 == keyIndex)
    {
        key = getValue('wlKeys4');
        weppsdModifyFLag = wep4PsdModFlag;
    } 

    if ("Basic" != beaconType)
    {
        key = getValue('wlWpaPsk');
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

function SubmitForm()
{
if ((addParameter1(Form) == false) || (addParameter2(Form) == false) || (AddParaForCover(Form) == false))
    {
        return false;
    }

    var wlandomain = Wlan[ssidIdx].domain;
    var AuthMode = getSelectVal('wlAuthMode');

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
        }
        else
        {
            if (1 == TelMexFlag)
            {
                urlNode += '&k1=' + wlandomain + '.WEPKey.' + getSelectVal('wlKeyIndex');
            }
            else
            {
				urlNode += '&k1=' + wlandomain + '.WEPKey.1'
		                    + '&k2=' + wlandomain + '.WEPKey.2'
		                    + '&k3=' + wlandomain + '.WEPKey.3'
		                    + '&k4=' + wlandomain + '.WEPKey.4';
            }
        } 
    }
    else if (AuthMode == 'wpa' || AuthMode == 'wpa2' || AuthMode == 'wpa/wpa2')
    {
    }
    else if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        if (IsWpsConfigDisplay() == false)
        {
            urlNode += '&k=' + wlandomain + '.PreSharedKey.1';
        }
        else
        {
            urlNode += '&z=' + wlandomain + '.WPS'
                    + '&k=' + wlandomain + '.PreSharedKey.1';
        }
    }
    else if(AuthMode == 'wapi' || AuthMode == 'wapi-psk')
    {
        urlNode += '&k=' + wlandomain + '.PreSharedKey.1';
    }
    else
    {
    	urlNode += '&x=InternetGatewayDevice.LANDevice.1';
    }
    
    urlNode += '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic';

    return true;
}

function onwlwpsEnable()
{
    var wpsEnable = getCheckVal('wlWPSEnable');
	if ((wpsPinNum[i].X_HW_ConfigMethod == 'PushButton') && (1 == wpsEnable))
	   {
	     setDisable('btnWpsPBC', 0); 
	   }
	 else
	   {
	     setDisable('btnWpsPBC', 1); 
	   }
	
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
        
        if ('5G' == wlanpage)
        {
            Form.setAction('WpsPBC.cgi?freq=5G' + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');
        }
        else
        {
            Form.setAction('WpsPBC.cgi?freq=2G' + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');
        }
        
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
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

function LoadFrame()
{   
    if (enbl == '')
    {
        setDisplay('wlanBasicCfg',0);
    }
    else
    {   
    	InitAuthMode(Wlan[ssidIdx].BeaconType);
     	addAuthModeOption();
     	
        setDisplay('wlanBasicCfg',1);
        setCheck('wlEnbl', radioEnabled);
        
        if ((1 == radioEnabled) && (WlanArr[0] != null))
        {
            selectLine('record_0');
            setDisplay('wlanCfg',1);
        }
        else if (0 == radioEnabled)
        {
            setDisplay('wlanCfg',0);
            setDisplay('tbApply',0);            
        }
        else
        {
            setDisplay('ssidDetail', '0');
        }
    }
    
    keyIndexChange(0);
    
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

    
    if (curLanguage.toUpperCase() == 'CHINESE')
    {
        var HUNCTFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_HUNCT);%>';

        if(((curWebFrame == 'frame_CMCC') && (curUserType == sptUserType)))
        {
            setDisplay("TblBasicParaTitle",1);
        }
		
        if ('CMCC' == CurrentBin.toUpperCase())
        {
            setDisplay('BtnAdd', 0);
            setDisplay('BtnRemove',0);
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
    
    if (wifiPasswordMask == 1) {
        BindPsdModifyEvent();
        setDisplay('hidewlRadiusKey', 0);
        setDisplay('hidewlWpaPsk', 0);
        setDisplay('hidewlKeys', 0);
        setDisplay('hideId1', 0);
        setDisplay('hideId2', 0);
        setDisplay('hideId3', 0);
    }
    
    if (('5G' == wlanpage) && (FobidChannel5G == 1))
    {
        setDisable('Channel', 1);
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
    if (addParameter1(Form) == false)
    {  
        return false;
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
        else
        {}

    }
    else
    {
        if (CfgMode.toUpperCase() == 'ANTEL')
		{
		  Form.addParameter('y.BeaconType','WPAand11i');
		  Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
		  Form.addParameter('y.X_HW_WPAand11iEncryptionModes','TKIPandAESEncryption');
		}  
    }

    return true;
}

function ApplySubmit2()
{
    return SubmitForm();
}

function AddAdvParam()
{
    if(!CheckForm(1))
    {
        return false;
    }

    if (('5G' == wlanpage) && (FobidChannel5G == 1))
    {
    
    }
    else
    {
        if (getSelectVal('Channel') == 0)
        {
            Form.addParameter('y.Channel',getSelectVal('Channel'));
            Form.addParameter('y.AutoChannelEnable',1);
        }
        else
        {
            Form.addParameter('y.Channel',getSelectVal('Channel'));
            Form.addParameter('y.AutoChannelEnable',0);
        }
    }    

    if (ChannelWidth == 0)
    {
        Form.addParameter('y.X_HW_HT20',getSelectVal('X_HW_HT20'));
    }

    Form.addParameter('y.TransmitPower',getSelectVal('wlTxPwr'));
    Form.addParameter('y.X_HW_Standard',getSelectVal('X_HW_Standard'));

    if (getCheckVal('advanceEnbl') == 1)
    {
        var dtimPeriod = parseInt(getValue('dtimPeriod'),10);
        var beaconPeriod = parseInt(getValue('beaconPeriod'),10);
        
        Form.addParameter('a.DtimPeriod',dtimPeriod);
        Form.addParameter('a.BeaconPeriod',beaconPeriod);
    } 

    urlNode += '&a=' + Wifi.domain;

    return true;
}

function ApplySubmit()
{
	Form = new webSubmitForm();
	urlNode = "";
	
	var valid = false;
	var formAction = '';
	
	$('input[type="button"]').attr('disabled','disabled');
	
    if (AddFlag == true)
    {
    	urlNode += 'y=InternetGatewayDevice.LANDevice.1.WLANConfiguration';
    	formAction = 'add.cgi?';
        valid = ApplySubmit1();
    }
    else
    {
    	urlNode += 'y=' + Wlan[ssidIdx].domain;
    	formAction = 'set.cgi?';
    	
        valid = ApplySubmit2() && AddAdvParam();
    }  

    if(!valid)
    {
    	$('input[type="button"]').removeAttr('disabled');
    	return;
    }
    
    Form.setAction(formAction + urlNode
                        + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function EnableSubmit()
{
    setDisable('wlEnbl', 1);
    AddFlag = false;
    var Form = new webSubmitForm();
    var enable = getCheckVal('wlEnbl');
    
    $('input[type="button"]').attr('disabled','disabled');
    
    if (1 == DoubleFreqFlag)
    {
        if ("2G" == wlanpage)
        {
            Form.addParameter('x.Enable',enable);
            if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node2G)
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');    
            }
            else
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');              
            }
        }
        else if ("5G" == wlanpage)
        {
            Form.addParameter('x.Enable',enable);
              if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node5G)
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');    
            }
            else
            {
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');              
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
                                + '&RequestFile=html/amp/wlanbasic/WlanCMDC.asp');
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
    XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");	
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
            setText('wlSsid1',currentWlan.ssid);
            setDisable('wlSsid1',0);
            setDisplay('wlSsid2',0);
            setText('wlSsid2',"");
            SetStyleValue("wlSsid1", "width:123px");
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

		if(!AddFlag)
		{
			InitAuthMode(Wlan[ssidIdx].BeaconType);
			authModeChange();
		}
    }
}

function IsInSameRadio(WlanMap_index, Wlan_index)
{
    var WlanMap_index_portIndex = 0;
    var Wlan_index_portIndex = 0;
		
    if ('1' != '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WPS_MULIT_PBC);%>')
	{
		return true;
	}

    WlanMap_index_portIndex = getWlanPortNumber(Wlan[WlanMap_index].name);
    Wlan_index_portIndex = getWlanPortNumber(Wlan[Wlan_index].name);
    
    if (   ((WlanMap_index_portIndex < 4) && (Wlan_index_portIndex < 4)) 
        || ((WlanMap_index_portIndex > 3) && (Wlan_index_portIndex > 3)) )
    {
        return true;
    }
    else
    {
        return false;
    }
}

function addWPSModeOption(value)
{
    var len = document.forms[0].wlWPSMode.options.length;
    var existPushBut = 0;

    for (i = 0; i < len; i++)
    {
        document.forms[0].wlWPSMode.remove(0);
    }
    
    for (i = 0; i < Wlan.length; i++)
    {
        if (IsInSameRadio(value, i) && (wpsPinNum[i].X_HW_ConfigMethod == 'PushButton') && (true == wpsPinNum[i].Enable) 
        && ((((Wlan[i].BeaconType == 'WPA2') || (Wlan[i].BeaconType == '11i')) && (Wlan[i].IEEE11iAuthenticationMode == 'PSKAuthentication'))
            || ((Wlan[i].BeaconType == 'WPA') && (Wlan[i].WPAAuthenticationMode == 'PSKAuthentication'))
            || (((Wlan[i].BeaconType == 'WPAand11i') || (Wlan[i].BeaconType == 'WPA/WPA2')) && (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'PSKAuthentication'))))
        {
            existPushBut = 1;
            break;
        }
    }
    
    if ((0 == existPushBut) || ((1 == existPushBut) && (value == i)))
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
	var wlanInst = 0;
	
	ClearPsdModFlag();
    if (-1 == idIndex)
    {   
        if (1 == SingleFreqFlag)
        {
            if (SsidPerBand == 8)
            {
                if (SsidNum2g >= 8)
                {
                    loadssid(tableRow, 8);
                    return;
                }
                
            }
            else if (SsidNum2g >= 4)
            {
                loadssid(tableRow, 4);
                return;
            }
        }
        else if (1 == DoubleFreqFlag)
        {
            if ("2G" == wlanpage)
            {
                if (SsidNum2g >= 4)
                {
                    loadssid(tableRow, 4);
                    return;
                }
            }
 
            else if("5G" == wlanpage)
            {
                if (SsidNum5g >= 4)
                {
                    loadssid(tableRow, 4);
                    return;
                }
            }
        }

        ssidIdx = -1;
        AddFlag = true;

        currentWlan = new stWlan('','','','',1,32,1,'','','','','','','','','','','','','','','');

        setDisplay('ssidDetail', 1);
        setDisplay('securityCfg',0); 
        setDisable('wlHide', 0);
    }
    else
    {
        setDisplay('cfg_table', 1);
        setDisplay('securityCfg',1);
        ssidIdx = parseInt(WlanMap[idIndex].index);
		wlanInst = getWlanInstFromDomain(Wlan[ssidIdx].domain);
        AddFlag = false;
        
        currentWlan = Wlan[ssidIdx];
        guiCoverSsidNotifyFlag = 0;

        addWPSModeOption(ssidIdx);    
           
        if (1 == TelMexFlag)
        {
            keyIndexChange(currentWlan.KeyIndex);
        }
    }

    setDisplay('wifiCfg', (-1 != idIndex));
    
    showWlan(currentWlan);
	
	if ((1 == isSsidForIsp(wlanInst)) && (1 == ShowISPSsidFlag))
	{
		setDisable('btnApplySubmit', 1);
		setDisable('cancel', 1);
		return;
	}

    if ((1 == gzcmccFlag) && (curUserType == sptUserType))
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
    Form.setAction('del.cgi?RequestFile=html/amp/wlanbasic/WlanCMDC.asp');
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function CancelConfig()
{
    wlanSetSelect('wlTxPwr',WlanWifi.power);
    wlanSetSelect('RegulatoryDomain',WlanWifi.RegulatoryDomain);
    wlanSetSelect('X_HW_HT20',WlanWifi.X_HW_HT20);
    wlanSetSelect('X_HW_Standard',WlanWifi.mode);
    
	InitX_HW_Standard();
	X_HW_StandardChange();
	
    if (WlanWifi.AutoChannelEnable == 1)
    {
        wlanSetSelect('Channel',0);
    }
    else
    {   
        wlanSetSelect('Channel',WlanWifi.channel);
    }
    
    setText('dtimPeriod',Wifi.dtimPeriod);
    setText('beaconPeriod',Wifi.beaconPeriod);
    setText('rtsThreshold',Wifi.rtsThreshold);
    setText('fragThreshold',Wifi.fragThreshold);
}

function cancelValue()
{	
    if (AddFlag == true)
    {
        var tableRow = getElement("wlanInst");
        selectLine('record_0');
        
        tableRow.deleteRow(tableRow.rows.length-1);
    }
    else
    {
        InitAuthMode(Wlan[ssidIdx].BeaconType);
        showWlan(Wlan[ssidIdx]);
    } 

    CancelConfig();

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
    var index = 0;
    var i;
    var WebChannel = wlanGetSelect('Channel', WlanWifi.channel);
    var WebChannelValid = 0;    

    getPossibleChannels(freq, country, mode, width);
    var ShowChannels = possibleChannels.split(',');

    $('#Channel').empty();

    document.forms[0].Channel[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");
    
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
        document.forms[0].Channel[j] = new Option(ShowChannels[j-1], ShowChannels[j-1]);
    }

    if (1 == WebChannelValid)
    {
        wlanSetSelect('Channel', WebChannel);
    }
    else
    {
        wlanSetSelect('Channel', 0);    
    }
}

function loadChannelList(country, mode, width)
{
    loadChannelListByFreq(wlanpage, country, mode, width);
	if(1 == ChannelWidth)
	{
		setDisable('X_HW_HT20',1);
	}
}

function ChangeCountry()
{
    var country = getSelectVal('RegulatoryDomain');
    var mode = getValue('X_HW_Standard');
	var Width = getSelectVal('X_HW_HT20');
    loadChannelList(country, mode, Width);

    InitTransmitPowerList("wlTxPwr");
}

function setCountry()
{
    wlanSetSelect('RegulatoryDomain', WlanWifi.RegulatoryDomain);
    ChangeCountry();
}

function ChannelChange()
{
}

function ChannelWidthChange()
{
    var country = getSelectVal('RegulatoryDomain');
    var mode = getValue('X_HW_Standard');
    var Width = getSelectVal('X_HW_HT20');
    loadChannelList(country, mode, Width);
}

function LoadFrameWifi()
{        
    if (radioEnabled == 1)
    {
        if (Wifi == null || WlanWifi == null )
        {
            return ;
        }
	    InitWlanBasicDropDownList();
	    
        setDisplay('adConfig',1);
        setDisplay('wifiCfg',1);
        setCheck('advanceEnbl',1);
        
        setText('dtimPeriod',Wifi.dtimPeriod);
        setText('beaconPeriod',Wifi.beaconPeriod);
        setText('rtsThreshold',Wifi.rtsThreshold);
        setText('fragThreshold',Wifi.fragThreshold);

        setDisplay('wifiCfg',1);

        if (curWebFrame == 'frame_UNICOM')
	    {            
	        CustomsizeCUAvailable();
	    }
    }
}

function CustomsizeCUAvailable()
{
    if ((curUserType != sysUserType) && (1 != BjcuFlag))
    {
        setDisplay('BtnAdd', 0);
        setDisplay('BtnRemove',0);

        setDisplay('wifiCfg',0);
    }

    var currentPageURLFlag = document.URL.split('?')[1];
    if (('basic' != currentPageURLFlag) && ('secuty' != currentPageURLFlag))
    {
        currentPageURLFlag = top.unicomWlanPage;
    }
    
    if(currentPageURLFlag == 'basic')
    {    
        setDisplay('tr_wlan_basic_ssid_device_number',0); 
        setDisplay('tr_wlan_basic_ssid_wmm_enable',0);   
        
        setDisplay('securityCfg',0);    
        setDisplay('wlEncryMethod',0); 
        top.unicomWlanPage = 'basic';
    }
    else if(currentPageURLFlag == 'secuty') 
    {
        setDisplay('table_wlan_basic_config',0);
        setDisplay('table_wlan_Enable_check_box',0);
        top.unicomWlanPage = 'secuty';
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

function CheckForm(type)
{
    if((getSelectVal('wlTxPwr') == "") || (getSelectVal('RegulatoryDomain') == "") || (getSelectVal('Channel') == "") 
        || (getSelectVal('X_HW_Standard') == "") || (getSelectVal('X_HW_HT20') == ""))
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

        if(!isPlusInteger(dtimPeriod)|| !isValidDecimalNum(dtimPeriod))
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
            if((parseInt(beaconPeriod,10) < 20) || (parseInt(beaconPeriod,10) > 1000))
            {
                AlertEx(cfg_wlancfgadvance_language['amp_beacon_range']);
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
<div id='wlanBasicCfg' style="display:none;">
<table id = 'table_wlan_Enable_check_box' cellspacing="0" cellpadding="0" width="100%"  >
    <tr>
        <td class='func_title'><input type='checkbox' name='wlEnbl' id='wlEnbl' onClick='EnableSubmit();' value="ON">
          <script>document.write(cfg_wlancfgother_language['amp_wlan_enable']);</script></input></td>
    </tr>
</table>

<div class="func_spread"></div>

<div id='wlanCfg'>
<table id="TblBasicParaTitle"  width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none">

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

	      <td ><div class="align_center">
	        <script>
	        if (true != telmexSpan)
	        {
	            document.write(cfg_wlancfgbasic_language['amp_bcast_ssid']);
	        }
	        else
	        {
	            document.write(cfg_wlancfgbasic_language['amp_bcast_ssid_telmex']);
	        }
	        </script>
	        </div></td>
          <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_security_cfg']);</script></div></td>
    </tr>
    <script language="JavaScript" type="text/javascript">
        for (var i = 0;i < WlanMap.length; i++)
        {   
			if (1 != DoubleFreqFlag)
			{
				if (WlanMap[i].portIndex > (basic5GIfIndex-1))
                {
                    continue;
                }         
			}
			
            var mapIndex = WlanMap[i].index;

            document.write('<TR id="record_' + i  + '" class="tabal_01" onclick="selectLine(this.id);">');

            if ((0 == WlanMap[i].portIndex) || ((4 == WlanMap[i].portIndex) && (1 == DoubleFreqFlag)))
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="cfg_table">
 
      <tr>
        <td colspan="6">
            <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr class="tabal_head">
                    <td BindText='amp_ssid_detail'></td>
                </tr>
            </table>
            <table id = 'table_wlan_basic_config' width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
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
		
                <tr>
                      <td class="table_title width_per25" BindText='amp_bcast_cssid'></td>
                    <td class="table_right" id="TdHide">
                        <input type='checkbox' id='wlHide' name='wlHide' value="ON">
                        <span class="gray"> </span></td>
                </tr>			
            </table>
            <div id='securityCfg'>
            <div id='wlAuthModeDiv'>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_auth_mode'></td>
                    <td class="table_right" id="TdAuth">
                        <select id='wlAuthMode' name='wlAuthMode' size="1" onChange='authModeChange()' class="width_180px"></select> 
                        <span class="gray"> </span></td>
                </tr>
            </table>
            </div>

            <div id='wlEncryMethod'>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
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
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
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
                            document.write("<input type='password' id='wlKeys1' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>")
                            document.write("<input type='text' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>");
                        }

                    </script> </td>
                    <td rowspan="4"  class="table_right"> <font class="color_red">*</font> 
                      <input checked type='checkbox' id='hidewlKeys' name='hidewlKeys' value='on' onClick="ShowOrHideText('hidewlKeys', 'wlKeys1', 'twlKeys1', wep1password);ShowOrHideText('hidewlKeys', 'wlKeys2', 'twlKeys2', wep2password);ShowOrHideText('hidewlKeys', 'wlKeys3', 'twlKeys3', wep3password);ShowOrHideText('hidewlKeys', 'wlKeys4', 'twlKeys4', wep4password);"/>
                      <span id="hideId1"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
                      <span id="span_wep_keynote" class="gray"><script>wlKeyBitChange();</script></span> 
                    </td>
                </tr>
              
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key2'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[1] != null)
                        {
                            document.write("<input type='password' id='wlKeys2' name='wlKeys2' size='20' maxlength=26 onchange=\"wep2password=getValue('wlKeys2');getElById('twlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1])+ "'>")
                            document.write("<input type='text' id='twlKeys2' name='twlKeys2' size='20' maxlength=26  style='display:none'  onchange=\"wep2password=getValue('twlKeys2');getElById('wlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1]) + "'>");
                        }

                    </script> </td>
                        </tr>
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key3'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[2] != null)
                        {
                            document.write("<input type='password' id='wlKeys3' name='wlKeys3' size='20' maxlength=26 onchange=\"wep3password=getValue('wlKeys3');getElById('twlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>")
                            document.write("<input type='text' id='twlKeys3' name='twlKeys3' size='20' maxlength=26  style='display:none' onchange=\"wep3password=getValue('twlKeys3');getElById('wlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>");
                        }

                    </script> </td>
                        </tr>
                <tr>
                    <td class="table_title width_per25" BindText='amp_encrypt_key4'></td>
                          <td class="table_right"> <script language="JavaScript" type="text/javascript">

                        if(g_keys[3] != null)
                        {
                            document.write("<input type='password' id='wlKeys4' name='wlKeys4' size='20' maxlength=26 onchange=\"wep4password=getValue('wlKeys4');getElById('twlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>")
                            document.write("<input type='text' id='twlKeys4' name='twlKeys4' size='20' maxlength=26  style='display:none' onchange=\"wep4password=getValue('twlKeys4');getElById('wlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>");
                        }

                    </script> </td>
                        </tr>
              </table>
            </div>

    <div id='wpaPreShareKey'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
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
            <input type='password' id='wlWpaPsk' name='wlWpaPsk' size='20' maxlength='64' class="amp_font"  onchange="wpapskpassword=getValue('wlWpaPsk');getElById('twlWpaPsk').value=wpapskpassword;" />
            <input type='text' id='twlWpaPsk' name='twlWpaPsk' size='20' maxlength='64' class="amp_font" style='display:none' onchange="wpapskpassword=getValue('twlWpaPsk');getElById('wlWpaPsk').value=wpapskpassword;"/>
            <input checked type="checkbox" id="hidewlWpaPsk" name="hidewlWpaPsk" value="on" onClick="ShowOrHideText('hidewlWpaPsk', 'wlWpaPsk', 'twlWpaPsk', wpapskpassword);"/>
            <span id="hideId2"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
            <font class="color_red">*</font><span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_wpa_psknote']);</script></span></td>
        </tr>
      </table>
    </div>
    
     <div id='wlWapi'>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
           <td class="table_title width_per25" BindText='amp_wapi_ip'></td>
           <td class="table_right">
              <input type='text' id='wapiIPAddr' name='wapiIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
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
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_srvip'></td>
          <td class="table_right">
              <input type='text' id='wlRadiusIPAddr' name='wlRadiusIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_radius_srvport'></td>
                    <td class="table_right">
                        <input type='text' id='wlRadiusPort' name='wlRadiusPort' size='20' maxlength='5'>
                        <font class="color_red">*</font><span class="gray">
                        <script>document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);</script></span> 
                    </td>
                </tr>
            </table>

            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                <tr>
                    <td class="table_title width_per25" BindText='amp_radius_sharekey'></td>
                    <td class="table_right">
                        <input type='password' id='wlRadiusKey' name='wlRadiusKey' size='20' maxlength='64' class="amp_font" onchange="radiuspassword=getValue('wlRadiusKey');getElById('twlRadiusKey').value=radiuspassword;" />
                        <input type='text' id='twlRadiusKey' name='twlRadiusKey' size='20' maxlength='64' class="amp_font" style='display:none'  onchange="radiuspassword=getValue('twlRadiusKey');getElById('wlRadiusKey').value=radiuspassword;"/>
                        <input checked type="checkbox" id="hidewlRadiusKey" name="hidewlRadiusKey" value="on" onClick="ShowOrHideText('hidewlRadiusKey', 'wlRadiusKey', 'twlRadiusKey', radiuspassword);"/>
                        <font class="color_red">*</font><span class="gray">
                        <span id="hideId3"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
                    </td>
                </tr>
            </table>
            </div>

            <div id='wpsPinNumber'>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                        <tr> 
                          <td class="table_title width_per25" BindText='amp_wps_enable'></td>
                          <td class="table_right" id="TdWPSEnable"> <input id='wlWPSEnable' name='wlWPSEnable' type='checkbox' value="ON" onClick="onwlwpsEnable();"> 
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
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                  <tr>
                    <td class="table_title width_per25">PBC:</td>
                      <td class="table_right"> 
                        <input name="btnWpsPBC" type="button" class="submit" BindText="amp_btn_wpsstart" onClick="WpsPBCSubmit();"> 
                       </td>
                  </tr>
                </table>
            </div>

           <div id='wpsPinNumVal'>
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                <tr>
                          <td class="table_title width_per25">PIN:</td>
                          <td class="table_right"> <input type='text' id='wlClientPinNum' name='wlClientPinNum' size='20' maxlength='8' class="amp_font"> 
                          </td>
                        </tr>
                      </table>
            </div>
                    
                    <div id='wpsAPPinNumVal'> 
                      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                        <tr> 
                          <td class="table_title width_per25">AP-PIN:</td>
                          <td class="table_right"> <input type='text' id='wlSelfPinNum' name='wlSelfPinNum' size='20' maxlength='8' disabled class="amp_font"> 
                            <input id="RegeneratePIN" name="RegeneratePIN" type="button" BindText="amp_reg_pin" class="submit" onclick="OnRegeneratePIN();"/>
                            <input id="ResetPIN" name="ResetPIN" type="button" BindText="amp_reset_pin" class="submit" onclick="OnResetPIN();"/>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </div>
        </td> 
      </tr>
      </table>

    </div>
</div>

</div>

<div id='wifiCfg' style="display:none;">

     <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr id="wlPutOutPower">
            <td class="table_title width_per25" BindText='amp_tx_power'></td>
			<td class="table_right"> <select id="wlTxPwr" name="wlTxPwr" class="width_150px"></select></td>
        </tr>
        <tr id='switchChannel'>                    
			<td class="table_title width_per25" BindText='amp_wlan_channel'></td>
            <td class="table_right">
                  <select id='Channel' name='Channel' size="1" onChange="ChannelChange()" class="width_150px">
                  </select>
            </td>
        </tr>
            
		<tr id='switchChannelWidth'>                    
			<td class="table_title width_per25" BindText='amp_channel_width'></td>
            <td class="table_right">
                    <select id='X_HW_HT20' name='X_HW_HT20' size="1" onChange="ChannelWidthChange()" class="width_150px"></select>
            </td>
        </tr>
                
		<tr id="div_gMode">
            <td class="table_title width_per25" BindText='amp_channel_mode'></td>
            <td class="table_right">
				<select id="X_HW_Standard" name="X_HW_Standard" size="1" class="width_150px" onchange="X_HW_StandardChange()"></select>
            </td>
        </tr>
    </table>
    
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
        <tr id="div_para0" style="display:none">
            <td class="table_title width_per25" BindText='amp_advance_config'></td>
            <td class="table_right">
				<input type='checkbox' id='advanceEnbl' name='advanceEnbl' onClick='advanceEnable();' value="OFF">
            </td>
        </tr>                    
    </table>
            
	<div id="adConfig">	
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
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
					<span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_beacon_timenote']);</script></span></td>
            </tr>
        </table>
    </div>
  
</div>

<table id="tbApply" width="100%" border="0" cellpadding="0" cellspacing="0"  >
        <tr><td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
              <tr >
                    <td class="table_submit width_per25"></td>
                    <td class="table_submit">
					    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                        <input id="btnApplySubmit" name="btnApplySubmit" type="button" BindText="amp_wlancfg_apply" class="submit" onClick="ApplySubmit();" />
                        <input id="cancel" name="cancel" type="button" BindText="amp_wlancfg_cancel" class="submit" onClick="cancelValue();" />
                    </td>
                  </tr>
            </table>
        </td> 
      </tr>
  </table>

<script>
ParseBindTextByTagName(cfg_wlancfgother_language,"input",2);
</script>

</form>
</td></tr>
</table>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
