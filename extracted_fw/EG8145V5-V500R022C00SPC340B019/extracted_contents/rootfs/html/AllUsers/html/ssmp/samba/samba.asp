<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" type="text/css" media="screen" />
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

<script language="JavaScript"type="text/javascript">
try
{
	document.execCommand('BackgroundImageCache', false, true);
}
catch(e)
{}
</script>
<script language="JavaScript" type="text/javascript">
var ProductType = '<%HW_WEB_GetProductType();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';

function stUsbInfo(mntpath, devname)
{
	this.mntpath = mntpath;
	this.devname = devname;
}

function stDftPrinter(domain,PrinterEnable,PrinterName)
{
	this.domain        = domain;
	this.PrinterEnable = PrinterEnable;
	this.PrinterName   = PrinterName;
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

var IsItVdf = '<%HW_WEB_GetFeatureSupport(FT_ITVDF_SUPPORT);%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var SamPWDFeatrue = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';
var UserNameArray = new Array("root", "nobody", "support", "admin", "user", "anonymous", "web", "upnp", "cwmp", "telnetd", "console", "dhcps", "osgi", "cli");
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

var IsGlobeFlag = '<%HW_WEB_GetFeatureSupport(FT_MNGT_GLOBE_XD);%>';
var stUsbInfo = <%HW_WEB_GetUSBAllInfo();%>;
var frame = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_FRAME.STRING);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';


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
var g_configX_HW_Permissions = 0;
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
var username1 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.1.Username);%>';
var username2 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1.UserName);%>';
var username3 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.2.UserName);%>';

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
					gVar_FolderName_Utf8   = logicfolder[folderIndex].Name;
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

function LoadFrame()
{
	if(1 == IsGlobeFlag)
	{
		setDisable('EnableSambaBar',1);
		setDisable('NetworkProtocolAuthBar',1);
		setDisable('Newbutton',1);
		setDisable('DeleteButton',1);
		setDisable('UserNameBar',1);
		setDisable('UserPasswordBar',1);
		setDisable('AuthEnableBar',1);
		setDisable('PermissionSeleteBar',1);
		setDisable('SharepathRadioBar1',1);
		setDisable('SharepathRadioBar2',1);
		setDisable('ButtonApply',1);
		setDisable('ButtonCancel',1);
		setDisable('SambaConfigList_rml0',1);
		setDisable('MediaChooseInput',1);
	}
   if(1==IsPtVdf)
   {
       var enable = getCheckVal('EnableSambaBar');
	
		if(1 == enable || '1' == enable)
		{
			setDisplay("sambawarningRow",1);
		}
		else
		{
		   setDisplay("sambawarningRow",0);
		}
   }
   else
   {
       setDisplay("sambawarningRow",0);
   }	
	loadlanguage();
	$("#checkinfo1Row").css("display", "none");
	if (IsPtVdf ==1 )
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="s0558"></span> </div></div>';
	}
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

function CheckPwdIsComplex(str,strName)
{
	var i = 0;
    if (str.length < pwdLen) {
		return false;
	}

	if (!CompareString(str,strName) )
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

function CheckForm()
{
	var name = $.trim(getValue('UserNameBar'));
	var pwd = HideTextFlag == 1 ? getValue('UserPasswordBar') : getValue('UserPwddefhideBar');
	var firstChar = parseInt(name.charAt(0),10);
	var needcheck=0;
	if (name == '')
	{
		AlertEx(SambaLgeDes['s1426']);
		return false;
	}

    if ((name == username1) || (name == username2) || (name == username3)) {
        AlertEx(SambaLgeDes['s1427']);
        return false;
    }

	if (CfgMode.toUpperCase() == "ROSUNION") {
		for (var i = 0; i < UserNameArray.length; i++) {
			if (name.toLowerCase() == UserNameArray[i]) {	
				AlertEx(SambaLgeDes['s1457']);
				return false;
			}
		}
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

	if(((firstChar >=0) && (firstChar <=9 )))
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

	for(var i = 0; i < pwd.length; i++)
	{

		var pChar = parseInt(pwd.charAt(i), 10);
		if (!( ((pChar >= 0) && (pChar <= 9 ))
			  || (pwd.charAt(i) == '_')
			  || ((pwd.charAt(i) >= 'a') && (pwd.charAt(i) <= 'z'))
			  || ((pwd.charAt(i) >= 'A') && (pwd.charAt(i) <= 'Z'))))
		{
			AlertEx(SambaLgeDes['s1440']);
			return false;
		}
	}

	if (!isValidAscii(pwd))
	{
		AlertEx(SambaLgeDes['s1437']);
		return false;
	}

	if(!CheckPwdIsComplex(pwd,name))
	{
		if( SamPWDFeatrue == 1 )
		{
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

	var AjaxSpecSMBConfigParaList = new Array(new stSpecParaArray("x.Username", "hello", 0),
											  new stSpecParaArray("y.Name", AccessPath, 0),
											  new stSpecParaArray("ERROR", "x.Username", 4),
											  new stSpecParaArray("x.X_HW_Token", getValue('onttoken'), 4));
	var Form = new webSubmitForm();

	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : 'ajaxset.cgi?x=' +'InternetGatewayDevice.Services.StorageService.1.UserAccount&ERROR=ERROR' + '&RequestFile=html/ssmp/samba/samba.asp',
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
	setDisplay("TableSambaAuthConfigForm", flag);
	setDisplay("ConfigPanelButtons", flag);
	return;
}

function DisplayMaskedPasswordDescSpan(flag)
{
	var disp = "none;";
	var spans = new Array();
	var els=document.getElementsByTagName('*');
	for(var i=0;i<els.length;i++) {
		if(els[i].id=='showpwdspanDecode') spans.push(els[i]);
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
		var PwdStr = getValue("UserPwddefhideBar");
		document.getElementById('UserPasswordBarRow').style.display="";
		document.getElementById('UserPwddefhideBarRow').style.display="none";
		setText("UserPasswordBar", PwdStr);
	}
	else
	{
		HideTextFlag = 0;
		setCheck("PaswordSambaPwdCheck", 0);
		setCheck("TextSambaPwdCheck", 0);
		var PwdStr = getValue("UserPasswordBar");
		document.getElementById('UserPasswordBarRow').style.display="none";
		document.getElementById('UserPwddefhideBarRow').style.display="";
		setText("UserPwddefhideBar", PwdStr);
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
			
			if(1 == IsItVdf){
				$("#IframeDropdown").remove();
				$('#PermissionSeleteBarCol').html('<div class="iframeDropLog"><div id="IframeDropdown" class="IframeDropdown"></div></div>');
				var arr = [SambaLgeDes["s1420"],SambaLgeDes["s1421"]];
				createDropdown("IframeDropdown",SambaLgeDes["s1420"],"225px",arr, "SambachooseValue(this);");
			}
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
			
			if (1 == IsPtVdf)
			{
				NewRecord.Name = transPath(NewRecord.Name);
			}
		}
		
		HWSetTableByLiIdList(SambaConfigFormList, NewRecord, SetSambamConfigSpec);
		
		if(1 == IsItVdf){
			$("#IframeDropdown").remove();
			$('#PermissionSeleteBarCol').html('<div class="iframeDropLog"><div id="IframeDropdown" class="IframeDropdown"></div></div>');
			var arr = [SambaLgeDes["s1420"],SambaLgeDes["s1421"]];
			var defaultvalue = NewRecord.X_HW_Permissions == 0 ? SambaLgeDes["s1420"] : SambaLgeDes["s1421"];
			createDropdown("IframeDropdown", defaultvalue,"225px",arr, "SambachooseValue(this);");
		}
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
			Form.setAction('del.cgi?RequestFile=html/ssmp/samba/samba.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
		}
	}
}

var SambaEnableFormList = new Array();
var SambaAuthEnableFormList = new Array();
var SambaConfigFormList = new Array();

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function SubmitSMBConfigForm()
{
	var SambaName = $.trim(getValue('UserNameBar'));

	if(1 == IsItVdf){
		var AccessMode =  (1 == g_configX_HW_Permissions ) ? 6 : 4;
	}
	else{
		var AccessMode =  (1 == getSelectVal('PermissionSeleteBar')) ? 6 : 4;
	}

	var ConfigDir = getValue('UrlUtf');
	if (1 == IsPtVdf)
	{
		var arr = ConfigDir.split("/");
		var newRootDir = ConfigDir;
		if (null != arr && arr.length >= 2)
		{
			newRootDir = GetMntPathByDevName(arr[1]);
			var mntPathArr = newRootDir.split("/");
			if (null != mntPathArr && mntPathArr.length > 3)
			{
				arr[1] = mntPathArr[3];
			}
			
			var ptvdfConfigDir = "/";
			
			for (var i = 0; i < arr.length; ++i)
			{
				if ("" == arr[i])continue;
				if (i == arr.length - 1)
				{
					ptvdfConfigDir += arr[i];
				}
				else
				{
					ptvdfConfigDir += arr[i] + "/";
				}
			}
			
			ConfigDir = ptvdfConfigDir;
		}
	}
	
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

	var SpecSMBConfigParaList = new Array(new stSpecParaArray("x.Username",SambaName, 0),
										  new stSpecParaArray("y.Name",AccessPath, 0),
										  new stSpecParaArray("x.Password",pwd, 0));

	var Parameter = {};
	Parameter.OldValueList = null;
	Parameter.FormLiList = SambaConfigFormList;
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
			if(indexid == 0)
			{
				AlertEx(SambaLgeDes['s1443']);
				return false;
			}

			ConfigUrl = 'addcfg.cgi?x=' + 'InternetGatewayDevice.Services.StorageService.1.UserAccount' +
						'&y=' + 'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder' +
						'&z=y.UserAccess' + '&RequestFile=html/ssmp/samba/samba.asp';
		}
		else
		{
			if(1 == IsItVdf){
				var AddPara10 = new stSpecParaArray("x.X_HW_Permissions", g_configX_HW_Permissions, 1);
				SpecSMBConfigParaList.push(AddPara10);
			}
			
			ConfigUrl = 'addcfg.cgi?x=' +'InternetGatewayDevice.Services.StorageService.1.UserAccount' + '&RequestFile=html/ssmp/samba/samba.asp';
		}

		Parameter.SpecParaPair = SpecSMBConfigParaList;
	}
	else
	{
		if(1 == IsItVdf){
			var AddPara9 = new stSpecParaArray("x.X_HW_Permissions", g_configX_HW_Permissions, 1);
			SpecSMBConfigParaList.push(AddPara9);
		}
		
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
							'&RequestFile=html/ssmp/samba/samba.asp';
			}
			else
			{
				var addlogicfolder = logicfolder[folderIndex].domain.substring(0,logicfolder[folderIndex].domain.lastIndexOf('.'));
				ConfigUrl = 'complex.cgi?x=' + UserInfo[selctIndex].domain +
							'&Del_z=' + useracc[useraccIndex].domain +
							'&Del_y=' + logicfolder[folderIndex].domain +
							'&Add_y=' + addlogicfolder +
							'&Addconnect_z='+addlogicfolder+ '.{i}.UserAccess' +
							'&RequestFile=html/ssmp/samba/samba.asp';
			}
		}
		else
		{
			if(1 == UserInfo[selctIndex].X_HW_AllPath || -1 == FolderNameIndex)
			{
				ConfigUrl = 'set.cgi?x=' + UserInfo[selctIndex].domain  + '&RequestFile=html/ssmp/samba/samba.asp';
			}
			else
			{
				ConfigUrl = 'complex.cgi?x=' + UserInfo[selctIndex].domain +
							'&Del_z=' + useracc[useraccIndex].domain +
							'&Del_y=' + logicfolder[folderIndex].domain +
							'&RequestFile=html/ssmp/samba/samba.asp';
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
    if(1==IsPtVdf)
	{
	    var enable = getCheckVal('EnableSambaBar');
		if(1 == enable || '1' == enable)
		{
			setDisplay("sambawarningRow",1);
		}
		else
		{
		   setDisplay("sambawarningRow",0);
		}
	}
	else
	{
	    setDisplay("sambawarningRow",0);
	}
	var Parameter = {};
	var url = 'set.cgi?x=InternetGatewayDevice.Services.StorageService.1.NetworkServer&RequestFile=html/ssmp/samba/samba.asp';
	var tokenvalue = getValue('onttoken');
	Parameter.asynflag = null;
	Parameter.FormLiList = SambaEnableFormList;
	Parameter.SpecParaPair = null;
	HWSetAction(null, url, Parameter, tokenvalue);
}

function EnableSambaAuthFunc()
{
	var Parameter = {};
	var url = 'set.cgi?x=InternetGatewayDevice.Services.StorageService.1.NetworkServer&RequestFile=html/ssmp/samba/samba.asp';
	var tokenvalue = getValue('onttoken');
	Parameter.asynflag = null;
	Parameter.FormLiList = SambaAuthEnableFormList;
	Parameter.SpecParaPair = null;
	HWSetAction(null, url, Parameter, tokenvalue);
}

function SetSambamConfigSpec(ControlData)
{
	this.Data = ControlData;
	if(this.Data["X_HW_AllPath"] == 1)
	{
		setDisplay("UrlUtfRow" ,0);
	}
	else
	{
		setDisplay("UrlUtfRow" ,1);
	}
}

function ShowChoosePathBrowse()
{
	if('1' == getRadioVal('SharepathRadioBar'))
	{
		setDisplay('UrlUtfRow',0);
	}
	else
	{
		setDisplay('UrlUtfRow',1);
	}
}

function title_show(input)
{
	var div=document.getElementById("title_show");

	if ("ARABIC" == LoginRequestLanguage.toUpperCase())
	{
		div.style.right = (input.offsetLeft+50)+"px";
	}
	else
	{
		div.style.left = (input.offsetLeft+410)+"px";
		div.style.zIndex = 9999;
	}

	if (input!=null && input.id=="UserNameBar")
	{
		div.innerHTML = SambaLgeDes['s1446'];
	}
	else
	{
		var sambaTips = (SamPWDFeatrue == 1) ? 'ss1116c_sec' : 'ss1116c';
		div.innerHTML = SambaLgeDes[sambaTips];
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
function GetLanguageDesc(Name)
{
	return SambaLgeDes[Name];
}

function SambachooseValue(obj){
	var text = obj.innerHTML;
	var ShowId = "IframeDropdown" + "show";
	$('#'+ShowId).html(text);
	
	if( SambaLgeDes['s1420']== obj.id){
		g_configX_HW_Permissions = 0;
	}else{
		g_configX_HW_Permissions = 1;
	}
	
	SetClickFlag(false);
	$('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
}

function transPath(usbPath)
{
	if (1 != IsPtVdf)
	{
		return usbPath;
	}
	
	var arr = usbPath.split("/");
	if (null != arr && arr.length >= 2)
	{
		var newRootDir = GetDevNameByOldMntPath("/mnt/usb/" + arr[1]);
		if (newRootDir != "")
		{
			arr[1] = newRootDir;
		}
	}
	
	var newUsbPath = "";
	for (var i = 1; i < arr.length; ++i)
	{
		newUsbPath += "/" + arr[i];
	}
	
	return newUsbPath;
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
	<script language="JavaScript" type="text/javascript">
		var ProductType1 = '<%HW_WEB_GetProductType();%>';	
		var SambaSummaryArray = new Array(new stSummaryInfo("text", GetDescFormArrayById(SambaLgeDes, "s1400")),
										  new stSummaryInfo("img",  "../../../images/icon_01.gif",    GetDescFormArrayById(SambaLgeDes, "s0531")),
										  new stSummaryInfo("text", GetDescFormArrayById(SambaLgeDes, "s0532")),
										  null);
		HWCreatePageHeadInfo("sambainfo", GetDescFormArrayById(SambaLgeDes, "s1445"), SambaSummaryArray, true);
		if (ProductType1 != '2')
		{
			if ("frame_itvdf" == frame){
				$("#sambainfo").before("<h1>"+GetLanguageDesc("s1446")+"</h1>");
			}		
		}
	</script>
	<div class="title_spread"></div>
	<form id="SambaEnableForm">
		<table id="SambaEnableConfigPanel" class="tabal_noborder_bg" width="100%" cellspacing="1" cellpadding="0">
			<li id="EnableSambaBar" RealType="CheckBox" DescRef="s1401" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.SMBEnable"    InitValue="Empty" ClickFuncApp="onClick=EnableSambaFunc"/>
			<li id="sambawarning"  RealType="HorizonBar"   DescRef="s1078" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="sambawarning" InitValue="Empty"/>
			<li id="PrinterInfoBar" RealType="HtmlText" DescRef="s1402" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PrinterInfoBar" InitValue="Empty" />
		</table>

		<script>
			SambaEnableFormList = HWGetLiIdListByForm("SambaEnableForm", null);
			HWParsePageControlByID("SambaEnableForm", TableClass ,SambaLgeDes, null);
			var SambaEnableArray = new Array();
			SambaEnableArray["SMBEnable"] = SMBEnable;
			SambaEnableArray["PrinterInfoBar"] = (dftPrinter.PrinterName != "" && SMBEnable == 1) ? dftPrinter.PrinterName : "--";
			HWSetTableByLiIdList(SambaEnableFormList, SambaEnableArray, null);
		</script>
	</form>
	<div class="func_spread"></div>
	<form id="SambaAuthEnableForm">
		<table id="SambaAuthEnablePanel" class="tabal_noborder_bg" width="100%" cellspacing="1" cellpadding="0">
			<li id="NetworkProtocolAuthBar" RealType="CheckBox" DescRef="s1403" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NetworkProtocolAuthReq" InitValue="Empty" ClickFuncApp="onClick=EnableSambaAuthFunc"/>
		</table>
		<script>
			SambaAuthEnableFormList = HWGetLiIdListByForm("SambaAuthEnableForm", null);
			HWParsePageControlByID("SambaAuthEnableForm", TableClass, SambaLgeDes, null);
			var SambaAuthArray = new Array();
			SambaAuthArray["NetworkProtocolAuthReq"] = NetworkProtocolAuthReq;
			HWSetTableByLiIdList(SambaAuthEnableFormList, SambaAuthArray, null);
		</script>
	</form>
	<div class="func_spread"></div>
	<div id="SambaAuthConfigHead" class="func_title" BindText='s1404'></div>
	<script type="text/javascript">
		var SambaConfiglistInfo = new Array(new stTableTileInfo("Empty",null,"DomainBox"),
											new stTableTileInfo("s1413",null,"NumIndexBox"),
											new stTableTileInfo("s1414",null,"Username", false, 18),
											new stTableTileInfo("s1415",null,"Enable"),
											new stTableTileInfo("s1416",null,"X_HW_Permissions"),
											new stTableTileInfo("s1417",null,"X_HW_AllPath",false, 32),null);

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
			
			SpecPath = transPath(SpecPath);
			TableDataInfo[i].X_HW_AllPath = TableDataInfo[i].X_HW_AllPath == 1 ? "----" : SpecPath;
		}

		setDisplay("SambaAuthConfigHead", NetworkProtocolAuthReq);
		HWShowTableListByType(NetworkProtocolAuthReq, "SambaConfigList", 1, ColumnNum, TableDataInfo, SambaConfiglistInfo, SambaLgeDes, null);
	</script>
	<div class="list_table_spread"></div>
	<form id="SambaAuthConfigForm"  name="SambaAuthConfigForm">
		<table id="SambaAuthConfigPanel" class="tabal_bg" width="100%" cellspacing="0" cellpadding="0">
			<li id="AuthConfigBar"       RealType="HorizonBar"      DescRef="s1405" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"             InitValue="Empty"/>
			<li id="UserNameBar"         RealType="TextDivbox"      DescRef="s1406" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"  BindField="x.Username"
				InitValue="[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; z-index:1000px; line-height:16px; width:280px; border:solid 1px #999999; background:#edeef0;'}]}]"/>
			<li id="UserPasswordBar"     RealType="TextOtherBox"    DescRef="s1407" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"  BindField="x.Password"
				InitValue="[{Item:[{AttrName:'id', AttrValue:'PaswordSambaPwdCheck'},{AttrName:'Type', AttrValue:'CheckBox'}, {AttrName:'value', AttrValue:'1'},{AttrName:'style', AttrValue:'display:none'},{AttrName:'onClick', AttrValue:'ShowOrHideText(this.id)'}]} ,{Type:'span', Item:[{AttrName:'id', AttrValue:'showpwdspanDecode'},{AttrName:'Type', AttrValue:'span'},{AttrName:'innerhtml', AttrValue:'s1422'},{AttrName:'style', AttrValue:'display:none'}]}]"
				ClickFuncApp="onmouseover=title_show;onmouseout=title_back;onfocus=OnFocusMasked;"/>
			<li id="UserPwddefhideBar"   RealType="TextOtherBox"    DescRef="s1407" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"  BindField="x.Password"
				InitValue="[{Item:[{AttrName:'id', AttrValue:'TextSambaPwdCheck'},{AttrName:'Type', AttrValue:'CheckBox'},{AttrName:'value', AttrValue:'1'}, {AttrName:'style', AttrValue:'display:none'},{AttrName:'onClick', AttrValue:'ShowOrHideText(this.id)'}]}, {Type:'span', Item:[{AttrName:'id', AttrValue:'showpwdspanDecode'},{AttrName:'Type', AttrValue:'span'},{AttrName:'innerhtml', AttrValue:'s1422'},{AttrName:'style', AttrValue:'display:none'}]}]"
				ClickFuncApp="onmouseover=title_show;onmouseout=title_back"/>
			<li id="checkinfo1" RealType="HtmlText"  DescRef="s0557" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;" />
			<li id="AuthEnableBar"       RealType="CheckBox"        DescRef="s1408" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable"           InitValue="Empty"/>
			<li id="PermissionSeleteBar" RealType="DropDownList"    DescRef="s1409" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_Permissions"
				InitValue="[{TextRef:'s1420',Value:'0'},{TextRef:'s1421',Value:'1'}]"/>
			<li id="SharepathRadioBar"   RealType="RadioButtonList" DescRef="s1410" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_AllPath"
				InitValue="[{TextRef:'s1423',Value:'1'},{TextRef:'s1424',Value:'0'}]" ClickFuncApp="onClick=ShowChoosePathBrowse"/>
			<li id="UrlUtf"              RealType="TextOtherBox"    DescRef="s1411" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"  BindField="y.Name"             disabled="disabled"
				InitValue="[{Item:[{AttrName:'id', AttrValue:'UrlBase'},{AttrName:'type', AttrValue:'text'}, {AttrName:'style', AttrValue:'display:none'}]},{Item:[{AttrName:'id', AttrValue:'MediaChooseInput'},{AttrName:'name', AttrValue:'MediaChooseInput'},{AttrName:'type', AttrValue:'button'}, {AttrName:'class', AttrValue:'CancleButtonCss browserbutton thickbox'}, {AttrName:'value', AttrValue:'s1425'}, {AttrName:'title', AttrValue:'s1436'}, {AttrName:'alt', AttrValue:'../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true'}]}]"/>
		</table>
		<script>
			SambaConfigFormList = HWGetLiIdListByForm("SambaAuthConfigForm", null);
			var formid_hide_id = null;
			HWParsePageControlByID("SambaAuthConfigForm", TableClass, SambaLgeDes, formid_hide_id);
			
			if(1 == IsItVdf)
			{
				$("#PermissionSeleteBar").remove();
				$('#PermissionSeleteBarCol').html('<div class="iframeDropLog"><div id="IframeDropdown" class="IframeDropdown"></div></div>');
				var arr = [SambaLgeDes["s1420"],SambaLgeDes["s1421"]];
				createDropdown("IframeDropdown", SambaLgeDes["s1420"],"225px",arr, "SambachooseValue(this);");
				$("#SambaAuthConfigPanel").css('display','none');
			}
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
		<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
			<tr>
				<td class='width_per30'></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
					<input id="ButtonApply"  type="button" BindText="s0526" class="ApplyButtoncss buttonwidth_100px" onclick="SubmitSMBConfigForm();"/>
					<input id="ButtonCancel" type="button" BindText="s0527" onclick="CancelConfig();" class="CancleButtonCss buttonwidth_100px" />
				</td>
			</tr>
		</table>
	</form>
	<div class="func_spread"></div>
	<script>
		ParseBindTextByTagName(SambaLgeDes, "div",    1);
		ParseBindTextByTagName(SambaLgeDes, "h1",  1);
		SetSambaConfigShow(0);
	</script>
</body>
</html>
