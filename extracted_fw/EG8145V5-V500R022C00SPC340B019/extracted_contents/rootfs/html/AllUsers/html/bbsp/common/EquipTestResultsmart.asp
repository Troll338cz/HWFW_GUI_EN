function () {  
  function EquipResult(domain, result)
  {
    this.domain = domain;
    this.result = result;
  }
  
  function SelfTestResultClass() {
    var keyArr = ['domain', 'SD5113Result', 'WifiResult', 'ExtLswResult', 'CodecResult',
                    'OpticResult', 'Port1Result', 'Port2Result', 'Port3Result', 'Port4Result',
                    'Port5Result', 'Port6Result', 'ExtRfResult', 'DECTResult'];

    var len = arguments.length;
    for(var i = 0; i < len; i++) {
      var key = keyArr[i];
      this[key] = arguments[i];
    }
  }
  
  var stSelfTestResult = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.GetSelfTest, SD5113Result|WifiResult|ExtLswResult|CodecResult|OpticResult|Port1Result|Port2Result|Port3Result|Port4Result|Port5Result|Port6Result|ExtRfResult|DECTResult, SelfTestResultClass);%>;
  if (stSelfTestResult.length > 0)
  {
    var SelfTestResult = stSelfTestResult[0];
  }
  else
  {
    var SelfTestResult = new SelfTestResultClass("","","","","","","","","","","","","","");
  }
  var LinkTestResult = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.BBSP.ExtendPortTransCheck, result, EquipResult);%>';
  LinkTestResult = LinkTestResult.toString().replace(/&#40;/g, "\(");
  LinkTestResult = LinkTestResult.toString().replace(/&#41;/g, "\)");

  function EquipTestResultClass() {
    var keyArr = ['SD5113Result', 'WifiResult', 'ExtLswResult', 'CodecResult', 'OpticResult',
                    'Port1Result', 'Port2Result', 'Port3Result', 'Port4Result', 'Port5Result',
                    'Port6Result', 'LinkTestResult', 'ExtRfResult', 'DECTResult'];
  
    var len = arguments.length;
    for(var i = 0; i < len; i++) {
      var key = keyArr[i];
      this[key] = arguments[i];
    }
  }

  var stEquipTestResult = new EquipTestResultClass("0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
  stEquipTestResult.SD5113Result = SelfTestResult.SD5113Result;
  stEquipTestResult.WifiResult = SelfTestResult.WifiResult;
  stEquipTestResult.LswResult = SelfTestResult.LswResult;
  stEquipTestResult.CodecResult = SelfTestResult.CodecResult;
  stEquipTestResult.OpticResult = SelfTestResult.OpticResult;
  stEquipTestResult.Port1Result = SelfTestResult.Port1Result;
  stEquipTestResult.Port2Result = SelfTestResult.Port2Result;
  stEquipTestResult.Port3Result = SelfTestResult.Port3Result;
  stEquipTestResult.Port4Result = SelfTestResult.Port4Result;
  stEquipTestResult.Port5Result = SelfTestResult.Port5Result;
  stEquipTestResult.Port6Result = SelfTestResult.Port6Result;
  stEquipTestResult.ExtRfResult = SelfTestResult.ExtRfResult;
  stEquipTestResult.DECTResult = SelfTestResult.DECTResult;
  stEquipTestResult.LinkTestResult = LinkTestResult;

  return stEquipTestResult;
}