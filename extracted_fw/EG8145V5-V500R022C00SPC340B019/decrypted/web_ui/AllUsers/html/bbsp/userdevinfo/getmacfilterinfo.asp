function() {
  function stMacFilter(domain,MACAddress)
  {
     this.domain = domain;
     this.MACAddress = MACAddress;
  }
  var MacFilter = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.MacFilter.{i},SourceMACAddress,stMacFilter);%>;
  
  function GetMacFilterData()
  {
    return MacFilter;
  }
  
  return GetMacFilterData();
}