function IPv6AddressInfo(domain, IPAddressStatus, Origin,IPAddress,PreferredTime, ValidTime, ValidTimeRemaining)
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

function getIPv6AddressList()
{
    return IPv6AddressList;
}
getIPv6AddressList();


