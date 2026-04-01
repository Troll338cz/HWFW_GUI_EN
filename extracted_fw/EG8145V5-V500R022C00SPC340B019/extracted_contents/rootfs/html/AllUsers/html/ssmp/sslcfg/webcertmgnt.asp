<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<style>
form{padding:0;margin:0}
</style>
<script language="JavaScript" type="text/javascript">
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
function title_show(input) 
{	
	var div=document.getElementById("title_show");	
	
	if ("ARABIC" == LoginRequestLanguage.toUpperCase())
	{	
		div.style.right = (input.offsetLeft+50)+"px";	
	}
	else
	{
		div.style.left = (input.offsetLeft+390)+"px";	
	}
	
  div.innerHTML = WebcertmgntLgeDes['s1116'];
	
	div.style.display = '';	
}
function title_back(input) 
{	
	var div=document.getElementById("title_show");		
	div.style.display = "none";
}

function GetLanguageDesc(Name)
{
    return WebcertmgntLgeDes[Name];
}

function stSSLWeb(domain,Enable)
{
    this.domain = domain;
	this.Enable   = Enable;
}

var stSSLWebs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebSslInfo,Enable,stSSLWeb);%>;
var SSLConfig = stSSLWebs[0];
function LoadFrame()
{
	if ( null != SSLConfig )
	{
	    setCheck('WebCertificateEnable', SSLConfig.Enable);
	}

	if( ( window.location.href.indexOf("set.cgi?") > 0) )
	{
	    AlertEx(GetLanguageDesc("s0d14"));
	}
}

function CheckFormPassword(type)
{	
	with(document.getElementById("ConfigFormWeb"))
    {
        if(WebcertPassword.value.length > 127)
        {
            AlertEx(GetLanguageDesc("s1904"));
            setText('WebcertPassword', '');
	        setText("WebCfmPassword", "");
            return false;
        }
		
		if (WebcertPassword.value == '')
		{
			AlertEx(GetLanguageDesc("s1430"));
			return false;
		}
		
        if(WebcertPassword.value != WebCfmPassword.value)
        {
            AlertEx(GetLanguageDesc("s0d0f"));
	        setText("WebcertPassword", "");
	        setText("WebCfmPassword", "");
            return false;
        }
		
		if(CheckPwdIsComplex(WebcertPassword.value) == false)
		{
			AlertEx(GetLanguageDesc("s1902"));
			return false;
		}
    }
    return true;
}

function VerifyFile(FileName)
{
	var File = document.getElementsByName(FileName)[0].value;
    if (File.length == 0)
    {
        AlertEx(GetLanguageDesc("s0d10"));
        return false;
    }
    if (File.length > 128)
    {
        AlertEx(GetLanguageDesc("s0d11"));
        return false;
    }
	
    return true;	
}

function uploadCert()
{
	var uploadForm = document.getElementById("fr_uploadImage");
	if (VerifyFile('browse') == false)
	{
	   return;
	}	
	top.previousPage = '/html/ssmp/sslcfg/webcertmgnt.asp';
	setDisable('btnSubmit',1);
	uploadForm.submit();
	setDisable('browse',1);	
	setDisable('btnBrowse',1);
}

function AddSubmitImportcert()
{
    if (CheckFormPassword() == false)
	{
	    return ;
	}
	
    var Form = new webSubmitForm();
	Form.addParameter('x.CertPassword',getValue('WebcertPassword'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebSslInfo'
                         + '&RequestFile=html/ssmp/sslcfg/webcertmgnt.asp');
                         
    setDisable('WebbtnApply',1);
    setDisable('WebcancelValue',1);
    Form.submit();
}

function SetCertificateInfo()
{
	var Form = new webSubmitForm();
	var Value = getCheckVal('WebCertificateEnable');
	
	Form.addParameter('x.Enable', Value);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('complex.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebSslInfo&RequestFile=html/ssmp/sslcfg/webcertmgnt.asp');	
	Form.submit();	
}

function CancelConfigPwd()
{
    setText("WebcertPassword", "");
	setText("WebCfmPassword", "");
}

function StartFileOpt()
{
 	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
}

function CheckPwdIsComplex(str)
{
	var i = 0;
    if (str.length < pwdLen)
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
	
	if ( isSpecialCharacterInString(str) )
	{
		i++;
	}
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function title_back(input) 
{	
	var div=document.getElementById("title_show");		
	div.style.display = "none";
}


</script>
<script language="JavaScript" type="text/javascript">

function fchange() {
	var ffile = document.getElementById("f_file");
	var tfile = document.getElementById("t_file");
	ffile.value = tfile.value;
	
	var buttonstart = document.getElementById('ImportCertification');
	buttonstart.focus();
}
</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<form id="ConfigFormWeb"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <tr> 
      <td class="prompt">
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
          <tr> 
            <td class="title_common" BindText="s1901"></td> 
          </tr> 
        </table></td> 
    </tr> 
  </table> 
    <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
    <tr> 
      <td class="width_per100" BindText="s0d23"></td> 
    </tr> 
  </table> 
  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
    <tr> 
      <td  class="table_title width_per30" BindText="s0d25"></td> 
      <td  class="table_right"> <input  id='WebCertificateEnable' name='WebCertificateEnable'  value='1' type='checkbox' onclick="SetCertificateInfo();">
	  <div id='title_show'  style='position:absolute; display:none; line-height:16px; width:310px; border:solid 1px #999999; background:#edeef0;'>
	  </div>
	  </td> 
    </tr> 
    <tr > 
      <td class="table_title" BindText="s0d26"></td> 
      <td class="table_right"> 
	  	<input name='WebcertPassword' type='password' id="WebcertPassword"  onmouseover="title_show(this);" onmouseout="title_back(this); " size="20" autocomplete="off"> 
		<script language="javascript">
		document.write('<span class="gray">' + GetLanguageDesc("s1905") + '</span>');
		</script> 
	  </td> 
    </tr> 
    <tr> 
      <td  class="table_title" BindText="s0d28"></td> 
      <td class="table_right"> 
	  	<input name='WebCfmPassword' type='password' id="WebCfmPassword" size="20" autocomplete="off"> 
		<script language="javascript">document.write('<span class="gray">' + GetLanguageDesc("s1905") + '</span>');</script> 
	  </td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">  
  	<tr>
      <td  class="table_submit width_per30"></td> 
      <td  class="table_submit"> 
	  	<input  class="submit" name="WebbtnApply" id= "WebbtnApply" type="button" BindText="s0d21" onClick="AddSubmitImportcert();"> 
        <input class="submit" name="WebcancelValue" id="WebcancelValue" type="button" BindText="s0d22" onClick="CancelConfigPwd();">
	  </td> 
    </tr> 
  </table> 
</form> 
<table width="100%" height="15" border="0" cellpadding="0" cellspacing="0"> 
<tr> 
<td></td> 
</tr> 
</table> 
<form action="websslcert.cgi?RequestFile=html/ssmp/sslcfg/webcertmgnt.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage"> 
  <div> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
      <tr> 
        <td class="width_per100" BindText="s0d29"></td> 
      </tr> 
    </table> 
    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
      <tr> 
        <td></td> 
      </tr> 
    </table> 
    <table> 
      <tr> 
        <td BindText="s0d2a"></td> 
        <td> 
			<div class="filewrap"> 
            <div class="fileupload"> 
			  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
              <input type="text" id="f_file" autocomplete="off" readonly="readonly" /> 
              <input type="file" name="browse" id="t_file" size="1"  onblur="StartFileOpt();" onchange="fchange();" /> 
              <input id="btnBrowse" type="button" class="submit" BindText="s0d2b" /> 
            </div> 
          </div>
		</td> 
        <td> <input class="submit" id="ImportCertification" name="btnSubmit" type='button' onclick='uploadCert();' BindText="s0d2c" /> </td> 
      </tr> 
    </table> 
  </div> 
  <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
</form> 
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

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
    b.innerHTML = WebcertmgntLgeDes[c];
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
    b.value = WebcertmgntLgeDes[c];
}
</script>

</body>
</html>
