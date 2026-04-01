<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(gateway.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>GAMES & APPLICATIONS</title>
<script language="JavaScript" type="text/javascript">
function LoadFrame()
{
    return;
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
				<table class="setupWifiTable" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th colspan="2" BindText="bm001"></th>
						</tr>
					</thead>
					<tbody>
						<tr class="header">
							<td colspan="2" BindText="bm002">
							</td>
						</tr>
						<tr>
							<td class="firstChild">
								<strong BindText="bm003"></strong><br />
								<select name="select" id="select"></select>
							</td>
							<td class="firstChild">
								<strong BindText="bm004"></strong><br />
							    <input type="text" name="textfield" id="textfield" />
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" class="red">
								<span class="vmsg error" BindText="bm005"></span>
								<span class="vmsg error" BindText="bm006"></span>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<a href="#" class="btn-default-orange-small right"><span BindText="bm007"></span></a>
								<a href="#" class="btn-default-orange-small right"><span BindText="bm008"></span></a>
							</td>
						</tr>
					</tfoot>
				</table>
				
				<table class="setupWifiTable">
						<thead>
							<tr>
								<th colspan="4" BindText="bm009"></th>
							</tr>
							<tr>
								<th BindText="bm010"></th>
								<th BindText="bm011"></th>
								<th BindText="bm012"></th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
</body>
<script>
	ParseBindTextByTagName(GamesLgedes, "th",   1);
	ParseBindTextByTagName(GamesLgedes, "td",   1);
	ParseBindTextByTagName(GamesLgedes, "span", 1);
	ParseBindTextByTagName(GamesLgedes, "a", 1);
	ParseBindTextByTagName(GamesLgedes, "strong", 1);
</script>
</html>
