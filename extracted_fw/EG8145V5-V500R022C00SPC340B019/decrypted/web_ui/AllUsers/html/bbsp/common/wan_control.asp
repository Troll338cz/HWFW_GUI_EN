var CurrentWan = null;
var EditFlag = "";
var ChangeUISource = "";
var AddType     = 1;
var CurrentWan = new WanInfoInst();
var defaultWan  = new WanInfoInst();
var COMPLEX_CGI_PREFIX='Add_';
var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var DoubleFreqFlag = <%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>;
var curUserType='<%HW_WEB_GetUserType();%>';
var RadioWanFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_RADIO_WAN_LOAD);%>";
var ispSsidBindEnable ="<%HW_WEB_GetFeatureSupport(FT_ISP_SSID_BIND);%>";
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var DisliteFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BTV_WAN_PROTOCOL_IGNORE);%>";
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var supportTelmex = "<%HW_WEB_GetFeatureSupport(BBSP_FT_TELMEX);%>";
var Tdefeature = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var TDE2ModeFlag   = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var DSLTELMEXFlag   = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var Option60FT =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_IPTV_OPT60_ENCRY);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var ROSTelecomGlobalFeature="<% HW_WEB_GetFeatureSupport(FT_ROS_TELECOM_GLOBAL);%>";
var DisableNameAndPwd = '<%HW_WEB_GetFeatureSupport(BBSP_FT_DISNAMEANDPWD);%>';
var DscpFeature = "<%HW_WEB_GetFeatureSupport(FT_DSCP_TO_8021P_TEMPLATE);%>";
var MultiWanIpFeature = '<%HW_WEB_GetFeatureSupport(FT_WAN_MULTI_IP);%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var UpportDetectFlag ='<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var RadioFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UMTS_SUPPORT);%>";
var DnsOverrideFlag = "<%HW_WEB_GetFeatureSupport(BBSP_FT_WEB_CONFIG_DNS);%>";
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var IfVisual = "<%HW_WEB_IfVisualOltUser();%>";
var isSupportVLAN0 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_VLAN0_TAG);%>';
var isPTVDF = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var isSupportSFP = "<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SFP);%>";
var isSupportPON = "<%HW_WEB_GetFeatureSupport(FT_XD_PON_SURPPORTED);%>";
var isSAFARICOM = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SAFARICOM);%>';
var IsDNSLockEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DNS.DNSLockEnable);%>'
var APAutoUPPortFlag = '<%HW_WEB_GetFeatureSupport(FT_AP_WEB_SELECT_UPPORT);%>';
var IPV4V6Flag = '<%HW_WEB_GetFeatureSupport(FT_INTERNET_WAN_DEFAULT_DUALSTACK);%>';
var WANMODEChange = '<%HW_WEB_GetFeatureSupport(FT_WANMODE_TRANSLATE);%>';
var isWanForConfig = '<%HW_WEB_GetFeatureSupport(FT_WANAUTH_TRUE_USER);%>';
var isRosUnion = '<%HW_WEB_GetFeatureSupport(FT_ROS_UNION);%>';
var isBiznetForUser = '<%HW_WEB_GetFeatureSupport(FT_DISPLAY_GUESTWIFI_POOL);%>';
var isSupportNPTv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_NPTV6);%>';
var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
var oteFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>';
var htFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>';
var IsSupportLanAsWan = '<%HW_WEB_GetFeatureSupport(FT_LAN_AS_WAN);%>';
var ethNum = '<%WEB_GetEthNum();%>';
if (IsXdProduct()) {
    ethNum = '<%GetLanPortNum();%>';
}
var supportUnnumberMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_UNNUMBERD_MODE);%>';
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
var showWanName = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_WANNAME);%>';
var isSuportPolnetia = '<%HW_WEB_GetFeatureSupport(FT_WEB_POLNETIA);%>';
var isDSLSupport = '<%HW_WEB_GetFeatureSupport(HW_FT_DSL_SURPPORT);%>';
var upLinkLanPort ='<%HW_WEB_GetFeatureSupport(FT_WEB_NOSHOW_UPLINK_LAN);%>';
var isUnicomNetworkExpress = "<%HW_WEB_GetFeatureSupport(FT_UNICOM_NETWORK_EXPRESS);%>";
var isCUSupportNPTv6 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_AUTO_NPTV6_BY_SERVLIST);%>';
var isSupportAboard = '<%HW_WEB_GetFeatureSupport(FT_ABOARD_FTTO);%>';
var ponOnuBind = "<%HW_WEB_GetFeatureSupport(FT_FTTR_PON_ONU_BIND_CTRL);%>"
var UnicomFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>";
var cntFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CNT);%>';

function checkContainAny(string, targetValueList) {
	for (var i = 0; i < targetValueList.length; i++) {
			if (string.indexOf(targetValueList[i]) >= 0) {
					 return true;
			}
	}
	return false;
}

function SupportNPTv6(wan) {
    if ((isSupportNPTv6 == '1') && (isCUSupportNPTv6 != '1') && (wan.Mode.toString().toUpperCase() == "IP_ROUTED")
        && checkContainAny(wan.ServiceList, ["INTERNET", "IPTV", "OTHER", "OTT", "SPECIAL_SERVICE", "HQoS", "D_Bus"])) {
        return true;
    }
    return false;
}

function SupportOnlyGEWan() {
    if ((CfgModeWord.toUpperCase() == 'DTURKCELL2WIFI') || (CfgModeWord.toUpperCase() == 'TURKCELL2') ||
        (CfgModeWord.toUpperCase() == 'DGECOMMON2WIFI') || (SupportTtnet())) {
        return true;
    }
    return false;
}

function SupportUnnumberIp(wan) {
    if ((supportUnnumberMode == '1') && (wan.Mode.toString().toUpperCase() == "IP_ROUTED") &&
        (wan.EncapMode.toString().toUpperCase() == "PPPOE") && (wan.ServiceList.indexOf("INTERNET") >= 0)) {
        return true;
    }
    return false;
}

function IsUnnumberedWanExist() {
    for (var i = 0; i < GetWanList().length; i++) {
        if ((GetWanList()[i].EnableUnnumbered == '1') &&
            (GetWanList()[i].domain != GetCurrentWan().domain)) {
            return true;
        }
    }

    return false;
}

function stConfigPort(domain,X_HW_MainUpPort)
{
	this.domain = domain;
	this.X_HW_MainUpPort = X_HW_MainUpPort;
}

var PortConfigInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,X_HW_MainUpPort,stConfigPort);%>;
var PortConfigInfo = PortConfigInfos[0];

function SupportTtnet()
{
    return (CfgModeWord.toUpperCase() == "DTTNET2WIFI" || CfgModeWord.toUpperCase() == "TTNET2");
}

function IsFreInSsidName()
{
	if(1 == IsPTVDFFlag)
	{
		return true;
	}
	return false;
}
function IsSixteenSsidUser()
{
	if('CAMPUSLAN' == CfgModeWord.toUpperCase())
	{
		return true;
	}
	return false;
}
var LanNum = 8;
var SsidNum = 8;
if(true == IsSixteenSsidUser())
{
	SsidNum = 16;
}
function IsCurrentRadioWan()
{
    var Wan = GetCurrentWan();
    if (IsXdProduct() || (isSupportLte == "1"))
    {
        var AccessTtpe = Wan.WanAccessType;

        if (((RadioWanFeature == "1") || (isSupportLte == "1")) && (AccessTtpe == 'UMTS'))
        {
            return true;
        }
    }
    else
    {
        var AccessTtpe = Wan.AccessType;

        if (("1" == RadioWanFeature) && ('0' == AccessTtpe))
        {
            return true;
        }
    }
    return false;
}

function getInstIdByDomain(domain)
{
    if ('' != domain)
    {
        return parseInt(domain.charAt(domain.length - 1));
    }
}

function getWlanPortNumber(name)
{
    if ('' != name)
    {
        return parseInt(name.charAt(name.length - 1));
    }
}

function stWlan(domain, Name, ssid, X_HW_RFBand)
{
    this.domain = domain;
    this.Name = Name;
    this.ssid = ssid;
    this.X_HW_RFBand = X_HW_RFBand;
    this.WlanInst = getInstIdByDomain(domain);
}
if (1 == DoubleFreqFlag )
{
    var WlanListTotal = new Array();
	try
	{
        WlanListTotal = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, Name|SSID|X_HW_RFBand, stWlan);%>;
	}
	catch(e)
	{
		WlanListTotal = new Array(null);
	}
    var WlanListNum = WlanListTotal.length - 1;
	for (var i = 0; i < WlanListNum; i++)
    {
       for (var j = i; j < WlanListNum; j++)
       {
			var index_i = getWlanPortNumber(WlanListTotal[i].Name);
			var index_j = getWlanPortNumber(WlanListTotal[j].Name);

			if (index_i > index_j)
			{
				var WlanTemp = WlanListTotal[i];
				WlanListTotal[i] = WlanListTotal[j];
				WlanListTotal[j] = WlanTemp;
			}
		}
	}
}

function SetCurrentWan(Wan)
{
    CurrentWan = Wan;
}
function GetCurrentWan()
{
    if (CurrentWan != null)
    {
        return CurrentWan;
    }

    return GetPageData();
}
function IsConTrigCanBeSend(Wan)
{
    if (Wan.Mode.toString().toUpperCase() == 'IP_ROUTED' && Wan.ServiceList.toString().toUpperCase() == 'INTERNET')
    {
        return true;
    }

    return false;
}


function GetOriginalWan(Domain)
{
	var WanList = GetWanList();

	for (var i = 0; i < WanList.length; i++)
	{
		if (WanList[i].domain == Domain)
		{
			return WanList[i];
		}
	}

	return null;
}

function IsConnectionTypeChange()
{
	var CurrentWan = GetCurrentWan();
	var OriginalWan = GetOriginalWan(CurrentWan.domain);
	if (OriginalWan == null)
	{
		return true;
	}

	var CurrentType = (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) ? "BRIDGE" : "ROUTE";
	var OriginalType = (OriginalWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) ? "BRIDGE" : "ROUTE";

	return (CurrentType == OriginalType) ? false : true;
}

function IsOriginalTr069Type()
{
	var CurrentWan = GetCurrentWan();
	var OriginalWan = GetOriginalWan(CurrentWan.domain);
	if (OriginalWan == null)
	{
		return false;
	}

	return (OriginalWan.ServiceList.toUpperCase().indexOf("TR069") >= 0) ? true : false;
}

function AtmLinkInfoPanelVisible()
{
    if (DBAA1 == "1") {
        return IsAdminUser();
    }
    return true;
}

function ControlAtmLinkConfig(Wan)
{
	setDisplay("LinkInfoBarPanel", 0);
	setDisplay("WANPVCRow", 0);
	setDisplay("LinkModeRow", 0);
	setDisplay("ServiceTypeRow", 0);
	setDisplay("AccessEncapModeRow", 0);
	setDisplay("ATMPeakCellRateRow", 0);
	setDisplay("ATMMaximumBurstSizeRow", 0);
	setDisplay("ATMSustainableCellRateRow", 0);
	
	if(Wan.WanAccessType != 'DSL')
	{
		return;
	}
	
	setDisplay("LinkInfoBarPanel", AtmLinkInfoPanelVisible() ? 1 : 0);
	setDisplay("WANPVCRow", 1);
	setDisplay("LinkModeRow", 1);
	setDisplay("ServiceTypeRow", 1);
	setDisplay("AccessEncapModeRow", 1);
	
	if( 'UBR+' == getValue('ServiceType') || 'CBR' == getValue('ServiceType') )
	{
		setDisplay("ATMPeakCellRateRow", 1);
	}
	else if( 'VBR-nrt' == getValue('ServiceType') || 'VBR-rt' == getValue('ServiceType'))
	{
		setDisplay("ATMPeakCellRateRow", 1);
		setDisplay("ATMMaximumBurstSizeRow", 1);
		setDisplay("ATMSustainableCellRateRow", 1);			
	}

	setDisable("LinkMode", 0);

	if ((CfgModeWord.toUpperCase() == "TS2WIFI") && (Wan.ServiceList.toUpperCase().indexOf("TR069") >= 0) && (EditFlag.toUpperCase() != "ADD")) {
		setDisable("WANPVC", 1);
	} else if (CfgModeWord.toUpperCase() == "TS2WIFI") {
		setDisable("WANPVC", 0);
	}
	
	if (Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
	   setSelect('LinkMode', 'EoA');
	   setDisable("LinkMode", 1);
	   return; 
	}
}

var WANAccessTypeRowLoaded = false;
function CommonInterfaceConfig(domain, WANAccessType, BitRate)
{
    this.domain 	       = domain;
    this.WANAccessType = WANAccessType;
	this.BitRate = BitRate;
}

function DSLDisplayradio()
{
    if (ProductType == 2)
    {
        if (RadioFlag == 0)
        {
            return false;
        }
    }
    return true;
}

function ControlWANAccessType(Wan) {
	if(!WANAccessTypeRowLoaded) {
		var CommonInterfaceConfigList =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANCommonInterfaceConfig, WANAccessType|Layer1UpstreamMaxBitRate, CommonInterfaceConfig);%>;
		var UpIndex = 0;
		for(i = 0 ; i < CommonInterfaceConfigList.length-1; i++) {
	        if ((isDSLSupport == '1') && (CommonInterfaceConfigList[i].WANAccessType == "DSL")) {
				document.forms[0].WANAccessType[UpIndex] = new Option(Languages['ATM'], "DSL");
				UpIndex++;
			} else if ((isDSLSupport == '1') && (CommonInterfaceConfigList[i].WANAccessType == "VDSL")) {
				document.forms[0].WANAccessType[UpIndex] = new Option(Languages['PTM'], "VDSL");
				UpIndex++;
			} else if((CommonInterfaceConfigList[i].WANAccessType == "Ethernet") && (IsSupportBridgeWan == 0)) {
				document.forms[0].WANAccessType[UpIndex] = new Option(Languages['ETH'], "Ethernet");
				UpIndex++;
			} else if((CommonInterfaceConfigList[i].WANAccessType == "SFP") && (isSupportSFP == 1)) {
				document.forms[0].WANAccessType[UpIndex] = new Option(Languages['SFP'], "SFP");
				UpIndex++;
			} else if((CommonInterfaceConfigList[i].WANAccessType == "UMTS") && DSLDisplayradio()) {
				document.forms[0].WANAccessType[UpIndex] = new Option(Languages['RADIO'], "UMTS");
				UpIndex++;
			} else if((CommonInterfaceConfigList[i].WANAccessType == "PON" || CommonInterfaceConfigList[i].WANAccessType == "GPON") && (isSupportPON == "1")) {
				document.forms[0].WANAccessType[UpIndex] = new Option("PON uplink", "PON");
				UpIndex++;
			}
		}
		
		WANAccessTypeRowLoaded = true;
	}
	
	setDisplay("AccessTypeRow", 0);
	if ((CfgModeWord.toUpperCase() != 'DNZTELECOM2WIFI') && (CfgModeWord.toUpperCase() != 'TTNET2')) {
		setDisplay("SwitchModeRow", 0);
	}
	
	setDisable("WANAccessType", EditFlag.toUpperCase() == "ADD" ? 0 : 1);
	setSelect("WANAccessType", Wan.WanAccessType);
	
}


function ControlPonAndLteWANAccessType(Wan) {
	if(!WANAccessTypeRowLoaded) {
		document.forms[0].WANAccessType[0] = new Option("PON uplink", "GPON");
		document.forms[0].WANAccessType[1] = new Option(Languages['RADIO'], "UMTS");
		WANAccessTypeRowLoaded = true;
	}
	
	setDisplay("AccessTypeRow", 0);
	if ((CfgModeWord.toUpperCase() != 'DNZTELECOM2WIFI') && (CfgModeWord.toUpperCase() != 'TTNET2')) {
		setDisplay("SwitchModeRow", 0);
	}
	
	setDisable("WANAccessType", EditFlag.toUpperCase() == "ADD" ? 0 : 1);
	setSelect("WANAccessType", Wan.WanAccessType);
}

function ControlWanName()
{
    if (showWanName != "1") {
        return;
    }

    if (IsAdminUser() == true) {
        setDisplay("WanNameRow", 1);
        setDisable("WanName", EditFlag.toUpperCase() == "ADD" ? 0 : 1);
    } else {
        setDisplay("WanNameRow", 0);
    }
}

function ControlSpecXD(Wan)
{
    if(!IsXdUpMode())
    {
        if (isSupportLte == "1") {
            ControlPonAndLteWANAccessType(Wan);
        }
        return;
    }

    if( Wan.WanAccessType == "VDSL" || Wan.WanAccessType == "DSL" || Wan.WanAccessType == "Ethernet" || (Wan.WanAccessType == "SFP" && 1 == isSupportSFP))
    {
        if (Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0)
        {
            setDisplay("WanIPv4InfoBarPanel", 0);
            setDisplay("WanIPv6InfoBarPanel", 0);
        }

        if (CfgModeWord.toUpperCase() == "DMOBILY2WIFI" && Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0 &&
            GetCurrentWan().ServiceList == 'IPTV') {
            if (Wan.ProtocolType.toString().toUpperCase() == "IPV4") {
                setDisplay("WanIPv4InfoBarPanel", 1);
                setDisplay("IPv4WanMVlanIdRow", 1);
            } else if (Wan.ProtocolType.toString().toUpperCase() == "IPV6") {
                setDisplay("WanIPv6InfoBarPanel", 1);
                setDisplay("IPv6WanMVlanIdRow", 1);
            } else if (Wan.ProtocolType.toString().toUpperCase() == "IPV4/IPV6") {
                setDisplay("WanIPv4InfoBarPanel", 1);
                setDisplay("WanIPv6InfoBarPanel", 1);
                
                setDisplay("IPv4WanMVlanIdRow", 1);
                setDisplay("IPv6WanMVlanIdRow", 1);
            }
            
        } else {
            setDisplay("IPv4WanMVlanIdRow", 0);
            setDisplay("IPv6WanMVlanIdRow", 0);
        }

    }

    ControlAtmLinkConfig(Wan);    
    ControlWANAccessType(Wan);
}

var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
function ControlSpec()
{
    setDisplay("WanDomainRow", 0);
    setDisplay("IPv6SubnetMaskRow", 0);
    setDisplay("IPv6DefaultGatewayRow", 0);
	setDisplay("IPV6sourcemodeRow", 0);
	if(isSAFARICOM != 1)
	{
		setDisplay("IPV6OverrideAllowedRow", 0);
		
	}
	setDisplay("IPV6sourcemodeRow", 0);
	if(IsPTVDFFlag == "1")
	{
		setDisplay("IPV6sourcemodeRow", 1);
	}

    var FeatureInfo = GetFeatureInfo();
    if (FeatureInfo.IPv6 == "0")
    {

        setDisplay("WanIPv4InfoBarRow", 0);
        setDisplay("WanIPv6InfoBarRow", 0);
        setDisplay("IPv6PrefixModeRow", 0);
        setDisplay("IPv6StaticPrefixRow", 0);
        setDisplay("IPv6AddressModeRow", 0);
        setDisplay("TDEIPv6UnnumberedModelRow", 0);
        setDisplay("TDEDHCP6cForAddressRow", 0);
        setDisplay("TDEIPv6AddressingTypeRow", 0);
        setDisplay("IPv6AddressStuffRow", 0);
        setDisplay("IPv6IPAddressRow", 0);
        setDisplay("IPv6AddrMaskLenE8cRow", 0);
        setDisplay("IPv6GatewayE8cRow", 0);
		setDisplay("IPv6ReserveAddress", 0);
        setDisplay("IPv6SubnetMaskRow", 0);
        setDisplay("IPv6DefaultGatewayRow", 0);
        setDisplay("IPv6PrimaryDNSServerRow", 0);
        setDisplay("IPv6SecondaryDNSServerRow", 0);
        setDisplay("IPv6WanMVlanIdRow", 0);
        setDisable("ProtocolType", 1);
        setSelect("ProtocolType", "IPv4");
		setDisplay("PrifixEnabledRow", 0);
    }
    if (FeatureInfo.WanPriPolicy == "0")
    {
        setDisplay("PriorityPolicyRow", 0);
    }
}

function ControlPanel()
{
    var Wan = GetCurrentWan();
    var Type = Wan.ProtocolType.toString();
    var IPv4BarIndex = 0;
    var IPv6BarIndex = 0;


    setDisplay("WanIPv4InfoBarPanel", 0);
    setDisplay("WanIPv6InfoBarPanel", 0);

   if(false == IsRDSGatewayUser())
   {
	    if (Type.toUpperCase()=="IPV4")
	    {
	        setDisplay("WanIPv4InfoBarPanel", 1);
	    }

	    if (Type.toUpperCase()=="IPV6")
	    {
	        setDisplay("WanIPv6InfoBarPanel", 1);
	    }

        if (Type.toUpperCase()=="IPV4/IPV6")
        {
	        setDisplay("WanIPv4InfoBarPanel", 1);
	        setDisplay("WanIPv6InfoBarPanel", 1);
	    }

        if(IsXdProduct())
        {
            setDisplay("LinkInfoBarPanel", 1);
        }

		if (true == IsCurrentRadioWan())
		{
			setDisplay("WanIPv4InfoBarPanel", 0);
			setDisplay("WanIPv6InfoBarPanel", 0);
            if(IsXdProduct())
            {
                setDisplay("LinkInfoBarPanel", 0);
            }
		}
    }

}

function ControlDislite()
{
    var Wan = GetCurrentWan();

   if(false == IsRDSGatewayUser())
   {
	    if ((Wan.IPv6DSLite=="Dynamic")
		    ||(Wan.IPv6DSLite=="Static"))
	    {
		    setDisplay("WanIPv4InfoBarPanel", 1);
	        setDisplay("WanIPv4InfoBarRow", 1);
			setDisplay("IPv4WanMVlanIdRow",1);
			setDisplay("IPv4AddressModeRow", 0);
		    setDisplay("IPv4NatSwitchRow", 0);
		    setDisplay("IPv4NatTypeRow", 0);
		    setDisplay("IPv4VendorIdRow", 0);
		    setDisplay("IPv4ClientIdRow", 0);
			setDisplay("IPv4ClientIdRow", 0);
	    }
    }

}


function ControlIPv4AddressMode()
{
    setDisplay("IPv4AddressModeRow", 1);
    if (GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED")
    {
        setDisplay("IPv4AddressModeRow", 0);
    }

}

function ControlIPv4DHCPEnable()
{
    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();
	var Wan = GetCurrentWan();
    var src = getElementById('ServiceList');

    setDisplay("LanDhcpSwitchRow", 0);
    if ( ServiceList.match('INTERNET') || ServiceList.match('IPTV') || ServiceList.match('OTHER') )
    {
        if(isE8cAndCMCC())
        {
	        setDisplay("LanDhcpSwitchRow", 1);
	    }
    }

    if(('JSCMCC' == CfgModeWord.toUpperCase()) && (getElementById('VlanId').value == 4031) && (curUserType == 0) && Instance_IspWlan.IsWanHidden(domainTowanname(Wan.domain)) == true)
    {
        setDisable("LanDhcpSwitch", 1);
    }
	else
	{
		setDisable("LanDhcpSwitch", 0);
	}

    if(EditFlag.toUpperCase() == "ADD" && ChangeUISource == src)
    {
        if (ServiceList == "OTHER")
	    {
            setCheck("LanDhcpSwitch", 0);
        }
	    else
	    {
	        setCheck("LanDhcpSwitch", 1);
	    }
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("LanDhcpSwitchRow", 0);
	}
}

function IsDstIPForwardingListVisibility(Wan,ServiceList)
{
  var CurrentBin = '<%HW_WEB_GetBinMode();%>';
	if (   (ServiceList == "TR069")
	     ||(ServiceList == "VOIP")
	     ||(ServiceList == "TR069_VOIP")
	     ||("IP_BRIDGED" == Wan.Mode.toString().toUpperCase())
	     ||("PPPOE_BRIDGED" == Wan.Mode.toString().toUpperCase()))
	{
		return false;
	}

    if (isUnicomNetworkExpress == '1') {
        return true;
    }

	if ('E8C' != CurrentBin.toUpperCase())
	{
		return false;
	}
	return true;
}

function Option60DisplayFlag(Wan)
{
	if((1 == Option60FT)
	&& (CurrentWan.EncapMode.toString().toUpperCase() == "IPOE")
	&& (Wan.ServiceList.toString().toUpperCase().indexOf("VOIP") < 0)
	&& Wan.Mode == "IP_Routed"
	&& ((Wan.ProtocolType.toString().toUpperCase()=="IPV4/IPV6") || ((Wan.ProtocolType.toString().toUpperCase()=="IPV4"))))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function Option60Display(Wan)
{
	setDisplay("Option60EnableRow","0");
	setDisplay("IPoEUserNameRow", "0");
	setDisplay("IPoEPasswordRow", "0");
	if(true == Option60DisplayFlag(Wan))
	{
		setDisplay("Option60EnableRow","1");
		if("1" == Wan.EnableOption60)
		{
			setDisplay("IPoEUserNameRow", 1);
			setDisplay("IPoEPasswordRow", 1);
		}
        if(!IsAdminUser()
           || ((CfgModeWord.toUpperCase() == 'HAINCU') && (Wan.ServiceList.indexOf("TR069") >= 0))
           || ((CfgModeWord.toUpperCase() == 'SDCU') && (Wan.ServiceList.indexOf("TR069") >= 0)))
		{
			setDisable("Option60Enable","1");
            setDisable("IPoEUserName","1");
            setDisable("IPoEPassword","1");
		}

        if (!IsAdminUser() && (CfgModeWord.toUpperCase() == 'HEBCU')) {
            setDisable("IPoEUserName", "0");
            setDisable("IPoEPassword", "0");
        }
	}
	return ;
}

function ControlDstIPForwardingListVisibility()
{
	var Wan = GetCurrentWan();
	var ServiceList = Wan.ServiceList;

    if (isUnicomNetworkExpress == '1') {
        setDisplay("IPForwardModeEnabledRow", 1);
    }

	setDisplay("DstIPForwardingListRow", 1);
	setDisplay("DstIPForwardingList", 1);

    if (Wan.IPForwardModeEnabled == "0") {
        setDisplay("DstIPForwardingListRow", 0);
        setDisplay("DstIPForwardingList", 0);
    }

	if (( false == IsDstIPForwardingListVisibility(Wan,ServiceList) )||(true == IsCurrentRadioWan()))
	{
		setDisplay("DstIPForwardingListRow", 0);
		setDisplay("DstIPForwardingList", 0);
        setDisplay("IPForwardModeEnabledRow", 0);
	}
}

function setWirelessDisplay(flag)
{
	setDisplay("RadioWanPSEnableRow", flag);
	setDisplay("SwitchModeRow", flag);
	setDisplay("SwitchDelayTimeRow", flag);
	setDisplay("PingIPAddressRow", flag);
	setDisplay("DialInfoBarRow", flag);
	setDisplay("RadioWanUsernameRow", flag);
	setDisplay("RadioWanPasswordRow", flag);
	setDisplay("APNRow", flag);
	setDisplay("DialNumberRow", flag);

    if (isSupportLte == "1") {
        setDisplay("ltebandRow", flag);
        setDisplay("BackupModeRow", flag);
        if (getRadioVal('BackupMode') == 0) {
            setDisplay("BackupDelayTimeRow", 0);
        } else {
            setDisplay("BackupDelayTimeRow", flag);
        }
        setDisplay("SwitchDelayTimeRow", 0);
        setDisplay("PingIPAddressRow", 0);
        setDisplay("DialNumberRow", 0);
        setDisplay("LteProfileRow", 0);
    }

	if (('DNZTELECOM2WIFI' == CfgModeWord.toUpperCase()) || (isSupportLte == "1") )
	{
		setDisplay("TriggerModeRow", 0);
	}
	else
	{
		setDisplay("TriggerModeRow", flag);
	}
}

function setPonDisplay(flag)
{
	setDisplay("WanSwitchRow", flag);
	setDisplay("EncapModeRow", flag);
	setDisplay("ProtocolTypeRow", flag);
	setDisplay("WanModeRow", flag);
	setDisplay("ServiceListRow", flag);
	setDisplay("VlanSwitchRow", flag);
}

function CntrolAccessType()
{
    if(IsXdProduct())
    {
        return;
    }
	if (RadioWanFeature == "1")
	{
		setDisplay("AccessTypeRow", 1);
	}
	else
	{
		setDisplay("AccessTypeRow", 0);
	}
}

function ControlRadioWan(Wan)
{
    if (IsXdProduct() || (isSupportLte == "1"))
    {
        if (true == IsCurrentRadioWan())
        {
            setWirelessDisplay(1);
            setPonDisplay(0);
            if (isSupportLte == "1") {
                setDisplay("ServiceListRow", 1);
                var svrlist = getElementById("ServiceList");
                RemoveItemFromSelect(svrlist , Languages['TR069_IPTV_INTERNET']);
                RemoveItemFromSelect(svrlist , Languages['TR069_IPTV']);
                RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_IPTV']);
                RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_IPTV_INTERNET']); 
                RemoveItemFromSelect(svrlist , Languages['IPTV']);
                RemoveItemFromSelect(svrlist , Languages['OTHER']);
                RemoveItemFromSelect(svrlist , Languages['IPTV_INTERNET']);
                RemoveItemFromSelect(svrlist , Languages['VOIP_IPTV']);
                RemoveItemFromSelect(svrlist , Languages['VOIP_IPTV_INTERNET']);

                if (Wan.X_HW_LteProfile == 1) {
                    setDisable("RadioWanPSEnable", 0);
                } else {
                    setDisable("RadioWanPSEnable", 1);
                }
            }
        }
        else
        {
            setWirelessDisplay(0);
            setPonDisplay(1);
        }

        if (isSupportLte == "1") {
            setDisplay('ProtocolTypeRow', 1);
        }

		if ((CfgModeWord.toUpperCase() != 'DNZTELECOM2WIFI') && (CfgModeWord.toUpperCase() != 'TTNET2')) {
			setDisplay("SwitchModeRow", 0);
		}

        if (CfgModeWord.toUpperCase() == 'DETHMAXIS') {
            setDisplay("DialInfoBarPanel", 0);
        }
    }
    else
    {
        var Wan = GetCurrentWan();
        var AccessTtpe = Wan.AccessType;
        if ("1" == RadioWanFeature)
        {
            if ('0' == AccessTtpe)
            {
                setWirelessDisplay(1);
                setPonDisplay(0);
            }
            else
            {
                setWirelessDisplay(0);
                setPonDisplay(1);
            }
        }
        else
        {
            setWirelessDisplay(0);
        }
    }
}


function displayWanMode()
{
	var wanMode = getElementById('WanMode');
	if(bin5board() == true || APAutoUPPortFlag == 1)
	{
		RemoveItemFromSelect(wanMode, 'IP_Bridged');
	}
}

function displayProtocolType()
{
	var protoType = getElementById('ProtocolType');
	var IPProtVer = Instance_IPVersion.GetIPProtVerMode();
	var Feature = GetFeatureInfo();

	if ((bin5board() == true)
	 || ((EditFlag.toUpperCase() == "ADD") && (Feature.IPProtChk == 1) && (IPProtVer == 1)))
	{
		RemoveItemFromSelect(protoType, Languages['IPv4IPv6']);
		RemoveItemFromSelect(protoType, Languages['IPv6']);
	}
	else if ((EditFlag.toUpperCase() == "ADD") && (Feature.IPProtChk == 1) && (IPProtVer == 2))
	{
		RemoveItemFromSelect(protoType, Languages['IPv4IPv6']);
		RemoveItemFromSelect(protoType, Languages['IPv4']);
	}
}

function displaysvrlist()
{
	if (EditFlag.toUpperCase() == "ADD")
	{
		Controlsvrlist();
	}
}

function getMtuMaxAllowCfg(Wan)
{
	var specIPoEMTUMax = '<%HW_WEB_GetSPEC(SPEC_LOWER_LAYER_MAX_MTU.UINT32);%>';
	var maxMtuCfg = 1540;
	if (parseInt(specIPoEMTUMax, 10) != 1500)
	{
		if(Wan.IPv4AddressMode.toUpperCase() == "PPPOE")
		{
			maxMtuCfg = parseInt(specIPoEMTUMax, 10) - 8;
		}
		else
		{
			maxMtuCfg = parseInt(specIPoEMTUMax, 10);
		}
	}
	return maxMtuCfg;
}


function ControlIPv4MXU()
{
    var WanProtocolType = GetCurrentWan().ProtocolType.toString();
    var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();
    var MXURemarkStr = "";

    if ((GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE") && (CfgModeWord.toUpperCase() != 'CNT') && (CfgModeWord.toUpperCase() != 'CNT2'))
    {
        setObjNoEncodeInnerHtmlValue(document.getElementById("IPv4MXURow").cells[0], Languages['IPv4MRU']);
    }
    else
    {
        setObjNoEncodeInnerHtmlValue(document.getElementById("IPv4MXURow").cells[0], Languages['IPv4MXU']);
    }

    setDisplay("IPv4MXURow", 1);

    if ((GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED") || (GetCfgMode().PCCWHK == "1") ||
        (IsCurrentRadioWan() == true) || (CfgModeWord.toUpperCase() == "PCCW")) {
        setDisplay("IPv4MXURow", 0);
    }

	if ( (1 == TDE2ModeFlag)
	    && ((GetCurrentWan().ServiceList == 'IPTV') || (GetCurrentWan().ServiceList == 'VOIP')))
	{
		setDisplay("IPv4MXURow", 0);
	}

    var maxMtuCfg = getMtuMaxAllowCfg(GetCurrentWan());

    if (WanProtocolType.match("IPv6"))
    {

    maxMtuCfg = maxMtuCfg < 1280 ? 1540 : maxMtuCfg;

		MXURemarkStr = ("ARABIC" == LoginRequestLanguage.toUpperCase()) ? "("+ maxMtuCfg + "-1280)" : "(1280-" + maxMtuCfg + ")";
		setElementInnerHtmlById("IPv4MXURemark", MXURemarkStr);
		getElById('IPv4MXU').title = MXURemarkStr;
    }
    else
    {
		MXURemarkStr = ("ARABIC" == LoginRequestLanguage.toUpperCase()) ?"("+ maxMtuCfg + "-1)" :  "(1-"+ maxMtuCfg + ")";
        setElementInnerHtmlById("IPv4MXURemark", MXURemarkStr);
		getElById('IPv4MXU').title = MXURemarkStr;
    }
}

function CheckWanSet(Wan)
{
	if(productName == 'HG8110H')
	{
		if ((Wan.ServiceList.toString().toUpperCase() != "TR069") && (Wan.ServiceList.toString().toUpperCase() != "VOIP") && (Wan.ServiceList.toString().toUpperCase() != "TR069_VOIP"))
		{
			AlertEx(Languages['CantSetInvalidSrv']);
			return false;
		}
	}

	return true;
}

function IsBin5IPONLY()
{
	if (('IPONLY' == CfgModeWord.toUpperCase()) && (productName == 'HG8040P'))
	{
		return true;
	}
	return false;
}

function isUnicomTr069orVoipWan()
{
    if (UnicomFlag != 1) {
        return false;
    }

    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();
    if ((ServiceList =="TR069") || (ServiceList == "VOIP") || (ServiceList =="TR069_VOIP")) {
        return true;
    }
    return false;
}

function ControlIPv4EnableNAT()
{
    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();

    setDisplay("IPv4NatSwitchRow", 0);
    setDisplay("IPv4NatTypeRow", 0);

    if ( (FeatureInfo.LanSsidWanBind == "0") || (IsBin5IPONLY()) || (IsSupportBridgeWan == 1))
    {
        return;
    }

    var src = getElementById('ServiceList');
    if(EditFlag.toUpperCase() == "ADD" && ChangeUISource == src)
    {
        if (checkContainAny(ServiceList, ["INTERNET", "IPTV", "OTHER", "HQOS", "D_BUS"]))
        {
            setCheck("IPv4NatSwitch", 1);
        }
        else
        {
            setCheck("IPv4NatSwitch", 0);
        }
    }

    if (GetCurrentWan().Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0)
    {
       setCheck('IPv4NatSwitch', 1);
       return;
    }

	if (IsPTVDFFlag == 1)
	{
		if ( (ServiceList.indexOf("INTERNET") >=0 ) || (ServiceList.indexOf("IPTV") >=0) || (ServiceList.indexOf("OTHER") >=0) || (ServiceList.indexOf("VOIP") >=0))
		{
			setDisplay("IPv4NatSwitchRow", 1);
			if ("1" == GetRunningMode())
			{
				setDisplay("IPv4NatTypeRow", 0);
			}
			else
			{
				setDisplay("IPv4NatTypeRow", 1);
			}

			if (getCheckVal("IPv4NatSwitch") == "1")
			{
				setDisable("IPv4NatType", 0);
			}
			else
			{
				setDisable("IPv4NatType", 1);
			}
		}
	}
	else
	{
		if (checkContainAny(ServiceList, ["INTERNET", "IPTV", "OTHER", "HQOS", "D_BUS"]))
		{
			setDisplay("IPv4NatSwitchRow", 1);

			if (("1" == GetCfgMode().TELMEX)
			||("1" == GetCfgMode().PCCWHK)
			||("1" == GetCfgMode().MOBILY)
			||("1" == GetRunningMode()))
			{
				setDisplay("IPv4NatTypeRow", 0);
			}
			else
			{
				setDisplay("IPv4NatTypeRow", 1);
			}


			if (getCheckVal("IPv4NatSwitch") == "1")
			{
				setDisable("IPv4NatType", 0);
			}
			else
			{
				setDisable("IPv4NatType", 1);
			}
		}
        else
        {
            if (IsE8cFrame() == false) {
                setDisplay("IPv4NatSwitchRow", 1);
            }

            if (UnicomFlag == 1) {
                setDisplay('IPv4NatSwitchRow', 0);
            }
        }
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv4NatSwitchRow", 0);
		setDisplay("IPv4NatTypeRow", 0);
	}
}


function ControlVlanId()
{
	var VlanId;
    setDisplay("VlanIdRow", 0);
    if (GetCurrentWan().EnableVlan.toString().toUpperCase() == "1")
    {
        setDisplay("VlanIdRow", 1);
		if (true == IsCurrentRadioWan())
		{
			 setDisplay("VlanIdRow", 0);
		}
		VlanId = GetCurrentWan().VlanId;
		if (0 == VlanId)
		{
			if (GetCurrentBin().toUpperCase() == "E8C")
			{
				setText('VlanId',1);
			}
			else if (1 == isSupportVLAN0)
			{
				setText('VlanId',0);
			}
			else
        	{
				setText('VlanId','');
			}
		} else if (VlanId == "-1") {
			setText('VlanId', "");
		}
    }
}


function ControlIPv4VendorId()
{
    setDisplay("IPv4VendorIdRow", 0);
    if (GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED" && GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "DHCP")
    {
        setDisplay("IPv4VendorIdRow", 1);
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv4VendorIdRow", 0);
	}
}

function ControlIPv4Unnumbered()
{
    setDisplay("IPv4UnnumberedSwitchRow", 0);
    setDisplay("IPv4UnnumberedIpAddressRow", 0);
    setDisplay("IPv4UnnumberedSubnetMaskRow", 0);

    if (SupportUnnumberIp(GetCurrentWan()) == false) {
        return;
    }

    if (IsUnnumberedWanExist() == true) {
        return;
    }

    setDisplay("IPv4UnnumberedSwitchRow", 1);
    if (GetCurrentWan().EnableUnnumbered == '1') {
        setDisplay("IPv4UnnumberedIpAddressRow", 1);
        setDisplay("IPv4UnnumberedSubnetMaskRow", 1);
    } else {
        setDisplay("IPv4UnnumberedIpAddressRow", 0);
        setDisplay("IPv4UnnumberedSubnetMaskRow", 0);
    }
}

function ControlDscpToPbit()
{
    if(1== DscpFeature)
    {
        var selwanmode=document.getElementById("WanMode").options[document.getElementById("WanMode").selectedIndex].value;
        var optionlen = document.getElementById("PriorityPolicy").options.length;
        if (selwanmode.toString().toUpperCase()=="IP_BRIDGED")
        {
            $("#PriorityPolicy option[value='DscpToPbit']").remove();
        }
        else
        {
            if(optionlen<3)
            {
                $("#PriorityPolicy").append('<option id="3" value="DscpToPbit">' + Languages['DscpToPbit'] + '</option>');
            }
        }
    }
    else
    {
    	$("#PriorityPolicy option[value='DscpToPbit']").remove();
    }
}
function ControlIPv4ClientId()
{
    setDisplay("IPv4ClientIdRow", 0);
    if ( (!isE8cAndCMCC()) && GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED" && GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "DHCP")
    {
        setDisplay("IPv4ClientIdRow", 1);
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv4ClientIdRow", 0);
	}
}

function ControlMultiWanIP()
{
    setDisplay("IPv4IPAddressSecondRow", 0);
    setDisplay("IPv4SubnetMaskSecondRow", 0);
    setDisplay("IPv4IPAddressThirdRow", 0);
    setDisplay("IPv4SubnetMaskThirdRow", 0);
    if(GetCurrentWan().IPv4AddressMode.toString().toUpperCase() != "PPPOE"
        && MultiWanIpFeature == "1")
    {
        setDisplay("IPv4IPAddressSecondRow", 1);
        setDisplay("IPv4SubnetMaskSecondRow", 1);
        setDisplay("IPv4IPAddressThirdRow", 1);
        setDisplay("IPv4SubnetMaskThirdRow", 1);
    }	
}

function ControlIPv4StaticIPAddress()
{
    var IPv4AddressType = GetCurrentWan().IPv4AddressMode.toString().toUpperCase();
    setDisplay("IPv4IPAddressRow", 0);
    setDisplay("IPv4SubnetMaskRow", 0);
    setDisplay("IPv4DefaultGatewayRow", 0);
    setDisplay("IPv4DNSOverrideSwitchRow", 0);
    setDisplay("IPv4PrimaryDNSServerRow", 0);
    setDisplay("IPv4SecondaryDNSServerRow", 0);
    if (IPv4AddressType == "STATIC" && GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED")
    {
        setDisplay("IPv4IPAddressRow", 1);
        setDisplay("IPv4SubnetMaskRow", 1);
        setDisplay("IPv4DefaultGatewayRow", 1);
        setDisplay("IPv4PrimaryDNSServerRow", 1);
        setDisplay("IPv4SecondaryDNSServerRow", 1);
    }
	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv4IPAddressRow", 0);
		setDisplay("IPv4SubnetMaskRow", 0);
		setDisplay("IPv4DefaultGatewayRow", 0);
		setDisplay("IPv4PrimaryDNSServerRow", 0);
		setDisplay("IPv4SecondaryDNSServerRow", 0);
	}
	if (isPTVDF == "1" && GetCurrentWan().IPv4Enable ==1 && CurrentWan.ServiceList.toUpperCase().indexOf("INTERNET") >= 0)
	{
        setDisplay("IPv4PrimaryDNSServerRow", 0);
        setDisplay("IPv4SecondaryDNSServerRow", 0);
		setDisplay("wandnsInfoBarRow",1);
		setDisplay("sourcemodeRow",1);
		setDisplay("primarydnsRow",1);
		setDisplay("secondarydnsRow",1);
	}
	else
	{
		setDisplay("wandnsInfoBarRow",0);
		setDisplay("sourcemodeRow",0);
		setDisplay("primarydnsRow",0);
		setDisplay("secondarydnsRow",0);
	}

}

function  ControlIPv4IGMPEnable()
{
	if(0 == ROSTelecomGlobalFeature)
	{
		setDisplay("IPv4EnableMulticastRow",0);
		return ;
	}
	var Wan = GetCurrentWan();
	if((Wan.Mode.toString().toUpperCase().indexOf("ROUTED") >= 0)
		&&((Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
		|| (Wan.ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0)
		|| (Wan.ServiceList.toString().toUpperCase().indexOf("OTHER") >= 0)))
	{
		setDisplay("IPv4EnableMulticastRow",1);
	}
	else
	{
		setDisplay("IPv4EnableMulticastRow",0);
	}
}


function ControlUserName()
{
    var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
    setDisplay("UserNameRow", 0);
    setDisplay("PasswordRow", 0);
	setDisplay("PPPAuthenticationProtocolRow", 0);


	setDisable("UserName",0);
	setDisable("Password",0);

    if (EncapMode == "PPPOE" && GetCurrentWan().Mode == "IP_Routed")
    {
        setDisplay("UserNameRow", 1);
        setDisplay("PasswordRow", 1);
		if (CfgModeWord.toUpperCase()  == 'BHARTI')
		{
			setDisplay("PPPAuthenticationProtocolRow", 1);
		}
    }    
	
	if(DisableNameAndPwd == '1' && curUserType != '0')
	{
		setDisable("UserName",1);
		setDisable("Password",1);
	}  
	
	if ((CfgModeWord.toUpperCase() == 'ROSUNION') && (!IsAdminUser())) {
		if (GetCurrentWan().ServiceList.toString().toUpperCase() =='INTERNET') {
			setDisable("UserName", 0);
			setDisable("Password", 0);
		} else {
			setDisable("UserName", 1);
			setDisable("Password", 1);
		}
	}

	if(Instance_IspWlan.IsOnlyReadWan( GetCurrentWan() ))
    {
		setDisable("UserName",1);
		setDisable("Password",1);
	}

	if (true == IsCurrentRadioWan())
	{
		setDisplay("UserNameRow", 0);
        setDisplay("PasswordRow", 0);
		setDisplay("PPPAuthenticationProtocolRow", 0);
	}
    if (DSLTELMEXFlag == 1)
    {
        if (getValue("UserName") == "")
        {
            setText("UserName","pppoe1@dsl_dom201");
        }
    }
    if ((CfgModeWord.toUpperCase()  == 'TOTALPLAY') || (CfgModeWord.toUpperCase()  == 'TOTALPLAY2'))
    {
        if (curUserType != '0')
        {
            setDisable("UserName",1);
            setDisable("Password",1);
        }
    }

    if ((WANMODEChange == 1) && (IsAdminUser() != true))
    {
        setDisplay("UserNameRow", 0);
        setDisplay("PasswordRow", 0);
        setDisplay("PPPAuthenticationProtocolRow", 0);
    }

    if (((CfgModeWord.toUpperCase() == 'MONGOLIA') || (CfgModeWord.toUpperCase() == 'MONGOLIA2'))
        && (EditFlag.toUpperCase() == "EDIT")) {
        setDisable("UserName",1);
        setDisable("Password",1);
    }

    if ((GetCfgMode().BJUNICOM == "1") && (IsAdminUser() != true)) {
        if (GetCurrentWan().ServiceList.toString().toUpperCase().indexOf("TR069") >=0) {
            setDisable("UserName", 1);
            setDisable("Password", 1);
        } else {
            setDisable("UserName", 0);
            setDisable("Password", 0);
        }
    }
}

function ControlApplyButton(Wan)
{
	var DisableButton = false;
       var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();

	if (!IsAdminUser())
	{
		if(EncapMode == "PPPOE" && GetCurrentWan().Mode == "IP_Routed")
		{
			if(DisableNameAndPwd == '1')
			{
				DisableButton = true;
			}
		}
	else
		{
			if(false == IsSonetUser())
			{
				DisableButton = true;
			}
		}

		if( GetCurrentWan().ServiceList.toString().toUpperCase() =='INTERNET'
				&&(GetCfgMode().BJCU == "1" || IsLanBJUNICOM()) )
		{
			DisableButton = false;
		}

		if(CfgModeWord.toUpperCase() == 'QTEL')
		{
			DisableButton = true;
		}

		if (true == IsCurrentRadioWan())
		{
			DisableButton = false;
		}

		if ((IsLanUpCanOper() == true) || (tedataGuide == 1) || (oteFlag == "1") || (IsEnWebUserModifyWan() == true))
		{
			DisableButton = false;
		}

		if ((GetCfgMode().TRUE == "1") || (isSuportPolnetia == "1")) {
			DisableButton = false;
		}

		if (GetCfgMode().TRUE == "1") 
		{
			DisableButton = false;
		}

        if ((CfgModeWord.toUpperCase() == 'TELECENTRO') || (WANMODEChange == 1))
        {
            DisableButton = false;
        }
    }

	if(true == Option60DisplayFlag(Wan)
		&& ("1" == Wan.EnableOption60))
	{
		DisableButton = false;
	}

	if ((CfgModeWord.toUpperCase() == "BELTELECOM2") && (!((Wan.ServiceList.toUpperCase() == "TR069") || (Wan.ServiceList.toUpperCase() == "VOIP")))) {
		DisableButton = false;
	}

	setDisable("ButtonApply", DisableButton?1:0);
	setDisable("ButtonCancel", DisableButton?1:0);
}

function ControlLcpCheck()
{
    var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
    setDisplay("LcpEchoReqCheckRow", 0);
    if ((!isE8cAndCMCC()) && EncapMode == "PPPOE" && GetCurrentWan().Mode == "IP_Routed")
    {
        setDisplay("LcpEchoReqCheckRow", 1);
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("LcpEchoReqCheckRow", 0);
	}
}

function IPv4DialModetoManul()
{
	var Wan = GetPageData();
	if (Wan.domain.length > 10 && Wan.IPv4DialMode.toUpperCase() == "MANUAL")
	{
		var i = 0;
		for (i = 0; i < GetWanList().length; i++)
		{
			if (GetWanList()[i].domain == Wan.domain)
			{
				break;
			}
		}

		if (GetWanList()[i].IPv4DialMode.toUpperCase()== "ONDEMAND" || GetWanList()[i].IPv4DialMode.toUpperCase()== "ALWAYSON")
		{
			return true;
		}
	}
	return false;
}

function ControlIPv4Dial()
{
    setDisplay("IPv4DialModeRow", 0);
    setDisplay("IPv4DialIdleTimeRow", 0);
    setDisplay("IPv4IdleDisconnectModeRow", 0);
	setDisplay("IPv4DialConnectManualRow", 0);

    if (GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED")
    {
        return;
    }

    if (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() != "PPPOE")
    {
        return;
    }


    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();
    if (GetCfgMode().BJUNICOM == "1")
    {
        if (ServiceList != "INTERNET" && ServiceList != "OTHER")
        {
            return;
        }
    }
    else
    {
        if (ServiceList != "INTERNET")
        {
            return;
        }
    }

    setDisplay("IPv4DialModeRow", 1);

	if(GetCfgMode().BJUNICOM == "1")
	{
		document.getElementById("IPv4DialModeCol").title = Languages['IPv4DialModeDes'];
	}

    if (GetCurrentWan().IPv4DialMode.toString().toUpperCase() == "ONDEMAND")
    {
        setDisplay("IPv4DialIdleTimeRow", 1);
        setDisplay("IPv4IdleDisconnectModeRow",1);

        if(GetCurrentWan().IPv4NATEnable.toString().toUpperCase() != "1")
        {
           setDisplay("IPv4IdleDisconnectModeRow",0);
        }
        if(SetIdleDisconnectMode == "1")
        {
            setDisable("IPv4IdleDisconnectMode", 1);
            setSelect("IPv4IdleDisconnectMode", "DetectUpstream");
        }
		if ("1" == supportTelmex)
		{
			setDisplay("IPv4IdleDisconnectModeRow",0);
		}

    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv4DialModeRow", 0);
		setDisplay("IPv4DialIdleTimeRow", 0);
		setDisplay("IPv4IdleDisconnectModeRow", 0);
	}

	if(GetCurrentWan().IPv4DialMode.toString().toUpperCase() == "MANUAL" && GetCurrentWan().Enable == "1"
	&& EditFlag.toUpperCase() == "EDIT" && IPv4DialModetoManul() != true && GetCfgMode().BJUNICOM == "1")
	{
		var connectionFlag = GetCurrentWan().ConnectionControl;
		var disconnectionFlag = (connectionFlag == "0")?"1":"0";

		setDisable("IPv4DialConnectManual1",connectionFlag);
		setDisable("IPv4DialConnectManual2",disconnectionFlag);
		setText("IPv4DialConnectManual1",Languages['IPv4ManualConnect']);
		setText("IPv4DialConnectManual2",Languages['IPv4ManualDisonnect']);
		setDisplay("IPv4DialConnectManualRow", 1);

	}
}

function OnConnectionControlButtonCU(Control,CurWandomain,CtrFlag) {
  var Form = new webSubmitForm();
  Form.addParameter('x.X_HW_ConnectionControl',CtrFlag);
  Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
  Form.setAction('set.cgi?' +'x='+ CurWandomain + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html');
  Form.submit();
}

function OnConnectionButton(ControlObject)
{
	var Wan = GetCurrentWan();
	var ctrFlag = (ControlObject.id == "IPv4DialConnectManual1")?"1":"0";
	var connectionFlag = Wan.ConnectionControl;

	if(ctrFlag == connectionFlag)
	{
		return;
	}
	OnConnectionControlButtonCU(ControlObject,Wan.domain,ctrFlag);
}


function ControlMVlan(IPvx)
{
    var Wan = GetCurrentWan();
    setDisplay(IPvx+"WanMVlanIdRow", 1);

    if ( '0' == FeatureInfo.RouteWanMulticastIPoE && "IP_ROUTED" == Wan.Mode.toString().toUpperCase())
    {
        setDisplay(IPvx+"WanMVlanIdRow", 0);
        return;
    }
    if ('0' == FeatureInfo.BridgeWanMulticast && ("IP_BRIDGED" == Wan.Mode.toString().toUpperCase() || "PPPOE_BRIDGED" == Wan.Mode.toString().toUpperCase()))
    {
        setDisplay(IPvx+"WanMVlanIdRow", 0);
        return;
    }

	if((productName == 'HG8240') && ("IP_ROUTED" == Wan.Mode.toString().toUpperCase()))
	{
		setDisplay(IPvx+"WanMVlanIdRow", 0);
		return;
	}

    if ((Wan.ServiceList =="TR069") || (Wan.ServiceList == "VOIP")
         || (Wan.ServiceList =="TR069_VOIP"))
    {
        setDisplay(IPvx+"WanMVlanIdRow",0);
        return;
    }
    else
    {
        setDisplay(IPvx+"WanMVlanIdRow",1);
    }

	var WanProtocolType = GetCurrentWan().ProtocolType.toString();
	var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();
	if (WanProtocolType == "IPv6")
	{
		if((WanIPv6DSLite != "Off")
		&&('COMMON' != CfgModeWord.toUpperCase())
		&&('COMMON2' != CfgModeWord.toUpperCase())
		&&('AWASR' != CfgModeWord.toUpperCase())
		&&(GetCfgMode().OSK != "1"))
		{
			setDisplay(IPvx+"WanMVlanIdRow", 0);
			return;
		}
		else
		{
			setDisplay(IPvx+"WanMVlanIdRow",1);
		}
	}

	if (true == IsCurrentRadioWan())
	{
		setDisplay(IPvx+"WanMVlanIdRow", 0);
	}
	
	if (Is3TMode())
	{
		if (WanProtocolType == "IPv4/IPv6")
		{
			setDisplay("IPv4v6"+"WanMVlanIdRow",1);
			setDisplay("IPv4"+"WanMVlanIdRow",0);
			setDisplay("IPv6"+"WanMVlanIdRow",0);
		}
		else
		{
			setDisplay("IPv4v6"+"WanMVlanIdRow",0);
		}
	}
}

function BirdgetoRoute()
{
	var Wan = GetPageData();
	if (Wan.domain.length > 10 && Wan.Mode == "IP_Routed")
	{
		var i = 0;
		for (i = 0; i < GetWanList().length; i++)
		{
			if (GetWanList()[i].domain == Wan.domain)
			{
				break;
			}
		}

		if (GetWanList()[i].Mode.toUpperCase().indexOf("BRIDGE") >= 0)
		{
			return true;
		}
	}
	return false;
}

function ControlIPv4AddressType()
{
    var Wan = GetCurrentWan();

    setDisplay("IPv4AddressModeRow", 1);
    if (Wan.Mode.toString().toUpperCase() != "IP_ROUTED")
    {
        setDisplay("IPv4AddressModeRow", 0);
        return;
    }

    setDisable("IPv4AddressMode1", 1);
    setDisable("IPv4AddressMode2", 1);
    setDisable("IPv4AddressMode3", 1);

    if (Wan.EncapMode.toString().toUpperCase() == "IPOE")
    {
        setDisable("IPv4AddressMode1", 0);
        setDisable("IPv4AddressMode2", 0);

        if ((Wan.IPv4AddressMode.toString().toUpperCase() != "STATIC")
        && (Wan.IPv4AddressMode.toString().toUpperCase() != "DHCP"))
        {
            setCheck("IPv4AddressMode2", 1);
            Wan.IPv4AddressMode = "DHCP";
        }
		if((BirdgetoRoute() == true) && (Wan.IPv4AddressMode.toString().toUpperCase() == "STATIC"))
		{
			if(getElById("IPv4IPAddress").value == '0.0.0.0')
			{
				setText('IPv4IPAddress','');
			}
			if(getElById("IPv4SubnetMask").value == '0.0.0.0')
			{
				setText('IPv4SubnetMask','');
			}
			if(getElById("IPv4DefaultGateway").value == '0.0.0.0')
			{
				setText('IPv4DefaultGateway','');
			}
		}
    }

    else if (Wan.EncapMode.toString().toUpperCase() == "PPPOE")
    {
        setDisable("IPv4AddressMode3", 0);
        setCheck("IPv4AddressMode3", 1);
        Wan.IPv4AddressMode = "PPPoE";
    }
}

function DisplayUpport()
{
	if ((UpportDetectFlag == 1) || (CfgModeWord.toUpperCase() == 'DETHMAXIS') || (upLinkLanPort == 1)) {
		for(var i = 1; i <= parseInt(ethNum); i++)
		{
			if(UpUserPortID == i)
			{
				setDisplay("DivIPv4BindLanList"+i, 0);
			}
			else
			{
				setDisplay("DivIPv4BindLanList"+i, 1);
			}
		}
	}

    var  MainUpPort = PortConfigInfo.X_HW_MainUpPort;
    for(var i = 1; i <= parseInt(ethNum); i++) {
        if(MainUpPort.indexOf("LAN") >= 0 && parseInt(MainUpPort.substr(3)) == i) {
            setDisable("IPv4BindLanList"+i, 1);
            if ((IsSupportLanAsWan == 1) && (parseInt(MainUpPort.substr(3)) == 5)) {
                setDisplay("DivIPv4BindLanList"+i, 0);
            }
        }
    }
	
	if (APAutoUPPortFlag == 1)
	{
		for(var i = 1; i <= parseInt(ethNum); i++)
		{
			setDisplay("DivIPv4BindLanList"+i, 0);
		}
	}
}

function InitIPTVWANInfo()
{
	if (supportIPTVPort != 1)
	{
		return;
	}

	var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort,DB);%>'.toUpperCase();
	if (IPTVUpPortInfo == "")
	{
		return;
	}
	
	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
	var tempIPTVUpList = tempIPTVUpValue.split(".");
	var IPTVUpPortID = tempIPTVUpList[0].substr(3);
	setDisplay("DivIPv4BindLanList" + IPTVUpPortID, 0);
	return;
}
var supportOnuBind = "<%HW_WEB_GetFeatureSupport(FT_ONU_VLAN_WAN_CFG);%>";
var maxOnuNum = 32;
function ControlIPv4LanWanBind()
{
    var Wan = GetCurrentWan();
    var ISPPortList = Instance_IspWlan.GetISPPortList();

    if (FeatureInfo.LanSsidWanBind == "0")
    {
        setDisplay('IPv4BindLanListRow',0);
        setDisplay('Wan_Pon_checkboxRow',0);
        return;
    }

    var topoInfoEthNum = parseInt(TopoInfo.EthNum);
    for (var i = 1; i <= topoInfoEthNum; i++)
    {
        var shouldDisable = 1;
        if (CfgModeWord.toUpperCase() == 'DGRWIND') {
            shouldDisable = 0;
        } else {
            if (IsL3Mode(i) == "1") {
                shouldDisable = 0;
            }
        }
        setDisable("IPv4BindLanList" + i, shouldDisable);
		if ((notSupportPON == "1") && (i > 3)) {
            setDisplay("DivIPv4BindLanList"+i, 0);
        }
    }

    if ('JSCMCC' == CfgModeWord.toUpperCase() && curUserType == 0)
    {
         for (var i = 1; i <= parseInt(ethNum); i++)
         {
            if (IsL3Mode(i) == "1")
            {
                setDisable("IPv4BindLanList"+i, 0);
            }
        }
    }

    for (var i = parseInt(ethNum) + 1; i <= 8; i++)
    {
        setDisplay("DivIPv4BindLanList"+i, 0);
    }



	if (1 != DoubleFreqFlag)
	{
	    for (var i = parseInt(TopoInfo.SSIDNum)+9; i <= 16; i++)
    	{
        	setDisplay("DivIPv4BindLanList"+i, 0);
    	}
	}
	if(true == IsFreInSsidName())
	{
		for(var k = (LanNum+1); k <= (LanNum+SsidNum+1); k++)
		{
			setDisplay("DivIPv4BindLanList"+k, 0);
		}
		var SL = GetSSIDFreList();
		for(var i = 0; i < SL.length; i++)
        {
		    for(var j = 1; j < (LanNum+1); j++)
			{
				if(j == getWlanInstFromDomain(SL[i].domain))
			    {
					if(j <= (SsidNum/2))
					{
					   setDisplay("DivIPv4BindLanList"+(j+LanNum), 1);
					}
					else
					{
					   setDisplay("DivIPv4BindLanList"+(j+LanNum+1), 1);
					}
					break;
			    }
			}
        }
	}

	if(1 == DoubleFreqFlag)
	{
		for (var i = 0; i < WlanList.length; i++)
		{
			var tid = parseInt(i+LanNum+1);
			if((true == IsFreInSsidName() || true == IsSixteenSsidUser()) && (i >= (SsidNum/2)))
			{
			   tid = tid +1;
			}
			if (WlanList[i].bindenable == "0")
			{
				setDisable("IPv4BindLanList"+tid, 1);
			}
			if (WlanList[i].bindenable == "1" && 'JSCMCC' == CfgModeWord.toUpperCase() && curUserType == 0)
            {
                setDisable("IPv4BindLanList"+tid, 0);
            }

			for (var j = 0; j < WlanListTotal.length -1; j++)
			{
			    var WlanCapability = WlanListTotal[j].X_HW_RFBand;
			    var WlanSsid = WlanListTotal[j].ssid;
			    var WlanInst = WlanListTotal[j].WlanInst;
				if((true == IsFreInSsidName() || true == IsSixteenSsidUser()) && (WlanInst > (SsidNum/2)))
			    {
			       WlanInst = WlanInst +1;
			    }
			    if((WlanList[i].bindenable == "1")&&(enbl5G != 1))
			    {
                    if (-1 != WlanCapability.indexOf("5G"))
				    {
					    setDisable("IPv4BindLanList"+(WlanInst+8), 1);
				    }
				    if (-1 == WlanCapability.indexOf("5G") && 'JSCMCC' == CfgModeWord.toUpperCase() && curUserType == 0)
                    {
                        setDisable("IPv4BindLanList"+(WlanInst+8), 0);
                    }
			    }

			    if((WlanList[i].bindenable == "1")&&(enbl2G != 1))
			    {
				    if (-1 != WlanCapability.indexOf("2.4G"))
				    {
					    setDisable("IPv4BindLanList"+(WlanInst+8), 1);
				    }
				    if (-1 == WlanCapability.indexOf("2.4G") && 'JSCMCC' == CfgModeWord.toUpperCase() && curUserType == 0)
                    {
                        setDisable("IPv4BindLanList"+(WlanInst+8), 0);
                    }
				}
			}
		}
	}
	else
	{
		for (var i = 0; i < WlanList.length; i++)
		{
			var tid = parseInt(i+1+4+4);
			if (WlanList[i].bindenable == "0")
			{
				setDisable("IPv4BindLanList"+tid, 1);
			}
			else if (WlanList[i].bindenable == "1" && 'JSCMCC' == CfgModeWord.toUpperCase() && curUserType == 0)
			{
			    setDisable("IPv4BindLanList"+tid, 0);
			}
		}
	}

	if(ISPPortList.length > 0)
    {
        for (var i = 1; i <= parseInt(TopoInfo.SSIDNum); i++)
        {
            var pos = ArrayIndexOf(ISPPortList, 'SSID'+i);
            if(pos >= 0)
            {
                var DivID = i + 4 + 4;
				if ((IsFreInSsidName() || IsSixteenSsidUser()) && (i > (SsidNum/2))) {
			       DivID = DivID +1;
			    }
                if (Instance_IspWlan.GetISPWanOnlyRead() && ispSsidBindEnable != 1)
                {
                    setDisable("IPv4BindLanList"+DivID, 1);
                }
                else
                {
                    if (ispSsidBindEnable != 1) {
                        setDisplay("DivIPv4BindLanList"+DivID, 0);
                    }
                    if ('JSCMCC' == CfgModeWord.toUpperCase() && curUserType == 0)
                    {
                        setDisplay("DivIPv4BindLanList"+DivID, 1);
                        setDisable("IPv4BindLanList"+DivID, 1);
                    }
                }
            }
        }
    }
	for (var i = 1; i <= parseInt(TopoInfo.SSIDNum); i++)
    {
        if (true == IsRDSGatewayUserSsid(i))
        {
            var DivID = i + 4 + 4;
			if(((true == IsFreInSsidName()) || (DoubleFreqFlag == 1)) && (i > (SsidNum/2)))
			{
			    DivID = DivID +1;
			}
            setDisplay("DivIPv4BindLanList"+DivID, 0);
        }
    }

    setDisplay('IPv4BindLanListRow',0);
    setDisplay('Wan_Pon_checkboxRow',0);
    if ((IsSupportBridgeWan == 0) && (Wan.ServiceList.match("INTERNET")
     || Wan.ServiceList.match("OTHER")
	 || Wan.ServiceList.match("IPTV")))
	 {
        setDisplay('IPv4BindLanListRow',1);
        setDisplay('Wan_Pon_checkboxRow',1);
	 }

	if (true == IsCurrentRadioWan())
	{
        setDisplay('IPv4BindLanListRow',0);
        setDisplay('Wan_Pon_checkboxRow',0);
	}

    if (ponOnuBind == 0) {
        setDisplay('Wan_Pon_checkboxRow',0);
    }

    if (CfgModeWord.toUpperCase() == "SDCCENTER") {
        setDisplay("DivIPv4BindLanList2", 0);
    }
	DisplayUpport();
	InitIPTVWANInfo();
    if (supportOnuBind != 1) {
        setDisplay('DownPon_checkbox',0);
    } else if (Wan.Mode == "IP_Routed") {
		setDisplay('DownPon_checkbox',0);
	}
}


function ControlIPv6PrefixAcquireMode()
{
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    setDisplay("IPv6PrefixModeRow", 0);
    if (WanMode == "IP_ROUTED")
    {
        setDisplay("IPv6PrefixModeRow", 1);
    }

	 if (true == IsCurrentRadioWan())
	 {
		 setDisplay("IPv6PrefixModeRow", 0);
	 }
}


function Control6RDParametersDisplay(Wan)
{
    var servicetypeIsMatch = (-1 != Wan.ServiceList.indexOf("INTERNET")) || (-1 != Wan.ServiceList.indexOf("IPTV")) || (-1 != Wan.ServiceList.indexOf("OTHER"));

    setDisplay("RDModeRow", 0);
    setDisplay("RdPrefixRow", 0);
    setDisplay("RdPrefixLenRow", 0);
    setDisplay("RdBRIPv4AddressRow", 0);
    setDisplay("RdIPv4MaskLenRow", 0);

    if( (1 == Wan.IPv4Enable) && (0 == Wan.IPv6Enable) && (Wan.Mode.toString().toUpperCase() == "IP_ROUTED") &&
        (true == servicetypeIsMatch)&&(true == Is6RdSupported()) ){

		setDisplay("RDModeRow", 1);

		if ("STATIC" == Wan.RdMode.toString().toUpperCase())
		{
			setDisplay("RdPrefixRow", 1);
			setDisplay("RdPrefixLenRow", 1);
			setDisplay("RdBRIPv4AddressRow",1);
			setDisplay("RdIPv4MaskLenRow", 1);
		}

		setDisableByName("RDMode", 0);
		setDisable("RdPrefix", 0);
		setDisable("RdPrefixLen", 0);
		setDisable("RdBRIPv4Address", 0);
		setDisable("RdIPv4MaskLen", 0);
		for(var i = 0; i < GetWanList().length;i++)
		{
			if( GetWanList()[i].Enable6Rd != "0" && GetWanList()[i].domain != GetCurrentWan().domain)
			{
				setDisableByName("RDMode", 1);
				setDisable("RdPrefix", 1);
				setDisable("RdPrefixLen", 1);
				setDisable("RdBRIPv4Address", 1);
				setDisable("RdIPv4MaskLen", 1);
			}
		}

		if(Wan.IPv4AddressMode.toString().toUpperCase() != 'DHCP')
		{
			setDisable("RDMode2", 1);
		}
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("RDModeRow", 0);
		setDisplay("RdPrefixRow", 0);
		setDisplay("RdPrefixLenRow", 0);
		setDisplay("RdBRIPv4AddressRow", 0);
		setDisplay("RdIPv4MaskLenRow", 0);
	}
}

function ControlIPv6Prefix()
{
    var IPv6StaticPrefix = GetCurrentWan().IPv6PrefixMode.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    setDisplay("IPv6StaticPrefixRow", 0);
    if (IPv6StaticPrefix == "STATIC" && WanMode == "IP_ROUTED")
    {
        setDisplay("IPv6StaticPrefixRow", 1);
    }
}


function ControlIPv6AddressAcquireMode()
{
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    setDisplay("IPv6AddressModeRow", 0);
    setDisplay("TDEIPv6UnnumberedModelRow", 0);
    setDisplay("TDEDHCP6cForAddressRow", 0);
    setDisplay("TDEIPv6AddressingTypeRow", 0);

    if (WanMode == "IP_ROUTED")
    {
        if (1 == TDE2ModeFlag)
        {
            setDisplay("TDEIPv6UnnumberedModelRow", 1);
            setDisplay("TDEDHCP6cForAddressRow", 1);
            setDisplay("TDEIPv6AddressingTypeRow", 1);
        }
        else
        {
            setDisplay("IPv6AddressModeRow", 1);
        }
    }
}


function ControlIPv6ReservedPrefixAddress()
{
	var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
	var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

	setDisplay("IPv6ReserveAddressRow", 0);

    if(!isE8cAndCMCC())
	{
		if ((CurrentWan.EncapMode.toString().toUpperCase() == "IPOE") && (IPv6AddressType.toUpperCase() == "NONE") && (WanMode == "IP_ROUTED"))
		{
			setDisplay("IPv6ReserveAddressRow", 1);
		}
	}

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv6ReserveAddressRow", 0);
	}
}

function ControlIPv6StaticIPAddress()
{
    var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    setDisplay("IPv6IPAddressRow", 0);
    setDisplay("IPv6AddrMaskLenE8cRow", 0);
    setDisplay("IPv6GatewayE8cRow", 0);
    setDisplay("IPv6SubnetMaskRow", 0);
    setDisplay("IPv6DefaultGatewayRow", 0);
    setDisplay("IPv6PrimaryDNSServerRow", 0);
    setDisplay("IPv6SecondaryDNSServerRow", 0);

    if (IPv6AddressType == "STATIC" && WanMode == "IP_ROUTED")
    {
        setDisplay("IPv6IPAddressRow", 1);
        setDisplay("IPv6AddrMaskLenE8cRow", 1);
        setDisplay("IPv6GatewayE8cRow", 1);
        setDisplay("IPv6SubnetMaskRow", 1);
        setDisplay("IPv6DefaultGatewayRow", 1);
        setDisplay("IPv6PrimaryDNSServerRow", 1);
        setDisplay("IPv6SecondaryDNSServerRow", 1);
		if(IsPTVDFFlag == "1")
		{
			var OverrideAllowed = getCheckVal('IPV6OverrideAllowed');
			setDisplay("IPv6PrimaryDNSServerRow", 1);
			setDisplay("IPv6SecondaryDNSServerRow", 1);
			if (OverrideAllowed == 0)
            {
				setDisable("IPv6PrimaryDNSServer",1);
				setDisable("IPv6SecondaryDNSServer",1);
				
				document.getElementById("IPV6sourcemode1").checked =true;
				document.getElementById("IPV6sourcemode2").checked =false;

				setText("IPv6PrimaryDNSServer","");
				setText("IPv6SecondaryDNSServer","");
			}
		}	
    }
    if(IsPTVDFFlag == "1")
	{			
		if ( IPv6AddressType == "DHCPV6" && WanMode == "IP_ROUTED" || IPv6AddressType == "AUTOCONFIGURED" && WanMode == "IP_ROUTED" || IPv6AddressType == "NONE" && WanMode == "IP_ROUTED")
		{
		    var OverrideAllowed = getCheckVal('IPV6OverrideAllowed');
			setDisplay("IPv6PrimaryDNSServerRow", 1);
			setDisplay("IPv6SecondaryDNSServerRow", 1);
			if (0 == OverrideAllowed)
            {
				setDisable("IPv6PrimaryDNSServer",1);
				setDisable("IPv6SecondaryDNSServer",1);

				document.getElementById("IPV6sourcemode1").checked =true;
				document.getElementById("IPV6sourcemode2").checked =false;

				setText("IPv6PrimaryDNSServer","");
				setText("IPv6SecondaryDNSServer","");	
			}
		}
	}
	

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv6IPAddressRow", 0);
		setDisplay("IPv6AddrMaskLenE8cRow", 0);
		setDisplay("IPv6GatewayE8cRow", 0);
		setDisplay("IPv6SubnetMaskRow", 0);
		setDisplay("IPv6DefaultGatewayRow", 0);
		setDisplay("IPv6PrimaryDNSServerRow", 0);
		setDisplay("IPv6SecondaryDNSServerRow", 0);
	}

}

function ControlIPv6IPAddressStuff()
{
    setDisplay("IPv6AddressStuffRow", "0");
    var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
    var ProtocolType = GetCurrentWan().ProtocolType.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    if (ProtocolType == "IPV4")
    {
        return;
    }

    if (IPv6AddressType != "AUTOCONFIGURED")
    {
        return;
    }

    if (WanMode != "IP_ROUTED")
    {
        return;
    }
    setDisplay("IPv6AddressStuffRow", "1");

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv6AddressStuffRow", "0");
	}
}

function setDisableByName(Name, Disable)
{
    var List = document.getElementsByName(Name);
    for (var i = 0; i < List.length; i++)
    {
        setDisable(List[i].id, Disable);
    }
}

function ControlEditMode()
{
    var Disable = 0;
    var Wan = GetPageData();

    setDisableByName("EncapMode", EditFlag.toUpperCase() == "ADD" ? 0 : 1);

    if (!((SonetFlag == '1') && curUserType == '0'))
	{
		setDisable("ProtocolType", EditFlag.toUpperCase() == "ADD" ? 0 : 1);
	}
	if (Tdefeature == 1)
	{
	    setDisable("ProtocolType", 0);
	}

    setDisable("WanMode", 0);
    if((Disable) && (bin3board() == true))
    {
        setDisable("WanMode", 1);
	}
	
	if ((CfgModeWord.toUpperCase() == 'JLCU' || CfgModeWord.toUpperCase() == 'JLCUHG8321R')
		&& (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0)) {
		setDisable("WanMode", 1);
	}
	
    setDisable("IPv4MXU", 0);
    setDisable("ServiceList", EditFlag.toUpperCase() == "ADD" ? 0 : 1);

	if("TELMEXACCESS" == CfgModeWord.toUpperCase() || "TELMEXACCESSNV" == CfgModeWord.toUpperCase() || "TELMEXRESALE" == CfgModeWord.toUpperCase())
	{

		if(Wan.Mode.toUpperCase().toUpperCase().indexOf("ROUTED") >= 0)
		{
			setDisable("ServiceList", 1);
		}
		else
		{
			setDisable("ServiceList", 0);
		}
		setDisable("ProtocolType", 1);
	}

	if ((CfgModeWord.toUpperCase() == "TELMEXVULA") || (cntFlag == 1)) {
		setDisable("ServiceList", 0);
		setDisable("ProtocolType", 0);
	}

    if (("1" == RadioWanFeature) && (!IsXdProduct()))
	{
		if (((EditFlag.toUpperCase() == "ADD") && (AddType == 1)) || isSupportAboard)
		{
			setDisable("AccessType",0);
		}
		else
		{
			setDisable("AccessType",1);
		}
	}
    setDisableByName("IPv4AddressMode", Disable);
    setDisableByName("IPv6PrefixMode", Disable);

    if (1 == TDE2ModeFlag)
    {
        setDisable("TDEIPv6AddressingType", Disable);
        setDisable("TDEIPv6UnnumberedModel", Disable);
        setDisable("TDEDHCP6cForAddress", Disable);
    }
    else
    {
        setDisableByName("IPv6AddressMode", Disable);
    }

    setDisable("IPv6IPAddress", Disable);
    setDisable("IPv6AddrMaskLenE8c", Disable);
    setDisable("IPv6GatewayE8c", Disable);
	setDisable("IPv6ReserveAddress", Disable);
    setDisable("IPv6StaticPrefix", Disable);
    setDisable("IPv6AddressStuff", Disable);
    if (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() != "PPPOE")
	{
		setDisable("IPv4AddressMode3", 1);
	}
	else
	{
		setDisable("IPv4AddressMode1", 1);
		setDisable("IPv4AddressMode2", 1);
	}

	if (AddType == 2 && EditFlag.toUpperCase() == "ADD")
	{
	        var SessionVlanLimit  = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULT_SESSION_VLAN_LIMIT);%>";
	        if (SessionVlanLimit == 1)
	        {
		    	setDisable('VlanSwitch', 1);
	            setDisable('VlanId', 1);
		    	setDisable('PriorityPolicy', 1);
                setDisable('VlanPriority', 1);
		    	setDisable('DefaultVlanPriority', 1);
		}

	}

	if (Wan.domain.length > 10 && Wan.Mode == "IP_Routed")
	{
		var i = 0;
		for (i = 0; i < GetWanList().length; i++)
		{
			if (GetWanList()[i].domain == Wan.domain)
			{
				break;
			}
		}
		var IPv6StaticPrefix = GetCurrentWan().IPv6PrefixMode.toString().toUpperCase();
        var IPv6StaticAdress = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
		if (GetWanList()[i].Mode.toUpperCase().indexOf("BRIDGE") >= 0 )
		{
			setDisableByName("IPv6PrefixMode", 0);

			if (IPv6StaticPrefix == "STATIC")
			{
				setDisable("IPv6StaticPrefix", 0);
			}

			setDisableByName("IPv6AddressMode",0);
			setDisable("TDEIPv6AddressingType",0);
			setDisable("TDEIPv6UnnumberedModel",0);
			setDisable("TDEDHCP6cForAddress",0);

			if (IPv6StaticAdress == "STATIC")
			{
				setDisable("IPv6IPAddress", 0);
				setDisable("IPv6AddrMaskLenE8c", 0);
                setDisable("IPv6GatewayE8c", 0);
			}

			if (IPv6StaticAdress == "AUTOCONFIGURED")
			{
				setDisable("IPv6AddressStuff", 0);
			}
		}
	}

    if (((CfgModeWord.toUpperCase() == "TTNET2") || (CfgModeWord.toUpperCase() == "DINFOTEK2")) && (curUserType == sysUserType)) {
        setDisable("ProtocolType", 0);
    }

    if ((CfgModeWord.toUpperCase() == "BELTELECOM2") && 
		((Wan.ServiceList.toUpperCase() == "TR069") || (Wan.ServiceList.toUpperCase() == "VOIP"))) {
        setDisable("WanMode", 1);
        setDisable("IPv4MXU", 1);
        setDisable("IPv4AddressMode1", 1);
        setDisable("IPv4AddressMode2", 1);
        setDisable("IPv4AddressMode3", 1);
    }
}

function DisableUserMode(Disable)
{
    setDisable("WanSwitch", Disable);
    setDisableByName("EncapMode", Disable);
    setDisable("ProtocolType", Disable);
    setDisable("WanMode", Disable);
    setDisable("IPv4MXU", Disable);
    setDisable("ServiceList", Disable);
    setDisable("VlanSwitch", Disable);
    setDisable("VlanId", Disable);
    setDisable("VlanPriority", Disable);
    setDisable("PriorityPolicy", Disable);
    setDisableByName("IPv4AddressMode", Disable);
    setDisable("IPv4MXU", Disable);
    setDisable("IPv4NatSwitch", Disable);
	if(false == IsSonetUser())
	{
    	setDisable("IPv4NatType", Disable);
	}
    setDisable("LanDhcpSwitch", Disable);
	
	setDisable("IPv4v6WanMVlanId", Disable);
	
    setDisable("IPv4VendorId", Disable);
    setDisable("IPv4ClientId", Disable);
    setDisable("IPv4IPAddress", Disable);
    setDisable("IPv4SubnetMask", Disable);
    setDisable("IPv4DefaultGateway", Disable);
    setDisable("IPv4DNSOverrideSwitch", Disable);
    setDisable("IPv4PrimaryDNSServer", Disable);
    setDisable("IPv4SecondaryDNSServer", Disable);
    setDisable("LcpEchoReqCheck", Disable);
    setDisable("IPv4DialMode", Disable);
    setDisable("IPv4DialIdleTime", Disable);
    setDisable("IPv4IdleDisconnectMode", Disable);
    setDisable("IPv4WanMVlanId", Disable);
    setDisableByName("IPv4BindLanList", Disable);
    setDisableByName("IPv6PrefixMode", Disable);
    setDisableByName("IPv6DSLite", Disable);
    setDisable("IPv6AFTRName", Disable);
    setDisable("IPv6StaticPrefix", Disable);
    setDisableByName("IPv6AddressMode", Disable);
    setDisable("TDEIPv6AddressingType", Disable);
    setDisable("TDEIPv6UnnumberedModel", Disable);
    setDisable("TDEDHCP6cForAddress", Disable);
    setDisable("IPv6AddressStuff", Disable);
    setDisable("IPv6IPAddress", Disable);
    setDisable("IPv6AddrMaskLenE8c", Disable);
    setDisable("IPv6GatewayE8c", Disable);
    setDisable("IPv6ReserveAddress", Disable);
    setDisable("IPv6SubnetMask", Disable);
    setDisable("IPv6DefaultGateway", Disable);
    setDisable("IPv6PrimaryDNSServer", Disable);
    setDisable("IPv6SecondaryDNSServer", Disable);
    setDisable("IPv6WanMVlanId", Disable);
    setDisable("PriorityPolicy", Disable);
    setDisable("DefaultVlanPriority", Disable);
	setDisableByName("RDMode", Disable);
	setDisable("RdPrefix", Disable);
	setDisable("RdPrefixLen", Disable);
	setDisable("RdBRIPv4Address", Disable);
	setDisable("RdIPv4MaskLen", Disable);
	setDisable("IPv4EnableMulticast", Disable);
    if (("1" == RadioWanFeature) && (!IsXdProduct()))
	{
		setDisable("AccessType", Disable);
	}
	if (GetCfgMode().TRUE == "1")
	{
		setDisable("WanMode", 0);
	}
	if (CfgModeWord.toUpperCase() == "UFB2") {
		setDisable("UserName", Disable);
		setDisable("Password", Disable);
		setDisable("IPv6NPTSwitch", Disable);
		setDisable("ButtonApply", Disable);
		setDisable("ButtonCancel", Disable);
	}

	if (CfgModeWord.toUpperCase() == "BELTELECOM2") {
		setDisable("EncapMode", Disable);
		setDisable("Password", Disable);
		setDisable("IPv6NPTSwitch", Disable);
		setDisable("ButtonApply", Disable);
		setDisable("ButtonCancel", Disable);
	}
}

function ControlUserMode(wan)
{
	var Disable = '';
	if (((IsAdminUser() == true) && (CfgModeWord.toUpperCase() != "BELTELECOM2")) || (CfgModeWord.toUpperCase() == 'POLNETIA')) {
		Disable = 0;
	}
	else
	{
		if ((IsLanUpCanOper() == true) || (tedataGuide == 1) || (oteFlag == "1") || (IsEnWebUserModifyWan() == true))
		{
			Disable = 0;
		}
		else
		{
			Disable = 1;
		}

		if (CfgModeWord.toUpperCase() == "BELTELECOM2" && (!((wan.ServiceList.toUpperCase() == "VOIP") || (wan.ServiceList.toUpperCase() == "TR069")))) {
			Disable = 0;
		}
	}

	DisableUserMode(Disable);
}


function ControlPageByEditModeAndUser()
{
    var Wan = GetCurrentWan();
    if ('JSCMCC' == CfgModeWord.toUpperCase() && Wan.VlanId == 4031 && Wan.ServiceList == 'OTHER' && Wan.EncapMode == 'PPPoE' && Instance_IspWlan.IsWanHidden(domainTowanname(Wan.domain)) == true)
    {
		DisableUserMode(0);
    }
    if (IsAdminUser() || (CfgModeWord.toUpperCase() == "BELTELECOM2" && (!((Wan.ServiceList.toUpperCase() == "VOIP") || (Wan.ServiceList.toUpperCase() == "TR069")))))
    {
		if ('JSCMCC' == CfgModeWord.toUpperCase() && Wan.VlanId == 4031 && Wan.ServiceList == 'OTHER' && Wan.EncapMode == 'PPPoE' && Instance_IspWlan.IsWanHidden(domainTowanname(Wan.domain)) == true)
		{
		     DisableUserMode(1);
			 setDisable("ButtonApply", 1);
		     setDisable("ButtonCancel", 1);
		}
		else if(Instance_IspWlan.IsOnlyReadWan(Wan) && ispSsidBindEnable != 1)
		{
			DisableUserMode(1);
		    setDisable("ButtonApply", 1);
		    setDisable("ButtonCancel", 1);
		}
		else
		{
            if ((CfgModeWord.toUpperCase() == "BELTELECOM2") && 
				((Wan.ServiceList.toUpperCase() == "VOIP") || (Wan.ServiceList.toUpperCase() == "TR069")) && (EditFlag != "ADD")) {
				ControlUserMode(Wan);
            }
            ControlEditMode();
		}
    }
    else
    {
		if ((isBiznetForUser == "1") && (Wan.domain.toUpperCase().indexOf("8") >= 0)) {
            setDisable("WanMode",1);
            setDisable("ButtonApply",1);
            setDisable("UserName",1);
            setDisable("Password",1);
        }

		if ((IsLanUpCanOper() == true) || (tedataGuide == 1) || (oteFlag == "1") || (IsEnWebUserModifyWan() == true))
		{
			ControlEditMode();
		}
		else
		{
			ControlUserMode(Wan);
		}

		if(Instance_IspWlan.IsOnlyReadWan(Wan))
		{
			DisableUserMode(1);
			setDisable("ButtonApply", 1);
			setDisable("ButtonCancel", 1);
		}
	}

    if (((CfgModeWord.toUpperCase() == "ARCLARO") || (CfgModeWord.toUpperCase() == "UYCLARO")) && (Wan.ServiceList.toUpperCase().indexOf("TR069") >= 0) &&
        (EditFlag != "ADD")) {
        DisableUserMode(1);
        setDisable("ButtonApply", 1);
        setDisable("ButtonCancel", 1);
    }
}

function E8CCheckDisable(Wan)
{
	setDisable('WanSwitch', 0);
	setDisable('VlanSwitch', 0);
	setDisable('VlanId', 0);
	setDisable('VlanPriority', 0);
	setDisable("PriorityPolicy", 0);
	setDisable('IPv4VendorId', 0);
	setDisable('IPv4ClientId', 0);
	setDisable('IPv4NatSwitch',0);
    setDisable('IPv4NatType',0);
	setDisable('IPv4WanMVlanId',0);
	setDisable('Option60Enable', 0);
	setDisable('IPoEUserName', 0);
	setDisable('IPoEPassword', 0);

	if(!isReadModeForTR069Wan())
	{
		return;
	}

	setDisable("IPv4BindLanListCol", 0);
    setDisable("Wan_Pon_checkboxRow", 0);
    if ((Wan.ServiceList.indexOf("TR069") >= 0) && (Wan.ServiceList.indexOf("INTERNET") < 0))
	{
        setDisable("IPv4BindLanListCol", 1);
        setDisable("Wan_Pon_checkboxRow", 1);
	}

    if (EditFlag.toUpperCase() == "ADD")
	{
		return;
	}
	else
	{
		if(!IsOriginalTr069Type())
		{
			return;
		}
	}

	if ((Wan.ServiceList == "TR069") || (Wan.ServiceList == "TR069_VOIP"))
	{
		setDisable('WanSwitch', 1);
		setDisable('VlanSwitch', 1);
		setDisable('VlanId', 1);
		setDisable('VlanPriority', 1);
		setDisable("PriorityPolicy", 1);
		setDisable('IPv4VendorId', 1);
		setDisable('IPv4ClientId', 1);
		setDisable('IPv4NatSwitch',1);
		setDisable('IPv4NatType',1);
		return;
	}

	if ((Wan.ServiceList == "TR069_INTERNET") || (Wan.ServiceList == "TR069_VOIP_INTERNET"))
	{
		setDisable('WanSwitch', 1);
		setDisable('VlanSwitch', 1);
		setDisable('VlanId', 1);
		setDisable('VlanPriority', 1);
		setDisable("PriorityPolicy", 1);
		setDisable('IPv4VendorId', 1);
		setDisable('IPv4ClientId', 1);
		setDisable('IPv4NatSwitch',1);
        setDisable('IPv4NatType',1);
		setDisable('IPv4WanMVlanId',1);
		return;
	}
}

function E8Ctr069CheckDisable(Wan)
{
	if(!isReadModeForTR069Wan())
	{
		return;
	}

    if (EditFlag.toUpperCase() == "ADD")
	{
		return;
	}
	else
	{
		if(!IsOriginalTr069Type())
		{
			return;
		}
	}

	if ((Wan.ServiceList == "TR069") || (Wan.ServiceList == "TR069_VOIP") || (Wan.ServiceList == "TR069_INTERNET") || (Wan.ServiceList == "TR069_VOIP_INTERNET"))
	{
		setDisable("WanMode", 1);
		setDisable("IPv4MXU", 1);
        setDisable("ProtocolType", 1);
        setDisable("ServiceList", 1);
        setDisableByName("IPv4AddressMode", 1);
		setDisable("UserName", 1);
        setDisable("Password", 1);
		return;
	}
}

function ControlIPv6DSLite()
{
	var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    setDisplay("IPv6DSLiteRow", 0);

	if((GetFeatureInfo().Dslite == "0") || (1 == GetCurrentWan().IPv4Enable))
    {
        return;
    }
	if (WanMode != "IP_ROUTED")
    {
        return;
    }
	setDisplay("IPv6DSLiteRow", 1);
	if (true == IsCurrentRadioWan())
	{
		 setDisplay("IPv6DSLiteRow", 0);
	}

	setDisableByName("IPv6DSLite", 0);
	for(var i = 0; i < GetWanList().length;i++)
	{
	    if( GetWanList()[i].IPv6DSLite.toString() != "Off" && GetWanList()[i].domain != GetCurrentWan().domain)
		{
		    setDisableByName("IPv6DSLite", 1);
		}
	}
}

function ControlIPv6AFTRName()
{
	var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
	var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();

    setDisplay("IPv6AFTRNameRow", 0);
    if((GetFeatureInfo().Dslite == "0") || (1 == GetCurrentWan().IPv4Enable))
    {
        return;
    }
	if (WanMode != "IP_ROUTED")
    {
        return;
    }
	setDisplay("IPv6AFTRNameRow", 1);

	if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv6AFTRNameRow", 0);
	}

	setDisable("IPv6AFTRName", 0);
	if(WanIPv6DSLite != "Static")
	{
	    setDisable("IPv6AFTRName", 1);
		setText("IPv6AFTRName","");
	}

}


function ControlPriority()
{
    var PriorityPolicy = GetCurrentWan().PriorityPolicy.toString();
    setDisplay("DefaultVlanPriorityRow", 0);
    setDisplay("VlanPriorityRow", 0);

    if (GetCurrentWan().EnableVlan.toString().toUpperCase() == "1")
    {
        setDisplay("PriorityPolicyRow", 1);
        setDisplay("PriorityPolicyspan",0);

        if (PriorityPolicy.toUpperCase() == "SPECIFIED" )
        {
            setDisplay("VlanPriorityRow", 1);
        }
        else if (PriorityPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE" )
        {
            setDisplay("DefaultVlanPriorityRow", 1);
        }
        else if (PriorityPolicy.toUpperCase() == "DSCPTOPBIT" )
        {
            setDisplay("DefaultVlanPriorityRow", 1);
            setDisplay("PriorityPolicyspan",1);
        }
    }
    else
    {
        setDisplay("PriorityPolicyRow", 0);
    }

	if (true == IsCurrentRadioWan())
	{
		setDisplay("DefaultVlanPriorityRow", 0);
		setDisplay("VlanPriorityRow", 0);
		setDisplay("PriorityPolicyRow", 0);
	}
}

function ControlErrorWANCfg(Wan)
{
	if((Wan.IPv4Enable == 1) || (Wan.IPv6Enable == 1))
	{
		return ;
	}
	var Disable = 1;
	DisableUserMode(Disable);
	setDisable("UserName",Disable);
	setDisable("Password",Disable);
	setDisable("IPv6AFTRName",Disable);
	setDisable("ButtonApply",Disable);
	setDisable("ButtonCancel",Disable);
}

function ControlInfoRds()
{
	setDisplay("EncapModeRow", 0);
	setDisplay("ProtocolTypeRow", 0);
	setDisplay("WanModeRow", 0);
	setDisplay("ServiceListRow", 0);
	setDisplay("VlanSwitchRow", 0);
	setDisplay("VlanIdRow", 0);
	setDisplay("PriorityPolicyRow", 0);
	setDisplay("DefaultVlanPriorityRow", 0);
	setDisplay("VlanPriorityRow", 0);
	setDisplay("LcpEchoReqCheckRow", 0);
}

function ControlSonet()
{
	setDisplay("WanModeRow", 0);
	setDisplay("VlanSwitchRow", 0);
	setDisplay("VlanIdRow", 0);
	setDisplay("PriorityPolicyRow", 0);
	setDisplay("DefaultVlanPriorityRow", 0);
	setDisplay("VlanPriorityRow", 0);
	setDisplay("IPv4BindLanListRow", 0);

	setDisplay("IPv4VendorIdRow", 0);
	setDisplay("IPv4ClientIdRow", 0);
	setDisplay("IPv4WanMVlanIdRow", 0);

	setDisplay("IPv6WanMVlanIdRow", 0);
}
function RdsAPNormalWanControl()
{
    setDisplay("WanIPv6InfoBarPanel", 0);
    $("#BasicInfoBarPanel>tr:gt(0)").hide();
    $("#WanIPv4InfoBarPanel>tr:gt(0)").hide();
    $("#WanIPv6InfoBarPanel>tr:gt(0)").hide();
    setDisplay("WanSwitchRow", 1);
    setDisable("WanSwitch", 0);
    setDisplay("IPv4PrimaryDNSServerRow", 1);
    setDisplay("IPv4SecondaryDNSServerRow", 1);
    setDisable("IPv4PrimaryDNSServer", 0);
    setDisable("IPv4SecondaryDNSServer", 0);

    if (GetCurrentWan().ProtocolType.toString() == "IPv6") {
        setDisplay("WanIPv4InfoBarPanel", 0);
    }

    if (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "STATIC") {
        setDisplay("WanIPv4InfoBarPanel", 1);
        setDisplay("IPv4IPAddressRow", 1);
        setDisplay("IPv4SubnetMaskRow", 1);
        setDisplay("IPv4DefaultGatewayRow", 1);
        setDisable("IPv4IPAddress",0);
        setDisable("IPv4SubnetMask",0);
        setDisable("IPv4DefaultGateway",0);
    }

    if (GetCurrentWan().IPv6PrefixMode.toString().toUpperCase() == "STATIC") {
        setDisplay("WanIPv6InfoBarPanel", 1);
        setDisplay("IPv6StaticPrefixRow", 1);
        setDisable("IPv6StaticPrefix", 0);
    }

    if (GetCurrentWan().IPv6AddressMode.toString().toUpperCase() == "STATIC") {
        setDisplay("WanIPv6InfoBarPanel", 1);
        setDisplay("IPv6IPAddressRow", 1);
        setDisable("IPv6IPAddress", 0);
        setDisplay("IPv6GatewayE8cRow", 1);
        setDisplay("IPv6PrimaryDNSServerRow", 1);
        setDisplay("IPv6SecondaryDNSServerRow", 1);
        setDisable("IPv6GatewayE8c", 0);
        setDisable("IPv6PrimaryDNSServer", 0);
        setDisable("IPv6SecondaryDNSServer", 0);
    }

    if ((GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE") && (GetCurrentWan().Mode == "IP_Routed")) {
        setDisplay("WanIPv4InfoBarRow", 0);
        setDisplay("IPv4PrimaryDNSServerRow", 0);
        setDisplay("IPv4SecondaryDNSServerRow",0);
        setDisplay("UserNameRow", 1);
        setDisplay("PasswordRow", 1);
    }

    setDisable("ButtonApply", 0);
    setDisable("ButtonCancel", 0);
}

function RdsAPNormalWanIPOEControl()
{
    $("#BasicInfoBarPanel>tr:gt(0)").hide();
    $("#WanIPv4InfoBarPanel>tr:gt(0)").hide();
    setDisplay("WanSwitchRow", 1);
    setDisable("WanSwitch", 0);
    setDisplay("IPv4PrimaryDNSServerRow", 1);
    setDisplay("IPv4SecondaryDNSServerRow", 1);
    setDisable("IPv4PrimaryDNSServer", 0);
    setDisable("IPv4SecondaryDNSServer", 0);

    if (GetCurrentWan().ProtocolType.toString() == "IPv6") {
        setDisplay("WanIPv4InfoBarPanel", 0);
        setDisplay("WanIPv4InfoBarPanel", 1);
        setDisplay("IPv4IPAddressRow", 1);
        setDisplay("IPv4SubnetMaskRow", 1);
        setDisplay("IPv4DefaultGatewayRow", 1);
        setDisable("IPv4IPAddress",0);
        setDisable("IPv4SubnetMask",0);
        setDisable("IPv4DefaultGateway",0);
    }

    if (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "STATIC") {
        setDisplay("WanIPv4InfoBarPanel", 1);
        setDisplay("IPv4IPAddressRow", 1);
        setDisplay("IPv4SubnetMaskRow", 1);
        setDisplay("IPv4DefaultGatewayRow", 1);
        setDisable("IPv4IPAddress",0);
        setDisable("IPv4SubnetMask",0);
        setDisable("IPv4DefaultGateway",0);
    }

    setDisable("ButtonApply", 0);
    setDisable("ButtonCancel", 0);
}
function ControlAntel()
{
    if((true == IsAdminUser()) || ((true == IsLanUpCanOper()) && (CfgModeWord.toUpperCase() != 'TURKCELL2')) || ((CfgModeWord.toUpperCase() == 'RDSAP') && (!IsAdminUser())))
    {
        return;
    }

    if ((CfgModeWord.toUpperCase() == 'ANTEL'|| CfgModeWord.toUpperCase() == 'ANTEL2'|| "1" == "<%HW_WEB_GetFeatureSupport(FT_NORMAL_ONLY_SHOW_PPPOE_INFO);%>")
        && GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE"
        && GetCurrentWan().Mode == "IP_Routed")
    {
        setDisplay("WanIPv4InfoBarPanel", 0);
        setDisplay("WanIPv6InfoBarPanel", 0);

        $("#BasicInfoBarPanel>tr:gt(0)").hide();

        if (WANMODEChange != 1)
        {
            $("#UserNameRow").show();
            $("#PasswordRow").show();
        }

        if (CfgModeWord.toUpperCase() == 'BHARTI')
        {
            $("#PPPAuthenticationProtocolRow").show();
        }
        if (CfgModeWord.toUpperCase() == 'AISAP') {
            setDisable("UserName", 1);
            setDisable("Password", 1);
            setDisable("ButtonApply", 1);
        }
        if (isSuportPolnetia == "1") {
            setDisplay("WanIPv4InfoBarPanel", 1);
        }
    }

    if (CfgModeWord.toUpperCase() == 'POLNETIA') {
        setDisplay("WanIPv6InfoBarPanel", 0);
        $("#BasicInfoBarPanel>tr:gt(0)").hide();
        $("#WanIPv4InfoBarPanel>tr:gt(0)").hide();
        $("#WanIPv6InfoBarPanel>tr:gt(0)").hide();
        setDisplay("WanModeRow", 1);
        setDisable("WanMode", 0);
        setDisplay("IPv4DNSOverrideSwitchRow", 1);
        setDisplay("IPv4PrimaryDNSServerRow", 1);
        setDisplay("IPv4SecondaryDNSServerRow", 1);
        if (GetCurrentWan().ProtocolType.toString() == "IPv6") {
            setDisplay("WanIPv4InfoBarPanel", 0);
        }

        if (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "STATIC") {
            setDisplay("WanIPv4InfoBarPanel", 1);
            setDisplay("IPv4IPAddressRow", 1);
            setDisplay("IPv4SubnetMaskRow", 1);
            setDisable("IPv4IPAddress",0);
            setDisable("IPv4SubnetMask",0);
        }

        if (GetCurrentWan().IPv6PrefixMode.toString().toUpperCase() == "STATIC") {
            setDisplay("WanIPv6InfoBarPanel", 1);
            setDisplay("IPv6StaticPrefixRow", 1);
            setDisable("IPv6StaticPrefix", 0);
        }

        if (GetCurrentWan().IPv6AddressMode.toString().toUpperCase() == "STATIC") {
            setDisplay("WanIPv6InfoBarPanel", 1);
            setDisplay("IPv6IPAddressRow", 1);
            setDisable("IPv6IPAddress", 0);
        }

        if ((GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE") && (GetCurrentWan().Mode == "IP_Routed")) {
            setDisplay("UserNameRow", 1);
            setDisplay("PasswordRow", 1);
        }
        if ((GetCurrentWan().Mode == "IP_Bridged") || (GetCurrentWan().Mode) == "PPPoE_Bridged") {
            setDisplay("WanIPv4InfoBarPanel", 0);
            setDisplay("WanIPv6InfoBarPanel", 0);
        }
        setDisable("ButtonApply", 0);
        setDisable("ButtonCancel", 0);
    }

    if ((CfgModeWord.toUpperCase() == "DICELANDVDF") && (GetCurrentWan().ServiceList == "IPTV")) {
        setDisplay("WanIPv4InfoBarPanel", 0);
        setDisplay("WanIPv6InfoBarPanel", 0);
        $("#BasicInfoBarPanel>tr:gt(0)").hide();
        setDisplay("IPv4BindLanListRow", 1);
        setDisable("ButtonApply", 0);
        setDisable("ButtonCancel", 0);
        
        var i = LanNum + 1;
        var total = LanNum + SsidNum;
        for (i; i <= total; i++) {
            setDisable("IPv4BindLanList" + i, 0);
        }

        ControlIPv4LanWanBind();
    }

    ControlWanMode();
}

function ControlTrue()
{        
    if((true == IsAdminUser()) || (true == IsLanUpCanOper()))
    {
        return;
    }

    if ((GetCfgMode().TRUE == "1" || "1" == "<%HW_WEB_GetFeatureSupport(FT_NORMAL_ONLY_SHOW_PPPOE_INFO);%>")
        && GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE")
    {
        setDisplay("WanIPv4InfoBarPanel", 0);
        setDisplay("WanIPv6InfoBarPanel", 0);
        
        $("#BasicInfoBarPanel>tr:gt(0)").hide();
        $("#WanModeRow").show();
        if (GetCurrentWan().Mode == "IP_Routed")
        {
            $("#UserNameRow").show();
            $("#PasswordRow").show();
        }
    }
}

function ControlWanMode()
{
    if (((CfgModeWord.toUpperCase() == 'TELECENTRO') || (WANMODEChange == 1)) && (!IsAdminUser()))
    {
        if (GetCurrentWan().EncapMode.toString().toUpperCase() == "IPOE")
        {
            setDisplay("WanIPv4InfoBarPanel", 0);
            setDisplay("WanIPv6InfoBarPanel", 0);
            $("#BasicInfoBarPanel>tr:gt(0)").hide();
        }
        if ((GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE") 
        && (!(GetCurrentWan().Mode.toUpperCase() == "IP_ROUTED")))
        {
            setDisplay("WanIPv4InfoBarPanel", 0);
            setDisplay("WanIPv6InfoBarPanel", 0);
            $("#BasicInfoBarPanel>tr:gt(0)").hide();
        }
        setDisplay("WanModeRow",1);
        setDisable("WanMode",0);            
    }
}

function ControlTelmex()
{
	if("1" == supportTelmex)
	{
		setDisable("PriorityPolicy", 1);
		setDisable("DefaultVlanPriority", 1);
		setDisable("VlanPriority", 1);
	}

	if ((CfgModeWord.toUpperCase() == 'TELMEX' ||  CfgModeWord.toUpperCase() == 'TELMEX5G' || CfgModeWord.toUpperCase() == 'TELMEX5GV' || CfgModeWord.toUpperCase() == 'TELMEX5GV5')&&(EditFlag.toUpperCase() == "EDIT"))
	{
		setDisableByName("IPv6PrefixMode", 1);
		setDisableByName("IPv6AddressMode", 1);
	}
}

function CheckProcDnsOverride()
{
    if (('TDE2' == CfgModeWord.toUpperCase())
        || ('COMMON' == CfgModeWord.toUpperCase())
        || ('COMMON2' == CfgModeWord.toUpperCase())
        || ('AWASR' == CfgModeWord.toUpperCase())
        || (true == DnsOverrideFlag)
        || (isSAFARICOM == 1))
    {
        return true;
    }

    return false;
}

function ControlIPv4PPPoEDNSOverride()
{
    var Disable = ((true == IsLanUpCanOper()) || IsAdminUser())==true ? 0 : 1;

    if (true != CheckProcDnsOverride())
    {
        setDisplay("IPv4DNSOverrideSwitchRow", 0);
        return;
    }

    if ((GetCurrentWan().IPv4AddressMode.toString().toUpperCase()== "PPPOE"
        || (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == 'DHCP'))
        && GetCurrentWan().Mode == "IP_Routed")
    {
        setDisplay("IPv4DNSOverrideSwitchRow", 1);

        if (getCheckVal("IPv4DNSOverrideSwitch") == "1")
        {
            setDisplay("IPv4PrimaryDNSServerRow", 1);
            setDisplay("IPv4SecondaryDNSServerRow", 1);
        }
        else
        {
            setDisplay("IPv4PrimaryDNSServerRow", 0);
            setDisplay("IPv4SecondaryDNSServerRow", 0);
        }

        if(getElById("IPv4PrimaryDNSServer").value == '0.0.0.0')
    	{
    		setText('IPv4PrimaryDNSServer','');
    	}

    	if(getElById("IPv4SecondaryDNSServer").value == '0.0.0.0')
    	{
    		setText('IPv4SecondaryDNSServer','');
    	}
    }
    else
    {
        setDisplay("IPv4DNSOverrideSwitchRow", 0);
    }

    if (CfgModeWord.toUpperCase() == 'POLNETIA') {
        Disable = 0;
    }

    setDisable("IPv4DNSOverrideSwitch", Disable);
    setDisable("IPv4PrimaryDNSServer", Disable);
    setDisable("IPv4SecondaryDNSServer", Disable);

    if (true == IsCurrentRadioWan())
	{
		setDisplay("IPv4DNSOverrideSwitchRow", 0);
		setDisplay("IPv4PrimaryDNSServerRow", 0);
		setDisplay("IPv4SecondaryDNSServerRow", 0);
	}
}

function ControlGlobe(Wan)
{
	setDisplay("IPv4WanMVlanIdGlobeUserRow",0);
	if(('GLOBE' == CfgModeWord.toUpperCase() || 'GLOBE2' == CfgModeWord.toUpperCase()) && (!IsAdminUser()))
	{
		setDisable("VlanId",0);
		setDisplay("VlanIdRow",1);
		if(0 == Wan.VlanId)
		{
			setText("VlanId",'');
			setDisable("VlanId",1);
		}
		if((Wan.ProtocolType.toString().toUpperCase()=="IPV4/IPV6") || (Wan.ProtocolType.toString().toUpperCase()=="IPV4"))
		{
			setDisplay("IPv4WanMVlanIdGlobeUserRow",1);
			setText('IPv4WanMVlanIdGlobeUser',Wan.IPv4WanMVlanId);
		}
	}

	if ((CfgModeWord.toUpperCase() == 'ROSUNION') && (!IsAdminUser())) {
		if (GetCurrentWan().ServiceList.toString().toUpperCase() =='INTERNET') {
			setDisable("VlanId", 0);
		} else {
			setDisable("VlanId", 1);
		}
	}
}

function ControlClaro()
{
	if (CfgModeWord.toUpperCase() != 'CLARO' && CfgModeWord.toUpperCase() != 'CLARODR')
	{
	    return ;
	}

    if(curUserType != '2')
    {
        return;
    }

	setDisable('IPv4NatSwitch',0);
	setDisable("ButtonApply",0);
    setDisable("ButtonCancel",0);
}

function ControlWanIPMode()
{
    var Wan = GetCurrentWan();
	
	if((getValue('WanMode').toString().toUpperCase().indexOf("ROUTE") >= 0) && (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0))
	{
		Wan.ProtocolType = "IPv4/IPv6";
		Wan.IPv4Enable = "1";
		Wan.IPv6Enable = "1";
		setSelect("ProtocolType","IPv4/IPv6");
	}
}

function ControlBridgeEnable(Wan) {
    var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    setDisplay("BridgeEnableRow",0);
    if (((oteFlag == "1") || (htFlag == "1")) && (Wan.ServiceList.indexOf("INTERNET") >= 0) &&
        (WanMode == "IP_ROUTED") && (EncapMode == "PPPOE")) {
        setDisplay("BridgeEnableRow",1);
    } else if ((Wan.IPv4AddressMode.toString().toUpperCase() == "PPPOE") &&
        (Wan.Mode.toString().toUpperCase() == "IP_ROUTED") && (IsAdminUser())) {
        setDisplay("BridgeEnableRow", 1);
    }
}

function ControlRosunion(Wan) {
    if (CfgModeWord.toUpperCase() != 'ROSUNION') {
        return ;
    }
    if (Wan.ServiceList.indexOf("INTERNET") < 0) {
        setDisplay("RTKIGMPProxySwitchRow", 0);
    } else {
        setDisplay("RTKIGMPProxySwitchRow", 1);
    }
}

function ControlAisSsidEnable() {
    if(!isAisBackhaul()){
        return;
    }

    var List = document.getElementsByName("IPv4BindLanList");
    for (var i = 0; i < List.length; i++) {
        if (List[i].getAttribute("value") == "SSID9") {
            setDisable(List[i].id, 0);
        }
    }
}

function ControlPage(Wan)
{
    SetCurrentWan(Wan);

    DisableUserMode(0);
    ControlPageByEditModeAndUser();

	if(IPV4V6Flag != 1)
	{
       ControlPanel();
	}
    ControlUserName();
    ControlApplyButton(Wan);
    ControlLcpCheck();
    ControlVlanId();
    ControlPriority();
    E8CCheckDisable(Wan);
    ControlIPv4DHCPEnable();
	Controlsvrlist();
		
	var src = getElementById('WanMode');
	if((IPV4V6Flag == 1) && (ChangeUISource == src) && (EditFlag == "ADD"))
	{
	    ControlWanIPMode();
	}
	
	if(IPV4V6Flag == 1)
	{
	    ControlPanel();
	}
	
    ControlDstIPForwardingListVisibility();
	
	ControlMVlan('IPv4v6');

    ControlIPv4AddressType();
    ControlIPv4EnableNAT();
    ControlIPv4Unnumbered();
    ControlIPv4IGMPEnable();
	ControlIPv4MXU();
    ControlIPv4VendorId();
    ControlIPv4ClientId();
    ControlIPv4StaticIPAddress();
    ControlMultiWanIP();
    ControlIPv4Dial();
    ControlMVlan('IPv4');
    ControlIPv4LanWanBind();
    Control6RDParametersDisplay(Wan);
	ControlDscpToPbit();

    ControlIPv6PrefixAcquireMode();
    ControlIPv6Prefix();
    ControlIPv6AddressAcquireMode();
	ControlIPv6ReservedPrefixAddress();
    ControlIPv6StaticIPAddress();
    ControlIPv6IPAddressStuff();

	ControlIPv6DSLite();
	ControlIPv6AFTRName();
	ControlMVlan('IPv6');

    ControlSpec();

    ControlPageByEditModeAndUser();
	if(((GetCfgMode().BJCU == "1") || (IsLanBJUNICOM())) && (Wan.ServiceList.match('INTERNET')))
    {
    	setDisable("WanMode", 0);
    }

    if (GetCfgMode().BJUNICOM == "1")
    {
        if ((Wan.ServiceList.toString().toUpperCase() =='INTERNET') || (Wan.ServiceList.toString().toUpperCase() =='OTHER'))
        {
            setDisable("IPv4DialMode", 0);
            setDisable("IPv4DialIdleTime", 0);
            setDisable("UserName",0);
    	    setDisable("Password",0);
	    }
	    else
	    {
            setDisable("UserName",1);
    	    setDisable("Password",1);
        	setDisable("ButtonApply",1);
        	setDisable("ButtonCancel",1);
	    }

        if ((Wan.ServiceList == 'IPTV') && (stbport != 0))
        {
            setDisableByName("IPv4BindLanList", 0);
            ControlIPv4LanWanBind();
            setDisable("IPv4BindLanList"+stbport, 1);
            for (var i = 1; i <= parseInt(ethNum); i++)
            {
               setDisable("IPv4BindLanList"+i, 1);
            }
    	    setDisable("ButtonApply", 0);
    	    setDisable("ButtonCancel", 0);
        }
		if (Wan.ServiceList == 'IPTV')
		{
		   setDisable("IPoEUserName", 1);
    	   setDisable("IPoEPassword", 1);
        }

    }

    if (GetFeatureInfo().IPv6 == "0")
    {
        setDisable("ProtocolType", 1);
        setSelect("ProtocolType", "IPv4");
    }
	
	if (IsSupportBridgeWan == 1)
	{
		setDisable("ProtocolType", 1);
		setDisable("WanMode", EditFlag.toUpperCase() == "EDIT" ? 1 : 0);
	}

	if (CfgModeWord.toUpperCase() == "ELISAAP") {
		setDisable("ProtocolType", 0);
	}

	E8Ctr069CheckDisable(Wan);
	ControlErrorWANCfg(Wan);
	if(IsSonetUser())
	{
		ControlSonet();
	}

	if(true == IsRDSGatewayUser())
	{
		ControlInfoRds();
	}
	CntrolAccessType();
	ControlRadioWan(Wan);
	if (GetCfgMode().TRUE == "1")
	{
		ControlTrue();
	}
	else
	{
		ControlAntel();
	}

    if ((CfgModeWord.toUpperCase() == 'RDSAP') && (!IsAdminUser())) {
        DisableUserMode(0);
        if (GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE") {
            RdsAPNormalWanControl();
        } else if (GetCurrentWan().EncapMode.toString().toUpperCase() == "IPOE") {
            RdsAPNormalWanIPOEControl();
        }
    }

	if (DisliteFeature == "1")
	{
	    ControlDislite();
	}
	ControlTelmex();

	if (isWanForConfig == "1") {
		intTrueWanInfoTable();
	}
	ControlIPv4PPPoEDNSOverride();

	if('TDE2' == CfgModeWord.toUpperCase())
	{
		setDisplay("IPv4WanMVlanIdRow", 0);
		setDisplay("IPv6WanMVlanIdRow", 0);

		if('IP_Bridged' == Wan.Mode || 'PPPoE_Bridged' == Wan.Mode)
		{
	    	setDisplay("WanIPv4InfoBarRow", 0);
			setDisplay("WanIPv6InfoBarRow", 0);
			setDisplay("PrifixEnabledRow", 0);
	    }
	    else
	    {
			setDisplay("WanIPv4InfoBarRow", 1);
			setDisplay("WanIPv6InfoBarRow", 1);
			setDisplay("PrifixEnabledRow", 1);
	    }
	    setDisplay("IPv6PrefixModeRow", 0);
	}
	else
	{
		setDisplay("PrifixEnabledRow", 0);
	}

	ControlClaro();

	Option60Display(Wan);

    if((GetCurrentWan().EncapMode.toString().toUpperCase() == "PPPOE") &&
       (!(GetCurrentWan().Mode.toUpperCase() == "IP_ROUTED")) && (CfgModeWord.toUpperCase() == 'RDSAP') && (!IsAdminUser())) {
        setDisplay("WanIPv4InfoBarRow", 1);
        setDisplay("IPv4PrimaryDNSServerRow", 1);
        setDisplay("IPv4SecondaryDNSServerRow",1);
    }

	ControlBridgeEnable(Wan);

	ControlGlobe(Wan);

	ControlSpecXD(Wan);

	if (isSupportLte == "1") {
		displayLteBand(EditFlag.toUpperCase());
	}

	if(APAutoUPPortFlag == 1)
	{
		setDisplay("IPv4WanMVlanIdRow", 0);
		setDisplay("IPv6WanMVlanIdRow", 0);
	}
	
	if (CfgModeWord.toUpperCase() == 'ROSUNION' && !IsAdminUser()) {
		if (GetCurrentWan().ServiceList.toString().toUpperCase() =='INTERNET') {
			setDisable("ButtonApply", 0);
			setDisable("ButtonCancel", 0);
		} else {
			setDisable("ButtonApply", 1);
			setDisable("ButtonCancel", 1);
		}
    }
    ControlRosunion(Wan);

    setDisplay("IPv6NPTSwitchRow", 0);
    if (SupportNPTv6(Wan)) {
        setDisplay("IPv6NPTSwitchRow", 1);
        if (checkContainAny(GetCurrentWan().ServiceList, ["HQoS", "D_Bus"])) {
            if (EditFlag.toUpperCase() == "ADD") {
                setCheck("IPv6NPTSwitch", 1);
            }
        }
    }

    if (SupportTtnet()) {
        if ((SupportTtnet()) && (pppoeUserNameAllFlag == false) && (CurrentWan.UserName.indexOf("@ttnet") == -1)) {
            CurrentWan.UserName = CurrentWan.UserName + "@ttnet";
        }
        changeDTTNETpage(CurrentWan, EditFlag);
    }
	ControlWanName();
    ControlAisSsidEnable();
    return;
}

function OnChangeUI(ControlObject)
{
    var wanmodeobj = getElementById('WanMode');
    ChangeUISource = ControlObject;
    if(ControlObject == wanmodeobj)
    {
        Controlsvrlist();
    }
    ControlPage(GetPageData());
	if (1 == CfgGuide)
	{
		window.parent.adjustParentHeight();
	}
	if(IfVisual==1)
	{
	    pageDisable();
		setDisable(ControlObject.id,0);
		setDisable("WanConnectName_select",0);
	}
	if( 1== isSAFARICOM)
	{
		if(IsDNSLockEnable == "1")
		{
		    setDisable("IPv4DNSOverrideSwitch",1);
			setDisable("IPv4PrimaryDNSServer",1);
			setDisable("IPv4SecondaryDNSServer",1);
		}
		else
		{
		    setDisable("IPv4DNSOverrideSwitch",0);
			setDisable("IPv4PrimaryDNSServer",0);
			setDisable("IPv4SecondaryDNSServer",0);
		}
		var OverrideAllowed = getCheckVal('IPV6OverrideAllowed');
		setDisplay("IPv6PrimaryDNSServerRow", OverrideAllowed);
		setDisplay("IPv6SecondaryDNSServerRow", OverrideAllowed);
	}
	

}

function GetAddType()
{
    return AddType;
}

function GetLinkConfigUrl(Wan)
{
	var temp  = Wan.domain.split(".");
	var LinkTypePath = "";
	
	if( Wan.WanAccessType == "DSL")
	{
		LinkTypePath = "&e=" + temp[0]+'.'+temp[1]+'.'+temp[2]+'.'+temp[3]+'.'+temp[4] + ".WANDSLLinkConfig";
	}
	else if( Wan.WanAccessType == "VDSL")
	{
		LinkTypePath = "&e=" + temp[0]+'.'+temp[1]+'.'+temp[2]+'.'+temp[3]+'.'+temp[4] + ".WANPTMLinkConfig";
	}
    else if(Wan.WanAccessType == "UMTS")
    {
        LinkTypePath = "&e=" + temp[0]+'.'+temp[1]+'.'+temp[2]+'.'+temp[3]+'.'+temp[4] + ".WANUMTSLinkConfig";
    }
	
	return LinkTypePath;
}


function GetAddXDWanUrl(Wan)
{
    if( Wan.WanAccessType == undefined &&  CurrentUpMode == 1 )
    {
        Wan.WanAccessType = "PON";
    }
    
	var Url = '';
	var Inst1 = Instance_AccessType.GetWanInstByWanAceesstype(Wan.WanAccessType);
	var Inst2 = '';
	var WanTypeName = '';
	var LinkConfig = '';
    var InstTemp = '';
	
	if(Wan.EncapMode.toString().toUpperCase() == 'PPPOE')
	{
		WanTypeName = 'WANPPPConnection';
	}
	else
	{
		WanTypeName = 'WANIPConnection';
	}
	
	if( Wan.WanAccessType == "DSL")
	{
        InstTemp = GetPVCIsInUsedWANConnectionDeviceInst(Wan);
        LinkConfig = 'WANDSLLinkConfig';
    }
    else if( Wan.WanAccessType == "VDSL")
    {
        InstTemp = GetVdslIsInUsedWANConnectionDeviceInst(Wan);
        LinkConfig = 'WANPTMLinkConfig';
    }
    else if( Wan.WanAccessType == "Ethernet")
    {
        InstTemp = GetEthIsInUsedWANConnectionDeviceInst(Wan);
        LinkConfig = '';
    }
    else if( Wan.WanAccessType == "SFP" && 1 == isSupportSFP )
    {
        InstTemp = GetSfpIsInUsedWANConnectionDeviceInst(Wan);
        LinkConfig = '';
    } else if( Wan.WanAccessType == "PON" )
    {
        InstTemp = GetPonIsInUsedWANConnectionDeviceInst(Wan);
        LinkConfig = '';
    }

    if( null != InstTemp )
    {
        Inst2 = '.' + InstTemp;
    }
	
    if (SupportOnlyGEWan())
	{
		if (true == WanIsExist())
		{
			Url = 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.' + WanTypeName;
			if('' != LinkConfig)
			{
				Url = Url + '&e=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.' + LinkConfig;
			}
		}
		else
		{
			Url = 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice' + '&GROUP_a_y=GROUP_a_x.' + WanTypeName;
			if('' != LinkConfig)
			{
				Url = Url + '&e=GROUP_a_x.' + LinkConfig;
			}
		}
		
		return Url;
	}
	
    if('' != Inst2)
    {
        Url = 'GROUP_a_y=InternetGatewayDevice.WANDevice.'+ Inst1 + '.WANConnectionDevice' + Inst2 + '.' + WanTypeName;
        if('' != LinkConfig)
        {
            Url = Url + '&e=InternetGatewayDevice.WANDevice.'+ Inst1 + '.WANConnectionDevice' + Inst2 + '.' + LinkConfig;
        }
    }
    else
    {
        Url = 'GROUP_a_x=InternetGatewayDevice.WANDevice.'+ Inst1 + '.WANConnectionDevice' + '&GROUP_a_y=GROUP_a_x.' + WanTypeName;
        if('' != LinkConfig)
        {
            Url = Url + '&e=GROUP_a_x.' + LinkConfig;
        }
    }

	return Url;
}

function GetAddWanUrl(Wan)
{
	if(IsXdProduct())
	{
		return GetAddXDWanUrl(Wan);
	}
	
	var wanConInst = 0;
	var WanList = GetWanList();
	if (AddType != 2)
	{
		if (CfgModeWord.toUpperCase() == 'ROSUNION') {
            if (WanList.length == 0) {
                if (Wan.EncapMode.toString().toUpperCase() == 'PPPOE') {
                    return 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANPPPConnection';
                } else {
                    return 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANIPConnection';
                }
            } else {
                if (Wan.EncapMode.toString().toUpperCase() == 'PPPOE') {
                    return 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection';
                } else {
                    return 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection';
                }
            }
        } else {
            if (Wan.EncapMode.toString().toUpperCase() == 'PPPOE') {
                return 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANPPPConnection';
            } else {
                return 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANIPConnection';
            }
        }
	}
	else
	{
		wanConInst = GetWanInfoSelected().domain.split(".")[4];

		if(Wan.EncapMode.toString().toUpperCase() == 'PPPOE')
		{
			return 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.' + wanConInst + '.WANPPPConnection';
		}
		else
		{
			return 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.' + wanConInst + '.WANIPConnection';
		}
	}
}

function GetWanInstanPathByDomain(domain , num)
{
    var temp  = domain.split(".");

    if( num == 1)
    {
        return temp[0]+'.'+temp[1]+'.'+temp[2];
    }
    else if(num == 2)
    {
        return temp[0]+'.'+temp[1]+'.'+temp[2]+'.'+temp[3]+'.'+temp[4];
    }
    else if(num == 3)
    {
        return domain;
    }

}

function GetLinkTypePath(Wan)
{
    var LinkTypePath = "";

    if(IsXdProduct()) {
        var shouldHasLinkType = IsAdminUser();
        if (((DBAA1 == "1") && (curUserType == '0')) || (CfgModeWord.toUpperCase() == "OTE")) {
            shouldHasLinkType = true;
        }

        if((Wan.WanAccessType == "DSL") && shouldHasLinkType) {
            LinkTypePath = "&e=" + GetWanInstanPathByDomain(Wan.domain,2) + ".WANDSLLinkConfig";
        } else if((Wan.WanAccessType == "VDSL") && shouldHasLinkType) {
            LinkTypePath = "&e=" + GetWanInstanPathByDomain(Wan.domain,2) + ".WANPTMLinkConfig";
        }
    }

    return LinkTypePath;
}

function GetEditWanUrl(Wan)
{
    return Wan.domain;
}

function IsLanBind(Name, IPv4BindLanList)
{
    for (var i = 0; i < IPv4BindLanList.length; i++)
    {
        if (IPv4BindLanList[i] != undefined && IPv4BindLanList[i] != null)
        if (Name.toString().toUpperCase() == IPv4BindLanList[i].toString().toUpperCase())
        {
            return true;
        }
    }
    return false;
}

function ConvertMac(WanMac)
{
	var NewWanMac = WanMac.replace(/\:/g,"-");
	return NewWanMac;
}

function IsOldServerListType(type)
{
	switch(type)
	{
		case 'TR069':
		case 'INTERNET':
		case 'TR069_INTERNET':
		case 'VOIP':
		case 'TR069_VOIP':
		case 'VOIP_INTERNET':
		case 'TR069_VOIP_INTERNET':
		case 'IPTV':
		case 'OTHER':
			return true;
	}

	return false;
}


function GetWanInfoSelected()
{
    var rml = document.getElementsByName("wanInstTablerml");
	if (rml == null)
	{
	    return null;
	}
    if (rml.length > 0)
    {
	    for (var i = 0; i < rml.length; i++)
	    {
	        if (rml[i].checked == true)
            {
                break;
            }
        }

		for (var tmp = 0;tmp < WanList.length; tmp++)
	    {
	        if (WanList[tmp].domain == rml[i].value)
		    {
		        return WanList[tmp];
		    }
	    }

		return null;
    }

	else if (rml.checked == true)
    {
        for (var tmp = 0;tmp < WanList.length; tmp++)
	    {
	        if (WanList[tmp].domain == rml.value)
		    {
		        return WanList[tmp];
		    }
	    }

		return null;
    }
}

function GetSelectedWanNum()
{
    var rml = getElement('wanInstTablerml');
    var numChoosed = 0;
	if (rml == null)
	{
	    return numChoosed;
	}
    if (rml.length > 0)
    {
	    for (var i = 0; i < rml.length; i++)
	    {
	        if (rml[i].checked == true)
            {
                numChoosed = numChoosed + 1;
            }
        }
    }
    else if (rml.checked == true)
    {
        numChoosed = numChoosed + 1;
    }

	return numChoosed;
}
function btnAddWanCnt()
{
	if (GetSelectedWanNum() > 1)
	{
	    AlertMsg("selectonewan");
		return false;
	}


	CurrentWan = defaultWan.clone();

	var wanInfoTmp = null;
    if (AddType == 2)
	{
	    wanInfoTmp = GetWanInfoSelected();
		if (wanInfoTmp == null)
		{
		    return null;
		}
		if (true == IsRadioWanSupported(wanInfoTmp))
		{
			AlertMsg("RadioWanNoSession");
			return false;
		}
		return true;
	}
    return null;
}

function GetBrotherWan(wanTmp)
{
    if(IsXdProduct())
    {
        return null;
    }

    var i = 0;
	for (i = 0; i < GetWanList().length; i++)
	{
		if ((GetWanList()[i].domain.substring(0, 55) ==
	       wanTmp.domain.substring(0, 55))
           && (GetWanList()[i].domain != wanTmp.domain))
        {
			return GetWanList()[i];
		}
	}
	return null;
}

function GetBrotherWanindex(wanTmp)
{
    var i = 0;
	for (i = 0; i < GetWanList().length; i++)
	{
		if ((GetWanList()[i].domain.substring(0, 55) ==
	       wanTmp.domain.substring(0, 55))
           && (GetWanList()[i].domain != wanTmp.domain))
        {
			return i;
		}
	}
	return null;
}


function IsAnyWanSelected()
{
    var rml = getElement('wanInstTablerml');
    var ChooseFlag = false;
	if (rml == null)
	{
	    return ChooseFlag;
	}
    if ( rml.length > 0)
    {
	    for (var i = 0; i < rml.length; i++)
	    {
	        if (rml[i].checked == true)
            {
                ChooseFlag = true;
            }
        }
    }
    else if (rml.checked == true)
    {
        ChooseFlag = true;
    }
	return ChooseFlag;
}

function wanInstTableselectRemoveCnt(curCheck)
{
    if (IsAnyWanSelected() == true)
	{
	    setText('Newbutton', Languages['New_Connection']);
		AddType = 2;
	}
	else
	{
	    setText('Newbutton', Languages['Connection']);
		AddType = 1;
	}
}
function intTrueWanInfoTable() {
    if (IsAdminUser() == false) {
        setDisable("WanMode", 1);
        setDisable("ButtonApply", 1);
        setDisable("UserName", 1);
        setDisable("Password", 1);
    }
}
