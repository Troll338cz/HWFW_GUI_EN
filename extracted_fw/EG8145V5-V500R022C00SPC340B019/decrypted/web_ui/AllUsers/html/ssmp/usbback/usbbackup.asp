<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function GetLanguageDesc(Name)
{
	return UsbBackupLgeDes[Name];
}


function stUSBDevice(domain,DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

function stFileFlag(name, ExistFlag)
{
	this.name = name;
	this.ExistFlag = ExistFlag;
}


var UsbDevice = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice,DeviceList,stUSBDevice);%>;

var EnableRestore = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_Restore.Enable);%>';
var UsbRecoverInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_Restore.X_HW_BACKUPCFG.Option);%>';

var usb1 = null;
var usb2 = null;

var DeviceStr = null;
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

if(DeviceStr != '')
{
	DeviceArray = DeviceStr.split("|");
}

function MakeDeviceName(DiskName)
{
	var device = 'USB';
	return device + DiskName.substr(8);
}

function WriteDeviceOption(id)
{
	var select = document.getElementById(id);

	if (DeviceStr != 'null')
	{
		for (var i in DeviceArray)
		{
			var opt = document.createElement('option');
			var html = document.createTextNode(MakeDeviceName(DeviceArray[i]));
			opt.value = DeviceArray[i];
			opt.appendChild(html);
			select.appendChild(opt);
		}
		return true;
	}
	else
	{
		var opt = document.createElement('option');
		var html = document.createTextNode(UsbBackupLgeDes['s052e']);
		opt.value = '';
		opt.appendChild(html);
		select.appendChild(opt);
		return false;
	}
}

function LoadFrame()
{
	if (DeviceArray == '') btnDown.disabled = true;
}

function checkFtpClient()
{
	if ( getSelectVal('ClDevType') == "" )
	{
		AlertEx(GetLanguageDesc("s0801"));
		return false;
	}

	return true;
}

function CheckForm()
{
	return checkFtpClient();
}

function AddSubmitParam(Form, type)
{
	setDisable('ClDevType', 1);
	setDisable('LocalPath', 1);
	setDisable('btnDown',   1);

	Form.addParameter('x.Operate', 1);
	Form.addParameter('x.Path',    getSelectVal('ClDevType'));
	Form.addParameter('x.Option',  getCheckVal('RecoverOld'));

	Form.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_Restore.X_HW_BACKUPCFG' + '&RequestFile=html/main/backup_success.html');
}

function LoadEnableFrame()
{
	if ( EnableRestore != '' )
	{
		setCheck('Enable', EnableRestore);
	}
}

function CheckEnableForm()
{
	setDisable('btnApply',    1);
	setDisable('cancelValue', 1);
	return true;
}

function CancelConfig()
{
	LoadEnableFrame();
}

function SubmitApply()
{
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.addParameter('x.Enable',     getCheckVal('Enable'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_Restore' + '&RequestFile=html/ssmp/usbback/usbbackup.asp');
	Form.submit();
}

var TableClass = new stTableClass("width_per35", "width_per65");
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">
		var UsbBackupArray = new Array(new stSummaryInfo("text", GetDescFormArrayById(UsbBackupLgeDes, "s0803")),
									   new stSummaryInfo("img", "../../../images/icon_01.gif", GetDescFormArrayById(UsbBackupLgeDes, "s0531")),
									   new stSummaryInfo("text", GetDescFormArrayById(UsbBackupLgeDes, "s0532")),
									   null);
		HWCreatePageHeadInfo("usbbackupinfo", GetDescFormArrayById(UsbBackupLgeDes, "s0808"), UsbBackupArray, true);
	</script>
	<div class="title_spread"></div>
	<div class="func_title" BindText="s0804"></div>
	<form id="UsbBackup">
		<table id="UsbBackupPanel" width="100%" cellspacing="1" cellpadding="0">
			<li id="Enable" RealType="CheckBox" DescRef="s0805" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Enable" InitValue="Empty"/>
		</table>
		<script>
			var UsbBackupFormList = new Array();
			UsbBackupFormList = HWGetLiIdListByForm("UsbBackup", null);

			HWParsePageControlByID("UsbBackup", TableClass, UsbBackupLgeDes, null);

			var UsbBackupArray = new Array();
			UsbBackupArray["Enable"] = EnableRestore;

			HWSetTableByLiIdList(UsbBackupFormList, UsbBackupArray, null);
		</script>
	</form>
	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
		<tr>
			<td class="table_submit width_per35"></td>
			<td class="table_submit">
				<input type="hidden" name="onttoken"    id="hwonttoken"   value="<%HW_WEB_GetToken();%>" />
				<input type="button" name="btnApply"    id="btnApply"     class="ApplyButtoncss  buttonwidth_100px" BindText="s0806" onClick="SubmitApply();" />
				<input type="button" name="cancelValue" id="cancelValue2" class="CancleButtonCss buttonwidth_100px" BindText="s0807" onClick="CancelConfig();" />
			</td>
		</tr>
	</table>

	<div class="func_spread"></div>
	<div class="func_title" BindText="s0808"></div>
	<form id="UsbRestore">
		<table id="UsbRestorePanel" width="100%" cellspacing="1" cellpadding="0">
			<li id="RecoverOld" RealType="CheckBox"     DescRef="s080b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="UsbRecoverInfo" InitValue="Empty"/>
			<li id="ClDevType"  RealType="DropDownList" DescRef="s0809" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"          InitValue="Empty" Elementclass="width_auto"/>
		</table>
		<script>
			var UsbRestoreFormList = HWGetLiIdListByForm("UsbRestore", null);

			HWParsePageControlByID("UsbRestore", TableClass, UsbBackupLgeDes, null);

			var UsbRestoreArray = new Array();
			UsbRestoreArray["UsbRecoverInfo"] = UsbRecoverInfo;

			HWSetTableByLiIdList(UsbRestoreFormList, UsbRestoreArray, null);
			WriteDeviceOption('ClDevType');
		</script>
	</form>
	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
		<tr>
			<td class="table_submit width_per35"></td>
			<td class="table_submit">
				<input type="button" name="btnDown" id="btnDown" class="CancleButtonCss filebuttonwidth_150px_250px" BindText="s080a" onClick='Submit()'>
			</td>
		</tr>
	</table>
	<script>
		ParseBindTextByTagName(UsbBackupLgeDes, "div",    1);
		ParseBindTextByTagName(UsbBackupLgeDes, "td",     1);
		ParseBindTextByTagName(UsbBackupLgeDes, "input",  2);
	</script>
</body>
</html>
