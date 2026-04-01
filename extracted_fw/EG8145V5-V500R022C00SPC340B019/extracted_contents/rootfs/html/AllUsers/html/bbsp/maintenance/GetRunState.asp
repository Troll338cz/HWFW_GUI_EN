function() {
  function returnState(){
    var type = $('#DiagnoseType').val();
    if(type=='Ping'){
      return "<%HW_WEB_GetRunState("Ping");%>";
    }else{
      return "<%HW_WEB_GetRunState("Traceroute");%>";
    }
  }
  return returnState();
}
