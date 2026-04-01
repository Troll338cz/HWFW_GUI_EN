function() {
  function IsBridgeAddressSource(IPAddressSource)
  {
    if(("Static"==IPAddressSource)||("DHCP"==IPAddressSource))
    {
      return false;
    }
    return true;
  }
  
  function DHCPInfo(domain,name,ip,mac,remaintime,devtype, interfacetype,AddressSource, ConnectedTime)
  {
    var IsBridgeFlag = IsBridgeAddressSource(AddressSource);
    
    if(IsBridgeFlag)
    {
      this.devtype    = "--";
      this.ip 		= "--";
    }
    else
    {
      this.devtype    = devtype;
      this.ip 		= ip;
    }
    
    this.domain		= domain;
    this.name 		= name;
    this.mac        = mac;
    this.remaintime		= remaintime;
    this.interfacetype = interfacetype;
    this.AddressSource = AddressSource;
      this.ConnectedTime = ConnectedTime;
  }
  
  var UserDhcpinfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecialGetUserDevInfo,InternetGatewayDevice.LANDevice.1.Hosts.Host.{i},HostName|IPAddress|MACAddress|LeaseTimeRemaining|VendorClassID|InterfaceType|AddressSource|ConnectedTime, DHCPInfo);%>;
  
  function GetUserDhcpInfoList()
  {
    return UserDhcpinfo;
  }
  
  return GetUserDhcpInfoList();
}