<html>
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<title>voip interface...</title>

<script language="JavaScript" type="text/javascript"> 

function stAuthState(AuthState)
{
	this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>; 
var SimIsAuth=SimConnStates[0].AuthState;

var VoiceState = 0;
VoiceState='<%HW_WEB_GetVoiceProcState();%>'; 

var VoiceProfileNumber = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.VoiceService.1.VoiceProfileNumberOfEntries);%>';

function stSignalingProtocol(Domain, SignalingProtocol)
{
    this.Domain = Domain;
    this.SignalingProtocol = SignalingProtocol;
}
var AllSignal = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}, SignalingProtocol, stSignalingProtocol);%>;

function InterfaceRefresh()
{
	document.location = "cnvoipinterface.asp";
}

function RedirectPingResult()
{

    if((VoiceProfileNumber  == 0) && (VoiceProfileNumber != ''))
    {
        document.location = "../voiperror/voiperror.asp";
        return;
    }

	if (1 == VoiceState)       
	{
		setTimeout("InterfaceRefresh()", 1000);
	}	
	else if (0 == SimIsAuth)
	{
		document.location = "../authfail/voipdisplayauthfail.asp";
	}
	else if ("H248" == AllSignal[0].SignalingProtocol || "H.248" == AllSignal[0].SignalingProtocol)
    {
        document.location = "cnh248voipinterface.asp";
    }
    else
    {
        document.location = "cnsipvoipinterface.asp";
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