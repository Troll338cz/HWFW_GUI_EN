(function(){
    function PingResultClass(domain, FailureCount, SuccessCount, DiagnosticsState) {
        this.domain = domain;
        this.FailureCount = FailureCount;
        this.SuccessCount = SuccessCount;
        this.DiagnosticsState = DiagnosticsState;
    }
    var ResultInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.IPPingDiagnostics,FailureCount|SuccessCount|DiagnosticsState, PingResultClass);%>;
    return ResultInfo[0];
})();
