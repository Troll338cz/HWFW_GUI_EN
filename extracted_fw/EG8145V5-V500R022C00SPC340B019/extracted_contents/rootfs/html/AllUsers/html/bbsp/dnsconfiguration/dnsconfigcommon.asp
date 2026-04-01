<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>

<title>dnsconfigcommon</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wandns.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>

<script language="javascript" src="../common/dnshostslist.asp"></script>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/dnsconfiguration/dnssearchlist.cus);%>"></script>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/dnsconfiguration/dnshosts.cus);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
.InputDns{
	width: 311px;
}
.SelectDns
{
	width: 311px;
	direction:ltr; 
}
</style>
<script language="JavaScript" type="text/javascript">
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
		setObjNoEncodeInnerHtmlValue(b, dnspolicy_language[b.getAttribute("BindText")]);
	}
}

function stDnsInfo(domain,type,policy,DnsServerEnable)
{
    this.domain = domain;
	this.type = type;
	this.policy = policy;
    this.DnsServerEnable = DnsServerEnable;
}

function DnsSearchListItemClass(domain, DNSServer, DomainName, Interface, WanServiceType)
{
    this.domain     = domain;
    this.DNSServer  = DNSServer;
    this.DomainName = DomainName;
    this.Interface  = Interface;
    this.WanServiceType = WanServiceType;
}

function SafeDomainNameItemClass(domain, domainName) {
    this.domain     = domain;
    this.domainName = domainName;
}

function configLanDnsSever()
{
    var enable = getCheckVal('enableLanDnsSever');
}
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var DnspolicyInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DNS, SupportedRecordTypes|LocalDNSPolicy|DnsServerEnable,stDnsInfo);%>; 
var DnspolicyInfo = DnspolicyInfos[0];
var DSLTableName = "DSLConfigList";
var SDNLTableName = "SDNLConfigList";

var DNS_NULL_INTERFACE_NAME="";
var DnsSearchListTemp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DNS.SearList.{i},DNSServer|DomainName|Interface|WanServiceType, DnsSearchListItemClass);%>;  
var DnsSearchList = new Array();
var Count = 0;
var DSLselctIndex = -1;

var SDNLselctIndex = -1;
var safeDomainNameListTemp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DNS.AntiDNSRebind.SafeDomainName.{i}, DomainName, SafeDomainNameItemClass);%>;
var safeDomainNameList = new Array();
var isAntiDnsRebAtkEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DNS.AntiDNSRebind.Enable);%>';
var antiDnsRebindFT = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_ANTIDNSREBIND);%>'; 
var sysUserType = '0';
var SonFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SONET);%>'; 
var DHTableName = "DnsHostConfigList";
var DHselctIndex = -1;
var DnsHostsList = GetDnsHostsList();
var SingtelModeEX = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL_EX);%>';
var TDEMode = '<%HW_WEB_GetFeatureSupport(HW_BBSP_FT_FEATURE_TDE);%>';
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var maxisNormalUser = '2';
var exchangeWan = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_EXCHANGE_NAME_WAN);%>';
var oteFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>';
var htFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>';

if (CfgMode.toUpperCase() == 'DNOVA2WIFI') {
    curUserType = sysUserType;
}

var AllWanInfo = GetWanList();
function FindWaninfo(item)
{
	if(item.Interface == '')
		return true;

	for(var k = 0;k < AllWanInfo.length;k++)
	{
		if(item.Interface == domainTowanname(AllWanInfo[k].domain))
			return true;
	}

	return false;
}

for (var i = 0; i < DnsSearchListTemp.length-1; i++)
{
	if(SingtelModeEX == 1)
	{
		if(FindWaninfo(DnsSearchListTemp[i]) == false)
		{
			continue;	
		}
	}
	DnsSearchList[Count++] = DnsSearchListTemp[i];
}

function GetDnsSearchList()
{
	return DnsSearchList;
}

for (var j = 0; j < safeDomainNameListTemp.length - 1; j++) {
    safeDomainNameList[j] = safeDomainNameListTemp[j];
}

function GetSafeDomainNameList() {
    return safeDomainNameList;
}

function SDNLBindPageData(safeDomainNameListInfo) {
    setText("SDNLdomain", safeDomainNameListInfo.domain);
    setText("SDNLDomainName", safeDomainNameListInfo.domainName);
}

function DSLBindPageData(DnsSearchListInfo)
{    
	setText("DSLdomain", DnsSearchListInfo.domain);
	setText("DNSServer", DnsSearchListInfo.DNSServer); 
	setText("DSLDomainName", DnsSearchListInfo.DomainName);  	

    if (CfgMode.toUpperCase() == 'DBAA1') {
        setSelect("WanTypeList", DnsSearchListInfo.WanServiceType);
    } else {
        if(DnsSearchListInfo.Interface != '') {
            setSelect("WanNameList", DnsSearchListInfo.Interface);
        } else { 
            setSelect("WanNameList", DNS_NULL_INTERFACE_NAME);	
        }
    }
}

function GetDnsSearchListData()
{
    var CurrentDomain = (DnsSearchList[DSLselctIndex] != null) ? DnsSearchList[DSLselctIndex].domain : "";
    return new DnsSearchListItemClass(CurrentDomain, getValue("DNSServer"), getValue("DSLDomainName"), getValue("WanNameList"), getValue("WanTypeList"));
}

function GetSafeDomainNameListData() {
    var currentDomain = ((SDNLselctIndex > -1) && (safeDomainNameList[SDNLselctIndex] != null)) ? safeDomainNameList[SDNLselctIndex].domain : "";
    return new SafeDomainNameItemClass(currentDomain, getValue("SDNLDomainName"));
}

function DSLCheckIpv6Adress(DnsSearchListItem)
{
	if (DnsSearchListItem.DNSServer != '' )
	{
		if ( IsIPv6AddressValid(DnsSearchListItem.DNSServer) == false)
		{
			AlertEx(dnscfg_language['bbsp_ipx']+ DnsSearchListItem.DNSServer + dnscfg_language['bbsp_invalid']);
			return false;
		}
		
		if (parseInt(DnsSearchListItem.DNSServer.split(":")[0], 16) >= parseInt("0xFF00", 16))
		{
			AlertEx(dnscfg_language['bbsp_ipx']+ DnsSearchListItem.DNSServer + dnscfg_language['bbsp_invalid']);
			return false;   
		} 

		if (IsIPv6ZeroAddress(DnsSearchListItem.DNSServer) == true)
		{
		   AlertEx(dnscfg_language['bbsp_ipx']+ DnsSearchListItem.DNSServer + dnscfg_language['bbsp_invalid']);
		   return false;  
		}

		if (IsIPv6LoopBackAddress(DnsSearchListItem.DNSServer) == true)
		{
			AlertEx(dnscfg_language['bbsp_ipx']+ DnsSearchListItem.DNSServer + dnscfg_language['bbsp_invalid']);
			return false;    
		}

		if (DnsSearchListItem.DNSServer.toUpperCase().substr(0, 4) == "FE80" || DnsSearchListItem.DNSServer.toUpperCase().substr(0, 4) == "FEC0" )
		{
			AlertEx(dnscfg_language['bbsp_ipx']+ DnsSearchListItem.DNSServer + dnscfg_language['bbsp_invalid']);
			return false;    
		} 			
		
	}   
	return true;
}

function DSLCheckItemRepeat(DnsSearchListItem)
{							
	var Dns_Search_List = GetDnsSearchList();
	var RecordCount = Dns_Search_List.length;
	var i = 0;
				
	 for(i=0;i<RecordCount;i++)
	 {
			if (DSLselctIndex != i)
			{
				if(DnsSearchListItem.Interface == DNS_NULL_INTERFACE_NAME)
				{
			    if((DnsSearchListItem.DomainName==Dns_Search_List[i].DomainName) 
             && ('' != Dns_Search_List[i].Interface ))
			    {
				    return true;	
			    }	
			    if ((DnsSearchListItem.DomainName==Dns_Search_List[i].DomainName) 
	           && (DnsSearchListItem.DNSServer==Dns_Search_List[i].DNSServer)
	           && ('' == Dns_Search_List[i].Interface ))	
	        {
	        	return true;	
	        }		
			  }else
			  {
			  	if((DnsSearchListItem.DomainName==Dns_Search_List[i].DomainName))
			    {
				    return true;	
			    }
			  }
		  }
		}
	
	return false;	
	
}

function SDNLCheckItemRepeat(safeDomainNameItem) {
    var safeDomNameList = GetSafeDomainNameList();
    var recordCount = safeDomNameList.length;

    for (var i = 0; i < recordCount; i++) {
        if ((safeDomNameList[i].domainName == safeDomainNameItem.domainName) && (SDNLselctIndex != i)) {
            return true;
        }
    }

    return false;
}

function DSLCheckParameter(DnsSearchListItem)
{ 
	if(DnsSearchListItem.DomainName == '' )
	{
		AlertEx(dnscfg_language['bbsp_domainisreq']);
		return false;
	}

		if(DnsSearchListItem.DNSServer == '' && DnsSearchListItem.Interface == DNS_NULL_INTERFACE_NAME)
	{
		AlertEx(dnscfg_language['bbsp_dnsisreq']);
		return false;
	}  
	if ( DnsSearchListItem.DNSServer != '' && (isValidIpAddress(DnsSearchListItem.DNSServer) == false || isAbcIpAddress(DnsSearchListItem.DNSServer) == false))
	{
			if(DSLCheckIpv6Adress(DnsSearchListItem) == false)
			{
				return false;
			}
	}      
			
	if(CheckDomainName(DnsSearchListItem.DomainName)==false)
	{
			AlertEx(dnscfg_language['bbsp_domaint'] + dnscfg_language['bbsp_invalidx']);
			return false;
	}

	return true;        
}

function SDNLCheckParameter(safeDomainNameListItem) {
    if (safeDomainNameListItem.domainName == '') {
        AlertEx(dnscfg_language['bbsp_domainisreq']);
        return false;
    }

    if (CheckDomainName(safeDomainNameListItem.domainName) == false) {
        AlertEx(dnscfg_language['bbsp_domaint'] + dnscfg_language['bbsp_invalidx']);
        return false;
    }

    return true;
}

function clickRemove() 
{
	return OnRemoveButtonClick();
}
	
function setControl(Index, LineId)
{
	var TableId = LineId.split('_')[0];
	if (DSLTableName == TableId)
	{
		DSLselctIndex = Index;
		if (Index < -1)
		{
			return;
		}
		if (Index == -1)
		{
			SetAddMode();
			if (GetDnsSearchList().length >= 32)
			{
				AlertEx(dnscfg_language['bbsp_dnscfgfull']);
				DSLOnCancelButtonClick();
				return false;
			}
			return DSLOnAddButtonClick();  
		}
		else
		{   
			SetEditMode();
			return DSLOnEditButtonClick(Index);
		}
    } else if (SDNLTableName == TableId) {
        SDNLselctIndex = Index;
        if (Index < -1) {
            return;
        }
        if (Index == -1) {
            SetAddMode();
            if (GetSafeDomainNameList().length >= 8) {
                AlertEx(dnscfg_language['bbsp_dnssafedomainfull']);
                SDNLOnCancelButtonClick();
                return false;
            }
            return SDNLOnAddButtonClick();
        } else {
            SetEditMode();
            return SDNLOnEditButtonClick(Index);
        }
	}
	else if (DHTableName == TableId)
	{
		DHselctIndex = Index;
        if (Index < -1)
        {
            return;
        }
        if (Index == -1)
        {
            SetAddMode();
            if (GetDnsHostsList().length >= 20)
            {
                AlertEx(dnscfg_language['bbsp_sdnsfull']);
                DSLOnCancelButtonClick();
                return false;
            }
            return OnAddButtonClick();  
        }
        else
        {   
            SetEditMode();
            return OnEditButtonClick(Index);
        }
	}
	
}
	
function DSLOnAddButtonClick()
{
	DSLBindPageData(new DnsSearchListItemClass("","","",""));
	setDisplay("DSLTableConfigInfo", 1);
	return false;   
}

function SDNLOnAddButtonClick() {
    SDNLBindPageData(new SafeDomainNameItemClass("", ""));
    setDisplay("SDNLTableConfigInfo", 1);
    return false;
}

function SDNLOnEditButtonClick(Index) {
    SDNLBindPageData(GetSafeDomainNameList()[Index]);
    setDisplay("SDNLTableConfigInfo", 1);
    return false;
}

function SDNLConfigListselectRemoveCnt(val) {
}

function DSLOnEditButtonClick(Index)
{	 
	DSLBindPageData(GetDnsSearchList()[Index]);
	setDisplay("DSLTableConfigInfo", 1);
	return false;           
}  

function DSLConfigListselectRemoveCnt(val)
{

}

function DeleteDomain(Form, strdomain)
{
	Form.addParameter(strdomain, '');
}
function OnDeleteButtonClick(TableID)
{    
	var TableId = TableID.split('_')[0];  
	var CheckBoxList = document.getElementsByName(TableId+"rml");
	var Form = new webSubmitForm();
	var Count = 0;
	for (var i = 0; i < CheckBoxList.length; i++)
	{
		if (CheckBoxList[i].checked == true)
		{
			 DeleteDomain(Form, CheckBoxList[i].value);
			 Count++;
		}
		
	}
	if( 0 != Count)
	{
		Form.setAction('del.cgi?x=InternetGatewayDevice.X_HW_DNS.HOSTS&RequestFile=html/bbsp/dnsconfiguration/dnsconfigcommon.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();	
		return true;
	}	
	 
}

function DSLOnApplyButtonClick()
{ 	
	var DnsSearchListItem = GetDnsSearchListData();
  
	if (DSLCheckParameter(DnsSearchListItem) == false)
	{
		return false;
	}
	
	if (DSLCheckItemRepeat(DnsSearchListItem) == true)
	{
		AlertEx(dnscfg_language['bbsp_dnscfgrepeat']);
		return true;
	}   
	
	var interface = '';
	if(DnsSearchListItem.Interface != DNS_NULL_INTERFACE_NAME) 
	{ 
		 interface = DnsSearchListItem.Interface;
	}

	var action = '';
	if( DSLselctIndex == -1 )
	{
		action = 'add.cgi?' +'x=InternetGatewayDevice.X_HW_DNS.SearList';
	}
	else
	{
		action = 'set.cgi?' +'x='+DnsSearchListItem.domain;
	}
	
	var Form = new webSubmitForm();
	var urlsubmit =  action + '&RequestFile=html/bbsp/dnsconfiguration/dnsconfigcommon.asp'; 
	Form.addParameter('x.DNSServer',  DnsSearchListItem.DNSServer);
    Form.addParameter('x.DomainName', DnsSearchListItem.DomainName);
    if (CfgMode.toUpperCase() == 'DBAA1') {
        Form.addParameter('x.WanServiceType', DnsSearchListItem.WanServiceType);
    } else {
        Form.addParameter('x.Interface', interface);
    }
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	setDisable("policybtnApply",1);
	setDisable("policycancelValue",1);  
	
	Form.setAction(urlsubmit);
	Form.submit();
	
	return true;
}

function DSLOnCancelButtonClick()
{
	var tableRow = getElementById(DSLTableName);
	if ((tableRow.rows.length > 2) && IsAddMode())
	{
		
		tableRow.deleteRow(tableRow.rows.length-1);
	}
	setDisplay("DSLTableConfigInfo", 0);
	return false;

}

function SDNLOnCancelButtonClick() {
    var tableRow = getElementById(SDNLTableName);
    if ((tableRow.rows.length > 2) && IsAddMode()) {
        tableRow.deleteRow(tableRow.rows.length-1);
    }
    setDisplay("SDNLTableConfigInfo", 0);
    return false;
}

function SDNLOnApplyButtonClick() {
    var safeDomainNameListItem = GetSafeDomainNameListData();

    if (SDNLCheckParameter(safeDomainNameListItem) == false) {
        return false;
    }

    if (SDNLCheckItemRepeat(safeDomainNameListItem) == true) {
        AlertEx(dnscfg_language['bbsp_dnssafedomainnamerepeat']);
        return true;
    }

    var action = '';
    if (SDNLselctIndex == -1) {
        action = 'add.cgi?' + 'x=InternetGatewayDevice.X_HW_DNS.AntiDNSRebind.SafeDomainName';
    } else {
        action = 'set.cgi?' + 'x=' + safeDomainNameListItem.domain;
    }

    var Form = new webSubmitForm();
    var urlsubmit =  action + '&RequestFile=html/bbsp/dnsconfiguration/dnsconfigcommon.asp';
    Form.addParameter('x.DomainName', safeDomainNameListItem.domainName);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    setDisable("SDNLButtonApply", 1);
    setDisable("SDNLButtonCancel", 1);

    Form.setAction(urlsubmit);
    Form.submit();

    return true;
}

function InitDSLTableList()
{
    for (var i = 0; i < DSLTableDataInfo.length - 1; i++) {
        DSLTableDataInfo[i].Interface = GetWanFullName(DSLTableDataInfo[i].Interface);
    }
}

function BindPageData(DnsHostsInfo)
{    
	setText("domain", DnsHostsInfo.domain);
	setText("IPAddress", DnsHostsInfo.IPAddress); 
	setText("DomainName", DnsHostsInfo.DomainName);  	
}


function GetDnsHostsData()
{
	var CurrentDomain = (GetDnsHostsList()[DHselctIndex] != null)?GetDnsHostsList()[DHselctIndex].domain:"";
	return new DnsHostsItemClass(CurrentDomain,getValue("IPAddress"), getValue("DomainName"));
}
	
function CheckIpv6Adress(DnsHostsItem)
{
	 if (DnsHostsItem.IPAddress != '' )
	{
		if ( IsIPv6AddressValid(DnsHostsItem.IPAddress) == false)
		{
			return false;
		}
		
		if (parseInt(DnsHostsItem.IPAddress.split(":")[0], 16) >= parseInt("0xFF00", 16))
		{
			return false;   
		} 

		if (IsIPv6ZeroAddress(DnsHostsItem.IPAddress) == true)
		{
		   return false;  
		}

		if (IsIPv6LoopBackAddress(DnsHostsItem.IPAddress) == true)
		{
			return false;    
		}

		if (DnsHostsItem.IPAddress.toUpperCase().substr(0, 4) == "FE80" || DnsHostsItem.IPAddress.toUpperCase().substr(0, 4) == "FEC0" )
		{
			return false;    
		} 			
		
	}   
	return true;
}

function CheckItemRepeat(DnsHostsItem)
{		
  	if( (DnsHostsItem.DomainName != '')&&(DnsHostsItem.IPAddress != ''))
	{					
	    var Dns_Host_List = GetDnsHostsList();
        var RecordCount = Dns_Host_List.length;
        var i = 0;
						
		for(i=0;i<RecordCount;i++)
		{
			if (DHselctIndex != i)
			{
				if((DnsHostsItem.DomainName==Dns_Host_List[i].DomainName) &&(DnsHostsItem.IPAddress==Dns_Host_List[i].IPAddress))
				{
					return true;	
				}				
			}
		}
	}
	
	return false;	
}

function IsSupportConfigLanDnsSever()
{
    if ((true == IsAdminUser()) && ('1' == TDEMode))     
    {
       return true;
    }
    return false;
}

function CheckParameter(DnsHostsItem)
{   
	if(DnsHostsItem.DomainName == '' )
	{
		AlertEx(dnscfg_language['bbsp_domainisreq']);
		return false;
	}

	if(DnsHostsItem.IPAddress == '' )
	{
		AlertEx(dnscfg_language['bbsp_ipisreq']);
		return false;
	}

	if ( DnsHostsItem.IPAddress != '' && (isValidIpAddress(DnsHostsItem.IPAddress) == false || isAbcIpAddress(DnsHostsItem.IPAddress) == false))
	{
			if(CheckIpv6Adress(DnsHostsItem) == false)
			{
				AlertEx(dnscfg_language['bbsp_ipx']+ DnsHostsItem.IPAddress + dnscfg_language['bbsp_invalid']);
				return false;
			}
	}       
					
	if(CheckDomainName(DnsHostsItem.DomainName)==false)
	{
		AlertEx(dnscfg_language['bbsp_domainx']+ DnsHostsItem.DomainName + dnscfg_language['bbsp_invalid']);
		return false;
	}   

	for (i = 0; i < GetDnsHostsList().length; i++)
	{	
		if (DHselctIndex != i)
		{
			if (DnsHostsListTemp[i].DomainName.toUpperCase() == DnsHostsItem.DomainName.toUpperCase() &&  DnsHostsItem.IPAddress != '' &&  DnsHostsListTemp[i].IPAddress != '' )
			{
				if((isAbcIpAddress(DnsHostsItem.IPAddress) == true &&  isAbcIpAddress(DnsHostsListTemp[i].IPAddress) == true)
				|| (CheckIpv6Adress(DnsHostsItem) == true &&  CheckIpv6Adress(DnsHostsListTemp[i]) == true))
				{
					AlertEx(dnscfg_language['bbsp_domainrepeat']);
					return false;
				}
			}
		}
		else
		{
			continue;
		}
	}
	return true;        
}

function OnAddButtonClick()
{
	
	BindPageData(new DnsHostsItemClass("","",""));
	setDisplay("TableConfigInfo", "1");
	return ;   
}


function OnEditButtonClick(Index)
{	    
	BindPageData(GetDnsHostsList()[Index]);
	setDisplay("TableConfigInfo", "1");
	return ;           
}

function DnsHostConfigListselectRemoveCnt(val)
{

}  

function OnApplyButtonClick()
{ 	
	var DnsHostsItem = GetDnsHostsData();
  
	if (CheckParameter(DnsHostsItem) == false)
	{
		return false;
	}
	
	if (CheckItemRepeat(DnsHostsItem) == true)
	{
		AlertEx(dnscfg_language['bbsp_sdnsrepeat']);
		return true;
	}   
	
	var action = '';
	if( DHselctIndex == -1 )
	{
		action = 'add.cgi?' +'x=InternetGatewayDevice.X_HW_DNS.HOSTS';
	}
	else
	{
		action = 'set.cgi?' +'x='+DnsHostsItem.domain;
	}
	
	var Form = new webSubmitForm();
	var urlsubmit =  action + '&RequestFile=html/bbsp/dnsconfiguration/dnsconfigcommon.asp'; 
	Form.addParameter('x.IPAddress',  DnsHostsItem.IPAddress);
	Form.addParameter('x.DomainName', DnsHostsItem.DomainName);
	Form.addParameter('x.X_HW_Token',   getValue('onttoken'));
	
	setDisable("policybtnApply",1);
	setDisable("policycancelValue",1);   
	
	Form.setAction(urlsubmit);
	Form.submit();
	return true;
}

function OnCancelButtonClick()
{
	if (GetDnsHostsList().length > 0 && IsAddMode())
	{
		var tableRow = getElementById(DHTableName);
		tableRow.deleteRow(tableRow.rows.length-1);
	}
	setDisplay("TableConfigInfo", "0");
	return false;
}


function SetDisableForm()
{
    var input = document.getElementsByTagName("input");

    for (var i = 0; i<input.length;i++)
    {
        input[i].disabled = true;
    }

    for (var j = 0; j < document.forms.length; j++) 
    {
        var form = document.forms[j];

        for (var k = 0; k < form.length; k++) 
        {
            form.elements[k].disabled = true;
        }
    }
}

function LoadFrame()
{
 	if ( null != DnspolicyInfo )
	{
	    setSelect('Dnspolicy',DnspolicyInfo.policy);
	}

	if(IsAdminUser() == false)
    {
	
    	setDisable("Dnspolicy",1);			
		setDisable("policybtnApply",1);
		setDisable("policycancelValue",1);
	}
    
    if (true == IsSupportConfigLanDnsSever())
    {
        setCheck('enableLanDnsSever', DnspolicyInfo.DnsServerEnable);
        
        if((DnspolicyInfo.DnsServerEnable) == 0)
        {
            SetDisableForm();
            setDisable("enableLanDnsSever",0);
            setDisable("policybtnApply",0);
            setDisable("policycancelValue",0);
            setDisable("Dnspolicy",1);
        }
    }
    
    if ((CfgMode.toUpperCase() == 'DETHMAXIS') && (curUserType != maxisNormalUser)) {
        setDisable("enableLanDnsSever",0);
        setDisable("policybtnApply",0);
        setDisable("policycancelValue",0);
        setDisable("Dnspolicy",0);
    }

	setDisplay('PolicyTableConfigInfo',1);
	loadlanguage();	

    setDisplay('divAntiDnsRebindAttack', antiDnsRebindFT);
    setCheck('antiDnsRebindAttack', isAntiDnsRebAtkEnable);
    setDisplay('SDNLConfigTable', isAntiDnsRebAtkEnable);
}

function PolicyOnApply()
{
	var val = getSelectVal('Dnspolicy');
	if("" == val)
	{
		AlertEx('please select a mode for dns policy!');
		return false;
	}
							 				
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = DnsPolicyConfigFormList;
	Parameter.SpecParaPair = null;
	var tokenvalue = getValue('onttoken'); 
	var url = 'set.cgi?' +'x=InternetGatewayDevice.X_HW_DNS' + '&RequestFile=html/bbsp/dnsconfiguration/dnsconfigcommon.asp';
	HWSetAction(null, url, Parameter, tokenvalue);
	setDisable('policybtnApply',1);
    setDisable('policycancelValue',1);
}

function CancelConfig()
{
    LoadFrame();
}

function OnAntiDnsRebindAttackClick() {
    var checked = getCheckVal('antiDnsRebindAttack');
    if (parseInt(checked, 10) == 1) {
         setDisplay('SDNLConfigTable', 1);
    } else {
        setDisplay('SDNLConfigTable', 0);
    }

    var Form = new webSubmitForm();
    var Enable = getElById("antiDnsRebindAttack").checked;
    if (Enable == true) {
        Form.addParameter('x.Enable',1);
    } else {
        Form.addParameter('x.Enable',0);
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DNS.AntiDNSRebind&RequestFile=html/bbsp/dnsconfiguration/dnsconfigcommon.asp');
    Form.submit();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("dnspolicytitleinfo", GetDescFormArrayById(dnscfg_language, "bbsp_mune"), GetDescFormArrayById(dnspolicy_language, "bbsp_dnspolicy_title"), false);
</script>
<div class="title_spread"></div>

<form id="PolicyTableConfigInfo" style="display:none;">
<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
<script>
if (true == IsSupportConfigLanDnsSever())
{
    document.write('<li id=\"enableLanDnsSever\" RealType=\"CheckBox\" DescRef=\"bbsp_enable_landns_server\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"x.DnsServerEnable\" InitValue=\"Empty\" InitValue=\"0\"   ClickFuncApp=\"onclick=configLanDnsSever\"/>');
}
</script>
<li   id="Dnspolicy"   RealType="DropDownList"     DescRef="bbsp_dnsmodemh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.LocalDNSPolicy"      InitValue="[{TextRef:'bbsp_DEFAULT',Value:'1'},{TextRef:'bbsp_PRIORITY',Value:'2'},{TextRef:'bbsp_INTERNET',Value:'3'}]" />                                                                   
</table>
<script LANGUAGE="JavaScript"> 
	 var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
	 DnsPolicyConfigFormList = HWGetLiIdListByForm("PolicyTableConfigInfo", null);
	 HWParsePageControlByID("PolicyTableConfigInfo", TableClass, dnspolicy_language, null);
	 getElById("Dnspolicy").title = dnspolicy_language['bbsp_dnshelp'];
</script>
<table cellpadding="0" cellspacing="1" width="100%" class="table_button"> 
<tr> 
  <td class="width_per25" ></td> 
  <td class="table_submit">
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	<button name="policybtnApply" id="policybtnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="PolicyOnApply();"><script>document.write(dnspolicy_language['bbsp_app']);</script></button> 
	<button name="policycancelValue" id="policycancelValue" class="CancleButtonCss buttonwidth_100px"  type="button" onClick="CancelConfig();"><script>document.write(dnspolicy_language['bbsp_cancel']);</script></button>
</td> 
</tr> 
</table> 
</form>

<div id="divAntiDnsRebindAttack">
<div class="func_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
<tr><td>
<script>document.write(dnscfg_language["bbsp_dns_anti_rebindattack_titlehead"]);</script>
</td></tr></table>

<form id="antiDnsRebindAttackForm" name="antiDnsRebindAttackForm">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li id="antiDnsRebindAttack" RealType="CheckBox" DescRef="bbsp_anti_dns_rebindattack" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty" ClickFuncApp="onclick=OnAntiDnsRebindAttackClick"/>
    </table>
    <script>
        var TableClass = new stTableClass("width_per40", "width_per60", "ltr");
        var antiDnsRebAtkFormList = new Array();
        antiDnsRebAtkFormList = HWGetLiIdListByForm("antiDnsRebindAttackForm",null);
        HWParsePageControlByID("antiDnsRebindAttackForm",TableClass,dnscfg_language,null);
    </script>
</form>

<div id="SDNLConfigTable">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
    <tr><td>
    <script>document.write(dnscfg_language["bbsp_dns_safe_domainnamecfg_titlehead"]);</script>
    </td></tr></table> 
    <script language="JavaScript" type="text/javascript">
        var SDNLTableClass = new stTableClass("width_per15", "width_per85", "ltr");
        var SDNLConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),
                                           new stTableTileInfo("bbsp_domain","align_center width_per40","domainName",false,30),null);
        var SDNLColumnNum = 2;
        var SDNLShowButtonFlag = true;
        var SDNLTableDataInfo = HWcloneObject(safeDomainNameList, 1);
        SDNLTableDataInfo.push(null);
        HWShowTableListByType(1, SDNLTableName, SDNLShowButtonFlag, SDNLColumnNum, SDNLTableDataInfo, SDNLConfiglistInfo, dnscfg_language, null);
    </script>

    <form id="SDNLTableConfigInfo" style="display:none;"> 
    <div class="list_table_spread"></div>
        <table border="0" cellpadding="0" cellspacing="1"  width="100%">
            <li   id="SDNLDomainName"    RealType="TextBox"          DescRef="bbsp_domainmh"         RemarkRef=""     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.DomainName"     Elementclass="InputDns"  InitValue="Empty" MaxLength="255"/>
        </table>
        <script language="JavaScript" type="text/javascript">
        HWParsePageControlByID("SDNLTableConfigInfo", SDNLTableClass, dnscfg_language, null);
        </script>

        <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
            <tr>
                <td width="15%">
                </td>
                <td class="table_submit pad_left5p" >
                    <button id="SDNLButtonApply"  type="button" onclick="SDNLOnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(dnscfg_language['bbsp_app']);</script></button>
                    <button id="SDNLButtonCancel" type="button" onclick="SDNLOnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px"><script>document.write(dnscfg_language['bbsp_cancel']);</script></button>
                </td>
            </tr>
        </table>
        <script></script>
    </form>
</div>
</div>

<div class="func_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
<tr><td>
<script>document.write(dnscfg_language["bbsp_dns_search_titlehead"]);</script>
</td></tr></table> 
<script language="JavaScript" type="text/javascript">
    var DSLTableClass = new stTableClass("width_per15", "width_per85", "ltr");
    var DSLConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),									
                                      new stTableTileInfo("bbsp_domain","align_center width_per40","DomainName",false,30),
                                      new stTableTileInfo("bbsp_waninterface","align_center width_per30 restrict_dir_ltr","Interface"),
                                      new stTableTileInfo("bbsp_dnssvr","align_center width_per30","DNSServer"),null);
    if (CfgMode.toUpperCase() == 'DBAA1') {
        DSLConfiglistInfo = new Array(new stTableTileInfo("Empty", "align_center width_per5", "DomainBox"),
                                      new stTableTileInfo("bbsp_domain", "align_center width_per40", "DomainName", false, 30),
                                      new stTableTileInfo("bbsp_wanTypeService", "align_center width_per30 restrict_dir_ltr", "WanServiceType"),
                                      new stTableTileInfo("bbsp_dnssvr", "align_center width_per30", "DNSServer"), null);
    }
    var DSLColumnNum = 4;

	var DSLShowButtonFlag = true;
	var DSLTableConfigInfoList = new Array();
	var DSLTableDataInfo = HWcloneObject(DnsSearchList, 1);
	DSLTableDataInfo.push(null);
	InitDSLTableList();
	HWShowTableListByType(1, DSLTableName, DSLShowButtonFlag, DSLColumnNum, DSLTableDataInfo, DSLConfiglistInfo, dnscfg_language, null);
</script>

<form id="DSLTableConfigInfo" style="display:none;"> 
<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%">
		<li   id="DSLdomain"        RealType="TextBox"          DescRef="Instance"         RemarkRef=""     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.domain"      InitValue="Empty" MaxLength="255"/>
		<li   id="DSLDomainName"    RealType="TextBox"          DescRef="bbsp_domainmh"         RemarkRef=""     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.DomainName"     Elementclass="InputDns"  InitValue="Empty" MaxLength="255"/>
        <script language="JavaScript" type="text/javascript">
            if (CfgMode.toUpperCase() == "DBAA1") {
                document.write('<li   id="WanTypeList"   RealType="DropDownList"     DescRef="bbsp_wantype"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.WanServiceType"    Elementclass="SelectDns"  InitValue="Empty"/>');
            } else {
                if (exchangeWan == "1") {
                    document.write('<li   id="WanNameList"   RealType="DropDownList"     DescRef="bbsp_wanservices"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"    Elementclass="SelectDns"  InitValue="Empty"/>');
                } else {
                    document.write('<li   id="WanNameList"   RealType="DropDownList"     DescRef="bbsp_waninterfacemh"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"    Elementclass="SelectDns"  InitValue="Empty"/>');
                }
            }
        </script>
		<li   id="DNSServer"     RealType="TextBox"          DescRef="bbsp_dnssvrmh"         RemarkRef=""     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DNSServer"     Elementclass="InputDns"  InitValue="Empty" MaxLength="39"/>
	</table>
	<script language="JavaScript" type="text/javascript">
	DSLConfigFormList = HWGetLiIdListByForm("DSLTableConfigInfo", DnsSearchListReload);
	HWParsePageControlByID("DSLTableConfigInfo", DSLTableClass, dnscfg_language, DnsSearchListReload);
	function IsRouteWan(Wan)
	{
	    if (viettelflag ==1)
	    {
	        if (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
	        {
	            return false;
	        }
	    } 		
		if (Wan.Mode =="IP_Routed")
		{
			return true;
		} 
		return false;
	}
    if (CfgMode.toUpperCase() == 'DBAA1') {
        var WanTypeListCtl = getElById("WanTypeList");
        var optionValueList = ['TR069', 'INTERNET', 'VOIP', 'IPTV', 'OTHER'];
        var optionResIdList = ['bbsp_Tr069', 'bbsp_Internet', 'bbsp_Voip', 'bbsp_Iptv', 'bbsp_Other'];
        for (var i = 0; i < optionValueList.length; i++) {
            Option = document.createElement("Option");
            Option.value = optionValueList[i];
            Option.innerText = dnscfg_language[optionResIdList[i]];
            Option.text = dnscfg_language[optionResIdList[i]];
            WanTypeListCtl.appendChild(Option);
        }
    } else if (exchangeWan == "1") {
		var Control = getElById("WanNameList");
		var Option = document.createElement("Option");
		Option.value = "eRouter";
		Option.innerText = "eRouter";
		Option.text = "eRouter";
		Control.appendChild(Option);
		
		Option = document.createElement("Option");
		Option.value = "eMTA";
		Option.innerText = "eMTA";
		Option.text = "eMTA";
		Control.appendChild(Option);
		
		Option = document.createElement("Option");
		Option.value = "eSTB";
		Option.innerText = "eSTB";
		Option.text = "eSTB";
		Control.appendChild(Option);
		
		Option = document.createElement("Option");
		Option.value = "INTERNET";
		Option.innerText = "INTERNET";
		Option.text = "INTERNET";
		Control.appendChild(Option);
		
		Option = document.createElement("Option");
		Option.value = "TR069_IPTV";
		Option.innerText = "TR069_IPTV";
		Option.text = "TR069_IPTV";
		Control.appendChild(Option);
		
		Option = document.createElement("Option");
		Option.value = "VoIP";
		Option.innerText = "VoIP";
		Option.text = "VoIP";
		Control.appendChild(Option);
		
		Option = document.createElement("Option");
		Option.value = "INTERNET_TR069_IPTV_VoIP";
		Option.innerText = "INTERNET_TR069_IPTV_VoIP";
		Option.text = "INTERNET_TR069_IPTV_VoIP";
		Control.appendChild(Option);
	} else {
		InitWanNameListControl("WanNameList", IsRouteWan);
	}
	</script>

	<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
		<tr>
			<td width="15%">
			</td>
			<td class="table_submit pad_left5p" >
				<button id="DSLButtonApply"  type="button" onclick="DSLOnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(dnscfg_language['bbsp_app']);</script></button>
				<button id="DSLButtonCancel" type="button" onclick="DSLOnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px"><script>document.write(dnscfg_language['bbsp_cancel']);</script></button>
			</td>
		</tr>
	</table>
</form> 
<div class="func_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
<tr><td>
<script>document.write(dnscfg_language["bbsp_dns_host_titlehead"]);</script>
</td></tr></table>
<script language="JavaScript" type="text/javascript">
	TableClass = new stTableClass("width_per15", "width_per85", "ltr");
	var DnsHostConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),									
									new stTableTileInfo("bbsp_domain","align_center width_per60","DomainName",false,50),
									new stTableTileInfo("bbsp_ip","align_center width_per40","IPAddress"),null);
									
	var ColumnNum = 3;
	var ShowButtonFlag = true;
	var DnsHostTableConfigInfoList = new Array();
	var TableDataInfo = HWcloneObject(DnsHostsList, 1);
	TableDataInfo.push(null);
	HWShowTableListByType(1, DHTableName, ShowButtonFlag, ColumnNum, TableDataInfo, DnsHostConfiglistInfo, dnscfg_language, null);
</script>
 
<form id="TableConfigInfo" style="display:none"> 
<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="domain"        RealType="TextBox"          DescRef="Instance"         RemarkRef=""     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.domain"      InitValue="Empty" MaxLength="255" datatype="int" minvalue="0" maxvalue="253" default="0" />
		<li   id="DomainName"    RealType="TextBox"          DescRef="bbsp_domainmh"         RemarkRef=""     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.DomainName"     Elementclass="InputDns"  InitValue="Empty" MaxLength="255"/>
		<li   id="IPAddress"     RealType="TextBox"          DescRef="bbsp_ipmh"         RemarkRef=""     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.IPAddress"   Elementclass="InputDns"    InitValue="Empty" MaxLength="39"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		DnsHostConfigFormList = HWGetLiIdListByForm("TableConfigInfo", DnsHostReload);
		HWParsePageControlByID("TableConfigInfo", TableClass, dnscfg_language, DnsHostReload);
	</script>
	<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
		<tr>
			<td class="width_per15">
			</td>
			<td class="table_submit pad_left5p" >
				<button id="ButtonApply"  type="button" onclick="OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(dnscfg_language['bbsp_app']);</script></button>
				<button id="ButtonCancel" type="button" onclick="OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(dnscfg_language['bbsp_cancel']);</script></button>
			</td>
		</tr>
	</table>
</form>
<div class="func_spread"></div>

</body>
</html>
