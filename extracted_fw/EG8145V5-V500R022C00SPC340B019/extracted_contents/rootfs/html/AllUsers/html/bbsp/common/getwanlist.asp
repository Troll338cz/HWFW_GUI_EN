function() {
  var IPWanList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayIPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},X_HW_VXLAN_Enable|X_HW_OperateDisable|ConnectionTrigger|MACAddress|ConnectionStatus|LastConnectionError|X_HW_RemoteWanInfo|Name|Enable|X_HW_LanDhcpEnable|X_HW_IPForwardList|ConnectionStatus|ConnectionType|AddressingType|ExternalIPAddress|SubnetMask|DefaultGateway|NATEnabled|X_HW_NatType|DNSServers|X_HW_VLAN|X_HW_MultiCastVLAN|X_HW_PRI|X_HW_VenderClassID|X_HW_ClientID|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_TR069FLAG|X_HW_MacId|X_HW_IPv4Enable|X_HW_IPv6Enable|X_HW_IPv6MultiCastVLAN|X_HW_PriPolicy|X_HW_DefaultPri|MaxMTUSize|X_HW_DHCPLeaseTime|X_HW_NTPServer|X_HW_TimeZoneInfo|X_HW_SIPServer|X_HW_StaticRouteInfo|X_HW_VendorInfo|X_HW_DHCPLeaseTimeRemaining|Uptime|DNSOverrideAllowed|X_HW_LowerLayers,WanIP);%>;
  var PPPWanList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPPPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},X_HW_VXLAN_Enable|X_HW_OperateDisable|ConnectionTrigger|MACAddress|ConnectionStatus|LastConnectionError|X_HW_RemoteWanInfo|Name|Enable|X_HW_LanDhcpEnable|X_HW_IPForwardList|ConnectionStatus|ConnectionType|ExternalIPAddress|DefaultGateway|NATEnabled|X_HW_NatType|DNSServers|Username|Password|ConnectionTrigger|X_HW_ConnectionControl|X_HW_VLAN|X_HW_MultiCastVLAN|X_HW_PRI|X_HW_LcpEchoReqCheck|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_TR069FLAG|IdleDisconnectTime|X_HW_MacId|X_HW_IPv4Enable|X_HW_IPv6Enable|X_HW_IPv6MultiCastVLAN|X_HW_PriPolicy|X_HW_DefaultPri|MaxMRUSize|PPPoEACName|X_HW_IdleDetectMode|Uptime|DNSOverrideAllowed|X_HW_LowerLayers|X_HW_BridgeEnable,WanPPP);%>;
  
  var IPWanListNum = IPWanList.length - 1;
  var PPPWanListNum = PPPWanList.length - 1;
  var WanIdx = 0;
  var WanList = new Array();
  
  for(var i=0; (IPWanList != null && IPWanListNum > 0 && i < IPWanListNum);i++)
  {		
    WanList[WanIdx] = new WanInfoInst();
    ConvertIPWan(IPWanList[i], WanList[WanIdx]);
    WanIdx++;
  }
  
  for(var j=0; (null != PPPWanList && PPPWanListNum > 0 && j < PPPWanListNum); j++)
  {	
    WanList[WanIdx] = new WanInfoInst();
    ConvertPPPWan(PPPWanList[j], WanList[WanIdx]);
    WanIdx++;
  }
  
  function IPv6AddressInfo(domain, IPAddressStatus, Origin,IPAddress,PreferredTime,
                          ValidTime,ValidTimeRemaining)
  {
      this.WanInstanceId = domain.split(".")[4];
      this.IPAddressStatus = IPAddressStatus;
      this.Origin = Origin;
      this.IPAddress = IPAddress;
    this.PreferredTime = PreferredTime;
    this.ValidTime = ValidTime;
    this.ValidTimeRemaining = ValidTimeRemaining;
  }
  
  var IPv6AddressList =  <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6Address, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i}.IPv6Address.{i},IPAddressStatus|Origin|IPAddress|PreferredTime|ValidTime|ValidTimeRemaining,IPv6AddressInfo);%>;
  
  function IPv6WanInfo(domain, Type, ConnectionStatus, L2EncapType, MACAddress, Vlan, Pri,
                       DNSServers, AFTRName, AFTRPeerAddr,DefaultRouterAddress,V6UpTime)
  {
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
  
  var IPv6WanInfoList =  <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6WanInfo, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i},Type|ConnectionStatus|L2EncapType|MACAddress|Vlan|Pri|IPv6DNS|AFTRName|PeerAddress|DefaultRouterAddress|V6UpTime,IPv6WanInfo);%>;
  
  
  function AllWanInfoSt()
  {
    this.WanList = new Array(null);
    this.IPv6AddressList = new Array(null);
    this.IPv6WanInfoList = new Array(null);
  }
  var AllWanInfo = new AllWanInfoSt('','','');
  AllWanInfo.WanList = WanList;
  AllWanInfo.IPv6AddressList = IPv6AddressList;
  AllWanInfo.IPv6WanInfoList = IPv6WanInfoList;
  

  return AllWanInfo;
}
