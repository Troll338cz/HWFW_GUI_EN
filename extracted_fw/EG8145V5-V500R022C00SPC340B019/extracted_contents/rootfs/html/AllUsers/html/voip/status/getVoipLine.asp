function() {
  function stLine(Domain, DirectoryNumber, PhyReferenceList, Status, CallState,RegisterError)
  {
      this.Domain = Domain;
      if(DirectoryNumber != null)
      {
          this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'");
      }
      else
      {
          this.DirectoryNumber = DirectoryNumber;
      }
      
    this.PhyReferenceList = PhyReferenceList;
      this.Status = Status;
      this.CallState = CallState;
      this.RegisterError = RegisterError;
  }
  
  var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|PhyReferenceList|Status|CallState|X_HW_LastRegisterError,stLine);%>;
  
  function GetVoipLines()
  {
    return AllLine;
  }
  
  return GetVoipLines();
}
