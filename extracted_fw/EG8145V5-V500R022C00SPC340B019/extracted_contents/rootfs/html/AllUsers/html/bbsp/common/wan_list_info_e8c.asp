var SupportIPv6 = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>";
var supportTelmex = "0";
var SetIdleDisconnectMode = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PPPOE_DETECTUPSTREAM);%>";
var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var RdFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6_6RD);%>";
var RadioWanFeature = "0";
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var radio_hidepassword=",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var IsSupportVoice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var SingtelModeEX = '0';
var ROSTelecomFeature = '0';
var ProductType = '<%HW_WEB_GetProductType();%>';
var IsDSLSURPPORT   = '0';
var isSupportVLAN0 = '0';
var vxlanfeature = <%HW_WEB_GetFeatureSupport("FT_VXLAN");%>;

var IsCMCC = '<%HW_WEB_GetFeatureSupport(HW_BBSP_FT_CMCC_RMS);%>';
var IsJSCT = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_JSCT);%>';
var IsCTCOM = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_CTCOM);%>';
var IsCU = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_CU);%>';
var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
var wanPPOEPassword = '<%HW_WEB_GetSPEC(SPEC_WAN_PPPOE_PASSWORD.STRING);%>';
var supportOnuBind = "<%HW_WEB_GetFeatureSupport(FT_ONU_VLAN_WAN_CFG);%>";

function Is3TMode() {
    if ((IsCMCC == '1') || (IsJSCT == '1') || (IsCTCOM == '1') || (IsCU == '1')) {
        return true;
    }
    return false;
}

function IsCmcc_rmsMode() {
    if (Custom_cmcc_rms == '1') {
        return true;
    }
    return false;

}

function stAuthState(AuthState)
{
    this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>;
var SimIsAuth=SimConnStates[0].AuthState;
var JsctSpecVlan='<%HW_WEB_GetSPEC(BBSP_SPEC_FILTERWAN_BYVLAN.STRING);%>';

function GetWebConfigRGEnable() {
    var WebConfigRGEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPWebCustomization.WebConfigRGEnable,DB);%>';

    switch(WebConfigRGEnable) {
        case '0':
        case '1':
            return WebConfigRGEnable;
        default:
            return '0';
    }
}

var FtWebRgEn = "<% HW_WEB_GetFeatureSupport(BBSP_FT_WEB_CFG_RG_EN_VALID);%>";
var FtBin5Enhanced = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BIN5_ENHANCED);%>";

var IsSupportBridgeWan = "<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>";

function IsE8cOrCMCC_RMS() {
    if((CurrentBin.toUpperCase() == 'E8C') || (IsCmcc_rmsMode())) {
        return true;
    }
    return false;
}

function IsSCCT() {
    return (CfgModeWord.toUpperCase() == 'SCCT');
}

function filterWanByFeature(WanItem) {
    var filterWanFeater = "<%HW_WEB_GetFeatureSupport(FT_NORMAL_ONLY_SHOW_PPPOE_INFO);%>";

    if ((filterWanFeater == '1') && (curUserType != '0') && (IsLanUpCanOper() == false) &&
        !(WanItem.EncapMode.toUpperCase() == "PPPOE" && WanItem.Mode == "IP_Routed")) {
        return false;
    }

    return true;
}

function filterWanOnlyTr069(WanItem) {
    if ((SimIsAuth == "0") && (WanItem.ServiceList.indexOf("TR069") < 0)) {
        return false;
    }
    return true;
}

function filterWanByVlan(WanItem) {
    if (WanItem.VlanId == parseInt(JsctSpecVlan) && curUserType != 0)  {
        return false;
    }
    return true;
}

function Is6RdSupported() {
    return false;
}

function IsRadioWanSupported(wan) {
    return false;
}

function WanInfoInst() {
    this.domain  = null;

    this.RealName     = "";
    this.ConnectionTrigger = "";
    this.ConnectionControl = "";
    this.MACAddress   = "";
    this.Status       = "";
    this.LastConnErr  = "";
    this.Enable       = "1";
    this.RemoteWanInfo = "";
    this.Name         = "";
    this.NewName       = "";
    this.EncapMode    = "IPoE";
    this.ProtocolType = "IPv4";
    this.IPv4Enable   = "1";
    this.IPv6Enable   = "0";
    this.Mode         = "IP_Routed";
    this.ServiceList  = "INTERNET";
    if (IsSupportBridgeWan == 1) {
        this.ServiceList  = "TR069";
    }
    if(vxlanfeature == 1) {
        this.X_HW_VXLAN_Enable = "0";
    }
    this.X_HW_OperateDisable = "0";
    this.EnableVlan   = "1";
    this.VlanId       = "";
    this.PriorityPolicy = "Specified";
    this.DefaultPriority   = "0";
    this.Priority     = "0";
    this.UserName     = "iadtest@pppoe";
    this.Password     = wanPPOEPassword;
    this.X_HW_BridgeEnable = "";
    this.LcpEchoReqCheck = "0";
    this.PPPoEACName  = "";
    this.MacId        = "0";

    this.IPv4AddressMode   = "DHCP";
    this.IPv4MXU           = "";
    this.IPv4NATEnable     = "1";
    this.X_HW_NPTv6Enable  = "0";
    this.NatType = "0";
    this.IPv4VendorId      = "";
    this.IPv4ClientId      = "";

    this.IPv4IPAddress    = "";
    this.IPv4SubnetMask   = "";
    this.IPv4IPAddressSecond = "";
    this.IPv4SubnetMaskSecond = "";
    this.IPv4IPAddressThird = "";
    this.IPv4SubnetMaskThird = "";
    this.IPv4Gateway      = "";
    this.IPv4PrimaryDNS   = "";
    this.IPv4SecondaryDNS = "";

    this.DHCPLeaseTime = "0";
    this.DHCPLeaseTimeRemaining = "0";
    this.NTPServer = "";
    this.TimeZoneInfo = "";
    this.SIPServer = "";
    this.StaticRouteInfo = "";
    this.VendorInfo = "";

    this.IPv4DialMode     = "AlwaysOn";
    if(true == IsSCCT()) {
        this.IPv4DialIdleTime = "1800";
    } else {
        this.IPv4DialIdleTime = "180";
    }
    this.IPv4IdleDisconnectMode = "";
    this.IPv4PPPoEAccountEnable = "disable";
    this.IPv4WanMVlanId   = "";
    this.IPv4BindLanList  = new Array();
    this.IPv4BindSsidList  = new Array();
    this.IPv4BindOnuList  = new Array();
    this.EnableLanDhcp   = "1";
    this.DstIPForwardingList   = "";
    this.IPv4v6WanMVlanId   = "";

    this.IPv6PrefixMode   = "PrefixDelegation";
    this.IPv6AddressStuff = "";
    this.IPv6AddressMode  = "AutoConfigured";
    this.X_HW_E8C_IPv6PrefixDelegationEnabled = "1";
    this.X_HW_UnnumberedModel = "0";
    this.X_HW_TDE_IPv6AddressingType = "SLAAC";
    this.X_HW_DHCPv6ForAddress  = "0";
    this.IPv6StaticPrefix = "";
    this.IPv6ReserveAddress = "";
    this.IPv6IPAddress    = "";
    this.IPv6AddrMaskLenE8c    = "64";
    this.IPv6GatewayE8c    = "";
    this.IPv6SubnetMask   = "";
    this.IPv6Gateway      = "";
    this.IPv6PrimaryDNS   = "";
    this.IPv6SecondaryDNS = "";
    this.IPv6WanMVlanId   = "";

    this.IPv6DSLite         = "Off";
    this.EnableDSLite       = "0";
    this.IPv6AFTRName       = "";
    this.EnablePrefix       = "1";

    this.Enable6Rd = "0";
    this.RdMode = "Off";
    this.RdPrefix = "";
    this.RdPrefixLen = "";
    this.RdBRIPv4Address = "";
    this.RdIPv4MaskLen = "";

    this.RadioWanPSEnable = "1";
    this.AccessType = "1";
    this.SwitchMode = "Auto";
    this.SwitchDelayTime = "30";
    this.PingIPAddress = "";

    this.RadioWanUsername = "";
    this.RadioWanPassword = radio_hidepassword;
    this.APN = "";
    this.DialNumber = "";
    this.TriggerMode = "AlwaysOn";
    this.Uptime = 0;
    this.IPv4DNSOverrideSwitch = "0";
    this.X_HW_LowerLayers = "";
    this.EnableOption60 = "0";
    this.X_HW_IPoEName ="";
    this.X_HW_IPoEPassword= "";
    this.IPv4EnableMulticast= "1";
    this.X_HW_DscpToPbitTbl= "";
    this.BytesSent          = "";
    this.BytesReceived      = "";
    this.PacketsSent        = "";
    this.PacketsReceived    = "";
    this.UnicastSent        = "";
    this.UnicastReceived    = "";
    this.MulticastSent      = "";
    this.MulticastReceived  = "";
    this.BroadcastSent      = "";
    this.BroadcastReceived  = "";
    this.X_HW_SpeedLimit_UP  = "";
    this.X_HW_SpeedLimit_DOWN  = "";
    this.X_HW_IGMPEnable    = "0";
    this.X_HW_PingResponseEnable    = "0";
    this.X_HW_PingResponseWhiteList    = "";
}

function GetIpWan6RDTunnelInfo(domain,Enable,RdMode,RdPrefix,RdPrefixLen, RdBRIPv4Address,RdIPv4MaskLen) {
    this.domain = domain;
    this.Enable6Rd = Enable;
    this.RdMode = RdMode;
    this.RdPrefix = RdPrefix;
    this.RdPrefixLen = RdPrefixLen;
    this.RdBRIPv4Address = RdBRIPv4Address;
    this.RdIPv4MaskLen = RdIPv4MaskLen;

}

function GetPppWan6RDTunnelInfo(domain,Enable,RdPrefix,RdPrefixLen, RdBRIPv4Address,RdIPv4MaskLen) {
    this.domain = domain;
    this.Enable6Rd = Enable;
    this.RdPrefix = RdPrefix;
    this.RdPrefixLen = RdPrefixLen;
    this.RdBRIPv4Address = RdBRIPv4Address;
    this.RdIPv4MaskLen = RdIPv4MaskLen;
}

function DsLiteInfo(domain, WorkMode, AFTRName) {
    this.domain = domain;
    this.WorkMode = WorkMode;
    this.AFTRName = AFTRName;
}

function WaninfoStats(domain, BytesSent, BytesReceived, PacketsSent, PacketsReceived,UnicastSent,UnicastReceived,MulticastSent,MulticastReceived,BroadcastSent,BroadcastReceived) {
    this.domain             = domain;
    this.BytesSent          = BytesSent;
    this.BytesReceived      = BytesReceived;
    this.PacketsSent        = PacketsSent;
    this.PacketsReceived    = PacketsReceived;
    this.UnicastSent        = UnicastSent;
    this.UnicastReceived    = UnicastReceived;
    this.MulticastSent      = MulticastSent;
    this.MulticastReceived  = MulticastReceived;
    this.BroadcastSent      = BroadcastSent;
    this.BroadcastReceived  = BroadcastReceived;
}

WanInfoInst.prototype.clone = function() {
    var newObj = new WanInfoInst();
    for(emplement in this)
    {
        newObj[emplement] = this[emplement];
    }
    return newObj;
}

function GetProtocolType(IPv4Enable, IPv6Enable) {
    if (IPv4Enable == "1" && IPv6Enable == "1") {
        return "IPv4/IPv6";
    }
    if (IPv4Enable == "1") {
        return "IPv4";
    }
    return "IPv6"
}

function WanIP(domain, X_HW_VXLAN_Enable, X_HW_OperateDisable,ConnectionTrigger, MACAddress, Status, LastConnErr, RemoteWanInfo, Name, Enable, EnableLanDhcp,
               DstIPForwardingList, ConnectionStatus, Mode, IPMode, IPAddress, SubnetMask, Gateway, NATEnable,
               X_HW_NatType, dnsstr, VlanId, MultiVlanID, Pri8021, VenderClassID, ClientID, ServiceList, ExServiceList,
               Tr069Flag, MacId, IPv4Enable, IPv6Enable, IPv6MultiCastVlan, PriPolicy, DefaultPri, MaxMTUSize,
               DHCPLeaseTime, NTPServer, TimeZoneInfo, SIPServer, StaticRouteInfo, VendorInfo, DHCPLeaseTimeRemaining,
               Uptime, DNSOverrideAllowed, X_HW_LowerLayers,  X_HW_IPoEName, X_HW_IPoEPassword, X_HW_IGMPEnable,
               X_HW_DscpToPbitTbl, IPv4IPAddressSecond, IPv4SubnetMaskSecond, IPv4IPAddressThird, IPv4SubnetMaskThird,
               X_HW_NPTv6Enable, X_HW_SpeedLimit_UP, X_HW_SpeedLimit_DOWN, X_HW_LteProfile, X_HW_PingResponseEnable, X_HW_PingResponseWhiteList)
{
    this.domain     = domain;
    this.Uptime = Uptime;
    this.ConnectionTrigger = ConnectionTrigger;
    this.MACAddress = MACAddress;
    this.Status = Status;
    this.LastConnErr  = LastConnErr;
    this.RemoteWanInfo = RemoteWanInfo;
    this.Name         = Name;
    this.NewName   =  domainTowanname(domain);
    this.Enable        = Enable;
    this.EnableLanDhcp = EnableLanDhcp;
    this.DstIPForwardingList   = DstIPForwardingList;
    this.ConnectionStatus = ConnectionStatus;
    this.X_HW_VXLAN_Enable = X_HW_VXLAN_Enable;
    this.X_HW_OperateDisable = X_HW_OperateDisable;

    this.Mode        = Mode;
    this.IPMode        = IPMode;

    this.IPAddress    = IPAddress;
    this.SubnetMask = SubnetMask;
    this.Gateway    = Gateway;

    this.NATEnable = NATEnable;
    this.X_HW_NatType = X_HW_NatType;

    var dnss         = dnsstr.split(',');
    this.PrimaryDNS     = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";
    this.VlanId   = VlanId;

    this.MultiVlanID=(MultiVlanID > 4094 )?"":MultiVlanID;
    this.IPv6MultiVlanID=(IPv6MultiCastVlan > 4094 ) ? "":IPv6MultiCastVlan;

    if (PriPolicy.toUpperCase() == "SPECIFIED") {
        this.PriorityPolicy = "Specified";
    } else if (PriPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE") {
        this.PriorityPolicy = "CopyFromIPPrecedence";
    } else {
        this.PriorityPolicy = "DscpToPbit";
    }
    this.DefaultPriority = DefaultPri;
    this.Pri8021  =  Pri8021;
    this.VenderClassID = VenderClassID;
    this.ClientID = ClientID;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();

    this.isPPPoEAccountEnable = "disable";
    this.Tr069Flag = Tr069Flag;
    this.MacId = MacId;

    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (0 == SupportIPv6) {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }

    this.DHCPLeaseTime = DHCPLeaseTime;
    this.DHCPLeaseTimeRemaining = DHCPLeaseTimeRemaining;
    this.NTPServer = NTPServer;
    this.TimeZoneInfo = TimeZoneInfo;
    this.SIPServer = SIPServer;
    this.StaticRouteInfo = StaticRouteInfo;
    this.VendorInfo = VendorInfo;

    if(0 == MaxMTUSize) {
        this.IPv4MXU = 1500;
    } else {
        this.IPv4MXU = MaxMTUSize;
    }
    this.DNSOverrideAllowed = DNSOverrideAllowed;
    this.X_HW_LowerLayers = X_HW_LowerLayers;
    this.X_HW_IPoEName = X_HW_IPoEName;
    this.X_HW_IPoEPassword = X_HW_IPoEPassword;
    this.IPv4EnableMulticast = X_HW_IGMPEnable;
    this.X_HW_DscpToPbitTbl = X_HW_DscpToPbitTbl;
    this.IPv4IPAddressSecond = IPv4IPAddressSecond;
    this.IPv4SubnetMaskSecond = IPv4SubnetMaskSecond;
    this.IPv4IPAddressThird = IPv4IPAddressThird;
    this.IPv4SubnetMaskThird = IPv4SubnetMaskThird;
    this.X_HW_NPTv6Enable = X_HW_NPTv6Enable;
    this.X_HW_SpeedLimit_UP = X_HW_SpeedLimit_UP;
    this.X_HW_SpeedLimit_DOWN = X_HW_SpeedLimit_DOWN;
    this.X_HW_IGMPEnable = X_HW_IGMPEnable;
    this.X_HW_PingResponseEnable = X_HW_PingResponseEnable;
    this.X_HW_PingResponseWhiteList = X_HW_PingResponseWhiteList;
}

function WanPPP(domain, X_HW_VXLAN_Enable, X_HW_OperateDisable, ConnectionTrigger, MACAddress, Status, LastConnErr, RemoteWanInfo, Name,Enable,EnableLanDhcp,
                DstIPForwardingList, ConnectionStatus, Mode, IPAddress, Gateway, NATEnable, X_HW_NatType, dnsstr,
                Username, Password, DialMode, ConnectionControl, VlanId, MultiVlanID, Pri8021, LcpEchoReqCheck,
                ServiceList, ExServiceList, Tr069Flag, IdleDisconnectTime, MacId, IPv4Enable, IPv6Enable, IPv6MultiCastVlan,
                PriPolicy, DefaultPri, MaxMRUSize, PPPoEACName,X_HW_IdleDetectMode, Uptime, DNSOverrideAllowed,
                X_HW_LowerLayers, PPPoESessionID, X_HW_IGMPEnable, StaticRouteInfo, X_HW_DscpToPbitTbl, Hurl, Motm,
                X_HW_BridgeEnable, X_HW_NPTv6Enable, X_HW_SpeedLimit_UP, X_HW_SpeedLimit_DOWN, X_HW_PingResponseEnable, X_HW_PingResponseWhiteList) {
    this.domain            = domain;
    this.ConnectionTrigger = ConnectionTrigger;
    this.Uptime = Uptime;
    this.X_HW_VXLAN_Enable = X_HW_VXLAN_Enable;
    this.X_HW_OperateDisable = X_HW_OperateDisable;

    if (parseInt(ConnectionControl, 10) == 0xFFFFFFFF) {
        this.ConnectionControl = 0;
    } else {
        this.ConnectionControl = ConnectionControl;
    }

    this.MACAddress = MACAddress;

    if ((Status.toUpperCase() == "CONNECTING") && (this.ConnectionControl == "0") && (ConnectionTrigger == "Manual")) {
        this.Status = "Disconnected";
    } else {
        this.Status = Status;
    }

    this.LastConnErr  = LastConnErr;
    this.RemoteWanInfo = RemoteWanInfo;
    this.Name          = Name;
    this.NewName      = domainTowanname(domain);
    this.Enable        = Enable;
    this.EnableLanDhcp = EnableLanDhcp;
    this.DstIPForwardingList   = DstIPForwardingList;
    this.ConnectionStatus = ConnectionStatus;

    this.Mode        = Mode;
    this.IPMode        = 'PPPoE';
    this.IPAddress    = IPAddress;
    this.SubnetMask    = '255.255.255.255';
    this.Gateway        = Gateway;
    this.NATEnable     = NATEnable;
    this.X_HW_NatType = X_HW_NatType;
    var dnss         = dnsstr.split(',');
    this.PrimaryDNS    = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";

    this.Username = Username;
    this.Password = Password;

    this.LcpEchoReqCheck = LcpEchoReqCheck;
    this.DialMode = DialMode;
    this.VlanId    = VlanId;
    this.MultiVlanID=(MultiVlanID > 4094 )?"":MultiVlanID;
    this.IPv6MultiVlanID=(IPv6MultiCastVlan > 4094 ) ? "":IPv6MultiCastVlan;

    if (PriPolicy.toUpperCase() == "SPECIFIED") {
        this.PriorityPolicy = "Specified";
    } else if (PriPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE") {
        this.PriorityPolicy = "CopyFromIPPrecedence";
    } else {
        this.PriorityPolicy = "DscpToPbit";
    }
    this.DefaultPriority = DefaultPri;
    this.Pri8021  =  Pri8021;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();

    this.IdleDisconnectTime = IdleDisconnectTime;
    this.IPv4IdleDisconnectMode = X_HW_IdleDetectMode;
    this.Tr069Flag = Tr069Flag;
    this.MacId = MacId;

    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (SupportIPv6 == '0') {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }

    this.PPPoEACName = PPPoEACName;
    if (MaxMRUSize == 0) {
        this.IPv4MXU = 1492;
    } else {
        this.IPv4MXU = MaxMRUSize;
    }

    this.DNSOverrideAllowed = DNSOverrideAllowed;
    this.X_HW_LowerLayers = X_HW_LowerLayers;
    this.PPoESessionID = PPPoESessionID;
    this.IPv4EnableMulticast = X_HW_IGMPEnable;
    this.StaticRouteInfo = StaticRouteInfo;
    this.X_HW_DscpToPbitTbl = X_HW_DscpToPbitTbl;
    this.Hurl = Hurl;
    this.Motm = Motm;
    this.X_HW_BridgeEnable = X_HW_BridgeEnable;
    this.X_HW_NPTv6Enable = X_HW_NPTv6Enable;
    this.X_HW_SpeedLimit_UP = X_HW_SpeedLimit_UP;
    this.X_HW_SpeedLimit_DOWN = X_HW_SpeedLimit_DOWN;
    this.X_HW_IGMPEnable = X_HW_IGMPEnable;
    this.X_HW_PingResponseEnable = X_HW_PingResponseEnable;
    this.X_HW_PingResponseWhiteList = X_HW_PingResponseWhiteList;

    if ((CfgModeWord.toUpperCase() == "SCCT") && (this.ServiceList == "OTHER")) {
        this.MultiVlanID = (MultiVlanID > 4094) ? "-1" : MultiVlanID;
    }
}


function AtmLinkConfig(domain, LinkType, DestinationAddress, ATMEncapsulation, ATMQoS, ATMPeakCellRate, ATMMaximumBurstSize, ATMSustainableCellRate) {
    this.domain      = domain;
    this.LinkType    = LinkType;
    this.DestinationAddress   = DestinationAddress;
    this.ATMEncapsulation       = ATMEncapsulation;
    this.ATMQoS               = ATMQoS;
    this.ATMPeakCellRate      = ATMPeakCellRate;
    this.ATMMaximumBurstSize  = ATMMaximumBurstSize;
    this.ATMSustainableCellRate = ATMSustainableCellRate;
}

function LinkConfig(domain, LinkType, DestinationAddress, ATMEncapsulation, ATMQoS, ATMPeakCellRate, ATMMaximumBurstSize, ATMSustainableCellRate) {
    this.domain      = domain;
    this.LinkType    = LinkType;
    this.DestinationAddress   = DestinationAddress;
    this.ATMEncapsulation       = ATMEncapsulation;
    this.ATMQoS               = ATMQoS;
    this.ATMPeakCellRate      = ATMPeakCellRate;
    this.ATMMaximumBurstSize  = ATMMaximumBurstSize;
    this.ATMSustainableCellRate = ATMSustainableCellRate;
}

function ConvertIPWan(IPWan, CommonWanInfo) {
    CommonWanInfo.domain  = IPWan.domain;

    CommonWanInfo.RealName     = IPWan.Name;
    CommonWanInfo.ConnectionTrigger = IPWan.ConnectionTrigger
    CommonWanInfo.MACAddress   = IPWan.MACAddress;
    CommonWanInfo.Status       = IPWan.Status;
    CommonWanInfo.LastConnErr  = IPWan.LastConnErr;
    CommonWanInfo.Enable       = IPWan.Enable;
    CommonWanInfo.EnableLanDhcp   = IPWan.EnableLanDhcp;
    CommonWanInfo.DstIPForwardingList   = IPWan.DstIPForwardingList;
    CommonWanInfo.RemoteWanInfo = IPWan.RemoteWanInfo;
    CommonWanInfo.Name         = IPWan.Name;
    CommonWanInfo.NewName      = IPWan.NewName;
    CommonWanInfo.ProtocolType = GetProtocolType(IPWan.IPv4Enable, IPWan.IPv6Enable);
    CommonWanInfo.IPv4Enable   = IPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable   = IPWan.IPv6Enable;
    CommonWanInfo.EncapMode    = "IPoE";
    CommonWanInfo.Mode         = IPWan.Mode;
    CommonWanInfo.ServiceList  = IPWan.ServiceList.toUpperCase();
    CommonWanInfo.EnableVlan   = (IPWan.VlanId == "0") ? "0" : "1";
    if (1 == isSupportVLAN0) {
        CommonWanInfo.EnableVlan = (IPWan.VlanId == "4095") ? "0" : "1";
    }
    
    CommonWanInfo.VlanId       = IPWan.VlanId;
    CommonWanInfo.PriorityPolicy  = IPWan.PriorityPolicy;
    CommonWanInfo.DefaultPriority = IPWan.DefaultPriority;
    CommonWanInfo.Priority     = IPWan.Pri8021;
    CommonWanInfo.Tr069Flag    = IPWan.Tr069Flag;
    CommonWanInfo.UserName     = "iadtest@pppoe";
    CommonWanInfo.Password     = wanPPOEPassword;

    CommonWanInfo.LcpEchoReqCheck  = "0";
    CommonWanInfo.MacId        = IPWan.MacId;

    switch (IPWan.IPMode.toString().toUpperCase()) {
        case 'STATIC':
            CommonWanInfo.IPv4AddressMode = 'Static';
            break;
        case 'DHCP':
            CommonWanInfo.IPv4AddressMode = 'DHCP';
            break;
        case 'AUTO':
            CommonWanInfo.IPv4AddressMode = 'Auto';
            break;
        default:
            break;
    }
    CommonWanInfo.IPv4MXU           = IPWan.IPv4MXU;
    CommonWanInfo.IPv4NATEnable     = IPWan.NATEnable;
    CommonWanInfo.NatType     = IPWan.X_HW_NatType;
    CommonWanInfo.IPv4VendorId      = IPWan.VenderClassID;
    CommonWanInfo.IPv4ClientId      = IPWan.ClientID;

    CommonWanInfo.IPv4IPAddress    = IPWan.IPAddress;
    CommonWanInfo.IPv4SubnetMask   = IPWan.SubnetMask;
    CommonWanInfo.IPv4IPAddressSecond    = IPWan.IPv4IPAddressSecond;
    CommonWanInfo.IPv4SubnetMaskSecond   = IPWan.IPv4SubnetMaskSecond;
    CommonWanInfo.IPv4IPAddressThird    = IPWan.IPv4IPAddressThird;
    CommonWanInfo.IPv4SubnetMaskThird   = IPWan.IPv4SubnetMaskThird;
    CommonWanInfo.IPv4Gateway      = IPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS   = IPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = IPWan.SecondaryDNS;
    CommonWanInfo.DHCPLeaseTime = IPWan.DHCPLeaseTime;
    CommonWanInfo.DHCPLeaseTimeRemaining = IPWan.DHCPLeaseTimeRemaining;
    CommonWanInfo.NTPServer = IPWan.NTPServer;
    CommonWanInfo.TimeZoneInfo = IPWan.TimeZoneInfo;
    CommonWanInfo.SIPServer = IPWan.SIPServer;
    CommonWanInfo.StaticRouteInfo = IPWan.StaticRouteInfo;
    CommonWanInfo.VendorInfo = IPWan.VendorInfo;

    CommonWanInfo.IPv4DialMode     = "AlwaysOn";
    CommonWanInfo.IPv4DialIdleTime = "180";
    CommonWanInfo.IPv4IdleDisconnectMode = IPWan.IPv4IdleDisconnectMode;
    CommonWanInfo.IPv4WanMVlanId   = IPWan.MultiVlanID;
    CommonWanInfo.IPv4BindLanList  = new Array();
    CommonWanInfo.IPv4BindSsidList  = new Array();
    CommonWanInfo.IPv4BindOnuList  = new Array();

    if ("IPv4/IPv6" == CommonWanInfo.ProtocolType && Is3TMode()) {
        CommonWanInfo.IPv4v6WanMVlanId = IPWan.MultiVlanID;
    }

    CommonWanInfo.IPv6PrefixMode   = "SLAAC";
    CommonWanInfo.IPv6AddressMode  = "DHCP";
    CommonWanInfo.IPv6AddressStuff = "";
    CommonWanInfo.IPv6StaticPrefix = "";
    CommonWanInfo.IPv6ReserveAddress = IPWan.IPv6ReserveAddress;
    CommonWanInfo.IPv6IPAddress    = "";
    CommonWanInfo.IPv6AddrMaskLenE8c    = "64";
    CommonWanInfo.IPv6GatewayE8c    = "";
    CommonWanInfo.IPv6SubnetMask   = "";
    CommonWanInfo.IPv6Gateway      = "";
    CommonWanInfo.IPv6PrimaryDNS   = "";
    CommonWanInfo.IPv6SecondaryDNS = "";
    CommonWanInfo.IPv6WanMVlanId   = (IPWan.IPv6MultiVlanID == "-1")  ?  "" : IPWan.IPv6MultiVlanID;
    CommonWanInfo.Uptime = IPWan.Uptime;
    CommonWanInfo.IPv4DNSOverrideSwitch = IPWan.DNSOverrideAllowed;
    CommonWanInfo.X_HW_LowerLayers = IPWan.X_HW_LowerLayers;
    CommonWanInfo.X_HW_IPoEName = IPWan.X_HW_IPoEName;
    CommonWanInfo.X_HW_IPoEPassword = IPWan.X_HW_IPoEPassword;
    CommonWanInfo.EnableOption60 = ((IPWan.X_HW_IPoEName != "")&&(IPWan.X_HW_IPoEPassword != "")) ? "1" : "0";
    CommonWanInfo.PPPoESessionID = "";
    CommonWanInfo.IPv4EnableMulticast = IPWan.IPv4EnableMulticast;
    CommonWanInfo.X_HW_DscpToPbitTbl = IPWan.X_HW_DscpToPbitTbl;
    CommonWanInfo.X_HW_NPTv6Enable = IPWan.X_HW_NPTv6Enable;
    CommonWanInfo.X_HW_SpeedLimit_UP = IPWan.X_HW_SpeedLimit_UP;
    CommonWanInfo.X_HW_SpeedLimit_DOWN = IPWan.X_HW_SpeedLimit_DOWN;
    CommonWanInfo.X_HW_IGMPEnable = IPWan.X_HW_IGMPEnable;
    if (vxlanfeature == 1) {
        CommonWanInfo.X_HW_VXLAN_Enable = IPWan.X_HW_VXLAN_Enable;
    }
    CommonWanInfo.X_HW_OperateDisable = IPWan.X_HW_OperateDisable;
    CommonWanInfo.X_HW_PingResponseEnable = IPWan.X_HW_PingResponseEnable;
    CommonWanInfo.X_HW_PingResponseWhiteList = IPWan.X_HW_PingResponseWhiteList;
}

function AccessType(domain, WANAccessType, BitRate) {
    this.domain         = domain;
    this.WANAccessType  = WANAccessType;
}

function ConvertPPPWan(PPPWan, CommonWanInfo) {
    CommonWanInfo.domain  = PPPWan.domain;

    CommonWanInfo.RealName     = PPPWan.Name;
    CommonWanInfo.ConnectionTrigger = PPPWan.ConnectionTrigger;
    CommonWanInfo.ConnectionControl = PPPWan.ConnectionControl;
    CommonWanInfo.MACAddress   = PPPWan.MACAddress;
    CommonWanInfo.Status       = PPPWan.Status;
    CommonWanInfo.LastConnErr  = PPPWan.LastConnErr;
    CommonWanInfo.Enable       = PPPWan.Enable;
    CommonWanInfo.EnableLanDhcp   = PPPWan.EnableLanDhcp;
    CommonWanInfo.DstIPForwardingList   = PPPWan.DstIPForwardingList;
    CommonWanInfo.RemoteWanInfo = PPPWan.RemoteWanInfo;
    CommonWanInfo.Name         = PPPWan.Name;
    CommonWanInfo.NewName      = PPPWan.NewName;
    CommonWanInfo.ProtocolType = GetProtocolType(PPPWan.IPv4Enable, PPPWan.IPv6Enable);
    CommonWanInfo.IPv4Enable   = PPPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable   = PPPWan.IPv6Enable;
    CommonWanInfo.EncapMode    = "PPPoE";
    if (PPPWan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0) {
        CommonWanInfo.Mode     = "IP_Bridged";
    } else {
        CommonWanInfo.Mode     = "IP_Routed";
    }
    CommonWanInfo.ServiceList  = PPPWan.ServiceList.toUpperCase();
    CommonWanInfo.EnableVlan   = (PPPWan.VlanId == "0") ? "0" : "1";
    if (1 == isSupportVLAN0) {
        CommonWanInfo.EnableVlan   = (PPPWan.VlanId == "4095") ? "0" : "1";
    }

    CommonWanInfo.VlanId       = PPPWan.VlanId;
    CommonWanInfo.PriorityPolicy  = PPPWan.PriorityPolicy;
    CommonWanInfo.DefaultPriority = PPPWan.DefaultPriority;
    CommonWanInfo.Priority     = PPPWan.Pri8021;
    CommonWanInfo.Tr069Flag    = PPPWan.Tr069Flag;
    CommonWanInfo.UserName     = PPPWan.Username;
    CommonWanInfo.Password     = PPPWan.Password;
    CommonWanInfo.LcpEchoReqCheck = PPPWan.LcpEchoReqCheck;
    CommonWanInfo.PPPoEACName  = PPPWan.PPPoEACName;
    CommonWanInfo.MacId        = PPPWan.MacId;

    CommonWanInfo.IPv4AddressMode   = PPPWan.IPMode;
    CommonWanInfo.IPv4MXU           = PPPWan.IPv4MXU;
    CommonWanInfo.IPv4NATEnable     = PPPWan.NATEnable;
    CommonWanInfo.NatType     = PPPWan.X_HW_NatType;
    CommonWanInfo.IPv4VendorId      = "";
    CommonWanInfo.IPv4ClientId      = "";

    CommonWanInfo.IPv4IPAddress    = PPPWan.IPAddress;
    CommonWanInfo.IPv4SubnetMask   = PPPWan.SubnetMask;
    CommonWanInfo.IPv4Gateway      = PPPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS   = PPPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = PPPWan.SecondaryDNS;
    CommonWanInfo.IPv4DialMode     = PPPWan.DialMode;
    CommonWanInfo.IPv4DialIdleTime = PPPWan.IdleDisconnectTime;
    CommonWanInfo.IPv4IdleDisconnectMode = PPPWan.IPv4IdleDisconnectMode;
    CommonWanInfo.IPv4PPPoEAccountEnable = PPPWan.IPv4PPPoEAccountEnable;
    CommonWanInfo.IPv4WanMVlanId   = PPPWan.MultiVlanID;
    CommonWanInfo.IPv4BindLanList  = new Array();
    CommonWanInfo.IPv4BindSsidList  = new Array();
    CommonWanInfo.IPv4BindOnuList  = new Array();

    if("IPv4/IPv6" == CommonWanInfo.ProtocolType && Is3TMode()) {
        CommonWanInfo.IPv4v6WanMVlanId = PPPWan.MultiVlanID;
    }

    CommonWanInfo.IPv6PrefixMode   = "SLAAC";
    CommonWanInfo.IPv6AddressMode  = "DHCP";
    CommonWanInfo.IPv6AddressStuff = "";
    CommonWanInfo.IPv6StaticPrefix = "";
    CommonWanInfo.IPv6ReserveAddress = PPPWan.IPv6ReserveAddress;
    CommonWanInfo.IPv6IPAddress    = "";
    CommonWanInfo.IPv6AddrMaskLenE8c    = "64";
    CommonWanInfo.IPv6GatewayE8c    = "";
    CommonWanInfo.IPv6SubnetMask   = "";
    CommonWanInfo.IPv6Gateway      = "";
    CommonWanInfo.IPv6PrimaryDNS   = "";
    CommonWanInfo.IPv6SecondaryDNS = "";
    CommonWanInfo.IPv6WanMVlanId   = (PPPWan.IPv6MultiVlanID == "-1")  ?  "" : PPPWan.IPv6MultiVlanID;
    CommonWanInfo.Uptime = PPPWan.Uptime;
    CommonWanInfo.IPv4DNSOverrideSwitch = PPPWan.DNSOverrideAllowed;
    CommonWanInfo.X_HW_LowerLayers = PPPWan.X_HW_LowerLayers;
    CommonWanInfo.PPPoESessionID = PPPWan.PPoESessionID;
    CommonWanInfo.IPv4EnableMulticast = PPPWan.IPv4EnableMulticast;
    CommonWanInfo.StaticRouteInfo = PPPWan.StaticRouteInfo;
    CommonWanInfo.X_HW_DscpToPbitTbl = PPPWan.X_HW_DscpToPbitTbl;
    CommonWanInfo.Hurl = PPPWan.Hurl;
    CommonWanInfo.Motm = PPPWan.Motm;
    if (vxlanfeature == 1) {
        CommonWanInfo.X_HW_VXLAN_Enable = PPPWan.X_HW_VXLAN_Enable;
    }
    CommonWanInfo.X_HW_OperateDisable = PPPWan.X_HW_OperateDisable;
    CommonWanInfo.X_HW_BridgeEnable = PPPWan.X_HW_BridgeEnable;
    CommonWanInfo.X_HW_NPTv6Enable = PPPWan.X_HW_NPTv6Enable;
    CommonWanInfo.X_HW_SpeedLimit_UP = PPPWan.X_HW_SpeedLimit_UP;
    CommonWanInfo.X_HW_SpeedLimit_DOWN = PPPWan.X_HW_SpeedLimit_DOWN;
    CommonWanInfo.X_HW_IGMPEnable = PPPWan.X_HW_IGMPEnable; 
    CommonWanInfo.X_HW_PingResponseEnable = PPPWan.X_HW_PingResponseEnable;
    CommonWanInfo.X_HW_PingResponseWhiteList = PPPWan.X_HW_PingResponseWhiteList;
}
