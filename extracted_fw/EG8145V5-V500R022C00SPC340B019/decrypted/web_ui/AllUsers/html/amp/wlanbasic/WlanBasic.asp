<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../common/<%HW_WEB_CleanCache_Resource(wlan_style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../../bbsp/common/wan_check.asp"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(ahcode.js);%>"></script>
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
<title>wireless basic configure</title>
<script language="JavaScript" type="text/javascript">

var BaseInstFacKeyChgF = '<%HW_WEB_GetBaseInstFacKeyChgF();%>';
var BaseInstFacKeyChgF2g = BaseInstFacKeyChgF.split(',')[0];
var BaseInstFacKeyChgF5g = BaseInstFacKeyChgF.split(',')[1];
var backupenable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_AIS_Backup.Enable);%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var sptUserType ='1';
var maxisNormalUserType = '2';
var gzcmccFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_GZCMCC);%>';
var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';
var PccwFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PCCW);%>';
var WapiFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WAPI);%>';
var OnlySsid1Flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_ONLY_SSID1);%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var jscmccFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCMCC);%>';
var ShowISPSsidFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SHOW_ISPSSID);%>';
var IspSSIDVisibility = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_ISPSSID_VISIBILITY);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var TypeWord='<%HW_WEB_GetTypeWordMode();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var WPAPSKFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_WPAPSK_SUPPORT);%>';
var noWep64Flag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NO_WEP_64);%>';
var AmpTDESepicalCharaterFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TDE_SEPCIAL_CHARACTER);%>';
var t2Flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TDEWIFI);%>';
var WPS20AuthSupported = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.WPS20AuthSupported.Enable);%>';
var nonWepFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NON_WEP);%>';
var WiFiUpStatus ='<%HW_WEB_WiFiUpLinkStatus();%>';
var OnlyTde2Flag= '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_ONLY_FOR_TDE);%>';
var TribandFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TRIBAND_AP);%>';
var ForbidAssocFT = '<%HW_WEB_GetFeatureSupport(AMP_FT_WLAN_FOBID_ASSOC);%>';
var fonEnable = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_FON);%>';
var OIFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_OI);%>';
var isVideoRetrans = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIDEO_TRANS);%>';
var FonSSID2GInst = 2;
var FonSSID5GInst = 6;
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var aisAp = '<%HW_WEB_GetFeatureSupport(FT_WLAN_AISAP);%>';
var aisApBackhaul  = '<%HW_WEB_GetFeatureSupport(FT_WLAN_AISAP);%>';
var prefixStr = '<%HW_WEB_GetSPEC(WLAN_SPEC_SSID_PREFIX.STRING);%>';

if (1 == fonEnable)
{
    FonSSID2GInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.FON.SSID2GINST);%>';
    FonSSID5GInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.FON.SSID5GINST);%>';
}
var ForbidAssocFlag = 0;
var staIsolationFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WIFI_STAISOLATION);%>';
var PTVDFFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>';
var HiLinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var DslTalkTalkFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
var trimssidFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NOT_TRIM_SSID);%>';
var BsdAutoSyncParaFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_BSD_AUTO_SYNC_PARA);%>';
var DefaultAesFlag = '<%HW_WEB_GetDefaultAesFlag();%>';
var viettelPrefixFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIETTEL_PREFIX);%>';
var HilinkStart = '<%HW_WEB_GetFeatureSupport(FEATURE_HILINK_START);%>';
var megacablePwd = '<%HW_WEB_GetFeatureSupport(FT_WLAN_MEGACABLEPWD);%>';
var TMCZSTflag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TMCZST);%>';
var webEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebEnable);%>';
var turkcellFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TURKCELL);%>';
var noApPinFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NOT_APPIN);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var maxStaNum = '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_STA_NUM.UINT32);%>';
var ttnet2Flag = '<%HW_WEB_GetFeatureSupport(FT_TTNET2_DEFAULT);%>';
var showWmmFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_DISPLAY_WMM);%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var bondingEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.BondingEnable);%>';
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var defaultPinSpec = '<%HW_WEB_GetSPEC(SPEC_WIFI_DEFAULT_PIN.STRING);%>';
var defaultWepSpec = '<%HW_WEB_GetSPEC(SPEC_WIFI_DEFAULT_WEP.STRING);%>';
var scnFT = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SCN_ROAM);%>';
var isShowGuestWifiPage = '<%HW_WEB_GetFeatureSupport(FT_WEB_GUEST_WIFI);%>';
var trueT3Flag = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>'
var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    if (curUserType == sysUserType) {
        isFitAp = 0;
    } else {
        isFitAp = 1;
    }
}
var serviceUrl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_ServiceManagement.URL);%>';

if (0 == HilinkStart)
{
	HiLinkRoll = 0;
}
var wep1password;
var wep2password;
var wep3password;
var wep4password;
var wpapskpassword;
var radiuspassword;
var radiusAccountpassword;
var telmexSpan = false;
var wep1PsdModFlag = false;
var wep2PsdModFlag = false;
var wep3PsdModFlag = false;
var wep4PsdModFlag = false;
var pskPsdModFlag = false;
var radPsdModFlag = false;
var radAccountFlag = false;
var wepOrigLen = 0;
var rosNeedAddEnable = 0;
var nowUsePushBut;
var isShowWpa3Eap = 0;
var firstLine = -1;
var curAuthMode = '';
var curMethod = '';

var jQ_IspDisabledItem = null;
var jQ_IspEnabledItem  = null;
var g_currentwlanInst  = null;

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var basic5GIfIndex = SsidPerBand;

if('CAMPUSLAN' == CfgMode.toUpperCase())
{
	ForbidAssocFlag = 1; 
}


if ('1' == TelMexFlag && 'SPANISH' == curLanguage.toUpperCase())
{
    telmexSpan = true;
}

if ((1 == ForbidAssocFT) && (curUserType == sptUserType))
{
    ForbidAssocFlag = 1;
}

function GetLanguageDesc(Name)
{
    return cfg_wlancfgdetail_language[Name];
}

var prefix = 'PLDTHOMEFIBR';

var wlanpage;
if (location.href.indexOf("WlanBasic.asp?") > 0)
{
    wlanpage = location.href.split("?")[1]; 
    top.WlanBasicPage = wlanpage;
}

wlanpage = top.WlanBasicPage;

initWlanCap(wlanpage);

if (typeof top.wlanBasic_selHighBand == 'undefined')
{
    top.wlanBasic_selHighBand = 0;
}

var SelHighBand = top.wlanBasic_selHighBand;

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

function IsSpecialSsidPrefix() {
    if (prefixStr != '') {
        return 1;
    }
    return 0;
}

function GetSpecialSsidPrefixTitle() {
    return prefixStr.substr(0, prefixStr.length - 1);
}

var specialPreflag = IsSpecialSsidPrefix();
var specialPreTitle = GetSpecialSsidPrefixTitle();

var scnVar = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.Enable);%>';

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

var WpsTimeInfo = '<%HW_WEB_GetWPSTime();%>';

function getWpsTimer()
{
	var wlandomain = Wlan[ssidIdx].domain;
    var wlanId = wlandomain.charAt(wlandomain.length - 1);

    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "refreshTime.asp?&1=1",
            data :"wlanid="+wlanId,
            success : function(data) {
                WpsTimeInfo = data;
            }
        });
}

function St11rEnable(domain, FBT_11rEnable) {
    this.domain = domain;
    this.FBT_11rEnable = FBT_11rEnable;
}
var enable11r = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_RoamProtocol, FBT_11rEnable ,St11rEnable, STATUS);%>;

var WpsIndex = WpsTimeInfo.split(',')[0];
var WpsTime = WpsTimeInfo.split(',')[1];
var WpsTimeHandle;

var SsidNum = '<%HW_WEB_GetSsidNum();%>';
var SsidNum2g = SsidNum.split(',')[0];
var SsidNum5g = SsidNum.split(',')[1];

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
var enbale = false;
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

function RandomString(length, chars) {
    var result = '';
    for (var i = length; i > 0; --i) {
        result += chars[Math.floor(Math.random() * chars.length)];
    }
    return result;
}

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;

if (CfgMode.toUpperCase() == 'DBAA1') {
    for (var i = 0; i < g_keys.length - 1; i++) {
        if (g_keys[i].value == defaultWepSpec) {
            g_keys[i].value = RandomString(13, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
        }
    }
}
if (null != g_keys)
{
    wep1password = g_keys[0];
    wep2password = g_keys[1];
    wep3password = g_keys[2];
    wep4password = g_keys[3];
}

function rosIsolation(domain, X_HW_IsolationEnable) {
    this.domain = domain;
    this.X_HW_IsolationEnable = X_HW_IsolationEnable;
}

var rosIsolationEnable =<%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AttachConf, X_HW_IsolationEnable,rosIsolation);%>;

var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey|KeyPassphrase,stPreSharedKey);%>;

var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,X_HW_ConfigMethod|DevicePassword|X_HW_PinGenerator|Enable,stWpsPin,STATUS);%>;

function stXHWAdvanceCfg(domain, value)
{
    this.domain = domain;
    this.value = value;
}

var XHWAdvanceCfg = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.1.X_HW_AdvanceCfg,UsersPerSSIDEnable,stXHWAdvanceCfg);%>;

XHWAdvanceCfg = XHWAdvanceCfg[0];

function stGuestSsid(domain, SSID_IDX, Enable)
{
    this.domain = domain;
    this.SSID_IDX = SSID_IDX;
    this.Enable = Enable;
}

var GuestSsidList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.{i}, SSID_IDX|Enable, stGuestSsid);%>;

function IsGuestSsid(wlanInst)
{
    for (var i = 0; i < GuestSsidList.length - 1; i++)
    {
        if (wlanInst == GuestSsidList[i].SSID_IDX)
        {
            return true;        
        }
    }

    return false;
}


function BackHaul(domain, enable) {
    this.domain = domain;
    this.enable = enable;
}

var backHaulList = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_Backhaul, Enable, BackHaul);%>;
var baskHaul = backHaulList[0];

if (baskHaul == null) {
    baskHaul = new BackHaul("","");
} 

function StApDevice(domain, DeviceType, SerialNumber, DeviceStatus, UpTime, WorkingMode, SyncStatus, SupportedWorkingMode, SupportedRFBand, SupportedSSIDNumber, UpAccessSsidInst) {
    this.domain = domain;
    this.DeviceType = DeviceType;
    this.SerialNumber = SerialNumber;
    this.DeviceStatus = DeviceStatus;
    this.UpTime = UpTime;
    this.WorkingMode = WorkingMode;
    this.SyncStatus = SyncStatus;
    this.SupportedWorkingMode = SupportedWorkingMode;
    this.SupportedRFBand = SupportedRFBand;
    this.SupportedSSIDNumber = SupportedSSIDNumber;
    this.UpAccessSsidInst = UpAccessSsidInst;
}

var apDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}, DeviceType|SerialNumber|DeviceStatus|UpTime|WorkingMode|SyncStatus|SupportedWorkingMode|SupportedRFBand|SupportedSSIDNumber|UpAccessSsidInst, StApDevice);%>;
var usefulApDeviceList = new Array();
for (var i = 0; i < apDeviceList.length - 1; i++) {
    if ((apDeviceList[i].DeviceType != '') && (apDeviceList[i].SerialNumber != '')) {
        usefulApDeviceList.push(apDeviceList[i]);
    }
}
var apNum = usefulApDeviceList.length;

var radiusAccountList = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.Accounting, Enable|ServerPort|SecondaryServerIPAddr|SecondarySecret, StRadiusAccount);%>;

function StRadiusAccount(domain, Enable, ServerPort, SecondaryServerIPAddr, SecondarySecret)
{
    this.domain = domain;
    this.Enable = Enable;
    this.ServerPort = ServerPort;
    this.SecondaryServerIPAddr = SecondaryServerIPAddr;
    this.SecondarySecret = SecondarySecret;
}

function aisapBandSteeringInfo(domain, enableSSID1_5, enableSSID2_6, enableSSID3_7, enableSSID4_8)
{
    this.domain = domain;
    this.enableSSID1_5 = enableSSID1_5;
    this.enableSSID2_6 = enableSSID2_6;
    this.enableSSID3_7 = enableSSID3_7;
    this.enableSSID4_8 = enableSSID4_8;
}

if (CfgMode.toUpperCase() == 'AISAP') {
    var aisapBSDInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_AIS_BandSteering,SSID1-5_enable|SSID2-6_enable|SSID3-7_enable|SSID4-8_enable, aisapBandSteeringInfo);%>;
    var aisapBSDInfo = aisapBSDInfos[0];
}

function IsOnlyPbc() {
    if ((CfgMode.toUpperCase() == 'ROSUNION') || (CfgMode.toUpperCase() == 'DBAA1')) {
        return true;
    }
    return false;
}

function isBsdSsid()
{
	if (1 == DoubleFreqFlag)
	{
		for (i = 0; i < Wlan.length; i++)
		{
			if ((getWlanPortNumber(Wlan[i].name) < SsidPerBand) && ("2G" == wlanpage)) 
			{
				continue;
			}
        
			if ((getWlanPortNumber(Wlan[i].name) >= SsidPerBand) && ("5G" == wlanpage)) 
			{
				continue;
			}
		
			if (Wlan[ssidIdx].ssid == Wlan[i].ssid)
			{
				return true;
			}
		}
	}
	else 
	{
		return false;
	}
}

function isBsdPskPwdChange()
{
	var value = getValue('wlWpaPsk');
	if ((isFireFox4 == 1) &&  (value == ''))
	{
		value = wpapskpassword;
	}
  
	if (wifiPasswordMask == '1')
	{
		if ((value != "********") || (pskPsdModFlag == true))
		{	
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		if (value != wpaPskKey[ssidIdx].value)
		{
			return true;
		}
		else 
		{
			return false;
		}
	}
}

function isBsdParamChange()
{
	var ssid = ltrim(getValue('wlSsid'));
	var AuthMode = getSelectVal('wlAuthMode');
	var Encryption = getSelectVal('wlEncryption');
	
	if (Wlan[ssidIdx].ssid != ssid)
	{
		return true;
	}
	
	if ((AuthMode == 'open') && (Encryption == 'None'))
	{
		if ((Wlan[ssidIdx].BeaconType != 'Basic') 
			|| ((Wlan[ssidIdx].BasicAuthenticationMode != 'None') && (Wlan[ssidIdx].BasicAuthenticationMode != 'OpenSystem'))
			|| (Wlan[ssidIdx].BasicEncryptionModes != 'None'))
		{
			return true;
		}
		else 
		{
			return false;
		}
	} else if (isAuthModePreSharedKey(AuthMode)) {
		if (AuthMode == 'wpa-psk')
		{
			if ((Wlan[ssidIdx].BeaconType != 'WPA') 
			|| (Wlan[ssidIdx].WPAAuthenticationMode != 'PSKAuthentication')
			|| (Wlan[ssidIdx].WPAEncryptionModes != Encryption))
			{
				return true;
			}
		}
		else if (AuthMode == 'wpa2-psk')
		{
			if (((Wlan[ssidIdx].BeaconType != '11i') && (Wlan[ssidIdx].BeaconType != 'WPA2')) 
			|| (Wlan[ssidIdx].IEEE11iAuthenticationMode != 'PSKAuthentication')
			|| (Wlan[ssidIdx].IEEE11iEncryptionModes != Encryption))
			{
				return true;
			}
		}
		else if (AuthMode == 'wpa/wpa2-psk')
		{
			if (((Wlan[ssidIdx].BeaconType != 'WPAand11i') && (Wlan[ssidIdx].BeaconType != 'WPA/WPA2')) || 
				(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode != 'PSKAuthentication') || 
				(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes != Encryption)) {
				return true;
			}
		} else if (AuthMode == 'wpa3-psk') {
			if ((Wlan[ssidIdx].BeaconType != 'WPA3') || 
				(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode != 'SAEAuthentication') || 
				(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes != Encryption)) {
				return true;
			}
		} else if (AuthMode == 'wpa2/wpa3-psk') {
			if ((Wlan[ssidIdx].BeaconType != 'WPA2/WPA3') || 
				(Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode != 'PSKandSAEAuthentication') || 
				(Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes != Encryption)) {
				return true;
			}
		}
		
		if (isBsdPskPwdChange() == true)
		{
			return true;
		}
		else 
		{
			return false;
		}
	}
	
	return false;
}
	
function isBsdAutoSyncPara()
{
	if ((1 == DoubleFreqFlag) && (1 == XHWGlobalConfig.BandSteeringPolicy) 
		&& (1 == BsdAutoSyncParaFlag) && (true == isBsdSsid()) && (true == isBsdParamChange()))
	{
		return true;
	}
	else 
	{
		return false;
	}
}

var ssidIdx = -1;
var ssidAccessAttr = 'Subscriber';
var AddFlag = true;
var currentWlan = new stWlan();


function wlanSetSelect(id, val)
{
	setSelect(id, val);
	
	if(id == 'wlKeyBit')
	{
		wlKeyBitChange();
	}
}

var uiFirstRecordFor5G = 0;
var RecordFor5G = 0;
var flag5Ghide = 0;
var first5GIfIndex = basic5GIfIndex;
if (isSetTriBand() && (1 == SelHighBand))
{
	first5GIfIndex = basic5GIfIndex * 2;
}

function FirstRecordFor5G()
{
    if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
    {
        for (var loop = 0; loop < WlanMap.length; loop++)
        {
            if (WlanMap[loop].portIndex > (first5GIfIndex-1))
            {
                uiFirstRecordFor5G = parseInt(getIndexFromPort(WlanMap[loop].portIndex));
                WlanWifi = WlanWifiArr[uiFirstRecordFor5G]; 
                if (null == WlanWifi)
                {
                    WlanWifi = new stWlanWifi("","","","","11n","","","","","");
                } 
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
            if (WlanMap[loop].portIndex < basic5GIfIndex)
            {
                uiFirstRecordFor2G = parseInt(getIndexFromPort(WlanMap[loop].portIndex));
                WlanWifi = WlanWifiArr[uiFirstRecordFor2G]; 
                if (null == WlanWifi)
                {
                    WlanWifi = new stWlanWifi("","","","","11n","","","","","");
                }            
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
        
        if (getWlanPortNumber(Wlan[loop].name) > (basic5GIfIndex-1))
        {
            uiTotal5gNum++;
        }
        else
        {
            uiTotal2gNum++;
        }
    }
}

var WlanMap = new Array();
var j = 0;
for (var i = 0; i < Wlan.length; i++)
{
    var index = getWlanPortNumber(Wlan[i].name);
    
    WlanMap[j] = new stIndexMapping(i,index);
    j++;

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

var TriHighBandNum = 0;
TriHighBandNum = getTriHighBandNum();
function getTriHighBandNum()
{
	var highBandNum = 0;
    if ((1 == DoubleFreqFlag) && ("5G" == wlanpage) && (1 == TriBandHighBandEnable))
    {
        for (var loop = 0; loop < WlanMap.length; loop++)
        {
            if (WlanMap[loop].portIndex > (basic5GIfIndex * 2-1))
            {
                highBandNum++;
            }
        }
    }

	return highBandNum;
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
    if (defaultPinSpec == PIN)
    {
        return 1;
    }
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
    setDisable('Newbutton', 1);
    setDisable('DeleteButton', 1);
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
}

var pinlock = 0;
function sendPinEvent(PinCheckFlag)
{
    var datavalue = 0;
    pinlock = 0;
    var portIndex = getPortFromIndex(ssidIdx);
    var PinId = ((portIndex < 4) ? 1 : 2);
    
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "WlanWpsPin.asp?&1=1",
            data :"PinId="+PinId+"&PinCheckFlag="+PinCheckFlag,
            success : function(data) {
            datavalue = data.split("\r");
            }
        });
    
    pinlock = datavalue[0];
    stapinlock = stapinlock.split("");
    stapinlock[PinId-1] = ''+pinlock;
    stapinlock = stapinlock.join("");

    return pinlock;
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

function IsAuthModeWithoutOpen() {
    if (((CfgMode.toUpperCase() == 'DTURKCELL2WIFI') || (turkcellFlag == 1)) && (curUserType == sptUserType)) {
        return true;
    }

    return false;
}

function ModifyOpenAuthMode() {
    if (ssidIdx == -1) {
        if (wlanpage == "5G") {
            ssidIdx = parseInt(WlanMap[RecordFor5G].index);
        } else {
            ssidIdx = parseInt(WlanMap[RecordFor2G].index);
        }
    }

    var BasicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
    var BeaconType = Wlan[ssidIdx].BeaconType;

    if (((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) && (BeaconType == 'Basic')) {
        var index = getOptionIndex('wlAuthMode', 'open');
        if (index < 0) {
            $("#wlAuthMode").prepend("<option value='open'></option>");
        }
    } else {
        removeOption('wlAuthMode', 'open');
    }
}

function ModifyEncryMode(authMode) {
    if (ssidIdx == -1) {
        return;
    }

    var beaconType = Wlan[ssidIdx].BeaconType;
    if ((authMode == 'open') && (beaconType == 'Basic')) {
        var basicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
        var basicEncryptionModes = Wlan[ssidIdx].BasicEncryptionModes;
        if ((basicAuthenticationMode == 'None') || (basicAuthenticationMode == 'OpenSystem')) {
            if (basicEncryptionModes == 'None') {
                removeOption('wlEncryption', 'WEPEncryption');
            } else {
                removeOption('wlEncryption', 'None');
            }
        }
    }

    if ((authMode == 'wpa') || (authMode == 'wpa-psk')) {
        var wpaEncryptionModes = Wlan[ssidIdx].WPAEncryptionModes;
        var wpaAuthenticationMode = Wlan[ssidIdx].WPAAuthenticationMode;
        if (((beaconType != 'WPA' || wpaEncryptionModes != 'TKIPEncryption' || wpaAuthenticationMode != 'EAPAuthentication')) &&
           (authMode == 'wpa')) {
            removeOption('wlEncryption', 'TKIPEncryption');
        }

        if (((beaconType != 'WPA' || wpaEncryptionModes != 'TKIPEncryption' || wpaAuthenticationMode != 'PSKAuthentication')) &&
           (authMode == 'wpa-psk')) {
            removeOption('wlEncryption', 'TKIPEncryption');
        }
    }
}

function ModifyAuthAndEncryMode() {
    if ((CfgMode.toUpperCase() === 'TTNET2') && (curUserType == sptUserType)) {
       removeOption('wlAuthMode', 'open');
    }

    if (ssidIdx == -1) {
        return;
    }

    var beaconType = Wlan[ssidIdx].BeaconType;
    if (beaconType == 'Basic') {
        var basicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
        var basicEncryptionModes = Wlan[ssidIdx].BasicEncryptionModes;
        if ((basicAuthenticationMode == 'None') || (basicEncryptionModes == 'OpenSystem')) {
            var index = getOptionIndex('wlAuthMode', 'open');
            if (index < 0) {
                $("#wlAuthMode").prepend("<option value='open'>" + cfg_wlancfgdetail_language['amp_auth_open'] + "</option>");
            }
            
            removeOption('wlAuthMode', 'shared');
            if (basicEncryptionModes == 'None') {
                removeOption('wlEncryption', 'WEPEncryption');
            } else {
                removeOption('wlEncryption', 'None');
            }
        } else {
            var index = getOptionIndex('wlAuthMode', 'shared');
            if (index < 0) {
                $("#wlAuthMode").prepend("<option value='shared'>" + cfg_wlancfgdetail_language['amp_auth_shared'] + "</option>");
            }

            removeOption('wlAuthMode', 'open');
        }
    } else {
        if ((CfgMode.toUpperCase() != 'TTNET2') && (CfgMode.toUpperCase() != 'DINFOTEK2')) {
            removeOption('wlAuthMode', 'open');
        }
        removeOption('wlAuthMode', 'shared');
    } 

    if (beaconType == 'WPA') {
        var wpaEncryptionModes = Wlan[ssidIdx].WPAEncryptionModes;
        if (wpaEncryptionModes != 'TKIPEncryption') {
            removeOption('wlEncryption', 'TKIPEncryption');
        }
    }
}

function addAuthModeOption()
{
    var mode = WlanWifi.mode;
	var auth = getSelectVal('wlAuthMode');
	if ('1' == WPS20AuthSupported)
    {
        capWPAPSK = 0;
        capWPAWPA2PSK = 0;
        capWPAEAP = 0;
        capWPAWPA2EAP = 0;
        wepCap = 0;
    }	
	
	if ('1' == nonWepFlag)
    {
        wepCap = 0;
    }

	var authModes = { 'open' : [cfg_wlancfgdetail_language['amp_auth_open'], 1], 
	                  'shared' : [cfg_wlancfgdetail_language['amp_auth_shared'], (wepCap == 1)], 
	                  'wpa-psk' : [cfg_wlancfgdetail_language['amp_auth_wpapsk'], (capWPAPSK == 1) && (WPAPSKFlag == '1')], 
	                  'wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1], 
	                  'wpa/wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], (capWPAWPA2PSK == 1)], 
	                  'wpa3-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa3psk'], (capWpa3 == 1)], 
	                  'wpa2/wpa3-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk'], (capWpa3 == 1)], 
	                  'wpa' : [cfg_wlancfgdetail_language['amp_auth_wpa'], (capWPAEAP == 1)], 
	                  'wpa2' : [cfg_wlancfgdetail_language['amp_auth_wpa2'], 1], 
	                  'wpa/wpa2' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2'], (capWPAWPA2EAP == 1)], 
	                  'wpa3' : [cfg_wlancfgdetail_language['amp_auth_wpa3'], (capWpa3 == 1) && (isShowWpa3Eap == 1)], 
	                  'wpa2/wpa3' : [cfg_wlancfgdetail_language['amp_auth_wpa2wpa3'], (capWpa3 == 1) && (isShowWpa3Eap == 1)], 
	                  'wapi-psk' : [cfg_wlancfgdetail_language['amp_auth_wapi_psk'], 1], 
	                  'wapi' : [cfg_wlancfgdetail_language['amp_auth_wapi'], 1]
	                };

    if (CfgMode.toUpperCase() == 'EGVDF2') {
        authModes = { 'wpa-psk' : [cfg_wlancfgdetail_language['amp_auth_wpapsk'], (capWPAPSK == 1) && (WPAPSKFlag == '1')], 
                      'wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1], 
                      'wpa/wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], (capWPAWPA2PSK == 1)], 
                      'wpa3-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa3psk'], (capWpa3 == 1)], 
                      'wpa2/wpa3-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk'], (capWpa3 == 1)], 
                      'wpa' : [cfg_wlancfgdetail_language['amp_auth_wpa'], (capWPAEAP == 1)], 
                      'wpa2' : [cfg_wlancfgdetail_language['amp_auth_wpa2'], 1], 
                      'wpa/wpa2' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2'], (capWPAWPA2EAP == 1)], 
                      'wpa3' : [cfg_wlancfgdetail_language['amp_auth_wpa3'], (capWpa3 == 1) && (isShowWpa3Eap == 1)], 
                      'wpa2/wpa3' : [cfg_wlancfgdetail_language['amp_auth_wpa2wpa3'], (capWpa3 == 1) && (isShowWpa3Eap == 1)], 
                      'wapi-psk' : [cfg_wlancfgdetail_language['amp_auth_wapi_psk'], 1], 
                      'wapi' : [cfg_wlancfgdetail_language['amp_auth_wapi'], 1]
                    };
    }

    if (IsAuthModeWithoutOpen()) {
        if (ssidIdx == -1) {
            if (wlanpage == "2G") {
                ssidIdx = parseInt(WlanMap[RecordFor2G].index);
            }

            if (wlanpage == "5G") {
                ssidIdx = parseInt(WlanMap[RecordFor5G].index);
            }
        }

        var BasicAuthenticationMode = Wlan[ssidIdx].BasicAuthenticationMode;
        var BeaconType = Wlan[ssidIdx].BeaconType;

        if (((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) && (BeaconType == 'Basic')) {
            authModes['open'][0] = "";
        }

        if (!(((BasicAuthenticationMode == 'None') || (BasicAuthenticationMode == 'OpenSystem')) && (BeaconType == 'Basic'))) {
            authModes['open'][1] = 0;
        }
    }

	if (cap11ax != 1) {
		authModes['wpa3-psk'][1] = 0;
		authModes['wpa2/wpa3-psk'][1] = 0;
		authModes['wpa3'][1] = 0;
		authModes['wpa2/wpa3'][1] = 0;
	}

	if (((mode == "11n") || (1 == TelMexFlag)||(mode == "11ac") || (1 == DTHungaryFlag)||(mode == "11aconly")) && (CfgMode.toUpperCase() != 'EGVDF2'))
	{
		authModes['shared'][1] = 0;
	}
	

    if ('ANTEL' == CfgMode.toUpperCase() || 'ANTEL2' == CfgMode.toUpperCase()) {
		authModes['open'][1] = 0;
		authModes['shared'][1] = 0;
		authModes['wpa'][1] = 0;
		authModes['wpa2'][1] = 0;
		authModes['wpa/wpa2'][1] = 0;
		authModes['wapi-psk'][1] = 0;
		authModes['wapi'][1] = 0;
        authModes['wpa3-psk'][1] = 0;
        authModes['wpa2/wpa3-psk'][1] = 0;
	}

	if(('SAFARICOM2' == CfgMode.toUpperCase()) || ('SAFARICOM' == CfgMode.toUpperCase()))
	{
		authModes['open'][1] = 0;
		authModes['shared'][1] = 0;
		authModes['wpa-psk'][1] = 0;
		authModes['wpa/wpa2-psk'][1] = 0;
		authModes['wpa'][1] = 0;
		authModes['wpa2'][1] = 0;
		authModes['wpa/wpa2'][1] = 0;
	}
	
	if((1 != WapiFlag) || (0 == wapiCap))
    {
    	authModes['wapi-psk'][1] = 0;
    	authModes['wapi'][1] = 0;
    }

    if ((CfgMode.toUpperCase() === 'TTNET2') && (curUserType == sptUserType)) {
        authModes['wpa-psk'][1] = 0;
    }

    InitDropDownListWithSelected('wlAuthMode', authModes, auth);

    if (ttnet2Flag == 1) {
        ModifyAuthAndEncryMode();
    }
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

function addEncryMethodOption(authMode) {
    var len = document.forms[0].wlEncryption.options.length;
    var mode = WlanWifi.mode;
    
    if ('1' == WPS20AuthSupported)
    {
        capTkip = 0;
        wepCap = 0;
    }
    
	if ('1' == nonWepFlag)
    {
        wepCap = 0;
    }

    for (i = 0; i < len; i++)
    {
        document.forms[0].wlEncryption.remove(0);
    }
    
    if (authMode == "open") {
		if(('SAFARICOM2' != CfgMode.toUpperCase()) && ('SAFARICOM' != CfgMode.toUpperCase()))
		{
			document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
			
			if((t2Flag != 1) || (3 != getWlanInstFromDomain(currentWlan.domain)))
			{
				if ((mode == "11n") || (mode == "11ac") || (1 == DTHungaryFlag) || (0 == wepCap) || (mode == "11aconly"))
				{
					document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
				}
				else
				{
					document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
					document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
				} 
			}
		}
		else
		{
			document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
		}		
    } else if (authMode == "shared") {
        if ((mode != "11n") && (mode != "11ac") && (mode != "11aconly"))
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
        }           
    } else if (authMode == "wpa3") {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
    } else {
        if ((mode == "11n")|| (mode == "11aconly"))
        {
            document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
        }
        else
        {
            if (PccwFlag == 1) {
                if (authMode == "wpa2-psk") {
                    document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
                } else if(authMode == "wpa-psk") {
                    document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
                } else if(authMode == "wpa/wpa2-psk") {
                    document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");  
                } else {
                    document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
                    document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
                    document.forms[0].wlEncryption[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
                }
            } else {
                document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
				if((t2Flag != 1) || (3 != getWlanInstFromDomain(currentWlan.domain)))
				{
					if('1' == capTkip)
					{
						document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkip'], "TKIPEncryption");
						document.forms[0].wlEncryption[2] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
					}
				}
				else
				{
					document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_tkipaes'], "TKIPandAESEncryption");
				}
            }
        }
    }
}

function ShowPinNote(mode)
{
    var PinNote = '';
    if (1 == DTHungaryFlag)
    {
        if ('PBC' != mode)
        {
            PinNote = cfg_wlancfgdetail_language['amp_wps_pin_alert'];
        }

        getElById('DivPinNote').innerHTML = PinNote;

        getElById('DivWpsNote').innerHTML = cfg_wlancfgdetail_language['amp_wps_auth_alert'];
 
    }

    ShowWpsTimer();
   
}
 

function ShowWpsTimer()
{
    var portIndex = getPortFromIndex(ssidIdx);

    setDisplay('DivPBCTimeNote', 0);
    setDisplay('DivPinTimeNote', 0);
    setDisplay('DivAPPinTimeNote', 0);


    if ((1 == DTHungaryFlag) && (portIndex == WpsIndex))
    {
        if ('PushButton' == wpsPinNum[ssidIdx].X_HW_ConfigMethod)
        {
            setDisplay('DivPBCTimeNote', 1);
        }
        else if ('STA' == wpsPinNum[ssidIdx].X_HW_PinGenerator)
        {
            setDisplay('DivPinTimeNote', 1);
        }
        else if ('AP' == wpsPinNum[ssidIdx].X_HW_PinGenerator)
        {
            setDisplay('DivAPPinTimeNote', 1);
        }
        
    }

}

function HideWpsConfig()
{
    setDisplay("wpsPinNumber",0);
    setDisplay("wpsPinNumVal",0);
    setDisplay("wpsAPPinNumVal",0);
    setDisplay('wpsPBCButton',0);
    
	if ((1 == gzcmccFlag) && (curUserType == sptUserType))
	{
		setDisable("btnApplySubmit", 1);
	}
	else
	{
		setDisable("btnApplySubmit", 0);
	}
    
}

function stWpsPinUpTime(domain,X_HW_APPINTIMEOUT)
{
    this.domain = domain;
    this.X_HW_APPINTIMEOUT = X_HW_APPINTIMEOUT;
}

var showWpsUpTime = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,X_HW_APPINTIMEOUT,stWpsPinUpTime,STATUS);%>;
var showTime;
var showPingUpTime
var dev_uptime = '<%HW_WEB_GetOsUpTime();%>';

var showWpsUpTimeLen = showWpsUpTime.length - 1;
var showWpslastTime = new Array();

for (i = 0; i < showWpsUpTimeLen; i++) {
    showWpslastTime[i] = new stWpsPinUpTime();
    showWpslastTime[i] = showWpsUpTime[i];
}

for (var i = 0; i < showWpsUpTimeLen; i++) {
    showWpslastTime[i].X_HW_APPINTIMEOUT = 120 - (dev_uptime - showWpsUpTime[i].X_HW_APPINTIMEOUT);
}

function PinUpTime() {
    var isUptime = 0;
    for (var i = 0; i < showWpsUpTimeLen; i++) {
        showWpslastTime[i].X_HW_APPINTIMEOUT = showWpslastTime[i].X_HW_APPINTIMEOUT - 1;
        if(showWpslastTime[i].X_HW_APPINTIMEOUT > 0) {
            isUptime = isUptime + 1;
        }
    }

    if (isUptime == 0) {
        clearInterval(showPingUpTime);
        return;
    }
}

function APPinTimeChange() {
    if (ssidIdx == -1) {
        clearInterval(showTime);
        getElementById("wpsApPinNumber").innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_Ping_time_note'];
        return;
    }

    if(showWpslastTime[ssidIdx].X_HW_APPINTIMEOUT > 0) {
        getElementById("wpsApPinNumber").innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_Ping_time'] + showWpslastTime[ssidIdx].X_HW_APPINTIMEOUT + "s";
    } else {
        clearInterval(showTime);
        getElementById("wpsApPinNumber").innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_Ping_time_note'];
        return;
    }
}

function ShowWpsPinDom(wpsMode) {
    var wpsDefaultPIN = computeDefaultPin() + '';

    if (wpsMode == 'PIN') {
        setDisplay('wpsPinNumVal', 1);
        setDisplay('wpsAPPinNumVal', 0);
        setText('wlClientPinNum', changeToPinNumber(wpsDefaultPIN, 8));
    } else {
        setDisplay('wpsPinNumVal', 0);
        setDisplay('wpsAPPinNumVal', 1);
        setText('wlSelfPinNum', changeToPinNumber(wpsDefaultPIN, 8));
    }

    wlanSetSelect('wlWPSMode', wpsMode);
    setDisplay('wpsPBCButton', 0);
    ShowPinNote(wpsMode);
}

function displayWpsConfig() {
    if (IsWpsConfigDisplay() == false) {
        HideWpsConfig();
        return;
    }

    setDisplay('wpsPinNumber', 1);
    setCheck('wlWPSEnable', wpsPinNum[ssidIdx].Enable);
    setDisable("wlClientPinNum", 0);

    if ((gzcmccFlag == 1) && (curUserType == sptUserType)) {
        setDisable("btnApplySubmit", 1);
    } else {
        setDisable("btnApplySubmit", 0);
    }

    if (noApPinFlag == 1) {
        if ((wpsPinNum[ssidIdx].X_HW_ConfigMethod == 'Lable')  && (wpsPinNum[ssidIdx].X_HW_PinGenerator == 'AP')) {
            wpsPinNum[ssidIdx].X_HW_PinGenerator = 'STA';
        }
    }

    if (wpsPinNum[ssidIdx].X_HW_ConfigMethod == 'Lable') {
        if (wpsPinNum[ssidIdx].X_HW_PinGenerator == 'AP') {
            wlanSetSelect('wlWPSMode', 'AP-PIN');
            setDisplay('wpsPBCButton', 0);
            if (CfgMode.toUpperCase() == 'DBAA1') {
                setDisplay('wpsAPPinNumVal', 0);
            } else {
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
            }
            setDisplay('wpsPinNumVal', 0);
            setText('wlSelfPinNum', changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword, 8));
            ShowPinNote('AP-PIN');
        } else {
            wlanSetSelect('wlWPSMode', 'PIN');
            setDisplay('wpsPBCButton', 0);
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
            setDisplay('wpsAPPinNumVal', 0);
            setText('wlClientPinNum', changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword, 8));
            ShowPinNote('PIN');

            if((stapinlock.charAt((wlanpage == "2G") ? 0 : 1) == '1')) {
                setDisable("wlClientPinNum", 1);
                setDisable("btnApplySubmit", 1);
            }
        }

        if (WPS20AuthSupported == '1') {
            wlanSetSelect('wlWPSMode', 'AP');
            setDisplay('wpsPBCButton', 0);
            setDisplay('wpsPinNumVal', 1);
            setDisplay('wpsAPPinNumVal', 1);
            setText('wlClientPinNum', '');
            setText('wlSelfPinNum',changeToPinNumber(wpsPinNum[ssidIdx].DevicePassword,8));
        }
    } else {
        wlanSetSelect('wlWPSMode', 'PBC');

        if (getSelectVal('wlWPSMode') == 'PBC') {
            wlanSetSelect('wlWPSMode', 'PBC');
            setDisplay('wpsPBCButton', 1);
            setDisplay('wpsPinNumVal', 0);
            setDisplay('wpsAPPinNumVal', 0);

            var wpsEnable = wpsPinNum[ssidIdx].Enable;
            if (wpsEnable == 1) {
                setDisable('btnWpsPBC', 0);
            } else if (wpsEnable == 0) {
                setDisable('btnWpsPBC', 1);
            }

            ShowPinNote('PBC');
        } else {
            if (noApPinFlag == 1) {
                ShowWpsPinDom('PIN');
            } else {
                ShowWpsPinDom('AP-PIN');
            }
        }  
    }

    if(CfgMode.toUpperCase() == 'ROSUNION') {
        wlanSetSelect('wlWPSMode','PBC');
        setDisplay('wpsPBCButton',1);
        setDisplay('wpsPinNumVal',0);
        setDisplay('wpsAPPinNumVal',0);
        var wpsEnable = wpsPinNum[ssidIdx].Enable;
        if (wpsEnable == 1) {
            setDisable('btnWpsPBC', 0);
        } else if (wpsEnable == 0) {
            setDisable('btnWpsPBC', 1);
        }
        ShowPinNote('PBC');
    }

    if (getSelectVal('wlWPSMode') == 'AP-PIN') {
        clearInterval(showTime);
        APPinTimeChange();
        showTime = setInterval('APPinTimeChange()', 1000);
    }
}

function WPSAndHideCheck()
{
    if('1' == t2Flag)
    {
        if(0 == getCheckVal('wlHide'))
        {
            setDisable('wlWPSEnable', 1);
            setCheck('wlWPSEnable', 0);
        }
        else
        {
            setDisable('wlWPSEnable', 0);
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

function IsAddressValid(IPAddress) {
    if (CfgMode.toUpperCase() == 'MEGACABLE2') {
        if (IPAddress.indexOf(":") > 0) {	
            if (IsIPv6AddressValid(IPAddress) == false) {
                return false;
            }
            if (IsIPv6MulticastAddress(IPAddress) == true) {
                return false;
            }
            if (IsIPv6ZeroAddress(IPAddress) == true) {
                return false;
            }
            if (IsIPv6LoopBackAddress(IPAddress) == true) {
                return false;
            }
        } else {
            if (isAbcIpAddress(IPAddress) == false) {
                return false;
            }
        }
    } else {
        if (isAbcIpAddress(IPAddress) == false) {
            return false;
        }
    }
    return true;
}

function hideWepDiv()
{
	setDisplay('wlEncryMethod',0);
	setDisplay('keyInfo',0);
}

function authModeChange()
{
    setDisplay("wlEncryMethod",0);
    setDisplay("keyInfo", 0);
    setDisplay("wlRadius", 0);
    setDisplay("wpaGTKRekey", 0);
    setDisplay("wpaPreShareKey", 0);
    setDisable("wlEncryption",0);
    setDisplay('wlWapi',0);
    HideWpsConfig();

    var authMode = getSelectVal('wlAuthMode');
    
    switch (authMode)
    {
        case 'open':
            setDisplay('wlEncryMethod',1);
            addEncryMethodOption(authMode);
            if (AddFlag == false)
            {
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
                if ('1' == WPS20AuthSupported)
                {
                    displayWpsConfig();
                }
				if('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
				{
					setDisplay('wlEncryMethod',0);         
				}
            }
            else
            {
                setDisplay('keyInfo', 0);
                wlanSetSelect('wlEncryption','None');
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
            
            if ((mode == "11n") || (mode == "11ac") || (mode == "11aconly"))
            {                  
                  setDisplay('wlEncryMethod',0);  
                  setDisplay('keyInfo', 0);                
            }
            else
            {                  
                setDisplay('wlEncryMethod',1); 
                setDisplay('keyInfo', 1);
                addEncryMethodOption(authMode);
				WEPandWPS20check();
                if (AddFlag == false)
                {
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
                else
                {
                    wlanSetSelect('wlKeyBit', 128);
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
            if (fitApFt == 1) {
                setDisplay("trRadiusAccountEnable", 1);
                setDisplay("tbRadiusAccountPort", 1);
                setDisplay("tbRadiusAccountIPAddr", 1);
                setDisplay("tbRadiusAccountKey", 1);
            }
            setDisplay('wpaGTKRekey', 1);
            if (AddFlag == false)
            {
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
                if (fitApFt == 1) {
                    if (IsValidRadiusAccount()) {
                        setCheck('wlRadiusAccountEnable', RadiusAccountEnable);
                        setText('wlRadiusAccountPort', RadiusAccountPort);
                        setText('wlRadiusAccountIPAddr', RadiusAccountIPAddr);
                        setText('wlRadiusAccountKey', RadiusAccountKey);
                        radiusAccountpassword = RadiusAccountKey; 
                        setText('twlRadiusAccountKey', RadiusAccountKey);
                    } else {
                        setCheck('wlRadiusAccountEnable', 0);
                        setText('wlRadiusAccountPort', 1813);
                        setText('wlRadiusAccountIPAddr', "192.168.0.100");
                        setText('wlRadiusAccountKey', '');
                        radiusAccountpassword = ''; 
                        setText('twlRadiusAccountKey', '');
                    }
                }
            }
            else
            {
                setText('wlRadiusIPAddr','');
                setText('wlRadiusPort','');
                setText('wlRadiusKey','');
                radiuspassword = ''; 
                setText('twlRadiusKey','');
                setText('wlWpaGtkRekey','');
                if (fitApFt == 1) {
                    setCheck('wlRadiusAccountEnable', '');
                    setText('wlRadiusAccountPort', '');
                    setText('wlRadiusAccountIPAddr', '');
                    setText('wlRadiusAccountKey', '');
                    radiusAccountpassword = ''; 
                    setText('twlRadiusAccountKey', '');
                }
            }
            break;

        case 'wpa-psk':
            if (CfgMode.toUpperCase() === 'TTNET2') {
                AlertEx(cfg_wlancfgother_language['amp_wlan_note5']);
            }
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
        case 'wpa3-psk':
        case 'wpa2/wpa3-psk':
            setDisplay('wlEncryMethod',1);
            if ((authMode == "wpa3-psk") || (authMode == "wpa2/wpa3-psk")) {
                addEncryMethodOption("wpa3");
            } else {
                if (PccwFlag == 1) {
                    addEncryMethodOption(authMode);
                } else {
                    addEncryMethodOption("psk");
                }
            }

            HidewlWpaPskDisplayBaseAuthMode(authMode, 'hidewlWpaPsk_note');
            setDisplay('wpaPreShareKey', 1);
            setDisplay('wpaGTKRekey', 1);
            document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wpa_psk");
            if (AddFlag == false)
            {
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
                    wlanSetSelect('wlWPSMode','AP-PIN');
                    setDisplay('wpsPBCButton',0);
                    setDisplay('wpsAPPinNumVal',1);
                    setDisplay('wpsPinNumVal',0);
                    
                    var wpsDefaultPIN = computeDefaultPin()+'';
                    setText('wlSelfPinNum',changeToPinNumber(wpsDefaultPIN,8));
                }
                else
                {
                    wlanSetSelect('wlWPSMode','PBC');
                    setDisplay('wpsPBCButton',1);
                    setDisplay('wpsPinNumVal',0);
                    setDisplay('wpsAPPinNumVal',0);
                }
            }
            WPSAndHideCheck();
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

                wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
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
                wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
            }
            break;
        default:
            break;
    }

    setEncryptSug();
    ShowPskWarningDiv(getWlanInstFromDomain(Wlan[ssidIdx].domain));

    if (ttnet2Flag == 1) {
        ModifyEncryMode(authMode);
    }
} 

function isValidKey(val, size)
{
    var ret = false;
 
    if (isValidAscii(val) != '') { 
        return ret;
    }

    var len = val.length;
    var doubleSize = size * 2;
    if (len == size) {
       ret = true;
    } else if (len == doubleSize) {
       for (i = 0; i < doubleSize; i++) {
          if (isHexaDigit(val.charAt(i)) == false) {
              break;
          }
        }

       if (i >= doubleSize) {
            ret = true;
       }
    }

   return ret;
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
    setDisable("wlClientPinNum", 0);
	
	if ((1 == gzcmccFlag) && (curUserType == sptUserType))
	{
		setDisable("btnApplySubmit", 1);
	}
	else
	{
		setDisable("btnApplySubmit", 0);
	}
        
    if (getSelectVal('wlWPSMode') == 'PBC')
    {
        setDisplay('wpsPBCButton',1);
        setDisplay('wpsPinNumVal',0);
        setDisable("btnWpsPBC", 1);
        setDisplay('wpsAPPinNumVal',0);
        
        if ('PushButton' == wpsPinNum[ssidIdx].X_HW_ConfigMethod)
        {
        	setDisable('btnWpsPBC', 0);
        }
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
        if(stapinlock.charAt((wlanpage == "2G") ? 0 : 1) == '1'  && '1' == t2Flag)
        {
            setDisable("wlClientPinNum", 1);
            setDisable("btnApplySubmit", 1);
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
        if ('1' == WPS20AuthSupported)
        {
            setDisplay('wpsPinNumVal',1);
            setText('wlClientPinNum', '');
        }
    }   
    ShowPinNote(getSelectVal('wlWPSMode'));
}

function addParameter3(Form)
{
    var clientPinNum = getValue('wlClientPinNum');
    if (clientPinNum == '')
    {
        AlertEx(cfg_wlancfgother_language['amp_clientpin_empty']);
        return false;
    }
    if ('1' == WPS20AuthSupported)
    {
        clientPinNum = clientPinNum.replace(" ", "");
        clientPinNum = clientPinNum.replace("-", "");
    }
    if (isInteger(clientPinNum) == false)
    {
        AlertEx(cfg_wlancfgother_language['amp_clientpin_int']);
        return false;
    }

    if (clientPinNum.length != 4 && clientPinNum.length != 8)
    {
        AlertEx(cfg_wlancfgother_language['amp_clientpin_8int']);
        return false;
    }
   

    if (clientPinNum == 0)
    {   
        AlertEx(cfg_wlancfgother_language['amp_clientpin_invalid']);
        return false;
    }
    var pinLen = clientPinNum.length;
    var pinNum = parseInt(changeToInteger(clientPinNum, pinLen));
    if (clientPinNum.length == 8)
    {  
        if (ValidateChecksum(parseInt(pinNum, 10)) != 0)
        {
          AlertEx(cfg_wlancfgother_language['amp_clientpin_invalid']);
          return false;
        }
    }
    Form.addParameter('z.X_HW_ConfigMethod','Lable');
    Form.addParameter('z.X_HW_PinGenerator','STA');
    Form.addParameter('z.DevicePassword',parseInt(pinNum, 10));
}

function OnSetWPSOOB()
{
    var wpsEnable = getCheckVal('wlWPSEnable');
    var wlandomain = Wlan[ssidIdx].domain;
    var url_pin = 'set.cgi?y=' + wlandomain + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp';
    if (ConfirmEx('Set WPS not configured?')) 
    {
        var Form = new webSubmitForm();
        /* X_HW_WPSConfigurated=1 not configured */
        Form.addParameter('y.X_HW_WPSConfigurated',1);
        Form.setAction(url_pin);
        
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
    
}

function OnWPS20Refresh()
{
    var wlandomain = Wlan[ssidIdx].domain;
    var url_pin = 'set.cgi?y=' + wlandomain + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp';

    var Form = new webSubmitForm();
    /* X_HW_WPSConfigurated=3 refresh page for HG8245Q*/
    Form.addParameter('y.X_HW_WPSConfigurated',3);
    Form.setAction(url_pin);
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();    
}

function OnPinPairUnreboot()
{
    var wpsEnable = getCheckVal('wlWPSEnable');
    var Form = new webSubmitForm();
    if (addParameter3(Form) == false)
    {        
        return;
    }
    if (wpsEnable == 0)
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wps_enable_note']);
        return;
    }

	var wlanInst = getInstIdByDomain(Wlan[ssidIdx].domain);
		
	var clientPinNum = getValue('wlClientPinNum');
    if (ConfirmEx(cfg_wlancfgdetail_language['amp_wps_start'])) 
    {
        Form.setAction('WpsPin.cgi?wlaninst=' + wlanInst + '_' + clientPinNum + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

function OnPINPair()
{
	if (1 == capStaPinUnreboot)
	{
		OnPinPairUnreboot();
		return;
	}
    var wpsEnable = getCheckVal('wlWPSEnable');
    var wlandomain = Wlan[ssidIdx].domain;
    var url_pin = 'set.cgi?z=' + wlandomain + '.WPS' + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp';
    var Form = new webSubmitForm();
    if (addParameter3(Form) == false)
    {        
        return;
    }
    if (wpsEnable == 0)
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wps_enable_note']);
        return;
    }

    if (ConfirmEx(cfg_wlancfgdetail_language['amp_wps_start'])) 
    {
        Form.setAction(url_pin);
        
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

function OnRegeneratePIN()
{
    var number = computePinInteger();
    setText('wlSelfPinNum', changeToPinNumber(number,8));
    if ('1' == WPS20AuthSupported)
    {
        var wpsEnable = getCheckVal('wlWPSEnable');
        var wlandomain = Wlan[ssidIdx].domain;
        var url_pin = 'set.cgi?z=' + wlandomain + '.WPS' + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp';;
        
        if (ConfirmEx('Regenerate PIN?')) 
        {
            var Form = new webSubmitForm();
            wlanSetSelect('wlWPSMode','AP-PIN');
            
            addParameter2(Form);
            
            Form.setAction(url_pin);
            
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.submit();
        }
    }
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

var RadiusAccountEnable;
var RadiusAccountPort;
var RadiusAccountIPAddr;
var RadiusAccountKey;
function IsValidRadiusAccount()
{
    for (var index = 0; index < radiusAccountList.length - 1; index++) {
        if (radiusAccountList[index] == 'null'){
            return false;
        }
        var ret = radiusAccountList[index].domain.indexOf(Wlan[ssidIdx].domain);
        if (ret >= 0) {
            RadiusAccountEnable = radiusAccountList[index].Enable;
            RadiusAccountPort = radiusAccountList[index].ServerPort;
            RadiusAccountIPAddr = radiusAccountList[index].SecondaryServerIPAddr;
            RadiusAccountKey = radiusAccountList[index].SecondarySecret;
            return true;
        }
    }
    return false;
}

function initEapAuthShow(wlAuthMode, wlEncryption, authMode) {
	setDisplay("wlEncryMethod", 1);
	addEncryMethodOption(authMode);
	setDisplay("wlRadius", 1);
	setDisplay("wpaGTKRekey", 1);
	wlanSetSelect('wlAuthMode', wlAuthMode);
	wlanSetSelect('wlEncryption', wlEncryption);
	setText('wlRadiusIPAddr', Wlan[ssidIdx].RadiusServer);
	setText('wlRadiusPort', Wlan[ssidIdx].RadiusPort);
	setText('wlRadiusKey', Wlan[ssidIdx].RadiusKey);
	radiuspassword = Wlan[ssidIdx].RadiusKey; 
	setText('twlRadiusKey', Wlan[ssidIdx].RadiusKey);
	setText('wlWpaGtkRekey', Wlan[ssidIdx].WPARekey);
    if (CfgMode.toUpperCase() == "CHINAEBG4") {
        setDisplay("trRadiusAccountEnable", 1);
        setDisplay("tbRadiusAccountPort", 1);
        setDisplay("tbRadiusAccountIPAddr", 1);
        setDisplay("tbRadiusAccountKey", 1);
        if (IsValidRadiusAccount()) {
            setCheck('wlRadiusAccountEnable', RadiusAccountEnable);
            setText('wlRadiusAccountPort', RadiusAccountPort);
            setText('wlRadiusAccountIPAddr', RadiusAccountIPAddr);
            setText('wlRadiusAccountKey', RadiusAccountKey);
            radiusAccountpassword = RadiusAccountKey; 
            setText('twlRadiusAccountKey', RadiusAccountKey);
        } else {
            setCheck('wlRadiusAccountEnable', 0);
            setText('wlRadiusAccountPort', 1813);
            setText('wlRadiusAccountIPAddr', "192.168.0.100");
            setText('wlRadiusAccountKey','');
            radiusAccountpassword = ''; 
            setText('twlRadiusAccountKey', '');
        }
    }
}

function initPskAuthShow(wlAuthMode, wlEncryption, authMode) {
	setDisplay("wlEncryMethod", 1);
	addEncryMethodOption(authMode);
	setDisplay("wpaPreShareKey", 1);
	setDisplay("wpaGTKRekey", 1);
	wlanSetSelect('wlAuthMode', wlAuthMode);
	wlanSetSelect('wlEncryption', wlEncryption);
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
            wlanSetSelect('wlAuthMode','open');
            wlanSetSelect('wlEncryption',BasicEncryptionModes);
            if (BasicEncryptionModes == 'None')
            {
                setDisplay('keyInfo', 0);
            } 
            else
            {
                var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
                setDisplay('keyInfo', 1);
                wlanSetSelect('wlKeyBit', parseInt(level)+24);
                wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
                displaywepkey();
            }
        }
        else
        {
            var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
            addEncryMethodOption('shared');
            setDisplay('keyInfo', 1);
            wlanSetSelect('wlAuthMode','shared');
            wlanSetSelect('wlEncryption',BasicEncryptionModes);
            wlanSetSelect('wlKeyBit', parseInt(level)+24);
            wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
            displaywepkey();
        }
        if ('1' == WPS20AuthSupported)
        {
            displayWpsConfig();
        }
    } else if (mode == 'WPA') {
        if (Wlan[ssidIdx].WPAAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa', Wlan[ssidIdx].WPAEncryptionModes, "enterprise");
        } else {
            initPskAuthShow('wpa-psk', Wlan[ssidIdx].WPAEncryptionModes, "wpa-psk");
        }
    } else if ((mode == '11i') || (mode == 'WPA2')) {
        if (Wlan[ssidIdx].IEEE11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa2', Wlan[ssidIdx].IEEE11iEncryptionModes, "enterprise");
        } else {
            initPskAuthShow('wpa2-psk', Wlan[ssidIdx].IEEE11iEncryptionModes, "wpa2-psk");
        }
    } else if ((mode == 'WPAand11i') || (mode == 'WPA/WPA2')) {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa/wpa2', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "enterprise");
        } else {
            initPskAuthShow('wpa/wpa2-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa/wpa2-psk");
        }
    } else if (mode == 'WPA3') {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa3', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        } else {
            initPskAuthShow('wpa3-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        }
    } else if (mode == 'WPA2/WPA3') {
        if (Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode == 'EAPAuthentication') {
            initEapAuthShow('wpa2/wpa3', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        } else {
            initPskAuthShow('wpa2/wpa3-psk', Wlan[ssidIdx].X_HW_WPAand11iEncryptionModes, "wpa3");
        }
    }
    else if(mode == 'X_HW_WAPI')
    {
        if(Wlan[ssidIdx].X_HW_WAPIAuthenticationMode == 'WAPIPSK')
        {
            wlanSetSelect('wlAuthMode','wapi-psk');
            setDisplay('wlEncryMethod',1);             
                    addWapiEncryMethodOption();  
            
            setDisable('wlEncryption',1);
            setDisplay("wpaPreShareKey", 1);
            document.getElementById('wpa_psk').innerHTML = GetLanguageDesc("amp_wapi_psk");
            setText('wlWpaPsk',wpaPskKey[ssidIdx].value);
            setText('twlWpaPsk',wpaPskKey[ssidIdx].value);
            wpapskpassword = wpaPskKey[ssidIdx].value; 



            wlanSetSelect('wlEncryption',Wlan[ssidIdx].X_HW_WAPIEncryptionModes);
        }
        else
        {
            wlanSetSelect('wlAuthMode','wapi');
            setDisplay('wlEncryMethod',1);             
            addWapiEncryMethodOption();  
            setDisable('wlEncryption',1);
            setDisplay('wlWapi',1); 
            setText('wapiIPAddr',Wlan[ssidIdx].X_HW_WAPIServer);
            setText('wapiPort',Wlan[ssidIdx].X_HW_WAPIPort);
        }
    }
    else
    {   
        addEncryMethodOption('open');
        setDisplay('wlEncryMethod',1);
        wlanSetSelect('wlAuthMode','open');
        wlanSetSelect('wlEncryption','None');
    }

    if (Wlan[ssidIdx] !== undefined) {
        HidewlWpaPskDisplayBaseValue(mode, Wlan[ssidIdx].X_HW_WPAand11iAuthenticationMode, 'hidewlWpaPsk_note');
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
    if (isAuthModePreSharedKey(AuthMode)) {
        return true;
    } else {
        return false;
    }
}

function IsWpsConfigDisplay( )
{
    var AuthMode = getSelectVal('wlAuthMode');
    var EncryMode = getSelectVal('wlEncryption');
    if ('1' == WPS20AuthSupported && AuthMode == 'open' && EncryMode == 'None')
    {
        return true;
    }
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

        if(0 == wps1Cap)
        {
            if ((AuthMode == 'wpa-psk')  || (AuthMode === 'wpa3-psk') || (EncryMode == 'TKIPEncryption'))
            
            {
                return false;
            }
        }
        
        return true;
    }

    return false;
}

function setAuthModeSug() {
    if (ttnet2Flag != 1) {
        return;
    }

    var authMode = getSelectVal('wlAuthMode');
    var spanAuth = getElementById('SpanAuthMode');

    if (authMode == 'open') {
        spanAuth.innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_auth_status'];
        spanAuth.style.color = '#ff0000';
    } else {
        spanAuth.innerHTML = '';
    }
}

function setEncryptSug()
{
	setAuthModeSug();
    if (isSontOrSYN) {
        return;
    }
	
	if (capTkip == '0' || PccwFlag == 1 || DslTalkTalkFlag == 1 || (CfgMode.toUpperCase() == 'ROSUNION')) {
		return;
	}
	
	var encryMode = getSelectVal('wlEncryption');
	var spanEncrypt = getElementById('SpanEncrypt');
    var authMode = getSelectVal('wlAuthMode');
    if ((authMode == 'wpa3-psk') || (authMode == 'wpa2/wpa3-psk')) {
        spanEncrypt.innerHTML = '';
        return;
    }
	
    if ((cap11ax == 1) && (isShowWpa3Eap == 1)) {
        if (encryMode != 'AESEncryption') {
            spanEncrypt.innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_11axencry_status'];
            spanEncrypt.style.color = '#ff0000';  
        } else {
            spanEncrypt.innerHTML = '';
        }
        return;
    }

	if ('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
	{
		if (encryMode != 'TKIPandAESEncryption' && encryMode != 'AESEncryption')
		{
			spanEncrypt.innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_encry_onlyaes_status'];
			spanEncrypt.style.color = '#ff0000';
		}
		else
		{
			spanEncrypt.innerHTML = '';
		}
	} else {
		if (encryMode != 'TKIPandAESEncryption')
		{
			if (encryMode == 'AESEncryption')
			{
				if (("OSK" == CfgMode) || ("OSK2" == CfgMode) || ("COMMON" == CfgMode) || ("COMMON2" == CfgMode) || (1 == DefaultAesFlag))
				{
					spanEncrypt.innerHTML = '';
					return ;
				}
			}
		
			spanEncrypt.innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_encry_status'];
			spanEncrypt.style.color = '#ff0000';
		}
		else
		{
			spanEncrypt.innerHTML = '';
		}
	}
}

function WEPandWPS20check()
{
	if('1' == t2Flag)
	{
		alert(cfg_wlancfgdetail_language['amp_wlancfgdetail_wps20_wep_check']);
	}
	
	return;
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
            if (AddFlag == false)
            {
				WEPandWPS20check();
                var level = getEncryLevel(Wlan[ssidIdx].EncypBit);
                setDisplay('keyInfo', 1);
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
            else
            {
                setDisplay('keyInfo', 1);
                wlanSetSelect('wlKeyBit', 128);
                
                if (1 == TelMexFlag)
                {
                    keyIndexChange(Wlan[ssidIdx].KeyIndex);
                }
                
                wlanSetSelect('wlKeyIndex',Wlan[ssidIdx].KeyIndex);
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

    displayWpsConfig();
    WPSAndHideCheck();
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
	 if(0 == trimssidFlag)
	 {
		return str.toString().replace(/(^\s*)/g,""); 
	 }
	 else
	 {
		return str.toString();
	 } 
}


function isValIdRule(val)
{	
	var reg = /^[A-Za-z0-9-]+$/;
	if(val.match(reg))
	{
		return val;
	}
	else
	{
		return '';
	}
}

function isValPWDRule(val)
{	
	var reg = /^[A-Za-z0-9]+$/;
	if(val.match(reg))
	{
		return val;
	}
	else
	{
		return '';
	}
}

function HideAdminPsk () {
    if (curUserType == 0) {
        setDisplay('hidewlWpaPsk', 0);
        setDisplay('hidewlWpaPsk_icon', 0);
        setDisplay('hidewlWpaPsk_note', 0);
    } else {
        setDisplay('hidewlWpaPsk', 1);
        setDisplay('hidewlWpaPsk_icon', 1);
        setDisplay('hidewlWpaPsk_note', 1);
        setDisable('hidewlWpaPsk', 0);
    }
}

function SsidEnableChangeSug() {
    if (AddFlag == 1) {
        return;
    }

    if ((DoubleFreqFlag == 1) && (wlanpage == "5G") && (bondingEnable == 1) && (baskHaul.domain.indexOf(Wlan[ssidIdx].domain) >= 0) &&
        (baskHaul.enable == 1) && (getCheckVal('wlEnable') == 0) && (Wlan[ssidIdx].enable == 1) && (apNum > 0)) {
        AlertEx(cfg_wlancfgother_language['amp_bonding_sug']);
    }
}

function addParameter1(Form)
{   
    SsidEnableChangeSug();
    Form.addParameter('y.Enable',getCheckVal('wlEnable'));
    Form.addParameter('y.SSIDAdvertisementEnabled',getCheckVal('wlHide'));

    if ((0 == AddFlag) && (-1 != ssidIdx) && (Wlan[ssidIdx].wmmEnable != getCheckVal('enableWmm')))
    {
        Form.addParameter('y.WMMEnable',getCheckVal('enableWmm'));
    }

    if ((1 == AddFlag) || (-1 == ssidIdx))
    {
        Form.addParameter('y.WMMEnable',getCheckVal('enableWmm'));
    }
    
    if((1 == staIsolationFlag) && (-1 != ssidIdx))
    {
        if (CfgMode.toUpperCase() == 'ROSUNION') {
            Form.addParameter('q.X_HW_IsolationEnable', getCheckVal('sta_isolation'));
        } else {
            Form.addParameter('y.IsolationEnable', getCheckVal('sta_isolation'));
        }
    }
    
    if (((CfgMode.toUpperCase() == 'DTURKCELL2WIFI') || (turkcellFlag == 1)) && (ssidIdx != -1)) {
        Form.addParameter('r.FBT_11rEnable', getCheckVal('enable11r'));
    }

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
    } else if (specialPreflag == 1) {
        ssid = getValue('wlSsid1') + getValue('wlSsid2');
    } else {
        ssid = getValue('wlSsid');
    }
     
	var AuthModeCheck = getSelectVal('wlAuthMode');
	 
	if(1 == DslTalkTalkFlag)
	{
		if(isValIdRule(ssid) == '') 
		{
			AlertEx(cfg_wlancfgother_language['amp_ttd_ssid_check']);
			return false;
		}

		if ((AuthModeCheck == 'wpa-psk') || (AuthModeCheck == 'wpa2-psk') || (AuthModeCheck == 'wpa/wpa2-psk') || (AuthModeCheck == 'wpa3-psk') || (AuthModeCheck == 'wpa2/wpa3-psk')) {
			if(isValPWDRule(getValue('twlWpaPsk')) == '') 
			{
				AlertEx(cfg_wlancfgother_language['amp_ttd_pwd_check']);
				return false;
			}
		}
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
	
	if (1 == DslTalkTalkFlag)
	{
		if (ssid.length < 3)
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_short']);
			return false;
		}
	}
	
	if(true == AmpTDESepicalCharaterFlag)
	{
	    if (true != checkSepcailStrValid(ssid))
        {
            AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid']);
            return false;
        }
	
	    if(getTDEStringActualLen(ssid) > 32)
	    {
            AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
            return false;
        }
    } else if (CfgMode.toUpperCase() != "TTNET2") {
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

	}
    

    for (i = 0; i < Wlan.length; i++)
    {
        if ((getWlanPortNumber(Wlan[i].name) > ssidEnd2G) && ((1 == DoubleFreqFlag) && ("2G" == wlanpage)) )
        {
            continue;
        }
        
        if ((getWlanPortNumber(Wlan[i].name) <= ssidEnd2G) && ((1 == DoubleFreqFlag) && ("5G" == wlanpage)) )
        {
            continue;
        }
		
		if ((getWlanPortNumber(Wlan[i].name) > ssidEnd2G) && ((1 != DoubleFreqFlag)) )
        {
            continue;
        }

        if ((ssidIdx != i) || (AddFlag == 1)) {
            if (Wlan[i].ssid == ssid) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
                return false;
            }
        }
    }

    Form.addParameter('y.SSID',ssid);

    var deviceNum = getValue('X_HW_AssociateNum');

    if (isValidAssoc(deviceNum) == false)
    {
        return false;
    }
	var deviceNumInt = parseInt(getValue('X_HW_AssociateNum'),10);
    
	if (0 == ForbidAssocFlag)
    {
		if(t2Flag == 1 && ssidIdx != -1)
		{
			if((getWlanInstFromDomain(Wlan[ssidIdx].domain) == 3) && ("1" == XHWAdvanceCfg.value))
			{
				Form.addParameter('y.X_HW_AssociateNum',deviceNumInt);
			}
		}
		else
		{
			Form.addParameter('y.X_HW_AssociateNum',deviceNumInt);
		}
    }
	
    if ('1' == WPS20AuthSupported)
    {
        Form.addParameter('y.UAPSDEnable',getCheckVal('U-APSD'));
    }
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
	if (number == '0')
	{
		number = computePinInteger();
	}
    var pinNumber = '';
    for (var i = 0; i < length-number.length; i++)
    {
        pinNumber += '0';
    }
    pinNumber += number;
    return pinNumber;
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

function checkPasswordStrength(passWord) {
    var score = 0;

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

function CheckPskLenValid(value) {
    if ((megacablePwd == 1) && (curUserType == '0') && (value == "********") && (pskPsdModFlag != true)) {
        return true;
    }

    if (isValidWPAPskKey(value) == false) {
        if (megacablePwd == 1) {
            AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid_telmex']);
        } else {
            AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
        }
        return false;
    }

    if ((CfgMode.toUpperCase() == "EGVDF2") && (checkPasswordStrength(value) < 2)) {
        AlertEx("The password must contain two of the following: uppercase characters, lowercase characters, digits (0-9), special characters.");
        return false;
    }
    return true;
}

function addParameter2(Form)
{ 
    var url = '';
    var temp = '';

    var AuthMode = getSelectVal('wlAuthMode');
	var method = getSelectVal('wlEncryption');

    if (((curUserType == maxisNormalUserType) && (CfgMode.toUpperCase() == 'DETHMAXIS')) && 
        ((curAuthMode != AuthMode) || (curMethod != method))) {
        AlertEx('Error!');
        return false;
    }

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
				     if (isSpaceInKey(val))
                    {
                        AlertEx(KeyDesc + " " + val + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + cfg_wlancfgother_language['amp_wpa_space']);
                        return false;
                    }

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
				   
				   if (isValidStr(val) != '')
                   {
                       AlertEx(KeyDesc + " " + val + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + isValidStr(val));
                       return false;
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
			if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
			{
				if(ssidIdx == 0)
				{
					Form.addParameter('u.WEPEncryptionLevel',(KeyBit-24)+'-bit');
	            	Form.addParameter('u.WEPKeyIndex',index);
				}
			}

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
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l1.WEPKey', wlKeys1);
								}
							}
                        }

                        if ( (wlKeys2 != "*************") || (wep2PsdModFlag == true) || wepOrigLen != getValue('wlKeys2').length)
                        {
                            Form.addParameter('k2.WEPKey', wlKeys2);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l2.WEPKey', wlKeys2);
								}
							}

                        }

                        if ( (wlKeys3 != "*************") || (wep3PsdModFlag == true) || wepOrigLen != getValue('wlKeys3').length)
                        {
                            Form.addParameter('k3.WEPKey', wlKeys3);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l3.WEPKey', wlKeys3);
								}
							}
                        }

                        if ( (wlKeys4 != "*************") || (wep4PsdModFlag == true) || wepOrigLen != getValue('wlKeys4').length)
                        {
                            Form.addParameter('k4.WEPKey', wlKeys4);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l4.WEPKey', wlKeys4);
								}
							}
                        }
                    }
                    else
                    {
                        if ( (wlKeys1 != "*****") || (wep1PsdModFlag == true)  || wepOrigLen != getValue('wlKeys1').length)
                        {
                            Form.addParameter('k1.WEPKey', wlKeys1);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l1.WEPKey', wlKeys1);
								}
							}
                        }

                        if ( (wlKeys2 != "*****") || (wep2PsdModFlag == true) || wepOrigLen != getValue('wlKeys2').length)
                        {
                            Form.addParameter('k2.WEPKey', wlKeys2);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l2.WEPKey', wlKeys2);
								}
							}
                        }

                        if ( (wlKeys3 != "*****") || (wep3PsdModFlag == true) || wepOrigLen != getValue('wlKeys3').length)
                        {
                            Form.addParameter('k3.WEPKey', wlKeys3);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l3.WEPKey', wlKeys3);
								}
							}
                        }

                        if ( (wlKeys4 != "*****") || (wep4PsdModFlag == true) || wepOrigLen != getValue('wlKeys4').length)
                        {
                            Form.addParameter('k4.WEPKey', wlKeys4);
							if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
							{
								if(ssidIdx == 0)
								{
									Form.addParameter('l4.WEPKey', wlKeys4);
								}
							}
                        }
                    } 
                }
                else
                {
                    Form.addParameter('k1.WEPKey', wlKeys1);
                    Form.addParameter('k2.WEPKey', wlKeys2);
                    Form.addParameter('k3.WEPKey', wlKeys3);
                    Form.addParameter('k4.WEPKey', wlKeys4);
					if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
					{
						if(ssidIdx == 0)
						{
							Form.addParameter('l1.WEPKey', wlKeys1);
		                    Form.addParameter('l2.WEPKey', wlKeys2);
		                    Form.addParameter('l3.WEPKey', wlKeys3);
		                    Form.addParameter('l4.WEPKey', wlKeys4);
						}
					}
                }
            }
        }
        
        Form.addParameter('y.BeaconType','Basic');
        if (AuthMode == 'open')
        {
            if ('1' == WPS20AuthSupported)
            {
                if (method == 'None')
                {
                    if (ConfirmEx('Security is not set, continue?') == false)
                    {
                        return false;
                    }
                }
            }    
            Form.addParameter('y.BasicAuthenticationMode','None');
        }
        else
        {
            Form.addParameter('y.BasicAuthenticationMode','SharedAuthentication');
        }
        Form.addParameter('y.BasicEncryptionModes',getSelectVal('wlEncryption'));
        if ('1' == WPS20AuthSupported)
        {
            var wpsEnable = getCheckVal('wlWPSEnable');
            Form.addParameter('z.Enable',wpsEnable);        
            if (0 == getCheckVal('wlHide') && IsWpsConfigDisplay() == true)
            {
                if (wpsEnable == 1)
                {
                    if (ConfirmEx('Broadcasting of the SSID is disabled, WPS will be disabled too, continue?'))
                    {
                        Form.addParameter('z.Enable', 0);
                    }
                    else
                    {
                        return false;
                    }
                }                
            }
            if (IsWpsConfigDisplay() == false && 1 == getCheckVal('wlWPSEnable'))
            {             
                if (ConfirmEx('WPS will be disabled, continue?') == false)
                {
                    return false;
                }
               
                Form.addParameter('z.Enable',0);
            }
            if (getSelectVal('wlWPSMode')== 'PBC')
            {
                Form.addParameter('z.X_HW_ConfigMethod','PushButton');
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
                Form.addParameter('z.DevicePassword',parseInt(changeToInteger(selPinNum,8), 10));
            }
        }
    } else if (isAuthModeEnterprise(AuthMode)) {
        var wlRadiusKey = getValue('wlRadiusKey');
		if ((isFireFox4 == 1) && (wlRadiusKey == ''))
		{
			wlRadiusKey = radiuspassword;
		}
		
        var wlRadiusIPAddr = getValue('wlRadiusIPAddr');
        var wlRadiusPort = getValue('wlRadiusPort');
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');

        if (fitApFt == 1) {
            var wlRadiusAccountEnable = getCheckVal('wlRadiusAccountEnable');
            var wlRadiusAccountPort = getValue('wlRadiusAccountPort');
            var wlRadiusAccountIPAddr = getValue('wlRadiusAccountIPAddr');
            var wlRadiusAccountKey = getValue('wlRadiusAccountKey');
            if ((isFireFox4 == 1) && (wlRadiusAccountKey == '')) {
                wlRadiusAccountKey = radiusAccountpassword;
            }
            if ((wlRadiusAccountPort == '') || ((wlRadiusAccountKey == '') && (wlRadiusAccountEnable == 1)) || (wlRadiusAccountIPAddr == '')) {
                AlertEx(cfg_wlancfgother_language['amp_empty_para']);
                return false;
            }
        }
        
        if (wlRadiusIPAddr == '' || wlRadiusPort == '' || wlWpaGtkRekey == '' || wlRadiusKey == '')
        {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }

        if (isValidRaiusKey(wlRadiusKey) == false) {
            AlertEx(cfg_wlancfgdetail_language['amp_radius_keyinvalid']);
            return false;
        }
        
        if (IsAddressValid(wlRadiusIPAddr) == false) {
            AlertEx(cfg_wlancfgdetail_language['amp_srvip_invalid']);
            return false;
        }

        if ((isValidRadiusPort(wlRadiusPort) == false) || ((0 == parseInt(wlRadiusPort,10)) && ('1' == t2Flag) && (1 == DoubleFreqFlag) && ("5G" == wlanpage)))
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
            Form.addParameter('y.BeaconType','WPA');
            Form.addParameter('y.WPAAuthenticationMode','EAPAuthentication');
            Form.addParameter('y.WPAEncryptionModes',getSelectVal('wlEncryption'));
        }
        else if (AuthMode == 'wpa2')
        {
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
        
        if (wifiPasswordMask == '1') {
            if ((wlRadiusKey != "********") || (radPsdModFlag == true) ) {
                Form.addParameter('y.X_HW_RadiusKey',wlRadiusKey);
                if ((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1)) {
                    if(ssidIdx == 0) {
                        Form.addParameter('u.X_HW_RadiusKey',wlRadiusKey);
                    }
                }
            }
        } else {
            Form.addParameter('y.X_HW_RadiusKey',wlRadiusKey);
            if ((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1)) {
                if(ssidIdx == 0) {
                    Form.addParameter('u.X_HW_RadiusKey',wlRadiusKey);
                }
            }
        }

        Form.addParameter('y.X_HW_RadiuServer',wlRadiusIPAddr);

        if (fitApFt == 1) {
            Form.addParameter('s.Enable', wlRadiusAccountEnable);
            Form.addParameter('s.ServerPort', wlRadiusAccountPort);
            Form.addParameter('s.SecondaryServerIPAddr', wlRadiusAccountIPAddr);
            if ((wlRadiusAccountKey != "********") || (radAccountFlag == true)) {
                Form.addParameter('s.SecondarySecret', wlRadiusAccountKey);
            }
        }

        wlRadiusPort = parseInt(getValue('wlRadiusPort'),10);
        wlWpaGtkRekey = parseInt(getValue('wlWpaGtkRekey'),10);
        Form.addParameter('y.X_HW_RadiusPort',wlRadiusPort);
        Form.addParameter('y.X_HW_GroupRekey',wlWpaGtkRekey);
    } else if ((isAuthModePreSharedKey(AuthMode)) || (AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
        var value = getValue('wlWpaPsk');
		if ((isFireFox4 == 1) &&  (value == ''))
		{
			value = wpapskpassword;
		}
		
        var wlWpaGtkRekey = getValue('wlWpaGtkRekey');
        var wapiIP = getValue('wapiIPAddr');
        var wapiPort = getValue('wapiPort');
        

    if (isAuthModePreSharedKey(AuthMode)) {

        if (value == '' || wlWpaGtkRekey == '')
        {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }

        if (AmpTDESepicalCharaterFlag == true) {
            if (isValidWPAPskSepcialKey(value) != true) {
                return false;
            }
        } else {
            if ((AuthMode == 'wpa3-psk') || (AuthMode == 'wpa2/wpa3-psk')) {
                if (megacablePwd == 1) {
                    if ((curUserType == '0') && (value == "********") && (pskPsdModFlag != true)) {
                    } else if ((isValidWPAPskKey(value) == false) || (value.length == 64)) {
                        AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid_telmex_63']);
                        return false;
                    }
                } else if ((isValidWPAPskKey(value) == false) || (value.length == 64)) {
                    AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid_63']);
                    return false;
                }
            } else {
                if (CheckPskLenValid(value) != true){
                    return false;
                }
            }

            if (preflag == 1) {
                if ((wifiPasswordMask == 1) && (value == '********') && (pskPsdModFlag != true)) {

                } else {
                    if (IsPskKeyValid_PLDT(getElementById('wlWpaPsk').value) == false) {
                        AlertEx(cfg_wlancfgdetail_language['amp_wpskey_invalid_pldt']);
                        return false;
                    }
                }
            }
        }

        if (CfgModeWord.toUpperCase() == 'EGVDF2') {
            if (CheckPwdIsComplex(value) == false) {
                AlertEx(cfg_wlancfgdetail_language['amp_pwd_egvdf_weak_warning']);
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
        } else if (AuthMode == 'wpa/wpa2-psk') {
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
            if (isAbcIpAddress(wapiIP) == false)
            {
                AlertEx(cfg_wlancfgdetail_language['amp_wapisrvip_invalid']);
                return false;
            }
            
            if (isValidRadiusPort(parseInt(wapiPort,10)) == false)
            {
                AlertEx(cfg_wlancfgdetail_language['amp_wapisrvport_invalid']);
                return false;
            }
            Form.addParameter('y.BeaconType','X_HW_WAPI');
            Form.addParameter('y.X_HW_WAPIAuthenticationMode','WAPICERT');
            Form.addParameter('y.X_HW_WAPIEncryptionModes','SMS4');
            Form.addParameter('y.X_HW_WAPIServer',wapiIP);
            Form.addParameter('y.X_HW_WAPIPort',parseInt(getValue('wapiPort')),10);
        } else if(AuthMode == 'wapi-psk') {
             if (value == '' || wlWpaGtkRekey == '')
            {
                AlertEx(cfg_wlancfgother_language['amp_empty_para']);
                return false;
            }

            if (CheckPskLenValid(value) != true) {
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
				if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
				{
					if(ssidIdx == 0)
					{
						Form.addParameter('l.PreSharedKey',value);
					}
				}

                if('1' == kppUsedFlag)
                {
                    Form.addParameter('k.KeyPassphrase',value);
                }
            }			 
        }
        else
        {
            Form.addParameter('k.PreSharedKey',value);
			if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 == OIFlag))
			{
				if(ssidIdx == 0)
				{
					Form.addParameter('l.PreSharedKey',value);
				}
			}

            if('1' == kppUsedFlag)
            {
                Form.addParameter('k.KeyPassphrase',value);
            }
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
        
        if (0 == getCheckVal('wlHide') && '1' == WPS20AuthSupported)
        {
            if (wpsEnable == 1)
            {
                if (ConfirmEx('Broadcasting of the SSID is disabled, WPS will be disabled too, continue?'))
                {
                    Form.addParameter('z.Enable', 0);
                }
                else
                {
                    return false;
                }
            }            
        }
        if (getSelectVal('wlWPSMode')== 'PBC')
        {
            Form.addParameter('z.X_HW_ConfigMethod','PushButton');
        }
        else if (getSelectVal('wlWPSMode')== 'PIN')
        {
        	if (IsWpsConfigDisplay() != false)
        	{
                var pinFlag = 1;
                var pinErrMsg = "";
                do{
                    var clientPinNum = getValue('wlClientPinNum');
                    if (clientPinNum == '')
                    {
                        pinErrMsg = cfg_wlancfgother_language['amp_clientpin_empty'];
                        break;
                    }
                        
                     if (isInteger(clientPinNum) == false)
                     {
                          pinErrMsg = cfg_wlancfgother_language['amp_clientpin_int'];
                          break;
                      }

                      if (clientPinNum.length != 8)
                      {
                          pinErrMsg = cfg_wlancfgother_language['amp_clientpin_8int'];
                          break;
                       }

                      if (clientPinNum == 0)
                      {   
                          pinErrMsg = cfg_wlancfgother_language['amp_clientpin_invalid'];
                          break;
                      }
                        
                      var pinNum = parseInt(changeToInteger(clientPinNum,8));
                      if (ValidateChecksum(parseInt(pinNum)) != 0)
                      {
                          pinErrMsg = cfg_wlancfgother_language['amp_clientpin_invalid'];
                          break;
                      }
                      
                      pinFlag = 0;
                      
                  }while(false);
                  
                  if('1' == t2Flag)
                  {
                      pinFlag |= sendPinEvent(pinFlag);
                  }
                  
                  if(0 != pinFlag)
                  {
                    if("" == pinErrMsg)
                    {
                        pinErrMsg = cfg_wlancfgother_language['amp_clientpin_invalid'];
                    }
                    AlertEx(pinErrMsg);
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
            Form.addParameter('z.DevicePassword',parseInt(changeToInteger(selPinNum,8), 10));
        }

        if ((IsOnlyPbc()) && (checkIsExistPushBut()) && (getCheckVal('wlWPSEnable') == 1)) {
            if (nowUsePushBut != ssidIdx) {
                Form.addParameter('m.Enable', 0);
                rosNeedAddEnable = 1;
            }
        }
    }
    else
    {
    }

    return true;
}

function checkIsExistPushBut() {
    var wlanInstIdNew = ssidIdx;

    for (var i = 0; i < Wlan.length; i++) {
        if (IsInSameRadio(wlanInstIdNew, i) && (wpsPinNum[i].Enable == true)) {
            nowUsePushBut = i;
            return true;
        }
    }

    return false;
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
    var ssid;
    var wlandomain = Wlan[ssidIdx].domain;
    var length = wlandomain.length;
    var wlanInstId = parseInt(wlandomain.charAt(length-1));
    var beaconType = "Basic";

    Form.addParameter('w.SsidInst',wlanInstId);

    if(1 == preflag)
    {
       ssid = getValue('wlSsid1');
       var ssid2 = getValue('wlSsid2');

       var ssidParts = ssid.split('_');
       if(ssidParts.length != 1)
       {
          if(ssidParts[1] != "")
          {
             ssid = ssid;
          }
          else
          {
             ssid = ssid + ssid2;
          }
       }
    } else if (specialPreflag == 1) {
        ssid = getValue('wlSsid1') + getValue('wlSsid2');
    } else {
       ssid = getValue('wlSsid');
    }
	
	var AuthModeCheck1 = getSelectVal('wlAuthMode');
	 
	if(1 == DslTalkTalkFlag)
	{
		if(isValIdRule(ssid) == '') 
		{
			AlertEx(cfg_wlancfgother_language['amp_ttd_ssid_check']);
			return false;
		}

		if ((AuthModeCheck1 == 'wpa-psk') || (AuthModeCheck1 == 'wpa2-psk') || (AuthModeCheck1 == 'wpa/wpa2-psk') || (AuthModeCheck1 == 'wpa3-psk') || (AuthModeCheck1 == 'wpa2/wpa3-psk')) {
			if(isValPWDRule(getValue('twlWpaPsk')) == '') 
			{
				AlertEx(cfg_wlancfgother_language['amp_ttd_pwd_check']);
				return false;
			}
		}
	}
    
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
    
	Form.addParameter('w.SSIDAdvertisementEnabled',getCheckVal('wlHide'));
	Form.addParameter('w.WMMEnable',getCheckVal('enableWmm'));

	Form.addParameter('w.MaxAssociateNum',getValue('X_HW_AssociateNum'));
	
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
    } else if (isAuthModeEnterprise(AuthMode)) {
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
        } else if (AuthMode == 'wpa/wpa2') {
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
    } else if ((isAuthModePreSharedKey(AuthMode)) || (AuthMode == 'wapi') || (AuthMode == 'wapi-psk')) {
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
        } else if (AuthMode == 'wpa/wpa2-psk') {
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

var apExtendedWLC = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC,EXTEND);%>;

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

function IsWlanSameSsid()
{
    var WlanWifi2G;
    var WlanWifi5G;
    for (var i = 0; i < Wlan.length; i++) {
        if (getInstIdByDomain(Wlan[i].domain) == 1) {
            WlanWifi2G = Wlan[i];
        }

        if (getInstIdByDomain(Wlan[i].domain) == parseInt(ssidStart5G) + 1) {
           WlanWifi5G = Wlan[i];
        }
    }

    if (WlanWifi2G.ssid != WlanWifi5G.ssid) {
        return false;
    }

    if (WlanWifi2G.BeaconType != WlanWifi5G.BeaconType) {
        return false;
    }

    if ((WlanWifi2G.BeaconType == 'Basic') || (WlanWifi2G.BeaconType == 'None')) {
        if ((WlanWifi2G.BasicAuthenticationMode != WlanWifi5G.BasicAuthenticationMode)
            || (WlanWifi2G.BasicEncryptionModes != WlanWifi5G.BasicEncryptionModes)) {
            return false;
        }
    } else if (WlanWifi2G.BeaconType == 'WPA') {
        if ((WlanWifi2G.WPAAuthenticationMode != WlanWifi5G.WPAAuthenticationMode)
            || (WlanWifi2G.WPAEncryptionModes != WlanWifi5G.WPAEncryptionModes)) {
            return false;
        }
    } else if ((WlanWifi2G.BeaconType == '11i') || (WlanWifi2G.BeaconType == 'WPA2')) {
        if (WlanWifi2G.IEEE11iAuthenticationMode != WlanWifi5G.IEEE11iAuthenticationMode 
            || WlanWifi2G.IEEE11iEncryptionModes != WlanWifi5G.IEEE11iEncryptionModes) {
            return false;
        }
    } else if ((WlanWifi2G.BeaconType == 'WPAand11i') || (WlanWifi2G.BeaconType == 'WPA/WPA2') ||
                (WlanWifi2G.BeaconType == 'WPA3') || (WlanWifi2G.BeaconType == 'WPA2/WPA3')) {
        if (WlanWifi2G.X_HW_WPAand11iAuthenticationMode != WlanWifi5G.X_HW_WPAand11iAuthenticationMode
            || WlanWifi2G.X_HW_WPAand11iEncryptionModes != WlanWifi5G.X_HW_WPAand11iEncryptionModes) {
            return false;
        }
    }

    return true;
}

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
    var tempEncryMode = getSelectVal('wlEncryption');
    var authMode = getSelectVal('wlAuthMode');
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

function SubmitForm()
{
    var form = new webSubmitForm();
    var url = "";
    var busyFlag = 0;
    if (addParameter1(form) == false) {   
        return;
    }

    if (addParameter2(form) == false) {
        setDisable('btnApplySubmit',0);
        setDisable('cancel',0);
        if (pinlock == 1) {
            pinlock = 0;
        }

        return;
    }

    if (AddParaForCover(form) == false) {      
        return;
    }
    
    for(var index = 0; index < Wlan.length; index++) {
        if(Wlan[index].name == "ath4" ) {
            var ssidIdx5G = index;
            break;
        }
    }

    var wlanDomain = Wlan[ssidIdx].domain;
    if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
        var wlanDomain5g = Wlan[ssidIdx5G].domain;
    }
    var authMode = getSelectVal('wlAuthMode');
    var tempEncryMode = getSelectVal('wlEncryption');
    var wifiCoverIndex = getInstIdByDomain(Wlan[ssidIdx].domain);
    var configAction = 'InternetGatewayDevice.X_HW_DEBUG.WLANConfigAction';

    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "../common/getSsidProcFlag.asp?&1=1",
            data :"wlanid="+wifiCoverIndex,
            success : function(data) {
            busyFlag = data;
            }
        });

    if (busyFlag == '1') {
        AlertEx(cfg_wificover_basic_language['amp_wificover_modify_wifipara_synchronizing']);
        return;
    }

    if (isWifiCoverSsidExt(wifiCoverIndex)) {
        if (isAuthModeEnterprise(authMode)) {
            AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_auth']);
            return;
        } else if (((authMode == 'shared') || (authMode == 'open')) && (tempEncryMode == 'WEPEncryption')) {
            AlertEx(cfg_wificover_basic_language['amp_wificover_ssid_change_wep']);
            return;
        }
    }

    if (isWifiCoverSsid(getWlanInstFromDomain(wlanDomain))) {
        if (ConfirmEx(cfg_wificover_basic_language['amp_wificover_ssid_change_notify']) == false) {
            guiCoverSsidNotifyFlag = 0;      
            return;
        }
    }
    
    if ((WiFiUpStatus == 1) && (TribandFlag == 0)) {
        if (ConfirmEx(cfg_wificover_basic_language['amp_wificover_modify_wlancfg_sug']) == false) {
             return;
        }
    }
    
    if (isBsdAutoSyncPara() == true) {
        if (wlanpage == "5G") {
            if (ConfirmEx(cfg_wlancfgother_language['amp_bandsteering_5G_sug']) == false) {
                return;
            }
        } else {
            if (ConfirmEx(cfg_wlancfgother_language['amp_bandsteering_2G_sug']) == false) {
                return;
            }
        }
    }

    if (AddParameter5G(wlanDomain, form) == false) {
        return;
    }

    if ((authMode == 'shared') || (authMode == 'open')) {
        if(HiLinkRoll == 0) {
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0) && (tempEncryMode != 'None')) {    
                url = 'set.cgi?y=' + wlanDomain + '&u=' + wlanDomain5g;
            } else {
                url = 'set.cgi?y=' + wlanDomain;
            }
        } else {
            url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlanDomain;
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0) && (tempEncryMode != 'None')) {
                url = '&u=' + wlanDomain5g;
            } else if (isSet5Gflag == 1) {
                url = '&Y=' + Wlan[ssidIdx5G].domain;
            }
        }

        if (getSelectVal('wlEncryption') == 'None') {
            /*form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlanDomain
                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');*/
        } else {
            if (TelMexFlag == 1) {
                /*form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlanDomain
                    + '&k1=' + wlanDomain + '.WEPKey.' 
                    + getSelectVal('wlKeyIndex')
                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');*/
                url += '&k1=' + wlanDomain + '.WEPKey.' + getSelectVal('wlKeyIndex');
            } else {
                /*form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlanDomain
                    + '&k1=' + wlanDomain + '.WEPKey.1'
                    + '&k2=' + wlanDomain + '.WEPKey.2'
                    + '&k3=' + wlanDomain + '.WEPKey.3'
                    + '&k4=' + wlanDomain + '.WEPKey.4'
                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');*/
                if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                    url += '&k1=' + wlanDomain + '.WEPKey.1'
                        + '&k2=' + wlanDomain + '.WEPKey.2'
                        + '&k3=' + wlanDomain + '.WEPKey.3'
                        + '&k4=' + wlanDomain + '.WEPKey.4'
                        + '&l1=' + wlanDomain5g + '.WEPKey.1'
                        + '&l2=' + wlanDomain5g + '.WEPKey.2'
                        + '&l3=' + wlanDomain5g + '.WEPKey.3'
                        + '&l4=' + wlanDomain5g + '.WEPKey.4';
                } else {
                    url += '&k1=' + wlanDomain + '.WEPKey.1'
                        + '&k2=' + wlanDomain + '.WEPKey.2'
                        + '&k3=' + wlanDomain + '.WEPKey.3'
                        + '&k4=' + wlanDomain + '.WEPKey.4';    
                }
            }
        }

        if (WPS20AuthSupported == '1') {
            url += '&z=' + wlanDomain + '.WPS';
        }
    } else if (isAuthModeEnterprise(authMode)) {
        if(HiLinkRoll == 0) {
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                url = 'set.cgi?y=' + wlanDomain + '&u=' + wlanDomain5g;
            } else {
                url = 'set.cgi?y=' + wlanDomain;
            }
        } else {
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
                    + wlanDomain + '&u=' + wlanDomain5g;
            } else {
                url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
                    + wlanDomain;
            }
        }

        if (fitApFt == 1) {
            url += '&s=' + wlanDomain + '.Accounting';
        }

    } else if (isAuthModePreSharedKey(authMode)) {
        if(0 == HiLinkRoll) {
            url = 'set.cgi?y=' + wlanDomain;
        } else {
            url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y=' + wlanDomain;
            if (isSet5Gflag == 1) {
                url += '&Y=' + Wlan[ssidIdx5G].domain;
            }
        }

        if (IsWpsConfigDisplay() == false) {
            url += '&k=' + wlanDomain + '.PreSharedKey.1';
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                url += '&l=' + wlanDomain5g + '.PreSharedKey.1';
            } else if (isSet5Gflag == 1) {
                url += '&K=' + Wlan[ssidIdx5G].domain + '.PreSharedKey.1';
            }
        } else {
            if (rosNeedAddEnable == 1) {
                url += '&m=' + Wlan[nowUsePushBut].domain + '.WPS'
            }

            url += '&z=' + wlanDomain + '.WPS' + '&k=' + wlanDomain + '.PreSharedKey.1';
            if ((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                url += '&l=' + wlanDomain5g + '.PreSharedKey.1';
            } else if (isSet5Gflag == 1) {
                url += '&K=' + Wlan[ssidIdx5G].domain + '.PreSharedKey.1';
            }
        }
    } else if((authMode == 'wapi') || (authMode == 'wapi-psk')) {
        if(HiLinkRoll == 0) {
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                url = 'set.cgi?y=' + wlanDomain + '&k=' + wlanDomain + '.PreSharedKey.1' + '&l=' + wlanDomain5g + '.PreSharedKey.1';
            } else {
                url = 'set.cgi?y=' + wlanDomain + '&k=' + wlanDomain + '.PreSharedKey.1';
            }
        } else {
            if((DoubleFreqFlag == 1) && (wlanpage == "2G") && (OIFlag == 1) && (ssidIdx == 0)) {
                url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
                    + wlanDomain + '&k=' + wlanDomain + '.PreSharedKey.1' + '&l=' + wlanDomain5g + '.PreSharedKey.1';
            } else {
                url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&y='
                    + wlanDomain + '&k=' + wlanDomain + '.PreSharedKey.1' 
            }
        }
    } else {
        if(HiLinkRoll == 0) {
            url = 'set.cgi?x=InternetGatewayDevice.LANDevice.1' + '&y=' + wlanDomain;
        } else {
            url = 'set.cgi?c1=' + configAction + '&w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&x=InternetGatewayDevice.LANDevice.1'
                + '&y=' + wlanDomain;
        }
    }

    if (CfgMode.toUpperCase() == 'ROSUNION') {
        url += '&q=' + wlanDomain + '.X_HW_AttachConf';
    }

    if ((wifiCoverIndex != 1) && (wifiCoverIndex != 5) && isSontOrSYN) {
        if (isGuset2G) {
            if (IsGuestSsid(wifiCoverIndex) && (wlanpage == "2G")) {
                if (getCheckVal('GuestSsidEnable') == 1) {
                    form.addParameter('a.SSID_IDX', wifiCoverIndex);
                } else {
                    form.addParameter('a.SSID_IDX', 0);
                }
                url += '&a=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1';
            }
        } else {
            if (wlanpage == "2G") {
                if (getCheckVal('GuestSsidEnable') == 1) {
                    form.addParameter('a.SSID_IDX', wifiCoverIndex);
                } else {
                    form.addParameter('a.SSID_IDX', 0);
                }
                url += '&a=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1';
            }
        }

        if (isGuset5G) {
            if (IsGuestSsid(wifiCoverIndex) && (wlanpage == "5G")) {
                if (getCheckVal('GuestSsidEnable') == 1) {
                    form.addParameter('a.SSID_IDX', wifiCoverIndex);
                } else {
                    form.addParameter('a.SSID_IDX', 0);
                }
                url += '&a=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.2';
            }
        } else {
            if (wlanpage == "5G") {
                if (getCheckVal('GuestSsidEnable') == 1) {
                    form.addParameter('a.SSID_IDX', wifiCoverIndex);
                } else {
                    form.addParameter('a.SSID_IDX', 0);
                }
                url += '&a=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.2';
            }
        }
        form.addParameter('a.PortIsolation', 1);
    }

    if (((CfgMode.toUpperCase() == 'DTURKCELL2WIFI') || (turkcellFlag == 1)) && (ssidIdx != -1)) {
        url += '&r=' + wlanDomain + '.X_HW_RoamProtocol';
    }

    form.addParameter('c1.ActionType', 0);
    url += '&c2=' + configAction;
    form.addParameter('c2.ActionType', 1);
    form.addParameter('c2.SSIDList', '' + getInstIdByDomain(Wlan[ssidIdx].domain));

    url += '&RequestFile=html/amp/wlanbasic/WlanBasic.asp';
    form.setAction(url);

    if(!isWlanInitFinished(wlanpage, WlanWifi.mode, WlanWifi.channelWidth)) {
        return;
    }
    setDisable('btnWpsPBC', 1);
    DisableButtons();
    form.addParameter('x.X_HW_Token', getValue('onttoken'));
    form.submit();
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
        
        var wlanInst = getInstIdByDomain(Wlan[ssidIdx].domain);
		
        if ((t2Flag == '1') || (DslTalkTalkFlag == '1') || (IsOnlyPbc())) {
            Form.setAction('WpsPBC.cgi?wlaninst=' + wlanInst + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
        }
		else
		{
		
			if ('5G' == wlanpage)
			{
				if (TMCZSTflag == 1) {
					if (webEnable5G != 1 && curUserType != 0) {
						AlertEx(cfg_wlancfgother_language['amp_5g_webenable']);
						return;
					}
				}
				Form.setAction('WpsPBC.cgi?freq=5G' + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
			}
			else
			{
				Form.setAction('WpsPBC.cgi?freq=2G' + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
			}
		}
        
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

function SetWlanBasicValueInAis()
{
    if (aisAp == 1 && HiLinkRoll == 0) {
        setDisable('wlWpaPsk',1);
        setDisable('twlWpaPsk',1);
        setDisable('wlSsid',1);
        setDisable('twlRadiusKey',1);
        setDisable('wlRadiusKey',1);
        setDisable("wlKeys1", 1);
        setDisable("twlKeys1", 1); 
        setDisable("wlKeys2", 1);
        setDisable("twlKeys2", 1);
        setDisable("wlKeys3", 1);
        setDisable("twlKeys3", 1);
        setDisable("wlKeys4", 1);
        setDisable("twlKeys4", 1);
    }
}

function WlanBasic(enable)
{
    setDisplay('wlanBasicCfg',1);
    setCheck('wlEnbl', enable);

    if (((enable == 1) || ((enable == 0) && (fttrFlag == 1))) && (WlanArr[0] != null)) {
        ssidIdx = 0;

        if ((1 == DoubleFreqFlag) && ("5G" == wlanpage) && (uiTotal5gNum > 0))
        {
            FirstRecordFor5G();
            selectLine('record_' + firstLine);

        }
        else if((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (uiTotal2gNum > 0))
        {
            FirstRecordFor2G();
            selectLine('record_' + firstLine);
        }
        else if (uiTotalNum > 0)
        {
            selectLine('record_0');    
        }
    
        setDisplay('wlanCfg',1);
        var authMode = Wlan[ssidIdx].BeaconType;
        beaconTypeChange(authMode); 

        if (1 == DTHungaryFlag)
        {
            SetWpsTimeNoTimer();
            WpsTimeHandle = setInterval("SetWpsTime();", 1000);
        }
    }
    else if ((0 == enable))
    {
        setDisplay('wlanCfg',0);
    } 
    else
    {
        setDisplay('ssidDetail', 0);
    }
    SetWlanBasicValueInAis();
}

function SetWpsTime()
{
    var desc = '';
    var portIndex = getPortFromIndex(ssidIdx);
    
    getWpsTimer();

    WpsIndex = WpsTimeInfo.split(',')[0];
    WpsTime = WpsTimeInfo.split(',')[1];

    if ((0 != WpsTime) && (portIndex == WpsIndex))
    {
        desc = WpsTime + ' seconds left';
    }
        
    ShowWpsTimer();
        
    getElById('DivPBCTimeNote').innerHTML = desc;
    getElById('DivPinTimeNote').innerHTML = desc;
    getElById('DivAPPinTimeNote').innerHTML = desc;
    
    if ((0 == WpsTime) && 
        !((wpsPinNum[ssidIdx].X_HW_ConfigMethod == 'Lable') && (wpsPinNum[ssidIdx].X_HW_PinGenerator == 'AP')))
    {
        if(WpsTimeHandle != undefined)
        {
           clearInterval(WpsTimeHandle);
        }
    }

}

function SetWpsTimeNoTimer()
{
    var desc = '';
 
    var portIndex = getPortFromIndex(ssidIdx);

    if ((0 != WpsTime) && (portIndex == WpsIndex))
    {
        desc = WpsTime + ' seconds left';
    }

    getElById('DivPBCTimeNote').innerHTML = desc;
    getElById('DivPinTimeNote').innerHTML = desc;
    getElById('DivAPPinTimeNote').innerHTML = desc;
}

function check11nAndWmm()
{
    if (WlanWifi.mode == '11n')
    {
        setDisable('enableWmm', 1);
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

function checkAuthModeAndWPS()
{
    var authMode = getSelectVal('wlAuthMode');
	switch (authMode)
    {
        case 'open':
        case 'shared':
        case 'wpa':
        case 'wpa2':
        case 'wpa/wpa2':
        case 'wpa3':
        case 'wpa2/wpa3':
            setDisable('wlHide', 0); 
            break; 

        case 'wpa-psk':
        case 'wpa2-psk':
        case 'wpa/wpa2-psk':
        case 'wpa3-psk':
        case 'wpa2/wpa3-psk':
            WPSAndHideCheck();
            break;
        
        default:
            break;
    }
}

function wlHideChange()
{
    if('1' == t2Flag)
    {
        if(0 == getCheckVal('wlHide'))
        {
            AlertEx(cfg_wlancfgbasic_tde_language['amp_wifitde_ssidhide_alert']);
            setDisable('wlWPSEnable', 1);
            setCheck('wlWPSEnable', 0); 
        }
        else
        {
            AlertEx(cfg_wlancfgbasic_tde_language['amp_wifitde_ssidshow_alert']);
            setDisable('wlWPSEnable', 0);
            setCheck('wlWPSEnable', 1); 
        }
    }
    else if (1 == PTVDFFlag)
    {
        var WpsEnable = wpsPinNum[ssidIdx].Enable;
        if((1 == WpsEnable) && (0 == getCheckVal('wlHide')) && (true == IsWpsConfig()))
        {
            AlertEx(cfg_wlancfgother_language['amp_bcastssid_off_help']);
            setCheck('wlHide',1);
        }
    }
}

function setWMMSug()
{
    if (CfgMode.toUpperCase() == "ROSUNION") {
        return;
    }
	var spanWmm = getElementById('SpanWMM');
	if ( 0 == getCheckVal('enableWmm'))
	{
		spanWmm.innerHTML = cfg_wlancfgdetail_language['amp_wlancfgdetail_WMM_status'];
		spanWmm.style.color = '#ff0000';
	}
	else 
	{
		spanWmm.innerHTML = '';
	}
}

function wmmChange()
{
    if ((0 == getCheckVal('enableWmm')) && ((WlanWifi.mode == "n") || (WlanWifi.mode == "11bgn") || (WlanWifi.mode == "11gn") ||(WlanWifi.mode == "11na")))
    {
        AlertEx(cfg_wlancfgother_language['amp_wlan_wmm_disable_notify']);
    }
	
	setWMMSug();
}

function setBasicSug()
{
	setEncryptSug();
	setWMMSug();
	
	if('1' == nonWepFlag && getSelectVal('wlAuthMode') == 'open')
	{
		hideWepDiv();
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
    if (fitApFt == 1) {
        radAccountFlag = false;
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

    $('#wlRadiusKey').bind("propertychange input", function(){ 
        if(getValue('wlRadiusKey') != "********") 
        {
            radPsdModFlag = true;
        }
    } );

    if (fitApFt == 1) {
        $('#wlRadiusAccountKey').bind("propertychange input", function(){ 
            if(getValue('wlRadiusAccountKey') != "********") {
                radAccountFlag = true;
            }
        } );
    }
}

function LoadResource()
{
    if (maxStaNum == '128') {
        getElById('SpanDeviceNum').innerHTML = cfg_wlancfgdetail_language['amp_AssociateNum_note_128'];
        getElById('TdDeviceNum').title = cfg_wlancfgdetail_language['amp_devnum_help_128'];
    } else if (maxStaNum == '64') {
        getElById('SpanDeviceNum').innerHTML = cfg_wlancfgdetail_language['amp_AssociateNum_note_64'];
        getElById('TdDeviceNum').title = cfg_wlancfgdetail_language['amp_devnum_help_64'];
    } else if (maxStaNum == '40') {
        getElById('SpanDeviceNum').innerHTML = cfg_wlancfgdetail_language['amp_AssociateNum_note_40'];
        getElById('TdDeviceNum').title = cfg_wlancfgdetail_language['amp_devnum_help_40'];
    }
}

function vdfPwdStrength(id)
{
    var checkid = "pwdvalue5"
    egvdfPwdStrengthcheck(id, checkid);
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

function setTab(name,cursel){
    for (var i=1; i <= 2; i++){
        var menu=document.getElementById(name+i);
        menu.className=((i==cursel)?"hover":"");
    }
	
    if (cursel ==1)
    {
		SelHighBand = 0;
    }
    else
    {
		SelHighBand = 1;	
    }
	
	top.wlanBasic_selHighBand = SelHighBand;
	window.location = "/html/amp/wlanbasic/WlanBasic.asp?5G";
}

function isSetTriBand()
{
	if ((1 == DoubleFreqFlag) && ("5G" == wlanpage) && (1 == TribandFlag) && (1 == HiLinkRoll) && (1 == TriBandHighBandEnable))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function getAddHighBandSSID()
{
	var addHighBandSSID = first5GIfIndex;
	var highBandSSIDArray = { 8: 0, 9 : 0, 10 : 0, 11 : 0};
	for (var loop = 0; loop < WlanMap.length; loop++)
    {
		if (WlanMap[loop].portIndex > (first5GIfIndex-1))
		{
			highBandSSIDArray[WlanMap[loop].portIndex] = 1;
		}
    }
	
	for (var loop = 0; loop < 4; loop++)
    {
		if (highBandSSIDArray[first5GIfIndex + loop] == 0)
		{
			addHighBandSSID = first5GIfIndex + loop;
			break;
		}
    }
	
	return addHighBandSSID;
}

function EnableTriBand()
{
	setDisable('triBandEnbl', 1);
    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
	setDisable('wlEnbl', 1);
	
	var Form = new webSubmitForm();
	var enable = (getCheckVal('triBandEnbl') == 0) ? 1 : 0 ;

	Form.addParameter('x.HighBandEnable', enable);	
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_WIFIInfo.X_HW_HighBandSupported'
					+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function LoadFrame()
{       
    g_currentwlanInst = 0;

    $("#checkinfo1Row").css("display", "none");
    var pwdcheck1 = document.getElementById('checkinfo1');
    pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd1" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="amp_pwd_strength_low"></span> </div></div>';

    $("#checkinfo2Row").css("display", "none");
    var pwdcheck2 = document.getElementById('checkinfo2');
    pwdcheck2.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd2" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue2" BindText="amp_pwd_strength_low"></span></div></div>';

    $("#checkinfo3Row").css("display", "none");
    var pwdcheck3 = document.getElementById('checkinfo3');
    pwdcheck3.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd3" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue3" BindText="amp_pwd_strength_low"></span></div></div>';

    $("#checkinfo4Row").css("display", "none");
    var pwdcheck4 = document.getElementById('checkinfo4');
    pwdcheck4.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd4" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue4" BindText="amp_pwd_strength_low"></span></div></div>';

    $("#checkinfo5Row").css("display", "none");
    var pwdcheck5 = document.getElementById('checkinfo5');
    pwdcheck5.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd5" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></span></div></div>';

    Total2gNum();
    if ("1" == t2Flag)
    {
        setTDEPskMaxLen();
    }
    if ('1' == WPS20AuthSupported)
    {
        var ClientPin = document.getElementById("wlClientPinNum");
        ClientPin.maxLength = 9;
    }

    if (enbl == '')
    {
        setDisplay('wlanBasicCfg',0);
    }
    else
    {    
        if(1 == PccwFlag)
        {
            if((1 == DoubleFreqFlag)&&('2G' == wlanpage))
            {
                if ((null == Wlan[0]) || (0 == Wlan[0].X_HW_ServiceEnable) || ("ath0" != Wlan[0].name))
                {     
                       setDisplay('ConfigForm',0); 
                       return;
                }        
            }
            else if((1 == DoubleFreqFlag)&&('5G' == wlanpage))
            {
                var index;
                for(index = 0; index < Wlan.length; index++)
                {
                    if("ath4" == Wlan[index].name)
                    {
                        break;
                    }
                }                
                if ((index >= Wlan.length) || (0 == Wlan[index].X_HW_ServiceEnable))
                {     
                       setDisplay('ConfigForm',0); 
                       return;
                }        
            }
            else
            {
                if ((null == Wlan[0]) || (0 == Wlan[0].X_HW_ServiceEnable))
                {     
                   setDisplay('ConfigForm',0); 
                   return;
                }
            }        
        }  
        
        setDisplay('ConfigForm',1); 
        if (1 == DoubleFreqFlag)
        {
            FirstRecordFor5G();
            
            if ('2G' == wlanpage)
            {
                WlanBasic(enbl2G & enbl);
            }

            if ('5G' == wlanpage)
            {
                WlanBasic(enbl5G & enbl);
            }
        }
        else
        {
            WlanBasic(enbl);
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

    if (fitApFt == 1) {
        document.getElementById('wlRadiusAccountKey').title  = posswordComplexTitle;
        document.getElementById('twlRadiusAccountKey').title = posswordComplexTitle;
    }

    if ('SPANISH' == curLanguage.toUpperCase())
    {
         document.getElementById('wlAuthMode').style.width = '220px';
         document.getElementById('wlEncryption').style.width = '220px';
    }

    if(1 == PccwFlag)
    {           

        setDisplay('wlanOnOff',0);
        setDisplay('table_space1',0); 
        setDisplay('table_space2',0);
		setDisplay('DivSSIDList_Table_Container',0);
		setDisplay('list_table_spread',0);
        setDisplay('ssid_defail',0);   
        setDisable('enableWmm', 1);

        if ((enbl != 1) || ((1 == DoubleFreqFlag) && ("2G" == wlanpage) && (1 != enbl2G)) || ((1 == DoubleFreqFlag) && ("5G" == wlanpage) && (1 != enbl5G)))
        {
            setDisplay('ssidDetail',0);
        }
    }
    else
    {
        if ((1 == gzcmccFlag) && (curUserType == sptUserType))
        {
            setDisable('Newbutton', 1);
            setDisable('DeleteButton', 1);   
            setDisable('wlEnbl', 1);
        }

        if ((1 == L2WifiFlag) || (("TELECENTRO" == CfgMode) && (sptUserType == curUserType)))
        {
            setDisplay('Newbutton', 0);  
            setDisplay('DeleteButton', 0);  
        }

        if (1 == DoubleFreqFlag)
        {
            if("2G" == wlanpage)
            {
                if(SsidNum2g > 0)
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
                if ((1 != TriBandHighBandEnable) || ((1 == TriBandHighBandEnable) && (0 == SelHighBand)))
				{
					if(SsidNum5g > 0)
					{
						setDisplay('ssidDetail',1);
					}
					else
					{
						setDisplay('ssidDetail',0);
					}
				}
				else if ((1 == TriBandHighBandEnable) && (1 == SelHighBand))
				{
					if (TriHighBandNum > 0)
					{
						setDisplay('ssidDetail',1);
					}
					else
					{
						setDisplay('ssidDetail',0);
					}
					
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
    }

	if (1 == PTVDFFlag && 1 == DoubleFreqFlag)
	{
		if (curUserType == sptUserType)
		{
			setDisplay('DivSSIDList_Table_Container', 0);
			setDisplay('list_table_spread', 0);
		}
		
		if((enbl2G != 0 && ("2G" == wlanpage)) || (enbl5G != 0 && ("5G" == wlanpage)))
		{
			setDisplay('wlanswitch', 0);
		}
		document.body.className = '';
	}
	
	if('CAMPUSLAN' == CfgMode.toUpperCase())
	{
		setDisplay('wlanswitch', 0);
		setDisplay('Newbutton', 0);  
		setDisplay('DeleteButton', 0); 
	}
	
    addAuthModeOption();

    check11nAndWmm();
    if('1' == t2Flag)
    {
        checkAuthModeAndWPS();
    }
    
    LoadResource();
    
    if (wifiPasswordMask == 1) {
        BindPsdModifyEvent();

        setDisplay('hidewlRadiusKey', 0);
        setDisplay('hidewlWpaPsk', 0);
        setDisplay('hidewlKeys', 0);
        setDisplay('hideId1', 0);
        setDisplay('hideId2', 0);
        setDisplay('hideId3', 0);

        if (fitApFt == 1) {
            setDisplay('hidewlRadiusAccountKey', 0);
            setDisplay('hideId4', 0);
        }
    }
    
    if ((CurrentBin.toUpperCase() == 'CMCC') || (isVideoRetrans == 1)) {
        setDisplay('Newbutton', 0);  
        setDisplay('DeleteButton', 0);  
    }
	
	if ((1 == OnlySsid1Flag) && (curUserType == sptUserType))
    {
        setDisplay('Newbutton', 0);  
        setDisplay('DeleteButton', 0);  
    }
	
	if ((CfgMode.toUpperCase() == 'DBAA1') && ((sptUserType == curUserType) || (sysUserType == curUserType))) {
        setDisplay('Newbutton', 0);  
        setDisplay('DeleteButton', 0); 
	}

	if (1 == ForbidAssocFlag)
    {
        setDisplay('tr_sta_num_max_limit', 0);
    }
	
	if	(t2Flag == 1) 
	{
		if((getWlanInstFromDomain(Wlan[ssidIdx].domain) == 3) && ("1" == XHWAdvanceCfg.value))
		{
			setDisplay('tr_sta_num_max_limit', 1);
		}
		else
		{
			setDisplay('tr_sta_num_max_limit', 0);
		}
	}
	
    if (["SONETSGP200W", "SYNCSGP200W", "SYNCSGP210W"].indexOf(CfgMode.toUpperCase()) >= 0) {
        HideAdminPsk();
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
        
        if (true == telmexSpan)
		{
			if (b.getAttribute("BindText") == 'amp_link_cdevnum')
			{
			   b.innerHTML = cfg_wlancfgdetail_language['amp_link_cdevnum_telmex'];
			   continue;
			}
			if (b.getAttribute("BindText") == 'amp_bcast_cssid')
			{
			   b.innerHTML = cfg_wlancfgdetail_language['amp_bcast_cssid_telmex'];
			   continue;
			}
			
		}      
        
    }


	if (1 == IspSSIDVisibility)
    {
        if (jQ_IspEnabledItem == null)
        {
            jQ_IspDisabledItem = $("#ssidDetail input:disabled, #ssidDetail select:disabled, #ssidDetail button:disabled").get();
            jQ_IspEnabledItem  = $("#ssidDetail input:enabled,  #ssidDetail select:enabled,  #ssidDetail button:enabled").get();
        }

        if (1 == isSsidForIsp(g_currentwlanInst) )
        {
            $(jQ_IspEnabledItem).each(function ()
            {
                setDisable(""+this.id, 1);
            })
        }
    }

	$("#DivSSIDList_Table_Container").width($("#ConfigForm").width());
	fixIETableScroll("DivSSIDList_Table_Container", "wlanInst");
	
    if(stapinlock.charAt(2) == '1' && t2Flag == 1)
	{
	    AlertEx(cfg_wlancfgother_language['amp_clientpin_invalid']);
	}
	
	setBasicSug();
	
	if ((1 == DoubleFreqFlag) && ("5G" == wlanpage) && (1 == TribandFlag) && (1 == HiLinkRoll) &&
		(getElement('wlanCfg').style.display != 'none'))
	{
		var triBandEnable = (TriBandHighBandEnable == 0) ? 1 : 0;
		setCheck('triBandEnbl', triBandEnable);
		setDisplay('TriBandswitch', 1);
	}
	else
	{
		setDisplay('TriBandswitch', 0);
	}
	
	if (isSetTriBand() && (getElement('wlanCfg').style.display != 'none'))
	{
		getElement('menu1').className = (0 == SelHighBand) ? 'hover' :'';
		getElement('menu2').className = (1 == SelHighBand) ? 'hover' :'';
		setDisplay('TriBandMenuDiv', 1);
		$('#wlanCfg').addClass('MenuboxDivBorder');
	}
	else 
	{
		setDisplay('TriBandMenuDiv', 0);
		$('#wlanCfg').removeClass('MenuboxDivBorder');
	}
	
	PinUpTime();
	showPingUpTime = setInterval("PinUpTime()",1000);
	if(capApPinRefresh  == 1)
	{
		setDisplay("wpsApPinNumber",1); 
	}

    if (rosunionGame == 1) {
        $("#wlanInst").find('td').each(function (j, item) {
            $(item).addClass('rosTableBorderBottom');
        });
    }

    if ((showWmmFlag == 0) && (curUserType == sptUserType)) {
        setDisplay('wmmSwitchTr', 0);
    }

    SetDomDisabled();
    createQRCode();

    if (isFitAp == 1) {
        FitApDisable();
    }

    if ((CfgMode.toUpperCase() == 'AISAP') && (meshMode != 3)) {
        SetSsidDisabled();
    }

    if (firstLine === -1) {
        clickAdd('Wireless');
    }
    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        setDisable('wlEnbl', 1);
    }
}

function FitApDisable() {
    setDisable("wlEnbl", 1);
    setDisable("Newbutton", 1);
    setDisable("DeleteButton", 1);
    setDisable('wlSsid', 1);
    setDisable('wlEnable', 1);
    setDisable('X_HW_AssociateNum', 1);
    setDisable('wlHide', 1);
    setDisable('enableWmm', 1);
    setDisable('wlAuthMode', 1);
    setDisable('wlEncryption', 1);
    setDisable('wlWpaPsk', 1);
    setDisable('twlWpaPsk', 1);
    setDisable('wlWpaGtkRekey', 1);
    setDisable('wlWPSEnable', 1);
    setDisable('wlWPSMode', 1);
    setDisable('btnWpsPBC', 1);
    setDisable('RegeneratePIN', 1);
    setDisable('wlKeyBit', 1);
    setDisable('wlKeys1', 1);
    setDisable('twlKeys1', 1);
    setDisable('wlKeys2', 1);
    setDisable('twlKeys2', 1);
    setDisable('wlKeys3', 1);
    setDisable('twlKeys3', 1);
    setDisable('wlKeys4', 1);
    setDisable('twlKeys4', 1);
    setDisable('wlClientPinNum', 1);
    setDisable('wlRadiusIPAddr', 1);
    setDisable('wlRadiusPort', 1);
    setDisable('wlRadiusKey', 1);
    setDisable('twlRadiusKey', 1);
    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
    if (fitApFt == 1) {
        setDisable('wlRadiusAccountEnable', 1);
        setDisable('wlRadiusAccountPort', 1);
        setDisable('wlRadiusAccountIPAddr', 1);
        setDisable('wlRadiusAccountKey', 1);
        setDisable('twlRadiusAccountKey', 1);
    }
}

function SetDomDisabled() {
    if (aisAp == 1) {
        if ((DoubleFreqFlag != 1) || (wlanpage != '5G')) {
            return;
        }
        var curWlanInst = 0;
        if (Wlan[ssidIdx] != undefined) {
            curWlanInst = getWlanInstFromDomain(Wlan[ssidIdx].domain);
        }
 
        var isConfigSsidFlag = 1;
        if (curWlanInst == 8) {
            isConfigSsidFlag = 0;
            if (aisAp == 1) {
                isConfigSsidFlag = 1;
            }
        }
        setDisplay('trSsidEnable', isConfigSsidFlag);
        setDisplay('tr_sta_num_max_limit', isConfigSsidFlag);
        setDisplay('trBroadcastSsid', isConfigSsidFlag);
        setDisplay('wmmSwitchTr', isConfigSsidFlag);
        setDisable('wlKeyBit', !isConfigSsidFlag);
        setDisable('wlKeyIndex', !isConfigSsidFlag);
        setDisable('wlAuthMode', !isConfigSsidFlag);
        setDisable('wlEncryption', !isConfigSsidFlag);

        if (isConfigSsidFlag == 0) {
            setDisplay('wlWapi', isConfigSsidFlag);
            setDisplay('tbRadiusIPAddr', isConfigSsidFlag);
            setDisplay('tbRadiusPort', isConfigSsidFlag);
            setDisplay('wpaGTKRekey', isConfigSsidFlag);
            setDisplay('wpsPinNumber', isConfigSsidFlag);
            setDisplay('wpsPBCButton', isConfigSsidFlag);
            setDisplay('wpsPinNumVal', isConfigSsidFlag);
            setDisplay('wpsAPPinNumVal', isConfigSsidFlag);
            setDisplay('wpsConfigurated', isConfigSsidFlag);
        }
    
        if (curUserType != sptUserType) {
            return;
        }
    
        setDisable('wlSsid', !isConfigSsidFlag);
        setDisable('twlWpaPsk', !isConfigSsidFlag);
        setDisable('wlRadiusKey', !isConfigSsidFlag);
        setDisable('twlRadiusKey', !isConfigSsidFlag);
        setDisable('wlKeys1', !isConfigSsidFlag);
        setDisable('twlKeys1', !isConfigSsidFlag);
        setDisable('wlKeys2', !isConfigSsidFlag);
        setDisable('twlKeys2', !isConfigSsidFlag);
        setDisable('wlKeys3', !isConfigSsidFlag);
        setDisable('twlKeys3', !isConfigSsidFlag);
        setDisable('wlKeys4', !isConfigSsidFlag);
        setDisable('twlKeys4', !isConfigSsidFlag);
        setDisable('btnApplySubmit', !isConfigSsidFlag);
        setDisable('cancel', !isConfigSsidFlag);
        if (fitApFt == 1) {
            setDisable('wlRadiusAccountKey', !isConfigSsidFlag);
            setDisable('twlRadiusAccountKey', !isConfigSsidFlag);
        }
    
        SetWlanBasicValueInAis();
    }
    if (((CfgMode.toUpperCase() != 'COCLAROEBG4') || (curUserType != sptUserType)) &&
        ((curUserType != maxisNormalUserType) || (CfgMode.toUpperCase() != 'DETHMAXIS'))) {
        return;
    }


    setDisplay('Newbutton', 0);
    setDisplay('DeleteButton', 0);
    setDisable('wlSsid', 1);
    setDisplay('trSsidEnable', 0);
    setDisplay('tr_sta_num_max_limit', 0);
    setDisplay('trBroadcastSsid', 0);
    setDisplay('wmmSwitchTr', 0);
    setDisplay('wlWapi', 0);
    setDisplay('tbRadiusIPAddr', 0);
    setDisplay('tbRadiusPort', 0);
    setDisplay('wpaGTKRekey', 0);
    setDisplay('wpsPinNumber', 0);
    setDisplay('wpsPBCButton', 0);
    setDisplay('wpsPinNumVal', 0);
    setDisplay('wpsAPPinNumVal', 0);
    setDisplay('wpsConfigurated', 0);
    setDisable('wlKeyBit', 1);
    setDisable('wlKeyIndex', 1);
    setDisable('wlAuthMode', 1);
    setDisable('wlEncryption', 1);

    if (CfgMode.toUpperCase() == 'DETHMAXIS') {
        setDisable('wlSsid', 0);
        setDisplay('trSsidEnable', 1);
        curAuthMode = getSelectVal('wlAuthMode');
        curMethod = getSelectVal('wlEncryption');
    }
}

function SetSsidDisabled() {
    var curWlanInst = 0;
    if (Wlan[ssidIdx] != undefined) {
        curWlanInst = getWlanInstFromDomain(Wlan[ssidIdx].domain);
    }

    var configSsidFlag = 0;

    if (((curWlanInst == 1) || (curWlanInst == 5)) && (aisapBSDInfo.enableSSID1_5 == 1)) {
        configSsidFlag = 1;
    } else if (((curWlanInst == 2) || (curWlanInst == 6)) && (aisapBSDInfo.enableSSID2_6 == 1)) {
        configSsidFlag = 1;
    } else if (((curWlanInst == 3) || (curWlanInst == 7)) && (aisapBSDInfo.enableSSID3_7 == 1)) {
        configSsidFlag = 1;
    } else if (((curWlanInst == 4) || (curWlanInst == 8)) && (aisapBSDInfo.enableSSID4_8 == 1)) {
        configSsidFlag = 1;
    }

    setDisable('wlSsid', configSsidFlag);
    setDisable('wlEnable', configSsidFlag);
}

function SetPSKwarningSug() {
  var pskpasswordwarning = getElementById('pskpasswordwarning');
  pskpasswordwarning.innerHTML = (needChangePwdFlag == 1) ? cfg_wlancfgdetail_language['amp_pwd_default_psk_egvdf_warning'] : cfg_wlancfgdetail_language['amp_pwd_default_psk_warning'];
  pskpasswordwarning.style.color = '#ff0000';
}

function ShowPskWarningDiv(wlanInst) {
    if ((IsPtVdf == 0) && (needChangePwdFlag == 0)) {
        return;
    }

    if ((wlanInst == parseInt(ssidStart2G) + 1) || (wlanInst == parseInt(ssidStart5G) + 1)) {
        setDisplay("pskpasswordwarning", 1);
    } else {
        setDisplay("pskpasswordwarning", 0);
    }
}

function ShowPSKwarningSug(wlanInst) {
    if ((IsPtVdf == 0) && (needChangePwdFlag == 0)) {
        return;
    }

    var authMode = getSelectVal('wlAuthMode');
    if (IsAuthModePsk(authMode)) {
        if (((BaseInstFacKeyChgF2g == 0) && (wlanInst == parseInt(ssidStart2G) + 1)) ||
            ((BaseInstFacKeyChgF5g == 0) && (wlanInst == parseInt(ssidStart5G) + 1))) {
                setDisplay("pskpasswordwarning", 1);
                SetPSKwarningSug();
        } else {
                setDisplay("pskpasswordwarning", 0);
        }
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
            if (CfgMode.toUpperCase() == 'ANTEL2') {
                Form.addParameter('y.BeaconType','WPAand11i');
                Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
                Form.addParameter('y.X_HW_WPAand11iEncryptionModes','TKIPandAESEncryption');
            }
            Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration'
                                       + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');    
        }
        else if ("5G" == wlanpage)
        {
			if (TMCZSTflag == 1) {
				if (webEnable5G != 1 && curUserType != 0) {
					AlertEx(cfg_wlancfgother_language['amp_5g_webenable']);
					return;
				}
			}
              Form.addParameter('y.LowerLayers', node5G);
			if (isSetTriBand() && (1 == SelHighBand))
			{
				Form.addParameter('y.SSIDAlias', 'ath'+ getAddHighBandSSID());
            }
            if (CfgMode.toUpperCase() == 'ANTEL2') {
                Form.addParameter('y.BeaconType','WPAand11i');
                Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
                Form.addParameter('y.X_HW_WPAand11iEncryptionModes','TKIPandAESEncryption');
            }
            Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration'
                                       + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');    
        }
        else
        {}

    } else {
        if (CfgMode.toUpperCase() == 'ANTEL' || 'ANTEL2' == CfgMode.toUpperCase()) {
            Form.addParameter('y.BeaconType','WPAand11i');
                Form.addParameter('y.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
                Form.addParameter('y.X_HW_WPAand11iEncryptionModes','TKIPandAESEncryption');
        }
        Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration' 
                           + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');    
    }

    DisableButtons();
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

	if (wlanpage == "5G") {
		if (TMCZSTflag == 1) {
			if (webEnable5G != 1 && curUserType != 0) {
				AlertEx(cfg_wlancfgother_language['amp_5g_webenable']);
				return;
			}
		}
	}
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
    
    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
    
    if (1 == DoubleFreqFlag)
    {
		if (1 == WiFiUpStatus && 0 == TribandFlag)
		{
			if (false == ConfirmEx(cfg_wificover_basic_language['amp_wificover_modify_wlancfg_sug'])) 
			{
				 return;
			}
		}
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
                                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
							+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}
                 
            }
            else
            {
				Form.addParameter('x.RadioInst', 2);
				
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
							+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}             
            }
        }
        else if ("5G" == wlanpage)
        {
            if ((bondingEnable == 1) && (apNum > 0)) {
                if (enable == 0) {
                    AlertEx(cfg_wlancfgother_language['amp_bonding_sug']);
                }
            }

			if (TMCZSTflag == 1) {
				if (webEnable5G != 1 && curUserType != 0) {
					AlertEx(cfg_wlancfgother_language['amp_5g_webenable']);
					return;
				}
			}
            Form.addParameter('x.Enable', enable);			
			
			if ('InternetGatewayDevice.LANDevice.1.WiFi.Radio.1' == node5G)
            {
                Form.addParameter('x.RadioInst', 1);
				
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
                                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1'
							+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}
            }
            else
            {
                Form.addParameter('x.RadioInst', 2);
				
				Form.addParameter('y.Enable',enable);

				if(0 == HiLinkRoll)
				{
						Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
                                    + '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
				}
				else
				{
					Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2'
							+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
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
						+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
		}
		else
		{
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverEnable&y=InternetGatewayDevice.LANDevice.1'
					+ '&RequestFile=html/amp/wlanbasic/WlanBasic.asp');
		} 
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
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

function SetDivValue(Id, Value)
{
    try
    {
        var Div = document.getElementById(Id);
        Div.innerHTML = Value;
    }
    catch(ex)
    {

    }
}

function SpecShowWlanCommon(currentWlan) {
    var prefixTitle = specialPreTitle;
    var ssidTipsNew = ssidTips.replace("1", prefixTitle.length + 1);
    SetDivValue("ssidLenTips", ssidTipsNew);

    if (AddFlag == true) {
        setText('wlSsid2', currentWlan.ssid);
    } else {
        var ssidParts = currentWlan.ssid.split('_');
        if ((ssidParts.length >= 2) && (ssidParts[0] == prefixTitle)) {
            var strSSID1 = ssidParts[0] + "_";
            var strSSID2 = currentWlan.ssid.substr(strSSID1.length, currentWlan.ssid.length);
            setText('wlSsid2', strSSID2);
        } else {
            setText('wlSsid2', currentWlan.ssid);
        }
    }
}

function SpecShowWlan(currentWlan)
{
    var ssidInst = getInstIdByDomain(currentWlan.domain);

    if (ssidInst == 5)
    {
        prefix = 'PLDTHOMEFIBR5G';
    }
    
    var ssidTipsNew = ssidTips;
    if ((true == AddFlag)|| ((ssidInst != 1) && (ssidInst != 5)))
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
            if(ssidParts[0] == prefix)
            {
                var strSSID1 = ssidParts[0] + "_";
                var strSSID2 = currentWlan.ssid.substr(strSSID1.length,currentWlan.ssid.length);
                var ssidTipsLen = prefix.length + 1;
                setText('wlSsid1',strSSID1);
                setDisable('wlSsid1',1);
                setText('wlSsid2',strSSID2);
                setDisplay('wlSsid2',1);
                SetStyleValue("wlSsid1", "width:100px;border:0");
                if (ssidInst == 5)
                {
                	SetStyleValue("wlSsid1", "width:115px;border:0");
                }
                ssidTipsNew = ssidTips.replace("1", ssidTipsLen);
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
    SetDivValue("ssidLenTips", ssidTipsNew);
}

function showWlan(currentWlan)
{
    with (document.forms[0])
    {
        ShowSsidEnable(currentWlan);
        setCheck('wlHide', currentWlan.wlHide);
        setText('X_HW_AssociateNum',currentWlan.DeviceNum);
        setCheck('enableWmm', currentWlan.wmmEnable)
        if ((CfgMode.toUpperCase() == 'DTURKCELL2WIFI') || (turkcellFlag == 1)) {
            setCheck('enable11r', current11R.FBT_11rEnable);
        }

        if ((staIsolationFlag == 1) && (currentWlan.domain != '') && (currentWlan.domain != undefined)) {
            setDisplay('tr_sta_isolation', 1);
            if (CfgMode.toUpperCase() == 'ROSUNION') {
                setCheck('sta_isolation', rosIsolationEnable[ssidIdx].X_HW_IsolationEnable);
            } else {
                setCheck('sta_isolation', currentWlan.IsolationEnable);
            }
        }
		
		if(t2Flag == 1)
		{
			if((getWlanInstFromDomain(currentWlan.domain) == 3) && ("1" == XHWAdvanceCfg.value))
			{
				setDisplay('tr_sta_num_max_limit', 1);
			}
			else
			{
				setDisplay('tr_sta_num_max_limit', 0);
			}
		}

        if (1 == preflag)
        {
            SpecShowWlan(currentWlan);
            if (ssidAccessAttr.indexOf('Subscriber') < 0)
            {
                setDisable('wlSsid1',1);
                setDisable('wlSsid2',1);
            }
        } else if (specialPreflag == 1) {
            SpecShowWlanCommon(currentWlan);
        } else {
            setText('wlSsid',currentWlan.ssid);
            if (ssidAccessAttr.indexOf('Subscriber') < 0)
            {
                setDisable('wlSsid',1);
            }
        }

        beaconTypeChange(currentWlan.BeaconType);
        WPSAndHideCheck();
        if ('1' == WPS20AuthSupported)
        {
            setCheck('U-APSD', currentWlan.UAPSDEnable);
            setDisplay('wpsConfigurated', 1);
            setDisplay('divUAPSD', 1);
            if (currentWlan.X_HW_WPSConfigurated == 1)
            {
                setText('wpsconfig', "Not Configured")
            }
            else
            {
                setText('wpsconfig', "Configured")
            }
        }
        else
        {
            setDisplay('wpsConfigurated', 0);
            setDisplay('divUAPSD', 0);
        }
        setBasicSug();
        if (AddFlag == false) {
            ShowPSKwarningSug(getWlanInstFromDomain(currentWlan.domain));
        }

        if (ttnet2Flag == 1) {
            ModifyAuthAndEncryMode();
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

	for (var i = 0; i < WlanMap.length; i++)
	{
		if (WlanMap[i].index == WlanMap_index)
		{
			WlanMap_index_portIndex = parseInt(WlanMap[i].portIndex);
			break;
		}
	}

    for (var i = 0; i < WlanMap.length; i++)
    {
        if (WlanMap[i].index == Wlan_index)
        {
            Wlan_index_portIndex = parseInt(WlanMap[i].portIndex);
            break;
        }
    }

    if (   ((WlanMap_index_portIndex < ssidStart5G) && (Wlan_index_portIndex < ssidStart5G)) 
        || ((WlanMap_index_portIndex > ssidEnd2G) && (Wlan_index_portIndex > ssidEnd2G)) )
    {
        return true;
    }
    else
    {
        return false;
    }
}


function addWPSModeOption(wlaninstId)
{
    var len = document.forms[0].wlWPSMode.options.length;
    var existPushBut = 0;

    for (i = 0; i < len; i++)
    {
        document.forms[0].wlWPSMode.remove(0);
    }
    
    for (i = 0; i < Wlan.length; i++)
    {        
        if (IsInSameRadio(wlaninstId, i) && (wpsPinNum[i].X_HW_ConfigMethod == 'PushButton') && (true == wpsPinNum[i].Enable) && 
            ((((Wlan[i].BeaconType == 'WPA2') || (Wlan[i].BeaconType == '11i')) && (Wlan[i].IEEE11iAuthenticationMode == 'PSKAuthentication')) || 
            ((Wlan[i].BeaconType == 'WPA') && (Wlan[i].WPAAuthenticationMode == 'PSKAuthentication')) || 
            (((Wlan[i].BeaconType == 'WPAand11i') || (Wlan[i].BeaconType == 'WPA/WPA2')) && (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'PSKAuthentication')) || 
            ((Wlan[i].BeaconType == 'WPA3') && ((Wlan[i].X_HW_WPAand11iAuthenticationMode == 'SAEAuthentication') || (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'SAEAuthentication'))) || 
            ((Wlan[i].BeaconType == 'WPA2/WPA3') && ((Wlan[i].X_HW_WPAand11iAuthenticationMode == 'PSKandSAEAuthentication') || (Wlan[i].X_HW_WPAand11iAuthenticationMode == 'PSKandSAEAuthentication'))))) {
            existPushBut = 1;
            break;
        }
    }
	
    if ((t2Flag == 1) || (DslTalkTalkFlag == 1) || (IsOnlyPbc())) {
        document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pbc'], "PBC");
        return;
    }

    if (CfgMode.toUpperCase() == 'DTURKCELL2WIFI') {
        document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pbc'], "PBC");
        document.forms[0].wlWPSMode[1] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "PIN");
        return;
    }

    if (scnFT == 1) {
        if (scnVar == 1) {
            document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pbc'], "PBC");
            return;
        }
    }

    if ((0 == existPushBut) || ((1 == existPushBut) && (wlaninstId == i)))
    {
        document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pbc'], "PBC");
        if ('1' != WPS20AuthSupported)
        {
            document.forms[0].wlWPSMode[1] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "PIN");
            document.forms[0].wlWPSMode[2] = new Option(cfg_wlancfgother_language['amp_wpsmode_appin'], "AP-PIN");
        }
        else if ('1' == WPS20AuthSupported)
        {
            document.forms[0].wlWPSMode[1] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "AP-PIN");
        }
    }
    else
    {
        if ('1' != WPS20AuthSupported)
        {
            document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "PIN");
            document.forms[0].wlWPSMode[1] = new Option(cfg_wlancfgother_language['amp_wpsmode_appin'], "AP-PIN");
        }
        else if ('1' == WPS20AuthSupported)
        {
            document.forms[0].wlWPSMode[0] = new Option(cfg_wlancfgother_language['amp_wpsmode_pin'], "AP-PIN");
        }
    }
	
	if (noApPinFlag == 1) {
		removeOption('wlWPSMode', 'AP-PIN');
	}
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		var temp = objTR.id.split('_')[1];
		if ((temp == 'null') || (id == 'Wireless_record_null'))
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
	
	if ((DoubleFreqFlag == 1) && (wlanpage == "5G") && (uiTotal5gNum > 0) && (OIFlag == 1)) {
        if (id == ('record_' + RecordFor5G)) {
            setDisable('twlWpaPsk',1);
            setDisable('wlWpaPsk',1);
            setDisable('twlRadiusKey',1);
            setDisable('wlRadiusKey',1);
            setDisable("wlKeys1", 1);
            setDisable("twlKeys1", 1); 
            setDisable("wlKeys2", 1);
            setDisable("twlKeys2", 1);
            setDisable("wlKeys3", 1);
            setDisable("twlKeys3", 1);
            setDisable("wlKeys4", 1);
            setDisable("twlKeys4", 1);
            if (fitApFt == 1) {
                setDisable('twlRadiusAccountKey',1);
                setDisable('wlRadiusAccountKey',1);
            }
        } else {
            setDisable('twlWpaPsk',0);
            setDisable('wlWpaPsk',0);
            setDisable('twlRadiusKey',0);
            setDisable('wlRadiusKey',0);
            setDisable("wlKeys1", 0);
            setDisable("twlKeys1", 0); 
            setDisable("wlKeys2", 0);
            setDisable("twlKeys2", 0);
            setDisable("wlKeys3", 0);
            setDisable("twlKeys3", 0);
            setDisable("wlKeys4", 0);
            setDisable("twlKeys4", 0);
            if (fitApFt == 1) {
                setDisable('twlRadiusAccountKey',0);
                setDisable('wlRadiusAccountKey',0);
            }
        }
    }
    SetDomDisabled();
    if (isFitAp == 1) {
        FitApDisable();
    }

    if ((CfgMode.toUpperCase() == 'AISAP') && (meshMode != 3)) {
        SetSsidDisabled();
    }
}

function loadssid(tableRow, maxssidband)
{
    setDisplay('cfg_table', 0);
    if (tableRow.rows.length > 2)
    {
        tableRow.deleteRow(tableRow.rows.length-1);
    }

    if (enbale && (aisApBackhaul == 1)) {
        AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
        enbale = false;
    } else {
        AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
    }

    LoadFrame();
}

function SetBSDDomDisable(isDisable) {
    setDisable('wlSsid', isDisable);
    setDisable('wlAuthMode', isDisable);
    setDisable('wlEncryption', isDisable);
    setDisable('wlWpaPsk', isDisable);
    setDisable('twlWpaPsk', isDisable);
}

function SetDomDisableForBSD(wlanInst) {
    if (IsShowBSD() && (XHWGlobalConfig.BandSteeringPolicy == 1) && wlanpage == "5G") {
        if (wlanInst == 5) {
            SetBSDDomDisable(1);
        } else {
            SetBSDDomDisable(0);
        }
    }
}

function setControl(idIndex)
{
    var tableRow = getElement("wlanInst");
	var wlanInst = 0;

    if ((aisApBackhaul == 1) && ((tableRow.rows.length > 5) || ((backupenable == 1) && (tableRow.rows.length > 4)))) {
        if (idIndex == -1) {
            enbale = true;
        }
        loadssid(tableRow, tableRow.rows.length);
        return;
    }

	if ((1 == gzcmccFlag) && (curUserType == sptUserType))
	{
		setDisable("btnApplySubmit", 1);
	}
	else
	{
		setDisable("btnApplySubmit", 0);
	}
    
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
            Total2gNum();

            if ("2G" == wlanpage)
            {
                if (SsidNum2g >= SsidPerBand)
                {
                    loadssid(tableRow, SsidPerBand);
                    return;
                }
            }
 
            else if("5G" == wlanpage)
            {
                if ((1 != TriBandHighBandEnable) || ((1 == TriBandHighBandEnable) && (0 == SelHighBand)))
                {
					if (SsidNum5g >= SsidPerBand)
					{
						loadssid(tableRow, SsidPerBand);
						return;
					}
				}
				else if ((1 == TriBandHighBandEnable) && (1 == SelHighBand))
				{
					if (TriHighBandNum >= SsidPerBand)
					{
						loadssid(tableRow, SsidPerBand);
						return;
					}
				}
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
        } else {
            currentWlan.DeviceNum = 32;
        }
		
		if (ttnet2Flag == 1) {
			currentWlan.DeviceNum = 32;
		}

        if (viettelPrefixFlag == 1) {
            currentWlan.ssid = 'VIETTEL_' + GetRandomNum(4);
        }

        setDisplay('ssidDetail', 1);
        setDisplay('securityCfg',0);
        setDisplay('div11r',0);
        setDisplay('tr_sta_isolation', 0);
    }
    else
    {
        setDisplay('cfg_table', 1);
        setDisplay('securityCfg',1);
        if ((CfgMode.toUpperCase() == 'DTURKCELL2WIFI') || (turkcellFlag == 1)) {
            setDisplay('div11r',1);
        }
        ssidIdx = parseInt(WlanMap[idIndex].index);
        AddFlag = false;
        
        currentWlan = Wlan[ssidIdx];
        current11R = enable11r[ssidIdx];
        wlanInst = getWlanInstFromDomain(currentWlan.domain);
        GuestSsidstate(wlanInst);
        guiCoverSsidNotifyFlag = 0;

        addWPSModeOption(ssidIdx);    
           
        if (1 == TelMexFlag)
        {
            keyIndexChange(currentWlan.KeyIndex);
        }
    }
	
	if(t2Flag ==1) 
	{
		if (-1 != idIndex)
		{
			 ssidIdx = parseInt(WlanMap[idIndex].index);
			 wlanInst = getWlanInstFromDomain(Wlan[ssidIdx].domain);
			if(IsGuestSsid(wlanInst))
			{
				var auth = getSelectVal('wlAuthMode');

				var authModes = { 'open' : [cfg_wlancfgdetail_language['amp_auth_open'], 1], 
								  'wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1], 
								  'wpa/wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpawpa2psk'], 1]
								};
								
				if(wlanpage == "5G")
				{
					authModes = { 'open' : [cfg_wlancfgdetail_language['amp_auth_open'], 1], 
								  'wpa2-psk' : [cfg_wlancfgdetail_language['amp_auth_wpa2psk'], 1]
								};
				}
								
				InitDropDownListWithSelected('wlAuthMode', authModes, auth);
			}
		}
		else
		{
			addAuthModeOption();
		}
	}

    if (IsAuthModeWithoutOpen()) {
        ModifyOpenAuthMode();
    }

    if (ttnet2Flag == 1) {
        ModifyAuthAndEncryMode();
    }

    showWlan(currentWlan);
	if (AddFlag == false)
	{
		InitWepOriginLen();
	}
	if(1 == fonEnable && (FonSSID2GInst == wlanInst || FonSSID5GInst == wlanInst))
	{
		setDisplay("fonDetailCover", 1);
		setDisable('DeleteButton', 1);
	}
	else
	{
		setDisplay("fonDetailCover", 0);
		if ((1 == gzcmccFlag) && (curUserType == sptUserType))
		{
			setDisable('DeleteButton', 1);
		}
		else
		{
			setDisable('DeleteButton', 0);
		}
		
	}
	
	if ((1 == isSsidForIsp(wlanInst)) && (1 == ShowISPSsidFlag) && (1 == jscmccFlag))
	{
		setDisable('btnApplySubmit', 1);
		setDisable('cancel', 1);
		return;
	}
    else
    {
		if ((1 == gzcmccFlag) && (curUserType == sptUserType))
		{
			setDisable("btnApplySubmit", 1);
		}
		else
		{
			setDisable("btnApplySubmit", 0);
		}
		setDisable('cancel', 0);
    }
    
    if ((1 == gzcmccFlag) && (curUserType == sptUserType))
    {
        setDisable('btnApplySubmit', 1);
        setDisable('cancel', 1);
        return;
    }

    if (1 == IspSSIDVisibility)
    {
        var wlanInst = getWlanInstFromDomain(currentWlan.domain);
        g_currentwlanInst = wlanInst;

        if (jQ_IspEnabledItem != null)
        {
            $(jQ_IspDisabledItem).each(function ()
            {
                setDisable(""+this.id, 1);
            }) 

            $(jQ_IspEnabledItem).each(function ()
            {
                setDisable(""+this.id, 0);
            }) 

            if (1 == isSsidForIsp(wlanInst))
            {
                $(jQ_IspEnabledItem).each(function ()
                {
                    setDisable(""+this.id, 1);
                })    
            }
        }
    }

    SetDomDisableForBSD(wlanInst);
    createQRCode();

    if ((CfgMode.toUpperCase() == 'PLDT2') && (idIndex != -1)) {
        var disable = 0;
        if ((IsWlanSameSsid()) &&
            ((wlanInst == 1) || (wlanInst == 5))) {
            disable = 1;
        }

        setDisable('wlSsid1', disable);
        setDisable('wlAuthMode', disable);
        setDisable('wlEncryption', disable);
        setDisable('wlWpaPsk', disable);
        setDisable('twlWpaPsk', disable);
        setDisable('wlKeyBit', disable);
        setDisable('wlKeyIndex', disable);
        setDisable('wlKeys1', disable);
        setDisable('wlKeys2', disable);
        setDisable('wlKeys3', disable);
        setDisable('wlKeys4', disable);
        setDisable('hidewlKeys', disable);
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
	DisableButtons();	
	
	if (del_array == '')
	{
		return;
	}
	
	del_array = del_array.substring(0, del_array.length-1);

    var guestUrl = "";
    var guestSSid = "";
    if (wlanpage == "2G") {
        if (getCheckVal('GuestSsidEnable') == 1) {
            guestSSid = "&z.SSID_IDX=0";
            guestUrl += '&z=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1';
        }
    }

    if (wlanpage == "5G") {
        if (getCheckVal('GuestSsidEnable') == 1) {
            guestSSid = "&z.SSID_IDX=0";
            guestUrl += '&z=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.2';
        } 
    }
	
	$.ajax({
		 type : "POST",
		 async : true,
		 cache : false,
		 data : 'y.DeleteInstArray='+del_array+guestSSid+'&x.X_HW_Token='+getValue('onttoken'),
		 url : 'set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.ParallelDelSsid'+guestUrl+'&RequestFile=html/amp/wlanbasic/WlanBasic.asp',
		 success : function(data) {
            Form.setAction('del.cgi?RequestFile=html/amp/wlanbasic/WlanBasic.asp');
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
       document.getElementById("DeleteButton").disabled = false;
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
    {   
        document.getElementById("DeleteButton").disabled = false;
        return;
    }

	delAjaxRequest();
}

function TDEGetSSIDStringContent(str, Length)
{		
    if(null != str)
    {
	str = str.toString().replace(/&amp;/g,"&");
    	str = str.toString().replace(/&nbsp;/g," ");
    	str = str.toString().replace(/&quot;/g,"\"");
    	str = str.toString().replace(/&gt;/g,">");
    	str = str.toString().replace(/&lt;/g,"<");
    	str = str.toString().replace(/&#39;/g, "\'");
    	str = str.toString().replace(/&#40;/g, "\(");
    	str = str.toString().replace(/&#41;/g, "\)");
			
		str = str.toString().replace(/&Aacute;/g,"Á");
        str = str.toString().replace(/&aacute;/g,"á");
		
        str = str.toString().replace(/&Agrave;/g,"À");
        str = str.toString().replace(/&agrave;/g,"à");	

        str = str.toString().replace(/&Eacute;/g,"É");
        str = str.toString().replace(/&eacute;/g,"é");	
				
        str = str.toString().replace(/&Iacute;/g,"Í");
        str = str.toString().replace(/&iacute;/g,"í");	
		
        str = str.toString().replace(/&Oacute;/g,"Ó");
        str = str.toString().replace(/&oacute;/g,"ó");		

		str = str.toString().replace(/&Uacute;/g,"Ú");
        str = str.toString().replace(/&uacute;/g,"ú");

		str = str.toString().replace(/&Acirc;/g,"Â");
        str = str.toString().replace(/&acirc;/g,"â");	
		
		str = str.toString().replace(/&Ecirc;/g,"Ê");
        str = str.toString().replace(/&ecirc;/g,"ê");	

		str = str.toString().replace(/&Icirc;/g,"Î");
        str = str.toString().replace(/&icirc;/g,"î");	

        str = str.toString().replace(/&ouml;/g,"ö");	

		str = str.toString().replace(/&Ucirc;/g,"Û");
        str = str.toString().replace(/&ucirc;/g,"û");			

		str = str.toString().replace(/&Uuml;/g,"Ü");
        str = str.toString().replace(/&uuml;/g,"ü");
		
		str = str.toString().replace(/&Ccedil;/g,"Ç");
        str = str.toString().replace(/&ccedil;/g,"ç");	

		str = str.toString().replace(/&Atilde;/g,"Ã");
        str = str.toString().replace(/&atilde;/g,"ã");	
		
		str = str.toString().replace(/&Otilde;/g,"Õ");
        str = str.toString().replace(/&otilde;/g,"õ");			

        str = str.toString().replace(/&Ntilde;/g,"Ñ");	    
        str = str.toString().replace(/&ntilde;/g,"ñ");	

        str = str.toString().replace(/&euro;/g, "€");

		str = str.toString().replace(/&Ograve;/g,"Ò");
        str = str.toString().replace(/&ograve;/g,"ò");	

		str = str.toString().replace(/&Ugrave;/g,"Ù");
        str = str.toString().replace(/&ugrave;/g,"ù");			

		str = str.toString().replace(/&Egrave;/g,"È");
        str = str.toString().replace(/&eacute;/g,"è");

		str = str.toString().replace(/&Igrave;/g,"Ì");
        str = str.toString().replace(/&iacute;/g,"ì");
		
		str = str.toString().replace(/&Iuml;/g,"Ï");
        str = str.toString().replace(/&iuml;/g,"ï");
		
		str = str.toString().replace(/&ordf;/g,"ª");
        str = str.toString().replace(/&ordm;/g,"º");	
		
        str = str.toString().replace(/&iquest;/g,"¿");	

    }

	if (str.length > Length)
    {
        str=str.substr(0, Length) + "......";
    }

	if(null != str)
    {
	str = str.toString().replace(/&amp;/g,"&");
       str = str.toString().replace(/ /g,"&nbsp;");
    	str = str.toString().replace(/\"/g,"&quot;");
    	str = str.toString().replace(/>/g,"&gt;");
    	str = str.toString().replace(/</g,"&lt;");
    	str = str.toString().replace(/\'/g, "&#39;");
    	str = str.toString().replace(/\(/g, "&#40;");
    	str = str.toString().replace(/\)/g, "&#41;");
		
		str = str.toString().replace(/Á/g,"&Aacute;");
        str = str.toString().replace(/á/g,"&aacute;");
		
        str = str.toString().replace(/À/g,"&Agrave;");
        str = str.toString().replace(/à/g,"&agrave;");	

        str = str.toString().replace(/É/g,"&Eacute;");
        str = str.toString().replace(/é/g,"&eacute;");	
				
        str = str.toString().replace(/Í/g,"&Iacute;");
        str = str.toString().replace(/í/g,"&iacute;");	
		
        str = str.toString().replace(/Ó/g,"&Oacute;");
        str = str.toString().replace(/ó/g,"&oacute;");		

		str = str.toString().replace(/Ú/g,"&Uacute;");
        str = str.toString().replace(/ú/g,"&uacute;");

		str = str.toString().replace(/Â/g,"&Acirc;");
        str = str.toString().replace(/â/g,"&acirc;");	
		
		str = str.toString().replace(/Ê/g,"&Ecirc;");
        str = str.toString().replace(/ê/g,"&ecirc;");	

		str = str.toString().replace(/Î/g,"&Icirc;");
        str = str.toString().replace(/î/g,"&icirc;");	

        str = str.toString().replace(/ö/g,"&ouml;");	

		str = str.toString().replace(/Û/g,"&Ucirc;");
        str = str.toString().replace(/û/g,"&ucirc;");			

		str = str.toString().replace(/Ü/g,"&Uuml;");
        str = str.toString().replace(/ü/g,"&uuml;");
		
		str = str.toString().replace(/Ç/g,"&Ccedil;");
        str = str.toString().replace(/ç/g,"&ccedil;");	

		str = str.toString().replace(/Ã/g,"&Atilde;");
        str = str.toString().replace(/ã/g,"&atilde;");	
		
		str = str.toString().replace(/Õ/g,"&Otilde;");
        str = str.toString().replace(/õ/g,"&otilde;");			

        str = str.toString().replace(/Ñ/g,"&Ntilde;");	    
        str = str.toString().replace(/ñ/g,"&ntilde;");	

        str = str.toString().replace(/€/g, "&euro;");

		str = str.toString().replace(/Ò/g,"&Ograve;");
        str = str.toString().replace(/ò/g,"&ograve;");	

		str = str.toString().replace(/Ù/g,"&Ugrave;");
        str = str.toString().replace(/ù/g,"&ugrave;");			

		str = str.toString().replace(/È/g,"&Egrave;");
        str = str.toString().replace(/è/g,"&eacute;");

		str = str.toString().replace(/Ì/g,"&Igrave;");
        str = str.toString().replace(/ì/g,"&iacute;");
		
		str = str.toString().replace(/Ï/g,"&Iuml;");
        str = str.toString().replace(/ï/g,"&iuml;");
		
		str = str.toString().replace(/ª/g,"&ordf;");
        str = str.toString().replace(/º/g,"&ordm;");	
		
        str = str.toString().replace(/¿/g,"&iquest;");	
			
    }

    return str;
}


function cancelValue()
{
    if (firstLine === -1) {
        return;
    }
    var temp1 =0;
    var temp2 =0;
	
	$("#checkinfo1Row").css("display", "none");
	$("#checkinfo2Row").css("display", "none");
	$("#checkinfo3Row").css("display", "none");
	$("#checkinfo4Row").css("display", "none");
	$("#checkinfo5Row").css("display", "none");

    if (AddFlag == true)
    {
        var tableRow = getElement("wlanInst");
        if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
        {
            FirstRecordFor5G();
            selectLine('record_' + firstLine);
            
            for(var i = 0; i < WlanMap.length; i++)
            {
                if(WlanMap[i].portIndex >3)
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
            selectLine('record_' + firstLine);
            
            for(var j = 0; j < WlanMap.length; j++)
            {
                if(WlanMap[j].portIndex < 4)
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
            
            if (0 == WlanMap.length)
			{
				setDisplay('ssidDetail',0);
			}
        }
        
        tableRow.deleteRow(tableRow.rows.length-1);
    }
    else
    {
        var currentWlan = Wlan[ssidIdx];
        showWlan(currentWlan);
        clearGusetSsid(currentWlan);
    } 
	
	ClearPsdModFlag();
	
	
}


var hide = cfg_wlancfgdetail_language['amp_bcastssid_help'];
var wmm = cfg_wlancfgdetail_language['amp_vmm_help'];
var authmode = cfg_wlancfgdetail_language['amp_authmode_help'];
var encryption = cfg_wlancfgdetail_language['amp_encrypt_help'];
var ssid = cfg_wlancfgdetail_language['amp_ssid_help'];
var deviceNumber = cfg_wlancfgdetail_language['amp_devnum_help'];
var posswordComplexTitle = cfg_wlancfgdetail_language['amp_wlanpasswordcomplex_title'];


function wlanWriteTabTail()
{
    document.write("<\/td><\/tr><\/table>");
}

function setTDEPskMaxLen()
{
    var wlWpapsk = document.getElementById("wlWpaPsk");
    wlWpapsk.maxLength = 63;
    var wlWpapskTxt = document.getElementById("twlWpaPsk");
    wlWpapskTxt.maxLength = 63;
}

var isGuset2G;
var isGuset5G;

function getChannels(domain, ChannelsInUse) {
    this.domain = domain;
    this.ChannelsInUse = ChannelsInUse;
}

var Channels = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, ChannelsInUse, getChannels);%>;

function checkIsExistGuestSsid()
{
    isGuset2G = false;
    isGuset5G = false;

    for (var i = 1; i < 9; i++) {
        if (IsGuestSsid(i)) {
            var curentChennels= Channels[i - 1].ChannelsInUse;
            if (curentChennels < 15) {
                isGuset2G = true;
            } else {
                isGuset5G = true;
            }
        }
    }
}

function setWpsStatus(enable)
{
    setDisable("wlWPSEnable", enable);
    setDisable("wlWPSMode", enable);
    setDisable("wlClientPinNum", enable);
    setDisable("wlSelfPinNum", enable);
    setDisable("RegeneratePIN", enable);
    setDisable("btnWpsPBC", enable);
}

function GuestSsidstate(index)
{
    SontOrSYN();

    if (!isSontOrSYN) {
        setDisplay("wlanGuest", 0);
        setDisplay("GuestSsidSEnable", 0);
        return;
    }

    if ((index == 1) || (index == 5)) {
        setDisplay("wlanGuest", 0);
        setDisplay("GuestSsidSEnable", 0);
        setWpsStatus(0);
        return;
    }

    checkIsExistGuestSsid();

    if (wlanpage == "2G") {
        if (isGuset2G) {
            if (IsGuestSsid(index)) {
                setDisplay("wlanGuest", 1);
                setDisplay("GuestSsidSEnable", 1);
                setCheck("GuestSsidEnable", 1);
                setWpsStatus(1);
            } else {
                setDisplay("wlanGuest", 0);
                setDisplay("GuestSsidSEnable", 0);
                setWpsStatus(0);
            }
        } else {
            setDisplay("wlanGuest", 1);
            setDisplay("GuestSsidSEnable", 1);
            setCheck("GuestSsidEnable", 0);
        }
    }

    if (wlanpage == "5G") {
        if (isGuset5G) {
            if (IsGuestSsid(index)) {
                setDisplay("wlanGuest", 1);
                setDisplay("GuestSsidSEnable", 1);
                setCheck("GuestSsidEnable", 1);
                setWpsStatus(1);
            } else {
                setDisplay("wlanGuest", 0);
                setDisplay("GuestSsidSEnable", 0);
                setWpsStatus(0);
            }
        } else {
            setDisplay("wlanGuest", 1);
            setDisplay("GuestSsidSEnable", 1);
            setCheck("GuestSsidEnable", 0);
        }
    }

}

function clearGusetSsid(currentWlan)
{
    if (!isSontOrSYN) {
        return;
    }

    var indexArray = currentWlan.domain.split('.')
    var len = indexArray.length;
    var index = indexArray[indexArray.length -1];

    if (IsGuestSsid(index)) {
        setCheck("GuestSsidEnable", 1);
    } else {
        setCheck("GuestSsidEnable", 0);
    }
}

function addBackSlash(str)
{
    var strNeedSlash = "\\'\".:,;";
    var strNew = "";
    for (var i=0; i< str.length; i++)
    {
        var c = str.charAt(i);
        for(var j=0; j< strNeedSlash.length; j++)
        {
            if(c == strNeedSlash.charAt(j))
            {
                strNew += "\\";
                break;
            }
        }
        strNew += c;
    }
    
    return strNew;
}

var beaconType;
var qrcode;

function beaconTypeStr() 
{
    if (Wlan[ssidIdx].BeaconType == "Basic" && Wlan[ssidIdx].BasicAuthenticationMode == "SharedAuthentication")
    {
        beaconType = "Shared";
    } else {
        beaconType = Wlan[ssidIdx].BeaconType;
    }
}

function createQRCode()
{
   if ((CfgModeWord != 'SYNCSGP210W')) {
        setDisplay("QRCode", 0);
        setDisplay("QRdesc", 0);
        return;
   }

     if (wlanpage == "2G" && !getCheckVal('wlEnbl')) {
        return;
    }

    if (wlanpage == "5G" && !getCheckVal('wlEnbl')) {
        return;
    }

    if (getValue('wlSsid')== '') {
        return;
    }

    if (curLanguage.toUpperCase() == 'JAPANESE') {
        document.getElementById('QRdesc').style.marginLeft = "262px";
    }

    if (curLanguage.toUpperCase() == 'ENGLISH') {
        document.getElementById('QRdesc').style.marginLeft = "225px";
    }

    var qrTxt = "WIFI:";
    var psk = "nopass";
    var ssid = addBackSlash(Wlan[ssidIdx].ssid);

    beaconTypeStr();

    if (beaconType == "Basic") {
        if (Wlan[ssidIdx].BasicEncryptionModes == "WEPEncryption") {
            qrTxt += "T:WEP";
            psk = addBackSlash(g_keys[ssidIdx].value);
        } else {
            qrTxt += "T:nopass";
        }
    } else if(beaconType == "Shared") {
        qrTxt += "T:WEP";
        psk = addBackSlash(g_keys[ssidIdx].value);
    } else {
        qrTxt += "T:WPA";
        psk = addBackSlash(wpaPskKey[ssidIdx].value);
    }

    qrTxt += ";S:" + ssid + ";P:" + psk + ";";
    qrTxt += "H:true;";

    if (qrcode) {
        qrcode.clear();
        document.getElementById("QRCode").innerHTML = "";
    }

    qrcode = new wabQR(document.getElementById("QRCode"), {
        width : 130,
        height : 130
    });

    qrcode.makeCode(qrTxt);

    $("#QRCode").attr("title", "");
}

var isSontOrSYN = false;

function SontOrSYN()
{
    if ((CfgModeWord == 'SYNCSGP210W') || (CfgModeWord == 'SONETSGP210W')) {
        isSontOrSYN = true;
    } else {
        isSontOrSYN = false;
    }
}

</script>
</head>


<body class="mainbody wlanmenu" onLoad="LoadFrame();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
if (!(1 == PTVDFFlag && 1 == DoubleFreqFlag))
{
	var wlanbasic_note = ""; 
var wlanbasic_header = ""; 
if((1 == DoubleFreqFlag) && ("2G" == wlanpage))
{
	wlanbasic_note = cfg_wlancfgother_language['amp_wlanbasic_title_2G'];
	wlanbasic_header = cfg_wlancfgbasic_language['amp_wlan_basic_header_2G'];
}
else if((1 == DoubleFreqFlag) && ("5G" == wlanpage))
{
	wlanbasic_note = cfg_wlancfgother_language['amp_wlanbasic_title_5G'];
	wlanbasic_header = cfg_wlancfgbasic_language['amp_wlan_basic_header_5G'];
}
else
{
	wlanbasic_note = cfg_wlancfgother_language['amp_wlanbasic_title'];
	wlanbasic_header = cfg_wlancfgbasic_language['amp_wlan_basic_header'];
}

if (1 == PccwFlag)
{
	wlanbasic_note = cfg_wlancfgother_language['amp_wlanbasic_title_pccw'];
}

var WlanBasicSummaryArray = new Array(new stSummaryInfo("text",wlanbasic_note),
                                    new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note1")),
                                    new stSummaryInfo("text","1. " + GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note") + "<br>"),
									new stSummaryInfo("text","2. " + GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note2")),
                                    null);
    if ((cap11ax == 1) && (isShowWpa3Eap == 1)) {
        WlanBasicSummaryArray[3] = new stSummaryInfo("text","2. " + GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note4"));
    }
    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        WlanBasicSummaryArray = new Array(new stSummaryInfo("text",wlanbasic_note),
                                    new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_notechmk")),
                                    new stSummaryInfo("text","<span style='color:red;'>If you are interested in our Wi-Fi service, please visit " + serviceUrl + " for more details.</span>"),
                                    null);
    }
    HWCreatePageHeadInfo("wlanbasicSummary", wlanbasic_header, WlanBasicSummaryArray, true);
}
</script>

<div class="title_spread"></div>

<form id="ConfigForm" action="../network/set.cgi" style="display:none">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr ><td>
  
    <div id='wlanBasicCfg'>
    <div id='wlanswitch'>
    <table cellspacing="0" cellpadding="0" width="100%" id="wlanOnOff">
      <tr>
        <td class="func_title"><input type='checkbox' name='wlEnbl' id='wlEnbl' onClick='EnableSubmit();' value="ON">
          <script>document.write(cfg_wlancfgother_language['amp_wlan_enable']);  </script></input></td>
      </tr>
    </table>

      </div>
	<div id='TriBandswitch' style='display:none'>
    <table cellspacing="0" cellpadding="0" width="100%">
      <tr>
        <td class="func_title"><input type='checkbox' id='triBandEnbl' onClick='EnableTriBand()' value="ON">
          <script>document.write(cfg_wlancfgother_language['amp_wlanbasic_triband_enbl']);  </script></input></td>
      </tr>
    </table>
    </div>
	
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_space2">
      <tr ><td class="width_10px"></td></tr>
    </table>

    <div id="TriBandMenuDiv" class="Menubox" style="display:none">
	<ul>
		<li id="menu1" onClick="setTab('menu',1)" class="hover"><script>document.write(cfg_wlancfgother_language['amp_wlanbasic_lowband_5G']);</script></li>
            <li id="menu2" onClick="setTab('menu',2)"><script>document.write(cfg_wlancfgother_language['amp_wlanbasic_highband_5G']);</script></li>
        </ul>
    </div>
	
	<div id='wlanCfg'>
	
	<div class="button_spread"></div>

    <script language="JavaScript" type="text/javascript">
     if(1 != PccwFlag)
    {
        writeTabCfgHeader('Wireless',"100%");
    }

    </script>
		
	<div id="DivSSIDList_Table_Container" style="overflow:auto;overflow-y:hidden;">
	
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInst">
      <tr class="head_title">
        <td>&nbsp;</td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_id']);</script></div></td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_name']);</script></div></td>
        <td ><div class="align_center"><script>document.write(cfg_wlancfgbasic_language['amp_ssid_link']);</script></div></td>
        
        <script>
        
        if ((0 == ForbidAssocFlag) && (t2Flag == 0))
        {
            document.write('<td ><div class="align_center">');
            if (true != telmexSpan)
            {
                document.write(cfg_wlancfgbasic_language['amp_link_devnum']);
            }
            else
            {
                document.write(cfg_wlancfgbasic_language['amp_link_devnum_telmex']);
            }
            document.write('</div></td>');
        }
        
        </script>
        
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
        var iotSsidInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.SyncIotSsidInst);%>';
        for (var i = 0;i < WlanMap.length; i++)
        {   
        	var value = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>';
			if(value == 1)
			{
				if ((WlanMap[i].portIndex == 1)||(WlanMap[i].portIndex == 5))
				{
					continue;
				}
			}
			
            if ('' == Wlan[i].name)
            {
                continue;
            }

			if('OSK2' == CfgMode.toUpperCase())
			{
				if ((WlanMap[i].portIndex == 1))
				{
					continue;
				}
			}	
			
            var mapIndex = parseInt(getIndexFromPort(WlanMap[i].portIndex));

            if ((1 == DoubleFreqFlag) && ("5G" == wlanpage))
            {
                if (WlanMap[i].portIndex < basic5GIfIndex)
                {
                    continue;
                }

                if ((aisAp == 1) && (WlanMap[i].portIndex > (basic5GIfIndex+3))) {
                    continue;
                }

				if (isSetTriBand())
				{
					if (0 == SelHighBand)
					{
						if (WlanMap[i].portIndex > (2*basic5GIfIndex-1))
						{
							continue;
						}
					}
					else
					{
						if (WlanMap[i].portIndex < 2*basic5GIfIndex)
						{
							continue;
						}
					}
				}
            }
                    
            if ((1 == DoubleFreqFlag) && ("2G" == wlanpage))
            {
                if (WlanMap[i].portIndex > (basic5GIfIndex-1))
                {
                    continue;
                }                    

                if ((aisAp == 1) && (WlanMap[i].portIndex > 3)) {
                    continue;
                }
            }

			if (1 != DoubleFreqFlag)
			{
				if (WlanMap[i].portIndex > (basic5GIfIndex-1))
                {
                    continue;
                }

                if ((aisAp == 1) && (WlanMap[i].portIndex > 3)) {
                    continue;
                }
			}

            var curWlanInst = getWlanInstFromDomain(Wlan[mapIndex].domain);
            if (aisApBackhaul == 1 && (curWlanInst == 9)) {
                continue;
            }

            if (curWlanInst == iotSsidInst) {
                continue;
            }

            if (aisApBackhaul == 1 && backupenable == 1) {
                if (wlanpage == "5G") {
                    if (curWlanInst == 7) {
                        continue;
                    }
                } else {
                    if (curWlanInst == 3) {
                        continue;
                    }
                }
            }

            if ((CfgMode.toUpperCase() == 'BIZNETEBG') && (IsGuestSsid(curWlanInst))) {
                continue;
            }

			if ('DTEDATA2WIFI' == CfgMode.toUpperCase())
			{
				if(1 == isSsidForIsp(curWlanInst))
				{
					continue;
				}
			}

            if (IsGuestSsid(curWlanInst)) {
                if ((CfgMode.toUpperCase() === 'BRAZCLARO') ||
                    ((CfgMode.indexOf('PCCW') === -1) && (isShowGuestWifiPage === '1'))) {
                    continue;
                }
            }

            document.write('<TR id="record_' + i  + '" class="tabal_01" onclick="selectLine(this.id);">');

            if ((WlanMap[i].portIndex == 0) || ((basic5GIfIndex == WlanMap[i].portIndex) && (DoubleFreqFlag == 1)) ||
                (((IspSSIDVisibility == 1) || (trueT3Flag == 1)) && (isSsidForIsp(curWlanInst) == 1)) || ((IsGuestSsid(curWlanInst)) && (t2Flag == 1))) {
                document.write('<TD>' + '<input type="checkbox" name="rml" id="rml"'  + ' value="'+ Wlan[mapIndex].domain + '" onclick="selectRemoveCnt(i);" disabled="true" >' + '</TD>');
            } else {
                document.write('<TD>' + '<input type="checkbox" name="rml" id="rml"'  + ' value="'+ Wlan[mapIndex].domain + '" onclick="selectRemoveCnt(i);">' + '</TD>');
            }
            
            document.write('<TD>' + curWlanInst + '</TD>');
            document.write('<TD>' + TDEGetSSIDStringContent(Wlan[mapIndex].ssid,32)+ '</TD>');
            
            if ((Wlan[mapIndex].enable == 1) && (Wlan[mapIndex].X_HW_ServiceEnable == 1))
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_ssid_enable'] + '</TD>');
            }
            else
            {
                document.write('<TD>' + cfg_wlancfgbasic_language['amp_ssid_disable'] + '</TD>');
            }

            if ((0 == ForbidAssocFlag) && (t2Flag == 0))
            {
                document.write('<TD>' + Wlan[mapIndex].DeviceNum+ '</TD>');
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

            if (firstLine === -1) {
                firstLine = i;
            }
        }
        </script>
    </table>
    
    </div>

<script language="JavaScript" type="text/javascript">
    wlanWriteTabTail();
</script>

<div id="list_table_spread" class="list_table_spread"></div>

<div id="fonDetailCover" style='display:none;
	width:660px;
	height:400px;
	margin-left:0px;
	margin-right:auto;
	margin-top:0px;
	position:absolute;
	z-index:100;
	filter: alpha(opacity=0); 
	-moz-opacity: 0; 
	-khtml-opacity: 0; 
	opacity: 0;
	background-color:#eeeeee;'>
</div>

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
                if ((preflag == 1) || (specialPreflag == 1)) {
                    document.write('<input type="text" name="wlSsid1" id="wlSsid1" maxlength="32">');
                    document.write('<input type="text" name="wlSsid2" id="wlSsid2" style="width:123px" maxlength="32">');
                    if (specialPreflag == 1) {
                        setText('wlSsid1', specialPreTitle + '_');
                        SetStyleValue("wlSsid1", "width:65px; border:0");
                        setDisable('wlSsid1', 1);
                    }
                } else {
                    document.write('<input type="text" name="wlSsid" id="wlSsid" style="width:123px" maxlength="32">');
                }
              </script>            
              <font class="color_red">*</font><span id="ssidLenTips" class="gray">
              <script>
              var ssidTips = cfg_wlancfgdetail_language['amp_linkname_note'];
			  if (1 == DslTalkTalkFlag)
			  {
				 ssidTips = cfg_wlancfgdetail_language['amp_linkname_note_dslTT'];
			  }
			  
              document.write(ssidTips);
              </script>
              </span> 
          </td>
        </tr>

        <tr id ="trSsidEnable" >
          <td class="table_title width_per25" BindText='amp_link_status'></td>
          <td class="table_right" id="TdEnable">
            <input type='checkbox' id='wlEnable' name='wlEnable' value="ON" onClick="SsidEnable();">
            <span class="gray"> </span></td>
        </tr>

        <tr id="tr_sta_num_max_limit">
          <td class="table_title width_per25" BindText='amp_link_cdevnum'></td>
          <td  class="table_right" id="TdDeviceNum">
            <input type='text' id='X_HW_AssociateNum' name='X_HW_AssociateNum' size='10' class="width_120px">
            <font class="color_red">*</font><span id='SpanDeviceNum' class="gray"> 
            <script>document.write(cfg_wlancfgdetail_language['amp_AssociateNum_note']);</script></span> 
          </td>
        </tr>

        <tr id = "trBroadcastSsid">
          <td class="table_title width_per25" BindText='amp_bcast_cssid'></td>
          <td class="table_right" id="TdHide">
            <input type='checkbox' id='wlHide' name='wlHide' value="ON" onclick='wlHideChange()'>
            <span class="gray"> </span></td>
        </tr>

        <tr id='wmmSwitchTr'>
          <td class="table_title width_per25" BindText='amp_multi_mdia'></td>
          <td class="table_right" id="TdWMM">
            <input type='checkbox' id='enableWmm' name='enableWmm' onclick='wmmChange()'>
            <span id='SpanWMM' class="gray">
			</span>
		  </td>
        </tr>
		
		<tr id='tr_sta_isolation' style='display:none;'>
            <td class="table_title width_per25">
                <script>
                    var staIsolationHtml = cfg_wlancfgdetail_language['amp_sta_isolation'];
                    if ((CfgMode.toUpperCase() === 'DTEDATA2WIFI') ||
                        (CfgMode.toUpperCase() === 'TEDATA') ||
                        (CfgMode.toUpperCase() === 'TEDATA2')) {
                        staIsolationHtml = cfg_wlancfgdetail_language['amp_sta_isolation_tedata'];
                    }
                    document.write(staIsolationHtml);
                </script>
            </td>
			<td class="table_right" id="Td_sta_isolation">
			<input type='checkbox' id='sta_isolation' >
			<span class="gray"></span></td>
		</tr>
      </table>

    <div id='divUAPSD' style='display:none'> 
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
            <tr> 
                <td class="table_title width_per25">Enable U-APSD:</td>
                <td class="table_right">
                <input type='checkbox' id='U-APSD' name='U-APSD' />
                <span class="gray"></span>
                </td>
            </tr>
        </table>
    </div>
    <table id='div11r' width="100%" style="padding: 0;background-color: #FFFFFF;margin-top:-10px;display:none;">
        <tr>
            <td class="table_title width_per25">11R:</td>
            <td class="table_right" id="td11r" style="padding-left: 3px;">
                <input type='checkbox' id='enable11r' name='enable11r'>
                <span id='Span11r' class="gray">
                </span>
            </td>
        </tr>
    </table>
    <div id='securityCfg'>
    <div id='wlAuthModeDiv'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_auth_mode'></td>
          <td class="table_right" id="TdAuth">
            <select id='wlAuthMode' name='wlAuthMode' size="1" onChange='authModeChange()' class="width_180px">
            <script language="JavaScript" type="text/javascript">
            if ((1 == TelMexFlag)||(1 == DTHungaryFlag))
            {
                document.write("<option value='open' selected>"+cfg_wlancfgdetail_language['amp_auth_open']+"</option>");
                document.write("<option value='wpa-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
                document.write("<option value='wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
                document.write("<option value='wpa/wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
                document.write("<option value='wpa3-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa3psk']+"</option>");
                document.write("<option value='wpa2/wpa3-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk']+"</option>");
                document.write("<option value='wpa'>"+cfg_wlancfgdetail_language['amp_auth_wpa']+"</option>");
                document.write("<option value='wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpa2']+"</option>");
                document.write("<option value='wpa/wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2']+"</option>");
                if (isShowWpa3Eap == 1) {
                    document.write("<option value='wpa3'>"+cfg_wlancfgdetail_language['amp_auth_wpa3']+"</option>");
                    document.write("<option value='wpa2/wpa3'>"+cfg_wlancfgdetail_language['amp_auth_wpa2wpa3']+"</option>");	
                }
            } else if ('ANTEL' == CfgMode.toUpperCase() || 'ANTEL2' == CfgMode.toUpperCase()) {
                document.write("<option value='wpa-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
                document.write("<option value='wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
                document.write("<option value='wpa/wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
            } else if (CfgMode.toUpperCase() === 'TTNET2') {
                document.write("<option value='wpa-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
                document.write("<option value='wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
                document.write("<option value='wpa/wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
                document.write("<option value='wpa3-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa3psk']+"</option>");
                document.write("<option value='wpa2/wpa3-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk']+"</option>");
                document.write("<option value='wpa'>"+cfg_wlancfgdetail_language['amp_auth_wpa']+"</option>");
                document.write("<option value='wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpa2']+"</option>");
                document.write("<option value='wpa/wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2']+"</option>");
            }
            else
            {
                document.write("<option value='open' selected>"+cfg_wlancfgdetail_language['amp_auth_open']+"</option>");
                document.write("<option value='shared'>"+cfg_wlancfgdetail_language['amp_auth_shared']+"</option>");
                document.write("<option value='wpa-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
                document.write("<option value='wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
                document.write("<option value='wpa/wpa2-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
                document.write("<option value='wpa3-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa3psk']+"</option>");
                document.write("<option value='wpa2/wpa3-psk'>"+cfg_wlancfgdetail_language['amp_auth_wpa2wpa3psk']+"</option>");
                document.write("<option value='wpa'>"+cfg_wlancfgdetail_language['amp_auth_wpa']+"</option>");
                document.write("<option value='wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpa2']+"</option>");
                document.write("<option value='wpa/wpa2'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2']+"</option>");
                if (isShowWpa3Eap == 1) {
                    document.write("<option value='wpa3'>"+cfg_wlancfgdetail_language['amp_auth_wpa3']+"</option>");
                    document.write("<option value='wpa2/wpa3'>"+cfg_wlancfgdetail_language['amp_auth_wpa2wpa3']+"</option>");
                }

                if(1 == WapiFlag)
                {
                    document.write("<option value='wapi-psk'>"+cfg_wlancfgdetail_language['amp_auth_wapi_psk']+"</option>");
                    document.write("<option value='wapi'>"+cfg_wlancfgdetail_language['amp_auth_wapi']+"</option>");
                }

            }
            </script>
            </select><span id="SpanAuthMode" class="gray"></span></td>
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
			<script language="JavaScript" type="text/javascript">
                if ((CfgModeWord != 'SYNCSGP210W') && (CfgModeWord != 'SONETSGP210W')) {
                    document.write("<span id='SpanEncrypt' class='gray'></span>");
                }
            </script>
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
              <script>
                setDisplay("tr_wepKeyBit", ('1' != noWep64Flag));
              </script>
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
            if (g_keys[0] != null)
            {
                document.write("<input type='password' autocomplete='off' id='wlKeys1' name='wlKeys1' size='20' maxlength=26 onchange=\"wep1password=getValue('wlKeys1');getElById('twlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>")
                document.write("<input type='text' autocomplete='off' id='twlKeys1' name='twlKeys1' size='20' maxlength=26 style='display:none'  onchange=\"wep1password=getValue('twlKeys1');getElById('wlKeys1').value=wep1password\" value='" + htmlencode(g_keys[0][1]) + "'>");
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
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
				{
					$("#checkinfo1Row").css("display", "");
					$("#psd_checkpwd1").css("display", "block");
					psdStrength1("wlKeys1");
				}
			});	
			$('#twlKeys1').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
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
                document.write("<input type='password' autocomplete='off' id='wlKeys2' name='wlKeys2' size='20' maxlength=26 onchange=\"wep2password=getValue('wlKeys2');getElById('twlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1])+ "'>")
                document.write("<input type='text' autocomplete='off' id='twlKeys2' name='twlKeys2' size='20' maxlength=26  style='display:none'  onchange=\"wep2password=getValue('twlKeys2');getElById('wlKeys2').value=wep2password\" value='" + htmlencode(g_keys[1][1]) + "'>");
            }
            </script> </td>
			        </tr>
		<tr id = "checkinfo2Row" style="display:none;">
          <td id = "checkinfotite2" class="table_title width_per25" BindText='amp_encrypt_key2_strength'></td>
		  <td id = "checkinfo2" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys2').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
				{
					$("#checkinfo2Row").css("display", "");
					$("#psd_checkpwd2").css("display", "block");
					psdStrength2("wlKeys2");
				}
			});	
			$('#twlKeys2').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
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
                document.write("<input type='text' autocomplete='off' id='twlKeys3' name='twlKeys3' size='20' maxlength=26  style='display:none' onchange=\"wep3password=getValue('twlKeys3');getElById('wlKeys3').value=wep3password\" value='" + htmlencode(g_keys[2][1]) + "'>");
            }
            </script> </td>
        </tr>
		<tr id = "checkinfo3Row" style="display:none;">
          <td id = "checkinfotite3" class="table_title width_per25" BindText='amp_encrypt_key3_strength'></td>
		  <td id = "checkinfo3" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys3').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
				{
					$("#checkinfo3Row").css("display", "");
					$("#psd_checkpwd3").css("display", "block");
					psdStrength3("wlKeys3");
				}
			});	
			$('#twlKeys3').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
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
                document.write("<input type='text' autocomplete='off' id='twlKeys4' name='twlKeys4' size='20' maxlength=26  style='display:none' onchange=\"wep4password=getValue('twlKeys4');getElById('wlKeys4').value=wep4password\" value='" + htmlencode(g_keys[3][1]) + "'>");
            }
            </script> </td>
        </tr>
		<tr id = "checkinfo4Row" style="display:none;">
          <td id = "checkinfotite4" class="table_title width_per25" BindText='amp_encrypt_key4_strength'></td>
		  <td id = "checkinfo4" class="table_title width_per25"></td>
			<script>		
			$('#wlKeys4').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
				{
					$("#checkinfo4Row").css("display", "");
					$("#psd_checkpwd4").css("display", "block");
					psdStrength4("wlKeys4");
				}
			});	
			$('#twlKeys4').on('keyup',function(){
				if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
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
            <input type='password' autocomplete='off' id='wlWpaPsk' name='wlWpaPsk' size='20' maxlength='64' class="amp_font"  onchange="wpapskpassword=getValue('wlWpaPsk');getElById('twlWpaPsk').value=wpapskpassword;" />
            <input type='text' autocomplete='off' id='twlWpaPsk' name='twlWpaPsk' size='20' maxlength='64' class="amp_font" style='display:none' onchange="wpapskpassword=getValue('twlWpaPsk');getElById('wlWpaPsk').value=wpapskpassword;"/>
            <input checked type="checkbox" id="hidewlWpaPsk" name="hidewlWpaPsk" value="on" onClick="ShowOrHideText('hidewlWpaPsk', 'wlWpaPsk', 'twlWpaPsk', wpapskpassword);"/>
            <span id="hideId2">
                <script>
                    if ((["SONETSGP200W", "SYNCSGP200W", "SYNCSGP210W"].indexOf(CfgMode.toUpperCase()) >= 0) && (curUserType == 0)) {
                        document.write("");
                    } else {
                        document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);
                    }
                </script>
            </span>
            <font class="color_red" id="hidewlWpaPsk_icon">*</font><span class="gray" id="hidewlWpaPsk_note">
            <script>
            var wpaPskNoteTxt = '';
            if (preflag == 1) {
                wpaPskNoteTxt = cfg_wlancfgdetail_language['amp_wpa_psknote_pldt'];
            } else {
                if (megacablePwd == 1) {
                    wpaPskNoteTxt = cfg_wlancfgdetail_language['amp_wpa_psknote_telmex'];
                } else {
                    wpaPskNoteTxt = cfg_wlancfgdetail_language['amp_wpa_psknote' + ('1' == kppUsedFlag ? '_63' : '')];
                }
            }

            document.write(wpaPskNoteTxt);
            </script></span>
			<span class="gray" id = "pskpasswordwarning" style="display:none;"></span></td>
		</tr>
		<tr id = "checkinfo5Row" style="display:none;">
          <td id = "checkinfotite5" class="table_title width_per25" BindText='amp_wpa_psk_strength'></td>
		  <td id = "checkinfo5" class="table_title"></td>
			<script>
            if (CfgMode.toUpperCase() == "EGVDF2") {
                $('#wlWpaPsk').on('keyup',function(){
                    if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
                    {
                        $("#checkinfo5Row").css("display", "");
                        $("#psd_checkpwd5").css("display", "block");
                        vdfPwdStrength("wlWpaPsk");
                    }
                });
                $('#twlWpaPsk').on('keyup',function(){
                    if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
                    {
                        $("#checkinfo5Row").css("display", "");
                        $("#psd_checkpwd5").css("display", "block");
                        vdfPwdStrength("twlWpaPsk");
                    }
                });
            } else {
                $('#wlWpaPsk').on('keyup',function(){
                    if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
                    {
                        $("#checkinfo5Row").css("display", "");
                        $("#psd_checkpwd5").css("display", "block");
                        psdStrength5("wlWpaPsk");
                    }
                });
                $('#twlWpaPsk').on('keyup',function(){
                    if ((PwdTipsFlag ==1) || (CfgMode.toUpperCase() == "EGVDF2"))
                    {
                        $("#checkinfo5Row").css("display", "");
                        $("#psd_checkpwd5").css("display", "block");
                        psdStrength5("twlWpaPsk");
                    }
                });
            }
			
			
			</script>

        </tr>
      </table>
    </div>
    
     <div id='wlWapi'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
           <td class="table_title width_per25" BindText='amp_wapi_ip'></td>
           <td class="table_right">
              <input type='text' id='wapiIPAddr' name='wapiIPAddr' size='20' maxlength='15'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
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
      <table id='tbRadiusIPAddr' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_srvip'></td>
          <td class="table_right">
              <input type='text' id='wlRadiusIPAddr' name='wlRadiusIPAddr' size='20' maxlength='39'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>

      <table id='tbRadiusPort' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_srvport'></td>
          <td class="table_right">
            <input type='text' id='wlRadiusPort' name='wlRadiusPort' size='20' maxlength='5'>
            <font class="color_red">*</font><span class="gray">
            <script>
			if(('1' == t2Flag) && (1 == DoubleFreqFlag) && ("5G" == wlanpage))
			{
				document.write(cfg_wlancfgdetail_language['amp_radiusport_note_1']);
			}
			else
			{
				document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);
			}
			</script></span> 
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_sharekey'></td>
          <td class="table_right">
            <input type='password' autocomplete='off' id='wlRadiusKey' name='wlRadiusKey' size='20' maxlength='64' class="amp_font" onchange="radiuspassword=getValue('wlRadiusKey');getElById('twlRadiusKey').value=radiuspassword;" />
            <input type='text' autocomplete='off' id='twlRadiusKey' name='twlRadiusKey' size='20' maxlength='64' class="amp_font" style='display:none'  onchange="radiuspassword=getValue('twlRadiusKey');getElById('wlRadiusKey').value=radiuspassword;"/>
            <input checked type="checkbox" id="hidewlRadiusKey" name="hidewlRadiusKey" value="on" onClick="ShowOrHideText('hidewlRadiusKey', 'wlRadiusKey', 'twlRadiusKey', radiuspassword);"/>
            <font class="color_red">*</font><span class="gray">
            <span id="hideId3"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
          </td>
        </tr>
      </table>

      <table id = 'trRadiusAccountEnable' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" style="display: none;">
        <td class="table_title width_per25" BindText='amp_radius_accountenalbe'></td>
        <td class="table_right" id="TdHide">
          <input type='checkbox' id='wlRadiusAccountEnable' name='wlRadiusAccountEnable' value="ON" onclick='wlHideChange()'>
          <span class="gray"> </span></td>
    </table>

      <table id='tbRadiusAccountPort' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" style="display: none;">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_accountport'></td>
          <td class="table_right">
            <input type='text' id='wlRadiusAccountPort' name='wlRadiusAccountPort' size='20' maxlength='5'>
            <font class="color_red">*</font><span class="gray">
                <script>
                if(('1' == t2Flag) && (1 == DoubleFreqFlag) && ("5G" == wlanpage)) {
                    document.write(cfg_wlancfgdetail_language['amp_radiusport_note_1']);
                } else {
                    document.write(cfg_wlancfgdetail_language['amp_radiusport_note']);
                }
                </script></span> 
          </td>
        </tr>
      </table>

      <table id='tbRadiusAccountIPAddr' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" style="display: none;">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_accountsvrip'></td>
          <td class="table_right">
              <input type='text' id='wlRadiusAccountIPAddr' name='wlRadiusAccountIPAddr' size='20' maxlength='39'>
              <font class="color_red">*</font>
          </td>
        </tr>
      </table>

      <table id='tbRadiusAccountKey' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" style="display: none;">
        <tr>
          <td class="table_title width_per25" BindText='amp_radius_accountsharekey'></td>
          <td class="table_right">
            <input type='password' autocomplete='off' id='wlRadiusAccountKey' name='wlRadiusAccountKey' size='20' maxlength='64' class="amp_font" onchange="radiusAccountpassword=getValue('wlRadiusAccountKey');getElById('twlRadiusAccountKey').value=radiusAccountpassword;" />
            <input type='text' autocomplete='off' id='twlRadiusAccountKey' name='twlRadiusAccountKey' size='20' maxlength='64' class="amp_font" style='display:none'  onchange="radiusAccountpassword=getValue('twlRadiusAccountKey');getElById('wlRadiusAccountKey').value=radiusAccountpassword;"/>
            <input checked type="checkbox" id="hidewlRadiusAccountKey" name="hidewlRadiusAccountKey" value="on" onClick="ShowOrHideText('hidewlRadiusAccountKey', 'wlRadiusAccountKey', 'twlRadiusAccountKey', radiusAccountpassword);"/>
            <font class="color_red">*</font><span class="gray">
            <span id="hideId4"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
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

    <div id='wpsPinNumber'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr> 
          <td class="table_title width_per25" BindText='amp_wps_enable'></td>
          <td class="table_right" id="TdWPSEnable"> <input id='wlWPSEnable' name='wlWPSEnable' type='checkbox' value="ON";> 
            <span class="gray" id='DivWpsNote'>
            </span>          
          </td>
        </tr>

        <tr>
          <td class="table_title width_per25" BindText='amp_wps_mode'></td>
          <td class="table_right">
            <select id='wlWPSMode' name='wlWPSMode' size='1' class="width_180px" onchange='wlPinModeChange();'> 
            </select> 
            <span class="gray" id='DivPinNote'>
            </span>
          </td>
        </tr> 
      </table>
    </div>

    <div id='wpsPBCButton'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25"><script>document.write(cfg_wlancfgother_language['amp_wlan_pbc']);</script></td>
          <td class="table_right"> 
            <script language="JavaScript" type="text/javascript">
                if (CfgMode == "DICELANDVDF") {
                    document.write('<input id="btnWpsPBC" name="btnWpsPBC" type="button" class="ApplyButtoncss  buttonwidth_height_30px" style="margin-left:0px" onClick="WpsPBCSubmit();">')
                } else {
                    document.write('<input id="btnWpsPBC" name="btnWpsPBC" type="button" class="CancleButtonCss buttonwidth_height_30px" style="margin-left:0px" onClick="WpsPBCSubmit();">')
                }
                setText('btnWpsPBC',cfg_wlancfgother_language['amp_btn_wpsstart']);
            </script>
            <span class="gray" id='DivPBCTimeNote'>
            </span>
          </td>
        </tr>
      </table>
    </div>

    <div id='wpsPinNumVal'>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
          <td class="table_title width_per25">PIN:</td>
          <td class="table_right"> <input type='text' id='wlClientPinNum' name='wlClientPinNum' size='20' maxlength='8' class="amp_font">
          <button id="PINPair" name="PINPair" type="button" class="CancleButtonCss buttonwidth_height_30px" onclick="OnPINPair();"/>
          <script>
          document.write("Pair STA");
          setDisplay('PINPair', 0);
          if ('1' == WPS20AuthSupported)
          {
            setDisplay('PINPair', 1);
          }
          </script>
          </button>
            <span class="gray" id='DivPinTimeNote'>
            </span>
          </td>
        </tr>
      </table>
    </div>

    <div id='wpsAPPinNumVal'> 
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr> 
          <td class="table_title width_per25">AP-PIN:</td>
          <td class="table_right"> <input type='text' id='wlSelfPinNum' name='wlSelfPinNum' size='20' maxlength='8' disabled class="amp_font"> 
            <button id="RegeneratePIN" name="RegeneratePIN" type="button" class="CancleButtonCss buttonwidth_height_30px" onclick="OnRegeneratePIN();"/><script>document.write(cfg_wlancfgother_language['amp_reg_pin']);</script></button>
            <button id="ResetPIN" name="ResetPIN" type="button" class="CancleButtonCss buttonwidth_height_30px" onclick="OnResetPIN();" style="display:none;"/>
            <script>document.write(cfg_wlancfgother_language['amp_reset_pin']);
            if ('1' == WPS20AuthSupported)
          {
            setDisplay('ResetPIN', 0);
          }	    	
          </script>
            </button>
			<span id="wpsApPinNumber" style="color:red;display:none;"></span>
            <span class="gray" id='DivAPPinTimeNote'>
            </span>
          </td>
        </tr>
      </table>
    </div>
    
        <div id='wpsConfigurated' style='display:none'> 
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr> 
          <td class="table_title width_per25">WPS Configurated:</td>
          <td class="table_right"> <input type='text' id='wpsconfig' name='wpsconfig' size='20' maxlength='8' disabled class="amp_font"> 
          <button id="SetState" name="SetState" type="button" class="CancleButtonCss buttonwidth_height_30px" onclick="OnSetWPSOOB();">
          <script>document.write("Set WPS OOB");</script>
          </button>
          <button id="wps20Reflash" name="wps20Reflash" type="button" class="CancleButtonCss buttonwidth_height_30px" onclick="OnWPS20Refresh();">
          <script>document.write("Refresh page for BCM");</script>
          </button>
          
          </td>
        </tr>
      </table>
    </div>
    <div id='GuestSsid'>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
          <tr> 
            <td class="table_title width_per25" id="wlanGuest" BindText='amp_wlan_Guest'></td>
            <td class="table_right" id="GuestSsidSEnable"> <input id='GuestSsidEnable' name='GuestSsidEnable' type='checkbox' value="ON";></td>
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

    <table width="100%" border="0" cellpadding="0" cellspacing="0"  ></table>
    <div style="overflow:hidden;zoom:1;">
        <span id="QRdesc" style="margin-top:200px;font-size:20px;font-family:arial;"><script>document.write(cfg_wlancfgother_language['amp_wlan_QRdesc']);</script></span>
        <div id="QRCode" style="margin-left:262px;"></div>
    </div>
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
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
