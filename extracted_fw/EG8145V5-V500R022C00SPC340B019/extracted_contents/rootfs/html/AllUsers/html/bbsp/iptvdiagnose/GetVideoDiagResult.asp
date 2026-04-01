function() {
  function ConvertTextToDiagList(ResultText)
  {
    var tmpDataList = new DataInfoSt('','');
    var DiagResultList = new Array();
    var DiagTimeList = new Array();
    var curRecList;
    var curRecInst;
  
    if(ResultText.toUpperCase() != 'NONE')
    {
      var TempDiagResultTextList =  ResultText.split('\n');
      var TempDiagResultListLen = TempDiagResultTextList.length;
  
      for(var i = 0; TempDiagResultListLen > 0 && i < TempDiagResultListLen -1; i++)
      {
        curRecList = '';
        curRecInst = '';
        curRecList = TempDiagResultTextList[i].split(',');
        curRecInst = MakeRecordInst(curRecList);
        DiagResultList.push(curRecInst);
        DiagTimeList.push(curRecInst.Time);
      }
      tmpDataList.DiagResultList = DiagResultList;
      tmpDataList.DiagTimeList = DiagTimeList;
    }
    return tmpDataList;
  }
  
  
  var DataList = new DataInfoSt('','');
  var IPtvDiagResultText = <%HW_WEB_GetIPtvDiagResult();%>; 
  if (IPtvDiagResultText != 'NONE')
  {
    DataList.DiagResultList = IPtvDiagResultText;
  }
  else
  {
    DataList.DiagResultList = new Array();
  }
  
  var len= DataList.DiagResultList.length;
  var DiagTimeList = new Array();
  for (var i=0;i<len;i++)
  {
    DiagTimeList.push(DataList.DiagResultList[i].Time);
  }
  DataList.DiagTimeList = DiagTimeList;
  
  function getDataList()
  {
    return DataList;
  }
  
  return getDataList();
}

