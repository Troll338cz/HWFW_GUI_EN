function() {
  function strspeedresult1(Domain,Interface,Diagspeed,UrlDiagnosticsState,ROMTime,BOMTime,EOMTime,TestBytesReceived,TotalBytesReceived,TCPOpenRequestTime,TCPOpenResponseTime,TotalBytesSent,TestBytesReceivedUnderFullLoading,TotalBytesReceivedUnderFullLoading,TotalBytesSentUnderFullLoading,PeriodOfFullLoading,PerConnectionResultNumberOfEntries,IncrementalResultNumberOfEntries,DiagnosticsMaxIncrementalResult,IPAddressUsed,DiagnosticMaxConnections,Transports,SampledValues,NumberOfConnections,TimeBasedTestDuration)
  {
      this.Domain     = Domain;
      this.Interface = Interface;
      this.Diagspeed  = Diagspeed;
      this.UrlDiagnosticsState     = UrlDiagnosticsState;
      this.ROMTime    = ROMTime;
      this.BOMTime = BOMTime;
      this.EOMTime = EOMTime;
      this.TestBytesReceived = TestBytesReceived;
      this.TotalBytesReceived = TotalBytesReceived;
      this.TCPOpenRequestTime = TCPOpenRequestTime;
      this.TCPOpenResponseTime = TCPOpenResponseTime;
      this.TotalBytesSent = TotalBytesSent;
      this.TestBytesReceivedUnderFullLoading = TestBytesReceivedUnderFullLoading;
      this.TotalBytesReceivedUnderFullLoading = TotalBytesReceivedUnderFullLoading;
      this.TotalBytesSentUnderFullLoading = TotalBytesSentUnderFullLoading;
      this.PeriodOfFullLoading = PeriodOfFullLoading;
      this.PerConnectionResultNumberOfEntries = PerConnectionResultNumberOfEntries;
      this.IncrementalResultNumberOfEntries = IncrementalResultNumberOfEntries;
      this.DiagnosticsMaxIncrementalResult = DiagnosticsMaxIncrementalResult; 
      this.IPAddressUsed = IPAddressUsed;
      this.DiagnosticMaxConnections = DiagnosticMaxConnections;
      this.Transports = Transports;
      this.SampledValues = SampledValues;
      this.NumberOfConnections = NumberOfConnections;
      this.TimeBasedTestDuration = TimeBasedTestDuration;
  }
  function strspeedresult2(Domain,Interface,Diagspeed,UrlDiagnosticsState,ROMTime,BOMTime,EOMTime,TotalBytesReceived,TCPOpenRequestTime,TCPOpenResponseTime,TotalBytesSent,TestBytesReceivedUnderFullLoading,TotalBytesReceivedUnderFullLoading,TotalBytesSentUnderFullLoading,PeriodOfFullLoading,PerConnectionResultNumberOfEntries,IncrementalResultNumberOfEntries,DiagnosticsMaxIncrementalResult,IPAddressUsed,DiagnosticMaxConnections,Transports,SampledValues,NumberOfConnections,TimeBasedTestDuration)
  {
      this.Domain     = Domain;
      this.Interface = Interface;
      this.Diagspeed  = Diagspeed;
      this.UrlDiagnosticsState     = UrlDiagnosticsState;
      this.ROMTime    = ROMTime;
      this.BOMTime = BOMTime;
      this.EOMTime = EOMTime;
      this.TotalBytesReceived = TotalBytesReceived;
      this.TCPOpenRequestTime = TCPOpenRequestTime;
      this.TCPOpenResponseTime = TCPOpenResponseTime;
      this.TotalBytesSent = TotalBytesSent;
      this.TestBytesReceivedUnderFullLoading = TestBytesReceivedUnderFullLoading;
      this.TotalBytesReceivedUnderFullLoading = TotalBytesReceivedUnderFullLoading;
      this.TotalBytesSentUnderFullLoading = TotalBytesSentUnderFullLoading;
      this.PeriodOfFullLoading = PeriodOfFullLoading;
      this.PerConnectionResultNumberOfEntries = PerConnectionResultNumberOfEntries;
      this.IncrementalResultNumberOfEntries = IncrementalResultNumberOfEntries;
      this.DiagnosticsMaxIncrementalResult = DiagnosticsMaxIncrementalResult; 
      this.IPAddressUsed = IPAddressUsed;
      this.DiagnosticMaxConnections = DiagnosticMaxConnections;
      this.Transports = Transports;
      this.SampledValues = SampledValues;
      this.NumberOfConnections = NumberOfConnections;
      this.TimeBasedTestDuration = TimeBasedTestDuration;
  }
  var speedResult1,speedResult2;
  var speedarry = new Array();
  
  speedResult1= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DownloadDiagnostics,Interface|DiagnosticsState|DownloadURL|ROMTime|BOMTime|EOMTime|TestBytesReceived|TotalBytesReceived|TCPOpenRequestTime|TCPOpenResponseTime|TotalBytesSent|TestBytesReceivedUnderFullLoading|TotalBytesReceivedUnderFullLoading|TotalBytesSentUnderFullLoading|PeriodOfFullLoading|PerConnectionResultNumberOfEntries|IncrementalResultNumberOfEntries|DownloadDiagnosticsMaxIncrementalResult|IPAddressUsed|DownloadDiagnosticMaxConnections|DownloadTransports|SampledValues|NumberOfConnections|TimeBasedTestDuration,strspeedresult1);%>; 
  
  speedarry.push(speedResult1); 
  
  speedResult2= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UploadDiagnostics,Interface|DiagnosticsState|UploadURL|ROMTime|BOMTime|EOMTime|TotalBytesReceived|TCPOpenRequestTime|TCPOpenResponseTime|TotalBytesSent|TestBytesSentUnderFullLoading|TotalBytesReceivedUnderFullLoading|TotalBytesSentUnderFullLoading|PeriodOfFullLoading|PerConnectionResultNumberOfEntries|IncrementalResultNumberOfEntries|UploadDiagnosticsMaxIncrementalResult|IPAddressUsed|UploadDiagnosticMaxConnections|UploadTransports|SampledValues|NumberOfConnections|TimeBasedTestDuration,strspeedresult2);%>;
  
  speedarry.push(speedResult2);   
  
  
  function getSpeedResultInfo()
  {
      return speedarry;
  }
  
  return getSpeedResultInfo();
}
