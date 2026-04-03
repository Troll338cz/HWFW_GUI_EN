<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>Dscp to pbit mapping</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, wan_dscpmapping_language);%>"></script>
<script language="JavaScript" type="text/javascript">

function DscpInfo(domain,DscpToPbitMapping,DefaultPbit)
{
	this.domain = domain;
	this.DscpToPbitMapping = DscpToPbitMapping;
	this.DefaultPbit=DefaultPbit;
}

var GetDscpinfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.QueueManagement.X_HW_DscpToPbitMappingTable.{i}, DscpToPbitMapping|DefaultPbit, DscpInfo);%>;
GetDscpinfos.pop();
var Dscpinstance = GetDscpinfos.length;

var LanUpportFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>";
var curUserType='<%HW_WEB_GetUserType();%>';

function LoadFrame()
{
	InitValue();
	if ((curUserType != '0') && (LanUpportFlag != '1'))
	{
		setDisable('DscpToPbitMapping',1);
		setDisable('DefaultPbit',1);
		setDisable('ButtonApply',1);
		setDisable('ButtonCancel',1);
	}
}

function CheckForm()
{
	var DefaultPbit = getValue('DefaultPbit');

	if('' == DefaultPbit)
	{
		AlertEx(wan_dscpmapping_language['bbsp_defaultpri']);
		return false;
	}
	return true;
}

function GetAjaxRet(Result)
{
    var i = 0;
	var errorIndex = 'bbsp_paraerror';
	var errorCodeArray = new Array('0xf7306004');
	var errorStringArray = new Array('bbsp_dscperror');

	if(Result == '{ "result": 0 }')
	{
		window.location.href = "/html/bbsp/dscptopbit/dscptopbit.asp";
		return true;
	}
	else
	{
		var resultSpilitArray = Result.split(":");
		var resultSpilitLen = resultSpilitArray.length;

	    for(i = 0; i< resultSpilitLen; i++)
		{
			if (resultSpilitArray[i].toString().toLowerCase().indexOf("error") >= 0 )
			{
				break;
			}
		}
		if ( i == resultSpilitLen)
		{
            AlertEx(wan_dscpmapping_language[errorIndex]);
            setDisable('ButtonApply',0);
		    setDisable('ButtonCancel',0);
		    return ;
		}

		var sub = resultSpilitArray[i + 1];
		var errorcode = sub.substring(2, 12);
		for(i = 0; i < errorCodeArray.length; i++)
		{
			if (errorCodeArray[i] == errorcode)
			{
				errorIndex = errorStringArray[i];
				break;
			}
		}
		AlertEx(wan_dscpmapping_language[errorIndex]);
		setDisable('ButtonApply',0);
		setDisable('ButtonCancel',0);
	}
}

function ApplyConfig()
{
    var Result = null;
	var SubmitParaForm = 'x.DscpToPbitMapping=' + getValue('DscpToPbitMapping');

	if( true != CheckForm())
	{
		return false;
	}

	SubmitParaForm += "&x.DefaultPbit=" + getValue('DefaultPbit');
	setDisable('ButtonApply',1);
	setDisable('ButtonCancel',1);
	if (Dscpinstance == 0)
	{
		$.ajax({
		type : "POST",
		async : true,
		cache : false,
		data : SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
		url : "addajax.cgi?x=InternetGatewayDevice.QueueManagement.X_HW_DscpToPbitMappingTable&RequestFile=html/bbsp/dscptopbit/dscptopbit.asp",
		success : function(data) {
		Result = hexDecode(data);
		GetAjaxRet(Result);
	}});
	}
	else
	{
		$.ajax({
		type : "POST",
		async : true,
		cache : false,
		data : SubmitParaForm + "&x.X_HW_Token=" + getValue('onttoken'),
		url : "setajax.cgi?x="+ GetDscpinfos[0].domain+ "&RequestFile=html/bbsp/dscptopbit/dscptopbit.asp",
		success : function(data) {
		Result = hexDecode(data);
		GetAjaxRet(Result);
	}});
	}
}

function InitValue()
{
	if (Dscpinstance == 0)
	{
		setText('DscpToPbitMapping',"");
		setText('DefaultPbit',"0");
	}
	else
	{
		setText('DscpToPbitMapping',GetDscpinfos[0].DscpToPbitMapping);
		setText('DefaultPbit',GetDscpinfos[0].DefaultPbit);
	}
}

function CancelConfig()
{
	InitValue();
}

</script>
</head>

<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("dscptopbittitle", GetDescFormArrayById(wan_dscpmapping_language, "bbsp_mune"), GetDescFormArrayById(wan_dscpmapping_language, "bbsp_title_advice"), false);
</script>
<div class="title_spread"></div>
<div class="func_title"><script>document.write(wan_dscpmapping_language["bbsp_dscpmapping"]);</script></div>
<form id="DscpForm" name="DscpForm">
	<table>
	<li   id="DscpToPbitMapping"		  RealType="TextBox"		DescRef="MappingRule" 				RemarkRef="mappingExample" 					ErrorMsgRef="Empty"    Require="FALSE"	  BindField=""    InitValue="Empty"  MaxLength="256" Elementclass="width_180px restrict_dir_ltr"/>
	<li   id="DefaultPbit"             RealType="TextBox"           DescRef="DefaultPbit"          RemarkRef="Defaultmapping"              		ErrorMsgRef="Empty"    Require="TRUE"    BindField=""    InitValue="Empty" Elementclass="width_60px restrict_dir_ltr"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
		HWParsePageControlByID("DscpForm", TableClass, wan_dscpmapping_language, null);
	</script>
	<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per20'></td>
        <td class="table_submit pad_left5p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApply"  type="button" onclick="javascript:return ApplyConfig();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(wan_dscpmapping_language['bbsp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:CancelConfig();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(wan_dscpmapping_language['bbsp_cancel']);</script></button>
        </td>
    </tr>
	</table>
</form>
</body>
</html>