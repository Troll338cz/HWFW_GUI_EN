<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>Chinese -- MAC Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, wlanmacfil_language, portmapping_language);%>"></script>
<script language="Javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style type="text/css">
.tabnoline td
{
   border:0px;
}
#MacFilterSet {
    cursor: pointer;
    width: 50px;
    height: 27px;
    overflow: hidden;
    background-repeat: no-repeat;
}

.Select_2 {
    width:133px;
    margin:0px 0px 0px 4px;
}
</style>
<script language="JavaScript" type="text/javascript"> 
var selctIndex = -1;
var numpara = "";
var portid  = "";
var TableName = "WMacfilterConfigList";
var SSIDnum = 8;
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';  
var ProductType = '<%HW_WEB_GetProductType();%>';  

var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var ApAdaptValue = '<%HW_WEB_GetCModeAdaptValue();%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';

var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';

var isNewAp = "<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>";

var NosFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NOS2WIFI);%>';
var isDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';

var wlanName = GetSSIDList();

if (CfgModeWord.toUpperCase() == 'CHINA4') {
    isNewAp = 0;
}

function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
}
	
function IsFreInSsidName()
{
	if(1 == IsPTVDFFlag)
	{
		return true;
	}
}
if( window.location.href.indexOf("?") > 0)
{
    numpara = window.location.href.split("?")[1]; 
    portid  = window.location.href.split("?")[2];
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
		b.innerHTML = wlanmacfil_language[b.getAttribute("BindText")];
	}
}

var enableFilter = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.WlanMacFilterRight);%>';
var Mode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.WlanMacFilterPolicy);%>';

function stSsidBandInfo(domain, SSIDReference, X_HW_RFBand)
{
   this.domain = domain;
   this.SSIDReference = SSIDReference;
   this.X_HW_RFBand = X_HW_RFBand;
}

var SSIDBandList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, SSIDReference|X_HW_RFBand, stSsidBandInfo);%>;

function stMacFilter(domain, SSIDName, DeviceName, MACAddress) {
   this.domain = domain;   
   this.SSIDName = SSIDName;
   this.DeviceName = DeviceName;
   this.MACAddress = MACAddress; 
}

var MacFilterSrc = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GeWlanMacFilter, InternetGatewayDevice.X_HW_Security.WLANMacFilter.{i}, SSIDName|DeviceName|SourceMACAddress, stMacFilter);%>;
var MacFilter = new Array();
for (var i = 0; i < MacFilterSrc.length-1; i++)
{
	var SSIDIndex = MacFilterSrc[i].SSIDName.charAt(MacFilterSrc[i].SSIDName.length - 1);
    if (CfgModeWord.toUpperCase() == "EGVDF2") {
        MacFilter.push(MacFilterSrc[i]);
    } else {
        if(IsVisibleSSID('SSID' + SSIDIndex) == true)
            MacFilter.push(MacFilterSrc[i]);
    }

}
MacFilter.push(null);

function stAthName(domain,Name,Enable)
{
	this.domain = domain;
	this.Name   = Name;
	this.Enable = Enable;
}

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
   Form.setAction('del.cgi?RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp');
   Form.submit();
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
function LoadFrame()
{
	if(isNewAp == 1)
	{
		setDisplay("EnableMacFilter",0);
		var htmlDiv='<div id=\"MacFilterSet\" MacFilterSetFlag=\"0\" style=\"background-image: url(../../../images/equls-left.jpg);\"></div>';
		$("#EnableMacFilterCol").prepend(htmlDiv);
		
		$("#MacFilterSet").click(function(){
			if($(this).attr("MacFilterSetFlag") == "1"){
				getElById("EnableMacFilter").checked = false;		
			}else{
				getElById("EnableMacFilter").checked = true;
			}
			SubmitForm();
		});
	}
	
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
           setDisplay('TableConfigInfo',1);
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
	   if(isNewAp == 1)
	   {
		  OpenSet();	
	   }	   
   }

	if(isValidMacAddress(numpara) == true)
	{
		clickAdd(TableName + '_head');
		setSelect('ssidindex', 'SSID-' + portid.charAt(portid.length - 1));        
		setText('SourceMACAddress', numpara);
		getElById("EnableMacFilter").checked = true;
		if(isNewAp == 1)
		{
		  OpenSet();	
		}
	}

	loadlanguage();
    APFilterMode();
    
    InitWifiDeviceName();
}

var wifiDeviceMacArray = new Array();
var wifiDeviceNameArray = new Array();

wifiDeviceMacArray[0] = "";
wifiDeviceNameArray[0] = portmapping_language['bbsp_hostName_select'];

function GetUserDevAlias(obj) {
    if (obj.UserDevAlias != "--") {
        return obj.MacAddr + '(' + obj.UserDevAlias + ')';
    } else if (obj.HostName != "--") {
        return obj.MacAddr + '(' + obj.HostName + ')';
    } else {
        return obj.MacAddr;
    }
}

function SetWiFiDeviceNameArray(userDevices) {
    var userDevicesnum = userDevices.length - 1;

    for (var i = 0, j = 1; i < userDevicesnum; i++) {
        if ((userDevices[i].PortType.toUpperCase() != "WIFI") || 
            ((userDevices[i].PortType.toUpperCase() == "WIFI") && (userDevices[i].DevStatus == "Offline"))) {
            continue;
        }

        if (userDevices[i].HostName != "--") {
            wifiDeviceNameArray[j] = userDevices[i].MacAddr + '(' + userDevices[i].HostName + ')';
            wifiDeviceMacArray[j] = userDevices[i].MacAddr;
        } else {
            wifiDeviceNameArray[j] = userDevices[i].MacAddr;
            wifiDeviceMacArray[j] = userDevices[i].MacAddr;
        }

        if (isDevTypeFlag == 1) {
            wifiDeviceNameArray[j] = GetUserDevAlias(userDevices[i]);
        }

        j++;
    }
}

function InitSelDeviceNameOptions() {
    var output = '';
    for (var i = 0; i < wifiDeviceNameArray.length; i++) {
        output = '<option value="' + i + '" title="' + htmlencode(wifiDeviceNameArray[i]) + '">' + GetStringContent(htmlencode(wifiDeviceNameArray[i]), 32) + '</option>';
        $("#SelDeviceName").append(output);
    }
}

function SelDeviceNameChange() {
    var deviceNameText = wifiDeviceNameArray[getSelectVal('SelDeviceName')];
    var sourceMACAddressText = wifiDeviceMacArray[getSelectVal('SelDeviceName')];

    if (getSelectVal('SelDeviceName') == 0) {
        deviceNameText = '';
        sourceMACAddressText = '';
    } else {
        if (deviceNameText.length > sourceMACAddressText.length) {
            deviceNameText = deviceNameText.substring(sourceMACAddressText.length + 1, deviceNameText.length - 1);
        }
    }

    setText('DeviceName', deviceNameText);
    setText('SourceMACAddress', sourceMACAddressText);
}

function InitWifiDeviceName() {
    GetLanUserDevInfo(function(para) {
        SetWiFiDeviceNameArray(para);
        InitSelDeviceNameOptions();
    });

    getElById('SelDeviceName').onchange = function() {
        SelDeviceNameChange();
    }
}

function OpenSet(){
	$("#MacFilterSet").css("background-image","url(../../../images/equls-right.gif)");
    $("#MacFilterSet").attr("MacFilterSetFlag","1");
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
   if(isNewAp == 1)
   {
	   $("#MacFilterSet").unbind("click");
   }  
}

function ChangeMode()
{
	var WMacfilterPolicySpecCfgParaList = new Array();
    var FilterMode = getElById("FilterMode");

    if (FilterMode[0].selected == true)
	{ 
		if (ConfirmEx(wlanmacfil_language['bbsp_macfilterconfirm1']))
		{
			WMacfilterPolicySpecCfgParaList.push(new stSpecParaArray("x.WlanMacFilterPolicy", 0, 1));
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
		if (ConfirmEx(wlanmacfil_language['bbsp_macfilterconfirm2']))
		{
			WMacfilterPolicySpecCfgParaList.push(new stSpecParaArray("x.WlanMacFilterPolicy", 1, 1));
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
	Parameter.FormLiList = WMacfilterInfoConfigFormList;
	Parameter.SpecParaPair = WMacfilterPolicySpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=InternetGatewayDevice.X_HW_Security'
                + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp';
	HWSetAction(null, url, Parameter, tokenvalue);	
}

function SubmitForm()
{
	var WMacfilterRightSpecCfgParaList = new Array();
	var Enable = getElById("EnableMacFilter").checked;
	if (Enable == true)
	{
	   WMacfilterRightSpecCfgParaList.push(new stSpecParaArray("x.WlanMacFilterRight", 1, 1));
	}
	else
	{
	   WMacfilterRightSpecCfgParaList.push(new stSpecParaArray("x.WlanMacFilterRight", 0, 1));
	}
    var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = WMacfilterInfoConfigFormList;
	Parameter.SpecParaPair = WMacfilterRightSpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=InternetGatewayDevice.X_HW_Security'
				+ '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp';
				
	HWSetAction(null, url, Parameter, tokenvalue);	
}

function CheckSSIDEnable(SSIDName)
{
	return GetSSIDStatusByName('SSID' + SSIDName.charAt(SSIDName.length - 1));
}

function GetInstIDNameBySSIDName(SSIDName)
{
	var SSIDDomain = GetSSIDDomainByName('SSID' + SSIDName.charAt(SSIDName.length - 1));
	return getWlanInstFromDomain(SSIDDomain);
}

function getSSIDBand (ssidName)
{
    var ssidBand = 0;
    var List = ssidName.split("-");
    if (List.length == 0) {
        return ssidBand;
    }
    var ssidInstance = List[List.length - 1];
    for (var i = 0; i < SSIDBandList.length - 1; i++) {
        var ssidList = SSIDBandList[i].SSIDReference.split(".");
        if (ssidList.length == 0) {
            continue;
        }

        if (ssidList[ssidList.length - 1] == ssidInstance) {
            ssidBand = SSIDBandList[i].X_HW_RFBand;
            break;
        }
    }

    return ssidBand;
}

function CheckForm()
{
    var SSIDName = getValue('ssidindex');
    var macAddress = getElement('SourceMACAddress').value;
    var num=0;

    if (macAddress == '') {
        AlertEx(wlanmacfil_language['bbsp_macfilterisreq']);
        return false;
    }

    if (isValidMacAddress1(macAddress) == false) {
        AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + wlanmacfil_language['bbsp_macisinvalid']);
        return false;
    }
    
    if (fttrFlag == 1) {
      var setBand = getSSIDBand(SSIDName);
      if (setBand == 0) {
          return false;
      }
   }

	for (var i = 0; i < MacFilter.length-1; i++)
    {
        if (selctIndex != i)
        {
            if ((macAddress.toUpperCase() == MacFilter[i].MACAddress.toUpperCase()) && (SSIDName == MacFilter[i].SSIDName))
            {
                AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + wlanmacfil_language['bbsp_macrepeat']);
                return false;
            }

            if (fttrFlag == 1) {
                var currentBand = getSSIDBand(MacFilter[i].SSIDName);
                if (currentBand == 0) {
                    continue;
                }

                if (setBand == currentBand) {
                    num++;
                }
            } else if (SSIDName == MacFilter[i].SSIDName) {
               num++;
            }
        }
        else
        {
            continue;
        }
	}

    if (fttrFlag == 1) {
        SSIDnum = '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_MACFILTER_RADIO_NUM.UINT32);%>';
    } else if (NosFlag == 1) {
        SSIDnum = '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_STA_NUM.UINT32);%>';
    }

    if (num >= parseInt(SSIDnum)) {

        if (fttrFlag == 1) {
            AlertEx(wlanmacfil_language['bbsp_rulenum_left'] + SSIDnum + wlanmacfil_language['bbsp_rulenum_right']);
        } else if (NosFlag == 1) {
            AlertEx(wlanmacfil_language['bbsp_rulenum4']);
        } else {
            AlertEx(wlanmacfil_language['bbsp_rulenum']);
        }
        return false;
    }

    return true;
}

function AddSubmitParam()
{
	if (false == CheckForm())
	{
		return;
	}

    var enable = getElById("EnableMacFilter").checked;
    var EnableMacFilter = (enable == true) ? 1 : 0;
    var WMacfilterSpecCfgParaList = new Array(new stSpecParaArray("x.SourceMACAddress",getValue('SourceMACAddress'), 1),
                                            new stSpecParaArray("x.SSIDName",getValue('ssidindex'), 1),
                                            new stSpecParaArray("x.DeviceName",getValue('DeviceName'), 1),
                                            new stSpecParaArray("x.Enable",1, 1));


    var url = '';
    if( selctIndex == -1 )
	{
		 url = 'add.cgi?x=InternetGatewayDevice.X_HW_Security.WLANMacFilter'
		                        + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp';
	}
	else
	{
	     url = 'set.cgi?x=' + MacFilter[selctIndex].domain
							+ '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp';
	}
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = WMacfilterConfigFormList;
	Parameter.SpecParaPair = WMacfilterSpecCfgParaList;
	var tokenvalue = getValue('onttoken');
	HWSetAction(null, url, Parameter, tokenvalue);	
	
    setDisable('EnableMacFilter',1);
    setDisable('FilterMode',1);
    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
	if(isNewAp == 1)
	{
	   $("#MacFilterSet").unbind("click");
	} 
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
             data : "x.WlanMacFilterRight=" + MacFilterInRightValue +"&x.X_HW_Token="+getValue('onttoken'),
             url : "set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp",
             success : function(data) {
             },
             complete: function (XHR, TS) {
                XHR=null;
             }
        });
    }

    AddSubmitParam();
}

function setCtlDisplay(record) {
    if (record == null) {
        setText('SourceMACAddress','');
        setText('DeviceName', '');
    } else {
        var ssid = getElementById('ssidindex');
        ssid.value = record.SSIDName;
        setText('SourceMACAddress', record.MACAddress);
        setText('DeviceName', record.DeviceName);
    }
}

function setMacInfo()
{
	if (Mode == 1)
    {   
        setDisplay("MacAlert",1);
        AlertEx(wlanmacfil_language['bbsp_rednote']);
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
        var SSIDNumber = (TopoInfo.SSIDNum == 0)?4:TopoInfo.SSIDNum;
        if (MacFilter.length >= (SSIDNumber*SSIDnum)+1)
        {
            setDisplay('TableConfigInfo', 0);
			if(DoubleFreqFlag == 1)
			{
            	AlertEx(wlanmacfil_language['bbsp_rulenum2']);
			}
			else
			{
				AlertEx(wlanmacfil_language['bbsp_rulenum1']);
			}
            return;
        }
        else
        {
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

function WMacfilterConfigListselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{ 
    if ((MacFilter.length-1) == 0)
	{
	    AlertEx(wlanmacfil_language['bbsp_nonerulealert']);
	    return;
	}

	if (selctIndex == -1)
	{
	    AlertEx(wlanmacfil_language['bbsp_saverulealert']);
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
		AlertEx(wlanmacfil_language['bbsp_chooserulealert']);
		return;
	}

    if (enableFilter == 1 && Mode == 1)
    {   
        if(ConfirmEx(wlanmacfil_language['bbsp_whitealert']))
        {
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.WLANMacFilter' + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp');
			Form.submit();
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
        if (ConfirmEx(wlanmacfil_language['bbsp_deletealert']) == false)
    	{
			document.getElementById("DeleteButton").disabled = false;
			return;
        }
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.WLANMacFilter' + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilter.asp');
		Form.submit();
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
    } else {
        var record = MacFilter[selctIndex];
        setCtlDisplay(record);
    }
}

function ChangeSSID()
{

}

function GetInstIdByName(instID) {
    for (var i = 0; i < wlanName.length; i++) {
        var nameId = wlanName[i].name.charAt(wlanName[i].name.length - 1);
        if (instID == nameId) {
            return i;
        }
    }
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("wlanmacfilter", GetDescFormArrayById(wlanmacfil_language, "bbsp_mune"), GetDescFormArrayById(wlanmacfil_language, "bbsp_wlanmac_title"), false);
if (true == IsNeedAddSafeDesForBelTelecom())
{
	document.getElementById("wlanmacfilter_content").innerHTML = wlanmacfil_language['bbsp_wlanmac_title'] + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>";
}

</script> 
<div class="title_spread"></div>

<div id="FilterInfo">
<form id="MacFilterCfg" style="display:block;">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="EnableMacFilter"                 RealType="CheckBox"           DescRef="bbsp_filterenable"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.WlanMacFilterRight"             InitValue="Empty" ClickFuncApp="onclick=SubmitForm"/>
		<li   id="FilterMode"                RealType="DropDownList"       DescRef="bbsp_filterpolicy"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.WlanMacFilterPolicy"         InitValue="[{TextRef:'bbsp_blacklist',Value:'0'},{TextRef:'bbsp_whitelist',Value:'1'}]" ClickFuncApp="onchange=ChangeMode"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
		WMacfilterInfoConfigFormList = HWGetLiIdListByForm("MacFilterCfg", null);
		HWParsePageControlByID("MacFilterCfg", TableClass, wlanmacfil_language, null);
		getElById("EnableMacFilter").title = wlanmacfil_language['bbsp_macfilternote1'];
        if ((4 == ApModeValue && ApAdaptValue > 1)
			||(4 != ApModeValue && ApModeValue > 1))
        {
            getElById("FilterMode").title = wlanmacfil_language['bbsp_macfilterblacknote'];
        }
        else{
		getElById("FilterMode").title = wlanmacfil_language['bbsp_macfilternote2'];
        }
	</script>
</form>
<div class="func_spread"></div>

<script language="JavaScript" type="text/javascript">
    if (fttrFlag == 1) {
        var WMacfilterConfiglistInfo = new Array(new stTableTileInfo("Empty", "", "DomainBox"),
                                                 new stTableTileInfo("bbsp_ssidname", "", "SSIDName"),
                                                 new stTableTileInfo("bbsp_devicename", "", "DeviceName"),
                                                 new stTableTileInfo("bbsp_macaddr", "", "MACAddress"), null);
    } else if (CfgModeWord.toUpperCase() == "EGVDF2") {
        var WMacfilterConfiglistInfo = new Array(new stTableTileInfo("Empty", "", "DomainBox"),
                                                 new stTableTileInfo("bbsp_ssidindex", "", "SSIDName", true),
                                                 new stTableTileInfo("bbsp_devicename", "", "DeviceName"),
                                                 new stTableTileInfo("bbsp_macaddr", "", "MACAddress"), null);
    } else {
        var WMacfilterConfiglistInfo = new Array(new stTableTileInfo("Empty", "", "DomainBox"),
                                                 new stTableTileInfo("bbsp_ssidindex", "", "SSIDName"),
                                                 new stTableTileInfo("bbsp_devicename", "", "DeviceName"),
                                                 new stTableTileInfo("bbsp_macaddr", "", "MACAddress"), null);
    }

    var ColumnNum = 4;
    var ShowButtonFlag = true;
    var WMacfilterTableConfigInfoList = new Array();
    var TableDataInfo = HWcloneObject(MacFilter, 1);
    var SSIDFreList = GetSSIDFreList();
    for (var i = 0; i < TableDataInfo.length - 1; i++) {
        if(IsFreInSsidName() != true) {
            TableDataInfo[i].SSIDName = GetInstIDNameBySSIDName(TableDataInfo[i].SSIDName);
            if (fttrFlag == 1) {
                var instID = GetInstIdByName(TableDataInfo[i].SSIDName);
                TableDataInfo[i].SSIDName = wlanName[instID].ssid + "(" + wlanName[instID].freq + ")";
            }
        } else {
            var SSIDDomain = GetSSIDDomainByName('SSID' + TableDataInfo[i].SSIDName.charAt(TableDataInfo[i].SSIDName.length - 1));
            for (var j = 0; j < SSIDFreList.length; j++) {
                if (SSIDFreList[j].domain == SSIDDomain) {
                    TableDataInfo[i].SSIDName = SSIDFreList[j].name;
                    break;
                }
            }
        }
    }

    HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, WMacfilterConfiglistInfo, wlanmacfil_language, null);
</script>

<div class="list_table_spread"></div>
<form id="TableConfigInfo" style="display:none;"> 
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="ssidindex"                RealType="DropDownList"       DescRef="bbsp_ssidaddrtitle"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SSIDName"         InitValue="" ClickFuncApp="onchange=ChangeSSID"/>
		<li   id="DeviceName"           RealType="TextOtherBox"       DescRef="bbsp_devicenametitle"                    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   MaxLength="32"  InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'SelDeviceName'},{AttrName:'class',AttrValue:'Select_2 restrict_dir_ltr'}]}]"/>
		<li   id="SourceMACAddress"         RealType="TextBox"            DescRef="bbsp_macaddrtitle"                 RemarkRef="bbsp_macfilternote3"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.SourceMACAddress"      InitValue="Empty" MaxLength='17'/>
	</table>
	<script language="JavaScript" type="text/javascript">
		TableClass = new stTableClass("width_per20", "width_per80", "ltr");
		WMacfilterConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
		HWParsePageControlByID("TableConfigInfo", TableClass, wlanmacfil_language, null);
		var svrlist = getElementById('ssidindex');
		svrlist.options.length = 0;
	    for (var i = 0, WIFIName = GetRealSSIDList(), WIFINameFre = GetSSIDFreList(); i < WIFIName.length; i++)
		{
	        var value = 'SSID-' + WIFIName[i].name.charAt(WIFIName[i].name.length - 1);
            if (CfgModeWord.toUpperCase() == "AISAP" && value == "SSID-9") {
                continue;
            }
			if(true != IsFreInSsidName())
			{
				if (fttrFlag == 1) {
					var TextRef = WIFIName[i].ssid + "(" + WIFIName[i].freq + ")";
				} else {
					var TextRef = 'SSID'+ getWlanInstFromDomain(WIFIName[i].domain);
				}
			}
			else
			{
			    var TextRef = WIFINameFre[i].name;
			}
			svrlist.options.add(new Option(TextRef, value));
		}

        if (CfgModeWord.toUpperCase() == 'EGVDF2') {
            setDisplay('ssidindexRow', 0);
            svrlist.value = "";
        }

        if (fttrFlag == 1) {
            getElementById("ssidindexColleft").innerHTML = wlanmacfil_language['bbsp_ssidname'] + "：";
        }
	</script>
	<div id="MacAlert" style="display:none;"> 
		<table cellpadding="2" cellspacing="0" class="pm_tabal_bg" width="100%"> 
		  <tr> 
			<td class='color_red' BindText='bbsp_rednote'></td> 
		  </tr> 
		</table> 
	 </div>
	 <table cellpadding="0" cellspacing="0" width="100%" class="table_button"> 
          <tr>
            <td class='width_per20'></td> 
            <td class="table_submit">
			  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
			  <button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="SubmitEx();"> <script>document.write(wlanmacfil_language['bbsp_apply']);</script> </button> 
              <button id='Cancel' name="cancel" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelValue();"/> <script>document.write(wlanmacfil_language['bbsp_cancle']);</script> </button></td> 
          </tr> 
		  <tr> 
			  <td  style="display:none"> <input type='text'> </td> 
		  </tr>
      </table> 
</form>
</div>
</body>
</html>
