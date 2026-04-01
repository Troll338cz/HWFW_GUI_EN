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
<script language="JavaScript" type="text/javascript">

function stInterfaceState(Domain, X_HW_InterfaceState)
{
    this.Domain = Domain;
    this.X_HW_InterfaceState = X_HW_InterfaceState;
}

function stLine(Domain, EndPointID, Status, CallState,InterfaceState,ProvStatus)
{
    this.Domain = Domain;
	
//	this.PhyReferenceList = PhyReferenceList;
	this.EndPointID = EndPointID;
    this.Status = Status;
    this.CallState = CallState;
    this.InterfaceState = InterfaceState;
	this.ProvStatus = ProvStatus;
}

function stProvStatus(domain,ProvStatus)
{
	this.domain = domain;
	this.ProvStatus = ProvStatus;
}

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.ST_MGCP_Status.{i},EndPointID|Status|CallState|InterfaceState|ProvStatus,stLine);%>;

var User = new Array();

function stUser(Domain, UserId)
{
    this.Domain = Domain;
    this.UserId = UserId;
}
  
function setControl()
{
}

function LoadFrame()
{
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
}  

function ShowTab(PhyReferenceList, EndPointID, Status,CallState,InterfaceState,ProvStatus)
{
	this.PhyReferenceList = PhyReferenceList;
	this.EndPointID = EndPointID;
	this.Status = Status;
	this.CallState = CallState;
	this.InterfaceState = InterfaceState;
	this.ProvStatus = ProvStatus;
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
<script language="JavaScript" type="text/javascript">

HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(h248status, "v01"), GetDescFormArrayById(h248status, "v02"), false);
</script>

<div class="title_spread"></div> 

<div class="func_title"><SCRIPT>document.write(h248status['vspa_prov_status']);</SCRIPT></div>

<table width="50%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<tr> 
	<!--<td class="table_title width_per35" style="color: #000000;" BindText='vspa_prov_stat'></td>-->
	<td class="table_title width_per35" style="color: #000000;"><SCRIPT>document.write(h248status['vspa_prov_stat']);</SCRIPT></td>
	<td class="table_right" style="color: #000000;">
		<script language="JavaScript" type="text/javascript">
		
			if ( AllLine[0].ProvStatus == 0 )
			{
				document.write(h248status['vspa_prov_not_init']);;
			}
			else if ( AllLine[0].ProvStatus == 1 )
			{
				document.write(h248status['vspa_prov_pass']);;
			}
			else if ( AllLine[0].ProvStatus == 2 )
			{
				document.write(h248status['vspa_prov_in_progress']);;
			}
			else if ( AllLine[0].ProvStatus == 3 )
			{
				document.write(h248status['vspa_prov_config_file_fail']);;
			}
			else if ( AllLine[0].ProvStatus == 4 )
			{
				document.write(h248status['vspa_prov_pass_with_warning']);;
			}
			else if ( AllLine[0].ProvStatus == 5 )
			{
				document.write(h248status['vspa_prov_pass_incomplete_parse']);;
			}
			else if ( AllLine[0].ProvStatus == 6 )
			{
				document.write(h248status['vspa_prov_internal_failure']);;
			}
			else if ( AllLine[0].ProvStatus == 7 )
			{
				document.write(h248status['vspa_prov_other_failure']);;
			}
			else 
			{
				document.write(h248status['vspa_prov_unknown']);;
			}
		</script>
	</td> 
</tr> 
</table>

<div class="func_spread"></div>


<div class="title_spread"></div>
<script language="JavaScript" type="text/JavaScript">
var i = 0;

var ShowableFlag = 1;
var ShowButtonFlag = 0;
//var ColumnNum = 8;
var ColumnNum = 5;
var VoipArray = new Array();
var ConfiglistInfo = new Array(
new stTableTileInfo("vspa_assopots","align_center","PhyReferenceList",false),
new stTableTileInfo("vspa_endpointid","align_center","EndPointID",false),
new stTableTileInfo("vspa_userstat","align_center","Status",false),
new stTableTileInfo("vspa_callstat","align_center","CallState",false),
new stTableTileInfo("vspa_interfacestatus","align_center","InterfaceState",false),null);


if (AllLine.length - 1 == 0)
{

	var VoipShowTab = new ShowTab();
	
	VoipShowTab.PhyReferenceList = 1;
	VoipShowTab.EndPointID = "aaln/1";
	VoipShowTab.Status = h248status['vspa_prov_unknown'];
	VoipShowTab.CallState = h248status['vspa_prov_unknown'];
	VoipShowTab.InterfaceState = h248status['vspa_prov_unknown'];

}
else
{
	for (i = 0; i < 2; i++)
	{
		var VoipShowTab = new ShowTab();
		VoipShowTab.PhyReferenceList = i + 1;		
		VoipShowTab.EndPointID = AllLine[i].EndPointID;
		if ( AllLine[i].Status == 0 )
		{
			VoipShowTab.Status = h248status['vspa_state_reg'];
		}
		else if ( AllLine[i].Status == 1 )
		{
			VoipShowTab.Status = h248status['vspa_state_active'];
		}
		else if ( AllLine[i].Status == 2 )
		{
			VoipShowTab.Status = h248status['vspa_state_deactive'];
		}
		else
		{
			VoipShowTab.Status = h248status['vspa_prov_unknown'];
		}
		
		if ( AllLine[i].CallState == 0 )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_idle'];
		}
		else if ( AllLine[i].CallState == 1 )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_fault'];
		}
		else if ( AllLine[i].CallState == 2 )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_hold'];
		}
		else if ( AllLine[i].CallState == 3 )
		{
			VoipShowTab.CallState = h248status['vspa_calstate_ring'];
		}
		else
		{
			VoipShowTab.CallState = h248status['vspa_prov_unknown'];
		}
		
		if ( AllLine[i].InterfaceState == 0 )
		{
			VoipShowTab.InterfaceState = h248status['vspa_closed'];
		}
		else if ( AllLine[i].InterfaceState == 1 )
		{
			VoipShowTab.InterfaceState = h248status['vspa_closing'];
		}
		else if ( AllLine[i].InterfaceState == 2 )
		{
			VoipShowTab.InterfaceState = h248status['vspa_restarting'];
		}
		else if ( AllLine[i].InterfaceState == 3 )
		{
			VoipShowTab.InterfaceState = h248status['vspa_inservice'];
		}
		else
		{
			VoipShowTab.InterfaceState = h248status['vspa_prov_unknown'];
		}
		
	VoipArray.push(VoipShowTab);		
	}
}

VoipArray.push(null);

HWShowTableListByType(ShowableFlag, "tdVoipInfo", ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, h248status, null);

</script>

</tr>
 </table>
<!--
<div id="resetButton">

    <table width="100%" cellpadding="0" cellspacing="1" >       
       <tr>
          	<td  class="table_right align_left">
          			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<input name="btnReboot" id="btnReboot" type="hidden" class="CancleButtonCss filebuttonwidth_100px" value="Restart VoIP" onClick="Reboot();"/>
				<script type="text/javascript">
			  	document.getElementsByName('btnReboot')[0].value = h248status['vspa_restartvoip'];	
			   </script>
            </td>
        </tr>
    </table>
<table width="100%" height="5" cellpadding="0" cellspacing="0" class="" >  
<tr>
</tr>
</table>-->
</div>
	</form>

</td></tr>
</table>
</body>
</html>
