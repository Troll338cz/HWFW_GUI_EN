<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Status</title>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, h248status, sipstatus);%>"></script>
<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';

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

function ClickRefresh(DevType)
{
	window.parent.SetDeviceNum();
	window.location.reload();
}

function LoadFrame()
{
    if (curLoginUserType == "0")
    {
        setDisplay('resetButton',1);
    }
    else
    {
        setDisplay('resetButton',1);
    }
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = h248status[b.getAttribute("BindText")];
	}
	adjustParentHeight();
} 

function getHeight(id)
{
	var item = document.getElementById(id);
	if (item != null)
	{
		if (item.style.display == 'none')
		{
			return 0;
		}
		if (typeof item.scrollHeight == 'number')
		{
			return item.scrollHeight;
		}
		return null;
	}

	return null;
}

function adjustParentHeight()
{
	var dh = getHeight("H248Tel");
	var dh1 = getHeight("siptable");
	var height = (dh > 0 ? dh : 0) + (dh1 > 0 ? dh1 : 0) + 24;
	window.parent.adjustParentHeight("ContectdevmngtPage", height);
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

</script>
</head>
<body style="background-color:#EDF1F2;" onLoad="LoadFrame();">
<table id="H248Tel" class="DevNameTitle">
<tr><td width="5%">
<label id="devicetitle" name="devicetitle" class="DeviceTitle" style="white-space:nowrap;"><script>document.write(sipstatus['vspa_tel'])</script></label></td>
<td class="DeviceLine"> | </td>
<td width="5%"><a id="refresh" href="#" onClick="ClickRefresh(this.name);" class="DeviceRefresh" style="white-space:nowrap;color:#56b6f1;text-decoration:none;"><script>document.write(sipstatus['vspa_refresh']);</script></a></td>
<td width="90%"></td>
</tr>
<tr><td height="10px"></td>
<tr>
</table>


<table  id="siptable" width="94%" border="1" align="center" cellspacing="0" cellpadding="0" class="DevTable">
<form id="ConfigForm">
      <tr class="DevTableTitle">    
	  <script type="text/javascript">

			if (curLanguage == "english"){
			document.write('<td class="width_per5 align_center" BindText="vspa_seq"></td>');
			document.write('<td class="width_per8 align_center" BindText="vspa_linename"></td>');
			document.write('<td class="width_per12 align_center" BindText="vspa_telno"></td>');
			document.write('<td class="width_per8 align_center" BindText="vspa_assopots"></td>');
			document.write('<td class="width_per8 align_center" BindText="vspa_userstat"></td>');
			document.write('<td class="width_per8 align_center" BindText="vspa_callstat"></td>');
			document.write('<td class="width_per12 align_center" BindText="vspa_interfacestatu"></td>');
			document.write('<td class="width_per15" BindText ="vspa_errorstat"></td>');   
	
			 if (AllLine.length - 1 == 0)
            {
                var html = '';
				var tmpState = InterfaceState[0].X_HW_InterfaceState;
				
				if ( '' == tmpState )
				{
					tmpState = '----';
				}
				
                html += '<tr class="DevTableTitle">';
                html += '<td class="align_center">----</td>'                 
                       + '<td class="align_center">----</td>'
                       + '<td class="align_center">----</td>'
                       + '<td class="align_center">----</td>' 
                       + '<td class="align_center">----</td>'
					   + '<td class="align_center">----</td>'
					   + '<td class="align_center">' + htmlencode(tmpState) + '</td>'
					             + '<td class="align_center">----</td>'
                       + '</tr>';
                document.write(html);
            }
            else
            {
                for (i = 0; i < AllLine.length - 1; i++)
                {
                    var html = '';
                    var text;
                    html += '<tr class="DevTableList">';
					
                    html += '<td class="align_center">' + (i+1) + '</td>'     
					if (User[i].UserId == "")
					{
						html += '<td class="align_center">' + '--' + '</td>'
					}   
					else 
					{
						html += '<td class="align_center" style="word-break:break-all; overflow:hidden;">' + htmlencode(User[i].UserId) + '</td>'
					}  
					html += '<td class="align_center">' + '--' + '</td>'       
                          
                    html += '<td class="align_center">' + htmlencode(AllLine[i].PhyReferenceList)+ '</td>'
						   + '<td class="align_center">' + htmlencode(AllLine[i].Status) + '</td>'
                           + '<td class="align_center">' + htmlencode(AllLine[i].CallState) + '</td>'    
                           
                    if(0 == i)
                    {
					    if (InterfaceState[0].X_HW_InterfaceState == "")
						{
							 html += '<td class="align_center" rowspan='+(AllLine.length-1)+'>' + '--' + '</td>'  
						}
						else
						{
							html += '<td class="align_center" rowspan='+(AllLine.length-1)+'>' + htmlencode(InterfaceState[0].X_HW_InterfaceState) + '</td>'   
						}                                                    
                    } 
                    
							if ( AllLine[i].RegisterError == '-' )
							{
								html += '<td class="align_center">--</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_ONU_OFFLINE' )
							{
								if (true == var_singtel)
								{
									html += '<td class="align_center">'+ h248status['vspa_errorstate_onroffine'] + '</td>';
								}
								else
								{
									html += '<td class="align_center">'+ h248status['vspa_errorstate_onuoffine'] + '</td>';
								}
							}
							else if ( AllLine[i].RegisterError == 'ERROR_WAN_NOT_CONFIGURED' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_wannotconfigured'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_WAN_IP_NOT_OBTAINED' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_wannotobtained'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_CORENET_ADDRESS_INCORRECT' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_mgcincorrect'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_VOICESERVICE_DISABLED' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_voicedisabled'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_CONFIGURED' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_usernotconfigured'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_BOUND_TO_POTS' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_usernotboundport'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_POTS_DISABLED_BY_OLT' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_portdisabledOLT'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_USER_DISABLED' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_userdisable'] + '</td>';
							}
                            else if ( AllLine[i].RegisterError == 'ERROR_USER_CONFLICT' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_userconflict'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_regauthfails'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_regtimesout'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_mgcerrorresponse'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_UNKNOWN' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_unknownerror'] + '</td>';
							}
							else
							{
								html += '<td class="align_center">--</td>';
							}   								                            
                  
                    html += '</tr>';     
                    
                    document.write(html);
                }
            }
			
		}
		

		else{
			document.write('<td width="5%" BindText="vspa_seq"></td>');
			document.write('<td width="8%" BindText="vspa_linename"></td>');
			document.write('<td width="12%" BindText="vspa_telno"></td>');
			document.write('<td width="8%" BindText="vspa_assopots"></td>');
			document.write('<td width="8%" BindText="vspa_userstat"></td>');
			document.write('<td width="8%" BindText="vspa_callstat"></td>');
			document.write('<td width="8%" BindText="vspa_interfacestatu"></td>');
			document.write('<td width="18%" BindText ="vspa_errorstat"></td>');   

			if (AllLine.length - 1 == 0)
			{
				var html = '';
				html += '<tr class="DevTableTitle">';
				html += '<td class="align_center">----</td>'                 
					+ '<td class="align_center">----</td>'
					 + '<td class="align_center">----</td>'
					+ '<td class="align_center">----</td>'
					+ '<td class="align_center">----</td>' 
					+ '<td class="align_center">----</td>' 
					+ '<td class="align_center">' + GetInterfaceState() + '</td>'
					+ '<td class="align_center">----</td>' 
					+ '</tr>';
				document.write(html);
			}
			else
			{
				for (i = 0; i < AllLine.length - 1; i++)
				{
					var html = '';
					var text;
					
					document.write('<tr class=\"DevTableList\">');
					document.write('<td class=\"align_center\">' + (i+1) + '</td>');
					    
					if ( User[i].UserId == "")
					{		
						 document.write('<td class=\"align_center\">' + '--' + '</td>');
					}
					else
					{           
						document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(User[i].UserId) + '</td>'); 
					}
					
					document.write('<td class=\"align_center\">' + '--' + '</td>' + 
					'<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(AllLine[i].PhyReferenceList)+ '</td>');
					
					
					if ( AllLine[i].Status == 'Up' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_up'] + '</td>');
					}
					else if ( AllLine[i].Status == 'Initializing' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_ini'] + '</td>');
					}
					else if ( AllLine[i].Status == 'Registering' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_reg'] + '</td>');
					}
					else if ( AllLine[i].Status == 'Unregistering' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_unreg'] + '</td>');
					}
					else if ( AllLine[i].Status == 'Error' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_err'] + '</td>');
					}
					else if ( AllLine[i].Status == 'Testing' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_test'] + '</td>');
					}		
					else if ( AllLine[i].Status == 'Quiescent' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_quies'] + '</td>');
					}
					else if ( AllLine[i].Status == 'Disabled' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_state_disable'] + '</td>');
					}
					else
					{
						document.write('<td class=\"align_center\">' + '</td>');
					}
			
					if ( AllLine[i].CallState == 'Idle' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_idle'] + '</td>');
					}
					else if ( AllLine[i].CallState == 'Calling' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_call'] + '</td>');
					}
					else if ( AllLine[i].CallState == 'Ringing' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_ring'] + '</td>');
					}
					else if ( AllLine[i].CallState == 'Connecting' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_con'] + '</td>');
					}
					else if ( AllLine[i].CallState == 'InCall' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_incall'] + '</td>');
					}
					else if ( AllLine[i].CallState == 'Hold' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_hold'] + '</td>');
					}
					else if ( AllLine[i].CallState == 'Disconnecting' )
					{
						document.write('<td class=\"align_center\">' + h248status['vspa_calstate_discon'] + '</td>');
					}
					else
					{
						document.write('<td class=\"align_center\">' + '</td>');
					}
					
					if(0 == i)
					{	
						document.write('<td class=\"align_center\" rowspan='+(AllLine.length-1)+'>' + htmlencode(GetInterfaceState()) + '</td>');	
					} 
					
						  if ( AllLine[i].RegisterError == '-' )
							{
								
								document.write('<td class=\"align_center\">--</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_ONU_OFFLINE' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_onuoffine'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_WAN_NOT_CONFIGURED' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_wannotconfigured'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_WAN_IP_NOT_OBTAINED' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_wannotobtained'] + '</td>');
								
							}
							else if ( AllLine[i].RegisterError == 'ERROR_CORENET_ADDRESS_INCORRECT' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_mgcincorrect'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_VOICESERVICE_DISABLED' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_voicedisabled'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_CONFIGURED' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_usernotconfigured'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_BOUND_TO_POTS' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_usernotboundport'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_POTS_DISABLED_BY_OLT' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_portdisabledOLT'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_USER_DISABLED' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_userdisable'] + '</td>');
							}
                            else if ( AllLine[i].RegisterError == 'ERROR_USER_CONFLICT' )
							{
								html += '<td class="align_center">'+ h248status['vspa_errorstate_userconflict'] + '</td>';
							}
							else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_regauthfails'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_regtimesout'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_mgcerrorresponse'] + '</td>');
							}
							else if ( AllLine[i].RegisterError == 'ERROR_UNKNOWN' )
							{
								document.write('<td class=\"align_center\">'+ h248status['vspa_errorstate_unknownerror'] + '</td>');
							}
							else
							{
								document.write('<td class=\"align_center\">--</td>');
							}   								                            
					
					document.write("</tr>"); 
					document.write(html);
				}
			} 
		}
</script>
</tr>
 </table>

</form>

</td></tr>
</table>
</body>
</html>
