<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" type="text/css" media="screen" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var USBFileName;

var USBInstanceID = '<%HW_WEB_GetCurAddInst();%>';
var USBROLIST = '<%HW_WEB_GetUSBDRWStatus();%>';

function GetLanguageDesc(Name)
{
	return UsbHostLgeDes[Name];
}


function stUSBDevice(domain,DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

function stRecordList(domain, Username, URL, Port, LocalPath, Status, Device, FtpClientStatus)
{
	this.domain = domain;
	this.Username = Username;
	this.URL = URL;
	this.Port = Port;
	this.LocalPath = LocalPath;
	this.Status = Status;
	this.Device = Device;
	this.FtpClientStatus = FtpClientStatus;
}

var RecordString = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.SMP.DM.FtpClient.{i},Username|URL|Port|LocalPath|Status|Device|FtpClientStatus,stRecordList);%>;

var UsbDevice = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice,DeviceList,stUSBDevice);%>;

var DownloadFileURL;

var default_path = "/mnt/usb/";


function stDownloadInfo(Domain,Username,URL,Port,LocalPath,Status,Device,FtpClientStatus)
{
	this.Domain = Domain;
	this.Username = Username;
	this.URL = URL;
	this.Port = Port;
	this.LocalPath = LocalPath;
	this.Status = Status;
	this.Device = Device;
	this.FtpClientStatus = FtpClientStatus;
}

var DownloadInfo = new stDownloadInfo("", "", "", "", "", "", "", "","");

function getUSBInstanceByID(InstanceID)
{
	var tempInstanceID = 0;
	var tempArrayRecordString;
	for(var i = 0 ; i < RecordString.length - 1 ; i++)
	{
		tempArrayRecordString= RecordString[i].domain.split(".");
		tempInstanceID = tempArrayRecordString[tempArrayRecordString.length-1];
		if(tempInstanceID == InstanceID)
		{
			return RecordString[i];
		}
	}

	return null;
}


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


function isSafeCharSN(val)
{
	if ( ( val == '<' )
	  || ( val == '>' )
	  || ( val == '\'' )
	  || ( val == '\"' )
	  || ( val == '#' )
	  || ( val == '{' )
	  || ( val == '}' )
	  || ( val == '\\' )
	  || ( val == '|' )
	  || ( val == '^' )
	  || ( val == '[' )
	  || ( val == ']' ) )
	{
		return false;
	}

	return true;
}

function isSafeStringSN(val)
{
	if ( val == "" )
	{
		return false;
	}

	for ( var j = 0 ; j < val.length ; j++ )
	{
		if ( !isSafeCharSN(val.charAt(j)) )
		{
			return false;
		}
	}

	return true;
}



function CheckUSBFileIsExist()
{
	var SaveAsPath = getValue('SaveAsPath_text');
	var DevicePath = default_path + SaveAsPath;

	DevicePath += '/';
	var DownloadFilePath = getValue('DownloadFilePath_text');
	if(DownloadFilePath.indexOf('/') >= 0)
	{
		var tepDownloadFilePath = DownloadFilePath.split("/");
		tepDownloadFilePath = tepDownloadFilePath[tepDownloadFilePath.length-1];
		DevicePath = DevicePath + tepDownloadFilePath;
	}
	else
	{
		DevicePath = DevicePath + DownloadFilePath;
	}

	var CheckResult =0;
	$.ajax(
	{
		type : "POST",
		async : false,
		cache : false,
		url : "../common/CheckUSBFileExist.asp?&1=1",
		data :'USBFileInfo='+encodeURIComponent(DevicePath),
		success : function(data) {
			CheckResult=data;
		}
	});

	if (CheckResult==1)
	{
		if(!ConfirmEx(UsbHostLgeDes["s0533"]))
		{
			return false;
		}
	}

	return true;
}


function checkFtpDownloadInfo()
{
	with( document.forms[0] )
	{
		if (ServerUrl_text.value == '' || ServerUrl_text.value.substr(0,6) != "ftp://" || ServerUrl_text.value.length <= 6)
		{
			AlertEx("服务器地址无效。");
			return false;
		}

		if (!isSafeStringSN(ServerUrl_text.value))
		{
			AlertEx("服务器地址不能包含下列字符：\"<, >, \', \", {, }, [, ],\\, ^, #, |\".");
			return false;
		}

		var info = parseFloat(ServerPort_text.value );
		if (info < 1 || info > 65535)
		{
			AlertEx("端口无效，请输入1～65535的一个端口。");
			return false;
		}

		if (!isValidPort(ServerPort_text.value))
		{
			AlertEx('端口号无效。');
			return false;
		}

		if (UserName_text.value.length > 255)
		{
			AlertEx("用户名太长，不能超过255个字符。");
			return false;
		}
		if (isValidString(UserName_text.value) == false )
		{
			AlertEx("请输入有效用户名。");
			return false;
		}

		for (var iTemp = 0; iTemp < UserName_text.value.length; iTemp ++)
		{
			if (UserName_text.value.charAt(iTemp) == ' ')
			{
				AlertEx("用户名不能有空格。");
				return false;
			}
		}

		if( (32 == UserPass_password.value.length) &&  ("********************************" == UserPass_password.value))
		{
			AlertEx("请重新输入密码。");
			setText('UserPass_password',"");
			UserPass_password.focus();
			return false;
		}

		if (UserPass_password.value.length > 255)
		{
			AlertEx("密码太长。");
			return false;
		}
		if ( isValidString(UserPass_password.value) == false )
		{
			AlertEx("密码无效。");
			return false;
		}

		//文件下载路径
		if ( DownloadFilePath_text.value == '' )
		{
			AlertEx("文件下载路径不能为空。");
			return false;
		}

		var ServerPos;
		var URLValue = ServerUrl_text.value;
		if(URLValue.charAt(URLValue.length-1)!='/')
		{
			URLValue += '/' ;
		}

		DownloadFileURL = URLValue + DownloadFilePath_text.value;

		if(DownloadFileURL.length > 255)
		{
			AlertEx("路径太长。");
			return false;
		}

		if(DownloadFileURL.charAt(DownloadFileURL.length-1)=='/')
		{
			AlertEx("文件下载路径无效。");
			return false;
		}

		if (!isSafeStringSN(DownloadFileURL))
		{
			AlertEx("文件下载路径不能包含空格和下列字符：\"<, >, \', \", {, }, [, ], %, \\, ^, #, |\".");
			return false;
		}

		ServerPos=DownloadFileURL.substr(6,DownloadFileURL.length);

		if(ServerPos.indexOf('/')<=0)
		{
			AlertEx("文件下载路径无效。");
			return false;
		}
		else
		{
			USBFileName=ServerPos.substr(ServerPos.indexOf('/')+1,ServerPos.length);
			if(USBFileName=='')
			{
				AlertEx("文件下载路径无效。");
				return false;
			}
		}

		//文件保存路径
		if ( SaveAsPath_text.value == '' )
		{
			AlertEx("文件保存路径不能为空。");
			return false;
		}
	}

	if(!CheckUSBFileIsExist())
	{
		return false;
	}

	return true;

}

function StartDownloadSubmit()
{
	var Ret = checkFtpDownloadInfo();
	if( false == Ret )
	{
		return;
	}

	var Form = new webSubmitForm();

	setDisable('Btn_StartDownload_button',1);

	Form.usingPrefix('x');

	//按通用ftp方式提交
	var FtpUsername = getValue('UserName_text');
	var SaveAsPath = getValue('SaveAsPath_text');
	var tmpDevicePath = SaveAsPath.split("/");
	var DevicePath = default_path + tmpDevicePath[1];
	var tmpLocalPath = '/' + tmpDevicePath[1];
	tmpLocalPath +='/';

	var LocalPath = SaveAsPath.substr(tmpLocalPath.length, SaveAsPath.length);
	if(LocalPath != "")
	{
		LocalPath +='/';
	}
	var DownloadFilePath = getValue('DownloadFilePath_text');

	if(DownloadFilePath.indexOf('/') >= 0)
	{
		var tepDownloadFilePath = DownloadFilePath.split("/");
		tepDownloadFilePath = tepDownloadFilePath[tepDownloadFilePath.length-1];
		LocalPath = LocalPath + tepDownloadFilePath;
	}
	else
	{
		LocalPath = LocalPath + DownloadFilePath;
	}

	if(LocalPath.length > 64 || DevicePath.length > 32)
	{
		AlertEx("文件保存路径太长。");
		return;
	}

	var URLPath =DownloadFileURL.toString().replace(/%20/g, " ");
	Form.addParameter('URL',URLPath);

	if (getCheckVal("HiddenName_checkbox") == 1)
	{
		Form.addParameter('Username',"Anonymous");
		Form.addParameter('Userpassword',"");
	}
	else
	{
		Form.addParameter('Username',FtpUsername);
		Form.addParameter('Userpassword',getValue('UserPass_password'));
	}

	Form.addParameter('Port',getValue('ServerPort_text'));
	Form.addParameter('Device',DevicePath);

	Form.addParameter('LocalPath',LocalPath);

	Form.endPrefix();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.FtpClient&'
				 + 'RequestFile=html/ssmp/usbftp/e8cusbhost.asp');

	Form.submit();
}

function RefreshDownloadSubmit()
{
	window.location="/html/ssmp/usbftp/e8cusbhost.asp";
}

function CancelDownloadSubmit()
{
	var Form = new webSubmitForm();
	Form.addParameter('x.FtpClientStop',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.FtpClient.' + USBInstanceID + '&RequestFile=html/ssmp/usbftp/e8cusbhost.asp');
	Form.submit();

}

function HiddenNameLogin()
{
	if (getCheckVal("HiddenName_checkbox") == 1)
	{
		setText('UserName_text',        "");
		setText('UserPass_password',    "");
		setDisable('UserName_text',     1);
		setDisable('UserPass_password', 1);
	}
	else
	{
		if( DownloadInfo!= null)
		{
			if("Anonymous" != DownloadInfo.Username)
			{
				setText('UserName_text',     DownloadInfo.Username);
				setText('UserPass_password', "********************************");
			}
		}

		setDisable('UserName_text',     0);
		setDisable('UserPass_password', 0);
	}
}

function GetUSBRoInfoText()
{
	if(((USBROLIST.indexOf("USB") > -1) || (USBROLIST.indexOf("usb") > -1))
	   && (USBROLIST.indexOf("SD_card") > -1) )
	{
		return UsbHostLgeDes["s0542"];
	}
	else if(USBROLIST.indexOf("SD_card") > -1)
	{
		return UsbHostLgeDes["s0541"];
	}
	else
	{
		return UsbHostLgeDes["s0540"];
	}
}

function LoadFrame()
{
	DownloadInfo = getUSBInstanceByID(USBInstanceID);
	if( DownloadInfo!= null)
	{
		var DownloadInfoRUL = DownloadInfo.URL.substr(0, DownloadInfo.URL.lastIndexOf('/'));
		var DownloadInfoLocalPath = DownloadInfo.URL.substr(DownloadInfo.URL.lastIndexOf('/')+1, DownloadInfo.URL.length);
		var SaveAsPath = DownloadInfo.Device.substr(default_path.length-1,DownloadInfo.Device.length+1);

		var LocalPathFile = DownloadInfo.LocalPath.substr(0, DownloadInfo.LocalPath.lastIndexOf('/'));
		if(LocalPathFile != "")
		{
			SaveAsPath += "/";
		}

		SaveAsPath = SaveAsPath + LocalPathFile;

		setText('ServerUrl_text',  DownloadInfoRUL);
		setText('ServerPort_text', DownloadInfo.Port);

		if ("Anonymous" == DownloadInfo.Username )
		{
			setCheck('HiddenName_checkbox', 1);
			setText('UserName_text',        "");
			setText('UserPass_password',    "");
			setDisable('UserName_text',     1);
			setDisable('UserPass_password', 1);
		}
		else
		{
			setText('UserName_text',     DownloadInfo.Username);
			setText('UserPass_password', "********************************");
		}
		setText('DownloadFilePath_text', DownloadInfoLocalPath);
		setText('SaveAsPath_text',       SaveAsPath);

		if( 0 == DownloadInfo.FtpClientStatus)
		{
			document.getElementById("DownloadState_text").innerHTML = "未下载";
			setDisable('Btn_CancelDownload_button', 1);
		}
		else if( 1 == DownloadInfo.FtpClientStatus)
		{
			document.getElementById("DownloadState_text").innerHTML = "下载中";
			setDisable('Btn_StartDownload_button',  1);
		}
		else if( 2 == DownloadInfo.FtpClientStatus)
		{
			document.getElementById("DownloadState_text").innerHTML = "下载完成";
			setDisable('Btn_CancelDownload_button', 1);
		}
		else
		{
			document.getElementById("DownloadState_text").innerHTML = "";
			setDisable('Btn_CancelDownload_button', 1);
		}
	}
	else
	{
		document.getElementById("DownloadState_text").innerHTML = "未下载";
		setDisable('Btn_CancelDownload_button',     1);
	}
	
	if("OK" != USBROLIST)
	{
		AlertEx(GetUSBRoInfoText());
	}
}

</script>
<style type="text/css">
input .UserInput{
	width:160px;
}

input .UserPort{
	width:40px;
}
</style>
</head>

<body class="mainbody" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">
		var UsbSummaryArray = new Array(new stSummaryInfo("text",  GetDescFormArrayById(UsbHostLgeDes, "s0101")),
										new stSummaryInfo("img",  "../../../images/icon_01.gif", GetDescFormArrayById(UsbHostLgeDes, "s0531")),
										new stSummaryInfo("text", GetDescFormArrayById(UsbHostLgeDes, "s0532")),
										null);
		HWCreatePageHeadInfo("usbinfo", GetDescFormArrayById(UsbHostLgeDes, "s0518"), UsbSummaryArray, true);
	</script>
	<div class="title_spread"></div>
	<form id="ConfigForm" action="">
		<table id="table_downloadinfo" width="100%" cellspacing="1" cellpadding="0">
			<li id="DownloadTransports_Value_select" RealType="DropDownList" DescRef="s0102" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="[{TextRef:'s010e', Value:'FTP'}]"/>
			<li id="ServerUrl_text"                  RealType="TextBox"      DescRef="s0103" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="256"     ElementClass="UserInput" InitValue="Empty"/>
			<li id="ServerPort_text"                 RealType="TextBox"      DescRef="s051a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="5"       ElementClass="UserPort"  InitValue="Empty"/>
			<li id="HiddenName_checkbox"             RealType="CheckBox"     DescRef="s0105" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"   ClickFuncApp="onClick=HiddenNameLogin"/>
			<li id="UserName_text"                   RealType="TextBox"      DescRef="s051b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="255"      ElementClass="UserInput" InitValue="Empty"/>
			<li id="UserPass_password"               RealType="TextBox"      DescRef="s051c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="255"      ElementClass="UserInput" InitValue="Empty"/>
			<li id="DownloadFilePath_text"           RealType="TextBox"      DescRef="s0108" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="256"     ElementClass="UserInput" InitValue="Empty"/>
			<li id="SaveAsPath_text"                 RealType="TextOtherBox" DescRef="s0109" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"  BindField="Empty" MaxLength="256"     ElementClass="UserInput" disabled="disabled" InitValue="[{Item:[{AttrName:'id', AttrValue:'UrlBase'},{AttrName:'type', AttrValue:'text'}, {AttrName:'style', AttrValue:'display:none'}, {AttrName:'maxlength', AttrValue:'256'}]},{Item:[{AttrName:'id', AttrValue:'SaveAsPath_button'},{AttrName:'name', AttrValue:'SaveAsPath_button'},{AttrName:'type', AttrValue:'button'}, {AttrName:'class', AttrValue:'CancleButtonCss browserbutton thickbox'}, {AttrName:'value', AttrValue:'s1605'}, {AttrName:'title', AttrValue:'s1436'}, {AttrName:'alt', AttrValue:'../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true'}]}]"/>
			<li id="DownloadState_text"              RealType="HtmlText"     DescRef="s010a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
		</table>
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
			var TableClass = new stTableClass("width_per30", "width_per70");
			var formid_hide_id = null;
			HWParsePageControlByID("ConfigForm", TableClass, UsbHostLgeDes, formid_hide_id);
			document.getElementById("ServerUrl_text").value = "ftp://";
			document.getElementById("ServerPort_text").value = "21";
		</script>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button">
			<tr align="right">
				<td class="table_submit width_25p"></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
					<input type="button" name="Btn_StartDownload_button"   id="Btn_StartDownload_button"   class="ApplyButtoncss buttonwidth_100px"  BindText="s010b" onClick='StartDownloadSubmit()'>
					<input type="button" name="Btn_RefreshDownload_button" id="Btn_RefreshDownload_button" class="CancleButtonCss buttonwidth_100px" BindText="s010c" onClick='RefreshDownloadSubmit()'>
					<input type="button" name="Btn_CancelDownload_button"  id="Btn_CancelDownload_button"  class="CancleButtonCss buttonwidth_100px" BindText="s010d" onClick='CancelDownloadSubmit()'>
				</td>
			</tr>
		</table>
	</form>
	<div class="func_spread"></div>
	<script>
		ParseBindTextByTagName(UsbHostLgeDes, "td",    1);
		ParseBindTextByTagName(UsbHostLgeDes, "input", 2);
	</script>
</body>
</html>
