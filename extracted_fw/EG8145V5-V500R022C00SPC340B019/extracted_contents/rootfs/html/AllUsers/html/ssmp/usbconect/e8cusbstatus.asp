<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
function stUSBDevice(domain, DeviceList)
{
    this.domain = domain;
    this.DeviceList = DeviceList;
}

var UsbDeviceSpeed = '<%GetUSBDeviceSpeed();%>';
function displayConnState()
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
		document.write("未连接");
	}
	else
	{
		document.write("已连接");
	}
}

</script>
</head>
<body class="mainbody"> 
<div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_usb_satus_lable">在本页面上，您可以查看USB设备的连接状态。</label></div>
<div class="title_spread"></div>

<table id="table_usbstatus" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr> 
    <td width="25%" class="table_title" id="Table_usb_1_table">USB状态:</td> 
    <td width="75%" class="table_right" id="Table_usb_2_table">
	<script language="JavaScript" type="text/javascript">
	displayConnState();
	</script> </td> 
  </tr> 
</table> 
</body>
</html>
