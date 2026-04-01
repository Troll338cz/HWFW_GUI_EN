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
<script language="javascript" src="../common/wan_check.asp"></script>
<title>Portmapping</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var enblPortList = new Array();
var fileUrl = 'html/bbsp/ipv6portmapping/portmappingsrc.asp';
var AllowEditFlag = false;

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


var Wan = GetWanList();
var InternetWanIf = ''; 
var FirewallIndex = 0;
for(var i = 0; i < Wan.length; i++)
{
	if (Wan[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") < 0)
	{
	    continue;
	}
	if (Wan[i].Mode != 'IP_Routed')
	{
	    continue;
	}
	if (Wan[i].IPv6Enable != "1")
	{
		continue;
	}

	InternetWanIf = Wan[i].domain;	
	break;
}

function getWanOffirewall(val)
{
   for (var i = 0; i < Wan.length; i++)
   {
      if (Wan[i].domain == val)
	  {
	      return Wan[i];
	  }
   }
   return "&nbsp;";
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

function setAllDisableTDE(flag)
{
    for(var i = 0; i < PortMapping.length; i++)
    {
       setDisable('portMappingInst_'+ i + "_1" ,flag);
       setDisable('portMappingInst_'+ i + "_2" ,flag);
       setDisable('portMappingInst_'+ i + "_3" ,flag);
       setDisable('portMappingInst_'+ i + "_4" ,flag);
   
    }
}

var TempIPv6Prefix = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Prefix.1.Prefix);%>';
var Br0IPv6Prefix = TempIPv6Prefix.split('/')[0];
var Prelength = TempIPv6Prefix.split('/')[1];

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

		
		TempIPv6PrefixNew += ':';
		
	}

	return TempIPv6PrefixNew + ":";
}

Br0IPv6Prefix = PutPrefix(Br0IPv6Prefix, Prelength);


function stFirewallPort(domain, IPAddress, Mask, StartPort, EndPort)
{
	this.domain = domain;
	this.IPAddress = IPAddress;
	this.Mask = Mask;
	this.StartPort = StartPort;
	this.EndPort = EndPort;
	this.ppindex = domain.split('.')[3];
	this.pindex = domain.split('.')[5];
}
var PortMapping3 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_TDE_Firewall.Firewall.{i}.Rule.{i}, X_HW_DstIPAddress|X_HW_DstMask|X_HW_DstStartPort|X_HW_DstEndPort, stFirewallPort);%>;

function stFirewall(domain, Name, Interface, Type, IPVersion, RuleNumberOfEntries)
{
	this.domain = domain;
	this.Name = Name;
	this.Interface = Interface;
	this.Type = Type;
	this.IPVersion = IPVersion;
	this.index = domain.split('.')[3];
	this.RuleNumberOfEntries = RuleNumberOfEntries;
}
var PortMapping1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_TDE_Firewall.Firewall.{i}, Name|Interface|Type|IPVersion|RuleNumberOfEntries, stFirewall);%>;

function GetCurrentFirewall(rule)
{
	var tmpFireall = new stFirewall("", "", "", "");
	for(var i = 0; i < PortMapping1.length -1; i++)
	{
		if(PortMapping1[i].index == rule.pindex)
		{
			tmpFireall = PortMapping1[i];
			break;
		}
	}
	
	return tmpFireall;
}

function GetCurrentFirewallindex(rule)
{
	var i;
	for(i = 0; i < PortMapping1.length -1; i++)
	{
		if(PortMapping1[i].index == rule.pindex)
		{
			break;
		}
	}
	
	return i;
}

function GetCurrentRulePort(rule)
{
	var tmpRulePort = new stFirewallPort("", "", "", "", "");
	for(var i = 0; i < PortMapping3.length -1; i++)
	{
		if((PortMapping3[i].pindex == rule.index) && (PortMapping3[i].ppindex == rule.pindex))		
		{
			tmpRulePort = PortMapping3[i];
			break;
		}
	}
	
	return tmpRulePort;
}

function stFirewallRule(domain, Enabled, Protocol, Action, PrivateFlag, RuleName)
{
	this.domain = domain;
	this.Enabled = Enabled;
	this.Protocol = Protocol;
	this.Action = Action;
	this.PrivateFlag = PrivateFlag;
	this.pindex = domain.split('.')[3];
	this.index = domain.split('.')[5];

	this.IPAddress = GetCurrentRulePort(this).IPAddress;
	this.Mask = GetCurrentRulePort(this).Mask;
	this.StartPort = GetCurrentRulePort(this).StartPort;
	this.EndPort = GetCurrentRulePort(this).EndPort;
	
	this.PortRange = this.StartPort + ':' + this.EndPort;

	this.Name = RuleName;
	this.Interface = GetCurrentFirewall(this).Interface;
	this.Type = GetCurrentFirewall(this).Type;
	this.IPVersion = GetCurrentFirewall(this).IPVersion;
}

var PortMapping2 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_TDE_Firewall.Firewall.{i}.Rule.{i}, Enabled|Protocol|Action|X_HW_PrivateFlag|X_HW_RuleName, stFirewallRule);%>;

var PortMapping = new Array();
for(var i = 0; i < PortMapping2.length - 1; i++)
{
	if((parseInt(PortMapping2[i].PrivateFlag) & 0x01) != 1)
	{
		continue;
	}
	if(PortMapping2[i].IPVersion != "6")
	{
		continue;
	}
	
	if((PortMapping2[i].IPAddress == "")||(PortMapping2[i].Enabled == ""))
	{
		continue;
	}
	
	PortMapping.push(PortMapping2[i]);
}

function setPortMapEnable(id ,enabled)
{
	if(1 == enabled)
	{
		getElById(id).style.background = "url(../../../images/cus_images/btn_on.png) no-repeat";
	}
	else
	{
		getElById(id).style.background = "url(../../../images/cus_images/btn_off.png) no-repeat";
	}
}

function EnablePortMapping(id)
{
	if (AllowEditFlag == false)
		return;
	var instId = id.split('_')[1];
	enblPortList[instId] = 1 - enblPortList[instId];
	setPortMapEnable(id, enblPortList[instId]);
}

function stPortMappingInst(domain, stName, stProtocol, stPortRange, stIPAddress, stEnabled)
{
	this.domain = domain;
	this.instId = domain.split('.')[3];
	this.stName = stName;
	this.stProtocol = stProtocol;
	this.stPortRange = stPortRange; 
	this.stIPAddress = stIPAddress;
	this.stEnabled = stEnabled;
	
	this.modifyFlag = false;
}

function PortMappingInstList(record)
{
	var instNum = record.length;
	
	this.showPortmappingList = function()
	{
		var htmlLines = '';
		var tdClass = "<td class=\"table_title align_center\"";
		
		if (instNum == 0 )
		{
			htmlLines += '<tr id="portMappingInst_record_no"' + ' class="tabal_center01" >';
			htmlLines += '<td >--</td>';
			htmlLines += '<td >--</td>';
			htmlLines += '<td >--</td>';
			htmlLines += '<td >--</td>';
			htmlLines += '<td >--</td>';
			htmlLines += '</tr>';
		}
		else
		{ 
			for(var i = 0; i < instNum; i++)
			{
				htmlLines += "<tr id=\"portMappingInst_record_" + i + "\" >";
				htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_1\" " + " size=\"5\" maxlength=\"16\" style=\"width: 150px\">" +  "</td>";
				
			    htmlLines += tdClass + ">" + "<select id=\"portMappingInst_" + i + "_2\" " + " size=\"1\">"
			    htmlLines += "<option value=\"TCP\" selected>TCP</option>" + "<option value=\"UDP\">UDP</option>" + "</select></td>";

				htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_3\" " + " size=\"5\" maxlength=\"11\" style=\"width: 140px\">" +  "</td>";
				
				htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_4\" " + " size=\"5\" maxlength=\"255\" style=\"width: 250px\">" +  "</td>";
				
				htmlLines += "<td>" + "<div id=\"portMappingInst_" + i + "_5\" " + " class=\"tb_switch\" onclick=\"EnablePortMapping(this.id);\">" + "</div>" + "</td>";
				
				htmlLines += "<td>" + "<div id=\"portMappingInst_" + i + "_6\" " + " class=\"tb_delete\" onclick=\"DeletePortMapping(this.id);\">" + "</div>" + "</td>" + "</tr>";
			}
		}
		
		return htmlLines;
	}
	
	this.showTblListDelIco = function()
	{
		for(var inst = 0; inst < record.length; inst++)
		{
			var icoId = "portMappingInst_" + inst + "_6";
			$("#" + icoId).css({
				"display" : "block"
			});
		}
	}

	this.fillUpListTblInst = function()
	{
		for(var inst = 0; inst < instNum; inst++)
		{
			setText("portMappingInst_" + inst + "_1", record[inst].Name);
			setSelect("portMappingInst_" + inst + "_2", record[inst].Protocol);
			setText("portMappingInst_" + inst + "_3", record[inst].PortRange);
			setText("portMappingInst_" + inst + "_4", record[inst].IPAddress);
			enblPortList.push(record[inst].Enabled);
			setPortMapEnable("portMappingInst_" + inst + "_5" ,enblPortList[inst]);
		}
	}
	
	this.getCurListInst = function(instId)
	{
		var curRowData = new stPortMappingInst(record[instId].domain,
											getValue("portMappingInst_" + instId + "_1"),
											getValue("portMappingInst_" + instId + "_2"),
											getValue("portMappingInst_" + instId + "_3"),
											getValue("portMappingInst_" + instId + "_4"),
											enblPortList[instId]);
											
		return curRowData;
	}
	
	this.getAllListInst = function()
	{
		var curDataList = new Array();
		for(var inst = 0; inst < instNum; inst++)
		{
			curDataList.push(this.getCurListInst(inst));
		}
		
		return curDataList;
	}
	
}

function GetCurrentPortMapList()
{
    var curPortMappingList = new PortMappingInstList(PortMapping);
	return curPortMappingList;
}

function CheckForm(type)
{
    switch (type)
    {
       case 3:
          return CheckPortMappingCfg();
          break;
    }
	return true;
}

function portmappingDescpChk(portmappingDescrip)
{
    if (isValidName(portmappingDescrip) == false) 
    {
        AlertEx(ipv6portmapping_language['bbsp_mappinginvalid']);
        return false;
    }
    return true;
}

function portListInstIpChk(innerHostIp)
{
    if ((CheckIpv6Parameter(innerHostIp) == false))
    {
        AlertEx(ipv6portmapping_language['bbsp_hostipinvalid']);
        return false;
    }
	
	return true;
}

function portValueValidChk(portrange)
{
    var innerPort = $.trim(portrange);
	var portList = FormatPortStr(innerPort).split(':');
    var innerStartPort = portList[0];
    var innerEndPort = portList[0];
    if(portList.length > 1){
        innerEndPort = portList[1];
    }
	
	if(portList.length > 2)
	{
		AlertEx(ipv6portmapping_language['bbsp_portrangeinvalid']);
        return false;
	}
	
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
	
	if (innerEndPort == "")
    {
        AlertEx(ipv6portmapping_language['bbsp_endportisreq']);
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

function CheckPortMappingCfg()
{
	var MAX_INST_NUM = (getValue('PMProtocol') == "TCP/UDP") ? '31' : '32';
	
	if(PortMapping2.length >= parseInt(MAX_INST_NUM))
	{
		AlertEx(ipv6portmapping_language['bbsp_mappingfulltde']);
		return false;
	}
	
	if (true != portmappingDescpChk(getValue("PMDescription")))
	{
	    return false;
	}

	if (true != portListInstIpChk(getValue("PMIPv6Address")))
	{
	    return false;
	}
	
	if (true != portValueValidChk(getValue("PMInnerPort")))
	{
        return false;
    }
	
	return true;
}

function AddFirstParam(stDescription, ExsitFilterPath, stIpAdress, stStartPort, stEndPort, stRuleName)
{
	var Onttoken = getValue('onttoken');
	var ajaxFilterInTemp = '';
	if(ExsitFilterPath == '')
	{
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : 'GROUP_a_x.Name='+ stDescription + '&GROUP_a_x.Interface=' + InternetWanIf + '&GROUP_a_x.Type=In' + '&GROUP_a_x.IPVersion=6' + '&GROUP_a_x.DefaultAction=Drop' + '&GROUP_a_y.Enabled=1'  + '&GROUP_a_y.Protocol=TCP' + '&GROUP_a_y.Action=Permit'
			  + '&GROUP_a_y.X_HW_PrivateFlag=1' + '&GROUP_a_y.X_HW_RuleName=' + stRuleName + '&GROUP_a_y.X_HW_DstIPAddress=' + stIpAdress + '&GROUP_a_y.X_HW_DstStartPort=' + stStartPort + '&GROUP_a_y.X_HW_DstEndPort=' + stEndPort + '&x.X_HW_Token=' + Onttoken,
		url :  'addcfg.cgi?GROUP_a_x=InternetGatewayDevice.X_HW_TDE_Firewall.Firewall' + '&GROUP_a_y=GROUP_a_x.Rule'
			   + '&RequestFile=html/ipv6/not_find_file.asp',
		error:function(XMLHttpRequest, textStatus, errorThrown) 
		{
			if(XMLHttpRequest.status == 404)
			{
			}
		}
		});
	}
	else
	{
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : 'GROUP_a_y.Enabled=1'  + '&GROUP_a_y.Protocol=TCP' + '&GROUP_a_y.Action=Permit'
			  + '&GROUP_a_y.X_HW_PrivateFlag=1' + '&GROUP_a_y.X_HW_RuleName=' + stRuleName + '&GROUP_a_y.X_HW_DstIPAddress=' + stIpAdress + '&GROUP_a_y.X_HW_DstStartPort=' + stStartPort + '&GROUP_a_y.X_HW_DstEndPort=' + stEndPort + '&x.X_HW_Token=' + Onttoken,
		url :  'addcfg.cgi?GROUP_a_y=' + ExsitFilterPath + '.Rule'
			   + '&RequestFile=html/ipv6/not_find_file.asp',
		error:function(XMLHttpRequest, textStatus, errorThrown) 
		{
			if(XMLHttpRequest.status == 404)
			{
			}
		}
		});
	}

	if (ExsitFilterPath == '')
	{
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url :  "./getfirewalldataportmapping.asp",
		success : function(data){
			ajaxFilterInTemp = dealDataWithFun(data);
			}
		});
	}
	return ajaxFilterInTemp;
}

function FindFirewall()
{
	var tmpFireall = new stFirewall("", "", "", "", "");
	
	for (var i = 0; i < PortMapping1.length - 1; i ++)
	{
		if ((InternetWanIf == PortMapping1[i].Interface)
			&& ('In' == PortMapping1[i].Type)
			&& ('6' == PortMapping1[i].IPVersion))
		{
			tmpFireall = PortMapping1[i];
			break;
		}
	}

	return tmpFireall;
}

function AddSubmitParam(SubmitForm,type)
{
	setDisable('btnApply',1);
	
	var url;
	var RulePrefix = "GROUP_a_y";
	
	var stProtocol = getValue('PMProtocol');
	var stRuleName = getValue('PMDescription');
	var stDescription = '';
	var stIpAdress = getValue('PMIPv6Address');
	var stInterPort = getValue('PMInnerPort');
	
	var portList = FormatPortStr(stInterPort).split(':');
    var stStartPort = portList[0];
    var stEndPort = portList[0];
	var ExsitFilterPath = FindFirewall().domain;
	var FilterInTemp = '';
	var waninfo;
	
    if(portList.length > 1){
        stEndPort = portList[1];
    }

	waninfo = getWanOffirewall(InternetWanIf);
	if(waninfo != "&nbsp;")
	{
		stDescription = MakeWanName(waninfo) + '_' + 'In' + '_' + 'IPv6';
	}
	else
	{
		stDescription = '_' + 'In' + '_' + 'IPv6';
	}
	
	switch(stProtocol)
	{
		case "TCP":
		case "UDP":
			break;
		case "TCP/UDP":
			stProtocol = "UDP";
			FilterInTemp = AddFirstParam(stDescription, ExsitFilterPath, stIpAdress, stStartPort, stEndPort, stRuleName);
			if(FilterInTemp != '')
			{
				for (var i = 0; i < FilterInTemp.length - 1; i ++)
				{
					if ((InternetWanIf == FilterInTemp[i].Interface)
						&& ('In' == FilterInTemp[i].Type)
						&& ('6' == FilterInTemp[i].IPVersion))
					{
						ExsitFilterPath = FilterInTemp[i].domain;
						break;
					}
				}
			}
			break;
		default:
			break;
	}

	if(ExsitFilterPath == '')
	{
	    SubmitForm.addParameter('GROUP_a_x.Name', stDescription);
	    SubmitForm.addParameter('GROUP_a_x.Interface', InternetWanIf);
		SubmitForm.addParameter('GROUP_a_x.Type', 'In');
		SubmitForm.addParameter('GROUP_a_x.IPVersion', '6');
		SubmitForm.addParameter('GROUP_a_x.DefaultAction', "Drop");
	}
	SubmitForm.addParameter(RulePrefix +'.Enabled', '1');
	SubmitForm.addParameter(RulePrefix +'.Protocol', stProtocol);
	SubmitForm.addParameter(RulePrefix +'.Action', 'Permit');
	SubmitForm.addParameter(RulePrefix +'.X_HW_PrivateFlag', '1');
	SubmitForm.addParameter(RulePrefix +'.X_HW_RuleName', stRuleName);
	
	SubmitForm.addParameter('GROUP_a_y.X_HW_DstIPAddress', stIpAdress);
	SubmitForm.addParameter('GROUP_a_y.X_HW_DstStartPort', stStartPort);
	SubmitForm.addParameter('GROUP_a_y.X_HW_DstEndPort', stEndPort);

	if (ExsitFilterPath == '')
	{
		url = "addcfg.cgi?GROUP_a_x=InternetGatewayDevice.X_HW_TDE_Firewall.Firewall" + "&GROUP_a_y=GROUP_a_x.Rule" + '&RequestFile=' + fileUrl;
	}
	else
	{
		url = "addcfg.cgi?GROUP_a_y=" + ExsitFilterPath + ".Rule" + '&RequestFile=' + fileUrl;
	}

	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction(url);
    	
}

function DeletePortMapping(id)
{
	var instId = id.split('_')[1];
	var SubmitForm = new webSubmitForm();
	SubmitForm.addParameter(PortMapping[instId].domain,'');
	var filterdomainid;
	filterdomainid = GetCurrentFirewallindex(PortMapping[instId]);
	if(PortMapping1[filterdomainid].RuleNumberOfEntries == 1)
	{
		SubmitForm.addParameter(PortMapping1[filterdomainid].domain,'');
	}
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=' + fileUrl);
	SubmitForm.submit();
}

function DeletePortMappingList()
{
	if ((PortMapping.length == 0) || (InternetWanIf == ''))
	{
		return;
	}
	
	var SubmitForm = new webSubmitForm();
	var filtercnt = new Array(PortMapping1.length - 1);
	var j = 0;
	for(j = 0;j < PortMapping1.length - 1;j++)
	{
		filtercnt[j] = 0;
	}
	for(var i = 0; i < PortMapping.length; i++)
	{
		SubmitForm.addParameter(PortMapping[i].domain,'');
		var filterdomainid;
		filterdomainid = GetCurrentFirewallindex(PortMapping[i]);
		filtercnt[filterdomainid]++;
		if(PortMapping1[filterdomainid].RuleNumberOfEntries == filtercnt[filterdomainid])
		{
			SubmitForm.addParameter(PortMapping1[filterdomainid].domain,'');
		}
	}
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=' + fileUrl);
	SubmitForm.submit();
}

function GetModifiedPmList()
{
	var modifyPmList = GetCurrentPortMapList().getAllListInst();
	
	for(var i = 0; i < modifyPmList.length; i++)
	{
		if(modifyPmList[i].stProtocol != oldPmList[i].stProtocol)
		{
			modifyPmList[i].modifyFlag = true;
			continue;
		}
		if(modifyPmList[i].stPortRange != oldPmList[i].stPortRange)
		{
			modifyPmList[i].modifyFlag = true;
			continue;
		}
		if(modifyPmList[i].stName != oldPmList[i].stName)
		{
			modifyPmList[i].modifyFlag = true;
			continue;
		}
		if(modifyPmList[i].stIPAddress != oldPmList[i].stIPAddress)
		{
			modifyPmList[i].modifyFlag = true;
			continue;
		}
		if(modifyPmList[i].stEnabled != oldPmList[i].stEnabled)
		{
			modifyPmList[i].modifyFlag = true;
			continue;
		}
	}

	return modifyPmList;
}

function GetChangedPmList()
{
	var newPmList = new Array();
	var tmpPmList = GetModifiedPmList();

	for(var i = 0; i < tmpPmList.length; i++)
	{
		if(tmpPmList[i].modifyFlag == true)
		{
			newPmList.push(tmpPmList[i]);
		}
	}

	if(newPmList.length == 0)
	{
		newPmList.push(tmpPmList[0]);
	}

	return newPmList;
}

function CheckPortMappingModify(instList)
{
	for(var i = 0; i < instList.length; i++)
	{
		if (true != portmappingDescpChk(instList[i].stName))
		{
			return false;
		}
		if (true != portListInstIpChk(instList[i].stIPAddress))
		{
			return false;
		}
		if (true != portValueValidChk(instList[i].stPortRange))
		{
			return false;
		}
	}
	
	return true;
}

function GetRowIndexByDomain(_domain)
{
	var rowIndex = 0;
	for(var i = 0; i < PortMapping.length; i++)
	{
		if(_domain == PortMapping[i].domain)
		{
			rowIndex = i;
		}
	}
	
	return rowIndex;
}

function ModifyPortMappingList()
{
	var prefixList = new Array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
	var needModifyList = GetChangedPmList();
	
	if ((true != CheckPortMappingModify(needModifyList)) || (InternetWanIf == ''))
	{
		return false;
	}
	
	setDisable('btnModify',1);
	setDisable('btnDelete',1);
	
	var instPrefix;
	var rulePrefix;
	var destPrefix;
	var SubmitForm = new webSubmitForm();
	var url = 'complex.cgi?';
	for(var i = 0; i < needModifyList.length; i++)
	{
		instPrefix = prefixList[i];
		rulePrefix = 'm' + prefixList[i];
		destPrefix = 'n' + prefixList[i];
		
		var pref1 = (i == 0) ? instPrefix : ('&' + instPrefix);
		var pref2 = rulePrefix + '=' + needModifyList[i].domain;
		var pref3 = destPrefix + '=' + needModifyList[i].domain;
		var rowindex = GetRowIndexByDomain(needModifyList[i].domain);
	
		url += pref1 + '=' + needModifyList[i].domain + '&' + pref2 + '&' + pref3;
		
		SubmitForm.addParameter(instPrefix+'.X_HW_RuleName', getValue("portMappingInst_" + rowindex + "_1"));
		SubmitForm.addParameter(rulePrefix+'.Enabled', enblPortList[rowindex]);
		SubmitForm.addParameter(rulePrefix+'.Protocol', getValue("portMappingInst_" + rowindex + "_2"));
		
		SubmitForm.addParameter(destPrefix+'.X_HW_DstIPAddress', getValue("portMappingInst_" + rowindex + "_4"));

		var portList = FormatPortStr(getValue("portMappingInst_" + rowindex + "_3")).split(':');
		var stStartPort = portList[0];
		var stEndPort = portList[0];
		if(portList.length > 1){
			stEndPort = portList[1];
		}
		SubmitForm.addParameter(destPrefix+'.X_HW_DstStartPort', stStartPort);
		SubmitForm.addParameter(destPrefix+'.X_HW_DstEndPort', stEndPort)
	}
	
	url +=  '&RequestFile=' + fileUrl;
	
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction(url);
	SubmitForm.submit();
	
}

function JumpToModify()
{
	if ((PortMapping.length == 0) || (InternetWanIf == ''))
	{
		return;
	}
	
	setDisplay('btnEditRow', 0);
	setDisplay('btnModifyRow', 1);
	GetCurrentPortMapList().showTblListDelIco();
    AllowEditFlag = true;
    setAllDisableTDE(0);
	
}

function getHeight(id)
{
	var item = id;
	var height;
	if (item != null)
	{
		if (item.style.display == 'none')
		{
			return 0;
		}
		if (navigator.appName.indexOf("Internet Explorer") == -1)
		{
			height = item.offsetHeight;
		}
		else
		{
			height = item.scrollHeight;
		}
		if (typeof height == 'number')
		{
			return height;
		}
		return null;
	}

	return null;
}

function adjustParentHeight()
{
	var dh = getHeight(document.getElementById("DivContent"));
	var height = dh > 0 ? dh : 0;
	window.parent.adjustParentHeight("PortmappingWarpContent", height+10);
}

function LoadFrame()
{
	if(PortMapping.length == 0)
	{
		setDisplay('btnEditRow', 0);
	}
	else
	{
		setDisplay('btnEditRow', 1);
	}
	
	
	setText('PMIPv6Address', Br0IPv6Prefix);
	
	GetCurrentPortMapList().fillUpListTblInst();
	
	oldPmList = GetCurrentPortMapList().getAllListInst();
	
	adjustParentHeight();

    setAllDisableTDE(1);
    AllowEditFlag = false;
	
	if (InternetWanIf == '')
	{
		setDisable('PMDescription',1);
		setDisable('PMIPv6Address',1);
		setDisable('PMProtocol',1);
		setDisable('PMInnerPort',1);
		setDisable('btnApply',1);
		setDisable('btnEdit',1);
		setDisable('btnModifyRow',1);
		setDisable('btnModify',1);
		setDisable('btnDelete',1);
	}
	else
	{
		setDisable('PMDescription',0);
		setDisable('PMIPv6Address',0);
		setDisable('PMProtocol',0);
		setDisable('PMInnerPort',0);
		setDisable('btnApply',0);
		setDisable('btnEdit',0);
		setDisable('btnModifyRow',0);
		setDisable('btnModify',0);
		setDisable('btnDelete',0);
	}
}

var TableClass = new stTableClass("PageSumaryTitleCss table_title width_per40", "table_right", "");

</script>
<style type="text/css">
	.TextBox
	{
		width:280px;  
	}
	.Select
	{
		width:153px;  
	}
	.SelectCfg
	{
		width:153px; 
	}
	.tb_switch
	{
		height: 20px;
		width: 55px;
		background: url(../../../images/cus_images/btn_on.png) no-repeat;
	}
	.tb_delete
	{
		height: 20px;
		width: 25px;
		background: url(../../../images/cus_images/del.png) no-repeat;
		display : none;
	}
</style>
</head>
<body onLoad="LoadFrame();" class="iframebody" >
<div id="DivContent">
<div class="title_spread"></div>
<div id="FuctionPageArea" class="FuctionPageAreaCss">
<div id="FunctionPageTitle" class="FunctionPageTitleCss">
<span id="PageTitleText" class="PageTitleTextCss" BindText="bbsp_ipv6ports"></span>
</div>
<div id="PmContentitle" class="FuctionPageContentCss">
<div id="PageSumaryInfo1" class="PageSumaryInfoCss" BindText="bbsp_portmapping_title_tde"></div>
</div>
<form id="ConfigForm">
<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li   id="PMDescription"   RealType="TextBox"            DescRef="bbsp_mappingtde"       RemarkRef="Empty"   		  ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"      InitValue="Empty"  Maxlength="16"/>
<li   id="PMIPv6Address"   RealType="TextBox"  			DescRef="bbsp_inthosttde"       RemarkRef="Empty"     	  ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   InitValue="Empty"  MaxLength="256"/>                                                                  
<li   id="PMProtocol"      RealType="DropDownList"       DescRef="bbsp_protocolmh"      RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"  Elementclass="SelectCfg"   InitValue="[{TextRef:'TCP',Value:'TCP'},{TextRef:'UDP',Value:'UDP'},{TextRef:'TCPUDP',Value:'TCP/UDP'}]"/>
<li   id="PMInnerPort"     RealType="TextBox"            DescRef="bbsp_intportmh"       RemarkRef="bbsp_portrange"   ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"             InitValue="Empty"/>
</table>
<script>
PortMappingCfgFormList = HWGetLiIdListByForm("ConfigForm", null);
HWParsePageControlByID("ConfigForm", TableClass, ipv6portmapping_language, null);
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" > 
  <tr> 
	<td class="table_submit"> 
		<button name="btnApply" id="btnApply" type="button" class="BluebuttonGreenBgcss buttonwidth_100px" onClick="Submit(3);"><script>document.write(ipv6portmapping_language['bbsp_add']);</script></button>
  </tr> 
</table> 
</form>
<div style="height:20px;"></div>
<table class="tabal_noborder_bg" id="portMappingInst" width="100%" cellpadding="0" cellspacing="1" style="padding-left:10px;padding-right:10px;"> 
<tr class="head_title_tde"> 
  <td width="25%" BindText='bbsp_mappingtde1'></td> 
  <td width="10%" BindText='bbsp_protocol'></td> 
  <td width="25%" BindText='bbsp_intporttde'></td> 
  <td width="30%" BindText='bbsp_inthosttde1'></td> 
  <td width="10%" colspan="2" BindText='bbsp_enabletde'></td> 
</tr> 
<script language="JavaScript" type="text/javascript">
document.write(GetCurrentPortMapList().showPortmappingList());
</script> 
</table> 

<table width="100%" border="0" cellspacing="0" cellpadding="0" > 
  <tr id="btnEditRow"> 
	<td class="title_bright1"> 
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<a id="btnEdit" href="#" onClick="JumpToModify();" style="font-size:14px;color:#266B94;text-decoration:none;white-space:nowrap;padding-right:180px;"><script>document.write(ipv6portmapping_language['bbsp_edit']);</script></a></td> 
  </tr> 
  <tr id="btnModifyRow" style="display:none"> 
	<td class="title_bright1"> 
	<a id="btnModify" href="#" onClick="ModifyPortMappingList();" style="font-size:14px;color:#266B94;text-decoration:none;white-space:nowrap;margin-left:10px;margin-right:10px"><script>document.write(ipv6portmapping_language['bbsp_ok']);</script></a>
	<a id="btnEmpty" style="margin-left:10px;margin-right:10px"></a>
	<a id="btnDelete" href="#" onClick="DeletePortMappingList();" style="font-size:14px;color:#266B94;text-decoration:none;white-space:nowrap;margin-left:5px;margin-right:5px"><script>document.write(ipv6portmapping_language['bbsp_del_all']);</script></a></td> 
  </tr> 
</table> 
<div style="height:20px;"></div>
</div>
</div>
<div style="height:20px;"></div>
<script>
ParseBindTextByTagName(ipv6portmapping_language, "span",  1);
ParseBindTextByTagName(ipv6portmapping_language, "td",    1);
ParseBindTextByTagName(ipv6portmapping_language, "div",  1);
</script>
</body>
</html>
