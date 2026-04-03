<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>ARP Age Time</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="Javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javaScript" type="text/javascript">

var OperatorFlag = 0;
var OperatorIndex = -1;
var MaxRouteWan = GetRouteWanMax();
var TableName = "ArpagetimeConfigList";

var WanInfo = GetWanListByFilter(CheckWanOkFunction);
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';

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
		b.innerHTML = arpagetime_language[b.getAttribute("BindText")];
	}
	
	var all = document.getElementsByTagName("span");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = arpagetime_language[b.getAttribute("BindText")];
	}
}

function ArpAgeTimeItem(Domain, Interface, AddressFamily, ArpAgingTime)
{
    this.Domain    = Domain;
    this.Interface = Interface;
	this.AddressFamily  = AddressFamily;
    this.ArpAgingTime   = ArpAgingTime;
}

function TrimArryInfo(WanIPInfoList)
{
    var list = new Array();

    for (var i = 0; i < WanIPInfoList.length-1; i++)
    {
        list[i] = WanIPInfoList[i];
    }
	
    return list;
}

function CheckWanOkFunction(item)
{
    if (viettelflag ==1)
    {
        if (item.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
        {
            return false;
        }
    }    
	if (item.IPv4AddressMode.toUpperCase() == "PPPOE")
	{
		return false;
	}

	if (item.Tr069Flag == "1")
	{
		return false;
	}

	if (item.Mode != "IP_Routed")
	{
		return false;
	}
	
	return true;
}

var ArpAgeTimeList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_NeighborDiscovery.InterfaceSetting.{i}, Interface|AddressFamily|ArpAgingTime, ArpAgeTimeItem);%>;
var itemList = TrimArryInfo(ArpAgeTimeList);

function GetFamilyName(AddressFamily)
{
    if(AddressFamily.toString().toUpperCase() == 'INET6')
	{
		return 'IPv6';	
	}
    else
	{
    	return 'IPv4';
	}
}

function MakeIntfName(path)
{
	if((path.toString().toUpperCase() == "BR0")||(path == "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1"))
	{
		return "LAN";	
	}

	for (var i = 0; i < WanInfo.length; i++)
    {
		var wanname1 = WanInfo[i].NewName;
		var wanname2 = WanInfo[i].domain;
		if((path.toString().toUpperCase() == wanname1.toString().toUpperCase())||(path == wanname2))
		{
			return MakeWanName(WanInfo[i]);
		}
    }

	return path;
}

function MakeIntfPath(path)
{	
	if(path.toString().toUpperCase() == "BR0")
	{
		return "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1";	
	}
	for (var i = 0; i < WanInfo.length; i++)
    {
		var wanname1 = WanInfo[i].NewName;
		if(path.toString().toUpperCase() == wanname1.toString().toUpperCase())
		{
			return WanInfo[i].domain;
		}
    }
	return path;
}

function GetFamilyValue(AddressFamily)
{
    if(AddressFamily.toString().toUpperCase() == 'INET6')
	{
		return 'inet6';	
	}
    else
	{
    	return 'inet';
	}
}


function InitTableData(List)
{
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	var i = 0;
    var RecordCount = List.length;
     
    if (RecordCount == 0)
    {
		TableDataInfo[Listlen] = new ArpAgeTimeItem();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].Interface = '--';
	    TableDataInfo[Listlen].AddressFamily = '--';
		TableDataInfo[Listlen].ArpAgingTime = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, ArpagetimeConfiglistInfo, arpagetime_language, null);
    	return;
    }

    for (i = 0; i < RecordCount; i++)
    {
		TableDataInfo[Listlen] = new ArpAgeTimeItem();
		TableDataInfo[Listlen].domain = List[i].Domain;
		TableDataInfo[Listlen].Interface = MakeIntfName(List[i].Interface);
	    TableDataInfo[Listlen].AddressFamily = GetFamilyName(List[i].AddressFamily);
		TableDataInfo[Listlen].ArpAgingTime = List[i].ArpAgingTime;
		Listlen++;
    }
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, ArpagetimeConfiglistInfo, arpagetime_language, null);
}

function GetCurrentItemInfo()
{
    return new ArpAgeTimeItem("", getSelectVal("WanNameList"), getSelectVal("AddressFamilyList"), getValue("ArpAgeTimeId"));  
}

function SetCurrentItemInfo(Item)
{
	setSelect("WanNameList", MakeIntfPath(Item.Interface));
	setSelect("AddressFamilyList", GetFamilyValue(Item.AddressFamily));
    setText("ArpAgeTimeId", Item.ArpAgingTime);
}

function IsRepeateConfig(checkItem, ignorItem)
{
	try
	{
		if(ignorItem && ((checkItem.Interface == itemList[i].Interface)&&(checkItem.AddressFamily == GetFamilyValue(itemList[i].AddressFamily))))
		{
			return false;
		}
	}
	catch(e)
	{
		return false;
	}
	
	for ( var i = 0; i < itemList.length; i++)
    {
		if((checkItem.Interface == itemList[i].Interface)&&(checkItem.AddressFamily == GetFamilyValue(itemList[i].AddressFamily)))
		{	
			return true;
		}
    }
	
    return false;
}
	
function CheckParaValid(checkItem, ignorItem)
{
	try
	{
		if (checkItem.Interface.length == 0)
		{
		    AlertEx(arpagetime_language['bbsp_msg1']);
		    return false; 
		}

		checkItem.ArpAgingTime = removeSpaceTrim(checkItem.ArpAgingTime);
		if(checkItem.ArpAgingTime!="")
		{
		   if ( false == CheckNumber(checkItem.ArpAgingTime, 5, 1440) )
		   {
			 AlertEx(arpagetime_language['bbsp_msg2']);
			 return false;
		   }
		}
		else
		{
			AlertEx(arpagetime_language['bbsp_msg2']);
			return false;
		}

		if (true == IsRepeateConfig(checkItem, ignorItem))
		{
			AlertEx(arpagetime_language['bbsp_wanexist']);
			return false;
		} 
	}
	catch(e)
	{
		return false;
	}

	return true;
}

function OnNewInstance(index)
{
	if (itemList.length == MaxRouteWan)
	{
		var tableRow = getElementById(TableName);
		tableRow.deleteRow(tableRow.rows.length-1);
		AlertEx(arpagetime_language['bbsp_arppingfull']);	
		return false;
	}
	
	OperatorFlag = 1;
	OperatorIndex = index;	

	var item = new ArpAgeTimeItem("", "", "", "30");
	document.getElementById("TableConfigInfo").style.display = "block";
	SetCurrentItemInfo(item);
}

function ModifyInstance(index)
{
    OperatorFlag = 2;
    OperatorIndex = index;
	    
    document.getElementById("TableConfigInfo").style.display = "block";
    SetCurrentItemInfo(itemList[index]);
}

function OnAddNewSubmit()
{
    var ItemInfo = GetCurrentItemInfo();

	if(false == CheckParaValid(ItemInfo, null))
	{
		return false;	
	}
		
    var Form = new webSubmitForm();
    Form.addParameter('x.Interface',ItemInfo.Interface);
	Form.addParameter('x.AddressFamily',ItemInfo.AddressFamily);
    Form.addParameter('x.ArpAgingTime',ItemInfo.ArpAgingTime);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
    Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_NeighborDiscovery.InterfaceSetting&RequestFile=html/bbsp/arpagetime/arpagetime.asp');
    Form.submit();
    DisableRepeatSubmit();
	return true;
}
 
function OnModifySubmit()
{
    var ItemInfo = GetCurrentItemInfo();

    if(false == CheckParaValid(ItemInfo, itemList[OperatorIndex]))
		return false;	
	
    var Form = new webSubmitForm();
    Form.addParameter('x.Interface',ItemInfo.Interface);
	Form.addParameter('x.AddressFamily',ItemInfo.AddressFamily);
    Form.addParameter('x.ArpAgingTime',ItemInfo.ArpAgingTime);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
    Form.setAction('set.cgi?x=' + itemList[OperatorIndex].Domain + '&RequestFile=html/bbsp/arpagetime/arpagetime.asp');
    Form.submit();
    DisableRepeatSubmit();
    return true;
}

function ArpagetimeConfigListselectRemoveCnt(val)
{

}
 
function OnDeleteButtonClick(TableID)
{
    var CheckBoxList = document.getElementsByName(TableName + 'rml');
    var Count = 0;
    var i;
    for (i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked == true)
        {
            Count++;
        }
    }

    if (Count == 0)
    {
        return false;
    }

    var Form = new webSubmitForm();
    for (i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }

        Form.addParameter(CheckBoxList[i].value,'');
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('del.cgi?x=InternetGatewayDevice.X_HW_NeighborDiscovery.InterfaceSetting&RequestFile=html/bbsp/arpagetime/arpagetime.asp');
    Form.submit();
}

function setControl(index)
{ 
	if (index < -1)
	{
		return;
	}

    if (-1 == index)
    {
        return OnNewInstance(index);
    }
    else
    {
        return ModifyInstance(index);
    }
}

function OnApply()
{
    if (OperatorFlag == 1)
    {
        return OnAddNewSubmit();
    }
    else
    {
        return OnModifySubmit();
    }
}

function OnCancel()
{
    getElById('TableConfigInfo').style.display = 'none';
    if (OperatorIndex == -1)
    {
         var tableRow = getElementById(TableName);
         if (tableRow.rows.length > 2)
			tableRow.deleteRow(tableRow.rows.length-1);
         return false;
     }
}

window.onload = function()
{   
    var OptionBr0 = document.createElement("Option");
	OptionBr0.value = "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1";
	OptionBr0.innerText = "LAN";
	OptionBr0.text = "LAN";
	getElById("WanNameList").appendChild(OptionBr0);

	InitWanNameListControl2("WanNameList", CheckWanOkFunction);

	loadlanguage();
}

function InitAddressFamilyList()
{
	var Optionv4 = document.createElement("Option");
	var Optionv6 = document.createElement("Option");
	Optionv4.value = "inet";
	Optionv4.innerText = "IPv4";
	Optionv4.text = "IPv4";
	getElById("AddressFamilyList").appendChild(Optionv4);
	Optionv6.value = "inet6";
	Optionv6.innerText = "IPv6";
	Optionv6.text = "IPv6";
	getElById("AddressFamilyList").appendChild(Optionv6);
}
</script>
</head>
<body class="mainbody">  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("arpagetimetitle", GetDescFormArrayById(arpagetime_language, "bbsp_mune"), GetDescFormArrayById(arpagetime_language, "bbsp_arpagetime_title"), false);
</script> 
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per15", "width_per85", "ltr");
	var ArpagetimeConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
										new stTableTileInfo("bbsp_wanname","align_center restrict_dir_ltr","Interface"),
										new stTableTileInfo("bbsp_familyname","align_center","AddressFamily"),
										new stTableTileInfo("bbsp_agetime","align_center","ArpAgingTime"),null);
	InitTableData(itemList);
</script>
  
<form id="TableConfigInfo" style="display:none;">
	<div class="list_table_spread"></div> 
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="WanNameList"       RealType="DropDownList"     DescRef="bbsp_wannamemh"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"    Elementclass="width_260px restrict_dir_ltr"    InitValue="Empty"/>
		<li   id="AddressFamilyList" RealType="DropDownList"     DescRef="bbsp_familynamemh"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.AddressFamily" Elementclass="width_260px restrict_dir_ltr"    InitValue="Empty"/>
		<li   id="ArpAgeTimeId"   RealType="TextBox"          DescRef="bbsp_agetimemh"  RemarkRef="bbs_range"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.ArpAgingTime"  Elementclass="width_254px"  InitValue="30"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		var ArpagetimeConfigFormList = new Array();
		ArpagetimeConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
		var formid_hide_id = null;
		HWParsePageControlByID("TableConfigInfo", TableClass, arpagetime_language, formid_hide_id);
		InitAddressFamilyList();
	</script>
    <table width="100%"  cellspacing="1" class="table_button"> 
      <tr> 
        <td class="width_per15"></td> 
        <td class="table_submit pad_left5p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			<button id='Apply' type='button' onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(arpagetime_language['bbsp_app']);</script></button>
          	<button id='Cancel' type='button' onclick="javascript:OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(arpagetime_language['bbsp_cancel']);</script></button> 
		</td> 
      </tr> 
    </table> 
</form> 
</body>
</html>
