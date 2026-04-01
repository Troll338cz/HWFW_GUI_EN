<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>设备信息帮助</title>
</head>
<body class="mainbody">
<blockquote>
<b>设备重启</b>
<p>点击 “重启” 按钮使终端重新启动。</p>
<br>
<script language="javascript">
	var MngtJsCmcc = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCMCC);%>';
	var ftForceSupport = '<%HW_WEB_GetFeatureSupport(FT_WEB_FORCESUPPORT);%>';
	if (MngtJsCmcc != 1)
	{
		document.write("<b>恢复默认配置 </b>");
		document.write("<p>  点击 “恢复默认配置” 按钮，使终端设备的配置恢复为默认配置并保留关键参数（如语音、无线参数等）。</p>");
		document.write("<br>");
	}
	if (ftForceSupport == 1)
	{
		document.write("<b>关闭强推 </b>");
		document.write("<p>  点击 “关闭强推” 按钮，可以关闭终端的强制推送页面功能。</p>");
		document.write("<br>");
	}
</script>
</blockquote>
</body>
</html>

