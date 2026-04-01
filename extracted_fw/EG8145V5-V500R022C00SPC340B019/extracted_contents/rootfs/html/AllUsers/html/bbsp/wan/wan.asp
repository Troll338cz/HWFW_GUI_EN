<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="Page" xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css" />
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(wan.css);%>" type="text/css" />
  <script src="../../../resource/common/jquery.min.js" type="text/javascript"></script>
  <script language="JavaScript" src="../../../resource/common/util.js"></script>
  <script language="JavaScript" src="../../../resource/common/common.js"></script>
  <script language="JavaScript" src="../../../resource/common/InitForm.asp"></script>
  <script language="JavaScript"
    src="../../../resource/<%HW_WEB_Resource(bbspdes.html, Languages, htmlpage_language, dst_ip_forwarding_cfg_ctc_language, guideinternet_language);%>"></script>
  <title>WAN Configuration</title>
    <style>
        .acctablehead {
            font-size: 16px;
       	    color: #666666;
       	    font-weight: bold;
            text-align: center;
       	    margin-top: 3px;
   	    }
    </style>
</head>

<script>
  var para = '';
  var CfgGuide = -1;
  if (window.location.href.indexOf("cfgguide") != -1) {
    para = window.location.href.split("cfgguide")[1];
    CfgGuide = para.split("=")[1];
  }
  var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
  var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
  var IsSupportpon2lan = '<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
  var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
  var DscpFeature = "<%HW_WEB_GetFeatureSupport(FT_DSCP_TO_8021P_TEMPLATE);%>";
  var ProductType = '<%HW_WEB_GetProductType();%>';
  var stbport = '<%HW_WEB_GetSTBPort();%>';
  var SymmetricNat = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SYMMETRIC_NAT);%>';
  var IfVisual = "<%HW_WEB_IfVisualOltUser();%>";
  var isSupportVLAN0 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_VLAN0_TAG);%>';
  var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
  var IsSAFARICOMFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SAFARICOM);%>';
  var IsDNSLockEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DNS.DNSLockEnable);%>'
  var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';
  var IsIPV6LANDEV = '<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6_LANDEV);%>';
  var DAUMFEATURE = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_DAUM);%>';
  var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
  var WPS20AuthSupported = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WIFIInfo.X_HW_HighBandSupported.HighBandEnable);%>';
  var IsTRUEFlag = '<%HW_WEB_GetFeatureSupport(FT_TAILAND_TRUE);%>';
  var IPV4V6Flag = '<%HW_WEB_GetFeatureSupport(FT_INTERNET_WAN_DEFAULT_DUALSTACK);%>';
  var WANMODEChange = '<%HW_WEB_GetFeatureSupport(FT_WANMODE_TRANSLATE);%>';
  var isWanForConfig = '<%HW_WEB_GetFeatureSupport(FT_WANAUTH_TRUE_USER);%>';
  var TedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
  var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
  var isSupportQue = '<%HW_WEB_GetFeatureSupport(FT_LTE_TYPE01);%>';
  var sysUserType = '0';
  var curUserType = '<%HW_WEB_GetUserType();%>';
  var oteFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>';
  var htFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>';
  var isIPV6DemandWan = '<%HW_WEB_GetFeatureSupport(FT_BBSP_IPV6_DEMAND_WAN);%>';
  var dbaa1Mode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.CurProfile.BondingProfile);%>';
  var exchangeWan = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_EXCHANGE_NAME_WAN);%>';
  var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
  var isPerfixderived = "<%HW_WEB_GetFeatureSupport(FT_PERFIXDERIVED_SUPPORT);%>";
  var isSupportOnulanCfg = "<%HW_WEB_GetFeatureSupport(FT_WEB_ONU_LAN_CFG);%>";
  var showWanName = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_WANNAME);%>';
  var supportOnuBind = "<%HW_WEB_GetFeatureSupport(FT_ONU_VLAN_WAN_CFG);%>";
  var isSuportPolnetia = '<%HW_WEB_GetFeatureSupport(FT_WEB_POLNETIA);%>';
  var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
  var isUnicomNetworkExpress = "<%HW_WEB_GetFeatureSupport(FT_UNICOM_NETWORK_EXPRESS);%>";
  var isSupportAboard = '<%HW_WEB_GetFeatureSupport(FT_ABOARD_FTTO);%>';
  var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';
  var isDualWanUpCfg = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DUALWAN_UPSTREAM);%>';
  var isDualWanUpProduct = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_DUALWAN_UPSTREAM);%>';
  var scnFT = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SCN_ROAM);%>';
  var scnEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.Enable);%>';
  var scnInst5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.ScnInst5G);%>';

var DefaultMTUSize = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.DefaultWANMTUSize,DB);%>';
var ponOnuBind = '<%HW_WEB_GetFeatureSupport(FT_FTTR_PON_ONU_BIND_CTRL);%>';
var isForceModifyPwd = window.parent.isForceModifyPwd;
var tempUserType = curUserType;
var isARCLARO = (curCfgModeWord === 'ARCLARO');
var meshMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_Mesh.MeshMode);%>';  

function isAisBackhaul()
{
	if (((meshMode == 1) || (meshMode == 2)) && (CfgModeWord.toUpperCase() == 'AISAP')) {
		return true;
	}
	return false;
}

function GetLanguage(Name) {
    return Languages[Name];
}

function AlertMsg(Name) {
    AlertEx(GetLanguage(Name));
}

function stLayer3Enable(domain, lay3enable) {
  this.domain = domain;
  this.L3Enable = lay3enable;
}

var LanModeList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 

function IsL3Mode(LanId) {
  if (parseInt(LanId) >= LanModeList.length) {
    return "null";
  }
  return LanModeList[parseInt(LanId)-1].L3Enable;
}

var ttNet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';
  function IsAdminUser() {
    if (DBAA1 == "1") {
      return curUserType == '2';
    }

    if ((DAUMFEATURE == 1) || (curCfgModeWord.toUpperCase() == 'DGRWIND') || (CfgModeWord.toUpperCase() == "DNOVA2WIFI")) {
      curUserType = sysUserType;
    }

    if (((curCfgModeWord.toUpperCase() == 'CNT') || (curCfgModeWord.toUpperCase() == 'CNT2')) && (curUserType == 2)) {
      return true;
    }

    return (curUserType == sysUserType);
  }

  function getLowerLayers() {
    var lowerLayersStr = "radio0";
    if (isSupportLte == "1") {
      lowerLayersStr = (isSupportQue == "1") ? "wwan0" : "lte";
    }
    return lowerLayersStr;
  }

  function SupportTtnet() {
    return (curCfgModeWord.toUpperCase() == "DTTNET2WIFI" || curCfgModeWord.toUpperCase() == "TTNET2");
  }

  function doKey(e) {
    var ev = e || window.event;
    var obj = ev.target || ev.srcElement;
    var t = obj.type || obj.getAttribute('type');

    if (ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea") {
      return false;
    }
  }

  document.onkeypress = doKey;

  document.onkeydown = doKey;

  var stopWanStateTimer = function() {
    if (window.parent.stopWanStateTimer) {
      window.parent.stopWanStateTimer();
    }
  }

  function NeedClearWanIPv4Info(Wan) {
    if ("1" == Wan.IPv4Enable && Wan.Mode == 'IP_Routed' && Wan.IPv4AddressMode == 'Static')
      return false;
    else
      return true;
  }

  function Chickexit() {
    window.top.location = "/index.asp";
  }

  function NeedClearWanIPv4DNSInfo(Wan) {
    if ("1" == Wan.IPv4Enable && Wan.Mode == 'IP_Routed') {
      if (Wan.IPv4AddressMode == 'Static') {
        return false;
      }
      else if (Wan.IPv4DNSOverrideSwitch != "0") {
        return false;
      }
      else {
        return true;
      }
    }
    else {
      return true;
    }
  }

  function NeedClearWanIPv6AddressInfo(Wan) {
    if ("1" == Wan.IPv6Enable && Wan.Mode == 'IP_Routed' && Wan.IPv6AddressMode == "Static")
      return false;
    else if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None"))
      return false;
    else
      return true;
  }

  function NeedClearWanIPv6PrefixInfo(Wan) {
    if ("1" == Wan.IPv6Enable && Wan.Mode == 'IP_Routed' && Wan.IPv6PrefixMode == "Static")
      return false;
    else if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None"))
      return false;
    else
      return true;
  }

  function ModifyWanData(Wan) {

    if (true == NeedClearWanIPv4Info(Wan)) {
      Wan.IPv4IPAddress = "";
      Wan.IPv4SubnetMask = "";
      Wan.IPv4Gateway = "";
    }

    if (true == NeedClearWanIPv4DNSInfo(Wan)) {
      Wan.IPv4PrimaryDNS = "";
      Wan.IPv4SecondaryDNS = "";
    }

    if (true == NeedClearWanIPv6AddressInfo(Wan)) {
      Wan.IPv6IPAddress = "";
      Wan.IPv6PrimaryDNS = "";
      Wan.IPv6SecondaryDNS = "";
      Wan.IPv6AddrMaskLenE8c = "";
      Wan.IPv6GatewayE8c = "";
    }

    if (true == NeedClearWanIPv6PrefixInfo(Wan)) {
      Wan.IPv6StaticPrefix = "";
    }
  }

  function IsGRE(item) {
    var AtmGreWan = "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.4.WANPPPConnection.1";
    var GeGreWan = "InternetGatewayDevice.WANDevice.3.WANConnectionDevice.1.WANPPPConnection.2";
    var PtmGreWan = "InternetGatewayDevice.WANDevice.2.WANConnectionDevice.1.WANPPPConnection.2";
    if (item.domain == AtmGreWan || item.domain == GeGreWan || item.domain == PtmGreWan) {
      return true;
    }
    return false;
  }

  function CapwapDisable() {
    var wanInfo = GetWanList();
    for (var i = 0; i < wanInfo.length; i++) {
      var currentWan = wanInfo[i];
      if (currentWan.ServiceList.toString().toUpperCase() == 'CAPWAP') {
        setDisable("wanInstTable_rml" + i, 1);
      }

      if ((isDualWanUpCfg === '1') && (isDualWanUpProduct === '1')) {
        if (currentWan.RealName === 'GEBackupWan') {
          setDisable("wanInstTable_rml" + i, 1);
        }
      }
    }
  }

  function IsARCLARONewDelButtonGrey()
  {
    if (!isARCLARO) {
        return;
    } 
    setDisable('Newbutton', 1);
    setDisable('DeleteButton', 1);
  }

  function newClickAdd(flag)       
  {  
    if(isARCLARO){
       return;
    }
    clickAdd(flag);
  }

  function newOnDeleteButtonClick(flag)
  {
    if(isARCLARO){
       return;
    }
    OnDeleteButtonClick(flag);  
  }

  function newWanInstTableselectRemoveCnt(flag)
  {
    wanInstTableselectRemoveCnt(flag);
    setText('Newbutton', Languages['Connection']);
  }

  function newSelectLine(flag) 
  {
      selectLine(flag);
      setDisable('DeleteButton', 1);                
  }

  function replaceNewConnectionButton()
  { 
    if (!isARCLARO) {
      return;
    }
    var wanInfo = GetWanList();
    for (var i = 0; i < wanInfo.length; i++) {
      var id = "wanInstTable_rml" + i;
      var id1 = "wanInstTable_record_" + i;
      $("#"+id).attr("onclick","newWanInstTableselectRemoveCnt(this);");
      $("#"+id1).attr("onclick","newSelectLine(this.id);");
    }
    $("#Newbutton").attr("onclick","newClickAdd('wanInstTable_head');");
    $("#DeleteButton").attr("onclick","newOnDeleteButtonClick('wanInstTable_head');");
  } 

  function LoadFrame() {
    if ((curCfgModeWord.toUpperCase() == 'DVODACOM2WIFI') &&
      (IsAdminUser() == false)) {
      setDisplay("wanInstTable_record_0", 0)
      setDisplay("wanInstTable_record_2", 0)
      setDisplay("wanInstTable_record_3", 0)
    }

    IsARCLARONewDelButtonGrey();

    if (IsTedata == 1) {
      var wanInfo = GetWanList();
      for (var i = 0; i < wanInfo.length; i++) {
        var currentWan = wanInfo[i];
        if (IsGRE(currentWan) == true) {
          setDisable("wanInstTable_rml" + i, 1);
        }
      }
    }

    if ((CfgModeWord.toUpperCase() == "ROSUNION") && (curUserType != 0)) {
      var wanInfo = GetWanList();
      for (var i = 0; i < wanInfo.length; i++) {
        var currentWan = wanInfo[i];
        if ((currentWan.ServiceList.indexOf("VOIP") >= 0) || (currentWan.ServiceList.indexOf("TR069") >= 'TR069')) {
          setDisable("wanInstTable_rml" + i, 1);
        }
      }
    }

    if (IsPTVDFFlag == "1") {
      document.getElementById("IPV6sourcemode1").checked = true;
      setDisable("IPv6PrimaryDNSServer", 1);
      setDisable("IPv6SecondaryDNSServer", 1);
      if (getRadioVal("IPV6sourcemode") == "1") {
        setDisplay("IPv6PrimaryDNSServer", 1);
        setDisplay("IPv6SecondaryDNSServer", 1);
      }
    }
    if (1 == CfgGuide) {
      if (1 == smartlanfeature || (3 == CurrentUpMode && 1 == IsSupportpon2lan)) {
        setDisplay("firstpage", 1);
        setDisplay("guideontauth", 0);
      }
      setDisplay("PromptPanel", 0);
      setDisplay("PromptPane2", 1);
      setDisplay("btnguidewan", 1);
      if (isDnzvdf == 1) {
        setDisplay("guideskip", 0);
        setDisplay("guideontauth", 0);
        $("#guidewlanconfig").css("margin-right", "135px");
      }
      $("#ConfigPanel").css("background-color", "#FFFFFF");
      window.parent.adjustParentHeight();
    }
    else {
      setDisplay("PromptPanel", 1);
      setDisplay("PromptPane2", 0);
      setDisplay("btnguidewan", 0);
      $("#ConfigPanel").css("background-color", "#d8d8d8");
    }

    if ("undefined" != typeof (CusLoadFrame)) {
      CusLoadFrame();
    }

    if ('1' == SymmetricNat) {
      addOption('IPv4NatType', 'symmetric', 3, Languages['Symmetric_TDE']);
    }

    ModifyWanList(ModifyWanData);
    setText("PPPAuthenticationProtocol", "PAP/CHAP");
    setDisable("PPPAuthenticationProtocol", 1);

    if (IfVisual == 1) {
      pageDisable();
      setDisable("Newbutton", 1);
      setDisable("DeleteButton", 1);
    }
    if ((fttrFlag == 1) && (CfgGuide == 1)) {
      window.parent.setDisplay("framepageContent", 1);
    }
    if (curCfgModeWord.toUpperCase() == 'DCORIOLIS2WIFI') {
      document.getElementById("DivIPv4BindLanList5").style.display = "none";
    }
    CapwapDisable();

    if ((CfgModeWord.toUpperCase() == "DNOVA2WIFI") && (tempUserType != sysUserType)) {
      pageDisable();
      setDisplay("Newbutton",0);
      setDisplay("DeleteButton",0);
    }
   replaceNewConnectionButton();
  }


  function __GetISPWanOnlyRead() {
    return ("<%HW_WEB_GetFeatureSupport(BBSP_FT_ISPSSID_DISPALY);%>" == "1") ? true : false;
  }


</script>
<script>
  if (1 == CfgGuide) {
    document.write('<body class="mainbodysmart" onLoad="LoadFrame();" >');
  }
  else {
    document.write('<body class="mainbody" onLoad="LoadFrame();" >');
  }
</script>

<body id="wanbody" onLoad="LoadFrame();">
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="javascript" src="../common/managemode.asp"></script>
  <script language="javascript" src="../common/wanaddressacquire.asp"></script>
  <script language="javascript" src="../common/wandns.asp"></script>
  <script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_list_info.asp);%>"></script>
  <script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_settings.asp);%>"></script>
  <script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_servicelist.js);%>"></script>
  <script language="javascript" src="../../amp/common/<%HW_WEB_CleanCache_Resource(wlan_list.asp);%>"></script>
  <script language="javascript" src="../common/wan_pageparse.asp"></script>
  <script language="javascript" src="../common/wan_control.asp"></script>
  <script language="javascript" src="../common/wan_check.asp"></script>
  <script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/wan/wan.cus);%>"></script>
  <script language="JavaScript" type="text/javascript">
    var Wan = GetWanList();
    var SpecWanCfgParaList = [];
    var TELMEX = false;
    var IsSurportPolicyRoute = "<%HW_WEB_GetFeatureSupport(BBSP_FT_ROUTE_POLICY);%>";
    var DoubleFreqFlag = <%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>;
    var RadioWanFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_RADIO_WAN_LOAD);%>";
    var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
    var MobileBackupWanSwitch = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Mobile_Backup.Enable,DB);%>';
    var RemoteWanFeature = "<%HW_WEB_GetFeatureSupport(FT_REMOTE_LOCAL_WAN);%>";
    var TDE2ModeFlag = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
    var MultiWanIpFeature = '<%HW_WEB_GetFeatureSupport(FT_WAN_MULTI_IP);%>';
    var UpportDetectFlag = '<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
    var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
    var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';

    var iponlyflg = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
    var TDESME2Modeflg = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDESME2);%>';
    var guideIndex = '<%HW_WEB_GetGuideChl();%>';
    guideIndex = guideIndex - 48;
    var pppoeUserNameAllFlag = true;
    var typeWordCom = '<%HW_WEB_GetTypeWord();%>';
    var isSupportPCDN = '<%HW_WEB_GetFeatureSupport(FT_PCDN_SUPPORT);%>';
    var maxOnuNum = 32;
    function IsFreInSsidName() {
      if (1 == IsPTVDFFlag) {
        return true;
      }
      return false;
    }

    function checkHon() {
      if ((isSupportPCDN == '1') && (typeWordCom != 'CDN') && (typeWordCom != 'V8XXC')) {
        return true;
      }
      return false;
    }

    function IsSixteenSsidUser() {
      if ('CAMPUSLAN' == CfgModeWord.toUpperCase()) {
        return true;
      }
      return false;
    }

    if ('TDE2' == CfgModeWord.toUpperCase()) {
      Languages['Port_Restricted_Cone_NAT'] = Languages['Port_Restricted_Cone_NAT_TDE'];
      Languages['Full_Cone_NAT'] = Languages['Full_Cone_NAT_TDE'];
    }

    function TopoInfoClass(Domain, EthNum, SSIDNum) {
      this.Domain = Domain;
      this.EthNum = EthNum;
      this.SSIDNum = SSIDNum;
    }

    var phyEthNum = '<%WEB_GetEthNum();%>';
    var SSIDNum = '<%WEB_GetSsidNum();%>';
    var TopoInfo = new TopoInfoClass('InternetGatewayDevice.X_HW_Topo', parseInt(phyEthNum), parseInt(SSIDNum));

    var PonUpportConfig = '<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';

    if (WPS20AuthSupported == 1) {
      TopoInfo.SSIDNum = 12;
    }

    function GetTopoInfo() {
      return TopoInfo;
    }
    function GetTopoItemValue(Name) {
      return TopoInfo[Name];
    }

    function getIsHaveHiddenPort() {
      if (UpUserPortID > 5) {
        return 0;
      }
      else {
        return 1;
      }
    }

    function stDevInfo(domain, HardwareVersion, ModelName) {
      this.domain = domain;
      this.HardwareVersion = HardwareVersion;
      this.ModelName = ModelName;
    }
    var devInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,HardwareVersion|ModelName,stDevInfo);%>;
    var devInfo = devInfos[0];

    if (MobileBackupWanSwitch == '') {
      MobileBackupWanSwitch = 0;
    }

    if (GetCfgMode().TELMEX == "1") {
      TELMEX = true;
    }
    else {
      TELMEX = false;
    }

    var PolicyRouteListAll = Instance_PolicyRoute.GetPolicyRouteList();
    var PolicyRouteList = new Array();
    var i, j = 0;
    for (i = 0; i < PolicyRouteListAll.length; i++) {
      if (PolicyRouteListAll[i] == null) {
        PolicyRouteList[j++] = PolicyRouteListAll[i];
        continue;
      }

      if (PolicyRouteListAll[i].Type.toUpperCase() == "EthernetType".toUpperCase()) {
        PolicyRouteList[j++] = PolicyRouteListAll[i];
        continue;
      }
    }

  </script>
  <div id="PromptPanel" style="display:none;">
    <script language="JavaScript" type="text/javascript">
      if (false == TELMEX) {
        if ((RadioWanFeature == "1") && (IsAdminUser() == false) && (MobileBackupWanSwitch == 0)) {
          if ((CfgModeWord.toUpperCase() == "DTURKCELL2WIFI") || (CfgModeWord.toUpperCase() == 'TURKCELL2')) {
            HWCreatePageHeadInfo("wan", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription"), false);
          }
          else {
            HWCreatePageHeadInfo("wan", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription2"), false);
          }
        }
        else {
          var nohometitle = '<%HW_WEB_GetFeatureSupport(FT_WEB_NOHOME_TITLE);%>';
          if (nohometitle == '1') {

            HWCreatePageHeadInfo("wan", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription_nohome"), false);
          } else {
            HWCreatePageHeadInfo("wan", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription"), false);
          }
        }
      }
      else {
        HWCreatePageHeadInfo("wan", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription_telmex"), false);
      }
    </script>
  </div>
  <div id="PromptPane2" style="display:none;">

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <TR>
        <TD align="middle" height="10px"></TD>
      </TR>
    </table>
  </div>
  <div class="title_spread">
    <script>
            if((CfgModeWord.toUpperCase() == "DNZVDF2WIFI") && (CfgGuide == 1)) {
                    document.write('<div class="acctablehead">' + Languages['bbsp_title_dnzvdf'] + '</div>');
            }
    </script>
  </div>

  <script>
    ShowWanListTable();
    if((CfgModeWord.toUpperCase() == "DNZVDF2WIFI") && (CfgGuide == 1)) {
        $("#wanInstTable_tbl").css('margin-top','15px');
    }
  </script>

  <script>
    function IsSupportDualsStack() {
      var Custom_cmcc = '<%HW_WEB_GetFeatureSupport(FT_WAN_DEFAULT_DUALSTACK);%>';
      if ('1' == Custom_cmcc) {
        return true;
      }
      else {
        return false;
      }
    }
    function DeleteLineRow() {
      var tableRow = getElementById("wanInstTable");
      if (tableRow.rows.length > 2)
        tableRow.deleteRow(tableRow.rows.length - 1);
      return false;
    }

    function HideRTKProxy(CurrentWan) {
      if (CfgModeWord.toUpperCase() == "ROSUNION") {
        if (CurrentWan.ServiceList.indexOf("INTERNET") < 0) {
          setDisplay("RTKIGMPProxySwitchRow", 0);
        } else {
          setDisplay("RTKIGMPProxySwitchRow", 1);
        }
      }
    }

    var gWanMode = 'IP_Routed';
    var selctIndex2 = 0;
    var temwaninfo = "";
    function setOverrideAllowed(domain) {
      var DnsServer = GetIPv6WanDnsServerInfo(domainTowanname(domain));
      if (DnsServer != null) {
        if (DnsServer.X_HW_OverrideAllowed != undefined) {

          if (1 == DnsServer.X_HW_OverrideAllowed) {
            setCheck("IPV6sourcemode2", 1);
          }
          else {
            setCheck("IPV6sourcemode1", 1);
          }

          setCheck("IPV6OverrideAllowed", DnsServer.X_HW_OverrideAllowed);
          setDisplay("IPv6PrimaryDNSServerRow", DnsServer.X_HW_OverrideAllowed);
          setDisplay("IPv6SecondaryDNSServerRow", DnsServer.X_HW_OverrideAllowed);
        }
      }
    }
    var anteltype = '<%HW_WEB_GetFeatureSupport(FT_NORMAL_USER_NOGUIGE);%>';

    var lteBandResult = '';
    function getLteBandInfo() {
      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        url: "lteBandInfo.asp",
        success: function (data) {
          lteBandResult = dealDataWithFun(data);
        }
      });
    }

    function getLTEBandStrToArr(lteBandStr) {
      var lteBandArr = lteBandStr.split("B");
      lteBandArr.shift();
      for (var i = 0; i < lteBandArr.length; i++) {
        lteBandArr[i] = "B" + lteBandArr[i];
      }
      return lteBandArr;
    }

    function clearLTEBand(lteBandList) {
      for (var i = 0; i < lteBandList.length; i++) {
        lteBandList[i].checked = false;
      }
    }

    var lteBandIsDisplay = false;

    function displayLteBand(flag) {
      if (IsCurrentRadioWan() == true) {
        if (lteBandIsDisplay) {
          return;
        }

        var lteBandList = document.getElementsByName("lteband");
        if (flag == "EDIT") {
          if (lteBandResult[0] == null) {
            getLteBandInfo();
          }
          if (lteBandResult[0] != null) {
            clearLTEBand(lteBandList);
            var lteBandArr = getLTEBandStrToArr(lteBandResult[0].LTEBandSet);
            for (var m = 0; m < lteBandArr.length; m++) {
              for (var i = 0; i < lteBandList.length; i++) {
                if (lteBandArr[m] == lteBandList[i].value) {
                  lteBandList[i].checked = true;
                }
              }
            }
          } else if (flag == "ADD") {
            for (var j = 0; j < lteBandList.length; j++) {
              lteBandList[j].checked = true;
            }
          }

          lteBandIsDisplay = true;
        }
      }
    }

    function GetOperateValue(domain) {
      for (var i = 0; i < IPWanList.length - 1; i++) {
        if (domain == IPWanList[i].domain) {
          return IPWanList[i].X_HW_OperateDisable;
        }
      }

      for (var i = 0; i < PPPWanList.length - 1; i++) {
        if (domain == PPPWanList[i].domain) {
          return PPPWanList[i].X_HW_OperateDisable;
        }
      }
      return 0;
    }

    function DisableCapwapWan() {
      setDisable('WanSwitch', 1);
      setDisable('WanMode', 1);
      setDisable('VlanSwitch', 1);
      setDisable('VlanId', 1);
      setDisable('PriorityPolicy', 1);
      setDisable('VlanPriority', 1);
      setDisable('IPv4MXU', 1);
      setDisable('IPv4AddressMode1', 1);
      setDisable('IPv4AddressMode2', 1);
      setDisable('IPv4AddressMode3', 1);
      setDisable('IPv4NatSwitch', 1);
      setDisable('IPv4VendorId', 1);
      setDisable('IPv4ClientId', 1);
      setDisable('IPv4DNSOverrideSwitch', 1);
      setDisable('IPv4WanMVlanId', 1);
      setDisable('ButtonApply', 1);
      setDisable('ButtonCancel', 1);
    }

    function setControl(Index) {
      var wanmax = GetWanMax();
      selctIndex = Index;
      selctIndex2 = (-1 == Index) ? selctIndex2 : Index;
      var bAdd = true;
      var isF5g = false;

      if (isSupportLte == "1") {
        lteBandIsDisplay = false;
      }

      setDisable("EnableForm", "0");
      setDisable("ButtonApply", "0");
      setDisable("ButtonCancel", "0");
      setDisplay('divTableConfigForm', 1);
      setDisplay('ConfigPanelButtons', 1);
      if (-1 == Index) {
        if (GetWanListLength() >= wanmax) {
          DeleteLineRow();
          AlertMsg("WanIsFull");
          return false;
        }

        var CurrentWan = new WanInfoInst();
        temwaninfo = CurrentWan;
        var IPProtVer = Instance_IPVersion.GetIPProtVerMode();
        if (IsSupportDualsStack()) {
          CurrentWan.ProtocolType = "IPv4/IPv6";
          CurrentWan.IPv4Enable = "1";
          CurrentWan.IPv6Enable = "1";
        } else if (2 == IPProtVer) {
          CurrentWan.ProtocolType = "IPv6";
          CurrentWan.IPv4Enable = "0";
          CurrentWan.IPv6Enable = "1";
        }

        if ((IPV4V6Flag == 1) && (CurrentWan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (CurrentWan.Mode.toUpperCase().indexOf("ROUTE") >= 0)) {
          CurrentWan.ProtocolType = "IPv4/IPv6";
          CurrentWan.IPv4Enable = "1";
          CurrentWan.IPv6Enable = "1";
        }

        if (GetRunningMode() == "1") {
          CurrentWan.VlanId = "1";
          CurrentWan.UserName = "";
          CurrentWan.Password = "";
        }

        if (true == Option60DisplayFlag(CurrentWan)) {
          CurrentWan.EnableOption60 = "0";
          CurrentWan.X_HW_IPoEName = "";
          CurrentWan.X_HW_IPoEPassword = "";
        }

        if (IsDstIPForwardingListVisibility(CurrentWan, CurrentWan.ServiceList) == true) {
          CurrentWan.IPForwardModeEnabled = "0";
          CurrentWan.DstIPForwardingList = "";
        }

        EditFlag = "ADD";
        ChangeUISource = null;
        gWanMode = CurrentWan.Mode;

        var AddWanCnt = btnAddWanCnt();

        if (true == AddWanCnt) {
          var wanInfoTmp = null;
          wanInfoTmp = GetWanInfoSelected();

          CurrentWan.EnableVlan = wanInfoTmp.EnableVlan;
          CurrentWan.VlanId = wanInfoTmp.VlanId;
          CurrentWan.PriorityPolicy = wanInfoTmp.PriorityPolicy;
          CurrentWan.Priority = wanInfoTmp.Priority;
          CurrentWan.DefaultPriority = wanInfoTmp.DefaultPriority;
        }
        else if (false == AddWanCnt) {
          EditFlag = "EDIT";
          ChangeUISource = null;
          return false;
        }

        BindPageData(CurrentWan);
        ControlPage(CurrentWan);
        DisplayDNSServer(CurrentWan);
        HideRTKProxy(CurrentWan);
        displaysvrlist();
        DisplayConfigPanel(1);
      }
      else {
        UpdateV6AddrInfo();
        var Feature = GetFeatureInfo();
        if (Feature.IPProtChk == 1) {
          var protoType = getElementById('ProtocolType');
          protoType.options.length = 0;
          protoType.options.add(new Option(Languages['IPv4'], 'IPv4'));
          protoType.options.add(new Option(Languages['IPv6'], 'IPv6'));
          protoType.options.add(new Option(Languages['IPv4IPv6'], 'IPv4/IPv6'));
        }

        var UserList = new Array();
        for (var i = 0; i < GetWanList().length; i++) {
          if (false == filterWanByFeature(GetWanList()[i])) {
            continue;
          }
          if ((GetCfgMode().PTVDF == "1") && (RadioWanFeature == "1") && (IsAdminUser() == false) && (MobileBackupWanSwitch == 1)) {
            if (GetWanList()[i].RealName.indexOf("RADIO") < 0) {
              continue;
            }
          }


          if (IsXdProduct() && ('TALKTALK2WIFI' == CfgModeWord.toUpperCase())) {
            var WanTypeDevice = getWanType();

            if (WanTypeDevice != GetWanList()[i].domain.split('.')[2]) {
              continue;
            }

          }

          UserList.push(GetWanList()[i]);
        }
        var CurrentWan = UserList[Index];
        if ((isDualWanUpCfg === '1') && (isDualWanUpProduct === '1')) {
          if (CurrentWan.RealName === 'GEBackupWan') {
            setDisplay('divTableConfigForm', 0);
            setDisplay('ConfigPanelButtons', 0);
            return;
          }
        }
        temwaninfo = CurrentWan;
        gWanMode = CurrentWan.Mode;
        EditFlag = "EDIT";
        BindPageData(CurrentWan);
        ControlPage(CurrentWan);
        DisplayDNSServer(CurrentWan);
        HideRTKProxy(CurrentWan);
        bAdd = false;
        DisplayConfigPanel(1);
        var Wan = GetPageData();
        var FeatureInfo = GetFeatureInfo();

        if (GetOperateValue(CurrentWan.domain) == 1) {
          isF5g = true;
        }

        if (1 == IsTedata) {
          Wan.UserName = ParseUsernameFortedata(CurrentWan.UserName);
          var isTedataGRE = IsGRE(CurrentWan);
          setDisable("EnableForm", isTedataGRE);
          setDisable("ButtonApply", isTedataGRE);
          setDisable("ButtonCancel", isTedataGRE);
        }
        if (isTedataGRE == false && CheckWan(Wan) == false) {
          return false;
        }

        if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable) {
          setOverrideAllowed(CurrentWan.domain);
        }

        if (SupportTtnet()) {
          changeDTTNETpage(CurrentWan, EditFlag);
        }
      }

      displayProtocolType();
      displayWanMode();

      if ("IRAQO3" == CfgModeWord.toUpperCase()) {
        if (false == IsAdminUser()) {
          setText("UserName", ParseUsernameForIraq(CurrentWan.UserName));
          document.getElementById("UserNameRequire").innerHTML = "@o3-telecom.com";
          document.getElementById("UserNameRequire").color = "grey";

        }
      }
      if (1 == IsTedata) {
        setText("UserName", ParseUsernameFortedata(CurrentWan.UserName));
      }
      if (IfVisual == 1) {
        pageDisable();
        setDisable("ButtonApply", 1);
        setDisable("ButtonCancel", 1);
      }

      if (1 == IsPTVDFFlag) {
        IPV6DNSChangeMode();
        if (IsDNSLockEnable == "1") {
          setDisable("primarydns", 1);
          setDisable("secondarydns", 1);
          setDisable("sourcemode1", 1);
          setDisable("sourcemode2", 1);

          setDisable("IPv6PrimaryDNSServer", 1);
          setDisable("IPv6SecondaryDNSServer", 1);
          setDisable("IPV6sourcemode1", 1);
          setDisable("IPV6sourcemode2", 1);
        }

      }
      if ((IsAdminUser() == false) && (anteltype == 1)) {
        setDisable("ButtonApply", "1");
        setDisable("ButtonCancel", "1");
        setDisable("WanMode", "1");
      }

      if (isF5g) {
        DisableUserMode(1);
        setDisable("UserName", "1");
        setDisable("PasswordCol", "1");
        setDisable("Password", "1");
        setDisable("ButtonApply", "1");
        setDisable("ButtonCancel", "1");
        setDisable("Option60Enable", "1");
        setDisable("DeleteButton", "1");
      } else {
        setDisable("DeleteButton", "0");
      }

      if (temwaninfo.ServiceList.toString().toUpperCase() == 'CAPWAP') {
        DisableCapwapWan();
      }

      if ((CfgModeWord.toUpperCase() == "DNOVA2WIFI") && (tempUserType != sysUserType)) {
        pageDisable();
      }

      if ((curCfgModeWord.toUpperCase() == "TT2") && (curUserType != sysUserType)) {
        pageDisable();
      }
    }

    function changeDTTNETpage(currentWan, EditFlag) {

      if (!SupportTtnet()) {
        return;
      }

      if ((currentWan.Mode == "IP_Bridged") || (currentWan.Mode == "PPPoE_Bridged")) {
        setDisplay("UserNameRow", 0);
        setDisplay("UserNameRemark", 0);
        setDisplay("UserNameCkick_span_blackRow", 0);
        setDisplay("UserNameTipsAllRow", 0);
        return;
      }

      var postFix = "@ttnet";
      var userNameTmp = currentWan.UserName

      if (currentWan.EncapMode.toUpperCase() == "PPPOE") {
        if ((EditFlag == "ADD") || (userNameTmp == "")) {
          pppoeUserNameAllFlag = false;
          setDisplay("UserNameRow", 1);
          setDisplay("UserNameRemark", 1);
          setDisplay("UserNameCkick_span_blackRow", 1);
          setDisplay("UserNameTipsAllRow", 0);
        } else if ((userNameTmp.indexOf(postFix) > -1) && (userNameTmp.substring(userNameTmp.length - postFix.length) == postFix)) {
          setText("UserName", userNameTmp.substring(0, userNameTmp.length - postFix.length));
          pppoeUserNameAllFlag = false;
          setDisplay("UserNameRow", 1);
          setDisplay("UserNameRemark", 1);
          setDisplay("UserNameCkick_span_blackRow", 1);
          setDisplay("UserNameTipsAllRow", 0);
        } else {
          pppoeUserNameAllFlag = true;
          setDisplay("UserNameRow", 1);
          setDisplay("UserNameRemark", 0);
          setDisplay("UserNameCkick_span_blackRow", 0);
          setDisplay("UserNameTipsAllRow", 1);
          document.getElementById('UserNameTipsAll').innerHTML = "<span>" + Languages['wan_pppoeusernameTips3_ttnet'] + "</span>";
        }

        if (curUserType != sysUserType) {
            setDisplay("IPv4MXURow", 1);
            setDisable("IPv4MXU", 0);
        }
      } else {
        setDisplay("UserNameRow", 0);
        setDisplay("UserNameRemark", 0);
        setDisplay("UserNameCkick_span_blackRow", 0);
        setDisplay("UserNameTipsAllRow", 0);
      }
    }

    function DisplayDNSServer(CurrentWan) {
      if (IsSAFARICOMFlag == "1") {
        if (IsDNSLockEnable == "1") {
          setDisable("IPv4PrimaryDNSServer", 1);
          setDisable("IPv4SecondaryDNSServer", 1);
          setDisable("IPv6PrimaryDNSServer", 1);
          setDisable("IPv6SecondaryDNSServer", 1);
          setDisable("IPV6OverrideAllowed", 1);
          setDisable("IPv4DNSOverrideSwitch", 1);
        }
        setText("IPv4PrimaryDNSServer", CurrentWan.IPv4PrimaryDNS);
        setText("IPv4SecondaryDNSServer", CurrentWan.IPv4SecondaryDNS);
        setText("IPv6PrimaryDNSServer", CurrentWan.IPv6PrimaryDNS);
        setText("IPv6SecondaryDNSServer", CurrentWan.IPv6SecondaryDNS);

      }
      if (IsPTVDFFlag == "0") {
        return;
      }
      if (CurrentWan.ServiceList.toUpperCase().indexOf("INTERNET") < 0) {
        setDisable("sourcemode1", 1);
        setDisable("sourcemode2", 1);
        setDisable("primarydns", 1);
        setDisable("secondarydns", 1);

        setDisable("IPV6sourcemode1", 1);
        setDisable("IPV6sourcemode2", 1);
        setDisable("IPv6PrimaryDNSServer", 1);
        setDisable("IPv6SecondaryDNSServer", 1);
      }
      else {
        setDisable("sourcemode1", 0);
        setDisable("sourcemode2", 0);
        setDisable("primarydns", 0);
        setDisable("secondarydns", 0);

        setDisable("IPV6sourcemode1", 0);
        setDisable("IPV6sourcemode2", 0);
        setDisable("IPv6PrimaryDNSServer", 0);
        setDisable("IPv6SecondaryDNSServer", 0);

        setDisplay("IPV6sourcemode1", 0);
        setDisplay("IPV6sourcemode2", 0);

        if (1 == IsPTVDFFlag) {
          setDisplay("IPV6sourcemode1", 1);
          setDisplay("IPV6sourcemode2", 1);
          IPV6DNSChangeMode();
          if (IsDNSLockEnable == "1") {
            setDisable("primarydns", 1);
            setDisable("secondarydns", 1);
            setDisable("sourcemode1", 1);
            setDisable("sourcemode2", 1);

            setDisable("IPv6PrimaryDNSServer", 1);
            setDisable("IPv6SecondaryDNSServer", 1);
            setDisable("IPV6sourcemode1", 1);
            setDisable("IPV6sourcemode2", 1);
          }
        }
      }
      setRadio("sourcemode", CurrentWan.IPv4DNSOverrideSwitch);
      setText("primarydns", CurrentWan.IPv4PrimaryDNS);
      setText("secondarydns", CurrentWan.IPv4SecondaryDNS);

      setRadio("IPV6sourcemode", CurrentWan.IPv6DNSOverrideSwitch);
      setText("IPv6PrimaryDNSServer", CurrentWan.IPv6PrimaryDNS);
      setText("IPv6SecondaryDNSServer", CurrentWan.IPv6SecondaryDNS);



      DNSChangeMode();
    }
    function DNSChangeMode() {
      if (getRadioVal("sourcemode") == "0") {
        setDisable("primarydns", 1);
        setDisable("secondarydns", 1);
        document.getElementById("primarydns").value = "";
        document.getElementById("secondarydns").value = "";
      }
      else {
        setDisable("primarydns", 0);
        setDisable("secondarydns", 0);
        setText("primarydns", temwaninfo.IPv4PrimaryDNS);
        setText("secondarydns", temwaninfo.IPv4SecondaryDNS);
      }
    }

    function IPV6DNSChangeMode() {
      if (getRadioVal("IPV6sourcemode") == "0") {
        setDisable("IPv6PrimaryDNSServer", 1);
        setDisable("IPv6SecondaryDNSServer", 1);
        document.getElementById("IPv6PrimaryDNSServer").value = "";
        document.getElementById("IPv6SecondaryDNSServer").value = "";
        document.getElementById("IPV6OverrideAllowed").checked = false;
      }
      else {
        setDisable("IPv6PrimaryDNSServer", 0);
        setDisable("IPv6SecondaryDNSServer", 0);
        setText("IPv6PrimaryDNSServer", temwaninfo.IPv6PrimaryDNS);
        setText("IPv6SecondaryDNSServer", temwaninfo.IPv6SecondaryDNS);
        document.getElementById("IPV6OverrideAllowed").checked = true;
      }
      OnChangeOverrideAllowed();
    }

    function DisplayConfigPanel(Flag) {
      setDisplay("ConfigForm", Flag);
      setDisplay("ConfigPanelButtons", Flag);
      if (1 == CfgGuide) {
        window.parent.adjustParentHeight();
      }
      if (IsXdPonUpMode()) {
        setDisplay("AccessTypeRow", 0);
      }
    }

    function DelServiceRoute() {
      if (PolicyRouteList.length - 1 != 0) {
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          data: PolicyRouteList[0].Domain + "=" + "&x.X_HW_Token=" + getValue('onttoken'),
          url : "del.cgi?x=InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route&RequestFile=html/bbsp/wan/wan.asp",
          success: function (data) {

          },
          complete: function (XHR, TS) {
            XHR = null;
          }
        });
      }
    }

    function CreateServiceRoute(SrvRouteWanName) {
      if (PolicyRouteList.length - 1 == 0) {
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          data: "x.PolicyRouteType=EthernetType" + "&x.VenderClassId=" + "&x.WanName=" + SrvRouteWanName + "&x.EtherType=PPPoE" + "&x.X_HW_Token=" + getValue('onttoken'),
          url : "add.cgi?x=InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route&RequestFile=html/html/bbsp/wan/wan.asp",
          success: function (data) {
          },
          complete: function (XHR, TS) {
            XHR = null;
          }
        });
      }
      else {
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          data: "x.PolicyRouteType=EthernetType" + "&x.VenderClassId=" + "&x.WanName=" + SrvRouteWanName + "&x.EtherType=PPPoE" + "&x.X_HW_Token=" + getValue('onttoken'),
          url : "set.cgi?x="+PolicyRouteList[0].Domain+"&RequestFile=html/bbsp/wan/wan.asp",
          success: function (data) {
          },
          complete: function (XHR, TS) {
            XHR = null;
          }
        });
      }
    }

    function CheckOption60(Wan) {
      if (true == Option60DisplayFlag(Wan)) {
        if ("0" == Wan.EnableOption60) {
          return true;
        }

        if (Wan.X_HW_IPoEName == "") {
          AlertEx(getErrorMsg("IPv4UserNamee8c", ERR_MUST_INPUT));
          return false;
        }
        if (Wan.X_HW_IPoEPassword == "") {
          AlertEx(getErrorMsg("IPv4Passworde8c", ERR_MUST_INPUT));
          return false;
        }
      }
      return true;

    }

    function setPppoeWanSrvRoute() {
      var pppoeidx = -1;
      var SrvRouteWanName = '';
      for (var i = 0; i < Wan.length; i++) {
        if ((Wan[i].ServiceList.toUpperCase().indexOf("INTERNET") >= 0) && (Wan[i].EncapMode.toUpperCase() == "PPPOE")) {
          pppoeidx = i;
          break;
        }
      }
      if (-1 != pppoeidx) {
        if (Wan[pppoeidx].Mode.toUpperCase().indexOf("BRIDGE") >= 0) {
          SrvRouteWanName = domainTowanname(Wan[pppoeidx].domain);
          CreateServiceRoute(SrvRouteWanName);
        }
        if (Wan[pppoeidx].Mode == "IP_Routed") {
          DelServiceRoute();
        }
      }
    }


    function OnAddApply() {
      var Wan = GetPageData();
      var FeatureInfo = GetFeatureInfo();

      if (CheckWan(Wan) == false) {
        return false;
      }

      if (CheckForSession(Wan, GetAddType()) == false) {
        return false;
      }

      if (CheckOption60(Wan) == false) {
        return false;
      }

      setDisable("ButtonApply", "1");
      setDisable("ButtonCancel", "1");

      var Parameter = {};
      FillForm(Parameter, Wan);
      Parameter.asynflag = null;
      Parameter.FormLiList = WanConfigFormList;
      Parameter.OldValueList = null;
      Parameter.SpecParaPair = SpecWanCfgParaList;
      var tokenvalue = getValue('onttoken');

      var DnsUrl = (Wan.IPv6AddressMode == "Static") ? "&k=GROUP_a_y.X_HW_IPv6.IPv6DnsServer" : "";
      if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None")) {
        OverrideAllowed = getCheckVal('IPV6OverrideAllowed');
        if (EditFlag == "ADD" && OverrideAllowed == 1) {
          DnsUrl = "&" + COMPLEX_CGI_PREFIX + "k=GROUP_a_y.X_HW_IPv6.IPv6DnsServer"
        }
        else if (EditFlag == "ADD" && OverrideAllowed == 0) {
          DnsUrl = "";
        }
        else {
          DnsUrl = "&k=GROUP_a_y.X_HW_IPv6.IPv6DnsServer";
        }
      }
      var IPv6Path = (Wan.IPv6Enable == "1") ? ('&m=GROUP_a_y.X_HW_IPv6.IPv6Address&n=GROUP_a_y.X_HW_IPv6.IPv6Prefix' + DnsUrl) : '';
      var DSLite = (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") ? ('&j=GROUP_a_y.X_HW_IPv6.DSLite') : '';
      var Path6Rd = (true == Is6RdSupported()) ? ('&r=GROUP_a_y.X_HW_6RDTunnel') : '';
      var unnumberedIpPath = ((SupportUnnumberIp(Wan) == true) && (IsUnnumberedWanExist() == false)) ? ('&g=GROUP_a_y.X_HW_UnnumberedIP') : '';

      var Url = 'addcfg.cgi?' + GetAddWanUrl(Wan) + IPv6Path + DSLite + Path6Rd + unnumberedIpPath + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html';

      if (1 == CfgGuide) {
        Url += '&cfgguide=1';
      }

      stopWanStateTimer();
      HWSetAction(null, Url, Parameter, tokenvalue);
    }

    function addParamForRadioWan(Wan, ProtectInterface) {
      var wanname = "";
      var wanData = 's.Enable=' + Wan.RadioWanPSEnable;
      wanData += '&s.PingIP=' + Wan.PingIPAddress;
      wanData += '&s.ProtectInterface=' + domainTowanname(ProtectInterface);
      if (!IsXdProduct() || (CfgModeWord.toUpperCase() === 'DNZTELECOM2WIFI') || (CfgModeWord.toUpperCase() === 'TTNET2')) {
        wanData += '&s.SwitchMode=' + getRadioVal("SwitchMode");
      }
      wanData += '&s.SwitchDelayTime=' + getValue("SwitchDelayTime");
      wanData += '&s.BackupMode=ordinary';

      wanData += '&t.Username=' + Wan.RadioWanUsername;
      if (Wan.RadioWanPassword != radio_hidepassword) {
        wanData += '&t.Password=' + Wan.RadioWanPassword;
      }
      wanData += '&t.APN=' + getValue("APN");
      wanData += '&t.DialNumber=' + getValue("DialNumber");
      wanData += '&t.Interface=radio0';

      return wanData;
    }

    function addParamForLteWan(Wan, ProtectInterface) {
      var wanData = 't.Username=' + Wan.RadioWanUsername;
      if (Wan.RadioWanPassword != radio_hidepassword) {
        wanData += '&t.Password=' + Wan.RadioWanPassword;
      }
      wanData += '&t.APN=' + getValue("APN");
      wanData += '&t.DialNum=' + getValue("DialNumber");

      if ((EditFlag == "ADD") || (getCheckVal("RadioWanPSEnable") == 0)) {
        wanData += '&t.Reset=0';
      } else {
        var CurrentWan = GetWanList()[selctIndex];
        var lteBand = '';
        var lteBandList = document.getElementsByName("lteband");
        for (var i = 0; i < lteBandList.length; i++) {
          if (lteBandList[i].checked != true) {
            continue;
          }
          lteBand = lteBand + lteBandList[i].value;
        }

        if ((CurrentWan.RadioWanUsername != Wan.RadioWanUsername) ||
          (CurrentWan.RadioWanPassword != Wan.RadioWanPassword) ||
          (CurrentWan.APN != Wan.APN) ||
          ((lteBandResult[0] != null) && (lteBandResult[0].LTEBandSet != lteBand))) {
          wanData += '&t.Reset=1';
        } else {
          wanData += '&t.Reset=0';
        }
      }
      return wanData;
    }

    function GetRadioWanDomainList() {
      var wanListAll = null;
      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: '&x.X_HW_Token=' + getValue('onttoken'),
        url: "../common/getwanlist.asp",
        success: function (data) {
          wanListAll = dealDataWithFun(data);
        }
      });

      if (wanListAll == null) {
        return null;
      }

      var radioWanDomainList = new Array();
      var wanList = wanListAll.WanList;
      var index = 0;
      for (var i = 0; i < wanList.length; i++) {
        if (IsRadioWanSupported(wanList[i]) == true) {
          radioWanDomainList[index] = wanList[i].domain;
          index += 1;
        }
      }

      return radioWanDomainList;
    }

    function IsAddRadioWan(radioWanDomain, wanDomainListBeforeAdd) {
      if (wanDomainListBeforeAdd == null) {
        return true;
      }

      for (var i = 0; i < wanDomainListBeforeAdd.length; i++) {
        if (radioWanDomain == wanDomainListBeforeAdd[i]) {
          return false;
        }
      }

      return true;
    }

    function AddAndGetProtectInterface() {
      var radioWanDomainListBeforeAdd = null;
      if (isSupportLte == "1") {
        radioWanDomainListBeforeAdd = GetRadioWanDomainList();
      }

      var Onttoken = getValue('onttoken');
      var protectinterface = "";
      var urlData;
      var wanname = 'RADIO_INTERNET_R_VID_';
      var srvListType = getSelectVal('ServiceList');
      if (IsPTVDFFlag == 1) {
        wanname = 'Mobile';
      }

      var ParaData = 'GROUP_a_y.Enable=' + getCheckVal("RadioWanPSEnable");
      if (isSupportLte == "1") {
        var ipType = getSelectVal('ProtocolType');

        if (ipType == 'IPv6') {
          ParaData += '&GROUP_a_y.X_HW_IPv4Enable=0&GROUP_a_y.X_HW_IPv6Enable=1';
        } else if (ipType == 'IPv4/IPv6') {
          ParaData += '&GROUP_a_y.X_HW_IPv4Enable=1&GROUP_a_y.X_HW_IPv6Enable=1';
        } else {
          ParaData += '&GROUP_a_y.X_HW_IPv4Enable=1&GROUP_a_y.X_HW_IPv6Enable=0';
        }
      } else {
        ParaData += '&GROUP_a_y.X_HW_IPv4Enable=1&GROUP_a_y.X_HW_IPv6Enable=0';
      }

      if (isSupportLte == "1") {
        ParaData += '&GROUP_a_y.X_HW_IPv6MultiCastVLAN=-1';
        ParaData += '&GROUP_a_y.X_HW_SERVICELIST=' + srvListType;
      } else {
        ParaData += '&GROUP_a_y.X_HW_IPv6MultiCastVLAN=-1&GROUP_a_y.X_HW_SERVICELIST=INTERNET';
      }
      ParaData += '&GROUP_a_y.X_HW_ExServiceList=&GROUP_a_y.X_HW_VLAN=0&GROUP_a_y.X_HW_PRI=0';
      ParaData += '&GROUP_a_y.X_HW_PriPolicy=Specified&GROUP_a_y.X_HW_DefaultPri=0';
      ParaData += '&GROUP_a_y.ConnectionType=IP_Routed&GROUP_a_y.X_HW_MultiCastVLAN=4294967295';
      ParaData += '&GROUP_a_y.NATEnabled=1&GROUP_a_y.X_HW_NatType=0&GROUP_a_y.DNSEnabled=1';
      ParaData += '&GROUP_a_y.MaxMTUSize=1500&GROUP_a_y.AddressingType=Auto';
      ParaData += '&GROUP_a_y.DefaultGateway=&GROUP_a_y.DNSServers=&GROUP_a_y.X_HW_BindPhyPortInfo=';
      ParaData += '&GROUP_a_y.Name=' + wanname;
      ParaData += '&GROUP_a_y.X_HW_LowerLayers=' + getLowerLayers();
      ParaData += '&GROUP_a_y.ConnectionTrigger=' + getRadioVal("TriggerMode");

      if (IsXdProduct() || (isSupportLte == "1")) {
        urlData = 'addcfg.cgi?GROUP_a_x=InternetGatewayDevice.WANDevice.' + Instance_AccessType.GetWanInstByWanAceesstype("UMTS") + '.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANIPConnection'
        + '&RequestFile=html/bbsp/wan/wan.asp';
      }
      else {
        urlData = 'addcfg.cgi?GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANIPConnection'
        + '&RequestFile=html/bbsp/wan/wan.asp';
      }

      if (1 == CfgGuide) {
        urlData += '&cfgguide=1';
      }

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: ParaData + '&x.X_HW_Token=' + Onttoken,
        url: urlData,
      });

      Onttoken = getValue('onttoken');
      var WanListAll = null;
      var RadioWanList = null;
      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: '&x.X_HW_Token=' + Onttoken,
        url: "../common/getwanlist.asp",
        success: function (data) {
          WanListAll = dealDataWithFun(data);
        }
      });

      if (null == WanListAll) {
        return;
      }

      RadioWanList = WanListAll.WanList;

      for (var i = 0; i < RadioWanList.length; i++) {
        if (IsRadioWanSupported(RadioWanList[i]) == true) {
          protectinterface = RadioWanList[i].domain;
          if (isSupportLte != "1") {
            break;
          }

          if (IsAddRadioWan(protectinterface, radioWanDomainListBeforeAdd) == true) {
            break;
          }
        }
      }

      return protectinterface;
    }

    function UpdateProtectInterface(WanDomain, enable, triggermode) {
      var Onttoken = getValue('onttoken');
      var urlData;

      urlData = 'set.cgi?GROUP_a_y=' + WanDomain;
      if (1 == CfgGuide) {
        urlData += '&cfgguide=1';
      }

      if (isSupportLte == "1") {
        var CurrentWan = GetWanList()[selctIndex];
        if ((enable == 1) && (CurrentWan.RadioWanPSEnable == enable)) {
          return;
        }
      }

      var ParaData = 'GROUP_a_y.Enable=' + enable;
      ParaData += '&GROUP_a_y.ConnectionTrigger=' + triggermode;

      if ((isSupportLte == "1") && (IsCurrentRadioWan() == true) && (CurrentWan.X_HW_LteProfile == 1)) {
        var wanInfo = GetWanList();
        for (var i = 0; i < wanInfo.length; i++) {
          if ((i != selctIndex) && (IsRadioWanSupported(wanInfo[i]) == true) && (wanInfo[i].X_HW_LteProfile != 1)) {
            urlData += "&GROUP_a_" + i + "=" + wanInfo[i].domain;
            ParaData += "&GROUP_a_" + i + ".Enable=" + enable;
          }
        }
      }

      urlData += '&RequestFile=html/bbsp/wan/wan.asp';

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: ParaData + '&x.X_HW_Token=' + Onttoken,
        url: urlData,
      });
    }

    function lteBandIsSelected() {
      var lteBandList = document.getElementsByName("lteband");
      var lteBand = '';
      for (var i = 0; i < lteBandList.length; i++) {
        if (lteBandList[i].checked != true) {
          continue;
        }
        lteBand = lteBand + lteBandList[i].value;
      }

      if ((lteBand == '') && (CfgModeWord.toUpperCase() != 'DETHMAXIS')) {
        AlertEx(Languages['LteBandTips']);
        return false;
      }

      return true;
    }

    function saveLteInfo() {
      var lteBandList = document.getElementsByName("lteband");
      var lteBand = '';
      for (var i = 0; i < lteBandList.length; i++) {
        if (lteBandList[i].checked != true) {
          continue;
        }
        lteBand = lteBand + lteBandList[i].value;
      }

      var postData = 'l.LTEBandSet=' + lteBand;
      postData += '&b.Mode=' + getRadioVal('BackupMode');
      postData += '&b.SwitchDelayTime=' + getValue('BackupDelayTime');

      var lteBandPath = 'l=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface';
      var lteBackupPath = 'b=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Backup'
      var postUrl = "set.cgi?"+lteBandPath + "&" + lteBackupPath +"&RequestFile=html/bbsp/wan/wan.asp";

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: postData + "&x.X_HW_Token=" + getValue('onttoken'),
        url: postUrl,
      });

      return;
    }

    function GetUnbindRadioWanProfile() {
      var DEFAULT_PROFILE_INST = "1";
      var RADIO_WAN_PROFILE_MAX = 3;
      var unbindInstList = new Array(0, 1, 2, 3);
      var wanListTmp = GetWanList();

      if (wanListTmp == null) {
        return parseInt(DEFAULT_PROFILE_INST);
      }

      for (var i = 0; i < wanListTmp.length; i++) {
        if (IsRadioWanSupported(wanListTmp[i]) == false) {
          continue;
        }

        var instId = wanListTmp[i].X_HW_LteProfile;
        if (instId == 0 || instId > RADIO_WAN_PROFILE_MAX) {
          continue;
        }

        unbindInstList[instId] = 0;
      }

      for (var i = 1; i <= RADIO_WAN_PROFILE_MAX; i++) {
        var instId = unbindInstList[i];
        if (instId != 0) {
          return instId;
        }
      }

      return parseInt(DEFAULT_PROFILE_INST);
    }

    function FoundNewRadioWanProfile(newApn) {
      var DEFAULT_PROFILE_INST = "1";

      var radioWanProfile = GetRadioWanProfileArray();
      if ((radioWanProfile == null) || (radioWanProfile.length < 1)) {
        return parseInt(DEFAULT_PROFILE_INST);
      }

      for (var i = 0; i < (radioWanProfile.length - 1); i++) {
        if (radioWanProfile[i] == null) {
          continue;
        }

        if (radioWanProfile[i].LteAPN == newApn) {
          var domain = radioWanProfile[i].domain;
          var instId = domain.replace(/[^\d]/g, '');
          return parseInt(instId);
        }
      }

      return parseInt(DEFAULT_PROFILE_INST);
    }

    function UpdateWanLteBind(wanDomain, newApn) {
      var urlData = 'set.cgi?GROUP_a_y=' + wanDomain + '&RequestFile=html/bbsp/wan/wan.asp';
      if (CfgGuide == 1) {
        urlData += '&cfgguide=1';
      }

      var addProfileInst;
      if (newApn == '') {
        addProfileInst = GetUnbindRadioWanProfile();
      } else {
        addProfileInst = FoundNewRadioWanProfile(newApn);
      }
      var paramterData = 'GROUP_a_y.X_HW_LteProfile=' + addProfileInst;

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: paramterData + '&x.X_HW_Token=' + getValue('onttoken'),
        url: urlData,
      });

    }

    function OnRadioWanApply() {
      var Wan = GetPageData();
      var Url = '';
      var RadioWanPSPath = '';
      var RadioWanPath = '';

      if (CheckRadioWan(Wan, EditFlag) == false) {
        return false;
      }

      if ((isSupportLte == "1") && (lteBandIsSelected() == false)) {
        return false;
      }

      setDisable("ButtonApply", "1");
      setDisable("ButtonCancel", "1");

      var ProtectInterface;
      var CheckBoxList;
      var enable = getCheckVal("RadioWanPSEnable");
      var triggermode = getRadioVal("TriggerMode");

      if (EditFlag == "ADD") {
        ProtectInterface = AddAndGetProtectInterface();
      }
      else {
        CheckBoxList = document.getElementsByName("wanInstTablerml");
        ProtectInterface = CheckBoxList[selctIndex2].value;
      }

      if ("" == ProtectInterface) {
        return false;
      }

      var wandata;
      if (isSupportLte == "1") {
        wandata = addParamForLteWan(Wan, ProtectInterface);
      } else {
        wandata = addParamForRadioWan(Wan, ProtectInterface);
      }

      var RadioWanIPv6AddrPath = "";
      var RadioWanIPv6PrefixPath = "";
      if (isSupportLte == "1") {
        if (EditFlag == "ADD") {
          var ipType = getSelectVal('ProtocolType');
          if ((ipType == 'IPv6') || (ipType == 'IPv4/IPv6')) {
            RadioWanIPv6AddrPath = '&IPv6Addr=' + ProtectInterface + '.X_HW_IPv6.IPv6Address';
            RadioWanIPv6PrefixPath = '&IPv6Pre=' + ProtectInterface + '.X_HW_IPv6.IPv6Prefix';

            wandata += '&IPv6Addr.Alias=';
            wandata += '&IPv6Addr.Origin=Static';
            wandata += '&IPv6Addr.DefaultGateway=';
            wandata += '&IPv6Addr.IPAddress=';
            wandata += '&IPv6Addr.ChildPrefixBits=';
            wandata += '&IPv6Addr.AddrMaskLen=64';

            wandata += '&IPv6Pre.Alias=';
            wandata += '&IPv6Pre.Origin=Static';
            wandata += '&IPv6Pre.Prefix=';
          }
        }
      }

      if (isSupportLte == "1") {
        saveLteInfo();
      }

      if (EditFlag == "ADD") {
        RadioWanPSPath = '&s=InternetGatewayDevice.X_HW_RadioWanPS';
        RadioWanPath = '&t=InternetGatewayDevice.X_HW_Radio_WAN';
        if (isSupportLte == "1") {
          RadioWanPSPath = '';
          RadioWanPath = 't=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Profile';
        }
        Url = 'addcfg.cgi?' + RadioWanPath + RadioWanPSPath + RadioWanIPv6AddrPath + RadioWanIPv6PrefixPath + '&RequestFile=html/bbsp/wan/wan.asp';
      }
      else {
        RadioWanPSPath = '&s=InternetGatewayDevice.X_HW_RadioWanPS.1';
        RadioWanPath = '&t=InternetGatewayDevice.X_HW_Radio_WAN.1';
        if (isSupportLte == "1") {
          RadioWanPSPath = '';
          RadioWanPath = 't=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Profile.' + Wan.X_HW_LteProfile;
        }
        Url = 'complex.cgi?' + RadioWanPath + RadioWanPSPath + RadioWanIPv6AddrPath + RadioWanIPv6PrefixPath + '&RequestFile=html/bbsp/wan/wan.asp';
      }

      if (1 == CfgGuide) {
        Url += '&cfgguide=1';
      }

      if (Wan.RadioWanPSEnable == 1) {
        if ((devInfo.ModelName.toString().toUpperCase() == 'HG8247H')
          && (devInfo.HardwareVersion.toString().toUpperCase().indexOf(".A") >= 0)) {
          AlertEx(Languages['WlWanWifiConflictAlert']);
        }
      }

      stopWanStateTimer();
      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: wandata + '&x.X_HW_Token=' + getValue('onttoken'),
        url: Url,
      });

      if (EditFlag != "ADD") {
        UpdateProtectInterface(ProtectInterface, enable, triggermode);
      }

      if (isSupportLte == "1") {
        if (EditFlag == "ADD") {
          UpdateWanLteBind(ProtectInterface, Wan.APN);
        }
      }

      window.location.href = '/html/bbsp/wan/confirmwancfginfo.html';
    }

    function addParamForBroWan(wan) {
      var AddPara1 = new stSpecParaArray("u.X_HW_VLAN", wan.VlanId, 1);
      SpecWanCfgParaList.push(AddPara1);

      if (!(("EDIT" == EditFlag.toUpperCase()) && (GetCfgMode().TELMEX == "1"))) {
        var AddPara2 = new stSpecParaArray("u.X_HW_PriPolicy", wan.PriorityPolicy, 1);
        SpecWanCfgParaList.push(AddPara2);

        var AddPara3 = new stSpecParaArray("u.X_HW_PRI", wan.Priority, 1);
        SpecWanCfgParaList.push(AddPara3);

        var AddPara4 = new stSpecParaArray("u.X_HW_DefaultPri", wan.DefaultPriority, 1);
        SpecWanCfgParaList.push(AddPara4);
      }
    }

    function CheckParameter() {
      var userName = document.getElementById("UserName");
      var passWord = document.getElementById("Password");

      if (userName.value == "") {
        AlertEx(Languages['UserNameTips']);
        return false;
      }
      if (passWord.value == "") {
        AlertEx(Languages['PasswordTips']);
        return false;
      }
      return true;
    }

    function OnEditApply() {
      var Wan = GetPageData();

      selctIndex = (-1 == selctIndex) ? selctIndex2 : selctIndex;

      var CurrentWan = GetWanList()[selctIndex];

      if (true == IsCurrentRadioWan()) {
        if (CheckRadioWan(Wan, EditFlag) == false) {
          return false;
        }
      }
      else {
        if (CheckWan(Wan) == false) {
          return false;
        }
      }

      if (CheckWanSet(Wan) == false) {
        return false;
      }

      if (isE8cAndCMCC()) {
        if (gWanMode != Wan.Mode && Wan.Mode == 'IP_Routed') {
          Wan.IPv4NATEnable = 1;
        }
      }

      if (CheckOption60(Wan) == false) {
        return false;
      }

      if (CfgModeWord.toUpperCase() == "DTURKCELL2WIFI") {
        if (!CheckParameter()) {
          return false;
        }

      }

      setDisable("ButtonApply", "1");
      setDisable("ButtonCancel", "1");

      var Parameter = {};
      FillForm(Parameter, Wan);

      var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);
      if (IPv6PrefixUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable) {
        IPv6PrefixUrl = "&" + COMPLEX_CGI_PREFIX + "n=" + Wan.domain + ".X_HW_IPv6.IPv6Prefix";
      }
      else {
        IPv6PrefixUrl = (IPv6PrefixUrl == null) ? "" : ("&n=" + IPv6PrefixUrl.domain);
      }

      var IPv6addressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
      if (IPv6addressUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable) {
        IPv6addressUrl = "&" + COMPLEX_CGI_PREFIX + "m=" + Wan.domain + ".X_HW_IPv6.IPv6Address";
      }
      else {
        IPv6addressUrl = (IPv6addressUrl == null) ? "" : ("&m=" + IPv6addressUrl.domain);
      }

      var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
      if (Wan.Mode == 'IP_Routed' && Wan.IPv6AddressMode == "Static" && DnsUrl == null) {
        DnsUrl = "&" + COMPLEX_CGI_PREFIX + "k=InternetGatewayDevice.X_HW_DNS.Client.Server";
      }
      else if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable && DnsUrl == null && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None")) {
        DnsUrl = "&" + COMPLEX_CGI_PREFIX + "k=InternetGatewayDevice.X_HW_DNS.Client.Server";
      }
      else {
        DnsUrl = (DnsUrl == null) ? "" : ("&k=" + DnsUrl.domain);
        DnsUrl = (Wan.IPv6AddressMode == "Static") ? DnsUrl : "";
        if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None")) {
          var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
          DnsUrl = (DnsUrl == null) ? "" : ("&k=" + DnsUrl.domain);
        }
      }

      var LinkTypePath = GetLinkTypePath(Wan);
      var CurrentWan = GetWanList()[selctIndex];
      var broWan = GetBrotherWan(CurrentWan);
      var FlagForAddBroWan = false;

      var DSLite = (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") ? ('.X_HW_IPv6.DSLite') : '';
      var Path6Rd = (true == Is6RdSupported()) ? ('.X_HW_6RDTunnel') : '';

      var DSLiteUrl = (DSLite != '') ? ('&j=' + Wan.domain + DSLite) : '';
      var Path6RdUrl = (Path6Rd != '') ? ('&r=' + Wan.domain + Path6Rd) : '';
      var unnumberedIpPath = ((SupportUnnumberIp(Wan) == true) && (IsUnnumberedWanExist() == false)) ? ('&g=' + Wan.domain + '.X_HW_UnnumberedIP') : '';

      if (((CurrentWan.VlanId != Wan.VlanId)
        || (CurrentWan.PriorityPolicy != Wan.PriorityPolicy)
        || (CurrentWan.EnableVlan != Wan.EnableVlan)
        || ((Wan.PriorityPolicy.toUpperCase() == 'SPECIFIED') && (CurrentWan.Priority != Wan.Priority))
        || ((Wan.PriorityPolicy.toUpperCase() != 'SPECIFIED') && (CurrentWan.DefaultPriority != Wan.DefaultPriority)))
        && (broWan != null)) {
        var prompt = GetLanguage("brothwan") + MakeWanName(broWan) + GetLanguage("browanvlan");
        if (false == ConfirmEx(prompt)) {
          return;
        }
        broWan.EnableVlan = Wan.EnableVlan;



        if (Wan.EnableVlan == "1") {
          broWan.VlanId = Wan.VlanId;
          broWan.Priority = Wan.Priority;
        }
        else {
          broWan.VlanId = 0;
          if (1 == isSupportVLAN0) {
            broWan.VlanId = 4095;
          }

          broWan.Priority = 0;
        }

        broWan.PriorityPolicy = Wan.PriorityPolicy;

        broWan.DefaultPriority = Wan.DefaultPriority;

        FlagForAddBroWan = true;

        var Url = 'complex.cgi?'
          + 'y=' + Wan.domain
          + IPv6PrefixUrl
          + IPv6addressUrl
          + DnsUrl
          + DSLiteUrl
          + Path6RdUrl
          + unnumberedIpPath
          + '&u=' + broWan.domain
          + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html';

      }
      else {
        var Url = 'complex.cgi?'
          + 'y=' + Wan.domain
          + IPv6PrefixUrl
          + IPv6addressUrl
          + DnsUrl
          + LinkTypePath
          + DSLiteUrl
          + Path6RdUrl
          + unnumberedIpPath
          + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html';
      }

      if (((GetCfgMode().TELECENTRO == "1") || (WANMODEChange == 1) || (CfgModeWord.toUpperCase() == "DICELANDVDF")) && (!IsAdminUser())) {
        var Url = 'complex.cgi?y=' + Wan.domain
          + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html';
      }
      if (FlagForAddBroWan == true) {
        addParamForBroWan(broWan);
      }

      Parameter.asynflag = null;
      Parameter.FormLiList = WanConfigFormList;
      Parameter.OldValueList = CurrentWan;
      Parameter.SpecParaPair = SpecWanCfgParaList;

      if (1 == CfgGuide) {
        Url += '&cfgguide=1';
      }

      var tokenvalue = getValue('onttoken');
      stopWanStateTimer();
      var bRet = HWSetAction(null, Url, Parameter, tokenvalue);
      if (!bRet) {
        setDisable("ButtonApply", "0");
        setDisable("ButtonCancel", "0");
      }
    }

    function FillFormXDSpecLinkType(Wan, SpecWanCfgParaList) {
      SpecWanCfgParaList.push(new stSpecParaArray('f.WanAccessType', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.Enable', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.DestinationAddress', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.LinkType', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.ATMQoS', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.ATMPeakCellRate', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.ATMMaximumBurstSize', '', 2));
      SpecWanCfgParaList.push(new stSpecParaArray('e.ATMSustainableCellRate', '', 2));

      if ((Wan.WanAccessType == "DSL") || (Wan.WanAccessType == "VDSL")) {
        SpecWanCfgParaList.push(new stSpecParaArray('e.Enable', 1, 1));
      }

      if (Wan.WanAccessType == "DSL") {
        SpecWanCfgParaList.push(new stSpecParaArray('e.DestinationAddress', "PVC:" + Wan.DestinationAddress, 1));
        SpecWanCfgParaList.push(new stSpecParaArray('e.LinkType', Wan.LinkType, 1));
        SpecWanCfgParaList.push(new stSpecParaArray('e.ATMQoS', Wan.ATMQoS, 1));

        if ('UBR+' == getValue('ServiceType') || 'CBR' == getValue('ServiceType')) {
          SpecWanCfgParaList.push(new stSpecParaArray('e.ATMPeakCellRate', Wan.ATMPeakCellRate, 1));
        }
        if ('VBR-nrt' == getValue('ServiceType') || 'VBR-rt' == getValue('ServiceType')) {
          SpecWanCfgParaList.push(new stSpecParaArray('e.ATMPeakCellRate', Wan.ATMPeakCellRate, 1));
          SpecWanCfgParaList.push(new stSpecParaArray('e.ATMMaximumBurstSize', Wan.ATMMaximumBurstSize, 1));
          SpecWanCfgParaList.push(new stSpecParaArray('e.ATMSustainableCellRate', Wan.ATMSustainableCellRate, 1));
        }
      }
    }

    function FillSysFormXDSpec(Wan, nodePrefix, SpecWanCfgParaList) {
      if (!IsXdUpMode()) {
        return;
      }

      FillFormXDSpecLinkType(Wan, SpecWanCfgParaList);
    }

    function OnEditApplyOmitBrother() {
      var Wan = GetPageData();

      selctIndex = (-1 == selctIndex) ? selctIndex2 : selctIndex;

      var CurrentWan = GetWanList()[selctIndex];

      if (CheckWan(Wan) == false) {
        return false;
      }

      if (CheckWanSet(Wan) == false) {
        return false;
      }

      if (isE8cAndCMCC()) {
        if (gWanMode != Wan.Mode && Wan.Mode == 'IP_Routed') {
          Wan.IPv4NATEnable = 1;
        }
      }

      if (CheckOption60(Wan) == false) {
        return false;
      }

      setDisable("ButtonApply", "1");
      setDisable("ButtonCancel", "1");

      var Parameter = {};
      FillForm(Parameter, Wan);
      Parameter.asynflag = null;
      Parameter.FormLiList = WanConfigFormList;
      Parameter.OldValueList = CurrentWan;
      Parameter.SpecParaPair = SpecWanCfgParaList;

      var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);
      if (IPv6PrefixUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable) {
        IPv6PrefixUrl = "&" + COMPLEX_CGI_PREFIX + "n=" + Wan.domain + ".X_HW_IPv6.IPv6Prefix";
      }
      else {
        IPv6PrefixUrl = (IPv6PrefixUrl == null) ? "" : ("&n=" + IPv6PrefixUrl.domain);
      }

      var IPv6addressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
      if (IPv6addressUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable) {
        IPv6addressUrl = "&" + COMPLEX_CGI_PREFIX + "m=" + Wan.domain + ".X_HW_IPv6.IPv6Address";
      }
      else {
        IPv6addressUrl = (IPv6addressUrl == null) ? "" : ("&m=" + IPv6addressUrl.domain);
      }

      var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
      if (Wan.Mode == 'IP_Routed' && Wan.IPv6AddressMode == "Static" && DnsUrl == null) {
        DnsUrl = "&" + COMPLEX_CGI_PREFIX + "k=InternetGatewayDevice.X_HW_DNS.Client.Server";
      }
      else if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && DnsUrl == null && "1" == Wan.IPv6Enable && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None")) {
        DnsUrl = "&" + COMPLEX_CGI_PREFIX + "k=InternetGatewayDevice.X_HW_DNS.Client.Server";
      }
      else {
        DnsUrl = (DnsUrl == null) ? "" : ("&k=" + DnsUrl.domain);
        DnsUrl = (Wan.IPv6AddressMode == "Static") ? DnsUrl : "";
      }

      var DSLite = (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") ? ('.X_HW_IPv6.DSLite') : '';
      var DSLiteUrl = (DSLite != '') ? ('&j=' + Wan.domain + DSLite) : '';
      var Url = 'complex.cgi?'
        + 'y=' + Wan.domain
        + IPv6PrefixUrl
        + IPv6addressUrl
        + DnsUrl
        + GetLinkConfigUrl(Wan)
        + DSLiteUrl
        + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html';

      if (1 == CfgGuide) {
        Url += '&cfgguide=1';
      }

      var tokenvalue = getValue('onttoken');
      stopWanStateTimer();
      var bRet = HWSetAction(null, Url, Parameter, tokenvalue);
      if (!bRet) {
        setDisable("ButtonApply", "0");
        setDisable("ButtonCancel", "0");
      }
    }

    function CheckPassword() {
      var password = document.getElementById('modepassword');

      if (password.value == "") {
        document.getElementById('checkWord').innerHTML = Languages['webcodetips'];
      } else {
        var base64Passwd = Base64Encode(password.value);
        var CheckResult = 0;
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          url: '../common/checkmodepwd.asp',
          data: 'wanwebcode=' + base64Passwd,
          success: function (data) {
            CheckResult = data;
          }
        });
        cover.style.display = "none";
        toast.style.display = "none";
        if (CheckResult != 1) {
          AlertEx(Languages['webcodeerror']);
        } else {
          OnEditApply();
        }
      }
    }

    function OnApply() {
      if ((IsAdminUser() == false) && (isWanForConfig == "1")) {
        return;
      }

      var CurrentWan = GetWanList()[selctIndex];
      var selctWanMode = getValue('WanMode');
      if ((selctIndex >= 0) && (CurrentWan.ServiceList.toString().toUpperCase() == 'CAPWAP')) {
        return;
      }

      if (true == IsCurrentRadioWan()) {
        OnRadioWanApply();
        return;
      }

      if (EditFlag == "ADD") {
        OnAddApply();
        return;
      }

      if (IsIPV6LANDEV == 1) {
        OverrideAllowedFlag = 1;
      }
      else {
        OverrideAllowedFlag = 2;
      }
      if (curCfgModeWord == "HAINCU" &&
        CurrentWan.Mode.toString().toUpperCase() == 'IP_ROUTED' &&
        (CurrentWan.ServiceList.toString().toUpperCase() == 'INTERNET' ||
          CurrentWan.ServiceList.toString().toUpperCase() == 'IPTV') &&
        selctWanMode == 'IP_Bridged') {
        var toast = document.getElementById("toast");
        var cover = document.getElementById("cover");
        var password = document.getElementById('modepassword');
        cover.style.display = "block";
        toast.style.display = "block";
        toast.style.position = "fixed";
        password.value = ""

      } else {
        var SessionVlanLimit = "<%HW_WEB_GetFeatureSupport(BBSP_FT_MULT_SESSION_VLAN_LIMIT);%>";
        if (SessionVlanLimit == 1) {
          OnEditApply();
        }
        else {
          OnEditApplyOmitBrother();
        }
      }
      $(function () {
        function boxAuto() {
          var dom = $("#toast");
          var w = dom.innerWidth();
          var h = dom.innerHeight();
          var t = ($(window).height() - h) / 2;
          var l = ($(window).width() - w) / 2;
          dom.css("top", t);
          dom.css("left", l);
        }
        boxAuto();
        $(window).resize(function () {
          boxAuto();
        })
      });
    }
    function OnCancel() {
      DisplayConfigPanel(0);
      if (EditFlag == "ADD") {
        DeleteLineRow();
        return false;
      }
    }

    function getWanindexByDomain(wandomain) {
      var wanindex = -1;
      for (var i = 0; i < Wan.length; i++) {
        if (wandomain == Wan[i].domain) {
          wanindex = i;
          return wanindex;
        }
      }
      return wanindex;
    }

    function clickRemove() {
      var CheckBoxList = document.getElementsByName("wanInstTablerml");
      var Count = 0;
      var i;
      var Wan = GetPageData();
      for (i = 0; i < CheckBoxList.length; i++) {
        if (CheckBoxList[i].checked == true) {
          Count++;
        }
      }

      if (Count == 0) {
        return false;
      }

      if ((IsTRUEFlag == 1) || (isSupportLte == 1)) {
        for (i = 0; i < CheckBoxList.length; i++) {
          if (CheckBoxList[i].checked != true) {
            continue;
          }

          if (((IsTRUEFlag == 1) && (CheckBoxList[i].value == "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1")) ||
            ((IsDefaultLteWan(CheckBoxList[i].value) == true) && (CfgModeWord.toUpperCase() != 'DETHMAXIS'))) {
            AlertEx(Languages['DeleteError']);
            return false;
          }
        }
      }

      var defaultWanListLength = 0;
      if (oteFlag == "1") {
        defaultWanListLength = 5;
      }
      if (htFlag == "1") {
        defaultWanListLength = 9;
      }
      if ((oteFlag == "1") || (htFlag == "1")) {
        for (i = 0; i < defaultWanListLength; i++) {
          if (CheckBoxList[i].checked == true) {
            AlertEx(Languages['DeleteError']);
            return false;
          }
        }
      }
      setDisable("DeleteButton", "1");
      setDisable("ButtonApply", "1");
      setDisable("ButtonCancel", "1");

      if (!DoubleFreqFlag) {
        var Form = new webSubmitForm();
        for (i = 0; i < CheckBoxList.length; i++) {
          if (CheckBoxList[i].checked != true) {
            continue;
          }

          var wanindex = getWanindexByDomain(CheckBoxList[i].value);

          if ((-1 != wanindex) && (true == IsRadioWanSupported(GetWanList()[wanindex]))) {
            Form.addParameter(CheckBoxList[i].value, '');
            if (isSupportLte == "1") {
              var checkedRadioWan = GetWanList()[wanindex];
              var toDeleteProfile = 'InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Profile.' + checkedRadioWan.X_HW_LteProfile;
              Form.addParameter(toDeleteProfile, '');
            } else {
              Form.addParameter('InternetGatewayDevice.X_HW_RadioWanPS.1', '');
              Form.addParameter('InternetGatewayDevice.X_HW_Radio_WAN.1', '');
            }
            continue;
          }
          Form.addParameter(CheckBoxList[i].value, '');

        }
        stopWanStateTimer();
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        if (1 == CfgGuide) {
          Form.setAction('del.cgi?RequestFile=html/bbsp/wan/wan.asp' + '&cfgguide=1');
        }
        else {
          Form.setAction('del.cgi?RequestFile=html/bbsp/wan/confirmwancfginfo.html');
        }
      }
      else {
        var LanWanBindInfo = Instance_PolicyRoute.GetLanWanBindInfo(domainTowanname(Wan.domain));

        var Form = new webSubmitForm();
        for (i = 0; i < CheckBoxList.length; i++) {
          if (CheckBoxList[i].checked != true) {
            continue;
          }

          var wanindex = getWanindexByDomain(CheckBoxList[i].value);
          if ((-1 != wanindex) && (true == IsRadioWanSupported(GetWanList()[wanindex]))) {
            Form.addParameter(CheckBoxList[i].value, '');
            if (isSupportLte == "1") {
              var checkedRadioWan = GetWanList()[wanindex];
              var toDeleteProfile = 'InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Profile.' + checkedRadioWan.X_HW_LteProfile;
              Form.addParameter(toDeleteProfile, '');
            } else {
              Form.addParameter('InternetGatewayDevice.X_HW_RadioWanPS.1', '');
              Form.addParameter('InternetGatewayDevice.X_HW_Radio_WAN.1', '');
            }
            continue;
          }

          if ((wanindex != -1) && (GetWanList()[wanindex].ServiceList.toString().toUpperCase() == 'CAPWAP')) {
            continue;
          }

          Form.addParameter(CheckBoxList[i].value, '');
        }
        if (LanWanBindInfo != null) {

        }
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        if (1 == CfgGuide) {
          Form.setAction('del.cgi?RequestFile=html/bbsp/wan/wan.asp' + '&cfgguide=1');
        }
        else {
          Form.setAction('del.cgi?RequestFile=html/bbsp/wan/confirmwancfginfo.html');
        }
      }
      stopWanStateTimer();
      Form.submit();
    }

function getBindlist(Wan)
{
  var Bindlist = "";
  for (var i = 1; i <= TopoInfo.EthNum; i++) {
    if (IsLanBind("Lan" + i, Wan.IPv4BindLanList)==true) {
      Bindlist = Bindlist + "Lan" + i + ",";
    }
  }

  for (var i = 1; i <= TopoInfo.SSIDNum; i++) {
    if (IsLanBind("SSID" + i, Wan.IPv4BindLanList)==true) {
      Bindlist = Bindlist + "SSID" + i + ",";
    }
  }
  if (supportOnuBind == 1 && Wan.Mode == "IP_Bridged" &&
    Wan.IPv4BindOnuList != null && Wan.IPv4BindOnuList != undefined) {
    for (var j = 1; j <= maxOnuNum; j++) {
      if (IsLanBind("ONU" + i, Wan.IPv4BindOnuList) == true) {
        Bindlist = Bindlist + "ONU" + j + ",";
      }
    }
  }

  return Bindlist.substring(0, Bindlist.length - 1);
}

    function FillUserForm(Parameter, Wan) {
      var UserPwdFlag = 2;
      var IPv4DialModeFlag = 2;
      var IdleDisconnectFlag = 2;
      var NatTypeFlag = 2;
      var NATEnabledFlag = 2;
      var ConnectionTypeFlag = 2;

      if (Wan.Mode == 'IP_Routed') {
        switch (Wan.IPv4AddressMode) {
          case 'PPPoE':
            // WANMODEChange为1表示开启WAN类型路由桥接切换(IPOE\PPPOE)
            if (WANMODEChange != 1 || CfgModeWord.toUpperCase() != "AISAP") {
              UserPwdFlag = 1;
            }

            if ((GetCfgMode().BJUNICOM == "1") || (CfgModeWord.toUpperCase() == 'DGRWIND')) {
              IPv4DialModeFlag = 1;
              if (Wan.IPv4DialMode == "OnDemand") {
                IdleDisconnectFlag = 1;
              }
            }
            break;
        }
      }
      if (Wan.Mode == 'IP_Routed' && Wan.IPv4Enable == "1") {
        if (IsSonetUser() && Wan.IPv4NATEnable == "1") {
          NatTypeFlag = 1;
        }
      }
      if (GetCfgMode().BJCU == "1" || IsLanBJUNICOM()) {
        NATEnabledFlag = 1;
        ConnectionTypeFlag = 1;
      }
      if (GetCfgMode().TRUE == "1") {
        ConnectionTypeFlag = 1;
      }

      if (Wan.Mode == 'IP_Routed') {
        if (('CLARO' == CfgModeWord.toUpperCase() || 'CLARODR' == CfgModeWord.toUpperCase()) && (curUserType == '2')) {
          NATEnabledFlag = 1;
          NatTypeFlag = 1
        }

      }

      if ((GetCfgMode().TELECENTRO == "1") && (!IsAdminUser())) {
        ConnectionTypeFlag = 1;
        NatTypeFlag = 2;
      }

      // WANMODEChange为1表示开启WAN类型路由桥接切换(IPOE\PPPOE)
      if ((WANMODEChange == 1) && (!IsAdminUser())) {
        ConnectionTypeFlag = 1;
      }

      var Option60Submit = 2;
      var IPoEUsernameValue = Wan.X_HW_IPoEName;
      var IPoEPasswordValue = Wan.X_HW_IPoEPassword;

      if (true == Option60DisplayFlag(Wan)) {
        Option60Submit = 1;
        if ("1" != Wan.EnableOption60) {
          IPoEUsernameValue = "";
          IPoEPasswordValue = "";
        }
      }

      var GlobeUserFlag = 2;
      var IPv4WanMVlanIdGlobeUserValue = ("" == getValue("IPv4WanMVlanIdGlobeUser")) ? 0xFFFFFFFF : getValue("IPv4WanMVlanIdGlobeUser");
      var VlanIdGlobeUserValue = (Wan.EnableVlan == "1") ? Wan.VlanId : "0";
      if (1 == isSupportVLAN0) {
        VlanIdGlobeUserValue = (Wan.EnableVlan == "1") ? Wan.VlanId : "4095";
      }

      if (('GLOBE' == CfgModeWord.toUpperCase() || 'GLOBE2' == CfgModeWord.toUpperCase()) && (!IsAdminUser())) {
        GlobeUserFlag = 1;
      }

      if (CfgModeWord.toUpperCase() == 'ROSUNION') {
        GlobeUserFlag = 1;
      }

      if ("IRAQO3" == CfgModeWord.toUpperCase()) {
        Wan.UserName = Wan.UserName + "@o3-telecom.com";
      }

      if (1 == IsTedata) {
        Wan.UserName = Wan.UserName + "@tedata.net.eg";
      }

      if ((SupportTtnet()) && (pppoeUserNameAllFlag == false)) {
        Wan.UserName = Wan.UserName + "@ttnet";
      }

      if ((SupportTtnet()) && (Wan.EncapMode.toUpperCase() === "PPPOE")) {
        var  MXUSize = Wan.IPv4MXU;

        if (Wan.IPv4MXU == "") {
            if ((DefaultMTUSize == "") || (DefaultMTUSize == "0")) {
                MXUSize = (Wan.IPv4AddressMode === 'PPPoE') ? 1492 : 1500
            } else {
                MXUSize = DefaultMTUSize;
            }
        }
    }

      var BindListFlag = 2;
      var Bindlist2 = "";
      if ((((GetCfgMode().BJUNICOM == "1") && (stbport != 0)) || (CfgModeWord.toUpperCase() == "DICELANDVDF")) && (Wan.ServiceList == 'IPTV')) {
        BindListFlag = 1;
        Bindlist2 = getBindlist(Wan);
      }

      SpecWanCfgParaList = new Array(new stSpecParaArray('d.domain', '', 2),
        new stSpecParaArray('d.AccessType', '', 2),
        new stSpecParaArray('d.EncapMode', '', 2),
        new stSpecParaArray('d.ProtocolType', '', 2),
        new stSpecParaArray('d.Mode', '', 2),
        new stSpecParaArray('d.EnableVlan', '', 2),
        new stSpecParaArray('d.VlanId', '', 2),
        new stSpecParaArray('d.ServiceList', '', 2),
        new stSpecParaArray('d.PriorityPolicy', '', 2),
        new stSpecParaArray('d.DefaultPriority', '', 2),
        new stSpecParaArray('d.Priority', '', 2),
        new stSpecParaArray('d.IPv4MXU', '', 2),
        new stSpecParaArray('d.UserName', '', 2),
        new stSpecParaArray('d.LcpEchoReqCheck', '', 2),
        new stSpecParaArray('d.IPv4BindLanList', '', 2),
        new stSpecParaArray('d.DstIPForwardingList', '', 2),
        new stSpecParaArray('d.IPForwardModeEnabled', '', 2),
        new stSpecParaArray('d.IPv4AddressMode', '', 2),
        new stSpecParaArray('d.IPv4NATEnable', '', 2),
        new stSpecParaArray('d.NatType', '', 2),
        new stSpecParaArray('d.IPv4VendorId', '', 2),
        new stSpecParaArray('d.IPv4ClientId', '', 2),
        new stSpecParaArray('d.IPv4IPAddress', '', 2),
        new stSpecParaArray('d.IPv4SubnetMask', '', 2),
        new stSpecParaArray('d.IPv4Gateway', '', 2),
        new stSpecParaArray('d.IPv4PrimaryDNS', '', 2),
        new stSpecParaArray('d.IPv4SecondaryDNS', '', 2),
        new stSpecParaArray('d.IPv4DialMode', '', 2),
        new stSpecParaArray('d.IPv4DialIdleTime', '', 2),
        new stSpecParaArray('d.IPv4IdleDisconnectMode', '', 2),
        new stSpecParaArray('d.IPv4WanMVlanId', '', 2),
        new stSpecParaArray('d.EnableLanDhcp', '', 2),
        new stSpecParaArray('d.PingIPAddress', '', 2),
        new stSpecParaArray('d.IPv6PrefixMode', '', 2),
        new stSpecParaArray('d.IPv6StaticPrefix', '', 2),
        new stSpecParaArray('d.IPv6AddressMode', '', 2),
        new stSpecParaArray('d.IPv6ReserveAddress', '', 2),
        new stSpecParaArray('d.IPv6AddressStuff', '', 2),
        new stSpecParaArray('d.IPv6IPAddress', '', 2),
        new stSpecParaArray('d.IPv6AddrMaskLenE8c', '', 2),
        new stSpecParaArray('d.IPv6GatewayE8c', '', 2),
        new stSpecParaArray('d.IPv6SubnetMask', '', 2),
        new stSpecParaArray('d.IPv6Gateway', '', 2),
        new stSpecParaArray('d.X_HW_OverrideAllowed', '', 2),
        new stSpecParaArray('d.IPv6PrimaryDNS', '', 2),
        new stSpecParaArray('d.IPv6SecondaryDNS', '', 2),
        new stSpecParaArray('d.IPv6WanMVlanId', '', 2),
        new stSpecParaArray('d.IPv6DSLite', '', 2),
        new stSpecParaArray('d.IPv6AFTRName', '', 2),
        new stSpecParaArray('d.Option60Enable', '', 2),
        (CfgModeWord.toUpperCase() != "ROSUNION") ? new stSpecParaArray('', '', 2) : new stSpecParaArray('d.X_HW_IGMPEnable', '', 2),
        new stSpecParaArray('d.X_HW_NPTv6Enable', '', 2),
        new stSpecParaArray('y.X_HW_VLAN', VlanIdGlobeUserValue, GlobeUserFlag),
        new stSpecParaArray('y.X_HW_MultiCastVLAN', IPv4WanMVlanIdGlobeUserValue, GlobeUserFlag),
        new stSpecParaArray('y.Username', Wan.UserName, UserPwdFlag),
        new stSpecParaArray('y.Password', Wan.Password, UserPwdFlag),

        new stSpecParaArray('y.X_HW_IPoEName', IPoEUsernameValue, Option60Submit),
        new stSpecParaArray('y.X_HW_IPoEPassword', IPoEPasswordValue, Option60Submit),

        new stSpecParaArray('y.ConnectionTrigger', Wan.IPv4DialMode, IPv4DialModeFlag),
        new stSpecParaArray('y.IdleDisconnectTime', Wan.IPv4DialIdleTime, IdleDisconnectFlag),
        new stSpecParaArray('y.X_HW_NatType', Wan.NatType, NatTypeFlag),
        new stSpecParaArray('y.ConnectionType', Wan.Mode, ConnectionTypeFlag),
        new stSpecParaArray('y.NATEnabled', Wan.IPv4NATEnable, NATEnabledFlag),
        new stSpecParaArray('y.X_HW_BindPhyPortInfo', Bindlist2, BindListFlag)
      );

      if (CfgModeWord.toUpperCase() == "DICELANDVDF") {
        return;
      }

      if (SupportTtnet()) {
        SpecWanCfgParaList.push(new stSpecParaArray('y.MaxMRUSize',MXUSize, 1));
      }
      FillSysFormXDSpec(Wan, 'y.', SpecWanCfgParaList);
    }

    var OverrideAllowedFlag = 2;
    function FillSysForm(Parameter, Wan) {
      var IPv6WanMVlanId = (Wan.IPv6WanMVlanId == "") ? -1 : Wan.IPv6WanMVlanId;
      var ServiceList = (true == IsOldServerListType(Wan.ServiceList)) ? Wan.ServiceList : 'INTERNET';
      var ExServiceList = (true == IsOldServerListType(Wan.ServiceList)) ? '' : Wan.ServiceList;
      var VlanId = (Wan.EnableVlan == "1") ? Wan.VlanId : "0";
      var PriorityPolicy = (Wan.EnableVlan == "1") ? Wan.PriorityPolicy : "Specified";
      var EnableLanDhcpFlag = 2;
      var EnablePriorityPolicy = 1;
      var EnablePriority = 1;
      var EnableDefPriority = 1;

      if (1 == isSupportVLAN0) {
        VlanId = (Wan.EnableVlan == "1") ? Wan.VlanId : "4095";
      }

      if (GetCfgMode().TELMEX == "1") {
        PriorityPolicy = (GetCfgMode().TELMEX == "1") ? "CopyFromIPPrecedence" : "Specified";
      }

      if (Wan.ServiceList.match('INTERNET') || Wan.ServiceList.match('IPTV') || Wan.ServiceList.match('OTHER')) {
        if (isE8cAndCMCC()) {
          EnableLanDhcpFlag = 1;
        }
      }

      var DstIPForwardingListFlag = 2;
      if (true == IsDstIPForwardingListVisibility(Wan, Wan.ServiceList)) {
        DstIPForwardingListFlag = 1;
      }

      var IPForwardModeEnabledFlag = 2;
      if (isUnicomNetworkExpress == '1') {
        IPForwardModeEnabledFlag = 1;
      }

      var IPv4WanMVlanId = ("" == Wan.IPv4WanMVlanId) ? 0xFFFFFFFF : Wan.IPv4WanMVlanId;

      if ("IPv4/IPv6" == Wan.ProtocolType.toString() && Is3TMode()) {
        if ("" == Wan.IPv4v6WanMVlanId) {
          IPv4WanMVlanId = 0xFFFFFFFF;
          IPv6WanMVlanId = -1;
        }
        else {
          IPv4WanMVlanId = Wan.IPv4v6WanMVlanId;
          IPv6WanMVlanId = Wan.IPv4v6WanMVlanId;
        }
      }

      var IPv4NATEnableFlag = 2;
      var NatTypeFlag = 2;
      if (Wan.Mode == 'IP_Routed') {
        if (IsPTVDFFlag == 1) {
          if (!(Wan.ServiceList == "TR069")) {
            IPv4NATEnableFlag = 1;
          }
        }
        else {
          IPv4NATEnableFlag = 1;
        }

        if ((Wan.IPv4NATEnable == "1")
          && ("1" != GetCfgMode().TELMEX)
          && ("1" != GetCfgMode().PCCWHK)
          && ("1" != GetCfgMode().MOBILY)
          && ("1" != GetRunningMode())) {
          NatTypeFlag = 1;
        }
      }

      var IPv4PPPoEDnsOverrideEnableFlag = 2;
      var DnsStr = Wan.IPv4PrimaryDNS + ',' + Wan.IPv4SecondaryDNS;
      if (Wan.IPv4PrimaryDNS.length == 0) {
        DnsStr = Wan.IPv4SecondaryDNS;
      }
      if (Wan.IPv4SecondaryDNS.length == 0) {
        DnsStr = Wan.IPv4PrimaryDNS;
      }

      var UsernameFlag = 2;
      var PasswordFlag = 2;
      var BridgeenableFlag = 2;
      var LcpEchoReqCheckFlag = 2;
      var IPv4DialModeFlag = 2;
      var IPv4DialIdleTimeFlag = 2;
      var IPv4IdleDisconnectModeFlag = 2;
      var DNSEnabledFlag = 2;
      var MXUSize = Wan.IPv4MXU;
      var MRUFlag = 2;
      var MTUFlag = 2;
      var AddressingTypeFlag = 2;
      var IPv4IPAddressFlag = 2;
      var IPv4NewIPAddressFlag = 2;
      var IPv4SubnetMaskFlag = 2;
      var IPv4NewSubnetMaskFlag = 2;
      var IPv4GatewayFlag = 2;
      var DnsStrFlag = 2;
      var IPv4VendorIdFlag = 2;
      var IPv4ClientIdFlag = 2;
      var IPv4IGMPEnableFlag = 2;

      if (Wan.IPv4MXU == "") {
        if ((DefaultMTUSize == "") || (DefaultMTUSize == "0")) {
          MXUSize = (Wan.IPv4AddressMode == 'PPPoE') ? 1492 : 1500;
          if ((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) {
            MXUSize = 1492;
          }
        }
        else {
          MXUSize = DefaultMTUSize;
        }
      }

      if ((Wan.IPv4AddressMode.toString().toUpperCase() != "PPPOE")
        && (MultiWanIpFeature == "1")) {
        IPv4NewIPAddressFlag = 1;
        IPv4NewSubnetMaskFlag = 1;
      }

      if (Wan.Mode == 'IP_Routed') {
        switch (Wan.IPv4AddressMode) {
          case 'PPPoE':
            UsernameFlag = 1;
            PasswordFlag = 1;
            if (((oteFlag == "1") || (htFlag == "1")) && (Wan.ServiceList.indexOf("INTERNET") >= 0)) {
              BridgeenableFlag = 1;
            }
            if (!isE8cAndCMCC()) {
              LcpEchoReqCheckFlag = 1;
            }
            var ServiceListIpv4Dia = ['INTERNET'];
            if (CfgModeWord.toUpperCase() == "DGRWIND") {
              ServiceListIpv4Dia = ['*'];
            }
            if ((ServiceListIpv4Dia.indexOf(ServiceList) >= 0) ||
              (ServiceListIpv4Dia.indexOf('*') >= 0)) {
              var IPv4DialModeFlag = 1;
              if (Wan.IPv4DialMode == "OnDemand") {
                IPv4DialIdleTimeFlag = 1;
                IPv4IdleDisconnectModeFlag = 1;
              }
            }
            DNSEnabledFlag = 1;
            IPv4PPPoEDnsOverrideEnableFlag = 1;
            DnsStrFlag = 1;

            if (true != CheckProcDnsOverride()) {
              IPv4PPPoEDnsOverrideEnableFlag = 2;
              DnsStrFlag = 2;
            }

            if ("1" != GetCfgMode().PCCWHK) {
              MRUFlag = 1;
            }

            if ((CfgModeWord.toUpperCase() == "DGRWIND") && (IsAdminUser())) {
              BridgeenableFlag = 1;
            }

            break;

          case 'Static':
            if ("1" == Wan.IPv4Enable) {
              AddressingTypeFlag = 1;
              IPv4IPAddressFlag = 1;
              IPv4SubnetMaskFlag = 1;
              IPv4GatewayFlag = 1;
              DnsStrFlag = 1;
              DNSEnabledFlag = 1;

            }
            if ("1" != GetCfgMode().PCCWHK) {
              MTUFlag = 1;
            }
            break;

          case 'DHCP':
            if ("1" == Wan.IPv4Enable) {
              AddressingTypeFlag = 1;
              IPv4VendorIdFlag = 1;
              DNSEnabledFlag = 1;
              IPv4PPPoEDnsOverrideEnableFlag = 1;
              DnsStrFlag = 1;

              if (true != CheckProcDnsOverride()) {
                IPv4PPPoEDnsOverrideEnableFlag = 2;
                DnsStrFlag = 2;
              }

              if (!isE8cAndCMCC()) {
                IPv4ClientIdFlag = 1;
              }
            }
            if ("1" != GetCfgMode().PCCWHK) {
              MTUFlag = 1;
            }
            break;
          default:
            break;
        }
      }
      if (((CfgModeWord.toUpperCase() == 'TDE2') || (CfgModeWord.toUpperCase() == 'PCCW')) &&
        ((GetCurrentWan().ServiceList == 'IPTV') || (GetCurrentWan().ServiceList == 'VOIP'))) {
        MTUFlag = 2;
        MRUFlag = 2;
      }
      var BindListFlag = 2;
      if (Wan.ServiceList.match('INTERNET')
        || Wan.ServiceList.match('IPTV')
        || Wan.ServiceList.match('OTHER')) {
        BindListFlag = 1;
        var Bindlist = "";
        var Bindlist2 = "";
        for (var i = 1; i <= TopoInfo.EthNum; i++) {
          if (IsLanBind("Lan" + i, Wan.IPv4BindLanList) == true) {
            Bindlist = Bindlist + "Lan" + i + ",";
          }
        }

        for (var i = 1; i <= TopoInfo.SSIDNum; i++) {
          if (IsLanBind("SSID" + i, Wan.IPv4BindLanList) == true) {
            Bindlist = Bindlist + "SSID" + i + ",";
            if ((i === 5) && (scnFT === '1') && (scnEnable === '1')) {
              Bindlist = Bindlist + "SSID" + scnInst5G + ",";
            }
          }
        }
        if (supportOnuBind == 1 && Wan.Mode == "IP_Bridged" &&
          Wan.IPv4BindOnuList != null && Wan.IPv4BindOnuList != undefined) {
          for (var j = 1; j <= maxOnuNum; j++) {
            if (IsLanBind("ONU" + i, Wan.IPv4BindOnuList) == true) {
              Bindlist = Bindlist + "ONU" + j + ",";
            }
          }
        }

        if ((ponOnuBind == 1) && (Wan.IPv4BindOnuList != null) && (Wan.IPv4BindOnuList != undefined)) {
          for (var j = 1; j <= 16; j++) {
              if (IsLanBind("ONU" + j, Wan.IPv4BindOnuList)) {
                  Bindlist = Bindlist + "ONU" + j + ",";
              }
          }
        }
        Bindlist2 = Bindlist.substring(0, Bindlist.length - 1);
      }

      var nodePrefix = "";
      var IPv6Addr_Pre = "";
      var IPv6Pref_Pre = "";

      if (EditFlag == "ADD") {
        nodePrefix = "GROUP_a_y.";
      }
      else if (EditFlag == "EDIT") {
        nodePrefix = "y.";
      }

      var IPv6AddrFlag = 2;
      var IPv6ReserveAddrFlag = 2;
      var nptv6Flag = 2;
      if ("IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable) {

        IPv6AddrFlag = 1;
        var IPv6AddressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
        if (IPv6AddressUrl == null && EditFlag == "EDIT") {
          IPv6Addr_Pre = COMPLEX_CGI_PREFIX + 'm.';
        }
        else {
          IPv6Addr_Pre = 'm.';
        }

        Wan.IPv6AddrMaskLenE8c = (Wan.IPv6AddrMaskLenE8c == "") ? "0" : Wan.IPv6AddrMaskLenE8c;
        if ((Wan.EncapMode.toString().toUpperCase() == "IPOE") && (Wan.IPv6AddressMode == "None")) {
          if (!isE8cAndCMCC()) {
            IPv6ReserveAddrFlag = 1;
          }
        }

        if (SupportNPTv6(Wan)) {
          nptv6Flag = 1;
        }
      }

      var IPv6PrefFlag = 2;
      if ("IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable) {
        IPv6PrefFlag = 1;
        var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);
        if (IPv6PrefixUrl == null && EditFlag == "EDIT") {
          IPv6Pref_Pre = COMPLEX_CGI_PREFIX + 'n.';
        }
        else {
          IPv6Pref_Pre = 'n.';
        }
      }

      var IPv6DnsFlag = 2;
      var IPv6DnsInterfaceFlag = 2;
      var IPv6Dns_Pre = "";
      if ("IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable && Wan.IPv6AddressMode == "Static") {
        IPv6DnsFlag = 1;
        var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
        var DnsServer = GetWanDnsServerString(Wan.IPv6PrimaryDNS, Wan.IPv6SecondaryDNS);
        if (DnsUrl == null && EditFlag == "EDIT") {
          IPv6DnsInterfaceFlag = 1;
          IPv6Dns_Pre = COMPLEX_CGI_PREFIX + 'k.';
        }
        else {
          IPv6Dns_Pre = 'k.';
        }
      }

      OverrideAllowed = getCheckVal('IPV6OverrideAllowed');
      if ((1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag) && Wan.Mode == "IP_Routed" && "1" == Wan.IPv6Enable && (Wan.IPv6AddressMode == "AutoConfigured" || Wan.IPv6AddressMode == "DHCPv6" || Wan.IPv6AddressMode == "None")) {
        IPv6DnsFlag = 1;
        var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
        var DnsServer = GetWanDnsServerString(Wan.IPv6PrimaryDNS, Wan.IPv6SecondaryDNS);
        if ((DnsUrl == null && EditFlag == "EDIT")) {
          IPv6DnsInterfaceFlag = 1;
          IPv6Dns_Pre = COMPLEX_CGI_PREFIX + 'k.';
        }
        else if (EditFlag == "ADD") {
          IPv6Dns_Pre = COMPLEX_CGI_PREFIX + 'k.';
        }
        else {
          IPv6Dns_Pre = 'k.';
        }
      }
      var IPv6DSLiteFlag = 2;
      if (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") {
        IPv6DSLiteFlag = 1;
      }

      var RdEnable = ('Off' == Wan.RdMode) ? '0' : '1';
      var RdFlag = 2;
      var RdModeFlag = 2;
      if (Wan.ProtocolType.toString() == "IPv4" && Wan.Mode == "IP_Routed" && true == Is6RdSupported()) {
        RdFlag = 1;

        if ('Off' == Wan.RdMode) {
        }
        else if ('Dynamic' == Wan.RdMode) {
          RdModeFlag = 1;
        }
        else {
          if (Wan.EncapMode.toString().toUpperCase() != "PPPOE") {
            RdModeFlag = 1;
          }
        }
      }
      if (("EDIT" == EditFlag.toUpperCase()) && (GetCfgMode().TELMEX == "1")) {
        EnablePriorityPolicy = 2;
        EnablePriority = 2;
        EnableDefPriority = 2;
      }

      var TDE2Flag = (((TDE2ModeFlag == 1) && (Wan.IPv6Enable == 1) && ("IP_Routed" == Wan.Mode)) ? 1 : 2);
      if ('TDE2' == CfgModeWord.toUpperCase()) {
        if (Wan.X_HW_E8C_IPv6PrefixDelegationEnabled == '1') {
          Wan.IPv6PrefixMode = "PrefixDelegation";
        }
        else {
          Wan.IPv6PrefixMode = "None";
        }
      }

      var ConnectionType = Wan.Mode;
      if (IsCmcc_rmsMode()) {
        if (("IP_Routed" == Wan.Mode) && ("PPPoE" == Wan.EncapMode)) {
          ConnectionType = "PPPoE_Routed";
        }
      }

      if ((SupportTtnet()) && (pppoeUserNameAllFlag == false)) {
        Wan.UserName = Wan.UserName + "@ttnet";
      }

      var Option60Submit = 2;
      var IPoEUsernameValue = Wan.X_HW_IPoEName;
      var IPoEPasswordValue = Wan.X_HW_IPoEPassword;
      if (true == Option60DisplayFlag(Wan)) {
        Option60Submit = 1;
        if ("1" != Wan.EnableOption60) {
          IPoEUsernameValue = "";
          IPoEPasswordValue = "";

        }
      }

      if (CfgModeWord.toUpperCase() == "TELMEX" || CfgModeWord.toUpperCase() == "TELMEX5G" || CfgModeWord.toUpperCase() == "TELMEX5GV" || CfgModeWord.toUpperCase() == "TELMEX5GV5") {
        if ("EDIT" == EditFlag.toUpperCase()) {
          IPv6AddrFlag = 2;
          IPv6PrefFlag = 2;
        }
      }

      if (1 == ROSTelecomGlobalFeature
        && ((Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
          || (Wan.ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0)
          || (Wan.ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0))) {
        IPv4IGMPEnableFlag = 1;
      }

      var EnableDscpToPbitTbl = 2;
      if ((1 == DscpFeature) && (PriorityPolicy.toUpperCase() == "DSCPTOPBIT")) {
        EnableDscpToPbitTbl = 1;
      }

      var DscpToPbitTblValue = "InternetGatewayDevice.QueueManagement.X_HW_DscpToPbitMappingTable.1.";
      if ("EDIT" == EditFlag.toUpperCase() && 1 == EnableDscpToPbitTbl) {
        var DscpValue = GetWanList()[selctIndex].X_HW_DscpToPbitTbl;
        if ("" != DscpValue) {
          DscpToPbitTblValue = DscpValue;
        }
      }
      if (IsPTVDFFlag == "1") {
        IPv4PPPoEDnsOverrideEnableFlag = 1;
        DnsStrFlag = 1;
        Wan.IPv4DNSOverrideSwitch = getRadioVal('sourcemode');
        DnsStr = getValue('primarydns') + ',' + getValue('secondarydns');

      }
      if (IsSAFARICOMFlag == "1") {
        IPv4PPPoEDnsOverrideEnableFlag = 1;
        DnsStrFlag = 1;
        Wan.IPv4DNSOverrideSwitch = getCheckVal('IPv4DNSOverrideSwitch');
        DnsStr = getValue('IPv4PrimaryDNSServer') + ',' + getValue('IPv4SecondaryDNSServer');

      }

      if (IsTedata == 1) {
        Wan.UserName = Wan.UserName + "@tedata.net.eg";
      }
      var wanNameFlag = 2;
      if ((showWanName == "1") && (EditFlag == "ADD")) {
        wanNameFlag = 1;
      }

      var enableUnnumberedFlag = 2;
      var unnumberedIpAddressFlag = 2;
      var unnumberedSubnetMaskFlag = 2;
      if ((SupportUnnumberIp(Wan) == true) && (IsUnnumberedWanExist() == false)) {
        enableUnnumberedFlag = 1;
        if (Wan.EnableUnnumbered == '1') {
          unnumberedIpAddressFlag = 1;
          unnumberedSubnetMaskFlag = 1;
        }
      }

      SpecWanCfgParaList = new Array(new stSpecParaArray('d.domain', '', 2),
        new stSpecParaArray('d.AccessType', '', 2),
        new stSpecParaArray('d.EncapMode', '', 2),
        new stSpecParaArray('d.ProtocolType', '', 2),
        new stSpecParaArray('d.Mode', '', 2),
        new stSpecParaArray('d.EnableVlan', '', 2),
        new stSpecParaArray('d.VlanId', '', 2),
        new stSpecParaArray('d.ServiceList', '', 2),
        new stSpecParaArray('d.PriorityPolicy', '', 2),
        new stSpecParaArray('d.DefaultPriority', '', 2),
        new stSpecParaArray('d.Priority', '', 2),
        new stSpecParaArray('d.IPv4MXU', '', 2),
        new stSpecParaArray('d.UserName', '', 2),
        new stSpecParaArray('d.LcpEchoReqCheck', '', 2),
        new stSpecParaArray('d.IPv4BindLanList', '', 2),
        new stSpecParaArray('d.DstIPForwardingList', '', 2),
        new stSpecParaArray('d.IPForwardModeEnabled', '', 2),
        new stSpecParaArray('d.IPv4AddressMode', '', 2),
        new stSpecParaArray('d.IPv4NATEnable', '', 2),
        new stSpecParaArray('d.NatType', '', 2),
        new stSpecParaArray('d.IPv4VendorId', '', 2),
        new stSpecParaArray('d.IPv4ClientId', '', 2),
        new stSpecParaArray('d.IPv4IPAddress', '', 2),
        new stSpecParaArray('d.IPv4SubnetMask', '', 2),
        new stSpecParaArray('d.IPv4IPAddressSecond', '', 2),
        new stSpecParaArray('d.IPv4SubnetMaskSecond', '', 2),
        new stSpecParaArray('d.IPv4IPAddressThird', '', 2),
        new stSpecParaArray('d.IPv4SubnetMaskThird', '', 2),
        new stSpecParaArray('d.IPv4Gateway', '', 2),
        new stSpecParaArray('d.IPv4DNSOverrideSwitch', '', 2),
        new stSpecParaArray('d.IPv4PrimaryDNS', '', 2),
        new stSpecParaArray('d.IPv4SecondaryDNS', '', 2),
        new stSpecParaArray('d.IPv4DialMode', '', 2),
        new stSpecParaArray('d.IPv4DialIdleTime', '', 2),
        new stSpecParaArray('d.IPv4IdleDisconnectMode', '', 2),
        new stSpecParaArray('d.IPv4WanMVlanId', '', 2),
        new stSpecParaArray('d.EnableLanDhcp', '', 2),
        new stSpecParaArray('d.PingIPAddress', '', 2),
        new stSpecParaArray('d.IPv6PrefixMode', '', 2),
        new stSpecParaArray('d.IPv6StaticPrefix', '', 2),
        new stSpecParaArray('d.IPv6AddressMode', '', 2),
        new stSpecParaArray('d.IPv6ReserveAddress', '', 2),
        new stSpecParaArray('d.IPv6AddressStuff', '', 2),
        new stSpecParaArray('d.IPv6IPAddress', '', 2),
        new stSpecParaArray('d.IPv6AddrMaskLenE8c', '', 2),
        new stSpecParaArray('d.IPv6GatewayE8c', '', 2),
        new stSpecParaArray('d.IPv6SubnetMask', '', 2),
        new stSpecParaArray('d.IPv6Gateway', '', 2),
        new stSpecParaArray('d.IPv6PrimaryDNS', '', 2),
        new stSpecParaArray('d.IPv6SecondaryDNS', '', 2),
        new stSpecParaArray('d.IPv6WanMVlanId', '', 2),
        new stSpecParaArray('d.IPv6DSLite', '', 2),
        new stSpecParaArray('d.IPv6AFTRName', '', 2),
        new stSpecParaArray('d.Option60Enable', '', 2),
        new stSpecParaArray('d.EnableUnnumbered', '', 2),
        new stSpecParaArray('d.UnnumberedIpAddress', '', 2),
        new stSpecParaArray('d.UnnumberedSubnetMask', '', 2),
        (CfgModeWord.toUpperCase() == "ROSUNION") ? new stSpecParaArray('', '', 2) : new stSpecParaArray('d.IPv4EnableMulticast', '', 2),

        new stSpecParaArray(nodePrefix + 'Enable', Wan.Enable, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_IPv4Enable', Wan.IPv4Enable, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_IPv6Enable', Wan.IPv6Enable, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_IPv6MultiCastVLAN', IPv6WanMVlanId, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_SERVICELIST', ServiceList, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_ExServiceList', ExServiceList, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_VLAN', VlanId, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_PRI', Wan.Priority, EnablePriority),
        new stSpecParaArray(nodePrefix + 'X_HW_PriPolicy', PriorityPolicy, EnablePriorityPolicy),
        new stSpecParaArray(nodePrefix + 'X_HW_DscpToPbitTbl', DscpToPbitTblValue, EnableDscpToPbitTbl),
        new stSpecParaArray(nodePrefix + 'X_HW_DefaultPri', Wan.DefaultPriority, EnableDefPriority),
        new stSpecParaArray(nodePrefix + 'ConnectionType', ConnectionType, 1),
        new stSpecParaArray(nodePrefix + 'X_HW_LanDhcpEnable', Wan.EnableLanDhcp, EnableLanDhcpFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_IPForwardList', Wan.DstIPForwardingList, DstIPForwardingListFlag),
        new stSpecParaArray(nodePrefix+'X_HW_CU_IPForwardModeEnabled',Wan.IPForwardModeEnabled, IPForwardModeEnabledFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_MultiCastVLAN', IPv4WanMVlanId, 1),
        (isUnicomTr069orVoipWan() == true) ? new stSpecParaArray('', '', 1) : new stSpecParaArray(nodePrefix + 'NATEnabled', Wan.IPv4NATEnable, IPv4NATEnableFlag),
        (isUnicomTr069orVoipWan() == true) ? new stSpecParaArray('', '', 1) : new stSpecParaArray(nodePrefix + 'X_HW_NatType', Wan.NatType, NatTypeFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_E8C_IPv6PrefixDelegationEnabled', Wan.X_HW_E8C_IPv6PrefixDelegationEnabled, TDE2Flag),
        new stSpecParaArray(nodePrefix + 'X_HW_UnnumberedModel', Wan.X_HW_UnnumberedModel, TDE2Flag),
        new stSpecParaArray(nodePrefix + 'X_HW_TDE_IPv6AddressingType', Wan.X_HW_TDE_IPv6AddressingType, TDE2Flag),
        new stSpecParaArray(nodePrefix + 'X_HW_DHCPv6ForAddress', Wan.X_HW_DHCPv6ForAddress, TDE2Flag),
        (CfgModeWord.toUpperCase() != "ROSUNION") ? new stSpecParaArray('', '', 1) : new stSpecParaArray(nodePrefix + 'X_HW_IGMPEnable', Wan.X_HW_IGMPEnable, 1),
        new stSpecParaArray(nodePrefix + 'Username', Wan.UserName, UsernameFlag),
        new stSpecParaArray(nodePrefix + 'Password', Wan.Password, PasswordFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_BridgeEnable', Wan.X_HW_BridgeEnable, BridgeenableFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_IPoEName', IPoEUsernameValue, Option60Submit),
        new stSpecParaArray(nodePrefix + 'X_HW_IPoEPassword', IPoEPasswordValue, Option60Submit),

        new stSpecParaArray(nodePrefix + 'X_HW_LcpEchoReqCheck', Wan.LcpEchoReqCheck, LcpEchoReqCheckFlag),
        new stSpecParaArray(nodePrefix + 'ConnectionTrigger', Wan.IPv4DialMode, IPv4DialModeFlag),
        new stSpecParaArray(nodePrefix + 'IdleDisconnectTime', Wan.IPv4DialIdleTime, IPv4DialIdleTimeFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_IdleDetectMode', Wan.IPv4IdleDisconnectMode, IPv4IdleDisconnectModeFlag),
        new stSpecParaArray(nodePrefix + 'DNSEnabled', '1', DNSEnabledFlag),
        new stSpecParaArray(nodePrefix + 'MaxMRUSize', MXUSize, MRUFlag),
        new stSpecParaArray(nodePrefix + 'MaxMTUSize', MXUSize, MTUFlag),
        (CfgModeWord.toUpperCase() == "ROSUNION") ? new stSpecParaArray('', '', 2) : new stSpecParaArray(nodePrefix + 'X_HW_IGMPEnable', Wan.IPv4EnableMulticast, IPv4IGMPEnableFlag),
        new stSpecParaArray(nodePrefix + 'AddressingType', Wan.IPv4AddressMode, AddressingTypeFlag),
        new stSpecParaArray(nodePrefix + 'ExternalIPAddress', Wan.IPv4IPAddress, IPv4IPAddressFlag),
        new stSpecParaArray(nodePrefix + 'SubnetMask', Wan.IPv4SubnetMask, IPv4SubnetMaskFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_2nd_IPAddress', Wan.IPv4IPAddressSecond, IPv4NewIPAddressFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_2nd_SubnetMask', Wan.IPv4SubnetMaskSecond, IPv4NewSubnetMaskFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_3rd_IPAddress', Wan.IPv4IPAddressThird, IPv4NewIPAddressFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_3rd_SubnetMask', Wan.IPv4SubnetMaskThird, IPv4NewSubnetMaskFlag),
        new stSpecParaArray(nodePrefix + 'DefaultGateway', Wan.IPv4Gateway, IPv4GatewayFlag),
        new stSpecParaArray(nodePrefix + 'DNSOverrideAllowed', Wan.IPv4DNSOverrideSwitch, IPv4PPPoEDnsOverrideEnableFlag),
        new stSpecParaArray(nodePrefix + 'DNSServers', DnsStr, DnsStrFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_VenderClassID', Wan.IPv4VendorId, IPv4VendorIdFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_ClientID', Wan.IPv4ClientId, IPv4ClientIdFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_BindPhyPortInfo', Bindlist2, BindListFlag),
        new stSpecParaArray(nodePrefix + 'X_HW_NPTv6Enable', Wan.X_HW_NPTv6Enable, nptv6Flag),
        new stSpecParaArray(nodePrefix + 'Name', Wan.Name, wanNameFlag),
        new stSpecParaArray(IPv6Addr_Pre + 'Alias', '', IPv6AddrFlag),
        new stSpecParaArray(IPv6Addr_Pre + 'Origin', Wan.IPv6AddressMode, (TDE2Flag == 1 ? 2 : IPv6AddrFlag)),
        new stSpecParaArray(IPv6Addr_Pre + 'IPAddress', Wan.IPv6IPAddress, IPv6AddrFlag),
        new stSpecParaArray(IPv6Addr_Pre + 'ChildPrefixBits', Wan.IPv6AddressStuff, IPv6AddrFlag),
        new stSpecParaArray(IPv6Addr_Pre + 'AddrMaskLen', Wan.IPv6AddrMaskLenE8c, IPv6AddrFlag),
        new stSpecParaArray(IPv6Addr_Pre + 'DefaultGateway', Wan.IPv6GatewayE8c, IPv6AddrFlag),
        new stSpecParaArray(IPv6Addr_Pre + 'UnnumberredWanReserveAddress', Wan.IPv6ReserveAddress, IPv6ReserveAddrFlag),

        new stSpecParaArray(IPv6Pref_Pre + 'Alias', '', IPv6PrefFlag),
        new stSpecParaArray(IPv6Pref_Pre + 'Origin', Wan.IPv6PrefixMode, IPv6PrefFlag),
        new stSpecParaArray(IPv6Pref_Pre + 'Prefix', Wan.IPv6StaticPrefix, IPv6PrefFlag),

        new stSpecParaArray(IPv6Dns_Pre + 'DNSServer', DnsServer, IPv6DnsFlag),
        new stSpecParaArray(IPv6Dns_Pre + 'Interface', domainTowanname(Wan.domain), IPv6DnsInterfaceFlag),
        new stSpecParaArray(IPv6Dns_Pre + 'X_HW_OverrideAllowed', OverrideAllowed, OverrideAllowedFlag),

        new stSpecParaArray("j.WorkMode", Wan.IPv6DSLite, IPv6DSLiteFlag),
        new stSpecParaArray("j.AFTRName", Wan.IPv6AFTRName, IPv6DSLiteFlag),

        new stSpecParaArray("r.Enable", RdEnable, RdFlag),
        new stSpecParaArray("r.RdMode", Wan.RdMode, RdModeFlag),

        new stSpecParaArray("g.Enable", Wan.EnableUnnumbered, enableUnnumberedFlag),
        new stSpecParaArray("g.IPAddress", Wan.UnnumberedIpAddress, unnumberedIpAddressFlag),
        new stSpecParaArray("g.SubnetMask", Wan.UnnumberedSubnetMask, unnumberedSubnetMaskFlag)
      );
      FillSysFormXDSpec(Wan, nodePrefix, SpecWanCfgParaList);

    }

    function FillForm(Parameter, Wan) {
      if (IsAdminUser() || (isSuportPolnetia == "1") || (CfgModeWord.toUpperCase() == 'RDSAP') || (curCfgModeWord.toUpperCase() == 'BELTELECOM2')) {
        FillSysForm(Parameter, Wan);
      }
      else {
        if ((IsLanUpCanOper() == true) || (tedataGuide == 1) || (oteFlag == "1") || (IsEnWebUserModifyWan() == true)) {
          FillSysForm(Parameter, Wan);
        }
        else {
          FillUserForm(Parameter, Wan);
        }
      }
    }

    function OnChangeEncapMode(ControlObject) {
      if (((curCfgModeWord.toUpperCase() == "CNT") || (curCfgModeWord.toUpperCase() == 'CNT2')) && (EditFlag == "ADD")) {
        var Wan = GetCurrentWan();
        if (getRadioVal('EncapMode') == "PPPoE") {
          Wan.ProtocolType = "IPv4/IPv6";
          Wan.IPv4Enable = "1";
          Wan.IPv6Enable = "1";
          Wan.ServiceList = "TR069_INTERNET";
          setSelect("ProtocolType", "IPv4/IPv6");
          setSelect("ServiceList", "TR069_INTERNET");
        } else {
          Wan.ProtocolType = "IPv4";
          Wan.IPv4Enable = "1";
          Wan.IPv6Enable = "0";
          Wan.ServiceList = "VOIP";
          setSelect("ProtocolType", "IPv4");
          setSelect("ServiceList", "VOIP");
        }
      }
      setText('IPv4PrimaryDNSServer', '');
      setText('IPv4SecondaryDNSServer', '');

      OnChangeUI(ControlObject);
    }

    function OnChangeIPv4AddressType(ControlObject) {
      setText('IPv4PrimaryDNSServer', '');
      setText('IPv4SecondaryDNSServer', '');

      OnChangeUI(ControlObject);
    }

    var OverrideAllowed = 0;
    function OnChangeOverrideAllowed() {
      OverrideAllowed = getCheckVal('IPV6OverrideAllowed');
      if (0 == OverrideAllowed) {
        if (IsSAFARICOMFlag != 1) {
          setDisplay("IPv6PrimaryDNSServerRow", 1);
          setDisplay("IPv6SecondaryDNSServerRow", 1);
          document.getElementById("IPV6sourcemode1").checked = true;
          setDisable("IPv6PrimaryDNSServer", 1);
          setDisable("IPv6SecondaryDNSServer", 1);
          setText('IPv6PrimaryDNSServer', '');
          setText('IPv6SecondaryDNSServer', '');
        }
        else {
          setDisplay("IPv6PrimaryDNSServerRow", 0);
          setDisplay("IPv6SecondaryDNSServerRow", 0);
          if (IsDNSLockEnable == 1) {
            setDisable("IPv6PrimaryDNSServer", 1);
            setDisable("IPv6SecondaryDNSServer", 1);
          }
          else {
            setDisable("IPv6PrimaryDNSServer", 0);
            setDisable("IPv6SecondaryDNSServer", 0);
          }
        }
      }
      else {
        setDisplay("IPv6PrimaryDNSServerRow", OverrideAllowed);
        setDisplay("IPv6SecondaryDNSServerRow", OverrideAllowed);
        if (IsSAFARICOMFlag != 1) {
          document.getElementById("IPV6sourcemode2").checked = true;
          setDisable("IPv6PrimaryDNSServer", 0);
          setDisable("IPv6SecondaryDNSServer", 0);
        }
        else {
          if (IsDNSLockEnable == 1) {
            setDisable("IPv6PrimaryDNSServer", 1);
            setDisable("IPv6SecondaryDNSServer", 1);
          }
          else {
            setDisable("IPv6PrimaryDNSServer", 0);
            setDisable("IPv6SecondaryDNSServer", 0);
          }
        }
      }
    }

    function loadJS(url, succ) {
      var domScr = document.createElement('script');
      succ = succ || function () { };
      domScr.src = url;
      if (navigator.userAgent.indexOf("MSIE") > 0) {
        domScr.onreadystatechange = function () {
          if (this.readyState === 'loaded' || this.readyState === 'complete') {
            succ();
            this.onload = this.onreadystatechange = null;
            this.parentNode.removeChild(this);
          }
        }
      } else {
        domScr.onload = function () {
          succ();
          this.onload = this.onreadystatechange = null;
          this.parentNode.removeChild(this);
        }
      }
      document.getElementsByTagName('head')[0].appendChild(domScr);
    }

    function ChangePPPUsernameToAll() {
      pppoeUserNameAllFlag = true;
      document.getElementById('UserNameTipsAll').innerHTML = "<span>" + Languages['wan_pppoeusernameTips3_ttnet'] + "</span>";
      setDisplay("UserNameTipsAllRow", 1);
      setDisplay("UserNameCkick_span_blackRow", 0);
      setDisplay("UserNameRemark", 0);
    }

    if (stbport > 0) {
      Languages['LAN' + stbport] = Languages['LANSTB'];
    }

    if ('1' == TDESME2Modeflg) {
      Languages['IPv4IPAddress'] = Languages['IPv4IPAddress_1'];
      Languages['IPv4SubnetMask'] = Languages['IPv4SubnetMask_1'];
    }

    function IsCnt() {
      if (isIPV6DemandWan == 1) {
        return true;
      }

      return false;
    }

  </script>
  <div id="cover"
    style="display:none;position: fixed;width: 100%;height: 100%;top:0px;left:0px;background: rgba(0, 0, 0, 0.5);">
  </div>
  <div
    style="background: rgb(59, 59, 61);width:500px;height:220px;margin:0 auto;display:none;position:relative;z-index:2;"
    id="toast">
    <div id="checkForm" style="width: 70%;margin: 0 auto;padding-top:50px;">
      <div style="margin-bottom:25px;">
        <label for="password" style="width:100%;display:inline-block;">
          <script>document.write(Languages['inputtips']);</script>
        </label>
      </div>
      <div>
        <input type="password" id="modepassword" style="width:100%;height:30px;text-indent:10px;">
      </div>
      <p style="text-align:center;width:100%;color:red;margin-bottom:10px;" id="checkWord"></p>
      <div style="text-align:center;">
        <input type="submit" value="提交" id="button" onclick="CheckPassword();" style="width:90px;height:40px;">
      </div>
    </div>
  </div>
  <form id="ConfigForm">
    <fieldset id="EnableForm" style="border:none">
      <div class="list_table_spread"></div>
      <table id="ConfigPanel" width="100%" cellspacing="1" cellpadding="0">
        <li id="BasicInfoBar" RealType="HorizonBar" DescRef="WanBasicInfo" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />
        <li id="WanDomain" RealType="TextBox" DescRef="VlanId" RemarkRef="WanVlanIdRemark" ErrorMsgRef="Empty"
          Require="TRUE" BindField="d.domain" InitValue="Empty" />
        <li id="WanSwitch" RealType="CheckBox" DescRef="EnableWanConnection" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="y.Enable" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <script>
          if (CfgModeWord.toUpperCase() == 'ROSUNION') {
            document.write('<li id="RTKIGMPProxySwitch" RealType="CheckBox" DescRef="EnableRTKIGMPProxy" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="d.X_HW_IGMPEnable" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI"/>');
          }
        </script>
        <li id="RadioWanPSEnable" RealType="CheckBox" DescRef="EnableWanConnection" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.RadioWanPSEnable" InitValue="Empty"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="AccessType" RealType="DropDownList" DescRef="AccessType" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.AccessType"
          InitValue="[{TextRef:'Wireless',Value:'0'},{TextRef:'PON',Value:'1'}]" ClickFuncApp="onchange=OnChangeUI" />
        <script language="JavaScript" type="text/javascript">
          if (IsXdUpMode() || (isSupportLte == "1")) {
            document.write("\<li   id=\"WANAccessType\"   RealType=\"DropDownList\"    DescRef=\"AccessType\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"f.WanAccessType\"    InitValue=\"Empty\" ClickFuncApp=\"onchange=OnChangeUI\"\/\> ");
          }
          if (showWanName == '1') {
            document.write("\<li   id=\"WanName\"   RealType=\"TextBox\"    DescRef=\"WanName\"   RemarkRef=\"WanNameDes\"    ErrorMsgRef=\"Empty\"    Require=\"TRUE\"    BindField=\"y.Name\"    InitValue=\"Empty\" MaxLength=\"64\"\/\> ");
          }
        </script>
        <li id="EncapMode" RealType="RadioButtonList" DescRef="EncapMode" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.EncapMode"
          InitValue="[{TextRef:'IPoE',Value:'IPoE'},{TextRef:'PPPoE',Value:'PPPoE'}]"
          ClickFuncApp="onclick=OnChangeEncapMode" />
        <li id="ProtocolType" RealType="DropDownList" DescRef="WanProtocolType" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.ProtocolType"
          InitValue="[{TextRef:'IPv4',Value:'IPv4'},{TextRef:'IPv6',Value:'IPv6'},{TextRef:'IPv4IPv6',Value:'IPv4/IPv6'}]"
          ClickFuncApp="onchange=OnChangeUI" />
        <li id="WanMode" RealType="DropDownList" DescRef="WanMode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
          BindField="d.Mode"
          InitValue="[{TextRef:'IP_Routed',Value:'IP_Routed'},{TextRef:'IP_Bridged',Value:'IP_Bridged'}]"
          ClickFuncApp="onchange=OnChangeUI" />
        <script>
          if (checkHon()) {
            document.write("\<li   id=\"ServiceList\" RealType=\"DropDownList\" DescRef=\"WanServiceList\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.ServiceList\" InitValue=\"[{TextRef:'TR069',Value:'TR069'},{TextRef:'INTERNET',Value:'INTERNET'},{TextRef:'TR069_INTERNET',Value:'TR069_INTERNET'},{TextRef:'VOIP',Value:'VOIP'},{TextRef:'TR069_VOIP',Value:'TR069_VOIP'},{TextRef:'VOIP_INTERNET',Value:'VOIP_INTERNET'},{TextRef:'TR069_VOIP_INTERNET',Value:'TR069_VOIP_INTERNET'},{TextRef:'IPTV',Value:'IPTV'},{TextRef:'OTHER',Value:'OTHER'}, {TextRef:'VOIP_IPTV',Value:'VOIP_IPTV'}, {TextRef:'TR069_IPTV',Value:'TR069_IPTV'},{TextRef:'TR069_VOIP_IPTV',Value:'TR069_VOIP_IPTV'},{TextRef:'IPTV_INTERNET',Value:'IPTV_INTERNET'},{TextRef:'VOIP_IPTV_INTERNET',Value:'VOIP_IPTV_INTERNET'},{TextRef:'TR069_IPTV_INTERNET',Value:'TR069_IPTV_INTERNET'},{TextRef:'TR069_VOIP_IPTV_INTERNET',Value:'TR069_VOIP_IPTV_INTERNET'},{TextRef:'HON',Value:'HON'}]\" ClickFuncApp=\"onchange=OnChangeUI\"\/\> ");
          } else {
            document.write("\<li   id=\"ServiceList\" RealType=\"DropDownList\" DescRef=\"WanServiceList\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.ServiceList\" InitValue=\"[{TextRef:'TR069',Value:'TR069'},{TextRef:'INTERNET',Value:'INTERNET'},{TextRef:'TR069_INTERNET',Value:'TR069_INTERNET'},{TextRef:'VOIP',Value:'VOIP'},{TextRef:'TR069_VOIP',Value:'TR069_VOIP'},{TextRef:'VOIP_INTERNET',Value:'VOIP_INTERNET'},{TextRef:'TR069_VOIP_INTERNET',Value:'TR069_VOIP_INTERNET'},{TextRef:'IPTV',Value:'IPTV'},{TextRef:'OTHER',Value:'OTHER'}, {TextRef:'VOIP_IPTV',Value:'VOIP_IPTV'}, {TextRef:'TR069_IPTV',Value:'TR069_IPTV'},{TextRef:'TR069_VOIP_IPTV',Value:'TR069_VOIP_IPTV'},{TextRef:'IPTV_INTERNET',Value:'IPTV_INTERNET'},{TextRef:'VOIP_IPTV_INTERNET',Value:'VOIP_IPTV_INTERNET'},{TextRef:'TR069_IPTV_INTERNET',Value:'TR069_IPTV_INTERNET'},{TextRef:'TR069_VOIP_IPTV_INTERNET',Value:'TR069_VOIP_IPTV_INTERNET'}]\" ClickFuncApp=\"onchange=OnChangeUI\"\/\> ");
          }
        </script>
        <li id="VlanSwitch" RealType="CheckBox" DescRef="EnableVlan" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.EnableVlan" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <script language="JavaScript" type="text/javascript">
          if ((curCfgModeWord.toUpperCase() == 'TURKCELL2') || (ttNet == "1")) {
            document.write("\<li id=\"VlanId\" RealType=\"TextBox\" DescRef=\"VlanId\" RemarkRef=\"WanVlanId\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"d.VlanId\" InitValue=\"Empty\"\/\>");
          } else {
            document.write("\<li id=\"VlanId\" RealType=\"TextBox\" DescRef=\"VlanId\" RemarkRef=\"WanVlanIdRemark\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"d.VlanId\" InitValue=\"Empty\"\/\>");
          }
        </script>
        <li id="IPv4WanMVlanIdGlobeUser" RealType="TextBox" DescRef="WanMVlanId" RemarkRef="WanMVlanIdRemark"
          ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />
        <li id="PriorityPolicy" RealType="DropDownList" DescRef="PriorityPolicy" RemarkRef="Dscptips"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.PriorityPolicy"
          InitValue="[{TextRef:'Specified',Value:'Specified'},{TextRef:'CopyFromIPPrecedence',Value:'CopyFromIPPrecedence'},{TextRef:'DscpToPbit',Value:'DscpToPbit'}]"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="DefaultVlanPriority" RealType="DropDownList" DescRef="DefaultVlanPriority" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.DefaultPriority"
          InitValue="[{TextRef:'Priority0',Value:'0'}, {TextRef:'Priority1',Value:'1'}, {TextRef:'Priority2',Value:'2'}, {TextRef:'Priority3',Value:'3'}, {TextRef:'Priority4',Value:'4'}, {TextRef:'Priority5',Value:'5'}, {TextRef:'Priority6',Value:'6'}, {TextRef:'Priority7',Value:'7'}]"
          ClickFuncApp="onchange=OnChangeUI" />

        <li id="VlanPriority" RealType="DropDownList" DescRef="VlanPriority" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.Priority"
          InitValue="[{TextRef:'Priority0',Value:'0'}, {TextRef:'Priority1',Value:'1'}, {TextRef:'Priority2',Value:'2'}, {TextRef:'Priority3',Value:'3'}, {TextRef:'Priority4',Value:'4'}, {TextRef:'Priority5',Value:'5'}, {TextRef:'Priority6',Value:'6'}, {TextRef:'Priority7',Value:'7'}]"
          ClickFuncApp="onchange=OnChangeUI" />
        <li id="IPv4MXU" RealType="TextBox" DescRef="IPv4MXU" RemarkRef="IPv4MXUHELP" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv4MXU" InitValue="Empty" />
        <script>
          if (curWebFrame == 'frame_argentina') {
            document.write('<li id="UserName" RealType="TextBox" DescRef="IPv4UserName" RemarkRef="IPv4UserNameHELP" ErrorMsgRef="Empty" Require="FALSE" BindField="d.UserName" InitValue="Empty" MaxLength="128"/>');
          } else if (SupportTtnet()) {
            document.write('<li id="UserName" RealType="TextBox" DescRef="IPv4UserName" RemarkRef="wan_pppoeusernameTips2_ttnet" ErrorMsgRef="Empty" Require="FALSE" BindField="d.UserName" InitValue="Empty" MaxLength="64"/>');
            document.write('<li id="UserNameCkick_span_black" RealType="SmartBoxList" DescRef="Empty" RemarkRef="wan_pppoeusernameTips1_ttnet" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="[{Item:[{AttrName:\'id\', AttrValue:\'UserNameCkickButton\'},{AttrName:\'type\', AttrValue:\'button\'},{AttrName:\'value\', AttrValue:\'click here\'},{AttrName:\'onClick\', AttrValue:\'ChangePPPUsernameToAll()\'}]}]"/>');
            document.write('<li id="UserNameTipsAll" RealType="HtmlText" DescRef="Empty" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />');
          } else {
            document.write('<li id="UserName" RealType="TextBox" DescRef="IPv4UserName" RemarkRef="IPv4UserNameHELP" ErrorMsgRef="Empty" Require="FALSE" BindField="d.UserName" InitValue="Empty" MaxLength="64"/>');
          }
        </script>
        <li id="Password" RealType="TextBox" DescRef="IPv4Password" RemarkRef="IPv4PasswordHELP" ErrorMsgRef="Empty"
          Require="FALSE" BindField="y.Password" InitValue="Empty" MaxLength="64" autocomplete="off" />
        <li id="PPPAuthenticationProtocol" RealType="TextBox" DescRef="PPPAuthenticationProtocol" RemarkRef=""
          ErrorMsgRef="Empty" Require="FALSE" BindField=""
          InitValue="[{TextRef:'PPPAuthenProtolValue',Value:'PAP/CHAP'}]" MaxLength="64" />
        <li id="Option60Enable" RealType="CheckBox" DescRef="EnableOption60Web" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.EnableOption60" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <li id="IPoEUserName" RealType="TextBox" DescRef="IPv4UserName" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="y.X_HW_IPoEName" InitValue="Empty" MaxLength="128" />
        <li id="IPoEPassword" RealType="TextBox" DescRef="IPv4Password" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="y.X_HW_IPoEPassword" InitValue="Empty" MaxLength="128" />
        <li id="LcpEchoReqCheck" RealType="CheckBox" DescRef="LcpEchoReqCheck" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.LcpEchoReqCheck" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <script language="JavaScript" type="text/javascript">
          if (CfgModeWord.toUpperCase() == "DGRWIND") {
            document.write("\<li id=\"BridgeEnable\" RealType=\"CheckBox\" DescRef=\"BridgeEnable\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.X_HW_BridgeEnable\" InitValue=\"Empty\"\/\>");
          }
          if (true == IsFreInSsidName()) {
            document.write("\<li   id=\"IPv4BindLanList\"   RealType=\"CheckBoxList\"    DescRef=\"IPv4BindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4BindLanList\"    InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'},{TextRef:'LAN5',Value:'LAN5'},{TextRef:'LAN6',Value:'LAN6'},{TextRef:'LAN7',Value:'LAN7'},{TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID4',Value:'<br>'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
          else if (isAisBackhaul()) {
             document.write("\<li   id=\"IPv4BindLanList\"   RealType=\"CheckBoxList\"    DescRef=\"IPv4BindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4BindLanList\"    InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'},{TextRef:'LAN5',Value:'LAN5'},{TextRef:'LAN6',Value:'LAN6'},{TextRef:'LAN7',Value:'LAN7'},{TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'},{TextRef:'SSID9',Value:'SSID9'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
          else if (true == IsSixteenSsidUser()) {
            document.write("\<li   id=\"IPv4BindLanList\"   RealType=\"CheckBoxList\"    DescRef=\"IPv4BindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4BindLanList\"    InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'},{TextRef:'LAN5',Value:'LAN5'},{TextRef:'LAN6',Value:'LAN6'},{TextRef:'LAN7',Value:'LAN7'},{TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'},{TextRef:'SSID8',Value:'<br>'},{TextRef:'SSID9',Value:'SSID9'},{TextRef:'SSID10',Value:'SSID10'},{TextRef:'SSID11',Value:'SSID11'},{TextRef:'SSID12',Value:'SSID12'},{TextRef:'SSID13',Value:'SSID13'},{TextRef:'SSID14',Value:'SSID14'},{TextRef:'SSID15',Value:'SSID15'},{TextRef:'SSID16',Value:'SSID16'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
          else if (1 == WPS20AuthSupported) {
            document.write("\<li   id=\"IPv4BindLanList\"   RealType=\"CheckBoxList\"    DescRef=\"IPv4BindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4BindLanList\"    InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'},{TextRef:'LAN5',Value:'LAN5'},{TextRef:'LAN6',Value:'LAN6'},{TextRef:'LAN7',Value:'LAN7'},{TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'},{TextRef:'SSID9',Value:'SSID9'},{TextRef:'SSID10',Value:'SSID10'},{TextRef:'SSID11',Value:'SSID11'},{TextRef:'SSID12',Value:'SSID12'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
          else {
            if (1 == iponlyflg) {
              document.write("\<li   id=\"IPv4BindLanList\"   RealType=\"CheckBoxList\"    DescRef=\"IPv4BindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4BindLanList\"    InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'},{TextRef:'LAN5EXT1',Value:'LAN5'},{TextRef:'LAN6',Value:'LAN6'},{TextRef:'LAN7',Value:'LAN7'},{TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
            }
            else {
              document.write("\<li   id=\"IPv4BindLanList\"   RealType=\"CheckBoxList\"    DescRef=\"IPv4BindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4BindLanList\"    InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'},{TextRef:'LAN5',Value:'LAN5'},{TextRef:'LAN6',Value:'LAN6'},{TextRef:'LAN7',Value:'LAN7'},{TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
            }

          }
          if (supportOnuBind == 1) {
            document.write("\<li   id=\"DownPon_checkbox\"   RealType=\"CheckBox\"    DescRef=\"DownPonBindOptions\"   RemarkRef=\"Empty\"    ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"Empty\"    InitValue=\"[{TextRef:'DownPON1',Value:'PON1'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }

          if (isUnicomNetworkExpress == '1') {
            document.write("\<li id=\"IPForwardModeEnabled\" RealType=\"CheckBox\" DescRef=\"IPForwardListEnable\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.IPForwardModeEnabled\" InitValue=\"Empty\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
        </script>
        <li id="Wan_Pon_checkbox" RealType="CheckBoxList" DescRef="IPv4PONBindOptions" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="[{TextRef:'PONBindRemark',Value:'PON1'}]"/>
        <li id="DstIPForwardingList" RealType="TextArea" DescRef="DstIPForwardingCfg" RemarkRef="DstIPForwardingHelp"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.DstIPForwardingList" InitValue="Empty" MaxLength="8192" />

        <script language="JavaScript" type="text/javascript">
          if ('DNZTELECOM2WIFI' == CfgModeWord.toUpperCase()) {
            document.write("\<li   id=\"SwitchMode\"                RealType=\"RadioButtonList\"    DescRef=\"DataCardInternetMode\"                RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"s.SwitchMode\"         InitValue=\"[{TextRef:'BackupConfirmMode',Value:'ManualSwitch'},{TextRef:'BackupAutoMode',Value:'Auto'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
          else {
            document.write("\<li   id=\"SwitchMode\"                RealType=\"RadioButtonList\"    DescRef=\"SwitchMode\"                RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"s.SwitchMode\"         InitValue=\"[{TextRef:'ManualWireless',Value:'ManualProtect'},{TextRef:'bbsp_auto',Value:'Auto'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          }
          if (isSupportLte == "1") {
            document.write("\<li   id=\"BackupMode\"                RealType=\"RadioButtonList\"    DescRef=\"LteSwitchMode\"                RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"b.BackupMode\"         InitValue=\"[{TextRef:'LteAlwaysOn',Value:'0'},{TextRef:'LteAutoBackUp',Value:'1'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
            document.write("\<li   id=\"BackupDelayTime\"           RealType=\"TextBox\"            DescRef=\"LteSwitchDelayTime\"           RemarkRef=\"SwitchDelayTimeLteRemark\"    ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"b.BackupDelayTime\"        InitValue=\"Empty\"/>");
            document.write("\<li   id=\"LteProfile\"                RealType=\"TextBox\"            DescRef=\"LteProfile\"                   RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"   BindField=\"d.X_HW_LteProfile\"        InitValue=\"Empty\"/>");
          }
          if (isSupportAboard == "1") {
              document.write("\<li id=\"SwitchDelayTime\" RealType=\"TextBox\" DescRef=\"SwitchDelayTime\" RemarkRef=\"SwitchDelayTimeRemarkLTE\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"s.SwitchDelayTime\" InitValue=\"Empty\"/>");
          } else {
              document.write("\<li id=\"SwitchDelayTime\" RealType=\"TextBox\" DescRef=\"SwitchDelayTime\" RemarkRef=\"SwitchDelayTimeRemark\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"s.SwitchDelayTime\" InitValue=\"Empty\"/>");
          }
        </script>
        <li id="PingIPAddress" RealType="TextBox" DescRef="PingIPAddress" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.PingIPAddress" InitValue="Empty" MaxLength="63" />

        <li id="DialInfoBar" RealType="HorizonBar" DescRef="DialInfo" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />
        <script language="JavaScript" type="text/javascript">
          function getBandRangeHtml() {
            var bandRangeStr = '<%HW_WEB_GetSPEC(LTE_SPEC_BAND_RANGE.STRING);%>';
            if (bandRangeStr == "") {
              return "";
            }

            var bandRangeArr = getLTEBandStrToArr(bandRangeStr);
            var bandRangeHtml = "[";
            for (var i = 0; i < bandRangeArr.length; i++) {
              bandRangeHtml += "{TextRef:'" + bandRangeArr[i] + "',Value:'" + bandRangeArr[i] + "'},";
            }
            bandRangeHtml = bandRangeHtml.substr(0, bandRangeHtml.length - 1);
            bandRangeHtml += "]";
            return bandRangeHtml;
          }
          if (isSupportLte == "1") {
            document.write("\<li id=\"RadioWanUsername\" RealType=\"TextBox\" DescRef=\"LteUserName\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.RadioWanUsername\" InitValue=\"Empty\" MaxLength=\"31\"/>");
            document.write("\<li id=\"RadioWanPassword\" RealType=\"TextBox\" DescRef=\"LtePassWord\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.RadioWanPassword\" InitValue=\"Empty\" MaxLength=\"31\"/>");

            var bandRangeHtml = getBandRangeHtml();
            document.write("\<li id=\"lteband\" RealType=\"CheckBoxList\" DescRef=\"lteband\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"" + bandRangeHtml + "\" ClickFuncApp=\"onclick=OnChangeUI\"\/\> ");
          } else {
            document.write("\<li id=\"RadioWanUsername\" RealType=\"TextBox\" DescRef=\"IPv4UserName\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.RadioWanUsername\" InitValue=\"Empty\" MaxLength=\"31\"/>");
            document.write("\<li id=\"RadioWanPassword\" RealType=\"TextBox\" DescRef=\"IPv4Password\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.RadioWanPassword\" InitValue=\"Empty\" MaxLength=\"31\"/>");
          }
        </script>
        <li id="APN" RealType="TextBox" DescRef="APN" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
          BindField="t.APN" InitValue="Empty" MaxLength="31" />
        <li id="DialNumber" RealType="TextBox" DescRef="DialNumber" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="t.DialNumber" InitValue="Empty" MaxLength="15" />
        <li id="TriggerMode" RealType="RadioButtonList" DescRef="TriggerMode" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="t.TriggerMode"
          InitValue="[{TextRef:'AlwaysOnline',Value:'AlwaysOn'},{TextRef:'OnDemand',Value:'OnDemand'}]"
          ClickFuncApp="onclick=OnChangeUI" />
        <script language="JavaScript" type="text/javascript">
          if (IsXdUpMode()) {
            document.write("\<li   id=\"LinkInfoBar\"               RealType=\"HorizonBar\"         DescRef=\"WanLinkInfo\"               RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"Empty\"              InitValue=\"Empty\"\/\> ");
            document.write("\<li   id=\"WANPVC\"                    RealType=\"TextBox\"            DescRef=\"WANPVC\"                    RemarkRef=\"WanPVCRemark\"              ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"e.DestinationAddress\"             InitValue=\"Empty\"\/\> ");
            document.write("\<li   id=\"LinkMode\"                  RealType=\"DropDownList\"       DescRef=\"LinkMode\"                  RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"e.LinkType\"         InitValue=\"[{TextRef:'EoA',Value:'EoA'},{TextRef:'PPPoA',Value:'PPPoA'},{TextRef:'IPoA',Value:'IPoA'}]\" ClickFuncApp=\"onchange=OnChangeUI\"\/\> ");
            document.write("\<li   id=\"ServiceType\"               RealType=\"DropDownList\"       DescRef=\"AccessServiceType\"         RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"e.ATMQoS\"         InitValue=\"[{TextRef:'UBR_without_PCR',Value:'UBR'},{TextRef:'UBR_with_PCR',Value:'UBR+'},{TextRef:'CBR',Value:'CBR'},{TextRef:'Non_real_time_VBR',Value:'VBR-nrt'},{TextRef:'Real_time_VBR',Value:'VBR-rt'}]\" ClickFuncApp=\"onchange=OnChangeUI\"\/\> ");
            document.write("\<li   id=\"ATMPeakCellRate\"           RealType=\"TextBox\"            DescRef=\"ATMPeakRate\"               RemarkRef=\"ATMPeakRateRemark\"              ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"e.ATMPeakCellRate\"             InitValue=\"Empty\"     MaxLength=\"5\"\/\> ");
            document.write("\<li   id=\"ATMSustainableCellRate\"    RealType=\"TextBox\"            DescRef=\"ATMSustainableRate\"        RemarkRef=\"ATMSustainableCellRateRemark\"              ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"e.ATMSustainableCellRate\"             InitValue=\"Empty\"    MaxLength=\"5\"\/\>");
            document.write("\<li   id=\"ATMMaximumBurstSize\"       RealType=\"TextBox\"            DescRef=\"ATMMaximumSize\"            RemarkRef=\"ATMMaximumBurstSizeRemark\"              ErrorMsgRef=\"Empty\"    Require=\"TRUE\"     BindField=\"e.ATMMaximumBurstSize\"             InitValue=\"Empty\"  MaxLength=\"6\"\/\> ");
            document.write("\<li   id=\"AccessEncapMode\"           RealType=\"DropDownList\"       DescRef=\"AccessEncapMode\"           RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"e.ATMEncapsulation\"         InitValue=\"[{TextRef:'LLC',Value:'LLC'},{TextRef:'VCMUX',Value:'VCMUX'}]\" ClickFuncApp=\"onchange=OnChangeUI\"\/\> ");
          }
          if (Is3TMode()) {
            document.write("\<li   id=\"IPv4v6WanMVlanId\"               RealType=\"TextBox\"         DescRef=\"WanMVlanId\"               RemarkRef=\"WanMVlanIdRemark\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv4v6WanMVlanId\"              InitValue=\"Empty\"\/\> ");
          }

          if (IsCnt()) {
            document.write('<li   id="IPv4DialMode"              RealType="DropDownList"       DescRef="IPv4DialMode"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="d.IPv4DialMode"       InitValue="[{TextRef:\'IPv4DialModeAlwaysOn\',Value:\'AlwaysOn\'},{TextRef:\'IPv4DialModeManual\',Value:\'Manual\'},{TextRef:\'IPv4DialModeOnDemand\',Value:\'OnDemand\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
            document.write('<li   id="IPv4DialIdleTime"          RealType="TextBox"            DescRef="IPv4IdleTime"              RemarkRef="IPv4IdleTimeRemark" ErrorMsgRef="Empty"    Require="TRUE"     BindField="d.IPv4DialIdleTime"   InitValue="Empty"/>');
            document.write('<li   id="IPv4IdleDisconnectMode"    RealType="DropDownList"       DescRef="IPv4IdleDisconnectMode"    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="d.IPv4IdleDisconnectMode"   InitValue="[{TextRef:\'IPv4IdleDisconnectMode_note1\',Value:\'DetectBidirectionally\'},{TextRef:\'IPv4IdleDisconnectMode_note2\',Value:\'DetectUpstream\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
          }

        </script>

        <li id="WanIPv4InfoBar" RealType="HorizonBar" DescRef="WanIPv4Info" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />
        <li id="IPv4AddressMode" RealType="RadioButtonList" DescRef="WanIpMode" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv4AddressMode"
          InitValue="[{TextRef:'Static',Value:'Static'},{TextRef:'DHCP',Value:'DHCP'},{TextRef:'PPPoE',Value:'PPPoE'}]"
          ClickFuncApp="onclick=OnChangeIPv4AddressType" />
        <li id="IPv4UnnumberedSwitch" RealType="CheckBox" DescRef="EnableUnnumbered" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.EnableUnnumbered" InitValue="Empty"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="IPv4UnnumberedIpAddress" RealType="TextBox" DescRef="UnnumberedIpAddress" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="TRUE" BindField="d.UnnumberedIpAddress" InitValue="Empty" MaxLength="64" />
        <li id="IPv4UnnumberedSubnetMask" RealType="TextBox" DescRef="UnnumberedSubnetMast" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="TRUE" BindField="d.UnnumberedSubnetMask" InitValue="Empty" MaxLength="64" />
        <li id="IPv4NatSwitch" RealType="CheckBox" DescRef="EnableNat" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv4NATEnable" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <li id="IPv4NatType" RealType="DropDownList" DescRef="NatType" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.NatType"
          InitValue="[{TextRef:'Port_Restricted_Cone_NAT',Value:'0'},{TextRef:'Full_Cone_NAT',Value:'1'}]"
          ClickFuncApp="onchange=OnChangeUI" />
        <li id="IPv4VendorId" RealType="TextBox" DescRef="IPv4VendorId" RemarkRef="IPv4VendorIdDes" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv4VendorId" InitValue="Empty" MaxLength="64" />
        <li id="IPv4ClientId" RealType="TextBox" DescRef="IPv4ClientId" RemarkRef="IPv4ClientIdDes" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv4ClientId" InitValue="Empty" MaxLength="64" />
        <li id="IPv4IPAddress" RealType="TextBox" DescRef="IPv4IPAddress" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="d.IPv4IPAddress" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPv4SubnetMask" RealType="TextBox" DescRef="IPv4SubnetMask" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="d.IPv4SubnetMask" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPv4IPAddressSecond" RealType="TextBox" DescRef="IPv4IPAddressSecond" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4IPAddressSecond" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv4SubnetMaskSecond" RealType="TextBox" DescRef="IPv4SubnetMaskSecond" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4SubnetMaskSecond" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv4IPAddressThird" RealType="TextBox" DescRef="IPv4IPAddressThird" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4IPAddressThird" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv4SubnetMaskThird" RealType="TextBox" DescRef="IPv4SubnetMaskThird" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4SubnetMaskThird" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv4DefaultGateway" RealType="TextBox" DescRef="IPv4DefaultGateway" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4Gateway" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPv4DNSOverrideSwitch" RealType="CheckBox" DescRef="EnableDnsOverride" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4DNSOverrideSwitch" InitValue="Empty"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="IPv4PrimaryDNSServer" RealType="TextBox" DescRef="IPv4PrimaryDNSServer" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4PrimaryDNS" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv4SecondaryDNSServer" RealType="TextBox" DescRef="IPv4SecondaryDNSServer" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4SecondaryDNS" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <script language="JavaScript" type="text/javascript">
          if (!IsCnt()) {
            document.write('<li   id="IPv4DialMode"              RealType="DropDownList"       DescRef="IPv4DialMode"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="d.IPv4DialMode"       InitValue="[{TextRef:\'IPv4DialModeAlwaysOn\',Value:\'AlwaysOn\'},{TextRef:\'IPv4DialModeManual\',Value:\'Manual\'},{TextRef:\'IPv4DialModeOnDemand\',Value:\'OnDemand\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
            document.write('<li   id="IPv4DialIdleTime"          RealType="TextBox"            DescRef="IPv4IdleTime"              RemarkRef="IPv4IdleTimeRemark" ErrorMsgRef="Empty"    Require="TRUE"     BindField="d.IPv4DialIdleTime"   InitValue="Empty"/>');
            document.write('<li   id="IPv4IdleDisconnectMode"    RealType="DropDownList"       DescRef="IPv4IdleDisconnectMode"    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="d.IPv4IdleDisconnectMode"   InitValue="[{TextRef:\'IPv4IdleDisconnectMode_note1\',Value:\'DetectBidirectionally\'},{TextRef:\'IPv4IdleDisconnectMode_note2\',Value:\'DetectUpstream\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
          }
        </script>
        <li id="IPv4DialConnectManual" RealType="InputButtonList" DescRef="IPv4DialConnectManual" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"
          InitValue="[{TextRef:'IPv4ManualTextRef',Value:'IPv4ManualConnect'},{TextRef:'IPv4ManualTextRef',Value:'IPv4ManualDisonnect'}]" />
        <script language="JavaScript">
          if (CfgModeWord.toUpperCase() != "ROSUNION") {
            document.write('<li id="IPv4EnableMulticast" RealType="CheckBox" DescRef="EnableMulticast" RemarkRef="Empty"  ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv4EnableMulticast" InitValue="Empty"/>');
          }
        </script>
        <li id="IPv4WanMVlanId" RealType="TextBox" DescRef="WanMVlanId" RemarkRef="WanMVlanIdRemark" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv4WanMVlanId" InitValue="Empty" />
        <li id="LanDhcpSwitch" RealType="CheckBox" DescRef="EnableLanDhcp" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.EnableLanDhcp" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <li id="RDMode" RealType="RadioButtonList" DescRef="Des6RDMode" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="r.RdMode"
          InitValue="[{TextRef:'Off',Value:'Off'},{TextRef:'Auto',Value:'Dynamic'},{TextRef:'Static',Value:'Static'}]"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="RdPrefix" RealType="TextBox" DescRef="Des6RDPrefix" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"
          BindField="r.RdPrefix" InitValue="Empty" />
        <li id="RdPrefixLen" RealType="TextBox" DescRef="Des6RDPrefixLenth" RemarkRef="RDPreLenthReMark"
          ErrorMsgRef="Empty" Require="TRUE" BindField="r.RdPrefixLen" InitValue="Empty" />
        <li id="RdBRIPv4Address" RealType="TextBox" DescRef="Des6RDBrAddr" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="r.RdBRIPv4Address" InitValue="Empty" />
        <li id="RdIPv4MaskLen" RealType="TextBox" DescRef="Des6RDIpv4MaskLenth" RemarkRef="RDIpv4MskLnReMark"
          ErrorMsgRef="Empty" Require="TRUE" BindField="r.RdIPv4MaskLen" InitValue="Empty" />

        <li id="wandnsInfoBar" RealType="HorizonBar" DescRef="wan_dnstitle" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />
        <li id="sourcemode" RealType="RadioButtonList" DescRef="wan_dnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty"
          InitValue="[{TextRef:'wan_dnscarrier',Value:'0'},{TextRef:'wan_dnscustom',Value:'1'}]"
          ClickFuncApp="onclick=DNSChangeMode" />
        <li id="primarydns" RealType="TextBox" DescRef="wan_primdnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />
        <li id="secondarydns" RealType="TextBox" DescRef="wan_seconddnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />

        <li id="WanIPv6InfoBar" RealType="HorizonBar" DescRef="WanIPv6Info" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="Empty" InitValue="Empty" />
        <li id="PrifixEnabled" RealType="CheckBox" DescRef="PrefixDelegationEnabled" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.X_HW_E8C_IPv6PrefixDelegationEnabled" InitValue="Empty" />

        <li id="IPv6PrefixMode" RealType="RadioButtonList" DescRef="IPv6PrefixMode" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv6PrefixMode"
          InitValue="[{TextRef:'DHCPPD',Value:'PrefixDelegation',TitleRef:'PrefixDHCPPDTitle'},{TextRef:'Static',Value:'Static',TitleRef:'PrefixStaticTitle'},{TextRef:'None',Value:'None',TitleRef:'PrefixNoneTitle'}]"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="IPv6StaticPrefix" RealType="TextBox" DescRef="IPv6StaticPrefix" RemarkRef="PrefixRemark"
          ErrorMsgRef="Empty" Require="TRUE" BindField="d.IPv6StaticPrefix" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <script>
          if (isPerfixderived == 1) {
            document.write("\<li   id=\"IPv6AddressMode\"           RealType=\"RadioButtonList\"    DescRef=\"WanIpMode\"                 RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv6AddressMode\"    InitValue=\"[{TextRef:'DHCPV6',Value:'DHCPv6',TitleRef:'AddressDHCPTitle'},{TextRef:'Auto',Value:'AutoConfigured',TitleRef:'AddressAutoTitle'},{TextRef:'Static',Value:'Static',TitleRef:'AddressStaticTitle'},{TextRef:'PrefixDerived',Value:'PrefixDerived',TitleRef:'AddressPrefixDerTitle'},{TextRef:'None',Value:'None',TitleRef:'AddressNoneTitle'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\>")
          } else {
            document.write("\<li   id=\"IPv6AddressMode\"           RealType=\"RadioButtonList\"    DescRef=\"WanIpMode\"                 RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"d.IPv6AddressMode\"    InitValue=\"[{TextRef:'DHCPV6',Value:'DHCPv6',TitleRef:'AddressDHCPTitle'},{TextRef:'Auto',Value:'AutoConfigured',TitleRef:'AddressAutoTitle'},{TextRef:'Static',Value:'Static',TitleRef:'AddressStaticTitle'},{TextRef:'None',Value:'None',TitleRef:'AddressNoneTitle'}]\" ClickFuncApp=\"onclick=OnChangeUI\"\/\>")
          }
        </script>

        <li id="TDEIPv6UnnumberedModel" RealType="CheckBox" DescRef="Unnumbered" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.X_HW_UnnumberedModel" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <li id="TDEDHCP6cForAddress" RealType="CheckBox" DescRef="TDEDHCPV6" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.X_HW_DHCPv6ForAddress" InitValue="Empty" ClickFuncApp="onclick=OnChangeUI" />
        <li id="TDEIPv6AddressingType" RealType="DropDownList" DescRef="WanIpMode" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.X_HW_TDE_IPv6AddressingType"
          InitValue="[{TextRef:'DHCP',Value:'DHCP'},{TextRef:'Static',Value:'Static'},{TextRef:'SLAAC',Value:'SLAAC'}]"
          ClickFuncApp="onchange=OnChangeUI" />

        <li id="IPv6ReserveAddress" RealType="TextBox" DescRef="IPv6ReserveAddress" RemarkRef="IPv6ReserveAddressNote"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv6ReserveAddress" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv6AddressStuff" RealType="TextBox" DescRef="IPv6AddressStuff" RemarkRef="StuffRemark"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv6AddressStuff" Elementclass="TextBoxLtr" InitValue=""
          TitleRef="AddressStuffTitle" />
        <li id="IPv6IPAddress" RealType="TextBox" DescRef="IPv4IPAddress" RemarkRef="IPv6AddressRemark"
          ErrorMsgRef="Empty" Require="TRUE" BindField="d.IPv6IPAddress" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPv6AddrMaskLenE8c" RealType="TextBox" DescRef="IPv6AddrMaskLenE8c" RemarkRef="IPv6AddrMaskLenE8cRemark"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv6AddrMaskLenE8c" InitValue="Empty" />
        <li id="IPv6GatewayE8c" RealType="TextBox" DescRef="IPv6GatewayE8c" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv6GatewayE8c" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPv6SubnetMask" RealType="TextBox" DescRef="IPv4SubnetMask" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="d.IPv6SubnetMask" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPv6DefaultGateway" RealType="TextBox" DescRef="IPv4DefaultGateway" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="TRUE" BindField="d.IPv6Gateway" Elementclass="TextBoxLtr" InitValue="Empty" />
        <li id="IPV6OverrideAllowed" RealType="CheckBox" DescRef="EnableDnsOverride" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.X_HW_OverrideAllowed" InitValue="Empty"
          ClickFuncApp="onclick=OnChangeOverrideAllowed" />
        <li id="IPV6sourcemode" RealType="RadioButtonList" DescRef="wan_dnssoucrce" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"
          InitValue="[{TextRef:'wan_dnscarrier',Value:'0'},{TextRef:'wan_dnscustom',Value:'1'}]"
          ClickFuncApp="onclick=IPV6DNSChangeMode" />
        <li id="IPv6PrimaryDNSServer" RealType="TextBox" DescRef="IPv4PrimaryDNSServer" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv6PrimaryDNS" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv6SecondaryDNSServer" RealType="TextBox" DescRef="IPv4SecondaryDNSServer" RemarkRef="Empty"
          ErrorMsgRef="Empty" Require="FALSE" BindField="d.IPv6SecondaryDNS" Elementclass="TextBoxLtr"
          InitValue="Empty" />
        <li id="IPv6WanMVlanId" RealType="TextBox" DescRef="WanMVlanId" RemarkRef="WanMVlanIdRemark" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv6WanMVlanId" InitValue="Empty" />
        <li id="IPv6DSLite" RealType="RadioButtonList" DescRef="DSLite" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv6DSLite"
          InitValue="[{TextRef:'Off',Value:'Off'},{TextRef:'Auto',Value:'Dynamic'},{TextRef:'Static',Value:'Static'}]"
          ClickFuncApp="onclick=OnChangeUI" />
        <li id="IPv6AFTRName" RealType="TextBox" DescRef="AFTRName" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.IPv6AFTRName" InitValue="Empty" MaxLength="256" />
        <li id="IPv6NPTSwitch" RealType="CheckBox" DescRef="EnableNPTv6" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="d.X_HW_NPTv6Enable" InitValue="Empty" />
      </table>
      <script>
        var WanConfigFormList = [];
        var dir_style = ("ARABIC" == LoginRequestLanguage.toUpperCase()) ? "rtl" : "ltr";
        var TableClass = new stTableClass("width_per25", "width_per75", dir_style, "Select");
        WanConfigFormList = HWGetLiIdListByForm("ConfigForm", WanReload);
        HWParsePageControlByID("ConfigForm", TableClass, Languages, WanReload);

        ParsePageSpec();
        CleanServiceListVoip();
        if (true == IsFreInSsidName()) {
          var SL = GetSSIDFreList();
          var LanNum = 8;
          var SsidhalfNum = 4;
          for (var i = 0; i < SL.length; i++) {
            var index = getWlanInstFromDomain(SL[i].domain) + 8;
            if (index > (LanNum + SsidhalfNum)) {
              index++;
            }
            var tid = 'IPv4BindLanList' + index + '_text';
            getElement(tid).innerHTML = SL[i].name;
          }
        }
      </script>
      <script>
        (function () {
          PromptInfo = function (id, des) {
            this.id = id;
            this.des = des;
          }

          var List = new Array();

          List[0] = new PromptInfo('LcpEchoReqCheck', 'LcpEchoReqCheckDes');
          List[1] = new PromptInfo('IPv6ReserveAddress', 'IPv6ReserveAddressDes');

          try {
            for (var i in List) {
              getElementById(List[i].id).setAttribute('title', Languages[List[i].des]);
            }
          }
          catch (e) {

          }
        })();
      </script>

      <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
        <tr>
          <td width="25%">
          </td>
          <td class="table_submit" style="padding-left: 5px">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <input id="ButtonApply" type="button" value="OK" onclick="javascript:return OnApply();"
              class="ApplyButtoncss buttonwidth_100px" />
            <input id="ButtonCancel" type="button" value="Cancel" onclick="javascript:OnCancel();"
              class="CancleButtonCss buttonwidth_100px" />
          </td>
        </tr>
      </table>
      <table width="100%" height="20" cellpadding="0" cellspacing="0">
        <tr>
          <td></td>
        </tr>
      </table>
      <script>setText("ButtonApply", GetLanguage("Apply")); setText("ButtonCancel", GetLanguage("Cancel"));</script>

      <script>DisplayConfigPanel(0);</script>
    </fieldset>
  </form>
  <script>
    function ClickPre(val) {
      if (("chinese" == curLanguage) || (curCfgModeWord.toUpperCase() == "BLSCHOOL2")) {
        val.name = '/html/amp/ontauth/password.asp';
      }
      else {
        val.name = '/html/amp/ontauth/passwordcommon.asp';
      }
      window.parent.onchangestep(val);
    }

    function ClickSkip(val) {
      val.id = "guidecfgdone";
      if (fttrFlag == 1) {
        val.id = "guidelanconfig";
      }
      if ((ProductType == '2') || (TedataGuide == 1)) {
        val.id = "guidewlanconfig";
        if (isForceModifyPwd) {
          val.id = "guidecfgdone";
        }
      }

      window.parent.onchangestep(val);
    }

    if ('TDE2' == CfgModeWord.toUpperCase()) {
      setPppoeWanSrvRoute();
    }

    function Chickexit() {
      window.top.location = "/index.asp";
    }

    function onfirstpage(val) {
      if (-48 == guideIndex) {
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          url: '/smartguide.cgi?1=1&RequestFile=index.asp',
          data: getDataWithToken('Parainfo=0', true),
          success: function (data) {
            ;
          }
        });
      }

      window.top.location.href = "/index.asp";
    }

    function AddConfigFlag() {
      var index = 0;
      if ((fttrFlag == '1') && (isSupportOnulanCfg == '1')) {
        index = 4;
      }
      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        url: '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=' + index, true),
        success: function (data) {
          ;
        }
      });
    }

    function guideDone(val) {
      val.id = "guidecfgdone";
      AddConfigFlag();
      top.onchangestep(val);
    }

    function guide_pre(obj) {
      AddConfigFlag();
      window.parent.location = "../../../index.asp";
    }

  </script>

  <div align="center">
    <div id="btnguidewan" border="0" cellpadding="0" cellspacing="0" class="contentItem nofloat" style="display:none;">
      <div class="labelBox"></div>
      <div class="contenbox nofloat">
        <script>
          if (curCfgModeWord == "GLOBE2") {
            document.write('<input type="button" id="guideontauth" name="/html/amp/ontauth/password.asp" class="CancleButtonCss buttonwidth_100px" onClick="Chickexit(this);" BindText="bbsp_exit"/>');
            document.write('<input type="button" id="guidewificfg" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="window.parent.onchangestep(this);"  BindText="bbsp_next"/>');
          }
          else if ((ProductType == '2') || (TedataGuide == 1)) {
            if (isForceModifyPwd) {
              document.write('<input type="button" id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" class="CancleButtonCss buttonwidth_100px" onClick="window.parent.onchangestep(this);" BindText="bbsp_pre"/>');
              document.write('<input type="button" id="guidecfgdone" name="/html/ssmp/cfgguide/userguidecfgdone.asp" class="ApplyButtoncss buttonwidth_100px" onClick="window.parent.onchangestep(this);" BindText="bbsp_next"/>');
              document.write('<a id="guideskip" name="/html/ssmp/cfgguide/userguidecfgdone.asp" href="#" onClick="ClickSkip(this);">');
            } else {
              document.write('<input type="button" id="guideontauth" name="/html/amp/ontauth/password.asp" class="CancleButtonCss buttonwidth_100px" onClick="guide_pre(this);" BindText="bbsp_exit"/>');
              document.write('<input type="button" id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px" onClick="window.parent.onchangestep(this);" BindText="bbsp_next"/>');
              document.write('<a id="guideskip" name="/html/amp/wlanbasic/guidewificfg.asp" href="#" onClick="ClickSkip(this);">');
            }
          }
          else {
            document.write('<input type="button" id="firstpage" style="display:none;" class="CancleButtonCss buttonwidth_100px" onClick="onfirstpage(this);" BindText="bbsp_exit" />');

            if (curCfgModeWord == "GLOBE2") {
              document.write('<input type="button" id="guideontauth" name="/html/amp/ontauth/password.asp" class="CancleButtonCss buttonwidth_100px" onClick="Chickexit(this);" BindText="bbsp_exit"/>');
              document.write('<input type="button" id="guidewificfg" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="window.parent.onchangestep(this);"  BindText="bbsp_next"/>');
            } else if (fttrFlag == 1) {
              document.write('<input type="button" id="guideontauth" name="/html/amp/ontauth/password.asp" class="CancleButtonCss buttonwidth_100px" onClick="ClickPre(this);" BindText="bbsp_pre"/>');
              if (isSupportOnulanCfg != 1) {
                document.write('<input type="button" id="guidelanconfig" name="/html/bbsp/lanservicecfg/lanservicecfg.asp" class="ApplyButtoncss buttonwidth_100px" onClick="window.parent.onchangestep(this);" BindText="bbsp_next"/>');
              } else {
                document.write('<input type="button" id="guidecfgdone" name="/html/ssmp/bss/guidebssinfo.asp" class="ApplyButtoncss buttonwidth_100px" onClick="guideDone(this);" BindText="bbsp_next"/>');
              }
            } else {
              document.write('<input type="button" id="guideontauth" name="/html/amp/ontauth/password.asp" class="CancleButtonCss buttonwidth_100px" onClick="ClickPre(this);" BindText="bbsp_pre"/>');
              document.write('<input type="button" id="guidecfgdone" name="/html/ssmp/bss/guidebssinfo.asp" class="ApplyButtoncss buttonwidth_100px" onClick="window.parent.onchangestep(this);" BindText="bbsp_next"/>');
            }
            if (fttrFlag == 1) {
              if (isSupportOnulanCfg != 1) {
                document.write('<a id="guideskip" name="/html/bbsp/lanservicecfg/lanservicecfg.asp" href="#" onClick="ClickSkip(this);">');
              } else {
                document.write('<a id="guideskip" name="/html/ssmp/bss/guidebssinfo.asp" href="#" onClick="guideDone(this);">');
              }
            } else {
              document.write('<a id="guideskip" name="/html/ssmp/bss/guidebssinfo.asp" href="#" onClick="ClickSkip(this);">');
            }
          }
        </script>
        <span BindText="bbsp_skip"></span>
        </a>
      </div>
    </div>
  </div>
  <script>
    ParseBindTextByTagName(guideinternet_language, "span", 1);
    ParseBindTextByTagName(guideinternet_language, "input", 2);
    if ((false == IsAdminUser()) && ("GLOBE" == CfgModeWord.toUpperCase() || "GLOBE2" == CfgModeWord.toUpperCase())) {
      selectLine("wanInstTable_record_0");
    }
  </script>
  <script language="javascript" src="../common/wanipv6state.asp"></script>
  <div
    class="subWanListPolicyRoute subWanListIPVersion subIspWlan subDSLite subV6RDTunnel subRadioWan subWanStats subWANAccessType">
    <script type="text/javascript">
      LazyLoad();
      function RenderPage(event) {
        if (IsXdProduct() && (event.type == "evtRadioWan")) {
          Instance_RadioWan.WanListOverlay(GetWanList());
        }
      }

      $(document).ready(function() {
        if (window.parent.startWanStateTimer) {
          window.parent.startWanStateTimer();
        }
      });
    </script>
  </div>
</body>

</html>