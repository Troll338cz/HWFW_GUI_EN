<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet" href="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.css);%>" type="text/css" media="screen" />
<script type="text/javascript" src="../smblist/<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
<style type="text/css">
.trTabContent td
{
	font-family:Arial;
	font-size:12px; 
	border:1px solid  #dcdcdc;
	text-align:center;
}
.trTabContent 
{ 
	background-color:#f4f4f4;
	color:#000000;
	height: 20px;
	padding: 1px;
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
function stDftPrinter(domain,PrinterEnable,PrinterName)
{
	this.domain 	= domain;
	this.PrinterEnable = PrinterEnable;
	this.PrinterName = PrinterName;
}

function stUserInfo(domain,Username,Enable,Password,X_HW_AllPath,X_HW_Permissions) 
{ 
	this.domain = domain; 
	this.Username = Username; 
	this.Enable = Enable; 
	this.Password = Password; 
	this.X_HW_AllPath = parseInt(X_HW_AllPath); 
	this.Privilege = parseInt(X_HW_Permissions); 
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

var IsNeedSambaPath='<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_YUEME_DISC_NAME);%>';
var SamPWDFeatrue = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';
var MaxUserAccountNum = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.UserAccountNumberOfEntries);%>';
var MaxUserAccountInst = parseInt(MaxUserAccountNum);
var dftPrinters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Printer,Enable|Name,stDftPrinter);%>;
var dftPrinter = dftPrinters[0];

var NetworkProtocolAuthReq  = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.StorageService.1.NetworkServer.NetworkProtocolAuthReq);%>';
var SMBEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.StorageService.1.NetworkServer.SMBEnable);%>';
var default_path = "mnt/usb"; 
var SambaAddFlag = true;
var UserInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.UserAccount.{i},Username|Enable|Password|X_HW_AllPath|X_HW_Permissions, stUserInfo);%>;

var useracc = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.LogicalVolume.{i}.Folder.{i}.UserAccess.{i},UserReference|Permissions,stUseracc);%>;

var logicfolder = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.LogicalVolume.{i}.Folder.{i}, Name|X_HW_NameNative,stLogicfolder);%>;
var LogicalVolume = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.1.LogicalVolume.{i}, Name|Enable,stLogicfolderinfo);%>;
var usersmpassword = '';
var gVar_FolderName_Utf8;
var gVar_FolderName_Native;
var gVar_UserAcc_Permissions;
var folderIndex = 256;
var useraccIndex;
var hasinput=false;
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';

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
	var all = document.getElementsByTagName("div");
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
	
}

function title_show(input) 
{	
	var div=document.getElementById("title_show");	
	div.style.left = (input.offsetLeft+370)+"px";	
			
	div.innerHTML = SambaLgeDes['ss1116c'];	
	div.style.display = '';	
}

function title_back(input) 
{	
	var div=document.getElementById("title_show");		
	div.style.display = "none";
}

function SetDeviceDirShow(ctrlid)
{
	if(1 == IsNeedSambaPath || "1" == IsNeedSambaPath)
	{	
		document.getElementById(ctrlid).style.display="none";
	}
	else
	{
		document.getElementById(ctrlid).style.display="";
	}
}

function LoadFrame()
{
	
	setCheck('NetworkProtocolAuthReq',NetworkProtocolAuthReq);
   
	if(SMBEnable == 0)
	{
		setCheck('dftIfStr',0);
		document.getElementById("sambaServiceName").innerHTML = "--";
	}
	else
	{
		setCheck('dftIfStr',1);
	
		if(dftPrinter.PrinterName == "")
		{
			document.getElementById("sambaServiceName").innerHTML = "--";
		}
		else
		{
			document.getElementById("sambaServiceName").innerHTML = htmlencode(dftPrinter.PrinterName);
		}
	}
	
	if(NetworkProtocolAuthReq == 0)
	{
		setDisplay('ConfigPanel', 0);
		setDisplay('ConfigForm', 0);
	}
	else
	{
		if (UserInfo.length -1 == 0)
		{
			selectLine('record_no');
			setDisplay('ConfigForm', 0);
		}
		else
		{
		  selectLine('record_0');
		  setDisplay('ConfigForm', 1);
		  SetDeviceDirShow("choosesambaPath");
		}
	}

	setDisplay('hidesmPassword', 0);
	setDisplay('tsmPassword', 0);
	setDisplay('sambahidetext', 0);
	
	loadlanguage();
}
   
function SubmitForm()
{   
	var Form = new webSubmitForm();
	
	Form.addParameter('x.SMBEnable',getCheckVal('dftIfStr'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.Services.StorageService.1.NetworkServer&RequestFile=html/ssmp/samba/e8csamba.asp');
	setDisable('btnSmbApply', 1);
	setDisable('cancelValue', 1);
	Form.submit();   
}

function SubmitAuthReq()
{
	var Form = new webSubmitForm();
	Form.addParameter('x.NetworkProtocolAuthReq',getCheckVal('NetworkProtocolAuthReq'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.Services.StorageService.1.NetworkServer&RequestFile=html/ssmp/samba/e8csamba.asp');
	setDisable('btnSmbApply', 1);
	setDisable('cancelValue', 1);
	Form.submit();   
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
    if (str.length < pwdLen)
	{
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
	var name = $.trim(getValue('SambaUsername'));
	var pwd = getValue('smPassword');
	var privilege = getSelectVal('Privilege');
	var firstChar = parseInt(name.charAt(0),10);
	var needcheck=0;
	if (name == '')
	{
		AlertEx(SambaLgeDes['s1426']);
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
		
		var pChar = parseInt(pwd.charAt(i),10);
		if(!(((pChar >= 0) && (pChar <= 9 )) || (pwd.charAt(i) == '_') ||((pwd.charAt(i) >= 'a')&&(pwd.charAt(i) <= 'z'))||((pwd.charAt(i) >= 'A')&&(pwd.charAt(i) <= 'Z'))))
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
function SubmitSMBForm()
{
		var Form = new webSubmitForm();
		
		var name = $.trim(getValue('SambaUsername'));
		var AllPath = getRadioVal('idRadioDirectory');
		
		var Privilege ;
		var lastFolderNameUtf8 = '';
		
		var ulret = CheckForm();	
		if (ulret != true )
		{
			return false;
		}
		
		var path = getValue('UrlUtf');
		
		if('0' == getRadioVal('idRadioDirectory'))
		{
			if(path == "")
			{
				AlertEx(SambaLgeDes['s1431']);
				return false;
			}
		}

		default_path += path;
		
		if (default_path.length > 256) 
		{
			AlertEx(SambaLgeDes['s1441']);
			return false;
		}
		
	    
		if( 1 == getSelectVal('Privilege'))
		{
			Privilege = 6; 
		}
		else
		{
			Privilege = 4; 
		}
		
		Form.addParameter('x.Username',name);
		Form.addParameter('x.Password',getValue('smPassword'));
		Form.addParameter('x.Enable',getCheckVal('idEnable'));
		Form.addParameter('x.X_HW_Permissions',getSelectVal('Privilege'));
		Form.addParameter('x.X_HW_AllPath',AllPath);
		Form.addParameter('y.Name',default_path);
		Form.addParameter('z.UserReference',name);
		Form.addParameter('z.Permissions',Privilege);
		if( selctIndex == -1 )
		{
			if(AllPath == 0)
			{
				var tempath = path.split("/");		
				var indexid = getFolderID(tempath[1]);
				if(indexid == 0)
				{
					AlertEx(SambaLgeDes['s1443']);
					return false;
				}
				Form.addParameter('x.X_HW_Token', getValue('onttoken'));
				Form.setAction('addcfg.cgi?x=' +'InternetGatewayDevice.Services.StorageService.1.UserAccount'
				                + '&y=' + 'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder'
				                + '&z=y.UserAccess'                        
				                + '&RequestFile=html/ssmp/samba/e8csamba.asp');
			                
			}
			else
			{
				Form.addParameter('x.X_HW_Token', getValue('onttoken'));
				Form.setAction('addcfg.cgi?x=' +'InternetGatewayDevice.Services.StorageService.1.UserAccount'
			                				+ '&RequestFile=html/ssmp/samba/e8csamba.asp');
			}
		
		}
		else
		{   
			Form.addParameter('Del_y.Name','');
			Form.addParameter('Del_z.UserReference','');
			Form.addParameter('Del_z.Permissions','');
			Form.addParameter('Add_y.Name',default_path);
			Form.addParameter('Addconnect_z.UserReference',name);
			Form.addParameter('Addconnect_z.Permissions',Privilege);
			 
			var FolderNameIndex = getFolderName(selctIndex);
			  
			if(AllPath == 0)
			{
				var tempath = path.split("/");		
				var indexid = getFolderID(tempath[1]);
				if(indexid == 0)
				{
					AlertEx(SambaLgeDes['s1443']);
					return false;
				}
			
				Form.addParameter('x.X_HW_Token', getValue('onttoken'));
				if(1 == UserInfo[selctIndex].X_HW_AllPath || -1 == FolderNameIndex )
				{
					Form.setAction('complex.cgi?x=' + UserInfo[selctIndex].domain
													+ '&Add_y=' + 'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder'
					                + '&Addconnect_z='+'InternetGatewayDevice.Services.StorageService.1.LogicalVolume.'+ indexid +'.Folder'+ '.{i}.UserAccess'
					                + '&RequestFile=html/ssmp/samba/e8csamba.asp');
				}
				else
				{
					var addlogicfolder = logicfolder[folderIndex].domain.substring(0,logicfolder[folderIndex].domain.lastIndexOf('.'));
					Form.setAction('complex.cgi?x=' + UserInfo[selctIndex].domain
													+ '&Del_z=' + useracc[useraccIndex].domain
													+ '&Del_y=' + logicfolder[folderIndex].domain
					                + '&Add_y=' + addlogicfolder
					                + '&Addconnect_z='+addlogicfolder+ '.{i}.UserAccess'
					                + '&RequestFile=html/ssmp/samba/e8csamba.asp');
				}
				
			       
			}
			else
			{ 
				Form.addParameter('x.X_HW_Token', getValue('onttoken'));
				if(1 == UserInfo[selctIndex].X_HW_AllPath || -1 == FolderNameIndex)
				{
					Form.setAction('set.cgi?x=' + UserInfo[selctIndex].domain
			                    + '&RequestFile=html/ssmp/samba/e8csamba.asp');
				}
				else
				{	
					Form.setAction('complex.cgi?x=' + UserInfo[selctIndex].domain
													+ '&Del_z=' + useracc[useraccIndex].domain
				 									+ '&Del_y=' + logicfolder[folderIndex].domain
			                    + '&RequestFile=html/ssmp/samba/e8csamba.asp');
				}
				
			}
		}
		
	setDisable('btnSmbApply', 1);
	setDisable('cancelValue', 1);
	setDisplay('smPassword', 1);
	setDisplay('hidesmPassword', 0);
	setDisplay('tsmPassword', 0);
	setDisplay('sambahidetext', 0);
	hasinput=false;

	Form.submit();
	
}
function CancelConfig()
{
    LoadFrame();
}

function SambaWriteTabTail()
{
    document.write("<\/td><\/tr><\/table>");
}

function radioChooseDirOption()
{
	var radioIndex = getRadioVal('idRadioDirectory');
	
	if('1' == radioIndex)
	{		
		setDisplay('DeviceDir',0);
	}
	else
	{
		SetDeviceDirShow("DeviceDir");
	}
	 	
}

function ClearContent()
{
	if (false == hasinput)
	{
		usersmpassword='';
		setText('smPassword', '');
		setDisplay('hidesmPassword', 1);
		setDisplay('sambahidetext', 1);
		hasinput=true;
	}	
}
		
function ShowOrHideText(checkBoxId, passwordId, textId, value)
{
	 
    if (1 == getCheckVal(checkBoxId))
    {
        setDisplay(passwordId, 1);
        setDisplay(textId, 0);
        setText(passwordId, value);
    }
    else
    {
        setDisplay(passwordId, 0);
        setDisplay(textId, 1);
        setText(textId, value);
    }
    
}

function setCtlDisplay(record,index)
{
	var path = '';
	var pathNative = '';
	usersmpassword = record.Password;
	setText('SambaUsername',record.Username);
	
	var name = $.trim(getValue('SambaUsername'));
	if(name!='')
	{
		 setDisable('SambaUsername', 1);
	}
	else
	{
		setDisable('SambaUsername', 0);
	}
	
	setText('smPassword',record.Password);
	setText('tsmPassword',record.Password);
	setCheck('idEnable',record.Enable);
	if(record.Privilege == 0)
	{		
		setSelect('Privilege', 0)
	}
	else
	{
		setSelect('Privilege', 1)
	}
	if ( -1 == selctIndex )
	{
		setRadio('idRadioDirectory', 1);
	}
	else
	{	
		setRadio('idRadioDirectory', parseInt(record.X_HW_AllPath));
		if('0' == getRadioVal('idRadioDirectory'))	
		{
			if(0 == getFolderName(index))
			{
				var shortpathstring = default_path;	
				if( -1 != gVar_FolderName_Utf8.indexOf("usb1_1"))
				{
					shortpathstring = "/mnt";
				}
								
				path = gVar_FolderName_Utf8.substring(shortpathstring.length,gVar_FolderName_Utf8.length);
			}
		}
		else
		{
			path = '';
		}
	}
	radioChooseDirOption();
	setText('UrlUtf',path);
	setText('UrlBase',pathNative);
}

var selctIndex = -1;

function setControl(index)
{
	var record;
	selctIndex = index;
	
	setCheck('hidesmPassword', 1);
    setDisplay('smPassword', 1);
    setDisplay('tsmPassword', 0);
	setDisplay('hidesmPassword', 0);
	setDisplay('sambahidetext', 0);
	hasinput=false;

	if (index == -1)
	{
		if (UserInfo.length-1 >= 8)
		{
			setDisplay('ConfigForm', 0);		
			AlertEx(SambaLgeDes['s1432']);
			return;
		}
		else
		{
			record = new stUserInfo('','','','','');
			SambaAddFlag = true;
			setCtlDisplay(record,index);
			setDisplay('ConfigForm', 1);
			SetDeviceDirShow("choosesambaPath");
		}
	}
	else if (index == -2)
	{
		setDisplay('ConfigForm', 0);
	}
	else
	{
		SambaAddFlag = false;
		record = UserInfo[index];
		setCtlDisplay(record,index);
		setDisplay('ConfigForm', 1);
		SetDeviceDirShow("choosesambaPath");
	}
	
	setDisable('btnSmbApply', 0);
	setDisable('cancelValue', 0);
}

function selectRemoveCnt(obj) 
{

} 

function AddDeleteDomain(Form, index)
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

function DeleteSinglePathUser(form ,index)
{
    AddDeleteDomain(form,index);    
   
}

function DeleteAllPathUser(form, index)
{   
    form.addParameter(UserInfo[index].domain, '');
}

function stDelete(form,index)
{
	
	if (0 == UserInfo[index].X_HW_AllPath)
	{
		 DeleteSinglePathUser(form,index);
	}
	else
	{
	    DeleteAllPathUser(form,index);
	}
}
function clickRemove() 
{	
	var Form = new webSubmitForm();	
	var cnt = 0;  
	var rml = getElement('rml');
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
			Form.setAction('del.cgi?RequestFile=html/ssmp/samba/e8csamba.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();	
		}
	}
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<form id="Configure"> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabTest"> 
    <tr> 
      <td class="prompt"> <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
          <tr> 
            <td class='title_common' BindText='s1400'></td> 
          </tr> 
           <tr> 
      <td class="title_common">  
	  <div>	
	  <table>
          <tr> 
            <td class='width_13p align_left'><img style="margin-bottom:2px" src="../../../images/icon_01.gif" width="15" height="15" /></td> 
            <td class='width_87p align_left'><script>document.write(SambaLgeDes['s0531']);</script></td> 
          </tr>
		 </table>
	 </div>
		  <tr>
		  <td class="title_common">
		  <script>document.write(SambaLgeDes['s0532']);</script>
		  </td>
		  </tr>
       </td> 
    </tr> 
        </table></td> 
    </tr> 
    <tr> 
      <td class='height5p'></td> 
    </tr> 
  </table> 
  <table cellpadding="0" cellspacing="1" class="tabal_bg" width="100%"> 
    <tr> 
      <td class="table_title width_30p" BindText='s1401'></td> 
      <td class="table_right"> <input type="checkbox" id='dftIfStr' name='dftIfStr' onclick="SubmitForm();" >
	  	  <input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"></td> 
    </tr> 
    <tr> 
      <td  class="table_title width_30p" BindText='s1402'></td> 
      <td class="table_right"><span id="sambaServiceName"></span></td> 
    </tr> 
  </table> 
<div class="func_spread"></div>

<table cellpadding="0" cellspacing="0" class="tabal_bg" width="100%"> 
  <tr> 
    <td class="table_title width_30p" BindText='s1403'></td> 
    <td class="table_right"> <input type="checkbox" id='NetworkProtocolAuthReq' name='NetworkProtocolAuthReq' onClick="SubmitAuthReq();"></td> 
  </tr> 
</table> 
<div class="func_spread"></div>

<div id="ConfigPanel">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tabal_head"  BindText='s1404'></td>
  </tr>
</table>

<script language="JavaScript" type="text/javascript">
	writeTabCfgHeader('Samba','100%');
	</script> 
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="SambaInst">
      <tr class="head_title">
        <td class="per_5_10">&nbsp;</td>
        <td ><div class="align_center"><script>document.write(SambaLgeDes['s1413']);</script></div></td>
        <td ><div class="align_center"><script>document.write(SambaLgeDes['s1414']);</script></div></td>
        <td ><div class="align_center"><script>document.write(SambaLgeDes['s1415']);</script></div></td>
        <td ><div class="align_center"><script>document.write(SambaLgeDes['s1416']);</script></div></td>
        <td ><div class="align_center"><script>document.write(SambaLgeDes['s1417']);</script></div></td>
      </tr>
        <script language="JavaScript" type="text/javascript">
        	
				if(UserInfo.length -1 == 0)
				{
					document.write('<TR id="record_no"' +' class="tabal_center01 " onclick="selectLine(this.id);">');
					document.write('<TD >--</TD>');
					document.write('<TD >--</TD>');
					document.write('<TD >--</TD>');
					document.write('<TD >--</TD>');
					document.write('<TD >--</TD>');
					document.write('<TD >--</TD>');
					document.write('</TR>');
				}
				else
				{
					for (var i = 0; i < UserInfo.length - 1; i++)
					{
						if( i%2 == 0 )
						{						
							document.write('<TR id="record_' + i 
										+'" class="tabal_01 " onclick="selectLine(this.id);">');
						}
						else
						{
							document.write('<TR id="record_' + i 
										+'" class="tabal_02 " onclick="selectLine(this.id);">');				
						}						
								        
						document.write('<TD class="align_center">' + '<input id = \"rml'+i+'\" type="checkbox" name="rml"'  + ' value="' 
												+ htmlencode(UserInfo[i].domain) + '" onclick="selectRemoveCnt(this);">' + '</TD>');
								        
						document.write('<TD>' + (i+1) + '</TD>');
						 document.write('<TD title="'+htmlencode(UserInfo[i].Username)+'">'+ GetStringContent(htmlencode(UserInfo[i].Username), 18)+'</TD>');      
						if(1 == UserInfo[i].Enable)
						{
							document.write('<TD>' + SambaLgeDes['s1418'] + '</TD>');		
						}
						else
						{
							document.write('<TD>' + SambaLgeDes['s1419'] + '</TD>');		
						}
							
						if(UserInfo[i].Privilege == 0)
						{
						    document.write('<TD>' + SambaLgeDes['s1420'] + '</TD>');
						}
						else
						{
						    document.write('<TD>' + SambaLgeDes['s1421'] + '</TD>');
						}
					
						if(1 == UserInfo[i].X_HW_AllPath)
						{
						    document.write('<TD>' + '----' +'</TD>')			
						}
						else
						{
						    if(0 == getFolderName(i))
						    {		
								var shortpathstring = default_path;	
								if( -1 != gVar_FolderName_Utf8.indexOf("usb1_1"))
								{
									shortpathstring = "/mnt";
								}

						        document.write('<TD title="'+ htmlencode(gVar_FolderName_Utf8.substring(shortpathstring.length,gVar_FolderName_Utf8.length))+'">'+GetStringContent(htmlencode(gVar_FolderName_Utf8.substring(shortpathstring.length,gVar_FolderName_Utf8.length)), 32)+'</TD>');
						    }
						    else
						    {
						        document.write('<TD>' + 'undefined' +'</TD>');
						    }
						}
						                     
						document.write('</TR>');
					}
				}
			
        </script>
    </table>
<script language="JavaScript" type="text/javascript">
    SambaWriteTabTail();
</script>
 </div>  
<div class="func_spread"></div> 
<div id="ConfigForm"> 
     <div class="func_title" BindText='s1405'></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr> 
      <td class="table_title" BindText="s1406"></td> 
      <td class="table_right"> <input type='text' name='SambaUsername' id="SambaUsername" value = '' maxlength='256'>
      	<font class="color_red">*</font><span class="gray">
		<div id='title_show'  style='position:absolute; display:none; line-height:16px; width:280px; border:solid 1px #999999; background:#edeef0;'></div>
		</td> 
    </tr>
     <tr> 
      <td class="table_title" BindText="s1407"></td> 
      <td class="table_right">
				<input type='password' autocomplete="off" id='smPassword' name='smPassword' size='20' maxlength='64' class="smp_font" onfocus="ClearContent()" onchange="usersmpassword=getValue('smPassword');setText('tsmPassword',usersmpassword);" onmouseover="title_show(this);" onmouseout="title_back(this);" /><input type='text' id='tsmPassword' name='tsmPassword' size='20' maxlength='64' class="smp_font" style='display:none' onchange="usersmpassword=getValue('tsmPassword');setText('smPassword',usersmpassword)" onmouseover="title_show(this);" onmouseout="title_back(this);"/><font class="color_red"> *</font>
				<input checked type="checkbox" id="hidesmPassword" name="hidesmPassword" value="on" onClick="ShowOrHideText('hidesmPassword', 'smPassword', 'tsmPassword', usersmpassword);"/>
				<span id='sambahidetext'><script>document.write(SambaLgeDes['s1422']);</script></span>
      	 </td> 
    </tr>  
    <tr> 
      <td class="table_title width_30p" BindText="s1408"></td> 
			 <td class="table_right"> <input type="checkbox" id='idEnable' name='idEnable'></td> 
    </tr> 
    <tr> 
      <td class="table_title" BindText="s1409"></td> 
      <td class="table_right">   	
			<select id="Privilege" style="width:128px">
			<script language="JavaScript" type="text/javascript">
				document.write('<option value="0">' + SambaLgeDes['s1420'] + '</option>');
				document.write('<option value="1">' + SambaLgeDes['s1421'] + '</option>');
			</script>
			</select>
      </td> 
    </tr> 
    <tr id="choosesambaPath" style="display:none;"> 
      <td class="table_title" BindText="s1410"></td> 
      <td class="table_right"> 
	  	<input name="idRadioDirectory" id="idRadioAllDirectory" type="radio" value="1" onclick="radioChooseDirOption();"/> 
				<script>document.write(SambaLgeDes['s1423']);</script>
				<input name="idRadioDirectory" id="idRadioChooseDirectory" type="radio" value="0" checked="checked" onclick="radioChooseDirOption();"/> 
				<script>document.write(SambaLgeDes['s1424']);</script>
	  </td> 
    </tr> 
	
    <tr id="DeviceDir" style="display:none;"> 
      <td class="table_title" BindText="s1411"></td> 
      <td class="table_right">
      	<input type="text" id="UrlBase" name="UrlBase" style="display:none"> 
      	<input type='text' id="UrlUtf" name='UrlUtf' disabled="disabled" maxlength='256' style="width: 200px">
      	<font class="color_red">*</font>
      	<input id="MediaChooseInput" name="MediaChooseInput" alt="../smblist/smb_choosedir_list.asp?&Choose=1&TB_iframe=true" title="" class="thickbox" type="button" BindText="s1425"/>
        <script>
          document.getElementsByName('MediaChooseInput')[0].title = SambaLgeDes['s1436'];
        </script>
      </td> 
    </tr> 
  </table> 
  <div class="button_spread"></div>
  <table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
  <tr align="right"> 
    <td class='width_25p'></td> 
    <td class="table_submit" align="right"> 
    	<input name="btnSmbApply" id="btnSmbApply" type="button" BindText="s0526" class="submit" onClick="SubmitSMBForm();">
      <input name="cancelValue" id="cancelValue" type="button" BindText="s0527" class="submit" onClick="CancelConfig();"></td> 
  </tr> 
</table>
</div> 
<div class="func_spread"></div>
</form> 
</body>
</html>
