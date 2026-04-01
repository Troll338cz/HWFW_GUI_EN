<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet" type="text/css" href='../../../Cuscss/<%HW_WEB_GetCusSource(gateway.css);%>'/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<title>DMZ</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.TextBox {
    width: 180px;
    height: 24px;
}
</style>
<script language="JavaScript" type="text/javascript">

function LoadFrame()
{
	if (DmzInfo.length > 0)
	{
		setRadio('DMZEnable', DmzInfo[0].DMZEnable);
		setText('DMZHostIPAddress', DmzInfo[0].DMZHostIPAddress);
	}
	else
	{
		setRadio('DMZEnable', '0');
		setText('DMZHostIPAddress', '');
	}	
}

function stDMZInfo(domain,DMZEnable,DMZHostIPAddress, flag)
{
	this.domain = domain;
	this.DMZEnable = DMZEnable;
	this.DMZHostIPAddress = DMZHostIPAddress;
	this.flag = 0;
}

function filterPPPInternetWan(WanItem)
{
	if ((WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
	       && (WanItem.domain.indexOf("WANPPPConnection") >= 0))
    {
        return true;
    }
   
    return false;    
}
var internetPPPWanInfo = GetWanListByFilter(filterPPPInternetWan);

var PppDmzInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_DMZ,DMZEnable|DMZHostIPAddress,stDMZInfo);%>;

var DmzInfo = new Array();

for (var i = 0; i < PppDmzInfo.length - 1; i++)
{
	if (PppDmzInfo[i].domain.split('.X_HW_DMZ')[0]  == internetPPPWanInfo[0].domain)
	{
		DmzInfo[0] = PppDmzInfo[i];
	}
}

function GetInterfacePath()
{
	for(var k = 0; k < internetPPPWanInfo.length; k++ )
	{
		if(internetPPPWanInfo[k].ServiceList.indexOf('INTERNET') >= 0
			&& internetPPPWanInfo[k].IPv4Enable == '1' 
        	&& internetPPPWanInfo[k].Mode == 'IP_Routed')
		{
			return internetPPPWanInfo[k].domain;
		}
	}
	return "InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.1.WANPPPConnection.1";
}

function CheckDMZ()
{
	var innerHostIp = $.trim(getValue("DMZHostIPAddress"));

    if (innerHostIp == "")
    {
        AlertEx(dmz_language['bbsp_dmzisreq']);
        return false;
    } 
	
	if (isAbcIpAddress(innerHostIp) == false)
    {
        AlertEx(portmapping_language['bbsp_hostipinvalid']);
        return false;
    }

    if (isValidIpAddress(innerHostIp) == false)
    {
        AlertEx(dmz_language['bbsp_dmzinvalid']);
        return false;
    }
	
	return true;
}

function ApplyConfig()
{
	if(CheckDMZ() == false)
	{
		return false;
	}
	
	setDisable('btnCancel',1);
	setDisable('btnApply',1);

	var Interface = GetInterfacePath();
	
	var url;
	var SpecDmzCfgParaList = new Array(new stSpecParaArray("x.DMZEnable", getRadioVal("DMZEnable"), 1),
									   new stSpecParaArray("x.DMZHostIPAddress", getValue("DMZHostIPAddress"), 1));
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = DmzConfigFormList;
	Parameter.SpecParaPair = SpecDmzCfgParaList;
	if(DmzInfo.length == 0 )
	{
		url = 'add.cgi?x=' + Interface + '.X_HW_DMZ'
						   + '&RequestFile=html/bbsp/dmz/dmzTlf.asp';
	}
	else
	{
		url = 'set.cgi?x=' + DmzInfo[0].domain 
						   + '&RequestFile=html/bbsp/dmz/dmzTlf.asp';
	}
	HWSetAction(null, url, Parameter, getValue('onttoken'));
	
}

function CancelConfig()
{
	LoadFrame();
}	

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
	<form id="ConfigForm">
		<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
			<li   id="DMZTitleBar"       RealType="HorizonBar"      DescRef="bbsp_titledmzbar"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"                 InitValue="Empty"/> 
			<li   id="DMZSInfoBar"       RealType="HorizonBar"      DescRef="bbsp_infodmzbar"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"                 InitValue="Empty"/> 
			<li   id="DMZEnable"         RealType="RadioButtonList" DescRef="bbsp_statemh"            RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DMZEnable"   		InitValue="[{TextRef:'bbsp_enableTlf',Value:'1'},{TextRef:'bbsp_disableTlf',Value:'0'}]"/>                                                                
			<li   id="DMZHostIPAddress" RealType="TextBox"       DescRef="bbsp_hostaddrmh"         RemarkRef="Empty"      ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DMZHostIPAddress" 		Elementclass="TextBox" InitValue="Empty" MaxLength="256"/>                                                                 
		</table>
		<script>
			var TableClass = new stTableClass("table_title width_per25", "table_right", "", "Select");
			DmzConfigFormList = HWGetLiIdListByForm("ConfigForm");
			HWParsePageControlByID("ConfigForm", TableClass, dmz_language, null);
		</script>
  		<table id="ConfigPanelButtons" width="100%"  class="table_button"> 
    		<tr> 
      			<td>
	    			<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 
	    			<button name="btnCancel" id="btnCancel" class="btn-default-orange-small right" onClick="CancelConfig();return false;"><script>document.write(dmz_language['bbsp_cancel']);</script></button> 
	    			<button name="btnApply" id="btnApply" class="btn-default-orange-small right" onClick="ApplyConfig();return false;"><script>document.write(dmz_language['bbsp_save']);</script></button>         			
				</td> 
    		</tr> 
  		</table> 
	</form>
</body>
</html>
