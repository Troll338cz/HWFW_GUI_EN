<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>

<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>

<title>IP Incoming Filter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/lanuserinfo.asp"></script>
<script language="javascript" src="../../bbsp/common/date.asp"></script>

<script language="JavaScript" type="text/javascript">

var cmccFeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CMCC_RMS);%>' | '<%HW_WEB_GetFeatureSupport(FT_CWMP_CMCC_RMS);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';

function stSyslogCfg(domain, Enable, Level, QueryLevel) {
    this.domain = domain;
    this.Enable = Enable;
    this.Level = Level;
    this.QueryLevel = QueryLevel;
}

var temp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_Syslog, Enable|Level|QueryLevel, stSyslogCfg);%>; 
var SyslogCfg = temp[0];

var LogLevelInfo = ["[Emergency", "[Alert", "[Critical", "[Error", "[Warning", "[Notice", "[Informational", "[Debug"];

function LoadFrame() {
    if(CfgMode.toUpperCase() == 'SHCTA8C') {
        setDisplay('DivLogView', 1);
    } else {
        setDisplay('DivLogView', 1);
    }
}
function CheckLogLevel(LineLogText, LookLogLevel) {
    var LevelInfoLength = LogLevelInfo.length;
    var i = parseInt(LookLogLevel, 10) + 1;

    for (; i < LevelInfoLength ; i++) {
        if (LineLogText.indexOf(LogLevelInfo[i]) != -1) {
            return false;
        }
    }

    return true;
}

function RefreshByLogType() {

    var OldLogText = document.getElementById("logarea").value;
    var QueryLevel = SyslogCfg.QueryLevel;
    var ResultLog = OldLogText.split("\n");
    var NewShowLog = "";
    var blankLineFlag = false;
    var IDtable = 1;


    for (var i = 0; i < ResultLog.length -1; i++ ) {
        if(blankLineFlag == false) {
             NewShowLog += ResultLog[i];
             NewShowLog += "\n<br>";
             if ((ResultLog[i] == "\r") || (ResultLog[i] ==  "")) {
                blankLineFlag = true;
                document.getElementById('Syslogtitle').innerHTML = htmlencode(NewShowLog);
             }
        } else {
            if ((ResultLog[i] != "\r\n") || (ResultLog[i] != "") || (ResultLog[i] != "\0")) {
                if (CheckLogLevel(ResultLog[i], QueryLevel) == true) {
                    NewShowLog += ResultLog[i];
                    NewShowLog += "\n";
                    var loginof =ResultLog[i];
                    var logtime = loginof.split("[");
                    var temp = loginof.split("]");
                    var loglevel = loginof.substring(logtime[0].length+1,temp[0].length);
                    var logalert = loginof.substring(temp[0].length+1,loginof.length);
                    
                    var id_time = "log_2_" + (IDtable++) + "_table";
                    var id_device = "log_2_" + (IDtable++) + "_table";
                    var id_critical= "log_2_" + (IDtable++) + "_table";
                    var id_alert= "log_2_" + (IDtable++) + "_table";

                    document.write('<tr class="tabal_center01 " id="trlog' + id_time + '">');
                    
                    document.write('<TD id="' + id_time +'">' + htmlencode(logtime[0]) + '</TD>');
                    if (cmccFeature == 0) {
                        document.write('<TD id="' + id_device + '">' + 'user' + '</TD>');
                    }
                    document.write('<TD id="' + id_critical+ '">' + htmlencode(loglevel) + '</TD>');
                    document.write('<TD id="' + id_alert + '" title="'+htmlencode(logalert)+'">'+GetStringContent(htmlencode(logalert), 64)+'</TD>');  					
                    document.write('</tr>');
                }
            }
        }
    }
}

function isValidHour(val) {
    if ((isValidNumber(val) == true) && (parseInt(val,10) < 24)) {
        return true;
    }
    return false;
}

function isValidMinute(val) {
    if ((isValidNumber(val) == true) && (parseInt(val,10) < 60)) {
        return true;
    }
    return false;
}

function parseTime(str) {
    if (str.length == 1) {
        str = '0' + str;
    }
    return str;
}

function isDecDigit(digit) 
{
    var decVals = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    var len = decVals.length;
    var i = 0;
    var ret = false;

    for (i = 0; i < len; i++) {
        if (digit == decVals[i]) {
            break;
        }
    }

    if (i < len) {
        ret = true;
    }
    return ret;
}

function isValidNumber(number) {
    var numberLen = number.length;
    if ((numberLen != 2) && (numberLen != 1)) {
        return false;
    }

    for (var i = 0 ; i < numberLen ; i++) {
        if (isDecDigit(number.charAt(i)) == false) {
            return false;
        }
    }
    return true;
}

function isValidTimeDuration(startHour, startMin, endHour, endMin,startDate, expiryDate)
{
    if (parseInt(startHour, 10) < parseInt(endHour, 10)) {
        return true;
    } else if ((parseInt(startHour,10) == parseInt(endHour,10)) && (parseInt(startMin,10) < parseInt(endMin,10))) {
        return true;
    } else {
       if (parseInt(startDate,10 ) < parseInt(expiryDate,10)) {
          return true;
       } else {
          return false;
       }
    }
}

function CheckParameter(strStartDate, strExpiryDate) {
    var strStartHour = getValue('StartHour');
    var strStartMin = getValue('StartMin');
    var strEndHour = getValue('EndHour');
    var strEndMin = getValue('EndMin');
    if ((strStartDate == '' )&& (strStartMin == '')&& (strStartHour == '') && (strExpiryDate == '') &&
        (strEndHour == '') && (strEndMin == '')) {
       return true;
    }
    if (strStartMin == '') {
       strStartMin = "0";
    }
    if (strEndMin == '') {
       strEndMin = "0";
    }
    if (isValidNumber(strStartHour)) {
       strStartHour = parseTime(strStartHour);
    }

    if (isValidNumber(strStartMin)) {
       strStartMin = parseTime(strStartMin);
    }

    if (isValidNumber(strEndHour)) {
        strEndHour = parseTime(strEndHour);
    }

    if (isValidNumber(strEndMin)) {
        strEndMin = parseTime(strEndMin);
    }

    var strStartTime = strStartHour +":" + strStartMin; 
    var strEndTime = strEndHour +":" + strEndMin;

    if ((isValidNumber(strStartHour) == false) || (isValidNumber(strStartMin) == false)) {
        AlertEx("时间无效");
        return false;
    }
    if((isValidNumber(strEndHour) == false) || (isValidNumber(strEndMin) == false)) {
        AlertEx("时间无效");
        return false;
    }

    if (isValidHour(strStartHour == false)) {
        AlertEx("时间中输入小时范围无效。有效小时范围（00-23）。");
        return false;
    }
    if (isValidHour(strEndHour) == false) {
        AlertEx("时间中输入小时范围无效。有效小时范围（00-23）。");
        return false;
    }
    if (isValidMinute(strStartMin) == false) {
        AlertEx("时间中输入分钟范围无效。有效分钟范围（00-59）。");
        return false;
    }
    if (isValidMinute(strEndMin) == false) {
        AlertEx("时间中输入分钟范围无效。有效分钟范围（00-59）。");
        return false;
    }

    return true;
}

var g_id_num = 0;

function RefreshByLogTypeEx() {
    var OldLogText = document.getElementById("logarea").value;
    var QueryLevel = SyslogCfg.QueryLevel;
    var ResultLog = OldLogText.split("\n");
    var NewShowLog = "";
    var blankLineFlag = false;
    var IDtable = 1;
    var CheckTimeFlat = 0;

    var StartDate = getValue('StartDate');
    var StartHour = getValue('StartHour');
    var StartMin = getValue('StartMin');
    var EndDate = getValue('EndDate');
    var EndHour = getValue('EndHour');
    var EndMin = getValue('EndMin');

    if ((StartDate != "") || (StartHour != "") || (StartMin != "") || (EndDate != "") || (EndHour != "") || (EndMin != "")) {
        if (CheckParameter(StartDate, EndDate) == false) {
            return false;
        }
    } else {
        CheckTimeFlat = 1;
    }

    var tr_id = "";
    for (var j = 1; j < g_id_num + 1; j = j + 4) {
        tr_id = "log_2_" + j + "_table";
        setDisplay('trlog' + tr_id, 1);
    }

    StartDate = StartDate.replace(/-/g,'/');
    EndDate = EndDate.replace(/-/g,'/');
    var startstr = StartDate + " " + StartHour + ":"+StartMin + ":" + 0;
    var endstr = EndDate + " " + EndHour + ":" + EndMin + ":" + 0;

    var begingtime = new Date(startstr);
    var endtime = new Date(endstr);
    if ((StartDate != "") && (StartHour != "") && (StartMin != "") && (EndDate != "") && (EndHour != "") && (EndMin != "")) {
        if (begingtime.getTime() >= endtime.getTime()) {
            AlertEx("输入的时间段不合法。");
            return ;
        }
    }

    var typeLog_select = document.getElementById("TypeLog_select").value;
    var typeLog_selectstr = "";
    if (typeLog_select == 0) {
        typeLog_selectstr="告警日志";
    } else if(typeLog_select == 1) {
        typeLog_selectstr="配置日志";
    } else if(typeLog_select == 2) {
        typeLog_selectstr="Shell日志";
    } else if(typeLog_select == 3) {
        typeLog_selectstr="运行日志";
    } else if(typeLog_select == 4) {
        typeLog_selectstr="事件日志";
    }

    var levelLog_select = document.getElementById("LevelLog_select").value;
    var levelLog_selectstr = "";
    if (levelLog_select == 0) {
        levelLog_selectstr="Emergency";
    } else if(levelLog_select == 1) {
        levelLog_selectstr="Alert";
    } else if(levelLog_select == 2) {
        levelLog_selectstr="Critical";
    } else if(levelLog_select == 3) {
        levelLog_selectstr="Error";
    } else if(levelLog_select == 4) {
        levelLog_selectstr="Warning";
    } else if(levelLog_select == 5) {
        levelLog_selectstr="Notice";
    } else if(levelLog_select == 6) {
        levelLog_selectstr="Informational";
    } else if(levelLog_select == 7) {
        levelLog_selectstr="Debugging";
    }

    for (var i = 0; i < ResultLog.length -1; i++ ) {
        if (blankLineFlag == false) {
             NewShowLog += ResultLog[i];
             NewShowLog += "\n<br>";
             if ((ResultLog[i] == "\r") || (ResultLog[i] == "")) {
                blankLineFlag = true;
                document.getElementById('Syslogtitle').innerHTML = NewShowLog;
             }
        } else {
            if ((ResultLog[i] != "\r\n") || (ResultLog[i] != "") || (ResultLog[i] != "\0")) {
                if (CheckLogLevel(ResultLog[i], QueryLevel) == true) {
                    NewShowLog += ResultLog[i];
                    NewShowLog += "\n";
                    var loginof =ResultLog[i];
                    var logtime = loginof.split("[");
                    var temp = loginof.split("]");

                    var loglevel = loginof.substring(logtime[0].length+1,temp[0].length);
                    var logalert = loginof.substring(temp[0].length+1,loginof.length);

                    var logtimeinfo=logtime[0];
                    var logtypetmp=loginof.split("]")[1];
                    var logtype=logtypetmp.substring(1,logtypetmp.length);

                    logtimeinfo = logtimeinfo.replace(/-/g,'/');
                    var logCalendarTime = new Date(logtimeinfo);
                    
                    g_id_num = IDtable;
                    
                    var id_time = "log_2_" + (IDtable++) + "_table";
                    var id_device = "log_2_" + (IDtable++) + "_table";
                    var id_critical= "log_2_" + (IDtable++) + "_table";
                    var id_alert= "log_2_" + (IDtable++) + "_table";
                   
                    if (((logCalendarTime.getTime () - begingtime.getTime () > 0) && (logCalendarTime.getTime () - endtime.getTime () < 0)) ||
                        (CheckTimeFlat == 1)) {
                        if ((logtype == typeLog_selectstr) || (typeLog_select == 5)) {
                            if ((loglevel == levelLog_selectstr) || (levelLog_select == 8)) {
                            } else {
                                setDisplay('trlog' + id_time, 0);
                            }
                        } else {
                            setDisplay('trlog' + id_time, 0);
                        }
                    } else {
                        setDisplay('trlog' + id_time, 0);
                    }
                }
            }
        }
    }
}

var g_hidelogtr=""

function CheckLogView() {
    setDisplay('DivLogView', 1);
    RefreshByLogTypeEx(); 
}

function ClearLog() {
}

function AccRefreshSubmit() {
    window.location="e8clogviewShct.asp";
}
function AccCloseSubmit() {
    setDisplay('DivLogView', 0);
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();"> 
<div id="logconfig"> 
<span style="font-size: 12px;font-weight: bold;">日志启用状态：&nbsp;&nbsp;</span>
<span>
<script type="text/javascript">
if (SyslogCfg.Enable == 1) {
    document.write("日志已启用");
} else {
    document.write("日志未启用");
}
</script> 
</span>
<div class="func_spread"></div>
<div class="title_with_desc">系统记录：</div>
<div class="title_01" width="100%">您可以点击“查看日志”来查看系统记录。</div>

<div class="func_spread"></div>
<div class="button_spread"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" id="SysLogInst">
<tr>
    <td>类型</td>
    <td><select name="TypeLog_select" size="1" id="TypeLog_select"> 
          <option value="5">全部日志</option>
          <option value="0">告警日志</option> 
          <option value="1">配置日志</option> 
          <option value="2">Shell日志</option> 
          <option value="3">运行日志</option> 
          <option value="4">事件日志</option>
        </select>
    </td>

    <td>级别</td>
    <td><select name="LevelLog_select" size="1" id="LevelLog_select"> 
          <option value="8">ALL</option>
          <option value="0">Emergency</option> 
          <option value="1">Alert</option> 
          <option value="2">Critical</option> 
          <option value="3">Error</option> 
          <option value="4">Warning</option> 
          <option value="5">Notice</option> 
          <option value="6">Informational</option> 
          <option value="7">Debugging</option> 
        </select>
    </td>
    <td>开始时间</td>
    <td><input id="StartDate" type="Text" style="width:100px;" value=""><td>
    <td><input id="StartHour" type="Text" style="width:16px;margin-left:-15px;" value=""><td>
    <td><span innerhtml=" : "> : </span><td>
    <td><input id="StartMin" type="Text" style="width:16px;" value=""><td>

    <td>结束时间</td>
    <td><input id="EndDate" type="Text" style="width:100px;" value=""><td>
    <td><input id="EndHour" type="Text" style="width:16px;margin-left:-15px;" value=""><td>
    <td><span innerhtml=" : "> : </span><td>
    <td><input id="EndMin" type="Text" style="width:16px;" value=""><td>

</tr>

<script>
getElById('StartDate').onclick = function () {
    var oevent = window.event||arguments[0];
    fPopCalendar(oevent,this,this,0);
}
getElById('EndDate').onclick = function () {
    var oevent = window.event||arguments[0];
    fPopCalendar(oevent,this,this,0);
}
</script>
</table>
<div><input class="submit" name="CheckLog_button" id="CheckLog_button" type="button" value="查看日志" onClick="CheckLogView();">
    <input class="submit" style='display:none' name="ClearLog_button" id="ClearLog_button" type="button" value="清除记录" onClick="ClearLog();"> 
</div>
<div id="DivLogView">
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
<div class="func_spread"></div>

<tr> 
<td><span style="font-size: 12px;font-weight: bold;"><lable>系统日志&nbsp;&nbsp;</lable></span>
</tr> 
<tr>
<td id="Syslogtitle" style="font-size: 12px;font-weight: bold;"></td>
</tr>
</table> 
<div id="logviews" align="center" style="display:none"> 
  <textarea name="logarea" id="logarea" style="width:100%;height:330px;margin-bottom:20px;" wrap="off" readonly="readonly">
</textarea> 
    <script type="text/javascript">
            document.getElementById("logarea").value='<%HW_WEB_GetLogInfo();%>';
            var sss= document.getElementById("logarea").value;
     </script> 
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="SysLogInst">
    <script language="JavaScript" type="text/javascript">

    document.write('<tr class="head_title">');
    document.write('<td class="width_5p" id="log_1_1_table"><div class="align_center">日期/时间</div></td>');
    if (cmccFeature == 0) {
      document.write('<td class="width_3p" id="log_1_2_table"><div class="align_center">设备</div></td>');
    }

    document.write('<td class="width_3p" id="log_1_3_table"><div class="align_center">级别</div></td>');
    document.write('<td class="width_17p" id="log_1_4_table"><div class="align_center">消息</div></td>');
    document.write(' </tr>');

    RefreshByLogType();
    </script>
</table>
  
    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
    <tr> 
        <td class="table_submit" width='25%'></td> 
        <td  class="table_submit" align="right"> 
            <input class="submit" name="AccRefresh_button" id="AccRefresh_button" type="button" value="刷新" onClick="AccRefreshSubmit();">
            <input class="submit" name="AccClose_button" id="AccClose_button" type="button" value="关闭" onClick="AccCloseSubmit();">
        </td>
    </tr>
  </table>
</div>
</div>
</body>
</html>
