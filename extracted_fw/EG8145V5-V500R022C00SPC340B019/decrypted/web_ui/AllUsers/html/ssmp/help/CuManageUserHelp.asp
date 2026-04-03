<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
var Modify_Amdin_Pwd = '<%HW_WEB_GetFeatureSupport(HW_SSMP_WEB_MODIFY_AMDIN_PWD);%>';
var curUserType='<%HW_WEB_GetUserType();%>';
</script>
<title>设备信息帮助</title>
</head>
<body class="mainbody">
<blockquote>
<p><b>用户管理</b>
<script language="JavaScript" type="text/javascript">
if('1' == Modify_Amdin_Pwd && '0' == curUserType)
{
	document.write("<p>执行该操作，可以修改普通用户和管理员用户的登录密码。");
}
else
{
	document.write("<p>执行该操作，可以修改普通用户的登录密码。");
}
</script>

</blockquote>
</body>
</html>
