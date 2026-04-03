<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>MAC Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, macfilter_language, portmapping_language);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style type="text/css">
.tabnoline td {
    border:0px;
}
.Select_2 {
    width:133px;
    margin:0px 0px 0px 4px;
}
</style>
<script language="JavaScript" type="text/javascript"> 
var selctIndex = -1;
var numpara = "";
var TableName = "MacfilterConfigList";
var ApAdaptValue = '<%HW_WEB_GetCModeAdaptValue();%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';
var macFilterMax = '<%HW_WEB_GetSPEC(BBSP_SPEC_ETHMACFLTER_MAX.UINT32);%>';
if (macFilterMax == '') {
    macFilterMax = 8;
}

if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
}
var WhiteList = <%HW_WEB_GetFeatureSupport(FT_SSMP_CLOSE_WHITELIST);%>;
var enableFilter = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.MacFilterRight);%>';
var Mode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.MacFilterPolicy);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
var isDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
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
		setObjNoEncodeInnerHtmlValue(b, macfilter_language[b.getAttribute("BindText")]);
	}
}

function stMacFilter(domain, MACAddress, DeviceAlias)
{
    this.domain = domain;
    this.MACAddress = MACAddress;
    if (DeviceAlias == "") {
        this.DeviceAlias = "--";
    } else {
        this.DeviceAlias = DeviceAlias;
    }
}

var MacFilter = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.MacFilter.{i}, SourceMACAddress|DeviceAlias, stMacFilter);%>;
function ShowMacFilter(obj)
{
	if (obj.checked)
	{
		setDisplay('FilterInfo', 1);
	}
	else
	{
		setDisplay('FilterInfo', 0);
	}
}
function APFilterMode()
{
     if ((4 == ApModeValue && ApAdaptValue > 1)
		 ||(4 != ApModeValue && ApModeValue > 1))
	{	
		setSelect('FilterMode',0);
		setDisable("FilterMode",1);
	}
   
}

function removeClick() 
{
   var rml = getElement('rml');
  
   if (rml == null)
   	   return;
 
   var Form = new webSubmitForm();

   var k;	   
   if (rml.length > 0)
   {
      for (k = 0; k < rml.length; k++) 
	  {
         if ( rml[k].checked == true )
         {
			 Form.addParameter(rml[k].value,'');
		 }	
      }
   }  
   else if ( rml.checked == true )
   {
	  Form.addParameter(rml.value,'');
   }
   Form.addParameter('x.X_HW_Token', getValue('onttoken'));	  
   Form.setAction('del.cgi?RequestFile=html/bbsp/macfilter/macfilter.asp');
   Form.submit();
}

function LoadFrame()
{
   if (enableFilter != '' && Mode != '')
   {    
       setDisplay('FilterInfo',1);
       setSelect('FilterMode',Mode);
       if (MacFilter.length - 1 == 0)
       {
           selectLine('record_no');
           setDisplay('TableConfigInfo',0);
       }
       else
       {
           selectLine(TableName + '_record_0');
           setDisplay('TableConfigInfo', 0);
       }
       setDisable('EnableMacFilter',0);
       setDisable('FilterMode',0);
       setDisable('btnApply_ex',0);
       setDisable('cancel',0);
   }
   else
   {
       setDisplay('FilterInfo',0);
   }
   
   if (enableFilter == "1")
   {
       getElById("EnableMacFilter").checked = true;
   }

	if(isValidMacAddress(numpara) == true)
	{
		clickAdd(TableName + '_head');
		setText('SourceMACAddress', numpara);
		getElById("EnableMacFilter").checked = true;
	}
	loadlanguage();
    APFilterMode();
}

function selFilter(filter)
{
   if (filter.checked)
   {   
       FilterInfo.style.display = "";
	   if (enableFilter == 0)
	   {
		   var mode = getElement('FilterMode');
		   mode[0].disabled = true;
		   mode[1].disabled = true;
	   }
   }
   else
   {
	   setDisplay('FilterInfo',0);
   }
   SubmitForm();
   setDisable('EnableMacFilter',1);
}

function ChangeMode()
{
	var MacfilterPolicySpecCfgParaList = new Array();

    var FilterMode = getElById("FilterMode");

    if (FilterMode[0].selected == true)
	{ 
		if (ConfirmEx(macfilter_language['bbsp_macfilterconfirm1']))
		{
			MacfilterPolicySpecCfgParaList.push(new stSpecParaArray("x.MacFilterPolicy", 0, 1));
		}
		else
		{
		    FilterMode[0].selected = false;
			FilterMode[1].selected = true;
			return;
		}
	}
	else if (FilterMode[1].selected == true)
	{ 
		if (ConfirmEx(macfilter_language['bbsp_macfilterconfirm2']))
		{
			MacfilterPolicySpecCfgParaList.push(new stSpecParaArray("x.MacFilterPolicy", 1, 1));
		}
		else
		{
		    FilterMode[0].selected = true;
		    FilterMode[1].selected = false;
			return;
		}
	}
	
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = MacfilterInfoConfigFormList;
	Parameter.SpecParaPair = MacfilterPolicySpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=InternetGatewayDevice.X_HW_Security'
                + '&RequestFile=html/bbsp/macfilter/macfilter.asp';
	HWSetAction(null, url, Parameter, tokenvalue);	
}

function SubmitForm()
{
	var MacfilterRightSpecCfgParaList = new Array();

	var Enable = getElById("EnableMacFilter").checked;
	if (Enable == true)
	{
	   MacfilterRightSpecCfgParaList.push(new stSpecParaArray("x.MacFilterRight", 1, 1));
	}
	else
	{
	   MacfilterRightSpecCfgParaList.push(new stSpecParaArray("x.MacFilterRight", 0, 1));
	}
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = MacfilterInfoConfigFormList;
	Parameter.SpecParaPair = MacfilterRightSpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=InternetGatewayDevice.X_HW_Security'
				+ '&RequestFile=html/bbsp/macfilter/macfilter.asp';
				
	HWSetAction(null, url, Parameter, tokenvalue);	
}

var lanDeviceMacList = new Array();
var lanDeviceNameList = new Array();
var lanDeviceNameSelectList = new Array();

lanDeviceMacList[0] = "";
lanDeviceNameList[0] = "";
lanDeviceNameSelectList[0] = portmapping_language['bbsp_hostName_select'];

function GetUserDevAlias(obj)
{
    if (obj.UserDevAlias != "--") {
        return obj.UserDevAlias;
    } else if (obj.HostName != "--") {
        return obj.HostName;
    } else {
        return obj.MacAddr;
    }
}

function SetLanDeviceNameMac(UserDevices)
{
    var UserDevicesNum = UserDevices.length - 1;

    for (var i = 0, j = 1; i < UserDevicesNum; i++) {
        if (UserDevices[i].PortType.toUpperCase() == "WIFI") {
            continue;
        }
        if (UserDevices[i].HostName != "--") {
            lanDeviceNameList[j] = UserDevices[i].HostName;
            lanDeviceMacList[j] = UserDevices[i].MacAddr;
            lanDeviceNameSelectList[j] = UserDevices[i].MacAddr + '(' + UserDevices[i].HostName + ')';
        } else {
            lanDeviceNameList[j] = UserDevices[i].MacAddr;
            lanDeviceMacList[j] = UserDevices[i].MacAddr;
            lanDeviceNameSelectList[j] = UserDevices[i].MacAddr;
        }

        if (isDevTypeFlag == 1) {
            lanDeviceNameList[j] = GetUserDevAlias(UserDevices[i]);
        }

        j++;
    }
}

function DeviceNameChange()
{
    if (getSelectVal('DeviceNameSelect') == 0) { 
        setText('DeviceName', "");
    } else {
        setText('DeviceName', lanDeviceNameList[getSelectVal('DeviceNameSelect')]);
    }
    setText('SourceMACAddress', lanDeviceMacList[getSelectVal('DeviceNameSelect')]);
}

function CreateDeviceNameSelectinfo()
{
    var output = '';
    for (i = 0; i < lanDeviceNameSelectList.length; i++) {
        output = '<option value="' + i + '" title="' + htmlencode(lanDeviceNameSelectList[i]) + '">' + GetStringContent(htmlencode(lanDeviceNameSelectList[i]), 30) + '</option>';
        $("#DeviceNameSelect").append(output);
    } 
}

function CheckForm()
{   
    var macAddress = getElement('SourceMACAddress').value;
    
	if (macAddress == '') 
    {
		AlertEx(macfilter_language['bbsp_macfilterisreq']);
        return false;
    }
    if (isValidMacAddress(macAddress) == false)
    {
        AlertEx(macfilter_language['bbsp_themac'] + macAddress + macfilter_language['bbsp_macisinvalid']);
        return false;
    }
    for (var i = 0; i < MacFilter.length-1; i++)
    {
        if (selctIndex != i)
        {
            if (macAddress.toUpperCase() == MacFilter[i].MACAddress.toUpperCase())
            {
                AlertEx(macfilter_language['bbsp_themac'] + macAddress + macfilter_language['bbsp_macrepeat']);
                return false;
            }
        }
        else
        {
            continue;
        }
    }
    return true;
}

function AddSubmitParam()
{
	if (false == CheckForm())
	{
		return;
	}
    var MacfilterSpecCfgParaList = new Array(new stSpecParaArray("x.SourceMACAddress", getValue('SourceMACAddress'), 1),
                                             new stSpecParaArray("x.DeviceAlias", getValue('DeviceName'), 1));
	var url = '';
    if( selctIndex == -1 )
	{
		 url = 'add.cgi?x=InternetGatewayDevice.X_HW_Security.MacFilter'
		                        + '&RequestFile=html/bbsp/macfilter/macfilter.asp';
	}
	else
	{
	     url = 'set.cgi?x=' + MacFilter[selctIndex].domain
							+ '&RequestFile=html/bbsp/macfilter/macfilter.asp';
	}
	
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = MacfilterConfigFormList;
	Parameter.SpecParaPair = MacfilterSpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	HWSetAction(null, url, Parameter, tokenvalue);	
	
    setDisable('EnableMacFilter',1);
    setDisable('FilterMode',1);
    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
}

function SubmitEx()
{
    if(isValidMacAddress(numpara) == true)
    {
        var MacFilterInRightValue;
        var Form = new webSubmitForm();
        if (true == getElById("EnableMacFilter").checked)
        {
            MacFilterInRightValue = 1; 
        }
        else
        {
            MacFilterInRightValue = 0;
        }

        $.ajax({
             type : "POST",
             async : false,
             cache : false,
             data : "x.MacFilterRight=" + MacFilterInRightValue +"&x.X_HW_Token="+getValue('onttoken'),
             url : "set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/macfilter/macfilter.asp",
             success : function(data) {
             },
             complete: function (XHR, TS) {
                XHR=null;
             }
        });
    }

    AddSubmitParam();
}

function setCtlDisplay(record)
{
    setText('SourceMACAddress', record.MACAddress);
    if (record.DeviceAlias == "--") {
        setText('DeviceName', "");
    } else {
        setText('DeviceName', record.DeviceAlias);
    }
    setSelect('DeviceNameSelect', '0');
}

function setMacInfo()
{
	if (Mode == 1)
    {   
        setDisplay("MacAlert",1);
        AlertEx(macfilter_language['bbsp_linkmacfilter']);
    }
    else 
    {
        setDisplay("MacAlert",0);
    }
}

function setControl(index)
{   
    var record;
    selctIndex = index;
    if (index == -1)
	{
	    if (MacFilter.length >= macFilterMax + 1) {
            setDisplay('TableConfigInfo', 0);
            AlertEx(macfilter_language['bbsp_macfilterfull']);
            return;
        }
        else
        {
            record = new stMacFilter('', '', '');
            setDisplay('TableConfigInfo', 1);
			setMacInfo();
            setCtlDisplay(record);
        }
	}
    else if (index == -2)
    {
        setDisplay('TableConfigInfo', 0);
    }
	else
	{
	    record = MacFilter[index];
        setDisplay('TableConfigInfo', 1);
        setCtlDisplay(record);
	}
    setDisable('btnApply_ex',0);
    setDisable('cancel',0);
}

function MacfilterConfigListselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{ 
    if ((MacFilter.length-1) == 0)
	{
	    AlertEx(macfilter_language['bbsp_nomacfilter']);
	    return;
	}

	if (selctIndex == -1)
	{
	    AlertEx(macfilter_language['bbsp_savemacfilter']);
	    return;
	}

    var CheckBoxList = document.getElementsByName(TableName+'rml');
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
		AlertEx(macfilter_language['bbsp_selectmacfilter']);
		return;
	}

    if (enableFilter == 1 && Mode == 1)
    {   
        if(ConfirmEx(macfilter_language['bbsp_macfilterconfirm3']))
        {
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.MacFilter' + '&RequestFile=html/bbsp/macfilter/macfilter.asp');
			Form.submit();
			setDisable('DeleteButton',1);
            setDisable('btnApply_ex',1);
            setDisable('cancel',1);
        }
        else
        {
            return;
        }
    }
    else
    {
        if (ConfirmEx(macfilter_language['bbsp_macfilterconfirm4']) == false)
    	{
    	    document.getElementById("DeleteButton").disabled = false;
    	    return;
        }
		
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.MacFilter' + '&RequestFile=html/bbsp/macfilter/macfilter.asp');
		Form.submit();
		setDisable('DeleteButton',1);
        setDisable('btnApply_ex',1);
        setDisable('cancel',1);
    }  
}

function CancelValue()
{   
    if (selctIndex == -1)
    {
        var tableRow = getElement(TableName);

        if (tableRow.rows.length == 1)
        {
        }
        else if (tableRow.rows.length == 2)
        {
		   setDisplay('TableConfigInfo',0);
        }   
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + '_record_0');
        }
    }
    else
    {
        setText('SourceMACAddress', MacFilter[selctIndex].MACAddress);
        setText('DeviceName', MacFilter[selctIndex].DeviceAlias);
    }
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("macfilter", GetDescFormArrayById(macfilter_language, "bbsp_mune"), GetDescFormArrayById(macfilter_language, "bbsp_macfilter_title"), false);
if (true == IsNeedAddSafeDesForBelTelecom())
{
	document.getElementById("macfilter_content").innerHTML = macfilter_language['bbsp_macfilter_title'] + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>";
}
</script>
<div class="title_spread"></div>

<div id="FilterInfo">
<form id="MacFilterCfg" style="display:block;">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="EnableMacFilter"                 RealType="CheckBox"           DescRef="bbsp_enablemacfiltermh"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.MacFilterRight"             InitValue="Empty" ClickFuncApp="onclick=SubmitForm"/>
		<script type="text/javascript">
			if(WhiteList == 1){
				document.write("\<li  id=\"FilterMode\"   RealType=\"DropDownList\"       DescRef=\"bbsp_filtermodemh\"    RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"x.MacFilterPolicy\"   InitValue=\"[{TextRef:\'bbsp_blacklist\',Value:\'0\'}]\"    ClickFuncApp=\"onchange=ChangeMode\" \/\> ");	
			}
			if(WhiteList == 0){
				document.write("\<li  id=\"FilterMode\"   RealType=\"DropDownList\"       DescRef=\"bbsp_filtermodemh\"    RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"x.MacFilterPolicy\"   InitValue=\"[{TextRef:\'bbsp_blacklist\',Value:\'0\'},{TextRef:\'bbsp_whitelist\',Value:\'1\'}]\"    ClickFuncApp=\"onchange=ChangeMode\" \/\> ");					
			}
		</script>
	</table>
	<script>
		var TableClass = new stTableClass("width_per20", "width_per80", "ltr");
		MacfilterInfoConfigFormList = HWGetLiIdListByForm("MacFilterCfg", null);
		HWParsePageControlByID("MacFilterCfg", TableClass, macfilter_language, null);
		getElById("EnableMacFilter").title = macfilter_language['bbsp_macfilternote1'];
        if ((4 == ApModeValue && ApAdaptValue > 1)
		    ||(4 != ApModeValue && ApModeValue > 1))
        {
            getElById("FilterMode").title = macfilter_language['bbsp_macfilterblacknote'];
        }
        else{
		getElById("FilterMode").title = macfilter_language['bbsp_macfilternote2'];
        }        
	</script>
	<div class="func_spread"></div>
</form>

<script language="JavaScript" type="text/javascript">
    var MacfilterConfiglistInfo = new Array(new stTableTileInfo("Empty", "", "DomainBox"),
                                            new stTableTileInfo("bbsp_devicename", "", "DeviceAlias"),
                                            new stTableTileInfo("bbsp_sourcemac", "", "MACAddress"), null);
    var ColumnNum = 3;
    var ShowButtonFlag = true;
    var MacfilterTableConfigInfoList = new Array();
    var TableDataInfo = HWcloneObject(MacFilter, 1);
    HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, MacfilterConfiglistInfo, macfilter_language, null);
</script>

<form id="TableConfigInfo" style="display:none;"> 
<div class="list_table_spread"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%">
        <li id="DeviceName"       RealType="TextOtherBox" DescRef="bbsp_devicenamemh" RemarkRef="Empty"               ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"              MaxLength="64" InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'DeviceNameSelect'},{AttrName:'class',AttrValue:'Select_2 restrict_dir_ltr'}]}]"/>
        <li id="SourceMACAddress" RealType="TextBox"      DescRef="bbsp_sourcemacmh"  RemarkRef="bbsp_macfilternote3" ErrorMsgRef="Empty" Require="TRUE"  BindField="x.SourceMACAddress" MaxLength='17' InitValue="Empty" />
    </table>
	<script language="JavaScript" type="text/javascript">
		MacfilterConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
		HWParsePageControlByID("TableConfigInfo", TableClass, macfilter_language, null);
	</script>
	<div id="MacAlert" style="display:none;"> 
		<table cellpadding="2" cellspacing="0" class="pm_tabal_bg" width="100%"> 
		  <tr> 
			<td class='color_red' BindText='bbsp_rednote'></td> 
		  </tr> 
		</table> 
	 </div>
	 <table cellpadding="0" cellspacing="0" width="100%" class="table_button"> 
          <tr > 
            <td class='width_per20'></td> 
            <td class="table_submit">
			  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
			  <button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="SubmitEx();"><script>document.write(macfilter_language['bbsp_app']);</script></button> 
              <button id='Cancel' name="cancel" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelValue();"><script>document.write(macfilter_language['bbsp_cancel']);</script></button> </td> 
          </tr> 
		  <tr> 
			  <td  style="display:none"> <input type='text'> </td> 
		  </tr>          
	</table> 
</form>
</div>
<script language="JavaScript" type="text/javascript">
GetLanUserDevInfo(function(para) {
    SetLanDeviceNameMac(para);
    CreateDeviceNameSelectinfo();
});
getElById('DeviceNameSelect').onchange = function() {
    DeviceNameChange();
}
</script>
</body>
</html>
