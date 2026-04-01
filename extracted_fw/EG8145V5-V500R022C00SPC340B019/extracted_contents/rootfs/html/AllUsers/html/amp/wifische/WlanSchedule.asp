<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlanschedule_language);%>"></script>
<title>Automatic WiFi Shutdown</title>
<script language="JavaScript" type="text/javascript">

function stDuration(domain, StartTime, EndTime, RepeatDay)
{
    this.domain = domain;
    this.StartTime = StartTime;
    this.EndTime = EndTime;
    this.RepeatDay = RepeatDay;
}

var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var PccwFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PCCW);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var Is8011_21V5 = "<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>";
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var systemdsttime = '<%HW_WEB_GetSystemTime();%>';

var DurationArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.{i}, StartTime|EndTime|RepeatDay, stDuration);%>;
var nowIndex = 0;

var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    isFitAp = 1;
}

function ModifyDurtionArr()
{
    var Druationitem = new Array(null, null, null, null);
    var ItemIndex;
    
    for (var i = 0; i < 4; i++)
    {
        if (DurationArr[i] != null)
        {
            ItemIndex = GetDurationIndex(DurationArr[i].domain);
			Druationitem[ItemIndex - 1] = DurationArr[i];
        }
    }

    for (var i = 1; i < 5; i++)
    {
        if (Druationitem[i-1] == null)
        {
            Druationitem[i-1] = new stDuration("InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration."+i, "", "", "1,2,3,4,5,6,7");
        }
    }

    for (var i = 0; i < 4; i++)
    {
	    DurationArr[i] = Druationitem[i];
    }
	
}

function GetDurationIndex(DurationDomain)
{
    var textIndex = '';
    var index = 0;
    index = DurationDomain.indexOf('.Duration.', 0);
    index += '.Duration.'.length;
    return DurationDomain.substr(index, index+1) ;
}

function wlanTimeSplit(InstId, strTimeStart, strTimeEnd)
{
    var InputStart_Hour = 'time_start' + InstId + '_hour';
    var InputStart_Min = 'time_start' + InstId + '_min';
    var InputEnd_Hour = 'time_end' + InstId + '_hour';
    var InputEnd_Min = 'time_end' + InstId + '_min';        
    
    var i = strTimeStart.indexOf(':', 0);
    if (i != 0) {
        setSelect(InputStart_Hour, strTimeStart.substr(0, i));
        setSelect(InputStart_Min, strTimeStart.substr(i + 1));
    }

    i = strTimeEnd.indexOf(':', 0);
    if (i != 0) {
        setSelect(InputEnd_Hour, strTimeEnd.substr(0, i));
        setSelect(InputEnd_Min, strTimeEnd.substr(i + 1));
    }
}

function wlanRepeatSplit(InstId, strValue)
{
    var i = 0;
	
    if ('' == strValue)
    {
        return;
    }

    for (i = 1; i <= 7; i++)
    {
        var CheckID = 'repeat' + InstId + '_day' + + i;
        setCheck(CheckID, 0);
    }

    for (i = 0; i < strValue.length; i = i + 2)
    {
        var CheckID = 'repeat' + InstId + '_day' + + strValue.charAt(i);
        setCheck(CheckID, 1);
    }
}

function LoadResource()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (cfg_wlanschedule_language[b.getAttribute("BindText")]) 
        {
            b.innerHTML = cfg_wlanschedule_language[b.getAttribute("BindText")];
        }
    }
}

function CheckedAllButton(id) {
    var enable = 1;
    for (var i = 1; i <= 7; i++) {
        var CheckID = 'repeat' + id + '_day' + + i;
        if (getCheckVal(CheckID) == 0) {
            enable = 0;
            break;
        }
    }
    setCheck("AllClick" + id, enable);
}

function LoadFrameSche()
{
    LoadResource();

    var wlanSchecuelEnable = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Enable);%>;
    setCheck('wlanScheEnable', wlanSchecuelEnable);    

    setDisplay('wlanShutDownCtrlTable',wlanSchecuelEnable);
    setDisplay('wlanApplyTable',wlanSchecuelEnable);
    setDisplay('addNewBtn',wlanSchecuelEnable);
    
    ModifyDurtionArr();

    if (wlanSchecuelEnable == 1) {
        for (var i = 0;i < 4; i++) {
            if (DurationArr[i].StartTime == "" && DurationArr[i].EndTime == "") {
                continue;
            }
            nowIndex++;
            wlanTimeSplit(nowIndex, DurationArr[i].StartTime, DurationArr[i].EndTime);
            wlanRepeatSplit(nowIndex, DurationArr[i].RepeatDay);
            setDisplay("para_time" + nowIndex, 1);
        }
    }  
    
    if (nowIndex == 4) {
        setDisable("btn_add", 1);
    } else {
        setDisable("btn_add", 0);
    }

    for (var i = 1;i <= 4; i++) {
        CheckedAllButton(i);
    }

    if (rosunionGame == 1) {
        $('#wlanShutDownCtrlTable').addClass('rosTableNoBoder');
        $('#wlanShutDownCtrlTable table td').css('border-bottom', 'none');
    }

    if (systemdsttime == "") {
        systemdsttime = "1970-01-01 01:01";
    }
    systemdsttime = systemdsttime.split("+");
    document.getElementById('nowtime').innerHTML = htmlencode(systemdsttime[0]);
    var year = systemdsttime[0].split("-");
    if (year[0] < 2020) {
        setDisplay("timeIllegal", 1);
        if ((CfgMode.toUpperCase()=="TELECOM2") || (CfgMode.toUpperCase()=="TELECOM")) {
            $("#timeIllegal").css('height', '40px');
        }
    }
    
    if (isFitAp == 1) {
        FitApDisable();
    }
}

function FitApDisable() {
    setDisable("wlanScheEnable", 1);
    setDisable("btn_add", 1);
    setDisable('btn_del', 1);
    var rml = getElement('rml');
    for (var i = 0; i < rml.length; i++) {
        rml[i].disabled = true;
    }

    for (var i = 1;i <= 4; i++) {
        setDisable('time_start' + i + '_hour', 1);
        setDisable('time_start' + i + '_min', 1);
        setDisable('time_end' + i + '_hour', 1);
        setDisable('time_end' + i + '_min', 1);

        setDisable('AllClick' + i, 1);
        for (var j = 1; j <= 7; j++) {
            setDisable('repeat' + i + '_day' + j, 1);
        }
    }
    setDisable('applyButton', 1);
    setDisable('cancelButton', 1);
}

function wlanScheSetEnable()
{
    var Form = new webSubmitForm();
    var enable = getCheckVal('wlanScheEnable');
	var Url_enable = '';
	
	if (1 == PccwFlag)
	{
		if (0 == enable
			&& (('' != DurationArr[0].StartTime) || ('' != DurationArr[1].StartTime) || ('' != DurationArr[2].StartTime) || ('' != DurationArr[3].StartTime)))
		{
			if (false == ConfirmEx(cfg_wlanschedule_language['amp_wlan_schedule_enable_wlan'])) 
			{
				LoadFrameSche();
				return false;
			}
			Form.addParameter('v.X_HW_WlanEnable', 1);
			Url_enable += '&v=InternetGatewayDevice.LANDevice.1';
		} 
	}
    setDisplay('wlanShutDownCtrlTable',enable);
    setDisplay('wlanApplyTable',enable);

    Form.addParameter('x.Enable',enable);
    Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl'
					+ Url_enable
                    + '&RequestFile=html/amp/wifische/WlanSchedule.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function isIntegerOrNull(value)
{
    if ((true != isPlusInteger(value)) && ('' != value))
    {
        return false;
    }
    
    return true;
}

function IsFttrEqualAlert() {
    if (fttrFlag == 1) {
        AlertEx(cfg_wlanschedule_language['amp_wlan_schedule_time_error_fttr']);
    } else {
        AlertEx(cfg_wlanschedule_language['amp_wlan_schedule_time_error']);
    }
}

function setParameterTimeCheck(Form)
{
    var time1_begin_h = getValue('time_start1_hour');
    var time2_begin_h = getValue('time_start2_hour');
    var time3_begin_h = getValue('time_start3_hour');
    var time4_begin_h = getValue('time_start4_hour');            
    
    var time1_begin_m = getValue('time_start1_min');
    var time2_begin_m = getValue('time_start2_min');
    var time3_begin_m = getValue('time_start3_min');
    var time4_begin_m = getValue('time_start4_min');        
    
    var time1_end_h = getValue('time_end1_hour');
    var time2_end_h = getValue('time_end2_hour');
    var time3_end_h = getValue('time_end3_hour');
    var time4_end_h = getValue('time_end4_hour');            
    
    var time1_end_m = getValue('time_end1_min');
    var time2_end_m = getValue('time_end2_min');
    var time3_end_m = getValue('time_end3_min');
    var time4_end_m = getValue('time_end4_min');            

    if (   ( (('0' == time4_begin_h)||('00' == time4_begin_h)) && (('0' == time4_begin_m)||('00' == time4_begin_m)) && (('0' == time4_end_h)||('00' == time4_end_h)) && (('0' == time4_end_m)||('00' == time4_end_m)) )
        || ( (('0' == time3_begin_h)||('00' == time3_begin_h)) && (('0' == time3_begin_m)||('00' == time3_begin_m)) && (('0' == time3_end_h)||('00' == time3_end_h)) && (('0' == time3_end_m)||('00' == time3_end_m)) )
        || ( (('0' == time2_begin_h)||('00' == time2_begin_h)) && (('0' == time2_begin_m)||('00' == time2_begin_m)) && (('0' == time2_end_h)||('00' == time2_end_h)) && (('0' == time2_end_m)||('00' == time2_end_m)) )
        || ( (('0' == time1_begin_h)||('00' == time1_begin_h)) && (('0' == time1_begin_m)||('00' == time1_begin_m)) && (('0' == time1_end_h)||('00' == time1_end_h)) && (('0' == time1_end_m)||('00' == time1_end_m)) )  )
    {
        IsFttrEqualAlert();
        return false;        
    }

    if ((time1_begin_h * 60 + time1_begin_m * 1) == (time1_end_h * 60 + time1_end_m * 1))
    {
        if ((0 != (time1_begin_h * 60 + time1_begin_m * 1)) || ( 0 != (time1_end_h * 60 + time1_end_m * 1)))
        {
            IsFttrEqualAlert();
            return false;        
        }
    }

    if ((time2_begin_h * 60 + time2_begin_m * 1) == (time2_end_h * 60 + time2_end_m * 1))
    {
        if ((0 != (time2_begin_h * 60 + time2_begin_m * 1)) || ( 0 != (time2_end_h * 60 + time2_end_m * 1)))
        {
            IsFttrEqualAlert();
            return false;        
        }
    }

    if ((time3_begin_h * 60 + time3_begin_m * 1) == (time3_end_h * 60 + time3_end_m * 1))
    {
        if ((0 != (time3_begin_h * 60 + time3_begin_m * 1)) || ( 0 != (time3_end_h * 60 + time3_end_m * 1)))
        {
            IsFttrEqualAlert();
            return false;        
        }
    }

    if ((time4_begin_h * 60 + time4_begin_m * 1) == (time4_end_h * 60 + time4_end_m * 1))
    {
        if ((0 != (time4_begin_h * 60 + time4_begin_m * 1)) || ( 0 != (time4_end_h * 60 + time4_end_m * 1)))
        {
            IsFttrEqualAlert();
            return false;        
        }
    }

    return true;
}

function repeatdayformat(repeatday)
{
    if (getCheckVal(repeatday) == 1)
    {
        var length = repeatday.length;
        var str = parseInt(repeatday.charAt(length-1));
        return str + ',';
    }

    return '';
}

function droplastsplitRepeatDay(time_repeat)
{
    var length = time_repeat.length; 
    if (0 < length)
    {
        return time_repeat.substr(0,length-1);
    }

    return '';
}

function droplastsplitTime(time_value)
{
    if (':' ==  time_value)
    {
        return '';
    }
    
    return time_value;
}

function ApplyForEach(Form, index) {
    if (index <= nowIndex) {
        time_start = getValue('time_start' + index + '_hour') + ':' + getValue('time_start' + index + '_min');
        var time_end = getValue('time_end' + index + '_hour') + ':' + getValue('time_end' + index + '_min');
        var time_repeat = repeatdayformat('repeat' + index + '_day1') + repeatdayformat('repeat' + index + '_day2') + repeatdayformat('repeat' + index + '_day3') + 
                            repeatdayformat('repeat' + index + '_day4') + repeatdayformat('repeat' + index + '_day5') + repeatdayformat('repeat' + index + '_day6') + 
                            repeatdayformat('repeat' + index + '_day7');
        time_repeat = droplastsplitRepeatDay(time_repeat);
        time_start = droplastsplitTime(time_start);
        time_end = droplastsplitTime(time_end);

        if (time_repeat == '') {
            AlertEx(cfg_wlanschedule_language['amp_wlan_schedule_week_empty']);
            return false;
        }
    } else {
        var time_start = "";
        var time_end = "";
        var time_repeat = "1,2,3,4,5,6,7";
    }

    Form.addParameter('x' + index + '.StartTime', time_start);
    Form.addParameter('x' + index + '.EndTime', time_end);
    Form.addParameter('x' + index + '.RepeatDay', time_repeat);
    
    return true;
}

function Apply()
{
    var Form = new webSubmitForm();
    var enable = getCheckVal('wlanScheEnable');
    var Url_enable = '';
    var time_start = '';
    if (setParameterTimeCheck(Form) == false)
    {
        return false;
    }

    for (var i = 1;i <= 4; i++) {
        if (ApplyForEach(Form, i) == false) {
            return false;
        }
    }
	if (1 == PccwFlag)
	{
		if ((time_start == '') && ((DurationArr[0].StartTime != '') || (DurationArr[1].StartTime != '') ||
            (DurationArr[2].StartTime != '') || (DurationArr[3].StartTime != '')))
		{
			if (false == ConfirmEx(cfg_wlanschedule_language['amp_wlan_schedule_enable_wlan'])) 
			{
				return false;
			}
			Form.addParameter('v.X_HW_WlanEnable', 1);
			Url_enable += '&v=InternetGatewayDevice.LANDevice.1';
		}
	}
    Form.setAction('set.cgi?' 
                    + 'x1=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.1'
                    + '&x2=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.2'
                    + '&x3=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.3'
                    + '&x4=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.4'
                    + Url_enable
                    + '&RequestFile=html/amp/wifische/WlanSchedule.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function Cancel() {
    location.reload();
}

function AllClickEvent(id) {
    var enable = getCheckVal(id);
    var length = id.length - 1;
    var InstId = parseInt(id.charAt(length));
    for (var i = 1; i <= 7; i++) {
        var CheckID = 'repeat' + InstId + '_day' + + i;
        setCheck(CheckID, enable);
    }
}

function AllClick(id) {
    AllClickEvent(id);
    var enable = getCheckVal(id);
    setCheck(id, 1 - enable);
}

function DayEnable(id) {
    DayTbEnable(id);
}

function DayTbEnable(id) {
    var enable = getCheckVal(id);
    setCheck(id, 1 - enable);
    if (id.includes("AllClick")) {
        AllClickEvent(id);
    }
}

function setSelect(sId, sValue) {
    var item;
    if (null == (item = getElement(sId))) {
        debug(sId + " is not existed" );
        return false;
    }

    if (sValue == "") {
        item.options[0].selected = true;
        return;
    }

    for (var i = 0; i < item.options.length; i++) {
        if (parseInt(item.options[i].value) == parseInt(sValue)) {
            item.options[i].selected = true;
            return true;
        }
    }

    return false;
}

function InitSelectOp(id, num) {
    document.write('<select id="' + id + '" name="' + id + '" style="width: 40px" >');
    for (var i = 0; i <= num; i++) {
        var showNum = i;
        if (i >= 0 && i <= 9) {
            showNum = "0" + i;
        }
        document.write("<option value='" + i + "'>" + showNum + "</option>");
    }
    document.write('</select>');
}

function InitTimeSelect(idHour, idMin, defaultVal) {
    InitSelectOp(idHour, 23);
    document.write(cfg_wlanschedule_language['amp_wlan_schedule_time_separator']);
    InitSelectOp(idMin, 59);
    setSelect(idHour, defaultVal);
    setSelect(idMin, '0');
}

function AddNewSche() {
    nowIndex++;
    if (nowIndex == 4) {
        setDisable("btn_add", 1);
    }
    setDisplay("para_time" + nowIndex, 1);
}

function DelSche() {
    var Form = new webSubmitForm();
    var rml = getElement('rml');
    var index;
    var url = 'set.cgi?';

    if (rml == null) {
        return;
    }

    if (rml.length > 0) {
        for (var i = 0; i < rml.length; i++) {
            if (rml[i].checked == true) {
                index = rml[i].value;
                Form.addParameter('x' + index + '.StartTime', "");
                Form.addParameter('x' + index + '.EndTime', "");
                url += "x" + index + "=InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration." + index + "&";
            }
        }
    } else if (rml.checked == true) {
        index = rml[i].value;
        Form.addParameter('x' + index + '.StartTime', "");
        Form.addParameter('x' + index + '.EndTime', "");
        url += "x" + index + "=InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration." + index + "&";
    }
    
    url += 'RequestFile=html/amp/wifische/WlanSchedule.asp'
    Form.setAction(url);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}
</script>
<style>
input[type="checkbox"] {
    width: 20px;
    height: 20px;
}
.table_title {
    background-color: #FFFFFF;
    padding-left: 5px;
    height: 35px;
    line-height: 150%;
    font-size: 14px;
    font-family: "微软雅黑";
    color: #666666;
    text-align: center;
    padding-right: 5px;
}
</style>
</head>

<body class="mainbody" onLoad="LoadFrameSche();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("WlanSche", GetDescFormArrayById(cfg_wlanschedule_language, "amp_wlan_schedule_header"), GetDescFormArrayById(cfg_wlanschedule_language, "amp_wlan_schedule_title"), false);
</script>

<div class="title_spread"></div>

<div class="func_title">
    <SCRIPT>document.write(cfg_wlanschedule_language["amp_wlan_schedule_config"]);</SCRIPT>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0" id="wlanScheCfg">
<tr><td>
<form id="ConfigForm" action="../network/set.cgi">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
        <tr id="para_enable">
            <td class="table_title" width="70%" style="text-align:left !important;"><input style="width:15px;height:15px;" type='checkbox' id='wlanScheEnable' name='wlanScheEnable' onClick='wlanScheSetEnable();' value="OFF">
                                               <script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_enable']);</script></input></td>
            <td id="addNewBtn" class="table_title" width="30%">
                <input id="btn_add" name="btnCheck" type="button" value="New" class="NewDelbuttoncss" onClick="AddNewSche();">
                    <script>document.getElementById('btn_add').value = cfg_wlanschedule_language['amp_wlan_schedule_add'];</script>
                </input>
                <input id="btn_del" name="btnCheck" type="button" value="Delete" class="NewDelbuttoncss" onClick="DelSche();">
                    <script>document.getElementById('btn_del').value = cfg_wlanschedule_language['amp_wlan_schedule_del'];</script>
                </input>
            </td>
        </tr>
    </table>

    <table id="wlanShutDownCtrlTable" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="display:none">
        <tr id="para_header">
          <td class="table_title" width="1%"></td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_time_start']);</script></td>
            </table>
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_time_end']);</script></td>
            </table>
          </td>
          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_mon']);</script></td>
            </table>
          </td>
          
          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">          
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_tue']);</script></td>
            </table>
          </td>

          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">          
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_wed']);</script></td>
            </table>
          </td>

          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_thu']);</script></td>
            </table>
          </td>

          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_fri']);</script></td>
            </table>
          </td>

          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_sat']);</script></td>
            </table>
          </td>

          <td class="table_title" width="8.5%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_week_sun']);</script></td>  
            </table>
          </td>
          <td id="allClickTitle" class="table_title" width="8.5%">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                  <td class="table_title" width="100%"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_all']);</script></td>
              </table>
          </td>
        </tr>

        <tr id="para_time1" style="display:none;">
          <td class="table_title" width="1%" >
              <input type="checkbox" style="width:14px;height:14px;" name="rml" id="rml" value="1">
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_start1_hour", "time_start1_min", "0");
            </script>
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_end1_hour", "time_end1_min", "7");
            </script>
          </td>

          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day1');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day1' name='repeat1_day1' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day2');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day2' name='repeat1_day2' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day3');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day3' name='repeat1_day3' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day4');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day4' name='repeat1_day4' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day5');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day5' name='repeat1_day5' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day6');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day6' name='repeat1_day6' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>


          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat1_day7');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat1_day7' name='repeat1_day7' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>
          </td>
          <td id='AllClickrepeat1' class="table_title" width="8.5%" onClick="DayTbEnable('AllClick1');">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                  <td class="table_title" width="100%"><input type='checkbox' id='AllClick1' name='AllClick1' onClick='AllClick(this.id);' value="OFF"></td>
              </table>
          </td>
        </tr>
        
        <tr id="para_time2" style="display:none;">
          <td class="table_title" width="1%">
              <input type="checkbox" style="width:14px;height:14px;" name="rml" id="rml" value="2">
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_start2_hour", "time_start2_min", "0");
            </script>
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_end2_hour", "time_end2_min", "7");
            </script>
          </td>
          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day1');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day1' name='repeat2_day1' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day2');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day2' name='repeat2_day2' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>
          
        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day3');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day3' name='repeat2_day3' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day4');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day4' name='repeat2_day4' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>


        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day5');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day5' name='repeat2_day5' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day6');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day6' name='repeat2_day6' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>         
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat2_day7');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat2_day7' name='repeat2_day7' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>
          </td>
          <td id='AllClickrepeat2' class="table_title" width="8.5%" onClick="DayTbEnable('AllClick2');">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                  <td class="table_title" width="100%"><input type='checkbox' id='AllClick2' name='AllClick2' onClick='AllClick(this.id);' value="OFF"></td>
              </table>
          </td>
        </tr>
        
        <tr id="para_time3" style="display:none;">
            <td class="table_title" width="1%">
                <input type="checkbox" style="width:14px;height:14px;" name="rml" id="rml" value="3">
            </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_start3_hour", "time_start3_min", "0");
            </script>
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_end3_hour", "time_end3_min", "7");
            </script>
          </td>
          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day1');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day1' name='repeat3_day1' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>            
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day2');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day2' name='repeat3_day2' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>            
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day3');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day3' name='repeat3_day3' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>            
          </td>
          
        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day4');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day4' name='repeat3_day4' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>            
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day5');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day5' name='repeat3_day5' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>            
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day6');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day6' name='repeat3_day6' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>            
          </td>
          
        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat3_day7');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat3_day7' name='repeat3_day7' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>
          </td>
          <td id='AllClickrepeat3' class="table_title" width="8.5%" onClick="DayTbEnable('AllClick3');">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                  <td class="table_title" width="100%"><input type='checkbox' id='AllClick3' name='AllClick3' onClick='AllClick(this.id);' value="OFF"></td>
              </table>
          </td>
        </tr>
        
        <tr id="para_time4" style="display:none;">
            <td class="table_title" width="1%">
                <input type="checkbox" style="width:14px;height:14px;" name="rml" id="rml" value="4">
            </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_start4_hour", "time_start4_min", "0");
            </script>
          </td>
          <td class="table_title" width="14%" style="padding-left:1px;padding-right:1px;min-width:91px;">
            <script>
                InitTimeSelect("time_end4_hour", "time_end4_min", "7");
            </script>
          </td>
          
          <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day1');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day1' name='repeat4_day1' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>           
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day2');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day2' name='repeat4_day2' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>           
          </td>


        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day3');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day3' name='repeat4_day3' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>           
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day4');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day4' name='repeat4_day4' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>           
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day5');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day5' name='repeat4_day5' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>           
          </td>

        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day6');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day6' name='repeat4_day6' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>           
          </td>
          
        <td class="table_title" width="8.5%" onClick="DayTbEnable('repeat4_day7');">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <td class="table_title" width="100%"><input type='checkbox' id='repeat4_day7' name='repeat4_day7' onClick='DayEnable(this.id);' value="OFF"></td>
            </table>
          </td>
          <td id='AllClickrepeat4' class="table_title" width="8.5%" onClick="DayTbEnable('AllClick4');">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
                  <td class="table_title" width="100%"><input type='checkbox' id='AllClick4' name='AllClick4' onClick='AllClick(this.id);' value="OFF"></td>
              </table>
          </td>
        </tr>
    </table>

    <div style="background-color:#fff;padding-top:20px;height: 25px;">
        <div style="float:left;width:150px;" class="nowtime">
        <script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_system_time']);</script>
      </div>
      <div class="nowtime" style="float:left;" id="nowtime"></div>
    </div>

    <div id="timeIllegal" style="background-color:#fff;display:none;clear:both">
        <div class="scheduletime" style="color:red;margin-left:150px;">
            <script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_time_illegal']);</script>
        </div>
    </div>

    <table id="wlanApplyTable" width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none">
      <tr><td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
          <tr>
            <td class="table_submit width_per25"></td>
            <td class="table_submit"> 
			  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
              <button id="applyButton" name="applyButton" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Apply();"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_apply']);</script></button>
              <button id="cancelButton" name="cancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="Cancel();"><script>document.write(cfg_wlanschedule_language['amp_wlan_schedule_cancel']);</script></button>
            </td>
          </tr>
        </table>
      </td></tr>
    </table>
 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr ><td class="width_15px"></td></tr>
    </table> 

</form>
</td></tr>
</table>
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd -->
</html>

