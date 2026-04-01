var curUserType='<%HW_WEB_GetUserType();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var gzcmccFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_GZCMCC);%>';
var AtTelecomFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELECOM);%>';
var AmpQHOPFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_QHOP_SUPPORT);%>';
var WdsFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WDS);%>';
var AisPrev = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_AIS);%>';
var AntGain = '<%HW_WEB_GetSPEC(AMP_SPEC_ANT_GAIN.UINT32);%>';
var bztlfFlag = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_BZTLF);%>';
var cusTripleT = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TRIPLET_3BB);%>';
var DfsWeatherRadarEnable  = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WIFIInfo.X_HW_ChannelAutoSelectModify.WeatherRadarEnable);%>';
var cusTrue = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TRUE);%>';
var cusUNE = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_UNE);%>';
var curWlanChipType2G = 0;
var curWlanChipType5G = 0;
var AmpTxBeamformingFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TX_BEAMFORMING_SHOW);%>';
var ShowMCSFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_MCS_VISIBILITY);%>';
var RegulatoryDomainImmutable = '<%HW_WEB_GetFeatureSupport(FT_WLAN_REGULATORYDOMAIN_IMMUTABLE);%>';
var t2Flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TDEWIFI);%>';
var RSSIThrFlagPrev = '<%HW_WEB_GetFeatureSupport(AMP_FT_RSSI_THRESHOLD);%>';
var cablevisFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_CABLEVISION);%>';
var ZigBeeSupport = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IOT_ZIGBEE_EXIST);%>';
var ZigbeeSwitch = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IOT_ZIGBEE.Enable);%>';
var DongleSwitch = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IOT_DONGLE.Enable);%>';
var AmpSCSFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SCS_SUPPORT);%>';
var CountryFixFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WIFI_COUNTRY_FIX);%>';
var OnlyTde2Flag= '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_ONLY_FOR_TDE);%>';
var CountryShowFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WIFI_COUNTRY_SHOW);%>';
var TribandFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TRIBAND_AP);%>';
var DslTelMexFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var DslTalkTalkFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var wlanChipType2G = '<%WEB_GetWlanChipType(2G);%>';
var wlanChipType5G = '<%WEB_GetWlanChipType(5G);%>';
var X_HT80Flag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SHOW_5GBANDWIDTH_80M);%>';
var PartSupportFlag = '<%HW_WEB_IsSupportConfWorkMode(2G);%>';
var PartSupportFlag5G = '<%HW_WEB_IsSupportConfWorkMode(5G);%>';
var wifiWorkMode = '<%HW_WEB_GetFeatureSupport(AMP_FT_WIFI_WORK_MODE);%>';
var crossWallFeature = '<%HW_WEB_GetFeatureSupport(AMP_FT_REMOVE_CROSSWALL);%>';
var cusTruerg = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TRUERG);%>';
var truergFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_TAILAND_TRUERG);%>';

var WiFiRadioArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.{i},GuardInterval,stWiFiRadio,EXTEND);%>;
var XHWAdvanceCfgArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.{i}.X_HW_AdvanceCfg,UsersPerSSIDEnable,stXHWAdvanceCfg);%>;
var AirtimeConfs = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_AirtimeFairness,Enable,stAirtimeConf,EXTEND);%>;
var TMCZSTflag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TMCZST);%>';
var webEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebEnable);%>';
var aisAp = '<%HW_WEB_GetFeatureSupport(FT_WLAN_AISAP);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var rosFlag = '<%HW_WEB_GetFeatureSupport(FT_ROS_UNION);%>';
var isVideoRetrans = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIDEO_TRANS);%>';
var isShowCustomize = '<%HW_WEB_GetFeatureSupport(FT_WLAN_HT20_CUSTOMIZE);%>';
var isHide160M = '<%HW_WEB_GetFeatureSupport(FT_WLAN_HIDE_160M);%>';
var DtHuFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DT_HUNGARY);%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';

var chlwidth80Res = ((t2Flag=='1') || (bztlfFlag == '1') || ((X_HT80Flag == '1') && (cfgMode.toUpperCase() == 'DMASMOVIL2WIFI'))) ? 'amp_chlwidth_80' : 'amp_chlwidth_auto204080';
var sysUserType='0';
var sptUserType ='1';
var ZigBeeEnable = false;
var AisFlag;
var telmexSpan = false;
var wlanpage;
var TripleT = cusTripleT & capAntiInterferenceMode;
var capWifiWorkMode = cusTrue & capAntiInterferenceMode;
var curWlanChipType = curWlanChipType2G;
var SelHighBand = top.wlanAdv_selHighBand;
var RSSIThrFlag = 0;
var enbl = WlanEnable[0].enable;
var channelscopeflag = 0;
var IsCommonSupport = 0;

var WiFiRadioArrLen = WiFiRadioArr.length - 1;
var WiFiRadio = WiFiRadioArr[0];
var XHWAdvanceCfg = new Array();
var WlanAdv = WlanAdvs[0];
var AttachConf = AttachConfs[0];
var AirtimeConf = AirtimeConfs[0];
var WlanBasic = wlanArr[0];
var totalWlanAttr;
var totalHighBand5gNum = 0;
var firstSSID2G;
var capAisAutoHT160 = 0;
var turkcellFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TURKCELL);%>';
var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    isFitAp = 1;
}

if (cfgMode.toUpperCase() == "RDSGATEWAY") {
    CountryFixFlag = 1;
    if (curUserType == sysUserType) {
        CountryFixFlag = 0;
    }
}

if ((AisPrev == 1) && (AntGain == 5)) {
    AisFlag = 1;
} else {
    AisFlag = 0;
}
var currentUserName = '<%HW_WEB_GetCurUserName();%>';
var userName= '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1.UserName);%>';
var curWifiChannel = '';
var curHT20= '';
var curStandard = '';

var megacablepwd = '<%HW_WEB_GetFeatureSupport(FT_WLAN_MEGACABLEPWD);%>';
var bsdGlbSubmitFirst = 1;
if ((cusTruerg == 1)|| (rosFlag == 1) || (turkcellFlag == 1) || (AisPrev == 1)) {
    bsdGlbSubmitFirst = 0;
}

if (aisAp == "1") {
    AisPrev = 1;
}

if ((ZigBeeSupport == '1') && (ZigbeeSwitch == 1)) {
    ZigBeeEnable = true;
}

if ((TelMexFlag == '1') && (language.toUpperCase() == 'SPANISH')) {
    telmexSpan = true;
}

if (location.href.indexOf("WlanAdvance.asp?") > 0) {
    wlanpage = location.href.split("?")[1]; 
    top.WlanAdvancePage = wlanpage;
}
wlanpage = top.WlanAdvancePage; 
initWlanCap(wlanpage);

if (aisAp == 1) {
    chlwidth80Res = 'amp_chlwidth_automatic';
    if (capHT160 == 1) {
        capAisAutoHT160 = 1;
    }
}

var freq = '2G';
if (wlanpage == "5G") {
    freq = '5G';
}

if (wlanpage == '5G') {
    curWlanChipType = curWlanChipType5G;
}

if (typeof top.wlanAdv_selHighBand == 'undefined') {
    top.wlanAdv_selHighBand = 0;
}

if ((RSSIThrFlagPrev == 1) && (curWlanChipType == 1)) {
    RSSIThrFlag = 1;
} else {
    RSSIThrFlag = 0;
}

if (wlanpage == '5G') {
    PartSupportFlag = PartSupportFlag5G;
}

if ((PartSupportFlag == 1) && (language.toUpperCase() != 'CHINESE')) {
    IsCommonSupport = 1;
}

if (AirtimeConf == null) {
    AirtimeConf = new stAirtimeConf("InternetGatewayDevice.LANDevice.1.WiFi.X_HW_AirtimeFairness", "0");
}

if (WlanBasic == null) {
    WlanBasic = new stWlanWifi("", "", "", "", "", "11n", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
}

SetWiFiRadioDefault();
if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
    getWlanWifiDefaultForBand(1);
} else {
    getWlanWifiDefaultForBand(0);
}

if (isSetTriBand() && (SelHighBand == 1)) {
    WlanWifiInitForHighBand5G();
}

if (IsShowBSD()) {
    getFirstWlan2G();
}

function getFirstWlan2G() {
    for (var i = 0; i < wlanArrLen; i++) {
        if (getWlanPortNumber(wlanArr[i].Name) == ssidStart2G) {
            firstSSID2G = wlanArr[i].SSID;
            return;
        }
    }
}

totalWlanAttr = new stTotalWlanAttr(WlanBasic, WlanAdv, WiFiRadio, XHWGlobalConfig, AttachConf, AirtimeConf);

var w52Channel;
var w53Channel;
var w56Channel;
function GetChannelData()
{
    if (possibleChannels == "") {
        return;
    }
    w52Channel = new Array;
    w53Channel = new Array;
    w56Channel = new Array;
    var channels = possibleChannels.split(',');
    for (var i = 0; i < channels.length; i++) {
        if (channels[i] >= 36 && channels[i] <= 48) {
            w52Channel.push(channels[i])
        } else if (channels[i] >= 52 && channels[i] <= 64) {
            w53Channel.push(channels[i]);
        } else {
            w56Channel.push(channels[i]);
        }
    }
}
function selectRestrictions()
{
    var count = 0;
    var w52Value = getCheckVal('CheckEnabledW52');
    var w53Value = getCheckVal('CheckEnabledW53');
    var w56Value = getCheckVal('CheckEnabledW56');
    var valueArr = [w52Value, w53Value, w56Value];
    var numCheck = 0;
    for (var i = 0; i < valueArr.length; i++) {
        if (valueArr[i] != 1) {
            count++;
        } else {
            numCheck = i;
        }
    }
    if (count >= 2) {
        if (numCheck == 0) {
            document.getElementById('CheckEnabledW52').disabled = true;
        } else if (numCheck == 1) {
            document.getElementById('CheckEnabledW53').disabled = true;
        } else {
            document.getElementById('CheckEnabledW56').disabled = true;
        }
    } else {
        document.getElementById('CheckEnabledW52').disabled = false;
        document.getElementById('CheckEnabledW53').disabled = false;
        document.getElementById('CheckEnabledW56').disabled = false;
    }
}
function AddSelectChannel(channel)
{
    var channelList = document.getElementById('Channel');
    var newChannel = new Array;
    while(channelList.options.length -1) {
        newChannel.push(channelList.options[channelList.options.length -1].value);
        channelList.options.remove(channelList.options.length - 1);
    }
    for (var i = 0; i < channel.length; i++) {
        newChannel.push(channel[i]);
    }
    newChannel.sort(function(a,b){return a-b});
    for (var i = 0; i < newChannel.length; i++) {
        var objOption = document.createElement("OPTION");
        objOption.value = newChannel[i];
        objOption.text = newChannel[i];
        channelList.add(objOption);
    }
}
function RemoveSelect(channelStr)
{
    var carList = document.getElementById('Channel');
    for (var j = 0; j < channelStr.length; j++) {
        for (var i = 0; i < carList.length; i++) {
            var flag = (carList.options[i].value == channelStr[j]);
            if (carList.options[i].value == channelStr[j]) {
                carList.remove(i);
                break;
            }
        }
    }
}
function SelectOperation(checkBoxId, channel)
{
  if (getCheckVal(checkBoxId) != 1) {
      RemoveSelect(channel);
    } else {
      AddSelectChannel(channel);
    }
}

function addSelectChannels(Form)
{
    GetChannelData();
    var w52Value = getCheckVal('CheckEnabledW52');
    var w53Value = getCheckVal('CheckEnabledW53');
    var w56Value = getCheckVal('CheckEnabledW56');
    var AutoChScope = "";
    if (w52Value == 1) {
        AutoChScope = AutoChScope.concat(w52Channel, ",");
    }
    if (w53Value == 1) {
        AutoChScope = AutoChScope.concat(w53Channel, ",");
    }
    if (w56Value == 1) {
        AutoChScope = AutoChScope.concat(w56Channel, ",");
    }
    AutoChScope = AutoChScope.substring(0, AutoChScope.length -1);

    Form.addParameter('y.X_HW_AutoChannelScope', AutoChScope);
}

function selectChannels(checkBoxId)
{
    selectRestrictions();
    GetChannelData();
    if (checkBoxId.id == "CheckEnabledW52") {
      SelectOperation("CheckEnabledW52", w52Channel);
    } else if (checkBoxId.id == "CheckEnabledW53") {
      SelectOperation("CheckEnabledW53", w53Channel);
    } else {
      SelectOperation("CheckEnabledW56", w56Channel);
    }
}

function UpdateCheckBoxState()
{
    GetChannelData();

    var w52AutoChannel = new Array;
    var w53AutoChannel = new Array;
    var w56AutoChannel = new Array;
    var AutoChScope = (WlanBasic.X_HW_AutoChannelScope).split(',');

    if (AutoChScope == "") {
        document.getElementById('CheckEnabledW52').checked = true;
        document.getElementById('CheckEnabledW53').checked = true;
        document.getElementById('CheckEnabledW56').checked = true;
        return;
    }

    for (var i = 0; i < AutoChScope.length; i++) {
        if (AutoChScope[i] >= 36 && AutoChScope[i] <= 48) {
            w52AutoChannel.push(AutoChScope[i])
        } else if (AutoChScope[i] >= 52 && AutoChScope[i] <= 64) {
            w53AutoChannel.push(AutoChScope[i]);
        } else {
            w56AutoChannel.push(AutoChScope[i]);
        }
    }

    if (w52AutoChannel.length == 0) {
        RemoveSelect(w52Channel);
        document.getElementById('CheckEnabledW52').checked = false;
    } else {
        document.getElementById('CheckEnabledW52').checked = true;
    }

    if (w53AutoChannel.length == 0) {
        RemoveSelect(w53Channel);
        document.getElementById('CheckEnabledW53').checked = false;
    } else {
        document.getElementById('CheckEnabledW53').checked = true;
    }

    if (w56AutoChannel.length == 0) {
        RemoveSelect(w56Channel);
        document.getElementById('CheckEnabledW56').checked = false;
    } else {
        document.getElementById('CheckEnabledW56').checked = true;
    }

    selectRestrictions();
}

function stWiFiRadio(domain, GuardInterval) {
    this.domain = domain;
    this.GuardInterval = GuardInterval;
}

function stXHWAdvanceCfg(domain, UsersPerSSIDEnable) {
    this.domain = domain;
    this.UsersPerSSIDEnable = UsersPerSSIDEnable;
}

function stAirtimeConf(domain, Enable) {
    this.domain = domain;
    this.Enable = Enable;
}

function stTotalWlanAttr(WlanBasic, WlanAdv, WiFiRadio, XHWGlobalConfig, AttachConf, AirtimeConf) {
    this.TransmitPower = WlanBasic.TransmitPower;
    this.RegulatoryDomain = WlanBasic.RegulatoryDomain;
    this.AutoChannelEnable = WlanBasic.AutoChannelEnable;
    this.GuardInterval = WiFiRadio.GuardInterval;    
    this.X_IEEE80211wEnabled = WlanBasic.X_IEEE80211wEnabled;    
    this.X_TxBFEnabled = WlanBasic.X_TxBFEnabled;
    this.X_OCCACEnables = WlanBasic.X_OCCACEnables;    
    this.BandSteeringPolicy = XHWGlobalConfig.BandSteeringPolicy;

    if (WlanBasic.AutoChannelEnable == 1) {
        this.Channel = 0;
    } else {
        if (WlanBasic.X_HW_HT20 == 5) {
            this.Channel = WlanBasic.Channel + "+" + WlanBasic.ChannelPlus;
        } else {
            this.Channel = WlanBasic.Channel;
        }
    }

    this.X_HW_WorkMode = WlanBasic.X_HW_WorkMode;
    this.X_HW_HT20 = WlanBasic.X_HW_HT20;
    this.X_HW_Standard = WlanBasic.X_HW_Standard;
    this.X_HW_MCS = WlanBasic.X_HW_MCS;

    this.DtimPeriod = WlanAdv.DtimPeriod;
    this.BeaconPeriod = WlanAdv.BeaconPeriod;
    this.RTSThreshold = WlanAdv.RTSThreshold;
    this.FragThreshold = WlanAdv.FragThreshold;    
    if (DslTalkTalkFlag == 1) {
        this.X_HW_AirtimeFairness = AirtimeConf.Enable;
    } else {
        this.X_HW_AirtimeFairness = AttachConf.X_HW_AirtimeFairness;
    }
    this.X_HW_PreambleType = AttachConf.X_HW_PreambleType;
}

function stWdsClientAp(domain, BSSID) {
    this.domain = domain;
    this.BSSID = BSSID;
}

function stWdsEnable(domain, enable) {
    this.domain = domain;
    this.enable = enable;
}

function checkDFSChSwitch() {
    if (cfgMode.toUpperCase() == 'DTEDATA2WIFI') {
        return;
    }

    if ((cfgMode.toUpperCase() == 'CTM') || (AisPrev == "1") || (getSelectVal('RegulatoryDomain') == "JP")) {
        dfsChSwitch = 0;
        return;
    }

    var isDFSChSwitch = ((isDfsArea(getSelectVal('RegulatoryDomain')) == 1) || (PTVDFFlag == 1) || (cablevisFlag == 1));
    checkDFSChSwitchCommon('X_HW_HT20', isDFSChSwitch);
}

function judgeVDFDFSCh() {
    var AutoChScope = (WlanBasic.X_HW_AutoChannelScope).split(',');
    var VDFDFSCh = new Array(52,56,60,64,100,104,108,112,116,132,136,140);
    for (var i = 0; i < VDFDFSCh.length; i++) {
        for (var j = 0; j < AutoChScope.length; j++) {
            if (AutoChScope[j] == VDFDFSCh[i]) {
                return true;
            }
        }
    }

    return false;
}

function wdsIsMacAddrRepeat() {
    var aucMac = new Array();
    var i = 0;
    var j = 0;

    aucMac[0] = getValue('wds_Ap1_BSSID');
    aucMac[1] = getValue('wds_Ap2_BSSID');
    aucMac[2] = getValue('wds_Ap3_BSSID');
    aucMac[3] = getValue('wds_Ap4_BSSID');

    for (i = 0; i < 4; i++) {
        for (j = i + 1; j < 4; j++) {
            if ((aucMac[i].length == 17) && (aucMac[j].length == 17)) {
                if (aucMac[i].toLowerCase() == aucMac[j].toLowerCase()) {
                    return true;
                }
            }
        }
    }

    return false;
}

function wdsIsMacAddrInvalid(Mac) {
    var loop = 0;

    if ((Mac.length != 0) && (Mac.length != 17)) {
        return true;
    }

    if (Mac.length == 17) {
        for (loop = 0; loop < 17; loop++) {
            if ((1 + loop) % 3 == 0) {
                if (Mac.charAt(loop) != ':') {
                    return true;
                }
            } else {
                if (((Mac.charAt(loop) >= '0') && (Mac.charAt(loop) <= '9')) || ((Mac.charAt(loop) >= 'a') && (Mac.charAt(loop) <= 'f')) || ((Mac.charAt(loop) >= 'A') && (Mac.charAt(loop) <= 'F'))) {
                    continue;
                } else {
                    return true;
                }
            }
        }
    }

    return false;
}

function ChannelScopeSpecProc() {
    channelScope = [];
    RadioVal = getRadioVal("WlanMethod");

    if (wlanpage == "2G") {
        if (RadioVal == 1) {
            channelScope = "1,2,3,4,5,6,7,8,9,10,11";
        } else {
            var checklist = document.getElementsByName("channel2g");

            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].checked) {
                    channelScope.push(checklist[i].value);
                }
            }

            channelscopeflag = 1;
        }
    } else {
        if (RadioVal == 1) {
            channelScope = "36,40,44,48,52,56,60,64,149,153,157,161";
        } else {
            var checklist = document.getElementsByName("ChBand1");

            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].checked) {
                    channelScope.push(checklist[i].value);
                }
            }

            checklist = document.getElementsByName("ChBand2");

            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].checked) {
                    channelScope.push(checklist[i].value);
                }
            }

            checklist = document.getElementsByName("ChBand3");

            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].checked) {
                    channelScope.push(checklist[i].value);
                }
            }

            channelscopeflag = 1;
        }
    }

    return channelScope;
}

function CheckForm(type) {
    if (checkProcessingState()) {
        AlertEx(cfg_wlancfgadvance_language['amp_config_busy']);
        return;
    }
    if ((getSelectVal('TransmitPower') == "") || (getSelectVal('RegulatoryDomain') == "") || (getSelectVal('Channel') == "") || 
    (getSelectVal('X_HW_Standard') == "") || (getSelectVal('X_HW_HT20') == "")) {
        AlertEx(cfg_wlancfgother_language['amp_basic_empty']);
        return false;
    }

    if ((PccwFlag == 1) && (DoubleFreqFlag == 1) && (['PCCW4MAC', 'PCCWSMART', 'PCCW2'].indexOf(cfgMode.toUpperCase()) < 0)) {
        var pccw_TxPwr = getSelectVal('TransmitPower');
        if ( pccw_TxPwr != WlanBasic.TransmitPower) {
            AlertEx(cfg_wlancfgother_language['amp_wlancfg_resetvalid']);
        }
    }

    if (IsShowBSD()) {
        if ((XHWGlobalConfig.BandSteeringPolicy == 0) && (getCheckVal('BandSteeringPolicy') == 1)) {
            AlertEx(cfg_wlancfgadvance_language['amp_advance_bsd_meg1'] + firstSSID2G + '.');
        }

        if ((XHWGlobalConfig.BandSteeringPolicy == 1) && (getCheckVal('BandSteeringPolicy') == 0)) {
            AlertEx(cfg_wlancfgadvance_language['amp_advance_bsd_meg2'] + firstSSID2G + cfg_wlancfgadvance_language['amp_advance_bsd_meg3'] + firstSSID2G + '_5GHz');
        }
    }

    var dtimPeriod = getValue('DtimPeriod');
    var beaconPeriod = getValue('BeaconPeriod');
    var rtsThreshold = getValue('RTSThreshold');
    var fragThreshold = getValue('FragThreshold'); 
    var RSSIThreshold = getValue('X_HW_RSSIThreshold');

    if ((dtimPeriod == "") || (beaconPeriod == "") ||  
        (rtsThreshold == "") || (fragThreshold == "")) {
        AlertEx(cfg_wlancfgother_language['amp_advance_empty']);
        return false;
    }

    if ((!isPlusInteger(dtimPeriod)) || (!isValidDecimalNum(dtimPeriod))) {
        AlertEx(cfg_wlancfgadvance_language['amp_dtimtime_int']);
        return false;
    } else {
        if ((parseInt(dtimPeriod,10) < 1) || (parseInt(dtimPeriod,10) > 255)) {
            AlertEx(cfg_wlancfgadvance_language['amp_dtimtime_range']);
            return false;
        }
    }

    if ((!isPlusInteger(beaconPeriod)) || (!isValidDecimalNum(beaconPeriod))) {
        AlertEx(cfg_wlancfgadvance_language['amp_beacon_int']);
        return false;
    } else {
        if (capBcnInerval == 1) {
            if ((parseInt(beaconPeriod,10) < 20) || (parseInt(beaconPeriod,10) > 1000)) {
                AlertEx(cfg_wlancfgadvance_language['amp_beacon_range']);
                return false;
            }
        } else if (capBcnInerval == 0) {
            if ((parseInt(beaconPeriod,10) < 100) || (parseInt(beaconPeriod,10) > 1000)) {
                AlertEx(cfg_wlancfgadvance_language['amp_beacon_range_bcn']);
                return false;
            }
        }
    }

    if ((!isPlusInteger(rtsThreshold)) || (!isValidDecimalNum(rtsThreshold))) {
        AlertEx(cfg_wlancfgadvance_language['amp_rts_int']);
        return false;
    } else {
        if (t2Flag == '1') {
            if (parseInt(rtsThreshold,10) > 65536) {
                AlertEx(cfg_wlancfgadvance_language['amp_rts_range_tde']);
                return false;
            }
        } else {
            if ((parseInt(rtsThreshold,10) < 1) || (parseInt(rtsThreshold,10) > 2346)) {
                AlertEx(cfg_wlancfgadvance_language['amp_rts_range']);
                return false;
            }
        }
    }

    if ((!isPlusInteger(fragThreshold)) || (!isValidDecimalNum(fragThreshold))) {
        AlertEx(cfg_wlancfgadvance_language['amp_frag_int']);
        return false;
    } else {
        if ((parseInt(fragThreshold,10) < 256) || (parseInt(fragThreshold,10) > 2346)) {
            AlertEx(cfg_wlancfgadvance_language['amp_frag_range']);
            return false;
        }
    }

    if (RSSIThrFlag == 1) {
        if (RSSIThreshold == "") {
            AlertEx(cfg_wlancfgother_language['amp_advance_empty']);
            return false;
        }

        if (!isInteger(RSSIThreshold)) {
            AlertEx(cfg_wlancfgadvance_language['amp_wlan_rssithreshold_int']);
            return false;
        } else {
            if ((parseInt(RSSIThreshold, 10) < -95) || (parseInt(RSSIThreshold, 10) > -75)) {
                AlertEx(cfg_wlancfgadvance_language['amp_wlan_rssithreshold_range']);
                return false;
            }
        }
    }

    var country = getSelectVal('RegulatoryDomain');
    if ( country != WlanBasic.RegulatoryDomain) {
        AlertEx(cfg_wlancfgother_language['amp_wlancfg_resetvalid']);
    }


    if ((wlanChipType2G === 'QCN9024' || wlanChipType5G === 'QCN9024') ||
        (ProductType == 2) || (PTVDFFlag == 1)) {
        var airtime = getCheckVal('X_HW_AirtimeFairness');
        if (DslTalkTalkFlag == 1) {
            if (airtime != AirtimeConf.Enable) {
                AlertEx(cfg_wlancfgadvance_language['amp_airtime_resetvalid']);
            }
        } else {
            if (airtime != AttachConf.X_HW_AirtimeFairness) {
                AlertEx(cfg_wlancfgadvance_language['amp_airtime_resetvalid']);
            }
        }
    }

    if (WdsFlag == 1) {
        if (getCheckVal('wds_Enable') == 1) {
            if (wdsIsMacAddrInvalid(getValue('wds_Ap1_BSSID')) || wdsIsMacAddrInvalid(getValue('wds_Ap2_BSSID')) || wdsIsMacAddrInvalid(getValue('wds_Ap3_BSSID')) || wdsIsMacAddrInvalid(getValue('wds_Ap4_BSSID'))) {
                AlertEx(cfg_wlancfgadvance_language['amp_wds_address_invalid']);
                return false;
            }

            if (wdsIsMacAddrRepeat()) {
                AlertEx(cfg_wlancfgadvance_language['amp_wds_address_repeat']);
                return false;
            }
        }
    }
    if (!isWlanInitFinished(wlanpage, WlanBasic.X_HW_Standard, WlanBasic.X_HW_HT20)) {
        return false;
    }

    if (!CheckDfsChannelWarn()) {
        return false;
    }

    return true;
}

function CheckDfsChannelWarn() {
    var curX_HW_Standard = getSelectVal('X_HW_Standard');
    var curX_HW_HT20 = getSelectVal('X_HW_HT20');
    var selChannel = getSelectVal('Channel');
    var countryCode = getSelectVal('RegulatoryDomain');
    return checkDfsChannelWarnCommon(curX_HW_Standard, curX_HW_HT20, selChannel, wlanpage, countryCode, WlanBasic);
}

function IsShow11gn() {
    if ((bztlfFlag == '1') || (DslTelMexFlag == '1') || (cfgMode.toUpperCase() == 'MEGACABLE2')) {
        return true;
    }
    return false;
}

function IsShowTransmitPower() {
    if ((cfgMode.toUpperCase() == 'MYTIME') && (curUserType == sptUserType)) {
        return false;
    }
 
    return true;
}

function CheckChannelGroup(ChannelWidth, Channel, ChannelPlus) {
    var DfsChannelMin20MHz = 52;
    var DfsChannelMax20MHz = 140;
    var WeatherChannelMin20MHz = 120;
    var WeatherChannelMax20MHz = 128;
    var WeatherChannelMin40MHz = 116;
    var WeatherChannelMin80MHz = 116;
    var WeatherChannelMin160MHz = 100;
    var GeneralChannelGroup = 0;

    var ChannelGroup = GeneralChannelGroup;

    if (ChannelWidth == 5) {
        if ((Channel >= WeatherChannelMin80MHz) || (ChannelPlus >= WeatherChannelMin80MHz)) {
            ChannelGroup = weatherRadorGroup;
        } else {
            ChannelGroup = dfsRadorGroup;
        }
    } else if (ChannelWidth == 4) {
        if ((Channel >= WeatherChannelMin160MHz) && (WeatherChannelMax20MHz >= Channel)) {
            ChannelGroup = weatherRadorGroup;
        } else {
            ChannelGroup = dfsRadorGroup;
        }
    } else if (ChannelWidth == 1) {
        if ((DfsChannelMin20MHz <= Channel) && (DfsChannelMax20MHz >= Channel)) {
            if ((WeatherChannelMin20MHz <= Channel) && (WeatherChannelMax20MHz >= Channel)) {
                ChannelGroup = weatherRadorGroup;
            } else {
                ChannelGroup = dfsRadorGroup;
            }
        }
    } else {
        if ((DfsChannelMin20MHz <= Channel) && (DfsChannelMax20MHz >= Channel)) {
            if ((WeatherChannelMin40MHz <= Channel) && (WeatherChannelMax20MHz >= Channel)) {
                ChannelGroup = weatherRadorGroup;
            } else {
                ChannelGroup = dfsRadorGroup;
            }
        }
    }

    return ChannelGroup;
}

function InitX_HW_Standard() {
    var wlgmode = getSelectVal('X_HW_Standard');
    var isshow11n = 0;
    var isshow11aconly = 0;
    var isshow11ac = 0;
    var isshow11a = 0;
    var isshow11ax = cap11ax;

    var standard = "802.11b/g/n/ax";
    if (cfgMode.toUpperCase() == 'UNE2') {
        standard = "802.11g/n/ax";
    }

    var is11AXForFreq = (wlanpage == "2G") ? standard : "802.11a/n/ac/ax";
    if (cfgMode.toUpperCase() == "TTNET2" || cfgMode.toUpperCase() == "DINFOTEK2") {
        is11AXForFreq = "802.11ax";
    }
    var isantel = (cfgMode.toUpperCase() == 'ANTEL' || cfgMode.toUpperCase() == 'ANTEL2');

    for (i = 0; i < wlanArrLen; i++) {
        var name = wlanArr[i].Name;
        var portIndex = parseInt(name.charAt(length-1));
        if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
            if (isSetTriBand() && (SelHighBand == 1)){
                if (portIndex <= ssidEnd5G) {
                    continue;
                }
            } else {
                if ((portIndex < ssidStart5G) || (portIndex > ssidEnd5G)) {
                    continue;
                }
            }
        } else {
             if (portIndex > ssidEnd2G) {
                continue;
            }
        }

        var BeaconType = wlanArr[i].BeaconType;
        var BasicEncryptionModes =  wlanArr[i].BasicEncryptionModes;
        var WPAEncryptionModes  = wlanArr[i].WPAEncryptionModes;
        var IEEE11iEncryptionModes = wlanArr[i].IEEE11iEncryptionModes;
        var X_HW_WPAand11iEncryptionModes = wlanArr[i].X_HW_WPAand11iEncryptionModes;

        if ((BeaconType == "Basic") && (BasicEncryptionModes == "WEPEncryption")) {
           isshow11n += 1;
           isshow11ac +=1;
           isshow11aconly +=1;
        } else if ((BeaconType == "WPA") && 
                   ((WPAEncryptionModes == "TKIPEncryption")||(WPAEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
           isshow11aconly +=1;
        } else if (((BeaconType == "11i") || (BeaconType == "WPA2")) && 
                    ((IEEE11iEncryptionModes == "TKIPEncryption")||(IEEE11iEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
           isshow11aconly +=1;
        } else if (((BeaconType == "WPAand11i") || (BeaconType == "WPA/WPA2")) && 
                   ((X_HW_WPAand11iEncryptionModes == "TKIPEncryption") || (X_HW_WPAand11iEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
           isshow11aconly +=1;
        } else if (((BeaconType == "WPA3") || (BeaconType == "WPA2/WPA3")) && 
                   ((X_HW_WPAand11iEncryptionModes == "TKIPEncryption") || (X_HW_WPAand11iEncryptionModes == "TKIPandAESEncryption"))) {
           isshow11n += 1;
           isshow11aconly +=1;
        }

        if (wlanArr[i].wmmEnable == 0) {
            isshow11n += 1;
        }
    }

    isshow11n += (1 - cap11n) + isantel;
    isshow11a += 1 - cap11a;

    $('X_HW_Standard').empty();

    var standardArr = { '11a' : ["802.11a", 0], 
                      '11b' : ["802.11b", 0], 
                      '11g' : ["802.11g", 0], 
                      '11n' : ["802.11n", 0], 
                      '11bg' : ["802.11b/g", 0], 
                      '11bgn' : ["802.11b/g/n", 0], 
                      '11na' : ["802.11a/n", 0], 
                      '11ac' : ["802.11a/n/ac", 0],
                      '11ax' : [is11AXForFreq, 0],
                      '11nac' : ["802.11n/ac", 0]
                   };

    if (IsShow11gn() == true) {
        standardArr = { '11a' : ["802.11a", 0], 
                      '11b' : ["802.11b", 0], 
                      '11g' : ["802.11g", 0], 
                      '11n' : ["802.11n", 0], 
                      '11bg' : ["802.11b/g", 0], 
                      '11gn' : ["802.11g/n", 0],
                      '11bgn' : ["802.11b/g/n", 0], 
                      '11na' : ["802.11a/n", 0], 
                      '11ac' : ["802.11a/n/ac", 0],
                      '11ax' : [is11AXForFreq, 0]
                    };
    }

    if (ftAcOnly  == '1') {
        standardArr = { '11a' : ["802.11a", 0], 
                      '11b' : ["802.11b", 0], 
                      '11g' : ["802.11g", 0], 
                      '11n' : ["802.11n", 0], 
                      '11bg' : ["802.11b/g", 0], 
                      '11bgn' : ["802.11b/g/n", 0], 
                      '11na' : ["802.11a/n", 0], 
                      '11ac' : ["802.11a/n/ac", 0],
                      '11aconly' : ["802.11ac", 0],
                      '11ax' : [is11AXForFreq, 0],
                      '11nac' : ["802.11n/ac", 0]
                    };
    }

    if (cusUNE == '1') {
        standardArr = { '11a' : ["802.11a", 0], 
                  '11g' : ["802.11g", 0], 
                  '11n' : ["802.11n", 0], 
                  '11gn' : ["802.11g/n", 0], 
                  '11na' : ["802.11a/n", 0], 
                  '11ac' : ["802.11a/n/ac", 0],
                  '11ax' : [is11AXForFreq, 0]
                };
    }

    if (cfgMode.toUpperCase() === 'DTEDATA2WIFI') {
        standardArr = { '11a' : ["802.11a", 0],
                        '11b' : ["802.11b", 0],
                        '11g' : ["802.11g", 0],
                        '11n' : ["802.11n", 0],
                        '11gn' : ["802.11g/n", 0],
                        '11bg' : ["802.11b/g", 0],
                        '11bgn' : ["802.11b/g/n", 0],
                        '11na' : ["802.11a/n", 0],
                        '11ac' : ["802.11a/n/ac", 0],
                        '11ax' : [is11AXForFreq, 0]
                    };
    }

    standardArr['11n'][1] = (isshow11n == 0);
    standardArr['11ax'][1] = (isshow11ax);

    if (wlanpage == "5G") {
        standardArr['11a'][1] = (isshow11a == 0);
        standardArr['11na'][1] = 1;
        standardArr['11ac'][1] = ((wlan11acFlag == 1) && (isshow11ac == 0));
        if (ftAcOnly  == '1') {
            standardArr['11aconly'][1] = ((wlan11acFlag == 1) && (isshow11aconly == 0));
        }

        if (rosFlag == 1) {
            standardArr['11nac'][1] = 1;
        }
    } else {
        if (cusUNE == '1') {
            standardArr['11g'][1] = 1;
            standardArr['11gn'][1] = 1;
        } else {
            standardArr['11b'][1] = 1;
            standardArr['11g'][1] = !isantel;

            if (IsShow11gn() == true) {
                standardArr['11gn'][1] = 1;
            }

            if ((cfgMode.toUpperCase() === 'DTEDATA2WIFI') && (standardArr['11n'][1] !== 1))  {
                standardArr['11gn'][0] = '802.11n';
                standardArr['11gn'][1] = 1;
            }

            standardArr['11bg'][1] = 1;
            standardArr['11bgn'][1] = 1;
        }

        if (wlgmode == "11n" && (standardArr['11n'][1] == 0)) {
            wlgmode = "11bgn";
        }
    }

    InitDropDownListWithSelected('X_HW_Standard', standardArr, wlgmode);

    if (getSelectVal('X_HW_Standard') != wlgmode) {
        setSelect('X_HW_Standard', "11bgn");
    }
}

function WlanWifiInitFor5G() {
    for (var i = 0; i < wlanArrLen; i++) {
        if (ssidStart5G == getWlanPortNumber(wlanArr[i].Name)) {
            WlanBasic = wlanArr[i];
            WlanAdv = WlanAdvs[i];
            AttachConf = AttachConfs[i];
            return;
        }
    }
}

function SetWlanWifiDefaultFor2G() {
    for (var i = 0; i < wlanArrLen; i++) {
        if (ssidStart2G == getWlanPortNumber(wlanArr[i].Name)) {
            WlanBasic = wlanArr[i];
            WlanAdv = WlanAdvs[i];
            AttachConf = AttachConfs[i];
            return;
        }
    }
}

function SetWiFiRadioDefault() {
    if (wlanpage == "5G") {
        WiFiRadio = WiFiRadioArr[1];
    } else if(wlanpage == "2G") {
        WiFiRadio = WiFiRadioArr[0];
        if (t2Flag == '1') {
            XHWAdvanceCfg = XHWAdvanceCfgArr[0];
        }
    } else {

    }

    return;
}

function isSelChannelDFS(thisChannel) {
    if (dfsChSwitch == 1 && wlanpage == "5G") {
        if (thisChannel == 0) {
            if (cablevisFlag == 1) {
                if ((WlanBasic.X_HW_AutoChannelScope).indexOf("100,104,108,112,116,132,136,140") != -1) {
                    return true;
                }
            } else if (PTVDFFlag == 1) {
                if (judgeVDFDFSCh() == true) {
                    return true;
                }
            } else {
                    if (judgeDFSCh(WlanBasic.X_HW_AutoChannelScope) == true) {
                    return true;
                }
            }
        }
    }

    return false;
}

function loadChannelListByFreq(width) {
    var len = document.forms[0].Channel.options.length;
    var index = 0;
    var i;
    var WebChannel = getSelectVal('Channel');
    var WebChannelValid = 0;
    var ShowChannels;
    var countrySYN = getSelectVal('RegulatoryDomain');

    if (width == 5) {
        ShowChannels = loadHT80and80ChannelList();
    } else if ((X_HT80Flag == 1) && (width == '6')) {
        if ((cfgMode.toUpperCase() != 'ROSUNION') && (truergFlag != 1)) {
            possibleChannels = "36,52,100,116,132,149";
        }
        ShowChannels = possibleChannels.split(',');
    } else {
        ShowChannels = possibleChannels.split(',');
    }

    if (isSetTriBand()) {
        var TriBandShowChannels = ShowChannels;
        ShowChannels = [];
        for (i = 1; i <= TriBandShowChannels.length; i++) {
            if (((SelHighBand == 0) && (TriBandShowChannels[i-1] >= 100)) ||
                ((SelHighBand == 1) && (TriBandShowChannels[i-1] < 100))) {
                    continue;
                }

            ShowChannels.push(TriBandShowChannels[i-1]);
        }
    }

    if (cfgMode.toUpperCase() == 'DTEDATA2WIFI') {
        var DteChannelList = ShowChannels;
        ShowChannels = [];
        for (i = 1; i <= DteChannelList.length; i++) {
            if (DteChannelList[i-1] >= 100) {
                continue;
            }

            ShowChannels.push(DteChannelList[i-1]);
        }
    }

    if ((megacablepwd == "1") && (getSelectVal("X_HW_HT20") == "4")) {
        var channelList = ShowChannels;
        ShowChannels = [];
        for (i = 1; i <= channelList.length; i++) {
            if (channelList[i-1] >= 100) {
                continue;
            }
            ShowChannels.push(channelList[i-1]);
        }
    }

    $("#Channel").empty();

    if ((dfsChSwitch == 1) && (wlanpage == "5G")) {
        if (PTVDFFlag == 1 || cablevisFlag == 1) {
            document.forms[0].Channel[0] = new Option(cfg_wlancfgadvance_language['amp_auto_withoutdfs'], "0");
            document.forms[0].Channel[ShowChannels.length + 1] = new Option(cfg_wlancfgadvance_language['amp_auto_withdfs'], "-1");
        } else {
            document.forms[0].Channel[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "-1");
            if (cfgMode.toUpperCase() !== 'TELECOM2') {
                document.forms[0].Channel[ShowChannels.length + 1] = new Option(cfg_wlancfgadvance_language['amp_common_auto_withoutdfs'], "0");
            }
        }
    } else {
        document.forms[0].Channel[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");
    }

    for (var j = 1; j <= ShowChannels.length; j++) {
        if (WebChannel == ShowChannels[j-1]) {
            WebChannelValid = 1;
        }

        if (ShowChannels[j-1] != "") {
            document.forms[0].Channel[j] = new Option(ShowChannels[j-1], ShowChannels[j-1]);
        }
    }

    if ((isSelChannelDFS(WebChannel)) || ((megacablepwd == '1') && (ShowChannels.indexOf(WebChannel) == -1))) {
        WebChannel = -1;
    }

    if (WebChannelValid == 1 || WebChannel == -1) {
        setSelect('Channel', WebChannel);
    } else {
        setSelect('Channel', 0);
    }
}

function setX_HW_StandardSug() {
    if (cfgMode.toUpperCase() == 'ROSUNION') {
        return;
    }
    var mode = getSelectVal('X_HW_Standard');
    var spanX_HW_Standard = getElementById('X_HW_Standardspan');
    var rowX_HW_Standard = getElementById('X_HW_StandardCol');
    var selectX_HW_Standard = getElementById('X_HW_Standard');
    

    if (((DslTelMexFlag == 1) || (cusUNE == 1)) && (mode != '11bgn') && (wlanpage == '2G')) {
        return;
    }
    if (cap11ax == 1) {
        if (mode == "11ax") {
            rowX_HW_Standard.style.position = "relative";
            selectX_HW_Standard.style.position = "absolute";
            selectX_HW_Standard.style.top = "50%";
            selectX_HW_Standard.style.marginTop = "-10px";
            spanX_HW_Standard.innerHTML = cfg_wlancfgadvance_language['amp_advance_working_mode_sug6'];
            spanX_HW_Standard.style.color = '#ff0000';
            spanX_HW_Standard.style.position = "relative";
            spanX_HW_Standard.style.left = "160px";
            spanX_HW_Standard.style.display = "inline-block";
            spanX_HW_Standard.style.width = "300px";
        }else if ((wlanpage == "2G") && (mode != '11ax')) {
            spanX_HW_Standard.innerHTML = cfg_wlancfgadvance_language['amp_advance_working_mode_sug5'];
            spanX_HW_Standard.style.color = '#ff0000';
        } else if ((wlanpage == "5G") && (DoubleFreqFlag == 1) && (mode != '11ax')) {
            spanX_HW_Standard.innerHTML = cfg_wlancfgadvance_language['amp_advance_working_mode_sug4'];
            spanX_HW_Standard.style.color = '#ff0000';
        } else {
            spanX_HW_Standard.innerHTML = '';
        }
    } else {
        setX_HW_StandardSugCommon(wlanpage, mode, spanX_HW_Standard);
    }
}

function getWidth80Sug() {
    var width80sug = ((t2Flag=='1') || (bztlfFlag == '1') || ((X_HT80Flag == '1') && (cfgMode.toUpperCase() == 'DMASMOVIL2WIFI'))) ? 'amp_advance_channelwidemode_sug4' : 'amp_advance_channelwidemode_sug3';
    return cfg_wlancfgadvance_language[width80sug];
}

function getWidthSug() {
    return cfg_wlancfgadvance_language['amp_advance_channelwidemode_sug2'];
}

function setX_HW_HT20Sug() {
    if ((cfgMode.toUpperCase() == 'ROSUNION') || (aisAp == 1)) {
        return;
    }
    var spanX_HW_HT20 = getElementById('X_HW_HT20span');
    var width = getSelectVal('X_HW_HT20');
    var country = getSelectVal('RegulatoryDomain');

    if ((wlanpage == '5G') && (country == 'EG')) {
        return;
    }

    setX_HW_HT20SugCommon(wlanpage, width, spanX_HW_HT20);
}

function setChannelSug() {
    if (cfgMode.toUpperCase() == 'ROSUNION') {
        return;
    }
    var spanChannel = getElementById('Channelspan');
    var channelVal = getSelectVal('Channel');
    setChannelSugCommon(spanChannel, channelVal);
}

function setTransmitPowerSug() {
    if (cfgMode.toUpperCase() == 'ROSUNION') {
        return;
    }
    var spanTransmitPower = getElementById('TransmitPowerspan');
    if ((getSelectVal('TransmitPower') != 100) && (PccwFlag != 1) && (AisFlag != 1) && (DslTelMexFlag != 1) && (truergFlag != 1)) {
        spanTransmitPower.innerHTML = cfg_wlancfgadvance_language['amp_advance_transmit_power_sug'];
        spanTransmitPower.style.color = '#ff0000';
    } else {
        spanTransmitPower.innerHTML = '';
    }
}

function SetTransmitPowerEGSug() {
    if (ProductType == 2) {
        return;
    }

    var spanEirpSug = getElementById('spanEirpSug');
    var sugTxt = '';
    if (getSelectVal('RegulatoryDomain') == 'EG' ) {
        sugTxt = (wlanpage == '2G') ? cfg_wlancfgadvance_language['amp_advance_eirp_tedata_sug_2g'] : cfg_wlancfgadvance_language['amp_advance_eirp_tedata_sug_5g'];
    }

    spanEirpSug.innerHTML = sugTxt;
}


function setAdvanceSug() {
    setAdvancePartSug();
    setTransmitPowerSug();
    SetTransmitPowerEGSug();
}

function WifiAdvanceShow(enable) {
    var setDivId = 'div_wlanadv';
    if (isSetTriBand() && (enbl5G == 1)) {
        setDivId = 'wlanadvForm';
    }

    if ((enable != 1) || (WlanAdv == null) || (WlanBasic == null)) {
        setDisplay(setDivId, 0);
    } else {
        setDisplay(setDivId, 1);
    }
}

function WdsSetDisplayFunc(enable) {
    if (WdsFlag == 1) {
        setDisplay('X_HW_WlanMac' + 'Row', enable);
        setDisplay('wds_Ap1_BSSID' + 'Row', enable);
        setDisplay('wds_Ap2_BSSID' + 'Row', enable);
        setDisplay('wds_Ap3_BSSID' + 'Row', enable);
        setDisplay('wds_Ap4_BSSID' + 'Row', enable);
    } else {
        setDisplay('wds_Enable' + 'Row', 0);
        setDisplay('X_HW_WlanMac' + 'Row', 0);
        setDisplay('wds_Ap1_BSSID' + 'Row', 0);
        setDisplay('wds_Ap2_BSSID' + 'Row', 0);
        setDisplay('wds_Ap3_BSSID' + 'Row', 0);
        setDisplay('wds_Ap4_BSSID' + 'Row', 0);
    }
}

function LoadWdsConfig() {
    var WdsEnable = 0;
    if (WdsFlag == 1) {
        WdsEnable = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS, Enable, stWdsEnable, EXTEND);%>;
        WdsEnable = WdsEnable[0].enable;

        var WdsClientApMacAddr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.{i}, BSSID, stWdsClientAp, EXTEND);%>;

        if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
            if (t2Flag == '1') {
                WdsClientApMacAddr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.X_HW_WDS.ClientAP.{i}, BSSID, stWdsClientAp, EXTEND);%>;
                WdsEnable = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.X_HW_WDS, Enable, stWdsEnable, EXTEND);%>;
                WdsEnable = WdsEnable[0].enable;
            } else {
                WdsClientApMacAddr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.ClientAP.{i}, BSSID, stWdsClientAp, EXTEND);%>;
                WdsEnable = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS, Enable, stWdsEnable, EXTEND);%>;
                WdsEnable = WdsEnable[0].enable;
            }
        }

        var WdsMasterMac = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_WlanMac);%>';
        if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
            WdsMasterMac = '<%HW_WEB_GetWlanMac_5G();%>';
        }

        setCheck('wds_Enable', WdsEnable);
        document.getElementById("X_HW_WlanMac").innerHTML = WdsMasterMac;
        setText('wds_Ap1_BSSID', WdsClientApMacAddr[0].BSSID.toUpperCase());
        setText('wds_Ap2_BSSID', WdsClientApMacAddr[1].BSSID.toUpperCase());
        setText('wds_Ap3_BSSID', WdsClientApMacAddr[2].BSSID.toUpperCase());
        setText('wds_Ap4_BSSID', WdsClientApMacAddr[3].BSSID.toUpperCase());
    }

    WdsSetDisplayFunc(WdsEnable);
}

function setRegulatoryDomainEtcHide() {
    setDisplay('RegulatoryDomain' + 'Row', 0);
    setDisplay('DtimPeriod' + 'Row', 0);
    setDisplay('BeaconPeriod' + 'Row', 0);
    setDisplay('RTSThreshold' + 'Row', 0);
    setDisplay('FragThreshold' + 'Row', 0);
}

function PccwSetDislayFunc() {
    if (['PCCW4MAC', 'PCCWSMART', 'PCCW2'].indexOf(cfgMode.toUpperCase()) >= 0) {
        return;
    }

    getElById("wlanadv_head").style.display = "none";
    setRegulatoryDomainEtcHide();
}

function TalkTalkSetCheckFunc() {
    setCheck('X_HW_AirtimeFairness',AirtimeConf.Enable);
}

function TalkTalkSetDislayFunc() {
    setRegulatoryDomainEtcHide();
}

function SetRegulatoryDomainDisable() {
    if ((DTHungaryFlag == 1) && (curUserType == sptUserType)) {
       setDisable('RegulatoryDomain',1);
    }

    if ((AisPrev == 1) && (curUserType == sptUserType)) {
       setDisable('RegulatoryDomain',1);
    }

    if ((CountryFixFlag == '1') || (RegulatoryDomainImmutable == '1')) {
        setDisable('RegulatoryDomain', 1);
    } else {
        setDisable('RegulatoryDomain', 0);
    }

    if ((rosFlag == 1) && (curUserType == sptUserType)) {
        setDisable('RegulatoryDomain', 1);
    }

    if ((CountryShowFlag == '0') || ((aisAp == 1) && (curUserType == sptUserType))) {
        setDisplay('RegulatoryDomain' + 'Row', 0);
    }
}

function setChBandCheck(ChBandId, thisCurrentScope) {
    var channelNum = 0;
    var checklist = document.getElementsByName("Ch" + ChBandId);

    for (var i = 0; i < thisCurrentScope.length; i++) {
        for (var j = 0; j < checklist.length; j++) {
            if (checklist[j].value == thisCurrentScope[i]) {
                checklist[j].checked = true;
                thisCurrentScope.splice(i, 1);
                i--;
                channelNum += 1;
                break;
            }
        }
    }

    if (checklist.length == channelNum) {
        document.getElementById(ChBandId).checked = true;
    }
}

function InitAutoChannelScope() {
    if (wlanpage == '2G') {
        var currentScope = WlanBasic.X_HW_AutoChannelScope.split(",");

        if (AttachConf.X_HW_ChannelScopeFlag == 1) {
            setRadio("WlanMethod", 2);

            setDisplay("CustChannel_2g", 1);

            for (var i = 0; i < currentScope.length; i++) {
                var checklist = document.getElementsByName("channel2g");

                for (var j = 0; j < checklist.length; j++) {
                    if (checklist[j].value == currentScope[i]) {
                        checklist[j].checked = true;
                        break;
                    }
                }
            }
        }
    } else {
        if (AttachConf.X_HW_ChannelScopeFlag == 1) {
            setRadio("WlanMethod", 2);
            setDisplay("CustChannel_5g", 1);

            var currentScope = WlanBasic.X_HW_AutoChannelScope.split(",");
            for (var i = 1; i <= 3; i++) {
                setChBandCheck('Band' + i, currentScope);
            }
        }
    }
}

function InitHwWorkModeTips() {
    if ((curWlanChipType == 2) && (wifiWorkMode == 1)) {
        setDisplay('X_HW_WorkMode' + 'Row', 1);

        var title = cfg_wlancfgadvance_language['amp_workmode_alert_normal'] + '\n' + 
                    cfg_wlancfgadvance_language['amp_workmode_alert_crosswall'] + '\n' + 
                    cfg_wlancfgadvance_language['amp_workmode_alert_highspeed'];

        if (crossWallFeature == 1) {
            title = cfg_wlancfgadvance_language['amp_workmode_alert_normal'] + '\n' + 
                    cfg_wlancfgadvance_language['amp_workmode_alert_highspeed'];
            document.getElementById('X_HW_WorkMode').remove(1);
        }

        document.getElementById('X_HW_WorkMode').setAttribute('title', title);
    } else if (IsCommonSupport == 1) {
        setDisplay('X_HW_WorkMode' + 'Row', 1);

        if (1 == getSelectVal('X_HW_WorkMode')) {
            document.getElementById('X_HW_WorkMode').title = cfg_wlan_tips_language['amp_wlan_normal_tips'];
        } else {
            document.getElementById('X_HW_WorkMode').title = cfg_wlan_tips_language['amp_wlan_antiinterference_tips'];
        }
    } else {
        setDisplay('X_HW_WorkMode' + 'Row', 0);
    }
}

function setTab(name,cursel) {
    for (var i=1; i <= 2; i++) {
        var menu=document.getElementById(name+i);
        menu.className=((i==cursel)?"hover":"");
    }

    if (cursel == 1) {
        SelHighBand = 0;
    } else {
        SelHighBand = 1;
    }

    top.wlanAdv_selHighBand = SelHighBand;
    window.location = "/html/amp/wlanadv/WlanAdvance.asp?5G";
}

function isSetTriBand() {
    if ((DoubleFreqFlag == 1) && (wlanpage == "5G") && (TribandFlag == 1) && (hiLinkRoll == 1) && (TriBandHighBandEnable == 1)) {
        return true;
    } else {
        return false;
    }
}

function WlanWifiInitForHighBand5G() {
    var firstIndexForHighBand5G = 0;
    for (i = 0; i < wlanArrLen; i++) {
        if ((DoubleFreqFlag == 1) && (wlanpage == "5G") && (TriBandHighBandEnable == 1)) {
            if (getWlanPortNumber(wlanArr[i].Name) > (ssidStart5G*2 - 1)) {
                firstIndexForHighBand5G = i;        
                WlanBasic = wlanArr[firstIndexForHighBand5G];
                WlanAdv = WlanAdvs[firstIndexForHighBand5G];
                AttachConf = AttachConfs[firstIndexForHighBand5G];

                return;
            }
        }
    }
}

function TotalHighBand5G() {
    totalHighBand5gNum = 0;
    for (var loop = 0; loop < wlanArrLen; loop++) {
        if (wlanArr[loop].Name == '') {
            continue;
        }

        if ((getWlanPortNumber(wlanArr[loop].Name) >= 2*ssidStart5G)) {
            totalHighBand5gNum++;
        }
    }
}

function Init_HW_QHOP() {
    if ((AmpQHOPFlag == 1) && (wlanpage == '5G')) {
        setCheck('X_QHOPEnables',WlanBasic.X_QHOPEnables);
    }
}

function InitTransmitPowerList(id) {
    if(TelMexFlag == 1 || DslTelMexFlag == 1) {
        if (language.toUpperCase() == 'SPANISH') {
            var ArrayTransmitPower = new Array(new stInitOption("100","Máxima"), new stInitOption("75","Alto"), new stInitOption("50","Medio"), new stInitOption("25","Bajo"));
        } else {
            var ArrayTransmitPower = new Array(new stInitOption("100","Maximum"), new stInitOption("75","High"), new stInitOption("50","Mid"), new stInitOption("25","Low"));
        }
    } else if ((PccwFlag == 1) && (['PCCW4MAC', 'PCCWSMART', 'PCCW2'].indexOf(cfgMode.toUpperCase()) < 0)) {
        var ArrayTransmitPower = new Array(new stInitOption("100","USA"), new stInitOption("80","HongKong"), new stInitOption("60","Europe"));
    } else if ((AisFlag == 1) || ((cfgMode.toUpperCase() == 'AIS') && (DoubleFreqFlag == 1) && (wlanpage == '2G'))) {
        var ArrayTransmitPower = new Array(new stInitOption("100","Default"), new stInitOption("50","Thailand"));
    } else if (truergFlag == 1) {
        var ArrayTransmitPower = new Array(new stInitOption("3","High"), new stInitOption("2","Medium"), new stInitOption("1","Standard"));
    } else {
        var ArrayTransmitPower = new Array(new stInitOption("100","100%"), new stInitOption("80","80%"), new stInitOption("60","60%"), new stInitOption("40","40%"), new stInitOption("20","20%"));
    }

    initDropDownList(id, ArrayTransmitPower);
}

function InitWifiWorkModeList(id) {
    var ArrayWifiWorkMode = new Array(new stInitOption("0","Normal"), new stInitOption("1","Anti-Interference"));

    if (capWifiWorkMode == 1) {
        ArrayWifiWorkMode = new Array(new stInitOption("1","Normal"), new stInitOption("2","Anti-Interference"));
    }

    initDropDownList(id, ArrayWifiWorkMode);
}

function InitHwWorkModeList(id) {
    var tdLeftDescRefid = id + 'Colleft';

    if ((curWlanChipType == 2) && (wifiWorkMode == 1)) {
        var ArrayHwWorkMode = new Array(new stInitOption("0", cfg_wlancfgadvance_language['amp_workmode_normal']),
                                        new stInitOption("1", cfg_wlancfgadvance_language['amp_workmode_crosswall']),
                                        new stInitOption("2", cfg_wlancfgadvance_language['amp_workmode_highspeed']));
        initDropDownList(id, ArrayHwWorkMode);
    }

    if (IsCommonSupport == 1) {
        document.getElementById(tdLeftDescRefid).innerHTML = cfg_wlancfgadvance_language['amp_wlan_work_mode'];
        var ArrayHwWorkMode = new Array(new stInitOption("0", cfg_wlancfgadvance_language['amp_hwworkmode_interference']),
                                        new stInitOption("1", cfg_wlancfgadvance_language['amp_hwworkmode_normal']));
        initDropDownList(id, ArrayHwWorkMode);
    }
}

function InitGuardInterval(id) {
    var wlgmcs = WiFiRadio.GuardInterval; 
    $('#GuardInterval').empty();
    if (getSelectVal('X_HW_Standard') == "11ax") {
        var ArrayGuardInterval = new Array(new stInitOption("Auto",cfg_wlancfgadvance_language['amp_shortgi_auto']), 
                                           new stInitOption("800nsec","800nsec"), 
                                           new stInitOption("1600nsec","1600nsec"), 
                                           new stInitOption("3200nsec","3200nsec"));
    } else {
        var ArrayGuardInterval = new Array(new stInitOption("Auto",cfg_wlancfgadvance_language['amp_shortgi_auto']), 
                                           new stInitOption("400nsec","400nsec"), 
                                           new stInitOption("800nsec","800nsec"));
    }

    initDropDownList(id, ArrayGuardInterval);

    setSelect('GuardInterval',wlgmcs);
}

function InitX_HW_PreambleType(id) {
    var ArrayPreambleType = new Array(new stInitOption("short",cfg_wlancfgadvance_language['amp_preambletype_short']), 
                                      new stInitOption("long",cfg_wlancfgadvance_language['amp_preambletype_long']), 
                                      new stInitOption("auto",cfg_wlancfgadvance_language['amp_preambletype_auto']));
    initDropDownList(id, ArrayPreambleType);

    setSelect('X_HW_PreambleType', AttachConf.X_HW_PreambleType);
}

function initStandardChangeDropDownList() {
    initChannelList("Channel", wlanpage);
    initChannelWidthList("X_HW_HT20");
}

function InitWlanBasicDropDownList() {
    InitHwWorkModeList("X_HW_WorkMode");
    InitTransmitPowerList("TransmitPower");
    initWlanBasicDropDownListCommon("RegulatoryDomain", "X_HW_Standard", "Channel", "X_HW_HT20", wlanpage);
    InitGuardInterval("GuardInterval");

    if ((TripleT == 1) || (capWifiWorkMode == 1)) {
        InitWifiWorkModeList("X_HW_WifiWorkingMode");
    }
}

function initPageHeadInfo() {
    var wlanadv_note = cfg_wlancfgother_language['amp_wlanadvance_title'];
    var wlanadv_header = cfg_wlancfgadvance_language['amp_wlan_advance_header'];

    if ((DoubleFreqFlag == 1) && (wlanpage == "2G")) {
        wlanadv_note = cfg_wlancfgother_language['amp_wlanadvance_title_2G'];
        wlanadv_header = cfg_wlancfgadvance_language['amp_wlan_advance_header_2G'];
    } else if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
        wlanadv_note = cfg_wlancfgother_language['amp_wlanadvance_title_5G'];
        wlanadv_header = cfg_wlancfgadvance_language['amp_wlan_advance_header_5G'];
    }

    if (PccwFlag == 1)  {
        wlanadv_note = cfg_wlancfgother_language['amp_wlanadvance_title_pccw'];
    }

    var WlanAdvSummaryArray = new Array(new stSummaryInfo("text",wlanadv_note),
                                        new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note1")),
                                        new stSummaryInfo("text",GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note")),
                                        null);
    HWCreatePageHeadInfo("wlanadvsummary", wlanadv_header, WlanAdvSummaryArray, true);
}

function X_HW_MCSChange() {
    if ((ShowMCSFlag == '0') || (curUserType == sptUserType) || (DoubleFreqFlag != 1) || (wlanpage != "5G")) {
        return;
    }

    var mode = getSelectVal('X_HW_Standard');
    $('#X_HW_MCS').empty();

    if ((mode == '11ac') || (mode == '11na') || (mode == '11aconly')) {
        setDisplay('X_HW_MCS' + 'Row', 1);
    } else {
        setDisplay('X_HW_MCS' + 'Row', 0);
        return;
    }

    if (mode == '11na') {
        var MAXMCS = 32;
        document.forms[0].X_HW_MCS[0] = new Option(cfg_wlancfgadvance_language['amp_shortgi_auto'], -1);
        for (var i = 1; i <= MAXMCS; i++) {
            document.forms[0].X_HW_MCS[i] = new Option(i-1, i-1);
        }
        setSelect('X_HW_MCS', -1);
    }

    if ((mode == '11ac') || (mode =='11aconly')) {
        var MAXMCS = 10;
        document.forms[0].X_HW_MCS[0] = new Option(cfg_wlancfgadvance_language['amp_shortgi_auto'], -1);
        for (var j = 1; j <= 4; j++) {
            for (var i = 1; i <= MAXMCS; i++) {
                var acMCS = i - 1 + j * 100;
                document.forms[0].X_HW_MCS[i + (j - 1) * 10] = new Option(acMCS, acMCS);
            }
        }
        setSelect('X_HW_MCS', -1);
    }
}

function SetChannelForchannelWidth(channelWidthRestore) {
    if ((aisAp == 1) && (wlanpage == "5G")) {
        if ((channelWidthRestore == 7) || (channelWidthRestore == 4)) {
            if (channelWidthRestore == 7) {
                setSelect('Channel', 0);
                setRadio("WlanMethod", 1);
                setDisplay("CustChannel_5g", 0);
                setDisable('Channel', 1);
                $("input[name='WlanMethod']").attr('disabled', true);
                setChannelSug();
            } else {
                setSelect('Channel', 0);
                setDisable('Channel', 1);
                $("input[name='WlanMethod']").attr('disabled', false);
            }
        }
    }
}

function X_HW_StandardChange() {
    setX_HW_StandardSug();
    var mode = getSelectVal('X_HW_Standard');
    var channelWidthRestore = getSelectVal('X_HW_HT20');
    var channel = getSelectVal('Channel');
    var country = getSelectVal('RegulatoryDomain');

    X_HW_MCSChange();
    InitGuardInterval("GuardInterval");

    if ((channel == 14) && (mode != "11b")) {
        setSelect('Channel', 0);
    }

    SetChannelForchannelWidth(channelWidthRestore);

    $('#X_HW_HT20').empty();

    if ((mode == "11b") || (mode == "11g") || (mode == "11bg") || (mode == "11a")) {    
        document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
    } else {
        if (DtHuFlag == 1) {
            if (wlanpage == "5G") {
                document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                document.forms[0].X_HW_HT20[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
            } else {
                document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            }
        } else if(cfgMode.toUpperCase() == 'ANTEL' || cfgMode.toUpperCase() == 'ANTEL2') {
            if (wlanpage == "5G") {
                document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                document.forms[0].X_HW_HT20[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
                if (mode != "11na") {
                    document.forms[0].X_HW_HT20[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
                }
            } else {
                document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
                document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
                document.forms[0].X_HW_HT20[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
            }
        } else if ((ZigBeeEnable == true || 
                   (ZigBeeSupport == '1' && ZigBeeEnable == false && DongleSwitch == '1' && (cfgMode.toUpperCase() == 'BELTELECOM' || cfgMode.toUpperCase() == 'BELTELECOMSMART' || cfgMode.toUpperCase() == 'BELTELECOM:LAN'))) && wlanpage == '2G') {
            document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        } else {
            document.forms[0].X_HW_HT20[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto2040'], "0");
            document.forms[0].X_HW_HT20[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
            if ((WlanBasic.X_HW_HT20 == 2) || (t2Flag == 0) || (wlanpage == "5G")) {
                document.forms[0].X_HW_HT20[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
            }
        }

        if ((DoubleFreqFlag == 1) && (wlanpage == "5G") && (((wlan11acFlag == 1) && ((mode == "11ac") || (mode == "11nac") || (mode == "11aconly"))) || ((cap11ax == 1) && (mode == "11ax"))) && (IsEgpytCustom() == false)) {
            var index = 3;
            if (DtHuFlag == 1) {
                index = 2;
            }
            if (X_HT80Flag == 1) {
                if(cfgMode.toUpperCase() != 'DMASMOVIL2WIFI') {
                    document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_80'], "6");
                    index++;
                }
            }

            if (aisAp == 1) {
                document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_80'], "6");
                } else {
                document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language[chlwidth80Res], "3");
            }
            index++;

            if (aisAp != 1) {
                if ((capHT160 == 1) && (megacablepwd != '1')) {
                    document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
                    index++;
                } else if ((cap11ax == 1) && (mode == "11ax")) {
                    document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_160'], "4");
                    index++;
                }
                if (capHT80_80 == 1) {
                    document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_80and80'], "5");
                    index++;
                }
                if ((cfgMode.toUpperCase() == 'CNT') || (cfgMode.toUpperCase() == 'CNT2')) {
                    document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_4080'], "7");
                    index++;
                }
            } else {
                document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language[chlwidth80Res], "3");
                index++;
                if ((capHT160 == 1) && (isHide160M != 1)) {
                    if (isShowCustomize == 1) {
                        document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_customized'], "7");
                    } else {
                        document.forms[0].X_HW_HT20[index] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_customized'], "4");
                    }

                    index++;
                }
            }
        }

        if ((aisAp == 1) && (wlanpage == "5G")) {
            $("#X_HW_HT20 option[value='0']").remove();
        }
        if ((channelWidthRestore != 3) || (mode == "11ac") || (mode == "11aconly") || (mode == "11nac") || (mode == "11ax")) {
            setSelect('X_HW_HT20', channelWidthRestore);
            if ((megacablepwd == '1') && (channelWidthRestore == 4) && (mode != "11ax")) {
                setSelect('X_HW_HT20', 3);
            }
        } else {
            setSelect('X_HW_HT20', 0);
        }

        if ((t2Flag=='1') && (wlanpage == "5G")) {
            if (mode == "11ac") {
                setSelect('X_HW_HT20', 3);
            } else if(mode == "11na") {
                setSelect('X_HW_HT20', 0);
            }
        }
    }

    var width = getValue('X_HW_HT20');
    loadChannelList(freq, country, mode, width);

    setX_HW_HT20Sug();
}

function X_HW_HT20Change() {
    var width = getValue('X_HW_HT20');
    var mode = getSelectVal('X_HW_Standard');
    var country = getSelectVal('RegulatoryDomain');
    loadChannelList(freq, country, mode, width);
    SetChannelForchannelWidth(width);
    setX_HW_HT20Sug();
}

function WorkModeChange() {
    if (IsCommonSupport == 1) {
        if (getSelectVal('X_HW_WorkMode') == 1) {
            document.getElementById('X_HW_WorkMode').title = cfg_wlan_tips_language['amp_wlan_normal_tips'];
        } else {
            document.getElementById('X_HW_WorkMode').title = cfg_wlan_tips_language['amp_wlan_antiinterference_tips'];
        }
    }
}

function RegulatoryDomainChange() {
    var width = getValue('X_HW_HT20');
    var mode = getSelectVal('X_HW_Standard');
    var country = getSelectVal('RegulatoryDomain');
    loadChannelList(freq, country, mode, width);
    SetTransmitPowerEGSug();
}

function X_HW_RSSIThresholdEnableClick() {
    setDisplay('X_HW_RSSIThreshold' + 'Row', getCheckVal('X_HW_RSSIThresholdEnable'));
}

function WdsClickFunc() {
    var WdsEnable = getCheckVal('wds_Enable');
    WdsSetDisplayFunc(WdsEnable);
}

function selectBand(selectBoxId) {
  selectName = "ChBand" + selectBoxId.charAt(selectBoxId.length - 1);
  var checkboxList = document.getElementsByName(selectName);
  if (document.getElementById(selectBoxId).checked) {
    for (var i = 0; i < checkboxList.length; i++) {
      checkboxList[i].checked = 1;
    }
  } else {
    for (var j = 0; j < checkboxList.length; j++) {
      checkboxList[j].checked = 0;
    }
  }
}

function onClickMethod() {
    isDisplay = 0;

    if (getRadioVal("WlanMethod") == 2) {
        isDisplay = 1;
    }

    if (wlanpage == "2G") {
        setDisplay("CustChannel_2g", isDisplay);
        if (aisAp == "1") {
            for (var i = 1; i <= 11; i++) {
                var selectName = "Channel" + i;
                document.getElementById(selectName).checked = 1;
            }
        }
    }

    if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
        setDisplay("CustChannel_5g", isDisplay);
        if (aisAp == "1") {
            document.getElementById("Band1").checked = 1;
            selectBand("Band1");
            document.getElementById("Band3").checked = 1;
            selectBand("Band3");
        }
    }
}

function AddSubmitParamHighBand(Form) {
    Form.addParameter('y.X_HW_HT20',getSelectVal('X_HW_HT20'));
    Form.addParameter('y.TransmitPower',getSelectVal('TransmitPower'));
    Form.addParameter('y.X_HW_Standard',getSelectVal('X_HW_Standard'));

    Form.setAction('set.cgi?&y=' + WlanBasic.domain + 
                   '&RequestFile=html/amp/wlanadv/WlanAdvance.asp');

    setDisable('applyButton', 1);
    setDisable('cancelButton', 1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
}

function addWdsSubmitParam(Form) {
    var wdsCheckValue = getCheckVal('wds_Enable');
    var configAction = 'InternetGatewayDevice.X_HW_DEBUG.WLANConfigAction';

    if (wdsCheckValue == 1) {
        Form.addParameter('m.Enable', wdsCheckValue);
        Form.addParameter('n.BSSID', getValue('wds_Ap1_BSSID').toUpperCase());
        Form.addParameter('o.BSSID', getValue('wds_Ap2_BSSID').toUpperCase());
        Form.addParameter('p.BSSID', getValue('wds_Ap3_BSSID').toUpperCase());
        Form.addParameter('q.BSSID', getValue('wds_Ap4_BSSID').toUpperCase());

        if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
            Form.setAction('set.cgi?c1=' + configAction + '&x=' + WlanBasic.domain + '.X_HW_AdvanceConf' + 
                            '&y=' + WlanBasic.domain + 
                            '&m=' + WlanBasic.domain + '.X_HW_WDS' + 
                            '&n=' + WlanBasic.domain + '.X_HW_WDS.ClientAP.1' + 
                            '&o=' + WlanBasic.domain + '.X_HW_WDS.ClientAP.2' + 
                            '&p=' + WlanBasic.domain + '.X_HW_WDS.ClientAP.3' + 
                            '&q=' + WlanBasic.domain + '.X_HW_WDS.ClientAP.4' + 
                            '&z=' + XHWGlobalConfig.domain + 
                            '&c2=' + configAction +
                            '&RequestFile=html/amp/wlanadv/WlanAdvance.asp');
        } else {
            Form.setAction('set.cgi?c1=' + configAction + '&x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_AdvanceConf' + 
                            '&y=' + WlanBasic.domain + 
                            '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS' + 
                            '&n=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.1' + 
                            '&o=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.2' + 
                            '&p=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.3' + 
                            '&q=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.4' + 
                            '&c2=' + configAction +
                            '&RequestFile=html/amp/wlanadv/WlanAdvance.asp');
        }
    } else {
        Form.addParameter('m.Enable', wdsCheckValue);

        if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
            Form.setAction('set.cgi?c1=' + configAction + '&x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_AdvanceConf' + 
                            '&y=' + WlanBasic.domain + 
                            '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS' + 
                            '&z=' + XHWGlobalConfig.domain + 
                            '&c2=' + configAction +
                            '&RequestFile=html/amp/wlanadv/WlanAdvance.asp');
        } else {
            Form.setAction('set.cgi?c1=' + configAction + '&x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_AdvanceConf' + 
                            '&y=' + WlanBasic.domain + 
                            '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS' + 
                            '&c2=' + configAction +
                            '&RequestFile=html/amp/wlanadv/WlanAdvance.asp');
        }
    }
}

function AddSubmitParam(Form, type) {
    var AutoChannelScope = "";
	if (wlanpage == "5G") {
		if (TMCZSTflag == 1) {
			if (webEnable5G != 1 && curUserType != 0) {
				AlertEx(cfg_wlancfgother_language['amp_5g_webenable']);
				return;
			}
		}
        if ((cfgMode.toUpperCase() == 'SYNCSGP210W') || (cfgMode.toUpperCase() == 'SONETSGP210W')) {
            addSelectChannels(Form);
        }
    }
    if ((cfgMode.toUpperCase() == 'TOTALPLAY2') && (curUserType == sptUserType) && (currentUserName == userName)) {
        var editChannel = getSelectVal('Channel');
        var editHT20 = getSelectVal('X_HW_HT20');
        var editStandard = getSelectVal('X_HW_Standard');
        if ((editChannel != curWifiChannel) || (editHT20 != curHT20) || (editStandard != curStandard)) {
            AlertEx('Error!');
            return;
        }
    }
    if (getSelectVal('Channel') == 0) {
        if (fobidChannel != 1) {
            Form.addParameter('y.Channel',getSelectVal('Channel'));
            Form.addParameter('y.AutoChannelEnable',1); 
        }

        if (((dfsChSwitch == 1) || (X_HT80Flag == 1) || (cfgMode.toUpperCase() == 'CTM')) && (wlanpage == "5G")) {
            if (cablevisFlag == 1) {
                AutoChannelScope = "52,56,60,64,149,153,157,161";
            } else if (PTVDFFlag == 1) {
                AutoChannelScope = "36,40,44,48";
            } else if ((getSelectVal('X_HW_HT20') == 6) && (X_HT80Flag == 1) && (truergFlag != 1)) {
                AutoChannelScope = "36,52,100,116,132,149";
            } else if (cfgMode.toUpperCase() == 'CTM') {
                AutoChannelScope = "149,153,157,161";
            } else {
                AutoChannelScope = ChannelsWithOutDFS;
            }

            if (cfgMode.toUpperCase() == 'ROSUNION') {
                AutoChannelScope = "36,40,44,48";
            }

            if (fobidChannel != 1) {
                Form.addParameter('y.X_HW_AutoChannelScope', AutoChannelScope);
            }
        }
    } else if (getSelectVal('Channel') == -1) {
        if (fobidChannel != 1) {
            Form.addParameter('y.Channel', 0);
            Form.addParameter('y.AutoChannelEnable',1); 
        }

        if ((dfsChSwitch == 1) && (wlanpage == "5G")) {
            if (cablevisFlag == 1) {
                AutoChannelScope = "52,56,60,64,149,153,157,161,100,104,108,112,116,132,136,140";
            } else if (PTVDFFlag == 1) {
                AutoChannelScope = "36,40,44,48,52,56,60,64,100,104,108,112,116,132,136,140";
            } else if (cfgMode.toUpperCase() == 'ROSUNION') {
                AutoChannelScope = "36,40,44,48,52,56,60,64";
            } else {
                AutoChannelScope = "0";
            }

            if (fobidChannel != 1) {
                Form.addParameter('y.X_HW_AutoChannelScope', AutoChannelScope);
            }
        }
    } else {
        if (5 == getSelectVal('X_HW_HT20')) {
            var curChannel = getSelectVal('Channel');
            var ChannelsArr = curChannel.split('+');
            Form.addParameter('y.Channel',ChannelsArr[0]);
            Form.addParameter('y.ChannelPlus',ChannelsArr[1]);
            Form.addParameter('y.AutoChannelEnable',0);
        } else {
            Form.addParameter('y.Channel',getSelectVal('Channel'));
            Form.addParameter('y.AutoChannelEnable',0);
        }
    }

    if ((isSetTriBand()) && (SelHighBand == 1)) {
        AddSubmitParamHighBand(Form);
        return;
    }

    if (AisPrev == "1") {
        AutoChannelScope = ChannelScopeSpecProc();
        Form.addParameter('v.X_HW_ChannelScopeFlag', channelscopeflag);
        Form.addParameter('y.X_HW_AutoChannelScope', AutoChannelScope);
    }

    if (mgtsFlag == 1) {
        Form.addParameter('y.X_HW_AutoChannelPeriodically', getCheckVal('X_HW_AutoChannelPeriodically'));
    }

    if (TripleT == 1) {
        Form.addParameter('y.X_HW_WifiWorkingMode', getSelectVal('X_HW_WifiWorkingMode'));
    }

    if (capWifiWorkMode == 1) {
        Form.addParameter('y.X_HW_WorkMode', getSelectVal('X_HW_WifiWorkingMode'));
    }

    Form.addParameter('y.X_HW_HT20',getSelectVal('X_HW_HT20'));

    if ((RegulatoryDomainImmutable != '1') && (CountryFixFlag != '1')) {
        Form.addParameter('y.RegulatoryDomain',getSelectVal('RegulatoryDomain'));
    }

    if (IsShowTransmitPower()) {
        Form.addParameter('y.TransmitPower',getSelectVal('TransmitPower'));
        if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
            Form.addParameter('Y.TransmitPower', getSelectVal('TransmitPower'));
        }
    }

    Form.addParameter('y.X_HW_Standard',getSelectVal('X_HW_Standard'));
    if (AmpTxBeamformingFlag == '1') {
        Form.addParameter('r.GuardInterval',getSelectVal('GuardInterval'));
        if (wlanpage == '5G') {
            Form.addParameter('y.X_TxBFEnabled',getCheckVal('X_TxBFEnabled'));
            Form.addParameter('y.X_OCCACEnables',getCheckVal('X_OCCACEnables'));
        }
    }

    if ((AmpQHOPFlag == 1)&&(wlanpage == '5G')) {
        Form.addParameter('y.X_QHOPEnables',getCheckVal('X_QHOPEnables'));
    }

    if ((AmpSCSFlag == 1)&&(wlanpage == '5G')) {
        Form.addParameter('y.X_SCSEnables',getCheckVal('X_SCSEnables'));
    }

    var wlgmode = getSelectVal('X_HW_Standard');

    if ((ShowMCSFlag == '1') && (curUserType != sptUserType) && ((wlgmode == '11na') || (wlgmode == '11ac') || (wlgmode == '11aconly'))) {
        Form.addParameter('y.X_HW_MCS',getSelectVal('X_HW_MCS'));
    }

    if (((curWlanChipType == 2) && (wifiWorkMode == 1)) || (IsCommonSupport == 1)) {
        Form.addParameter('y.X_HW_WorkMode',getSelectVal('X_HW_WorkMode'));
    }

    if (WlanBasic.X_HW_Standard != getSelectVal('X_HW_Standard')) {
        if ((DoubleFreqFlag == 0) || (wlanpage == "2G")) {
            if (0 < bandIncludeWifiCoverSsid) {
                if (ConfirmEx(cfg_wificover_adv_language['amp_wificover_ssid_glb_notify']) == false) {
                    bandIncludeWifiCoverSsid = 0;
                    setDisable('applyButton', 1);
                    setDisable('cancelButton', 1);
                    return;
                }
            }
        }
    }

    if (t2Flag == '1') {
        if (wlanpage == '5G') {
            Form.addParameter('v.X_HW_AirtimeFairness',getCheckVal('X_HW_AirtimeFairness'));
        }
        Form.addParameter('w.UsersPerSSIDEnable',getCheckVal('UsersPerSSIDEnable'));
    }

    if ((wifiUpStatus == 1) && (TribandFlag == 0)) {
        if (ConfirmEx(cfg_wificover_adv_language['amp_wificover_modify_wlancfg_sug']) == false) {
            return;
        }
    }

    if (DslTalkTalkFlag != 1) {
        Form.addParameter('x.DtimPeriod',getValue('DtimPeriod'));
        Form.addParameter('x.BeaconPeriod',getValue('BeaconPeriod'));
        Form.addParameter('x.RTSThreshold',getValue('RTSThreshold'));
        Form.addParameter('x.FragThreshold',getValue('FragThreshold'));
    } else {
        Form.addParameter('t.Enable',getCheckVal('X_HW_AirtimeFairness'));
    }

    if ((cusTruerg == 1) && (wlanpage == '5G')) {
        Form.addParameter('v.X_MUMIMOEnabled', getCheckVal('MuMimoEnable'));
    }

    if (capBandSteering == 1) {
        var BandSteeringPolicy = getCheckVal('BandSteeringPolicy');
        Form.addParameter('z.BandSteeringPolicy', BandSteeringPolicy);
    }

    if (ProductType == 2) {
        if (DslTalkTalkFlag != 1) {
            Form.addParameter('v.X_HW_AirtimeFairness',getCheckVal('X_HW_AirtimeFairness'));
        }

        if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
            Form.addParameter('v.X_MUMIMOEnabled',getCheckVal('X_MUMIMOEnabled'));
            Form.addParameter('y.X_TxBFEnabled',getCheckVal('X_TxBFEnabled'));
            Form.addParameter('y.X_TxBFImplicit',getCheckVal('X_TxBFEnabled'));
        }
    }

    if (capAirtimeFairness == 1) {
        Form.addParameter('v.X_HW_AirtimeFairness',getCheckVal('X_HW_AirtimeFairness'));
    }

    if (RSSIThrFlag == 1) {
        Form.addParameter('y.X_HW_RSSIThreshold', parseInt(getValue('X_HW_RSSIThreshold'), 10));
        Form.addParameter('y.X_HW_RSSIThresholdEnable', parseInt(getCheckVal('X_HW_RSSIThresholdEnable'), 10));
    }

    if (rosFlag == 1) {
        Form.addParameter('v.X_HW_PreambleType',getSelectVal('X_HW_PreambleType'));
    }

    if (WdsFlag == 1) {
       addWdsSubmitParam(Form);
    } else {
        var configAction = 'InternetGatewayDevice.X_HW_DEBUG.WLANConfigAction';
        var url = 'set.cgi?';
        if (!CheckConfigChannel(getSelectVal('Channel'), WlanBasic.Channel)) {
            url += 'c1=' + configAction + '&';
            Form.addParameter('c1.ActionType', 0);
        }

        if (t2Flag == '1') {
            if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
                url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' + 
                               '&y=' + WlanBasic.domain + 
                               '&r=' + WiFiRadio.domain + 
                               '&z=' + XHWGlobalConfig.domain + 
                               '&v=' + AttachConf.domain;
            } else {
                url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' + 
                               '&y=' + WlanBasic.domain + 
                               '&r=' + WiFiRadio.domain + 
                               '&w=' + XHWAdvanceCfg.domain;
            }
        } else if ((ProductType == 2) || (PTVDFFlag == 1)) {
            if (DslTalkTalkFlag == 1) {
                url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' + 
                               '&y=' + WlanBasic.domain + 
                               '&r=' + WiFiRadio.domain + 
                               '&v=' + AttachConf.domain + 
                               '&t=' + AirtimeConf.domain + 
                               '&z=' + XHWGlobalConfig.domain;
            } else {
                url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' + 
                               '&y=' + WlanBasic.domain + 
                               '&r=' + WiFiRadio.domain + 
                               '&v=' + AttachConf.domain + 
                               '&z=' + XHWGlobalConfig.domain;
            }
        } else {
            if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
                if (!bsdGlbSubmitFirst) {
                    url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' +
                                   '&v=' + AttachConf.domain +
                                   '&y=' + WlanBasic.domain +
                                   '&r=' + WiFiRadio.domain +
                                   '&z=' + XHWGlobalConfig.domain;
                } else {
                    url += 'z=' + XHWGlobalConfig.domain + 
                                   '&v=' + AttachConf.domain +
                                   '&x=' + WlanBasic.domain + '.X_HW_AdvanceConf' + 
                                   '&y=' + WlanBasic.domain + 
                                   '&r=' + WiFiRadio.domain;
                }
            } else {
                if ((AisPrev == 1) || (rosFlag == 1)) {
                    url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' +
                                   '&v=' + AttachConf.domain +
                                   '&y=' + WlanBasic.domain +
                                   '&r=' + WiFiRadio.domain;
                } else {
                    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
                        url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' +
                                       '&v=' + AttachConf.domain +
                                       '&y=' + WlanBasic.domain +
                                       '&Y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5' +
                                       '&r=' + WiFiRadio.domain;
                    } else {
                        url += 'x=' + WlanBasic.domain + '.X_HW_AdvanceConf' +
                                       '&v=' + AttachConf.domain +
                                       '&y=' + WlanBasic.domain +
                                       '&r=' + WiFiRadio.domain;
                    }
                }
            }
        }

        if (!CheckConfigChannel(getSelectVal('Channel'), WlanBasic.Channel)) {
            url += '&c2=' + configAction;
            Form.addParameter('c2.ActionType', 1);
            Form.addParameter('c2.SSIDList', '' + getInstIdByDomain(WlanBasic.domain));
        }
		url += '&RequestFile=html/amp/wlanadv/WlanAdvance.asp';
        Form.setAction(url);
    }

    setDisable('applyButton', 1);
    setDisable('cancelButton', 1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
}

function stWlanStaBoost(domain, ChipIndex, MACAddress, Duration, DurationTime) {
    this.domain = domain;
    this.ChipIndex = ChipIndex;
    this.MACAddress = MACAddress.toUpperCase();
    this.Duration = Duration;
    this.DurationTime = DurationTime;
}

var boost = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WiFi.Radio.{i}.X_HW_WLANSTABoost.{i},ChipIndex|MACAddress|Duration|DurationTime,stWlanStaBoost);%>;
function CheckBoost() {
    var atfEnable = getCheckVal("X_HW_AirtimeFairness");
    if (atfEnable == 0) {
        for (var i = 0;i < boost.length - 1; i++) {
            if (((wlanpage == "2G") && (boost[i].ChipIndex == 0)) || ((wlanpage == "5G") && (boost[i].ChipIndex == 1))) {
                AlertEx(cfg_wlancfgadvance_language['amp_advance_atf_note']);
                setCheck("X_HW_AirtimeFairness", 1);
                return;
            }
        }
    }
}

function InitMuMimo()
{
    if ((cusTruerg == 1) && (wlanpage == '5G')) {
        setCheck('MuMimoEnable', AttachConf.X_MUMIMOEnabled);
    }
}

function CancelConfig() {
    initStandardChangeDropDownList();
    setTableValue();
    X_HW_StandardChange();
    LoadWdsConfig();
    setAdvanceSug();
    Init_HW_QHOP();
    InitMuMimo();
}

function loadTableTitle() {
    if (mgtsFlag == 1) {
        setDisplay('X_HW_AutoChannelPeriodicallyRow', 1);
    } else {
        setDisplay('X_HW_AutoChannelPeriodicallyRow', 0);
    }

    if ((TripleT == 1) || (capWifiWorkMode == 1)) {
        setDisplay('X_HW_WifiWorkingModeRow', 1);
    } else {
        setDisplay('X_HW_WifiWorkingModeRow', 0);
    }

    if (!IsShowTransmitPower()) {
        setDisplay('TransmitPowerRow', 0);
    }

    var DtimPeriodDescRef = 'amp_dtim_timenote';
    if(t2Flag == 1) {
        if(wlanpage == "2G") {
            DtimPeriodDescRef = 'amp_dtim_timenote1';
        } else {
            DtimPeriodDescRef = 'amp_dtim_timenote2'; 
        }
    }

    $('#DtimPeriod').attr('title', cfg_wlancfgadvance_language[DtimPeriodDescRef]);
    getElementById('DtimPeriodRemark').innerHTML = cfg_wlancfgadvance_language[DtimPeriodDescRef];

    if (capBcnInerval == 1) {
        $('#BeaconPeriod').attr('title', cfg_wlancfgadvance_language['amp_beacon_timenote']);
        getElementById('BeaconPeriodRemark').innerHTML = cfg_wlancfgadvance_language['amp_beacon_timenote'];
    } else {
        $('#BeaconPeriod').attr('title', cfg_wlancfgadvance_language['amp_beacon_timenote_bcn']);
        getElementById('BeaconPeriodRemark').innerHTML = cfg_wlancfgadvance_language['amp_beacon_timenote_bcn'];
    }

    var RTSThresholdRowDescRef = 'amp_rts_thresholdnote';
    if(t2Flag == 1) {
        if(wlanpage == "5G") {
            RTSThresholdRowDescRef = 'amp_rts_thresholdnote_tde';
        } else {
            RTSThresholdRowDescRef = 'amp_rts_thresholdnote_tde2'; 
        }
    }

    $('#RTSThreshold').attr('title', cfg_wlancfgadvance_language[RTSThresholdRowDescRef]);
    getElementById('RTSThresholdRemark').innerHTML = cfg_wlancfgadvance_language[RTSThresholdRowDescRef];

    $('#FragThreshold').attr('title', cfg_wlancfgadvance_language['amp_frag_thresholdnote']);
    getElementById('FragThresholdRemark').innerHTML = cfg_wlancfgadvance_language['amp_frag_thresholdnote'];

    if (RSSIThrFlag == 1) {
        $('#X_HW_RSSIThreshold').attr('title', cfg_wlancfgadvance_language['amp_wlan_rssithreshold_alert']);    
        getElementById('X_HW_RSSIThresholdRemark').innerHTML = cfg_wlancfgadvance_language['amp_wlan_rssithreshold_note'];
        setDisplay('X_HW_RSSIThresholdEnable' + 'Row', 1);
        setDisplay('X_HW_RSSIThreshold' + 'Row', WlanBasic.X_HW_RSSIThresholdEnable);
    } else {
        setDisplay('X_HW_RSSIThresholdEnable' + 'Row', 0);
        setDisplay('X_HW_RSSIThreshold' + 'Row', 0);
    }

    getElementById('wds_Enablespan').innerHTML = cfg_wlancfgadvance_language['amp_wds_notes'];

    $('#wds_Ap1_BSSID').attr('title', cfg_wlancfgadvance_language['amp_wds_address_demo']);
    getElementById('wds_Ap1_BSSIDRemark').innerHTML = cfg_wlancfgadvance_language['amp_wds_address_demo'];

    $('#wds_Ap2_BSSID').attr('title', cfg_wlancfgadvance_language['amp_wds_address_demo']);
    getElementById('wds_Ap2_BSSIDRemark').innerHTML = cfg_wlancfgadvance_language['amp_wds_address_demo'];

    $('#wds_Ap3_BSSID').attr('title', cfg_wlancfgadvance_language['amp_wds_address_demo']);
    getElementById('wds_Ap3_BSSIDRemark').innerHTML = cfg_wlancfgadvance_language['amp_wds_address_demo'];

    $('#wds_Ap4_BSSID').attr('title', cfg_wlancfgadvance_language['amp_wds_address_demo']);
    getElementById('wds_Ap4_BSSIDRemark').innerHTML = cfg_wlancfgadvance_language['amp_wds_address_demo'];

    $('#X_TxBFEnabled').attr('title', cfg_wlancfgadvance_language['amp_tx_beamforming_note']);
    $('#X_HW_AirtimeFairness').attr('title', cfg_wlancfgadvance_language['amp_airtimefairness_note']);
    $('#BandSteeringPolicy').attr('title', cfg_wlancfgadvance_language['amp_BandSteering_note']);
    $('#X_MUMIMOEnabled').attr('title', cfg_wlancfgadvance_language['amp_MUMIMO_note']);
}

function setTableValue() {
    setSelect('X_HW_WorkMode', totalWlanAttr.X_HW_WorkMode);
    setSelect('TransmitPower', totalWlanAttr.TransmitPower);
    setSelect('X_HW_Standard', totalWlanAttr.X_HW_Standard);
    
    if (getSelectVal('X_HW_Standard') != totalWlanAttr.X_HW_Standard) {
        setSelect('X_HW_Standard', "11bgn");
    }

    setSelect('RegulatoryDomain', totalWlanAttr.RegulatoryDomain);
    setSelect('X_HW_HT20', totalWlanAttr.X_HW_HT20);
    setSelect('Channel', totalWlanAttr.Channel);
    setSelect('X_HW_MCS', totalWlanAttr.X_HW_MCS);
    setSelect('GuardInterval', totalWlanAttr.GuardInterval);
    setCheck('X_IEEE80211wEnabled', totalWlanAttr.X_IEEE80211wEnabled);
    setCheck('X_TxBFEnabled', totalWlanAttr.X_TxBFEnabled);
    setCheck('X_OCCACEnables', totalWlanAttr.X_OCCACEnables);
    setCheck('X_HW_AirtimeFairness', totalWlanAttr.X_HW_AirtimeFairness);
    setCheck('BandSteeringPolicy', totalWlanAttr.BandSteeringPolicy);
    setText('DtimPeriod', totalWlanAttr.DtimPeriod);
    setText('BeaconPeriod', totalWlanAttr.BeaconPeriod);
    setText('RTSThreshold', totalWlanAttr.RTSThreshold);
    setText('FragThreshold', totalWlanAttr.FragThreshold);
    setCheck('X_HW_RSSIThresholdEnable', WlanBasic.X_HW_RSSIThresholdEnable);
    setText('X_HW_RSSIThreshold', WlanBasic.X_HW_RSSIThreshold);
}

function loadFrameTable() {
    loadTableTitle();
    InitWlanBasicDropDownList();
    setTableValue();
    setDisplay('TablewlanadvForm', 1);
    rebuildWlanBasicDropDownList();
    InitX_HW_PreambleType("X_HW_PreambleType");
    setSelect('X_HW_MCS', totalWlanAttr.X_HW_MCS);
    LoadWdsConfig();
}

function LoadFrameWifiHighBand() {
    WlanWifiInitForHighBand5G();
    TotalHighBand5G();
    if (enbl == 1) {
        WifiAdvanceShow((enbl5G != "0") && (totalHighBand5gNum > 0));
    } else {
        WifiAdvanceShow(enbl != "0");
    }

    setBindText();
    setAdvanceSug();

    if ((PTVDFFlag == 1) && (wlanpage == '5G')) {
        document.getElementById('X_HW_HT20').title = cfg_wlan_tips_language['amp_wlan_channelwidth_tips'];
        document.getElementById('Channel').title = cfg_wlan_tips_language['amp_wlan_channel_tips'];
    }

    setDisplay('X_HW_MCS' + 'Row', 0);
    setDisplay('X_HW_RSSIThresholdEnable' + 'Row', 0);
    setDisplay('X_HW_RSSIThreshold' + 'Row', 0);
    setDisplay('X_HW_WorkMode' + 'Row', 0);
    setDisplay('wds_Enable' + 'Row', 0);
    setDisplay('X_HW_WlanMac' + 'Row', 0);
    setDisplay('wds_Ap1_BSSID' + 'Row', 0);
    setDisplay('wds_Ap2_BSSID' + 'Row', 0);
    setDisplay('wds_Ap3_BSSID' + 'Row', 0);
    setDisplay('wds_Ap4_BSSID' + 'Row', 0);
    setDisplay('X_QHOPEnablesRow', 0); 
    setDisplay('X_HW_AirtimeFairnessRow', 0);
    setDisplay('UsersPerSSIDEnableRow', 0);
    setDisplay('DtimPeriod' + 'Row', 0);
    setDisplay('BeaconPeriod' + 'Row', 0);
    setDisplay('RTSThreshold' + 'Row', 0);
    setDisplay('FragThreshold' + 'Row', 0);
    setDisplay('GuardIntervalRow', 0); 
    setDisplay('X_IEEE80211wEnabledRow', 0);
    setDisplay('X_OCCACEnablesRow', 0); 
    setDisplay('X_TxBFEnabledRow', 0);
    setDisplay("FragThresholdRow", 0);
    setDisplay('X_SCSEnablesRow', 0); 
    setDisplay('X_MUMIMOEnabledRow', 0);

    setDisable('RegulatoryDomain',1);
}

function LoadFrameWifi() {
    loadFrameTable();

    if ((wlanpage == "5G") && ((cfgMode.toUpperCase() == 'SYNCSGP210W') || (cfgMode.toUpperCase() == 'SONETSGP210W'))) {
        UpdateCheckBoxState();
    }

    if (isSetTriBand()) {
        getElement('menu1').className = (0 == SelHighBand) ? 'hover' :'';
        getElement('menu2').className = (1 == SelHighBand) ? 'hover' :'';
        $('#wlanadvForm').addClass('MenuboxDivBorder');
        setDisplay('TriBandMenuDiv', 1);
    } else {
        $('#wlanadvForm').removeClass('MenuboxDivBorder');
        setDisplay('TriBandMenuDiv', 0);
    }

    if (isSetTriBand() && (SelHighBand == 1)) {
        LoadFrameWifiHighBand();
        return;
    }

    Total2gNum();
    if (DoubleFreqFlag == 1) {
        if (enbl == 1) {
            if (wlanpage == '2G') {
                WifiAdvanceShow((enbl2G != "0") && (totalSSID2gNum > 0));
            }
            
            if (wlanpage == '5G') {
                WifiAdvanceShow((enbl5G != "0") && (totalSSID5gNum > 0));
                if ((capBandSteering == 1) && (isVideoRetrans == 0)) {
                    setDisplay('BandSteeringPolicyRow', 1);
                    setCheck('BandSteeringPolicy', XHWGlobalConfig.BandSteeringPolicy);
                }

                if (((turkcellFlag == 1) && (curUserType != 0)) || (truergFlag == 1) || (cfgMode.toUpperCase() == 'PLDT2')) {
                    setDisplay('BandSteeringPolicyRow', 0);
                }
            }
        } else {
            WifiAdvanceShow((enbl != "0") && (wlanArrLen > 0));
        }

        if (IsSonetSptUser()) {
            setDisplay('RegulatoryDomain' + 'Row', 0);
        }
    } else {
        WifiAdvanceShow((enbl != "0") && (wlanArrLen > 0));
    }

    if ((gzcmccFlag == 1) && (curUserType == sptUserType)) {
        setDisable('applyButton', 1);
        setDisable('cancelButton', 1);
    }

    if (capAirtimeFairness == 1) {
        setCheck('X_HW_AirtimeFairness', AttachConf.X_HW_AirtimeFairness);
        setDisplay('X_HW_AirtimeFairnessRow', 1);
    } else {
        setDisplay('X_HW_AirtimeFairnessRow', 0);
    }

    if ((DoubleFreqFlag == 1) && (wlanpage == "5G") && (ShowMCSFlag == '1') && (curUserType == sysUserType) &&
       ((WlanBasic.X_HW_Standard == '11na') || (WlanBasic.X_HW_Standard == '11ac') || (WlanBasic.X_HW_Standard == '11aconly'))) {
        setDisplay('X_HW_MCS' + 'Row', 1);
    } else {
        setDisplay('X_HW_MCS' + 'Row', 0);
    }

    SetRegulatoryDomainDisable();

    if (IsPTVDFSptUser()) {
        setDisplay('RegulatoryDomain' + 'Row', 0);
    }

    InitHwWorkModeTips();

    setBindText();
    setAdvanceSug();

    if (hiLinkRoll == 0) {
        setDisable('X_HW_HT20', 1);
        setDisable('X_HW_Standard', 1);
    }

    if (wifiUpStatus == 1) {
        var RetEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_RetransConfig.RetransEnable);%>';

        if ((TribandFlag == 0) || ((RetEnable == 1) && (wlanpage == '2G'))) {
            setDisable('Channel', 1);
        }
    }

    if (AmpQHOPFlag == 1) {
        if (wlanpage == '2G') {
            setDisplay('X_QHOPEnablesRow', 0); 
        } else if (wlanpage == '5G') {
            setCheck('X_QHOPEnables',WlanBasic.X_QHOPEnables);
            setDisplay('X_QHOPEnablesRow', 1);
        }
    } else {
        setDisplay('X_QHOPEnablesRow', 0); 
    }

    if (t2Flag == '1') {
        setDisplay('X_HW_AirtimeFairnessRow', 0);
        if (wlanpage == '5G') {
            setDisplay('X_HW_AirtimeFairnessRow', 1);
            setDisplay('UsersPerSSIDEnableRow', 0);
            setCheck('X_HW_AirtimeFairness',AttachConf.X_HW_AirtimeFairness);
            setDisable('X_HW_HT20', 1); 
        } else {
            setCheck('UsersPerSSIDEnable',XHWAdvanceCfg.UsersPerSSIDEnable);
            setDisplay('UsersPerSSIDEnableRow', 1);
        }
    } else {
        setDisplay('X_HW_AirtimeFairnessRow', capAirtimeFairness);
        setDisplay('UsersPerSSIDEnableRow', 0);
    }

    if (AmpTxBeamformingFlag == 1) {
        if (wlanpage == '2G') {
            setDisplay('GuardIntervalRow', 1); 
            setDisplay('X_TxBFEnabledRow', 0); 
            setDisplay('X_IEEE80211wEnabledRow', 0);
            setDisplay('X_OCCACEnablesRow', 0);
        } else if (wlanpage == '5G') {
            setDisplay('GuardIntervalRow', 1); 
            setCheck('X_IEEE80211wEnabled',WlanBasic.X_IEEE80211wEnabled);
            setDisplay('X_IEEE80211wEnabledRow', 1);
            setDisable('X_IEEE80211wEnabled', 1);

            setCheck('X_TxBFEnabled',WlanBasic.X_TxBFEnabled);
            setDisplay('X_TxBFEnabledRow', 1); 

            setCheck('X_OCCACEnables',WlanBasic.X_OCCACEnables);
            setDisplay('X_OCCACEnablesRow', 1);  
        }
    } else {
        setDisplay('GuardIntervalRow', 0); 
        setDisplay('X_IEEE80211wEnabledRow', 0);
        setDisplay('X_OCCACEnablesRow', 0); 
        setDisplay('X_TxBFEnabledRow', 0); 
    }

    if (PccwFlag == 1) {
        if ((DoubleFreqFlag == 1) && (wlanpage == '2G')) {
            if ((wlanArr[0] == null) || (wlanArr[0].X_HW_ServiceEnable == 0) || (wlanArr[0].Name != "ath0")) {
                setDisplay('div_wlanadv', 0);
            } else {
                PccwSetDislayFunc();
            }
            return;
        } else if ((DoubleFreqFlag == 1) && (wlanpage == '5G')) {
            var index;
            for (index = 0; index < wlanArrLen; index++) {
                if (wlanArr[index].Name == "ath4") {
                    break;
                }
            } 
            
            if ((index >= wlanArrLen) || (wlanArr[index].X_HW_ServiceEnable == 0)) {
                setDisplay('div_wlanadv', 0);
            } else {
                PccwSetDislayFunc();
            }
            return;
        } else {
            if ((wlanArr[0] == null) || (wlanArr[0].X_HW_ServiceEnable == 0)) {
                setDisplay('div_wlanadv', 0);
            } else {
                PccwSetDislayFunc();  
            }
            return;
        }
    }

    if (fragCap == 0) {
        setDisplay("FragThresholdRow", 0);
    }

    if ((PTVDFFlag == 1) && (wlanpage == '5G')) {
        document.getElementById('X_HW_HT20').title = cfg_wlan_tips_language['amp_wlan_channelwidth_tips'];
        document.getElementById('Channel').title = cfg_wlan_tips_language['amp_wlan_channel_tips'];
    }

    if (AtTelecomFlag == 1) {
        if (curUserType == sptUserType) {
            setDisable('TransmitPower', 1);
            setDisable('RegulatoryDomain', 1);
            setDisable('Channel', 1);
            setDisable('X_HW_HT20', 1);
            setDisable('BandSteeringPolicy', 1);

            setDisable('DtimPeriod', 1);
            setDisable('BeaconPeriod', 1);
            setDisable('RTSThreshold', 1);
            setDisable('FragThreshold', 1);

            setDisable('applyButton', 1);
            setDisable('cancelButton', 1);
            setDisable('X_HW_Standard', 1);
        }
    }
    
    if ((AmpSCSFlag == 1) && (wlanpage == '5G')) {
        setCheck('X_SCSEnables', WlanBasic.X_SCSEnables);
        setDisplay('X_SCSEnablesRow', 1);
    } else {
        setDisplay('X_SCSEnablesRow', 0); 
    }

    if (mgtsFlag == 1) {
        setCheck('X_HW_AutoChannelPeriodically', WlanBasic.X_HW_AutoChannelPeriodically);
    }

    if (TripleT == 1) {
        setSelect('X_HW_WifiWorkingMode', WlanBasic.X_HW_WifiWorkingMode);
    }

    if (capWifiWorkMode == 1) {
        setSelect('X_HW_WifiWorkingMode', WlanBasic.X_HW_WorkMode);
        document.getElementById('X_HW_WifiWorkingMode').title = cfg_wlan_tips_language['amp_wlan_work_mode_tips'];
    }

    if (AisPrev == 1) { 
        setDisplay("AutoChannelScopeFt", 1);
        if ((wlanpage == "5G") && ((getSelectVal('X_HW_HT20') == 7) || (getSelectVal('X_HW_HT20') == 4))) {
            setRadio("WlanMethod", 1);
            setDisplay("CustChannel_5g", 0);
            $("input[name='WlanMethod']").attr('disabled', true);
        }
        InitAutoChannelScope();
    }

    if (cablevisFlag == 1 && curUserType == sptUserType) {
        if (wlanpage == '2G') {
            setDisable('X_HW_HT20', 1);
        }
    } 
    
    if (fobidChannel == 1) {
        setDisable('Channel', 1);
    }

    if (ProductType == 2) {
        setCheck('X_HW_AirtimeFairness', AttachConf.X_HW_AirtimeFairness);
        if (capAirtimeFairness == 1) {
            setDisplay('X_HW_AirtimeFairnessRow', 1);
        } else {
            setDisplay('X_HW_AirtimeFairnessRow', 0);
        }

        if ((DoubleFreqFlag == 1) && (wlanpage == '5G')) {
            if (capMU_MIMO == 1) {
                setCheck('X_MUMIMOEnabled', AttachConf.X_MUMIMOEnabled);
                setDisplay('X_MUMIMOEnabledRow', 1);
            } else {
                setDisplay('X_MUMIMOEnabledRow', 0);
            }
            setCheck('X_TxBFEnabled', WlanBasic.X_TxBFEnabled);
            setDisplay('X_TxBFEnabledRow', 1); 
        }
    }

    if (PTVDFFlag == 1) {
        if (capAirtimeFairness == 1) {
            setCheck('X_HW_AirtimeFairness', AttachConf.X_HW_AirtimeFairness);
            setDisplay('X_HW_AirtimeFairnessRow', 1);
        } else {
            setDisplay('X_HW_AirtimeFairnessRow', 0);
        }
    }

    if (DslTalkTalkFlag == 1) {
        TalkTalkSetCheckFunc();
        TalkTalkSetDislayFunc();
    }

    if ((DtHuFlag == 1) && (curUserType != 0)) {
        setDisplay('DtimPeriodRow', 0);
        setDisplay('BeaconPeriodRow', 0);
        setDisplay('FragThresholdRow', 0);
        setDisplay('RTSThresholdRow', 0);
    }

    if ((cusTruerg == 1) && (wlanpage == '5G')) {
        setDisplay('MuMimoEnableRow', 1);
        setCheck('MuMimoEnable', AttachConf.X_MUMIMOEnabled);
    }

    if (rosFlag == 1) {
        setDisplay('X_HW_PreambleTypeRow', 1);
        setSelect('X_HW_PreambleType', AttachConf.X_HW_PreambleType);
    }
    
    if (isFitAp == 1) {
        FitApDisable();
    }

    if (CfgMode.toUpperCase() == 'STC2' && curLanguage === 'arabic') {
        document.getElementById("X_HW_Standardspan").style.position = "static";
        document.getElementById("X_HW_Standardspan").style.marginRight = "168px";
    }

    if ((cfgMode.toUpperCase() == 'TOTALPLAY2') && (curUserType == sptUserType) && (currentUserName == userName)) {
        curWifiChannel = getSelectVal('Channel');
        curHT20 = getSelectVal('X_HW_HT20');
        curStandard = getSelectVal('X_HW_Standard');
        setDisable('X_HW_Standard', 1);
        setDisable('X_HW_HT20', 1);
        setDisable('Channel', 1);
    }
}

function FitApDisable() {
    setDisable("TransmitPower", 1);
    setDisable("RegulatoryDomain", 1);
    setDisable('Channel', 1);
    setDisable('X_HW_HT20', 1);
    setDisable('X_HW_Standard', 1);
    setDisable('X_HW_AirtimeFairness', 1);
    setDisable('BandSteeringPolicy', 1);
    setDisable('DtimPeriod', 1);
    setDisable('BeaconPeriod', 1);
    setDisable('RTSThreshold', 1);
    setDisable('FragThreshold', 1);
    setDisable('applyButton', 1);
    setDisable('cancelButton', 1);
}
