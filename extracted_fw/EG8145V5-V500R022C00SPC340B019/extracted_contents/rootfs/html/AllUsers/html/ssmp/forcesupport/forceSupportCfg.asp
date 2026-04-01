<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function GetLanguageDesc(Name)
{
    return forceSupportLangDes[Name];
}

function LoadFrame()
{ 

}
function closeForceSupport()
{
	if(ConfirmEx(GetLanguageDesc("s0101"))) 
	{
		setDisable('btnClose',1);
		
		var Form = new webSubmitForm();
				
		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_UserInfo'
								+ '&RequestFile=html/ssmp/forcesupport/forceSupportCfg.asp');
		Form.addParameter('x.ForceSupport', 0);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));						
		Form.submit();
	}
}
</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">

	<div class="func_spread"></div>
	<div class="title_with_desc">
		<label id="Title_reboot_lable">强推配置</label>
	</div>
	<div class="title_01" style="padding-left:10px;" width="100%">
		<label id="Title_reboot_tips_lable">点击此按钮可以关闭强推功能。</label>
	</div>
	<div class="button_spread"></div>
	<div align="right">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<input type='button' name="Restart_button" id="Restart_button" class="submit" style="width:98px" onClick='closeForceSupport()' value="关闭强推">
	</div>
</body>
</html>
