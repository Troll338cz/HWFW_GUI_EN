<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<style>
    #PasswordRemark,#pwdTextRemark,#ConnectionRequestPasswordRemark,#requestPwdTextRemark{
        float: right;
        margin-right: 54%;
    }
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<style>
.InputTime
    {
        width:20px;  
    }
</style>
<style>
form{padding:0;margin:0}
</style>
<script language="JavaScript" type="text/javascript">
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var RebootConfigFormList = new Array();

function stEnableReboot(domain,Enable,RunningDays,RebootStartTime,RebootEndTime,TrafficKeepTime,TrafficLimit) {
    this.domain = domain;
    this.Enable = Enable;
    this.RunningDays = RunningDays;
    this.RebootStartTime = RebootStartTime;
    this.RebootEndTime = RebootEndTime;
    this.TrafficKeepTime = TrafficKeepTime;
    this.TrafficLimit = TrafficLimit;
}

var EnableReboots = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_AutoReboot, Enable|RunningDays|RebootStartTime|RebootEndTime|TrafficKeepTime|TrafficLimit,stEnableReboot);%>;
var EnableReboot = EnableReboots[0];

function LoadFrame()
{
    setCheck('EnableReboot', EnableReboot.Enable);

    var time_start_min_1 = EnableReboot.RebootStartTime % 60;
    if (time_start_min_1 < 10) {
        time_start_min_1 = "0" + time_start_min_1;
    }
    var time_start_hour_1 = parseInt(EnableReboot.RebootStartTime / 60);
    if (time_start_hour_1 < 10) {
        time_start_hour_1 = "0" + time_start_hour_1;
    }
    var time_end_hour_1 = parseInt(EnableReboot.RebootEndTime / 60);
    if (time_end_hour_1 < 10) {
        time_end_hour_1 = "0" + time_end_hour_1;
    }
    var time_end_min_1 = EnableReboot.RebootEndTime % 60;
    if (time_end_min_1 < 10) {
        time_end_min_1 = "0" + time_end_min_1;
    }

    setText('RunningDays', EnableReboot.RunningDays);
    setText('TrafficKeepTime', EnableReboot.TrafficKeepTime);
    setText('TrafficLimit', EnableReboot.TrafficLimit);
    setText('time_start_hour', time_start_hour_1);
    setText('time_start_min', time_start_min_1);
    setText('time_end_hour', time_end_hour_1);
    setText('time_end_min', time_end_min_1);
	
	if (EnableReboot.TrafficLimit == -1) {
		setCheck('immediateReboot', 1);
		setDisplay('TrafficKeepTimeRow', 0);
		setDisplay('TrafficLimitRow', 0);
	} else {
		setCheck('immediateReboot', 0);
		setDisplay('TrafficKeepTimeRow', 1);
		setDisplay('TrafficLimitRow', 1);
	}
}

function SubmitRebootConfig()
{
    var Form = new webSubmitForm();
    var EnableReboot = getCheckVal('EnableReboot');

    Form.addParameter('x.Enable', EnableReboot);
    Form.addParameter('x.DelayMode', "none");

    if ((setParameterTimeCheck(Form) == false) || (checkRunningdays(Form) == false)) {
        return false;
    }
	
    if (getCheckVal('immediateReboot') != 1) {
        if (checkTrafficLimit(Form) == false || checkTrafficKeepTime(Form) == false) {
            return false;
        }
    }

    if (getValue('RunningDays') == '') {
        Form.addParameter('x.RunningDays', "15");
    } else {
        Form.addParameter('x.RunningDays', getValue('RunningDays'));
    }
    if ((getValue('time_start_hour') == '') && (getValue('time_start_min') == '') && (getValue('time_end_hour') == '') && (getValue('time_end_min') == '')) {
        Form.addParameter('x.RebootStartTime', "120");
        Form.addParameter('x.RebootEndTime', "330");
    } else {
        Form.addParameter('x.RebootStartTime', (getValue('time_start_hour') * 60 + getValue('time_start_min') * 1));
        Form.addParameter('x.RebootEndTime', (getValue('time_end_hour') * 60 + getValue('time_end_min') * 1));
    }
    if (getValue('TrafficKeepTime') == '') {
        Form.addParameter('x.TrafficKeepTime', "30");
    } else {
        Form.addParameter('x.TrafficKeepTime',getValue('TrafficKeepTime'));
    }
	
	if (getCheckVal('immediateReboot') == 1) {
		Form.addParameter('x.TrafficLimit', -1);
	} else {
		if (getValue('TrafficLimit') == '') {
			Form.addParameter('x.TrafficLimit', "1000");
		} else {
			Form.addParameter('x.TrafficLimit', getValue('TrafficLimit'));
		}
	}

    Form.setAction('set.cgi?' 
                    + 'x=' + 'InternetGatewayDevice.X_HW_AutoReboot'
                    + '&RequestFile=html/ssmp/reboot/reboottriplet.asp');

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    setDisable('RebootbtnApply',1);
    setDisable('RebootcancelValue',1);

    Form.submit();
}

function checkRunningdays(From)
{
    var RunningDays = getValue('RunningDays');

    if (RunningDays == '') {
        RunningDays = 15;
    }

    if (!(isIntegerOrNull(RunningDays))) {
        AlertEx(Reboot['s1745']);
        return false;
    }

    if ((RunningDays > 365) || (RunningDays < 1)) {
        AlertEx(Reboot['s1745']);
        return false;
    }

    return true;
}

function checkTrafficLimit(From)
{
    var TrafficLimit = getValue('TrafficLimit');

    if (TrafficLimit == '') {
        TrafficLimit = 1000;
    }

    if (!(isIntegerOrNull(TrafficLimit))) {
        AlertEx(Reboot['s1751']);
        return false;
    }
	
	if (!(parseInt(TrafficLimit, 10) >= 1 && parseInt(TrafficLimit, 10) <= 5000)) {
		AlertEx(Reboot['s1751']);
		return false;
	}

    return true;
}

function checkTrafficKeepTime(From)
{
    var TrafficKeepTime = getValue('TrafficKeepTime');

    if (TrafficKeepTime == '') {
        TrafficKeepTime = 30;
    }

    if (!(isIntegerOrNull(TrafficKeepTime))) {
        AlertEx(Reboot['s1750']);
        return false;
    }
	
	if (!(parseInt(TrafficKeepTime, 10) >= 1 && parseInt(TrafficKeepTime, 10) <= 60)) {
		AlertEx(Reboot['s1750']);
		return false;
	}

    return true;
}

function isValidTimeDuration(startHour, startMin, endHour, endMin)
{
    if (parseInt(startHour,10) < parseInt(endHour,10)) {
        return true;
    } else if ((parseInt(startHour,10) == parseInt(endHour,10)) && (parseInt(startMin,10) < parseInt(endMin,10))) {
        return true;
    } else if (startHour == '' && startMin == '' && endHour == '' && endMin == '') {
        return true;
    } else {
        return false;
    }
}

function isIntegerOrNull(value)
{
    if (isPlusInteger(value) != true && value != '') {
        return false;
    }

    return true;
}

function isDecDigit(digit) 
{
   var decVals = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
   var len = decVals.length;
   var i = 0;
   var ret = false;

   for ( i = 0; i < len; i++ )
      if ( digit == decVals[i] ) break;

   if ( i < len )
      ret = true;
   return ret;
}

function isValidNumber(number)
{
    var numberLen = number.length;
    if (numberLen != 2 && numberLen != 1) {
        return false;
    }
    for (var i = 0 ; i < numberLen ; i++) {
        if (!isDecDigit(number.charAt(i))) {
            return false;
        }
    }
    return true;
}

function isValidHour(val)
{
    if ((isValidNumber(val) == true) && (parseInt(val, 10) < 24)) {
        return true;
    }
    return false;
}

function isValidMinute(val)
{
    if ((isValidNumber(val) == true) && (parseInt(val,10) < 60)) {
        return true;
    }
    return false;
}

function setParameterTimeCheck(Form)
{
    var time_start_hour = getValue('time_start_hour');
    var time_start_min = getValue('time_start_min');
    var time_end_hour = getValue('time_end_hour');
    var time_end_min = getValue('time_end_min');

    if (('-' == time_start_hour.charAt(0)) || ('-' == time_start_min.charAt(0)) 
        || ('-' == time_end_hour.charAt(0)) || ('-' == time_end_min.charAt(0))
        || ('+' == time_start_hour.charAt(0)) || ('+' == time_start_min.charAt(0)) 
        || ('+' == time_end_hour.charAt(0)) || ('+' == time_end_min.charAt(0))) {
        AlertEx(Reboot['s1741']);
        return false;
    }

    if (('' == time_start_hour) || ('' == time_start_min) || ('' == time_end_hour) || ('' == time_end_min)) {
        if (('' != time_start_hour) || ('' != time_start_min) || ('' != time_end_hour) || ('' != time_end_min)) {
            AlertEx(Reboot['s1742']);
            return false;
        }
    }
	
	if (( (('0' == time_start_hour)||('00' == time_start_hour)) && (('0' == time_start_min)||('00' == time_start_min)) && (('0' == time_end_hour)||('00' == time_end_hour)) && (('0' == time_end_min)||('00' == time_end_min)))) {
        AlertEx(Reboot['s1755']);
        return false;        
    }

    if (!(isIntegerOrNull(time_start_hour) && isIntegerOrNull(time_start_min) && isIntegerOrNull(time_end_hour) && isIntegerOrNull(time_end_min))) {
        AlertEx(Reboot['s1741']);
        return false;
    }

    if (('' == time_start_hour) && ('' == time_start_min) && ('' == time_end_hour) && ('' == time_end_min)) {
        time_start_hour = 2;
        time_start_min = 0;
        time_end_hour = 5;
        time_end_min = 30;
    }

    if ((time_start_hour > 23) ||(time_end_hour > 23)) {
        AlertEx(Reboot['s1737']);
        return false;
    }

    if ((time_start_min > 59) ||(time_end_min > 59)) {
        AlertEx(Reboot['s1738']);
        return false;
    }
	
	if ((time_start_hour * 60 + time_start_min * 1) == (time_end_hour * 60 + time_end_min * 1)) {
        if ((0 != (time_start_hour * 60 + time_start_min * 1)) || ( 0 != (time_end_hour * 60 + time_end_min * 1))) {
            AlertEx(Reboot['s1755']);
            return false;
        }
    }

    return true;
}

function InitRebootTableList() {
    LoadFrame();
}

function GetLanguageDesc(Name)
{
    return Reboot[Name];
}

function EnableImmediateReboot() {
	var enable = getCheckVal('immediateReboot');
	if (enable == 1) {
		setDisplay('TrafficKeepTimeRow', 0);
		setDisplay('TrafficLimitRow', 0);
	} else {
		setDisplay('TrafficKeepTimeRow', 1);
		setDisplay('TrafficLimitRow', 1);
		setText('TrafficLimit', 1000);
	}
}

function onClickReboot() {
	if (ConfirmEx(GetLanguageDesc('s1754'))) {
		setDisable('btnReboot', 1);
		
		var Form = new webSubmitForm();
		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard' + '&RequestFile=html/ssmp/reboot/reboottriplet.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
    <div class="title_spread"></div>
	<script>
		HWCreatePageHeadInfo("Reboot", GetDescFormArrayById(Reboot, "s1724"), GetDescFormArrayById(Reboot, "s1752"), false);
	</script>
	<div class="func_spread"></div>
	
	<div class="func_title" BindText="s1759"></div>
	<table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td> <input  class="ApplyButtoncss buttonwidth_150px" name="btnReboot" id="btnReboot" type='button' onClick='onClickReboot()' BindText="s1753"/>
	  </td> 
    </tr> 
    </table>
	
	<div class="func_spread"></div>

	<div class="func_title" BindText="s1760"></div>
    <form id="RebootConfigForm"  name="RebootConfigForm">
        <table id="rebootFormPanel" width="100%" cellspacing="1" cellpadding="0">
            <li id="EnableReboot" RealType="CheckBox" DescRef="s1721" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty" />');
            <li id="RunningDays" RealType="TextBox" DescRef="s1723" RemarkRef="s1727" ErrorMsgRef="Empty" Require="FALSE" BindField="x.RunningDays" InitValue="Empty"/>
			<li id="immediateReboot" RealType="CheckBox" DescRef="s1749" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.ImmediateReboot" InitValue="Empty" ClickFuncApp="onClick=EnableImmediateReboot"/>
            <li id="TrafficKeepTime" RealType="TextBox" DescRef="s1728" RemarkRef="s1761" ErrorMsgRef="Empty" Require="FALSE" BindField="x.TrafficKeepTime" InitValue="Empty"/>
			<li id="TrafficLimit" RealType="TextBox" DescRef="s1722" RemarkRef="s1762" ErrorMsgRef="Empty" Require="FALSE" BindField="x.TrafficLimit" InitValue="Empty" />');
		    <li id="time_start_hour" RealType="TextOtherBox" DescRef="s1756" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.RebootStartTime" Elementclass="InputTime"  MaxLength="2"  
		    InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'startColon'}]},
					{Type:'input',Item:[{AttrName:'id',AttrValue:'time_start_min'},{AttrName:'BindFileld', AttrValue:'Empty'},{AttrName:'MaxLength', AttrValue:'2'},{AttrName:'class', AttrValue:'InputTime'}]},
				    {Type:'span',Item:[{AttrName:'innerhtml', AttrValue:'s1733'},{AttrName:'class', AttrValue:'gray'}]}]"/>
		    <li id="time_end_hour" RealType="TextOtherBox" DescRef="s1757" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.EndTime" Elementclass="InputTime"  MaxLength="2"  
		    InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'endColon'}]},
					{Type:'input',Item:[{AttrName:'id',AttrValue:'time_end_min'},{AttrName:'BindFileld', AttrValue:'Empty'},{AttrName:'MaxLength', AttrValue:'2'},{AttrName:'class', AttrValue:'InputTime'}]},
				    {Type:'span',Item:[{AttrName:'innerhtml', AttrValue:'s1733'},{AttrName:'class', AttrValue:'gray'}]}]"/>
        </table>
        <script>
            RebootConfigFormList = HWGetLiIdListByForm("RebootConfigForm", null);
            var TableClass = new stTableClass("width_per30", "width_per70", "");
            var ReloadCusInfo = null;
            HWParsePageControlByID("RebootConfigForm", TableClass, Reboot, ReloadCusInfo);
			document.getElementById("startColon").innerHTML = '&nbsp;&nbsp;'+ Reboot['s1732'] + '&nbsp;&nbsp;';
			document.getElementById("endColon").innerHTML = '&nbsp;&nbsp;'+ Reboot['s1732'] + '&nbsp;&nbsp;';
        </script>
        <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
            <tr>
                <td class="width_per30"></td>
                <td class="table_submit">
                    <input type="button" id="RebootbtnApply" value="" BindText="s0d21" class="ApplyButtoncss  buttonwidth_100px" onclick="SubmitRebootConfig();" />
                    <input type="button" id="RebootcancelValue" value="" BindText="s0d22" class="CancleButtonCss buttonwidth_100px" onclick="InitRebootTableList();" />
					<input type="hidden" name="onttoken" id="hwonttoken"   value="<%HW_WEB_GetToken();%>" />
                </td>
            </tr>
        </table>
    </form>
    <script>
		setDisplay("func_title",1);
		setDisplay("RebootConfigForm",1); 
	</script>
    
    <div class="func_spread"></div>
    <div class="func_spread"></div>
    <script>
        ParseBindTextByTagName(Reboot, "div",   1);
        ParseBindTextByTagName(Reboot, "td",    1);
        ParseBindTextByTagName(Reboot, "input", 2);
    </script>
<br>
</body>
</html>