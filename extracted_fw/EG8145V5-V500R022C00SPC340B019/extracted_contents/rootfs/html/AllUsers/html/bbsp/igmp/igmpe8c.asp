<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>igmp</title>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(managemode.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(wan_list_info_e8c.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(wan_list_e8c.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(wan_check.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, route_language, igmp_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">

var Mldsuppert = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SUPPORT_MLD_PROXY);%>';
var HideMld = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HIDE_MLD_CONFIGURE);%>';
var IfVisual = "<% HW_WEB_IfVisualOltUser();%>";

var FJCTFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_FJCT);%>';

if ((Mldsuppert == 1) && (HideMld == 1))
{
    Mldsuppert = 0;
}
function stIGMPInfo(domain,IGMPEnable,ProxyEnable,SnoopingEnable,Robustness,GenQueryInterval,GenResponseTime,SpQueryNumber,SpQueryInterval,SpResponseTime,MLDProxyEnable,MLDSnoopingEnable,STBNumber,BridgeWanProxyEnable,RouterAlertEnable)
{
    this.domain = domain;
    this.IGMPEnable = IGMPEnable;
    this.ProxyEnable = ProxyEnable;
    this.SnoopingEnable = SnoopingEnable;
    this.Robustness = Robustness;
    this.GenQueryInterval = GenQueryInterval;
    this.GenResponseTime = GenResponseTime;
    this.SpQueryNumber = SpQueryNumber;
    this.SpQueryInterval = SpQueryInterval;
    this.SpResponseTime = SpResponseTime;
	this.STBNumber = STBNumber;
	this.MLDSnoopingEnable = MLDSnoopingEnable;
	this.MLDProxyEnable = MLDProxyEnable;
	this.BridgeWanProxyEnable = BridgeWanProxyEnable;
	this.RouterAlertEnable = RouterAlertEnable;
}
var IGMPInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_IPTV, IGMPEnable|ProxyEnable|SnoopingEnable|Robustness|GenQueryInterval|GenResponseTime|SpQueryNumber|SpQueryInterval|SpResponseTime|MLDProxyEnable|MLDSnoopingEnable|STBNumber|BridgeWanProxyEnable|RouterAlertEnable,stIGMPInfo);%>; 
var IGMPInfo = IGMPInfos[0];

var IPv4Enableflag = 0;
var IPv6Enableflag = 0;
var currentdomain  = "";

function filterWan(wan)
{
    if (Mldsuppert == 1)
	{
		if ((wan.ServiceList == "TR069") 
		 || (wan.ServiceList == "VOIP")
		 || (wan.ServiceList == "TR069_VOIP")
		 || ('0' == FeatureInfo.RouteWanMulticastIPoE && "IP_ROUTED" == wan.Mode.toString().toUpperCase())
		 || ('0' == FeatureInfo.BridgeWanMulticast && ("IP_BRIDGED" == wan.Mode.toString().toUpperCase() || "PPPOE_BRIDGED" == wan.Mode.toString().toUpperCase())))
		{
			return false;
		}
	}
	else
	{
		if(((wan.IPv4Enable=="0")&&(wan.IPv6Enable == "1")) || (wan.ServiceList =="TR069") || (wan.ServiceList == "VOIP")|| (wan.ServiceList =="TR069_VOIP") || ( '0' == FeatureInfo.RouteWanMulticastIPoE && "IP_ROUTED" == wan.Mode.toString().toUpperCase()) || ('0' == FeatureInfo.BridgeWanMulticast && ("IP_BRIDGED" == wan.Mode.toString().toUpperCase() || "PPPOE_BRIDGED" == wan.Mode.toString().toUpperCase())) )
		{
			return false;
		}
	}
	return true;
}

var WanInfo = GetWanListByFilter(filterWan);

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = igmp_language[b.getAttribute("BindText")];
	}
}

function WriteOption()
{
	for (i = 0; i < WanInfo.length; i++)
	{
		document.write('<option id="wan_' + i + '" value="' + WanInfo[i].domain + '">' + MakeWanName1(WanInfo[i]) + '</option>');
	}    
}

function getWanIndexByDomain(domain)
{
	var index = -1;
	for (var i = 0;i < WanInfo.length;i++)
	{
		if (domain == WanInfo[i].domain)
		{
			index = i;
		}
	}
	return index;
}

function onWanNameChange()
{
	if (WanInfo.length > 0)
	{
		currentdomain = getSelectVal('InterfaceSelect_select');
		var index = getWanIndexByDomain(currentdomain);
		IPv4Enableflag = WanInfo[index].IPv4Enable;
		IPv6Enableflag = WanInfo[index].IPv6Enable;
		
		if(FJCTFlag ==1)
		{
		    if(WanInfo[index].Mode == 'IP_Routed')
			{
				setCheck("IGMPSnooping_checkbox", IGMPInfo.SnoopingEnable);
				setCheck("IGMPProxy_checkbox", IGMPInfo.ProxyEnable);
				setCheck("MldSnooping_checkbox", IGMPInfo.SnoopingEnable);
				setCheck("MldProxy_checkbox", IGMPInfo.ProxyEnable);
				setCheck("RouterAlertEnable_checkbox", IGMPInfo.RouterAlertEnable);
			}
			else
			{
				var ProxyEnable = false;
				if(IGMPInfo.ProxyEnable != 0) {
					ProxyEnable = true;
					setDisable("RouterAlertEnable_checkbox", 0);
				} else {
					setDisable("RouterAlertEnable_checkbox", 1);
				}

				var SnoopingEnable = false;
				if(IGMPInfo.SnoopingEnable != 0) {
					SnoopingEnable = true;
				}

				setCheck("IGMPSnooping_checkbox", (IGMPInfo.BridgeWanProxyEnable != 0)?(ProxyEnable):(ProxyEnable || SnoopingEnable));
				setCheck("IGMPProxy_checkbox", IGMPInfo.BridgeWanProxyEnable);
				setCheck("MldSnooping_checkbox", (IGMPInfo.BridgeWanProxyEnable != 0)?(ProxyEnable):(ProxyEnable || SnoopingEnable));
				setCheck("MldProxy_checkbox", IGMPInfo.BridgeWanProxyEnable);
				setCheck("RouterAlertEnable_checkbox", IGMPInfo.RouterAlertEnable);
			}
		}
		
		if (Mldsuppert == 1)
		{
			if (1 == IPv4Enableflag)
			{
				setDisplay('tr_IPv4MulticastVlanTitle', 1);
				setDisplay('IPv4MulticastVlanTitle', 1);
				setDisplay('MulticastSettings_text', 1);
				setText('MulticastSettings_text', WanInfo[index].IPv4WanMVlanId);
			}
			else
			{
				setDisplay('tr_IPv4MulticastVlanTitle', 0);
				setDisplay('IPv4MulticastVlanTitle', 0);
				setDisplay('MulticastSettings_text', 0);
			}
			
			if (1 == IPv6Enableflag)
			{
				setDisplay('tr_IPv6MulticastVlanTitle', 1);
				setDisplay('IPv6MulticastVlanTitle', 1);
				setDisplay('IPv6MulticastVlanVal', 1);
				setText('IPv6MulticastVlanVal', WanInfo[index].IPv6WanMVlanId);
			}
			else
			{
				setDisplay('tr_IPv6MulticastVlanTitle', 0);
				setDisplay('IPv6MulticastVlanTitle', 0);
				setDisplay('IPv6MulticastVlanVal', 0);
			}
		}
		else
		{
			if (1 == WanInfo[index].IPv4Enable)
			{
				setText('MulticastSettings_textold',WanInfo[index].IPv4WanMVlanId);
			}
		}
	}
}

function CheckVlanValid(VlanID,filedDesc)
{
	var errmsg="";
	errmsg=checkMVlanID(VlanID,""); 
	
	if(""!=errmsg)
	{
	   AlertEx(filedDesc+errmsg);
	   return false;
	}
	return true;
}

function checkForm()
{
	if (WanInfo.length == 0)
	{
		AlertEx(route_language['bbsp_alert_wan']);
		return false;
	}
	if (Mldsuppert == 1)
	{
		if (IPv4Enableflag == 1)
		{
			if (CheckVlanValid(getValue('MulticastSettings_text'), igmp_language['bbsp_ipv4multicast']) == false)
			{
				return false;
			}
		}
		
		if (IPv6Enableflag == 1)
		{
			if (CheckVlanValid(getValue('IPv6MulticastVlanVal'), igmp_language['bbsp_ipv6multicast']) == false)
			{
				return false;
			}
		}
	}
	else
	{
		var MVlanID = getValue('MulticastSettings_textold');
		
		if (( "" != MVlanID) && (IPv4Enableflag == 1 ))
		{
			if(CheckVlanValid(MVlanID,igmp_language['bbsp_ipv4multicast']) == false)
			{
				return false;
			}

		}
	}
	return true;
}

function IgmpModeChange()
{
	var enableIgmpSnooping = (true == getElement('IGMPSnooping_checkbox').checked) ? 1 : 0;
	var enableIgmpProxy = (true == getElement('IGMPProxy_checkbox').checked) ? 1 : 0;
	if (Mldsuppert == 1)
	{
		var enableMldSnooping = (true == getElement('MldSnooping_checkbox').checked) ? 1 : 0;
		var enableMldProxy = (true == getElement('MldProxy_checkbox').checked) ? 1 : 0;
	}

	if (enableIgmpProxy == 1) {
		setDisable("RouterAlertEnable_checkbox", 0);
	} else {
		setDisable("RouterAlertEnable_checkbox", 1);
	}

	var Form = new webSubmitForm();
	Form.addParameter('x.ProxyEnable',enableIgmpProxy);
	Form.addParameter('x.SnoopingEnable',enableIgmpSnooping);
	if (Mldsuppert == 1)
	{
		Form.addParameter('x.MLDSnoopingEnable',enableMldSnooping);
		Form.addParameter('x.MLDProxyEnable',enableMldProxy);
	}
	if (Mldsuppert == 1)
	{
		if(enableIgmpSnooping || enableIgmpProxy||enableMldSnooping||enableMldProxy)
		{
	        Form.addParameter('x.IGMPEnable',1);
	    }
		else
		{
	        Form.addParameter('x.IGMPEnable',0);
		}
	}
	else
	{
		if(enableIgmpSnooping || enableIgmpProxy)
		{
	        Form.addParameter('x.IGMPEnable',1);
	    }
		else
		{
	        Form.addParameter('x.IGMPEnable',0);
	    }
	}

	if (enableIgmpProxy == 1) {
		var routerAlert = (true == getElement('RouterAlertEnable_checkbox').checked) ? 1 : 0;
		Form.addParameter('x.RouterAlertEnable', routerAlert);
	}

	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('complex.cgi?x=InternetGatewayDevice.Services.X_HW_IPTV' + '&RequestFile=html/bbsp/igmp/igmpe8c.asp');
	Form.submit();
}

function OnSave()
{
	var IPv4MVlanID = 0xFFFFFFFF;
	var IPv6MVlanID = 0xFFFFFFFF;

	if (false == checkForm())
	{
		return false;
	}
	
	var Form = new webSubmitForm();	
	
	if ((1 == IPv4Enableflag)
	    &&(Mldsuppert == 1))
	{
		IPv4MVlanID = (getValue('MulticastSettings_text') != "") ? getValue('MulticastSettings_text') : 0xFFFFFFFF;
		Form.addParameter('y.X_HW_MultiCastVLAN',IPv4MVlanID);
	}
	else if ((1 == IPv4Enableflag)
	    &&(Mldsuppert == 0))
	{
	    IPv4MVlanID = (getValue('MulticastSettings_textold') != "") ? getValue('MulticastSettings_textold') : 0xFFFFFFFF;
		Form.addParameter('y.X_HW_MultiCastVLAN',IPv4MVlanID);
	}
	
	if (Mldsuppert == 1)
	{
	
		if (1 == IPv6Enableflag)
		{
			IPv6MVlanID = (getValue('IPv6MulticastVlanVal') != "") ? getValue('IPv6MulticastVlanVal') : 0xFFFFFFFF;
			Form.addParameter('y.X_HW_IPv6MultiCastVLAN',IPv6MVlanID);
		}
	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('complex.cgi?y=' + currentdomain + '&RequestFile=html/bbsp/igmp/igmpe8c.asp');
	setDisable('Save_button',1);
	Form.submit();
}

function IsShowIpv6Mvlan()
{

    if (Mldsuppert == 1)
	{
		setDisplay('tr_IPv4MulticastVlanTitle', 1);
		setDisplay('tr_IPv6MldSnoopingTitle', 1);
		setDisplay('tr_IPv6MldProxyTitle', 1);
		
		if (1 == IPv6Enableflag)
		{
			setDisplay('IPv6MulticastVlanTitle', 1);
			setDisplay('IPv6MulticastVlanVal', 1);
			setDisplay('tr_IPv6MulticastVlanTitle', 1);
		}
		setDisplay('IPv4MulticastVlanTitle', 1);
		setDisplay('MulticastSettings_text', 1);	
		if(FJCTFlag == 1)
		{
		   setDisplay('tr_FJCTTitle',1);
		}
		else
		{
		   setDisplay('tr_IPv4IPV6Title',1)
		}
	}
	else
	{
		setDisplay('tr_IPv4Title', 1);
		setDisplay('tr_IPvMulticastVlanTitle', 1);
		setDisplay('IPv4MulticastVlanTitleold', 1);
	}

}

function LoadFrame()
{
    if (Mldsuppert == 1)
	{
		setDisplay('tr_IPv4MulticastVlanTitle', 0);
		setDisplay('IPv4MulticastVlanTitle', 0);
		setDisplay('MulticastSettings_text', 0);
		setDisplay('MulticastSettings_textold', 0);
		setDisplay('tr_IPv6MulticastVlanTitle', 0);
		setDisplay('IPv6MulticastVlanTitle', 0);
		setDisplay('IPv6MulticastVlanVal', 0);
	}
	if(FJCTFlag ==1)
	{
	    setDisable("MldSnooping_checkbox",1);
		setDisable("MldProxy_checkbox",1);
	    setDisable("IGMPProxy_checkbox",1);
		setDisable("IGMPSnooping_checkbox",1);
		setDisable("RouterAlertEnable_checkbox",1);
	}
	
	if ( null != IGMPInfo )
	{
		getElement('IGMPSnooping_checkbox').checked = false;
		getElement('IGMPProxy_checkbox').checked = false;
		if (Mldsuppert == 1)
		{
			getElement('MldSnooping_checkbox').checked = false;
			getElement('MldProxy_checkbox').checked = false;
		}

		setDisable("RouterAlertEnable_checkbox", 1);

		if('1' == IGMPInfo.IGMPEnable){
			if('1' == IGMPInfo.SnoopingEnable)
			{
				getElement('IGMPSnooping_checkbox').checked = true;
			}
			if('1' == IGMPInfo.ProxyEnable)
			{
				getElement('IGMPProxy_checkbox').checked = true;
				if (FJCTFlag !== '1') {
					setDisable("RouterAlertEnable_checkbox", 0);
				}
			}
			if (Mldsuppert == 1)
			{
				if('1' == IGMPInfo.MLDSnoopingEnable)
				{
					getElement('MldSnooping_checkbox').checked = true;
				}
					if('1' == IGMPInfo.MLDProxyEnable)
				{
					getElement('MldProxy_checkbox').checked = true;
				}
			}
		}

		setCheck('RouterAlertEnable_checkbox', IGMPInfo.RouterAlertEnable);
	}
	
	onWanNameChange();
	IsShowIpv6Mvlan();
	if(IfVisual == 1)
	{
	   pageDisable();
	   setDisable('Save_button',1);
	}
	
	loadlanguage();
}
</script>
<body onLoad="LoadFrame();" class="mainbody"> 
<form id="ConfigForm"> 
  <table width="100%" border="0" cellpadding="0" cellspacing="1"> 
	  <tr> 
		<td id="tr_IPv4IPV6Title"  style = "display:none" class="title_common" width="100%"><script>document.write(igmp_language['bbsp_igmp_title1']);</script></td>
		<td id="tr_IPv4Title" style = "display:none" class="title_common" width="100%"><script>document.write(igmp_language['bbsp_igmp_title2']);</script></td>
        <td id="tr_FJCTTitle" style = "display:none" class="title_common" width="100%"><script>document.write(igmp_language['bbsp_igmp_title3']);</script></td>  		
	  </tr> 
  </table> 
  <div class="title_spread"></div>

	<table cellpadding="0" cellspacing="0" width="100%"> 
		<tr> 
			<td class="table_title"> <input type='checkbox' value='True' id='IGMPSnooping_checkbox' name='IGMPSnooping_checkbox' onclick="IgmpModeChange()"> <script>document.write(igmp_language['bbsp_enableIgmpSnooping']);</script></td> 
		</tr>
		<tr> 
			<td class="table_title"> <input type='checkbox' value='True' id='IGMPProxy_checkbox' name='IGMPProxy_checkbox' onclick="IgmpModeChange()"> <script>document.write(igmp_language['bbsp_enableIgmpProxy']);</script></td> 
		</tr>
			<tr id="tr_IPv6MldSnoopingTitle" style = "display:none"> 
			<td class="table_title"> <input type='checkbox' value='True' id='MldSnooping_checkbox' name='MldSnooping_checkbox' onclick="IgmpModeChange()"> <script>document.write(igmp_language['bbsp_enableMldSnooping']);</script></td> 
		</tr>
		<tr id="tr_IPv6MldProxyTitle" style = "display:none"> 
			<td class="table_title"> <input type='checkbox' value='True' id='MldProxy_checkbox' name='MldProxy_checkbox' onclick="IgmpModeChange()"> <script>document.write(igmp_language['bbsp_enableMldProxy']);</script></td> 
		</tr>
		<tr> 
			<td class="table_title"> <input type='checkbox' value='True' id='RouterAlertEnable_checkbox' name='RouterAlertEnable_checkbox' onclick="IgmpModeChange()"><script>document.write(igmp_language['bbsp_RouterAlertEnable'].replace(':', ''));</script></td>
		</tr>
	</table>
	<div class="func_spread"></div>
	
	 <table cellpadding="0" cellspacing="1" width="100%"> 
		<div class="func_title" id = "MulticastVLAN_lable"><script>document.write(igmp_language['bbsp_MultiVlan']);</script></div>
		<table cellpadding="0" cellspacing="0" width="100%"> 
			<tr class="tabal_tr">
				<td width="25%" class="table_title"><script>document.write(igmp_language['bbsp_wanname']);</script></td> 
				<td width="75%" class="table_right"> 
					<select id="InterfaceSelect_select" name="InterfaceSelect_select" maxlength="30" onChange="onWanNameChange();"> 
						<script language="javascript">WriteOption();</script> 
					</select> 
				</td> 
			</tr> 
			<tr class="tabal_tr" id="tr_IPv4MulticastVlanTitle" style="display:none;">
				<td width="25%" class="table_title" id="IPv4MulticastVlanTitle"><script>document.write(igmp_language['bbsp_IPv4MultiVlan']);</script></td> 
				<td width="75%" class="table_right"> <input type='text' id="MulticastSettings_text" name="MulticastSettings_text" maxlength='15'></td> 
			</tr>
			<tr class="tabal_tr" id="tr_IPvMulticastVlanTitle" style="display:none;">
				<td width="25%" class="table_title" id="IPv4MulticastVlanTitleold"><script>document.write(igmp_language['bbsp_MultiVlan']);</script></td> 
				<td width="75%" class="table_right"> <input type='text' id="MulticastSettings_textold" name="MulticastSettings_textold" maxlength='15'></td> 
			</tr> 
			<tr class="tabal_tr" id="tr_IPv6MulticastVlanTitle" style="display:none;">
				<td width="25%" class="table_title" id="IPv6MulticastVlanTitle"><script>document.write(igmp_language['bbsp_IPv6MultiVlan']);</script></td> 
				<td width="75%" class="table_right"> <input type='text' id="IPv6MulticastVlanVal" name="IPv6MulticastVlanVal" maxlength='15'></td> 
			</tr> 
		</table>
	</table>
	
	<div class="button_spread"></div>
	<table width="100%" border="0"  class="table_button"> 
		<tr align="right">
			<td >
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<button id="Save_button" type="button" class="submit" onClick="OnSave();"><script>document.write(igmp_language['bbsp_save']);</script></button>
			</td>
		</tr> 
	</table> 
</form>
</body>
</html>
