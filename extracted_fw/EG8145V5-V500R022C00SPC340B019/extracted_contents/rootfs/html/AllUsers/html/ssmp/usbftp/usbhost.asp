<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<meta http-equiv="Content-Security-Policy" content="default-src *; style-src 'self' http://* 'unsafe-inline'; script-src 'self' http://* 'unsafe-inline' 'unsafe-eval'" />
<link type='text/css' rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link type='text/css' rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" type="text/css" media="screen" />
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js, UsbHostLgeDes, usbHostPrompteDes);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(errdes.html);%>"></script>
<style type='text/css'>
  span.language-string {
  padding: 0px 15px;
  display: block;
  height: 40px;
  line-height: 40px;
}
.row.hidden-pw-row {
  width: 132px;
  height: 30px;
  line-height: 30px;
}

 #SaveAsPath_text {
    width: 120px;
 }
.accessPathStyle {
	width: 694px;
    background-color: #f8f8f8;
    height: 22px;
}
.accessTitle {
	padding-top: 4px;
	margin-left: 6px;
    float: left;
}

.accessValue {
	padding-top: 4px;
	margin-left: 104px;
    float: left;
}

.egvdfbrowserbutton {
	width : 80px;
}

 .SaveAsPath_textClass {
    width: 150px !important; 
 }
</style>
<script language="JavaScript" type="text/javascript">
var USBFileName;
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var USBROLIST = '<%HW_WEB_GetUSBDRWStatus();%>';
var tedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";

var IsGlobeFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GLOBE);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var LanHostInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask|X_HW_AddressConflictDetectionEnable,stLanHostInfo);%>;
var IpAddr = LanHostInfos[0].ipaddr;
var isMegacablePWD = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';

function stLanHostInfo(domain,enable,ipaddr,subnetmask,AddressConflictDetectionEnable)
{
    this.domain = domain;
    this.enable = enable;
    this.ipaddr = ipaddr;
    this.subnetmask = subnetmask;
    this.AddressConflictDetectionEnable = AddressConflictDetectionEnable;
}

function GetLanguageDesc(Name)
{
	return UsbHostLgeDes[Name];
}

function stUSBDevice(domain,DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

function stFtpSrvCfg(domain, enable, username, ftpport, rootdirpath, usrnum)
{
	this.domain = domain ;
	this.enable  = enable ;
	this.username = username ;
	this.passwd = '********************************';
	this.ftpport = ftpport;
	this.rootdirpath = rootdirpath;
	this.usrnum = usrnum;
}

function stUsbInfo(mntpath, devname)
{
	this.mntpath = mntpath;
	this.devname = devname;
}

var g_configftppath=UsbHostLgeDes['s052e'];
var IsItVdf = '<%HW_WEB_GetFeatureSupport(FT_ITVDF_SUPPORT);%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var IsTelmex = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TELMEX);%>';
var ftpmode = '<%HW_WEB_GetSPEC(SSMP_SPEC_FTP_MODE.UINT32);%>';
var CuOSGIMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CU_OSGI_MODE);%>';
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var UsbDevice = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice,DeviceList,stUSBDevice);%>;
var FtpSrvCfgs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_ServiceManage, FtpEnable|FtpUserName|FtpPort|FtpRoorDir|FtpUserNum, stFtpSrvCfg);%>;
var frame = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_FRAME.STRING);%>';
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
var ftpsrvcfg = FtpSrvCfgs[0];
if (ftpsrvcfg == null) {
    ftpsrvcfg = new stFtpSrvCfg("", false, "", "", 0, "", 0);
}

var stUsbInfo = <%HW_WEB_GetUSBAllInfo();%>;
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var securityAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_SECURITY_ACCESS);%>';
var securityInAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_WAN_ACCESS_IN_SECURITY);%>';
var disableUnsafePro = '<%HW_WEB_GetFeatureSupport(FT_DISABLE_UNSAFE_PROTOCOL);%>';
var isDebugMode ='<%WEB_GetDebugMode();%>';
var pwdComplexFt = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';
var usb1 = null;
var usb2 = null;

var DeviceStr = null;
var DeviceArray = null;
var addFlag = 0;
var defaultPwd = "********************************";
var notSetPwd = 0;

var SFTPClientInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SFTP.X_HW_SFTP_ClientInfo.{i}, SftpEnable|SftpUserName|SftpPassword|SftpRoorDir|EncryptMode|Permission, stSFTPClientInfo);%>;
var CurrentSFTPClientIndex = 0;
var SFTPSrvInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SFTP.X_HW_SFTP_ServerInfo, SftpEnable|SftpPort|SftpLANEnable|SftpWANEnable|SftpStatus|SftpMaxDuration|SftpEnableTime|SftpMaxIdleDur, stSFTPSrvCfg);%>;
var SFTPSrvInfo = SFTPSrvInfoList[0];
if ((tedataGuide == 1) && (SFTPSrvInfo == null)) {
    SFTPSrvInfo = new stSFTPSrvCfg("InternetGatewayDevice.X_HW_SFTP.X_HW_SFTP_ServerInfo","0","22","0","0","1","86400","0","300");
}

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

function useSftp() {
    return (IsPtVdf == 1);
}

function IsDisableUnsafeProtocol()
{
	if (CfgMode.toUpperCase() == "EGVDF2") {
		return true;
	}

	if ((securityAccessFlag == '1') && (disableUnsafePro == '1') && (isDebugMode != '1')) {
		return true;
	}
	return false;
}

function MakeDeviceName(DiskName)
{
	var device = DiskName.split("/");
	return device[device.length - 1];
}

function GetDevNameByOldMntPath(mntpath)
{
	if (null == stUsbInfo)return "";
	
	for (var i = 0; i < stUsbInfo.length; i++)
	{
		if (null == stUsbInfo[i])continue;
		
		if (stUsbInfo[i].mntpath == mntpath)
			return stUsbInfo[i].devname;
	}
	
	return "";
}

function GetMntPathByDevName(devname)
{
	if (null == stUsbInfo)return "";
	
	for (var i = 0; i < stUsbInfo.length; i++)
	{
		if (null == stUsbInfo[i])continue;
		
		if (stUsbInfo[i].devname == devname)
			return stUsbInfo[i].mntpath;
	}
	
	return "";
}

function init()
{
	if (useSftp())
	{		
		setSelect('TransModeSelect', top.FTPType);
	}

	
	with(document.forms[0])
	{
		if (DeviceArray == '')
			btnDown.disabled = true;

		setCheck('FtpdEnable', ftpsrvcfg.enable);
		setText('SrvUsername', ftpsrvcfg.username);
		setText('SrvPort', ftpsrvcfg.ftpport);
		setText('Srvpassword', ftpsrvcfg.passwd);

		var tmp;
		var i;
		var newPath="";

		if("" != ftpsrvcfg.rootdirpath)
		{
			tmp = ftpsrvcfg.rootdirpath.split("/");
			for(i=0; i<tmp.length - 3; i++)
			{
				newPath += tmp[3+i];

				if(i != tmp.length - 4)
				{
					newPath += '/';
				}
			}

			if ( 'jffs2' == newPath )
			{
				newPath='';
			}
			
			if (1 == IsItVdf)
			{
				WriteDeviceOption(newPath);
				g_configftppath = newPath;
				setText('RootDirPath', newPath);
			}
			else if (useSftp())
			{
				setText('RootDirPath', GetDevNameByOldMntPath('/mnt/usb/'+newPath));
				setSelect('SrvClDevType', GetDevNameByOldMntPath('/mnt/usb/'+tmp[3])+'/');
			}
			else
			{
				setText('RootDirPath', newPath);
				setSelect('SrvClDevType', '/mnt/usb/'+tmp[3]+'/');
			}
		}
		else
		{
			setText('RootDirPath',    '');
			setSelect('SrvClDevType', '');
		}

		SetFtpEnable();
	}
	$("#checkinfo1Row").css("display", "none");
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

function UsbFtpchooseValue(obj)
{
	var text = obj.innerHTML;
	var ShowId = "IframeUSBHost" + "show";
	$('#'+ShowId).html(text);
	g_configftppath = obj.id;
	setText('RootDirPath', g_configftppath);
	SetClickFlag(false);
	$('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
}

function WriteDeviceOption(id)
{
	if(1 == IsItVdf){
	
		if (DeviceStr != 'null'){
		
			var arr = [];
			
			var DefaultValue = (null != id || "" != id)?id:UsbHostLgeDes['s052e'];
			
			for (var i in DeviceArray)
			{
				if ((DeviceArray[i] == 'null')
					|| (DeviceArray[i] == 'undefined'))
					continue;
				arr.push(MakeDeviceName(DeviceArray[i]));
			}
			
		}else{
			var arr = [UsbHostLgeDes['s052e']];
			var DefaultValue = UsbHostLgeDes['s052e'];
		}
		
		createDropdown("IframeUSBHost",DefaultValue,"225px", arr, "UsbFtpchooseValue(this);");
			
	}else{
	
		var select = document.getElementById(id);
	
		if (DeviceStr != 'null')
		{
			for (var i in DeviceArray)
			{
				if ((DeviceArray[i] == 'null')
					|| (DeviceArray[i] == 'undefined'))
					continue;
				var opt = document.createElement('option');
				var html;
				
				if (useSftp())
				{
					var devname = GetDevNameByOldMntPath(DeviceArray[i]);
					html = document.createTextNode(devname);
				}
				else
				{
					html = document.createTextNode(MakeDeviceName(DeviceArray[i]));
				}
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
}

function CheckPwdIsComplex(str, strName)
{
    var i = 0;
    if (str.length < pwdLen) {
        return false;
    }

    if (!CompareString(str,strName)) {
        return false;
    }

    if (isLowercaseInString(str)) {
        i++;
    }

    if (isUppercaseInString(str)) {
        i++;
    }

    if (isDigitInString(str)) {
        i++;
    }

    if (isSpecialCharacterInString(str)) {
        i++;
    }

    if (i >= 2) {
        return true;
    }
    return false;
}

function title_show(input)
{
	var div=document.getElementById("title_show");

	if ("ARABIC" == LoginRequestLanguage.toUpperCase())
	{
		div.style.right = (input.offsetLeft + 50) + "px";
	}
	else if (curWebFrame == 'frame_UNICOM'||curWebFrame == 'frame_LNUNICOM')
	{
		div.style.left = (input.offsetLeft + 300) + "px";
		div.style.width = "auto";
		div.style.overflow= "auto";
	}
	else
	{
		div.style.left = (input.offsetLeft + 370) + "px";
	}

	var ftpTips = (pwdComplexFt == 1) ? 'ss1116b_sec' : 'ss1116b';
	div.innerHTML = UsbHostLgeDes[ftpTips];

	if (CuOSGIMode == 1)
	{
		div.style.color = "#000000";
		div.style.width = "270px";
	}
	div.style.display = '';
	if ( 'ZAIN' == CfgMode.toUpperCase())
	{
		div.style.color = '#000000';
	}
	if (CfgModeWord.toUpperCase() == "ROSUNION") {
	    div.style.background = 'rgb(39, 58, 100)';
	    div.style.color = '#fff';
	    div.style.border = 'none';
	    div.style.padding = '5px';
	}
}

function title_back(input)
{
	var div=document.getElementById("title_show");
	div.style.display = "none";
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

function GetLanguageDesc(Name)
{
	return UsbHostLgeDes[Name];
}

function psdStrength()
{
	if (top.FTPType == "SFTP")
	{
		return;
	}
	
	var score = 0;
	var password1 = getElementById("Srvpassword").value;
	if(password1.length > 8) score++;

	if(password1.match(/[a-z]/) && password1.match(/[A-Z]/)) score++;

	if(password1.match(/\d/)) score++;

	if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;

	if (password1.length > 12) score++;


	if(0 == score)
	{
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s0558');
		getElementById("pwdvalue1").style.width=16.6+"%";
		getElementById("pwdvalue1").style.borderBottom="4px solid #FF0000";
	}

	if(1 == score)
	{
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s0558');
		getElementById("pwdvalue1").style.width=33.2+"%";
		getElementById("pwdvalue1").style.borderBottom="4px solid #FF0000";
	}
	if(2 == score)
	{
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s0559');
		getElementById("pwdvalue1").style.width=49.8+"%";
		getElementById("pwdvalue1").style.borderBottom="4px solid #FFA500";
	}
	if(3 == score)
	{
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s0559');
		getElementById("pwdvalue1").style.width=66.4+"%";
		getElementById("pwdvalue1").style.borderBottom="4px solid #FFA500";
	}
	if(4 == score)
	{
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s0560');
		getElementById("pwdvalue1").style.width=83+"%";
		getElementById("pwdvalue1").style.borderBottom="4px solid #008000";
	}
	if(5 == score)
	{
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s0560');
		getElementById("pwdvalue1").style.width=100+"%";
		getElementById("pwdvalue1").style.borderBottom="4px solid #008000";
	}
}

function checkFtpURL()
{
	var ServerPos;
	var URLValue = document.getElementById('URL').value;
    var checkPrefix = IsDisableUnsafeProtocol() ? "sftp://" : "ftp://";
    var checkCount = IsDisableUnsafeProtocol() ? 7 : 6;
    var invailUrl = IsDisableUnsafeProtocol() ? "s0667sftp" : "s050a";
    var errorUrl = IsDisableUnsafeProtocol() ? "s0668sftp" : "s0534";

    if (URLValue.substr(0, checkCount) != checkPrefix) {
        AlertEx(UsbHostLgeDes[invailUrl]);
        return false;
    }
    
    if ((URLValue == '') || (URLValue.length <= 6)) {
        AlertEx(UsbHostLgeDes[invailUrl]);
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
		AlertEx(UsbHostLgeDes[invailUrl]);
		return false;
	}

	ServerPos=URLValue.substr(checkCount, URLValue.length);
	if(ServerPos.indexOf('/') <= 0)
	{
		AlertEx(UsbHostLgeDes[invailUrl]);
		return false;
	}
	else
	{
		USBFileName = ServerPos.substr(ServerPos.indexOf('/') + 1,ServerPos.length);
		if (USBFileName == '')
		{
			AlertEx(UsbHostLgeDes[invailUrl]);
			return false;
		}
		return true;
	}
}

function CheckUSBFileIsExist()
{
	var USBFileLocalPath = document.getElementById('SaveAsPath_text').value;
	var CheckResult = 0;
	var USBFileInfo = "";
	if (useSftp())
	{
		var arr = USBFileLocalPath.split("/");
		var newFileLocalPath = "";
		if (null != arr && arr.length > 2)
		{
			newFileLocalPath = GetMntPathByDevName(arr[1]);
			for (var i = 2; i < arr.length; ++i)
			{
				newFileLocalPath += '/' + arr[i];
			}
			USBFileInfo = newFileLocalPath +'/' + USBFileName;
		}
	}
	else
	{
		USBFileInfo = '/mnt/usb' + USBFileLocalPath +'/' + USBFileName;
	}

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

function checkFtpClient()
{
	with( document.forms["ConfigForm"] )
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
        if (IsDisableUnsafeProtocol()) {
            if (Username.value == '') {
                AlertEx(GetLanguageDesc("s050e"));
                return false;
            }
            if (Userpassword.value == '') {
                AlertEx(GetLanguageDesc("s0512"));
                return false;
            }
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
		if ("" == tmp)
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

	if (NullCheckValue == '') {
		if (IsDisableUnsafeProtocol()) {
			Form.addParameter('Port', 22);
		} else {
			if ((CfgMode.toUpperCase() == "TELMEXVULA") || (CfgMode.toUpperCase() == "TELMEXACCESS") ||
				(CfgMode.toUpperCase() == "TELMEXRESALE")) {
					Form.addParameter('Port', 21);
			}
		}
    }
	var savepath = getValue('SaveAsPath_text');

	var Devicepath = "";
	if (undefined != savepath.split("/")[2])
	{
		if (useSftp())
		{
			Devicepath = GetMntPathByDevName(savepath.split("/")[1]) + '/';
		}
		else
		{
			Devicepath = '/mnt/usb/' +savepath.split("/")[1] +'/';
		}
	}
	else
	{
		if (useSftp())
		{
			Devicepath = GetMntPathByDevName(savepath.split("/")[1]);
		}
		else
		{
			Devicepath = '/mnt/usb/' +savepath.split("/")[1];
		}
	}

	var LocalPath = savepath.substr(savepath.split("/")[1].length + 2,savepath.length);
	LocalPath = LocalPath +"/"+ USBFileName;
	
	Form.addParameter('Device',  Devicepath);
	Form.addParameter('LocalPath', LocalPath);
	Form.addParameter('X_HW_Token',   getValue('onttoken'));
	Form.endPrefix();
	Form.setAction('add.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.FtpClient&'
				 + 'RequestFile=html/ssmp/usbftp/usbhost.asp');
}

function checkPort(portVal)
{
	if ((portVal == '') || (isPlusInteger(portVal) == false))
	{
		AlertEx(GetLanguageDesc("s0501"));
		return false;
	}		

	var portInfo = parseInt(portVal, 10);
	if (portInfo < 1 || portInfo > 65535)
	{
		AlertEx(GetLanguageDesc("s0502"));
		return false;
	}
	
	return true;
}

function checkFtpSrv()
{
	with (document.forms[0])
	{
		if( 0 == getCheckVal('FtpdEnable') || '0' == getCheckVal('FtpdEnable') )
		{
			return true;
		}

		if (getValue("SrvUsername").length > 256)
		{
			AlertEx(GetLanguageDesc("s050d"));
			return false;
		}

		if (getValue("SrvUsername").length == 0)
		{
			AlertEx(GetLanguageDesc("s050e"));
			return false;
		}

		if (getValue("SrvUsername") == 'anonymous' || getValue("SrvUsername") == 'Anonymous')
		{
			AlertEx(GetLanguageDesc("s050f"));
			return false;
		}

		if (isValidString(getValue("SrvUsername")) == false )
		{
			msg = GetLanguageDesc("s050f");
			AlertEx(msg);
			return false;
		}

		var srvUName = getValue("SrvUsername");
		for (var iTemp = 0; iTemp < srvUName.length; iTemp ++)
		{
			if (srvUName.charAt(iTemp) == ' ')
			{
				AlertEx(GetLanguageDesc("s0505"));
				return false;
			}
		}

		if (getValue("Srvpassword").length > 256)
		{
			AlertEx(GetLanguageDesc("s0511"));
			return false;
		}

		if (getValue("Srvpassword").length == 0)
		{
			AlertEx(GetLanguageDesc("s0512"));
			return false;
		}

		if(getValue("Srvpassword").charAt(0) == ' ')
		{
			AlertEx(GetLanguageDesc("s052c"));
			return false;
		}

		if(getValue("Srvpassword").charAt(getValue("Srvpassword").length - 1) == ' ')
		{
			AlertEx(GetLanguageDesc("s052d"));
			return false;
		}

		if ( isValidString(getValue("Srvpassword")) == false )
		{
			msg = GetLanguageDesc("s0513");
			AlertEx(msg);
			return false;
		}

		var tmpSrvPasswd = getValue("Srvpassword");
		for (var iTemp = 0; iTemp < tmpSrvPasswd.length; iTemp ++)
		{
			if (tmpSrvPasswd.charAt(iTemp) == ' ')
			{
				AlertEx(GetLanguageDesc("s0513"));
				return false;
			}
		}
		
		var portVal = getValue("SrvPort");
		if (false == checkPort(portVal))
		{
			return false;
		}

		if ( getSelectVal('SrvClDevType') == "" )
		{
			AlertEx(GetLanguageDesc("s0514"));
			return false;
		}

		var tmp = getValue("RootDirPath");
		if (tmp.length > 256)
		{
			AlertEx(GetLanguageDesc("s0515"));
			return false;
		}

		if (isValidString(getValue("RootDirPath")) == false )
		{
			msg = GetLanguageDesc("s0516");
			AlertEx(msg);
			return false;
		}

	}

	var pwd_value = getValue("Srvpassword");
	if (ftpsrvcfg.passwd != pwd_value)
	{
		if (!CheckPwdIsComplex(pwd_value, srvUName))
		{
			if ((pwdComplexFt == 1) || (tedataGuide == 1)) {
              CfgModeWord.toUpperCase() === "EGVDF2"? AlertEx(AccountLgeDes['s1116l']) : AlertEx(UsbHostLgeDes['s0651sftp']);
              return false;
			}
			if (false == ConfirmEx(UsbHostLgeDes['s1439']))
			{
				return false;
			}
		}
	}

	var notice = GetLanguageDesc("s0517");
	if (ftpmode == '1') {
		notice = GetLanguageDesc("s0702ftps");
	}

	if (ConfirmEx(notice))
	{
		return true;
	}
	else
	{
		return false;
	}

	return true;

}

function ShowResult(Result)
{
	var i = 0;
	var errorCodeArray = new Array('0xf734b001', '0xf734b002', '0xf734b003', '0xf734b004', '0xf734b005');
	var errorstring = new Array('s0543', 's0544', 's0545', 's0546', 's0547');
	try{
		var ResultInfo = JSON.parse(hexDecode(Result));
		if (0 == ResultInfo.result)
		{
			return;
		}
		
		for (i = 0; i < errorCodeArray.length; i++)
		{
			if (errorCodeArray[i] == ResultInfo.error)
			{
				AlertEx(GetLanguageDesc(errorstring[i]));
				return;
			}
		}

		var errData = errLanguage['s' + ResultInfo.error];
		if ('string' != typeof(errData))
		{
			errData = errLanguage['s0xf7205001'];
		}

		AlertEx(errData);
	}catch(e){
	
		errData = errLanguage['s0xf7205001'];
		AlertEx(errData);
	}
}

function SetSftpEnable()
{
	if("1" != getCheckVal("SFTPEnable")){
		return;
	}
	
	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : "x.SftpEnable=0" + "&x.X_HW_Token=" + getValue('onttoken'),
		 url : "setajax.cgi?x=InternetGatewayDevice.X_HW_SFTP.X_HW_SFTP_ServerInfo&RequestFile=html/ssmp/usbftp/usbhost.asp",
		 success : function(data) {
		 }
	});
}

function SrvSubmit()
{
	var Ret;

	Ret = checkFtpSrv();
	if (false == Ret)
	{
		return;
	}

	setDisable('SrvClDevType', 1);
	setDisable('RootDirPath', 1);
	setDisable('btnDownSrvApply',  1);
	setDisable('btnDownSrcCancle', 1);

	var ftpInfoData="x.FtpEnable=" + getCheckVal('FtpdEnable');

	if (1 == getCheckVal('FtpdEnable') || '1' == getCheckVal('FtpdEnable'))
	{
		ftpInfoData += "&x.FtpUserName=" + encodeURIComponent(getValue('SrvUsername'));

		if (ftpsrvcfg.passwd != getValue('Srvpassword'))
		{
			ftpInfoData += "&x.FtpPassword=" + encodeURIComponent(getValue('Srvpassword'));
		}
	
		ftpInfoData += "&x.FtpPort=" + getValue('SrvPort');
		
		if (1 == IsItVdf)
		{
			ftpInfoData += "&x.FtpRoorDir=/mnt/usb/" + encodeURIComponent(g_configftppath);
		}
		else if (useSftp())
		{
			var tmpDirPath = "";
			var tmpDirPathArr = getValue('RootDirPath').split("/");
			if (null != tmpDirPathArr)
			{
				tmpDirPath = tmpDirPathArr[0];
			}
			ftpInfoData += "&x.FtpRoorDir=" + encodeURIComponent(GetMntPathByDevName(tmpDirPath));
		}
		else
		{
			ftpInfoData += "&x.FtpRoorDir=/mnt/usb/" + encodeURIComponent(getValue('RootDirPath'));
		}
		
	}

	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : ftpInfoData + "&x.X_HW_Token=" + getValue('onttoken'),
		 url : "setajax.cgi?x=InternetGatewayDevice.X_HW_ServiceManage&RequestFile=html/ssmp/usbftp/usbhost.asp",
		 success : function(data) {
						
			ShowResult(data);
			window.location.href = "/html/ssmp/usbftp/usbhost.asp";
		 }
	});
}

function SetFtpEnable()
{
	var enable = getCheckVal('FtpdEnable');
	
	if(1 == enable || '1' == enable)
	{
	    if ((ftpsrvcfg.enable == false) && (tedataGuide == 1) && (DeviceStr == 'null')) {
	        AlertEx(GetLanguageDesc("s0562"));
	        setCheck('FtpdEnable', 0);
	        return;
	    }

		setDisable("SrvUsername",  0);
		setDisable("Srvpassword",  0);
		setDisable("SrvPort",  0);
		
		setDisable("RootDirPath",  0);
			
		if(1 == IsItVdf){
			setDisable("SrvClDevTypeCol",0);
			$("#IframeUSBHostshow").css("color","#5D5D5D");
			$("#IframeDropdownCorver").css("display","none");
		}else{
			setDisable("SrvClDevType", 0);
		}
		if(useSftp())
		{
		setDisplay("ftpwarningRow",1);
		}
	}
	else
	{
		setDisable("SrvUsername",  1);
		setDisable("Srvpassword",  1);
		setDisable("SrvPort",  1);
		setDisable("RootDirPath",  1);
		
		if(1 == IsItVdf){
			setDisable("SrvClDevTypeCol",1);
			$("#IframeUSBHostshow").css("color","#C5C5C5");
			$("#IframeDropdownCorver").css("display","block");
		}else{
			setDisable("SrvClDevType", 1);
		}
		setDisplay("ftpwarningRow",0);
	}
}

function onChangeDev()
{
	var dev = getSelectVal('SrvClDevType');
	var tmp;

	if (DeviceArray.length-1 > 1)
	{
		return;
	}

	if ( "" != dev)
	{
		tmp = dev.split("/");
		if (useSftp())
		{
			setText('RootDirPath', GetDevNameByOldMntPath('/mnt/usb/'+tmp[3])+'/');
		}
		else
		{			
			setText('RootDirPath', tmp[3]+'/');
		}		
	}
	else
	{
		setText('RootDirPath', '');
	}
}


function onSelectDev()
{
	var dev = getSelectVal('SrvClDevType');
	var tmp;

	if( "" != dev)
	{
		tmp = dev.split("/");
		if (useSftp())
		{
			setText('RootDirPath', GetDevNameByOldMntPath('/mnt/usb/'+tmp[3])+'/');
		}
		else
		{			
			setText('RootDirPath', tmp[3]+'/');
		}
	}
	else
	{
		setText('RootDirPath', '');
	}
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
	for(i = 0; i < RecordString.length - 1; i++)
	{
		DownloadInfo[i] = new stDownloadInfo();
		var posLast = RecordString[i].Device.lastIndexOf('/');
		var tmpDevice = "";
		if(RecordString[i].LocalPath.replace(/(^\s*)|(\s*$)/g, "")=='')
		{
			var pos = RecordString[i].URL.lastIndexOf('/');
			if (useSftp())
			{
				tmpDevice = (posLast + 1 == RecordString[i].Device.length) ? RecordString[i].Device.substr(0, RecordString[i].Device.length-1) : RecordString[i].Device;
				RecordString[i].LocalPath = GetDevNameByOldMntPath(tmpDevice) + "/" + RecordString[i].URL.substr(pos + 1, RecordString[i].URL.length - pos -1);
			}
			else
			{
				RecordString[i].LocalPath = RecordString[i].Device + RecordString[i].URL.substr(pos + 1, RecordString[i].URL.length - pos -1);
			}			
		}
		else
		{
			if (useSftp())
			{
				tmpDevice = (posLast + 1 == RecordString[i].Device.length) ? RecordString[i].Device.substr(0, RecordString[i].Device.length-1) : RecordString[i].Device;
				var newDevice = GetDevNameByOldMntPath(tmpDevice);
				if ("" == newDevice)
				{
					RecordString[i].LocalPath = RecordString[i].Device + RecordString[i].LocalPath;
				}
				else
				{
					if (tmpDevice == RecordString[i].Device)
					{
						RecordString[i].LocalPath = "/" + newDevice + RecordString[i].LocalPath;
					}
					else
					{
						RecordString[i].LocalPath = "/" + newDevice + "/" + RecordString[i].LocalPath;
					}
				}
			}
			else
			{
				RecordString[i].LocalPath = RecordString[i].Device + RecordString[i].LocalPath;
			}
		}
		DownloadInfo[i] = RecordString[i];
	}
}

function Cancleconfig()
{
	init();
}

var TableClass = new stTableClass("width_per25", "width_per75");
var TableClass20_80 = new stTableClass("width_per20", "width_per80");

function stSFTPClientInfo(Domain, SftpEnable, SftpUserName, SftpPassword, SftpRoorDir, EncryptMode, Permission)
{
	this.Domain = Domain;
	this.SftpUserName = SftpUserName;
	this.SftpPassword = SftpPassword;
	this.SftpRoorDir = SftpRoorDir;
	this.EncryptMode = EncryptMode;
	this.Permission = Permission;
	this.EnableAccount = SftpEnable;
}

function stSFTPClientShowInfo(Domain, SftpEnable, SftpUserName, SftpRoorDir, Permission)
{
	this.Domain = Domain;
	this.SftpUserName = SftpUserName;
	this.SftpRoorDir = SftpRoorDir;
	this.Permission = Permission;
	this.EnableAccount = SftpEnable;
}

function stSFTPSrvCfg(Domain, SftpEnable, SftpPort, SftpLANEnable, SftpWANEnable, SftpStatus, SftpMaxDuration, SftpEnableTime, SftpMaxIdleDur)
{
	this.Domain = Domain;
	this.SftpEnable = SftpEnable;
	this.SftpPort = SftpPort;
	this.SftpLANEnable = SftpLANEnable;
	this.SftpWANEnable = SftpWANEnable;
	this.SftpStatus = SftpStatus;
	this.SftpMaxDuration = SftpMaxDuration;
	this.SftpEnableTime = SftpEnableTime;
	this.SftpMaxIdleDur = SftpMaxIdleDur;
}

function ShowListControlInfo()
{
	var ColumnNum = 4;
    var ShowListLength = SFTPClientInfoList.length - 1;
	var Listlen = 0;
	var TableDataInfo = new Array();
	
	for (var i = 0; i < ShowListLength; i++)
	{
		TableDataInfo[Listlen] = new stSFTPClientShowInfo();
		TableDataInfo[Listlen].SftpUserName = SFTPClientInfoList[i].SftpUserName;
		
		if (1 == IsPtVdf)
		{
			var substr = SFTPClientInfoList[i].SftpRoorDir.substr(8, SFTPClientInfoList[i].SftpRoorDir.length - 1);
			var arr = substr.split('/');
			arr[1] = GetDevNameByOldMntPath('/mnt/usb/'+arr[1]);
			var rootdir = '';
			for(var j = 1; j < arr.length; ++j)
			{
				rootdir += '/'+arr[j];
			}
			TableDataInfo[Listlen].SftpRoorDir = rootdir;
		}
		else
		{
			TableDataInfo[Listlen].SftpRoorDir = SFTPClientInfoList[i].SftpRoorDir.substr(8, SFTPClientInfoList[i].SftpRoorDir.length - 1);
		}
		
		if (SFTPClientInfoList[i].Permission == 1)
		{
			TableDataInfo[Listlen].Permission = UsbHostLgeDes['s0656sftp'];
		}
		else
		{
			TableDataInfo[Listlen].Permission = UsbHostLgeDes['s0657sftp'];
		}
		
		if (SFTPClientInfoList[i].EnableAccount == 1)
		{
			TableDataInfo[Listlen].EnableAccount = UsbHostLgeDes['s0654sftp'];
		}
		else
		{
			TableDataInfo[Listlen].EnableAccount = UsbHostLgeDes['s0655sftp'];
		}
		
		Listlen++;
	}
	
	if (0 == ShowListLength)
    {
        TableDataInfo[Listlen] = new stSFTPClientShowInfo();
		TableDataInfo[Listlen].SftpUserName = "--";
		TableDataInfo[Listlen].SftpRoorDir = "--";
		TableDataInfo[Listlen].Permission = "--";
		TableDataInfo[Listlen].EnableAccount = "--";
    }
    else
    {
        TableDataInfo.push(null);
    }
	
	HWShowTableListByType(1, "UsbSFTPConfigList", true, ColumnNum, TableDataInfo, UsbConfiglistInfo, UsbHostLgeDes, null);
}

function SFTPEditClientSubmit()
{
    if ((!useSftp()) && (IsDisableUnsafeProtocol() != true)) {
        return;
    }
	var sftpClientUserName = getValue("SFTPUsername");
	var sftpClientNewPwd = getValue("SFTPNewPassword");
	var sftpClientConfirmPwd = getValue("SFTPCfmPassword");
	
	var Form = new webSubmitForm();
		
	if (sftpClientNewPwd != sftpClientConfirmPwd)
	{
		AlertEx(UsbHostLgeDes['s0650sftp']);
		return;
	}
	
	if (false == CheckPwdIsComplex(sftpClientNewPwd, sftpClientUserName))
	{
		CfgModeWord.toUpperCase() === "EGVDF2"? AlertEx(AccountLgeDes['s1116l']) : AlertEx(UsbHostLgeDes['s0651sftp']);
		return;
	}
	
	Form.addParameter('x.SftpPassword', sftpClientNewPwd);
	Form.addParameter('x.EncryptMode',0);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	Form.setAction('set.cgi?' +'x='+ SFTPClientInfoList[CurrentSFTPClientIndex].Domain + '&RequestFile=html/ssmp/usbftp/usbhost.asp');
	Form.submit();
}

function SFTPEditClientCancle()
{
	setDisplay("SFTPConfigForm", 1);
	setDisplay("SFTPEditPwd", 0);
}

function OnChangeTransmissionMode()
{
	ControlTransMode()
	
	return;
}

function OnChangeDirMode()
{
	ControlDirMode();
}

function OnChangeChooseDir()
{
	tb_show("Browse Directory", "../smblist/smb_choosedir_list.asp?&amp;Choose=1&amp;TB_iframe=true", "false");
	setDisplay("TB_window", 1);
	return;
}

function OnChangeEditSFTPClientCfg()
{
	setDisplay("SFTPConfigForm", 0);
	setDisplay("SFTPEditPwd", 1);
	getElementById("SFTPEditUserName").innerHTML = getValue("SFTPUsername");
	return;
}

function isValidInASCII(val)
{
	for ( var i = 0 ; i < val.length ; i++ )
	{
		var ch = val.charAt(i);
		if ( ch <= ' ' || ch > '~' )
		{
			return false;
		}
	}
	return true;
}

function CheckSftpForm()
{
    var sftpClientUserName = getValue("SFTPUsername");
    var sftpClientPwd = getValue("SFTPUserpassword");
    var sftpClientConfirmPwd = getValue("SFTPConfirmpassword");
    var sftpPath = getValue("SaveAsPath_text_account");
    
    if (IsDisableUnsafeProtocol()) {
        if (sftpClientUserName == '') {
            AlertEx(UsbHostLgeDes['s0662sftp']);
            return false;
        }
        if ((sftpClientPwd == '') || (sftpClientConfirmPwd == '')) {
            AlertEx(UsbHostLgeDes['s0663sftp']);
            return false;
        }
        if (sftpPath == '') {
            AlertEx(UsbHostLgeDes['s0664sftp']);
            return false;
        }
        if ((sftpClientPwd == defaultPwd) && (sftpClientConfirmPwd == defaultPwd)) {
        notSetPwd = 1;
        if (addFlag == false) {
            return true;
        }
    
    }
}
    if (sftpClientPwd != sftpClientConfirmPwd) {
        AlertEx(UsbHostLgeDes['s0650sftp']);
        return false;
    }

    if (CheckPwdIsComplex(sftpClientPwd, sftpClientUserName) == false) {
        CfgModeWord.toUpperCase() === "EGVDF2"? AlertEx(AccountLgeDes['s1116l']) : AlertEx(UsbHostLgeDes['s0651sftp']);
        return false;
    }
    return true;
}

function ClientSubmit()
{
    if ((!useSftp()) && (IsDisableUnsafeProtocol() != true)) {
        return;
    }
    var sftpClientEnable = getCheckVal("EnableAccount");
    var sftpClientUserName = getValue("SFTPUsername");
    var sftpClientPwd = getValue("SFTPUserpassword");
    var sftpClientConfirmPwd = getValue("SFTPConfirmpassword");
    var sftpClientDirEnable = getRadioVal("Dirmode");
    var sftpClientUSBDir = "";
    var sftpClientPrivilegeValue = getRadioVal("Privilege");
    var sftpClientPrivilege = 0;
    notSetPwd = 0;

    var Form = new webSubmitForm();

    if (CheckSftpForm() == false) {
        return;
    }
    if (IsDisableUnsafeProtocol()) {
        sftpClientUSBDir = "/mnt/usb" + getValue("SaveAsPath_text_account");
    } else {
        if (sftpClientDirEnable == 1) {
            if (IsPtVdf == 1) {
                var tmp = getValue("ChoosDir");
                var arr = tmp.split("/");
                if ((arr != null) && (arr.length >= 2)) {
                    sftpClientUSBDir = GetMntPathByDevName(arr[1]);
                    for (var i = 2; i < arr.length; ++i) {
                        sftpClientUSBDir += '/' + arr[i];
                    }
                }
            } else {
                sftpClientUSBDir = "/mnt/usb" + getValue("ChoosDir");
            }
        } else {
            sftpClientUSBDir = "/mnt/usb/";
        }
    }

    if (isValidInASCII(sftpClientUSBDir) != true) {
        AlertEx(UsbHostLgeDes['s0658sftp']);
        return;
    }

    if (sftpClientPrivilegeValue == 0) {
        sftpClientPrivilege = 1;
    } else {
        sftpClientPrivilege = 0;
    }

    Form.addParameter('x.SftpEnable',sftpClientEnable);
    Form.addParameter('x.SftpUserName',sftpClientUserName);
    if ((addFlag == 1) || (notSetPwd == 0)) {
        Form.addParameter('x.SftpPassword', sftpClientPwd);
    }
    Form.addParameter('x.SftpRoorDir', sftpClientUSBDir);
    Form.addParameter('x.EncryptMode',0);
    Form.addParameter('x.Permission',sftpClientPrivilege);

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    if (addFlag == 0) {
        Form.setAction('set.cgi?' +'x='+ SFTPClientInfoList[CurrentSFTPClientIndex].Domain + '&RequestFile=html/ssmp/usbftp/usbhost.asp');
    } else {
        Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_SFTP.X_HW_SFTP_ClientInfo&RequestFile=html/ssmp/usbftp/usbhost.asp');
    }

    Form.submit();
    return;
}

function ClientCancle()
{
	var tableRow = getElement("UsbSFTPConfigList");
	setDisplay("SFTPConfigForm", 0);
	
	if (tableRow.rows.length != 1 && tableRow.rows.length != 2)
	{
		tableRow.deleteRow(tableRow.rows.length - 1);
        selectLine("UsbSFTPConfigList_record_0");
	}
	
	return;
}

function OnChangeSFTPEnable()
{
	ControlSFTPServiceEnable();
	return;
}

function SFTPShowResult(Result)
{
	var errorCodeArray = new Array('0xf720b001','0xf734b001', '0xf734b002', '0xf734b003', '0xf734b004', '0xf734b005');
	var errorstring = new Array('s0638sftp', 's0543', 's0544', 's0545', 's0546', 's0547');
	try{
		var ResultInfo = JSON.parse(hexDecode(Result));
		if (0 == ResultInfo.result)
		{
			return;
		}
		
		for (i = 0; i < errorCodeArray.length; i++)
		{
			if (errorCodeArray[i] == ResultInfo.error)
			{
				AlertEx(GetLanguageDesc(errorstring[i]));
				return;
			}
		}

		var errData = errLanguage['s' + ResultInfo.error];
		if ('string' != typeof(errData))
		{
			errData = errLanguage['s0xf7205001'];
		}

		AlertEx(errData);
	}catch(e){
	
		errData = errLanguage['s0xf7205001'];
		AlertEx(errData);
	}
	return;
}


function SetDisableFtpEnable()
{
	if("1" != getCheckVal("FtpdEnable")){
		return;
	}
	
	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : "x.FtpEnable=0" + "&x.X_HW_Token=" + getValue('onttoken'),
		 url : "setajax.cgi?x=InternetGatewayDevice.X_HW_ServiceManage&RequestFile=html/ssmp/usbftp/usbhost.asp",
		 success : function(data) {
		 }
	});
}

function SFTPSrvSubmit()
{
    if ((!useSftp()) && (IsDisableUnsafeProtocol() != true)) {
        return;
    }
    var TempTimeInfo = getValue("MaximumIdleTime");
    var reg = /^[0-9]*$/;;
    if (!reg.test(TempTimeInfo) || (TempTimeInfo < 60) || (TempTimeInfo > 300)) {
        AlertEx(UsbHostLgeDes["s0653sftp"]);
        return;
    }

    SFTPSrvInfo.SftpEnable = getCheckVal("SFTPEnable");
    SFTPSrvInfo.SftpLANEnable = getCheckVal("LANWANEnable1");
    SFTPSrvInfo.SftpWANEnable = getCheckVal("LANWANEnable2");
    SFTPSrvInfo.SftpPort = getValue("SFTPPort");
    SFTPSrvInfo.SftpMaxIdleDur = TempTimeInfo;

    if (checkPort(SFTPSrvInfo.SftpPort) == false) {
        return false;
    }

    var sftpInfoData="x.SftpEnable=" + SFTPSrvInfo.SftpEnable;
    sftpInfoData += "&x.SftpPort=" + SFTPSrvInfo.SftpPort;
    sftpInfoData += "&x.SftpLANEnable=" + SFTPSrvInfo.SftpLANEnable;
    if ((IsDisableUnsafeProtocol() != true) && (tedataGuide != 1)) {
        sftpInfoData += "&x.SftpWANEnable=" + SFTPSrvInfo.SftpWANEnable;
    }

    sftpInfoData += "&x.SftpMaxIdleDur=" + SFTPSrvInfo.SftpMaxIdleDur;

    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : sftpInfoData + "&x.X_HW_Token=" + getValue('hwonttoken'),
         url : "setajax.cgi?x=InternetGatewayDevice.X_HW_SFTP.X_HW_SFTP_ServerInfo&RequestFile=html/ssmp/usbftp/usbhost.asp",
         success : function(data) {
            if (useSftp()) {
                SetDisableFtpEnable();
            }
            SFTPShowResult(data);
            window.location.href = "/html/ssmp/usbftp/usbhost.asp";
         }
    });

    return;
}

function SFTPSrvCancle()
{
	InitCfgInfo();
	InitControl();
	if (IsDisableUnsafeProtocol()) {
        setDisplay("SvrConfigForm", 0);
        setDisplay("SFTPSvrConfigForm", 1);
        setDisplay("SFTPClientConfigForm", 1);
    }
	return;
}

function AddSFTPClientEditHtml(UserName)
{
    var html = '<tr border="1" id="SftpConfigEditButtonRow" style="">' +
    '    <td id="UserNameIndex" class="table_title width_per25">'+ UserName + '</td>' +
    '    <td id="" class="table_right width_per75">' +
    '        <input id="SftpConfigEditButton" type="button" value="' + UsbHostLgeDes["s0642sftp"] + '" ' +
    '               class="CancleButtonCss browserbutton" style="margin-left:0;" ' +
    '               onclick="OnChangeEditSFTPClientCfg()">' +
    '    </td>' +
    '</tr>';

	$("#SFTPUsernameRow").before(html);
}

function AddChoosDirHtml()
{
    var html =  '<tr border="1" id="ChooseDirRow"> ' +
    '    <td id="" class="table_title width_per25"></td>' +
    '    <td id="" class="table_right width_per75">' +
    '        <input id="ChoosDir" type="text" title="" class="TextBox osgidisable" maxlength="null" ' +
    '               realtype="TextBox" bindfield="Empty" disabled=""/>' +
    '    </td>' +
    '</tr>' +
    '<tr border="1" id="ChooseDirButton">' +
        '<td id="" class="table_title width_per25"></td>' +
        '<td id="" class="table_right width_per75">' +
        '    <input id="ChoosDirButton" type="button" value="' + UsbHostLgeDes["s0636sftp"] + '" ' +
        '           title="' + UsbHostLgeDes["s0637sftp"] + '" ' +
        '           class="CancleButtonCss browserbutton thickbox" style="margin-left:0;"' +
        '           alt="../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true"/>' +
        '</td>' +
    '</tr>';
	$("#DirmodeRow").after(html);
}

function AddPwdNoticeHtml()
{
	var PwdNoticeInfoObj = document.getElementById("PwdNotice");
	PwdNoticeInfoObj.innerHTML = UsbHostLgeDes["s0647sftp"]; 
}

function ControlDirMode()
{
    var DirModeValue = getCheckVal("Dirmode2");

    if (DirModeValue == "1") {
        setDisplay("ChooseDirRow", 1);
        setDisplay("ChooseDirButton", 1);
    } else {
        setDisplay("ChooseDirRow", 0);
        setDisplay("ChooseDirButton", 0);
    }
}

function ControlSFTPServiceEnable()
{
	if ("1" == getCheckVal("SFTPEnable"))
	{
        if (tedataGuide == 1) {
            if (DeviceStr == 'null') {
                AlertEx(GetLanguageDesc("s0562"));
                setCheck('SFTPEnable', 0);
            }
        } else {
            setDisplay("SFTPwarningRow", 1);
        }
	}
	else
	{
		setDisplay("SFTPwarningRow", 0);
	}
}

function OnDeleteButtonClick()
{
    if (SFTPClientInfoList.length <= 1) {
        return;
    }
	var Form = new webSubmitForm();
	Form.addParameter(SFTPClientInfoList[CurrentSFTPClientIndex].Domain, "");
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('del.cgi?&RequestFile=html/ssmp/usbftp/usbhost.asp');
	Form.submit();
}

function setControl(index, id)
{
    if (id.indexOf("UsbSFTPConfigList") == -1) {
        return;
    }
    if (CfgModeWord.toUpperCase() == "EGVDF2" && $("#vdfSftpPwdStrengthServerRow").css('display') !== 'none') {
      $("#vdfSftpPwdStrengthServerRow").css('display', 'none');
    }
    CurrentSFTPClientIndex = index;
    if (index == -2) {
        setDisplay("SftpConfigEditButtonRow", 0);
        setDisplay("SFTPConfigForm", 0);
    } else if (index == -1) {
        addFlag = 1;
        setDisplay("SftpConfigEditButtonRow", 0);
        setDisplay("SFTPConfigForm", 1);
        setDisplay("sftpPwdNotice", 1);
        setDisplay("SFTPConfirmpasswordRow", 1);
        setDisplay("btnDownClientApply", 1);
        setDisplay("btnDownClientCancle", 1);
        setDisable("SFTPUsername", 0);
        setDisable("SFTPUserpassword", 0);
        setDisable("Dirmode1", 0);
        setDisable("Dirmode2", 0);
        setDisable("Privilege1", 0);
        setDisable("Privilege2", 0);
        setDisable("EnableAccount", 0);
        setDisable("btnDownClientApply", 0);
        setDisable("btnDownClientCancle", 0);
        setText("SFTPUsername", "");
        setText("SFTPUserpassword", "");
        setText("SFTPConfirmpassword", "");
        setCheck("Dirmode1", 1);
        setCheck("Privilege1", 1);
        setText("SaveAsPath_text", "");
        setText("SaveAsPath_text_account", "");
    } else {
        addFlag = 0;
        if (IsDisableUnsafeProtocol() != true) {
            setDisplay("btnDownClientApply", 0);
            setDisplay("btnDownClientCancle", 0);
            setDisplay("SFTPConfirmpasswordRow", 0);
            setDisplay("SftpConfigEditButtonRow", 1);
            setDisable("SFTPUsername", 1);
            setDisable("SFTPUserpassword", 1);
            setDisable("Dirmode1", 1);
            setDisable("Dirmode2", 1);
            setDisable("Privilege1", 1);
            setDisable("Privilege2", 1);
            setDisable("EnableAccount", 1);
            setDisable("btnDownClientApply", 1);
            setDisable("btnDownClientCancle", 1);
            if ((SFTPClientInfoList == null) || (SFTPClientInfoList[index] == null)) {
                return;
            }
            document.getElementById("UserNameIndex").innerHTML = SFTPClientInfoList[index].SftpUserName + ":";
            setText("SFTPUserpassword", "******");
        } else {
            setText("SFTPUserpassword", defaultPwd);
            setText("SFTPConfirmpassword", defaultPwd);
        }
        setDisplay("SFTPConfigForm", 1);
        setDisplay("sftpPwdNotice", 0);
        setText("SFTPUsername", SFTPClientInfoList[index].SftpUserName);

        if (SFTPClientInfoList[index].SftpRoorDir == "/mnt/usb/") {
            setRadio("Dirmode", 0);
        } else {
            setRadio("Dirmode", 1);
        }
        if (IsDisableUnsafeProtocol()) {
            setText("SaveAsPath_text_account", SFTPClientInfoList[index].SftpRoorDir.substr(8, SFTPClientInfoList[index].SftpRoorDir.length - 1));
        }
        
        if (SFTPClientInfoList[index].Permission == 1) {
            setRadio("Privilege", 0);
        } else {
            setRadio("Privilege", 1);
        }

        setCheck("EnableAccount", SFTPClientInfoList[index].EnableAccount);
    }
}

function InitCfgInfo()
{
    setSelect('TransModeSelect', top.FTPType);
    setCheck("SFTPEnable",SFTPSrvInfo.SftpEnable);
    setCheck("LANWANEnable1", SFTPSrvInfo.SftpLANEnable);
    setCheck("LANWANEnable2", SFTPSrvInfo.SftpWANEnable);
    if (tedataGuide == 1) {
        setDisplay("LANWANEnable2", 0);
        setDisplay("LANWANEnable2_text", 0);
    }
    setText("SFTPPort", SFTPSrvInfo.SftpPort);

    setText("MaximumIdleTime", SFTPSrvInfo.SftpMaxIdleDur);

    setText("WANMaxDuration", SFTPSrvInfo.SftpMaxDuration);
    if (IsDisableUnsafeProtocol()) {
        if (SFTPSrvInfo.SftpStatus == 1) {
            getElementById("Status").innerHTML = "UP";
        } else {
            getElementById("Status").innerHTML = "DOWN";
        }
    } else {
        if (SFTPSrvInfo.SftpStatus == 1) {
            setText("Status", "UP");
        } else {
            setText("Status", "DOWN");
        }
    }
    setText("EnableTime", SFTPSrvInfo.SftpEnableTime);
}

function InitFrameHtml()
{
    var InitUserName = "";
    if (IsDisableUnsafeProtocol() != true) {
        AddSFTPClientEditHtml(InitUserName);
        AddChoosDirHtml();
    }
    AddPwdNoticeHtml();
    return;
}

function ControlTransMode()
{
    top.FTPType = getValue("TransModeSelect");

    if ("FTP" == top.FTPType) {
        setDisplay("ConfigForm", 1);
        setDisplay("SvrConfigForm", 1);
        setDisplay("SFTPSvrConfigForm", 0);
        setDisplay("SFTPClientConfigForm", 0);
    } else {
        setDisplay("ConfigForm", 0);
        setDisplay("SvrConfigForm", 0);
        setDisplay("SFTPSvrConfigForm", 1);
        setDisplay("SFTPClientConfigForm", 1);
    }
}

function InitControl()
{
	ControlTransMode();
	ControlDirMode();
	ControlSFTPServiceEnable();
	setDisplay("SFTPEditPwd", 0);
	setDisplay("WANMaxDurationRow", 0);
	setDisplay("EnableTimeRow", 0);
	setDisable("WANMaxDuration", 1);
	setDisable("EnableTime", 1);
	setDisable("Status", 1);
	return;
}

function title_show_sftp(input)
{
    var div=document.getElementById("title_show_sftp");

    div.style.left = (input.offsetLeft+390)+"px";

    var tip = IsDisableUnsafeProtocol() ? 's0669sftp': 's0647sftp';
    div.innerHTML = UsbHostLgeDes[tip];
    div.style.display = '';
}
function title_back_sftp(input)
{
    var div=document.getElementById("title_show_sftp");
    div.style.display = "none";
}

function LoadFrame()
{
    init();

    if (CfgModeWord.toUpperCase() == "EGVDF2") {
        $("#vdfPwdStrengthServerRow").css("display", "none");
        var pwdCheck = document.getElementById('vdfPwdStrengthServerCol');
        pwdCheck.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwdvdfserver" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue6" BindText="amp_pwd_strength_low"></span></div></div>';
        CheckEnableProtocolType();

        $("#vdfSftpPwdStrengthServerRow").css("display", "none");
        var pwdCheck = document.getElementById('vdfSftpPwdStrengthServerCol');
        pwdCheck.innerHTML =' <div class="row hidden-pw-row" id="psd_checksftppwdvdfserver" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></span></div></div>';
    }

    if (IsGlobeFlag == 1) {
        setDisable('FtpdEnable',1);
        setDisable('SrvUsername',1);
        setDisable('Srvpassword',1);
        setDisable('SrvClDevType',1);
        setDisable('RootDirPath',1);
        setDisable('btnDownSrvApply',1);
        setDisable('btnDownSrcCancle',1);
        setDisable('table_downloadinfo',1);
        setDisable('URL',1);
        setDisable('Port',1);
        setDisable('Username',1);
        setDisable('Userpassword',1);
        setDisable('SaveAsPath_text',1);
        setDisable('SaveAsPath_button',1);
        setDisable('btnDown',1);
    }

    if (USBROLIST != "OK") {
        AlertEx(GetUSBRoInfoText());
    }

    if (PwdTipsFlag == 1) {
        var pwdcheck1 = document.getElementById('checkinfo1');
        pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="s0558"></span> </div></div>';
    }

    if ((useSftp()) || (IsDisableUnsafeProtocol())) {
        var enable = getCheckVal('FtpdEnable');
        if ((enable == 1) || (enable == '1')) {
            setDisplay("ftpwarningRow",1);
        } else {
            setDisplay("ftpwarningRow",0);
        }
        
        InitFrameHtml();
        InitCfgInfo();
        InitControl();
    } else {
        setDisplay("ftpwarningRow",0);
        setDisplay("ModeConfigForm",0);
        setDisplay("SFTPConfigForm", 0);
        setDisplay("SFTPSvrConfigForm", 0);
        setDisplay("SFTPClientConfigForm", 0);
        setDisplay("SFTPEditPwd", 0);
    }
    if (IsDisableUnsafeProtocol()) {
        setDisplay("SvrConfigForm", 0);
        setDisplay("SFTPSvrConfigForm", 1);
        setDisplay("SFTPClientConfigForm", 1);
    }

	if (CfgMode.toUpperCase() == "TELECOM2") {
		document.getElementById("accessURL").href = "ftp://" + IpAddr + ":" + ftpsrvcfg.ftpport;
		document.getElementById("accessURL").innerHTML = "ftp://" + IpAddr + ":" + ftpsrvcfg.ftpport;
		document.getElementById('accessPathModule').style.display = 'block';
	}

    if (CfgMode.toUpperCase() == "EGVDF2") {
        document.getElementById("sftpPwdNotice").innerHTML = UsbHostLgeDes["s0669sftp"];
    }

    return;
}

function CheckEnableProtocolType()
{
    var unsafePclStr = "FTP";
    var confirmStr = "Enabling ";

    $("#FtpdEnable").unbind("click");
    $("#FtpdEnable").click(function()
    {
        var confirmStr = usbHostPrompteDes['ssmp_confirm_protocol_enable'] + unsafePclStr + usbHostPrompteDes['ssmp_confirm_protocol_right'];
        if (getElement("FtpdEnable").checked == true) {
            if (ConfirmEx(confirmStr) == false) {
                setCheck("FtpdEnable", 0);
                return;
            }
        }
    });
}

function vdfPwdStrengthServer(id, checkId)
{
    egvdfPwdStrengthcheck(id, checkId);
}

function egvdfPwdStrengthcheck(id, pwdid)
{
    var score = 0;
    var password = getElementById(id).value;

    if (password.match(/[a-z]/)) {
        score++;
    }

    if (password.match(/[A-Z]/)) {
        score++;
    }

    if (password.match(/\d/)) {
        score++;
    }

    if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) {
        score++;
    }

    if (password.length < 8) {
        score = 1;
    }

    if (score < 2) {
        getElementById(pwdid).innerHTML = usbHostPrompteDes['ssmp_pwd_strength_low'];
        getElementById(pwdid).style.width=23+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FF0000";
    } else if (score == 2) {
        getElementById(pwdid).innerHTML = usbHostPrompteDes['ssmp_pwd_strength_medium'];
        getElementById(pwdid).style.width=60+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FFA500";
    } else if (score >= 3) {
        getElementById(pwdid).innerHTML = usbHostPrompteDes['ssmp_pwd_strength_high'];
        getElementById(pwdid).style.width=100+"%";
        getElementById(pwdid).style.borderBottom="10px solid #008000";
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
    var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
    if (IsDisableUnsafeProtocol()) {
        if ((CfgMode.toUpperCase() == 'CHINAEBG4') && ((ProductName == "W626E") || (ProductName == "W826E"))) {
            HWCreatePageHeadInfo("USBHOST", GetDescFormArrayById(UsbHostLgeDes, "s0659sftp"), GetDescFormArrayById(UsbHostLgeDes, "s0660sftp_ebg"), false);
        } else {
            HWCreatePageHeadInfo("USBHOST", GetDescFormArrayById(UsbHostLgeDes, "s0659sftp"), GetDescFormArrayById(UsbHostLgeDes, "s0660sftp"), false);
        }
    } else if (useSftp()) {
        HWCreatePageHeadInfo("USBHOST", GetDescFormArrayById(UsbHostLgeDes, "s0538_tedata"), GetDescFormArrayById(UsbHostLgeDes, "s0539_tedata"), false);
    } else if (CfgMode === 'TTNET2') {
        HWCreatePageHeadInfo("USBHOST", GetDescFormArrayById(UsbHostLgeDes, "s0538"), GetDescFormArrayById(UsbHostLgeDes, "s0539_ttnet"), false);
    } else {
        if ((CfgMode.toUpperCase() == 'CHINAEBG4') && ((ProductName == "W626E") || (ProductName == "W826E"))) {
            HWCreatePageHeadInfo("USBHOST", GetDescFormArrayById(UsbHostLgeDes, "s0538"), GetDescFormArrayById(UsbHostLgeDes, "s0539_ebg"), false);
        } else {
            HWCreatePageHeadInfo("USBHOST", GetDescFormArrayById(UsbHostLgeDes, "s0538"), GetDescFormArrayById(UsbHostLgeDes, "s0539"), false);
        }
    }

    if ("frame_itvdf" == frame)
    {
        $("#USBHOST").before("<h1>"+GetLanguageDesc("s0548")+"</h1>");
    }
    </script>
	
	<form id="ModeConfigForm" action="" style="display:none">
		<div class="title_spread"></div>
		<div class="func_title" BindText="s0601sftp"></div>
		<table id="" width="100%" cellspacing="1" cellpadding="0">
		<tr border="1" id="TransModeRow">
			<td class="table_title width_per25" id="WanModeColleft" BindText="s0602sftp"></td>
			<td id="TransModeCol" class="table_right width_per75">
				<select id="TransModeSelect" class="Select" realtype="DropDownList" onchange="OnChangeTransmissionMode(this);">
					<option id="1" value="FTP">FTP</option>
				</select>
			</td>
		</tr>
		</table>
	</form>

    <form id="ConfigForm" action="">
        <div class="title_spread"></div>
        <script>
            if (IsDisableUnsafeProtocol()) {
                document.write("<div class=\"func_title\" BindText=\"s0603sftp\"></div>");
            } else {
                document.write("<div class=\"func_title\" BindText=\"s0518\"></div>");
            }
        </script>
        <table id="table_downloadinfo" width="100%" cellspacing="1" cellpadding="0">
             <script>
                if (IsDisableUnsafeProtocol()) {
                    document.write("<li id=\"URL\"          		RealType=\"TextBox\"      DescRef=\"s0665sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"256\"   ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                    document.write("<li id=\"Port\"         		RealType=\"TextBox\"      DescRef=\"s051a\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"5\"     ElementClass=\"UserPort\"  InitValue=\"Empty\"/>");
                    document.write("<li id=\"Username\"     		RealType=\"TextBox\"      DescRef=\"s051b\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                    document.write("<li id=\"Userpassword\"       RealType=\"TextBox\"      DescRef=\"s051c\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                } else {
                    document.write("<li id=\"URL\"          		RealType=\"TextBox\"      DescRef=\"s052f\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"256\"   ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                    document.write("<li id=\"Port\"         		RealType=\"TextBox\"      DescRef=\"s051a\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"5\"     ElementClass=\"UserPort\"  InitValue=\"Empty\"/>");
                    document.write("<li id=\"Username\"     		RealType=\"TextBox\"      DescRef=\"s051b\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                    document.write("<li id=\"Userpassword\"       RealType=\"TextBox\"      DescRef=\"s051c\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                }
            </script>
            <li id="SaveAsPath_text"    RealType="TextOtherBox" DescRef="s051e" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="Empty" MaxLength="256"    ElementClass="UserInput SaveAsPath_textClass" disabled="disabled" InitValue="[{Item:[{AttrName:'id', AttrValue:'UrlBase'},{AttrName:'type', AttrValue:'text'}, {AttrName:'style', AttrValue:'display:none'}, {AttrName:'maxlength', AttrValue:'256'}]},{Item:[{AttrName:'id', AttrValue:'SaveAsPath_button'},{AttrName:'name', AttrValue:'SaveAsPath_button'},{AttrName:'type', AttrValue:'button'}, {AttrName:'class', AttrValue:'CancleButtonCss browserbutton thickbox'}, {AttrName:'value', AttrValue:'s1605'}, {AttrName:'title', AttrValue:'s1436'}, {AttrName:'alt', AttrValue:'../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true'}]}]"/>

        </table>
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
			var formid_hide_id = null;

			HWParsePageControlByID("ConfigForm", TableClass, UsbHostLgeDes, formid_hide_id);
            if (IsDisableUnsafeProtocol()) {
                document.getElementById("URL").value = "sftp://";
                document.getElementById("Port").value = "22";
            } else {
                if ((CfgMode.toUpperCase() != "TELMEXVULA") && (CfgMode.toUpperCase() != "TELMEXACCESS") &&
                    (CfgMode.toUpperCase() != "TELMEXRESALE") && (isMegacablePWD !== '1')) {
                    document.getElementById("URL").value = "ftp://";
                    document.getElementById("Port").value = "21";
                } else {
                    document.getElementById("URL").value = "";
                    document.getElementById("Port").value = "";
                }
            }
            
			
			if (!IsTelmex)
			{
				document.getElementById('SaveAsPath_textRemark').style.display = "none";
			}
		</script>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="button" name="btnDown" id="btnDown" style= "width: 130px;" class="ApplyButtoncss buttonwidth_100px" BindText="s051f" onClick='Submit()'>
				</td>
			</tr>
		</table>

		<div class="func_spread"></div>
		<script type="text/javascript">
			if (rosunionGame == "1") {
				$("#btnDown").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
			}
			var UsbConfiglistInfo = new Array(new stTableTileInfo("s0528", null, "Username", false, 10),
											  new stTableTileInfo("s0529", null, "UserPassword"),
											  new stTableTileInfo("s052a", null, "Port"),
											  new stTableTileInfo((IsDisableUnsafeProtocol() ? "s0666sftp" : "s0530"), null, "URL", false, 30),
											  new stTableTileInfo("s052b", null, "LocalPath", false, 30),
											  new stTableTileInfo("s0520", null, "Status", false, 8),
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
	</form>

	<form id="SvrConfigForm" action="">
		<div class="title_spread"></div>
		<script language="JavaScript" type="text/javascript">
			if (ftpmode == '1') {
				document.write("<div class=\"func_title\" BindText=\"s0700ftps\"></div>");
			} else {
				document.write("<div class=\"func_title\" BindText=\"s0521\"></div>");
			}
		</script>
		<table id="table_downloadinfo" width="100%" cellspacing="1" cellpadding="0">
			<li id="FtpdEnable"   RealType="CheckDivBox"  DescRef="s0524" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:310px; border:solid 1px #999999; background:#edeef0;'}]}]" ClickFuncApp="onClick=SetFtpEnable"/>
			<li id="ftpwarning"  RealType="HorizonBar"   DescRef="s0561" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="ftpwarning" InitValue="Empty"/>
			<li id="SrvUsername"  RealType="TextBox"      DescRef="s051b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
			<li id="Srvpassword"  RealType="TextBox"      DescRef="s051c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty" ClickFuncApp="onmouseover=title_show;onmouseout=title_back"/>
			<script>
				if (CfgModeWord.toUpperCase() == "EGVDF2") {
					document.write("<li id=\"vdfPwdStrengthServer\"       RealType=\"TextBox\"      DescRef=\"s0557\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
				}
			</script>
			
			<li id="checkinfo1" RealType="HtmlText"  DescRef="s0557" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;" />
			<li id="SrvPort"      RealType="TextBox"      DescRef="s051a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" MaxLength="5" ElementClass="UserPort" InitValue="Empty"/>
			<li id="SrvClDevType" RealType="DropDownList" DescRef="s051d" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" Elementclass="UserInput" ClickFuncApp="onClick=onChangeDev;onChange=onSelectDev"/>
			<li id="RootDirPath"  RealType="TextBox"      DescRef="s0525" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
		</table>

		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("SvrConfigForm", null);
			var formid_hide_id = null;

			HWParsePageControlByID("SvrConfigForm", TableClass, UsbHostLgeDes, formid_hide_id);
			if(1 == IsItVdf){
				$("#SrvClDevType").remove();
				$('#SrvClDevTypeCol').html('<div class="iframeDropLog"><div id="IframeDropdownCorver" class="IframeDropdownCorver"></div><div id="IframeUSBHost" class="IframeDropdown"></div></div>');
				WriteDeviceOption('SrvClDevType');
			}
			else{
				WriteDeviceOption('SrvClDevType');
			}
			
            if (CfgModeWord.toUpperCase() == "EGVDF2") {
                $('#Srvpassword').on('keyup',function(){
                    $("#vdfPwdStrengthServerRow").css("display", "");
                    $("#psd_checkpwdvdfserver").css("display", "block");
                    vdfPwdStrengthServer("Srvpassword", "pwdvalue6");
                });
            } else {
                $('#Srvpassword').on('keyup',function(){
                    if (PwdTipsFlag ==1)
                    {
                        $("#checkinfo1Row").css("display", "");
                        $("#psd_checkpwd").css("display", "block");
                        psdStrength();
                    }
                });
            }

			if (ftpmode == '1') {
				getElementById("FtpdEnableColleft").innerHTML=GetLanguageDesc('s0701ftps');
			}
		</script>
		<div id="accessPathModule" class="accessPathStyle" style="display:none">
			<div id= "accessPath" class="accessTitle">
				<script>
					document.getElementById("accessPath").innerHTML = UsbHostLgeDes["s0703ftps"];
				</script>
			</div>
			<div class="accessValue">
				<a id= "accessURL" href="" target="_blank" style="text-decoration: underline;">ftp://192.168.1.1</a>
			</div>
		</div>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>" />
					<input type="button" name="btnDownSrvApply"  id="btnDownSrvApply"  class="ApplyButtoncss  buttonwidth_100px" BindText="s0526" onClick='SrvSubmit()' />
					<input type="button" name="btnDownSrcCancle" id="btnDownSrcCancle" class="CancleButtonCss buttonwidth_100px" BindText="s0527" onClick='Cancleconfig()' />
				</td>
			</tr>
		</table>
	</form>
	<div id="SFTPClientConfigForm">
	<div class="title_spread"></div>
	
	<script type="text/javascript">
        if (IsDisableUnsafeProtocol()) {
            document.write("<div class=\"func_title\" BindText=\"s0619sftp\"></div>");
        } else {
            document.write("<div class=\"func_title\" BindText=\"s0603sftp\"></div>");
        }
		var UsbConfiglistInfo = new Array(new stTableTileInfo("s0614sftp", null, "SftpUserName"),
										  new stTableTileInfo("s0616sftp", null, "SftpRoorDir"),
										  new stTableTileInfo("s0617sftp", null, "Permission"),
										  new stTableTileInfo("s0618sftp", null, "EnableAccount"),null);
		ShowListControlInfo();
	</script>	
	<form id="SFTPConfigForm" style="display:none">
        <div id = "sftpPwdNotice" class="tabal_pwd_notice"
        style="display:none; height: 400px; font-size: 14px; margin-bottom: -400px; margin-top: 10px; margin-left: 400px; width: 260px;"
        BindText="s0647sftp" ></div>

		<table id="table_downloadinfo" width="100%" cellspacing="1" cellpadding="0">
        <script type="text/javascript">
            if (IsDisableUnsafeProtocol()) {
                document.write("<li id=\"SFTPUsername\"        RealType=\"TextBox\"         DescRef=\"s0604sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                document.write("<li id=\"SFTPUserpassword\"    RealType=\"TextBox\"         DescRef=\"s0605sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"Empty\" MaxLength=\"255\"  InitValue=\"Empty\" ClickFuncApp=\"onmouseover=title_show_sftp;onmouseout=title_back_sftp\"/>");
                if (CfgModeWord.toUpperCase() == "EGVDF2") {
					document.write("<li id=\"vdfSftpPwdStrengthServer\" RealType=\"TextBox\" DescRef=\"s0557\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\" ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
				}
                document.write("<li id=\"SFTPConfirmpassword\" RealType=\"TextDivbox\" DescRef=\"s0606sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\"  BindField=\"Empty\" InitValue=\"[{Item:[{AttrName:'id', AttrValue:'title_show_sftp'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:280px;margin-top:-60px; border:solid 1px #999999; background:#edeef0;'}]}]\" />");
                document.write("<li id=\"SaveAsPath_text_account\"    RealType=\"TextOtherBox\" DescRef=\"s051e\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"Empty\" MaxLength=\"256\"    ElementClass=\"UserInput SaveAsPath_textClass\" disabled=\"disabled\" InitValue=\"[{Item:[{AttrName:'id', AttrValue:'UrlBase_account'},{AttrName:'type', AttrValue:'text'}, {AttrName:'style', AttrValue:'display:none'}, {AttrName:'maxlength', AttrValue:'256'}]},{Item:[{AttrName:'id', AttrValue:'SaveAsPath_button_account'},{AttrName:'name', AttrValue:'SaveAsPath_button_account'},{AttrName:'type', AttrValue:'button'}, {AttrName:'class', AttrValue:'CancleButtonCss egvdfbrowserbutton thickbox'}, {AttrName:'value', AttrValue:'s1605'}, {AttrName:'title', AttrValue:'s1436'}, {AttrName:'alt', AttrValue:'../smblist/smb_choosedir_list.asp?&Choose=2&TB_iframe=true'}]}]\"/>");
            } else {
                document.write("<li id=\"SFTPUsername\"        RealType=\"TextBox\"         DescRef=\"s0604sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                document.write("<li id=\"SFTPUserpassword\"    RealType=\"TextBox\"         DescRef=\"s0605sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                document.write("<li id=\"SFTPConfirmpassword\" RealType=\"TextBox\"         DescRef=\"s0606sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" MaxLength=\"255\"    ElementClass=\"UserInput\" InitValue=\"Empty\"/>");
                document.write("<li id=\"Dirmode\" RealType=\"RadioButtonList\" DescRef=\"s0607sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"[{TextRef:'s0608sftp',Value:'0'},{TextRef:'s0609sftp',Value:'1'}]\" ClickFuncApp=\"onclick=OnChangeDirMode\"/>");
            }
        </script>

			<li id="Privilege"           RealType="RadioButtonList" DescRef="s0610sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="[{TextRef:'s0611sftp',Value:'0'},{TextRef:'s0612sftp',Value:'1'}]"/>			
			<li id="EnableAccount"       RealType="CheckBox"        DescRef="s0613sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
		</table>
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("SFTPConfigForm", null);
			var formid_hide_id = null;
			HWParsePageControlByID("SFTPConfigForm", TableClass20_80, UsbHostLgeDes, formid_hide_id);
            if (CfgModeWord.toUpperCase() == "EGVDF2") {
                $('#SFTPUserpassword').on('keyup',function(){
                    $("#vdfSftpPwdStrengthServerRow").css("display", "");
                    $("#psd_checksftppwdvdfserver").css("display", "block");
                    vdfPwdStrengthServer("SFTPUserpassword", "pwdvalue5");
                });
            }
		</script>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="button" name="btnDownClientApply"  id="btnDownClientApply"  class="ApplyButtoncss  buttonwidth_100px" BindText="s0634sftp" onClick='ClientSubmit()' />
					<input type="button" name="btnDownClientCancle" id="btnDownClientCancle" class="CancleButtonCss buttonwidth_100px" BindText="s0635sftp" onClick='ClientCancle()' />
				</td>
			</tr>
		</table>
		<div class="func_spread"></div>
	</form>
	</div>
	
	<div id="SFTPEditPwd">
		<table width="100%" border="0" cellpadding="0" cellspacing="1">
			<tr id="secUsername">
				<td class="width_per40">
					<form id="SFTPEditPwdForm"  name="PwdChangeCfgForm">
						<table id="PwdChangeCfg" width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF">
							<li id="SFTPEditUserName" RealType="HtmlText" DescRef="s0643sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"  InitValue="Empty"/>
							<li id="SFTPNewPassword"  RealType="TextBox"  DescRef="s0645sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"  InitValue="Empty" onKeyUp="psdStrength()" />
							<li id="SFTPCfmPassword"  RealType="TextBox"  DescRef="s0646sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"  InitValue="Empty"/>
						</table>
						<script>
							var UsbSFTPEditPwdFormList = HWGetLiIdListByForm("SFTPEditPwdForm", null);
							var PwdTableClass = new stTableClass("width_per60", "width_per40");
							HWParsePageControlByID("SFTPEditPwdForm", PwdTableClass, UsbHostLgeDes, null);
						</script>
					</form>
				</td>
				<td class="tabal_pwd_notice width_per60" id="PwdNotice"></td>
			</tr>             
		</table>

		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="button" name="btnSFTPEditApply"  id="btnSFTPEditApply"  class="ApplyButtoncss  buttonwidth_100px" BindText="s0648sftp" onClick='SFTPEditClientSubmit()' />
					<input type="button" name="btnSFTPEditCancle" id="btnSFTPEditCancle" class="CancleButtonCss buttonwidth_100px" BindText="s0649sftp" onClick='SFTPEditClientCancle()' />
				</td>
			</tr>
		</table>
	</div>
	
	<div class="func_spread"></div>
	<form id="SFTPSvrConfigForm" action="">
    <script type="text/javascript">
        if (!IsDisableUnsafeProtocol()) {
            document.write("<div class=\"func_title\" BindText=\"s0619sftp\"></div>");
        }
    </script>
		<table id="table_downloadinfo" width="100%" cellspacing="1" cellpadding="0">
			<li id="SFTPEnable"        RealType="CheckBox"  DescRef="s0620sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" ClickFuncApp="onclick=OnChangeSFTPEnable"/>
			<li id="SFTPwarning"       RealType="HorizonBar"   DescRef="s0641sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
            <script type="text/javascript">
                if (IsDisableUnsafeProtocol()) {
                    document.write("<li id=\"LANWANEnable\"      RealType=\"CheckBoxList\"  DescRef=\"s0621sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"[{TextRef:'s0622sftp',Value:'0'}]\"/>");
                    document.write("<li id=\"SFTPPort\"          RealType=\"TextBox\"  DescRef=\"s0624sftp\" RemarkRef=\"s0661sftp\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"Empty\"/>");
                } else {
                    document.write("<li id=\"LANWANEnable\"      RealType=\"CheckBoxList\"  DescRef=\"s0621sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"[{TextRef:'s0622sftp',Value:'0'},{TextRef:'s0623sftp',Value:'0'}]\"/>");
                    document.write("<li id=\"SFTPPort\"          RealType=\"CheckBox\"  DescRef=\"s0624sftp\" RemarkRef=\"s0625sftp\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"Empty\" ClickFuncApp=\"onclick=OnChangeSFTPPort\"/>");
                }
            </script>
			<li id="MaximumIdleTime"   RealType="TextBox"  DescRef="s0626sftp" RemarkRef="s0628sftp" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" />
            <script type="text/javascript">
                if (IsDisableUnsafeProtocol()) {
                    document.write("<li id=\"Status\" RealType=\"HtmlText\"   DescRef=\"s0629sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"Empty\"/>");
                } else {
                    document.write("<li id=\"Status\" RealType=\"TextBox\"   DescRef=\"s0629sftp\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"Empty\" InitValue=\"Empty\"/>");
                }
            </script>
			<li id="WANMaxDuration"    RealType="TextBox"   DescRef="s0630sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
			<li id="EnableTime"        RealType="TextBox"   DescRef="s0631sftp" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
		</table>
		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("SFTPSvrConfigForm", null);
			var formid_hide_id = null;
			HWParsePageControlByID("SFTPSvrConfigForm", TableClass, UsbHostLgeDes, formid_hide_id);
		</script>
		
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="button" name="btnSFTPSrvApply"  id="btnSFTPSrvApply"  class="ApplyButtoncss  buttonwidth_100px" BindText="s0632sftp" onClick='SFTPSrvSubmit()' />
					<input type="button" name="btnSFTPSrvCancle" id="btnSFTPSrvCancle" class="CancleButtonCss buttonwidth_100px" BindText="s0633sftp" onClick='SFTPSrvCancle()' />
				</td>
			</tr>
		</table>
	</form>	

	<script>
		ParseBindTextByTagName(UsbHostLgeDes, "div",    1);
		ParseBindTextByTagName(UsbHostLgeDes, "td",     1);
		ParseBindTextByTagName(UsbHostLgeDes, "input",  2);
		ParseBindTextByTagName(UsbHostLgeDes, "h1",     1);
	</script>
</body>
</html>
