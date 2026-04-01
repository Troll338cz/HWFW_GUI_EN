<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" type='text/css' href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link rel="stylesheet" type='text/css' href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stRandomInformCfg(domain, Enable)
{
	this.domain = domain;
	this.Enable = Enable;
}

var temp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.ManagementServer, X_HW_RandomInformEnable, stRandomInformCfg);%>;
var RandomInformCfg = temp[0];


function setRandomInformEnable(id, flag)
{
	if ((flag != null) && (flag == 1 || flag == '1'))
	{
		document.getElementById(id + "1").checked = true;
	}
	else
	{
		document.getElementById(id + "2").checked = true;
	}
}

function getRandomInformEnable(id)
{
	if (document.getElementById(id + "1").checked)
		return 1;
	else
		return 0;
}

function LoadFrame()
{
	setRandomInformEnable("RandomInformEnable", RandomInformCfg.Enable)
}

function CheckForm()
{
	return true;
}

function CancelConfig()
{
	setRandomInformEnable("RandomInformEnable", RandomInformCfg.Enable)
}

function AddSubmitParam(SubmitForm, type)
{
	SubmitForm.addParameter('x.X_HW_RandomInformEnable', getRandomInformEnable("RandomInformEnable"));
	SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.ManagementServer'
					   + '&RequestFile=html/ssmp/tr069/randominform.asp');

	setDisable('btnApply',    1);
	setDisable('cancelValue', 1);
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">
		HWCreatePageHeadInfo("TR069", GetDescFormArrayById(Tr069LgeDes, "s0101"), GetDescFormArrayById(Tr069LgeDes, "s0e01"), false);
	</script>
	<div class="title_spread"></div>
	<form id="RandomInformEnableCfgForm">
		<table id="RandomInformEnableCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1">
			<li id="RandomInformEnable" RealType="RadioButtonList" DescRef="s0e04" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_RandomInformEnable"     
				InitValue="[{TextRef:'s0e02',Value:'Enable'},{TextRef:'s0e03',Value:'Forbid'}]"/>
		</table>
		<script>
			var RandomInformEnableCfgFormList = new Array();
			RandomInformEnableCfgFormList = HWGetLiIdListByForm("RandomInformEnableCfgForm", null);
			var TableClass = new stTableClass("width_per20", "width_per80");
			HWParsePageControlByID("RandomInformEnableCfgForm", TableClass, Tr069LgeDes, null);
		</script>
	</form>
	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
		<tr>
			<td class="table_submit width_per20"></td>
			<td class="table_submit" align="left">
				<input type="hidden" name="onttoken"    id="hwonttoken"  value="<%HW_WEB_GetToken();%>">
				<input type="button" name="btnApply"    id="btnApply"    class="ApplyButtoncss buttonwidth_150px_250px"  BindText="s0d21" onClick="Submit();">
				<input type="button" name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_150px_250px" BindText="s0d22" onClick="CancelConfig();">
			</td>
		</tr>
	</table>
	<script>
		ParseBindTextByTagName(Tr069LgeDes, "input",  2);
	</script>
</body>
</html>
