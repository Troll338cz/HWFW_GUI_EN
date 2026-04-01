<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Status</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248status);%>"></script>
<style>
.uriclass
{ 
	word-break:break-all;
	min-width:30px;
}
.regnameclass
{ 
	word-break:break-all;
	width:110px;
}
</style>
<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';

var CfgWord = CfgMode.toUpperCase();
var isUnicomFlag = false;
if(CfgWord.indexOf("CU") >=0 || CfgWord.indexOf("UNICOM") >=0 )
{
	isUnicomFlag = true;
}
else
{
	isUnicomFlag = false;
}

function stInterfaceState(Domain, X_HW_InterfaceState)
{
    this.Domain = Domain;
    this.X_HW_InterfaceState = X_HW_InterfaceState;
}

var InterfaceState = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1,X_HW_InterfaceState,stInterfaceState);%>;

function stLine(Domain, DirectoryNumber, PhyReferenceList,Status, CallState,RegisterError)
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

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i},DirectoryNumber|PhyReferenceList|Status|CallState|X_HW_LastRegisterError,stLine);%>;

function stH248LineName(Domain, LineName)
{
    this.Domain = Domain;
	if(LineName != null)
    {
        this.LineName = LineName.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.LineName = LineName;
    }
}

var AllH248LineName = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.{i}.X_HW_H248,LineName,stH248LineName);%>;

var User = new Array();

function stUser(Domain, UserId)
{
    this.Domain = Domain;
    this.UserId = UserId;
}
      
for (var i = 0; i < AllLine.length - 1; i++)
{
    User[i] = new stUser();
    User[i].UserId = AllH248LineName[i].LineName;
}

function setControl()
{
}

function Reboot()
{
    if(confirm(h248status['vspa_restartalert'])) 
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

var AllCodeAndReason = '<%HW_WEB_GetVspRegReason();%>';


var SplitCodeReason = AllCodeAndReason.split("|");
var SplitCodeReaRegTimeForOneUser = new Array();
var OutputRegTime    = new Array();


for ( var m = 0; m < AllLine.length - 1; m++ )
{
	if ( m + 1 > SplitCodeReason.length )
	{
		OutputRegTime[m]    = '--';
	}
	else
	{
	
		SplitCodeReaRegTimeForOneUser[m] = SplitCodeReason[m].split("<");
		if(SplitCodeReaRegTimeForOneUser[m].length < 2)
		{
			OutputRegTime[m] = "--";
		}
		else
		{
			OutputRegTime[m] = SplitCodeReaRegTimeForOneUser[m][1];
		}	
	}
}



function LoadFrame()
{
    if (curLoginUserType == "0") {
        setDisplay('resetButton', 1);
    } else {
        setDisplay('resetButton', 0);
    }
	
	if ((CfgMode.toUpperCase() == 'TELECOM') || (CfgMode.toUpperCase() == 'TELECOM2')) {
		getElementByName('btnReboot').disabled = true;
	}
			
	if (CfgMode.toUpperCase() == 'BHARTI') {
		getElementByName('btnReboot').disabled = true;
	}

    if ((CfgMode.toUpperCase() == "RDSGATEWAY") && (curUserType != "0")) {
        setDisplay('resetButton', 0);
    }

	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length; i++) {
		var b = all[i];
		if (b.getAttribute("BindText") == null){
			continue;
		}
		b.innerHTML = h248status[b.getAttribute("BindText")];
	}
}  

function GetInterfaceState()
{
	if ( InterfaceState[0].X_HW_InterfaceState == 'Closed' )
	{
		return h248status['vspa_state_closed'];
    }
    else if ( InterfaceState[0].X_HW_InterfaceState == 'Closing' )
    {
		return h248status['vspa_state_closing'];
    }
    else if ( InterfaceState[0].X_HW_InterfaceState == 'Inservice' )
    {
		return h248status['vspa_state_inserv'];
	}
	else if ( InterfaceState[0].X_HW_InterfaceState == 'Restarting' )
	{
		return h248status['vspa_state_restarting'];
	}
    else if ( InterfaceState[0].X_HW_InterfaceState == 'Graceful Closed' )
    {
		return h248status['vspa_state_grace'];
    }
    else if ( InterfaceState[0].X_HW_InterfaceState == 'MGC Disconnected' )
    {
		return h248status['vspa_state_discon'];
    }
    else if ( InterfaceState[0].X_HW_InterfaceState == 'MGC Switching' )
    {
       return h248status['vspa_state_switch'];
    }
    else
    {
       return '--';
    }
} 

function ShowTab(index, UserId, TelNo, PhyReferenceList, Status,CallState,InterfaceState,RegisterError)
{
	this.index = index;
	this.UserId = UserId;
	this.TelNo = TelNo;
	this.PhyReferenceList = PhyReferenceList;
	this.Status = Status;
	this.CallState = CallState;
	this.InterfaceState = InterfaceState;
	this.RegisterError = RegisterError;
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
<script language="JavaScript" type="text/javascript">

if(CfgMode.toUpperCase().indexOf('PTVDF') >= 0)
{
	HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(h248status, "v01"), GetDescFormArrayById(h248status, "vspa_voipmaintain_title"), false);
}
else
{
	HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(h248status, "v01"), GetDescFormArrayById(h248status, "v02"), false);
}

</script>

<div class="title_spread"></div>
<script language="JavaScript" type="text/JavaScript">
var i = 0;

var ShowableFlag = 1;
var ShowButtonFlag = 0;
var ColumnNum = 9;
var VoipArray = new Array();
var ConfiglistInfo = new Array(
	new stTableTileInfo("vspa_seq","align_center","index",false),
	new stTableTileInfo("vspa_linename","uriclass align_center","UserId",false),
	new stTableTileInfo("vspa_telno","align_center","TelNo",false),
	new stTableTileInfo("vspa_assopots","align_center","PhyReferenceList",false),
	new stTableTileInfo("vspa_userstat","align_center","Status",false),
	new stTableTileInfo("vspa_callstat","align_center","CallState",false),
	new stTableTileInfo("vspa_regtime","align_center","RegTime",!(isUnicomFlag)),
	new stTableTileInfo("vspa_interfacestatu","align_center","InterfaceState",false),
	new stTableTileInfo("vspa_errorstat","regnameclass align_left","RegisterError",false),null);

if (AllLine.length - 1 == 0)
{
	var VoipShowTab = new ShowTab();
	
	VoipShowTab.index = "----";
	VoipShowTab.UserId = "----"; 
	VoipShowTab.TelNo = "----";
	VoipShowTab.PhyReferenceList = "----";
	VoipShowTab.Status = "----";
	VoipShowTab.CallState = "----";
	if(isUnicomFlag == true)
	{
		VoipShowTab.RegTime = "--";
	}
	VoipShowTab.InterfaceState = GetInterfaceState();
	VoipShowTab.RegisterError = "----";

}
else
{
	for (i = 0; i < AllLine.length - 1; i++)
	{
		var VoipShowTab = new ShowTab();
		VoipShowTab.index = i + 1;		
				
		if ( User[i].UserId == "")
		{	
			VoipShowTab.UserId = "--";
		}
		else
		{  
			VoipShowTab.UserId = User[i].UserId;         
		}
		
		VoipShowTab.TelNo = "--";
		
		VoipShowTab.PhyReferenceList = AllLine[i].PhyReferenceList;

		if ( AllLine[i].Status == 'Up' )
		{
			VoipShowTab.Status = h248status['vspa_state_up'];
		}
		else if ( AllLine[i].Status == 'Initializing' )
		{
			VoipShowTab.Status = h248status['vspa_state_ini'];
		}
		else if ( AllLine[i].Status == 'Registering' )
		{
			VoipShowTab.Status = h248status['vspa_state_reg'];
		}
		else if ( AllLine[i].Status == 'Unregistering' )
		{
			VoipShowTab.Status = h248status['vspa_state_unreg'];
		}
		else if ( AllLine[i].Status == 'Error' )
		{
			VoipShowTab.Status = h248status['vspa_state_err'];
		}
		else if ( AllLine[i].Status == 'Testing' )
		{
			VoipShowTab.Status = h248status['vspa_state_test'];
		}		
		else if ( AllLine[i].Status == 'Quiescent' )
		{
			VoipShowTab.Status = h248status['vspa_state_quies'];
		}
		else if ( AllLine[i].Status == 'Disabled' )
		{
			VoipShowTab.Status = h248status['vspa_state_disable'];
		}
		else
		{
			VoipShowTab.Status = "--";
		}
		
		if(isUnicomFlag == true)
		{
			VoipShowTab.RegTime =  htmlencode(OutputRegTime[i]);
		}
		
		if ( AllLine[i].CallState == 'Idle' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_idle'];
		}
		else if ( AllLine[i].CallState == 'Calling' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_call'];
		}
		else if ( AllLine[i].CallState == 'Ringing' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_ring'];
		}
		else if ( AllLine[i].CallState == 'Connecting' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_con'];
		}
		else if ( AllLine[i].CallState == 'InCall' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_incall'];
		}
		else if ( AllLine[i].CallState == 'Hold' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_hold'];
		}
		else if ( AllLine[i].CallState == 'Disconnecting' )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_discon'];
		}
		else
		{
			VoipShowTab.CallState = "--";
		}
		
		VoipShowTab.InterfaceState = GetInterfaceState();
				
		if ( AllLine[i].RegisterError == '-' )
		{
			VoipShowTab.RegisterError = "--";
		}
		else if ( AllLine[i].RegisterError == 'ERROR_ONU_OFFLINE' )
		{		
			if (true == var_singtel)
			{
				VoipShowTab.RegisterError = h248status['vspa_errorstate_onroffine'];
			}
			else
			{
				VoipShowTab.RegisterError = h248status['vspa_errorstate_onuoffine'];
			}
		}
		else if ( AllLine[i].RegisterError == 'ERROR_WAN_NOT_CONFIGURED' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_wannotconfigured'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_WAN_IP_NOT_OBTAINED' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_wannotobtained'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_CORENET_ADDRESS_INCORRECT' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_mgcincorrect'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_VOICESERVICE_DISABLED' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_voicedisabled'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_CONFIGURED' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_usernotconfigured'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_BOUND_TO_POTS' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_usernotboundport'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_POTS_DISABLED_BY_OLT' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_portdisabledOLT'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_USER_DISABLED' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_userdisable'];
		}
        else if ( AllLine[i].RegisterError == 'ERROR_USER_CONFLICT' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_userconflict'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_regauthfails'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_regtimesout'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_mgcerrorresponse'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_UNKNOWN' )
		{
			VoipShowTab.RegisterError = h248status['vspa_errorstate_unknownerror'];
		}
		else
		{
			VoipShowTab.RegisterError = "--";
		}   
			
	VoipArray.push(VoipShowTab);	
	
	}
}
VoipArray.push(null);

HWShowTableListByType(ShowableFlag, "tdVoipInfo", ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, h248status, null);

</script>

</tr>
 </table>

<div id="resetButton">

    <table width="100%" cellpadding="0" cellspacing="1" >       
       <tr>
          	<td  class="table_right align_left">
          			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<input name="btnReboot" id="btnReboot" type="button" class="CancleButtonCss filebuttonwidth_100px" value="Restart VoIP" onClick="Reboot();"/>
				<script type="text/javascript">
			  	document.getElementsByName('btnReboot')[0].value = h248status['vspa_restartvoip'];	
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
