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
function stWapLinkInfo(waplinks, wapurl, wapRegCerlinks,wapRegCerurl, pluginlinks, pluginurl)
{
    this.waplinks = waplinks;
	this.wapurl = wapurl;
	this.wapRegCerlinks = wapRegCerlinks;
	this.wapRegCerurl = wapRegCerurl;
    this.pluginlinks = pluginlinks;
	this.pluginurl = pluginurl;
}

function GetLanguageDesc(Name)
{
    return ssmpLanguage[Name];
}

var stWapArrayLinkStatus = <%HW_WEB_GetPgnCntLink();%>;

var WapLinkStatus = stWapArrayLinkStatus[0];
var stShowInfo =  new Array(new stWapLinkInfo("0","0","0","0","0","0"),null);
var Result = stShowInfo[0];

if(WapLinkStatus.waplinks == 0 || WapLinkStatus.waplinks == 1)
{
	var Dest = WapLinkStatus.wapurl == "" ? "平台" : WapLinkStatus.wapurl;
	Result.waplinks = "正在尝试连接" + Dest;
}
else if(WapLinkStatus.waplinks == 2 || WapLinkStatus.waplinks == 3)
{
	var Dest = WapLinkStatus.wapurl == "" ? "平台" : WapLinkStatus.wapurl;
	Result.waplinks = "与" + Dest + "保持连接中";
}
else if(WapLinkStatus.waplinks >= 4 && WapLinkStatus.waplinks <= 12)
{
	var Dest = WapLinkStatus.wapurl == "" ? "平台" : WapLinkStatus.wapurl;
	Result.waplinks = "与" + Dest + "连接结束";
}
else
{
	Result.waplinks = "未连接";
}


if(WapLinkStatus.waplinks == 4 || WapLinkStatus.waplinks == 5 || WapLinkStatus.waplinks == 6 || WapLinkStatus.waplinks == 7 || WapLinkStatus.waplinks == 8 || WapLinkStatus.waplinks == 9)
{
	var Dest = WapLinkStatus.wapRegCerurl == "" ? "平台" : WapLinkStatus.wapRegCerurl;
	Result.wapRegCerlinks = "正在尝试连接" + Dest;
}
else if(WapLinkStatus.waplinks == 10 || WapLinkStatus.waplinks == 11)
{
	var Dest = WapLinkStatus.wapRegCerurl == "" ? "平台" : WapLinkStatus.wapRegCerurl;
	Result.wapRegCerlinks = "向" + Dest + "注册中";
}
else if(WapLinkStatus.waplinks == 12)
{
	var Dest = WapLinkStatus.wapRegCerurl == "" ? "平台" : WapLinkStatus.wapRegCerurl;
	Result.wapRegCerlinks = "向" + Dest + "心跳保活中";
}
else
{
	Result.wapRegCerlinks = "未连接";
}

if(WapLinkStatus.pluginlinks == 1 || WapLinkStatus.pluginlinks == 2 || WapLinkStatus.pluginlinks == 3)
{
	var Dest = WapLinkStatus.pluginurl == "" ? "平台" : WapLinkStatus.pluginurl;
	Result.pluginlinks = "正在尝试连接" + Dest;
}
else if(WapLinkStatus.pluginlinks == 4)
{
	var Dest = WapLinkStatus.pluginurl == "" ? "平台" : WapLinkStatus.pluginurl;
	Result.pluginlinks = "向" + Dest + "注册中";
}
else if(WapLinkStatus.pluginlinks == 5)
{
	var Dest = WapLinkStatus.pluginurl == "" ? "平台" : WapLinkStatus.pluginurl;
	Result.pluginlinks = "向" + Dest + "心跳保活中";
}
else
{
	Result.pluginlinks = "未连接";
}
</script>
</head>

<body class="mainbody">
<div class="func_title"><label id = "Title_base_lable">平台连接状态</label></div>
<table class="tabal_bg width_100p" cellspacing="1" id="bundleid">  
  <tr align="left"> 
    <td width="40%" class="table_title">分发平台连接情况：</td> 
    <td width="60%" class="table_right"><script>document.write(htmlencode(Result.waplinks));</script></td> 
  </tr> 
    <tr align="left"> 
    <td width="40%" class="table_title">运营平台注册中心连接情况：</td> 
    <td width="60%" class="table_right"><script>document.write(htmlencode(Result.wapRegCerlinks));</script></td> 
  </tr> 
    <tr align="left"> 
    <td width="40%" class="table_title">运营平台插件中心连接情况：</td> 
    <td width="60%" class="table_right"><script>document.write(htmlencode(Result.pluginlinks));</script></td> 
  </tr> 
</table>  
</body>
</html>
