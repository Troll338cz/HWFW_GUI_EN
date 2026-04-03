<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" type="text/javascript">

var LookLogType = 0;
if (location.href.indexOf("debuglogview_ios.asp?") > 0)
{
    LookLogType = location.href.split("?")[1]; 
}

function DownloadDebugLog()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('logtype', "opt");
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('debuglogdown.cgi?FileType=debuglog&RequestFile=html/ssmp/debuglog/debuglogview_ios.asp');
	Form.submit();
}

function DownloadWiFiLog()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('wifidebuglogdown.cgi?RequestFile=html/ssmp/debuglog/debuglogview_ios.asp');
	Form.submit();
}

function LoadFrame()
{
	if (0 == LookLogType)
	{
		DownloadDebugLog();
	}
	else if (1 == LookLogType)
	{
		DownloadWiFiLog();
	}
}

</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
	<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
</body>
</html>
