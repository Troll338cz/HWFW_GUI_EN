function IPv6WanDnsInfoClass(domain, DNSServer, Interface,X_HW_OverrideAllowed)
{
    this.domain = domain;
    this.DNSServer = DNSServer;
    this.Interface = Interface;
    this.WanInstanceId = Interface;
	this.X_HW_OverrideAllowed = X_HW_OverrideAllowed;
}

var RecordList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DNS.Client.Server.{i},DNSServer|Interface|X_HW_OverrideAllowed,IPv6WanDnsInfoClass);%>;

function GetIPv6WanDnsServerInfo(WanInstanceId)
{
    for (var i = 0; i < RecordList.length - 1; i++)
    {
        if (RecordList[i].WanInstanceId == WanInstanceId)
        {
            return RecordList[i];
        }
    }
    
    return null;
}

function GetWanDnsServerString(PrimaryDnsServer, SecondaryDnsServer)
{
	var DnsServerString = "";
	if ("" != PrimaryDnsServer && "" != SecondaryDnsServer)
	{
		DnsServerString = PrimaryDnsServer + "," + SecondaryDnsServer;
	}
	else
	{
		DnsServerString = PrimaryDnsServer  + SecondaryDnsServer;
	}
	return DnsServerString;
}
