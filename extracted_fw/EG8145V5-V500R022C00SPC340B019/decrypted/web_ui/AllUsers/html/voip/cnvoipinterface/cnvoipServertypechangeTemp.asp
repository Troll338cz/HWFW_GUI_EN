<html>
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<title>voip interface...</title>

<script language="JavaScript" type="text/javascript"> 

function ServerTempRefresh()
{
	document.location = "cnvoipinterface.asp";
}

function RedirectPingResult()
{
	setTimeout("ServerTempRefresh()", 1200);
}

function LoadFrame()
{
    RedirectPingResult();
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">

<table height="200px">
    <tr><td></td></tr>
    
</table>
<table align="center" width="100%">
    <tr>
        <td align="center">
        <td>
    </tr>
</table>
</body>
</html>