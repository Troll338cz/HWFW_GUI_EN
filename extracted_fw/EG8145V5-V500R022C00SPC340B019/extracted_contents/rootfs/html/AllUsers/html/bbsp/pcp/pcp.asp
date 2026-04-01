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
<script language="Javascript" src="../common/portfwdprohibit.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="javascript" src="../common/pcplist.asp"></script>
<script language="javascript" src="../common/userinfo.asp"></script>

<script language="JavaScript" type="text/javascript">
var curUserType='<%HW_WEB_GetUserType();%>';  
var currentFile='pcp.asp';
var TableClass = new Array();
    TableClass["left"] = "width_per30";
    TableClass["right"] = "width_per70";
var selctIndex = -1;
var listNum = 10;
var CurrentMode;

if (GetPcpMappingList().length > 0)
{
    var PcpList = GetPcpMappingList();
    var Idx = PcpList.length;
}
else
{
    Idx = 0;
}

var MappingInfoNr = Idx;

var firstpage = 1;
if(MappingInfoNr == 0)
{
	firstpage = 0;
}

var lastpage = MappingInfoNr/listNum;
if(lastpage != parseInt(lastpage,10))
{
	lastpage = parseInt(lastpage,10) + 1;	
}

var page = firstpage;

if( window.location.href.indexOf("del.cgi") == -1 && window.location.href.indexOf("add.cgi") == -1 && window.location.href.indexOf("set.cgi") == -1 && window.location.href.indexOf("?") > 0 )
{
  page = parseInt(window.location.href.split("?")[1],10); 
}

if(page < firstpage)
{
	page = firstpage;
}
else if( page > lastpage ) 
{
	page = lastpage;
}

function SetEditMode()
{
    CurrentMode = "EDIT";    
}
function SetAddMode()
{
    CurrentMode = "ADD";    
}

function IsEditMode()
{
    return CurrentMode=="EDIT" ? true : false;
}
function IsAddMode()
{
    return CurrentMode=="ADD" ? true : false;
}

function PcpConfigListselectRemoveCnt()
{
}

function AddPcpList()
{
	setControl(-1);
}
function DelPcpList()
{
        var CheckBoxList = document.getElementsByName("PcpConfigListrml");
		var PcpListInfo = GetPcpMappingList();
        var Form = new webSubmitForm();
        var Count = 0;
      
	    if(PcpListInfo.length == 0)
		{
		    AlertEx(pcpmapping_language['bbsp_pcp_delnone']);
            return false;
		}
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
		    AlertEx(pcpmapping_language['bbsp_pcp_del']);
            return false;
        }
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_PCP.1.PCPMapping' + '&RequestFile=html/bbsp/pcp/pcp.asp');
        Form.submit();
        setDisable('ButtonApply',1);
    	setDisable('ButtonCancel',1);
        return false;          
}

    function OnAddButtonClick()
    {
		setDisplay("pcpmappinglist", "1");
		var AddRecord = new stPcpMappingList("","","","","","");
		HWSetTableByLiIdList(PcpmappingConfigFormList, AddRecord, null);
		return; 		
    }

function setControl(index)
{
    var record;
    selctIndex = index;
	var PcpmappingItem = GetPcpMappingData();
	
	if (index < -1)
    {
         return;
    }
	
	
    if (index == -1)
    {
        SetAddMode();
        return OnAddButtonClick();  
    }
	else
	{
	    SetEditMode();
		var EditRecord = new stPcpMappingList();
		if (page >= 1)
		{
		    index = (parseInt(page - 1,10)*10)+index;
		}
		EditRecord = GetPcpMappingList()[index];

		HWSetTableByLiIdList(PcpmappingConfigFormList, EditRecord, EditCallBack);
		if (EditRecord.Origin == 'UPnP')
		{
		    setDisable('AllowProposal',1);	
            setDisable('Protocol',1);
	        setDisable('InternalAddress',1);	
            setDisable('InternalPort',1);
	        setDisable('RequiredExternalAddress',1);	
            setDisable('RequiredExternalPort',1);
			setDisable('ButtonApp',1);	
            setDisable('ButtonCancel',1);
		}
		else
		{
		    setDisable('AllowProposal',0);	
            setDisable('Protocol',0);
	        setDisable('InternalAddress',0);	
            setDisable('InternalPort',0);
	        setDisable('RequiredExternalAddress',0);	
            setDisable('RequiredExternalPort',0);
			setDisable('ButtonApp',0);	
            setDisable('ButtonCancel',0);
		}
		
		return;
	}
	
	
    setDisable('btnApply_ex',0);	
    setDisable('cancelValue',0);
}

function EditCallBack()
{
	setDisplay('pcpmappinglist',1);
	setDisplay('Origin',0);
	setDisplay('Status',0);
	
}
	
	function CheckPcpMappingListData(PcpListData)
    {
	    var PcpData = GetPcpmapping();
		var InternalAddress = PcpListData.InternalAddress;
		var InternalPort = PcpListData.InternalPort ;
		var RequiredExternalAddress = PcpListData.RequiredExternalAddress;
		var RequiredExternalPort = PcpListData.RequiredExternalPort ;
		var Protocol = PcpListData.Protocol;
		var AllowProposal = PcpListData.AllowProposal;
		var Origin = PcpListData.Origin;
		var ExternalAddress = PcpListData.ExternalAddress;
		var ExternalPort = PcpListData.ExternalPort;
		var Status = PcpListData.Status;
		var PcpMappingData = GetPcpMappingList();
		var PcpMappingListLen = 0;
		var PcpmappingItem = GetPcpmapping();
		
		for (var i= 0; i< GetPcpMappingList().length;i++)
		{
			if (PcpMappingData[i].Origin != 'UPnP')
			{
			    PcpMappingListLen++;
			}
		}
		if ((PcpMappingListLen >=32) && (IsAddMode() == true))
		{
		    AlertEx(pcpmapping_language['bbsp_alert_recfull']);
            return false;
		}
		

		if (PcpmappingItem.length <= 1)
		{
		    AlertEx(pcpmapping_language['pcp_none']);
            return false;
		}
		
		if (InternalPort == '')
		{
		    AlertEx(pcpmapping_language['pcp_bbsp_InternalPort']);
            return false;
		}
		
		if ((InternalPort != '') && (false == CheckNumber(InternalPort, 1, 65535)))
		{
		     AlertEx(pcpmapping_language['pcp_bbsp_InternalPortvoild']);
            return false;
		}
		
		if ((InternalPort != '')&&(InternalPort <= 0 || InternalPort > 65535))
		{
		    AlertEx(pcpmapping_language['pcp_bbsp_InternalPortvoild']);
            return false;
		}
		
		if (Protocol != 'TCP' && Protocol != 'UDP')
		{
		    AlertEx(pcpmapping_language['pcp_protocol']);
            return false;
		}
		
		if ((RequiredExternalPort != '') && (false == CheckNumber(RequiredExternalPort, 0, 65535)))
		{
		     AlertEx(pcpmapping_language['pcp_bbsp_RequiredExternalPortvoild']);
            return false;
		}
		if ((RequiredExternalPort != '') && (RequiredExternalPort < 0 || RequiredExternalPort > 65535))
		{
		    AlertEx(pcpmapping_language['pcp_bbsp_RequiredExternalPortvoild']);
            return false;
		}
		
		for (var i= 0; i< GetPcpMappingList().length;i++)
		{
		    var index='';
			if (page >= 1)
			{
			    index = (parseInt(page - 1,10)*10)+selctIndex;
			}
			if ((index != i)
			   &&(InternalAddress == PcpMappingData[i].InternalAddress)
		       && (InternalPort == PcpMappingData[i].InternalPort) 
			   && (Protocol == PcpMappingData[i].Protocol))
		   {
		        AlertEx(pcpmapping_language['bbsp_ruleexist']);
                return false;
		   }
		}
		
		return true;
	    
    }
	
    function GetPcpMappingData()
    {
	    var CurrentDomain = (GetPcpmapping()[0] != null)?GetPcpmapping()[0].domain:"";
        return new stPcpMapping(CurrentDomain,getCheckVal("PcpEnable"), getSelectVal("WanNameList"),"", getValue("PcpServer"));
    }
	
	function IsDisliteWan(Wan)
  {
      if (Wan != null)
	  {
	      if ((Wan.ProtocolType =="IPv6") && (Wan.IPv6DSLite == "Dynamic" || Wan.IPv6DSLite == "Static"))
          {
              return true;
          } 
	  }
      return false;
  }

function GetCurrentWan(Domain)
{
    
    for (var i = 0; i < GetWanList().length;i++)
    {
	    if (GetWanList()[i].domain == Domain)
		{
			return GetWanList()[i];
		}
    }
}

	function OnApplyButtonPcpClick()
	{
		var PcpmappingItem = GetPcpMappingData();
			
        var EnablePra = PcpmappingItem.Enable;
		var InterfacePre = PcpmappingItem.Interface ;
		var PlainMode = PcpmappingItem.PlainMode ;
		var ServerAddressPra = PcpmappingItem.ServerAddress;
		var CurrentWan = '';
		
		CurrentWan = GetCurrentWan(InterfacePre);
		
		if (CurrentWan != null)
		{
		    if (IsDisliteWan(CurrentWan) == true)
		    {
		        PlainMode = 1;
		    }
		}
		else
		{
		    PlainMode = 0;
		}
		var SpecPcpConfigParaList = new Array(new stSpecParaArray("x.Enable",EnablePra, 0),
											  new stSpecParaArray("x.Interface",InterfacePre, 0),
											   new stSpecParaArray("x.PlainMode",PlainMode, 4),
											  new stSpecParaArray("x.ServerAddress",ServerAddressPra, 0));
											  
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = PcpmappingConfigForm;
		Parameter.SpecParaPair = SpecPcpConfigParaList;
		var url = '';							  
		Parameter.asynflag = null;
		if (GetPcpmapping().length == 1)
		{
			url = 'add.cgi?x=InternetGatewayDevice.X_HW_PCP' + '&RequestFile=html/bbsp/pcp/pcp.asp';
		}
		else
		{
			url = 'set.cgi?x=InternetGatewayDevice.X_HW_PCP.1' + '&RequestFile=html/bbsp/pcp/pcp.asp';
		}
		
		var tokenvalue = getValue('hwonttoken');
		HWSetAction(null, url, Parameter, tokenvalue);
		
		setDisable('ButtonPcpApp',1);
    	setDisable('ButtonPcpCancel',1);
        return;		
	}
	
	function GetPcpMappingListData()
	{
		var index='';
		if (page >= 1)
		{
		    index = (parseInt(page - 1,10)*10)+selctIndex;
		}

		var CurrentDomain = (GetPcpMappingList()[index] != null)?GetPcpMappingList()[index].domain:"";
		return new stPcpMappingList(CurrentDomain,getValue("InternalAddress"), getValue("InternalPort"), getSelectVal("Protocol"),getValue("RequiredExternalAddress"), getValue("RequiredExternalPort"),getSelectVal("AllowProposal"), getValue("Origin"),getValue("ExternalAddress"),getValue("ExternalPort"),getValue("Status"));
	}

	function OnApplyButtonPcpListClick()
	{
		var PcpmappingListItem = GetPcpMappingListData();
			
        var InternalAddress = PcpmappingListItem.InternalAddress;
		var InternalPort = PcpmappingListItem.InternalPort ;
		var Protocol = PcpmappingListItem.Protocol;
		var RequiredExternalAddress = PcpmappingListItem.RequiredExternalAddress;
		var RequiredExternalPort = PcpmappingListItem.RequiredExternalPort ;
		var AllowProposal = PcpmappingListItem.AllowProposal;
		
		if (false == CheckPcpMappingListData(PcpmappingListItem))
		{
		    return;	
		}
		
		if (AllowProposal == '1')
		{
		    AllowProposal = 1;
		}
		else
		{
		    AllowProposal = 0;
		}
		
		var SpecPcplistConfigParaList = new Array(new stSpecParaArray("x.InternalAddress",InternalAddress, 0),
											  new stSpecParaArray("x.InternalPort",InternalPort, 0),
											  new stSpecParaArray("x.Protocol",Protocol, 0),
											  new stSpecParaArray("x.RequiredExternalAddress",RequiredExternalAddress, 0),
											  new stSpecParaArray("x.RequiredExternalPort",RequiredExternalPort, 0),
											  new stSpecParaArray("x.AllowProposal",AllowProposal, 0));
											  
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = PcpmappingConfigFormList;
		Parameter.SpecParaPair = SpecPcplistConfigParaList;
		var url = '';							  
		Parameter.asynflag = null;
		
		if (IsAddMode() == true)
        {
            url = 'add.cgi?x=InternetGatewayDevice.X_HW_PCP.1.PCPMapping' + '&RequestFile=html/bbsp/pcp/pcp.asp';
        }
        else
        {
            url = 'set.cgi?x='+PcpmappingListItem.domain + '&RequestFile=html/bbsp/pcp/pcp.asp';
        }

		var tokenvalue = getValue('onttoken');
		HWSetAction(null, url, Parameter, tokenvalue);
		
		setDisable('ButtonApp',1);
    	setDisable('ButtonCancel',1);
        return;		
	}
	
	function stPcpTableTileInfo(DesRef, TableClass, ShowAttrName)
	{
		this.DesRef = DesRef;
		this.TableClass = TableClass;
		this.ShowAttrName = ShowAttrName;
	}
	
	function OnCancelButtonClick()
	{
	    setDisplay('pcpmappinglist',0);
	}
	
	function InitPcpTableList()
	{
	    var PcpMapping = new stPcpMapping();
		PcpMapping = GetPcpmapping()[0];
		var FillData = HWcloneObject(PcpMapping, 1);
	    HWSetTableByLiIdList(PcpmappingConfigForm, FillData, null);
	}
	
	var ShinePortArray = new Array();
	var ShineIpArray = new Array();

function blinklinkport() 
{    

    for (var i = 0; i < ShinePortArray.length;i++)
	{
		if (!document.getElementById(ShinePortArray[i]).style.color) 
		{        
			document.getElementById(ShinePortArray[i]).style.color = "red";    
		}   
		if (document.getElementById(ShinePortArray[i]).style.color == "red") 
		{        
			document.getElementById(ShinePortArray[i]).style.color = "black";    
		} 
		else 
		{       
			 document.getElementById(ShinePortArray[i]).style.color = "red";   
		}
		
		document.getElementById(ShinePortArray[i]).title = "The required external port is different from the one obtained from the server.";
	}
	
	
  	timer = setTimeout("blinklinkport()", 333);
 }
 
 function blinklinkip() 
{    

    for (var i = 0; i < ShineIpArray.length;i++)
	{
		
		if (!document.getElementById(ShineIpArray[i]).style.color) 
		{        
			document.getElementById(ShineIpArray[i]).style.color = "red";    
		}   
		if (document.getElementById(ShineIpArray[i]).style.color == "red") 
		{        
			document.getElementById(ShineIpArray[i]).style.color = "black";    
		} 
		else 
		{       
			 document.getElementById(ShineIpArray[i]).style.color = "red";   
		}
		document.getElementById(ShineIpArray[i]).title = "The required external IP address is different from the one obtained from the server.";
	}
	
	
  	timer = setTimeout("blinklinkip()", 333);
 }
	
function showlistcontrol()
{
	var ColumnNum = 9;
	var ShowTableFlag = true;
    var PcpListlen = 0;
    var i = 0;
	var startIdx ;
	var endIdx;
    var PcpListInfo = GetPcpMappingList();
	var TableDataInfo = new Array();
		
	if (PcpListInfo.length == 0)
	{
		TableDataInfo.push(null);
		HWShowTableListByType(ShowTableFlag,"PcpConfigList", false, ColumnNum, TableDataInfo, PcpConfiglistInfo, pcpmapping_language, null);
		isNeedReloadPcpMappingList();
		return;
	}

	sessionStorage.setItem("reloadcount", 1);

	if( MappingInfoNr >= listNum*parseInt(page,10) )
	{
		startIdx = (parseInt(page,10)-1)*listNum;
		endIdx = parseInt(page,10)*listNum;
	    for(i = startIdx; i < endIdx; i++)
		{
			TableDataInfo[PcpListlen] = new stPcpMappingList();
			TableDataInfo[PcpListlen].domain = PcpListInfo[i].domain;
		    TableDataInfo[PcpListlen].Origin = PcpListInfo[i].Origin;
			TableDataInfo[PcpListlen].ExternalAddress = PcpListInfo[i].ExternalAddress;
			TableDataInfo[PcpListlen].ExternalPort = PcpListInfo[i].ExternalPort;
			TableDataInfo[PcpListlen].InternalPort = PcpListInfo[i].InternalPort;
			TableDataInfo[PcpListlen].Protocol = PcpListInfo[i].Protocol;
			TableDataInfo[PcpListlen].InternalAddress = PcpListInfo[i].InternalAddress;
			TableDataInfo[PcpListlen].RequiredExternalAddress = PcpListInfo[i].RequiredExternalAddress;
			TableDataInfo[PcpListlen].RequiredExternalPort = PcpListInfo[i].RequiredExternalPort;
			TableDataInfo[PcpListlen].Status = PcpListInfo[i].Status;
			
			if (PcpListInfo[i].AllowProposal == '0')
	        {  
	            TableDataInfo[PcpListlen].AllowProposal = 'N';
	        }
	        else
	        {
	            TableDataInfo[PcpListlen].AllowProposal = 'Y';
	        }
			PcpListlen++;
		}
		TableDataInfo.length = PcpListlen;
		TableDataInfo.push(null);
       HWShowTableListByType(ShowTableFlag,"PcpConfigList", false, ColumnNum, TableDataInfo, PcpConfiglistInfo, pcpmapping_language, null);

	}
	else
	{
		startIdx = (parseInt(page,10)-1)*listNum;
		endIdx = MappingInfoNr;
	    for(i = startIdx; i < endIdx; i++)
		{
			TableDataInfo[PcpListlen] = new stPcpMappingList();
			TableDataInfo[PcpListlen].domain = PcpListInfo[i].domain;
		    TableDataInfo[PcpListlen].Origin = PcpListInfo[i].Origin;
			TableDataInfo[PcpListlen].ExternalAddress = PcpListInfo[i].ExternalAddress;
			TableDataInfo[PcpListlen].ExternalPort = PcpListInfo[i].ExternalPort;
			TableDataInfo[PcpListlen].InternalPort = PcpListInfo[i].InternalPort;
			TableDataInfo[PcpListlen].Protocol = PcpListInfo[i].Protocol;
			TableDataInfo[PcpListlen].InternalAddress = PcpListInfo[i].InternalAddress;
			TableDataInfo[PcpListlen].RequiredExternalAddress = PcpListInfo[i].RequiredExternalAddress;
			TableDataInfo[PcpListlen].RequiredExternalPort = PcpListInfo[i].RequiredExternalPort;
			TableDataInfo[PcpListlen].Status = PcpListInfo[i].Status;
			
			if (PcpListInfo[i].AllowProposal == '0')
	        {  
	            TableDataInfo[PcpListlen].AllowProposal = 'N';
	        }
	        else
	        {
	            TableDataInfo[PcpListlen].AllowProposal = 'Y';
	        }
			PcpListlen++;
		}
		TableDataInfo.length = PcpListlen;
		TableDataInfo.push(null);
       HWShowTableListByType(ShowTableFlag,"PcpConfigList", false, ColumnNum, TableDataInfo, PcpConfiglistInfo, pcpmapping_language, null);
	}

	for(i = 0; i < TableDataInfo.length - 1; i++)
	{
	    var ShineArray = new Array();
		var Shineport;
		var Shineip;
		
	    if ((TableDataInfo[i].RequiredExternalPort != TableDataInfo[i].ExternalPort)&& (TableDataInfo[i].Status == 'Success'))
		{
		    Shineport = 'PcpConfigList_' + i +'_3';
			ShinePortArray.push(Shineport);
		}
	    if ((TableDataInfo[i].RequiredExternalAddress != TableDataInfo[i].ExternalAddress)&& (TableDataInfo[i].Status == 'Success'))
		{
			Shineip = 'PcpConfigList_' + i +'_2';
			ShineIpArray.push(Shineip);
		}
	}
	blinklinkport();
	blinklinkip();
	
}



function IsValidPage(pagevalue)
{
	if (true != isInteger(pagevalue))
	{
		return false;
	}
	return true;
}

function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		return;
	}
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitprv()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page--;
	window.location = currentFile + "?" + parseInt(page,10);
}

function submitnext()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page++;
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		return;
	}
	
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitjump()
{
	var jumppage = getValue('pagejump');
	if((jumppage == '') || (isInteger(jumppage) != true))
	{
		setText('pagejump', '');
		return;
	}
	
	jumppage = parseInt(jumppage, 10);
	if(jumppage < firstpage)
	{
		jumppage = firstpage;
	}
	if(jumppage > lastpage)
	{
		jumppage = lastpage;
	}
	window.location= currentFile + "?" + jumppage;
}

function isNeedReloadPcpMappingList() {
    var PcpmappingItem = GetPcpMappingData();
    var pcpEnable = PcpmappingItem.Enable;
    var reloadnum = sessionStorage.getItem("reloadcount");
    if (pcpEnable == 1 && reloadnum == 1) {
        setTimeout("reloadPcpMappingList()", 5000);
        reloadnum++;
        sessionStorage.setItem("reloadcount", reloadnum);
    } else {
        sessionStorage.removeItem("reloadcount");
    }
}

function LoadFrame()
{
var PcpmappingItem = GetPcpmapping();


	if(IsAdminUser() == true)
	{	
		setDisplay('pcpmapping',1);
		setDisplay('ConfigPanelButtons',1);
	}
	else
	{
		setDisplay('pcpmapping',0);
		setDisplay('ConfigPanelButtons',0);
	}
	if (PcpmappingItem.length >1)
	{
		setSelect("WanNameList",PcpmappingItem[0].Interface);
	}
	
}

function OnPCPCancelButtonClick()
{
	InitPcpTableList();
}

function OnChangeWan()
{
	setText('PcpServer', '');
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<form id="title">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("pcptitle", GetDescFormArrayById(pcpmapping_language, "pcp_bbsp_title"), GetDescFormArrayById(pcpmapping_language, "pcp_bbsp_title_prompt"), false);
</script> 
<div class="title_spread"></div>
</form>

<form id="pcpmapping" style="display:none">
<table id="PcpmappingPanel" class="tabal_bg" width="100%" cellspacing="1" cellpadding="0"> 
<li   id="PcpEnable"       RealType="CheckBox"          DescRef="bbsp_pcp_enable"    RemarkRef="Empty"     ErrorMsgRef="Empty"        Require="FALSE"          BindField="x.Enable"         InitValue="Empty"/>
<li   id="WanNameList"     RealType="DropDownList"          DescRef="bbsp_td_wanname"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"          BindField="x.Interface"      InitValue="Empty" ClickFuncApp="onchange=OnChangeWan"/>
<li   id="PcpServer"       RealType="TextBox"               DescRef="bbsp_pcp_server"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"          BindField="x.ServerAddress"  InitValue="Empty"/>                                                                    
</table>
<script>

var PcpmappingConfigForm = HWGetLiIdListByForm("pcpmapping", null);
	HWParsePageControlByID("pcpmapping", TableClass, pcpmapping_language, null);
	InitPcpTableList();

</script>
<table id="ConfigPanelButtons" style="display:none" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per30'>
        </td>
        <td class="table_submit pad_left30p">
			<input type="hidden" name="hwonttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonPcpApp"  type="button" onclick="javascript:return OnApplyButtonPcpClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(pcpmapping_language['bbsp_pcp_app']);</script></button>
            <button id="ButtonPcpCancel" type="button" onclick="javascript:OnPCPCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(pcpmapping_language['bbsp_pcp_cancel']);</script></button>
        </td>
    </tr>
</table>
</form>
 <div class="func_spread"></div>
 </table> 
    <table width="100%" border="0"  cellpadding="0" cellspacing="0" > 
      <tr > 
        <td class='title_bright1'> 
		  <button id='BtnNew' name="button" class="NewDelbuttoncss" type="button" onClick="AddPcpList();" ><script>document.write(pcpmapping_language['bbsp_pcp_new']);</script></button> 
          <button id='BtnRes' name="cancelValue" class="NewDelbuttoncss" type="button" onClick="DelPcpList();"><script>document.write(pcpmapping_language['bbsp_pcp_res']);</script></button> 
		  </td> 
      </tr> 
  </table>
 <form>
  <div class="func_spread"></div>
 
<script type="text/javascript">
var PcpConfiglistInfo = new Array(new stTableTileInfo("Empty","width_per10","DomainBox"),
                                    new stTableTileInfo("bbsp_pcp_Orign","width_per10","Origin"),
									new stTableTileInfo("bbsp_pcp_ExternalAddress","width_per10","ExternalAddress"),
									new stTableTileInfo("bbsp_ExternalPort","width_per10","ExternalPort"),
									new stTableTileInfo("bbsp_pcp_InternalPort","width_per10","InternalPort"),
									new stTableTileInfo("bbsp_pcp_Protocol","width_per10","Protocol"),
									new stTableTileInfo("bbsp_pcp_InternalAddress","width_per10","InternalAddress"),
									new stTableTileInfo("bbsp_pcp_server_code","width_per10","Status"),
									new stTableTileInfo("bbsp_AllowProposal","width_per10","AllowProposal"),null);

showlistcontrol();

</script>
</form>
  <div id="ConfigForm2"> 
    <table  class="tabCfgArea" cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
		<tr > 
			<td class='width_per40'></td> 
			<td class='title_bright1' >
				<input type="hidden" name="onttoken1" id="hwonttoken1" value="<%HW_WEB_GetToken();%>"> 
				<input name="first" id="first" class="submit" type="button" value="<<" onClick="submitfirst();"/> 
				<input name="prv" id="prv"  class="submit" type="button" value="<" onClick="submitprv();"/> 
					<script>
						if (false == IsValidPage(page))
						{
							page = (0 == MappingInfoNr) ? 0:1;
						}
						document.write(parseInt(page,10) + "/" + lastpage);
					</script>
				<input name="next"  id="next" class="submit" type="button" value=">" onClick="submitnext();"/> 
				<input name="last"  id="last" class="submit" type="button" value=">>" onClick="submitlast();"/> 
			</td>
			<td class='width_per5'></td>
			<td  class='title_bright1'>
				<script> document.write(sroute_language['bbsp_goto']); </script> 
					<input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
				<script> document.write(sroute_language['bbsp_page']); </script>
			</td>
			<td class='title_bright1'>
				<button name="jump"  id="jump" class="submit" type="button" onClick="submitjump();"> <script> document.write(sroute_language['bbsp_jump']); </script></button> 
			</td>
		</tr> 	 
    </table>
	  <script language="JavaScript" type="text/javascript">
	writeTabTail();
	if(page == firstpage)
	{
		setDisable('first',1);
		setDisable('prv',1);
	}
	if(page == lastpage)
	{
		setDisable('next',1);
		setDisable('last',1);
	}	
</script>	
  </div>

<form id="pcpmappinglist" style="display:none">
<div class="func_spread"></div>
<table class="tabal_bg" class="tabCfgArea" border="0" cellpadding="0" cellspacing="1"  width="100%">
<li   id="InternalAddress"               RealType="TextBox"          DescRef="bbsp_pcp_InternalAddress1"            RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"         BindField="x.InternalAddress"            InitValue="Empty"/>
<li   id="InternalPort"                  RealType="TextBox"          DescRef="bbsp_pcp_InternalPort1"               RemarkRef="bbsp_pcp_port"     ErrorMsgRef="Empty"    Require="TRUE"         BindField="x.InternalPort"               InitValue="Empty"/>
<li   id="Protocol"                      RealType="DropDownList"     DescRef="bbsp_protocolmh"                    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"         BindField="x.Protocol"                   InitValue="[{TextRef:'bbsp_none',Value:''}, {TextRef:'TCP',Value:'TCP'},{TextRef:'UDP',Value:'UDP'}]"/>                       
<li   id="RequiredExternalAddress"       RealType="TextBox"          DescRef="bbsp_pcp_RequiredExternalAddress1"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"         BindField="x.RequiredExternalAddress"    InitValue="Empty"/>
<li   id="RequiredExternalPort"          RealType="TextBox"          DescRef="bbsp_RequiredExternalPort1"           RemarkRef="bbsp_pcp_external_port"     ErrorMsgRef="Empty"    Require="FALSE"         BindField="x.RequiredExternalPort"       InitValue="Empty"/>
<li   id="AllowProposal"                 RealType="DropDownList"     DescRef="bbsp_AllowProposal1"                  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"         BindField="x.AllowProposal"              InitValue="[{TextRef:'NO',Value:'0'},{TextRef:'YES',Value:'1'}]"/> 
</table>
<script>
var PcpmappingConfigFormList = HWGetLiIdListByForm("pcpmappinglist");
var formid_hide_id = null;
HWParsePageControlByID("pcpmappinglist", TableClass, pcpmapping_language, formid_hide_id);
</script>
<table id="ConfigPanelButtons1" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per30'>
        </td>
        <td class="table_submit pad_left30p">
			<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApp"  type="button" onclick="javascript:return OnApplyButtonPcpListClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(pcpmapping_language['bbsp_pcp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(pcpmapping_language['bbsp_pcp_cancel']);</script></button>
        </td>
    </tr>
	 <tr> 
      <td class='height10p'></td> 
    </tr> 
</table>

</form>
<script>
  function IsPcpRouteWan(Wan)
  {
      if ((Wan.Mode =="IP_Routed")
	      &&((Wan.ServiceList =="INTERNET")||(Wan.ServiceList =="TR069_INTERNET")||(Wan.ServiceList =="VOIP_INTERNET")||(Wan.ServiceList =="TR069_VOIP_INTERNET")||(Wan.ServiceList =="IPTV_INTERNET")||(Wan.ServiceList =="VOIP_IPTV_INTERNET")||(Wan.ServiceList =="TR069_IPTV_INTERNET")||(Wan.ServiceList =="TR069_VOIP_IPTV_INTERNET"))
		  &&((Wan.ProtocolType =="IPv4") || (Wan.ProtocolType =="IPv4/IPv6") || (Wan.ProtocolType =="IPv6") && (Wan.IPv6DSLite == "Dynamic" || Wan.IPv6DSLite == "Static")))
      {
        return true;
      } 
      return false;
  }
  InitWanNameListControl1("WanNameList", IsPcpRouteWan);
</script>
</body>
</html>
