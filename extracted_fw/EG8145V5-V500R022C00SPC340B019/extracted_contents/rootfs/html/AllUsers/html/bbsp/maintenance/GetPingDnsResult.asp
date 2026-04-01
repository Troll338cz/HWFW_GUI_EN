function() {
  var pingDnsResultInfo = <%HW_WEB_GetPingDnsResult();%>;

  function GetPingDnsResultInfo()
  {
    return pingDnsResultInfo;
  }
  return GetPingDnsResultInfo();
}


