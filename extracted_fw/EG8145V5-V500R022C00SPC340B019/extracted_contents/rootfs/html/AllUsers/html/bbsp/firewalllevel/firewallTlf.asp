<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>Firewall</title>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(gateway.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../../bbsp/common/wan_check.asp"></script>
<style>
	input.messageInput,select.messageInput{
		height:24px;
		line-height:24px;
		display:inline-block;
		color: #666666;
		padding:0px;
		text-align:center;
		background-color: inherit;
		font-weight:inherit;
		font-size:inherit;
	}
	input[disabled],select[disabled]{
		color: #666666;
		background-color: inherit;
		border-width:0px;
	}
	input.name{
		width:65px;
	}
	td.tdSelect{
		position:relative;
	}
	select.protocol{
		width:65px;
		background-color: transparent;
	
	}
	select.IPVersion{
		background-color: transparent;
	}
	.nullDiv{
		position:absolute;
		width:26px;
		height:26px;
		top:10px;
		right:3px;
		background-color: inherit;
	}
	input.port{
		width:70px;
	}
	input.ip{
		width:70px;
	}
	#rulesListTbody input {
    background-color: transparent;
    border:0 solid #e4e4e4;
	padding-left:0px; 
    }

	#rulesListTbody tr td {
	text-align: center!important;
	padding-left: 4px;
	padding-right: 4px;
	}
	.action {
	display: block;
	float: left;
	}
</style>
<script language="JavaScript" type="text/javascript">

function stDosFilter(domain, IcmpEchoReplyEn, PingSweepEn)
{
	this.domain = domain;
	this.IcmpEchoReplyEn = IcmpEchoReplyEn;
	this.PingSweepEn = PingSweepEn;
}

function stFireWallRule(domain, Order, Enable, Description, Target, SourceInterface, DestInterface, DestIP, DestMask, SourceIP, SourceMask, Protocol, DestPort, DestPortRangeMax, SourcePort, SourcePortRangeMax, IPVersion)
{
	this.domain = domain;
	this.Order = Order;
	this.Enable = Enable;
	this.Description = Description;
	this.Target = Target;
	this.SourceInterface = SourceInterface;
	this.DestInterface = DestInterface;
	this.DestIP = DestIP;
	this.DestMask = DestMask;
	this.SourceIP = SourceIP;
	this.SourceMask = SourceMask;
	this.Protocol = Protocol;
	this.DestPort = DestPort;
	this.DestPortRangeMax = DestPortRangeMax;
	this.SourcePort = SourcePort;
	this.SourcePortRangeMax = SourcePortRangeMax;
	this.action = getImgAction(SourceInterface.toUpperCase(), DestInterface.toUpperCase(), Target.toUpperCase());
	this.IPVersion = ("-1" == IPVersion) ? "4":IPVersion;
}

function stFireWallLevel(domain, DefaultPolicy)
{
	this.domain = domain;
	this.DefaultPolicy = DefaultPolicy;
}

var AdvancedLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.Firewall.AdvancedLevel);%>';												
var fireWallLevel = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Firewall.Level.{i}, DefaultPolicy, stFireWallLevel);%>;
var fireWallRuleAll = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Firewall.Chain.{i}.Rule.{i}, Order|Enable|Description|Target|SourceInterface|DestInterface|DestIP|DestMask|SourceIP|SourceMask|Protocol|DestPort|DestPortRangeMax|SourcePort|SourcePortRangeMax|IPVersion, stFireWallRule);%>;

var pingWanDos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Dosfilter, IcmpEchoReplyEn|PingSweepEn, stDosFilter);%>;

var levelInstId = '2';
if (AdvancedLevel != '')
{
	levelInstId = AdvancedLevel.split('Level.')[1];	
	
	while ((levelInstId != null) && (levelInstId.substr(levelInstId.length-1, levelInstId.length) == "."))
	{
   		levelInstId = levelInstId.substr(0, levelInstId.length-1);
	}
}
var defaultPolicy = 'Drop';
if (fireWallLevel.length > levelInstId)
{
	defaultPolicy = fireWallLevel[levelInstId - 1].DefaultPolicy;
}
var fireWallRule = new Array();
var index = 0;
for (var i = 0; i < fireWallRuleAll.length - 1; i++)
{
	if (fireWallRuleAll[i].domain.split('.')[4] == levelInstId)
	{
		fireWallRule[index]=fireWallRuleAll[i];
		index++;
	}
}

fireWallRule.sort(function(a,b){
	return a.Order - b.Order;
});

function LoadFrame()
{
	if ('DROP' == defaultPolicy.toUpperCase())
	{
		document.getElementById("defaultPolicyReject").checked = true;
		document.getElementById("defaultPolicyAccept").checked = false;
	}
	else
	{
		document.getElementById("defaultPolicyAccept").checked = true;
		document.getElementById("defaultPolicyReject").checked = false;
	}

	if ((pingWanDos[0].IcmpEchoReplyEn == '0') && (pingWanDos[0].PingSweepEn == '0'))
	{
		document.getElementById("pingWANInterfaceReject").checked = false;
		document.getElementById("pingWANInterfaceAccept").checked = true;
	}
	else
	{
		document.getElementById("pingWANInterfaceAccept").checked = false;
		document.getElementById("pingWANInterfaceReject").checked = true;
	}	
	
	displayRulesList();
}

function chooseDefaultPolicy($this)
{
	var defaultPolicyUpdate = "";
	if ($this.id=="defaultPolicyReject")
	{
		document.getElementById("defaultPolicyAccept").checked = false;
		document.getElementById("defaultPolicyReject").checked = true;
		defaultPolicyUpdate = "Drop";	
	}
	else if($this.id=="defaultPolicyAccept")
	{
		document.getElementById("defaultPolicyReject").checked = false;
		document.getElementById("defaultPolicyAccept").checked = true;
		defaultPolicyUpdate = "Accept";
	}
	
	var ConfigParaList = new Array(new stSpecParaArray("x.DefaultPolicy", defaultPolicyUpdate , 0));
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = ConfigParaList;
	var ConfigUrl = "set.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall.Level." + levelInstId 
						+ "&RequestFile=html/bbsp/firewalllevel/firewallTlf.asp";							  
	HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));
}

function choosePingWANInterface($this)
{
	var icmpEchoReplyEnUpdate = "";
	var pingSweepEnUpdate = "";
	if (($this.id=="pingWANInterfaceReject")
		&& (pingWanDos[0].IcmpEchoReplyEn == "0")
		&& (pingWanDos[0].PingSweepEn == "0"))
	{
		document.getElementById("pingWANInterfaceReject").checked = true;
		document.getElementById("pingWANInterfaceAccept").checked = false;
		icmpEchoReplyEnUpdate = "1";
		pingSweepEnUpdate = "1";
	}
	else if(($this.id=="pingWANInterfaceAccept")
		&& ((pingWanDos[0].IcmpEchoReplyEn != "0") || (pingWanDos[0].PingSweepEn != "0")))
	{
		document.getElementById("pingWANInterfaceAccept").checked = true;
		document.getElementById("pingWANInterfaceReject").checked = false;
		icmpEchoReplyEnUpdate = "0";
		pingSweepEnUpdate = "0";
	}
	if (icmpEchoReplyEnUpdate == "")
	{
		return;
	}
	var ConfigParaList = new Array(new stSpecParaArray("x.IcmpEchoReplyEn", icmpEchoReplyEnUpdate , 0),
								   new stSpecParaArray("x.PingSweepEn", pingSweepEnUpdate , 0));
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = ConfigParaList;
	var ConfigUrl = "set.cgi?x=InternetGatewayDevice.X_HW_Security.Dosfilter" 
						+ "&RequestFile=html/bbsp/firewalllevel/firewallTlf.asp";
								  
	HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));
	
}

function chooseAction($this)
{
	var curAction = $($this).val();
	var actionToImg = $($('#imgAction img')[0]);
	switch(curAction)
	{	
		case 'Reject from local':
			actionToImg.attr('src','../../../images/rjctLocal.gif');
			break;
		case 'Reject from remote':
			actionToImg.attr('src','../../../images/rjctRemote.gif');
			break;
		case 'Reject in both way':
			actionToImg.attr('src','../../../images/rjctBoth.gif');
			break;
		case 'Accept from local':
			actionToImg.attr('src','../../../images/acptLocal.gif');
			break;
		case 'Accept from remote':
			actionToImg.attr('src','../../../images/acptRemote.gif');
			break;
		case 'Accept in both way':
			actionToImg.attr('src','../../../images/acptBoth.gif');
			break;
		default:
			break;		
	}
}	

function checkForm(ruleName, localPort, remotePort, localIP, remoteIP, protocol, IPVersion)
{	

	if (((fireWallRule.length >= 31) && (protocol == '6/17'))
		|| (fireWallRule.length >= 32))
	{
		AlertEx(firewalllevel_language['bbsp_firewallfull']);
	}

	if (localIP != "")
	{
		if((isAbcIpAddress(localIP) == false && CheckIpv6Parameter(localIP) == false))
		{
			AlertEx(firewalllevel_language['bbsp_localip_invalid']);
			return false;
		}
		
		if(("4" == IPVersion)&& (isAbcIpAddress(localIP) == false))
		{
			AlertEx(firewalllevel_language['bbsp_localip_invalid']);
			return false;
		}
		if(("6" == IPVersion)&& (CheckIpv6Parameter(localIP) == false ))
		{
			AlertEx(firewalllevel_language['bbsp_localip_invalid']);
			return false;
		}
		
	}
	
	if(remoteIP != "")
	{	
		if((isAbcIpAddress(remoteIP) == false && CheckIpv6Parameter(remoteIP) == false))
		{
			AlertEx(firewalllevel_language['bbsp_remoteip_invalid']);
			return false;
		}
		if(("4" == IPVersion)&& (isAbcIpAddress(remoteIP) == false))
		{
			AlertEx(firewalllevel_language['bbsp_remoteip_invalid']);
			return false;
		}
		if(("6" == IPVersion)&& (CheckIpv6Parameter(remoteIP) == false ))
		{
			AlertEx(firewalllevel_language['bbsp_remoteip_invalid']);
			return false;
		}
	}

	if (localPort != '')
	{
		var localPortList = localPort.split(':');
		var startLocalPort = '';
		var endLocalPort = '';
		
		startLocalPort = localPortList[0];
		if (localPortList.length > 1)
		{		
			endLocalPort = localPortList[1];
		}
	    		
		if (isValidPort2(startLocalPort) == false)
		{
		    AlertEx(firewalllevel_language['bbsp_localport_invalid']);
	        return false;
		}

	    if ((endLocalPort != "") && ( isValidPort2(endLocalPort) == false))
	    {
	        AlertEx(firewalllevel_language['bbsp_localport_invalid']);
	        return false;
	    }
		
		if ((startLocalPort.charAt(0) != "0") && (endLocalPort.charAt(0) != "0") && (parseInt(endLocalPort,10) < parseInt(startLocalPort,10)))
	    {
		    AlertEx(firewalllevel_language['bbsp_intstartportleqendport']);
		    return false;     	
	    }
	}

	if (remotePort != '')
	{
		var remotePortList = remotePort.split(':');
		var startRemotePort = '';
		var endRemotePort = '';
		
		startRemotePort = remotePortList[0];
		if (remotePortList.length > 1)
		{		
			endRemotePort = remotePortList[1];
		}
	    
		if  (isValidPort2(startRemotePort) == false)
		{
		    AlertEx(firewalllevel_language['bbsp_remoteport_invalid']);
	        return false;
		}

	    if ((endRemotePort != "") && (isValidPort2(endRemotePort) == false))
	    {
	        AlertEx(firewalllevel_language['bbsp_remoteport_invalid']);
	        return false;
	    }
		
		if ((startRemotePort.charAt(0) != "0") && (endRemotePort.charAt(0) != "0") && (parseInt(endRemotePort,10) < parseInt(startRemotePort,10)))
	    {
		    AlertEx(firewalllevel_language['bbsp_extstartportleqendport']);
		    return false;     	
	    }
	}
	
	return true;
}

function addUDPAppendRule(ruleName, paraPortAndIPs, paraInterfaceAndTargets, IPVersion)
{
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	data : 'x.Enable=1'+'&x.Description=' + encodeURIComponent(ruleName) +'&x.Protocol=17' + '&x.SourcePort=' + paraPortAndIPs.sourcePort 
		  + '&x.IPVersion=' + IPVersion 
	      + '&x.SourcePortRangeMax=' + paraPortAndIPs.sourcePortRangeMax + '&x.DestPort=' + paraPortAndIPs.destPort 
	      + '&x.DestPortRangeMax=' + paraPortAndIPs.destPortRangeMax + '&x.SourceIP=' + paraPortAndIPs.sourceIP 
	      + '&x.DestIP=' + paraPortAndIPs.destIP +'&x.SourceInterface=' + paraInterfaceAndTargets[0] +'&x.DestInterface=' 
		  + paraInterfaceAndTargets[1] + '&x.Target=' + paraInterfaceAndTargets[2] + '&x.X_HW_Token=' + getValue('onttoken'),
	url :  "addcfg.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall.Chain." + levelInstId + '.Rule'
		   + '&RequestFile=html/ipv6/not_find_file.asp',
	error:function(XMLHttpRequest, textStatus, errorThrown) 
	{
		if(XMLHttpRequest.status == 404)
		{
		}
	}
	});
}
	
function getInterfaceAndTargetByAction(action)
{
	var pairs = {'Reject from local':'LAN:WAN:Drop',
				 'Reject from remote':'WAN:LAN:Drop',
				 'Reject in both way':'::Drop',
				 'Accept from local':'LAN:WAN:Accept',
				 'Accept from remote':'WAN:LAN:Accept',
				 'Accept in both way':'::Accept'};
	try
	{
		return pairs[action];
	}
	catch(e)
	{
		return "";
	}
}

function getInterfaceDirection(interface)
{
	var interfaceNew = interface;
	if (interface.toUpperCase().indexOf('LAN') >= 0)
	{
		interfaceNew = 'LAN';
	}

	if (interface.toUpperCase().indexOf('WAN') >= 0)
	{
		interfaceNew = 'WAN';
	}
	return interfaceNew;
}

function getImgAction(SourceInterface, DestInterface, Target)
{
	var pairs = {'LAN:WAN:DROP':'Reject from local',
				 'WAN:LAN:DROP':'Reject from remote',
				 '::DROP':'Reject in both way',
				 'LAN:WAN:ACCEPT':'Accept from local',
				 'WAN:LAN:ACCEPT':'Accept from remote',
				 '::ACCEPT':'Accept in both way',
				 'LAN::ACCEPT':'Accept from local',
				 'WAN::ACCEPT':'Accept from remote',
				 ':LAN:ACCEPT':'Accept from remote',
				 ':WAN:ACCEPT':'Accept from local',
				 'LAN::DROP':'Reject from local',
				 'WAN::DROP':'Reject from remote',
				 ':LAN:DROP':'Reject from remote',
				 ':WAN:DROP':'Reject from local'};
	var SourceInterfaceNew = getInterfaceDirection(SourceInterface);
	var DestInterfaceNew = getInterfaceDirection(DestInterface);
	var sourcePara = SourceInterfaceNew + ':' + DestInterfaceNew + ':' + Target;
	try
	{
		return pairs[sourcePara];
	}
	catch(e)
	{
		return "";
	}
	
}

function SetPortDefultValue(PortValue)
{
	if("" == PortValue)
	{
		return -1;
	}
	return PortValue;
}

function getPortAndIPByAction(action, localIP, remoteIP, localPort, remotePort)
{
	var portListLocal = localPort.split(':');
	var portListRemote = remotePort.split(':');

	portListLocal[0] = SetPortDefultValue(portListLocal[0]);
	portListRemote[0] = SetPortDefultValue(portListRemote[0]);
	
	if (action.toUpperCase().indexOf('REMOTE') >= 0)
	{
		return {sourceIP:remoteIP,
				destIP:localIP,
				sourcePort:portListRemote[0], 
				sourcePortRangeMax:SetPortDefultValue(portListRemote.length > 1 ? portListRemote[1]:portListRemote[0]),
				destPort:portListLocal[0],
				destPortRangeMax:SetPortDefultValue(portListLocal.length > 1 ? portListLocal[1]:portListLocal[0])};
	}
	else
	{
		return {sourceIP:localIP,
				destIP:remoteIP,
				sourcePort:portListLocal[0], 
				sourcePortRangeMax:SetPortDefultValue(portListLocal.length > 1 ? portListLocal[1]:portListLocal[0]),
				destPort:portListRemote[0],
				destPortRangeMax:SetPortDefultValue(portListRemote.length > 1 ? portListRemote[1]:portListRemote[0])};
	}

}

function AddSubmitParam()
{
	var ruleName = getValue('ruleName');
	var protocol = getSelectVal('protocol');
	var IPVersion = getSelectVal('IPVersion');	
	var localPort = getValue('localPort');
	var remotePort = getValue('remotePort');
	var localIP = getValue('localIP');
	var remoteIP = getValue('remoteIP');
	var action = getSelectVal('selectAction');

	var paraInterfaceAndTargets = getInterfaceAndTargetByAction(action);
	if (paraInterfaceAndTargets == "")
	{
		return;
	}
	paraInterfaceAndTargets = paraInterfaceAndTargets.split(':');	

	if (true != checkForm(ruleName, localPort, remotePort, localIP, remoteIP, protocol, IPVersion))
	{
		return;
	}

	var paraPortAndIPs = getPortAndIPByAction(action, localIP, remoteIP, localPort, remotePort);
	
	if (protocol == '6/17')
	{
		addUDPAppendRule(ruleName, paraPortAndIPs, paraInterfaceAndTargets, IPVersion);
		protocol = '6';
	}

	var ConfigParaList = new Array(new stSpecParaArray("x.Enable", '1', 0),
								   new stSpecParaArray("x.Description", ruleName, 0),
								   new stSpecParaArray("x.Protocol", protocol, 0),
								   new stSpecParaArray("x.SourcePort", paraPortAndIPs.sourcePort, 0),
								   new stSpecParaArray("x.SourcePortRangeMax", paraPortAndIPs.sourcePortRangeMax, 0),
								   new stSpecParaArray("x.DestPort", paraPortAndIPs.destPort, 0),
								   new stSpecParaArray("x.DestPortRangeMax", paraPortAndIPs.destPortRangeMax, 0),								  
								   new stSpecParaArray("x.SourceIP", paraPortAndIPs.sourceIP, 0),
								   new stSpecParaArray("x.DestIP", paraPortAndIPs.destIP, 0),
								   new stSpecParaArray("x.SourceInterface", paraInterfaceAndTargets[0], 0),
								   new stSpecParaArray("x.DestInterface", paraInterfaceAndTargets[1], 0),
								   new stSpecParaArray("x.Target", paraInterfaceAndTargets[2], 0),
								   new stSpecParaArray("x.IPVersion", IPVersion, 0));
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = ConfigParaList;
	var ConfigUrl = "add.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall.Chain." + levelInstId + '.Rule'
						+ "&RequestFile=html/bbsp/firewalllevel/firewallTlf.asp";
	
	HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));
}

function CancelConfig(){
	$('#ruleTbody input').each(function(){
		$(this).val('');
	});
	$('#ruleTbody select').each(function(){
		$(this).val($(this).children('option:first').val());
	});

	chooseAction(getElementById('selectAction'));
}

function protocolToOption(obj,protocolList){
	obj.each(function(index){
		$(this).val(protocolList[index]);
	});
}

function ipMaskToNumMask(mask)	
{
	if (isValidSubnetMask(mask) == false)
	{
		return 32;
	}
	var maskParts = mask.split('.');
	var num = 0;
	for (var i = 0; i < 4; i++)
	{
		for (var j = 0; j < 8; j++)
		{
			if (parseInt(maskParts[i], 10) && (0x01 << j))
			{
				num++;
			}
			else
			{
				break;
			}
		}
	}
	return num;
}

function disIPAndMask(ip, mask)
{
	var maskNum = ipMaskToNumMask(mask);
	return ip + '/' + maskNum;
}

function getSrcImg(action)
{
	var pairs = {'Reject from local':'../../../images/rjctLocal.gif',
				 'Reject from remote':'../../../images/rjctRemote.gif',
				 'Reject in both way':'../../../images/rjctBoth.gif',
				 'Accept from local':'../../../images/acptLocal.gif',
				 'Accept from remote':'../../../images/acptRemote.gif',
				 'Accept in both way':'../../../images/acptBoth.gif'};
	try
	{
		return pairs[action];
	}
	catch(e)
	{
		return "";
	}
}

function getPortPair(portStart, portEnd)
{
	if (portStart != '-1' && portEnd != '-1')
	{
		return portStart+':'+portEnd;
	}
	else if (portStart != '-1')
	{
		return portStart;
	}
	else if (portEnd != '-1')
	{
		return portEnd; 
	}
	else
	{
		return '*';
	}
}


function getDisplayIP(ip)
{
	return (ip==''?'*':ip);
}

function getDisplayParaByDirection(rule)
{
	if (rule.action.toUpperCase().indexOf('REMOTE') >= 0)
	{
		return {localPort:getPortPair(rule.DestPort, rule.DestPortRangeMax),
				remotePort:getPortPair(rule.SourcePort, rule.SourcePortRangeMax),				
				localIP:getDisplayIP(rule.DestIP),
				remoteIP:getDisplayIP(rule.SourceIP)};
	}
	return {localPort:getPortPair(rule.SourcePort, rule.SourcePortRangeMax),
			remotePort:getPortPair(rule.DestPort, rule.DestPortRangeMax),
			localIP:getDisplayIP(rule.SourceIP),
			remoteIP:getDisplayIP(rule.DestIP)};
}

function displayRulesList()
{
	$('#rulesListTbody').html('');
	
	var rulesListTr =  '';
	var protocolList = [];
	var IPprotocolList = [];
	var localPort = '';
	var remotePort = '';
	
	for(var i=0;i< fireWallRule.length;i++)
	{
		var actionDiv = '<div class="actions" style="margin-left:0px; margin-right:-8px; padding-left:0;">'
						+'<a class="action edit"><img id="ruleList_'+ i +'_8" class="img-actions" src="../../../images/edit2.gif" style="margin-left:5px;" onclick="editRule(this, ' + i +');return false;"></a> '
						+'<a class="action delete"><img id="ruleList_'+ i +'_9"  class="img-actions" src="../../../images/trash.gif" style="margin-left:5px;" onclick="deleteRule(this.id,' + i +');return false;"></a>' 
						+'<a class="action"><img id="ruleList_'+ i +'_10" class="img-actions" src="../../../images/arrow_up.gif" style="width:16px; height:8px; margin: 10px 2px;" onclick="RuleUp(this);return false;"></a> '	
						+'<a class="action"><img id="ruleList_'+ i +'_11" class="img-actions" src="../../../images/arrow_down.gif" style="width:16px; height:8px; margin: 10px 2px;" onclick="RuleDown(this);return false;"></a> '											
					+'</div>';
		var paras = getDisplayParaByDirection(fireWallRule[i]);
		
		localPort = getPortPair(fireWallRule[i].SourcePort, fireWallRule[i].SourcePortRangeMax);
		remotePort = getPortPair(fireWallRule[i].DestPort, fireWallRule[i].DestPortRangeMax);
		if(i%2==0)
		{
			rulesListTr += '<tr>'
				+'<td class="cinza"><input class="messageInput name" style="width:50px;" id="ruleList_'+ i +'_1" value="'+GetStringContentForTitle(htmlencode(fireWallRule[i].Description),4)+'" title="'+htmlencode(fireWallRule[i].Description)+'"></td>'
			
			if(fireWallRule[i].Protocol != 1)
			{
				protocolList.push(fireWallRule[i].Protocol);
				rulesListTr += '<td class="cinza tdSelect"><select class="messageInput protocol"  style="width:55px;padding-left:0px;" id="ruleList_'+ i +'_2" value="'+fireWallRule[i].Protocol+'"><option value="6">TCP</option><option value="17">UDP</option></select></td>'
			}
			else
			{
				rulesListTr += '<td class="cinza tdSelect"><input class="messageInput protocol"  style="width:55px;padding-left:0px;" id="ruleList_'+ i +'_2" value="ICMP"></td>'
			}

			rulesListTr += '<td class="cinza tdSelect"><select class="messageInput IPVersion" style="width:60px;padding-left:0px;" id="ruleList_'+ i +'_3" value="'+ fireWallRule[i].IPVersion +'"><option value="4">IPv4</option><option value="6">IPv6</option></select></td>'
				+'<td class="cinza"><input class="messageInput port" style="width:67px;" id="ruleList_'+ i +'_4" value="'+paras.localPort+'"></td>'
				+'<td class="cinza"><input class="messageInput ip" style="width:80px;" id="ruleList_'+ i +'_5" value="'+GetStringContentForTitle(htmlencode(paras.localIP),10)+'" title="'+htmlencode(paras.localIP)+'"></td>'
				+'<td class="cinza"><img class="" style="width:45px;" id="ruleList_'+ i +'_6" src="'+getSrcImg(fireWallRule[i].action)+'"></td>'
				+'<td class="cinza"><input class="messageInput ip" style="width:80px;" id="ruleList_'+ i +'_7" value="'+GetStringContentForTitle(htmlencode(paras.remoteIP),10)+'" title="'+htmlencode(paras.remoteIP)+'"></td>'
				+'<td class="cinza"><input class="messageInput port" style="width:67px;" id="ruleList_'+ i +'_8" value="'+paras.remotePort+'"></td>'
				+'<td colspan="3" class="cinza">'+actionDiv+'</td>'
				'</tr>';
		}
		else
		{
			rulesListTr += '<tr>'
			+'<td class="cinza2"><input class="messageInput name" style="width:50px;" id="ruleList_'+ i +'_1" value="'+GetStringContentForTitle(htmlencode(fireWallRule[i].Description),4)+'" title="'+htmlencode(fireWallRule[i].Description)+'"></td>'
			
			if(fireWallRule[i].Protocol != 1)
			{
				protocolList.push(fireWallRule[i].Protocol);
				rulesListTr += '<td class="cinza2 tdSelect"><select class="messageInput protocol"  style="width:55px;padding-left:0px;" id="ruleList_'+ i +'_2" value="'+fireWallRule[i].Protocol+'"><option value="6">TCP</option><option value="17">UDP</option></select></td>'
				
			}
			else
			{
				rulesListTr += '<td class="cinza2 tdSelect"><input class="messageInput protocol"  style="width:55px;padding-left:0px;" id="ruleList_'+ i +'_2" value="ICMP"></td>'
			}
			
			rulesListTr += '<td class="cinza2 tdSelect"><select class="messageInput IPVersion" style="width:60px;padding-left:0px;" id="ruleList_'+ i +'_3" value="'+ fireWallRule[i].IPVersion +'"><option value="4">IPv4</option><option value="6">IPv6</option></select></td>'
				+'<td class="cinza2"><input class="messageInput port" style="width:67px;" id="ruleList_'+ i +'_4" value="'+paras.localPort+'"></td>'
				+'<td class="cinza2"><input class="messageInput ip" style="width:80px;" id="ruleList_'+ i +'_5" value="'+GetStringContentForTitle(htmlencode(paras.localIP),10)+'" title="'+htmlencode(paras.localIP)+'"></td>'
				+'<td class="cinza2"><img class="" style="width:45px;" id="ruleList_'+ i +'_6" src="'+getSrcImg(fireWallRule[i].action)+'"></td>'
				+'<td class="cinza2"><input class="messageInput ip" style="width:80px;" id="ruleList_'+ i +'_7" value="'+GetStringContentForTitle(htmlencode(paras.remoteIP),10)+'" title="'+htmlencode(paras.remoteIP)+'"></td>'
				+'<td class="cinza2"><input class="messageInput port" style="width:67px;" id="ruleList_'+ i +'_8" value="'+paras.remotePort+'"></td>'
				+'<td colspan="3" class="cinza2">'+actionDiv+'</td>'
				'</tr>';
		}
		
        IPprotocolList.push(fireWallRule[i].IPVersion);		
	}
	$('#rulesListTbody').html(rulesListTr);
	var Rulelenth = fireWallRule.length - 1;
	if(fireWallRule.length > 0)
	{
		document.getElementById("ruleList_0_10").src ="../../../images/arrowup.jpg";
		document.getElementById("ruleList_0_10").onclick = function(){};
		document.getElementById("ruleList_"+ Rulelenth + "_11").src ="../../../images/arrowdown.jpg";
		document.getElementById("ruleList_"+ Rulelenth + "_11").onclick = function(){};
	}
	protocolToOption($('#rulesListTbody  select.protocol'),protocolList);
	protocolToOption($('#rulesListTbody  select.IPVersion'),IPprotocolList);
	inputSet($('#rulesListTbody  .messageInput'),'disabled',true);
	selectSet($('#rulesListTbody  select'));
}
function selectSet(obj)
{
	obj.each(function(){
		if($(this).attr('disabled')=='disabled')
		{
			$(this).parent().append('<div class="nullDiv"></div>');
		}
		else
		{
			$(this).parent().children('div.nullDiv').remove();
		}
	});
}
function inputSet(obj,key,value)
{
	obj.each(function()
	{
		if(key=='disabled'){
			$(this).attr(key,value);
			if(value==true)
			{
				$(this).css({'border-width':'0px'});
			}
			else
			{
				$(this).css({'border-width':'1.8px'});
			}
		}
	});

}

function RuleSubmit(indexID,orderID)
{
	var Form = new webSubmitForm();
	Form.addParameter('x.Order',orderID);
	Form.setAction('set.cgi?x=' + fireWallRule[indexID].domain + '&RequestFile=html/bbsp/firewalllevel/firewallTlf.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}
function RuleUp(obj)
{		
	var ruleupID = obj.id.split('_')[1];
	if(ruleupID <= 0)
	{
		return;
	}
	
	var uporderID = fireWallRule[ruleupID - 1].Order
	RuleSubmit(ruleupID , uporderID);
}
function RuleDown(obj)
{		
	var ruledownID = obj.id.split('_')[1];
	var downorderID = fireWallRule[ruledownID].Order;
	
	ruledownID++;
	if(ruledownID >= fireWallRule.length)
	{
		return;
	}
	
	RuleSubmit(ruledownID,downorderID);
}

function editRule(obj)
{		
	var instID = obj.id.split('_')[1];
	if ('ICMP' == getSelectVal('ruleList_'+ instID +'_2'))
	{
		return;
	}

	var curInputs = $(obj).parent().parent().parent().parent().children('td').children('.messageInput');
	var curSelects = $(obj).parent().parent().parent().parent().children('td').children('select.messageInput');
	
	if($(curInputs[0]).attr('disabled')=='disabled')
	{
		$(obj).attr('src','../../../images/ok.gif');
		inputSet(curInputs,'disabled',false);
		$("#ruleList_"+ instID +"_1").val(fireWallRule[instID].Description);
		var tempfireWallRule = getDisplayParaByDirection(fireWallRule[instID]);
		$("#ruleList_"+ instID +"_5").val(tempfireWallRule.localIP);
		$("#ruleList_"+ instID +"_7").val(tempfireWallRule.remoteIP);
		
		curInputs.css({"border":"1px solid rgb(168, 166, 166)", "background":"#fff"});
		selectSet(curSelects);
	}
	else
	{		
		var ruleName = getValue('ruleList_'+ instID +'_1');
		var protocol = getSelectVal('ruleList_'+ instID +'_2');
		protocol = protocol == ''?'-1':protocol;
		
		var IPVersion = getSelectVal('ruleList_'+ instID +'_3');
		var localPort = getValue('ruleList_'+ instID +'_4');
		var localIP = getValue('ruleList_'+ instID +'_5');
		var remoteIP = getValue('ruleList_'+ instID +'_7');
		var remotePort = document.getElementById('ruleList_'+ instID +'_8').value;
		
		var localIPSet = (localIP == '*'?'':localIP);
		var remoteIPSet = (remoteIP == '*'?'':remoteIP);
		var localPortSet = (localPort == '*'?'':localPort);
		var remotePortSet = (remotePort == '*'?'':remotePort);
		if (true != checkForm(ruleName, localPortSet, remotePortSet, localIPSet, remoteIPSet, protocol, IPVersion))
		{
			return ;
		}
		$(obj).attr('src','../../../images/edit2.gif');
		inputSet(curInputs,'disabled',true);
		var curInputParas = $("#rulesListTbody_tr"+instID).children('td').children('.messageInput');
		curInputs.css({"border":"0 solid #e4e4e4", "background-color":"transparent"})
		selectSet(curSelects);
		editMessageSubmit(ruleName, protocol, localPortSet, localIPSet, remoteIPSet, remotePortSet, instID, IPVersion);		
	}	
}

function editMessageSubmit(ruleName, protocol, localPort, localIP, remoteIP, remotePort, index, IPVersion)
{
	var paraPortAndIPs = getPortAndIPByAction(fireWallRule[index].action, localIP, remoteIP, localPort, remotePort);

   
	var ConfigParaList = new Array(new stSpecParaArray("x.Description", ruleName, 0),
								   new stSpecParaArray("x.Protocol", protocol, 0),
								   new stSpecParaArray("x.SourcePort", paraPortAndIPs.sourcePort, 0),
								   new stSpecParaArray("x.SourcePortRangeMax", paraPortAndIPs.sourcePortRangeMax, 0),
								   new stSpecParaArray("x.DestPort", paraPortAndIPs.destPort, 0),
								   new stSpecParaArray("x.DestPortRangeMax", paraPortAndIPs.destPortRangeMax, 0),								  
								   new stSpecParaArray("x.SourceIP", paraPortAndIPs.sourceIP, 0),
								   new stSpecParaArray("x.DestIP", paraPortAndIPs.destIP, 0),
								   new stSpecParaArray("x.IPVersion", IPVersion, 0));
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = ConfigParaList;
	var ConfigUrl = "set.cgi?x=" + fireWallRule[index].domain
						+ "&RequestFile=html/bbsp/firewalllevel/firewallTlf.asp";
	
	HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));
	
}

function deleteRule(id)
{	
	var instID = id.split('_')[1];

	var SubmitForm = new webSubmitForm();

	SubmitForm.addParameter(fireWallRule[instID].domain,'');
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/firewalllevel/firewallTlf.asp');
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.submit();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
	<table class="setupWifiTable">
		<thead>
				<th colspan="4" BindText='bbsp_f_default_policy'></th>
			</thead>
				<tr>
				<td BindText='bbsp_f_state'></td>
					<td colspan="3">
					<input type="radio" name="defaultPolicyAction" value="0" id="defaultPolicyAccept" onclick="chooseDefaultPolicy(this)"/> <script>document.write(firewalllevel_language['bbsp_f_accept']);</script> &nbsp;&nbsp; 
					<input type="radio" name="defaultPolicyAction" value="1" id="defaultPolicyReject" onclick="chooseDefaultPolicy(this)"/> <script>document.write(firewalllevel_language['bbsp_f_reject']);</script>
					</td>
				</tr>

			<thead>
				<th colspan="4" BindText='bbsp_f_pingwan_interface'></th>
			</thead>
			<tbody>
				<tr>
				<td BindText='bbsp_f_state'></td>
					<td colspan="3">
					<input type="radio" name="pingWANInterfaceAction" value="0" id="pingWANInterfaceAccept" onclick="choosePingWANInterface(this)"/> <script>document.write(firewalllevel_language['bbsp_f_accept']);</script> &nbsp;&nbsp; 
					<input type="radio" name="pingWANInterfaceAction" value="1" id="pingWANInterfaceReject" onclick="choosePingWANInterface(this)"/> <script>document.write(firewalllevel_language['bbsp_f_reject']);</script>
					</td>
				</tr>
            </tbody>
			<thead>
				<th colspan="4" BindText='bbsp_f_add_new_rule'></th>
			</thead>
			<tbody id="ruleTbody">
				<tr>
					<td colspan="4" BindText='bbsp_f_config_vivobox'></td>
				</tr>
				<tr>
					<td BindText='bbsp_f_rulename'></td>
					<td><input type="text" name="textfield" id="ruleName" maxlength="256"/></td>
					<td><strong BindText='bbsp_f_protocol'></strong></td>
					<td><select id="protocol" name="">
					<option value="6" BindText='bbsp_f_TCP'></option>
					<option value="17" BindText='bbsp_f_UDP'></option>
					<option value="6/17" BindText='bbsp_f_TCPUDP'></option>
					</select></td>
				</tr>
				<tr >
					<td BindText='bbsp_f_protocol_ip'></td>
					<td colspan="8"><select id="IPVersion" name="">
					<option value="4">IPv4</option>
					<option value="6">IPv6</option>
					</select></td>
				</tr>
				<tr>
					<td><script>document.write(firewalllevel_language['bbsp_f_local_port']);</script> <span class="description"><br><script>document.write(firewalllevel_language['bbsp_single_port_range']);</script> <br><script>document.write(firewalllevel_language['bbsp_eg_8090']);</script></span></td>
					<td><input type="text" name="textfield" id="localPort" maxlength="11"/></td>
					<td><strong><script>document.write(firewalllevel_language['bbsp_f_remote_port']);</script><span class="description"><br><script>document.write(firewalllevel_language['bbsp_single_port_range']);</script> <br><script>document.write(firewalllevel_language['bbsp_eg_8090']);</script></strong></span></td>
					<td><input type="text" name="textfield" id="remotePort" maxlength="11"/></td>
				</tr>
				<tr>
					<td><script>document.write(firewalllevel_language['bbsp_f_loccal_ip']);</script> <span class="description"><br><script>document.write(firewalllevel_language['bbsp_f_mean_all_ip']);</script></span></td>
					<td><input type="text" name="textfield" id="localIP" maxlength="39"/></td>
					<td><strong><script>document.write(firewalllevel_language['bbsp_f_remote_ip']);</script></strong><span class="description"><br><script>document.write(firewalllevel_language['bbsp_f_mean_all_ip']);</script></span></td>
					<td><input type="text" name="textfield" id="remoteIP" maxlength="39"/></td>
				</tr>
					<tr>
					<td><strong BindText='bbsp_f_action'></strong></td>
					<td>
					<select id="selectAction" onchange="chooseAction(this)">
					<option value="Reject from local" BindText='bbsp_f_reject_from_local'></option>
					<option value="Reject from remote" BindText='bbsp_f_reject_from_remote'></option>
					<option value="Accept from local" BindText='bbsp_f_accept_from_local'></option>
					<option value="Accept from remote" BindText='bbsp_f_accept_from_remote'></option>
					</select>
					</td>
					<td style="background-color:#F3F3F4" colspan=2 align="center"><div class="policystatus"><strong><script>document.write(firewalllevel_language['bbsp_f_local']);</script></strong></div><div id="imgAction" class="policystatus"><img src="../../../images/rjctLocal.gif"></div><div class="policystatus"><strong><script>document.write(firewalllevel_language['bbsp_f_remote']);</script></strong></div></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 
						<a href="#" class="btn-default-orange-small right" onclick="CancelConfig()"><span BindText='bbsp_f_clear'></span></a>
						<a href="#" class="btn-default-orange-small right" onclick="AddSubmitParam()"><span BindText='bbsp_f_add'></span></a>
					</td>
				</tr>
			</tbody>
	</table>
		
		<table class="setupWifiTable">
			<thead>
				<tr>
					<th colspan="12" BindText='bbsp_f_rules_list'></th>
				</tr>
				<tr>
					<th colspan="3" BindText='bbsp_f_rule'></th>
					<th colspan="2" BindText='bbsp_f_local'></th>
                    <th colspan="2" BindText='bbsp_f_action'></th>
					<th colspan="2" BindText='bbsp_f_remote'></th>
					<th colspan="2" BindText='bbsp_f_modify'></th>
				</tr>
				<tr>
					<th BindText='bbsp_f_name'></th>
					<th BindText='bbsp_f_protocolhm'></th>
					<th BindText='bbsp_f_protocol_ip'></th>
					<th BindText='bbsp_f_port'></th>
					<th BindText='bbsp_f_ip'></th>
					<th BindText='bbsp_f_policy'></th>
					<th BindText='bbsp_f_ip'></th>
					<th BindText='bbsp_f_port'></th>
					<th colspan="3" BindText='bbsp_f_edit'></th>
				</tr>
			</thead>
			<tbody id="rulesListTbody">					
			</tbody>
		</table>					
<script>
	ParseBindTextByTagName(firewalllevel_language, "td",   1);
	ParseBindTextByTagName(firewalllevel_language, "input",   2);
	ParseBindTextByTagName(firewalllevel_language, "th",   1);
	ParseBindTextByTagName(firewalllevel_language, "strong",   1);
	ParseBindTextByTagName(firewalllevel_language, "span", 1);
	ParseBindTextByTagName(firewalllevel_language, "option",   1);
</script>
</body>
</html>
