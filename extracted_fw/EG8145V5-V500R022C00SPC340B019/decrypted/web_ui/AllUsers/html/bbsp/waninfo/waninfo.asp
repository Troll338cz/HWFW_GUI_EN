<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script>
function __GetISPWanOnlyRead()
{
	return ("<%HW_WEB_GetFeatureSupport(BBSP_FT_ISPSSID_DISPALY);%>" == "1")?true:false;
}

</script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, waninfo_language, Languages, maptInfo_language);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(common.js);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wandns.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_list.asp);%>"></script>
<script language="javascript" src="../common/wan_control.asp"></script>
<title>WAN Information</title>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<script language="javascript" src="../common/ontstate.asp"></script>
<script language="javascript" src="../common/wanaddressacquire.asp"></script>
<script language="javascript" src="../common/wanipv6state.asp"></script>
<script>

var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var IsAPFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var MobileBackupWanSwitch = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Mobile_Backup.Enable,DB);%>';
var IsTDE2Mode   = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var SingtelModeEX = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL_EX);%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';
var ApAptModeValue = '<%HW_WEB_GetCModeAdaptValue();%>';
var TDESME2Modeflg ='<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDESME2);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var isSupportNPTv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_NPTV6);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var IsSupportMap = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_MAP);%>';
var IsSupportMapT = '<%HW_WEB_GetFeatureSupport(FT_MAP_T);%>';
var IsSupportMapE = '<%HW_WEB_GetFeatureSupport(FT_MAP_E);%>';
var isSupportMapEAutoBmr = '<%HW_WEB_GetFeatureSupport(FT_MAP_E_AUTO_BMR);%>';
var isDualWanUpCfg = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DUALWAN_UPSTREAM);%>';
var isDualWanUpProduct = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_DUALWAN_UPSTREAM);%>';
var showWanstatusFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_WANSTATUS);%>';

if (MobileBackupWanSwitch == '')
{
	MobileBackupWanSwitch = 0;
}

function PONPackageInfo(domain,PacketsSent,PacketsReceived)
{
	this.PacketsSent=PacketsSent;
	this.PacketsReceived=PacketsReceived;
}

function dhcpmainst(domain,enable,MainDNS)
{
	this.domain     = domain;
	this.enable     = enable;
	if(MainDNS == "")
	{
		this.MainPriDNS = "";
		this.MainSecDNS = "";
	}
	else
	{
		var MainDnss    = MainDNS.split(',');
		this.MainPriDNS = MainDnss[0];
		this.MainSecDNS  = MainDnss[1];
		if (MainDnss.length <=1)
		{
			this.MainSecDNS = "";
		}
	}
}

function stLanHostInfo(domain,ipaddr,subnetmask)
{
	this.domain = domain;
	this.ipaddr = ipaddr;
	this.subnetmask = subnetmask;
}

function IPv6DNSConfigClass(domain, DomainName, IPv6DNSConfigType, IPv6DNSWANConnection, IPv6DNSServers)
{
	this.domain = domain;
	this.DomainName = DomainName;
	this.IPv6DNSConfigType = IPv6DNSConfigType;
	this.IPv6DNSWANConnection = IPv6DNSWANConnection;
	this.IPv6DNSServers = IPv6DNSServers;
	if(IPv6DNSServers == "")
	{
		this.IPv6PriDNS = "";
		this.IPv6SecDNS = "";
	}
	else
	{
		var MainIPv6Dnss     = IPv6DNSServers.split(',');
		this.IPv6PriDNS  = MainIPv6Dnss[0];
		this.IPv6SecDNS  = MainIPv6Dnss[1];
		if (MainIPv6Dnss.length <=1)
		{
			this.IPv6SecDNS = "";
		}
	}
}
function Br0IPv6AddrClass(domain, Alias, IPv6Address)
{
	this.domain = domain;
	this.Alias = Alias;
	this.IPv6Address = IPv6Address;
}
function WanEthInfo(domain,Status)
{
	this.domain	= domain;
    this.Status = Status;
    if(Status == "Up")
    {
        this.Status = waninfo_language['bbsp_port_linkup'];
    }
    else
    {
        this.Status = waninfo_language['bbsp_port_linkdown'];
    }
}
function WanEthStats(domain, BytesReceived, PacketsReceived, BytesSent, PacketsSent)
{
	this.domain             = domain;
	this.BytesReceived 	    = BytesReceived;
	this.PacketsReceived    = PacketsReceived;
	this.BytesSent  	= BytesSent;
	this.PacketsSent 	= PacketsSent;
}
var TELMEX = false;
var IPv4VendorId="--"
var PackageList =  "";
var ponPackage = "";
if (GetCfgMode().TELMEX == "1")
{
	TELMEX = true;
	PackageList =  <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetPonPackageStat, InternetGatewayDevice.WANDevice.{i}.X_HW_PonInterface.Stats,PacketsSent|PacketsReceived,PONPackageInfo);%>;
	ponPackage = PackageList[0];
}
else
{
	TELMEX = false;
}

function maptInfoArry(domain, Enable, Name, TransportMode, Status, WANInterface, BRIPv6Prefix, MappedIPv4Address, MappedIPv6Address, PortSegments) {
    this.domain = domain;
    this.Enable = Enable;
    this.Name = Name;
    this.TransportMode = TransportMode;
    this.Status = Status;
    this.WANInterface = WANInterface;
    this.BRIPv6Prefix = BRIPv6Prefix;
    this.MappedIPv4Address = MappedIPv4Address;
    this.MappedIPv6Address = MappedIPv6Address;
    this.PortSegments = PortSegments;
}

function ruleInfoArry(domain, Enable, IPv6Prefix, IPv4Prefix, EABitsLength, IsFMR, IsBMR, PSIDOffset, PSIDLength, PSID) {
    this.domain = domain;
    this.RuleEnable = Enable;
    this.IPv6Prefix = IPv6Prefix;
    this.IPv4Prefix = IPv4Prefix;
    this.EABitsLength = EABitsLength;
    this.IsFMR = IsFMR;
    this.IsBMR = IsBMR;
    this.PSIDOffset = PSIDOffset;
    this.PSIDLength = PSIDLength;
    this.PSID = PSID;
}
var maptableInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Domain.{i},Enable|Name|TransportMode|Status|WANInterface|BRIPv6Prefix|MappedIPv4Address|MappedIPv6Address|PortSegments,maptInfoArry);%>;
var ruleInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Domain.{i}.Rule.{i},Enable|IPv6Prefix|IPv4Prefix|EABitsLength|IsFMR|IsBMR|PSIDOffset|PSIDLength|PSID,ruleInfoArry);%>;

var MainDhcpRange = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,DHCPServerEnable|X_HW_DNSList,dhcpmainst);%>;
var dhcpmain = MainDhcpRange[0];
var LanHostInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress|IPInterfaceSubnetMask,stLanHostInfo);%>;
var LanHostInfo = LanHostInfos[0];
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curCfgMode ='<%HW_WEB_GetCfgMode();%>';
var dbaa = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
function IsAdminUser() {
  if (dbaa === '1') {
    return curUserType === '2';
  }
  return curUserType === sysUserType;
}
var IPv6DNSConfigs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_IPv6Config,DomainName|IPv6DNSConfigType|IPv6DNSWANConnection|IPv6DNSServers, IPv6DNSConfigClass);%>;
var IPv6DNSConfig = IPv6DNSConfigs[0];
var Br0IPv6Addrs = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetBr0Ipv6Address,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Address.{i},Alias|IPv6Address, Br0IPv6AddrClass);%>;
var Br0IPv6Addr = Br0IPv6Addrs[0];
var waninfos = GetWanList();
var isNewMegacable = 0;
if (((curCfgMode.toUpperCase() == 'MEGACABLE') || (curCfgMode.toUpperCase() == 'MEGACABLE2')) && (curUserType != 0)) {
    isNewMegacable = 1;
}
function IsRDSGatewayUser()
{
	if('RDSGATEWAY' == curCfgMode.toUpperCase() && curUserType != sysUserType)
	{
		return true;
	}
	else
	{
		return false;
	}
}
function IsSonetUser()
{
	if((SonetFlag == '1')
	   && curUserType != '0')
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsSingtelUser()
{
	if (SingtelMode == '1' && curUserType != '0')
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsPtvdfUser()
{
	if((IsPTVDFFlag == 1) && curUserType != '0')
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsTelecentroUser()
{
	if ((GetCfgMode().TELECENTRO == "1") && (!IsAdminUser()))
    {
    	return true;
    }
    else
    {
    	return false;
    }
}
function IsCwcGatewayUser()
{
	if (('CWCGATEWAY' == curCfgMode.toUpperCase()) && (!IsAdminUser()))
    {
    	return true;
    }
    else
    {
    	return false;
    }
}

function IsPOLNETIAUser()
{
    if (('POLNETIA' == curCfgMode.toUpperCase()) && (!IsAdminUser())) {
        return true;
    } else {
        return false;
    }
}

var ClickWanType = "";
function selectLineipv4(id)
{
	if(true == IsRDSGatewayUser())
	{
		return;
	}
	ClickWanType = "IPV4";
	selectLine(id);
}

function selectLineipv6(id)
{
	ClickWanType = "IPV6";
	selectLine(id);
}

function selectLineMap(id) {
    setDisplay("mapInfoDetail", 1);
    InitMapRuleInfo(id);
}

function selectLineWanStatus(id)
{
	var TableId = id.split('_')[1];
	var index = parseInt(TableId);
	var objTR = getElement(id);
	setLineHighLight(objTR);
	DisplayWanStatusDetail(index);
}

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++)
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		setObjNoEncodeInnerHtmlValue(b, waninfo_language[b.getAttribute("BindText")]);
	}
}
function PPPLastErrTrans(ErrCode)
{
	var errStr = "";
	switch(ErrCode)
	{
		case 'ERROR_USER_DISCONNECT':
		  errStr = waninfo_language['Telmex_UserDisconn_err'];
		  break;
		case 'ERROR_ISP_DISCONNECT':
		  errStr = waninfo_language['Telmex_ISPDisconn_err'];
		  break;
	  case 'ERROR_IDLE_DISCONNECT':
		errStr = waninfo_language['Telmex_IdleDisconn_err'];
		  break;
		case 'ERROR_AUTHENTICATION_FAILURE':
		  errStr = waninfo_language['Telmex_AuthFailuer_err'];
		  break;
		default:
		  errStr = waninfo_language['Telmex_ConnTimeout_err'];
		  break;
	}
	return errStr;
}

function GetIPv4PPPoeError(CurrentWan)
{
	var errStr = "";
	if (GetOntState()!= "ONLINE")
	{
		errStr = waninfo_language['bbsp_wanerror_offline'];
		return errStr;
	}

	if (CurrentWan.Enable == "0")
	{
		errStr = waninfo_language['bbsp_wanerror_disable'];
		return errStr;
	}

	if((CurrentWan.ConnectionTrigger == "Manual") && (CurrentWan.ConnectionControl == "0"))
	{
	   errStr = waninfo_language['bbsp_wanerror_nodial'];
	   return errStr;
	}

	if ((CurrentWan.Status.toUpperCase() == "UNCONFIGURED") || (CurrentWan.Status == ChangeLanguageWanStatus("UNCONFIGURED")))
	{
		errStr = waninfo_language['bbsp_wanerror_noaddress'];
		return errStr;
	}

	if (CurrentWan.IPv4Enable == "1" && CurrentWan.IPv6Enable == "1")
	{
		errStr = waninfo_language['bbsp_wanerror_noaddress'];
		return errStr;
	}

	switch(CurrentWan.LastConnErr)
	{
		case "ERROR_NOT_ENABLED_FOR_INTERNET":
			errStr = waninfo_language['bbsp_wanerror_neg'];
			break;

		case "ERROR_AUTHENTICATION_FAILURE":
			errStr = waninfo_language['bbsp_wanerror_usrpass'];
			break;

		case "ERROR_ISP_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_srvdown'];
			break;

		case "ERROR_ISP_TIME_OUT":
			errStr = waninfo_language['bbsp_wanerror_timeout'];
			break;

		case "ERROR_IDLE_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_notraffic'];
			break;

		default:
			errStr = waninfo_language['bbsp_wanerror_noaddress'];
			break;
	}

	return errStr;

}


function IsDisplayIPv6DialCode(Origin, lla, gua)
{

	if (lla != "")
	{
		return false;
	}

	return true;
}

function GetIPv6PPPoeError(CurrentWan, lla, gua)
{
	var errStr = "";

	if (GetOntState()!= "ONLINE")
	{
		errStr = waninfo_language['bbsp_wanerror_offline'];
		return errStr;
	}

	if (CurrentWan.Enable == "0")
	{
		errStr = waninfo_language['bbsp_wanerror_disable'];
		return errStr;
	}

	if (CurrentWan.IPv4Enable == "1" && CurrentWan.IPv6Enable == "1")
	{
		errStr = waninfo_language['bbsp_wanerror_noaddress'];
		return errStr;
	}

	switch(CurrentWan.LastConnErr)
	{
		case "ERROR_NOT_ENABLED_FOR_INTERNET":
			errStr = waninfo_language['bbsp_wanerror_neg'];
			break;

		case "ERROR_AUTHENTICATION_FAILURE":
			errStr = waninfo_language['bbsp_wanerror_usrpass'];
			break;

		case "ERROR_ISP_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_srvdown'];
			break;

		case "ERROR_ISP_TIME_OUT":
			errStr = waninfo_language['bbsp_wanerror_timeout'];
			break;

		case "ERROR_IDLE_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_notraffic'];
			break;

		default:
			errStr = waninfo_language['bbsp_wanerror_noaddress'];
			break;
	}

	return errStr;

}
function ChangeLanguageWanStatus(WanStatus)
{
	if ("DISCONNECTED" == WanStatus.toUpperCase())
	{
		return waninfo_language['bbsp_waninfo_disconnected'];
	}
	else if ("CONNECTED" == WanStatus.toUpperCase())
	{
		return waninfo_language['bbsp_waninfo_connected'];
	}
	else if ("UNCONFIGURED" == WanStatus.toUpperCase())
	{
		return waninfo_language['bbsp_waninfo_unconfigured'];
	}
		else if ("CONNECTING" == WanStatus.toUpperCase())
	{
		return waninfo_language['bbsp_waninfo_connecting'];
	}
	else
	{
		return WanStatus;
	}
}

function ChangeLanguageWanIPv4AddressMode(IPv4AddressMode)
{
	if( 'PPPOE' == IPv4AddressMode.toUpperCase() )
	{
		return Languages['PPPoE'];
	}
	else if( 'DHCP' == IPv4AddressMode.toUpperCase() )
	{
		return Languages['DHCP'];
	}
	else if( 'STATIC' == IPv4AddressMode.toUpperCase() )
	{
		return Languages['Static'];
	}
	else if( 'AUTO' == IPv4AddressMode.toUpperCase() )
	{
		return Languages['Auto'];
	}
	else
	{
		return IPv4AddressMode;
	}
}

function convertDHCPLeaseTimeRemaining(DHCPLeaseTimeRemaining)
{
	if('0' == DHCPLeaseTimeRemaining || '' == DHCPLeaseTimeRemaining)
	{
	   return "";
	}
	else
	{
	   return DHCPLeaseTimeRemaining;
	}

}

function IsExistIPv6WAN()
{
	var IPv6WanCount = 0;
	for (var i = 0; i < GetWanList().length; i++)
	{
		if (GetWanList()[i].IPv6Enable != "1")
		{
			continue;
		}
		IPv6WanCount++;
	}

	return (IPv6WanCount > 0) ? true : false;

}

function IsSupportIPv6WANInfo()
{
	if(IsPtvdfUser())
	{
		var IPProtoVersion = Instance_IPVersion.GetIPProtVerMode();
		if(1 == IPProtoVersion)
		{
			return false;
		}
		else
		{
			return IsExistIPv6WAN();
		}
	}
	else
	{
		return IsExistIPv6WAN();
	}
}

function ShowWanInfo()
{
	if ((IsAPFlag == "1") || (CfgModeWord.toUpperCase() == "ROSUNION") || (showWanstatusFlag == "1"))
	{
		setDisplay("wanstatusinfo",1);
	}
	else
	{
		setDisplay("wanstatusinfo",0);
	}
}

function IsAPRoute()
{
	if (ApModeValue == "1" || (ApAptModeValue == "1" && ApModeValue == "4"))
	{
		return true;
	}
	return false;
}
function ShowWanStatus()
{
	var htmllines = "";
	if((IsAPRoute()) || (CfgModeWord.toUpperCase() == "ROSUNION") || (showWanstatusFlag == "1"))
	{
		if(waninfos.length == 0)
		{
			htmllines += "<tr class=\"tabal_02\" align=\"center\">";
			htmllines += "<td "+ bottomBorderClass(true) +">--</td>";
			htmllines += "<td "+ bottomBorderClass(true) +">--</td>";
			htmllines += "<td "+ bottomBorderClass(true) +">--</td>";
			htmllines += "<td "+ bottomBorderClass(true) +">--</td>";
			htmllines += "<td "+ bottomBorderClass(true) +">--</td>";
			htmllines += "<td "+ bottomBorderClass(true) +">--</td>";
			if (showWanstatusFlag == 1) {
					htmllines += "<td>--</td>";
					htmllines += "<td>--</td>";
				}
			htmllines += "</tr>";
		}
		else
		{
			for (var i = 0; i < waninfos.length; i++)
			{
				if (curCfgMode.toUpperCase() == "TRIPLETAP" || curCfgMode.toUpperCase() == "TRIPLETAPNOGM" || curCfgMode.toUpperCase() == "TRIPLETAP6" || curCfgMode.toUpperCase() == "TRIPLETAP6PAIR") {
					if (waninfos[i].domain.indexOf(8) > -1) {
						continue;
					}
				}
				htmllines += "<tr class=\"tabal_02\" align=\"center\" id=\"wansinfotatus_" + i + "\" onclick=\"selectLineWanStatus(this.id);\" >";
				htmllines += "<td "+ bottomBorderClass(true) +">" + waninfos[i].Name + "</td>";

				if ((waninfos[i].IPv6Enable == 1) && (waninfos[i].IPv4Enable != 1)) {
					var ipv6Wan = GetIPv6WanInfo(waninfos[i].MacId);
					waninfos[i].Status = ChangeLanguageWanStatus(ipv6Wan.ConnectionStatus);
				}
				else if (GetOntState()!='ONLINE')
				{
					waninfos[i].Status = ChangeLanguageWanStatus('Disconnected');
				}
				else
				{
					if ("UNCONFIGURED" == waninfos[i].Status.toUpperCase())
					{
						waninfos[i].Status = ChangeLanguageWanStatus('Disconnected');
					}
					else
					{
						waninfos[i].Status = ChangeLanguageWanStatus(waninfos[i].Status);
					}
				}
				htmllines += "<td id='wansinfoStatus" + i + "'"+ bottomBorderClass(true) +">" +waninfos[i].Status + "</td>";
				htmllines += "<td id='wansinfoByteRev" + i + "'"+ bottomBorderClass(true) +">" +waninfos[i].BytesReceived + "</td>";
				htmllines += "<td id='wansinfoPacketRev" + i + "'"+ bottomBorderClass(true) +">" +waninfos[i].PacketsReceived + "</td>";
				if (showWanstatusFlag == 1) {
					htmllines += "<td>" +waninfos[i].X_HW_DownstreamBitrate + "</td>";
				}
				htmllines += "<td id='wansinfoByteSent" + i + "'"+ bottomBorderClass(true) +">" +waninfos[i].BytesSent + "</td>";
				htmllines += "<td id='wansinfoPacketSent" + i + "'"+ bottomBorderClass(true) +">" +waninfos[i].PacketsSent + "</td>";
				if (showWanstatusFlag == 1) {
					htmllines += "<td>" +waninfos[i].X_HW_UpstreamBitrate + "</td>";
				}
				htmllines += "</tr>";
			}
		}
	}
	$("#Wanstatus").append(htmllines);
}
var wanStatsTime = 0;
var wanStatsData;
function InitWanStatsData() {
    wanStatsTime++;
    if (waninfos[0].BytesReceived != "") {
        clearInterval(wanStatsData);
        for (var i = 0; i < waninfos.length; i++) {
            getElementById("wansinfoByteRev" + i).innerText = waninfos[i].BytesReceived;
            getElementById("wansinfoPacketRev" + i).innerText = waninfos[i].PacketsReceived;
            getElementById("wansinfoByteSent" + i).innerText = waninfos[i].BytesSent;
            getElementById("wansinfoPacketSent" + i).innerText = waninfos[i].PacketsSent;
        }
    }

    if (wanStatsTime == 10) {
        clearInterval(wanStatsData);
    }
}

function LoadFrame()
{
    if (curCfgMode.toUpperCase() == "AISAP") {
        if (waninfos.length > 0 && waninfos[0].BytesReceived == "") {
            wanStatsData = setInterval("InitWanStatsData()", 300);
        }
    }

	if( window.location.href.indexOf("?") > 0)
	{
		var WanPage = window.location.href.split("?")[1];
	}
	if(true == IsRDSGatewayUser())
	{
		setDisplay("IPv6PrefixPanelRds", 1);
		setDisplay("IPv6TitleInfoBar", 1);
		setDisplay("IPv6PrefixPanel", 0);
	}
	ShowWanInfo();
	if (showWanstatusFlag != "1") {
		ShowWanStatus();
	}

	if ((CfgModeWord.toUpperCase() == "ROSUNION") && (curUserType == sysUserType)) {
        document.getElementById('wanstatusinfo_table1').style.marginBottom  = '5px';
    }

    if ((IsSupportMap == 1) && ((IsSupportMapE == 1) || (IsSupportMapT == 1))) {
        setDisplay("mapInfoDiv", 1);
    }
}
if( '1' == TDESME2Modeflg )
{
    waninfo_language['bbsp_ip'] = waninfo_language['bbsp_ip_1'];
	waninfo_language['bbsp_ipv6ipaddress'] = waninfo_language['bbsp_ipv6ipaddress_1'];
    waninfo_language['bbsp_wanip'] = waninfo_language['bbsp_wanip_1'];
}
function clearnStatistic() {
    var Form = new webSubmitForm();
    Form.addParameter('x.wanid', 0);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.BBSP.ClearWanPktStatistic&RequestFile=html/bbsp/waninfo/waninfo.asp');
    Form.submit();
}
</script>
<script type="text/javascript" language="javascript">
if (true == TELMEX)
{
	document.write('<div style="overflow-x:auto;overflow-y:auto;width:100%; height:100%;">');
}
</script>
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("waninfo", GetDescFormArrayById(waninfo_language, "bbsp_mune"), GetDescFormArrayById(waninfo_language, "bbsp_waninfo_titile"), false);
</script>
<script type="text/javascript" language="javascript">
if (true == TELMEX)
{
	document.write('<div id="IPTable">');
}
else
{
	document.write('<div  id="IPTable" style="overflow-x:auto;overflow-y:hidden;width:100%;">');
}
</script>
<div class="title_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
<tr><td class="width_per100" BindText="bbsp_ipv4info"></td></tr></table>

<table class="tabal_bg width_per100"  cellspacing="1" id="IPv4Panel">
  <tr class="head_title" id = "Table_wan_ipv4_head">
   <script type="text/javascript" language="javascript">
    	if (IsRDSGatewayUser() == true) {
			document.write('<td>'+waninfo_language['bbsp_linkstate_rds']+'</td>');
			document.write('<td>'+waninfo_language['bbsp_ipmode']+'</td>');
			document.write('<td>'+waninfo_language['bbsp_ip']+'</td>');
			document.write('<td>'+waninfo_language['bbsp_mask']+'</td>');
		} else {
			document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_wanname']+'</td>');
			document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_linkstate']+'</td>');
			if (isNewMegacable != 1) {
                document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_ip']+'</td>');
			}
		}

		if (!IsTelecentroUser()) {
			if((!IsSonetUser()) && (!IsRDSGatewayUser()) && (!IsPtvdfUser()) && (!IsSingtelUser())) {
				if (rosunionGame == "1") {
					document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_vlanpri']+'</td>');
				} else {
					document.write('<td id="Ipv4VlanPri">'+waninfo_language['bbsp_vlanpri']+'</td>');
				}
			}

			if ((!IsRDSGatewayUser()) && (!IsSingtelUser())) {
				document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_con']+'</td>');
			}

			if (IsRDSGatewayUser()) {
				document.write('<td>'+waninfo_language['bbsp_mac']+'</td>');
			}
		}

        if((curCfgMode.toUpperCase() == 'GLOBE2') || (curCfgMode.toUpperCase() == 'GLOBE')) {
            document.write('<td>'+waninfo_language['bbsp_wandialcode']+'</td>');
        }
        if (isNewMegacable == 1) {
            setDisplay("Ipv4Addresss",0);
           setDisplay("Ipv4VlanPri",0);
        }
    </script>
</tr>
	<script type="text/javascript" language="javascript">

	function replaceSpace(str)
	{
		if(str.indexOf(" ")!=-1)
		{
			str=str.replace(/ /g,"&#160;");
		}
		return str;
	}

	function AddTimeUnit(time,timeunit)
	{
		if(time.toString().length == 0||(time == "--"))
			return time;
		else
			return time.toString() +" "+ timeunit;
	}


	function FormatDigit(Number)
	{
		if (Number < 10)
		{
			return ('0' + Number);
		}
		else
		{
			return Number;
		}
	}

	function DisplayIpv6RouteInfo( bDisplay )
	{
		setDisplay("IPv6GateWayRow",bDisplay);
		setDisplay("IPv6DnsServerRow",bDisplay);
		setDisplay("IPv6PriDnsServerRow",bDisplay);
		setDisplay("IPv6SecDnsServerRow",bDisplay);
		setDisplay("IPv6PrefixRow",bDisplay);
		setDisplay("IPv6PrefixModeRow",bDisplay);
		setDisplay("IPv6PrefixPreferredTimeRow",bDisplay);
		setDisplay("IPv6PrefixVaildTimeRow",bDisplay);
		setDisplay("IPv6PrefixVaildTimeRemainingRow",bDisplay);
		setDisplay("IPv6IpAddressRow",bDisplay);
		setDisplay("IPv6IpAccessModeRow",bDisplay);
		setDisplay("Ipv6IpStateRow",bDisplay);
		setDisplay("IPv6PreferredTimeRow",bDisplay);
		setDisplay("IPv6VaildTimeRow",bDisplay);
		setDisplay("IPv6DsliteAftrnameRow",bDisplay);
		setDisplay("IPv6VaildTimeRemainingRow",bDisplay);
		setDisplay("IPv6DslitePeerAddressRow",bDisplay);
		setDisplay("IPv6DialCodeRow",bDisplay);
	}

	function GetIpv6WanTime(IPv6WanTimeList, wanIndex)
	{
		for(var i = 0; i < IPv6WanTimeList.length - 1; i++) {
			if (IPv6WanTimeList[i].WanInstanceId == wanIndex) {
				return IPv6WanTimeList[i].V6UpTime;
			}
		}

		return "0";
	}

	function GetAddressTimeRemaining(wanIpv6Address, wanIndex)
	{
		var List = new Array();
		var Count = 0;

		for (var i = 0; i < wanIpv6Address.length; i++)
		{
			if(wanIpv6Address[i] == null)
			continue;

			if (wanIpv6Address[i].WanInstanceId != wanIndex)
			continue;

			List[Count++] = wanIpv6Address[i];
		}

		return List;
	}

	function GetPrefixTimeRemaining(wanIpv6prefix, wanIndex)
	{
		var List = new Array();
		var Count = 0;

		for (var i = 0; i < wanIpv6prefix.length; i++)
		{
			if(wanIpv6prefix[i] == null)
			continue;

			if (wanIpv6prefix[i].WanInstanceId != wanIndex)
			continue;

			List[Count++] = wanIpv6prefix[i];
		}

		return List;
	}

	function DisplayIPv6WanDetail(WanIndex)
	{
		var CurrentWan = GetWanList()[WanIndex];
		var ipv6Wan = GetIPv6WanInfo(CurrentWan.MacId);
		var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
		var AddressList = GetIPv6AddressList(CurrentWan.MacId);
		var AcquireHtml = "";
		var AddressHtml = "";
		var AddressStatusHtml = "";
		var AddressPreferredTimeHtml = "";
		var AddressValidTimeHtml = "";
		var AddressValidTimeRemainingHtml="";
		var PriDNSServers = "";
		var SecDNSServers = "";
		var DNSServer = "";

		var wanIpv6Address = new Array(null);
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "/html/bbsp/common/get_ipv6state_address.asp",
            success : function(data) {
                if (data != "") {
                    wanIpv6Address = dealDataWithFun(data);
                }
            }
		});
		var addressTimeList = GetAddressTimeRemaining(wanIpv6Address, CurrentWan.MacId);

		for (var m = 0; m < AddressList.length; m++)
		{
			if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
			{
				if (CurrentWan.Enable == "1")
				{
					if(AddressHtml == '')
						AddressHtml += AddressList[m].IPAddress;
					else
						AddressHtml += "<br>" + AddressList[m].IPAddress;

					if(AddressStatusHtml == '')
						AddressStatusHtml += AddressList[m].IPAddressStatus;
					else
						AddressStatusHtml += "<br>" +  AddressList[m].IPAddressStatus;

					if(AddressPreferredTimeHtml == '')
						AddressPreferredTimeHtml += AddressList[m].PreferredTime;
					else
						AddressPreferredTimeHtml += "<br>" +  AddressList[m].PreferredTime;

					if(AddressValidTimeHtml == '')
						AddressValidTimeHtml += AddressList[m].ValidTime;
					else
						AddressValidTimeHtml += "<br>" +  AddressList[m].ValidTime;

					if(AddressValidTimeRemainingHtml == '')
					{
						AddressValidTimeRemainingHtml += convertDHCPLeaseTimeRemaining(addressTimeList[m].ValidTimeRemaining);
					}
					else
					{
						AddressValidTimeRemainingHtml += "<br>" +  convertDHCPLeaseTimeRemaining(addressTimeList[m].ValidTimeRemaining);
					}
				}
			}
		}

		setDisplay("IPv6WanDetail",1);
		setDisplay("ipv6InformationForm",1);
		setDisplay("V6PPPUsernameRow",0);
		setDisplay("V6PPPPasswordRow",0);

		if (GetCfgMode().BJUNICOM == "1")
		{
			CurrentWan.MACAddress = ConvertMac(CurrentWan.MACAddress);
		}
		setElementInnerHtmlById("IPv6MacAddress", CurrentWan.MACAddress);
		setNoEncodeInnerHtmlValue("IPv6PriorityPolicy", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? waninfo_language['bbsp_wanpriority'] : waninfo_language['bbsp_wandefaultpri']);
		setDisplay("IPv6NPTv6EnableRow", 0);
        if (curCfgMode.toUpperCase() == 'TURKCELL2') {
            if (parseInt(CurrentWan.VlanId,10) == 4095) {
                if((ipv6Wan.ConnectionStatus.toUpperCase() == "CONNECTED") && (CurrentWan.Mode == 'IP_Routed')) {
                    setElementInnerHtmlById("IPv6Vlan", "");
                    setElementInnerHtmlById("IPv6Priority", "");
                    setElementInnerHtmlById("IPv6PriorityPolicy", "");
                } else {
                    setElementInnerHtmlById("IPv6Vlan", "--");
                    setElementInnerHtmlById("IPv6Priority", "--");
                    setElementInnerHtmlById("IPv6PriorityPolicy", "--");
                }
            } else {
                setElementInnerHtmlById("IPv6Vlan", CurrentWan.VlanId);
                setElementInnerHtmlById("IPv6Priority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? CurrentWan.Priority : CurrentWan.DefaultPriority);
                setNoEncodeInnerHtmlValue("IPv6PriorityPolicy", waninfo_language[CurrentWan.PriorityPolicy]);
            }
        } else {
            if (parseInt(CurrentWan.VlanId,10) == 0) {
                if((ipv6Wan.ConnectionStatus.toUpperCase() == "CONNECTED") && (CurrentWan.Mode == 'IP_Routed') ) {
                    setElementInnerHtmlById("IPv6Vlan", "");
                    setElementInnerHtmlById("IPv6Priority", "");
                    setElementInnerHtmlById("IPv6PriorityPolicy", "");
                } else {
                    setElementInnerHtmlById("IPv6Vlan", "--");
                    setElementInnerHtmlById("IPv6Priority", "--");
                    setElementInnerHtmlById("IPv6PriorityPolicy", "--");
                }
            } else {
                setElementInnerHtmlById("IPv6Vlan", CurrentWan.VlanId);
                setElementInnerHtmlById("IPv6Priority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? CurrentWan.Priority : CurrentWan.DefaultPriority);
                setNoEncodeInnerHtmlValue("IPv6PriorityPolicy", waninfo_language[CurrentWan.PriorityPolicy]);
            }
        }
		if(true == IsSonetUser())
		{
			setDisplay("IPv6VlanRow",0);
			setDisplay("IPv6PriorityPolicyRow",0);
			setDisplay("IPv6PriorityRow",0);
		}

		if('IP_Routed' == CurrentWan.Mode)
		{
			setDisplay("IPv6GateWayRow",1);
			if(true == TELMEX)
			{
				setDisplay("IPv6DnsServerRow",0);
				setDisplay("IPv6PriDnsServerRow",1);
				setDisplay("IPv6SecDnsServerRow",1);
			}
			else
			{
				setDisplay("IPv6DnsServerRow",1);
				setDisplay("IPv6PriDnsServerRow",0);
				setDisplay("IPv6SecDnsServerRow",0);
			}
			setDisplay("IPv6PrefixRow",1);
			setDisplay("IPv6PrefixModeRow",1);
			setDisplay("IPv6PrefixPreferredTimeRow",1);
			setDisplay("IPv6PrefixVaildTimeRow",1);
			setDisplay("IPv6PrefixVaildTimeRemainingRow",1);
			setDisplay("IPv6IpAddressRow",1);
			setDisplay("IPv6IpAccessModeRow",1);
			setDisplay("Ipv6IpStateRow",1);
			setDisplay("IPv6PreferredTimeRow",1);
			setDisplay("IPv6VaildTimeRow",1);
			setDisplay("IPv6VaildTimeRemainingRow",1);
			setDisplay("IPv6DsliteAftrnameRow",1);
			setDisplay("IPv6DslitePeerAddressRow",1);


			if(true == IsSonetUser())
			{
			    setDisplay("IPv6IpAddressRow",0);
				setDisplay("IPv6IpAccessModeRow",0);
				setDisplay("Ipv6IpStateRow",0);
				setDisplay("IPv6PreferredTimeRow",0);
				setDisplay("IPv6VaildTimeRow",0);
				setDisplay("IPv6GateWayRow",0);
				setDisplay("IPv6DsliteAftrnameRow",0);
				setDisplay("IPv6VaildTimeRemainingRow",0);
				setDisplay("IPv6DslitePeerAddressRow",0);
			}

			if (isSupportNPTv6 == '1') {
				setDisplay("IPv6NPTv6EnableRow", 1);
				setNoEncodeInnerHtmlValue("IPv6NPTv6Enable", CurrentWan.X_HW_NPTv6Enable == "1" ? waninfo_language['bbsp_enable']: waninfo_language['bbsp_disable']);
			}

			var PrefixList = GetIPv6PrefixList(CurrentWan.MacId);
			var Prefix = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].Prefix:'') :(PrefixList[0].Prefix));
			Prefix = (CurrentWan.Enable == "1") ? Prefix : "";

			var PrefixAcquire = GetIPv6PrefixAcquireInfo(CurrentWan.domain);
			PrefixAcquire = ((PrefixAcquire==null) ? '' : PrefixAcquire.Origin);
			setElementInnerHtmlById("IPv6PrefixMode", PrefixAcquire);

            if (1 == IsTDE2Mode)
            {
                switch (AddressAcquire.Origin)
                {
                    case "AutoConfigured":
                        AcquireHtml = "SLAAC";
                        break;
                    case "DHCPv6":
                        AcquireHtml = "DHCPv6";
                        break;
                    case "Static":
                        AcquireHtml = "Static";
                        break;
                    case "None":
                        AcquireHtml = "Unnumbered";
                        break;
                    default:
                        AcquireHtml = "SLAAC";
                        break;
                }
            }
            else
            {
			    AcquireHtml = AddressAcquire.Origin;
            }

			if("" != ipv6Wan.DNSServers)
			{
				if(ipv6Wan.DNSServers.indexOf(",") >= 0)
				{
					PriDNSServers = ipv6Wan.DNSServers.split(",")[0];
					SecDNSServers = ipv6Wan.DNSServers.split(",")[1];
				}
				else
				{
					PriDNSServers = ipv6Wan.DNSServers;
					SecDNSServers = "--";
				}
			}

			setElementInnerHtmlById("IPv6IpAccessMode", AcquireHtml);

			var PrefixPreferredTime = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].PreferredTime:'') :(PrefixList[0].PreferredTime));
			PrefixPreferredTime = ((CurrentWan.Enable == "1") && (Prefix.length != 0))? PrefixPreferredTime : "";

			var PrefixValidTime = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].ValidTime:'') :(PrefixList[0].ValidTime));
			PrefixValidTime = ((CurrentWan.Enable == "1") && (Prefix.length != 0)) ? PrefixValidTime : "";

			var wanIpv6prefix = new Array(null);
			$.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : "/html/bbsp/common/get_ipv6state_prefix.asp",
				success : function(data) {
					if (data != "") {
						wanIpv6prefix = dealDataWithFun(data);
					}
				}
			});
			var prefixTimeList = GetAddressTimeRemaining(wanIpv6prefix, CurrentWan.MacId);

			var PrefixValidTimeRemaining = ((PrefixList!=null)?(PrefixList.length > 0?prefixTimeList[0].ValidTimeRemaining:'') :(prefixTimeList[0].ValidTimeRemaining));
			PrefixValidTimeRemaining = ((CurrentWan.Enable == "1") && (Prefix.length != 0)) ? PrefixValidTimeRemaining : "";
			PrefixValidTimeRemaining = convertDHCPLeaseTimeRemaining(PrefixValidTimeRemaining);

			if("CONNECTED" == ipv6Wan.ConnectionStatus.toUpperCase() )
			{
				setElementInnerHtmlById("IPv6GateWay", ipv6Wan.DefaultRouterAddress);
				if(true == TELMEX)
				{
					if(("STATIC" != IPv6DNSConfig.IPv6DNSConfigType.toUpperCase())
					|| (IPv6DNSConfig.IPv6PriDNS == Br0IPv6Addr.IPv6Address)
					|| (IPv6DNSConfig.IPv6SecDNS == Br0IPv6Addr.IPv6Address)
					|| ((IPv6DNSConfig.IPv6PriDNS == "") && (IPv6DNSConfig.IPv6SecDNS == "")))
					{
						setElementInnerHtmlById("IPv6PriDnsServer", PriDNSServers);
						setElementInnerHtmlById("IPv6SecDnsServer", SecDNSServers);
					}
					else
					{
						setNoEncodeInnerHtmlValue("IPv6PriDnsServer", PriDNSServers + '<br>' + '<font color="red">' + waninfo_language['bbsp_ipv6_dnsser'] + '</font>');
						setNoEncodeInnerHtmlValue("IPv6SecDnsServer", SecDNSServers + '<br>' + '<font color="red">' + waninfo_language['bbsp_ipv6_dnsser'] + '</font>');
					}
				}
				else
				{
					setElementInnerHtmlById("IPv6DnsServer", ipv6Wan.DNSServers);
				}
				setNoEncodeInnerHtmlValue("IPv6PreferredTime", AddTimeUnit(AddressPreferredTimeHtml,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6VaildTime", AddTimeUnit(AddressValidTimeHtml,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6VaildTimeRemaining", AddTimeUnit(AddressValidTimeRemainingHtml,waninfo_language['bbsp_timeunit']));
				setElementInnerHtmlById("IPv6Prefix", Prefix);
				setNoEncodeInnerHtmlValue("IPv6PrefixPreferredTime", AddTimeUnit(PrefixPreferredTime,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6PrefixVaildTime", AddTimeUnit(PrefixValidTime,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6PrefixVaildTimeRemaining", AddTimeUnit(PrefixValidTimeRemaining,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6IpAddress", AddressHtml);
				setNoEncodeInnerHtmlValue("Ipv6IpState", AddressStatusHtml);
				setElementInnerHtmlById("IPv6DsliteAftrname", CurrentWan.IPv6AFTRName);
				setElementInnerHtmlById("IPv6DslitePeerAddress", ipv6Wan.AFTRPeerAddr);

			}
			else
			{
				setElementInnerHtmlById("IPv6GateWay", "--");
				if(true == TELMEX)
				{
					setElementInnerHtmlById("IPv6PriDnsServer", "--");
					setElementInnerHtmlById("IPv6SecDnsServer", "--");
				}
				else
				{
					setElementInnerHtmlById("IPv6DnsServer", "--");
				}
				setElementInnerHtmlById("IPv6PreferredTime", "--");
				setElementInnerHtmlById("IPv6VaildTime", "--");
				setElementInnerHtmlById("IPv6Prefix", "--");
				setElementInnerHtmlById("IPv6PrefixPreferredTime", "--");
				setElementInnerHtmlById("IPv6PrefixVaildTime", "--");
				setElementInnerHtmlById("IPv6PrefixVaildTimeRemaining", "--");
				setElementInnerHtmlById("IPv6IpAddress", "--");
				setElementInnerHtmlById("Ipv6IpState", "--");
				setElementInnerHtmlById("IPv6DsliteAftrname", "--");
				setElementInnerHtmlById("IPv6DslitePeerAddress", "--");
		  }

		  if('IPoE' == CurrentWan.EncapMode)
		  {
			  setDisplay("IPv6DialCodeRow",0);
		  }
		  else
		  {
			  var lla = "";
			  var gua = "";
			  for (var m = 0; m < AddressList.length; m++)
			  {
					if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
					{
						gua = AddressList[m].IPAddress;
					}
					else
					{
						lla = AddressList[m].IPAddress;
					}
			  }

			  if (IsDisplayIPv6DialCode(AddressAcquire.Origin, lla, gua) == false)
			  {
				  setDisplay("IPv6DialCodeRow",0);
			  }
			  else
			  {
				  setDisplay("IPv6DialCodeRow",1)

				  var error = GetIPv6PPPoeError(CurrentWan, lla, gua);
				  setElementInnerHtmlById("IPv6DialCode", error);
			  }

			  if('GLOBE' == curCfgMode.toUpperCase() || 'GLOBE2' == curCfgMode.toUpperCase())
			  {
				  setDisplay("V6PPPUsernameRow",1);
				  setDisplay("V6PPPPasswordRow",1);
				  setElementInnerHtmlById("V6PPPUsername", CurrentWan.UserName);
				  setElementInnerHtmlById("V6PPPPassword", "***");
			  }
		  }

		  if (true == TELMEX)
		  {
			  setDisplay("IPv6DialCodeRow",0);
			  setDisplay("IPv6DnsServerRow",0);
		  }

		}
		else
		{
			DisplayIpv6RouteInfo(0);
		}

        var ipv6WanTimeList = new Array();
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "/html/bbsp/common/get_wan_list_ipv6time.asp",
            success : function(data) {
                if (data != "") {
                    ipv6WanTimeList = dealDataWithFun(data);
                }
            }
        });

		var days = 0;
		var hours = 0;
		var minutes = 0;
		var seconds = 0;
		var ipv6WanTime = GetIpv6WanTime(ipv6WanTimeList, CurrentWan.MacId)
		seconds = ipv6WanTime%60;
		minutes = Math.floor(ipv6WanTime/60);
		hours  = Math.floor(minutes/60);
		minutes = minutes%60;
		days = Math.floor(hours/24);
		hours = hours%24;

		setDisplay("V6UpTimeRow",1);

		if (days != '0' || hours != '0' || minutes != '0' || seconds != '0')
		{
			 setElementInnerHtmlById("V6UpTime",
				FormatDigit(days) + ':' + FormatDigit(hours) + ':' + FormatDigit(minutes) + ':' + FormatDigit(seconds));
		}
		else
		{
			setElementInnerHtmlById("V6UpTime", "--");
		}
		if (IsTelecentroUser())
		{
			DisplaySimplifyWanDetail("IPV6",WanIndex);
		}
		if (IsCwcGatewayUser())
		{
			if ((-1 != CurrentWan.ServiceList.indexOf("VOIP")))
			{
				DisplayIpv6RouteInfo(0);
				setDisplay("V6UpTimeRow",0);
			}
		}
        if (IsPOLNETIAUser()) {
            if ((CurrentWan.ServiceList.toString().toUpperCase() == "TR069") ||
                (CurrentWan.ServiceList.toString().toUpperCase() == "VOIP") ||
                (CurrentWan.ServiceList.toString().toUpperCase() == "TR069_VOIP")) {
                setDisplay("ipv6InformationForm",0);
            }
        }
        if (isNewMegacable == 1) {
            document.getElementById('IPv6VlanRow').style.display="none";
            document.getElementById('IPv6IpAddressRow').style.display="none";
            document.getElementById('IPv6GateWayRow').style.display="none";
        }
    }

	function GetStaticRouteInfo(string)
	{
		var Result = hexDecode(string);
		var res = Result.split("\n");
		if ((typeof(res) != "undefined") && (res != "undefined")) {
			setElementInnerHtmlById("StaticRoute", res[1]);
		}
	}

	function GetOption121(wanindex)
	{
		var Option121Info="";

		$.ajax({
			type : "POST",
			async : true,
			cache : false,
			timeout : 2000,
			data : "x.X_HW_Token="+getValue('onttoken'),
			url : "staticroute.cgi?WANNAME=wan"+wanindex,
			success : function(data) {
				GetStaticRouteInfo(data);
			},
			complete: function (XHR, TS) {

				Option121Info=null;

				XHR = null;
		  }
		});
	}

	function DisplaySimplifyWanDetail(type,WanIndex)
	{
		var CurrentWan = GetWanList()[WanIndex];
		if (type.toUpperCase() == "IPV4")
		{
			var arr = getElementById("ipv4InformationForm").getElementsByTagName("tr");
			for (var i = 1; i < arr.length; i++)
			{
				arr[i].style.display = "none";
			}
			setDisplay("MacAddressRow",1);
			setDisplay("NatSwitchRow",1);
			setDisplay("IPAddressModeRow",1);
			setDisplay("V4UpTimeRow",1);
			setElementInnerHtmlById("MacAddress", CurrentWan.MACAddress);
			if( 'IP_Routed' == CurrentWan.Mode )
			{
				setNoEncodeInnerHtmlValue("NatSwitch", CurrentWan.IPv4NATEnable == "1" ? waninfo_language['bbsp_enable']: waninfo_language['bbsp_disable']);
			}
			else
			{
				setDisplay("NatSwitchRow",0);
			}
			if (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0)
			{
				setElementInnerHtmlById("IPAddressMode", "--");
			}
			else
			{
				setNoEncodeInnerHtmlValue("IPAddressMode", ChangeLanguageWanIPv4AddressMode(CurrentWan.IPv4AddressMode));
			}
			if (CurrentWan.EncapMode.toUpperCase() == 'IPOE' || CurrentWan.Mode.toUpperCase() != 'IP_ROUTED')
			{
				setDisplay("DialCodeRow",0);
			}
			else
			{
				if(CurrentWan.Status == waninfo_language['bbsp_waninfo_connected'])
				{
					setDisplay("DialCodeRow",0);
				}
				else
				{
					setDisplay("DialCodeRow",1);
					var error = GetIPv4PPPoeError(CurrentWan);
					setElementInnerHtmlById("DialCode", error);
				}
			}
		}
		else if(type.toUpperCase() == "IPV6")
		{
			var CurrentWan = GetWanList()[WanIndex];
			var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
			var AddressList = GetIPv6AddressList(CurrentWan.MacId);
			var arr = getElementById("ipv6InformationForm").getElementsByTagName("tr");
			for (var i = 1; i < arr.length; i++)
			{
				arr[i].style.display = "none";
			}
			setElementInnerHtmlById("IPv6MacAddress", CurrentWan.MACAddress);
			if(CurrentWan.EncapMode.toUpperCase() == "IPOE" ||CurrentWan.Mode.toUpperCase() != 'IP_ROUTED')
			{
			  	setDisplay("IPv6DialCodeRow",0);
			}
			else
			{
				var lla = "";
				var gua = "";
				for (var m = 0; m < AddressList.length; m++)
				{
					if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
					{
						gua = AddressList[m].IPAddress;
					}
					else
					{
						lla = AddressList[m].IPAddress;
					}
				}
				if (IsDisplayIPv6DialCode(AddressAcquire.Origin, lla, gua) == false)
				{
					setDisplay("IPv6DialCodeRow",0);
				}
				else
				{
					setDisplay("IPv6DialCodeRow",1)
					var error = GetIPv6PPPoeError(CurrentWan, lla, gua);
					setElementInnerHtmlById("IPv6DialCode", error);
				}
			}
			setDisplay("IPv6MacAddressRow",1);
			setDisplay("V6UpTimeRow",1);
		}
	}

    function isTEDataMode() {
        return (CfgModeWord.toUpperCase() == 'TEDATA2') || (CfgModeWord.toUpperCase() == 'TEDATA');
    }

	function DisplayIpv4RouteInfo( bDisplay )
	{
		setDisplay("NatSwitchRow",bDisplay);
		setDisplay("IpAdressRow",bDisplay);
		setDisplay("GateWayRow",bDisplay);
		setDisplay("DnsServerRow",bDisplay);
		setDisplay("PriDnsServerRow",bDisplay);
		setDisplay("SecDnsServerRow",bDisplay);
		setDisplay("BrasNameRow",bDisplay);
		setDisplay("LeaseTimeRow",bDisplay);
		setDisplay("LeaseTimeRemainingRow",bDisplay);
		setDisplay("NtpServerRow",bDisplay);
		setDisplay("STimeRow",bDisplay);
		setDisplay("SipServerRow",bDisplay);
		setDisplay("StaticRouteRow",bDisplay);
		setDisplay("VenderInfoRow",bDisplay);
		setDisplay("DialCodeRow",bDisplay);
	}
	function DisplayIPv4WanDetail(WanIndex)
	{
		var CurrentWan = GetWanList()[WanIndex];
		document.getElementById("WanDetail").style.display = "";
		setDisplay("ipv4InformationForm",1);

		if (GetCfgMode().BJUNICOM == "1")
		{
			CurrentWan.MACAddress = ConvertMac(CurrentWan.MACAddress);
		}
		setElementInnerHtmlById("MacAddress", CurrentWan.MACAddress);
		setText("MacAddress",CurrentWan.MACAddress);

		setNoEncodeInnerHtmlValue("PriorityColleft", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? waninfo_language['bbsp_wanpriority'] : waninfo_language['bbsp_wandefaultpri']);

        var wanTimeList = new Array(null);
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "/html/bbsp/common/get_wan_list_time.asp",
            success : function(data) {
                if (data != "") {
                    wanTimeList = dealDataWithFun(data);
                }
            }
        });

        var wanTimeListNum = wanTimeList.length;
        var upTime = CurrentWan.Uptime;
        var DHCPLeaseTimeRemaining = CurrentWan.DHCPLeaseTimeRemaining;
        for (i = 0; (wanTimeList != null && wanTimeListNum > 0 && i < wanTimeListNum); i++) {
            if (wanTimeList[i].domain == CurrentWan.domain) {
                upTime = wanTimeList[i].Uptime;
                DHCPLeaseTimeRemaining = wanTimeList[i].DHCPLeaseTimeRemaining;
            }
        }

        if (curCfgMode.toUpperCase() == 'TURKCELL2') {
            if (parseInt(CurrentWan.VlanId,10) == 4095) {
                if(((CurrentWan.Status == 'Connected') || (CurrentWan.Status == waninfo_language['bbsp_waninfo_connected'])) && (CurrentWan.IPv4IPAddress != '')) {
                    setElementInnerHtmlById("Vlan", "");
                    setElementInnerHtmlById("Priority", "");
                    setElementInnerHtmlById("PriorityPolicy", "");
                } else {
                    setElementInnerHtmlById("Vlan", "--");
                    setElementInnerHtmlById("Priority", "--");
                    setElementInnerHtmlById("PriorityPolicy", "--");
                }
            } else {
                setElementInnerHtmlById("Vlan", CurrentWan.VlanId);
                setElementInnerHtmlById("Priority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? CurrentWan.Priority : CurrentWan.DefaultPriority);
                setNoEncodeInnerHtmlValue("PriorityPolicy", waninfo_language[CurrentWan.PriorityPolicy]);
            }
        } else {
            if (parseInt(CurrentWan.VlanId,10) == 0) {
                if(((CurrentWan.Status == 'Connected') || (CurrentWan.Status == waninfo_language['bbsp_waninfo_connected'])) && (CurrentWan.IPv4IPAddress != '')) {
                    setElementInnerHtmlById("Vlan", "");
                    setElementInnerHtmlById("Priority", "");
                    setElementInnerHtmlById("PriorityPolicy", "");
                } else {
                    setElementInnerHtmlById("Vlan", "--");
                    setElementInnerHtmlById("Priority", "--");
                    setElementInnerHtmlById("PriorityPolicy", "--");
                }
            } else {
                setElementInnerHtmlById("Vlan", CurrentWan.VlanId);
                setElementInnerHtmlById("Priority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? CurrentWan.Priority : CurrentWan.DefaultPriority);
                setNoEncodeInnerHtmlValue("PriorityPolicy", waninfo_language[CurrentWan.PriorityPolicy]);
            }
        }
		setDisplay("RDModeRow", 0);
		setDisplay("RDPrefixRow", 0);
		setDisplay("RDPrefixLenthRow", 0);
		setDisplay("RDBrAddrRow", 0);
		setDisplay("RDIpv4MaskLenthRow", 0);
		setDisplay("V4PPPUsernameRow",0);
		setDisplay("V4PPPPasswordRow",0);

		if(true == IsSonetUser())
		{
			setDisplay("VlanRow",0);
			setDisplay("PriorityRow",0);
			setDisplay("PriorityPolicyRow",0);
		}

		if (true == IsSingtelUser())
		{
			setDisplay("VlanRow",0);
			setDisplay("PriorityRow",0);
			setDisplay("PriorityPolicyRow",0);
		}
		if (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0)
		{
			setElementInnerHtmlById("IPAddressMode", "--");
		}
		else
		{
			setNoEncodeInnerHtmlValue("IPAddressMode", ChangeLanguageWanIPv4AddressMode(CurrentWan.IPv4AddressMode));
		}

		setDisplay("HurlRow",0);
		setDisplay("MotmRow",0);

		if( 'IP_Routed' == CurrentWan.Mode )
		{
			setNoEncodeInnerHtmlValue("NatSwitch", CurrentWan.IPv4NATEnable == "1" ? waninfo_language['bbsp_enable']: waninfo_language['bbsp_disable']);

			setDisplay("NatSwitchRow",1);
			setDisplay("IpAdressRow",1);
			setDisplay("GateWayRow", isTEDataMode() ? 0 : 1);
			if(true == TELMEX)
			{
				setDisplay("DnsServerRow",0);
				setDisplay("PriDnsServerRow",1);
				setDisplay("SecDnsServerRow",1);
			}
			else
			{
				setDisplay("DnsServerRow",1);
				setDisplay("PriDnsServerRow",0);
				setDisplay("SecDnsServerRow",0);
			}

			var servicetypeIsMatch = (-1 != CurrentWan.ServiceList.indexOf("INTERNET")) || (-1 != CurrentWan.ServiceList.indexOf("IPTV")) || (-1 != CurrentWan.ServiceList.indexOf("OTHER"));
			if( (1 == CurrentWan.IPv4Enable) && (0 == CurrentWan.IPv6Enable) &&
				(true == servicetypeIsMatch)&&(true == Is6RdSupported()))
			{
				setDisplay("RDModeRow", 1);
				setElementInnerHtmlById("RDMode", CurrentWan.RdMode);
				if (1 == CurrentWan.Enable6Rd)
				{
					setDisplay("RDPrefixRow", 1);
					setDisplay("RDPrefixLenthRow", 1);
					setDisplay("RDBrAddrRow", 1);
					setDisplay("RDIpv4MaskLenthRow", 1);
					setElementInnerHtmlById("RDPrefix", CurrentWan.RdPrefix);
					setElementInnerHtmlById("RDPrefixLenth", CurrentWan.RdPrefixLen);
					setElementInnerHtmlById("RDBrAddr", CurrentWan.RdBRIPv4Address);
					setElementInnerHtmlById("RDIpv4MaskLenth", CurrentWan.RdIPv4MaskLen);
				}
			}

			if (((CurrentWan.Status == waninfo_language['bbsp_waninfo_connected']) || (CurrentWan.Status == 'Connected')) && (CurrentWan.IPv4IPAddress != ''))
			{
				setElementInnerHtmlById("IpAdress", CurrentWan.IPv4IPAddress + "/" + CurrentWan.IPv4SubnetMask);
				if (CurrentWan.IPv4Gateway != '')
                {
    				setElementInnerHtmlById("GateWay", CurrentWan.IPv4Gateway);
                }
                else
                {
    				setElementInnerHtmlById("GateWay", "--");
                }

				var DnsSplitCharacter = ("" == CurrentWan.IPv4SecondaryDNS) ? " " : ",";
				if((true == TELMEX) && (dhcpmain.enable == 1))
				{
					if(((dhcpmain.MainPriDNS == "") && (dhcpmain.MainSecDNS == ""))
					|| (dhcpmain.MainPriDNS == LanHostInfo.ipaddr) || (dhcpmain.MainSecDNS == LanHostInfo.ipaddr))
					{
						setElementInnerHtmlById("PriDnsServer", CurrentWan.IPv4PrimaryDNS);
						setElementInnerHtmlById("SecDnsServer", CurrentWan.IPv4SecondaryDNS);

					}
					else
					{
						setNoEncodeInnerHtmlValue("PriDnsServer", CurrentWan.IPv4PrimaryDNS + '<br>' + '<font color="red">' + waninfo_language['bbsp_waninfo_dnsser'] + '</font>');
						setNoEncodeInnerHtmlValue("SecDnsServer", CurrentWan.IPv4SecondaryDNS + '<br>' + '<font color="red">' + waninfo_language['bbsp_waninfo_dnsser'] + '</font>');
					}
				}
				else
				{
					if(true == TELMEX)
					{
						setElementInnerHtmlById("PriDnsServer", CurrentWan.IPv4PrimaryDNS);
						setElementInnerHtmlById("SecDnsServer", CurrentWan.IPv4SecondaryDNS);
					}
					else
					{
						setElementInnerHtmlById("DnsServer", CurrentWan.IPv4PrimaryDNS + DnsSplitCharacter +CurrentWan.IPv4SecondaryDNS);
					}
				}
			}
			else
			{
				setElementInnerHtmlById("IpAdress", "--");
				setElementInnerHtmlById("GateWay", "--");
				if(true == TELMEX)
				{
					setElementInnerHtmlById("PriDnsServer", "--");
					setElementInnerHtmlById("SecDnsServer", "--");
				}
				else
				{
					setElementInnerHtmlById("DnsServer", "--");
				}
			}

			if('IPoE' == CurrentWan.EncapMode)
			{
				setDisplay("BrasNameRow", 0);

				setDisplay("DialCodeRow",0);

				if (("STATIC" == CurrentWan.IPv4AddressMode.toUpperCase()) || ("AUTO" == CurrentWan.IPv4AddressMode.toUpperCase()))
				{
					setDisplay("LeaseTimeRow",0);
					setDisplay("LeaseTimeRemainingRow",0);
					setDisplay("NtpServerRow",0);
					setDisplay("STimeRow",0);
					setDisplay("SipServerRow",0);
					setDisplay("StaticRouteRow",0);
					setDisplay("VenderInfoRow",0);
				}
				else
				{
					setDisplay("LeaseTimeRow",1);
					setDisplay("LeaseTimeRemainingRow",1);
					setDisplay("NtpServerRow",1);
					setDisplay("STimeRow",1);
					setDisplay("SipServerRow",1);
					setDisplay("StaticRouteRow",1);
					setDisplay("VenderInfoRow",1);
				}

				if(true == IsSonetUser())
				{
					setDisplay("SipServerRow",0);
					setDisplay("StaticRouteRow",0);
					setDisplay("VenderInfoRow",0);
				}

				if (true == IsSingtelUser())
				{
					setDisplay("SipServerRow",0);
					setDisplay("StaticRouteRow",0);
					setDisplay("VenderInfoRow",0);
					setDisplay("NtpServerRow",0);
				}

				if(SingtelModeEX == 1)
				{
					setDisplay("SipServerRow",0);
				}
				if((CurrentWan.Status == waninfo_language['bbsp_waninfo_connected']) || (CurrentWan.Status == 'Connected'))
				{
					setNoEncodeInnerHtmlValue("LeaseTime", AddTimeUnit(CurrentWan.DHCPLeaseTime,waninfo_language['bbsp_timeunit']));
					setNoEncodeInnerHtmlValue("LeaseTimeRemaining", AddTimeUnit(convertDHCPLeaseTimeRemaining(DHCPLeaseTimeRemaining),waninfo_language['bbsp_timeunit']));
					setElementInnerHtmlById("NtpServer", CurrentWan.NTPServer);
					setElementInnerHtmlById("STime", CurrentWan.TimeZoneInfo);
					setElementInnerHtmlById("SipServer", CurrentWan.SIPServer);

					setElementInnerHtmlById("StaticRoute", "");
					if ("DHCP" == CurrentWan.IPv4AddressMode.toUpperCase())
					{
					    if (false == IsSingtelUser())
					    {
    						GetOption121(CurrentWan.MacId);
						}
					}
					else
					{
						setElementInnerHtmlById("StaticRoute", CurrentWan.StaticRouteInfo);
					}
					IPv4VendorId = CurrentWan.IPv4VendorId;
					setNoEncodeInnerHtmlValue("VenderInfo", replaceSpace(GetStringContent(htmlencode(IPv4VendorId),16)));
					document.getElementById("VenderInfo").title = IPv4VendorId;
				}
				else
				{
					setElementInnerHtmlById("LeaseTime", "--");
					setElementInnerHtmlById("LeaseTimeRemaining", "--");
					setElementInnerHtmlById("NtpServer", "--");
					setElementInnerHtmlById("STime", "--");
					setElementInnerHtmlById("SipServer", "--");
					setElementInnerHtmlById("StaticRoute", "--");
					setElementInnerHtmlById("VenderInfo", "--");
				}
				if ( bin4board_nonvoice() == true )
				{
					setDisplay("SipServerRow",0);
				}
			}
			else
			{
				setDisplay("BrasNameRow", isTEDataMode() ? 0 : 1);
				setDisplay("LeaseTimeRow",0);
				setDisplay("LeaseTimeRemainingRow",0);
				setDisplay("NtpServerRow",0);
				setDisplay("STimeRow",0);
				setDisplay("SipServerRow",0);
				setDisplay("VenderInfoRow",0);

				if(("" != CurrentWan.Hurl) && (!IsCwcGatewayUser()))
				{
					setElementInnerHtmlById("Hurl", CurrentWan.Hurl);
					setDisplay("HurlRow", 1);
				}

				if(("" != CurrentWan.Motm) && (!IsCwcGatewayUser()))
				{
					setElementInnerHtmlById("Motm", CurrentWan.Motm);
					setDisplay("MotmRow", 1);
				}

				if(CurrentWan.Status == waninfo_language['bbsp_waninfo_connected'])
				{
					setElementInnerHtmlById("BrasName", CurrentWan.PPPoEACName);
					setElementInnerHtmlById("StaticRoute", CurrentWan.StaticRouteInfo);
					setDisplay("DialCodeRow",0);
				}
				else
				{
					setDisplay("DialCodeRow",1);

					var error = GetIPv4PPPoeError(CurrentWan);

					setElementInnerHtmlById("DialCode", error);
					setElementInnerHtmlById("BrasName", "--");
					setElementInnerHtmlById("StaticRoute", "--");
				}

				if (true == TELMEX)
				{
					setDisplay("DialCodeRow",0);
				}

				if('GLOBE' == curCfgMode.toUpperCase() || 'GLOBE2' == curCfgMode.toUpperCase())
				{
					setDisplay("V4PPPUsernameRow",1);
					setDisplay("V4PPPPasswordRow",1);
					setElementInnerHtmlById("V4PPPUsername", CurrentWan.UserName);
					setElementInnerHtmlById("V4PPPPassword", "***");
				}
			}
		}
		else
		{
		    DisplayIpv4RouteInfo(0);
		}

		var days = 0;
		var hours = 0;
		var minutes = 0;
		var seconds = 0;
		seconds = upTime % 60;
		minutes = Math.floor(upTime / 60);
		hours  = Math.floor(minutes / 60);
		minutes = minutes % 60;
		days = Math.floor(hours / 24);
		hours = hours % 24;

		setDisplay("V4UpTimeRow",1);

		if (days != '0' || hours != '0' || minutes != '0' || seconds != '0')
		{
			setElementInnerHtmlById("V4UpTime",
				FormatDigit(days) + ':' + FormatDigit(hours) + ':' + FormatDigit(minutes) + ':' + FormatDigit(seconds));
		}
		else
		{
			setElementInnerHtmlById("V4UpTime", "--");
		}
		if (IsTelecentroUser())
		{
			DisplaySimplifyWanDetail("IPV4",WanIndex);
     	}
		if (IsCwcGatewayUser())
		{
			if ((-1 != CurrentWan.ServiceList.indexOf("VOIP")))
			{
				DisplayIpv4RouteInfo(0);
				setDisplay("IPAddressModeRow",0);
				setDisplay("V4UpTimeRow",0);
			}
        }

        if (IsPOLNETIAUser()) {
            if ((CurrentWan.ServiceList.toString().toUpperCase() == "TR069") ||
                (CurrentWan.ServiceList.toString().toUpperCase() == "VOIP") ||
                (CurrentWan.ServiceList.toString().toUpperCase() == "TR069_VOIP")) {
                setDisplay("ipv4InformationForm",0);
            }
        }
        if (isNewMegacable == 1) {
            document.getElementById('VlanRow').style.display="none";
            document.getElementById('IPAddressModeRow').style.display="none";
            document.getElementById('IpAdressRow').style.display="none";
            document.getElementById('GateWayRow').style.display="none";
        }
    }

	function DisplayWanStatusDetail(index)
	{
		setDisplay("WanStatusDetail",1);
		if (showWanstatusFlag != 1) {
			setDisplay("UpstreamBitrateRow",0);
			setDisplay("DownstreamBitrateRow",0);
		}
		if((IsAPRoute()) || (CfgModeWord.toUpperCase() == "ROSUNION") || (showWanstatusFlag == "1")) {
			setElementInnerHtmlById("Name",waninfos[index].Name);
			setElementInnerHtmlById("Status",waninfos[index].Status);
			setElementInnerHtmlById("BytesReceived",waninfos[index].BytesReceived);
			setElementInnerHtmlById("PacketsReceived",waninfos[index].PacketsReceived);
			setElementInnerHtmlById("UnicastReceived",waninfos[index].UnicastReceived);
			setElementInnerHtmlById("MulticastReceived",waninfos[index].MulticastReceived);
			setElementInnerHtmlById("BroadcastReceived",waninfos[index].BroadcastReceived);
			setElementInnerHtmlById("BytesSent",waninfos[index].BytesSent);
			setElementInnerHtmlById("PacketsSent",waninfos[index].PacketsSent);
			setElementInnerHtmlById("UnicastSent",waninfos[index].UnicastSent);
			setElementInnerHtmlById("MulticastSent",waninfos[index].MulticastSent);
			setElementInnerHtmlById("BroadcastSent",waninfos[index].BroadcastSent);
			if (showWanstatusFlag == 1) {
				setElementInnerHtmlById("UpstreamBitrate", waninfos[index].X_HW_UpstreamBitrate);
				setElementInnerHtmlById("DownstreamBitrate", waninfos[index].X_HW_DownstreamBitrate);
			}
		}
	}
	function setControl(WanIndex)
	{
		if (true == IsPtvdfUser())
		{
			return;
		}
		var CurrentWan = GetWanList()[WanIndex];
		var ProtocolType = GetProtocolType(CurrentWan.IPv4Enable, CurrentWan.IPv6Enable);
		if ("IPv4" == ProtocolType)
		{
			DisplayIPv4WanDetail(WanIndex);
		}
		else if ("IPv6" == ProtocolType)
		{
			DisplayIPv6WanDetail(WanIndex);
		}
		else if ("IPv4/IPv6" == ProtocolType)
		{
			if ("IPV4" == ClickWanType)
			{
				DisplayIPv4WanDetail(WanIndex);
			}
			else if ("IPV6" == ClickWanType)
			{
				DisplayIPv6WanDetail(WanIndex);
			}
		}
	}

function isGEBackupWan(wan) {
    if ((isDualWanUpCfg === '1') && (isDualWanUpProduct === '1')) {
        if (wan.RealName && (wan.RealName.indexOf('GEBackupWan') >= 0)) {
            return true;
        }
    }

    return false;
}

var IPv4WanCount = 0;
var IPv6WanCount = 0;
var IPv6WanRdsCount = 0;
function DrawIPv4Table() {
    var domString = "";
    for (var i = 0;i < GetWanList().length;i++) {
        var CurrentWan = GetWanList()[i];
        if ((CurrentWan.IPv4Enable != "1") || ((GetCfgMode().PTVDF == 1) && (IsAdminUser() == false) &&
            (MobileBackupWanSwitch == 0) && (CurrentWan.Name.toUpperCase().indexOf("MOBILE") >=0))) {
            continue;
        }

        if ((curCfgMode.toUpperCase() == "CYPRUSCYTA") && (IsAdminUser() == false) &&
            (CurrentWan.ServiceList.indexOf("INTERNET") < 0)) {
            continue;
        }

        if (curCfgMode.toUpperCase() == "TRIPLETAP" || curCfgMode.toUpperCase() == "TRIPLETAPNOGM" ||
            curCfgMode.toUpperCase() == "TRIPLETAP6" || curCfgMode.toUpperCase() == "TRIPLETAP6PAIR") {
            if (CurrentWan.domain.indexOf(8) > -1) {
                continue;
            }
        }
        if ((curCfgMode.toUpperCase() == "RDSAP") && (IsAdminUser() == false) && (CurrentWan.Name.toUpperCase().indexOf("TR069") >= 0)) {
            continue;
        }
        IPv4WanCount ++;
        domString += ('<TR id="record_' + i + '" onclick="selectLineipv4(this.id);" class="tabal_01" align="center">');
        var idPrefix = getElementId(domainTowanname(CurrentWan.domain))
        if (IsRDSGatewayUser() == false) {
            domString += ('<td class="restrict_dir_ltr' + bottomBorderClass(false) +' ' + idPrefix+'_Name">'+htmlencode(CurrentWan.Name)+'</td>');
        }

		if ((CfgModeWord.toUpperCase() == "TELECOM2") && (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0)) {
            domString += ('<td align="center" '+ bottomBorderClass(true) +'>--</td>');
		} else {
            if ((IsRadioWanSupported(CurrentWan) == true) || isGEBackupWan(CurrentWan)) {
				domString += ('<td ' + bottomBorderClass(true) + '>'+ ChangeLanguageWanStatus(CurrentWan.Status) + '</td>');
			} else if (GetOntState()!='ONLINE') {
				domString += ('<td ' + bottomBorderClass(true) + '>'+ ChangeLanguageWanStatus('Disconnected') + '</td>');
			} else {
				if (("UNCONFIGURED" == CurrentWan.Status.toUpperCase()) || (ChangeLanguageWanStatus("UNCONFIGURED") == CurrentWan.Status)) {
					domString += ('<td ' + bottomBorderClass(true) + '>' +ChangeLanguageWanStatus('Disconnected') + '</td>');
				} else {
					domString += ('<td ' + bottomBorderClass(true) + '>' + ChangeLanguageWanStatus(CurrentWan.Status) + '</td>');
				}
			}
		}

        if (IsRDSGatewayUser()) {
            if (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) {
                domString += ('<td align="center" '+ bottomBorderClass(true) +'>--</td>');
            } else {
                domString += ('<td align="center" '+ bottomBorderClass(true) +'>'+CurrentWan.IPv4AddressMode+'</td>');
            }
        }

        if (isNewMegacable != 1) {
            if (((CurrentWan.Status == 'Connected') || (CurrentWan.Status == waninfo_language['bbsp_waninfo_connected'])) && (CurrentWan.IPv4IPAddress != '') && (CurrentWan.Mode == 'IP_Routed')) {
                if(((IsCwcGatewayUser()) && (-1 != CurrentWan.ServiceList.indexOf("VOIP"))) ||
                ((IsPOLNETIAUser()) && ((CurrentWan.ServiceList.toString().toUpperCase() == "TR069") ||
                                        (CurrentWan.ServiceList.toString().toUpperCase() == "VOIP") ||
                                        (CurrentWan.ServiceList.toString().toUpperCase() == "TR069_VOIP")))) {
                    domString += ('<td align="center" '+ bottomBorderClass(true) +'>**</td>');
                } else {
                    domString += ('<td '+ bottomBorderClass(true) +'>'+CurrentWan.IPv4IPAddress + '</td>');
                }
            } else {
                domString += ('<td align="center" '+ bottomBorderClass(true) +'>--</td>');
            }
        }

        if (IsRDSGatewayUser()) {
            if((CurrentWan.Status == waninfo_language['bbsp_waninfo_connected']) && (CurrentWan.IPv4SubnetMask != '') && (CurrentWan.Mode == 'IP_Routed')) {
                domString += ('<td '+ bottomBorderClass(true) +'>'+CurrentWan.IPv4SubnetMask+'</td>');
            }else {
                domString += ('<td align="center" '+ bottomBorderClass(true) +'>--</td>');
            }
        }
        if (IsTelecentroUser()) {
            domString += ('</tr>');
            continue;
        }
        if (isNewMegacable != 1) {
            if((!IsSonetUser()) && (!IsRDSGatewayUser()) && (!IsPtvdfUser()) && (!IsSingtelUser())) {
                if ((curCfgMode.toUpperCase() == "DTURKCELL2WIFI") || (curCfgMode.toUpperCase() == 'TURKCELL2')) {
                    if ( parseInt(CurrentWan.VlanId,10) != 4095) {
                        var pri = ('Specified' == CurrentWan.PriorityPolicy) ? CurrentWan.Priority : CurrentWan.DefaultPriority ;
                        domString += ('<td>'+CurrentWan.VlanId+'/'+pri+'</td>');
                    } else {
                        domString += ('<td>'+'-/-'+'</td>');
                    }
                } else {
                    if ( parseInt(CurrentWan.VlanId,10) != 0) {
                        var pri = ('Specified' == CurrentWan.PriorityPolicy) ? CurrentWan.Priority : CurrentWan.DefaultPriority ;
                        domString += ('<td '+ bottomBorderClass(true) +'>'+CurrentWan.VlanId+'/'+pri+'</td>');
                    } else {
                        domString += ('<td '+ bottomBorderClass(true) +'>'+'-/-'+'</td>');
                    }
                }
            }
        }

        if (IsRDSGatewayUser() == true) {
            if (CurrentWan.MACAddress != '') {
                domString += ('<td>'+CurrentWan.MACAddress +'</td>');
            } else {
                domString += ('<td align="center">--</td>');
            }
        }

        if ((IsRDSGatewayUser() == false) && (IsSingtelUser() == false)) {
            if (NeedAddConnectButton(CurrentWan) == true && CurrentWan.Enable == "1") {
                var btText = CurrentWan.ConnectionControl == "1" ? waninfo_language['bbsp_discon']: waninfo_language['bbsp_con'];
                var ctrFlag = CurrentWan.ConnectionControl == "1" ? "0": "1";
                domString += ("<td align='center'><a style='color:blue' onclick = 'OnConnectionControlButton(this,"+i+","+ctrFlag+")' RecordId = '"+i+"' href='#'>"+btText+"</a></td>");
            } else {
                var innerText = waninfo_language['bbsp_AlwaysOn'];
                if (IsRadioWanSupported(CurrentWan) == true) {
                    if (CurrentWan.TriggerMode == "OnDemand") {
                        innerText = waninfo_language['bbsp_needcon'];
                    }
                } else {
                    if (CurrentWan.ConnectionTrigger == "OnDemand") {
                        innerText = waninfo_language['bbsp_needcon'];
                    } else if (CurrentWan.ConnectionTrigger == "Manual") {
                        innerText = waninfo_language['bbsp_Manual'];
                    }
                }
                domString += ("<td "+ bottomBorderClass(true) +">"+innerText+"</td>");
            }
        }
        if ('GLOBE2' == curCfgMode.toUpperCase() || 'GLOBE' == curCfgMode.toUpperCase()) {
            if ( 'IP_Routed' == CurrentWan.Mode ) {
                if ('IPoE' == CurrentWan.EncapMode) {
                    domString += ('<td>--</td>');
                } else {
                    var error = GetIPv4PPPoeError(CurrentWan);
                    if (CurrentWan.Status == waninfo_language['bbsp_waninfo_connected']) {
                        domString += ('<td>--</td>');
                    } else {
                        domString += ('<td>'+error+'</td>');
                    }
                }
            } else {
                domString += ('<td>--</td>');
            }
        }
        domString += ('</tr>');
    }
    if(IPv4WanCount == 0) {
        domString += ("<tr class= \"tabal_01\" align=\"center\">");

        if (true == IsRDSGatewayUser()) {
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ("</tr>");
        } else {
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            if ((IsSonetUser() == false) && (IsPtvdfUser() == false)) {
                domString += ('<td >'+'--'+'</td>');
            }
            if (!IsTelecentroUser() && (isNewMegacable != 1)) {
                if (false == IsSingtelUser()) {
                    domString += ('<td >'+'--'+'</td>');
                    domString += ('<td >'+'--'+'</td>');
                }
            }
            if ('GLOBE2' == curCfgMode.toUpperCase() || 'GLOBE' == curCfgMode.toUpperCase()) {
                domString += ('<td >'+'--'+'</td>');
            }
            domString += ("</tr>");
        }
    }
    return domString;
}
$("#Table_wan_ipv4_head").after(DrawIPv4Table());
</script>
</table>

<div  align='center' style="display:none" id="WanDetail">
<div class="list_table_spread"></div>
<form id="ipv4InformationForm" name="ipv4InformationForm">
<table id="ipv4InformationFormPanel" class="tabal_bg width_per100"  cellspacing="1" >
<li id="WanDetailTitle" RealType="HorizonBar" DescRef="bbsp_wandetailinfo" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="MacAddress" RealType="HtmlText" DescRef="bbsp_wanmacaddress" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="MacAddress" InitValue="Empty"/>
<li id="Vlan" RealType="HtmlText" DescRef="bbsp_wanvlan" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Vlan" InitValue="Empty"/>
<li id="PriorityPolicy" RealType="HtmlText" DescRef="bbsp_wanpripolicy" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PriorityPolicy" InitValue="Empty"/>
<li id="Priority" RealType="HtmlText" DescRef="bbsp_wanpriority" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Priority" InitValue="Empty"/>
<li id="NatSwitch" RealType="HtmlText" DescRef="bbsp_wannat" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="NatSwitch" InitValue="Empty"/>
<li id="IPAddressMode" RealType="HtmlText" DescRef="bbsp_ipmode1" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="V4PPPUsername" RealType="HtmlText" DescRef="" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="V4PPPPassword" RealType="HtmlText" DescRef="" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="IpAdress" RealType="HtmlText" DescRef="bbsp_wanip" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IpAdress" InitValue="Empty"/>
<li id="GateWay" RealType="HtmlText" DescRef="bbsp_wangateway" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="GateWay" InitValue="Empty"/>
<li id="Hurl" RealType="HtmlText" DescRef="bbsp_acshurl" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_HURL" InitValue="Empty"/>
<li id="Motm" RealType="HtmlText" DescRef="bbsp_motm" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_MOTM" InitValue="Empty"/>
<li id="DnsServer" RealType="HtmlText" DescRef="bbsp_wandns" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DnsServer" InitValue="Empty"/>
<li id="PriDnsServer" RealType="HtmlText" DescRef="bbsp_wanpridns" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="SecDnsServer" RealType="HtmlText" DescRef="bbsp_wansecdns" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="BrasName" RealType="HtmlText" DescRef="bbsp_wanbras" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="BrasName" InitValue="Empty"/>
<li id="DialCode" RealType="HtmlText" DescRef="bbsp_wandialcode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DialCode" InitValue="Empty"/>
<li id="LeaseTime" RealType="HtmlText" DescRef="bbsp_wanlease" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LeaseTime" InitValue="Empty"/>
<li id="LeaseTimeRemaining" RealType="HtmlText" DescRef="bbsp_wanlease_remaining" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LeaseTimeRemaining" InitValue="Empty"/>
<li id="NtpServer" RealType="HtmlText" DescRef="bbsp_wanntp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="NtpServer" InitValue="Empty"/>
<li id="STime" RealType="HtmlText" DescRef="bbsp_wanstime" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="STime" InitValue="Empty"/>
<li id="SipServer" RealType="HtmlText" DescRef="bbsp_wansip" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SipServer" InitValue="Empty"/>
<li id="StaticRoute" RealType="HtmlText" DescRef="bbsp_wansroute" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="StaticRoute" InitValue="Empty"/>
<li id="VenderInfo" RealType="HtmlText" DescRef="bbsp_wanvendor" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="VenderInfo"  Elementclass="restrict_dir_ltr" InitValue="Empty"/>
<li id="RDMode" RealType="HtmlText" DescRef="Des6RDMode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RDMode" InitValue="Empty"/>
<li id="RDPrefix" RealType="HtmlText" DescRef="Des6RDPrefix" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RDPrefix" InitValue="Empty"/>
<li id="RDPrefixLenth" RealType="HtmlText" DescRef="Des6RDPrefixLenth" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RDPrefixLenth" InitValue="Empty"/>
<li id="RDBrAddr" RealType="HtmlText" DescRef="Des6RDBrAddr" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RDBrAddr" InitValue="Empty"/>
<li id="RDIpv4MaskLenth" RealType="HtmlText" DescRef="Des6RDIpv4MaskLenth" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RDIpv4MaskLenth" InitValue="Empty"/>
<li id="V4UpTime" RealType="HtmlText" DescRef="uptime_tips" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="V4UpTime" InitValue="Empty"/>
</table>
<script>
var TableClass = new stTableClass("align_left width_per30", "align_left width_per70", "ltr");
var Ipv4WanInfoFormList = new Array();
	Ipv4WanInfoFormList = HWGetLiIdListByForm("ipv4InformationForm",null);
	HWParsePageControlByID("ipv4InformationForm",TableClass,waninfo_language,null);
	var Ipv4WaninfoArray = new Array();

	HWSetTableByLiIdList(Ipv4WanInfoFormList,Ipv4WaninfoArray,null);
	setNoEncodeInnerHtmlValue("V4PPPUsernameColleft", Languages['IPv4UserName']);
	setNoEncodeInnerHtmlValue("V4PPPPasswordColleft", Languages['IPv4Password']);
</script>
</form>
</div>

<div class="func_spread"></div>


<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title" id="IPv6TitleInfoBar">
<tr><td class="width_per100" BindText="bbsp_inv6info"></td>
  	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
</tr></table>

<table class="tabal_bg width_per100" cellspacing="1"  id="IPv6PrefixPanelRds" style="display:none">
  <tr class="head_title" id="Table_wan_ipv6Rds_head">
	<td BindText = 'bbsp_linkstate_rds'></td>
	<td BindText = 'bbsp_ipmode'></td>
	<td BindText = 'bbsp_prefixmaskmode'></td>
	<td BindText = 'bbsp_ip'></td>
	<td BindText = 'bbsp_ipstate'></td>
  </tr>
  <script type="text/javascript" language="javascript">
function DrawIPv6RdsTable() {
    var domString = "";
    for (var i = 0;i < GetWanList().length;i++) {
        var CurrentWan = GetWanList()[i];

        if (CurrentWan.IPv6Enable != "1") {
            continue;
        }

        IPv6WanRdsCount++;

        var ipv6Wan = GetIPv6WanInfo(CurrentWan.MacId);
        if (ipv6Wan == null) {
            continue;
        }

        domString += ('<tr id="ipv6recordRds_' + i + '"  class="tabal_01" align="center">');
        domString += ('<td>'+ChangeLanguageWanStatus(ipv6Wan.ConnectionStatus)+'</td>');

        var PrefixAcquire = GetIPv6PrefixAcquireInfo(CurrentWan.domain);
        var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
        var AddressList = GetIPv6AddressList(CurrentWan.MacId);
        PrefixAcquire = ((PrefixAcquire==null) ? '' : PrefixAcquire.Origin);
        PrefixAcquire = (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) ? '--' : PrefixAcquire;

        var AcquireHtml = "";
        var AddressHtml = "";
        var AddressStatusHtml = "";
        for (var m = 0; m < AddressList.length; m++) {
            AcquireHtml += (AddressList[m].Origin == ""?AddressAcquire.Origin:AddressList[m].Origin) +"<br>";
            if (CurrentWan.Enable == "1") {
                AddressHtml += AddressList[m].IPAddress+"<br>";
                AddressStatusHtml += AddressList[m].IPAddressStatus +"<br>";
            }
        }

        if ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) || (0 == AddressList.length)) {
            AcquireHtml = "--<br>";
            AddressHtml = "--<br>";
            AddressStatusHtml = "--<br>";
        }

        domString += ('<td>'+AcquireHtml+'</td>');
        domString += ('<td>'+PrefixAcquire+'</td>');
        domString += ('<td>'+AddressHtml+'</td>');
        domString += ('<td>'+AddressStatusHtml+'</td>');

        domString += ('</tr>');
    }

    if(IPv6WanRdsCount == 0) {
        domString += ("<tr class= \"tabal_01\" align=\"center\">");
        domString += ('<td >'+'--'+'</td>');
        domString += ('<td >'+'--'+'</td>');
        domString += ('<td >'+'--'+'</td>');
        domString += ('<td >'+'--'+'</td>');
        domString += ('<td >'+'--'+'</td>');
        domString += ("</tr>");
    }

    return domString;
}
$("#Table_wan_ipv6Rds_head").after(DrawIPv6RdsTable());
</script>
</table>
<table class="tabal_bg width_per100" cellspacing="1"  id="IPv6PrefixPanel">
  <tr class="head_title" id="Table_wan_ipv6_head">
	<td BindText = 'bbsp_wanname'></td>
	<td BindText = 'bbsp_linkstate'></td>
	<td BindText = 'bbsp_prefixmask'></td>
	<script type="text/javascript" language="javascript">
	if (!IsSonetUser() && (isNewMegacable != 1)) {
		document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_ip']+'</td>');
	}
	if (!IsTelecentroUser()) {
		if(false == IsSonetUser() && false == IsPtvdfUser() && (isNewMegacable != 1)) {
			document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_vlanpri']+'</td>');
		}
		document.write('<td '+ bottomBorderClass(true) +'>'+waninfo_language['bbsp_con']+'</td>');
	}

	if('GLOBE2' == curCfgMode.toUpperCase() || 'GLOBE' == curCfgMode.toUpperCase()) {
		document.write('<td>'+waninfo_language['bbsp_wandialcode']+'</td>');
	}
	</script>
  </tr>
<script type="text/javascript" language="javascript">
function DrawIPv6Table() {
    var domString = "";
    for (var i = 0;i < GetWanList().length;i++) {
        var CurrentWan = GetWanList()[i];

        if (CurrentWan.IPv6Enable != "1") {
            continue;
        }
        if (curCfgMode.toUpperCase() == "TRIPLETAP" || curCfgMode.toUpperCase() == "TRIPLETAPNOGM" || curCfgMode.toUpperCase() == "TRIPLETAP6" || curCfgMode.toUpperCase() == "TRIPLETAP6PAIR") {
            if (CurrentWan.domain.indexOf(8) > -1) {
                continue;
            }
        }
        if ((curCfgMode.toUpperCase() == "RDSAP") && (IsAdminUser() == false) && (CurrentWan.Name.toUpperCase().indexOf("TR069") >= 0)) {
            continue;
        }
        IPv6WanCount++;

        var ipv6Wan = GetIPv6WanInfo(CurrentWan.MacId);
        if (ipv6Wan == null) {
            continue;
        }

        domString += ('<tr id="ipv6record_' + i + '" onclick="selectLineipv6(this.id);" class="tabal_01" align="center">');
        var idPrefix = getElementId(domainTowanname(CurrentWan.domain));
        domString += ('<td class="restrict_dir_ltr'+ bottomBorderClass(false) +' ' + idPrefix+'_Name">'+htmlencode(CurrentWan.Name)+'</td>');
		if ((CfgModeWord.toUpperCase() == "TELECOM2") && (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0)) {
			domString += ('<td align="center" '+ bottomBorderClass(true) +'>--</td>');
		} else {
			domString += ('<td '+ bottomBorderClass(true) +'>'+ChangeLanguageWanStatus(ipv6Wan.ConnectionStatus)+'</td>');
		}
        var PrefixList = GetIPv6PrefixList(CurrentWan.MacId)
        var Prefix = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].Prefix:'') :(PrefixList[0].Prefix));
        Prefix = (CurrentWan.Enable == "1") ? Prefix : "";
        Prefix = (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) ? '--' : Prefix;
        if (ipv6Wan.ConnectionStatus.toUpperCase()=="CONNECTED") {
            if (((IsCwcGatewayUser()) && (-1 != CurrentWan.ServiceList.indexOf("VOIP"))) ||
                ((IsPOLNETIAUser()) && ((CurrentWan.ServiceList.toString().toUpperCase() == "TR069") ||
                                        (CurrentWan.ServiceList.toString().toUpperCase() == "VOIP") ||
                                        (CurrentWan.ServiceList.toString().toUpperCase() == "TR069_VOIP")))) {
                Prefix = (Prefix != '--'?'**':'--');
            }
            domString += ('<td class="restrict_dir_ltr'+ bottomBorderClass(false) +'">'+Prefix+ '</td>');
        } else {
            domString += ('<td '+ bottomBorderClass(true) +'>'+'--'+ '</td>');
        }

        var AddressHtml = "";
        var AddressList = GetIPv6AddressList(CurrentWan.MacId);
        if (isNewMegacable != 1) {
            for (var m = 0; m < AddressList.length; m++) {
                if (CurrentWan.Enable == "1") {
                    if (((IsCwcGatewayUser()) && (-1 != CurrentWan.ServiceList.indexOf("VOIP"))) ||
                        ((IsPOLNETIAUser()) && ((CurrentWan.ServiceList.toString().toUpperCase() == "TR069") ||
                                                (CurrentWan.ServiceList.toString().toUpperCase() == "VOIP") ||
                                                (CurrentWan.ServiceList.toString().toUpperCase() == "TR069_VOIP")))) {
                        AddressHtml += (AddressList[m].IPAddress == ""?"--":"**")+"<br>";
                    } else {
                        AddressHtml += (AddressList[m].IPAddress == ""?"--":AddressList[m].IPAddress)+"<br>";
                    }
                }
            }

            if (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0 || AddressList.length < 1) {
                AddressHtml = "--<br>";
            }

            if (!IsSonetUser() && (isNewMegacable != 1)) {
                domString += ('<td class="restrict_dir_ltr'+ bottomBorderClass(false) +'">'+AddressHtml+'</td>');
            }
            if (IsTelecentroUser()) {
                domString += ('</tr>');
                continue;
            }
            if (!IsSonetUser() && !IsPtvdfUser() && (isNewMegacable != 1)) {
                if ((curCfgMode.toUpperCase() == "DTURKCELL2WIFI") || (curCfgMode.toUpperCase() == 'TURKCELL2')) {
                    if (parseInt(CurrentWan.VlanId, 10) != 4095) {
                        var pri = ('Specified' == CurrentWan.PriorityPolicy) ? CurrentWan.Priority : CurrentWan.DefaultPriority ;
                        domString += ('<td>'+CurrentWan.VlanId+'/'+pri+'</td>');
                    } else {
                        domString += ('<td>'+'-/-'+'</td>');
                    }
                } else {
                    if (0 != parseInt(CurrentWan.VlanId,10)) {
                        var pri = ('Specified' == CurrentWan.PriorityPolicy) ? CurrentWan.Priority : CurrentWan.DefaultPriority ;
                        domString += ('<td '+ bottomBorderClass(true) +'>'+CurrentWan.VlanId+'/'+pri+'</td>');
                    } else {
                        domString += ('<td '+ bottomBorderClass(true) +'>'+'-/-'+'</td>');
                    }
                }
            }
        }

        if (NeedAddConnectButton(CurrentWan) == true && CurrentWan.Enable == "1") {

            var btText = CurrentWan.ConnectionControl == "1" ? waninfo_language['bbsp_discon']: waninfo_language['bbsp_con'];
            var ctrFlag = CurrentWan.ConnectionControl == "1" ? "0": "1";
            domString += ("<td align='center'><a style='color:blue' onclick = 'OnConnectionControlButton(this,"+i+","+ctrFlag+")' RecordId = '"+i+"' href='#'>"+btText+"</a></td>");
        } else {
            var innerText = waninfo_language['bbsp_AlwaysOn'];
            if (true == IsRadioWanSupported(CurrentWan)) {
                if (CurrentWan.TriggerMode == "OnDemand") {
                    innerText = waninfo_language['bbsp_needcon'];
                }
            } else {
                if (CurrentWan.ConnectionTrigger == "OnDemand") {
                    innerText = waninfo_language['bbsp_needcon'];
                } else if (CurrentWan.ConnectionTrigger == "Manual") {
                    innerText = waninfo_language['bbsp_Manual'];
                }
            }
            domString += ("<td "+ bottomBorderClass(true) +">"+innerText+"</td>");
        }

        if ('GLOBE2' == curCfgMode.toUpperCase() || 'GLOBE' == curCfgMode.toUpperCase()) {
            if ('IP_Routed' == CurrentWan.Mode) {
                if ('IPoE' == CurrentWan.EncapMode) {
                    domString += ('<td>--</td>');
                } else {
                    var lla = "";
                    var gua = "";
                    var AddressList = GetIPv6AddressList(CurrentWan.MacId);
                    for (var m = 0; m < AddressList.length; m++) {
                        if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL") {
                            gua = AddressList[m].IPAddress;
                        } else {
                            lla = AddressList[m].IPAddress;
                        }
                    }
                    var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
                    if (IsDisplayIPv6DialCode(AddressAcquire.Origin, lla, gua) == false) {
                        domString += ('<td>--</td>');
                    } else {
                        var error = GetIPv6PPPoeError(CurrentWan, lla, gua);
                        domString += ('<td>' + error + '</td>')
                    }
                }
            } else {
                domString += ('<td>--</td>');
            }
        }
        domString += ('</tr>');
    }

    if( 0 == IPv6WanCount) {
        domString += ("<tr class= \"tabal_01\" align=\"center\">");
        if (false == IsSonetUser() && false == IsPtvdfUser()) {
            domString += ('<td >'+'--'+'</td>');
        }
        if (false == IsSonetUser()) {
            domString += ('<td >'+'--'+'</td>');
        }
        domString += ('<td >'+'--'+'</td>');
        domString += ('<td >'+'--'+'</td>');
        domString += ('<td >'+'--'+'</td>');
        domString += ("</tr>");
    }

    return domString;
}
$("#Table_wan_ipv6_head").after(DrawIPv6Table());
</script>
</table>

<div  align='center' style="display:none" id="IPv6WanDetail">
<div class="list_table_spread"></div>
<form id="ipv6InformationForm" name="ipv6InformationForm">
<table id="ipv6InformationFormPanel" class="tabal_bg width_per100"  cellspacing="1">
<li id="IPv6WanDetailTitle" RealType="HorizonBar" DescRef="bbsp_wandetailinfo" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="IPv6MacAddress" RealType="HtmlText" DescRef="bbsp_wanmacaddress" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6MacAddress" InitValue="Empty"/>
<li id="IPv6Vlan" RealType="HtmlText" DescRef="bbsp_wanvlan" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6Vlan" InitValue="Empty"/>
<li id="IPv6PriorityPolicy" RealType="HtmlText" DescRef="bbsp_wanpripolicy" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PriorityPolicy" InitValue="Empty"/>
<li id="IPv6Priority" RealType="HtmlText" DescRef="bbsp_wanpriority" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6Priority" InitValue="Empty"/>
<li id="IPv6NPTv6Enable" RealType="HtmlText" DescRef="bbsp_ntpv6enable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6NPTv6Enable" InitValue="Empty"/>
<li id="V6PPPUsername" RealType="HtmlText" DescRef="" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="V6PPPPassword" RealType="HtmlText" DescRef="" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="IPv6DnsServer" RealType="HtmlText" DescRef="bbsp_wandns" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6DnsServer"  Elementclass="restrict_dir_ltr"  InitValue="Empty"/>
<li id="IPv6PriDnsServer" RealType="HtmlText" DescRef="bbsp_wanpridns" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PriDnsServer"  Elementclass="restrict_dir_ltr"  InitValue="Empty"/>
<li id="IPv6SecDnsServer" RealType="HtmlText" DescRef="bbsp_wansecdns" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6SecDnsServer"  Elementclass="restrict_dir_ltr"  InitValue="Empty"/>
<li id="IPv6Prefix" RealType="HtmlText" DescRef="bbsp_ipv6prefix" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6Prefix" Elementclass="restrict_dir_ltr" InitValue="Empty"/>
<li id="IPv6PrefixMode" RealType="HtmlText" DescRef="bbsp_ipv6prefixmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PrefixMode" InitValue="Empty"/>
<li id="IPv6PrefixPreferredTime" RealType="HtmlText" DescRef="bbsp_prefixpreferredtime" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PrefixPreferredTime" InitValue="Empty"/>
<li id="IPv6PrefixVaildTime" RealType="HtmlText" DescRef="bbsp_prefixvaildtime" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PrefixVaildTime" InitValue="Empty"/>
<li id="IPv6PrefixVaildTimeRemaining" RealType="HtmlText" DescRef="bbsp_prefixvaild_remaining" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PrefixVaildTimeRemaining" InitValue="Empty"/>
<li id="IPv6IpAddress" RealType="HtmlText" DescRef="bbsp_ipv6ipaddress" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6IpAddress" Elementclass="restrict_dir_ltr" InitValue="Empty"/>
<li id="IPv6IpAccessMode" RealType="HtmlText" DescRef="bbsp_ipacmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6IpAccessMode" InitValue="Empty"/>
<li id="Ipv6IpState" RealType="HtmlText" DescRef="bbsp_ipv6ipstate" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Ipv6IpState" InitValue="Empty"/>
<li id="IPv6PreferredTime" RealType="HtmlText" DescRef="bbsp_ippreferredtime" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6PreferredTime" InitValue="Empty"/>
<li id="IPv6VaildTime" RealType="HtmlText" DescRef="bbsp_ipvaildtime" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6VaildTime" InitValue="Empty"/>
<li id="IPv6VaildTimeRemaining" RealType="HtmlText" DescRef="bbsp_ipvaildtime_remaining" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6VaildTimeRemaining" InitValue="Empty"/>
<li id="IPv6GateWay" RealType="HtmlText" DescRef="bbsp_ipv6_default_route" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6GateWay" Elementclass="restrict_dir_ltr" InitValue="Empty"/>
<li id="IPv6DsliteAftrname" RealType="HtmlText" DescRef="bbsp_dsliteaftrname" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6DsliteAftrname" InitValue="Empty"/>
<li id="IPv6DslitePeerAddress" RealType="HtmlText" DescRef="bbsp_dslitepeeraddress" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6DslitePeerAddress" Elementclass="restrict_dir_ltr" InitValue="Empty"/>
<li id="IPv6DialCode" RealType="HtmlText" DescRef="bbsp_wandialcode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv6DialCode" InitValue="Empty"/>
<li id="V6UpTime" RealType="HtmlText" DescRef="uptime_tips" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="V6UpTime" InitValue="Empty"/>

</table>
<script>
var TableClassTwo = new stTableClass("align_left width_per30", "align_left width_per70", "ltr");
var Ipv6WanInfoFormList = new Array();
	Ipv6WanInfoFormList = HWGetLiIdListByForm("ipv6InformationForm",null);
	HWParsePageControlByID("ipv6InformationForm",TableClassTwo,waninfo_language,null);
	setNoEncodeInnerHtmlValue("V6PPPUsernameColleft", Languages['IPv4UserName']);
	setNoEncodeInnerHtmlValue("V6PPPPasswordColleft", Languages['IPv4Password']);
</script>
</form>
</div>

<div align='center' style="display:none;" id="mapInfoDiv">
    <div class="func_spread"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
        <tr><td class="width_per100"><script>document.write(maptInfo_language['map056'])</script></td></tr>
    </table>
    <table class="tabal_bg width_per100" cellspacing="1">
        <tr class="head_title"> 
            <td class="width_per5" style = "width:10%" rowspan="2"><script>document.write(maptInfo_language['map012'])</script></td>
            <td class="width_per10" style = "width:10%" rowspan="2"><script>document.write(waninfo_language['bbsp_linkstate'])</script></td>
            <td class="width_per10" style = "width:10%" rowspan="2"><script>document.write(maptInfo_language['map057'])</script></td>
            <td class="width_per20" style = "width:20%" rowspan="2"><script>document.write(maptInfo_language['map058'])</script></td>
            <td colspan="3"><script>document.write(maptInfo_language['map052'])</script></td>
        </tr>
        <tr class="head_title" id="mapInfoTable"> 
            <td><script>document.write(maptInfo_language['map007'])</script></td>
            <td><script>document.write(maptInfo_language['map008'])</script></td>
            <td><script>document.write(maptInfo_language['map009'])</script></td>
        </tr>
    </table>
</div>

<div align="center" style="display:none;" id="mapInfoDetail">
<div class="list_table_spread"></div>
<form id="mapInfoDetailForm" name="mapInfoDetailForm">
<div id="divTablemapInfoDetailForm" class="configborder">
    <table id="TablemapInfoDetailForm" width="100%" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tbody>
            <tr class="head_title">
                <td class="block_title" colspan="2"><script>document.write(maptInfo_language['map059'])</script></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map007'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="ruleIpv6"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map008'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="ruleIpv4"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map009'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="eaBitsLength"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map020'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="psIdLength"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map021'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="psIdOffset"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map022'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="psId"></td>
            </tr>
            <tr class="head_title">
                <td class="block_title" colspan="2"><script>document.write(maptInfo_language['map061'])</script></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map010'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="mapPingIPv4Addr"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map011'] + ":")</script></td>
                <td class="table_right align_left width_per70" id="mapPingIPv6Addr"></td>
            </tr>
            <tr border="1">
                <td class="table_title align_left width_per30"><script>document.write(maptInfo_language['map060'])</script></td>
                <td class="table_right align_left width_per70" id="portRanges"></td>
            </tr>
        </tbody>
    </table>
</div>
<script>
    function GetTransPort(port) {
		if (port == "") {
			return "";
		}
        return port == "Translation" ? "MAP-T" : "MAP-E";
    }
    function ChangeValueToLine(val) {
        return (val == "" || val == undefined) ? "--" : val;
    }
    function GetPsidNum(val) {
        if (val == "--") {
            return val;
        }
        if (maptableInfo !== null && maptableInfo[0] && maptableInfo[0].Status.toLowerCase() !== 'available') {
            return "--";
        }
        val = parseInt(val);
        return val == 0 ? val : val + "(0x" + val.toString(16) + ")";
    }
    
    function WanPrefixTem(domain, Prefix) {
        this.domain = domain;
        this.Prefix = Prefix;
    }

    var IPWanListTem = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayIPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_IPv6.IPv6Prefix.{i}, Prefix, WanPrefixTem);%>;
    var PPPWanListTem = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPPPWAN, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_IPv6.IPv6Prefix.{i}, Prefix, WanPrefixTem);%>;

    function GetEndUseIpv(domain) {
        if (domain == "") {
            return "";
        }
        for (var i = 0; i < IPWanListTem.length - 1; i++) {
            if (IPWanListTem[i].domain.indexOf(domain) != -1) {
                return IPWanListTem[i].Prefix;
            }
        }
        for (var i = 0; i < PPPWanListTem.length - 1; i++) {
            if (PPPWanListTem[i].domain.indexOf(domain) != -1) {
                return PPPWanListTem[i].Prefix;
            }
        }
        return ""
    }
    function GetMapInfoByDomain(domain) {
        for (var i = 0; i < maptableInfo.length - 1; i++) {
            if (maptableInfo[i].domain.indexOf(domain) != -1) {
                return maptableInfo[i];
            }
        }
        return new maptInfoArry();
    }
    function InitMapRuleInfo(id) {
        var obj = GetMapInfoByDomain(id);
        var ruleInfoTem = GetRuleByMapDomainAndStatus(id, obj.Status);
        getElementById("ruleIpv6").innerText = ChangeValueToLine(ruleInfoTem.IPv6Prefix);
        getElementById("ruleIpv4").innerText = ChangeValueToLine(ruleInfoTem.IPv4Prefix);
        getElementById("eaBitsLength").innerText = ChangeValueToLine(ruleInfoTem.EABitsLength);
        getElementById("psIdLength").innerText = ChangeValueToLine(ruleInfoTem.PSIDLength);
        getElementById("psIdOffset").innerText = ChangeValueToLine(ruleInfoTem.PSIDOffset);
        getElementById("psId").innerText = GetPsidNum(ChangeValueToLine(ruleInfoTem.PSID));
        getElementById("mapPingIPv4Addr").innerText = ChangeValueToLine(obj.MappedIPv4Address);
        getElementById("mapPingIPv6Addr").innerText = ChangeValueToLine(obj.MappedIPv6Address);
        if (obj.PortSegments == "") {
            getElementById("portRanges").innerText = ChangeValueToLine(obj.PortSegments);
        } else {
            InitPortRanges("" + obj.PortSegments);
        }
    }
    function InitPortRanges(portSegments) {
        var portRangesElem = getElementById("portRanges");
        portRangesElem.innerHTML = '';
        var strToArr = portSegments.split(",");
        var lineElemNum = (portSegments.indexOf('-') > -1) ? 6 : 11;
        var table = document.createElement("tr");
        for (var i = 0; i < strToArr.length; i++) {
            if (i % lineElemNum == 0) {
                table = document.createElement("tr");
            }
            table.style.width = '100%'
            var tds = document.createElement("td");
            tds.innerText = strToArr[i];
            if (i != strToArr.length - 1) {
                tds.innerText += ",";
            }
            tds.style.width = '10%'
            table.appendChild(tds)
            portRangesElem.appendChild(table);
        }
    }
    function GetRuleByMapDomainAndStatus(domain, status) {
        if (isSupportMapEAutoBmr === '1') {
            if (status.toLowerCase() !== 'available') {
                return new ruleInfoArry();
            }
        }
        return GetRuleByMapDomain(domain);
    }
    function GetRuleByMapDomain(domain) {
        for (var i = 0; i < ruleInfo.length - 1; i++) {
            if (ruleInfo[i].domain.indexOf(domain) != -1) {
                if (ruleInfo[i].IsBMR == 1) {
                    return ruleInfo[i];
                }
            }
        }
        return new ruleInfoArry();
    }
    function InitMapInfo() {
        if ((IsSupportMap != 1) && (IsSupportMapE != 1) && (IsSupportMapT != 1)) {
            return;
        }
        var html = "";
        if (maptableInfo.length == 1) {
            html = "<tr class='tabal_01'>" +
                    "<td class='align_center'>--</td>" +
                    "<td class='align_center'>--</td>" +
                    "<td class='align_center'>--</td>" +
                    "<td class='align_center'>--</td>" +
                    "<td class='align_center'>--</td>" +
                    "<td class='align_center'>--</td>" +
                    "<td class='align_center'>--</td>" +
                    "</tr>";
        } else {
            for (var i = 0; i < maptableInfo.length - 1; i++) {
                var ruleInfoTem = GetRuleByMapDomainAndStatus(maptableInfo[i].domain, maptableInfo[i].Status);
                html += "<tr class='tabal_01' id=" + maptableInfo[i].domain + " onclick='selectLineMap(this.id);'>" +
                        "<td class='align_center'>" + ChangeValueToLine(maptableInfo[i].Name) + "</td>" +
                        "<td class='align_center'>" + ChangeValueToLine(maptableInfo[i].Status) + "</td>" +
                        "<td class='align_center'>" + ChangeValueToLine(GetTransPort(maptableInfo[i].TransportMode)) + "</td>" +
                        "<td class='align_center'>" + ChangeValueToLine(GetEndUseIpv(maptableInfo[i].WANInterface)) + "</td>" +
                        "<td class='align_center'>" + ChangeValueToLine(ruleInfoTem.IPv6Prefix) + "</td>" +
                        "<td class='align_center'>" + ChangeValueToLine(ruleInfoTem.IPv4Prefix) + "</td>" +
                        "<td class='align_center'>" + ChangeValueToLine(ruleInfoTem.EABitsLength) + "</td>" +
                        "</tr>";
            }
        }
        return html;
    }
    $("#mapInfoTable").after(InitMapInfo());
</script>
</form>
</div>

<div class="func_spread"></div>

<div  align='center' style="display:none" id="PonPortStatistics">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
<tr><td class="width_per100" BindText="bbsp_PonPortStatistics"></td></tr></table>
<table class="tabal_bg width_per100" cellspacing="1">
  <tr>
	<td class="table_title width_per35" BindText='bbsp_RxPackets'></td>
	<td  class="table_right">
		<script language="JavaScript" type="text/javascript">
			document.write(ponPackage.PacketsReceived);
		</script>
	</td>
  </tr>
  <tr>
	<td class="table_title width_per35" BindText='bbsp_TxPackets'></td>
	<td  class="table_right">
		<script language="JavaScript" type="text/javascript">
			document.write(ponPackage.PacketsSent);
		</script>
	</td>
  </tr>
</table>
</div>
<div id="wanstatusinfo">
	<div class="title_spread"></div>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title" id="wanstatusinfo_table1">
        <tr>
            <td class="width_per100" BindText="bbsp_wanstatus"></td>
            <script>
                if (CfgModeWord.toUpperCase() == "ROSUNION" && curUserType == sysUserType) {
                    document.write(
                        '<td >' +
                            '<button onclick="clearnStatistic()" style="width: 110px;height: 25px;cursor: pointer;margin-right: 1px;">' +
                                    waninfo_language['bbsp_wanstatus_clear']
                            +'</button>' +
                        '</td>'
                    );
                }
            </script>
        </tr>
    </table>
	<table id="Wanstatus" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
		<script>
            if (rosunionGame != "1") {
                document.write('<tr class="head_title">' +
                               '<td colspan="1" rowspan="2" BindText="bbsp_waninfo_portnum"></td>' +
                               '<td colspan="1" BindText="bbsp_waninfo_portstatus"></td>');
				if (showWanstatusFlag == 1) {
					document.write('<td colspan="3" BindText="bbsp_waninfo_rx"></td>');
					document.write('<td colspan="3" BindText="bbsp_waninfo_tx"></td>');
				} else {
					document.write('<td colspan="2" BindText="bbsp_waninfo_rx"></td>');
					document.write('<td colspan="2" BindText="bbsp_waninfo_tx"></td>');
				}
				document.write('</tr>');
                document.write('<tr class="head_title">' +
                               '<td BindText="bbsp_waninfo_link"></td>' +
                               '<td BindText="bbsp_waninfo_bytes"></td>' +
                               '<td BindText="bbsp_waninfo_pkts"></td>');
				if (showWanstatusFlag == 1) {
					document.write('<td BindText="bbsp_waninfo_Bitrate"></td>');
				}
				document.write('<td BindText="bbsp_waninfo_bytes"></td>' +
                               '<td BindText="bbsp_waninfo_pkts"></td>');
				if (showWanstatusFlag == 1) {
					document.write('<td BindText="bbsp_waninfo_Bitrate"></td>');
				}
				document.write('</tr>');
            } else {
                document.write('<tr class="head_title">' +
                               '<td BindText="bbsp_waninfo_portnum" '+ bottomBorderClass(true) +'></td>' +
                               '<td BindText="bbsp_waninfo_rosgame_link" '+ bottomBorderClass(true) +'></td>' +
                               '<td BindText="bbsp_waninfo_rosgame_bytes" '+ bottomBorderClass(true) +'></td>' +
                               '<td BindText="bbsp_waninfo_rosgame_pkts" '+ bottomBorderClass(true) +'></td>' +
                               '<td BindText="bbsp_waninfo_rosgameTransmit_bytes" '+ bottomBorderClass(true) +'></td>' +
                               '<td BindText="bbsp_waninfo_rosgameTransmit_pkts" '+ bottomBorderClass(true) +'></td>' +
                               '</tr>');
            }
        </script>

	</table>
</div>
<div  align='center' style="display:none" id="WanStatusDetail">
<div class="list_table_spread"></div>
<form id="WanInformationForm" name="WanInformationForm">
<table id="WanInformationFormPanel" class="tabal_bg width_per100"  cellspacing="1">
<li id="WanStatusTitle" RealType="HorizonBar" DescRef="bbsp_wanstatusinfo" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="Name" RealType="HtmlText" DescRef="bbsp_port_wan" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Name" InitValue="Empty"/>
<li id="Status" RealType="HtmlText" DescRef="bbsp_waninfo_portstatus" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Status" InitValue="Empty"/>
<li id="WanStatusTitle" RealType="HorizonBar" DescRef="bbsp_waninfo_rx" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="BytesReceived" RealType="HtmlText" DescRef="bbsp_waninfo_bytes" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="BytesReceived" InitValue="Empty"/>
<li id="PacketsReceived" RealType="HtmlText" DescRef="bbsp_waninfo_pkts" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PacketsReceived" InitValue="Empty"/>
<li id="UnicastReceived" RealType="HtmlText" DescRef="bbsp_waninfo_unicast" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="UnicastReceived" InitValue="Empty"/>
<li id="MulticastReceived" RealType="HtmlText" DescRef="bbsp_waninfo_multicast" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="MulticastReceived" InitValue="Empty"/>
<li id="BroadcastReceived" RealType="HtmlText" DescRef="bbsp_waninfo_broadcast" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="BroadcastReceived" InitValue="Empty"/>
<script language="JavaScript" type="text/javascript">
	if (showWanstatusFlag == 1) {
		document.write('<li id="DownstreamBitrate" RealType="HtmlText" DescRef="bbsp_waninfo_Bitrate" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_DownstreamBitrate" InitValue="Empty"/>');
	}
</script>
<li id="WanStatusTitle" RealType="HorizonBar" DescRef="bbsp_waninfo_tx" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
<li id="BytesSent" RealType="HtmlText" DescRef="bbsp_waninfo_bytes" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="BytesSent" InitValue="Empty"/>
<li id="PacketsSent" RealType="HtmlText" DescRef="bbsp_waninfo_pkts" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PacketsSent" InitValue="Empty"/>
<li id="UnicastSent" RealType="HtmlText" DescRef="bbsp_waninfo_unicast" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="UnicastSent" InitValue="Empty"/>
<li id="MulticastSent" RealType="HtmlText" DescRef="bbsp_waninfo_multicast" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="MulticastSent" InitValue="Empty"/>
<li id="BroadcastSent" RealType="HtmlText" DescRef="bbsp_waninfo_broadcast" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="BroadcastSent" InitValue="Empty"/>
<script language="JavaScript" type="text/javascript">
if (showWanstatusFlag == 1) {
	document.write('<li id="UpstreamBitrate" RealType="HtmlText" DescRef="bbsp_waninfo_Bitrate" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_UpstreamBitrate" InitValue="Empty"/>');
}
</script>
</table>
<script>
var TableClassThree = new stTableClass("align_left width_per30", "align_left width_per70", "ltr");
var WanStatusInfoFormList = new Array();
	WanStatusInfoFormList = HWGetLiIdListByForm("WanInformationForm",null);
	HWParsePageControlByID("WanInformationForm",TableClassThree,waninfo_language,null);
</script>
</form>
<table>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</div>
<script>
	if (true == TELMEX)
	{
		document.write('</div>');
	}
</script>
<div style="height:20px;"></div>
<script>
	if ((GetFeatureInfo().IPv6 == "0") || (true == bin5board()) || (false == IsSupportIPv6WANInfo()))
	{
		setDisplay("IPv6TitleInfoBar", "0");
		setDisplay("IPv6PrefixPanel", "0");
	}
	if (true == TELMEX)
	{
		setDisplay("PonPortStatistics",1);
	}
	loadlanguage();
</script>
<div class="subWanListPolicyRoute subWanListIPVersion subIspWlan subDSLite subV6RDTunnel subRadioWan subWanStats subWANAccessType">
<script type="text/javascript">
  function RenderPage(event) {
      $(".tabal_01").remove();
	  if ((showWanstatusFlag == "1") && (event.type == "evtWanStats")) {
	    $(".tabal_02").remove();
	    ShowWanStatus();
	  }
      $("#Table_wan_ipv4_head").after(DrawIPv4Table());
      $("#Table_wan_ipv6Rds_head").after(DrawIPv6RdsTable());
      $("#Table_wan_ipv6_head").after(DrawIPv6Table());
      $("#mapInfoTable").after(InitMapInfo());
  }
  LazyLoad();

</script>
</div>
</body>
</html>
