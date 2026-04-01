<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<title>Device Identification config</title>
<style type="text/css">
</style>
<script language="JavaScript" type="text/javascript">
var OperatorIndex = -1;
var AddFlag = true;
var TableName = "DevIdentificationList";
var OptionCntInGroup = '<%HW_WEB_GetSPEC(OPTION60_BIND_COUNT_IN_GROUP.UINT32);%>';

function stDeviceIndentify(Domain,Type,TypeDesc,VenderClassId)
{
    this.domain = Domain;
	this.Type = Type;
    this.TypeDesc = TypeDesc;
	this.VenderClassId = VenderClassId;

	switch(Type.toUpperCase())
	{
		case "OTHER":
			this.Type = "Other";
			break;

		case "PC":
			this.Type = "PC";
			break;

		case "STB":
			this.Type = "STB";
			break;

		default:
			this.Type = "Other";
			break;
	}
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
		b.innerHTML = deviceidentification_language[b.getAttribute("BindText")];
	}
}

var DeviceIndentifys = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_DeviceIdentification.{i},Type|TypeDesc|VenderClassId,stDeviceIndentify);%>;

var DeviceIndentify = new Array();
for (var i = 0; i < DeviceIndentifys.length-1; i++)
{
    DeviceIndentify[i] = DeviceIndentifys[i];
}

function AddDeviceTypeToList(WanListControlId, devicetype)
{
    var Control = getElById(WanListControlId);
    var Option = document.createElement("Option");
    Option.value = devicetype;
    Option.innerText = devicetype;
    Option.text = devicetype; 
    
    Control.appendChild(Option);
}

function InitDeviceTypeListControl(WanListControlId, devicetype)
{
    $("#bbsp_devicetype").empty();
    AddDeviceTypeToList("bbsp_devicetype", "Other");
    AddDeviceTypeToList("bbsp_devicetype", "PC");
    AddDeviceTypeToList("bbsp_devicetype", "STB");
}

function LoadFrame()
{
    InitDeviceTypeListControl();
   
    loadlanguage();
}

function DevIdentificationListselectRemoveCnt()
{

}

function IsVenderClassVaLid(VenderClassId)
{
    var uiDotCount = 0;
    var i;
    var chDot = '*';
    var uiLength = VenderClassId.length;

    for (i = 0; i < VenderClassId.length; i++)
    {
        if(VenderClassId.charAt(i)==',')
        {
            return false;
        }
        
        if(VenderClassId.charAt(i)==chDot)
        {
            uiDotCount++; 
        }
    }   

    if (uiDotCount > 2)
    {
        return false;
    }

    if (0== uiDotCount)
    {
        return true;
    }

    if ((1 == uiDotCount) 
        && (VenderClassId.charAt(0) != chDot) 
        && (VenderClassId.charAt(uiLength-1) != chDot))
    {
        return false;
    }

    if ((2 == uiDotCount) 
        && ((VenderClassId.charAt(0) != chDot) 
        || (VenderClassId.charAt(uiLength-1) != chDot)))
    {
        return false
    }

    return true;
}

function IsRepeateVenderClass(DeviceIndentifyInfo)
{
    var NewVenderId = DeviceIndentifyInfo.VenderClassId.split(',');
    var OldVenderId;
    var i = 0;
    var j = 0;
    var k = 0;

    for (i = 0; i < NewVenderId.length - 1; i++)
    {   
        for (j = i + 1; j < NewVenderId.length; j++)
        {
            if (NewVenderId[i].toLowerCase() == NewVenderId[j].toLowerCase())
            {
                return true;
            } 
        }
    }
        
    for (k = 0; k < DeviceIndentify.length; k++)
    {
        if (DeviceIndentifyInfo.domain == DeviceIndentify[k].domain)
        {
            continue;
        }
        
        OldVenderId = DeviceIndentify[k].VenderClassId.split(',');        
        for (i = 0; i < NewVenderId.length; i++)
        {
            for (j = 0; j < OldVenderId.length; j++)
            {
                if (NewVenderId[i].toLowerCase() == OldVenderId[j].toLowerCase())
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

function CheckVenderClass(DeviceIndentifyInfo, bAdd)
{
    var TempVenderId = DeviceIndentifyInfo.VenderClassId.split(',');
    var i;

    if (0 == DeviceIndentifyInfo.VenderClassId.length)
    {
        AlertEx(deviceidentification_language['bbsp_proutermsg1']);
        return false;
    }

    if (0 == TempVenderId.length)
    {
        return false;
    }
    else if(OptionCntInGroup < TempVenderId.length)
    {
        if ('' == deviceidentification_language['bbsp_eachvendorfullEnd'])
        {
            AlertEx(deviceidentification_language['bbsp_eachvendorfull']);
        }
        else
        {
            AlertEx(deviceidentification_language['bbsp_eachvendorfull']+OptionCntInGroup+deviceidentification_language['bbsp_eachvendorfullEnd']);
        }
        return false;
    }

    for (i = 0; i < TempVenderId.length; i++)
    {
        if (TempVenderId[i].length == 0)
        {
            AlertEx(deviceidentification_language['bbsp_proutermsg1']);
            return false;
        } 

        if ( (isValidAscii(TempVenderId[i]) != '') || (IsVenderClassVaLid(TempVenderId[i]) == false) )
        {
            AlertEx(deviceidentification_language['bbsp_vendorinvalid']);
            return false;
        }
    		 
    	if(false == isSafeStringExc(TempVenderId[i],'#='))
    	{
    		AlertEx(deviceidentification_language['bbsp_60'] + TempVenderId[i] + deviceidentification_language['bbsp_60invalid']);
    		return false;
    	}  
    }

    if ((true != bAdd) && (DeviceIndentifyInfo.VenderClassId == DeviceIndentify[OperatorIndex].VenderClassId))
    {
        return true;
    }
    
    if (true == IsRepeateVenderClass(DeviceIndentifyInfo))
    {
        AlertEx(deviceidentification_language['bbsp_vendorrepeat']);
        return false;
    }

    return true; 
}

function GetInputDeviceIdentifyInfo()
{
    return new stDeviceIndentify("",getSelectVal("bbsp_devicetype"),getValue("bbsp_devicedes"),getValue("bbsp_vendorclass"));  
}

function OnAddNewDevIdentifySubmit()
{
    var DeviceIndentifyInfo = GetInputDeviceIdentifyInfo();

    if (true != CheckVenderClass(DeviceIndentifyInfo, true))
    {      
        return false;
    }
    
    var Form = new webSubmitForm();
    Form.addParameter('x.Type', DeviceIndentifyInfo.Type);
    Form.addParameter('x.TypeDesc',DeviceIndentifyInfo.TypeDesc);
    Form.addParameter('x.VenderClassId',DeviceIndentifyInfo.VenderClassId);
	Form.addParameter('x.X_HW_Token', getValue('onttoken')); 	
    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.LANDevice.1.X_HW_DeviceIdentification' + '&RequestFile=html/bbsp/deviceidentify/deviceidentification.asp');
    Form.submit();
    DisableRepeatSubmit();
    setDisable('btnApply_ex', 1);
    setDisable('cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}

function OnModifyDevIdentifySubmit()
{
    var DeviceIndentifyInfo = GetInputDeviceIdentifyInfo();
    DeviceIndentifyInfo.domain = DeviceIndentify[OperatorIndex].domain;

    if (true != CheckVenderClass(DeviceIndentifyInfo, false))
    {
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.Type', DeviceIndentifyInfo.Type);
    Form.addParameter('x.TypeDesc',DeviceIndentifyInfo.TypeDesc);
    Form.addParameter('x.VenderClassId',DeviceIndentifyInfo.VenderClassId);
	Form.addParameter('x.X_HW_Token', getValue('onttoken')); 	
    Form.setAction('set.cgi?' +'x='+ DeviceIndentifyInfo.domain + '&RequestFile=html/bbsp/deviceidentify/deviceidentification.asp');
    Form.submit();
    setDisable('btnApply_ex', 1);
    setDisable('cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}

function AddSubmitParam()
{					
    if (true == AddFlag)
    {
        return OnAddNewDevIdentifySubmit();
    }
    else
    {
        return OnModifyDevIdentifySubmit();
    }
}

function setDevIdentifyCtlDisplay(record)
{
    if (record == null)
    {
        setSelect("bbsp_devicetype", 'Other'); 
    	setText('bbsp_devicedes','');
        setText('bbsp_vendorclass','');
    	
    }
    else
    {
        setSelect("bbsp_devicetype", record.Type); 
        setText('bbsp_devicedes',record.TypeDesc);
        setText('bbsp_vendorclass',record.VenderClassId);
    }
}

function DeleteLineRow()
{
	var tableRow = getElementById(TableName);
	
	if ((OperatorIndex == -1) && (tableRow.rows.length > 2))
	{
		tableRow.deleteRow(tableRow.rows.length-1);
	}
	
	return false;
}

function setControl(index)
{
	var record;
	OperatorIndex = index;
	
    if (index == -1)
	{
	    if(DeviceIndentify.length >= 8)
	    {
			DeleteLineRow();
			setDisplay('TableConfigInfo', 0);
			AlertEx(deviceidentification_language['bbsp_maxdeviceidentify']);
		    return;
	    }
	    record = null;
        AddFlag = true;
        setDisplay('TableConfigInfo', 1);
        setDevIdentifyCtlDisplay(record);
	}
    else if (index == -2)
    {
        setDisplay('TableConfigInfo', 0);
    }
	else
	{
	    record = DeviceIndentify[index];
        AddFlag = false;
        setDisplay('TableConfigInfo', 1);
        setDevIdentifyCtlDisplay(record);
	}

    setDisable('btnApply_ex',0);
    setDisable('cancel',0);
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

    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.LANDevice.1.X_HW_DeviceIdentification' + '&RequestFile=html/bbsp/deviceidentify/deviceidentification.asp');
    Form.submit();
    setDisable('btnApply_ex', 1);
    setDisable('cancel', 1);
    setDisable('DeleteButton', 1);
    setDisable('Newbutton', 1);
}  

function Cancel()
{
    getElById('TableConfigInfo').style.display = 'none';
    DeleteLineRow();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("deviceidentify", GetDescFormArrayById(deviceidentification_language, "bbsp_mune"), GetDescFormArrayById(deviceidentification_language, "bbsp_devidentify_title"), false);
</script>
<div class="title_spread"></div>
<script language="JavaScript" type="text/javascript">
	var IdentificationListInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
                                    new stTableTileInfo("bbsp_devtype","align_center","Type"),
									new stTableTileInfo("bbsp_devicescription","align_center","TypeDesc",false,30),
									new stTableTileInfo("bbsp_vendor","align_center","VenderClassId",false,30),
									null);									
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var TableDataInfo = HWcloneObject(DeviceIndentify, 1);
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, IdentificationListInfo, deviceidentification_language, null);
</script>

<form id="TableConfigInfo" style="display:none;"> 
<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
	   	<li  id="bbsp_devicetype"  RealType="DropDownList"   DescRef="bbsp_devtypemh"   RemarkRef="Empty"  ErrorMsgRef="Empty" Require="FALSE"  BindField="x.Type" Elementclass="width_260px restrict_dir_ltr" InitValue="" ClickFuncApp=""/>                                                                   
		<li  id="bbsp_devicedes"  RealType="TextBox"  DescRef="bbsp_devicescriptionmh"  RemarkRef="Empty"  ErrorMsgRef="Empty"  Require="FALSE"     BindField="x.TypeDesc"  Elementclass="width_260px restrict_dir_ltr"   InitValue="Empty" MaxLength="31"/>
		<li  id="bbsp_vendorclass"  RealType="TextBox"  DescRef="bbsp_vendormh" RemarkRef="bbsp_prnote"  ErrorMsgRef="Empty"  Require="TRUE"  BindField="x.VenderClassId"  Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty" MaxLength="255"/>
	</table>
	<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
    var DevIdentificationFormList = new Array();	
	DevIdentificationFormList = HWGetLiIdListByForm("TableConfigInfo", null);
	HWParsePageControlByID("TableConfigInfo", TableClass, deviceidentification_language, null);
	</script>
    <table  cellpadding="0" cellspacing="0" width="100%" class="table_button"> 
       <tr>
	      <td class='width_per25'></td>
            <td class="table_submit">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="AddSubmitParam();"/><script>document.write(deviceidentification_language['bbsp_apply']);</script></button>
                <button id="cancel" name="cancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="Cancel();"/><script>document.write(deviceidentification_language['bbsp_cancle']);</script></button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
