function() {
  var keyArr = ['wanMac', 'txPower', 'rxPower', 'oltRxPower', 'voltage', 'bias', 'temper', 'isTxCalibrated',
                'rxPowerMax', 'rxPowerMin', 'txPowerMax', 'txPowerMin', 'oltRxPowerMax', 'oltRxPowerMin',
                'voltageMax', 'voltageMin', 'biasMax', 'biasMin','temperMax', 'temperMin'
                ];
  function ApPonInfo() {
    var len = arguments.length;
    for(var i = 0; i < len; i++) {
      var key = keyArr[i];
      this[key] = arguments[i];
    }
  }
  return <%WEB_GetApPonInfo();%>;
}
