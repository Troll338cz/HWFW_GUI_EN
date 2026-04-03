<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>DDNS</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<style>
.SelectDdns{
	width: 260px;
}
.SelectWanName{
	width: 260px;
	direction:ltr;
}
.InputDdns{
	width: 254px;
}
</style>
<script language="JavaScript" type="text/javascript">

var PcpFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PCP);%>';  
var AddFlag = true;
var TableName = "DdnsConfigList";
var IsNeedAdvancedSet = 0;

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
		b.innerHTML = ddns_language[b.getAttribute("BindText")];
	}
}


function filterWan(WanItem)
{	
	return true;
}

function InitWanNameListForDDNS()
{
    if (AddFlag == true)
    {
       var WANNamelist = getElementById("WANName");
		WANNamelist.options.length = 0;
		InitWanNameListControl2("WANName", function(item){
            if (item.ServiceList != 'TR069' 
                && item.ServiceList != 'VOIP'
                && item.ServiceList != 'TR069_VOIP'
                && item.Mode == 'IP_Routed'
                && item.IPv4Enable == '1'
                && item.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0
                && item.Name != 'Mobile')
            {return true;}else{return false;}
            });        
    }
	else if (PcpFlag == 1)
	{
	   var WANNamelist = getElementById("WANName");
	   WANNamelist.options.length = 0;
	   InitWanNameListControl2("WANName", function(item)
	   {
			if ((item.ServiceList != 'TR069' 
			    && item.ServiceList != 'VOIP'
                && item.ServiceList != 'TR069_VOIP'
				&& item.Mode == 'IP_Routed'
				&& item.IPv4Enable == '1')
				||(item.ServiceList != 'TR069' 
				&& item.ServiceList != 'VOIP'
                && item.ServiceList != 'TR069_VOIP'
				&& item.Mode == 'IP_Routed'
				&&(item.IPv6Enable =="1") 
				&&(item.IPv6DSLite == "Dynamic" || item.IPv6DSLite == "Static")))
			{
			    return true;
			}
			else
			{
			    return false;
			}
		});
	}
    else
    {
	  	var WANNamelist = getElementById("WANName");
	  	WANNamelist.options.length = 0;
		InitWanNameListControl2("WANName", function(item){
			if (item.ServiceList != 'TR069'
				&& item.ServiceList != 'VOIP'
                && item.ServiceList != 'TR069_VOIP' 
				&& item.Mode == 'IP_Routed'
				&& item.IPv4Enable == '1')
			{return true;}else{return false;}
		});
    }
}

var wans = GetWanListByFilter(filterWan);

function stDdns(domain,Enable,Provider,Username,Port,DomainName,HostName,SaltAddress, SuccessUpdateInterval, FailRetryTimes, Status, LastError)
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
    this.SuccessUpdateInterval = SuccessUpdateInterval;
    this.FailRetryTimes = FailRetryTimes;
    this.Status    = Status;
    this.LastError = LastError;
}

var WanIPDdns = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_DDNSConfiguration.{i},DDNSCfgEnabled|DDNSProvider|DDNSUsername|ServicePort|DDNSDomainName|DDNSHostName|SaltAddress|SuccessUpdateInterval|FailRetryTimes|Status|LastError,stDdns);%>;
var WanPPPDdns = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_DDNSConfiguration.{i},DDNSCfgEnabled|DDNSProvider|DDNSUsername|ServicePort|DDNSDomainName|DDNSHostName|SaltAddress|SuccessUpdateInterval|FailRetryTimes|Status|LastError,stDdns);%>;

function FindWanInfoByDdns(ddnsItem)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < wans.length; k++ )
	{
		wandomain_len = wans[k].domain.length;
		temp_domain = ddnsItem.domain.substr(0, wandomain_len);
		
		if (temp_domain == wans[k].domain)
		{
			return wans[k];
		}
	}	
	return null;
}

var Ddns = new Array();
var Idx = 0;

for (i = 0; i < WanIPDdns.length-1; i++)
{
    var tmpWan = FindWanInfoByDdns(WanIPDdns[i]);  
	
	if (tmpWan == null)
    {
        continue;
    }

    if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.Mode == 'IP_Routed')
	{
		Ddns[Idx] = WanIPDdns[i];
		Ddns[Idx].name = MakeDdnsName(WanIPDdns[i].domain);
		Ddns[Idx].wanins = MakeDdnsWanIns(WanIPDdns[i].domain);
		Idx ++;
	}
}
for (j = 0; j < WanPPPDdns.length-1; j++,i++)
{
	var tmpWan = FindWanInfoByDdns(WanPPPDdns[j]);  
	
	if (tmpWan == null)
    {
        continue;
    } 

	if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.Mode == 'IP_Routed')
	{
		Ddns[Idx] = WanPPPDdns[j];
		Ddns[Idx].name = MakeDdnsName(WanPPPDdns[j].domain);
		Ddns[Idx].wanins = MakeDdnsWanIns(WanPPPDdns[j].domain);   
		Idx ++;
	}  
}

function MakeDdnsName(DdnsDomain)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < wans.length; k++ )
	{
		wandomain_len = wans[k].domain.length;
		temp_domain = DdnsDomain.substr(0, wandomain_len);
		if (temp_domain == wans[k].domain)
		{
			return MakeWanName1(wans[k]);
		}
	}
}

function MakeDdnsWanIns(DdnsDomain)
{
	var wandomain_len = 0;
	var temp_domain = null;
	for(var k = 0; k < wans.length; k++ )
	{
		wandomain_len = wans[k].domain.length;
		temp_domain = DdnsDomain.substr(0, wandomain_len);
		if (temp_domain == wans[k].domain)
		{
			return temp_domain;
		}
	}
}

function WriteOption()
{
    var k;

	for (k = 0; k < wans.length; k++)
	{
	   if (wans[k].ServiceList != 'TR069' && wans[k].Mode == 'IP_Routed')
	   {
	   document.write('<option value="' + wans[k].domain + '">' 
					+ MakeWanName1(wans[k]) + '</option>');	 					
	   }	   	 					
	}	
}

function isVaildDomainHost(val)
{
    return true;
}

function btnAdd(place) 
{
    var loc = place + '?action=add';

    with ( document.forms[0] ) 
    {      
        loc += '&service=' + ispname[ispname.selectedIndex].value;
        loc += '&iface=' + ifc[ifc.selectedIndex].value;
        loc += '&hostname=' + domainname.value;
        loc += '&username=' + DDNSUsername.value;
        loc += '&password=' + password.value;
        loc += '&domainname=' + domainname.value;
        if (ispname.selectedIndex == 1)
        {
			loc += '&protocol=' + infoprotocol[infoprotocol.selectedIndex].value;
			loc += '&serveraddr=' + infoserveraddress.value;
		}
		else
		{
			loc += '&protocol=' + 'GNUDip.http';
			loc += '&serveraddr=' + DDNSServer.value;
		}
    }
    var code = 'location="' + loc + '"';
    dealDataWithStr(code);
}

function DdnsConfigListselectRemoveCnt(val)
{
	var checkname = val.name;	
}

function OnDeleteButtonClick(TableID)
{ 
	if (Ddns.length == 0)
	{
	    AlertEx(ddns_language['bbsp_noddns']);
	    return;
	}
	
	var rml = document.getElementsByName(TableName + 'rml');
    var SubmitForm = new webSubmitForm();	 
	var Count = 0;
	for (var i = 0; i < rml.length; i++)
	{
		if (rml[i].checked != true)
		{
			continue;
		}
		
		Count++;
		SubmitForm.addParameter(rml[i].value,'');
	}
	if (Count <= 0)
	{
		AlertEx(ddns_language['bbsp_selectddns']);
		return false;
	}
	
	if (ConfirmEx(ddns_language['bbsp_deldns']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
	    return;
    }	
	
   SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
   SubmitForm.setAction('del.cgi?RequestFile=html/bbsp/ddns/ddnsptvdf.asp');   
   SubmitForm.submit();
}

function LoadFrame()
{
	if (Ddns.length > 0)
    {
 	    selectLine(TableName + '_record_0');  
        setDisplay('TableConfigInfo',1);
    }	
    else
    {	
 	    selectLine('record_no');     
        setDisplay('TableConfigInfo',0);
    }

    IsNeedAdvancedSet = 0;
    
    setDisplay('SaltAddressRow',0);
    setDisplay('DDNSHostNameRow',0);
    setDisplay('DDNSServicePortRow',0);
    setDisplay('DDNSUpdateIntervalRow',0); 
    setDisplay('DDNSRetryTimesRow',0);    
    setDisplay('DDNSEncryptRow',0); 

    setDisable('DDNSStatus',1);
    setDisable('DDNSLastError',1);
    
	loadlanguage();
}

function checkeMail(mail)
{
    return(new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(mail));
}

function CheckForm()
{ 
	var selectObj = getElement('WANName');
    var index = 0;
    var idx = 0;
	var count = 0;
	var i = 0;
             
    if ( selectObj.selectedIndex < 0 )
    {
        AlertEx(ddns_language['bbsp_creatwan']);
        return false;
    } 

	if (AddFlag == true)
	{
	    for (i = 0; i < Ddns.length; i++)
		{  
			  if (Ddns[i].wanins == getSelectVal("WANName"))
			  {
				count++;
			  }
		} 
		if (count >= 4)
		{
			AlertEx(ddns_language['bbsp_fourdns']);
			return false;        
		}
	}

    with (getElement('TableConfigInfo'))
    {
        if (DDNSProvider.value == "")
        {
			AlertEx(ddns_language['bbsp_providerisreq']);
            return false;  
        }

        if (DDNSHostName.value == "")
        {
			AlertEx(ddns_language['bbsp_hostisreq']);
            return false;            
        }

		DDNSHostName.value = removeSpaceTrim(DDNSHostName.value);
		if(CheckDomainName(DDNSHostName.value) == false)
		{			
		    AlertEx(ddns_language['bbsp_hostx'] + DDNSHostName.value +  ddns_language['bbsp_invalid']);
			return false;
		}

        if (DDNSServicePort.value == "")
        {
			AlertEx(ddns_language['bbsp_portidreq']);
            return false;            
        }
        else if (DDNSServicePort.value.charAt(0) == '0')
		{
		    AlertEx(ddns_language['bbsp_portinvalid']);
            return false; 
		}	

        if(isValidPort(DDNSServicePort.value) == false)
		{			
            AlertEx(ddns_language['bbsp_portinvalid']);
			return false;
		}		
		if (DDNSDomainName.value == "")
        {
	        AlertEx(ddns_language['bbsp_domainisreq']);
            return false;
        }		
		DDNSDomainName.value = removeSpaceTrim(DDNSDomainName.value);
		if (DDNSProvider.value == 'no-ip')
		{
			if(CheckMultDomainName(DDNSDomainName.value) == false)
			{	
			   AlertEx(ddns_language['bbsp_domainx'] + DDNSDomainName.value +  ddns_language['bbsp_invalid']);			
			   return false;
			}
		}
		else
		{
			if(CheckDomainName(DDNSDomainName.value) == false)
			{			
				AlertEx(ddns_language['bbsp_domainx'] + DDNSDomainName.value +  ddns_language['bbsp_invalid']);
				return false;
			}
		}

		if (DDNSUsername.value == "") 
		{
		   AlertEx(ddns_language['bbsp_userisreq']);
		   return false;
		}
		
		if (isValidAscii(DDNSUsername.value) != '')         
		{  
			AlertEx(Languages['IPv4UserName1'] + Languages['Hasvalidch'] + isValidAscii(DDNSUsername.value) + ddns_language['bbsp_sign']);          
			return false;       
		}

        if (!isInteger(DDNSUpdateInterval.value) || DDNSUpdateInterval.value < 7200 || DDNSUpdateInterval.value  > 2592000)
        {
            AlertEx(ddns_language['bbsp_invalidpara']);
            return false;
        }

        if (!isInteger(DDNSRetryTimes.value) || DDNSRetryTimes.value < 0 || DDNSRetryTimes.value  > 65535)
        {
            AlertEx(ddns_language['bbsp_invalidpara']);
            return false;
        }
        
        for (i = 0; i < Ddns.length; i++)
        {
            if (selctIndex != i)
            {
                if (DDNSDomainName.value == Ddns[i].DDNSDomainName)
                   {
				      AlertEx(ddns_language['bbsp_ddnsrepeat']);
			          return false;                           
                   }
            }
        }
	}

	setDisable('btnApply_ex', 1);
	return true;
}

function AddSubmitParam()
{
	if (false == CheckForm())
	{
		return;
	}
    var DomainPrefix = getSelectVal('WANName')+'.X_HW_DDNSConfiguration';
	var url;
	var SpecDdnsConfigParaList = new Array();
	
    with (getElement ("TableConfigInfo"))
    {
		SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSCfgEnabled",getCheckVal('DDNSCfgEnabled'), 1));
		SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSProvider",getValue('DDNSProvider'), 1));
      	SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSUsername",getValue('DDNSUsername'), 1));        
       
        if (getValue('DDNSPassword') != '********************************')
        {
			SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSPassword",getValue('DDNSPassword'), 1));    
        } 
       
		SpecDdnsConfigParaList.push(new stSpecParaArray("x.ServicePort",getValue('DDNSServicePort'), 1));    
		SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSDomainName",getValue('DDNSDomainName'),1));  
        SpecDdnsConfigParaList.push(new stSpecParaArray("x.DDNSHostName",getValue('DDNSHostName'), 1)); 
        SpecDdnsConfigParaList.push(new stSpecParaArray("x.SuccessUpdateInterval",getValue('DDNSUpdateInterval'), 1)); 
        SpecDdnsConfigParaList.push(new stSpecParaArray("x.FailRetryTimes",getValue('DDNSRetryTimes'), 1)); 
        if (getValue('DDNSProvider') == "gnudip.http")
        {
			SpecDdnsConfigParaList.push(new stSpecParaArray("x.SaltAddress",getValue('SaltAddress'), 1));
        }      
    }
	
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = DdnsConfigFormList;
	Parameter.SpecParaPair = SpecDdnsConfigParaList;
	var tokenvalue = getValue('onttoken');	
	if ( AddFlag == true )
	{
		url = 'add.cgi?x=' + DomainPrefix
						   +'&RequestFile=html/bbsp/ddns/ddnsptvdf.asp';
	}
	else
	{
		url = 'set.cgi?x=' + Ddns[selctIndex].domain
						   +'&RequestFile=html/bbsp/ddns/ddnsptvdf.asp';
	}
	HWSetAction(null, url, Parameter, tokenvalue);
	setDisable('btnApply_ex',1);
    setDisable('cancelValue',1);	
}

function getDdnsEncryptAlgorithm(servProvider)
{
	var ret = 'BASE64';
	
	if ((servProvider == 'gnudip') || (servProvider == 'gnudip.http'))
	{
		ret = 'MD5';
	}
	else if (servProvider == 'dtdns')
	{
		ret = ddns_language['bbsp_noencryptmh'];
	}
	else if (servProvider == '')
	{
		ret = '';
	}
	
	return ret;
}

function OnAdvancedSet()
{
    IsNeedAdvancedSet = 1 - IsNeedAdvancedSet;

	with (document.forms[0])
    {   
        setDisplay('SaltAddressRow', 0);

        if (DDNSProvider.value == 'gnudip.http')
        {							    
            setDisplay('SaltAddressRow', IsNeedAdvancedSet);
        }

        setDisplay('DDNSHostNameRow',    IsNeedAdvancedSet);		
        setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);	
        setDisplay('DDNSEncryptRow',     IsNeedAdvancedSet);
        setDisplay('DDNSUpdateIntervalRow',IsNeedAdvancedSet); 
        setDisplay('DDNSRetryTimesRow',IsNeedAdvancedSet);
        
        DDNSEncrypt.value = getDdnsEncryptAlgorithm(DDNSProvider.value);
        setDisable('DDNSEncrypt',1);
    }

    return;
}

function LastErrorTranslate(LastError)
{
    var errorArray = new Array('None', 'Authentication error', 'Service not available', 'No Internet connection', 'Other');
    var errorString = new Array('bbsp_none', 'bbsp_auth', 'bbsp_service', 'bbsp_connect', 'bbsp_othererror');
    var index = 0;
    var error_index = 0;
    for (index = 0; index < errorArray.length; index++)
    {
        if (LastError.match(errorArray[index]) != null)
        {
            error_index = errorString[index];
            break;
        }
    }

    if (index > 4)
    {
        return LastError;
    }

    if (index == 4)
    {
        return ddns_language[error_index] + LastError.substr(5, LastError.length);   
    }
    
    return ddns_language[error_index];
}

function ISPChange()
{
	with (document.forms[0])
	{
		setDisplay('DDNSProtocolRow', 0);
		setDisplay('SaltAddressRow', 0);
		SaltAddress.value = '';
		if (DDNSProvider.value == 'dyndns')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);	
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);		
			DDNSHostName.value = 'members.dyndns.org';
			DDNSServicePort.value = '80';
		}
		else if (DDNSProvider.value == 'dyndns-static')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = 'members.dyndns.org';
			DDNSServicePort.value = '80';
		}
		else if (DDNSProvider.value == 'dyndns-custom')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = 'members.dyndns.org';
			DDNSServicePort.value = '80';
		}		
		else if (DDNSProvider.value == 'qdns')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = 'members.3322.org';
			DDNSServicePort.value = '80';
		}
		else if (DDNSProvider.value == 'qdns-static')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = 'members.3322.org';
			DDNSServicePort.value = '80';
		}
		else if (DDNSProvider.value == 'gnudip')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = '';
			DDNSServicePort.value = '3459';
		}
		else if (DDNSProvider.value == 'gnudip.http')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
			setDisplay('isDDNSServer', IsNeedAdvancedSet);			
			setDisplay('isDDNSServerPort', IsNeedAdvancedSet);
			DDNSHostName.value = '';
			DDNSServicePort.value = '80';
			SaltAddress.value = '/cgi-bin/gdipupdt.cgi';
			setDisplay('SaltAddressRow', IsNeedAdvancedSet);
		}
		else if (DDNSProvider.value == 'no-ip')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = 'dynupdate.no-ip.com';
			DDNSServicePort.value = '80';
		}
		else if (DDNSProvider.value == 'dtdns')
		{			
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = 'www.dtdns.com';
			DDNSServicePort.value = '80';
		}
		else if (DDNSProvider.value == '')
		{
			DDNSUsername.value = '';
			DDNSPassword.value = '';					    
		    setDisplay('DDNSHostNameRow', IsNeedAdvancedSet);			
		    setDisplay('DDNSServicePortRow', IsNeedAdvancedSet);
			DDNSHostName.value = '';
			DDNSServicePort.value = '';
		}

	    setDisplay('DDNSEncryptRow', IsNeedAdvancedSet);
        setDisplay('DDNSUpdateIntervalRow',IsNeedAdvancedSet); 
        setDisplay('DDNSRetryTimesRow',IsNeedAdvancedSet);       
		DDNSEncrypt.value = getDdnsEncryptAlgorithm(DDNSProvider.value);
        DDNSUpdateInterval.value = 86400;    
        DDNSRetryTimes.value = 0;    
		setDisable('DDNSEncrypt',1);
        setDisable('DDNSStatus',1);
        setDisable('DDNSLastError',1);
	}
}

function setCtlDisplay(record)
{	
    var endIndex = record.domain.lastIndexOf('X_HW_DDNSConfiguration') - 1;
	var Interface = record.domain.substring(0,endIndex);
	InitWanNameListForDDNS();
    setSelect('WANName',Interface);
    setSelect('DDNSProvider',record.DDNSProvider); 
	setText('DDNSDomainName',record.DDNSDomainName);
	setText('DDNSHostName',record.DDNSHostName);
	setText('DDNSUsername',record.DDNSUsername);
	setText('DDNSPassword',record.Password);
	setText('DDNSServicePort',record.ServicePort);	
    setCheck('DDNSCfgEnabled', record.DDNSCfgEnabled);
	
    setText('SaltAddress',record.SaltAddress);
    setText('DDNSUpdateInterval', record.SuccessUpdateInterval);    
    setText('DDNSRetryTimes', record.FailRetryTimes);    

	setText('DDNSEncrypt', getDdnsEncryptAlgorithm(record.DDNSProvider));
	if (record.Status != '')
	{
     	setText('DDNSStatus',  (record.Status == 'Up') ? ddns_language["bbsp_up"] : ddns_language["bbsp_down"]); 
 	}
 	else
 	{
 	    setText('DDNSStatus', '');
 	}
 	
 	if (record.LastError != '')
 	{
    	setText('DDNSLastError', LastErrorTranslate(record.LastError));
    }
    else
    {
    	setText('DDNSLastError', '');    
    }
	setDisable('DDNSEncrypt',1);
    setDisable('DDNSStatus',1);
    setDisable('DDNSLastError',1);   

    setDisplay('SaltAddressRow', 0);

    if (record.SaltAddress == 'gnudip.http')
    {							    
        setDisplay('SaltAddressRow', IsNeedAdvancedSet);
    }
    
    setDisplay('DDNSHostNameRow',IsNeedAdvancedSet);
    setDisplay('DDNSServicePortRow',IsNeedAdvancedSet);
    setDisplay('DDNSUpdateIntervalRow',IsNeedAdvancedSet); 
    setDisplay('DDNSRetryTimesRow',IsNeedAdvancedSet);     
    setDisplay('DDNSEncryptRow',IsNeedAdvancedSet);
    
}

function setControl(index)
{
    var record;
    var endIndex;

    selctIndex = index;
    setDisable('btnApply_ex',0);
    setDisable('cancelValue',0);
    if (index == -1)
    {
        if(Ddns.length >= 8)
	    {	        
		    AlertEx(ddns_language['bbsp_ddnsfull']);
		    CancelConfig();
		    return;
	    }
    	setDisable('WANName', 0);
    	AddFlag = true;
        record = new stDdns('','0','dyndns','','80','','members.dyndns.org','', 86400, 0, '', '');
        setDisplay('TableConfigInfo', 1);        
        setCtlDisplay(record);
    }
    else if (index == -2)
    {
        setDisplay('TableConfigInfo', 0);
    }
    else
    {
    	setDisable('WANName', 1);
    	AddFlag = false;
        record = Ddns[index];
        setDisplay('TableConfigInfo', 1);
        setCtlDisplay(record);
    }

}
      
function CancelConfig()
{
    setDisplay("TableConfigInfo", 0);
   
	if (selctIndex == -1)
    {
        var tableRow = getElement("DdnsConfigList");
        
        if (tableRow.rows.length == 1)
        {
            selectLine('record_no');
        }
        else if (tableRow.rows.length == 2)
        {
        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
        }
    }
    else
    {
        var record = Ddns[selctIndex];
        setCtlDisplay(record);
    } 
}

function InitDDNSProvider()
{
    $("#DDNSProvider").append('<option value=' + "dyndns" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_dyndns'] + '</option>');
	$("#DDNSProvider").append('<option value=' + "dyndns-static" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_dyndns_static'] + '</option>');
	$("#DDNSProvider").append('<option value=' + "dyndns-custom" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_dyndns_custom'] + '</option>');
	$("#DDNSProvider").append('<option value=' + "qdns" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_qdns'] + '</option>');
	$("#DDNSProvider").append('<option value=' + "qdns-static" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_qdns_static'] + '</option>');

    $("#DDNSProvider").append('<option value=' + "gnudip" + ' id="'
                    + i + '">'
                    +ddns_language['bbsp_gnudip'] + '</option>');
    $("#DDNSProvider").append('<option value=' + "gnudip.http" + ' id="'
                    + i + '">'
                    +ddns_language['bbsp_gnudiphttp_gl'] + '</option>');

    $("#DDNSProvider").append('<option value=' + "no-ip" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_no_ip'] + '</option>');
	$("#DDNSProvider").append('<option value=' + "dtdns" + ' id="'
                        + i + '">'
                        +ddns_language['bbsp_dtdns'] + '</option>');	
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("ddns", GetDescFormArrayById(ddns_language, "bbsp_mune"), GetDescFormArrayById(ddns_language, "bbsp_ddns_title"), false)
</script>
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
	var DdnsConfiglistInfo = new Array();
	DdnsConfiglistInfo.push(new stTableTileInfo("Empty","align_center width_per5","DomainBox"));
	DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_wanname","align_center width_per20 restrict_dir_ltr","name"));
	DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_enable_status","align_center width_per20","DDNSCfgEnabled"));
	DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_provider","align_center width_per20","DDNSProvider"));
	DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_domain","align_center width_per20","DDNSDomainName", false, 32));
	DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_state","align_center width_per20","Status"));    
	DdnsConfiglistInfo.push(new stTableTileInfo(null));

	var ColumnNum = 6;
	var ShowButtonFlag = true;
	var DdnsConfigFormList = new Array();
	var TableDataInfo =  HWcloneObject(Ddns, 1);
	TableDataInfo.push(null);
	for (var i = 0; i < TableDataInfo.length - 1; i++)
	{
		TableDataInfo[i].DDNSCfgEnabled = TableDataInfo[i].DDNSCfgEnabled == 1 ? ddns_language["bbsp_enable"] : ddns_language["bbsp_disable"];
		TableDataInfo[i].DDNSDomainName = TableDataInfo[i].DDNSDomainName;	
        TableDataInfo[i].Status = (TableDataInfo[i].Status == 'Up') ? ddns_language["bbsp_up"] : ddns_language["bbsp_down"]
	}
	
	HWShowTableListByType(1, "DdnsConfigList", ShowButtonFlag, ColumnNum, TableDataInfo, DdnsConfiglistInfo, ddns_language, null);
	for (var i = 0; i < Ddns.length; i++)
	{
		var id = 'DdnsConfigList_' + i +'_4';
		document.getElementById(id).title = ShowNewRow(Ddns[i].DDNSDomainName);
	}
	document.getElementById('headDdnsConfigList_0_4').className = "align_center";
</script> 

 <form id="TableConfigInfo" style="display:none"> 
 <div class="list_table_spread"></div>
	 <table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
		<li   id="DDNSCfgEnabled"     RealType="CheckBox"         DescRef="bbsp_enableddnsmh"   RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DDNSCfgEnabled"        InitValue="Empty"/>
		<li   id="WANName"            RealType="DropDownList"     DescRef="bbsp_wannamemh"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"       Elementclass="SelectDdns restrict_dir_ltr"        InitValue="Empty"/>
		<li   id="DDNSProvider"       RealType="DropDownList"     DescRef="bbsp_providermh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DDNSProvider"     Elementclass="SelectDdns"  ClickFuncApp="onchange=ISPChange"/>
		<li   id="DDNSDomainName"     RealType="TextBox"          DescRef="bbsp_domainmh"       RemarkRef="bbsp_note1"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.DDNSDomainName" Elementclass="InputDdns"  InitValue="Empty" MaxLength="255"/>
		<li   id="DDNSUsername"       RealType="TextBox"          DescRef="bbsp_usermh"         RemarkRef="bbsp_note4"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.DDNSUsername"   Elementclass="InputDdns"  InitValue="Empty" MaxLength="256"/>
		<li   id="DDNSPassword"       RealType="TextBox"          DescRef="bbsp_pswmh"          RemarkRef="bbsp_note3"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""  Elementclass="InputDdns"   InitValue="Empty" MaxLength="256"/>
		<li   id="DDNSStatus"         RealType="TextBox"          DescRef="bbsp_current_status"          RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"  Elementclass="InputDdns"  InitValue="Empty"/>
		<li   id="DDNSLastError"      RealType="TextBox"          DescRef="bbsp_last_error"      RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"  Elementclass="InputDdns"  InitValue="Empty"/>
		<li   id="DDNSAdButtion"      RealType="ButtonArea"       DescRef="bbsp_advancedset"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"  Elementclass="SelectDdns"   ClickFuncApp="onClick=OnAdvancedSet"/>		
		<li   id="SaltAddress"        RealType="TextBox"          DescRef="bbsp_Salt_address"         RemarkRef="bbsp_Salt_address_eg"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.SaltAddress"  Elementclass="InputDdns"   InitValue="Empty" MaxLength="256"/>		
		<li   id="DDNSHostName"       RealType="TextBox"          DescRef="bbsp_hostmh"         RemarkRef="bbsp_note1"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.DDNSHostName"   Elementclass="InputDdns"  InitValue="Empty" MaxLength="255"/>
		<li   id="DDNSServicePort"    RealType="TextBox"          DescRef="bbsp_portmh"         RemarkRef="bbsp_note2"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.ServicePort"   Elementclass="InputDdns"   InitValue="Empty" MaxLength="5"/>
		<li   id="DDNSUpdateInterval"    RealType="TextBox"          DescRef="bbsp_update_interval"         RemarkRef="bbsp_note5"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.SuccessUpdateInterval"   Elementclass="InputDdns"   InitValue="Empty" MaxLength="7"/>
		<li   id="DDNSRetryTimes"        RealType="TextBox"          DescRef="bbsp_retry_times"         RemarkRef="bbsp_note6"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.FailRetryTimes"   Elementclass="InputDdns"   InitValue="Empty" MaxLength="5"/>
		<li   id="DDNSEncrypt"        RealType="TextBox"          DescRef="bbsp_encryptmh"      RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField=""  Elementclass="InputDdns"  InitValue="Empty" MaxLength="255"/>
		<script language="JavaScript" type="text/javascript">
			DdnsConfigFormList = HWGetLiIdListByForm("TableConfigInfo", null);
			var formid_hide_id = null;
			HWParsePageControlByID("TableConfigInfo", TableClass, ddns_language, formid_hide_id);
			InitWanNameListForDDNS();
			InitDDNSProvider();
			
		</script>
	  </table>
	   <table width="100%" class="table_button"> 
        <tr > 
          <td class="width_per25"></td> 
          <td class="table_submit">
		  	<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 
		  	<button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="AddSubmitParam();"><script>document.write(ddns_language['bbsp_app']);</script></button> 
            <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(ddns_language['bbsp_cancel']);</script></button>
		</td> 
        </tr> 
      </table> 
  </form>
</body>
</html>
