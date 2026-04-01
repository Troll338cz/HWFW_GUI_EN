<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<title>DHCPSERVEROPTION</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>

<script language="JavaScript" type="text/javascript">

var appName = navigator.appName;
var DhcpoptionAddFlag = false;
var selctOptionIndex = 0;
var TableName = "DhcpOptionInst";

var conditionpoolfeature ='<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_COND_POOL);%>';
var gstuseallslvpool ='<%HW_WEB_GetFeatureSupport(FT_GUEST_USE_ALL_SLVPOOL);%>';
var conditionpoolflag = 1;
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
		b.innerHTML = landhcpoption_language[b.getAttribute("BindText")];
	}
}


function stDhcpMainPoolOption(domain,enable,tag,value)
{
	this.domain 	      = domain;
	this.enable           = enable;
	this.tag              = tag;
	this.value            = value;
	this.type            = "MainPool"
	if (tag == '0')
	{
	    this.show = 0;
	}
	else
	{
	    this.show = 1;
	}
}

function stDhcpConditionOption(domain,enable,tag,value)
{
	this.domain 	      = domain;
	this.enable           = enable;
	this.tag              = tag;
	this.value            = value;
	this.type            = "ConditionPool"
	
	if (tag == '0')
	{
	    this.show = 0;
	}
	else
	{
	    this.show = 1;
	}
}

function stDhcpServerOption(domain,enable,tag,value)
{
	this.domain 	      = domain;
	this.enable           = enable;
	this.tag              = tag;
	this.value            = value;
	this.type             = "";	
	this.show             = 0;
	
}
function condhcpst(domain,enable)
{
	this.Domain 	= domain;
	this.enable 	= enable;
}

var DhcpMainPoolOptions = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPOption.{i}, Enable|Tag|Value, stDhcpMainPoolOption);%>;
var DhcpMainPoolOptionsnum = DhcpMainPoolOptions.length - 1;

var ServerOptionInfo = new Array(); 
var idx = 0;
for (var i = 0; i < DhcpMainPoolOptionsnum; i++)
{
    if (DhcpMainPoolOptions[i].show != 0)
    {
        ServerOptionInfo[idx++] = DhcpMainPoolOptions[i];
    }
}

var DhcpConditionOptions = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.DHCPOption.{i}, Enable|Tag|Value, stDhcpConditionOption);%>;
var DhcpConditionOptionsnum = DhcpConditionOptions.length - 1;

if (conditionpoolfeature == 1)
{
    for (var j = 0; j < DhcpConditionOptionsnum; j++)
    {
        if (DhcpConditionOptions[j].show != 0)
        {
            ServerOptionInfo[idx++] = DhcpConditionOptions[j];
        }
    }
}
var DHCPConditionalServerPoolInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i}, Enable, condhcpst);%>;
if (DHCPConditionalServerPoolInfos[0] == null)
{
   conditionpoolflag = 0;
}


function AddSubmitParam(SubmitForm,type)
{	
    var addresspool = getElement('AddressPool');
    var poolname = addresspool.options[addresspool.selectedIndex].value;
    var url;
 
    SubmitForm.addParameter('x.Enable', '1');  
    SubmitForm.addParameter('x.Tag', getValue('Dhcptag'));
	
    var dhcpvalue = getValue('DhcpValue');
    if (1 == getRadioVal('DhcpMode')) 
    {   
	var dhcpvalue64 = ConvertHexToBase64(dhcpvalue); 
        SubmitForm.addParameter('x.Value', dhcpvalue64);
    }
    else
    {
        SubmitForm.addParameter('x.Value', dhcpvalue);
    }
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	
    if(DhcpoptionAddFlag == true)
    {
        if (poolname == "MainPool")
        {
	    url = 'add.cgi?x=' + 'InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPOption'
						   + '&RequestFile=html/bbsp/landhcpoption/landhcpoption.asp';
	}
	else
	{
	    url = 'add.cgi?x=' + 'InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.DHCPOption'
						   + '&RequestFile=html/bbsp/landhcpoption/landhcpoption.asp';
	}

    }
    else
    {
        if (poolname == "MainPool")
        {
	    url = 'set.cgi?x=' + DhcpMainPoolOptions[selctOptionIndex].domain 
						   + '&RequestFile=html/bbsp/landhcpoption/landhcpoption.asp';
	}
	else
	{
	    url = 'set.cgi?x=' + DhcpConditionOptions[selctOptionIndex - DhcpMainPoolOptionsnum].domain 
						   + '&RequestFile=html/bbsp/landhcpoption/landhcpoption.asp';
	}
    }

    setDisable('AddressPool',1);

    SubmitForm.setAction(url);
}


function CheckForm(type)
{
    with (getElement('ConfigForm')) 
    {
    	var addresspool = getElement('AddressPool');
    	var poolname = addresspool.options[addresspool.selectedIndex].value;
    	  
        var dhcptag = getValue('Dhcptag');
        var dhcpvalue = getValue('DhcpValue');
        var dhcpmode = getRadioVal('DhcpMode');
       
        if (addresspool.selectedIndex < 0 )
        {
	    AlertEx(landhcpoption_language['bbsp_dhcp_nopool']);
            return false;
        }

        if (poolname == "MainPool")
	{
	    if (DhcpoptionAddFlag == true)
	    {
	        if (DhcpMainPoolOptionsnum >= 8)
	        {
	            AlertEx(landhcpoption_language['bbsp_dhcp_invalid_num1']);
                    return false;
	        }
	    }
	    else
	    {
	        if (DhcpMainPoolOptionsnum > 8)
	        {
	            AlertEx(landhcpoption_language['bbsp_dhcp_invalid_num1']);
                    return false;
	        }
	    }
	}
	else
	{
	    if (DhcpoptionAddFlag == true)
	    {
	        if (DhcpConditionOptionsnum.optionnum >= 8)
	        {
	            AlertEx(landhcpoption_language['bbsp_dhcp_invalid_num1']);
                    return false;
	        }
	    }
	    else
	    {
	        if (DhcpConditionOptionsnum.optionnum > 8)
	        {
	            AlertEx(landhcpoption_language['bbsp_dhcp_invalid_num1']);
                    return false;
	        }
	    }
	}
	
        if (dhcptag == '')
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_reqyuired_tag']);
	    return false;
	}
	else if (dhcptag.charAt(0) == '0')
	{
            AlertEx(landhcpoption_language['bbsp_dhcp_invalid_tag']);
	    return false; 
	}
	
	if (isValidAscii(dhcptag) != '')
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_invalid_tag']);
	    return false;     
	}
	
	if (false == CheckNumber(dhcptag, 1, 254))
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_tag_note1']);
	    return false; 
	}

	if ((parseInt(dhcptag, 10) == 53) || (parseInt(dhcptag, 10) == 55))
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_tag_note1']);
	    return false; 
	}
	
	if (dhcpvalue== '')
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_required_value']);
	    return false;
	}
		
	
	if (0 == dhcpmode)
	{
	    if (!isValidBase64(dhcpvalue))
	    {
	        AlertEx(landhcpoption_language['bbsp_dhcp_value_note2']);
                return false;
	    }

	    if(dhcpvalue.length > 340)
	    {
	    	AlertEx(landhcpoption_language['bbsp_dhcp_value_note3']);
                return false;
	    }
	}
	else
	{
	    if (isValidAscii(dhcpvalue) != '')
	    {
                AlertEx(landhcpoption_language['bbsp_dhcp_invalid_value']);
		return false;
	    }
	        
	    for (i = 0; i < dhcpvalue.length; i++)
            {   
	        if (!isHexaDigit(dhcpvalue.charAt(i)))
                {
		    AlertEx(landhcpoption_language['bbsp_dhcp_value_note1']);
                    return false;
                }
            }
            
	    var dhcpvalue64 = ConvertHexToBase64(dhcpvalue);
	    if(dhcpvalue64.length > 340)
	    {
	    	AlertEx(landhcpoption_language['bbsp_dhcp_value_note3']);
                return false;
	    }
	}	
    }
    setDisable('btnApply1', 1);
    setDisable('cancelValue', 1);
    return true;
}



function LoadFrame()
{
    if ((DhcpMainPoolOptionsnum + DhcpConditionOptionsnum) == 0)
    {
        selectLine('record_no');
        setDisplay('ConfigForm', 0);
    }
    else
    {
        selectLine(TableName + '_record_0');
        setDisplay('ConfigForm', 1);
    }

    loadlanguage();
}

function setCtlDisplay(optionrecord)
{
    if ( optionrecord.type == '' )
    {
        setDisable('AddressPool', 0);
        var addresspool = getElement('AddressPool');
        if (selectedPoolindex == -1)
        {
            addresspool.selectedIndex = 0;
        }
        else
        {   
            addresspool.selectedIndex = selectedPoolindex;
        }	
	setText('Dhcptag','');
	setText('DhcpValue','');
    }
    else
    {
        setDisable('AddressPool', 1);
	setText('Dhcptag',optionrecord.tag);
	setSelect('AddressPool',optionrecord.type);
	
	if (0 == getRadioVal('DhcpMode')) 
	{
	    setText('DhcpValue',optionrecord.value);
	}
	else
	{
	    setText('DhcpValue', ConvertBase64ToHex(optionrecord.value));
	}
    }
	if(gstuseallslvpool == "1")
	{
		setDisable('AddressPool', 1);
	}
}

var selectedPoolindex = -1; 

function setControl(index)
{
    var optionrecord;

    selctOptionIndex = index;

    if (index == -1)
    {
    	optionrecord = new stDhcpServerOption('','','','','');
    	DhcpoptionAddFlag = true;
        setCtlDisplay(optionrecord);
        setDisplay('ConfigForm', 1);

    }
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
    else
    {
        DhcpoptionAddFlag = false;
	optionrecord = ServerOptionInfo[index];
        setCtlDisplay(optionrecord);
        setDisplay('ConfigForm', 1);
        
        var addresspool = getElement('AddressPool');
        if (addresspool.options[0].value == optionrecord.type)
        {
            selectedPoolindex = 0;
        }
        else
        {
           selectedPoolindex = 1;
        }
    }

    setDisable('btnApply1', 0);
    setDisable('cancelValue', 0);
}

function DhcpOptionInstselectRemoveCnt(val)
{
   
} 

function OnDeleteButtonClick(TableID)
{
    if (ServerOptionInfo.length == 0)
    {
        AlertEx(landhcpoption_language['bbsp_dhcp_nooption']);
        return;
    }

    if (selctOptionIndex == -1)
    {
        AlertEx(landhcpoption_language['bbsp_dhcp_nosaveoption']);
		return;
    }
    
    var rml = document.getElementsByName(TableName + 'rml');
    var SubmitForm = new webSubmitForm();	 
	var Count = 0;
	for (var i = 0; i < rml.length; i++)
	{
		if (rml[i].checked != true)
		{
			continue;
		}
		
		Count++;
		SubmitForm.addParameter(rml[i].value,'');
	}
    if (Count <= 0)
    {
        AlertEx(landhcpoption_language['bbsp_dhcp_selectoption']);
        return ;
    }

    if (ConfirmEx(landhcpoption_language['bbsp_dhcp_deloption']) == false)
    {
		document.getElementById("DeleteButton").disabled = false;
		return;
    }
    setDisable('btnApply1', 1);
    setDisable('cancelValue', 1);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/landhcpoption/landhcpoption.asp');   
	SubmitForm.submit();
}

function CancelConfig()
{
    setDisplay("ConfigForm", 0);
	
	if (selctOptionIndex == -1)
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
            selectLine(TableName + '_record_0');
        }
    }
    else
    {
        var optionrecord = ServerOptionInfo[selctOptionIndex];
        setCtlDisplay(optionrecord);
    }

}

var CurrrentDhcpMode = 0; 

function ChangeDhcpValueMode()
{
   
   if (CurrrentDhcpMode == getRadioVal('DhcpMode'))
       return;
       
   var dhcpoption = getValue('DhcpValue');
   if (dhcpoption == '')
   {
       CurrrentDhcpMode = getRadioVal('DhcpMode');
       return;
   }
   
   if (0 == getRadioVal('DhcpMode')) 
   {     
        
        if (isValidAscii(dhcpoption) != '')
	{
            AlertEx(landhcpoption_language['bbsp_dhcp_invalid_value']);
            setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	    
        for (i = 0; i < dhcpoption.length; i++)
        {   
            if (isHexaDigit(dhcpoption.charAt(i)) == false)
            {
		AlertEx(landhcpoption_language['bbsp_dhcp_value_note1']);
		setRadio('DhcpMode', CurrrentDhcpMode);
                return false;
            }
        }
        
        var dhcpoption64 = ConvertHexToBase64(dhcpoption);
	if(dhcpoption64.length > 340)
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_value_note3']);
	    setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	
        setText('DhcpValue', dhcpoption64);
   }
   else
   {   
        if (!isValidBase64(dhcpoption))
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_value_note2']);
	    setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	    
	if(dhcpoption.length > 340)
	{
	    AlertEx(landhcpoption_language['bbsp_dhcp_value_note3']);
	    setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	    
       setText('DhcpValue', ConvertBase64ToHex(dhcpoption));
   }
   
   CurrrentDhcpMode = getRadioVal('DhcpMode');
   
}

function InitTableData()
{
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	
	if (ServerOptionInfo.length == 0)
    {
		TableDataInfo[Listlen] = new stDhcpServerOption();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].tag = '--';
		TableDataInfo[Listlen].value = '--';
		TableDataInfo[Listlen].type = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, LandhcpoptionConfiglistInfo, landhcpoption_language, null);
		return;
    }
    else
    {
        for (var i = 0; i < ServerOptionInfo.length; i++)
        {
			if (ServerOptionInfo[i].tag == '0')
				continue;
             
			TableDataInfo[Listlen] = new stDhcpServerOption();
			TableDataInfo[Listlen].domain = ServerOptionInfo[i].domain;  
			TableDataInfo[Listlen].tag = ServerOptionInfo[i].tag;
			TableDataInfo[Listlen].value = ServerOptionInfo[i].value;
        	if (ServerOptionInfo[i].type == "MainPool")
        	{
				TableDataInfo[Listlen].type = landhcpoption_language['bbsp_dhcp_mainpool'];
        	}
        	else
        	{
				TableDataInfo[Listlen].type = landhcpoption_language['bbsp_dhcp_conditionpool'];
        	}
			Listlen++;
        }
		TableDataInfo.push(null);
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, LandhcpoptionConfiglistInfo, landhcpoption_language, null);
    }
}

function InitAddressPool()
{
	$("#AddressPool").append('<option value=' + 'MainPool' + ' id="Pool_0' + '">' + landhcpoption_language['bbsp_dhcp_mainpool'] + '</option>');
	if (conditionpoolfeature == 1 && conditionpoolflag == 1)
	{
		$("#AddressPool").append('<option value=' + 'ConditionPool' + ' id="Pool_1' + '">' + landhcpoption_language['bbsp_dhcp_conditionpool'] + '</option>');
	}
}
</script> 

</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("landhcpoptiontitle", GetDescFormArrayById(landhcpoption_language, "bbsp_mune"), GetDescFormArrayById(landhcpoption_language, ""), false);
	if (conditionpoolfeature == 1 && gstuseallslvpool != "1")
	{
	  document.getElementById("landhcpoptiontitle_content").innerHTML = landhcpoption_language['bbsp_dhcp_service_title'] + landhcpoption_language['bbsp_dhcp_service_title_ex'];
	}
	else
	{
	  document.getElementById("landhcpoptiontitle_content").innerHTML = landhcpoption_language['bbsp_dhcp_service_title'];
	}
</script>
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per25", "width_per75", "restrict_dir_ltr");
	var LandhcpoptionConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),										
										new stTableTileInfo("bbsp_dhcp_optionlabel","align_center width_per15","tag"),
										new stTableTileInfo("bbsp_dhcp_base64content","align_center width_per45 restrict_dir_ltr","value",false,35),
										new stTableTileInfo("bbsp_dhcp_appto","align_center width_per35","type"),null);
	InitTableData();
</script>

<form id="ConfigForm" style="display:none"> 
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="Dhcptag"           RealType="TextBox"            DescRef="bbsp_dhcp_optionlabel1"    RemarkRef="bbsp_dhcp_tag_note"    ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Tag"           Elementclass="width_50px"    InitValue="Empty"  Maxlength="3"/>
		<li   id="DhcpMode"          RealType="RadioButtonList"    DescRef="bbsp_dhcp_optionmode"      RemarkRef="Empty"                 ErrorMsgRef="Empty"    Require="FALSE"    BindField="DhcpMode"        InitValue="[{TextRef:'bbsp_dhcp_hex',Value:'1'},{TextRef:'bbsp_dhcp_base64',Value:'0'}]" ClickFuncApp="onclick=ChangeDhcpValueMode"/>
		<li   id="DhcpValue"         RealType="TextBox"            DescRef="bbsp_dhcp_optioncontent"   RemarkRef="bbsp_dhcp_value_note"  ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.Value"         Elementclass="width_254px restrict_dir_ltr"    InitValue="Empty"  Maxlength="522"/>
		<li   id="AddressPool"       RealType="DropDownList"       DescRef="bbsp_dhcp_appto1"          RemarkRef="Empty"                 ErrorMsgRef="Empty"    Require="FALSE"    BindField="AddressPool"     Elementclass="width_260px"   InitValue="Empty"  Maxlength="30"/>                                                                   

	</table>
	<script language="JavaScript" type="text/javascript">
		var LanhcpoptionConfigFormList = new Array();
		LanhcpoptionConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
		var formid_hide_id = null;
		HWParsePageControlByID("ConfigForm", TableClass, landhcpoption_language, formid_hide_id);
		InitAddressPool();
		setRadio('DhcpMode',0);
	</script>
	<table width="100%" cellpadding="2" cellspacing="0" class="table_button" id="DhcpServerOptionFormTable2"> 
		<tr> 
		  <td class="width_per25"></td> 
		  <td class="table_submit">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
			<button id="btnApply1" name="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(2);"><script>document.write(landhcpoption_language['bbsp_dhcp_app']);</script></button> 
			<button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(landhcpoption_language['bbsp_dhcp_cancel']);</script></button> 
		  </td> 
		</tr> 
	</table> 
</form> 
<script language="JavaScript" type="text/javascript">
    document.write('</DIV>');
</script> 
</body>
</html>
