<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>智能系统完整性检测</title>
<script>
var g_TimerHandle = 0;
var g_waittime = 0;

var CheckResult = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.WAP_OSGI.PluginCheck.Result);%>';
function loadframe()
{
	if(g_TimerHandle != 0)
	{
		clearTimeout(g_TimerHandle);
		g_TimerHandle = 0;
		g_waittime = 0;
	}
	
	if(1 == CheckResult)
	{
		setDisable('btnStart',1);
		getElement('reportResult').innerHTML = '<B><FONT color=red>正在进行智能系统完整性检测，请稍候...'+ '</FONT><B>';
		g_TimerHandle = setInterval("GetCheckPluginResult()", 3000);
	}
	else if(2 == CheckResult)
	{
		setDisable('btnStart',0);
		getElement('reportResult').innerHTML = '<B><FONT color=red>智能系统完整性被破坏，请更新系统。</FONT></B>';
	}
	else if(3 == CheckResult)
	{
		setDisable('btnStart',0);
		getElement('reportResult').innerHTML = '<B><FONT color=red>智能系统完整性检测成功。</FONT></B>';
	}
	else if("" == CheckResult)
	{	
		setDisable('btnStart',0);
		getElement('reportResult').innerHTML = '<B><FONT color=red>访问智能系统完整性检测页面异常，请稍后重试！'+ '</FONT><B>';;
	}
}

function GetCheckPluginResult()
{
	if(g_waittime > 10)
	{
		clearTimeout(g_TimerHandle);
		setDisable('btnStart',0);
		getElement('reportResult').innerHTML = '<B><FONT color=red>启动智能系统完整性检测失败，请稍后重试！'+ '</FONT><B>';
		return;
	}
	
	var indextoken = getValue('onttoken');
	var ResultInfo = null;
	
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/getajax.cgi?x=InternetGatewayDevice.X_HW_DEBUG.WAP_OSGI.PluginCheck&RequestFile=html/ssmp/osgiplugin/plugincheck.asp',
		data: 'Result&x.X_HW_Token=' + indextoken,
		success : function(data) {
			 ResultInfo = hexDecode(data);
		}
	});
	
	g_waittime = g_waittime + 1;
	
	try{
		var ReportResult = $.parseJSON(ResultInfo);
		getElement('reportResult').innerHTML = '';
		if(ReportResult.result!='0')
		{
			clearTimeout(g_TimerHandle);
			setDisable('btnStart',0);
			getElement('reportResult').innerHTML = '<B><FONT color=red>启动智能系统完整性检测失败，请稍后重试！'+ '</FONT><B>';
		}
		else if (ReportResult.Result=='2')
		{	
			setDisable('btnStart',0);
			getElement('reportResult').innerHTML = '<B><FONT color=red>智能系统完整性被破坏，请更新系统。</FONT></B>';
			clearTimeout(g_TimerHandle);
		}
		else if(ReportResult.Result == '3')
		{
			setDisable('btnStart',0);
			getElement('reportResult').innerHTML = '<B><FONT color=red>智能系统完整性检测成功。</FONT></B>';
			clearTimeout(g_TimerHandle);
		}
		else
		{
			setDisable('btnStart',1);
			getElement('reportResult').innerHTML = '<B><FONT color=red>正在进行智能系统完整性检测，请稍候...'+ '</FONT><B>';
		}
	}catch(e){
			
		setDisable('btnStart',1);
		getElement('reportResult').innerHTML = '<B><FONT color=red>正在进行智能系统完整性检测，请稍候...'+ '</FONT><B>';
	}
}

function StartPluginCheck()
{
	var StartResult="";
	var indextoken = getValue('onttoken');
	setDisable('btnStart',1);
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		timeout:5000,
		url : '/setajax.cgi?x=InternetGatewayDevice.X_HW_DEBUG.WAP_OSGI.PluginCheck&RequestFile=html/ssmp/osgiplugin/plugincheck.asp',
		data: 'x.Result=0&x.X_HW_Token=' + indextoken,
		success : function(data) {
			 StartResult = hexDecode(data);
		}
	});
	
	setDisable('btnStart',1);
	getElement('reportResult').innerHTML = '<B><FONT color=red>正在进行智能系统完整性检测，请稍候...'+ '</FONT><B>';
	g_TimerHandle = setInterval("GetCheckPluginResult()", 3000);
}

</script>
</head>

<body  class="mainbody" onload="loadframe();">
<div class="title_with_desc">智能系统完整性检测</div>
<div class="prompt" width="100%" class="title_01" style="padding-left: 10px;">
	点击[智能系统完整性检测]按钮，将启动智能系统完整性检测。
</div>

<div class="button_spread"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> 
<td class="table_submit"> 
<input name="btnStart" id="plugincheck_button" type="submit" class="submit" value="智能系统完整性检测" onclick="StartPluginCheck()">
<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
</td> 
</tr> 
</table> 
<div name="reportResult" id="reportResult"></div> 
<br>
<br>
</body>
</html>
