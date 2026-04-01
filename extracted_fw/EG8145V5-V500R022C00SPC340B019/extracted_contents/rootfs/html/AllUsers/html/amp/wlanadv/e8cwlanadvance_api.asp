var wlan11acFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_11AC);%>';
var wdsFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WDS);%>';
var wifiPowerFixFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WIFI_POWER_FIX);%>';
var currentBin = '<%HW_WEB_GetBinMode();%>';
var enbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';
var guardInterval = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.Radio.1.GuardInterval);%>';
var wallMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_WallModeForChina.Enable);%>';
var wdsMasterMac = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_WlanMac);%>';
var wlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|PossibleChannels|SSIDAdvertisementEnabled|X_HW_ServiceEnable|WMMEnable|BeaconType|BasicEncryptionModes|WPAEncryptionModes|IEEE11iEncryptionModes|X_HW_WPAand11iEncryptionModes, StWlanWifi);%>;
var cfgMode = '<%HW_WEB_GetCfgMode();%>';
var tianyiFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CTRG);%>';
var wlanTransmitPower = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, TransmitPower, StWlanTransmit, EXTEND);%>;
var isCheckDfsSignal = '<%HW_WEB_GetDfsSignal();%>';

var wlanPage;
var possibleChannels = "";
var wlanArrLen = wlanWifiArr.length - 1;
var wlanWifi = wlanWifiArr[0];
var uiTotal2gNum = 0;
var uiTotal5gNum = 0;
var uiTotalNum = 0;
var is11AX = 0;

function IsSCCT() {
    return ((cfgMode.toUpperCase() == "SCCT") || (cfgMode.toUpperCase() == "SCSCHOOL"));
}

var chlwidth160Res = IsSCCT() ? "160 MHz" : cfg_wlancfgadvance_language['amp_chlwidth_160'];

if (location.href.indexOf("e8cWlanAdvance.asp?") > 0) {
    wlanPage = location.href.split("?")[1]; 
    top.WlanAdvancePage = wlanPage;
}

wlanPage = top.WlanAdvancePage;

if (wlanWifi == null) {
    wlanWifi = new StWlanWifi("", "", "", "", "11n", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
}

if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
    wlanWifiInitFor5G();
    guardInterval = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.Radio.2.GuardInterval);%>';
    wdsMasterMac = '<%HW_WEB_GetWlanMac_5G();%>';
} else {
    setWlanWifiDefaultFor2G();
}

if ((wlanWifi.mode == "11ax") || (wlanWifi.mode == "n,ax") || (wlanWifi.mode == "b,g,n,ax") || (wlanWifi.mode == "ac,ax") || (wlanWifi.mode == "n,ac,ax")) {
    is11AX = 1;
}

function StWlanTransmit(domain, power) {
    this.domain = domain;
    this.power = power;
}

function StWlanWifi(domain, name, enable, ssid, mode, channel, power, Country, AutoChannelEnable, channelWidth, PossibleChannels, Advertisement, X_HW_ServiceEnable, wmmEnable, BeaconType, BasicEncryptionModes, WPAEncryptionModes, IEEE11iEncryptionModes, X_HW_WPAand11iEncryptionModes) {
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
    this.Advertisement = Advertisement;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.wmmEnable = wmmEnable;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
}

function StWdsClientAp(domain, BSSID) {
    this.domain = domain;
    this.BSSID = BSSID;
}

function IsTransmitPowerBand(wlanWifi) {
    for (var i = 0; i < wlanTransmitPower.length -1; i++) {
        if (wlanWifi.domain == wlanTransmitPower[i].domain) {
            if (wlanTransmitPower[i].power == 200) {
                return true;
            }
        }
    }
    return false;
}

function wlanWifiInitFor5G() {
    if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
        for (var i = 0; i < wlanArrLen; i++) {
            if (ssidStart5G == getWlanPortNumber(wlanWifiArr[i].name)) {
                wlanWifi = wlanWifiArr[i];
                if (IsTransmitPowerBand(wlanWifi)) {
                    wlanWifi.power = 200;
                }
                return;
            }
        }
    }
}

function setWlanWifiDefaultFor2G() {
    if (wlanPage == "5G") {
        return;
    }

    for (var i = 0; i < wlanArrLen; i++) {
        if (ssidStart2G == getWlanPortNumber(wlanWifiArr[i].name)) {
            wlanWifi = wlanWifiArr[i];
            if (IsTransmitPowerBand(wlanWifi)) {
                wlanWifi.power = 200;
            }
            return;
        }
    }
}

function total2gNum() {
    uiTotal2gNum = 0;
    uiTotal5gNum = 0;
    uiTotalNum = wlanArrLen;

    for (var loop = 0; loop < wlanArrLen; loop++) {
        if (wlanWifiArr[loop].name == '') {
            continue;
        }
        
        if (getWlanPortNumber(wlanWifiArr[loop].name) > ssidEnd2G) {
            uiTotal5gNum++;
        } else {
            uiTotal2gNum++;
        }
    }
}

function getPossibleChannels(freq, country, mode, width) {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../common/WlanChannel.asp?&1=1",
        data : "freq=" + freq + "&country=" + country + "&standard=" + mode + "&width=" + width,
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

function IsShowStandard() {
    if (((currentBin.toUpperCase() == 'A8C') && (cfgMode.toUpperCase() == "GXCT")) || ((cfgMode.toUpperCase() == 'TJCMCC_RMS') && (cap11ax == 1))) {
        return true;
    }

    return false;
}

function loadChannelListByFreq(freq, country, mode, width) {
    var webChannel = getSelectVal('WlanChannel_select');
    var webChannelValid = 0;

    getPossibleChannels(freq, country, mode, width);
    var showChannels = possibleChannels.split(',');

    $("#WlanChannel_select").empty();

    document.forms[0].WlanChannel_select[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");
    
    for (var j = 1; j <= showChannels.length; j++) {
        if (showChannels[j-1] == webChannel) {
            webChannelValid = 1;
        }

        document.forms[0].WlanChannel_select[j] = new Option(showChannels[j-1], showChannels[j-1]);
    }

    if (webChannelValid == 1) {
        setSelect('WlanChannel_select', webChannel);
    } else {
        setSelect('WlanChannel_select', 0);
    }
}

function loadChannelList(country, mode, width) {
    var freq = '2G';
    if (wlanPage == "5G") {
        freq = '5G';
    }

    loadChannelListByFreq(freq, country, mode, width);
}

function InitX_HW_Standard() {
    var wlgmode = getSelectVal('X_HW_Standard'); 
    var isshow11n = 0;
    var isshow11aconly = 0;
    var isshow11ac = 0;
    var isshow11a = 0;
    var isshow11ax = cap11ax;
    var is11AXForFreq = (wlanPage == "2G") ? "802.11b/g/n/ax" : "802.11a/n/ac/ax";

    for (var i = 0; i < wlanArrLen; i++) {
        var name = wlanWifiArr[i].name;
        var portIndex = parseInt(name.charAt(length-1));
        if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
            if ((portIndex < ssidStart5G) || (portIndex > ssidEnd5G)) {
                continue;
            }
        } else {
             if (portIndex > ssidEnd2G) {
                continue;
            }
        }

        var BeaconType = wlanWifiArr[i].BeaconType;
        var BasicEncryptionModes =  wlanWifiArr[i].BasicEncryptionModes;
        var WPAEncryptionModes  = wlanWifiArr[i].WPAEncryptionModes;
        var IEEE11iEncryptionModes = wlanWifiArr[i].IEEE11iEncryptionModes;
        var X_HW_WPAand11iEncryptionModes = wlanWifiArr[i].X_HW_WPAand11iEncryptionModes;

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

        if (wlanWifiArr[i].wmmEnable == 0) {
            isshow11n += 1;
        }
    }

    isshow11n += (1 - cap11n);
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
                        '11ax' : [is11AXForFreq, 0]
                      };

    standardArr['11n'][1] = (isshow11n == 0);
    standardArr['11ax'][1] = (isshow11ax);

    if (wlanPage == "5G") {
        standardArr['11a'][1] = (isshow11a == 0);
        standardArr['11na'][1] = 1;
        standardArr['11ac'][1] = ((wlan11acFlag == 1) && (isshow11ac == 0));
    } else {
        standardArr['11b'][1] = 1;
        standardArr['11g'][1] = 1;
        standardArr['11bg'][1] = 1;
        standardArr['11bgn'][1] = 1;

        if (wlgmode == "11n" && (standardArr['11n'][1] == 0)) {
            wlgmode = "11bgn";
        }
    }

    if ((cfgMode.toUpperCase() == 'TJCMCC_RMS') && (cap11ax == 1)) {
        if (wlanPage == "5G") {
            standardArr = {
                '11ac' : ["a/n/ac", 1],
                '11ax' : ["a/n/ac/ax", 1]
            }
        } else {
            standardArr = {
                '11bgn' : ["b/g/n", 1],
                '11ax' : ["b/g/n/ax", 1]
            }
        }
    }

    InitDropDownListWithSelected('X_HW_Standard', standardArr, wlgmode);

    if (getSelectVal('X_HW_Standard') != wlgmode) {
        setSelect('X_HW_Standard', "11bgn");
    }
}

function X_HW_StandardChange() {
    var mode = getSelectVal('X_HW_Standard');
    var channelWidthRestore = getSelectVal('WlanBandWidth_select');
    var channel = getSelectVal('WlanChannel_select');
    
    if ((channel == 14) && (mode != "11b")) {
        setSelect('WlanChannel_select', 0);
    }

    $("#WlanBandWidth_select").empty();

    if ((mode == "11b") || (mode == "11g") || (mode == "11bg") || (mode == "11a")) {    
        document.forms[0].WlanBandWidth_select[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
    } else {
        document.forms[0].WlanBandWidth_select[0] = new Option("20MHz/40MHz", "0");
        document.forms[0].WlanBandWidth_select[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        document.forms[0].WlanBandWidth_select[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");

        if ((wlan11acFlag == 1) && (DoubleFreqFlag == 1) && (wlanPage == "5G") && (mode == "11ac")) {
            INIT_E8cWidth80M();
            if (capHT160 == 1) {
                document.forms[0].WlanBandWidth_select[4] = new Option(chlwidth160Res, "4");
            }
        }

        if ((DoubleFreqFlag == 1) && (wlanPage == "5G") && (is11AX == 1)) {
            INIT_E8cWidth80M();
            document.forms[0].WlanBandWidth_select[4] = new Option(chlwidth160Res, "4");
        }

        if ((channelWidthRestore != 3) || (mode == "11ac") || (mode == "11aconly") || (mode == "11ax")) {
            setSelect('WlanBandWidth_select', channelWidthRestore);
        } else {
            setSelect('WlanBandWidth_select', 0);
        }
    }

    loadChannelList(wlanWifi.RegulatoryDomain, mode, getSelectVal('WlanBandWidth_select'));
}
function channelWidthChange() {
    var mode = (IsShowStandard()) ? getValue('X_HW_Standard') : wlanWifi.mode;
    loadChannelList(wlanWifi.RegulatoryDomain, mode, getSelectVal('WlanBandWidth_select'));
}

function InitGuardInterval() {
    $('#WlanInterval_select').empty();
    if (is11AX == 1) {
        document.forms[0].WlanInterval_select[0] = new Option("800nsec", "800nsec");
        document.forms[0].WlanInterval_select[1] = new Option("1600nsec", "1600nsec");
        document.forms[0].WlanInterval_select[2] = new Option("3200nsec", "3200nsec");
    } else {
        document.forms[0].WlanInterval_select[0] = new Option("短", "400nsec");
        document.forms[0].WlanInterval_select[1] = new Option("长", "800nsec");
    }

    if (guardInterval == 'Auto') {
        setSelect("WlanInterval_select", '400nsec');
    } else {
        setSelect("WlanInterval_select", guardInterval);
    }
}

function setDefaultWlanValue() {
    loadChannelList(wlanWifi.RegulatoryDomain,wlanWifi.mode, wlanWifi.channelWidth);
    if (IsShowStandard()) {
        setSelect('X_HW_Standard', wlanWifi.mode);
        initX_HW_HT20();
    }
    setSelect('WlanTransmit_select', wlanWifi.power);
    if (wlanWifi.AutoChannelEnable == 1) {
        setSelect('WlanChannel_select', 0);
    } else {
        setSelect('WlanChannel_select', wlanWifi.channel);
    }

    setSelect('WlanBandWidth_select', wlanWifi.channelWidth);
    if ((wlanWifi.channelWidth == 4) && (isCheckDfsSignal == 1)) {
        setDisplay('Title_wlan_dfs_tips_lable', 1);
    }

    if (wlanWifi.Advertisement == 1) {
        setCheck('WlanHide_checkbox', 0);
    } else {
        setCheck('WlanHide_checkbox', 1);
    }

    InitGuardInterval();
    loadWdsConfig();
}

function wifiAdvanceShow(enable) {
    if (enable == 1) {
        setDisplay('wifiCfg', 1);
        if ((wlanWifi.mode == "11b") || (wlanWifi.mode == "11g") || (wlanWifi.mode == "11bg") || (wlanWifi.mode == "11a")) {
            $("#WlanBandWidth_select").empty();
            document.forms[0].WlanBandWidth_select[0] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
        }

        setDefaultWlanValue();
    } else {
        setDisplay('wifiCfg', 0);
    }
}

function wdsClickFunc() {
    if (getCheckVal('wds_enable') == 0) {
        setDisplay('div_wds_mac', 0);
    } else {
        setDisplay('div_wds_mac', 1);
    }
}

function loadWdsConfig() {
    if (wdsFlag == 1) {
        var wdsEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.Enable);%>';
        var wdsClientApMacAddr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.{i}, BSSID, StWdsClientAp);%>;

        if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
            wdsClientApMacAddr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.ClientAP.{i}, BSSID, StWdsClientAp);%>;
            wdsEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.Enable);%>';
        }

        setCheck('wds_enable', wdsEnable);
        document.getElementById("X_HW_WlanMac").innerHTML = wdsMasterMac;
        setText('wds_text_ap1', wdsClientApMacAddr[0].BSSID);
        setText('wds_text_ap2', wdsClientApMacAddr[1].BSSID);
        setText('wds_text_ap3', wdsClientApMacAddr[2].BSSID);
        setText('wds_text_ap4', wdsClientApMacAddr[3].BSSID);

        setDisplay('div_wds_config', 1);
        
        if (wdsEnable == 0) {
            setDisplay('div_wds_mac', 0);
        }
    } else {
        setDisplay('div_wds_config', 0);
    }
}

function setE8CWlanAdvanceTitle() {
    var thisTitle = "说明：无线连接的高级功能设置，可设置开放的信道，发射功率等一些高级参数(在无线网络功能关闭时，此页面内容可能为空)。";
    if ((DoubleFreqFlag == 1) && (wlanPage == "2G")) {
        thisTitle = cfg_wlancfgother_language['amp_wlanadvance_title_2G'];
    } else if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
        thisTitle = cfg_wlancfgother_language['amp_wlanadvance_title_5G'];
    }

    getElementById("e8CWlanAdvanceTitle").innerHTML = thisTitle;
}

function INIT_E8cWidth80M() {
    if (((currentBin.toUpperCase() == 'E8C') || (currentBin.toUpperCase() == 'A8C')) && (cfgMode.toUpperCase() != 'JSCT')) {
        document.forms[0].WlanBandWidth_select[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_80'], "3");
    } else {
        document.forms[0].WlanBandWidth_select[3] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_auto204080'], "3");
    }
}

function initX_HW_HT20() {
    var mode = wlanWifi.mode;
    document.forms[0].WlanBandWidth_select[0] = new Option("20MHz/40MHz", "0");
    document.forms[0].WlanBandWidth_select[1] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_20'], "1");
    document.forms[0].WlanBandWidth_select[2] = new Option(cfg_wlancfgadvance_language['amp_chlwidth_40'], "2");
    if ((wlan11acFlag == 1) && (DoubleFreqFlag == 1) && (wlanPage == "5G") && (mode == "11ac")) {
        INIT_E8cWidth80M();
        if (capHT160 == 1) {
            document.forms[0].WlanBandWidth_select[4] = new Option(chlwidth160Res, "4");
        }
    }

    if ((DoubleFreqFlag == 1) && (wlanPage == "5G") && (is11AX == 1)) {
        INIT_E8cWidth80M();
        document.forms[0].WlanBandWidth_select[4] = new Option(chlwidth160Res, "4");
    }
}

function wdsIsMacAddrRepeat() {
    var aucMac = new Array();
    var i = 0;
    var j = 0;

    aucMac[0] = getValue('wds_text_ap1');
    aucMac[1] = getValue('wds_text_ap2');
    aucMac[2] = getValue('wds_text_ap3');
    aucMac[3] = getValue('wds_text_ap4');

    for (var i = 0; i < 4; i++) {
        for (var j = i + 1; j < 4; j++) {
            if ((aucMac[i].length == 17) && (aucMac[j].length == 17)) {
                if (aucMac[i].toLowerCase() == aucMac[j].toLowerCase()) {
                    return true;
                }
            }
        }
    }

    return false;
}

function wdsIsMacAddrInvalid(mac) {
    if ((mac.length != 0) && (mac.length != 17)) {
        return true;
    }

    if (mac.length == 17) {
        for (var loop = 0; loop < 17; loop++) {
            if ((1 + loop) % 3 == 0) {
                if (mac.charAt(loop) != ':') {
                    return true;
                }
            } else {
                if (((mac.charAt(loop) >= '0') && (mac.charAt(loop) <= '9')) || ((mac.charAt(loop) >= 'a') && (mac.charAt(loop) <= 'f')) || ((mac.charAt(loop) >= 'A') && (mac.charAt(loop) <= 'F'))) {
                    continue;
                } else {
                    return true;
                }
            }
        }
    }

    return false;
}

function setBindText() {
    var all = document.getElementsByTagName("td");
    for (var i = 0; i < all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
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

function CheckForm(type) {
    if (checkProcessingState()) {
        AlertEx(cfg_wlancfgadvance_language['amp_config_busy']);
        return false;
    }
    if ((getSelectVal('WlanTransmit_select') == "") || (getSelectVal('WlanChannel_select') == "") ||
        (getSelectVal('WlanBandWidth_select') == "") || ((IsShowStandard()) && (getSelectVal('X_HW_Standard') == ""))){
        AlertEx(cfg_wlancfgother_language['amp_basic_empty']);
        return false;
    }

    if (wdsFlag == 1) {
        if (getCheckVal('wds_enable') == 1) {
            if (wdsIsMacAddrInvalid(getValue('wds_text_ap1')) || wdsIsMacAddrInvalid(getValue('wds_text_ap2')) ||
                wdsIsMacAddrInvalid(getValue('wds_text_ap3')) || wdsIsMacAddrInvalid(getValue('wds_text_ap4'))) {
                AlertEx(cfg_wlancfgadvance_language['amp_wds_address_invalid']);
                return false;
            }

            if (wdsIsMacAddrRepeat()) {
                AlertEx(cfg_wlancfgadvance_language['amp_wds_address_repeat']);
                return false;
            }
        }
    }

    return true;
}

function addWdsSubmitParam(Form) {
    var wdsCheckValue = getCheckVal('wds_enable');
    if (wdsCheckValue == 1) {
        Form.addParameter('m.Enable', wdsCheckValue);
        Form.addParameter('n.BSSID', getValue('wds_text_ap1'));
        Form.addParameter('o.BSSID', getValue('wds_text_ap2'));
        Form.addParameter('p.BSSID', getValue('wds_text_ap3'));
        Form.addParameter('q.BSSID', getValue('wds_text_ap4'));

        if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
            url += '&y=' + wlanWifi.domain +
                   '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS' +
                   '&n=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.ClientAP.1' +
                   '&o=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.ClientAP.2' +
                   '&p=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.ClientAP.3' +
                   '&q=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS.ClientAP.4';
        } else {
            url += '&y=' + wlanWifi.domain +
                   '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS' +
                   '&n=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.1' +
                   '&o=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.2' +
                   '&p=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.3' +
                   '&q=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS.ClientAP.4';
        }
    } else {
        Form.addParameter('m.Enable',wdsCheckValue);
        if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
            url += '&y=' + wlanWifi.domain +
                   '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.X_HW_WDS';
        } else {
            url += '&y=' + wlanWifi.domain +
                   '&m=' + 'InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.X_HW_WDS';
        }
    }
}

function AddSubmitParam(Form, type) {
    var selChannel = getSelectVal('WlanChannel_select');
    Form.addParameter('y.Channel', selChannel);
    if (selChannel == 0) {
        Form.addParameter('y.AutoChannelEnable', 1); 
    } else {
        Form.addParameter('y.AutoChannelEnable', 0);
    }

    Form.addParameter('y.X_HW_HT20', getSelectVal('WlanBandWidth_select')); 

    if (IsShowStandard()) {
        Form.addParameter('y.X_HW_Standard',getSelectVal('X_HW_Standard'));
    }

    var wallModeSel = getSelectVal('wallMode_select');
    if (wifiPowerFixFlag != "1") {
        if (tianyiFlag == 1) {
            Form.addParameter('y.TransmitPower', getSelectVal('WlanTransmit_select'));
        } else {
            if (wallModeSel == 1) {
                Form.addParameter('y.TransmitPower', 100);
            } else {
                Form.addParameter('y.TransmitPower', getSelectVal('WlanTransmit_select'));
            }

            Form.addParameter('r.Enable', wallModeSel);

            if (DoubleFreqFlag == 1) {
                if (wallModeSel == 1) {
                    Form.addParameter('s.TransmitPower', 100);
                } else if ((wallModeSel == 0) && (wallMode == 1)) {
                    Form.addParameter('s.TransmitPower', 100);
                }
            }
        }
    }

    var radioIndex = ((DoubleFreqFlag == 1) && (wlanPage == "5G")) ? 2 : 1;
    var wlan = getFirstSSIDInst(radioIndex, allWlanInfo);
    var wlanInst = wlan.InstId;
    WifiCoverParaDefault(wlan, wlanInst);

    if (getCheckVal('WlanHide_checkbox') == 1) {
        Form.addParameter('y.SSIDAdvertisementEnabled',0);
        setCoverSsidNotifyFlag(wlan.SSIDAdvertisementEnabled, 0, ENUM_SSIDAdvertisementEnabled);
    } else {
        Form.addParameter('y.SSIDAdvertisementEnabled',1);
        setCoverSsidNotifyFlag(wlan.SSIDAdvertisementEnabled, 1, ENUM_SSIDAdvertisementEnabled);
    }

    Form.addParameter('z.GuardInterval', getSelectVal('WlanInterval_select'));
    SubmitWIfiCoverSsid(Form, wlan, wlanInst);

    var url = 'set.cgi?';
    var configAction = 'InternetGatewayDevice.X_HW_DEBUG.WLANConfigAction';
    if (!CheckConfigChannel(selChannel, wlanWifi.channel)) {
        url += 'c1=' + configAction + '&';
        Form.addParameter('c1.ActionType', 0);
    }

    if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
        url += 'z=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2';
    } else {
        url += 'z=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
    }

    if ((wifiPowerFixFlag != "1") && (tianyiFlag != 1)) {
        url += '&r=InternetGatewayDevice.LANDevice.1.WiFi.X_HW_WallModeForChina';
    }

    if (wdsFlag == 1) {
        addWdsSubmitParam(Form);
    } else {
        if ((DoubleFreqFlag == 1) && (wlanPage == "5G")) {
            url += '&y=' + wlanWifi.domain;
        } else {
            url += '&y=' + wlanWifi.domain;
        }
    }

    if ((DoubleFreqFlag == 1) && (wifiPowerFixFlag != "1") && ((wallModeSel == 1) || (wallMode == 1)) && (tianyiFlag != 1)) {
        if (wlanPage == "5G") {
            url += '&s=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1';
        } else {
            url += '&s=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5';
        }
    }

    if (!CheckConfigChannel(selChannel, wlanWifi.channel)) {
        url += '&c2=' + configAction;
        Form.addParameter('c2.ActionType', 1);
        Form.addParameter('c2.SSIDList', '' + wlanInst);
    }
    url += '&RequestFile=html/amp/wlanadv/e8cWlanAdvance.asp';
    Form.setAction(url);

    setDisable('Save_button', 1);
    setDisable('Cancel_button', 1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
}

function cancelConfig() {
    setDefaultWlanValue();
    if (tianyiFlag != 1) {
        InitWallMode();
    }
}

function InitTransmitPower() {
    if (tianyiFlag != 1) {
        return;
    }

    document.getElementById("WlanTransmit_select").innerHTML = "";
    document.forms[0].WlanTransmit_select[0] = new Option("穿墙", "200");
    document.forms[0].WlanTransmit_select[1] = new Option("100%", "100");
    document.forms[0].WlanTransmit_select[2] = new Option("80%", "80");
    document.forms[0].WlanTransmit_select[3] = new Option("60%", "60");
    document.forms[0].WlanTransmit_select[4] = new Option("40%", "40");
    document.forms[0].WlanTransmit_select[5] = new Option("20%", "20");
}

function loadFrameWifi() {
    initWlanCap();
    total2gNum();
    setE8CWlanAdvanceTitle();
    initX_HW_HT20();
    InitTransmitPower();

    if (DoubleFreqFlag == 1) {
        if (enbl == 1) {
            if (wlanPage == '2G') {
                wifiAdvanceShow((enbl2G != "0") && (uiTotal2gNum > 0));
            }
            
            if (wlanPage == '5G') {
                wifiAdvanceShow((enbl5G != "0") && (uiTotal5gNum > 0));
            }
        } else {
            wifiAdvanceShow(enbl != "0");
        }
    } else {
        wifiAdvanceShow((enbl != "0") && (uiTotalNum > 0));
    }
    
    setBindText();

    if (wifiPowerFixFlag == "1") {
        setDisable('WlanTransmit_select', 1);
    }

    if (IsShowStandard()) {
        setDisplay('X_HW_StandardRow', 1);
        setSelect('X_HW_Standard', wlanWifi.mode);
        InitX_HW_Standard();
        X_HW_StandardChange();
    }

    setDisplay('AdvanceConfig', 1);

    InitWallMode();
}

function InitWallMode() {
    if ((wifiPowerFixFlag == "1") || (tianyiFlag == 1)) {
        return;
    }
    setSelect("wallMode_select", wallMode);
    if ((DoubleFreqFlag != 1) || (wlanPage == '5G')) {
        setDisplay("powerStrenthMode", 1);
    }
    setDisable("WlanTransmit_select", wallMode);
    if (wallMode == 1) {
        setSelect("WlanTransmit_select", 100);
    }
}

function WallModeChange() {
    var wallModeVal = getSelectVal('wallMode_select');
    setDisable("WlanTransmit_select", wallModeVal);
    if (wallModeVal == 1) {
        setSelect("WlanTransmit_select", 100);
    }
}

