function() {
  var keyArr = ['domain', 'LinkType', 'DestinationAddress', 'ATMEncapsulation', 'ATMQoS', 
                  'ATMPeakCellRate', 'ATMMaximumBurstSize', 'ATMSustainableCellRate'];
  function LinkConfig() {
    var len = arguments.length;
    for(var i = 0; i < len; i++) {
      var key = keyArr[i];
      this[key] = arguments[i];
    }
  }
  return <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANDSLLinkConfig, LinkType|DestinationAddress|ATMEncapsulation|ATMQoS|ATMPeakCellRate|ATMMaximumBurstSize|ATMSustainableCellRate, LinkConfig);%>
}