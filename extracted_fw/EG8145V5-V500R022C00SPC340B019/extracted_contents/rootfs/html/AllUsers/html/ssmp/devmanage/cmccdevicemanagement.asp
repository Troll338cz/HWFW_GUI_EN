<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function LoadFrame()
{
}

function RestoreDefaultCfg()
{
	if(ConfirmEx("如果您恢复了默认配置，您的私有配置将会丢失，并且设备将会自动重启。\n确定要恢复默认配置吗?"))
	{
		var Form = new webSubmitForm();

		setDisable('btnRestoreDftCfg', 1);
		setDisable('Restart_button',   1);
		setDisable('Restore_button',    1);
		Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function RestoreDefaultCfgAll()
{
	if(ConfirmEx("如果您恢复了出厂配置，您的私有配置和关键参数将会丢失，并且设备将会自动重启。\n确定要恢复默认出厂配置吗?"))
	{
		var Form = new webSubmitForm();

		setDisable('Restore_button',    1);
		setDisable('Restart_button',    1);
		setDisable('UsbbtnDown_button', 1);
		setDisable('btnRestoreDftCfg',  1);
		Form.setAction('restoredefaultcfgall.cgi?' + 'RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">

	<div class="func_spread"></div>
	<div class="title_with_desc">
		<lable>恢复默认配置</lable>
	</div>
	<div class="button_spread"></div>
	<div class="title_01" style="padding-left:10px;" width="100%">
		<lable>在本页面上，您可以通过点击“恢复默认配置”使终端设备的配置恢复为默认配置并保留关键参数（如语音、无线参数等）。</lable>
	</div>
	<div class="button_spread"></div>
	<div align="right">
		<input type='button' name="btnRestoreDftCfg" id="btnRestoreDftCfg" class="submit" style="width:98px" onClick='RestoreDefaultCfg()' value='恢复默认配置'>
	</div>
	
	
	<div class="func_spread"></div>
	<div class="title_with_desc"><label id="Title_factoryset_backup_lable">恢复出厂配置</label></div>
	<div class="title_01" style="padding-left:10px;" width="100%"><label id="Title_factoryset_backup_tips_lable">点击如下按钮恢复路由器到出厂默认设置。</label> </div>
	<div class="button_spread"></div>
	<div align="right"> <input  class = "submit" name="Restore_button" id="Restore_button" type='button' style="width:98px" onClick='RestoreDefaultCfgAll()' value='恢复出厂配置'> </div>
	
	<div class="button_spread"></div>
	<div align="right">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	</div>

</body>
</html>
