var isSupportSFP = "<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SFP);%>";
var isSupportPCDN = '<%HW_WEB_GetFeatureSupport(FT_PCDN_SUPPORT);%>';
var isScCt = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>';
var isHONWanView = '<%HW_WEB_GetFeatureSupport(FT_CDN_VIEW_SUPPORT);%>';
var isSupportModifyCdn = '<%HW_WEB_GetFeatureSupport(FT_MODIFY_CDN);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';

function WlanISPSSID(domain, SSID, EnableUserId, UserId) {
  this.domain = domain;
  this.SSID = SSID;
  this.EnableUserId = EnableUserId;
  this.UserId = UserId;
}

function stWlanInfo(domain, name, X_HW_ServiceEnable, enable, bindenable) {
  this.domain = domain;
  this.name = name;
  this.X_HW_ServiceEnable = X_HW_ServiceEnable;
  this.enable = enable;
  this.bindenable = bindenable;
}

function PolicyRouteItem(_Domain, _Type, _VenderClassId, _WanName, _EtherType, _PhyPortName) {
  this.Domain = _Domain;
  this.Type = _Type;
  this.VenderClassId = _VenderClassId;
  this.WanName = _WanName;
  this.EtherType = _EtherType;
  this.PhyPortName = _PhyPortName;
}

function PolicyRouteLoader() {
    function PolicyRouteItem(_Domain, _Type, _VenderClassId, _WanName, _EtherType, _PhyPortName) {
        this.Domain = _Domain;
        this.Type = _Type;
        this.VenderClassId = _VenderClassId;
        this.WanName = _WanName;
        this.EtherType = _EtherType;
        this.PhyPortName = _PhyPortName;
    }
    this.PolicyRouteList = [];

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 5000,
        url : "/html/bbsp/common/get_wan_list_policyroute.asp",
        success : function(data) {
            this.PolicyRouteList = dealDataWithFun(data);
            this.Validate(this.PolicyRouteList);
        }
    });

    this.GetPolicyRouteList = function() {
        return this.PolicyRouteList;
    }

    this.LanWanBindList = [];
    this.AnyPortAnyServiceList = [];
    this.EthRouteList = [];
    this.PortVlanBindList = [];

    this.Validate = function(newRouteList) {
        for (var i=0,j=0,k=0,m=0,n=0; i < newRouteList.length - 1; i++) {
            if ((newRouteList[i].Type == "SourcePhyPort") || (newRouteList[i].Type == "SourcePhyPortV6")) {
                this.LanWanBindList[j++] = newRouteList[i];
            }

            if (newRouteList[i].Type == "SoureIP") {
                this.AnyPortAnyServiceList[k++] = newRouteList[i];
            }

            if (newRouteList[i].Type == "EtherType") {
                this.EthRouteList[m++] = newRouteList[i];
            }

            if (newRouteList[i].Type == "PortVlan") {
                this.PortVlanBindList[n++] = newRouteList[i];
            }
        }

        $(".subWanListPolicyRoute").trigger("evtWanListPolicyRoute");
    }

    this.GetLanWanBindList = function() {
        return this.LanWanBindList;
    }
    this.GetLanWanBindInfo = function(WanName) {
        var BindList = this.GetLanWanBindList();
        for (var i = 0; i < BindList.length; i++) {
            if (WanName == BindList[i].WanName) {
                return BindList[i];
            }
        }
    }

    this.GetAnyPortAnyServiceList = function() {
        return this.AnyPortAnyServiceList;
    }
    this.GetEthRouteList = function() {
        return this.EthRouteList;
    }
    this.GetPortVlanRouteList = function() {
        return this.PortVlanBindList;
    }
}

var Instance_PolicyRoute = new PolicyRouteLoader();

function IPVersionLoader(){
    this.IPProtVerMode = '';

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_ipversion.asp",
        success : function(data) {
            this.IPProtVerMode = data;
            this.Validate();
        }
    });

    this.GetIPProtVerMode = function() {
        return this.IPProtVerMode;
    }
    this.Validate = function() {
        $(".subWanListIPVersion").trigger("evtWanListIPVersion");
    }
}
var Instance_IPVersion = new IPVersionLoader();

function domainTowanname(domain) {
    if((null != domain) && (undefined != domain)) {
        var domaina = domain.split('.');
        var type = (-1 == domain.indexOf("WANIPConnection")) ? '.ppp' : '.ip' ;
        return 'wan' + domaina[2] + '.' + domaina[4] + type + domaina[6] ;
    }
}

function waninterface(tr098wanpath, tr181interface) {
    this.tr098wanpath = tr098wanpath;
    this.tr181interface = tr181interface;
}

function domainTowanname_if(domain) {
    var i;
    var waninterfaces = <%HW_WEB_GetTR181WANDomain(waninterface);%>;

    for (i = 0; i < waninterfaces.length - 1; i++) {
        if (domain == waninterfaces[i].tr098wanpath) {
            return waninterfaces[i].tr181interface;
        }
    }

    return "";
}

function GetWanConnectioDevicePath(WanFullPath) {
    var IndexOfConnction = WanFullPath.indexOf("WANIPConnection");
    if (-1 == IndexOfConnction) {
        IndexOfConnction = WanFullPath.indexOf("WANPPPConnection");
    }
    return WanFullPath.substr(0, IndexOfConnction-1);
}

var CurCfgModeWord ='<%HW_WEB_GetCfgMode();%>';

function MakeDefaultWanName(wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';

    wanInst = wan.MacId;
    wanServiceList  = wan.ServiceList.toUpperCase();
    wanMode         = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId          = wan.VlanId;

    if (CurCfgModeWord.toUpperCase() == "GSCMCC_RMS" && wanServiceList == "OTHER") {
        wanServiceList = "IPTV";
    }

    if (true == IsRadioWanSupported(wan)) {
        currentWanName = wanInst + "_" + RADIOWAN_NAMEPREFIX + "_" + wanServiceList + "_" + wanMode + "_VID_";
    } else {
        if (0 != parseInt(vlanId)) {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }
    }

    return currentWanName;
}

function MakeWanNameForVoice(wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';

    wanInst = wan.MacId;
    wanServiceList  = wan.ServiceList.toUpperCase().replace(new RegExp(/(VOIP)/g),"VOICE");
    wanMode         = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId          = wan.VlanId;

    if (true == IsRadioWanSupported(wan)) {
        currentWanName = wanInst + "_" + RADIOWAN_NAMEPREFIX + "_" + wanServiceList + "_" + wanMode + "_VID_";
    } else {
        if (0 != parseInt(vlanId)) {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }
    }

    return currentWanName;
}


function MakeWanName_New(wan) {
    var currentWanName = '';
    var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
    var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
    var CurrentBin = '<%HW_WEB_GetBinMode();%>';
    var IsCUMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CU);%>';

    if(IsCmProduct()) {
        return wan.Name;
    }

    if (wan.Name.indexOf("OLT") >= 0) {
        return MakeDefaultWanName(wan);
    }

    if (("0" == CUVoiceFeature) && ('1' == IsCUMode)) {
        currentWanName = MakeDefaultWanName(wan);
    } else if('E8C' == CurrentBin.toUpperCase() || "1" == CUVoiceFeature) {
        currentWanName = MakeWanNameForVoice(wan);
    } else {
        currentWanName = MakeDefaultWanName(wan);
    }

    return currentWanName;
}

function MakeWanName(wan) {
    return MakeWanName_New(wan);
}

function MakeWanName1(wan) {
    return MakeWanName_New(wan);
}

function ArrayIndexOf(List, Value) {
    for(var i in List) {
        if(List[i] == Value)
            return i;
    }
    return -1;
}

function IspWlanLoader() {
    function WlanISPSSID(domain, SSID, EnableUserId, UserId) {
        this.domain = domain;
        this.SSID = SSID;
        this.EnableUserId = EnableUserId;
        this.UserId = UserId;
    }
    function stWlanInfo(domain, name, X_HW_ServiceEnable, enable, bindenable) {
        this.domain = domain;
        this.name = name;
        this.X_HW_ServiceEnable = X_HW_ServiceEnable;
        this.enable = enable;
        this.bindenable = bindenable;
    }
    this.ISPSSIDList = [];
    this.WlanInfo = [];
    this.updateISPSSIDList = false;
    this.updateWlanInfo = false;

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_ispwlan.asp",
        beforeSend : function(xhr) {
            this.updateISPSSIDList = false;
        },
        success : function(data) {
            this.ISPSSIDList = dealDataWithFun(data);
            this.updateISPSSIDList = true;
            if (this.updateISPSSIDList && this.updateWlanInfo) {
                this.Validate();
            }
        }
    });
    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_wlaninfo.asp",
        beforeSend : function(xhr) {
            this.updateWlanInfo = false;
        },
        success : function(data) {
            this.WlanInfo = dealDataWithFun(data);
            this.updateWlanInfo = true;
            if (this.updateISPSSIDList && this.updateWlanInfo) {
                this.Validate();
            }
        }
    });
    this.GetISPSSIDList = function() {
        var ISPPortList = [];

        for(var j = 0; j < this.ISPSSIDList.length - 1; j++) {
            ISPPortList.push('SSID' + this.ISPSSIDList[j].SSID);
        }
        return ISPPortList;
    }

    this.BindWhichWan = function(BindList, Port) {
        for (var i in BindList) {
            if(BindList[i].PhyPortName.toUpperCase().indexOf(Port.toUpperCase()) >= 0)
                return BindList[i].WanName;
        }

        return '';
    }

    this.GetISPWanList = function(BindList, PortList) {
        var WanList = [];

        for(var port in PortList) {
            var Wan = this.BindWhichWan(BindList, PortList[port]);
            if(Wan.length != 0) {
                if(ArrayIndexOf(WanList, Wan) < 0)
                    WanList.push(Wan);
            }
        }

        return WanList;
    }

    this.GetISPWanOnlyRead = function() {
        if(typeof(__GetISPWanOnlyRead) == 'function'){
            return __GetISPWanOnlyRead();
        } else {
            return false;
        }
    }

    this.ISPWanList = [];

    this.ValidateISPWanList = function(BindList) {
        this.ISPWanList = this.GetISPWanList(BindList, this.GetISPSSIDList());
    }

    this.GetISPPortList = function() {
        return this.GetISPSSIDList();
    }
    this.IsWanHidden = function(interface) {
        return (ArrayIndexOf(this.ISPWanList, interface) >= 0);
    }

    this.IsWanMustHidden = function(interface) {
        return (!this.GetISPWanOnlyRead()) && this.IsWanHidden(interface);
    }

    this.IsOnlyReadWan = function(wan) {
        return (this.GetISPWanOnlyRead() && this.IsWanHidden(domainTowanname(wan.domain)));
    }

    this.Validate = function() {
        $(".subIspWlan").trigger("evtIspWlan");
    }
}

var Instance_IspWlan = new IspWlanLoader();

var WanList = new Array();

var Tr069WanOnlyRead = <%HW_WEB_GetFeatureSupport("BBSP_FT_TR069_WAN_ONLY_READ");%>;
var WanstatistcsRead = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_STATISTICS);%>';

var IPWanList = [];
var PPPWanList = [];
var unnumberdIPInfo = [];

(function() {
    var wanCacheObj = window.parent.wanCacheObj;
    if (wanCacheObj && wanCacheObj.wanListCacheObj
        && (JSON.stringify(wanCacheObj.wanListCacheObj) !== '{}')
    ) {
        var wanListCache = wanCacheObj.wanListCacheObj;
        IPWanList = wanListCache.IPWanList;
        PPPWanList = wanListCache.PPPWanList;
        unnumberdIPInfo = wanListCache.unnumberdIPInfo;
    } else {
        var result = ajaxGetAspData('/html/bbsp/common/wan_list_cache_wan.asp');
        IPWanList = result.IPWanList;
        PPPWanList = result.PPPWanList;
        unnumberdIPInfo = result.unnumberdIPInfo;
        if (window.parent.wanCacheObj) {
          window.parent.wanCacheObj.wanListCacheObj = result;
        }
    }
})();

var timesone;
function DSLiteLoader() {
    this.IPDSLiteList = [];
    this.PPPDSLiteList = [];
    this.ipDSLiteReady = false;
    this.pppDSLiteReady = false;

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_ipdslite.asp",
        beforeSend : function(xhr) {
            this.ipDSLiteReady = false;
        },
        success : function(data) {
            this.IPDSLiteList = dealDataWithFun(data);
            this.ipDSLiteReady = true;
            if (this.ipDSLiteReady && this.pppDSLiteReady) {
                this.Validate();
            }
        }
    });
    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_pppdslite.asp",
        beforeSend : function(xhr) {
            this.pppDSLiteReady = false;
        },
        success : function(data) {
            this.PPPDSLiteList = dealDataWithFun(data);
            this.pppDSLiteReady = true;
            if (this.ipDSLiteReady && this.pppDSLiteReady) {
                this.Validate();
            }
        }
    });

    this.WanListOverlay = function(WanList, DSLiteList) {
        for (var i = 0; i < DSLiteList.length - 1; i++) {
            for (var j = 0; j < WanList.length; j++) {
                if ((DSLiteList[i].domain.indexOf(WanList[j].domain) < 0) ||
                    (WanList[j].ProtocolType.toString() != "IPv6") ||
                    (WanList[j].Mode.toString().toUpperCase() != "IP_ROUTED")) {
                    continue;
                }
                switch(DSLiteList[i].WorkMode.toUpperCase()) {
                    case "OFF":
                        DSLiteList[i].WorkMode = "Off";
                        break;
                    case "STATIC":
                        DSLiteList[i].WorkMode = "Static";
                        break;
                    case "DYNAMIC":
                        DSLiteList[i].WorkMode = "Dynamic";
                        break;
                    default:
                        break;
                }
                WanList[j].EnableDSLite = (DSLiteList[i].WorkMode == "Off") ? "0" : "1";
                WanList[j].IPv6DSLite = DSLiteList[i].WorkMode;
                WanList[j].IPv6AFTRName = DSLiteList[i].AFTRName;
            }
        }
    }
    this.WanListOverlayAll = function(WanList) {
        this.WanListOverlay(WanList, this.IPDSLiteList);
        this.WanListOverlay(WanList, this.PPPDSLiteList);
    }

    this.Validate = function() {
        timesone = setInterval("dsLiteEvt()", 300);
    }
}

function dsLiteEvt() {
    $(".subDSLite").trigger("evtDSLite");
}

var Instance_DSLite = new DSLiteLoader();

function V6RDTunnelLoader() {
    this.IP6RDTunnelList = [];
    this.PPP6RDTunnelList = [];
    this.ipTunnelReady = false;
    this.pppTunnelReady = false;

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_v6iptunnel.asp",
        beforeSend : function(xhr) {
            this.ipTunnelReady = false;
        },
        success : function(data) {
            this.IP6RDTunnelList = dealDataWithFun(data);
            this.ipTunnelReady = true;
            if (this.ipTunnelReady && this.pppTunnelReady) {
                this.Validate();
            }
        }
    });
    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_v6ppptunnel.asp",
        beforeSend : function(xhr) {
            this.pppTunnelReady = false;
        },
        success : function(data) {
            this.PPP6RDTunnelList = dealDataWithFun(data);
            this.pppTunnelReady = true;
            if (this.ipTunnelReady && this.pppTunnelReady) {
                this.Validate();
            }
        }
    });

    this.WanListOverlay = function(WanList, V6TunnelList) {
        if (!Is6RdSupported()) {
            return;
        }
        for (var i = 0; i < V6TunnelList.length; i++) {
            for (var j = 0; j < WanList.length; j++) {
                if ((V6TunnelList[i].domain.indexOf(WanList[j].domain) < 0) ||
                    (WanList[j].ProtocolType.toString() != "IPv4") ||
                    (WanList[j].Mode.toString().toUpperCase() != "IP_ROUTED")) {
                    continue;
                }

                WanList[j].RdMode = (V6TunnelList[i].Enable6Rd == '1') ? V6TunnelList[i].RdMode : "Off";
                WanList[j].Enable6Rd = V6TunnelList[i].Enable6Rd;
                WanList[j].RdPrefix = V6TunnelList[i].RdPrefix;
                WanList[j].RdPrefixLen = V6TunnelList[i].RdPrefixLen;
                WanList[j].RdBRIPv4Address = V6TunnelList[i].RdBRIPv4Address;
                WanList[j].RdIPv4MaskLen = V6TunnelList[i].RdIPv4MaskLen;
            }
        }
    }
    this.WanListOverlayAll = function(WanList) {
        this.WanListOverlay(WanList, this.IP6RDTunnelList);
        this.WanListOverlay(WanList, this.PPP6RDTunnelList);
    }

    this.Validate = function() {
        $(".subV6RDTunnel").trigger("evtV6RDTunnel");
    }
}

var Instance_v6RDTunnel = new V6RDTunnelLoader();

function RadioWanLoader() {
    this.RadioWanParaList = [];
    this.RadioWanPSList = [];
    this.ParaListReady = false;
    this.PSListReady = false;

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_radiowanpara.asp",
        beforeSend : function(xhr) {
            this.ParaListReady = false;
        },
        success : function(data) {
            this.RadioWanParaList = dealDataWithFun(data);
            this.ParaListReady = true;
            if (this.ParaListReady && this.PSListReady) {
                this.Validate();
            }
        }
    });
    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_radiowanps.asp",
        beforeSend : function(xhr) {
            this.PSListReady = false;
        },
        success : function(data) {
            this.RadioWanPSList = dealDataWithFun(data);
            this.PSListReady = true;
            if (this.ParaListReady && this.PSListReady) {
                this.Validate();
            }
        }
    });
    this.WanListOverlay = function(WanList) {
        for (var j = 0; j < WanList.length; j++) {
            if (!IsRadioWanSupported(WanList[j])) {
                continue;
            }
            if (this.RadioWanPSList.length > 1) {
                WanList[j].RadioWanPSEnable = this.RadioWanPSList[0].RadioWanPSEnable;
                WanList[j].AccessType = this.RadioWanPSList[0].AccessType;
                WanList[j].SwitchMode = this.RadioWanPSList[0].SwitchMode;
                WanList[j].SwitchDelayTime = this.RadioWanPSList[0].SwitchDelayTime;
                WanList[j].PingIPAddress = this.RadioWanPSList[0].PingIPAddress;
            }

            if (this.RadioWanParaList.length > 1) {
                WanList[j].RadioWanUsername = this.RadioWanParaList[0].RadioWanUsername;
                WanList[j].RadioWanPassword = this.RadioWanParaList[0].RadioWanPassword;
                WanList[j].APN = this.RadioWanParaList[0].APN;
                WanList[j].DialNumber = this.RadioWanParaList[0].DialNumber;
                WanList[j].TriggerMode = WanList[j].ConnectionTrigger;
            }
        }
    }

    this.WanListOverlayAll = function(WanList) {
        this.WanListOverlay(WanList);
    }

    this.Validate = function() {
        $(".subRadioWan").trigger("evtRadioWan");
    }

    this.IsInvalidRadioWan = function() {
        if (((RadioWanParaList.length == 1) && (RadioWanParaList.length < RadioWanPSList.length)) ||
            ((RadioWanPSList.length == 1) && (RadioWanParaList.length > RadioWanPSList.length))) {
            return true;
        }
        return false;
    }

    this.CompensateRadioWanCfg = function() {
        var requestUrl = "";
        var Onttoken = "<%HW_WEB_GetToken();%>";

        if ((RadioWanParaList.length == 1) && (RadioWanParaList.length < RadioWanPSList.length)) {
            requestUrl = 'InternetGatewayDevice.X_HW_RadioWanPS.1' + '=';
        }
        else if ((RadioWanPSList.length == 1) && (RadioWanParaList.length > RadioWanPSList.length)) {
            requestUrl = 'InternetGatewayDevice.X_HW_Radio_WAN.1' + '=';
        } else {
            return;
        }
        requestUrl += '&x.X_HW_Token=' + Onttoken;

        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : requestUrl,
            url :  "del.cgi?" + "&RequestFile=html/ipv6/not_find_file.asp"
        });
    }
}

var Instance_RadioWan = new RadioWanLoader();

function WanStatsLoader() {
    this.WanEthIPStats = [];
    this.WanEthPPStats = [];
    this.ipStatsReady = false;
    this.ppStatsReady = false;

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_ipwanstat.asp",
        beforeSend : function(xhr) {
            this.ipStatsReady = false;
        },
        success : function(data) {
            this.WanEthIPStats = dealDataWithFun(data);
            this.ipStatsReady = true;
            if (this.ipStatsReady && this.ppStatsReady) {
                this.Validate();
            }
        }
    });
    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_pppwanstat.asp",
        beforeSend : function(xhr) {
            this.ppStatsReady = false;
        },
        success : function(data) {
            this.WanEthPPStats = dealDataWithFun(data);
            this.ppStatsReady = true;
            if (this.ipStatsReady && this.ppStatsReady) {
                this.Validate();
            }
        }
    });

    this.WanListOverlay = function(WanList, WanStats) {
        if (WanstatistcsRead != 1) {
            return;
        }
        for (var i = 0; i < WanStats.length - 1; i++) {
            for (var j = 0; j < WanList.length; j++) {
                if (WanStats[i].domain.indexOf(WanList[j].domain) < 0) {
                    continue;
                }
                WanList[j].BytesSent = WanStats[i].BytesSent;
                WanList[j].BytesReceived = WanStats[i].BytesReceived;
                WanList[j].PacketsSent = WanStats[i].PacketsSent;
                WanList[j].PacketsReceived = WanStats[i].PacketsReceived;
                WanList[j].UnicastSent = WanStats[i].UnicastSent;
                WanList[j].UnicastReceived = WanStats[i].UnicastReceived;
                WanList[j].MulticastSent = WanStats[i].MulticastSent;
                WanList[j].MulticastReceived = WanStats[i].MulticastReceived;
                WanList[j].BroadcastSent = WanStats[i].BroadcastSent;
                WanList[j].BroadcastReceived = WanStats[i].BroadcastReceived;
            }
        }
    }
    this.WanListOverlayAll = function(WanList) {
        this.WanListOverlay(WanList, this.WanEthIPStats);
        this.WanListOverlay(WanList, this.WanEthPPStats);
    }

    this.Validate = function() {
        $(".subWanStats").trigger("evtWanStats");
    }
}

var Instance_WanStats = new WanStatsLoader();

var ProductType = '<%HW_WEB_GetProductType();%>';
function IsXdProduct() {
    return '2'==ProductType;
}

function IsCmProduct() {
    return '3'==ProductType;
}

function AccessTypeLoader() {
    this.DSLWanInstance = "";
    this.VDSLWanInstance = "";
    this.ETHWanInstance = "";
    this.SFPWanInstance = "";
    this.UMTSWanInstance = "";

    this.AccessTypeList = [];

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_wanaccesstype.asp",
        success : function(data) {
            this.AccessTypeList = dealDataWithFun(data);
            this.Validate();
        }
    });

    this.Validate = function() {
        for(var i = 0; i < AccessTypeList.length - 1; i++) {
            if(AccessTypeList[i].WANAccessType == "DSL") {
                DSLWanInstance = AccessTypeList[i].domain.split(".")[2];
            } else if(AccessTypeList[i].WANAccessType == "VDSL") {
                VDSLWanInstance = AccessTypeList[i].domain.split(".")[2];
            } else if(AccessTypeList[i].WANAccessType == "Ethernet") {
                ETHWanInstance = AccessTypeList[i].domain.split(".")[2];
            } else if(AccessTypeList[i].WANAccessType == "SFP") {
                SFPWanInstance = AccessTypeList[i].domain.split(".")[2];
            } else if(AccessTypeList[i].WANAccessType == "UMTS") {
                UMTSWanInstance = AccessTypeList[i].domain.split(".")[2];
            }
        }

        $(".subWANAccessType").trigger("evtWANAccessType");
    }

    this.GetWanInstByWanAceesstype = function(wanAccesstype) {
        if(wanAccesstype == "DSL") {
            return DSLWanInstance;
        } else if(wanAccesstype == "VDSL") {
            return VDSLWanInstance;
        } else if(wanAccesstype == "Ethernet") {
            return ETHWanInstance;
        } else if(wanAccesstype == "SFP") {
            return SFPWanInstance;
        } else if(wanAccesstype == "UMTS") {
            return UMTSWanInstance;
        }
        return 1;
    }

    this.GetWanAceesstypeByWanInst = function(Inst) {
        if(Inst == DSLWanInstance) {
            return "DSL" ;
        } else if(Inst == VDSLWanInstance) {
            return "VDSL";
        } else if(Inst == ETHWanInstance) {
            return "Ethernet";
        } else if((Inst == SFPWanInstance) && (isSupportSFP == 1)) {
            return "SFP";
        } else if(Inst == UMTSWanInstance) {
            return "UMTS";
        }
        return null;
    }
}

function GetPVCIsInUsedWANConnectionDeviceInst(Wan) {
    for (var i = 0; i < GetWanList().length; i++) {
        if (GetWanList()[i].DestinationAddress == Wan.DestinationAddress) {
            return GetWanList()[i].domain.split(".")[4];
        }
    }

    return null;
}

function GetVdslIsInUsedWANConnectionDeviceInst(Wan) {
    for (var i = 0; i < GetWanList().length; i++) {
        if (GetWanList()[i].domain.split(".")[2] == "2") {
            return GetWanList()[i].domain.split(".")[4];
        }
    }
    return null;
}

function GetEthIsInUsedWANConnectionDeviceInst(Wan) {
    for (var i = 0; i < GetWanList().length; i++) {
        if (GetWanList()[i].domain.split(".")[2] == "3") {
            return GetWanList()[i].domain.split(".")[4];
        }
    }

    return null;
}

function GetSfpIsInUsedWANConnectionDeviceInst(Wan) {
    for (var i = 0; i < GetWanList().length; i++) {
        if (GetWanList()[i].domain.split(".")[2] == "4") {
            return GetWanList()[i].domain.split(".")[4];
        }
    }

    return null;
}

function IsAdminUser() {
    return (curUserType == 0);
}

var refreshWanInfo = function(refreshFlag) {
  for (i=0, j=0; IPWanList.length > 0 && i < IPWanList.length -1; i++, j++) {
    if ("1" == IPWanList[i].Tr069Flag || Instance_IspWlan.IsWanMustHidden(domainTowanname(IPWanList[i].domain)) == true) {
        j--;
        continue;
    }

    if (filterWanOnlyTr069(IPWanList[i]) == false ) {
        j--;
        continue;
    }

    if (filterWanByVlan(IPWanList[i]) == false ) {
        j--;
        continue;
    }

    if ((true == IsRadioWanSupported(IPWanList[i])) && (true == IsInvalidRadioWan())) {
        j--;
        CompensateRadioWanCfg();
        continue;
    }

    if (!refreshFlag) {
      WanList[j] = new WanInfoInst();
    }
    ConvertIPWan(IPWanList[i], WanList[j]);
    WanList[j].Name = MakeWanName(WanList[j]);
  }

  for(i=0; PPPWanList.length > 0 && i < PPPWanList.length - 1; j++,i++) {
      if ("1" == PPPWanList[i].Tr069Flag || Instance_IspWlan.IsWanMustHidden(domainTowanname(PPPWanList[i].domain)) == true &&
          ('JSCMCC' != CfgModeWord.toUpperCase() || PPPWanList[i].VlanId != 4031 || curUserType != 0)) {
          j--;
          continue;
      }
      if(filterWanOnlyTr069(PPPWanList[i]) == false ) {
          j--;
          continue;
      }

      if(filterWanByVlan(PPPWanList[i]) == false ) {
          j--;
          continue;
      }

      if ((true == IsRadioWanSupported(PPPWanList[i])) && (true == IsInvalidRadioWan())) {
          j--;
          CompensateRadioWanCfg();
          continue;
      }

      if (!refreshFlag) {
        WanList[j] = new WanInfoInst();
      }
      ConvertPPPWan(PPPWanList[i], WanList[j]);
      WanList[j].Name = MakeWanName(WanList[j]);
  }

  WanList.sort(
    function (wan1, wan2) {
        var cmp = 0;

        if(wan1.MacId > wan2.MacId)
                cmp = 1;
        else if(wan1.MacId < wan2.MacId)
            cmp = -1;
        else
            cmp = 0;

        return cmp;
    }
  );
}

refreshWanInfo(false);

function LazyLoad() {
    var __RenderPage = function(event) {
        if(typeof(RenderPage) == 'function'){
            return RenderPage(event);
        }
    }
    $(".subWanListPolicyRoute").on("evtWanListPolicyRoute", function(event) {
        Instance_IspWlan.ValidateISPWanList(Instance_PolicyRoute.GetLanWanBindList());
        __RenderPage(event);
    });
    $(".subWanListIPVersion").on("evtWanListIPVersion", function(event) {
        Instance_IspWlan.ValidateISPWanList(Instance_PolicyRoute.GetLanWanBindList());
        __RenderPage(event);
    });
    $(".subIspWlan").on("evtIspWlan", function(event) {
        __RenderPage(event);
    });
    $(".subDSLite").on("evtDSLite", function(event) {
        clearInterval(timesone);
        Instance_DSLite.WanListOverlayAll(WanList);
        __RenderPage(event);
    });
    $(".subV6RDTunnel").on("evtV6RDTunnel", function(event) {
        Instance_v6RDTunnel.WanListOverlayAll(WanList);
        __RenderPage(event);
    });
    $(".subRadioWan").on("evtRadioWan", function(event) {
        Instance_RadioWan.WanListOverlayAll(WanList);
        __RenderPage(event);
    });
    $(".subWanStats").on("evtWanStats", function(event) {
        Instance_WanStats.WanListOverlayAll(WanList);
        __RenderPage(event);
    });
    $(".subWANAccessType").on("evtWANAccessType", function(event) {
        __RenderPage(event);
    });
    $(".subIPv6AddressList").on("evtIPv6AddressList", function(event) {
        __RenderPage(event);
    });
    $(".subIPv6PrefixList").on("evtIPv6PrefixList", function(event) {
        __RenderPage(event);
    });
    $(".subIPv6WanInfoList").on("evtIPv6WanInfoList", function(event) {
        __RenderPage(event);
    });
}


function UpdateV6AddrInfo() {
    this.IPv6PrefixMode   = "PrefixDelegation";
    this.IPv6AddressStuff = "";
    this.IPv6AddressMode  = "DHCPv6";
    this.IPv6StaticPrefix = "20::01/64";
    this.IPv6IPAddress    = "20::02";
    this.IPv6AddrMaskLenE8c    = "64";
    this.IPv6GatewayE8c    = "";
    this.IPv6ReserveAddress = "";
    this.IPv6SubnetMask   = "";
    this.IPv6Gateway      = "";
    this.IPv6PrimaryDNS   = "";
    this.IPv6SecondaryDNS = "";
    this.IPv6WanMVlanId   = "";

    for (var i = 0; i < WanList.length; i++) {
        var AddressAcquireItem = GetIPv6AddressAcquireInfo(WanList[i].domain);
        var PrefixAcquireItem = GetIPv6PrefixAcquireInfo(WanList[i].domain);

        WanList[i].IPv6AddressMode = (null != AddressAcquireItem && AddressAcquireItem.Origin!="") ? AddressAcquireItem.Origin : "None";
        WanList[i].IPv6AddressStuff = (null != AddressAcquireItem) ? AddressAcquireItem.ChildPrefixBits : "";
        WanList[i].IPv6IPAddress = (null != AddressAcquireItem) ? AddressAcquireItem.IPAddress : "";
        WanList[i].IPv6AddrMaskLenE8c = (null != AddressAcquireItem) ? AddressAcquireItem.AddrMaskLen : "";
        WanList[i].IPv6GatewayE8c = (null != AddressAcquireItem) ? AddressAcquireItem.DefaultGateway : "";
        if (WanList[i].EncapMode == "IPoE") {
            WanList[i].IPv6ReserveAddress = (null != AddressAcquireItem) ? AddressAcquireItem.IPv6ReserveAddress : "";
        } else if (WanList[i].EncapMode == "PPPoE") {
            WanList[i].IPv6ReserveAddress = "";
        }
        WanList[i].IPv6PrefixMode = (null != PrefixAcquireItem && PrefixAcquireItem.Origin!="") ? PrefixAcquireItem.Origin : "None";
        WanList[i].EnablePrefix =(WanList[i].IPv6PrefixMode == "None") ? "0":"1";
        WanList[i].IPv6StaticPrefix = (null != PrefixAcquireItem) ? PrefixAcquireItem.Prefix : "";
    }
}
try {
    UpdateV6AddrInfo();
} catch (e) {}

function GetIPv6WanDNS(IPv6WanDomain) {
    var DnsServer = GetIPv6WanDnsServerInfo(domainTowanname(IPv6WanDomain));

    if (DnsServer == null || DnsServer=="") {
        return null;
    }

  return DnsServer.DNSServer;
}

try
{
    for (var i = 0; i < WanList.length; i++) {
        var DnsServer = GetIPv6WanDNS(WanList[i].domain);

        if (DnsServer == null) {
            continue;
        }

        var DnsServerList = DnsServer.split(",");
        if (DnsServerList == null) {
            continue;
        }

        WanList[i].IPv6PrimaryDNS = ((DnsServerList.length >= 1) ? DnsServerList[0] : "");
        WanList[i].IPv6SecondaryDNS = ((DnsServerList.length >= 2) ? DnsServerList[1] : "");
    }
}catch(ex){}

function ModifyWanList(ModifyFunc) {
    if (ModifyFunc == null || ModifyFunc == undefined) {
        return;
    }

    for (var i = 0; i < WanList.length; i++) {
        try {
            ModifyFunc(WanList[i]);
        } catch(e) {

        }
    }
}

function filterWanListByHON()
{
    var result = [];
    for (var i = 0; i < WanList.length; i++) {
        var wan = WanList[i];
        if (wan.ServiceList.toUpperCase() != "HON") {
            result.push(wan);
        }
    }
    return result;
}

function GetWanList() {
    if (((isScCt == 1) && (isSupportPCDN == 1)) ||
        ((isSupportPCDN == 1) &&(isSupportModifyCdn == 1)) ||
        ((isSupportPCDN == 1) && (isSupportModifyCdn == 1) && (curUserType == 1)) ||
        ((isHONWanView != 1) && (isSupportPCDN == 1))) {
        return filterWanListByHON();
    }
    return WanList;
}

function GetRadioWanParaList() {
    return RadioWanParaList;
}

function GetRadioWanPSList() {
    return RadioWanPSList;
}

function IsTr069WanOnlyRead() {
    return Tr069WanOnlyRead;
}

function GetWanListByFilter(filterFunction) {
    var WansResult = new Array();
    var WanList = GetWanList();
    var i=0;
    var j=0;

    for (i = 0; i < WanList.length; i++) {
    if (filterFunction != null && filterFunction != undefined) {
        if (filterFunction(WanList[i]) == false) {
            continue;
        }
    }

     WansResult[j]=WanList[i];
     j++;
    }

  return WansResult;
}

function FindWanInfoByAppInfo(appItem) {
    var WanList = GetWanList();
    var wandomain_len = 0;
    var temp_domain = null;

    for(var k = 0; k < WanList.length; k++ ) {
        wandomain_len = WanList[k].domain.length;
        temp_domain = appItem.domain.substr(0, wandomain_len);

        if (temp_domain == WanList[k].domain) {
            return WanList[k];
        }
    }
    return null;
}

function GetAppListFormWanAppendInfo(wanAppInfo1, wanAppInfo2, filterFunction) {
    var listAppInfo = new Array();
    var Idx = 0;

    for (var i = 0; i < wanAppInfo1.length-1; i++) {
        var tmpWan = FindWanInfoByAppInfo(wanAppInfo1[i]);

        if (tmpWan == null) {
            continue;
        }

        if (filterFunction == null || filterFunction(tmpWan)) {
            listAppInfo[Idx] = wanAppInfo1[i];
            Idx ++;
        }
    }

    for (var j = 0; j < wanAppInfo2.length-1; j++) {
        var tmpWan = FindWanInfoByAppInfo(wanAppInfo2[j]);

        if (tmpWan == null) {
            continue;
        }

        if (filterFunction == null || filterFunction(tmpWan)) {
            listAppInfo[Idx] = wanAppInfo2[j];
            Idx ++;
        }
    }

    return listAppInfo;
}

function InitWanNameListControl(WanListControlId, IsThisWanOkFunction) {
    var Control = getElById(WanListControlId);
    var WanList = GetWanListByFilter(IsThisWanOkFunction);
    var i = 0;
    var NullOption = document.createElement("Option");
    NullOption.value = '';
    NullOption.innerText = '';
    NullOption.text = '';
    Control.appendChild(NullOption);

    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = domainTowanname(WanList[i].domain);
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);
        Control.appendChild(Option);
    }
}

function InitWanNameListControl1(WanListControlId, IsThisWanOkFunction) {
    var Control = getElById(WanListControlId);
    var WanList = GetWanListByFilter(IsThisWanOkFunction);
    var i = 0;
    var NullOption = document.createElement("Option");
    NullOption.value = '';
    NullOption.innerText = '';
    NullOption.text = '';
    Control.appendChild(NullOption);

    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = WanList[i].domain;
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);

        Control.appendChild(Option);
    }
}

function InitWanNameListControl2(WanListControlId, IsThisWanOkFunction) {
    var Control = getElById(WanListControlId);
    var WanList = GetWanListByFilter(IsThisWanOkFunction);
    var i = 0;

    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = WanList[i].domain;
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);

        Control.appendChild(Option);
    }
}

function InitWanNameListControl_if(WanListControlId, IsThisWanOkFunction) {
    var Control = getElById(WanListControlId);
    var WanList = GetWanListByFilter(IsThisWanOkFunction);
    var i = 0;
    var NullOption = document.createElement("Option");
    NullOption.value = '';
    NullOption.innerText = '';
    NullOption.text = '';
    Control.appendChild(NullOption);

    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = domainTowanname_if(WanList[i].domain);
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);
        Control.appendChild(Option);
    }
}

function InitWanNameListControlWanname(WanListControlId, IsThisWanOkFunction) {
    var Control = getElById(WanListControlId);
    var WanList = GetWanListByFilter(IsThisWanOkFunction);
    var i = 0;

    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = domainTowanname(WanList[i].domain);
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);
        Control.appendChild(Option);
    }
}

function GetWanFullName(WanName) {
    for (var i = 0; i < WanList.length;i++) {
        if (WanList[i].NewName == WanName) {
            return MakeWanName(WanList[i]);
        }
    }

    return WanName;
}

function getWANByVlan(vlan) {
    var wanSpec = new Array();
    var i = 0;
    for(i=0; PPPWanList.length > 0 && i < PPPWanList.length - 1; i++) {
        if (vlan == PPPWanList[i].VlanId) {
            wanSpec.push(PPPWanList[i]);
        }
    }
    for(i=0; IPWanList.length > 0 && i < IPWanList.length - 1; i++) {
        if (vlan == IPWanList[i].VlanId) {
            wanSpec.push(IPWanList[i]);
        }
    }
    return wanSpec;
}

function GetWanInfoByWanName(WanName) {
    for (var i = 0; i < WanList.length;i++) {
        if (WanList[i].NewName == WanName) {
            return (WanList[i]);
        }
    }

    return WanName;
}

function GetWanInfoByDomain(Domain) {
    for (var i = 0; i < WanList.length;i++) {
        if (WanList[i].domain == Domain) {
            return (domainTowanname(WanList[i].domain));
        }
    }

    return Domain;
}

function WanMacId2WanPath(wanMacId) {
    for (var i = 0; i < WanList.length;i++) {
        if (wanMacId == WanList[i].MacId) {
            return WanList[i].domain;
            break;
        }
    }
    return "";
}

function WanPath2WanMacId(wanPath) {
    for (var i = 0; i < WanList.length;i++) {
        if (wanPath.toUpperCase() == WanList[i].domain.toUpperCase()) {
            return WanList[i].MacId;
        }
    }
    return 0;
}

function RemoveDomainPoint(str) {
    if (str.charAt(str.length-1) == ".") {
        return str.slice(0,str.length-1);
    } else {
        return str;
    }
}

function WanIsExist() {
    if ((IPWanList.length > 1 && IPWanList[0] != null) || (PPPWanList.length > 1 && PPPWanList[0] != null)) {
        return true;
    }

    return false;
}

if (window.parent.startWanStateTimer) {
  window.parent.startWanStateTimer();
}