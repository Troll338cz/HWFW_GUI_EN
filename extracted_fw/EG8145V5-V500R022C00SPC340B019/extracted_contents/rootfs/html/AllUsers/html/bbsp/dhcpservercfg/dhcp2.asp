<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css" />
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <title>DHCP Configure</title>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
  <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
  <script language="javascript" src="../common/managemode.asp"></script>
  <script language="javascript" src="../common/dhcpinfo.asp"></script>
  <script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/dhcpservercfg/dhcp2.cus);%>"></script>
  <script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(lanmodelist.asp);%>"></script>
  <script language="javascript" src="../../amp/common/<%HW_WEB_CleanCache_Resource(wlan_list.asp);%>"></script>
  <style>
    .TextBox {
      width: 130px;
    }

    .TextBox_2 {
      width: 63px;
    }

    .TextBoxLtr {
      width: 130px;
      direction: ltr;
    }

    .Select {
      width: 135px;
    }

    .Select_2 {
      width: 63px;
      margin: 0px 0px 0px 3px;
    }
  </style>
  <script language="JavaScript" type="text/javascript">
    var normaluserenable;
    var sysUserType = '0';
    var curUserType = '<%HW_WEB_GetUserType();%>';
    var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
    var dbaa1SuperSysUserType = '2';
    var maxisNormalUserType = '2';
    function IsAdminUser() {
      if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
      }
      return curUserType == sysUserType;
    }
    var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';
    var conditionpoolfeature = '<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_COND_POOL);%>';
    var hiderelay125feature = '<%HW_WEB_GetFeatureSupport(FT_NOMAL_HIDE_DHCP_RELAY_125);%>';
    var norightslavefeature = '<%HW_WEB_GetFeatureSupport(FT_NOMAL_NO_RIGHT_SLAVE_POOL);%>';
    var slv_independency = '<%HW_WEB_GetFeatureSupport(FT_SLAVE_NO_ASSIGN_ADDR);%>';
    var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
    var SonetHN8055QFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SONET_HN8055Q);%>';
    var option240feature = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
    var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
    var gstwfpoolfeature = '<%HW_WEB_GetFeatureSupport(FT_LAN_GUESTWIFI_POOL);%>';
    var ProductType = '<%HW_WEB_GetProductType();%>';
    var gstuseallslvpool = '<%HW_WEB_GetFeatureSupport(FT_GUEST_USE_ALL_SLVPOOL);%>';
    var multioptionsfeature = '<%HW_WEB_GetFeatureSupport(FT_DHCP_COND_POOL_60_43_OPT);%>';
    var IsAPFlagfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
    var ptvdfflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
    var selctIndex = -1;
    var TableName = "DhcpOptions";
    var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
    var IsDNSLockEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DNS.DNSLockEnable);%>';
    var isSAFARICOM = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SAFARICOM);%>';
    var IsNETLIFElag = '<%HW_WEB_GetFeatureSupport(HW_BBSP_FEATURE_NETLIFE);%>';
    var isDNSRelayEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.LanInheritHsiWanDns);%>';
    var CfgMode = '<%HW_WEB_GetCfgMode();%>';
    var CfgWord = CfgMode.toUpperCase();
    var isTMCZST = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TMCZST);%>';
    var isBiznetForUser = '<%HW_WEB_GetFeatureSupport(FT_DISPLAY_GUESTWIFI_POOL);%>';
    var isMegacableFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
    var supportUnnumberMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_UNNUMBERD_MODE);%>';
    var supportPoolBlock = '<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCP_POOL_BLOCKING);%>';
    var supportModifyDNS = '<%HW_WEB_GetFeatureSupport(FT_USER_MODIFY_DNSSEVER);%>';
    var primaryPool = "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement";
    var secondaryPool = "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.";
    var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
    var supportMacBindIp = '<%HW_WEB_GetFeatureSupport(BBSP_IPV4_MAC_BIND_IP);%>';
    var dualLanEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.X_HW_DualLANEnable);%>';
    var dhcps = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress.{i},Enable|Yiaddr|Chaddr,stDhcp);%>;
    var dhcp = new Array();
    var addMacIpFlag = true;
    for (var i = 0; i < dhcps.length-1; i++) {
        dhcp[i] = dhcps[i];
    }

    if (CfgMode.toUpperCase() == 'DNOVA2WIFI') {
      curUserType = sysUserType;
    }

    if (CfgWord == "NOS2") {
      gstwfpoolfeature = 0;
    }

    if ((1 == gstwfpoolfeature) || ("1" == GetCfgMode().DT_HUNGARY)) {
      conditionpoolfeature = 0;
    }

    function MultiOption(domain, VendorClassID, X_HW_Option43) {
      this.domain = domain;
      this.VendorClassID = VendorClassID;
      this.X_HW_Option43 = X_HW_Option43;
    }

    var Multioptions = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i},VendorClassID|X_HW_Option43,MultiOption);%>;

    var MOptions = new Array();
    for (var i = 0; i < Multioptions.length - 1; i++) {
      MOptions[i] = Multioptions[i];
    }

    var MoptionArray = MOptions.slice(1);

    function IsSonetUser() {
      if ((SonetFlag == '1') && (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }

    function IsSingtelUser() {
      if ((SingtelMode == '1') && (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }


    function IsSonetHN8055QUser() {
      if ((SonetHN8055QFlag == '1') && (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }

    function IsSonetNewNormalUser() {
      if (((curCfgModeWord.toUpperCase() == 'SONET') || (curCfgModeWord.toUpperCase() == 'SONET8045Q') ||
        (curCfgModeWord.toUpperCase() == 'SONETSGP200W')) && (IsAdminUser() == false)) {
        return true;
      }
      if ((curCfgModeWord.toUpperCase() == 'SYNCSGP210W') || (curCfgModeWord.toUpperCase() == 'SONETSGP210W')) {
        return true;
      }
      return false;
    }

    function IsOSKNormalUser() {
      if ((GetCfgMode().OSK == "1") && (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }

    function IsAISNormalUser() {
      if ((CfgModeWord.toUpperCase() == 'AIS') && (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }

    function IsAISAPUser() {
      return (CfgModeWord.toUpperCase() == 'AISAP');
    }
    function IsBJUNICOMNormalUser() {
      if ((CfgModeWord.toUpperCase() == 'BJUNICOM') && (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }

    function IsMaxisNormalUser() {
      if (CfgModeWord.toUpperCase() == 'DETHMAXIS') {
        return (curUserType == maxisNormalUserType);
      }

      return false;
    }

    function IsDigicelNormalUser() {
      if (('DIGICEL' == CfgModeWord.toUpperCase()) || ('DIGICEL2' == CfgModeWord.toUpperCase())) {
        return true;
      }
      else {
        return false;
      }
    }

    function IsTrueNormalUser() {
      if (((CfgModeWord.toUpperCase() == 'TRUE') || (CfgModeWord.toUpperCase() == 'TRUERG')) &&
        (IsAdminUser() == false)) {
        return true;
      } else {
        return false;
      }
    }

    var TELMEX = false;

    if (GetCfgMode().TELMEX == "1") {
      TELMEX = true;
    }
    else {
      TELMEX = false;
    }

    function loadlanguage() {
      var all = document.getElementsByTagName("td");
      for (var i = 0; i < all.length; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
          continue;
        }
        b.innerHTML = dhcp2_language[b.getAttribute("BindText")];
      }
    }

    function stDhcp(domain,Enable,ipAddress,macAddress) {
      this.domain = domain;
      this.Enable = Enable;
      this.ipAddress = ipAddress;
      this.macAddress = macAddress;	
    }   

    function dhcpcnst(domain, dhcpStart, dhcpEnd, LeaseTime, Enable, option60, ntpsvr, Option43, NormalUserEnable, SlaDNS) {
      this.domain = domain;
      this.dhcpStart = dhcpStart;
      this.dhcpEnd = dhcpEnd;
      this.LeaseTime = LeaseTime;
      this.Enable = Enable;
      this.option60 = option60;
      if (SlaDNS == "") {
        this.SlaPriDNS = "";
        this.SlaSecDNS = "";
      }
      else {
        var SlaDnss = SlaDNS.split(',');
        this.SlaPriDNS = SlaDnss[0];
        this.SlaSecDNS = SlaDnss[1];

        if (SlaDnss.length <= 1) {
          this.SlaSecDNS = "";
        }
      }

      this.ntpsvr = ntpsvr;
      this.Option43 = Option43;
      this.NormalUserEnable = NormalUserEnable;
    }

    function dhcpcnst1(domain, dhcpStart, dhcpEnd, LeaseTime, Enable, option60, ntpsvr, NormalUserEnable, SlaDNS) {
      this.domain = domain;
      this.dhcpStart = dhcpStart;
      this.dhcpEnd = dhcpEnd;
      this.LeaseTime = LeaseTime;
      this.Enable = Enable;
      this.option60 = option60;
      if (SlaDNS == "") {
        this.SlaPriDNS = "";
        this.SlaSecDNS = "";
      }
      else {
        var SlaDnss = SlaDNS.split(',');
        this.SlaPriDNS = SlaDnss[0];
        this.SlaSecDNS = SlaDnss[1];

        if (SlaDnss.length <= 1) {
          this.SlaSecDNS = "";
        }
      }

      this.ntpsvr = ntpsvr;
      this.NormalUserEnable = NormalUserEnable;
    }

    function condhcpst(domain, enable, option60, option60mode, ipstart, ipend, gateway, gatewaymask, dnss, dhcpleasetime, normaluserenable, option43) {
      this.Domain = domain;
      this.Gateway = gateway;
      this.Gatewaymask = gatewaymask;
      this.DhcpStart = ipstart;
      this.DhcpEnd = ipend;
      this.LeaseTime = dhcpleasetime;
      this.Enable = enable;
      this.Option60 = option60;
      this.Option60mode = option60mode;
      if (dnss == "") {
        this.SlaPriDNS = "";
        this.SlaSecDNS = "";
      }
      else {
        var SlaDnss = dnss.split(',');
        this.SlaPriDNS = SlaDnss[0];
        this.SlaSecDNS = SlaDnss[1];

        if (SlaDnss.length <= 1) {
          this.SlaSecDNS = "";
        }
      }

      this.NormalUserEnable = normaluserenable;
      this.option43 = option43;
    }

    function stDhcpConditionOption(domain, enable, tag, value) {
      this.domain = domain;
      this.enable = enable;
      this.tag = tag;
      this.value = value;
      this.type = "ConditionPool"
    }

    function dhcpmainst(domain, enable, startip, endip, leasetime, l2relayenable, HGWstartip, HGWendip, STBstartip, STBendip, Camerastartip, Cameraendip, Computerstartip, Computerendip, Phonestartip, Phoneendip, MainDNS, X_HW_Option125Enable, DNSServers, OptionEnable) {
      this.domain = domain;
      this.enable = enable;
      this.startip = startip;
      this.endip = endip;
      this.leasetime = leasetime;
      this.l2relayenable = l2relayenable;
      this.HGWstartip = HGWstartip;
      this.HGWendtip = HGWendip;
      this.STBstartip = STBstartip;
      this.STBendtip = STBendip;
      this.Camerastartip = Camerastartip;
      this.Cameraendtip = Cameraendip;
      this.Computerstartip = Computerstartip;
      this.Computerendtip = Computerendip;
      this.Phonestartip = Phonestartip;
      this.Phoneendtip = Phoneendip;
      MainDNS = (MainDNS == "") ? DNSServers : MainDNS;
      if (MainDNS == "") {
        this.MainPriDNS = "";
        this.MainSecDNS = "";
      }
      else {
        var MainDnss = MainDNS.split(',');
        this.MainPriDNS = MainDnss[0];
        this.MainSecDNS = MainDnss[1];
        if (MainDnss.length <= 1) {
          this.MainSecDNS = "";
        }
      }
      this.X_HW_Option125Enable = X_HW_Option125Enable;
      this.OptionEnable = OptionEnable;
    }

    function stipaddr(domain, enable, ipaddr, subnetmask) {
      this.domain = domain;
      this.enable = enable;
      this.ipaddr = ipaddr;
      this.subnetmask = subnetmask;
    }

    function stipaddrpool(startip, endip) {
      this.startip = startip;
      this.endip = endip;
    }

    function DhcpServerInfo() {
      this.domain = null;
      this.MainEnable = "";
    }
    var PolicyRouteNum = 0;

    function PolicyRouteItem(_Domain, _Type, _VenderClassId, _WanName) {
      this.Domain = _Domain;
      this.Type = _Type;
      this.VenderClassId = _VenderClassId;
      this.WanName = _WanName;
    }

    function sldcinfo(domain, startIP, endIP, enable, description) {
      this.domain = domain;
      this.startIP = startIP;
      this.endIP = endIP;
      this.enable = enable;
      this.description = description;
    }

    var PolicyRouteListAll = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterPolicyRoute, InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route.{i},PolicyRouteType|VenderClassId|WanName,PolicyRouteItem);%>;
    for (i = 0; i < PolicyRouteListAll.length && PolicyRouteListAll[i]; i++) {
      if (PolicyRouteListAll[i].Type.toUpperCase() == "SourceIP".toUpperCase()) {
        PolicyRouteNum++;
      }
    }

    var SlaveDhcpInfos;

    if (conditionpoolfeature == 1) {
      SlaveDhcpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaSlaveDhcpPool,InternetGatewayDevice.X_HW_DHCPSLVSERVER, StartIP|EndIP|LeaseTime|DHCPEnable|Option60|NTPList|NormalUserEnable|DNSList,dhcpcnst1);%>;
    }
    else {
      SlaveDhcpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaSlaveDhcpPool,InternetGatewayDevice.X_HW_DHCPSLVSERVER,StartIP|EndIP|LeaseTime|DHCPEnable|Option60|NTPList|Option43|NormalUserEnable|DNSList, dhcpcnst);%>;
    }

    var MainDhcpRange = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement, DHCPServerEnable|MinAddress|MaxAddress|DHCPLeaseTime|X_HW_DHCPL2RelayEnable|X_HW_HGWStart|X_HW_HGWEnd|X_HW_STBStart|X_HW_STBEnd|X_HW_CameraStart|X_HW_CameraEnd|X_HW_ComputerStart|X_HW_ComputerEnd|X_HW_PhoneStart|X_HW_PhoneEnd|X_HW_DNSList|X_HW_Option125Enable|DNSServers|X_HW_COND_POOL_MODE,dhcpmainst);%>;

    var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,stipaddr);%>;
    var LanHostInfo = LanIpInfos[0];
    if (LanIpInfos[1] == null) {
      LanIpInfos[1] = new stipaddr("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2", "", "", "");
    }

    var IPbr0 = LanIpInfos[0].ipaddr;
    var IPbr00 = LanIpInfos[1].ipaddr;
    if (IsPTVDFFlag == 1 && IPbr00 == "") {
      IPbr00 = LanIpInfos[0].ipaddr;
    }
    var dhcpmain = MainDhcpRange[0];

    var option240 = "";
    var option240instance = 0;
    var ConditionDhcpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i},Enable|VendorClassID|VendorClassIDMode|MinAddress|MaxAddress|IPRouters|SubnetMask|DNSServers|DHCPLeaseTime|X_HW_NormalUserEnable|X_HW_Option43,condhcpst);%>;
    if (ConditionDhcpInfos[1] == null) {
      ConditionDhcpInfos[1] = new condhcpst("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2", "", "", "", "", "", "", "", "", "", "", "");
    }
    var DhcpConditionOptions = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.DHCPOption.{i},Enable|Tag|Value,stDhcpConditionOption);%>;
    var DhcpConditionOptionsnum = DhcpConditionOptions.length - 1;


    var guestDhcpInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i}.,MinAddress|MaxAddress|Enable|X_HW_Description,sldcinfo);%>;
    var guestwifiDhcp = new Array();
    var guestflag = 0;
    var guestwififlag = 0;
    for (var i = 0; i < guestDhcpInfo.length - 1; i++) {
      if (guestDhcpInfo[i].description == "") {
        guestwifiDhcp = guestDhcpInfo[i];
        guestflag = 1;
      }
      if (guestDhcpInfo[i].description == "guestwifi" && guestDhcpInfo[i].enable == 0) {
        guestwififlag = 1;
      }
    }

    function poolBlockInfo(domain, from, to) {
      this.domain = domain;
      this.from = from;
      this.to = to;
    }

    var blockVisitFromPrimary = 0;
    var blockVisitPrimary = 0;
    var blockListExistA = 0;
    var blockListExistB = 0;
    var blockListAInst = -1;
    var blockListBInst = -1;
    var poolBlockList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_DHCPPoolBlockingList.{i},From|To,poolBlockInfo);%>;

    if (poolBlockList[0] != null) {
      if ((poolBlockList[0].from == primaryPool)) {
        blockListAInst = 0;
        blockListExistA = 1;
        blockVisitFromPrimary = 1;
      } else {
        blockListBInst = 0;
        blockListExistB = 1;
        blockVisitPrimary = 1;
      }
    }

    if (poolBlockList[1] != null) {
      if ((poolBlockList[1].from == primaryPool)) {
        blockListAInst = 1;
        blockListExistA = 1;
        blockVisitFromPrimary = 1;
      } else {
        blockListBInst = 1;
        blockListExistB = 1;
        blockVisitPrimary = 1;
      }
    }

    if (option240feature == 1) {
      for (var i = 0; i < DhcpConditionOptionsnum; i++) {
        if (DhcpConditionOptions[i].tag == "240") {
          option240instance = i + 1;
          var tmp = DhcpConditionOptions[i].value;
          option240 = Base64Decode(tmp);
        }
      }
    }

    function slvSourceInterface(domain, SourceInterface) {
      this.domain = domain;
      this.SourceInterface = SourceInterface;
    }

    var dhcpConditionalList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i},SourceInterface,slvSourceInterface);%>;

    if (dhcpConditionalList[0] == null) {
      dhcpConditionalList[0] = new slvSourceInterface("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1", "");
    }

    var slaveSourceInterface = dhcpConditionalList[0].SourceInterface;

    function SetPortBindCheck(slaveSourceInterface) {
      var portInfo = slaveSourceInterface.split(',');
      for (i = 1; i <= 8; i++) {
        setCheck("sourceInterface" + i, 0);
      }
      for (i = 0; i < portInfo.length; i++) {
        if (portInfo[i] == "") {
          continue;
        }
        var parms = portInfo[i].split('.');
        if (parms[parms.length - 2].indexOf('LANEthernetInterfaceConfig') != -1) {
          var checkedValue = parms[parms.length - 1];
          setCheck("sourceInterface" + checkedValue, 1);
        } else if (parms[parms.length - 2].indexOf('WLANConfiguration') != -1) {
          var checkedValue = parseInt(parms[parms.length - 1]) + 8;
          setCheck("sourceInterface" + checkedValue, 1);
        }
      }
    }

    function GetCheckedPortBindStr() {
      var portBindStr = '';
      for (i = 1; i <= 16; i++) {
        var checkbox = getElement("sourceInterface" + i);
        if (checkbox.checked == true) {
          if (portBindStr != '') {
            if (i <= 8) {
              portBindStr += (",InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + i);
            } else {
              portBindStr += (",InternetGatewayDevice.LANDevice.1.WLANConfiguration." + (i - 8));
            }
          } else {
            if (i <= 8) {
              portBindStr = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + i;
            } else {
              portBindStr = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + (i - 8);
            }
          }
        }
      }
      return portBindStr;
    }

    function ControlLanBind() {
      for (var i = 1; i <= 8; i++) {
        if (IsL3Mode(i) == "1") {
          setDisable("sourceInterface" + i, 0);
        } else {
          setDisable("sourceInterface" + i, 1);
        }
        if (i > GetLanModeList().length - 1) {
          setDisplay("DivsourceInterface" + i, 0)
        }
      }

      for (var j = 9; j <= 16; j++) {
        if (WlanList[j - 9].bindenable == 1) {
          setDisable("sourceInterface" + j, 0);
        } else {
          setDisable("sourceInterface" + j, 1);
        }
      }
    }

    function setLease(dhcpLease, flag) {
      var i = 0;
      var timeUnits = 604800;
      var infinite = ((dhcpLease == "-1") || (dhcpLease == "4294967295"));

      for (i = 0; i < 4; i++) {
        if (i == 0) {
          timeUnits = 604800;
        }
        else if (i == 1) {
          timeUnits = 86400;
        }
        else if (i == 2) {
          timeUnits = 3600;
        }
        else {
          timeUnits = 60;
        }

        if (true == isInteger(dhcpLease / timeUnits)) {
          break;
        }
      }

      if (flag == "slave") {
        setSelect('dhcpLeasedTimeFrag', timeUnits);
        if (infinite)
          setText('SlaveLeasedTime', dhcp2_language['bbsp_infinitetime']);
        else
          setText('SlaveLeasedTime', dhcpLease / timeUnits);
      }
      else if (flag == "main") {
        setSelect('maindhcpLeasedTimeFrag', timeUnits);
        if (infinite)
          setText('MainLeasedTime', dhcp2_language['bbsp_infinitetime']);
        else
          setText('MainLeasedTime', dhcpLease / timeUnits);
      }
      else {
        AlertEx(dhcp2_language['bbsp_poolinvalid']);
      }

    }


    function setAllDisable() {
      setDisable('DHCPEnable', 1);
      setDisable('SlaveEthStart', 1);
      setDisable('dhcpLeasedTimeFrag', 1);
      setDisable('SlaveEthEnd', 1);
      setDisable('SlaveLeasedTime', 1);
      setDisable('dhcpOption60', 1);
      setDisable('dnsSecPri', 1);
      setDisable('dnsSecSec', 1);
      setDisable('dhcpHsiWanDns', 1);

      if (supportPoolBlock == '1') {
        setDisable('MainVisitSlave', 1);
        setDisable('SlaveVisitMain', 1);
      }

      if ((supportUnnumberMode == '1') || (CfgWord == 'MYTIME') || (CfgWord == 'TM2')) {
        setDisable('sourceInterface', 1);
      }

      if (conditionpoolfeature == 1) {
        setDisable('Option60Mode', 1);
      }
      else {
        setDisable('dhcpOption43', 1);
        setDisable('ntpserver', 1);
      }
    }

    function setApDisplay() {
      if (IsAPFlagfeature == 1) {
        setDisplay("SecondaryServerPool", 0);
      }
    }

    function LoadFrame() {
      setDisplay("dhcpHsiWanDnsRow", 0);
      if (curCfgModeWord.toUpperCase() == "AISAP") {
        setDisplay("dhcpHsiWanDnsRow", 1);
        setCheck('dhcpHsiWanDns', isDNSRelayEnable);
      }
      setDisplay("ethIpAddressRow", 0);
      setDisplay("ethSubnetMaskRow", 0);
      if (true == IsBJUNICOMNormalUser()) {
        document.getElementById('DhcpServerFormtable').style.display = "none";
        setDisplay("ethIpAddressRow", 1);
        setDisplay("ethSubnetMaskRow", 1);
      }
      if ((IsAdminUser() == false) && (GetCfgMode().PCCWHK == "1")) {
        setDisplay("DhcpPoolPanel", 0);
        setDisplay("SecondaryServerPool", 0);
      }
      if ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) {
        setDisplay('dhcpL2relayRow', 0);
        setDisplay("DhcpPoolPanel", 0);
        setDisplay("SecondaryServerPool", 0);
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
        setDisplay('dhcpMainOption125Row', 0);
      }
      if (((hiderelay125feature == '1') && (IsAdminUser() == false)) ||
        (IsSonetHN8055QUser()) ||
        (IsSonetNewNormalUser())) {
        setDisplay('dhcpL2relayRow', 0);
        setDisplay('dhcpMainOption125Row', 0);
      }

      if (GetRunningMode() == "1") {
        setDisplay("DhcpPoolPanel", 1);
      }
      else {
        setDisplay("DhcpPoolPanel", 0);
      }

      if ("1" == GetCfgMode().DT_HUNGARY) {
        setDisplay("SecondaryServerPool", 0);
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
      }

      with (document.forms[0]) {
        setMainDhcp();
        setDhcp(LanIpInfos[1]);
        setDisplay('dhcpPoolInfo', 1);
      }

      if ((IsAdminUser() == false) && (IsSonetUser() == false)) {
        setDisable("dnsMainPri", 1);
        setDisable("dnsMainSec", 1);
        setDisable("dnsSecPri", 1);
        setDisable("dnsSecSec", 1);
      }

      if ((IsAdminUser() == false) &&
        ((IsOSKNormalUser()) || (IsAISNormalUser()) || (IsBJUNICOMNormalUser()) ||
        (IsDigicelNormalUser()) || (IsAISAPUser()) || (supportModifyDNS == '1'))) {
        setDisable("dnsMainPri", 0);
        setDisable("dnsMainSec", 0);
        setDisable("dnsSecPri", 0);
        setDisable("dnsSecSec", 0);
      }

      if ((IsAdminUser() == false) && ((IsTrueNormalUser()) || (CfgModeWord.toUpperCase() == 'DGRWIND'))) {
        setDisable("dnsMainPri", 0);
        setDisable("dnsMainSec", 0);
      }

      if (GetCfgMode().PCCWHK == "1") {
        setDisable("dhcpSrvType", 1);
        setDisable("dhcpL2relay", 1);
        setDisplay("dnsMainPriRow", 0);
        setDisplay("dnsMainSecRow", 0);
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
      }

      if (curCfgModeWord.toUpperCase() == "OTE") {
        setDisable("dnsMainPri", 0);
        setDisable("dnsMainSec", 0);
      }

      loadlanguage();

      if (true == TELMEX) {
        setDisplay('SecondaryServerPool', 0);
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
        setDisplay('dhcpMainOption125Row', 0);
      }

      if ('PCCW' == CfgModeWord.toUpperCase() || GetCfgMode().PCCWHK == "1") {
        setDisplay('dhcpMainOption125Row', 0);
      }

      var slavepoolenable;
      if (conditionpoolfeature == 1) {
        normaluserenable = ConditionDhcpInfos[0].NormalUserEnable;
        slavepoolenable = ConditionDhcpInfos[0].Enable;

        setDisplay('dhcpOption43Row', 0);
        setDisplay('ntpserverRow', 0);
      }
      else {
        normaluserenable = SlaveDhcpInfos[0].NormalUserEnable;
        slavepoolenable = SlaveDhcpInfos[0].Enable;
        setDisplay('Option60ModeRow', 0);
      }

      if ((option240feature == 1) && (conditionpoolfeature == 1)) {
        setDisplay('dhcpOption240Row', 1);
      }
      else {
        setDisplay('dhcpOption240Row', 0);
      }

      if ((true == TELMEX) ||
        (GetCfgMode().PCCWHK == "1") ||
        (GetCfgMode().DT_HUNGARY == "1") ||
        ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) ||
        (IsBJUNICOMNormalUser()) ||
        (curCfgModeWord.toUpperCase() == "ROMANIADT2")) {
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
        if (IsAdminUser() && (GetCfgMode().PCCWHK == "1") && (gstuseallslvpool != "1")) {
          setDisplay('SecondaryServerPool', 1);
        } else {
          setDisplay('SecondaryServerPool', 0);
        }
      } else if (gstuseallslvpool == "1") {
        setDisplay('SecondaryServerPool', 0);
      }
      else {
        if (slavepoolenable == 1) {
          setDisplay("dnsSecPriRow", 1);
          setDisplay("dnsSecSecRow", 1);
        }
        setDisplay('SecondaryServerPool', 1);
      }

      if (((norightslavefeature == "1") && (IsAdminUser() == false)) ||
        (IsSonetHN8055QUser())) {
        setDisplay('SecondaryServerPool', 0);
      }

      if (slavepoolenable == 0) {
        setDisplay('SlaveIpAddrRow', 0);
        setDisplay('SlaveMaskRow', 0);
        setDisplay('SlaveSubnetMaskRow', 0);
        setDisplay('SlaveEthStartRow', 0);
        setDisplay('SlaveEthEndRow', 0);
        setDisplay('SlaveLeasedTimeRow', 0);
        setDisplay('dhcpOption60Row', 0);
        if (conditionpoolfeature == 1) {
          setDisplay('Option60ModeRow', 0);

        }
        else {
          setDisplay('dhcpOption43Row', 0);
          setDisplay('ntpserverRow', 0);
        }
        setDisplay('dnsSecPriRow', 0);
        setDisplay('dnsSecSecRow', 0);
      }
      else {
        setDisplay('SlaveConfigForm', 1);
      }

      if ((IsAdminUser() == false) && (normaluserenable == '0')) {
        setAllDisable();
      }

      if ('CLARO' == CfgModeWord.toUpperCase() ||
        '1' == ptvdfflag || 'CLARODR' == CfgModeWord.toUpperCase()) {
        setDisable("dnsMainPri", 0);
        setDisable("dnsMainSec", 0);
      }

      if (SingtelMode == '1') {
        if (IsAdminUser() == false) {
          setDisplay('dhcpSrvTypeRow', 0);
          setDisplay('dhcpL2relayRow', 0);
          setDisplay('dhcpMainOption125Row', 0);
        }
        setDisplay("SecondaryServerPool", 0);
      }
      if (true == IsBJUNICOMNormalUser()) {
        setDisplay("dhcpL2relayRow", 0);
        setDisplay("dhcpMainOption125Row", 0);
        setDisplay("LanHostIPRow", 0);
        setDisplay("LanHostMaskRow", 0);
        setDisplay("dnsMainPriRow", 0);
        setDisplay("dnsMainSecRow", 0);
        setDisable("MainLeasedTime", 1);
      }

      if (multioptionsfeature == '0') {
        setDisplay('OptionsEnableRow', 0);
      }
      else {
        setDisplay('OptionsEnableRow', 1);
      }

      enbleDHCP();
      setApDisplay();

      // CM
      if (ProductType == '3') {
        setDisplay('SecPoolConfigForm', 0);
      }

      if (1 == IsPTVDFFlag || 1 == isSAFARICOM) {
        if (IsDNSLockEnable == "1") {
          setDisable("dnsMainPri", 1);
          setDisable("dnsMainSec", 1);
        }
        else {
          setDisable("dnsMainPri", 0);
          setDisable("dnsMainSec", 0);
        }
      }
      if (CfgMode == "DMASMOVIL2WIFI") {
        setDisable("dnsMainPri", 1);
        setDisable("dnsMainSec", 1);
      }

      if ((DBAA1 == "1") && (curUserType != dbaa1SuperSysUserType)) {
        setDisplay("dhcpSrvTypeRow", 0);
        setDisplay("dhcpL2relayRow", 0);
        setDisplay("dhcpMainOption125Row", 0);
        setDisplay("MainLeasedTimeRow", 0);
        setDisplay("dhcpHsiWanDnsRow", 0);
        setDisplay("dnsMainPriRow", 0);
        setDisplay("dnsMainSecRow", 0);
        setDisplay("SecPoolConfigForm", 0);
      }

      if ((curUserType != '0') && (isMegacableFlag == "1")) {
        setDisplay("SecondaryServerPool", 0);
      }

      if (isTMCZST == 1) {
        setDisplay("dnsMainPriRow", 0);
        setDisplay("dnsMainSecRow", 0);
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
      }

      if ((curWebFrame == 'frame_argentina') && (curUserType != sysUserType)) {
        setDisable("dhcpMainOption125", 1);
      }

      //DHCPMacBindIp
      if (supportMacBindIp == 1) {
        setDisplay("DHCPMacBindIp", 1);

        if (dhcp.length > 0) {
        selectLine(TableName + '_record_0');
        setDisplay('TableConfigInfo',1);
        }
        else {   
          selectLine('record_no');
          setDisplay('TableConfigInfo',0);
        }
      }
    }

    function setMainDhcp() {
      with (document.forms[0]) {
        setCheck('dhcpSrvType', MainDhcpRange[0].enable);
        setCheck('dhcpL2relay', MainDhcpRange[0].l2relayenable);
        setCheck('dhcpMainOption125', MainDhcpRange[0].X_HW_Option125Enable);

        setElementInnerHtmlById("LanHostIP", LanIpInfos[0].ipaddr);
        setElementInnerHtmlById("LanHostMask", LanIpInfos[0].subnetmask);
        setText('mainstartipaddr', MainDhcpRange[0].startip);
        setText('mainendipaddr', MainDhcpRange[0].endip);
        setText('HGWEthStart', MainDhcpRange[0].HGWstartip);
        setText('HGWEthEnd', MainDhcpRange[0].HGWendtip);
        setText('STBEthStart', MainDhcpRange[0].STBstartip);
        setText('STBEthEnd', MainDhcpRange[0].STBendtip);
        setText('CameraEthStart', MainDhcpRange[0].Camerastartip);
        setText('CameraEthEnd', MainDhcpRange[0].Cameraendtip);
        setText('ComputerEthStart', MainDhcpRange[0].Computerstartip);
        setText('ComputerEthEnd', MainDhcpRange[0].Computerendtip);
        setText('PhoneEthStart', MainDhcpRange[0].Phonestartip);
        setText('PhoneEthEnd', MainDhcpRange[0].Phoneendtip);
        if (true == IsBJUNICOMNormalUser()) {
          setText('ethIpAddress', LanHostInfo.ipaddr);
          setText('ethSubnetMask', LanHostInfo.subnetmask);
        }
        if (GetCfgMode().PCCWHK != "1") {
          setText('dnsMainPri', MainDhcpRange[0].MainPriDNS);
          setText('dnsMainSec', MainDhcpRange[0].MainSecDNS);
        }
        setLease(dhcpmain.leasetime, "main");

        SetDHCPServerDisplay(MainDhcpRange[0].enable);
      }
    }

    function setDhcp(dhcpst) {
      with (document.forms[0]) {
        if (conditionpoolfeature == 1) {
          setText('SlaveEthStart', ConditionDhcpInfos[0].DhcpStart);
          setText('SlaveEthEnd', ConditionDhcpInfos[0].DhcpEnd);
          setText('SlaveIpAddr', ConditionDhcpInfos[0].Gateway);
          setText('SlaveMask', ConditionDhcpInfos[0].Gatewaymask);
          setDisable('SlaveIpAddr', 0);
          setDisable('SlaveMask', 0);
          setText('dhcpOption60', ConditionDhcpInfos[0].Option60);
          setSelect('Option60Mode', ConditionDhcpInfos[0].Option60mode);
          setText('dhcpOption43', ConditionDhcpInfos[0].option43);
          if (GetCfgMode().PCCWHK != "1") {
            setText('dnsSecPri', ConditionDhcpInfos[0].SlaPriDNS);
            setText('dnsSecSec', ConditionDhcpInfos[0].SlaSecDNS);
          }

          setLease(ConditionDhcpInfos[0].LeaseTime, "slave");
          setCheck('DHCPEnable', ConditionDhcpInfos[0].Enable);
          if (option240feature == 1) {
            setText('dhcpOption240', option240);
          }
          if (multioptionsfeature == '1') {
            setCheck('OptionsEnable', MainDhcpRange[0].OptionEnable);
          }
          if (supportPoolBlock == '1') {
            setCheck('MainVisitSlave', blockVisitFromPrimary);
            setCheck('SlaveVisitMain', blockVisitPrimary);
          }
          if (supportUnnumberMode == '1') {
            SetPortBindCheck(slaveSourceInterface);
            ControlLanBind();
          }

          if ((CfgWord == 'MYTIME') || (CfgWord == 'TM2')) {
            SetPortBindCheck(slaveSourceInterface);
            ControlLanBind();
            setCheck('EnableDualLan', dualLanEnable);
          }
        }
        else {
          setText('SlaveEthStart', SlaveDhcpInfos[0].dhcpStart);
          setText('SlaveEthEnd', SlaveDhcpInfos[0].dhcpEnd);
          setText('SlaveIpAddr', LanIpInfos[1].ipaddr);
          setText('SlaveMask', LanIpInfos[1].subnetmask);
          if (IsPTVDFFlag == 1) {
            setDisable('SlaveIpAddr', 0);
            setDisable('SlaveMask', 0);
          }
          else {
            setDisable('SlaveIpAddr', 1);
            setDisable('SlaveMask', 1);
          }
          setText('dhcpOption60', SlaveDhcpInfos[0].option60);
          if (GetCfgMode().PCCWHK != "1") {
            setText('dnsSecPri', SlaveDhcpInfos[0].SlaPriDNS);
            setText('dnsSecSec', SlaveDhcpInfos[0].SlaSecDNS);
          }
          setText('ntpserver', SlaveDhcpInfos[0].ntpsvr);
          setText('dhcpOption43', SlaveDhcpInfos[0].Option43);
          setLease(SlaveDhcpInfos[0].LeaseTime, "slave");

          setCheck('DHCPEnable', SlaveDhcpInfos[0].Enable);
        }
      }
    }

    function checkPoolPara() {
      with (document.forms[0]) {
        var poolPara = new Array(new stipaddrpool(getValue("HGWEthStart"), getValue("HGWEthEnd")),
          new stipaddrpool(getValue("STBEthStart"), getValue("STBEthEnd")),
          new stipaddrpool(getValue("CameraEthStart"), getValue("CameraEthEnd")),
          new stipaddrpool(getValue("ComputerEthStart"), getValue("ComputerEthEnd")),
          new stipaddrpool(getValue("PhoneEthStart"), getValue("PhoneEthEnd")));
        var deviceType = new Array('HGW', 'STB', 'Camera', 'Computer', 'Phone');

        var index = 0;
        var indexTemp = 0;
        if (1 == getCheckVal('dhcpSrvType')) {
          for (index = 0; index < 5; index++) {
            if (("" == poolPara[index].startip) && ("" == poolPara[index].endip)) {
              continue;
            }

            if (isValidIpAddress(poolPara[index].startip) == false) {
              AlertEx(dhcp2_language['bbsp_startipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpserinvalid']);
              return false;
            }

            if (isBroadcastIp(poolPara[index].startip, LanIpInfos[0].subnetmask) == true) {
              AlertEx(dhcp2_language['bbsp_startipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpserinvalid']);
              return false;
            }

            if (false == isSameSubNet(poolPara[index].startip, LanIpInfos[0].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
              AlertEx(dhcp2_language['bbsp_startipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpsermustsamehost']);
              return false;
            }

            if (!(isEndGTEStart(poolPara[index].startip, mainstartipaddr.value))) {
              AlertEx(dhcp2_language['bbsp_startipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpmustinpriserpool']);
              return false;
            }

            if (isValidIpAddress(poolPara[index].endip) == false) {
              AlertEx(dhcp2_language['bbsp_endipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpinvalid']);
              return false;
            }

            if (isBroadcastIp(poolPara[index].endip, LanIpInfos[0].subnetmask) == true) {
              AlertEx(dhcp2_language['bbsp_endipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpinvalid']);
              return false;
            }

            if (false == isSameSubNet(poolPara[index].endip, LanIpInfos[0].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
              AlertEx(dhcp2_language['bbsp_endipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpsermustsamesubhost']);
              return false;
            }

            if (!(isEndGTEStart(poolPara[index].endip, poolPara[index].startip))) {
              AlertEx(dhcp2_language['bbsp_endipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpsermustgtrstip']);
              return false;
            }

            if (!(isEndGTEStart(mainendipaddr.value, poolPara[index].endip))) {
              AlertEx(dhcp2_language['bbsp_endipaddr'] + deviceType[index] + dhcp2_language['bbsp_pridhcpsermustinpripool']);
              return false;
            }
          }

          for (index = 0; index < 5; index++) {
            if (("" == poolPara[index].startip) && ("" == poolPara[index].endip)) {
              continue;
            }

            for (indexTemp = index + 1; indexTemp < 5; indexTemp++) {
              if (("" == poolPara[indexTemp].startip) && ("" == poolPara[indexTemp].endip)) {
                continue;
              }

              if ((isEndGTEStart(poolPara[indexTemp].startip, poolPara[index].startip) && isEndGTEStart(poolPara[index].endip, poolPara[indexTemp].startip))
                || (isEndGTEStart(poolPara[index].startip, poolPara[indexTemp].startip) && isEndGTEStart(poolPara[indexTemp].endip, poolPara[index].startip))) {
                AlertEx(dhcp2_language['bbsp_startipaddr'] + deviceType[index] + dhcp2_language['bbsp_poolandtype'] + deviceType[indexTemp] + dhcp2_language['bbsp_secpoolconflict']);
                return false;
              }
            }
          }
        }
      }
      return true;
    }

    //MacBindIp
    function PS_CheckReserveIP(Operation, Ip, MAC) {
      var conflict = false;   
      $.ajax({
          type  : "POST",
          async : false,
          cache : false,
          data  : "act=" + Operation+ "&ip=" + Ip + "&mac=" + MAC +"&x.X_HW_Token="+getValue('onttoken'),
          url   : "pdtipconflictcheck",
          success : function(data) {
              conflict = true;
          },
          error : function(XMLHttpRequest, textStatus, errorThrown) {
              conflict = false;
          },
          complete: function (XHR, TS) { 
              XHR = null;
        }         
      });
      return conflict;
    }
    function CheckForm1() {	
      var IpAddress;
      var MacAddress;
      var right = 0;

      IpAddress = getValue('ipAddr');
      MacAddress = getValue('macAddr');
      if (MacAddress == "") {
        msg = dhcpstatic_language_ftto['bbsp_macnull'];
        AlertEx(msg);
        return false;
      }

      if(isValidMacAddress(MacAddress) == false) {
        AlertEx(dhcpstatic_language_ftto['bbsp_mac']+ MacAddress + dhcpstatic_language_ftto['bbsp_invalid']);
        return false;
      }	

      if (IpAddress == "") {
        msg = dhcpstatic_language_ftto['bbsp_ipnull'];
        AlertEx(msg);
        return false;
      }

      if((isAbcIpAddress(IpAddress) == false) || (isDeIpAddress(IpAddress) == true) 
        || (isBroadcastIpAddress(IpAddress) == true) || (isLoopIpAddress(IpAddress) == true)) {
        AlertEx(dhcpstatic_language_ftto['bbsp_ipinvalid1']+ IpAddress + dhcpstatic_language_ftto['bbsp_invalid']);
        return false;
      }

      if (SingtelMode == '1') {
        var IpAddrParts = IpAddress.split('.');
        if (parseInt(IpAddrParts[3]) < 64 || parseInt(IpAddrParts[3]) > 127) {
          AlertEx(dhcpstatic_language_ftto['bbsp_ipinvalid1']+ IpAddress + dhcpstatic_language_ftto['bbsp_invalid']);
          return false;    
        }
      }
      /* 增加参数重复时报错提醒 */
      for (var i = 0; i < dhcp.length; i++) {
        if (selctIndex != i) {
          if (dhcp[i].macAddress.toUpperCase() == MacAddress.toUpperCase()) {
            AlertEx(dhcpstatic_language_ftto['bbsp_macused']);
            return false;
          }

          if (dhcp[i].ipAddress == IpAddress) {
            AlertEx(dhcpstatic_language_ftto['bbsp_isused']);
            return false;
          }
        }
        else {
          continue;
        }
      }

      if(("1" == "<%HW_WEB_GetFeatureSupport(HW_FT_DHCP_CHECK_STATIC_ARP);%>")
        && (true == PS_CheckReserveIP("checkDhcp", IpAddress, MacAddress))) {            
        AlertEx(dhcpstatic_language_ftto['bbsp_ipconflict']);
        return false;
      }

      return true;
    }

    function Cancel() {
      setDisplay("TableConfigInfo", 0);
    
      if (addMacIpFlag == true) {
        var tableRow = getElement(TableName);
        
        if (tableRow.rows.length == 1) {
            selectLine('record_no');
        }
        else if (tableRow.rows.length == 2) {
        } 
        else {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + '_record_0');
        }
      }
      else {
        setText('ipAddr',dhcp[selctIndex].ipAddress);
        setText('macAddr',dhcp[selctIndex].macAddress);
      }
      setDisable('btnAdd',0);
      setDisable('cancel',0);
    }

    function AddSubmitParam2() {

      if (false == CheckForm1()) {
        return;
      }

      var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';
      var DhcpStaticSpecCfgParaList = new Array(new stSpecParaArray("x.Yiaddr",getValue('ipAddr'), 1),
                                     new stSpecParaArray("x.Chaddr",getValue('macAddr'), 1));
      var url = '';
      if( selctIndex == -1 ) {
        DhcpStaticSpecCfgParaList.push(new stSpecParaArray("x.Enable","1", 1));
        url = 'add.cgi?'+'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress'
                            + '&RequestFile=' + RequestFile;
      }
      else {
        url = 'set.cgi?x=' + dhcp[selctIndex].domain
                            + '&RequestFile=' + RequestFile;
      }
    
      var Parameter = {};
      Parameter.asynflag = null;
      Parameter.FormLiList = DhcpStaticConfigFormList;
      Parameter.SpecParaPair = DhcpStaticSpecCfgParaList;
      var tokenvalue = getValue('onttoken');
      HWSetAction(null, url, Parameter, tokenvalue);	
      setDisable('btnAdd',1);
      setDisable('cancel',1);
    }

    function IsDhcpOption60Valid(value) {
      var uiDotCount = 0;
      var i;
      var chDot = '*';
      var uiLength = value.length;

      for (i = 0; i < value.length; i++) {
        if (value.charAt(i) == chDot) {
          uiDotCount++;
        }
      }

      if (uiDotCount > 2) {
        return false;
      }

      if (0 == uiDotCount) {
        return true;
      }

      if ((1 == uiDotCount)
        && (value.charAt(0) != chDot)
        && (value.charAt(uiLength - 1) != chDot)) {
        return false;
      }

      if ((2 == uiDotCount)
        && ((value.charAt(0) != chDot)
          || (value.charAt(uiLength - 1) != chDot))) {
        return false
      }
      return true;
    }


    function dnsipcheck(ip) {
      if (ip.length == 0) {
        return true;
      }
      if ((isAbcIpAddress(ip) == false) || (isValidIpAddress(ip) == false)) {
        return false;
      }
      return true;
    }

    function ParseNtpServerResult(string) {
      var splitobj = ",";
      var subString = string.split(splitobj);
      var stringlength = 0;

      stringlength = string.length;

      if (subString.length > 0) {
        for (var i = 0; i < subString.length; i++) {
          if (false == dnsipcheck(subString[i])) {
            AlertEx(dhcp2_language['bbsp_ntpserverinvalid']);
            return false;
          }
        }
      }
      return true;
    }


    function ParseOption60Result(string) {
      var splitobj = ",";
      var subString = string.split(splitobj);

      if (subString.length > 0) {
        for (var i = 0; i < subString.length; i++) {
          if (subString[i] == "") {
            return false;
          }

          if (IsDhcpOption60Valid(subString[i]) == false) {
            return false;
          }
        }
      }

      return true;
    }

    function ParseConditionOption60Result(string, mode) {
      var splitobj = ",";
      var subString = string.split(splitobj);

      var i = 0;
      var chDot = '*';

      if (subString.length > 1) {
        if (mode == "Exact") {
          if (ParseOption60Result(string) == false) {
            return false;
          }
        }
        else {
          return false;
        }
      }
      else {
        for (i = 0; i < string.length; i++) {
          if (string.charAt(i) == chDot) {
            return false;
          }
        }
      }

      return true;
    }

    function isHexaDigit(ch) {
      var hexList = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "a", "b", "c", "d", "e", "f");

      for (var i = 0; i < hexList.length; i++) {
        if (ch == hexList[i]) {
          return true;
        }
      }

      return false;
    }

    function IsDhcpOption43Valid(Option43) {
      var uiDotCount = 0;
      var i;
      var uiLength = Option43.length;

      if (uiLength > 64) {
        AlertEx(dhcp2_language['bbsp_option43leninvalid']);
        return false;
      }

      if (('0' == Option43.charAt(0) && 'x' == Option43.charAt(1)) || ('0' == Option43.charAt(0) && 'X' == Option43.charAt(1))) {
        if ((Option43.length) % 2 == 1) {
          AlertEx(dhcp2_language['bbsp_option43invalid']);
          return false;
        }
        for (i = 2; i < Option43.length; i++) {
          if (isHexaDigit(Option43.charAt(i)) == false) {
            AlertEx(dhcp2_language['bbsp_option43invalid']);
            return false;
          }
        }
      }
      return true;
    }
    function IsLessThan(lip, rip) {
      var ladress = lip.split('.');
      var radress = rip.split('.');
      var ladnum = 0;
      var radnum = 0;

      for (var i = 0; i < 4; i++) {
        ladnum = ladnum + parseInt(ladress[i], 10);
        radnum = radnum + parseInt(radress[i], 10);
      }

      if (ladnum <= radnum) {
        return true;
      }
      return false;
    }
    function CheckFormGuestAllSLVPool() {
      with (document.forms[0]) {
        if (1 == getCheckVal('dhcpSrvType')) {
          if (isValidIpAddress(mainstartipaddr.value) == false) {
            AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid']);
            return false;
          }

          if (isBroadcastIp(mainstartipaddr.value, LanIpInfos[0].subnetmask) == true) {
            AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid']);
            return false;
          }

          if (isValidIpAddress(mainendipaddr.value) == false) {
            AlertEx(dhcp2_language['bbsp_dhcpendipinvalid']);
            return false;
          }


          if (isBroadcastIp(mainendipaddr.value, LanIpInfos[0].subnetmask) == true) {
            AlertEx(dhcp2_language['bbsp_dhcpendipinvalid']);
            return false;
          }

          if (false == isSameSubNet(mainstartipaddr.value, LanIpInfos[0].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
            AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost']);
            return false;
          }
          if (false == isSameSubNet(mainendipaddr.value, LanIpInfos[0].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
            AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost']);
            return false;
          }

          if (!(isEndGTEStart(mainendipaddr.value, mainstartipaddr.value))) {
            AlertEx(dhcp2_language['bbsp_priendipgeqstartip']);
            return false;
          }

          if (PolicyRouteNum > 0) {
            var IpStartNew = getValue('mainstartipaddr').split('.');
            var IpEndNew = getValue('mainendipaddr').split('.');
            var IpMinNew = parseInt(IpStartNew[3]);
            var IpMaxNew = parseInt(IpEndNew[3]);

            var IpStartOld = MainDhcpRange[0].startip.split('.');
            var IpEndOld = MainDhcpRange[0].endip.split('.');
            var IpMinOld = parseInt(IpStartOld[3]);
            var IpMaxOld = parseInt(IpEndOld[3]);
            if (IpMinNew > IpMinOld || IpMaxNew < IpMaxOld) {
              AlertEx(dhcp2_language['bbsp_ippoolpolicyrouteinvalid']);
              return false;
            }
          }

          if (false == checkLease("bbsp_pripool", MainLeasedTime.value, maindhcpLeasedTimeFrag.value, dhcp2_language)) {
            return false;
          }
        }
        else if (ConditionDhcpInfos[1].Enable == 1) {
          AlertEx(dhcp2_language['bbsp_guestpoolwrong']);
          return false;
        }
        if (GetCfgMode().OSK == "1") {
          if (getValue('dnsMainPri') != '' && (isValidIpAddress(getValue('dnsMainPri')) == false || isAbcIpAddress(getValue('dnsMainPri')) == false)) {
            AlertEx(dhcp2_language['bbsp_pripoolpridnsinvalid']);
            return false;
          }
          if (getValue('dnsMainSec') != '' && (isValidIpAddress(getValue('dnsMainSec')) == false || isAbcIpAddress(getValue('dnsMainSec')) == false)) {
            AlertEx(dhcp2_language['bbsp_pripoolsecdndinvalid']);
            return false;
          }
        }
      }

      setDisable('btnApply_ex', 1);
      setDisable('cancelValue_ex', 1);

      return true;
    }
    function CheckForm() {
      var IpMin;
      var IPMax;
      with (document.forms[0]) {
        if (1 == getCheckVal('dhcpSrvType')) {
          if (isValidIpAddress(mainstartipaddr.value) == false) {
            if (SingtelMode == '1') {
              AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid_singtel']);
            }
            else {
              AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid']);
            }

            return false;
          }

          if (isBroadcastIp(mainstartipaddr.value, LanIpInfos[0].subnetmask) == true) {
            if (SingtelMode == '1') {
              AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid_singtel']);
            }
            else {
              AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid']);
            }
            return false;
          }

          if (((CfgModeWord.toUpperCase() == 'PCCWHK') || (CfgModeWord.toUpperCase() == 'PCCW3MAC')) &&
            (IsAdminUser() == false)) {
            if ((getValue('mainstartipaddr').split(".")[0] == 192) &&
              (getValue('mainstartipaddr').split(".")[1] == 168) &&
              (getValue('mainstartipaddr').split(".")[2] == 8) &&
              (getValue('mainstartipaddr').split(".")[3] > 127)) {
              AlertEx(dhcp2_language['bbsp_startipinvalid']);
              return false;
            }
          }

          if (isValidIpAddress(mainendipaddr.value) == false) {
            if (SingtelMode == '1') {
              AlertEx(dhcp2_language['bbsp_dhcpendipinvalid_singtel']);
            }
            else {
              AlertEx(dhcp2_language['bbsp_dhcpendipinvalid']);
            }
            return false;
          }


          if (isBroadcastIp(mainendipaddr.value, LanIpInfos[0].subnetmask) == true) {
            if (SingtelMode == '1') {
              AlertEx(dhcp2_language['bbsp_dhcpendipinvalid_singtel']);
            }
            else {
              AlertEx(dhcp2_language['bbsp_dhcpendipinvalid']);
            }
            return false;
          }


          if (true == IsBJUNICOMNormalUser()) {
            if (false == isSameSubNet(mainstartipaddr.value, getValue('ethSubnetMask'), getValue('ethIpAddress'), getValue('ethSubnetMask'))) {
              if (SingtelMode == '1') {
                AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost_singtel']);
              }
              else {
                AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost']);
              }
              return false;
            }
            if (false == isSameSubNet(mainendipaddr.value, getValue('ethSubnetMask'), getValue('ethIpAddress'), getValue('ethSubnetMask'))) {
              if (SingtelMode == '1') {
                AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost_singtel']);
              }
              else {
                AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost']);
              }
              return false;
            }
          }
          else {
            if (false == isSameSubNet(mainstartipaddr.value, LanIpInfos[0].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
              if (SingtelMode == '1') {
                AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost_singtel']);
              }
              else {
                AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost']);
              }
              return false;
            }
            if (false == isSameSubNet(mainendipaddr.value, LanIpInfos[0].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
              if (SingtelMode == '1') {
                AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost_singtel']);
              }
              else {
                AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost']);
              }
              return false;
            }
          }

          if (((CfgModeWord.toUpperCase() == 'PCCWHK') || (CfgModeWord.toUpperCase() == 'PCCW3MAC')) &&
            (IsAdminUser() == false)) {
            if ((getValue('mainendipaddr').split(".")[0] == 192) &&
              (getValue('mainendipaddr').split(".")[1] == 168) &&
              (getValue('mainendipaddr').split(".")[2] == 8) &&
              (getValue('mainendipaddr').split(".")[3] > 127)) {
              AlertEx(dhcp2_language['bbsp_endipinvalid']);
              return false;
            }
          }

          if (!(isEndGTEStart(mainendipaddr.value, mainstartipaddr.value))) {
            if (SingtelMode == '1') {
              AlertEx(dhcp2_language['bbsp_priendipgeqstartip_singtel']);
            }
            else {
              AlertEx(dhcp2_language['bbsp_priendipgeqstartip']);
            }
            return false;
          }
          if (1 == gstwfpoolfeature) {
            if (!guestwififlag) {
              if ((ConditionDhcpInfos[1].Gateway == LanIpInfos[0].ipaddr) &&
                ((IsLessThan(ConditionDhcpInfos[1].DhcpStart, mainendipaddr.value) && IsLessThan(mainstartipaddr.value, ConditionDhcpInfos[1].DhcpStart)) ||
                  (IsLessThan(ConditionDhcpInfos[1].DhcpStart, mainstartipaddr.value) && IsLessThan(mainstartipaddr.value, ConditionDhcpInfos[1].DhcpEnd)))) {
                AlertEx(dhcp2_language['bbsp_mainpoolingstwfpool']);
                return false;
              }
              if ((ConditionDhcpInfos[1].Gateway == LanIpInfos[1].ipaddr) &&
                ((IsLessThan(ConditionDhcpInfos[1].DhcpStart, getValue("SlaveEthEnd")) && IsLessThan(getValue("SlaveEthStart"), ConditionDhcpInfos[1].DhcpStart)) ||
                  (IsLessThan(ConditionDhcpInfos[1].DhcpStart, getValue("SlaveEthStart")) && IsLessThan(getValue("SlaveEthStart"), ConditionDhcpInfos[1].DhcpEnd)))) {
                AlertEx(dhcp2_language['bbsp_slavepoolingstwfpool']);
                return false;
              }
            }
          }
          if (PolicyRouteNum > 0) {
            var IpStartNew = getValue('mainstartipaddr').split('.');
            var IpEndNew = getValue('mainendipaddr').split('.');
            var IpMinNew = parseInt(IpStartNew[3]);
            var IpMaxNew = parseInt(IpEndNew[3]);

            var IpStartOld = MainDhcpRange[0].startip.split('.');
            var IpEndOld = MainDhcpRange[0].endip.split('.');
            var IpMinOld = parseInt(IpStartOld[3]);
            var IpMaxOld = parseInt(IpEndOld[3]);
            if (IpMinNew > IpMinOld || IpMaxNew < IpMaxOld) {
              if (SingtelMode == '1') {
                AlertEx(dhcp2_language['bbsp_ippoolpolicyrouteinvalid_singtel']);
              }
              else {
                AlertEx(dhcp2_language['bbsp_ippoolpolicyrouteinvalid']);
              }
              return false;
            }
          }

          if (SingtelMode == '1') {
            if (false == checkLease("bbsp_pripool_singtel", MainLeasedTime.value, maindhcpLeasedTimeFrag.value, dhcp2_language)) {
              return false;
            }
          }
          else {
            if (false == checkLease("bbsp_pripool", MainLeasedTime.value, maindhcpLeasedTimeFrag.value, dhcp2_language)) {
              return false;
            }
          }


          if (GetCfgMode().PCCWHK != "1") {
            if (getValue('dnsMainPri') != '' && (isValidIpAddress(getValue('dnsMainPri')) == false || isAbcIpAddress(getValue('dnsMainPri')) == false)) {
              if (SingtelMode == '1') {
                AlertEx(dhcp2_language['bbsp_pripoolpridnsinvalid_singtel']);
              }
              else {
                AlertEx(dhcp2_language['bbsp_pripoolpridnsinvalid']);
              }

              return false;
            }
            if (TELMEX != true) {
              if (getValue('dnsMainSec') != '' && (isValidIpAddress(getValue('dnsMainSec')) == false || isAbcIpAddress(getValue('dnsMainSec')) == false)) {
                if (SingtelMode == '1') {
                  AlertEx(dhcp2_language['bbsp_pripoolsecdndinvalid_singtel']);
                }
                else {
                  AlertEx(dhcp2_language['bbsp_pripoolsecdndinvalid']);
                }
                return false;
              }
            }
          }
        }

        if ((TELMEX != true) &&
          (GetCfgMode().DT_HUNGARY != "1") &&
          (!((IsAdminUser() == false) && (GetCfgMode().PCCWHK == "1"))) &&
          (!((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY"))) &&
          (!((IsAdminUser() == false) && (norightslavefeature == "1")))) {
          if (getCheckVal("DHCPEnable") == 1) {
            if ((slv_independency == "0") && (getCheckVal("dhcpSrvType") != 1)) {
              AlertEx(dhcp2_language['bbsp_startsecdhcp']);
              return false;
            }

            var conditionroute = getValue("SlaveIpAddr");
            var conditionmask = getValue("SlaveMask");

            if (conditionpoolfeature == 1) {
              if (isValidIpAddress(getValue("SlaveIpAddr")) == false) {
                AlertEx(dhcp2_language['bbsp_secdhcpinvalid']);
                return false;
              }

              if (isValidSubnetMask(conditionmask) == false) {
                AlertEx(dhcp2_language['bbsp_secdhcpnaskinvalid']);
                return false;
              }

              if (isValidIpAddress(getValue("SlaveEthStart")) == false) {
                AlertEx(dhcp2_language['bbsp_secdhcpstartipinvalid']);
                return false;
              }

              if (isBroadcastIp(getValue("SlaveEthStart"), conditionmask) == true) {
                AlertEx(dhcp2_language['bbsp_secdhcpstartipinvalid']);
                return false;
              }

              if (false == isSameSubNet(getValue("SlaveEthStart"), conditionmask, conditionroute, conditionmask)) {
                AlertEx(dhcp2_language['bbsp_secdhcpstipmustsamesubhost']);
                return false;
              }

              if (isValidIpAddress(getValue("SlaveEthEnd")) == false) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipinvalid']);
                return false;
              }

              if (isBroadcastIp(getValue("SlaveEthEnd"), conditionmask) == true) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipinvalid']);
                return false;
              }

              if (false == isSameSubNet(getValue("SlaveEthEnd"), conditionmask, conditionroute, conditionmask)) {
                AlertEx(dhcp2_language['bbsp_secdhcpedipmustsamesubhost']);
                return false;
              }

              if (!(isEndGTEStart(getValue("SlaveEthEnd"), getValue("SlaveEthStart")))) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipgeqstartip']);
                return false;
              }

              if (getValue("SlaveEthStart") == conditionmask) {
                AlertEx(dhcp2_language['bbsp_secdhcpstartipdifroute']);
                return false;
              }

              if (getValue("SlaveEthEnd") == conditionmask) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipdifroute']);
                return false;
              }

              if (option240feature == 1) {
                var tmp = getValue('dhcpOption240');
                var tmp1 = Base64Encode(tmp);

                if (isValidAscii(tmp) != '') {
                  AlertEx(dhcp2_language['bbsp_option240invalid']);
                  return false;
                }

                if (tmp1.length > 340) {
                  AlertEx(dhcp2_language['bbsp_option240leninvalid']);
                  return false;
                }
              }
            }
            else {
              if (IsPTVDFFlag == 1) {
                if (conditionroute != IPbr0 && conditionroute != IPbr00) {
                  AlertEx(dhcp2_language['bbsp_secdhcpinvalid']);
                  return false;
                }
              }

              if (true == isSameSubNet(LanIpInfos[1].ipaddr, LanIpInfos[1].subnetmask, LanIpInfos[0].ipaddr, LanIpInfos[0].subnetmask)) {
                AlertEx(dhcp2_language['bbsp_pridhcpsecdhcpdif']);
                return false;
              }

              if (isValidIpAddress(getValue("SlaveEthStart")) == false) {
                AlertEx(dhcp2_language['bbsp_secdhcpstartipinvalid']);
                return false;
              }

              if (isBroadcastIp(getValue("SlaveEthStart"), LanIpInfos[1].subnetmask) == true) {
                AlertEx(dhcp2_language['bbsp_secdhcpstartipinvalid']);
                return false;
              }

              if (IsPTVDFFlag == 1) {
                if (false == isSameSubNet(getValue("SlaveEthStart"), conditionmask, conditionroute, conditionmask)) {
                  AlertEx(dhcp2_language['bbsp_secdhcpstipmustsamesubhost']);
                  return false;
                }
              }
              else {
                if (false == isSameSubNet(getValue("SlaveEthStart"), LanIpInfos[1].subnetmask, LanIpInfos[1].ipaddr, LanIpInfos[1].subnetmask)) {
                  AlertEx(dhcp2_language['bbsp_secdhcpstipmustsamesubhost']);
                  return false;
                }
              }

              if (isValidIpAddress(getValue("SlaveEthEnd")) == false) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipinvalid']);
                return false;
              }

              if (isBroadcastIp(getValue("SlaveEthEnd"), LanIpInfos[1].subnetmask) == true) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipinvalid']);
                return false;
              }

              if (IsPTVDFFlag == 1) {
                if (false == isSameSubNet(getValue("SlaveEthEnd"), conditionmask, conditionroute, conditionmask)) {
                  AlertEx(dhcp2_language['bbsp_secdhcpstipmustsamesubhost']);
                  return false;
                }
              }
              else {
                if (false == isSameSubNet(getValue("SlaveEthEnd"), LanIpInfos[1].subnetmask, LanIpInfos[1].ipaddr, LanIpInfos[1].subnetmask)) {
                  AlertEx(dhcp2_language['bbsp_secdhcpedipmustsamesubhost']);
                  return false;
                }
              }

              if (!(isEndGTEStart(getValue("SlaveEthEnd"), getValue("SlaveEthStart")))) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipgeqstartip']);
                return false;
              }

              if (getValue("SlaveEthStart") == LanIpInfos[1].subnetmask) {
                AlertEx(dhcp2_language['bbsp_secdhcpstartipdifroute']);
                return false;
              }

              if (getValue("SlaveEthEnd") == LanIpInfos[1].subnetmask) {
                AlertEx(dhcp2_language['bbsp_secdhcpendipdifroute']);
                return false;
              }
            }

            var timeLease = getValue('SlaveLeasedTime');
            if (false == checkLease("bbsp_secpool", timeLease, getSelectVal('dhcpLeasedTimeFrag'), dhcp2_language)) {
              return false;
            }

            if (getValue('dhcpOption60').length == 0) {
              if ((supportUnnumberMode != 1) && (CfgWord != 'MYTIME') && (CfgWord != 'TM2')) {
                AlertEx(dhcp2_language['bbsp_60required']);
                return false;
              } else {
                if (GetCheckedPortBindStr().length == 0) {
                  AlertEx(dhcp2_language['bbsp_60andsourceinfrequired']);
                  return false;
                }
              }
            }

            if (isValidAscii(getValue('dhcpOption60')) != '') {
              AlertEx(dhcp2_language['bbsp_60'] + getValue('dhcpOption60') + dhcp2_language['bbsp_60invalid']);
              return false;
            }

            if (false == isSafeStringExc(getValue('dhcpOption60'), '#=')) {
              AlertEx(dhcp2_language['bbsp_60'] + getValue('dhcpOption60') + dhcp2_language['bbsp_60invalid']);
              return false;
            }

            if (conditionpoolfeature == 1) {
              var mode = getSelectVal('Option60Mode');
              if (ParseConditionOption60Result(getValue('dhcpOption60'), mode) == false) {
                AlertEx(dhcp2_language['bbsp_60'] + getValue('dhcpOption60') + dhcp2_language['bbsp_60invalid']);
                return false;
              }
            }
            else {
              if (ParseOption60Result(getValue('dhcpOption60')) == false) {
                AlertEx(dhcp2_language['bbsp_60'] + getValue('dhcpOption60') + dhcp2_language['bbsp_60invalid']);
                return false;
              }
            }
            if (GetCfgMode().PCCWHK != "1") {
              if (getValue('dnsSecPri') != '' && (isValidIpAddress(getValue('dnsSecPri')) == false || isAbcIpAddress(getValue('dnsSecPri')) == false)) {
                AlertEx(dhcp2_language['bbsp_secpoolpridnsinvalid']);
                return false;
              }

              if (getValue('dnsSecSec') != '' && (isValidIpAddress(getValue('dnsSecSec')) == false || isAbcIpAddress(getValue('dnsSecSec')) == false)) {
                AlertEx(dhcp2_language['bbsp_secpoolsecdnsinvalid']);
                return false;
              }
            }


            var ntpip = getValue('ntpserver');
            var option43 = getValue('dhcpOption43');

            if (ntpip.length != 0) {
              if (ParseNtpServerResult(ntpip) == false) {
                return false;
              }
            }

            if (option43.length != 0) {
              if (isValidAscii(option43) == '') {
                if (IsDhcpOption43Valid(option43) == false) {
                  return false;
                }
              }
              else {
                AlertEx(dhcp2_language['bbsp_option43invalid']);
                return false;
              }
            }
          }
        }
      }


      if (false == checkPoolPara()) {
        return false;
      }

      setDisable('btnApply_ex', 1);
      setDisable('cancelValue_ex', 1);

      return true;
    }

    function IsEnableSameTime() {
      var mainEnable = getCheckVal('dhcpSrvType');
      var secEnable = getCheckVal('DHCPEnable');

      if ((mainEnable == 1) && (secEnable == 1)) {
        return true;
      }
      return false;
    }

    function ApplyOption240(base64, instance) {
      var urlpara;
      var url;
      var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';
      var Form = new webSubmitForm();

      if (instance == 0) {
        Form.addParameter('x.Value', base64);
        Form.addParameter('x.Enable', 1);
        Form.addParameter('x.Tag', 240);
        urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.DHCPOption'
          + '&RequestFile=' + RequestFile;
        url = 'add.cgi?' + urlpara;
      }
      else {
        Form.addParameter('x.Value', base64);
        urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.DHCPOption.1'
          + '&RequestFile=' + RequestFile;
        url = 'set.cgi?' + urlpara;
      }

      Form.addParameter('x.X_HW_Token', getValue('onttoken'));
      Form.setAction(url);
      Form.submit();

    }

    function ApplyBlockListA(mainVistSlaveBlock) {
      var urlpara;
      var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';
      var data = "";

      if (blockListExistA == 0 && mainVistSlaveBlock == 1) {
        urlpara = 'add.cgi?' + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_DHCPPoolBlockingList' + '&RequestFile=' + RequestFile;
        data += '&x.From=' + primaryPool + '&x.To=' + secondaryPool + '&x.X_HW_Token=' + getValue('onttoken');
      } else if (blockListExistA == 1 && mainVistSlaveBlock == 0) {
        urlpara = 'del.cgi?' + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_DHCPPoolBlockingList' + '&RequestFile=' + RequestFile;
        data += poolBlockList[blockListAInst].domain + "=" + '&x.X_HW_Token=' + getValue('onttoken');
      } else {
        return;
      }

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: data,
        url: urlpara,
        success: function (data) {
        }
      });
    }

    function ApplyBlockListB(slaveVisitMainBlock) {
      var urlpara;
      var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';
      var data = "";

      if (blockListExistB == 0 && slaveVisitMainBlock == 1) {
        urlpara = 'add.cgi?' + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_DHCPPoolBlockingList' + '&RequestFile=' + RequestFile;
        data += '&x.From=' + secondaryPool + '&x.To=' + primaryPool + '&x.X_HW_Token=' + getValue('onttoken');
      } else if (blockListExistB == 1 && slaveVisitMainBlock == 0) {
        urlpara = 'del.cgi?' + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_DHCPPoolBlockingList' + '&RequestFile=' + RequestFile;
        data += poolBlockList[blockListBInst].domain + "=" + '&x.X_HW_Token=' + getValue('onttoken');
      } else {
        return;
      }

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: data,
        url: urlpara,
        success: function (data) {
        }
      });
    }

    function GetPolicyRouteListLength(PolicyRouteList, Type) {
      var Count = 0;

      if (PolicyRouteList == null) {
        return 0;
      }
      for (var i = 0; i < PolicyRouteList.length; i++) {
        if (PolicyRouteList[i] == null) {
          continue;
        }

        if (PolicyRouteList[i].Type == Type) {
          Count++;
        }
      }

      return Count;
    }

    function GetCurrentLoginIP() {
      var CurUrlIp = (window.location.host).toUpperCase();

      return CurUrlIp;
    }

    function CheckFormBJUNICOM() {
      var ethIpAddress = getValue('ethIpAddress');
      var ethSubnetMask = getValue('ethSubnetMask');

      {
        if (isValidIpAddress(ethIpAddress) == false) {
          AlertEx(dhcp_language['bbsp_ipmhaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
          return false;
        }
        if (isValidSubnetMask(ethSubnetMask) == false) {
          AlertEx(dhcp_language['bbsp_subnetmaskmh'] + ethSubnetMask + dhcp_language['bbsp_isinvalidp']);
          return false;
        }
        if (isMaskOf24BitOrMore(ethSubnetMask) == false) {
          AlertEx(dhcp_language['bbsp_subnetmaskmh'] + ethSubnetMask + dhcp_language['bbsp_isinvalidp'] + dhcp_language['bbsp_maskerrorinfo']);
          return false;
        }

        if (isHostIpWithSubnetMask(ethIpAddress, ethSubnetMask) == false) {
          AlertEx(dhcp_language['bbsp_ipmhaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
          return false;
        }
        if (isBroadcastIp(ethIpAddress, ethSubnetMask) == true) {
          AlertEx(dhcp_language['bbsp_ipmhaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
          return false;
        }
      }


      var Reboot = (GetPolicyRouteListLength(PolicyRouteListAll, "SourceIP") > 0 && getValue('ethIpAddress') != LanIpInfos[0].ipaddr) ? dhcp_language['bbsp_resetont'] : "";
      var result = true;
      if (((getValue('ethIpAddress') != LanIpInfos[0].ipaddr) && (GetCurrentLoginIP() == LanIpInfos[0].ipaddr))) {
        result = ConfirmEx(dhcp_language['bbsp_dhcpconfirmnote'] + Reboot);
      }

      return result;


    }

    function SubmitOptions() {
      var options_60 = getValue('MultidhcpOption60');
      var options_43 = getValue('MultidhcpOption43');

      if (getValue('MultidhcpOption60').length == 0) {
        AlertEx(dhcp2_language['bbsp_60required']);
        return false;
      }

      if (isValidAscii(getValue('MultidhcpOption60')) != '') {
        AlertEx(dhcp2_language['bbsp_60'] + getValue('MultidhcpOption60') + dhcp2_language['bbsp_60invalid']);
        return false;
      }

      if (false == isSafeStringExc(getValue('MultidhcpOption60'), '#=')) {
        AlertEx(dhcp2_language['bbsp_60'] + getValue('MultidhcpOption60') + dhcp2_language['bbsp_60invalid']);
        return false;
      }
      else {
        var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';

        var DSASpecCfgParaList = new Array(new stSpecParaArray("x.VendorClassID", options_60, 1),
          new stSpecParaArray("x.X_HW_Option43", options_43, 1));
        var url = '';
        if (selctIndex == -1) {
          url = 'add.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool'
            + '&RequestFile=' + RequestFile;
        }
        else {
          url = 'set.cgi?x=' + MoptionArray[selctIndex].domain
            + '&RequestFile=' + RequestFile;
        }
        setDisable('DHCPEnable', 1);
        setDisable('dhcpSrvType', 1);
        setDisable('dhcpL2relay', 1);
        setDisable('dhcpMainOption125', 1);
        setDisable('OptionsEnable', 1);
        setDisable('btnSubmit', 1);
        setDisable('CancelOptions', 1);
        setDisable('btnApply_ex', 1);
        setDisable('cancelValue_ex', 1);
        var Parameter = {};
        Parameter.asynflag = null;
        Parameter.FormLiList = OptionsConfigFormList;
        Parameter.SpecParaPair = DSASpecCfgParaList;
        var tokenvalue = getValue('onttoken');
        HWSetAction(null, url, Parameter, tokenvalue);
      }
    }

    function IsSubmitPtvdfGuestwifi() {
      if (ptvdfflag == 1) {
        if (SlaveDhcpInfos[0].Enable == getCheckVal('DHCPEnable') && getCheckVal('DHCPEnable') == 0) {
          return false;
        }
        else {
          return true;
        }
      }
      else {
        return false;
      }
    }

    function PtvdfGuestwifiSubmit(str) {
      if (guestflag == 0 && IsSubmitPtvdfGuestwifi()) {
        var SubmitParaForm = str;
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          data: SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
          url: 'add.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool&RequestFile=html/bbsp/dhcpservercfg/dhcp2.asp',
          success: function (data) {

          }
        });
      }
    }

    function CheckDNSConfigPTVDF() {
      if ((getValue('dnsMainPri') != MainDhcpRange[0].MainPriDNS)
        || (getValue('dnsMainSec') != MainDhcpRange[0].MainSecDNS)) {
        if (false == ConfirmEx(dhcp2_language['bbsp_ptvdf_dns'])) {
          setDisable('btnApply_ex', 0);
          setDisable('cancelValue_ex', 0);
          return false;
        }
      }

      return true;
    }
    function ApplyConfig() {
      if (IsNETLIFElag == 1) {
        var bDisplay = getCheckVal('DHCPEnable');
        if (bDisplay == "1") {
          if (confirm(dhcp2_language['bbsp_DHCP_confirmtip']) == false) {
            return false;
          }
        }
      }
      if (true == IsBJUNICOMNormalUser()) {
        if ((true != CheckFormBJUNICOM()) || (true != CheckForm())) {
          return false;
        }

        var Form = new webSubmitForm();
        var url = '';
        var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';

        Form.addParameter('m.IPInterfaceIPAddress', getValue('ethIpAddress'));
        Form.addParameter('m.IPInterfaceSubnetMask', getValue('ethSubnetMask'));
        Form.addParameter('z.DHCPServerEnable', getCheckVal('dhcpSrvType'));
        if (1 == getCheckVal('dhcpSrvType')) {
          Form.addParameter('z.MinAddress', getValue('mainstartipaddr'));
          Form.addParameter('z.MaxAddress', getValue('mainendipaddr'));
        }
        Form.addParameter('z.DHCPLeaseTime', getValue('MainLeasedTime') * getValue('maindhcpLeasedTimeFrag'));

        url = 'set.cgi?'
          + 'm=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1'
          + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
          + '&RequestFile=' + RequestFile;

        Form.addParameter('x.X_HW_Token', getValue('onttoken'));

        setDisable('dhcpSrvType', 1);
        Form.setAction(url);
        Form.submit();
      }
      else if (gstuseallslvpool == "1") {
        if (true != CheckFormGuestAllSLVPool()) {
          return false;
        }
        var Form = new webSubmitForm();
        var url = '';
        var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';

        if (1 == getCheckVal('dhcpSrvType')) {
          Form.addParameter('z.MinAddress', getValue('mainstartipaddr'));
          Form.addParameter('z.MaxAddress', getValue('mainendipaddr'));
          Form.addParameter('z.DHCPLeaseTime', getValue('MainLeasedTime') * getValue('maindhcpLeasedTimeFrag'));
        }
        if (GetCfgMode().OSK == "1") {
          var DnsMStr = getValue('dnsMainPri') + ',' + getValue('dnsMainSec');
          if (getValue('dnsMainPri') == 0) {
            DnsMStr = getValue('dnsMainSec');
          }
          if (getValue('dnsMainSec') == 0) {
            DnsMStr = getValue('dnsMainPri');
          }
          Form.addParameter('z.X_HW_DNSList', DnsMStr);
          Form.addParameter('z.DHCPServerEnable', getCheckVal('dhcpSrvType'));
          Form.addParameter('z.X_HW_DHCPL2RelayEnable', getCheckVal('dhcpL2relay'));
          Form.addParameter('z.X_HW_Option125Enable', getCheckVal('dhcpMainOption125'));
        }

        url = 'set.cgi?'
          + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
          + '&RequestFile=' + RequestFile;

        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction(url);
        Form.submit();
      }
      else {

        if (false == CheckForm()) {
          return false;
        }

        if ('1' == ptvdfflag) {
          if (false == CheckDNSConfigPTVDF()) {
            return false;
          }
        }

        var Form = new webSubmitForm();
        var submitparam = "";
        with (document.forms[0]) {
          if (conditionpoolfeature == 1) {
            if (option240feature == 1) {
              var tmp = getValue('dhcpOption240');
              ApplyOption240(Base64Encode(tmp), option240instance);
            }

            Form.addParameter('y.Enable', getCheckVal('DHCPEnable'));
            if (getCheckVal("DHCPEnable") == 1) {
              if (GetCfgMode().PCCWHK != "1") {
                var DnsSStr = getValue('dnsSecPri') + ',' + getValue('dnsSecSec');
                if (getValue('dnsSecPri') == 0) {
                  DnsSStr = getValue('dnsSecSec');
                }
                if (getValue('dnsSecSec') == 0) {
                  DnsSStr = getValue('dnsSecPri');
                }
                Form.addParameter('y.DNSServers', DnsSStr);
              }

              Form.addParameter('y.IPRouters', getValue('SlaveIpAddr'));
              Form.addParameter('y.SubnetMask', getValue('SlaveMask'));
              Form.addParameter('y.MinAddress', getValue('SlaveEthStart'));
              Form.addParameter('y.MaxAddress', getValue('SlaveEthEnd'));
              Form.addParameter('y.DHCPLeaseTime', getValue('SlaveLeasedTime') * getValue('dhcpLeasedTimeFrag'));
              Form.addParameter('y.VendorClassID', getValue('dhcpOption60'));
              Form.addParameter('y.VendorClassIDMode', getSelectVal('Option60Mode'));
              if (multioptionsfeature == '1') {
                Form.addParameter('y.X_HW_Option43', getValue('dhcpOption43'));
                Form.addParameter('z.X_HW_COND_POOL_MODE', getCheckVal('OptionsEnable'));
              }
              if (supportPoolBlock == 1) {
                ApplyBlockListA(getCheckVal('MainVisitSlave'));
                ApplyBlockListB(getCheckVal('SlaveVisitMain'));
              }
              if (supportUnnumberMode == 1) {
                Form.addParameter('y.SourceInterface', GetCheckedPortBindStr());
              }
              if ((CfgWord == 'MYTIME') || (CfgWord == 'TM2')) {
                Form.addParameter('y.SourceInterface', GetCheckedPortBindStr());
                Form.addParameter('y.X_HW_DualLANEnable', getCheckVal('EnableDualLan'));
              }
            }
          } else {
            if ((IsAdminUser()) || (normaluserenable != 0)) {
              if ((TELMEX != true) &&
                (GetCfgMode().DT_HUNGARY != "1") &&
                (!((IsAdminUser() == false) && (GetCfgMode().PCCWHK == "1"))) &&
                (!((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY"))) &&
                (!((IsAdminUser() == false) && (norightslavefeature == "1"))) &&
                (IsSonetHN8055QUser() == false)) {
                Form.addParameter('y.DHCPEnable', getCheckVal('DHCPEnable'));
                if (1 == gstwfpoolfeature) {
                  if (ConditionDhcpInfos[1].Gateway == LanIpInfos[1].ipaddr) {
                    if (LanIpInfos[1].enable == '1') {
                      Form.addParameter('w.Enable', getCheckVal('DHCPEnable'));
                    }
                    else {
                      Form.addParameter('w.Enable', LanIpInfos[1].enable);
                    }
                    if ((getCheckVal('DHCPEnable') == '1') && (LanIpInfos[1].enable == '1')) {
                      Form.addParameter('w.MinAddress', ConditionDhcpInfos[1].DhcpStart);
                      Form.addParameter('w.MaxAddress', ConditionDhcpInfos[1].DhcpEnd);
                    }
                  }
                  if (ConditionDhcpInfos[1].Gateway == LanIpInfos[0].ipaddr) {
                    Form.addParameter('w.Enable', getCheckVal('dhcpSrvType'));
                    if (1 == getCheckVal('dhcpSrvType')) {
                      Form.addParameter('w.MinAddress', ConditionDhcpInfos[1].DhcpStart);
                      Form.addParameter('w.MaxAddress', ConditionDhcpInfos[1].DhcpEnd);
                    }
                  }
                }
              }
              if (getCheckVal("DHCPEnable") == 1) {
                if (GetCfgMode().PCCWHK != "1") {
                  var DnsSStr = getValue('dnsSecPri') + ',' + getValue('dnsSecSec');
                  if (getValue('dnsSecPri') == 0) {
                    DnsSStr = getValue('dnsSecSec');
                  }
                  if (getValue('dnsSecSec') == 0) {
                    DnsSStr = getValue('dnsSecPri');
                  }
                  if ((TELMEX != true) &&
                    (!((IsAdminUser() == false) && (norightslavefeature == "1"))) &&
                    (IsSonetHN8055QUser() == false)) {
                    Form.addParameter('y.DNSList', DnsSStr);
                  }
                }

                if ((TELMEX != true) &&
                  (GetCfgMode().DT_HUNGARY != "1") &&
                  (!((IsAdminUser() == false) && (GetCfgMode().PCCWHK == "1"))) &&
                  (!((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY"))) &&
                  (!((IsAdminUser() == false) && (norightslavefeature == "1"))) &&
                  (IsSonetHN8055QUser() == false)) {
                  Form.addParameter('y.StartIP', getValue('SlaveEthStart'));
                  Form.addParameter('y.EndIP', getValue('SlaveEthEnd'));
                  Form.addParameter('y.LeaseTime', getValue('SlaveLeasedTime') * getValue('dhcpLeasedTimeFrag'));
                  Form.addParameter('y.Option60', getValue('dhcpOption60'));
                  Form.addParameter('y.NTPList', getValue('ntpserver'));
                  Form.addParameter('y.Option43', getValue('dhcpOption43'));
                }
              }
            }
          }
          if (false == IsSingtelUser()) {
            Form.addParameter('z.DHCPServerEnable', getCheckVal('dhcpSrvType'));
          }
          if ((!((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY"))) &&
            (!((IsAdminUser() == false) && (hiderelay125feature == "1"))) &&
            (IsSonetHN8055QUser() == false) &&
            (IsSonetNewNormalUser() == false) &&
            (IsSingtelUser() == false)) {
            Form.addParameter('z.X_HW_DHCPL2RelayEnable', getCheckVal('dhcpL2relay'));
          }
          if ((TELMEX != true) &&
            (!((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY"))) &&
            (!((IsAdminUser() == false) && (hiderelay125feature == "1"))) &&
            (IsSonetHN8055QUser() == false) &&
            (IsSonetNewNormalUser() == false) &&
            (CfgModeWord.toUpperCase() != 'PCCW') &&
            (GetCfgMode().PCCWHK != "1") &&
            (IsSingtelUser() == false)) {
            Form.addParameter('z.X_HW_Option125Enable', getCheckVal('dhcpMainOption125'));
          }

          if (GetCfgMode().PCCWHK != "1") {
            var DnsMStr = getValue('dnsMainPri') + ',' + getValue('dnsMainSec');
            if (getValue('dnsMainPri') == 0) {
              DnsMStr = getValue('dnsMainSec');
            }
            if (getValue('dnsMainSec') == 0) {
              DnsMStr = getValue('dnsMainPri');
            }
            if ((curCfgModeWord.toUpperCase() != "HT") || (IsAdminUser())) {
              Form.addParameter('z.X_HW_DNSList', DnsMStr);
            }
          }

          if (1 == getCheckVal('dhcpSrvType')) {
            Form.addParameter('z.MinAddress', getValue('mainstartipaddr'));
            Form.addParameter('z.MaxAddress', getValue('mainendipaddr'));
          }
          Form.addParameter('z.DHCPLeaseTime', getValue('MainLeasedTime') * getValue('maindhcpLeasedTimeFrag'));
          if (GetRunningMode() == "1") {
            Form.addParameter('z.X_HW_HGWStart', getValue('HGWEthStart'));
            Form.addParameter('z.X_HW_HGWEnd', getValue('HGWEthEnd'));
            Form.addParameter('z.X_HW_STBStart', getValue('STBEthStart'));
            Form.addParameter('z.X_HW_STBEnd', getValue('STBEthEnd'));
            Form.addParameter('z.X_HW_CameraStart', getValue('CameraEthStart'));
            Form.addParameter('z.X_HW_CameraEnd', getValue('CameraEthEnd'));
            Form.addParameter('z.X_HW_ComputerStart', getValue('ComputerEthStart'));
            Form.addParameter('z.X_HW_ComputerEnd', getValue('ComputerEthEnd'));
            Form.addParameter('z.X_HW_PhoneStart', getValue('PhoneEthStart'));
            Form.addParameter('z.X_HW_PhoneEnd', getValue('PhoneEthEnd'));
          }
          if (guestflag == 0 && ptvdfflag == 1 && IsSubmitPtvdfGuestwifi()) {
            submitparam += "x.Enable=1";
            submitparam += "&x.MinAddress=" + getValue('SlaveEthStart');
            submitparam += "&x.MaxAddress=" + getValue('SlaveEthEnd');
            submitparam += "&x.IPRouters=" + LanIpInfos[1].ipaddr;
            submitparam += "&x.SubnetMask=" + LanIpInfos[1].subnetmask;
            submitparam += "&x.DHCPLeaseTime=" + getValue('SlaveLeasedTime') * getValue('dhcpLeasedTimeFrag');
          }
          if (curCfgModeWord.toUpperCase() == "AISAP") {
            Form.addParameter('k.LanInheritHsiWanDns', getCheckVal('dhcpHsiWanDns'));
          }
        }

        var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2.asp';
        var urlpara;
        if (IsEnableSameTime() == true) {
          if (conditionpoolfeature == 1) {
            urlpara = 'z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
              + '&y=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1'
              + '&RequestFile=' + RequestFile;

          } else {
            if (((IsAdminUser() == false) && (GetCfgMode().PCCWHK == "1")) ||
              (TELMEX == true) ||
              (GetCfgMode().DT_HUNGARY == "1") ||
              ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) ||
              ((IsAdminUser() == false) && (norightslavefeature == "1")) ||
              (IsSonetHN8055QUser()) ||
              (SingtelMode == '1') ||
              (curCfgModeWord.toUpperCase() == "ROMANIADT2")) {
              urlpara = 'z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                + '&RequestFile=' + RequestFile;
            } else if (gstwfpoolfeature == 1) {
              if (ptvdfflag == 1) {
                urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                  + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                  + '&y=InternetGatewayDevice.X_HW_DHCPSLVSERVER'
                  + '&RequestFile=' + RequestFile;
              }
              else {
                urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                  + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                  + '&y=InternetGatewayDevice.X_HW_DHCPSLVSERVER'
                  + '&w=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2'
                  + '&RequestFile=' + RequestFile;
              }

            }
            else {
              urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                + '&y=InternetGatewayDevice.X_HW_DHCPSLVSERVER'
                + '&RequestFile=' + RequestFile;
            }
          }
        }
        else {
          if (conditionpoolfeature == 1) {
            urlpara = 'y=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1'
              + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
              + '&RequestFile=' + RequestFile;
          } else {
            if (((IsAdminUser() == false) && (GetCfgMode().PCCWHK == "1")) ||
              (TELMEX == true) ||
              (GetCfgMode().DT_HUNGARY == "1") ||
              ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) ||
              ((IsAdminUser() == false) && (norightslavefeature == "1")) ||
              (IsSonetHN8055QUser()) ||
              (SingtelMode == '1')) {
              urlpara = 'z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                + '&RequestFile=' + RequestFile;
            } else if (gstwfpoolfeature == 1) {
              if (IsSubmitPtvdfGuestwifi()) {
                urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                  + '&y=InternetGatewayDevice.X_HW_DHCPSLVSERVER'
                  + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                  + '&w=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2'
                  + '&RequestFile=' + RequestFile;
              }
              else {
                urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                  + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                  + '&RequestFile=' + RequestFile;
              }
            }
            else if (curCfgModeWord.toUpperCase() == "AISAP") {
              urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                + '&y=InternetGatewayDevice.X_HW_DHCPSLVSERVER'
                + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                + '&k=InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization'
                + '&RequestFile=' + RequestFile;
            }
            else {
              urlpara = 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                + '&y=InternetGatewayDevice.X_HW_DHCPSLVSERVER'
                + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                + '&RequestFile=' + RequestFile;
            }
          }
        }

        PtvdfGuestwifiSubmit(submitparam);
        if (IsPTVDFFlag == 1) {
          Form.addParameter('x.IPInterfaceIPAddress', getValue('SlaveIpAddr'));
          Form.addParameter('x.IPInterfaceSubnetMask', getValue('SlaveMask'));
        }
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        var url = 'set.cgi?' + urlpara;
        setDisable('DHCPEnable', 1);
        setDisable('dhcpSrvType', 1);
        setDisable('dhcpL2relay', 1);
        setDisable('dhcpMainOption125', 1);
        setDisable('btnSubmit', 1);
        setDisable('CancelOptions', 1);
        setDisable('OptionsEnable', 1);
        setDisable('Newbutton', 1);
        setDisable('DeleteButton', 1);
        setDisable('MainVisitSlave', 1);
        setDisable('SlaveVisitMain', 1);
        setDisable('sourceInterface', 1);

        Form.setAction(url);
        Form.submit();
      }
    }

    function enbleDHCP() {
      var bDisplay = getCheckVal('DHCPEnable');

      setDisplay('SlaveConfigForm', bDisplay);

      if ((CfgWord== 'MYTIME') || (CfgWord == 'TM2')) {
        setDisplay('sourceInterfaceRow', bDisplay);
        setDisplay('EnableDualLanRow', bDisplay);
      } else if (supportUnnumberMode == '1') {
        setDisplay('sourceInterfaceRow', bDisplay);
      } else {
        setDisplay('sourceInterfaceRow', 0);
      }

      if (supportPoolBlock == '1') {
        setDisplay('MainVisitSlaveRow', bDisplay);
        setDisplay('SlaveVisitMainRow', bDisplay);
      } else {
        setDisplay('MainVisitSlaveRow', 0);
        setDisplay('SlaveVisitMainRow', 0);
      }

      setDisplay('SlaveEthStartRow', bDisplay);
      setDisplay('SlaveEthEndRow', bDisplay);
      setDisplay('SlaveLeasedTimeRow', bDisplay);
      setDisplay('dhcpOption60Row', bDisplay);
      setDisplay('SlaveIpAddrRow', bDisplay);
      setDisplay('SlaveMaskRow', bDisplay);
      if ((conditionpoolfeature == 1)) {
        setDisplay('Option60ModeRow', bDisplay);
        if (multioptionsfeature == 1) {
          setDisplay('dhcpOption43Row', bDisplay);
        }
      }
      else {
        setDisplay('dhcpOption43Row', bDisplay);
        setDisplay('ntpserverRow', bDisplay);
      }
      setDisplay('dnsSecPriRow', bDisplay);
      setDisplay('dnsSecSecRow', bDisplay);
      if ((TELMEX == true) ||
        (GetCfgMode().PCCWHK == "1") ||
        (GetCfgMode().DT_HUNGARY == "1") ||
        ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY"))) {
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
      } else {
        setDisplay("dnsSecPriRow", bDisplay);
        setDisplay("dnsSecSecRow", bDisplay);
      }
      if (bDisplay == '0') {
        setDisplay('MulitOptions', bDisplay);
        setDisplay('OptionsForm', bDisplay);
        setDisplay('OptionsEnableRow', bDisplay);
      }
      else {
        if (multioptionsfeature == '1') {
          setDisplay('MulitOptionsRow', bDisplay);
          setDisplay('OptionsEnableRow', bDisplay);
          IsShowMulitOption();
        }
      }
      if (1 == isSAFARICOM) {
        if (IsDNSLockEnable == "1") {
          setDisable("dnsSecPri", 1);
          setDisable("dnsSecSec", 1);
        }
        else {
          setDisable("dnsSecPri", 0);
          setDisable("dnsSecSec", 0);
        }

      }

      if (isTMCZST == 1) {
        setDisplay("dnsSecPriRow", 0);
        setDisplay("dnsSecSecRow", 0);
      }
    }

    function IsShowMulitOption() {
      var OptionValue = MainDhcpRange[0].OptionEnable;
      if (OptionValue == '0') {
        setDisplay('MulitOptions', 0);
      }
      else {
        setDisplay('MulitOptions', 1);
      }
    }
    var selectedPoolindex = -1;
    //MacBindIp
    function DeleteLineRow() {
      var tableRow = getElementById(TableName);
      if (tableRow.rows.length > 2)
      tableRow.deleteRow(tableRow.rows.length-1);
      return false;
    }

    function setControl(index) {
      selctIndex = index;
      if (supportMacBindIp == 0) {
        var multioption;
        if (index == -1) {
          if (MoptionArray.length >= 4) {
            setDisplay('OptionsForm', 0);
            AlertEx(dhcp2_language['bbsp_optionconfigfull']);
            return;
          }
          multioption = new MultiOption("", "", "");
          AddFlag = true;
          setDisplay('OptionsForm', 1);
          setCtlDisplay(multioption);
        }
        else if (index == -2) {
          setDisplay('OptionsForm', 0);
        }
        else {
          multioption = MoptionArray[index];
          AddFlag = false;
          setDisplay('OptionsForm', 1);
          setCtlDisplay(multioption);
        }

        setDisable('btnSubmit', 0);
        setDisable('CancelOptions', 0);
      } else {
        var record;
        if (index == -1) {
          if(dhcp.length >= 16) {
            DeleteLineRow();
            setDisplay('TableConfigInfo', 0);
            AlertEx(dhcpstatic_language_ftto['bbsp_num']);
            return;
          }
          record = null;
          addMacIpFlag = true;
          setDisplay('TableConfigInfo', 1);
          setCtlDisplayBind(record);
        }
        else if (index == -2) {
          setDisplay('TableConfigInfo', 0);
        }
        else {
          record = dhcp[index];
          addMacIpFlag = false;
          setDisplay('TableConfigInfo', 1);
          setCtlDisplayBind(record);
        }

        setDisable('btnAdd',0);
        setDisable('cancel',0);
      }
    }

    function OnDeleteButtonClick(TableID) { 
      var CheckBoxList = document.getElementsByName(TableName + 'rml');
      var Form = new webSubmitForm();
      var Count = 0;
      for (var i = 0; i < CheckBoxList.length; i++) {
          if (CheckBoxList[i].checked != true) {
            continue;
          }

          Count++;
          Form.addParameter(CheckBoxList[i].value, '');
      }
      if (supportMacBindIp == 0) {
        setDisable('DeleteButton', 1);
        setDisable('btnSubmit', 1);
        setDisable('CancelOptions', 1);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool' + '&RequestFile=html/bbsp/dhcpservercfg/dhcp2.asp');
      } else {
        if (dhcp.length == 0){
          AlertEx(dhcpstatic_language_ftto['bbsp_removealert1']);
          return;
        }
    
        if (selctIndex == -1) {
          AlertEx(dhcpstatic_language_ftto['bbsp_removealert2']);
          return;
        }

        if (Count <= 0) {
          AlertEx(dhcpstatic_language_ftto['bbsp_removealert3']);
          return;
        }
    
        if (ConfirmEx(dhcpstatic_language_ftto['bbsp_removealert4']) == false) {
          document.getElementById("DeleteButton").disabled = false;
          return;
        }
        setDisable('DeleteButton', 1);
        setDisable('btnAdd',1);
        setDisable('cancel',1);	
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' +'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress' + '&RequestFile=html/bbsp/dhcpservercfg/dhcp2.asp');
      }
      Form.submit();
    }


    function setCtlDisplayBind(record) {
      if (record == null) {
        setText('ipAddr','');
        setText('macAddr','');
      }
      else {
        setText('ipAddr',record.ipAddress);
        setText('macAddr',record.macAddress);
      }
    }

    function setCtlDisplay(multioption) {
      setText('MultidhcpOption60', multioption.VendorClassID);
      setText('MultidhcpOption43', multioption.X_HW_Option43);
    }

    function SetDHCPL2Relay() {
      var enable = getCheckVal('dhcpL2relay');
    }

    function SetDNSServerEnable() {
      var enable = getCheckVal('dhcpHsiWanDns');
      if ((IsAdminUser()) || (IsAISAPUser())) {
        setDisable('dnsMainPri', enable);
        setDisable('dnsMainSec', enable);
        setText('dnsMainPri', "");
        setText('dnsMainSec', "");
      }
    }

    function SetMainDHCPServer() {
      var enable = getCheckVal('dhcpSrvType');
      SetDHCPServerDisplay(enable);
    }

    function SetDHCPServerDisplay(value) {
      if (value == 1 || value == '1') {
        setDisable("mainstartipaddr", 0);
        setDisable("mainendipaddr", 0);
        if (false == IsBJUNICOMNormalUser()) {
          setDisable("MainLeasedTime", 0);
        }
        setDisable("maindhcpLeasedTimeFrag", 0);

        setDisable("HGWEthStart", 0);
        setDisable("HGWEthEnd", 0);
        setDisable("STBEthStart", 0);
        setDisable("STBEthEnd", 0);
        setDisable("CameraEthStart", 0);
        setDisable("CameraEthEnd", 0);
        setDisable("ComputerEthStart", 0);
        setDisable("ComputerEthEnd", 0);
        setDisable("PhoneEthStart", 0);
        setDisable("PhoneEthEnd", 0);
      }
      else {
        setDisable("mainstartipaddr", 1);
        setDisable("mainendipaddr", 1);
        setDisable("MainLeasedTime", 1);
        setDisable("maindhcpLeasedTimeFrag", 1);

        setDisable("HGWEthStart", 1);
        setDisable("HGWEthEnd", 1);
        setDisable("STBEthStart", 1);
        setDisable("STBEthEnd", 1);
        setDisable("CameraEthStart", 1);
        setDisable("CameraEthEnd", 1);
        setDisable("ComputerEthStart", 1);
        setDisable("ComputerEthEnd", 1);
        setDisable("PhoneEthStart", 1);
        setDisable("PhoneEthEnd", 1);
      }
    }

    function CancelOption() {
      setDisplay('OptionsForm', 0);
    }

    function CancelConfig() {

      LoadFrame();
    }

    function DhcpOptionsselectRemoveCnt(val) {

    }
    var TableClass = new stTableClass("table_title width_per30", "table_right width_per70", "", "Select");

    function InitLeasedTime() {
      var LeasedTimeIdArray = ["maindhcpLeasedTimeFrag", "dhcpLeasedTimeFrag"];
      for (var i = 0; i < LeasedTimeIdArray.length; i++) {
        var LeasedTimeId = "#" + LeasedTimeIdArray[i];
        if (ProductType == '2') {
          if ('DNZTELECOM2WIFI' != CfgModeWord.toUpperCase()) {
            $(LeasedTimeId).append('<option value="60">' + dhcp2_language['bbsp_minute_xd'] + '</option>');
          }
          $(LeasedTimeId).append('<option value="3600">' + dhcp2_language['bbsp_hour_xd'] + '</option>');
          $(LeasedTimeId).append('<option value="86400">' + dhcp2_language['bbsp_day_xd'] + '</option>');
          $(LeasedTimeId).append('<option value="604800">' + dhcp2_language['bbsp_week_xd'] + '</option>');
        }
        else {
          $(LeasedTimeId).append('<option value="60">' + dhcp2_language['bbsp_minute'] + '</option>');
          $(LeasedTimeId).append('<option value="3600">' + dhcp2_language['bbsp_hour'] + '</option>');
          $(LeasedTimeId).append('<option value="86400">' + dhcp2_language['bbsp_day'] + '</option>');
          $(LeasedTimeId).append('<option value="604800">' + dhcp2_language['bbsp_week'] + '</option>');
        }
      }
    }

    function InitOption60Mode() {
      $("#Option60Mode").append('<option value="Exact">' + dhcp2_language['bbsp_op60_exact'] + '</option>');
      $("#Option60Mode").append('<option value="Prefix">' + dhcp2_language['bbsp_op60_prefix'] + '</option>');
      $("#Option60Mode").append('<option value="Suffix">' + dhcp2_language['bbsp_op60_suffix'] + '</option>');
      $("#Option60Mode").append('<option value="Substring">' + dhcp2_language['bbsp_op60_substring'] + '</option>');
    }

  </script>
</head>

<body onLoad="LoadFrame();" class="mainbody">
  <div id="ConfigForm" action="../network/set.cgi">
    <script language="JavaScript" type="text/javascript">
      if (true == IsBJUNICOMNormalUser()) {
        HWCreatePageHeadInfo("dhcptitle", GetDescFormArrayById(dhcp_language, "bbsp_mune"), GetDescFormArrayById(dhcp_language, ""), false);
        document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title'] + dhcp_language['bbsp_dhcp_title1'];
      }
      else {
        if ("1" == GetRunningMode()) {
          HWCreatePageHeadInfo("dhcp2", GetDescFormArrayById(dhcp2_language, "bbsp_mune"), GetDescFormArrayById(dhcp2_language, "bbsp_dhcp2_title"), false);
        } else if (IsPTVDFFlag == 1) {
          HWCreatePageHeadInfo("dhcp2", GetDescFormArrayById(dhcp2_language, "bbsp_mune"), GetDescFormArrayById(dhcp2_language, "bbsp_dhcp2_title2_vdf"), false);
        }
        else {
          HWCreatePageHeadInfo("dhcp2", GetDescFormArrayById(dhcp2_language, "bbsp_mune"), GetDescFormArrayById(dhcp2_language, "bbsp_dhcp2_title2"), false);
        }
      }
    </script>
    <div class="title_spread"></div>
    <div id="DhcpServerPanel">
      <form id="PriPoolConfigForm">
        <table width="100%" id="DhcpServerFormtable" border="0" cellpadding="0" cellspacing="0" class="func_title">
          <tr>
            <script language="JavaScript" type="text/javascript">
              if (SingtelMode == '1') {
                document.write('<td BindText="bbsp_pripool_singtel"></td>');
              }
              else {
                var shouldHide = false;

                if ((DBAA1 == "1") && (curUserType != dbaa1SuperSysUserType)) {
                  shouldHide = true;
                }

                if (shouldHide == false) {
                  document.write('<td BindText="bbsp_pripool"></td>');
                }
              }
            </script>
          </tr>
        </table>


        <table border="0" cellpadding="0" cellspacing="1" width="100%">
          <li id="ethIpAddress" RealType="TextBox" DescRef="bbsp_ip" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="TRUE" BindField="m.IPInterfaceIPAddress" MaxLength="15" InitValue="Empty" />
          <li id="ethSubnetMask" RealType="TextBox" DescRef="bbsp_ethIpMask" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="TRUE" BindField="m.IPInterfaceSubnetMask" MaxLength="15" InitValue="Empty" />
          <script language="JavaScript" type="text/javascript">
            if (SingtelMode == '1') {
              document.write("\<li   id=\"dhcpSrvType\" RealType=\"CheckBox\" DescRef=\"bbsp_enablepridhcpmh_singtel\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\"   Require=\"FALSE\"    BindField=\"Empty\"   InitValue=\"Empty\"  ClickFuncApp=\"onclick=SetMainDHCPServer\"\/\>");
            }
            else {
              document.write("\<li   id=\"dhcpSrvType\" RealType=\"CheckBox\" DescRef=\"bbsp_enablepridhcpmh\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\"    BindField=\"Empty\"   InitValue=\"Empty\"  ClickFuncApp=\"onclick=SetMainDHCPServer\"\/\>");
            }
          </script>
          <li id="dhcpL2relay" RealType="CheckBox" DescRef="bbsp_enablel2relaymh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="FALSE" BindField="Empty" InitValue="Empty" ClickFuncApp="onclick=SetDHCPL2Relay" />
          <li id="dhcpMainOption125" RealType="CheckBox" DescRef="bbsp_main_option125" RemarkRef="Empty"
            ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />
          <li id="LanHostIP" RealType="HtmlText" DescRef="bbsp_lanhostmh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="FALSE" BindField="Empty" InitValue="Empty" />
          <li id="LanHostMask" RealType="HtmlText" DescRef="bbsp_maskmh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="FALSE" BindField="Empty" InitValue="Empty" />
          <li id="mainstartipaddr" RealType="TextBox" DescRef="bbsp_startipmh" RemarkRef="bbsp_mustbesamesubnet"
            ErrorMsgRef="Empty" Require="TRUE" BindField="Empty" InitValue="Empty" MaxLength="15" />
          <li id="mainendipaddr" RealType="TextBox" DescRef="bbsp_endipmh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="TRUE" BindField="Empty" InitValue="Empty" MaxLength="15" />
          <li id="MainLeasedTime" RealType="TextOtherBox" DescRef="bbsp_leasedmh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="FALSE" BindField="Empty" Elementclass="TextBox_2"
            InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'maindhcpLeasedTimeFrag'},{AttrName:'class',AttrValue:'Select_2'}]}]" />
          <li id="dhcpHsiWanDns" RealType="CheckBox" DescRef="bbsp_enablehsiwandns" RemarkRef="bbsp_commenthsiwandns"
            ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"
            ClickFuncApp="onclick=SetDNSServerEnable" />
          <li id="dnsMainPri" RealType="TextBox" DescRef="bbsp_pridnsmh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="FALSE" BindField="Empty" InitValue="Empty" MaxLength="15" />
          <li id="dnsMainSec" RealType="TextBox" DescRef="bbsp_secdnsmh" RemarkRef="Empty" ErrorMsgRef="Empty"
            Require="FALSE" BindField="Empty" InitValue="Empty" MaxLength="15" />
        </table>
        <script>
          PriPoolConfigFormList = HWGetLiIdListByForm("PriPoolConfigForm");
          HWParsePageControlByID("PriPoolConfigForm", TableClass, dhcp2_language, null);
        </script>
      </form>

      <div id="DhcpPoolPanel" style="display:none">
        <div class="func_spread"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
          <tr>
            <td BindText="bbsp_pripoolsub"></td>
          </tr>
        </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
          <tbody id='dhcpPoolInfo'>
            <tr>
              <td class="table_title width_per25" BindText='bbsp_devtype'></td>
              <td class="table_right width_per15" BindText='bbsp_startip'></td>
              <td class="table_right width_per60" BindText='bbsp_endip'></td>
            </tr>
            <tr>
              <td class="table_title width_per25" BindText='bbsp_hgwmh'></td>
              <td class="table_right width_per15">
                <div align="left">
                  <input type='text' id='HGWEthStart' name='HGWEthStart' maxlength='15'>
                </div>
              </td>
              <td class="table_right width_per60"> <input type='text' id='HGWEthEnd' name='HGWEthEnd' maxlength='15'>
              </td>
            </tr>
            <tr>
              <td class="table_title width_per25" BindText='bbsp_stbmh'></td>
              <td class="table_right width_per15"> <input type='text' id='STBEthStart' name='STBEthStart'
                  maxlength='15'></td>
              <td class="table_right width_per60"> <input type='text' id='STBEthEnd' name='STBEthEnd' maxlength='15'>
              </td>
            </tr>
            <tr>
              <td class="table_title width_per25" BindText='bbsp_cameramh'></td>
              <td class="table_right width_per15"> <input type='text' id='CameraEthStart' name='CameraEthStart'
                  maxlength='15'></td>
              <td class="table_right width_per60"> <input type='text' id='CameraEthEnd' name='CameraEthEnd'
                  maxlength='15'></td>
            </tr>
            <tr>
              <td class="table_title width_per25" BindText='bbsp_computermh'></td>
              <td class="table_right width_per15"> <input type='text' id='ComputerEthStart' name='ComputerEthStart'
                  maxlength='15'></td>
              <td class="table_right width_per60"> <input type='text' id='ComputerEthEnd' name='ComputerEthEnd'
                  maxlength='15'></td>
            </tr>
            <tr>
              <td class="table_title width_per25" BindText='bbsp_phonemh'></td>
              <td class="table_right width_per15"> <input type='text' id='PhoneEthStart' name='PhoneEthStart'
                  maxlength='15'></td>
              <td class="table_right width_per60"> <input type='text' id='PhoneEthEnd' name='PhoneEthEnd'
                  maxlength='15'></td>
            </tr>
          </tbody>
        </table>
      </div>
      <script language="JavaScript" type="text/javascript">
        if (SingtelMode == '1') {
          document.write(" \<br\>  Note: For static IP address configuration, the value of the last octet must be within 64 - 127.");
        }
      </script>
      <div id='SecondaryServerPool' style="display:none">
        <div class="func_spread"></div>

        <form id="SecPoolConfigForm">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
            <tr>
              <td id="SecPoolInfoBar">
                <script>
                  if (IsMaxisNormalUser() == false) {
                    if (conditionpoolfeature == '1') {
                      document.write(dhcp2_language['bbsp_conpool']);
                    } else {
                      document.write(dhcp2_language['bbsp_secpool']);
                    }
                  }

                </script>
              </td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <li id="DHCPEnable" RealType="CheckBox" DescRef="bbsp_enablesecvermh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" ClickFuncApp="onclick=enbleDHCP" />
          </table>
          <script>
            if (IsMaxisNormalUser() == false) {
              SecPoolConfigFormList = HWGetLiIdListByForm("SecPoolConfigForm", SecPoolReload);
              HWParsePageControlByID("SecPoolConfigForm", TableClass, dhcp2_language, SecPoolReload);
              if (conditionpoolfeature == '1') {
                document.getElementById("DHCPEnable").title = dhcp2_language['bbsp_dhcp_con_enable'];
              } else {
                document.getElementById("DHCPEnable").title = dhcp2_language['bbsp_dhcp_enable'];
              }
            }

          </script>
        </form>

        <form id="SlaveConfigForm" style="display:none">
          <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <li id="MainVisitSlave" RealType="CheckBox" DescRef="bbsp_main_visit_slave" RemarkRef="Empty"
              ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />
            <li id="SlaveVisitMain" RealType="CheckBox" DescRef="bbsp_slave_visit_main" RemarkRef="Empty"
              ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />
            <script language="JavaScript" type="text/javascript">
              if ((CfgWord == 'MYTIME') || (CfgWord == 'TM2')) {
                  document.write("\<li id=\"EnableDualLan\"  RealType=\"CheckBox\"  DescRef=\"bbsp_enableduallan\"  RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"Empty\"/>");
              }
            </script>
            <li id="SlaveIpAddr" RealType="TextBox" DescRef="bbsp_ipmh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" />
            <li id="SlaveMask" RealType="TextBox" DescRef="bbsp_maskmh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" />
            <li id="SlaveEthStart" RealType="TextBox" DescRef="bbsp_startipmh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="TRUE" BindField="Empty" InitValue="Empty" MaxLength="15" />
            <li id="SlaveEthEnd" RealType="TextBox" DescRef="bbsp_endipmh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="TRUE" BindField="Empty" InitValue="Empty" MaxLength="15" />
            <li id="SlaveLeasedTime" RealType="TextOtherBox" DescRef="bbsp_leasedmh" RemarkRef="Empty"
              ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" Elementclass="TextBox_2"
              InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'dhcpLeasedTimeFrag'},{AttrName:'class',AttrValue:'Select_2'}]}]" />
            <script language="JavaScript" type="text/javascript">
              if ((supportUnnumberMode == '1') || (CfgWord == 'MYTIME') || (CfgWord == 'TM2')) {
                document.write("\<li id=\"dhcpOption60\"  RealType=\"TextBox\"  DescRef=\"bbsp_op60mh\"  RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" Elementclass=\"TextBoxLtr\" InitValue=\"Empty\" TitleRef=\"bbsp_60prnote\"  MaxLength=\"256\"/>");
                document.write("\<li id='sourceInterface' RealType=\"CheckBoxList\" DescRef=\"bbsp_sourceinf\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"d.sourceInterface\" InitValue=\"[{TextRef:'LAN1',Value:'LAN1'},{TextRef:'LAN2',Value:'LAN2'},{TextRef:'LAN3',Value:'LAN3'},{TextRef:'LAN4',Value:'LAN4'}, {TextRef:'LAN5',Value:'LAN5'}, {TextRef:'LAN6',Value:'LAN6'}, {TextRef:'LAN7',Value:'LAN7'}, {TextRef:'LAN8',Value:'LAN8'},{TextRef:'SSID1',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'}]\" ClickFuncApp=\"Empty\"\/\> ");
              } else {
                document.write("\<li id=\"dhcpOption60\"  RealType=\"TextBox\"  DescRef=\"bbsp_op60mh\"  RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"Empty\" Elementclass=\"TextBoxLtr\" InitValue=\"Empty\" TitleRef=\"bbsp_60prnote\"  MaxLength=\"256\"/>");
              }
            </script>
            <li id="Option60Mode" RealType="DropDownList" DescRef="bbsp_op60_modemh" RemarkRef="Empty"
              ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />
            <li id="dhcpOption43" RealType="TextBox" DescRef="bbsp_op43mh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" Elementclass="TextBoxLtr" InitValue="Empty"
              TitleRef="bbsp_option43prnote" MaxLength="64" />
            <li id="ntpserver" RealType="TextBox" DescRef="bbsp_ntpserver" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" TitleRef="bbsp_ntpserverprnote" MaxLength="64" />
            <li id="dnsSecPri" RealType="TextBox" DescRef="bbsp_pridnsmh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" MaxLength="15" />
            <li id="dnsSecSec" RealType="TextBox" DescRef="bbsp_secdnsmh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" MaxLength="15" />
            <li id="dhcpOption240" RealType="TextBox" DescRef="bbsp_op240mh" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" Elementclass="TextBoxLtr" InitValue="Empty" MaxLength="522" />
            <li id="OptionsEnable" RealType="CheckBox" DescRef="bbsp_enablOptions" RemarkRef="Empty" ErrorMsgRef="Empty"
              Require="FALSE" BindField="Empty" InitValue="Empty" />
          </table>
          <script>
            SlaveConfigFormList = HWGetLiIdListByForm("SlaveConfigForm", SlaveCfgReload);
            HWParsePageControlByID("SlaveConfigForm", TableClass, dhcp2_language, SlaveCfgReload);
          </script>
        </form>
      </div>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button">
        <tr>
          <td class='width_per25'></td>
          <td class="table_submit">
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px"
              onClick="ApplyConfig();">
              <script>document.write(dhcp2_language['bbsp_app']);</script>
            </button>
            <button name="cancelValue_ex" id="cancelValue_ex" type="button" class="CancleButtonCss buttonwidth_100px"
              onClick="CancelConfig();">
              <script>document.write(dhcp2_language['bbsp_cancel']);</script>
            </button>
        </tr>
      </table>
    </div>
  </div>
  <div class="func_spread"></div>
  <div id="MulitOptions" style="display:none">
    <div class="func_spread"></div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
      <tr>
        <td>
          <script>document.write(dhcp2_language["bbsp_enablOptions"]);</script>
        </td>
      </tr>
    </table>
    <script language="JavaScript" type="text/javascript">
      var optionsConfiglistInfo = new Array(new stTableTileInfo("Empty", "align_center width_per5", "DomainBox"),
        new stTableTileInfo("bbsp_op60", "align_center width_per25", "VendorClassID", false, 25),
        new stTableTileInfo("bbsp_MultiOption43", "align_center width_per25 restrict_dir_ltr", "X_HW_Option43", false, 25), null);
      var ColumnNum = optionsConfiglistInfo.length - 1;
      var ShowButtonFlag = true;
      var DhcpStaticTableConfigInfoList = new Array();
      var TableDataInfo = HWcloneObject(MoptionArray, 1);
      TableDataInfo.push(null);
      HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, optionsConfiglistInfo, dhcp2_language, null);
    </script>
    <form id="OptionsForm" style="display:none">
      <table border="0" cellpadding="0" cellspacing="1" width="100%">
        <li id="MultidhcpOption60" RealType="TextBox" DescRef="bbsp_op60mh" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="TRUE" BindField="x.VendorClassID" Elementclass="TextBoxLtr" InitValue="Empty" MaxLength="256" />
        <li id="MultidhcpOption43" RealType="TextBox" DescRef="bbsp_op43mh" RemarkRef="Empty" ErrorMsgRef="Empty"
          Require="FALSE" BindField="x.X_HW_Option43" Elementclass="TextBoxLtr" InitValue="Empty" MaxLength="64" />
      </table>
      <script>
        OptionsConfigFormList = HWGetLiIdListByForm("OptionsForm", null);
        HWParsePageControlByID("OptionsForm", TableClass, dhcp2_language, null);
      </script>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button">
        <tr>
          <td class='width_per25'></td>
          <td class="table_submit">
            <button id="btnSubmit" name="btnSubmit" type="button" class="ApplyButtoncss buttonwidth_50px"
              onClick="SubmitOptions();">
              <script>document.write(dhcp2_language['bbsp_app']);</script>
            </button>
            <button name="CancelOptions" id="CancelOptions" type="button" class="CancleButtonCss buttonwidth_50px"
              onClick="CancelOption();">
              <script>document.write(dhcp2_language['bbsp_cancel']);</script>
            </button>
        </tr>
      </table>
    </form>
    <br>
    <br>
  </div>
  <script language="JavaScript" type="text/javascript">
    InitLeasedTime();
    InitOption60Mode();
    if (IsMaxisNormalUser() == false) {
      getElById("DHCPEnableRow").title = dhcp2_language['bbsp_dhcp_enable'];
    }
  </script>
  <div id='DHCPMacBindIp' style="display:none">
    <script language="JavaScript" type="text/javascript">
      if (supportMacBindIp == 1) {
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        var DhcpStaticConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),
                                               new stTableTileInfo("bbsp_macaddrtitle","","macAddress"),									
                                               new stTableTileInfo("bbsp_ipaddrtitle","","ipAddress"),
                                               null);									
        var ColumnNum = 3;
        var ShowButtonFlag = true;
        var DhcpStaticTableConfigInfoList = new Array();
        var TableDataInfo = HWcloneObject(dhcp, 1);
        TableDataInfo.push(null);
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, DhcpStaticConfiglistInfo, dhcpstatic_language_ftto, null);
      }
    </script>
    <form id="TableConfigInfo" style="display:none;"> 
        <table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
            <li id="macAddr" RealType="TextBox" DescRef="bbsp_macaddr" RemarkRef="bbsp_macaddform" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Chaddr" Elementclass="InputDhcp" InitValue="Empty"/>
            <script language="JavaScript" type="text/javascript">
              if (supportMacBindIp == 1) {
                if (SingtelMode == '1')
                {
                    document.write(" \<li id=\"ipAddr\" RealType=\"TextBox\" DescRef=\"bbsp_ipaddr\" RemarkRef=\"bbsp_ipaddform\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"x.Yiaddr\" Elementclass=\"InputDhcp\" InitValue=\"Empty\"\/\> ");
                }
                else
                {
                    document.write(" \<li id=\"ipAddr\" RealType=\"TextBox\" DescRef=\"bbsp_ipaddr\" RemarkRef=\"\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"x.Yiaddr\" Elementclass=\"InputDhcp\" InitValue=\"Empty\"\/\> ");	
                }
              }
            </script>	
        </table>
        <script language="JavaScript" type="text/javascript">
          if (supportMacBindIp == 1) {
            DhcpStaticConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
            HWParsePageControlByID("TableConfigInfo", TableClass, dhcpstatic_language_ftto, null);
          }
        </script>
        <table width="100%" border="0" class="table_button">
          <tr align="center">
               <td class="table_submit">
                   <input type="hidden">
                   <button id="btnAdd" name="btnAdd" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="AddSubmitParam2();"/>
                   <script>
                     if (supportMacBindIp == 1) {
                       document.write(dhcpstatic_language_ftto['bbsp_apply']);
                     }
                   </script>
                   </button>
                   <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="Cancel();"/>
                   <script>
                    if (supportMacBindIp == 1) {
                       document.write(dhcpstatic_language_ftto['bbsp_cancle']);
                     }
                   </script>
                   </button>
               </td>
           </tr>
       </table>
    </form>
  </div>
</body>

</html>