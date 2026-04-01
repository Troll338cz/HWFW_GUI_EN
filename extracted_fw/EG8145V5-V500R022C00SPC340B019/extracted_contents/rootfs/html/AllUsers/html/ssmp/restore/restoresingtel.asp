<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';

function GetLanguageDesc(Name)
{
    return RestoreLgeDes[Name];
}

function LoadFrame()
{
	/* 只有管理员用户增加恢复默认配置并删除pwd按钮 */
	if (curUserType != sysUserType)
	{
		setDisplay('btnRestoreAndDelPwd', 0);		
	}
}

function RestoreDefaultCfg()
{
	if(ConfirmEx(GetLanguageDesc("s0a01")))
	{
		var Form = new webSubmitForm();
		setDisable('btnRestoreDftCfg', 1);
		Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/ssmp/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function RestoreFactoryCfg()
{
	if(ConfirmEx(GetLanguageDesc("s0a09")))
	{
		var Form = new webSubmitForm();
		setDisable('btnRestoreAndDelPwd', 1);
		Form.setAction('RestoreAndDelPwd.cgi?' + 'RequestFile=html/ssmp/ssmp/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken1'));
		Form.submit();
	}
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();"> 

<script language="JavaScript" type="text/javascript"> 
	if (curUserType != sysUserType)
	{
		HWCreatePageHeadInfo("restore", GetDescFormArrayById(RestoreLgeDes, "s0a03"), GetDescFormArrayById(RestoreLgeDes, "s0a02"), false);
	}
	else
	{
		HWCreatePageHeadInfo("restore", GetDescFormArrayById(RestoreLgeDes, "s0a03"), GetDescFormArrayById(RestoreLgeDes, "s0a08"), false);
	}
</script>

<div>
	<table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td> 
      	<input  class = "ApplyButtoncss buttonwidth_150px_250px" name="btnRestoreDftCfg" id="btnRestoreDftCfg" type='button' onClick='RestoreDefaultCfg()'  BindText="s0a03" > 
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      </td> 
	  
	  <td> 
      	<input  class = "ApplyButtoncss buttonwidth_150px_250px" name="btnRestoreAndDelPwd" id="btnRestoreAndDelPwd" type='button' onClick='RestoreFactoryCfg()'  BindText="s0a0a" > 
		<input type="hidden" name="onttoken1" id="hwonttoken1" value="<%HW_WEB_GetToken();%>">
      </td> 
    </tr> 
  </table> 
</div> 
<script>
ParseBindTextByTagName(RestoreLgeDes, "td",     1);
ParseBindTextByTagName(RestoreLgeDes, "input",  2);
ParseBindTextByTagName(RestoreLgeDes, "div",  1);
ParseBindTextByTagName(RestoreLgeDes, "span", 1);
</script>

</body>
</html>
