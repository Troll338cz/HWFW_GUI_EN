<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet" type="text/css" href='../../../Cuscss/<%HW_WEB_GetCusSource(gateway.css);%>'/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>UPnP</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>

<script language="JavaScript" type="text/javascript">

var enblMainUpnp = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_MainUPnP.Enable);%>';
var enblSlvUpnp = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_SlvUPnP.Enable);%>';

function LoadFrame()
{
	setRadio('upnpEnable', enblMainUpnp);
}

function CancelConfig()
{
	LoadFrame();
}

function ApplyConfig()
{
	setDisable('buttonCancel', 1);
    setDisable('buttonApply', 1);

	var SpecUpnpCfgParaList = new Array(new stSpecParaArray("x.Enable", getRadioVal('upnpEnable'), 0),
										new stSpecParaArray("y.Enable", getRadioVal('upnpEnable'), 0));
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = UpnpConfigFormList;
	Parameter.SpecParaPair = SpecUpnpCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'set.cgi?x=InternetGatewayDevice.X_HW_MainUPnP'
   	              + '&y=InternetGatewayDevice.X_HW_SlvUPnP' + '&RequestFile=html/bbsp/upnp/upnpTlf.asp';
				  
	HWSetAction(null, url, Parameter, tokenvalue);
};

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
	<form id="ConfigForm">
		<table border="0" cellpadding="0" cellspacing="1"  width="100%">
			<li id="upnpTitle" RealType="HorizonBar" DescRef="bbsp_title" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
			<li id="upnpInfo" RealType="HorizonBar" DescRef="bbsp_info" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty"/>
			<li id="upnpEnable" RealType="RadioButtonList" DescRef="bbsp_radioInfo" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="[{TextRef:'bbsp_enableTlf',Value:'1'},{TextRef:'bbsp_disableTlf',Value:'0'}]"/>
		</table>
		<script>
		var TableClass = new stTableClass("table_title width_per40", "table_right", "", "");
		UpnpConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
		HWParsePageControlByID("ConfigForm", TableClass, upnp_language, null);
		</script>
		<table width="100%"  cellpadding="5" cellspacing="0" class="table_button"> 
			<tr > 
				<td class="width_per25"></td> 
				<td class="pad_left5p">
					<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 
					<button name="buttonCancel" id="buttonCancel"  class="btn-default-orange-small right" onClick="CancelConfig();return false;"> <script>document.write(upnp_language['bbsp_cancelupcase']);</script></button>
					<button id="buttonApply" name="buttonApply"  class="btn-default-orange-small right" onClick="ApplyConfig();return false;"><script>document.write(upnp_language['bbsp_save']);</script></button>
				</td> 
			</tr> 
		</table> 
	</form>
	<div class="func_spread"></div>
</body>
</html>
