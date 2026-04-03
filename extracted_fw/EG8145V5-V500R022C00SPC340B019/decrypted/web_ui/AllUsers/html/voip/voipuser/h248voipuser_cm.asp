<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>VOIP User</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<style>
.TextBox
{
width:150px;  
}

.Select
{
width:157px;  
}
	
.impedancetextareaclass
{
	font-size:11px;
	width:99%;
}

.impedancetextclass
{
	font-size:12px;
	width:80%;
	color:#767676;	
}

.selectdefcss
{
width:150px;
}

.interfacetextclass{
	width:300px;
	height:50px;
}

</style>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248user);%>"></script>
<script language="JavaScript" type="text/javascript">
var selctIndex = -1;
var selctLindex = 0;
var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function ShowTab(OffhookDuration,OnhookDuration,HookFlashDownTime,HookFlashUpTime,RingFreq,OnhookTxGain,OnhookRxGain,OffhookTxGain,OffhookRxGain)
{
	this.OffhookDuration = OffhookDuration;
	this.OnhookDuration = OnhookDuration;	
	this.HookFlashDownTime = HookFlashDownTime;
	this.HookFlashUpTime = HookFlashUpTime;	
	this.RingFreq = RingFreq;
	this.OnhookTxGain = OnhookTxGain;
	this.OnhookRxGain = OnhookRxGain;
	this.OffhookTxGain = OffhookTxGain;
	this.OffhookRxGain = OffhookRxGain;
	
}

function stPhyInterfaceParam(Domain,OffhookDuration,OnhookDuration,HookFlashDownTime,HookFlashUpTime,RingFreq,OnhookTxGain,OnhookRxGain,OffhookTxGain,OffhookRxGain)
{
   this.Domain = Domain;
   this.OffhookDuration = OffhookDuration;
	this.OnhookDuration = OnhookDuration;	
	this.HookFlashDownTime = HookFlashDownTime;
	this.HookFlashUpTime = HookFlashUpTime;	
	this.RingFreq = RingFreq;
	this.OnhookTxGain = OnhookTxGain;
	this.OnhookRxGain = OnhookRxGain;
	this.OffhookTxGain = OffhookTxGain;
	this.OffhookRxGain = OffhookRxGain;
}
var PhyInterfaceParams = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.ST_MGCP_Advan.{i},OffhookDuration|OnhookDuration|HookFlashDownTime|HookFlashUpTime|RingFreq|OnhookTxGain|OnhookRxGain|OffhookTxGain|OffhookRxGain, stPhyInterfaceParam);%>;

function initHighConfig()
{
	document.getElementById("OffhookDuration").innerText = PhyInterfaceParams[0].OffhookDuration;
	document.getElementById("OnhookDuration").innerText = PhyInterfaceParams[0].OnhookDuration;
	document.getElementById("HookFlashDownTime").innerText = PhyInterfaceParams[0].HookFlashDownTime;
	document.getElementById("HookFlashUpTime").innerText = PhyInterfaceParams[0].HookFlashUpTime;
	document.getElementById("RingFreq").innerText = PhyInterfaceParams[0].RingFreq;
	document.getElementById("OnhookTxGain").innerText = PhyInterfaceParams[0].OnhookTxGain;
	document.getElementById("OnhookRxGain").innerText = PhyInterfaceParams[0].OnhookRxGain;
	document.getElementById("OffhookTxGain").innerText = PhyInterfaceParams[0].OffhookTxGain;
	document.getElementById("OffhookRxGain").innerText = PhyInterfaceParams[0].OffhookRxGain;
	
}

function AddSubmitParam(Form,type)
{
	var PhyListLength = getElement('PhyList').options.length;
	
	if (PhyListLength > 0)
	{
	
		Form.addParameter('u.OffhookDuration',getValue('OffhookDuration'));
		Form.addParameter('u.OnhookDuration',getValue('OnhookDuration'));
		Form.addParameter('u.HookFlashDownTime',getValue('HookFlashDownTime'));
		Form.addParameter('u.HookFlashUpTime',getValue('HookFlashUpTime'));
		Form.addParameter('u.RingFreq',getValue('RingFreq'));
		Form.addParameter('u.OnhookTxGain',getValue('OnhookTxGain'));
		Form.addParameter('u.OnhookRxGain',getValue('OnhookRxGain'));
		Form.addParameter('u.OffhookTxGain',getValue('OffhookTxGain'));
		Form.addParameter('u.OffhookRxGain',getValue('OffhookRxGain'));
	}
}

function setPhyInterfaceParams()
{
    var PhyID;
    var selectObj = getElement("PhyList");
    if(selectObj.options.length == 0)
    {
        return;
    }
	PhyID = parseInt(getSelectVal("PhyList"));	
	if(PhyID >= 1)
	{
	PhyID = parseInt(getSelectVal("PhyList"))-1;
	
	document.getElementById("OffhookDuration").innerText = PhyInterfaceParams[PhyID].OffhookDuration;
	document.getElementById("OnhookDuration").innerText = PhyInterfaceParams[PhyID].OnhookDuration;
	document.getElementById("HookFlashDownTime").innerText = PhyInterfaceParams[PhyID].HookFlashDownTime;
	document.getElementById("HookFlashUpTime").innerText = PhyInterfaceParams[PhyID].HookFlashUpTime;
	document.getElementById("RingFreq").innerText = PhyInterfaceParams[PhyID].RingFreq;
	document.getElementById("OnhookTxGain").innerText = PhyInterfaceParams[PhyID].OnhookTxGain;
	document.getElementById("OnhookRxGain").innerText = PhyInterfaceParams[PhyID].OnhookRxGain;
	document.getElementById("OffhookTxGain").innerText = PhyInterfaceParams[PhyID].OffhookTxGain;
	document.getElementById("OffhookRxGain").innerText = PhyInterfaceParams[PhyID].OffhookRxGain;
 
	}
}
    </script>
</head>
<body class="mainbody" onload="initHighConfig();">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipUser", GetDescFormArrayById(h248user, "v01"), GetDescFormArrayById(h248user, "v02"), false);

</script>

<div class="title_spread"></div>
<div class="func_spread"></div>
		
<form id="voipadv3">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_phy'></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="PhyList" RealType="DropDownList" DescRef="vspa_portindex" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyList" InitValue="[{TextRef:'vspa_one',Value:'1'},{TextRef:'vspa_two',Value:'2'}]" ClickFuncApp="onchange=setPhyInterfaceParams"/>	
<li id="OffhookDuration" RealType="HtmlText" DescRef="vspa_offhookduration" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="OffhookDuration" InitValue="Empty"/>
<li id="OnhookDuration" RealType="HtmlText" DescRef="vspa_onhookduration" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="OnhookDuration" InitValue="Empty"/>
<li id="HookFlashDownTime" RealType="HtmlText" DescRef="vspa_hookdown" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="HookFlashDownTime" InitValue="Empty"/>
<li id="HookFlashUpTime" RealType="HtmlText" DescRef="vspa_hookup" RemarkRef="vspa_uintms" ErrorMsgRef="Empty" Require="FALSE" BindField="HookFlashUpTime" InitValue="Empty"/>
<li id="RingFreq" RealType="HtmlText" DescRef="vspa_RingFreq" RemarkRef="vspa_hz" ErrorMsgRef="Empty" Require="FALSE" BindField="RingFreq" InitValue="Empty"/>
<li id="OnhookTxGain" RealType="HtmlText" DescRef="vspa_OnhookTxGain" RemarkRef="vspa_uindb" ErrorMsgRef="Empty" Require="FALSE" BindField="OnhookTxGain" InitValue="Empty"/>
<li id="OnhookRxGain" RealType="HtmlText" DescRef="vspa_OnhookRxGain" RemarkRef="vspa_uindb" ErrorMsgRef="Empty" Require="FALSE" BindField="OnhookRxGain" InitValue="Empty"/>
<li id="OffhookTxGain" RealType="HtmlText" DescRef="vspa_OffhookTxGain" RemarkRef="vspa_uindb" ErrorMsgRef="Empty" Require="FALSE" BindField="OffhookTxGain" InitValue="Empty"/>
<li id="OffhookRxGain" RealType="HtmlText" DescRef="vspa_OffhookRxGain" RemarkRef="vspa_uindb" ErrorMsgRef="Empty" Require="FALSE" BindField="OffhookRxGain" InitValue="Empty"/>

<script>
var VoipConfigFormList3 = HWGetLiIdListByForm("voipadv3", null);
HWParsePageControlByID("voipadv3", TableClass, h248user, null);

var VoipAdvSetArray = new Array();
HWSetTableByLiIdList(VoipConfigFormList3, VoipAdvSetArray, null);
</script>
</table>
</form>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height10p"></td></tr>
</table>
</body>
</html>
