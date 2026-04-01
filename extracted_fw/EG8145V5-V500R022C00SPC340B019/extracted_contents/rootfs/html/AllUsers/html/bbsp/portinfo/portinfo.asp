<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Configuration</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>

<style type="text/css">
	.Select
    {
        width:150px;  
    }

    .TextBox
    {
        width:150px;  
    }
	
	.SrcTPIDSelect
	{
		width:15%
	}
</style>
	
<script language="JavaScript" type="text/javascript">
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var SsidNativeVlan ='<%HW_WEB_GetFeatureSupport(BBSP_FT_SSID_NATIVE_VLAN);%>';
function FLOW_CTROL()
{
	this.__tableAction = "none";
	this.__selectIndex = -1;

	function null_function(){}

	this.GetNullItemInfo    = null_function;  
	this.GetItemInfo        = null_function;  
	this.GetInputCfgItem    = null_function; 

	this.setCfgItem         = null_function;
	this.displayCfgItem     = null_function;
	this.disableAddProcess  = null_function;
	this.disableSetProcess  = null_function;
	this.onAddSubmit        = null_function;
	this.onSetSubmit        = null_function;
	this.CheckCurrentItemInfo  = null_function;
	this.CheckRepeatedItemInfo = null_function;
	this.specProcess           = null_function;
	
	this.__isNewInstance = function(index)
	{
		return (-1 == index)?true:false;
	}

	this.__setAction = function(index)
	{
		this.__selectIndex = index;
		this.__tableAction = this.__isNewInstance(index)?"Add":"Set";
	}

	this.__disableAddProcess = function(index, item) 
	{
		this.disableAddProcess(item);
	}
	
	this.__disableSetProcess = function(index, item) 
	{
		this.disableSetProcess(item);
	}

	this.__AddSubmitProcess = function(index, item) 
	{
		if(this.CheckCurrentItemInfo(item) && this.CheckRepeatedItemInfo(item))
		{
			this.onAddSubmit(index, item);
		}
	}

	this.__SetSubmitProcess = function(index, item)
	{
		if(this.CheckCurrentItemInfo(item))
		{
			this.onSetSubmit(index, this.GetItemInfo(index), item);
		}
	}

	this.onClickProcess = function(index) 
	{
		var item = this.__isNewInstance(index)? this.GetNullItemInfo() : this.GetItemInfo(index);
		
		this.__setAction(index);
		this.setCfgItem(item);
		this["__disable" + this.__tableAction + "Process"](index, item);
		this.displayCfgItem(true, item);
		this.specProcess();		
	}
	
	this.onCancelProcess = function()
	{
		var item = this.GetInputCfgItem();
		this.displayCfgItem(false, item);			
		return false;
	}

	this.onSubmitProcess = function()
	{
		var item = this.GetInputCfgItem();
		
		return this["__" + this.__tableAction + "SubmitProcess"](this.__selectIndex, item);
	}
	
	this.onDeleteProcess = function (rmlId, path)
	{
	    var CheckBoxList = document.getElementsByName(rmlId);
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
	    Form.setAction('del.cgi?&RequestFile=' + path);
		
	    Form.submit();
		return true;
	}
}

var flowCtrol = new FLOW_CTROL();
var tableName = "TableDetailContent";
var TableClass;
var ConfigFormList;
var idList = [];
var requestFile = "html/bbsp/portinfo/portinfo.asp";
var isOpticUpMode = '<%HW_WEB_IsOpticUpMode();%>';
var lanUpPort = '5';
var TDIPList = ["0x8100", "0x9100", "0x88a8"];

if (CfgModeWord.toUpperCase() == "LTEIDU") {
    lanUpPort = '';
}

function IsLanUpMode()
{
    if('0' == isOpticUpMode)
	{
	    return true;
	}
	return false;
}

function SetIDAttr(id, disable, display)
{
	for(var i=0;i<idList.length;i++)
	{
		if(idList[i].id == id)
		{
			idList[i].disable = disable;
			idList[i].display = display;
		}
	}
}

var IsoLateValue = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BridgePara.PortIsolateEnable);%>';
var PortInfoArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_BridgePara.Port.{i},PortInterface|QinqEnable|QinqVlan|QinqPri|PvidEnable|PVID|PvidPri|TransparentEnable|TPIDSwitch,PortInfo);%>;
PortInfoArray.pop();			
var itemList = PortInfoArray;

function PortInfo(domain, PortInterface,QinQEnable,QinQVlanID,QinQPri,PVIDEnable,PVIDVlan,PVIDPri,EnableTrans,TPIDSwitch)
{
	this.domain = domain;
	this.PortInterface = PortInterface;
	
	this.QinQEnable=QinQEnable;
	this.QinQVlanID=QinQVlanID;
	this.QinQPriorityPolicy = ("8" == QinQPri)?"CopyFromInnerPriority":"Specified";
	this.QinQPriority = ("8" == QinQPri)?0:QinQPri;
	
	this.PVIDEnable = PVIDEnable;
	this.PVIDVlanID = PVIDVlan;
	this.PVIDPriority = PVIDPri;
	
	this.TransparentEnable = EnableTrans;
	this.TPIDSwitch = TPIDSwitch.toLowerCase();
	this.SrcTPID = "";
	this.DestTPID = "";
	var TPIDInfoList = TPIDSwitch.split("/");
	if(TPIDInfoList.length > 1)
	{
		this.SrcTPID = TPIDInfoList[0];
		this.DestTPID = TPIDInfoList[1];		
	}

    this.PortAttr = (PortInterface.indexOf('WLANConfiguration') >= 0) ? GetWlanNameByDomain(PortInterface) : GetLanNameByDomain(PortInterface);
	this.QinQAttr  = (QinQEnable == '0')?'-/-' : (QinQVlanID + "/" + this.QinQPriority);
    this.PVIDAttr  = (PVIDEnable == '0')?'-/-' : (PVIDVlan + "/" + PVIDPri);
	this.TransAttr = (EnableTrans == '1')?port_info_language['bbsp_port_enable']:port_info_language['bbsp_port_disable'];
	this.TPIDSwitchAttr = (TPIDSwitch == '')?'-/-' : (TPIDSwitch);
}

function GetNullItemInfo()
{
    return new PortInfo("", "", "0", "1", "0", "0","1","0","1","");
}

function GetItemInfo(index)
{
    return itemList[index];
}

function checkVlanID(VlanID,fieldPrompt)
{
	if('' == VlanID)
	{
		return port_info_language[fieldPrompt]+port_info_language['bbsp_port_mustbeinput'];
	}
	if ( VlanID.length > 1 && VlanID.charAt(0) == '0' )
	{
		return port_info_language[fieldPrompt]+port_info_language['bbsp_port_isnumFstchr'];
	}
	if( false == isInteger(VlanID) )
	{
		return port_info_language[fieldPrompt]+port_info_language['bbsp_port_isnum'];
	}
	if ( false == CheckNumber(VlanID,1, 4094) )
	{
		return port_info_language[fieldPrompt]+port_info_language['bbsp_port_vlanrange'];
	}

	return "";
}

function CheckCurrentItemInfo(Item)
{
	if(Item.QinQEnable == '1')
	{
	    var errmsg = checkVlanID(Item.QinQVlanID,"bbsp_port_vlanid"); 
		if("" != errmsg)
		{
			AlertEx(errmsg);
			return false;
		}
	}
	
	if(Item.PVIDEnable == '1')
	{
	    var errmsg = checkVlanID(Item.PVIDVlanID,"bbsp_port_vlanid"); 
		if("" != errmsg)
		{
			AlertEx(errmsg);
			return false;
		}
	}

    if(true != CheckTPIDItemInfo(Item))
    {
        return false;
    }
    
    return  true;
}

function CheckRepeatedItemInfo(item)
{
	for(var i = 0; i < itemList.length; i++)
	{
		if(item.PortInterface == itemList[i].PortInterface)
		{
		    AlertEx(port_info_language['bbsp_port_repeate']);
			return false;
		}
	}
	
    return  true;
}

function CheckTPIDItemInfo(item)
{	
    if (item.SrcTPID == "" && item.DestTPID != "")
    {
	    AlertEx(port_info_language['bbsp_port_tpid_src_error']);
		return false;
	}

    if (item.SrcTPID != "" && item.DestTPID == "")
    {
	    AlertEx(port_info_language['bbsp_port_tpid_dest_error']);
		return false;
	}
	
    return true;
}


function GetCurrentItemInfo()
{
	var srcTPIDInfo = getSelectVal("SrcTPID");
	var destTPIDInfo = getSelectVal("DestTPID");
	var TPIDSwitchInfo = srcTPIDInfo + "/" + destTPIDInfo;
    if(srcTPIDInfo == "" && destTPIDInfo == "")
	{
		TPIDSwitchInfo = "";
	}
	
    return new PortInfo("", getSelectVal("PortInterface"), getCheckVal("QinQEnable"),
	     getValue("QinQVlanID"), 
	     (getRadioVal("QinQPriorityPolicy")=="CopyFromInnerPriority")?"8":getValue("QinQPriority"), 
	     getCheckVal("PVIDEnable"),getValue("PVIDVlanID"),getSelectVal("PVIDPriority"),getCheckVal("TransparentEnable"), TPIDSwitchInfo); 
}

function SetCurrentItemInfo(Item)
{
	for(var i=0;i<idList.length;i++)
	{
		if(idList[i].id == "SrcTPID_select")
		{
            setSelect("SrcTPID", Item.SrcTPID);
			setSelect("DestTPID", Item.DestTPID);		    
		}
		else if(idList[i].type.indexOf("Check") >= 0)
		{
			setCheck(idList[i].id,Item[idList[i].id]);
		}
		else if(idList[i].type.indexOf("Radio") >= 0)
		{
			setRadio(idList[i].id,Item[idList[i].id]);
		}
		else if(idList[i].type.indexOf("Drop") >= 0)
		{
			setSelect(idList[i].id,Item[idList[i].id]);
		}
		else
		{
			setText(idList[i].id,Item[idList[i].id]);
		}
	}
}

function specProcess()
{
	for(var i=0;i<idList.length;i++)
	{
		if(idList[i].hasOwnProperty("display") && (0 ==idList[i].display))
		{
			setDisplay(idList[i].id + "Row", idList[i].display);
		}

		if(idList[i].hasOwnProperty("disable") && (1 ==idList[i].disable))
		{
			setDisable(idList[i].id, idList[i].disable);
		}
	}
}

function specTableProcess()
{
	if(true == IsLanUpMode())
	{		
		for(var i=0; i < itemList.length; i++)
		{
		    var tid = 'TableDetailContent_rml'+ i;
			if(getPortIdByDomainId(getValue(tid).charAt(getValue(tid).length-1)) == lanUpPort)
			{
			    setDisable(tid, 1);
			}		
		}
	}
	
}

function IsDisableConfig(item)
{
    if((true == IsLanUpMode()) && item.PortInterface.charAt(item.PortInterface.length-1) == lanUpPort)
	{
		return true;
	}
	return false;
}

function DisplayCurrentItem(visible, item)
{	
	if(item.QinQEnable == '0')
	{
		setDisplay("QinQVlanID"+ "Row", 0);
		setDisplay("QinQPriorityPolicy"+ "Row", 0);
		setDisplay("QinQPriority"+ "Row", 0);
	}
	else
	{
		setDisplay("QinQVlanID"+ "Row", 1);
		setDisplay("QinQPriorityPolicy"+ "Row", 1);
		setDisplay("QinQPriority"+ "Row", (item.QinQPriorityPolicy != "CopyFromInnerPriority"));
	}
	
	if(item.PVIDEnable == '0')
	{
	    setDisplay("PVIDVlanID"+ "Row", 0);
        setDisplay("PVIDPriority"+ "Row", 0);
	}
	else
	{
	    setDisplay("PVIDVlanID"+ "Row", 1);
        setDisplay("PVIDPriority"+ "Row", 1);
	}

	setDisplay("TableConfigInfo", visible?1:0);
}

function OnChangeUI()
{
	DisplayCurrentItem(true, flowCtrol.GetInputCfgItem());
}

function addProcessDisable(item)
{
	$("#TableConfigInfo :input").each(function(){
		$(this).attr("disabled", false);
	});
	
	setDisable("PortInterface", 0); 
}

function setProcessDisable(item)
{	
	var disble = IsDisableConfig(item);
	
	$("#TableConfigInfo :input").each(function(){
		$(this).attr("disabled", disble);
	});
	
	setDisable("PortInterface", 1);
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
		b.innerHTML = port_info_language[b.getAttribute("BindText")];
	}

    if (CfgModeWord.toUpperCase() == "LTEIDU") {
        setDisplay("divTableIsolateCfg", 0);
        setDisplay("PortIsolateEnableRow", 0);
        setDisplay("QinQEnableRow", 0);
        setDisplay("TransparentEnableRow", 0);
        setDisplay("SrcTPID_selectRow", 0);
    }
}

function onSubmit(index, item, formList, path)
{
	var ParaList  = [];

    ParaList.push(new stSpecParaArray('x.PortInterface',  item.PortInterface));
    if (CfgModeWord.toUpperCase() != "LTEIDU") {
        ParaList.push(new stSpecParaArray('x.QinqEnable',  item.QinQEnable));
        if(item.QinQEnable == '1')
        {
            ParaList.push(new stSpecParaArray('x.QinqVlan', item.QinQVlanID));
            ParaList.push(new stSpecParaArray('x.QinqPri',  (item.QinQPriorityPolicy == "CopyFromInnerPriority")?"8": item.QinQPriority));
        }

        ParaList.push(new stSpecParaArray('x.TransparentEnable', item.TransparentEnable));
	    ParaList.push(new stSpecParaArray('x.TPIDSwitch', item.TPIDSwitch));
    }

    ParaList.push(new stSpecParaArray('x.PvidEnable',  item.PVIDEnable));
	if(item.PVIDEnable == '1')
	{
	    ParaList.push(new stSpecParaArray('x.PVID', item.PVIDVlanID));
	    ParaList.push(new stSpecParaArray('x.PvidPri',  item.PVIDPriority));
	}
	
	var actionPara = new stSetParaInfo(false, formList, ParaList, null, false);

	HWSetAction(null, path, actionPara, getValue('onttoken'));
	
    DisableRepeatSubmit();
	return true;
}
		
function onAddSubmit(index, item)
{
	var path = 'add.cgi?x=InternetGatewayDevice.X_HW_BridgePara.Port&RequestFile=' + requestFile;
	
	return onSubmit(index, item, ConfigFormList, path);
}

function onSetSubmit(index, oldItem, item)
{
	var	 path = 'set.cgi?x=' + oldItem.domain +'&RequestFile=' + requestFile;
	
	return onSubmit(index, item, ConfigFormList, path);
}

function OnApplyButtonClick()
{
	if(flowCtrol.onSubmitProcess)
	{
		return flowCtrol.onSubmitProcess();
	}    
}

function OnCancelButtonClick()
{
	if(flowCtrol.onCancelProcess)
	{
		return flowCtrol.onCancelProcess();
	}	
} 

function TableDetailContentselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{
	if(flowCtrol.onDeleteProcess)
	{
		return flowCtrol.onDeleteProcess(tableName + 'rml', requestFile);
	}
}

function setControl(index)
{ 
	if (index < -1)
	{
		return;
	}

	if(flowCtrol.onClickProcess)
	{
		flowCtrol.onClickProcess(index);
	}
}

function getPortIdByDomainId(index)
{
    for(var i=0; i<itemList.length; i++)
	{
	    if(itemList[i].domain.charAt(itemList[i].domain.length-1) == index)
		{
		    return itemList[i].PortInterface.charAt(itemList[i].PortInterface.length-1)
		}
	}
	return 0;
}

function SubmitPortIsolate()
{	
    var Enable = getElById("PortIsolateEnable").checked;
	var Form = new webSubmitForm();
	if(Enable == true)
	{
		Form.addParameter('x.PortIsolateEnable',1);
	}
	else
	{
		Form.addParameter('x.PortIsolateEnable',0);
	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_BridgePara&RequestFile=' + requestFile);				
	Form.submit();
}

function WriteTPIDSwitchOption()
{
	var srcOutPut = '<option value="" id="SrcTPIDType0"></option>';
    var destOutPut = '<option value="" id="DestTPIDType0"></option>';
	for(var i = 0; i < TDIPList.length; ++i)
	{
	    var index = i + 1;
		srcOutPut += '<option value="' + TDIPList[i] + '" id="SrcTPIDType' + index.toString() + '">' + TDIPList[i] + '</option>';		
		destOutPut += '<option value="' + TDIPList[i] + '" id="DestTPIDType' + index.toString() + '">' + TDIPList[i] + '</option>';		
	}

    $("#SrcTPID").append(srcOutPut);
	$("#DestTPID").append(destOutPut);
}

function InitPortIsolate()
{
    setCheck('PortIsolateEnable',IsoLateValue);
}

function OnPageLoad()
{
	flowCtrol.GetNullItemInfo    = GetNullItemInfo;
	flowCtrol.GetItemInfo        = GetItemInfo;

	flowCtrol.GetInputCfgItem    = GetCurrentItemInfo;
	flowCtrol.setCfgItem         = SetCurrentItemInfo;

	flowCtrol.displayCfgItem     = DisplayCurrentItem;
	flowCtrol.disableAddProcess  = addProcessDisable;
	flowCtrol.disableSetProcess  = setProcessDisable;

	flowCtrol.onAddSubmit        = onAddSubmit;
	flowCtrol.onSetSubmit        = onSetSubmit;

	flowCtrol.CheckCurrentItemInfo  = CheckCurrentItemInfo;
	flowCtrol.CheckRepeatedItemInfo = CheckRepeatedItemInfo;
	flowCtrol.specProcess = specProcess;
	
    specTableProcess();
	InitPortIsolate();
	loadlanguage();
    return true; 
}

</script>
</head>

<body  class="mainbody" onload="OnPageLoad();">
<script language="JavaScript" type="text/javascript">
    var bbsp_port_title = "bbsp_port_title";
    var bbsp_mune_title = "bbsp_mune";
    if (CfgModeWord.toUpperCase() == "LTEIDU") {
        bbsp_port_title = "bbsp_port_title_lteidu";
        bbsp_mune_title = "bbsp_mune_lteidu";
    }
    var HeadSummaryArray = new Array(new stSummaryInfo("text", GetDescFormArrayById(port_info_language, bbsp_port_title)),
                                        new stSummaryInfo("img", "../../../images/icon_01.gif", GetDescFormArrayById(port_info_language, "bbsp_port_title1")),
                                        new stSummaryInfo("text", GetDescFormArrayById(port_info_language, "bbsp_port_title2")),
                                        null);
	HWCreatePageHeadInfo("bbsp_mune", GetDescFormArrayById(port_info_language, bbsp_mune_title), HeadSummaryArray, true);
	document.write('<div class="title_spread"></div>');
</script>

<form id="IsolateCfg" style="display:block;">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="PortIsolateEnable"  RealType="CheckBox"  DescRef="bbsp_port_isolateen"  RemarkRef="Empty"  ErrorMsgRef="Empty"  Require="FALSE"  BindField=""  InitValue="Empty" ClickFuncApp="onclick=SubmitPortIsolate"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
		HWParsePageControlByID("IsolateCfg", TableClass, port_info_language, null);
	</script>
	<div class="func_spread"></div>
</form>

<script language="JavaScript" type="text/javascript">
    if (CfgModeWord.toUpperCase() == "LTEIDU") {
        var ConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
                                    new stTableTileInfo("bbsp_port","align_center","PortAttr"),								
                                    new stTableTileInfo("bbsp_port_pvid","align_center","PVIDAttr"),
                                    null);
    } else {
        var ConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
                                    new stTableTileInfo("bbsp_port","align_center","PortAttr"),								
                                    new stTableTileInfo("bbsp_port_qinq","align_center","QinQAttr"),
                                    new stTableTileInfo("bbsp_port_pvid","align_center","PVIDAttr"),
                                    new stTableTileInfo("bbsp_port_transact","align_center","TransAttr"),
                                    new stTableTileInfo("bbsp_port_tpid_switch","align_center","TPIDSwitchAttr"),
                                    null);
    }
    var ColumnNum = ConfiglistInfo.length - 1;
    var ShowButtonFlag = true;	
    var TableDataInfo =HWcloneObject(itemList, 1);	
    TableDataInfo.push(null);
    HWShowTableListByType(1, tableName, ShowButtonFlag, ColumnNum, TableDataInfo, ConfiglistInfo, port_info_language, null);
</script>

<form id="TableConfigInfo" style="display:none">
  <div class="list_table_spread"></div>
  <div class="list_table_spread"></div>
  <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
  		<li   id="PortInterface"		  RealType="DropDownList"		DescRef="bbsp_port1" 				RemarkRef="Empty" 					ErrorMsgRef="Empty"    Require="FALSE"	  BindField=""    InitValue="Empty"/>
		<li   id="QinQEnable"             RealType="CheckBox"           DescRef="bbsp_port_qinqen"          RemarkRef="Empty"              		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="" ClickFuncApp="onclick=OnChangeUI"/>
		<li   id="QinQVlanID"             RealType="TextBox"            DescRef="bbsp_port_qinqvlan"        RemarkRef="bbsp_vlanremark"    		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty"/>
		<li   id="QinQPriorityPolicy"     RealType="RadioButtonList"    DescRef="bbsp_port_qinqpripolicy"   RemarkRef="Empty"              		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'bbsp_port_prispecified',Value:'Specified'},{TextRef:'bbsp_port_pricopy',Value:'CopyFromInnerPriority'}]" ClickFuncApp="onclick=OnChangeUI"/>
		<li   id="QinQPriority"           RealType="DropDownList"       DescRef="bbsp_port_qinqpri"         RemarkRef="Empty"              		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'Priority0',Value:'0'}, {TextRef:'Priority1',Value:'1'}, {TextRef:'Priority2',Value:'2'}, {TextRef:'Priority3',Value:'3'}, {TextRef:'Priority4',Value:'4'}, {TextRef:'Priority5',Value:'5'}, {TextRef:'Priority6',Value:'6'}, {TextRef:'Priority7',Value:'7'}]"/>
		<li   id="PVIDEnable"             RealType="CheckBox"           DescRef="bbsp_port_pviden"          RemarkRef="Empty"              		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" ClickFuncApp="onclick=OnChangeUI"/>
		<li   id="PVIDVlanID"             RealType="TextBox"            DescRef="bbsp_port_pvidvlan"        RemarkRef="bbsp_vlanremark"    		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty"/>
		<li   id="PVIDPriority"           RealType="DropDownList"       DescRef="bbsp_port_pvidpri"         RemarkRef="Empty"              		ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'Priority0',Value:'0'}, {TextRef:'Priority1',Value:'1'}, {TextRef:'Priority2',Value:'2'}, {TextRef:'Priority3',Value:'3'}, {TextRef:'Priority4',Value:'4'}, {TextRef:'Priority5',Value:'5'}, {TextRef:'Priority6',Value:'6'}, {TextRef:'Priority7',Value:'7'}]"/>
		<li   id="TransparentEnable"      RealType="CheckBox"     		DescRef="bbsp_port_transen"         RemarkRef="Empty"     				ErrorMsgRef="Empty"    Require="FALSE"    BindField="" 	  InitValue=""/> 
		<li   id="SrcTPID_select"         RealType="SmartBoxList"       DescRef="bbsp_port_tpid_switchen"   RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="FALSE"    BindField="" 	  InitValue="[{Type:'span',Item:[{AttrName:'innerhtml', AttrValue:'&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;'}]}, {Type:'select',Item:[{AttrName:'id',AttrValue:'DestTPID'},{AttrName:'style', AttrValue:'width:15%'}]}]" Elementclass="SrcTPIDSelect"/>	
		<script language="JavaScript" type="text/javascript">
			$("#TableConfigInfo li").each(function(i){
				idList.push({id:$(this).attr("id"), type:$(this).attr("RealType")});				
			});

			TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			ConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
			
			HWParsePageControlByID("TableConfigInfo", TableClass, port_info_language, null);

            InitPortList("PortInterface");

            if (CfgModeWord.toUpperCase() == "LTEIDU" || SsidNativeVlan == 1) {
                InitWlanPortList("PortInterface");
            }
			WriteTPIDSwitchOption();
		</script>
  </table>
  
  <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per25'>
        </td>
        <td class="table_submit pad_left5p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(port_info_language['bbsp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(port_info_language['bbsp_cancel']);</script></button>
        </td>
    </tr>
  </table>
</form>
</body>
</html>