
﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>DDNS</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href="../../../Cuscss/<%HW_WEB_GetCusSource(gateway.css);%>" type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list.asp);%>"></script>
</head>

<script language="JavaScript" type="text/javascript">

function stDdns(domain,Enable,Provider,Username,Port,DomainName,HostName,SaltAddress)
{
    this.domain = domain;
    this.DDNSCfgEnabled = Enable;
    this.DDNSProvider = Provider;
    this.DDNSUsername = Username;
    this.Password = '********************************';
    this.ServicePort = Port;
    this.DDNSDomainName = DomainName;
    this.DDNSHostName = HostName;
	this.SaltAddress = SaltAddress;
}

var WanIPDdns = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_DDNSConfiguration.{i},DDNSCfgEnabled|DDNSProvider|DDNSUsername|ServicePort|DDNSDomainName|DDNSHostName|SaltAddress,stDdns);%>;
var WanPPPDdns = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_DDNSConfiguration.{i},DDNSCfgEnabled|DDNSProvider|DDNSUsername|ServicePort|DDNSDomainName|DDNSHostName|SaltAddress,stDdns);%>;

function filterWan(WanItem)
{
	return true;
}

var wans = GetWanListByFilter(filterWan);

function fliterDdns(WanItem)
{
	if (WanItem.ServiceList != 'TR069'
         && WanItem.Mode == 'IP_Routed')
	{
		return true;
	}
	return false;
}

var Ddns = GetAppListFormWanAppendInfo(WanPPPDdns, WanIPDdns, fliterDdns);

function LoadFrame()
{    
	setDisplay('TableConfigInfo',1);
	if (Ddns.length > 0)
	{
		setSelect('DDNSProvider', Ddns[0].DDNSProvider); 
		setText('DDNSDomainName', Ddns[0].DDNSDomainName);
		setText('DDNSUsername', Ddns[0].DDNSUsername);
		setText('DDNSPassword', Ddns[0].Password);	
		setRadio('DDNSCfgEnabled', Ddns[0].DDNSCfgEnabled);	
	}
    else
    {
        setRadio('DDNSCfgEnabled', '0');	
    }   
}

function CheckForm()
{      
	if (getValue("DDNSDomainName") == "")
    {
	    AlertEx(ddns_language['bbsp_domainisreq']);
        return false;
    }		

	if (getValue("DDNSProvider") == 'no-ip')
	{
		if(CheckMultDomainName(getValue("DDNSDomainName")) == false)
		{	
		   AlertEx(ddns_language['bbsp_domainx'] + getValue("DDNSDomainName") +  ddns_language['bbsp_invalid']);		
		   return false;
		}
	}
	else
	{
		if(CheckDomainName(getValue("DDNSDomainName")) == false)
		{			
			AlertEx(ddns_language['bbsp_domainx'] + getValue("DDNSDomainName") +  ddns_language['bbsp_invalid']);
			return false;
		}
	}

	if (getValue("DDNSUsername") == "") 
	{
	   AlertEx(ddns_language['bbsp_userisreq']);
	   return false;
	}
	
	if (isValidAscii(getValue("DDNSUsername")) != '')         
	{  
		AlertEx(Languages['IPv4UserName1'] + Languages['Hasvalidch'] + isValidAscii(getValue("DDNSUsername")) + ddns_language['bbsp_sign']);          
		return false;       
	}
		
	return true;
}

function GetInterfacePath()
{
	for(var k = 0; k < wans.length; k++ )
	{
		if(wans[k].ServiceList.indexOf('INTERNET') >= 0
			&& wans[k].IPv4Enable == '1' 
        	&& wans[k].Mode == 'IP_Routed')
		{
			return wans[k].domain;
		}
	}
	return "InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.1.WANPPPConnection.1";
}

function AddSubmitParam()
{
    var Interface = GetInterfacePath();
	
	if (false == CheckForm())
	{
		return;
	}
    var DomainPrefix = Interface +'.X_HW_DDNSConfiguration';
	var url;
	var SpecDdnsConfigParaList = new Array();
	
	SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSCfgEnabled", getRadioVal('DDNSCfgEnabled'), 1));
	SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSProvider", getSelectVal('DDNSProvider'), 1));
  	SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSUsername", getValue('DDNSUsername'), 1));        
    if (getValue('DDNSPassword') != '********************************')
    {
		SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSPassword", getValue('DDNSPassword'), 1));    
    } 
	SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSDomainName", getValue('DDNSDomainName'),1));  
    SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSHostName", getDDNSHostName(getSelectVal('DDNSProvider')), 1)); 
	
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = DdnsConfigFormList;
	Parameter.SpecParaPair = SpecDdnsConfigParaList;
	var tokenvalue = getValue('onttoken');	
	if ( Ddns.length < 1 )
	{
		url = 'add.cgi?x=' + DomainPrefix
						   +'&RequestFile=html/bbsp/ddns/ddnsTlf.asp';
	}
	else
	{
		url = 'set.cgi?x=' + Ddns[0].domain
						   +'&RequestFile=html/bbsp/ddns/ddnsTlf.asp';
	}
	HWSetAction(null, url, Parameter, tokenvalue);

	setDisable('btnApply_ex',1);
    setDisable('cancelValue',1);	
}

function getDDNSHostName(DDNSProvider)
{
	var paire = {"dyndns":"members.dyndns.org",
				 "no-ip":"dynupdate.no-ip.com",
				 "dtdns":"www.dtdns.com",
				 "easydns":"members.easydns.com"};
	try
	{
		return paire[DDNSProvider];
	}
	catch(e)
	{
		return "";
	}
}
    
function CancelConfig()
{
	LoadFrame();
}

function InitDDNSProvider()
{
	var i = 0;
    $("#DDNSProvider").append('<option value=' + "no-ip" + ' id="'
                        + i++ + '">'
                        +ddns_language['bbsp_no_ip_TLF'] + '</option>');
						
    $("#DDNSProvider").append('<option value=' + "dyndns" + ' id="'
                        + i++ + '">'
                        +ddns_language['bbsp_nyndns_TLF'] + '</option>');
						
	$("#DDNSProvider").append('<option value=' + "easydns" + ' id="'
                        + i++ + '">'
                        +ddns_language['bbsp_easynds_TLF'] + '</option>');

	$("#DDNSProvider").append('<option value=' + "dtdns" + ' id="'
                        + i++ + '">'
                        +ddns_language['bbsp_dtdns_TLF'] + '</option>');
}

function ISPChange()
{
	setText("DDNSUsername", '');
	setText("DDNSPassword", '');
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div class="title_spread"></div>
 <form id="TableConfigInfo" style="display:none"> 
 <div class="list_table_spread"></div>
	 <table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="DDNSTitleBar"       RealType="HorizonBar"       DescRef="bbsp_DDNSTitle"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"                   InitValue="Empty"/> 
		<li   id="DDNSInfoBar"        RealType="HorizonBar"       DescRef="bbsp_DDNSInfoTLF"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"                   InitValue="Empty"/> 
		<li   id="DDNSCfgEnabled"     RealType="RadioButtonList"  DescRef="bbsp_DDNShm"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DDNSCfgEnabled"        InitValue="[{TextRef:'bbsp_enableTlf',Value:'1'},{TextRef:'bbsp_disableTlf',Value:'0'}]"/>                                                                       
        <li   id="DDNSProvider"       RealType="DropDownList"     DescRef="bbsp_provider"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DDNSProvider"     Elementclass="SelectText" ClickFuncApp="onchange=ISPChange"/>
		<li   id="DDNSUsername"       RealType="TextBox"          DescRef="bbsp_username"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DDNSUsername"   Elementclass="InputText"  InitValue="Empty" MaxLength="256"/>
		<li   id="DDNSPassword"       RealType="TextBox"          DescRef="bbsp_password"          RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""  Elementclass="InputText"   InitValue="Empty" MaxLength="256"/>
		<li   id="DDNSDomainName"     RealType="TextBox"          DescRef="bbsp_hostname"       RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DDNSDomainName" Elementclass="InputText"  InitValue="Empty" MaxLength="256"/>
		<script language="JavaScript" type="text/javascript">
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			DdnsConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
			var formid_hide_id = null;
			HWParsePageControlByID("TableConfigInfo", TableClass, ddns_language, formid_hide_id);
			InitDDNSProvider();
		</script>
	  </table>
	   <table width="100%" class="table_button"> 
        <tr > 
          <td class="width_per25"></td> 
          <td>
		  	<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 		  	
            <button name="cancelValue" id="cancelValue" type="button" class="btn-default-orange-small right" onClick="CancelConfig();return false;"><script>document.write(ddns_language['bbsp_cancel']);</script></button>
			<button id="btnApply_ex" name="btnApply_ex" type="button" class="btn-default-orange-small right" onClick="AddSubmitParam();return false;"><script>document.write(ddns_language['bbsp_save']);</script></button> 
		</td> 
        </tr> 
      </table> 
  </form>
</body>
</html>

	
