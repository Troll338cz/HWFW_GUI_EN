function() {
    function bondingTunnelInfo(domain, Status, IPv4Address, IPv6Address) {
        this.domain = domain;   
        this.Status = Status;
        this.IPv4Address = IPv4Address;
        this.IPv6Address = IPv6Address;
    }

    var resultInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Bonding.Interfaces.{i}, Status|IPv4Address|IPv6Address, bondingTunnelInfo);%>;
    return resultInfo;
}
