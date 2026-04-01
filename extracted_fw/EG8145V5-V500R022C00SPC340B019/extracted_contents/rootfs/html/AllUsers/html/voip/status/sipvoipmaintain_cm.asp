<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<style>
.uriclass
{ 
	word-break:break-all;
	min-width:30px;
}

.regnameclass
{ 
	word-break:break-all;
}


</style>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>VOIP Status</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipstatus);%>"></script>
<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var CfgMode = '<%HW_WEB_GetCfgMode();%>';

function stLine(Domain, DirectoryNumber, PhyReferenceList, Status, CallState,RegisterError)
{
    this.Domain = Domain;
    if(DirectoryNumber != null)
    {
        this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.DirectoryNumber = DirectoryNumber;
    }
	
	this.PhyReferenceList = PhyReferenceList;
    this.Status = Status;
    this.CallState = CallState;
    this.RegisterError = RegisterError;
}

function stLineURI(Domain, URI)
{
	this.Domain = Domain;
	if(URI != null)
    {
        this.URI = URI.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.URI = URI;
    }

}
function setControl()
{
}

var AllLineURI = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,URI,stLineURI);%>;
var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|PhyReferenceList|Status|CallState|X_HW_LastRegisterError,stLine);%>;
var AllCodeAndReason = '<%HW_WEB_GetVspRegReason();%>';
var SplitCodeReason = AllCodeAndReason.split("|");

var OutputCodeReason = new Array();

for ( var m = 0; m < AllLine.length - 1; m++ )
{
	if ( m + 1 > SplitCodeReason.length )
	{
		OutputCodeReason[m] = '--';
	}
	else
	{
		if ( ( AllLine[m].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
		     || ( AllLine[m].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
			 || ( AllLine[m].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' ) )
		{
			OutputCodeReason[m] = SplitCodeReason[m];
		}
		else
		{
			OutputCodeReason[m] = '--';
		}		
	}
}



function stAuth(Domain, AuthUserName)
{
    this.Domain = Domain;
	if(AuthUserName != null)
    {
        this.AuthUserName = AuthUserName.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.AuthUserName = AuthUserName;
    }
    
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName,stAuth);%>;
var Auth = new Array();
for (var i = 0; i < AllAuth.length-1; i++) 
    Auth[i] = AllAuth[i];

var User = new Array();

function stUser(Domain, UserId)
{
    this.Domain = Domain;
    this.UserId = UserId;
}

for (var i = 0; i < AllLine.length - 1; i++)
{
    User[i] = new stUser();
    User[i].UserId = AllLine[i].DirectoryNumber;
}

function Reboot()
{
    if(ConfirmEx(sipstatus['vspa_restartalert'])) 
    {               
        var Form = new webSubmitForm();
        
        Form.addParameter('x.X_HW_Reset',1);   
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        
        Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1'
                        + '&RequestFile=html/voip/status/voipmaintain.asp');
        setDisable('btnReboot',1);
        Form.submit();        
    }
}

function LoadFrame()
{
    if (curLoginUserType == "0")
    {
        setDisplay('resetButton',1);
    }
	else if ((CfgMode.toUpperCase() == 'ANTEL')&&(curLoginUserType != "0"))
    {
        setDisplay('resetButton', 0);
    }
    else
    {
        setDisplay('resetButton',1);
    }
	
	if(CfgMode.toUpperCase() == 'PTVDF')
    {
	
        setDisplay('resetButton', 0);
    }
	
	if ('BJUNICOM' == CfgMode.toUpperCase())
	{
		getElementByName('btnReboot').disabled = true;
	}
	
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = sipstatus[b.getAttribute("BindText")];
	}
} 

//function ShowTab(index, URI, AuthUserName, PhyReferenceList, Status,CallState,RegisterError,ErrorCode)
function ShowTab(index, URI, AuthUserName, PhyReferenceList, Status,CallState,RegisterError)
{
	this.index = index;
	this.URI = URI;
	this.AuthUserName = AuthUserName;
	this.PhyReferenceList = PhyReferenceList;
	this.Status = Status;
	this.CallState = CallState;
	this.RegisterError = RegisterError;
	//this.ErrorCode = ErrorCode;
}


</script>
</head>



<body class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
if(CfgMode.toUpperCase() == 'PTVDF')
{
	HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(sipstatus, "v01"), GetDescFormArrayById(sipstatus, "vspa_voipmaintain_title"), false);
}
else
{
	HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(sipstatus, "v01"), GetDescFormArrayById(sipstatus, "v02"), false);
}
</script>


<div class="title_spread"></div>
<script language="JavaScript" type="text/JavaScript">
var i = 0;
var ShowableFlag = 1;
var ShowButtonFlag = 0;
var ColumnNum = 7;
var VoipArray = new Array();
var ConfiglistInfo = new Array(
		new stTableTileInfo("vspa_seq","align_center ","index",false),
	//	new stTableTileInfo("vspa_uri","uriclass align_center","URI",CfgMode.toUpperCase() == 'PTVDF'),		
		new stTableTileInfo("vspa_uri","uriclass align_center","URI",false),		
		new stTableTileInfo("vspa_username","regnameclass align_center","AuthUserName",false),
		new stTableTileInfo("vspa_assopots","align_center","PhyReferenceList",false),
		new stTableTileInfo("vspa_userstat","align_center","Status",false),
		new stTableTileInfo("vspa_callstat","align_center","CallState",false),
		new stTableTileInfo("vspa_errorstat","regnameclass align_center","RegisterError",false),null);
	//	new stTableTileInfo("vspa_regcodereason","align_center","ErrorCode",false),null);

if(AllLine.length - 1 == 0)
{
	var VoipShowTab = new ShowTab();
	VoipShowTab.index = "--";
	VoipShowTab.URI = "--";
	VoipShowTab.AuthUserName = "--";
	VoipShowTab.PhyReferenceList = "--";
	VoipShowTab.Status = "--"; 
	VoipShowTab.CallState = "--"; 
	VoipShowTab.RegisterError = "--"; 
//	VoipShowTab.ErrorCode = "--"; 
}

else
{
	for (i = 0; i < AllLine.length - 1; i++)
	{
		var VoipShowTab = new ShowTab();
		VoipShowTab.index = i + 1;
		
	//	if(CfgMode.toUpperCase() != 'PTVDF')
	//	{
			if (AllLineURI[i].URI == "")
			{
				VoipShowTab.URI = "--";
			}
			else
			{
				VoipShowTab.URI = AllLineURI[i].URI;
			}
	//	}
		
		if (User[i].UserId == "")
		{
			 if( Auth[i].AuthUserName.indexOf(":") >= 0)
			 {
				var Authpart = Auth[i].AuthUserName.split(':');
				var k1 = Authpart[1];
				var k2 = k1.split('@');
				var k3 = k2[0];
				if (k3 == "")
				{   
					VoipShowTab.AuthUserName = "--";
				}
				else
				{    
					VoipShowTab.AuthUserName = k3;
				}
			 }
			 else
			 {
				 var Authpart = Auth[i].AuthUserName.split('@');
				 var k = Authpart[0];
				if (k == "")
				{    
					VoipShowTab.AuthUserName = "--";
				}
				else
				{   
					VoipShowTab.AuthUserName = k; 
				}
			 }
		}
		else
		{
			 if( User[i].UserId.indexOf(":") >= 0)
			 {
				 var UserId = User[i].UserId.split(':');
				 var k1 = UserId[1];
				var k2 = k1.split('@');
				var k3 = k2[0];
				if (k3 == "")
				{    
					VoipShowTab.AuthUserName = "--";
				}
				else
				{    
					VoipShowTab.AuthUserName = k3;
				}
			 }
			 else
			 {
				 var UserId = User[i].UserId.split('@');
				 var k = UserId[0];
				if (k == "")
				{ 
					VoipShowTab.AuthUserName = "--";   
				}
				else
				{    
					VoipShowTab.AuthUserName = k; 
				}
			 }
		}   
		if (AllLine[i].PhyReferenceList == "")
		{    
			VoipShowTab.PhyReferenceList = "--";   
		}
		else
		{    
			VoipShowTab.PhyReferenceList = AllLine[i].PhyReferenceList;
		}
		
		if ( AllLine[i].CallState == "Idle" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_idle']; 
		}
		else if ( AllLine[i].CallState == "Calling" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_cal']; 
		}
		else if ( AllLine[i].CallState == "Ringing" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_ring'];
		}
		else if ( AllLine[i].CallState == "Connecting" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_con']; 
		}
		else if ( AllLine[i].CallState == "InCall" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_incall']; 
		}
		else if ( AllLine[i].CallState == "Hold" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_hold'];    
		}
		else if ( AllLine[i].CallState == "Disconnecting" )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_dis'];    
		}
		else
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_idle'];    
		}		

 		if ( AllLine[i].Status == "Up" )
		{
			VoipShowTab.Status = sipstatus['vspa_status_succ'];
		}
		else if ( AllLine[i].Status == "Initializing" )
		{    
			VoipShowTab.Status = sipstatus['vspa_status_ini'];
		}
		else if ( AllLine[i].Status == "Registering" )
		{    
			VoipShowTab.Status = sipstatus['vspa_status_reg'];
		}
		else if ( AllLine[i].Status == "Unregistering" )
		{  
	    	VoipShowTab.Status = sipstatus['vspa_status_unreg'];
		}
		else if ( AllLine[i].Status == "Quiescent" )
		{    
			VoipShowTab.Status = sipstatus['vspa_status_qui'];
		}
		else if ( AllLine[i].Status == "Disabled" )
		{
			VoipShowTab.Status = sipstatus['vspa_status_disa'];    
		}
		else if ( AllLine[i].Status == "Error" )
		{
			VoipShowTab.Status = sipstatus['vspa_status_err'];    
		}
		else if ( AllLine[i].Status == "Testing" )
		{
			VoipShowTab.Status = sipstatus['vspa_status_test'];    
		}
		else
		{
			VoipShowTab.Status = sipstatus['vspa_status_disa']; 
		}
		
		if ( AllLine[i].Status == "Error" )
		{
			if ( AllLine[i].RegisterError == "ERROR_ONU_OFFLINE" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_onuoffine'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_WAN_NOT_CONFIGURED" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_wannotconfigured'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_WAN_IP_NOT_OBTAINED" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_wannotobtained'];			
			}
			else if ( AllLine[i].RegisterError == "ERROR_CORENET_ADDRESS_INCORRECT" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_mgcincorrect'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_VOICESERVICE_DISABLED" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_voicedisabled'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_USER_NOT_CONFIGURED" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_usernotconfigured'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_USER_NOT_BOUND_TO_POTS" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_usernotboundport'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_POTS_DISABLED_BY_OLT" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_portdisabledOLT'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_USER_DISABLED" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_userdisable'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_REGISTRATION_AUTH_FAIL" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_regauthfails'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_REGISTRATION_TIME_OUT" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_regtimesout'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_mgcerrorresponse'];
			}
			else if ( AllLine[i].RegisterError == "ERROR_UNKNOWN" )
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_unknownerror'];
			}
			else
			{
				VoipShowTab.RegisterError = "RegisterError_unknown";
			}
		}
		else
		{
			VoipShowTab.RegisterError = "no error";
		}
	//	VoipShowTab.ErrorCode = OutputCodeReason[i];		
		VoipArray.push(VoipShowTab);
	}
}
VoipArray.push(null);
HWShowTableListByType(ShowableFlag, "tdVoipInfo", ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, sipstatus, null);
</script>

<div id="resetButton">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height5p"></td></tr>
</table>
<table width="100%" height="35" cellpadding="0" cellspacing="0" class="" >      
 <tr>
    <td  class="table_right" class="align_left">
    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    <input name="btnReboot" id="btnReboot" type="hidden" class="CancleButtonCss filebuttonwidth_100px" value="Restart VoIP" onClick="Reboot();"/> 
    <script type="text/javascript">
    document.getElementsByName('btnReboot')[0].value = sipstatus['vspa_restartvoip'];    
    </script>
    </td>
</tr>
</table>
<table width="100%" height="5" cellpadding="0" cellspacing="0" class="" >  
<tr>
</tr>
</table>
    </div>    
</form>
</td></tr>
</table>
</body>
</html>
