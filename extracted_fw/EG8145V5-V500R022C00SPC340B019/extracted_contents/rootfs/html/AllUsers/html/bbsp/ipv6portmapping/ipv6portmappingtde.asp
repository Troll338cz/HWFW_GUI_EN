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
<script language="javascript" src="../common/wan_check.asp"></script>
<title>Portmapping</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var enblPortList = new Array();
var fileUrl = 'html/bbsp/ipv6portmapping/ipv6portmappingtde.asp';


var TempIPv6Prefix = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Prefix.1.Prefix);%>';
var Br0IPv6Prefix = TempIPv6Prefix.split('/')[0];
var Br0IPv6Prefixlength = TempIPv6Prefix.split('/')[1];

function stLanDhcp6Info(domain, MinAddress, MaxAddress)
{
	this.domain = domain;
	this.MinAddress = MinAddress;
	this.MaxAddress = MaxAddress;
}

function stIPv6Address(domain, IPv6InterfaceAddress, IPv6PrefixAddress, IPv6PrefixLength)
{
	this.domain = domain;
	this.IPv6InterfaceAddress = IPv6InterfaceAddress;
	this.IPv6PrefixAddress = IPv6PrefixAddress;
	this.IPv6PrefixLength = IPv6PrefixLength;
}

var TempIPv6Address = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.X_TELEFONICA-ES_IPv6LanIntfAddress.DelegatedAddress.1, IPv6InterfaceAddress|IPv6PrefixAddress|IPv6PrefixLength, stIPv6Address);%>;
var TempStaticDelegated = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.X_TELEFONICA-ES_IPv6InterfaceAddressingType.StaticDelegated);%>;
if ((1 == TempStaticDelegated) || ('1' == TempStaticDelegated))
{
	var IPv6Address = new stIPv6Address('', '', '', '');
}
else
{
	var IPv6Address = TempIPv6Address[0];
}

var LANIPv6Address = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.X_TELEFONICA-ES_IPv6LanIntfAddress.UniqueLocalAddress);%>';

var LANIPv6State = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_RouterAdvertisement.ManagedFlag);%>';

var TempLANIPv6 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server.Pool.1, MinAddress|MaxAddress,stLanDhcp6Info);%>;
var LANIPv6Interface = TempLANIPv6[0];

function ParseIPv6Prefix(IPv6Prefix)
{
	var TempPrefix = "";
	var Temp_list;
	var SegNumber = 4;
	var Prefix_list = IPv6Prefix.split('::');
	
	if(Prefix_list.length == 1)
	{
		TempPrefix = IPv6Prefix + ':';
	}
	else if(Prefix_list.length == 2)
	{
		Temp_list = IPv6Prefix.split(':');
		if(Temp_list.length >= parseInt(SegNumber + 2))
		{
			TempPrefix = IPv6Prefix.substring(0, IPv6Prefix.length - 1 );
		}
		else
		{
			if(IPv6Prefix.charAt(IPv6Prefix.length - 1) == ':')
			{
				TempPrefix = IPv6Prefix;
			}
			else
			{
				TempPrefix = IPv6Prefix + ':';
			}
		}
	}
	else
	{
		TempPrefix = '::';
	}
	
	return TempPrefix;
}

function MakeFullIPv6Address(IPv6Prefix, InterfaceID)
{
	var result = "";
	if(IPv6Prefix == "")
	{
		result = '::' + InterfaceID;
	}
	else
	{
		result = ParseIPv6Prefix(IPv6Prefix) + InterfaceID;
	}
	
	return result;
}

function ParseBackIPv6Para(IPv6Prefix, IPv6PrefixLen)
{
	var TempPrefix = "";
	var Temp_list;
	var SegNumber = parseInt(IPv6PrefixLen/16);
	var Ip_str = ":0:";
	var Prefix_list = IPv6Prefix.split('::');
	
	if(Prefix_list.length == 1)
	{
		Temp_list = IPv6Prefix.split(':');
		for(var i = 0; i < SegNumber; i++)
		{
			TempPrefix += Temp_list[i];
			if(i < (SegNumber - 1))TempPrefix += ':';
		}
	}
	else if(Prefix_list.length == 2)
	{
		if(Prefix_list[0] == "")Prefix_list[0] = "0";
		if(Prefix_list[1] == "")Prefix_list[1] = "0";
		
		var Ip_list = IPv6Prefix.split(':');
		for(i = 0; i < 8 - Ip_list.length; i++ )
		{
			Ip_str += "0:";
		}
		
		var Ip_Temp = Prefix_list[0] + Ip_str + Prefix_list[1];
		
		Temp_list = Ip_Temp.split(':');
		for(var i = 0; i < SegNumber; i++)
		{
			TempPrefix += Temp_list[i];
			if(i < (SegNumber - 1))TempPrefix += ':';
		}
	}
	else
	{
		TempPrefix = '::';
	}
	
	return TempPrefix;
}

function CtrlIPAddressRow(state)
{
	setDisplay('StartIPAddressRow', state);
	setDisplay('EndIPAddressRow', state);
}

function ParBackOldPrefix(FullIPv6Addr)
{
	var tempAddr;
	var iplist = FullIPv6Addr.split(':');
	if(iplist.length < 8)
	{
		tempAddr = FullIPv6Addr;
	}
	else if((iplist[0] == 0) && (iplist[1] == 0) && (iplist[2] == 0) && (iplist[3] == 0))
	{
		tempAddr = '::' + iplist[4] + ':' + iplist[5] + ':' + iplist[6] + ':' + iplist[7];
	}
	else
	{
		tempAddr = FullIPv6Addr;
	}
	
	return tempAddr;
}

function filtergetmask6(length)
{
	var bitlength = length % 16;
	var mask = ['0','8000','C000','E000','F000','F800','FC00','FE00','FF00','FF80','FFC0','FFE0','FFF0','FFF8','FFFC','FFFE','FFFF'];
	var maskout;
	if((length < 16)&&(length >= 1))
	{
		maskout = mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 32)&&(length >= 16))
	{
		maskout = 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 48)&&(length >= 32))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 64)&&(length >= 48))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 80)&&(length >= 64))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 96)&&(length >= 80))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0';
	}

	if((length < 112)&&(length >= 96))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' +  'FFFF' + ':' + mask[bitlength] + ':' + '0';
	}

	if((length < 128)&&(length >= 112))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' +  'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength];
	}

	if(length == 128)
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' +  'FFFF' + ':' + 'FFFF' + ':' + 'FFFF';
	}

	if(length == 0)
	{
		maskout = '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}
	return maskout;
}
function PutPrefix(Br0IPv6Prefixtmp, Prelengthtmp)
{
	var Br0IPv6PrefixList = standIpv6Address(Br0IPv6Prefixtmp);
	var Masklist = filtergetmask6(Prelengthtmp).split(':');
	
	var TempIPv6PrefixNew = '';

	for(var fixlength = 0;fixlength < 4;fixlength++)
	{
		var tmp;
		tmp = parseInt(Br0IPv6PrefixList[fixlength], 16) & parseInt(Masklist[fixlength], 16);
		Br0IPv6PrefixList[fixlength] = tmp.toString(16);

		TempIPv6PrefixNew += "0000".substring(0, 4 - Br0IPv6PrefixList[fixlength].length) + Br0IPv6PrefixList[fixlength];

		if(fixlength != 3)
		{
			TempIPv6PrefixNew += ':';
		}
	}

	return TempIPv6PrefixNew;
}
function BindDHCPv6Info()
{
	setText('LocalIPv6Address', LANIPv6Address);
	setText('GlobalIPv6Address', IPv6Address.IPv6InterfaceAddress);
	setText('SubnetPrefixLen', IPv6Address.IPv6PrefixLength);
	
	var IPv6AssignModeVal = (LANIPv6State == "1") ? "Fixed" : "Auto";

	var IsModeFixed = (IPv6AssignModeVal == "Fixed") ? true : false;
	var IsModeAuto = (!IsModeFixed) ? true : false;
	getElById("IPv6AssignMode1").checked = IsModeAuto;
	getElById("IPv6AssignMode2").checked = IsModeFixed;

	var newBr0IPv6Prefix = PutPrefix(Br0IPv6Prefix, Br0IPv6Prefixlength);

	var StartIPAddress_text = MakeFullIPv6Address(newBr0IPv6Prefix, LANIPv6Interface.MinAddress);
	var EndIPAddress_text = MakeFullIPv6Address(newBr0IPv6Prefix, LANIPv6Interface.MaxAddress);
	
	setText('StartIPAddress', ParBackOldPrefix(StartIPAddress_text));
	setText('EndIPAddress', ParBackOldPrefix(EndIPAddress_text));
	if(IPv6AssignModeVal == "Fixed")
	{	
		CtrlIPAddressRow(1);
	}
	else
	{
		CtrlIPAddressRow(0);
	}
}

function IPv6AddrChk(ipv6Addr)
{
	if (IsIPv6AddressValid(ipv6Addr) == false)
	{
		return false;
	}
	if (IsIPv6MulticastAddress(ipv6Addr) == true)
	{
		return false;  
	} 
	if (IsIPv6ZeroAddress(ipv6Addr) == true)
	{
		return false;
	}
	if (IsIPv6LoopBackAddress(ipv6Addr) == true)
	{
		return false;  
	}
	
	return true;
}

function Dhcpv6ServerAddrChkConvert(ipv6DhcpAddr)
{
    var j = 0;
    var standIpv6Addr = "";
    for(var i = 0; i < ipv6DhcpAddr.length; i++){
        if(":" == ipv6DhcpAddr.charAt(i)){
            continue;
        }
        standIpv6Addr += ipv6DhcpAddr.charAt(i);
        if(!(++j%2)){
            standIpv6Addr += ":";
        }
    }
    return standIpv6Addr.substring(0,23);
}
function Dhcpv6ServerAddrChk(MinAddr, MaxAddr)
{
    var begainAddr = MinAddr;
    var endAddr = MaxAddr;
    var theIpReg = /(([0-9a-fA-F]{4}(:)){3})([0-9a-fA-F]{4})/g;
     
    if((null == begainAddr.match(theIpReg))) 
	{
        AlertEx(ipv6portmapping_language['bbsp_startipv6formatinvalid']);
        return false;
    }
    if(true != IPv6AddrChk(Dhcpv6ServerAddrChkConvert(begainAddr)))
	{
		AlertEx(ipv6portmapping_language['bbsp_startipv6invalid']);
        return false;
    }
    if((null == endAddr.match(theIpReg))) 
	{
        AlertEx(ipv6portmapping_language['bbsp_endipv6formatinvalid']);
        return false;
    }
    if(true != IPv6AddrChk(Dhcpv6ServerAddrChkConvert(endAddr)))
	{
		AlertEx(ipv6portmapping_language['bbsp_endipv6invalid']);
        return false;
    }
    if(true == isStartIpbigerEndIp(begainAddr,endAddr))
	{
        AlertEx(ipv6portmapping_language['bbsp_startbigthanend']);
        return false;
    }
    return true;
}

function OnDhcpApply()
{
	var StartIPAddr = $.trim(getValue('StartIPAddress'));
	var EndIPAddr = $.trim(getValue('EndIPAddress'));
	var State = (getElById("IPv6AssignMode2").checked == true) ? '1' : '0';

	var MinAddr = "";
	var MaxAddr = "";
	
	if('1' == State)
	{
		if(!IsIPv6AddressValid(StartIPAddr) || !IsIPv6AddressValid(EndIPAddr))
		{
			AlertEx(ipv6portmapping_language['bbsp_ipv6invalid']);
			return false;
		}
		
		var prefix1 = ParseBackIPv6Para(StartIPAddr, 64) + ':';
		var prefix2 = ParseBackIPv6Para(EndIPAddr, 64) + ':';
		var StartIPAddr1 = ParseBackIPv6Para(StartIPAddr, 128);
		var EndIPAddr1 = ParseBackIPv6Para(EndIPAddr, 128);

		MinAddr = StartIPAddr1.substring(prefix1.length, StartIPAddr1.length);
		MaxAddr = EndIPAddr1.substring(prefix2.length, EndIPAddr1.length);

		if(!Dhcpv6ServerAddrChk(MinAddr, MaxAddr))
		{
			return false;
		}
	}

	var Form = new webSubmitForm();
	if('1' == State)
	{
		Form.addParameter('x.MinAddress', MinAddr);
		Form.addParameter('x.MaxAddress', MaxAddr);
	}
	Form.addParameter('y.ManagedFlag', State);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server.Pool.1' 
					+ '&y=InternetGatewayDevice.LANDevice.1.X_HW_RouterAdvertisement' + '&RequestFile=' + fileUrl);
	Form.submit();
	
	setDisable('btnApply_ex',1);
	
}

function OnChangeUI(Obj)
{
	if(Obj.value == "Fixed")
	{
		setDisplay('StartIPAddressRow', 1);
		setDisplay('EndIPAddressRow', 1);
	}
	else
	{
		setDisplay('StartIPAddressRow', 0);
		setDisplay('EndIPAddressRow', 0);
	}
}

function LoadFrame()
{
	BindDHCPv6Info();	
}

function adjustParentHeight(containerID, newHeight)
{
	$("#" + containerID).css("height", newHeight + "px");
}

var TableClass = new stTableClass("PageSumaryTitleCss table_title width_per40", "table_right", "");

</script>
<style type="text/css">
	.TextBox
	{
		width:280px;  
	}
</style>
</head>
<body onLoad="LoadFrame();" class="iframebody" >
<div class="title_spread"></div>
<div id="FuctionPageArea" class="FuctionPageAreaCss">
<div id="FunctionPageTitle" class="FunctionPageTitleCss">
<span id="PageTitleText" class="PageTitleTextCss" BindText="bbsp_ipv6localnet"></span>
</div>
 
<form id="ConfigFormDhcp" style="display:block;"> 
<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
<li   id="DHCPv6InfoBar"            RealType="HtmlText"         DescRef="bbsp_dhcpv6info"         RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   InitValue="Empty"/>
<li   id="LocalIPv6Address"        	RealType="TextBox"      	  DescRef="bbsp_localaddrmh"        RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   disabled="TRUE"  InitValue="Empty"/>
<li   id="GlobalIPv6Address"        RealType="TextBox"      	  DescRef="bbsp_globaladdrmh"       RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   disabled="TRUE"  InitValue="Empty"/>
<li   id="SubnetPrefixLen"        	RealType="TextBox"      	  DescRef="bbsp_subprefixmh"        RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   disabled="TRUE"  InitValue="Empty"/>
<li   id="IPv6AssignMode"           RealType="RadioButtonList"    DescRef="bbsp_assignmode"         RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    InitValue="[{TextRef:'bbsp_auto',Value:'Auto'},{TextRef:'bbsp_fixed',Value:'Fixed'}]" ClickFuncApp="onclick=OnChangeUI"/>
<li   id="StartIPAddress"    		RealType="TextBox"            DescRef="bbsp_startaddrmh"        RemarkRef="Empty"    		ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"      InitValue="Empty"/>
<li   id="EndIPAddress"    			RealType="TextBox"            DescRef="bbsp_endaddrmh"          RemarkRef="Empty"    		ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"      InitValue="Empty"/>
</table>
<script>
PortMappingCfgFormList = HWGetLiIdListByForm("ConfigFormDhcp", null);
HWParsePageControlByID("ConfigFormDhcp", TableClass, ipv6portmapping_language, null);
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
	<td class="table_submit"> 
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<button name="btnApply_ex" id="btnApply_ex" type="button" class="BluebuttonGreenBgcss buttonwidth_100px" onClick="OnDhcpApply()"><script>document.write(ipv6portmapping_language['bbsp_app']);</script></button>
  </tr> 
</table> 
</form>
<div style="height:20px;"></div>
</div>
<script>
CtrlIPAddressRow(0);
ParseBindTextByTagName(ipv6portmapping_language, "span",  1);
ParseBindTextByTagName(ipv6portmapping_language, "td",    1);
document.getElementById("StartIPAddress").title = ipv6portmapping_language['bbsp_interfaceremark'];
document.getElementById("EndIPAddress").title = ipv6portmapping_language['bbsp_interfaceremark'];
</script>
<div id="PortmappingWarpContent">
<iframe id="PortmappingContent" src="/html/bbsp/ipv6portmapping/portmappingsrc.asp" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" width="100%" height="100%" />
</div>
</body>
</html>
