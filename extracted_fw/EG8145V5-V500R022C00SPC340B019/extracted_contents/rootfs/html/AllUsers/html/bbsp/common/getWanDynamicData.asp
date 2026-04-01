var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var SupportIPv6 = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>";

function domainTowanname(domain) {
  if((null != domain) && (undefined != domain)) {
      var domaina = domain.split('.');
      var type = (-1 == domain.indexOf("WANIPConnection")) ? '.ppp' : '.ip' ;
      return 'wan' + domaina[2]  + '.' + domaina[4] + type + domaina[6] ;
  }
}

function WanIP(domain,X_HW_VXLAN_Enable, X_HW_OperateDisable,ConnectionTrigger,MACAddress, Status, LastConnErr, RemoteWanInfo, Name,Enable,EnableLanDhcp,DstIPForwardingList,ConnectionStatus,
                Mode,IPMode,IPAddress,SubnetMask,Gateway,
                NATEnable,X_HW_NatType,dnsstr,VlanId,MultiVlanID,Pri8021,VenderClassID,ClientID,ServiceList,ExServiceList,
                Tr069Flag, MacId, IPv4Enable, IPv6Enable, IPv6MultiCastVlan, PriPolicy, DefaultPri,MaxMTUSize,
                DHCPLeaseTime,NTPServer,TimeZoneInfo,SIPServer,StaticRouteInfo,VendorInfo,DHCPLeaseTimeRemaining,Uptime,DNSOverrideAllowed,X_HW_LowerLayers,
                X_HW_IPoEName,X_HW_IPoEPassword,X_HW_IGMPEnable,X_HW_DscpToPbitTbl, IPv4IPAddressSecond, IPv4SubnetMaskSecond, IPv4IPAddressThird, 
                IPv4SubnetMaskThird, X_HW_NPTv6Enable, X_HW_SpeedLimit_UP, X_HW_SpeedLimit_DOWN, X_HW_LteProfile, X_HW_PingResponseEnable, X_HW_PingResponseWhiteList,IPForwardModeEnabled) {
    this.domain = domain;
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
    this.X_HW_VXLAN_Enable = X_HW_VXLAN_Enable;
    this.X_HW_OperateDisable = X_HW_OperateDisable;

    this.MultiVlanID=(MultiVlanID > 4094 )?"":MultiVlanID;
    this.IPv6MultiVlanID=(IPv6MultiCastVlan > 4094 ) ? "":IPv6MultiCastVlan;

    if(PriPolicy.toUpperCase() == "SPECIFIED")
    {
        this.PriorityPolicy = "Specified";
    }
    else if(PriPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE")
    {
        this.PriorityPolicy = "CopyFromIPPrecedence";
    }
    else
    {
        this.PriorityPolicy = "DscpToPbit";
    }
    this.DefaultPriority = DefaultPri;
    this.Pri8021  =  Pri8021;
    this.VenderClassID = VenderClassID;
    this.ClientID = ClientID;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();
    if (this.ServiceList == "HQOS") {
        this.ServiceList = "HQoS";
    }
    if (this.ServiceList == "D_BUS") {
        this.ServiceList = "D_Bus";
    }

    this.isPPPoEAccountEnable = "disable";
    this.Tr069Flag = Tr069Flag;
    this.MacId = MacId;

    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (0 == SupportIPv6)
    {
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

    if(0 == MaxMTUSize)
    {
        this.IPv4MXU = 1500;
    }
    else
    {
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
    this.X_HW_LteProfile = X_HW_LteProfile;
    this.X_HW_PingResponseEnable = X_HW_PingResponseEnable;
    this.X_HW_PingResponseWhiteList = X_HW_PingResponseWhiteList;
    this.IPForwardModeEnabled = IPForwardModeEnabled;
}

function WanPPP(domain, X_HW_VXLAN_Enable, X_HW_OperateDisable, ConnectionTrigger, MACAddress, Status, LastConnErr, RemoteWanInfo, Name,Enable,EnableLanDhcp,DstIPForwardingList,ConnectionStatus,Mode,IPAddress,Gateway,NATEnable,X_HW_NatType,dnsstr,
                Username,Password,DialMode,ConnectionControl,VlanId,MultiVlanID,Pri8021,LcpEchoReqCheck,ServiceList,ExServiceList,Tr069Flag,
                IdleDisconnectTime, MacId, IPv4Enable, IPv6Enable, IPv6MultiCastVlan, PriPolicy, DefaultPri, MaxMRUSize, PPPoEACName,X_HW_IdleDetectMode, Uptime, DNSOverrideAllowed, X_HW_LowerLayers,
                PPPoESessionID,X_HW_IGMPEnable, StaticRouteInfo, X_HW_DscpToPbitTbl, Hurl, Motm, X_HW_BridgeEnable, X_HW_NPTv6Enable, X_HW_SpeedLimit_UP, X_HW_SpeedLimit_DOWN,
                X_HW_PingResponseEnable, X_HW_PingResponseWhiteList, IPForwardModeEnabled) {
    this.domain            = domain;
    this.ConnectionTrigger = ConnectionTrigger;
    this.Uptime = Uptime;

    if (parseInt(ConnectionControl, 10) == 0xFFFFFFFF )
    {
        this.ConnectionControl = 0;
    }
    else
    {
        this.ConnectionControl = ConnectionControl;
    }

    this.MACAddress = MACAddress;

    if ((Status.toUpperCase() == "CONNECTING") && (this.ConnectionControl == "0") && (ConnectionTrigger == "Manual"))
    {
        this.Status = "Disconnected";
    }
    else
    {
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
    this.X_HW_VXLAN_Enable = X_HW_VXLAN_Enable;
    this.X_HW_OperateDisable = X_HW_OperateDisable;
    this.MultiVlanID=(MultiVlanID > 4094 )?"":MultiVlanID;
    this.IPv6MultiVlanID=(IPv6MultiCastVlan > 4094 ) ? "":IPv6MultiCastVlan;

    if(PriPolicy.toUpperCase() == "SPECIFIED")
    {
        this.PriorityPolicy = "Specified";
    }
    else if(PriPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE")
    {
        this.PriorityPolicy = "CopyFromIPPrecedence";
    }
    else
    {
        this.PriorityPolicy = "DscpToPbit";
    }
    this.DefaultPriority = DefaultPri;
    this.Pri8021  =  Pri8021;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();
    if (this.ServiceList == "HQOS") {
        this.ServiceList = "HQoS";
    }
    if (this.ServiceList == "D_BUS") {
        this.ServiceList = "D_Bus";
    }

    this.IdleDisconnectTime = IdleDisconnectTime;
    this.IPv4IdleDisconnectMode = X_HW_IdleDetectMode;
    this.Tr069Flag = Tr069Flag;
    this.MacId = MacId;

    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (0 == SupportIPv6)
    {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }

    this.PPPoEACName = PPPoEACName;
    if(0 == MaxMRUSize)
        this.IPv4MXU = 1492;
    else
        this.IPv4MXU = MaxMRUSize;

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
    this.IPForwardModeEnabled = IPForwardModeEnabled;
    
    if ((CfgModeWord.toUpperCase() == "SCCT") && (this.ServiceList == "OTHER")) {
        this.MultiVlanID = (MultiVlanID > 4094) ? "-1" : MultiVlanID;
    }
    this.X_HW_PingResponseEnable = X_HW_PingResponseEnable;
    this.X_HW_PingResponseWhiteList = X_HW_PingResponseWhiteList;
}

function UnnumberdIPInfoClass(domain, Enable, IPAddress, SubnetMask) {
    this.domain = domain;
    this.Enable = Enable;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;
}

function IPv6AddressInfo(domain, IPAddressStatus, Origin, IPAddress, PreferredTime, ValidTime, ValidTimeRemaining) {
  this.WanInstanceId = domain.split(".")[4];
  this.IPAddressStatus = IPAddressStatus;
  this.Origin = Origin;
  this.IPAddress = IPAddress;
  this.PreferredTime = PreferredTime;
  this.ValidTime = ValidTime;
  this.ValidTimeRemaining = ValidTimeRemaining;
}

function IPv6PrefixInfo(domain, Origin, Prefix,PreferredTime,ValidTime,ValidTimeRemaining) {
  this.WanInstanceId = domain.split(".")[4];
  this.Prefix = Prefix;
  this.Origin = Origin;
  this.PreferredTime = PreferredTime;
  this.ValidTime = ValidTime;
  this.ValidTimeRemaining = ValidTimeRemaining;
}

function IPv6WanInfo(domain, Type, ConnectionStatus, L2EncapType, MACAddress, Vlan, Pri,
                     DNSServers, AFTRName, AFTRPeerAddr,DefaultRouterAddress,V6UpTime) {
  this.WanInstanceId = domain.split(".")[4];
  this.Type = Type;
  this.ConnectionStatus = ConnectionStatus;
  this.L2EncapType = L2EncapType;
  this.MACAddress = MACAddress;
  this.Vlan = Vlan;
  this.Pri = Pri;
  this.DNSServers = DNSServers;
  this.AFTRName = AFTRName;
  this.AFTRPeerAddr = (AFTRPeerAddr=="::")?"":AFTRPeerAddr;
  this.DefaultRouterAddress = DefaultRouterAddress;
  this.V6UpTime = V6UpTime;
}

var refreshWanListCache = function() {
  getDynamicData('/html/bbsp/common/wan_list_cache_wan.asp', function(data) {
    if (typeof window.wanCacheObj.wanListCacheObj !== 'undefined') {
      window.wanCacheObj.wanListCacheObj = dealDataWithFun(data);
    }
  });
}
  
var refreshIpv6StateCache = function() {
  getDynamicData('/html/bbsp/common/wan_list_cache_wanipv6.asp', function(data) {
    if (typeof window.wanCacheObj.wanIpv6StateCacheObj !== 'undefined') {
      window.wanCacheObj.wanIpv6StateCacheObj = dealDataWithFun(data);
    }
  });
}

var ininCurWanState = function() {
  window.wanCacheObj.curWanState = ajaxGetAspData('/html/bbsp/common/wanStateMonitor.asp');
}

window.stopWanStateTimer = function() {
  if (window.wanCacheObj.wanMonitorTimer) {
      clearInterval(window.wanCacheObj.wanMonitorTimer);
      window.wanCacheObj.wanMonitorTimer = null;
  }
}

var errorCallBack = function() {
  stopWanStateTimer();
}

var monitorWanState = function() {
  if (parseInt(UpgradeFlag) !== 0) {
    stopWanStateTimer();
    return;
  }
  getDynamicData('/html/bbsp/common/wanStateMonitor.asp', function(data) {
    if (typeof window.wanCacheObj.curWanState !== 'undefined') {
      if (window.wanCacheObj.curWanState !== data) {
        refreshWanListCache();
        refreshIpv6StateCache();
        window.wanCacheObj.curWanState = data;
      }
    }
  }, errorCallBack);
}

window.startWanStateTimer = function() {
    if (!window.wanCacheObj.wanMonitorTimer) {
        monitorWanState();
        window.wanCacheObj.wanMonitorTimer = setInterval("monitorWanState()", 2500); 
    }
}

var wanCacheInit = (function() {
    refreshWanListCache();
    refreshIpv6StateCache();
    ininCurWanState();
    startWanStateTimer();
})();