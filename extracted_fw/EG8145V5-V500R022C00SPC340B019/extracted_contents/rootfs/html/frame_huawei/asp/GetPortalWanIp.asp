function(){
	function WANIP(domain, ConnectionStatus, X_HW_VLAN, X_HW_SERVICELIST, ConnectionType, AddressingType, ExternalIPAddress, SubnetMask, DefaultGateway, DNSServers)
	{
		this.domain 	= domain;
		this.ConnectionStatus 	= ConnectionStatus;			
		this.ConnectionType	= ConnectionType;
		this.X_HW_VLAN	= X_HW_VLAN;
		this.X_HW_SERVICELIST = X_HW_SERVICELIST;
		this.AddressingType = AddressingType;
		this.ExternalIPAddress = ExternalIPAddress;
		this.SubnetMask = SubnetMask;
		this.DefaultGateway = DefaultGateway;
		this.DNSAServers = "";
		this.DNSSServers = "";
		if (DNSServers != "")
		{
			DNSList = DNSServers.split(",");
			this.DNSAServers = DNSList[0];
			if (DNSList.length == 2)
			{
				this.DNSSServers = DNSList[1];
			}
		}
	}
	
	var ResultInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i},ConnectionStatus|X_HW_VLAN|X_HW_SERVICELIST|ConnectionType|AddressingType|ExternalIPAddress|SubnetMask|DefaultGateway|DNSServers,WANIP);%>;
	return ResultInfo;
}
