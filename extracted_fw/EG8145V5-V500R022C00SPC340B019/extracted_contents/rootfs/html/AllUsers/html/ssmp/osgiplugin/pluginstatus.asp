<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link type='text/css' rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link type='text/css' rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
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
    return PluginStatusLgeDes[Name];
}

var stWapArrayLinkStatus = <%HW_WEB_GetPgnCntLink();%>;

var WapLinkStatus = stWapArrayLinkStatus[0];
var stShowInfo =  new Array(new stWapLinkInfo("0","0","0","0","0","0"),null);
var Result = stShowInfo[0];

if(WapLinkStatus.waplinks == 4 || WapLinkStatus.waplinks == 5 || WapLinkStatus.waplinks == 6 || WapLinkStatus.waplinks == 7 || WapLinkStatus.waplinks == 8 || WapLinkStatus.waplinks == 9)
{
	var Dest = WapLinkStatus.wapRegCerurl == "" ? PluginStatusLgeDes["s0304"] : WapLinkStatus.wapRegCerurl;
	Result.wapRegCerlinks = PluginStatusLgeDes["s0303"] + Dest;
}
else if(WapLinkStatus.waplinks == 10 || WapLinkStatus.waplinks == 11)
{
	var Dest = WapLinkStatus.wapRegCerurl == "" ? PluginStatusLgeDes["s0304"] : WapLinkStatus.wapRegCerurl;
	Result.wapRegCerlinks = PluginStatusLgeDes["s0309"] + Dest + PluginStatusLgeDes["s030a"];
}
else if(WapLinkStatus.waplinks == 12)
{
	var Dest = WapLinkStatus.wapRegCerurl == "" ? PluginStatusLgeDes["s0304"] : WapLinkStatus.wapRegCerurl;
	Result.wapRegCerlinks = PluginStatusLgeDes["s0309"] + Dest + PluginStatusLgeDes["s030b"];
}
else
{
	Result.wapRegCerlinks = PluginStatusLgeDes["s030d"];
}

if(WapLinkStatus.pluginlinks == 1 || WapLinkStatus.pluginlinks == 2 || WapLinkStatus.pluginlinks == 3)
{
	var Dest = WapLinkStatus.pluginurl == "" ? PluginStatusLgeDes["s0304"] : WapLinkStatus.pluginurl;
	Result.pluginlinks = PluginStatusLgeDes["s0303"] + Dest;
}
else if(WapLinkStatus.pluginlinks == 4)
{
	var Dest = WapLinkStatus.pluginurl == "" ? PluginStatusLgeDes["s0304"] : WapLinkStatus.pluginurl;
	Result.pluginlinks = PluginStatusLgeDes["s0309"] + Dest + PluginStatusLgeDes["s030a"];
}
else if(WapLinkStatus.pluginlinks == 5)
{
	var Dest = WapLinkStatus.pluginurl == "" ? PluginStatusLgeDes["s0304"] : WapLinkStatus.pluginurl;
	Result.pluginlinks = PluginStatusLgeDes["s0309"] + Dest + PluginStatusLgeDes["s030b"];
}
else
{
	Result.pluginlinks = PluginStatusLgeDes["s030d"];
}
</script>
</head>


<body class="mainbody">
	<script language="JavaScript" type="text/javascript">
		HWCreatePageHeadInfo("pluginstatus", GetDescFormArrayById(PluginStatusLgeDes, "s0100"), GetDescFormArrayById(PluginStatusLgeDes, "s0301"), false);
	</script>
	<div class="title_spread"></div>
	<form id="PluginStatusForm">
		<table id="PluginStatusshowPanel" width="100%" cellspacing="1" cellpadding="0">
			<li id="td1_2" RealType="HtmlText" DescRef="s0308" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td1_2" InitValue="Empty" />
			<li id="td2_2" RealType="HtmlText" DescRef="s030c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td2_2" InitValue="Empty" />
		</table>
		<script>
			var PluginStatusFormList = new Array();
			var TableClass = new stTableClass("width_per50", "width_per50");
			PluginStatusFormList = HWGetLiIdListByForm("PluginStatusForm", null);

			HWParsePageControlByID("PluginStatusForm", TableClass, PluginStatusLgeDes, null);

			var PluginStatusArray = new Array();
			PluginStatusArray["td1_2"] = Result.wapRegCerlinks;
			PluginStatusArray["td2_2"] = Result.pluginlinks;

			HWSetTableByLiIdList(PluginStatusFormList, PluginStatusArray, null);
		</script>
	</form>
	
	
</body>
</html>
