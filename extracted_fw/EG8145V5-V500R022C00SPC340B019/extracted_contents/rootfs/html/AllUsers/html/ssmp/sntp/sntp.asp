<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="javascript" src="../../bbsp/common/wandns.asp"></script>
<style>
.sntpselectdefcss{
    width:260px;
}
</style>
<script language="JavaScript" type="text/javascript">
var MngtTelmex  = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TELMEX);%>';
var MngtTelmex2WIFI  = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var cur_time    = '<%HW_WEB_GetLocalTime();FT=HW_SSMP_FEATURE_MNGT_TELMEX&USER=2%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var SmartFlag  = '<%HW_WEB_IsSmartBoard();%>';
var IsTde2Mode = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';
var curAPType = '<%HW_WEB_GetApMode();%>';
var DBAA1 = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>';
if (MngtTelmex == 1) {
    var SntpReload =  [];
} else if (DBAA1 == '1') {
    var SntpReload = [{ReloadId:"ntpServer4_select", ReloadValue:[{display:0}]}, ]
} else {
    var SntpReload = [
        {ReloadId:"ntpServer3_select", ReloadValue:[{display:0}]},
        {ReloadId:"ntpServer4_select", ReloadValue:[{display:0}]},
    ]
}
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var TalkTalkFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
var sntpinterfaceflag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_SNTP_INTERFACE);%>';
var sntpAddr = '<%HW_WEB_GetSPEC(SPEC_WEB_SNTP_ADDR.STRING);%>';

var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var TypeWord='<%HW_WEB_GetTypeWordMode();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var var_month;
var var_week;
var var_day;
var var_hour;
var var_min;
var var_sec;

if (cur_time == null
    || cur_time == "")
{
    cur_time = "Mon Jan 1 00:00:00 2015";
}

var tmp_time    = cur_time.replace("  "," ");
var strDateTime = tmp_time.split(' ');

var weekday  = strDateTime[0];
var month    = strDateTime[1];
var day      = strDateTime[2];
var year     = strDateTime[4];
var timezone = strDateTime[5];

var time   = strDateTime[3].split(':');
var hour   = time[0];
var minute = time[1];
var second = time[2];
var n      = 0;

var strCurrentTime = '';
var flagLeapYear   = 0;
var ProductType = '<%HW_WEB_GetProductType();%>';

function IsXdslProduct()
{
    return '2'==ProductType;
}

function IsSonetNewNormalUser() {
    if (((CfgMode.toUpperCase() == 'SONET') || (CfgMode.toUpperCase() == 'SONET8045Q') ||
        (CfgMode.toUpperCase() == 'SONETSGP200W')) && (curUserType != '0')) {
        return true;
    }
    if ((CfgMode.toUpperCase() == 'SYNCSGP210W') || (CfgMode.toUpperCase() == 'SONETSGP210W')) {
        return true;
    }
    return false;
}

function AddDay()
{
    if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)))
    {
        flagLeapYear = 1;
    }

    switch(month)
    {
        case 'Jan':
            {
                if (day >= 31)
                {
                    month = 'Feb';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Feb':
            {
                if (((flagLeapYear == 1) && (day >= 29)) || ((flagLeapYear == 0) && (day >= 28)))
                {
                    month = 'Mar';
                    day   = '1';
                }
                else
                {
                    day++;
                }

            }
            break;
        case 'Mar':
            {
                if (day >= 31)
                {
                    month = 'Apr';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Apr':
            {
                if (day >= 30)
                {
                    month = 'May';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'May':
            {
                if (day >= 31)
                {
                    month = 'Jun';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Jun':
            {
                if (day >= 30)
                {
                    month = 'Jul';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Jul':
            {
                if (day >= 31)
                {
                    month = 'Aug';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Aug':
            {
                if (day >= 31)
                {
                    month = 'Sep';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Sep':
            {
                if (day >= 30)
                {
                    month = 'Oct';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Oct':
            {
                if (day >= 31)
                {
                    month = 'Nov';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Nov':
            {
                if (day >= 30)
                {
                    month = 'Dec';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        case 'Dec':
            {
                if (day >= 31)
                {
                    year++;
                    month = 'Jan';
                    day   = '1';
                }
                else
                {
                    day++;
                }
            }
            break;
        default:
            break;
    }
}

function AddWeekday()
{
    switch(weekday)
    {
        case 'Mon':
            {
                weekday = 'Tue';
            }
            break;
        case 'Tue':
            {
                weekday = 'Wed';
            }
            break;
        case 'Wed':
            {
                weekday = 'Thu';
            }
            break;
        case 'Thu':
            {
                weekday = 'Fri';
            }
            break;
        case 'Fri':
            {
                weekday = 'Sat';
            }
            break;
        case 'Sat':
            {
                weekday = 'Sun';
            }
            break;
        case 'Sun':
            {
                weekday = 'Mon';
            }
            break;
        default:
            break;
    }
}

function TransSpanishWeekday()
{
    switch(weekday)
    {
        case 'Mon':
            {
                weekday = 'Lun';
            }
            break;
        case 'Tue':
            {
                weekday = 'Mar';
            }
            break;
        case 'Wed':
            {
                weekday = 'Mie';
            }
            break;
        case 'Thu':
            {
                weekday = 'Jue';
            }
            break;
        case 'Fri':
            {
                weekday = 'Vie';
            }
            break;
        case 'Sat':
            {
                weekday = 'Sab';
            }
            break;
        case 'Sun':
            {
                weekday = 'Dom';
            }
            break;
        default:
            break;
    }
}

function TransSpanishMonth()
{
    switch(month)
    {
        case 'Jan':
            {
                month = 'Ene';
            }
            break;
        case 'Feb':
            {
                month = 'Feb';
            }
            break;
        case 'Mar':
            {
                month = 'Mar';
            }
            break;
        case 'Apr':
            {
                month = 'Abr';
            }
            break;
        case 'May':
            {
                month = 'May';
            }
            break;
        case 'Jun':
            {
                month = 'Jun';
            }
            break;
        case 'Jul':
            {
                month = 'Jul';
            }
            break;
        case 'Aug':
            {
                month = 'Ago';
            }
            break;
        case 'Sep':
            {
                month = 'Sep';
            }
            break;
        case 'Oct':
            {
                month = 'Oct';
            }
            break;
        case 'Nov':
            {
                month = 'Nov';
            }
            break;
        case 'Dec':
            {
                month = 'Dic';
            }
            break;
        default:
            break;
    }
}

function upgrade_curtime(data)
{
    cur_time = data;
    if (cur_time == null || cur_time == "")
    {
        n = 0;
        return;
    }
    ParseTime();
    n = 0;
}

function showtime()
{
    second++;
    n++;
    if (second < 10)
    {
        second = '0' + second;
    }
    if (second >= 60)
    {
        minute++;
        if(minute < 10)
        {
            minute = '0' + minute;
        }
        second = "00";
    }
    if (minute >= 60)
    {
        hour++;
        if(hour < 10)
        {
            hour = '0'+hour;
        }
        minute = "00";
    }
    if (hour >= 24)
    {
        AddDay();
        hour = "00";
        AddWeekday();
    }

    if (curLanguage == 'spanish')
    {
        TransSpanishWeekday();
        TransSpanishMonth();
    }

    strCurrentTime = weekday + ' ' + month + ' ' + day + ' ' + hour + ':' + minute + ':' + second  + ' ' + year;
    if ((n > TimeInfo.SynInterval) && (TimeInfo.Enable == 1))
    {
        $.ajax({
        type : "POST",
        async : true,
        cache : false,
        url : "/asp/GetLocalTime.asp",
        success : function(data) {
            try{
                upgrade_curtime(hexDecode(data));
            }catch(e){
                
            }
        }
        });
    }
    getElById("curtime").value = strCurrentTime;
}

function ParseTime()
{
    var tmp_tmp = '';

    tmp_tmp = cur_time.replace("  "," ");
    strDateTime = tmp_tmp.split(' ');

    weekday  = strDateTime[0];
    month    = strDateTime[1];
    day      = strDateTime[2];
    time     = strDateTime[3].split(':');
    year     = strDateTime[4];
    timezone = strDateTime[5];

    hour   = time[0];
    minute = time[1];
    second = time[2];
}

function GetLanguageDesc(Name)
{
    return SntpLgeDes[Name];
}

function setNtpDisplay(id, checkbox)
{
    if (checkbox.checked)
    {
        setDisplay(id, 1);
    }
    else
    {
        setDisplay(id, 0);
    }
}

function ShowDstConfig(checkbox)
{
    setNtpDisplay('dstConfigDetail', checkbox);
}

function ShowNtpConfig(checkbox)
{
    setNtpDisplay('ntpConfigDetail', checkbox);
}

function stTimeInfo(domain,Enable,ntp1,ntp2,ntp3,ntp4,Zone,ZoneName,SynInterval,WanName,DstUsed,StartDate,EndDate,StartDate_EX,EndDate_EX,SyncServer)
{
    this.domain = domain;
    this.Enable = Enable;
    this.ntp1   = ntp1;
    this.ntp2   = ntp2;
    this.ntp3   = ntp3;
    this.ntp4   = ntp4;
    this.Zone   = Zone;
    this.ZoneName    = ZoneName.toString().replace(/&#39;/g, "\'");
    this.SynInterval = SynInterval;
    this.WanName   = WanName;
    this.DstUsed   = DstUsed;
    this.StartDate = StartDate;
    this.EndDate   = EndDate;
    this.StartDate_EX = StartDate_EX;
    this.EndDate_EX   = EndDate_EX;
    this.SyncServer   = SyncServer
}

function stWanInfo(domain,Enable,CntType,ConnectionStatus,NATEnabled,DefaultGateway,ServiceList,vlanid,tr069flag,submask)
{
    this.domain  = domain;
    this.Enable  = Enable;
    this.CntType = CntType;
    this.ConnectionStatus = ConnectionStatus;
    this.NATEnabled       = NATEnabled;
    this.DefaultGateway   = DefaultGateway;

    this.ServiceList = ServiceList.toUpperCase();
    this.vlanid      = vlanid;
    this.submask     = submask;
    this.Tr069Flag   = tr069flag;
}

var TimeInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Time,Enable|NTPServer1|NTPServer2|NTPServer3|NTPServer4|LocalTimeZone|LocalTimeZoneName|X_HW_SynInterval|X_HW_WanName|DaylightSavingsUsed|DaylightSavingsStart|DaylightSavingsEnd|X_HW_DaylightSavingsStartDate|X_HW_DaylightSavingsEndDate|X_HW_SyncServer,stTimeInfo);%>;

var timeInterfaces = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Time.X_HW_Interfaces);%>';

var TimeInfo = TimeInfos[0];

function IsRouteWan(Wan)
{
    if (viettelflag ==1)
    {
        if (Wan.ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
        {
            return false;
        }
    }
    if (curCfgModeWord.toUpperCase() == "TRIPLETAP" || curCfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || curCfgModeWord.toUpperCase() == "TRIPLETAP6" || curCfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
        if (Wan.domain.indexOf(8) > -1) {
            return false;
        }
    }
    if(Wan.Mode == 'IP_Routed' )
    {
        return true;
    }
    return false;
}

var sntpSysTime = '2009-9-12T200:11:22';
var timeoutID;


var ntpServers = new Array('None',
                           'cpentp.superonline.net',
                           'clock.fmt.he.net',
                           'clock.nyc.he.net',
                           'clock.sjc.he.net',
                           'clock.via.net',
                           'ntp1.tummy.com',
                           'time.cachenetworks.com',
                           'time.nist.gov',
                           'time.windows.com',
                           'Other');
if (TalkTalkFlag == "1")
{
     ntpServers = new Array('0.ntp.talktalk.net',
                           '1.ntp.talktalk.net',
                           '2.ntp.talktalk.net');
}

if (CfgMode.toUpperCase() == 'TRIPLETAP' || CfgMode.toUpperCase() == 'TRIPLETAPNOGM' || CfgMode.toUpperCase() == 'TRIPLETAP6' || CfgMode.toUpperCase() == 'TRIPLETAP6PAIR') {
    ntpServers = new Array('None',
                           '0.pool.ntp.org',
                           '0.th.pool.ntp.org',
                           'cpentp.superonline.net',
                           'clock.fmt.he.net',
                           'clock.nyc.he.net',
                           'clock.sjc.he.net',
                           'clock.via.net',
                           'ntp1.tummy.com',
                           'time.cachenetworks.com',
                           'time.nist.gov',
                           'time.windows.com',
                           'Other');
}

if ((CfgMode.toUpperCase() == 'STCAP') && (curLanguage == 'arabic')) {
    ntpServers = new Array('بلا',
                           'cpentp.superonline.net',
                           'clock.fmt.he.net',
                           'clock.nyc.he.net',
                           'clock.sjc.he.net',
                           'clock.via.net',
                           'ntp1.tummy.com',
                           'time.cachenetworks.com',
                           'time.nist.gov',
                           'time.windows.com',
                           'أخرى');
}

if ((CfgMode.toUpperCase() == "MONGOLIA") || (CfgMode.toUpperCase() == "MONGOLIA2")) {
var timeZonesEng = new Array(' GMT-12:00  International Date Line West',
                             ' GMT-11:00  Midway Island, Samoa',
                             ' GMT-10:00  Hawaii',
                             ' GMT-09:00  Alaska',
                             ' GMT-08:00  Pacific Time, Tijuana',
                             ' GMT-07:00  Arizona, Mazatlan',
                             ' GMT-07:00  Chihuahua, La Paz',
                             ' GMT-07:00  Mountain Time',
                             ' GMT-06:00  Central America',
                             ' GMT-06:00  Central Time',
                             ' GMT-06:00  Guadalajara, Mexico City, Monterrey',
                             ' GMT-06:00  Saskatchewan',
                             ' GMT-05:00  Bogota, Lima, Quito',
                             ' GMT-05:00  Eastern Time',
                             ' GMT-05:00  Indiana',
                             ' GMT-04:00  Atlantic Time',
                             ' GMT-04:00  Caracas, La Paz',
                             ' GMT-04:00  Santiago',
                             ' GMT-03:30  Newfoundland',
                             ' GMT-03:00  Brasilia',
                             ' GMT-03:00  Buenos Aires, Georgetown',
                             ' GMT-03:00  Greenland',
                             ' GMT-02:00  Mid-Atlantic',
                             ' GMT-01:00  Azores',
                             ' GMT-01:00  Cape Verde Is.',
                             ' GMT  Casablanca, Monrovia',
                             ' GMT  Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London',
                             ' GMT+01:00  Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
                             ' GMT+01:00  Belgrade, Bratislava, Budapest, Ljubljana, Prague',
                             ' GMT+01:00  Brussels, Copenhagen, Madrid, Paris',
                             ' GMT+01:00  Sarajevo, Skopje, Warsaw, Zagreb',
                             ' GMT+01:00  West Central Africa',
                             ' GMT+02:00  Athens, Istanbul, Minsk',
                             ' GMT+02:00  Bucharest',
                             ' GMT+02:00  Cairo',
                             ' GMT+02:00  Harare, Pretoria',
                             ' GMT+02:00  Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius',
                             ' GMT+02:00  Jerusalem',
                             ' GMT+03:00  Baghdad',
                             ' GMT+03:00  Kaliningrad',
                             ' GMT+03:00  Kuwait, Riyadh',
                             ' GMT+03:00  Nairobi',
                             ' GMT+03:00  Moscow, St. Petersburg, Nizhny Novgorod',
                             ' GMT+03:30  Tehran',
                             ' GMT+04:00  Abu Dhabi, Muscat',
                             ' GMT+04:00  Moscow, St. Petersburg, Volgograd',
                             ' GMT+04:00  Baku, Tbilisi, Yerevan',
                             ' GMT+04:30  Kabul',
                             ' GMT+05:00  Islamabad, Karachi, Tashkent',
                             ' GMT+05:30  Chennai, Kolkata, Mumbai, New Delhi',
                             ' GMT+05:45  Kathmandu',
                             ' GMT+06:00  Almaty',
                             ' GMT+06:00  Astana, Dhaka',
                             ' GMT+06:00  Ekaterinburg',
                             ' GMT+06:00  Sri Jayawardenepura',
                             ' GMT+06:30  Rangoon',
                             ' GMT+07:00  Bangkok, Hanoi, Jakarta',
                             ' GMT+07:00  Novosibirsk',
                             ' GMT+08:00  Beijing, Chongqing, Hong Kong, Urumqi',
                             ' GMT+08:00  Krasnoyarsk',
                             ' GMT+08:00  Kuala Lumpur, Singapore',
                             ' GMT+08:00  Perth',
                             ' GMT+08:00  Taipei',
                             ' GMT+08:00  Irkutsk, Ulaanbaatar',
                             ' GMT+08:00  Ulaan Bataar',
                             ' GMT+09:00  Irkutsk',
                             ' GMT+09:00  Osaka, Sapporo, Tokyo',
                             ' GMT+09:00  Seoul',
                             ' GMT+09:30  Adelaide',
                             ' GMT+09:30  Darwin',
                             ' GMT+10:00  Brisbane',
                             ' GMT+10:00  Canberra, Melbourne, Sydney',
                             ' GMT+10:00  Guam, Port Moresby',
                             ' GMT+10:00  Hobart',
                             ' GMT+10:00  Yakutsk',
                             ' GMT+11:00  Solomon Is., New Caledonia',
                             ' GMT+11:00  Vladivostok',
                             ' GMT+12:00  Auckland, Wellington',
                             ' GMT+12:00  Fiji, Kamchatka, Marshall Is.',
                             ' GMT+12:00  Magadan',
                             ' GMT+13:00  Nuku\'alofa');
} else {
var timeZonesEng = new Array(' GMT-12:00  International Date Line West',
                             ' GMT-11:00  Midway Island, Samoa',
                             ' GMT-10:00  Hawaii',
                             ' GMT-09:00  Alaska',
                             ' GMT-08:00  Pacific Time, Tijuana',
                             ' GMT-07:00  Arizona, Mazatlan',
                             ' GMT-07:00  Chihuahua, La Paz',
                             ' GMT-07:00  Mountain Time',
                             ' GMT-06:00  Central America',
                             ' GMT-06:00  Central Time',
                             ' GMT-06:00  Guadalajara, Mexico City, Monterrey',
                             ' GMT-06:00  Saskatchewan',
                             ' GMT-05:00  Bogota, Lima, Quito',
                             ' GMT-05:00  Eastern Time',
                             ' GMT-05:00  Indiana',
                             ' GMT-04:00  Atlantic Time',
                             ' GMT-04:00  Caracas, La Paz',
                             ' GMT-04:00  Santiago',
                             ' GMT-03:30  Newfoundland',
                             ' GMT-03:00  Brasilia',
                             ' GMT-03:00  Buenos Aires, Georgetown',
                             ' GMT-03:00  Greenland',
                             ' GMT-02:00  Mid-Atlantic',
                             ' GMT-01:00  Azores',
                             ' GMT-01:00  Cape Verde Is.',
                             ' GMT  Casablanca, Monrovia',
                             ' GMT  Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London',
                             ' GMT+01:00  Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
                             ' GMT+01:00  Belgrade, Bratislava, Budapest, Ljubljana, Prague',
                             ' GMT+01:00  Brussels, Copenhagen, Madrid, Paris',
                             ' GMT+01:00  Sarajevo, Skopje, Warsaw, Zagreb',
                             ' GMT+01:00  West Central Africa',
                             ' GMT+02:00  Athens, Istanbul, Minsk',
                             ' GMT+02:00  Bucharest',
                             ' GMT+02:00  Cairo',
                             ' GMT+02:00  Harare, Pretoria',
                             ' GMT+02:00  Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius',
                             ' GMT+02:00  Jerusalem',
                             ' GMT+03:00  Baghdad',
                             ' GMT+03:00  Kaliningrad',
                             ' GMT+03:00  Kuwait, Riyadh',
                             ' GMT+03:00  Nairobi',
                             ' GMT+03:00  Moscow, St. Petersburg, Nizhny Novgorod',
                             ' GMT+03:00  Istanbul',
                             ' GMT+03:30  Tehran',
                             ' GMT+04:00  Abu Dhabi, Muscat',
                             ' GMT+04:00  Moscow, St. Petersburg, Volgograd',
                             ' GMT+04:00  Baku, Tbilisi, Yerevan',
                             ' GMT+04:30  Kabul',
                             ' GMT+05:00  Islamabad, Karachi, Tashkent',
                             ' GMT+05:30  Chennai, Kolkata, Mumbai, New Delhi',
                             ' GMT+05:45  Kathmandu',
                             ' GMT+06:00  Almaty',
                             ' GMT+06:00  Astana, Dhaka',
                             ' GMT+06:00  Ekaterinburg',
                             ' GMT+06:00  Sri Jayawardenepura',
                             ' GMT+06:30  Rangoon',
                             ' GMT+07:00  Bangkok, Hanoi, Jakarta',
                             ' GMT+07:00  Novosibirsk',
                             ' GMT+08:00  Beijing, Chongqing, Hong Kong, Urumqi',
                             ' GMT+08:00  Krasnoyarsk',
                             ' GMT+08:00  Kuala Lumpur, Singapore',
                             ' GMT+08:00  Perth',
                             ' GMT+08:00  Taipei',
                             ' GMT+08:00  Ulaan Bataar',
                             ' GMT+09:00  Irkutsk',
                             ' GMT+09:00  Osaka, Sapporo, Tokyo',
                             ' GMT+09:00  Seoul',
                             ' GMT+09:30  Adelaide',
                             ' GMT+09:30  Darwin',
                             ' GMT+10:00  Brisbane',
                             ' GMT+10:00  Canberra, Melbourne, Sydney',
                             ' GMT+10:00  Guam, Port Moresby',
                             ' GMT+10:00  Hobart',
                             ' GMT+10:00  Yakutsk',
                             ' GMT+11:00  Solomon Is., New Caledonia',
                             ' GMT+11:00  Vladivostok',
                             ' GMT+12:00  Auckland, Wellington',
                             ' GMT+12:00  Fiji, Kamchatka, Marshall Is.',
                             ' GMT+12:00  Magadan',
                             ' GMT+13:00  Nuku\'alofa');
}

if (curLanguage == 'russian')
{
    var timeZonesRus = new Array(
                            ' GMT-12:00  Международная линия перемены дат',
                            ' GMT-11:00  О-ва Мидуэй, Самоа',
                            ' GMT-10:00  Гавайи',
                            ' GMT-09:00  Аляска',
                            ' GMT-08:00  Тихоокеанское время, Тихуана',
                            ' GMT-07:00  Аризона, Масатлан',
                            ' GMT-07:00  Чиуауа, Ла-Пас',
                            ' GMT-07:00  Горное время',
                            ' GMT-06:00  Центральноамериканское время',
                            ' GMT-06:00  Центральное время',
                            ' GMT-06:00   Гвадалахара, Мехико, Монтеррей',
                            ' GMT-06:00  Саскачеван',
                            ' GMT-05:00  Богота, Лима, Кито',
                            ' GMT-05:00   Североамериканское восточное время',
                            ' GMT-05:00  Индиана',
                            ' GMT-04:00  Атлантическое время',
                            ' GMT-04:00  Каракас, Ла-Пас',
                            ' GMT-04:00  Сантьяго',
                            ' GMT-03:30  Ньюфаундленд',
                            ' GMT-03:00  Бразилиа',
                            ' GMT-03:00  Буэнос-Айрес, Джорджтаун',
                            ' GMT-03:00  Гренландия',
                            ' GMT-02:00  Среднеатлантическое время',
                            ' GMT-01:00  Азорские о-ва',
                            ' GMT-01:00  Кабо-Верде',
                            ' GMT  Касабланка, Монровия',
                            ' GMT  Гринвичское время: Дублин, Эдинбург, Лиссабон, Лондон',
                            ' GMT+01:00  Амстердам, Берлин, Берн, Рим, Стокгольм, Вена',
                            ' GMT+01:00  Белград, Братислава, Будапешт, Любляна, Прага',
                            ' GMT+01:00  Брюссель, Копенгаген, Мадрид, Париж',
                            ' GMT+01:00  Сараево, Скопье, Варшава, Загреб',
                            ' GMT+01:00  Западное центральноафриканское время', 
                            ' GMT+02:00  Афины, Стамбул, Минск',
                            ' GMT+02:00  Бухарест',
                            ' GMT+02:00  Каир',
                            ' GMT+02:00  Хараре, Претория',
                            ' GMT+02:00  Хельсинки, Киев, Рига, София, Таллинн, Вильнюс',
                            ' GMT+02:00  Иерусалим',
                            ' GMT+03:00  Багдад',
                            ' GMT+03:00  Калининград',
                            ' GMT+03:00  Кувейт, Эр-Рияд',
                            ' GMT+03:00  Найроби',
                            ' GMT+03:00  Москва, Санкт-Петербург, Нижний Новгород',
                            ' GMT+03:00  Стамбул',
                            ' GMT+03:30  Тегеран',
                            ' GMT+04:00  Абу-Даби, Мускат',
                            ' GMT+04:00  Баку, Тбилиси, Ереван',
                            ' GMT+04:00  Москва, Санкт-Петербург, Волгоград',
                            ' GMT+04:30  Кабул',
                            ' GMT+05:00  Исламабад, Карачи, Ташкент',
                            ' GMT+05:30  Ченнаи, Калькутта, Мумбаи, Нью-Дели',
                            ' GMT+05:45  Катманду',
                            ' GMT+06:00  Алматы',
                            ' GMT+06:00  Астана, Дакка',
                            ' GMT+06:00  Екатеринбург',
                            ' GMT+06:00  Шри-Джаяварденепура',
                            ' GMT+06:30  Янгон',
                            ' GMT+07:00  Бангкок, Ханой, Джакарта',
                            ' GMT+07:00  Новосибирск',
                            ' GMT+08:00  Пекин, Чунцин, Гонконг, Урумчи',
                            ' GMT+08:00  Красноярск',
                            ' GMT+08:00  Куала-Лумпур, Сингапур',
                            ' GMT+08:00  Перт',
                            ' GMT+08:00  Тайбэй',
                            ' GMT+08:00  Улан-Батор',
                            ' GMT+09:00  Иркутск',
                            ' GMT+09:00  Осака, Саппоро, Токио',
                            ' GMT+09:00  Сеул',
                            ' GMT+09:30  Аделаида',
                            ' GMT+09:30  Дарвин',
                            ' GMT+10:00  Брисбен',
                            ' GMT+10:00  Канберра, Мельбурн, Сидней',
                            ' GMT+10:00  Гуам, Порт-Морсби',
                            ' GMT+10:00  Хобарт',
                            ' GMT+10:00  Якутск',
                            ' GMT+11:00  Соломоновы о-ва, Новая Каледония',
                            ' GMT+11:00  Владивосток',
                            ' GMT+12:00  Окленд, Веллингтон',
                            ' GMT+12:00  Фиджи, Камчатка, Маршалловы о-ва',
                            ' GMT+12:00  Магадан',
                            ' GMT+13:00  Нукуалофа'
    );
}

if (curLanguage == 'brasil') {
    var timeZonesBra = new Array(
                            ' GMT-12:00  Linha Internacional de Data Oeste',
                            ' GMT-11:00  Ilha Midway, Samoa',
                            ' GMT-10:00  Havaí',
                            ' GMT-09:00  Alasca',
                            ' GMT-08:00  Hora do Pacífico, Tijuana',
                            ' GMT-07:00  Arizona, Mazatlán',
                            ' GMT-07:00  Chihuahua, La Paz',
                            ' GMT-07:00  Hora das Montanhas',
                            ' GMT-06:00  América Central',
                            ' GMT-06:00  Hora Central',
                            ' GMT-06:00  Guadalajara, Cidade do México, Monterrey',
                            ' GMT-06:00  Saskatchewan',
                            ' GMT-05:00  Bogotá, Lima, Quito',
                            ' GMT-05:00  Hora do Leste',
                            ' GMT-05:00  Indiana',
                            ' GMT-04:00  Hora do Atlântico',
                            ' GMT-04:00  Caracas, La Paz',
                            ' GMT-04:00  Santiago',
                            ' GMT-03:30  Newfoundland',
                            ' GMT-03:00  Brasília',
                            ' GMT-03:00  Buenos Aires, Georgetown',
                            ' GMT-03:00  Groenlândia',
                            ' GMT-02:00  Atlântico Central',
                            ' GMT-01:00  Açores',
                            ' GMT-01:00  Ilhas Cabo Verde',
                            ' GMT  Casablanca, Monróvia',
                            ' GMT  Hora de Greenwich: Dublin, Edimburgo, Lisboa, Londres',
                            ' GMT+01:00  Amsterdã, Berlim, Berna, Roma, Estocolmo, Viena',
                            ' GMT+01:00  Belgrado, Bratislava, Budapeste, Liubliana, Praga',
                            ' GMT+01:00  Bruxelas, Copenhague, Madri, Paris',
                            ' GMT+01:00  Sarajevo, Skopje, Varsóvia, Zagreb',
                            ' GMT+01:00  Centro-oeste da África',
                            ' GMT+02:00  Atenas, Istambul, Minsk',
                            ' GMT+02:00  Bucareste',
                            ' GMT+02:00  Cairo',
                            ' GMT+02:00  Harare, Pretória',
                            ' GMT+02:00  Helsinque, Kiev, Riga, Sófia, Tallinn, Vilnius',
                            ' GMT+02:00  Jerusalém',
                            ' GMT+03:00  Bagdá',
                            ' GMT+03:00  Kaliningrado',
                            ' GMT+03:00  Kuwait, Riad',
                            ' GMT+03:00  Nairóbi',
                            ' GMT+03:00  Moscou, São Petersburgo, Nizhny Novgorod',
                            ' GMT+03:00  Istambul',
                            ' GMT+03:30  Teerã',
                            ' GMT+04:00  Abu Dhabi, Muscat',
                            ' GMT+04:00  Moscou, São Petersburgo, Volgogrado',
                            ' GMT+04:00  Baku, Tbilisi, Yerevan',
                            ' GMT+04:30  Cabul',
                            ' GMT+05:00  Islamabad, Karachi, Tashkent',
                            ' GMT+05:30  Chennai, Calcutá, Mumbai, Nova Délhi',
                            ' GMT+05:45  Katmandu',
                            ' GMT+06:00  Almaty',
                            ' GMT+06:00  Astana, Daca',
                            ' GMT+06:00  Ekaterimburgo',
                            ' GMT+06:00  Sri Jayawardenepura',
                            ' GMT+06:30  Yangon',
                            ' GMT+07:00  Bancoc, Hanói, Jacarta',
                            ' GMT+07:00  Novosibirsk',
                            ' GMT+08:00  Pequim, Chonqim, Hong Kong, Urumqi',
                            ' GMT+08:00  Krasnoyarsk',
                            ' GMT+08:00  Kuala Lumpur, Cingapura',
                            ' GMT+08:00  Perth',
                            ' GMT+08:00  Taipé',
                            ' GMT+08:00  Ulaan Bataar',
                            ' GMT+09:00  Irkutsk',
                            ' GMT+09:00  Osaka, Sapporo, Tóquio',
                            ' GMT+09:00  Seul',
                            ' GMT+09:30  Adelaide',
                            ' GMT+09:30  Darwin',
                            ' GMT+10:00  Brisbane',
                            ' GMT+10:00  Camberra, Melbourne, Sydney',
                            ' GMT+10:00  Guam, Port Moresby',
                            ' GMT+10:00  Hobart',
                            ' GMT+10:00  Yakutsk',
                            ' GMT+11:00  Ilhas Salomão, Nova Caledônia',
                            ' GMT+11:00  Vladivostok',
                            ' GMT+12:00  Auckland, Wellington',
                            ' GMT+12:00  Ilhas Fiji, Kamchatka, Ilhas Marshall',
                            ' GMT+12:00  Magadan',
                            ' GMT+13:00  Nuku\'alofa'
    );
}

if (curLanguage == 'turkish') {
    var timeZonesTurk = new Array(
                            ' GMT-12:00  Tarih Değiştirme Çizgisi Batı',
                            ' GMT-11:00  Midway Adası, Samoa',
                            ' GMT-10:00  Hawaii',
                            ' GMT-09:00  Alaska',
                            ' GMT-08:00  Pasifik Saati, Tijuana',
                            ' GMT-07:00  Arizona, Mazatlan',
                            ' GMT-07:00  Chihuahua, La Paz',
                            ' GMT-07:00  Dağ Saati',
                            ' GMT-06:00  Orta Amerika',
                            ' GMT-06:00  Merkezi Saat',
                            ' GMT-06:00  Guadalajara, Mexico City, Monterrey',
                            ' GMT-06:00  Saskatchewan',
                            ' GMT-05:00  Bogota, Lima, Quito',
                            ' GMT-05:00  Doğu Saati',
                            ' GMT-05:00  Indiana',
                            ' GMT-04:00  Atlantik Saati',
                            ' GMT-04:00  Karakas, La Paz',
                            ' GMT-04:00  Santiago',
                            ' GMT-03:30  Newfoundland',
                            ' GMT-03:00  Brasilia',
                            ' GMT-03:00  Buenos Aires, Georgetown',
                            ' GMT-03:00  Grönland',
                            ' GMT-02:00  Orta Atlantik',
                            ' GMT-01:00  Azorlar',
                            ' GMT-01:00  Cape Verde Ad.',
                            ' GMT  Kazablanka, Monrovia',
                            ' GMT  Greenwich Saati: Dublin, Edinburgh, Lizbon, Londra',
                            ' GMT+01:00  Amsterdam, Berlin, Bern, Roma, Stockholm, Viyana',
                            ' GMT+01:00  Belgrad, Bratislava, Budapeşte, Lübliyana, Prag',
                            ' GMT+01:00  Brüksel, Kopenhag, Madrid, Paris',
                            ' GMT+01:00  Saraybos., Üsküp, Varşova, Zagreb',
                            ' GMT+01:00  Orta Batı Afrika',
                            ' GMT+02:00  Atina, İstanbul, Minsk',
                            ' GMT+02:00  Bükreş',
                            ' GMT+02:00  Kahire',
                            ' GMT+02:00  Harare, Pretoria',
                            ' GMT+02:00  Helsinki, Kiev, Riga, Sofya, Tallinn, Vilnius',
                            ' GMT+02:00  Kudüs',
                            ' GMT+03:00  Bağdat',
                            ' GMT+03:00  Kaliningrad',
                            ' GMT+03:00  Kuveyt, Riyad',
                            ' GMT+03:00  Nairobi',
                            ' GMT+03:00  Moskova, St Petersburg, Nijniy Novgorod',
                            ' GMT+03:00  İstanbul',
                            ' GMT+03:30  Tahran',
                            ' GMT+04:00  Abu Dabi, Maskat',
                            ' GMT+04:00  Moskova, St. Petersburg, Volvograd',
                            ' GMT+04:00  Bakü, Tiflis, Erivan',
                            ' GMT+04:30  Kabil',
                            ' GMT+05:00  İslamabad, Karaçi, Taşkent',
                            ' GMT+05:30  Chennai, Kalküta, Mumbai, Yeni Delhi',
                            ' GMT+05:45  Katmandu',
                            ' GMT+06:00  Almatı',
                            ' GMT+06:00  Astana, Dakka',
                            ' GMT+06:00  Yekaterinburg',
                            ' GMT+06:00  Sri Jayawardenepura',
                            ' GMT+06:30  Rangoon',
                            ' GMT+07:00  Bangkok, Hanoi, Jakarta',
                            ' GMT+07:00  Novosibirsk',
                            ' GMT+08:00  Pekin, Chongqing, Hong Kong, Urumçi',
                            ' GMT+08:00  Krasnoyarsk',
                            ' GMT+08:00  Kuala Lumpur, Singapur',
                            ' GMT+08:00  Perth',
                            ' GMT+08:00  Taipei',
                            ' GMT+08:00  Ulan Batur',
                            ' GMT+09:00  İrkutsk',
                            ' GMT+09:00  Osaka, Sapporo, Tokyo',
                            ' GMT+09:00  Seul',
                            ' GMT+09:30  Adelaide',
                            ' GMT+09:30  Darwin',
                            ' GMT+10:00  Brisbane',
                            ' GMT+10:00  Canberra, Melbourne, Sidney',
                            ' GMT+10:00  Guam, Port Moresby',
                            ' GMT+10:00  Hobart',
                            ' GMT+10:00  Yakutsk',
                            ' GMT+11:00  Solomon Ad., Yeni Kaledonya',
                            ' GMT+11:00  Vladivostok',
                            ' GMT+12:00  Auckland, Wellington',
                            ' GMT+12:00  Fiji, Kamçatka, Marshall Ad.',
                            ' GMT+12:00  Magadan',
                            ' GMT+13:00  Nuku\'alofa'
    );
}

var timeZonesRos = new Array(' GMT+02:00  Kaliningrad',
                             ' GMT+03:00  Moscow',
                             ' GMT+04:00  Samara',
                             ' GMT+05:00  Yekaterinburg',
                             ' GMT+06:00  Omsk',
                             ' GMT+07:00  Krasnoyarsk',
                             ' GMT+08:00  Irkutsk',
                             ' GMT+09:00  yakutsk',
                             ' GMT+10:00  Vladivostok',
                             ' GMT+11:00  Magadan',
                             ' GMT+12:00  Kamchatka');
if (CfgMode == 'ROSUNION') {
    timeZonesEng = timeZonesRos;
    timeZonesRus = timeZonesRos;
}

function getTimeZoneIndex(timeZoneName, timeZone)
{
    var i = 0, ret = 4;

    for (var i = 0; i < timeZonesEng.length; i++) {
        if (timeZone == "+00:00") {
            timeZone = "GMT";
        }
        if ((timeZonesEng[i].search(timeZoneName) != -1) && (timeZonesEng[i].indexOf(timeZone) != -1)) {
            break;
        }
    }

    if (i < timeZonesEng.length)
        ret = i;

    return ret;
}

function getTimeZoneName(idx)
{
    var str = timeZonesEng[idx];
    var ret = '';

    if ( idx != 25 && idx != 26 )
        ret = str.substr(12);
    else
        ret = str.substr(6);

    return ret;
}

function ntpChange(optionlist)
{
    var index = optionlist.id.substr(optionlist.id.length - 1, 1);
    var textbox = document.getElementById("ntpServerOther" + index);

    if (textbox == null)
        return ;

    if ((optionlist[optionlist.selectedIndex].value == "Other")
        || (optionlist[optionlist.selectedIndex].value == "Otro")
        || (optionlist[optionlist.selectedIndex].value == "أخرى"))
    {
        textbox.disabled = false;
        textbox.style.cssText = "margin-left:1em";
        if(MngtTelmex == "1")
        {
            if ((index == "1")&&(textbox.value == ""))
            {
                textbox.value = sntpAddr;
            }
        }
        else if (MngtTelmex2WIFI == "1")
        {
            if ((index == "1")&&(textbox.value == ""))
            {
                textbox.value = "cronos.cenam.mx";
            }
        }
    }
    else
    {
        textbox.value = "";
        textbox.disabled = true;
        textbox.style.cssText = "display:none;";
    }
}

function LoadFrameDSTtime(Load_date, Flag)
{
    var RetValue = CheckDSTtime_Ex(Load_date);

    if(RetValue != true)
    {
        return false;
    }
    
    if(1 == IsTde2Mode || CfgMode == 'ROSUNION')
    {
        setDisplay('WanNameRow', 0);
    }

    if (Flag == 1)
    {
        setSelect('month1',   var_month);
        setSelect('weeks1',   var_week);
        setSelect('weekday1', var_day);
        setSelect('hours1',   var_hour);
        setSelect('minute1',  var_min);
        setSelect('second1',  var_sec);
    }
    else
    {
        setSelect('month2',   var_month);
        setSelect('weeks2',   var_week);
        setSelect('weekday2', var_day);
        setSelect('hours2',   var_hour);
        setSelect('minute2',  var_min);
        setSelect('second2',  var_sec);
    }
}

function loadNtpServer(ntp, ntpval)
{
    var i;
    var index = ntp.substr(ntp.length - 1, 1);
    var ntpServer = document.getElementById(ntp);
    var ntpServerOther = document.getElementById('ntpServerOther' + index);

    if (ntpval.length)
    {
        for (i = 0; i < ntpServers.length - 1; i++)
        {
            if ( ntpval == ntpServers[i] )
            {
                ntpServer.selectedIndex = i;
                break;
            }
        }

        if ( i == ntpServers.length - 1 )
        {
            ntpServer.selectedIndex = i;
            ntpServerOther.value = ntpval;
            ntpServerOther.disabled = false;
            ntpServerOther.style.cssText = "margin-left:1em";            
        }
    }

    ntpChange(ntpServer);
}

function LoadFrame()
{
    CancelConfigServer();
    CancelConfigTime();

    if ((MngtTelmex == 1)
       && (TimeInfo.Enable == 1))
    {
        ParseTime();
        setDisplay('ntpDisplay',   1);
        setInterval("showtime();", 1000);
    }
    else
    {
        if ((CfgMode == 'LANAP') ||  (CfgMode == 'E8CAP') || (CfgMode == 'GHNAP2') || (CfgMode == 'BATELCO') || (CfgMode == 'DESKAP') || (CfgMode == 'CTCAP') || (CfgMode == 'CLAROAP'))
        {
            if ((TypeWord == 'AP') || (TypeWord == 'REP') || (CfgMode == 'GHNAP2') || (CfgMode == 'BATELCO'))
            {
                setDisable('WanName', 1);
            }        
        }
        setDisplay('ntpDisplay',   0);
    }

    if(IsXdslProduct())
    {
        setDisplay('WanNameRow', 0);
	    if(TalkTalkFlag == "1")
	    {
	        setDisplay('ntpDisplay',   0);
	        setDisplay('dstConfigDiv',   0);
	        setDisplay('dstConfigDetail',   0);
	        setDisplay('dstconfigbutton',   0);
	    }
    }
	
    RosSetDisable();
}

function isIpFormat(str)
{
    var i;
    var addrParts = str.split('.');

    if (addrParts.length != 4 )
        return false;

    for (i = 0; i < 4; i++)
    {
        if (isNaN(addrParts[i])
            || addrParts[i] == ""
            || addrParts[i].charAt(0) == '+'
            || addrParts[i].charAt(0) == '-' )
            return false;

        if (isPlusInteger(addrParts[i]) == false)
            return false;
    }
    return true;
}

function isTValidName(name)
{
    var i = 0;
    var unsafeString = "\"<>%\\^[]`\+\$\,='#&:;*/{} \t";
    for ( i = 0; i < name.length; i++ ) {
        for( j = 0; j < unsafeString.length; j++)
            if ( (name.charAt(i)) == unsafeString.charAt(j) )
                return false;
    }

    return true;
}

var arrAlertBindTextNtp1 = ['s0c03','s0c04','s0c05','s0c06'];
var arrAlertBindTextNtp2 = ['s0c07','s0c08','s0c09','s0c0a'];
var arrAlertBindTextNtp3 = ['s0c4a','s0c4b','s0c4c','s0c4d'];
var arrAlertBindTextNtp4 = ['s0c4e','s0c4f','s0c50','s0c51'];

function addNtpServerParam(form, ntp, bindtext)
{
    var index          = ntp.substr(ntp.length - 1, 1);
    var ntpServer      = document.getElementById(ntp);
    var ntpServerOther = document.getElementById('ntpServerOther' + index);

    if (TalkTalkFlag == "1")
    {
        form.addParameter('NTPServer' + index, ntpServer[ntpServer.selectedIndex].value);
        return true;
    }
    if (ntpServer.selectedIndex == ntpServers.length - 1)
    {
        if ( ntpServerOther.value.length == 0 )
        {
            AlertEx(GetLanguageDesc(bindtext[0]));
            return false;
        }

        if (isIpFormat(ntpServerOther.value))
        {
            if (isValidIpAddress(ntpServerOther.value) == false)
            {
                AlertEx(GetLanguageDesc(bindtext[1]));
                return false;
            }

            if (isAbcIpAddress(ntpServerOther.value) == false)
            {
                AlertEx(GetLanguageDesc(bindtext[2]));
                return false;
            }
        }
        else
        {
            if (isTValidName(ntpServerOther.value) == false)
            {
                AlertEx(GetLanguageDesc(bindtext[3]));
                return false;
            }
        }

        form.addParameter('NTPServer' + index, ntpServerOther.value);
    }
    else
    {
        if (ntpServer.selectedIndex > 0)
        {
            form.addParameter('NTPServer' + index, ntpServer[ntpServer.selectedIndex].value);
        }
        else
        {
            form.addParameter('NTPServer' + index, "");
        }
    }
    return true;
}

function SubmitForm()
{
    var Form            = new webSubmitForm();
    var ntpEnabled      = document.getElementById('ntpEnabled');
    var cboTimeZone     = document.getElementById('cboTimeZone');
    var XHWSynInterval  = document.getElementById('XHWSynInterval');
    var WanCanChange    = 1; 

    if (XHWSynInterval.value.length > 1  && XHWSynInterval.value.charAt(0) == '0')
    {
        AlertEx(GetLanguageDesc("s0c02"));
        return false;
    }

    if (isPlusInteger(XHWSynInterval.value) == false)
    {
        AlertEx(GetLanguageDesc("s0c02"));
        return false;
    }

    Form.usingPrefix('x');
    if (ntpEnabled.checked)
    {
        Form.addParameter('Enable', 1);
        if (!addNtpServerParam(Form, 'ntpServer1', arrAlertBindTextNtp1))
            return false;
        if (!addNtpServerParam(Form, 'ntpServer2', arrAlertBindTextNtp2))
            return false;
        if (MngtTelmex == 1)
        {
            if (!addNtpServerParam(Form, 'ntpServer3', arrAlertBindTextNtp3))
                return false;
            if (!addNtpServerParam(Form, 'ntpServer4', arrAlertBindTextNtp4))
                return false;
        }
        else if (TalkTalkFlag == "1")
        {
             if (!addNtpServerParam(Form, 'ntpServer3', arrAlertBindTextNtp3))
                return false;
        }
        Form.addParameter('LocalTimeZoneName', getTimeZoneName(cboTimeZone.selectedIndex));
    }
    else
    {
        Form.addParameter('Enable', 0);
    }
    
    Form.addParameter('X_HW_SynInterval', document.getElementById("XHWSynInterval").value);

    if ((CfgMode == 'LANAP') ||  (CfgMode == 'E8CAP') || (CfgMode == 'GHNAP2') || (CfgMode == 'BATELCO') || (CfgMode == 'DESKAP') || (CfgMode == 'CTCAP') || (CfgMode == 'CLAROAP'))
    {
        if ((TypeWord == 'AP') || (TypeWord == 'REP') || (CfgMode == 'GHNAP2') || (CfgMode == 'BATELCO'))
        {
            WanCanChange = 0;    
        }        
    }
    
    if ((1 != IsTde2Mode) && (WanCanChange == 1))
    {
        if (1 == sntpinterfaceflag)
        {
            Form.addParameter('X_HW_Interfaces',     getSelectVal('WanName'));
        }
        else
        {
            Form.addParameter('X_HW_WanName',     getSelectVal('WanName'));
        }
    }
    
    Form.endPrefix();
    Form.addParameter('x.X_HW_Token',     getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.Time&RequestFile=html/ssmp/sntp/sntp.asp');

    setDisable('btnApply',      1);
    setDisable('cancelValue1',  1);
    setDisable('btnApply2',     1);
    setDisable('cancelValue2',  1);
    Form.submit();
}

function printOntSysTime()
{
    var sysTime = document.getElementById('ontSysTime');
    sysTime.innerText = "The current system time : " + sntpSysTime;
}

function refreshSNTP()
{
    window.location.replace("sntp.asp");
}

function startTimeout()
{
    timeoutID = setTimeout("refreshSNTP()", 1000 * 60);
}

function stopTimeout()
{
    clearTimeout(timeoutID);
}

function checkDSTtime(str_date)
{
    date_values = str_date.split("T");
    if (date_values.length != 2)
    {
        return false;
    }

    year_values = date_values[0].split("-");
    if (year_values.length != 3)
    {
        return false;
    }

    time_values = date_values[1].split(":");
    if (time_values.length != 3)
    {
        return false;
    }

    var_year  = parseInt(year_values[0], 10);
    var_month = parseInt(year_values[1], 10);
    var_day   = parseInt(year_values[2], 10);
    var_hour  = parseInt(time_values[0], 10);
    var_min   = parseInt(time_values[1], 10);
    var_sec   = parseInt(time_values[2], 10);

    if (   isNaN(var_year) || isNaN(var_month) || isNaN(var_day)
        || isNaN(var_hour) || isNaN(var_min)   || isNaN(var_sec) )
    {
        return false;
    }

    if (var_year  < 2009 || var_year  > 2049) return false;
    if (var_month < 1    || var_month > 12)   return false;
    if (var_day   < 1    || var_day   > 31)   return false;
    if (var_hour  < 0    || var_hour  > 23)   return false;
    if (var_min   < 0    || var_min   > 59)   return false;
    if (var_sec   < 0    || var_sec   > 59)   return false;

    return true;
}

function CheckDSTtime_Ex(str_date)
{
    date_values = str_date.split("/");

    if (date_values.length != 6)
    {
        return false;
    }

    for (date_var in date_values)
    {
        if (isNaN(date_values[date_var]))
        {
            return false;
        }
    }

    try
    {
        var_month = parseInt(date_values[0], 10);
        var_week  = parseInt(date_values[1], 10);
        var_day   = parseInt(date_values[2], 10);
        var_hour  = parseInt(date_values[3], 10);
        var_min   = parseInt(date_values[4], 10);
        var_sec   = parseInt(date_values[5], 10);

        if (var_month < 1 || var_month > 12) return false;
        if (var_week  < 1 || var_week  >  5) return false;
        if (var_day   < 1 || var_day   >  7) return false;
        if (var_hour  < 0 || var_hour  > 23) return false;
        if (var_min   < 0 || var_min   > 59) return false;
        if (var_sec   < 0 || var_sec   > 59) return false;

        return true;
    }
    catch(e)
    {
        return false;
    }
}

function SubmitDSTForm()
{
    var second = 0;
    var Form = new webSubmitForm();
    var dstEnabled = document.getElementById("dstEnabled");

    Form.usingPrefix('y');

    if (dstEnabled.checked)
    {
        var startMonth = parseInt(getSelectVal('month1'));
        var endMonth   = parseInt(getSelectVal('month2'));

        if( startMonth == endMonth)
        {
            AlertEx(GetLanguageDesc("s0c41"));
            return;
        }

        var DstExtTimeStartStr = getSelectVal('month1')   + '/'
                               + getSelectVal('weeks1')   + '/'
                               + getSelectVal('weekday1') + '/'
                               + getSelectVal('hours1')   + '/'
                               + getSelectVal('minute1')  + '/'
                               + getSelectVal('second1');
        var DstExtTimeEndStr = getSelectVal('month2')   + '/'
                             + getSelectVal('weeks2')   + '/'
                             + getSelectVal('weekday2') + '/'
                             + getSelectVal('hours2')   + '/'
                             + getSelectVal('minute2')  + '/'
                             + getSelectVal('second2');

        Form.addParameter('DaylightSavingsUsed',           getCheckVal('dstEnabled'));
        Form.addParameter('X_HW_DaylightSavingsStartDate', DstExtTimeStartStr);
        Form.addParameter('X_HW_DaylightSavingsEndDate',   DstExtTimeEndStr);
    }
    else
    {
        Form.addParameter('DaylightSavingsUsed',           getCheckVal('dstEnabled'));
    }


    Form.endPrefix();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?y=InternetGatewayDevice.Time&RequestFile=html/ssmp/sntp/sntp.asp');

    setDisable('btnApply',     1);
    setDisable('cancelValue1', 1);
    setDisable('btnApply2',    1);
    setDisable('cancelValue2', 1);
    Form.submit();
}

function CancelConfigServer()
{
    var ntp1        = TimeInfo.ntp1;
    var ntp2        = TimeInfo.ntp2;
    if (MngtTelmex == 1)
    {
        var ntp3        = TimeInfo.ntp3;
        var ntp4        = TimeInfo.ntp4;
    }
    else if (TalkTalkFlag == "1" || DBAA1 == '1')
    {
        var ntp3    = TimeInfo.ntp3;
    }
    var ntp_enabled = TimeInfo.Enable;
    var tz_name     = TimeInfo.ZoneName;
    var zone        = TimeInfo.Zone;
    var cboTimeZone = document.getElementById('cboTimeZone');

    setCheck('ntpEnabled', ntp_enabled);
    if (ntp_enabled == '1')
        setDisplay('ntpConfigDetail', 1);
    else
        setDisplay('ntpConfigDetail', 0);

    loadNtpServer('ntpServer1', ntp1);
    loadNtpServer('ntpServer2', ntp2);
    if (MngtTelmex == 1)
    {
        loadNtpServer('ntpServer3', ntp3);
        loadNtpServer('ntpServer4', ntp4);
    }
    else if (TalkTalkFlag == "1" || DBAA1 == '1')
    {
        loadNtpServer('ntpServer3', ntp3);
    }
    cboTimeZone.selectedIndex = getTimeZoneIndex(tz_name, zone);
    document.getElementById('XHWSynInterval').value = TimeInfo.SynInterval;

    if (1 == sntpinterfaceflag)
    {
        document.getElementById("WanName").value = timeInterfaces;
    }
    else
    {
        document.getElementById("WanName").value = TimeInfo.WanName;
    }

    if (DBAA1 == '1') {
        var sync = TimeInfo.SyncServer;
        setElementInnerHtmlById("SyncServer", sync);
        setDisable("ntpServer2", 1);
        setDisable("ntpServer3", 1);
        setDisable("ntpServerOther2", 1);
        setDisable("ntpServerOther3", 1);
        document.getElementById("ntpServer3_selectColleft").innerHTML = GetLanguageDesc("s0c56");
    }
}

function CancelConfigTime()
{
    setCheck('dstEnabled', TimeInfo.DstUsed);
    if (IsSonetNewNormalUser() == true) {
        $("#dstConfigDetail").css("display", "none");
    } else {
        if (TimeInfo.DstUsed == '1') {
            setDisplay('dstConfigDetail', 1);
        } else {
            setDisplay('dstConfigDetail', 0);
        }
    }
    LoadFrameDSTtime(TimeInfo.StartDate_EX, 1);
    LoadFrameDSTtime(TimeInfo.EndDate_EX, 0);
}

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
var sntpConfigFormList = new Array();
var sntpConfigDetailList = new Array();
var dstConfigFormList = new Array();
var dstConfigDetailList = new Array();
var arrMonBindText = ["s0c1b","s0c1c","s0c1d","s0c1e","s0c1f","s0c20","s0c21","s0c22","s0c23","s0c24","s0c25","s0c26"];
var arrWeeksBindText = ["s0c27","s0c28","s0c29","s0c2a","s0c2b"];
var arrWeekdayBindText = ["s0c2c","s0c2d","s0c2e","s0c2f","s0c30","s0c31","s0c32"];

function genSelectOption(selectId, startValue, endValue, bindTextArray)
{
    var cnt=0;
    var select = document.getElementById(selectId);
    for (var i = startValue; i <= endValue; i++, cnt++)
    {
        var opt = document.createElement('option');
        var txt;
        opt.value = i;
        if (bindTextArray != null)
            txt = document.createTextNode(GetLanguageDesc(bindTextArray[cnt]));
        else
            txt = document.createTextNode(i);
        opt.appendChild(txt);
        select.appendChild(opt);
    }
}

function genNtpServerList(list)
{
    var select = document.getElementById(list);
    var txt = "ntpServerOther" + list.substr(list.length - 1, 1);

    if (curLanguage == "spanish")
    {
        ntpServers[0] = 'Ninguno';
        ntpServers[9] = 'Otro';
    }
    for (var i in ntpServers)
    {
        var opt = document.createElement('option');
        var html = document.createTextNode(ntpServers[i]);
        opt.value = ntpServers[i];
        opt.appendChild(html);
        select.appendChild(opt);
    }

    var txtattr = new Array(new stElementAttr('size',      '20'),
                            new stElementAttr('maxLength', '63'));
    setElementAttr(txt, txtattr);
}

function genNtpTimezone(zone)
{
    var html;
    var select = document.getElementById(zone);
    for (var i in timeZonesEng)
    {
        var opt = document.createElement('option');
        if (curLanguage == 'russian') {
            html = document.createTextNode(timeZonesRus[i]);
        } else if (curLanguage == 'brasil') {
            html = document.createTextNode(timeZonesBra[i]);
        } else if (curLanguage == 'turkish') {
            html = document.createTextNode(timeZonesTurk[i]);
        } else {
            html = document.createTextNode(timeZonesEng[i]);
        }
        opt.value = timeZonesEng[i];
        opt.appendChild(html);
        select.appendChild(opt);
    }
}

function RosSetDisable() {
    if (CfgMode.toUpperCase() == 'ROSUNION' && curUserType != '0') {
        setDisable("ntpEnabled", 1);
        setDisable("ntpServer1", 1);
        setDisable("ntpServer2", 1);
        setDisable("ntpServer3", 1);
        setDisable("ntpServer4", 1);
        setDisable("ntpServerOther1", 1);
        setDisable("ntpServerOther2", 1);
        setDisable("ntpServerOther3", 1);
        setDisable("ntpServerOther4", 1);
        
        setDisable("cboTimeZone", 1);
        setDisable("XHWSynInterval", 1);
        setDisable("WanName", 1);
        setDisable("btnApply2", 1);
        setDisable("cancelValue2", 1);
        
        setDisable("dstEnabled", 1);
        setDisable("month1", 1);
        setDisable("weeks1", 1);
        setDisable("weekday1", 1);
        setDisable("hours1", 1);
        setDisable("minute1", 1);
        setDisable("second1", 1);
        
        setDisable("month2", 1);
        setDisable("weeks2", 1);
        setDisable("weekday2", 1);
        setDisable("hours2", 1);
        setDisable("minute2", 1);
        setDisable("second2", 1);
        
        setDisable("btnApply", 1);
        setDisable("cancelValue1", 1);
    }
}

function stElementAttr(name, value)
{
    this.name = name;
    this.value = value;
}
function setElementAttr(id, attrList)
{
    var element = document.getElementById(id);

    if (element == null) return;
    if (attrList == null) return;

    for (var i in attrList)
        element.setAttribute(attrList[i].name, attrList[i].value);
}
</script>
</head>
<body onLoad="LoadFrame();" onUnload="stopTimeout();" class="mainbody">
    <script language="JavaScript" type="text/javascript">
    if (SmartFlag == 1)
    {
        var SNTPSummaryArray = new Array(new stSummaryInfo("text", GetDescFormArrayById(SntpLgeDes, "s0c0f")),
                                         new stSummaryInfo("img", "../../../images/icon_01.gif", GetDescFormArrayById(SntpLgeDes, "s0c54")),
                                         new stSummaryInfo("text", GetDescFormArrayById(SntpLgeDes, "s0c55")),
                                         null);
        HWCreatePageHeadInfo("ntpinfo", GetDescFormArrayById(SntpLgeDes, "s0c49"), SNTPSummaryArray, true);
    }
    else
    {
        HWCreatePageHeadInfo("ntpinfo", GetDescFormArrayById(SntpLgeDes, "s0c49"), GetDescFormArrayById(SntpLgeDes, "s0c0f"), false);
    }
    </script>
    <div class="title_spread"></div>

    <div id="sntpConfigDiv">
        <form id="sntpConfig">
            <table id="sntpConfigTable" cellpadding="0" cellspacing="0" width="100%">
                <li id="ntpEnabled" RealType="CheckBox" DescRef="s0c10" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty"  ClickFuncApp="onClick=ShowNtpConfig"/>
            </table>
            <script language="JavaScript" type="text/javascript">
                sntpConfigFormList = HWGetLiIdListByForm("sntpConfig", null);
                var formid_hide_id = null;
                HWParsePageControlByID("sntpConfig", TableClass, SntpLgeDes, formid_hide_id);
            </script>
        </form>
    </div>
    <div id="ntpConfigDetail" name="ntpConfigDetail" class="z_index_2" style="display:none;">
        <form id="sntpConfigDetail">
            <table id="sntpConfigDetailTable"  cellpadding="0" cellspacing="0" width="100%">
                <script>
                    if (DBAA1 == '1') {
                        
                        document.write('<li id="SyncServer" RealType="HtmlText" DescRef="s0c58" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.SyncServer"/>');
                    }
                </script>
                <li id="ntpServer1_select" RealType="SmartBoxList" DescRef="s0c11" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NTPServer1"        
                    InitValue="[{Item:[{AttrName:'id', AttrValue:'ntpServerOther1'},{AttrName:'type', AttrValue:'text'}]}]" ClickFuncApp="onChange=ntpChange"/>
                <li id="ntpServer2_select" RealType="SmartBoxList" DescRef="s0c12" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NTPServer2"        
                    InitValue="[{Item:[{AttrName:'id', AttrValue:'ntpServerOther2'},{AttrName:'type', AttrValue:'text'}]}]" ClickFuncApp="onChange=ntpChange"/>
                <li id="ntpServer3_select" RealType="SmartBoxList" DescRef="s0c52" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NTPServer3"        
                    InitValue="[{Item:[{AttrName:'id', AttrValue:'ntpServerOther3'},{AttrName:'type', AttrValue:'text'}]}]" ClickFuncApp="onChange=ntpChange"/>
                <li id="ntpServer4_select" RealType="SmartBoxList" DescRef="s0c53" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NTPServer4"        
                    InitValue="[{Item:[{AttrName:'id', AttrValue:'ntpServerOther4'},{AttrName:'type', AttrValue:'text'}]}]" ClickFuncApp="onChange=ntpChange"/>
                <li id="cboTimeZone"       RealType="DropDownList" DescRef="s0c13" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.LocalTimeZoneName" InitValue="Empty" />
                <li id="XHWSynInterval"    RealType="TextBox"      DescRef="s0c14" RemarkRef="s0c15" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_SynInterval"  InitValue="Empty"/>
                <script>
                    if (1 == sntpinterfaceflag)
                    {
                        document.write('<li id="WanName"           RealType="DropDownList" DescRef="s0c16" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_Interfaces"      InitValue="Empty" Elementclass="sntpselectdefcss"/>');
                    }
                    else
                    {
                        document.write('<li id="WanName"           RealType="DropDownList" DescRef="s0c16" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_WanName"      InitValue="Empty" Elementclass="sntpselectdefcss"/>');
                    }
                </script>
            </table>
            <script>
                sntpConfigDetailList = HWGetLiIdListByForm("sntpConfigDetail", null);
                if (TalkTalkFlag == "1")
                {
                    SntpReload[0].ReloadValue[0].display = 1;
                }
                var formid_hide_id = null;
                HWParsePageControlByID("sntpConfigDetail", TableClass, SntpLgeDes, SntpReload);

                genNtpServerList('ntpServer1');
                genNtpServerList('ntpServer2');
                if (MngtTelmex == 1)
                {
                    genNtpServerList('ntpServer3');
                    genNtpServerList('ntpServer4');
                }
                else if (TalkTalkFlag =="1" || DBAA1 == '1')
                {
                    genNtpServerList('ntpServer3');
                }
                genNtpTimezone('cboTimeZone');
                if (1 == sntpinterfaceflag)
                {
                    InitWanNameListControl_if("WanName", IsRouteWan);
                }
                else
                {
                    InitWanNameListControl("WanName", IsRouteWan);
                }
                var cboTimeZone = new Array(new stElementAttr("size",      '1'),
                                            new stElementAttr("maxlength", '20'));
                setElementAttr('cboTimeZone', cboTimeZone);
                var intval = new Array(new stElementAttr("maxlength", '9'),
                                       new stElementAttr("size",      '26'));
                setElementAttr('XHWSynInterval', intval);
                var WanName = new Array(new stElementAttr("size",      '1'),
                                        new stElementAttr("maxlength", '20'));
                setElementAttr('WanName', WanName);

                if (curAPType == 1) {
                    setDisplay('WanNameRow', 0);
                }
                if (DBAA1 == '1') {
                    document.getElementById("ntpServer2").disabled = false;
                    document.getElementById("ntpServer3").disabled = false;
                }

            </script>
        </form>
    </div>
    <table id="sntpsubmit" cellpadding="0" cellspacing="0"  width="100%" class="table_button">
        <tr>
            <td class='width_per30'></td>
            <td class="table_submit">
                <input type="button" name="btnApply2"    id="btnApply2"    class="ApplyButtoncss buttonwidth_100px"  BindText="s0c17" onClick="SubmitForm();">
                <input type="button" name="cancelValue2" id="cancelValue2" class="CancleButtonCss buttonwidth_100px" BindText="s0c18" onClick="CancelConfigServer();">
                <input type="hidden" name="onttoken"     id="hwonttoken"   value="<%HW_WEB_GetToken();%>">
            </td>
        </tr>
    </table>

    <div class="func_spread"></div>
    <div id="dstConfigDiv" style="display:none;">
        <form id="dstConfig">
            <table id="dstConfigTable" cellpadding="0" cellspacing="1" width="100%">
                <li id="dstEnabled" RealType="CheckBox" DescRef="s0c19" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="y.DaylightSavingsUsed" InitValue="Empty" ClickFuncApp="onClick=ShowDstConfig"/>
            </table>
            <script language="JavaScript" type="text/javascript">
                dstConfigFormList = HWGetLiIdListByForm("dstConfig", null);
                var formid_hide_id = null;
                HWParsePageControlByID("dstConfig", TableClass, SntpLgeDes, formid_hide_id);
            </script>
        </form>
    </div>
    <div id="dstConfigDetail" name="dstConfigDetail" class="z_index_2" style="display:none;">
        <table class="tabal_noborder_bg" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="table_title per_25_35" BindText='s0c1a'></td>
            </tr>
        </table>
        <table class="tabal_noborder_bg" width="100%" cellpadding="0" cellspacing="1">
            <tr>
                <td class="table_right">
                    <select name='month1' id='month1' size="1"></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('month1', 1, 12, arrMonBindText);
						if(CfgMode == "TOTALPLAY" || CfgMode == "TOTALPLAY2") {
							document.getElementById('month1').setAttribute("disabled","true")
						}
                    </script>
                </td>
                <td class="table_right">
                    <select name='weeks1' id='weeks1' size="1" ></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('weeks1', 1, 5, arrWeeksBindText);
						if(CfgMode == "TOTALPLAY" || CfgMode == "TOTALPLAY2") {
							document.getElementById('weeks1').setAttribute("disabled","true")
						}
                    </script>
                </td>
                <td class="table_right">
                    <select name='weekday1' id="weekday1" size="1"></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('weekday1', 1, 7, arrWeekdayBindText);
						if(CfgMode == "TOTALPLAY" || CfgMode == "TOTALPLAY2") {
							document.getElementById('weekday1').setAttribute("disabled","true")
						}
                    </script>
                </td>
                <td class="table_right">
                    <span BindText='s0c33'></span>
                    <select name='hours1' id="hours1" size="1"></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('hours1', 0, 23);
						if(CfgMode == "TOTALPLAY" || CfgMode == "TOTALPLAY2") {
							document.getElementById('hours1').setAttribute("disabled","true")
						}
                    </script>
                    <span BindText='s0c34'></span>
                </td>
                <td class="table_right">
                    <span BindText='s0c35'></span>
                    <select name='minute1' id="minute1" size="1" ></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('minute1', 0, 59);
						if(CfgMode == "TOTALPLAY" || CfgMode == "TOTALPLAY2") {
							document.getElementById('minute1').setAttribute("disabled","true")
						}
                    </script>
                    <span BindText='s0c36'></span>
                </td>
                <td class="table_right">
                    <span BindText='s0c37'></span>
                    <select name='second1' id="second1" size="1" ></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('second1', 0, 59);
						if(CfgMode == "TOTALPLAY" || CfgMode == "TOTALPLAY2") {
							document.getElementById('second1').setAttribute("disabled","true")
						}
                    </script>
                    <span BindText='s0c38'></span>
                </td>
            </tr>
        </table>
        <table class="tabal_noborder_bg" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr >
                <td class="table_title per_25_35" BindText='s0c39'></td>
            </tr>
        </table>
        <table class="tabal_noborder_bg" width="100%" cellpadding="0" cellspacing="1">
            <tr>
                <td class="table_right">
                    <select name='month2' id='month2' size="1"></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('month2', 1, 12, arrMonBindText);
                    </script>
                </td>
                <td class="table_right">
                    <select name='weeks2' id='weeks2' size="1" ></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('weeks2', 1, 5, arrWeeksBindText);
                    </script>
                </td>
                <td class="table_right">
                    <select name='weekday2' id="weekday2" size="1"></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('weekday2', 1, 7, arrWeekdayBindText);
                    </script>
                </td>
                <td class="table_right">
                    <span BindText='s0c33'></span>
                    <select name='hours2' id="hours2" size="1"></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('hours2', 0, 23);
                    </script>
                    <span BindText='s0c34'></span>
                </td>
                <td class="table_right">
                    <span BindText='s0c35'></span>
                    <select name='minute2' id="minute2" size="1" ></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('minute2', 0, 59);
                    </script>
                    <span BindText='s0c36'></span>
                </td>
                <td class="table_right">
                    <span BindText='s0c37'></span>
                    <select name='second2' id="second2" size="1" ></select>
                    <script language="JavaScript" type="text/javascript">
                        genSelectOption('second2', 0, 59);
                    </script>
                    <span BindText='s0c38'></span>
                </td>
            </tr>
        </table>
    </div>
    <table  cellpadding="0" cellspacing="0" width="100%" class="table_button" id="dstconfigbutton" style="display:none;">
        <tr>
            <td class="width_per30"></td>
            <td class="table_submit">
                <input type="button" name="btnApply"     id="btnApply"     class="ApplyButtoncss buttonwidth_100px"  BindText="s0c17" onClick="SubmitDSTForm();" />
                <input type="button" name="cancelValue1" id="cancelValue1" class="CancleButtonCss buttonwidth_100px" BindText="s0c18" onClick="CancelConfigTime();" />
            </td>
        </tr>
    </table>

    <div class="func_spread"></div>
    <div id="ntpDisplay" name="ntpDisplay" class="" style="z-index:2" >
        <table class="tabal_noborder_bg"  cellpadding="0" cellspacing="1" width="100%">
            <tr>
                <td class="table_title width_per30" BindText="s0c40"></td>
                <td class="table_right width_per70"><input type='text' name='curtime' id='curtime' size="32" readonly="readonly" /></td>
            </tr>
        </table>
    </div>
    <script>
        ParseBindTextByTagName(SntpLgeDes, "td",     1);
        ParseBindTextByTagName(SntpLgeDes, "span",   1);
        ParseBindTextByTagName(SntpLgeDes, "input",  2);
        if (IsSonetNewNormalUser() == true) {
            setDisplay('dstConfigDiv', 0);
            setDisplay('dstconfigbutton', 0);
        } else {
            setDisplay('dstConfigDiv', 1);
            setDisplay('dstconfigbutton', 1);
        }
    </script>
</body>
<div class="func_spread"></div>
<div class="func_spread"></div>
<div class="func_spread"></div>
</html>

