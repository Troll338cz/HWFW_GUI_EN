<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>Bundle Information</title>
<script>
function stBundleInfo(domain,bundleid,bundleStatus,bundlename,bundleversion)
{
    this.domain = domain;
    this.bundleid = bundleid;
    this.bundleStatus = bundleStatus;
    this.bundlename = bundlename;
	this.bundleversion = bundleversion;
}

function GetLanguageDesc(Name)
{
    return SmartOntdes[Name];
}

var token = '<%HW_WEB_GetToken();%>';
var BundleInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Bundle.{i}, bundleid|bundleState|name|version,stBundleInfo);%>;
var BundleLen = BundleInfo.length - 1;

</script>
</head>

<body class="mainbody">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("boundlestatusasp", GetDescFormArrayById(SmartOntdes, "smart035"), GetDescFormArrayById(SmartOntdes, "smart034B"), false);
</script> 
<div class="title_spread"></div>
<table class="tabal_bg width_100p" cellspacing="1" id="bundleid" width="100%">  
  <tr class="head_title"> 
    <td width="10%" align="center" BindText = 'smart036'></td> 
    <td width="15%" align="center" BindText = 'smart037'></td> 
    <td width="55%" align="center" BindText = 'smart038'></td>
    <td width="20%" align="center" BindText = 'smart039'></td>      
  </tr> 
	<script type="text/javascript" language="javascript">

	for (var i = 0; i < BundleLen; i++)
	{	
		document.write('<TR id="record_' + i + '" class="tabal_01">');
		document.write('<TD align="center">' + (i + 1) + '</TD>');
		document.write('<TD align="center">' + htmlencode(BundleInfo[i].bundleStatus) + '</TD>');
		document.write('<TD align="center">' + htmlencode(BundleInfo[i].bundlename) + '</TD>');
		document.write('<TD align="center">' + htmlencode(BundleInfo[i].bundleversion) + '</TD>');
		document.write('</TR>');
	}
        
	if (0 == BundleLen)
	{
		document.write("<tr class= \"tabal_center01\">");
		document.write('<td align="center" >'+'--'+'</td>');
		document.write('<td align="center" >'+'--'+'</td>');
		document.write('<td align="center" >'+'--'+'</td>');
		document.write('<td align="center" >'+'--'+'</td>');
		document.write("</tr>");
	}
	</script> 
</table>  
<div class="func_spread"></div>
<div class="func_spread"></div>
<script>
ParseBindTextByTagName(SmartOntdes, "span", 1);
ParseBindTextByTagName(SmartOntdes, "td", 1);
ParseBindTextByTagName(SmartOntdes, "div", 1);
</script>

</body>
</html>
