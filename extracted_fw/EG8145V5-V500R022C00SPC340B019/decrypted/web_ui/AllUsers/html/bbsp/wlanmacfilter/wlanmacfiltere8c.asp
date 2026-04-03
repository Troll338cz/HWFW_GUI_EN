<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>Chinese -- MAC Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, wlanmacfil_language);%>"></script>
<script language="Javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>
<style type="text/css">
.tabnoline td
{
   border:0px;
}
</style>
<script language="JavaScript" type="text/javascript"> 
var selctIndex = -1;
var numpara = "";
var addFlag = false;
var portid  = "";

if ((SSIDnum == 0) || (SSIDnum == '')) {
    SSIDnum = 8;
}
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';   
var isFttrModeFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';

if (isFttrModeFlag == 1){
    var SSIDnum = '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_MACFILTER_RADIO_NUM.UINT32);%>';
} else {
    var SSIDnum = '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_MACFILTER_NUM.UINT32);%>';
}

var StrHomeMacAddr = '<%HW_WEB_GetMacAddress();%>';
var HomeMacAddr = '';
if ('' != StrHomeMacAddr)
{
	HomeMacAddr = StrHomeMacAddr.substring(0,2) + ':' + StrHomeMacAddr.substring(2,4) + ':' + StrHomeMacAddr.substring(4,6) + ':' + StrHomeMacAddr.substring(6,8) + ':' + StrHomeMacAddr.substring(8,10) + ':' + StrHomeMacAddr.substring(10,12);
}

var HomeMacAddrIndexMap = {};
 
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
var wlanstate = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>'; 
var Mode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.WlanMacFilterPolicy);%>';


function stMacFilter(domain,SSIDName,MACAddress)
{
   this.domain = domain;   
   this.SSIDName = SSIDName;
   this.MACAddress = MACAddress; 
}

var MacFilterSrc = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.WLANMacFilter.{i},SSIDName|SourceMACAddress,stMacFilter);%>;
var MacFilter = new Array();
for (var i = 0; i < MacFilterSrc.length-1; i++)
{
	var SSIDIndex = MacFilterSrc[i].SSIDName.charAt(MacFilterSrc[i].SSIDName.length - 1);
	if(IsVisibleSSID('SSID' + SSIDIndex) == true)
		MacFilter.push(MacFilterSrc[i]);
}
MacFilter.push(null);

function stSsidBandInfo(domain, SSIDReference, X_HW_RFBand)
{
   this.domain = domain;
   this.SSIDReference = SSIDReference;
   this.X_HW_RFBand = X_HW_RFBand;
}

var SSIDBandList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, SSIDReference|X_HW_RFBand, stSsidBandInfo);%>;

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
   Form.setAction('del.cgi?RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
   Form.submit();
}

function LoadFrame()
{
	setDisplay('Newbutton',0);
	setDisplay('DeleteButton',0);

   if (enableFilter != '' && Mode != '')
   {    
       setDisplay('ConfigForm1',1);
       setSelect('FilterMode',Mode);
       if (MacFilter.length - 1 == 0)
       {
           selectLine('record_no');
           setDisplay('ConfigForm',0);
       }
       else
       {
           selectLine('record_0');
           setDisplay('ConfigForm',1);
       }
       setDisable('FilterMode',0);
       setDisable('WlanMACApply_button',0);
   }
   else
   {
       setDisplay('ConfigForm1',0);
   }
   
   if (enableFilter == "1")
   {
       getElById("EnableMacFilter").checked = true;
   }

	if(isValidMacAddress(numpara) == true)
	{
		clickAdd('MAC Filter');
		setSelect('ssidindex',portid);
		setText('SourceMACAddress', numpara);
		if('SSID1' == portid)
		{
			setText('ssidindex','SSID-1');
		}
		if('SSID2' == portid)
		{
			setText('ssidindex','SSID-2');
		}
		if('SSID3' == portid)
		{
			setText('ssidindex','SSID-3');
		}
		if('SSID4' == portid)
		{
			setText('ssidindex','SSID-4');
		}
	}

	loadlanguage();
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
   setDisable('isFilter',1);
}

function ChangeMode()
{
    var Form = new webSubmitForm();

    var FilterMode = getElById("FilterMode");

    if (FilterMode[0].selected == true)
	{ 
		if (ConfirmEx(wlanmacfil_language['bbsp_macfilterconfirm1']))
		{
		    Form.addParameter('x.WlanMacFilterPolicy',0);		
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
			Form.addParameter('x.WlanMacFilterPolicy',1);
		}
		else
		{
		    FilterMode[0].selected = true;
		    FilterMode[1].selected = false;
			return;
		}
	}
}

function SubmitForm()
{
   var Form = new webSubmitForm();   
   var Enable = getElById("EnableMacFilter").checked;
   if (Enable == true)
   {
	   if (0 == wlanstate)
	   {			
			AlertEx(wlanmacfil_language['bbsp_wlanstate']);
			return;
	   }	   
       Form.addParameter('x.WlanMacFilterRight',1);
   }
   else
   {
       Form.addParameter('x.WlanMacFilterRight',0);
   }
   Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
   Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
                        + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
   Form.submit();
}

function setBtnDisable()
{
	setDisable('EnableMacFilter',1);
    setDisable('FilterMode',1);
	setDisable('ModeSave_button',1);
    setDisable('WlanMACAdd_button',1);
	setDisable('WlanMACEdit_button',1);
	setDisable('WlanMACApply_button',1);
	setDisable('WlanMACDelete_button',1);
}

function OnSaveWlanFilterMode()
{
	var Form = new webSubmitForm();   
	var Enable = getElById("EnableMacFilter").checked;
	if (Enable == true)
	{
	   if (0 == wlanstate)
	   {			
			AlertEx(wlanmacfil_language['bbsp_wlanstate']);
			return;
	   }	   
	   Form.addParameter('x.WlanMacFilterRight',1);
	}
	else
	{
	   Form.addParameter('x.WlanMacFilterRight',0);
	}
	
    var FilterMode = getElById("FilterMode");

    if (FilterMode[0].selected == true)
	{ 
		Form.addParameter('x.WlanMacFilterPolicy',0);		
	}
	else if (FilterMode[1].selected == true)
	{
		Form.addParameter('x.WlanMacFilterPolicy',1);
	}
	Form.addParameter('x.ClientMAC', StrHomeMacAddr);	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'
						+ '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
	setBtnDisable();
	Form.submit();
}

function OnSelectWlanMacRecord(recId)
{
    if(false == addFlag){
        selectLine(recId);
    }
}

function OnEditWlanMacFilter()
{
    var recordId = 'record_' + selctIndex;
    setDisplay('mac_edit_tr',0);
    if((selctIndex < 0) && (MacFilter.length <= 1)){
       AlertEx("没有可以修改的配置记录");
        return;
    }
    selectLine(recordId);
    setDisplay('mac_edit_tr',1);
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

function CheckForm(type)
{   
    var SSIDName = getValue('ssidindex');
    var SSIDEnable = CheckSSIDEnable(SSIDName);
    var macAddress = getElement('SourceMACAddress').value;
    var num=0;

    if (macAddress == '') {
        AlertEx(wlanmacfil_language['bbsp_macfilterisreq']);
        return false;
    }

    if (true != SSIDEnable)
    {
		AlertEx(wlanmacfil_language['bbsp_ssiddisable']);
		return false;
    }

	if ((0 == Mode) && (HomeMacAddr != '') && (HomeMacAddr.toUpperCase() == macAddress.toUpperCase()))
	{
		AlertEx(wlanmacfil_language['bbsp_macfilterBlackReq']);
		return false;
	}

    if (isFttrModeFlag == 1) {
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

        if (isFttrModeFlag == 1) {
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
    if (num >= parseInt(SSIDnum)) {
        AlertEx(wlanmacfil_language['bbsp_rulenum_left'] + SSIDnum + wlanmacfil_language['bbsp_rulenum_right']);
        return;
    }

    return true;
}

function AddSubmitParam(SubmitForm,type)
{
	if (0 == wlanstate)
    {			
		AlertEx(wlanmacfil_language['bbsp_wlanstate2']);
		return;
    }
	
	SubmitForm.addParameter('x.SourceMACAddress',getValue('SourceMACAddress'));
	SubmitForm.addParameter('x.SSIDName',getValue('ssidindex'));

	var enable = getElById("EnableMacFilter").checked;
	SubmitForm.addParameter('x.Enable',1);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));	
    if( selctIndex == -1 )
	{
		 SubmitForm.setAction('add.cgi?x=InternetGatewayDevice.X_HW_Security.WLANMacFilter'
		                        + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
	}
	else
	{
	     SubmitForm.setAction('set.cgi?x=' + MacFilter[selctIndex].domain
							+ '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
	}
	setBtnDisable();
}

function setCtlDisplay(record)
{
	if (record == null)
	{
		setText('SourceMACAddress','');
	}
	else
	{
        var ssid = getElementById('ssidindex');
        ssid.value = record.SSIDName;
        setText('SourceMACAddress', record.MACAddress);
	}	
}

function setControl(index)
{   
    var record;
    selctIndex = index;
    if (index == -1)
	{
        if (MacFilter.length >= (TopoInfo.SSIDNum*SSIDnum)+1)
        {
            setDisplay('ConfigForm', 0);
			if(DoubleFreqFlag == 1)
			{
            	AlertEx(wlanmacfil_language['bbsp_rulenum2']);
			}
			else
			{
				AlertEx(wlanmacfil_language['bbsp_rulenum1']);
			}
			setDisable('WlanMACApply_button',1);
            return;
        }
        else
        {
            setDisplay('ConfigForm', 1);
            setCtlDisplay(record);
        }
	}
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
	else
	{
	    record = MacFilter[index];
		if ((1 == Mode) && (HomeMacAddr != '') && (HomeMacAddr.toUpperCase() == record.MACAddress.toUpperCase()))
		{
			setDisable('WlanMACEdit_button',1);
		}
		else
		{
			setDisable('WlanMACEdit_button',0);
		}
        setDisplay('ConfigForm', 1);
        setCtlDisplay(record);
	}
    setDisable('WlanMACApply_button',0);
}

function OnDeleteBtClick() 
{ 
	var noChooseFlag = true;
	var SubmitForm = new webSubmitForm();	
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

	for (var i = 0; i < MacFilter.length - 1; i++)
	{
		var j = i + 1;
		var rmId = 'WlanMACAddress' + j +'_checkbox';
		var rm = getElement(rmId);
		if (rm.checked == true)
		{
			noChooseFlag = false;
			SubmitForm.addParameter(MacFilter[i].domain,'');
		}
	}
    if ( noChooseFlag )
    {
        AlertEx(wlanmacfil_language['bbsp_chooserulealert']);
        return ;
    }

    if (enableFilter == 1 && Mode == 1)
    {   
        if(ConfirmEx(wlanmacfil_language['bbsp_whitealert']))
        {
			setBtnDisable();
			SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
			SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
			SubmitForm.submit();	
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
			return;
        }
        setBtnDisable();
		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/wlanmacfilter/wlanmacfiltere8c.asp');
		SubmitForm.submit();	
    }  
}

function clickCheckbox(index)
{
    var chkboxShow = 'WlanMACAddress' + index +'_checkbox';
    var chkboxHide = 'WlanMACAddress' + index +'_checkboxCopy';
    var enableVal = getCheckVal(chkboxShow);
	if (!((1 == Mode) && (HomeMacAddr != '') && (HomeMacAddrIndexMap[index] == 1)))
	{
		setCheck(chkboxHide,enableVal);
	}
}

function clickCheckboxAll()
{
    for (var i = 0; i < MacFilter.length - 1; i++){
        var index = i + 1;
        var chkboxShow = 'WlanMACAddress' + index +'_checkbox';
        var enableVal = getCheckVal("WlanMACAddress_checkbox");
		if (!((1 == Mode) && (HomeMacAddr != '') && (HomeMacAddrIndexMap[index] == 1)))
        {
			setCheck(chkboxShow,enableVal);
        	clickCheckbox(index);
		}
    }
}

function CancelValue()
{   
    if (selctIndex == -1)
    {
        var tableRow = getElement("MacInfo");

        if (tableRow.rows.length == 1)
        {
        }
        else if (tableRow.rows.length == 2)
        {
            addNullInst('MAC Filter');
        }   
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine('record_0');
        }
    }
    else
    {
        setText('SourceMACAddress',MacFilter[selctIndex].MACAddress);
    }
}

function ChangeSSID()
{

}

function clickAdd()
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
	setDisplay('mac_edit_tr',1);
	
	var tab = document.getElementById('WlanMAC Filter').getElementsByTagName('table');
	var row,col;
	var rowLen = tab[0].rows.length;
	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if (lastRow.id == 'record_null')
	{
		selectLine("record_null");
		return;
	}
    else if (lastRow.id == 'record_no')
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
    }

	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1;
		row.className = 'trTabContent';
		row.id = 'record_null';
		row.attachEvent("onclick", function(){selectLine("record_null");});
	}
	else
	{
		g_browserVersion = 2;
		row.setAttribute('class','trTabContent');
		row.setAttribute('id','record_null');
		row.setAttribute('onclick','selectLine(this.id);');
	}

	for (var i = 0; i < firstRow.cells.length; i++)
	{
        col = row.insertCell(i);
	 	col.innerHTML = '----';
	} 
	selectLine("record_null");
	setText('SourceMACAddress', '');
	addFlag = true;
    setDisable('WlanMACDelete_button',1);
    setDisable('WlanMACEdit_button',1);
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabTest"> 
  <tr> 
    <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class='title_common' BindText='bbsp_wlanmac_title'> </td> 
        </tr> 
      </table></td> 
  </tr> 
</table> 
<div class="title_spread"></div>

<table cellspacing="0" cellpadding="0" width="100%" class="tabal_bg" > 
  <form id="ConfigForm1" action=""> 
    <div id='FilterInfo'> 
      <table cellspacing="0" cellpadding="0" width="100%"> 
        <tr class="align_left"> 
          <td class="table_title" width="30%">使能WLAN MAC过滤</td> 
          <td class="table_right"><input type=checkbox value="True" id="EnableMacFilter" name="EnableMacFilter"/></td> 
        </tr> 
        <tr class="align_left"> 
          <td class="table_title width_30p">过滤模式</td> 
          <td class="table_right" id="FilterModeTitle"><select id="FilterMode" size='1' onchange="setTimeout(function(){ChangeMode();})">
              <option value="0"><script>document.write(wlanmacfil_language['bbsp_blacklist']);</script></option> 
              <option value="1"><script>document.write(wlanmacfil_language['bbsp_whitelist']);</script></option> 
            </select></td> 
        </tr> 
	    <script>
			getElById("EnableMacFilter").title = wlanmacfil_language['bbsp_macfilternote1'];
			getElById("FilterModeTitle").title = wlanmacfil_language['bbsp_macfilternote2'];
		</script>
      </table> 
      <div class="button_spread"></div>
      <table width="100%" class="table_button"> 
          <tr align="right"> 
          <td><button id="ModeSave_button" type="button" class="submit" onclick="OnSaveWlanFilterMode();">保存/应用</button></td>
          </tr>
     </table>
	 
	 <div class="func_spread"></div>
	 <hr style="color:#C9C9C9"></hr>
      <script language="JavaScript" type="text/javascript">
        writeTabCfgHeader('WlanMAC Filter',"100%");
        </script> 
      <table id="MacInfo" width="100%" cellspacing="1" class="tabal_bg"> 
        <tr> 
		<td class="head_title"><input id="WlanMACAddress_checkbox" type="checkbox" onclick="clickCheckboxAll();"  value="false" ></td> 
		<td class=" head_title" BindText='bbsp_ssidindex'></td> 
          <td class=" head_title" BindText='bbsp_macaddr'></td> 
        </tr> 
        <script language="JavaScript" type="text/javascript">
            if (MacFilter.length - 1 == 0)
            {
				document.write('<tr id="record_no" class="tabal_01" onclick="OnSelectWlanMacRecord(this.id);">');
                document.write('<td id=\"WlanMACAddress1_checkbox\" onclick="selectLine(this.id);" align="center">--</td>');
				document.write('<td align="center">--</td>');  
				document.write('<td align="center">--</td>');   
				document.write('</tr>');
            }
            else
            {
            	for (i = 0; i < MacFilter.length - 1; i++)
            	{
				   	var j = i+1;
					document.write('<tr id="record_' + i + '" class="tabal_01"  onclick="OnSelectWlanMacRecord(this.id)">');
					if ((1 == Mode) && (HomeMacAddr != '') && (HomeMacAddr.toUpperCase() == MacFilter[i].MACAddress.toUpperCase()))
					{
						HomeMacAddrIndexMap[j] = 1;
 						document.write('<td align="center"><input disabled="disabled" id=\"WlanMACAddress' + j +'_checkbox\"'  + 'type=\'checkbox\''+ 'value=\'false\'' + 'onclick=\"clickCheckbox('+j+');\" \'>' );
						document.write('<input id=\"WlanMACAddress' + j +'_checkboxCopy\"'  + 'type=\'checkbox\''
										+ ' value=\'' + MacFilter[i].domain + '\' style=\"display:none\" >'+ '</td>' );
						document.write('<td align="center">SSID' + GetInstIDNameBySSIDName(MacFilter[i].SSIDName)+ '&nbsp;</td>');
						document.write('<td align="center">' + MacFilter[i].MACAddress + '</br>' + '<span class="color_red">' + wlanmacfil_language['bbsp_WriteListInfo'] + '</span>' +'&nbsp;</td>'); 
					}
					else
					{
						document.write('<td align="center"><input id=\"WlanMACAddress' + j +'_checkbox\"'  + 'type=\'checkbox\''+ 'value=\'false\'' + 'onclick=\"clickCheckbox('+j+');\" \'>' );
						document.write('<input id=\"WlanMACAddress' + j +'_checkboxCopy\"'  + 'type=\'checkbox\''
										+ ' value=\'' + MacFilter[i].domain + '\' style=\"display:none\" >'+ '</td>' );
						document.write('<td align="center">SSID' + GetInstIDNameBySSIDName(MacFilter[i].SSIDName)+ '&nbsp;</td>');
						document.write('<td align="center">' + MacFilter[i].MACAddress + '&nbsp;</td>'); 
					}
            			document.write('</tr>');  
            	}
            }
            </script> 
    </table> 
    <div id="ConfigForm"> 
      <table  cellpadding="0" cellspacing="0" width="100%"> 
        <tr> 
          <td id="mac_edit_tr" style="display:none"> <table cellpadding="0" cellspacing="0" width="100%"> 
              <tr> 
			    <td class="table_title width_20p">SSID索引</td> 
                <td class="table_right width_80p"> <select id="ssidindex" onchange="ChangeSSID();">  
                <script language="JavaScript" type="text/javascript">	              
                for (var i = 0, WIFIName = GetRealSSIDList(); i < WIFIName.length; i++)
                {
                    document.write('<option value="SSID-' + WIFIName[i].name.charAt(WIFIName[i].name.length - 1) + '">' +'SSID'+ getWlanInstFromDomain(WIFIName[i].domain) + '</option>');
                }
                </script> 
                </select></td>                
              </tr> 
			  <tr> 
                  <td  class="table_title width_20p">源MAC地址</td> 
                  <td  class="table_right width_80p"> <input type='text' name="SourceMACAddress" id="SourceMACAddress" maxlength='17'><span class="gray">(AA:BB:CC:DD:EE:FF)</span> </td> 
                </tr> 
                <tr style="display:none"> 
                  <td class="table_title" BindText='bbsp_macenabletitle'></td> 
                  <td class="table_right"> <input type='checkbox' id="Enable" name="Enable" checked> </td> 
                </tr> 
              </table> 
              <div id="MacAlert" style="display:none"> 
                <table cellpadding="2" cellspacing="0" class="tabal_bg" width="100%"> 
                  <tr>                    
					<td class='color_red' BindText='bbsp_rednote'></td> 
                  </tr> 
                </table> 
              </div></td> 
			  </td> 
          </tr> 
        </table> 
      </div> 
	  <div class="button_spread"></div>
	  <table  width="100%" class="table_button"> 
          <tr align="right">
            <td class='width_20p'></td> 
            <td>
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<button id='WlanMACAdd_button'  class="submit" type="button" onClick="clickAdd('WlanMAC Filter');">添加</button>
				<button id='WlanMACEdit_button' class="submit" type="button" onclick="OnEditWlanMacFilter();" >编辑</button>
			    <button id='WlanMACApply_button' name="WlanMACApply_button" class="submit" type="button" onClick="Submit();"> <script>document.write(wlanmacfil_language['bbsp_apply']);</script> </button> 
                <button id='WlanMACDelete_button' name="WlanMACDelete_button"  class="submit" type="button" onClick="OnDeleteBtClick();">删除</button> </td>
          </tr> 
		  <tr> 
			  <td  style="display:none"> <input type='text'> </td> 
		  </tr>
        </table> 
      <script language="JavaScript" type="text/javascript">
		writeTabTail();
		</script> 
    </div> 
  </form> 
</table> 
</body>
</html>
