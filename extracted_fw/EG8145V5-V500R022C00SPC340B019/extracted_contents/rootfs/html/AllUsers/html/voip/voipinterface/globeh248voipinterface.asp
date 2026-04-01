<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248interface);%>"></script>
  <!--
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.js);%>"></script>
-->
  <title>VOIP Interface</title>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
  <script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
  <script language="javascript" src="../common/voip_disableallelement.asp"></script>

  <script language="JavaScript" type="text/javascript">
    var selctIndex = -1;
    var CfgMode = '<%HW_WEB_GetCfgMode();%>';
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

    var WanPPPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId,stWanInfo);%>;

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

    function MakeWanName(wan) {
      var wanInst = 0;
      var wanServiceList = '';
      var wanMode = '';
      var vlanId = 0;
      var currentWanName = '';

      if ('&nbsp;' != wan) {
        wanInst = wan.MacId;
        wanServiceList = wan.ServiceList;
        wanMode = (wan.CntType == 'IP_Bridged') ? "B" : "R";
        vlanId = wan.vlanid;

        if (1 == MngtShct || CUVoiceFeature == "1") {
          switch (wanServiceList) {
            case "VOIP":
              wanServiceList = "VOICE";
              break;
            case "TR069_VOIP":
              wanServiceList = "TR069_VOICE";
              break;
            case "VOIP_INTERNET":
              wanServiceList = "VOICE_INTERNET";
              break;
            case "TR069_VOIP_INTERNET":
              wanServiceList = "TR069_VOICE_INTERNET";
              break;
            case "VOIP_IPTV":
              wanServiceList = "VOICE_IPTV";
              break;
            case "TR069_VOIP_IPTV":
              wanServiceList = "TR069_VOICE_IPTV";
              break;
            default:
              break;
          }
        }

        if (0 != parseInt(vlanId)) {
          currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
        }
        else {
          currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }

        return currentWanName;
      }
      else {
        return '&nbsp;';
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
      var all = document.getElementsByTagName("td");
      for (var i = 0; i < all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
          continue;
        }
        b.innerHTML = h248interface[b.getAttribute("BindText")];
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

      var LocalPort = document.getElementById('LocalPort');



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


      Form.addParameter('y.LocalPort', parseInt(getValue('LocalPort'), 10));

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
          + '&Add_a=' + 'InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line'
          + '&b=' + 'InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.' + FreeLine + '.X_HW_H248'
          + '&RequestFile=html/voip/voipinterface/globevoipinterface.asp');

      }
      else if (selctIndex == -2) {
        Form.setAction('set.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&RequestFile=html/voip/voipinterface/globevoipinterface.asp');
      }
      else {
        Form.setAction('set.cgi?x=' + Profile[0].Domain
          + '&y=' + Profile[0].Domain + '.X_HW_H248'
          + '&Add_a=' + Line[selctIndex].Domain
          + '&b=' + Line[selctIndex].Domain + '.X_HW_H248'
          + '&RequestFile=html/voip/voipinterface/globevoipinterface.asp');
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
        SubmitForm.setAction('del.cgi?RequestFile=html/voip/voipinterface/globevoipinterface.asp');
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

      for (i = 0; i < ArrayOption.length; i++) {
        var Option = document.createElement("Option");
        Option.value = domainTowanname(WanInfo[i].domain);
        Option.innerText = MakeWanName(WanInfo[i]);
        Option.text = MakeWanName(WanInfo[i]);
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
      <li id="LocalPort" RealType="TextBox" DescRef="vspa_loport" RemarkRef="vspa_localportbound" ErrorMsgRef="Empty"
        Require="TRUE" BindField="LocalPort" InitValue="Empty" MaxLength="11" />
      <script>
        var VoipConfigFormList1 = HWGetLiIdListByForm("voipbasic", null);
        HWParsePageControlByID("voipbasic", TableClass, h248interface, null);
        var VoipBasicParaSetArray = new Array();
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