var wlan11acFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_11AC);%>';
var t2Flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TDEWIFI);%>';
var ftAcOnly  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_11ACONLY);%>';
var mgtsFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_MGTS);%>';
var fobidChannel = '<%HW_WEB_GetFeatureSupport(AMP_FT_WLAN_FOBID_CHANNEL);%>';
var wifiUpStatus ='<%HW_WEB_WiFiUpLinkStatus();%>';
var currUpLinkStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var hiLinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var cfgMode = CfgModeWord;
var aisAp = '<%HW_WEB_GetFeatureSupport(FT_WLAN_AISAP);%>';
var typeWord = '<%HW_WEB_GetTypeWordMode();%>';
var aisAPmode = '<%HW_WEB_GetFeatureSupport(FT_AISAP_MODE);%>';

var apExtendedWLC = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC,EXTEND);%>;
var wlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|WMMEnable|X_HW_WorkMode|X_IEEE80211wEnabled|X_TxBFEnabled|X_OCCACEnables|X_HW_MCS|X_HW_RSSIThreshold|X_HW_RSSIThresholdEnable|ChannelPlus|X_SCSEnables|X_HW_AutoChannelPeriodically|X_HW_AutoChannelScope|X_HW_WifiWorkingMode|X_QHOPEnables|BeaconType|BasicEncryptionModes|WPAEncryptionModes|IEEE11iEncryptionModes|X_HW_WPAand11iEncryptionModes|X_HW_ServiceEnable|X_HW_UsedForCover, stWlanWifi);%>;
var WlanAdvs = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AdvanceConf,DtimPeriod|BeaconPeriod|RTSThreshold|FragThreshold,stWlanAdv);%>;
var AttachConfs = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AttachConf,X_HW_AirtimeFairness|X_HW_ChannelScopeFlag|X_MUMIMOEnabled|X_HW_PreambleType,stAttachConf);%>;
var DtHuFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DT_HUNGARY);%>';
var dfsSilentEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WIFIInfo.WlanDfsControl.DfsSilentEnable, DB);%>';

var dfsChSwitch = 0;
var dfsRadorGroup = 1;
var weatherRadorGroup = 2;
var possibleChannels = "";
var totalSSID2gNum = 0;
var totalSSID5gNum = 0;
var uiTotalNum = 0;
var wlanArrLen = wlanArr.length - 1;
var bandIncludeWifiCoverSsid = 0;
var ChannelsWithOutDFS = 0;

function stWlanWifi(domain, Name, Enable, SSID, wlHide, X_HW_Standard, Channel, TransmitPower, RegulatoryDomain, AutoChannelEnable, X_HW_HT20, wmmEnable, X_HW_WorkMode, 
                    X_IEEE80211wEnabled, X_TxBFEnabled, X_OCCACEnables, X_HW_MCS, X_HW_RSSIThreshold, X_HW_RSSIThresholdEnable, ChannelPlus, X_SCSEnables, 
                    X_HW_AutoChannelPeriodically, X_HW_AutoChannelScope, X_HW_WifiWorkingMode, X_QHOPEnables, BeaconType, BasicEncryptionModes, WPAEncryptionModes, 
                    IEEE11iEncryptionModes, X_HW_WPAand11iEncryptionModes, X_HW_ServiceEnable, X_HW_UsedForCover) {
    this.domain = domain;
    this.Name = Name;
    this.Enable = Enable;
    this.SSID = SSID;
    this.wlHide = wlHide;
    this.X_HW_Standard = X_HW_Standard;
    this.Channel = Channel;
    this.TransmitPower = TransmitPower;
    this.RegulatoryDomain = RegulatoryDomain;
    this.AutoChannelEnable = AutoChannelEnable;
    this.X_HW_HT20 = X_HW_HT20;
    this.wmmEnable = wmmEnable;
    this.X_HW_WorkMode = X_HW_WorkMode;
    this.X_IEEE80211wEnabled = X_IEEE80211wEnabled;
    this.X_TxBFEnabled = X_TxBFEnabled;
    this.X_OCCACEnables = X_OCCACEnables;
    this.X_HW_MCS = X_HW_MCS;
    this.X_HW_RSSIThreshold = X_HW_RSSIThreshold;
    this.X_HW_RSSIThresholdEnable = X_HW_RSSIThresholdEnable;
    this.ChannelPlus = ChannelPlus;
    this.X_SCSEnables = X_SCSEnables;
    this.X_HW_AutoChannelPeriodically = X_HW_AutoChannelPeriodically;
    this.X_HW_AutoChannelScope = X_HW_AutoChannelScope;
    this.X_HW_WifiWorkingMode = X_HW_WifiWorkingMode;
    this.X_QHOPEnables = X_QHOPEnables;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.X_HW_UsedForCover = X_HW_UsedForCover;
}

function stWlanAdv(domain, DtimPeriod, BeaconPeriod, RTSThreshold, FragThreshold) {
    this.domain = domain;
    this.DtimPeriod = DtimPeriod;
    this.BeaconPeriod = BeaconPeriod;
    this.RTSThreshold = RTSThreshold;
    this.FragThreshold = FragThreshold;
}

function stAttachConf(domain, X_HW_AirtimeFairness, X_HW_ChannelScopeFlag, X_MUMIMOEnabled, X_HW_PreambleType) {
    this.domain = domain;
    this.X_HW_AirtimeFairness = X_HW_AirtimeFairness;
    this.X_HW_ChannelScopeFlag = X_HW_ChannelScopeFlag;
    this.X_MUMIMOEnabled = X_MUMIMOEnabled;
    this.X_HW_PreambleType = X_HW_PreambleType;
}

function stExtendedWLC(domain, SSIDIndex) {
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
}

function isDFSCountry() {
    if ((mgtsFlag == 1) || (cfgMode.toUpperCase() == 'ZAIN') || (DtHuFlag == 1)) {
        return false;
    } else {
        return true;
    }
}

function checkDFSChSwitchCommon(id, isDFSChSwitch) {
    if ((isDFSChSwitch == 1) && (isDFSCountry() == true)) {
        dfsChSwitch = 1;
        var ChannelWidth = getSelectVal(id);
        var allChannels = possibleChannels;
        ChannelsWithOutDFS = getChannelWithOutDfs(allChannels, ChannelWidth);
    } else {
        dfsChSwitch = 0;
    }
}

function getWlanWifiDefaultForBand(band) {
    var ssidStartInst = (band == 0) ? ssidStart2G : ssidStart5G;
    for (var i = 0; i < wlanArrLen; i++) {
        if (ssidStartInst == getWlanPortNumber(wlanArr[i].Name)) {
            WlanBasic = wlanArr[i];
            WlanAdv = WlanAdvs[i];
            AttachConf = AttachConfs[i];
            return WlanBasic;
        }
    }
}

function setBandWifiCoverSsidFlag(wlanInst) {
    for (var j = 0; j < apExtendedWLC.length - 1; j++) {
        if (wlanInst == apExtendedWLC[j].SSIDIndex) {
            bandIncludeWifiCoverSsid++;
        }
    }
}

function Total2gNum() {
    totalSSID2gNum = 0;
    totalSSID5gNum = 0;

    for (var loop = 0; loop < wlanArrLen; loop++) {
        if (wlanArr[loop].Name == '') {
            continue;
        }

        if ((getWlanPortNumber(wlanArr[loop].Name) > ssidEnd2G) && (getWlanPortNumber(wlanArr[loop].Name) < 2*ssidStart5G)) {
            totalSSID5gNum++;
        } else if ((getWlanPortNumber(wlanArr[loop].Name) >= ssidStart2G) && (getWlanPortNumber(wlanArr[loop].Name) <= ssidEnd2G)) {
            totalSSID2gNum++;
            setBandWifiCoverSsidFlag(getWlanInstFromDomain(wlanArr[loop].domain));
        } else {

        }
    }
}

function getPossibleChannels(freq, country, mode, width) {
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

function loadHT80and80ChannelList() {
    var ShowChannels2 = possibleChannels.split(',');
    ShowChannels = new Array;

    for (var i = 0; i < ShowChannels2.length; i++) {
        for (var j = 0; j < ShowChannels2.length; j++) {
            if ((ShowChannels2[i] != ShowChannels2[j]) && (((ShowChannels2[i] - ShowChannels2[j]) > 16) || ((ShowChannels2[j] - ShowChannels2[i]) > 16))) {
                ShowChannels.push(ShowChannels2[i] + "+" + ShowChannels2[j]);
            }
        }
    }

    return ShowChannels;
}

function judgeDFSCh(autoChannelScope) {
    var AutoChScope = autoChannelScope.split(',');
    if ((AutoChScope.length == 0) || (AutoChScope == '0') || (AutoChScope == '')) {
        return true;
    }

    for (var i = 0; i < AutoChScope.length; i++) {
        if ((AutoChScope[i] >= 52) && (AutoChScope[i] <= 144)) {
            return true;
        }
    }
    return false;
}

function loadChannelList(freq, country, mode, width) {
    getPossibleChannels(freq, country, mode, width);
    checkDFSChSwitch();
    loadChannelListByFreq(width, freq);
}

function setX_HW_StandardSugCommon(freq, mode, spanX_HW_Standard) {
    if ((mode != '11bgn') && (freq == '2G')) {
        spanX_HW_Standard.innerHTML = cfg_wlancfgadvance_language['amp_advance_working_mode_sug1'];
        spanX_HW_Standard.style.color = '#ff0000';
    } else if ((wlan11acFlag == 1) && (DoubleFreqFlag == 1) && (freq == '5G') && (mode != '11ac')) {
        spanX_HW_Standard.innerHTML = cfg_wlancfgadvance_language['amp_advance_working_mode_sug2'];
        spanX_HW_Standard.style.color = '#ff0000';
    } else if ((wlan11acFlag != 1) && (DoubleFreqFlag == 1) && (freq == '5G') && (mode != '11na')) {
        spanX_HW_Standard.innerHTML = cfg_wlancfgadvance_language['amp_advance_working_mode_sug3'];
        spanX_HW_Standard.style.color = '#ff0000';
    } else {
        spanX_HW_Standard.innerHTML = '';
    }
}

function IsEgpytCustom() {
    if (getSelectVal('RegulatoryDomain') == "EG") {
        return true;
    }

    return false;
}

function isNotCntCfgWidth6orWidth7(width)
{
    if (((width != 6) && (width != 7)) || ((cfgMode.toUpperCase() != 'CNT2') && (cfgMode.toUpperCase() != 'CNT'))) {
        return true;
    }
    return false;
}

function setX_HW_HT20SugCommon(freq, width, spanX_HW_HT20) {
    var widthSug =  getWidthSug();
	if ((freq == "5G") && (cap11ax == 1) && (DoubleFreqFlag == 1)) {
        if (width != 4) {
            spanX_HW_HT20.innerHTML = cfg_wlancfgadvance_language['amp_advance_channelwidemode_short_sug5'];
            spanX_HW_HT20.style.color = '#ff0000';
        } else {
            spanX_HW_HT20.innerHTML = '';
        }
    } else if ((width == 2) && (freq == '2G')) {
        spanX_HW_HT20.innerHTML = widthSug;
        spanX_HW_HT20.style.color = '#ff0000';
    } else if (((width != 3) && (freq == '5G') && (DoubleFreqFlag == 1)) && (isNotCntCfgWidth6orWidth7(width))) {
        if (aisAp == 1) {
            return;
        }
        if ((wlan11acFlag == 1) && (IsEgpytCustom() == false)) {
            spanX_HW_HT20.innerHTML = getWidth80Sug();
            spanX_HW_HT20.style.color = '#ff0000';
        } else {
            if ((getSelectVal('X_HW_HT20') != 0) && (getSelectVal('X_HW_HT20') != 1)) {
                spanX_HW_HT20.innerHTML = widthSug;
                spanX_HW_HT20.style.color = '#ff0000';
            } else {
                spanX_HW_HT20.innerHTML = '';
            }
        }
    } else {
        spanX_HW_HT20.innerHTML = '';
    }
}

function setChannelSugCommon(spanChannel, ChannelVal) {
    if ((ChannelVal != 0) && (ChannelVal != -1)) {
        spanChannel.innerHTML = cfg_wlancfgadvance_language['amp_advance_channel_sug'];
        if (aisAPmode == 1) {
           spanChannel.innerHTML = cfg_wlancfgadvance_language['amp_advance_channel_sug_aisap'];
        }
        spanChannel.style.color = '#ff0000';
    } else {
        spanChannel.innerHTML = '';
    }
}

function setAdvancePartSug(id) {
    setX_HW_HT20Sug(id);
    setX_HW_StandardSug(id);
    setChannelSug(id);
}

function rebuildWlanBasicDropDownList(id) {
    InitX_HW_Standard(id);
    X_HW_StandardChange(id);
}

function setBindText() {
    var all = document.getElementsByTagName("td");
    var allDiv = document.getElementsByTagName("div");
    for (var i = 0; i < all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }

        if (cfg_wlancfgadvance_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgadvance_language[b.getAttribute("BindText")];
        } else if (cfg_wlancfgother_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgother_language[b.getAttribute("BindText")];
        } else if (cfg_wlanzone_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlanzone_language[b.getAttribute("BindText")];
        }

        if (typeof cfg_wifi_adv_desk_language != 'undefined') {
            if (cfg_wifi_adv_desk_language[b.getAttribute("BindText")]) {
                 b.innerHTML = cfg_wifi_adv_desk_language[b.getAttribute("BindText")];
            }
        }
    }

    for (var i = 0; i < allDiv.length; i++) {
        var c = allDiv[i];
        if (c.getAttribute("BindText") == null) {
            continue;
        }
        
        if (typeof cfg_wifi_adv_desk_language != 'undefined') {
            if (cfg_wifi_adv_desk_language[c.getAttribute("BindText")]) {
                c.innerHTML = cfg_wifi_adv_desk_language[c.getAttribute("BindText")];
            }
        }
    }
}

function stInitOption(value, innerText) {
    this.value = value;
    this.innerText = innerText;
}

function initDropDownList(id, ArrayOption) {
    $('#' + id).empty();

    var Control = getElById(id);
    var i = 0;

    for (i = 0; i < ArrayOption.length; i++) {
        var Option = document.createElement("Option");
        Option.value = ArrayOption[i].value;
        Option.innerText = ArrayOption[i].innerText;
        Option.text = ArrayOption[i].innerText;
        Control.appendChild(Option);
    }
}

function initRegulatoryDomainList(id) {
    var ArrayRegulatoryDomain = new Array(
        new stInitOption("AL", cfg_wlanzone_language['amp_wlanzone_AL']),
        new stInitOption("DZ", cfg_wlanzone_language['amp_wlanzone_DZ']),
        new stInitOption("AD", cfg_wlanzone_language['amp_wlanzone_AD']),
        new stInitOption("AO", cfg_wlanzone_language['amp_wlanzone_AO']),
        new stInitOption("AR", cfg_wlanzone_language['amp_wlanzone_AR']),
        new stInitOption("AU", cfg_wlanzone_language['amp_wlanzone_AU']),
        new stInitOption("AT", cfg_wlanzone_language['amp_wlanzone_AT']),
        new stInitOption("AZ", cfg_wlanzone_language['amp_wlanzone_AZ']),
        new stInitOption("BH", cfg_wlanzone_language['amp_wlanzone_BH']),
        new stInitOption("BY", cfg_wlanzone_language['amp_wlanzone_BY']),
        new stInitOption("BE", cfg_wlanzone_language['amp_wlanzone_BE']),
        new stInitOption("BA", cfg_wlanzone_language['amp_wlanzone_BA']),
        new stInitOption("BR", cfg_wlanzone_language['amp_wlanzone_BR']),
        new stInitOption("BN", cfg_wlanzone_language['amp_wlanzone_BN']),
        new stInitOption("BG", cfg_wlanzone_language['amp_wlanzone_BG']),
        new stInitOption("BF", cfg_wlanzone_language['amp_wlanzone_BF']),
        new stInitOption("CA", cfg_wlanzone_language['amp_wlanzone_CA']),
        new stInitOption("CL", cfg_wlanzone_language['amp_wlanzone_CL']),
        new stInitOption("CN", cfg_wlanzone_language['amp_wlanzone_CN']),
        new stInitOption("CO", cfg_wlanzone_language['amp_wlanzone_CO']),
        new stInitOption("CR", cfg_wlanzone_language['amp_wlanzone_CR']),
        new stInitOption("CI", cfg_wlanzone_language['amp_wlanzone_CI']),
        new stInitOption("HR", cfg_wlanzone_language['amp_wlanzone_HR']),
        new stInitOption("CY", cfg_wlanzone_language['amp_wlanzone_CY']),
        new stInitOption("CZ", cfg_wlanzone_language['amp_wlanzone_CZ']),
        new stInitOption("DK", cfg_wlanzone_language['amp_wlanzone_DK']),
        new stInitOption("DO", cfg_wlanzone_language['amp_wlanzone_DO']),
        new stInitOption("EC", cfg_wlanzone_language['amp_wlanzone_EC']),
        new stInitOption("EG", cfg_wlanzone_language['amp_wlanzone_EG']),
        new stInitOption("SV", cfg_wlanzone_language['amp_wlanzone_SV']),
        new stInitOption("EE", cfg_wlanzone_language['amp_wlanzone_EE']),
        new stInitOption("FK", cfg_wlanzone_language['amp_wlanzone_FK']),
        new stInitOption("FI", cfg_wlanzone_language['amp_wlanzone_FI']),
        new stInitOption("FR", cfg_wlanzone_language['amp_wlanzone_FR']),
        new stInitOption("GE", cfg_wlanzone_language['amp_wlanzone_GE']),
        new stInitOption("DE", cfg_wlanzone_language['amp_wlanzone_DE']),
        new stInitOption("GH", cfg_wlanzone_language['amp_wlanzone_GH']),
        new stInitOption("GR", cfg_wlanzone_language['amp_wlanzone_GR']),
        new stInitOption("GT", cfg_wlanzone_language['amp_wlanzone_GT']),
        new stInitOption("HN", cfg_wlanzone_language['amp_wlanzone_HN']),
        new stInitOption("HK", cfg_wlanzone_language['amp_wlanzone_HK']),
        new stInitOption("HU", cfg_wlanzone_language['amp_wlanzone_HU']),
        new stInitOption("IS", cfg_wlanzone_language['amp_wlanzone_IS']),
        new stInitOption("IN", cfg_wlanzone_language['amp_wlanzone_IN']),
        new stInitOption("ID", cfg_wlanzone_language['amp_wlanzone_ID']),
        new stInitOption("IR", cfg_wlanzone_language['amp_wlanzone_IR']),
        new stInitOption("IE", cfg_wlanzone_language['amp_wlanzone_IE']),
        new stInitOption("IL", cfg_wlanzone_language['amp_wlanzone_IL']),
        new stInitOption("IT", cfg_wlanzone_language['amp_wlanzone_IT']),
        new stInitOption("JM", cfg_wlanzone_language['amp_wlanzone_JM']),
        new stInitOption("JP", cfg_wlanzone_language['amp_wlanzone_JP']),
        new stInitOption("JO", cfg_wlanzone_language['amp_wlanzone_JO']),
        new stInitOption("KZ", cfg_wlanzone_language['amp_wlanzone_KZ']),
        new stInitOption("KE", cfg_wlanzone_language['amp_wlanzone_KE']),
        new stInitOption("KP", cfg_wlanzone_language['amp_wlanzone_KP']),
        new stInitOption("KR", cfg_wlanzone_language['amp_wlanzone_KR']),
        new stInitOption("KW", cfg_wlanzone_language['amp_wlanzone_KW']),
        new stInitOption("LA", cfg_wlanzone_language['amp_wlanzone_LA']),
        new stInitOption("LV", cfg_wlanzone_language['amp_wlanzone_LV']),
        new stInitOption("LB", cfg_wlanzone_language['amp_wlanzone_LB']),
        new stInitOption("LR", cfg_wlanzone_language['amp_wlanzone_LR']),
        new stInitOption("LI", cfg_wlanzone_language['amp_wlanzone_LI']),
        new stInitOption("LT", cfg_wlanzone_language['amp_wlanzone_LT']),
        new stInitOption("LU", cfg_wlanzone_language['amp_wlanzone_LU']),
        new stInitOption("MO", cfg_wlanzone_language['amp_wlanzone_MO']),
        new stInitOption("MU", cfg_wlanzone_language['amp_wlanzone_MU']),
        new stInitOption("MK", cfg_wlanzone_language['amp_wlanzone_MK']),
        new stInitOption("MY", cfg_wlanzone_language['amp_wlanzone_MY']),
        new stInitOption("MT", cfg_wlanzone_language['amp_wlanzone_MT']),
        new stInitOption("MX", cfg_wlanzone_language['amp_wlanzone_MX']),
        new stInitOption("MC", cfg_wlanzone_language['amp_wlanzone_MC']),
        new stInitOption("MA", cfg_wlanzone_language['amp_wlanzone_MA']),
        new stInitOption("MD", cfg_wlanzone_language['amp_wlanzone_MD']),
        new stInitOption("NP", cfg_wlanzone_language['amp_wlanzone_NP']),
        new stInitOption("NL", cfg_wlanzone_language['amp_wlanzone_NL']),
        new stInitOption("AN", cfg_wlanzone_language['amp_wlanzone_AN']),
        new stInitOption("NZ", cfg_wlanzone_language['amp_wlanzone_NZ']),
        new stInitOption("NI", cfg_wlanzone_language['amp_wlanzone_NI']),
        new stInitOption("NO", cfg_wlanzone_language['amp_wlanzone_NO']),
        new stInitOption("NG", cfg_wlanzone_language['amp_wlanzone_NG']),
        new stInitOption("OM", cfg_wlanzone_language['amp_wlanzone_OM']),
        new stInitOption("PK", cfg_wlanzone_language['amp_wlanzone_PK']),
        new stInitOption("PA", cfg_wlanzone_language['amp_wlanzone_PA']),
        new stInitOption("PG", cfg_wlanzone_language['amp_wlanzone_PG']),
        new stInitOption("PY", cfg_wlanzone_language['amp_wlanzone_PY']),
        new stInitOption("PE", cfg_wlanzone_language['amp_wlanzone_PE']),
        new stInitOption("PH", cfg_wlanzone_language['amp_wlanzone_PH']),
        new stInitOption("PL", cfg_wlanzone_language['amp_wlanzone_PL']),
        new stInitOption("PT", cfg_wlanzone_language['amp_wlanzone_PT']),
        new stInitOption("PR", cfg_wlanzone_language['amp_wlanzone_PR']),
        new stInitOption("QA", cfg_wlanzone_language['amp_wlanzone_QA']),
        new stInitOption("RO", cfg_wlanzone_language['amp_wlanzone_RO']),
        new stInitOption("RU", cfg_wlanzone_language['amp_wlanzone_RU']),
        new stInitOption("SA", cfg_wlanzone_language['amp_wlanzone_SA']),
        new stInitOption("RS", cfg_wlanzone_language['amp_wlanzone_RS']),
        new stInitOption("SG", cfg_wlanzone_language['amp_wlanzone_SG']),
        new stInitOption("SK", cfg_wlanzone_language['amp_wlanzone_SK']),
        new stInitOption("SI", cfg_wlanzone_language['amp_wlanzone_SI']),
        new stInitOption("SR", cfg_wlanzone_language['amp_wlanzone_SR']),
        new stInitOption("ZA", cfg_wlanzone_language['amp_wlanzone_ZA']),
        new stInitOption("ES", cfg_wlanzone_language['amp_wlanzone_ES']),
        new stInitOption("LK", cfg_wlanzone_language['amp_wlanzone_LK']),
        new stInitOption("SE", cfg_wlanzone_language['amp_wlanzone_SE']),
        new stInitOption("CH", cfg_wlanzone_language['amp_wlanzone_CH']),
        new stInitOption("SY", cfg_wlanzone_language['amp_wlanzone_SY']),
        new stInitOption("TW", cfg_wlanzone_language['amp_wlanzone_TW']),
        new stInitOption("TH", cfg_wlanzone_language['amp_wlanzone_TH']),
        new stInitOption("TT", cfg_wlanzone_language['amp_wlanzone_TT']),
        new stInitOption("TN", cfg_wlanzone_language['amp_wlanzone_TN']),
        new stInitOption("TR", cfg_wlanzone_language['amp_wlanzone_TR']),
        new stInitOption("UA", cfg_wlanzone_language['amp_wlanzone_UA']),
        new stInitOption("AE", cfg_wlanzone_language['amp_wlanzone_AE']),
        new stInitOption("GB", cfg_wlanzone_language['amp_wlanzone_GB']),
        new stInitOption("US", cfg_wlanzone_language['amp_wlanzone_US']),
        new stInitOption("UY", cfg_wlanzone_language['amp_wlanzone_UY']),
        new stInitOption("VE", cfg_wlanzone_language['amp_wlanzone_VE']),
        new stInitOption("VN", cfg_wlanzone_language['amp_wlanzone_VN']),
        new stInitOption("ZW", cfg_wlanzone_language['amp_wlanzone_ZW'])
        );
    ArrayRegulatoryDomain.splice(3, 0, new stInitOption("AM", cfg_wlanzone_language['amp_wlanzone_AM']));
    ArrayRegulatoryDomain.splice(10, 0, new stInitOption("BZ", cfg_wlanzone_language['amp_wlanzone_BZ']));
    ArrayRegulatoryDomain.splice(44, 0, new stInitOption("IQ", cfg_wlanzone_language['amp_wlanzone_IQ']));
    ArrayRegulatoryDomain.splice(108, 0, new stInitOption("UZ", cfg_wlanzone_language['amp_wlanzone_UZ']));
    ArrayRegulatoryDomain.splice(111, 0, new stInitOption("YE", cfg_wlanzone_language['amp_wlanzone_YE']));
    if (DoubleFreqFlag == 1) {
        ArrayRegulatoryDomain.splice(13, 0, new stInitOption("BO", cfg_wlanzone_language['amp_wlanzone_BO']));
     } else {
        ArrayRegulatoryDomain.splice(11, 0, new stInitOption("BO", cfg_wlanzone_language['amp_wlanzone_BO']));
    }

    if (IsCaribbeanReg()) {
        var insertpos = 0;

        for (var i = 0; i < ArrayRegulatoryDomain.length; i++) {
            if (ArrayRegulatoryDomain[i].value == "CA") {
                insertpos = i + 1;
                break;
            }
        }

        if (insertpos == 0) {
            insertpos = ArrayRegulatoryDomain.length;
        }

        ArrayRegulatoryDomain.splice(insertpos, 0, new stInitOption("CB", cfg_wlanzone_language['amp_wlanzone_CB']));
    }

    initDropDownList(id, ArrayRegulatoryDomain);
}

function initChannelList(id, wlanpage) {
    if ((DoubleFreqFlag == 1) && (wlanpage == "5G")) {
        var wlanBasicFor5G = (id == "Channel5g") ? wlanBasic5g : WlanBasic;
        if ((wlan11acFlag == 1) && (wlanBasicFor5G.X_HW_HT20 == 5) && (capHT80_80 == 1) && ((wlanBasicFor5G.X_HW_Standard == "11ac") || (wlanBasicFor5G.X_HW_Standard == "11aconly")|| (WlanBasic.X_HW_Standard == "11nac"))) {
            var all80_80Channel = '36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128';
            var all80_80ChannelList = all80_80Channel.split(',');
            var HT80and80ChannelList = [];
            for (var i = 0; i < all80_80ChannelList.length; i++) {
                for (var j = 0; j < all80_80ChannelList.length; j++) {
                    if ((all80_80ChannelList[i] != all80_80ChannelList[j]) && ((all80_80ChannelList[i] - all80_80ChannelList[j]) > 16 || (all80_80ChannelList[j] - all80_80ChannelList[i]) > 16)) {
                        HT80and80ChannelList.push(all80_80ChannelList[i] + "+" + all80_80ChannelList[j]);
                    }
                }
            }
            
            var ArrayChannel = new Array(new stInitOption("0",cfg_wlancfgadvance_language['amp_chllist_auto']));
            for(var i = 0; i < HT80and80ChannelList.length; i++) {
                ArrayChannel.push(new stInitOption(HT80and80ChannelList[i],HT80and80ChannelList[i]));
            }
        } else {
            var ArrayChannel = new Array(new stInitOption("0",cfg_wlancfgadvance_language['amp_chllist_auto']),
                                         new stInitOption("36",36), new stInitOption("40",40), new stInitOption("44",44), new stInitOption("48",48), 
                                         new stInitOption("52",52), new stInitOption("56",56), new stInitOption("60",60), new stInitOption("64",64), 
                                         new stInitOption("100",100), new stInitOption("104",104), new stInitOption("108",108), new stInitOption("112",112), 
                                         new stInitOption("116",116), new stInitOption("120",120), new stInitOption("124",124), new stInitOption("128",128), 
                                         new stInitOption("132",132), new stInitOption("136",136), new stInitOption("140",140), new stInitOption("144",144), 
                                         new stInitOption("149",149), new stInitOption("153",153), new stInitOption("157",157), new stInitOption("161",161), 
                                         new stInitOption("165",165));
        }
    } else {
        var ArrayChannel = new Array(new stInitOption("0",cfg_wlancfgadvance_language['amp_chllist_auto']),
                                     new stInitOption("1",1), new stInitOption("2",2), new stInitOption("3",3), new stInitOption("4",4), 
                                     new stInitOption("5",5), new stInitOption("6",6), new stInitOption("7",7), new stInitOption("8",8), 
                                     new stInitOption("9",9), new stInitOption("10",10), new stInitOption("11",11), new stInitOption("12",12), 
                                     new stInitOption("13",13), new stInitOption("14",14));
    }

    initDropDownList(id, ArrayChannel);
}

function initChannelWidthList(id) {
    var country = (id == 'wlanadvForm') ? getSelectVal('RegulatoryDomain') : getSelectVal('RegulatoryDomain5g');
    if (country != "EG") {
        if ((cfgMode.toUpperCase() == 'CNT2') || (cfgMode.toUpperCase() == 'CNT')) {
            var ArrayChannelWidth = new Array(new stInitOption("0",cfg_wlancfgadvance_language['amp_chlwidth_auto2040']), 
                                              new stInitOption("1",cfg_wlancfgadvance_language['amp_chlwidth_20']), 
                                              new stInitOption("2",cfg_wlancfgadvance_language['amp_chlwidth_40']),
                                              new stInitOption("3",cfg_wlancfgadvance_language[chlwidth80Res]),
                                              new stInitOption("4",cfg_wlancfgadvance_language['amp_chlwidth_160']),
                                              new stInitOption("5",cfg_wlancfgadvance_language['amp_chlwidth_80and80']),
                                              new stInitOption("6",cfg_wlancfgadvance_language['amp_chlwidth_80']),
                                              new stInitOption("7",cfg_wlancfgadvance_language['amp_chlwidth_4080']));
        } else {
            var ArrayChannelWidth = new Array(new stInitOption("0",cfg_wlancfgadvance_language['amp_chlwidth_auto2040']), 
                                              new stInitOption("1",cfg_wlancfgadvance_language['amp_chlwidth_20']), 
                                              new stInitOption("2",cfg_wlancfgadvance_language['amp_chlwidth_40']),
                                              new stInitOption("3",cfg_wlancfgadvance_language[chlwidth80Res]),
                                              new stInitOption("4",cfg_wlancfgadvance_language['amp_chlwidth_160']),
                                              new stInitOption("5",cfg_wlancfgadvance_language['amp_chlwidth_80and80']),
                                              new stInitOption("6",cfg_wlancfgadvance_language['amp_chlwidth_80']),
                                              new stInitOption("7",cfg_wlancfgadvance_language['amp_chlwidth_customized']));
        }
    } else {
        var ArrayChannelWidth = new Array(new stInitOption("0",cfg_wlancfgadvance_language['amp_chlwidth_auto2040']), 
                                          new stInitOption("1",cfg_wlancfgadvance_language['amp_chlwidth_20']), 
                                          new stInitOption("2",cfg_wlancfgadvance_language['amp_chlwidth_40']));
    }
    initDropDownList(id, ArrayChannelWidth);
}

function initHwStandardList(id) {
     var ArrayHwStandard = new Array(new stInitOption("11a","802.11a"), new stInitOption("11na","802.11a/n"), new stInitOption("11ac","802.11a/n/ac"), new stInitOption("11nac","802.11n/ac"),
                                     new stInitOption("11aconly","802.11ac"), new stInitOption("11b","802.11b"), new stInitOption("11g","802.11g"), 
                                     new stInitOption("11n","802.11n"), new stInitOption("11bg","802.11b/g"), new stInitOption("11gn", "802.11g/n"), 
                                     new stInitOption("11bgn","802.11b/g/n"),new stInitOption("11ax","802.11b/g/n/ax"),new stInitOption("11ax","802.11a/n/ac/ax"));

    initDropDownList(id, ArrayHwStandard);
    setSelect(id, '11bgn');
}

function initWlanBasicDropDownListCommon(RegulatoryDomain, X_HW_Standard, Channel, X_HW_HT20, wlanpage) {
    initRegulatoryDomainList(RegulatoryDomain);
    initHwStandardList(X_HW_Standard);
    initChannelList(Channel, wlanpage);
    initChannelWidthList(X_HW_HT20);
}

function checkDfsChannelWarnCommon(curX_HW_Standard, curX_HW_HT20, SelChannel, wlanpage, CountryCode, wlanBasicFor5G) {
    var curChannelArr;
    var curChannel;
    var curChannelPlus;
    var ChannelGroup;

    if ((SelChannel == 0) || (SelChannel == -1)) {
        return true;
    }

    if (dfsSilentEnable === '0') {
        return true;
    }

    if ((dfsChSwitch == 1) && (wlanpage == '5G')) {
        if (curX_HW_HT20 == 5) {
            curChannelArr = SelChannel.split('+');
            curChannel = curChannelArr[0];
            curChannelPlus = curChannelArr[1];
        } else {
            curChannel = SelChannel;
            curChannelPlus = wlanBasicFor5G.ChannelPlus;
        }

        if ((curX_HW_Standard != wlanBasicFor5G.X_HW_Standard) || 
            (curX_HW_HT20 != wlanBasicFor5G.X_HW_HT20) || 
            (curChannel != wlanBasicFor5G.Channel) || 
            (curChannelPlus != wlanBasicFor5G.ChannelPlus) || 
            (CountryCode != wlanBasicFor5G.RegulatoryDomain)) {
            if (PTVDFFlag == 1) {
                ChannelGroup = CheckChannelGroup(curX_HW_HT20, curChannel, curChannelPlus);
            } else {
                ChannelGroup = getDfsKeepTime(curChannel, curChannelPlus, CountryCode, curX_HW_HT20);
            }

            if (ChannelGroup == weatherRadorGroup) {
                if (ConfirmEx(cfg_wlancfgadvance_language['amp_advance_dfs_weather_warn']) == false) {
                    return false;
                }
            } else if ((cfgMode.toUpperCase() !== 'TELECOM2') && (ChannelGroup == dfsRadorGroup)) {
                if (ConfirmEx(cfg_wlancfgadvance_language['amp_advance_dfs_general_warn']) == false) {
                    return false;
                }
            }
        }
    }

    return true;
}

function CheckConfigChannel(selChannel, curChannel) {
    if ((selChannel == 0) || (selChannel == -1)) {
        return false;
    }

    return (selChannel != curChannel);
}
