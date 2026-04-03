
var WanList = new Array();
var SupportIPv6 = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>";
function WanIP(domain, X_HW_SERVICELIST, X_HW_ExServiceList, X_HW_IPv4Enable, X_HW_IPv6Enable, AddressingType, MaxMTUSize, ExternalIPAddress, SubnetMask, DefaultGateway, DNSServers) {
    this.domain = domain;
    this.ServiceList = (X_HW_ExServiceList.length == 0)?X_HW_SERVICELIST.toUpperCase():X_HW_ExServiceList.toUpperCase();
    this.IPv4Enable = X_HW_IPv4Enable;
    this.IPv6Enable = X_HW_IPv6Enable;
    if (0 == SupportIPv6) {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }
    this.IPMode = AddressingType;

    this.IPv4MXU = MaxMTUSize;
    if (0 == MaxMTUSize) {
        this.IPv4MXU = 1500;
    } else {
        this.IPv4MXU = MaxMTUSize;
    }
    this.IPAddress = ExternalIPAddress;
    this.SubnetMask = SubnetMask;
    this.Gateway = DefaultGateway;
     var dnss = DNSServers.split(',');
    this.PrimaryDNS = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";    
}


function WanPPP(domain, IPAddress, Gateway, dnsstr, Username,Password, ServiceList,ExServiceList,IPv4Enable, IPv6Enable, MaxMRUSize) {
    this.domain        = domain;
    this.IPMode        = 'PPPoE';
    this.IPAddress     = IPAddress;
    this.SubnetMask    = '255.255.255.255';
    this.Gateway       = Gateway;
    var dnss           = dnsstr.split(',');
    this.PrimaryDNS    = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";
    this.Username = Username;
    this.Password = Password;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();
    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (0 == SupportIPv6) {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }

    if (0 == MaxMRUSize) {
        this.IPv4MXU = 1492;
    } else {
        this.IPv4MXU = MaxMRUSize;
    }
}

var IPWanList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayIPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_IPv4Enable|X_HW_IPv6Enable|AddressingType|MaxMTUSize|ExternalIPAddress|SubnetMask|DefaultGateway|DNSServers,WanIP);%>;

var PPPWanList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPPPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},ExternalIPAddress|DefaultGateway|DNSServers|Username|Password|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_IPv4Enable|X_HW_IPv6Enable|MaxMRUSize,WanPPP);%>;

var i=0,j=0;

function WanInfoInst() {
    this.IPv4Enable   = "1";
    this.IPv6Enable   = "0";
    this.ServiceList  = "INTERNET";
    this.UserName     = "";
    this.Password     = "";
    this.IPv4AddressMode   = "DHCP";
    this.IPv4MXU           = "";
    this.IPv4IPAddress    = "";
    this.IPv4SubnetMask   = "";
    this.IPv4Gateway      = "";
    this.IPv4PrimaryDNS   = "";
    this.IPv4SecondaryDNS = "";
}

function ConvertIPWan(IPWan, CommonWanInfo) {
    CommonWanInfo.domain  = IPWan.domain;
    CommonWanInfo.IPv4Enable   = IPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable   = IPWan.IPv6Enable;

    CommonWanInfo.ServiceList  = IPWan.ServiceList.toUpperCase();
    
    CommonWanInfo.UserName     = "";
    CommonWanInfo.Password     = "";

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
    CommonWanInfo.IPv4MXU          = IPWan.IPv4MXU;
    CommonWanInfo.IPv4IPAddress    = IPWan.IPAddress;
    CommonWanInfo.IPv4SubnetMask   = IPWan.SubnetMask;
    CommonWanInfo.IPv4Gateway      = IPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS   = IPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = IPWan.SecondaryDNS;
    CommonWanInfo.IPv6AddressMode  = "DHCP";   
}

function ConvertPPPWan(PPPWan, CommonWanInfo) {
    CommonWanInfo.domain  = PPPWan.domain;
    CommonWanInfo.IPv4Enable   = PPPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable   = PPPWan.IPv6Enable;
    CommonWanInfo.ServiceList  = PPPWan.ServiceList.toUpperCase();
    CommonWanInfo.UserName     = PPPWan.Username;
    CommonWanInfo.Password     = PPPWan.Password;
    CommonWanInfo.IPv4AddressMode   = PPPWan.IPMode;
    CommonWanInfo.IPv4MXU           = PPPWan.IPv4MXU;
    CommonWanInfo.IPv4IPAddress    = PPPWan.IPAddress;
    CommonWanInfo.IPv4SubnetMask   = PPPWan.SubnetMask;
    CommonWanInfo.IPv4Gateway      = PPPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS   = PPPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = PPPWan.SecondaryDNS;
}

for (i=0, j=0; IPWanList.length > 0 && i < IPWanList.length -1; i++, j++) {
    WanList[j] = new WanInfoInst();
    ConvertIPWan(IPWanList[i], WanList[j]);
}

for (i=0; PPPWanList.length > 0 && i < PPPWanList.length - 1; j++,i++) {
    WanList[j] = new WanInfoInst();
    ConvertPPPWan(PPPWanList[i], WanList[j]);
}

WanList.sort(
    function (wan1, wan2) {
        var cmp = 0;

        if (wan1.MacId > wan2.MacId) {
            cmp = 1;
        } else if (wan1.MacId < wan2.MacId) {
            cmp = -1;
        } else {
            cmp = 0;
        }
        return cmp;
    }
);

function GetWanList() {
    return WanList;
}
