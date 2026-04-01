<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>

<title>VOIP Status</title>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipstatus);%>"></script>
<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';


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
	else if ((CfgMode.toUpperCase() == 'ANTEL')&&(curLoginUserType != "0"))
    {
        setDisplay('resetButton', 0);
    }
    else
    {
        setDisplay('resetButton',1);
    }
	
	if(CfgMode.toUpperCase().indexOf('PTVDF') >= 0)
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
	
	if ('DVODACOM2WIFI' == CfgMode.toUpperCase())
	{
		document.getElementById('refresh').style.color = "red";
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
	var dh = getHeight("SipTel");
	var dh1 = getHeight("siptable");
	var height = (dh > 0 ? dh : 0) + (dh1 > 0 ? dh1 : 0) + 24;
	window.parent.adjustParentHeight("ContectdevmngtPage", height);
}

</script>
</head>

<body onLoad="LoadFrame();" style="background-color:#EDF1F2;">
<table id="SipTel" class="DevNameTitle">
<tr><td width="5%">
<label id="devicetitle" name="devicetitle" class="DeviceTitle" style="white-space:nowrap;"><script>document.write(sipstatus['vspa_tel'])</script></label></td>
<td class="DeviceLine"> | </td>
<script>
    if(CfgMode.toUpperCase().indexOf('DTEDATA') >= 0){
        document.write('<td width="5%"><a id="refresh" href="#" onClick="ClickRefresh(this.name);" class="DeviceRefresh" style="white-space:nowrap;color:#6f2d91;text-decoration:none;">' + sipstatus['vspa_refresh'] + '</a></td>');
    } else {
        document.write('<td width="5%"><a id="refresh" href="#" onClick="ClickRefresh(this.name);" class="DeviceRefresh" style="white-space:nowrap;color:#56b6f1;text-decoration:none;">' + sipstatus['vspa_refresh'] + '</a></td>');
    }
</script>
<td width="90%"></td>
</tr>
<tr><td height="10px"></td>
<tr>
</table>

<table id="siptable"  width="94%" border="1" align="center" cellspacing="0" cellpadding="0" class="DevTable">
<form id="ConfigForm">
        <div>
            <tr class="DevTableTitle">
            <script type="text/javascript">
            
            document.write('<td class="width_per5" BindText="vspa_seq"></td>');
			if((CfgMode.toUpperCase().indexOf('PTVDF') < 0)&&(!((true == var_singtel)&&(curLoginUserType != "0"))))
			{
            document.write('<td class="width_per8" BindText="vspa_uri"></td>');
			}
            document.write('<td class="width_per12" BindText="vspa_username"></td>');
            document.write('<td class="width_per8" BindText ="vspa_assopots"></td>');
            document.write('<td class="width_per8" BindText ="vspa_userstat"></td>');
            document.write('<td class="width_per8" BindText ="vspa_callstat"></td>');
            document.write('<td class="width_per12" BindText ="vspa_errorstat"></td>');
            document.write('<td class="width_per10"  BindText ="vspa_regcodereason"></td>');        
            if (AllLine.length - 1 == 0)
            {
                var html = '';
                
                html += '<tr class="DevTableTitle">';
                html += '<td class="align_center">--</td>'
                       + '<td class="align_center">--</td>'                 
                       + '<td class="align_center">--</td>'
                       + '<td class="align_center">--</td>'
                       + '<td class="align_center">--</td>'  
                       + '<td class="align_center">--</td>'
                       + '<td class="align_center">--</td>' 
				if((CfgMode.toUpperCase().indexOf('PTVDF') < 0)&&(!((true == var_singtel)&&(curLoginUserType != "0"))))
				{
                    html += '<td class="align_center">--</td>'
				}					   
                html += '</tr>';     
                
                document.write(html);
            }
            else
            {
                for (i = 0; i < AllLine.length - 1; i++)
                {
                    var html = '';
                       
                    document.write('<tr class=\"DevTableList\">');
                    document.write('<td class=\"align_center\">' + (i+1) + '</td>');
					if((CfgMode.toUpperCase().indexOf('PTVDF') < 0)&&(!((true == var_singtel)&&(curLoginUserType != "0"))))
					{
                    if (AllLineURI[i].URI == "")
                    {    
                        document.write('<td class=\"align_center\">' + '--' + '</td>');
                    } 
                    else
                    {    
                        document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(AllLineURI[i].URI) + '</td>');
                    }  
                    }
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
                                document.write('<td class=\"align_center\">' + '--' + '</td>');
                            }
                            else
                            {    
                                document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(k3) + '</td>');
                            }
                         }
                         else
                         {
                             var Authpart = Auth[i].AuthUserName.split('@');
                             var k = Authpart[0];
                            if (k == "")
                            {    
                                document.write('<td class=\"align_center\">' + '--' + '</td>');
                            }
                            else
                            {    
                                document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(k) + '</td>');
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
                                document.write('<td class=\"align_center\">' + '--' + '</td>');
                            }
                            else
                            {    
                                document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(k3) + '</td>');
                            }
                         }
                         else
                         {
                             var UserId = User[i].UserId.split('@');
                             var k = UserId[0];
                            if (k == "")
                            {    
                                document.write('<td class=\"align_center\">' + '--' + '</td>');
                            }
                            else
                            {    
                                document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(k) + '</td>');
                            }
                         }
                    }        

                    if (AllLine[i].PhyReferenceList == "")
                    {    
                        document.write('<td class=\"align_center\">' + '--' + '</td>');
                    }
                    else
                    {    
                        document.write('<td class=\"align_center\" style=\"word-break:break-all; overflow:hidden;\">' + htmlencode(AllLine[i].PhyReferenceList) + '</td>');
                    }
                                              
                    if ( AllLine[i].Status == 'Up' )
                    {
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_succ'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Initializing' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_ini'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Registering' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_reg'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Unregistering' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_unreg'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Quiescent' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_qui'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Disabled' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_disa'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Error' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_err'] + '</td>');
                    }
                    else if ( AllLine[i].Status == 'Testing' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_status_test'] + '</td>');
                    }
                    else
                    {    
                        document.write('<td class=\"align_center\">' + '--' + '</td>');
                    }
                    
                    if ( AllLine[i].CallState == 'Idle' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_idle'] + '</td>');
                    }
                    else if ( AllLine[i].CallState == 'Calling' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_cal'] + '</td>');
                    }
                    else if ( AllLine[i].CallState == 'Ringing' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_ring'] + '</td>');
                    }
                    else if ( AllLine[i].CallState == 'Connecting' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_con'] + '</td>');
                    }
                    else if ( AllLine[i].CallState == 'InCall' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_incall'] + '</td>');
                    }
                    else if ( AllLine[i].CallState == 'Hold' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_hold'] + '</td>');
                    }
                    else if ( AllLine[i].CallState == 'Disconnecting' )
                    {    
                        document.write('<td class=\"align_center\">' + sipstatus['vspa_callstat_dis'] + '</td>');
                    }
                    else
                    {    
                        document.write('<td class=\"align_center\">' + '--' + '</td>');
                    }
                    
                       if ( AllLine[i].RegisterError == '-' )
                            {
                                
                                document.write('<td class=\"align_center\">--</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_ONU_OFFLINE' )
                            {
								if (true == var_singtel)
								{
									document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_onroffine'] + '</td>');
								}
								else
								{
									document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_onuoffine'] + '</td>');
								}
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_WAN_NOT_CONFIGURED' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_wannotconfigured'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_WAN_IP_NOT_OBTAINED' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_wannotobtained'] + '</td>');
                                
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_CORENET_ADDRESS_INCORRECT' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_mgcincorrect'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_VOICESERVICE_DISABLED' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_voicedisabled'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_CONFIGURED' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_usernotconfigured'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_BOUND_TO_POTS' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_usernotboundport'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_POTS_DISABLED_BY_OLT' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_portdisabledOLT'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_USER_DISABLED' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_userdisable'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_USER_CONFLICT' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_userconflict'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_regauthfails'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_regtimesout'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_mgcerrorresponse'] + '</td>');
                            }
                            else if ( AllLine[i].RegisterError == 'ERROR_UNKNOWN' )
                            {
                                document.write('<td class=\"align_center\">'+ sipstatus['vspa_errorstate_unknownerror'] + '</td>');
                            }
                            else
                            {
                                document.write('<td class=\"align_center\">--</td>');
                            }
							
							document.write('<td class="align_center">' + htmlencode(OutputCodeReason[i]) + '</td>');

                    document.write("</tr>");                   
                    document.write(html);
                }
            }
            </script>    
            </tr>
    </table>
    </div>

</form>
</td></tr>
</table>
</body>
</html>
