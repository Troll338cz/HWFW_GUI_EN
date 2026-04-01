<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stUSBDevice(domain,DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

var UsbDevice = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice,DeviceList,stUSBDevice);%>;

var EnableRestore = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_Restore.Enable);%>';
var UsbRecoverInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_Restore.X_HW_BACKUPCFG.Option);%>';

var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var featurequickcfg = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_QUICKCFG);%>';
var featuregxb = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_GXBMONITOR);%>';
var featureacssupport = '<%HW_WEB_GetFeatureSupport(FT_SSMP_IACCESS_WEB_RESTORE);%>';
var cfgMode = '<%HW_WEB_GetCfgMode();%>';
var supportUsb = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_USB);%>';
var closeForceSupport = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHXCT);%>';
var forceSupport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.ForceSupport);%>';
var usb1 = "";
var usb2 = "";

var DeviceStr = "";
var DeviceArray = null;

if ( UsbDevice.length > 1 )
{
	usb1 = UsbDevice[0].DeviceList;
}

if (UsbDevice.length > 2)
{
	usb2 = UsbDevice[1].DeviceList;
}

DeviceStr = usb1 + usb2;

if (DeviceStr != '')
{
	DeviceArray = DeviceStr.split("|");
}

function MakeDeviceName(DiskName)
{
	var device = 'USB';
	return device + DiskName.substr(8);
}

function LoadFrame()
{
	if (DeviceArray == '')
	{
		setDisable('UsbbtnDown_button', 1);
	}
	
	setCheck('RecEnable_checkbox', EnableRestore);
	setCheck('RecoverOld',         UsbRecoverInfo);

	if ((curUserType == sysUserType) && (featurequickcfg == '1') && (supportUsb == '1'))
	{
		setDisplay('usbbackup', 1);
	}
	else
	{
		setDisplay('usbbackup', 0);
	}
	
	if(((cfgMode.toUpperCase() == 'AHCT') || (featuregxb == 1)) && (featureacssupport == 1))
	{
		setDisplay('openbox_display', 1);
	}
	else
	{
		setDisplay('openbox_display', 0);
	}
	if (cfgMode.toUpperCase() != 'SCSCHOOL') {
		setDisplay('restoredefault', 1);
	}
	if (closeForceSupport == 1) {
		setDisplay('closeforcesupport', 1);
	} else {
		setDisplay('closeforcesupport', 0);
	}
	if (forceSupport == 0) {
		setDisable('closeforcesupport_button', 1);
	}
}

function RestoreDefaultCfg()
{
	if (cfgMode.toUpperCase() == 'SCSCHOOL') {
		return;
	}
	if(ConfirmEx("如果您恢复了出厂配置，您的私有配置将会丢失，并且设备将会自动重启。\n确定要恢复出厂配置吗?"))
	{
		var Form = new webSubmitForm();

		setDisable('btnRestoreDftCfg',  1);
		setDisable('Restart_button',    1);
		setDisable('UsbbtnDown_button', 1);
		setDisable('Restore_button',    1);
		setDisable('openbox_button',    1);
		Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function RestoreDefaultCfgAll()
{
	var Strpop = "如果您清空了网关配置，您的私有配置和关键参数将会丢失，并且设备将会自动重启。\n确定要清空网关配置吗?";
	if (cfgMode.toUpperCase() == 'SHXCT') {
		Strpop = "如果您完全恢复了出厂配置，您的私有配置和关键参数将会丢失，并且设备将会自动重启。\n确定要完全恢复出厂配置吗?";
	}
	if(ConfirmEx(Strpop))
	{
		var Form = new webSubmitForm();

		setDisable('Restore_button',    1);
		setDisable('Restart_button',    1);
		setDisable('UsbbtnDown_button', 1);
		setDisable('btnRestoreDftCfg',  1);
		setDisable('openbox_button',    1);
		Form.setAction('restoredefaultcfgall.cgi?' + 'RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function OpenBox()
{
	if(ConfirmEx("非专业人员请谨慎进行恢复开箱操作。\n确定要进行恢复开箱操作吗?"))
	{
		var Form = new webSubmitForm();

		setDisable('Restore_button',    1);
		setDisable('Restart_button',    1);
		setDisable('UsbbtnDown_button', 1);
		setDisable('btnRestoreDftCfg',  1);
		setDisable('openbox_button',    1);
		Form.setAction('openbox.cgi?' + 'RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function WriteDeviceOption()
{
	if ((DeviceStr != '') && (DeviceStr != '/mnt/usb/pcdn|'))
	{
		for (i = 0; i < DeviceArray.length - 1; i++)
		{
			document.write('<option value="' + htmlencode(DeviceArray[i]) +'">' + htmlencode(MakeDeviceName(DeviceArray[i])) + '</option>');
		}
		return true;
	}
	else
	{
	   return false;
	}
}

function checkUsbsubarea()
{
	if ( getSelectVal('Usbsubarea_select') == "" )
	{
		AlertEx("请选择USB设备。");
		return false;
	}

	return true;
}

function RecEnableApply()
{
	var Form = new webSubmitForm();
	Form.addParameter('x.Enable', getCheckVal('RecEnable_checkbox'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_Restore' + '&RequestFile=html/ssmp/devmanage/e8cdevicemanagement.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function UsbbtnDownSubmit()
{
	if(!checkUsbsubarea())
	{
		return false;
	}
	
	var Form = new webSubmitForm();
	setDisable('Usbsubarea_select', 1);
	setDisable('UsbbtnDown_button', 1);
	setDisable('Restart_button',    1);
	setDisable('Restore_button',    1);
	setDisable('btnRestoreDftCfg',  1);
	setDisable('openbox_button',    1);
	Form.addParameter('x.Path',getSelectVal('Usbsubarea_select'));
	Form.addParameter('x.Operate',  1);
	Form.addParameter('x.Option',getCheckVal('RecoverOld'));

	Form.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_Restore.X_HW_BACKUPCFG' + '&RequestFile=html/main/backup_success.html');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function Reboot()
{
	if(ConfirmEx("确定要重启设备吗?"))
	{
		setDisable('Restart_button',    1);
		setDisable('UsbbtnDown_button', 1);
		setDisable('Restore_button',    1);
		setDisable('btnRestoreDftCfg', 1);
		setDisable('openbox_button',   1);
		var Form = new webSubmitForm();

		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
					 + '&RequestFile=html/ssmp/devmanage/e8cdevicemanagement.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function Closeforcesupport()
{
    if (ConfirmEx("扭转设备注册状态功能设备将会自动重启生效，确认扭转吗？") == false) {
        return;
    }

    if (forceSupport == 0) {
        location.reload(true);
        return;
    }
    setDisable('closeforcesupport_button', 1);
    $.ajax({
            type : "POST",
            async : true,
            cache : false,
            data : "x.X_HW_Token="+getValue('onttoken'),
            url : "closeforcesupport.cgi?&RequestFile=html/ssmp/devmanage/e8cdevicemanagement.asp",
            success : function(data) {
                location.reload(true);
            },
            complete: function (XHR, TS) {
                XHR=null;
            }
        });
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<div id = "usbbackup" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<label id="Title_usb_backup_lable">
			<div class="title_with_desc">USB备份设置</div>

			<tr>
				<td class="title_01"  style="padding-left:10px;" width="100%">在本页面上，您可以备份设备的配置文件到USB存储设备上和设置系统是否从USB存储设备快速恢复已经备份的配置文件。</td>
			</tr>
			<tr>
				<td class="title_common">
					<div>
					<table>
					<tr>
					<td class='width_13p align_left'><img style="margin-bottom:2px" src="../../../images/icon_01.gif" width="15" height="15" /></td>
					<td class='width_87p align_left'>注意：</td>
					</tr>
					</table>
					</div>
					<tr>
					<td class="title_common">请勿在USB指示灯闪烁时拔插USB设备，可能造成文件损坏。</td>
					</tr>
				</td>
			</tr>
		</label>
	</table>
<div class="title_spread"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
<tr>
	<td class="table_title" align="left" width='25%'>快速恢复：</td>
	<td class="table_right" width='75%'><input name="RecEnable_checkbox" id="RecEnable_checkbox" type="checkbox" onClick="RecEnableApply();"></td>
</tr>
<tr>
	<td class="table_title" align="left" width='25%'>覆盖备份文件：</td>
	<td class="table_right" width='75%'><input name="RecoverOld" id="RecoverOld" type="checkbox"></td>
</tr>
<tr>
	<td class="table_title width_diff7">USB分区选择：</td>
	<td class="table_right">
		<select id="Usbsubarea_select" name="Usbsubarea_select" class="width_auto">
			<script language="JavaScript" type="text/javascript">
			if (WriteDeviceOption() == false)
			{
				document.write("<option  value=\"\">" + '无usb存储分区' + "</option>");
			}
			</script>
		</select>
	</td>
	</tr>
</table>
<div class="button_spread"></div>
<div align="right" >
	 <input  class="submit"  style="width:98px" type="button" value="备份配置" name="UsbbtnDown_button" id="UsbbtnDown_button" onClick='UsbbtnDownSubmit()'></div>
 </div>
<div id="restoredefault" style="display:none">
<div class="func_spread"></div>
<div class="title_with_desc"><lable>恢复出厂设置</lable></div>
<div class="button_spread"></div>
<div class="title_01"  style="padding-left:10px;" width="100%"><lable>点击此按钮将使网关的配置恢复为出厂配置并保留关键参数。</lable></div>
<div class="button_spread"></div>
<div align="right"> <input class = "submit" name="btnRestoreDftCfg" id="btnRestoreDftCfg" type='button' style="width:98px" onClick='RestoreDefaultCfg()' value='恢复出厂设置'> </div>
</div>
<div class="func_spread"></div>
<script>
	if (cfgMode.toUpperCase() == 'SHXCT') {
		document.write('<div class="title_with_desc"><label id="Title_factoryset_backup_lable">完全恢复出厂设置</label></div>');
		document.write('<div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_factoryset_backup_tips_lable">点击此按钮将完全恢复出厂设置。</label> </div>');
		document.write('<div class="button_spread"></div>');
		document.write('<div align="right"> <input  class = "submit" name="Restore_button" id="Restore_button" type=\'button\' style="width:120px" onClick=\'RestoreDefaultCfgAll()\' value=\'完全恢复出厂设置\'> </div>');
	} else {
		document.write('<div class="title_with_desc"><label id="Title_factoryset_backup_lable">清空网关配置</label></div>');
		document.write('<div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_factoryset_backup_tips_lable">点击此按钮将清空网关配置。</label> </div>');
		document.write('<div class="button_spread"></div>');
		document.write('<div align="right"> <input  class = "submit" name="Restore_button" id="Restore_button" type=\'button\' style="width:98px" onClick=\'RestoreDefaultCfgAll()\' value=\'清空网关配置\'> </div>');
	}
</script>
<div class="func_spread"></div>
<div class="title_with_desc"><label id="Title_reboot_lable">设备重启</label></div>
<div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_reboot_tips_lable">点击如下按钮重启路由器。</label></div>
<div class="button_spread"></div>
<div align="right"><input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<input  style="width:98px" class="submit" name="Restart_button" id="Restart_button" type='button' onClick='Reboot()' value="重启"></div>
<div id = "openbox_display" style="display:none">
	<div class="func_spread"></div>
	<div class="title_with_desc"><label id="Title_openbox_lable">恢复开箱</label></div>
	<div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_openbox_tips_lable">点击如下按钮进行恢复开箱操作。</label> </div>
	<div class="button_spread"></div>
	<div align="right"> <input  class = "submit" name="openbox_button" id="openbox_button" type='button' style="width:98px" onClick='OpenBox()' value='恢复开箱'> </div>
	<div class="func_spread"></div>
</div>
<div id = "closeforcesupport" style="display:none">
    <div class="func_spread"></div>
    <div class="title_with_desc"><label id="Title_closeforcesupport_lable">扭转设备注册状态</label></div>
    <div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_closeforcesupport_tips_lable">点击如下按钮扭转设备注册状态。</label> </div>
    <div class="button_spread"></div>
    <div align="right"> <input  class = "submit" name="closeforcesupport_button" id="closeforcesupport_button" type='button' style="width:120px" onClick='Closeforcesupport()' value='扭转设备注册状态'> </div>
    <div class="func_spread"></div>
</div>
</body>
</html>
