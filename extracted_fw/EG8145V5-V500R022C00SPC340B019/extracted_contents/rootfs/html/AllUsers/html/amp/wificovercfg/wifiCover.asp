<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, wificovercfg_language, cfg_wlancfgother_language, cfg_wlancfgdetail_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>WiFi Coverage Management</title>
<script language="JavaScript" type="text/javascript">

var UPNPCfgFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_UPNP_CONFIG);%>';
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var PccwFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PCCW);%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

var isAscOver = '<%HW_WEB_GetEnforceACSOperFlag();%>';
var ShowFirstSSID = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SHOW_FIRST_SSID);%>';
var vdfFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>';
var viettelPrefixFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIETTEL_PREFIX);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var noWiFiChipFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_START_WITH_NO_CHIP);%>';
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';

var aWiFiSSID2GInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AWiFi_SSID.SSID2GINST);%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var dbForceKickInterval = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.ForceKickInterval);%>;
var deviceInfos =  '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var forceKickStaFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_FORCEKICKSTA_LOWRSSI);%>';
var forceKickThres = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.ForcedSwitchThrehold);%>';
var supportForceKickSta = forceKickStaFlag;

var retserver_exist = '<%HW_WEB_GetRetServiceExistFlag();%>';
var productType = '<%HW_WEB_GetProductType();%>';

var tmczstFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TMCZST);%>';
var webEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebEnable);%>';
var webAdminEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebAadminEnable);%>';
var isVideoRetrans = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIDEO_TRANS);%>';

var scnFT = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SCN_ROAM);%>';
var isApSsidOver = 0;
var AscOverFlagHandle;
var check5GSSIDRadio;
var check2GSSIDRadio;
var nowCheck5GSSID;
var nowCheck2GSSID;
var typeWord='<%HW_WEB_GetTypeWordMode();%>';
var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    isFitAp = 1;
}

initWlanCap("2G");

function hidePwdInput() {
    var hideEles = document.getElementsByName("checkWlPsk");
    for (var index = 0; index < hideEles.length; index++) {
        hideEles[index].style.display = "none";
    }
    hideSpanExcludeError("hideId1");
    hideSpanExcludeError("hideId2");
    hideSpanExcludeError("hideId3");
    hideClassExcludeError("hidetitle");
}

function hideClassExcludeError(className) {
    try {
        var hideElements = document.getElementsByClassName(className);
        var hideElement;
        for (var tempIndex = 0; tempIndex < hideElements.length; tempIndex++) {
            hideElement = hideElements[tempIndex];
            hideElement.style.display = "none";
        }
    } catch (error) {
    }
}

function hideSpanExcludeError(id) {
    try {
        document.getElementById(id).style.display = "none";
    } catch (error) {
    }
}

function USERDeviceInfo(Domain,MACAddress,Name) {
    this.Domain = Domain;
    this.MACAddress = MACAddress;
    this.Name = Name;
}
var g_AllUserDevinfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_HOMENET_NAME.hosts.{i},MACAddress|Name ,USERDeviceInfo);%>;

function getAscOverFlag()
{
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "refreshOperFlag.asp?&1=1",
            success : function(data) {
                isAscOver = data;
            }
        });
}

function getApSsidOverFlag(wlaninst)
{
    isApSsidOver = 0;
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : "wlaninst=" + wlaninst,
            url : "refreshApSsidFlag.asp?&1=1",
            success : function(data) {
                isApSsidOver = data;
            }
        });
}

var AddSsidInstArray = '';
var DelSsidInstArray = '';

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

        if (wificovercfg_language[b.getAttribute("BindText")]) 
        {
            b.innerHTML = wificovercfg_language[b.getAttribute("BindText")];
        }
    }
}

var scnVar = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.Enable);%>';

function stWifiCoverService(domain, AutoExtended, AutoExtendedPolicy, IspExtended, AutoSwitchAP, SyncWifiSwitch, Enable, AutoExtendPublicWiFi, RETEnable, RETRtcpPort, BondingEnable, BondingRatio2G, BondingRatio5G)
{
    this.domain = domain;
    this.AutoExtended = AutoExtended;
    this.AutoExtendedPolicy = AutoExtendedPolicy;
    this.IspExtended = IspExtended;
    this.AutoSwitchAP = AutoSwitchAP;
    this.SyncWifiSwitch = SyncWifiSwitch;
    this.Enable = Enable;
    this.AutoExtendPublicWiFi = AutoExtendPublicWiFi;
    this.RETEnable = RETEnable;
    this.RETRtcpPort = RETRtcpPort;
    this.BondingEnable = BondingEnable;
    this.BondingRatio2G = BondingRatio2G;
    this.BondingRatio5G = BondingRatio5G;
}

var WifiCoverService = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_WifiCoverService, AutoExtended|AutoExtendedPolicy|IspExtended|AutoSwitchAP|SyncWifiSwitch|Enable|AutoExtendPublicWiFi|RETEnable|RETRtcpPort|BondingEnable|BondingRatio2G|BondingRatio5G, stWifiCoverService);%>;

function stLiveAccessContol(domain, LiveModeEnable, IntensityThreshold, MonitorTimes, WeakTimes)
{
    this.domain = domain;
    this.LiveModeEnable = LiveModeEnable;
	this.IntensityThreshold = IntensityThreshold;
	this.MonitorTimes = MonitorTimes;
	this.WeakTimes = WeakTimes;
}

var liveAccessContol = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_WifiCoverService.LiveAccessControl, LiveModeEnable|IntensityThreshold|MonitorTimes|WeakTimes, stLiveAccessContol);%>;

function stConfigurationByRadio(domain, RFBand, AutoExtendedSSIDIndex, ForcedRssiThrehold, LowRssiThreshold, HighRssiThreshold, IncreasedRssiThreshold)
{
    this.domain = domain;
    this.RFBand = RFBand;
    this.AutoExtendedSSIDIndex = AutoExtendedSSIDIndex;
    this.ForcedSwitchThrehold = ForcedRssiThrehold;
    this.LowRssiThreshold = LowRssiThreshold;
    this.HighRssiThreshold = HighRssiThreshold;
    this.IncreasedRssiThreshold = IncreasedRssiThreshold;
}

var ConfigurationByRadio = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_WifiCoverService.ConfigurationByRadio.{i},RFBand|AutoExtendedSSIDIndex|ForcedRssiThrehold|LowRssiThreshold|HighRssiThreshold|IncreasedRssiThreshold,stConfigurationByRadio);%>;

function getInstIdByDomain(domain)
{
    if ('' != domain)
    {
        return parseInt(domain.substr(domain.lastIndexOf('.') + 1));
    }
}

function stExtendedWLC(domain, SSIDIndex)
{
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
    this.ExtWlanInst = getInstIdByDomain(domain);
}

var apExtendedWLC = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC);%>;

function stWlan(domain, Name, ssid, wlHide, X_HW_RFBand,LowerLayers,X_HW_ServiceEnable,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,WEPKeyIndex,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode, Enable, DeviceNum, IsolationEnable)
{
    this.domain = domain;
    this.Name = Name;
    this.ssid = ssid;
    this.wlHide = wlHide;
    this.X_HW_RFBand = X_HW_RFBand;
    this.LowerLayers = LowerLayers;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.WEPKeyIndex = WEPKeyIndex;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_WPAand11iAuthenticationMode = X_HW_WPAand11iAuthenticationMode;
    this.Enable = Enable;
    this.DeviceNum = DeviceNum;
    this.IsolationEnable = IsolationEnable;
    this.WlanInst = getInstIdByDomain(domain);
}

function stWLANInfo(Domain, Name)
{
    this.Domain = Domain;
    this.Name = Name;
}

var WlanList = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, Name|SSID|SSIDAdvertisementEnabled|X_HW_RFBand|LowerLayers|X_HW_ServiceEnable|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|Enable|X_HW_AssociateNum|IsolationEnable, stWlan);%>;
var iotSsidInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.SyncIotSsidInst);%>';
var WlanListNum = WlanList.length - 1;

for (var i = 0; i < WlanListNum; i++)
{
    for (var j = i; j < WlanListNum; j++)
    {
        var index_i = getWlanPortNumber(WlanList[i].Name);
        var index_j = getWlanPortNumber(WlanList[j].Name);
        
        if (index_i > index_j)
        {
            var WlanTemp = WlanList[i];
            WlanList[i] = WlanList[j];
            WlanList[j] = WlanTemp;
        }
    }
}

if (CfgMode.toUpperCase() == "AISAP") {
    for (var i = 0; i < WlanListNum; i++) {
        if (WlanList[i].domain == "InternetGatewayDevice.LANDevice.1.WLANConfiguration.9") {
            WlanList.splice(i, 1);
            WlanListNum = WlanList.length - 1;
            break;
        }
    }
}

var thisLowerLayer;
var WlanList2G = new Array();
var WlanList5G = new Array();

for (var i = 0; i < WlanList.length - 1; i++ )
{
    var athindex = getWlanPortNumber(WlanList[i].Name);
    if (( athindex >= 0 )&&( athindex <= ssidEnd2G ))    
    {
        WlanList2G.push(WlanList[i]);
    }
    else if (( athindex >= ssidStart5G )&&( athindex <= ssidEnd5G)) 
    {
        WlanList5G.push(WlanList[i]);
    }
}

var pskPsdModFlag = false;

function stPreSharedKey(domain, psk, kpp)
{
    this.domain = domain;
    this.value = psk;
    
    if('1' == kppUsedFlag)
    {
        this.value = kpp;
    }
}

var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey|KeyPassphrase,stPreSharedKey);%>;

var wpaPskMap = {};
for (var i = 0; i < wpaPskKey.length-1; i++)
{
    var index = wpaPskKey[i].domain.split('.')[4];
    wpaPskMap[index] = wpaPskKey[i];
}

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
var iotAutoSsidInst = "<%WEB_GetIotSsidInst();%>";
function stAttachConf(domain, X_HW_MNGSsidState) {
    this.domain = domain;
    this.MNGSsidState = X_HW_MNGSsidState;
}
var wlanAttachConfList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AttachConf, X_HW_MNGSsidState, stAttachConf);%>;
var attachConfMap = {};
for (var i = 0 ; i < wlanAttachConfList.length - 1; i++) {
    var index = wlanAttachConfList[i].domain.split('.')[4];
    attachConfMap[index] = wlanAttachConfList[i];
}
var wlanMap = {};
for (var i = 0; i < WlanList.length-1; i++)
{
    var index = getInstIdByDomain(WlanList[i].domain);
    wlanMap[index] = i;
}

var authMap = {    'OPEN' : wificovercfg_language['amp_homenetwork_auth_open'], 
                'WEP' : wificovercfg_language['amp_homenetwork_auth_wep'], 
                'WPA-Personal' : wificovercfg_language['amp_homenetwork_auth_wpa'], 
                'WPA2-Personal' : wificovercfg_language['amp_homenetwork_auth_wpa2'], 
                'WPA-WPA2-Personal' : wificovercfg_language['amp_homenetwork_auth_wpa_wpa2'],
                'WPA3-Personal' : wificovercfg_language['amp_homenetwork_auth_wpa3'], 
                'WPA2-WPA3-Personal' : wificovercfg_language['amp_homenetwork_auth_wpa2_wpa3']
              };
var authMapBpon = { 'Basic' : "OPEN", 
                'WPA' : 'WPA-Personal', 
                '11i' : 'WPA2-Personal', 
                'WPA2' : 'WPA2-Personal', 
                'WPAand11i' : 'WPA-WPA2-Personal',
                'WPA/WPA2' : 'WPA-WPA2-Personal',
                'WPA3' : 'WPA3-Personal', 
                'WPA2/WPA3' : 'WPA2-WPA3-Personal'
              };

var encryptMapBpon = { 'NONE' : "--", 
                'AESEncryption' : cfg_wlancfgdetail_language['amp_encrypt_aes'], 
                'TKIPEncryption' : cfg_wlancfgdetail_language['amp_encrypt_tkip'], 
                'TKIPandAESEncryption' : cfg_wlancfgdetail_language['amp_encrypt_tkipaes']
              };
                    
function stFonSsidInst(domain, inst2g, inst5g)
{
    this.domain = domain;
    this.fonssid2g = inst2g;
    this.fonssid5g = inst5g;
}
var fonssidinsts  = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.FON, SSID2GINST|SSID5GINST, stFonSsidInst, EXTEND);%>;
var fonssidinst = new stFonSsidInst("", 0 , 0);
if ((fonssidinsts.length > 1) && ('1' == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_FON);%>'))
{
    fonssidinst = fonssidinsts[0];
}

function stGuestWifi(domain,SSID_IDX)
{
    this.domain = domain;
    this.SSID_IDX = SSID_IDX;
}


var GuestWifiArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.{i},SSID_IDX,stGuestWifi);%>;
var GuestWifiMap = {};

for(var i=0; i < GuestWifiArr.length - 1; i++)
{
    GuestWifiMap[GuestWifiArr[i].SSID_IDX] = GuestWifiArr[i];
}

function  stApDevice(domain, DeviceType, SerialNumber, DeviceStatus, UpTime, WorkingMode, SyncStatus, SupportedWorkingMode, SupportedRFBand, SupportedSSIDNumber, UpAccessSsidInst, APMacAddr)
{
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
    this.APMacAddr = APMacAddr;
}

var apDeviceList = new Array();
apDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}, DeviceType|SerialNumber|DeviceStatus|UpTime|WorkingMode|SyncStatus|SupportedWorkingMode|SupportedRFBand|SupportedSSIDNumber|UpAccessSsidInst|APMacAddr, stApDevice);%>;
 
for (var ap_loop = 0, ap_valid_num = 0; (ap_loop < apDeviceList.length - 1) && (ap_valid_num < apDeviceList.length - 1); )
{
    if (("" == apDeviceList[ap_loop].DeviceType) || ("" == apDeviceList[ap_loop].SerialNumber))
    {
        apDeviceList.splice(ap_loop, 1);
    }
    else
    {
        ap_valid_num++;
    }

    ap_loop = ap_valid_num;
}

var apNum = apDeviceList.length - 1;

function stTopoAdjustPolicy(domain, UserPolicy, LowRateThrehold, PacketLossRateThrehold)
{    
    this.domain = domain;
    this.UserPolicy = UserPolicy;
    this.LowRateThrehold = LowRateThrehold;
    this.PacketLossRateThrehold = PacketLossRateThrehold;
}

var topoAdjustPolicyList = new Array();
topoAdjustPolicyList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SmartTopo, UserPolicy|LowRateThrehold|PacketLossRateThrehold, stTopoAdjustPolicy);%>;

var topoAdjustPolicy = topoAdjustPolicyList[0];
if (null == topoAdjustPolicy)
{
    topoAdjustPolicy = new stTopoAdjustPolicy('', 1, 50, 3);
}

var syncstatus = wificovercfg_language['amp_wificover_syncstatus_yes_desc'];
function getSyncStauts(intSyncStatus)
{
    if (1 == intSyncStatus)
    {
        syncstatus = wificovercfg_language['amp_wificover_syncstatus_nocfg_desc'];
    }
    else if (2 == intSyncStatus)
    {
        syncstatus = wificovercfg_language['amp_wificover_syncstatus_no_desc'];
    }
    else
    {
        syncstatus = wificovercfg_language['amp_wificover_syncstatus_yes_desc'];
    }
}

function getTheDeviceStatus(apDevice)
{
    var deviceStatus = apDevice.DeviceStatus;
    
    if (apDevice.DeviceStatus != 'OK' && apDevice.DeviceStatus != 'Warning' 
        && apDevice.DeviceStatus != 'Error' && apDevice.DeviceStatus != 'Fatal')
    {
        if (apDevice.UpTime != '-')
        {
            deviceStatus = 'OK';
        }
        else 
        {
            deviceStatus = '-';
        }
    }

    return deviceStatus;
}

function UpnpEnableSubmit()
{
    if ((UPNPCfgFlag == true) && (fttrFlag != 1)) {
        var Form = new webSubmitForm();
        Form.addParameter('x.Enable', getCheckVal('UpnpEnable'));
        Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }

}

function onClickSelectPolicy()
{        
    if(1 == getRadioVal("AutoExtendedPolicy"))
    {
        WifiCoverService[0].AutoExtended = 0;
    }
    else if(2 == getRadioVal("AutoExtendedPolicy"))
    {
        WifiCoverService[0].AutoExtended = 1;
        WifiCoverService[0].AutoExtendedPolicy = 0
    }
    else if(3 == getRadioVal("AutoExtendedPolicy"))
    {
        WifiCoverService[0].AutoExtended = 1;
        WifiCoverService[0].AutoExtendedPolicy = 1;
    }
    else 
    {
        WifiCoverService[0].AutoExtended = 1;
    }
    
    var Form = new webSubmitForm();

    Form.addParameter('x.AutoExtended', WifiCoverService[0].AutoExtended);
    Form.addParameter('x.AutoExtendedPolicy',WifiCoverService[0].AutoExtendedPolicy);

    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function funCover2GSsidSelect()
{
    var Form = new webSubmitForm();
    Form.addParameter('x.AutoExtendedSSIDIndex', getSelectVal('Cover2GSsidSelect'));
    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService.ConfigurationByRadio.1'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');             
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function funCover5GSsidSelect()
{
    var Form = new webSubmitForm();
    Form.addParameter('x.AutoExtendedSSIDIndex', getSelectVal('Cover5GSsidSelect'));
    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService.ConfigurationByRadio.2'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function CheckSwitchThreodhold()
{ 
    var ForceSwitchValue2G = getValue('wifiCoverForceSwitch2G');
    var LowThresholdValue2G = getValue('LowRssiThreshold2G');
    var HighThresholdValue2G = getValue('HighRssiThreshold2G');
    var IncreasedThresholdValue2G = getValue('IncreasedRssiThreshold2G');
    var ForceKickInterval = getValue('wifiCoverForceInterVal2G');
    
    if(!isInteger(ForceSwitchValue2G))
    {
        AlertEx(wificovercfg_language['amp_forceSwitch_int']);
        return false;
    }

    if (supportForceKickSta == 1) {
        if (!isInteger(ForceKickInterval) || ForceKickInterval < 1 || ForceKickInterval > 1440) {
            AlertEx(wificovercfg_language['amp_forceKickInterval_out_range']);
            return false;
        }
    }

    if( (parseInt(ForceSwitchValue2G,10) < -100) || (parseInt(ForceSwitchValue2G,10) > -66)  )
    {

        AlertEx(wificovercfg_language['amp_forceSwitch_out_range']);
        return false;
    }
    
    if(!isInteger(LowThresholdValue2G))
    {
        AlertEx(wificovercfg_language['amp_LowRssiThreshold_int']);
        return false;
    }

    if( (parseInt(LowThresholdValue2G,10) < -100) || (parseInt(LowThresholdValue2G,10) > -60) )
    {

        AlertEx(wificovercfg_language['amp_LowRssiThreshold_out_range']);
        return false;
    }
    
    if(!isInteger(HighThresholdValue2G))
    {
        AlertEx(wificovercfg_language['amp_HighRssiThreshold_int']);
        return false;
    }

    if( (parseInt(HighThresholdValue2G,10) < -59) || (parseInt(HighThresholdValue2G,10) > 0))
    {
        AlertEx(wificovercfg_language['amp_HighRssiThreshold_out_range']);
        return false;
    }
    
    if(!isInteger(IncreasedThresholdValue2G))
    {
        AlertEx(wificovercfg_language['amp_IncreasedRssiThreshold_int']);
        return false;
    }

    if( (parseInt(IncreasedThresholdValue2G,10) < 3) || (parseInt(IncreasedThresholdValue2G,10) > 100) )
    {

        AlertEx(wificovercfg_language['amp_IncreasedRssiThreshold_out_range']);
        return false;
    }

    if( parseInt(ForceSwitchValue2G,10) > parseInt(LowThresholdValue2G,10))
    {
        AlertEx(wificovercfg_language['amp_force_bigger_LowRssiThreshold']);
        return false;
    }
    
    if ((1 == DoubleFreqFlag) || (1 == isShowHomeNetWork))
    {
        var ForceSwitchValue5G = getValue('wifiCoverForceSwitch5G');
        var LowThresholdValue5G = getValue('LowRssiThreshold5G');    
        var HighThresholdValue5G = getValue('HighRssiThreshold5G');
        var IncreasedThresholdValue5G = getValue('IncreasedRssiThreshold5G');
        
        if(!isInteger(ForceSwitchValue5G))
        {
            AlertEx(wificovercfg_language['amp_forceSwitch_int']);
            return false;
        }

        if( (parseInt(ForceSwitchValue5G,10) < -100) || (parseInt(ForceSwitchValue5G,10) > -66)  )
        {
            AlertEx(wificovercfg_language['amp_forceSwitch_out_range']);
            return false;
        }
    
        if(!isInteger(LowThresholdValue5G))
        {
            AlertEx(wificovercfg_language['amp_LowRssiThreshold_int']);
            return false;
        }

        if( (parseInt(LowThresholdValue5G,10) < -100) || (parseInt(LowThresholdValue5G,10) > -60) )
        {
            AlertEx(wificovercfg_language['amp_LowRssiThreshold_out_range']);
            return false;
        }
    
        if(!isInteger(HighThresholdValue5G))
        {
            AlertEx(wificovercfg_language['amp_HighRssiThreshold_int']);
            return false;
        }

        if( (parseInt(HighThresholdValue5G,10) < -59) || (parseInt(HighThresholdValue5G,10) > 0))
        {
            AlertEx(wificovercfg_language['amp_HighRssiThreshold_out_range']);
            return false;
        }
    
        if(!isInteger(IncreasedThresholdValue5G))
        {
            AlertEx(wificovercfg_language['amp_IncreasedRssiThreshold_int']);
            return false;
        }

        if( (parseInt(IncreasedThresholdValue5G,10) < 3) || (parseInt(IncreasedThresholdValue5G,10) > 100) )
        {
            AlertEx(wificovercfg_language['amp_IncreasedRssiThreshold_out_range']);
            return false;
        }

        if( parseInt(ForceSwitchValue5G,10) > parseInt(LowThresholdValue5G,10))
        {
            AlertEx(wificovercfg_language['amp_force_bigger_LowRssiThreshold']);
            return false;
        }
    }
    
    return true;
}

function wifiCoverAdvSubmit()
{
    var Form = new webSubmitForm();
    
    if (false == CheckSwitchThreodhold())
    {
        return;
    }

    Form.addParameter('x.AutoSwitchAP', getCheckVal('AutoSwitchAP'));
    if (supportForceKickSta == 1) {
        Form.addParameter('x.ForceKickInterval', parseInt(getValue('wifiCoverForceInterVal2G'), 10) * 60);
        Form.addParameter('x.ForcedSwitchThrehold', parseInt(getValue('wifiCoverForceSwitch2G'), 10));
    }
    Form.addParameter('y.ForcedRssiThrehold', parseInt(getValue('wifiCoverForceSwitch2G'), 10));
    Form.addParameter('y.LowRssiThreshold',  parseInt(getValue('LowRssiThreshold2G'), 10));
    Form.addParameter('y.HighRssiThreshold',  parseInt(getValue('HighRssiThreshold2G'), 10));
    Form.addParameter('y.IncreasedRssiThreshold',  parseInt(getValue('IncreasedRssiThreshold2G'), 10));
    var actionUrl = '&y=' + ConfigurationByRadio[0].domain;
    
    if ((1 == DoubleFreqFlag) || (1 == isShowHomeNetWork))
    {
        Form.addParameter('z.ForcedRssiThrehold', parseInt(getValue('wifiCoverForceSwitch5G'), 10));
        Form.addParameter('z.LowRssiThreshold', parseInt(getValue('LowRssiThreshold5G'), 10));
        Form.addParameter('z.HighRssiThreshold', parseInt(getValue('HighRssiThreshold5G'), 10));
        Form.addParameter('z.IncreasedRssiThreshold', parseInt(getValue('IncreasedRssiThreshold5G'), 10));
        actionUrl += '&z=' + ConfigurationByRadio[1].domain;
    }
                     
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_WifiCoverService'
                    + actionUrl
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function BindForceInterValEvent(id, freg) {
    $('#' + id + freg).bind("change", function() {
        if (freg == '2G') {
            setText(id + '5G', getValue(id + '2G'));
        } else {
            setText(id + '2G', getValue(id + '5G'));
        }
    });
}

function setDefaultRssi()
{
    setText('wifiCoverForceSwitch2G', ConfigurationByRadio[0].ForcedSwitchThrehold);
    if (supportForceKickSta == 1) {
        setText('wifiCoverForceSwitch2G', forceKickThres);
        setDisplay("wifiCoverForceInterDiv", 1);
        setText('wifiCoverForceInterVal2G', dbForceKickInterval/60);
    }
    setText('LowRssiThreshold2G', ConfigurationByRadio[0].LowRssiThreshold);
    setText('HighRssiThreshold2G', ConfigurationByRadio[0].HighRssiThreshold);
    setText('IncreasedRssiThreshold2G', ConfigurationByRadio[0].IncreasedRssiThreshold);
    
    if ((1 == DoubleFreqFlag) || (1 == isShowHomeNetWork))
    {
        setText('wifiCoverForceSwitch5G', ConfigurationByRadio[1].ForcedSwitchThrehold);
        if (supportForceKickSta == 1) {
            setText('wifiCoverForceSwitch5G', forceKickThres);
            setText('wifiCoverForceInterVal5G', dbForceKickInterval/60);
            BindForceInterValEvent('wifiCoverForceInterVal', '5G');
            BindForceInterValEvent('wifiCoverForceInterVal', '2G');
            BindForceInterValEvent('wifiCoverForceSwitch', '5G');
            BindForceInterValEvent('wifiCoverForceSwitch', '2G');
        }
        setText('LowRssiThreshold5G', ConfigurationByRadio[1].LowRssiThreshold);
        setText('HighRssiThreshold5G', ConfigurationByRadio[1].HighRssiThreshold);
        setText('IncreasedRssiThreshold5G', ConfigurationByRadio[1].IncreasedRssiThreshold);
    }
}

function wifiCoverAdvCancel()
{
    setCheck('AutoSwitchAP', WifiCoverService[0].AutoSwitchAP);
    setDefaultRssi();
}

function judgeWifiCoverNum()
{
    var bsradio = document.getElementsByName("bandsteer");
    
    for(i = 0; i< bsradio.length ;i++)
    {
        if(bsradio[i].checked == true)
        {
            return bsradio[i].value;
        }
    }
    
    return 0;
}

function wifiCoverAndBandSteeringSubmit()
{
    var Form = new webSubmitForm();
    
    Form.addParameter('x.SteeringSensitivity', judgeWifiCoverNum());                     
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_WifiCoverService'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function wifiCoverAndBandSteeringCancel()
{
    LoadRFAdjust();
}
    
function LoadRFAdjust()
{
    var rfAdjust = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.SteeringSensitivity);%>;
    var bsradio = document.getElementsByName("bandsteer");
    
    if(rfAdjust == 0)
    {
        bsradio[0].checked = true;
    }
    else if(rfAdjust == 1)
    {
        bsradio[1].checked = true;
    }
    else
    {
        bsradio[2].checked = true;
    }
}

function AssignEncrypt(wlan) {
    if ((wlan.BeaconType == 'Basic') || (wlan.BeaconType == 'None')) {
        Auth = wlan.BasicAuthenticationMode;
        Encrypt = wlan.BasicEncryptionModes;
    } else if (wlan.BeaconType == 'WPA') {
        Auth = wlan.WPAAuthenticationMode;
        Encrypt = wlan.WPAEncryptionModes;
    } else if ((wlan.BeaconType == '11i') || (wlan.BeaconType == 'WPA2')) {
        Auth = wlan.IEEE11iAuthenticationMode;
        Encrypt = wlan.IEEE11iEncryptionModes;
    } else if ((wlan.BeaconType == 'WPAand11i') || (wlan.BeaconType == 'WPA/WPA2') || (wlan.BeaconType == 'WPA3') || (wlan.BeaconType == 'WPA2/WPA3')) {
        Auth = wlan.X_HW_WPAand11iAuthenticationMode;
        Encrypt = wlan.X_HW_WPAand11iEncryptionModes;
    }
    authTrueValue = wlan.BeaconType;
}

var Auth = '';
var Encrypt = '';
var authTrueValue = '';
function isShowWlan(wlan)
{
    AssignEncrypt(wlan);
    
    if(Auth == 'EAPAuthentication')
    {   
        return false;
    }
                
    if(Encrypt == 'NONE' || Encrypt == 'None')
    {  
        if (Auth == 'Both')
        {
            Encrypt = 'WEP';
        }
        else
        {
            Encrypt = 'OPEN';
        }
    }
    else if(Encrypt == 'WEPEncryption')
    {
        Encrypt = 'WEP';
    }
    else if(Encrypt == 'AESEncryption') 
    {
        if (wlan.BeaconType == 'WPA3') {
            Encrypt = 'WPA3-Personal';
        } else if (wlan.BeaconType == 'WPA2/WPA3') {
            Encrypt = 'WPA2-WPA3-Personal';
        } else {
            Encrypt = 'WPA2-Personal';
        }
    }
    else if(Encrypt == 'TKIPEncryption')
    {
        Encrypt = 'WPA-Personal';
    }
    else if(Encrypt == 'TKIPandAESEncryption')
    {
        Encrypt = 'WPA-WPA2-Personal';
    }
    
    if ('WEP' == Encrypt)
    {
        return false;
    }
    var wlanInst = getInstIdByDomain(wlan.domain);
    
    if (IsIspSsid(wlanInst))
    {
        return false;
    } 
    
    if(IsAwifiSsid(wlanInst))
    {
        return false;
    }
    if (isBponFlag === '1') {
        if (isOMWlan(wlanInst)) {
            return false;
        }
    }
    if(1 == ShowFirstSSID)    
    {
        if((wlanInst != 1) &&(wlanInst != 5))
        {
            return false;
        } 
    }
    
    if ((wlanInst == fonssidinst.fonssid2g) || (wlanInst == fonssidinst.fonssid5g))
    {
        return false;
    }
    if(1 != wlan.X_HW_ServiceEnable)
    {
        return false;
    }
    if(undefined != GuestWifiMap[wlanInst])
    {
        return false;
    }
                                
    return true;
}
function isOMWlan(wlanInst) {
    return (attachConfMap[wlanInst].MNGSsidState === '1');
}

function GetEncryptByValue(encrypt) {
    if (encrypt == "OPEN") {
        return "NONE";
    } else if (encrypt == 'WPA-Personal') {
        return "TKIPEncryption"
    } else if ((encrypt == 'WPA2-Personal') || (encrypt == 'WPA3-Personal') || (encrypt == 'WPA2-WPA3-Personal')) {
        return "AESEncryption"
    } else if (encrypt == 'WPA-WPA2-Personal') {
        return "TKIPandAESEncryption"
    }
}

function IsOnlyOneSsidExtSupport(wificoverApId)
{
    for (var i = 0; i < apNum; i++)
    {
        var ApInst = getInstIdByDomain(apDeviceList[i].domain);
        
        if (wificoverApId != ApInst)
        {
            continue;
        }
        
        if ("WS331c" == apDeviceList[i].DeviceType)
        {
            for (var index = 0; index < WlanListNum; index++)
            {
                var wlanInst = getInstIdByDomain(WlanList[index].domain);
                
                if (isShowWlan(WlanList[index]) == false)
                {
                    continue;
                }
                
                setDisable('ExtendedWLC_' + wlanInst, 1);
            }
        }
        else
        {
            for (var index = 0; index < WlanListNum; index++)
            {
                var wlanInst = getInstIdByDomain(WlanList[index].domain);
                
                if (isShowWlan(WlanList[index]) == false)
                {
                    continue;
                }
                setDisable('ExtendedWLC_' + wlanInst, 0);
            }
        }
    }
}

var checkwlanInst2G = 0;

function IsOnlyOneSsidExtEveryRFBandSupport(wificoverApId,checkflag,checkwlanInst,rfband)
{ 
    
    var devicetype;

    for (var indexap = 0; indexap < apNum; indexap++)
    {
        var apInst = getInstIdByDomain(apDeviceList[indexap].domain);
        if (apInst == wificoverApId)
        {
            break;
        }
    }
    
    if (apNum == indexap)
    {
        return false;
    }
    
    devicetype = apDeviceList[indexap].DeviceType;
    
    if(("Honor" == devicetype) || ("PT230" == devicetype))
    {
        for (var index = 0; index < WlanListNum; index++)
        {
            var wlanInst = getInstIdByDomain(WlanList[index].domain);
            
            if (isShowWlan(WlanList[index]) == false)
            {
                continue;
            }
            
            if('2.4GHz' == rfband)
            {
                if(-1 != WlanList[index].X_HW_RFBand.indexOf("5G"))  
                {
                    continue;
                } 
                
                if((checkwlanInst != wlanInst)&&(checkwlanInst != 0)) 
                { 
                    setDisable('ExtendedWLC_' + wlanInst, 1);
                }
            }
            
            if('5GHz' == rfband)
            {
                if(-1 != WlanList[index].X_HW_RFBand.indexOf("2.4G"))  
                {
                    continue;
                } 
                
                if((checkwlanInst != wlanInst)&&(checkwlanInst != 0))  
                { 
                    setDisable('ExtendedWLC_' + wlanInst, 1);
                }
            }
            
        }
    }
}

function IsBandCompatible(Wlanindex, wificoverApId)
{
    var WlanCapability = WlanList[Wlanindex].X_HW_RFBand;

    for (var i = 0; i < apNum; i++)
    {
        var ApInst = getInstIdByDomain(apDeviceList[i].domain);
        
        if (wificoverApId != ApInst)
        {
            continue;
        }
        
        var ApCapability = apDeviceList[i].SupportedRFBand;
        if ( ((-1 != WlanCapability.indexOf("2.4G")) && (-1 != ApCapability.indexOf("2.4G")))
             || ((-1 != WlanCapability.indexOf("5G")) && (-1 != ApCapability.indexOf("5G"))) )
        {
            return true;
        }
    }

    return false;
}


var curWorkMode = '';
function SetApDetail(wificoverApId)
{
    IsOnlyOneSsidExtSupport(wificoverApId);
    
    for (var index = 0; index < WlanListNum; index++)
    {
        var extEnable = 0;
        var wlanInst = getInstIdByDomain(WlanList[index].domain);
        var checkflag = 0;
        var checkwlanInst = 0;
        var rfband = '';
        
        for (var extWlcLoop = 0; extWlcLoop < apExtendedWLC.length - 1; extWlcLoop++)
        {
            var ApInstArray = apExtendedWLC[extWlcLoop].domain.split('.');
            var ApInst = ApInstArray[2];
            
            if (wificoverApId != ApInst)
            {
                continue;
            }
            else
            {
                if (wlanInst == apExtendedWLC[extWlcLoop].SSIDIndex)
                {    
                    rfband = WlanList[index].X_HW_RFBand
                    checkwlanInst = wlanInst;
                    checkflag = 1;
                    if(true == IsAuthEAP(index))
                    {
                        extEnable = 1;
                    }
                    break;
                }            
            }
        }
        
        setCheck('ExtendedWLC_' + wlanInst, extEnable);
            
        IsOnlyOneSsidExtEveryRFBandSupport(wificoverApId,checkflag,checkwlanInst,rfband);
                
        if (!IsBandCompatible(index, wificoverApId))
        {
            setDisable('ExtendedWLC_' + wlanInst, 1);
        }
    }    

    for (var i = 0; i < apNum; i++)
    {
        var ApInst = getInstIdByDomain(apDeviceList[i].domain);

        if (wificoverApId != ApInst)
        {
            continue;
        }
  
        curWorkMode = apDeviceList[i].WorkingMode; 

        break;
    }
}

var apDomain = "InternetGatewayDevice.X_HW_APDevice.1";
var wificoverApId = 1;
function setControl(ApInstId)
{
    wificoverApId = ApInstId;
    apDomain = "InternetGatewayDevice.X_HW_APDevice." + wificoverApId;
    SetApDetail(wificoverApId);
}

function setExtendedSubmit()
{
    if (DelSsidInstArray != '')
    {
        DelSsidInstArray = DelSsidInstArray.substring(0, DelSsidInstArray.length-1);
    }
    
    if (AddSsidInstArray != '')
    {
        AddSsidInstArray = AddSsidInstArray.substring(0, AddSsidInstArray.length-1);
    }
    
    if ((DelSsidInstArray == '') && (AddSsidInstArray != ''))
    {            
        $.ajax({
             type : "POST",
             async : true,
             cache : false,
             data : "y.ApInst="+wificoverApId+"&y.AddWlanInst="+AddSsidInstArray+"&x.X_HW_Token="+getValue('onttoken'),
             url : "set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverExtendedWlan&RequestFile=html/amp/wificovercfg/wifiCover.asp",
             success : function(data) {

             },
             complete: function (XHR, TS) {
                XHR=null;
                setDisable('btnApplySubmit', 0);
                setDisable('cancel', 0);

             }
        });
    }
    
    else if ((DelSsidInstArray != '') && (AddSsidInstArray == ''))
    {
        $.ajax({
             type : "POST",
             async : true,
             cache : false,
             data : "y.ApInst="+wificoverApId+"&y.DelExtendedWlInst="+DelSsidInstArray+"&x.X_HW_Token="+getValue('onttoken'),
             url : "set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverExtendedWlan&RequestFile=html/amp/wificovercfg/wifiCover.asp",
             success : function(data) {

             },
             complete: function (XHR, TS) {
                XHR=null;
                setDisable('btnApplySubmit', 0);
                setDisable('cancel', 0);

             }
        });
    }
    
    else if ((DelSsidInstArray != '') && (AddSsidInstArray != ''))
    {
        $.ajax({
             type : "POST",
             async : true,
             cache : false,
             data : "y.ApInst="+wificoverApId+"&y.AddWlanInst="+AddSsidInstArray+"&y.DelExtendedWlInst="+DelSsidInstArray+"&x.X_HW_Token="+getValue('onttoken'),
             url : "set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.SetWifiCoverExtendedWlan&RequestFile=html/amp/wificovercfg/wifiCover.asp",
             success : function(data) {
             },
             complete: function (XHR, TS) {
                XHR=null;
                setDisable('btnApplySubmit', 0);
                setDisable('cancel', 0);

             }
        });
    }
    else
    {
        setDisable('btnApplySubmit', 0);
        setDisable('cancel', 0);
    }
}
function ApplySubmit()
{

    var setAction_AddExtWlc = '';
    var setAction_DelExtWlc = '';
    AddSsidInstArray = '';
    DelSsidInstArray = '';

    for (var i = 0; i < WlanListNum; i++)
    {
        var exsitFlag = 0;
        var wlanInst =  WlanList[i].WlanInst;
        var j = 0;
        var DelWlcInst = 0;

        for (j = 0; j < apExtendedWLC.length - 1; j++)
        {
            var ApInstArray = apExtendedWLC[j].domain.split('.');
            var ApInst = ApInstArray[2];
            
            if (wificoverApId != ApInst)
            {
                continue;
            }

            if (wlanInst ==  apExtendedWLC[j].SSIDIndex)
            {
                DelWlcInst = getInstIdByDomain(apExtendedWLC[j].domain);

                exsitFlag = 1;
                break;
            }
        }

        if ( (1 == exsitFlag) && (0 == getCheckVal('ExtendedWLC_' + wlanInst)) )
        {
            var ExtWlcDomainDel = 'InternetGatewayDevice.X_HW_APDevice.' + wificoverApId + '.WifiCover.ExtendedWLC.' + DelWlcInst;
            setAction_DelExtWlc = setAction_DelExtWlc + '&Del_y_' + wlanInst + '=' + ExtWlcDomainDel;
            
            DelSsidInstArray =  DelSsidInstArray + DelWlcInst + ",";
        }

        if ( (0 == exsitFlag) && (1 == getCheckVal('ExtendedWLC_' + wlanInst)) )
        {
            var ExtWlcDomainAdd = 'InternetGatewayDevice.X_HW_APDevice.' + wificoverApId + '.WifiCover.ExtendedWLC';
            setAction_AddExtWlc = setAction_AddExtWlc + '&Add_z_' + wlanInst + '=' + ExtWlcDomainAdd;
            
            AddSsidInstArray =  AddSsidInstArray + wlanInst + ",";
        }
    }
    
    setDisable('btnApplySubmit', 1);
    setDisable('cancel', 1);
    setExtendedSubmit();
    window.location = 'wifiCover.asp';
    
}

function stIspSsid(domain, SSID_IDX)
{
    this.domain = domain;
    this.SSID_IDX = SSID_IDX;
}

var IspSsidList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForISP.{i}, SSID_IDX, stIspSsid);%>;

function IsIspSsid(wlanInst)
{
    for (var i = 0; i < IspSsidList.length - 1; i++)
    {
        if (wlanInst == IspSsidList[i].SSID_IDX)
        {
            return true;        
        }
    }

    return false;
}

function IsAwifiSsid(wlanInst)
{
    if (wlanInst == aWiFiSSID2GInst)
    {
        return true;        
    }
    return false;
}
function cancelValue()
{

    var j = 0;
    var i = 0;
    
    var devicetype = apDeviceList[wificoverApId-1].DeviceType;    
    
    for (i = 0; i < WlanListNum; i++)
    {
        var wlanInst =  WlanList[i].WlanInst;
        
        for (j = 0; j < apExtendedWLC.length - 1; j++)
        {
            var ApInstArray = apExtendedWLC[j].domain.split('.');
            var ApInst = ApInstArray[2];

            if (wificoverApId != ApInst)
            {
                continue;
            }

            if (wlanInst ==  apExtendedWLC[j].SSIDIndex)
            {
                setCheck('ExtendedWLC_' + wlanInst, 1);
                if(("Honor" == devicetype) || ("PT230" == devicetype))
                {
                    setDisable('ExtendedWLC_' + wlanInst, 0);
                }
        
                break;
            }
        }
        
        if (j == apExtendedWLC.length - 1)
        {
            setCheck('ExtendedWLC_' + wlanInst, 0);
            if(("Honor" == devicetype) || ("PT230" == devicetype))
            {
                setDisable('ExtendedWLC_' + wlanInst, 1);
            }
        }
    } 
 
}

var wlanInfo5GNum = 0;

function is5GSsidUsed(wlan)
{
    var wlanInst = getInstIdByDomain(wlan.domain);
    
    if (IsIspSsid(wlanInst)) {
        return true;
    } 
    
    if (IsAwifiSsid(wlanInst)) {
        return true;
    }
    
    if (wlanInst == fonssidinst.fonssid5g) {
        return true;
    }

    if (wlan.Enable == 1) {
        return true;
    }
    
    if (GuestWifiMap[wlanInst] != undefined) {
        return true;
    }
                                
    return false;
}

for (var i = 0; i < WlanList5G.length; i++) {
    if (is5GSsidUsed(WlanList5G[i])) {
        wlanInfo5GNum++;
    }
}

var FirstCfgApInst = 0;

function setUpSSIDDisabled(recordApInst)
{
    var ApInst = recordApInst.substring(7);
    
    if (apDeviceList.length == 1)
    {
        return;
    }

    for (var indexLoop = 0; indexLoop < apNum; indexLoop++)
    {
        var apInstTemp = getInstIdByDomain(apDeviceList[indexLoop].domain);
        if (apInstTemp == ApInst)
        {
            for (var index = 0; index < WlanListNum; index++)
            {
                var wlanInst = getInstIdByDomain(WlanList[index].domain);
                if (wlanInst == apDeviceList[indexLoop].UpAccessSsidInst)
                {
                    setDisable('ExtendedWLC_' + wlanInst, 1);
                    return;
                }
            }
        }
    }    
}

function setAscOverFlag()
{
    getAscOverFlag();
    if (1 == isAscOver)
    {
        setDisable('startAcsButton', 0);
        if(AscOverFlagHandle != undefined)
        {
           clearInterval(AscOverFlagHandle);
        }
    }
}

function setAscOverFlagHandle()
{
    if (1 == isAscOver)
    {
        setDisable('startAcsButton', 0);
    }
    else 
    {
        setDisable('startAcsButton', 1);
        AscOverFlagHandle = setInterval("setAscOverFlag();", 5000);
    }
}

function BindPsdModifyEvent(pwdId)
{
    if (wifiPasswordMask == '1' && getValue('wlWpaPsk') != "********" )
    {
        pskPsdModFlag = true;
    }
}

function setHomenetwork()
{
    initWlanInst2G();
    initWlanInst5G();
    if (1 == DoubleFreqFlag)
    {
        setDisplay('divBtn5G', 0);
        setDisplay('divTxt5G', 1);
        $("input[name = 'rml2G']").css('display', 'none');
        $("input[name = 'rml5G']").css('display', 'none');
    }
    else
    {
        setDisplay('divBtn5G', 1);
        setDisplay('divTxt5G', 0);
        
        if (!IsWlanAvailable())
        {
            setDisplay('divBtn2G', 1);
            setDisplay('divTxt2G', 0);
        }
        else
        {
            $("input[name = 'rml2G']").css('display', 'none');
        }
    }
    
    if (wifiPasswordMask == '1') {
        hidePwdInput();
    }
        
    setDisplay('divHomenetConfig', 1);

	if ('<%HW_WEB_GetFeatureSupport(WLAN_FEATURE_SINGLE_5G);%>' == 1) {
		setDisplay('Cover2GSsidSelect',0);
		setDisplay('basicSetting2G', 0);
	}

    if (!IsWlanAvailable())
    {
        setDisplay('divSyncWifiSwitch', 0);
    }
    if (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_NON_FIRST_SSID_FORBIDDON);%>')
    {
        if(0 == DoubleFreqFlag)
        {
            setDisplay('New5Gbutton', 0);
            setDisplay('Delete5GButton', 0);
            if (!IsWlanAvailable())
            {
                setDisplay('New2Gbutton', 0);
                setDisplay('Delete2GButton', 0);
            }
        }
    }
}

var wlantabId = 'tab1';
if (typeof top.wificover_tabid == 'undefined')
{
    top.wificover_tabid = 'tab1';
}

if (location.href.indexOf("&RequestFile=html/amp/wificovercfg/wifiCover.asp") > 0)
{
    wlantabId = top.wificover_tabid;
}

function IsUseBonding() {
    return false;
}

function SetBondingValue() {
    setCheck('BondingEnableSwitch', WifiCoverService[0].BondingEnable);
    setText('BondingRatio2G', WifiCoverService[0].BondingRatio2G);
    setText('BondingRatio5G', WifiCoverService[0].BondingRatio5G);
}

function DisplayBondingRatio(isDisplay) {
    setDisplay('bondingRatio2GTr', isDisplay);
    setDisplay('bondingRatio5GTr', isDisplay);
}

function InitBondingDom() {
    setDisplay ('bondingSwitchTr', 1);
    SetBondingValue();
    if (getCheckVal('BondingEnableSwitch') == 1) {
        DisplayBondingRatio(1);
    } else {
        DisplayBondingRatio(0);
    }
}

function BondingSwitchChange() {
    DisplayBondingRatio(getCheckVal('BondingEnableSwitch'));
}

function FitApDisable() {

    setDisable('UpnpEnable', 1);
    $("input[name='AutoExtendedPolicy']").attr('disabled',true);
    setDisable('Cover2GSsidSelect', 1);
    setDisable('Cover5GSsidSelect', 1);
    setDisable('SyncWifiSwitch', 1);
    setDisable('RETEnableSwitch', 1);
    setDisable('RTCP_port', 1);
    setDisable('RetSubmitButton', 1);
    setDisable('RetCancelButton', 1);
    setDisable('bandsteer0', 1);
    setDisable('bandsteer1', 1);
    setDisable('bandsteer2', 1);
    setDisable('applyButton', 1);
    setDisable('cancelButton', 1);
    setDisable('startAcsButton', 1);
    $("input[name='TopoAdjustPolicy']").attr('disabled',true);
    setDisable('rmlLowRateThrehold', 1);
    setDisable('rmlPacketLossRateThrehold', 1);
    setDisable('TopoAdjustPolicyApplyButton', 1);
    setDisable('TopoAdjustPolicyCancelButton', 1);
    setDisable('TopoAdjustSettingsApplyButton', 1);
    setDisable('TopoAdjustSettingsCancelButton', 1);
    setDisable('LowRateThrehold', 1);
    setDisable('PacketLossRateThrehold', 1);
}

function LoadFrame()
{ 
    LoadResource();
    setDefaultRssi();

    if (0 == apNum)
    {
        setDisplay('divApDetailCfg', 0);
    }
    else
    {
        setDisplay('divApDetailCfg', 1);
    }

    selectLine('record_' + FirstCfgApInst);
    setUpSSIDDisabled('record_' + FirstCfgApInst);
    
    setAscOverFlagHandle();
    
    if ((1 != DoubleFreqFlag) && (1 != isShowHomeNetWork))
    {
        $(".5GClass").hide();
    }

    if (fttrFlag == 1) {
        initWlanInstIotSsid();
        setDisplay('iotSsidSetting2G', 1);
        setDisable('NewIotbutton', 0);
        setDisable('DeleteIotButton', 1);
        setDisable('ModifyIotbutton', 1);
        if (iotSsidInst != 0) {
            setDisable('NewIotbutton', 1);
            setDisable('DeleteIotButton', 0);
            setDisable('ModifyIotbutton', 0);
        }
    }

    if (1 == isShowHomeNetWork)
    {
        setHomenetwork();
    }

    if (curUserType === '0' && IspSsidList.length > 1) {
        setDisplay('trPublicWiFi', 1);
    }
    
    SetDefaultAdjustPolicy();
    switchTab(wlantabId);
    
    if ((1 != DoubleFreqFlag) || (0 == retserver_exist))
    {
        setDisplay("tableRETEnableSwitch", 0);
        setDisplay("tableRtcp", 0);
    }
    else 
    {
        setText('RTCP_port', WifiCoverService[0].RETRtcpPort);
    }
    if((vdfFlag == false) && (fttrFlag == false) && (supportForceKickSta != 1))
    {
        setDisplay("WifiCoverSwitchForm", 0);
    }
    else
    {
        setDisplay("WifiSensitivityForm", 0);
    }

    if (rosunionGame == 1) {
        $('.tabal_01').css('text-align', 'left');
        $("#WifiCoverCfgForm").find('td').each(function (j, item) {
            $(item).addClass('rosTableBorderBottom');
        });

        $("#DivAdvSettings").find('td').each(function (j, item) {
            $(item).addClass('rosTableBorderBottom');
        });

        $("#tableTopoAdjustSettings").find('td').each(function (j, item) {
            $(item).addClass('rosTableBorderBottom');
        });
    }

    if ((fttrFlag == 1) && (isBponFlag != 1)) {
        $("#space5gDiv").css('height', '40px');
        $("#spacePolicyDiv").css('height', '40px');
        if (DoubleFreqFlag != 1) {
            FttrHideButton('5G');
            if (noWiFiChipFlag == 1) {
                FttrHideButton('2G');
            }
        }
    }

    if (fttrFlag == 1) {
        setDisable('UpnpEnable', 1);
    }

    if (IsUseBonding()) {
        InitBondingDom();
    }

    if (scnFT == 1) {
        setDisplay("divScnEnable", 1);
        setCheck("EnableScnBox", scnVar);
        if (scnVar == 1) {
            setDisable("Cover2GSsidSelect", 1);
            setDisable("Cover5GSsidSelect", 1);
        }
    }
	if ((typeWord != "V8XXC") && (typeWord != "CDN")) {
		setDisplay("divLiveCtlSwitch", 0);
		setDisplay("divLiveCtlValue", 0);
	} else {
		setCheck("LiveCoverEnable", liveAccessContol[0].LiveModeEnable);
		setText("LiveAccessThrehold", liveAccessContol[0].IntensityThreshold);
	}

    if (isFitAp == 1) {
        FitApDisable();
    }
}

function FttrHideButton(lowerLayer) {
    if (lowerLayer == "5G") {
        if(isBponFlag != 1) {
            modifySSIDTr('5G');
            setDisplay('Modify5Gbutton', 0);
        }
        setDisable("New5Gbutton", 0);
        setDisable('Delete5GButton', 1);
    } else {
        if (noWiFiChipFlag == 1) {
            if(isBponFlag != 1) {
                modifySSIDTr('2G');
                setDisplay('Modify2Gbutton', 0);
            }
            setDisable("New2Gbutton", 0);
            setDisable('Delete2GButton', 1);
        }
    }
}

function SyncWifiSwitch()
{
    var Form = new webSubmitForm();
    Form.addParameter('x.SyncWifiSwitch', getCheckVal('SyncWifiSwitch'));
    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function SyncWifiSwitch_vdf()
{
    var Form = new webSubmitForm();
    Form.addParameter('x.SyncWifiSwitch', getCheckVal('SyncWifiSwitch_vdf'));
    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function CheckRtcpPortSettings()
{
    var RtcpPortVal = getValue('RTCP_port');
    
    if(!isInteger(RtcpPortVal))
    {
        AlertEx(wificovercfg_language['amp_rtcpport_int']);
        return false;
    }

    if( (parseInt(RtcpPortVal,10) < 1) || (parseInt(RtcpPortVal,10) > 65535)  )
    {
        AlertEx(wificovercfg_language['amp_rtcpport_out_range']);
        return false;
    }
    
    return true;
}

function CheckRetChg()
{
    var findflag = 0;
    
    for (var indexLoop = 0; indexLoop < apNum; indexLoop++)
    {
        var upssid = apDeviceList[indexLoop].UpAccessSsidInst;
        var synstatus = apDeviceList[indexLoop].SyncStatus;
        if ((synstatus == 3) && (upssid != 0))
        {
            findflag = 1;
            break;
        }
    }

    if (1 == findflag)
    {
         if (false == ConfirmEx(wificovercfg_language['amp_retswitch_chg_explain']))
         {
            return false;
         }
    }
    
    return true;
}

function CheckBondingRatio() {
    var bondingRatio2G = getValue('BondingRatio2G');
    var bondingRatio5G = getValue('BondingRatio5G');
    if (!isInteger(bondingRatio2G)) {
        AlertEx(wificovercfg_language['amp_bondingRatio2G_int']);
        return false;
    }

    if ((parseInt(bondingRatio2G, 10) < 1) || (parseInt(bondingRatio2G, 10) > 5)) {
        AlertEx(wificovercfg_language['amp_bondingRatio2G_out_range']);
        return false;
    }
    
    if (!isInteger(bondingRatio5G)) {
        AlertEx(wificovercfg_language['amp_bondingRatio5G_int']);
        return false;
    }

    if ((parseInt(bondingRatio5G, 10) < 1) || (parseInt(bondingRatio5G, 10) > 5)) {
        AlertEx(wificovercfg_language['amp_bondingRatio5G_out_range']);
        return false;
    }

    return true;
}

function RETEnableOpeSwitch()
{
    var Form = new webSubmitForm();
    
    if (false == CheckRtcpPortSettings())
    {
        return;
    }
    
    if (WifiCoverService[0].RETEnable != getCheckVal('RETEnableSwitch'))
    {
        if (false == CheckRetChg())
        {
            return;
        }
    }

    if (IsUseBonding()) {
        if (!CheckBondingRatio()) {
            return;
        }
    }

    setDisable('RetSubmitButton', 1);
    setDisable('RetCancelButton', 1);
    
    Form.addParameter('x.RETEnable', getCheckVal('RETEnableSwitch'));
    Form.addParameter('x.RETRtcpPort', getValue('RTCP_port'));

    if (IsUseBonding()) {
        Form.addParameter('x.BondingEnable', getCheckVal('BondingEnableSwitch'));
        Form.addParameter('x.BondingRatio2G', getValue('BondingRatio2G'));
        Form.addParameter('x.BondingRatio5G', getValue('BondingRatio5G'));
    }

    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function RETEnableCancel()
{
    setCheck('RETEnable', WifiCoverService[0].RETEnable);
    setText('RTCP_port', WifiCoverService[0].RETRtcpPort);

    if (IsUseBonding()) {
        InitBondingDom();
    }
}

function IsAuthEAP(index)
{  
    AssignEncrypt(WlanList[index]);
    
    if (Auth == 'EAPAuthentication') {
        return false;
    }
    
    return true;
}

function setCheckDisable(id)
{
    var wlanInst = id.substring(id.length-1);
    var rfband = 0;
    var devicetype = apDeviceList[wificoverApId-1].DeviceType;    
    
    for(var j = 0;j < WlanListNum; j++)
    {
        if(wlanInst == getInstIdByDomain(WlanList[j].domain))
        {
            if(false == IsAuthEAP(j))
            {
                if(1 == getCheckVal('ExtendedWLC_' + wlanInst))
                {
                    AlertEx(wificovercfg_language['amp_wificover_config_wlan_eap_auth']);
                    setCheck('ExtendedWLC_' + wlanInst,0);
                }
            }
            rfband = WlanList[j].LowerLayers.substring(WlanList[j].LowerLayers.length-1);
        }
    }
    
    if(("Honor" == devicetype) || ("PT230" == devicetype))
    {    
        if('1' == rfband)
        {
            if (1 == getCheckVal(id))
            {
                for(var index = 0;index < WlanListNum; index++)
                {
                    var wlanIndex = getInstIdByDomain(WlanList[index].domain);
                    
                    if (IsIspSsid(wlanIndex))
                    {
                        continue ;
                    } 
                    if(IsAwifiSsid(wlanIndex))
                    {
                        continue ;
                    }
                                    if ((wlanInst == fonssidinst.fonssid2g) || (wlanInst == fonssidinst.fonssid5g))
                                    {
                                        continue;
                                    }
                    if(1 != WlanList[index].X_HW_ServiceEnable)
                    {
                        continue;
                    }
                    
                    if (-1 != WlanList[index].X_HW_RFBand.indexOf("5G"))
                    {
                        continue;
                    }  
                    
                    if(wlanIndex != wlanInst)
                    {
                        setDisable('ExtendedWLC_' + wlanIndex, 1);
                    }
                }
            }
            else
            {
                for(var index = 0;index < WlanListNum; index++)
                {
                    var wlanIndex = getInstIdByDomain(WlanList[index].domain);
                    
                    if (IsIspSsid(wlanIndex))
                    {
                        continue ;
                    } 
                    if(IsAwifiSsid(wlanIndex))
                    {
                        continue ;
                    } 
                                    if ((wlanInst == fonssidinst.fonssid2g) || (wlanInst == fonssidinst.fonssid5g))
                                    {
                                        continue;
                                    }
                    if(1 != WlanList[index].X_HW_ServiceEnable)
                    {
                        continue;
                    }
                    
                    if (-1 != WlanList[index].X_HW_RFBand.indexOf("5G"))
                    {
                        continue;
                    }  
                    
                    setDisable('ExtendedWLC_' + wlanIndex, 0);
                }
            }
        }
        
        if('2' == rfband)
        {
            if (1 == getCheckVal(id))
            {
                for(var index = 0;index < WlanListNum; index++)
                {
                    var wlanIndex = getInstIdByDomain(WlanList[index].domain);
                    
                    if (IsIspSsid(wlanIndex))
                    {
                        continue ;
                    } 
                    if(IsAwifiSsid(wlanIndex))
                    {
                        continue ;
                    }
                                    if ((wlanInst == fonssidinst.fonssid2g) || (wlanInst == fonssidinst.fonssid5g))
                                    {
                                        continue;
                                    }
                    if(1 != WlanList[index].X_HW_ServiceEnable)
                    {
                        continue;
                    }
        
                    if (-1 != WlanList[index].X_HW_RFBand.indexOf("2.4G"))
                    {
                        continue;
                    }  
                    
                    if(wlanIndex != wlanInst)
                    {
                        setDisable('ExtendedWLC_' + wlanIndex, 1);
                    }
                }
            }
            else
            {
                for(var index = 0;index < WlanListNum; index++)
                {
                    var wlanIndex = getInstIdByDomain(WlanList[index].domain);
                    
                    if (IsIspSsid(wlanIndex))
                    {
                        continue ;
                    } 
                    if(IsAwifiSsid(wlanIndex))
                    {
                        continue ;
                    } 
                                    if ((wlanInst == fonssidinst.fonssid2g) || (wlanInst == fonssidinst.fonssid5g))
                                    {
                                        continue;
                                    }
                    if (-1 != WlanList[index].X_HW_RFBand.indexOf("2.4G"))
                    {
                        continue;
                    }  

                    setDisable('ExtendedWLC_' + wlanIndex, 0);
                }
            }
        }
    }
}

function LiveCoverEnableSubmit()
{
    var Form = new webSubmitForm();
    if (getCheckVal('LiveCoverEnable') == true) {
        if (ConfirmEx(wificovercfg_language['amp_wificover_config_live_access_control_explan']) == false) {
            setCheck('LiveCoverEnable', 0)
            return;
        }
    }

    Form.addParameter('x.LiveModeEnable', getCheckVal('LiveCoverEnable'));
    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService.LiveAccessControl'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function LiveCoverSubmit()
{
    var Form = new webSubmitForm();

	var LiveAccessThrehold = getValue('LiveAccessThrehold');
    if(!isInteger(LiveAccessThrehold)) {
        AlertEx(wificovercfg_language['amp_wifiCover_live_acess_RssiThreshold_int']);
        return;
    }
	
	if ((parseInt(LiveAccessThrehold, 10) > 0) || (parseInt(LiveAccessThrehold, 10) < -100)) {
        AlertEx(wificovercfg_language['amp_wifiCover_live_acess_RssiThreshold_range']);
        return;	
	}

	Form.addParameter('x.IntensityThreshold', LiveAccessThrehold);
    Form.setAction('set.cgi?'
                    + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService.LiveAccessControl'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function LiveCoverCancel()
{
	setText("LiveAccessThrehold", liveAccessContol[0].IntensityThreshold);
}

function HwAjaxStartAcs()
{
      $.ajax({
        type : "POST",
        async : true,
        cache : false,
        url : './WifiCoverOper.cgi?WifiCoverOper=EnforceACS&RequestFile=html/amp/wificovercfg/wifiCover.asp',
        data :'x.X_HW_Token=' + getValue('onttoken'),
        success : function(data) {
            getAscOverFlag();
            setAscOverFlagHandle();
        }
    });
}

function startAcsSubmit()
{
    if (ConfirmEx(wificovercfg_language['amp_wificover_acsprompt']) == false)
    {
        return false;
    }
    setDisable('startAcsButton', 1);
    HwAjaxStartAcs();
}

function showDivAdvSettings(show)
{    
    setDisplay('btnShowAdvSettings', !show);
    setDisplay('btnHideAdvSettings', show);
    setDisplay('DivAdvSettings', show);
}

function getRadioValue(sId)
{
    var item;
    if (null == (item = getElement(sId)))
    {
        debug(sId + " is not existed" );
        return -1;
    }

    if (item.length > 0)
    {
        for (i = 0; i < item.length; i++)
        {
            if (item[i].checked == true)
            {
            return item[i].value;
            }
        }
    }
    else if (item.checked == true)
    {
        return item.value;
    }

    return -1;
}

var AddFlag = true;
var selValIndex = -1;
function setSSIDBtnEnable(isModifySSID)
{
    if (noWiFiChipFlag == 1) {
        setSSIDBtnEnableFttr(isModifySSID);
        return;
    }

    var lowerLayer = thisLowerLayer;
    var otherLayer = ((lowerLayer == '2G') || (lowerLayer == "Iot")) ? '5G' : '2G'; 
    setDisplay('divButton' + lowerLayer, isModifySSID);
    setDisable('New' + lowerLayer + 'button', isModifySSID);
    setDisable('Modify' + lowerLayer + 'button', isModifySSID);
    setDisable('Delete' + lowerLayer + 'Button', isModifySSID);

    setDisable('New' + otherLayer + 'button', isModifySSID);
    setDisable('Modify' + otherLayer + 'button', isModifySSID);
    setDisable('Delete' + otherLayer + 'Button', isModifySSID);

    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        setDisable('New' + lowerLayer + 'button', 0);
        setDisable('Modify' + lowerLayer + 'button', 0);
        setDisable('Delete' + lowerLayer + 'Button', 0);

        setDisable('New' + otherLayer + 'button', 0);
        setDisable('Modify' + otherLayer + 'button', 0);
        setDisable('Delete' + otherLayer + 'Button', 0);
    }
}

function setSSIDBtnEnableFttr(index) {
    var lowerLayer = thisLowerLayer;
    var otherLayer = (lowerLayer == '2G') ? '5G' : '2G'; 
    setDisplay('divButton' + lowerLayer, index);
    if (AddFlag == true) {
        setDisable('Delete' + lowerLayer + 'Button', 1);
    } else {
        if (index == 1 && getRadioValue("rml" + lowerLayer) != "ssid.0") {
            setDisable('Delete' + lowerLayer + 'Button', 0);
        } else {
            setDisable('Delete' + lowerLayer + 'Button', 1);
        }
    }
}

var SsidNum2g = WlanList2G.length;
var SsidNum5g = WlanList5G.length;

function setPwdEqule(pwdId)
{
    var idIndex = pwdId.substring(0, pwdId.lastIndexOf('_'));
    var pwdValue = getValue(pwdId);
    if (pwdId.indexOf('_txt') > 0)
    {
        setText(idIndex + '_pwd', pwdValue);
    }
    else
    {
        setText(idIndex + '_txt', pwdValue);
    }
}

function addSSIDTr(lowerLayer)
{
    thisLowerLayer = lowerLayer;
    var ssidNum = (lowerLayer == '2G') ? SsidNum2g : SsidNum5g;
    if (ssidNum == SsidPerBand)
    {
        if (SsidPerBand == 4)
        {
            AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);    
        }
        else
        {
            AlertEx(cfg_wlancfgother_language['amp_ssid_8max']);    
        }
        
        return;
    }

    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        if (lowerLayer == '5G') {
            FttrUnModefy('5G');
        } else {
            if (noWiFiChipFlag == 1) {
                FttrUnModefy('2G');
            }
        }
    }

    AddFlag = true;
    var ratioName = 'rml' + lowerLayer;
    var trId = 'tr' + lowerLayer + '_Ssid_' + ssidNum;
    var txtSsid = 'Ssid' + lowerLayer + '_text_' + ssidNum;
    var selwlHideId = 'Ssid' + lowerLayer + '_wlHide_' + ssidNum;
    var selwlAuthId = 'Ssid' + lowerLayer + '_wlAuth_' + ssidNum;
    var selwlEncryId = 'Ssid' + lowerLayer + '_wlEncry_' + ssidNum;
    var idIndex = 'wlPsk' + lowerLayer + '_' + ssidNum;
    var tabWlanId = 'wlanInst' + lowerLayer;
    var selEnable = 'Ssid' + lowerLayer + '_Enable_' + ssidNum;
    var selDeviceNum = 'Ssid' + lowerLayer + '_DeviceNum_' + ssidNum;
    
    setSSIDBtnEnable(1);
    $("input[name =" + ratioName + "]").removeAttr('checked');

    var trHtml = '<tr class="tabal_01 align_center ssid_detail' + lowerLayer + '" id="' + trId + '">';     
    trHtml += '<td><input type="radio" name=' + ratioName + ' id="rml" value="ssid.' + ssidNum + '" checked onClick="ModifyForRadio(this)"></td>';
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        trHtml += '<td>--</td>'; 
    }
    trHtml += '<td style="word-wrap:break-word;"><input type="text" id="' + txtSsid 
           +'" style = "width:80px" maxlength="32"></td>'; 
    trHtml += '<td><select style = "width:50px" id =' + selwlHideId +'><option value="1">' 
           + wificovercfg_language['amp_homenetwork_bcast_enable'] + '</option><option value="0">' 
           + wificovercfg_language['amp_homenetwork_bcast_disable'] + '</option></select></td>'; 
    trHtml += '<td><select style = "width:80px" id =' + selwlAuthId +' onchange="ChangeMode(this.id);"><option value="OPEN">' 
           + authMap['OPEN'] + '</option>';
    if ((noWiFiChipFlag != 1) || (isBponFlag == 1)) {
        trHtml += '<option value="WPA-Personal">' + authMap['WPA-Personal'] + '</option>';
    }
    trHtml += '<option value="WPA2-Personal">' + authMap['WPA2-Personal'] + '</option><option value="WPA-WPA2-Personal">' + 
              authMap['WPA-WPA2-Personal'] + '</option>';
    if ((cap11ax == 1) || ((isBponFlag == 1) && (noWiFiChipFlag == 1))) {
        trHtml += '<option value="WPA3-Personal">' + authMap['WPA3-Personal'] + '</option><option value="WPA2-WPA3-Personal">' + 
                  authMap['WPA2-WPA3-Personal'] +'</option>'; 
    }
    trHtml += '</select></td>';

    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        trHtml += '<td><select style = "width:80px" id =' + selwlEncryId +'>';
        trHtml += '<option value="AESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_aes'] + '</option> ' + 
                  '<option value="TKIPEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_tkip'] + '</option>' + 
                  '<option value="TKIPandAESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_tkipaes'] + '</option>';
        trHtml += '</select></td>';
    }

    trHtml += '<td style="word-wrap:break-word;width:140px"><input id=' + idIndex + '_txt' 
           + ' type="text" class="amp_font" style="width:105px;display:none" onchange="setPwdEqule(this.id);" /><input id=' 
           + idIndex + '_pwd' + ' type="password" class="amp_font" style="width:105px;" onchange="setPwdEqule(this.id);' 
           + ' BindPsdModifyEvent(this.id);" /><input checked type="checkbox" id=' 
           + idIndex + ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);" /><span id ="hideId1">'
           + wificovercfg_language['amp_homenetwork_hide'] + '</span></td>';
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        trHtml +='<td><input type="text" style="width:30px;" id="' + selDeviceNum + '" name="deviceNum"/> </td>';
        trHtml +='<td><input type="checkbox" id="' + selEnable + '" name="enable"/> </td>';
    }
    trHtml += '</tr>';

    $("#" + tabWlanId).append(trHtml);

    $("input[name = " + ratioName + "]").attr('disabled', true);
    if (viettelPrefixFlag == 1) {
        setText(txtSsid, 'VIETTEL_' + GetRandomNum(4));
    }

    if ((fttrFlag == 1) && (DoubleFreqFlag != 1) && (lowerLayer == '2G')) {
        setDisable('Delete2GButton', 1);
        setDisable('New2Gbutton', 1);
    }

    if ((fttrFlag == 1) && (DoubleFreqFlag != 1) && (lowerLayer == '5G')) {
        setDisable('Delete5GButton', 1);
        setDisable('New5Gbutton', 1);
    }

    selValIndex = ssidNum;
    ChangeMode(selwlAuthId);
}

function getAll2GSSIDNum()
{
    var currentWlanList = [];
    $.ajax({
        type : "post",
        async : false,
        cache : false,
        url : "./getSsidlist.asp",
        success : function(data) {
            currentWlanList = dealDataWithFun(data);
        }
    });

    var All2GSSID = new Array();
    for (var i = 0; i < currentWlanList.length - 1; i++ ) {
        var athindex = getWlanPortNumber(currentWlanList[i].Name);
        if (( athindex >= 0 )&&( athindex <= ssidEnd2G )) {
            All2GSSID.push(currentWlanList[i]);
        }
    }
    return All2GSSID.length;
}

function addIotSSIDTr(lowerLayer)
{
    thisLowerLayer = lowerLayer;
    var ssidNum = getAll2GSSIDNum();
    if ((ssidNum == SsidPerBand) && (iotAutoSsidInst == 0)) {
        AlertEx(cfg_wlancfgother_language['amp_ssid_4max']);
        return;
    }

    AddFlag = true;
    var ratioName = 'rml' + lowerLayer;
    var trId = 'tr' + lowerLayer + '_Ssid_' + ssidNum;
    var txtSsid = 'Ssid' + lowerLayer + '_text_' + ssidNum;
    var selwlHideId = 'Ssid' + lowerLayer + '_wlHide_' + ssidNum;
    var selwlAuthId = 'Ssid' + lowerLayer + '_wlAuth_' + ssidNum;
    var idIndex = 'wlPsk' + lowerLayer + '_' + ssidNum;
    var tabWlanId = 'wlanInst' + lowerLayer;
    
    setSSIDBtnEnable(1);
    $("input[name =" + ratioName + "]").removeAttr('checked');

    var trHtml = '<tr class="tabal_01 align_center ssid_detail' + lowerLayer + '" id="' + trId + '">';     
    trHtml += '<td><input type="radio" name=' + ratioName + ' id="rml" value="ssid.' + ssidNum + '" checked onClick="ModifyForRadio(this)"></td>';
    trHtml += '<td style="word-wrap:break-word;"><input type="text" id="' + txtSsid 
           +'" style = "width:80px" maxlength="32"></td>'; 
    trHtml += '<td><select style = "width:50px" id =' + selwlHideId +'><option value="1">' 
           + wificovercfg_language['amp_homenetwork_bcast_enable'] + '</option><option value="0">' 
           + wificovercfg_language['amp_homenetwork_bcast_disable'] + '</option></select></td>'; 
    trHtml += '<td><select style = "width:80px" id =' + selwlAuthId +'><option value="OPEN">' 
           + authMap['OPEN'] + '</option>';
    if (noWiFiChipFlag != 1) {
        trHtml += '<option value="WPA-Personal">' + authMap['WPA-Personal'] + '</option>';
    }
    trHtml += '<option value="WPA2-Personal">' + authMap['WPA2-Personal'] + '</option><option value="WPA-WPA2-Personal">' + 
              authMap['WPA-WPA2-Personal'] + '</option>';
    if (cap11ax == 1) {
        trHtml += '<option value="WPA3-Personal">' + authMap['WPA3-Personal'] + '</option><option value="WPA2-WPA3-Personal">' + 
                  authMap['WPA2-WPA3-Personal'] +'</option>'; 
    }
    trHtml += '</select></td>';

    trHtml += '<td style="word-wrap:break-word;"><input id=' + idIndex + '_txt' 
           + ' type="text" class="amp_font" style="width:105px;display:none" onchange="setPwdEqule(this.id);" /><input id=' 
           + idIndex + '_pwd' + ' type="password" class="amp_font" style="width:105px;" onchange="setPwdEqule(this.id);' 
           + ' BindPsdModifyEvent(this.id);" /><input checked type="checkbox" id=' 
           + idIndex + ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);" />' 
           + wificovercfg_language['amp_homenetwork_hide'] + '</td>';
    trHtml += '</tr>';

    $("#" + tabWlanId).append(trHtml);

    $("input[name = " + ratioName + "]").attr('disabled', true);
    selValIndex = ssidNum;
}

function ltrim(str)
{ 
 return str.toString().replace(/(^\s*)/g,""); 
}

function AddParaForCover(Form, domain)
{
    var lowerLayer = thisLowerLayer;
    var ssid;
    ssid = getValue('Ssid' + lowerLayer + '_text_' + selValIndex);    
    Form.addParameter('w.SSID',ltrim(ssid));
    
    var wlanDomain = domain;
    var wlanInstId = getInstIdByDomain(wlanDomain);
    Form.addParameter('w.SsidInst',wlanInstId);
    
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        Form.addParameter('w.Enable', getCheckVal('Ssid' + lowerLayer + '_Enable_' + selValIndex));
        Form.addParameter('w.MaxAssociateNum', getValue('Ssid' + lowerLayer + '_DeviceNum_' + selValIndex));
    } else {
        Form.addParameter('w.Enable',1);
    }

    Form.addParameter('w.WMMEnable',1);
    Form.addParameter('w.SSIDAdvertisementEnabled',getSelectVal('Ssid' + lowerLayer + '_wlHide_' + selValIndex));
    
    var authEncry = getValue('Ssid' + lowerLayer + '_wlAuth_' + selValIndex);
    var encryValue = getValue('Ssid' + lowerLayer + '_wlEncry_' + selValIndex);
    if (authEncry == 'OPEN')
    {
        Form.addParameter('w.BeaconType','Basic');
        Form.addParameter('w.BasicAuthenticationMode','None');
        Form.addParameter('w.BasicEncryptionModes','None');
    }
    else
    {
        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var authAddData = { 'WPA-Personal' : ['WPA', 'WPAAuthenticationMode', 'WPAEncryptionModes', encryValue, 'PSKAuthentication'], 
                                'WPA2-Personal' : ['11i', 'IEEE11iAuthenticationMode', 'IEEE11iEncryptionModes', encryValue, 'PSKAuthentication'], 
                                'WPA-WPA2-Personal' : ['WPAand11i', 'MixAuthenticationMode', 'MixEncryptionModes', encryValue, 'PSKAuthentication'], 
                                'WPA3-Personal' : ['WPA3', 'MixAuthenticationMode', 'MixEncryptionModes', encryValue, 'SAEAuthentication'], 
                                'WPA2-WPA3-Personal' : ['WPA2/WPA3', 'MixAuthenticationMode', 'MixEncryptionModes', encryValue, 'PSKandSAEAuthentication']
                              };
        } else {
            var authAddData = { 'WPA-Personal' : ['WPA', 'WPAAuthenticationMode', 'WPAEncryptionModes', 'TKIPEncryption', 'PSKAuthentication'], 
                                'WPA2-Personal' : ['11i', 'IEEE11iAuthenticationMode', 'IEEE11iEncryptionModes', 'AESEncryption', 'PSKAuthentication'], 
                                'WPA-WPA2-Personal' : ['WPAand11i', 'MixAuthenticationMode', 'MixEncryptionModes', 'TKIPandAESEncryption', 'PSKAuthentication'], 
                                'WPA3-Personal' : ['WPA3', 'MixAuthenticationMode', 'MixEncryptionModes', 'AESEncryption', 'SAEAuthentication'], 
                                'WPA2-WPA3-Personal' : ['WPA2/WPA3', 'MixAuthenticationMode', 'MixEncryptionModes', 'AESEncryption', 'PSKandSAEAuthentication']
                              };
        }

        if (authAddData.hasOwnProperty(authEncry)) {
            Form.addParameter('w.BeaconType', authAddData[authEncry][0]);
            Form.addParameter('w.' + authAddData[authEncry][1], authAddData[authEncry][4]);
            Form.addParameter('w.' + authAddData[authEncry][2], authAddData[authEncry][3]);
        }

        var value = '';
        var wlPskID = 'wlPsk' + lowerLayer + '_' + selValIndex;
        if (1 == getCheckVal(wlPskID))
        {
            value = getValue(wlPskID + '_pwd');
        }
        else
        {
            value = getValue(wlPskID + '_txt');
        }
        if (wifiPasswordMask == '1')
        {
            if ( (value != "********") || (pskPsdModFlag == true) )
            {
                Form.addParameter('w.Key',value);
            }             
        }
        else
        {
            Form.addParameter('w.Key',value);
        }        
    }

    return true;
}

var addSSID = '';
function ajaxAddParameter1()
{
    var lowerLayer = thisLowerLayer;
    var addSsidNum = selValIndex;
    var thisWlanList = ((lowerLayer == '2G') || (lowerLayer == "Iot")) ? WlanList2G : WlanList5G;
    var ssid = getValue('Ssid' + lowerLayer + '_text_' + addSsidNum);
    var deviceNum = getValue('Ssid' + lowerLayer + '_DeviceNum_' + selValIndex);
    ssid = ltrim(ssid);

    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        if (deviceNum == "") {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }

        if (!CheckNumber(deviceNum, 1, 64)) {
            AlertEx(cfg_wlancfgother_language['amp_dev_num_64']);
            return false;
        }
    }
    
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
    
    if('E8C' != CurrentBin.toUpperCase() && (isBponFlag != 1) && (curLanguage.toUpperCase() != "CHINESE"))
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
    
    for (i = 0; i < thisWlanList.length; i++)
    {    
        if (addSsidNum != i)
        {
            if (thisWlanList[i].ssid == ssid)
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

    addSSID = ssid;
}

function addParameter1(Form)
{
    var lowerLayer = thisLowerLayer;
    var thisWlanList = ((lowerLayer == '2G') || (lowerLayer == "Iot")) ? WlanList2G : WlanList5G;
    var deviceNum = getValue('Ssid' + lowerLayer + '_DeviceNum_' + selValIndex);
    Form.addParameter('y.SSIDAdvertisementEnabled',getSelectVal('Ssid' + lowerLayer + '_wlHide_' + selValIndex));

    var ssid = getValue('Ssid' + lowerLayer + '_text_' + selValIndex);
    ssid = ltrim(ssid);

    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        if (deviceNum == "") {
            AlertEx(cfg_wlancfgother_language['amp_empty_para']);
            return false;
        }
        if (!CheckNumber(deviceNum, 1, 64)) {
            AlertEx(cfg_wlancfgother_language['amp_dev_num_64']);
            return false;
        }
    }
    
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
    
    if ('E8C' != CurrentBin.toUpperCase() && (isBponFlag != 1) && (curLanguage.toUpperCase() != "CHINESE"))
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

    for (i = 0; i < thisWlanList.length; i++)
    {    
        if (selValIndex != i)
        {
            if (thisWlanList[i].ssid == ssid)
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

    Form.addParameter('y.SSID',ssid);
}

function addParameter2(Form)
{
    var lowerLayer = thisLowerLayer;
    var authEncry = getValue('Ssid' + lowerLayer + '_wlAuth_' + selValIndex);
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        Form.addParameter('y.Enable', getCheckVal('Ssid' + lowerLayer + '_Enable_' + selValIndex));
        Form.addParameter('y.X_HW_AssociateNum', getValue('Ssid' + lowerLayer + '_DeviceNum_' + selValIndex));
    }
    if (authEncry == 'OPEN')
    {
        Form.addParameter('y.BeaconType','Basic');
        Form.addParameter('y.BasicAuthenticationMode','None');
        Form.addParameter('y.BasicEncryptionModes','None');
    }
    else
    {
        var value = '';
        var wlPskID = 'wlPsk' + lowerLayer + '_' + selValIndex;
        if (1 == getCheckVal(wlPskID))
        {
            value = getValue(wlPskID + '_pwd');
        }
        else
        {
            value = getValue(wlPskID + '_txt');
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

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var encryValue = getValue('Ssid' + lowerLayer + '_wlEncry_' + selValIndex);
            var authAddData = { 'WPA-Personal' : ['WPA', 'WPAAuthenticationMode', 'WPAEncryptionModes', encryValue, 'PSKAuthentication'], 
                              'WPA2-Personal' : ['11i', 'IEEE11iAuthenticationMode', 'IEEE11iEncryptionModes', encryValue, 'PSKAuthentication'], 
                              'WPA-WPA2-Personal' : ['WPAand11i', 'X_HW_WPAand11iAuthenticationMode', 'X_HW_WPAand11iEncryptionModes', encryValue, 'PSKAuthentication'], 
                              'WPA3-Personal' : ['WPA3', 'X_HW_WPAand11iAuthenticationMode', 'X_HW_WPAand11iEncryptionModes', encryValue, 'SAEAuthentication'], 
                              'WPA2-WPA3-Personal' : ['WPA2/WPA3', 'X_HW_WPAand11iAuthenticationMode', 'X_HW_WPAand11iEncryptionModes', encryValue, 'PSKandSAEAuthentication']
                            };
        } else {
            var authAddData = { 'WPA-Personal' : ['WPA', 'WPAAuthenticationMode', 'WPAEncryptionModes', 'TKIPEncryption', 'PSKAuthentication'], 
                              'WPA2-Personal' : ['11i', 'IEEE11iAuthenticationMode', 'IEEE11iEncryptionModes', 'AESEncryption', 'PSKAuthentication'], 
                              'WPA-WPA2-Personal' : ['WPAand11i', 'X_HW_WPAand11iAuthenticationMode', 'X_HW_WPAand11iEncryptionModes', 'TKIPandAESEncryption', 'PSKAuthentication'], 
                              'WPA3-Personal' : ['WPA3', 'X_HW_WPAand11iAuthenticationMode', 'X_HW_WPAand11iEncryptionModes', 'AESEncryption', 'SAEAuthentication'], 
                              'WPA2-WPA3-Personal' : ['WPA2/WPA3', 'X_HW_WPAand11iAuthenticationMode', 'X_HW_WPAand11iEncryptionModes', 'AESEncryption', 'PSKandSAEAuthentication']
                            };
        }

        if (authAddData.hasOwnProperty(authEncry)) {
            Form.addParameter('y.BeaconType', authAddData[authEncry][0]);
            Form.addParameter('y.' + authAddData[authEncry][1], authAddData[authEncry][4]);
            Form.addParameter('y.' + authAddData[authEncry][2], authAddData[authEncry][3]);
        }

        if (wifiPasswordMask == '1')
        {
            if ( (value != "********") || (pskPsdModFlag == true) )
            {
                Form.addParameter('k.PreSharedKey',value);

                if('1' == kppUsedFlag)
                {
                    Form.addParameter('k.KeyPassphrase',value);
                }
            }             
        }
        else
        {
            Form.addParameter('k.PreSharedKey',value);

            if('1' == kppUsedFlag)
            {
                Form.addParameter('k.KeyPassphrase',value);
            }
        }        
    }
}

function stWlanNow(domain, Name, ssid)
{
    this.domain = domain;
    this.Name = Name;
    this.ssid = ssid;
}

function setWlanNowMap(WlanListNow)
{
    var lowerLayer = thisLowerLayer;
    var WlanNowMap = {};
    for (var i = 0; i < WlanListNow.length-1; i++)
    {
        var athindex = getWlanPortNumber(WlanListNow[i].Name);
        if (((lowerLayer == '2G') || (lowerLayer == 'Iot')) && (athindex >= 0) && (athindex <= ssidEnd2G))
        {
            WlanNowMap[WlanListNow[i].ssid] = WlanListNow[i];
        }
        else if ((lowerLayer == '5G')&&( athindex >= ssidStart5G )&&( athindex <= ssidEnd5G )) 
        {
            WlanNowMap[WlanListNow[i].ssid] = WlanListNow[i];
        }
    }
    
    return WlanNowMap;
}

function DisableButtons() {
    setDisable('apply2GButton', 1);
    setDisable('cancel2GButton', 1);
    setDisable('apply5GButton',1);
    setDisable('cancelButton',1);
    setDisable('cancelButtonfbt',1);
    setDisable('applyIotButton', 1);
    setDisable('cancelIotButton', 1);
}

function FormatSSID(val) {
    if (val != "") {
        var formatstr = val;
        formatstr = formatstr.replace(new RegExp(/(\%)/g), "%25");
        formatstr = formatstr.replace(new RegExp(/(\&)/g), "%26");
        formatstr = formatstr.replace(new RegExp(/(\+)/g), "%2B");
        return formatstr
    }

    return val;
}

function ApplySubmit1()
{
    var lowerLayer = thisLowerLayer;
    var Form = new webSubmitForm(); 
    var wlanDomain;    
    var Channel5GData="";
    
    if (ajaxAddParameter1() == false)
    {  
        return;
    }
    
    if (addParameter2(Form) == false)
    {
        return;
    }
    
    if (1 != DoubleFreqFlag)
    {
        if(lowerLayer == "5G")
        {
            Channel5GData = "&y.Channel=0&y.AutoChannelEnable=1"
        }
    }
    var thisNode = ((lowerLayer == '2G') || (lowerLayer == "Iot")) ? node2G : node5G;
    var dataStr = "y.SSIDAdvertisementEnabled=" + getSelectVal('Ssid' + lowerLayer + '_wlHide_' + selValIndex) + "&y.SSID=" + FormatSSID(addSSID) + "&y.LowerLayers=" + thisNode + Channel5GData;
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        dataStr += "&y.Enable=" + getCheckVal('Ssid' + lowerLayer + '_Enable_' + selValIndex);
    }
    dataStr += "&x.X_HW_Token=" + getValue('onttoken');
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : dataStr,
            url : 'add.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration'
                                       + '&RequestFile=html/amp/wificovercfg/wifiCover.asp',
            success : function(data) {
                var WlanListNow = [];
                $.ajax({
                    type : "post",
                    async : false,
                    cache : false,
                    url : "./getSsidlist.asp",
                    success : function(data) {    
                        WlanListNow = dealDataWithFun(data);    
                        var WlanNowMap = setWlanNowMap(WlanListNow);
                        wlanDomain = WlanNowMap[addSSID].domain;
                        if (AddParaForCover(Form, wlanDomain) == false)
                        {      
                            return;
                        }
                        
                        if (lowerLayer == "Iot") {
                            var iotInst = getWlanInstFromDomain(wlanDomain);
                            Form.addParameter('m.SyncIotSsidInst', iotInst);
                            Form.setAction('set.cgi?y=' + wlanDomain
                                        + '&k=' + wlanDomain + '.PreSharedKey.1'
                                        + "&m=InternetGatewayDevice.X_HW_WifiCoverService"
                                        + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                        } else {
                            Form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic'
                                       + '&y=' + wlanDomain
                                       + '&k=' + wlanDomain + '.PreSharedKey.1'
                                       + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                        }

                        DisableButtons();
                        $.ajax({
                            type : "post",
                            async : false,
                            cache : false,
                            data:"wlaninst=" + getInstIdByDomain(wlanDomain),
                            url : "./coverApExternSsid.asp",
                            success : function(data) {
                            }
                        }); 
                        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
                        Form.submit();
                    }
                });
                },
                complete: function (XHR, TS) {
                                XHR=null;
                 }
            });
}

function ApplySubmit2()
{
    var lowerLayer = thisLowerLayer;
    var thisWlanList = ((lowerLayer == '2G') || (lowerLayer == "Iot")) ? WlanList2G : WlanList5G;
    var Form = new webSubmitForm();
    var wlanDomain;
    var iotSubmitUrl = "";
    if ((lowerLayer == "Iot") && (isAutoIotSsidInst(lowerLayer) == true)) {
        wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + iotAutoSsidInst;
        Form.addParameter('y.Enable',1);
        Form.addParameter('m.SyncIotSsidInst',iotAutoSsidInst);
        iotSubmitUrl = "&m=InternetGatewayDevice.X_HW_WifiCoverService";
    } else {
        wlanDomain = thisWlanList[selValIndex].domain;
    }

    if (addParameter1(Form) == false)
    {  
        return;
    }
    
    if (addParameter2(Form) == false)
    {
        return;
    }
    
    if (AddParaForCover(Form, wlanDomain) == false)
    {      
        return;
    }
    
    Form.setAction('set.cgi?w=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic' 
                                       + '&y=' + wlanDomain
                                       + '&k=' + wlanDomain + '.PreSharedKey.1'
                                       + iotSubmitUrl
                                       + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');    

    DisableButtons();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function isAutoIotSsidInst(lowerLayer)
{
    if ((fttrFlag != 1) || (lowerLayer != "Iot")) {
        return false;
    }

    var ssidNum = getAll2GSSIDNum();
    if ((ssidNum == SsidPerBand) && (iotAutoSsidInst != 0)) {
        return true;
    }

    return false;
}

function homeNetworkSubmit(lowerLayer)
{
    var addSsidNum = selValIndex;
    var ssid = getValue('Ssid' + lowerLayer + '_text_' + addSsidNum);
    ssid = ltrim(ssid);
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        if (ConfirmEx(wificovercfg_language['amp_homenetwork_apply_warning']) == false) {
            return;
        }
        if(CurrentBin.toUpperCase() == 'A8C'){
            if((lowerLayer == '2G') && (0 != ssid.indexOf("ChinaNet-")) ){
                AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
                return false;
            }
 
            if (1 != DoubleFreqFlag){
                if((lowerLayer == '5G') && (0 != ssid.indexOf("ChinaNet-")) ){
                    AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet_5G']);
                    return false;
                }
            }
        }
    }

    thisLowerLayer = lowerLayer;
    if ((AddFlag == true) && (isAutoIotSsidInst(lowerLayer) == false)) {
        ApplySubmit1();
    } else {
        ApplySubmit2();
    }
}

function FttrUnModefy(lowerLayer) {
    var wlanList = ((lowerLayer == "2G") || (lowerLayer == "Iot")) ? WlanList2G : WlanList5G;
    var hiddenNum = [];
    for (var i = 0; i < wlanList.length; i++) {
        $("#tr" + lowerLayer + "_Ssid_" + i).remove();

        if (i > 0) {
            hiddenNum[i] = hiddenNum[i - 1];
        } else {
            hiddenNum[i] = 0;
        }
        if (isShowWlan(wlanList[i]) == false) {
            hiddenNum[i] += 1;
            continue;
        }

        var ssidIndex = getInstIdByDomain(wlanList[i].domain);
        var trHtml = '<tr class="tabal_01 align_center ssid_detail' + lowerLayer + '" id="tr' + lowerLayer + '_Ssid_' + i + '">';
        trHtml += '<td><input type="radio" name="rml' + lowerLayer + '" id="rml" value="ssid.' + i +'" onClick="ModifyForRadio(this)"></td>';
        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            trHtml += '<td>' + ssidIndex + '</td>'; 
        }
        trHtml += '<td style="word-wrap:break-word;">' + GetSSIDStringContent(htmlencode(wlanList[i].ssid),32) + '</td>';

        if (wlanList[i].wlHide == 1) {
            trHtml += '<td>' + wificovercfg_language['amp_homenetwork_bcast_enable'] +'</td>';
        } else {
            trHtml += '<td>' + wificovercfg_language['amp_homenetwork_bcast_disable'] +'</td>';
        }

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var authBpon = GetEncryptByValue(Encrypt);
            trHtml += '<td id="td_ssid' + lowerLayer + '_wlAuth_' + i + '" name="' + authMapBpon[wlanList[i].BeaconType] + '">' + authMap[authMapBpon[wlanList[i].BeaconType]] + '</td>';
            trHtml += '<td id="td_ssid' + lowerLayer + '_wlEncry_' + i + '" name="' + authBpon + '">' + encryptMapBpon[authBpon] + '</td>';
        } else {
            trHtml += '<td id="td_ssid' + lowerLayer + '_wlAuth_' + i + '" name="' + Encrypt + '">' + authMap[Encrypt] + '</td>';
        }
        var pwd = '--';
        if (Encrypt == 'OPEN') {
            pwd = '--';
        } else  {
            pwd = wpaPskMap[ssidIndex].value;
        }

        pwd = GetSSIDStringContent(htmlencode(pwd),64);
        if (pwd == '--') {
            trHtml += '<td style="word-wrap:break-word;" type="password">' + pwd + '</td>';
        } else {
            var idIndex = 'wlPsk' + lowerLayer + '_' + i;
            trHtml += '<td style="word-wrap:break-word;width:140px"><input id=' + idIndex + '_txt' +
                      ' type="text" class="amp_font"  value="' + pwd +'" style="width:105px;display:none" disabled /><input id=' +
                      idIndex + '_pwd' + ' type="password" class="amp_font" style="width:105px;" value="' + pwd +
                      '" disabled/><input checked type="checkbox" id=' + idIndex +
                      ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);"/><span id = "hideId2">' +
                      wificovercfg_language['amp_homenetwork_hide'] + '</span></td>';
        }

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var enable = (wlanList[i].Enable == 1) ? "checked" : "";
            trHtml += '<td><input type="text" id="td_ssid' + lowerLayer + '_DeviceNum_' + i + '" value="' + wlanList[i].DeviceNum + '" style="width:30px;" name="deviceNum" disabled/> </td>';
            trHtml += '<td><input type="checkbox" '+ enable + ' id="td_ssid' + lowerLayer + '_Enable_' + i + '" name="enable" disabled/> </td>';
        }
        trHtml += '</tr>';

        var isCheckValue;
        $("#wlanInst" + lowerLayer).append(trHtml);

        var checkSSIDRadio = ((lowerLayer == "2G") || (lowerLayer == "Iot")) ? check2GSSIDRadio : check5GSSIDRadio;
        if (checkSSIDRadio == ('ssid.' + i)) {
            isCheckValue = i;
            if ((lowerLayer == "2G") || (lowerLayer == "Iot")) {
                nowCheck2GSSID = ssidIndex;
            } else {
                nowCheck5GSSID = ssidIndex;
            }
        }
    }

    isCheckValue = isCheckValue - hiddenNum[isCheckValue];
    $("input[name = 'rml" + lowerLayer + "']")[isCheckValue].checked = true;
    if (wifiPasswordMask == '1') {
        hidePwdInput();
    }
}

function ModifyForRadio(obj) {
    var value = obj.value;
    var lowerLayer = (obj.name == "rml2G") ? "2G" : "5G";
    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        if (lowerLayer == "5G") {
            if (value == check5GSSIDRadio ) {
                return;
            }
            
            check5GSSIDRadio = value;
            FttrUnModefy("5G");
            modifySSIDTr('5G');

            if (nowCheck5GSSID == parseInt(ssidStart5G) + 1) {
                setDisable('Delete5GButton', 1);
            }
        } else {
            if (noWiFiChipFlag != 1) {
                return;
            }

            if (value == check2GSSIDRadio ) {
                return;
            }

            check2GSSIDRadio = value;
            FttrUnModefy("2G");
            modifySSIDTr('2G');

            if (nowCheck2GSSID == parseInt(ssidStart2G) + 1) {
                setDisable('Delete2GButton', 1);
            }
        }
        

        if ((value == check2GSSIDRadio ) && (lowerLayer == "2G") && (noWiFiChipFlag == 1)) {
            return;
        }
    }
}

function ChangeMode(id) {
    var authMode = getSelectVal(id);
    var id1 = id.slice(4,6);
    var id2 = id.slice(-1);
    id = id.split("_");
    var encryId = id[0] + "_wlEncry_" + id[2];
    var idIndex = 'wlPsk' + id1 + '_' + id2 + '_pwd';
    if (authMode == "OPEN") {
        setDisable(idIndex, 1);
        setDisable(encryId, 1);
        return;
    }
    setDisable(idIndex, 0);
    setDisable(encryId, 0);

    getElementById(encryId).innerHTML = "";
    if (authMode == "WPA2-WPA3-Personal" || authMode == "WPA3-Personal") {
        getElementById(encryId).innerHTML = '<option value="AESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_aes'] + '</option> ';
    } else {
        getElementById(encryId).innerHTML = '<option value="AESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_aes'] + '</option> ' + 
                                            '<option value="TKIPEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_tkip'] + '</option>' + 
                                            '<option value="TKIPandAESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_tkipaes'] + '</option>';
    }
}


function modifySSIDTr(lowerLayer)
{
    thisLowerLayer = lowerLayer;
    var ratioName = 'rml' + lowerLayer;
    
    if ('-1' ==  getRadioValue(ratioName) )
    {   
        AlertEx(cfg_wlancfgother_language['amp_ssid_select']);
        return ;
    }
    
    AddFlag = false;
    setSSIDBtnEnable(1);
    selValIndex = getInstIdByDomain(getRadioValue(ratioName));
    
    var thisWlanList = (lowerLayer == '2G' || lowerLayer == "Iot") ? WlanList2G : WlanList5G;
    var wlanInstOver = getInstIdByDomain(thisWlanList[selValIndex].domain);

    if (isBponFlag == 1) {
        getApSsidOverFlag(wlanInstOver);
        setDisable("apply" + lowerLayer + "Button", isApSsidOver);
        setDisable("cancel" + lowerLayer + "Button", isApSsidOver);
        setDisable("Delete" + lowerLayer + "Button", isApSsidOver);
        setDisable("Modify" + lowerLayer + "Button", isApSsidOver);
        if (isApSsidOver == 1) {
            AlertEx(wificovercfg_language['amp_wificover_ap_ssidsyncing']);
        }
    }

    var trId = 'tr' + lowerLayer + '_Ssid_' + selValIndex;
    var txtSsid = 'Ssid' + lowerLayer + '_text_' + selValIndex;
    var selwlHideId = 'Ssid' + lowerLayer + '_wlHide_' + selValIndex;
    var selwlAuthId = 'Ssid' + lowerLayer + '_wlAuth_' + selValIndex;
    var selwlEncryId = 'Ssid' + lowerLayer + '_wlEncry_' + selValIndex;
    var idIndex = 'wlPsk' + lowerLayer + '_' + selValIndex;
    var tabWlanId = 'wlanInst' + lowerLayer;
    var thisWlanList = (lowerLayer == '2G' || lowerLayer == "Iot") ? WlanList2G : WlanList5G;
    var selEnable = 'Ssid' + lowerLayer + '_Enable_' + selValIndex;
    var selDeviceNum = 'Ssid' + lowerLayer + '_DeviceNum_' + selValIndex;
    var ssidIndex = getInstIdByDomain(thisWlanList[selValIndex].domain);
    
    var trHtml = '<tr class="tabal_01 align_center ssid_detail' + lowerLayer + '" id=' + trId + '>';     
    trHtml += '<td><input type="radio" name=' + ratioName + ' id="rml" value="ssid.' + selValIndex +'" checked onClick="ModifyForRadio(this)"></td>';
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        trHtml += '<td>' + ssidIndex + '</td>'; 
    }

    trHtml += '<td style="word-wrap:break-word;"><input type="text" id=' 
           + txtSsid +' style = "width:80px" maxlength="32"></td>'; 
    trHtml += '<td><select style = "width:50px" id =' + selwlHideId +'><option value="1">' 
           + wificovercfg_language['amp_homenetwork_bcast_enable'] + '</option><option value="0">' 
           + wificovercfg_language['amp_homenetwork_bcast_disable'] + '</option></select></td>'; 
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        trHtml += '<td><select style = "width:80px" id =' + selwlAuthId +' onchange="ChangeMode(this.id);"><option value="OPEN">' 
                + authMap['OPEN'] + '</option>';
    } else {
        trHtml += '<td><select style = "width:80px" id =' + selwlAuthId +'><option value="OPEN">' 
                + authMap['OPEN'] + '</option>';
    }
    if ((noWiFiChipFlag != 1) || (isBponFlag == 1)) {
        trHtml += '<option value="WPA-Personal">' + authMap['WPA-Personal'] + '</option>';
    } 
    trHtml += '<option value="WPA2-Personal">' + authMap['WPA2-Personal'] + '</option><option value="WPA-WPA2-Personal">' + 
              authMap['WPA-WPA2-Personal'] + '</option>';
    if ((cap11ax == 1) || ((isBponFlag == 1) && (noWiFiChipFlag == 1))) {
        trHtml += '<option value="WPA3-Personal">' + authMap['WPA3-Personal'] + '</option><option value="WPA2-WPA3-Personal">' + 
                  authMap['WPA2-WPA3-Personal'] + '</option>';
    }
    trHtml += '</select></td>';

    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        trHtml += '<td><select style = "width:80px" id =' + selwlEncryId +'>';
        trHtml += '<option value="AESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_aes'] + '</option> ' + 
                  '<option value="TKIPEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_tkip'] + '</option>' + 
                  '<option value="TKIPandAESEncryption">' + cfg_wlancfgdetail_language['amp_encrypt_tkipaes'] + '</option>';
        trHtml += '</select></td>';
    }

    trHtml += '<td style="word-wrap:break-word;width:140px"><input id=' + idIndex + '_txt' 
           + ' type="text" class="amp_font" style="width:105px;display:none" onchange="setPwdEqule(this.id);" /><input id=' 
           + idIndex + '_pwd' + ' type="password" class="amp_font" style="width:105px;" onchange="setPwdEqule(this.id);' 
           + ' BindPsdModifyEvent(this.id);" /><input checked type="checkbox" id=' 
           + idIndex + ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);" /><span id = "hideId3">'
           + wificovercfg_language['amp_homenetwork_hide'] + '</span></td>';
    if (noWiFiChipFlag == 1) {
        trHtml +='<td><input type="text" style="width:30px;" id="' + selDeviceNum + '" name="deviceNum"/> </td>';
        trHtml +='<td><input type="checkbox" id="' + selEnable + '" name="enable"/> </td>';
    }
    trHtml += '</tr>';
    
    var thisAuth = getElById("td_ssid" + lowerLayer + "_wlAuth_" + selValIndex).attributes['name'].value;
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        var thisEncrypt = getElById("td_ssid" + lowerLayer + "_wlEncry_" + selValIndex).attributes['name'].value;
    }
    var trIndex = $("#" + trId)[0].rowIndex - 1;
    $("#" + trId).remove();
    $("#" + tabWlanId + " tr:eq(" + trIndex + ")").after(trHtml);
    
    setText(txtSsid, thisWlanList[selValIndex].ssid);
    
    setSelect(selwlHideId, thisWlanList[selValIndex].wlHide);
    setSelect(selwlAuthId, thisAuth);
    if (noWiFiChipFlag == 1) {
        setCheck(selEnable, thisWlanList[selValIndex].Enable);
        setText(selDeviceNum, thisWlanList[selValIndex].DeviceNum);
    }

    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        ChangeMode(selwlAuthId);
        setSelect(selwlEncryId, thisEncrypt);
    }
    var pwd = '--';
    if (thisAuth == 'OPEN')
    {
        pwd = '--';
    }
    else 
    {
        pwd = wpaPskMap[ssidIndex].value;
    }
    setText(idIndex + '_txt', pwd);                                
    setText(idIndex + '_pwd', pwd);

    if (wifiPasswordMask == '1') {
        setDisplay(idIndex, 0);
        setDisable(idIndex, 1);
        SetPasswordBoxState(lowerLayer);
    }

    if (fttrFlag != 1) {
        $("input[name = " + ratioName + "]").attr('disabled', true);
    }
}

function SetPasswordBoxState(lowerLayer) {
    var wlanList = (lowerLayer == '2G' || lowerLayer == "Iot") ? WlanList2G : WlanList5G;
    for (var idx = 0; idx < wlanList.length; idx++) {
        setDisable('wlPsk' + lowerLayer + '_' + idx, 1);
    }
}

function delAjaxRequest()
{
    lowerLayer = thisLowerLayer;
    var ratioName = 'rml' + lowerLayer;
    var thisWlanList = ((lowerLayer == '2G') || (lowerLayer == "Iot")) ? WlanList2G : WlanList5G;
    var delValIndex = getInstIdByDomain(getRadioValue(ratioName));
    var Form = new webSubmitForm();    
    Form.addParameter(thisWlanList[delValIndex].domain, '');
    Form.setAction('del.cgi?RequestFile=html/amp/wificovercfg/wifiCover.asp');
    
    var del_array = getInstIdByDomain(thisWlanList[delValIndex].domain);
    
    $.ajax({
         type : "POST",
         async : true,
         cache : false,
         data : "y.DeleteInstArray="+del_array+"&x.X_HW_Token="+getValue('onttoken'),
         url : "set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.ParallelDelSsid&RequestFile=html/amp/wificovercfg/wifiCover.asp",
         success : function(data) {
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.submit();
         },
         complete: function (XHR, TS) {
            XHR=null;
         }
    });
}

function CheckDelSSID(lowerLayer, ratioName) {
    var thisWlanList = (lowerLayer == '2G') ? WlanList2G : WlanList5G;
    var delValIndex = getInstIdByDomain(getRadioValue(ratioName));
    var delDomainIndex = getInstIdByDomain(thisWlanList[delValIndex].domain);
    if ((delDomainIndex == parseInt(ssidStart2G) + 1) || (delDomainIndex == parseInt(ssidStart5G) + 1)) {
        return false;
    }

    return true;
}

function delIotSSID(lowerLayer)
{
    thisLowerLayer = lowerLayer;
    if (ConfirmEx(cfg_wlancfgother_language['amp_delssid_confirm']) == false) {
        return;
    }

    var ratioName = 'rml' + lowerLayer;
    var thisWlanList = WlanList2G;
    var delValIndex = getInstIdByDomain(getRadioValue(ratioName));

    var Form = new webSubmitForm();
    Form.addParameter(thisWlanList[delValIndex].domain, '');
    Form.setAction('del.cgi?RequestFile=html/amp/wificovercfg/wifiCover.asp');
    
    var del_array = getInstIdByDomain(thisWlanList[delValIndex].domain);
    $.ajax({
         type : "POST",
         async : true,
         cache : false,
         data : "y.DeleteInstArray=" + del_array + "&x.X_HW_Token="+getValue('onttoken'),
         url : "set.cgi?y=InternetGatewayDevice.X_HW_DEBUG.AMP.ParallelDelSsid&RequestFile=html/amp/wificovercfg/wifiCover.asp",
         success : function(data) {
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.submit();
         },
         complete: function (XHR, TS) {
            XHR=null;
         }
    });

}

function delSSIDTr(lowerLayer)
{
    thisLowerLayer = lowerLayer;
    var ratioName = 'rml' + lowerLayer;

    if (fttrFlag == 1) {
        if (CheckDelSSID(lowerLayer, ratioName) == false) {
            return;
        }
    }

    if (getRadioValue(ratioName) == '-1') {
        AlertEx(cfg_wlancfgother_language['amp_ssid_select']);
        return;
    }
    
    if (ConfirmEx(cfg_wlancfgother_language['amp_delssid_confirm']) == false) {
        return;
    }

    delAjaxRequest();
}

function ShowOrHideText(idIndex)
{
    if (1 == getCheckVal(idIndex))
    {
        setDisplay(idIndex + '_pwd', 1);
        setDisplay(idIndex + '_txt', 0);
    }
    else
    {
        setDisplay(idIndex + '_pwd', 0);
        setDisplay(idIndex + '_txt', 1);
    }
}

function BindSsidChangeEvent(lowerLayer) {
    $('input:radio[name="rml' + lowerLayer + '"]').bind("change", function(){ 
        if (CheckDelSSID(lowerLayer, 'rml' + lowerLayer) == false) {
            setDisable('Delete' + lowerLayer + 'Button', 1);
        } else {
            setDisable('Delete' + lowerLayer + 'Button', 0);
        }
    });
}

function CancleScnEnable(scnId) {
    setCheck("EnableScnBox", scnVar);
}

function CommitScnEnable() {
    if (ConfirmEx(wificovercfg_language['amp_scn_enable_explain']) == false) {
        return;
    }

    var Form = new webSubmitForm();

    Form.addParameter('scn.Enable', getCheckVal("EnableScnBox"));
    Form.setAction('set.cgi?scn=InternetGatewayDevice.LANDevice.1.X_HW_SCN&RequestFile=html/amp/wificovercfg/wifiCover.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function initWlanInst2G()
{
    for (var i = 0; i < WlanList2G.length; i++)
    {
        if (isShowWlan(WlanList2G[i]) == false)
        {
            continue;
        }

        if (getWlanInstFromDomain(WlanList2G[i].domain) == iotSsidInst) {
            continue;
        }
        check2GSSIDRadio = 'ssid.0';
        var ssidIndex = getInstIdByDomain(WlanList2G[i].domain);

        var trHtml = '<tr class="tabal_01 align_center ssid_detail2G" id="tr2G_Ssid_' + i + '">';     
        trHtml += '<td><input type="radio" name="rml2G" id="rml" value="ssid.' + i +'" onClick="ModifyForRadio(this)"></td>';
        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            trHtml += '<td>' + ssidIndex + '</td>'; 
        }
        trHtml += '<td style="word-wrap:break-word;">' + GetSSIDStringContent(htmlencode(WlanList2G[i].ssid),32) + '</td>'; 
    
        if (WlanList2G[i].wlHide == 1)
        {
            trHtml += '<td>' + wificovercfg_language['amp_homenetwork_bcast_enable'] +'</td>'; 
        }
        else
        {
            trHtml += '<td>' + wificovercfg_language['amp_homenetwork_bcast_disable'] +'</td>'; 
        }

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var authBpon = GetEncryptByValue(Encrypt);
            trHtml += '<td id="td_ssid2G_wlAuth_' + i + '" name="' + authMapBpon[WlanList2G[i].BeaconType] + '">' + authMap[authMapBpon[WlanList2G[i].BeaconType]] + '</td>';
            trHtml += '<td id="td_ssid2G_wlEncry_' + i + '" name="' + authBpon + '">' + encryptMapBpon[authBpon] + '</td>';
        } else {
            trHtml += '<td id="td_ssid2G_wlAuth_' + i + '" name="' + Encrypt + '">' + authMap[Encrypt] + '</td>'; 
        }
        
        var pwd = '--';
        if (Encrypt == 'OPEN')
        {
            pwd = '--';
        }
        else 
        {
            pwd = wpaPskMap[ssidIndex].value;
        }
        
        pwd = GetSSIDStringContent(htmlencode(pwd),64);
        if (pwd == '--')
        {
            trHtml += '<td style="word-wrap:break-word;" type="password">' + pwd + '</td>';
        }
        else
        {
            var idIndex = 'wlPsk2G_' + i;
            trHtml += '<td style="word-wrap:break-word;width:140px"><input id=' + idIndex + '_txt' 
            + ' type="text" class="amp_font"  value="' + pwd +'" style="width:105px;display:none" disabled /><input id=' 
            + idIndex + '_pwd' + ' type="password" style="width:105px;" class="amp_font"  value="' + pwd 
            +'" disabled/><input checked type="checkbox" id=' + idIndex 
            + ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);"/><span id = "hideId4" class="hidetitle">'
            + wificovercfg_language['amp_homenetwork_hide'] + '</span></td>';
        }

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var selEnable = 'Ssid2G_Enable_' + i;
            var selDeviceNum = 'Ssid2G_DeviceNum_' + i;
            trHtml += '<td><input type="text" style="width:30px;" id=' + selDeviceNum + ' name="deviceNum" value="OFF" disabled="disabled"/> </td>';
            trHtml += '<td><input type="checkbox" id=' + selEnable + ' name="enable" value="OFF" disabled="disabled"/> </td>';
        }
        trHtml += '</tr>';

        $("#wlanInst2G").append(trHtml);
        if ((fttrFlag == 1) && !(IsWlanAvailable())) {
            if (ssidIndex == parseInt(ssidStart2G) + 1) {
                setDisable('Delete2GButton', 1);
            }
        }
    }
    
    if (undefined != $("input[name = 'rml2G']")[0])
    {
        $("input[name = 'rml2G']")[0].checked = true;
    }

    if ((fttrFlag == 1) && !(IsWlanAvailable())) {
        BindSsidChangeEvent('2G');
    }
    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        setDisplay('ssidIndex2g', 1);
        getElById('ssidAuth2g').innerHTML = wificovercfg_language['amp_wificover_common_auth'];
        setDisplay('ssidMode2g', 1);
        setDisplay('ssidDeviceNum2g', 1);
        setDisplay('ssidEnable2g', 1);
        SetEnableBoxState("2G", WlanList2G);
    }
}

function SetEnableBoxState(lowerLayer, wlanList) {
    for (var idx = 0; idx < wlanList.length; idx++) {
        setCheck('Ssid' + lowerLayer + '_Enable_' + idx, wlanList[idx].Enable);
        setText('Ssid' + lowerLayer + '_DeviceNum_' + idx, wlanList[idx].DeviceNum);
    }
}

function initWlanInstIotSsid()
{
    for (var i = 0; i < WlanList2G.length; i++) {
        if (isShowWlan(WlanList2G[i]) == false) {
            continue;
        }

        if (getWlanInstFromDomain(WlanList2G[i].domain) != iotSsidInst) {
            continue;
        }
        
        check2GSSIDRadio = 'ssid.0';
        var trHtml = '<tr class="tabal_01 align_center ssid_detailIot" id="trIot_Ssid_' + i + '">';     
        trHtml += '<td><input type="radio" name="rmlIot" id="rml" value="ssid.' + i +'" onClick="ModifyForRadio(this)"></td>';
        trHtml += '<td style="word-wrap:break-word;">' + GetSSIDStringContent(htmlencode(WlanList2G[i].ssid),32) + '</td>'; 
    
        if (WlanList2G[i].wlHide == 1) {
            trHtml += '<td>' + wificovercfg_language['amp_homenetwork_bcast_enable'] +'</td>'; 
        } else {
            trHtml += '<td>' + wificovercfg_language['amp_homenetwork_bcast_disable'] +'</td>'; 
        }
        trHtml += '<td id="td_ssidIot_wlAuth_' + i + '" name="' + Encrypt + '">' + authMap[Encrypt] + '</td>'; 
        
        var pwd = '--';
        var ssidIndex = getInstIdByDomain(WlanList2G[i].domain);
        if (Encrypt == 'OPEN') {
            pwd = '--';
        } else {
            pwd = wpaPskMap[ssidIndex].value;
        }
        
        pwd = GetSSIDStringContent(htmlencode(pwd),64);
        if (pwd == '--') {
            trHtml += '<td style="word-wrap:break-word;" type="password">' + pwd + '</td>';
        } else {
            var idIndex = 'wlPskIot_' + i;
            trHtml += '<td style="word-wrap:break-word;"><input id=' + idIndex + '_txt' 
            + ' type="text" class="amp_font"  value="' + pwd +'" style="display:none" disabled /><input id=' 
            + idIndex + '_pwd' + ' type="password" class="amp_font"  value="' + pwd 
            +'" disabled/><input checked type="checkbox" id=' + idIndex 
            + ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);"/>'
            + wificovercfg_language['amp_homenetwork_hide'] + '</td>';
        }

        trHtml += '</tr>';

        $("#wlanInstIot").append(trHtml);

    }

    if ($("input[name = 'rmlIot']")[0] != undefined) {
        $("input[name = 'rmlIot']")[0].checked = true;
    }

}

function initWlanInst5G()
{
    for (var i = 0; i < WlanList5G.length; i++)
    {
        if (isShowWlan(WlanList5G[i]) == false)
        {
            continue;
        }
        check5GSSIDRadio = 'ssid.0';
        var ssidIndex = getInstIdByDomain(WlanList5G[i].domain);
        var trHtml = '<tr class="tabal_01 align_center ssid_detail5G" id="tr5G_Ssid_' + i + '">';     
        trHtml += '<td><input type="radio" name="rml5G" id="rml" value="ssid.' + i +'" onClick="ModifyForRadio(this)"></td>';
        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            trHtml += '<td>' + ssidIndex + '</td>'; 
        }
        trHtml += '<td style="word-wrap:break-word;">' + GetSSIDStringContent(htmlencode(WlanList5G[i].ssid),32) + '</td>'; 
        if (WlanList5G[i].wlHide == 1)
        {
            trHtml += '<td>' +  wificovercfg_language['amp_homenetwork_bcast_enable'] +'</td>'; 
        }
        else
        {
            trHtml += '<td>' +  wificovercfg_language['amp_homenetwork_bcast_disable'] +'</td>'; 
        }

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var authBpon = GetEncryptByValue(Encrypt);
            trHtml += '<td id="td_ssid5G_wlAuth_' + i + '" name="' + authMapBpon[WlanList5G[i].BeaconType] + '">' + authMap[authMapBpon[WlanList5G[i].BeaconType]] + '</td>';
            trHtml += '<td id="td_ssid5G_wlEncry_' + i + '" name="' + authBpon + '">' + encryptMapBpon[authBpon] + '</td>';
        } else {
            trHtml += '<td id="td_ssid5G_wlAuth_' + i + '" name="' + Encrypt + '">' + authMap[Encrypt] + '</td>'; 
        }
        
        var pwd = '--';
        if (Encrypt == 'OPEN')
        {
            pwd = '--';
        }
        else 
        {
            pwd = wpaPskMap[ssidIndex].value;
        }
        
        pwd = GetSSIDStringContent(htmlencode(pwd),64);
        if (pwd == '--')
        {
            trHtml += '<td style="word-wrap:break-word;" type="password">' + pwd + '</td>';
        }
        else
        {
            var idIndex = 'wlPsk5G_' + i;
            trHtml += '<td style="word-wrap:break-word;width:140px"><input id=' + idIndex + '_txt' 
            + ' type="text" class="amp_font"  value="' + pwd +'" style="width:105px;display:none" disabled /><input id=' 
            + idIndex + '_pwd' + ' type="password" style="width:105px;" class="amp_font"  value="' + pwd 
            +'" disabled/><input checked type="checkbox" id=' + idIndex 
            + ' name="checkWlPsk" value="on" onClick="ShowOrHideText(this.id);"/><span id = "hideId5" class="hidetitle">'
            + wificovercfg_language['amp_homenetwork_hide'] + '</span></td>';
        }

        if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
            var selEnable = 'Ssid5G_Enable_' + i;
            var selDeviceNum = 'Ssid5G_DeviceNum_' + i;
            trHtml += '<td><input type="text" style="width:30px;" id=' + selDeviceNum + ' name="deviceNum" value="OFF" disabled="disabled"/> </td>';
            trHtml += '<td><input type="checkbox" id=' + selEnable + ' name="enable" value="OFF" disabled="disabled"/> </td>';
        }

        trHtml += '</tr>';
        
        $("#wlanInst5G").append(trHtml);
        if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
            if (ssidIndex == parseInt(ssidStart5G) + 1) {
                setDisable('Delete5GButton', 1);
            }
        }
    }
    
    if (undefined != $("input[name = 'rml5G']")[0])
    {
        $("input[name = 'rml5G']")[0].checked = true;
    }
    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        BindSsidChangeEvent('5G');
    }

    if ((isBponFlag == 1) && (noWiFiChipFlag == 1)) {
        setDisplay('ssidIndex5g', 1);
        getElById('ssidAuth5g').innerHTML = wificovercfg_language['amp_wificover_common_auth'];
        setDisplay('ssidMode5g', 1);
        setDisplay('ssidDeviceNum5g', 1);
        setDisplay('ssidEnable5g', 1);
        SetEnableBoxState("5G", WlanList5G);
    }
}

function homeNetworkCancel(lowerLayer)
{
    thisLowerLayer = lowerLayer;
    $('.ssid_detail' + lowerLayer).remove();
    setSSIDBtnEnable(0);

    if (lowerLayer == '2G') {
        initWlanInst2G();
        if((fttrFlag == 1) && (DoubleFreqFlag != 1) && (noWiFiChipFlag == 1)) {
            FttrHideButton('2G');
            if (wifiPasswordMask == '1') {
                $("input[name = 'checkWlPsk']").attr('disabled', true);
            }
        }
    } else if (lowerLayer == 'Iot') {
        initWlanInstIotSsid();
        if (iotSsidInst != 0) {
            setDisable('New' + lowerLayer + 'button', 1);
        }
        if (wifiPasswordMask == '1') {
            $("input[name = 'checkWlPsk']").attr('disabled', true);
        }
    } else {
        initWlanInst5G();
        if((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
            FttrHideButton('5G');
            if (wifiPasswordMask == '1') {
                hidePwdInput();
            }
        }
    }

    pskPsdModFlag = false;
}

function switchTab(TableN)
{
    for (var i = 1; i <= 2; i++)
    {
        if ("tab" + i == TableN) 
        {
            getElementById(TableN).style.backgroundColor = "#f6f6f6";
            getElementById(TableN).style.color="#000000";

            if (rosunionGame == 1) {
                document.getElementById(TableN).style.backgroundColor = '#001c45';
                document.getElementById(TableN).style.color = 'rgb(255,79,18)';
            }

            top.wificover_tabid = TableN;
            setDisplay('meun_'+i, 1);
            
            if(i == 2)
            {
                LoadRFAdjust();
            }        
        }
        else
        {
            getElementById("tab" + i).style.backgroundColor = "";
            getElementById("tab" + i).style.color = "";
            setDisplay('meun_'+i, 0);
        }
    }
}

function IsShowSettings()
{
    if (1 == getRadioVal("TopoAdjustPolicy"))
    {
        setDisplay('divTopoAdjustSettings', 0);
        $(".adjustPolicyClass").css('display', 'none');
    }
    else
    {
        setDisplay('divTopoAdjustSettings', 1);
        $(".adjustPolicyClass").css('display', '');
    }
}

function setAdjustSettings()
{
    setText('LowRateThrehold', topoAdjustPolicy.LowRateThrehold);
    setText('PacketLossRateThrehold', topoAdjustPolicy.PacketLossRateThrehold);
}

function setAdjustPolicy()
{    
    if (topoAdjustPolicy.UserPolicy == 1)
    {
        setRadio('TopoAdjustPolicy', 1);
    }
    else
    {
        setRadio('TopoAdjustPolicy', 2);
        if (topoAdjustPolicy.UserPolicy == 2)
        {
            setCheck('rmlLowRateThrehold', 1);
            setCheck('rmlPacketLossRateThrehold', 0);
        }
        else if (topoAdjustPolicy.UserPolicy == 4)
        {
            setCheck('rmlLowRateThrehold', 0);
            setCheck('rmlPacketLossRateThrehold', 1);
        }
        else if (topoAdjustPolicy.UserPolicy == 6)
        {
            setCheck('rmlLowRateThrehold', 1);
            setCheck('rmlPacketLossRateThrehold', 1);
        }
    }
}

function SetDefaultAdjustPolicy()
{
    setAdjustPolicy();
    setAdjustSettings();
    IsShowSettings();
}

function SetTopoButtonDisabled()
{
    setDisable('TopoAdjustPolicyApplyButton', 1);
    setDisable('TopoAdjustPolicyCancelButton', 1);
    setDisable('TopoAdjustSettingsApplyButton', 1);
    setDisable('TopoAdjustSettingsCancelButton', 1);
}

function CheckTopoAdjustPolicy()
{
    if(!getCheckVal('rmlLowRateThrehold') && !getCheckVal('rmlPacketLossRateThrehold') && 2 == getRadioVal('TopoAdjustPolicy'))
    {
        AlertEx(wificovercfg_language['amp_topoAdjustPolicy_linkQuality_none']);
        return false;
    }
    
    return true;
}

function TopoAdjustPolicySubmit()
{
    var Form = new webSubmitForm();
    
    if (false == CheckTopoAdjustPolicy())
    {
        return;
    }
    
    SetTopoButtonDisabled();
    var userPolicy = 0;
    if (1 == getRadioVal('TopoAdjustPolicy'))
    {
        userPolicy = 1;
    }
    else if (2 == getRadioVal('TopoAdjustPolicy'))
    {    
        if (getCheckVal('rmlLowRateThrehold'))
        {
            userPolicy += parseInt(getSelectVal('rmlLowRateThrehold'), 10)
        }
        
        if (getCheckVal('rmlPacketLossRateThrehold'))
        {
            userPolicy += parseInt(getSelectVal('rmlPacketLossRateThrehold'), 10);
        }
    }
    
    Form.addParameter('x.UserPolicy', userPolicy);
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SmartTopo'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function TopoAdjustPolicyCancel()
{
    setAdjustPolicy();
    IsShowSettings();
}

function CheckTopoAdjustSettings()
{
    var LowRateThreholdValue = getValue('LowRateThrehold');
    var PacketLossRateThreholdValue = getValue('PacketLossRateThrehold');
    
    if(!isInteger(LowRateThreholdValue))
    {
        AlertEx(wificovercfg_language['amp_LowRateThrehold_int']);
        return false;
    }

    if( (parseInt(LowRateThreholdValue,10) < 0) || (parseInt(LowRateThreholdValue,10) > 65535)  )
    {
        AlertEx(wificovercfg_language['amp_LowRateThrehold_out_range']);
        return false;
    }
    
    if(!isInteger(PacketLossRateThreholdValue))
    {
        AlertEx(wificovercfg_language['amp_PacketLossRateThrehold_int']);
        return false;
    }

    if( (parseInt(PacketLossRateThreholdValue,10) < 0) || (parseInt(PacketLossRateThreholdValue,10) > 100)  )
    {
        AlertEx(wificovercfg_language['amp_PacketLossRateThrehold_out_range']);
        return false;
    }
    
    return true;
}

function TopoAdjustSettingsSubmit()
{
    var Form = new webSubmitForm();
    
    if (false == CheckTopoAdjustSettings())
    {
        return;
    }
    
    SetTopoButtonDisabled();
    
    
    Form.addParameter('x.LowRateThrehold', getValue('LowRateThrehold'));
    Form.addParameter('x.PacketLossRateThrehold', getValue('PacketLossRateThrehold'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SmartTopo'
                    + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
                    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function TopoAdjustSettingsCancel()
{
    setAdjustSettings();
}

function IsNotShowConfig5G() {
    if (tmczstFlag ==  1) {
        if ((webEnable5G != 1 && curUserType != 0) || (webAdminEnable5G != 1 && curUserType == 0)) {
            return true;
        }
    }

    return false;
}

function GetApInstByDomain(domain) {
    return domain.split(".")[2];
}

function GetNameByMac(mac) {
    for (var index = 0; index < g_AllUserDevinfo.length - 1; index++) {
        if (g_AllUserDevinfo[index].MACAddress.toUpperCase() == mac.toUpperCase()) {
            if (g_AllUserDevinfo[index].Name != "") {
                return g_AllUserDevinfo[index].Name;
            }
        }
    }
    return mac;
}

function syncPublicWiFiSubmit() {
    var Form = new webSubmitForm();
    Form.addParameter('x.AutoExtendPublicWiFi', getCheckVal('syncPublicWiFiEnable'));
    Form.setAction('set.cgi?'
                + 'x=' + 'InternetGatewayDevice.X_HW_WifiCoverService'
                + '&RequestFile=html/amp/wificovercfg/wifiCover.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function checkSSIDNum() {
    if (getCheckVal('EnableScnBox') === 1) {
        if (wlanInfo5GNum === parseInt(SsidPerBand)) {
            AlertEx(cfg_wlancfgother_language['amp_scn_enable_tips']);
            setCheck('EnableScnBox', 0);
        }
    }
}

</script>

<style>
.levelleft
{
    float:left;
    width:60px;
    text-align:left;
    margin-left:4px;
}

.levelmiddle
{
    float:left;
    width:60px;
    margin-left:46px;
    text-align:center;
}

.levelright
{
    float:left;
    width:60px;
    margin-left:44px;
    text-align:right;
}
</style>

</head>

<body class="mainbody" onLoad="LoadFrame();" >
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("WifiCoverCfg", GetDescFormArrayById(wificovercfg_language, "amp_wificover_config_header"), GetDescFormArrayById(wificovercfg_language, "amp_wificover_config_desc"), false);
</script>

<div class="title_spread"></div>

<table>
  <tr id="trUpnpEable" style="display:none"><td>
    <input type='checkbox' name='UpnpEnable' id='UpnpEnable' onClick='UpnpEnableSubmit();' value="ON">
      <script>
        setCheck('UpnpEnable', WifiCoverService[0].Enable);
        var wifiCoverEnableText = wificovercfg_language['amp_wificover_enable'];
        if (productType == 2) {
            wifiCoverEnableText = wificovercfg_language['amp_wificover_dsl_enable'];
        }

        document.write(wifiCoverEnableText); 
        if (true == UPNPCfgFlag) {getElById("trUpnpEable").style.display = "";}
      </script>
    </input></td>
  </tr>
</table>

<div id='divWifiCoverCfgAll' style="display:none">

<div>
<table id="tableinfo" width="100%" height="100%" style="border-spacing: 0px;">
    <tr class="head_title">
        <td width="20%" id="tab1" onclick="switchTab('tab1');" style="background-color:#f6f6f6; color:#000000;"><script>document.write(wificovercfg_language['amp_homenetwork_tab1']);</script></td>
        <td width="20%" id="tab2" onclick="switchTab('tab2');"><script>document.write(wificovercfg_language['amp_homenetwork_tab2']);</script></td>
    </tr>
</table>
</div>

<div id='meun_1'>
<div id='divHomenetConfig' style='display:none;'>
<div class="title_spread"></div>
<div id="basicSetting2G">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
        <tr>
            <td>
                <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody><tr>
                    <td>
                        <script>document.write(wificovercfg_language['amp_homenetwork_2g']);</script>
                    </td>
                    <td style="text-align: right;">
                    <div id = 'divBtn2G' style = 'display:none;'>
                        <button class="NewDelbuttoncss" id="New2Gbutton" type="button" onclick="addSSIDTr('2G');">
                             <script>document.write(wificovercfg_language['amp_homenetwork_add_ssid']);</script></button>
                        <button class="NewDelbuttoncss" id="Modify2Gbutton" type="button" onclick="modifySSIDTr('2G');">
                            <script>document.write(wificovercfg_language['amp_homenetwork_modify_ssid']);</script></button>
                        <button class="NewDelbuttoncss" id="Delete2GButton" type="button" onclick="delSSIDTr('2G');">
                            <script>document.write(wificovercfg_language['amp_homenetwork_del_ssid']);</script></button>
                    </div>
                    <div id = 'divTxt2G'>
                        <script>
                        if (1 == DoubleFreqFlag)
                        {
                            document.write(wificovercfg_language['amp_homenetwork_double_2g_explain']);
                        }
                        else
                        {
                            document.write(wificovercfg_language['amp_homenetwork_2g_explain']);
                        }

                        if (curLanguage.toUpperCase() == 'ARABIC') {
                            $('#divTxt2G').css('float','left');
                        }
                    </script>
                    </div>
                    </td>
                </tr></tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="button_spread"></td>
        </tr>
        <tr>
            <td id="Wireless">
                <div id="DivSSIDList_Table_Container">        
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInst2G" style = "table-layout:fixed">
                        <tbody>
                            <tr class="head_title align_center" >
                                <td class='width_per5'>&nbsp;</td>
                                <td class='width_per10' id='ssidIndex2g' style='display:none;'><script>document.write(wificovercfg_language['amp_homenetwork_index'])</script></td>
                                <td class='width_per25'><script>document.write(wificovercfg_language['amp_homenetwork_ssid'])</script></td>
                                <td class='width_per18'><script>document.write(wificovercfg_language['amp_homenetwork_bcast_ssid'])</script></td>
                                <td class='width_per25' id='ssidAuth2g'><script>document.write(wificovercfg_language['amp_homenetwork_auth']);</script></td>
                                <td class='width_per25' id='ssidMode2g' style='display:none;'><script>document.write(wificovercfg_language['amp_wificover_common_mode'])</script></td>
                                <td style="width: 34%;"><script>document.write(wificovercfg_language['amp_homenetwork_pwd'])</script></td>
                                <td class='width_per15' id='ssidDeviceNum2g' style='display:none;'><script>document.write(wificovercfg_language['amp_homenetwork_ap_num'])</script></td>
                                <td class='width_per13' id='ssidEnable2g' style='display:none;'><script>document.write(wificovercfg_language['amp_homenetwork_ssid_enable'])</script></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </tbody>
    </table>
    
<div id = 'divButton2G' style = 'display:none;'>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tbody><tr>
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="apply2GButton" name="apply2GButton" type="button" class="ApplyButtoncss buttonwidth_100px" onclick="homeNetworkSubmit('2G');">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="cancel2GButton" name="cancel2GButton" type="button" class="CancleButtonCss buttonwidth_100px" onclick="homeNetworkCancel('2G');">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
    </tr>
    </tbody>
</table>
</div>
</div>

<div id='space5gDiv' class="title_spread"></div>

<div id="basicSetting5G">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
        <tr>
            <td>
                <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                <tr>
                <td>
                    <script>document.write(wificovercfg_language['amp_homenetwork_5g']);</script>
                </td>
                <td style="text-align: right;">
                    <div id = 'divBtn5G' style = 'display:none;'>
                        <button class="NewDelbuttoncss" id="New5Gbutton" type="button" onclick="addSSIDTr('5G');">
                             <script>document.write(wificovercfg_language['amp_homenetwork_add_ssid']);</script></button>
                        <button class="NewDelbuttoncss" id="Modify5Gbutton" type="button" onclick="modifySSIDTr('5G');">
                            <script>document.write(wificovercfg_language['amp_homenetwork_modify_ssid']);</script></button>
                        <button class="NewDelbuttoncss" id="Delete5GButton" type="button" onclick="delSSIDTr('5G');">
                            <script>document.write(wificovercfg_language['amp_homenetwork_del_ssid']);</script></button>
                    </div>
                    <div id = 'divTxt5G'>
                        <script>
                        document.write(wificovercfg_language['amp_homenetwork_5g_explain']);
                        if (curLanguage.toUpperCase() == 'ARABIC') {
                            $('#divTxt5G').css('float','left');
                        }
                        </script>
                    </div>
                </td>
                </tr>
                </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="button_spread"></td>
        </tr>
        <tr>
            <td id="Wireless">
                <div id="DivSSIDList_Table_Container">    
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInst5G" style = "table-layout:fixed">
                        <tbody>
                            <tr class="head_title align_center" >
                                <td class='width_per5'>&nbsp;</td>
                                <td class='width_per10' id='ssidIndex5g' style='display:none;'><script>document.write(wificovercfg_language['amp_homenetwork_index'])</script></td>
                                <td class='width_per25'><script>document.write(wificovercfg_language['amp_homenetwork_ssid'])</script></td>
                                <td class='width_per18'><script>document.write(wificovercfg_language['amp_homenetwork_bcast_ssid'])</script></td>
                                <td class='width_per25' id='ssidAuth5g'><script>document.write(wificovercfg_language['amp_homenetwork_auth'])</script></td>
                                <td class='width_per25' id='ssidMode5g' style='display:none;'><script>document.write(wificovercfg_language['amp_wificover_common_mode'])</script></td>
                                <td style="width: 34%;"><script>document.write(wificovercfg_language['amp_homenetwork_pwd'])</script></td>
                                <td class='width_per15' id='ssidDeviceNum5g' style='display:none;'><script>document.write(wificovercfg_language['amp_homenetwork_ap_num'])</script></td>
                                <td class='width_per13' id='ssidEnable5g' style='display:none;'><script>document.write(wificovercfg_language['amp_homenetwork_ssid_enable'])</script></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </tbody>
    </table>

<div id = 'divButton5G' style = 'display:none;'>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tbody><tr>
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="apply5GButton" name="apply5GButton" type="button" class="ApplyButtoncss buttonwidth_100px" onclick="homeNetworkSubmit('5G');">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="cancel5GButton" name="cancel5GButton" type="button" class="CancleButtonCss buttonwidth_100px" onclick="homeNetworkCancel('5G');">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
    </tbody>
</table>
</div>
</div>
<div id="iotSsidSetting2G" style='display:none;'>
    <div id="spaceScnDiv" class="title_spread" style="height: 40px;"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
        <tr>
            <td>
                <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody><tr>
                    <td>
                      <script>document.write(wificovercfg_language['amp_wificover_iotssid_config']);</script>
                    </td>
                    <td style="text-align: right;">
                    <div id='divBtn2G'>
                        <button class="NewDelbuttoncss" id="NewIotbutton" type="button" onclick="addIotSSIDTr('Iot');">
                             <script>document.write(wificovercfg_language['amp_homenetwork_add_ssid']);</script></button>
                        <button class="NewDelbuttoncss" id="ModifyIotbutton" type="button" onclick="modifySSIDTr('Iot');">
                            <script>document.write(wificovercfg_language['amp_homenetwork_modify_ssid']);</script></button>
                        <button class="NewDelbuttoncss" id="DeleteIotButton" type="button" onclick="delIotSSID('Iot');">
                            <script>document.write(wificovercfg_language['amp_homenetwork_del_ssid']);</script></button>
                    </div>
                    </td>
                </tr></tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="button_spread"></td>
        </tr>
        <tr>
            <td id="Wireless_Iot">
                <div id="DivSSIDList_Table_Container">
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="wlanInstIot" style = "table-layout:fixed">
                        <tbody>
                            <tr class="head_title align_center" >
                                <td class='width_per5'>&nbsp;</td>
                                <td class='width_per30' style="width: 27%;"><script>document.write(wificovercfg_language['amp_homenetwork_ssid'])</script></td>
                                <td class='width_per10'><script>document.write(wificovercfg_language['amp_homenetwork_bcast_ssid'])</script></td>
                                <td class='width_per25'><script>document.write(wificovercfg_language['amp_homenetwork_auth'])</script></td>
                                <td class='width_per35' style="width: 33%;"><script>document.write(wificovercfg_language['amp_homenetwork_pwd'])</script></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </tbody>
    </table>
    
    <div id='divButtonIot' style="display:none;">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
            <tbody><tr>
            <td class="table_submit width_per25"></td>
            <td class="table_submit">
                <button id="applyIotButton" name="applyButton" type="button" class="ApplyButtoncss buttonwidth_100px" onclick="homeNetworkSubmit('Iot');">
                    <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
                <button id="cancelIotButton" name="cancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onclick="homeNetworkCancel('Iot');">
                    <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
            </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</div>

<div id="spaceScnDiv" class="title_spread" style="height: 40px;"></div>
<div id="divScnEnable" style="display:none;">
    <div class="func_title">
        <script>document.write(wificovercfg_language['amp_homenetwork_scn_title'])</script>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr border="1">
            <td class="table_title width_per30">
                <script>document.write(wificovercfg_language['amp_homenetwork_scn_enable']);</script>
            </td>
            <td class="table_right width_per70">
                <input id="EnableScnBox" type="checkbox" onclick="checkSSIDNum()">
                <span>
                </span>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
        <tbody>
            <tr>
                <td class="table_submit width_per25"></td>
                <td class="table_submit">
                    <button id="applyButtonscn" name="applyButtonscn" type="button" class="ApplyButtoncss buttonwidth_100px" onclick="CommitScnEnable();">
                        <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
                    <button id="cancelButtonscn" name="cancelButtonscn" type="button" class="CancleButtonCss buttonwidth_100px" onclick="CancleScnEnable();">
                        <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div id='spacePolicyDiv' class="title_spread"></div>
    <script>
    if (CfgMode.toUpperCase().indexOf('DTEDATA') >= 0){
       document.write('<div style="color:#6f2d91;font-weight:bold;">' + wificovercfg_language['amp_wificover_config_autoenable'] + '</div>');
    } else {
       document.write('<div>' + wificovercfg_language['amp_wificover_config_autoenable'] + '</div>');
    }
    </script>
    <table height="50" cellspacing="0" cellpadding="0" width="100%" border="0" class="tabal_01">        
        <tr id='trAutoExtendedPolicy1' class="tabal_01">
        <td>
        <input type="radio" name="AutoExtendedPolicy" id = "AutoExtendedPolicy" value = "1" onclick = "onClickSelectPolicy()" />
            <script> 
                document.write(wificovercfg_language['amp_wificover_config_not_autosync']);
            </script>
            </td>
        </tr >
        <tr id='trAutoExtendedPolicy2' class="tabal_01">
            <td >
                <input type="radio" name="AutoExtendedPolicy" id = "AutoExtendedPolicy" value = "2" onclick = "onClickSelectPolicy()" />
                    <script>   
                        document.write(wificovercfg_language['amp_wificover_config_specify_autosync']);
                    </script>
            </td>
            <td class="tabal_01">
                <select name="CoverSsidSelect" style="width:160px;" id="Cover2GSsidSelect" onchange="funCover2GSsidSelect();">
                    <script >
                    var DoubelWlanSign  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
                    
                       var selectedflag = false;
                       for (var index = 0; index < WlanListNum; index++)
                       {                        
                            if(WlanList[index].LowerLayers.substring(WlanList[index].LowerLayers.length-1) == '1')
                            {
                                var wlanInst = getInstIdByDomain(WlanList[index].domain);
                                if (isShowWlan(WlanList[index]) == false)
                                {
                                    continue;
                                }
                                
                                var ssid2GString = GetSSIDStringContent(htmlencode(WlanList[index].ssid),32);
                                if ((0 == DoubelWlanSign) && (1 != isShowHomeNetWork))
                                {
                                   if (wlanInst == ConfigurationByRadio[0].AutoExtendedSSIDIndex)
                                   {
                                        selectedflag = true;
                                       document.write('<option value='+ wlanInst +' selected>' + ssid2GString + '</option>');
                                   }
                                   else
                                   {
                                       document.write('<option value='+ wlanInst +'>' + ssid2GString + '</option>');
                                   }
                                }
                                else
                                {
                                    if (wlanInst == ConfigurationByRadio[0].AutoExtendedSSIDIndex)
                                    {
                                        selectedflag = true;
                                        document.write('<option value='+ wlanInst +' selected>' + ssid2GString + '(2.4G)' + '</option>');
                                    }
                                    else
                                    {
                                        document.write('<option value='+ wlanInst +'>' + ssid2GString + '</option>');
                                    }
                                }   
                           }
                       }
                       document.write('<option value='+ 0 +' ' + (selectedflag ? "" : "selected") + '  >' +'</option>');   
                   </script>
                </select>
            </td>    
            <td class="tabal_01">
                <select name="CoverSsidSelect" style="width:160px;" id="Cover5GSsidSelect" onchange="funCover5GSsidSelect();">
                    <script >
                        if (1 != isShowHomeNetWork)
                        {
                            setDisplay('Cover5GSsidSelect',(1 == DoubleFreqFlag));
                            if (IsNotShowConfig5G()) {
                                setDisplay('Cover5GSsidSelect', 0);
                            }
                        }
                       
                       var selectedflag = false;
                       for (var index = 0; index < WlanListNum; index++)
                       {
                           if((WlanList[index].LowerLayers.substring(WlanList[index].LowerLayers.length-1) == '2'))
                           {
                                   var wlanInst = getInstIdByDomain(WlanList[index].domain);
                                if (isShowWlan(WlanList[index]) == false)
                                
                                {
                                    continue;
                                }
                                
                                var ssid5GString = GetSSIDStringContent(htmlencode(WlanList[index].ssid),32);
                              if (wlanInst == ConfigurationByRadio[1].AutoExtendedSSIDIndex)
                               {
                                   selectedflag = true;
                                   document.write('<option value='+ wlanInst +' selected>' + ssid5GString + '(5G)' +'</option>');
                               }
                               else
                               {
                                   document.write('<option value='+ wlanInst +'>' + ssid5GString + '(5G)' +'</option>');
                               }
                           }
                       }
                       document.write('<option value='+ 0 +' ' + (selectedflag ? "" : "selected") + '  >' +'</option>');   
                   </script>
                  </select>
            </td>
        </tr>
        <tr id='trAutoExtendedPolicy3' class="tabal_01">
            <td>
                <input type="radio" name="AutoExtendedPolicy" id = "AutoExtendedPolicy" value = "3" onclick = "onClickSelectPolicy()" />
                <script>   
                    document.write(wificovercfg_language['amp_wificover_config_make_effort_sync']);
                </script>
            </td>
                
        </tr>
        <script>
                if(0 == WifiCoverService[0].AutoExtended)
                {
                    setRadio('AutoExtendedPolicy',1);
                    setDisable('Cover2GSsidSelect',1);
                    setDisable('Cover5GSsidSelect',1);
                }
                else if(WifiCoverService[0].AutoExtended && (WifiCoverService[0].AutoExtendedPolicy == 0))
                {
                    setRadio('AutoExtendedPolicy',2);
                }
                else if(WifiCoverService[0].AutoExtended && WifiCoverService[0].AutoExtendedPolicy)
                {
                    setRadio('AutoExtendedPolicy',3);
                    setDisable('Cover2GSsidSelect',1);
                    setDisable('Cover5GSsidSelect',1);
                }                
        </script>
    </table>

<div class="func_spread"></div>

<form id="WifiCoverCfgForm" action="../network/set.cgi">

<div class="func_title"><SCRIPT>document.write(wificovercfg_language["amp_wificover_config_list_head"]);</SCRIPT></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
  <tr  class="head_title"> 
    <script language="JavaScript" type="text/JavaScript">
        if (isBponFlag == 1) {
            document.writeln("<td>AP ID</td>");
        }
    </script>
    <td BindText='amp_wificover_config_devtype'></td>
    <script language="JavaScript" type="text/JavaScript">
        if (isBponFlag == 1) {
            document.writeln("<td>" + "AP " + wificovercfg_language['amp_topoAdjustSettings_name'] + "</td>");
        } else {
            document.writeln("<td>" + wificovercfg_language['amp_wificover_onlineap_sn'] + "</td>");
        }
    </script>
    <td BindText='amp_wificover_config_status'></td>
    <td BindText='amp_wificover_config_onlinetime'></td>
    <td BindText='amp_wificover_config_status_desc'></td>
  </tr>
  <script language="JavaScript" type="text/JavaScript">
   var index = 0;
   
   FirstCfgApInst = 0;
   
   if (0 == apNum)
   {
            document.writeln("<tr class='tabal_01'>");
            if (isBponFlag == 1) {
                document.writeln("<td class='align_center'>--</td>");
            }
            document.writeln("<td class='align_center'>--</td>");
            document.writeln("<td class='align_center'>--</td>");
            document.writeln("<td class='align_center'>--</td>");
            document.writeln("<td class='align_center'>--</td>");
            document.writeln("<td class='align_center'>--</td>");
            document.writeln("</tr>");
   }
   else
   {
        var CfgApNum = 0;
        var theDeviceStatus = '-';
       for (index = 0; index < apNum; index++)
       {
            var ApInstId = getInstIdByDomain(apDeviceList[index].domain);
            
            CfgApNum++;
            if (1 == CfgApNum)
            {
                FirstCfgApInst = ApInstId;
            }
            
            theDeviceStatus = getTheDeviceStatus(apDeviceList[index]);
            if(index%2 == 0)
            {
                document.write('<tr id="record_' + ApInstId  + '" class="tabal_01" onclick="selectLine(this.id);setUpSSIDDisabled(this.id);">');
            }
            else
            {
                document.write('<tr id="record_' + ApInstId  + '" class="tabal_02" onclick="selectLine(this.id);setUpSSIDDisabled(this.id);">');
            }

            if (isBponFlag == 1) {
                document.write('<td class=\"align_center\">' + GetApInstByDomain(apDeviceList[index].domain) + '</td>');
            }

            document.write('<td class=\"align_center\">'+ htmlencode(apDeviceList[index].DeviceType)    +'</td>');
            if (isBponFlag == 1) {
                document.write('<td class=\"align_center\">' + htmlencode(GetNameByMac(apDeviceList[index].APMacAddr)) + '</td>');
            } else {
                document.write('<td class=\"align_center\">'+ htmlencode(apDeviceList[index].SerialNumber)    +'</td>');
            }

            document.write('<td class=\"align_center\">'+ htmlencode(theDeviceStatus)    +'</td>');
            document.write('<td class=\"align_center\">'+ htmlencode(apDeviceList[index].UpTime)    +'</td>');
            
            getSyncStauts(apDeviceList[index].SyncStatus);
            document.write('<td class=\"align_center\">'+ htmlencode(syncstatus)    +'</td>');

            document.write("</tr>");
       }
   }   
  </script>
</table>

<div id='divApDetailCfg'>

<div class="func_spread"></div>

<div class="func_title"><SCRIPT>document.write(wificovercfg_language["amp_wificover_config_detail_head"]);</SCRIPT></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" >
    <script language="JavaScript" type="text/JavaScript">
    var DoubelWlanFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';

    if (((isShowHomeNetWork != 1) && (DoubelWlanFlag == 0)) || IsNotShowConfig5G())
    {
        document.write('<tr class="tabal_01" >');

        document.write('<td width="35%" >');
        document.write(wificovercfg_language['amp_wificover_config_extssidselect']);
        document.write('</td>');
        
        document.write('<td class="table_right" >');
        document.write("<ul style= 'list-style:none;padding-left:5px;margin-top:5px; margin-bottom:5px;'>");
        for (var index = 0; index < WlanListNum; index++)
        {
            var extEnable = 0;
            var wlanInst = getInstIdByDomain(WlanList[index].domain);
            
            var radio = (WlanList[index].LowerLayers.substring(WlanList[index].LowerLayers.length-1) == '1') ? '(2.4G)' : '(5G)';

            if (isShowWlan(WlanList[index]) == false)
            {
                continue;
            }

            if (IsNotShowConfig5G()) {
                if (radio == '(5G)') {
                    continue;
                }
            }
            
            document.write("<li>");

            document.write('<input type="checkbox" style = "margin-left:20px" id = "checkssid '+ wlanInst +'" name="ExtendedWLC_' + wlanInst + '" value="ExtendedWLC_' + wlanInst + '" onClick="setCheckDisable(this.id)">' + GetSSIDStringContent(htmlencode(WlanList[index].ssid),32));
            for (var extWlcLoop = 0; extWlcLoop < apExtendedWLC.length - 1; extWlcLoop++)
            {
                if (wlanInst == apExtendedWLC[extWlcLoop].SSIDIndex)
                {
                    if(true == IsAuthEAP(index))
                    {
                        extEnable = 1;
                    }
                    break;
                }
            }
            
            setCheck('ExtendedWLC_' + wlanInst, extEnable); 
            
            document.write("</li>");        
        }
        document.write("</ul>"); 
        document.write('</td>');
        document.write('</tr>');
    }
    else
    {
        document.write('<tr class="tabal_01">');
        
        document.write('<td width="35%" rowspan="2" >');
        document.write(wificovercfg_language['amp_wificover_config_extssidselect']);
        document.write('</td>');

        document.write('<td class="table_right" >');

        document.write("<ul style='list-style:none;padding-left:5px;margin-top:5px; margin-bottom:5px '>");
        
        for (var index = 0; index < WlanListNum; index++)
        {
            var wlanInst = getInstIdByDomain(WlanList[index].domain);
            var radio = (WlanList[index].LowerLayers.substring(WlanList[index].LowerLayers.length-1) == '1') ? '(2.4G)' : '(5G)';
                
            if (isShowWlan(WlanList[index]) == false)
            {
                continue;
            }
            
            if (-1 != WlanList[index].X_HW_RFBand.indexOf("5G"))
            {
                continue;
            }     
            
            if (isVideoRetrans == 1) {
                if (WlanList[index].X_HW_RFBand.indexOf("2.4G") != -1) {
                    continue;
                }
            }

            document.write("<li>");

            document.write('<input type="checkbox" id = "checkssid '+ wlanInst +'" style = "margin-left:20px" name="ExtendedWLC_' + wlanInst + '" value="ExtendedWLC_' + wlanInst + '" onClick="setCheckDisable(this.id)" >' + GetSSIDStringContent(htmlencode(WlanList[index].ssid),32) + radio);
        
            for (var extWlcLoop = 0; extWlcLoop < apExtendedWLC.length - 1; extWlcLoop++)
            {
                if (wlanInst == apExtendedWLC[extWlcLoop].SSIDIndex)
                {
                    if(true == IsAuthEAP(index))
                    {
                        extEnable = 1;
                    }
                    break;
                }
            }
            
            setCheck('ExtendedWLC_' + wlanInst, extEnable);   
            
            document.write("</li>");
            
        }

        if (isVideoRetrans == 0) {
            document.write("</ul>"); 
            document.write('</td>');
            document.write('</tr>');
            document.write('<tr class="tabal_01">');
            document.write('<td class="table_right" >');
            document.write("<ul style= 'list-style:none;padding-left:5px;margin-top:5px; margin-bottom:5px'>");
        }

        for (var index = 0; index < WlanListNum; index++)
        {
            var wlanInst = getInstIdByDomain(WlanList[index].domain);
            var radio = (WlanList[index].LowerLayers.substring(WlanList[index].LowerLayers.length-1) == '1') ? '(2.4G)' : '(5G)';
            
            if (isShowWlan(WlanList[index]) == false)
            {
                continue;
            }
            
            if (-1 != WlanList[index].X_HW_RFBand.indexOf("2.4G"))
            {
                continue;
            }
            
            
            document.write("<li>");
            document.write('<input type="checkbox" id = "checkssid '+ wlanInst +'" style = "margin-left:20px" name="ExtendedWLC_' + wlanInst + '" value="ExtendedWLC_' + wlanInst + '" onClick="setCheckDisable(this.id)" >' + GetSSIDStringContent(htmlencode(WlanList[index].ssid),32) + radio);
            
            for (var extWlcLoop = 0; extWlcLoop < apExtendedWLC.length - 1; extWlcLoop++)
            {
                if (wlanInst == apExtendedWLC[extWlcLoop].SSIDIndex)
                {
                    if(true == IsAuthEAP(index))
                    {
                        extEnable = 1;
                    }
                    break;
                }
            }
            
            setCheck('ExtendedWLC_' + wlanInst, extEnable);
            
            
            document.write("</li>");
        }  
        document.write("</ul >");  
        document.write('</td>');
        document.write('</tr>');
    }

    </script>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr >
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
      <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="ApplySubmit();"><script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
      <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="cancelValue();"><script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
</table>
</div>

</form>
</div>

<div id='meun_2'>

<div id="divSyncWifiSwitch">
<div class="title_spread"></div>
<div>
    <tr>
        <td>
            <input type="checkbox" name="SyncWifiSwitch" id="SyncWifiSwitch"  onclick="SyncWifiSwitch();" value="OFF"/>
        </td>
    <td>
    <script>
        document.write(wificovercfg_language['amp_wificover_config_wlan_enable_sync']);
    </script></td>
    <script>
        if(1 == WifiCoverService[0].SyncWifiSwitch)
        {
            setCheck('SyncWifiSwitch',1);
        }
        else
        {
            setCheck('SyncWifiSwitch',0);
        }
                if (1 == PccwFlag)
        {
            setDisable('SyncWifiSwitch', 1);
        }
    </script>
    </tr>
</div>
</div>

<div id="trPublicWiFi" style="display:none">
    <tr>
        <td>
            <input type="checkbox" name="syncPublicWiFiEnable" id="syncPublicWiFiEnable"  onclick="syncPublicWiFiSubmit();" value="OFF"/>
            <script>
                setCheck('syncPublicWiFiEnable', WifiCoverService[0].AutoExtendPublicWiFi);
                var wifiCoverEnableText = wificovercfg_language['amp_wificover_autoExtendPublicWiFiEnable'];
                document.write(wifiCoverEnableText);
            </script>
        </td>
    </tr>
</div>

<div class="title_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button" id = "tableRETEnableSwitch">
    <tr>
        <td class="width_per30" colspan='2'>
            <input type="checkbox" name="RETEnableSwitch" id="RETEnableSwitch" value="OFF"/>
        <script>
            document.write(wificovercfg_language['amp_dualretrans_switch']);
        </script>
        <script>
            if(1 == WifiCoverService[0].RETEnable)
            {
                setCheck('RETEnableSwitch',1);
            }
            else
            {
                setCheck('RETEnableSwitch',0);
            }            
        </script>
        </td>
    </tr>
    <tr class='tabal_01'>
        <td class="width_per30" colspan='2'><script>document.write(wificovercfg_language['amp_rtcpport_setting']);</script>
       
            <input id="RTCP_port" type="text" value='8027' style="width:50px;margin-left:20px;">
        <script>
            if(curLanguage == 'arabic')
            {
                document.write('<span dir="rtl" class="gray" style="margin-left:10px;">');
            }
            else
            {
                document.write('<span class="gray" style="margin-left:10px;">');
            }
        </script>
        <script>document.write(wificovercfg_language['amp_rtcpthrehold_value']);</script></span></td>


    </tr>
    <tr id = 'bondingSwitchTr' style = "display:none;">
        <td class="width_per30" colspan='2'>
            <input type="checkbox" name="BondingEnableSwitch" id="BondingEnableSwitch" onchange='BondingSwitchChange();'/>
            <script>
                document.write(wificovercfg_language['amp_bonding_switch']);
            </script>
        </td>
    </tr>
    <tr id = 'bondingRatio2GTr' style = "display:none;">
        <td class="width_per30"><script>document.write(wificovercfg_language['amp_bondingRatio2G_setting']);</script>
        </td>
        <td class="width_per30">
        <input id="BondingRatio2G" type="text" value='1' style="width:50px;margin-left:20px;">
        <span class="gray" style="margin-left:10px;">
        <script>document.write(wificovercfg_language['amp_bondingRatio2G_switch']);</script></span></td>
    </tr>
    <tr id = 'bondingRatio5GTr' style = "display:none;">
        <td class="width_per30"><script>document.write(wificovercfg_language['amp_bondingRatio5G_setting']);</script>
        </td>
        <td class="width_per30">
        <input id="BondingRatio5G" type="text" value='3' style="width:50px;margin-left:20px;">
        <span class="gray" style="margin-left:10px;">
        <script>document.write(wificovercfg_language['amp_bondingRatio5G_switch']);</script></span></td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button" id = "tableRtcp">
  <tr >
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="RetSubmitButton" name="RetSubmitButton" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="RETEnableOpeSwitch();">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="RetCancelButton" name="RetCancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="RETEnableCancel();">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
</table>

<div class="title_spread"></div>
<form id="WifiCoverSwitchForm">

<div id="wlanadv_head" class="func_title"><SCRIPT>document.write(wificovercfg_language["amp_wificover_fbt_title"]);</SCRIPT></div>

<table  width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr border="1" id="AutoSwitchAPRow">
        <td class="table_title width_per30" id="AutoSwitchAPColleft"><script>document.write(wificovercfg_language["amp_wificover_fbt_enable"]);</script></td>
        <td id="AutoSwitchAPCol" class="table_right width_per70">
            <input id="AutoSwitchAP" type="checkbox">
            <button id="btnShowAdvSettings" type="button"  class="NewDelbuttoncss" style="margin-left:20px;" onClick="showDivAdvSettings(1);">
            <script>document.write(wificovercfg_language['amp_wificover_show_adv_setting']);</script></button>
            <button id="btnHideAdvSettings" type="button"  class="NewDelbuttoncss" style ="margin-left:20px; display:none;" onClick="showDivAdvSettings(0);">
            <script>document.write(wificovercfg_language['amp_wificover_hide_adv_setting']);</script></button>
        </td>
    </tr>
</table>

<div id="DivAdvSettings" style = "display:none;">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
  <tr  class="head_title"> 
    <td class="width_per30"><script>document.write(wificovercfg_language['amp_wificover_adv_setting_title']);</script></td>
    <td class="width_per10"><script>document.write(wificovercfg_language['amp_wificover_adv_setting_2g']);</script></td>
    <td class="width_per10 5GClass"><script>document.write(wificovercfg_language['amp_wificover_adv_setting_5g']);</script></td>
    <td><script>document.write(wificovercfg_language['amp_wificover_adv_setting_explain']);</script></td>
  </tr>
  
  <tr class='tabal_01'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_wifiCover_forceSwitch']);</script></td>
    <td class='align_center'>
        <input id="wifiCoverForceSwitch2G" type="text" style="width:50px">
    </td>
    <td class='align_center 5GClass'>
        <input id="wifiCoverForceSwitch5G" type="text" style="width:50px">
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_wifiCover_forceSwitchValues']);</script></span></td>
  </tr>
  <tr id='wifiCoverForceInterDiv' class='tabal_01' style='display:none;'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_wifiCover_forceInterval']);</script></td>
    <td class='align_center'>
        <input id="wifiCoverForceInterVal2G" type="text" style="width:50px">
    </td>
    <td class='align_center 5GClass'>
        <input id="wifiCoverForceInterVal5G" type="text" style="width:50px">
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_wifiCover_forceIntervalValues']);</script></span></td>
  </tr>
  <tr class='tabal_01'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_wifiCover_LowRssiThreshold']);</script></td>
    <td class='align_center'>
        <input id="LowRssiThreshold2G" type="text" style="width:50px">
    </td>
    <td class='align_center 5GClass'>
        <input id="LowRssiThreshold5G" type="text" style="width:50px">
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_wifiCover_LowRssiThreshold_Values']);</script></span></td>
  </tr>
  <tr class='tabal_01'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_wifiCover_HighRssiThreshold']);</script></td>
    <td class='align_center'>
        <input id="HighRssiThreshold2G" type="text" style="width:50px">
    </td>
    <td class='align_center 5GClass'>
        <input id="HighRssiThreshold5G" type="text" style="width:50px">
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_wifiCover_HighRssiThreshold_Values']);</script></span></td>
  </tr>
  <tr class='tabal_01'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_wifiCover_IncreasedRssiThreshold']);</script></td>
    <td class='align_center'>
        <input id="IncreasedRssiThreshold2G" type="text" style="width:50px">
    </td>
    <td class='align_center 5GClass'>
        <input id="IncreasedRssiThreshold5G" type="text" style="width:50px">
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_wifiCover_IncreasedRssiThreshold_Values']);</script></span></td>
  </tr>
</table>
</div>

<script>
var TableClass = new stTableClass("width_per30", "width_per70", "", "StyleSelect");
HWParsePageControlByID("WifiCoverSwitchForm", TableClass ,wificovercfg_language, null);
setCheck('AutoSwitchAP', WifiCoverService[0].AutoSwitchAP);
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr >
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="applyButtonfbt" name="applyButtonfbt" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="wifiCoverAdvSubmit();">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="cancelButtonfbt" name="cancelButtonfbt" type="button" class="CancleButtonCss buttonwidth_100px" onClick="wifiCoverAdvCancel();">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
</table>

</form>
<div class="title_spread"></div>
<form id="WifiSensitivityForm">
<div class="func_title"><script>document.write(wificovercfg_language['amp_wificover_and_bandsteering_title']);</script></div>
<div id= "drag_bar" class="table_button">
    <table style="margin-left:100px;">
        <tr>
            <td id="wificoverandBSInput">
                <input type="radio" id="bandsteer0" name="bandsteer" value="0" >
                    <img src="../../../images/scale2.gif" style="width:100px;height:14px;">
                </input>
                <input type="radio" id="bandsteer1" name="bandsteer" value="1" >
                    <img src="../../../images/scale2.gif" style="width:100px;height:14px;">
                </input>
                <input type="radio" id="bandsteer2" name="bandsteer" value="2" />
            </td>
        </tr>        
        <tr>
            <td>
                <div class="levelleft">
                    <script>document.write(wificovercfg_language['amp_wificover_and_bandsteering_low']);</script>
                </div>
                <div class="levelmiddle">
                    <script>document.write(wificovercfg_language['amp_wificover_and_bandsteering_middle']);</script>
                </div>
                <div class="levelright">
                    <script>document.write(wificovercfg_language['amp_wificover_and_bandsteering_high']);</script>
                </div>
            </td>
        </tr>
    </table>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr >
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="applyButton" name="applyButton" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="wifiCoverAndBandSteeringSubmit();">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="cancelButton" name="cancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="wifiCoverAndBandSteeringCancel();">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
</table>
</form>
<script>
if(curLanguage == 'arabic')
{
    getElementById("wificoverandBSInput").style.direction= "ltr";
}    
</script>

<div class="func_spread"></div>

<div id='divLiveCtlSwitch'>
	<input type='checkbox' name='LiveCoverEnable' id='LiveCoverEnable' onClick='LiveCoverEnableSubmit();' value="ON">
	  <script>
		document.write(wificovercfg_language['amp_wificover_config_live_access_control']); 
	  </script>
	</input>
</div>

<div id="divLiveCtlValue">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
		<tbody>
			<tr class='tabal_01'>
				<td class='align_center'><script>document.write(wificovercfg_language['amp_wifiCover_live_acess_RssiThreshold']);</script></td>
				<td class='align_center' style='text-align: left;'>				
					<input id="LiveAccessThrehold" type="text" style="width:50px" value='-80'>
					<style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_wifiCover_live_acess_RssiThreshold_Values']);</script></span>
				</td>
			</tr>
		 </tbody>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
	  <tr >
		<td class="table_submit width_per25"></td>
		<td class="table_submit">
			<button id="LiveAccessApplyButton" name="LiveAccessApplyButton" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="LiveCoverSubmit();">
				<script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
			<button id="LiveAccessCancelButton" name="LiveAccessCancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="LiveCoverCancel();">
				<script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
		 </td>
	   </tr>
	</table>    
</div>

<div class="func_spread"></div>

<div id='divAcs'>
<div class="func_title"><script>document.write(wificovercfg_language["amp_wificover_acs_title"]);</script></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr>
    <td class="table_submit width_per25"> <script>document.write(wificovercfg_language["amp_wificover_acs_enforce"]);</script></td>
    <td class="table_submit">
        <button id="startAcsButton" name="startAcsButton" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="startAcsSubmit();">
            <script>document.write(wificovercfg_language["amp_wificover_acs_start"]);</script></button>
     </td>
   </tr>
</table>    
</div>
<div class="func_spread"></div>

<div id='divTopoAdjustPolicy'>
<div class="func_title"><script>document.write(wificovercfg_language['amp_topoAdjustPolicy_title']);</script></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr>
    <td class="width_per30"> <input name="TopoAdjustPolicy" id="TopoAdjustPolicy" type="radio" value="1" checked="checked" onclick="IsShowSettings()"/>
    <script>document.write(wificovercfg_language['amp_topoAdjustPolicy_noSta']);</script></td>
    <td> <input name="TopoAdjustPolicy" id="TopoAdjustPolicy" type="radio"  value="2"  onclick="IsShowSettings()" /><script>document.write(wificovercfg_language['amp_topoAdjustPolicy_linkQuality']);</script></td>
  </tr>
  <tr class='adjustPolicyClass'>
    <td class="width_per30"> </td>
    <td>
        <input type="checkbox" name="rml" id="rmlLowRateThrehold" value="2" onclick=""/>
        <script>document.write(wificovercfg_language['amp_LowRateThrehold_policy']);</script>
    </td>
  </tr>
  <tr class='adjustPolicyClass'>
    <td class="width_per30"> </td>
    <td>
        <input type="checkbox" name="rml" id="rmlPacketLossRateThrehold" value="4" onclick=""/>
        <script>document.write(wificovercfg_language['amp_PacketLossRateThrehold_policy']);</script>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr >
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="TopoAdjustPolicyApplyButton" name="TopoAdjustPolicyApplyButton" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="TopoAdjustPolicySubmit();">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="TopoAdjustPolicyCancelButton" name="TopoAdjustPolicyCancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="TopoAdjustPolicyCancel();">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
</table>
    
</div>

<div class="func_spread"></div>

<div id='divTopoAdjustSettings'>
<div class="func_title"><script>document.write(wificovercfg_language['amp_topoAdjustSettings_title']);</script></div>
<table id="tableTopoAdjustSettings" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
  <tr  class="head_title"> 
    <td class="width_per30"><script>document.write(wificovercfg_language['amp_topoAdjustSettings_name']);</script></td>
    <td class="width_per10"><script>document.write(wificovercfg_language['amp_topoAdjustSettings_value']);</script></td>
    <td><script>document.write(wificovercfg_language['amp_topoAdjustSettings_explain']);</script></td>
  </tr>
  
  <tr class='tabal_01'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_LowRateThrehold_setting']);</script></td>
    <td class='align_center'>
        <input id="LowRateThrehold" type="text" style="width:50px" value='50'>
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_LowRateThrehold_Values']);</script></span></td>
  </tr>
  <tr class='tabal_01'>
    <td class='align_center'><script>document.write(wificovercfg_language['amp_PacketLossRateThrehold_setting']);</script></td>
    <td class='align_center'>
        <input id="PacketLossRateThrehold" type="text" style="width:50px" value='3'>
    </td>
    <td style='text-align: left;'><span class="gray"><script>document.write(wificovercfg_language['amp_PacketLossRateThrehold_Values']);</script></span></td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
  <tr >
    <td class="table_submit width_per25"></td>
    <td class="table_submit">
        <button id="TopoAdjustSettingsApplyButton" name="TopoAdjustSettingsApplyButton" type="button"  class="ApplyButtoncss buttonwidth_100px" onClick="TopoAdjustSettingsSubmit();">
            <script>document.write(wificovercfg_language['amp_wificover_config_apply']);</script></button>
        <button id="TopoAdjustSettingsCancelButton" name="TopoAdjustSettingsCancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="TopoAdjustSettingsCancel();">
            <script>document.write(wificovercfg_language['amp_wificover_config_cancel']);</script></button>
     </td>
   </tr>
</table>
    
</div>

<div class="func_spread"></div>
</div>

</div>

<script>
if (true == UPNPCfgFlag)
{
    setDisplay('divWifiCoverCfgAll', WifiCoverService[0].Enable);
}
else
{
    setDisplay('divWifiCoverCfgAll', 1);
}
</script>

<div>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td style = 'height:10px'></td></tr>
</table>    
</div>

</body>
</html>
