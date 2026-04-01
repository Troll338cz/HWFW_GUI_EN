<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<title>Firewall Log</title>
<script language="JavaScript" type="text/javascript">
var TableName = "LogInfo";
var selctIndex = -1;
var FirewallLogRight = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.FirewallLog.FirewallLogRight);%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
var initLanguage = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE.STRING);%>';
var languageSet = new Array();
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
if ((typeof languageList == 'string') && (languageList != '')) {
    languageSet = languageList.split("|");
}

function IsSupportPrompt()
{
    if (languageSet.length > 1) {
        for (var lang in languageSet) {
            if ((languageSet[lang] != 'english') && (languageSet[lang] != 'chinese')) {
                return false;
            }
        }
    }

    if ((initLanguage != 'english') && (initLanguage != 'chinese')) {
        return false;
    }

    if ((curLanguage != 'english') && (curLanguage != 'chinese')) {
        return false;
    }

    return true;
}

function stFirewallLogRules(domain,Enable,Direction,Action)
{
   this.domain = domain;
   this.Enable = Enable;
   this.Direction = Direction;
   this.Action = Action;
}
var FirewallLogRules = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.FirewallLog.Rules.{i},Enable|Direction|Action,stFirewallLogRules);%>;

function ShowFirewallLogInfo(obj)
{
	if (obj.checked)
	{
		setDisplay('FirewallLogInfo', 1);
	}
	else
	{
		setDisplay('FirewallLogInfo', 0);
	}
}

function LoadFrame()
{
   if (FirewallLogRight == "1")
   {
       getElById("EnableFirewallLog").checked = true;
   }
   
   setDisplay('ConfigForm1',1);
	   
   if (FirewallLogRules.length - 1 == 0)
   {
       selectLine('record_no');
       setDisplay('ConfigForm',0);
   }
   else
   {
       selectLine(TableName + '_record_0');
       setDisplay('ConfigForm',1);
   }
	   
   setDisable('btnApply_ex',0);
   setDisable('cancel',0);
}

function SubmitForm()
{
   var Form = new webSubmitForm();
      
   if (getElById("EnableFirewallLog").checked == true)
   {
       Form.addParameter('x.FirewallLogRight',1);
   }
   else
   {
       Form.addParameter('x.FirewallLogRight',0);
   }
   
   Form.addParameter('x.X_HW_Token', getValue('onttoken'));
   Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.FirewallLog' + '&RequestFile=html/bbsp/firewalllog/firewalllogview.asp');
   Form.submit();
}

function CheckForm(type)
{
	var Direction = getElement('Direction').value;
	var Action;
	
	if ( getElement('Action').value == 0)
	{
		Action = "Deny";
	}
	else
	{
		Action = "Permit";
	}
	
	for (i = 0; i < FirewallLogRules.length - 1; i++)
    {
		if (selctIndex == i)
		{
			continue;
		}
		
		if ((FirewallLogRules[i].Direction == Direction) && (FirewallLogRules[i].Action == Action))
		{
			AlertEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_rule_exist']);
			return false;
		}
    }
	
    return true;
}

function AddSubmitParam(SubmitForm,type)
{
	if (getElById("Enable").checked == true)
	{
		SubmitForm.addParameter('x.Enable', 1);
	}
	else
	{
		SubmitForm.addParameter('x.Enable', 0);
	}
	
	SubmitForm.addParameter('x.Direction',getValue('Direction'));
	
	if (getValue('Action') == 0)
	{
		SubmitForm.addParameter('x.Action', "Deny");
	}
	else
	{
		SubmitForm.addParameter('x.Action', "Permit");
	}
	
    if (selctIndex == -1)
	{
		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		AlertEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_add_note']);
		SubmitForm.setAction('add.cgi?x=InternetGatewayDevice.X_HW_Security.FirewallLog.Rules' + '&RequestFile=html/bbsp/firewalllog/firewalllogview.asp');
	}
	else
	{
		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		SubmitForm.setAction('set.cgi?x=' + FirewallLogRules[selctIndex].domain + '&RequestFile=html/bbsp/firewalllog/firewalllogview.asp');
	}

    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
}
function setCtlDisplay(record)
{
	if (record.Enable == 1)
	{
		getElById("Enable").checked = true;
	}
	else
	{
		getElById("Enable").checked = false;
	}
	
	setSelect('Direction',record.Direction);
	
	if (record.Action == "Deny")
	{
		setSelect('Action',0);
	}
	else
	{
		setSelect('Action',1);
	}
}

function setControl(index)
{   
    var record;
    selctIndex = index;
	
    if (index == -1)
	{
	    if (FirewallLogRules.length >= 8+1)
        {
            setDisplay('ConfigForm', 0);
            AlertEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_full']);
			CancelValue();
            return;
        }
        else
        {
	        record = new stFirewallLogRules('','','','');
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
	    record = FirewallLogRules[index];
        setDisplay('ConfigForm', 1);
        setCtlDisplay(record);
	}
	
    setDisable('btnApply_ex',0);
    setDisable('cancel',0);
}

function LogInfoselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{ 
    if ((FirewallLogRules.length-1) == 0)
	{
	    AlertEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_no_rule']);
	    return;
	}

	if (selctIndex == -1)
	{
	    AlertEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_save_rule']);
	    return;
	}

    var rml = document.getElementsByName(TableName + 'rml');
	var Form = new webSubmitForm();
	var Count = 0;
   for (var i = 0; i < rml.length; i++)
	{
		if (rml[i].checked != true)
		{
			continue;
		}
		
		Count++;
		Form.addParameter(rml[i].value,'');
	}
	if (Count <= 0)
	{
		 AlertEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_select_rule']);
		return;
	}   

    if (ConfirmEx(ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_del_confirm']) == false)
    {
        document.getElementById("DeleteButton").disabled = false;
        return;
    }
	
    setDisable('btnApply_ex',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('del.cgi?RequestFile=html/bbsp/firewalllog/firewalllogview.asp');
    Form.submit();
}

function CancelValue()
{ 
    if (selctIndex == -1)
    {
		setDisplay("ConfigForm", 0);	
        var tableRow = getElementById(TableName);

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
        setCtlDisplay(FirewallLogRules[selctIndex]);
    }
}

function ShowFirewallLogDir()
{
}

function ShowFirewallLogAct()
{
}

function backupSetting()
{
	if (IsSupportPrompt() == true) {
		if (ConfirmEx(firewalllogviewLgeDes['s0b14']) == false) {
			return;
		}
	}

	var ua = navigator.userAgent.toLowerCase();	
    var Form = new webSubmitForm();
	if (/iphone|ipad|ipod/.test(ua)) {
		window.open("/html/bbsp/firewalllog/firewalllogview_ios.asp");
		return;
	}
	Form.addParameter('logtype', "opt");
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('downloadfile.cgi?FileType=flowlog&RequestFile=html/bbsp/firewalllog/firewalllogview.asp');
	Form.submit();
}

function InitTableData()
{
	var TableDataInfo = new Array();
	var ShowButtonFlag = true;
	var RecordCount = FirewallLogRules.length - 1;
    var i = 0;
	var Listlen = 0;

	if (RecordCount == 0)
	{
		TableDataInfo[Listlen] = new stFirewallLogRules();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].Enable = '--';
		TableDataInfo[Listlen].Direction = '--';
		TableDataInfo[Listlen].Action = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, FirewallLogConfiglistInfo, ipfirewalllogcfg_language, null);
    	return;
	}
	
	 for (i = 0; i < RecordCount; i++)
	 {
	 	TableDataInfo[Listlen] = new stFirewallLogRules();
		TableDataInfo[Listlen].domain = FirewallLogRules[i].domain;
		if (FirewallLogRules[i].Enable == "1" || FirewallLogRules[i].Enable == 1)
		{
			TableDataInfo[Listlen].Enable = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_en_str'];
		}
		else
		{
			TableDataInfo[Listlen].Enable = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_dis_str'];
		}
		
		if (FirewallLogRules[i].Direction == "0" || FirewallLogRules[i].Direction == 0)
		{
			TableDataInfo[Listlen].Direction = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_dir_0'];
		}
		else if (FirewallLogRules[i].Direction == "1" || FirewallLogRules[i].Direction == 1)
		{
			TableDataInfo[Listlen].Direction = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_dir_1'];
		}
		else if (FirewallLogRules[i].Direction == "2" || FirewallLogRules[i].Direction == 2)
		{
			TableDataInfo[Listlen].Direction = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_dir_2'];
		}
		else
		{
			TableDataInfo[Listlen].Direction = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_dir_3'];
		}
		
		if (FirewallLogRules[i].Action == "Deny")
		{
			TableDataInfo[Listlen].Action = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_act_0'];
		}
		else
		{
			TableDataInfo[Listlen].Action = ipfirewalllogcfg_language['bbsp_ipfirewalllogcfg_act_1'];
		}
		Listlen++;
	 }
	 TableDataInfo.push(null);
	 HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, FirewallLogConfiglistInfo, ipfirewalllogcfg_language, null);
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
var lgeDes = "s0b0e";
if (CfgMode.toUpperCase() == 'DINFOTEK2') {
    lgeDes = "s0b0e_s";
}
HWCreatePageHeadInfo("firewalllog", GetDescFormArrayById(firewalllogviewLgeDes, "s0b0e"), GetDescFormArrayById(firewalllogviewLgeDes, "s0100"), false);
</script> 
<div class="title_spread"></div>

<form id="FirewallLogEnableForm" style="display:block;">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="EnableFirewallLog"                 RealType="CheckBox"           DescRef="bbsp_ipfirewalllogcfg_enable_mh"       RemarkRef="bbsp_ipfirewalllogcfg_enable_note"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.FirewallLogRight"      InitValue="Empty"     ClickFuncApp="onclick=SubmitForm"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per20", "width_per80", "ltr");
		HWParsePageControlByID("FirewallLogEnableForm", TableClass, ipfirewalllogcfg_language, null);
	</script>
	<div class="func_spread"></div>
</form>

<script language="JavaScript" type="text/javascript">
	var FirewallLogConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),									
								new stTableTileInfo("bbsp_ipfirewalllogcfg_tt_en","","Enable"),
								new stTableTileInfo("bbsp_ipfirewalllogcfg_tt_dir","","Direction"),
								new stTableTileInfo("bbsp_ipfirewalllogcfg_tt_act","","Action"),null);	
	var ColumnNum = 4;
	var ShowButtonFlag = true;
	var MacfilterTableConfigInfoList = new Array();
	InitTableData();
</script>

<form id="ConfigForm" style="display:none;"> 
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="Enable"          RealType="CheckBox"         DescRef="bbsp_ipfirewalllogcfg_en_add"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"      InitValue="Empty"/>
		<li   id="Direction"       RealType="DropDownList"     DescRef="bbsp_ipfirewalllogcfg_dir_add"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.Direction"    Maxlength="50"
		InitValue="[{TextRef:'bbsp_ipfirewalllogcfg_dir_0',Value:'0'},{TextRef:'bbsp_ipfirewalllogcfg_dir_1',Value:'1'},{TextRef:'bbsp_ipfirewalllogcfg_dir_2',Value:'2'},{TextRef:'bbsp_ipfirewalllogcfg_dir_3',Value:'3'}]" ClickFuncApp="onchange=ShowFirewallLogDir"/>                                                                   
		<li   id="Action"       RealType="DropDownList"     DescRef="bbsp_ipfirewalllogcfg_act_add"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.Action"    Maxlength="50"
		InitValue="[{TextRef:'bbsp_ipfirewalllogcfg_act_0',Value:'0'},{TextRef:'bbsp_ipfirewalllogcfg_act_1',Value:'1'}]" ClickFuncApp="onchange=ShowFirewallLogAct"/>                                                                   
	</table>
	<script language="JavaScript" type="text/javascript">
		var FirewallLogConfigFormList = new Array();
		FirewallLogConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
		HWParsePageControlByID("ConfigForm", TableClass, ipfirewalllogcfg_language, null);
	</script>
	<table cellpadding="0" cellspacing="0" width="100%" class="table_button"> 
          <tr > 
            <td class='width_per20'></td> 
            <td class="table_submit"> 
			  <button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="Submit();"><script>document.write(ipfirewalllogcfg_language['bbsp_app']);</script></button> 
              <button id='Cancel' name="cancel" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelValue();"><script>document.write(ipfirewalllogcfg_language['bbsp_cancel']);</script></button>
		   </td> 
          </tr> 
		  <tr> 
			  <td  style="display:none"> <input type='text'> </td> 
		  </tr>          
	</table>
</form>
	<div class="func_spread"></div> 


<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
  <tr> 
    <td class="width_per100" BindText="s0b0f"></td> 
  </tr> 
</table> 
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 
<div id="backlog"> 
  <table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td> 
	  <input class="ApplyButtoncss buttonwidth_150px_250px" name="button" id="button" type='button'  onClick='backupSetting()' BindText="s0b11" >  
	  <input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
	  </td> 
    </tr> 
  </table> 
</div> 
<div class="button_spread"></div>

<div id="logviews"> 
  <textarea name="logarea" id="logarea" class="text_log" wrap="off" readonly="readonly">
  </textarea> 
	<script type="text/javascript">
	document.getElementById("logarea").value ='<%HW_WEB_GetFlowLogInfo();%>';
	</script> 
</div> 

<script>
ParseBindTextByTagName(firewalllogviewLgeDes, "td",     1);
ParseBindTextByTagName(firewalllogviewLgeDes, "option", 1);
ParseBindTextByTagName(firewalllogviewLgeDes, "div",    1);
ParseBindTextByTagName(firewalllogviewLgeDes, "input",  2);
</script>

</body>
</html>
