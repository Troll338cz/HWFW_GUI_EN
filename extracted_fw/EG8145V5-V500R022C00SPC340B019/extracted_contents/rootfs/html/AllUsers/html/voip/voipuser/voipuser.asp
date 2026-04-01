<html>
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>voip user...</title>

<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
function stAuthState(AuthState)
{
	this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>; 
var SimIsAuth=SimConnStates[0].AuthState;

var VoiceProfileNumber = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.VoiceService.1.VoiceProfileNumberOfEntries);%>';

function stSignalingProtocol(Domain, SignalingProtocol)
{
    this.Domain = Domain;
    this.SignalingProtocol = SignalingProtocol;
}
var AllSignal = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}, SignalingProtocol, stSignalingProtocol);%>;

function RedirectPingResult()
{
    if ((VoiceProfileNumber == 0) && (VoiceProfileNumber != '')) {
        document.location = "../voiperror/voiperror.asp";
        return;
    }
	if (SimIsAuth == 0) {
	    document.location = "../authfail/voipdisplayauthfail.asp";
	} else if (AllSignal[0].SignalingProtocol == "H248" || AllSignal[0].SignalingProtocol == "H.248") {
        if (((CfgMode.toUpperCase() == 'ANTEL') || (CfgMode.toUpperCase() == 'ANTEL2')) && (curLoginUserType != "0")) {
            document.location = "sipvoipuser.asp";
        } else {
            document.location = "h248voipuser.asp";
        }
    } else {
        document.location = "sipvoipuser.asp";
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