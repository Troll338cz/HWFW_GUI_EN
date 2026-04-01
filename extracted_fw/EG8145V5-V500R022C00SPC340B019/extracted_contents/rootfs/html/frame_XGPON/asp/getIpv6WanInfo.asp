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

function getIPv6WanInfoList()
{
    return IPv6WanInfoList;
}
getIPv6WanInfoList();
