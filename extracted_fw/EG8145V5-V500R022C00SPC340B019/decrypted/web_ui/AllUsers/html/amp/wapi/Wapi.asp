<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<title>WAPI Certification</title>
<script language="JavaScript" type="text/javascript">

function setAllDisable()
{
	setDisable('f_file',1);
	setDisable('browse',1);	
	setDisable('btnBrowse',1);
	setDisable('btnSubmit',1);
	setDisable('f_file1',1);
	
}


function GetLanguageDesc(Name)
{
    return cfg_wapi_language[Name];
}


function Check_SWM_Status()
{
    var xmlHttp = null;
	
	if(window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
    
    xmlHttp.open("GET", "/html/get_swm_status.asp", false);
	xmlHttp.send(null);
	
	var swm_status = xmlHttp.responseText;
	if (swm_status.substr(1,1) == "0") {
	    return true;
    } else {
        return false;
    }
}

function LoadFrame()
{ 
	top.UpgradeFlag = 0;
	
	if((top.curWebFrame == 'frame_argentina') &&(top.curUserType == top.sysUserType))
	{
		setAllDisable();
	}
}


function VerifyFile(FileName)
{
	var File = document.getElementsByName(FileName)[0].value;
	var File1 = document.getElementsByName(FileName)[1].value;
    if ((File.length == 0)&&(File1.length == 0))
    {
       AlertEx(GetLanguageDesc("amp_wapicertificate_invalid"));
        return false;
    }
    if ((File.length > 128)&&(File1.length > 128))
    {
       AlertEx(GetLanguageDesc("amp_wapicertificate_length_invalid"));
        return false;
    }

    return true;	
}

function uploadImage()
{
    var uploadForm = document.getElementById("fr_uploadImage");
    
    if (Check_SWM_Status() == false)
    {
        AlertEx(GetLanguageDesc("amp_wapisystem_busy"));
        return;
    }
    
	if (VerifyFile('browse') == false)
	{
	   return;
	}	
	top.previousPage = '/html/ssmp/reset/reset.asp';
	setDisable('btnSubmit',1);

	uploadForm.submit();

	setDisable('browse',1);	
	setDisable('btnBrowse',1);
}

function uploadImageuser()
{
    var uploadForm = document.getElementById("fr_uploadImageuser");
    if (Check_SWM_Status() == false)
    {
        AlertEx(GetLanguageDesc("amp_wapisystem_busy"));
        return;
    }
    
	if (VerifyFile('browse') == false)
	{
	   return;
	}	
	top.previousPage = '/html/ssmp/reset/reset.asp';
	setDisable('btnSubmit',1);
	
	uploadForm.submit();

	setDisable('browse',1);	
	setDisable('btnBrowse',1);
}

</script>
<script language="JavaScript" type="text/javascript">
function fchange()
{
	var ffile = document.getElementById("f_file");

	var tfile = document.getElementById("t_file");
	ffile.value = tfile.value;
	return ;
}

function fchangeuser()
{
	var ffile1 = document.getElementById("f_file1");

	var tfile1 = document.getElementById("t_file1");
	ffile1.value = tfile1.value;
	return ;
}

function StartFileOpt()
{
 	XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
}

</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
 <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
    <tr> 
      <td class="prompt" > 
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
          <tr> 
            <td class="title_common" BindText="amp_wapi_des"></td> 
          </tr> 
        </table>
	  </td> 
    </tr> 
  </table> 
<form action="certificationwapias.cgi?RequestFile=html/ssmp/reset/reset.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage"> 
  <div> 
  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0" align = "center"> 
    <tr> 
      <td></td> 
    </tr> 
  </table>  
  <table> 
    <tr> 
      <td BindText="amp_wapi_asu"></td> 
      <td> 
		<div class="fileupload"> 
			<input type="text" id="f_file" autocomplete="off" readonly="readonly" /> 
			<input type="file" name="browse" id="t_file" size="1"  onblur="StartFileOpt();" onchange="fchange();" /> 
			<input id="btnBrowse" type="button" class="submit"  BindText="amp_wapi_browser" /> 
		</div>
	  </td> 
	 <td>
	    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	    <button id="btnSubmit" name="btnSubmit" type="button" class="submit" onClick="uploadImage();"><script>document.write(cfg_wapi_language['amp_wapicertificate_import']);</script></button>  
     </td> 
    </tr> 
	</table>
  </div> 
  <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
</form> 


<form action="certificationwapiae.cgi?RequestFile=html/ssmp/reset/reset.asp" method="post" enctype="multipart/form-data" name="fr_uploadImageuser" id="fr_uploadImageuser"> 
  <div> 
  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0" align = "center"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
  
  <table> 
    <tr> 
      <td BindText="amp_wapi_user"></td> 
      <td> 
		<div class="fileupload"> 
			<input type="text" id="f_file1" autocomplete="off" readonly="readonly" /> 
			<input type="file" name="browse" id="t_file1" size="1"  onblur="StartFileOpt();" onchange="fchangeuser();" /> 
			<input id="btnBrowse" type="button" class="submit"  BindText="amp_wapi_browser" /> 
		</div>
	  </td>   
	 <td> 
	    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	    <button id="btnSubmit" name="btnSubmit" type="button" class="submit" onClick="uploadImageuser();"><script>document.write(cfg_wapi_language['amp_wapicertificate_import']);</script></button>  
	 </td> 
    </tr> 
	</table>
  </div> 
  <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
</form> 
<script>
var all = document.getElementsByTagName("td");
for (var i = 0; i < all.length; i++)
{
    var b = all[i];
	var c = b.getAttribute("BindText");
	if(c == null)
	{
		continue;
	}
    b.innerHTML = cfg_wapi_language[c];
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
    b.value = cfg_wapi_language[c];
}
</script>
</body>
</html>
