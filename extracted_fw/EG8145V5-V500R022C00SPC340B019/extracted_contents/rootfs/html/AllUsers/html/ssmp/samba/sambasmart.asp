<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link type='text/css' rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>'>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link type="text/css" rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" media="screen" />
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script type="text/javascript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
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
</style>

<script type="text/javascript">
	try
	{
		document.execCommand('BackgroundImageCache', false, true);
	}
	catch(e)
	{}
</script>
<script type="text/javascript">
function stDftPrinter(domain, PrinterEnable, PrinterName)
{
	this.domain = domain;
	this.PrinterEnable = PrinterEnable;
	this.PrinterName = PrinterName;
}

function stSambaAuthConfigPanelInfo(domain,Username,Enable,Password,X_HW_AllPath,X_HW_Permissions,Name)
{
	this.domain = domain;
	this.Username = Username;
	this.Enable = Enable;
	this.Password = Password;
	this.X_HW_AllPath = parseInt(X_HW_AllPath);
	this.X_HW_Permissions = parseInt(X_HW_Permissions);
	this.Name = Name;
}

function stUseracc(domain,UserReference,Permissions)
{
	this.domain = domain;
	this.UserReference = UserReference;
	this.Permissions = Permissions;
}

function stLogicfolder(domain,Name,X_HW_NameNative)
{
	this.domain = domain;
	this.Name = Name;
	this.X_HW_NameNative = X_HW_NameNative;
}

function stLogicfolderinfo(domain,Name,Enable)
{
	this.domain = domain;
	this.Name = Name;
	this.Enable = Enable;
}

function stUSBDevice(domain, DeviceList) {
    this.domain = domain;
    this.DeviceList = DeviceList;
}

var SambaUserPwdString="";
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var SamPWDFeatrue = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';
var IsGlobeFlag = '<%HW_WEB_GetFeatureSupport(FT_MNGT_GLOBE_XD);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GLOBE);%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var MaxUserAccountNum = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.UserAccountNumberOfEntries);%>';
var MaxUserAccountInst = parseInt(MaxUserAccountNum);
var dftPrinters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Printer,Enable|Name,stDftPrinter);%>;
var dftPrinter = dftPrinters[0];

var NetworkProtocolAuthReq  = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.StorageService.1.NetworkServer.NetworkProtocolAuthReq);%>';
var SMBEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.StorageService.1.NetworkServer.SMBEnable);%>';

var UserInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.UserAccount.{i},Username|Enable|Password|X_HW_AllPath|X_HW_Permissions, stSambaAuthConfigPanelInfo);%>;

var useracc = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.LogicalVolume.{i}.Folder.{i}.UserAccess.{i},UserReference|Permissions,stUseracc);%>;
var logicfolder = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.LogicalVolume.{i}.Folder.{i}, Name|X_HW_NameNative,stLogicfolder);%>;
var LogicalVolume = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.LogicalVolume.{i}, Name|Enable,stLogicfolderinfo);%>;
var default_path = "mnt/usb";
var gvar_sambauserwordhide = "********************************";
var EditFlag = "";
var gVar_FolderName_Utf8;
var gVar_FolderName_Native;
var gVar_UserAcc_Permissions;
var folderIndex = 256;
var useraccIndex;
var HideTextFlag = 1;
var Focused = false;
var ProductType = '<%HW_WEB_GetProductType();%>';

var tedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
var UsbDevice = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice,DeviceList,stUSBDevice);%>;
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
var usb1 = null;
var usb2 = null;
var DeviceStr = null;
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';

if (UsbDevice.length > 1) {
    usb1 = UsbDevice[0].DeviceList;
}
if (UsbDevice.length > 2) {
    usb2 = UsbDevice[1].DeviceList;
}
DeviceStr = usb1 + usb2;

function getFolderName(index)
{
	var localIndex = index;
	for(useraccIndex = 0 ; useraccIndex < useracc.length - 1 ; useraccIndex++)
	{
	  if(useracc[useraccIndex].UserReference == UserInfo[localIndex].Username)
		{
			if(useracc[useraccIndex].Permissions == 4)
				gVar_UserAcc_Permissions = false;
			else
				gVar_UserAcc_Permissions = true;
			for(folderIndex = 0 ; folderIndex < logicfolder.length -1 ; folderIndex++)
			{
				var indx = useracc[useraccIndex].domain.indexOf(logicfolder[folderIndex].domain);
				if(indx != -1)
				{
					gVar_FolderName_Utf8 = logicfolder[folderIndex].Name;
					return 0;
				}
			}
			break;
		}
	}
	return -1;
}

function getFolderID(strname)
{
	var logicIndex = 0;
	var tempArrayVolume;
	for(var i = 0 ; i < LogicalVolume.length - 1 ; i++)
	{
		if(strname == LogicalVolume[i].Name)
		{
			tempArrayVolume= LogicalVolume[i].domain.split(".");
			logicIndex = tempArrayVolume[tempArrayVolume.length-1];
			break;
		}
	}
	return logicIndex;
}

function GetLanguageDesc(Name)
{
	return SambaLgeDes[Name];
}

function psdStrength(id)
{
	var score = 0;
	var password1 = getElementById(id).value;
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

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length; i++)
	{
		var b = all[i];
		var c = b.getAttribute("BindText");
		if(c == null)
		{
			continue;
		}
		b.innerHTML = SambaLgeDes[c];
	}

	var all = document.getElementsByTagName("input");
	for (var i = 0; i < all.length; i++)
	{
		var b = all[i];
		var c = b.getAttribute("BindText");
		if(c == null)
		{
			continue;
		}
		b.value = SambaLgeDes[c];
	}
}

function adjustParentHeight()
{
	var ProductType = '<%HW_WEB_GetProductType();%>';
	if (ProductType != '2')
	{
		var dh = getHeight("sambaEnable"), dh1 = getHeight("sambaAuth"), dh2 = getHeight("sambaConfigDiv");
	}
	else
	{
		var dh = getHeight("sambaEnable"), dh1 = getHeight("sambaAuth"), dh2 = getHeight("sambaConfigDiv"), dh3 = getHeight("usb_device_info");	
	}
	var height = getHeight("PageTitle")
				+ (dh  > 0 ? dh  + 10 : 0)
				+ (dh1 > 0 ? dh1 + 10 : 0)
				+ (dh2 > 0 ? dh2 + 10 : 0)
				+ (dh3 > 0 ? dh3 + 30 : 0);
	window.parent.adjustParentHeight("usbsambapage", height);
}

function LoadFrame()
{
	if(1 ==IsGlobeFlag )
	{
		setDisable("sambaEnableBox",1);
		setDisable("NetworkProtocolAuthBar",1);
	}
	loadlanguage();
	setDisplay("SambaEnableForm", SMBEnable);
	adjustAuthList(((NetworkProtocolAuthReq == 1) && (SMBEnable == 1)));
	adjustParentHeight();
	
	$("#checkinfo1Row").css("display", "none");
	if (PwdTipsFlag ==1 )
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="s0558"></span> </div></div>';
	}
}

var gUsbDevInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.PhysicalMedium.{i}, Vendor|Model|SerialNumber|ConnectionType|Capacity|Status|X_HW_Manufacturer|X_HW_Product,stUsbDevInfo);%>;
function stUsbDevInfo(domain, Vendor, Model, SerialNumber, ConnectionType, Capacity, Status, Manufacturer, Product)
{
	this.domain = domain;
	this.Vendor = Vendor;
	this.Model = Model;
	this.SerialNumber = SerialNumber;	
	this.ConnectionType = ConnectionType;
	this.Capacity = Capacity;
	this.Status = Status;
	this.X_HW_Manufacturer = Manufacturer;
	this.X_HW_Product = Product;
}

function isDevOnline(name)
{
	for(index in gUsbDevVolume)
	{
		if(gUsbDevVolume[index] == null)
		{
			continue;
		}
		if(gUsbDevVolume[index].PhysicalReference == name)
		{
			if(gUsbDevVolume[index].Status == "Online")
				return true;
			else
				return false;
		}
	}
	return false;
}

function isSpecialCharacterUnderline(str)
{
	var specia_Reg =/_/;
	var MyReg = new RegExp(specia_Reg);
	if ( MyReg.test(str) )
	{
		return true;
	}
	return false;
}

function isValidAscii(val)
{
	for ( var i = 0 ; i < val.length ; i++ )
	{
		var ch = val.charAt(i);
		if ( ch < ' ' || ch > '~' )
		{
			return false;
		}
	}
	return true;
}

function CheckPwdIsComplex(str, strName)
{
	var i = 0;
    if (str.length < pwdLen) {
		return false;
	}

	if (!CompareString(str, strName) )
	{
		return false;
	}

	if ( isLowercaseInString(str) )
	{
		i++;
	}

	if ( isUppercaseInString(str) )
	{
		i++;
	}

	if ( isDigitInString(str) )
	{
		i++;
	}

	if ( isSpecialCharacterUnderline(str) )
	{
		i++;
	}

	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function pwdHasChanged(item)
{
	if (item.id == 'UserPasswordBar')
	{
		var PwdStr = getValue("UserPasswordBar");
		setText("UserPwddefhideBar", PwdStr);
	}
	else
	{
		var PwdStr = getValue("UserPwddefhideBar");
		setText("UserPasswordBar", PwdStr);
	}
}

function CheckForm()
{
	var name = $.trim(getValue('UserNameBar'));
	var pwd = HideTextFlag == 1 ? getValue('UserPasswordBar') : getValue('UserPwddefhideBar');
	var firstChar = parseInt(name.charAt(0), 10);
	var needcheck = 0;
	if (name == '')
	{
		AlertEx(SambaLgeDes['s1426']);
		return false;
	}

	if ((name == 'root') || (name == 'admin')) {
		AlertEx(SambaLgeDes['s1427']);
		return false;
	}

	for(var i = 0; i < UserInfo.length-1; i++)
	{
		if(selctIndex == i)
		{
			continue;
		}
		if(name == UserInfo[i].Username)
		{
			AlertEx(SambaLgeDes['s1428']);
			return false;
		}
	}

	if(((firstChar >= 0) && (firstChar <= 9 )))
	{
		AlertEx(SambaLgeDes['s1438']);
		return false;
	}
	for(var i = 0; i < name.length; i++)
	{

		var pChar = parseInt(name.charAt(i),10);
		if(!(((pChar >= 0) && (pChar <= 9 )) || (name.charAt(i) == '_') ||((name.charAt(i) >= 'a') && (name.charAt(i) <= 'z'))))
		{
			AlertEx(SambaLgeDes['s1429']);
			return false;
		}
	}

	if(pwd == '')
	{
		AlertEx(SambaLgeDes['s1430']);
		return false;
    }

    if (pwd !== '***sensitive data replaced***') {
        for(var i = 0; i < pwd.length; i++) {
            var pChar = parseInt(pwd.charAt(i),10);
            if(!(((pChar >= 0) && (pChar <= 9 )) || (pwd.charAt(i) == '_') ||
                ((pwd.charAt(i) >= 'a')&&(pwd.charAt(i) <= 'z')) ||
                ((pwd.charAt(i) >= 'A')&&(pwd.charAt(i) <= 'Z')))) {
                AlertEx(SambaLgeDes['s1440']);
                return false;
            }
        }
	}

    if((pwd !== '***sensitive data replaced***') && !CheckPwdIsComplex(pwd, name)) {
        if ((SamPWDFeatrue == 1) || (tedataGuide == 1)) {
			AlertEx(SambaLgeDes['s1442']);
			return false;
		}
		if(ConfirmEx(SambaLgeDes['s1439']))
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	return true;
}

function HWAjaxConfigForm()
{
	var CheckResult;
	var ConfigDir = getValue('UrlUtf');
	var AccessPathType = getRadioVal('SharepathRadioBar');
	var AccessPath = (1 == AccessPathType) ? (default_path):(default_path+ConfigDir);

	var AjaxSpecSMBConfigParaList = new Array(new stSpecParaArray("x.Username","hello", 0),
											  new stSpecParaArray("y.Name",AccessPath, 0),
											  new stSpecParaArray("ERROR","x.Username", 4),
											  new stSpecParaArray("x.X_HW_Token",getValue('onttoken'), 4));
	var Form = new webSubmitForm();

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : 'ajaxset.cgi?x=' +'InternetGatewayDevice.Services.StorageService.1.UserAccount&ERROR=ERROR' + '&RequestFile=html/ssmp/samba/sambasmart.asp',
		data :HWAddParameterByFormId(null, SambaConfigFormList, AjaxSpecSMBConfigParaList, null),
		success : function(data) {
			CheckResult=data;
		}
	});

	var CfgResult = dealDataWithStr(CheckResult)[0];
	AlertEx("CfgResult.Result = " + CfgResult.Result + " CfgResult.ErrorAttr = " + CfgResult.ErrorAttr + " CfgResult.ErrorCode = " + CfgResult.ErrorCode);

	var ErrorId = HWGetIdByBindField(SambaConfigFormList, CfgResult.ErrorAttr);

	document.getElementById(ErrorId).style.backgroundColor="#FF0000";
}

function DeleteLineRow()
{
   var tableRow = getElementById("SambaConfigList");
   if (tableRow.rows.length > 2)
   tableRow.deleteRow(tableRow.rows.length-1);
   return;
}

function CancelConfig()
{
	setControl(selctIndex,"");
	SetSambaConfigShow(0);
	$("#checkinfo1Row").css("display", "none");
	if(EditFlag == "ADD")
	{
		DeleteLineRow();
	}
	return;
}

function SetSambaConfigShow(flag)
{
	setDisplay("sambaConfigDiv",   flag);
	setDisplay("ConfigPanelButtons", flag);
	adjustParentHeight();
	return;
}

function DisplayMaskedPasswordDescSpan(flag)
{
	var disp = "none;";
	
	if (ProductType == '2')
	{
		var spans = document.all["showpwdspanDecode"];
	}
	else
	{
		var spans = new Array();
		var els=document.getElementsByTagName('*');
		for(var i=0;i<els.length;i++) {
			if(els[i].id=='showpwdspanDecode') spans.push(els[i]);
		}
	}
	
	if (1 == flag)
	{
		disp=";";
	}

	spans[0].setAttribute("style","display:"+disp);
	spans[1].setAttribute("style","display:"+disp);
	spans[0].style.cssText="display:"+disp;
	spans[1].style.cssText="display:"+disp;
}

function OnFocusMasked()
{
	if (false == Focused)
	{
		setText("UserPasswordBar", "");
		DisplayMaskedPasswordDescSpan(1);

		if (1 == HideTextFlag)
		{
			setDisplay("PaswordSambaPwdCheck", 1);
			setDisplay("TextSambaPwdCheck", 0);
		}
		else
		{
			setDisplay("PaswordSambaPwdCheck", 0);
			setDisplay("TextSambaPwdCheck", 1);
		}
		
		Focused = true;
	}
}

function ShowOrHideText(id)
{
	if(getCheckVal(id) == 1 )
	{
		HideTextFlag = 1;
		setCheck("PaswordSambaPwdCheck", 1);
		setCheck("TextSambaPwdCheck", 0);
		var tmpstr = getValue("UserPwddefhideBar");
		setText("UserPasswordBar", tmpstr);
		document.getElementById('UserPasswordBarRow').style.display="";
		document.getElementById('UserPwddefhideBarRow').style.display="none";
		
	}
	else
	{
		HideTextFlag = 0;
		setCheck("PaswordSambaPwdCheck", 0);
		setCheck("TextSambaPwdCheck", 0);
		var tmpstr = getValue("UserPasswordBar");
		setText("UserPwddefhideBar", tmpstr);
		document.getElementById('UserPasswordBarRow').style.display="none";
		document.getElementById('UserPwddefhideBarRow').style.display="";
	}
	
	DisplayMaskedPasswordDescSpan(1);

	if (1 == HideTextFlag)
	{
		setDisplay("PaswordSambaPwdCheck", 1);
		setDisplay("TextSambaPwdCheck", 0);
	}
	else
	{
		setDisplay("PaswordSambaPwdCheck", 0);
		setDisplay("TextSambaPwdCheck", 1);
	}
}

var selctIndex = -1;

function setControl(index, LineId)
{
	this.id = LineId;
	this.Index = index;

	var TableId = this.id.split('_')[0];
	selctIndex = index;

	HideTextFlag = 1;
	Focused = false;
	setCheck("PaswordSambaPwdCheck", 1);
	setCheck("TextSambaPwdCheck", 0);
	setDisplay("UserPasswordBarRow", 1);
	setDisplay("UserPwddefhideBarRow", 0);
	setDisplay("PaswordSambaPwdCheck", 0);
	setDisplay("TextSambaPwdCheck", 0);
	DisplayMaskedPasswordDescSpan(0);
	
	if (index == -1)
	{
		if (UserInfo.length-1 >= 8)
		{
			AlertEx(SambaLgeDes['s1432']);
			return;
		}
		else
		{
			EditFlag = "ADD";
			SetSambaConfigShow(1);
			setCheck("PaswordSambaPwdCheck", 1);
			setCheck("TextSambaPwdCheck", 0);
			var AddNewRecord = new stSambaAuthConfigPanelInfo("", "", "", "", "1", "", "");
			HWSetTableByLiIdList(SambaConfigFormList, AddNewRecord, SetSambamConfigSpec);
		}
		setDisable('UserNameBar', 0);
	}
	else if (index == -2)
	{
		;
	}
	else
	{
		SetSambaConfigShow(1);
		setCheck("PaswordSambaPwdCheck", 1);
		setCheck("TextSambaPwdCheck", 0);
		setDisable('UserNameBar', 1);

		var NewRecord = new stSambaAuthConfigPanelInfo();
		NewRecord = HWcloneObject(UserInfo[index], 1);
		
		if(getFolderName(Index) != 0)
		{
			NewRecord.Name = "";
		}
		else
		{
			var shortpathstring = default_path;	
			
			if( -1 != gVar_FolderName_Utf8.indexOf("usb1_1"))
			{
				shortpathstring = "/mnt";
			}
			
			NewRecord.Name = gVar_FolderName_Utf8.substring(shortpathstring.length,gVar_FolderName_Utf8.length);
		}
		
		HWSetTableByLiIdList(SambaConfigFormList, NewRecord, SetSambamConfigSpec);
	}

	setDisable('btnSmbApply', 0);
	setDisable('cancelValue', 0);
}

function SambaConfigListselectRemoveCnt(obj)
{
}

function DeleteSinglePathUser(Form, index)
{
	var localIndex = index;
	var domain1;
	var domain2;
	for(useraccIndex = 0 ; useraccIndex < useracc.length - 1 ; useraccIndex++)
	{
		if(useracc[useraccIndex].UserReference == UserInfo[localIndex].Username)
		{
			domain1 = useracc[useraccIndex].domain;
			Form.addParameter(domain1 , '');

			for(folderIndex = 0 ; folderIndex < logicfolder.length -1 ; folderIndex++)
			{
				var indx = useracc[useraccIndex].domain.indexOf(logicfolder[folderIndex].domain);
				if(indx != -1)
				{
					domain2 = logicfolder[folderIndex].domain;
					Form.addParameter(domain2 , '');
					break;
				}
			}
		}
	}

	Form.addParameter(UserInfo[index].domain, '');
}

function stDelete(form,index)
{
	return UserInfo[index].X_HW_AllPath == 0 ? DeleteSinglePathUser(form,index) : form.addParameter(UserInfo[index].domain, '');
}

function clickRemove(TableID, ButtonName)
{
	var Form = new webSubmitForm();
	var cnt = 0;
	var previd = TableID.split("_")[0];
	var rmlId = previd + "rml";

	var rml = getElement(rmlId);

	if (rml != null)
	{
		with (document.forms[0])
		{
			if (rml.length > 0)
			{
				for (var i = 0; i < rml.length; i++)
				{
					if (rml[i].checked == true)
					{
						stDelete(Form,i);
						cnt++;
					}
				}
			}
			else if (rml.checked == true)
			{
				stDelete(Form,0);
				cnt++;
			}
		}

		if( 0 != cnt)
		{
			Form.setAction('del.cgi?RequestFile=html/ssmp/samba/sambasmart.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
		}
	}
}

var SambaAuthEnableFormList = new Array();
var SambaConfigFormList = new Array();

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function SubmitSMBConfigForm()
{
	var SambaName = $.trim(getValue('UserNameBar'));

	var AccessMode =  (1 == getSelectVal('PermissionSeleteBar')) ? 6 : 4;

	var ConfigDir = getValue('UrlUtf');
	var AccessPathType = getRadioVal('SharepathRadioBar');
	var AccessPath = (1 == AccessPathType) ? (default_path):(default_path+ConfigDir);
	var pwd = HideTextFlag == 1 ? getValue('UserPasswordBar') : getValue('UserPwddefhideBar');

	if('0' == AccessPathType)
	{
		if(ConfigDir == "")
		{
			AlertEx(SambaLgeDes['s1431']);
			return false;
		}
	}

	var SpecSMBConfigParaList = new Array(new stSpecParaArray("x.Username", SambaName, 0),
										  new stSpecParaArray("y.Name",AccessPath, 0),
										  new stSpecParaArray("x.Password",pwd, 0));

	var Parameter = {};
	Parameter.OldValueList = null;
	Parameter.FormLiList = SambaConfigFormList;
    if (pwd === '***sensitive data replaced***') {
        var userPasswordIndex = SambaConfigFormList.indexOf("UserPasswordBar");
        SambaConfigFormList.splice(userPasswordIndex, 1);
    }
	var ConfigUrl = "";
	var tokenvalue = getValue('onttoken');
	Parameter.asynflag = null;

	var ulret = CheckForm();
	if (ulret != true )
	{
		return false;
	}

	if( selctIndex == -1 )
	{
		if(AccessPathType == 0)
		{
			var AddPara2 = new stSpecParaArray("z.UserReference", SambaName, 4);
			SpecSMBConfigParaList.push(AddPara2);
			var AddPara3 = new stSpecParaArray("z.Permissions", AccessMode, 4);
			SpecSMBConfigParaList.push(AddPara3);
			var tempath = ConfigDir.split("/");
			var indexid = getFolderID(tempath[1]);
			if(ProductType != '2' && indexid == 0)
			{
				AlertEx(SambaLgeDes['s1443']);
				return false;
			}

			ConfigUrl = 'addcfg.cgi?x=' + 'InternetGatewayDevice.Services.StorageService.1.UserAccount' +
						'&y=' + 'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder' +
						'&z=y.UserAccess' + '&RequestFile=html/ssmp/samba/sambasmart.asp';
		}
		else
		{
			ConfigUrl = 'addcfg.cgi?x=' +'InternetGatewayDevice.Services.StorageService.1.UserAccount' + '&RequestFile=html/ssmp/samba/sambasmart.asp';
		}

		Parameter.SpecParaPair = SpecSMBConfigParaList;
	}
	else
	{
		var AddPara2 = new stSpecParaArray("Addconnect_z.UserReference", SambaName, 4);
		SpecSMBConfigParaList.push(AddPara2);
		var AddPara3 = new stSpecParaArray("Addconnect_z.Permissions", AccessMode, 4);
		SpecSMBConfigParaList.push(AddPara3);

		var AddPara4 = new stSpecParaArray("Add_y.Name", AccessPath, 4);
		SpecSMBConfigParaList.push(AddPara4);

		var AddPara5 = new stSpecParaArray("Del_y.Name", "", 4);
		SpecSMBConfigParaList.push(AddPara5);

		var AddPara6 = new stSpecParaArray("Del_z.UserReference", "", 4);
		SpecSMBConfigParaList.push(AddPara6);

		var AddPara7 = new stSpecParaArray("Del_z.Permissions", "", 4);
		SpecSMBConfigParaList.push(AddPara7);

		var AddPara8 = new stSpecParaArray("y.Name", "", 2);
		SpecSMBConfigParaList.push(AddPara8);

		Parameter.SpecParaPair = SpecSMBConfigParaList;
		var FolderNameIndex = getFolderName(selctIndex);
		if(AccessPathType == 0)
		{
			var tempath = ConfigDir.split("/");
			var indexid = getFolderID(tempath[1]);
			if(indexid == 0)
			{
				AlertEx(SambaLgeDes['s1443']);
				return false;
			}

			if(1 == UserInfo[selctIndex].X_HW_AllPath || -1 == FolderNameIndex )
			{
				ConfigUrl = 'complex.cgi?x=' + UserInfo[selctIndex].domain +
									  '&Add_y=' + 'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder' +
									  '&Addconnect_z='+'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder'+ '.{i}.UserAccess' +
									  '&RequestFile=html/ssmp/samba/sambasmart.asp';
			}
			else
			{
				var addlogicfolder = logicfolder[folderIndex].domain.substring(0,logicfolder[folderIndex].domain.lastIndexOf('.'));
				ConfigUrl = 'complex.cgi?x=' + UserInfo[selctIndex].domain +
									 '&Del_z=' + useracc[useraccIndex].domain +
									 '&Del_y=' + logicfolder[folderIndex].domain +
									 '&Add_y=' + addlogicfolder +
									 '&Addconnect_z='+addlogicfolder+ '.{i}.UserAccess' +
									 '&RequestFile=html/ssmp/samba/sambasmart.asp';
			}
		}
		else
		{
			if(1 == UserInfo[selctIndex].X_HW_AllPath || -1 == FolderNameIndex)
			{
				ConfigUrl = 'set.cgi?x=' + UserInfo[selctIndex].domain  + '&RequestFile=html/ssmp/samba/sambasmart.asp';
			}
			else
			{
				ConfigUrl = 'complex.cgi?x=' + UserInfo[selctIndex].domain +
										'&Del_z=' + useracc[useraccIndex].domain +
										'&Del_y=' + logicfolder[folderIndex].domain +
										'&RequestFile=html/ssmp/samba/sambasmart.asp';
			}
		}
	}

	var result = HWSetAction(null, ConfigUrl, Parameter, tokenvalue);
	if(result)
	{
		setDisable('ButtonApply',1);
		setDisable('ButtonCancel',1);
	}
	return;
}

function EnableSambaFunc()
{
   var enable = getCheckVal('sambaEnableBox');
    if ((tedataGuide == 1) && (DeviceStr == 'null') && (enable == 1)) {
        AlertEx(SambaLgeDes['s1458']);
        setCheck('sambaEnableBox', 0);
        return;
    }

	var Parameter = {};
	var url = 'set.cgi?x=InternetGatewayDevice.Services.StorageService.1.NetworkServer&RequestFile=html/ssmp/samba/sambasmart.asp';
	var tokenvalue = getValue('onttoken');
	Parameter.asynflag = null;
	Parameter.FormLiList = new Array("sambaEnableBox");
	Parameter.SpecParaPair = null;
	HWSetAction(null, url, Parameter, tokenvalue);
}

function EnableSambaAuthFunc()
{
	var Parameter = {};
	var url = 'set.cgi?x=InternetGatewayDevice.Services.StorageService.1.NetworkServer&RequestFile=html/ssmp/samba/sambasmart.asp';
	var tokenvalue = getValue('onttoken');
	Parameter.asynflag = null;
	Parameter.FormLiList = SambaAuthEnableFormList;
	Parameter.SpecParaPair = null;
	HWSetAction(null, url, Parameter, tokenvalue);
}

function adjustConfigPanel(flag)
{
	setDisplay("UrlUtfRow", flag);
	adjustAuthList(((NetworkProtocolAuthReq == 1) && (SMBEnable == 1)));
	adjustParentHeight();
}

function SetSambamConfigSpec(ControlData)
{
	this.Data = ControlData;
	adjustConfigPanel(this.Data["X_HW_AllPath"] != 1);
}

function ShowChoosePathBrowse()
{
	adjustConfigPanel('1' != getRadioVal('SharepathRadioBar'));
}

function title_show(input)
{
	var div=document.getElementById("title_show");

	if ("ARABIC" == LoginRequestLanguage.toUpperCase())
	{
		div.style.right = (input.offsetLeft + 50) + "px";
	}
	else
	{
		div.style.left = (input.offsetLeft + 372) + "px";
	}

	var sambaTips = (SamPWDFeatrue == 1) ? 'ss1116c_sec' : 'ss1116c';
	div.innerHTML = SambaLgeDes[sambaTips];
	div.style.display = '';
}

function title_back(input)
{
	var div=document.getElementById("title_show");
	div.style.display = "none";
}

function getHeight(id)
{
	var item = document.getElementById(id);
	if (item != null)
	{
		if (item.style.display == 'none')
		{
			return 0;
		}
		if (typeof item.scrollHeight == 'number')
		{
			return item.scrollHeight;
		}
		return null;
	}

	return null;
}

function adjustAuthList(flag)
{
	if (flag)
	{
		var lt = document.getElementById("SambaConfigList_tbl");
		var lh = document.getElementById("FunctionAuth");
		var listDiv = document.getElementById("sambaAuth");
		var oh = (lt != null ? lt.scrollHeight : 0);
		oh += (lh != null ? lh.scrollHeight + 10 : 0);
		listDiv.style.height = oh + 'px';
	}
}

function doUsbOperation(domain, para)
{
	var Form = new webSubmitForm();
	Form.setAction('set.cgi?x=' + domain + '&RequestFile=html/ssmp/samba/sambasmart.asp'); 
	Form.addParameter('x.X_HW_SafeRemove', para);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function formatCapacity(capacity)
{
	if (capacity < 1024)
		return capacity + 'M';
	else if (capacity >= 1024 && capacity < 1024*1024)
		return (capacity/1024).toFixed(2) + 'G';
	else if (capacity >= 1024*1024)
		return (capacity/(1024*1024)).toFixed(2) + 'T';
}

function createTableLine(line, usbDevInfo, hasRemoveBtn)
{
	var lineStyleIndex = (parseInt(line)%2 == 0) ? 2 : 1;
	document.write('<tr class="tabal_0' + lineStyleIndex.toString() + '">');
	document.write('<td>' + usbDevInfo.X_HW_Manufacturer + '</td>');
	document.write('<td>' + usbDevInfo.X_HW_Product + '</td>');
	document.write('<td>' + usbDevInfo.SerialNumber + '</td>');
	//document.write('<td>' + usbDevInfo.ConnectionType + '</td>');
	document.write('<td>' + formatCapacity(parseInt(usbDevInfo.Capacity)) + '</td>');
	
	hasRemoveBtn = true;
	dom = usbDevInfo.domain;
	//<input class="ApplyButtoncss buttonwidth_70px" type="button" id="usbreset" style="margin-top:5px;margin-bottom:5px;" \
	//	bindText="s1450" onClick="doUsbOperation(\'' + dom + '\', 0)"></input>
	if(hasRemoveBtn)
	{
		document.write('<td align="center"><input class="ApplyButtoncss buttonwidth_70px" type="button" \
		id="eject" style="margin-top:5px;margin-bottom:5px;" bindText="s1449" onClick="doUsbOperation(\'' + dom + '\', 1)"></input> \
		</td>');
	}
	else
	{
		document.write('<td>--</td>');
	}
	document.write('</tr>');
}

</script>
<style type="text/css">
.bodyBg{
	background-color:#EDF1F2;
}
.pageTitile{
	height:30px;
	line-height:30px;
	font-size:16px;
	color:#666666;
	font-weight:bold;
}
.enableCheckbox{
	float:left;
	margin-top:10px;
	*margin-top:5px;	/*IE7 compatible*/
}
.configApply{
	float:left;
	width:710px;
	text-align:center;
	position:relative;
	height: auto;
    overflow: hidden;
}
#sambaEnable{
	width:710px;
	height:auto;
	overflow: hidden;
}
#sambaAuth {
	width:710px;
	float:left;
	height: auto;
    overflow: hidden;
}
#sambaConfigDiv {
	width:710px;
	height:auto;
	overflow: hidden;
	position:relative;
}
#sambaConfigDetail {
	width:710px;
	position:relative;
	height: auto;
    overflow: hidden;
}

</style>
</head>
<body onLoad="LoadFrame();" class="bodyBg">
	<div id="MainContent">
	<script>
		if (ProductType == '2')
		{
			document.write('<div id="PageTitle" class="PageTitleCss">');			
			document.write('<span id = "FunctionTitleTextSpan" BindText="s1448"></span>');
			document.write('</div>');
			document.write('<div id="usb_device_info">');
			document.write('<div id="FunctionUsbDevInfo" class="FunctionTitle">');
			document.write('<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>');
			document.write('<div id="FunctionTitleText">');
			document.write('<span id="FunctionTitleTextSpan" class="FunctionTitleTextSpanCss" BindText="s1447"></span>');
			document.write('</div>');
			document.write('</div>');

			document.write('<div class="button_spread"></div>');			
			document.write('<table id="usb_device_table" width="96%" border="0" cellpadding="3" cellspacing="1" class="tabal_bg">');
			document.write('<tbody>');
			document.write('<tr class="head_title">');
			document.write('<td><span BindText="s1451"></span></td>');
			document.write('<td><span BindText="s1456"></span></td>');
			document.write('<td><span BindText="s1452"></span></td>');
												
			document.write('<td><span BindText="s1454"></span></td>');
			document.write('<td><span BindText="s1455"></span></td>');
			document.write('</tr>');

			var line = 1;
						
			for(info in gUsbDevInfo)
			{
				if(gUsbDevInfo[info] == null)
				{continue;}					
							
				if(gUsbDevInfo[info].Status == "Offline")
				{continue;}
				createTableLine(line, gUsbDevInfo[info], true);
				line++;				
			}
						
			document.write('</tbody>');
			document.write('</table>');			
			document.write('<div class="button_spread"></div>');
			document.write('</div>');	
		}
	</script>
        <div id="PageTitle" class="PageTitleCss">
            <script>
                if ((CfgMode.toUpperCase() == 'CHINAEBG4') && ((ProductName == "W626E") || (ProductName == "W826E"))) {
                    document.write('<span id="FunctionTitleTextSpan" BindText="s1444_ebg"></span>');
                } else {
                    document.write('<span id="FunctionTitleTextSpan" BindText="s1444"></span>');
                }
            </script>
        </div>
		<div id="sambaEnable">
			<div id="FunctionSamba" class="FunctionTitle">
				<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>
				<div id="FunctionTitleText">
					<span id="FunctionTitleTextSpan" class="FunctionTitleTextSpanCss">
						<script type="text/javascript">document.write(SambaLgeDes["s1401"]);</script>
					</span>
				</div>
				<div id="FuncEnable" class="enableCheckbox">
					<input id="sambaEnableBox" class="FunctionTitleTextCheckbox" type="checkbox" onClick="EnableSambaFunc();" BindField="x.SMBEnable" RealType="CheckBox" />
				</div>
				<script type="text/javascript">
					var SambaEnableFormList = new Array("sambaEnableBox");
					var SambaEnableArray = new Array();
					SambaEnableArray["SMBEnable"] = SMBEnable;
					HWSetTableByLiIdList(SambaEnableFormList, SambaEnableArray, null);
				</script>
			</div>

			<div class="button_spread"></div>

			<form id="SambaEnableForm">
                <table id="SambaEnableConfigPanel" class="tabal_noborder_bg" width="710px;" cellspacing="1" cellpadding="0">
                    <script>
                        if ((CfgMode.toUpperCase() == 'CHINAEBG4') && ((ProductName == "W626E") || (ProductName == "W826E"))) {
                            document.write('<li id="PrinterInfoBar" RealType="HtmlText" DescRef="s1402_ebg" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PrinterInfoBar" InitValue="Empty"/>');
                        } else {
                            document.write('<li id="PrinterInfoBar" RealType="HtmlText" DescRef="s1402" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PrinterInfoBar" InitValue="Empty"/>');
                        }
                    </script>
                    <li id="NetworkProtocolAuthBar" RealType="CheckBox" DescRef="s1403" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NetworkProtocolAuthReq" InitValue="Empty" ClickFuncApp="onClick=EnableSambaAuthFunc"/>
                </table>
				<script>
					SambaAuthEnableFormList = HWGetLiIdListByForm("SambaEnableForm", null);
					HWParsePageControlByID("SambaEnableForm", TableClass, SambaLgeDes, null);
					var SambaEnableArray = new Array();
					SambaEnableArray["PrinterInfoBar"] = (dftPrinter.PrinterName != "" && SMBEnable == 1) ? dftPrinter.PrinterName : "--";
					SambaEnableArray["NetworkProtocolAuthReq"] = NetworkProtocolAuthReq;
					HWSetTableByLiIdList(SambaAuthEnableFormList, SambaEnableArray, null);
				</script>
			</form>

		</div>

		<div class="button_spread"></div>

		<div id="sambaAuth">
			<div id="FunctionAuth" class="FunctionTitle">
				<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>
				<div id="FunctionTitleText">
					<span id="FunctionTitleTextSpan" class="FunctionTitleTextSpanCss">
						<script type="text/javascript">document.write(SambaLgeDes["s1404"]);</script>
					</span>
				</div>
			</div>
			<div class="button_spread"></div>
			<script type="text/javascript">
				var SambaConfiglistInfo = new Array(new stTableTileInfo("Empty", null, "DomainBox"),
													new stTableTileInfo("s1413", null, "NumIndexBox"),
													new stTableTileInfo("s1414", null, "Username", false, 18),
													new stTableTileInfo("s1415", null, "Enable"),
													new stTableTileInfo("s1416", null, "X_HW_Permissions"),
													new stTableTileInfo("s1417", null, "X_HW_AllPath", false, 32), null);

				var ColumnNum = 6;
				var TableDataInfo =  HWcloneObject(UserInfo, 1);
				for(var i = 0; i < TableDataInfo.length -1; i++)
				{
					if(getFolderName(i) != 0)
					{
						var SpecPath = "undefine";
					}
					else
					{
						var shortpathstring = default_path;	
						
						if( -1 != gVar_FolderName_Utf8.indexOf("usb1_1"))
						{
							shortpathstring = "/mnt";
						}
						
						var SpecPath = gVar_FolderName_Utf8.substring(shortpathstring.length,gVar_FolderName_Utf8.length);
					}
			
					TableDataInfo[i].Enable = TableDataInfo[i].Enable == 1 ? SambaLgeDes["s1418"] : SambaLgeDes["s1419"];
					TableDataInfo[i].X_HW_Permissions = TableDataInfo[i].X_HW_Permissions == 0 ? SambaLgeDes["s1420"] : SambaLgeDes["s1421"];
					TableDataInfo[i].X_HW_AllPath = TableDataInfo[i].X_HW_AllPath == 1 ? '----' : SpecPath;
				}
				HWShowTableListByType(NetworkProtocolAuthReq, "SambaConfigList", 1, ColumnNum, TableDataInfo, SambaConfiglistInfo, SambaLgeDes, null);
				setDisplay("sambaAuth", ((NetworkProtocolAuthReq == 1) && (SMBEnable == 1)));
			</script>
		</div>

		<div class="button_spread"></div>

		<div id="sambaConfigDiv">
			<div id="sambaConfigDetail">
				<form id="SambaAuthConfigForm"  name="SambaAuthConfigForm">
					<table id="SambaAuthConfigPanel" class="tabal_bg" width="710px;" cellspacing="1" cellpadding="0">
						<li id="AuthConfigBar"              RealType="HorizonBar"       DescRef="s1405"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"
						InitValue="Empty"/>
						<li id="UserNameBar"                RealType="TextDivbox"       DescRef="s1406"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Username"    MaxLength="256"
						InitValue="[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:280px; border:solid 1px #999999; background:#edeef0;'}]}]"/>
						<li id="UserPasswordBar"            RealType="TextOtherBox"     DescRef="s1407"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Password"    MaxLength="64"
						InitValue="[{Item:[{AttrName:'id', AttrValue:'PaswordSambaPwdCheck'},{AttrName:'Type', AttrValue:'CheckBox'}, {AttrName:'value', AttrValue:'1'},{AttrName:'style', AttrValue:'display:none'},{AttrName:'onClick', AttrValue:'ShowOrHideText(this.id)'}]} ,{Type:'span', Item:[{AttrName:'id', AttrValue:'showpwdspanDecode'},{AttrName:'Type', AttrValue:'span'},{AttrName:'innerhtml', AttrValue:'s1422'},{AttrName:'style', AttrValue:'display:none'}]}]"
						ClickFuncApp="onmouseover=title_show;onmouseout=title_back;onfocus=OnFocusMasked;"/>
						<li id="UserPwddefhideBar"          RealType="TextOtherBox"     DescRef="s1407"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Password"    MaxLength="64"
						InitValue="[{Item:[{AttrName:'id', AttrValue:'TextSambaPwdCheck'},{AttrName:'Type', AttrValue:'CheckBox'},{AttrName:'value', AttrValue:'1'},{AttrName:'style', AttrValue:'display:none'},{AttrName:'onClick', AttrValue:'ShowOrHideText(this.id)'}]}, {Type:'span', Item:[{AttrName:'id', AttrValue:'showpwdspanDecode'},{AttrName:'Type', AttrValue:'span'},{AttrName:'innerhtml', AttrValue:'s1422'},{AttrName:'style', AttrValue:'display:none'}]}]"
						ClickFuncApp="onmouseover=title_show;onmouseout=title_back"/>
						<li id="checkinfo1" RealType="HtmlText"  DescRef="s0557" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;" />	
						<li id="AuthEnableBar"              RealType="CheckBox"         DescRef="s1408"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"
						InitValue="Empty"/>
						<li id="PermissionSeleteBar"        RealType="DropDownList"     DescRef="s1409"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_Permissions"
						InitValue="[{TextRef:'s1420',Value:'0'},{TextRef:'s1421',Value:'1'}]"/>
						<li id="SharepathRadioBar"          RealType="RadioButtonList"  DescRef="s1410"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_AllPath"
						InitValue="[{TextRef:'s1423',Value:'1'},{TextRef:'s1424',Value:'0'}]" ClickFuncApp="onClick=ShowChoosePathBrowse"/>
						<li id="UrlUtf" disabled="disabled" RealType="TextOtherBox"     DescRef="s1411"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="y.Name"
						InitValue="[{Item:[{AttrName:'id', AttrValue:'UrlBase'},{AttrName:'type', AttrValue:'text'}, {AttrName:'style', AttrValue:'display:none'}]},{Item:[{AttrName:'id', AttrValue:'MediaChooseInput'},{AttrName:'name', AttrValue:'MediaChooseInput'},{AttrName:'type', AttrValue:'button'}, {AttrName:'class', AttrValue:'CancleButtonCss browserbutton thickbox'}, {AttrName:'value', AttrValue:'s1425'}, {AttrName:'title', AttrValue:'s1436'}, {AttrName:'alt', AttrValue:'../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true'}]}]"/>
					</table>
					<script>
						SambaConfigFormList = HWGetLiIdListByForm("SambaAuthConfigForm", null);
						var formid_hide_id = null;
						HWParsePageControlByID("SambaAuthConfigForm", TableClass, SambaLgeDes, formid_hide_id);
						
						$('#UserPasswordBar').on('keyup',function(){
				if(PwdTipsFlag ==1)
				{
					$("#checkinfo1Row").css("display", "");
					$("#checkinfo1Row").css("height", "56px");
					$("#psd_checkpwd").css("display", "block");
					psdStrength("UserPasswordBar");
				}
			});
			$('#UserPwddefhideBar').on('keyup',function(){
				if(PwdTipsFlag ==1)
				{
					$("#checkinfo1Row").css("display", "");
					$("#checkinfo1Row").css("height", "56px");
					$("#psd_checkpwd").css("display", "block");
					psdStrength("UserPwddefhideBar");
				}
			});
					</script>
				</form>
			</div>
	<div class="newBtn" style="height:80px;">
	<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
	<tr>
	<td class='width_per30'></td> 
	<td class="table_submit"> 
	<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
	<input type="button" id="ButtonApply" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitSMBConfigForm();" value="" BindText="s0526">
	<input type="button" id="ButtonCancel" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig(this);" value="" BindText="s0527">
	</td>
	</tr>
	</table>
	</div>
		</div>

	</div>
	<script>
		SetSambaConfigShow(0);
		ParseBindTextByTagName(SambaLgeDes, "span", 1);
	</script>
</body>
</html>
