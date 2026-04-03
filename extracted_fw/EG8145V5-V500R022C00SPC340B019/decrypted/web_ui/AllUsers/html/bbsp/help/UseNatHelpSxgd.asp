<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<title>设备信息帮助</title>
</head>
<body class="mainbody">
<blockquote>

<script language="JavaScript" type="text/javascript">
var MngtFjct = '<%HW_WEB_GetFeatureSupport(BBSP_FT_FJCT);%>';
var curUserType='<%HW_WEB_GetUserType();%>';

if ((1 == MngtFjct) && (curUserType == 1))
{
}
else
{
	document.write("  <p><b>ALG配置</b>  </p>");
	document.write("  <p> 在ALG配置页面上，可以通过选择相应的复选框，并打上勾，相应的ALG及硬件就能使用。支持FTP、TFTP、H.323、SIP和RTSP协议。<br></p>");
	document.write("  <p> <br>");
}
</script>

    <b>DMZ</b></p>
  <p> DMZ是英文“Demilitarized Zone”的缩写，中文名称为“隔离区”，也称“非军事化区”。它是为了解决安装防火墙后外部网络不能访问内部网络服务器的问题而设立的一个非安全系统与安全系统之间的缓冲区，在这个区域内可以放置一些必须公开的服务器设施，如企业WEB服务器、FTP服务器和论坛等。DMZ可以实现来自 WAN 口所有外网数据映射到内网的某台主机上。
  <p><b>WAN名称：</b>外网数据从哪个WAN口进来。<br />
    <b> 主机地址：</b>映射到的内网主机IP地址。  
  <p>  
  <p><br>

</blockquote>
</body>
</html>

