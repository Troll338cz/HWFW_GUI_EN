<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<title>诊断帮助</title>
</head>
<body class="mainbody">
<blockquote>
<p><b>Ping测试</b></p>
<p>通过使用Ping测试功能，可以检测LAN或者Internet的连接是否正常。</p>
<p><b>Tracert测试</b></p>
<p>通过使用Tracert测试功能，可以检测LAN或者Internet的连接是否正常。</p>


<script language="javascript">
    var ReportResultCfg = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_TR069);%>';
    var BjunicomFeature = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BJUNICOM);%>';
	var IsHangzhouMark = '<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_HANGZHOUMARK);%>';
	if(IsHangzhouMark == 1)
	{
		document.write("<p><b>Inform手动上报</b></p>");
		document.write("<p>点击“Inform手动上报”，可以手动连接RMS管理平台。</p>");	
	}

	else if(ReportResultCfg == 1)
	{
		document.write("<b>Inform手动上报 </b>");
		document.write("<p>  点击 “Inform手动上报” 按钮，使终端设备向网管服务器上报Info，检测和网管的连接状态。</p>");	
	}

	if (BjunicomFeature ==1)
	{
		document.write("<p><b>远程镜像</b></p>");
		document.write("<p>一键抓取报文。</p>");		
	}	   
</script>

</blockquote>

</body>
</html>

