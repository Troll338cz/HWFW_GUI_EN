function() {
  var obj = {};
  obj.PrefixAcquireIP = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_IPv6.IPv6Prefix.{i},Alias|Origin|Prefix,PrefixAcquireItem);%>;
  obj.PrefixAcquirePPP = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_IPv6.IPv6Prefix.{i},Alias|Origin|Prefix,PrefixAcquireItem);%>;
  return obj;
}