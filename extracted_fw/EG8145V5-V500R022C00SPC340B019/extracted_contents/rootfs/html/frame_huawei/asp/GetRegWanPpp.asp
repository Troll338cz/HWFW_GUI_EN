function(){
	function WANPPP(domain,ConnectionStatus,ExternalIPAddress, X_HW_SERVICELIST,ConnectionType,X_HW_TR069FLAG)
	{
	  this.domain	= domain;
	  this.ConnectionStatus	= ConnectionStatus;	
		
	  if (ConnectionType == 'PPPoE_Bridged')
	  {  
	  	this.ExternalIPAddress	= '';	  
	  }
	  else
	  {
	    this.ExternalIPAddress= ExternalIPAddress;
	  }	 
	  this.X_HW_SERVICELIST = X_HW_SERVICELIST;
	  this.X_HW_TR069FLAG = X_HW_TR069FLAG;
	  this.ConnectionType = ConnectionType;
	}
	
	var ResultInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},ConnectionStatus|ExternalIPAddress|X_HW_SERVICELIST|ConnectionType|X_HW_TR069FLAG,WANPPP);%>;
	return ResultInfo;
}
