function(){
	function stResultInfo(domain, LOID, State)
	{
		this.LOID = LOID;
		this.State = State;
	}  
		
	var ResultStatusInfo =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_RegistInfo, LOID|State, stResultInfo);%>;
	
	return ResultStatusInfo[0];
}
