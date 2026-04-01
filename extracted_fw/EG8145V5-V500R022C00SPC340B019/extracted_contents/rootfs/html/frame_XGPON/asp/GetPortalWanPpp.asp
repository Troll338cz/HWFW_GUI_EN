function(){
	function WANPPP(domain, ConnectionStatus, X_HW_VLAN, X_HW_SERVICELIST, ConnectionType, Username)
	{
		this.domain	= domain;
		this.ConnectionStatus	= ConnectionStatus;	
		this.ConnectionType	= ConnectionType;
		this.X_HW_VLAN	= X_HW_VLAN;
		this.X_HW_SERVICELIST = X_HW_SERVICELIST;
		this.Username = Username;
	}
	
	var ResultInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},ConnectionStatus|X_HW_VLAN|X_HW_SERVICELIST|ConnectionType|Username,WANPPP);%>;
	return ResultInfo;
}
