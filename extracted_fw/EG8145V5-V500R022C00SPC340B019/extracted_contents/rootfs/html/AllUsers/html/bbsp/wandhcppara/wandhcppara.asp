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
<title>DHCPCLIENTREQOPTION</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.Inputclass{
	width:160px;
}
</style>
<script language="JavaScript" type="text/javascript">

var appName = navigator.appName;
var DhcpoptionAddFlag = false;
var selctOptionIndex = -1;
var TableName = "DhcpOptionInst";
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
		b.innerHTML = dhcppara_language[b.getAttribute("BindText")];
	}
}

function IsValidDhcpWan(WanItem)
{
    if (viettelflag ==1)
    {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
        {
            return false;
        }
    }    
    if (WanItem.Mode != "IP_Routed")
    {
        return false;
    }

    if (WanItem.EncapMode != "IPoE")
    {
        return false;
    }
    
    if (WanItem.IPv4Enable == "0")
    {
        return false;
    }

    return true;
}

function stWanOptionInfo(domain,Name)
{
	this.domain = domain; 	
	this.name = name;
	this.optionnum = 0;
}

var Wanlist = GetWanListByFilter(IsValidDhcpWan);
var WanOptionInfo = new Array();    
for (var i = 0; i < Wanlist.length; i++)
{
    WanOptionInfo[i] = new stWanOptionInfo("", "");
    WanOptionInfo[i].domain = Wanlist[i].domain;
    WanOptionInfo[i].name = Wanlist[i].Name;
    WanOptionInfo[i].optionnum = 0;
}

function stDhcpClientReqOption(domain,enable,tag,order,value)
{
	this.domain 	      = domain;
	this.enable           = enable;
	this.wanname          = "";
	this.tag              = tag;
	this.order            = order;
	this.value            = value;
	this.show             = 0;
	
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < Wanlist.length; k++ )
	{       
		if (('' == domain) || (undefined == domain))
		    break;
		    
		wandomain_len = Wanlist[k].domain.length;
		temp_domain = domain.substr(0, wandomain_len);
		
		if (temp_domain == Wanlist[k].domain)
		{
			this.wanname = Wanlist[k].Name;
			WanOptionInfo[k].optionnum++;
			this.show = 1;
			break;
		}
	}
	
	if (tag == '0')
	{
	    this.show = 0;
	}
	else
	{
	    this.show = 1;
	}
	
}

var DhcpTotalReqOptions = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.DHCPClient.ReqDHCPOption.{i}, Enable|Tag|Order|Value, stDhcpClientReqOption);%>;

var DhcpClientReqOptionsnum = 0;
var DhcpClientReqOptions = new Array();


for (var i = 0; i < DhcpTotalReqOptions.length - 1; i++)
{
    if (DhcpTotalReqOptions[i].show != 0)
    {
        DhcpClientReqOptions[DhcpClientReqOptionsnum++] = DhcpTotalReqOptions[i];
    }

}

function AddSubmitParam(SubmitForm,type)
{	
    var waninterface = getElement('Waninterface');
    var wannameid = waninterface.options[waninterface.selectedIndex].id;
    var index = wannameid.split('_')[1];
    var url;
 
    SubmitForm.addParameter('x.Enable', '1');  
    SubmitForm.addParameter('x.Tag', getValue('Dhcptag'));
    SubmitForm.addParameter('x.Order', getValue('Dhcporder'));
    SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	
    if(DhcpoptionAddFlag == true)
    {
	url = 'add.cgi?x=' + Wanlist[index].domain + '.DHCPClient.ReqDHCPOption'
						   + '&RequestFile=html/bbsp/wandhcppara/wandhcppara.asp'
    }
    else
    {
	url = 'set.cgi?x=' + DhcpClientReqOptions[selctOptionIndex].domain 
						   + '&RequestFile=html/bbsp/wandhcppara/wandhcppara.asp'
    }

    setDisable('Waninterface',1);
	
    SubmitForm.setAction(url);
}

function CheckForm(type)
{
    with (getElement('ConfigForm')) 
    {
    	var waninterface = getElement('Waninterface');
    	
    	if ( waninterface.selectedIndex < 0 )
        {
	    AlertEx(dhcppara_language['bbsp_dhcp_nowan']);
            return false;
        }

        if (waninterface.options.length == 0)
        {
            AlertEx(dhcppara_language['bbsp_dhcp_nowan']);
	    return false;	
        }
        
    	var wannameid = waninterface.options[waninterface.selectedIndex].id;
    	var wanname = waninterface.options[waninterface.selectedIndex].value;
        var wanindex = wannameid.split('_')[1];
        
        var dhcptag = getValue('Dhcptag');
        var dhcporder = getValue('Dhcporder');
          

        
        if (DhcpoptionAddFlag == true)
        {
	    if (WanOptionInfo[wanindex].optionnum >= 10)
	    {
	        AlertEx(dhcppara_language['bbsp_dhcp_invalid_num']);
                return false;
	    }
	}
	else
	{
	    if (WanOptionInfo[wanindex].optionnum > 10)
	    {
	        AlertEx(dhcppara_language['bbsp_dhcp_invalid_num']);
                return false;
	    }
	}
	
        if (dhcptag == '')
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_reqyuired_tag']);
	    return false;
	}
	else if (dhcptag.charAt(0) == '0')
	{
            AlertEx(dhcppara_language['bbsp_dhcp_invalid_tag']);
	    return false; 
	}
	
	if (isValidAscii(dhcptag) != '')
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_invalid_tag']);
	    return false;     
	}
	
	if (false == CheckNumber(dhcptag, 1, 254))
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_tag_note1']);
	    return false; 
	}
	
	if ((parseInt(dhcptag, 10) == 53) || (parseInt(dhcptag, 10) == 55))
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_tag_note1']);
	    return false; 
	}
        
        for (var i = 0; i < DhcpClientReqOptionsnum; i++)
        {
            if (DhcpoptionAddFlag == false)
            {
                if (i == selctOptionIndex)
                {
                    continue;
                }
            }
            if ((wanname == DhcpClientReqOptions[i].wanname) && (dhcptag == DhcpClientReqOptions[i].tag))
            {
                AlertEx(dhcppara_language['bbsp_dhcp_tag_exist']);
	        return false; 
            }
        }
	
	if (dhcporder == '')
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_reqyuired_order']);
	    return false;
	}
	else if (dhcporder.charAt(0) == '0')
	{
            AlertEx(dhcppara_language['bbsp_dhcp_invalid_order']);
	    return false; 
	}
	
	if (isValidAscii(dhcporder) != '')
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_invalid_order']);
	    return false;     
	}
	
	if (false == CheckNumber(dhcporder, 1, 10))
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_invalid_order']);
	    return false; 
	}	
	
	if (DhcpoptionAddFlag == true)
	{
	    if (false == CheckNumber(dhcporder, 1, WanOptionInfo[wanindex].optionnum + 1))
	    {
	        AlertEx(dhcppara_language['bbsp_dhcp_invalid_order']);
	        return false; 
	    }
	}
	else
	{
	    if (false == CheckNumber(dhcporder, 1, WanOptionInfo[wanindex].optionnum))
	    {
	        AlertEx(dhcppara_language['bbsp_dhcp_invalid_order']);
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
    if (DhcpClientReqOptionsnum == 0)
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

    if ( optionrecord.wanname == '' )
    {
	setText('Dhcptag','');
	setText('DhcpValue','');
	
	setDisable('Waninterface', 0);	
        setDisable('DhcpValue', 1);
        
        var waninterface = getElement('Waninterface');
        
        
        if (selectedWaninterfaceIndex == -1)
        {
            waninterface.selectedIndex = 0;
        }
        else
        {
            waninterface.selectedIndex = selectedWaninterfaceIndex;
        }
        
        if (waninterface.selectedIndex == -1)
        {
            setText('Dhcporder','');
            return;
        }
        
        if (WanOptionInfo[waninterface.selectedIndex].optionnum < 10)
        {
            setText('Dhcporder',WanOptionInfo[waninterface.selectedIndex].optionnum + 1);
        }
        else
        {
            setText('Dhcporder',10);
        }	
    }
    else
    {
       
	setText('Dhcptag',optionrecord.tag);
	setText('Dhcporder',optionrecord.order);
	if (0 == getRadioVal('DhcpMode')) 
	{
	    setText('DhcpValue',optionrecord.value);
	}
	else
	{
	    setText('DhcpValue', ConvertBase64ToHex(optionrecord.value));
	}
	setDisable('Waninterface', 1);
        setDisable('DhcpValue', 1);	
        
        setSelect('Waninterface',optionrecord.wanname);
    }
}

var selectedWaninterfaceIndex = -1;  

function setControl(index)
{
    var optionrecord;

    selctOptionIndex = index;

    if (index == -1)
    {
    	optionrecord = new stDhcpClientReqOption('','','','','');
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
	optionrecord = DhcpClientReqOptions[index];
        setCtlDisplay(optionrecord);
        setDisplay('ConfigForm', 1);
        
        for ( var i = 0; i < Wanlist.length; i++)
        {
            if (optionrecord.wanname == Wanlist[i].Name)
            {
                selectedWaninterfaceIndex = i;
                break;
            }
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
    if (DhcpClientReqOptionsnum == 0)
    {
        AlertEx(dhcppara_language['bbsp_dhcp_nooption']);
        return;
    }

    if (selctOptionIndex == -1)
    {
        AlertEx(dhcppara_language['bbsp_dhcp_nosaveoption']);
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
        AlertEx(dhcppara_language['bbsp_dhcp_selectoption']);
        return ;
    }

    if (ConfirmEx(dhcppara_language['bbsp_dhcp_deloption']) == false)
    {
		document.getElementById("DeleteButton").disabled = false;
		return;
    }
    setDisable('btnApply1', 1);
    setDisable('cancelValue', 1);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/wandhcppara/wandhcppara.asp');   
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
        var optionrecord = DhcpClientReqOptions[selctOptionIndex];
        setCtlDisplay(optionrecord);
    }

}

var CurrrentDhcpMode = 0;  

function ChangeDhcpValueMode()
{
   var dhcpoption = getValue('DhcpValue');
   
   if (CurrrentDhcpMode == getRadioVal('DhcpMode'))
       return;

   if (dhcpoption == '')
   {
       CurrrentDhcpMode = getRadioVal('DhcpMode');
       return;
   }
   
   if (0 == getRadioVal('DhcpMode')) 
   {       
        if (isValidAscii(dhcpoption) != '')
	{
            AlertEx(dhcppara_language['bbsp_dhcp_invalid_value']);
            setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	         
        for (i = 0; i < dhcpoption.length; i++)
        {   
            if (isHexaDigit(dhcpoption.charAt(i)) == false)
            {
		AlertEx(dhcppara_language['bbsp_dhcp_value_note1']);
		setRadio('DhcpMode', CurrrentDhcpMode);
                return false;
            }
        }
  
        var dhcpoption64 = ConvertHexToBase64(dhcpoption);
	if(dhcpoption64.length > 340)
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_value_note3']);
	    setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	
        setText('DhcpValue', dhcpoption64);
   }
   else
   {   
        if (!isValidBase64(dhcpoption))
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_value_note2']);
	    setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	    
	if(dhcpoption.length > 340)
	{
	    AlertEx(dhcppara_language['bbsp_dhcp_value_note3']);
	    setRadio('DhcpMode', CurrrentDhcpMode);
            return false;
	}
	    
       setText('DhcpValue', ConvertBase64ToHex(dhcpoption));
   }
   
   CurrrentDhcpMode = getRadioVal('DhcpMode');
}

function ShowWaninterface()
{

     var waninterface = getElement('Waninterface');
          
     if (DhcpoptionAddFlag)
     {
         if (WanOptionInfo[waninterface.selectedIndex].optionnum < 10)
         {
             setText('Dhcporder',WanOptionInfo[waninterface.selectedIndex].optionnum + 1);
         }
         else
         {
             setText('Dhcporder', 10);
         }
     }
}

function InitTableData()
{
	var ColumnNum = 5;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	
	if (DhcpClientReqOptionsnum == 0)
    {
		TableDataInfo[Listlen] = new stDhcpClientReqOption();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].wanname = '--';
		TableDataInfo[Listlen].tag = '--';
		TableDataInfo[Listlen].order = '--';
		TableDataInfo[Listlen].value = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, DhcpparaConfiglistInfo, dhcppara_language, null);
		return;
    }
    else
    {
        for (var i = 0; i < DhcpClientReqOptionsnum; i++)
        {       
			TableDataInfo[Listlen] = new stDhcpClientReqOption();
			TableDataInfo[Listlen].domain = DhcpClientReqOptions[i].domain;
			TableDataInfo[Listlen].wanname = DhcpClientReqOptions[i].wanname;
			TableDataInfo[Listlen].tag = DhcpClientReqOptions[i].tag;
			TableDataInfo[Listlen].order = DhcpClientReqOptions[i].order;
			TableDataInfo[Listlen].value = DhcpClientReqOptions[i].value;
			Listlen++;
        }
  	 	TableDataInfo.push(null);
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, DhcpparaConfiglistInfo, dhcppara_language, null);
    }
}

function InitWanname()
{
	for (i = 0; i < Wanlist.length; i++)
	{
		 $("#Waninterface").append('<option value=\"' + Wanlist[i].Name + '\" id="wan_'
                        + i + '">'
                        + Wanlist[i].Name + '</option>');
	}
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("wandhcpparatitle", GetDescFormArrayById(dhcppara_language, "bbsp_mune"), GetDescFormArrayById(dhcppara_language, "bbsp_dhcp_req_title"), false);
</script> 
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per25", "width_per75", "restrict_dir_ltr");
	var DhcpparaConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),
										new stTableTileInfo("bbsp_dhcp_wanname","align_center width_per35 restrict_dir_ltr","wanname"),
										new stTableTileInfo("bbsp_dhcp_optionlabel","align_center width_per15","tag"),
										new stTableTileInfo("bbsp_dhcp_reqorder","align_center width_per15","order"),
										new stTableTileInfo("bbsp_dhcp_base64content","align_center width_per30 restrict_dir_ltr","value",false,20),null);
	InitTableData();
</script>

<form id="ConfigForm" style="display:none;"> 
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="Waninterface"      RealType="DropDownList"       DescRef="bbsp_dhcp_wanname1"        RemarkRef="Empty"                 ErrorMsgRef="Empty"    Require="FALSE"    BindField="Waninterface"    Elementclass="width_260px restrict_dir_ltr"   InitValue="Empty"  Maxlength="30"    ClickFuncApp="onChange=ShowWaninterface"/>                                                                   
		<li   id="Dhcptag"           RealType="TextBox"            DescRef="bbsp_dhcp_optionlabel1"    RemarkRef="bbsp_dhcp_tag_note"    ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Tag"           Elementclass="width_50px"    InitValue="Empty"  Maxlength="3"/>
		<li   id="Dhcporder"         RealType="TextBox"            DescRef="bbsp_dhcp_reqorder1"       RemarkRef="bbsp_dhcp_order_note"  ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Order"         Elementclass="width_50px"    InitValue="Empty"  Maxlength="2"/>
		<li   id="DhcpMode"          RealType="RadioButtonList"    DescRef="bbsp_dhcp_optionmode"      RemarkRef="Empty"                 ErrorMsgRef="Empty"    Require="FALSE"    BindField="DhcpMode"        InitValue="[{TextRef:'bbsp_dhcp_hex',Value:'1'},{TextRef:'bbsp_dhcp_base64',Value:'0'}]" ClickFuncApp="onclick=ChangeDhcpValueMode"/>
		<li   id="DhcpValue"         RealType="TextBox"            DescRef="bbsp_dhcp_optioncontent"   RemarkRef="Empty"  ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.Value"         Elementclass="Inputclass restrict_dir_ltr"    InitValue="Empty"  Maxlength="522"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		var DhcpparaConfigFormList = new Array();
		DhcpparaConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
		var formid_hide_id = null;
		HWParsePageControlByID("ConfigForm", TableClass, dhcppara_language, formid_hide_id);
		InitWanname();
		setRadio('DhcpMode',0);
	</script>
  <table width="100%" cellpadding="2" cellspacing="0" class="table_button" id="DhcpReqOptionFormTable2"> 
    <tr> 
      <td class="width_per25"></td> 
      <td class="table_submit">
	  	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	  	<button id="btnApply1" name="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(2);"><script>document.write(dhcppara_language['bbsp_dhcp_app']);</script></button> 
        <button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(dhcppara_language['bbsp_dhcp_cancel']);</script></button> 
	</td> 
    </tr> 
  </table> 
</form> 
<script language="JavaScript" type="text/javascript">
    document.write('</DIV>');
</script> 
</body>
</html>
