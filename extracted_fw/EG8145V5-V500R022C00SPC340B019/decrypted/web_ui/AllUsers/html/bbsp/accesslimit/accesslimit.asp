<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.Selectclass{
	width: 156px;
}
.Inputclass{
	width: 150px;
}
.inputclass1
{
   width:214px;
}
</style>
<title>portal</title>
</head>
<body class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("accesslimittitle", GetDescFormArrayById(accesslimit_language, "bbsp_mune"), GetDescFormArrayById(accesslimit_language, "bbsp_accesslimit_title"), false);
var CfgModeWord = '<%HW_WEB_GetCfgMode();%>';
</script>
<div class="title_spread"></div>

<form id="LimitmodeForm">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<script language="JavaScript" type="text/javascript">
			if (CfgModeWord.toUpperCase() == 'JXCT')
			{
				document.write(" \<li   id=\"LimitMode\"     RealType=\"DropDownList\"          DescRef=\"bbsp_limitmodemh\"         RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"x.Mode\"  Elementclass=\"width_155px\"    InitValue=\"[{TextRef:'bbsp_off',Value:'Off'},{TextRef:'bbsp_globallimit',Value:'GlobalLimit'}]\" ClickFuncApp=\"onchange=OnChangeLimitMode\"\/\> ");
			}
			else
			{
				document.write(" \<li   id=\"LimitMode\"     RealType=\"DropDownList\"          DescRef=\"bbsp_limitmodemh\"         RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"x.Mode\"  Elementclass=\"width_155px\"    InitValue=\"[{TextRef:'bbsp_off',Value:'Off'},{TextRef:'bbsp_globallimit',Value:'GlobalLimit'},{TextRef:'bbsp_typelimit',Value:'TypeLimit'}]\" ClickFuncApp=\"onchange=OnChangeLimitMode\"\/\> ");	
			}
		</script>                                                                
		<li   id="TotalLimit"           RealType="TextBox"          DescRef="bbsp_limitnummh"         RemarkRef="bbsp_LimitNumrange"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.TotalTerminalNumber"  Elementclass="Inputclass"   InitValue="Empty"  Maxlength="3"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		var TableClass = new stTableClass("width_per20", "width_per80", "ltr");
		var LimitmodeFormList = new Array();
		LimitmodeFormList = HWGetLiIdListByForm("LimitmodeForm", null);
		var formid_hide_id = null;
		HWParsePageControlByID("LimitmodeForm", TableClass, accesslimit_language, formid_hide_id);
	</script>
	<table id="OperatorPanel" class="table_button width_per100" cellpadding="0"> 
	  <tr> 
		<td class="table_submit width_per20"></td> 
		<td class="table_submit align_left"> 
			<button id='Apply' type=button onclick = "javascript:return OnApplyGlobal();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(accesslimit_language['bbsp_app']);</script></button>
			<button id='Cancel' type=button onclick = "javascript:return OnCancelGlobal();" class="CancleButtonCss buttonwidth_100px"><script>document.write(accesslimit_language['bbsp_cancel']);</script></button> 
	&nbsp;</td> 
	  </tr> 
	</table> 
</form>
<div class="func_spread"></div>

<script language="javascript">
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
		b.innerHTML = accesslimit_language[b.getAttribute("BindText")];
	}
}


function GetLanguageEnable(Language, Enable)
{
    if (Enable == "1" || Enable == 1)
    {
        return accesslimit_language['bbsp_enable'];
    }
    else
    {
        return accesslimit_language['bbsp_disable'];
    }
}
function BasicInfo(_Domain, _LimitMode, _TotalLimit)
{
	this.Domain = _Domain;
	this.LimitMode = _LimitMode;
	this.TotalLimit = _TotalLimit;
}

function TypeLimitInfo(_Domain, _Enable, _DeviceType, _LimitNum)
{
    this.Domain = _Domain;
    this.Enable = _Enable;
    this.DeviceType = _DeviceType;
    this.LimitNum = _LimitNum;
}

function IsTelmexOpenAccess()
{
    return ((CfgModeWord.toUpperCase() == 'TELMEXVULA') ||
            (CfgModeWord.toUpperCase() == 'TELMEXACCESS') ||
            (CfgModeWord.toUpperCase() == 'TELMEXACCESSNV') ||
            (CfgModeWord.toUpperCase() == 'TELMEXRESALE')) ? true : false;
}

var DeviceList = new Array("Computer", "Phone", "STB", "Camera");
var BasicInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_AccessLimit,Mode|TotalTerminalNumber,BasicInfo);%>;
var TypeLimitInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_AccessLimit.TypeLimit.{i},Enable|VenderClassId|LimitNumber,TypeLimitInfo);%>;
var BasicInfo = BasicInfoList[0];
var TableName = "TableLimitList";
var JXCTflag = 0;
if (CfgModeWord.toUpperCase() == 'JXCT')
{
	if (BasicInfo.LimitMode == 'TypeLimit')
	{
		BasicInfo.LimitMode = 'GlobalLimit';
		var JXCTflag = 1;
	}
}


function OnChangeLimitMode(val)
{
	var LimitMode = val[val.selectedIndex].value;
    setDisplay("TotalLimitRow",0);
    setDisplay("TypeLimitPanel",0);
    
    if (LimitMode == "GlobalLimit")
    {
        setDisplay("TotalLimitRow",1);
    }
}
function ShowConfigPanel(LimitMode)
{
    setDisplay("TotalLimitRow",0);
    setDisplay("TypeLimitPanel",0);
    
    if (LimitMode == "GlobalLimit")
    {
        setDisplay("TotalLimitRow",1);
    }
    if (LimitMode == "TypeLimit")
    {
        setDisplay("TypeLimitPanel",1);
    }
    
}
function UpdateUI(BasicInfo, TypeLimitInfoList)
{
    setSelect("LimitMode", BasicInfo.LimitMode);
    setText("TotalLimit", BasicInfo.TotalLimit);

    ShowConfigPanel(BasicInfo.LimitMode);

    if ((CfgModeWord.toUpperCase() == 'LNCU') ||
        (CfgModeWord.toUpperCase() == 'SCCT_FTTO') ||
        IsTelmexOpenAccess()) {
        setDisable('TotalLimit', 1);
        setDisable('LimitMode', 1);
        setDisable('Apply', 1);
        setDisable('Cancel', 1);
        setDisable('Applys', 1);
        setDisable('Cancels', 1);
        setDisable('DeleteButton', 1);
        setDisable('Newbutton', 1);
        setDisable('EnableTypeLimit', 1);
        setDisable('LimitNum', 1);
    }
}

function InitTableData()
{
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	var i = 0;   
    var RecordCount = TypeLimitInfoList.length - 1;
     
    if (RecordCount == 0)
    {
		TableDataInfo[Listlen] = new TypeLimitInfo();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].Enable = '--';
		TableDataInfo[Listlen].DeviceType = '--';
		TableDataInfo[Listlen].LimitNum = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, AccesslimitConfiglistInfo, accesslimit_language, null);
    	return;
    }

    for (i = 0; i < RecordCount; i++)
    {
		TableDataInfo[Listlen] = new TypeLimitInfo();
		TableDataInfo[Listlen].domain = TypeLimitInfoList[i].Domain;
		TableDataInfo[Listlen].Enable = GetLanguageEnable("Chinese",TypeLimitInfoList[i].Enable);
		if (IsDeviceTypeNormal(TypeLimitInfoList[i].DeviceType) == false)
		{
			TableDataInfo[Listlen].DeviceType = TypeLimitInfoList[i].DeviceType;
		}
		else 
		{
			TableDataInfo[Listlen].DeviceType = accesslimit_language[TypeLimitInfoList[i].DeviceType];
		}
		TableDataInfo[Listlen].LimitNum = TypeLimitInfoList[i].LimitNum;
		Listlen++;
    }
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, AccesslimitConfiglistInfo, accesslimit_language, null);
    for (i = 0;i < RecordCount; i++) {
        if ((CfgModeWord.toUpperCase() == 'LNCU') || IsTelmexOpenAccess()) {
            var id = TableName + "_rml" + i;
            setDisable(id, 1);
        }
    }
}

window.onload = function()
{
    UpdateUI(BasicInfo, TypeLimitInfoList);
    InitControlDataType();
	loadlanguage();
	if (JXCTflag == 1)
	{
		AlertEx(accesslimit_language['bbsp_jxct']);
	}
}


function OnApplyGlobal()
{ 
    var LimitMode = getSelectVal("LimitMode");
    var TotalLimit = getValue("TotalLimit"); 

    if (LimitMode == "GlobalLimit")
    {
				if (isValidAscii(TotalLimit) != '')         
				{  
					AlertEx(accesslimit_language['bbsp_limitnummh1'] + Languages['Hasvalidch'] + isValidAscii(TotalLimit) + accesslimit_language['bbsp_sign']);          
					return false;       
				}
        if(TotalLimit.charAt(0) == '0' && TotalLimit != '0')
        {
            AlertEx(accesslimit_language['bbsp_glimitnuminvalid']);
            return false;
        }
        if (false == CheckNumber(TotalLimit, 0, 253))
        {
        	AlertEx(accesslimit_language['bbsp_totallimitmsg']);
        	return false;
        }
    }
 
    var Form = new webSubmitForm();
    Form.addParameter('x.Mode',LimitMode);
    if (LimitMode == "GlobalLimit")
    {
    	Form.addParameter('x.TotalTerminalNumber',TotalLimit);	
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?' +'x=InternetGatewayDevice.Services.X_HW_AccessLimit' + '&RequestFile=html/bbsp/accesslimit/accesslimit.asp');
	Form.submit();
}

function OnCancelGlobal()
{
    UpdateUI(BasicInfo, TypeLimitInfoList);
}
</script> 
<script language="JavaScript" type="text/javascript">
var OperatorFlag = 0;
var OperatorIndex = 0;

function GetInputTypeLimitInfo()
{
    var TypeEnable = getCheckVal("EnableTypeLimit");
    var DeviceName = getElById("DeviceNameControl").value;
    var LimitNum = getElById("LimitNum").value; 
   
    return new TypeLimitInfo("", TypeEnable, DeviceName, LimitNum);    
}

function CheckValueBeforeApply(TypeLimitInfo)
{
    if (TypeLimitInfo.DeviceType.length == 0)
    {
        AlertEx(accesslimit_language['bbsp_devtypeisreq']);
        return false;	
    }

    if (TypeLimitInfo.LimitNum.length == 0)
    {
        AlertEx(accesslimit_language['bbsp_limitnumisreq']);
        return false;
    }

    if ((TypeLimitInfo.LimitNum.charAt(0) == '0') && (TypeLimitInfo.LimitNum != '0'))
    {
        AlertEx(accesslimit_language['bbsp_limitnuminvalid']);
        return false;
    }
	
	if (isValidAscii(TypeLimitInfo.LimitNum) != '')         
	{  
		AlertEx(accesslimit_language['bbsp_typelimitnum'] + Languages['Hasvalidch'] + isValidAscii(TypeLimitInfo.LimitNum) + accesslimit_language['bbsp_sign']);          
		return false;       
	}
		if (false == CheckNumber(TypeLimitInfo.LimitNum, 0, 253))
		{
			AlertEx(accesslimit_language['bbsp_limitnummsg']);
			return false;	
		}


    return true;

}


function OnNewInstance(index)
{
   OperatorFlag = 1;

   getElById("ChooseDeviceType").disabled = false;
   getElById("LimitNum").value = "";
   setDisable("DeviceNameControl", 0);
   setCheck("EnableTypeLimit", "1");
   InitDeviceTypeComlexControl("Computer");

   document.getElementById("TableConfigInfo").style.display = "block";
}
function OnAddNewSubmit()
{
    var TypeLimitInfoInput = GetInputTypeLimitInfo();

  
    var i;

	if (BasicInfo.LimitMode != "TypeLimit")
	{
	    AlertEx(accesslimit_language['bbsp_selectmode']);
	    return false;
	}

    for (i = 0; i < TypeLimitInfoList.length-1; i++)
    {
        if (TypeLimitInfoList[i].DeviceType == TypeLimitInfoInput.DeviceType)
        {
            AlertEx(getElById("DeviceNameControl").ErrorMsg);
            return false;
        }
    }

    if (false == CheckValueBeforeApply(TypeLimitInfoInput))
    {
        return false;
    }


    var Form = new webSubmitForm();
    Form.addParameter('x.Enable', TypeLimitInfoInput.Enable);
    Form.addParameter('x.VenderClassId',TypeLimitInfoInput.DeviceType);
    Form.addParameter('x.LimitNumber',TypeLimitInfoInput.LimitNum);	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.Services.X_HW_AccessLimit.TypeLimit' + '&RequestFile=html/bbsp/accesslimit/accesslimit.asp');
    Form.submit();
}


function ModifyInstance(index)
{
    OperatorFlag = 2;
    var InstanceId = TypeLimitInfoList[index].Domain;
    var EnableTypeLimit = TypeLimitInfoList[index].Enable;
    var DeviceType = TypeLimitInfoList[index].DeviceType;
    var LimitNum = TypeLimitInfoList[index].LimitNum;

    getElById("DeviceNameControl").disabled = true;
    getElById("ChooseDeviceType").disabled = true;
    getElById("TableConfigInfo").style.display = "block";
    getElById("LimitNum").value = LimitNum;
    setCheck("EnableTypeLimit", EnableTypeLimit);
    InitDeviceTypeComlexControl(DeviceType);

} 
function OnModifySubmit()
{
    var TypeLimitInfoInput = GetInputTypeLimitInfo();

    if (false == CheckValueBeforeApply(TypeLimitInfoInput))
    {
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.Enable',TypeLimitInfoInput.Enable);
    Form.addParameter('x.LimitNumber',TypeLimitInfoInput.LimitNum);	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?' +'x='+ TypeLimitInfoList[OperatorIndex].Domain + '&RequestFile=html/bbsp/accesslimit/accesslimit.asp');
    Form.submit();

}
  
function setControl(index)
{ 
	if (index < -1)
	{
		return;
	}


    OperatorIndex = index;   

    if (-1 == index)
    {
        if (TypeLimitInfoList.length-1 == 4)
        {
	        AlertEx(accesslimit_language['bbsp_devtypefull']);
	        return false;
        }
        return OnNewInstance(index);
    }
    else
    {
        return ModifyInstance(index);
    }
}

function TableLimitListselectRemoveCnt(val)
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
        AlertEx(accesslimit_language['bbsp_selectrecord']);
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
    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.Services.X_HW_AccessLimit.TypeLimit' + '&RequestFile=html/bbsp/accesslimit/accesslimit.asp');
    Form.submit();
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
	getElById('TableConfigInfo').style.display='none';
	getElById('OperatorPanel').style.display = 'block';
	
	var tableRow = getElementById(TableName);
	if ( (OperatorFlag == 1) && (tableRow.rows.length > 2))
	{
		tableRow.deleteRow(tableRow.rows.length-1);
		return false;
	}
}

   function IsDeviceTypeNormal(Value)
   {
        var i;
        
        for (i = 0; i < DeviceList.length; i++)
        {
            if (Value == DeviceList[i])
            {
                return true;
            }
        }
        return false;
   }

   function InitDeviceTypeComlexControl(Value)
   {
        setSelect("ChooseDeviceType", Value);
        setText("DeviceNameControl", Value);
        setDisplay("DeviceNameControl",0);
        if (IsDeviceTypeNormal(Value) == false)
        {   
            if (Value == "Other")
            {
               setText("DeviceNameControl", ""); 
            }
            setSelect("ChooseDeviceType", "Other");
            setDisplay("DeviceNameControl",1);
        }
   }  

   function OnChooseDeviceType(Select)
   {
        InitDeviceTypeComlexControl(getSelectVal(Select.id));
   }

	function InitDeviceType()
	{
		var List = getElementById("ChooseDeviceType");
		List.options.length = 0;
		List.options.add(new Option(accesslimit_language['Computer'],"Computer"));
		List.options.add(new Option(accesslimit_language['Phone'],"Phone"));
		List.options.add(new Option(accesslimit_language['STB'],"STB"));
		List.options.add(new Option(accesslimit_language['Camera'],"Camera"));
		List.options.add(new Option(accesslimit_language['Other'],"Other"));
	}
   </script> 
<div id="TypeLimitPanel" style="display:none;"> 
	<script language="JavaScript" type="text/javascript">
		var AccesslimitConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),									
									new stTableTileInfo("bbsp_enable_status","align_center","Enable"),									
									new stTableTileInfo("bbsp_devtype","align_center","DeviceType",false,45),
									new stTableTileInfo("bbsp_typelimitnum","align_center","LimitNum"),null);	
		UpdateUI(BasicInfo, TypeLimitInfoList);
		InitTableData();
	</script>
 
  <form id="TableConfigInfo" style="display:none"> 
  <div class="list_table_spread"></div>
 	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="EnableTypeLimit"     RealType="CheckBox"         DescRef="bbsp_enabletypelimitmh"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"        InitValue="Empty"/>
		<li id="ChooseDeviceType_select" RealType="SmartBoxList" DescRef="bbsp_devtypemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DeviceTypeName"      Elementclass="Selectclass"  
		InitValue="[{Item:[{AttrName:'id', AttrValue:'DeviceNameControl'},{AttrName:'type', AttrValue:'text'},{AttrName:'class', AttrValue:'inputclass1'},{AttrName:'Maxlength', AttrValue:'255'}]}]" ClickFuncApp="onChange=OnChooseDeviceType"/>
		<li   id="LimitNum"    RealType="TextBox"          DescRef="bbsp_typelimitnummh"       RemarkRef="bbsp_LimitNumrange"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.MACAddress"  Elementclass="Inputclass"    Maxlength="3"   InitValue="Empty"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		var TableClass = new stTableClass("width_per20", "width_per80", "ltr");
		var AccesslimitConfigFormList = new Array();
		AccesslimitConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
		var formid_hide_id = null;
		HWParsePageControlByID("TableConfigInfo", TableClass, accesslimit_language, formid_hide_id);
		InitDeviceType();
		document.getElementById('DeviceNameControl').ErrorMsg = accesslimit_language['bbsp_devnamemsg'];
	</script>
    <table width="100%"  cellspacing="1" class="table_button"> 
      <tr> 
        <td class="width_per20"></td> 
        <td class="table_submit pad_left5p"> 
			 <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			<button id='Applys' type=button onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(accesslimit_language['bbsp_app']);</script></button> 
          	<button id='Cancels' type=button onclick="javascript:OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(accesslimit_language['bbsp_cancel']);</script></button>
		  </td> 
      </tr> 
    </table> 
  </form> 
</div> 
</body>
</html>
