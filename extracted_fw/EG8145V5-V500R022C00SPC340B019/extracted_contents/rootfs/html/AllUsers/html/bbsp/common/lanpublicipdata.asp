
function stLanPublicIPClass(domain, Enable, IPAddress, SubnetMask)
{
    this.domain = domain;
	this.Enable =  Enable;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;	
}

var LanPublicIPItms = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.X_HW_PublicIPInterface.{i},Enable|IPAddress|SubnetMask,stLanPublicIPClass);%>;


function GetLanPublicIP()
{
    return LanPublicIPItms;
}