function() {
  var GetIperfServerResultFile = <%HW_WEB_GetIperfServerResultFile();%>;  

  function getSpeedResultInfo()
  {
      return GetIperfServerResultFile;
  }
  return getSpeedResultInfo();
}

