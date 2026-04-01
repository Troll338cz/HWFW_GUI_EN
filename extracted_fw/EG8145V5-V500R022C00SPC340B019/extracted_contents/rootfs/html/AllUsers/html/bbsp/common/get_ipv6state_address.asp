function() {
  function IPv6AddressInfo(domain, ValidTimeRemaining)
  {
      this.WanInstanceId = domain.split(".")[4];
    this.ValidTimeRemaining = ValidTimeRemaining;
  }
  var IPv6AddressList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6Address, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i}.IPv6Address.{i},ValidTimeRemaining,IPv6AddressInfo);%>
  
  function GetIPv6AddressList()
  {
      return IPv6AddressList;
  }
  
  return GetIPv6AddressList();
}