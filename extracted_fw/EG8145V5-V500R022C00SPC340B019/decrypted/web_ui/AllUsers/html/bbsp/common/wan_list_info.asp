var CfgModePCCWHK = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PCCW);%>";
var SupportIPv6 = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>";
var supportTelmex = "<%HW_WEB_GetFeatureSupport(BBSP_FT_TELMEX);%>";
var SetIdleDisconnectMode = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PPPOE_DETECTUPSTREAM);%>";
var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var RdFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPV6_6RD);%>";
var RadioWanFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_RADIO_WAN_LOAD);%>";
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var radio_hidepassword=",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var IsSupportVoice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var SingtelModeEX = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL_EX);%>';
var ROSTelecomFeature = '<%HW_WEB_GetFeatureSupport(FT_ROS_TELECOM_GLOBAL);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var IsDSLSURPPORT   = '<%HW_WEB_GetFeatureSupport(HW_FT_DSL_SURPPORT);%>';
var isSupportVLAN0 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_VLAN0_TAG);%>';

var IsCMCC = '<%HW_WEB_GetFeatureSupport(HW_BBSP_FT_CMCC_RMS);%>';
var IsJSCT = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_JSCT);%>';
var IsCTCOM = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_CTCOM);%>';
var IsCU = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_CU);%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var APAutoUPPortFlag = '<%HW_WEB_GetFeatureSupport(FT_AP_WEB_SELECT_UPPORT);%>';
var WANMODEChange = '<%HW_WEB_GetFeatureSupport(FT_WANMODE_TRANSLATE);%>';
var vxlanfeature = <%HW_WEB_GetFeatureSupport("FT_VXLAN");%>;
var tedataGuide = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>';
var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
var pppoeUserName = '<%HW_WEB_GetSPEC(SPEC_DEFAULT_PPPOE_USERNAME.STRING);%>';
var supportOnuBind = '<%HW_WEB_GetFeatureSupport(FT_ONU_VLAN_WAN_CFG);%>';
var hideVlan = '<%HW_WEB_GetFeatureSupport(FT_DESKAP_MODE_SIMPLE);%>';

function SupportTtnet()
{
    return (CfgModeWord.toUpperCase() == "DTTNET2WIFI" || CfgModeWord.toUpperCase() == "TTNET2");
}

function IsAdminUser()
{
    if (CfgModeWord.toUpperCase() == "DBAA1") {
        return curUserType == '2';
    }

	if (CfgModeWord.toUpperCase() == "DGRWIND") {
		curUserType = '0';
	}

    if ((CfgModeWord.toUpperCase() == "CNT") || (CfgModeWord.toUpperCase() == "CNT2")) {
        return true;
    }

    if (CfgModeWord.toUpperCase() == 'DNOVA2WIFI') {
        curUserType = '0';
    }

    return curUserType == '0';
}

function Is3TMode()
{
    if ('1' == IsCMCC || '1' == IsJSCT || '1' == IsCTCOM || '1' == IsCU)
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsXdProduct()
{
    return '2'==ProductType;
}

if (ProductType == '3')
{
    function MainDhcpInfo(domain, DocsisVersion, FirmwareVersion, Status, Security, Ipv6Addr, Ipv4Addr, LeaseTime, RebindTime, ReNewTime, CmMac, IpProvMode)
    {
        this.domain            = domain;
        this.DocsisVersion     = DocsisVersion;
        this.FirmwareVersion   = FirmwareVersion;
        this.Status            = Status;
        this.Security          = Security;
        this.Ipv6Addr          = Ipv6Addr;
        this.Ipv4Addr          = Ipv4Addr;
        this.LeaseTime         = LeaseTime;
        this.RebindTime        = RebindTime;
        this.ReNewTime         = ReNewTime;
        this.CmMac             = CmMac;
        this.IpProvMode        = IpProvMode;
    }

    function ConfigCmAnnexType(domain, CmAnnexType)
    {
        this.domain  = domain;
        this.CmAnnexType = CmAnnexType;
    }

    var MainDhcpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Docsis.X_HW_CMINFO,DocsisVersion|FirmwareVersion|Status|Security|Ipv6Addr|Ipv4Addr|LeaseTime|RebindTime|ReNewTime|CmMac|IpProvMode,MainDhcpInfo);%>;
    var CmAnnexType = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Docsis.X_HW_ANNEXTYPE,CmAnnexType,ConfigCmAnnexType);%>;
}

var RADIOWAN_NAMEPREFIX = "RADIO";

function IsCmcc_rmsMode()
{
    var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
    if ('1' == Custom_cmcc_rms )
    {
        return true;
    }
    else
    {
        return false;
    }
}

function stAuthState(AuthState)
{
    this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>;
var SimIsAuth=SimConnStates[0].AuthState;
var JsctSpecVlan='<%HW_WEB_GetSPEC(BBSP_SPEC_FILTERWAN_BYVLAN.STRING);%>';

function GetWebConfigRGEnable()
{
    var WebConfigRGEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPWebCustomization.WebConfigRGEnable,DB);%>';

    switch(WebConfigRGEnable)
    {
        case '0':
        case '1':
            return WebConfigRGEnable;
        default:
            return '0';
    }
}

function bin3board()
{
    if((productName == 'HG8242') || (productName == 'HG8010') || (productName == 'HG8110') || (productName == 'HG8120') || (productName == 'HG8240B') || (productName == 'HG8240J') || (productName == 'HG8240S') || (productName == 'HG8040'))
    {
        return true;
    }
    return false;
}

function bin4board_nonvoice()
{
    if(productName == 'HG8045A' || productName == 'HG8045H' || productName == 'HG8045D' || productName == 'HG8021H' || productName == 'HG8045A2')
    {
        return true;
    }
    return false;
}

var FtWebRgEn = "<% HW_WEB_GetFeatureSupport(BBSP_FT_WEB_CFG_RG_EN_VALID);%>";
var FtBin5Enhanced = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BIN5_ENHANCED);%>";
var FtBin5Board = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BIN5_BOARD);%>";
var IsSupportBridgeWan = "<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>";

function bin5board()
{
    var name = productName.toUpperCase();
    if ("1" == FtBin5Enhanced){
        return false;
    }

    if(name == 'HG8240F')
    {
        if (("1" == FtWebRgEn) && ('1' == GetWebConfigRGEnable()))
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    if ("1" == FtBin5Board)
    {
        return true;
    }

    return false;
}

function IsSonetUser()
{
    if ((SonetFlag == '1') && (IsAdminUser() == false))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsE8cOrCMCC_RMS()
{
    if(('E8C' == CurrentBin.toUpperCase()) || (IsCmcc_rmsMode()))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsSCCT()
{
    return ((CfgModeWord.toUpperCase() == "SCCT") || (CfgModeWord.toUpperCase() == "SCSCHOOL"));
}

function IsRDSGatewayUser()
{
    if (('RDSGATEWAY' == CfgModeWord.toUpperCase()) && (IsAdminUser() == false))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsVnpt()
{
    return ('VNPT' == CfgModeWord.toUpperCase());
}

function dbaa1FilterWan(WanItem)
{
    var dbaa1SuperSysUserType = '2';

    if (curUserType == dbaa1SuperSysUserType) {
        return true;
    }

    var isADWan = WanItem.WanAccessType == "DSL";
    var isVDWan = WanItem.WanAccessType == "VDSL";
    var isLTEWan = WanItem.X_HW_LowerLayers.indexOf("lte") >= 0;
    var isInternetWan = WanItem.ServiceList.indexOf("INTERNET") >= 0;

    if (isLTEWan) {
        return true;
    }

    if (dbaa1Mode == 'MU') {
        return (isADWan || isVDWan) && isInternetWan;
    } else if (dbaa1Mode == 'SU') {
        return false;
    } else if (dbaa1Mode == 'VoB') {
        if (isADWan) {
            return (WanItem.DestinationAddress == '8/48') || (WanItem.DestinationAddress == '8/49');
        }
        if (isVDWan) {
            return (WanItem.VlanId == '2') || (WanItem.VlanId == '20');
        }
    }

    return false;
}

function filterWanByFeature(WanItem)
{
    var filterWanFeater = "<%HW_WEB_GetFeatureSupport(FT_NORMAL_ONLY_SHOW_PPPOE_INFO);%>";
    var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
	var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";

    if (DBAA1 == "1") {
        return dbaa1FilterWan(WanItem);
    }

    if ((CfgModeWord.toUpperCase() == 'TELECENTRO') && (IsAdminUser() == false)) {
        if(WanItem.ServiceList.indexOf("INTERNET") == -1) {
            return false;
        } else {
            return true;
        }
    }

    if ((CfgModeWord.toUpperCase() == "TURKCELL2")) {
        if ((IsAdminUser() == false) && (WanItem.ServiceList.indexOf("INTERNET") == -1)) {
            return false;
        }
        return true;
    }

    if ((IsAdminUser() == false) && (CfgModeWord.toUpperCase() == "DICELANDVDF") && 
        (WanItem.ServiceList.toString().toUpperCase() == "IPTV")) {
        return true;
    }

    // WANMODEChange为1表示开启WAN类型路由桥接切换(IPOE\PPPOE)
    if ((WANMODEChange == 1) && (IsAdminUser() == false)) {
        if ((WanItem.ServiceList.indexOf("INTERNET") == -1) ||
            (WanItem.ServiceList.indexOf("TR069") >= 0) ||
            (WanItem.ServiceList.indexOf("VOIP") >= 0) ||
            (WanItem.ServiceList.indexOf("IPTV") >= 0)) {
            return false;
        } else {
            return true;
        }
    }

    if ((GetCfgMode().TRUE == "1") &&
        (WanItem.EncapMode.toUpperCase() == "PPPOE") &&
        (IsAdminUser() == false)) {
        if(WanItem.ServiceList.indexOf("INTERNET") < 0) {
            return false;
        }
        return true;
    }

    if ((IsAdminUser() == false) && (CfgModeWord.toUpperCase() == "POLNETIA") &&
        (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)) {
        return true;
    }

    if ((IsAdminUser() == false) && (CfgModeWord.toUpperCase() == "RDSAP") && 
        (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) &&
        ((WanItem.EncapMode.toUpperCase() == "PPPOE") || (WanItem.IPv4AddressMode.toString().toUpperCase() == "STATIC") ||
        (WanItem.IPv6AddressMode.toString().toUpperCase() == "STATIC"))) {
        return true;
    }

    if ((IsAdminUser() == false) && (((filterWanFeater == "1") &&
        !((WanItem.EncapMode.toUpperCase() == "PPPOE") && (WanItem.Mode == "IP_Routed")) &&(IsLanUpCanOper() == false)) ||
        ((htFlag == "1") && ((WanItem.ServiceList.toString().toUpperCase().indexOf("TR069") >= 0) ||
        (WanItem.ServiceList.toString().toUpperCase().indexOf("VOIP") >= 0))))) {
        return false;
    }

    if (viettelflag == 1) {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("TR069") >= 0) {
            return false;
        }
    }

    return true;
}

function filterWanOnlyTr069(WanItem)
{
    if ("0" == SimIsAuth && WanItem.ServiceList.indexOf("TR069") < 0)
    {
        return false;
    }
    return true;
}

function filterWanByVlan(WanItem)
{
    if (WanItem.VlanId == parseInt(JsctSpecVlan) && IsAdminUser() == false)
    {
        return false;
    }
    return true;
}

function Is6RdSupported()
{
    if (("1" == RdFeature) && (ProductType == '3'))
    {
        return true;
    }
    
    if (("1" == RdFeature) && ("1" == supportTelmex))
    {
        return true;
    }

    return false;
}

function IsRadioWanSupported(wan)
{
    if ((RadioWanFeature != "1") && (isSupportLte != "1"))
    {
        return false;
    }

    if ((wan.Name.indexOf(RADIOWAN_NAMEPREFIX) >=0) || (wan.Name.indexOf("Mobile") >=0) || (wan.X_HW_LowerLayers.indexOf("radio") >=0) || (wan.X_HW_LowerLayers.indexOf("lte") >=0))
    {
        return true;
    }

    return false;
}

function WanInfoInst()
{
    this.domain  = null;

    this.RealName     = "";
    this.ConnectionTrigger = "";
    this.ConnectionControl = "";
    this.MACAddress   = "";
    this.Status       = "";
    this.LastConnErr  = "";
    this.Enable       = "1";
    this.RemoteWanInfo = "";
    this.Name         = "";
    this.NewName       = "";
    this.EncapMode    = "IPoE";
    this.ProtocolType = "IPv4";
    this.IPv4Enable   = "1";
    this.IPv6Enable   = "0";
    this.Mode         = "IP_Routed";
    this.ServiceList  = "INTERNET";
    if ((bin5board() == true) || (IsSupportBridgeWan == 1))
    {
        this.ServiceList  = "TR069";
    }
    if("TELMEXACCESS" == CfgModeWord.toUpperCase() || "TELMEXACCESSNV" == CfgModeWord.toUpperCase())
    {
        this.ServiceList  = "TR069_VOIP_INTERNET";
    }
    if("TELMEXRESALE" == CfgModeWord.toUpperCase())
    {
        this.ServiceList  = "TR069_VOIP_INTERNET";
    }
    if(vxlanfeature == 1)
    {
        this.X_HW_VXLAN_Enable = "0";
    }
    this.X_HW_OperateDisable = "0";
    this.EnableVlan   = "1";
    this.VlanId       = "";
    this.PriorityPolicy = ("1" == supportTelmex)?"CopyFromIPPrecedence":"Specified";
    this.DefaultPriority   = "0";
    this.Priority     = "0";
    if ("1" == supportTelmex) {
        this.UserName     = "";
        this.Password     = "";
    } else if(tedataGuide == 1) {
        if (curUserType == sysUserType) {
            this.UserName = "00000";
        } else {
            this.UserName  = pppoeUserName;
        }
        this.Password = "";
    } else {
        this.UserName     = "iadtest@pppoe";
        this.Password     = "";
    }
	
    if("GLOBE2WIFI" == CfgModeWord.toUpperCase() || "GLOBE2" == CfgModeWord.toUpperCase())
    {
        this.UserName     = pppoeUserName;
        this.Password     = "";
    }

    if (hideVlan == "1") {
        this.EnableVlan = "0";
    }

    this.X_HW_BridgeEnable = "";
    this.LcpEchoReqCheck = "0";
    this.PPPoEACName  = "";
    this.MacId        = "0";

    this.IPv4AddressMode   = "DHCP";
    this.IPv4MXU           = "";
    this.IPv4NATEnable     = "1";
    this.X_HW_NPTv6Enable  = "0";
    this.NatType = "0";
    this.IPv4VendorId      = "";
    this.IPv4ClientId      = "";

    this.IPv4IPAddress    = "";
    this.IPv4SubnetMask   = "";
    this.IPv4IPAddressSecond = "";
    this.IPv4SubnetMaskSecond = "";
    this.IPv4IPAddressThird = "";
    this.IPv4SubnetMaskThird = "";
    this.IPv4Gateway      = "";
    this.IPv4PrimaryDNS   = "";
    this.IPv4SecondaryDNS = "";

    this.DHCPLeaseTime = "0";
    this.DHCPLeaseTimeRemaining = "0";
    this.NTPServer = "";
    this.TimeZoneInfo = "";
    this.SIPServer = "";
    this.StaticRouteInfo = "";
    this.VendorInfo = "";
    this.X_HW_UpstreamBitrate  = "";
    this.X_HW_DownstreamBitrate  = "";

    this.IPv4DialMode = "AlwaysOn";
    if( true == IsSCCT() )
    {
        this.IPv4DialIdleTime = "1800";
    }
    else
    {
        this.IPv4DialIdleTime = "180";
    }
    this.IPv4IdleDisconnectMode = "";
    this.IPv4PPPoEAccountEnable = "disable";
    this.IPv4WanMVlanId   = "";
    this.IPv4BindLanList  = new Array();
    this.IPv4BindSsidList  = new Array();
    this.IPv4BindOnuList  = new Array();
    this.EnableLanDhcp   = "1";
    this.DstIPForwardingList   = "";
	this.IPv4v6WanMVlanId   = "";

    this.IPv6PrefixMode   = "PrefixDelegation";
    this.IPv6AddressStuff = "";
    this.IPv6AddressMode  = "AutoConfigured";
    this.X_HW_E8C_IPv6PrefixDelegationEnabled = "1";
    this.X_HW_UnnumberedModel = "0";
    this.X_HW_TDE_IPv6AddressingType = "SLAAC";
    this.X_HW_DHCPv6ForAddress  = "0";
    this.IPv6StaticPrefix = "";
    this.IPv6ReserveAddress = "";
    this.IPv6IPAddress    = "";
    this.IPv6AddrMaskLenE8c    = "64";
    this.IPv6GatewayE8c    = "";
    this.IPv6SubnetMask   = "";
    this.IPv6Gateway      = "";
    this.IPv6PrimaryDNS   = "";
    this.IPv6SecondaryDNS = "";
    this.IPv6WanMVlanId   = "";

    this.IPv6DSLite         = "Off";
    this.EnableDSLite       = "0";
    this.IPv6AFTRName       = "";
    this.EnablePrefix       = "1";

    this.Enable6Rd = "0";
    this.RdMode = "Off";
    this.RdPrefix = "";
    this.RdPrefixLen = "";
    this.RdBRIPv4Address = "";
    this.RdIPv4MaskLen = "";

    this.RadioWanPSEnable = "1";
    this.AccessType = "1";
    this.SwitchMode = "Auto";
    this.SwitchDelayTime = "30";
    this.PingIPAddress = "";

    if (isSupportLte == "1") {
        this.BackupMode = "0";
        this.BackupDelayTime = "30";
        if (IsXdProduct() != true) {
            this.WanAccessType = "GPON";
        }
    }
    this.RadioWanUsername = "";
    this.RadioWanPassword = radio_hidepassword;
    this.APN = "";
    this.X_HW_LteProfile = 0;
    this.DialNumber = "";
    this.TriggerMode = "AlwaysOn";
    this.Uptime = 0;
    this.IPv4DNSOverrideSwitch = "0";
    this.X_HW_LowerLayers = "";
    this.EnableOption60 = "0";
    this.X_HW_IPoEName ="";
    this.X_HW_IPoEPassword= "";
    this.IPv4EnableMulticast= "1";
    this.X_HW_DscpToPbitTbl= "";
    this.BytesSent          = "";
    this.BytesReceived      = "";
    this.PacketsSent        = "";
    this.PacketsReceived    = "";
    this.UnicastSent        = "";
    this.UnicastReceived    = "";
    this.MulticastSent      = "";
    this.MulticastReceived  = "";
    this.BroadcastSent      = "";
    this.BroadcastReceived  = "";
    this.X_HW_IGMPEnable    = "0";
    this.X_HW_SpeedLimit_UP  = "";
    this.X_HW_SpeedLimit_DOWN  = "";
    this.EnableUnnumbered = "";
    this.UnnumberedIpAddress = "";
    this.UnnumberedSubnetMask = "";
    this.Option60_enable =  "";
    this.Option60_User = "";
    this.Option60_Pwd = "";

    this.BytesSentHigh = "";
	this.BytesSentLow = "";
	this.BytesReceivedHigh = "";
	this.BytesReceivedLow = "";
    this.IPForwardModeEnabled = "0";
    
    if(IsXdProduct())
    {
        this.EnableVlan = "0";
        if ((CfgModeWord.toUpperCase() == "DNZTELECOM2WIFI") || (SupportTtnet()))
        {
            this.UserName     = "";
            this.Password     = "";
        }
        else if(1 == IsTedata)
		{
			this.UserName     = "00000";
            this.Password     = "";
		}
		else
        {
            this.UserName     = "pppoe1@dsl_dom201";
            this.Password     = "";
        }
		this.WanAccessType = XDGetDefaultWanAccessType();

        this.DestinationAddress = "";
        this.LinkType = "";
        this.ATMQoS = "UBR";
        this.ATMEncapsulation = "";
        this.ATMPeakCellRate      = "";
        this.ATMMaximumBurstSize  = "";
        this.ATMSustainableCellRate = "";
    }

    if ((CfgModeWord.toUpperCase() == "CNT") || (CfgModeWord.toUpperCase() == 'CNT2')) {
        this.ServiceList  = "VOIP";
        this.IPv4MXU = "1492";
        this.UserName = "";
        this.Password = "";
    }
}

function XDGetDefaultWanAccessType()
{
    var ethCfgModeList = ["TURKCELL2", "DSTCOACCESS"];
    for (var loop = 0; loop < ethCfgModeList.length; loop++) {
        if(CfgModeWord.toUpperCase() == ethCfgModeList[loop]) {
            return "Ethernet";
        }
    }

    if(IsDSLSURPPORT == 1) {
        return "DSL";
    }

    return "Ethernet";
}

function GetIpWan6RDTunnelInfo(domain,Enable,RdMode,RdPrefix,RdPrefixLen, RdBRIPv4Address,RdIPv4MaskLen)
{
    this.domain = domain;
    this.Enable6Rd = Enable;
    this.RdMode = RdMode;
    this.RdPrefix = RdPrefix;
    this.RdPrefixLen = RdPrefixLen;
    this.RdBRIPv4Address = RdBRIPv4Address;
    this.RdIPv4MaskLen = RdIPv4MaskLen;

}

function GetPppWan6RDTunnelInfo(domain,Enable,RdPrefix,RdPrefixLen, RdBRIPv4Address,RdIPv4MaskLen)
{
    this.domain = domain;
    this.Enable6Rd = Enable;
    this.RdPrefix = RdPrefix;
    this.RdPrefixLen = RdPrefixLen;
    this.RdBRIPv4Address = RdBRIPv4Address;
    this.RdIPv4MaskLen = RdIPv4MaskLen;
}

function DsLiteInfo(domain, WorkMode, AFTRName)
{
    this.domain = domain;
    this.WorkMode = WorkMode;
    this.AFTRName = AFTRName;
}

function RadioWanClass(domain, RadioWanUsername, APN, DialNumber, TriggerMode)
{
    this.domain = domain;
    this.RadioWanUsername  = RadioWanUsername;
    this.RadioWanPassword  = radio_hidepassword;
    this.APN  = APN;
    this.DialNumber  = DialNumber;
    this.TriggerMode  = TriggerMode;
}

function RadioWanPSClass(domain, RadioWanPSEnable, SwitchMode, SwitchDelayTime, PingIPAddress, RadioWANIndex)
{
    this.domain = domain;
    this.RadioWanPSEnable = RadioWanPSEnable;
    this.AccessType = "0";
    this.SwitchMode = SwitchMode;
    this.SwitchDelayTime = SwitchDelayTime;
    this.PingIPAddress = PingIPAddress;
    this.RadioWANIndex = RadioWANIndex;
}

function TDEIPWanIPv6AddressClass(domain, X_HW_UnnumberedModel, X_HW_TDE_IPv6AddressingType, X_HW_DHCPv6ForAddress)
{
    this.domain = domain;
    this.X_HW_UnnumberedModel = X_HW_UnnumberedModel;
    this.X_HW_TDE_IPv6AddressingType = X_HW_TDE_IPv6AddressingType;
    this.X_HW_DHCPv6ForAddress = X_HW_DHCPv6ForAddress;
}

function TDEPPPWanIPv6AddressClass(domain, X_HW_UnnumberedModel, X_HW_TDE_IPv6AddressingType, X_HW_DHCPv6ForAddress)
{
    this.domain = domain;
    this.X_HW_UnnumberedModel = X_HW_UnnumberedModel;
    this.X_HW_TDE_IPv6AddressingType = X_HW_TDE_IPv6AddressingType;
    this.X_HW_DHCPv6ForAddress = X_HW_DHCPv6ForAddress;
}

function TDE_IP_DelegationEnabledClass(domain, X_HW_E8C_IPv6PrefixDelegationEnabled)
{
    this.domain = domain;
    this.X_HW_E8C_IPv6PrefixDelegationEnabled = X_HW_E8C_IPv6PrefixDelegationEnabled;
}

function TDE_PPP_DelegationEnabledClass(domain, X_HW_E8C_IPv6PrefixDelegationEnabled)
{
    this.domain = domain;
    this.X_HW_E8C_IPv6PrefixDelegationEnabled = X_HW_E8C_IPv6PrefixDelegationEnabled;
}

function UnnumberdIPInfoClass(domain, Enable, IPAddress, SubnetMask)
{
    this.domain = domain;
    this.Enable = Enable;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;
}

function WaninfoStats(domain, BytesSent, BytesReceived, PacketsSent, PacketsReceived,UnicastSent,UnicastReceived,MulticastSent,MulticastReceived,BroadcastSent,BroadcastReceived,BytesSentHigh,BytesSentLow,BytesReceivedHigh,BytesReceivedLow,X_HW_UpstreamBitrate,X_HW_DownstreamBitrate)
{
    this.domain             = domain;
    this.BytesSent          = BytesSent;
    this.BytesReceived      = BytesReceived;
    this.PacketsSent        = PacketsSent;
    this.PacketsReceived    = PacketsReceived;
    this.UnicastSent        = UnicastSent;
    this.UnicastReceived    = UnicastReceived;
    this.MulticastSent      = MulticastSent;
    this.MulticastReceived  = MulticastReceived;
    this.BroadcastSent      = BroadcastSent;
    this.BroadcastReceived  = BroadcastReceived;
    this.BytesSentHigh      = BytesSentHigh;
    this.BytesSentLow       = BytesSentLow;
    this.BytesReceivedHigh  = BytesReceivedHigh;
    this.BytesReceivedLow   = BytesReceivedLow;
    this.X_HW_UpstreamBitrate  = X_HW_UpstreamBitrate;
    this.X_HW_DownstreamBitrate  = X_HW_DownstreamBitrate;
}
WanInfoInst.prototype.clone = function()
{
    var newObj = new WanInfoInst();
    for(emplement in this)
    {
        newObj[emplement] = this[emplement];
    }
    return newObj;
}

function GetProtocolType(IPv4Enable, IPv6Enable)
{
    if (IPv4Enable == "1" && IPv6Enable == "1")
    {
        return "IPv4/IPv6";
    }
    if (IPv4Enable == "1")
    {
        return "IPv4";
    }
    return "IPv6"
}

function WanIP(domain,X_HW_VXLAN_Enable, X_HW_OperateDisable,ConnectionTrigger,MACAddress, Status, LastConnErr, RemoteWanInfo, Name,Enable,EnableLanDhcp,DstIPForwardingList,ConnectionStatus,
                Mode,IPMode,IPAddress,SubnetMask,Gateway,
                NATEnable,X_HW_NatType,dnsstr,VlanId,MultiVlanID,Pri8021,VenderClassID,ClientID,ServiceList,ExServiceList,
                Tr069Flag, MacId, IPv4Enable, IPv6Enable, IPv6MultiCastVlan, PriPolicy, DefaultPri,MaxMTUSize,
                DHCPLeaseTime,NTPServer,TimeZoneInfo,SIPServer,StaticRouteInfo,VendorInfo,DHCPLeaseTimeRemaining,Uptime,DNSOverrideAllowed,X_HW_LowerLayers,
                X_HW_IPoEName,X_HW_IPoEPassword,X_HW_IGMPEnable,X_HW_DscpToPbitTbl, IPv4IPAddressSecond, IPv4SubnetMaskSecond, IPv4IPAddressThird, 
                IPv4SubnetMaskThird, X_HW_NPTv6Enable, X_HW_SpeedLimit_UP, X_HW_SpeedLimit_DOWN, X_HW_LteProfile, X_HW_PingResponseEnable, X_HW_PingResponseWhiteList, IPForwardModeEnabled)
{
    this.domain     = domain;
    this.Uptime = Uptime;
    this.ConnectionTrigger = ConnectionTrigger;
    this.MACAddress = MACAddress;
    this.Status = Status;
    this.LastConnErr  = LastConnErr;
    this.RemoteWanInfo = RemoteWanInfo;
    this.Name         = Name;
    this.NewName   =  domainTowanname(domain);
    this.Enable        = Enable;
    this.EnableLanDhcp = EnableLanDhcp;
    this.DstIPForwardingList   = DstIPForwardingList;
    this.ConnectionStatus = ConnectionStatus;

    this.Mode        = Mode;
    this.IPMode        = IPMode;

    this.IPAddress    = IPAddress;
    this.SubnetMask = SubnetMask;
    this.Gateway    = Gateway;

    this.NATEnable = NATEnable;
    this.X_HW_NatType = X_HW_NatType;

    var dnss         = dnsstr.split(',');
    this.PrimaryDNS     = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";
    this.VlanId   = VlanId;
    this.X_HW_VXLAN_Enable = X_HW_VXLAN_Enable;
    this.X_HW_OperateDisable = X_HW_OperateDisable;

    this.MultiVlanID=(MultiVlanID > 4094 )?"":MultiVlanID;
    this.IPv6MultiVlanID=(IPv6MultiCastVlan > 4094 ) ? "":IPv6MultiCastVlan;

    if(PriPolicy.toUpperCase() == "SPECIFIED")
    {
        this.PriorityPolicy = "Specified";
    }
    else if(PriPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE")
    {
        this.PriorityPolicy = "CopyFromIPPrecedence";
    }
    else
    {
        this.PriorityPolicy = "DscpToPbit";
    }
    this.DefaultPriority = DefaultPri;
    this.Pri8021  =  Pri8021;
    this.VenderClassID = VenderClassID;
    this.ClientID = ClientID;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();
    if (this.ServiceList == "HQOS") {
        this.ServiceList = "HQoS";
    }
    if (this.ServiceList == "D_BUS") {
        this.ServiceList = "D_Bus";
    }

    this.isPPPoEAccountEnable = "disable";
    this.Tr069Flag = Tr069Flag;
    this.MacId = MacId;

    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (0 == SupportIPv6)
    {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }

    this.DHCPLeaseTime = DHCPLeaseTime;
    this.DHCPLeaseTimeRemaining = DHCPLeaseTimeRemaining;
    this.NTPServer = NTPServer;
    this.TimeZoneInfo = TimeZoneInfo;
    this.SIPServer = SIPServer;
    this.StaticRouteInfo = StaticRouteInfo;
    this.VendorInfo = VendorInfo;

    if(0 == MaxMTUSize)
    {
        this.IPv4MXU = 1500;
    }
    else
    {
        this.IPv4MXU = MaxMTUSize;
    }
    this.DNSOverrideAllowed = DNSOverrideAllowed;
    this.X_HW_LowerLayers = X_HW_LowerLayers;
    this.X_HW_IPoEName = X_HW_IPoEName;
    this.X_HW_IPoEPassword = X_HW_IPoEPassword;
    this.IPv4EnableMulticast = X_HW_IGMPEnable;
    this.X_HW_DscpToPbitTbl = X_HW_DscpToPbitTbl;
    this.IPv4IPAddressSecond = IPv4IPAddressSecond;
    this.IPv4SubnetMaskSecond = IPv4SubnetMaskSecond;
    this.IPv4IPAddressThird = IPv4IPAddressThird;
    this.IPv4SubnetMaskThird = IPv4SubnetMaskThird;
    this.X_HW_NPTv6Enable = X_HW_NPTv6Enable;
    this.X_HW_SpeedLimit_UP = X_HW_SpeedLimit_UP;
    this.X_HW_SpeedLimit_DOWN = X_HW_SpeedLimit_DOWN;
    this.X_HW_IGMPEnable = X_HW_IGMPEnable;	
    this.X_HW_LteProfile = X_HW_LteProfile;
    this.X_HW_PingResponseEnable = X_HW_PingResponseEnable;
    this.X_HW_PingResponseWhiteList = X_HW_PingResponseWhiteList;
    this.IPForwardModeEnabled = IPForwardModeEnabled;
}

function WanPPP(domain, X_HW_VXLAN_Enable, X_HW_OperateDisable, ConnectionTrigger, MACAddress, Status, LastConnErr, RemoteWanInfo, Name,Enable,EnableLanDhcp,DstIPForwardingList,ConnectionStatus,Mode,IPAddress,Gateway,NATEnable,X_HW_NatType,dnsstr,
                Username,Password,DialMode,ConnectionControl,VlanId,MultiVlanID,Pri8021,LcpEchoReqCheck,ServiceList,ExServiceList,Tr069Flag,
                IdleDisconnectTime, MacId, IPv4Enable, IPv6Enable, IPv6MultiCastVlan, PriPolicy, DefaultPri, MaxMRUSize, PPPoEACName,X_HW_IdleDetectMode, Uptime, DNSOverrideAllowed, X_HW_LowerLayers,
                PPPoESessionID,X_HW_IGMPEnable, StaticRouteInfo, X_HW_DscpToPbitTbl, Hurl, Motm, X_HW_BridgeEnable, X_HW_NPTv6Enable, X_HW_SpeedLimit_UP, X_HW_SpeedLimit_DOWN,
                X_HW_PingResponseEnable, X_HW_PingResponseWhiteList, IPForwardModeEnabled)
{
    this.domain            = domain;
    this.ConnectionTrigger = ConnectionTrigger;
    this.Uptime = Uptime;

    if (parseInt(ConnectionControl, 10) == 0xFFFFFFFF )
    {
        this.ConnectionControl = 0;
    }
    else
    {
        this.ConnectionControl = ConnectionControl;
    }

    this.MACAddress = MACAddress;

    if ((Status.toUpperCase() == "CONNECTING") && (this.ConnectionControl == "0") && (ConnectionTrigger == "Manual"))
    {
        this.Status = "Disconnected";
    }
    else
    {
        this.Status = Status;
    }

    this.LastConnErr  = LastConnErr;
    this.RemoteWanInfo = RemoteWanInfo;
    this.Name          = Name;
    this.NewName      = domainTowanname(domain);
    this.Enable        = Enable;
    this.EnableLanDhcp = EnableLanDhcp;
    this.DstIPForwardingList   = DstIPForwardingList;
    this.ConnectionStatus = ConnectionStatus;

    this.Mode        = Mode;
    this.IPMode        = 'PPPoE';

    this.IPAddress    = IPAddress;
    this.SubnetMask    = '255.255.255.255';
    this.Gateway        = Gateway;

    this.NATEnable     = NATEnable;
    this.X_HW_NatType = X_HW_NatType;

    var dnss         = dnsstr.split(',');
    this.PrimaryDNS    = dnss[0];
    this.SecondaryDNS = (dnss.length >= 2) ? dnss[1] : "";

    this.Username = Username;

    this.Password = Password;

     this.LcpEchoReqCheck = LcpEchoReqCheck;


    this.DialMode = DialMode;

    this.VlanId    = VlanId;
    this.X_HW_VXLAN_Enable = X_HW_VXLAN_Enable;
    this.X_HW_OperateDisable = X_HW_OperateDisable;
    this.MultiVlanID=(MultiVlanID > 4094 )?"":MultiVlanID;
    this.IPv6MultiVlanID=(IPv6MultiCastVlan > 4094 ) ? "":IPv6MultiCastVlan;

    if(PriPolicy.toUpperCase() == "SPECIFIED")
    {
        this.PriorityPolicy = "Specified";
    }
    else if(PriPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE")
    {
        this.PriorityPolicy = "CopyFromIPPrecedence";
    }
    else
    {
        this.PriorityPolicy = "DscpToPbit";
    }
    this.DefaultPriority = DefaultPri;
    this.Pri8021  =  Pri8021;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();
    if (this.ServiceList == "HQOS") {
        this.ServiceList = "HQoS";
    }
    if (this.ServiceList == "D_BUS") {
        this.ServiceList = "D_Bus";
    }

    this.IdleDisconnectTime = IdleDisconnectTime;
    this.IPv4IdleDisconnectMode = X_HW_IdleDetectMode;
    this.Tr069Flag = Tr069Flag;
    this.MacId = MacId;

    this.IPv4Enable = IPv4Enable;
    this.IPv6Enable = IPv6Enable;
    if (0 == SupportIPv6)
    {
        this.IPv6Enable = 0;
        this.IPv4Enable = 1;
    }

    this.PPPoEACName = PPPoEACName;
    if(0 == MaxMRUSize)
        this.IPv4MXU = 1492;
    else
        this.IPv4MXU = MaxMRUSize;

    this.DNSOverrideAllowed = DNSOverrideAllowed;
    this.X_HW_LowerLayers = X_HW_LowerLayers;
    this.PPoESessionID = PPPoESessionID;
    this.IPv4EnableMulticast = X_HW_IGMPEnable;
    this.StaticRouteInfo = StaticRouteInfo;
    this.X_HW_DscpToPbitTbl = X_HW_DscpToPbitTbl;
    this.Hurl = Hurl;
    this.Motm = Motm;
    this.X_HW_BridgeEnable = X_HW_BridgeEnable;
    this.X_HW_NPTv6Enable = X_HW_NPTv6Enable;
    this.X_HW_SpeedLimit_UP = X_HW_SpeedLimit_UP;
    this.X_HW_SpeedLimit_DOWN = X_HW_SpeedLimit_DOWN;
    this.X_HW_IGMPEnable = X_HW_IGMPEnable;
    this.IPForwardModeEnabled = IPForwardModeEnabled;
    
    if ((CfgModeWord.toUpperCase() == "SCCT") && (this.ServiceList == "OTHER")) {
        this.MultiVlanID = (MultiVlanID > 4094) ? "-1" : MultiVlanID;
    }
    this.X_HW_PingResponseEnable = X_HW_PingResponseEnable;
    this.X_HW_PingResponseWhiteList = X_HW_PingResponseWhiteList;
}


function AtmLinkConfig(domain, LinkType, DestinationAddress, ATMEncapsulation, ATMQoS, ATMPeakCellRate, ATMMaximumBurstSize, ATMSustainableCellRate)
{
    this.domain      = domain;
    this.LinkType    = LinkType;
    this.DestinationAddress   = DestinationAddress;
    this.ATMEncapsulation       = ATMEncapsulation;
    this.ATMQoS               = ATMQoS;
    this.ATMPeakCellRate      = ATMPeakCellRate;
    this.ATMMaximumBurstSize  = ATMMaximumBurstSize;
    this.ATMSustainableCellRate = ATMSustainableCellRate;
}

function LinkConfig(domain, LinkType, DestinationAddress, ATMEncapsulation, ATMQoS, ATMPeakCellRate, ATMMaximumBurstSize, ATMSustainableCellRate)
{
    this.domain      = domain;
    this.LinkType    = LinkType;
    this.DestinationAddress   = DestinationAddress;
    this.ATMEncapsulation       = ATMEncapsulation;
    this.ATMQoS               = ATMQoS;
    this.ATMPeakCellRate      = ATMPeakCellRate;
    this.ATMMaximumBurstSize  = ATMMaximumBurstSize;
    this.ATMSustainableCellRate = ATMSustainableCellRate;
}


function FillWanInfoForXD(CommonWanInfo)
{
    if(!IsXdProduct())
    {
        if (isSupportLte == "1") {
            CommonWanInfo.WanAccessType = (CommonWanInfo.X_HW_LowerLayers.indexOf("lte") >= 0) ? "UMTS" : "GPON";
        }
        return;
    }
    
    CommonWanInfo.WanAccessType = Instance_AccessType.GetWanAceesstypeByWanInst(CommonWanInfo.domain.split(".")[2]);
    if( CommonWanInfo.WanAccessType == 'DSL')
    {
      var DSLLinkConfigList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANDSLLinkConfig, LinkType|DestinationAddress|ATMEncapsulation|ATMQoS|ATMPeakCellRate|ATMMaximumBurstSize|ATMSustainableCellRate, AtmLinkConfig);%>;
      for( var i = 0 ; i < DSLLinkConfigList.length - 1 ; i++)
      {
          if( CommonWanInfo.domain.split(".")[4] == DSLLinkConfigList[i].domain.split(".")[4] ) 
          {
              CommonWanInfo.DestinationAddress = DSLLinkConfigList[i].DestinationAddress.replace("PVC:",""); 
              CommonWanInfo.LinkType = DSLLinkConfigList[i].LinkType ;
              CommonWanInfo.ATMQoS = DSLLinkConfigList[i].ATMQoS ;
              CommonWanInfo.ATMEncapsulation = DSLLinkConfigList[i].ATMEncapsulation ;
              CommonWanInfo.ATMPeakCellRate      = DSLLinkConfigList[i].ATMPeakCellRate ;
              CommonWanInfo.ATMMaximumBurstSize  = DSLLinkConfigList[i].ATMMaximumBurstSize ;
              CommonWanInfo.ATMSustainableCellRate = DSLLinkConfigList[i].ATMSustainableCellRate ;
              break;
          }
      }
    }
}


function ConvertIPWan(IPWan, CommonWanInfo)
{
    CommonWanInfo.domain  = IPWan.domain;

    CommonWanInfo.RealName     = IPWan.Name;
    CommonWanInfo.ConnectionTrigger = IPWan.ConnectionTrigger
    CommonWanInfo.MACAddress   = IPWan.MACAddress;
    CommonWanInfo.Status       = IPWan.Status;
    CommonWanInfo.LastConnErr  = IPWan.LastConnErr;
    CommonWanInfo.Enable       = IPWan.Enable;
    CommonWanInfo.EnableLanDhcp   = IPWan.EnableLanDhcp;
    CommonWanInfo.DstIPForwardingList   = IPWan.DstIPForwardingList;
    CommonWanInfo.RemoteWanInfo = IPWan.RemoteWanInfo;
    CommonWanInfo.Name         = IPWan.Name;
    CommonWanInfo.NewName      = IPWan.NewName;
    CommonWanInfo.ProtocolType = GetProtocolType(IPWan.IPv4Enable, IPWan.IPv6Enable);
    CommonWanInfo.IPv4Enable   = IPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable   = IPWan.IPv6Enable;
    CommonWanInfo.EncapMode    = "IPoE";
    CommonWanInfo.Mode         = IPWan.Mode;
    CommonWanInfo.ServiceList  = IPWan.ServiceList.toUpperCase();
    if (CommonWanInfo.ServiceList == "HQOS") {
        CommonWanInfo.ServiceList = "HQoS";
    }
    if (CommonWanInfo.ServiceList == "D_BUS") {
        CommonWanInfo.ServiceList = "D_Bus";
    }
    CommonWanInfo.EnableVlan   = (IPWan.VlanId == "0") ? "0" : "1";

	if (1 == isSupportVLAN0)
	{
		CommonWanInfo.EnableVlan = ((IPWan.VlanId == "4095") || (IPWan.VlanId == "-1")) ? "0" : "1";
	}
	
    CommonWanInfo.VlanId       = IPWan.VlanId;
    CommonWanInfo.PriorityPolicy  = IPWan.PriorityPolicy;
    CommonWanInfo.DefaultPriority = IPWan.DefaultPriority;
    CommonWanInfo.Priority     = IPWan.Pri8021;
    CommonWanInfo.Tr069Flag    = IPWan.Tr069Flag;
    if ("1" == supportTelmex )
    {
        CommonWanInfo.UserName     = "";
        CommonWanInfo.Password     = "";
    }
    else
    {
        CommonWanInfo.UserName     = "iadtest@pppoe";
        CommonWanInfo.Password     = "";
    }
    CommonWanInfo.LcpEchoReqCheck  = "0";
    CommonWanInfo.MacId        = IPWan.MacId;

    switch(IPWan.IPMode.toString().toUpperCase())
    {
        case 'STATIC':
            CommonWanInfo.IPv4AddressMode = 'Static';
            break;
        case 'DHCP':
            CommonWanInfo.IPv4AddressMode = 'DHCP';
            break;
        case 'AUTO':
            CommonWanInfo.IPv4AddressMode = 'Auto';
            break;
        default:
            break;
    }
    CommonWanInfo.IPv4MXU           = IPWan.IPv4MXU;
    CommonWanInfo.IPv4NATEnable     = IPWan.NATEnable;
    CommonWanInfo.NatType     = IPWan.X_HW_NatType;
    CommonWanInfo.IPv4VendorId      = IPWan.VenderClassID;
    CommonWanInfo.IPv4ClientId      = IPWan.ClientID;

    CommonWanInfo.IPv4IPAddress    = IPWan.IPAddress;
    CommonWanInfo.IPv4SubnetMask   = IPWan.SubnetMask;
    CommonWanInfo.IPv4IPAddressSecond    = IPWan.IPv4IPAddressSecond;
    CommonWanInfo.IPv4SubnetMaskSecond   = IPWan.IPv4SubnetMaskSecond;
    CommonWanInfo.IPv4IPAddressThird    = IPWan.IPv4IPAddressThird;
    CommonWanInfo.IPv4SubnetMaskThird   = IPWan.IPv4SubnetMaskThird;
    CommonWanInfo.IPv4Gateway      = IPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS   = IPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = IPWan.SecondaryDNS;
    CommonWanInfo.DHCPLeaseTime = IPWan.DHCPLeaseTime;
    CommonWanInfo.DHCPLeaseTimeRemaining = IPWan.DHCPLeaseTimeRemaining;
    CommonWanInfo.NTPServer = IPWan.NTPServer;
    CommonWanInfo.TimeZoneInfo = IPWan.TimeZoneInfo;
    CommonWanInfo.SIPServer = IPWan.SIPServer;
    CommonWanInfo.StaticRouteInfo = IPWan.StaticRouteInfo;
    CommonWanInfo.VendorInfo = IPWan.VendorInfo;

    CommonWanInfo.IPv4DialMode     = "AUTO";
    CommonWanInfo.IPv4DialIdleTime = "180";
    CommonWanInfo.IPv4IdleDisconnectMode = IPWan.IPv4IdleDisconnectMode;
    CommonWanInfo.IPv4WanMVlanId   = IPWan.MultiVlanID;
    CommonWanInfo.IPv4BindLanList  = new Array();
    CommonWanInfo.IPv4BindSsidList  = new Array();
    CommonWanInfo.IPv4BindOnuList  = new Array();

	if("IPv4/IPv6" == CommonWanInfo.ProtocolType && Is3TMode())
	{
		CommonWanInfo.IPv4v6WanMVlanId = IPWan.MultiVlanID;
	}

    CommonWanInfo.IPv6PrefixMode   = "SLAAC";
    CommonWanInfo.IPv6AddressMode  = "DHCP";
    CommonWanInfo.IPv6AddressStuff = "";
    CommonWanInfo.IPv6StaticPrefix = "";
    CommonWanInfo.IPv6ReserveAddress = IPWan.IPv6ReserveAddress;
    CommonWanInfo.IPv6IPAddress    = "";
    CommonWanInfo.IPv6AddrMaskLenE8c    = "64";
    CommonWanInfo.IPv6GatewayE8c    = "";
    CommonWanInfo.IPv6SubnetMask   = "";
    CommonWanInfo.IPv6Gateway      = "";
    CommonWanInfo.IPv6PrimaryDNS   = "";
    CommonWanInfo.IPv6SecondaryDNS = "";
    CommonWanInfo.IPv6WanMVlanId   = (IPWan.IPv6MultiVlanID == "-1")  ?  "" : IPWan.IPv6MultiVlanID;
    CommonWanInfo.Uptime = IPWan.Uptime;
    CommonWanInfo.IPv4DNSOverrideSwitch = IPWan.DNSOverrideAllowed;
    CommonWanInfo.X_HW_LowerLayers = IPWan.X_HW_LowerLayers;
    CommonWanInfo.X_HW_IPoEName = IPWan.X_HW_IPoEName;
    CommonWanInfo.X_HW_IPoEPassword = IPWan.X_HW_IPoEPassword;
    CommonWanInfo.EnableOption60 = ((IPWan.X_HW_IPoEName != "")&&(IPWan.X_HW_IPoEPassword != "")) ? "1" : "0";
    CommonWanInfo.PPPoESessionID = "";
    CommonWanInfo.IPv4EnableMulticast = IPWan.IPv4EnableMulticast;
    CommonWanInfo.X_HW_DscpToPbitTbl = IPWan.X_HW_DscpToPbitTbl;
    CommonWanInfo.X_HW_NPTv6Enable = IPWan.X_HW_NPTv6Enable;
    CommonWanInfo.X_HW_SpeedLimit_UP = IPWan.X_HW_SpeedLimit_UP;
    CommonWanInfo.X_HW_SpeedLimit_DOWN = IPWan.X_HW_SpeedLimit_DOWN;
    CommonWanInfo.X_HW_IGMPEnable = IPWan.X_HW_IGMPEnable; 
    CommonWanInfo.IPForwardModeEnabled = IPWan.IPForwardModeEnabled;
    if (vxlanfeature == 1)
    {
        CommonWanInfo.X_HW_VXLAN_Enable = IPWan.X_HW_VXLAN_Enable;
    }
    CommonWanInfo.X_HW_OperateDisable = IPWan.X_HW_OperateDisable;
    if (isSupportLte == "1") {
        CommonWanInfo.X_HW_LteProfile = IPWan.X_HW_LteProfile;
    }
    
    FillWanInfoForXD(CommonWanInfo);
}

function AccessType(domain, WANAccessType, BitRate)
{
    this.domain         = domain;
    this.WANAccessType  = WANAccessType;
}

function ConvertPPPWan(PPPWan, CommonWanInfo)
{
    CommonWanInfo.domain  = PPPWan.domain;

    CommonWanInfo.RealName     = PPPWan.Name;
    CommonWanInfo.ConnectionTrigger = PPPWan.ConnectionTrigger;
    CommonWanInfo.ConnectionControl = PPPWan.ConnectionControl;
    CommonWanInfo.MACAddress   = PPPWan.MACAddress;
    CommonWanInfo.Status       = PPPWan.Status;
    CommonWanInfo.LastConnErr  = PPPWan.LastConnErr;
    CommonWanInfo.Enable       = PPPWan.Enable;
    CommonWanInfo.EnableLanDhcp   = PPPWan.EnableLanDhcp;
    CommonWanInfo.DstIPForwardingList   = PPPWan.DstIPForwardingList;
    CommonWanInfo.RemoteWanInfo = PPPWan.RemoteWanInfo;
    CommonWanInfo.Name         = PPPWan.Name;
    CommonWanInfo.NewName      = PPPWan.NewName;
    CommonWanInfo.ProtocolType = GetProtocolType(PPPWan.IPv4Enable, PPPWan.IPv6Enable);
    CommonWanInfo.IPv4Enable   = PPPWan.IPv4Enable;
    CommonWanInfo.IPv6Enable   = PPPWan.IPv6Enable;
    CommonWanInfo.EncapMode    = "PPPoE";
    if (PPPWan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0)
    {
        CommonWanInfo.Mode     = "IP_Bridged";
    }
    else
    {
        CommonWanInfo.Mode     = "IP_Routed";
    }
    CommonWanInfo.ServiceList  = PPPWan.ServiceList.toUpperCase();
    if (CommonWanInfo.ServiceList == "HQOS") {
        CommonWanInfo.ServiceList = "HQoS";
    }
    if (CommonWanInfo.ServiceList == "D_BUS") {
        CommonWanInfo.ServiceList = "D_Bus";
    }
    CommonWanInfo.EnableVlan   = (PPPWan.VlanId == "0") ? "0" : "1";
	if (1 == isSupportVLAN0)
	{
		CommonWanInfo.EnableVlan = ((PPPWan.VlanId == "4095") || (PPPWan.VlanId == "-1")) ? "0" : "1";
	}
	
    CommonWanInfo.VlanId       = PPPWan.VlanId;
    CommonWanInfo.PriorityPolicy  = PPPWan.PriorityPolicy;
    CommonWanInfo.DefaultPriority = PPPWan.DefaultPriority;
    CommonWanInfo.Priority     = PPPWan.Pri8021;
    CommonWanInfo.Tr069Flag    = PPPWan.Tr069Flag;
    CommonWanInfo.UserName     = PPPWan.Username;
    CommonWanInfo.Password     = PPPWan.Password;
    CommonWanInfo.LcpEchoReqCheck = PPPWan.LcpEchoReqCheck;
    CommonWanInfo.PPPoEACName  = PPPWan.PPPoEACName;
    CommonWanInfo.MacId        = PPPWan.MacId;

    CommonWanInfo.IPv4AddressMode   = PPPWan.IPMode;
    CommonWanInfo.IPv4MXU           = PPPWan.IPv4MXU;
    CommonWanInfo.IPv4NATEnable     = PPPWan.NATEnable;
    CommonWanInfo.NatType     = PPPWan.X_HW_NatType;
    CommonWanInfo.IPv4VendorId      = "";
    CommonWanInfo.IPv4ClientId      = "";

    CommonWanInfo.IPv4IPAddress    = PPPWan.IPAddress;
    CommonWanInfo.IPv4SubnetMask   = PPPWan.SubnetMask;
    CommonWanInfo.IPv4Gateway      = PPPWan.Gateway;
    CommonWanInfo.IPv4PrimaryDNS   = PPPWan.PrimaryDNS;
    CommonWanInfo.IPv4SecondaryDNS = PPPWan.SecondaryDNS;
    CommonWanInfo.IPv4DialMode     = PPPWan.DialMode;
    CommonWanInfo.IPv4DialIdleTime = PPPWan.IdleDisconnectTime;
    CommonWanInfo.IPv4IdleDisconnectMode = PPPWan.IPv4IdleDisconnectMode;
    CommonWanInfo.IPv4PPPoEAccountEnable = PPPWan.IPv4PPPoEAccountEnable;
    CommonWanInfo.IPv4WanMVlanId   = PPPWan.MultiVlanID;
    CommonWanInfo.IPv4BindLanList  = new Array();
    CommonWanInfo.IPv4BindSsidList  = new Array();
    CommonWanInfo.IPv4BindOnuList  = new Array();
	if("IPv4/IPv6" == CommonWanInfo.ProtocolType && Is3TMode())
	{
		CommonWanInfo.IPv4v6WanMVlanId = PPPWan.MultiVlanID;
	}

    CommonWanInfo.IPv6PrefixMode   = "SLAAC";
    CommonWanInfo.IPv6AddressMode  = "DHCP";
    CommonWanInfo.IPv6AddressStuff = "";
    CommonWanInfo.IPv6StaticPrefix = "";
    CommonWanInfo.IPv6ReserveAddress = PPPWan.IPv6ReserveAddress;
    CommonWanInfo.IPv6IPAddress    = "";
    CommonWanInfo.IPv6AddrMaskLenE8c    = "64";
    CommonWanInfo.IPv6GatewayE8c    = "";
    CommonWanInfo.IPv6SubnetMask   = "";
    CommonWanInfo.IPv6Gateway      = "";
    CommonWanInfo.IPv6PrimaryDNS   = "";
    CommonWanInfo.IPv6SecondaryDNS = "";
    CommonWanInfo.IPv6WanMVlanId   = (PPPWan.IPv6MultiVlanID == "-1")  ?  "" : PPPWan.IPv6MultiVlanID;
    CommonWanInfo.Uptime = PPPWan.Uptime;
    CommonWanInfo.IPv4DNSOverrideSwitch = PPPWan.DNSOverrideAllowed;
    CommonWanInfo.X_HW_LowerLayers = PPPWan.X_HW_LowerLayers;
    CommonWanInfo.PPPoESessionID = PPPWan.PPoESessionID;
    CommonWanInfo.IPv4EnableMulticast = PPPWan.IPv4EnableMulticast;
    CommonWanInfo.StaticRouteInfo = PPPWan.StaticRouteInfo;
    CommonWanInfo.X_HW_DscpToPbitTbl = PPPWan.X_HW_DscpToPbitTbl;
    CommonWanInfo.Hurl = PPPWan.Hurl;
    CommonWanInfo.Motm = PPPWan.Motm;
    if (vxlanfeature == 1)
    {
        CommonWanInfo.X_HW_VXLAN_Enable = PPPWan.X_HW_VXLAN_Enable;
    }
    CommonWanInfo.X_HW_OperateDisable = PPPWan.X_HW_OperateDisable;
    CommonWanInfo.X_HW_BridgeEnable = PPPWan.X_HW_BridgeEnable;
    CommonWanInfo.X_HW_NPTv6Enable = PPPWan.X_HW_NPTv6Enable;
    CommonWanInfo.X_HW_SpeedLimit_UP = PPPWan.X_HW_SpeedLimit_UP;
    CommonWanInfo.X_HW_SpeedLimit_DOWN = PPPWan.X_HW_SpeedLimit_DOWN;
    CommonWanInfo.X_HW_IGMPEnable = PPPWan.X_HW_IGMPEnable; 
    CommonWanInfo.IPForwardModeEnabled = PPPWan.IPForwardModeEnabled;
    
    FillWanInfoForXD(CommonWanInfo);
}
