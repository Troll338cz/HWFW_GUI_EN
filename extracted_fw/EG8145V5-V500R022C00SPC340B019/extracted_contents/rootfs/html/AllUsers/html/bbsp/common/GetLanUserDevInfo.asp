function USERDevice(Domain,IpAddr,MacAddr,Port,IpType,DevType,DevStatus,PortType,Time,HostName,IPv4Enabled,IPv6Enabled,DeviceType,UserDevAlias,UserSpecifiedDeviceType,LeaseTimeRemaining)
{
	this.Domain 	= Domain;
	this.IpAddr	    = (IpAddr.length == 0)?"--":IpAddr;
	this.MacAddr	= MacAddr;

	if(Port=="LAN0" || Port=="SSID0")
	{
		this.Port  = "--"; 
	}
	else
	{
		this.Port  = Port;
	}
	
	this.PortID = Port; 
	
	this.PortType	= PortType;
	
	this.DevStatus 	= DevStatus;
	this.IpType		= IpType;
	if(IpType=="Static")
	{
	  this.DevType="--";
	}
	else
	{
		if(DevType=="")
		{
			this.DevType	= "--";	
		}
		else
		{
			this.DevType	= DevType;		
		}	
	}
	this.Time	    = Time;
	
	if(HostName=="")
	{
		this.HostName	= "--";
	}
	else
	{
	   this.HostName	= HostName;
	}
	
	this.IPv4Enabled = IPv4Enabled;
	this.IPv6Enabled = IPv6Enabled;
	this.DeviceType = DeviceType;
	if (UserDevAlias == "")
	{
		this.UserDevAlias = "--";
	}
	else
	{
		this.UserDevAlias = UserDevAlias;
	}
	this.UserSpecifiedDeviceType = UserSpecifiedDeviceType;
	this.LeaseTimeRemaining = LeaseTimeRemaining;
	this.instid       = '';
	this.IsClickDev   = false;
}

function USERDeviceNew(Domain, IpAddr, MacAddr, Port, IpType, DevType, DevStatus, PortType, Time, HostName, IPv4Enabled, IPv6Enabled, DeviceType, UserDevAlias, UserSpecifiedDeviceType, LeaseTimeRemaining, RealMacAddr) {
	this.Domain = Domain;
	this.IpAddr = (IpAddr.length == 0)?"--":IpAddr;
	this.MacAddr = MacAddr;

	if ((Port=="LAN0") || (Port=="SSID0")) {
		this.Port = "--"; 
	} else {
		this.Port = Port;
	}
	this.PortID = Port; 
	this.PortType = PortType;
	this.DevStatus = DevStatus;
	this.IpType = IpType;
	if (IpType == "Static") {
	 this.DevType="--";
	} else {
		if (DevType == "") {
			this.DevType = "--";	
		} else {
			this.DevType = DevType;		
		}
	}
	this.Time = Time;
	
	if (HostName == "") {
		this.HostName = "--";
	} else {
	   this.HostName = HostName;
	}
	
	this.IPv4Enabled = IPv4Enabled;
	this.IPv6Enabled = IPv6Enabled;
	this.DeviceType = DeviceType;
	if (UserDevAlias == "") {
		this.UserDevAlias = "--";
	} else {
		this.UserDevAlias = UserDevAlias;
	}
	this.UserSpecifiedDeviceType = UserSpecifiedDeviceType;
	this.LeaseTimeRemaining = LeaseTimeRemaining;
	this.RealMacAddr = RealMacAddr;
	this.instid = '';
	this.IsClickDev = false;
}

var ProductType = '<%HW_WEB_GetProductType();%>';
var isRealmac = '<%HW_WEB_GetFeatureSupport(BBSP_FT_STA_REALMAC);%>';
if (ProductType != '2') {
    if (isRealmac == 1) {
        var UserDevinfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecialGetUserDevInfo,InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i},IpAddr|MacAddr|PortID|IpType|DevType|DevStatus|PortType|time|HostName|IPv4Enabled|IPv6Enabled|DeviceType|UserDevAlias|UserSpecifiedDeviceType|LeaseTimeRemaining|RealMacAddr ,USERDeviceNew);%>;
    } else {
        var UserDevinfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecialGetUserDevInfo,InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i},IpAddr|MacAddr|PortID|IpType|DevType|DevStatus|PortType|time|HostName|IPv4Enabled|IPv6Enabled|DeviceType|UserDevAlias|UserSpecifiedDeviceType|LeaseTimeRemaining ,USERDevice);%>;
    }
} else {
    var UserDevinfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i},IpAddr|MacAddr|PortID|IpType|DevType|DevStatus|PortType|time|HostName|IPv4Enabled|IPv6Enabled|DeviceType|UserDevAlias|UserSpecifiedDeviceType|LeaseTimeRemaining ,USERDevice);%>;
}

function stWifiWorkingMode(domain,WifiMode,IPAddress,MacAddress)
{
	this.domain 		= domain;
	this.WifiMode 		= WifiMode;
	this.IPAddress		= IPAddress;
	this.MacAddress     = MacAddress;
}

var WifiWorkingModes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.AssociatedDevice.{i},X_HW_WorkingMode|AssociatedDeviceIPAddress|AssociatedDeviceMACAddress,stWifiWorkingMode);%>;
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 

if (curCfgModeWord == "TALKTALK2WIFI")
{
	for(var i = 0; i < UserDevinfo.length - 1; i++)
	{	var MACmacthFlag = 0; 
		if (UserDevinfo[i].DevStatus.toUpperCase() == "OFFLINE")
		{
			UserDevinfo[i].Port = "--";
			continue;
		}
		
		if(UserDevinfo[i].PortType != "WIFI")
		{		
			UserDevinfo[i].Port = "Ethernet";
			continue;
		}
		
		
		for(var j = 0;j < WifiWorkingModes.length - 1 ; j++)
		{ 
			if (UserDevinfo[i].MacAddr.toString().toUpperCase() ==  WifiWorkingModes[j].MacAddress.toString().toUpperCase())
			{	
				UserDevinfo[i].Port = WifiWorkingModes[j].WifiMode;	
				MACmacthFlag = 1;
				break;
			}	
		}
		
		if(MACmacthFlag != 1)
		{
			for(var k = 0;k < WifiWorkingModes.length - 1 ; k++)
			{
				if	(UserDevinfo[i].IpAddr.toString() == WifiWorkingModes[k].IPAddress.toString())
				{
					UserDevinfo[i].Port = WifiWorkingModes[k].WifiMode;	
					MACmacthFlag = 1;
					break;
				}
			}
		}
		if(MACmacthFlag != 1)
		{
			UserDevinfo[i].Port = "--";
		}
	}	
}



var UserDevinfoTmp = new Array();
for(var i = 0; i < UserDevinfo.length - 1; i++)
{
	var id = UserDevinfo[i].Domain.split(".");
	UserDevinfo[i].instid = id[id.length -1];

	if (UserDevinfo[i].IPv4Enabled == "1") {
		if (curCfgModeWord == "TTNET2") {
			if (UserDevinfo[i].DevStatus.toUpperCase() == "ONLINE") {
				UserDevinfoTmp.push(UserDevinfo[i]);
			}
		} else {
			UserDevinfoTmp.push(UserDevinfo[i]);
		}
	}
}
UserDevinfoTmp.push(null);

function GetUserDevInfoList()
{
	return UserDevinfoTmp;
}

GetUserDevInfoList();