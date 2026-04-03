<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>

<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, IT_VDF_wlan_schedule_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>Schedule</title>
<script language="JavaScript" type="text/javascript">

function stDuration(domain, StartTime, EndTime, RepeatDay)
{
    this.domain = domain;
    this.StartTime = StartTime;
    this.EndTime = EndTime;
    this.RepeatDay = RepeatDay;
}

var isAddSchedule = -1;
var editDurationIndex = -1;

var DurationArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.{i}, StartTime|EndTime|RepeatDay, stDuration);%>;

for (var i = 0; i <  DurationArr.length; i++)
{
	if(null == DurationArr[i])
	{
		DurationArr.splice(i,1);
	}
}

var OldDurationArr = new Array(null, null, null, null);
for (var i = 0; i < 4; i++)
{
	OldDurationArr[i] = DurationArr[i];
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

function getAddDomainIndex()
{
	for(var i = 0; i < 4 ; i++)
	{
		if ('' == DurationArr[i].StartTime && '' == DurationArr[i].EndTime)
		{
			return i;
		}
	}
}

var dayArray = {
				'1' : IT_VDF_wlan_schedule_language['amp_schedule_day_mon'], 
	            '2' : IT_VDF_wlan_schedule_language['amp_schedule_day_tues'], 
				'3' : IT_VDF_wlan_schedule_language['amp_schedule_day_wed'], 
				'4' : IT_VDF_wlan_schedule_language['amp_schedule_day_thur'], 
				'5' : IT_VDF_wlan_schedule_language['amp_schedule_day_fri'], 
				'6' : IT_VDF_wlan_schedule_language['amp_schedule_day_sat'], 
				'7' : IT_VDF_wlan_schedule_language['amp_schedule_day_sun']
			   };

var selDaysValArr = { 'individual' : IT_VDF_wlan_schedule_language['amp_schedule_time_individual'], 
					  'everyDay' : IT_VDF_wlan_schedule_language['amp_schedule_time_every_day'], 
					  'everyWorkday' : IT_VDF_wlan_schedule_language['amp_schedule_time_workday'], 
					  'everyWeekend' : IT_VDF_wlan_schedule_language['amp_schedule_time_weekend']
					};	
					
var selDaysVal;
function setSelShow(obj)
{
	var text = obj.innerHTML;
	var dropdownShowId =  obj.offsetParent.firstChild.id;
	
	$('#'+dropdownShowId).html(text);
	SetClickFlag(false);
	$('#'+dropdownShowId).css("background-image","url('../../../images/arrow-down.png')");
}

function selectDaysSelValue(obj)
{
	setSelShow(obj);
	selDaysVal = obj.getAttribute('dataValue');
	setIndividualDays();
}

function setSelectDaysSel()
{
	var selDaysArr = new Array();
	for (var key in selDaysValArr)
	{
		selDaysArr.push([selDaysValArr[key],key]);
	}
	
	var DefaultValue = selDaysArr[0];
	createWlanDropdown("selectDays", DefaultValue, "220px", selDaysArr, "selectDaysSelValue(this);");
}
			   
function GetDurationIndex(DurationDomain)
{
    var textIndex = '';
    var index = 0;
    index = DurationDomain.indexOf('.Duration.', 0);
    index += '.Duration.'.length;
    return DurationDomain.substr(index, index+1) ;
}

function setRepeatDay(repeatDay)
{
	var repeatDayArray = repeatDay.split(',');
	var repeatDayLan = '';
	for (var i = 0; i < repeatDayArray.length; i++)
	{
		repeatDayLan += dayArray[repeatDayArray[i]] + ',';
	}
	
	
	return repeatDayLan.substr(0, repeatDayLan.length - 1);
}

function LoadTable()
{
	var trSchedule = getElementById('tbSchedule');
	var divHtml = '';
	var trHeadHtml = '<tr>';
	var trFootHtml = '<\/tr>';
	var tdHeadHtml = '<td><span>';
	var tdFootHtml = '<\/span><\/td>';
	var editHeadHtml = '<td class="tL"><input class="button-edit" type="button" value="" onclick="EditSchedule(';
	var editFootHtml = ')"><\/td>';
	var delHeadHtml = '<td class="tL" style="text-align:right"><input class="button-delete" type="button" value="" onclick="DelSchedule(';
	var delFootHtml = ')"><\/td>';
	
	var repeatDay;
	var startTime;
	var endTime;
	var count = 0;
	
	for (var i = 0; i <  DurationArr.length; i++)
	{
		if ('' == DurationArr[i].StartTime && '' == DurationArr[i].EndTime)
		{
			continue;
		}
		
		repeatDay = DurationArr[i].RepeatDay;
		repeatDayLan = setRepeatDay(repeatDay);
		startTime = DurationArr[i].StartTime;
		endTime = DurationArr[i].EndTime;

		divHtml += trHeadHtml;
		divHtml += tdHeadHtml + repeatDayLan + '&nbsp;&nbsp' + tdFootHtml;
		divHtml += tdHeadHtml + IT_VDF_wlan_schedule_language['amp_schedule_time_from'] + '&nbsp;&nbsp';
		divHtml += startTime + '&nbsp;&nbsp' + IT_VDF_wlan_schedule_language['amp_schedule_time_to'];
		divHtml += '&nbsp;&nbsp' + endTime + '&nbsp;&nbsp' + tdFootHtml;
		divHtml += editHeadHtml + i + editFootHtml;
		divHtml += delHeadHtml + i + delFootHtml;
		divHtml += trFootHtml;
		count ++;
	}
	
	if (0 == count)
	{
		divHtml += '<tr> <td colspan="2" style="text-align:center"><div style="font-style:italic"><span>';
		divHtml += IT_VDF_wlan_schedule_language['amp_wlan_schedule_empty'] + '</span>' + '<\/div><\/td><\/tr>'; 
	}	
	
	divHtml += '<tr class="addCont"><td>&nbsp;<\/td><td>&nbsp;<\/td><td>&nbsp;<\/td>';
	divHtml += '<td style="float:right;">';
	if (count < 4)
	{
		divHtml += '<input class="button-add" id="addSchedule" type="button" value="" onclick = "AddSchedule()">';
	}
	
	divHtml += '<\/td><\/tr>';			
							
	$(trSchedule).html('');
	$(trSchedule).html(divHtml);
}
	
function LoadBindText()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (IT_VDF_wlan_schedule_language[b.getAttribute("BindText")]) 
        {
            b.innerHTML = IT_VDF_wlan_schedule_language[b.getAttribute("BindText")];
        }
    }
}

function LoadBtnBindText()
{
    var all = document.getElementsByTagName("input");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (IT_VDF_wlan_schedule_language[b.getAttribute("BindText")]) 
        {
            b.value = IT_VDF_wlan_schedule_language[b.getAttribute("BindText")];
        }
    }
}

function setAddDivDefault()
{
	setDropdownSelVal('selectDays', selDaysValArr['individual']);	
	selDaysVal = 'individual';
	setCheck('add_day1',0);
	setCheck('add_day2',0);
	setCheck('add_day3',0);
	setCheck('add_day4',0);
	setCheck('add_day5',0);
	setCheck('add_day6',0);
	setCheck('add_day7',0);
	
	getElementById('time_start1_hour').value = '';
	getElementById('time_start1_min').value = '';
	getElementById('time_end1_hour').value = '';
	getElementById('time_end1_min').value = '';
	getElementById('spanAddTitle').innerHTML = IT_VDF_wlan_schedule_language['amp_schedule_add_title'];
}

function setBtnDisable(disable)
{
	if (1 == disable)
	{
		getElementById('wlanScheEnable').onclick = "";
	}
	else
	{
		getElementById('wlanScheEnable').onclick = wlanScheSetEnable;
	}
	
	setDisable('applyButton',disable);
	setDisable('cancelButton',disable);
}

function AddSchedule()
{
	isAddSchedule = 1;
	setAddDivDefault();
	setIndividualDays();
	
	var h1 = $("#divButton").height();
    var h2 = $("#DivAddSchedule").height(); 
	
    $("body").height(h2+h1+120);

	$("#DivAddSchedule").fadeIn(500);
	setBtnDisable(1);
}

function wlanTimeSplit(InstId, strTimeStart, strTimeEnd)
{
    var InputStart_Hour = 'time_start' + InstId + '_hour';
    var InputStart_Min = 'time_start' + InstId + '_min';
    var InputEnd_Hour = 'time_end' + InstId + '_hour';
    var InputEnd_Min = 'time_end' + InstId + '_min';        
    
    var i = strTimeStart.indexOf(':', 0);
    if (0 != i)
    {
        setText(InputStart_Hour, strTimeStart.substr(0, i));
        setText(InputStart_Min, strTimeStart.substr(i + 1));
    }

    i = strTimeEnd.indexOf(':', 0);
    if (0 != i)
    {
        setText(InputEnd_Hour, strTimeEnd.substr(0, i));
        setText(InputEnd_Min, strTimeEnd.substr(i + 1));
    }
}

function wlanRepeatSplit(strValue)
{
    var i = 0;
	
    if ('' == strValue)
    {
        return;
    }

    for (i = 1; i <= 7; i++)
    {
        var CheckID = 'add_day' + + i;
        setCheck(CheckID, 0);
    }

    for (i = 0; i < strValue.length; i = i + 2)
    {
        var CheckID = 'add_day' + + strValue.charAt(i);
        setCheck(CheckID, 1);
    }
}

function setEditDivDefault(durationIndex)
{
	setDropdownSelVal('selectDays', selDaysValArr['individual']);	
	selDaysVal = 'individual';
	
	wlanTimeSplit(1, DurationArr[durationIndex].StartTime, DurationArr[durationIndex].EndTime);
    wlanRepeatSplit(DurationArr[durationIndex].RepeatDay);
	getElementById('spanAddTitle').innerHTML = IT_VDF_wlan_schedule_language['amp_schedule_edit_title'];
}

function EditSchedule(durationIndex)
{
	isAddSchedule = 0;
	editDurationIndex = durationIndex;
	setEditDivDefault(durationIndex);
	setIndividualDays();
	
	var h1 = $("#divButton").height();
    var h2 = $("#DivAddSchedule").height(); 
	
    $("body").height(h2+h1+120); 
	
	$("#DivAddSchedule").fadeIn(500);
	setBtnDisable(1);
}

function DelSchedule(durationIndex)
{
	DurationArr[durationIndex] = new stDuration("InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration."+(durationIndex + 1), "", "", "1,2,3,4,5,6,7");
	LoadTable();
}

function setIndividualDays()
{
	var seletDay = selDaysVal;
	if ('individual' == seletDay)
	{
		getElementById('individualDays').style.display = '';
	}
	else 
	{
		getElementById('individualDays').style.display = 'none';
		
		if ('everyDay' == seletDay)
		{
			wlanRepeatSplit('1,2,3,4,5,6,7');
		}
		else if ('everyWorkday' == seletDay)
		{
			wlanRepeatSplit('1,2,3,4,5');
		}
		else if ('everyWeekend' == seletDay)
		{
			wlanRepeatSplit('6,7');
		}
	}
}

function SetImgValue(Buttonid, ButtonValue)
{
	var Btnelement = getElementById(Buttonid);
	if(null == Btnelement)
	{
		return;
	}

	if(1 == ButtonValue)
	{
		Btnelement.src="../../../images/checkon.gif";
		Btnelement.value = 1;
	}
	else
	{
		Btnelement.src="../../../images/checkoff.gif";
		Btnelement.value = 0;
	}	
}

function changeImg(element)
{
	if (element.src.match("checkon"))
	{
		element.src="../../../images/checkoff.gif";
		element.value = 0;
	}
	else
	{
		element.src="../../../images/checkon.gif";
		element.value = 1;
	}
}

function wlanScheSetEnable()
{
	var wlanScheEnable = getElementById('wlanScheEnable');
	changeImg(wlanScheEnable);
	
	var Form = new webSubmitForm();
    var enable = wlanScheEnable.value;

    setDisplay('DivSchedule',enable);
    setDisplay('DivApply',enable);

    Form.addParameter('x.Enable',enable);
    
	Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl'
                    + '&RequestFile=html/amp/wifische/itvdfWlanSchedule.asp');
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

function setParameterTimeCheck(Form)
{
    var time1_begin_h = getValue('time_start1_hour');
    var time1_begin_m = getValue('time_start1_min');
    var time1_end_h = getValue('time_end1_hour');
    var time1_end_m = getValue('time_end1_min');
         

    if (('-' == time1_begin_h.charAt(0)) || ('-' == time1_begin_m.charAt(0)) 
		|| ('-' == time1_end_h.charAt(0)) || ('-' == time1_end_m.charAt(0))
        || ('+' == time1_begin_h.charAt(0)) || ('+' == time1_begin_m.charAt(0))
        || ('+' == time1_end_h.charAt(0)) || ('+' == time1_end_m.charAt(0)))
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_type_invalid']);
        return false;
    }        

    if (('' == time1_begin_h) || ('' == time1_begin_m) || ('' == time1_end_h) || ('' == time1_end_m))
    {
            AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_time_empty']);
            return false;
    }

    if ((('0' == time1_begin_h)||('00' == time1_begin_h)) 
		&& (('0' == time1_begin_m)||('00' == time1_begin_m)) 
		&& (('0' == time1_end_h)||('00' == time1_end_h)) 
		&& (('0' == time1_end_m)||('00' == time1_end_m)))
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_time_error']);
        return false;        
    }

    if (!(isIntegerOrNull(time1_begin_h) 
        && isIntegerOrNull(time1_begin_m) 
        && isIntegerOrNull(time1_end_h) 
        && isIntegerOrNull(time1_end_m)))
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_type_invalid']);
        return false;
    }

    if (('' == time1_begin_h) && ('' == time1_begin_m) && ('' == time1_end_h) && ('' == time1_end_m))
    {
        time1_begin_h = 0;
        time1_begin_m = 0;
        time1_end_h = 0;
        time1_end_m = 0;
    }

    if ((time1_begin_h > 23) || (time1_end_h > 23))
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_hour_invalid']);
        return false;
    }

    if ((time1_begin_m > 59) || (time1_end_m > 59))
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_min_invalid']);
        return false;
    }

    if ((time1_begin_h * 60 + time1_begin_m * 1) == (time1_end_h * 60 + time1_end_m * 1))
    {
        if ((0 != (time1_begin_h * 60 + time1_begin_m * 1)) || ( 0 != (time1_end_h * 60 + time1_end_m * 1)))
        {
            AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_time_error']);
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

function scheduleSave()
{
	if (setParameterTimeCheck() == false)
    {
        return false;
    }
	
	var time1_start = getValue('time_start1_hour') + ':' + getValue('time_start1_min');
	var time1_end = getValue('time_end1_hour') + ':' + getValue('time_end1_min');
	var time1_repeat = repeatdayformat('add_day1') + repeatdayformat('add_day2') + repeatdayformat('add_day3') + repeatdayformat('add_day4') 
                 + repeatdayformat('add_day5') + repeatdayformat('add_day6') + repeatdayformat('add_day7');
	
    
	time1_repeat = droplastsplitRepeatDay(time1_repeat);
	
	if ('' == time1_repeat)
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_week_empty']);
        return false;
    }
	
	time1_start = droplastsplitTime(time1_start);
    time1_end = droplastsplitTime(time1_end);
	
	var domianIndex = editDurationIndex;
	if(1 == isAddSchedule)
	{
		domianIndex = getAddDomainIndex();
	}

	var duration = new stDuration("InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration."+(domianIndex+1),time1_start, time1_end, time1_repeat);
    DurationArr[domianIndex] = duration;

	getElementById('DivAddSchedule').style.display = 'none';
	setBtnDisable(0);
	
	LoadTable();
}

function scheduleCancel()
{
	getElementById('DivAddSchedule').style.display = 'none';
	setBtnDisable(0);
}

function LoadFrame()
{
	LoadBindText();
	LoadBtnBindText();
	var wlanSchecuelEnable = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Enable);%>;
    SetImgValue('wlanScheEnable', wlanSchecuelEnable);
	setDisplay('DivSchedule', wlanSchecuelEnable);
    setDisplay('DivApply', wlanSchecuelEnable);
	ModifyDurtionArr();
	LoadTable();
	getElementById('divButton').style.display = '';
	setDisplay('content', 1);
}

function Apply()
{
    var Form = new webSubmitForm();
    var enable = getCheckVal('wlanScheEnable');
    var time1_start = DurationArr[0].StartTime;
    var time1_end = DurationArr[0].EndTime;
    var time1_repeat = DurationArr[0].RepeatDay;
	
	var time2_start = DurationArr[1].StartTime;
    var time2_end = DurationArr[1].EndTime;
    var time2_repeat = DurationArr[1].RepeatDay;
	
	var time3_start = DurationArr[2].StartTime;
    var time3_end = DurationArr[2].EndTime;
    var time3_repeat = DurationArr[2].RepeatDay;
	
	var time4_start = DurationArr[3].StartTime;
    var time4_end = DurationArr[3].EndTime;
    var time4_repeat = DurationArr[3].RepeatDay;
    
    if (('' == time1_repeat) || ('' == time2_repeat) || ('' == time3_repeat) || ('' == time4_repeat))
    {
        AlertEx(IT_VDF_wlan_schedule_language['amp_wlan_schedule_week_empty']);
        return false;
    }
    
    Form.addParameter('x.StartTime',time1_start);
    Form.addParameter('x.EndTime',time1_end);
    Form.addParameter('x.RepeatDay',time1_repeat);
    
    Form.addParameter('y.StartTime',time2_start);
    Form.addParameter('y.EndTime',time2_end);
    Form.addParameter('y.RepeatDay',time2_repeat);
    
    Form.addParameter('z.StartTime',time3_start);
    Form.addParameter('z.EndTime',time3_end);
    Form.addParameter('z.RepeatDay',time3_repeat);
    
    Form.addParameter('w.StartTime',time4_start);
    Form.addParameter('w.EndTime',time4_end);
    Form.addParameter('w.RepeatDay',time4_repeat);

    Form.setAction('set.cgi?' 
                    + 'x=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.1'
                    + '&y=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.2'
                    + '&z=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.3'
                    + '&w=' + 'InternetGatewayDevice.LANDevice.1.X_HW_WLANShutDownCtrl.Duration.4'
                    + '&RequestFile=html/amp/wifische/itvdfWlanSchedule.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function Cancel()
{
	for (var i = 0; i < 4; i++)
	{
		DurationArr[i] = OldDurationArr[i];
	}
	
	LoadFrame();
}

</script>

<style type="text/css">
.no-text-align {
	text-align: left !important;
}

.btn-apply-color {
	background-color: #b141ad !important;
}

.row .left{
  float: none;
}

#DivAddSchedule {
width:100%;
margin:0px auto;
background-color:#f0f0f2;
}

.img_btn img{
width:60px;
height:30px;
}

[type="checkbox"]:not(:checked),
[type="checkbox"]:checked {
  left: -9999px;
  position: absolute;
}

.button-add{
	margin:0px;
}
</style>
</head>
<body onLoad="LoadFrame();">
	<div>
		<div id="content" class="content-schedule" style="display:none">
			<h1 style="font-family:'Arial';">
				<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_title']);</script></span>
			</h1>
			<h2>
				<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_explain']);</script></span>
			</h2>
			<div id="divButton" class="h3-content " style="display:none">
				<div class="row">
					<div class="left">
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_function']);</script></span>    
					</div>
					<div class="right img_btn">
						<img id="wlanScheEnable" onclick="wlanScheSetEnable();"/>
						</div>
					</div>
				</div>
			</div>

		<div id="DivAddSchedule" style="display:none; position:absolute; padding : 10px 15px 15px;">
			<p class="title">
				<span id="spanAddTitle"><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_add_title']);</script></span>  
			</p>
			<div class="row">
				<div class="left space-right" style="width: 62%;">
					<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_time_frame']);</script></span>    
				</div>
				<div class="right" style="width: 230px; position: relative; height:50px;">
					<div class="iframeDropLog">
					<div id="selectDays" class="IframeDropdown" style="left: 8%;top: 5px; z-index: 9;">
						<script>
							setSelectDaysSel();
						</script>
					</div>
					</div>
				</div>
			</div>
			
			<div style="width: 100%;"></div>
			<div id="individualDays" style = "display: none;">
				<div class="row">
					<div class="left space-right" style="width: 65%;">
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_individual']);</script></span>      
					</div>
					<div class="right no-text-align">
						<input id="add_day1" type="checkbox" value="1">
						<label for="add_day1"></label>
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_Mon']);</script></span>      
					</div>
					<div class="right no-text-align">
						<input id="add_day6" type="checkbox" value="6">
						<label for="add_day6"></label>
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_sat']);</script></span>      
					</div>
				</div>
				<div class="row">
					<div class="left">
					</div>
					<div class="right no-text-align">
						<input id="add_day2"  type="checkbox" value="2">
						<label for="add_day2"></label>
						<span ><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_tues']);</script></span>      
					</div>
					<div class="right no-text-align">
						<input id="add_day7"  type="checkbox" value="7">
						<label for="add_day7"></label>
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_sun']);</script></span>      
					</div>
				</div>
				<div class="row">
					<div class="left">
					</div>
					<div class="right no-text-align">
						<input id="add_day3" type="checkbox"  value="3">
						<label for="add_day3"></label>
						<span ><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_wed']);</script></span>      
					</div>
					<div class="right no-text-align">
					</div>
				</div>
				<div class="row">
					<div class="left">
					</div>
					<div class="right no-text-align">
						<input id="add_day4" type="checkbox" value="4">
						<label for="add_day4"></label>
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_thur']);</script></span>      
					</div>
					<div class="right no-text-align">
					</div>
				</div>
				<div class="row">
					<div class="left">
					</div>
					<div class="right no-text-align">
						<input id="add_day5" type="checkbox" value="5">
						<label for="add_day5"></label>
						<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_select_fri']);</script></span>      
					</div>
					<div class="right no-text-align">
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="left space-right" style="width: 57%;">
					<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_time']);</script></span>    
				</div>
				<div class="right">
					<table>
						<tr>
							<td>
								<script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_time_from'])</script>
								<input type='text' id="time_start1_hour" name="time_start1_hour" style="width: 50px" maxlength="2">
								<script>document.write(IT_VDF_wlan_schedule_language['amp_wlan_schedule_time_separator']);</script>
								<input type='text' id="time_start1_min" name="time_start1_min" style="width: 50px" maxlength="2">
							</td>
							<td>
								<script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_time_to'])</script>
								<input type='text' id="time_end1_hour" name="time_end1_hour" style="width: 50px" maxlength="2">
								<script>document.write(IT_VDF_wlan_schedule_language['amp_wlan_schedule_time_separator']);</script>
								<input type='text' id="time_end1_min" name="time_end1_min" style="width: 50px" maxlength="2">
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class=" apply-cancel">
				<input id="addCancelButton" class="button button-cancel " BindText="amp_btn_cancel" type="button" onclick='scheduleCancel()'>
				<input id="addSaveButton" class="button button-apply btn-apply-color" BindText="amp_btn_Save" type="button" onclick='scheduleSave()'>
			</div>
		</div>
	
			<div id='DivSchedule' class="scheduleOnOff shadowProblem">
				<h3>
					<span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_title']);</script></span>
				</h3>
			
				<div class="h3-content">
					<table class="table-three-columns schedule-off" id="schedule-table">
						<thead>
							<tr>
								<th style="width: 123px;"><span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_day']);</script></span></th>
								<th style="width: 132px;"><span><script>document.write(IT_VDF_wlan_schedule_language['amp_schedule_time']);</script></span></th>
								<th style="width: 40px;">&nbsp;</th>
								<th style="width: 50px;">&nbsp;</th>
							</tr>
						</thead>
						<tbody id="tbSchedule">
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="blackBackground" style="display: none;">
				&nbsp;
			</div>
		
			<div id='DivApply' class="clearfix apply-cancel">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<input id="cancelButton" class="button button-cancel " BindText="amp_btn_cancel" type="button" onclick="Cancel()">
				<input id="applyButton" class="button button-apply btn-apply-color" BindText="amp_btn_apply" type="button" onclick="Apply()">
			</div>
		</div>
	</div>
</body>
</html>
