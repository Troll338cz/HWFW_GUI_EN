<html>
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>voip maintain...</title>

<script language="JavaScript" type="text/javascript"> 

var SigProtol = '<%HW_WEB_GetSigProtol();%>';

function RedirectPingResult()
{
	if ("H248" == SigProtol || "H.248" == SigProtol)
	{
		document.location = "h248voipmaintain.asp";
	}
	else
	{
		document.location = "sipvoipmaintain.asp";
	}
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