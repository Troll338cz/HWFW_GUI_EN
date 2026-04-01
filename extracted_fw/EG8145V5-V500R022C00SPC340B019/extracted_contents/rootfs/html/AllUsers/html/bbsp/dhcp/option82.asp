<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>DHCP Configure</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">

var MainDhcpOption82s = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_DHCPOption82Enable);%>';

function LoadFrame()
{
	setCheck('enableOption82', MainDhcpOption82s);
}

function CancelConfig()
{
    LoadFrame();
}

function SubmitForm()
{
	setDisable('enableOption82', 1);
	var Form = new webSubmitForm();
	
	Form.addParameter('x.X_HW_DHCPOption82Enable',getCheckVal('enableOption82'));		
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement&RequestFile=html/bbsp/dhcp/option82.asp');	
	Form.submit();	
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("dhcptitle", GetDescFormArrayById(dhcp_language, "bbsp_pl_mune"), GetDescFormArrayById(dhcp_language, ""), false);
	document.getElementById("dhcptitle_content").innerHTML += dhcp_language['bbsp_dhcp_title4'];
</script>
<div class="title_spread"></div>

<form id="FreeArpForm" name="FreeArpForm">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li id="enableOption82" RealType="CheckBox" DescRef="bbsp_enableoption82mh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_DHCPOption82Enable" InitValue="Empty"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
		var FreeArpConfigFormList = new Array();
		FreeArpConfigFormList = HWGetLiIdListByForm("FreeArpForm", null);
		HWParsePageControlByID("FreeArpForm", TableClass, dhcp_language, null);
	</script>
</form>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button" id="commosubmit">
<tr >
  <td class='width_per30'></td>
  <td class="table_submit">
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<button id="btnApply" name="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitForm(0);"><script>document.write(dhcp_language['bbsp_app']);</script></button>
	<button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px"  type="button" onClick="CancelConfig();"><script>document.write(dhcp_language['bbsp_cancel']);</script></button> </td>
</tr>
</table>
</body>
</html>
