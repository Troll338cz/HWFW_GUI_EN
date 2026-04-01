<html>
<head>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<title>voip interface...</title>
<script language = "JavaScript" type = "text/javascript">

function stSignalingProtocol(Domain, SignalingProtocol)
{
    this.Domain = Domain;
    this.SignalingProtocol = SignalingProtocol;
}
var AllSignal = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1, SignalingProtocol, stSignalingProtocol);%>;


function RedirectPingResult()
{
    if (AllSignal[0].SignalingProtocol == "H248" || AllSignal[0].SignalingProtocol == "H.248")
    {
        document.location = "sipvoipdiagnose.asp";
    }
    else
    {
        document.location = "sipvoipdiagnose.asp";
    }
}

function LoadFrame()
{
    RedirectPingResult();
}

</script>
</head>

<body class = "mainbody" onLoad = "LoadFrame();">
<table height = "200px">
    <tr><td></td></tr>
</table>
<table align = "center" width = "100%">
    <tr>
        <td align = "center">
        <td>
    </tr>
</table>
</body>
</html>