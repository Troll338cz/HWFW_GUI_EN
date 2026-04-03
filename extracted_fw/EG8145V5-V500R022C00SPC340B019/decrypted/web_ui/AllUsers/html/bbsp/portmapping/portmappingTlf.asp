<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(gateway.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<title>Port Forwarding</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style type="text/css">
#myTable tr td input {
width:100px;
border:none;
background-color: rgba(250, 235, 215, 0);
text-align: center;
font-size: 12px;
color: #666666;
height:16px;
line-height:16px;
background-color: transparent;
border:0 solid #e4e4e4;
padding-left:0px!important;
}
#myTable tr td select {
width: 65px;
border: navajowhite;
font-size: 12px;
color: #666666;
border:1px solid rgb(168, 166, 166);
height: 20px;
}
.center a {
float: left;
margin-left: 12px;
width:26px;
}
.table_title a {
display:block;
float: left;
margin-left: 12px;
width:26px;
}
input[disable]{
	color:#FF0000!important;
}
td.table_title.align_center {
    padding: 12px 5px;
}
table.setupWifiTable tbody td:first-child, table.setupWifiTable tbody td.firstChild {
    text-align: center;
    padding-left: 2px!important; 
    padding-right: 2px!important;
    background: #e3e3e3;
    font-weight: bold;
    padding-top: 12px;
    padding-bottom: 12px;
}
</style>
<script language="JavaScript" type="text/javascript">

var fileUrl = 'html/bbsp/portmapping/portmappingTlf.asp';

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
	if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false)))
	{
		return false;	
	}    
	return true;
}

var WanInfo = GetWanListByFilter(filterWan);

function stPortMap(domain,ProtMapEnabled,RemoteHost,ExternalPort,ExternalPortEndRange,InternalPort,Protocol,InClient,Description)
{
    this.domain = domain;
    this.ProtMapEnabled = ProtMapEnabled;
    this.RemoteHost = RemoteHost;
	this.ExternalPort = ExternalPort;
	this.ExternalPortEndRange = ExternalPortEndRange;
	this.InternalPort = InternalPort;
	this.Protocol = Protocol;
    this.InClient = InClient;	
    this.Description = Description;
    var index = domain.lastIndexOf('PortMapping');
    this.Interface = domain.substr(0,index - 1);
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

function ParsePortStart(port)
{
	var portList = FormatPortStr(port).split(':');
	var StartPort = portList[0];
	var EndPort = portList[0];
	if(portList.length > 1){
		EndPort = portList[1];
	}
	
	return StartPort;
}

function ParsePortEnd(port)
{
	var portList = FormatPortStr(port).split(':');
	var StartPort = portList[0];
	var EndPort = portList[0];
	if(portList.length > 1){
		EndPort = portList[1];
	}
	
	return EndPort;
}

var WanIPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i},PortMappingEnabled|RemoteHost|ExternalPort|ExternalPortEndRange|InternalPort|PortMappingProtocol|InternalClient|PortMappingDescription,stPortMap);%>;
var WanPPPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i},PortMappingEnabled|RemoteHost|ExternalPort|ExternalPortEndRange|InternalPort|PortMappingProtocol|InternalClient|PortMappingDescription,stPortMap);%>; 

function fliterPortMapping(WanItem)
{
	if (WanItem.ServiceList != 'TR069'
         && WanItem.ServiceList != 'VOIP'
         && WanItem.ServiceList != 'TR069_VOIP'
         && WanItem.Mode == 'IP_Routed')
	{
		return true;
	}
	return false;
}

var PortMapping = GetAppListFormWanAppendInfo(WanPPPPortMapping, WanIPPortMapping, fliterPortMapping);
	
function stPortMappingInst(domain, stDescription, stProtocol, stExternalPort, stRemoteHost, stInternalPort, stInClient)
{
	var portList;
	this.domain = domain;
	this.instId = domain.split('.')[8];
	this.stDescription = stDescription;
	this.stProtocol = stProtocol;
	this.stExternalPort = stExternalPort; 
	this.stInternalPort = stInternalPort; 
	this.stRemoteHost = stRemoteHost;
	this.stInClient = stInClient;
	
	portList = FormatPortStr(stInternalPort).split(':');
    this.innerPortStart = portList[0];
    this.innerPortEnd = portList[0];
    if(portList.length > 1){
        this.innerPortEnd = portList[1];
    }
	
	portList = FormatPortStr(stExternalPort).split(':');
    this.exterPortStart = portList[0];
    this.exterPortEnd = portList[0];
    if(portList.length > 1){
        this.exterPortEnd = portList[1];
    }
	
	this.modifyFlag = false;
	this.modifyPortFlag = false;
}

function PortMappingInstList(record)
{
	var instNum = record.length;
	
	this.showPortmappingList = function()
	{
		var htmlLines = '';
		
		
		if (instNum == 0 )
		{
			return '';
		}
		for(var i = 0; i < instNum; i++)
		{
			var tdClass =(i%2==0) ?"<td class=\"table_title cinza align_center\"" : "<td class=\"table_title cinza2 align_center\"";
			
			htmlLines += "<tr id=\"portMappingInst_record_" + i + "\" >";
			htmlLines += tdClass + ">" + "<input type=\"text\" style=\"font-weight:bold\" id=\"portMappingInst_" + i + "_1\" " + " size=\"5\" maxlength=\"256\" readonly=\"readonly\" style=\"width: 75px;\">" +  "</td>";
			htmlLines += tdClass + ">" + "<select disabled=disabled id=\"portMappingInst_" + i + "_2\" " + " size=\"1\">"
			htmlLines += "<option value=\"TCP\" selected>TCP</option>" + "<option value=\"UDP\">UDP</option>" + "</select></td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_3\" " + " size=\"5\" maxlength=\"11\" readonly=\"readonly\" style=\"width: 100px\">" +  "</td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_4\" " + " size=\"5\" maxlength=\"11\" readonly=\"readonly\" style=\"width: 100px\">" +  "</td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_5\" " + " size=\"5\" maxlength=\"11\" readonly=\"readonly\" style=\"width: 100px\">" +  "</td>";
			htmlLines += tdClass + ">" + "<input type=\"text\" id=\"portMappingInst_" + i + "_6\" " + " size=\"5\" maxlength=\"16\" readonly=\"readonly\" style=\"width: 100px\">" +  "</td>";			
			htmlLines += tdClass + ">" + "<a id=\"portMappingInst_" + i + "_7\" " 
						  + " class=\"action edit\" onclick=\"JumpToModify(this.id);\"><img class=\"img-actions\" src=\"../../../images/edit2.gif\" />"; 
			htmlLines += "</a>" + "<a id=\"portMappingInst_" + i + "_8\" " 
						  + " class=\"action edit\" style=\"display:none\" onclick=\"ModifyPortMappingList(this.id);\"><img class=\"img-actions\" src=\"../../../images/ok.gif\" />"; 
			htmlLines += "</a>" + "<a id=\"portMappingInst_" + i + "_9\" " 
						  + " class=\"action edit\" onclick=\"DeletePortMapping(this.id);\"><img class=\"img-actions\" src=\"../../../images/trash.gif\" />"  + "</a>";
		
		}
		
		return htmlLines;
	}
	
	this.fillUpListTblInst = function()
	{
		var InternalPortEnd;
		for(var inst = 0; inst < instNum; inst++)
		{
			var des = record[inst].Description;
			if(des.length > 7)
			{
				des = des.substr(0, 7) + "...";
			}
			$("#portMappingInst_" + inst + "_1").val(des).attr("title", record[inst].Description);

			setSelect("portMappingInst_" + inst + "_2", (record[inst].Protocol).toUpperCase());
			if ('0' == record[inst].ExternalPortEndRange)
			{
				record[inst].ExternalPortEndRange = record[inst].ExternalPort;
				InternalPortEnd = record[inst].InternalPort;
			}
			else
			{
				InternalPortEnd = parseInt(record[inst].InternalPort,10) 
			          + (parseInt(record[inst].ExternalPortEndRange,10) - parseInt(record[inst].ExternalPort,10));
			}
			setText("portMappingInst_" + inst + "_3", record[inst].ExternalPort + ':' + record[inst].ExternalPortEndRange);	
			setText("portMappingInst_" + inst + "_4", record[inst].InternalPort + ':' + InternalPortEnd);
			setText("portMappingInst_" + inst + "_5", record[inst].RemoteHost);
			setText("portMappingInst_" + inst + "_6", record[inst].InClient);			
		}
	}
}

function GetCurrentPortMapList()
{
    var curPortMappingList = new PortMappingInstList(PortMapping);
	return curPortMappingList;
}

function GetInterfacePath()
{
	for(var k = 0; k < WanInfo.length; k++ )
	{
		if(WanInfo[k].ServiceList.indexOf('INTERNET') >= 0
	        && WanInfo[k].Mode == 'IP_Routed'
	        && WanInfo[k].IPv4Enable == '1'
	        && WanInfo[k].IPv4NATEnable == '1')
		{
			return WanInfo[k].domain;
		}
	}
	return "InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.1.WANPPPConnection.1";
}

function portListInstIpChk(innerHostIp)
{
    if (innerHostIp == "")
    {
        //AlertEx(portmapping_language['bbsp_hostipisreq']);
        return false;
    } 
	
	if (isAbcIpAddress(innerHostIp) == false)
    {
        //AlertEx(portmapping_language['bbsp_hostipinvalid']);
        return false;
    }

    if (isValidIpAddress(innerHostIp) == false)
    {
        //AlertEx(portmapping_language['bbsp_hostipinvalid']);
        return false;
    }

	var ip4 = innerHostIp.split(".");
    if ( parseInt(ip4[3],10) == 0 )
    {
		//AlertEx(portmapping_language['bbsp_hostipoutran']);
		return false;
    }
	
	return true;
}

function portValueValidChk(externalPortRange)
{
	var externalPort = $.trim(externalPortRange);
    var portList = FormatPortStr(externalPort).split(':');
    var externalStartPort = portList[0];
    var externalEndPort = portList[0];
    if(portList.length > 1)
	{
        externalEndPort = portList[1];
        if (isValidPort(externalEndPort) == false )
    	{
	        //AlertEx(portmapping_language['bbsp_intstartport']+getValue('InternalPort')+portmapping_language['bbsp_invalid'] );
	        return false;
	    }
    }

    if (isValidPort(externalStartPort) == false )
    {
        //AlertEx(portmapping_language['bbsp_intstartport']+getValue('InternalPort')+portmapping_language['bbsp_invalid'] );
        return false;
    }

    if (parseInt(externalEndPort,10) < parseInt(externalStartPort,10))
    {
	    //AlertEx(portmapping_language['bbsp_extstartportleqendport']+ "(" + externalStartPort + ")");
	    return false;     	
    }

	return true;
}

function CheckPortMappingPara(InternalClient, RemoteHost, InnerPortId, ExternalPortId)
{
	if (true != portListInstIpChk($.trim(InternalClient)))
	{
	    return false;
	}

	if ($.trim(RemoteHost) != "")
    {
        if (portListInstIpChk($.trim(RemoteHost)) == false)
        {
            //AlertEx(portmapping_language['bbsp_extsrcipinvalid']);
            return false;
        }
    } 
	
	if (true != portValueValidChk(InnerPortId))
	{
	    return false;
	}

	if (true != portValueValidChk(ExternalPortId))
	{
	    return false;
	}
	
	return true;
}

function CheckPortMappingCfg()
{
	var MAX_INST_NUM = (getValue('PortMappingProtocolId') == "TCP/UDP") ? '31' : '32';
	
	if(PortMapping.length >= parseInt(MAX_INST_NUM))
	{
		AlertEx(portmapping_language['bbsp_mappingfull']);
		return false;
	}

	return CheckPortMappingPara(getValue("InternalClient"), getValue('RemoteHost'), getValue("InnerPortId"), getValue("ExternalPortId"));
}

function CheckForm(type)
{
	var ret = true;

    switch (type)
    {
       case 3:
          ret = CheckPortMappingCfg();
          if(false == ret)
          {
          	AlertEx(portmapping_language['bbsp_invalid_port_ip']);
          }
          break;
    }

	return ret;
}

function ModifyPortMappingList(id)
{
	var instId = id.split('_')[1];	

	var ret = CheckPortMappingPara(getValue("portMappingInst_" + instId + "_6"), getValue("portMappingInst_" + instId + "_5"), getValue("portMappingInst_" + instId + "_3"), getValue("portMappingInst_" + instId + "_4"));
	if(true != ret)
	{
		//setDisplay("checkFailTipsID", 1);
		AlertEx(portmapping_language['bbsp_invalid_port_ip']);
		return false;
	}	

	var SubmitForm = new webSubmitForm();
	var url = 'set.cgi?x=' + PortMapping[instId].domain + '&RequestFile=' + fileUrl;
	
	SubmitForm.addParameter('x.PortMappingDescription',getValue("portMappingInst_" + instId + "_1"));
	SubmitForm.addParameter('x.PortMappingProtocol',getValue("portMappingInst_" + instId + "_2"));
	SubmitForm.addParameter('x.ExternalPort',ParsePortStart(getValue("portMappingInst_" + instId + "_3")));
	SubmitForm.addParameter('x.ExternalPortEndRange',ParsePortEnd(getValue("portMappingInst_" + instId + "_3")));	
	SubmitForm.addParameter('x.InternalPort',ParsePortStart(getValue("portMappingInst_" + instId + "_4")));
	SubmitForm.addParameter('x.RemoteHost',getValue("portMappingInst_" + instId + "_5"));			
	SubmitForm.addParameter('x.InternalClient',getValue("portMappingInst_" + instId + "_6"));
	
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction(url);
	SubmitForm.submit();
	
}

function DeletePortMapping(id)
{
	var instId = id.split('_')[1];
	var SubmitForm = new webSubmitForm();
	SubmitForm.addParameter(PortMapping[instId].domain,'');
	SubmitForm.setAction('del.cgi?RequestFile=' + fileUrl);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.submit();
}

function AddFirstParam(Interface, stDescription, stInterClient, stInterPort, stExterPort, stExterPortEnd, stRemoteHost)
{
	var Onttoken = getValue('onttoken');
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	data : 'x.PortMappingEnabled=1' +'&x.PortMappingDescription='+ encodeURIComponent(stDescription)  + '&x.InternalClient=' + stInterClient 
	      + '&x.PortMappingProtocol=TCP' + '&x.InternalPort=' + stInterPort + '&x.ExternalPort=' + stExterPort 
		  + '&x.ExternalPortEndRange=' + stExterPortEnd + '&x.RemoteHost=' + stRemoteHost +'&x.X_HW_Token=' + Onttoken,
	url :  'addcfg.cgi?x=' + Interface + '.PortMapping' 
		   + '&RequestFile=html/ipv6/not_find_file.asp',
	error:function(XMLHttpRequest, textStatus, errorThrown) 
	{
		if(XMLHttpRequest.status == 404)
		{
		}
	}
	});
}

function AddSubmitParam(SubmitForm,type)
{
	setDisable('addBtn',1);
	setDisable('clearBtn',1);

	var Interface = GetInterfacePath();
	var url;
	
	var stProtocol = getSelectVal('PortMappingProtocolId');
	var stDescription = getValue('PortMappingDescription');
	var stInterClient = getValue('InternalClient');
	var stInterPort = ParsePortStart(getValue('InnerPortId'));
	var stExterPort = ParsePortStart(getValue('ExternalPortId'));
	var stExterPortEnd = ParsePortEnd(getValue('ExternalPortId'));
	var stRemoteHost = getValue('RemoteHost');
	if ("TCP/UDP" == stProtocol)
	{
		AddFirstParam(Interface, stDescription, stInterClient, stInterPort, stExterPort, stExterPortEnd, stRemoteHost);
		stProtocol = "UDP";
	}
	
    SubmitForm.addParameter('x.PortMappingEnabled', '1');
    SubmitForm.addParameter('x.PortMappingDescription', stDescription);
	SubmitForm.addParameter('x.InternalClient', stInterClient);
	SubmitForm.addParameter('x.PortMappingProtocol',stProtocol);
	SubmitForm.addParameter('x.InternalPort', stInterPort);
	SubmitForm.addParameter('x.ExternalPort', stExterPort);
	SubmitForm.addParameter('x.ExternalPortEndRange', stExterPortEnd);
	SubmitForm.addParameter('x.RemoteHost', stRemoteHost);
	
	url = "addcfg.cgi?x=" + Interface + ".PortMapping" + '&RequestFile=' + fileUrl;
	
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction(url);
    	
}

function JumpToModify(id)
{		
	var instId = id.split('_')[1];
	$("#portMappingInst_" + instId + "_1").val(PortMapping[instId].Description);
	document.getElementById("portMappingInst_" + instId + "_8").style.display="block";
	document.getElementById("portMappingInst_" + instId + "_7").style.display="none";
	for (var i = 1; i <= 6; i++)
	{
		if (i == 2) 
		{
			setDisable("portMappingInst_" + instId + "_" + i, 0);
			continue;
		}
		document.getElementById("portMappingInst_" + instId + "_" + i).style.border="1px solid rgb(168, 166, 166)";
		document.getElementById("portMappingInst_" + instId + "_" + i).style.background="#fff";
		document.getElementById("portMappingInst_" + instId + "_" + i).readOnly="";		
	}
}

function ClearConfig()
{
	setSelect('PortMappingProtocolId', "TCP");
	setText('PortMappingDescription', "");
	setText('InternalClient', "");
	setText('InnerPortId', "");
	setText('ExternalPortId', "");
	setText('RemoteHost', "");
}

function LoadFrame()
{
	loadlanguage();
	
	GetCurrentPortMapList().fillUpListTblInst();

	//setDisplay("checkFailTipsID", 0);
	
}	
			
</script>

</head>
<body class="mainbody" onLoad="LoadFrame();">
	<div id="tab-02">
		<table class="setupWifiTable">
			<thead>
				<th colspan="4"><script>document.write(portmapping_language['portforwardtitle']);</script></th>
			</thead>
			<tbody>
				<tr>
					<td colspan="4" BindText='bbsp_config_port_device'></td>
				</tr>
				<tr>
					<td BindText='bbsp_rulename'></td>
					<td><input type="text" name="PortMappingDescription" id="PortMappingDescription" maxlength="256"/></td>
					<td><strong BindText='bbsp_protocol'></strong></td>
					<td>
						<select name="PortMappingProtocolId" id="PortMappingProtocolId">
							<option value="TCP" BindText='TCP'></option>
							<option value="UDP" BindText='UDP'></option>
							<option value="TCP/UDP" BindText='TCPUDP'></option>
						</select>
					</td>
				 </tr>
				 <tr>
					<td><script>document.write(portmapping_language['bbsp_extern_port']);</script><span class='description'><br><script>document.write(portmapping_language['bbsp_single_port']);</script><br><script>document.write(portmapping_language['bbsp_g8090']);</script></span></td>
					<td><input type="text" name="ExternalPortId" id="ExternalPortId" maxlength="11"/></td>
					<td><strong><script>document.write(portmapping_language['bbsp_internal_port']);</script> <span class='description'><br><script>document.write(portmapping_language['bbsp_if_arange']);</script><br><script>document.write(portmapping_language['bbsp_is_optional']);</script></strong></span></td>
					<td><input type="text" name="InnerPortId" id="InnerPortId" maxlength="11"/></td>
				 </tr>
				<tr>
					<td BindText='bbsp_external_ip'></td>
					<td><input type="text" name="RemoteHost" id="RemoteHost" maxlength="15"/></td>
					<td><strong BindText='bbsp_internal_ip'></strong></td>
					<td><input type="text" name="InternalClient" id="InternalClient" maxlength="15"/></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 
						<button id="clearBtn" name="clearBtn" class="btn-default-orange-small right" onClick="ClearConfig()"><span BindText='bbsp_clear'></span></button>
						<button id="addBtn" name="addBtn" class="btn-default-orange-small right" onClick="Submit(3)"><span BindText='bbsp_add'></span></button>
					</td>
				</tr>
				</tr>
			</tbody>
		</table>

					
		<table id="ForwardingTbl" class="setupWifiTable">
			<thead>
				<tr>
					<th colspan="8" BindText='bbsp_forward_table'></th>
				</tr>
				<tr>
					<th colspan="2" BindText='bbsp_rule'></th>
					<th colspan="2" BindText='bbsp_port'></th>
					<th colspan="2" BindText='bbsp_ip'></th>
					<th colspan="2" BindText='bbsp_action'></th>
				</tr>
				<tr>
					<th BindText='bbsp_tab_name'></th>
					<th BindText='bbsp_tab_prot'></th>
					<th BindText='bbsp_tab_external'></th>
					<th BindText='bbsp_tab_internal'></th>
					<th BindText='bbsp_tab_externo'></th>
					<th BindText='bbsp_tab_interno'></th>
					<th colspan="2"><span id="chang_btn" BindText='bbsp_modify'></span> /<span BindText='bbsp_remove'></span></th>
				</tr>
			</thead>
		<tbody id="myTable">
			<script language="JavaScript" type="text/javascript">
				document.write(GetCurrentPortMapList().showPortmappingList());
			</script>
		</tbody>
	</table>
</div> 
<script>
	ParseBindTextByTagName(portmapping_language, "td",   1);
	ParseBindTextByTagName(portmapping_language, "th",   1);
	ParseBindTextByTagName(portmapping_language, "br",   1);
	ParseBindTextByTagName(portmapping_language, "strong",   1);
	ParseBindTextByTagName(portmapping_language, "span", 1);
	ParseBindTextByTagName(portmapping_language, "option",   1);
</script>
</body>
</html>
