function() {
  var GetClientFile = <%HW_WEB_GetClientFile();%>;
  var GetServerFile = <%HW_WEB_GetServerFile();%>;
  var result = GetClientFile + ";" + GetServerFile;
  function getSpeedResultInfo()
  {
      return result;
  }
  return getSpeedResultInfo();
}

