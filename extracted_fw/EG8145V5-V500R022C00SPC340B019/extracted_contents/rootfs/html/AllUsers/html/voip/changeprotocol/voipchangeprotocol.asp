<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<!--
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.js);%>"></script>
-->
<title>VOIP Interface</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, changeprotocol, diagnose);%>"></script>
<script language="javascript" src="../common/voip_disableallelement.asp"></script>
<script language="JavaScript" type="text/javascript"> 

var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var BhartiMode = 0;
var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";

if(CfgMode.toUpperCase() == 'BHARTI')
{
    BhartiMode = 1;
}

if (CfgMode.toUpperCase() == 'ROSUNION')
{
    protocolText = changeprotocol['vspa_protocolList_ros'];
} else {
    protocolText = changeprotocol['vspa_protocolList'];
}

var VoiceProfileNumber = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.VoiceService.1.VoiceProfileNumberOfEntries);%>';

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function stSignalingProtocol(Domain, SignalingProtocol)
{
    this.Domain = Domain;
    this.SignalingProtocol = SignalingProtocol;
}
var AllSignal = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}, SignalingProtocol, stSignalingProtocol);%>;

function stProtocolAbality(Domain, SignalingProtocols)
{
    this.Domain = Domain;
    this.SignalingProtocols = SignalingProtocols;
}
var ProtocolAbality = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.Capabilities, SignalingProtocols, stProtocolAbality);%>;
function stDeviceInfoVoiceMode(Domain, X_HW_VOICE_MODE)
{
    this.Domain = Domain;
    this.X_HW_VOICE_MODE = X_HW_VOICE_MODE;
}

var DeviceVoiceMode = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo, X_HW_VOICE_MODE, stDeviceInfoVoiceMode);%>;

function SubmitStartChangeProtocol()
{
    if(AllSignal[0] == null)
    {
        return false;
    }
    
    if(ConfirmEx(diagnose['vspa_prochangehint'])) 
    {
        var Form = new webSubmitForm();
            
        Form.addParameter('x.SignalingProtocol',getValue('ProtocolList'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        
        Form.setAction('set.cgi?x=' + AllSignal[0].Domain + '&RequestFile=html/voip/changeprotocol/voipchangeprotocol.asp');             
            
        Form.submit(); 
    }

}

function LoadFrame()
{
    if((VoiceProfileNumber  == 0) && (VoiceProfileNumber != ''))
    {
        setDisplay('vag_is_exist', 0);
        document.location = "../voiperror/voiperror.asp";
        return;
    }
    
    if ("H248" == AllSignal[0].SignalingProtocol || "H.248" == AllSignal[0].SignalingProtocol)
    {
        setSelect('ProtocolList', "H.248");
    }
    else
    {
        setSelect('ProtocolList', "SIP");
    }
    
    if ( DeviceVoiceMode != null )
    {
        if(DeviceVoiceMode[0] != null)
        {
            if(DeviceVoiceMode[0].X_HW_VOICE_MODE != 0)
            {
                setDisable('startChangeProtocol',1);
                setDisable('ProtocolList',1);
            }
        }
    }
    
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }
        b.innerHTML = diagnose[b.getAttribute("BindText")];
    }
	
	if(1 == BhartiMode)
	{
		DisableAllElement();
	}
	
	if(isOltVisualUser == 1)
	{
        var all_input = document.getElementsByTagName("input");
        for (var i = 0; i <all_input.length ; i++) 
        {
            var b_input = all_input[i];
            
            if (b_input.type == "button")
            {
                setDisable(b_input.id,1);
            }
            else
            {
                b_input.disabled = "disabled";
            }
        }
        $("select").attr("disabled",true);
	}
}

</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();">  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipProtocol", GetDescFormArrayById(changeprotocol, "v01"), GetDescFormArrayById(changeprotocol, "v02"), false);
</script>

<div class="title_spread"></div>
<div id="vag_is_exist">
<form id="changeprotocol">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
  <tr>
    <td class="table_title align_left width_per30"><script>document.write(protocolText);</script>
    </td>
    <td  class="table_right align_left width_per75" >
        <select name="ProtocolList" id="ProtocolList" class="wid_60px">
           <script language="JavaScript" type="text/javascript">
		   var ProtocolData=ProtocolAbality[0].SignalingProtocols.toUpperCase();
           if (ProtocolData.indexOf("SIP") >= 0)
		   {
		       document.write('<option value=' + "SIP" + '>' + "SIP"+ '<\/option>'); 
		   }
		   if ((ProtocolData.indexOf("H248") >=0) || (ProtocolData.indexOf("H.248") >=0))
		   {
			   document.write('<option value=' + "H.248" + '>' + "H.248"+ '<\/option>'); 
		   }   
		   
           </script>
      </select>
    </td> 
<script>
var VoipConfigFormList = HWGetLiIdListByForm("changeprotocol", null);
HWParsePageControlByID("changeprotocol", TableClass, changeprotocol, null);
</script>
  </tr>
</table>
</form>

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
  <tr> 
    <td class="table_submit width_per30"></td> 
    <td class="table_submit align_left">
   	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
       <input name="startChangeProtocol" id="startChangeProtocol" type="button" class="ApplyButtoncss buttonwidth_100px" value="Start Change" onClick="SubmitStartChangeProtocol();"/> 
              <script type="text/javascript">
                  document.getElementsByName('startChangeProtocol')[0].value = diagnose['vspa_diagapply'];    
              </script>
    </td> 
  </tr> 
</table> 

</body>
</div>
</html>
