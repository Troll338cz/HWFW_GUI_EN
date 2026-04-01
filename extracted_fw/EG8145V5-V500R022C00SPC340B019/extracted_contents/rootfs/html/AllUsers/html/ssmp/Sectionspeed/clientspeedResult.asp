function() {
  var GetIperfClientResultFile = <%HW_WEB_GetIperfClientResultFile();%>;  

  function getSpeedResultInfo()
  {
      return GetIperfClientResultFile;
  }
  return getSpeedResultInfo();
}


