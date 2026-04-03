<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<title>Wan Access Configuration</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script>
	
var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();


var LanNameList = new Array();
var SSIDNameList = GetSSIDList();

var stbport = '<%HW_WEB_GetSTBPort();%>';

var EthNum = '<%GetLanPortNum();%>';
for(var i = 1 ;i <= EthNum ;i++)
{
	LanNameList.push(new stLanInfo('InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.'+i,'LAN'+i));
}

var appName = navigator.appName;

function stLanInfo(domain,name)
{
    this.domain = domain ;
	this.name = name;
}
    

var TableName = "PortAclConfigList";
var AddFlag = false;
var PortAclIndex = -1;

var PortAclEnableInfo =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.AccessControl,AccessControlListEnable,stPortAclEnable);%>;  				
var PortAclListInfoTmp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List.{i},SrcPortType|SrcPortName|ServicePort,stPortAcl);%>;  
var PortAclListInfo = new Array();

for(var i=0;i<PortAclListInfoTmp.length-1;i++)
{
	if(PortAclListInfoTmp[i].SrcPortType == "0" || PortAclListInfoTmp[i].SrcPortType == "1")
	{
		PortAclListInfo.push(PortAclListInfoTmp[i]);
	}
}
PortAclListInfo.push(null);

function stPortAclEnable(domain,enable)
{
	this.domain = domain;
	this.enable = enable;
}
function stPortAcl(domain, SrcPortType, SrcPortName ,Protocol)
{
    this.domain = domain;
	this.SrcPortType = SrcPortType ;
    this.Protocol = Protocol;    
	this.SrcPortName = SrcPortName;
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
		b.innerHTML = port_acl_language[b.getAttribute("BindText")];
	}
}

function OnPageLoad()
{
	loadlanguage();
	if(FltsecLevel != 'CUSTOM')
	{          
	    setDisable('portaclwhiteCol', 1);
	}   
	return true;
}

function GetPortNameDomian(id,porttype)
{
	var portdomain ;

    if(0 == porttype)
	{
		for(var i = 0 ; i< EthNum ; i++)
		{
		    if(id == LanNameList[i].name)
			{
				portdomain = LanNameList[i].domain;
				break;
			}
		}
	}
	else if(1 == porttype)
	{
		for(var i = 0 ; i< SSIDNameList.length ; i++)
		{
			if(id == SSIDNameList[i].name)
			{
				portdomain = SSIDNameList[i].domain;
				break;
			}
		}
	}
	return portdomain;
}


function GetSrcPortListID(srcporttype)
{
	var portnamelistid = new Array();
	if(0 == srcporttype )
	{
		for(var i = 1 ; i<= EthNum ; i++)
		{
			portnamelistid[i-1] = LanNameList[i-1].name;
		}
	}
	else if(1 == srcporttype)
	{
		for(var i = 0 ; i< SSIDNameList.length ; i++)
		{
			portnamelistid[i] = SSIDNameList[i].name;
		}
	}
	return portnamelistid;
}
	
function GetSplitList(splitlist)
{
	var splitlist = splitlist.split(",");
	var tmplist = new Array();
	var index = 0;
	
	for(var i = 0; i < splitlist.length; i++)
	{
		if (splitlist[i] != "")
			tmplist[index++] = splitlist[i];
	}
	return tmplist;
}

function GetSrcPortID(domain, srcporttype)
{
    var portnameid ;
    if(0 == srcporttype)
	{
		for(var i = 0 ; i< EthNum ; i++)
		{
		    if(domain == LanNameList[i].domain)
			{
				portnameid = LanNameList[i].name;
				break;
			}
		}
	}
	else if(1 == srcporttype)
	{
		for(var i = 0 ; i< SSIDNameList.length ; i++)
		{
			if(domain == SSIDNameList[i].domain)
			{
				portnameid = SSIDNameList[i].name;
				break;
			}
		}
	}
	return portnameid.toString().toUpperCase();;
}

function setControl(index)
{
    var record;
    PortAclIndex = index;
    if (index == -1)
	{   
		setDisplay("ConfigForm", 1);
		AddFlag = true;           
		record = new stPortAcl("", "0", "", "");
		
		setCtlDisplay(record);
	}
    else if (index == -2)
    {
        setDisplay("ConfigForm", 0);
    }
    else
	{
	    setDisplay("ConfigForm", 1);
        AddFlag = false;
	    record = PortAclListInfo[PortAclIndex];
		setCtlDisplay(record);
	}
}

function PortAclConfigListselectRemoveCnt(val)
{

}

function setCtlDisplay(record)
{
	var i;
	var portlannameidlist = GetSrcPortListID(0);
	var portssidnameidlist = GetSrcPortListID(1);
	var portnamelist = GetSplitList(record.SrcPortName);
	
	setSelect("PortType", record.SrcPortType);
	
	setCheck('Protocol1', 0);
	setCheck('Protocol2', 0);
	setCheck('Protocol3', 0);
	setCheck('Protocol4', 0);
	  
	if(record.Protocol.toUpperCase().match('TELNET'))
	{
		setCheck('Protocol1', 1);
	}
	
	if(record.Protocol.toUpperCase().match('HTTP'))
	{
		setCheck('Protocol2', 1);
	}
	
	if(record.Protocol.toUpperCase().match('SSH'))
	{
		setCheck('Protocol3', 1);
	}
	
	if(record.Protocol.toUpperCase().match('FTP'))
	{
		setCheck('Protocol4', 1);
	}
	
	for(i = 0 ; i < portlannameidlist.length ; i++)
	{
		setCheck(portlannameidlist[i], 0);
	}
	
	
	for(i = 0 ; i < portssidnameidlist.length ; i++)
	{
		setCheck(portssidnameidlist[i], 0);
	}
	
	for( i = 0 ; i < portnamelist.length ; i++)
	{
	    var portnameid = GetSrcPortID(portnamelist[i],record.SrcPortType);
		setCheck(portnameid, 1);
	}

	OnChangePortType();
}

	
function GetSrcProtocol()
{
	var selHttp = getCheckVal('Protocol2');
	var selFtp = getCheckVal('Protocol4');
	var selTelnet = getCheckVal('Protocol1');
	var selSSH = getCheckVal('Protocol3');
	var protoclStr = "";	
	
	if((selHttp==1)&&(selFtp==0)&&(selTelnet==0)&&(selSSH==0))
	{protoclStr="HTTP";}
		
	if((selHttp==0)&&(selFtp==1)&&(selTelnet==0)&&(selSSH==0))
	{protoclStr="FTP";}
		
	if((selHttp==0)&&(selFtp==0)&&(selTelnet==1)&&(selSSH==0))
	{protoclStr="TELNET";}
		
	if((selHttp==0)&&(selFtp==0)&&(selTelnet==0)&&(selSSH==1))
	{protoclStr="SSH";}
		 
	if((selTelnet==1)&&(selHttp==1)&&(selFtp==1)&&(selSSH==1))
	{protoclStr="TELNET,HTTP,FTP,SSH";}
			
	if((selTelnet==1)&&(selHttp==1)&&(selFtp==1)&&(selSSH==0))
	{protoclStr="TELNET,HTTP,FTP";}
		
	if((selTelnet==1)&&(selHttp==1)&&(selFtp==0)&&(selSSH==1))
	{protoclStr="TELNET,HTTP,SSH";}
		
	if((selTelnet==1)&&(selHttp==1)&&(selFtp==0)&&(selSSH==0))
	{protoclStr="TELNET,HTTP";}
		
	if((selTelnet==1)&&(selHttp==0)&&(selFtp==1)&&(selSSH==1))
	{protoclStr="TELNET,FTP,SSH";}
		
	if((selTelnet==1)&&(selHttp==0)&&(selFtp==1)&&(selSSH==0))
	{protoclStr="TELNET,FTP";}
		
	if((selTelnet==1)&&(selHttp==0)&&(selFtp==0)&&(selSSH==1))
	{protoclStr="TELNET,SSH";}
		
	if((selTelnet==0)&&(selHttp==1)&&(selFtp==1)&&(selSSH==1))
	{protoclStr="HTTP,FTP,SSH";}
		
	if((selTelnet==0)&&(selHttp==1)&&(selFtp==1)&&(selSSH==0))
	{protoclStr="HTTP,FTP";}
		
	if((selTelnet==0)&&(selHttp==1)&&(selFtp==0)&&(selSSH==1))
	{protoclStr="HTTP,SSH";}
		
	if((selTelnet==0)&&(selHttp==0)&&(selFtp==1)&&(selSSH==1))
	{protoclStr="FTP,SSH";}
	
	return protoclStr;
}

function GetSrcPortName(srcporttype)
{
	var portnamelistid = GetSrcPortListID(srcporttype);
	var portname = "";
	
	for(var i = 0 ; i < portnamelistid.length ; i++)
	{
		if(getCheckVal(portnamelistid[i]))
		{
			if (i < portnamelistid.length - 1)
			{
				portname += GetPortNameDomian(portnamelistid[i],srcporttype) + ',';
			}
			else
			{
				portname += GetPortNameDomian(portnamelistid[i],srcporttype);
			}
		}	
		
	}
	if(',' == portname.charAt(portname.length - 1))
	{
		portname = portname.substring(0, portname.length - 1); 
	}
	return portname ;
}

function OnDeleteButtonClick()
{   
	if(false == ConfirmEx(port_acl_language['bbsp_modify_prompt']))
	{	
		return false;
	}
    
	var CheckBoxList = document.getElementsByName(TableName+"rml");
	var Form = new webSubmitForm();
	var Count = 0;
  
	for (var i = 0; i < CheckBoxList.length; i++)
	{
		if (CheckBoxList[i].checked != true)
		{
			continue;
		}
		
		Count++;
		Form.addParameter(CheckBoxList[i].value,'');
	}
	if (Count <= 0)
	{
		return false;
	}
	setDisable("btnApply_ex","1");
	 setDisable("canelButton",1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List' + '&RequestFile=html/bbsp/portacl/portacl.asp');
	Form.submit();
	
	return false;        
}

function CheckRepeteConfig(portnamestr,protoclStr)
{   
	for (var i = 0 ;i < PortAclListInfo.length-1 ; i++)
	{
		if(true == AddFlag)
		{
			if(PortAclListInfo[i].Protocol == protoclStr 
			&& PortAclListInfo[i].SrcPortName == portnamestr )
			{
				AlertEx(port_acl_language['bbsp_repeate_config']);
				return false;
			}
			
		}
		else 
		{
			if(	PortAclListInfo[i].domain != PortAclListInfo[PortAclIndex].domain				
				&& PortAclListInfo[i].Protocol == protoclStr 
				&& PortAclListInfo[i].SrcPortName == portnamestr )
			{
				AlertEx(port_acl_language['bbsp_repeate_config']);
				return false;
			}
		}
	}
	return true;        
}
function SubmitForm()
{ 	
	var porttype = getSelectVal('PortType');
	var srcportnamestr = GetSrcPortName(porttype);
	var protoclStr = GetSrcProtocol();
	var Form = new webSubmitForm();				
		
	if(protoclStr == '')
	{
		AlertEx(port_acl_language['bbsp_alert_selproto']);
		return false;
	}
	

	if (srcportnamestr == '')
	{
		AlertEx(port_acl_language['bbsp_alert_port']);
		return false;
	}  
	
	if(false == CheckRepeteConfig(srcportnamestr,protoclStr))
	{	
		return false;
	}
	
    if(false == ConfirmEx(port_acl_language['bbsp_modify_prompt']))
    {
        return false;
    }	
	
	Form.addParameter('x.SrcPortName', srcportnamestr);
	Form.addParameter('x.ServicePort',protoclStr);
	Form.addParameter('x.SrcPortType',porttype);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	if (AddFlag == true)
	{
		Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List' + '&RequestFile=html/bbsp/portacl/portacl.asp');
	}
	else
	{
		Form.setAction('set.cgi?' +'x='+ PortAclListInfo[PortAclIndex].domain + '&RequestFile=html/bbsp/portacl/portacl.asp');
	}
	
	DisableRepeatSubmit();
	
	Form.submit();
	
	setDisable('ButtonApply',1);
	setDisable('ButtonCancel',1);
	return false;
}

function CancelValue()
{
    setDisplay("ConfigForm", 0);
	if (PortAclIndex == -1)
    {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length == 1)
        {
			
        }
        else if (tableRow.rows.length == 2)
        {
			
        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + "_record_0");
        }
    }
    else
    {
        var record = PortAclListInfo[PortAclIndex];
		setCtlDisplay(record);
    }
}

function GetShortPortName(SrcPortName,SrcPortType)
{
	var portnamelist = GetSplitList(SrcPortName);
	var portshortname = "";
	for(var i = 0 ; i < portnamelist.length ; i++)
	{
		if (i < portnamelist.length - 1)
		{
			portshortname += GetSrcPortID(portnamelist[i], SrcPortType) + ',';
		}
		else
		{
			portshortname += GetSrcPortID(portnamelist[i], SrcPortType);
		}
	}
	if(',' == portshortname.charAt(portshortname.length - 1))
	{
		portshortname = portshortname.substring(0, portshortname.length - 1); 
	}
	
	return portshortname;
}

function stPortAclInfo(domain,Protocol,SrcPortName)
{
	this.domain = domain;
	this.Protocol = Protocol;
	this.SrcPortName = SrcPortName;
}
function ShowListControlInfo()
{
	var ColumnNum = 3;
	var ShowButtonFlag = (FltsecLevel == 'CUSTOM') ? true : false;
	var TableDataInfo = new Array();
	var Listlen = 0;
	var i = 0;
	
	var PortAclInfoNr = PortAclListInfo.length-1;
	
	if (FltsecLevel != 'CUSTOM')
	{
	    PortAclInfoNr = 0;
	}
	if( 0 == PortAclInfoNr )
	{		
		TableDataInfo[Listlen] = new stPortAclInfo();
		TableDataInfo[Listlen].domain = "--";
		TableDataInfo[Listlen].SrcPortName = "--";
		TableDataInfo[Listlen].Protocol = "--";
		
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PortAclConfiglistInfo, port_acl_language, null);
		return ;
	}

	for(i = 0; i < PortAclInfoNr; i++)   
	{
		TableDataInfo[Listlen] = new stPortAclInfo();
	    TableDataInfo[Listlen].domain = PortAclListInfo[i].domain;
		TableDataInfo[Listlen].SrcPortName = GetShortPortName(PortAclListInfo[i].SrcPortName,PortAclListInfo[i].SrcPortType);
		TableDataInfo[Listlen].Protocol = PortAclListInfo[i].Protocol.toUpperCase();
		Listlen++;
	}
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PortAclConfiglistInfo, port_acl_language, null);
}


function OnChangePortType()
{
	var porttype = getSelectVal('PortType');
	
	if('0'== porttype)
	{
		setDisplay('LANRow',1);
		setDisplay('SSIDRow',0);
	}
	else
	{
		setDisplay('LANRow',0);
		setDisplay('SSIDRow',1);
	}
}

function InitConfigForm()
{
	$("#PortType").append('<option value=' + 0 + ' id="LAN">'+ "LAN" + '</option>');
	if(0 != SSIDNameList.length )
	{
		$("#PortType").append('<option value=' + 1 + ' id="SSID">'+ "SSID" + '</option>');	
	}
	
	
	var i;
	for(i=1; i<=8; i++)
	{
		setDisplay('DivSSID'+i,0);
		if(i > EthNum)
		{
			setDisplay('DivLAN'+i,0);
		}
		
	}
	
	for(i=0 ;i<SSIDNameList.length; i++)
	{
		setDisplay('Div'+SSIDNameList[i].name,1);
	}
}

function EnablePortAclForm()
{
	var Form = new webSubmitForm();
	var Enable = getElById("portaclwhite").checked;
	if (Enable == true)
	{
	   Form.addParameter('x.AccessControlListEnable',1);
	}
	else
	{
        if(false == ConfirmEx(port_acl_language['bbsp_modify_prompt']))
        {	
            setCheck("portaclwhite",1);
            return false;
        }
        else
        {
            setCheck("portaclwhite",0);
        }

	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl'
						+ '&RequestFile=html/bbsp/portacl/portacl.asp');
	Form.submit();
}

if( stbport > 0)
{
	port_acl_language['bbsp_lan'+ stbport] = port_acl_language['bbsp_stb'];
}

</script>


</head>
<body onLoad="OnPageLoad();" class="mainbody"> 

<div id="PromptPanel">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("portacltitle", GetDescFormArrayById(port_acl_language, "bbsp_mune"), GetDescFormArrayById(port_acl_language, "bbsp_title_prompt"), false);
</script> 
<div class="title_spread"></div>  
</div>

<form id="PortAccessEnableForm" style="display:block;"> 
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li   id="portaclwhite"   RealType="CheckBox"  DescRef="bbsp_title_portaclwhiteenable"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="y.PortSrcWhiteListEnable"  InitValue=""  ClickFuncApp="onclick=EnablePortAclForm"/>
	</table>
	<script>
		var PortAccessEnableFormList = new Array();
		var TableClass = new stTableClass("per_35_52", "per_65_48", "ltr");
		PortAccessEnableFormList = HWGetLiIdListByForm("PortAccessEnableForm",null);
		HWParsePageControlByID("PortAccessEnableForm",TableClass,port_acl_language,null);	
		setCheck('portaclwhite',PortAclEnableInfo[0].enable);
	</script>
	<div class="func_spread"></div>
</form> 

<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
    var PortAclConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),									
								new stTableTileInfo("bbsp_td_portname","align_center","SrcPortName"),
								new stTableTileInfo("bbsp_td_protocol","align_center","Protocol"),null);	
								
    ShowListControlInfo();
</script>

<form id="ConfigForm" style="display:none"> 
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="PortType"    	RealType="DropDownList"		DescRef="bbsp_porttype"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField=""   	Elementclass="width_260px "  	InitValue=""  ClickFuncApp="onChange=OnChangePortType"/>
		<li   id="LAN"      RealType="CheckBoxList"		DescRef="bbsp_portname"		RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""    InitValue="[{TextRef:'bbsp_lan1',Value:'LAN1'},{TextRef:'bbsp_lan2',Value:'LAN2'},{TextRef:'bbsp_lan3',Value:'LAN3'},{TextRef:'bbsp_lan4',Value:'LAN4'},{TextRef:'bbsp_lan5',Value:'LAN5'},{TextRef:'bbsp_lan6',Value:'LAN6'},{TextRef:'bbsp_lan7',Value:'LAN'},{TextRef:'bbsp_lan8',Value:'LAN8'}]" />
		<li   id="SSID"     RealType="CheckBoxList"		DescRef="bbsp_portname"		RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""    InitValue="[{TextRef:'bbsp_ssid1',Value:'SSID1'},{TextRef:'bbsp_ssid2',Value:'SSID2'},{TextRef:'bbsp_ssid3',Value:'SSID3'},{TextRef:'bbsp_ssid4',Value:'SSID4'},{TextRef:'bbsp_ssid5',Value:'SSID5'},{TextRef:'bbsp_ssid6',Value:'SSID6'},{TextRef:'bbsp_ssid7',Value:'SSID'},{TextRef:'bbsp_ssid8',Value:'SSID8'}]" />
		<li   id="Protocol"     RealType="CheckBoxList"		DescRef="bbsp_proto"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""   	InitValue="[{TextRef:'bbsp_Telnet',Value:'TELNET'},{TextRef:'bbsp_Http',Value:'HTTP'},{TextRef:'bbsp_SSH',Value:'SSH'},{TextRef:'bbsp_Ftp',Value:'FTP'}]" />
		<script language="JavaScript" type="text/javascript">
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			var PortAclFormList = new Array();
			PortAclFormList = HWGetLiIdListByForm("ConfigForm", null);
			var formid_hide_id = null;
			HWParsePageControlByID("ConfigForm", TableClass, port_acl_language, formid_hide_id);
			InitConfigForm();
		</script>
	</table>
	
	<table class="table_button" cellspacing="1" id="cfg_table" width="100%"> 
	  <tr> 
		<td class='width_per25'>&nbsp;</td>
		<td class="table_submit width_per75"> 
		  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		  <button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();"><script>document.write(port_acl_language['bbsp_app']);</script></button>
		  <button id="canelButton" name="canelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();"><script>document.write(port_acl_language['bbsp_cancel']);</script></button>  
		</td> 
	  </tr>   
	</table>
</form>  
  
</body>
</html>