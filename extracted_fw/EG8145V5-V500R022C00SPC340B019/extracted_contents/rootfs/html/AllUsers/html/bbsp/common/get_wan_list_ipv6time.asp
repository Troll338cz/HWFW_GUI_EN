function() {
  function IPv6WanTimeInfo(domain, V6UpTime)
  {
      this.domain = domain;
      this.WanInstanceId = domain.split(".")[4];
      this.V6UpTime = V6UpTime;
  }
  
  var IPv6WanTimeList =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i}, V6UpTime, IPv6WanTimeInfo);%>;
  
  function GetIpv6WanTimeList()
  {
      return IPv6WanTimeList;
  }
  
  return GetIpv6WanTimeList();
}