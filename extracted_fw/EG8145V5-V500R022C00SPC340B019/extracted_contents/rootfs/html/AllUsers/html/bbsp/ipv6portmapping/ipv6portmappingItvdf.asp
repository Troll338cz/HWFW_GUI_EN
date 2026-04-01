<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(Itvdfinterface.js);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" type="text/javascript">
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var WanIndex = -1;
var currentPortMappingInst = 0;
var curPortList;
var AddFlag = true;
var selctIndex = -1;
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var FirewallDual = <%HW_WEB_GetFeatureSupport("BBSP_FT_FIREWALL_DUAL");%>;
var IPv6Firewall = <%HW_WEB_GetFeatureSupport("BBSP_FT_CONFIG_IPV6_SESSION");%>;
var IPv6FirewallEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_IPv6FWDFireWallEnable);%>';

function filterWan(WanItem)
{
	if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false)))
	{
		return false;
	}
    if (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0 && WanItem.IPv6Enable == '1')
    {
        return true;
    }
    else
    {
        return false;
    }
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
    if(portList.length > 1)
    {
       this.innerPortEnd = portList[1];
    }
}

function SetIPv6MappingInfo(PortMapObj, Interface, PortListObj)
{
	this.PortMapObj = PortMapObj;
	this.Interface = Interface;
	this.PortList = PortListObj;
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
	return null;
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
            break;
        }
        parentDomain = wanPortMappingPortList[i].domain.substr(0,idx);
        if(portMappingDomain == parentDomain)
        {
            portList.push(wanPortMappingPortList[i]);
        }
    }
    return portList;
}

var PortMapping = new Array;

for (var i = 0; i < WanIPPortMapping.length-1; i++)
{
    var tmpWan = FindWanInfoByPortMapping(WanIPPortMapping[i]);
	var tmpPortList;
	var tmpIndex;
	if(null == tmpWan)
	{
		continue;
	}

	tmpPortList = SelectPortMappingPortList(WanIPPortMapping[i].domain,WanIPPortMappingPortList);
	if (tmpPortList.length == 0)
	{
		PortMapping.push(new SetIPv6MappingInfo(WanIPPortMapping[i], MakeWanName(tmpWan), null));
	}
	else
	{
		for (tmpIndex = 0; tmpIndex < tmpPortList.length; tmpIndex++)
		{
			PortMapping.push(new SetIPv6MappingInfo(WanIPPortMapping[i], MakeWanName(tmpWan), tmpPortList[tmpIndex]));
		}
	}
}

for (var j = 0; j < WanPPPPortMapping.length-1; j++)
{
    var tmpWan = FindWanInfoByPortMapping(WanPPPPortMapping[j]);
	var tmpPortList;
	var tmpIndex;
	if(null == tmpWan)
	{
		continue;
	}

	tmpPortList = SelectPortMappingPortList(WanPPPPortMapping[j].domain,WanPPPPortMappingPortList);
	if (tmpPortList.length == 0)
	{
		PortMapping.push(new SetIPv6MappingInfo(WanPPPPortMapping[j], MakeWanName(tmpWan), null));
	}
	else
	{
		for (tmpIndex = 0; tmpIndex < tmpPortList.length; tmpIndex++)
		{
			PortMapping.push(new SetIPv6MappingInfo(WanPPPPortMapping[j], MakeWanName(tmpWan), tmpPortList[tmpIndex]));
		}
	}
}

function SubmitPortMapping()
{
	if (CheckPortMappingCfg())
	{
		if ((0 == FirewallDual) && (1 == IPv6Firewall) && (0 == IPv6FirewallEnable))
		{
			if(IPV6_SESSIONNUM == 0)
			{
			   AlertEx(ipv6portmapping_language['bbsp_firewallnote']);
               return;
			}
		}
		var url;
	    var portListUrl = '';
	    var postUrlPrefix = 'GROUP_a_x';
	    var PortMappingEnable = 1;
        var postlistPrefix = "GROUP_a_ya";
	    var Form = new webSubmitForm();
	    Form.addParameter(postUrlPrefix + '.Enabled',PortMappingEnable);
		Form.addParameter(postUrlPrefix + '.InternalClient',getValue('InternalClient'));
		if ( true == AddFlag )
		{
	        Form.addParameter(postlistPrefix + '.Protocol',getElement('SelectProtocolshow').innerHTML);
	        if('' != getValue('innerPortStart') && '' != getValue('innerPortEnd'))
            {
                Form.addParameter(postlistPrefix + '.InternalPortList',getValue('innerPortStart') + ':' + getValue('innerPortEnd'));
            }
            else if ('' != getValue('innerPortStart'))
            {
                Form.addParameter(postlistPrefix + '.InternalPortList',getValue('innerPortStart'));
            }
			else if ('' != getValue('innerPortEnd'))
			{
			    Form.addParameter(postlistPrefix + '.InternalPortList',getValue('innerPortEnd'));
			}
			else
			{
				Form.addParameter(postlistPrefix + '.InternalPortList',"");
			}
		    portListUrl = '&GROUP_a_ya=' + postUrlPrefix + ".Portlist";
			url = "addcfg.cgi?" + postUrlPrefix + '=' + getPortMappingWanList() + ".X_HW_IPv6.PortForward";
		}
		else
		{
            if (PortMapping[selctIndex].PortList != null)
            {
                portListUrl += '&GROUP_a_ya=' + PortMapping[selctIndex].PortList.domain;
            }
            else
            {
                portListUrl += '&GROUP_a_ya=' + PortMapping[selctIndex].PortMapObj.domain + ".Portlist";
            }

            if('' != getValue('innerPortStart') && '' != getValue('innerPortEnd'))
            {
                Form.addParameter(postlistPrefix + '.InternalPortList',getValue('innerPortStart') + ':' + getValue('innerPortEnd'));
            }
            else if ('' != getValue('innerPortStart'))
            {
                Form.addParameter(postlistPrefix + '.InternalPortList',getValue('innerPortStart'));
            }
			else if ('' != getValue('innerPortEnd'))
			{
			    Form.addParameter(postlistPrefix + '.InternalPortList',getValue('innerPortEnd'));
			}
			else
			{
				Form.addParameter(postlistPrefix + '.InternalPortList',"");
			}

            Form.addParameter(postlistPrefix + '.Protocol',getElement('SelectProtocolshow').innerHTML);
			url = "complex.cgi?" + postUrlPrefix + '=' + PortMapping[selctIndex].PortMapObj.domain;
		}
		url += portListUrl;
		url += "&RequestFile=html/bbsp/ipv6portmapping/ipv6portmappingItvdf.asp";
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction(url);
		Form.submit();
	}
	else
	{
		return false;
	}
}

function portListInstIpChk()
{
    var innerHostIp = getValue("InternalClient");
    if ((innerHostIp != "") && (CheckIpv6Parameter(innerHostIp) == false))
    {
        AlertEx(ipv6portmapping_language['bbsp_hostipinvalid']);
        return false;
    }
	return true;
}
function getPortMappingWanList()
{
    var wandomain = null;
    if (WanInfo.length > 0) 
    {
    	wandomain = WanInfo[0].domain;
    }
    else
    {
    	wandomain = null;
    }
	return wandomain;
}

function CheckPortMappingCfg()
{
    var innerHostIp = getValue("InternalClient");
    var innerPortStart = getValue('innerPortStart');
    var innerPortEnd = getValue('innerPortEnd');
    if ((innerHostIp != "") && (CheckIpv6Parameter(innerHostIp) == false))
    {
        AlertEx(ipv6portmapping_language['bbsp_hostipinvalid']);
        return false;
    }
	return true;
}

function LoadFrame()
{
	getPortMappingWanList();
	showlist();
}

function showlist()
{
    var instNum = PortMapping;
    var pormappinglen = PortMapping.length;
    var htmlLines = '';
    var innerPortStart = "";
    var innerPortEnd = "";
    var Protocol = "";
    var empytValue = "--";
	var tmpport = "";
    if (pormappinglen > 0)
    {
        for(var i = 0; i < pormappinglen; i++)
        {
			empytValue = instNum[i].PortMapObj.InClient;
	    	if (instNum[i].PortList != null)
			{
				Protocol = instNum[i].PortList.Protocol;
				innerPortStart = instNum[i].PortList.innerPortStart;
				innerPortEnd = instNum[i].PortList.innerPortEnd;
			}

			if (innerPortStart == "" && innerPortEnd == "")
			{
			    tmpport = "--";
			}
			else if (innerPortStart != "" && innerPortEnd == "")
			{
				tmpport = htmlencode(innerPortStart) + '-' + htmlencode(innerPortStart);
			}
			else if (innerPortStart == "" && innerPortEnd != "")
			{
				tmpport = htmlencode(innerPortEnd) + '-' + htmlencode(innerPortEnd);
			}
			else
			{
				tmpport = htmlencode(innerPortStart) + '-' + htmlencode(innerPortEnd);
			}

			if(Protocol == "")
            {
				Protocol = "--";
            }

            if(empytValue == "")
            {
				empytValue = "--";
            }

            htmlLines += "<tr id=\"portMappingInst_record_" + i + "\" ><td id=\"portMappingInst_record_" + i + "_1\" class=\"ipv6-font-size\" title=\"" + htmlencode(empytValue) + "\">" + htmlencode(empytValue) + "</td>";
            htmlLines += "<td id=\"portMappingInst_" + i + "_2\" class=\"ipv6-font-size\">" + htmlencode(Protocol.toUpperCase()) + "</td>";
            htmlLines += "<td id=\"portMappingInst_" + i + "_3\" class=\"ipv6-font-size\">" + tmpport + "</td>";
            htmlLines += "<td><img src=\"../../../images/button-edit-desktop.png\"  id=\"portMappingInst_" + i + "_4\" " + "  class= \"imgbutton\" onClick = \"EditPortList(this.id)\">" +  "</td>";
            htmlLines += "<td><img src=\"../../../images/button-delete-desktop.png\"  onClick = \"DeletePortList(this.id)\" id=\"portMappingInst_" + i + "_5\" " + "  class=\"imgbutton\" >" +  "</td></tr>";
        }
    }
    else
    {
            htmlLines += "<tr id=\"ipv6nodevice\"><td></td><td style=\"font-style:italic\">"+ ipv6portmapping_language['bbsp_no_devices']+"</td><td></td><td></td></tr>";
    }

    	htmlLines += "<tr><td colspan=\"4\"></td><td><img src=\"../../../images/button-add-desktop.png\" id=\"addportmapping\" class=\"imgbutton\" onclick =\"AddPortMapping();\"></td></tr>";
    $('#showlist').append(htmlLines);
}


function EditPortList(index)
{
	var objTR = getElement(index);
	var temp = objTR.id.split('_')[1];
	setControl(temp);
    setDisplay('editrules',1);
    setDisplay('addrules',0);
}

function DeletePortList(index)
{
	var objTR = getElement(index);
	var temp = objTR.id.split('_')[1];
	var SubmitForm = new webSubmitForm();
	var deleteflag = 0;
	for(var i = 0; i < PortMapping.length; i++)
	{
		if(PortMapping[i].PortMapObj.domain == PortMapping[temp].PortMapObj.domain)
		{
			deleteflag++;
		}
	}

	if (deleteflag > 1)
	{
		SubmitForm.addParameter(PortMapping[temp].PortList.domain,'');
	}
	else
	{
	    SubmitForm.addParameter(PortMapping[temp].PortMapObj.domain,'');
	}
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/ipv6portmapping/ipv6portmappingItvdf.asp');
	SubmitForm.submit();
}
function setCtlDisplay(record)
{
	setText('InternalClient',record.PortMapObj.InClient);
	if (record.PortList != null)
	{
        if(record.PortList.Protocol.toUpperCase() != "TCP" && record.PortList.Protocol.toUpperCase() != "UDP")
        {
            SetDivValue('SelectProtocolshow',ipv6portmapping_language['TCP']);
        }
        else
        {
            SetDivValue('SelectProtocolshow',record.PortList.Protocol.toUpperCase());
        }
    	setText('innerPortStart',record.PortList.innerPortStart);
    	setText('innerPortEnd',record.PortList.innerPortEnd);
	}
	else
	{
		SetDivValue('SelectProtocolshow',ipv6portmapping_language['TCP']);
		setText('innerPortStart',"");
		setText('innerPortEnd',"");
	}
}

function ChangeProtocol(obj)
{
    var text = obj.innerHTML;
    var dropdownShowId = "SelectProtocol" + "show";
    $("#"+dropdownShowId).html(text);
}

function setControl(index)
{
    var record;

	selctIndex = index;

    if (index == -1)
	{
	    if(PortMapping.length >= 32)
	    {
		    AlertEx(ipv6portmapping_language['bbsp_mappingfull']);
		    return;
	    }
		AddFlag = true;
        record = new stPortMap('','1','','','','','','','','','','');
        record.PortList = new stPortMappingPortList('','TCP','','');
	}
    else if (index == -2)
    {
        setDisplay('editPort', 0);
    }
	else
	{
		AddFlag = false;
		setDisplay('editPort',1);
	    record = PortMapping[index];
        setCtlDisplay(record);
	}
}


function AddPortMapping()
{
	if (getPortMappingWanList() == null)
	{
		return;
	};
    AddFlag = true;
	setDisplay('editPort',1);
    setDisplay('editrules',0);
    setDisplay('addrules',1);
    SetDivValue("SelectProtocolshow",ipv6portmapping_language['TCP']);
    $(".max5").val("");
    $("#InternalClient").val("");
    setDisplay("ipv6nodevice",0);
}

function CancelConfig()
{
	setDisplay('editPort',0);
    $(".max5").val("");
    $("#InternalClient").val("");
    if(PortMapping.length == 0)
    {
        setDisplay("ipv6nodevice",1);
    }
}
</script>

</head>
<body onLoad="LoadFrame();" class="ipv6firewall" style="width:760px">
    <div id="ipv6firewallrule">
        <h1>
            <script>document.write(ipv6portmapping_language['bbsp_ITVDF_IPV6Name']);</script>
        </h1>
        <div>
            <h2>
                <span BindText="bbsp_ITVDF_IPV6title"></span>
            </h2>
            <div class="firewall-on-off" style="width:750px">
                <div class="h3-content">
					<table border="0" id='showlist'>
					    <tr class="ipv6-font-size" style="border-bottom: 1px solid #e6e6e6;" >
					    <td class="ipv6-font-size" style="width:220px" BindText = "bbsp_ITVDF_inthost">
					    </td>
						<td class="ipv6-font-size" style="width:204px" BindText = "bbsp_ITVDF_protocol">
						</td>
					    <td class="ipv6-font-size" style="width:124px" BindText = "bbsp_ITVDF_ipv6ports">
					    </td>
					    <td style="width:61px"></td>
					    <td style="width:61px"></td>
					    </tr>
					</table>
                </div>
            </div>
        </div>
        <div class="edit-firewall-rule-popup" id="editPort" style="display:none" style="width:730px">
            <div>
                <table class="popip-table" style="float:left">
                    <tr class="titleleft">
                        <td style="width:300px;" class="ipv6rules">
                        <h3  style="color:red" class="ipv6H3" id="editrules">
                            <script>document.write(ipv6portmapping_language['bbsp_ITVDF_IPV6edit']);</script>
                        </h3>
                        <h3  style="color:red" class="ipv6H3" id="addrules">
                            <script>document.write(ipv6portmapping_language['bbsp_ITVDF_IPV6add']);</script>
                        </h3>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width:300px;" class="ipv6rules ipv6head"  BindText = "bbsp_protocol"></td>
                        <td class="showright" style="width:390px;" id="ProtocolShow">
                            <script type="text/javascript">
                                $('#ProtocolShow').css("position","relative");
                                $('#ProtocolShow').html('<div class="iframeDropLog"><div id="SelectProtocol" class="IframeDropdown"></div></div>');
                                var arr = [ipv6portmapping_language['TCP'],ipv6portmapping_language['UDP']];
                                var DefaultValue = ipv6portmapping_language['TCP'];
                                createDropdown("SelectProtocol", DefaultValue, "390px", arr, "ChangeProtocol(this);",false);
                            </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="ipv6rules ipv6head" BindText= "bbsp_ITVDF_PortRane"></td>
                        <td class="showright">
                            <input type="text" class="max5 max5-range" id = "innerPortStart" value="" style="width: 75px;">
                             -
                            <input type="text" class="max5 max5-range" id = "innerPortEnd" value="" style="width: 75px;">
                        </td>
                    </tr>
                    <tr>
                        <td class="ipv6rules" style="height: 50px;line-height: 50px;">
                            <h3 class="titleleft ipv6H3" style="color:red">
                                <script>document.write(ipv6portmapping_language['bbsp_ITVDF_Destination']);</script>
                            </h3>
                        </td>
                        <td>

                        </td>
                    </tr>
                    <tr>
                        <td class="ipv6rules ipv6head " BindText= "bbsp_ITVDF_IPAddress" style="padding-bottom:35px;height:50px;line-height:50px"></td>
                        <td class="showright" style="padding-bottom:35px;height:50px;line-height:50px"><input type="text" class="fullWidth" id="InternalClient" style="width:390px"></td>
                    </tr>
                    <tr style="border-top:1px solid #e6e6e6">
                        <td class="ipv6rules ipv6head"></td>
                        <td class="showright">
                        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                        <button  id="cancelButton" class="button button-cancel" value="Cancel" onclick="CancelConfig()">
                            <script>document.write(ipv6portmapping_language['bbsp_cancel']);</script>
                        </button>
                        <button id="applyButton" class="button button-apply saveButton" style="background:#9c2aa0"  onClick="SubmitPortMapping()">
                            <script>document.write(ipv6portmapping_language['bbsp_app']);</script>
                        </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
<script type="text/javascript">
    ParseBindTextByTagName(ipv6portmapping_language, "div",  1);
    ParseBindTextByTagName(ipv6portmapping_language, "td",  1);
    ParseBindTextByTagName(ipv6portmapping_language, "span",  1);
    ParseBindTextByTagName(ipv6portmapping_language, "input", 2);
    ParseBindTextByTagName(ipv6portmapping_language, "th", 1);
    ParseBindTextByTagName(ipv6portmapping_language, "h3", 1);
</script>
</body>
</html>
