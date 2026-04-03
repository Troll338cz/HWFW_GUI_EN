<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link type='text/css' rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link type='text/css' rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" type="text/css" media="screen" />
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var USBFileName;
var USBROLIST = '<%HW_WEB_GetUSBDRWStatus();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
function GetLanguageDesc(Name)
{
	return UsbHostLgeDes[Name];
}

function stUSBDevice(domain,DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

var UsbDevice = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice,DeviceList,stUSBDevice);%>;


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
	var device = DiskName.split("/");
	return device[3];
}

function init()
{
	with(document.forms[0])
	{
		if (DeviceArray == '')
			btnDown.disabled = true;
	}
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

function WriteDeviceOption(id)
{
	var select = document.getElementById(id);

	if (DeviceStr != 'null')
	{
		for (var i in DeviceArray)
		{
			if ((DeviceArray[i] == 'null')
				|| (DeviceArray[i] == 'undefined'))
				continue;
			var opt = document.createElement('option');
			var html = document.createTextNode(MakeDeviceName(DeviceArray[i]));
			opt.value = DeviceArray[i] + '/';
			opt.appendChild(html);
			select.appendChild(opt);
		}
		return true;
	}
	else
	{
		var opt = document.createElement('option');
		var html = document.createTextNode(UsbHostLgeDes['s052e']);
		opt.value = '';
		opt.appendChild(html);
		select.appendChild(opt);
		return false;
	}
}

function setControl(index, id)
{
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
	init();
	if("OK" != USBROLIST)
	{
		AlertEx(GetUSBRoInfoText());
	}
}

function checkFtpURL()
{
	var ServerPos;
	var URLValue = document.getElementById('URL').value;

	if (URLValue == '' || URLValue.substr(0, 6) != "ftp://" || URLValue.length <= 6)
	{
		AlertEx(UsbHostLgeDes["s050a"]);
		return false;
	}

	if (!isSafeStringSN(URLValue))
	{
		AlertEx(UsbHostLgeDes["s0534"]);
		document.getElementById('URL').focus();
		return false;
	}

	if(URLValue.charAt(URLValue.length - 1) == '/')
	{
		AlertEx(UsbHostLgeDes["s050a"]);
		return false;
	}

	ServerPos=URLValue.substr(6, URLValue.length);
	if(ServerPos.indexOf('/') <= 0)
	{
		AlertEx(UsbHostLgeDes["s050a"]);
		return false;
	}
	else
	{
		USBFileName = ServerPos.substr(ServerPos.indexOf('/') + 1,ServerPos.length);
		if (USBFileName == '')
		{
			AlertEx(UsbHostLgeDes["s050a"]);
			return false;
		}
		return true;
	}
}

if (ProductType == '2')
{
	function CheckUSBFileIsExist()
	{
		var USBFileLocalPath = document.getElementById('LocalPath').value;
		var CheckResult = 0;
		var USBFileInfo;

		if(USBFileLocalPath == '')
		{
			USBFileInfo = getSelectVal('ClDevType')+USBFileName;
		}
		else
		{
			USBFileInfo = getSelectVal('ClDevType')+USBFileLocalPath;
		}

		$.ajax(
		{
			type : "POST",
			async : false,
			cache : false,
			url : "../common/CheckUSBFileExist.asp?&1=1",
			data :'USBFileInfo=' + USBFileInfo,
			success : function(data) {
				CheckResult = data;
			}
		});

		if (CheckResult == 1)
		{
			if (!ConfirmEx(UsbHostLgeDes["s0533"]))
			{
				return false;
			}
		}

		return true;
	}
}
else
{
	function CheckUSBFileIsExist()
	{
		var USBFileLocalPath = document.getElementById('SaveAsPath_text').value;
		var CheckResult = 0;
		var USBFileInfo = '/mnt/usb' + USBFileLocalPath +'/' + USBFileName;

		$.ajax(
		{
			type : "POST",
			async : false,
			cache : false,
			url : "../common/CheckUSBFileExist.asp?&1=1",
			data :'USBFileInfo=' + encodeURIComponent(USBFileInfo),
			success : function(data) {
				CheckResult = data;
			}
		});

		if (CheckResult == 1)
		{
			if (!ConfirmEx(UsbHostLgeDes["s0533"]))
			{
				return false;
			}
		}

		return true;
	}
}


function CheckUSBFileIsExist_xd()
{
	var USBFileLocalPath = document.getElementById('LocalPath').value;
	var CheckResult = 0;
	var USBFileInfo;

	if(USBFileLocalPath == '')
	{
		USBFileInfo = getSelectVal('ClDevType')+USBFileName;
	}
	else
	{
		USBFileInfo = getSelectVal('ClDevType')+USBFileLocalPath;
	}

	$.ajax(
	{
		type : "POST",
		async : false,
		cache : false,
		url : "../common/CheckUSBFileExist.asp?&1=1",
		data :'USBFileInfo=' + USBFileInfo,
		success : function(data) {
			CheckResult = data;
		}
	});

	if (CheckResult == 1)
	{
		if (!ConfirmEx(UsbHostLgeDes["s0533"]))
		{
			return false;
		}
	}

	return true;
}

function checkFtpClient()
{
	with( document.forms[0] )
	{
		if ( (Port.value !='') &&(isNaN(parseInt(Port.value )) == true))
		{
			AlertEx(GetLanguageDesc("s0501"));
			return false;
		}
		var info = parseFloat(Port.value );
		if (info < 1 || info > 65535)
		{
			AlertEx(GetLanguageDesc("s0502"));
			return false;
		}

		if (Username.value.length > 255)
		{
			AlertEx(GetLanguageDesc("s0503"));
			return false;
		}
		if (isValidString(Username.value) == false )
		{
			msg = GetLanguageDesc("s0504");
			AlertEx(msg);
			return false;
		}

		for (var iTemp = 0; iTemp < Username.value.length; iTemp ++)
		{
			if (Username.value.charAt(iTemp) == ' ')
			{
				AlertEx(GetLanguageDesc("s0505"));
				return false;
			}
		}

		if (Userpassword.value.length > 255)
		{
			AlertEx(GetLanguageDesc("s0506"));
			return false;
		}
		if ( isValidString(Userpassword.value) == false )
		{
			msg = GetLanguageDesc("s0507");
			AlertEx(msg);
			return false;
		}

		var tmp = SaveAsPath_text.value;
		if (tmp.length > 255)
		{
			AlertEx(GetLanguageDesc("s0508"));
			return false;
		}
		if (tmp.indexOf("..") >= 0 || tmp == '\\' || tmp.charAt(0) == '/'
			|| tmp.charAt(tmp.length-1) == '/')		
		{
			msg = GetLanguageDesc("s0509");
			AlertEx(msg);
			return false;
		}

		if(checkFtpURL()==false)
		{
			return;
		}

		if ( getSelectVal('ClDevType') == "" )
		{
			AlertEx(GetLanguageDesc("s050c"));
			return false;
		}
	}

	if(!CheckUSBFileIsExist())
	{
		return false;
	}
	return true;

}

function CheckForm()
{
	return checkFtpClient();
}

function AddSubmitParam(Form,type)
{
	setDisable('ClDevType', 1);
	setDisable('SaveAsPath_text', 1);
	setDisable('btnDown',   1);

	var tmp = getValue('URL');
	var URLPath = tmp.toString().replace(/%20/g, " ");

	Form.usingPrefix('x');

	Form.addParameter('Username',     getValue('Username'));
	Form.addParameter('Userpassword', getValue('Userpassword'));
	Form.addParameter('URL',          URLPath);
	var NullCheckValue = getValue('Port');
	if(NullCheckValue != '')
	{
		Form.addParameter('Port', getValue('Port'));
	}
	var savepath = getValue('SaveAsPath_text');
	
	if( undefined != savepath.split("/")[2])
	{
		var Devicepath = '/mnt/usb/' +savepath.split("/")[1] +'/';
	}
	else
	{
		var Devicepath = '/mnt/usb/' +savepath.split("/")[1];
	}
	
	var LocalPath = savepath.substr(savepath.split("/")[1].length + 2,savepath.length);
	LocalPath = LocalPath +"/"+ USBFileName;

	Form.addParameter('Device',  Devicepath);
	Form.addParameter('LocalPath', LocalPath);
	Form.endPrefix();
	Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.FtpClient&'
				 + 'RequestFile=html/ssmp/usbftp/usbhostrds.asp');
}

function stDownloadInfo(Domain,Username,URL,Port,LocalPath,Status,Device)
{
	this.Domain = null;
	this.Username = null;
	this.URL = null;
	this.Port = null;
	this.LocalPath = null;
	this.Status = null;
	this.Device = null;
}

function stRecordList(domain, Username, URL, Port, LocalPath, Status, Device)
{
	this.domain = domain;
	this.Username = Username;
	this.URL = URL;
	this.Port = Port;
	this.LocalPath = LocalPath;
	this.Status = Status;
	this.Device = Device;
}

var RecordString = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.SMP.DM.FtpClient.{i},Username|URL|Port|LocalPath|Status|Device,stRecordList);%>;

var DownloadInfo = new Array();

CreateUsbRecord();

function CreateUsbRecord()
{
	for (i = 0; i < RecordString.length - 1; i++)
	{
		DownloadInfo[i] = new stDownloadInfo();
		if (RecordString[i].LocalPath.replace(/(^\s*)|(\s*$)/g, "") == '')
		{
			var pos = RecordString[i].URL.lastIndexOf('/');
			RecordString[i].LocalPath = RecordString[i].Device + RecordString[i].URL.substr(pos + 1, RecordString[i].URL.length - pos -1);
		}
		else
		{
			RecordString[i].LocalPath = RecordString[i].Device + RecordString[i].LocalPath;
		}
		DownloadInfo[i] = RecordString[i];
	}
}

var TableClass = new stTableClass("width_per25", "width_per75");
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
		var UsbSummaryArray = new Array(new stSummaryInfo("text",  GetDescFormArrayById(UsbHostLgeDes, "s0519")),
										new stSummaryInfo("img",  "../../../images/icon_01.gif", GetDescFormArrayById(UsbHostLgeDes, "s0531")),
										new stSummaryInfo("text", GetDescFormArrayById(UsbHostLgeDes, "s0532")),
										null);
		HWCreatePageHeadInfo("usbinfo", GetDescFormArrayById(UsbHostLgeDes, "s0518"), UsbSummaryArray, true);
	</script>
	<div class="title_spread"></div>
	<form id="ConfigForm" action="">
		<table id="table_downloadinfo" width="100%" cellspacing="1" cellpadding="0">
			<li id="URL"          RealType="TextBox"      DescRef="s052f" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="256"   ElementClass="UserInput" InitValue="Empty"/>
			<li id="Port"         RealType="TextBox"      DescRef="s051a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="5"     ElementClass="UserPort"  InitValue="Empty"/>
			<li id="Username"     RealType="TextBox"      DescRef="s051b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="255"    ElementClass="UserInput" InitValue="Empty"/>
			<li id="Userpassword" RealType="TextBox"      DescRef="s051c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="255"    ElementClass="UserInput" InitValue="Empty"/>
			<li id="SaveAsPath_text"    RealType="TextOtherBox" DescRef="s051e" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="Empty" MaxLength="256"    ElementClass="UserInput" disabled="disabled" InitValue="[{Item:[{AttrName:'id', AttrValue:'UrlBase'},{AttrName:'type', AttrValue:'text'}, {AttrName:'style', AttrValue:'display:none'}, {AttrName:'maxlength', AttrValue:'256'}]},{Item:[{AttrName:'id', AttrValue:'SaveAsPath_button'},{AttrName:'name', AttrValue:'SaveAsPath_button'},{AttrName:'type', AttrValue:'button'}, {AttrName:'class', AttrValue:'CancleButtonCss browserbutton thickbox'}, {AttrName:'value', AttrValue:'s1605'}, {AttrName:'title', AttrValue:'s1436'}, {AttrName:'alt', AttrValue:'../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true'}]}]"/>
		</table>
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
			var formid_hide_id = null;

			HWParsePageControlByID("ConfigForm", TableClass, UsbHostLgeDes, formid_hide_id);

			document.getElementById("URL").value = "ftp://";
			document.getElementById("Port").value = "21";
		</script>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
					<input type="button" name="btnDown"  id="btnDown" class="ApplyButtoncss pix_50_80" BindText="s051f" onClick='Submit()'>
				</td>
			</tr>
		</table>

		<div class="func_spread"></div>
		<script type="text/javascript">
			var UsbConfiglistInfo = new Array(new stTableTileInfo("s0528", null, "Username",  false, 10),
											  new stTableTileInfo("s0529", null, "UserPassword"),
											  new stTableTileInfo("s052a", null, "Port"),
											  new stTableTileInfo("s0530", null, "URL",       false, 30),
											  new stTableTileInfo("s052b", null, "LocalPath", false, 30),
											  new stTableTileInfo("s0520", null, "Status",    false, 8),
											  null);

			var ColumnNum = 6;
			var TableDataInfo = HWcloneObject(DownloadInfo, 1);
			for (var i in TableDataInfo)
			{
				TableDataInfo[i].UserPassword = '*****';
			}
			TableDataInfo[TableDataInfo.length] = 'null';
			HWShowTableListByType(1, "UsbConfigList", 0, ColumnNum, TableDataInfo, UsbConfiglistInfo, UsbHostLgeDes, null);
		</script>
		<div class="func_spread"></div>
	</form>
	<script>
		ParseBindTextByTagName(UsbHostLgeDes, "div",    1);
		ParseBindTextByTagName(UsbHostLgeDes, "td",     1);
		ParseBindTextByTagName(UsbHostLgeDes, "input",  2);
	</script>
</body>
</html>
