<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<title>LLDP</title>
<script language="JavaScript" type="text/javascript">
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var ethNum = <%GetLanPortNum();%>;
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

		b.innerHTML = amp_lldp_language[b.getAttribute("BindText")];
	}
	
	setControl(top.lldpIdx);
	document.getElementById("tab" + (top.lldpIdx+1)).style.backgroundColor = "#f6f6f6";
}

function stGlobalTable(domain,VoiceVlanEnable,VoiceVlan,VoiceCOS,OUIID_0,OUIID_1,OUIID_2,OUIID_3, OUIID_4, OUIID_5, OUIID_6,OUIID_7)
{
    this.domain           = domain;
    this.VoiceVlanEnable  = VoiceVlanEnable;
	this.VoiceVlan        = VoiceVlan;
	this.VoiceCOS         = VoiceCOS;
	this.OUIID_0          = OUIID_0;
	this.OUIID_1          = OUIID_1;
    this.OUIID_2          = OUIID_2;
	this.OUIID_3          = OUIID_3;
	this.OUIID_4          = OUIID_4;
	this.OUIID_5          = OUIID_5;
    this.OUIID_6          = OUIID_6;
	this.OUIID_7          = OUIID_7;
}
var GlobalTables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_LLDP.GlobalTable,VoiceVlanEnable|VoiceVlan|VoiceCOS|OUIID_0|OUIID_1|OUIID_2|OUIID_3|OUIID_4|OUIID_5|OUIID_6|OUIID_7,stGlobalTable);%>;
var GlobalTable = GlobalTables[0];

function stPortTable(domain,Enable,LLDPSendInterval,NetworkPolicySignalVlanID,NetworkPolicySignalCOS,NetworkPolicySignalDSCP,NetworkPolicySignalUntag,NetworkPolicyMediaVlanID,NetworkPolicyMediaCOS,NetworkPolicyMediaDSCP,NetworkPolicyMediaUntag,NetworkPolicyEnable,ExtendPowerViaMDI,
					RemoteChassisID,RemotePortID,RemoteTTL,RemotePortDescription,RemoteSystemName,RemoteSystemDescription,RemoteSystemCapabilities,RemoteManagementAddress,RemoteAutoNegSpt,RemoteAutoNegEnb,RemoteOperMau,RemoteMEDCapabilities,RemoteExtendedPowerViaMDI,RemoteHardwareRevision,RemoteFirmwareRevision,RemoteSoftwareRevision,RemoteSerialNumber,RemoteManufacturerName,RemoteModelName,RemoteAssetID,
					LLDPPacketSendNumber,LLDPPacketRcvNumber,LLDPPacketDroppedNumber)
{
    this.domain                    = domain;
    this.Enable                    = Enable;
	this.LLDPSendInterval          = LLDPSendInterval;
	this.NetworkPolicySignalVlanID = NetworkPolicySignalVlanID;
    this.NetworkPolicySignalCOS    = NetworkPolicySignalCOS;
	this.NetworkPolicySignalDSCP   = NetworkPolicySignalDSCP;
	this.NetworkPolicySignalUntag  = NetworkPolicySignalUntag;
	this.NetworkPolicyMediaVlanID  = NetworkPolicyMediaVlanID;
	this.NetworkPolicyMediaCOS     = NetworkPolicyMediaCOS;
	this.NetworkPolicyMediaDSCP    = NetworkPolicyMediaDSCP;
	this.NetworkPolicyMediaUntag   = NetworkPolicyMediaUntag;
	this.NetworkPolicyEnable       = NetworkPolicyEnable;
    this.ExtendPowerViaMDI         = ExtendPowerViaMDI;
	this.RemoteChassisID           = RemoteChassisID;
	this.RemotePortID              = RemotePortID;
    this.RemoteTTL                 = RemoteTTL;
	this.RemotePortDescription     = RemotePortDescription;
	this.RemoteSystemName          = RemoteSystemName;
	this.RemoteSystemDescription   = RemoteSystemDescription;
	this.RemoteSystemCapabilities  = RemoteSystemCapabilities;
    this.RemoteManagementAddress   = RemoteManagementAddress;
	this.RemoteAutoNegSpt          = RemoteAutoNegSpt;
	this.RemoteAutoNegEnb          = RemoteAutoNegEnb;
	this.RemoteOperMau             = RemoteOperMau;
	this.RemoteMEDCapabilities     = RemoteMEDCapabilities;
	this.RemoteExtendedPowerViaMDI = RemoteExtendedPowerViaMDI;
    this.RemoteHardwareRevision    = RemoteHardwareRevision;
	this.RemoteFirmwareRevision    = RemoteFirmwareRevision;
	this.RemoteSoftwareRevision    = RemoteSoftwareRevision;
	this.RemoteSerialNumber	       = RemoteSerialNumber;
	this.RemoteManufacturerName	   = RemoteManufacturerName;
	this.RemoteModelName	       = RemoteModelName;
	this.RemoteAssetID	           = RemoteAssetID;
	this.LLDPPacketSendNumber	   = LLDPPacketSendNumber;
	this.LLDPPacketRcvNumber	   = LLDPPacketRcvNumber;
	this.LLDPPacketDroppedNumber   = LLDPPacketDroppedNumber;
}

function stPortTable1(domain,LocalChassisID,LocalPortID,LocalTTL,LocalPortDescription,LocalSystemName,LocalSystemDescription,LocalSystemCapabilities,LocalManagementAddress,LocalAutoNegSpt,LocalAutoNegEnb,LocalOperMau,LocalMEDCapabilities,LocalExtendedPowerViaMDI,LocalHardwareRevision,LocalFirmwareRevision,LocalSoftwareRevision,LocalSerialNumber,LocalManufacturerName,LocalModelName,LocalAssetID)
{
    this.domain                    = domain;
	this.LocalChassisID 		   = LocalChassisID;
	this.LocalPortID 			   = LocalPortID;
	this.LocalTTL			       = LocalTTL;
	this.LocalPortDescription	   = LocalPortDescription;
	this.LocalSystemName		   = LocalSystemName;
	this.LocalSystemDescription    = LocalSystemDescription;
	this.LocalSystemCapabilities   = LocalSystemCapabilities;
	this.LocalManagementAddress    = LocalManagementAddress;
	this.LocalAutoNegSpt           = LocalAutoNegSpt;
	this.LocalAutoNegEnb    	   = LocalAutoNegEnb;
	this.LocalOperMau       	   = LocalOperMau;
	this.LocalMEDCapabilities	   = LocalMEDCapabilities;
	this.LocalExtendedPowerViaMDI  = LocalExtendedPowerViaMDI;
	this.LocalHardwareRevision     = LocalHardwareRevision;
	this.LocalFirmwareRevision     = LocalFirmwareRevision;
	this.LocalSoftwareRevision     = LocalSoftwareRevision;
	this.LocalSerialNumber		   = LocalSerialNumber;
	this.LocalManufacturerName     = LocalManufacturerName;
	this.LocalModelName		       = LocalModelName;
	this.LocalAssetID			   = LocalAssetID;
}

var PortTable = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_LLDP.PortTable.{i},Enable|LLDPSendInterval|NetworkPolicySignalVlanID|NetworkPolicySignalCOS|NetworkPolicySignalDSCP|NetworkPolicySignalUntag|NetworkPolicyMediaVlanID|NetworkPolicyMediaCOS|NetworkPolicyMediaDSCP|NetworkPolicyMediaUntag|NetworkPolicyEnable|ExtendPowerViaMDI|RemoteChassisID|RemotePortID|RemoteTTL|RemotePortDescription|RemoteSystemName|RemoteSystemDescription|RemoteSystemCapabilities|RemoteManagementAddress|RemoteAutoNegSpt|RemoteAutoNegEnb|RemoteOperMau|RemoteMEDCapabilities|RemoteExtendedPowerViaMDI|RemoteHardwareRevision|RemoteFirmwareRevision|RemoteSoftwareRevision|RemoteSerialNumber|RemoteManufacturerName|RemoteModelName|RemoteAssetID|LLDPPacketSendNumber|LLDPPacketRcvNumber|LLDPPacketDroppedNumber,stPortTable);%>;
var PortTable1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_LLDP.PortTable.{i},LocalChassisID|LocalPortID|LocalTTL|LocalPortDescription|LocalSystemName|LocalSystemDescription|LocalSystemCapabilities|LocalManagementAddress|LocalAutoNegSpt|LocalAutoNegEnb|LocalOperMau|LocalMEDCapabilities|LocalExtendedPowerViaMDI|LocalHardwareRevision|LocalFirmwareRevision|LocalSoftwareRevision|LocalSerialNumber|LocalManufacturerName|LocalModelName|LocalAssetID,stPortTable1);%>;

function Submit(type)
{
    if(type == 1)
	{
		if (CheckForm1() == true)
		{
			var Form = new webSubmitForm();
			GlobalTableAddSubmitParam(Form,type);
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
			DisableRepeatSubmit();
		}
	}
	else if(type == 2)
	{
		if (CheckForm2() == true)
		{
			var Form = new webSubmitForm();
			PortTableAddSubmitParam(Form,type);
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
			DisableRepeatSubmit();
		}
	}
}
						  
function GlobalTableAddSubmitParam(Form,type)
{	
	var url;
	
	Form.addParameter('x.VoiceVlanEnable', getCheckVal("amp_lldp_voice_vlan_enable")); 
	Form.addParameter('x.VoiceVlan', getElById("amp_lldp_vlanid").value);
	Form.addParameter('x.VoiceCOS', getElById("amp_lldp_cos").value);
	Form.addParameter('x.OUIID_0', getElById("oui_id1").value);
	Form.addParameter('x.OUIID_1', getElById("oui_id2").value);
	Form.addParameter('x.OUIID_2', getElById("oui_id3").value);
	Form.addParameter('x.OUIID_3', getElById("oui_id4").value);
	Form.addParameter('x.OUIID_4', getElById("oui_id5").value);
	Form.addParameter('x.OUIID_5', getElById("oui_id6").value);
	Form.addParameter('x.OUIID_6', getElById("oui_id7").value);
	Form.addParameter('x.OUIID_7', getElById("oui_id8").value);

	url = 'set.cgi?x=InternetGatewayDevice.X_HW_LLDP.GlobalTable' + '&RequestFile=html/bbsp/lldp/lldp.asp';
				
	Form.setAction(url);
}

function PortTableAddSubmitParam(Form,type)
{
	var url;
    var i = top.lldpIdx;
	
	Form.addParameter('x.Enable', getCheckVal("amp_lldp_enable"));
	Form.addParameter('x.LLDPSendInterval', getElById("amp_lldp_tx_interval").value);  
	
	Form.addParameter('x.NetworkPolicySignalVlanID', getElById("network_policy_signal_vlanid").value);
	Form.addParameter('x.NetworkPolicySignalCOS', getElById("network_policy_signal_cos").value);
	Form.addParameter('x.NetworkPolicySignalDSCP', getElById("network_policy_signal_dscp").value);
	Form.addParameter('x.NetworkPolicySignalUntag', getCheckVal("network_policy_signal_untagged"));
	
	Form.addParameter('x.NetworkPolicyMediaVlanID', getElById("network_policy_media_vlanid").value);
	Form.addParameter('x.NetworkPolicyMediaCOS', getElById("network_policy_media_cos").value);
	Form.addParameter('x.NetworkPolicyMediaDSCP', getElById("network_policy_media_dscp").value);
	Form.addParameter('x.NetworkPolicyMediaUntag', getCheckVal("network_policy_media_untagged"));
	
	Form.addParameter('x.NetworkPolicyEnable', getCheckVal("amp_lldp_network_policy_enable"));
	Form.addParameter('x.ExtendPowerViaMDI', getCheckVal("amp_lldp_power_via_mdi_enable"));
	
	url = 'set.cgi?x=InternetGatewayDevice.X_HW_LLDP.PortTable.' + i + '&RequestFile=html/bbsp/lldp/lldp.asp';
	Form.setAction(url);
}

function CheckForm1()
{
	var vlanid = getElById("amp_lldp_vlanid").value;
	var cos = getElById("amp_lldp_cos").value;
	var oui_id1 = getElById("oui_id1").value;
	var oui_id2 = getElById("oui_id2").value;
	var oui_id3 = getElById("oui_id3").value;
	var oui_id4 = getElById("oui_id4").value;
	var oui_id5 = getElById("oui_id5").value;
	var oui_id6 = getElById("oui_id6").value;
	var oui_id7 = getElById("oui_id7").value;
	var oui_id8 = getElById("oui_id8").value;

	if (!isNum(vlanid) || !(parseInt(vlanid,10) >= 0 && parseInt(vlanid,10) <= 4094))
	{
		AlertEx(amp_lldp_language['amp_lldp_vlanid']+vlanid+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(cos) || !(parseInt(cos,10) >= 0 && parseInt(cos,10) <= 7))
	{
		AlertEx(amp_lldp_language['amp_lldp_cos']+cos+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	MacCheckForm(oui_id1);
	MacCheckForm(oui_id2);
	MacCheckForm(oui_id3);
	MacCheckForm(oui_id4);
	MacCheckForm(oui_id5);
	MacCheckForm(oui_id6);
	MacCheckForm(oui_id7);
	MacCheckForm(oui_id8);
    return true;
}

function CheckForm2()
{
    var txInterval = getElById("amp_lldp_tx_interval").value;
	
	var vlanidSignal = getElById("network_policy_signal_vlanid").value;
	var cosSignal = getElById("network_policy_signal_cos").value;
	var dscpSignal = getElById("network_policy_signal_dscp").value;
	
	var vlanidMedia = getElById("network_policy_media_vlanid").value; 
	var cosMedia = getElById("network_policy_media_cos").value;
	var dscpMedia = getElById("network_policy_media_dscp").value;
	
	if (!isNum(txInterval) || !(parseInt(txInterval,10) >= 1 && parseInt(txInterval,10) <= 65535))
	{
		AlertEx(amp_lldp_language['amp_lldp_tx_interval']+txInterval+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(vlanidSignal) || !(parseInt(vlanidSignal,10) >= 0 && parseInt(vlanidSignal,10) <= 4094))
	{
		AlertEx(amp_lldp_language['amp_lldp_vlanid']+vlanidSignal+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(cosSignal) || !(parseInt(cosSignal,10) >= 0 && parseInt(cosSignal,10) <= 7))
	{
		AlertEx(amp_lldp_language['amp_lldp_cos']+cosSignal+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(dscpSignal) || !(parseInt(dscpSignal,10) >= 0 && parseInt(dscpSignal,10) <= 63))
	{
		AlertEx(amp_lldp_language['amp_lldp_dscp']+dscpSignal+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(vlanidMedia) || !(parseInt(vlanidMedia,10) >= 0 && parseInt(vlanidMedia,10) <= 4094))
	{
		AlertEx(amp_lldp_language['amp_lldp_vlanid']+vlanidMedia+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(cosMedia) || !(parseInt(cosMedia,10) >= 0 && parseInt(cosMedia,10) <= 7))
	{
		AlertEx(amp_lldp_language['amp_lldp_cos']+cosMedia+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
	if (!isNum(dscpMedia) || !(parseInt(dscpMedia,10) >= 0 && parseInt(dscpMedia,10) <= 63))
	{
		AlertEx(amp_lldp_language['amp_lldp_dscp']+dscpMedia+amp_lldp_language['amp_lldp_invalid']);
		return false;				
	}
	
    return true;
}

function MacCheckForm(macAddress)
{

	tempmacAddress = macAddress.split("/");
	
    if (tempmacAddress[0] != '' && isValidMacAddress1(tempmacAddress[0]) == false ) 
    {
        AlertEx(amp_lldp_language['amp_lldp_themac'] + tempmacAddress[0] + amp_lldp_language['amp_lldp_macisinvalid']);
        return false;
    }
	
    return true;
}

var lldpTabN = 0;
function switchTab(TableN)
{ 	
    for (var i = 1; i <= ethNum +1 ; i++)
    {	
        if ("tab" + i == TableN.id) 
        {
            document.getElementById(TableN.id).style.backgroundColor = "#f6f6f6";
			lldpTabN = i - 1;
			top.lldpIdx = i - 1;
        }
        else
        {
            document.getElementById("tab" + i).style.backgroundColor = "";
        }
    }

    setControl(lldpTabN);
}

function lldpEnable()
{
    if(getCheckVal("amp_lldp_enable") == 1) 
    {
		setDisable('amp_lldp_network_policy_enable', 0);
		setDisable('amp_lldp_power_via_mdi_enable', 0);
		networkPolicyEnable();
	}
	else
	{
	    lldp(1);
	}
}

function networkPolicyEnable()
{
	if(getCheckVal("amp_lldp_network_policy_enable")) 
	{
		setDisable('network_policy_signal_untagged', 0);
		setDisable('network_policy_media_untagged', 0);
		setDisable('network_policy_signal_dscp', 0);
		setDisable('network_policy_media_dscp', 0);
		signalUntaggedEnable();
		meidialUntaggedEnable();
	}
	else
	{
	    networkPolicy(1);
	}
}

function signalUntaggedEnable()
{	
	var i = top.lldpIdx;
	if (PortTable[i-1].NetworkPolicySignalUntag == 1) {
		disableSignalTag(1);
	} else {
		disableSignalTag(0);
	}
}
function signalUntaggedChange()
{
	if(getCheckVal("network_policy_signal_untagged"))
	{
	    disableSignalTag(1);
	}
	else
	{
	    disableSignalTag(0);
	}
}

function meidialUntaggedEnable()
{
    var i = top.lldpIdx;
	if (PortTable[i-1].NetworkPolicyMediaUntag == 1) {
		disablemeidiaTag(1);
	} else {
		disablemeidiaTag(0);
	}
}

function meidialUntaggedChange()
{
	if(getCheckVal("network_policy_media_untagged"))
	{
		disablemeidiaTag(1);
	}
	else
	{
		disablemeidiaTag(0);
	}
}

function lldp(flag)
{
	setDisable('amp_lldp_network_policy_enable', flag);
	setDisable('network_policy_signal_vlanid', flag);
	setDisable('network_policy_signal_cos', flag);
	setDisable('network_policy_signal_dscp', flag);
	setDisable('network_policy_signal_untagged', flag);
	setDisable('network_policy_media_vlanid', flag);
	setDisable('network_policy_media_cos', flag);
	setDisable('network_policy_media_dscp', flag);
	setDisable('network_policy_media_untagged', flag);
	setDisable('amp_lldp_power_via_mdi_enable', flag);
}

function networkPolicy(flag)
{
	setDisable('network_policy_signal_vlanid', flag);
	setDisable('network_policy_signal_cos', flag);
	setDisable('network_policy_signal_dscp', flag);
	setDisable('network_policy_signal_untagged', flag);
	setDisable('network_policy_media_vlanid', flag);
	setDisable('network_policy_media_cos', flag);
	setDisable('network_policy_media_dscp', flag);
	setDisable('network_policy_media_untagged', flag);
}

function disableSignalTag(flag)
{
	setDisable('network_policy_signal_vlanid', flag);
	setDisable('network_policy_signal_cos', flag);
}
function disablemeidiaTag(flag)
{
	setDisable('network_policy_media_vlanid', flag);
	setDisable('network_policy_media_cos', flag);
}
	
function displaySys(flag)
{
	setDisplay('SystemConfig', flag);
	
	setCheck('amp_lldp_voice_vlan_enable', GlobalTable.VoiceVlanEnable);
	setText('amp_lldp_vlanid', GlobalTable.VoiceVlan);
	setText('amp_lldp_cos', GlobalTable.VoiceCOS);
	setText('oui_id1', GlobalTable.OUIID_0);
	setText('oui_id2', GlobalTable.OUIID_1);
	setText('oui_id3', GlobalTable.OUIID_2);
	setText('oui_id4', GlobalTable.OUIID_3);
	setText('oui_id5', GlobalTable.OUIID_4);
	setText('oui_id6', GlobalTable.OUIID_5);
	setText('oui_id7', GlobalTable.OUIID_6);
	setText('oui_id8', GlobalTable.OUIID_7);
}

function displayPort(flag, portid)
{
    var i = portid;
    
	setDisplay('PortConfig', flag);
	
	setCheck('amp_lldp_enable',PortTable[i-1].Enable);
	if(PortTable[i-1].Enable == 1) 
	{
		lldp(0);
		
		if(PortTable[i-1].NetworkPolicyEnable == 1) 
		{
			networkPolicy(0);
			
			if(PortTable[i-1].NetworkPolicySignalUntag == 1) 
			{
				disableSignalTag(1);
			}
			else
			{
				disableSignalTag(0);
			}
			
			if(PortTable[i-1].NetworkPolicyMediaUntag == 1) 
			{
				disablemeidiaTag(1);
			}
			else
			{
				disablemeidiaTag(0);
			}
		}
		else
		{
			networkPolicy(1);
		}
	}
	else
	{
	    lldp(1);
	}

	setText('amp_lldp_tx_interval',PortTable[i-1].LLDPSendInterval);
	setCheck('amp_lldp_network_policy_enable', PortTable[i-1].NetworkPolicyEnable);
	
	setText('network_policy_signal_vlanid', PortTable[i-1].NetworkPolicySignalVlanID); 
	setText('network_policy_signal_cos', PortTable[i-1].NetworkPolicySignalCOS);
	setText('network_policy_signal_dscp', PortTable[i-1].NetworkPolicySignalDSCP);
	setCheck('network_policy_signal_untagged', PortTable[i-1].NetworkPolicySignalUntag);
	setText('network_policy_media_vlanid', PortTable[i-1].NetworkPolicyMediaVlanID);      
	setText('network_policy_media_cos', PortTable[i-1].NetworkPolicyMediaCOS);
	setText('network_policy_media_dscp', PortTable[i-1].NetworkPolicyMediaDSCP);
	setCheck('network_policy_media_untagged', PortTable[i-1].NetworkPolicyMediaUntag);
	setCheck('amp_lldp_power_via_mdi_enable', PortTable[i-1].ExtendPowerViaMDI);

	document.getElementById("RemoteChassisID").innerText = PortTable[i-1].RemoteChassisID;
	document.getElementById("RemotePortID").innerText = PortTable[i-1].RemotePortID;
	document.getElementById("RemoteTTL").innerText = PortTable[i-1].RemoteTTL;
	document.getElementById("RemotePortDescription").innerText = PortTable[i-1].RemotePortDescription;
	document.getElementById("RemoteSystemName").innerText = PortTable[i-1].RemoteSystemName;
	document.getElementById("RemoteSystemDescription").innerText = PortTable[i-1].RemoteSystemDescription;
	document.getElementById("RemoteSystemCapabilities").innerText = PortTable[i-1].RemoteSystemCapabilities;
	document.getElementById("RemoteManagementAddress").innerText = PortTable[i-1].RemoteManagementAddress;
	document.getElementById("RemoteAutoNegSpt").innerText = PortTable[i-1].RemoteAutoNegSpt;
	document.getElementById("RemoteAutoNegEnb").innerText = PortTable[i-1].RemoteAutoNegEnb;
	document.getElementById("RemoteOperMau").innerText = PortTable[i-1].RemoteOperMau;
	document.getElementById('RemoteMEDCapabilities').innerText = PortTable[i-1].RemoteMEDCapabilities;
	document.getElementById('RemoteExtendedPowerViaMDI').innerText = PortTable[i-1].RemoteExtendedPowerViaMDI;
	document.getElementById('RemoteHardwareRevision').innerText = PortTable[i-1].RemoteHardwareRevision;
	document.getElementById('RemoteFirmwareRevision').innerText = PortTable[i-1].RemoteFirmwareRevision;
	document.getElementById('RemoteSoftwareRevision').innerText = PortTable[i-1].RemoteSoftwareRevision;
	document.getElementById('RemoteSerialNumber').innerText = PortTable[i-1].RemoteSerialNumber;
	document.getElementById('RemoteManufacturerName').innerText = PortTable[i-1].RemoteManufacturerName;  
	document.getElementById('RemoteModelName').innerText = PortTable[i-1].RemoteModelName;
	document.getElementById('RemoteAssetID').innerText = PortTable[i-1].RemoteAssetID;
	
	document.getElementById("LocalChassisID").innerText = PortTable1[i-1].LocalChassisID;
	document.getElementById("LocalPortID").innerText = PortTable1[i-1].LocalPortID;
	document.getElementById("LocalTTL").innerText = PortTable1[i-1].LocalTTL;
	document.getElementById("LocalPortDescription").innerText = PortTable1[i-1].LocalPortDescription;
	document.getElementById("LocalSystemName").innerText = PortTable1[i-1].LocalSystemName;
	document.getElementById("LocalSystemDescription").innerText = PortTable1[i-1].LocalSystemDescription;
	document.getElementById("LocalSystemCapabilities").innerText = PortTable1[i-1].LocalSystemCapabilities;
	document.getElementById("LocalManagementAddress").innerText = PortTable1[i-1].LocalManagementAddress;
	document.getElementById("LocalAutoNegSpt").innerText = PortTable1[i-1].LocalAutoNegSpt;
	document.getElementById("LocalAutoNegEnb").innerText = PortTable1[i-1].LocalAutoNegEnb;
	document.getElementById("LocalOperMau").innerText = PortTable1[i-1].LocalOperMau;
	document.getElementById('LocalMEDCapabilities').innerText = PortTable1[i-1].LocalMEDCapabilities;
	document.getElementById('LocalExtendedPowerViaMDI').innerText = PortTable1[i-1].LocalExtendedPowerViaMDI;
	document.getElementById('LocalHardwareRevision').innerText = PortTable1[i-1].LocalHardwareRevision;
	document.getElementById('LocalFirmwareRevision').innerText = PortTable1[i-1].LocalFirmwareRevision;
	document.getElementById('LocalSoftwareRevision').innerText = PortTable1[i-1].LocalSoftwareRevision;
	document.getElementById('LocalSerialNumber').innerText = PortTable1[i-1].LocalSerialNumber;
	document.getElementById('LocalManufacturerName').innerText = PortTable1[i-1].LocalManufacturerName;  
	document.getElementById('LocalModelName').innerText = PortTable1[i-1].LocalModelName;
	document.getElementById('LocalAssetID').innerText = PortTable1[i-1].LocalAssetID;

	document.getElementById('amp_lldp_tx_packages').innerText = PortTable[i-1].LLDPPacketSendNumber;
	document.getElementById('amp_lldp_rx_packages').innerText = PortTable[i-1].LLDPPacketRcvNumber;
	document.getElementById('amp_lldp_drop_packages').innerText = PortTable[i-1].LLDPPacketDroppedNumber;
}

function setControl(tabN)
{
    if (0 == tabN)
    {
        displaySys(1);
		displayPort(0, 1);
    }
    else
    {
        displaySys(0);
		displayPort(1, tabN);
    }
}

function CancelConfig()
{
	LoadFrame();
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
<div id="ConfigForm"> 
<table width="100%" class="tabal_bg">
  <tr class="head_title">
    <table width="100%" class="tabal_bg">
      <tr class="head_title">
		<script>
		if (ethNum == 4) {
			document.write('<td id="tab1" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_voice_vlan'] + '</td>');
			document.write('<td id="tab2" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth1_config'] + '</td>');
			document.write('<td id="tab3" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth2_config'] + '</td>');
			document.write('<td id="tab4" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth3_config'] + '</td>');
			document.write('<td id="tab5" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth4_config'] + '</td>');
		} else if (ethNum == 5) {
			document.write('<td id="tab1" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_voice_vlan'] + '</td>');
			document.write('<td id="tab2" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth1_config'] + '</td>');
			document.write('<td id="tab3" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth2_config'] + '</td>');
			document.write('<td id="tab4" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth3_config'] + '</td>');
			document.write('<td id="tab5" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth4_config'] + '</td>');
			document.write('<td id="tab6" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth5_config'] + '</td>')		
		} else {
			document.write('<td id="tab1" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_voice_vlan'] + '</td>');
			document.write('<td id="tab2" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth1_config'] + '</td>');
			document.write('<td id="tab3" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth2_config'] + '</td>');
			document.write('<td id="tab4" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth3_config'] + '</td>');
			document.write('<td id="tab5" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth4_config'] + '</td>');
			document.write('<td id="tab6" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth5_config'] + '</td>');
			document.write('<td id="tab7" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth6_config'] + '</td>');
			document.write('<td id="tab8" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth7_config'] + '</td>');
			document.write('<td id="tab9" onclick="switchTab(this)" width="11%">' + amp_lldp_language['amp_lldp_eth8_config'] + '</td>');			
		}
		</script>
      </tr>
    </table>
  </tr>
</table>

<table width="100%" height="10" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
</table> 
<div id="SystemConfig">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_lldp_system_config_title' class="PageTitle_content"></td>
    </tr>                  
</table>
<div class="title_spread"></div>
<table id="eth_status_table" width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
	<tr class="table_title table_border">
        <td colspan="1" rowspan="11" class="table_title table_border" BindText='amp_lldp_voice_vlan'></td>
		<td class="table_title table_border" BindText='amp_lldp_voice_vlan_enable'></td>
		<td class="table_right table_border"><input id='amp_lldp_voice_vlan_enable' type='checkbox' name='amp_lldp_voice_vlan_enable'></td> 
	</tr> 
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_vlanid'></td>
		<td class="table_right table_border"><input id='amp_lldp_vlanid' type='text' name='amp_lldp_vlanid' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_vlanidmh']);</script></span></td>
	</tr> 
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_cos'></td>
		<td class="table_right table_border"><input id='amp_lldp_cos' type='text' name='amp_lldp_cos' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_cosmh']);</script></span></td>
	</tr>

	<tr class="table_title table_border">
        <td colspan="1" rowspan="8" class="table_title table_border" BindText='amp_lldp_oui_id'></td>
		<td class="table_right table_border"> <input id='oui_id1' type='text' name='oui_id1' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td>
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id2' type='text' name='oui_id2' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td> 
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id3' type='text' name='oui_id3' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td>
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id4' type='text' name='oui_id4' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td> 
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id5' type='text' name='oui_id5' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td> 
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id6' type='text' name='oui_id6' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td> 
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id7' type='text' name='oui_id7' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td> 
	</tr>
	<tr class="table_right table_border">
		<td class="table_right table_border"> <input id='oui_id8' type='text' name='oui_id8' maxlength='256'  style="width:200px"><span class="gray"><script>document.write(amp_lldp_language['amp_lldp_oui_des']);</script></span></td> 
	</tr>
</table>
<table cellpadding="0" cellspacing="1" width="100%" class="table_button"> 
    <tr> 
      <td class="width_per25" ></td> 
      <td class="table_submit">
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	  	<button id="btnApply1" name="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(1);"><script>document.write(amp_lldp_language['amp_lldp_app']);</script></button> 
        <button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(amp_lldp_language['amp_lldp_cancel']);</script></button> 
	</td> 
    </tr> 
</table>
</div>
<div id="PortConfig">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_lldp_port_config_title' class="PageTitle_content"></td>
    </tr>                  
</table>  
<div class="title_spread"></div>
<table id="eth_status_table" width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr class="table_title table_border">
        <td colspan="2" rowspan="1" class="table_title table_border" BindText='amp_lldp_tx_interval'></td> 
        <td class="table_right table_border"> <input id='amp_lldp_tx_interval' type='text' name='amp_lldp_tx_interval' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_tx_intervalmh']);</script></span></td> 
	</tr>
	<tr class="table_title table_border">
        <td colspan="2" rowspan="1" class="table_title table_border" BindText='amp_lldp_enable'></td>
        <td class="table_right table_border"> <input id='amp_lldp_enable' type='checkbox' name='amp_lldp_enable' onclick="lldpEnable();"></span></td> 
	</tr>
	<tr class="table_title table_border">
        <td colspan="2" rowspan="1" class="table_title table_border" BindText='amp_lldp_network_policy_enable'></td>
		<td class="table_right table_border"><input id='amp_lldp_network_policy_enable' type='checkbox' name='amp_lldp_network_policy_enable' onclick="networkPolicyEnable();"></td> 
	</tr>
	<tr class="table_title table_border">
        <td colspan="1" rowspan="4" class="table_title table_border" BindText='amp_lldp_network_policy_signal'></td>
		<td class="table_title table_border" BindText='amp_lldp_untagged'></td>
		<td class="table_right table_border"><input id='network_policy_signal_untagged' type='checkbox' name='network_policy_signal_untagged' onclick="signalUntaggedChange();"></td>
	</tr>
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_vlanid'></td>
		<td class="table_right table_border"><input id='network_policy_signal_vlanid' type='text' name='network_policy_signal_vlanid' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_vlanidmh']);</script></span></td>
	</tr> 
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_cos'></td>
		<td class="table_right table_border"><input id='network_policy_signal_cos' type='text' name='network_policy_signal_cos' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_cosmh']);</script></span></td>
	</tr> 
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_dscp'></td> 
		<td class="table_right table_border"><input id='network_policy_signal_dscp' type='text' name='network_policy_signal_dscp' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_dscpmh']);</script></span></td>
	</tr>
	<tr class="table_title table_border">
        <td colspan="1" rowspan="4" class="table_title table_border" BindText='amp_lldp_network_policy_media'></td>
		<td class="table_title table_border" BindText='amp_lldp_untagged'></td>
		<td class="table_right table_border"><input id='network_policy_media_untagged' type='checkbox' name='network_policy_media_untagged' onclick="meidialUntaggedChange();"></td>
	</tr>
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_vlanid'></td>
		<td class="table_right table_border"><input id='network_policy_media_vlanid' type='text' name='network_policy_media_vlanid' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_vlanidmh']);</script></span></td>
	</tr> 
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_cos'></td>
		<td class="table_right table_border"><input id='network_policy_media_cos' type='text' name='network_policy_media_cos' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_cosmh']);</script></span></td>
	</tr> 
	<tr class="table_title table_border">
		<td class="table_title table_border" BindText='amp_lldp_dscp'></td> 
		<td class="table_right table_border"><input id='network_policy_media_dscp' type='text' name='network_policy_media_dscp' maxlength='256'  style="width:200px"> <font color="red">*</font> <span class="gray"><script>document.write(amp_lldp_language['amp_lldp_dscpmh']);</script></span></td>
	</tr>
	<tr class="table_title table_border">
        <td colspan="2" rowspan="1" class="table_title table_border" BindText='amp_lldp_power_via_mdi'></td>
		<td class="table_right table_border"><input id='amp_lldp_power_via_mdi_enable' type='checkbox' name='amp_lldp_power_via_mdi_enable'></td> 
	</tr>
</table>
<table cellpadding="0" cellspacing="1" width="100%" class="table_button"> 
    <tr> 
      <td class="width_per25" ></td> 
      <td class="table_submit">
	  	<button id="btnApply2" name="btnApply2" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit(2);"><script>document.write(amp_lldp_language['amp_lldp_app']);</script></button> 
        <button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(amp_lldp_language['amp_lldp_cancel']);</script></button> 
	</td> 
    </tr> 
</table>

<table width="100%" height="10" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
</table> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_lldp_remote_tlv_title'></td>
    </tr>                  
</table>
<table width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
 <tr class="table_title table_border">
	<td colspan="1" rowspan="11" class="table_title table_border" BindText="amp_lldp_basic_tlv"></td>
    <td class="table_title table_border" BindText="amp_lldp_chassis_id"></td>
 	<td class="table_right table_border width_per65" id='RemoteChassisID'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_portid"></td>
 	<td class="table_right table_border" id='RemotePortID'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_timetolive_id"></td>
 	<td class="table_right table_border" id='RemoteTTL'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_port_des"></td>
 	<td class="table_right table_border" id='RemotePortDescription'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_system_name"></td>
 	<td class="table_right table_border" id='RemoteSystemName'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_system_des"></td>
 	<td class="table_right table_border" id='RemoteSystemDescription'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_system_cap"></td>
 	<td class="table_right table_border" id='RemoteSystemCapabilities'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_management_add"></td>
 	<td class="table_right table_border" id='RemoteManagementAddress'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_RemoteAutoNegSpt"></td>
 	<td class="table_right table_border" id='RemoteAutoNegSpt'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_RemoteAutoNegEnb"></td>
 	<td class="table_right table_border" id='RemoteAutoNegEnb'></td> 
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_RemoteOperMau"></td>
 	<td class="table_right table_border" id='RemoteOperMau'></td>
 </tr>
 <tr class="table_title table_border">
 	<td colspan="1" rowspan="9" class="table_title table_border" BindText="amp_lldp_med_tlv"></td>
 	<td class="table_title table_border" BindText="amp_lldp_lldpmed_capabilities"></td>
 	<td class="table_right table_border" id='RemoteMEDCapabilities'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_extended_power_via_mdi"></td>
 	<td class="table_right table_border" id='RemoteExtendedPowerViaMDI'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_hardware_revision"></td>
 	<td class="table_right table_border" id='RemoteHardwareRevision'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_firmware_revision"></td>
 	<td class="table_right table_border" id='RemoteFirmwareRevision'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_software_revision"></td>
 	<td class="table_right table_border" id='RemoteSoftwareRevision'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_sn"></td>
 	<td class="table_right table_border" id='RemoteSerialNumber'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_manufacturer_name"></td>
 	<td class="table_right table_border" id='RemoteManufacturerName'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_remoteModelName"></td>
 	<td class="table_right table_border" id='RemoteModelName'></td> 
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_remoteAssetID"></td>
 	<td class="table_right table_border" id='RemoteAssetID'></td>
 </tr>
</table>

<table width="100%" height="10" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
</table> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_lldp_local_tlv_title1'></td>
    </tr>                  
</table>
<table width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
 <tr class="table_title table_border">
	<td colspan="1" rowspan="11" class="table_title table_border" BindText="amp_lldp_basic_tlv"></td>
    <td class="table_title table_border" BindText="amp_lldp_chassis_id"></td>
 	<td class="table_right table_border width_per65" id='LocalChassisID'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_portid"></td>
 	<td class="table_right table_border" id='LocalPortID'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_timetolive_id"></td>
 	<td class="table_right table_border" id='LocalTTL'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_port_des"></td>
 	<td class="table_right table_border" id='LocalPortDescription'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_system_name"></td>
 	<td class="table_right table_border" id='LocalSystemName'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_system_des"></td>
 	<td class="table_right table_border" id='LocalSystemDescription'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_system_cap"></td>
 	<td class="table_right table_border" id='LocalSystemCapabilities'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_management_add"></td>
 	<td class="table_right table_border" id='LocalManagementAddress'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_RemoteAutoNegSpt"></td>
 	<td class="table_right table_border" id='LocalAutoNegSpt'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_RemoteAutoNegEnb"></td>
 	<td class="table_right table_border" id='LocalAutoNegEnb'></td> 
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_RemoteOperMau"></td>
 	<td class="table_right table_border" id='LocalOperMau'></td>
 </tr>
 <tr class="table_title table_border">
 	<td colspan="1" rowspan="9" class="table_title table_border" BindText="amp_lldp_med_tlv"></td>
 	<td class="table_title table_border" BindText="amp_lldp_lldpmed_capabilities"></td>
 	<td class="table_right table_border" id='LocalMEDCapabilities'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_extended_power_via_mdi"></td>
 	<td class="table_right table_border" id='LocalExtendedPowerViaMDI'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_hardware_revision"></td>
 	<td class="table_right table_border" id='LocalHardwareRevision'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_firmware_revision"></td>
 	<td class="table_right table_border" id='LocalFirmwareRevision'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_software_revision"></td>
 	<td class="table_right table_border" id='LocalSoftwareRevision'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_sn"></td>
 	<td class="table_right table_border" id='LocalSerialNumber'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_manufacturer_name"></td>
 	<td class="table_right table_border" id='LocalManufacturerName'></td>
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_remoteModelName"></td>
 	<td class="table_right table_border" id='LocalModelName'></td> 
 </tr>
 <tr class="table_title table_border">
 	<td class="table_title table_border" BindText="amp_lldp_remoteAssetID"></td>
 	<td class="table_right table_border" id='LocalAssetID'></td>
 </tr>
</table>

<table width="100%" height="10" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
</table> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_lldp_packages_total_title'></td>
    </tr>                  
</table>
<table width="100%" cellpadding="0" cellspacing="1" class="tabal_bg">
 <tr class="table_title table_border">
 	<td colspan="2" rowspan="1" class="table_title table_border" BindText="amp_lldp_tx_packages"></td>
 	<td class="table_right table_border width_per65" id='amp_lldp_tx_packages'></td>
 </tr>
 <tr class="table_title table_border">
 	<td colspan="2" rowspan="1" class="table_title table_border" BindText="amp_lldp_rx_packages"></td>
 	<td class="table_right table_border" id='amp_lldp_rx_packages'></td>
 </tr>
 <tr class="table_title table_border">
 	<td colspan="2" rowspan="1" class="table_title table_border" BindText="amp_lldp_drop_packages"></td>
 	<td class="table_right table_border" id='amp_lldp_drop_packages'></td>
 </tr>
</table>
<table width="100%" height="20" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr>
</table>
</div>  
</div>  
</body> 
</html> 
       