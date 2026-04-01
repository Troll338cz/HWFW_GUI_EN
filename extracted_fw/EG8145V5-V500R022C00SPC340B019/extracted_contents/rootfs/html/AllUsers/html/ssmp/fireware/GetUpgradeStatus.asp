function() {
  function houpUpgrade(status, Progress)
  {
      this.status = status;
      this.Progress = Progress;
  }
  
  var upgradeInfo = <%WEB_GetUpgradeStatus();%>;
  
  function getInfoList()
  {
    return upgradeInfo;
  }
  return getInfoList();
}
