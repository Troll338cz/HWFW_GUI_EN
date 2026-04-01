<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<style>
.Select
{
	width:154px;  
}
.Select_4
{
	width:270px;  
}
.Select_6
{
	width:290px;  
}
.TextBox
{
	width:150px;  
}
.Select_2
{
	width:154px;
	margin:0px 0px 0px 4px;
}
.TextBox_2
{
	width:150px;  
}
.SelectExpand_i{
	padding:0;
	margin:0;
	height:20px;
	line-height:20px;
}

.SelectExpand_s{
	position:absolute;
	margin:0;
	padding:0;
	border:1px solid #CCC;
	border-top:0;
}
</style>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="SelectExpand.js"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script>
    var curBinWord = "<%HW_WEB_GetBinMode();%>";
    if (curBinWord == 'E8C') {
        document.write('<script language="javascript" src="../common/wan_list_info_e8c.asp"><\/script>')
        document.write('<script language="javascript" src="../common/wan_list_e8c.asp"><\/script>')
    } else {
        document.write('<script language="javascript" src="../common/wan_list_info.asp"><\/script>')
        document.write('<script language="javascript" src="../common/wan_list.asp"><\/script>')
    }
</script>
<script language="javascript" src="../common/wan_check.asp"></script>
<title>Portmapping</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, portmapping_language, ipv6portmapping_language);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/ipv6portmapping/ipv6portmapping.cus);%>"></script>
<script language="JavaScript" type="text/javascript">
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var WanIndex = -1;
var appName = navigator.appName;
var TELMEX_EN = false;  
var PORTMAPPING_PORTLIST_INST_MAX = 12;
var currentPortMappingInst = 0;
var curPortList;
var AddFlag = true;
var selctIndex = -1; 
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var FirewallDual = <%HW_WEB_GetFeatureSupport("BBSP_FT_FIREWALL_DUAL");%>;
var IPv6Firewall = <%HW_WEB_GetFeatureSupport("BBSP_FT_CONFIG_IPV6_SESSION");%>;
var IsDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var IPv6FirewallEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_IPv6FWDFireWallEnable);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var TableName = "ConfigForm";
var SelectIP = "";
var GuaPrefix = "";
var GuaPrefixMask = "";
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var g_bondingDomain = "";

function IPv6Br0PrefixClass(domain, Prefix)
{ 
    this.domain = domain;
    this.Prefix = Prefix;
}

var IPv6Br0Prefix = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6Prefix,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Prefix.{i},Prefix, IPv6Br0PrefixClass);%>;

function ipv6BondingClass(domain, Enabled, Description, InternalClient, RemoteHost, RemoteHostRange, Protocol, InternalPortList) {
	this.domain = domain;
    this.ProtMapEnabled = Enabled;
	this.Description = Description;
	this.InClient = InternalClient;
	this.RemoteHost = RemoteHost;
	this.RemoteHostRange = RemoteHostRange;
	this.Protocol = Protocol;
	this.InternalPortList = InternalPortList;
}

var ipv6BondingList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Bonding.PortForward.{i}, Enabled|Description|InternalClient|RemoteHost|RemoteHostRange|Protocol|InternalPortList, ipv6BondingClass);%>;
function clean(){
	document.getElementById("PortMappingInterface").options[0].selected = true;
}

if ("1" == GetCfgMode().TELMEX)
{
	TELMEX_EN = true;
}
else
{
	TELMEX_EN = false;
}

var numpara = "";
if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
}

function setIPv6PortMappingAddr()
{
	if(IsIPv6AddressValid(numpara) == true)
	{
		clickAdd('portMappingInst_head');
		SelectIP = numpara;
		setSelectHostName();
		setText('InternalClient', numpara);
	}
}
var LANhostName = new Array();
var LANhostNameValue = new Array();

LANhostName[0] = ipv6portmapping_language['bbsp_selectdd'];
LANhostNameValue[0] = "Select";

function USERDeviceList(Domain,UserDevAlias,IpAddr,MacAddr,Port,IpType,DevType,DevStatus,PortType,Time,HostName,IPv4Enabled,IPv6Enabled)
{
	this.Domain 	= Domain;
	this.IpAddr	    = IpAddr;
	this.MacAddr	= MacAddr;
	this.Port 		= Port;
	this.PortType	= PortType;
	
	this.DevStatus 	= DevStatus;
	this.IpType		= IpType;
	if(IpType=="Static")
	{
	  this.DevType="--";
	}
	else
	{
		if(DevType=="")
		{
			this.DevType	= "--";	
		}
		else
		{
			this.DevType	= DevType;		
		}	
	}
	this.Time	    = Time;
	
	if(HostName=="")
	{
		this.HostName	= "--";
	}
	else
	{
	   this.HostName	= HostName;
	}
	
	if (UserDevAlias == "")
	{
		this.UserDevAlias = "--";
	}
	else
	{
		this.UserDevAlias = UserDevAlias;
	}
	
	this.IPv4Enabled = IPv4Enabled;
	this.IPv6Enabled = IPv6Enabled;
}

var UserDevinfoList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecialGetUserDevInfo,InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i},UserDevAlias|IpAddr|MacAddr|PortID|IpType|DevType|DevStatus|PortType|time|HostName|IPv4Enabled|IPv6Enabled ,USERDeviceList);%>;


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

function USERv6Device(domain, IPv6Addr, IPv6Scope)
{
	this.domain = domain;
	this.IPv6Addr = IPv6Addr;
	this.IPv6Scope = IPv6Scope;	
}

var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,stipaddr);%>;
var SlaveDhcpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DHCPSLVSERVER,StartIP|EndIP|DHCPEnable,dhcpcnst);%>;  

var MainDhcpRange = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,MinAddress|MaxAddress,dhcpmainst);%>;  
var UserDev6info = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i}.IPv6Address.{i},IP|Scope, USERv6Device);%>;

function GetHostAddrByDomain(_domain)
{
	var tmpHostAddr = new Array();
	for(var i = 0; i < UserDev6info.length -1; i++)
	{
		if(_domain.split('.')[4] == UserDev6info[i].domain.split('.')[4])
		{
			tmpHostAddr.push(UserDev6info[i]);
		}
	}
	
	return tmpHostAddr;
}

function GetHostNameByIpDomain(_domain)
{
	var HostNameVal = "";
	var HostNameArr = new Array();
	var tmpArr = _domain.split('.');
	for(var i = 0; i < 5; i++)
	{
		HostNameArr.push(tmpArr[i]);
	}
	HostNameVal = HostNameArr.join(".");
	
	return HostNameVal;
}

function IsHostHaveValidAddr(UserDevice)
{
	var tmpValidAddr = new Array();
	var tmpAddr = GetHostAddrByDomain(UserDevice.Domain);
	for(var i = 0; i < tmpAddr.length; i++)
	{
		if("GUA" == tmpAddr[i].IPv6Scope.toUpperCase())
		{
			tmpValidAddr.push(tmpAddr[i]);
		}
	}
	
	return (tmpValidAddr.length > 0) ? true : false;
}

function GetUserDevAlias(obj)
{
    if (obj.UserDevAlias != "--")
    {
        return obj.UserDevAlias;
    }
    else if(obj.HostName != "--")
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
		if( "1" != UserDevices[i].IPv6Enabled || !IsHostHaveValidAddr(UserDevices[i]))
		{
			continue;
		}
		
		if ("--" != UserDevices[i].HostName)
		{
		  	LANhostName[j] = UserDevices[i].HostName;
			LANhostNameValue[j] = UserDevices[i].Domain;
	    }
	    else
	    {
		  	LANhostName[j] = UserDevices[i].MacAddr;
			LANhostNameValue[j] = UserDevices[i].Domain;
		}
		if (IsDevTypeFlag == 1)
		{
			LANhostName[j] = GetUserDevAlias(UserDevices[i]);
		}
		j++;		
    } 	  
}

function GetGUAByLLA(llaaddr)
{
	/*优先根据LLA地址和LLA前缀，可以找到随机接口ID，再根据接口ID和GUA前缀生成永久GUA地址，找到永久GUA地址即可，调整到第一个显示*/
	var index = llaaddr.toUpperCase().indexOf("FE80::");
	if(0 == index)
	{
		var randomId = llaaddr.substr(6);
		return GuaPrefix + randomId;
	}
	else
	{
		return "";
	}	
}

function GetTransMac(HostMac)
{
	var oriMacArr = HostMac.split(":");
	if(oriMacArr.length < 6)
	{
		return "";
	}
	
	var macstr = oriMacArr.join("");
	var newmacstr = macstr.substring(0,6) + "fffe" + macstr.substr(6);
	var temp = newmacstr.substr(1,1);
	var newmacstrsub = parseInt(temp).toString(2);
	//第7位反转
	var reverseBit = parseInt(newmacstrsub.substr(2,1),2);
	if("0" == reverseBit)
	{
		reverseBit = "1";
	}
	else
	{
		reverseBit = "0";
	}
	temp = newmacstrsub.substring(0,2) + reverseBit + newmacstrsub.substr(3);
	newmacstr = newmacstr.substr(0,1) + parseInt(temp,2).toString(16) + newmacstr.substr(2);
	
	var retStr = "";
	for(var i = 0; i < newmacstr.length; ++i)
	{
		retStr += TransIPV6OneToBinary(newmacstr.charAt(i));
	}
	
	return retStr;
}

function TransIPV6OneToBinary(str)
{
	var transed = parseInt(str,16).toString(2);
	if(0 == transed.length)
	{
		return "0000";
	}
	else if(1 == transed.length)
	{
		return "000" + transed;
	}
	else if(2 == transed.length)
	{
		return "00" + transed;
	}
	else if(3 == transed.length)
	{
		return "0" + transed;
	}
	else
	{
		return transed;
	}
}

function TranIPV6SegmentComplete(prefix)
{
	if(0 == prefix.length)
	{
		return "0000";
	}
	else if(1 == prefix.length)
	{
		return "000"+prefix;
	}
	else if(2 == prefix.length)
	{
		return "00"+prefix;
	}
	else if(3 == prefix.length)
	{
		return "0"+prefix;
	}
	else
	{
		return prefix;
	}
}

function TransIPV6Segment(prefix)
{
	//2012 -> 二进制
	var retStr = "";
	
	for (var i = 0; i < prefix.length; ++i)
	{
		retStr += TransIPV6OneToBinary(prefix.charAt(i));
	}
	return  retStr;
}

function GetTransGuaPrefix(GuaPrefixMaskInfo, mask)
{
	/*目前仅考虑支持前缀为64位IPV6格式的*/
	var prefixList = standIpv6Address(GuaPrefixMaskInfo);
    var temp = "";
	var segmentComplete = "";
	for(var i = 0; i < prefixList.length; ++i)
	{
		segmentComplete = TranIPV6SegmentComplete(prefixList[i]);
		temp += TransIPV6Segment(segmentComplete);
	}
	
	if(mask > 64)
	{
		return "";
	}
	else
	{
		return temp.substr(0, mask);
	}
}

function TransStrToIPV6(str)
{
	var temp = "";
	var hexstr = "";
	for(var i = 0, j = 0; i < 128; i+=4, j++)
	{
		temp = str.substr(i,4);
		hexstr += parseInt(temp,2).toString(16);
		if((j+1)%4 == 0 && j > 0)
		{
			hexstr += ":";
		}
	}
	return hexstr;	
}

function GetGUAByMac(HostMac)
{
	var GuaPrefixMaskList = GuaPrefixMask.split("/");
	var mask = parseInt(GuaPrefixMaskList[1]);
	
	var transMac = GetTransMac(HostMac);
	var transGUA = GetTransGuaPrefix(GuaPrefixMaskList[0], mask);
	
	/*目前仅考虑支持前缀为64位IPV6格式的*/
	var len = 128-mask;
	var subMac = transMac.substr(transMac.length-len);
	var retStr = transGUA + subMac;
	return TransStrToIPV6(retStr);
}

function SortHostAddrByLLAAndMac(SelectHostAddr, HostMac)
{
	var SortedHostAddr = new Array(0);
	var FirstHostIdx = -1;
	var LLAAddr = "";
	
	for(var i = 0; i < SelectHostAddr.length; i++)
	{
		if("LLA" == SelectHostAddr[i].IPv6Scope.toUpperCase())
		{
			LLAAddr = SelectHostAddr[i].IPv6Addr;
		}
	}
	if("" == LLAAddr)
	{
		return SelectHostAddr;
	}
	
	var PermGUA1 = GetGUAByLLA(LLAAddr);
	var PermGUA2 = GetGUAByMac(HostMac);
	for(var i = 0; i < SelectHostAddr.length; i++)
	{
		if("GUA" == SelectHostAddr[i].IPv6Scope.toUpperCase())
		{			
			if(isStartIpSameEndIp(PermGUA1, SelectHostAddr[i].IPv6Addr))
			{/*优先根据LLA地址和LLA前缀，可以找到随机接口ID，再根据接口ID和GUA前缀生成永久GUA地址，找到永久GUA地址即可，调整到第一个显示*/
				FirstHostIdx = i;
				break;
			}
			else if(isStartIpSameEndIp(PermGUA2, SelectHostAddr[i].IPv6Addr))
			{/*无法匹配时，按照MAC地址和GUA前缀生成永久GUA，找到后调整第一个显示*/
				FirstHostIdx = i;
				break;
			}
		}
	}
	
	if(-1 == FirstHostIdx)
	{/*都无法匹配，按照原有显示所有GUA地址*/
		return SelectHostAddr;
	}
	else
	{
		SortedHostAddr.push(SelectHostAddr[FirstHostIdx]);
		for(var i = 0; i < SelectHostAddr.length; i++)
		{
			if(i == FirstHostIdx)
			{
				continue;
			}
			else
			{
				SortedHostAddr.push(SelectHostAddr[i]);
			}
		}
		return SortedHostAddr;
	}
}

function HostNameChange()
{
	var SelectHostAddr = new Array();
	var SelectHostValue = getSelectVal("HostName");
	var HostIpList = getElementById("HostIP");
	HostIpList.options.length = 0;
	
	SelectHostAddr = GetHostAddrByDomain(SelectHostValue);
	
	var SortedSelectHostAddr = new Array();
	var SelectHostMac = $("#HostName").children("option:selected").text();
	SortedSelectHostAddr = SortHostAddrByLLAAndMac(SelectHostAddr, SelectHostMac);
	
	for(var i = 0; i < SortedSelectHostAddr.length; i++)
	{
		if("GUA" == SortedSelectHostAddr[i].IPv6Scope.toUpperCase())
		{
			$("#HostIP").append('<option value=' + htmlencode(SortedSelectHostAddr[i].IPv6Addr) + ' title=' + htmlencode(SortedSelectHostAddr[i].IPv6Addr) + ' id="IpAddr_'+ htmlencode(SortedSelectHostAddr[i].domain.split('.')[6]) + '">'
							+ htmlencode(SortedSelectHostAddr[i].IPv6Addr) + '</option>');
		}
	}
	
	if(SortedSelectHostAddr.length > 0)
	{
		for(var i = 0; i < SortedSelectHostAddr.length; i++)
		{
			if("GUA" == SortedSelectHostAddr[i].IPv6Scope.toUpperCase())
			{
				setText('InternalClient',SortedSelectHostAddr[i].IPv6Addr);
			}
		}	
	}
	else
	{
		setText('InternalClient',"");
	}
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
		b.innerHTML = ipv6portmapping_language[b.getAttribute("BindText")];
	}
}

function checkIsHiddenWan(WanDomain) {
  return Instance_IspWlan.IsWanHidden(domainTowanname(WanDomain));
}

function filterWan(WanItem)
{
    if (!(WanItem.Tr069Flag == '0' && (checkIsHiddenWan(WanItem.domain) == false)))
	{
		return false;	
	}
	
	
    if (("1" == GetCfgMode().DT_HUNGARY) && (curUserType != sysUserType))
    {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
	return true;
}

var WanInfo = GetWanListByFilter(filterWan);


function stPortMap(domain,Enabled,InternalClient,RemoteHost,RemoteHostRange,Description)
{
    this.domain = domain;
    this.ProtMapEnabled = Enabled;
	this.InClient = InternalClient;	
    this.RemoteHost = RemoteHost;
    this.RemoteHostRange = RemoteHostRange;	
    this.Description = Description;
    var index = domain.lastIndexOf('PortMapping');
    this.Interface = domain.substr(0,index - 1);
    this.WanDomain = domain.substr(0,domain.lastIndexOf('X_HW_IPv6') - 1);
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
  
function stPortMappingPortList(domain,Protocol,InternalPort)
{
    var portList;
    var pathString = domain.split('.');
    this.instId = 0;
    if((pathString.length > 0) && ("Portlist" == pathString[pathString.length - 2])){
        this.instId = parseInt(pathString[pathString.length - 1], 10);;
    }
    this.domain = domain;
    this.Protocol = Protocol;
    
    portList = FormatPortStr(InternalPort).split(':');
    this.innerPortStart = portList[0];
    this.innerPortEnd = portList[0];
    if(portList.length > 1){
        this.innerPortEnd = portList[1];
    }
}

var WanIPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_IPv6.PortForward.{i}.Portlist.{i},Protocol|InternalPortList,stPortMappingPortList);%>;
var WanPPPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_IPv6.PortForward.{i}.Portlist.{i},Protocol|InternalPortList,stPortMappingPortList);%>;
var WanIPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_IPv6.PortForward.{i},Enabled|InternalClient|RemoteHost|RemoteHostRange|Description,stPortMap);%>;
var WanPPPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_IPv6.PortForward.{i},Enabled|InternalClient|RemoteHost|RemoteHostRange|Description,stPortMap);%>; 


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
function SelectPortMappingPortList(portMappingDomain,wanPortMappingPortList)
{
    var idx;
    var parentDomain;
    var portList = new Array(0);
    
    for(var i = 0; i < wanPortMappingPortList.length-1; i++)
    {
        idx = wanPortMappingPortList[i].domain.lastIndexOf(".Portlist");
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

function SelectBondingPortList(ipv6PortBondingList) {
	var portList = new Array();
	var bondingPortList = new stPortMappingPortList(ipv6PortBondingList.domain, ipv6PortBondingList.Protocol, ipv6PortBondingList.InternalPortList)
	portList.push(bondingPortList);
	return portList;
}

var PortMapping = new Array();
var Idx = 0;
for (var i = 0; i < WanIPPortMapping.length-1; i++)
{
	if(false == FindWanInfoByPortMapping(WanIPPortMapping[i]))
	{
		continue;
	}
	var tmpWan = FindWanInfoByPortMapping(WanIPPortMapping[i]);
    if (tmpWan.ServiceList != 'TR069'
       && tmpWan.ServiceList != 'VOIP'
       && tmpWan.ServiceList != 'TR069_VOIP'
       && tmpWan.Mode == 'IP_Routed')
	{    
	    PortMapping[Idx] = WanIPPortMapping[i];
		PortMapping[Idx].Interface = MakeWanName(tmpWan);
	    PortMapping[Idx].PortList = SelectPortMappingPortList(WanIPPortMapping[i].domain,WanIPPortMappingPortList);
		Idx ++;
	}
}
for (var j = 0; j < WanPPPPortMapping.length-1; j++,i++)
{
	if(false == FindWanInfoByPortMapping(WanPPPPortMapping[j]))
	{
		continue;
	}
    var tmpWan = FindWanInfoByPortMapping(WanPPPPortMapping[j]);   

    if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.ServiceList != 'VOIP'
		&& tmpWan.ServiceList != 'TR069_VOIP'
		&& tmpWan.Mode == 'IP_Routed')
	{
		PortMapping[Idx] = WanPPPPortMapping[j];
		PortMapping[Idx].Interface = MakeWanName(tmpWan);
	    PortMapping[Idx].PortList = SelectPortMappingPortList(WanPPPPortMapping[j].domain,WanPPPPortMappingPortList);

		Idx ++;   
	}
}

if (isSupportHybrid == "1") {
	for (var i = 0; i < ipv6BondingList.length -1; i++) {
		PortMapping[Idx] = ipv6BondingList[i];
		PortMapping[Idx].Interface = "Bonding";
		PortMapping[Idx].PortList = SelectBondingPortList(ipv6BondingList[i]);
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
var IPV6_SESSIONNUM = '<%HW_WEB_GetSPEC(BBSP_SPEC_IPV6_SESSIONNUM.UINT32);%>';

function submitBondingPortForward(SubmitForm) {
    SubmitForm.addParameter('x.Enabled',getCheckVal('PortMappingEnable'));
    SubmitForm.addParameter('x.Description',getValue('PortMappingDescription'));
	SubmitForm.addParameter('x.InternalClient',getValue('InternalClient'));
    SubmitForm.addParameter('x.RemoteHost',getValue('RemoteHost'));
	SubmitForm.addParameter('x.RemoteHostRange',getValue('RemoteHostRange'));

	var bondingPortList = GetCurrentPortList().getCurrPortList();
	SubmitForm.addParameter('x.Protocol', bondingPortList[0].Protocol);
	var bondingPortListstr = ""
	var portStart  = bondingPortList[0].innerPortStart;
	var portEnd = bondingPortList[0].innerPortEnd;
	if ((portEnd == "") || (portStart == portEnd)) {
		bondingPortListstr = portStart;
	} else {
		bondingPortListstr = portStart + ":" + portEnd;
	}
	SubmitForm.addParameter('x.InternalPortList', bondingPortListstr);
	if (AddFlag == true) {
		url = "addcfg.cgi?x=InternetGatewayDevice.Services.X_HW_Bonding.PortForward"
	} else {
		url = "set.cgi?x=" + g_bondingDomain;
	}
	url += "&RequestFile=html/bbsp/ipv6portmapping/ipv6portmapping.asp";
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction(url);
	setDisable('btnApply_ex',1);	
	setDisable('cancelValue',1);
	return;
}

function AddSubmitParam(SubmitForm,type)
{
	if ((0 == FirewallDual) && (1 == IPv6Firewall) && (0 == IPv6FirewallEnable))
	{
	    if(IPV6_SESSIONNUM == 0)
	    {
		    AlertEx(ipv6portmapping_language['bbsp_firewallnote']);
		}
	}
	var Interface = getSelectVal('PortMappingInterface');
	var url;
    var portListUrl = '';
    var postUrlPrefix = 'x';

    SubmitForm.addParameter(postUrlPrefix + '.Enabled',getCheckVal('PortMappingEnable'));
    SubmitForm.addParameter(postUrlPrefix + '.Description',getValue('PortMappingDescription'));
	SubmitForm.addParameter(postUrlPrefix + '.InternalClient',getValue('InternalClient'));
    SubmitForm.addParameter(postUrlPrefix + '.RemoteHost',getValue('RemoteHost'));
	SubmitForm.addParameter(postUrlPrefix + '.RemoteHostRange',getValue('RemoteHostRange'));
	
	if ((isSupportHybrid == "1") && (Interface == "Bonding")) {
		submitBondingPortForward(SubmitForm);
		return;
	}
	
	if ( true == AddFlag )
	{
	    portListUrl = PortListCommit(SubmitForm,postUrlPrefix,GetCurrentPortList().getCurrPortList());
		url = "addcfg.cgi?" + postUrlPrefix + '=' + Interface + ".X_HW_IPv6.PortForward";
	}
	else
	{
	    portListUrl = PortListCommit(SubmitForm,PortMapping[selctIndex].domain,GetCurrentPortList().getCurrPortList());
		url = "complex.cgi?" + postUrlPrefix + '=' + PortMapping[selctIndex].domain;
	}
	url += portListUrl;
	url += "&RequestFile=html/bbsp/ipv6portmapping/ipv6portmapping.asp";
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction(url);
    setDisable('btnApply_ex',1);	
    setDisable('cancelValue',1);
    
   
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

function portValueValidChk(curPortListRec)
{
    var innerStartPort = curPortListRec.innerPortStart;
    var innerEndPort = curPortListRec.innerPortEnd;

    if (innerStartPort == "")
    {
        AlertEx(ipv6portmapping_language['bbsp_startportisreq']);
        return false;
    }
	else if ((innerStartPort.charAt(0) == "0") || (isValidPort(innerStartPort) == false))
	{
	    AlertEx(ipv6portmapping_language['bbsp_startport'] +  innerStartPort + ipv6portmapping_language['bbsp_invalid']);
        return false;
	}

    if ((innerEndPort != "") && ((innerEndPort.charAt(0) == "0") || (isValidPort2(innerEndPort) == false)))
    {
        AlertEx(ipv6portmapping_language['bbsp_endport'] +  innerEndPort + ipv6portmapping_language['bbsp_invalid']);
        return false;
    }
	
	if ((innerStartPort != "") && (innerEndPort != "")
		&& (parseInt(innerStartPort, 10) > parseInt(innerEndPort, 10)))
	{
		AlertEx(ipv6portmapping_language['bbsp_startportleqendport']);
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
	
    if ((innerHostIp != "") && (CheckIpv6Parameter(innerHostIp) == false))
    {
        AlertEx(ipv6portmapping_language['bbsp_hostipinvalid']);
        return false;
    }

	if ((externalHostIp != "") && (CheckIpv6Parameter(externalHostIp) == false))
    {
		AlertEx(ipv6portmapping_language['bbsp_extsrcipstartinvalid']);
		return false;
    }
	if ((externalHostRangeIp != "") && (CheckIpv6Parameter(externalHostRangeIp) == false))
    {
		AlertEx(ipv6portmapping_language['bbsp_extsrcipendinvalid']);
		return false;
    }
	if ((externalHostRangeIp != "") && (isStartIpbigerEndIp(externalHostIp,externalHostRangeIp) == true))
	{
		AlertEx(ipv6portmapping_language['bbsp_extsrcipinvalid1']);
		return false;
	}
	if (externalHostIp == "" && externalHostRangeIp != "")
	{
		AlertEx(ipv6portmapping_language['bbsp_extsrcipisreq']);
		return false;
	}
	
	return true;
}

function portmappingDescpChk()
{
    var portmappingDescrip = getValue("PortMappingDescription");
    if((true == TELMEX_EN) && ("" == portmappingDescrip)){
        AlertEx(ipv6portmapping_language['bbsp_mappingisreq']);
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

function CheckPortMappingCfg() 
{
	var curWanInterface = getElement('PortMappingInterface');
	var selectId = 0;
	var wanIdx = 0;


    if(getElement("radiosrv")[1].checked == true && getElement("appTempOptionsSelectId").selectedIndex == 0)
    {
        AlertEx(ipv6portmapping_language['bbsp_notChoiceTemplate']); 
        return false;
    }
	if ( curWanInterface.selectedIndex < 0 )
	{
		 AlertEx(ipv6portmapping_language['bbsp_creatwan']);
		 return false;
	} 
	selectId = parseInt(curWanInterface.selectedIndex,10);
	wanIdx = curWanInterface.options[selectId].id.split('_')[1];

	if (curWanInterface.length == 0)
	{
	    AlertEx(ipv6portmapping_language['bbsp_wanconinvalid']);
	    return false;	
	}

	if (true != portmappingDescpChk())
	{
	    return false;
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
	
	return true;
}
function getPortMappingWanList()
{
	var HU='<%HW_WEB_GetFeatureSupport(BBSP_FT_HU);%>';
    $("#PortMappingInterface").empty();
    
    for (i = 0; i < WanInfo.length; i++)
	{
	    if (WanInfo[i].ServiceList != 'TR069'
			&& WanInfo[i].ServiceList != 'VOIP'
			&& WanInfo[i].ServiceList != 'TR069_VOIP'
		    && WanInfo[i].Mode == 'IP_Routed'
			&& WanInfo[i].IPv6Enable == '1')
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
function LoadFrame()
{
    var noRecordBeShow = true;
    curPortList = new PortMappingPortList("TABLE_PORTMAPPING_PORTLIST",PORTMAPPING_PORTLIST_INST_MAX);
	for (i = 0; i < PortMapping.length; i++)
	{  
		if(false == IsRecordValid(PortMapping[i]))
		{
			continue;
		}
		noRecordBeShow = false;
		selectLine(TableName + '_record_' + i);
		break;
	}

    if(true == noRecordBeShow)
    {	
 	    selectLine('record_no');
        setDisplay('ConfigForm',0);
    }

	setIPv6PortMappingAddr();
	loadlanguage();

	if (isSupportHybrid == "1") {
		$("#Newbutton").click(function() {
			clean();
		});
	}
}

function delAllPortList() {
	for (var i = 0; i <= PORTMAPPING_PORTLIST_INST_MAX; i++) {
		if (getElById("PortMappingPortListTbl_" + i) != undefined) {
			GetCurrentPortList().deletePortListTblInst(i);
		}
	}
}

function ShowPortMappingInterface()
{
   var Interface = getElement('PortMappingInterface');
   
   if(Interface.options.length > 0 && (Interface.selectedIndex >= 0))
   {
   		Interface.title = Interface.options[Interface.selectedIndex].text;
   }

	if (isSupportHybrid == "1") {
		if (Interface.value == "Bonding") {
			delAllPortList();
			AddPortList();
			setDisplay("portListAddId", 0);
			setDisplay("delButtonLine_1", 0);
		} else {
			setDisplay("portListAddId", 1);
			if (getElById("delButtonLine_1") != undefined) {
				setDisplay("delButtonLine_1", 1);
			}
		}
	}
}

function record_click(id)
{
	selectLine(id);
	currentPortMappingInst = id.split('_')[1];
	UpdatePortmappingPortList(PortMapping[currentPortMappingInst]);
}
function IsRecordValid(portMappingInfo)
{
    if(GetCfgMode().PCCWHK == "1")
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
        var tdClassInput = "<td class=\"table_title width_per25 bg_mappingInput\"";
        var requiredTips = "<strong style=\"color:red\">*</strong>";
        var subTableStyle = "<div class=\"list_table_spread\"></div><table class=\"tabal_noborder_bg width_per100\" cellpadding=\"0\" cellspacing=\"2\" id=\"PortMappingPortListTbl_";
        
        htmlLines += subTableStyle + portListInst + "\">";
        htmlLines += "<tr>" + tdClass + ">" + ipv6portmapping_language['bbsp_protocolmh'] +"</td>";
        htmlLines += tdClassInput + ">" + "<select id=\"PortMappingProtocolId_" + portListInst + "\" " + " size=\"1\" style=\"width: 111px\">"
        htmlLines += "<option value=\"TCP\" selected>TCP</option>" + "<option value=\"UDP\">UDP</option>" + "<option value=\"TCP/UDP\">TCP/UDP</option></select></td>";
        
        htmlLines += tdClass + "\">" +ipv6portmapping_language['bbsp_port']+ "</td>";;
        htmlLines += tdClassInput + ">" + "<input type=\"text\" id=\"InnerStartPortId_" + portListInst + "\" " + " size=\"5\" maxlength=\"5\">" + "--";
        htmlLines += "<input type=\"text\" id=\"InnerEndPortId_" + portListInst + "\" " + "size=\"5\" maxlength=\"5\">" + requiredTips +"</td>" + "</tr>";
        
        htmlLines += "<tr id='delButtonLine_" + portListInst + "'>" + tdClass + "colspan=\"4\">";
        htmlLines += "<button id=\"portListDeleteId_" + portListInst + "\" " + "class=\"NewDelbuttoncss1\" onclick=\"DeletePortList(this);\" type=\"button\">";
        htmlLines += ipv6portmapping_language['bbsp_del'] + "</button></td></tr></table>";
        return htmlLines;
    } 
    

    this.insertPortListTblInst = function (portListInst){
        var tableHandler = this.tableHandler;
        var newRow = tableHandler.insertRow(tableHandler.rows.length);
        newRow.insertCell(0).innerHTML = this.getPortListFillUp(portListInst);
    }
    

    this.getCurrPortList = function (){
        portList = new Array(0);
        portListInst = {instId:'',Protocol:'',InternalPort:''};
        for (var inst = 0; inst < ($("table:visible[id^='PortMappingPortListTbl_']").length);inst++) {
            var instId = $("table:visible[id^='PortMappingPortListTbl_']").get(inst).id.split('_')[1];
            portListInst = new Object;
            portListInst.instId = instId;
            portListInst.Protocol = getSelectVal("PortMappingProtocolId_" + instId);
            portListInst.innerPortStart = getValue("InnerStartPortId_" + instId);
            portListInst.innerPortEnd = getValue("InnerEndPortId_" + instId);
            portList.push(portListInst);
        }
        return portList;
    }
    

    this.fillUpPortListTblInst = function (portListInst,record){
    	setSelect("PortMappingProtocolId_" + portListInst,(record.Protocol).toUpperCase());
        setText("InnerStartPortId_" + portListInst,record.innerPortStart);
        setText("InnerEndPortId_" + portListInst,record.innerPortEnd);
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
    var thisDomain = "InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.1.WANIPConnection.1.X_HW_IPv6.PortForward.Portlist." + portListInstId;

    var appTempPortList = new stPortMappingPortList(thisDomain,matchProtocol,inPort,'');
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
        AlertEx(ipv6portmapping_language['bbsp_cannot_add_more']);
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

var FIRST_APP = ipv6portmapping_language['bbsp_selectdd'];
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
    app_temples[48] = new cVnew("Xbox Live",4); 
    app_temples[48].e[0] = new iVnew("0", "53", "53");
    app_temples[48].e[1] = new iVnew("0", "80", "80");
    app_temples[48].e[2] = new iVnew("0", "1863", "1863");
    app_temples[48].e[3] = new iVnew("0", "3074", "3074");
    app_temples[49] = new cVnew("Yahoo Messenger",1); 
    app_temples[49].e[0] = new iVnew("1", "5050", "5050");
}else{
    var TOTAL_APP_TEMPLES = 14;
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
	
	if ((isSupportHybrid == "1") && (getElById("PortMappingInterface").value == "Bonding")) {
		setDisplay("delButtonLine_1", 0);
	}

}
function getAnAppTempOption(optionValue,languageId)
{
    aOption = "<option value=" + "\"" + optionValue + "\"" + ">" + ipv6portmapping_language[languageId] + "</option>"; 
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
        html += "<option value=TFTP>TFTP</option>";
        html += getAnAppTempOption("WEB","bbsp_WebServerHTTP");
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
    return true;
}
function PortListCommit(SubmitForm,portListDomain,newPortListRec)
{
    var modifyInst = new Array(0);
    var addInst = new Array(0);
    var delInst = new Array(0);
    var requestUrl = "";
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
        requestUrl += '&' + urlPrefix + '=' + portListDomain + ".Portlist." + delInst[i].instId;
    }
    for(var i = 0; i < addInst.length; i++)
    {
        var urlPrefix = "Add_a" + searchList[i];
        SubmitForm.addParameter(urlPrefix + '.Protocol',addInst[i].Protocol);
        if('' != addInst[i].innerPortEnd){
            SubmitForm.addParameter(urlPrefix + '.InternalPortList',addInst[i].innerPortStart + ':' + addInst[i].innerPortEnd);
        }else{
            SubmitForm.addParameter(urlPrefix + '.InternalPortList',addInst[i].innerPortStart);
        }
        requestUrl += '&' + urlPrefix + '=' + portListDomain + ".Portlist";
    }
    for(var i = 0; i < modifyInst.length; i++)
    {
        var urlPrefix = "m" + searchList[i];
        SubmitForm.addParameter(urlPrefix + '.Protocol',modifyInst[i].Protocol);
        if('' != modifyInst[i].innerPortEnd){
            SubmitForm.addParameter(urlPrefix + '.InternalPortList',modifyInst[i].innerPortStart + ':' + modifyInst[i].innerPortEnd);
        }else{
            SubmitForm.addParameter(urlPrefix + '.InternalPortList',modifyInst[i].innerPortStart);
        }
        requestUrl += '&' + urlPrefix + '=' + portListDomain + ".Portlist." + modifyInst[i].instId;
    }
    return requestUrl;
}
function setCtlDisplay(record)
{
    var endIndex = record.domain.lastIndexOf('PortMapping') - 1;
	var Interface = record.domain.substring(0,endIndex);

    setText('PortMappingDescription',record.Description);
	if ((isSupportHybrid == "1") && (record.domain.indexOf("X_HW_Bonding") > -1)) {
		setSelect('PortMappingInterface', "Bonding");
		g_bondingDomain = record.domain;
	} else {
	    setSelect('PortMappingInterface',record.WanDomain);
		g_bondingDomain = "";
	}
	setCheck('PortMappingEnable',record.ProtMapEnabled);
	setText('RemoteHost',record.RemoteHost);
	setText('RemoteHostRange',record.RemoteHostRange);
	setText('InternalClient',record.InClient);
	setSelect('HostName', 'Select');
	for (var k = 0; k < UserDev6info.length -1; k++)
	{
		if (record.InClient == UserDev6info[k].IPv6Addr && "LLA" != UserDev6info[k].IPv6Scope.toUpperCase())
		{
			setSelect('HostName', GetHostNameByIpDomain(UserDev6info[k].domain));
			break;
		}
	}
	
	UpdatePortmappingPortList(record);
	PortListReplicate(record.PortList);	
	SelectIP = record.InClient;

	if (isSupportHybrid == "1") {
		if (record.domain.indexOf("X_HW_Bonding") > -1) {
			setDisplay("delButtonLine_0", 0);
			setDisplay("portListAddId", 0);
		} else {
			setDisplay("delButtonLine_0", 1);
			setDisplay("portListAddId", 1);
		}
	}
}

function getPortMappingInternetWan()
{
    $("#PortMappingInterface").empty();
    for (i = 0; i < WanInfo.length; i++)
    {
        if (WanInfo[i].Mode == 'IP_Routed' && WanInfo[i].IPv6Enable == '1')
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

function RefreshHostAddrList()
{
	var SelectHostAddr = new Array();
	var SelectHostValue = getSelectVal("HostName");
	var HostIpList = getElementById("HostIP");
	HostIpList.options.length = 0;
	SelectHostAddr = GetHostAddrByDomain(SelectHostValue);
	
	for(var i = 0; i < SelectHostAddr.length; i++)
	{
		if("GUA" == SelectHostAddr[i].IPv6Scope.toUpperCase())
		{
			$("#HostIP").append('<option value=' + htmlencode(SelectHostAddr[i].IPv6Addr) + ' title=' + htmlencode(SelectHostAddr[i].IPv6Addr) + ' id="IpAddr_'+ htmlencode(SelectHostAddr[i].domain.split('.')[6]) + '">'
							+ htmlencode(SelectHostAddr[i].IPv6Addr) + '</option>');
		}
	}
	
}

function RefreshWanInterface(isAdd)
{
    if ((curUserType != sysUserType) && (IsPTVDFFlag == 1))
    {
        if(isAdd==true)
        {
            getPortMappingInternetWan();
        }
        else
        {
            getPortMappingWanList();
        }
    }
}

function SetWanPrefixByPortmapping()
{
    var prefix = IPv6Br0Prefix[0].Prefix;
	GuaPrefixMask = prefix;

    if (prefix != "::/0")
    {
        var temp_prefix = prefix.split('/');
        prefix = temp_prefix[0];
        setText("InternalClient", prefix);
		GuaPrefix = prefix;
    }
    else
    {
        setText("InternalClient", "");
    }
    
    return;
}

function setControl(index)
{
    var record;

	selctIndex = index;

    if (index == -1)
	{
	    if(PortMapping.length >= 32)
	    {
	        setDisplay('ConfigForm', 0);
			if(GetCfgMode().PCCWHK == "1")
			{
				AlertEx(ipv6portmapping_language['bbsp_mappingfullpccw']);
			}
			else
			{
		    	AlertEx(ipv6portmapping_language['bbsp_mappingfull']);
			}
		    return;
	    }   
		AddFlag = true;
        RefreshWanInterface(AddFlag);
        setDisplay('ConfigForm', 1);
        record = new stPortMap('','1','','','','','','','','','','');
        record.PortList = new stPortMappingPortList('','TCP/UDP','','');
        setCtlDisplay(record);
		setDisable('PortMappingInterface', 0);
		getElement("radiosrv")[0].checked="checked";
		setSelect("appTempOptionsSelectId",'FIRST_APP');
		setDisable("appTempOptionsSelectId",1);
		RefreshHostAddrList();

        SetWanPrefixByPortmapping();
	}
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
	else
	{
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
		RefreshHostAddrList();
	}

    setDisable('btnApply_ex',0);	
    setDisable('cancelValue',0);
}

function portMappingInstselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{ 
    if (PortMapping.length == 0)
	{
	    AlertEx(ipv6portmapping_language['bbsp_nomapping']);
	    return;
	}

	if (selctIndex == -1)
	{
	    AlertEx(ipv6portmapping_language['bbsp_savemapping']);
	    return;
	}
    var rml = document.getElementsByName("portMappingInstrml");
	var SubmitForm = new webSubmitForm();	 
    var Count = 0;
	for (var i = 0; i < rml.length; i++)
	{
		if (rml[i].checked != true)
		{
			continue;
		}
		
		Count++;
		SubmitForm.addParameter(rml[i].value,'');
	}
	if (Count <= 0)
	{
		AlertEx(ipv6portmapping_language['bbsp_selectmapping']);
		return;
	}
   
	if (ConfirmEx(ipv6portmapping_language['bbsp_confirm2']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
	    return;
    }
	
    setDisable('btnApply_ex',1);	
    setDisable('cancelValue',1);	
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/ipv6portmapping/ipv6portmapping.asp');   
	SubmitForm.submit();
} 

function setSelectHostName()
{
	
	for (var k = 0; k < UserDev6info.length - 1; k++)
	{
		if (SelectIP == UserDev6info[k].IPv6Addr && "LLA" != UserDev6info[k].IPv6Scope.toUpperCase())
		{
			setSelect('HostName', GetHostNameByIpDomain(UserDev6info[k].domain));
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
        
        if (tableRow.rows.length == 1)
        {
            selectLine('record_no');
        }
        else if (tableRow.rows.length == 2)
        {
           
        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + '_record_0');
        }
    }
    else
    {
        var record = PortMapping[selctIndex];
        setCtlDisplay(record);
    } 
    
}

function MakeEnableStatus(ProtMapEnabled)
{
	if (ProtMapEnabled == "1")
	{
	   return ipv6portmapping_language['bbsp_enable'] ;
	}
	else
	{
	   return ipv6portmapping_language['bbsp_disable'] ;
	}
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody" >
<script language="JavaScript" type="text/javascript">
	 HWCreatePageHeadInfo("ipv6portmappingtitle", GetDescFormArrayById(ipv6portmapping_language, "bbsp_mune"), GetDescFormArrayById(ipv6portmapping_language, ""), false);
	 if ((0 == FirewallDual) && (1 == IPv6Firewall))
	{
	    if(IPV6_SESSIONNUM == 0)
		{
		   document.getElementById("ipv6portmappingtitle_content").innerHTML = ipv6portmapping_language['bbsp_portmapping_title_ext'] + ipv6portmapping_language['bbsp_firewallnote'];
		}
		else
		{
		   document.getElementById("ipv6portmappingtitle_content").innerHTML = ipv6portmapping_language['bbsp_portmapping_title'];
		}
	 }
	 else
	 {
		document.getElementById("ipv6portmappingtitle_content").innerHTML = ipv6portmapping_language['bbsp_portmapping_title'];
		if (IsPTVDFFlag == 1) {
            document.getElementById("ipv6portmappingtitle_content").innerHTML = ipv6portmapping_language['bbsp_portmapping_title'] + ipv6portmapping_language['bbsp_PTVDF_portmapping'];
        }
	 }
</script>
<div class="title_spread"></div>
<div id="PortMappingCfgListTable" style="overflow-x:auto;overflow-y:hidden;width:100%;">
<script type="text/javascript">
var PortMappingCfgListInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
								new stTableTileInfo("bbsp_mapping","align_center","Description",false,10),
								new stTableTileInfo("bbsp_wanname","align_center restrict_dir_ltr","Interface"),
								new stTableTileInfo("bbsp_inthost","align_center","InClient"),
								new stTableTileInfo("bbsp_externelhost","align_center","RemoteHost", false,"",0),
								new stTableTileInfo("bbsp_enable_status","align_center","ProtMapEnabled"),null);
								
var TableDataInfo = new Array();
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
</div>
<form id="ConfigForm" style="display:none;"> 
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li   id="radiosrv"      RealType="RadioButtonList"      DescRef="bbsp_typemh"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    InitValue="[{TextRef:'bbsp_custom',Value:'1'},{TextRef:'bbsp_application',Value:'2'}]" ClickFuncApp="onclick=radioClick"/>
		<li   id="appTempOptionsSelectId"    RealType="DropDownList"       DescRef="bbsp_applicationmh"      RemarkRef="Empty"       ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    disabled="TRUE"   InitValue="Empty"  Elementclass="Select" ClickFuncApp="onchange=appTempSelect"/>
		<li   id="PortMappingEnable"         RealType="CheckBox"           DescRef="bbsp_enablemappingmh"     RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"      InitValue="Empty" />
		<li   id="PortMappingDescription"    RealType="TextBox"            DescRef="bbsp_mappingmh"           RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"             InitValue="Empty"    Maxlength="256"/>
		<li   id="PortMappingInterface"    RealType="DropDownList"       DescRef="bbsp_wannamemh"      RemarkRef="Empty"       ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    InitValue="Empty"  Elementclass="Select restrict_dir_ltr"  ClickFuncApp="onchange=ShowPortMappingInterface"/>
		<li   id="HostIP_select"  RealType="SmartBoxList"  DescRef="bbsp_inthostmh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    Elementclass="Select_6"   Maxlength="256"  Textwidth="274"   InitValue="[{Type:'span',Item:[{AttrName:'innerhtml',AttrValue:'bbsp_space'}]},{Type:'select',Item:[{AttrName:'id',AttrValue:'HostName'},{AttrName:'class',AttrValue:'Select'},{AttrName:'onChange',AttrValue:'HostNameChange()'}]}]"/>
		<li   id="RemoteHost"  RealType="TextOtherBox"  DescRef="bbsp_extsrcipmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"  MaxLength="63"  Elementclass="Select_4"
		InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'SpanLine'},{AttrName:'innerhtml',AttrValue:'--<br>'}]},{Type:'text',Item:[{AttrName:'id',AttrValue:'RemoteHostRange'},{AttrName:'MaxLength', AttrValue:'63'},{AttrName:'class',AttrValue:'Select_4'}]}]"/>                                                                  
	</table>
	<script>
		var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
		var PortMappingCfgFormList = new Array();
		PortMappingCfgFormList = HWGetLiIdListByForm("ConfigForm", PortMappingReload);
		HWParsePageControlByID(TableName, TableClass, ipv6portmapping_language, PortMappingReload);
		$("#appTempOptionsSelectId").append(getAppTempsOptions());
		getPortMappingWanList();
	</script>
	<table width="100%"  cellpadding="0" cellspacing="0"> 
        <tr> 
          <td>  
          <table id="TABLE_PORTMAPPING_PORTLIST" cellpadding="2" cellspacing="0"  width="100%"> 
			<tr><td></td></tr>
		</table> 
		</td> 
	  </tr>
	  <tr>
		<td>
			<button id="portListAddId" class="NewDelbuttoncss1" onclick="AddPortList()" type="button">
			<script language="JavaScript" type="text/javascript">
			document.write(ipv6portmapping_language['add_new_inst']);
			</script>  
		</button>
		</td>
	  </tr>  
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
		<td class="title_bright1"> 
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<button name="btnApply_ex" id="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(3)" enable=true ><script>document.write(ipv6portmapping_language['bbsp_app']);</script></button>
				<button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" style="padding-left:4px;" onClick="CancelConfig();"><script>document.write(ipv6portmapping_language['bbsp_cancel']);</script></button> </td> 
	  </tr> 
	</table> 
</form>
<script language="JavaScript" type="text/javascript">
$("#HostIP").SelectExpand();		
function createportmapselectinfo()
{
	var output = '';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = '<option value="' + htmlencode(LANhostNameValue[i]) + '" title="' + htmlencode(LANhostName[i]) + '">' + GetStringContent(htmlencode(LANhostName[i]),30) + '</option>';
		$("#HostName").append(output);
	} 
} 
if (isSupportHybrid == 1) {
    $("#PortMappingInterface").append('<option value="Bonding" id="BONDING">' + bonding_other_language['bbsp_bonding'] + '</option>');
}
setlanhostnameip(UserDevinfoList);
createportmapselectinfo();
setSelectHostName();

</script>	
<div style="height:20px;"></div>
<div style="height:20px;"></div>
</body>
</html>
