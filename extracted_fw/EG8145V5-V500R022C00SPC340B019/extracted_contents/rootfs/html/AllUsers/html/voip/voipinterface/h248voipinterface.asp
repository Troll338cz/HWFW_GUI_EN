<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <!--
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.js);%>"></script>
-->
  <title>VOIP Interface</title>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="JavaScript"
    src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipinterface, h248interface);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
  <script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
  <script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
  <script language="javascript" src="../common/voip_disableallelement.asp"></script>

  <script language="JavaScript" type="text/javascript">
    var selctIndex = -1;
    var CfgMode = '<%HW_WEB_GetCfgMode();%>';
    var SingTelMode = 0;
    var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";

    if ((CfgMode.toUpperCase() == 'SINGTEL') || (CfgMode.toUpperCase() == 'SINGTEL2')) {
      SingTelMode = 1;
    }

    var brazclaroMode = 0;
    if (CfgMode.toUpperCase() == 'BRAZCLARO') {
      brazclaroMode = 1;
    }

    var BhartiMode = 0;
    if (CfgMode.toUpperCase() == 'BHARTI') {
      BhartiMode = 1;
    }

    var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
    var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
    var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
    var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
    function isValidVoipPort(port) {
      if (!isInteger(port) || port < 0 || port > 65535) {
        return false;
      }

      return true;
    }

    function stProfile(Domain, Region, X_HW_DigitMapMatchMode, X_HW_PortName) {
      this.Domain = Domain;
      this.Region = Region;
      this.X_HW_DigitMapMatchMode = X_HW_DigitMapMatchMode;
      this.X_HW_PortName = X_HW_PortName;
      var temp = Domain.split('.');
      this.key = '.' + temp[5] + '.';
    }

    var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1,Region|X_HW_DigitMapMatchMode|X_HW_PortName,stProfile);%>;
    var Profile = new Array();
    for (var i = 0; i < AllProfile.length - 1; i++)
      Profile[i] = AllProfile[i];

    function stExtendAttr(Domain, RTPTermIDPrefix, RTPTermIDStartNum, RTPTermIDNumWidth) {
      this.Domain = Domain;
      this.RTPTermIDPrefix = RTPTermIDPrefix;
      this.RTPTermIDStartNum = RTPTermIDStartNum;
      this.RTPTermIDNumWidth = RTPTermIDNumWidth;
    }
    var ExtendAttrs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP.X_HW_Extend,RTPTermIDPrefix|RTPTermIDStartNum|RTPTermIDNumWidth,stExtendAttr);%>;
    var ExtendAttr = ExtendAttrs[0];

    function stRTP(Domain, PortName) {
      this.Domain = Domain;
      this.PortName = PortName;
    }
    var RTPs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP,X_HW_PortName,stRTP);%>;
    var RTP = RTPs[0];

    function stH248Server(Domain, CallAgent1, CallAgentPort1, CallAgent2, CallAgentPort2, LocalPort, MGDomain, DeviceName, MIDFormat) {
      this.Domain = Domain;
      this.CallAgent1 = CallAgent1;
      this.CallAgentPort1 = CallAgentPort1;
      this.CallAgent2 = CallAgent2;
      this.LocalPort = LocalPort;
      this.MGDomain = MGDomain;
      this.DeviceName = DeviceName;
      this.MIDFormat = MIDFormat;
      this.key = "";
      this.CallAgentPort2 = CallAgentPort2;

      var temp = Domain.split('.');
      this.key = '.' + temp[5] + '.';
    }

    var AllH248Server = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248,CallAgent1|CallAgentPort1|CallAgent2|CallAgentPort2|LocalPort|Domain|DeviceName|MIDFormat,stH248Server);%>;
    var H248Server = new Array();
    for (var i = 0; i < AllH248Server.length; i++)
      H248Server[i] = AllH248Server[i];


    AssociateParam1(Profile, H248Server, 'CallAgent1|CallAgentPort1|CallAgent2|CallAgentPort2|LocalPort|Domain|DeviceName|MIDFormat');


    var varDmAutoEnable = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Extend.DigitMapAutoMatchEnable);%>;

    function AssociateParam1(dest, src, name) {
      var destObj = dest;
      var srcObj = src;
      var NameArray = name.split('|');
      for (j = 0; j < destObj.length; j++) {
        if (destObj[j] == null)
          break;
        for (i = 0; i < srcObj.length; i++) {
          if (srcObj[i] == null)
            break;
          if (destObj[j].key.indexOf(srcObj[i].key) > -1) {
            try {
              dest[j].Relating = src[i];
            }
            catch (e) { }
            for (k = 0; k < NameArray.length; k++) {
              if (NameArray[k] == '') {
                continue;
              }
              try {
                if ("Domain" == NameArray[k]) {
                  NameArray[k] = "MGDomain";
                }
                dest[j][NameArray[k]] = src[i][NameArray[k]];
              }
              catch (e) { }
            }
            break;
          }
        }
      }
    }

    function ValidVoipWan(wan) {
      return ((true == wan.Enable) && (wan.ServiceList.toUpperCase().indexOf("VOIP") >= 0));
    }

    var WanInfo = GetWanListByFilter(ValidVoipWan);

    function MakeVoipWanName(wan) {
      var wanInst = 0;
      var wanServiceList = '';
      var currentWanName = '';

      DomainElement = wan.domain.split(".");
      wanInst = DomainElement[4];

      wanServiceList = wan.ServiceList;

      currentWanName = "wan" + wanInst;
      return currentWanName;
    }

    function SelectProfileRecord(recordId) {
      selectLine(recordId);
    }

    function init() {
      if (Profile[0].CallAgent1 == "255.255.255.255") {
        Profile[0].CallAgent1 = "";
      }

      if (Profile[0].CallAgent2 == "255.255.255.255") {
        Profile[0].CallAgent2 = "";
      }

      setText('CallAgent1', Profile[0].CallAgent1);
      setText('CallAgentPort1', Profile[0].CallAgentPort1);
      setText('CallAgent2', Profile[0].CallAgent2);
      setText('CallAgentPort2', Profile[0].CallAgentPort2);
      setText('MGDomain', Profile[0].MGDomain);
      setText('LocalPort', Profile[0].LocalPort);
      setText('DeviceName', Profile[0].DeviceName);
      setText("MIDFormat", Profile[0].MIDFormat);
      setSelect('Region', Profile[0].Region);
      setSelect('X_HW_DigitMapMatchMode', Profile[0].X_HW_DigitMapMatchMode);
      var wanSigValue;
      for (k = 0; k < WanInfo.length; k++) {
        if (MakeVoipWanName(WanInfo[k]) == Profile[0].X_HW_PortName) {
          wanSigValue = domainTowanname(WanInfo[k].domain);
          break;
        }
      }
      if (k == WanInfo.length) {
        wanSigValue = Profile[0].X_HW_PortName;
      }
      setSelect('X_HW_PortName', wanSigValue);

      var wanRtpValue;
      for (k = 0; k < WanInfo.length; k++) {
        if (MakeVoipWanName(WanInfo[k]) == RTP.PortName) {
          wanRtpValue = domainTowanname(WanInfo[k].domain);
          break;
        }
      }
      if (k == WanInfo.length) {
        wanRtpValue = RTP.PortName;
      }
      setSelect('MediaPortName', wanRtpValue);

      setText("RTPTermIDPrefix", ExtendAttr.RTPTermIDPrefix);
      setText("RTPTermIDStartNum", ExtendAttr.RTPTermIDStartNum);
      setText("RTPTermIDNumWidth", ExtendAttr.RTPTermIDNumWidth);
      setCheck('DmAutoEnable', varDmAutoEnable);

      if (1 == SingTelMode) {
        setDisplay('X_HW_PortNameRow', 0);
        setDisplay('MediaPortNameRow', 0);
      }
    }

    function ShowTab(index, LineName, PhyReferenceList) {
      this.index = index;
      this.LineName = LineName;
      this.PhyReferenceList = PhyReferenceList;
    }

    function LoadFrame() {
      if (Line.length > 0) {
        selectLine('record_0');
        selectLine('tdVoipInfo_record_0');
        setDisplay('ConfigForm1', 1);
      }
      else {
        selectLine('record_no');
        setDisplay('ConfigForm1', 0);
      }
      init();

      if (1 == BhartiMode) {
        DisableAllElement();
      }

      var all = document.getElementsByTagName("td");
      for (var i = 0; i < all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
          continue;
        }
        b.innerHTML = h248interface[b.getAttribute("BindText")];
      }

      if (isOltVisualUser == 1) {
        var all_input = document.getElementsByTagName("input");
        for (var i = 0; i < all_input.length; i++) {
          var b_input = all_input[i];

          if (b_input.type == "button") {
            setDisable(b_input.id, 1);
          }
          else {
            b_input.disabled = "disabled";
          }
        }
        $("select").attr("disabled", true);
      }
    }

    var g_Index = -1;

    function isIpAddress(address) {
      var i = 0;

      var addrParts = address.split('.');
      if (addrParts.length != 4) {
        return false;
      }

      for (i = 0; i < 4; i++) {
        if (isNaN(addrParts[i]) || addrParts[i] == ""
          || addrParts[i].charAt(0) == '+' || addrParts[i].charAt(0) == '-') {
          return false;
        }
        if (!isInteger(addrParts[i]) || addrParts[i] < 0) {
          return false;
        }
      }
      return true;
    }

    function isvalidVoipIpAddress(address) {
      var i = 0;
      if (address == '255.255.255.255') {
        return false;
      }

      if (address == '0.0.0.0') {
        return true;
      }

      var addrParts = address.split('.');
      if (addrParts.length != 4) return false;
      for (i = 0; i < 4; i++) {
        if (isNaN(addrParts[i]) || addrParts[i] == ""
          || addrParts[i].charAt(0) == '+' || addrParts[i].charAt(0) == '-')
          return false;

        if (addrParts[i].length > 3 || addrParts[i].length < 1) {
          return false;
        }

        if (addrParts[i].length > 1 && addrParts[i].charAt(0) == '0') {
          return false;
        }
        if (!isInteger(addrParts[i]) || addrParts[i] < 0) {
          return false;
        }
        num = parseInt(addrParts[i]);
        if (num < 0 || num > 255)
          return false;
      }
      return true;
    }

    function isValidNumWidth(numWidth) {
      if ((numWidth < 0) || (numWidth > 16)) {
        return false;
      }
      return true;
    }

    function vspaisValidCfgStr(cfgName, val, len) {
      if (isValidAscii(val) != '') {
        AlertEx(cfgName + h248interface['vspa_hasvalidch'] + isValidAscii(val) + h248interface['vspa_end']);
        return false;
      }
      if (val.length > len) {
        AlertEx(cfgName + h248interface['vspa_cantexceed'] + len + h248interface['vspa_characters']);
        return false;
      }
    }

    function CheckForm1() {
      var Region = document.getElementById('Region');
      var CallAgent1 = document.getElementById('CallAgent1');
      var CallAgentPort1 = document.getElementById('CallAgentPort1');
      var CallAgentPort2 = document.getElementById('CallAgentPort2');
      var X_HW_PortName = document.getElementById('X_HW_PortName');
      var LocalPort = document.getElementById('LocalPort');
      var CallAgent2 = document.getElementById('CallAgent2');
      var MGDomain = document.getElementById('MGDomain');
      var DeviceName = document.getElementById('DeviceName');
      var MIDFormat = document.getElementById('MIDFormat');
      var RTPTermIDPrefix = document.getElementById('RTPTermIDPrefix');
      var RTPTermIDStartNum = document.getElementById('RTPTermIDStartNum');
      var RTPTermIDNumWidth = document.getElementById('RTPTermIDNumWidth');
      var MediaPortName = document.getElementById('MediaPortName');

      if ('' == removeSpaceTrim(getValue('CallAgent1'))) {
        AlertEx(h248interface['vspa_primgcreq']);
        return false;
      }
      else {
        if (true == isIpAddress(getValue('CallAgent1'))) {
          if (false == isvalidVoipIpAddress(CallAgent1.value)) {
            AlertEx(h248interface['vspa_primgcaddinva']);
            return false;
          }
        }
        else {
          if (false == vspaisValidCfgStr(h248interface['vspa_theprimgc'], CallAgent1.value, 65)) {
            return false;
          }

        }
      }

      if ('' != removeSpaceTrim(RTPTermIDNumWidth.value)) {
        var numWidth = RTPTermIDNumWidth.value;
        if (false == isValidNumWidth(numWidth)) {
          AlertEx(h248interface['vspa_tidwidinva']);
          return false;
        }
      }

      if ('' == CallAgentPort1.value) {
        AlertEx(h248interface['vspa_priportreq']);
        return false;
      }
      else {
        if (isValidVoipPort(CallAgentPort1.value) == false) {
          AlertEx(h248interface['vspa_theprport'] + CallAgentPort1.value + h248interface['vspa_isvalid']);
          return false;
        }
      }

      if ('' != removeSpaceTrim(CallAgent2.value)) {
        if (true == isIpAddress(CallAgent2.value)) {
          if (false == isvalidVoipIpAddress(CallAgent2.value)) {
            AlertEx(h248interface['vspa_thestmgaddinva']);
            return false;
          }
        }
        else {
          if (false == vspaisValidCfgStr(h248interface['vspa_standbymgc'], CallAgent2.value, 65)) {
            return false;
          }

        }
        if (CallAgent2.value != 0) {
          if ((true == isIpAddress(CallAgent1.value) && false == isIpAddress(CallAgent2.value))
            || (false == isIpAddress(CallAgent1.value) && true == isIpAddress(CallAgent2.value))) {
            AlertEx(h248interface['vspa_allthepri']);
            return false;
          }
        }

      }

      if ('' != removeSpaceTrim(CallAgentPort2.value)) {
        if (isValidVoipPort(CallAgentPort2.value) == false) {
          AlertEx(h248interface['vspa_thestmgcport'] + CallAgentPort2.value + h248interface['vspa_isvalid']);
          return false;
        }
      }

      if ('' != removeSpaceTrim(MGDomain.value)) {
        if (vspaisValidCfgStr(h248interface['vspa_themgdomain'], MGDomain.value, 65) == false) {
          return false;
        }
      }

      if ('' != removeSpaceTrim(DeviceName.value)) {
        if (vspaisValidCfgStr(h248interface['vspa_thedevicename'], DeviceName.value, 65) == false) {
          return false;
        }
      }

      if ('' == LocalPort.value) {
        AlertEx(h248interface['vspa_loportre']);
        return false;
      }
      else {
        if (isValidVoipPort(LocalPort.value) == false) {
          AlertEx(h248interface['vspa_thelocalpo'] + LocalPort.value + h248interface['vspa_isvalid']);
          return false;
        }
      }

      return true;
    }


    var selctIndex = -1;

    function stPhyInterface(Domain, InterfaceID) {
      this.Domain = Domain;
    }

    var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

    function stLine(Domain, Enable, PhyReferenceList) {
      this.Domain = Domain;
      this.PhyReferenceList = PhyReferenceList;

      if (Enable.toLowerCase() == 'enabled') {
        this.Enable = 1;
      }
      else {
        this.Enable = 0;
      }

      this.LineName = '';
      var temp = Domain.split('.');
      this.key = '.' + temp[7] + '.';
    }

    var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i},Enable|PhyReferenceList,stLine);%>;
    var Line = new Array();
    for (var i = 0; i < AllLine.length - 1; i++) {
      Line[i] = AllLine[i];
    }

    var AllLineInsNumArray = new Array();
    for (var j = 0; j < 68; j++) {

      AllLineInsNumArray[j] = 256;
    }

    for (var i = 0; i < AllLine.length - 1; i++) {
      var temp = AllLine[i].Domain.split('.');

      DomainStr = AllLine[i].Domain;
      index = DomainStr.charAt(DomainStr.length - 1);
      AllLineInsNumArray[index - 1] = index;
    }

    function FindFreeLineInst() {
      for (var i = 0; i < 68; i++) {
        if (256 == AllLineInsNumArray[i]) {
          return i + 1;
        }
      }

      return 256;
    }


    function stLineName(Domain, LineName) {
      this.Domain = Domain;
      if (LineName != null) {
        this.LineName = LineName.toString().replace(/&apos;/g, "\'");

      }
      else {
        this.LineName = LineName;
      }
      var temp = Domain.split('.');
      this.key = '.' + temp[7] + '.';
    }

    var AllLineName = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i}.X_HW_H248,LineName,stLineName);%>;
    var LineName = new Array();
    for (var i = 0; i < AllLineName.length - 1; i++)
      LineName[i] = AllLineName[i];

    AssociateParam(Line, LineName, 'LineName');

    var recordLineName;

    function SelectLineRecord(recordId) {
      selectLine(recordId);
      recordLineName = getElement("LineName").value;
    }

    function SubmitBasicPara() {
      var Form = new webSubmitForm();
      var sndMgcPort;
      var FreeLine;
      var ret = CheckForm1();
      if (ret != true) {
        return false;
      }

      ret = CheckBasicParaForm();
      if (ret != true) {
        return false;
      }

      if ('' == removeSpaceTrim(getValue('CallAgentPort2'))) {
        sndMgcPort = 0;
      }
      else {
        sndMgcPort = parseInt(getValue('CallAgentPort2'), 10);
      }

      Form.addParameter('x.Region', getValue('Region'));
      Form.addParameter('x.X_HW_DigitMapMatchMode', getValue('X_HW_DigitMapMatchMode'));

      Form.addParameter('y.CallAgent1', getValue('CallAgent1'));
      Form.addParameter('y.CallAgentPort1', parseInt(getValue('CallAgentPort1'), 10));
      Form.addParameter('y.CallAgentPort2', sndMgcPort);
      Form.addParameter('y.LocalPort', parseInt(getValue('LocalPort'), 10));
      Form.addParameter('y.CallAgent2', getValue('CallAgent2'));
      Form.addParameter('y.Domain', getValue('MGDomain'));
      Form.addParameter('y.DeviceName', getValue('DeviceName'));
      Form.addParameter('y.MIDFormat', getValue('MIDFormat'));
      Form.addParameter('z.RTPTermIDPrefix', getValue('RTPTermIDPrefix'));
      Form.addParameter('z.RTPTermIDStartNum', parseInt(getValue('RTPTermIDStartNum'), 10));
      Form.addParameter('z.RTPTermIDNumWidth', parseInt(getValue('RTPTermIDNumWidth'), 10));

      if (0 == SingTelMode) {
        Form.addParameter('x.X_HW_PortName', getValue('X_HW_PortName'));
        Form.addParameter('w.X_HW_PortName', getValue('MediaPortName'));
      }

      Form.addParameter('t.DigitMapAutoMatchEnable', getCheckVal('DmAutoEnable'));

      Form.addParameter('Add_a.PhyReferenceList', getValue('PhyReferenceList'));
      Form.addParameter('b.LineName', getValue('LineName'));

      if (getCheckVal('Enable') == 1) {
        Form.addParameter('Add_a.Enable', 'Enabled');
      }
      else {
        Form.addParameter('Add_a.Enable', 'Disabled');
      }

      Form.addParameter('x.X_HW_Token', getValue('onttoken'));
      if (selctIndex == -1) {
        FreeLine = FindFreeLineInst();
        Form.setAction('complex.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&z=' + ExtendAttr.Domain
          + '&w=' + RTP.Domain
          + '&t=' + Profile[0].Domain + '.X_HW_H248' + '.Extend'
          + '&Add_a=' + 'InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line'
          + '&b=' + 'InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.' + FreeLine + '.X_HW_H248'
          + '&RequestFile=html/voip/voipinterface/voipinterface.asp');

      }
      else if (selctIndex == -2) {
        Form.setAction('set.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&z=' + ExtendAttr.Domain
          + '&w=' + RTP.Domain
          + '&t=' + Profile[0].Domain + '.X_HW_H248' + '.Extend'
          + '&RequestFile=html/voip/voipinterface/voipinterface.asp');
      }
      else {
        Form.setAction('set.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&z=' + ExtendAttr.Domain
          + '&w=' + RTP.Domain
          + '&t=' + Profile[0].Domain + '.X_HW_H248' + '.Extend'
          + '&Add_a=' + Line[selctIndex].Domain
          + '&b=' + Line[selctIndex].Domain + '.X_HW_H248'
          + '&RequestFile=html/voip/voipinterface/voipinterface.asp');
      }
      setDisable('btnApplyVoipUser', 1);
      setDisable('cancelValue', 1);
      Form.submit();
    }

    var serverRecord = null;
    function setCtlDisplay(record) {
      setText('LineName', record.LineName);
      setSelect('PhyReferenceList', record.PhyReferenceList);
      setCheck('Enable', record.Enable);
    }

    var g_Index = -1;

    function setControl(index) {
      var record;
      selctIndex = index;

      if (index == -1) {
        if (Line.length > 3) {
          setDisplay('ConfigForm1', 0);
          AlertEx(h248interface['vspa_toomanyuser']);
          return false;
        }
        record = new stLine("", "", "", "", "Disabled", "0", "0");
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(record);
      }
      else if (index == -2) {
        setDisplay('ConfigForm1', 0);
      }
      else {
        record = Line[index];
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(record);
      }
      g_Index = index;
    }

    function clickRemove() {
      if (Line.length == 0) {
        AlertEx(h248interface['vspa_usercanotdel']);
        return;
      }

      if (selctIndex == -1) {
        AlertEx(h248interface['vspa_usercanotdel1']);
        return;
      }
      var rml = getElement('tdVoipInforml');
      var noChooseFlag = true;

      var SubmitForm = new webSubmitForm();

      if (rml.length > 0) {
        for (var i = 0; i < rml.length; i++) {
          if (rml[i].checked == true) {
            noChooseFlag = false;
            SubmitForm.addParameter(rml[i].value, '');
          }
        }
      }
      else if (rml.checked == true) {
        noChooseFlag = false;
        SubmitForm.addParameter(rml.value, '');
      }
      if (noChooseFlag) {
        AlertEx(h248interface['vspa_nouserdel']);
        return;
      }

      if (ConfirmEx(h248interface['vspa_del']) == false) {
        document.getElementById("DeleteButton").disabled = false;
        return;
      }
      setDisable('btnApplyVoipUser', 1);
      setDisable('cancelValue', 1);
      if (!noChooseFlag) {
        SubmitForm.setAction('del.cgi?RequestFile=html/voip/voipinterface/voipinterface.asp');
        SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
        SubmitForm.submit();
      }
    }

    function tdVoipInfoselectRemoveCnt() {
    }


    function CheckBasicParaForm() {
      if (selctIndex != -2) {
        if (vspaisValidCfgStr(h248interface['vspa_thelinename'], getValue('LineName'), 64) == false) {
          return false;
        }

        for (var i = 0; i < Line.length; i++) {
          if (selctIndex != i) {
            if ((getValue('PhyReferenceList') == Line[i].PhyReferenceList) && (getValue('PhyReferenceList') != '')) {
              AlertEx(h248interface['vspa_samepots']);
              return false;
            }
          }

        }
      }
      return true;
    }

    function CancelUserConfig() {
      init();
      if (selctIndex == -1 || selctIndex == -2) {
        var tableRow = getElement("voipUserTable");

        if (tableRow.rows.length == 1) {
          selectLine('record_no');
        }
        else if (tableRow.rows.length == 2) {
          addNullInst('VOIP User');
        }
        else {
          tableRow.deleteRow(tableRow.rows.length - 1);
          selectLine('record_0');
        }
      }
      else {
        var record = Line[selctIndex];
        setCtlDisplay(record);
      }
    }

    function DropDownListSelect(id, ArrayOption) {
      var Control = getElById(id);
      var i = 1;

      var Option = document.createElement("Option");
      Option.value = "";
      Option.innerText = "";
      Option.text = "";
      Control.appendChild(Option);


      var Option = document.createElement("Option");
      Option.value = "br0";
      Option.innerText = "br0";
      Option.text = "br0";
      Control.appendChild(Option);

      InitWanNameListControlWanname(id, ValidVoipWan);
    }

    function RegionSelect(id) {
      var Control = getElById(id);
      var Option = document.createElement("Option");
      Option.value = "";
      Option.innerText = "";
      Option.text = "";
      Control.appendChild(Option);

      var RegionEn = [
        ["AF", sipinterface['vspa_AF']],
        ["AX", sipinterface['vspa_AX']],
        ["AL", sipinterface['vspa_AL']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AS", sipinterface['vspa_AS']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["AR", sipinterface['vspa_AR']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["BS", sipinterface['vspa_BS']],
        ["BH", sipinterface['vspa_BH']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BY", sipinterface['vspa_BY']],
        ["BE", sipinterface['vspa_BE']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BT", sipinterface['vspa_BT']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BV", sipinterface['vspa_BV']],
        ["BR", sipinterface['vspa_BR']],
        ["IO", sipinterface['vspa_IO']],
        ["BN", sipinterface['vspa_BN']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["KH", sipinterface['vspa_KH']],
        ["CM", sipinterface['vspa_CM']],
        ["CA", sipinterface['vspa_CA']],
        ["CV", sipinterface['vspa_CV']],
        ["KY", sipinterface['vspa_KY']],
        ["CF", sipinterface['vspa_CF']],
        ["TD", sipinterface['vspa_TD']],
        ["CL", sipinterface['vspa_CL']],
        ["CN", sipinterface['vspa_CN']],
        ["CX", sipinterface['vspa_CX']],
        ["CC", sipinterface['vspa_CC']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["CK", sipinterface['vspa_CK']],
        ["CR", sipinterface['vspa_CR']],
        ["CI", sipinterface['vspa_CI']],
        ["HR", sipinterface['vspa_HR']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["CY", sipinterface['vspa_CY']],
        ["CZ", sipinterface['vspa_CZ']],
        ["KP", sipinterface['vspa_KP']],
        ["DK", sipinterface['vspa_DK']],
        ["DJ", sipinterface['vspa_DJ']],
        ["DM", sipinterface['vspa_DM']],
        ["DO", sipinterface['vspa_DO']],
        ["EC", sipinterface['vspa_EC']],
        ["EG", sipinterface['vspa_EG']],
        ["SV", sipinterface['vspa_SV']],
        ["GQ", sipinterface['vspa_GQ']],
        ["ER", sipinterface['vspa_ER']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["FK", sipinterface['vspa_FK']],
        ["FO", sipinterface['vspa_FO']],
        ["FJ", sipinterface['vspa_FJ']],
        ["FI", sipinterface['vspa_FI']],
        ["FR", sipinterface['vspa_FR']],
        ["GF", sipinterface['vspa_GF']],
        ["PF", sipinterface['vspa_PF']],
        ["TF", sipinterface['vspa_TF']],
        ["GA", sipinterface['vspa_GA']],
        ["GM", sipinterface['vspa_GM']],
        ["GE", sipinterface['vspa_GE']],
        ["DE", sipinterface['vspa_DE']],
        ["GH", sipinterface['vspa_GH']],
        ["GI", sipinterface['vspa_GI']],
        ["GR", sipinterface['vspa_GR']],
        ["GL", sipinterface['vspa_GL']],
        ["GD", sipinterface['vspa_GD']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GT", sipinterface['vspa_GT']],
        ["GG", sipinterface['vspa_GG']],
        ["GN", sipinterface['vspa_GN']],
        ["GW", sipinterface['vspa_GW']],
        ["GY", sipinterface['vspa_GY']],
        ["HT", sipinterface['vspa_HT']],
        ["HM", sipinterface['vspa_HM']],
        ["HN", sipinterface['vspa_HN']],
        ["HK", sipinterface['vspa_HK']],
        ["HU", sipinterface['vspa_HU']],
        ["IS", sipinterface['vspa_IS']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["IR", sipinterface['vspa_IR']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IE", sipinterface['vspa_IE']],
        ["IM", sipinterface['vspa_IM']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']],
        ["JE", sipinterface['vspa_JE']],
        ["JO", sipinterface['vspa_JO']],
        ["KZ", sipinterface['vspa_KZ']],
        ["KE", sipinterface['vspa_KE']],
        ["KI", sipinterface['vspa_KI']],
        ["KW", sipinterface['vspa_KW']],
        ["KG", sipinterface['vspa_KG']],
        ["LA", sipinterface['vspa_LA']],
        ["LV", sipinterface['vspa_LV']],
        ["LB", sipinterface['vspa_LB']],
        ["LS", sipinterface['vspa_LS']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LT", sipinterface['vspa_LT']],
        ["LU", sipinterface['vspa_LU']],
        ["MO", sipinterface['vspa_MO']],
        ["MG", sipinterface['vspa_MG']],
        ["MW", sipinterface['vspa_MW']],
        ["MY", sipinterface['vspa_MY']],
        ["MV", sipinterface['vspa_MV']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["MH", sipinterface['vspa_MH']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MR", sipinterface['vspa_MR']],
        ["MU", sipinterface['vspa_MU']],
        ["YT", sipinterface['vspa_YT']],
        ["MX", sipinterface['vspa_MX']],
        ["FM", sipinterface['vspa_FM']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MN", sipinterface['vspa_MN']],
        ["ME", sipinterface['vspa_ME']],
        ["MS", sipinterface['vspa_MS']],
        ["MA", sipinterface['vspa_MA']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MM", sipinterface['vspa_MM']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NL", sipinterface['vspa_NL']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NU", sipinterface['vspa_NU']],
        ["NF", sipinterface['vspa_NF']],
        ["MK", sipinterface['vspa_MK']],
        ["MP", sipinterface['vspa_MP']],
        ["NO", sipinterface['vspa_NO']],
        ["OM", sipinterface['vspa_OM']],
        ["PK", sipinterface['vspa_PK']],
        ["PW", sipinterface['vspa_PW']],
        ["PS", sipinterface['vspa_PS']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PH", sipinterface['vspa_PH']],
        ["PN", sipinterface['vspa_PN']],
        ["PL", sipinterface['vspa_PL']],
        ["PT", sipinterface['vspa_PT']],
        ["PR", sipinterface['vspa_PR']],
        ["QA", sipinterface['vspa_QA']],
        ["KR", sipinterface['vspa_KR']],
        ["RE", sipinterface['vspa_RE']],
        ["RO", sipinterface['vspa_RO']],
        ["RU", sipinterface['vspa_RU']],
        ["RW", sipinterface['vspa_RW']],
        ["BL", sipinterface['vspa_BL']],
        ["SH", sipinterface['vspa_SH']],
        ["KN", sipinterface['vspa_KN']],
        ["LC", sipinterface['vspa_LC']],
        ["MF", sipinterface['vspa_MF']],
        ["PM", sipinterface['vspa_PM']],
        ["VC", sipinterface['vspa_VC']],
        ["WS", sipinterface['vspa_WS']],
        ["SM", sipinterface['vspa_SM']],
        ["ST", sipinterface['vspa_ST']],
        ["SA", sipinterface['vspa_SA']],
        ["SN", sipinterface['vspa_SN']],
        ["RS", sipinterface['vspa_RS']],
        ["SC", sipinterface['vspa_SC']],
        ["SL", sipinterface['vspa_SL']],
        ["SG", sipinterface['vspa_SG']],
        ["SX", sipinterface['vspa_SX']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["SB", sipinterface['vspa_SB']],
        ["SO", sipinterface['vspa_SO']],
        ["ZA", sipinterface['vspa_ZA']],
        ["GS", sipinterface['vspa_GS']],
        ["SS", sipinterface['vspa_SS']],
        ["ES", sipinterface['vspa_ES']],
        ["LK", sipinterface['vspa_LK']],
        ["SD", sipinterface['vspa_SD']],
        ["SR", sipinterface['vspa_SR']],
        ["SJ", sipinterface['vspa_SJ']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["SY", sipinterface['vspa_SY']],
        ["TW", sipinterface['vspa_TW']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TH", sipinterface['vspa_TH']],
        ["CD", sipinterface['vspa_CD']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["TO", sipinterface['vspa_TO']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TR", sipinterface['vspa_TR']],
        ["TM", sipinterface['vspa_TM']],
        ["TC", sipinterface['vspa_TC']],
        ["TV", sipinterface['vspa_TV']],
        ["UG", sipinterface['vspa_UG']],
        ["UA", sipinterface['vspa_UA']],
        ["AE", sipinterface['vspa_AE']],
        ["GB", sipinterface['vspa_GB']],
        ["US", sipinterface['vspa_US']],
        ["UM", sipinterface['vspa_UM']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["VU", sipinterface['vspa_VU']],
        ["VA", sipinterface['vspa_VA']],
        ["VE", sipinterface['vspa_VE']],
        ["VN", sipinterface['vspa_VN']],
        ["VG", sipinterface['vspa_VG']],
        ["VI", sipinterface['vspa_VI']],
        ["WF", sipinterface['vspa_WF']],
        ["YE", sipinterface['vspa_YE']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']]];


      var RegionCh = [
        ["AL", sipinterface['vspa_AL']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AF", sipinterface['vspa_AF']],
        ["AR", sipinterface['vspa_AR']],
        ["AE", sipinterface['vspa_AE']],
        ["AW", sipinterface['vspa_AW']],
        ["OM", sipinterface['vspa_OM']],
        ["AZ", sipinterface['vspa_AZ']],
        ["EG", sipinterface['vspa_EG']],
        ["ET", sipinterface['vspa_ET']],
        ["IE", sipinterface['vspa_IE']],
        ["EE", sipinterface['vspa_EE']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AG", sipinterface['vspa_AG']],
        ["AT", sipinterface['vspa_AT']],
        ["AX", sipinterface['vspa_AX']],
        ["AU", sipinterface['vspa_AU']],
        ["MO", sipinterface['vspa_MO']],
        ["BB", sipinterface['vspa_BB']],
        ["PG", sipinterface['vspa_PG']],
        ["BS", sipinterface['vspa_BS']],
        ["PK", sipinterface['vspa_PK']],
        ["PY", sipinterface['vspa_PY']],
        ["PS", sipinterface['vspa_PS']],
        ["BH", sipinterface['vspa_BH']],
        ["PA", sipinterface['vspa_PA']],
        ["BR", sipinterface['vspa_BR']],
        ["BY", sipinterface['vspa_BY']],
        ["BM", sipinterface['vspa_BM']],
        ["BG", sipinterface['vspa_BG']],
        ["MP", sipinterface['vspa_MP']],
        ["MK", sipinterface['vspa_MK']],
        ["PW", sipinterface['vspa_PW']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BE", sipinterface['vspa_BE']],
        ["IS", sipinterface['vspa_IS']],
        ["PR", sipinterface['vspa_PR']],
        ["BA", sipinterface['vspa_BA']],
        ["PL", sipinterface['vspa_PL']],
        ["BO", sipinterface['vspa_BO']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BW", sipinterface['vspa_BW']],
        ["BT", sipinterface['vspa_BT']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["BV", sipinterface['vspa_BV']],
        ["KP", sipinterface['vspa_KP']],
        ["GQ", sipinterface['vspa_GQ']],
        ["DK", sipinterface['vspa_DK']],
        ["DE", sipinterface['vspa_DE']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["DO", sipinterface['vspa_DO']],
        ["DM", sipinterface['vspa_DM']],
        ["RU", sipinterface['vspa_RU']],
        ["EC", sipinterface['vspa_EC']],
        ["ER", sipinterface['vspa_ER']],
        ["FR", sipinterface['vspa_FR']],
        ["FO", sipinterface['vspa_FO']],
        ["PF", sipinterface['vspa_PF']],
        ["GF", sipinterface['vspa_GF']],
        ["TF", sipinterface['vspa_TF']],
        ["VA", sipinterface['vspa_VA']],
        ["PH", sipinterface['vspa_PH']],
        ["FJ", sipinterface['vspa_FJ']],
        ["FI", sipinterface['vspa_FI']],
        ["CV", sipinterface['vspa_CV']],
        ["FK", sipinterface['vspa_FK']],
        ["GM", sipinterface['vspa_GM']],
        ["CG", sipinterface['vspa_CG']],
        ["CD", sipinterface['vspa_CD']],
        ["CO", sipinterface['vspa_CO']],
        ["CR", sipinterface['vspa_CR']],
        ["GD", sipinterface['vspa_GD']],
        ["GL", sipinterface['vspa_GL']],
        ["GE", sipinterface['vspa_GE']],
        ["GG", sipinterface['vspa_GG']],
        ["CU", sipinterface['vspa_CU']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GY", sipinterface['vspa_GY']],
        ["KZ", sipinterface['vspa_KZ']],
        ["HT", sipinterface['vspa_HT']],
        ["KR", sipinterface['vspa_KR']],
        ["NL", sipinterface['vspa_NL']],
        ["BQ", sipinterface['vspa_BQ']],
        ["SX", sipinterface['vspa_SX']],
        ["HM", sipinterface['vspa_HM']],
        ["ME", sipinterface['vspa_ME']],
        ["HN", sipinterface['vspa_HN']],
        ["KI", sipinterface['vspa_KI']],
        ["DJ", sipinterface['vspa_DJ']],
        ["KG", sipinterface['vspa_KG']],
        ["GN", sipinterface['vspa_GN']],
        ["GW", sipinterface['vspa_GW']],
        ["CA", sipinterface['vspa_CA']],
        ["GH", sipinterface['vspa_GH']],
        ["GA", sipinterface['vspa_GA']],
        ["KH", sipinterface['vspa_KH']],
        ["CZ", sipinterface['vspa_CZ']],
        ["ZW", sipinterface['vspa_ZW']],
        ["CM", sipinterface['vspa_CM']],
        ["QA", sipinterface['vspa_QA']],
        ["KY", sipinterface['vspa_KY']],
        ["CC", sipinterface['vspa_CC']],
        ["KM", sipinterface['vspa_KM']],
        ["CI", sipinterface['vspa_CI']],
        ["KW", sipinterface['vspa_KW']],
        ["HR", sipinterface['vspa_HR']],
        ["KE", sipinterface['vspa_KE']],
        ["CK", sipinterface['vspa_CK']],
        ["CW", sipinterface['vspa_CW']],
        ["LV", sipinterface['vspa_LV']],
        ["LS", sipinterface['vspa_LS']],
        ["LA", sipinterface['vspa_LA']],
        ["LB", sipinterface['vspa_LB']],
        ["LT", sipinterface['vspa_LT']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["RE", sipinterface['vspa_RE']],
        ["LU", sipinterface['vspa_LU']],
        ["RW", sipinterface['vspa_RW']],
        ["RO", sipinterface['vspa_RO']],
        ["MG", sipinterface['vspa_MG']],
        ["IM", sipinterface['vspa_IM']],
        ["MV", sipinterface['vspa_MV']],
        ["MT", sipinterface['vspa_MT']],
        ["MW", sipinterface['vspa_MW']],
        ["MY", sipinterface['vspa_MY']],
        ["ML", sipinterface['vspa_ML']],
        ["MH", sipinterface['vspa_MH']],
        ["MQ", sipinterface['vspa_MQ']],
        ["YT", sipinterface['vspa_YT']],
        ["MU", sipinterface['vspa_MU']],
        ["MR", sipinterface['vspa_MR']],
        ["US", sipinterface['vspa_US']],
        ["UM", sipinterface['vspa_UM']],
        ["AS", sipinterface['vspa_AS']],
        ["MN", sipinterface['vspa_MN']],
        ["MS", sipinterface['vspa_MS']],
        ["BD", sipinterface['vspa_BD']],
        ["PE", sipinterface['vspa_PE']],
        ["FM", sipinterface['vspa_FM']],
        ["MM", sipinterface['vspa_MM']],
        ["MD", sipinterface['vspa_MD']],
        ["MA", sipinterface['vspa_MA']],
        ["MC", sipinterface['vspa_MC']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MX", sipinterface['vspa_MX']],
        ["NA", sipinterface['vspa_NA']],
        ["ZA", sipinterface['vspa_ZA']],
        ["AQ", sipinterface['vspa_AQ']],
        ["GS", sipinterface['vspa_GS']],
        ["SS", sipinterface['vspa_SS']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NU", sipinterface['vspa_NU']],
        ["NO", sipinterface['vspa_NO']],
        ["NF", sipinterface['vspa_NF']],
        ["PN", sipinterface['vspa_PN']],
        ["PT", sipinterface['vspa_PT']],
        ["JP", sipinterface['vspa_JP']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["SV", sipinterface['vspa_SV']],
        ["WS", sipinterface['vspa_WS']],
        ["RS", sipinterface['vspa_RS']],
        ["SL", sipinterface['vspa_SL']],
        ["SN", sipinterface['vspa_SN']],
        ["CY", sipinterface['vspa_CY']],
        ["SC", sipinterface['vspa_SC']],
        ["SA", sipinterface['vspa_SA']],
        ["BL", sipinterface['vspa_BL']],
        ["PM", sipinterface['vspa_PM']],
        ["CX", sipinterface['vspa_CX']],
        ["ST", sipinterface['vspa_ST']],
        ["SH", sipinterface['vspa_SH']],
        ["KN", sipinterface['vspa_KN']],
        ["LC", sipinterface['vspa_LC']],
        ["MF", sipinterface['vspa_MF']],
        ["SM", sipinterface['vspa_SM']],
        ["VC", sipinterface['vspa_VC']],
        ["LK", sipinterface['vspa_LK']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["SJ", sipinterface['vspa_SJ']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SD", sipinterface['vspa_SD']],
        ["SR", sipinterface['vspa_SR']],
        ["SB", sipinterface['vspa_SB']],
        ["SO", sipinterface['vspa_SO']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TH", sipinterface['vspa_TH']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TO", sipinterface['vspa_TO']],
        ["TC", sipinterface['vspa_TC']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TV", sipinterface['vspa_TV']],
        ["TR", sipinterface['vspa_TR']],
        ["TM", sipinterface['vspa_TM']],
        ["TK", sipinterface['vspa_TK']],
        ["WF", sipinterface['vspa_WF']],
        ["VU", sipinterface['vspa_VU']],
        ["GT", sipinterface['vspa_GT']],
        ["VI", sipinterface['vspa_VI']],
        ["VG", sipinterface['vspa_VG']],
        ["VE", sipinterface['vspa_VE']],
        ["BN", sipinterface['vspa_BN']],
        ["UG", sipinterface['vspa_UG']],
        ["UA", sipinterface['vspa_UA']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["ES", sipinterface['vspa_ES']],
        ["GR", sipinterface['vspa_GR']],
        ["HK", sipinterface['vspa_HK']],
        ["SG", sipinterface['vspa_SG']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["HU", sipinterface['vspa_HU']],
        ["SY", sipinterface['vspa_SY']],
        ["JM", sipinterface['vspa_JM']],
        ["AM", sipinterface['vspa_AM']],
        ["YE", sipinterface['vspa_YE']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IR", sipinterface['vspa_IR']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["GB", sipinterface['vspa_GB']],
        ["IO", sipinterface['vspa_IO']],
        ["JO", sipinterface['vspa_JO']],
        ["VN", sipinterface['vspa_VN']],
        ["ZM", sipinterface['vspa_ZM']],
        ["JE", sipinterface['vspa_JE']],
        ["TD", sipinterface['vspa_TD']],
        ["GI", sipinterface['vspa_GI']],
        ["CL", sipinterface['vspa_CL']],
        ["CF", sipinterface['vspa_CF']],
        ["CN", sipinterface['vspa_CN']],
        ["TW", sipinterface['vspa_TW']]];

      var RegionSpa = [
        ["AF", sipinterface['vspa_AF']],
        ["CF", sipinterface['vspa_CF']],
        ["AL", sipinterface['vspa_AL']],
        ["DE", sipinterface['vspa_DE']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["SA", sipinterface['vspa_SA']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AR", sipinterface['vspa_AR']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["BS", sipinterface['vspa_BS']],
        ["BH", sipinterface['vspa_BH']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BE", sipinterface['vspa_BE']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BY", sipinterface['vspa_BY']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BR", sipinterface['vspa_BR']],
        ["BN", sipinterface['vspa_BN']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["BT", sipinterface['vspa_BT']],
        ["CV", sipinterface['vspa_CV']],
        ["KH", sipinterface['vspa_KH']],
        ["CM", sipinterface['vspa_CM']],
        ["CA", sipinterface['vspa_CA']],
        ["TD", sipinterface['vspa_TD']],
        ["CL", sipinterface['vspa_CL']],
        ["CN", sipinterface['vspa_CN']],
        ["CY", sipinterface['vspa_CY']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["CI", sipinterface['vspa_CI']],
        ["CR", sipinterface['vspa_CR']],
        ["HR", sipinterface['vspa_HR']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["DK", sipinterface['vspa_DK']],
        ["DM", sipinterface['vspa_DM']],
        ["EC", sipinterface['vspa_EC']],
        ["EG", sipinterface['vspa_EG']],
        ["SV", sipinterface['vspa_SV']],
        ["VA", sipinterface['vspa_VA']],
        ["AE", sipinterface['vspa_AE']],
        ["ER", sipinterface['vspa_ER']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["ES", sipinterface['vspa_ES']],
        ["US", sipinterface['vspa_US']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["PH", sipinterface['vspa_PH']],
        ["FI", sipinterface['vspa_FI']],
        ["FJ", sipinterface['vspa_FJ']],
        ["FR", sipinterface['vspa_FR']],
        ["GA", sipinterface['vspa_GA']],
        ["GM", sipinterface['vspa_GM']],
        ["GE", sipinterface['vspa_GE']],
        ["GH", sipinterface['vspa_GH']],
        ["GI", sipinterface['vspa_GI']],
        ["GD", sipinterface['vspa_GD']],
        ["GR", sipinterface['vspa_GR']],
        ["GL", sipinterface['vspa_GL']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GT", sipinterface['vspa_GT']],
        ["GF", sipinterface['vspa_GF']],
        ["GG", sipinterface['vspa_GG']],
        ["GN", sipinterface['vspa_GN']],
        ["GQ", sipinterface['vspa_GQ']],
        ["GW", sipinterface['vspa_GW']],
        ["GY", sipinterface['vspa_GY']],
        ["HT", sipinterface['vspa_HT']],
        ["HN", sipinterface['vspa_HN']],
        ["HU", sipinterface['vspa_HU']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IR", sipinterface['vspa_IR']],
        ["IE", sipinterface['vspa_IE']],
        ["BV", sipinterface['vspa_BV']],
        ["IM", sipinterface['vspa_IM']],
        ["CX", sipinterface['vspa_CX']],
        ["NF", sipinterface['vspa_NF']],
        ["IS", sipinterface['vspa_IS']],
        ["AX", sipinterface['vspa_AX']],
        ["KY", sipinterface['vspa_KY']],
        ["CC", sipinterface['vspa_CC']],
        ["CK", sipinterface['vspa_CK']],
        ["FO", sipinterface['vspa_FO']],
        ["GS", sipinterface['vspa_GS']],
        ["HM", sipinterface['vspa_HM']],
        ["FK", sipinterface['vspa_FK']],
        ["MP", sipinterface['vspa_MP']],
        ["MH", sipinterface['vspa_MH']],
        ["SB", sipinterface['vspa_SB']],
        ["TC", sipinterface['vspa_TC']],
        ["UM", sipinterface['vspa_UM']],
        ["VG", sipinterface['vspa_VG']],
        ["VI", sipinterface['vspa_VI']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']],
        ["JE", sipinterface['vspa_JE']],
        ["JO", sipinterface['vspa_JO']],
        ["KZ", sipinterface['vspa_KZ']],
        ["KE", sipinterface['vspa_KE']],
        ["KG", sipinterface['vspa_KG']],
        ["KI", sipinterface['vspa_KI']],
        ["KW", sipinterface['vspa_KW']],
        ["LA", sipinterface['vspa_LA']],
        ["LS", sipinterface['vspa_LS']],
        ["LV", sipinterface['vspa_LV']],
        ["LB", sipinterface['vspa_LB']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LT", sipinterface['vspa_LT']],
        ["LU", sipinterface['vspa_LU']],
        ["MK", sipinterface['vspa_MK']],
        ["MG", sipinterface['vspa_MG']],
        ["MY", sipinterface['vspa_MY']],
        ["MW", sipinterface['vspa_MW']],
        ["MV", sipinterface['vspa_MV']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["MA", sipinterface['vspa_MA']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MU", sipinterface['vspa_MU']],
        ["MR", sipinterface['vspa_MR']],
        ["YT", sipinterface['vspa_YT']],
        ["MX", sipinterface['vspa_MX']],
        ["FM", sipinterface['vspa_FM']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MN", sipinterface['vspa_MN']],
        ["ME", sipinterface['vspa_ME']],
        ["MS", sipinterface['vspa_MS']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MM", sipinterface['vspa_MM']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NU", sipinterface['vspa_NU']],
        ["NO", sipinterface['vspa_NO']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["OM", sipinterface['vspa_OM']],
        ["NL", sipinterface['vspa_NL']],
        ["PK", sipinterface['vspa_PK']],
        ["PW", sipinterface['vspa_PW']],
        ["PS", sipinterface['vspa_PS']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PN", sipinterface['vspa_PN']],
        ["PF", sipinterface['vspa_PF']],
        ["PL", sipinterface['vspa_PL']],
        ["PT", sipinterface['vspa_PT']],
        ["PR", sipinterface['vspa_PR']],
        ["QA", sipinterface['vspa_QA']],
        ["HK", sipinterface['vspa_HK']],
        ["MO", sipinterface['vspa_MO']],
        ["GB", sipinterface['vspa_GB']],
        ["CZ", sipinterface['vspa_CZ']],
        ["KR", sipinterface['vspa_KR']],
        ["CD", sipinterface['vspa_CD']],
        ["DO", sipinterface['vspa_DO']],
        ["KP", sipinterface['vspa_KP']],
        ["RE", sipinterface['vspa_RE']],
        ["RW", sipinterface['vspa_RW']],
        ["RO", sipinterface['vspa_RO']],
        ["RU", sipinterface['vspa_RU']],
        ["WS", sipinterface['vspa_WS']],
        ["AS", sipinterface['vspa_AS']],
        ["BL", sipinterface['vspa_BL']],
        ["KN", sipinterface['vspa_KN']],
        ["SM", sipinterface['vspa_SM']],
        ["MF", sipinterface['vspa_MF']],
        ["PM", sipinterface['vspa_PM']],
        ["VC", sipinterface['vspa_VC']],
        ["SH", sipinterface['vspa_SH']],
        ["LC", sipinterface['vspa_LC']],
        ["ST", sipinterface['vspa_ST']],
        ["SN", sipinterface['vspa_SN']],
        ["RS", sipinterface['vspa_RS']],
        ["SC", sipinterface['vspa_SC']],
        ["SL", sipinterface['vspa_SL']],
        ["SG", sipinterface['vspa_SG']],
        ["SX", sipinterface['vspa_SX']],
        ["SY", sipinterface['vspa_SY']],
        ["SO", sipinterface['vspa_SO']],
        ["LK", sipinterface['vspa_LK']],
        ["SZ", sipinterface['vspa_SZ']],
        ["ZA", sipinterface['vspa_ZA']],
        ["SD", sipinterface['vspa_SD']],
        ["SS", sipinterface['vspa_SS']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["SR", sipinterface['vspa_SR']],
        ["SJ", sipinterface['vspa_SJ']],
        ["TH", sipinterface['vspa_TH']],
        ["TW", sipinterface['vspa_TW']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TJ", sipinterface['vspa_TJ']],
        ["IO", sipinterface['vspa_IO']],
        ["TF", sipinterface['vspa_TF']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["TO", sipinterface['vspa_TO']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TM", sipinterface['vspa_TM']],
        ["TR", sipinterface['vspa_TR']],
        ["TV", sipinterface['vspa_TV']],
        ["UA", sipinterface['vspa_UA']],
        ["UG", sipinterface['vspa_UG']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["VU", sipinterface['vspa_VU']],
        ["VE", sipinterface['vspa_VE']],
        ["VN", sipinterface['vspa_VN']],
        ["WF", sipinterface['vspa_WF']],
        ["YE", sipinterface['vspa_YE']],
        ["DJ", sipinterface['vspa_DJ']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']]];

      var RegionArb = [
        ["ET", sipinterface['vspa_ET']],
        ["AZ", sipinterface['vspa_AZ']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["ER", sipinterface['vspa_ER']],
        ["ES", sipinterface['vspa_ES']],
        ["AU", sipinterface['vspa_AU']],
        ["EE", sipinterface['vspa_EE']],
        ["IL", sipinterface['vspa_IL']],
        ["CF", sipinterface['vspa_CF']],
        ["AF", sipinterface['vspa_AF']],
        ["IO", sipinterface['vspa_IO']],
        ["TF", sipinterface['vspa_TF']],
        ["AR", sipinterface['vspa_AR']],
        ["JO", sipinterface['vspa_JO']],
        ["EC", sipinterface['vspa_EC']],
        ["AE", sipinterface['vspa_AE']],
        ["AL", sipinterface['vspa_AL']],
        ["BH", sipinterface['vspa_BH']],
        ["BR", sipinterface['vspa_BR']],
        ["PT", sipinterface['vspa_PT']],
        ["BA", sipinterface['vspa_BA']],
        ["ME", sipinterface['vspa_ME']],
        ["DZ", sipinterface['vspa_DZ']],
        ["VI", sipinterface['vspa_VI']],
        ["VG", sipinterface['vspa_VG']],
        ["DK", sipinterface['vspa_DK']],
        ["SV", sipinterface['vspa_SV']],
        ["SN", sipinterface['vspa_SN']],
        ["SD", sipinterface['vspa_SD']],
        ["SE", sipinterface['vspa_SE']],
        ["SO", sipinterface['vspa_SO']],
        ["IQ", sipinterface['vspa_IQ']],
        ["GA", sipinterface['vspa_GA']],
        ["VA", sipinterface['vspa_VA']],
        ["PH", sipinterface['vspa_PH']],
        ["CM", sipinterface['vspa_CM']],
        ["CG", sipinterface['vspa_CG']],
        ["CD", sipinterface['vspa_CD']],
        ["KW", sipinterface['vspa_KW']],
        ["DE", sipinterface['vspa_DE']],
        ["HU", sipinterface['vspa_HU']],
        ["MA", sipinterface['vspa_MA']],
        ["MX", sipinterface['vspa_MX']],
        ["SA", sipinterface['vspa_SA']],
        ["NO", sipinterface['vspa_NO']],
        ["AT", sipinterface['vspa_AT']],
        ["NE", sipinterface['vspa_NE']],
        ["IN", sipinterface['vspa_IN']],
        ["US", sipinterface['vspa_US']],
        ["JP", sipinterface['vspa_JP']],
        ["YE", sipinterface['vspa_YE']],
        ["GR", sipinterface['vspa_GR']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AD", sipinterface['vspa_AD']],
        ["ID", sipinterface['vspa_ID']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["UG", sipinterface['vspa_UG']],
        ["UA", sipinterface['vspa_UA']],
        ["IR", sipinterface['vspa_IR']],
        ["IE", sipinterface['vspa_IE']],
        ["IS", sipinterface['vspa_IS']],
        ["IT", sipinterface['vspa_IT']],
        ["PG", sipinterface['vspa_PG']],
        ["PY", sipinterface['vspa_PY']],
        ["BB", sipinterface['vspa_BB']],
        ["PK", sipinterface['vspa_PK']],
        ["PW", sipinterface['vspa_PW']],
        ["CN", sipinterface['vspa_CN']],
        ["BM", sipinterface['vspa_BM']],
        ["BN", sipinterface['vspa_BN']],
        ["GB", sipinterface['vspa_GB']],
        ["BE", sipinterface['vspa_BE']],
        ["BG", sipinterface['vspa_BG']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BD", sipinterface['vspa_BD']],
        ["PA", sipinterface['vspa_PA']],
        ["BT", sipinterface['vspa_BT']],
        ["BW", sipinterface['vspa_BW']],
        ["PR", sipinterface['vspa_PR']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["PL", sipinterface['vspa_PL']],
        ["BO", sipinterface['vspa_BO']],
        ["PF", sipinterface['vspa_PF']],
        ["BQ", sipinterface['vspa_BQ']],
        ["PN", sipinterface['vspa_PN']],
        ["PE", sipinterface['vspa_PE']],
        ["BJ", sipinterface['vspa_BJ']],
        ["TH", sipinterface['vspa_TH']],
        ["TW", sipinterface['vspa_TW']],
        ["TM", sipinterface['vspa_TM']],
        ["TR", sipinterface['vspa_TR']],
        ["TT", sipinterface['vspa_TT']],
        ["TD", sipinterface['vspa_TD']],
        ["CL", sipinterface['vspa_CL']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TG", sipinterface['vspa_TG']],
        ["TV", sipinterface['vspa_TV']],
        ["TK", sipinterface['vspa_TK']],
        ["TN", sipinterface['vspa_TN']],
        ["TO", sipinterface['vspa_TO']],
        ["TL", sipinterface['vspa_TL']],
        ["JM", sipinterface['vspa_JM']],
        ["GI", sipinterface['vspa_GI']],
        ["AX", sipinterface['vspa_AX']],
        ["BS", sipinterface['vspa_BS']],
        ["KM", sipinterface['vspa_KM']],
        ["MH", sipinterface['vspa_MH']],
        ["MV", sipinterface['vspa_MV']],
        ["UM", sipinterface['vspa_UM']],
        ["TC", sipinterface['vspa_TC']],
        ["SB", sipinterface['vspa_SB']],
        ["FO", sipinterface['vspa_FO']],
        ["FK", sipinterface['vspa_FK']],
        ["KY", sipinterface['vspa_KY']],
        ["CK", sipinterface['vspa_CK']],
        ["CC", sipinterface['vspa_CC']],
        ["CV", sipinterface['vspa_CV']],
        ["CX", sipinterface['vspa_CX']],
        ["BV", sipinterface['vspa_BV']],
        ["IM", sipinterface['vspa_IM']],
        ["NF", sipinterface['vspa_NF']],
        ["HM", sipinterface['vspa_HM']],
        ["CZ", sipinterface['vspa_CZ']],
        ["DO", sipinterface['vspa_DO']],
        ["KR", sipinterface['vspa_KR']],
        ["KP", sipinterface['vspa_KP']],
        ["ZA", sipinterface['vspa_ZA']],
        ["SS", sipinterface['vspa_SS']],
        ["GE", sipinterface['vspa_GE']],
        ["GS", sipinterface['vspa_GS']],
        ["DJ", sipinterface['vspa_DJ']],
        ["JE", sipinterface['vspa_JE']],
        ["DM", sipinterface['vspa_DM']],
        ["RW", sipinterface['vspa_RW']],
        ["RU", sipinterface['vspa_RU']],
        ["BY", sipinterface['vspa_BY']],
        ["RO", sipinterface['vspa_RO']],
        ["RE", sipinterface['vspa_RE']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']],
        ["CI", sipinterface['vspa_CI']],
        ["WS", sipinterface['vspa_WS']],
        ["AS", sipinterface['vspa_AS']],
        ["BL", sipinterface['vspa_BL']],
        ["PM", sipinterface['vspa_PM']],
        ["SM", sipinterface['vspa_SM']],
        ["VC", sipinterface['vspa_VC']],
        ["KN", sipinterface['vspa_KN']],
        ["LC", sipinterface['vspa_LC']],
        ["MF", sipinterface['vspa_MF']],
        ["SH", sipinterface['vspa_SH']],
        ["ST", sipinterface['vspa_ST']],
        ["SJ", sipinterface['vspa_SJ']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["SG", sipinterface['vspa_SG']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SY", sipinterface['vspa_SY']],
        ["SR", sipinterface['vspa_SR']],
        ["CH", sipinterface['vspa_CH']],
        ["SL", sipinterface['vspa_SL']],
        ["LK", sipinterface['vspa_LK']],
        ["SC", sipinterface['vspa_SC']],
        ["SX", sipinterface['vspa_SX']],
        ["RS", sipinterface['vspa_RS']],
        ["TJ", sipinterface['vspa_TJ']],
        ["OM", sipinterface['vspa_OM']],
        ["GM", sipinterface['vspa_GM']],
        ["GH", sipinterface['vspa_GH']],
        ["GD", sipinterface['vspa_GD']],
        ["GL", sipinterface['vspa_GL']],
        ["GT", sipinterface['vspa_GT']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GY", sipinterface['vspa_GY']],
        ["GF", sipinterface['vspa_GF']],
        ["GG", sipinterface['vspa_GG']],
        ["GN", sipinterface['vspa_GN']],
        ["GQ", sipinterface['vspa_GQ']],
        ["GW", sipinterface['vspa_GW']],
        ["VU", sipinterface['vspa_VU']],
        ["FR", sipinterface['vspa_FR']],
        ["PS", sipinterface['vspa_PS']],
        ["VE", sipinterface['vspa_VE']],
        ["FI", sipinterface['vspa_FI']],
        ["VN", sipinterface['vspa_VN']],
        ["FJ", sipinterface['vspa_FJ']],
        ["CY", sipinterface['vspa_CY']],
        ["KG", sipinterface['vspa_KG']],
        ["QA", sipinterface['vspa_QA']],
        ["KZ", sipinterface['vspa_KZ']],
        ["NC", sipinterface['vspa_NC']],
        ["HR", sipinterface['vspa_HR']],
        ["KI", sipinterface['vspa_KI']],
        ["KH", sipinterface['vspa_KH']],
        ["CA", sipinterface['vspa_CA']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["CR", sipinterface['vspa_CR']],
        ["CO", sipinterface['vspa_CO']],
        ["KE", sipinterface['vspa_KE']],
        ["LV", sipinterface['vspa_LV']],
        ["LA", sipinterface['vspa_LA']],
        ["LB", sipinterface['vspa_LB']],
        ["LU", sipinterface['vspa_LU']],
        ["LY", sipinterface['vspa_LY']],
        ["LR", sipinterface['vspa_LR']],
        ["LT", sipinterface['vspa_LT']],
        ["LI", sipinterface['vspa_LI']],
        ["LS", sipinterface['vspa_LS']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MP", sipinterface['vspa_MP']],
        ["MW", sipinterface['vspa_MW']],
        ["MT", sipinterface['vspa_MT']],
        ["ML", sipinterface['vspa_ML']],
        ["MY", sipinterface['vspa_MY']],
        ["YT", sipinterface['vspa_YT']],
        ["MG", sipinterface['vspa_MG']],
        ["EG", sipinterface['vspa_EG']],
        ["MK", sipinterface['vspa_MK']],
        ["MO", sipinterface['vspa_MO']],
        ["HK", sipinterface['vspa_HK']],
        ["MN", sipinterface['vspa_MN']],
        ["MR", sipinterface['vspa_MR']],
        ["MU", sipinterface['vspa_MU']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MS", sipinterface['vspa_MS']],
        ["MM", sipinterface['vspa_MM']],
        ["FM", sipinterface['vspa_FM']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NG", sipinterface['vspa_NG']],
        ["NI", sipinterface['vspa_NI']],
        ["NZ", sipinterface['vspa_NZ']],
        ["NU", sipinterface['vspa_NU']],
        ["HT", sipinterface['vspa_HT']],
        ["HN", sipinterface['vspa_HN']],
        ["NL", sipinterface['vspa_NL']],
        ["WF", sipinterface['vspa_WF']]];

      var RegionJap = [
        ["IS", sipinterface['vspa_IS']],
        ["IE", sipinterface['vspa_IE']],
        ["AZ", sipinterface['vspa_AZ']],
        ["AF", sipinterface['vspa_AF']],
        ["AE", sipinterface['vspa_AE']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AR", sipinterface['vspa_AR']],
        ["AW", sipinterface['vspa_AW']],
        ["AL", sipinterface['vspa_AL']],
        ["AM", sipinterface['vspa_AM']],
        ["AI", sipinterface['vspa_AI']],
        ["AO", sipinterface['vspa_AO']],
        ["AG", sipinterface['vspa_AG']],
        ["AD", sipinterface['vspa_AD']],
        ["YE", sipinterface['vspa_YE']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IR", sipinterface['vspa_IR']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["UG", sipinterface['vspa_UG']],
        ["UA", sipinterface['vspa_UA']],
        ["UZ", sipinterface['vspa_UZ']],
        ["UY", sipinterface['vspa_UY']],
        ["GB", sipinterface['vspa_GB']],
        ["IO", sipinterface['vspa_IO']],
        ["VG", sipinterface['vspa_VG']],
        ["EC", sipinterface['vspa_EC']],
        ["EG", sipinterface['vspa_EG']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["ER", sipinterface['vspa_ER']],
        ["SV", sipinterface['vspa_SV']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AX", sipinterface['vspa_AX']],
        ["OM", sipinterface['vspa_OM']],
        ["NL", sipinterface['vspa_NL']],
        ["GH", sipinterface['vspa_GH']],
        ["CV", sipinterface['vspa_CV']],
        ["GG", sipinterface['vspa_GG']],
        ["GY", sipinterface['vspa_GY']],
        ["KZ", sipinterface['vspa_KZ']],
        ["QA", sipinterface['vspa_QA']],
        ["UM", sipinterface['vspa_UM']],
        ["CA", sipinterface['vspa_CA']],
        ["GA", sipinterface['vspa_GA']],
        ["CM", sipinterface['vspa_CM']],
        ["GM", sipinterface['vspa_GM']],
        ["KH", sipinterface['vspa_KH']],
        ["MK", sipinterface['vspa_MK']],
        ["MP", sipinterface['vspa_MP']],
        ["GN", sipinterface['vspa_GN']],
        ["GW", sipinterface['vspa_GW']],
        ["CY", sipinterface['vspa_CY']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["GR", sipinterface['vspa_GR']],
        ["KI", sipinterface['vspa_KI']],
        ["KG", sipinterface['vspa_KG']],
        ["GT", sipinterface['vspa_GT']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["KW", sipinterface['vspa_KW']],
        ["CK", sipinterface['vspa_CK']],
        ["GL", sipinterface['vspa_GL']],
        ["CX", sipinterface['vspa_CX']],
        ["GD", sipinterface['vspa_GD']],
        ["HR", sipinterface['vspa_HR']],
        ["KY", sipinterface['vspa_KY']],
        ["KE", sipinterface['vspa_KE']],
        ["CI", sipinterface['vspa_CI']],
        ["CC", sipinterface['vspa_CC']],
        ["CR", sipinterface['vspa_CR']],
        ["KM", sipinterface['vspa_KM']],
        ["CO", sipinterface['vspa_CO']],
        ["CG", sipinterface['vspa_CG']],
        ["CD", sipinterface['vspa_CD']],
        ["SA", sipinterface['vspa_SA']],
        ["GS", sipinterface['vspa_GS']],
        ["WS", sipinterface['vspa_WS']],
        ["BL", sipinterface['vspa_BL']],
        ["ST", sipinterface['vspa_ST']],
        ["ZM", sipinterface['vspa_ZM']],
        ["PM", sipinterface['vspa_PM']],
        ["SM", sipinterface['vspa_SM']],
        ["MF", sipinterface['vspa_MF']],
        ["SL", sipinterface['vspa_SL']],
        ["DJ", sipinterface['vspa_DJ']],
        ["GI", sipinterface['vspa_GI']],
        ["JE", sipinterface['vspa_JE']],
        ["JM", sipinterface['vspa_JM']],
        ["GE", sipinterface['vspa_GE']],
        ["SY", sipinterface['vspa_SY']],
        ["SG", sipinterface['vspa_SG']],
        ["SX", sipinterface['vspa_SX']],
        ["ZW", sipinterface['vspa_ZW']],
        ["CH", sipinterface['vspa_CH']],
        ["SE", sipinterface['vspa_SE']],
        ["SD", sipinterface['vspa_SD']],
        ["SJ", sipinterface['vspa_SJ']],
        ["ES", sipinterface['vspa_ES']],
        ["SR", sipinterface['vspa_SR']],
        ["LK", sipinterface['vspa_LK']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SC", sipinterface['vspa_SC']],
        ["GQ", sipinterface['vspa_GQ']],
        ["SN", sipinterface['vspa_SN']],
        ["RS", sipinterface['vspa_RS']],
        ["KN", sipinterface['vspa_KN']],
        ["VC", sipinterface['vspa_VC']],
        ["SH", sipinterface['vspa_SH']],
        ["LC", sipinterface['vspa_LC']],
        ["SO", sipinterface['vspa_SO']],
        ["SB", sipinterface['vspa_SB']],
        ["TC", sipinterface['vspa_TC']],
        ["TH", sipinterface['vspa_TH']],
        ["KR", sipinterface['vspa_KR']],
        ["TW", sipinterface['vspa_TW']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TZ", sipinterface['vspa_TZ']],
        ["CZ", sipinterface['vspa_CZ']],
        ["TD", sipinterface['vspa_TD']],
        ["CF", sipinterface['vspa_CF']],
        ["CN", sipinterface['vspa_CN']],
        ["TN", sipinterface['vspa_TN']],
        ["KP", sipinterface['vspa_KP']],
        ["CL", sipinterface['vspa_CL']],
        ["TV", sipinterface['vspa_TV']],
        ["DK", sipinterface['vspa_DK']],
        ["DE", sipinterface['vspa_DE']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["DO", sipinterface['vspa_DO']],
        ["DM", sipinterface['vspa_DM']],
        ["TT", sipinterface['vspa_TT']],
        ["TM", sipinterface['vspa_TM']],
        ["TR", sipinterface['vspa_TR']],
        ["TO", sipinterface['vspa_TO']],
        ["NG", sipinterface['vspa_NG']],
        ["NR", sipinterface['vspa_NR']],
        ["NA", sipinterface['vspa_NA']],
        ["AQ", sipinterface['vspa_AQ']],
        ["NU", sipinterface['vspa_NU']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["JP", sipinterface['vspa_JP']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["NP", sipinterface['vspa_NP']],
        ["NF", sipinterface['vspa_NF']],
        ["NO", sipinterface['vspa_NO']],
        ["HM", sipinterface['vspa_HM']],
        ["BH", sipinterface['vspa_BH']],
        ["HT", sipinterface['vspa_HT']],
        ["PK", sipinterface['vspa_PK']],
        ["VA", sipinterface['vspa_VA']],
        ["PA", sipinterface['vspa_PA']],
        ["VU", sipinterface['vspa_VU']],
        ["BS", sipinterface['vspa_BS']],
        ["PG", sipinterface['vspa_PG']],
        ["BM", sipinterface['vspa_BM']],
        ["PW", sipinterface['vspa_PW']],
        ["PY", sipinterface['vspa_PY']],
        ["BB", sipinterface['vspa_BB']],
        ["PS", sipinterface['vspa_PS']],
        ["HU", sipinterface['vspa_HU']],
        ["BD", sipinterface['vspa_BD']],
        ["TL", sipinterface['vspa_TL']],
        ["PN", sipinterface['vspa_PN']],
        ["FJ", sipinterface['vspa_FJ']],
        ["PH", sipinterface['vspa_PH']],
        ["FI", sipinterface['vspa_FI']],
        ["BT", sipinterface['vspa_BT']],
        ["BV", sipinterface['vspa_BV']],
        ["PR", sipinterface['vspa_PR']],
        ["FO", sipinterface['vspa_FO']],
        ["FK", sipinterface['vspa_FK']],
        ["BR", sipinterface['vspa_BR']],
        ["FR", sipinterface['vspa_FR']],
        ["GF", sipinterface['vspa_GF']],
        ["TF", sipinterface['vspa_TF']],
        ["PF", sipinterface['vspa_PF']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BN", sipinterface['vspa_BN']],
        ["BI", sipinterface['vspa_BI']],
        ["US", sipinterface['vspa_US']],
        ["AS", sipinterface['vspa_AS']],
        ["VI", sipinterface['vspa_VI']],
        ["VN", sipinterface['vspa_VN']],
        ["BJ", sipinterface['vspa_BJ']],
        ["VE", sipinterface['vspa_VE']],
        ["BY", sipinterface['vspa_BY']],
        ["BZ", sipinterface['vspa_BZ']],
        ["PE", sipinterface['vspa_PE']],
        ["BE", sipinterface['vspa_BE']],
        ["PL", sipinterface['vspa_PL']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BO", sipinterface['vspa_BO']],
        ["PT", sipinterface['vspa_PT']],
        ["HK", sipinterface['vspa_HK']],
        ["HN", sipinterface['vspa_HN']],
        ["MH", sipinterface['vspa_MH']],
        ["MO", sipinterface['vspa_MO']],
        ["MG", sipinterface['vspa_MG']],
        ["YT", sipinterface['vspa_YT']],
        ["MW", sipinterface['vspa_MW']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MY", sipinterface['vspa_MY']],
        ["IM", sipinterface['vspa_IM']],
        ["FM", sipinterface['vspa_FM']],
        ["ZA", sipinterface['vspa_ZA']],
        ["SS", sipinterface['vspa_SS']],
        ["MM", sipinterface['vspa_MM']],
        ["MX", sipinterface['vspa_MX']],
        ["MU", sipinterface['vspa_MU']],
        ["MR", sipinterface['vspa_MR']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MC", sipinterface['vspa_MC']],
        ["MV", sipinterface['vspa_MV']],
        ["MD", sipinterface['vspa_MD']],
        ["MA", sipinterface['vspa_MA']],
        ["MN", sipinterface['vspa_MN']],
        ["MS", sipinterface['vspa_MS']],
        ["ME", sipinterface['vspa_ME']],
        ["JO", sipinterface['vspa_JO']],
        ["LA", sipinterface['vspa_LA']],
        ["LV", sipinterface['vspa_LV']],
        ["LT", sipinterface['vspa_LT']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LR", sipinterface['vspa_LR']],
        ["RO", sipinterface['vspa_RO']],
        ["LU", sipinterface['vspa_LU']],
        ["RW", sipinterface['vspa_RW']],
        ["LS", sipinterface['vspa_LS']],
        ["LB", sipinterface['vspa_LB']],
        ["RE", sipinterface['vspa_RE']],
        ["RU", sipinterface['vspa_RU']],
        ["WF", sipinterface['vspa_WF']]];

      var RegionPT = [
        ["AF", sipinterface['vspa_AF']],
        ["ZA", sipinterface['vspa_ZA']],
        ["AL", sipinterface['vspa_AL']],
        ["DE", sipinterface['vspa_DE']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["SA", sipinterface['vspa_SA']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AR", sipinterface['vspa_AR']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["BS", sipinterface['vspa_BS']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BH", sipinterface['vspa_BH']],
        ["BE", sipinterface['vspa_BE']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BY", sipinterface['vspa_BY']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BR", sipinterface['vspa_BR']],
        ["BN", sipinterface['vspa_BN']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["BT", sipinterface['vspa_BT']],
        ["CV", sipinterface['vspa_CV']],
        ["CM", sipinterface['vspa_CM']],
        ["KH", sipinterface['vspa_KH']],
        ["CA", sipinterface['vspa_CA']],
        ["QA", sipinterface['vspa_QA']],
        ["KZ", sipinterface['vspa_KZ']],
        ["TD", sipinterface['vspa_TD']],
        ["CL", sipinterface['vspa_CL']],
        ["CN", sipinterface['vspa_CN']],
        ["CY", sipinterface['vspa_CY']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["CD", sipinterface['vspa_CD']],
        ["CI", sipinterface['vspa_CI']],
        ["CR", sipinterface['vspa_CR']],
        ["HR", sipinterface['vspa_HR']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["DK", sipinterface['vspa_DK']],
        ["DM", sipinterface['vspa_DM']],
        ["EG", sipinterface['vspa_EG']],
        ["AE", sipinterface['vspa_AE']],
        ["EC", sipinterface['vspa_EC']],
        ["ER", sipinterface['vspa_ER']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["ES", sipinterface['vspa_ES']],
        ["US", sipinterface['vspa_US']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["FJ", sipinterface['vspa_FJ']],
        ["PH", sipinterface['vspa_PH']],
        ["FI", sipinterface['vspa_FI']],
        ["FR", sipinterface['vspa_FR']],
        ["GA", sipinterface['vspa_GA']],
        ["GM", sipinterface['vspa_GM']],
        ["GH", sipinterface['vspa_GH']],
        ["GE", sipinterface['vspa_GE']],
        ["GI", sipinterface['vspa_GI']],
        ["GD", sipinterface['vspa_GD']],
        ["GR", sipinterface['vspa_GR']],
        ["GL", sipinterface['vspa_GL']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GT", sipinterface['vspa_GT']],
        ["GG", sipinterface['vspa_GG']],
        ["GY", sipinterface['vspa_GY']],
        ["GF", sipinterface['vspa_GF']],
        ["GN", sipinterface['vspa_GN']],
        ["GQ", sipinterface['vspa_GQ']],
        ["GW", sipinterface['vspa_GW']],
        ["HT", sipinterface['vspa_HT']],
        ["HN", sipinterface['vspa_HN']],
        ["HU", sipinterface['vspa_HU']],
        ["YE", sipinterface['vspa_YE']],
        ["BV", sipinterface['vspa_BV']],
        ["IM", sipinterface['vspa_IM']],
        ["MF", sipinterface['vspa_MF']],
        ["CX", sipinterface['vspa_CX']],
        ["HM", sipinterface['vspa_HM']],
        ["NF", sipinterface['vspa_NF']],
        ["AX", sipinterface['vspa_AX']],
        ["KY", sipinterface['vspa_KY']],
        ["CK", sipinterface['vspa_CK']],
        ["CC", sipinterface['vspa_CC']],
        ["FK", sipinterface['vspa_FK']],
        ["FO", sipinterface['vspa_FO']],
        ["GS", sipinterface['vspa_GS']],
        ["MH", sipinterface['vspa_MH']],
        ["UM", sipinterface['vspa_UM']],
        ["PN", sipinterface['vspa_PN']],
        ["SB", sipinterface['vspa_SB']],
        ["TC", sipinterface['vspa_TC']],
        ["VI", sipinterface['vspa_VI']],
        ["VG", sipinterface['vspa_VG']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["IR", sipinterface['vspa_IR']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IE", sipinterface['vspa_IE']],
        ["IS", sipinterface['vspa_IS']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']],
        ["JE", sipinterface['vspa_JE']],
        ["DJ", sipinterface['vspa_DJ']],
        ["JO", sipinterface['vspa_JO']],
        ["KW", sipinterface['vspa_KW']],
        ["LA", sipinterface['vspa_LA']],
        ["LS", sipinterface['vspa_LS']],
        ["LV", sipinterface['vspa_LV']],
        ["LB", sipinterface['vspa_LB']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LT", sipinterface['vspa_LT']],
        ["LU", sipinterface['vspa_LU']],
        ["MK", sipinterface['vspa_MK']],
        ["MG", sipinterface['vspa_MG']],
        ["YT", sipinterface['vspa_YT']],
        ["MY", sipinterface['vspa_MY']],
        ["MW", sipinterface['vspa_MW']],
        ["MV", sipinterface['vspa_MV']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["MP", sipinterface['vspa_MP']],
        ["MA", sipinterface['vspa_MA']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MU", sipinterface['vspa_MU']],
        ["MR", sipinterface['vspa_MR']],
        ["MX", sipinterface['vspa_MX']],
        ["MM", sipinterface['vspa_MM']],
        ["FM", sipinterface['vspa_FM']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MN", sipinterface['vspa_MN']],
        ["MS", sipinterface['vspa_MS']],
        ["ME", sipinterface['vspa_ME']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NU", sipinterface['vspa_NU']],
        ["NO", sipinterface['vspa_NO']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["OM", sipinterface['vspa_OM']],
        ["NL", sipinterface['vspa_NL']],
        ["PW", sipinterface['vspa_PW']],
        ["PS", sipinterface['vspa_PS']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PK", sipinterface['vspa_PK']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PF", sipinterface['vspa_PF']],
        ["PL", sipinterface['vspa_PL']],
        ["PR", sipinterface['vspa_PR']],
        ["PT", sipinterface['vspa_PT']],
        ["KE", sipinterface['vspa_KE']],
        ["KG", sipinterface['vspa_KG']],
        ["KI", sipinterface['vspa_KI']],
        ["HK", sipinterface['vspa_HK']],
        ["MO", sipinterface['vspa_MO']],
        ["GB", sipinterface['vspa_GB']],
        ["CF", sipinterface['vspa_CF']],
        ["CZ", sipinterface['vspa_CZ']],
        ["KR", sipinterface['vspa_KR']],
        ["DO", sipinterface['vspa_DO']],
        ["KP", sipinterface['vspa_KP']],
        ["RE", sipinterface['vspa_RE']],
        ["RO", sipinterface['vspa_RO']],
        ["RW", sipinterface['vspa_RW']],
        ["RU", sipinterface['vspa_RU']],
        ["SV", sipinterface['vspa_SV']],
        ["WS", sipinterface['vspa_WS']],
        ["AS", sipinterface['vspa_AS']],
        ["SH", sipinterface['vspa_SH']],
        ["LC", sipinterface['vspa_LC']],
        ["BL", sipinterface['vspa_BL']],
        ["KN", sipinterface['vspa_KN']],
        ["SM", sipinterface['vspa_SM']],
        ["SX", sipinterface['vspa_SX']],
        ["PM", sipinterface['vspa_PM']],
        ["ST", sipinterface['vspa_ST']],
        ["VC", sipinterface['vspa_VC']],
        ["SC", sipinterface['vspa_SC']],
        ["SN", sipinterface['vspa_SN']],
        ["SL", sipinterface['vspa_SL']],
        ["RS", sipinterface['vspa_RS']],
        ["SG", sipinterface['vspa_SG']],
        ["SY", sipinterface['vspa_SY']],
        ["SO", sipinterface['vspa_SO']],
        ["LK", sipinterface['vspa_LK']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SD", sipinterface['vspa_SD']],
        ["SS", sipinterface['vspa_SS']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["SR", sipinterface['vspa_SR']],
        ["SJ", sipinterface['vspa_SJ']],
        ["TH", sipinterface['vspa_TH']],
        ["TW", sipinterface['vspa_TW']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TF", sipinterface['vspa_TF']],
        ["IO", sipinterface['vspa_IO']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TO", sipinterface['vspa_TO']],
        ["TK", sipinterface['vspa_TK']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TM", sipinterface['vspa_TM']],
        ["TR", sipinterface['vspa_TR']],
        ["TV", sipinterface['vspa_TV']],
        ["UA", sipinterface['vspa_UA']],
        ["UG", sipinterface['vspa_UG']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["VU", sipinterface['vspa_VU']],
        ["VA", sipinterface['vspa_VA']],
        ["VE", sipinterface['vspa_VE']],
        ["VN", sipinterface['vspa_VN']],
        ["WF", sipinterface['vspa_WF']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']]];

      var RegionRU = [
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["AX", sipinterface['vspa_AX']],
        ["AL", sipinterface['vspa_AL']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AS", sipinterface['vspa_AS']],
        ["AI", sipinterface['vspa_AI']],
        ["AO", sipinterface['vspa_AO']],
        ["AD", sipinterface['vspa_AD']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["AR", sipinterface['vspa_AR']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["AF", sipinterface['vspa_AF']],
        ["BS", sipinterface['vspa_BS']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BH", sipinterface['vspa_BH']],
        ["BY", sipinterface['vspa_BY']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BE", sipinterface['vspa_BE']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BG", sipinterface['vspa_BG']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BR", sipinterface['vspa_BR']],
        ["IO", sipinterface['vspa_IO']],
        ["BN", sipinterface['vspa_BN']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["BT", sipinterface['vspa_BT']],
        ["VU", sipinterface['vspa_VU']],
        ["VA", sipinterface['vspa_VA']],
        ["HU", sipinterface['vspa_HU']],
        ["VE", sipinterface['vspa_VE']],
        ["VG", sipinterface['vspa_VG']],
        ["VI", sipinterface['vspa_VI']],
        ["UM", sipinterface['vspa_UM']],
        ["VN", sipinterface['vspa_VN']],
        ["GA", sipinterface['vspa_GA']],
        ["GY", sipinterface['vspa_GY']],
        ["HT", sipinterface['vspa_HT']],
        ["GM", sipinterface['vspa_GM']],
        ["GH", sipinterface['vspa_GH']],
        ["GP", sipinterface['vspa_GP']],
        ["GT", sipinterface['vspa_GT']],
        ["GN", sipinterface['vspa_GN']],
        ["GW", sipinterface['vspa_GW']],
        ["DE", sipinterface['vspa_DE']],
        ["GG", sipinterface['vspa_GG']],
        ["GI", sipinterface['vspa_GI']],
        ["HN", sipinterface['vspa_HN']],
        ["GD", sipinterface['vspa_GD']],
        ["GL", sipinterface['vspa_GL']],
        ["GR", sipinterface['vspa_GR']],
        ["GE", sipinterface['vspa_GE']],
        ["GU", sipinterface['vspa_GU']],
        ["DK", sipinterface['vspa_DK']],
        ["CD", sipinterface['vspa_CD']],
        ["JE", sipinterface['vspa_JE']],
        ["DJ", sipinterface['vspa_DJ']],
        ["DM", sipinterface['vspa_DM']],
        ["DO", sipinterface['vspa_DO']],
        ["EG", sipinterface['vspa_EG']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']],
        ["YE", sipinterface['vspa_YE']],
        ["IL", sipinterface['vspa_IL']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["JO", sipinterface['vspa_JO']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IR", sipinterface['vspa_IR']],
        ["IE", sipinterface['vspa_IE']],
        ["IS", sipinterface['vspa_IS']],
        ["ES", sipinterface['vspa_ES']],
        ["IT", sipinterface['vspa_IT']],
        ["CV", sipinterface['vspa_CV']],
        ["KZ", sipinterface['vspa_KZ']],
        ["KH", sipinterface['vspa_KH']],
        ["CM", sipinterface['vspa_CM']],
        ["CA", sipinterface['vspa_CA']],
        ["QA", sipinterface['vspa_QA']],
        ["KE", sipinterface['vspa_KE']],
        ["CY", sipinterface['vspa_CY']],
        ["KG", sipinterface['vspa_KG']],
        ["KI", sipinterface['vspa_KI']],
        ["KP", sipinterface['vspa_KP']],
        ["CC", sipinterface['vspa_CC']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["CR", sipinterface['vspa_CR']],
        ["CI", sipinterface['vspa_CI']],
        ["CU", sipinterface['vspa_CU']],
        ["KW", sipinterface['vspa_KW']],
        ["CW", sipinterface['vspa_CW']],
        ["LA", sipinterface['vspa_LA']],
        ["LV", sipinterface['vspa_LV']],
        ["LS", sipinterface['vspa_LS']],
        ["LR", sipinterface['vspa_LR']],
        ["LB", sipinterface['vspa_LB']],
        ["LY", sipinterface['vspa_LY']],
        ["LT", sipinterface['vspa_LT']],
        ["LI", sipinterface['vspa_LI']],
        ["LU", sipinterface['vspa_LU']],
        ["MU", sipinterface['vspa_MU']],
        ["MR", sipinterface['vspa_MR']],
        ["MG", sipinterface['vspa_MG']],
        ["YT", sipinterface['vspa_YT']],
        ["MW", sipinterface['vspa_MW']],
        ["MY", sipinterface['vspa_MY']],
        ["ML", sipinterface['vspa_ML']],
        ["MV", sipinterface['vspa_MV']],
        ["MT", sipinterface['vspa_MT']],
        ["MA", sipinterface['vspa_MA']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MH", sipinterface['vspa_MH']],
        ["CN", sipinterface['vspa_CN']],
        ["MX", sipinterface['vspa_MX']],
        ["FM", sipinterface['vspa_FM']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MN", sipinterface['vspa_MN']],
        ["MS", sipinterface['vspa_MS']],
        ["MM", sipinterface['vspa_MM']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NL", sipinterface['vspa_NL']],
        ["NI", sipinterface['vspa_NI']],
        ["NU", sipinterface['vspa_NU']],
        ["NZ", sipinterface['vspa_NZ']],
        ["NC", sipinterface['vspa_NC']],
        ["NO", sipinterface['vspa_NO']],
        ["AE", sipinterface['vspa_AE']],
        ["OM", sipinterface['vspa_OM']],
        ["BV", sipinterface['vspa_BV']],
        ["IM", sipinterface['vspa_IM']],
        ["NF", sipinterface['vspa_NF']],
        ["CX", sipinterface['vspa_CX']],
        ["SH", sipinterface['vspa_SH']],
        ["HM", sipinterface['vspa_HM']],
        ["KY", sipinterface['vspa_KY']],
        ["CK", sipinterface['vspa_CK']],
        ["PN", sipinterface['vspa_PN']],
        ["WF", sipinterface['vspa_WF']],
        ["PK", sipinterface['vspa_PK']],
        ["PW", sipinterface['vspa_PW']],
        ["PS", sipinterface['vspa_PS']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PL", sipinterface['vspa_PL']],
        ["PT", sipinterface['vspa_PT']],
        ["PR", sipinterface['vspa_PR']],
        ["KR", sipinterface['vspa_KR']],
        ["RE", sipinterface['vspa_RE']],
        ["RU", sipinterface['vspa_RU']],
        ["RW", sipinterface['vspa_RW']],
        ["RO", sipinterface['vspa_RO']],
        ["SV", sipinterface['vspa_SV']],
        ["WS", sipinterface['vspa_WS']],
        ["SM", sipinterface['vspa_SM']],
        ["ST", sipinterface['vspa_ST']],
        ["HK", sipinterface['vspa_HK']],
        ["MO", sipinterface['vspa_MO']],
        ["SA", sipinterface['vspa_SA']],
        ["SZ", sipinterface['vspa_SZ']],
        ["MK", sipinterface['vspa_MK']],
        ["MP", sipinterface['vspa_MP']],
        ["SC", sipinterface['vspa_SC']],
        ["BL", sipinterface['vspa_BL']],
        ["SN", sipinterface['vspa_SN']],
        ["MF", sipinterface['vspa_MF']],
        ["PM", sipinterface['vspa_PM']],
        ["VC", sipinterface['vspa_VC']],
        ["KN", sipinterface['vspa_KN']],
        ["LC", sipinterface['vspa_LC']],
        ["RS", sipinterface['vspa_RS']],
        ["SG", sipinterface['vspa_SG']],
        ["SX", sipinterface['vspa_SX']],
        ["SY", sipinterface['vspa_SY']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["GB", sipinterface['vspa_GB']],
        ["SB", sipinterface['vspa_SB']],
        ["SO", sipinterface['vspa_SO']],
        ["SD", sipinterface['vspa_SD']],
        ["SR", sipinterface['vspa_SR']],
        ["US", sipinterface['vspa_US']],
        ["SL", sipinterface['vspa_SL']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TW", sipinterface['vspa_TW']],
        ["TH", sipinterface['vspa_TH']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TC", sipinterface['vspa_TC']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["TO", sipinterface['vspa_TO']],
        ["TT", sipinterface['vspa_TT']],
        ["TV", sipinterface['vspa_TV']],
        ["TN", sipinterface['vspa_TN']],
        ["TM", sipinterface['vspa_TM']],
        ["TR", sipinterface['vspa_TR']],
        ["UG", sipinterface['vspa_UG']],
        ["UZ", sipinterface['vspa_UZ']],
        ["UA", sipinterface['vspa_UA']],
        ["UY", sipinterface['vspa_UY']],
        ["FO", sipinterface['vspa_FO']],
        ["FJ", sipinterface['vspa_FJ']],
        ["PH", sipinterface['vspa_PH']],
        ["FI", sipinterface['vspa_FI']],
        ["FK", sipinterface['vspa_FK']],
        ["FR", sipinterface['vspa_FR']],
        ["GF", sipinterface['vspa_GF']],
        ["PF", sipinterface['vspa_PF']],
        ["TF", sipinterface['vspa_TF']],
        ["HR", sipinterface['vspa_HR']],
        ["CF", sipinterface['vspa_CF']],
        ["TD", sipinterface['vspa_TD']],
        ["ME", sipinterface['vspa_ME']],
        ["CZ", sipinterface['vspa_CZ']],
        ["CL", sipinterface['vspa_CL']],
        ["CH", sipinterface['vspa_CH']],
        ["SE", sipinterface['vspa_SE']],
        ["SJ", sipinterface['vspa_SJ']],
        ["LK", sipinterface['vspa_LK']],
        ["EC", sipinterface['vspa_EC']],
        ["GQ", sipinterface['vspa_GQ']],
        ["ER", sipinterface['vspa_ER']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["ZA", sipinterface['vspa_ZA']],
        ["GS", sipinterface['vspa_GS']],
        ["SS", sipinterface['vspa_SS']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']]];

      var RegionBS = [
        ["AF", sipinterface['vspa_AF']],
        ["CF", sipinterface['vspa_CF']],
        ["ZA", sipinterface['vspa_ZA']],
        ["AL", sipinterface['vspa_AL']],
        ["DE", sipinterface['vspa_DE']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["SA", sipinterface['vspa_SA']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AR", sipinterface['vspa_AR']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["BS", sipinterface['vspa_BS']],
        ["BH", sipinterface['vspa_BH']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BE", sipinterface['vspa_BE']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BY", sipinterface['vspa_BY']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BR", sipinterface['vspa_BR']],
        ["BN", sipinterface['vspa_BN']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["BT", sipinterface['vspa_BT']],
        ["CV", sipinterface['vspa_CV']],
        ["CM", sipinterface['vspa_CM']],
        ["KH", sipinterface['vspa_KH']],
        ["CA", sipinterface['vspa_CA']],
        ["KZ", sipinterface['vspa_KZ']],
        ["TD", sipinterface['vspa_TD']],
        ["CL", sipinterface['vspa_CL']],
        ["CN", sipinterface['vspa_CN']],
        ["CY", sipinterface['vspa_CY']],
        ["SG", sipinterface['vspa_SG']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["CI", sipinterface['vspa_CI']],
        ["CR", sipinterface['vspa_CR']],
        ["HR", sipinterface['vspa_HR']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["DK", sipinterface['vspa_DK']],
        ["DJ", sipinterface['vspa_DJ']],
        ["DM", sipinterface['vspa_DM']],
        ["EG", sipinterface['vspa_EG']],
        ["SV", sipinterface['vspa_SV']],
        ["AE", sipinterface['vspa_AE']],
        ["EC", sipinterface['vspa_EC']],
        ["ER", sipinterface['vspa_ER']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["ES", sipinterface['vspa_ES']],
        ["US", sipinterface['vspa_US']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["FJ", sipinterface['vspa_FJ']],
        ["PH", sipinterface['vspa_PH']],
        ["FI", sipinterface['vspa_FI']],
        ["FR", sipinterface['vspa_FR']],
        ["GA", sipinterface['vspa_GA']],
        ["GM", sipinterface['vspa_GM']],
        ["GH", sipinterface['vspa_GH']],
        ["GE", sipinterface['vspa_GE']],
        ["GI", sipinterface['vspa_GI']],
        ["GB", sipinterface['vspa_GB']],
        ["GD", sipinterface['vspa_GD']],
        ["GR", sipinterface['vspa_GR']],
        ["GL", sipinterface['vspa_GL']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GT", sipinterface['vspa_GT']],
        ["GG", sipinterface['vspa_GG']],
        ["GY", sipinterface['vspa_GY']],
        ["GF", sipinterface['vspa_GF']],
        ["GN", sipinterface['vspa_GN']],
        ["GQ", sipinterface['vspa_GQ']],
        ["GW", sipinterface['vspa_GW']],
        ["HT", sipinterface['vspa_HT']],
        ["HN", sipinterface['vspa_HN']],
        ["HU", sipinterface['vspa_HU']],
        ["YE", sipinterface['vspa_YE']],
        ["BV", sipinterface['vspa_BV']],
        ["IM", sipinterface['vspa_IM']],
        ["NF", sipinterface['vspa_NF']],
        ["AX", sipinterface['vspa_AX']],
        ["KY", sipinterface['vspa_KY']],
        ["CX", sipinterface['vspa_CX']],
        ["CC", sipinterface['vspa_CC']],
        ["CK", sipinterface['vspa_CK']],
        ["FK", sipinterface['vspa_FK']],
        ["FO", sipinterface['vspa_FO']],
        ["GS", sipinterface['vspa_GS']],
        ["HM", sipinterface['vspa_HM']],
        ["MH", sipinterface['vspa_MH']],
        ["UM", sipinterface['vspa_UM']],
        ["SB", sipinterface['vspa_SB']],
        ["TC", sipinterface['vspa_TC']],
        ["VG", sipinterface['vspa_VG']],
        ["VI", sipinterface['vspa_VI']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["IR", sipinterface['vspa_IR']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IE", sipinterface['vspa_IE']],
        ["IS", sipinterface['vspa_IS']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']],
        ["JE", sipinterface['vspa_JE']],
        ["JO", sipinterface['vspa_JO']],
        ["KI", sipinterface['vspa_KI']],
        ["KW", sipinterface['vspa_KW']],
        ["LA", sipinterface['vspa_LA']],
        ["LS", sipinterface['vspa_LS']],
        ["LV", sipinterface['vspa_LV']],
        ["LB", sipinterface['vspa_LB']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LT", sipinterface['vspa_LT']],
        ["LU", sipinterface['vspa_LU']],
        ["MK", sipinterface['vspa_MK']],
        ["MG", sipinterface['vspa_MG']],
        ["MY", sipinterface['vspa_MY']],
        ["MW", sipinterface['vspa_MW']],
        ["MV", sipinterface['vspa_MV']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["MP", sipinterface['vspa_MP']],
        ["MA", sipinterface['vspa_MA']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MU", sipinterface['vspa_MU']],
        ["MR", sipinterface['vspa_MR']],
        ["YT", sipinterface['vspa_YT']],
        ["MX", sipinterface['vspa_MX']],
        ["MM", sipinterface['vspa_MM']],
        ["FM", sipinterface['vspa_FM']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MN", sipinterface['vspa_MN']],
        ["MS", sipinterface['vspa_MS']],
        ["ME", sipinterface['vspa_ME']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NU", sipinterface['vspa_NU']],
        ["NO", sipinterface['vspa_NO']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["OM", sipinterface['vspa_OM']],
        ["NL", sipinterface['vspa_NL']],
        ["PW", sipinterface['vspa_PW']],
        ["PS", sipinterface['vspa_PS']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PK", sipinterface['vspa_PK']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PN", sipinterface['vspa_PN']],
        ["PF", sipinterface['vspa_PF']],
        ["PL", sipinterface['vspa_PL']],
        ["PR", sipinterface['vspa_PR']],
        ["PT", sipinterface['vspa_PT']],
        ["QA", sipinterface['vspa_QA']],
        ["KE", sipinterface['vspa_KE']],
        ["KG", sipinterface['vspa_KG']],
        ["HK", sipinterface['vspa_HK']],
        ["MO", sipinterface['vspa_MO']],
        ["CZ", sipinterface['vspa_CZ']],
        ["KR", sipinterface['vspa_KR']],
        ["CD", sipinterface['vspa_CD']],
        ["DO", sipinterface['vspa_DO']],
        ["KP", sipinterface['vspa_KP']],
        ["RE", sipinterface['vspa_RE']],
        ["RO", sipinterface['vspa_RO']],
        ["RW", sipinterface['vspa_RW']],
        ["RU", sipinterface['vspa_RU']],
        ["PM", sipinterface['vspa_PM']],
        ["WS", sipinterface['vspa_WS']],
        ["AS", sipinterface['vspa_AS']],
        ["SH", sipinterface['vspa_SH']],
        ["LC", sipinterface['vspa_LC']],
        ["BL", sipinterface['vspa_BL']],
        ["KN", sipinterface['vspa_KN']],
        ["SM", sipinterface['vspa_SM']],
        ["MF", sipinterface['vspa_MF']],
        ["ST", sipinterface['vspa_ST']],
        ["VC", sipinterface['vspa_VC']],
        ["SN", sipinterface['vspa_SN']],
        ["SL", sipinterface['vspa_SL']],
        ["RS", sipinterface['vspa_RS']],
        ["SC", sipinterface['vspa_SC']],
        ["SX", sipinterface['vspa_SX']],
        ["SY", sipinterface['vspa_SY']],
        ["SO", sipinterface['vspa_SO']],
        ["LK", sipinterface['vspa_LK']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SD", sipinterface['vspa_SD']],
        ["SS", sipinterface['vspa_SS']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["SR", sipinterface['vspa_SR']],
        ["SJ", sipinterface['vspa_SJ']],
        ["TH", sipinterface['vspa_TH']],
        ["TW", sipinterface['vspa_TW']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TZ", sipinterface['vspa_TZ']],
        ["IO", sipinterface['vspa_IO']],
        ["TF", sipinterface['vspa_TF']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["TO", sipinterface['vspa_TO']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TM", sipinterface['vspa_TM']],
        ["TR", sipinterface['vspa_TR']],
        ["TV", sipinterface['vspa_TV']],
        ["UA", sipinterface['vspa_UA']],
        ["UG", sipinterface['vspa_UG']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["VU", sipinterface['vspa_VU']],
        ["VA", sipinterface['vspa_VA']],
        ["VE", sipinterface['vspa_VE']],
        ["VN", sipinterface['vspa_VN']],
        ["WF", sipinterface['vspa_WF']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']]];

      var RegionTU = [
        ["US", sipinterface['vspa_US']],
        ["AF", sipinterface['vspa_AF']],
        ["AX", sipinterface['vspa_AX']],
        ["DE", sipinterface['vspa_DE']],
        ["UM", sipinterface['vspa_UM']],
        ["AS", sipinterface['vspa_AS']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["AR", sipinterface['vspa_AR']],
        ["AL", sipinterface['vspa_AL']],
        ["AW", sipinterface['vspa_AW']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["BS", sipinterface['vspa_BS']],
        ["BH", sipinterface['vspa_BH']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BE", sipinterface['vspa_BE']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BY", sipinterface['vspa_BY']],
        ["AE", sipinterface['vspa_AE']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BV", sipinterface['vspa_BV']],
        ["BR", sipinterface['vspa_BR']],
        ["IO", sipinterface['vspa_IO']],
        ["BN", sipinterface['vspa_BN']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["BT", sipinterface['vspa_BT']],
        ["GB", sipinterface['vspa_GB']],
        ["CV", sipinterface['vspa_CV']],
        ["KY", sipinterface['vspa_KY']],
        ["GI", sipinterface['vspa_GI']],
        ["DZ", sipinterface['vspa_DZ']],
        ["CX", sipinterface['vspa_CX']],
        ["DJ", sipinterface['vspa_DJ']],
        ["CC", sipinterface['vspa_CC']],
        ["CK", sipinterface['vspa_CK']],
        ["CW", sipinterface['vspa_CW']],
        ["TD", sipinterface['vspa_TD']],
        ["CZ", sipinterface['vspa_CZ']],
        ["CN", sipinterface['vspa_CN']],
        ["DK", sipinterface['vspa_DK']],
        ["CD", sipinterface['vspa_CD']],
        ["DO", sipinterface['vspa_DO']],
        ["DM", sipinterface['vspa_DM']],
        ["EC", sipinterface['vspa_EC']],
        ["GQ", sipinterface['vspa_GQ']],
        ["SV", sipinterface['vspa_SV']],
        ["ID", sipinterface['vspa_ID']],
        ["ER", sipinterface['vspa_ER']],
        ["AM", sipinterface['vspa_AM']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["FK", sipinterface['vspa_FK']],
        ["FO", sipinterface['vspa_FO']],
        ["MA", sipinterface['vspa_MA']],
        ["FJ", sipinterface['vspa_FJ']],
        ["CI", sipinterface['vspa_CI']],
        ["PH", sipinterface['vspa_PH']],
        ["PS", sipinterface['vspa_PS']],
        ["FI", sipinterface['vspa_FI']],
        ["FR", sipinterface['vspa_FR']],
        ["TF", sipinterface['vspa_TF']],
        ["GF", sipinterface['vspa_GF']],
        ["PF", sipinterface['vspa_PF']],
        ["GA", sipinterface['vspa_GA']],
        ["GM", sipinterface['vspa_GM']],
        ["GH", sipinterface['vspa_GH']],
        ["GN", sipinterface['vspa_GN']],
        ["GW", sipinterface['vspa_GW']],
        ["GD", sipinterface['vspa_GD']],
        ["GL", sipinterface['vspa_GL']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GT", sipinterface['vspa_GT']],
        ["GG", sipinterface['vspa_GG']],
        ["GY", sipinterface['vspa_GY']],
        ["ZA", sipinterface['vspa_ZA']],
        ["GS", sipinterface['vspa_GS']],
        ["SS", sipinterface['vspa_SS']],
        ["GE", sipinterface['vspa_GE']],
        ["HT", sipinterface['vspa_HT']],
        ["HM", sipinterface['vspa_HM']],
        ["HR", sipinterface['vspa_HR']],
        ["IN", sipinterface['vspa_IN']],
        ["NL", sipinterface['vspa_NL']],
        ["HN", sipinterface['vspa_HN']],
        ["HK", sipinterface['vspa_HK']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IR", sipinterface['vspa_IR']],
        ["IE", sipinterface['vspa_IE']],
        ["ES", sipinterface['vspa_ES']],
        ["IL", sipinterface['vspa_IL']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["IT", sipinterface['vspa_IT']],
        ["IS", sipinterface['vspa_IS']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']],
        ["JE", sipinterface['vspa_JE']],
        ["KH", sipinterface['vspa_KH']],
        ["CM", sipinterface['vspa_CM']],
        ["CA", sipinterface['vspa_CA']],
        ["ME", sipinterface['vspa_ME']],
        ["QA", sipinterface['vspa_QA']],
        ["KZ", sipinterface['vspa_KZ']],
        ["KE", sipinterface['vspa_KE']],
        ["CY", sipinterface['vspa_CY']],
        ["KG", sipinterface['vspa_KG']],
        ["KI", sipinterface['vspa_KI']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["KR", sipinterface['vspa_KR']],
        ["KP", sipinterface['vspa_KP']],
        ["CR", sipinterface['vspa_CR']],
        ["CU", sipinterface['vspa_CU']],
        ["KW", sipinterface['vspa_KW']],
        ["MK", sipinterface['vspa_MK']],
        ["MP", sipinterface['vspa_MP']],
        ["LA", sipinterface['vspa_LA']],
        ["LS", sipinterface['vspa_LS']],
        ["LV", sipinterface['vspa_LV']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LT", sipinterface['vspa_LT']],
        ["LB", sipinterface['vspa_LB']],
        ["LU", sipinterface['vspa_LU']],
        ["HU", sipinterface['vspa_HU']],
        ["MG", sipinterface['vspa_MG']],
        ["MO", sipinterface['vspa_MO']],
        ["MW", sipinterface['vspa_MW']],
        ["MV", sipinterface['vspa_MV']],
        ["MY", sipinterface['vspa_MY']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["IM", sipinterface['vspa_IM']],
        ["MH", sipinterface['vspa_MH']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MU", sipinterface['vspa_MU']],
        ["YT", sipinterface['vspa_YT']],
        ["MX", sipinterface['vspa_MX']],
        ["EG", sipinterface['vspa_EG']],
        ["FM", sipinterface['vspa_FM']],
        ["MN", sipinterface['vspa_MN']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MS", sipinterface['vspa_MS']],
        ["MR", sipinterface['vspa_MR']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MM", sipinterface['vspa_MM']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NI", sipinterface['vspa_NI']],
        ["NU", sipinterface['vspa_NU']],
        ["NF", sipinterface['vspa_NF']],
        ["NO", sipinterface['vspa_NO']],
        ["CF", sipinterface['vspa_CF']],
        ["UZ", sipinterface['vspa_UZ']],
        ["PK", sipinterface['vspa_PK']],
        ["PW", sipinterface['vspa_PW']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PN", sipinterface['vspa_PN']],
        ["PL", sipinterface['vspa_PL']],
        ["PT", sipinterface['vspa_PT']],
        ["PR", sipinterface['vspa_PR']],
        ["RE", sipinterface['vspa_RE']],
        ["RO", sipinterface['vspa_RO']],
        ["RW", sipinterface['vspa_RW']],
        ["RU", sipinterface['vspa_RU']],
        ["BL", sipinterface['vspa_BL']],
        ["SH", sipinterface['vspa_SH']],
        ["KN", sipinterface['vspa_KN']],
        ["LC", sipinterface['vspa_LC']],
        ["MF", sipinterface['vspa_MF']],
        ["PM", sipinterface['vspa_PM']],
        ["VC", sipinterface['vspa_VC']],
        ["WS", sipinterface['vspa_WS']],
        ["SM", sipinterface['vspa_SM']],
        ["ST", sipinterface['vspa_ST']],
        ["SN", sipinterface['vspa_SN']],
        ["SC", sipinterface['vspa_SC']],
        ["RS", sipinterface['vspa_RS']],
        ["SL", sipinterface['vspa_SL']],
        ["SG", sipinterface['vspa_SG']],
        ["SX", sipinterface['vspa_SX']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["SB", sipinterface['vspa_SB']],
        ["SO", sipinterface['vspa_SO']],
        ["LK", sipinterface['vspa_LK']],
        ["SD", sipinterface['vspa_SD']],
        ["SR", sipinterface['vspa_SR']],
        ["SY", sipinterface['vspa_SY']],
        ["SA", sipinterface['vspa_SA']],
        ["SJ", sipinterface['vspa_SJ']],
        ["SZ", sipinterface['vspa_SZ']],
        ["CL", sipinterface['vspa_CL']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TH", sipinterface['vspa_TH']],
        ["TW", sipinterface['vspa_TW']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["TO", sipinterface['vspa_TO']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TR", sipinterface['vspa_TR']],
        ["TM", sipinterface['vspa_TM']],
        ["TC", sipinterface['vspa_TC']],
        ["TV", sipinterface['vspa_TV']],
        ["UG", sipinterface['vspa_UG']],
        ["UA", sipinterface['vspa_UA']],
        ["OM", sipinterface['vspa_OM']],
        ["UY", sipinterface['vspa_UY']],
        ["JO", sipinterface['vspa_JO']],
        ["VU", sipinterface['vspa_VU']],
        ["VA", sipinterface['vspa_VA']],
        ["VE", sipinterface['vspa_VE']],
        ["VN", sipinterface['vspa_VN']],
        ["VI", sipinterface['vspa_VI']],
        ["VG", sipinterface['vspa_VG']],
        ["WF", sipinterface['vspa_WF']],
        ["YE", sipinterface['vspa_YE']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["GR", sipinterface['vspa_GR']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']]];

      var RegionGe = [
        ["AF", sipinterface['vspa_AF']],
        ["AX", sipinterface['vspa_AX']],
        ["AL", sipinterface['vspa_AL']],
        ["DZ", sipinterface['vspa_DZ']],
        ["AS", sipinterface['vspa_AS']],
        ["AD", sipinterface['vspa_AD']],
        ["AO", sipinterface['vspa_AO']],
        ["AI", sipinterface['vspa_AI']],
        ["AQ", sipinterface['vspa_AQ']],
        ["AG", sipinterface['vspa_AG']],
        ["AR", sipinterface['vspa_AR']],
        ["AM", sipinterface['vspa_AM']],
        ["AW", sipinterface['vspa_AW']],
        ["AU", sipinterface['vspa_AU']],
        ["AT", sipinterface['vspa_AT']],
        ["AZ", sipinterface['vspa_AZ']],
        ["BS", sipinterface['vspa_BS']],
        ["BH", sipinterface['vspa_BH']],
        ["BD", sipinterface['vspa_BD']],
        ["BB", sipinterface['vspa_BB']],
        ["BY", sipinterface['vspa_BY']],
        ["BE", sipinterface['vspa_BE']],
        ["BZ", sipinterface['vspa_BZ']],
        ["BJ", sipinterface['vspa_BJ']],
        ["BM", sipinterface['vspa_BM']],
        ["BT", sipinterface['vspa_BT']],
        ["BO", sipinterface['vspa_BO']],
        ["BQ", sipinterface['vspa_BQ']],
        ["BA", sipinterface['vspa_BA']],
        ["BW", sipinterface['vspa_BW']],
        ["BV", sipinterface['vspa_BV']],
        ["BR", sipinterface['vspa_BR']],
        ["IO", sipinterface['vspa_IO']],
        ["BN", sipinterface['vspa_BN']],
        ["BG", sipinterface['vspa_BG']],
        ["BF", sipinterface['vspa_BF']],
        ["BI", sipinterface['vspa_BI']],
        ["KH", sipinterface['vspa_KH']],
        ["CM", sipinterface['vspa_CM']],
        ["CA", sipinterface['vspa_CA']],
        ["CV", sipinterface['vspa_CV']],
        ["KY", sipinterface['vspa_KY']],
        ["CF", sipinterface['vspa_CF']],
        ["TD", sipinterface['vspa_TD']],
        ["CL", sipinterface['vspa_CL']],
        ["CN", sipinterface['vspa_CN']],
        ["CX", sipinterface['vspa_CX']],
        ["CC", sipinterface['vspa_CC']],
        ["CO", sipinterface['vspa_CO']],
        ["KM", sipinterface['vspa_KM']],
        ["CG", sipinterface['vspa_CG']],
        ["CK", sipinterface['vspa_CK']],
        ["CR", sipinterface['vspa_CR']],
        ["CI", sipinterface['vspa_CI']],
        ["HR", sipinterface['vspa_HR']],
        ["CU", sipinterface['vspa_CU']],
        ["CW", sipinterface['vspa_CW']],
        ["CY", sipinterface['vspa_CY']],
        ["CZ", sipinterface['vspa_CZ']],
        ["KP", sipinterface['vspa_KP']],
        ["DK", sipinterface['vspa_DK']],
        ["DJ", sipinterface['vspa_DJ']],
        ["DM", sipinterface['vspa_DM']],
        ["DO", sipinterface['vspa_DO']],
        ["EC", sipinterface['vspa_EC']],
        ["EG", sipinterface['vspa_EG']],
        ["SV", sipinterface['vspa_SV']],
        ["GQ", sipinterface['vspa_GQ']],
        ["ER", sipinterface['vspa_ER']],
        ["EE", sipinterface['vspa_EE']],
        ["ET", sipinterface['vspa_ET']],
        ["FK", sipinterface['vspa_FK']],
        ["FO", sipinterface['vspa_FO']],
        ["FJ", sipinterface['vspa_FJ']],
        ["FI", sipinterface['vspa_FI']],
        ["FR", sipinterface['vspa_FR']],
        ["GF", sipinterface['vspa_GF']],
        ["PF", sipinterface['vspa_PF']],
        ["TF", sipinterface['vspa_TF']],
        ["GA", sipinterface['vspa_GA']],
        ["GM", sipinterface['vspa_GM']],
        ["GE", sipinterface['vspa_GE']],
        ["DE", sipinterface['vspa_DE']],
        ["GH", sipinterface['vspa_GH']],
        ["GI", sipinterface['vspa_GI']],
        ["GR", sipinterface['vspa_GR']],
        ["GL", sipinterface['vspa_GL']],
        ["GD", sipinterface['vspa_GD']],
        ["GP", sipinterface['vspa_GP']],
        ["GU", sipinterface['vspa_GU']],
        ["GT", sipinterface['vspa_GT']],
        ["GG", sipinterface['vspa_GG']],
        ["GN", sipinterface['vspa_GN']],
        ["GW", sipinterface['vspa_GW']],
        ["GY", sipinterface['vspa_GY']],
        ["HT", sipinterface['vspa_HT']],
        ["HM", sipinterface['vspa_HM']],
        ["HN", sipinterface['vspa_HN']],
        ["HK", sipinterface['vspa_HK']],
        ["HU", sipinterface['vspa_HU']],
        ["IS", sipinterface['vspa_IS']],
        ["IN", sipinterface['vspa_IN']],
        ["ID", sipinterface['vspa_ID']],
        ["IR", sipinterface['vspa_IR']],
        ["IQ", sipinterface['vspa_IQ']],
        ["IE", sipinterface['vspa_IE']],
        ["IM", sipinterface['vspa_IM']],
        ["IL", sipinterface['vspa_IL']],
        ["IT", sipinterface['vspa_IT']],
        ["JM", sipinterface['vspa_JM']],
        ["JP", sipinterface['vspa_JP']],
        ["JE", sipinterface['vspa_JE']],
        ["JO", sipinterface['vspa_JO']],
        ["KZ", sipinterface['vspa_KZ']],
        ["KE", sipinterface['vspa_KE']],
        ["KI", sipinterface['vspa_KI']],
        ["KW", sipinterface['vspa_KW']],
        ["KG", sipinterface['vspa_KG']],
        ["LA", sipinterface['vspa_LA']],
        ["LV", sipinterface['vspa_LV']],
        ["LB", sipinterface['vspa_LB']],
        ["LS", sipinterface['vspa_LS']],
        ["LR", sipinterface['vspa_LR']],
        ["LY", sipinterface['vspa_LY']],
        ["LI", sipinterface['vspa_LI']],
        ["LT", sipinterface['vspa_LT']],
        ["LU", sipinterface['vspa_LU']],
        ["MO", sipinterface['vspa_MO']],
        ["MG", sipinterface['vspa_MG']],
        ["MW", sipinterface['vspa_MW']],
        ["MY", sipinterface['vspa_MY']],
        ["MV", sipinterface['vspa_MV']],
        ["ML", sipinterface['vspa_ML']],
        ["MT", sipinterface['vspa_MT']],
        ["MH", sipinterface['vspa_MH']],
        ["MQ", sipinterface['vspa_MQ']],
        ["MR", sipinterface['vspa_MR']],
        ["MU", sipinterface['vspa_MU']],
        ["YT", sipinterface['vspa_YT']],
        ["MX", sipinterface['vspa_MX']],
        ["FM", sipinterface['vspa_FM']],
        ["MD", sipinterface['vspa_MD']],
        ["MC", sipinterface['vspa_MC']],
        ["MN", sipinterface['vspa_MN']],
        ["ME", sipinterface['vspa_ME']],
        ["MS", sipinterface['vspa_MS']],
        ["MA", sipinterface['vspa_MA']],
        ["MZ", sipinterface['vspa_MZ']],
        ["MM", sipinterface['vspa_MM']],
        ["NA", sipinterface['vspa_NA']],
        ["NR", sipinterface['vspa_NR']],
        ["NP", sipinterface['vspa_NP']],
        ["NL", sipinterface['vspa_NL']],
        ["NC", sipinterface['vspa_NC']],
        ["NZ", sipinterface['vspa_NZ']],
        ["NI", sipinterface['vspa_NI']],
        ["NE", sipinterface['vspa_NE']],
        ["NG", sipinterface['vspa_NG']],
        ["NU", sipinterface['vspa_NU']],
        ["NF", sipinterface['vspa_NF']],
        ["MK", sipinterface['vspa_MK']],
        ["MP", sipinterface['vspa_MP']],
        ["NO", sipinterface['vspa_NO']],
        ["OM", sipinterface['vspa_OM']],
        ["PK", sipinterface['vspa_PK']],
        ["PW", sipinterface['vspa_PW']],
        ["PS", sipinterface['vspa_PS']],
        ["PA", sipinterface['vspa_PA']],
        ["PG", sipinterface['vspa_PG']],
        ["PY", sipinterface['vspa_PY']],
        ["PE", sipinterface['vspa_PE']],
        ["PH", sipinterface['vspa_PH']],
        ["PN", sipinterface['vspa_PN']],
        ["PL", sipinterface['vspa_PL']],
        ["PT", sipinterface['vspa_PT']],
        ["PR", sipinterface['vspa_PR']],
        ["QA", sipinterface['vspa_QA']],
        ["KR", sipinterface['vspa_KR']],
        ["RE", sipinterface['vspa_RE']],
        ["RO", sipinterface['vspa_RO']],
        ["RU", sipinterface['vspa_RU']],
        ["RW", sipinterface['vspa_RW']],
        ["BL", sipinterface['vspa_BL']],
        ["SH", sipinterface['vspa_SH']],
        ["KN", sipinterface['vspa_KN']],
        ["LC", sipinterface['vspa_LC']],
        ["MF", sipinterface['vspa_MF']],
        ["PM", sipinterface['vspa_PM']],
        ["VC", sipinterface['vspa_VC']],
        ["WS", sipinterface['vspa_WS']],
        ["SM", sipinterface['vspa_SM']],
        ["ST", sipinterface['vspa_ST']],
        ["SA", sipinterface['vspa_SA']],
        ["SN", sipinterface['vspa_SN']],
        ["RS", sipinterface['vspa_RS']],
        ["SC", sipinterface['vspa_SC']],
        ["SL", sipinterface['vspa_SL']],
        ["SG", sipinterface['vspa_SG']],
        ["SX", sipinterface['vspa_SX']],
        ["SK", sipinterface['vspa_SK']],
        ["SI", sipinterface['vspa_SI']],
        ["SB", sipinterface['vspa_SB']],
        ["SO", sipinterface['vspa_SO']],
        ["ZA", sipinterface['vspa_ZA']],
        ["GS", sipinterface['vspa_GS']],
        ["SS", sipinterface['vspa_SS']],
        ["ES", sipinterface['vspa_ES']],
        ["LK", sipinterface['vspa_LK']],
        ["SD", sipinterface['vspa_SD']],
        ["SR", sipinterface['vspa_SR']],
        ["SJ", sipinterface['vspa_SJ']],
        ["SZ", sipinterface['vspa_SZ']],
        ["SE", sipinterface['vspa_SE']],
        ["CH", sipinterface['vspa_CH']],
        ["SY", sipinterface['vspa_SY']],
        ["TW", sipinterface['vspa_TW']],
        ["TJ", sipinterface['vspa_TJ']],
        ["TZ", sipinterface['vspa_TZ']],
        ["TH", sipinterface['vspa_TH']],
        ["CD", sipinterface['vspa_CD']],
        ["TL", sipinterface['vspa_TL']],
        ["TG", sipinterface['vspa_TG']],
        ["TK", sipinterface['vspa_TK']],
        ["TO", sipinterface['vspa_TO']],
        ["TT", sipinterface['vspa_TT']],
        ["TN", sipinterface['vspa_TN']],
        ["TR", sipinterface['vspa_TR']],
        ["TM", sipinterface['vspa_TM']],
        ["TC", sipinterface['vspa_TC']],
        ["TV", sipinterface['vspa_TV']],
        ["UG", sipinterface['vspa_UG']],
        ["UA", sipinterface['vspa_UA']],
        ["AE", sipinterface['vspa_AE']],
        ["GB", sipinterface['vspa_GB']],
        ["US", sipinterface['vspa_US']],
        ["UM", sipinterface['vspa_UM']],
        ["UY", sipinterface['vspa_UY']],
        ["UZ", sipinterface['vspa_UZ']],
        ["VU", sipinterface['vspa_VU']],
        ["VA", sipinterface['vspa_VA']],
        ["VE", sipinterface['vspa_VE']],
        ["VN", sipinterface['vspa_VN']],
        ["VG", sipinterface['vspa_VG']],
        ["VI", sipinterface['vspa_VI']],
        ["WF", sipinterface['vspa_WF']],
        ["YE", sipinterface['vspa_YE']],
        ["ZM", sipinterface['vspa_ZM']],
        ["ZW", sipinterface['vspa_ZW']]];

      for (i = 0; i < RegionEn.length; i++) {
        var Option = document.createElement("Option");
        if (curLanguage == "english") {
          if (brazclaroMode == 1) {
            if ((RegionEn[i][0] == "HK") || (RegionEn[i][0] == "TW") || (RegionEn[i][0] == "MO")) {
              continue;
            }
          }
          Option.value = RegionEn[i][0];
          Option.innerText = RegionEn[i][1];
          Option.text = RegionEn[i][1];
        }
        if (curLanguage == "chinese") {
          Option.value = RegionCh[i][0];
          Option.innerText = RegionCh[i][1];
          Option.text = RegionCh[i][1];
        }
        if (curLanguage == "spanish") {
          Option.value = RegionSpa[i][0];
          Option.innerText = RegionSpa[i][1];
          Option.text = RegionSpa[i][1];
        }
        if (curLanguage == "arabic") {
          Option.value = RegionArb[i][0];
          Option.innerText = RegionArb[i][1];
          Option.text = RegionArb[i][1];
        }
        if (curLanguage == "japanese") {
          Option.value = RegionJap[i][0];
          Option.innerText = RegionJap[i][1];
          Option.text = RegionJap[i][1];
        }
        if (curLanguage == "portuguese") {
          Option.value = RegionPT[i][0];
          Option.innerText = RegionPT[i][1];
          Option.text = RegionPT[i][1];
        }
        if (curLanguage == "russian") {
          Option.value = RegionRU[i][0];
          Option.innerText = RegionRU[i][1];
          Option.text = RegionRU[i][1];
        }
        if (curLanguage == "brasil") {
          if (brazclaroMode == 1) {
            if ((RegionBS[i][0] == "HK") || (RegionBS[i][0] == "TW") || (RegionBS[i][0] == "MO")) {
              continue;
            }
          }
          Option.value = RegionBS[i][0];
          Option.innerText = RegionBS[i][1];
          Option.text = RegionBS[i][1];
        }
        if (curLanguage == "turkish") {
          Option.value = RegionTu[i][0];
          Option.innerText = RegionTu[i][1];
          Option.text = RegionTu[i][1];
        }
        if (curLanguage == "german") {
          Option.value = RegionGe[i][0];
          Option.innerText = RegionGe[i][1];
          Option.text = RegionGe[i][1];
        }
        Control.appendChild(Option);

      }
    }

    function DropDownLineListSelect(id, ArrayOption) {
      var Control = getElById(id);
      var i = 1;

      var Option = document.createElement("Option");
      Option.value = "";
      Option.innerText = "";
      Option.text = "";
      Control.appendChild(Option);

      for (i = 1; i < ArrayOption.length; i++) {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
        Option.text = i;
        Control.appendChild(Option);
      }
    }

  </script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("VoipInterface", GetDescFormArrayById(h248interface, "v01"), GetDescFormArrayById(h248interface, "v02"), false);
  </script>
  <div class="title_spread"></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
    <tr>
      <td BindText="vspa_basic"></td>
    </tr>
  </table>

  <form id="voipbasic">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
      <li id="CallAgent1" RealType="TextBox" DescRef="vspa_primgc" RemarkRef="vspa_ipordomain" ErrorMsgRef="Empty"
        Require="TRUE" BindField="CallAgent1" InitValue="Empty" MaxLength="256" />
      <li id="CallAgentPort1" RealType="TextBox" DescRef="vspa_primgcport" RemarkRef="vspa_portbound"
        ErrorMsgRef="Empty" Require="TRUE" BindField="CallAgentPort1" InitValue="Empty" MaxLength="11" />
      <li id="CallAgent2" RealType="TextBox" DescRef="vspa_stmgcaddr" RemarkRef="vspa_ipordomain" ErrorMsgRef="Empty"
        Require="FALSE" BindField="CallAgent2" InitValue="Empty" MaxLength="256" />
      <li id="CallAgentPort2" RealType="TextBox" DescRef="vspa_stmgcport" RemarkRef="vspa_portbound" ErrorMsgRef="Empty"
        Require="FALSE" BindField="CallAgentPort2" InitValue="Empty" MaxLength="11" />
      <li id="MGDomain" RealType="TextBox" DescRef="vspa_mgdomain" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="MGDomain" InitValue="Empty" MaxLength="256" />
      <li id="LocalPort" RealType="TextBox" DescRef="vspa_loport" RemarkRef="vspa_localportbound" ErrorMsgRef="Empty"
        Require="TRUE" BindField="LocalPort" InitValue="Empty" MaxLength="11" />
      <li id="DeviceName" RealType="TextBox" DescRef="vspa_devicename1" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="DeviceName" InitValue="Empty" MaxLength="256" />
      <li id="MIDFormat" RealType="DropDownList" DescRef="vspa_midformat" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="MIDFormat"
        InitValue="[{TextRef:'vspa_domainname',Value:'DomainName'},{TextRef:'vspa_ip',Value:'IP'},{TextRef:'vspa_devicename',Value:'DeviceName'}]" />
      <li id="X_HW_DigitMapMatchMode" RealType="DropDownList" DescRef="vspa_digitmatchmode" RemarkRef="Empty"
        ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_DigitMapMatchMode"
        InitValue="[{TextRef:'vspa_min',Value:'Min'},{TextRef:'vspa_max',Value:'Max'}]" />
      <li id="DmAutoEnable" RealType="CheckBox" DescRef="vspa_digmapauto" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="DmAutoEnable" InitValue="Empty" />
      <li id="RTPTermIDPrefix" RealType="TextBox" DescRef="vspa_rtptid" RemarkRef="vspa_rtpprefixtips"
        ErrorMsgRef="Empty" Require="FALSE" BindField="RTPTermIDPrefix" InitValue="Empty" MaxLength="48" />
      <li id="RTPTermIDStartNum" RealType="TextBox" DescRef="vspa_startnumofrtp" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="RTPTermIDStartNum" InitValue="Empty" MaxLength="256" />
      <li id="RTPTermIDNumWidth" RealType="TextBox" DescRef="vspa_widofrtptid" RemarkRef="vspa_rtpwidthtips"
        ErrorMsgRef="Empty" Require="FALSE" BindField="RTPTermIDNumWidth" InitValue="Empty" MaxLength="256" />
      <li id="X_HW_PortName" RealType="DropDownList" DescRef="vspa_sigport" RemarkRef="vspa_sigporthint"
        ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" Elementclass="restrict_dir_ltr" />
      <li id="MediaPortName" RealType="DropDownList" DescRef="vspa_medport" RemarkRef="vspa_medporthint"
        ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" Elementclass="restrict_dir_ltr" />
      <li id="Region" RealType="DropDownList" DescRef="vspa_Region" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="Region" InitValue="Empty" />
      <script>
        var VoipConfigFormList1 = HWGetLiIdListByForm("voipbasic", null);
        HWParsePageControlByID("voipbasic", TableClass, h248interface, null);
        var VoipBasicParaSetArray = new Array();
        if (0 == SingTelMode) {
          DropDownListSelect("X_HW_PortName", WanInfo);
          DropDownListSelect("MediaPortName", WanInfo);
        }
        RegionSelect("Region");
        HWSetTableByLiIdList(VoipConfigFormList1, VoipBasicParaSetArray, null);
      </script>
    </table>
  </form>

  <div class="func_spread"></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
    <tr>
      <td BindText="vspa_userbaspara"></td>
    </tr>
  </table>

  <script language="JavaScript" type="text/JavaScript">
var i = 0;
var ShowableFlag = 1;
var ShowButtonFlag = 1;
var ColumnNum = 4;
var VoipArray = new Array();
var ConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox",false),
							new stTableTileInfo("vspa_seq","align_center","index",false),
							new stTableTileInfo("vspa_linename","align_center","LineName",false),
							new stTableTileInfo("vspa_assopot","align_center","PhyReferenceList",false),null);
if (Line.length == 0)
{
	var VoipShowTab = new ShowTab();
		
	VoipShowTab.index = "--";
	VoipShowTab.LineName = "--";
	VoipShowTab.PhyReferenceList = "--";
}
else
{
	for (var i = 0; i < Line.length; i++)
	{
		var VoipShowTab = new ShowTab();
			
		VoipShowTab.domain = Line[i].Domain;
		
		VoipShowTab.index = i+1;	
		  
		if (Line[i].LineName == "")
		{
			VoipShowTab.LineName = '--';
		}
		else
		{
			VoipShowTab.LineName = Line[i].LineName;
		}  
		
		VoipShowTab.PhyReferenceList = Line[i].PhyReferenceList;  
		VoipArray.push(VoipShowTab);      
			
	}
}

VoipArray.push(null);
HWShowTableListByType(ShowableFlag, "tdVoipInfo", ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, h248interface, null);
</script>

  <form id="ConfigForm1">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
      <li id="Enable" RealType="CheckBox" DescRef="vspa_enablelinename" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="Enable" InitValue="Empty" />
      <li id="LineName" RealType="TextBox" DescRef="vspa_linename1" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="" InitValue="Empty" MaxLength="256" />
      <li id="PhyReferenceList" RealType="DropDownList" DescRef="vspa_assopot1" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="PhyReferenceList" InitValue="Empty" />
      <script>
        var VoipConfigFormList2 = HWGetLiIdListByForm("ConfigForm1", null);
        HWParsePageControlByID("ConfigForm1", TableClass, h248interface, null);
        DropDownLineListSelect("PhyReferenceList", AllPhyInterface);
      </script>
    </table>
  </form>



  <table width="100%" border="0" cellpadding="0" cellspacing="1">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr>
            <td class="width_per25 table_submit"></td>

            <td class="table_submit">
              <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <input name="btnApplyVoipUser" id="btnApplyVoipUser" type="button"
                class="ApplyButtoncss buttonwidth_100px" value="Apply" onClick="SubmitBasicPara();" />
              <script type="text/javascript">
                document.getElementsByName('btnApplyVoipUser')[0].value = h248interface['vspa_apply'];
              </script>
              <input name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px"
                value="Cancel" onClick="CancelUserConfig();" />
              <script>
                document.getElementsByName('cancelValue')[0].value = h248interface['vspa_cancel'];
              </script>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="height10p"></td>
    </tr>
  </table>
</body>

</html>