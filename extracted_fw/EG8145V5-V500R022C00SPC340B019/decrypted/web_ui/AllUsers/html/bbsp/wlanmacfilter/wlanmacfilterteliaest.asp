<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>Chinese -- MAC Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="Javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<style type="text/css">
.tabnoline td
{
   border:0px;
}
</style>
<script language="JavaScript" type="text/javascript"> 
var selctIndex = -1;
var TableName = "WMacfilterConfigList";
var SSIDnum = 8;
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';  
var ProductType = '<%HW_WEB_GetProductType();%>';  

var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';

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

function stMacFilter(domain,SSIDName,MACAddress)
{
   this.domain = domain;   
   this.SSIDName = SSIDName;
   this.MACAddress = MACAddress; 
   this.WlanMacFilterPolicy = '0';
   //Blacklist
}

var MacFilterSrc = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GeWlanMacFilter, InternetGatewayDevice.X_HW_Security.WLANMacFilter.{i},SSIDName|SourceMACAddress,stMacFilter);%>;

function stAttachConf(domain,X_HW_MacFilterPolicy)
{
    this.domain = domain;
    this.X_HW_MacFilterPolicy = X_HW_MacFilterPolicy;
}

var AttachConfs = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.X_HW_AttachConf,X_HW_MacFilterPolicy,stAttachConf);%>;


var AttachConfMap = {};
for (var i = 0; i < AttachConfs.length-1; i++)
{
	  var path = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
      var ApInst = AttachConfs[i].domain.charAt(path.length);
	  AttachConfMap[ApInst] = AttachConfs[i].X_HW_MacFilterPolicy;
}

var MacFilter = new Array();
for (var i = 0; i < MacFilterSrc.length-1; i++)
{
	var SSIDIndex = MacFilterSrc[i].SSIDName.charAt(MacFilterSrc[i].SSIDName.length - 1);
	if(IsVisibleSSID('SSID' + SSIDIndex) == true)
	{
		MacFilterSrc[i].WlanMacFilterPolicy = AttachConfMap[SSIDIndex];
		MacFilter.push(MacFilterSrc[i]);
	}
		
}
MacFilter.push(null);

var MacFilterPolicyMap = { 
							'0' : wlanmacfil_language['bbsp_none'],
							'1' : wlanmacfil_language['bbsp_whitelist'],
							'2' : wlanmacfil_language['bbsp_blacklist'] 
						 }
						 
function stAthName(domain,Name,Enable)
{
	this.domain = domain;
	this.Name   = Name;
	this.Enable = Enable;
}

function LoadFrame()
{
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
    setDisable('btnApply_ex',0);
    setDisable('cancel',0);

	loadlanguage();
}

function ChangeMode()
{
	
}

function GetInstIDNameBySSIDName(SSIDName)
{
	var SSIDDomain = GetSSIDDomainByName('SSID' + SSIDName.charAt(SSIDName.length - 1));
	return getWlanInstFromDomain(SSIDDomain);
}

function GetInstId(ssidName)
{
	var instId = ssidName.charAt(ssidName.length - 1);
	return instId;
}

function CheckForm()
{
    var SSIDName = getValue('ssidindex');
    var macAddress = getElement('SourceMACAddress').value;
    var num=0;
	
	if (ProductType == '2')
	{
	    if (macAddress == '') 
	    {
			AlertEx(wlanmacfil_language['bbsp_macfilterisreq']);
	        return false;
	    }
	    if (macAddress != '' && isValidMacAddress1(macAddress) == false ) 
	    {
			AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + macfilter_language['bbsp_macisinvalid']);       
	        return false;
	    }	
	}
	for (var i = 0; i < MacFilter.length-1; i++)
    {
        if (selctIndex != i)
        {
            if ((macAddress.toUpperCase() == MacFilter[i].MACAddress.toUpperCase()) && (SSIDName == MacFilter[i].SSIDName))
            {
                AlertEx(macfilter_language['bbsp_themac'] + macAddress + macfilter_language['bbsp_macrepeat']);
                return false;
            }
            if (SSIDName == MacFilter[i].SSIDName)
            {
               num++;
            }
        }
        else
        {
            continue;
        }
    }
    if (num >= SSIDnum)
    {
        AlertEx(wlanmacfil_language['bbsp_rulenum']);
        return false;
    }
	
    return true;
}

function AddSubmitParam(Form)
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : "y.X_HW_MacFilterPolicy="+getValue('SsidFilterMode')+"&x.X_HW_Token="+getValue('onttoken'),
    	url : 'set.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + GetInstId(getValue('ssidindex')) + '.X_HW_AttachConf'
                                       + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilterteliaest.asp',
		success : function(data) {
						
			Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_Security.WLANMacFilter' 
	                                    + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilterteliaest.asp');    

			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
			},
			
		complete: function (XHR, TS) {
			XHR=null;
			}
		});
}

function ModifySubmitParam(Form)
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : "y.X_HW_MacFilterPolicy="+getValue('SsidFilterMode')+"&x.X_HW_Token="+getValue('onttoken'),
    	url : 'set.cgi?y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + GetInstId(getValue('ssidindex')) + '.X_HW_AttachConf'
                                       + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilterteliaest.asp',
		success : function(data) {
						
			Form.setAction('set.cgi?x=' + MacFilter[selctIndex].domain 
	                                    + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilterteliaest.asp');    

			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
			},
			
		complete: function (XHR, TS) {
			XHR=null;
			}
		});
}

function SubmitParam()
{
	var Form = new webSubmitForm(); 

	if (false == CheckForm())
	{
		return;
	}
	
	Form.addParameter('x.SourceMACAddress',getValue('SourceMACAddress'));
	Form.addParameter('x.SSIDName',getValue('ssidindex'));
	Form.addParameter('x.Enable',1);
	
	setDisable('btnApply_ex',1);
    setDisable('cancel',1);
	if (selctIndex == -1)
	{
		AddSubmitParam(Form);
	}
	else
	{
		ModifySubmitParam(Form);
	}
}

function setCtlDisplay(record)
{
	if (record == null)
	{
		setText('SourceMACAddress','');
	}
	else
	{
        //var ssid = getElementById('ssidindex');
        //ssid.value = record.SSIDName;
		setSelect('ssidindex', record.SSIDName);
        setText('SourceMACAddress', record.MACAddress);
		setSelect('SsidFilterMode', record.WlanMacFilterPolicy);
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

	//需要修改为选中的SSID的模式是否为白名单
    //if (enableFilter == 1 && Mode == 1)
	if (MacFilter[selctIndex].WlanMacFilterPolicy  == 1)
    {   
        if(ConfirmEx(wlanmacfil_language['bbsp_whitealert']))
        {
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.WLANMacFilter' + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilterteliaest.asp');
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
		Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.WLANMacFilter' + '&RequestFile=html/bbsp/wlanmacfilter/wlanmacfilterteliaest.asp');
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
    }
    else
    {
        setText('SourceMACAddress',MacFilter[selctIndex].MACAddress);
		setSelect('ssidindex', MacFilter[selctIndex].SSIDName);
		setSelect('SsidFilterMode', MacFilter[selctIndex].WlanMacFilterPolicy);
    }
}

function ChangeSSID()
{

}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("wlanmacfilter", GetDescFormArrayById(wlanmacfil_language, "bbsp_mune"), GetDescFormArrayById(wlanmacfil_language, "bbsp_wlanmac_title"), false);
</script> 
<div class="title_spread"></div>

<div id="FilterInfo">

<div class="func_spread"></div>

<script language="JavaScript" type="text/javascript">
	var WMacfilterConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),									
								new stTableTileInfo("bbsp_ssidindex","","SSIDName"),
								new stTableTileInfo("bbsp_macaddr","","MACAddress"),
								new stTableTileInfo("bbsp_filterpolicytr","","WlanMacFilterPolicy"),null);	
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var WMacfilterTableConfigInfoList = new Array();
	var TableDataInfo = HWcloneObject(MacFilter, 1);
	var SSIDFreList = GetSSIDFreList();
	for (i = 0; i < TableDataInfo.length - 1; i++)
	{
		TableDataInfo[i].SSIDName = GetInstIDNameBySSIDName(TableDataInfo[i].SSIDName);
		TableDataInfo[i].WlanMacFilterPolicy = MacFilterPolicyMap[TableDataInfo[i].WlanMacFilterPolicy];
	}
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, WMacfilterConfiglistInfo, wlanmacfil_language, null);
</script>


<div class="list_table_spread"></div>
<form id="TableConfigInfo" style="display:none;"> 
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="ssidindex"                RealType="DropDownList"       DescRef="bbsp_ssidaddrtitle"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SSIDName"         InitValue="" ClickFuncApp="onchange=ChangeSSID"/>
		<li   id="SourceMACAddress"         RealType="TextBox"            DescRef="bbsp_macaddrtitle"                 RemarkRef="bbsp_macfilternote3"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.SourceMACAddress"      InitValue="Empty" MaxLength='17'/>
		
		<li   id="SsidFilterMode"                RealType="DropDownList"       DescRef="bbsp_filterpolicy"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.WlanMacFilterPolicy"         InitValue="[{TextRef:'bbsp_none',Value:'0'},{TextRef:'bbsp_whitelist',Value:'1'},{TextRef:'bbsp_blacklist',Value:'2'}]" ClickFuncApp="onchange=ChangeMode"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		TableClass = new stTableClass("width_per20", "width_per80", "ltr");
		//WMacfilterConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
		HWParsePageControlByID("TableConfigInfo", TableClass, wlanmacfil_language, null);
		var svrlist = getElementById('ssidindex');
		svrlist.options.length = 0;
	    for (var i = 0, WIFIName = GetRealSSIDList(), WIFINameFre = GetSSIDFreList(); i < WIFIName.length; i++)
		{
	        var value = 'SSID-' + WIFIName[i].name.charAt(WIFIName[i].name.length - 1);
			var TextRef = 'SSID'+ getWlanInstFromDomain(WIFIName[i].domain);
			
			svrlist.options.add(new Option(TextRef, value));
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
			  <button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="SubmitParam();"> <script>document.write(wlanmacfil_language['bbsp_apply']);</script> </button> 
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
