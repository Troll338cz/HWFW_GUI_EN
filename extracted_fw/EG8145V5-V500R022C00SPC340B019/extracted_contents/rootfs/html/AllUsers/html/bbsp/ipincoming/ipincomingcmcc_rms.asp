<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>

<title>IP Incoming Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style>
.SelectDdns{
	width: 103px;
}
.InputRuleName{
	width: 98px;
}
.InputDdns{
	width: 120px;
}
.PortShowHide{
	display: none;
}
.spanNull{
	margin-left:10px;
}
.restrict_dir_ltr{
	margin-left:3px;
}
</style>
<script language="JavaScript" type="text/javascript">

var ignorefirewall = "<%HW_WEB_GetFeatureSupport(BBSP_FT_IPFLT_IGNORE_FWLEVEL);%>"; 

var LANhostIP = new Array();
var LANhostName = new Array();

LANhostIP[0] = "";
LANhostName[0] = ipincoming_language['hostName_select'];

var SelectSIPStart = "";
var SelectSIPEnd = "";

function stPortFilter(domain, IpFilterInRight, IpFilterInPolicy, IpFilterOutRight, IpFilterOutPolicy, FirewallLevel)
{
    this.domain = domain;
	this.IpFilterInRight   =  IpFilterInRight;
	this.IpFilterInPolicy  =  IpFilterInPolicy;
	this.IpFilterOutRight  =  IpFilterOutRight;
	this.IpFilterOutPolicy =  IpFilterOutPolicy;
	this.FirewallLevel    = FirewallLevel;
}

var NewOrEditFlag = false;
var PortFilters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security,IpFilterInRight|IpFilterInPolicy|IpFilterOutRight|IpFilterOutPolicy|X_HW_FirewallLevel,stPortFilter);%>
var PortFilter = PortFilters[0]; 

var FltsecLevel = PortFilters[0].FirewallLevel.toUpperCase();
var selctIndex = -1;

function stFilterIn(domain, Protocol, Direction, SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd, SourcePortStart, SourcePortEnd, DestPortStart, DestPortEnd, Name)
{
    this.domain = domain;
	this.Protocol = Protocol;	
    this.Direction = Direction;
    this.SourceIPStart = SourceIPStart;
    this.SourceIPEnd = SourceIPEnd;
    this.DestIPStart = DestIPStart;    
    this.DestIPEnd = DestIPEnd;
    this.SourcePortStart = SourcePortStart;
    this.SourcePortEnd = SourcePortEnd;
    this.DestPortStart = DestPortStart;
    this.DestPortEnd = DestPortEnd;	
    this.name = Name;
}
function stFilterOut(domain, Protocol, SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd, SourcePortStart, SourcePortEnd, DestPortStart, DestPortEnd ,Name)
{
    this.domain = domain;
	this.Protocol = Protocol;
    this.SourceIPStart = SourceIPStart;
    this.SourceIPEnd = SourceIPEnd;
    this.DestIPStart = DestIPStart;    
    this.DestIPEnd = DestIPEnd;
    this.SourcePortStart = SourcePortStart;
    this.SourcePortEnd = SourcePortEnd;
    this.DestPortStart = DestPortStart;
    this.DestPortEnd = DestPortEnd;
    this.name = Name;
}

var FilterIn = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.IpFilterIn.{i},Protocol|Direction|SourceIPStart|SourceIPEnd|DestIPStart|DestIPEnd|SourcePortStart|SourcePortEnd|DestPortStart|DestPortEnd|Name,stFilterIn);%>;
var FilterOut = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.IpFilterOut.{i},Protocol|SourceIPStart|SourceIPEnd|DestIPStart|DestIPEnd|SourcePortStart|SourcePortEnd|DestPortStart|DestPortEnd|Name,stFilterOut);%>;

var FilterShowList = [];

var FilterInLength = FilterIn.length - 1;
var FilterOutLength = FilterOut.length - 1;

for(var numTemp2 = 0; numTemp2 < FilterOutLength; numTemp2 ++)
{
	var FilterShowL = new stFilterIn();
	FilterShowL.domain = FilterOut[numTemp2].domain;	
	FilterShowL.name = FilterOut[numTemp2].name;
	FilterShowL.Direction = "Upstream";
	FilterShowL.Protocol = FilterOut[numTemp2].Protocol;
	FilterShowL.SourceIPStart = FilterOut[numTemp2].DestIPStart;
	FilterShowL.SourceIPEnd = FilterOut[numTemp2].DestIPEnd;
	FilterShowL.DestIPStart = FilterOut[numTemp2].SourceIPStart;
	FilterShowL.DestIPEnd = FilterOut[numTemp2].SourceIPEnd;
	FilterShowL.SourcePortStart = FilterOut[numTemp2].DestPortStart;
	FilterShowL.SourcePortEnd = FilterOut[numTemp2].DestPortEnd;
	FilterShowL.DestPortStart = FilterOut[numTemp2].SourcePortStart;
	FilterShowL.DestPortEnd = FilterOut[numTemp2].SourcePortEnd;
	FilterShowList.push(FilterShowL);
}

for(var numTemp1 = 0; numTemp1 < FilterInLength; numTemp1 ++)
{
	FilterIn[numTemp1].Direction = "Downstream";
	FilterShowList.push(FilterIn[numTemp1]);
}

FilterShowList.push(null); 


function SetLanHostNameIp(UserDevices)
{
	var UserDevicesnum = UserDevices.length - 1;
	for (var i = 0,j = 1; i < UserDevicesnum; i++, j++)
	{
		if ("--" != UserDevices[i].HostName)
		{
			LANhostName[j] = UserDevices[i].HostName;
		}
		else
		{
			LANhostName[j] = UserDevices[i].MacAddr;
		}	
		LANhostIP[j] = UserDevices[i].IpAddr;
    }
}

function SHostNameChange(item)
{
	setText('LanSideStarIp',LANhostIP[getSelectVal('SHostName')]);
}

function EHostNameChange(item)
{	
	setText('LanSideEndIp',LANhostIP[getSelectVal('EHostName')]);
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
		b.innerHTML = ipincoming_language[b.getAttribute("BindText")];
	}
}
	
function setBtnDisable()
{
	setDisable('EnableIpFilterOut',1);
	setDisable('FilterModeOut',1);
	setDisable('EnableIpFilterIn',1);
	setDisable('FilterModeIn',1);
	setDisable('btnApply_ex',1);
	setDisable('addButton',1);
	setDisable('editButton',1);
	setDisable('applyButton',1);	
	setDisable('deleteButton',1);
}


function clickRemove() 
{
	var noChooseFlag = true;
	var SubmitForm = new webSubmitForm();	
    if ((FilterShowList.length-1) == 0)
	{
	    AlertEx(ipincoming_language['bbsp_norule']);
	    return;
	}
	
	for (var i = 0; i < FilterShowList.length - 1; i++)
	{
		var rmId = 'IpFilterInAndOutInst_rml'+i;
		var rm = getElementById(rmId);
		if (rm.checked == true)
		{
			noChooseFlag = false;
			SubmitForm.addParameter(FilterShowList[i].domain,'');
		}
	}
    if ( noChooseFlag )
    {
        AlertEx(ipincoming_language['bbsp_plschoose']);
        return ;
    }
 
	if (ConfirmEx(ipincoming_language['bbsp_isdel']) == false)
	{
		return;
    }
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	setBtnDisable()	
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/ipincoming/ipincomingcmcc_rms.asp');
	SubmitForm.submit();	
}

function setSelectSHostName()
{
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (SelectSIPStart == LANhostIP[k])
		{
			setSelect('SHostName', k);
			break;
		}
	}
}
function setSelectEHostName()
{
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (SelectSIPEnd == LANhostIP[k])
		{
			setSelect('EHostName', k);
			break;
		}
	}
}

function CheckIpFilterFull()
{
	var Directionlist = getValue('Direction');
	var MaxLengthAllow = 32+1;
	if(('Downstream' == Directionlist) && (FilterIn.length >= MaxLengthAllow))
	{
		AlertEx(ipincoming_language['Downstream']+ipincoming_language['bbsp_ipfilterfull']);
		return false;
	}
	else if(('Upstream' == Directionlist) && (FilterOut.length >= MaxLengthAllow))
	{
		AlertEx(ipincoming_language['Upstream']+ipincoming_language['bbsp_ipfilterfull']);
		return false;	
	}
	return true;
}

function setControl(index)
{
    var record;
    selctIndex = index;
	
    if (index == -1)
	{
		record = new stFilterIn('', 'ALL','Upstream', '', '', '', '', 0, 0, 0, 0,'');
		setDisplay('ConfigForm', 1);
		setCtlDisplay(record);
		setDisable('applyButton', 0);	
		setDisable('editButton',1);
		setDisable('deleteButton',1);
		setDisable('Direction', 0);
	
	}
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
	else
	{
	}
}


function LoadFrame()
{
	setDisplay('IpFilterInAndOutInst', 1);
	InitControlDataType();
	ProtocalChange();
	setDisable('applyButton', 1);	
	
	if((FltsecLevel != 'CUSTOM') && ("1" != ignorefirewall))
	{
		setBtnDisable();
		setDisplay('IpFilterInAndOutInst', 0);
	}

	loadlanguage();
}

function setCtlDisplay(record)
{
    setText('RuleNameId', record.name);
	setSelect('Protocol', (record.Protocol).toUpperCase());
	setSelect('Direction', record.Direction);
	setText('LanSideStarIp', record.DestIPStart);
	setText('LanSideEndIp', record.DestIPEnd);
	setText('WanSideStartIp', record.SourceIPStart);
	setText('WanSideEndIp', record.SourceIPEnd);
	setText('LanSideStartPort', record.DestPortStart);
	setText('LanSideEndPort', record.DestPortEnd);
	setText('WanSideStartPort', record.SourcePortStart);
	setText('WanSideEndPort', record.SourcePortEnd);	
	ProtocalChange();
}

function ChangMode(FilterMode, FilterModeId, Mode)
{
	if (FilterMode[0].selected == true)
	{ 
		if (false == ConfirmEx(ipincoming_language['bbsp_changemodenote1']))
		{
	        setSelect(FilterModeId, Mode);
			return;
		}
	}
	else if (FilterMode[1].selected == true)
	{ 
		if (false == ConfirmEx(ipincoming_language['bbsp_changemodenote2']))
		{
		     setSelect(FilterModeId, Mode);
			 return;
		}
	}
}

function ChangeModeIn()
{
	var FilterMode = getElementById("FilterModeIn");
	var FilterModeId = "FilterModeIn";
	var Mode = PortFilter.IpFilterInPolicy;
	ChangMode(FilterMode, FilterModeId, Mode);
}

function ChangeModeOut()
{
	var FilterMode = getElementById("FilterModeOut");
	var FilterModeId = "FilterModeOut";	
	var Mode = PortFilter.IpFilterOutPolicy;
	ChangMode(FilterMode, FilterModeId, Mode);
}

function OnSaveIPFilterModeAndPolicy()
{
	var Form = new webSubmitForm(); 
	
	Form.addParameter('x.IpFilterInRight', (true == getElById("EnableIpFilterIn").checked) ? 1 : 0);	
	Form.addParameter('x.IpFilterOutRight', (true == getElById("EnableIpFilterOut").checked) ? 1 : 0);
	
	Form.addParameter('x.IpFilterInPolicy', getValue("FilterModeIn"));
	Form.addParameter('x.IpFilterOutPolicy', getValue("FilterModeOut"));
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	setBtnDisable();	
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
						+ '&RequestFile=html/bbsp/ipincoming/ipincomingcmcc_rms.asp');
	
	Form.submit();
}


function IpFilterRepeateCfgChk(SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd)
{
	var protocolVal = getSelectVal('Protocol');
	var dir = getSelectVal('Direction');

	for (var i = 0; i < FilterShowList.length-1; i++)
	{	
		if(i != selctIndex)
		{	
			if ((FilterShowList[i].SourceIPStart == SourceIPStart)
			    && (FilterShowList[i].SourceIPEnd == SourceIPEnd)				
				&& (FilterShowList[i].DestIPStart == DestIPStart)
				&& (FilterShowList[i].DestIPEnd == DestIPEnd)
				&& (FilterShowList[i].Protocol == protocolVal)
				&& (FilterShowList[i].Direction == dir))
    		    {
					AlertEx(ipincoming_language['bbsp_rulerepeat']);		    
					return false;	
    			}
		}
	} 
	return true;   
}

function CheckForm()
{	
	var SourceIPStart = getValue('LanSideStarIp');
    var SourceIPEnd = getValue('LanSideEndIp');
    var DestIPStart = getValue('WanSideStartIp');
    var DestIPEnd = getValue('WanSideEndIp'); 
	
	if (SourceIPStart != "" && isAbcIpAddress(SourceIPStart) == false)
	{
		AlertEx(ipincoming_language['bbsp_lanstartaddr'] + SourceIPStart + ipincoming_language['bbsp_isvalid']);
		return false;
	}
	if (SourceIPEnd != "" && isAbcIpAddress(SourceIPEnd) == false)
	{
		AlertEx(ipincoming_language['bbsp_lanendaddr'] + SourceIPEnd + ipincoming_language['bbsp_isvalid']);
		return false;
	}
    if (SourceIPEnd != "" 
	    && (IpAddress2DecNum(SourceIPStart) > IpAddress2DecNum(SourceIPEnd)))
	{
		AlertEx(ipincoming_language['bbsp_lanstartaddrinvalid']);
		return false;     	
	}
    if (SourceIPStart == "" && SourceIPEnd != "" ) 
	{
		AlertEx(ipincoming_language['bbsp_lanstartaddrisreq']);
		return false;
	}

	if (DestIPStart != ""  && isAbcIpAddress(DestIPStart) == false) 
	{
		AlertEx(ipincoming_language['bbsp_wanstartaddr'] + DestIPStart + ipincoming_language['bbsp_isvalid']);
		return false;
	}
	if (DestIPEnd != "" && isAbcIpAddress(DestIPEnd) == false) 
	{
		AlertEx(ipincoming_language['bbsp_wanendaddr'] + DestIPEnd + ipincoming_language['bbsp_isvalid']);
		return false;
	}
    if (DestIPEnd != "" 
	    && (IpAddress2DecNum(DestIPStart) > IpAddress2DecNum(DestIPEnd)))
	{
		AlertEx(ipincoming_language['bbsp_wanstartaddrinvalid']);
		return false;     	
	}
    if (DestIPStart == "" && DestIPEnd != "" ) 
	{
		AlertEx(ipincoming_language['bbsp_wanstartaddrisreq']);
		return false;
	}

    if(true != IpFilterRepeateCfgChk(DestIPStart, DestIPEnd, SourceIPStart, SourceIPEnd))
    {
        return false;
    }

	if(true != CheckIpFilterFull())
	{
        return false;	
	}
	
   	return true;
}

function AddSubmitIpAndPortParam(Label, SubmitForm, SourceIPStart, SourceIPEnd, DestIPStart, DestIPEnd, LanSideStartPort, LanSideEndPort, WanSideStartPort, WanSideEndPort, Protocol, RuleNameId)
{
	SubmitForm.addParameter(Label+'.Protocol', Protocol);
	SubmitForm.addParameter(Label+'.Name', RuleNameId);
	SubmitForm.addParameter(Label+'.SourceIPStart', SourceIPStart);
	SubmitForm.addParameter(Label+'.SourceIPEnd', SourceIPEnd);
	SubmitForm.addParameter(Label+'.DestIPStart', DestIPStart);
	SubmitForm.addParameter(Label+'.DestIPEnd', DestIPEnd);
	
	if (getSelectVal('Protocol') != 'ALL' && getSelectVal('Protocol') != 'ICMP')
	{

		SubmitForm.addParameter(Label+'.SourcePortStart', LanSideStartPort);
		SubmitForm.addParameter(Label+'.SourcePortEnd', LanSideEndPort);
		SubmitForm.addParameter(Label+'.DestPortStart', WanSideStartPort);
		SubmitForm.addParameter(Label+'.DestPortEnd', WanSideEndPort);			
	}
	else
	{
		SubmitForm.addParameter(Label+'.SourcePortStart', 0);
		SubmitForm.addParameter(Label+'.SourcePortEnd', 0);
		SubmitForm.addParameter(Label+'.DestPortStart', 0);
		SubmitForm.addParameter(Label+'.DestPortEnd', 0);		
	}
}

function AddSubmitParam(SubmitForm,type)
{
	var IpFilterAddPath = '';
	var DirectionSubmit = getSelectVal('Direction');
	var LanSideStarIp = getValue('LanSideStarIp');
	var LanSideEndIp = getValue('LanSideEndIp');
	var WanSideStartIp = getValue('WanSideStartIp');
	var WanSideEndIp = getValue('WanSideEndIp');
	var LanSideStartPort = getValue('LanSideStartPort');
	var LanSideEndPort = getValue('LanSideEndPort');
	var WanSideStartPort =  getValue('WanSideStartPort');
	var WanSideEndPort =  getValue('WanSideEndPort');
	var Protocol = getSelectVal('Protocol');
	var RuleNameId = getSelectVal('RuleNameId');
	var Label = 'x';
		
	if("Downstream" == DirectionSubmit)
	{
		AddSubmitIpAndPortParam(Label, SubmitForm, WanSideStartIp, WanSideEndIp, LanSideStarIp, LanSideEndIp, WanSideStartPort, WanSideEndPort, LanSideStartPort, LanSideEndPort, Protocol, RuleNameId);		
		IpFilterAddPath = '.IpFilterIn';
	}
	else if("Upstream" == DirectionSubmit)
	{
		AddSubmitIpAndPortParam(Label, SubmitForm, LanSideStarIp, LanSideEndIp, WanSideStartIp, WanSideEndIp, LanSideStartPort, LanSideEndPort, WanSideStartPort, WanSideEndPort, Protocol, RuleNameId);
		IpFilterAddPath = '.IpFilterOut';	
	}

	setBtnDisable();
	
	if (selctIndex == -1)
	{	
		SubmitForm.setAction('add.cgi?x=InternetGatewayDevice.X_HW_Security'+IpFilterAddPath
								 + '&RequestFile=html/bbsp/ipincoming/ipincomingcmcc_rms.asp');	
	}
	else if (FilterShowList[selctIndex].Direction != DirectionSubmit)
	{

	}
	else
	{ 
		SubmitForm.setAction('set.cgi?x=' + FilterShowList[selctIndex].domain
				+ '&RequestFile=html/bbsp/ipincoming/ipincomingcmcc_rms.asp');
	}
}


function OnEditIpIncomingFilter()
{
    if(selctIndex < 0)
	{	
		if(FilterShowList.length <= 1)
		{
			AlertEx(ipincoming_language['bbsp_filternorule']);
			return;
		}
		else
		{
			selctIndex = 0; 
		}
    }
	var record = FilterShowList[selctIndex];
	setCtlDisplay(record);
	setDisplay('ConfigForm', 1);
	setDisable('Direction', 1);
	setDisable('applyButton', 0);
}

function ProtocalChange(event_invoke)
{   
    var currentPro = getSelectVal('Protocol');
    
    setDisplay('LanSideStarIpRow', 1);
	setDisplay('WanSideStartIpRow', 1);
    switch (currentPro)
    {
        case "ALL":
        case "ICMP":
            setDisplay('LanSidePortIdRow', 0);
			setDisplay('WanSidePortIdRow', 0);
            break;
        default:
			setDisplay('LanSidePortIdRow', 1);
			setDisplay('WanSidePortIdRow', 1);
            break;
    }
}

function SetLanHostOptionInfoStart()
{
	var output = "";
	output = output + '<select class="restrict_dir_ltr" name=' + "'SHostName'" + ' id=' + "'SHostName'" + ' size="1" onChange=' + '"SHostNameChange(item)"' + ' style="width: 110px">';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = output + '<option value="' + i + '" id="' + htmlencode(LANhostName[i]) + '">' + htmlencode(LANhostName[i]) + '</option>';			   
	} 
	output = output + '</select>';
	$("#LanSideStarIp").after(output);
}	
function SetLanHostOptionInfoEnd()
{
	var output = "";
	output = output + '<select class="restrict_dir_ltr" name=' + "'EHostName'" + ' id=' + "'EHostName'" + ' size="1" onChange=' + '"EHostNameChange(item)"' + ' style="width: 110px">';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = output + '<option value="' + i + '" id="' + htmlencode(LANhostName[i]) + '">' + htmlencode(LANhostName[i]) + '</option>';			   
	} 
	output = output + '</select>'; 
	$("#LanSideEndIp").after(output);
}	

function IpFilterInAndOutInstselectRemoveCnt(obj)
{

}

function ShowIpFilterProtocol(pro)
{
	if("ALL" == pro)
	{
		return ipincoming_language['ALL'];		
	}
	else
	{
		return pro;
	}
}

function ShowIpFilterTableDataIp(DateInfo, IpStart, IpEnd, LanOrWan)
{
	var ShowInfo;
	
	if((""== IpStart) && (""== IpEnd))
	{
		ShowInfo = "--";
	}
	else if(""== IpEnd)
	{
		ShowInfo = IpStart;
	}
	else
	{
		ShowInfo = IpStart  +"--" + IpEnd;	
	}
	
	if('lan' == LanOrWan)
	{
		DateInfo.LanSideStarIp = ShowInfo;		
	}
	else if('wan' == LanOrWan)
	{
		DateInfo.WanSideStartIp = ShowInfo;
	}	
}

function ShowIpFilterTableData(ColumnNum)
{
	var TableDataInfo = new Array();										 
	var Show = 0;
	if (FilterShowList.length <= 1)
	{
		var inst = new stFilterIn();
		inst.domain  = '--';		
		inst.name  = '--';
		inst.Protocol = '--';
		inst.Direction = '--';
		inst.LanSideStarIp = '--';
		inst.WanSideStartIp = '--';	
		TableDataInfo.push(inst);
	}
	else
	{
		for (var t = 0;t < (FilterShowList.length - 1); t++)
		{  			
			TableDataInfo[Show] = new stFilterIn();
			TableDataInfo[Show].domain  = FilterShowList[t].domain;		
			TableDataInfo[Show].name = FilterShowList[t].name; 
			TableDataInfo[Show].Protocol = ShowIpFilterProtocol(FilterShowList[t].Protocol);
			TableDataInfo[Show].Direction = ipincoming_language[FilterShowList[t].Direction]; 
			ShowIpFilterTableDataIp(TableDataInfo[Show], FilterShowList[t].DestIPStart, FilterShowList[t].DestIPEnd ,'lan');		
			ShowIpFilterTableDataIp(TableDataInfo[Show], FilterShowList[t].SourceIPStart, FilterShowList[t].SourceIPEnd, 'wan');		
			Show++;
		}

	}
	TableDataInfo.push(null);		
	HWShowTableListByType(1, "IpFilterInAndOutInst", false, ColumnNum, TableDataInfo, IpFilterInAndOutInfo, ipincoming_language, null);	

}

function ShowFilterModeTitle()
{
	getElementById("FilterModeInRow").title = ipincoming_language['title4'];
	getElementById("FilterModeOutRow").title = ipincoming_language['title4'];	
	getElById("FilterModeOut")[0].title = ipincoming_language['title1'];
	getElById("FilterModeOut")[1].title = ipincoming_language['title2'];
	getElById("FilterModeIn")[0].title = ipincoming_language['title1'];
	getElById("FilterModeIn")[1].title = ipincoming_language['title2'];	
}



</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div id="ConfigForm1"style="display:inline"></div>
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("ipincoming", GetDescFormArrayById(ipincoming_language, "bbsp_mune"), GetDescFormArrayById(ipincoming_language, "bbsp_ipincomingcmcc_rms_title"), false);
</script>
<div class="title_spread"></div>
<form id="ipFilterForm" name="ipFilterForm">
<table id="ipFilterFormPanel" cellspacing="1" cellpadding="0" width="100%">
<li id="EnableIpFilterOut"  RealType="CheckBox" 	DescRef="bbsp_filteroutpolicy" 	RemarkRef="tip_perfence" ErrorMsgRef="Empty" Require="FALSE" BindField="x.IpFilterOutRight"   InitValue="Empty" /> 
<li id="FilterModeOut"      RealType="DropDownList" DescRef="bbsp_filteroutenable" 	RemarkRef="Empty" 		 ErrorMsgRef="Empty" Require="FALSE" BindField="x.IpFilterOutPolicy" 	InitValue="[{TextRef:'bbsp_blackList',Value:'0'},{TextRef:'bbsp_whiteList',Value:'1'}]" ClickFuncApp="onchange=ChangeModeOut" />
<li id="EnableIpFilterIn"   RealType="CheckBox" 	DescRef="bbsp_filterinpolicy" 	RemarkRef="tip_perfence" ErrorMsgRef="Empty" Require="FALSE" BindField="x.IpFilterInRight" 	InitValue="Empty" />
<li id="FilterModeIn"       RealType="DropDownList" DescRef="bbsp_filterinenable" 	RemarkRef="Empty" 		 ErrorMsgRef="Empty" Require="FALSE" BindField="x.IpFilterInPolicy" 	InitValue="[{TextRef:'bbsp_blackList',Value:'0'},{TextRef:'bbsp_whiteList',Value:'1'}]" ClickFuncApp="onchange=ChangeModeIn" />
</table>
<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("table_title width_per20 align_left", "table_right align_left");
	var ipFilterFormList = new Array();
	ipFilterFormList = HWGetLiIdListByForm("ipFilterForm",null);
	HWParsePageControlByID("ipFilterForm",TableClass,ipincoming_language,null);
	HWSetTableByLiIdList(ipFilterFormList,PortFilter,null);
	ShowFilterModeTitle();
</script>
<table id="ipFilterFormPanel2" width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button"> 
<tr align="right">
<td class="table_submit"> 
<input class="ApplyButtoncss buttonwidth_100px" name="btnApply_ex" id= "btnApply_ex" type="button" BindText="bbsp_app_save" onClick="OnSaveIPFilterModeAndPolicy();"> 
</td>
</tr> 
</table>
</form>
<div class="func_spread"></div>
<hr style="color:#C9C9C9"></hr>
<table class="tabal_bg" id="ipfilter" width="100%" border="0" align="center" cellpadding="0" cellspacing="1"> 
	<script language="JavaScript" type="text/javascript">
		var IpFilterInAndOutInfo = new Array(    new stTableTileInfo("Empty","align_center width_per5","DomainBox"),
												 new stTableTileInfo("tip_rule_name2","align_center width_per8","name"),
												 new stTableTileInfo("bbsp_protocol","align_center width_per10","Protocol"),
												 new stTableTileInfo("bbsp_direction","align_center width_per10","Direction"),
												 new stTableTileInfo("bbsp_lanip","align_center width_per25","LanSideStarIp"), 		
												 new stTableTileInfo("bbsp_wanip","align_center width_per25","WanSideStartIp"),null);	
		ShowIpFilterTableData(IpFilterInAndOutInfo.length - 1);							 
	</script> 
</table> 
<div id="ConfigForm" style="display:none"> 
<div class="list_table_spread"></div>
<form id="ConfigurationForm" name="ConfigurationForm">
<table id="ConfigurationFormPanel" cellpadding="2" cellspacing="0" width="100%">
<li id="RuleNameId"    			RealType="TextBox" 			DescRef="tip_rule_name" 		RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty" 			Elementclass="InputRuleName" 	MaxLength="32" 		InitValue="Empty" />
<li id="Protocol"  				RealType="DropDownList" 	DescRef="bbsp_protocolmh" 		RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty" 			Elementclass="SelectDdns" 							InitValue="[{TextRef:'ALL',Value:'ALL'},{TextRef:'TCPUDP',Value:'TCP/UDP'},{TextRef:'TCP',Value:'TCP'},{TextRef:'UDP',Value:'UDP'},{TextRef:'ICMP',Value:'ICMP'}]" ClickFuncApp="onchange=ProtocalChange" />
<li id="Direction" 				RealType="DropDownList" 	DescRef="bbsp_directionmh" 		RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty" 			Elementclass="SelectDdns" 							InitValue="[{TextRef:'Upstream',Value:'Upstream'},{TextRef:'Downstream',Value:'Downstream'}]" />
<li id="LanSideStarIp" 			RealType="TextOtherBox" 	DescRef="bbsp_lanip" 			RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty" 										MaxLength="15" 
InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'LanSideStarIpBias'},{AttrName:'innerhtml', AttrValue:'bbsp_dash'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'LanSideEndIp'},{AttrName:'MaxLength', AttrValue:'15'}]}]"/>  
<li id="WanSideStartIp" 			RealType="TextOtherBox" 	DescRef="bbsp_wanip" 			RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty" 													MaxLength="15" 
InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'WanSideStartIpBias'},{AttrName:'innerhtml', AttrValue:'bbsp_dash'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'WanSideEndIp'},{AttrName:'MaxLength', AttrValue:'15'}]}]"/>  
<li id="LanSidePortId" 			RealType="TextOtherBox" 	DescRef="bbsp_lanport" 			RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty"  			Elementclass="PortShowHide" 			MaxLength="90" 
InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'LanSideStartPortTilte'},{AttrName:'innerhtml', AttrValue:'bbsp_ipincoming_startport'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'LanSideStartPort'},{AttrName:'MaxLength', AttrValue:'90'}]},
			{Type:'span',Item:[{AttrName:'id',AttrValue:'LanSidePortBias'},{AttrName:'class', AttrValue:'spanNull'}]},	
			{Type:'span',Item:[{AttrName:'id',AttrValue:'LanSideEndPortTilte'},{AttrName:'innerhtml', AttrValue:'bbsp_ipincoming_endport'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'LanSideEndPort'},{AttrName:'MaxLength', AttrValue:'90'}]}]"/> 
<li id="WanSidePortId" 			RealType="TextOtherBox" 	DescRef="bbsp_wanport" 			RemarkRef="Empty" 		ErrorMsgRef="Empty" 	Require="FALSE" 	BindField="Empty" 			Elementclass="PortShowHide" 			MaxLength="90" 
InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'WanSideStartPortTilte'},{AttrName:'innerhtml', AttrValue:'bbsp_ipincoming_startport'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'WanSideStartPort'},{AttrName:'MaxLength', AttrValue:'50'}]},
			{Type:'span',Item:[{AttrName:'id',AttrValue:'WanSidePortBias'},{AttrName:'class', AttrValue:'spanNull'}]},		
			{Type:'span',Item:[{AttrName:'id',AttrValue:'WanSideEndPortTilte'},{AttrName:'innerhtml', AttrValue:'bbsp_ipincoming_endport'}]},
			{Type:'text',Item:[{AttrName:'id',AttrValue:'WanSideEndPort'},{AttrName:'MaxLength', AttrValue:'50'}]}]"/> 
</table>
<script>
var TableClassTwo = new stTableClass("table_title width_per20", "table_right width_per80","ltr"); 
var ConfigurationFormList = new Array();
	ConfigurationFormList = HWGetLiIdListByForm("ConfigurationForm",null);
	HWParsePageControlByID("ConfigurationForm", TableClassTwo, ipincoming_language, null);

</script>	 
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button"> 
<tr align="right">
<td class='width_per35'></td> 
<td class="table_submit"> 
<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
<input class="ApplyButtoncss buttonwidth_100px"  name="addButton"   	id= "addButton" 	type="button" 	BindText="bbsp_add" 	onClick="clickAdd('IpFilterInAndOutInst_head');"> 
<input class="ApplyButtoncss buttonwidth_100px"  name="editButton"    	id= "editButton" 	type="button" 	BindText="bbsp_edit" 	onClick="OnEditIpIncomingFilter();"> 
<input class="ApplyButtoncss buttonwidth_100px"  name="applyButton"   	id= "applyButton" 	type="button" 	BindText="bbsp_app" 	onClick="Submit();"> 
<input class="CancleButtonCss buttonwidth_100px" name="deleteButton" 	id= "deleteButton" 	type="button" 	BindText="bbsp_Delete" 	onClick="clickRemove();">
</td>
</tr> 
</table> 
</form>	
<div style="height:10px;"></div>
  <script language="JavaScript" type="text/javascript">
	GetLanUserDevInfo(function(para)
	{
		SetLanHostNameIp(para);
		SetLanHostOptionInfoStart();
		SetLanHostOptionInfoEnd();
		setSelectSHostName();
		setSelectEHostName();
	});
	ParseBindTextByTagName(ipincoming_language, "input", 2);
</script>
</div>
</body>
</html>