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
var InformStatus =  '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.X_HW_InformStatus);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
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
    <!-- 1 = Normal user , 0 = Supper user-->
    if (curUserType == 1) {
        document.getElementById("Olt_Info").style.display="none";
    }
    setDisplay('content', 1);
}

</script>


</head>
<body onLoad="LoadFrame();">
	<div id="content" style="display:none">
		<h1 style="font-family:'Arial';">
			<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_title2']);</script></span>
		</h1>
		
		<h3><span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_transinfo']);</script></span></h3>	
		<div class="h3-content">
			<table id="optic_status_table">
				<tr> 
					<th><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_ontinfo2']);</script></th>
					<th><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_cur']);</script></th>
					<th id="ref_head"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_ref']);</script></th>
				</tr>
				<tr> 
					<td BindText='amp_opticinfo_txpower' ></td>
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
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_catvrx']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{	
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{            
							document.write(opticInfo.rfRxPower+'&nbsp;'+IT_VDF_opticinfo_language['amp_opticinfo_dBm']);
						}
						</script> 
					</td>
					<td id="ref_temp"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_catvrxref']);</script></td>
				</tr>
				<tr> 
					<td><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_catvtx']);</script></td>
					<td> 
						<script language="javascript" type="text/javascript">
						if(opticInfo == null)
						{	
							document.write(IT_VDF_opticinfo_language['amp_opticinfo_unknown']);
						}
						else
						{            
							document.write(opticInfo.rfOutputPower+'&nbsp;'+IT_VDF_opticinfo_language['amp_opticinfo_dBm']);
						}
						</script> 
					</td>
					<td id="ref_temp"><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_catvtxref']);</script></td>
				</tr>
			</table>
		</div>
		<div id="Olt_Info">
		<h3><span><script> document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltinfo']);</script></span></h3>
		<div class="h3-content">
			<div class="row">
				<div class="left deviceStatus">
					<span><script>document.write(IT_VDF_opticinfo_language['amp_opticinfo_oltponid']);</script></span>	
				</div>
				<div class="left deviceStatus">
					<span>
						<script>
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
					</span>			
				</div>
			</div>
		</div>
		</div>
	</div>
</body>
</html>
