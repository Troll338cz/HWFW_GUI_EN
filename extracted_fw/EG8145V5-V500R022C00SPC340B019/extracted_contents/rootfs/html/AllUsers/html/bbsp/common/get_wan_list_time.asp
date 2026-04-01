function() {
  function ConvertWanList(Wan, WANPara)
  {
      WANPara.domain = Wan.domain;
      WANPara.Uptime = Wan.Uptime;
      WANPara.DHCPLeaseTimeRemaining = Wan.DHCPLeaseTimeRemaining;
  }
  
  function stIPWanTimeList(domain, Uptime, X_HW_DHCPLeaseTimeRemaining)
  {
      this.domain = domain;
      this.Uptime = Uptime;
      this.DHCPLeaseTimeRemaining = X_HW_DHCPLeaseTimeRemaining;
  }
  
  function stPPPWanTimeList(domain, Uptime, X_HW_DHCPLeaseTimeRemaining)
  {
      this.domain = domain;
      this.Uptime = Uptime;
      this.DHCPLeaseTimeRemaining = "";
  }
  
  var IPWanTimeList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayIPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}, Uptime|X_HW_DHCPLeaseTimeRemaining, stIPWanTimeList);%>;
  var PPPWanTimeList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPPPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}, Uptime, stPPPWanTimeList);%>;
  
  function GetWanTimeList()
  {
      var IPWanListNum = IPWanTimeList.length - 1;
      var PPPWanListNum = PPPWanTimeList.length - 1;
      var WanIdx = 0;
      var WanList = new Array();
  
      for(var i=0; (IPWanTimeList != null && IPWanListNum > 0 && i < IPWanListNum); i++) {
          WanList[WanIdx] = new stIPWanTimeList();
          ConvertWanList(IPWanTimeList[i], WanList[WanIdx]);
          WanIdx++;
      }
  
      for(var j=0; (null != PPPWanTimeList && PPPWanListNum > 0 && j < PPPWanListNum); j++) {
          WanList[WanIdx] = new stPPPWanTimeList();
          ConvertWanList(PPPWanTimeList[j], WanList[WanIdx]);
          WanIdx++;
      }
  
      return WanList;
  }
  return GetWanTimeList();
}