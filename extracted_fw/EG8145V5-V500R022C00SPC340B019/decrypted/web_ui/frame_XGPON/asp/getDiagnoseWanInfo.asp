var WanList = new Array();
function WanIP(domain, Enable, NATEnable, ConnectionStatus, VlanId, X_HW_SERVICELIST, X_HW_ExServiceList, AddressingType, ExternalIPAddress, DefaultGateway, DNSServers, Name, X_HW_IPv4Enable, X_HW_IPv6Enable, X_HW_MacId, ConnectionType) {
    this.domain = domain;
    this.Enable = Enable;
    this.NATEnable = NATEnable;
    this.ConnectionStatus = ConnectionStatus;
    this.VlanId = VlanId;
    this.ServiceList = (X_HW_ExServiceList.length == 0) ? X_HW_SERVICELIST.toUpperCase() : X_HW_ExServiceList.toUpperCase();
    this.IPMode = AddressingType;
    this.IPAddress = ExternalIPAddress;
    this.Gateway = DefaultGateway;
    var dnss = DNSServers.split(',');
    this.PrimaryDNS = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";
    this.Name = Name;
    this.IPv4Enable = X_HW_IPv4Enable;
    this.IPv6Enable = X_HW_IPv6Enable;
    this.MacId = X_HW_MacId;
    this.Mode = ConnectionType;
}

function WanPPP(domain, Enable, NATEnable, ConnectionStatus, VlanId, IPAddress, Gateway, dnsstr, ServiceList, ExServiceList, Name, X_HW_IPv4Enable, X_HW_IPv6Enable, X_HW_MacId, ConnectionType) {
    this.domain = domain;
    this.Enable = Enable;
    this.NATEnable = NATEnable;
    this.ConnectionStatus = ConnectionStatus;
    this.VlanId = VlanId;
    this.IPMode = 'PPPoE';
    this.IPAddress = IPAddress;
    this.Gateway = Gateway;
    var dnss = dnsstr.split(',');
    this.PrimaryDNS = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";
    this.ServiceList = (ExServiceList.length == 0) ? ServiceList.toUpperCase() : ExServiceList.toUpperCase();
    this.Name = Name;
    this.IPv4Enable = X_HW_IPv4Enable;
    this.IPv6Enable = X_HW_IPv6Enable;
    this.MacId = X_HW_MacId;
    this.Mode = ConnectionType;
}

var IPWanList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},Enable|NATEnabled|ConnectionStatus|X_HW_VLAN|X_HW_SERVICELIST|X_HW_ExServiceList|AddressingType|ExternalIPAddress|DefaultGateway|DNSServers|Name|X_HW_IPv4Enable|X_HW_IPv6Enable|X_HW_MacId|ConnectionType,WanIP);%>;
var PPPWanList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},Enable|NATEnabled|ConnectionStatus|X_HW_VLAN|ExternalIPAddress|DefaultGateway|DNSServers|X_HW_SERVICELIST|X_HW_ExServiceList|Name|X_HW_IPv4Enable|X_HW_IPv6Enable|X_HW_MacId|ConnectionType,WanPPP);%>;

function WanInfoInst() {
    this.Enable = "1";
    this.IPv4NATEnable = "1";
    this.ConnectionStatus = "";
    this.VlanId = "0";
    this.ServiceList = "INTERNET";
    this.IPv4AddressMode = "DHCP";
    this.IPv4IPAddress = "";
    this.IPv4Gateway = "";
    this.IPv4PrimaryDNS = "";
    this.IPv4SecondaryDNS = "";
    this.Name = "";
    this.IPv4Enable = "1";
    this.IPv6Enable = "0";
    this.MacId = "0";
}

function ConvertIPWan(IPWan, CommonWanInfo) {
    CommonWanInfo.domain = IPWan.domain;
    CommonWanInfo.Enable = IPWan.Enable;
    CommonWanInfo.IPv4NATEnable = IPWan.NATEnable;
    CommonWanInfo.ConnectionStatus = IPWan.ConnectionStatus;
    CommonWanInfo.VlanId = IPWan.VlanId;
    CommonWanInfo.ServiceList = IPWan.ServiceList.toUpperCase();
  
    switch(IPWan.IPMode.toString().toUpperCase()) {
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

    CommonWanInfo.IPv4IPAddress = IPWan.IPAddress;
    CommonWanInfo.IPv4Gateway = IPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS = IPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = IPWan.SecondaryDNS;
    CommonWanInfo.IPv6AddressMode = "DHCP";
    CommonWanInfo.Name = IPWan.Name;
    CommonWanInfo.IPv4Enable = IPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable = IPWan.IPv6Enable;
    CommonWanInfo.MacId = IPWan.MacId;
    CommonWanInfo.Mode = IPWan.Mode;
}

function ConvertPPPWan(PPPWan, CommonWanInfo) {
    CommonWanInfo.domain = PPPWan.domain;
    CommonWanInfo.Enable = PPPWan.Enable;
    CommonWanInfo.IPv4NATEnable = PPPWan.NATEnable;
    CommonWanInfo.ConnectionStatus = PPPWan.ConnectionStatus;
    CommonWanInfo.VlanId = PPPWan.VlanId;
    CommonWanInfo.ServiceList = PPPWan.ServiceList.toUpperCase();
    CommonWanInfo.IPv4AddressMode = PPPWan.IPMode;
    CommonWanInfo.IPv4IPAddress = PPPWan.IPAddress;
    CommonWanInfo.IPv4Gateway = PPPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS = PPPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = PPPWan.SecondaryDNS;
    CommonWanInfo.Name = PPPWan.Name;
    CommonWanInfo.IPv4Enable = PPPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable = PPPWan.IPv6Enable;
    CommonWanInfo.MacId = PPPWan.MacId;
    if (PPPWan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0) {
        CommonWanInfo.Mode = "IP_Bridged";
    } else {
        CommonWanInfo.Mode = "IP_Routed";
    }
}

var i=0,j=0;
for (i=0, j=0; IPWanList.length > 0 && i < IPWanList.length -1; i++, j++) {
    WanList[j] = new WanInfoInst();
    ConvertIPWan(IPWanList[i], WanList[j]);
}

for (i=0; PPPWanList.length > 0 && i < PPPWanList.length - 1; j++,i++) {
    WanList[j] = new WanInfoInst();
    ConvertPPPWan(PPPWanList[i], WanList[j]);
}

function GetWanList() {
    return WanList;
}

GetWanList();

