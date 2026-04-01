function() {
  function LANStats(domain,SendMcastFrame,SendUcastFrame)
  {  
      this.domain   = domain;
      this.SendMcastFrame = SendMcastFrame;
    this.SendUcastFrame = SendUcastFrame;
  }
  
  var userEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.Statistics,SendMcastFrame|SendUcastFrame,LANStats);%>;
  
  function getStbResult()
  {
    return userEthInfos;
  }
  
  return getStbResult();
}
