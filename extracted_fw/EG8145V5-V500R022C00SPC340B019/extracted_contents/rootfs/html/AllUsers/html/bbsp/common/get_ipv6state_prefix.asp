function() {
  function IPv6PrefixInfo(domain, ValidTimeRemaining)
  {
      this.WanInstanceId = domain.split(".")[4];
    this.ValidTimeRemaining = ValidTimeRemaining;
  }
  var IPv6PrefixList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6WanPrefix, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i}.IPv6Prefix.{i},ValidTimeRemaining,IPv6PrefixInfo);%>
  
  function GetIPv6PrefixList()
  {
      return IPv6PrefixList;
  }
  
  return GetIPv6PrefixList();
}