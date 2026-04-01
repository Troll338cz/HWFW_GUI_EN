function() {
  function stWlanMacFilter(domain,SSIDName,MACAddress)
  {
     this.domain = domain;   
     this.SSIDName = SSIDName;
     this.MACAddress = MACAddress; 
  }
  var WlanMacFilterSrc = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.WLANMacFilter.{i},SSIDName|SourceMACAddress,stWlanMacFilter);%>;
  var WlanMacFilter = new Array();
  for (var i = 0; i < WlanMacFilterSrc.length-1; i++)
  {
    var SSIDIndex = WlanMacFilterSrc[i].SSIDName.charAt(WlanMacFilterSrc[i].SSIDName.length - 1);
    if(IsVisibleSSID('SSID' + SSIDIndex) == true)
      WlanMacFilter.push(WlanMacFilterSrc[i]);
  }
  WlanMacFilter.push(null);
  
  function GetWlanMacFilterData()
  {
    return WlanMacFilter;
  }
  
  return GetWlanMacFilterData();
}