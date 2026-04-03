<html>
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<title>voip interface...</title>

<script language="JavaScript" type="text/javascript"> 

var VoiceProfileNumber = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.VoiceService.1.VoiceProfileNumberOfEntries);%>';

function stSignalingProtocol(Domain, SignalingProtocol)
{
    this.Domain = Domain;
    this.SignalingProtocol = SignalingProtocol;
}
var AllSignal = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}, SignalingProtocol, stSignalingProtocol);%>;

function RedirectPingResult()
{
    if((VoiceProfileNumber  == 0) && (VoiceProfileNumber != ''))
    {
        document.location = "../voiperror/voiperror.asp";
        return;
    }
    
	if ("H248" == AllSignal[0].SignalingProtocol || "H.248" == AllSignal[0].SignalingProtocol)
    {
        document.location = "vdfh248voipstatus.asp";
    }
    else
    {
        document.location = "vdfsipvoipstatus.asp";
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