function() {
  function aiopsUploadStatus(status, uploadTime)
  {
      this.status = status;
      this.uploadTime = uploadTime;
  }
  
  var uploadState = <%WEB_GetAiopsUploadStatus();%>;
  
  function getInfoList()
  {
      return uploadState;
  }
  return getInfoList();
}
