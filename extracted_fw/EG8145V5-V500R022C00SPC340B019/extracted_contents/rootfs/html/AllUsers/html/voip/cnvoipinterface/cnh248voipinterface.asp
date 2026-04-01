<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248interface);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
  <title>VOIP Interface</title>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
  <script language="javascript" src="../../bbsp/common/wan_list.asp"></script>

  <script language="JavaScript" type="text/javascript">

    var selctIndex = -1;
    var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
    var MngtYnct = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_YNCT);%>";
    var CfgMode = '<%HW_WEB_GetCfgMode();%>';
    var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";


    function isValidVoipPort(port) {
      if (!isInteger(port) || port < 0 || port > 65535) {
        return false;
      }

      return true;
    }

    function stServerType(Domain, X_HW_ServerType) {
      this.Domain = Domain;
      this.X_HW_ServerType = X_HW_ServerType;
    }
    var AllServerType = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1,X_HW_ServerType,stServerType);%>;

    function stDeviceInfoVoiceMode(Domain, X_HW_VOICE_MODE) {
      this.Domain = Domain;
      this.X_HW_VOICE_MODE = X_HW_VOICE_MODE;
    }

    var DeviceVoiceMode = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo,X_HW_VOICE_MODE,stDeviceInfoVoiceMode);%>;


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
    var RTPs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.RTP, X_HW_PortName, stRTP);%>;
    var RTP = RTPs[0];

    function stH248Server(Domain, CallAgent1, CallAgentPort1, CallAgent2, CallAgentPort2, LocalPort, MGDomain, DeviceName, MessageEncodingType, MIDFormat) {
      this.Domain = Domain;
      this.CallAgent1 = CallAgent1;
      this.CallAgentPort1 = CallAgentPort1;
      this.CallAgent2 = CallAgent2;
      this.LocalPort = LocalPort;
      this.MGDomain = MGDomain;
      this.MessageEncodingType = MessageEncodingType;
      this.DeviceName = DeviceName;
      this.MIDFormat = MIDFormat;
      this.key = "";
      this.CallAgentPort2 = CallAgentPort2;

      var temp = Domain.split('.');
      this.key = '.' + temp[5] + '.';
    }

    var AllH248Server = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248,CallAgent1|CallAgentPort1|CallAgent2|CallAgentPort2|LocalPort|Domain|DeviceName|MessageEncodingType|MIDFormat,stH248Server);%>;
    var H248Server = new Array();
    for (var i = 0; i < AllH248Server.length; i++)
      H248Server[i] = AllH248Server[i];


    AssociateParam1(Profile, H248Server, 'CallAgent1|CallAgentPort1|CallAgent2|CallAgentPort2|LocalPort|Domain|DeviceName|MessageEncodingType|MIDFormat');


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

    function stDftRoute(domain, autoenable, wandomain) {
      this.domain = domain;
      this.autoenable = autoenable;
      this.wandomain = wandomain;
    }

    function stWanInfo(domain, Enable, CntType, Name, ConnectionStatus, NATEnabled, DefaultGateway, ServiceList, ExServiceList, vlanid, MacId, submask) {
      this.domain = domain;
      this.Enable = Enable;
      this.CntType = CntType;
      this.Name = Name;
      this.ConnectionStatus = ConnectionStatus;
      this.NATEnabled = NATEnabled;
      this.DefaultGateway = DefaultGateway;
      this.ServiceList = (ExServiceList.length == 0) ? ServiceList : ExServiceList;
      this.vlanid = vlanid;
      this.MacId = MacId;
      this.submask = submask;
    }

    var WanIPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId|SubnetMask,stWanInfo);%>;

    var WanPPPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}, Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId,stWanInfo);%>;

    var dftRoutes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Layer3Forwarding,X_HW_AutoDefaultGatewayEnable|DefaultConnectionService,stDftRoute);%>;


    var dftRoute = dftRoutes[0];

    var WanInfo = new Array();

    for (i = 0, j = 0; WanIPInfo.length > 0 && i < WanIPInfo.length - 1; i++) {
      WanIPInfo[i].ServiceList = WanIPInfo[i].ServiceList.toUpperCase();

      if ((true == WanIPInfo[i].Enable)
        && (WanIPInfo[i].ServiceList.indexOf("VOIP") >= 0)
      ) {
        WanInfo[j] = WanIPInfo[i];
        j++;
      }
    }

    for (i = 0; WanPPPInfo.length > 0 && i < WanPPPInfo.length - 1; i++) {
      WanPPPInfo[i].ServiceList = WanPPPInfo[i].ServiceList.toUpperCase();

      if ((true == WanPPPInfo[i].Enable)
        && (WanPPPInfo[i].ServiceList.indexOf("VOIP") >= 0)
      ) {
        WanInfo[j] = WanPPPInfo[i];
        j++;
      }
    }

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

      setSelect('ServerType_select', AllServerType[0].X_HW_ServerType);
      if (DeviceVoiceMode != null) {
        if (DeviceVoiceMode[0] != null) {
          if (DeviceVoiceMode[0].X_HW_VOICE_MODE != 0) {
            setDisable('ServerType_select', 1);
          }
        }
      }

      if (Profile[0].CallAgent1 == "255.255.255.255") {
        Profile[0].CallAgent1 = "";
      }

      if (Profile[0].CallAgent2 == "255.255.255.255") {
        Profile[0].CallAgent2 = "";
      }

      setText('MediaGatewayControler_text', Profile[0].CallAgent1);
      setText('MediaGatewayControlerPort_text', Profile[0].CallAgentPort1);
      setText('StandbyMediaGatewayControler_text', Profile[0].CallAgent2);
      setText('StandbyMediaGatewayControlerPort_text', Profile[0].CallAgentPort2);

      var PFMGDomain = Profile[0].MGDomain;
      if ((MngtYnct == 1) && ('' != PFMGDomain)) {
        setText('MGDomain', "******");
      }
      else {
        setText('MGDomain', Profile[0].MGDomain);
      }

      setText('MediaGatewayPort_text', Profile[0].LocalPort);
      setText('DeviceID_text', Profile[0].DeviceName);
      setText('MessageEncodingType_text', Profile[0].MessageEncodingType);
      setText("DeviceIDType_text", Profile[0].MIDFormat);
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

      setText("RTPPrefix_text", ExtendAttr.RTPTermIDPrefix);
      setText("EphemeralTermIDStart_text", ExtendAttr.RTPTermIDStartNum);
      setText("EphemeralTermIDAddLen_text", ExtendAttr.RTPTermIDNumWidth);
      setCheck('DmAutoEnable', varDmAutoEnable);
    }



    function LoadFrame() {
      if (AllPhyInterface.length >= 3) {
        if (Line.length > 0) {
          selectLine('record_0');
          setDisplay('ConfigForm1', 1);
        }
        else {
          selectLine('record_no');
          setDisplay('ConfigForm1', 0);
        }
      }
      else {
        if (Line.length == 0) {
          setCheck('FXSPortEnable_checkbox', 0);
          setText('LineName', "");
        }
        else {
          setCheck('FXSPortEnable_checkbox', Line[0].Enable);
          setText('LineName', Line[0].LineName);
        }

        setDisplay('ConfigForm1', 1);
      }

      if ('SCCT' == CfgMode.toUpperCase()) {
        setDisable('Newbutton', 1);
        setDisable('DeleteButton', 1);
        setDisable('FXSPortEnable_checkbox', 1);
        setDisable('LineName', 1);
        setDisable('PhyReferenceList', 1);
      }

      init();
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
      var CallAgent1 = document.getElementById('MediaGatewayControler_text');
      var CallAgentPort1 = document.getElementById('MediaGatewayControlerPort_text');
      var CallAgentPort2 = document.getElementById('StandbyMediaGatewayControlerPort_text');
      var X_HW_PortName = document.getElementById('X_HW_PortName');
      var LocalPort = document.getElementById('MediaGatewayPort_text');
      var CallAgent2 = document.getElementById('StandbyMediaGatewayControler_text');
      var MGDomain = document.getElementById('MGDomain');
      var DeviceName = document.getElementById('DeviceID_text');
      var MIDFormat = document.getElementById('DeviceIDType_text');
      var MessageEncodingType = document.getElementById('MessageEncodingType_text');
      var RTPTermIDPrefix = document.getElementById('RTPPrefix_text');
      var RTPTermIDStartNum = document.getElementById('EphemeralTermIDStart_text');
      var RTPTermIDNumWidth = document.getElementById('EphemeralTermIDAddLen_text');
      var MediaPortName = document.getElementById('MediaPortName');

      if ('' == removeSpaceTrim(getValue('MediaGatewayControler_text'))) {
        AlertEx(h248interface['vspa_primgcreq']);
        return false;
      }
      else {
        if (true == isIpAddress(getValue('MediaGatewayControler_text'))) {
          if (false == isvalidVoipIpAddress(CallAgent1.value)) {
            AlertEx(h248interface['vspa_primgcaddinva']);
            return false;
          }
        }
        else {
          if (false == vspaisValidCfgStr(h248interface['vspa_theprimgc'], CallAgent1.value, 65)) {
            return false;
          }
          var proxyserv = getValue('MediaGatewayControler_text');
          if ((proxyserv.substring(0, 1) <= 9) && (proxyserv.substring(0, 1) >= 0)) {
            AlertEx(h248interface['vspa_primgcaddinva']);
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

          var proxysndserv = getValue('StandbyMediaGatewayControler_text');

          if ((proxysndserv.substring(0, 1) <= 9) && (proxysndserv.substring(0, 1) >= 0)) {
            if (!((proxysndserv.length == 1) && (proxysndserv.substring(0, 1) == 0))) {
              AlertEx(h248interface['vspa_thestmgaddinva']);
              return false;
            }
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

    function SubmitServerType() {
      var Form = new webSubmitForm();

      Form.addParameter('x.X_HW_ServerType', getSelectVal('ServerType_select'));
      Form.addParameter('x.X_HW_Token', getValue('onttoken'));

      ActionURL = 'set.cgi?'
        + 'x=' + AllServerType[0].Domain
        + '&RequestFile=html/voip/cnvoipinterface/cnvoipServertypechangeTemp.asp';
      Form.setAction(ActionURL);
      Form.submit();
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

      if ('' == removeSpaceTrim(getValue('StandbyMediaGatewayControlerPort_text'))) {
        sndMgcPort = 0;
      }
      else {
        sndMgcPort = parseInt(getValue('StandbyMediaGatewayControlerPort_text'), 10);
      }

      Form.addParameter('y.CallAgent1', getValue('MediaGatewayControler_text'));
      Form.addParameter('y.CallAgentPort1', parseInt(getValue('MediaGatewayControlerPort_text'), 10));
      Form.addParameter('y.CallAgentPort2', sndMgcPort);
      Form.addParameter('y.LocalPort', parseInt(getValue('MediaGatewayPort_text'), 10));
      Form.addParameter('y.CallAgent2', getValue('StandbyMediaGatewayControler_text'));
      if (getValue('MGDomain') != "******") {
        Form.addParameter('y.Domain', getValue('MGDomain'));
      }
      Form.addParameter('y.DeviceName', getValue('DeviceID_text'));
      Form.addParameter('y.MIDFormat', getValue('DeviceIDType_text'));
      Form.addParameter('y.MessageEncodingType', getValue('MessageEncodingType_text'));
      Form.addParameter('z.RTPTermIDPrefix', getValue('RTPPrefix_text'));
      Form.addParameter('z.RTPTermIDStartNum', parseInt(getValue('EphemeralTermIDStart_text'), 10));
      Form.addParameter('z.RTPTermIDNumWidth', parseInt(getValue('EphemeralTermIDAddLen_text'), 10));

      if ('SCCT' == CfgMode.toUpperCase()) {
        selctIndex = -2;
      }
      else {
        if (AllPhyInterface.length <= 2) {

          Form.addParameter('Add_a.PhyReferenceList', 1);
          if (Line.length == 0) {
            selctIndex = -1;
          }
          else {
            selctIndex = 0;
          }

        }
        else {
          Form.addParameter('Add_a.PhyReferenceList', getValue('PhyReferenceList'));
        }

        Form.addParameter('b.LineName', getValue('LineName'));

        if (getCheckVal('FXSPortEnable_checkbox') == 1) {
          Form.addParameter('Add_a.Enable', 'Enabled');
        }
        else {
          Form.addParameter('Add_a.Enable', 'Disabled');
        }
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
          + '&RequestFile=html/voip/cnvoipinterface/cnvoipinterface.asp');

      }
      else if (selctIndex == -2) {
        Form.setAction('set.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&z=' + ExtendAttr.Domain
          + '&w=' + RTP.Domain
          + '&t=' + Profile[0].Domain + '.X_HW_H248' + '.Extend'
          + '&RequestFile=html/voip/cnvoipinterface/cnvoipinterface.asp');
      }
      else {
        Form.setAction('set.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&z=' + ExtendAttr.Domain
          + '&w=' + RTP.Domain
          + '&t=' + Profile[0].Domain + '.X_HW_H248' + '.Extend'
          + '&Add_a=' + Line[selctIndex].Domain
          + '&b=' + Line[selctIndex].Domain + '.X_HW_H248'
          + '&RequestFile=html/voip/cnvoipinterface/cnvoipinterface.asp');
      }
      setDisable('SaveApply_button', 1);
      setDisable('Cancel_button', 1);
      Form.submit();
    }

    var serverRecord = null;
    function setCtlDisplay(record) {
      setText('LineName', record.LineName);
      setSelect('PhyReferenceList', record.PhyReferenceList);
      setCheck('FXSPortEnable_checkbox', record.Enable);
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
      var rml = getElement('rml');
      var noChooseFlag = true;
      if (rml.length > 0) {
        for (var i = 0; i < rml.length; i++) {
          if (rml[i].checked == true) {
            noChooseFlag = false;
          }
        }
      }
      else if (rml.checked == true) {
        noChooseFlag = false;
      }
      if (noChooseFlag) {
        AlertEx(h248interface['vspa_nouserdel']);
        return;
      }

      if (ConfirmEx(h248interface['vspa_del']) == false) {
        document.getElementById("DeleteButton").disabled = false;
        return;
      }
      setDisable('SaveApply_button', 1);
      setDisable('Cancel_button', 1);
      removeInst('html/voip/cnvoipinterface/cnvoipinterface.asp');
    }

    function CheckBasicParaForm() {
      if (selctIndex != -2) {
        if (vspaisValidCfgStr(h248interface['vspa_thelinename'], getValue('LineName'), 64) == false) {
          return false;
        }

        if (AllPhyInterface.length > 2) {
          for (var i = 0; i < Line.length; i++) {
            if (selctIndex != i) {
              if ((getValue('PhyReferenceList') == Line[i].PhyReferenceList) && (getValue('PhyReferenceList') != '')) {
                AlertEx(h248interface['vspa_samepots']);
                return false;
              }
            }

          }
        }

      }
      return true;
    }

    function CancelUserConfig() {
      init();

      if (AllPhyInterface.length > 2) {
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
      else {
        if (Line.length == 0) {
          setCheck('FXSPortEnable_checkbox', 0);
          setText('LineName', "");
        }
        else {
          setCheck('FXSPortEnable_checkbox', Line[0].Enable);
          setText('LineName', Line[0].LineName);
        }
      }

    }

  </script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="tabal_head" BindText='vspa_protocol'></td>
    </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1">
    <tr>
      <td class="table_title align_left width_per25" BindText='vspa_protocolList'></td>
      <td class="table_right align_left width_per75">
        <select name="ServerType_select" id="ServerType_select" class="wid_60px" onchange="SubmitServerType();">
          <script language="JavaScript" type="text/javascript">
            document.write('<option value=' + "0" + ' id="IMS_SIP">' + "IMS" + '<\/option>');
            document.write('<option value=' + "1" + ' id="NGN_SIP">' + "软交换" + '<\/option>');
            document.write('<option value=' + "2" + ' id="H.248">' + "H.248" + '<\/option>');
          </script>
        </select>
      </td>
    </tr>
  </table>

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="height15p"></td>
    </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="tabal_head" BindText="vspa_basic"></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="height5p"></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="1">
    <tr>

      <td class="table_title align_left width_per25" BindText="vspa_primgc"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="MediaGatewayControler_text" id="MediaGatewayControler_text" maxlength="256"
          class="width_155px" />&nbsp;<strong style="color:#FF0033">*</strong><span class="gray">
          <script>document.write(h248interface['vspa_ipordomain']);</script>
        </span>
      </td>
    </tr>
    <tr>

      <td class="table_title align_left width_per25" BindText="vspa_primgcport"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="MediaGatewayControlerPort_text" id="MediaGatewayControlerPort_text" maxlength="11"
          value="2944" class="width_155px" />&nbsp;<strong style="color:#FF0033">*</strong><span
          class="gray">(0-65535)</span>
      </td>
    </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1">
    <tr>

      <td class="table_title align_left width_per25" BindText="vspa_stmgcaddr"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="StandbyMediaGatewayControler_text" id="StandbyMediaGatewayControler_text"
          maxlength="256" style="width: 155px" />&nbsp;<span class="gray">
          <script>document.write(h248interface['vspa_ipordomain']);</script>
        </span>
      </td>
    </tr>

    <tr>

      <td class="table_title align_left width_per25" BindText="vspa_stmgcport"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="StandbyMediaGatewayControlerPort_text" id="StandbyMediaGatewayControlerPort_text"
          maxlength="11" value="2944" style="width: 155px">&nbsp;<span class="gray">(0-65535)</span>
      </td>
    </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1">

    <tr>
      <td class="table_title align_left width_per25" BindText="vspa_mgdomain"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="MGDomain" id="MGDomain" maxlength="256" value="huawei.com" style="width: 155px" />
      </td>
    </tr>

    <tr>
      <td class="table_title align_left width_per25" BindText="vspa_loport"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="MediaGatewayPort_text" id="MediaGatewayPort_text" maxlength="11" value="2944"
          style="width: 155px">&nbsp;<strong style="color:#FF0033">*</strong><span class="gray">(1-65535)</span>
      </td>
    </tr>

    <tr>
      <td class="table_title align_left width_per25" BindText="vspa_devicename1"></td>
      <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="DeviceID_text" id="DeviceID_text" maxlength="256" value="huawei.com"
          style="width: 155px" />
      </td>
    </tr>

    <tr>
      <td class="table_title align_left width_per25">终端标识类型：</td>
      <td class="table_right align_left width_per75" colspan="2">
        <select name="DeviceIDType_text" id="DeviceIDType_text" style="width: 125px">
          <option value="DomainName">
            <script>document.write(h248interface['vspa_domainname']);</script>
          </option>
          <option value="IP">
            <script>document.write(h248interface['vspa_ip']);</script>
          </option>
          <option value="DeviceName">
            <script>document.write(h248interface['vspa_devicename']);</script>
          </option>
        </select>
      </td>
    </tr>


    <tr>
      <td class="table_title align_left width_per25">H.248协议编码类型：</td>
      <td class="table_right align_left width_per75" colspan="2">
        <select name="MessageEncodingType_text" id="MessageEncodingType_text" style="width: 125px">
          <option value="ABNF">ABNF</option>
          <option value="ASN.1">ASN.1</option>
        </select>
      </td>
    </tr>

    <tr>
      <td class="table_title align_left width_per25">RTP终结点标识前缀：</td>
      <td class="table_right align_left width_per75" colspan="2"><input type="text" name="RTPPrefix_text"
          id="RTPPrefix_text" maxlength="48" value="RTP/00" style="width: 155px">
        <span class="gray">
          <script>document.write(h248interface['vspa_rtpprefixtips']);</script>
        </span>
      </td>
    </tr>
    <tr>
      <td class="table_title align_left width_per25">RTP终结点标识名起始值：</td>
      <td class="table_right align_left width_per75" colspan="2"><input name="EphemeralTermIDStart_text" type="text"
          id="EphemeralTermIDStart_text" class="width_155px" value="0" maxlength="256"></td>
    </tr>
    <tr>
      <td class="table_title align_left width_per25">RTP终结点标识前缀后面添加的数字部分位数：</td>
      <td class="table_right align_left width_per75" colspan="2"><input name="EphemeralTermIDAddLen_text" type="text"
          id="EphemeralTermIDAddLen_text" style="width: 155px" value="6" maxlength="256">
        <span class="gray">
          <script>document.write(h248interface['vspa_rtpwidthtips']);</script>
        </span>
      </td>
    </tr>



  </table>

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="height15p"></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="tabal_head" BindText="vspa_userbaspara"></td>
    </tr>
  </table>

  <script language="JavaScript" type="text/javascript">
    if (AllPhyInterface.length > 2) {
      writeTabCfgHeader('VOIP User', "100%");
    }
  </script>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="voipUserTable"
    style="table-layout:fixed;word-break:break-all">
    <script language="JavaScript" type="text/javascript">

      if (AllPhyInterface.length > 2) {
        document.write('<tr class="head_title">');
        document.write('<td class="width_per20" >&nbsp;</td>');
        document.write('<td class="width_per20" BindText="vspa_seq"></td>');
        document.write('<td class="width_per30">终端物理终结点标识</td>');
        document.write('<td class="width_per30" BindText="vspa_assopot"></td>');
        document.write('</tr>');
        if (Line.length == 0) {
          document.write('<tr id="record_no"'
            + ' class="trTabContent" onclick="selectLine(this.id);">');
          document.write('<td class="align_center">----</td>');
          document.write('<td class="align_center">----</td>');
          document.write('<td class="align_center">----</td>');
          document.write('<td class="align_center">----</td>');
          document.write('</tr>');
        }
        else {
          for (var i = 0; i < Line.length; i++) {
            var html = '';
            if (i % 2 == 0) {
              html += '<tr id="record_' + i + '" class="tabal_01" '
                + 'onclick="SelectLineRecord(this.id);">';
            }
            else {
              html += '<tr id="record_' + i + '" class="tabal_02" '
                + 'onclick="SelectLineRecord(this.id);">';
            }
            html += '<td class="align_center">' + '<input name="rml" id="rml" type="checkbox" value="'

              + htmlencode(Line[i].Domain) + '";></td>';

            html += '<td class="align_left">' + (i + 1) + '</td>';
            if (Line[i].LineName == "") {
              html += '<td class="align_center">' + '--' + '&nbsp;</td>';
            }
            else {
              html += '<td class="align_left" style="word-wrap:break-word; overflow:hidden;">' + htmlencode(Line[i].LineName) + '&nbsp;</td>';
            }
            html += '<td class="align_left" style="word-wrap:break-word; overflow:hidden;">' + htmlencode(Line[i].PhyReferenceList) + '&nbsp;</td>';
            html += '</tr>';

            document.write(html);
          }
        }
      }

    </script>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="5px"></td>
    </tr>
  </table>
  <div id="ConfigForm1">
    <table width="100%" border="0" cellpadding="0" cellspacing="1">
      <tr>
        <td class="table_title align_left width_per25">启用：</td>
        <td class="table_right align_left width_per75" colspan="2">
          <input name="FXSPortEnable_checkbox" id="FXSPortEnable_checkbox" type='checkbox' size="18"
            checked="checked" />
        </td>
      </tr>
      <tr>
        <td class="table_title align_left width_per25">终端物理终结点标识：</td>
        <td class="table_right align_left width_per75" colspan="2">
          <input name="LineName" id="LineName" type="text" maxlength="256" style="width: 155px" />
        </td>
      </tr>

      <script language="JavaScript" type="text/javascript">
        if (AllPhyInterface.length > 2) {
          document.write('<tr>');
          document.write('<td class="table_title align_left width_per25" BindText="vspa_assopot1"></td>');
          document.write('<td class="table_right align_left width_per75" colspan="2">');
          document.write('<select name="PhyReferenceList" id="PhyReferenceList" class="wid_40px">');
          var k;
          document.write('<option value="" id="null">' + '' + '<\/option>');
          for (k = 1; k < AllPhyInterface.length; k++) {
            document.write('<option value="' + k + '">' + k + '</option>');
          }
          document.write('</select>');
          document.write(' </td>');
          document.write('</tr>');
        }

      </script>
      <tr>
        <td class="height_9p"></td>
      </tr>
    </table>
  </div>
  <table width="100%" border="0" cellpadding="0" cellspacing="1">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="">
          <tr>
            <td class="width_per25 "></td>

            <td class="" align="right">
              <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply"
                onClick="SubmitBasicPara();" />
              <script type="text/javascript">
                document.getElementsByName('SaveApply_button')[0].value = h248interface['e8cvspa_apply'];
              </script>
              <input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel"
                onClick="CancelUserConfig();" />
              <script>
                document.getElementsByName('Cancel_button')[0].value = h248interface['vspa_cancel'];
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