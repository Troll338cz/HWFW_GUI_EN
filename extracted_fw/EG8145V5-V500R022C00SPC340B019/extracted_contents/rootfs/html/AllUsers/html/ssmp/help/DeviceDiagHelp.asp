<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
var Customz_CMCC_RMS = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
var iperfflag = '<%HW_WEB_GetFeatureSupport(FT_IPERF_TEST);%>'
</script>

<title>诊断帮助</title>
</head>
<body class="mainbody">
<blockquote>
<script language="JavaScript" type="text/javascript">
if('1' != Customz_CMCC_RMS)
{
	document.write("<p><b>硬件故障诊断</b>");
	document.write("<p>点击“开始硬件故障检测”按钮，对主要器件做基本的功能检测。本功能尽力对硬件进行功能测试，但无法保证检测出所有硬件故障。<br>");
}
</script>
<p><b>远程镜像</b></p>
<p>通过镜像功能，镜像进出CPU的报文。或者实时抓取报文。</p>
<br>
<p><b>家庭网络测速</b></p>
<p>通过使用家庭网络测速，检测当前网络的带宽状态。</p>

<script language="JavaScript" type="text/javascript">
if(iperfflag == 1)
{
	document.write("<br><p><b>分段测速</b>");
	document.write("<p>通过使用分段测速，对家庭网关测速，包括网关到Internet，AP到AP等测速。</p><br>");
}
</script>
<br>
<p><b>软件故障诊断</b></p>
<p>收集和下载故障信息。</p>
<br>
<p><b>日志诊断</b></p>
<p>查看日志信息，或者通过点击“下载日志文件”按钮下载日志文件。</p>
<br>
</blockquote>

</body>
</html>

