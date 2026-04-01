<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wanaddressacquire.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wandns.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, Languages, lan_address_language, lanaddr_Languages);%>"></script>

<style>
.SelectDdns{
	width: 260px;
}
.SelectLtr{
	width: 260px;
	direction:ltr;
}
.InputDdns{
	width: 254px;
}
.InputLtr{
	width: 254px;
	direction:ltr;
}
</style>
<script>

var specIPoEMTUMax = '<%HW_WEB_GetSPEC(SPEC_LOWER_LAYER_MAX_MTU.UINT32);%>';
var g_MTUDefault = 1500;
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var sysUserType = '0';
var CfgMode = '<%HW_WEB_GetCfgMode();%>'
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsDNSLockEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DNS.DNSLockEnable);%>'
var IsIPProtocolVersionEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_IPProtocolVersion.Mode);%>'
var IsSAFARICOMFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SAFARICOM);%>';
var ebgWebFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_EBG);%>';
var curIpv6ConnectType = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.IPv6BridgeTransfer.Enable);%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var isDualWanUpCfg = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DUALWAN_UPSTREAM);%>';
var isDualWanUpProduct = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_DUALWAN_UPSTREAM);%>';

var CurIPv6ConnectSelect;

function isDisableURAMode(wan) {
    for (var i = 0; i < wan.length; i++) {
      if (wan[i].X_HW_NPTv6Enable === '1') {
        return true;
      }
    }
    return false;
}

function filtergetmask6(length)
{
	var bitlength = length % 16;
	var mask = ['0','8000','C000','E000','F000','F800','FC00','FE00','FF00','FF80','FFC0','FFE0','FFF0','FFF8','FFFC','FFFE','FFFF'];
	var maskout;
	if((length < 16)&&(length >= 1))
	{
		maskout = mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 32)&&(length >= 16))
	{
		maskout = 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 48)&&(length >= 32))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 64)&&(length >= 48))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 80)&&(length >= 64))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0' + ':' + '0';
	}

	if((length < 96)&&(length >= 80))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength] + ':' + '0' + ':' + '0';
	}

	if((length < 112)&&(length >= 96))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' +  'FFFF' + ':' + mask[bitlength] + ':' + '0';
	}

	if((length < 128)&&(length >= 112))
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' +  'FFFF' + ':' + 'FFFF' + ':' + mask[bitlength];
	}

	if(length == 128)
	{
		maskout = 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' + 'FFFF' + ':' +  'FFFF' + ':' + 'FFFF' + ':' + 'FFFF';
	}

	if(length == 0)
	{
		maskout = '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0' + ':' + '0';
	}
	return maskout;
}

function PutPrefix(Br0IPv6Prefixtmp, Prelengthtmp)
{
	var Br0IPv6PrefixList = standIpv6Address(Br0IPv6Prefixtmp);
	var Masklist = filtergetmask6(Prelengthtmp).split(':');
	
	var TempIPv6PrefixNew = '';

	for(var fixlength = 0;fixlength < 4;fixlength++)
	{
		var tmp;
		tmp = parseInt(Br0IPv6PrefixList[fixlength], 16) & parseInt(Masklist[fixlength], 16);
		Br0IPv6PrefixList[fixlength] = tmp.toString(16);

		TempIPv6PrefixNew += "0000".substring(0, 4 - Br0IPv6PrefixList[fixlength].length) + Br0IPv6PrefixList[fixlength];

		if(fixlength != 3)
		{
			TempIPv6PrefixNew += ':';
		}
	}

	return TempIPv6PrefixNew;
}

	function GetCurrentLoginIP()
	{
		var CurUrlIp = (window.location.host).toUpperCase();
		CurUrlIp = CurUrlIp.replace(/[\[\]]/g, "");

		return CurUrlIp;
	}
	
    function Br0IPv6AddressClass(domain, Alias, IPv6Address)
    {
        this.domain = domain;
        this.Alias = Alias;
        this.IPv6Address = IPv6Address;
    }

    function Br0IPv6PrefixClass(domain, Alias, ParentPrefix, ChildPrefixMask, Mode, Prefix, PreferredLifeTime, ValidLifeTime)
    { 
        this.domain = domain;
        this.Alias = Alias;
        this.ParentPrefix = ParentPrefix;
        this.ChildPrefixMask = ChildPrefixMask;
		
		switch(Mode.toString().toUpperCase())
		{
			case "WANDELEGATED": 
				Mode = "WANDelegated"; break;
			case "HGWPROXY": 
				Mode = "HGWProxy"; break;
			case "STATIC": 
				Mode = "Static"; break;
			default: 
				break;
		}
        this.Mode = Mode;
        this.Prefix = Prefix;
        this.PreferredLifeTime = PreferredLifeTime;
        this.ValidLifeTime = ValidLifeTime;     
    }
    function IPv6DNSConfigClass(domain, DomainName, IPv6DNSConfigType, IPv6DNSWANConnection, IPv6DNSServers)
    { 
        this.domain = domain;
        this.DomainName = DomainName;
        this.IPv6DNSConfigType = IPv6DNSConfigType;
        this.IPv6DNSWANConnection = IPv6DNSWANConnection;
        this.IPv6DNSServers = IPv6DNSServers;
    }

    function IPv6BindLanClass(domain, LanInterface)
    { 
        this.domain = domain;
        this.LanInterface = LanInterface;
    }

    function RaConfigInfoClass(domain, ManagedFlag, OtherConfigFlag, mode, Enable, MTU)
    {
        this.domain = domain;
        this.ManagedFlag = ManagedFlag;
        this.OtherConfigFlag = OtherConfigFlag;
        this.Mode = mode;
		this.Enable = Enable;
		this.MTU = MTU;
    }

    function UlaModeInfoClass(domain, ULAmode)
    {
        this.domain = domain;
        this.ULAmode = ULAmode;
    }

	function DhcpV6Server(domain, Enable, DHCPv6LeaseTime)
    {
        this.domain = domain;
        this.Enable= Enable;
		this.DHCPv6LeaseTime = DHCPv6LeaseTime;
    }
	
    function UlaConfigInfoClass(domain, ULAPrefix, ULAPrefixLen, ValidLifetime, PreferredLifetime)
    {
        this.domain = domain;
        this.ULAPrefix = ULAPrefix;
		this.ULAPrefixLen = ULAPrefixLen;
		this.ValidLifetime = ValidLifetime;
		this.PreferredLifetime = PreferredLifetime;
    }
	
	function stLanDhcp6Info(domain, MinAddress, MaxAddress, IAPDAddLength)
	{
		this.domain = domain;
		this.MinAddress = MinAddress;
		this.MaxAddress = MaxAddress;
		this.IAPDAddLength = IAPDAddLength;
	}

 	var DhcpV6SServer = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server, Enable|DHCPv6LeaseTime, DhcpV6Server);%>;  
	var DhcpV6ServerTemp = DhcpV6SServer[0];
     
    var Temp1 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetBr0Ipv6Address,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Address.{i},Alias|IPv6Address, Br0IPv6AddressClass);%>;
    var Br0IPv6Address = Temp1[0];

	var IPv6localAddress = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.X_TELEFONICA-ES_IPv6LanIntfAddress.UniqueLocalAddress);%>';

	var IPv6globalAddress = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.X_TELEFONICA-ES_IPv6LanIntfAddress.DelegatedAddress.1.IPv6InterfaceAddress);%>';

    var Temp2 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetIPv6Prefix,InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.IPv6Prefix.{i},Alias|ParentPrefix|ChildPrefixMask|Mode|Prefix|PreferredLifeTime|ValidLifeTime, Br0IPv6PrefixClass);%>;
    var Br0IPv6Prefix = Temp2[0];

    var Temp3 =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1, LanInterface, IPv6BindLanClass);%>;  
    var LanInterface = Temp3[0];

    var Temp4 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetRaConfig, InternetGatewayDevice.LANDevice.1.X_HW_RouterAdvertisement, ManagedFlag|OtherConfigFlag|mode|Enable|MTU, RaConfigInfoClass);%>;  
    var RaConfig = Temp4[0];
	
	var Temp5 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetUlaMode, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.ULAIPv6Prefix, ULAmode, UlaModeInfoClass);%>;  
    var UlaMode = Temp5[0];
	
    var Temp6 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetUlaPrefix, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.ULAIPv6Prefix.prefix.{i}, ULAPrefix|ULAPrefixLen|ValidLifetime|PreferredLifetime, UlaConfigInfoClass);%>;  
    var DefaultUla = new UlaConfigInfoClass("","fd00::1","64","7200","3600");
    var UlaConfig = (Temp6.length==1)?DefaultUla:Temp6[0];
    var Temp7 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_IPv6Config,DomainName|IPv6DNSConfigType|IPv6DNSWANConnection|IPv6DNSServers, IPv6DNSConfigClass);%>;
    var IPv6DNSConfig = Temp7[0];
	
	var TempLANIPv6 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server.Pool.1, MinAddress|MaxAddress|IAPDAddLength,stLanDhcp6Info);%>;
	var LANIPv6Interface = TempLANIPv6[0];
	
	var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
	var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
	var SonetHN8055QFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SONET_HN8055Q);%>';
	var CfgMode = '<%HW_WEB_GetCfgMode();%>';
	
	if ('TDE2' == CfgMode.toUpperCase())
	{
		lan_address_language['bbsp_dhcp'] = lan_address_language['bbsp_dhcp_tde'];
		lan_address_language['bbsp_slaac'] = lan_address_language['bbsp_slaac_tde'];
		lan_address_language['bbsp_enableDHCP6Smh'] = lan_address_language['bbsp_enableDHCP6Smh_tde'];
		lan_address_language['bbsp_enableRAmh'] = lan_address_language['bbsp_enableRAmh_tde'];
	}

	if ('1' == IsPTVDFFlag && curUserType != sysUserType)	
	{
		lan_address_language['bbsp_enableDHCP6Smh'] = lan_address_language['bbsp_enableDHCP6Smh'];
		lan_address_language['bbsp_enableRAmh'] = lan_address_language['bbsp_enableRAmh'];
	}	
    </script>
<script>
	function IsSonetUser()
	{
		if((SonetFlag == '1') && ('0' == SonetHN8055QFlag)
		   && curUserType != '0')
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	function getBr0Ipv6VisibleState() {
        if (CfgMode.toUpperCase() == "FIDNADESKAP") {
            return "DISABLE";
        }
        return "VISIBLE";
    }


	function IsSupportUlaCfg()
	{
		if(!isE8cAndCMCC())
		{
			return true;
		}
		
		return false;
	}
	
function isWanname(domain)
{
	if((null != domain) && (undefined != domain))
	{
		var domaina = domain.split('.'); 
		if(domaina[3] == null || undefined == domaina[3])
			return  true
		else
			return false;
	}
}

function IsValidWan(Wan)
{
    if (viettelflag == 1)
    {
        if (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
        {
            return false;
        }
    }    
    if (Wan.Mode != "IP_Routed")
    {
        return false;
    }

    if (Wan.IPv6Enable == "0")
    {
        return false;
    }

    return true;
}
 
var wan_domain = "";   
function IsinWanList(domain)
{

    var WanList = GetWanListByFilter(IsValidWan);
    var i = 0;
    
    for (i = 0; i < WanList.length; i++)
    {        
        if( domain == WanList[i].domain || domain == domainTowanname(WanList[i].domain)) 
        {
            wan_domain =  WanList[i].domain;
            return true;
        }
    }  
    return false;
    
}

	function SetDisplayULAConfig(sh)
	{
		setDisplay("UlaPrefixDEFHIDERow",sh);
		setDisplay("ULAPrefixLenDEFHIDERow",sh);
		setDisplay("UlaPreferredLifetimeDEFHIDERow",sh);
		setDisplay("UlaValidLifetimeDEFHIDERow",sh);
	}
	
	function displayRAMtu()
	{
		setText("RAMXUCol", RaConfig.MTU);	
    	if ("ARABIC" == LoginRequestLanguage.toUpperCase())
    	{
        	document.getElementById("RAMXUColRemark").innerHTML = "(" + specIPoEMTUMax + "-1280)";
    	}
    	else
    	{
    		  document.getElementById("RAMXUColRemark").innerHTML = "(1280-" + specIPoEMTUMax + ")";
    	}
	}

    function BindPageData()
    {
        setText("IPv6Address", Br0IPv6Address.IPv6Address);
        
        setDisplay("IPv6Address", 1);
        setDisable("IPv6Address", 0);
        if (getBr0Ipv6VisibleState() == "DISABLE") {
            setDisable("IPv6Address", 1);
        }

        setText("IPv6localAddress", IPv6localAddress);
		setText("IPv6globalAddress", IPv6globalAddress);
		
        setText("Prefix", Br0IPv6Prefix.Prefix);
        setText("PreferredLifeTime", ((Br0IPv6Prefix.PreferredLifeTime == 0) ? 3600 : Br0IPv6Prefix.PreferredLifeTime));
        setText("ValidLifeTime", ((Br0IPv6Prefix.ValidLifeTime == 0) ? 7200 : Br0IPv6Prefix.ValidLifeTime));
        setSelect("PreFixModeList", Br0IPv6Prefix.Mode);
        setSelect("WanNameList", Br0IPv6Prefix.ParentPrefix);
        setText("SubPrefixMask", Br0IPv6Prefix.ChildPrefixMask);
        setSelect("ResourceAllocModeList", RaConfig.Mode);
        if (ebgWebFlag == '1') {
            setText('IAPDLength', LANIPv6Interface.IAPDAddLength);
        }
        if (SonetFlag != '1')
        {
            displayRAMtu(); 	
        }
       
        var EnableDhcpv6 = DhcpV6ServerTemp.Enable;
        setCheck("EnablePrefixAssignment", RaConfig.Enable); 	
        setCheck("EnableDHCPv6Server", EnableDhcpv6); 
        
		
		if('TDE2' == CfgMode.toUpperCase())
		{
			var Dhcpv6LeaseTime = DhcpV6ServerTemp.DHCPv6LeaseTime;
			if ('0' == Dhcpv6LeaseTime)
			{
				setRadio("leasetime", '0');
			}
			if ('-1' == Dhcpv6LeaseTime)
			{
				setRadio("leasetime", '-1');
			}
			
			if ((Dhcpv6LeaseTime != '-1') && (Dhcpv6LeaseTime != '0'))
			{
				setText("specificvalue", Dhcpv6LeaseTime);
			}
			else
			{
				setText("specificvalue", '');
			}
		}
		
        if ((RaConfig.Mode == "Manual")||(RaConfig.Mode == "StrictManual"))
        {
            setRadio("AssignType", RaConfig.ManagedFlag);
            setRadio("OtherType", RaConfig.OtherConfigFlag);    
            setDisplay("AssignTypeRow", 1); 
			CtrlIPAddressRow(1); 
			if('TDE2' != CfgMode.toUpperCase())
            {
            	setDisplay("OtherTypeRow", 1);
            }
        }
        else
        {
            setRadio("AssignType", RaConfig.ManagedFlag);
            setRadio("OtherType", RaConfig.OtherConfigFlag); 
            setDisplay("AssignTypeRow", 0);  
			CtrlIPAddressRow(0); 
			setDisplay("OtherTypeRow", 0);  
        }
        
		if ('1' == IsPTVDFFlag && curUserType != sysUserType)
		{
			setDisplay("AssignTypeRow", 0);  
			setDisplay("OtherTypeRow", 0);
		}
        setSelect("Ipv6landnsList", IPv6DNSConfig.IPv6DNSConfigType);   
        
        
        if(IsinWanList(IPv6DNSConfig.IPv6DNSWANConnection))  
        {                      
        	setSelect("Ipv6wanname", wan_domain);
        }

        
        var Ipv6DnsServer = IPv6DNSConfig.IPv6DNSServers.split(",");       
        setText("Ipv6PrimaryDNS", ((Ipv6DnsServer.length >= 1) ? Ipv6DnsServer[0] : ""));
        setText("Ipv6secondDNS", ((Ipv6DnsServer.length >= 2) ? Ipv6DnsServer[1] : ""));
		
		if (IsSupportUlaCfg() == true)
		{
			if ("" == UlaMode)
			{
				setDisplay("ULAmodeDEFHIDERow",0);
				setDisplay("UlaTipsTitleDEFHIDE",0);	
				setDisplay("UlaInfoSpace",0);
				SetDisplayULAConfig(0);					
			}
			else
			{
				setSelect("ULAmodeDEFHIDE",UlaMode.ULAmode);
				setDisplay("ULAmodeDEFHIDERow",1);
				setDisplay("UlaTipsTitleDEFHIDE",1);	
				setDisplay("UlaInfoSpace",1);
				SetDisplayULAConfig(1);	
			}
			
			if ("" == UlaConfig)
			{
				setText("UlaPrefixDEFHIDE", "");		
				setText("ULAPrefixLenDEFHIDE", "");		
				setText("UlaPreferredLifetimeDEFHIDE", "");	
				setText("UlaValidLifetimeDEFHIDE", "");
			}
			
			if (("" != UlaMode) && ("" != UlaConfig))
			{
				setSelect("ULAmodeDEFHIDE",UlaMode.ULAmode);
				setText("UlaPrefixDEFHIDE", UlaConfig.ULAPrefix);		
				setText("ULAPrefixLenDEFHIDE", UlaConfig.ULAPrefixLen);		
				setText("UlaPreferredLifetimeDEFHIDE", UlaConfig.PreferredLifetime);	
				setText("UlaValidLifetimeDEFHIDE", UlaConfig.ValidLifetime);	

				if (0 == RaConfig.ManagedFlag)
				{
					setDisplay("ULAmodeDEFHIDERow",1);
					setDisplay("UlaTipsTitleDEFHIDE",1);	
					setDisplay("UlaInfoSpace",1);
					
					if ("MANUAL" == UlaMode.ULAmode.toUpperCase()) 
					{
						SetDisplayULAConfig(1);
					}
					else
					{
						SetDisplayULAConfig(0);
					}
				}
				else
				{
					setDisplay("ULAmodeDEFHIDERow",0);
					setDisplay("UlaTipsTitleDEFHIDE",0);
					setDisplay("UlaInfoSpace",0);	
					SetDisplayULAConfig(0);	
				}
			}
		}
	   Ipv6landnsSelect(IPv6DNSConfig.IPv6DNSConfigType);
	   PreFixModeSelect(Br0IPv6Prefix.Mode);
		
        var LanInterfaceList = LanInterface.LanInterface.split(",");
        for (var i = 0; i < LanInterfaceList.length; i++)
        {
            setCheck(LanInterfaceList[i].toUpperCase(), "1");	
        }
        return true;
    
    }

	function AddPrefixInstance()
	{
		if(UlaConfig.domain != '')
		{	
			return ;
		}
		var Onttoken = getValue('onttoken');
		
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : 'o.ULAPrefix=' + UlaConfig.ULAPrefix + '&o.ULAPrefixLen=' + UlaConfig.ULAPrefixLen 
		       + '&o.PreferredLifetime=' + UlaConfig.PreferredLifetime + '&o.ValidLifetime=' + UlaConfig.ValidLifetime + '&x.X_HW_Token=' + Onttoken,
		url :  'add.cgi?o=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.ULAIPv6Prefix.prefix'
		       + '&RequestFile=html/ipv6/not_find_file.asp',
		error:function(XMLHttpRequest, textStatus, errorThrown) 
		{
			if(XMLHttpRequest.status == 404)
			{
				UlaConfig.domain = 'InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_IPv6Interface.1.ULAIPv6Prefix.prefix.1';
			}
		}
		});	
	}

    function OnPageLoad()
    {
        if ((isDualWanUpProduct === '1') && (isDualWanUpCfg === '1')) {
            setCheck("ipv6Enable", IsIPProtocolVersionEnable === '3' ? 1 : 0);
            setDisplay("ipv6EnableSwitch", 1);
            if (IsIPProtocolVersionEnable === '1') {
                setDisplay("InterfaceAddrInfoForm", 0);
                setDisplay("DnsInfoForm", 0);
                setDisplay("ResourceAllocationForm", 0);
                setDisplay("UlaInfoForm", 0);
                setDisplay("ConfigPanelButtons", 0);
                return;
            }
        }
        BindPageData();
		BindDHCPv6Info();
		if(IsSonetUser())
		{
			setDisplay("InterfaceAddrInfoForm",0);  
		}
			
		if(SonetFlag == '1')
		{
		  setDisplay("RAMXUColRow",0);
		}
		
		if (IsSupportUlaCfg() == true)
		{
			setDisplay("UlaInfoForm",1);
		}
		else
		{
			setDisplay("UlaInfoForm",0);
		}

		if('TDE2' != CfgMode.toUpperCase())
		{
			setDisplay("IPv6localAddressRow",0);
			setDisplay("IPv6globalAddressRow",0);
		}
		else
		{
			setDisplay("IPv6AddressRow", 0);
			setDisable("IPv6localAddress",1);
			setDisable("IPv6globalAddress",1);
			setDisplay("OtherTypeRow",0);
			setDisplay("ResourceAllocModeListRow",0);		
		}
		
		if (1 == IsPTVDFFlag)
		{
			if(curUserType == sysUserType)
			{
				setDisplay("InterfaceAddrInfoForm", 1);		
				setDisplay("UlaInfoForm", 1);	
			}
			else
			{
				setDisplay("InterfaceAddrInfoForm", 0);	
				setDisplay("ResourceAllocModeListRow", 0);	
				setDisplay("AssignTypeRow", 0);	
				setDisplay("OtherTypeRow", 0);	
				setDisplay("UlaInfoForm", 0);	
			}		
		}
		
		setDisplay("DnsInfoForm",1);

		if(1 == IsPTVDFFlag || 1 == IsSAFARICOMFlag)
		{
			if(IsDNSLockEnable == "1")
			{
				setDisable("Ipv6landnsList",1);
				setDisable("Ipv6wanname",1);
				setDisable("Ipv6PrimaryDNS",1);
				setDisable("Ipv6secondDNS",1);
			}
			else
			{
				setDisable("Ipv6landnsList",0);
				setDisable("Ipv6wanname",0);
				setDisable("Ipv6PrimaryDNS",0);
				setDisable("Ipv6secondDNS",0);
			}
			if(curUserType != sysUserType)
			{
				if("1" == IsIPProtocolVersionEnable )
				{
					setDisable("EnablePrefixAssignment",1);
					setDisable("EnableDHCPv6Server",1);
				}
				else
				{
					setDisable("EnablePrefixAssignment",0);
					setDisable("EnableDHCPv6Server",0);
				}
			}

		}

		if (CfgMode.toUpperCase() === "ELISAAP") {
			CurIPv6ConnectSelect = (curIpv6ConnectType == 0) ? "ipv6Router" : "ipv6Bridge";
			setRadio("idIpv6ConnectionType", CurIPv6ConnectSelect);
			setDisplay('IPv6ConnectionType', 1);
			showOtherForm(curIpv6ConnectType == 0);
		}

        return true;
    }
    
    function CheckTimeValue(PreferredTime, VaildTime)
    {
    	PreferredTime = removeSpaceTrim(PreferredTime);
	if(PreferredTime!="")
	{
	   if ( false == CheckNumber(PreferredTime, 600, 4294967295) )
	   {
			AlertEx(lan_address_language['bbsp_preferredtimeinvaild']);
			return false;
	   }
	}
	else
	{
		AlertEx(lan_address_language['bbsp_preferredtimereq']);
		return false;
	}

	VaildTime = removeSpaceTrim(VaildTime);
	
	if(VaildTime!="")
	{
	   if ( false == CheckNumber(VaildTime, 600, 4294967295) )
	   {
			AlertEx(lan_address_language['bbsp_vaildtimeinvaild']);
			return false;
	   }
	}
	else
	{
		AlertEx(lan_address_language['bbsp_vaildtimereq']);
		return false;
	}

	if (parseInt(VaildTime, 10) < parseInt(PreferredTime, 10))
	{
		AlertEx(lan_address_language['bbsp_vaildtimereqvalue']);
		return false; 
	}
	
	return true;
    }

    function CheckIpAddPrefix(Ipv6AddPrefix)
    {
            if (Ipv6AddPrefix.length == 0)
	    {
	        AlertEx(lanaddr_Languages['IPv6PrefixEmpty']);
	        return false;
	    }
	    var List = Ipv6AddPrefix.split("/");
	    if (List.length != 2)
	    {
	        AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
	        return false;
	    }
	    if ('' == List[1])
	    {
	        AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
	        return false;
	    }
	    if ( List[1].length > 1 && List[1].charAt(0) == '0' )
	    {
	         AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
	         return false;  
	    }
	    if (parseInt(List[1],10) < 1 || isNaN(List[1].replace(' ', 'a')) == true || parseInt(List[1],10) > 64)
	    {
            	AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
            	return false;    
	    }
	    if (IsIPv6AddressValid(List[0]) == false)
	    {
            	AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
            	return false;  
	    }
	    if ( IsIPv6ZeroAddress(List[0]) == true)
	    {
            	AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
            	return false;  
	    } 
	    if (parseInt(List[0].split(":")[0], 16) >= parseInt("0xFF00", 16))
            {
                AlertEx(lanaddr_Languages['IPv6PrefixInvalid']);
                return false;   
            }  
    }
    
    function CheckParameter()
    { 
		var result = false;
		var IPAddress = getValue("IPv6Address");
		var WANName = getSelectVal("Ipv6wanname");
		var DNSSourceMode = getSelectVal("Ipv6landnsList");
		var IpPrimaryDNS = getValue("Ipv6PrimaryDNS");
		var IpsecondDNS = getValue("Ipv6secondDNS");
		var RAMXU = getValue("RAMXUCol");
		var LeaseTimeSpec = getValue("specificvalue");

		if (ebgWebFlag == '1') {
		    var IAPDLength = getValue("IAPDLength");
			if ((IAPDLength == '') || (isNum(IAPDLength) == false) || (parseInt(IAPDLength,10) < 1) || (parseInt(IAPDLength,10) > 64)) {
				AlertEx(lanaddr_Languages['IAPDAlert']);
				return false;
			}
		}
		if (RAMXU == '' || (false == isNum(RAMXU)) || isNaN(RAMXU) || parseInt(RAMXU,10) > parseInt(specIPoEMTUMax, 10) || parseInt(RAMXU,10) < 1280)
		{
			if (SonetFlag != '1')
			{
	   		if ('1500' == specIPoEMTUMax)
				{
			   		AlertEx(Languages['RAMxuAlert']);
				}
				else
				{
					AlertEx(Languages['MTUInvalid']);				
				}
			  return false;
		  }
		}

		if(DNSSourceMode.toUpperCase() == "STATIC")
		{
			if(IpPrimaryDNS.length == 0 && IpsecondDNS.length == 0)
			{
				AlertEx(lan_address_language['bbsp_ipv6isreq']);
				return false;
			}
			
			if(IpPrimaryDNS.length != 0)
			{
				if (IsIPv6AddressValid(IpPrimaryDNS) == false)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;
				}
				if (IsIPv6MulticastAddress(IpPrimaryDNS) == true)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;  
				} 
				if (IsIPv6ZeroAddress(IpPrimaryDNS) == true)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;
				}
				if (IsIPv6LoopBackAddress(IpPrimaryDNS) == true)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;  
				}
			}
			
			if(IpsecondDNS.length != 0)
			{
				if (IsIPv6AddressValid(IpsecondDNS) == false)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;
				}
				if (IsIPv6MulticastAddress(IpsecondDNS) == true)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;  
				} 
				if (IsIPv6ZeroAddress(IpsecondDNS) == true)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;
				}
				if (IsIPv6LoopBackAddress(IpsecondDNS) == true)
				{
					AlertEx(lan_address_language['bbsp_ipv6invalid']);
					return false;  
				}
			}
		}
		
		if(false == IsSonetUser())
		{
			if (IPAddress.length == 0)
			{
				AlertEx(lan_address_language['bbsp_ipv6isreq']);
				return false;
			}
	
			if (IsIPv6AddressValid(IPAddress) == false)
			{
				AlertEx(lan_address_language['bbsp_ipv6invalid']);
				return false;
			}

			if (IsIPv6MulticastAddress(IPAddress) == true)
			{
				AlertEx(lan_address_language['bbsp_ipv6invalid']);
				return false;  
			} 
	
			if (IsIPv6ZeroAddress(IPAddress) == true)
			{
				AlertEx(lan_address_language['bbsp_ipv6invalid']);
				return false;
			}
	
			if (IsIPv6LoopBackAddress(IPAddress) == true)
			{
				AlertEx(lan_address_language['bbsp_ipv6invalid']);
				return false;  
			}
	
			if(getValue("SubPrefixMask").length == 0)
			{
				AlertEx(lan_address_language['bbsp_premaskisreq']);
				return false;  
			}

			var List = getValue("SubPrefixMask").split("/");
			if (List.length != 2)
			{
				AlertEx(lan_address_language['bbsp_premaskinvalid']);
				return false;   
			}
			if (parseInt(List[1],10) < 1 || isNaN(List[1].replace(' ', 'a')) == true || parseInt(List[1],10) != 64)
			{
				AlertEx(lan_address_language['bbsp_premaskinvalid']);
				return false;    
			}
			if (IsIPv6AddressValid(List[0]) == false)
			{
				AlertEx(lan_address_language['bbsp_premaskinvalid']);
				return false;  
			} 
		}
		
		if (IsSupportUlaCfg() == true)
		{
			var PrefixAssignType = getRadioVal('AssignType');
			var UlaMode = getValue('ULAmodeDEFHIDE');
			var UlaPrefix = getValue('UlaPrefixDEFHIDE');
			var UlaPrefixLen = getValue('ULAPrefixLenDEFHIDE');
			var UlaPreferredTime = getValue('UlaPreferredLifetimeDEFHIDE');
			var UlaVaildTime = getValue('UlaValidLifetimeDEFHIDE');
						
			if (0 == PrefixAssignType)
			{
				if ("MANUAL" == UlaMode.toUpperCase()) 
				{
					if (UlaPrefix.length == 0)
					{
						AlertEx(lan_address_language['bbsp_prefixisreq']);
						return false;
					}
					
					if (IsIPv6AddressValid(UlaPrefix) == false)
					{
						AlertEx(lan_address_language['bbsp_ipv6invalid']);
						return false;
					}
					
					if (IsIPv6UlaAddress(UlaPrefix) == false)
					{
						AlertEx(lan_address_language['bbsp_prefixinvaild']);
						return false;  
					} 
					
					UlaPrefixLen = removeSpaceTrim(UlaPrefixLen);
					if(UlaPrefixLen!="")
					{
					   if ( false == CheckNumber(UlaPrefixLen, 16, 64) )
					   {
							AlertEx(lan_address_language['bbsp_prefixlengthinvaild']);
							return false;
					   }
					}
					else
					{
						AlertEx(lan_address_language['bbsp_prefixlenisreq']);
						return false;
					}
					
					UlaPreferredTime = removeSpaceTrim(UlaPreferredTime);
					if(UlaPreferredTime!="")
					{
					   if ( false == CheckNumber(UlaPreferredTime, 600, 4294967295) )
					   {
							AlertEx(lan_address_language['bbsp_preferredtimeinvaild']);
							return false;
					   }
					}
					else
					{
						AlertEx(lan_address_language['bbsp_preferredtimereq']);
						return false;
					}

					UlaVaildTime = removeSpaceTrim(UlaVaildTime);
					if(UlaVaildTime!="")
					{
					   if ( false == CheckNumber(UlaVaildTime, 600, 4294967295) )
					   {
							AlertEx(lan_address_language['bbsp_vaildtimeinvaild']);
							return false;
					   }
					}
					else
					{
						AlertEx(lan_address_language['bbsp_vaildtimereq']);
						return false;
					}

					if (parseInt(UlaVaildTime, 10) < parseInt(UlaPreferredTime, 10))
					{
						AlertEx(lan_address_language['bbsp_vaildtimereqvalue']);
						return false; 
					}
				}
			}
		}
		
		
		var Ipv6PrefixMode = getSelectVal("PreFixModeList");
		
		if ("STATIC" == Ipv6PrefixMode.toUpperCase() && false == IsSonetUser()) 
		{
		
			var Ipv6AddPrefix = getValue("Prefix");
			if (false == CheckIpAddPrefix(Ipv6AddPrefix))
			{
				return false;
			}	
			var Ipv6PreferredLifeTime = getValue("PreferredLifeTime");
			var Ipv6ValidLifeTime = getValue("ValidLifeTime");
				
			if (false == CheckTimeValue(Ipv6PreferredLifeTime, Ipv6ValidLifeTime))
			{
				return false;
			}	
		}
		
		if('1' == getRadioVal("AssignType") && ('TDE2' == CfgMode.toUpperCase()))
		{
			var StartIPAddr = $.trim(getValue('StartIPAddress'));
			var EndIPAddr = $.trim(getValue('EndIPAddress'));
			
			if(!IsIPv6AddressValid(StartIPAddr) || !IsIPv6AddressValid(EndIPAddr))
			{
				AlertEx(lan_address_language['bbsp_ipv6invalid']);
				return false;
			}
			
			var prefix1 = ParseBackIPv6Para(StartIPAddr, 64) + ':';
			var prefix2 = ParseBackIPv6Para(EndIPAddr, 64) + ':';
			var StartIPAddr1 = ParseBackIPv6Para(StartIPAddr, 128);
			var EndIPAddr1 = ParseBackIPv6Para(EndIPAddr, 128);
	
			var MinAddr = StartIPAddr1.substring(prefix1.length, StartIPAddr1.length);
			var MaxAddr = EndIPAddr1.substring(prefix2.length, EndIPAddr1.length);
	
			if(!Dhcpv6ServerAddrChk(MinAddr, MaxAddr))
			{
				return false;
			}
		}
		
		if (('TDE2' == CfgMode.toUpperCase()) && (getElement("leasetime")[1].checked == true))
		{
			if(LeaseTimeSpec != '')
			{
				LeaseTimeSpec = removeSpaceTrim(LeaseTimeSpec);
				if ( false == CheckNumber(LeaseTimeSpec, 600, 2147483647) )
				{
					AlertEx(lan_address_language['bbsp_leasetimeinvalid']);
					return false;
				}
			}
		}
		
		result = true;
		if ((Br0IPv6Address.IPv6Address.toUpperCase() == GetCurrentLoginIP())
			&& (getValue('IPv6Address').toUpperCase() != Br0IPv6Address.IPv6Address.toUpperCase()))
		{
			result = ConfirmEx(lan_address_language['bbsp_confirmnote']);
		}
	
		if ( result == true )
		{
			setDisable('ButtonApply', 1);
			setDisable('ButtonCancel', 1);
		}
		
		return result; 
    }
	
    function GetLanList()
    {
        var List = "";
        for (var i = 1; i <=4; i++)
        {
            if (getCheckVal("LAN"+i) == 1)
            {
             		List += "LAN"+i +",";
            }
            if (getCheckVal("SSID"+i) == 1)
            {
             		List += "SSID"+i +",";
            }
        }
        if (List.length > 0)
        {
         		List = List.substr(0, List.length-1);
        }
         
        return List;
     }
     function GetIpv6WanDnsServerString(PrimaryDnsServer, SecondaryDnsServer)
	{
		var DnsServerString = "";
		if ("" != PrimaryDnsServer && "" != SecondaryDnsServer)
		{
			DnsServerString = PrimaryDnsServer + "," + SecondaryDnsServer;
		}
		else
		{
			DnsServerString = PrimaryDnsServer  + SecondaryDnsServer;
		}
		return DnsServerString;
	}
	
	function getLeaseTime()
	{
		if(getElement("leasetime")[0].checked == true)
		{
			return -1;
		}
		else if(getElement("leasetime")[1].checked == true)
		{
			if ('' == getValue("specificvalue"))
			{
				return 0;
			}
			else
			{
				return getValue("specificvalue");
			}
		}
		return 0;
	}

    function OnApplyButtonClick()
    {
        if (CheckParameter() == false)
        {
            return false;
        }
        if(IsSupportUlaCfg() == true)
        {
       	 	AddPrefixInstance();
		}

		if('1' == getRadioVal("AssignType") && ('TDE2' == CfgMode.toUpperCase()))
		{
			var StartIPAddr = $.trim(getValue('StartIPAddress'));
			var EndIPAddr = $.trim(getValue('EndIPAddress'));
			var MinAddr = "";
			var MaxAddr = "";
			var prefix1 = ParseBackIPv6Para(StartIPAddr, 64) + ':';
			var prefix2 = ParseBackIPv6Para(EndIPAddr, 64) + ':';
			var StartIPAddr1 = ParseBackIPv6Para(StartIPAddr, 128);
			var EndIPAddr1 = ParseBackIPv6Para(EndIPAddr, 128);
	
			MinAddr = StartIPAddr1.substring(prefix1.length, StartIPAddr1.length);
			MaxAddr = EndIPAddr1.substring(prefix2.length, EndIPAddr1.length);

		}
	
        var url = "";
        var Form = new webSubmitForm();
		if(false == IsSonetUser())
		{
			if (getBr0Ipv6VisibleState() == "VISIBLE") {
				Form.addParameter('x.IPv6Address', getValue("IPv6Address"));
			}
			Form.addParameter('y.Prefix', getValue("Prefix"));
			Form.addParameter('y.PreferredLifeTime', getValue("PreferredLifeTime"));
			Form.addParameter('y.ValidLifeTime', getValue("ValidLifeTime"));
			Form.addParameter('y.Mode', getSelectVal("PreFixModeList"));
			Form.addParameter('y.ParentPrefix',getSelectVal("WanNameList"));
			Form.addParameter('y.ChildPrefixMask',getValue("SubPrefixMask"));
		}
		if (SonetFlag != '1')
		{
			Form.addParameter('m.MTU',getValue("RAMXUCol"));
        }
        Form.addParameter('z.LanInterface',GetLanList());
		if('TDE2' != CfgMode.toUpperCase())
		{
			Form.addParameter('m.mode',getSelectVal("ResourceAllocModeList"));
		}

		var RAMode = getSelectVal("ResourceAllocModeList");
		if (( RAMode == "Manual" )||( RAMode == "StrictManual" ))
        {
            Form.addParameter('m.ManagedFlag',getRadioVal("AssignType"));
			if('TDE2' != CfgMode.toUpperCase())
			{
				Form.addParameter('m.OtherConfigFlag',getRadioVal("OtherType"));
			}
			
			if(('1' == getRadioVal("AssignType")) && ('TDE2' == CfgMode.toUpperCase()))
			{
				Form.addParameter('q.MinAddress', MinAddr);
				Form.addParameter('q.MaxAddress', MaxAddr);
				var leaseTime = getLeaseTime();
				Form.addParameter('r.DHCPv6LeaseTime',leaseTime);
			}
        }
		
          
        var PAEnable = getCheckVal("EnablePrefixAssignment");
        var DHCPv6ServerEnable = getCheckVal("EnableDHCPv6Server");
            
		Form.addParameter('m.Enable',PAEnable);
		Form.addParameter('r.Enable',DHCPv6ServerEnable);
		
        Form.addParameter('p.IPv6DNSConfigType',getSelectVal("Ipv6landnsList"));
        Form.addParameter('p.IPv6DNSWANConnection',getSelectVal("Ipv6wanname")); 
        Form.addParameter('p.IPv6DNSServers',GetIpv6WanDnsServerString(getValue("Ipv6PrimaryDNS"), getValue("Ipv6secondDNS")));
		
		if('TDE2' == CfgMode.toUpperCase())
		{
			url = 'x='+Br0IPv6Address.domain+"&y="+Br0IPv6Prefix.domain +"&z="+LanInterface.domain+ "&p="+IPv6DNSConfig.domain+ "&m=InternetGatewayDevice.LANDevice.1.X_HW_RouterAdvertisement"
				+ '&q=InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server.Pool.1' + '&r=InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server';
		}
		else
		{
			url = 'x='+Br0IPv6Address.domain+"&y="+Br0IPv6Prefix.domain +"&z="+LanInterface.domain+ "&p="+IPv6DNSConfig.domain+ "&m=InternetGatewayDevice.LANDevice.1.X_HW_RouterAdvertisement"
			    + '&r=InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server';
		}
		
		if (IsSupportUlaCfg() == true)
		{
			if (0 == getRadioVal('AssignType')) 
			{
				Form.addParameter('n.ULAmode', getValue('ULAmodeDEFHIDE'));
				url += "&n="+UlaMode.domain;
				if ("MANUAL" == getValue('ULAmodeDEFHIDE').toUpperCase()) 
				{	
					var UlaPrefixLen = getValue('ULAPrefixLenDEFHIDE');
					UlaPrefixLen = removeSpaceTrim(UlaPrefixLen);
					var UlaPreferredTime = getValue('UlaPreferredLifetimeDEFHIDE');
					UlaPreferredTime = removeSpaceTrim(UlaPreferredTime);
					var UlaVaildTime = getValue('UlaValidLifetimeDEFHIDE');
					UlaVaildTime = removeSpaceTrim(UlaVaildTime);

					Form.addParameter('o.ULAPrefix', getValue('UlaPrefixDEFHIDE'));
					Form.addParameter('o.ULAPrefixLen', UlaPrefixLen);
					Form.addParameter('o.PreferredLifetime', UlaPreferredTime);
					Form.addParameter('o.ValidLifetime', UlaVaildTime);
					url += "&o="+UlaConfig.domain;					
				}
			}
		}

		if (ebgWebFlag == '1') {
			Form.addParameter('t.IAPDAddLength',getValue("IAPDLength"));
			url += "&t=InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server.Pool.1";
		}
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		
		Form.setAction('set.cgi?' + url + '&RequestFile=html/bbsp/lanaddress/lanaddress.asp');
        Form.submit();
		
        setDisable('ButtonApply',1);
    	setDisable('ButtonCancel',1);
        return false;
    }

    function OnCancelButtonClick()
    {       
        BindPageData();
        return false;
    }
	
	function ulaSelect(val)
	{
		var UlaMode = val.value;
		if ("MANUAL" == UlaMode.toUpperCase()) 
		{
			SetDisplayULAConfig(1);
			if ("" == getValue("UlaPrefixDEFHIDE"))
			{
				setText("UlaPrefixDEFHIDE", "fd00::1");	
			}
			
			if ("" == getValue("ULAPrefixLenDEFHIDE"))
			{
				setText("ULAPrefixLenDEFHIDE", "16");	
			}
			
			if ("" == getValue("UlaPreferredLifetimeDEFHIDE"))
			{
				setText("UlaPreferredLifetimeDEFHIDE", "3600");
			}
			
			if ("" == getValue("UlaValidLifetimeDEFHIDE"))
			{
				setText("UlaValidLifetimeDEFHIDE", "7200");
			}
		}
		else
		{
			SetDisplayULAConfig(0);
		}
	}
	
	function ResouceAllocSelect()
	{
		var resourceallocmode = getValue("ResourceAllocModeList");
	    if ((resourceallocmode == "Manual")||(resourceallocmode == "StrictManual"))
	    {
	        setDisplay("AssignTypeRow", 1); 
			CtrlIPAddressRow(1);  
	        setDisplay("OtherTypeRow", 1);  
	    }
	    else
	    {
	        setDisplay("AssignTypeRow", 0); 
			CtrlIPAddressRow(0);  
	        setDisplay("OtherTypeRow", 0);  
	    }
	}
	
	function PreFixModeSelect()
	{
	    var  PreFixModeValue =  getValue("PreFixModeList");
		if ("STATIC" == PreFixModeValue.toUpperCase()) 
		{
			setDisplay("PrefixRow", 1);  
			setDisplay("PreferredLifeTimeRow", 1);
			setDisplay("ValidLifeTimeRow", 1);
			setDisplay("WanNameListRow", 0);
			setDisplay("SubPrefixMaskRow", 0);		
		}
		else
		{
		    setDisplay("PrefixRow", 0);  
			setDisplay("PreferredLifeTimeRow", 0);
			setDisplay("ValidLifeTimeRow", 0);
			setDisplay("WanNameListRow", 1);
			setDisplay("SubPrefixMaskRow", 1);
		}		
	}
	
	function Ipv6landnsSelect(val)
	{
		var Ipv6landns = getValue("Ipv6landnsList");
		if ("WANCONNECTION" == Ipv6landns.toUpperCase()) 
		{	
			setDisplay("Ipv6wannameRow",1);
			setDisplay("Ipv6PrimaryDNSRow", 0);
			setDisplay("Ipv6secondDNSRow", 0);
			
		}
		else if ("STATIC" == Ipv6landns.toUpperCase()) 
		{
			
			setDisplay("Ipv6PrimaryDNSRow", 1);
		    setDisplay("Ipv6secondDNSRow", 1);
		    setDisplay("Ipv6wannameRow", 0);
				
			if ("FE80::1" == getValue("Ipv6PrimaryDNS").toUpperCase() && "STATIC" != IPv6DNSConfig.IPv6DNSConfigType.toUpperCase())
		    {
				setText("Ipv6PrimaryDNS", "");
		    }
		}
		else
		{
			setDisplay("Ipv6PrimaryDNSRow", 0);
		    setDisplay("Ipv6secondDNSRow", 0);
		    setDisplay("Ipv6wannameRow", 0);
		}		
	}

	function ChangePrefixCfgMode(obj)
	{
		if (IsSupportUlaCfg() == true)
		{
			if ("" != UlaMode)
			{
				setSelect("ULAmodeDEFHIDE",UlaMode.ULAmode);
				
				if (0 == getRadioVal('AssignType')) 
				{
					setDisplay("ULAmodeDEFHIDERow",1);
					setDisplay("UlaTipsTitleDEFHIDE",1);	
					setDisplay("UlaInfoSpace",1);
					
					if ("MANUAL" == UlaMode.ULAmode.toUpperCase()) 
					{
						SetDisplayULAConfig(1);
					}
					else
					{
						SetDisplayULAConfig(0);
					}
				}
				else
				{			
					setDisplay("ULAmodeDEFHIDERow",0);
					setDisplay("UlaTipsTitleDEFHIDE",0);	
					setDisplay("UlaInfoSpace",0);
					SetDisplayULAConfig(0);
				}
			}
		}

		if(obj.value == "1")
		{
			CtrlIPAddressRow(1);
		}
		else
		{
			CtrlIPAddressRow(0);
		}
	}
	
    function ControlLanList(LanIdPrefix, SSIDPrefix)
    {
        for (var i = 1; i <= parseInt(TopoInfo.EthNum,10); i++)
        {
            if (IsL3Mode(i) == "0")
            {
                setDisable(LanIdPrefix+i, 1);
            }
        }

        for (var i = parseInt(TopoInfo.EthNum,10)+1; i <= 4; i++)
        {
            setDisplay(LanIdPrefix+i, 0);
        }

        for (var i = parseInt(TopoInfo.SSIDNum,10)+1; i <= 4; i++)
        {
            setDisplay(SSIDPrefix+i, 0);
        }
    }

function InitIpv6landnsList()
{
	var List = getElementById("Ipv6landnsList");
	List.options.length = 0;
	if('TDE2' != CfgMode.toUpperCase())
	{
		List.options.add(new Option(lan_address_language['bbsp_HGWDNSProxy'],"HGWProxy"));
	}
	List.options.add(new Option(lan_address_language['bbsp_WANConnection'],"WANConnection"));
	List.options.add(new Option(lan_address_language['bbsp_StaticDNS'],"Static"));
}

function InitULAmodeDEFHIDE()
{
	var List = getElementById("ULAmodeDEFHIDE");
	List.options.length = 0;
	List.options.add(new Option(lan_address_language['bbsp_disable'],"Disable"));
	List.options.add(new Option(lan_address_language['bbsp_manualconfigure'],"Manual"));
	if('TDE2' != CfgMode.toUpperCase())
	{
		List.options.add(new Option(lan_address_language['bbsp_autoconfigure'],"Auto"));
	}
}

function ParseIPv6Prefix(IPv6Prefix)
{
	var TempPrefix = "";
	var Temp_list;
	var SegNumber = 4;
	var Prefix_list = IPv6Prefix.split('::');
	
	if(Prefix_list.length == 1)
	{
		TempPrefix = IPv6Prefix + ':';
	}
	else if(Prefix_list.length == 2)
	{
		Temp_list = IPv6Prefix.split(':');
		if(Temp_list.length >= parseInt(SegNumber + 2))
		{
			TempPrefix = IPv6Prefix.substring(0, IPv6Prefix.length - 1 );
		}
		else
		{
			if(IPv6Prefix.charAt(IPv6Prefix.length - 1) == ':')
			{
				TempPrefix = IPv6Prefix;
			}
			else
			{
				TempPrefix = IPv6Prefix + ':';
			}
		}
	}
	else
	{
		TempPrefix = '::';
	}
	
	return TempPrefix;
}

function MakeFullIPv6Address(IPv6Prefix, InterfaceID)
{
	var result = "";
	if(IPv6Prefix == "")
	{
		result = '::' + InterfaceID;
	}
	else
	{
		result = ParseIPv6Prefix(IPv6Prefix) + InterfaceID;
	}
	
	return result;
}

function ParseBackIPv6Para(IPv6Prefix, IPv6PrefixLen)
{
	var TempPrefix = "";
	var Temp_list;
	var SegNumber = parseInt(IPv6PrefixLen/16);
	var Ip_str = ":0:";
	var Prefix_list = IPv6Prefix.split('::');
	
	if(Prefix_list.length == 1)
	{
		Temp_list = IPv6Prefix.split(':');
		for(var i = 0; i < SegNumber; i++)
		{
			TempPrefix += Temp_list[i];
			if(i < (SegNumber - 1))TempPrefix += ':';
		}
	}
	else if(Prefix_list.length == 2)
	{
		if(Prefix_list[0] == "")Prefix_list[0] = "0";
		if(Prefix_list[1] == "")Prefix_list[1] = "0";
		
		var Ip_list = IPv6Prefix.split(':');
		for(i = 0; i < 8 - Ip_list.length; i++ )
		{
			Ip_str += "0:";
		}
		
		var Ip_Temp = Prefix_list[0] + Ip_str + Prefix_list[1];
		
		Temp_list = Ip_Temp.split(':');
		for(var i = 0; i < SegNumber; i++)
		{
			TempPrefix += Temp_list[i];
			if(i < (SegNumber - 1))TempPrefix += ':';
		}
	}
	else
	{
		TempPrefix = '::';
	}
	
	return TempPrefix;
}

function CtrlIPAddressRow(state)
{
	var flag = state;
	if('TDE2' != CfgMode.toUpperCase())
	{
		return false;
	}
	if('1' != getRadioVal("AssignType"))
	{
		flag = 0;
	}
	var RAMode = getSelectVal("ResourceAllocModeList");
	if(( RAMode != "Manual")&&( RAMode != "StrictManual"))
	{
		flag = 0;
	}
	
	setDisplay('StartIPAddressRow', flag);
	setDisplay('EndIPAddressRow', flag);
	setDisplay('DHCPv6LeaseTimecon', flag);
}

function ParBackOldPrefix(FullIPv6Addr)
{
	var tempAddr;
	var iplist = FullIPv6Addr.split(':');
	if(iplist.length < 8)
	{
		tempAddr = FullIPv6Addr;
	}
	else if((iplist[0] == 0) && (iplist[1] == 0) && (iplist[2] == 0) && (iplist[3] == 0))
	{
		tempAddr = '::' + iplist[4] + ':' + iplist[5] + ':' + iplist[6] + ':' + iplist[7];
	}
	else
	{
		tempAddr = FullIPv6Addr;
	}
	
	return tempAddr;
}

function BindDHCPv6Info()
{
	if('1' == RaConfig.ManagedFlag)
	{
		CtrlIPAddressRow(1);
	}
	else
	{
		CtrlIPAddressRow(0);
	}

	var newBr0IPv6Prefix = "";
	if ('TDE2' != CfgMode.toUpperCase())
	{
		newBr0IPv6Prefix = ParseBackIPv6Para(Br0IPv6Prefix.Prefix, 64);
	}
	else
	{
		newBr0IPv6Prefix = Br0IPv6Prefix.Prefix;
		var prifix = newBr0IPv6Prefix.split('/')[0];
		var length = newBr0IPv6Prefix.split('/')[1];
		newBr0IPv6Prefix = PutPrefix(prifix, length);
	}
	var StartIPAddress_text = MakeFullIPv6Address(newBr0IPv6Prefix, LANIPv6Interface.MinAddress);
	var EndIPAddress_text = MakeFullIPv6Address(newBr0IPv6Prefix, LANIPv6Interface.MaxAddress);
	
	setText('StartIPAddress', ParBackOldPrefix(StartIPAddress_text));
	setText('EndIPAddress', ParBackOldPrefix(EndIPAddress_text));
	if (ebgWebFlag == '1') {
		setText('IAPDLength', LANIPv6Interface.IAPDAddLength);
	}
}

function IPv6AddrChk(ipv6Addr)
{
	if (IsIPv6AddressValid(ipv6Addr) == false)
	{
		return false;
	}
	if (IsIPv6MulticastAddress(ipv6Addr) == true)
	{
		return false;  
	} 
	if (IsIPv6ZeroAddress(ipv6Addr) == true)
	{
		return false;
	}
	if (IsIPv6LoopBackAddress(ipv6Addr) == true)
	{
		return false;  
	}
	
	return true;
}

function Dhcpv6ServerAddrChkConvert(ipv6DhcpAddr)
{
    var j = 0;
    var standIpv6Addr = "";
    for(var i = 0; i < ipv6DhcpAddr.length; i++){
        if(":" == ipv6DhcpAddr.charAt(i)){
            continue;
        }
        standIpv6Addr += ipv6DhcpAddr.charAt(i);
        if(!(++j%2)){
            standIpv6Addr += ":";
        }
    }
    return standIpv6Addr.substring(0,23);
}
function Dhcpv6ServerAddrChk(MinAddr, MaxAddr)
{
    var begainAddr = MinAddr;
    var endAddr = MaxAddr;
    var theIpReg = /(([0-9a-fA-F]{4}(:)){3})([0-9a-fA-F]{4})/g;
     
    if((null == begainAddr.match(theIpReg))) 
	{
        AlertEx(lan_address_language['bbsp_startipv6formatinvalid']);
        return false;
    }
    if(true != IPv6AddrChk(Dhcpv6ServerAddrChkConvert(begainAddr)))
	{
		AlertEx(lan_address_language['bbsp_startipv6invalid']);
        return false;
    }
    if((null == endAddr.match(theIpReg))) 
	{
        AlertEx(lan_address_language['bbsp_endipv6formatinvalid']);
        return false;
    }
    if(true != IPv6AddrChk(Dhcpv6ServerAddrChkConvert(endAddr)))
	{
		AlertEx(lan_address_language['bbsp_endipv6invalid']);
        return false;
    }
    if(true == isStartIpbigerEndIp(begainAddr,endAddr))
	{
        AlertEx(lan_address_language['bbsp_startbigthanend']);
        return false;
    }
    return true;
}
function disRadio()
{
	if(getElement("leasetime")[0].checked == true)
	{
		setDisable("specificvalue", 1);
	}
	else if(getElement("leasetime")[1].checked == true)
	{
		setDisable("specificvalue", 0);
	}
	return true;
}

function radioClick()
{
	disRadio();
	return true;
}

function OnChangeRAUI()
{
	if('0' == getCheckVal("EnablePrefixAssignment"))
	{
	    AlertEx(lan_address_language['bbsp_disRAnote']);
	}
}

function OnChangeDHCPV6UI()
{
	if('0' == getCheckVal("EnableDHCPv6Server"))
	{
	    AlertEx(lan_address_language['bbsp_disDHCP6note']);
	}
}

function showOtherForm(isShow)
{
  setDisplay("InterfaceAddrInfoForm", isShow);
  setDisplay("DnsInfoForm", isShow);
  setDisplay("ResourceAllocationForm", isShow);
  setDisplay("UlaInfoForm", isShow);
  setDisplay("ConfigPanelButtons", isShow);
}

function ChooseIpv6TypeOption()
{
  var RadioValue = getRadioVal('idIpv6ConnectionType');
  var requestUrl = "";
  var Onttoken = getValue('onttoken');

  if(CurIPv6ConnectSelect == RadioValue){
    return;
  }

  var enable = 0;
  var Form = new webSubmitForm();
  if (RadioValue == 'ipv6Bridge') {
    enable = 1;
  } else {
    enable = 0;
  }

  Form.addParameter('x.Enable', enable);
  Form.addParameter('x.X_HW_Token', getValue('onttoken'));
  Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.IPv6BridgeTransfer' + '&RequestFile=html/bbsp/lanaddress/lanaddress.asp');

  Form.submit();
  showOtherForm(enable == 0);
  CurIPv6ConnectSelect = RadioValue;
}

function SubmitIpv6Enable() {
    var enable = getCheckVal('ipv6Enable');
    var Form = new webSubmitForm();
    if (enable === 1) {
        Form.addParameter('w.Mode', '3');
    } else {
        Form.addParameter('w.Mode', '1');
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('set.cgi?w=InternetGatewayDevice.DeviceInfo.X_HW_IPProtocolVersion' + '&RequestFile=html/bbsp/lanaddress/lanaddress.asp');
    Form.submit();
}

</script>
<title>LAN Address Configuration</title>
</head>
<body  class="mainbody" onload="OnPageLoad();"> 
<script language="JavaScript" type="text/javascript">
if (IsPTVDFFlag == '1') {
	HWCreatePageHeadInfo("lanaddress", GetDescFormArrayById(lan_address_language, "bbsp_mune"), GetDescFormArrayById(lan_address_language, "bbsp_lan_address_title_vdf"), false);
} else {
	HWCreatePageHeadInfo("lanaddress", GetDescFormArrayById(lan_address_language, "bbsp_mune"), GetDescFormArrayById(lan_address_language, "bbsp_lan_address_title"), false);
}
</script>
<div class="title_spread"></div>
<form id="ipv6EnableSwitch" name="ipv6EnableSwitch" style="display: none;">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <tr border="1" id="ipv6EnableTr">
            <td class="table_title width_per25">
                <script>
                    document.write(lan_address_language["bbsp_ipv6_enable"]);
                </script>
            </td>
            <td id="ipv6EnableCol" class="table_right width_per75">
                <input type="checkbox" id="ipv6Enable" name="ipv6Enable" value="ON" onClick="SubmitIpv6Enable();">
            </td>
        </tr>
    </table>
    <div class="func_spread"></div>
</form>

<form id="IPv6ConnectionType" name="IPv6ConnectionType" style="display:none">
  <div id="IPv6ConnectionTypePanel" class="func_title" BindText="bbsp_ipv6_connection_type"></div>
  <td>
    <input name="idIpv6ConnectionType" id="idIpv6ConnectionType" type="radio" value="ipv6Bridge" onclick="ChooseIpv6TypeOption();"/>
    <span><script>document.write(lan_address_language["bbsp_ipv6_bridge"]);</script></span>
    <input name="idIpv6ConnectionType" id="idIpv6ConnectionType" type="radio" value="ipv6Router" onclick="ChooseIpv6TypeOption();"/>
    <span><script>document.write(lan_address_language["bbsp_ipv6_route"]);</script></span>
  </td>
  <div class="func_spread"></div>
  <script>
    var TableClassRadio = new stTableClass("table_title align_left width_per25", "table_right align_left width_per75");
    var IPv6ConnectionTypeFormList = new Array();
    IPv6ConnectionTypeList = HWGetLiIdListByForm("IPv6ConnectionType",null);
    HWParsePageControlByID("IPv6ConnectionType", TableClassRadio, lan_address_language,null);
  </script>
</form>

<form id="InterfaceAddrInfoForm" name="InterfaceAddrInfoForm">
<div id="IPv6AddresInfoPanel" class="func_title" BindText="bbsp_ipv6addressinfo"></div>
<table id="InterfaceAddrInfoFormPanel" border="0" cellpadding="0" cellspacing="1"  width="100%"> 
<li id="IPv6Address" RealType="TextBox" DescRef="bbsp_ipv6mh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.IPv6Address" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
<li id="IPv6localAddress" RealType="TextBox" DescRef="bbsp_ipv6localmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.IPv6Address" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
<li id="IPv6globalAddress" RealType="TextBox" DescRef="bbsp_ipv6globalmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.IPv6Address" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
<li id="PreFixModeList" RealType="DropDownList" DescRef="bbsp_Ipv6PrefixMode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PreFixModeList" Elementclass="SelectDdns" InitValue="[{TextRef:'bbsp_WANDelegated',Value:'WANDelegated'},{TextRef:'bbsp_Static',Value:'Static'}]" ClickFuncApp="onchange=PreFixModeSelect" />
<li id="Prefix" RealType="TextBox" DescRef="bbsp_ipv6Prefixmh" RemarkRef="" ErrorMsgRef="Empty" Require="TRUE" BindField="y.Prefix" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
<li id="PreferredLifeTime" RealType="TextBox" DescRef="bbsp_ipv6PreferredLifeTimemh" RemarkRef="bbsp_preferredtimenoteE8c" ErrorMsgRef="Empty" Require="TRUE" BindField="PreferredLifeTime" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />
<li id="ValidLifeTime" RealType="TextBox" DescRef="bbsp_ipv6ValidLifeTimemh" RemarkRef="bbsp_vaildtimenoteE8c" ErrorMsgRef="Empty" Require="TRUE" BindField="ValidLifeTime" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />
<li id="WanNameList" RealType="DropDownList" DescRef="" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="WanNameList" Elementclass="SelectLtr" InitValue="Empty" />
<li id="SubPrefixMask" RealType="TextBox" DescRef="bbsp_childpremh" RemarkRef="bbsp_lanaddressnote" ErrorMsgRef="Empty" Require="TRUE" BindField="SubPrefixMask" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
<li id="RAMXUCol" RealType="TextBox" DescRef="bbsp_mtu" RemarkRef="bbsp_mturemark" ErrorMsgRef="Empty" Require="TRUE" BindField="RAMXUCol" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />

<script language="JavaScript" type="text/javascript">
if (ebgWebFlag == '1') {
    document.write("\<li id=\"IAPDLength\" RealType=\"TextBox\" DescRef=\"bbsp_iapd\" RemarkRef=\"bbsp_iapdremark\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"IAPDLength\" Elementclass=\"InputDdns\" MaxLength=\"2\" InitValue=\"Empty\" \/\>");
}
</script>

</table>
<script>
	var TableClass = new stTableClass("table_title align_left width_per25", "table_right align_left width_per75");
	var InterfaceAddrInfoFormList = new Array();
	InterfaceAddrInfoFormList = HWGetLiIdListByForm("InterfaceAddrInfoForm",null);
	HWParsePageControlByID("InterfaceAddrInfoForm",TableClass,lan_address_language,null);
</script>	
<script>getElById("SubPrefixMask").title = Languages['AddressStuffTitle'];</script>
<script> setNoEncodeInnerHtmlValue("PrefixRemark", Languages['PrefixRemark']);</script>
<script> 
	if ('TDE2' == CfgMode.toUpperCase())
	{
		document.getElementById("WanNameListColleft").innerHTML=lan_address_language["bbsp_parentPremh"];
	}
	else
	{
		document.getElementById("WanNameListColleft").innerHTML=lan_address_language["bbsp_parentPremhOther"];
	}
</script>
<div class="func_spread"></div>
</form>
	
<form id="DnsInfoForm" name="DnsInfoForm" style="display:none">
<div id="DnsInfoTitle" class="func_title" BindText="bbsp_ipv6dnsserverinfo"></div>
<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li id="Ipv6landnsList" RealType="DropDownList" DescRef="bbsp_Ipv6landnsMode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Ipv6landnsList" Elementclass="SelectDdns" InitValue="Empty" ClickFuncApp="onchange=Ipv6landnsSelect"/>
<li id="Ipv6wanname" RealType="DropDownList" DescRef="bbsp_Ipv6wanname" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" Elementclass="SelectLtr" InitValue="Empty" />
<li id="Ipv6PrimaryDNS" RealType="TextBox" DescRef="bbsp_Ipv6PrimaryDNS" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Ipv6PrimaryDNS" Elementclass="InputLtr" MaxLength="255" InitValue="Empty" />
<li id="Ipv6secondDNS" RealType="TextBox" DescRef="bbsp_Ipv6secondDNS" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Ipv6secondDNS" Elementclass="InputLtr" MaxLength="255"  InitValue="Empty" />
</table>
<script>
	var dir_style = ("ARABIC" == LoginRequestLanguage.toUpperCase()) ? "rtl" : "ltr";
	var TableClassTwo = new stTableClass("table_title align_left width_per25", "table_right align_left width_per75",dir_style);
	var DnsInfoFormList = new Array();
	DnsInfoFormList = HWGetLiIdListByForm("DnsInfoForm",null);
	HWParsePageControlByID("DnsInfoForm",TableClassTwo,lan_address_language,null);
	InitIpv6landnsList();
</script>
</form>

<form id="ResourceAllocationForm" name="ResourceAllocationForm">
<div class="func_spread"></div>
<div id="ResourceAllocTitle" class="func_title" BindText="bbsp_resourceallocinfo"></div>
<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li id="EnablePrefixAssignment" RealType="CheckBox" DescRef="bbsp_enableRAmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="EnablePrefixAssignment" InitValue="Empty" ClickFuncApp="onclick=OnChangeRAUI"/>
<li id="EnableDHCPv6Server" RealType="CheckBox" DescRef="bbsp_enableDHCP6Smh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="EnableDHCPv6Server" InitValue="Empty" ClickFuncApp="onclick=OnChangeDHCPV6UI"/>
<li id="ResourceAllocModeList" RealType="DropDownList" DescRef="bbsp_resourceallocmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="m.mode" Elementclass="SelectDdns" InitValue="[{TextRef:'bbsp_manualconfigure',Value:'Manual'},{TextRef:'bbsp_autoconfigure',Value:'Auto'},{TextRef:'bbsp_strictmanualconfigure',Value:'StrictManual'}]" ClickFuncApp="onchange=ResouceAllocSelect" />
<li id="AssignType" RealType="RadioButtonList" DescRef="bbsp_prefixcfgmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="AssignType"     InitValue="[{TextRef:'bbsp_dhcp',Value:'1'},{TextRef:'bbsp_slaac',Value:'0'}]" ClickFuncApp="onclick=ChangePrefixCfgMode" />
<li id="StartIPAddress"    RealType="TextBox"     DescRef="bbsp_startaddrmh"      RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"    Elementclass="InputLtr"  BindField="Empty"      InitValue="Empty"/>
<li id="EndIPAddress"    RealType="TextBox"     DescRef="bbsp_endaddrmh"        RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"    Elementclass="InputLtr"  BindField="Empty"      InitValue="Empty"/>
<li id="OtherType" RealType="RadioButtonList" DescRef="bbsp_othercfgmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="m.OtherConfigFlag"     InitValue="[{TextRef:'bbsp_dhcp',Value:'1'},{TextRef:'bbsp_slaac',Value:'0'}]"/>
</table>
<script>
	var ResourceAllocationFormList = new Array();
	ResourceAllocationFormList = HWGetLiIdListByForm("ResourceAllocationForm",null);
	HWParsePageControlByID("ResourceAllocationForm",TableClassTwo,lan_address_language,null);
</script>
<div id="DHCPv6LeaseTimecon" class="tabal_noborder_bg" >
<table>
<tr>
<td class="table_title align_left " style="width:159px">
<script language="javascript">
		document.write( lan_address_language['bbsp_leasetimemh']);
		</script>
</td>
<td class="table_right align_left ">
<input type='radio' name='leasetime' id='leasetime' onclick='radioClick();' value="-1">
<script language="javascript">
		document.write( lan_address_language['bbsp_infinite']);
		</script> 
<input type='radio' name='leasetime' id='leasetime' onclick='radioClick();' value="0" checked="true">
<input type='text'  name='leasetime' id='specificvalue'>
<span class="gray" ><script>document.write(lan_address_language['bbsp_leasetimerange']);</script></span>
</td>
</tr>
</table> 	
</div>
</form>

<form id="UlaInfoForm" name="UlaInfoForm" style="display:none;">
<div id="UlaInfoSpace" class="func_spread"></div>
<div id="UlaTipsTitleDEFHIDE" class="func_title" BindText="bbsp_ulainfo">
</div>
<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li id="ULAmodeDEFHIDE" RealType="DropDownList" DescRef="bbsp_ulamode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ULAmodeDEFHIDE" Elementclass="SelectDdns" InitValue="Empty" ClickFuncApp="onchange=ulaSelect"/>
<li id="UlaPrefixDEFHIDE" RealType="TextBox" DescRef="bbsp_prefix" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="UlaPrefixDEFHIDE" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />
<li id="ULAPrefixLenDEFHIDE" RealType="TextBox" DescRef="bbsp_prefixlength" RemarkRef="bbsp_prefixlengthnote" ErrorMsgRef="Empty" Require="TRUE" BindField="ULAPrefixLenDEFHIDE" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />
<li id="UlaPreferredLifetimeDEFHIDE" RealType="TextBox" DescRef="bbsp_preferredtime" RemarkRef="bbsp_preferredtimenote" ErrorMsgRef="Empty" Require="TRUE" BindField="UlaPreferredLifetimeDEFHIDE" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />
<li id="UlaValidLifetimeDEFHIDE" RealType="TextBox" DescRef="bbsp_vaildtime" RemarkRef="bbsp_vaildtimenote" ErrorMsgRef="Empty" Require="TRUE" BindField="UlaValidLifetimeDEFHIDE" Elementclass="InputDdns" MaxLength="255" InitValue="Empty" />
<li id="SpanLANDEFHIDE"           RealType="CheckBoxList"       DescRef="bbsp_assginportmh"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="d.SpanLAN" InitValue="[{TextRef:'bbsp_LAN1',Value:'bbsp_LAN1'},{TextRef:'bbsp_LAN2',Value:'bbsp_LAN2'},{TextRef:'bbsp_LAN3',Value:'bbsp_LAN3'},{TextRef:'bbsp_LAN4',Value:'bbsp_LAN4'},{TextRef:'bbsp_SSID1',Value:'bbsp_SSID1'},{TextRef:'bbsp_SSID2',Value:'bbsp_SSID2'},{TextRef:'bbsp_SSID3',Value:'bbsp_SSID3'},{TextRef:'bbsp_SSID4',Value:'bbsp_SSID4'}]"/>  
</table>
<script>
	var UlaInfoFormList = new Array();
	UlaInfoFormList = HWGetLiIdListByForm("UlaInfoForm",null);
	HWParsePageControlByID("UlaInfoForm",TableClassTwo,lan_address_language,null);
	InitULAmodeDEFHIDE();
</script>
</form>
	
  <table id="ConfigPanelButtons" width="100%"  cellspacing="1" class="table_button"> 
    <tr>
      <td class='width_per25'> </td> 
      <td class="table_submit pad_left5p"> <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  <input class="ApplyButtoncss buttonwidth_100px" name="ButtonApply" id= "ButtonApply" type="button" BindText="bbsp_app" onClick="javascript:return OnApplyButtonClick();"> 
	  <input class="CancleButtonCss buttonwidth_100px" name="ButtonCancel" id="ButtonCancel" type="button" BindText="bbsp_cancel" onClick="javascript:OnCancelButtonClick();"></td> 
    </tr> 
  </table> 
  <div style="height:10px;"></div>

<script>
ParseBindTextByTagName(lan_address_language, "td",    1);
ParseBindTextByTagName(lan_address_language, "div",   1);

InitWanNameListControl("WanNameList", IsValidWan);    
InitWanNameListControl1("Ipv6wanname", IsValidWan);

ControlLanList("SpanLAN", "SpanSSID");
ParseBindTextByTagName(lan_address_language, "input", 2);
setDisplay('StartIPAddressRow', 0);
setDisplay('EndIPAddressRow', 0); 
setDisplay('DHCPv6LeaseTimecon', 0)
document.getElementById("StartIPAddress").title = lan_address_language['bbsp_interfaceremark'];
document.getElementById("EndIPAddress").title = lan_address_language['bbsp_interfaceremark'];
if ("ARABIC" == LoginRequestLanguage.toUpperCase())
{
	document.getElementById('RAMXUCol').title = lan_address_language['bbsp_mturemark2'];;
}
setDisable('ULAmodeDEFHIDE', isDisableURAMode(GetWanListByFilter(IsValidWan)));
</script> 
</body>
</html>
