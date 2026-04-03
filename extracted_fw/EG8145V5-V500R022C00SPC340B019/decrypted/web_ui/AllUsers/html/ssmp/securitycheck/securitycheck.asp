<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';

var checkIdDesMap = {
  "WEB password": GetDescFormArrayById(SecurityInfoLgeDes, "s30015"),
  "Telnet password": GetDescFormArrayById(SecurityInfoLgeDes, "s30018"),
  "SSH password": GetDescFormArrayById(SecurityInfoLgeDes, "s30027"),
  "FTP service": GetDescFormArrayById(SecurityInfoLgeDes, "s30021"),
  "SFTP service": GetDescFormArrayById(SecurityInfoLgeDes, "s30024"),
  "secure boot": GetDescFormArrayById(SecurityInfoLgeDes, "s30009"),
  "integrity protection": GetDescFormArrayById(SecurityInfoLgeDes, "s30012")
};

var checkResultMap = {
  "ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30008"),
  "NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30007"),
};

var checkResultReasonMap = {
  "WEB password_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30017"),
  "WEB password_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30016"),
  "Telnet password_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30020"),
  "Telnet password_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30019"),
  "SSH password_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30028"),
  "SSH password_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30029"),
  "FTP service_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30023"),
  "FTP service_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30022"),
  "SFTP service_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30026"),
  "SFTP service_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30025"),
  "secure boot_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30010"),
  "secure boot_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30011"),
  "integrity protection_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30013"),
  "integrity protection_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30014"),
  "WAN listening port 7547_NORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30035"),
  "WAN listening port 80_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30036"),
  "WAN listening port 443_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30036"),
  "WAN listening port 23_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30037"),
  "WAN listening port 22_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30038"),
  "WAN listening port 21_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30039"),
  "WAN listening port 8022_ABNORMAL": GetDescFormArrayById(SecurityInfoLgeDes, "s30040")
};

var checkStatusMap = {
  "Checking": GetDescFormArrayById(SecurityInfoLgeDes, "s30031"),
  "Fail": GetDescFormArrayById(SecurityInfoLgeDes, "s30032"),
  "Finish": GetDescFormArrayById(SecurityInfoLgeDes, "s30033"),
};


function getCheckIdDes(id) {
  if(checkIdDesMap[id] != undefined) {
    return checkIdDesMap[id];
  }
  var WAN_LISTEN_DES_START = "WAN listening port";
  if(id.indexOf(WAN_LISTEN_DES_START) != -1) {
    return id.replace(WAN_LISTEN_DES_START, GetDescFormArrayById(SecurityInfoLgeDes, "s30034"));
  }
  var LISTEN_DES_START = "Listening port";
  if(id.indexOf(LISTEN_DES_START) != -1) {
    return id.replace(LISTEN_DES_START, GetDescFormArrayById(SecurityInfoLgeDes, "s30041"));
  }
  return id;
}


function getCheckResult(result) {
  if(checkResultMap[result] != undefined) {
    return checkResultMap[result];
  }
  return result;
}

function getCheckResultReason(arrLine) {
  var id = $.trim(arrLine[0]);
  var result = $.trim(arrLine[1]);
  var key = id + '_' + result;
  if(checkResultReasonMap[key] != undefined) {
    return checkResultReasonMap[key];
  }
  var reason = $.trim(arrLine[2]);
  var EXCEPTION_START = "Exception process";
  if(reason.indexOf(EXCEPTION_START) != -1) {
    return reason.replace(EXCEPTION_START, GetDescFormArrayById(SecurityInfoLgeDes, "s30042"));
  }
  return reason;
}

function LoadFrame()
{
    if(curLanguage == "arabic"){
        document.getElementById("faultInfo").style.textAlign = "right";
    }
    else{
        document.getElementById("faultInfo").style.textAlign = "left";
    }
    getSecCheckStatus();
}

function secCheckListShow(arr)
{
  var tbodyHtml = "";
  for(var i = 0 ;i < arr.length; i++) {      
        if(arr[i] != "") {
          var arrLine = arr[i].split("|");
          tbodyHtml += '<tr id="checkRecord_' + i + '"class="tabal_01">';
          tbodyHtml += '<td ' + bottomBorderClass(true) + '>' + getCheckIdDes($.trim(arrLine[0]))+ '&nbsp;</td>';
          tbodyHtml += '<td ' + bottomBorderClass(true) + '>' + getCheckResult($.trim(arrLine[1])) + '&nbsp;</td>';
          tbodyHtml += '<td ' + bottomBorderClass(true) + '>' + getCheckResultReason(arrLine) + '&nbsp;</td>';
          tbodyHtml += '</tr>';
        }
    }
    $("#secCheckResult").html(tbodyHtml);
}

function getSecCheckInfo()
{
  $.ajax({
    type : "POST",
    async : false,
    cache : false,
    url : "/html/ssmp/securitycheck/getSecCheckResult.asp",
    success : function(data) {
        if(typeof data != undefined && data != "") {
          var checkResult = hexDecode(data);
          var arrCheckResult = checkResult.split("\r\n");
          secCheckListShow(arrCheckResult);
        }
    }
  });
}

function getDesStatusDes(status) {
  if(checkStatusMap[status] != undefined) {
    return checkStatusMap[status];
  }
  return "";
}

var checkTimer = null;
function getSecCheckStatus()
{
  $.ajax({
    type : "POST",
    async : false,
    cache : false,
    url : "/html/ssmp/securitycheck/getSecCheckStatus.asp",
    success : function(data) {
        if(data != undefined && data != "") {
          var result = data.replace("\r\n","");
          if(result != "Idle") {
            $("#secCheckStatus").show();
            var statusDes = getDesStatusDes(result);
            $("#secCheckStatus").text(statusDes);
          }
          
          if(result == "Finish") {
            getSecCheckInfo();
            if(checkTimer) {
              clearInterval(checkTimer);
            }
          }
        }
    }
  });
}

function startCollectResult()
{
  $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : "x.Enable=1&x.X_HW_Token="+getValue('onttoken'),
        url : "set.cgi?x=InternetGatewayDevice.X_HW_CheckSafety&RequestFile=html/ssmp/securitycheck/securitycheck.asp",
        success : function() {
          $("#secCheckStatus").show();
          $("#secCheckStatus").text(GetDescFormArrayById(SecurityInfoLgeDes, "s30031"));
          $("#secCheckResult").html("");
          checkTimer = setInterval("getSecCheckStatus()", 1000);
        }
  });
}

</script>
</head>
<body class="mainbody pageBg" onload="LoadFrame();"> 
<div id="faultInfo"> 
<script language="JavaScript" type="text/javascript">
  HWCreatePageHeadInfo("securityCheck.asp", GetDescFormArrayById(SecurityInfoLgeDes, "s30001"), GetDescFormArrayById(SecurityInfoLgeDes, "s30002"), false);
</script> 
<div id="collectSecCheckInfo"> 
    <table width="100%" cellpadding="0" cellspacing="0"> 
        <tr> 
            <td>
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <input class="ApplyButtoncss buttonwidth_150px pix_70_120" name="button" id="collect" type='button' onClick='startCollectResult()' BindText="s30003" />
            </td> 
        </tr> 
    </table> 
</div> 
<br>
<div id = "secCheckStatus" style="display:none">
</div>
<table class="tabal_bg" id="ipfilter" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
  <tr class=" head_title">
    <script>
      document.write("<td  BindText='s30004' " + bottomBorderClass(true) + "></td>" +
                     "<td  BindText='s30005' " + bottomBorderClass(true) + "></td>" +
                     "<td  BindText='s30006' " + bottomBorderClass(true) + "></td> ");
    </script>
  </tr> 
  <tbody id = "secCheckResult">
  </tbody>
</table>
<script>
ParseBindTextByTagName(SecurityInfoLgeDes, "td",     1);
ParseBindTextByTagName(SecurityInfoLgeDes, "div",    1);
ParseBindTextByTagName(SecurityInfoLgeDes, "input",  2);
</script>
</body>
</html>
