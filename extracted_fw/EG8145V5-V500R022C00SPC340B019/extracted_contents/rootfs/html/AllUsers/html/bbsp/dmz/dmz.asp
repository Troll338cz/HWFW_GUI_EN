<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wandns.asp"></script>
<title>DMZ</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, dmz_language);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style>
.Select
{
	width:260px;
	direction:ltr;  
}
.TextBox
{
	width:254px;  
}
.Select_2
{
	width:133px;
}
</style>

<script language="JavaScript" type="text/javascript">
var WanIndex = -1;
var DmzAddFlag = false;
var appName = navigator.appName;
var curUserType='<%HW_WEB_GetUserType();%>';
var IsDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var sysUserType = '0';
var WebInnerPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
var WebOuterPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenOuterPort);%>';
var telnetInnerPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_CLITelnetAccess.TelnetPort);%>';
var telnetOuterPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_CLITelnetAccess.OutTelnetPort);%>';
var WebWanDefaultPort = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_OUTPORTNUM.UINT32);%>';
var WebWanChangePort = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_OUTCHANGEPORT.UINT32);%>';
var WebWanPort = {defaultport:WebWanDefaultPort, newport:WebWanChangePort};
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var TELMEX_EN = ("1" == GetCfgMode().TELMEX)?true:false;  
var defaultWebPort = 80;
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var isMapFlag = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_MAP);%>';
var mapEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Enable);%>';
var isZQProduct = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var isUNICOMFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>';

if(TELMEX_EN)
{
	WebInnerPort = WebWanDefaultPort;
	WebOuterPort = WebWanChangePort;
	
	defaultWebPort = parseInt(WebWanDefaultPort, 10);
}
function isGuangdongUNICOM(){
    return (CfgFtWordArea === '020' && isUNICOMFlag === '1');
}
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
		setObjNoEncodeInnerHtmlValue(b, dmz_language[b.getAttribute("BindText")]);
	}
}

function stDMZInfo(domain,DMZEnable,DMZHostIPAddress,DMZWANInterface,flag)
{
	this.domain = domain;
	this.DMZEnable = DMZEnable;
	this.DMZHostIPAddress = DMZHostIPAddress;
	this.flag = 0;
    this.DMZWANInterface = DMZWANInterface;
}

var LANhostIP = new Array();
var LANhostName = new Array();

LANhostIP[0] = "";
LANhostName[0] = dmz_language['bbsp_hostName_select'];

var SelectIP = "";

function GetUserDevAlias(obj)
{
    if (obj.UserDevAlias != "--")
    {
        return obj.UserDevAlias;
    }
    else if (obj.HostName != "--") 
    {
    	return obj.HostName;
    }
    else
    {
        return obj.MacAddr;
    }
}
function setlanhostnameip(UserDevices)
{
	var UserDevicesnum = UserDevices.length - 1;

	for (var i = 0, j = 1; i < UserDevicesnum; i++)
	{
		if ("--" != UserDevices[i].HostName)
		{
	  	LANhostName[j] = UserDevices[i].HostName;
	  	LANhostIP[j] = UserDevices[i].IpAddr;
	  }
	  else
	  {
	  	LANhostName[j] = UserDevices[i].MacAddr;
	  	LANhostIP[j] = UserDevices[i].IpAddr;
        }
        if (IsDevTypeFlag == 1)
        {
            LANhostName[j] = GetUserDevAlias(UserDevices[i]);
        }
        j++;
	}
}

function setSelectHostName()
{
	setSelect('DMZHostName', '0');
	for (var k = 0; k < LANhostIP.length; k++)
	{
		if (SelectIP == LANhostIP[k])
		{
			setSelect('DMZHostName', k);
			break;
		}
	}
}

function StartFileOpt()
{
    XmlHttpSendAspFlieWithoutResponse("/asp/StartFileLoad.asp");
}

function DMZHostNameChange()
{
	setText('DMZHostIPAddress',LANhostIP[getSelectVal('DMZHostName')]);
}

function FormatPortStr(port)
{
    var portList = port.split(':');
    if ((portList.length > 1) && (parseInt(portList[1], 10) == 0))
    {
        return portList[0];
    }

    return port;
}

function stPortMappingPortList(domain,Protocol,InternalPort,ExternalPort,ExternalSrcPort,flag)
{
    var portList;
    var pathString = domain.split('.');
    this.instId = 0;
    if((pathString.length > 0) && ("X_HW_Portlist" == pathString[pathString.length - 2])){
        this.instId = parseInt(pathString[pathString.length - 1], 10);;
    }
    this.domain = domain;
    this.Protocol = Protocol;
    this.flag = 0;
    
    portList = FormatPortStr(InternalPort).split(':');
    this.innerPortStart = portList[0];
    this.innerPortEnd = portList[0];
    if(portList.length > 1){
        this.innerPortEnd = portList[1];
    }
    
    portList = FormatPortStr(ExternalPort).split(':');
    this.exterPortStart = portList[0];
    this.exterPortEnd = portList[0];
    if(portList.length > 1){
        this.exterPortEnd = portList[1];
    }
    
    portList = FormatPortStr(ExternalSrcPort).split(':');
    this.exterSrcPortStart = portList[0];
    this.exterSrcPortEnd = portList[0];
    if(portList.length > 1){
        this.exterSrcPortEnd = portList[1];
    }
}

function stPortMap(domain,ProtMapEnabled)
{
    this.domain = domain;
    this.ProtMapEnabled = ProtMapEnabled;
}

var WanIPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i}.X_HW_Portlist.{i},Protocol|InternalPort|ExternalPort|ExternalSrcPort,stPortMappingPortList);%>;
var WanPPPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i}.X_HW_Portlist.{i},Protocol|InternalPort|ExternalPort|ExternalSrcPort,stPortMappingPortList);%>;
var WanIPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i},PortMappingEnabled,stPortMap);%>;
var WanPPPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i},PortMappingEnabled,stPortMap);%>; 

function IsEqualDomain(a, b)
{
	var min_len = (a.length > b.length)?b.length : a.length;
	var _a = "";
	var _b = "";
	
	_a = a.substr(0, min_len).toLowerCase();
	_b = b.substr(0, min_len).toLowerCase();
	
	return (_a == _b)?true: false;
}

function SelectPortMapping(portMappingDomain,wanPortMapping)
{
    var portList = new Array(0);
    
    for(var i = 0; i < wanPortMapping.length-1; i++)
    {
        if(IsEqualDomain(wanPortMapping[i].domain, portMappingDomain))
        {
            return (wanPortMapping[i].ProtMapEnabled == 1)?true : false;
        }
    }
	
    return false;
}

function SelectPortMappingPortList(portMappingDomain,wanPortMappingPortList, TargetPort)
{
    for(var i = 0; i < wanPortMappingPortList.length-1; i++)
    {
        if (IsEqualDomain(wanPortMappingPortList[i].domain, portMappingDomain))
        {   
			var extstartport = parseInt(wanPortMappingPortList[i].exterPortStart, 10);
			var extendport   = parseInt(wanPortMappingPortList[i].exterPortEnd, 10);
		
			if ((TargetPort >= extstartport) && (TargetPort <= extendport))
			{
                if (TELMEX_EN)
                {
                    if (wanPortMappingPortList[i].Protocol.toUpperCase() == "UDP")
                    {
                        continue;
                    }
                    else
                    {
				        return true;
                    }
                }
                else
                {
                    return true;                                                       
                }
            }
            if (TELMEX_EN)
            {
                if ((extstartport ==0 &&extendport ==0) || (wanPortMappingPortList[i].exterPortStart =="" && wanPortMappingPortList[i].exterPortEnd == ""))
                {
                    if (wanPortMappingPortList[i].Protocol.toUpperCase() == "UDP")
                    {
                        continue;
                    }
                    else
                    {
                        return true;
                    }                    
                }
            }
        }
    }
    return false;
}

function PortIsUserInPortMapping(TargetPort, domain)
{
	var PortListIsFind = false;
	var PortMappingIsEnable = false;
	
	if(domain.indexOf("WANIPConnection") >= 0)
	{
		PortMappingIsEnable = SelectPortMapping(domain, WanIPPortMapping);		
		PortListIsFind = SelectPortMappingPortList(domain,WanIPPortMappingPortList, TargetPort);
	}
	else if(domain.indexOf("WANPPPConnection") >= 0)
	{
		PortMappingIsEnable = SelectPortMapping(domain, WanPPPPortMapping);		
		PortListIsFind = SelectPortMappingPortList(domain,WanPPPPortMappingPortList, TargetPort);
	}
	else
	{
		return false;
	}

	if( (true == PortMappingIsEnable) && (true == PortListIsFind))
	{
		return true;
	}
	
	return false;
}


function stWanInfo(domain,Name,Enable,NATEnabled,ConnectionType,ServiceList, ExServiceList, vlanid,connectionstatus,Tr069Flag,MacId,IPv4Enable)
{
	this.domain = domain; 	
	this.Name = Name;
	this.Enable = Enable;
	this.NATEnabled = NATEnabled;
	this.Mode = ConnectionType;
	this.ServiceList = (ExServiceList.length == 0)?ServiceList.toUpperCase():ExServiceList.toUpperCase();
	this.VlanId = vlanid;
	this.connectionstatus = connectionstatus;
	this.Tr069Flag = Tr069Flag;
	this.MacId     = MacId;
	this.IPv4Enable = IPv4Enable;
	this.DMZ_Array = new Array(null);
}

var IpDmzInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_DMZ,DMZEnable|DMZHostIPAddress,stDMZInfo);%>;
var PppDmzInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_DMZ,DMZEnable|DMZHostIPAddress,stDMZInfo);%>;
var guangdongDmzInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayFilterWan, InternetGatewayDevice.X_HW_DMZ.{i},Enable|HostIPAddress|WANInterface,stDMZInfo);%>;

function filterWan(WanItem)
{
    if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))) {
        return false;
    }
    if (CfgModeWord.toUpperCase() == "TRIPLETAP" || CfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || CfgModeWord.toUpperCase() == "TRIPLETAP6" || CfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
        if (WanItem.domain.indexOf(8) > -1) {
            return false;
        }
    }
    if (("1" == GetCfgMode().DT_HUNGARY) && (curUserType != sysUserType)) {
        if (WanItem.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) {
            return true;
        } else {
            return false;
        }
    }
    return true;
}

var AllWanInfoTemp = GetWanListByFilter(filterWan);
var AllWanInfo = new Array();

for (var i = 0; i < AllWanInfoTemp.length; i++)
{
	AllWanInfo[i] = new stWanInfo("","","","","","","","","","","","");
	AllWanInfo[i].domain = AllWanInfoTemp[i].domain;
	AllWanInfo[i].Name = AllWanInfoTemp[i].Name;
	AllWanInfo[i].Enable = AllWanInfoTemp[i].Enable;
	AllWanInfo[i].NATEnabled = AllWanInfoTemp[i].IPv4NATEnable;
	AllWanInfo[i].Mode = AllWanInfoTemp[i].Mode;
	AllWanInfo[i].ServiceList = AllWanInfoTemp[i].ServiceList;
	AllWanInfo[i].VlanId = AllWanInfoTemp[i].VlanId;
	AllWanInfo[i].connectionstatus = AllWanInfoTemp[i].connectionstatus;
	AllWanInfo[i].Tr069Flag = AllWanInfoTemp[i].Tr069Flag;
	AllWanInfo[i].MacId = AllWanInfoTemp[i].MacId;
	AllWanInfo[i].IPv4Enable = AllWanInfoTemp[i].IPv4Enable;
	AllWanInfo[i].DMZ_Array = new Array(null);
	AllWanInfo[i].X_HW_LowerLayers = AllWanInfoTemp[i].X_HW_LowerLayers;
}

function FindWanInfoByDmz(DmzItem)
{
	var wandomain_len = 0;
	var temp_domain = null;
    var isTowanNameSame;
    var isTowanwanxSame;
    var isDomainSame;
	for(var k = 0; k < AllWanInfo.length; k++ )
	{
		wandomain_len = AllWanInfo[k].domain.length;
		temp_domain = DmzItem.domain.substr(0, wandomain_len);
        isDomainSame = (temp_domain == AllWanInfo[k].domain);
		if (isGuangdongUNICOM()) {
            temp_domain = DmzItem.DMZWANInterface;
            if(temp_domain != undefined) {
                isTowanNameSame = temp_domain.toString().indexOf(domainTowanname(AllWanInfo[k].domain)) >= 0;
                isTowanwanxSame = temp_domain.toString().indexOf(domainTowanname(AllWanInfo[k].domain,"wanxFormat")) >= 0;
                isDomainSame = temp_domain.toString().indexOf(AllWanInfo[k].domain) >= 0;
            }
        }
        if (isDomainSame || isTowanNameSame || isTowanwanxSame)
		{
			return AllWanInfo[k];
		}
	}
	return null;
}

var DmzInfo = new Array();
var Idx = 0;

var IpDmzInfoLen = IpDmzInfo.length-1;
var PppDmzInfoLen = PppDmzInfo.length-1;
var gdDmzInfoLen = guangdongDmzInfo.length-1;

if(isGuangdongUNICOM()) {
    IpDmzInfoLen = 0;
    PppDmzInfoLen = 0;
} else {
    gdDmzInfoLen = 0;
}

for (i = 0; i < IpDmzInfoLen; i++)
{
    var tmpWan = FindWanInfoByDmz(IpDmzInfo[i]);
	
    if (tmpWan == null)
    {
        continue;
    }
	
	if (tmpWan.ServiceList != 'TR069'
       && tmpWan.ServiceList != 'VOIP'
       && tmpWan.ServiceList != 'TR069_VOIP'
       && tmpWan.Mode == 'IP_Routed')
	{
   		DmzInfo[Idx] = IpDmzInfo[i];
		Idx ++;
	}
}
for (j = 0; j < PppDmzInfoLen; j++,i++)
{
	var tmpWan = FindWanInfoByDmz(PppDmzInfo[j]); 
	 
	if (tmpWan == null)
    {
        continue;
    }  

    if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.ServiceList != 'VOIP'
		&& tmpWan.ServiceList != 'TR069_VOIP'
		&& tmpWan.Mode == 'IP_Routed')
	{
   		DmzInfo[Idx] = PppDmzInfo[j];
		Idx ++;
	}
}
for (j = 0; j < gdDmzInfoLen; j++,i++)
{
	var tmpWan = FindWanInfoByDmz(guangdongDmzInfo[j]); 
	 
	if (tmpWan == null)
    {
        continue;
    }  
 
    if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.ServiceList != 'VOIP'
		&& tmpWan.ServiceList != 'TR069_VOIP'
		&& tmpWan.Mode == 'IP_Routed')
	{
   		DmzInfo[Idx] = guangdongDmzInfo[j];
		Idx ++;
	}
}

if (isSupportHybrid == 1) {
    var BondingDmzInfo = '';
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/bbsp/bonding/bondingdmzinfo.asp",
        success : function(data) {
            BondingDmzInfo = dealDataWithFun(data);
        }
    });

    if ((BondingDmzInfo.length > 1) && (BondingDmzInfo[0].DMZHostIPAddress != '')) {
        DmzInfo[Idx] = BondingDmzInfo[0];
        Idx ++;
    }
}

var WanInfo = new Array();

InitWanDmzInfo();

function InitWanDmzInfo()
{
	var WanIPInfo_len = 0;	
	var temp_domain = null;
	var k = 0;
    var isTowanNameSame;
    var isTowanwanxSame;
	var isDomainSame;

	for (i = 0; i < DmzInfo.length; i++)
	{
		for (j = 0; j < AllWanInfo.length; j++)
		{
			WanIPInfo_len = AllWanInfo[j].domain.length;
			temp_domain = DmzInfo[i].domain.substr(0, WanIPInfo_len);
            isDomainSame = (temp_domain == AllWanInfo[j].domain);
            if (isGuangdongUNICOM()) {
                temp_domain = DmzInfo[i].DMZWANInterface;
                if(temp_domain != undefined) {
                    isTowanNameSame = temp_domain.toString().indexOf(domainTowanname(AllWanInfo[j].domain)) >= 0;
                    isTowanwanxSame = temp_domain.toString().indexOf(domainTowanname(AllWanInfo[j].domain,"wanxFormat")) >= 0;
                    isDomainSame = temp_domain.toString().indexOf(AllWanInfo[j].domain) >= 0 ;
                }
            }
			if (isDomainSame || isTowanNameSame || isTowanwanxSame)
			{
				WanInfo[k] = AllWanInfo[j];
				WanInfo[k].DMZ_Array[0] = DmzInfo[i];
				WanInfo[k].DMZ_Array[1] = null;
				k++;
				break;
			}
		}
	}
    if (isSupportHybrid == 1) {
        if ((BondingDmzInfo.length > 1) && (BondingDmzInfo[0].DMZHostIPAddress != '')) {
            var bondingInfo = new stWanInfo("InternetGatewayDevice.Services.X_HW_Bonding.DMZ", "Bonding", "", "", "", "", "", "", "", "", "", "");
            WanInfo[k] = bondingInfo;
            WanInfo[k].DMZ_Array[0] = BondingDmzInfo[0];
            WanInfo[k].DMZ_Array[1] = null;
        }
    }
}

function AppBondingConfig()
{
    var bondingDmzData = "x.Enable=" + getCheckVal('DMZEnable');
    bondingDmzData += "&x.HostIPAddress=" + getValue('DMZHostIPAddress');
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : bondingDmzData + "&x.X_HW_Token=" + getValue('onttoken'),
        url : "setajax.cgi?x=InternetGatewayDevice.Services.X_HW_Bonding.DMZ&RequestFile=html/bbsp/dmz/dmz.asp",
        success : function(data) {
            window.location.href = "/html/bbsp/dmz/dmz.asp";
        }
    });
}
function setActionGdUNICOM(index) {
    var isTowanNameSame;
    var isTowanwanxSame;
    var isdomainSame;
    var tempDomain;
    for (var i = 0 ; i < guangdongDmzInfo.length -1 ; i++) {
        isTowanNameSame = domainTowanname(AllWanInfo[index].domain) ==  guangdongDmzInfo[i].DMZWANInterface;
        isTowanwanxSame = domainTowanname(AllWanInfo[index].domain,"wanxFormat") == guangdongDmzInfo[i].DMZWANInterface;
        isdomainSame = AllWanInfo[index].domain == guangdongDmzInfo[i].DMZWANInterface;
        if (isTowanNameSame || isTowanwanxSame || isdomainSame) {
            tempDomain = guangdongDmzInfo[i].domain;
        }
    }
    var SubmitForm = new webSubmitForm();
    if (DmzAddFlag == true) {
        var url = 'add.cgi?x=' + 'InternetGatewayDevice.X_HW_DMZ'
					   + '&RequestFile=html/bbsp/dmz/dmz.asp'
        SubmitForm.addParameter('x.WANInterface', AllWanInfo[index].domain);
    } else {
        var url = 'set.cgi?x=' + tempDomain
					   + '&RequestFile=html/bbsp/dmz/dmz.asp' 
    }
    
    var DMZEnable = "0" ;
    if ( $("#DMZEnable").is(':checked')) {
        DMZEnable = "1" ;
    }

	SubmitForm.setAction(url);
    SubmitForm.addParameter('x.Enable', DMZEnable);
    SubmitForm.addParameter('x.HostIPAddress', getValue('DMZHostIPAddress'));
   
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.submit();
}
function ApplyConfig()
{
	if(CheckDMZ() == false)
	{
        setDisable('btnApply1',0);
        setDisable('cancelValue',0);        
		return false;
	}
	
	setDisable('btnApply1',1);
	setDisable('cancelValue',1);
	setDisable('DMZInterface',1);
	
	var Interface = getElement('DMZInterface');
	var optionID = Interface.options[Interface.selectedIndex].id;
    if (isSupportHybrid == 1) {
        if (optionID == 'BONDING') {
            AppBondingConfig();
            return;
        }
    }
	var index = optionID.split('_')[1];
	var url;
	var SpecDmzCfgParaList = new Array(new stSpecParaArray("x.Name","",2));
	var Parameter = {};
	Parameter.asynflag = null;
	Parameter.FormLiList = DmzConfigFormList;
	Parameter.SpecParaPair = SpecDmzCfgParaList;

    var tokenvalue = getValue('onttoken');
	if (isGuangdongUNICOM()){
        setActionGdUNICOM(index);
    } else {
        if(DmzAddFlag == true)
        {
        	url = 'add.cgi?x=' + AllWanInfo[index].domain + '.X_HW_DMZ'
        					   + '&RequestFile=html/bbsp/dmz/dmz.asp'
        }
        else
        {
        	url = 'set.cgi?x=' + AllWanInfo[index].domain + '.X_HW_DMZ'
        					   + '&RequestFile=html/bbsp/dmz/dmz.asp'
        }
        HWSetAction(null, url, Parameter, tokenvalue);
    }

}

function CheckAddDMZNote()
{
    if (parseInt(getCheckVal('DMZEnable'), 10) == 0)
    {
        return 0;
    }

    return 1;
}

function CheckModifyDMZNote()
{
    if (DmzInfo[selctIndex].DMZEnable != 1)
    {
        if (parseInt(getCheckVal('DMZEnable'), 10) == 0)
        {
            return 0;
        }
        else
        {
            return 1;
        }
    }
    else
    {
		if (parseInt(getCheckVal('DMZEnable'), 10) == 0)
		{
			return 2;
		}
		else
		{
			return 0;
		}
    }

    return 0;    
}

function CheckDelDMZNote(curitem)
{
	if(DmzInfo[curitem].DMZEnable != 1)
	{
		return 0;
	}
	
	return 2;
}

function IsMakeSpecialNote(ServiceList)
{
	var portFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_INTERNET_INNER_PORT);%>";
	var serviceType = ServiceList.toUpperCase();
	if(("1" == portFeature) && ("INTERNET" == serviceType))
	{
		return true;
	}
	return false;
}

function ProductNoteString(result)
{
    var notestring = '';
    var Interface = getElement('DMZInterface');
    var optionID = Interface.options[Interface.selectedIndex].id;
    var index = optionID.split('_')[1];

    if (GetFeatureInfo().dmzpri == 0)
    {
        return notestring;
    }

    var WebDefaultInUser = PortIsUserInPortMapping(WebInnerPort, AllWanInfo[index].domain);
    var TelnetDefaultInUser = PortIsUserInPortMapping(telnetInnerPort, AllWanInfo[index].domain);
	
    if (result == 1)
    {
        if ((GetFeatureInfo().httpportmode == 1 || TELMEX_EN) && (false == WebDefaultInUser))
        {
			if(TELMEX_EN)
			{
				notestring = dmz_language['bbsp_dmzconflithttp1'].replace(/8080/, WebWanPort["newport"]); 
			}
            else if (WebOuterPort)
            {
                notestring = dmz_language['bbsp_dmzconflithttp1'].replace(/8080/, WebOuterPort);
            }
            else
            {
                notestring = dmz_language['bbsp_dmzconflithttp3'];          
            } 
        }

        if ((GetFeatureInfo().telportmode == 1) && (false == TelnetDefaultInUser))
        {
            if (telnetOuterPort)
            {
                notestring += dmz_language['bbsp_dmzconflittel1'].replace(/2323/, telnetOuterPort);           
            }
            else
            {
                notestring += dmz_language['bbsp_dmzconflittel3'];  
                
            }
        }

    }
    else if (result == 2)
    {
        if ((GetFeatureInfo().httpportmode == 1 || TELMEX_EN) && (false == WebDefaultInUser))
        {
            if (WebInnerPort == defaultWebPort)
            {
            	if(TELMEX_EN && (WebWanPort["defaultport"] != 80))
				{
					notestring = dmz_language['bbsp_dmzconflithttp1'].replace(/8080/, WebWanPort["defaultport"]); 
				}
				else if(false == IsMakeSpecialNote(AllWanInfo[index].ServiceList))
				{
			    	notestring = dmz_language['bbsp_dmzconflithttp2'];
				}
				else
				{
					notestring = dmz_language['bbsp_dmzconflithttp1'];
				}
            }
            else
            {
                notestring = dmz_language['bbsp_dmzconflithttp3'];           
            }
        }

        if ((GetFeatureInfo().telportmode == 1) && (false == TelnetDefaultInUser))
        {
            if (telnetInnerPort == 23)
            {
                if(false == IsMakeSpecialNote(AllWanInfo[index].ServiceList))
				{
			    	notestring += dmz_language['bbsp_dmzconflittel2'];
				}
				else
				{
					notestring += dmz_language['bbsp_dmzconflittel1'];
				}           
            }
            else
            {
                notestring += dmz_language['bbsp_dmzconflittel3'];               
            }
        }
    } 

    return notestring;
}

function CheckDMZ()
{
    var Interface = getElement('DMZInterface');
	var optionID = 0;
	var index = 0;
	var result = 0;
    var notestring = '';

    setDisable('btnApply1', 1);
    setDisable('cancelValue', 1);
   
	if ( Interface.selectedIndex < 0 )
	{
	    AlertEx(dmz_language['bbsp_creatwan']);
        return false;
	}

    optionID = Interface.options[Interface.selectedIndex].id;
    if ((isSupportHybrid == 1) && (optionID == "BONDING")) {
    } else {
	index = optionID.split('_')[1];

	if ( AllWanInfo[index].NATEnabled < 1 )
	{
	     AlertEx(dmz_language['bbsp_natof'] + MakeWanName1(AllWanInfo[index]) + dmz_language['bbsp_disable']);
         return false;
	}
    }
	if (getElement('DMZInterface').length == 0)
	{
        AlertEx(dmz_language['bbsp_nowan']);
        return false;	
	}

    with (getElement('divTableConfigForm')) 
	{

		if (getElement('DMZHostIPAddress').value == '')
		{
			AlertEx(dmz_language['bbsp_dmzisreq']);
			return false;
		}

		if (isAbcIpAddress(getElement('DMZHostIPAddress').value) == false ) 
		{
			AlertEx(dmz_language['bbsp_dmzinvalid']);
			return false;
		}

		if(DmzAddFlag == true)
		{
			for(i = 0; i < WanInfo.length; i++)
			{
				if(WanInfo[i].Name == Interface.value)
				{
                    if (isSupportHybrid == 1) {
                        if (WanInfo[i].Name == 'Bonding') {
                            AlertEx(dmz_language['bbsp_interface'] + 'Bonding' + dmz_language['bbsp_dmzrepeat']);
                            return false;
                        }
                    }
					AlertEx(dmz_language['bbsp_interface'] + MakeWanName1(WanInfo[i]) + dmz_language['bbsp_dmzrepeat']);
					return false;
				}
			}
		}
	}

	if (isSupportHybrid == 1) {
        if (optionID == "BONDING") {
            return true;
        }
    }

    if (DmzAddFlag == true) 
    {
        result = CheckAddDMZNote();
    }
    else
    {
        result = CheckModifyDMZNote();
    }

    notestring = ProductNoteString(result);

    if (notestring.length != 0)
    {
		StartFileOpt();
        AlertEx(notestring);
    }

   return true;
}

function LoadFrame()
{
	loadlanguage();	
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
    if (CfgModeWord === 'DESKAPASTRO') {
        $('.Select_2').css({"width": "160px", "margin-left": "8px"});
        $('#DMZHostIPAddressColleft').prepend('<font color="red">*</font>');
        setDisplay("DMZHostIPAddressRequire", 0);
    }

}

function ShowDMZ()
{

}

function setCtlDisplay(record)
{
    if (DBAA1 == '1') {
        setSelect('DMZInterface', "Bonding");
    } else {
        setSelect('DMZInterface', record.Name);
    }

	if ( record.domain == '' )
	{
        setDisable('DMZInterface', 0);
		setCheck('DMZEnable','');		
		setText('DMZHostIPAddress','');
		SelectIP = '';
		setSelectHostName();
	}
	else
	{
        setDisable('DMZInterface', 1);
		setCheck('DMZEnable',record.DMZ_Array[0].DMZEnable);		
		setText('DMZHostIPAddress',record.DMZ_Array[0].DMZHostIPAddress);
		SelectIP = record.DMZ_Array[0].DMZHostIPAddress;
		setSelectHostName();
	}
}

var selctIndex = -1;

function getInterfaceWanList()
{
    var HU='<%HW_WEB_GetFeatureSupport(BBSP_FT_HU);%>';
	var WANNamelist = getElementById("DMZInterface");
	WANNamelist.options.length = 0;
    for (i = 0; i < AllWanInfo.length; i++)
    { 
        if (AllWanInfo[i].ServiceList != 'TR069'
            && AllWanInfo[i].ServiceList != 'VOIP'
            && AllWanInfo[i].ServiceList != 'TR069_VOIP'
            && AllWanInfo[i].Mode == 'IP_Routed'
            && AllWanInfo[i].IPv4Enable == '1')
        {
            if((HU==1) && (curUserType != '0') && ((AllWanInfo[i].ServiceList == 'IPTV') || (AllWanInfo[i].ServiceList == 'OTHER')))
            {
                continue;
            }
            else
            {
                $("#DMZInterface").append('<option value="' + htmlencode(AllWanInfo[i].Name) + '" id="wan_'
                        + i + '">'
                        + htmlencode(AllWanInfo[i].Name) + '</option>');
            }
        }
    }	 
}
function getInterfaceInternetWanList()
{
    var WANNamelist = getElementById("DMZInterface");
	WANNamelist.options.length = 0;
    for (i = 0; i < AllWanInfo.length; i++)
    { 
        if (AllWanInfo[i].Mode == 'IP_Routed' && AllWanInfo[i].IPv4Enable == '1')
        {
           if (AllWanInfo[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") == -1
                || IsRadioWanSupported(AllWanInfo[i]))
            {
                continue;
            }
            else
            {
                $("#DMZInterface").append('<option value="' + htmlencode(AllWanInfo[i].Name) + '" id="wan_'
                        + i + '">'
                        + htmlencode(AllWanInfo[i].Name) + '</option>');
            }
        }
    }	   
}

function RefreshWanInterface(isAdd)
{
    if (((curUserType != sysUserType) && (IsPTVDFFlag == 1))
        || (SingtelMode == '1'))
    {
        if(isAdd==true)
        {
            getInterfaceInternetWanList();
        }
        else
        {
            getInterfaceWanList();
        }
    }
}

function InitWanInterface()
{
	var HU='<%HW_WEB_GetFeatureSupport(BBSP_FT_HU);%>';
	for (i = 0; i < AllWanInfo.length; i++) {
        if (CfgModeWord.toUpperCase() == "TMCZST") {
            if ((AllWanInfo[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) &&
                (AllWanInfo[i].Mode == 'IP_Routed') && (AllWanInfo[i].IPv4Enable == '1')) {
                $("#DMZInterface").append('<option value="' + htmlencode(AllWanInfo[i].Name) + '" id="wan_'
                    + i + '">' + htmlencode(AllWanInfo[i].Name) + '</option>');
            }
            continue;
        }
		if (AllWanInfo[i].ServiceList != 'TR069'
			&& AllWanInfo[i].ServiceList != 'VOIP'
			&& AllWanInfo[i].ServiceList != 'TR069_VOIP'
			&& AllWanInfo[i].Mode == 'IP_Routed'
			&& AllWanInfo[i].IPv4Enable == '1')
		{
			if((HU==1) && (curUserType != '0') && ((AllWanInfo[i].ServiceList == 'IPTV') || (AllWanInfo[i].ServiceList == 'OTHER')))
			{
				continue;
			}
			else
			{
				$("#DMZInterface").append('<option value="' + htmlencode(AllWanInfo[i].Name) + '" id="wan_'
                        + i + '">'
                        + htmlencode(AllWanInfo[i].Name) + '</option>');
			}
		}
	}	
}

function setControl(index)
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(dmz_language["map_t_enable_prompt"]);
        return;
    }
    var record;

	selctIndex = index;

	if (index == -1)
	{
	    if (DmzInfo.length >= 4)
        {
            setDisplay('ConfigForm', 0);
            AlertEx(dmz_language['bbsp_full']);
            return;
        }
        else
        {
    	    record = new stWanInfo('','','','','','','','','','');
    		DmzAddFlag = true;
            RefreshWanInterface(DmzAddFlag);
            setCtlDisplay(record);
            setDisplay('ConfigForm', 1);
			record.DMZEnable = '';
			record.DMZHostIPAddress = '';
			HWSetTableByLiIdList(DmzConfigFormList, record, null);
			return; 	
        }
	}
    else if (index == -2)
    {
        setDisplay('ConfigForm', 0);
    }
	else
	{
		DmzAddFlag = false;
        RefreshWanInterface(DmzAddFlag);
	    record = WanInfo[index];
        setCtlDisplay(record);
        setDisplay('ConfigForm', 1);
		record.DMZEnable = record.DMZ_Array[0].DMZEnable;
		record.DMZHostIPAddress = record.DMZ_Array[0].DMZHostIPAddress;
		HWSetTableByLiIdList(DmzConfigFormList, record, null);
		return; 
	}

    setDisable('btnApply1', 0);
    setDisable('cancelValue', 0);
	
	if((curUserType != 0) && ("INDOSAT" == CfgModeWord.toUpperCase())) 
	{
		$("input").attr("disabled","true");
		$("button").attr("disabled","true");
		$("select").attr("disabled","true");				
	}
}

function dmzInstselectRemoveCnt(obj) 
{

}  

function DelBondingDmz(flag)
{
    var bondingDmzData = "x.Enable=0";
    bondingDmzData += "&x.HostIPAddress=";
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : bondingDmzData + "&x.X_HW_Token=" + getValue('onttoken'),
        url : "setajax.cgi?x=InternetGatewayDevice.Services.X_HW_Bonding.DMZ&RequestFile=html/bbsp/dmz/dmz.asp",
        success : function(data) {
            if (flag <= 1) {
                window.location.href = "/html/bbsp/dmz/dmz.asp";
            }
        }
    });
}

function RemoveInst(url, rmlId)
{
	var rml = getElement(rmlId);
	if (rml == null)
		return;

	var SubmitForm = new webSubmitForm();
	var cnt = 0;
	with (document.forms[0])
	{
		if (rml.length > 0)
		{
			for (var i = 0; i < rml.length; i++)
			{
				if (rml[i].checked == true)
				{
				    if ((isSupportHybrid == 1) && (rml[i].value.indexOf('X_HW_Bonding') >= 0)) {
					   DelBondingDmz(rml.length);
					} else {
                        if(isGuangdongUNICOM()){
                            SubmitForm.addParameter(forDelselectDomain(rml[i].value),'');   
                        }else {
                            SubmitForm.addParameter(rml[i].value + '.X_HW_DMZ','');
                        }
					}
					cnt++;
				}
			}
		}
		else if (rml.checked == true)
		{
		    if ((isSupportHybrid == 1) && (rml.value.indexOf('X_HW_Bonding') >= 0)) {
			   DelBondingDmz(0);
		    } else {
                if(isGuangdongUNICOM()) {
                    SubmitForm.addParameter(forDelselectDomain(rml.value),'');   
                }else {
                    SubmitForm.addParameter(rml.value + '.X_HW_DMZ','');
                }
			}
			cnt++;
		}
	}

	SubmitForm.setAction('del.cgi?RequestFile=' + url);
	
SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
	SubmitForm.submit();
}

function forDelselectDomain(rmlVal){
    for (var j = 0 ; j < guangdongDmzInfo.length -1 ; j++) {
        var tempNode = guangdongDmzInfo[j].DMZWANInterface;
        isTowanNameSame = tempNode.toString().indexOf(domainTowanname(rmlVal)) >= 0;
        isTowanwanxSame = tempNode.toString().indexOf(domainTowanname(rmlVal,"wanxFormat")) >= 0;
        isdomainSame =  tempNode.toString().indexOf(rmlVal) >= 0;
        if (isTowanNameSame || isTowanwanxSame || isdomainSame) {
            return guangdongDmzInfo[j].domain;
        }   
    }
}

function OnDeleteButtonClick(id)
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AAlertEx(dmz_language["map_t_enable_prompt"]);
        return;
    }
	var notestring = '';
    var result = 0;
    if (DmzInfo.length == 0)
	{
	    AlertEx(dmz_language['bbsp_nodmz']);
	    return;
	}

	if (selctIndex == -1 && DmzAddFlag == true)
	{
	    AlertEx(dmz_language['bbsp_savedmz']);
	    return;
	}
    var rml = getElement('dmzInstrml');
    var noChooseFlag = true;
    if ( rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             {   
                 noChooseFlag = false;
             }
         }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
    }
    if ( noChooseFlag )
    {
        AlertEx(dmz_language['bbsp_choosedmz']);
        return ;
    }

	if (ConfirmEx(dmz_language['bbsp_deldmz']) == false)
	{
		document.getElementById("DeleteButton").disabled = false;
	    return;
    }
	
    if (rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             {   
                result = CheckDelDMZNote(i);
                notestring = ProductNoteString(result);
                if (notestring.length != 0)
                {
					StartFileOpt();
                	AlertEx(notestring);
                }
             }
         }
    }
    else if (rml.checked == true) 
    {
        result = CheckDelDMZNote(selctIndex);
        notestring = ProductNoteString(result);
        if (notestring.length != 0)
        {
			StartFileOpt();
            AlertEx(notestring);
        }
    }
    
    setDisable('btnApply1', 1);
    setDisable('cancelValue', 1);
	RemoveInst('html/bbsp/dmz/dmz.asp', 'dmzInstrml');
}

function CancelConfig()
{
    setDisplay("ConfigForm", 0);
	
	if (selctIndex == -1)
    {
        var tableRow = getElement("dmzInst");

        if (tableRow.rows.length > 2)
        {
            tableRow.deleteRow(tableRow.rows.length-1);
			return;
        }
    }
}

function ShowDMZEnableStatus(statusflag)
{
	if (statusflag == "1" || statusflag == 1)
	{
		return dmz_language['bbsp_dmz_enable'];
	}
	else
	{
		return dmz_language['bbsp_dmz_disable'];
	}	
}

var TableClass = new stTableClass("table_title width_per25", "table_right", "", "Select");

function CreateDMZSelectInfo()
{
	var output = '';
	for (i = 0; i < LANhostName.length; i++)
	{
		output = '<option value=' + i + ' id="' + htmlencode(LANhostName[i]) + '"  title="' + htmlencode(LANhostName[i]) +'">' + GetStringContent(htmlencode(LANhostName[i]),18) + '</option>';
		$("#DMZHostName").append(output);
	} 			
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
var dmz_title = 'bbsp_dmz_title';
if (IsPTVDFFlag == 1) {
    dmz_title = "bbsp_PTVDF_dmz_title";
}
HWCreatePageHeadInfo("dmz", GetDescFormArrayById(dmz_language, "bbsp_mune"), GetDescFormArrayById(dmz_language, dmz_title), false);
</script>
<div class="title_spread"></div>

<script type="text/javascript">
var DmzConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),
								new stTableTileInfo("bbsp_wanname","align_center restrict_dir_ltr","Name"),
								new stTableTileInfo("bbsp_enabledmz","align_center","EnableDMZ"),
								new stTableTileInfo("bbsp_hostaddr","align_center","HostAddress"),null);

var TableDataInfo =  HWcloneObject(WanInfo, 1);
TableDataInfo.push(null);
for(var i = 0; i < TableDataInfo.length-1; i++)
{
	TableDataInfo[i].EnableDMZ = ShowDMZEnableStatus(TableDataInfo[i].DMZ_Array[0].DMZEnable);
	TableDataInfo[i].HostAddress = TableDataInfo[i].DMZ_Array[0].DMZHostIPAddress;
}								
HWShowTableListByType(1, "dmzInst", true, 4, TableDataInfo, DmzConfiglistInfo, dmz_language, null);

</script>

<form id="ConfigForm" style="display:none">
<div class="list_table_spread"></div>
<table border="0" cellpadding="0" cellspacing="0"  width="100%">
<li   id="DMZEnable"         RealType="CheckBox"      DescRef="bbsp_enabledmzmh"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.DMZEnable"   InitValue="Empty"/>
<li   id="DMZInterface"      RealType="DropDownList"  DescRef="bbsp_wannamemh"          RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Name"  InitValue="Empty" ClickFuncApp="onchange=ShowDMZ"/>                                                                   
<li   id="DMZHostIPAddress"  RealType="TextOtherBox"  DescRef="bbsp_hostaddrmh"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.DMZHostIPAddress"  MaxLength="15"  InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'DMZHostName'},{AttrName:'class',AttrValue:'Select_2 restrict_dir_ltr'}]}]"/>                                                                  
</table>
<script>
DmzConfigFormList = HWGetLiIdListByForm("ConfigForm");
HWParsePageControlByID("ConfigForm", TableClass, dmz_language, null);
</script>
  <table id="ConfigPanelButtons" width="100%" cellpadding="2" cellspacing="0" class="table_button"> 
    <tr> 
      <td class="width_per25"></td> 
      <td class="table_submit">
	    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	  	<button name="btnApply1" id="btnApply1" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="ApplyConfig();"><script>document.write(dmz_language['bbsp_app']);</script></button> 
        <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(dmz_language['bbsp_cancel']);</script></button> 
	</td> 
    </tr> 
  </table> 
</form>
<div style="height:20px;"></div>
<script language="JavaScript" type="text/javascript">
InitWanInterface();
if (isSupportHybrid == 1) {
    $("#DMZInterface").append('<option value="Bonding" id="BONDING">' + bonding_other_language['bbsp_bonding'] + '</option>');
}
GetLanUserDevInfo(function(para)
{
	setlanhostnameip(para);
	CreateDMZSelectInfo();
	setSelectHostName();
});
getElById('DMZHostName').onchange = function()
{
	DMZHostNameChange();
}
</script> 
</body>
</html>
