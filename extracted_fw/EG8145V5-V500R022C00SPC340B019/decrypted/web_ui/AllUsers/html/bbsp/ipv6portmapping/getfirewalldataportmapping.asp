function() {
  var ajaxFilterIn = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_TDE_Firewall.Firewall.{i}, Name|Interface|Type|IPVersion|RuleNumberOfEntries, stFirewall);%>;

  function GetajaxFilterIn()
  {
    return ajaxFilterIn;
  }
  return GetajaxFilterIn();
}