var g_months = new Array(time_language['bbsp_January'], time_language['bbsp_February'], time_language['bbsp_March'],
    time_language['bbsp_April'], time_language['bbsp_May'], time_language['bbsp_June'], time_language['bbsp_July'],
    time_language['bbsp_August'], time_language['bbsp_September'], time_language['bbsp_October'],
    time_language['bbsp_November'], time_language['bbsp_December']);
var g_weekDay = new Array(time_language['bbsp_Sunday'], time_language['bbsp_Monday'], time_language['bbsp_Tuesday'],
    time_language['bbsp_Wednesday'], time_language['bbsp_Thursday'], time_language['bbsp_Friday'],
    time_language['bbsp_Saturday']);
var g_today = time_language['bbsp_Today'];
var g_year = time_language['bbsp_Year'];
var g_month=time_language['bbsp_Month'];
var g_day = time_language['bbsp_Day'];
var g_splitChar = "-";
var g_startYear = 2000;
var g_endYear = 2050;
var g_dayTdHeight = 12;
var g_dayTdTextSize = 12;
var g_notCurMonth = "#E0E0E0";
var g_restDay = "#FF0000";
var g_workDay = "#444444";
var g_mouseOver = "#79D0FF";
var g_mouseOut = "#F4F4F4";
var g_styleToday = "#444444";
var g_todayMouseOver = "#6699FF";
var g_todayMouseOut = "#79D0FF";
var g_dCtrl = new Object();
var g_selectTag = new Array();
var g_curDate = new Date();
var g_curYear = g_curDate.getFullYear();
var g_curMonth = g_curDate.getMonth() + 1;
var g_curDay = g_curDate.getDate();
function $(){
	var elesArry=new Array();
	for(var i=0;i<arguments.length;i++) {
		var ele=arguments[i];
		if(typeof(arguments[i])=='string') {
			ele=document.getElementById(arguments[i]);
		}
		if(arguments.length==1) {
			return ele;
		}
		elesArry.Push(ele);
	}
	return elesArry;
}
String.prototype.HexToDec = function() {
  return parseInt(this, 16);
}
Array.prototype.Push = function() {
    var startLen = this.length;
    for (var i = 0; i < arguments.length; i++) {
        this[startLen + i] = arguments[i];
    }
    return this.length;
}
String.prototype.cleanBlank=function() {
    if (this.isEmpty()) {
        return "";
    }
    return this.replace(/\s/g, "");
}
function checkColor()
{
    var color_tmp = (arguments[0] + "").replace(/\s/g,"").toUpperCase();
    var model_tmp1 = arguments[1].toUpperCase();
    var model_tmp2 = "rgb(" + arguments[1].substring(1, 3).HexToDec() + "," + arguments[1].substring(1, 3).HexToDec() +
        "," + arguments[1].substring(5).HexToDec() + ")";
    model_tmp2 = model_tmp2.toUpperCase();
    if ((color_tmp == model_tmp1) || (color_tmp == model_tmp2)) {
        return true;
    }
    return false;
}
function $V()
{
    return document.getElementById(arguments[0]).value;
}
function fPopCalendar(evt, popCtrl, dateCtrl, offsetX)
{
    evt.cancelBubble = true;
    g_dCtrl = dateCtrl;
    SetYearMon(g_curYear, g_curMonth);
    var point = fGetXY(popCtrl);
    with(document.getElementById("calendardiv").style)
    {
        if (document.all) {
            left = (point.x - offsetX + 1) + "px";
            top = (point.y+popCtrl.offsetHeight + 1) + "px";
        } else {
            left = (point.x - offsetX + 1) + "px";
            top = (point.y+popCtrl.offsetHeight + 1) + "px";
        }
        visibility = 'visible';
        zindex = '99';
        position = 'absolute';
    }
    document.getElementById("calendardiv").focus();
}
function SetDate(year, month, day)
{
    var newMonth = new String(month);
    var newDay = new String(day);
    if (newMonth.length < 2) {
        newMonth = "0" + newMonth;
    }
    if (newDay.length < 2) {
        newDay = "0" + newDay;
    }
    g_dCtrl.value = year + g_splitChar + newMonth + g_splitChar + newDay;
    fHideCalendar();
}
function fHideCalendar()
{
    document.getElementById("calendardiv").style.visibility = "hidden";
    for (var i = 0; i < g_selectTag.length; i++) {
        g_selectTag[i].style.visibility = "visible";
    }
    g_selectTag.length = 0;
}
function SetSelected()
{
    var offset = 0;
    var year = parseInt(document.getElementById("tbSelYear").value);
    var months = parseInt(document.getElementById("tbSelMonth").value);
    var cell = document.getElementById("cellText" + arguments[0]);
    cell.bgColor = g_mouseOut;
    with(cell)
    {
        var day = parseInt(innerHTML);
        if (checkColor(style.color, g_notCurMonth)) {
            offset = (innerHTML > 16) ? -1 : 1;
        }
        months += offset;
        if (months < 1) {
            months = 12;
            year--;
        } else if (months > 12) {
            months = 1;
            year++;
        }
    }
    SetDate(year, months, day);
}
function Point(x, y)
{
    this.x = x;
    this.y = y;
}
function BuildCal(year, month)
{
    var arrMonth = new Array();
    for (var i = 1; i < 7; i++) {
        arrMonth[i] = new Array(i);
    }
    var calDate = new Date(year, month - 1, 1);
    var dayOfFirst = calDate.getDay();
    var daysInMonth = new Date(year, month, 0).getDate();
    var offsetLast = new Date(year, month - 1, 0).getDate() - dayOfFirst + 1;
    var date = 1;
    var next = 1;
    for (var j = 0; j < 7; j++) {
        arrMonth[1][j] = (j < dayOfFirst) ? (offsetLast + j) * (-1) : date++;
    }
    for (var k = 2; k < 7; k++) {
        for (var m = 0; m < 7; m++) {
            arrMonth[k][m] = (date <= daysInMonth) ? date++ : (next++) * (-1);
        }
    }
    return arrMonth;
}
function DrawCal(year, month, iCellHeight, iDateTextSize)
{
    var colorAttr = " bgcolor='";
    var styleAttr = " valign='middle' align='center' style='height:" + iCellHeight + "px;font-weight:bolder;font-size:" + iDateTextSize + "px;";
    var dateCalendar = "<tr>";
    for (var i = 0; i < 7; i++) {
        dateCalendar += "<td bgcolor='" + g_mouseOut + "' bordercolor='" + g_mouseOut + "'" + styleAttr + "color:#990099'>" + g_weekDay[i] + "</td>";
    }
    dateCalendar += "</tr>";
    for (var j = 1; j < 7; j++) {
        dateCalendar += "<tr>";
        for (var k = 0; k < 7; k++) {
            var tmpid = j + "" + k;
            dateCalendar += "<td" + styleAttr + "cursor:pointer;' onclick='SetSelected(" + tmpid + ")'> <span id='cellText" +
                tmpid + "'></span> </td>";
        }
        dateCalendar += "</tr>";
    }
    return dateCalendar;
}
function UpdateCal(year, month)
{
    var myMonth = BuildCal(year, month);
    for (var i = 1; i < 7; i++) {
        for (var j = 0; j < 7; j++) {
            with(document.getElementById("cellText" + i + "" + j))
            {
                parentNode.bgColor = g_mouseOut;
                parentNode.borderColor = g_mouseOut;
                parentNode.onmouseover = function()
                {
                    this.bgColor = g_mouseOver;
                };
                parentNode.onmouseout = function()
                {
                    this.bgColor = g_mouseOut;
                };
                if (myMonth[i][j] < 0) {
                    style.color = g_notCurMonth;
                    innerHTML = Math.abs(myMonth[i][j]);
                } else {
                    style.color = ((j == 0) || (j == 6)) ? g_restDay : g_workDay;
                    innerHTML = myMonth[i][j];
                    if ((year==g_curYear) && (month == g_curMonth) && (myMonth[i][j]==g_curDay)) {
                        style.color = g_styleToday;
                        parentNode.bgColor = g_todayMouseOut;
                        parentNode.onmouseover = function()
                        {
                            this.bgColor = g_todayMouseOver;
                        };
                        parentNode.onmouseout = function()
                        {
                            this.bgColor = g_todayMouseOut;
                        };
                    }
                }
            }
        }
    }
}

function SetYearMon(year, iMon)
{
    document.getElementById("tbSelMonth").options[iMon - 1].selected = true;
    for (var i = 0; i < document.getElementById("tbSelYear").length; i++) {
        if (document.getElementById("tbSelYear").options[i].value == year) {
            document.getElementById("tbSelYear").options[i].selected = true;
        }
    }
    UpdateCal(year, iMon);
}
function PrevMonth()
{
    var iMon = document.getElementById("tbSelMonth").value;
    var year = document.getElementById("tbSelYear").value;
    if ((--iMon) < 1) {
        iMon=12;
        year--;
    }
    SetYearMon(year, iMon);
}
function fNextMonth()
{
    var iMon = document.getElementById("tbSelMonth").value;
    var year = document.getElementById("tbSelYear").value;
    if ((++iMon) > 12) {
        iMon=1;
        year++;
    }
    SetYearMon(year,iMon);
}
function fGetXY(aTag)
{
    var tmp = aTag;
    var pt = new Point(0, 0);
    do {
        pt.x += tmp.offsetLeft;
        pt.y += tmp.offsetTop;
        tmp = tmp.offsetParent;
    } while (tmp.tagName.toUpperCase() != "BODY");
    return pt;
}
function getDateDiv()
{
    var dateDiv = "<div id='calendardiv' onclick='event.cancelBubble=true' ";
    if (document.all) {
        dateDiv += "onselectstart='return false;' style='";
    } else {
        dateDiv += " style='-moz-user-select:none;";
    }

    dateDiv += "position:absolute;z-index:99;visibility:hidden;border:1px solid #999999;'>";
    dateDiv += "<table border='0' bgcolor='#E0E0E0' cellpadding='1' cellspacing='1' ><tr>";
    dateDiv +=
        "<td><input type='button' id='PrevMonth' value='<' style='height:22px;width:20px;font-weight:bolder;padding-left: 2px;padding-top: 0px;' onclick='PrevMonth()'>";
    dateDiv += "</td><td><select id='tbSelYear' style='border:1px solid;' onchange='UpdateCal($V(\"tbSelYear\"),$V(\"tbSelMonth\"))'>";
    for (var i = g_startYear; i < g_endYear; i++) {
        dateDiv += "<option value='" + i + "'>" + i + "</option>";
    }

    dateDiv +=
        "</select></td><td><select id='tbSelMonth' style='border:1px solid;' onchange='UpdateCal($V(\"tbSelYear\"),$V(\"tbSelMonth\"))'>";
    for (var i = 0; i < 12; i++) {
        dateDiv += "<option value='" + (i + 1) + "'>" + g_months[i] + "</option>";
    }
    dateDiv +=
        "</select></td><td><input type='button' id='NextMonth' value='>' style='height:22px;width:20px;font-weight:bolder;padding-left: 2px;padding-top: 0px;' onclick='fNextMonth()'>";
    dateDiv += "</td></tr><tr><td align='center' colspan='4'>";
    dateDiv += "<div style='background-color:#cccccc'><table width='100%' border='0' cellpadding='3' cellspacing='1'>";
    dateDiv += DrawCal(g_curYear, g_curMonth, g_dayTdHeight, g_dayTdTextSize);
    dateDiv += "</table></div></td></tr><tr><td align='center' colspan='4' nowrap>";

    if (top.curLanguage == "chinese") {
        dateDiv += "<span style='cursor:pointer;font-weight:bolder;' onclick='SetDate(g_curYear,g_curMonth,g_curDay)' onmouseover='this.style.color=\"" +
            g_mouseOver + "\"' onmouseout='this.style.color=\"#000000\"'>" + g_today + ":" + g_curYear + g_year +
            g_curMonth + g_month + g_curDay + g_day + "</span>";
    } else {
        dateDiv += "<span style='cursor:pointer;font-weight:bolder;' onclick='SetDate(g_curYear,g_curMonth,g_curDay)' onmouseover='this.style.color=\"" +
            g_mouseOver + "\"' onmouseout='this.style.color=\"#000000\"'>" + g_today + ":" + g_curMonth + ',' + g_curDay +
            ',' + g_curYear + "</span>";
    }
    dateDiv += "</tr></tr></table></div>";
    return dateDiv;
}

with(document)
{
    onclick = fHideCalendar;

    write(getDateDiv());
    bgColor = "#FFFFFF";
}
