<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stUSBDevice(domain, DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

var UsbDeviceSpeed = '<%GetUSBDeviceSpeed();%>';

function GetLanguageDesc(Name)
{
	return UsbstatusLgeDes[Name];
}

function getConnValue()
{
	var i, speed;
	var connected = false;
	var UsbDeviceSpeeds = UsbDeviceSpeed.split('|');
	
	for (i=0; i<UsbDeviceSpeeds.length; i++)
	{
		speed = parseInt(UsbDeviceSpeeds[i]);
		if (!isNaN(speed) && speed > 0)
		{
			connected = true;
			break;
		}
	}
	
	if (!connected)
	{
		return UsbstatusLgeDes["s0403"];
	}
	else
	{
		return UsbstatusLgeDes["s0404"];
	}
}

</script>
</head>

<body class="mainbody">
	<script language="JavaScript" type="text/javascript">
		HWCreatePageHeadInfo("USBStatus", GetDescFormArrayById(UsbstatusLgeDes, "s0405"), GetDescFormArrayById(UsbstatusLgeDes, "s0401"), false);
	</script>
	<div class="title_spread"></div>
	<form id="UsbConnStatusForm">
		<table id="UsbConnStatusShowPanel" width="100%" cellspacing="1" cellpadding="0">
			<li id="USBConValue" RealType="HtmlText" DescRef="s0402" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Status" InitValue="Empty" />
		</table>
		<script>
			var UsbStatusFormList = new Array();
			var TableClass = new stTableClass("width_per25", "width_per75");
			UsbStatusFormList = HWGetLiIdListByForm("UsbConnStatusForm", null);

			HWParsePageControlByID("UsbConnStatusForm", TableClass, UsbstatusLgeDes, null);

			var UsbStatusArray = new Array();
			UsbStatusArray["Status"] = getConnValue();

			HWSetTableByLiIdList(UsbStatusFormList, UsbStatusArray, null);
		</script>
	</form>
	<script>
	</script>
</body>
</html>
