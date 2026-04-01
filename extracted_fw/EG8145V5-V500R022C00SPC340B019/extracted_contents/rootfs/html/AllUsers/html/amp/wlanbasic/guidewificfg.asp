<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="../common/wlan_extended.asp"></script>
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
.tb_radio
{
	height: 30px;
	width: 70px;
	background: url(../../../images/on.jpg) no-repeat;
}

.width_auto {
    width: auto;
    margin-left :104px;
}
</style>

<title>WiFi Configuration</title>
<script language="JavaScript" type="text/javascript">

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var wlan1 = null;
var wlan5 = null;
var wlan5_exist = false;
var allPsk;
var allWep;
var encryTypeArr = new Array();
var pwdNoticeArr = new Array("pwd_notice", "pwd_notice_5G");
var psk1 = "";
var psk5 = "";
var wep1 = "";
var wep5 = "";
var url = "";

var enbl2G = 0;
var enbl5G = 0;
var bsdPolicy = 0;
var dfsChSwitch = 0;
var channelsWithOutDFS;
var dfsRadorGroup = 1;
var weatherRadorGroup = 2;
var isSet5Gflag = 0;
var ssid5GIndex = 0;

var curUserType = '<%HW_WEB_GetUserType();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var sysUserType = '0';
var sptUserType ='1';
var dbaa1SuperSysUserType = '2';
var ProductType = '<%HW_WEB_GetProductType();%>';
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var IsSurportInternetCfg  = "<%HW_WEB_GetFeatureSupport(BBSP_FT_GUIDE_PPPOE_WAN_CFG);%>";
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var megacablePwd = '<%HW_WEB_GetFeatureSupport(FT_WLAN_MEGACABLEPWD);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var nonWepFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NON_WEP);%>';
var WPAPSKFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_WPAPSK_SUPPORT);%>';
var fobidChannel = '<%HW_WEB_GetFeatureSupport(AMP_FT_WLAN_FOBID_CHANNEL);%>';
var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var tmczstFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TMCZST);%>';
var webEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebEnable);%>';
var webAdminEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebAadminEnable);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var IsCTRG = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CTRG);%>';
var hiLinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var currentBin = '<%HW_WEB_GetBinMode();%>';
var isVideoRetrans = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIDEO_TRANS);%>';
var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';
var isForceModifyPwd = window.parent.isForceModifyPwd;
var iotSsidInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.SyncIotSsidInst);%>';
var dfsSilentEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WIFIInfo.WlanDfsControl.DfsSilentEnable, DB);%>';
var TypeWord = '<%HW_WEB_GetTypeWordMode();%>';

function SupportTtnet()
{
    return (CfgMode.toUpperCase() == "DTTNET2WIFI" || CfgMode.toUpperCase() == "TTNET2");
}

function WANIP(domain,ipGetMode,serviceList,modeType,Tr069Flag)
{
	this.domain = domain;

	if (modeType.toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
		this.modeType = "BRIDGED";
	}
	else
	{
		this.modeType = "ROUTED";
	}

	this.ipGetMode = "DHCP";
	this.serviceList = serviceList; 
	this.Tr069Flag = Tr069Flag;
}

function SubmitPre() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
        }
    });
    window.parent.location="../../../index.asp";
}

function Clickexit()
{
	window.top.location = "/index.asp";
}

function guide_pre_globe(obj)
{
	window.parent.onchangestep(obj);
}

function WANPPP(domain,serviceList,modeType,Tr069Flag)
{
	this.domain = domain;

	if (modeType.toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
		this.modeType = "BRIDGED";
	}
	else
	{
		this.modeType = "ROUTED";
	}

	this.ipGetMode = "PPPOE";

	this.serviceList = serviceList;
	this.Tr069Flag = Tr069Flag;
}

var WanIp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i},AddressingType|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANIP);%>;
var WanPpp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANPPP);%>;

var Wan = new Array();

var inter_index = -1;

for (i=0, j=0; WanIp.length > 1 && j < WanIp.length - 1; i++,j++)
{
	if("1" == WanIp[j].Tr069Flag)
	{
		i--;
		continue;
	}
	Wan[i] = WanIp[j];
}

for (j=0; WanPpp.length > 1 && j<WanPpp.length - 1; i++,j++)
{
	if("1" == WanPpp[j].Tr069Flag)
	{
		i--;
		continue;
	}
	
	Wan[i] = WanPpp[j];
}

function filterChooseWan()
{
	var i = 0;
	for (i = 0; i < Wan.length; i++)
	{
		if ((Wan[i].serviceList.toString().toUpperCase().indexOf("INTERNET") < 0)
		|| (Wan[i].serviceList.toString().toUpperCase().indexOf("TR069") >= 0)
		|| (Wan[i].serviceList.toString().toUpperCase().indexOf("VOIP") >= 0)
		|| (Wan[i].ipGetMode.toUpperCase() != "PPPOE"))
		{
			continue;
		}
		if ((Wan[i].modeType != "ROUTED") && (Wan[i].modeType != "BRIDGED"))
		{
			continue;
		}

		inter_index = i;

		if (Wan[i].serviceList == "INTERNET")
		{
			break;
		}
	}

	return inter_index;
}

var PPPoEWanid = filterChooseWan();

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

allPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;
allWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;

function getWlan()
{
	wlan1 = getFirstSSIDInst(1, allWlanInfo);	
	if(null != wlan1)
	{
		psk1 = getPsk(wlan1.InstId, allPsk);
		wep1 = getWep(wlan1.InstId, wlan1.KeyIndex, allWep);
        convStdAuthMode(wlan1);
	}

	if(1 == DoubleFreqFlag)
	{
		wlan5 = getFirstSSIDInst(2, allWlanInfo);
		wlan5_exist = (null != wlan5);
		if(wlan5_exist)
		{
			psk5 = getPsk(wlan5.InstId, allPsk);
			wep5 = getWep(wlan5.InstId, wlan5.KeyIndex, allWep);
            convStdAuthMode(wlan5);
		}
	}
}

function GetWpaPskNote(beaconType) {
    var wpaPskNote = cfg_wlancfgdetail_language['amp_wpa_psknote' + (megacablePwd == 1 ? '_telmex' : '')];
    if ((beaconType == "WPA3") || (beaconType == "WPA2/WPA3")) {
        wpaPskNote = cfg_wlancfgdetail_language['amp_wpa_psknote_63' + (megacablePwd == 1 ? '_telmex' : '')];
    }

    return wpaPskNote;
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
	
	if(encryTypeArr[idx] == "wep")
	{
		if("104-bit" == wlan.WEPEncryptionLevel)
		{
			getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_encrypt_keynote_128'];
		}
		else
		{
			getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_encrypt_keynote_64'];
		}
	}
	else
	{
        getElById(pwdNoticeArr[idx]).innerHTML = GetWpaPskNote(wlan.BeaconType);

        if (CfgMode.toUpperCase() == "EGVDF2") {
            getElById(pwdNoticeArr[idx]).innerHTML = "(The password must be at least 8 characters long and must contain all of the following: uppercase characters, lowercase characters, digits (0-9), special characters.)";
        } else if (CfgMode.toUpperCase() == "GNVDF") {
            getElById(pwdNoticeArr[idx]).innerHTML = "(The password must be at least 16 characters long and must contain two of the following: uppercase characters, lowercase characters, digits (0-9), special characters.)";
        }
    }
}

function GetInternetFlag()
{
	if (IsSurportInternetCfg == "1" && mngttype == "0")
	{
		return true;
	}
	return false;
}

function SubmitPwd(val)
{
	window.parent.onchangestep("guidesystemcfg.asp");	
}

if(allWlanInfo != null && allWlanInfo.length > 1)
{
	allWlanInfo.pop();
	
	allWlanInfo.sort(function(s1, s2)
	    {
	        return parseInt(s1.name.charAt(s1.name.length - 1), 10) - parseInt(s2.name.charAt(s2.name.length - 1), 10);
	    }
	);
}

function isShowWifiName()
{
	return !IsSonetSptUser();
}

function checkWep(val, keyBit)
{
	if ( val != '' && val != null)
	{
	   
	   if ( keyBit == '104-bit' )
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
	   AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_empty']);
	   return false;
	}
	return true;
}




function addRadioEnablePara(form)
{
	var oldRadioEbl = Radio[0].Enable;
	if(enbl2G != oldRadioEbl)
	{
		form.addParameter('e1.RadioInst', 1);
		form.addParameter('r1.Enable',enbl2G);
		url += 'e1=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&r1=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&';
	}
		
	if(1 == DoubleFreqFlag)
	{
		oldRadioEbl = Radio[1].Enable;
		if(enbl5G != oldRadioEbl)
		{
			form.addParameter('r2.Enable',enbl5G);
			url += 'r2=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2&';
		}
	}
}

function CheckDfsChannelWarn(wlan) {
    var addIdName = (wlan == wlan1) ? '' : '_5G';  
    var freq = (wlan == wlan1) ? '2G' : '5G';
    var curChannel = getSelectVal('wlChannel' + addIdName);;
    var channelGroup;

    if ((curChannel == 0) || (curChannel == -1)) {
        return true;
    }

    if (dfsSilentEnable === '0') {
        return true;
    }

    if ((dfsChSwitch == 1) && (freq == '5G')) {
        if (curChannel != wlan.Channel) {
            channelGroup = getDfsKeepTime(curChannel, wlan.ChannelPlus, wlan.RegulatoryDomain, wlan.X_HW_HT20);

            if (channelGroup == weatherRadorGroup) {
                if (ConfirmEx(cfg_wlancfgadvance_language['amp_advance_dfs_weather_warn']) == false) {
                    return false;
                }
            } else if (channelGroup == dfsRadorGroup) {
                if (ConfirmEx(cfg_wlancfgadvance_language['amp_advance_dfs_general_warn']) == false) {
                    return false;
                }
            }
        }
    }

    return true;
}

function AddParaChannel(form, addIdName, idx) {
    var freq = (idx == 0) ? '2G' : '5G';
    var selChannelValue = getSelectVal('wlChannel' + addIdName);
    var autoChannelScope = "0";

    if ((selChannelValue == 0) || (selChannelValue == -1)) {
        if (fobidChannel != 1) {
            form.addParameter('w' + idx + '.Channel', 0);
            form.addParameter('w' + idx + '.AutoChannelEnable', 1); 

            if ((dfsChSwitch == 1) && (freq == "5G")) {
                if (selChannelValue == 0) {
                    autoChannelScope = channelsWithOutDFS;
                }

                Form.addParameter('w' + idx + '.X_HW_AutoChannelScope', autoChannelScope);
            }
        }
    } else {
        form.addParameter('w' + idx + '.Channel', selChannelValue);
        form.addParameter('w' + idx + '.AutoChannelEnable', 0); 
    }
}

function IsAuthModePreSharedKey(authMode) {
    if ((authMode == 'wpa-psk') || (authMode == 'wpa2-psk') || (authMode == 'wpa/wpa2-psk') || (authMode == 'wpa3-psk') || (authMode == 'wpa2/wpa3-psk')) {
        return true;
    } else {
        return false;
    }
}

function AddParaAuthTurkcell(wlan, form, pwd, authMode, method) {
    var wlanInst = wlan.InstId;
    var idx = (wlan == wlan1) ? 0 : 1;
    var addIdName = (wlan == wlan1) ? '' : '_5G';
    var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;
    var authAddData = { 'open' : ['Basic', 'BasicAuthenticationMode', 'None', 'BasicEncryptionModes', ENUM_BasicAuthenticationMode, ENUM_BasicEncryptionModes], 
                        'wpa-psk' : ['WPA', 'WPAAuthenticationMode', 'PSKAuthentication', 'WPAEncryptionModes', ENUM_WPAAuthenticationMode, ENUM_WPAEncryptionModes], 
                        'wpa2-psk' : ['11i', 'IEEE11iAuthenticationMode', 'PSKAuthentication', 'IEEE11iEncryptionModes', ENUM_IEEE11iAuthenticationMode, ENUM_IEEE11iEncryptionModes], 
                        'wpa/wpa2-psk' : ['WPAand11i', 'X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication', 'X_HW_WPAand11iEncryptionModes', ENUM_MixAuthenticationMode, ENUM_MixEncryptionModes], 
                        'wpa3-psk' : ['WPA3', 'X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication', 'X_HW_WPAand11iEncryptionModes', ENUM_MixAuthenticationMode, ENUM_MixEncryptionModes],
                        'wpa2/wpa3-psk' : ['WPA2/WPA3', 'X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication', 'X_HW_WPAand11iEncryptionModes', ENUM_MixAuthenticationMode, ENUM_MixEncryptionModes]
                        }

    if ((authMode == 'open') || IsAuthModePreSharedKey(authMode)) {
        form.addParameter('w' + idx + '.BeaconType', authAddData[authMode][0]);
        form.addParameter('w' + idx + '.' + authAddData[authMode][1], authAddData[authMode][2]);
        form.addParameter('w' + idx + '.' + authAddData[authMode][3], method);
        setCoverSsidNotifyFlag("", authAddData[authMode][0], ENUM_BeaconType);
        setCoverSsidNotifyFlag("", authAddData[authMode][2], authAddData[authMode][4]);
        setCoverSsidNotifyFlag("", method, authAddData[authMode][5]);
    } 

    if (IsAuthModePreSharedKey(authMode)) {
        var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst + ".PreSharedKey.1";
        if (!CheckPsk(pwd)) {
            return false;
        }

        if (pwd != "********") {
            form.addParameter('psk'+idx+'.PreSharedKey', pwd);
        }

        url += "psk" + idx + "=" + pskDomain + "&";
        setCoverSsidNotifyFlag("", pwd, ENUM_Key);
    } else {
    }

    if (!CheckDfsChannelWarn(wlan)) {
        return false;
    }

    AddParaChannel(form, addIdName, idx);
    return true; 
}

function AddParaAuth(wlan, form, pwd) {
    var wlanInst = wlan.InstId;
    var idx = (wlan == wlan1) ? 0 : 1;
    var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;

    if (encryTypeArr[idx] == "wep") {
        var wep1Domain = wlanDomain + ".WEPKey." + wlan.KeyIndex;
        if (!checkWep(pwd, wlan.WEPEncryptionLevel)) {
            return false;
        }

        if (pwd != "********") {
            form.addParameter('wep' + idx + '.WEPKey', pwd);
        }

        url += "wep" + idx + "=" + wep1Domain + "&";
        setCoverSsidNotifyFlag("", pwd, ENUM_Key);		
    } else {
        var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst + ".PreSharedKey.1";
        if (!CheckPsk(pwd)) {
            return false;
        }

        if (pwd != "********") {
            form.addParameter('psk' + idx + '.PreSharedKey', pwd);
        }

        url += "psk" + idx + "=" + pskDomain + "&";
        if (isSet5Gflag == 1) {
            url += "PSK" + idx + "=" + allWlanInfo[ssid5GIndex].domain + ".PreSharedKey.1&";
        }
        setCoverSsidNotifyFlag("", pwd, ENUM_Key);		
    }

    if (encryTypeArr[idx] == "none") {
        form.addParameter('w' + idx + '.BeaconType', "WPAand11i");
        form.addParameter('w' + idx + '.X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication');
        form.addParameter('w' + idx + '.X_HW_WPAand11iEncryptionModes', "TKIPandAESEncryption");
        setCoverSsidNotifyFlag("", "WPAand11i", ENUM_BeaconType);
        setCoverSsidNotifyFlag("", "TKIPandAESEncryption", ENUM_MixEncryptionModes);
    }

    return true;
}

function addParaWlan(wlan, form)
{
    var wlanInst = wlan.InstId;
    var idx = wlan==wlan1?0:1;
    var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;
	var pwd = idx?getValue("pwd_wifipw_5G"):getValue("pwd_wifipw");
	if ((isFireFox4 == 1) && (pwd == ''))
	{
		pwd = idx?getValue("txt_wifipw_5G"):getValue("txt_wifipw");
	}
	
	var ssid = idx?getValue("txt_wifiname_5G"):getValue("txt_wifiname");
	
    if(!CheckSsid(ssid))
    {
        return false;
    }

    wlan.ssid = ssid;
    if(checkSSIDExist(wlan, allWlanInfo))
    {
        return false;
    }
    WifiCoverParaDefault(wlan, wlanInst);

    if (turkcellFlag == 1) {
        var addIdName = (wlan == wlan1) ? '' : '_5G';
        var authMode = getSelectVal('wlAuthMode' + addIdName);
        var method = getSelectVal('wlEncryption' + addIdName);

        if (!AddParaAuthTurkcell(wlan, form, pwd, authMode, method)) {
            return false;
        }
    } else {
        if (!AddParaAuth(wlan, form, pwd)) {
            return false;
        }
    }

    form.addParameter('w'+idx+'.SSID', ssid);
    url += "w"+idx+"="+wlanDomain+"&";
    if (isSet5Gflag == 1) {
        url += "W" + idx + "=" + allWlanInfo[ssid5GIndex].domain + "&";
    }
    SubmitWIfiCoverSsid(form, wlan, wlanInst);
	
	addRadioEnablePara(form);
	
    return true;
}

function AddParaWlanForBSD(form) {
    var wlanInst = wlan5.InstId;
    var idx = 1;
    var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;
    var pwd = getValue("pwd_wifipw");

    if ((isFireFox4 == 1) && (pwd == '')) {
        pwd = getValue("txt_wifipw");
    }

    var ssid = getValue("txt_wifiname");

    if (!CheckSsid(ssid)) {
        return false;
    }

    wlan5.ssid = ssid;
    if (checkSSIDExist(wlan5, allWlanInfo)) {
        return false;
    }

    WifiCoverParaDefault(wlan5, wlanInst);

    var authMode = getSelectVal('wlAuthMode');
    var method = getSelectVal('wlEncryption');

    if (!AddParaAuthTurkcell(wlan5, form, pwd, authMode, method)) {
        return false;
    }

    form.addParameter('w' + idx + '.SSID', ssid);
    url += "w" + idx + "=" + wlanDomain + "&";
    SubmitWIfiCoverSsid(form, wlan5, wlanInst);

    return true;
}

function AddParameterForBSD(form) {
    form.addParameter('z.BandSteeringPolicy', bsdPolicy);
    url += "z=" + XHWGlobalConfig.domain + "&";
}

function IsFirstSsidEqual() {
    var ssid2G = '';
    var ssid5G = '';
    for (var i = 0; i < allWlanInfo.length; i++) {
        if (getInstIdByDomain(allWlanInfo[i].domain) == 1) {
            ssid2G = allWlanInfo[i].ssid;
        }

        if (getInstIdByDomain(allWlanInfo[i].domain) == parseInt(ssidStart5G) + 1) {
            ssid5G = allWlanInfo[i].ssid;
            ssid5GIndex = i;
        }
    }

    if (ssid2G == ssid5G) {
        return true;
    }

    return false;
}

function IsSetSsid5G(wlandomain) {
    if ((fttrFlag == 1) && (DoubleFreqFlag != 1) && (getInstIdByDomain(wlandomain) == 1) &&
        ((encryTypeArr[0] == "psk") || (encryTypeArr[0] == "none")) && (hiLinkRoll == 1) &&
        (IsFirstSsidEqual() == true)) {
        isSet5Gflag = 1;
    } else {
        isSet5Gflag = 0;
    }
}

function IsSsid5GExist(ssid) {
    for (var i = 0; i < allWlanInfo.length; i++) {
        if (getWlanPortNumber(allWlanInfo[i].name) <= ssidEnd2G) {
            continue;
        }

        if (i != ssid5GIndex) {
            if (allWlanInfo[i].ssid == ssid) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
                return false;
            }
        }
    }

    return true;
}

function AddParameter5G(wlandomain, Form) {
    var formLength = Form.oForm.length;
    for (var i = 0; i < formLength; i++) {
        if (Form.oForm[i].name == 'w0.SSID') {
            if (IsSsid5GExist(Form.oForm[i].value) == false) {
                return false;
            }
        }

        var name = Form.oForm[i].name.split('.');
        if ((name[0] == 'r1') || (name[0] == 'z0')) {
            continue;
        }

        var newName; 
        var coverDomain = 'ToAp' + wlan1.InstId;
        if (name[0] == coverDomain) {
            newName = Form.oForm[i].name + '5G';
            if (newName == (coverDomain + '.SsidInst5G')) {
                Form.addParameter(newName, parseInt(ssidStart5G) + 1);
                continue;
            }

            if (newName == (coverDomain + '.Standard5G')) {
                continue;
            }
        } else {
            newName = name[0].toUpperCase() + '.' + name[1];
        }

        Form.addParameter(newName, Form.oForm[i].value);
    }

    if (((allWlanInfo[ssid5GIndex].BeaconType == 'Basic') && (allWlanInfo[ssid5GIndex].BasicEncryptionModes == 'None')) && (encryTypeArr[0] == "psk")) {
        if (wlan1.BeaconType == 'WPA') {
            Form.addParameter('W0.BeaconType', wlan1.BeaconType);
            Form.addParameter('W0.WPAAuthenticationMode','PSKAuthentication');
            Form.addParameter('W0.WPAEncryptionModes', wlan1.WPAEncryptionModes);

            Form.addParameter(coverDomain + '.BeaconType5G', wlan1.BeaconType);
            Form.addParameter(coverDomain + '.WPAAuthenticationMode', 'PSKAuthentication');
            Form.addParameter(coverDomain + '.WPAEncryptionModes', wlan1.WPAEncryptionModes);
        } else if ((wlan1.BeaconType == '11i') || (wlan1.BeaconType == 'WPA2')) {
            Form.addParameter('W0.BeaconType', wlan1.BeaconType);
            Form.addParameter('W0.IEEE11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('W0.IEEE11iEncryptionModes', wlan1.IEEE11iEncryptionModes);

            Form.addParameter(coverDomain + '.BeaconType5G', wlan1.BeaconType);
            Form.addParameter(coverDomain + '.IEEE11iAuthenticationMode5G', 'PSKAuthentication');
            Form.addParameter(coverDomain + '.IEEE11iEncryptionModes5G', wlan1.IEEE11iEncryptionModes);
        } else if ((wlan1.BeaconType == 'WPAand11i') || (wlan1.BeaconType == 'WPA/WPA2') ||
                   (wlan1.BeaconType == 'WPA3') || (wlan1.BeaconType == 'WPA2/WPA3')) {
            Form.addParameter('W0.BeaconType', wlan1.BeaconType);
            Form.addParameter('W0.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
            Form.addParameter('W0.X_HW_WPAand11iEncryptionModes', wlan1.X_HW_WPAand11iEncryptionModes);

            Form.addParameter(coverDomain + '.BeaconType5G', wlan1.BeaconType);
            Form.addParameter(coverDomain + '.MixAuthenticationMode5G', 'PSKAuthentication');
            Form.addParameter(coverDomain + '.MixEncryptionModes5G', wlan1.X_HW_WPAand11iEncryptionModes);
        }
    }

    return true;
}

function checkPasswordStrength(id) {
    var score = 0;
    var passWord = document.getElementById(id).value;

    if (passWord.length < 8) {
        return 0;
    }

    if (isLowercaseInString(passWord)) {
        score++;
    }
    if (isUppercaseInString(passWord)) {
        score++;
    }
    if (isDigitInString(passWord)) {
        score++;
    }
    if (isSpecialCharacterNoSpace(passWord)) {
        score++;
    }

    return score;
}

function guideJumpNext()
{
    if ((fttrFlag == 1) && (IsCTRG == 1)) {
        guide_skip($('#guidelanconfig')[0]);
    } else if ((ProductType == '2') && isForceModifyPwd) {
        if (curUserType == sysUserType) {
            guide_skip($('#guidewancfg')[0]);
        } else {
            guide_skip($('#guideinternet')[0]);
        }
    } else {
        guide_skip($('#guidesyscfg')[0]);
    }
}

function SubmitForm(val)
{
    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        guide_skip($('#guidesyscfg')[0]);
        return ;
    }

    if (CfgMode.toUpperCase() == "EGVDF2") {
        var score2G = checkPasswordStrength("pwd_wifipw");
        var score5G = checkPasswordStrength("pwd_wifipw_5G");
        if (score2G < 2 || score5G < 2) {
            AlertEx("The password must be at least 8 characters long and must contain all of the following: uppercase characters, lowercase characters, digits (0-9), special characters.");
            return;
        }
    }

    Form = window.parent.wifiForm;
    url = '';
    var url_add = 'set.cgi?';

    if (fttrFlag == 1) {
        IsSetSsid5G(wlan1.domain);
    }

    if((null != wlan1) && !addParaWlan(wlan1, Form))
    {
        return ;
    }
    if(wlan5_exist)
    {
        if (IsShowBSD()) {
            if (bsdPolicy != XHWGlobalConfig.BandSteeringPolicy) {
                AddParameterForBSD(Form);
            }
            
            if (bsdPolicy == 0) {
                if(!addParaWlan(wlan5, Form)) {
                    return ;
                }
            } else {
                if (!AddParaWlanForBSD(Form)) {
                    return ;
                }
            }
        } else {
            if (tmczstFlag == 1) {
                if (!IsTmczstShow5G()) {
                    if(!addParaWlan(wlan5, Form)) {
                        return ;
                    }
                }
            } else {
                if(!addParaWlan(wlan5, Form)) {
                    return ;
                }
            }
        }
    }
    if (isSet5Gflag == 1) {
        if (AddParameter5G(wlan1.domain, Form) == false) {
            return;
        }
    }

    url_add += url_new;
    url_add += url;
    if (fttrFlag == 1) {
        Form.setAction(url_add + 'RequestFile=/html/bbsp/lanservicecfg/lanportcfg.asp');
    } else if (IsTedata == 1) {
        Form.setAction(url_add + 'RequestFile=/html/ssmp/cfgguide/userguidecfgdone.asp');
    } else {
        Form.setAction(url_add + 'RequestFile=/html/ssmp/accoutcfg/guideaccountcfg.asp');
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    if (fttrFlag == 1) {
        setDisplay('iotwifitable', 1);
        setDisplay("wifiCfgInfo", 0);
        top.showIotSsidFlag = 1;
    } else {
        guideJumpNext();
    }
}

function IotAuthModeChange()
{
    var authMode = getSelectVal('iotauthmode');
    setDisplay("iotssid_pwd", 1);
    if (authMode == "open") {
        setDisplay("iotssid_pwd", 0);
    }
}

function checkIotSSIDExist(ssid, WlanArr)
{
    for (i = 0; i < WlanArr.length - 1; i++) {
        if (WlanArr[i].ssid == ssid) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
            return false;
        } else {
            continue;
        }
    }

    return true;
}

function stWlanNow(domain, Name, ssid)
{
    this.domain = domain;
    this.Name = Name;
    this.ssid = ssid;
}

function setWlanNowMap(WlanListNow)
{
    var WlanNowMap = {};
    for (var i = 0; i < WlanListNow.length-1; i++) {
        var athindex = getWlanPortNumber(WlanListNow[i].Name);
        if ((athindex >= 0) && (athindex <= ssidEnd2G)) {
            WlanNowMap[WlanListNow[i].ssid] = WlanListNow[i];

        }
    }
    
    return WlanNowMap;
}

function SetWlanParaInfo(wlanDomain)
{
    var wlanData = "";
    var authEncry = getSelectVal('iotauthmode');
    var value = getValue("iotwifipwd");
    var iotInst = getWlanInstFromDomain(wlanDomain);

    wlanData += "k.PreSharedKey=" + value;

    wlanData += "&m.SyncIotSsidInst=" + iotInst;

    if (authEncry == 'open') {
        wlanData += "&y.BeaconType=Basic";
        wlanData += "&y.BasicAuthenticationMode=None";
        wlanData += "&y.BasicEncryptionModes=None";

    } else if (authEncry == 'wpa') {
        wlanData += "&y.BeaconType=WPA";
        wlanData += "&y.WPAAuthenticationMode=PSKAuthentication";
        wlanData += "&y.WPAEncryptionModes=TKIPEncryption";

    } else if (authEncry == 'wpa2-psk') {
        wlanData += "&y.BeaconType=11i";
        wlanData += "&y.IEEE11iAuthenticationMode=PSKAuthentication";
        wlanData += "&y.IEEE11iEncryptionModes=AESEncryption";

    } else if (authEncry == 'wpa/wpa2-psk') {
        wlanData += "&y.BeaconType=WPAand11i";
        wlanData += "&y.X_HW_WPAand11iAuthenticationMode=PSKAuthentication";
        wlanData += "&y.X_HW_WPAand11iEncryptionModes=TKIPandAESEncryption";

    } else if (authEncry == 'wpa3-psk') {
        wlanData += "&y.BeaconType=WPA3";
        wlanData += "&y.X_HW_WPAand11iAuthenticationMode=SAEAuthentication";
        wlanData += "&y.X_HW_WPAand11iEncryptionModes=AESEncryption";

    } else if (authEncry == 'wpa2/wpa3-psk') {
        wlanData += "&y.BeaconType=WPA2/WPA3";
        wlanData += "&y.X_HW_WPAand11iAuthenticationMode=PSKandSAEAuthentication";
        wlanData += "&y.X_HW_WPAand11iEncryptionModes=AESEncryption";
    }

    $.ajax({
         type : "POST",
         async : true,
         cache : false,
         data : wlanData + "&x.X_HW_Token=" + getValue('onttoken'),
         url : "set.cgi?y=" + wlanDomain 
            +  "&k=" + wlanDomain + '.PreSharedKey.1' 
            + "&m=InternetGatewayDevice.X_HW_WifiCoverService"
            + "&RequestFile=html/amp/wlanbasic/guidewificfg.asp",
         success : function(data) {
         },
         complete: function (XHR, TS) {
            XHR=null;
         }
    });
}

function addSubmit()
{
    var wlanDomain;
    var addSSID = getValue("iotwifiname");
    var thisNode = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : "y.SSIDAdvertisementEnabled=1" + "&y.SSID=" + addSSID + "&y.LowerLayers=" + thisNode + "&x.X_HW_Token=" + getValue('onttoken'),
            url : 'add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration' 
                   + '&RequestFile=html/amp/wlanbasic/guidewificfg.asp',
            success : function(data) {
                var WlanListNow = [];
                $.ajax({
                    type : "post",
                    async : false,
                    cache : false,
                    url : "/html/amp/wificovercfg/getSsidlist.asp",
                    success : function(data) {  
                        WlanListNow = dealDataWithFun(data); 
                        var WlanNowMap = setWlanNowMap(WlanListNow);
                        wlanDomain = WlanNowMap[addSSID].domain;
                        SetWlanParaInfo(wlanDomain);
                    }
                });
                },
                complete: function (XHR, TS) {
                                XHR=null;
                 }
            });
}

function iotSubmitForm()
{
    if(top.enableIotSsid == 0) {
        guideJumpNext();
        return;
    }

    if (iotSsidInst != 0) {
        AlertEx(cfg_wifiguide_language['amp_wifiguide_existiotssid']);
        guideJumpNext();
        return;
    }

   var ssid = getValue("iotwifiname");
   var pwd = getValue("iotwifipwd");
   if (!CheckSsid(ssid)) {
        return;
   }

    if (!checkIotSSIDExist(ssid, allWlanInfo)) {
        return;
    }

    if (!CheckPsk(pwd)) {
        return;
    }

    addSubmit();

    guideJumpNext();
}
function iotSsidguide_pre()
{
    setDisplay('iotwifitable', 0);
    setDisplay("wifiCfgInfo", 1);
    top.showIotSsidFlag = 0;
}

function setPwdText(idx)
{
	var pwdId = idx?"pwd_wifipw_5G":"pwd_wifipw";
	var txtId = idx?"txt_wifipw_5G":"txt_wifipw";
	if(encryTypeArr[idx] == "none")
	{
		setText(pwdId, "");
	}
	else
	{
		var pwd = (encryTypeArr[idx] == "wep")?(idx?wep5:wep1):(idx?psk5:psk1);
		setText(pwdId, pwd);
		setText(txtId, pwd);
	}
}

function setIotSsidPwdText(iotWlan)
{
    var pwdId = "iotwifipwd";
    var txtId = "txt_iotwifipwd";
    if(encryTypeArr[0] == "none") {
        setText(pwdId, "");
    } else {
        var psk= getPsk(iotWlan.InstId, allPsk);
        var wep = getWep(iotWlan.InstId, iotWlan.KeyIndex, allWep);
        var pwd = (encryTypeArr[0] == "wep") ? wep:psk;
        setText(pwdId, pwd);
        setText(txtId, pwd);
        setText("iotwifiname", iotWlan.ssid);
    }
}

function egvdfPwdStrengthcheck(id, pwdid)
{
    var score = 0;
    var password = getElementById(id).value;

    if (password.match(/[a-z]/)) {
        score++;
    }

    if (password.match(/[A-Z]/)) {
        score++;
    }

    if (password.match(/\d/)) {
        score++;
    }

    if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) {
        score++;
    }

    if (password.length < 8) {
        score = 1;
    }

    if (score < 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=23+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FF0000";
    } else if (score == 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=60+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FFA500";
    } else if (score >= 3) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=100+"%";
        getElementById(pwdid).style.borderBottom="10px solid #008000";
    }
}


function pwdStrengthcheck(id,pwdid)
{
    if (CfgMode.toUpperCase() == "EGVDF2") {
        egvdfPwdStrengthcheck(id,pwdid);
        return;
    }

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

function EnableWiFi(id)
{		
    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        return;
    }

	var wlan;
	
	if(id=="enable2g")
	{
		enbl2G = 1 - enbl2G;
		wlan = wlan1;
		setRadioEnable(id ,enbl2G);
	}
	else
	{
		enbl5G = 1 - enbl5G;
		wlan = wlan5;
		setRadioEnable(id ,enbl5G);
	}
    SetRadioStyle();
}

function showIotInfo(enable)
{
    setRadioEnable("createiotssid" ,enable);
    setDisplay("iotssid_name", enable);
    setDisplay("iotssid_authtype", enable);
    setDisplay("iotssid_pwd", enable);
    var authMode = getSelectVal('iotauthmode');
    if (authMode == "open") {
        setDisplay("iotssid_pwd", 0);
    }
}

var clickIotFlag = top.enableIotSsid;
function ClickcreateIotSsid()
{
    clickIotFlag = (clickIotFlag == 1) ? 0 : 1;

    showIotInfo(clickIotFlag);

    setRadioEnable("createiotssid" ,clickIotFlag);
    SetRadioStyle();
    top.enableIotSsid = clickIotFlag;
}

function setRadioEnable(id ,enabled)
{
	if(1 == enabled)
	{
        if (CfgMode == "DICELANDVDF") {
            getElById(id).style.background = "url(../../../images/onred.jpg) no-repeat";
        } else {
            getElById(id).style.background = "url(../../../images/on.jpg) no-repeat";
        }
	}
	else
	{
		getElById(id).style.background = "url(../../../images/off.jpg) no-repeat";
	}
}

function IsTmczstShow5G() {
    if (((webEnable5G != 1) && (curUserType != 0)) || ((webAdminEnable5G != 1) && (curUserType == 0))) {
        return true;
    }

    return false;
}

function getIotSsid() {
    for (var i = 0; i < allWlanInfo.length; i++) {
        if (getInstIdByDomain(allWlanInfo[i].domain) == iotSsidInst) {
            return allWlanInfo[i];
        }
    }
    return "";
}

function DefaultAuthType(wlan) {
    var mode = wlan.BeaconType;
    if (mode == 'Basic') {
        var BasicAuthenticationMode = wlan.BasicAuthenticationMode;
        if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) {
            selectAuth = "open";
        }
    } else if (mode == 'WPA') {
        selectAuth = "wpa-psk";
    } else if ((mode == '11i') || (mode == 'WPA2')) {
        selectAuth = "wpa2-psk";
    } else if ((mode == 'WPAand11i') || (mode == 'WPA/WPA2')) {
        selectAuth = "wpa/wpa2-psk";
    } else if (mode == 'WPA3') {
        selectAuth = "wpa3-psk";
    } else if (mode == 'WPA2/WPA3') {
        selectAuth = "wpa2/wpa3-psk";
    } else {
        selectAuth = "wpa/wpa2-psk";
    }
}

function LoadFrame()
{
	$("#checkinfo1Row").css("display", "none");
	if (IsPtVdf ==1 || CfgMode.toUpperCase() == "EGVDF2")
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd1" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="amp_pwd_strength_low"></span> </div></div>';
	}	
	
	$("#checkinfo2Row").css("display", "none");
	if (IsPtVdf ==1 || CfgMode.toUpperCase() == "EGVDF2")
	{
		var pwdcheck2 = document.getElementById('checkinfo2');
		pwdcheck2.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd2" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue2" BindText="amp_pwd_strength_low"></span></div></div>';
	}	
	
	$(".textboxbg").addClass('tx_input');
	
    if (!isForceModifyPwd) {
        $("#guidesyscfg").width($("#span_skip").width());
    }
    
    getWlan();
	
    if(null != wlan1)
	{
		initWlanEncType(wlan1);
		setText("txt_wifiname", wlan1.ssid);
		setPwdText(0);
		enbl2G = Radio[0].Enable;
	}
	else
	{
		enbl2G = 0;
	}
	
	setRadioEnable("enable2g", enbl2G);
			
    setDisable("txt_wifiname", null==wlan1);
    setDisable("pwd_wifipw", null==wlan1);
    setDisable("txt_wifipw", null==wlan1);
    setDisplay("cb_2g_pwd", !((wlan1 == null) || (wifiPasswordMask == 1)));
    
    setDisable("txt_wifiname_5G", null==wlan5);
    setDisable("pwd_wifipw_5G", null==wlan5);
    setDisable("txt_wifipw_5G", null==wlan5);
    setDisplay("cb_5g_pwd", !((wlan5 == null) || (wifiPasswordMask == 1)));
    
    setDisable("btnNext", (null==wlan1 && null==wlan5));

	if (isShowWifiName()) {
        setDisplay("tr_wifiname", 1);
        if (DoubleFreqFlag == 1) {
            if ((tmczstFlag == 1) && IsTmczstShow5G()) {
                setDisplay("tr_wifiname_5G", 0);
                setDisplay("tdWifiEnable5G", 0);
            } else {
                setDisplay("tr_wifiname_5G", 1);
                setDisplay("tdWifiEnable5G", 1);
            }
        }
	}
    if(1 == DoubleFreqFlag)
    {
        if ((tmczstFlag == 1) && IsTmczstShow5G()) {
            return;
        }
        setDisplay('tr_wifion_5G', 1);
        setDisplay("tr_wifipw_5G", 1);
        if(null != wlan5)
		{
			initWlanEncType(wlan5);
			setText("txt_wifiname_5G", wlan5.ssid);
			setPwdText(1);
			enbl5G = Radio[1].Enable;
        }
		else
		{
			enbl5G = 0;
		}
		
		setRadioEnable("enable5g", enbl5G);
    }

    if (curLanguage.toUpperCase() == 'BRASIL') {
        $('#tdWiFiOn2g').css('float', 'none');
        $('#tdWiFiOn5g').css('float', 'none');
    }

    if (curLanguage.toUpperCase() == 'TURKISH') {
        $('#tdWifiauth2G').css('float', 'none');
        $('#tdWifiauth5G').css('float', 'none');
    }

    if (turkcellFlag == 1) {
        LoadAuth(); 
    }

    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        getElById("tdWiFiOn2g").innerHTML = cfg_wlancfgother_language['amp_wlan_enable'];
        getElById("tdWiFiName2G").innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname'];
        getElById("tdWiFiPwd2G").innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd'];
    }

    if (isVideoRetrans == 1) {
        setDisplay("tr_wifion_2G", 0);
        setDisplay("tr_wifiname", 0);
        setDisplay("tr_wifipw", 0);
    }

    if (typeof window.parent.adjustParentHeight == 'function') {
        window.parent.adjustParentHeight();
    }

    if (isDnzvdf == 1) {
        setDisplay("span_skip", 0);
    }

    SetBSDShow();
    setTimeout(function(){AlertSsidNeedCfg();}, 100);
    
    if ((fttrFlag == 1) && (window.parent.wifiPara != null)) {
		window.parent.setDisplay("framepageContent", 1);	
	}

    if ((fttrFlag == 1) && (curUserType == 0) && (currentBin.toUpperCase() == 'E8C')) {
        $(".textboxbg").removeClass('tx_input');
        SetRadioStyle();
    }

    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        setDisable("txt_wifiname", 1);
        setDisable("pwd_wifipw", 1);
        setDisable("txt_wifipw", 1);
        setDisable("cb_2g_pwd", 1);
        setDisable("txt_wifiname_5G", 1);
        setDisable("pwd_wifipw_5G", 1);
        setDisable("txt_wifipw_5G", 1);
        setDisable("cb_5g_pwd", 1);
    }

    if (fttrFlag == 1) {
        var iotWlan = wlan1;
        if (iotSsidInst != 0) {
            iotWlan = getIotSsid();
            initWlanEncType(iotWlan);
            setIotSsidPwdText(iotWlan);
        }
        DefaultAuthType(iotWlan);
        if (top.showIotSsidFlag == 1) {
            setDisplay('iotwifitable', 1);
            setDisplay("wifiCfgInfo", 0);
        } else {
            setDisplay('iotwifitable', 0);
            setDisplay("wifiCfgInfo", 1);
        }
        IotSsidAuthModeOption();
    }

    SetDomDisabled();
    setTimeout(function(){AlertSsidNeedCfg();}, 100);
}

function SetDomDisabled() {
    if ((CfgMode.toUpperCase() != 'COCLAROEBG4') || (curUserType != sptUserType)) {
        return;
    }

    setDisable('txt_wifiname', 1);
    $("#txt_wifiname").css("background-color","#CCCCCC");
    if (DoubleFreqFlag == 1) {
        setDisable('txt_wifiname_5G', 1);
        $("#txt_wifiname_5G").css("background-color","#CCCCCC");
    }
}

function SetRadioStyle() {
    $(".tb_radio").css({
        "height" : "24px",
        "line-height" : "22px",
        "background-size" :"70px 24px"
    });
}

function showPwd(id)
{
	var pwdId = "pwd_wifipw" + id;
	var txtId = "txt_wifipw" + id;
	
	if(getElById(pwdId).style.display == "none")
	{
		setDisplay(pwdId, 1);
		setDisplay(txtId, 0);
	}
	else
	{
		setDisplay(pwdId, 0);
		setDisplay(txtId, 1);
	}
}

function iotshowpwd(id)
{
    if(getElById("iotwifipwd").style.display == "none") {
        setDisplay("iotwifipwd", 1);
        setDisplay("txt_iotwifipwd", 0);
    } else {
        setDisplay("iotwifipwd", 0);
        setDisplay("txt_iotwifipwd", 1);
    }
}

function AddConfigFlag()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
		 ;
		}
	}); 
}

function guide_pre(obj)
{
    if (ProductType == '2') {
        if (DBAA1 == "1") {
            if (curUserType == dbaa1SuperSysUserType) {
                window.parent.onchangestep(obj);
            } else {
                AddConfigFlag();
                window.parent.location="../../../index.asp";
            }
            return;
        }

        if(curUserType != sysUserType)
        {
            if (CfgMode.toUpperCase() != 'DETHMAXIS') {
                if (!isForceModifyPwd) {
                    obj.name = "/html/bbsp/guideinternet/guideinternet.asp";
                    obj.id = "guideinternet";
                }
            }
        } else {
            if (SupportTtnet()) {
                obj.name = "/html/bbsp/guideinternet/guideinternet.asp";
                obj.id = "guideinternet";
            }
        }

        window.parent.onchangestep(obj);
    }
    else
    {
        if ('1' == smartlanfeature)
        {
            if(-1 != PPPoEWanid)
            {
                window.parent.onchangestep(obj);
            }
            else
            {
                AddConfigFlag();
                window.parent.location="../../../index.asp";
            }
        }
        else
        {
            if(false == GetInternetFlag())
            {
                AddConfigFlag();
                if ((fttrFlag == 1) && (curUserType == 0) && (currentBin.toUpperCase() == 'E8C')) {
                    window.parent.location="../../../CustomApp/Aindex.asp";
                } else {
                    window.parent.location="../../../index.asp";
                }
            }
            else
            {
                window.parent.onchangestep(obj);
            }
        }
    }
}

function guide_skip(obj)
{
	if(false == GetInternetFlag())
	{
		AddConfigFlag();
	}
	
	window.parent.onchangestep(obj);
}

function AuthModeChange(domId) {
    var addIdName = (domId == 'wlAuthMode') ? '' : '_5G';
    var wlan = (domId == 'wlAuthMode') ? wlan1 : wlan5;
    var psk = (domId == 'wlAuthMode') ? psk1 : psk5;
    setVisible("tr_wifipw" + addIdName, 0);
    var authMode = getSelectVal('wlAuthMode' + addIdName);

    switch (authMode) {
        case 'open':
            AddEncryMethodOption(authMode, addIdName);
            setSelect('wlEncryption' + addIdName, wlan.BasicEncryptionModes);
            break;
        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
        case 'wpa3-psk':
        case 'wpa2/wpa3-psk':
            setVisible("tr_wifipw" + addIdName, 1);
            if ((authMode == "wpa3-psk") || (authMode == "wpa2/wpa3-psk")) {
                AddEncryMethodOption("wpa3", addIdName);
            } else {
                AddEncryMethodOption("psk", addIdName);
            }

            if (authMode == 'wpa-psk') {
                setSelect('wlEncryption' + addIdName, wlan.WPAEncryptionModes);
            } else if (authMode == 'wpa2-psk') {
                setSelect('wlEncryption' + addIdName, wlan.IEEE11iEncryptionModes);
            } else {
                setSelect('wlEncryption' + addIdName, wlan.X_HW_WPAand11iEncryptionModes);
            }

            setText('pwd_wifipw' + addIdName, psk);
            setText('txt_wifipw' + addIdName, psk);
            break;
        default:
            break;
    }
}

function IsAuthModeWithoutOpen() {
    if (((turkcellFlag == 1)) && (curUserType == sptUserType)) {
        return true;
    }

    return false;
}

var selectAuth = 'open';
var selectAuth5G = 'open';

function SetSelectAuth(freq, value) {
    if (freq == '2G') {
        selectAuth = value;
    } else {
        selectAuth5G = value;
    }
}

initWlanCap('2G');
var wepCap_2G = wepCap;
var capWPAPSK_2G = capWPAPSK;
var capWPAWPA2PSK_2G = capWPAWPA2PSK;
var capWpa3_2G = capWpa3;
var cap11ax_2G = cap11ax;

var wepCap_5G = 0;
var	capWPAPSK_5G = 0;
var	capWPAWPA2PSK_5G = 0;
var	capWpa3_5G = 0;
var	cap11ax_5G = 0;

if (DoubleFreqFlag == 1) {
    initWlanCap('5G');
    wepCap_5G = wepCap;
    capWPAPSK_5G = capWPAPSK;
    capWPAWPA2PSK_5G = capWPAWPA2PSK;
    capWpa3_5G = capWpa3;
    cap11ax_5G = cap11ax;
}

function AddAuthModeOption(freq) {
    var wlan = (freq == '2G') ? wlan1 : wlan5;
    var authModeId = (freq == '2G') ? 'wlAuthMode' : 'wlAuthMode_5G';
    var selLocalAuth = (freq == '2G') ? selectAuth : selectAuth5G;
    var wepCapLocal = (freq == '2G') ? wepCap_2G : wepCap_5G;
    var capWPAPSKLocal = (freq == '2G') ? capWPAPSK_2G : capWPAPSK_5G;
    var capWPAWPA2PSKLocal = (freq == '2G') ? capWPAWPA2PSK_2G: capWPAWPA2PSK_5G;
    var capWpa3Local = (freq == '2G') ? capWpa3_2G : capWpa3_5G;
    var cap11axLocal = (freq == '2G') ? cap11ax_2G : cap11ax_5G;

    if (nonWepFlag == 1) {
        wepCap = 0;
    }

    var authModes = { 'open' : [cfg_wlancfgdetail_language['amp_auth_open'], 1], 
                      'shared' : [cfg_wlancfgdetail_language['amp_auth_shared'], (wepCap == 1)], 
                      'wpa-psk' : [cfg_wlancfgdetail_language['amp_auth_wpapsk'], (capWPAPSK == 1) && (WPAPSKFlag == '1')], 
                      'wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1], 
                      'wpa/wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], (capWPAWPA2PSK == 1)], 
                      'wpa3-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa3psk'], (capWpa3 == 1) && (cap11ax == 1)], 
                      'wpa2/wpa3-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk'], (capWpa3 == 1) && (cap11ax == 1)]
                    };

    if (IsAuthModeWithoutOpen()) {
        var BasicAuthenticationMode = wlan.BasicAuthenticationMode;
        var BeaconType = wlan.BeaconType;

        if (((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) && (BeaconType == 'Basic')) {
            authModes['open'][0] = "";
        }

        if (!(((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) && (BeaconType == 'Basic'))) {
            authModes['open'][1] = 0;
        }
    }

    InitDropDownListWithSelected(authModeId, authModes, selLocalAuth);
}

function IotSsidAuthModeOption() {
    var authModeId = 'iotauthmode';
    var selLocalAuth = selectAuth;
    var authModes = { 'open' : ["OPEN", 1],
                      'wpa2-psk' : ["WPA2-PSK", 1], 
                      'wpa/wpa2-psk' : ["WPA/WPA2-PSK", (capWPAWPA2PSK == 1)], 
                      'wpa3-psk' : ["WPA3-SAE", (capWpa3 == 1) && (cap11ax == 1)], 
                      'wpa2/wpa3-psk' : ["WPA2/WPA3-PSKandSAE", (capWpa3 == 1) && (cap11ax == 1)]
                    };
    InitDropDownListWithSelected(authModeId, authModes, selLocalAuth);
}

function AddEncryMethodOption(authMode, addIdName) {
    var wlan = (addIdName == '') ? wlan1 : wlan5;
    var mode = wlan.X_HW_Standard; 	
    $('#wlEncryption' + addIdName).empty();

    var wlEncryptionDom = getElementById('wlEncryption' + addIdName);
    if (authMode == "open") {
        wlEncryptionDom.options[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
    } else if (authMode == "wpa3") {
        wlEncryptionDom.options[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
    } else {
        if ((mode == "11n")|| (mode == "11aconly")) {
            wlEncryptionDom.options[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
        } else {
            wlEncryptionDom.options[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
            if(capTkip == '1') {
                wlEncryptionDom.options[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
                wlEncryptionDom.options[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
            }
        }
    }
}

function InitPskAuthShow(wlAuthMode, wlEncryption, authMode, freq) {
    var addIdName = (freq == '2G') ? '' : '_5G';
    var psk = (freq == '2G') ? psk1 : psk5;
    AddEncryMethodOption(authMode, addIdName);
    SetSelectAuth(freq, wlAuthMode);
    setSelect('wlEncryption' + addIdName, wlEncryption);

    setText('pwd_wifipw' + addIdName, psk);
    setText('txt_wifipw' + addIdName, psk);
}

function BeaconTypeChange(mode, wlan, freq) {
    var addIdName = (freq == '2G') ? '' : '_5G';
    if (mode == 'Basic') {
        var BasicAuthenticationMode = wlan.BasicAuthenticationMode;
        var BasicEncryptionModes = wlan.BasicEncryptionModes;

        if ((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) {
            AddEncryMethodOption('open', addIdName); 
            SetSelectAuth(freq, 'open');
            setSelect('wlEncryption' + addIdName, BasicEncryptionModes);
            setVisible("tr_wifipw" + addIdName, 0);
        }
    } else if (mode == 'WPA') {
        if (wlan.WPAAuthenticationMode == 'EAPAuthentication') {
            InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
        } else {
            InitPskAuthShow('wpa-psk', wlan.WPAEncryptionModes, "wpa-psk", freq);
        }
    } else if ((mode == '11i') || (mode == 'WPA2')) {
        if (wlan.IEEE11iAuthenticationMode == 'EAPAuthentication') {
            InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
        } else {
            InitPskAuthShow('wpa2-psk', wlan.IEEE11iEncryptionModes, "wpa2-psk", freq);
        }
    } else if ((mode == 'WPAand11i') || (mode == 'WPA/WPA2')) {
        if (wlan.X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
        } else {
            InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
        }
    } else if (mode == 'WPA3') {
        if (wlan.X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
        } else {
            InitPskAuthShow('wpa3-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa3", freq);
        }
    } else if (mode == 'WPA2/WPA3') {
        if (wlan.X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
        } else {
            InitPskAuthShow('wpa2/wpa3-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa3", freq);
        }
    } else {
        InitPskAuthShow('wpa/wpa2-psk', wlan.X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk", freq);
    }
}

function JudgeDFSCh(autoChannelScope) {
    var autoChScope = autoChannelScope.split(',');
    if ((autoChScope.length == 0) || (autoChScope == '0') || (autoChScope == '')) {
        return true;
    }

    for (var i = 0; i < autoChScope.length; i++) {
        if ((autoChScope[i] >= 52) && (autoChScope[i] <= 144)) {
            return true;
        }
    }
    return false;
}

function IsSelChannelDFS(thisChannel, autoChannelScope) {
    if (dfsChSwitch == 1) {
        if (thisChannel == 0) {
            if (JudgeDFSCh(autoChannelScope) == true) {
                return true;
            }
        }
    }

    return false;
}

function LoadChannelListByFreq(freq, channel) {
    var wlan = (freq == '2G') ? wlan1 : wlan5;
    var addIdName = (freq == '2G') ? '' : '_5G';
    var WebChannel = channel;
    var WebChannelValid = 0;
    var ShowChannels = possibleChannels.split(',');  
    var wlChannelDom = getElementById('wlChannel' + addIdName);

    if ((dfsChSwitch == 1) && (freq == "5G")) {
        wlChannelDom.options[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "-1");
        wlChannelDom.options[ShowChannels.length + 1] = new Option(cfg_wlancfgadvance_language['amp_common_auto_withoutdfs'], "0");
    } else {
        wlChannelDom.options[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");
    }

    for (var j = 1; j <= ShowChannels.length; j++) {
        if (WebChannel == ShowChannels[j-1]) {
            WebChannelValid = 1;
        }

        if (ShowChannels[j-1] != "") {
            wlChannelDom.options[j] = new Option(ShowChannels[j-1], ShowChannels[j-1]);
        }
    }

    if (freq != '2G') {
        if (IsSelChannelDFS(WebChannel, wlan.X_HW_AutoChannelScope)) {
            WebChannel = -1;
        }
    }

    if ((WebChannelValid == 1) || (WebChannel == -1)) {
        setSelect('wlChannel' + addIdName, WebChannel);
    } else {
        setSelect('wlChannel' + addIdName, 0);
    }
}

function GetPossibleChannels(freq, country, mode, width) {
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "../common/WlanChannel.asp?&1=1",
            data :"freq=" + freq + "&country=" + country + "&standard=" + mode + "&width=" + width,
            success : function(data) {
                possibleChannels = data;
                var lastIndex = possibleChannels.lastIndexOf(',');
                var index = possibleChannels.length;
                for (var i = lastIndex + 1; i < possibleChannels.length; i++) {
                    if ((possibleChannels.charCodeAt(i) < 0x30) || (possibleChannels.charCodeAt(i) > 0x39)) {
                        index = i;
                        break;
                    }
                }

                possibleChannels = possibleChannels.substring(0, index);
            }
        });
}

function CheckDFSChSwitch(channelWidth, regulatoryDomain) {
    if (regulatoryDomain == "JP") {
        dfsChSwitch = 0;
        return;
    }

    if (isDfsArea(regulatoryDomain) == 1) {
        dfsChSwitch = 1;
        var allChannels = possibleChannels;
        channelsWithOutDFS = getChannelWithOutDfs(allChannels, channelWidth);
    } else {
        dfsChSwitch = 0;
    }
}

function LoadChannelList(freq) {
    var wlan = (freq == '2G') ? wlan1 : wlan5;
    var addIdName = (freq == '2G') ? '' : '_5G';
    GetPossibleChannels(freq, wlan.RegulatoryDomain, wlan.X_HW_Standard, wlan.X_HW_HT20);
    var channel = wlan.Channel;

    if (wlan.AutoChannelEnable == 1) {
        channel = 0;
    }

    CheckDFSChSwitch(wlan.X_HW_HT20, wlan.RegulatoryDomain);
    LoadChannelListByFreq(freq, channel);
}

function LoadAuth() {
    if (turkcellFlag != 1) {
        return; 
    }

    setDisplay('tr_wifiauth', 1);
    setDisplay('tr_wifiencry', 1);
    setDisplay('tr_wifichannel', 1);
    BeaconTypeChange(wlan1.BeaconType, wlan1, '2G');
    AddAuthModeOption('2G');
    LoadChannelList('2G');

    if (wlan5_exist) {
        setDisplay('tr_wifiauth_5G', 1);
        setDisplay('tr_wifiencry_5G', 1);
        setDisplay('tr_wifichannel_5G', 1);
        BeaconTypeChange(wlan5.BeaconType, wlan5, '5G');
        AddAuthModeOption('5G');
        LoadChannelList('5G');
    }
}

function ClickBandSteeringPolicy() {
    setDisable('bandSteeringPolicyRadio', 1);
    bsdPolicy = 1 - bsdPolicy;
    setRadioEnable('bandSteeringPolicyRadio', bsdPolicy);
    SetPageShow();
    SetSsidForBSD();
    setDisable('bandSteeringPolicyRadio', 0);
}

function SetSsidForBSD() {
    var ssid2G;
    var ssid5G;
    if (bsdPolicy == 1) {
        ssid2G = getValue('txt_wifiname');
        setText('txt_wifiname', ssid2G);
    } else {
        ssid2G = getValue('txt_wifiname');
        ssid5G = getValue('txt_wifiname');
        ssid5G = (ssid5G.length > 27) ? ssid5G : ssid5G + '_5GHz';
        setText('txt_wifiname', ssid2G);
        setText("txt_wifiname_5G", ssid5G);
    }
}

function SetPageShow() {
    if (bsdPolicy == 1) {
        getElById('tdWiFiName2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname'];
        getElById('tdWiFiPwd2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd'];
        getElById('tdWifiauth2G').innerHTML = cfg_wlancfgdetail_language['amp_auth_mode'];
        getElById('tdWifiencry2G').innerHTML = cfg_wlancfgdetail_language['amp_encrypt_mode'];
        $('#tdWifiauth2G').removeClass('width_auto');
        setDisplay('tr_wifiname_5G', 0);
        setDisplay('tr_wifipw_5G', 0);
        setDisplay('tr_wifiauth_5G', 0);
        setDisplay('tr_wifiencry_5G', 0);
    } else {
        getElById('tdWiFiName2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname_2G'];
        getElById('tdWiFiPwd2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd_2G'];
        getElById('tdWifiauth2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiauth_2G'];
        getElById('tdWifiencry2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiencrypt_2G'];
        $('#tdWifiauth2G').addClass('width_auto');
        setDisplay('tr_wifiname_5G', 1);
        setDisplay('tr_wifipw_5G', 1);
        setDisplay('tr_wifiauth_5G', 1);
        setDisplay('tr_wifiencry_5G', 1);
    }
}

function SetBSDShow() {
    if (IsShowBSD()) {
        setDisplay('tr_bsd', 1);
        bsdPolicy = XHWGlobalConfig.BandSteeringPolicy;
        setRadioEnable('bandSteeringPolicyRadio', bsdPolicy);
        SetPageShow();
    } else {
        setDisplay('tr_bsd', 0);
    }

    if ((turkcellFlag == 1) && (curUserType != 0)) {
        setDisplay('tr_bsd', 0);
    }
}

function IsAdminUser() {
    if ((curUserType == sysUserType) || ((CfgMode.toUpperCase() == 'DETHMAXIS') && (curUserType == sptUserType))) {
        return true;
    }

    return false;
}

</script>
	
<style type="text/css">
    .tx_input
    {
		-webkit-border-radius: 4px;
		-moz-border-radius: 4px;
		border-radius: 4px;
		border: 1px solid #CECACA;
		vertical-align: middle;
		font-size: 16px;
		height: 32px;
		width: 228px;
		padding-left: 5px;
		margin-left: 0px;
		line-height: 32px;
		background-color: #ffffff;
    }
	.gray{
		color: #767676;
	};
</style>
</head>

<script>
	if(curLanguage == 'arabic')
	{
		document.write('<body onLoad="LoadFrame();" style="background-color: #ffffff;margin-top: 35px; direction: rtl;">');
	}
	else{

		document.write('<body onLoad="LoadFrame();" style="background-color: #ffffff;margin-top: 35px;">');
	}
</script>

<div align="center"> 
<div id="wifiCfgInfo">
<table align="center" border="0" cellpadding="5" cellspacing="1">
	<tr>
		<td></td>
		<td colspan="2" align="left" style="font-size:16px;color:#666666;font-weight:bold;padding-bottom: 16px;"><script>document.write(cfg_wifiguide_language['amp_wifiguide_title']);</script></td>    
	</tr>
	<tr id="tr_bsd" style="display:none;"> 
		<td  class="labelBox"><script>document.write(cfg_wlancfgadvance_language['amp_BandSteering']);</script></td>
		<td><div id="bandSteeringPolicyRadio" class="tb_radio" onClick="ClickBandSteeringPolicy();"></div></td>
	</tr>
    <tr id="tr_wifion_2G">
		<td id='tdWiFiOn2g'  class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifi2on']);</script></td>
		<td><div id="enable2g" class="tb_radio" onClick="EnableWiFi(this.id);"></div></td>
	</tr>
	<tr id="tr_wifiname" style="display:none;"> 
		<td  class="labelBox" id='tdWiFiName2G'><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifiname_2G']);</script></td>
		<td> <input type="text" name="txt_wifiname" id="txt_wifiname" class="textboxbg" maxlength="32"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"><script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></td>
	</tr>
		<tr id="tr_wifichannel" style="display:none;"> 
		<td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifichannel_2G']);</script></td>
		<td><select id='wlChannel' size="1" class="textboxbg"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"></td>
	</tr>
	<tr id="tr_wifiauth" style="display:none;"> 
		<td id='tdWifiauth2G' class="labelBox width_auto"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifiauth_2G']);</script></td>
		<td><select id='wlAuthMode' size="1" onChange='AuthModeChange(this.id)' class="textboxbg"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"></td>
	</tr>
	<tr id="tr_wifiencry" style="display:none;"> 
		<td id='tdWifiencry2G' class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifiencrypt_2G']);</script></td>
		<td><select id='wlEncryption' size="1" class="textboxbg"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"></td>
	</tr>
	
	<tr id="tr_wifipw"> 
		<td class="labelBox" id='tdWiFiPwd2G'><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifipwd_2G']);</script></td>
		<td> 
			<input type="password" autocomplete="off" name="pwd_wifipw" id="pwd_wifipw" class="textboxbg" onchange="pwd=getValue('pwd_wifipw');getElById('txt_wifipw').value = pwd;">
			<input type="text" autocomplete="off" name="txt_wifipw" id="txt_wifipw" class="textboxbg" style="display:none;" onchange="pwd=getValue('txt_wifipw');getElById('pwd_wifipw').value = pwd;">
		</td>
		<td style='text-align: left;'>
			<input  id="cb_2g_pwd" type="checkbox" checked="true" onClick="showPwd('');"/>
			<span class="gray" style="font-size: 14px;"><script>document.write(cfg_wifiguide_language['amp_wifipage_hidepwd']);</script></span>
			<span id="pwd_notice" class="gray" style="font-size: 14px; width:200px; text-align: left;" />
		</td>
	</tr>
    <tr id = "checkinfo1Row" style="display:none;">
	  <td id = "checkinfotitel" class="labelBox" ><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifipwd_2G_Strength']);</script></td>
	  <td id = "checkinfo1" class="table_title width_per25"></td>
		<script>		
		$('#pwd_wifipw').on('keyup',function(){
			if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
			{
				$("#checkinfo1Row").css("display", "");
				$("#psd_checkpwd1").css("display", "block");
				psdStrength1("pwd_wifipw");
			}
		});	
		$('#txt_wifipw').on('keyup',function(){
			if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
			{
				$("#checkinfo1Row").css("display", "");
				$("#psd_checkpwd1").css("display", "block");
				psdStrength1("txt_wifipw");
			}
		});	
		</script>
	</tr>

    
    <tr id='tr_wifion_5G' style='display:none;'>
		<td id='tdWiFiOn5g' class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifi5on']);</script></td>
		<td><div id="enable5g" class="tb_radio" onClick="EnableWiFi(this.id);"></div></td>
	</tr>
    <tr id="tr_wifiname_5G" style="display:none;"> 
		<td  class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifiname_5G']);</script></td>
		<td> <input type="text" name="txt_wifiname_5G" id="txt_wifiname_5G" class="textboxbg" maxlength="32"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"><script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></td>
	</tr>
	<tr id="tr_wifichannel_5G" style="display:none;"> 
		<td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifichannel_5G']);</script></td>
		<td><select id='wlChannel_5G' size="1" class="textboxbg"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"></td>
	</tr>
	<tr id="tr_wifiauth_5G" style="display:none;"> 
		<td id='tdWifiauth5G' class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifiauth_5G']);</script></td>
		<td><select id='wlAuthMode_5G' size="1" onChange='AuthModeChange(this.id)' class="textboxbg"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"></td>
	</tr>
	<tr id="tr_wifiencry_5G" style="display:none;"> 
		<td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifiencrypt_5G']);</script></td>
		<td><select id='wlEncryption_5G' size="1" class="textboxbg"></td>
	    <td class="gray" style="font-size: 14px; text-align: left;"></td>
	</tr>
	
	<tr id="tr_wifipw_5G" style="display:none;"> 
		<td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifipwd_5G']);</script></td>
		<td> 
			<input type="password" autocomplete="off" name="pwd_wifipw_5G" id="pwd_wifipw_5G" class="textboxbg" onchange="pwd=getValue('pwd_wifipw_5G');getElById('txt_wifipw_5G').value = pwd;">
			<input type="text" autocomplete="off" name="txt_wifipw_5G" id="txt_wifipw_5G" class="textboxbg" style="display:none;" onchange="pwd=getValue('txt_wifipw_5G');getElById('pwd_wifipw_5G').value = pwd;">
		</td>
		<td style='text-align: left;'>
			<input  id="cb_5g_pwd" type="checkbox" checked="true" onClick="showPwd('_5G');"/>
			<span class="gray" style="font-size: 14px;"><script>document.write(cfg_wifiguide_language['amp_wifipage_hidepwd']);</script></span>
			<span id="pwd_notice_5G" class="gray" style="font-size: 14px; width:200px; text-align: left;" />
		</td>
			</tr>
	<tr id = "checkinfo2Row" style="display:none;">
	  <td id = "checkinfotite2" class="labelBox" ><script>document.write(cfg_wifiguide_language['amp_wifiguide_wifipwd_5G_Strength']);</script></td>
	  <td id = "checkinfo2" class="table_title width_per25"></td>
		<script>		
		$('#pwd_wifipw_5G').on('keyup',function(){
			if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
			{
				$("#checkinfo2Row").css("display", "");
				$("#psd_checkpwd2").css("display", "block");
				psdStrength2("pwd_wifipw_5G");
			}
		});	
		$('#txt_wifipw_5G').on('keyup',function(){
			if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
			{
				$("#checkinfo2Row").css("display", "");
				$("#psd_checkpwd2").css("display", "block");
				psdStrength2("txt_wifipw_5G");
			}
		});	
		</script>
	</tr>
    
    
	<tr>
	<td></td>
	<td align="left"  id="DSL_Arbic" colspan="2" style="padding-top: 20px;">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <script>
		if(CfgMode == "GLOBE2")
		{	
			if(curUserType == 0)
			{
				document.write('<input id="guidewancfg" name="../../html/bbsp/wan/wan.asp?cfgguide=1" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre_globe(this)"/>');
			}
			else
			{
				document.write('<input type="button" id="guidewancfg" name="" class="CancleButtonCss buttonwidth_100px" onClick="Clickexit(this);" />');
			}			
		}
		
        else if (ProductType == '2' && IsTedata != 1)
        {
            if (window.parent.UserGuideSteps == 1) {
                if(IsAdminUser()) {
                    document.write('<input id="guidewancfg" name="../../html/bbsp/wan/wan.asp?cfgguide=1" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre_globe(this)"/>');
                } else {
                    document.write('<input type="button" id="guidewancfg" name="" class="CancleButtonCss buttonwidth_100px" onClick="SubmitPre();" />');
                }
            } else if ((CfgMode.toUpperCase() == "DETHMAXIS") && (IsAdminUser() == true)) {
		        document.write('<input id="guidevoiceconfig" name="../../html/voip/voipinterface/guidevoice.asp" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);">');
            } else if (isForceModifyPwd) {
                document.write('<input id="guidesyscfg" name="../../html/ssmp/accoutcfg/guideaccountcfg.asp" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);">');
            } else {
                document.write('<input id="guidewancfg" name="../../html/bbsp/wan/wan.asp?cfgguide=1" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);">');
            }		
		}
		else
		{
			document.write('<input id="guideinternet" name="../../html/bbsp/guideinternet/guideinternet.asp" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);">');
		}
        </script>
        <script>
        if(CfgMode.toUpperCase() == "GLOBE2") {
            if(curUserType == 0) {
                setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_prestep']);
            } else {
                setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_exit']);
            }
        } else if (DBAA1 == "1") {
            if (curUserType == dbaa1SuperSysUserType) {
                setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_prestep']);
            } else {
                setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_exit']);
            } 
        } else if ((CfgMode.toUpperCase() == "DETHMAXIS") && (IsAdminUser() == true)) {
                setText('guidevoiceconfig', cfg_wifiguide_language['amp_wifiguide_prestep']);
            } else {
            if (ProductType == '2' && IsTedata != 1) {
                if (window.parent.UserGuideSteps == 1) {
                    if(IsAdminUser()) {
                        setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_prestep']);
                    } else {
                        setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_exit']);
                    }
                } else if (isForceModifyPwd) {
                    setText('guidesyscfg', cfg_wifiguide_language['amp_wifiguide_prestep']);
                } else {
                    setText('guidewancfg', cfg_wifiguide_language['amp_wifiguide_prestep']);
                }
            } else {
                if ('1' == smartlanfeature) {
                    if (-1 != PPPoEWanid) {
                        setText('guideinternet', cfg_wifiguide_language['amp_wifiguide_prestep']);
                    } else {
                        setText('guideinternet', cfg_wifiguide_language['amp_wifiguide_exit']);
                    }
                } else {
                    if (false == GetInternetFlag()) {
                        setText('guideinternet', cfg_wifiguide_language['amp_wifiguide_exit']);
                    } else {
                        setText('guideinternet', cfg_wifiguide_language['amp_wifiguide_prestep']);
                    }
                }
            }
        }
		</script>
		</input>
		<input id="btnNext" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm(this);">
		<script>getElById('btnNext').value = cfg_wifiguide_language['amp_wifiguide_nextstep'];</script>
		</input>
		<script type="text/javascript">
			var output ="";
			if (CfgMode == "DSLSTC2WIFI")
			{
				output += '<a id="guidesyscfg" name="/html/ssmp/accoutcfg/guideaccountcfg_xdstc.asp" href="#" style="display:block; margin-top: -26px;margin-left: 250px;font-size:16px;text-decoration: none;color: #666666;" onclick="guide_skip(this);">';
			} else if ((fttrFlag == 1) && (IsCTRG == 1)) {
                output += '<a id="guidelanconfig" name="/html/bbsp/lanservicecfg/lanservicecfg.asp" href="#" style="display:block; margin-top: -26px;margin-left: 250px;font-size:16px;text-decoration: none;color: #666666;" onclick="window.parent.onchangestep(this);">';
            } else if (IsTedata == 1) {
				output += '<a id="guidesyscfg" name="/html/ssmp/cfgguide/userguidecfgdone.asp" href="#" style="display:block; margin-top: -26px;margin-left: 250px;font-size:16px;text-decoration: none;color: #666666;" onclick="guide_skip(this);">';
            } else if ((ProductType == '2') && isForceModifyPwd) {
                if (curUserType == sysUserType) {
                    output += '<a id="guidewancfg" name="/html/bbsp/wan/wan.asp?cfgguide=1" href="#" style="display:block; margin-top: -26px;margin-left: 250px;font-size:16px;text-decoration: none;color: #666666; width: 35px;" onclick="guide_skip(this);">';
                } else {
                    output += '<a id="guideinternet" name="../../html/bbsp/guideinternet/guideinternet.asp" href="#" style="display:block; margin-top: -26px;margin-left: 250px;font-size:16px;text-decoration: none;color: #666666; width: 35px;" onclick="guide_skip(this);">';
                }
            } else {
				output += '<a id="guidesyscfg" name="/html/ssmp/accoutcfg/guideaccountcfg.asp" href="#" style="display:block; margin-top: -26px;margin-left: 250px;font-size:16px;text-decoration: none;color: #666666;" onclick="guide_skip(this);">';
			}
			output += '<span id="span_skip"></span>'
			output +='</a>'
			document.write(output);
		
		if(curLanguage == 'arabic')
		{
			document.getElementById("DSL_Arbic").style.textAlign = "right";
			document.getElementById("guidesyscfg").style.marginRight = "250px";
		}
		else{

			document.getElementById("DSL_Arbic").textAlign = "left";
            if ((ProductType == '2') && isForceModifyPwd) {
                if (curUserType == sysUserType) {
                    document.getElementById("guidesyscfg").style.marginLeft = "0px";
                }
            } else {
                document.getElementById("guidesyscfg").style.marginLeft = "250px";
            }
		}
		document.getElementById("span_skip").innerHTML = cfg_wifiguide_language['amp_wifiguide_skip'];
		</script>
	</td>
	</tr>

</table>
</div>
<table id="iotwifitable" align="left" border="0" cellpadding="5" cellspacing="1" style="display:none;margin-left:200px;">
    <tr>
        <td></td>
        <td colspan="2" align="left" style="font-size:16px;color:#666666;font-weight:bold;padding-bottom: 16px;">
        <script>document.write(cfg_wifiguide_language['amp_wifiguide_iotssid']);</script></td>
    </tr>
    <tr id="iotSsid">
        <td  class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_createiotssid']);</script></td>
        <td><div id="createiotssid" class="tb_radio" onClick="ClickcreateIotSsid(this.id);" style="background: url(../../../images/off.jpg) no-repeat;"></div></td>
    </tr>
    <tr id="iotssid_name">
        <td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_iotwifissid']);</script></td>
        <td><input type="text" name="iotwifiName" id="iotwifiname" class="textboxbg" maxlength="32"></td>
        <td class="gray" style="font-size: 14px; text-align: left;"><script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></td>
    </tr>
    <tr id="iotssid_authtype">
        <td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_iotsafe']);</script></td>
        <td><select id='iotauthmode' size="1" onChange='IotAuthModeChange(this.id)' class="textboxbg">
        </select>
        </td>
        <td class="gray" style="font-size: 14px; text-align: left;"></td>
    </tr>
    <tr id="iotssid_pwd">
        <td class="labelBox"><script>document.write(cfg_wifiguide_language['amp_wifiguide_iotwifipwd']);</script></td>
        <td>
            <input type="password" autocomplete="off" id="iotwifipwd" class="textboxbg" onchange="pwd=getValue('iotwifipwd');getElById('txt_iotwifipwd').value = pwd;">
            <input type="text" autocomplete="off" id="txt_iotwifipwd" class="textboxbg" style="display:none;" onchange="pwd=getValue('txt_iotwifipwd');getElById('iotwifipwd').value = pwd;">
        </td>
        <td style='text-align: left;'>
            <input id="iotshowpwd" type="checkbox" checked="true" onClick="iotshowpwd();"/>
            <span class="gray" style="font-size: 14px;"><script>document.write(cfg_wifiguide_language['amp_wifipage_hidepwd']);</script></span>
            <span id="pwd_notice_iot" class="gray" style="font-size: 14px; width:200px; text-align: left;" ><script>document.write(cfg_wlancfgdetail_language['amp_wpa_psknote']);</script></span>
        </td>
    </tr>
    <tr>
    <td></td>
    <td align="left" id="iotsubmit" colspan="2" style="padding-top: 20px;">
        <input id="iotBtnprevious" style="margin-left:0px;" type="button" class="CancleButtonCss buttonwidth_100px" onClick="iotSsidguide_pre(this);">
        <script>getElById('iotBtnprevious').value = cfg_wifiguide_language['amp_wifiguide_prestep'];</script>
        </input>
        <input id="iotBtnNext" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="iotSubmitForm(this);">
        <script>getElById('iotBtnNext').value = cfg_wifiguide_language['amp_wifiguide_nextstep'];</script>
        </input>
    </td>
    </tr>
    <script>
    if (fttrFlag == 1) {
        showIotInfo(top.enableIotSsid);
    }
    </script>
</table>
</div>
</div>
</body>
</html>
