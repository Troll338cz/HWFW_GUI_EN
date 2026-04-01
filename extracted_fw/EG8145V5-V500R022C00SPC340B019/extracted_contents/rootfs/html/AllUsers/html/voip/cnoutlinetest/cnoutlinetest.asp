<html>
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<title>voip telnum...</title>

<script language="JavaScript" type="text/javascript"> 

function stAuthState(AuthState)
{
    this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>; 
var SimIsAuth=SimConnStates[0].AuthState;

function RedirectPingResult()
{
    if (0 == SimIsAuth)
    {
        document.location = "../authfail/voipdisplayauthfail.asp";
    }
    else
    {
        document.location = "cnoutlinetestreal.asp";
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
