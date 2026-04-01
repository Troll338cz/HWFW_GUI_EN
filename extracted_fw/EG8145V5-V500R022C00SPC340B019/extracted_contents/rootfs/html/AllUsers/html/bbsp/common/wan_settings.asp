var isSupportSFP = "<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SFP);%>";
var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
var xdPonSupport = "<%HW_WEB_GetFeatureSupport(FT_XD_PON_SURPPORTED);%>";
var dbaa1Mode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.CurProfile.BondingProfile);%>';
var DBAA1 = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var IsZQ = "<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>";
var SingtelModeEX = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL_EX);%>';
var showWanName = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_WANNAME);%>';
var isDSLSupport = '<%HW_WEB_GetFeatureSupport(HW_FT_DSL_SURPPORT);%>';

function PolicyRouteItem(_Domain, _Type, _VenderClassId, _WanName, _EtherType, _PhyPortName) {
  this.Domain = _Domain;
  this.Type = _Type;
  this.VenderClassId = _VenderClassId;
  this.WanName = _WanName;
  this.EtherType = _EtherType;
  this.PhyPortName = _PhyPortName;
}

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
        return 'wan' + domaina[2]  + '.' + domaina[4] + type + domaina[6] ;
    }
}

function waninterface(tr098wanpath, tr181interface) {
    this.tr098wanpath = tr098wanpath;
    this.tr181interface = tr181interface;
}

function domainTowanname_if(domain)
{
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

function MakeWanNameForPTVDF(wan) {
    var currentWanName = '';

    if (true == IsRadioWanSupported(wan)) {
        return "Mobile";
    }

    switch (wan.ServiceList.toUpperCase()) {
        case "INTERNET":
        case "TR069_INTERNET":
            currentWanName = "Internet";
            break;
        case "VOIP":
        case "TR069_VOIP":
            currentWanName = "VoIP";
            break;
        case "IPTV":
        case "TR069_IPTV":
            currentWanName = "IPTV";
            break;
        case "TR069":
            currentWanName = "TR069";
            break;
        case "OTHER":
            currentWanName = "OTHER";
            break;
        case "VOIP_INTERNET":
        case "TR069_VOIP_INTERNET":
            currentWanName = "VoIP_Internet";
            break;
        case "VOIP_IPTV":
        case "TR069_VOIP_IPTV":
            currentWanName = "VoIP_IPTV";
            break;
        case "IPTV_INTERNET":
        case "TR069_IPTV_INTERNET":
            currentWanName = "IPTV_Internet";
            break;
        case "VOIP_IPTV_INTERNET":
        case "TR069_VOIP_IPTV_INTERNET":
            currentWanName = "VoIP_IPTV_Internet";
            break;
        default:
            break;
    }

    return currentWanName;
}

function MakeWanNameForTURKCELL(wan) {
    var currentWanName = '';

    switch (wan.ServiceList.toUpperCase()) {
        case "IPTV":
            currentWanName = "WAN_IPTV";
            break;
        case "TR069_VOIP_INTERNET":
            currentWanName = "WAN_INTERNET";
            break;
        default:
            if(IsXdProduct()) {
                currentWanName = MakeDefaultWanNameForXD(wan);
            } else {
                currentWanName = MakeDefaultWanName(wan);
            }
            break;
    }

    return currentWanName;
}

var IsPTVDFMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsTDE2Mode   = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var CurCfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var ttnet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';

function MakeDefaultWanNameForXD(Wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';
    var linktype = '';
    var pvc = '';

    wanInst = Wan.MacId;
    wanServiceList  = Wan.ServiceList.toUpperCase();
    wanMode         = (Wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId          = Wan.VlanId;
    pvc             = Wan.DestinationAddress;

    if(Wan.WanAccessType == 'DSL') {
        linktype = "ADSL";
    } else if(Wan.WanAccessType == 'VDSL') {
        linktype = "VDSL";
    } else if(Wan.WanAccessType == 'Ethernet') {
        linktype = "GE";
    } else if(Wan.WanAccessType == 'SFP' && 1 == isSupportSFP) {
        linktype = "SFP";
    }
    
    if (true == IsRadioWanSupported(Wan)) {
        if (DBAA1 == '1'){
            currentWanName = "INTERNET_MOBILE";
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + RADIOWAN_NAMEPREFIX + "_VID_";
        }
    } else {
        if(linktype == "ADSL") {
            if (0 != parseInt(vlanId)) {
                currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + linktype + "_" + pvc + "_VID_" + vlanId;
            } else {
                currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + linktype  + "_" + pvc;
            }
        } else {
            if ((CurCfgModeWord.toUpperCase() == "DTURKCELL2WIFI") || (CurCfgModeWord.toUpperCase() == 'TURKCELL2')) {
                if (4095 != parseInt(vlanId)) {
                    currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + linktype + "_VID_" + vlanId;
                } else {
                    currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + linktype + "_VID_";
                }
            } else {
                if (((ttnet == '1') && (parseInt(vlanId) != "-1")) || (parseInt(vlanId) != "0")) {
                    currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + linktype + "_VID_" + vlanId;
                } else {
                    currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + linktype + "_VID_";
                }
            }
         }
    }

    return currentWanName;
}

function MakeWanNameForOteNewWan(Wan) {
    var currentWanName = '';
    var linktype = '';

    var wanServiceList  = Wan.ServiceList.toUpperCase();
    var wanMode         = (Wan.Mode == 'IP_Routed' ) ? "R" : "B";
    var vlanId          = Wan.VlanId;
    var pvc             = Wan.DestinationAddress;

    if(Wan.WanAccessType == 'DSL') {
        linktype = "ADSL";
    } else if(Wan.WanAccessType == 'VDSL') {
        linktype = "VDSL";
    } else if(Wan.WanAccessType == 'Ethernet') {
        linktype = "GE";
    } else if(Wan.WanAccessType == 'SFP' && 1 == isSupportSFP) {
        linktype = "SFP";
    }
    
    if (true == IsRadioWanSupported(Wan)) {
        currentWanName = wanServiceList + "_" + wanMode + "_" + RADIOWAN_NAMEPREFIX;
    } else {
        if(linktype == "ADSL") {
            if (0 != parseInt(vlanId)) {
                currentWanName = wanServiceList + "_" + wanMode + "_" + linktype + "_" + pvc + "_VID_" + vlanId;
            } else {
                currentWanName = wanServiceList + "_" + wanMode + "_" + linktype  + "_" + pvc;
            }
        } else {
            if (0 != parseInt(vlanId)) {
                currentWanName = wanServiceList + "_" + wanMode + "_" + linktype + "_VID_" + vlanId;
            } else {
                currentWanName = wanServiceList + "_" + wanMode + "_" + linktype + "_VID_";
            }
         }
    }

    return currentWanName;
}

function MakeWanNameForOteDefaultWan(Wan) {
    var currentWanName = '';
    var linktype = '';

    if(Wan.WanAccessType == 'DSL') {
        linktype = "ADSL";
    } else if(Wan.WanAccessType == 'VDSL') {
        linktype = "VDSL";
    } else if(Wan.WanAccessType == 'Ethernet') {
        linktype = "GE";
    } else if(Wan.WanAccessType == 'SFP' && 1 == isSupportSFP) {
        linktype = "SFP";
    }
    
    if (true == IsRadioWanSupported(Wan)) {
        currentWanName = "MOBILE";
    } else {
        if (Wan.ServiceList.toUpperCase().indexOf("INTERNET") >= 0) {
            currentWanName = "INTERNET_" + linktype;
        } else {
            currentWanName = "IPTV_" + linktype;
        }
    }

    return currentWanName;
}

function MakeWanNameForOte(Wan) {
    if (Wan.MacId > 5) {
        return MakeWanNameForOteNewWan(Wan);
    } else {
        return MakeWanNameForOteDefaultWan(Wan);
    }
}

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

    if (((CurCfgModeWord.toUpperCase() == "GSCMCC_RMS") || (CurCfgModeWord.toUpperCase() == "GSCMCC_FTTO")) &&
        (wanServiceList == "OTHER")) {
        wanServiceList = "IPTV";
    }

    if (IsRadioWanSupported(wan) == true) {
        currentWanName = wanInst + "_" + RADIOWAN_NAMEPREFIX + "_" + wanServiceList + "_" + wanMode + "_VID_";
    } else if (CurCfgModeWord.toUpperCase() == 'TURKCELL2') {
        if (parseInt(vlanId) != 4095) {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }
    } else {
        if (parseInt(vlanId) != 0) {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }
    }

    return currentWanName;
}

function MakeGdgdWanName(wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';
    
    wanInst = wan.MacId;
    wanServiceList  = wan.ServiceList.toUpperCase();
    
    if (wanServiceList == 'INTERNET') {
        wanServiceList = "eRouter";
    } else if (wanServiceList == 'VOIP') {
        wanServiceList = "eMTA";
    } else if (wanServiceList == 'TR069_IPTV') {
        wanServiceList = "eSTB";
    }
    
    wanMode = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId = wan.VlanId;
    
    if (IsRadioWanSupported(wan) == true) {
        currentWanName = wanInst + "_" + RADIOWAN_NAMEPREFIX + "_" + wanServiceList + "_" + wanMode + "_VID_";
    } else {
        if (parseInt(vlanId) != 0) {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }
    }
    
    return currentWanName;
}

function MakeWanNameHiddenVlan(wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';

    wanInst = wan.MacId;
    wanServiceList  = wan.ServiceList.toUpperCase();
    wanMode         = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    if (!IsAdminUser()) {
        currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode;
    } else {
        currentWanName = MakeDefaultWanName(wan);
    }
    return currentWanName;     
}

function MakeWanNameForQtelMTN(wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';
    wanInst = wan.MacId;
    wanServiceList  = wan.ServiceList.toUpperCase();
    wanMode         = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId          = wan.VlanId;

    if (true == IsRadioWanSupported(wan)) {
        currentWanName = "Mobile";
    } else {
        if (0 != parseInt(vlanId)) {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        } else {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }
    }

    return currentWanName;
}

function MakeWanNameForPCCW(wan) {
    var currentWanName = '';
    var wanInst = 0;
    var wanMode = '';

    wanInst = wan.MacId;
    wanMode = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    if(true == IsRadioWanSupported(wan)) {
        currentWanName = wanInst + "_" + RADIOWAN_NAMEPREFIX + "_" + wanServiceList + "_" + wanMode + "_VID_";
    } else {
        wanMode = (wan.Mode == 'IP_Routed' ) ? "Route" : "Bridge";
        currentWanName = wanInst + "_" + wanMode + "_" + "WAN";
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

    if (wanServiceList == "HQOS") {
        wanServiceList = "HQoS";
    }

    if (wanServiceList == "D_BUS") {
        wanServiceList = "D_Bus";
    }

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

function MakeWanNameForA8C(wan) {
    var wanServiceList = '';
    wanServiceList  = wan.ServiceList.toUpperCase();
    wanMode         = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId          = wan.VlanId;
    var currentWanName = '';
    wanInst = wan.MacId;
    
    switch(wanServiceList) {
        case "INTERNET":
            wanServiceList = "Internet";
            break;
        case "VOIP":
            wanServiceList = "Voice";
            break;
        case "IPTV":
            wanServiceList = "iTV";
            break;
        case "TR069":
            wanServiceList = "Management";
            break;
        case "OTHER":
            wanServiceList = "Other";
            break;
        case "TR069_INTERNET":
            wanServiceList = "Management_Internet";
            break;
        case "TR069_VOIP":
            wanServiceList = "Management_Voice";
            break;
        case "VOIP_INTERNET":
            wanServiceList = "Voice_Internet";
            break;
        case "TR069_VOIP_INTERNET":
            wanServiceList = "Management_Voice_Internet";
            break;
        case "VOIP_IPTV":
            wanServiceList = "Voice_iTV";
            break;
        case "TR069_IPTV":
            wanServiceList = "Management_iTV";
            break;
        case "TR069_VOIP_IPTV":
            wanServiceList = "Management_Voice_iTV";
            break;
        case "IPTV_INTERNET":
            wanServiceList = "iTV_Internet";
            break;
        case "VOIP_IPTV_INTERNET":
            wanServiceList = "Voice_iTV_Internet";
            break;
        case "TR069_IPTV_INTERNET":
            wanServiceList = "Management_iTV_Internet";
            break;
        case "TR069_VOIP_IPTV_INTERNET":
            wanServiceList = "Management_Voice_iTV_Internet";
            break;
        default:
            break;
    }
    

    if (0 != parseInt(vlanId)) {
        currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_" + vlanId;
    } else {
        currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_";
    }  
    
    return currentWanName;
}

function MakeWanName_New(wan) {
    var currentWanName = '';
    var Layer2Feature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_SERVICELIST_BY_LAYER2);%>";
    var CfgModePCCWHK = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PCCW);%>";
    var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
    var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
    var CurrentBin = '<%HW_WEB_GetBinMode();%>';
    var IsCUMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CU);%>';
    var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
    var RosUnionMode = '<%HW_WEB_GetFeatureSupport(FT_ROS_UNION);%>';
    var gdgdWanName = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_EXCHANGE_NAME_WAN);%>';
    
    if ("AIS" == CfgModeWord.toUpperCase() && wan.Name != '') {
        return wan.Name;
    }
    if (showWanName == '1') {
        return wan.Name;
    }

    var keepWanDefaultNameList = ["TRIPLETAP", "TRIPLETAPNOGM", "TRIPLETAP6", "TRIPLETAP6PAIR", "CHILEWOM2", "ETB"];
    if ((keepWanDefaultNameList.indexOf(CfgModeWord.toUpperCase()) >= 0) && (wan.Name != '')) {
        return wan.Name;
    }

    if ((SingtelMode == '1') && (wan.Name != '')) {
        return wan.Name;
    }

    if (RosUnionMode == '1') {
        currentWanName = wan.Name;
    }

    if (IsCmProduct()) {
        return wan.Name;
    }

    if (wan.Name.indexOf("OLT") >= 0) {
        return MakeDefaultWanName(wan);
    }

    if (IsTDE2Mode == "1") {
        currentWanName = wan.Name;
        if (currentWanName == "") {
             currentWanName = "untag";
        }
        return currentWanName
    }

    if ("1" == Layer2Feature) {
        if (RosUnionMode == '1') {
            return currentWanName;
        } else {
            return MakeDefaultWanName(wan);
        }
    }

    if ('1' == IsPTVDFMode) {
        currentWanName = MakeWanNameForPTVDF(wan);
    } else if (CfgModeWord.toUpperCase() == "OTE") {
        currentWanName = MakeWanNameForOte(wan);
    }else if (CfgModeWord.toUpperCase() == "TURKCELL2") {
        currentWanName = MakeWanNameForTURKCELL(wan);
    } else if ("1" == CfgModePCCWHK) {
        currentWanName = MakeWanNameForPCCW(wan);
    } else if ('QTEL' == CurCfgModeWord.toUpperCase() || 'MTN2' == CurCfgModeWord.toUpperCase()) {
        currentWanName = MakeWanNameForQtelMTN(wan);
    } else if (("0" == CUVoiceFeature) && ('1' == IsCUMode)) {
        currentWanName = MakeDefaultWanName(wan);
    } else if ('E8C' == CurrentBin.toUpperCase() || "1" == CUVoiceFeature) {
        currentWanName = MakeWanNameForVoice(wan);
    } else if ((CurrentBin.toUpperCase() == 'A8C') && (CurCfgModeWord.toUpperCase() != "SCCT_FTTO")) {
       currentWanName = MakeWanNameForA8C(wan);
    } else if (IsXdProduct()) {
        if (RosUnionMode == '1') {
            currentWanName = currentWanName;
        } else {
            currentWanName = MakeDefaultWanNameForXD(wan);
        }
    } else {
        currentWanName = MakeDefaultWanName(wan);
    }

    if (CfgModeWord.toUpperCase() == "TELECENTRO") {
        currentWanName = MakeWanNameHiddenVlan(wan);
    }

    if (gdgdWanName == "1") {
        currentWanName = MakeGdgdWanName(wan);
    }

    return currentWanName;
}

function MakeWanName(wan) {
    return MakeWanName_New(wan);
}

function MakeWanName1(wan) {
    return MakeWanName_New(wan);
}

function MakeMegacableWanName(wan) {
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = '';

    wanInst = wan.MacId;
    wanServiceList = wan.ServiceList.toUpperCase();
    wanMode  = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
    vlanId = wan.VlanId;

    if (IsRadioWanSupported(wan) == true) {
        currentWanName = wanInst + "_" + RADIOWAN_NAMEPREFIX + "_" + wanServiceList + "_" + wanMode;
    } else {       
        currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode;
    }

    return currentWanName;
}

function MakeWanName_Megacable(wan) {
    var currentWanName = '';
    if (wan.Name.indexOf("OLT") >= 0) {
        return MakeMegacableWanName(wan);
    }
    currentWanName = MakeMegacableWanName(wan);
    return currentWanName;
}

function MakeWanNameForMC(wan) {
    return MakeWanName_Megacable(wan);
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

        if(IsVnpt()) {
            if(ArrayIndexOf(WanList, "wan1.7.ip1") < 0)
                WanList.push("wan1.7.ip1");

            if(ArrayIndexOf(WanList, "wan1.7.ppp1") < 0)
                WanList.push("wan1.7.ppp1");

            if(ArrayIndexOf(WanList, "wan1.8.ip1") < 0)
                WanList.push("wan1.8.ip1");

            if(ArrayIndexOf(WanList, "wan1.8.ppp1") < 0)
                WanList.push("wan1.8.ppp1");
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

var isNeedRefreshWanCache = function () {
    if (window.parent.wanCacheObj
        && window.parent.wanCacheObj.wanOptType === 0
        && window.parent.wanCacheObj.wanListCacheObj
        && JSON.stringify(window.parent.wanCacheObj.wanListCacheObj) !== '{}') {
        return false;
    }
    return true;
}

var wanListInit = (function() {
    var wanCacheObj = window.parent.wanCacheObj;
    if (isNeedRefreshWanCache()) {
        var result = ajaxGetAspData('/html/bbsp/common/wan_list_cache_wan.asp');
        IPWanList = result.IPWanList;
        PPPWanList = result.PPPWanList;
        unnumberdIPInfo = result.unnumberdIPInfo;
        if (window.parent.wanCacheObj) {
          window.parent.wanCacheObj.wanListCacheObj = result;
        }
      } else {
        var wanListCache = window.parent.wanCacheObj.wanListCacheObj;
        IPWanList = wanListCache.IPWanList;
        PPPWanList = wanListCache.PPPWanList;
        unnumberdIPInfo = wanListCache.unnumberdIPInfo;
    }

    if (window.parent.wanCacheObj) {
      window.parent.wanCacheObj.wanOptType = 0;
    }
})();

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
            
            if (isSupportLte == 1) {
                if (RadioWanBackup.length > 1) {
                    WanList[j].BackupMode = RadioWanBackup[0].BackupMode;
                    WanList[j].BackupDelayTime = RadioWanBackup[0].BackupDelayTime;
                }

                if (RadioWanProfile.length > 1) {
                    var profileInst = 0;
                    var radioWan = GetWanList()[j];
                    if (radioWan != null) {
                        profileInst = radioWan.X_HW_LteProfile;
                    }
                    for (var k = 0; k < RadioWanProfile.length; k++) {
                        var domainStr = RadioWanProfile[k].domain.substr(RadioWanProfile[k].domain.length-1, 1);
                        if (domainStr == profileInst) {
                            WanList[j].APN = RadioWanProfile[k].LteAPN;
                            break;
                        }
                    }
                    WanList[j].DialNumber = RadioWanProfile[0].LteDialNum;
                    WanList[j].RadioWanUsername = RadioWanProfile[0].LteUsername;
                    WanList[j].RadioWanPassword = RadioWanProfile[0].LtePassword;
                    WanList[j].RadioWanPSEnable = WanList[j].Enable;
                }
            }
        }
    }

    this.WanListOverlayAll = function(WanList) {
        this.WanListOverlay(WanList);
    }

    this.Validate = function() {
        timesRadio = setInterval("radioEvt()", 300);
    }

    this.IsInvalidRadioWan = function() {
        if (((this.RadioWanParaList.length == 1) && (this.RadioWanParaList.length < this.RadioWanPSList.length)) ||
            ((this.RadioWanPSList.length == 1) && (this.RadioWanParaList.length > this.RadioWanPSList.length))) {
            return true;
        }
        return false;
    }

    this.CompensateRadioWanCfg = function() {
        var requestUrl = "";
        var Onttoken = "<%HW_WEB_GetToken();%>";

        if ((this.RadioWanParaList.length == 1) && (this.RadioWanParaList.length < this.RadioWanPSList.length)) {
            requestUrl = 'InternetGatewayDevice.X_HW_RadioWanPS.1' + '=';
        }
        else if ((this.RadioWanPSList.length == 1) && (this.RadioWanParaList.length > this.RadioWanPSList.length)) {
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

function radioEvt() {
    $(".subRadioWan").trigger("evtRadioWan");
}

var Instance_RadioWan = new RadioWanLoader();

var RadioWanBackup = "";
var RadioWanProfile = "";

function getWanBackupInfo() {
    var xmlhttp = CreateXMLHttp();
    xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {
                RadioWanBackup = dealDataWithFun(xmlhttp.responseText);
            }
        }
    }
    xmlhttp.open('POST','/html/bbsp/common/ltebackupinfo.asp', false);
    xmlhttp.send(null); 
}

function getWanDialInfo() {
    var xmlhttp = CreateXMLHttp();
    xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {
                RadioWanProfile = dealDataWithFun(xmlhttp.responseText);
            }
        }
    }
    xmlhttp.open('POST','/html/bbsp/common/ltedialinfo.asp', false);
    xmlhttp.send(null); 
}

function GetRadioWanProfileArray()
{
    getWanDialInfo();
    return RadioWanProfile;
}

if (isSupportLte == 1) {
   getWanBackupInfo();
   getWanDialInfo();
}

var ProductType = '<%HW_WEB_GetProductType();%>';
function IsXdProduct()
{
    return '2'==ProductType;
}

function IsXdUpMode() {
    return '2' == ProductType && CurrentUpMode != 1;
}

function IsXdPonUpMode() {
    return '2' == ProductType && CurrentUpMode == 1;
}

function IsCmProduct()
{
    return '3'==ProductType;
}

function AccessTypeLoader() {
    this.DSLWanInstance = "";
    this.VDSLWanInstance = "";
    this.ETHWanInstance = "";
    this.SFPWanInstance = "";
    this.UMTSWanInstance = "";
    this.PonWanInstance = 6;

    this.AccessTypeList = [];

    this.Validate = function() {
        for(var i = 0; i < this.AccessTypeList.length - 1; i++) {
            if(this.AccessTypeList[i].WANAccessType == "DSL") {
                this.DSLWanInstance = this.AccessTypeList[i].domain.split(".")[2];
            } else if(this.AccessTypeList[i].WANAccessType == "VDSL") {
                this.VDSLWanInstance = this.AccessTypeList[i].domain.split(".")[2];
            } else if(this.AccessTypeList[i].WANAccessType == "Ethernet") {
                this.ETHWanInstance = this.AccessTypeList[i].domain.split(".")[2];
            } else if(this.AccessTypeList[i].WANAccessType == "SFP") {
                this.SFPWanInstance = this.AccessTypeList[i].domain.split(".")[2];
            } else if(this.AccessTypeList[i].WANAccessType == "UMTS") {
                this.UMTSWanInstance = this.AccessTypeList[i].domain.split(".")[2];
            } else if( "PON" == this.AccessTypeList[i].WANAccessType ) {
                this.PonWanInstance = this.AccessTypeList[i].domain.split(".")[2];
            }
        }

        if ((this.UMTSWanInstance == "") && (IsXdProduct() || isSupportLte == "1")) {
            var DEFAULT_WAN_DEVICE_INST = 1;
            this.UMTSWanInstance = DEFAULT_WAN_DEVICE_INST;
        }

        $(".subWANAccessType").trigger("evtWANAccessType");
    }

    $.ajax({
        context : this,
        type : "GET",
        async : false,
        cache : false,
        timeout : 10000,
        url : "/html/bbsp/common/get_wan_list_wanaccesstype.asp",
        success : function(data) {
            this.AccessTypeList = dealDataWithFun(data);
            this.Validate();
        }
    });

    this.GetWanInstByWanAceesstype = function(wanAccesstype) {
        if(wanAccesstype == "DSL") {
            return this.DSLWanInstance;
        } else if(wanAccesstype == "VDSL") {
            return this.VDSLWanInstance;
        } else if(wanAccesstype == "Ethernet") {
            return this.ETHWanInstance;
        } else if(wanAccesstype == "SFP") {
            return this.SFPWanInstance;
        } else if(wanAccesstype == "UMTS") {
            return this.UMTSWanInstance;
        } else if( "PON" == wanAccesstype ) {
            return this.PonWanInstance;
        }
        return 1;
    }

    this.GetWanAceesstypeByWanInst = function(Inst) {
        if(Inst == this.DSLWanInstance) {
            return "DSL" ;
        } else if(Inst == this.VDSLWanInstance) {
            return "VDSL";
        } else if(Inst == this.ETHWanInstance) {
            return "Ethernet";
        } else if((Inst == this.SFPWanInstance) && (isSupportSFP == 1)) {
            return "SFP";
        } else if(Inst == this.UMTSWanInstance) {
            return "UMTS";
        } else if(this.PonWanInstance == Inst ) {
            return "PON";
        }
        return null;
    }
}

Instance_AccessType = new AccessTypeLoader();

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
        if (GetWanList()[i].domain.split(".")[2] == Instance_AccessType.ETHWanInstance) {
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

function GetPonIsInUsedWANConnectionDeviceInst(Wan) {
    for (var i = 0; i < GetWanList().length; i++) {
        if (GetWanList()[i].domain.split(".")[2] == "6") {
            return GetWanList()[i].domain.split(".")[4];
        }
    }

    return null;
}

function TranslateRadioWanProfile(profileInst) 
{
    var DEFAULT_PROFILE_INDEX = 0;
    
    if (RadioWanProfile == null) {
        return DEFAULT_PROFILE_INDEX;
    }
    
    var PROFILE_DOMAIN = "InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Profile." + profileInst; 
    for (var i = 0; i < (RadioWanProfile.length - 1); i++) {
        if (RadioWanProfile[i] == null) {
            continue;
        }
        
        if (RadioWanProfile[i].domain == PROFILE_DOMAIN) {
            return i;
        }
    }
    
    return DEFAULT_PROFILE_INDEX;
}

var refreshWanInfo = function(refreshFlag) {
  for(i = 0, j = 0;IPWanList.length > 0 && i < IPWanList.length -1; i++, j++) {
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

    if ((true == IsRadioWanSupported(IPWanList[i])) && (true == Instance_RadioWan.IsInvalidRadioWan())) {
        j--;
        CompensateRadioWanCfg();
        continue;
    }
   if (!refreshFlag) {
     WanList[j] = new WanInfoInst();
   }
    ConvertIPWan(IPWanList[i], WanList[j]);
    WanList[j].Name = MakeWanName_New(WanList[j]);
  }

  for( i= 0; PPPWanList.length > 0 && i < PPPWanList.length - 1; j++,i++) {
      if("1" == PPPWanList[i].Tr069Flag || Instance_IspWlan.IsWanMustHidden(domainTowanname(PPPWanList[i].domain)) == true && ('JSCMCC' != CfgModeWord.toUpperCase() || PPPWanList[i].VlanId != 4031 || curUserType != 0)) {
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
  
      if ((true == IsRadioWanSupported(PPPWanList[i])) && (true == Instance_RadioWan.IsInvalidRadioWan())) {
          j--;
          CompensateRadioWanCfg();
          continue;
      }
      if (!refreshFlag) {
        WanList[j] = new WanInfoInst();
      }

      ConvertPPPWan(PPPWanList[i], WanList[j]);
      WanList[j].Name = MakeWanName_New(WanList[j]);
      
      if (unnumberdIPInfo.length > 1) {
          WanList[j].EnableUnnumbered = unnumberdIPInfo[i].Enable;
          WanList[j].UnnumberedIpAddress = unnumberdIPInfo[i].IPAddress;
          WanList[j].UnnumberedSubnetMask = unnumberdIPInfo[i].SubnetMask;
      }
  }
  WanList.sort(
    function (wan1, wan2) {
        var cmp = 0;

        if (parseInt(wan1.MacId) > parseInt(wan2.MacId)) {
            cmp = 1;
        } else if (parseInt(wan1.MacId) < parseInt(wan2.MacId)) {
            cmp = -1;
        } else {
            cmp = 0;
        }

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
        clearInterval(timesRadio);
        Instance_RadioWan.WanListOverlayAll(WanList);
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

    if(DnsServer == null || DnsServer=="") {
        return null;
    }

    return DnsServer.DNSServer;
}


try
{
    for (var i = 0; i < WanList.length; i++)
    {
        var DnsServer = GetIPv6WanDNS(WanList[i].domain);

        if (DnsServer == null)
        {
            continue;
        }

        var DnsServerList = DnsServer.split(",");
        if (DnsServerList == null)
        {
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
        } catch(e) {}
    }
}

function filterXDWanList() {
    var result = [];
    for (var i = 0; i < WanList.length; i++) {
        var wan = WanList[i];
        if (wan.WanAccessType != "PON") {
            result.push(wan);
        }
    }
    return result;
}

function filterPonWanList() {
    var result = [];
    for (var i = 0; i < WanList.length; i++) {
        var wan = WanList[i];
        if (wan.WanAccessType == "PON") {
            result.push(wan);
        }
    }
    return result;
}

function filterWanListByUpMode() {
    var localWanList = null;
    if (CurrentUpMode == 3) {
        localWanList = WanList;
    } else if (CurrentUpMode == 1) {
        localWanList = filterPonWanList();
    }
    return localWanList;
}

function dbaa1FilterWanList(wanList) {
    if (curUserType != '1') {
        return wanList;
    }
    for (var i = wanList.length - 1; i >= 0; i--) {
        if (dbaa1FilterWan(wanList[i]) == false) {
            wanList.splice(i, 1);
        }
    }
    return wanList;
}

function FilterWanListSkipDslWan()
{
    var curWanList = [];
    for (var i = 0; i < WanList.length; i++) {
        var wan = WanList[i];
        if ((wan.WanAccessType == "DSL") || (wan.WanAccessType == "VDSL")) {
            continue;
        }
        curWanList.push(wan);
    }
    return curWanList;
}

function GetWanList() {
    if ((CurCfgModeWord.toUpperCase() == "DETHMAXIS") && (isDSLSupport == "0")) {
        return FilterWanListSkipDslWan();
    }
    if (xdPonSupport == 1) {
        return filterWanListByUpMode();
    }
    if (DBAA1 == "1") {
        return dbaa1FilterWanList(WanList);
    }
    return WanList;
}

function GetWanListLength() {
    return WanList.length;
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

function InitWanNameListControlForMC(WanListControlId, IsThisWanOkFunction) {
    var Control = getElById(WanListControlId);
    var WanList = GetWanListByFilter(IsThisWanOkFunction);
    var i = 0;

    for (i = 0; i < WanList.length; i++) {
        var Option = document.createElement("Option");
        Option.value = WanList[i].domain;
        Option.innerText = MakeWanNameForMC(WanList[i]);
        Option.text = MakeWanNameForMC(WanList[i]);
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
        if (WanList[i].NewName == WanName)
        {
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

function PS_GetCmdFormat(type, dev, protocal, start, end) {
    var cmd = type
              + "/" + dev
              + "/" + (("TCP/UDP" == protocal.toUpperCase())?"tcpudp":protocal)
              + "/" + start
              + "/" + (((end.length == 0) || (parseInt(end, 10) == 0))? 1:(parseInt(end, 10) - parseInt(start, 10) + 1));

    return cmd.toLowerCase();
}

function PS_CheckReservePort(Operation, NewPort, OldPOrt) {
    var conflict = false;
    var Onttoken = "<%HW_WEB_GetToken();%>";
    $.ajax({
        type  : "POST",
        async : false,
        cache : false,
        data  : "act=" + Operation+ "&new=" + NewPort + "&old=" + OldPOrt +'&x.X_HW_Token=' + Onttoken,
        url   : "pdtportcheck",
        success : function(data) {
            conflict = true;
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            conflict = false;
        },
        complete: function (XHR, TS) {
            XHR = null;
      }
    });

    return conflict;
}

function ParseUsernameForIraq(userName) {
    var viewusrnm = '';
    var temp;
    var viewUserName = userName;

    if( false == IsAdminUser() ) {
        var postFix = "@o3-telecom.com";

        if(userName.indexOf(postFix) >= 0) {
            if (userName.substring(userName.length - postFix.length) == postFix) {
                viewUserName =  userName.substring(0, userName.length - postFix.length);

            }
        }
    }
    return viewUserName;
}

function ParseUsernameFortedata(userName) {
    var viewusrnm = '';
    var temp;
    var viewUserName = userName;

    var postFix = "@tedata.net.eg";

    if (userName.indexOf(postFix) >= 0) {
        if (userName.substring(userName.length - postFix.length) == postFix) {
            viewUserName =  userName.substring(0, userName.length - postFix.length);
        }
    }
    return viewUserName;
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
    for (var i = 0; i < WanList.length;i++)  {
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

function IsDefaultLteWan(wanPath) {
    if (isSupportLte != 1) {
        return false;
    }

    if (CurCfgModeWord.toUpperCase() == 'COMMON') {
        return false;
    }

    for (var i = 0; i < IPWanList.length - 1; i++) {
        if ((wanPath.toUpperCase() == IPWanList[i].domain.toUpperCase()) && (IPWanList[i].X_HW_LteProfile == 1)) {
            return true;
        }
    }

    return false;
}
