function() {
  var obj = {};
  obj.IPv6AddressList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6Address, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i}.IPv6Address.{i},IPAddressStatus|Origin|IPAddress|PreferredTime|ValidTime|ValidTimeRemaining,IPv6AddressInfo);%>;
  obj.IPv6PrefixList  = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6WanPrefix, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i}.IPv6Prefix.{i},Origin|Prefix|PreferredTime|ValidTime|ValidTimeRemaining,IPv6PrefixInfo);%>;
  obj.IPv6WanInfoList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6WanInfo, InternetGatewayDevice.WANDevice.{i}.X_HW_ShowInterface.{i},Type|ConnectionStatus|L2EncapType|MACAddress|Vlan|Pri|IPv6DNS|AFTRName|PeerAddress|DefaultRouterAddress|V6UpTime,IPv6WanInfo);%>;
  return obj;
}
