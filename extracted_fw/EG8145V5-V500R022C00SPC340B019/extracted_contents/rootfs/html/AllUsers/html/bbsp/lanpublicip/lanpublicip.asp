<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />

<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/lanpublicipdata.asp"></script>    

<style>
	.Select
	{
		width:260px;  
	}
</style>
	
<script>
	var selctIndex = -1;
	var currentFile='lanpublicip.asp';
	var CurrentMode;
	var ClassAIpSupportFlag='<%HW_WEB_GetFeatureSupport(BBSP_FT_SUPPORT_CLASS_A_IP);%>';
	var cfgMode='<%HW_WEB_GetCfgMode();%>'; 
	var TableName = "LanPublicipConfigList";

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
			setObjNoEncodeInnerHtmlValue(b, lanpublicip_language[b.getAttribute("BindText")]);
		}
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
	
    function GetLanPublicIPData()
    {
	    var CurrentDomain = (GetLanPublicIP()[selctIndex] != null)?GetLanPublicIP()[selctIndex].domain:"";
        return new stLanPublicIPClass(CurrentDomain,getCheckVal("Enable"), getValue("IPAddress"),getValue("SubnetMask"));
	 } 

    function OnPageLoad()
    {
	    configEnableSaddress();
		loadlanguage();
        return true;
    }
    
    function CheckParameter(LanPublicIpItem)
    {   
	    var enableslaveaddress = getCheckVal('Enable');
		
		if (enableslaveaddress != 0)
		{
		    if (LanPublicIpItem.IPAddress == '')
			{
				AlertEx(lanpublicip_language['bbsp_ipaddress_none']);
				return false;
			}
			
			if ( isValidIpAddress(LanPublicIpItem.IPAddress) == false )
			{
				 AlertEx(lanpublicip_language['bbsp_ipaddress_invalid']);
				 return false;
			}
			
			if (LanPublicIpItem.SubnetMask == '')
			{
				AlertEx(lanpublicip_language['bbsp_subnetmask_none']);
				return false;
			}
			
			if ( isValidSubnetMask(LanPublicIpItem.SubnetMask) == false )
			{
				 AlertEx(lanpublicip_language['bbsp_subnetmask_invalid']);
				 return false;
			}
			
			if (ClassAIpSupportFlag != 1)
			{
			if ( isMaskOf24BitOrMore(LanPublicIpItem.SubnetMask) == false ) 
			{
				  AlertEx(lanpublicip_language['bbsp_subnetmaskp'] + LanPublicIpItem.SubnetMask + dhcp_language['bbsp_isinvalidp'] +
				          dhcp_language['bbsp_maskerrorinfo']);
				  return false;
				}
			}
		  
			if(isHostIpWithSubnetMask(LanPublicIpItem.IPAddress, LanPublicIpItem.SubnetMask) == false)
			{
				AlertEx(lanpublicip_language['bbsp_ipaddress_invalid']);
				return false;
			}
			if ( isBroadcastIp(LanPublicIpItem.IPAddress, LanPublicIpItem.SubnetMask) == true )
			{
				AlertEx(lanpublicip_language['bbsp_ipaddress_invalid']);
				return false;
			}
		}
		return true;
    }

    function LanPublicipConfigListselectRemoveCnt(val)
    {
    }

    function OnDeleteButtonClick(id) 
    {
        if (GetLanPublicIP().length <= 1) {
            return;
        }
        
        var checkBoxList = document.getElementsByName(TableName + 'rml');
        var form = new webSubmitForm();
        var count = 0;
        for (var i = 0; i < checkBoxList.length; i++) {
            if (checkBoxList[i].checked != true) {
                continue;
            }

            count++;
            form.addParameter(checkBoxList[i].value, '');
        }
        if (count <= 0) {
            return;
        }

        if (ConfirmEx(lanpublicip_language['bbsp_removeconfirm']) == false) {
            document.getElementById("DeleteButton").disabled = false;
            return;
        }
        setDisable('DeleteButton', 1);
        setDisable('ButtonApply', 1);
        setDisable('ButtonCancel',1);
        form.addParameter('x.X_HW_Token', getValue('onttoken'));
        form.setAction('del.cgi?' +'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_PublicIPInterface' + '&RequestFile=html/bbsp/lanpublicip/lanpublicip.asp');
        form.submit();
    }

    function setCtlDisplay(record)
    {
        if (record == null) {
            setCheck("Enable", 0);
            setText('IPAddress', '');
            setText('SubnetMask', '');
        } else {
            setCheck("Enable", record.Enable);
            setText('IPAddress', record.IPAddress);
            setText('SubnetMask', record.SubnetMask);
        }
        configEnableSaddress();
    }

    function DeleteLineRow()
    {
        var tableRow = getElementById(TableName);
        if (tableRow.rows.length > 2)
            tableRow.deleteRow(tableRow.rows.length - 1);
        return false;
    }

    function setControl(Index)
    {
        var record = null;
        selctIndex = Index;
        if (Index < -1) {
            setDisplay('TableConfigInfo', 0);
            return;
        }
        if (Index == -1) {
            if (GetLanPublicIP().length >= 3) {
                DeleteLineRow();
                setDisplay('TableConfigInfo', 0);
                AlertEx(lanpublicip_language['bbsp_lanpublicipfull']);
                return;
            }
            SetAddMode();
            setDisplay('TableConfigInfo', 1);
            setCtlDisplay(record);
        } else {
            SetEditMode();
            setDisplay("TableConfigInfo", "1");
            record = GetLanPublicIP()[Index];
            setCtlDisplay(record);
            return;
        }
    }
  
    function OnApplyButtonClick()
    {
        var LanPublicIpItem = GetLanPublicIPData();

        var Enable = LanPublicIpItem.Enable;
        var IPAddress = LanPublicIpItem.IPAddress;
        var SubnetMask = LanPublicIpItem.SubnetMask;

        if (CheckParameter(LanPublicIpItem) == false) {
            return false;
        }
			

        if (Enable == 0) {
            var SpeclanpublicipCfgParaList = new Array(new stSpecParaArray("x.Enable",Enable, 1));
        } else {
            var SpeclanpublicipCfgParaList = new Array(new stSpecParaArray("x.Enable",Enable, 1),
                                                       new stSpecParaArray("x.IPAddress",IPAddress, 1),
                                                       new stSpecParaArray("x.SubnetMask",SubnetMask, 1));
        }

        var Parameter = {};
        Parameter.asynflag = null;
        Parameter.FormLiList = lanpublicipConfigForm;
        Parameter.SpecParaPair = SpeclanpublicipCfgParaList;
        var url = "";
        if (selctIndex == -1) {
            url = 'add.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_PublicIPInterface' + '&RequestFile=html/bbsp/lanpublicip/lanpublicip.asp';
        } else {
            url = 'set.cgi?x=' + LanPublicIpItem.domain + '&RequestFile=html/bbsp/lanpublicip/lanpublicip.asp';
        }

        var tokenvalue = getValue('onttoken');
        HWSetAction(null, url, Parameter, tokenvalue);

        setDisable('ButtonApply',1);
        setDisable('ButtonCancel',1);
        return;
    }

    function OnCancelButtonClick()
    {
        setDisplay("TableConfigInfo", 0);

        if (IsAddMode()) {
            var tableRow = getElement(TableName);

            if (tableRow.rows.length == 1) {
                selectLine('record_no');
            } else if (tableRow.rows.length == 2) {
            } else {
                tableRow.deleteRow(tableRow.rows.length-1);
                selectLine(TableName + '_record_0');
            }
        } else {
            var record = GetLanPublicIP()[selctIndex];
            setCheck("Enable", record.Enable);
            setText('IPAddress', record.IPAddress);
            setText('SubnetMask', record.SubnetMask);
        }
        setDisable('ButtonApply', 0);
        setDisable('ButtonCancel', 0);
    }
    function OnCancelButtonClickSpec()
    {
        if (GetLanPublicIP().length > 0 && IsAddMode())
        {
			var tableRow = getElementById("lanpublicipConfigList");
            tableRow.deleteRow(tableRow.rows.length-1);
        }
        setDisplay("TableConfigInfo", "0");
        return;
    }
	
	function InitLanPublicIPTableList()
	{
	    var LanPublicIP = new stLanPublicIPClass();
		LanPublicIPData = GetLanPublicIP()[0];
		var FillData = HWcloneObject(LanPublicIPData, 1);
	    HWSetTableByLiIdList(lanpublicipConfigForm, FillData, null);
	}
	
	function configEnableSaddress()
	{
		var enableslaveaddress = getCheckVal('Enable');
		setDisplay('IPAddressRow', enableslaveaddress);
		setDisplay('SubnetMaskRow', enableslaveaddress);
	}
	
	var TableClass = new stTableClass("width_per30", "width_per70", "", "Select");
</script>	
</head>
<body  class="mainbody" onload="OnPageLoad();">
<script language="JavaScript" type="text/javascript">
if (cfgMode == "TRIPLETAP" || cfgMode == "TRIPLETAPNOGM" || cfgMode == "TRIPLETAP6" || cfgMode == "TRIPLETAP6PAIR" || (cfgMode.toUpperCase() == "COCLAROEBG4")) {
	HWCreatePageHeadInfo("lanpubliciptitle", GetDescFormArrayById(lanpublicip_language, "bbsp_mune"), GetDescFormArrayById(lanpublicip_language, "bbsp_title_prompt"), false);
} else {
	HWCreatePageHeadInfo("lanpubliciptitle", GetDescFormArrayById(lanpublicip_language, ""), GetDescFormArrayById(lanpublicip_language, "bbsp_title_prompt"), false);
}
</script>
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
    var LanPublicipConfiglistInfo = new Array(new stTableTileInfo("Empty", "", "DomainBox"),
                                            new stTableTileInfo("bbsp_enabletitle", "", "Enable"),
                                            new stTableTileInfo("bbsp_ipaddresstitle", "", "IPAddress"),
                                            new stTableTileInfo("bbsp_subnetmasktitle", "", "SubnetMask"), null);
    var ColumnNum = 4;
    var ShowButtonFlag = true;
    var LanPublicipTableConfigInfoList = new Array();
    var TableDataInfo = HWcloneObject(LanPublicIPItms, 1);
    for (var i = 0; i < TableDataInfo.length - 1; i++) {
        TableDataInfo[i].Enable = (TableDataInfo[i].Enable == 1) ? lanpublicip_language["bbsp_enabled"] : lanpublicip_language["bbsp_disabled"];
    }
    HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, LanPublicipConfiglistInfo, lanpublicip_language, null);
</script>
<form id="TableConfigInfo" style="display:none;">
<table class="tabal_bg" class="tabCfgArea" border="0" cellpadding="0" cellspacing="1"  width="100%">
<li   id="Enable"                   RealType="CheckBox"           DescRef="bbsp_enable"                    RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="FALSE"          BindField="x.Enable"         InitValue="Empty" ClickFuncApp="onClick=configEnableSaddress"/>
<li   id="IPAddress"                RealType="TextBox"            DescRef="bbsp_ipaddress"                 RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.IPAddress"      InitValue="Empty"   MaxLength="15"/>
<li   id="SubnetMask"               RealType="TextBox"            DescRef="bbsp_subnetmask"                 RemarkRef="Empty"                   ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.SubnetMask"  InitValue="Empty"   MaxLength="15"/>
</table>
<script>

var lanpublicipConfigForm = HWGetLiIdListByForm("TableConfigInfo");
HWParsePageControlByID("TableConfigInfo", TableClass, lanpublicip_language, null);

</script>
<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per30'>
        </td>
        <td class="table_submit">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(lanpublicip_language['bbsp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(lanpublicip_language['bbsp_cancel']);</script></button>
        </td>
    </tr>
</table>
</form>

</body>
</html>