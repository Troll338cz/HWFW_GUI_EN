<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>DataStatus</title>
<script language="JavaScript" type="text/javascript">
function stOpticInfo(domain,transOpticPower,revOpticPower,voltage,temperature,bias,rfRxPower,rfOutputPower, VendorName, VendorSN, DateCode, TxWaveLength, RxWaveLength, MaxTxDistance, LosStatus)
{
    this.domain = domain;
    this.transOpticPower = transOpticPower;
    this.revOpticPower = revOpticPower;
    this.voltage = voltage;
    this.temperature = temperature;
    this.bias = bias;
    this.rfRxPower = rfRxPower;
    this.rfOutputPower = rfOutputPower;
    this.VendorName = VendorName;
    this.VendorSN = VendorSN;
    this.DateCode = DateCode;
    this.TxWaveLength = TxWaveLength;
    this.RxWaveLength = RxWaveLength;
    this.MaxTxDistance = MaxTxDistance;
    this.LosStatus = LosStatus;
}

function stOLTOpticInfo(domain,BudgetClass,TxPower,PONIdentifier)
{
    this.domain = domain;
    this.BudgetClass = BudgetClass;
    this.TxPower = TxPower;
    this.PONIdentifier = PONIdentifier;
}

var GUIDE_NULL = "--";
var OltOptics = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.OltOptic,BudgetClass|TxPower|PONIdentifier, stOLTOpticInfo);%>;
var OltOptic = OltOptics[0];
if(null == OltOptic)
{
	OltOptic = new stOLTOpticInfo('InternetGatewayDevice.X_HW_DEBUG.AMP.OltOptic', '--', '--', '');
}

var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var gponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT.State);%>';
var eponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT.State);%>';
var InformStatus =  '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.X_HW_InformStatus);%>';
var status = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptTxMode.TxMode);%>';
var opticStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptStaus.status);%>';
var opticPower = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.SMP.APM.ChipStatus.Optical);%>';
var IPOnlyFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
var ontXGMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.XG_AccessMode);%>';
var opticType = '<%HW_WEB_GetOpticType();%>';
var opticInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic,TxPower|RxPower|Voltage|Temperature|Bias|RfRxPower|RfOutputPower|VendorName|VendorSN|DateCode|TxWaveLength|RxWaveLength|MaxTxDistance|LosStatus, stOpticInfo);%>; 
var opticInfo = opticInfos[0];

function GetAccessMode()
{
	var accModes = new Array(["not initial", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_not_initial']], 
							 ["gpon", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_gpon']], 
							 ["epon", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_epon']], 
							 ["10g-gpon", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_10g_gpon']], 
							 ["Asymmetric 10g-epon", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_asymmetric_10g_epon']], 
							 ["Symmetric 10g-epon", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_symmetric_10g_epon']], 
							 ["ge", IT_VDF_opticinfo_language['amp_opticinfo_accessmode_ge']]);
	
	var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.XG_AccessMode);%>';

	var i=0;
	
	for( ; i<accModes.length; i++)
	{
		if(ontPonMode == accModes[i][0])
			return accModes[i][1];
	}
	
	return "--";
}

function GetLinkState()
{
	var State = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;

	if (State == 1 || State == "1")
	{
		return IT_VDF_opticinfo_language['amp_opticinfo_connected'];
	}
	else
	{
		return IT_VDF_opticinfo_language['amp_opticinfo_disconnected'];
	}
}

function GetLinkTime()
{
	var LinkTime = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.EPONLinkInfo.PONLinkTime);%>';
	var LinkDesc;
	
	var hh = parseInt(LinkTime/3600);
	var mm = parseInt((LinkTime%3600)/60);
	
	var hhStr = (hh <= 1) ? IT_VDF_opticinfo_language['amp_opticinfo_h'] : IT_VDF_opticinfo_language['amp_opticinfo_hs'];
	var mmStr = (mm <= 1) ? IT_VDF_opticinfo_language['amp_opticinfo_min'] : IT_VDF_opticinfo_language['amp_opticinfo_mins'];
	LinkDesc = parseInt(hh) + hhStr + parseInt(mm) + mmStr;
	
	if (GetLinkState() == IT_VDF_opticinfo_language['amp_opticinfo_disconnected'])
	{
		LinkDesc = GUIDE_NULL;
	}

	return LinkDesc;
}

function SetItmsInfoStatus()
{
	if( '0' == InformStatus )
	{
		document.write(IT_VDF_opticinfo_language['amp_opticinfo_registration_success']);
	} 
	else if( '1' == InformStatus )
	{
		document.write(IT_VDF_opticinfo_language['amp_opticinfo_unregistered']);
	} 
	else if( '2' == InformStatus || '3' == InformStatus )
	{
		document.write(IT_VDF_opticinfo_language['amp_opticinfo_registration_fail']);
	} 
	else
	{
		document.write(IT_VDF_opticinfo_language['amp_opticinfo_unregistered']);
	}	
}

function isValidAscii(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch < ' ' || ch > '~' )
        {
            return false;
        }
    }
    return true;
}

function DeleteAllZero(hexpasswd)
{
    var str;
    var len = hexpasswd.length ;
    var i = len/2;
 
    for (  i ; i >= 0 ; i-- )
    {   
        if((hexpasswd.substring(i*2 - 1, i*2 ) != '0')||(hexpasswd.substring(i*2 - 2, i*2 - 1) != '0'))   
        {                      
            str = hexpasswd.substring(0, i*2); 
            break;
        }
    }        
    
    return str; 
                    
}

function ChangeHextoAscii(hexpasswd)
{
    var str;  
    var str2;
    var len = 0;
    
    len = hexpasswd.length;
    
    if (0 != len%2)
    {
        hexpasswd += "0";
    }
    
    str2 = DeleteAllZero(hexpasswd); 

    str = str2.replace(/[a-f\d]{2}/ig, function(m){
    return String.fromCharCode(parseInt(m, 16));});
    
    return str;
}

function conversionblankAscii(val)
{
    var str='';
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch == ' ')
        {
            str+="&nbsp;";
        }
        else
        {
            str+= ch;    
        }
    }
    
    return str;
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
        
        if (IT_VDF_opticinfo_language[b.getAttribute("BindText")]) 
		{
            b.innerHTML = IT_VDF_opticinfo_language[b.getAttribute("BindText")];
		}
	}
	
	setDisplay('content', 1);
}

</script>

<style type="text/css">
.h3-content td,
.h3-content th {
  padding: 0px;
}

</style>
</head>
<body onLoad="LoadFrame();">
	<div id="content" style="display:none">
		<h1 style="font-family:'Arial';">
			<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_title']);</script></span>
		</h1>
		<h2><span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_explain']);</script></span></h2>
			
		<h3><span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_pon_info']);</script></span></h3>
		<div class="h3-content">
			<div class="row">
				<div class="left deviceStatus">
					<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_line_protocol']);</script></span>	
				</div>
				<div class="left deviceStatus">
					<span>
						<script>
							document.write(htmlencode(GetAccessMode()));
						</script>
					</span>			
				</div>
			</div>
		
			<div class="row">
				<div class="left line deviceStatus">
					<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_conn_status']);</script></span>			
				</div>
				<div class="left line deviceStatus">
					<span>
						<script>
							document.write(htmlencode(GetLinkState()));
						</script>
					</span>			
				</div>
			</div>

			<div class="row">
				<div class="left line deviceStatus">
					<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_duration']);</script></span>			
				</div>
				<div class="left line deviceStatus">
					<span>
						<script>
							document.write(htmlencode(GetLinkTime()));
						</script>
					</span>			
				</div>
			</div>
		</div>
		
		<h3><span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_registration']);</script></span></h3>	
		<div class="h3-content">
			<div class="row">
				<div class="left deviceStatus">
					<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path']);</script></span>			
				</div>
				<div class="left deviceStatus">
					<span>
					<script>
					if(opticInfo.RxPower == "--" || opticInfo.RxPower == "")
					{ 
						document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path_status1']);
					}
					else
					{
						if (ontPonMode.toUpperCase() == 'GPON')
						{
							if (gponStatus.toUpperCase() == 'O5')
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path_status2']);
							}
							else
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path_status3']);
							}
						}
						else if (ontPonMode.toUpperCase() == 'EPON')
						{
							if (eponStatus.toUpperCase() =="ONLINE" )
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path_status2']);
							}
							else
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path_status3']);
							}
						}
						else
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_optical_path_status3']);
						}
					}
					</script>
					</span>			
				</div>
			</div>

			<div class="row">
				<div class="left line deviceStatus">
					<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_acs']);</script></span>			
				</div>
				<div class="left line deviceStatus">
					<span>
					<script>
						SetItmsInfoStatus();
					</script>
					</span>			
				</div>
			</div>
		</div>
		
		<h3><span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_ontinfo']);</script></span></h3>	
		<div class="h3-content">
			<table id="optic_status_table"  class="table-three-columns">
				<tr> 
					<th>&nbsp;</th>
					<th><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_cur']);</script></th>
					<th id="ref_head"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_ref']);</script></th>
				</tr>
				<tr> 
					<td BindText='amp_opticinfo_txpower'></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{
							document.write(opticInfo.transOpticPower+' '+IT_VDF_opticinfo_language['amp_opticinfo_dBm']);
						}
						</script> 
					</td>
					<td id="ref_tx">
						<script language="javascript" type="text/javascript">
						if (ontXGMode == '10g-gpon')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref_10g']);
						}
						else if (ontXGMode == 'Asymmetric 10g-epon')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref_10eas']);
						}
						else if (ontXGMode == 'Symmetric 10g-epon')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref_10es']);
						}
						else if (ontXGMode == 'ge')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref_ge']);
						}
                        else if (ontXGMode == 'Symmetric 10g-gpon')
                        {
    	                   document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref_10es']);
                        }
						else
						{
							if ( ((ontPonMode == 'gpon') || (ontPonMode == 'GPON')) && (opticType == 6) )
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref_classc_plus_plus']);
							}
							else
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_txref']);		
							}
						}
						</script>
					</td>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxpower']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{
							document.write(opticInfo.revOpticPower+' '+IT_VDF_opticinfo_language['amp_opticinfo_dBm']);
						}
						</script> 
					</td>
					<td id="ref_rx">
						<script language="javascript" type="text/javascript">
						if ((ontPonMode == 'gpon' || ontPonMode == 'GPON'))
						{
							if (ontXGMode == 'gpon')
							{
								if (opticType == 2)
								{
									document.write(IT_VDF_opticinfo_language['amp_opticinfo_classc_plus_rxrefg']);
								}
								else if (opticType == 6)
								{
									document.write(IT_VDF_opticinfo_language['amp_opticinfo_classc_plus_plus_rxrefg']);
								}
								else
								{
									document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxrefg']);
								}
							}
					        else if (ontXGMode == 'Symmetric 10g-gpon')
					        {
					           document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxref_10gs']);
					        }
							else
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxref_10g']);
							}
						}
						else if ((ontPonMode == 'epon' || ontPonMode == 'EPON'))
						{
							if (ontXGMode == 'epon')
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxrefe']);
							}
							else
							{
								document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxref_10e']);
							}
						}
						else
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_rxref_ge']);
						}
						</script>
					</td>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_voltage']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{
							document.write(opticInfo.voltage+' '+IT_VDF_opticinfo_language['amp_opticinfo_mV']);
						}    
						</script> 
					</td>
					<td id="ref_vol"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_volref']);</script></td>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_current']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{
							document.write(opticInfo.bias +' '+IT_VDF_opticinfo_language['amp_opticinfo_mA']);
						}    
						</script> 
					</td>
					<td id="ref_cur">
						<script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_curref']);</script>
					</td>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_temp']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{	
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{            
							document.write(opticInfo.temperature+'&nbsp;'+IT_VDF_opticinfo_language['amp_opticinfo_temp_unit']);
						}
						</script> 
					</td>
					<td id="ref_temp"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_tempref']);</script></td>
				</tr>
			</table>
		</div>
		
		<h3><span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltinfo']);</script></span></h3>
		<div class="h3-content">
			<table id="optic_status_table"  class="table-three-columns">
				<tr> 
					<th>&nbsp;</th>
					<th><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_cur']);</script></th>
					<th id="ref_head"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_ref']);</script></th>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltpower']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
							document.write(OltOptic.BudgetClass);
						</script> 
					</td>
					<td id="ref_olt_optic_type">--</td>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_olttxpower']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
							 document.write(OltOptic.TxPower+' '+IT_VDF_opticinfo_language['amp_opticinfo_dBm']);
						</script> 
					</td>
					<td id="ref_olt_txpower">
						<script language="javascript" type="text/javascript">
						if(opticInfo != null && opticInfo.revOpticPower == '--')
						{
							document.write('--');
						}
						else if(OltOptic.BudgetClass.toUpperCase() == 'CLASS A')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltclass_a']);
						}
						else if(OltOptic.BudgetClass.toUpperCase() == 'CLASS B')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltclass_b']);
						}
						else if(OltOptic.BudgetClass.toUpperCase() == 'CLASS C')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltclass_c']);
						}
						else if(OltOptic.BudgetClass.toUpperCase() == 'CLASS B+')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltclass_bj']);
						}
						else if(OltOptic.BudgetClass.toUpperCase() == 'CLASS C+')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltclass_cj']);
						}
						else if(OltOptic.BudgetClass == 'N1')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_xgpon']);
						}
						else if(OltOptic.BudgetClass == 'N2a')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_xgpon']);
						}
						else if(OltOptic.BudgetClass == 'N2b')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_xgpon']);
						}
						else if(OltOptic.BudgetClass == 'E1')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_xgpon']);
						}
						else if(OltOptic.BudgetClass == 'E2a')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_xgpon']);
						}
						else if(OltOptic.BudgetClass == 'E2b')
						{
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_xgpon']);
						}
						else
						{
							document.write('--');
						}	
						</script>
					</td>
				</tr>
				<tr> 
					<td BindText='amp_opticinfo_oltponid'></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(OltOptic.PONIdentifier =='')
						{
							document.write('--');
						}
						else
						{
							if(isValidAscii(ChangeHextoAscii(OltOptic.PONIdentifier)) == true)
							{
								document.write(conversionblankAscii(ChangeHextoAscii(OltOptic.PONIdentifier))+"&nbsp;"+'('+'0x'+OltOptic.PONIdentifier+')');
							}
							else
							{
								document.write('('+'0x'+OltOptic.PONIdentifier+')');
							}
						}
						</script> 
					</td>
					<td id="ref_olt_portid">--</td>
				</tr>
			</table>
		</div>	
	</div>
</body>
</html>
