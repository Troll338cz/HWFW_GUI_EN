<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>家庭存储帮助</title>
</head>
<body class="mainbody">
<blockquote>

<script language="javascript">
var MngtSabam = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_USBPRINTER);%>'; 
var MngtDLNA = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_DLNA);%>'; 
var curUserType='<%HW_WEB_GetUserType();%>';
var CfgBinMode ='<%HW_WEB_GetBinMode();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
if(1 == MngtSabam)
{
	if('CMCC' == CfgBinMode.toUpperCase())
	{
		document.write("<b>FTP</b>");
	}
	else
	{
		document.write("<b>远程下载</b>");
	}
	document.write("<p>远程下载，正确配置后，可以自动从指定的服务器地址下载文件到家庭网关的存储空间内，实现资源共享。<p>");
}

if (CfgBinMode.toUpperCase() == 'A8C')
{
    document.write("<b>远程下载</b>");
    document.write("<p>远程下载，正确配置后，可以自动从指定的服务器地址下载文件到政企网关的存储空间内，实现资源共享。<p>");
}

if('SHXCNCATV' != CfgBinMode.toUpperCase())
{
	if(1 == MngtSabam)
	{
		
		document.write("<br>");
		if('CMCC' == CfgMode.toUpperCase())
		{
			document.write("<b>USB共享打印</b>");
		}
		else
		{
			document.write("<b>家庭共享</b>");
		}
		document.write("<p> 通过家庭共享功能，您可以开启和设置家庭打印机和存储共享。开启了存储共享，您可以更加方便的访问连接到终端的USB设备中的资源。</p>");
	}

	if(1 == MngtDLNA)
	{
		document.write("<br>");
		document.write("<b>媒体共享 </b>");
		document.write("<p> 通过媒体共享功能，您可以将USB存储设备内的媒体信息（视频、音乐、图片）共享给支持DLNA功能的设备，如个人电脑、移动设备、消费电器等，让您可以在这些设备上随时欣赏媒体内容。</p>");
	}

	if('0' == curUserType && ('CMCC' != CfgBinMode.toUpperCase()))
	{
		document.write("<br>");
		document.write("<b>IPTV（仅部分型号支持）</b>");
		document.write("<p> 可以设置WAN口组播VLAN。</p>");
	}
}
</script>
</blockquote>

</body>
</html>

