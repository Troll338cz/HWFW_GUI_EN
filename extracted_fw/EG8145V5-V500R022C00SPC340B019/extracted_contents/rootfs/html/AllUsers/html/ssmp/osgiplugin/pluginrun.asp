<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>Bundle Information</title>
<script>
function stBundleInfo(domain,bundleStatus,bundlename)
{
    this.domain = domain;
    this.bundleStatus = bundleStatus;
    this.bundlename = bundlename;
}

function GetLanguageDesc(Name)
{
    return ssmpLanguage[Name];
}

function IsPluginNeedHide(pluginName)
{
	var i;
	var hideList = ["java", "felix", "app_m", "com.chinatelecom.huawei.smartgateway.popwindow"];

	for (i=0; i<hideList.length; i++)
	{
		if (pluginName == hideList[i])
		{
			return true;
		}
	}
	return false;
}

var token = '<%HW_WEB_GetToken();%>';
var BundleInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Bundle.{i}, bundleState|name, stBundleInfo);%>;
var BundleLen = BundleInfo.length - 1;

var CpluginStatus = '<%HW_WEB_GetCpluginStatus();%>';
var StatusArray = CpluginStatus.split("@");
var CplugLen = StatusArray.length-1;

</script>
</head>

<body class="mainbody">
<div class="func_title"><label id = "Title_base_lable">插件运行状态</label></div>
<table class="tabal_bg width_100p" cellspacing="1" id="bundleid">  
  <tr class="table_title"> 
    <td width="5%" align="center">序号</td> 
    <td width="70%" align="center">插件名称</td> 
    <td width="25%" align="center">状态</td> 
  </tr> 
	<script type="text/javascript" language="javascript">
	var RowID = 0;
	
	for (var i = 0; i < BundleLen; i++,RowID++)
	{
		document.write('<TR id="record_' + RowID + '" class="tabal_01">');
		document.write('<TD align="center">' + (RowID+1) + '</TD>');
		document.write('<TD align="center">' + htmlencode(BundleInfo[i].bundlename) + '</TD>');
		document.write('<TD align="center">' + (htmlencode(BundleInfo[i].bundleStatus) == "ACTIVE" ? "运行" : "停止") + '</TD>');
		document.write('</TR>');
	}

	for (var j = 0; j < CplugLen; j++)
	{
		var StatusLine = StatusArray[j];
		var SessionArray = StatusLine.split("|");
		if (IsPluginNeedHide(SessionArray[0]))
		{
			continue;
		}
		
		document.write('<TR id="record_' + RowID + '" class="tabal_01">');
		document.write('<TD align="center">' + (RowID+1) + '</TD>');
		document.write('<TD align="center">' + htmlencode(SessionArray[0]) + '</TD>');
		document.write('<TD align="center">' + (htmlencode(SessionArray[2]) == "ACTIVE" ? "运行" : "停止") + '</TD>');
		document.write('</TR>');
		
		RowID++;
	}
    
	if (0 == RowID)
	{
		document.write("<tr class= \"tabal_center01\">");
		document.write('<td style="background:#FFFFFF">'+'--'+'</td>');
		document.write('<td style="background:#FFFFFF">'+'--'+'</td>');
		document.write('<td style="background:#FFFFFF">'+'--'+'</td>');
		document.write("</tr>");
	}

	</script> 
</table>  
</body>
</html>
