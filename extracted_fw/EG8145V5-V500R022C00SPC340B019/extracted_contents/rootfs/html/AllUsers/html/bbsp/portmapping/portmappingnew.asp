<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="Javascript" src="../common/portfwdprohibit.asp"></script>
<title>Portmapping</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/portmapping/portmappingnew.cus);%>"></script>
<style>
.Select
{
	width:133px;  
}
.SelectWanName{
	width: 133px;
	direction:ltr;
}
.TextBox
{
	width:130px;  
}
.Select_2
{
	width:133px;
	margin:0px 0px 0px 4px;
}
.TextBox_2
{
	width:130px;  
}
</style>
<script language="JavaScript" type="text/javascript">
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var PublicIpFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SNAT_IPMAPPING);%>';
var WebInnerPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
var WebOuterPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenOuterPort);%>';
var telnetInnerPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_CLITelnetAccess.TelnetPort);%>';
var telnetOuterPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_CLITelnetAccess.OutTelnetPort);%>';
var portCheckPolicy = '<%HW_WEB_GetSPEC(SPEC_PORTMAPPING_CHECKPOLICY.UINT32);%>';
var WebWanDefaultPort = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_OUTPORTNUM.UINT32);%>';
var WebWanChangePort = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_OUTCHANGEPORT.UINT32);%>';
var CwmpRequestPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.ManagementServer.X_HW_Port);%>';
var WebWanPort = {defaultport:WebWanDefaultPort, newport:WebWanChangePort};

var WanIndex = -1;
var appName = navigator.appName;
var TELMEX_EN = false;  
var PORTMAPPING_PORTLIST_INST_MAX = 12;
var currentPortMappingInst = 0;
var curPortList;
var AddFlag = false;
var selctIndex = -1; 
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var PTVDFFlag = "<% HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var OperateRuleFeature = "<% HW_WEB_GetFeatureSupport(BBSP_FT_PORTMAPPING_ADMIN);%>";
var IsDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var Telmexflag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var telecomMessage = '<%WEB_GetPortmapErrorRet();%>';
var TtnetFlag = "<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>";
var isMapFlag = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_MAP);%>';
var mapEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Enable);%>';

function stDMZInfo(domain,DMZEnable)
{
	this.domain = domain;
	this.DMZEnable = DMZEnable;
}

var IpDmzInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_DMZ,DMZEnable,stDMZInfo);%>;
var PppDmzInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_DMZ,DMZEnable,stDMZInfo);%>;

function IsEqualDomain(a, b)
{
	var min_len = (a.length > b.length)?b.length : a.length;
	var _a = "";
	var _b = "";
	
	_a = a.substr(0, min_len).toLowerCase();
	_b = b.substr(0, min_len).toLowerCase();
	
	
	return (_a == _b)?true: false;
}

function PortIsUserInDMZ(domain)
{
	if(domain.indexOf("WANIPConnection") >= 0)
	{
		for (i = 0; i < IpDmzInfo.length - 1; i++)
		{	
			if (IpDmzInfo[i].DMZEnable != 1)
			{
				continue;
			}
			
			if (IsEqualDomain(IpDmzInfo[i].domain, domain))
			{
				return true;
			}
		}
	}
	else if(domain.indexOf("WANPPPConnection") >= 0)
	{
		for (i = 0; i < PppDmzInfo.length - 1; i++)
		{	
			if (PppDmzInfo[i].DMZEnable != 1)
			{
				continue;
			}
			
			if (IsEqualDomain(PppDmzInfo[i].domain, domain))
			{
				return true;
			}
		}
	}
	
    return false;
}

if ("1" == GetCfgMode().TELMEX)
{
	TELMEX_EN = true;
}
else
{
	TELMEX_EN = false;
}

var defaultWebPort = 80;
if(TELMEX_EN)
{
	WebInnerPort = WebWanDefaultPort;
	WebOuterPort = WebWanChangePort;
	
	defaultWebPort = parseInt(WebWanDefaultPort, 10);
}
var numpara = "";
if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
}

function stExtportConflitInfo(conflitstate)
{
    this.conflitstate = conflitstate;
    this.freeport     = new Array(0);
} 

function stNoteInfo(isnote, noteindex)
{
    this.isnote    = isnote;
    this.noteindex = noteindex;
    this.freeport  = new Array(0);
}

function StartFileOpt()
{
    XmlHttpSendAspFlieWithoutResponse("/asp/StartFileLoad.asp");
}

function ConflitInfoIsEqual(conflit1, conflit2, flag1, flag2)
{
    if ((flag1 == flag2)
        && ($.unique(conflit1.freeport.sort()).toString() == $.unique(conflit2.freeport.sort()).toString()))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

var LANhostIP = new Array();
var LANhostName = new Array();

LANhostIP[0] = "";
LANhostName[0] = portmapping_language['bbsp_hostName_select'];

function dhcpcnst(domain,dhcpStart,dhcpEnd,Enable)
{
    this.domain 	= domain;
    this.dhcpStart 	= dhcpStart;
	this.dhcpEnd 	= dhcpEnd;
	this.Enable 	= Enable;  
}

function dhcpmainst(domain,startip,endip)
{
	this.domain 	= domain;
	this.startip	= startip;
	this.endip		= endip;
}

function stipaddr(domain,enable,ipaddr,subnetmask)
{
	this.domain		= domain;
	this.enable		= enable;
	this.ipaddr		= ipaddr;
	this.subnetmask	= subnetmask;	
}

var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,stipaddr);%>;
var SlaveDhcpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DHCPSLVSERVER,StartIP|EndIP|DHCPEnable,dhcpcnst);%>;  

var MainDhcpRange = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,MinAddress|MaxAddress,dhcpmainst);%>;  

function GetUserDevAlias(obj)
{
    if (obj.UserDevAlias != "--")
    {
        return obj.UserDevAlias;
    }
    else if (obj.HostName != "--")
    {
    	return obj.HostName;
    }
    else
    {
        return obj.MacAddr;
    }
}
function setlanhostnameip(UserDevices)
{
	var UserDevicesnum = UserDevices.length - 1;

	for (var i = 0, j = 1; i < UserDevicesnum; i++)
	{
		if ("--" != UserDevices[i].HostName)
		{
		  	LANhostName[j] = UserDevices[i].HostName;
		  	LANhostIP[j] = UserDevices[i].IpAddr;
	    }
	    else
	    {
		  	LANhostName[j] = UserDevices[i].MacAddr;
		  	LANhostIP[j] = UserDevices[i].IpAddr;
		}

		if (IsDevTypeFlag == 1)
		{
			LANhostName[j] = GetUserDevAlias(UserDevices[i]);
		}
		
		j++;	
    } 	  
}

function HostNameChange()
{
	setText('InternalClient',LANhostIP[getSelectVal('HostName')]);
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
		b.innerHTML = portmapping_language[b.getAttribute("BindText")];
	}
}

function filterWan(WanItem)
{
    if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))) {
        return false;
    }
    if (CfgModeWord.toUpperCase() == "TRIPLETAP" || CfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || CfgModeWord.toUpperCase() == "TRIPLETAP6" || CfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
        if (WanItem.domain.indexOf(8) > -1) {
            return false;
        }
    }
    if ((GetCfgMode().DT_HUNGARY == "1") && (curUserType != sysUserType)) {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

var WanInfo = GetWanListByFilter(filterWan);


function stPortMap(domain,ProtMapEnabled,RemoteHost,RemoteHostRange,OperateRule,InClient,Description,ExternalIP)
{
    this.domain = domain;
    this.ProtMapEnabled = ProtMapEnabled;
    this.RemoteHost = RemoteHost;
	this.RemoteHostRange = RemoteHostRange;
	this.OperateRule = OperateRule;
    this.InClient = InClient;	
    this.Description = Description;
	this.ExternalIP = ExternalIP;
    var index = domain.lastIndexOf('PortMapping');
    this.Interface = domain.substr(0,index - 1);
	this.delflag = 0;
}

function IsBelongAddrPool(InternalHost)
{
	var Ipjudge1 = InternalHost.split(".");
	var Ipjudge_lan_hostip = LanIpInfos[0].ipaddr.split(".");
	var Ipjudge_main_startip = MainDhcpRange[0].startip.split(".");
	var Ipjudge_main_endip = MainDhcpRange[0].endip.split(".");	
	var Ipjudge_slave_startip = SlaveDhcpInfos[0].dhcpStart.split(".");
	var Ipjudge_slave_endip = SlaveDhcpInfos[0].dhcpEnd.split(".");

	if( (parseInt(Ipjudge1[0]) != parseInt(Ipjudge_main_startip[0])) || (parseInt(Ipjudge1[1]) != parseInt(Ipjudge_main_startip[1]) ) 
	|| (parseInt(Ipjudge1[2]) != parseInt(Ipjudge_main_startip[2]) ) || (parseInt(Ipjudge1[3]) < parseInt(Ipjudge_main_startip[3])) || (parseInt(Ipjudge1[3]) > parseInt(Ipjudge_main_endip[3])))
	{
		if(SlaveDhcpInfos[0].Enable == 1)
		{
			if((parseInt(Ipjudge1[0]) != parseInt(Ipjudge_slave_startip[0])) || (parseInt(Ipjudge1[1]) != parseInt(Ipjudge_slave_startip[1]) ) 
			|| (parseInt(Ipjudge1[2]) != parseInt(Ipjudge_slave_startip[2])) || (parseInt(Ipjudge1[3]) < parseInt(Ipjudge_slave_startip[3])) || (parseInt(Ipjudge1[3]) > parseInt(Ipjudge_slave_endip[3])))
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}
}

function FormatPortStr(port)
{
    var portList = port.split(':');
    if ((portList.length > 1) && (parseInt(portList[1], 10) == 0))
    {
        return portList[0];
    }

    return port;
}

function stPortMappingPortList(domain,Protocol,InternalPort,ExternalPort,ExternalSrcPort,flag)
{
    var portList;
    var pathString = domain.split('.');
    this.instId = 0;
    if((pathString.length > 0) && ("X_HW_Portlist" == pathString[pathString.length - 2])){
        this.instId = parseInt(pathString[pathString.length - 1], 10);;
    }
    this.domain = domain;
    this.Protocol = Protocol;
	this.flag = 0;
    
    portList = FormatPortStr(InternalPort).split(':');
    this.innerPortStart = portList[0];
    this.innerPortEnd = portList[0];
    if(portList.length > 1){
        this.innerPortEnd = portList[1];
    }
    
    portList = FormatPortStr(ExternalPort).split(':');
    this.exterPortStart = portList[0];
    this.exterPortEnd = portList[0];
    if(portList.length > 1){
        this.exterPortEnd = portList[1];
    }
    
    portList = FormatPortStr(ExternalSrcPort).split(':');
    this.exterSrcPortStart = portList[0];
    this.exterSrcPortEnd = portList[0];
    if(portList.length > 1){
        this.exterSrcPortEnd = portList[1];
    }
}
var WanIPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i}.X_HW_Portlist.{i},Protocol|InternalPort|ExternalPort|ExternalSrcPort,stPortMappingPortList);%>;
var WanPPPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i}.X_HW_Portlist.{i},Protocol|InternalPort|ExternalPort|ExternalSrcPort,stPortMappingPortList);%>;
var WanIPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i},PortMappingEnabled|RemoteHost|X_HW_RemoteHostRange|X_HW_OperateRule|InternalClient|PortMappingDescription|X_HW_ExternalIP,stPortMap);%>;
var WanPPPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i},PortMappingEnabled|RemoteHost|X_HW_RemoteHostRange|X_HW_OperateRule|InternalClient|PortMappingDescription|X_HW_ExternalIP,stPortMap);%>; 

function FindWanInfoByPortMapping(portMappingItem)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < WanInfo.length; k++ )
	{
		wandomain_len = WanInfo[k].domain.length;
		temp_domain = portMappingItem.domain.substr(0, wandomain_len);
		
		if (temp_domain == WanInfo[k].domain)
		{
			return WanInfo[k];
		}
	}
	return false;
}

function IsAllowWan(tmpWan)
{
    if (curCfgModeWord.toUpperCase() == "TMCZST") {
        if ((tmpWan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (tmpWan.Mode == 'IP_Routed') &&
            (tmpWan.IPv4Enable == '1')) {
            return true;
        }
        return false;
    }
	if((tmpWan.ServiceList != 'TR069') && (tmpWan.Mode == 'IP_Routed') && (tmpWan.IPv4Enable == '1'))
	{
		if(((GetCfgMode().PTVDF == "1") || (GetCfgMode().PTVDFB == "1")) && (curUserType == sysUserType))
		{
			return true;
		}
		else if(tmpWan.ServiceList != 'VOIP' && tmpWan.ServiceList != 'TR069_VOIP')
		{
			return true;	
		}
		else
		{
			return false;
		}
	}
	else
	{
			return false;	
	}
}

function SelectPortMappingPortList(portMappingDomain,wanPortMappingPortList)
{
    var idx;
    var parentDomain;
    var portList = new Array(0);
    
    for(var i = 0; i < wanPortMappingPortList.length-1; i++)
    {
        idx = wanPortMappingPortList[i].domain.lastIndexOf(".X_HW_Portlist");
        if(idx < 0)
        {
            return '';
        }
        parentDomain = wanPortMappingPortList[i].domain.substr(0,idx);
        if(portMappingDomain == parentDomain)
        {
            portList.push(wanPortMappingPortList[i]);
        }
    }
    return portList;
}

var PortMapping = new Array();
var Idx = 0;

for (var i = 0; i < WanIPPortMapping.length-1; i++)
{
	if(WanIPPortMapping[i].InClient=="")
	{
		continue;
	}
	if(false == FindWanInfoByPortMapping(WanIPPortMapping[i]))
	{
		continue;
	}
	var tmpWan = FindWanInfoByPortMapping(WanIPPortMapping[i]);

	   
	if(IsAllowWan(tmpWan))
	{    
	    PortMapping[Idx] = WanIPPortMapping[i];
		PortMapping[Idx].Interface = MakeWanName(tmpWan);
	    PortMapping[Idx].PortList = SelectPortMappingPortList(WanIPPortMapping[i].domain,WanIPPortMappingPortList);
		Idx ++;
	}
}
for (var j = 0; j < WanPPPPortMapping.length-1; j++,i++)
{
	if(WanPPPPortMapping[j].InClient=="")
	{
		continue;
	}
	if(false == FindWanInfoByPortMapping(WanPPPPortMapping[j]))
	{
		continue;
	}
    var tmpWan = FindWanInfoByPortMapping(WanPPPPortMapping[j]);   

    if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.ServiceList != 'VOIP'
		&& tmpWan.ServiceList != 'TR069_VOIP'
		&& tmpWan.Mode == 'IP_Routed'
		&& tmpWan.IPv4Enable == '1')
	{
		PortMapping[Idx] = WanPPPPortMapping[j];
		PortMapping[Idx].Interface = MakeWanName(tmpWan);
	    PortMapping[Idx].PortList = SelectPortMappingPortList(WanPPPPortMapping[j].domain,WanPPPPortMappingPortList);

		Idx ++;   
	}
}

if (isSupportHybrid == 1) {
    var BondingPortmapping = '';
    var BondingPortmappingPortlist = '';
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/bbsp/bonding/bondingportmappinginfo.asp",
        success : function(data) {
            BondingPortmapping = dealDataWithFun(data);
        }
    });

    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/bbsp/bonding/bondingportmappingportlistinfo.asp",
        success : function(data) {
            BondingPortmappingPortlist = dealDataWithFun(data);
        }
    });

    for (var k = 0; k < BondingPortmapping.length - 1; k++) {
        PortMapping[Idx] = BondingPortmapping[k];
        PortMapping[Idx].Interface = "Bonding";
        PortMapping[Idx].PortList = new Array(BondingPortmappingPortlist[k]);
        Idx ++;
    }
}

function MakePortMappingName(PortMappingDomain)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < WanInfo.length; k++ )
	{
		wandomain_len = WanInfo[k].domain.length;
		temp_domain = PortMappingDomain.substr(0, wandomain_len);
		if (temp_domain == WanInfo[k].domain)
		{
			return MakeWanName1(WanInfo[k]);
		}
	}
}

function FindPortMappingInfoByWan(wanIdx, pmIdx)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	wandomain_len = WanInfo[wanIdx].domain.length;
	temp_domain = PortMapping[pmIdx].domain.substr(0, wandomain_len);
	if(WanInfo[wanIdx].domain == temp_domain)
	{
		return true;
	}
	
	return false;
}

function IsMakeSpecialNote(wanObj)
{
	var portFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_INTERNET_INNER_PORT);%>";
	var serviceType = wanObj.ServiceList.toUpperCase();
	if(("1" == portFeature) && ("INTERNET" == serviceType))
	{
		return true;
	}
	return false;
}

function FindWanByDomain(domain)
{
	for(var i = 0; i < WanInfo.length; i++)
	{
		if(domain == WanInfo[i].domain)
		{
			return WanInfo[i];
		}
	}
}


function CheckConflictState(ObjPort1, ObjPort2, conflit1, conflit2)
{
    var conflitInfo = new stExtportConflitInfo();
    
    if ((conflit1 == 1) && (conflit2 == 1))
    {
        conflitInfo.conflitstate = 2;      
    }
    else if ((conflit1 == 0) && (conflit2 == 1))
    {
        conflitInfo.conflitstate = 1;
        conflitInfo.freeport.push(parseInt(ObjPort1)); 
    }
    else if ((conflit1 == 1) && (conflit2 == 0))
    {
        conflitInfo.conflitstate = 1;
        conflitInfo.freeport.push(parseInt(ObjPort2));
    }
    else
    {
        conflitInfo.conflitstate = 0;
        conflitInfo.freeport.push(parseInt(ObjPort1));
		conflitInfo.freeport.push(parseInt(ObjPort2));
    }

    return conflitInfo;
}

	
var noteresult = new Array(new stNoteInfo(0,-1), new stNoteInfo(0,-1), new stNoteInfo(0,-1));

function getNoFreePortNote()
{
	var notestring;
	
	if(TELMEX_EN)
	{
		notestring = portmapping_language['bbsp_exportconflithttp1'].replace(/8080/, WebWanPort["newport"]); 
	}
	else
	{
		notestring = portmapping_language['bbsp_exportconflithttp3'];
	}
	
	return notestring;
}

function ProductConflitNote()
{
    var notestring = '';

    var Interface = getSelectVal('PortMappingInterface');

    if (isSupportHybrid == 1) {
        if (Interface == 'Bonding') {
            return '';
        }
    }
    if (true == PortIsUserInDMZ(Interface))
    {
        return '';
    }

    if (GetFeatureInfo().httpportmode == 1 || TELMEX_EN) 
    {
        if (noteresult[0].noteindex == 1)
        {
            notestring = getNoFreePortNote();        
        }
        else if (noteresult[0].noteindex == 0)
        {
            if (($.inArray(parseInt(WebOuterPort), noteresult[0].freeport) != -1)
				&& ($.inArray(defaultWebPort, noteresult[0].freeport) == -1))
            {
                if(TELMEX_EN)
				{
					notestring = portmapping_language['bbsp_exportconflithttp1'].replace(/8080/, WebWanPort["newport"]); 
				}
				else
				{
					notestring = portmapping_language['bbsp_exportconflithttp1'].replace(/8080/, WebOuterPort); 
				}
            }
            else if ($.inArray(defaultWebPort, noteresult[0].freeport) != -1)
            {
				if(false == IsMakeSpecialNote(FindWanByDomain(Interface)))
				{
                	if(TELMEX_EN && (WebWanPort["defaultport"] != 80))
					{
						notestring = portmapping_language['bbsp_exportconflithttp1'].replace(/8080/, WebWanPort["defaultport"]);
					}
					else
					{
						notestring = portmapping_language['bbsp_exportconflithttp2'];
					}
				}
				else
				{
					if($.inArray(parseInt(WebOuterPort), noteresult[0].freeport) != -1)
					{
						notestring = portmapping_language['bbsp_exportconflithttp1'].replace(/8080/, WebOuterPort);
					}
					else
					{
						notestring = getNoFreePortNote();        
					}
				}
            }
			else if(($.inArray(parseInt(WebOuterPort), noteresult[0].freeport) == -1) && ($.inArray(defaultWebPort, noteresult[0].freeport) == -1))
			{
				notestring = getNoFreePortNote();        
			}
            else
            {
                notestring = portmapping_language['bbsp_exportconflithttp4'];
            }           
        }
    }
	
    if (GetFeatureInfo().telportmode == 1)
    {
        if (noteresult[1].noteindex == 1)
        {
            notestring += portmapping_language['bbsp_exportconflittel3'];        
        }
        else if (noteresult[1].noteindex == 0)
        {
            if (($.inArray(parseInt(telnetOuterPort), noteresult[1].freeport) != -1)
				&& ($.inArray(23, noteresult[1].freeport) == -1))
            {
                notestring += portmapping_language['bbsp_exportconflittel1'].replace(/2323/, telnetOuterPort); 
            }
            else if ($.inArray(23, noteresult[1].freeport) != -1)
            {
                if(false == IsMakeSpecialNote(FindWanByDomain(Interface)))
				{
					notestring += portmapping_language['bbsp_exportconflittel2'];
				}
				else
				{
					if($.inArray(parseInt(WebOuterPort), noteresult[1].freeport) != -1)
					{
						notestring += portmapping_language['bbsp_exportconflittel1'].replace(/2323/, telnetOuterPort); 
					}
					else
					{
						notestring += portmapping_language['bbsp_exportconflittel3'];
					}
				} 
            }
			else if(($.inArray(parseInt(WebOuterPort), noteresult[1].freeport) == -1) && ($.inArray(23, noteresult[1].freeport) == -1))
			{
				notestring = portmapping_language['bbsp_exportconflittel3'];
			}
            else
            {
                notestring += portmapping_language['bbsp_exportconflittel4'];
            }           
        } 
    }

    return notestring;
}
    

function checkOperateRule(OperateRule)
{
	var flag = false;
	if ('' == OperateRule)
	{
		flag = true;
	}
	else
	{
		if (curUserType == sysUserType)
		{
			flag = true;
		}
		else
		{
			if ('0' == OperateRule)
			{
				flag = true;
			}
			else
			{
				AlertEx(portmapping_language['bbsp_OperateRuleError']);
				flag = false;
			}
		}
	}
	return flag;
}

function GetAjaxRet(Result)
{
    var i = 0;
	var error_index = 'portmapping_paraerror';
	var errorCodeArray = new Array('0xf734b001',
                                   '0xf734b002',
                                   '0xf734b003',
                                   '0xf734b004',
                                   '0xf734b005',
                                   '0xf7307022',
                                   '0xf732c007',
                                   '0xf732c008',
                                   '0xf732c009',
                                   '0xf732c010',
                                   '0xf732c011',
                                   '0xf732c012',
                                   '0xf732c013',
                                   '0xf732c014');

    var errorstring = new Array('inner_port_conflict',
                                'portmapping_conflict',
                                'porttrigger_conflict',
                                'voip_port_conflict',
                                'ftp_port_conflict',
                                'portmapping_ipinvalid',
                                'http_telecom_portConflict_8080_Exit',
                                'ssh_telecom_portConflict_2222_Exit',
                                'telnet_telecom_portConflict_2323_Exit',
                                'ftp_telecom_portConflict_2121_Exit',
                                'http_telecom_portConflict_8080',
                                'ssh_telecom_portConflict_2222',
                                'telnet_telecom_portConflict_2323',
                                'ftp_telecom_portConflict_2121');
    if (Telmexflag == '1')
    {
        errorstring[0] = 'inner_port_conflict_telmex';
    }
	if(Result == '{ "result": 0 }')
	{
        if (curCfgModeWord.toUpperCase() != "TELECOM2") {
            window.location.replace("portmappingnew.asp");
            return true;
        }
	}
	else 
	{	
	    for(i = 0; ; i++)
		{
			if (Result.split(":")[i].toString().indexOf("error") >= 0 )
			{
				break;
			}
		}
		
		var sub = Result.split(":")[i + 1];		
		var errorcode = sub.substring(2, 12);
		for(i = 0; i < errorCodeArray.length; i++)
		{
			if (errorCodeArray[i] == errorcode)
			{
				error_index = errorstring[i];
				break;
			}
		}
		AlertEx(portmapping_language[error_index]);
		setDisable('btnApply_ex',0);	
		setDisable('cancelValue',0);
	}
}


function TELECOM_alertMessage()
{
    if (!document.getElementById("ExternalStartPortId_1")) {
        window.location.href = "/html/bbsp/portmapping/portmappingnew.asp";
    }
    var errorArray = new Array('0xf732c003',
                                '0xf732c004',
                                '0xf732c005',
                                '0xf732c006',
                                '0xf732c007',
                                '0xf732c008',
                                '0xf732c009',
                                '0xf732c010',
                                '0xf732c011',
                                '0xf732c012',
                                '0xf732c013',
                                '0xf732c014',
                                '0xf732c015',
                                '0xf732c016',
                                '0xf732c017',
                                '0xf732c018');

	var errorArrayStr = new Array('http_telecom_portConflict_80',
                                'ssh_telecom_portConflict_22',
                                'telnet_telecom_portConflict_23',
                                'ftp_telecom_portConflict_21',
                                'http_telecom_portConflict_8080_Exit',
                                'ssh_telecom_portConflict_2222_Exit',
                                'telnet_telecom_portConflict_2323_Exit',
                                'ftp_telecom_portConflict_2121_Exit',
                                'http_telecom_portConflict_8080',
                                'ssh_telecom_portConflict_2222',
                                'telnet_telecom_portConflict_2323',
                                'ftp_telecom_portConflict_2121',
                                'http_telecom_portRestoreTo80',
                                'ssh_telecom_portRestoreTo22',
                                'telnet_telecom_portRestoreTo23',
								'ftp_telecom_portRestoreTo21');
    
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/html/bbsp/common/portmappingerror.asp',
        success : function(data) {
            telecomMessage = data;
        }
    });

	if (checkErrorCode(telecomMessage)) {
		var errorIndex = "";
		for (var i = 0; i < errorArray.length; i++) {
			if (telecomMessage == errorArray[i]) {
				errorIndex = errorArrayStr[i];
				break;
			}
		}
		AlertEx(portmapping_language[errorIndex]);
    }
    
    window.location.href = "/html/bbsp/portmapping/portmappingnew.asp";
}

function checkErrorCode(errorCode)
{
    var telkomErrorArray = new Array('0xf732c003',
                                     '0xf732c004',
                                     '0xf732c005',
                                     '0xf732c006',
                                     '0xf732c007',
                                     '0xf732c008',
                                     '0xf732c009',
                                     '0xf732c010',
                                     '0xf732c011',
                                     '0xf732c012',
                                     '0xf732c013',
                                     '0xf732c014',
                                     '0xf732c015',
                                     '0xf732c016',
                                     '0xf732c017',
                                     '0xf732c018');

    for (var i = 0; i < telkomErrorArray.length; i++) {
        if (errorCode == telkomErrorArray[i]) {
            return true;
        }
    }

    return false;
}

function Submitportmap(type)
{
	var Interface = getSelectVal('PortMappingInterface');
	var url;
    var portListUrl = '';
    var postUrlPrefix = 'GROUP_a_x';
	var SubmitData = '';

	if (CheckForm(type) != true)
	{
        setDisable('btnApply_ex',0);    
        setDisable('cancelValue',0);        
		return;
	}
	setDisable('btnApply_ex',1);	
    setDisable('cancelValue',1);
	if (true == AddFlag)
	{
		postUrlPrefix = 'GROUP_a_x';
	}
	else
	{
		postUrlPrefix = 'x';
	}
	SubmitData = postUrlPrefix + '.PortMappingEnabled=' + getCheckVal('PortMappingEnable');
	SubmitData += '&'+ postUrlPrefix + '.PortMappingDescription=' + encodeURIComponent(getValue('PortMappingDescription'));
	SubmitData += '&'+ postUrlPrefix + '.InternalClient=' + encodeURIComponent(getValue('InternalClient'));
	SubmitData += '&'+ postUrlPrefix + '.RemoteHost=' + encodeURIComponent(getValue('RemoteHost'));
	SubmitData += '&'+ postUrlPrefix + '.X_HW_RemoteHostRange=' + encodeURIComponent(getValue('RemoteHostRange'));
	
	if (PublicIpFlag == 1)
	{
		SubmitData += '&'+ postUrlPrefix + '.X_HW_ExternalIP=' + encodeURIComponent(getValue('PublicIP'));
	}
	
	if ( true == AddFlag )
	{
		if ("1" == OperateRuleFeature)
		{
			SubmitData += '&'+ postUrlPrefix + '.X_HW_OperateRule=' + '';			
		}
        if ((isSupportHybrid == 1) && (Interface == 'Bonding')) {
            var bondPortList = GetCurrentPortList().getCurrPortList();
            if (bondPortList.length >= 1) {
                SubmitData += '&'+ postUrlPrefix + '.PortMappingProtocol=' + bondPortList[0].Protocol;
                SubmitData += '&'+ postUrlPrefix + '.InternalPort=' + bondPortList[0].innerPortStart;
                SubmitData += '&'+ postUrlPrefix + '.X_HW_InternalEndPort=' + bondPortList[0].innerPortEnd;
                SubmitData += '&'+ postUrlPrefix + '.ExternalPort=' + bondPortList[0].exterPortStart;
                SubmitData += '&'+ postUrlPrefix + '.ExternalPortEndRange=' + bondPortList[0].exterPortEnd;
                SubmitData += '&'+ postUrlPrefix + '.X_HW_ExternalSrcPort=' + bondPortList[0].exterSrcPortStart;
                SubmitData += '&'+ postUrlPrefix + '.X_HW_ExternalSrcEndPort=' + bondPortList[0].exterSrcPortEnd;
            }
            url = "addcfgajax.cgi?" + postUrlPrefix + '=' + 'InternetGatewayDevice.Services.X_HW_Bonding.PortMapping';	
        } else {
            portListUrl = GetPortListUrl(postUrlPrefix,GetCurrentPortList().getCurrPortList());
            SubmitData += GetPortListSubData(postUrlPrefix,GetCurrentPortList().getCurrPortList());
            url = "addcfgajax.cgi?" + postUrlPrefix + '=' + Interface + ".PortMapping";	
        }
	}
	else
	{
        if ((isSupportHybrid == 1) && (Interface == 'Bonding')) {
            var bondPortList = GetCurrentPortList().getCurrPortList();
            if (bondPortList.length >= 1) {
                SubmitData += '&'+ postUrlPrefix + '.PortMappingProtocol=' + bondPortList[0].Protocol;
                SubmitData += '&'+ postUrlPrefix + '.InternalPort=' + bondPortList[0].innerPortStart;
                SubmitData += '&'+ postUrlPrefix + '.X_HW_InternalEndPort=' + bondPortList[0].innerPortEnd;
                SubmitData += '&'+ postUrlPrefix + '.ExternalPort=' + bondPortList[0].exterPortStart;
                SubmitData += '&'+ postUrlPrefix + '.ExternalPortEndRange=' + bondPortList[0].exterPortEnd;
                SubmitData += '&'+ postUrlPrefix + '.X_HW_ExternalSrcPort=' + bondPortList[0].exterSrcPortStart;
                SubmitData += '&'+ postUrlPrefix + '.X_HW_ExternalSrcEndPort=' + bondPortList[0].exterSrcPortEnd;
            }
        } else {
            portListUrl = GetPortListUrl(PortMapping[selctIndex].domain,GetCurrentPortList().getCurrPortList());
            SubmitData += GetPortListSubData(PortMapping[selctIndex].domain,GetCurrentPortList().getCurrPortList());
        }
		url = "complexajax.cgi?" + postUrlPrefix + '=' + PortMapping[selctIndex].domain;
	}
	url += portListUrl;
	if(portListUrl.length > 512){
	    url += "&RequestFile=html/bbsp/portmapping/portmapping.asp";
	}else{
	    url += "&RequestFile=html/bbsp/portmapping/portmappingnew.asp";
	}
	SubmitData += '&'+ 'x.X_HW_Token=' + getValue('onttoken');
	var Result = null;
	$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : url,
			data: SubmitData,
			success : function(data) {
				Result = hexDecode(data);
			}
		}); 
	if (curCfgModeWord.toUpperCase() == "TELECOM2") {
		GetAjaxRet(Result);
		TELECOM_alertMessage();
	} else {
		return GetAjaxRet(Result);
	}

}

function AutoCompleteFillUp()
{

	if (true == TELMEX_EN && getElement("radiosrv")[1].checked == true && getValue("PortMappingDescription") == "")
	{
		var srvname = getValue("appTempOptionsSelectId");
		var endCh = srvname.indexOf('(');
		if(endCh > 0)
		{
		    srvname = srvname.substr(0,endCh);
		}
		var splitdata = srvname.split(' ');
		var newsrvname = '';
		for (var i = 0; i < splitdata.length; i++)
		{
			newsrvname += splitdata[i];
		}
		newsrvname += '_app';
		setText("PortMappingDescription",newsrvname);
	}
}
function CheckForm(type)
{
    AutoCompleteFillUp();
    switch (type)
    {
       case 3:
          return CheckPortMappingCfg();
          break;
    }
	
	return true;
}

function externalPortRepeatChk(currentWanIdx,curPortListRec)
{
    var currentInterface = MakeWanName1(WanInfo[currentWanIdx]);
    var repeateFound = false;
    var errorPort;   
    

    for(var inst = 0; inst < curPortListRec.length; inst++)
    {
        var curProto = curPortListRec[inst].Protocol;
        var curStartPort = parseInt(curPortListRec[inst].exterPortStart,10);
        var curEndPort = parseInt(curPortListRec[inst].exterPortEnd,10);
        if(true == repeateFound)
        {
            break;
        }
        for(var i = 0; i < curPortListRec.length; i++)
        {
            if(i == inst)
            {
                continue;
            }
            var compareProto = curPortListRec[i].Protocol;
	        var compareStartPort = parseInt(curPortListRec[i].exterPortStart,10);
	        var compareEndPort = parseInt(curPortListRec[i].exterPortEnd,10);
	        
    		if( ( -1 == compareProto.indexOf(curProto)) && (-1 == curProto.indexOf(compareProto)))
    		{   

    			continue;
    		}

    		if( (curStartPort >= compareStartPort) && (curStartPort <= compareEndPort) )
    		{
    		    errorPort = curStartPort;
    		    repeateFound = true;
    		    break;
    		}

    		if( (curEndPort >= compareStartPort) && (curEndPort <= compareEndPort) )
    		{
    		    errorPort = curEndPort;
    		    repeateFound = true;
    		    break;
    		}

    		if( (curStartPort < compareStartPort) && (curEndPort > compareEndPort) )
    		{
    		    errorPort = curStartPort;
    		    repeateFound = true;
    		    break;
    		}
            
        }
    }
    
    if(true != repeateFound && (portCheckPolicy == "1"))
    {
        for(var inst = 0; inst < curPortListRec.length; inst++)
        {
            var curProto = curPortListRec[inst].Protocol;
            var curStartPort = parseInt(curPortListRec[inst].exterPortStart,10);
            var curEndPort = parseInt(curPortListRec[inst].exterPortEnd,10);
            
            if(true == repeateFound)
            {
                break;
            }
            
        	for(var i = 0 ;i < PortMapping.length; i++)
        	{
                if(true == repeateFound)
                {
                    break;
                }
        	    if((currentInterface != PortMapping[i].Interface) || (selctIndex == i))
        	    {
        	        continue;
        	    }
        	    for(var j = 0; j < PortMapping[i].PortList.length; j++)
        	    {          	    
                    var compareProto = PortMapping[i].PortList[j].Protocol;
        	        var compareStartPort = parseInt(PortMapping[i].PortList[j].exterPortStart,10);
        	        var compareEndPort = parseInt(PortMapping[i].PortList[j].exterPortEnd,10);
        	        
            		if(((compareProto.indexOf(curProto)==-1) && (curProto.indexOf(compareProto) == -1)))
            		{   
            			continue;
            		}
            		if( (curStartPort >= compareStartPort) && (curStartPort <= compareEndPort) )
            		{
            		    errorPort = curStartPort;
            		    repeateFound = true;
            		    break;
            		}
            		if( (curEndPort >= compareStartPort) && (curEndPort <= compareEndPort) )
            		{
            		    errorPort = curEndPort;
            		    repeateFound = true;
            		    break;
            		}
            		if( (curStartPort < compareStartPort) && (curEndPort > compareEndPort) )
            		{
            		    errorPort = curStartPort;
            		    repeateFound = true;
            		    break;
            		}
        	    }
        	}
        }   
    }
	
	if(true == repeateFound)
	{
	    AlertEx(portmapping_language['bbsp_extportinvalid'] + "(" + errorPort + ")");
	    return false;
	}
	return true;
}

function PortListCheck()
{   
    var newPortListRec = GetCurrentPortList().getCurrPortList()
    var dev = domainTowanname(getSelectVal('PortMappingInterface'));
    


    for(var i = 0; i < newPortListRec.length; i++)
    {
        var modfiyFound = false;
        for(var j = 0; j < oldPortListRec.length; j++)
        {
            if(newPortListRec[i].instId == oldPortListRec[j].instId)
            {
                modfiyFound = true;
                break;
            }
        }
    }
    
    return false;
}

function portValueValidChk(curPortListRec)
{
    var innerStartPort = curPortListRec.innerPortStart;
    var innerEndPort = curPortListRec.innerPortEnd;
    var externalStartPort = curPortListRec.exterPortStart;
    var externalEndPort = curPortListRec.exterPortEnd;
    var externalSrcStartPort = curPortListRec.exterSrcPortStart;
    var externalSrcEndPort = curPortListRec.exterSrcPortEnd;
	var portNum = [21,990,6050,2323,80,443,546,68];	
	
	if ((PTVDFFlag == 1) && (curUserType == 1))
	{
		if (externalStartPort == "")
		{
			AlertEx(portmapping_language['bbsp_extstartportisreq']);
			return false;
		}
		else if (externalEndPort == "")
		{
			AlertEx(portmapping_language['bbsp_extendportisreq']);
			return false;
		}
		else if (externalStartPort.charAt(0) == "0")
		{
			AlertEx(portmapping_language['bbsp_extstartport'] +  externalStartPort + portmapping_language['bbsp_invalid']);
			return false;
		}
		else if (externalEndPort.charAt(0) == "0")
		{
			AlertEx(portmapping_language['bbsp_extendport'] +  externalEndPort + portmapping_language['bbsp_invalid']);
			return false;
		}
	}
	
    if (innerStartPort == "")
    {
        AlertEx(portmapping_language['bbsp_intstartportisreq']);
        return false;
    }
	else if ((innerStartPort.charAt(0) == "0") || (isValidPort(innerStartPort) == false))
	{
	    AlertEx(portmapping_language['bbsp_intstartport'] +  innerStartPort + portmapping_language['bbsp_invalid']);
        return false;
	}

    if ((innerEndPort != "") && (isValidPort2(innerEndPort) == false))
    {
        AlertEx(portmapping_language['bbsp_intendport'] +  innerEndPort + portmapping_language['bbsp_invalid']);
        return false;
    }
	
	if ((innerStartPort.charAt(0) != "0") && (innerEndPort.charAt(0) != "0") && (parseInt(innerEndPort,10) < parseInt(innerStartPort,10)))
    {
	    AlertEx(portmapping_language['bbsp_intstartportleqendport'] + "(" + innerStartPort + ")");
	    return false;     	
    }
	
	if ((externalStartPort == "") && (externalEndPort == ""))
	{
		if("CLARODR" == CfgModeWord.toUpperCase() || "CLARO" == CfgModeWord.toUpperCase())
		{
			AlertEx(portmapping_language['bbsp_extstartportisreq'] + '\n' + portmapping_language['bbsp_extendportisreq']);
			
			return false;
		}
		
		return true;
	}

    if (externalStartPort == "")
    {
        AlertEx(portmapping_language['bbsp_extstartportisreq']);
        return false;
    }
	else if ((1 != externalStartPort.length) && (isValidPort2(externalStartPort) == false))
	{
	    AlertEx(portmapping_language['bbsp_extstartport'] +  externalStartPort + portmapping_language['bbsp_invalid']);
        return false;
	}

    if (externalEndPort == "")
    {
        AlertEx(portmapping_language['bbsp_extendportisreq']);
        return false;
    }
	else if ((1 != externalEndPort.length) && (isValidPort2(externalEndPort) == false))
	{
	    AlertEx(portmapping_language['bbsp_extendport'] +  externalEndPort + portmapping_language['bbsp_invalid']);
        return false;
	}

    if ((externalStartPort.charAt(0) != "0") && (externalEndPort.charAt(0) != "0") && (parseInt(externalEndPort,10) < parseInt(externalStartPort,10)))
    {
	    AlertEx(portmapping_language['bbsp_extstartportleqendport'] + "(" + externalStartPort + ")");
	    return false;     	
    }

    if (TtnetFlag === '1') {
        if ((parseInt(externalStartPort,10) === parseInt(CwmpRequestPort,10)) || (parseInt(externalEndPort,10) === parseInt(CwmpRequestPort,10))) {
            AlertEx(portmapping_language['bbsp_extstartportincludetr069'] + "(" + externalStartPort + ")");
            return false;
        }
    }

	if(curCfgModeWord.toUpperCase() == "DTURKCELL2WIFI")
	{
		for(var j = 0; j < portNum.length; j++)
		{
			if(portNum[j] == parseInt(externalStartPort,10) || portNum[j] == parseInt(externalEndPort,10))
			{
				if ( ConfirmEx(portmapping_language['bbsp_portconfirm']) == false )
				{
					return false;
				}
			}
		}
		
		if(3050 == parseInt(externalStartPort,10) || 3050 == parseInt(externalEndPort,10))
		{
			AlertEx(portmapping_language['bbsp_portconfirm1']);
			return false;			
		}
		
		if ((50000 <= parseInt(externalStartPort,10)) && (50020 >= parseInt(externalStartPort,10)) || (50000 <= parseInt(externalEndPort,10)) && (50020 >= parseInt(externalEndPort,10)))
		{
			if ( ConfirmEx(portmapping_language['bbsp_portconfirm']) == false )
			{
				return false;
			}
		}
		
		if ((56005 <= parseInt(externalStartPort,10)) && (56020 >= parseInt(externalStartPort,10)) || (56005 <= parseInt(externalEndPort,10)) && (56020 >= parseInt(externalEndPort,10)))
		{
			if ( ConfirmEx(portmapping_language['bbsp_portconfirm']) == false )
			{
				return false;
			}
		}
		
		if ((7070 <= parseInt(externalStartPort,10)) && (7101 >= parseInt(externalStartPort,10)) || (7070 <= parseInt(externalEndPort,10)) && (7101 >= parseInt(externalEndPort,10)))
		{
			if ( ConfirmEx(portmapping_language['bbsp_portconfirm']) == false )
			{
				return false;
			}
		}
		
	}
	
	else
	{	
		if ((7070 <= parseInt(externalStartPort,10)) && (7079 >= parseInt(externalStartPort,10)) || (7070 <= parseInt(externalEndPort,10)) && (7079 >= parseInt(externalEndPort,10)))
		{
			if ( ConfirmEx(portmapping_language['bbsp_confirm1']) == false )
			{
				return false;
			}
		}	
	}

    if (((externalSrcStartPort == "") && (externalSrcEndPort != ""))
		|| ((externalSrcStartPort != "") && (externalSrcEndPort == "")))
    {
       AlertEx(portmapping_language['bbsp_extsrcstartandendport']);
	   return false;
    }
	else if ((externalSrcStartPort != "") && (externalSrcEndPort != ""))
	{
	    if ((isValidPort2(externalSrcStartPort) == false) && (1 != externalSrcStartPort.length))
        {
            AlertEx(portmapping_language['bbsp_extsrcstartport'] + externalSrcStartPort + portmapping_language['bbsp_invalid'] );
            return false;
        }
	    if ((isValidPort2(externalSrcEndPort) == false) && (1 != externalSrcEndPort.length))
        {
            AlertEx(portmapping_language['bbsp_extsrcendport'] + externalSrcEndPort + portmapping_language['bbsp_invalid']);
            return false;
        }
	}
	if ((externalSrcStartPort.charAt(0) != "0") && (externalSrcEndPort.charAt(0) != "0") && (parseInt(externalSrcEndPort,10) < parseInt(externalSrcStartPort,10)))
    {
	    AlertEx(portmapping_language['bbsp_extsrcstartleqendport'] + "(" + externalSrcStartPort + ")");
	    return false;     	
    }
	return true;
}

function portListInstIpChk()
{
    var innerHostIp = getValue("InternalClient");
    var externalHostIp = getValue("RemoteHost");
	var externalHostRangeIp = getValue("RemoteHostRange");
	var exHostIp = '';

    if (innerHostIp == "")
    {
        AlertEx(portmapping_language['bbsp_hostipisreq']);
        return false;
    } 
	
    if (isAbcIpAddress(innerHostIp) == false)
    {
        AlertEx(portmapping_language['bbsp_hostipinvalid']);
        return false;
    }
    
	if ('PCCWHK' == CfgModeWord.toUpperCase() || 'PCCW3MAC' == CfgModeWord.toUpperCase())
	{
		if (false == IsBelongAddrPool(innerHostIp))
		{
			AlertEx(portmapping_language['bbsp_hostipoutran']);
			return false;
		}
	}

    if ((externalHostIp != "") && (isAbcIpAddress(externalHostIp) == false))
    {
		AlertEx(portmapping_language['bbsp_extsrcipstartinvalid']);
		return false;
    }
	if ((externalHostRangeIp != "") && (isAbcIpAddress(externalHostRangeIp) == false))
    {
		AlertEx(portmapping_language['bbsp_extsrcipendinvalid']);
		return false;
    }
	if ((externalHostRangeIp != "") && (IpAddress2DecNum(externalHostIp) > IpAddress2DecNum(externalHostRangeIp)))
	{
		AlertEx(portmapping_language['bbsp_extsrcipinvalid1']);
		return false;
	}
	if (externalHostIp == "" && externalHostRangeIp != "")
	{
		AlertEx(portmapping_language['bbsp_extsrcipisreq']);
		return false;
	}
	
	return true;
}

function portmappingDescpChk()
{
    var portmappingDescrip = getValue("PortMappingDescription");
    if((true == TELMEX_EN) && ("" == portmappingDescrip)){
        AlertEx(portmapping_language['bbsp_mappingisreq']);
        return false;
    }

    return true;
}

function portMappingGetValueById(sId)
{
    var item;
    if (null == (item = getElement(sId)))
    {
        return "";
    }
    return item.value;
}

function getCurEditPortListInst(editPortListRec)
{
	var CurEditPortListInst = -1;
	var curPortListRec = GetCurrentPortList().getCurrPortList();
	for(var inst = 0 ;inst < curPortListRec.length; inst++)
	{
		if ((editPortListRec.exterPortStart == curPortListRec[inst].exterPortStart)
			&& (editPortListRec.exterPortEnd == curPortListRec[inst].exterPortEnd))
		{
			CurEditPortListInst = inst;
			return CurEditPortListInst;
		}
	}
	return CurEditPortListInst;
}

function getCurDelPortListInst(exterPortStart,exterPortEnd)
{
	var CurDelPortListInst = -1;
	var PortListRec = PortMapping[selctIndex].PortList;
	for(var inst = 0 ;inst < PortListRec.length; inst++)
	{
		if ((exterPortStart == PortListRec[inst].exterPortStart)
			&& (exterPortEnd == PortListRec[inst].exterPortEnd))
		{
			CurDelPortListInst = inst;
			return CurDelPortListInst;
		}
	}
	return CurDelPortListInst;
}

function CheckPortConflictOfWan(ObjPort1, ObjPort2, wanIdx, curPortListRec, expitem, exceptCurInstFlag)
{
	var conflit1 = 0;
	var conflit2 = 0;
	var extstartport = 0;
	var extendport   = 0;
	var curstartport = 0;
    var curendport   = 0;
	var isNeedCountExpitem = false;

	if(expitem == -1)
	{
		isNeedCountExpitem = true;
	}
	
	for(var i = 0; i < PortMapping.length; i++)
	{
		if (PortMapping[i].ProtMapEnabled != 1)
		{
			if(expitem != i)
			{
				continue;
			}
		}
		if(false == FindPortMappingInfoByWan(wanIdx, i))
		{
			continue;
		}
		if(expitem == i)
		{
			if(exceptCurInstFlag != 1)
			{
				isNeedCountExpitem = true;
			}
			continue;
		}
		
		var PortListRec = PortMapping[i].PortList;
		for(var inst = 0 ;inst < PortListRec.length; inst++)
		{
			if( "UDP" == PortListRec[inst].Protocol.toUpperCase())
			{   
				continue;
			}
					
			extstartport = parseInt(PortListRec[inst].exterPortStart, 10);
			extendport   = parseInt(PortListRec[inst].exterPortEnd, 10);

			if ((ObjPort1 >= extstartport) && (ObjPort1 <= extendport))
			{
				conflit1 = 1;
			}
	
			if ((ObjPort2 >= extstartport) && (ObjPort2 <= extendport))
			{
				conflit2 = 1;
			}
			
			if ((0 == extstartport) || ("" == PortListRec[inst].exterPortStart))
			{
			    conflit1 = 1;
				conflit2 = 1;
			}     
		}	
	}
	
	if(isNeedCountExpitem)
	{
		for(var j = 0; j < curPortListRec.length; j++)
		{
			if( "UDP" == curPortListRec[j].Protocol.toUpperCase())
			{   
				continue;
			}
			
			curstartport = parseInt(curPortListRec[j].exterPortStart, 10);
			curendport   = parseInt(curPortListRec[j].exterPortEnd, 10);
			
			if ((ObjPort1 >= curstartport) && (ObjPort1 <= curendport))
			{
				conflit1 = 1;
			}
	
			if ((ObjPort2 >= curstartport) && (ObjPort2 <= curendport))
			{
				conflit2 = 1;
			}
			
			if ((0 == curstartport) || ("" == curPortListRec[j].exterPortStart))
			{
			    conflit1 = 1;
				conflit2 = 1;
			}
		}
	}

	return CheckConflictState(ObjPort1, ObjPort2, conflit1, conflit2);
}


function CheckAddModifyActionPortConflict(protocal, curPortListRec, wanIdx)
{
	var expitem = -2;
    var curconflitInfo = new stExtportConflitInfo(0);
    var lastconflitInfo = new stExtportConflitInfo(0);
    var checkinnerport   = 0;
    var checkouterport   = 0;
	var toDisableFlag = 0;
    var curmapingstate = parseInt(getCheckVal('PortMappingEnable'), 10); 
    

	if(AddFlag == true)
	{
		expitem = -1;	
		if (curmapingstate == 0)
		{
			noteresult[protocal].isnote = 0;
			noteresult[protocal].noteindex = -1;
			return;        
		}		
	}
	else
	{
		expitem = selctIndex;
		var befmapingstate = parseInt(PortMapping[selctIndex].ProtMapEnabled, 10);
		if ((curmapingstate == 0) && (befmapingstate == 0))
		{
			noteresult[protocal].isnote = 0;
			noteresult[protocal].noteindex = -1;
			return;        
		}
		
		if((curmapingstate == 0) && (befmapingstate == 1))
		{
			toDisableFlag = 1;
		}
	}
	
    if (0 == protocal)
    {
        checkinnerport = (!IsMakeSpecialNote(WanInfo[wanIdx])) ? WebInnerPort : WebOuterPort;
        checkouterport = WebOuterPort;
    }
    else
    {
        checkinnerport = (!IsMakeSpecialNote(WanInfo[wanIdx])) ? telnetInnerPort : telnetOuterPort;
        checkouterport = telnetOuterPort;
    }
	
	lastconflitInfo = CheckPortConflictOfWan(checkinnerport, checkouterport, wanIdx, curPortListRec, -2, 0);
	
	curconflitInfo = CheckPortConflictOfWan(checkinnerport, checkouterport, wanIdx, curPortListRec, expitem, toDisableFlag);
	
	if(ConflitInfoIsEqual(curconflitInfo, lastconflitInfo, curconflitInfo.conflitstate, lastconflitInfo.conflitstate))
	{
		noteresult[protocal].isnote = 0;
        noteresult[protocal].noteindex = -1;
		return;
	}
	
	
	if((curconflitInfo.conflitstate == 0) || (curconflitInfo.conflitstate == 1))
	{
		noteresult[protocal].isnote = 1;
        noteresult[protocal].noteindex = 0;
		noteresult[protocal].freeport = curconflitInfo.freeport;
		return;
	}
	else if(curconflitInfo.conflitstate == 2)
	{
		noteresult[protocal].isnote = 1;
		noteresult[protocal].noteindex = 1;
		return;
	}
	
	noteresult[protocal].isnote = 0;
    noteresult[protocal].noteindex = -1;
    return; 
}

function CheckDelActionPortConflict(protocal, curitem, wanIdx)
{
	var expitem = curitem;
    var conflitInfo = new stExtportConflitInfo(0);
    var lastconflitInfo = new stExtportConflitInfo(0);
    var checkinnerport   = 0;
    var checkouterport   = 0;
    var curmapingstate = parseInt(PortMapping[curitem].ProtMapEnabled, 10);

    if (curmapingstate == 0)
    {
        noteresult[protocal].isnote = 0;
        noteresult[protocal].noteindex = -1;
        return;        
    }

    if (0 == protocal)
    {
        checkinnerport = (!IsMakeSpecialNote(WanInfo[wanIdx])) ? WebInnerPort : WebOuterPort;
        checkouterport = WebOuterPort;
    }
    else
    {
        checkinnerport = (!IsMakeSpecialNote(WanInfo[wanIdx])) ? telnetInnerPort : telnetOuterPort;
        checkouterport = telnetOuterPort;
    }

	lastconflitInfo = CheckDelPortConflictOfWan(checkinnerport, checkouterport, wanIdx, -2);
	
	curconflitInfo = CheckDelPortConflictOfWan(checkinnerport, checkouterport, wanIdx, expitem);
	
	if(lastconflitInfo.conflitstate == 0)
	{
		noteresult[protocal].isnote = 0;
        noteresult[protocal].noteindex = -1;
		return;
	}
	else if(lastconflitInfo.conflitstate >= 1)
	{
		if(ConflitInfoIsEqual(curconflitInfo, lastconflitInfo, curconflitInfo.conflitstate, lastconflitInfo.conflitstate))
		{
			noteresult[protocal].isnote = 0;
			noteresult[protocal].noteindex = -1;
			return;
		}
		else
		{
			noteresult[protocal].isnote = 1;
			noteresult[protocal].noteindex = 0;
			noteresult[protocal].freeport = curconflitInfo.freeport;
			return;
		}
	}
	
	noteresult[protocal].isnote = 0;
    noteresult[protocal].noteindex = -1;
    return;
}

function CheckDelPortConflictOfWan(ObjPort1, ObjPort2, wanIdx, curInst)
{
	var conflit1 = 0;
	var conflit2 = 0;
	var extstartport = 0;
	var extendport   = 0;

	for(var i = 0; i < PortMapping.length; i++)
	{
		if (PortMapping[i].ProtMapEnabled != 1)
		{
			continue;
		}
		if(false == FindPortMappingInfoByWan(wanIdx, i))
		{
			continue;
		}
		if(i == curInst)
		{
			continue;
		}
		if(PortMapping[i].delflag == 1)
		{
			continue;
		}
		
		var PortListRec = PortMapping[i].PortList;
		for(var inst = 0 ;inst < PortListRec.length; inst++)
		{
            if (TELMEX_EN)
            {
                if( "UDP" == PortListRec[inst].Protocol.toUpperCase())
                {   
                    continue;
                }                                                
            }
			extstartport = parseInt(PortListRec[inst].exterPortStart, 10);
			extendport   = parseInt(PortListRec[inst].exterPortEnd, 10);

			if ((ObjPort1 >= extstartport) && (ObjPort1 <= extendport))
			{
				conflit1 = 1;
			}
	
			if ((ObjPort2 >= extstartport) && (ObjPort2 <= extendport))
			{
				conflit2 = 1;
			}
			
			if ((0 == extstartport) || ("" == PortListRec[inst].exterPortStart))
			{
			    conflit1 = 1;
				conflit2 = 1;
			}
		}	
	}

	return CheckConflictState(ObjPort1, ObjPort2, conflit1, conflit2);
}


function getPortNoteInfo(wanIdx)
{
	var curPortListRec = GetCurrentPortList().getCurrPortList();
	var notestring = '';

	CheckAddModifyActionPortConflict(0, curPortListRec, wanIdx);
	CheckAddModifyActionPortConflict(1, curPortListRec, wanIdx);  
	notestring = ProductConflitNote();

	return notestring;
}

function CheckPortMappingCfg() 
{
	var curWanInterface = getElement('PortMappingInterface');
	var selectId = 0;
	var wanIdx = 0;

    setDisable('btnApply_ex',1);    
    setDisable('cancelValue',1);
        
    if(getElement("radiosrv")[1].checked == true && getElement("appTempOptionsSelectId").selectedIndex == 0)
    {
        AlertEx(portmapping_language['bbsp_notChoiceTemplate']); 
        return false;
    }
	if ( curWanInterface.selectedIndex < 0 )
	{
		 AlertEx(portmapping_language['bbsp_creatwan']);
		 return false;
	} 

    if ((isSupportHybrid == 1) && (curWanInterface.value == 'Bonding')) {
        selectId = 0;
        wanIdx = 0;
    } else  {
        selectId = parseInt(curWanInterface.selectedIndex,10);
        wanIdx = curWanInterface.options[selectId].id.split('_')[1];
    }

	if (curWanInterface.length == 0)
	{
	    AlertEx(portmapping_language['bbsp_wanconinvalid']);
	    return false;	
	}

	if (true != portmappingDescpChk())
	{
	    return false;
	}
	
	if (PublicIpFlag == "1" && getValue("PublicIP") != '')
	{
		if (isValidIpAddress(getValue("PublicIP")) == false)
	    {
			AlertEx(portmapping_language['bbsp_publicipvolid']);
            return false;
	    }
	    if (isAbcIpAddress(getValue("PublicIP")) == false 
           || isDeIpAddress(getValue("PublicIP")) == true 
           || isBroadcastIpAddress(getValue("PublicIP")) == true 
           || isLoopIpAddress(getValue("PublicIP")) == true ) 
       {              
            AlertEx(portmapping_language['bbsp_publicipvolid']);
            return false;
       }
	}

	if (true != portListInstIpChk())
	{
	    return false;
	}

	var curPortListRec = GetCurrentPortList().getCurrPortList();
	for(var inst = 0 ;inst < curPortListRec.length; inst++)
	{
        if (true != portValueValidChk(curPortListRec[inst])){
            return false;
        }
    }

	if(portCheckPolicy == "1")
	{
		if (true != externalPortRepeatChk(wanIdx,curPortListRec)){
        	return false;
    	}
	}
	
	var notestring = getPortNoteInfo(wanIdx);
	if (notestring.length != 0)
	{
		StartFileOpt();
		AlertEx(notestring);
	}

	if ((false == AddFlag) && ('1' == OperateRuleFeature) && (false == checkOperateRule(PortMapping[selctIndex].OperateRule)))
	{
		return false;
	}

    if(true == PortListCheck())
    {
        return false;
    }
    
	return true;
}
function getPortMappingWanList()
{
    var HU='<%HW_WEB_GetFeatureSupport(BBSP_FT_HU);%>';
    $("#PortMappingInterface").empty(); 

    for (i = 0; i < WanInfo.length; i++)
    {

		if(IsAllowWan(WanInfo[i]))
        {
            if((HU==1) && (curUserType != sysUserType) && ((WanInfo[i].ServiceList == 'IPTV') || (WanInfo[i].ServiceList == 'OTHER')))
            {
                continue;
            }
            else if((curUserType != sysUserType) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY") && (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") == -1))
            {
                continue;
            }
            else
            {
                $("#PortMappingInterface").append('<option value=' + WanInfo[i].domain 
                               + ' id="wan_' + i + '" title="' + MakeWanName1(WanInfo[i]) 
                               + '">'
                               + MakeWanName1(WanInfo[i]) + '</option>');
            }
        } 
    }
    var optionInterface=getElById('PortMappingInterface');
    if( optionInterface.options.length > 0 && (optionInterface.selectedIndex >= 0) )
    {
        getElById("PortMappingInterfaceCol").title = optionInterface.options[optionInterface.selectedIndex].text;
    }
}

function getPortMappingInterneWan()
{
    $("#PortMappingInterface").empty();
    for (i = 0; i < WanInfo.length; i++)
    {
        if (WanInfo[i].Mode == 'IP_Routed' && WanInfo[i].IPv4Enable == '1')
        {
            if (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") == -1
                || IsRadioWanSupported(WanInfo[i]))
            {
                continue;
            }
            else
            {
                $("#PortMappingInterface").append('<option value=' + WanInfo[i].domain 
                               + ' id="wan_' + i + '" title="' + MakeWanName1(WanInfo[i]) 
                               + '">'
                               + MakeWanName1(WanInfo[i]) + '</option>');
            }
        }                  
    }
    
    var optionInterface=getElById('PortMappingInterface');
    if( optionInterface.options.length > 0 && (optionInterface.selectedIndex >= 0) )
    {
        getElById("PortMappingInterfaceCol").title = optionInterface.options[optionInterface.selectedIndex].text;
    }
}

function RefreshWanInterface(isAdd)
{
    if (((curUserType != sysUserType) && (IsPTVDFFlag == 1))
        || (SingtelMode == '1'))
    {
        if(isAdd==true)
        {
            getPortMappingInterneWan();
        }
        else
        {
            getPortMappingWanList();
        }
    }
}

function LoadFrame()
{
    curPortList = new PortMappingPortList("TABLE_PORTMAPPING_PORTLIST",PORTMAPPING_PORTLIST_INST_MAX);

	if(isValidIpAddress(numpara) == true)
	{
		clickAdd('portMappingInst_head');
		setText('InternalClient', numpara);
		for (var k = 0; k < LANhostIP.length; k++)
		{
			if (numpara == LANhostIP[k])
			{
				setSelect('HostName', k);
				break;
			}
		}
	}
	loadlanguage();
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
}

function ShowPortMappingInterface()
{
   var Interface = getElement('PortMappingInterface');
   
   if(Interface.options.length > 0 && (Interface.selectedIndex >= 0))
   {
   		Interface.title = Interface.options[Interface.selectedIndex].text;
   }
}


function IsRecordValid(portMappingInfo)
{
    if('PCCWHK' == CfgModeWord.toUpperCase() || 'PCCW3MAC' == CfgModeWord.toUpperCase())
    {
        var innerHostIp = portMappingInfo.InClient.split(".");
        if((innerHostIp[0] == 192) && (innerHostIp[1] == 168) && (innerHostIp[2] == 8) && (innerHostIp[3] > 127 ))
        {
            return false;
        }
    }
    return true;
}

function cleanAllPortListInstFilling()
{

    GetCurrentPortList().deleteAllPortListTblInst()
}



function GetCurrentPortList()
{
    return curPortList;
}
function PortMappingPortList(tableId,maxInst)
{   

    this.tableId = tableId;
    this.portListInstMax = maxInst;
    this.tableHandler = document.getElementById(this.tableId);
    

    this.getPortListFillUp = function (portListInst){
        var htmlLines = "";
        var tdClass = "<td class=\"table_title width_per25\"";
        var requiredTips = "<strong style=\"color:red\">*</strong>";
        var subTableStyle = "<div class=\"list_table_spread\"></div><table class=\"tabal_noborder_bg width_per100\" cellpadding=\"0\" cellspacing=\"2\" id=\"PortMappingPortListTbl_";
        
        htmlLines += subTableStyle + portListInst + "\">";
        htmlLines += "<tr>" + tdClass + ">" + portmapping_language['bbsp_protocolmh'] +"</td>";
        htmlLines += tdClass + ">" + "<select id=\"PortMappingProtocolId_" + portListInst + "\" " + " size=\"1\" style=\"width: 111px\">"
        htmlLines += "<option value=\"TCP\" selected>TCP</option>" + "<option value=\"UDP\">UDP</option>" + "<option value=\"TCP/UDP\">TCP/UDP</option></select></td>";
        
        htmlLines += tdClass + "\">" +portmapping_language['bbsp_inner_port']+ "</td>";;
        htmlLines += tdClass + ">" + "<input type=\"text\" id=\"InnerStartPortId_" + portListInst + "\" " + " size=\"5\" maxlength=\"5\">" + "--";
        htmlLines += "<input type=\"text\" id=\"InnerEndPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + requiredTips +"</td>" + "</tr>";

		if ((PTVDFFlag == 1) && (curUserType == 1))
		{
			htmlLines += tdClass + "\">" + portmapping_language['bbsp_external_port'] + "</td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"ExternalStartPortId_" + portListInst + "\" " + " size=\"5\" maxlength=\"5\">" + "--";
			htmlLines += "<input type=\"text\" id=\"ExternalEndPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + requiredTips + "</td>";
		}
		else if('CLARODR' == curCfgModeWord.toUpperCase() || "CLARO" == CfgModeWord.toUpperCase())
		{
			htmlLines += tdClass + "\">" + portmapping_language['bbsp_external_port'] + "</td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"ExternalStartPortId_" + portListInst + "\" " + " size=\"5\" maxlength=\"5\">" + "--";
			htmlLines += "<input type=\"text\" id=\"ExternalEndPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + requiredTips + "</td>";
		}
		else
		{
			htmlLines += tdClass + "\">" + portmapping_language['bbsp_external_port'] + "</td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"ExternalStartPortId_" + portListInst + "\" " + " size=\"5\" maxlength=\"5\">" + "--";
			htmlLines += "<input type=\"text\" id=\"ExternalEndPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + "</td>";
		}
       
        htmlLines += tdClass + "\">" + portmapping_language['bbsp_external_src_port'] + "</td>";
        htmlLines += tdClass + ">" + "<input type=\"text\" id=\"ExternalSrcStartPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + "--";
        htmlLines += "<input type=\"text\" id=\"ExternalSrcEndPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + "</td>" + "</tr>";
        
        htmlLines += "<tr>" + tdClass + "colspan=\"4\">";
        htmlLines += "<button id=\"portListDeleteId_" + portListInst + "\" " + "class=\"NewDelbuttoncss1\" onclick=\"DeletePortList(this);\" type=\"button\">";
        htmlLines += portmapping_language['bbsp_del'] + "</button></td></tr></table>";
        return htmlLines;
    } 
    

    this.insertPortListTblInst = function (portListInst){
        var tableHandler = this.tableHandler;
        var newRow = tableHandler.insertRow(tableHandler.rows.length);
        newRow.insertCell(0).innerHTML = this.getPortListFillUp(portListInst);
    }
    

    this.getCurrPortList = function (){
        portList = new Array(0);
        portListInst = {instId:'',Protocol:'',InternalPort:'',ExternalPort:'',ExternalSrcPort:''};
        for (var inst = 0; inst < ($("table:visible[id^='PortMappingPortListTbl_']").length);inst++) {
            var instId = $("table:visible[id^='PortMappingPortListTbl_']").get(inst).id.split('_')[1];
            portListInst = new Object;
            portListInst.instId = instId;
            portListInst.Protocol = getSelectVal("PortMappingProtocolId_" + instId);
            portListInst.innerPortStart = getValue("InnerStartPortId_" + instId);
            portListInst.innerPortEnd = getValue("InnerEndPortId_" + instId);
            portListInst.exterPortStart = getValue("ExternalStartPortId_" + instId);
            portListInst.exterPortEnd = getValue("ExternalEndPortId_" + instId);
            portListInst.exterSrcPortStart = getValue("ExternalSrcStartPortId_" + instId);
            portListInst.exterSrcPortEnd = getValue("ExternalSrcEndPortId_" + instId);
            portList.push(portListInst);
        }
        return portList;
    }
    

    this.fillUpPortListTblInst = function (portListInst,record){
    	setSelect("PortMappingProtocolId_" + portListInst,(record.Protocol).toUpperCase());
        setText("InnerStartPortId_" + portListInst,record.innerPortStart);
        setText("InnerEndPortId_" + portListInst,record.innerPortEnd);
    	setText("ExternalStartPortId_" + portListInst,record.exterPortStart);
    	setText("ExternalEndPortId_" + portListInst,record.exterPortEnd);
    	setText("ExternalSrcStartPortId_" + portListInst,record.exterSrcPortStart);
    	setText("ExternalSrcEndPortId_" + portListInst,record.exterSrcPortEnd);

    }

    this.getFreePortListInstId = function (){
        for(inst = 1; inst <= this.portListInstMax; inst++){
            var tableId = "PortMappingPortListTbl_" + inst;
            if (null == document.getElementById(tableId)){
                return inst;
            }
        }
        return -1;
    }

    this.appendPortListTblInst = function (){
        var instId = this.getFreePortListInstId();
        if( -1 != instId ){
            if (isSupportHybrid == 1) {
                if ((getSelectVal('PortMappingInterface') == 'Bonding') && (instId >= 2)) {
                    return -1;
                }
            }
            this.insertPortListTblInst(instId);
            if (arguments.length > 0) {
                this.fillUpPortListTblInst(instId,arguments[0]);
            }
        }
        return instId;
    }

    this.getExistedPortListInstList = function (){

        var portListExistedIdList = new Array(0);
        for(var inst = 0; inst < ($("table:visible[id^='PortMappingPortListTbl_']").length);inst++)
        {
            var existedId = $("table:visible[id^='PortMappingPortListTbl_']").get(i).id.split('_')[1];
            portListExistedIdList.push(existedId);
        }
        return portListExistedIdList;
    }


    this.deletePortListTblInst = function (portListInst){ 
        var  portListElem = $("table [id='PortMappingPortListTbl_" + portListInst + "']");
        if(null != portListElem){
            portListElem.parent().parent().remove();
        }
    } 
    

    this.deleteAllPortListTblInst = function (){ 
        var  portListElem = $("table [id^='PortMappingPortListTbl_']");
        if(null != portListElem){
            portListElem.parent().parent().remove();
        }
    }


    this.updatePortList = function (portList){
        this.deleteAllPortListTblInst();
        for (var inst = 0; inst < portList.length ; inst++){
            this.insertPortListTblInst(portList[inst].instId);
            this.fillUpPortListTblInst(portList[inst].instId,portList[inst]);
        }
    }
}
function UpdatePortmappingPortList(record)
{
    GetCurrentPortList().updatePortList(record.PortList);   
}

function specialProcFillUpPortList()
{
    var inPortStart;
    var inPortEnd;
    
    for(var i = 0;i < PORTMAPPING_PORTLIST_INST_MAX;i++)
    {
        inPortStart = "InnerStartPortId_" + i;
        inPortEnd = "InnerEndPortId_" + i;
        if(21 == getValue(inPortStart))
        {
            setDisable(inPortStart,1);
            setDisable(inPortEnd,1);
        }
        else
        {
            setDisable(inPortStart,0);
            setDisable(inPortEnd,0);
        }
    }
}
function fillUpPortListInst(portListInstId,portListInstInfo)
{
    var matchProtocol = "TCP";
    var inPort = portListInstInfo.innerPort;
    var exPort = portListInstInfo.externalPort;
    
    if(!(inPort.indexOf(":") > 0)){
        inPort += ":" + inPort;
    }
    if(!(exPort.indexOf(":") > 0)){
        exPort += ":" + exPort;
    }
    
    switch (portListInstInfo.proto)
    {
        case '0':
          matchProtocol = "TCP/UDP";
          break;
        case '1':
          matchProtocol = "TCP";
          break;
        case '2':
          matchProtocol = "UDP";
          break;
    }
    var thisDomain = "InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.1.WANIPConnection.1.PortMapping.X_HW_Portlist." + portListInstId;

    var appTempPortList = new stPortMappingPortList(thisDomain,matchProtocol,inPort,exPort,'');
    return appTempPortList;
}

function DeletePortList(currentPortList)
{
    var portListBeDel = currentPortList.id.split('_')[1];   
	
    GetCurrentPortList().deletePortListTblInst(portListBeDel);
}

 
function AddPortList()
{
    var wanIdx;
    
    if (-1 == GetCurrentPortList().appendPortListTblInst())
    {
        AlertEx(portmapping_language['bbsp_cannot_add_more']);
    }
}

function cVnew(name, entryNum)
{   
    var i;
    this.name = name;
    this.eNum = entryNum;
    this.e = new Array(3);
    for(var i = 1; i < 12;i++){
        this.e[i] = new Array(3);
    }
}

function iVnew(proto, innerPort, externalPort)
{
   this.proto = proto;
   this.innerPort = innerPort;
   this.externalPort = externalPort;
}

var FIRST_APP = portmapping_language['bbsp_selectdd'];
if(true == TELMEX_EN){
    var TOTAL_APP_TEMPLES = 50;
    var app_temples = new Array(TOTAL_APP_TEMPLES);
    app_temples[0] = new cVnew("AIM Talk",1);
    app_temples[0].e[0] = new iVnew("1", "5190", "5190");
    app_temples[1] = new cVnew("Apple Remote desktop",1);
    app_temples[1].e[0] = new iVnew("1","3283", "3283");
    app_temples[2] = new cVnew("XP Remote desktop",1); 
    app_temples[2].e[0] = new iVnew("1", "3389", "3389"); 
    app_temples[3] = new cVnew("BearShare",1); 
    app_temples[3].e[0] = new iVnew("1", "6346", "6346"); 
    app_temples[4] = new cVnew("BitTorrent",1); 
    app_temples[4].e[0] = new iVnew("0", "6881:6900", "6881:6900"); 
    app_temples[5] = new cVnew("IP Camera 1",1); 
    app_temples[5].e[0] = new iVnew("1", "80", "8120"); 
    app_temples[6] = new cVnew("IP Camera 2",1); 
    app_temples[6].e[0] = new iVnew("1", "80", "8121"); 
    app_temples[7] = new cVnew("IP Camera 3",1); 
    app_temples[7].e[0] = new iVnew("1", "80", "8122");
    app_temples[8] = new cVnew("IP Camera 4",1); 
    app_temples[8].e[0] = new iVnew("1", "80", "8123");
    app_temples[9] = new cVnew("Checkpoint FW1 VPN",1); 
    app_temples[9].e[0] = new iVnew("0", "259", "259");
    app_temples[10] = new cVnew("DirectX",4); 
    app_temples[10].e[0] = new iVnew("1", "2300:2400", "2300:2400");
    app_temples[10].e[1] = new iVnew("2", "2302:2400", "2302:2400");
    app_temples[10].e[2] = new iVnew("2", "6073", "6073");
    app_temples[10].e[3] = new iVnew("0", "47624", "47624");
    app_temples[11] = new cVnew("eMule",5); 
    app_temples[11].e[0] = new iVnew("1", "4662", "4662");
    app_temples[11].e[1] = new iVnew("1", "4711", "4711");
    app_temples[11].e[2] = new iVnew("1", "64583", "64583");
    app_temples[11].e[3] = new iVnew("2", "4672", "4672");
    app_temples[11].e[4] = new iVnew("2", "27673", "27673");
    app_temples[12] = new cVnew("Remote desktop",1); 
    app_temples[12].e[0] = new iVnew("1", "3389", "3389");
    app_temples[13] = new cVnew("Gnutella",1); 
    app_temples[13].e[0] = new iVnew("0", "6346:6347", "6346:6347");
    app_temples[14] = new cVnew("ICQ",1); 
    app_temples[14].e[0] = new iVnew("1", "5190", "5190");
    app_temples[15] = new cVnew("iMesh",1); 
    app_temples[15].e[0] = new iVnew("1", "1214", "1214");
    app_temples[16] = new cVnew("IRC",3); 
    app_temples[16].e[0] = new iVnew("1", "194", "194");
    app_temples[16].e[1] = new iVnew("1", "5100", "5100");
    app_temples[16].e[2] = new iVnew("1", "6665:6669", "6665:6669");
    app_temples[17] = new cVnew("iTunes",1); 
    app_temples[17].e[0] = new iVnew("0", "3689", "3689");
    app_temples[18] = new cVnew("KaZaa",1); 
    app_temples[18].e[0] = new iVnew("1", "1214", "1214");
    app_temples[19] = new cVnew("Napster",1); 
    app_temples[19].e[0] = new iVnew("0", "6699", "6699");
    app_temples[20] = new cVnew("Netmeeting",7); 
    app_temples[20].e[0] = new iVnew("1", "389", "389");
    app_temples[20].e[1] = new iVnew("1", "522", "522");
    app_temples[20].e[2] = new iVnew("1", "1023", "1023");
    app_temples[20].e[3] = new iVnew("1", "1502:1504", "1502:1504");
    app_temples[20].e[4] = new iVnew("1", "1720:1732", "1720:1732");
    app_temples[20].e[5] = new iVnew("1", "65534", "65534");
    app_temples[20].e[6] = new iVnew("2", "1024:65535", "1024:65535");
    app_temples[21] = new cVnew("OpenVPN",1); 
    app_temples[21].e[0] = new iVnew("0", "1194", "1194");
    app_temples[22] = new cVnew("pcAnywhere",1); 
    app_temples[22].e[0] = new iVnew("0", "5631:5632", "5631:5632");
    app_temples[23] = new cVnew("PlayStation",6); 
    app_temples[23].e[0] = new iVnew("1", "80", "80");
    app_temples[23].e[1] = new iVnew("1", "443", "443");
    app_temples[23].e[2] = new iVnew("1", "5223", "5223");
    app_temples[23].e[3] = new iVnew("2", "3478:3479", "3478:3479");
    app_temples[23].e[4] = new iVnew("2", "3658", "3658");
    app_temples[23].e[5] = new iVnew("0", "10070:10080", "10070:10080");
    app_temples[24] = new cVnew("PPTP",1); 
    app_temples[24].e[0] = new iVnew("1", "1723", "1723");
    app_temples[25] = new cVnew("FTP",1); 
    app_temples[25].e[0] = new iVnew("1", "21", "21");
    app_temples[26] = new cVnew("DHCPv6",1); 
    app_temples[26].e[0] = new iVnew("0", "547", "547");
    app_temples[27] = new cVnew("DNS",1); 
    app_temples[27].e[0] = new iVnew("0", "53", "53");
    app_temples[28] = new cVnew("HTTPS",1); 
    app_temples[28].e[0] = new iVnew("1", "443", "443");
    app_temples[29] = new cVnew("IMAP",4); 
    app_temples[29].e[0] = new iVnew("1", "143", "143");
    app_temples[29].e[1] = new iVnew("1", "220", "220");
    app_temples[29].e[2] = new iVnew("1", "585", "585");
    app_temples[29].e[3] = new iVnew("1", "993", "993");
    app_temples[30] = new cVnew("Lotus Notes",1); 
    app_temples[30].e[0] = new iVnew("1", "1352", "1352");
    app_temples[31] = new cVnew("MAMP",1); 
    app_temples[31].e[0] = new iVnew("1", "8888:8889", "8888:8889");
    app_temples[32] = new cVnew("MySQL",1); 
    app_temples[32].e[0] = new iVnew("0", "3306", "3306");
    app_temples[33] = new cVnew("NNTP",2); 
    app_temples[33].e[0] = new iVnew("1", "119", "119");
    app_temples[33].e[1] = new iVnew("1", "123", "123");
    app_temples[34] = new cVnew("POP3",2); 
    app_temples[34].e[0] = new iVnew("1", "110", "110");
    app_temples[34].e[1] = new iVnew("1", "995", "995");
    app_temples[35] = new cVnew("SQL",1); 
    app_temples[35].e[0] = new iVnew("1", "1433", "1433");
    app_temples[36] = new cVnew("SSH",1); 
    app_temples[36].e[0] = new iVnew("1", "22", "22");
    app_temples[37] = new cVnew("SMTP",1); 
    app_temples[37].e[0] = new iVnew("1", "25", "25");
    app_temples[38] = new cVnew("Telnet",1); 
    app_temples[38].e[0] = new iVnew("1", "23", "23");
    app_temples[39] = new cVnew("TFTP",1); 
    app_temples[39].e[0] = new iVnew("2", "69", "69");
    app_temples[40] = new cVnew("WEB",1); 
    app_temples[40].e[0] = new iVnew("1", "80", "80");
    app_temples[41] = new cVnew("Skype",3); 
    app_temples[41].e[0] = new iVnew("1", "80", "80");
    app_temples[41].e[1] = new iVnew("0", "443", "443");
    app_temples[41].e[2] = new iVnew("0", "23399", "23399");
    app_temples[42] = new cVnew("VNC",3); 
    app_temples[42].e[0] = new iVnew("1", "5500", "5500");
    app_temples[42].e[1] = new iVnew("1", "5800", "5800");
    app_temples[42].e[2] = new iVnew("1", "5900", "5900");
    app_temples[43] = new cVnew("Vuze",6); 
    app_temples[43].e[0] = new iVnew("1", "6880", "6880");
    app_temples[43].e[1] = new iVnew("1", "6969", "6969");
    app_temples[43].e[2] = new iVnew("1", "7000", "7000");
    app_temples[43].e[3] = new iVnew("1", "45100", "45100");
    app_temples[43].e[4] = new iVnew("2", "16680", "16680");
    app_temples[43].e[5] = new iVnew("2", "49001", "49001");
    app_temples[44] = new cVnew("Wii",5); 
    app_temples[44].e[0] = new iVnew("0", "80", "80");
    app_temples[44].e[1] = new iVnew("0", "443", "443");
    app_temples[44].e[2] = new iVnew("0", "28910", "28910");
    app_temples[44].e[3] = new iVnew("0", "29900", "29900");
    app_temples[44].e[4] = new iVnew("1", "29901", "29901");
    app_temples[45] = new cVnew("Windows Live Messenger",12);
    app_temples[45].e[0] = new iVnew("2", "9", "9"); 
    app_temples[45].e[1] = new iVnew("1", "80", "80");
    app_temples[45].e[2] = new iVnew("1", "443", "443");
    app_temples[45].e[3] = new iVnew("0", "1025", "1025");
    app_temples[45].e[4] = new iVnew("1", "1503", "1503");
    app_temples[45].e[5] = new iVnew("0", "1863", "1863");
    app_temples[45].e[6] = new iVnew("1", "3389", "3389");
    app_temples[45].e[7] = new iVnew("2", "5004", "5004");
    app_temples[45].e[8] = new iVnew("1", "5061", "5061");
    app_temples[45].e[9] = new iVnew("0", "6891:6901", "6891:6901");
    app_temples[45].e[10] = new iVnew("0", "7001", "7001");
    app_temples[45].e[11] = new iVnew("0", "30000:65535", "30000:65535");
    app_temples[46] = new cVnew("WinMX",2); 
    app_temples[46].e[0] = new iVnew("1", "6699", "6699");
    app_temples[46].e[1] = new iVnew("2", "6257", "6257");
    app_temples[47] = new cVnew("X Windows",1); 
    app_temples[47].e[0] = new iVnew("2", "6000", "6000");
    app_temples[48] = new cVnew("Xbox Live",5); 
    app_temples[48].e[0] = new iVnew("0", "53", "53");
    app_temples[48].e[1] = new iVnew("1", "80", "80");
	app_temples[48].e[2] = new iVnew("2", "88", "88");
    app_temples[48].e[3] = new iVnew("0", "1863", "1863");
    app_temples[48].e[4] = new iVnew("0", "3074", "3074");
    app_temples[49] = new cVnew("Yahoo Messenger",1); 
    app_temples[49].e[0] = new iVnew("1", "5050", "5050");
}else{
    if('DNZTELECOM2WIFI' == CfgModeWord.toUpperCase())
    {
        var TOTAL_APP_TEMPLES = 19;
    }
    else
    {
        var TOTAL_APP_TEMPLES = 14;
    }
    var app_temples = new Array(TOTAL_APP_TEMPLES);
    app_temples[0] = new cVnew("DNS",1); 
    app_temples[0].e[0] = new iVnew("2", "53", "53");
    app_temples[1] = new cVnew("FTP",1); 
    app_temples[1].e[0] = new iVnew("1", "21", "21");
    app_temples[2] = new cVnew("IPSEC",1); 
    app_temples[2].e[0] = new iVnew("2", "500", "500");
    app_temples[3] = new cVnew("POP3",1); 
    app_temples[3].e[0] = new iVnew("1", "110", "110");
    app_temples[4] = new cVnew("SMTP",1); 
    app_temples[4].e[0] = new iVnew("1", "25", "25");
    app_temples[5] = new cVnew("PPTP",1); 
    app_temples[5].e[0] = new iVnew("1", "1723", "1723");
    app_temples[6] = new cVnew("Real Player",1); 
    app_temples[6].e[0] = new iVnew("2", "7070", "7070");
    app_temples[7] = new cVnew("SSH",1); 
    app_temples[7].e[0] = new iVnew("1", "22", "22");
    app_temples[8] = new cVnew("HTTPS",1); 
    app_temples[8].e[0] = new iVnew("1", "443", "443");
    app_temples[9] = new cVnew("SNMP",1); 
    app_temples[9].e[0] = new iVnew("2", "161", "161");
    app_temples[10] = new cVnew("SNMP Trap",1); 
    app_temples[10].e[0] = new iVnew("2", "162", "162");
    app_temples[11] = new cVnew("Telnet",1); 
    app_temples[11].e[0] = new iVnew("1", "23", "23");
    app_temples[12] = new cVnew("TFTP",1); 
    app_temples[12].e[0] = new iVnew("2", "69", "69");
    app_temples[13] = new cVnew("WEB",1); 
    app_temples[13].e[0] = new iVnew("1", "80", "80");
    if('DNZTELECOM2WIFI' == CfgModeWord.toUpperCase())
    {
        app_temples[14] = new cVnew("H323",1); 
        app_temples[14].e[0] = new iVnew("0", "1718:1720", "1718:1720");	
        app_temples[15] = new cVnew("MSN",1); 
        app_temples[15].e[0] = new iVnew("1", "1863", "1863");
        app_temples[16] = new cVnew("AOL",1); 
        app_temples[16].e[0] = new iVnew("1", "5190", "5190");
        app_temples[17] = new cVnew("YAHOO",1); 
        app_temples[17].e[0] = new iVnew("1", "5050", "5050");
        app_temples[18] = new cVnew("ICQ",1); 
        app_temples[18].e[0] = new iVnew("1", "5190", "5190");
    }
}

function appTempSelect(sOption)
{
    var portListInstAll = 0;
    var appTempInstId = 0;
    
    cleanAllPortListInstFilling();

    with (getElement('ConfigForm')) 
    {   
        if (sOption.value == FIRST_APP) 
        {
            return;
        }
        for(var i = 0; i < TOTAL_APP_TEMPLES; i++) 
        {
            if(app_temples[i].name == sOption.value) 
            {
                portListInstAll = app_temples[i].eNum;
                appTempInstId = i;
                break;
            }
        }
        var appTempPortList = new Array(0);
        for(var i = 0; i < portListInstAll; i++)
        {
            appTempPortList.push(fillUpPortListInst(i+1,app_temples[appTempInstId].e[i]));
        }

        GetCurrentPortList().updatePortList(appTempPortList);
        
        specialProcFillUpPortList();
    } 
	
	var optionInterface=getElById('appTempOptionsSelectId');
	if( optionInterface.options.length > 0 && (optionInterface.selectedIndex >= 0) )
    {
        getElById("appTempOptionsSelectIdCol").title = optionInterface.options[optionInterface.selectedIndex].text;
    }

}
function getAnAppTempOption(optionValue,languageId)
{
    aOption = "<option value=" + "\"" + optionValue + "\" title=\"" + portmapping_language[languageId] + "\">" + portmapping_language[languageId] + "</option>"; 
    return aOption; 
}
function getAppTempsOptions()
{
    var html = "";
    
    if(true == TELMEX_EN){
        html += getAnAppTempOption("FIRST_APP","bbsp_selectdd");
        html += getAnAppTempOption("AIM Talk","bbsp_AIMTalk");
        html += getAnAppTempOption("Apple Remote desktop","bbsp_AppleRemoteDesktop");
        html += getAnAppTempOption("BearShare","bbsp_BearShare");
        html += getAnAppTempOption("BitTorrent","bbsp_BitTorrent");
        html += getAnAppTempOption("Checkpoint FW1 VPN","bbsp_CheckpointFW1VPN");
        html += getAnAppTempOption("DHCPv6","bbsp_ServerDHCPv6");
        html += getAnAppTempOption("DirectX","bbsp_DirectX");
        html += getAnAppTempOption("DNS","bbsp_ServerDNS");
        html += getAnAppTempOption("eMule","bbsp_eMule");
        html += getAnAppTempOption("FTP","bbsp_FTPServer");
        html += getAnAppTempOption("Gnutella","bbsp_Gnutella");
        html += getAnAppTempOption("HTTPS","bbsp_ServerHTTPS");
        html += getAnAppTempOption("ICQ","bbsp_ICQ");
        html += getAnAppTempOption("IMAP","bbsp_ServerIMAP");
        html += getAnAppTempOption("iMesh","bbsp_iMesh");
        html += getAnAppTempOption("IP Camera 1","bbsp_CameraIP1");
        html += getAnAppTempOption("IP Camera 2","bbsp_CameraIP2");
        html += getAnAppTempOption("IP Camera 3","bbsp_CameraIP3");
        html += getAnAppTempOption("IP Camera 4","bbsp_CameraIP4");
        html += getAnAppTempOption("IRC","bbsp_IRC");
        html += getAnAppTempOption("iTunes","bbsp_iTunes");
        html += getAnAppTempOption("KaZaa","bbsp_KaZaa");
        html += getAnAppTempOption("Lotus Notes","bbsp_ServerLotusNotes");
        html += getAnAppTempOption("MAMP","bbsp_ServerMAMP");
        html += getAnAppTempOption("MySQL","bbsp_ServerMySQL");
        html += getAnAppTempOption("Napster","bbsp_Napster");
        html += getAnAppTempOption("Netmeeting","bbsp_Netmeeting");
        html += getAnAppTempOption("NNTP","bbsp_ServerNNTP");
        html += getAnAppTempOption("OpenVPN","bbsp_OpenVPN");
        html += getAnAppTempOption("pcAnywhere","bbsp_pcAnywhere");
        html += getAnAppTempOption("PlayStation","bbsp_PlayStation");
        html += getAnAppTempOption("POP3","bbsp_ServerPOP3");
        html += getAnAppTempOption("PPTP","bbsp_PPTP");
        html += getAnAppTempOption("Remote desktop","bbsp_RemoteDesktop");
        html += getAnAppTempOption("Skype","bbsp_Skype");
        html += getAnAppTempOption("SMTP","bbsp_ServerSMTP");
        html += getAnAppTempOption("SQL","bbsp_ServerSQL");
        html += getAnAppTempOption("SSH","bbsp_ServerSSH");
        html += getAnAppTempOption("Telnet","bbsp_TelnetServer");
        html += getAnAppTempOption("TFTP","bbsp_TFTP");
        html += getAnAppTempOption("WEB","bbsp_ServerWEB");
        html += getAnAppTempOption("VNC","bbsp_VNC");
        html += getAnAppTempOption("Vuze","bbsp_Vuze");
        html += getAnAppTempOption("Wii","bbsp_Wii");
        html += getAnAppTempOption("Windows Live Messenger","bbsp_WindowsLiveMessenger");
        html += getAnAppTempOption("WinMX","bbsp_WinMX");
        html += getAnAppTempOption("XP Remote desktop","bbsp_RemoteSupportXP");
        html += getAnAppTempOption("X Windows","bbsp_XWindows");
        html += getAnAppTempOption("Xbox Live","bbsp_XboxLive");
        html += getAnAppTempOption("Yahoo Messenger","bbsp_YahooMessenger");
    }else{
        html += getAnAppTempOption("FIRST_APP","bbsp_selectdd");
        html += getAnAppTempOption("DNS","bbsp_DomainNameServer");
        html += getAnAppTempOption("FTP","bbsp_FTPServer");
        html += getAnAppTempOption("IPSEC","bbsp_IPSEC");
        html += getAnAppTempOption("POP3","bbsp_MailPOP");
        html += getAnAppTempOption("SMTP","bbsp_MailSMTP");
        html += getAnAppTempOption("PPTP","bbsp_PPTP");
        html += getAnAppTempOption("Real Player","bbsp_RealPlayer");
        html += getAnAppTempOption("SSH","bbsp_SecureShellServer");
        html += getAnAppTempOption("HTTPS","bbsp_SecureWebServer");
        html += getAnAppTempOption("SNMP","bbsp_SNMP");
        html += getAnAppTempOption("SNMP Trap","bbsp_SNMPTrap");
        html += getAnAppTempOption("Telnet","bbsp_TelnetServer");
        html += getAnAppTempOption("TFTP","bbsp_TFTP");
        html += "<option value=\"TFTP\" title=\"TFTP\">TFTP</option>";
        html += getAnAppTempOption("WEB","bbsp_WebServerHTTP");
        if('DNZTELECOM2WIFI' == CfgModeWord.toUpperCase())
        {
            html += getAnAppTempOption("H323","bbsp_H323");
            html += getAnAppTempOption("MSN","bbsp_MSN");
            html += getAnAppTempOption("AOL","bbsp_AOL");
            html += getAnAppTempOption("YAHOO","bbsp_YahooMessenger");
            html += getAnAppTempOption("ICQ","bbsp_ICQ");
        }
    }
    return html;
}
function radioClick()
{
    if(-1 != selctIndex){
        UpdatePortmappingPortList(PortMapping[selctIndex]);
    }
    
    setSelect("appTempOptionsSelectId",'FIRST_APP');
    if(true == getElement("radiosrv")[0].checked)
    {
        setDisable("appTempOptionsSelectId",1);
        setDisable('portListAddId',0);
    }
    else
    {
        cleanAllPortListInstFilling();
        setDisable("appTempOptionsSelectId",0); 
        setDisable('portListAddId',1);  
    }
}
var oldPortListRec = "";
function PortListReplicate(portListRec)
{
    oldPortListRec = portListRec;
}
function PortListCompare(srcPortList,dstPortList)
{
    if(srcPortList.Protocol != dstPortList.Protocol)
    {
        return false;
    }
    if(srcPortList.innerPortStart != dstPortList.innerPortStart)
    {
        return false;
    }
    if(srcPortList.innerPortEnd != dstPortList.innerPortEnd)
    {
        return false;
    }
    if(srcPortList.exterPortStart != dstPortList.exterPortStart)
    {
        return false;
    }
    if(srcPortList.exterPortEnd != dstPortList.exterPortEnd)
    {
        return false;
    }
    if(srcPortList.exterSrcPortStart != dstPortList.exterSrcPortStart)
    {
        return false;
    }
    if(srcPortList.exterSrcPortEnd != dstPortList.exterSrcPortEnd)
    {
        return false;
    }
    return true;
}
function GetPortListUrl(portListDomain,newPortListRec)
{
	var requestUrl = "";
	var modifyInst = new Array(0);
	var addInst = new Array(0);
	var delInst = new Array(0);
	var searchList = new Array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p');
	for(var i = 0; i < oldPortListRec.length; i++){
        var oldInstId = oldPortListRec[i].instId;
        var modfiyFound = false;
        var instBeFound = false;
        for(var j = 0; j < newPortListRec.length; j++){
            if(oldInstId == newPortListRec[j].instId){
                instBeFound = true;

                if(false == PortListCompare(oldPortListRec[i],newPortListRec[j])){
                    modfiyFound = true;
                }
                break;
            }
        }
        if(true == modfiyFound){
            modifyInst.push(newPortListRec[j]);
        }else if(true != instBeFound){
            delInst.push(oldPortListRec[i]);
        }
    }
	for(var i = 0; i < newPortListRec.length; i++){
        var newInstId = newPortListRec[i].instId;
        var modfiyFound = false;
        for(var j = 0; j < oldPortListRec.length; j++){
            if(newInstId == oldPortListRec[j].instId){
                modfiyFound = true;
                break;
            }
        }
        if(false == modfiyFound){
            addInst.push(newPortListRec[i]);
        }
    }
	for(var i = 0; i < delInst.length; i++)
    {
        var urlPrefix = "Del_d" + searchList[i];
        requestUrl += '&' + urlPrefix + '=' + portListDomain + ".X_HW_Portlist." + delInst[i].instId;
    }
	for(var i = 0; i < modifyInst.length; i++)
    {
		var urlPrefix = "m" + searchList[i];
		requestUrl += '&' + urlPrefix + '=' + portListDomain + ".X_HW_Portlist." + modifyInst[i].instId;
	}
	for(var i = 0; i < addInst.length; i++)
    {
		var urlPrefix = '';
		if (true == AddFlag)
		{
			urlPrefix = "GROUP_a_y" + searchList[i];
		}
		else
		{
			urlPrefix = "Add_a" + searchList[i];
		}
		requestUrl += '&' + urlPrefix + '=' + portListDomain + ".X_HW_Portlist";
	}
	return requestUrl;
}
function GetPortListSubData(portListDomain,newPortListRec)
{
    var modifyInst = new Array(0);
    var addInst = new Array(0);
    var delInst = new Array(0);
    var requestUrl = "";
	var SubmitData = '';
    var searchList = new Array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p');
    

    for(var i = 0; i < oldPortListRec.length; i++){
        var oldInstId = oldPortListRec[i].instId;
        var modfiyFound = false;
        var instBeFound = false;
        for(var j = 0; j < newPortListRec.length; j++){
            if(oldInstId == newPortListRec[j].instId){
                instBeFound = true;

                if(false == PortListCompare(oldPortListRec[i],newPortListRec[j])){
                    modfiyFound = true;
                }
                break;
            }
        }
        if(true == modfiyFound){
            modifyInst.push(newPortListRec[j]);
        }else if(true != instBeFound){
            delInst.push(oldPortListRec[i]);
        }
    }
                    

    for(var i = 0; i < newPortListRec.length; i++){
        var newInstId = newPortListRec[i].instId;
        var modfiyFound = false;
        for(var j = 0; j < oldPortListRec.length; j++){
            if(newInstId == oldPortListRec[j].instId){
                modfiyFound = true;
                break;
            }
        }
        if(false == modfiyFound){
            addInst.push(newPortListRec[i]);
        }
    }
    

    for(var i = 0; i < delInst.length; i++)
    {
        var urlPrefix = "Del_d" + searchList[i];
    }
    for(var i = 0; i < addInst.length; i++)
    {
		var urlPrefix = '';
		if (true == AddFlag)
		{
			urlPrefix = "GROUP_a_y" + searchList[i];
		}
		else
		{
			urlPrefix = "Add_a" + searchList[i];
		}

		SubmitData += '&'+ urlPrefix + '.Protocol=' + addInst[i].Protocol;
        if('' != addInst[i].innerPortEnd){
			SubmitData += '&'+ urlPrefix + '.InternalPort=' + addInst[i].innerPortStart + ':' + addInst[i].innerPortEnd;
        }else{
			SubmitData += '&'+ urlPrefix + '.InternalPort=' + addInst[i].innerPortStart;
        }

		SubmitData += '&'+ urlPrefix + '.ExternalPort=' + addInst[i].exterPortStart + ':' + addInst[i].exterPortEnd;
        if('' != addInst[i].exterSrcPortStart){
			SubmitData += '&'+ urlPrefix + '.ExternalSrcPort=' + addInst[i].exterSrcPortStart + ':' + addInst[i].exterSrcPortEnd;
        }
    }
    for(var i = 0; i < modifyInst.length; i++)
    {
        var urlPrefix = "m" + searchList[i];
		SubmitData += '&'+ urlPrefix + '.Protocol=' + modifyInst[i].Protocol;
        if('' != modifyInst[i].innerPortEnd){
        
			SubmitData += '&'+ urlPrefix + '.InternalPort=' + modifyInst[i].innerPortStart + ':' + modifyInst[i].innerPortEnd;
        }else{
			SubmitData += '&'+ urlPrefix + '.InternalPort=' + modifyInst[i].innerPortStart;
        }
		SubmitData += '&'+ urlPrefix + '.ExternalPort=' + modifyInst[i].exterPortStart + ':' + modifyInst[i].exterPortEnd;
        if('' != modifyInst[i].exterSrcPortStart){
			SubmitData += '&'+ urlPrefix + '.ExternalSrcPort=' + modifyInst[i].exterSrcPortStart + ':' + modifyInst[i].exterSrcPortEnd;
        }
        else
        {
			SubmitData += '&'+ urlPrefix + '.ExternalSrcPort=' + '';
        }
    }
    return SubmitData;
}
function setCtlDisplay(record)
{
    var endIndex = record.domain.lastIndexOf('PortMapping') - 1;
	var Interface = record.domain.substring(0,endIndex);

    if (isSupportHybrid == 1) {
        if (record.domain.indexOf('X_HW_Bonding') >= 0) {
            Interface = 'Bonding';
        }
    }
    setText('PortMappingDescription',record.Description);
	setSelect('PortMappingInterface',Interface);
	setCheck('PortMappingEnable',record.ProtMapEnabled);
	setText('RemoteHost',record.RemoteHost);
	setText('RemoteHostRange',record.RemoteHostRange);
	setText('InternalClient',record.InClient);
	setSelect('HostName', '0');
	if (PublicIpFlag == 1)
	{
	    setText('PublicIP',record.ExternalIP);
	}
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (record.InClient == LANhostIP[k])
		{
			setSelect('HostName', k);
			break;
		}
	}

	UpdatePortmappingPortList(record);
	PortListReplicate(record.PortList);	
	SelectIP = record.InClient;
}

function setControl(index)
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(maptInfo_language["map041"]);
        return;
    }
    var record;

	selctIndex = index;

    if (index == -1)
	{
	    if(PortMapping.length >= 32)
	    {
	        setDisplay('ConfigForm', 0);
			if(GetCfgMode().PCCWHK == "1")
			{
				AlertEx(portmapping_language['bbsp_mappingfullpccw']);
			}
			else
			{
		    	AlertEx(portmapping_language['bbsp_mappingfull']);
			}
		    return;
	    } 
	    if (PublicIpFlag == 1)
	    {
	        setDisplay('PublicIPRow', 1);
	    }
		else
		{
		    setDisplay('PublicIPRow', 0);
		}		
		AddFlag = true;
        RefreshWanInterface(AddFlag);
        setDisplay('ConfigForm', 1);
        record = new stPortMap('','1','','','','','','','','','','','');
        record.PortList = new stPortMappingPortList('','TCP/UDP','','','');
        setCtlDisplay(record);
		setDisable('PortMappingInterface', 0);
		getElement("radiosrv")[0].checked="checked";
		setSelect("appTempOptionsSelectId",'FIRST_APP');
		setDisable("appTempOptionsSelectId",1);
	}
    else if (index == -2)
    {
	    if (PublicIpFlag == 1)
	    {
	        setDisplay('PublicIPRow', 1);
	    }
		else
		{
		    setDisplay('PublicIPRow', 0);
		}
        setDisplay('ConfigForm', 0);
    }
	else
	{
	    if (PublicIpFlag == 1)
	    {
	        setDisplay('PublicIPRow', 1);
	    }
		else
		{
		    setDisplay('PublicIPRow', 0);
		}
		AddFlag = false;
        RefreshWanInterface(AddFlag);
		var UserDataInfo = new Array;
		for(var i = 0; i < PortMapping.length; i++)
		{
			if(true == IsRecordValid(PortMapping[i]))
			{
				UserDataInfo.push(PortMapping[i]);
			}
		}
	    record = UserDataInfo[index];
	    
        setDisplay('ConfigForm', 1);
        setCtlDisplay(record);
		setDisable('PortMappingInterface', 1);
		getElement("radiosrv")[0].checked="checked";
		getElById('PortMappingInterface').title = getElById('PortMappingInterface').options[getElById('PortMappingInterface').selectedIndex].text;
	}

    setDisable('btnApply_ex',0);	
    setDisable('cancelValue',0);
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
}

function getSelectIndexByDomain(domain)
{
	var selectIndex = -1;
	for (var i = 0; i < PortMapping.length; i++)
	{
		if (domain == PortMapping[i].domain)
		{
			selectIndex = i;
			return selectIndex;
		}
	}
	return selectIndex;
}

function RemoveInst(url, rmlId)
{
	var rml = getElement(rmlId);
	var delInst_TELECOM = '';
	if (rml == null)
		return;

	var SubmitForm = new webSubmitForm();
	var cnt = 0;
	var checkedNum = 0;
	with (document.forms[0])
	{
		if (rml.length > 0)
		{
			for (var i = 0; i < rml.length; i++)
			{
				if (rml[i].checked == true)
				{
					SubmitForm.addParameter(rml[i].value,'');
					cnt++;
				}
			}
		}
		else if (rml.checked == true)
		{
			SubmitForm.addParameter(rml.value ,'');
			cnt++;
		}
	}

	if (curCfgModeWord.toUpperCase() == "TELECOM2") {
		var delElement = getElementByName(rmlId);
		if (delElement == null) {
			return;
		}

		if (delElement.length >= 2) {
			for (var i = 0; i < delElement.length; i++) {
				if (delElement[i].checked == true) {
					delInst_TELECOM = delInst_TELECOM + delElement[i].defaultValue + '=""&';
					checkedNum++;
				}
			}

			if (checkedNum == 0) {
				return true;
			}
		} else {
			if (delElement.checked == true) {
				delInst_TELECOM = delInst_TELECOM + delElement.defaultValue + '=""&';
				checkedNum++;
			}
			if (checkedNum == 0) {
				return true;
			}
		}

		var ResultCode = '';
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			data : delInst_TELECOM + "x.X_HW_Token=" + getValue('onttoken'),
			url : "del.cgi?" + "RequestFile=" + url,
			success : function(data) {
			}
		});
		TELECOM_alertMessage();
		window.location.href = "/html/bbsp/portmapping/portmappingnew.asp";
	} else {
		SubmitForm.setAction('del.cgi?RequestFile=' + url);
		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		SubmitForm.submit();
	}
}

function FindWanIndexByPmIndex(index)
{
	var wandomain_len = 0;
	var temp_domain = null;
	var wanIdx = 0;

	for(var i = 0; i < WanInfo.length; i++ )
	{
		wandomain_len = WanInfo[i].domain.length;
		temp_domain = PortMapping[index].domain.substr(0, wandomain_len);
		if(temp_domain == WanInfo[i].domain)
		{
			wanIdx = i;
			break;
		}
	}
	
	return wanIdx;
}

function OnDeleteButtonClick()
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(maptInfo_language["map041"]);
        return;
    }
	var notestring;
	var curItem;
    if (PortMapping.length == 0)
	{
	    AlertEx(portmapping_language['bbsp_nomapping']);
	    return;
	}

	if (selctIndex == -1 && AddFlag == true)
	{
	    AlertEx(portmapping_language['bbsp_savemapping']);
	    return;
	}
    var rml = getElement('portMappingInstrml');
    var noChooseFlag = true;
    if ( rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             {   
                 noChooseFlag = false;
             }
         }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
    }
    if ( noChooseFlag )
    {
        AlertEx(portmapping_language['bbsp_selectmapping']);
        return ;
    }
   
	if (ConfirmEx(portmapping_language['bbsp_confirm2']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
	    return;
    }
	
	if ( rml.length > 0)
	{
	   for (var i = 0; i < rml.length; i++)
	   {
		   if (rml[i].checked == true)
		   {  
		        curItem = "";
				curItem = getSelectIndexByDomain(rml[i].value);
				if (-1 != curItem)
				{
                    if ((isSupportHybrid == 1) && (rml[i].value.indexOf('X_HW_Bonding') >= 0)) {

                    } else {
                        CheckDelActionPortConflict(0, curItem, FindWanIndexByPmIndex(curItem));
                        CheckDelActionPortConflict(1, curItem, FindWanIndexByPmIndex(curItem));
                    }
					PortMapping[curItem].delflag = 1;
					
					notestring = ProductConflitNote();
				    if (notestring.length != 0)
				    {
					   StartFileOpt();
					   AlertEx(notestring);
				    }
					if (('1' == OperateRuleFeature) && (false == checkOperateRule(PortMapping[curItem].OperateRule)))
					{
						return false;
					}
				}
		   }
	   }
	}
	else if (rml.checked == true)
	{
	   curItem = "";
	   curItem = getSelectIndexByDomain(rml.value);
	   if (-1 != curItem)
	   {
            if ((isSupportHybrid == 1) && (rml.value.indexOf('X_HW_Bonding') >= 0)) {

            } else {
                CheckDelActionPortConflict(0, curItem, FindWanIndexByPmIndex(curItem));
                CheckDelActionPortConflict(1, curItem, FindWanIndexByPmIndex(curItem));
            }
			notestring = ProductConflitNote();
		    if (notestring.length != 0)
		    {
			   StartFileOpt();
			   AlertEx(notestring);
		    }
			if (('1' == OperateRuleFeature) && (false == checkOperateRule(PortMapping[curItem].OperateRule)))
			{
				return false;
			}
	   }
	}    
	
    setDisable('btnApply_ex',1);	
    setDisable('cancelValue',1);
	RemoveInst('html/bbsp/portmapping/portmappingnew.asp', "portMappingInstrml");
} 

var SelectIP = "";

function setSelectHostName()
{
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (SelectIP == LANhostIP[k])
		{
			setSelect('HostName', k);
			break;
		}
	}
}
function CancelConfig()
{
    setDisplay("ConfigForm", 0);

    if (selctIndex == -1)
    {
        var tableRow = getElement("portMappingInst");
        
        if (tableRow.rows.length > 2)
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            return;
        }
    }
    else
    {
        var record = PortMapping[selctIndex];
        setCtlDisplay(record);
    } 
    
}

function portMappingInstselectRemoveCnt(Obj)
{

}

var TableClass = new stTableClass("table_title width_per25", "table_right", "");

function MakeEnableStatus(ProtMapEnabled)
{
	if (ProtMapEnabled == "1")
	{
	   return portmapping_language['bbsp_enable'];
	}
	else
	{
	   return portmapping_language['bbsp_disable'];
	}
}

function createportmapselectinfo()
{
	var output = '';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = '<option value="' + i + '" title="' + htmlencode(LANhostName[i]) + '">' + GetStringContent(htmlencode(LANhostName[i]),30) + '</option>';
		$("#HostName").append(output);
	} 
}  
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody" >
<script language="JavaScript" type="text/javascript">
if (IsPTVDFFlag == 1) {
	HWCreatePageHeadInfo("portmapping", GetDescFormArrayById(portmapping_language, "bbsp_mune"), GetDescFormArrayById(portmapping_language, ""), false);
	document.getElementById("portmapping_content").innerHTML = portmapping_language['bbsp_portmapping_title_short'] + portmapping_language['bbsp_portmapping_title_note'] + portmapping_language['bbsp_PTVDF_portmapping_title'];
} else {
	HWCreatePageHeadInfo("portmapping", GetDescFormArrayById(portmapping_language, "bbsp_mune"), GetDescFormArrayById(portmapping_language, "bbsp_portmapping_title"), false);
	
}
</script>
<div class="title_spread"></div>

<script type="text/javascript">
var PortMappingCfgListInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
								new stTableTileInfo("bbsp_mapping","align_center","Description",false,10),
								new stTableTileInfo("bbsp_wanname","align_center restrict_dir_ltr","Interface"),
								new stTableTileInfo("bbsp_inthost","align_center","InClient"),
								new stTableTileInfo("bbsp_externelhost","align_center restrict_dir_ltr","RemoteHost",false,"",0),
								new stTableTileInfo("bbsp_enable_status","align_center","ProtMapEnabled"),null);

var TableDataInfo = new Array;
var PortMappingData = HWcloneObject(PortMapping, 1);
for(var i = 0; i < PortMappingData.length; i++)
{
	if(true == IsRecordValid(PortMappingData[i]))
	{
		TableDataInfo.push(PortMappingData[i]);
	}
}
TableDataInfo.push(null);
for(var i = 0; i < TableDataInfo.length-1; i++)
{	
	var RemoteHostStr = "";
	if (TableDataInfo[i].RemoteHost != '' && TableDataInfo[i].RemoteHostRange != '') 
	{
		 RemoteHostStr = TableDataInfo[i].RemoteHost  + '-'	+ '<br/>' + TableDataInfo[i].RemoteHostRange;	
	}
	else if (TableDataInfo[i].RemoteHost != '' && TableDataInfo[i].RemoteHostRange == '')
	{
		  RemoteHostStr =  TableDataInfo[i].RemoteHost;
	}
	else
	{
		RemoteHostStr = "--";
	}
	
	TableDataInfo[i].Description = (TableDataInfo[i].Description == "") ? "--" : TableDataInfo[i].Description;
	TableDataInfo[i].RemoteHost = RemoteHostStr;
	TableDataInfo[i].ProtMapEnabled = MakeEnableStatus(TableDataInfo[i].ProtMapEnabled);
}								
HWShowTableListByType(1, "portMappingInst", true, 6, TableDataInfo, PortMappingCfgListInfo, portmapping_language, null);

</script>

<form id="ConfigForm" style="display:none">
<div class="list_table_spread"></div>
<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li   id="radiosrv"      RealType="RadioButtonList"      DescRef="bbsp_typemh"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    InitValue="[{TextRef:'bbsp_custom',Value:'1'},{TextRef:'bbsp_application',Value:'2'}]" ClickFuncApp="onclick=radioClick"/>
<li   id="appTempOptionsSelectId"    RealType="DropDownList"       DescRef="bbsp_applicationmh"      RemarkRef="Empty"       ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    disabled="TRUE"   Elementclass="Select" InitValue="Empty"  ClickFuncApp="onchange=appTempSelect"/>
<li   id="PortMappingEnable"         RealType="CheckBox"           DescRef="bbsp_enablemappingmh"     RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"      InitValue="Empty" />
<li   id="PortMappingDescription"    RealType="TextBox"            DescRef="bbsp_mappingmh"           RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"             InitValue="Empty"/>
<li   id="PortMappingInterface"    RealType="DropDownList"       DescRef="bbsp_wannamemh"      RemarkRef="Empty"       ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    Elementclass="SelectWanName"  InitValue="Empty"  ClickFuncApp="onchange=ShowPortMappingInterface"/>
<li   id="PublicIP"    RealType="TextBox"            DescRef="bbsp_publicip"           RemarkRef="bbsp_publicnote"    ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"      InitValue="Empty"  MaxLength="256"/>
<li   id="InternalClient"  RealType="TextOtherBox"  DescRef="bbsp_inthostmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="Empty"   MaxLength="32"  InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'HostName'},{AttrName:'class',AttrValue:'Select_2 restrict_dir_ltr'}]}]"/>                                                                  
<li   id="RemoteHost"  RealType="TextOtherBox"  DescRef="bbsp_extsrcipmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"  MaxLength="15"  InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'SpanLine'},{AttrName:'innerhtml',AttrValue:'--'}]},{Type:'text',Item:[{AttrName:'id',AttrValue:'RemoteHostRange'},{AttrName:'class',AttrValue:'TextBox_2'}]}]"/>                                                                  

</table>
<script>
PortMappingCfgFormList = HWGetLiIdListByForm("ConfigForm", PortMappingReload);
HWParsePageControlByID("ConfigForm", TableClass, portmapping_language, PortMappingReload);
</script>


<table width="100%" class="pm_tabal_bg" cellpadding="0" cellspacing="0"> 
  <tr> 
	<td>  
	<table id="TABLE_PORTMAPPING_PORTLIST" cellpadding="2" cellspacing="0" class="pm_tabal_bg" width="100%"> 
		<tr><td></td></tr>
	</table> 
	</td> 
  </tr>
  <tr>
	<td>
		<button id="portListAddId" class="NewDelbuttoncss1" onclick="AddPortList()" type="button">
		<script language="JavaScript" type="text/javascript">
		if(true == TELMEX_EN)
		{
			document.write(portmapping_language['add_new_inst_telmex']);
		}
		else
		{
			document.write(portmapping_language['add_new_inst']);
		}
		if (rosunionGame == "1") {
			$("#portListAddId").removeClass("NewDelbuttoncss1");
		}
		</script>  
	</button>
	</td>
  </tr>  
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" > 
  <tr> 
	<td class="title_bright1"> 
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<button name="btnApply_ex" id="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submitportmap(3)" enable=true ><script>document.write(portmapping_language['bbsp_app']);</script></button>
		<button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" style="padding-left:4px;" onClick="CancelConfig();"><script>document.write(portmapping_language['bbsp_cancel']);</script></button> </td> 
  </tr> 
</table> 
</form>
<div style="height:20px;"></div>
<script language="JavaScript" type="text/javascript">
GetLanUserDevInfo(function(para)
{
	setlanhostnameip(para);
	createportmapselectinfo();
	SelectIP = numpara;
	setSelectHostName();
});
getPortMappingWanList();
if (isSupportHybrid == 1) {
    $("#PortMappingInterface").append('<option value="Bonding" id="BONDING">' + bonding_other_language['bbsp_bonding'] + '</option>');
}
$("#appTempOptionsSelectId").append(getAppTempsOptions());
getElById('HostName').onchange = function()
{
	HostNameChange();
}
if(PublicIpFlag == '1')
{
	getElById("PublicIPRow").title = portmapping_language['bbsp_public_prompt'];
}
</script>
</body>
</html>
