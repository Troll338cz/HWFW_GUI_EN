<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
  <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
  <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <style>
    .tableclasscenter_num {
      text-align: center;
      width: 4%;
    }

    .tableclasscenter {
      text-align: center;
      width: 16%;
    }

    .tabletextcenter {
      text-align: center;
    }
  </style>
  <script language="JavaScript" type="text/javascript">
    var IsAcsSupport = '<%HW_WEB_GetFeatureSupport(FT_SSMP_IACCESS_ACS_SUPPORT);%>';
    var Is2ndPlatSupport = '<%HW_WEB_GetFeatureSupport(FT_IACCESS_SUPPORT_SECONDPLAT);%>';
    var IsGXCT = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GXCT);%>';
    var jiuzhouFlag = '<%WEB_GetJiuZhouFlag();%>';

    function monitorIaccess(domain, Enable, ReportEnable, SecPlatEnable, SecPlatStatus) {
      this.domain = domain;
      this.Enable = Enable;
      this.ReportEnable = ReportEnable;
      this.SecPlatEnable = SecPlatEnable;
      this.SecPlatStatus = SecPlatStatus;
    }

    function stMonitorDevInfo(domain, VendorID, OperatorID, ModelStr, SerialNum, WANMAC, DevMAC, Uplink, SoftVer, ProtocolVer, Long, Lat, Altitudes, AreaCode, HorizontalError, AltitudeError, GISLockTime, GISDigest, DeviceTime, ServerURI1, ServerURI2, RegID, UUID, LocalRepStatus, ReportPeriod, NextReport, PostPath2, TaskExePeriod, SpeedTest2, PostPath, SpeedTest1, TraceDomain, TimeDomain) {
      this.domain = domain;
      this.VendorID = VendorID;
      this.OperatorID = OperatorID;
      this.ModelStr = ModelStr;
      this.SerialNum = SerialNum;
      this.WANMAC = WANMAC;
      this.DevMAC = DevMAC;
      this.Uplink = Uplink;
      this.SoftVer = SoftVer
      this.ProtocolVer = ProtocolVer;
      this.Long = Long;
      this.Lat = Lat;
      this.Altitudes = Altitudes;
      this.AreaCode = AreaCode;
      this.HorizontalError = HorizontalError;
      this.AltitudeError = AltitudeError;
      this.GISLockTime = GISLockTime;
      this.GISDigest = GISDigest;
      this.DeviceTime = DeviceTime;
      this.ServerURI1 = ServerURI1;
      this.ServerURI2 = ServerURI2;
      this.RegID = RegID;
      this.UUID = UUID;
      this.LocalRepStatus = LocalRepStatus;
      this.ReportPeriod = ReportPeriod;
      this.NextReport = NextReport;
      this.PostPath2 = PostPath2;
      this.TaskExePeriod = TaskExePeriod;
      this.SpeedTest2 = SpeedTest2;
      this.PostPath = PostPath;
      this.SpeedTest1 = SpeedTest1;
      this.TraceDomain = TraceDomain;
      this.TimeDomain = TimeDomain;
    }
    function stMonitorDevInfoEx(domain, ServerURI1, ServerURI2, LocalRepAStatus, LocalRepBStatus) {
      this.domain = domain;
      this.ServerURI1 = ServerURI1;
      this.ServerURI2 = ServerURI2;
      this.LocalRepAStatus = LocalRepAStatus;
      this.LocalRepBStatus = LocalRepBStatus;
    }
    function stTimeInfo(domain, Enable, ntp1, ntp2, ntp3, ntp4, ntp5, ZoneName, SynInterval, WanName, ExportCfgMode, ExportType, DstUsed, StartDate, EndDate, StartDate_EX, EndDate_EX) {
      this.domain = domain;
      this.Enable = Enable;
      this.ntp1 = ntp1;
      this.ntp2 = ntp2;
      this.ntp3 = ntp3;
      this.ntp4 = ntp4;
      this.ntp5 = ntp5;
      this.ZoneName = ZoneName;
      this.SynInterval = SynInterval;
      this.WanName = WanName;
      this.DstUsed = DstUsed;
      this.StartDate = StartDate;
      this.EndDate = EndDate;
      this.StartDate_EX = StartDate_EX;
      this.EndDate_EX = EndDate_EX;
      this.ExportCfgMode = ExportCfgMode;
      this.ExportType = ExportType;
    }

    function stMonitorCounterInfo(domain, PendingTask, SuccessTask, FailTask, ExpireTask, FailInform, SuccessInform, FailResult, SuccessResult) {
      this.domain = domain;
      this.PendingTask = PendingTask;
      this.SuccessTask = SuccessTask;
      this.FailTask = FailTask;
      this.ExpireTask = ExpireTask;
      this.FailInform = FailInform
      this.SuccessInform = SuccessInform;
      this.FailResult = FailResult
      this.SuccessResult = SuccessResult;
    }

    function stMonitorTaskInfo(domain, RPCID, TaskObject, TaskID, PlanedTime, MaxAge, Params) {
      this.domain = domain;
      this.RPCID = RPCID;
      this.TaskObject = TaskObject;
      this.TaskID = TaskID;
      this.PlanedTime = PlanedTime;
      this.MaxAge = MaxAge;
      this.Params = Params;
    }

    function stResultInfo(domain, speedtest, traceroute) {
      this.domain = domain;
      this.speedtest = speedtest;
      this.traceroute = traceroute;
    }

    function stPositionInfo(domain, Long, Lat, Altitudes, HorizontalError, VerticalError, GISInterface, AreaCode, GISLockTime, GISDigest, LocalRepStatus) {
      this.domain = domain;
      this.Long = Long;
      this.Lat = Lat;
      this.Altitudes = Altitudes;
      this.HorizontalError = HorizontalError;
      this.VerticalError = VerticalError;
      this.GISInterface = GISInterface;
      this.AreaCode = AreaCode;
      this.GISLockTime = GISLockTime;
      this.GISDigest = GISDigest;
      this.LocalRepStatus = LocalRepStatus;
    }
    var MonitorIaccessinfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_iaccess,Enable|ReportEnable|SecPlatEnable|SecPlatStatus,monitorIaccess);%>;

    var platEnable = MonitorIaccessinfos[0].SecPlatEnable;
    var platStatus = MonitorIaccessinfos[0].SecPlatStatus;

    var PositionAInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.GISInfoA,Long|Lat|Altitudes|HorizontalError|VerticalError|GISInterface|AreaCode|GISLockTime|GISDigest|LocalRepStatus,stPositionInfo);%>;
    var PositionBInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.GISInfoB,Long|Lat|Altitudes|HorizontalError|VerticalError|GISInterface|AreaCode|GISLockTime|GISDigest|LocalRepStatus,stPositionInfo);%>;

    var TimeInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Time,Enable|NTPServer1|NTPServer2|NTPServer3|NTPServer4|NTPServer5|LocalTimeZoneName|X_HW_SynInterval|X_HW_WanName|X_HW_ExportCfgMode|X_HW_ExportType|DaylightSavingsUsed|DaylightSavingsStart|DaylightSavingsEnd|X_HW_DaylightSavingsStartDate|X_HW_DaylightSavingsEndDate,stTimeInfo);%>;

    if (null == PositionAInfos || null == PositionAInfos[0]) {
      PositionAInfos = new Array(new stPositionInfo("InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.GISInfoA", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--"), null);
    }

    if (null == PositionBInfos || null == PositionBInfos[0]) {
      PositionBInfos = new Array(new stPositionInfo("InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.GISInfoA", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--"), null);
    }

    var MonitorDevInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.DeviceInfo,VendorID|OperatorID|ModelStr|SerialNum|WANMAC|DevMAC|Uplink|SoftVer|ProtocolVer|Long|Lat|Altitudes|AreaCode|HorizontalError|AltitudeError|GISLockTime|GISDigest|DeviceTime|ServerURI1|ServerURI2|RegID|UUID|LocalRepStatus|ReportPeriod|NextReport|PostPath2|TaskExePeriod|SpeedTest2|PostPath|SpeedTest1|TraceDomain|TraceDomain,stMonitorDevInfo);%>;

    if (null == MonitorDevInfos || null == MonitorDevInfos[0]) {
      MonitorDevInfos = new Array(new stMonitorDevInfo("InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.DeviceInfo", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--", "--"), null);
    }

    var MonitorDevInfoExs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.DeviceInfoEx,ServerURI1|ServerURI2|LocalRepAStatus|LocalRepBStatus,stMonitorDevInfoEx);%>;
    if (null == MonitorDevInfoExs || null == MonitorDevInfoExs[0]) {
      MonitorDevInfoExs = new Array(new stMonitorDevInfoEx("InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.DeviceInfoEx", "--", "--", "--", "--"), null);
    }
    var MonitorDevInfo = MonitorDevInfos[0];
    if (jiuzhouFlag == "1") {
      MonitorDevInfo.VendorID = "JZCT";
    }
    var MonitorDevInfoEx = MonitorDevInfoExs[0];
    var Timeinfo = TimeInfos[0];
    MonitorDevInfo.TimeDomain = Timeinfo.ntp3;
    var MonitorPositionAInfo = PositionAInfos[0];
    var MonitorPositionBInfo = PositionBInfos[0];

    if (1 == IsAcsSupport) {
      if (!isNaN(MonitorPositionAInfo.HorizontalError) && MonitorPositionAInfo.HorizontalError != '') {
        MonitorPositionAInfo.HorizontalError = parseInt(MonitorPositionAInfo.HorizontalError);
      }

      if (!isNaN(MonitorPositionAInfo.VerticalError) && MonitorPositionAInfo.VerticalError != '') {
        MonitorPositionAInfo.VerticalError = parseInt(MonitorPositionAInfo.VerticalError);
      }

      if (!isNaN(MonitorPositionAInfo.Altitudes) && MonitorPositionAInfo.Altitudes != '') {
        MonitorPositionAInfo.Altitudes = parseInt(MonitorPositionAInfo.Altitudes);
      }

      if (!isNaN(MonitorPositionBInfo.HorizontalError) && MonitorPositionBInfo.HorizontalError != '') {
        MonitorPositionBInfo.HorizontalError = parseInt(MonitorPositionBInfo.HorizontalError);
      }

      if (!isNaN(MonitorPositionBInfo.VerticalError) && MonitorPositionBInfo.VerticalError != '') {
        MonitorPositionBInfo.VerticalError = parseInt(MonitorPositionBInfo.VerticalError);
      }

      if (!isNaN(MonitorPositionBInfo.Altitudes) && MonitorPositionBInfo.Altitudes != '') {
        MonitorPositionBInfo.Altitudes = parseInt(MonitorPositionBInfo.Altitudes);
      }
    }

    function RespStatusToDesc(status) {
      var ReportInfo = "";
      switch (status) {
        case 0:
          ReportInfo = GXBMonitorDes["GXB030"];
          break;
        case 1:
          ReportInfo = GXBMonitorDes["GXB031"];
          break;
        case 2:
          ReportInfo = GXBMonitorDes["GXB032"];
          break;
        case 3:
          ReportInfo = GXBMonitorDes["GXB033"];
          break;
        case 4:
          ReportInfo = GXBMonitorDes["GXB034"];
          break;
        case 5:
          ReportInfo = GXBMonitorDes["GXB035"];
          break;
        case 6:
          ReportInfo = GXBMonitorDes["GXB036"];
          break;
        case 7:
          ReportInfo = GXBMonitorDes["GXB037"];
          break;
        default:
          ReportInfo = GXBMonitorDes["GXB030"];
          break;
      }
      return ReportInfo;
    }

    MonitorDevInfo.LocalRepStatus = RespStatusToDesc(parseInt(MonitorDevInfo.LocalRepStatus));
    MonitorPositionAInfo.LocalRepStatus = RespStatusToDesc(parseInt(MonitorPositionAInfo.LocalRepStatus));
    MonitorPositionBInfo.LocalRepStatus = RespStatusToDesc(parseInt(MonitorPositionBInfo.LocalRepStatus));

    MonitorDevInfoEx.LocalRepAStatus = RespStatusToDesc(parseInt(MonitorDevInfoEx.LocalRepAStatus));
    MonitorDevInfoEx.LocalRepBStatus = RespStatusToDesc(parseInt(MonitorDevInfoEx.LocalRepBStatus));

    var URIConfigFormList = new Array();

    var ArrayCounterInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.Counter,PendingTask|SuccessTask|FailTask|ExpireTask|FailInform|SuccessInform|FailResult|SuccessResult,stMonitorCounterInfo);%>;

    if (null == ArrayCounterInfos || null == ArrayCounterInfos[0]) {
      ArrayCounterInfos = new Array(new stMonitorCounterInfo("InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.Counter", "", "", "", "", "", "", "", ""), null);
    }

    var CounterInfo = ArrayCounterInfos[0];

    var ArrayTaskInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.TaskInfo.{i},RPCID|TaskObject|TaskID|PlanedTime|MaxAge|Params,stMonitorTaskInfo);%>;
    var TaskInfo = ArrayTaskInfos[1];
    var sysUserType = '0';
    var curUserType = '<%HW_WEB_GetUserType();%>';

    var ResultInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.X_HW_GXB.LastTaskResult,SpeedTestResult|TraceRouteResult,stResultInfo);%>;


    function LoadFrame() {
      setSelect("platType_select", platEnable)
      if (platStatus == 1) {
        document.getElementById('BucpePlatStatus').innerHTML = GetLanguageDesc("GXB102");
      } else {
        document.getElementById('BucpePlatStatus').innerHTML = GetLanguageDesc("GXB103");
      }
      SubmitForm(platEnable);

      if (platStatus == '1') {
        setDisplay("DivBucpe2ndPlatInfoGap", 1);
        setDisplay("DivBucpe2ndPlatInfo", 1);
        setDisplay("Bucpe2ndPlatInfoForm", 1);
      }

      if ('1' == IsGXCT && curUserType == sysUserType) {
        setDisplay("SpeedTest", 1);
        var timestr = TaskInfo.PlanedTime;
        if (timestr.length == 14) {
          setText('StartHour', timestr.substr(8, 2));
          setText('StartMinute', timestr.substr(10, 2));
        }
        else {
          setText('StartHour', '');
          setText('StartMinute', '');
        }

        if (GetDateTimeDiff() > 0) {
          if (GetDateTimeDiff() / 60 >= 5) {
            setDisable("btnStartSpeedTest", "0");
          }
          else {
            setDisable("btnStartSpeedTest", "1");
          }
        }
        else {
          setDisable("btnStartSpeedTest", "0");
        }
      }
    }

    function GetPageTitleInfo() {
      var IndexNum = (curUserType == sysUserType) ? "GXB001" : "GXB001a";
      if ('1' == IsGXCT && curUserType == sysUserType) {
        IndexNum = "GXB001b";
      }
      return GetDescFormArrayById(GXBMonitorDes, IndexNum);

    }

    function ChangeSpaceValueToLine(InputArray, ElementList) {
      for (var index = 0; index < ElementList.length; index++) {
        var ElementId = ElementList[index];

        if (null != InputArray[ElementId] && undefined != InputArray[ElementId] && "" == InputArray[ElementId].toString()) {
          InputArray[ElementId] = '--'
        }
      }
    }

    function ChangeSpaceValueToLineBySuifix(InputArray, ElementList, suifixStr) {
      for (var index = 0; index < ElementList.length; index++) {
        try {
          var ElementId = ElementList[index].split(suifixStr)[0];

          if (null != InputArray[ElementId] && undefined != InputArray[ElementId] && "" == InputArray[ElementId].toString()) {
            InputArray[ElementId] = '--'
          }
        } catch (e) {
          ;
        }
      }
    }

    function checkUrlPort(urlinfo) {
      var url_values = urlinfo.split("://");

      if (url_values.length <= 1) {
        var port_value = urlinfo.split(":");

        if (port_value.length <= 1) {
          return true;
        }
        else {
          var othervalue = port_value[port_value.length - 1].split("/");

          if (othervalue.length == 0) {
            return true;
          }

          if (true == isNull(othervalue[0])) {
            return false;
          }

          if (false == isNum(othervalue[0])) {
            return false;
          }

          var port = parseInt(othervalue[0], 10);
          if ((port >= 65536) || (port < 1)) {
            return false;
          }
          return true;
        }
      }
      else {
        var port_value = url_values[url_values.length - 1].split(":");
        if (port_value.length <= 1) {
          return true;
        }

        var othervalue = port_value[port_value.length - 1].split("/");
        if (othervalue.length == 0) {
          return true;
        }

        if (true == isNull(othervalue[0])) {
          return false;
        }

        if (false == isNum(othervalue[0])) {
          return false;
        }

        var port = parseInt(othervalue[0], 10);
        if ((port >= 65536) || (port < 1)) {
          return false;
        }
      }

      return true;
    }


    function CheckURIPara(URIValue, index) {
      var URIDes = (index == 1) ? "主服务器地址" : "备服务器地址";
      if (URIValue == '') {
        AlertEx(GetDescFormArrayById(GXBMonitorDes, "GXB065"));
        return false;
      }

      if (!isSafeStringSN(URIValue)) {
        AlertEx(URIDes + GetDescFormArrayById(GXBMonitorDes, "GXB066"));
        return false;
      }

      if (!checkUrlPort(URIValue)) {
        AlertEx(URIDes + GetDescFormArrayById(GXBMonitorDes, "GXB067"));
        return false;
      }

      if ('' != isValidAscii(URIValue)) {
        AlertEx(URIDes + GetDescFormArrayById(GXBMonitorDes, "GXB068"));
        return false;
      }
    }

    function selectLine(idindex) {
    }

    function GetLanguageDesc(Name) {
      return GXBMonitorDes[Name];
    }

    function isDecDigit(digit) {
      var decVals = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
      var len = decVals.length;
      var i = 0;
      var ret = false;

      for (i = 0; i < len; i++)
        if (digit == decVals[i]) break;

      if (i < len)
        ret = true;
      return ret;
    }

    function GetDateTimeDiff() {
      startgxbtime = getCookie('startgxbtime');
      if (startgxbtime == null || startgxbtime == "") {
        return '0';
      }
      var CurrentTime = new Date();
      var PrevTime = new Date(getCookie("startgxbtime"));
      return parseInt((CurrentTime.getTime() - PrevTime.getTime()) / 1000);
    }

    function isValidNumber(number) {
      var numberLen = number.length;
      if (numberLen != 2 && numberLen != 1) {
        return false;
      }
      for (var i = 0; i < numberLen; i++) {
        if (!isDecDigit(number.charAt(i))) {
          return false;
        }
      }
      return true;
    }

    function isValidHour(val) {
      if ((isValidNumber(val) == true) && (parseInt(val, 10) < 24)) {
        return true;
      }
      return false;
    }

    function isValidMinute(val) {
      if ((isValidNumber(val) == true) && (parseInt(val, 10) < 60)) {
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

    function getFullMonth(month) {
      var fullMonth = month + 1;
      var strMonth = fullMonth.toString();
      if (strMonth.length == 1) {
        strMonth = '0' + strMonth;
      }
      return strMonth;
    }

    function CheckParameter() {
      var strStartHour = getValue('StartHour');
      var strStartMin = getValue('StartMinute');

      if (isValidNumber(strStartHour)) {
        strStartHour = parseTime(strStartHour);
      }

      if (isValidNumber(strStartMin)) {
        strStartMin = parseTime(strStartMin);
      }

      if (!isValidNumber(strStartHour) || !isValidNumber(strStartMin)) {
        AlertEx(GetLanguageDesc("GXB098"));
        return false;
      }

      if (!isValidHour(strStartHour)) {
        AlertEx(GetLanguageDesc("GXB099"));
        return false;
      }

      if (!isValidMinute(strStartMin)) {
        AlertEx(GetLanguageDesc("GXB100"));
        return false;
      }

      return true;
    }

    function BeginSpeedTest() {
      var parainfo = "";
      parainfo = 'x.X_HW_Token=' + getValue('hwonttoken');

      $.ajax({
        type: "POST",
        async: true,
        cache: false,
        timeout: 4000,
        data: parainfo,
        url: '/StartGXBSpeedTest.cgi?' + '&RequestFile=html/ssmp/GXBMonitor/GXBMonitor.asp',
        success: function (data) {
        }
      });

      setCookie("startgxbtime", new Date());
      setDisable("btnStartSpeedTest", "1");
    }

    function parseTimeToInt(time) {
      var ret = time;
      if (time.length == 2) {
        if (time.charAt[0] == '0') {
          ret = time.substr(1);
        }
      }
      return ret;
    }

    function SaveTaskExeTime() {
      if (!CheckParameter()) {
        return false;
      }

      var StartHour = getValue('StartHour');
      var StartMin = getValue('StartMinute');
      var StartTimeStr = "";
      StartHour = parseTime(StartHour);
      StartMin = parseTime(StartMin);

      var CurrentTime = new Date();
      CurrentTime.setHours(parseTimeToInt(StartHour), parseTimeToInt(StartMin));
      var taskexeperiod = parseInt(MonitorDevInfo.TaskExePeriod);
      CurrentTime.setTime(CurrentTime.getTime() + (taskexeperiod * 60 * 60 * 1000));
      StartTimeStr = CurrentTime.getFullYear().toString() + getFullMonth(CurrentTime.getMonth()) + parseTime(CurrentTime.getDate()) + StartHour + StartMin + parseTime(CurrentTime.getSeconds());

      var parainfo = "";
      parainfo += "PlanedTime=" + StartTimeStr;
      parainfo += '&x.X_HW_Token=' + getValue('hwonttoken');

      $.ajax({
        type: "POST",
        async: true,
        cache: false,
        data: parainfo,
        url: 'SaveGXBReportTime.cgi?' + '&RequestFile=html/ssmp/GXBMonitor/GXBMonitor.asp',
        success: function (data) {
        }
      });

      window.location.href = "/html/ssmp/GXBMonitor/GXBMonitor.asp";
    }
    function SubmitForm(value) {
      if (value == 0) {
        document.getElementById('messageinfo').innerHTML = GetLanguageDesc("GXB104");
      } else if (value == 1) {
        document.getElementById('messageinfo').innerHTML = GetLanguageDesc("GXB105");
      } else if (value == 2) {
        document.getElementById('messageinfo').innerHTML = GetLanguageDesc("GXB106");
      }
      if (value == platEnable) {
        return;
      }

      var parainfo = "x.SecPlatEnable=" + value;
      parainfo += '&x.X_HW_Token=' + getValue('hwonttoken');
      $.ajax({
        type: "POST",
        async: true,
        cache: false,
        data: parainfo,
        url: 'set.cgi?x=InternetGatewayDevice.X_HW_iaccess' + '&RequestFile=html/ssmp/GXBMonitor/GXBMonitor.asp',
        success: function (data) {
          window.location.href = "/html/ssmp/GXBMonitor/GXBMonitor.asp";
        }
      });
    }
  </script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(GXBMonitorDes, "GXB000"), GetPageTitleInfo(), false);
  </script>

  <div class="title_spread"></div>
  <div id="DivDevInfo" class="func_title" BindText="GXB007"></div>
  <form id="DevInfoForm" name="DevInfoForm">
    <table id="deviceInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
      <li id="VendorID" RealType="HtmlText" DescRef="GXB008" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="VendorID" InitValue="Empty" />
      <li id="OperatorID" RealType="HtmlText" DescRef="GXB009" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="OperatorID" InitValue="Empty" />
      <li id="ModelStr" RealType="HtmlText" DescRef="GXB010" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="ModelStr" InitValue="Empty" />
      <li id="SerialNum" RealType="HtmlText" DescRef="GXB011" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SerialNum" InitValue="Empty" />
      <li id="WANMAC" RealType="HtmlText" DescRef="GXB012" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="WANMAC" InitValue="Empty" />
      <li id="DevMAC" RealType="HtmlText" DescRef="GXB013" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="DevMAC" InitValue="Empty" />
      <li id="Uplink" RealType="HtmlText" DescRef="GXB014" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Uplink" InitValue="Empty" />
      <li id="SoftVer" RealType="HtmlText" DescRef="GXB015" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SoftVer" InitValue="Empty" />
      <li id="ProtocolVer" RealType="HtmlText" DescRef="GXB016" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="ProtocolVer" InitValue="Empty" />
      <li id="DeviceTime" RealType="HtmlText" DescRef="GXB024" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="DeviceTime" InitValue="Empty" />
      <li id="RegID" RealType="HtmlText" DescRef="GXB027" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="RegID" InitValue="Empty" />
      <li id="UUID" RealType="HtmlText" DescRef="GXB028" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="UUID" InitValue="Empty" />
    </table>
    <script>
      var DevInfoTableClass = new stTableClass("width_per30 table_title", "width_per70 table_right align_left", "ltr");
      var deviceInfoFormList = new Array();
      deviceInfoFormList = HWGetLiIdListByForm("DevInfoForm", null);
      HWParsePageControlByID("DevInfoForm", DevInfoTableClass, GXBMonitorDes, null);
      var DevTableDataInfo = HWcloneObject(MonitorDevInfo, 1);
      ChangeSpaceValueToLine(DevTableDataInfo, deviceInfoFormList);
      HWSetTableByLiIdList(deviceInfoFormList, DevTableDataInfo, null);
      $("#TableDevInfoForm").attr("class", "table_bg");
    </script>
  </form>

  <div class="title_spread"></div>
  <div id="DivBucpeInfo" class="func_title" BindText="GXB069"></div>
  <form id="BucpeInfoForm" name="BucpeInfoForm">
    <table id="bucpeInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
      <li id="ShowServerURI1" RealType="HtmlText" DescRef="GXB070" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="ShowServerURI1" InitValue="Empty" />
      <li id="ShowServerURI2" RealType="HtmlText" DescRef="GXB071" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="ShowServerURI2" InitValue="Empty" />
      <li id="PostPath" RealType="HtmlText" DescRef="GXB072" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="PostPath" InitValue="Empty" />
      <li id="PostPath2" RealType="HtmlText" DescRef="GXB073" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="PostPath2" InitValue="Empty" />
      <li id="ReportPeriod" RealType="HtmlText" DescRef="GXB074" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="ReportPeriod" InitValue="Empty" />
      <li id="TaskExePeriod" RealType="HtmlText" DescRef="GXB075" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="TaskExePeriod" InitValue="Empty" />
      <li id="SpeedTest1" RealType="HtmlText" DescRef="GXB076" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SpeedTest1" InitValue="Empty" />
      <li id="SpeedTest2" RealType="HtmlText" DescRef="GXB077" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SpeedTest2" InitValue="Empty" />
      <li id="TraceDomain" RealType="HtmlText" DescRef="GXB078" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="TraceDomain" InitValue="Empty" />
      <li id="TimeDomain" RealType="HtmlText" DescRef="GXB079" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="TimeDomain" InitValue="Empty" />
    </table>
    <script>
      var DevInfoTableClass = new stTableClass("width_per30 table_title", "width_per70 table_right align_left", "ltr");
      var deviceInfoFormList = new Array();
      deviceInfoFormList = HWGetLiIdListByForm("BucpeInfoForm", null);
      HWParsePageControlByID("BucpeInfoForm", DevInfoTableClass, GXBMonitorDes, null);
      var DevTableDataInfo = HWcloneObject(MonitorDevInfo, 1);
      ChangeSpaceValueToLine(DevTableDataInfo, deviceInfoFormList);
      HWSetTableByLiIdList(deviceInfoFormList, DevTableDataInfo, null);
      document.getElementById('ShowServerURI1').innerHTML = ("" == htmlencode(MonitorDevInfo.ServerURI1)) ? "--" : htmlencode(MonitorDevInfo.ServerURI1);
      document.getElementById('ShowServerURI2').innerHTML = ("" == htmlencode(MonitorDevInfo.ServerURI2)) ? "--" : htmlencode(MonitorDevInfo.ServerURI2);
      $("#TableBucpeInfoForm").attr("class", "table_bg");
    </script>
  </form>

  <div id="DivBucpe2ndPlatInfoGap" class="title_spread"></div>
  <div id="DivBucpe2ndPlatInfo" class="func_title" BindText="GXB069A"></div>
  <table cellpadding="0" cellspacing="1" class="tabal_bg" width="100%">
    <tr align="left">
      <td width="30.2%" class="table_title" BindText="GXB107"></td>
      <td class="table_right">
        <select name="platType_select" id="platType_select" maxlength="20" style="width:55px;"
          onclick="SubmitForm(value);">
          <option value="0">关闭</option>
          <option value="1">开启</option>
          <option value="2">默认</option>
        </select>
        <span id="messageinfo" style="display:inline-block; text-indent:10px; color:#888"></span>
      </td>
    </tr>
  </table>
  <table cellpadding="0" cellspacing="1" class="tabal_bg" width="100%" style=" margin-top:-1px; margin-bottom:-1px;">
    <tr>
      <td class="table_title width_30p" style="width:30.2%;" BindText="GXB108"></td>
      <td class="table_right"> <span id="BucpePlatStatus"></span>
    </tr>
  </table>

  <div id="DivBucpe2ndPlatInfoGap" class="title_spread" style="display:none"></div>
  <div id="DivBucpe2ndPlatInfo" class="func_title" BindText="GXB069A" style="display:none"></div>
  <form id="Bucpe2ndPlatInfoForm" name="Bucpe2ndPlatInfoForm" style="display:none">
    <table id="bucpeInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
      <li id="PostPath2nd" RealType="HtmlText" DescRef="GXB072" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="PostPathEx" InitValue="Empty" />
      <li id="PostPath2nd2" RealType="HtmlText" DescRef="GXB073" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="PostPathEx2" InitValue="Empty" />
      <li id="LocalRepAStatus" RealType="HtmlText" DescRef="GXB080" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="LocalRepAStatus" InitValue="Empty" />
      <li id="LocalRepBStatus" RealType="HtmlText" DescRef="GXB081" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="LocalRepBStatus" InitValue="Empty" />
    </table>
    <script>
      var DevInfoExTableClass = new stTableClass("width_per30 table_title", "width_per70 table_right align_left", "ltr");
      var deviceInfoExFormList = new Array();
      deviceInfoExFormList = HWGetLiIdListByForm("Bucpe2ndPlatInfoForm", null);
      HWParsePageControlByID("Bucpe2ndPlatInfoForm", DevInfoExTableClass, GXBMonitorDes, null);
      var DevTableDataInfoEx = HWcloneObject(MonitorDevInfoEx, 1);
      ChangeSpaceValueToLine(DevTableDataInfoEx, deviceInfoExFormList);
      HWSetTableByLiIdList(deviceInfoExFormList, DevTableDataInfoEx, null);
      document.getElementById('PostPath2nd').innerHTML = ("" == htmlencode(MonitorDevInfoEx.ServerURI1)) ? "--" : htmlencode(MonitorDevInfoEx.ServerURI1);
      document.getElementById('PostPath2nd2').innerHTML = ("" == htmlencode(MonitorDevInfoEx.ServerURI2)) ? "--" : htmlencode(MonitorDevInfoEx.ServerURI2);
      document.getElementById('LocalRepAStatus').innerHTML = htmlencode(MonitorDevInfoEx.LocalRepAStatus);
      document.getElementById('LocalRepBStatus').innerHTML = htmlencode(MonitorDevInfoEx.LocalRepBStatus);
      $("#TableBucpe2ndPlatInfoForm").attr("class", "table_bg");
    </script>
  </form>


  <div class="title_spread"></div>
  <div id="PositionAInfo" class="func_title" BindText="GXB007A"></div>
  <form id="PositionAInfoForm" name="DevInfoForm">
    <table id="PositionAInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1"
      class="tabal_noborder_bg">
      <li id="LongSA" RealType="HtmlText" DescRef="GXB017" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Long.SA" InitValue="Empty" />
      <li id="LatSA" RealType="HtmlText" DescRef="GXB018" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Lat.SA" InitValue="Empty" />
      <li id="AltitudesSA" RealType="HtmlText" DescRef="GXB019" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Altitudes.SA" InitValue="Empty" />
      <li id="AreaCodeSA" RealType="HtmlText" DescRef="GXB020" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="AreaCode.SA" InitValue="Empty" />
      <li id="HorizontalErrorSA" RealType="HtmlText" DescRef="GXB021" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="HorizontalError.SA" InitValue="Empty" />
      <li id="VerticalErrorSA" RealType="HtmlText" DescRef="GXB021a" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="VerticalError.SA" InitValue="Empty" />
      <li id="GISLockTimeSA" RealType="HtmlText" DescRef="GXB022" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="GISLockTime.SA" InitValue="Empty" />
      <li id="GISDigestSA" RealType="HtmlText" DescRef="GXB023" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="GISDigest.SA" InitValue="Empty" />
      <li id="LocalRepStatusSA" RealType="HtmlText" DescRef="GXB029" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="LocalRepStatus.SA" InitValue="Empty" />

    </table>
    <script>
      var DevInfoTableClass = new stTableClass("width_per30 table_title", "width_per70 table_right align_left", "ltr");
      var PositionAInfoList = new Array();
      PositionAInfoList = HWGetLiIdListByForm("PositionAInfoForm", null);
      HWParsePageControlByID("PositionAInfoForm", DevInfoTableClass, GXBMonitorDes, null);
      var PositionATableDataInfo = HWcloneObject(MonitorPositionAInfo, 1);
      ChangeSpaceValueToLineBySuifix(PositionATableDataInfo, PositionAInfoList, "SA");
      HWSetTableByLiIdList(PositionAInfoList, PositionATableDataInfo, null, ".SA");
      $("#TablePositionAInfoForm").attr("class", "table_bg");
    </script>
  </form>

  <div class="title_spread"></div>
  <div id="PositionBInfo" class="func_title" BindText="GXB007B"></div>
  <form id="PositionBInfoForm" name="DevInfoForm">
    <table id="PositionBInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1"
      class="tabal_noborder_bg">
      <li id="LongSB" RealType="HtmlText" DescRef="GXB017" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Long.SB" InitValue="Empty" />
      <li id="LatSB" RealType="HtmlText" DescRef="GXB018" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Lat.SB" InitValue="Empty" />
      <li id="AltitudesSB" RealType="HtmlText" DescRef="GXB019" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="Altitudes.SB" InitValue="Empty" />
      <li id="AreaCodeSB" RealType="HtmlText" DescRef="GXB020" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="AreaCode.SB" InitValue="Empty" />
      <li id="HorizontalErrorSB" RealType="HtmlText" DescRef="GXB021" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="HorizontalError.SB" InitValue="Empty" />
      <li id="VerticalErrorSB" RealType="HtmlText" DescRef="GXB021a" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="VerticalError.SB" InitValue="Empty" />
      <li id="GISLockTimeSB" RealType="HtmlText" DescRef="GXB022" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="GISLockTime.SB" InitValue="Empty" />
      <li id="GISDigestSB" RealType="HtmlText" DescRef="GXB023" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="GISDigest.SB" InitValue="Empty" />
      <li id="LocalRepStatusSB" RealType="HtmlText" DescRef="GXB029" RemarkRef="Empty" ErrorMsgRef="Empty"
        Require="FALSE" BindField="LocalRepStatus.SB" InitValue="Empty" />

    </table>
    <script>
      var DevInfoTableClass = new stTableClass("width_per30 table_title", "width_per70 table_right align_left", "ltr");
      var PositionBInfoList = new Array();
      PositionBInfoList = HWGetLiIdListByForm("PositionBInfoForm", null);
      HWParsePageControlByID("PositionBInfoForm", DevInfoTableClass, GXBMonitorDes, null);
      var PositionBTableDataInfo = HWcloneObject(MonitorPositionBInfo, 1);
      ChangeSpaceValueToLineBySuifix(PositionBTableDataInfo, PositionBInfoList, "SB");
      HWSetTableByLiIdList(PositionBInfoList, PositionBTableDataInfo, null, ".SB");
      $("#TablePositionBInfoForm").attr("class", "table_bg");
    </script>
  </form>


  <div class="title_spread"></div>
  <div id="DivCounterInfo" class="func_title" BindText="GXB038"></div>
  <form id="CounterInfoForm" name="CounterInfoForm">
    <table id="CounterInfoPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
      <li id="PendingTask" RealType="HtmlText" DescRef="GXB043" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="PendingTask" InitValue="Empty" />
      <li id="SuccessTask" RealType="HtmlText" DescRef="GXB044" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SuccessTask" InitValue="Empty" />
      <li id="FailTask" RealType="HtmlText" DescRef="GXB045" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="FailTask" InitValue="Empty" />
      <li id="ExpireTask" RealType="HtmlText" DescRef="GXB046" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="ExpireTask" InitValue="Empty" />
      <li id="FailInform" RealType="HtmlText" DescRef="GXB047" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="FailInform" InitValue="Empty" />
      <li id="SuccessInform" RealType="HtmlText" DescRef="GXB048" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SuccessInform" InitValue="Empty" />
      <li id="FailResult" RealType="HtmlText" DescRef="GXB049" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="FailResult" InitValue="Empty" />
      <li id="SuccessResult" RealType="HtmlText" DescRef="GXB050" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
        BindField="SuccessResult" InitValue="Empty" />
    </table>
    <script>
      var DevInfoTableClass = new stTableClass("width_per30 table_title", "width_per70 table_right align_left", "ltr");
      var CounterInfoFormList = new Array();
      CounterInfoFormList = HWGetLiIdListByForm("CounterInfoForm", null);
      HWParsePageControlByID("CounterInfoForm", DevInfoTableClass, GXBMonitorDes, null);
      var DevCounterInfo = HWcloneObject(CounterInfo, 1);
      ChangeSpaceValueToLine(DevCounterInfo, CounterInfoFormList);
      HWSetTableByLiIdList(CounterInfoFormList, DevCounterInfo, null);
      $("#TableCounterInfoForm").attr("class", "table_bg");
    </script>
  </form>

  <div class="title_spread"></div>
  <div id="DivTaskInfo" class="func_title" BindText="GXB053"></div>
  <script type="text/javascript">
    var MonitorTaskListInfo = new Array(new stTableTileInfo("Empty", "tableclasscenter_num", "NumIndexBox"),
      new stTableTileInfo("GXB054", "tableclasscenter", "RPCID"),
      new stTableTileInfo("GXB055", "tableclasscenter", "TaskObject", false, 18),
      new stTableTileInfo("GXB056", "tableclasscenter", "TaskID"),
      new stTableTileInfo("GXB057", "tableclasscenter", "PlanedTime"),
      new stTableTileInfo("GXB058", "tableclasscenter", "MaxAge", false, 32),
      new stTableTileInfo("GXB059", "tableclasscenter", "Params", false, 32), null);

    var ColumnNum = 7;
    var TableDataInfo = HWcloneObject(ArrayTaskInfos, 1);
    HWShowTableListByType(1, "MonitorTaskList", false, ColumnNum, TableDataInfo, MonitorTaskListInfo, GXBMonitorDes, null);
  </script>

  <div id="SpeedTest" style="display:none">
    <div class="title_spread"></div>
    <div id="DivSpeedTest" class="func_title" BindText="GXB093"></div>
    <table cellpadding="0" cellspacing="1" class="tabal_noborder_bg" width="100%">
      <tr>
        <td class="table_title width_per12" BindText="GXB094"></td>
        <td class="table_right">
          <input type="text" id="StartHour" style="width: 18px" maxlength="2">
          <span class="gray" BindText="GXB096"></span>
          <input type="text" id="StartMinute" style="width: 18px" maxlength="2">
          <span class="gray" BindText="GXB097"></span>
          <input type="button" id="btnSaveReportTime" BindText="GXB101" onClick="SaveTaskExeTime()" />
          <input type="button" id="btnStartSpeedTest" BindText="GXB095" onClick="BeginSpeedTest()" />
          <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        </td>
      </tr>
    </table>
    <div class="title_spread"></div>
    <div id="DivResultInfo" class="func_title" BindText="GXB090"></div>
    <table width="100%" class="tabal_bg" id="SpeedTestResult" border="0" cellpadding="0" cellspacing="1">
      <tr class="head_title" id="SpeedTestResultTitle">
        <td BindText='GXB091'></td>
        <td BindText='GXB092'></td>
      <tr>
      <tr class="tabal_01" id="TraceRouteResultContent">
      </tr>
      <tr class="tabal_02" id="SpeedTestResultContent">
      </tr>
      <script>
        var htmlline;
        var Contents = "";

        function replacer(key, value) {
          if ("SpeedTable" == key) {
            var newArr = [];
            var strline = '';
            for (var i = 0; i < value.length; i++) {
              if ((i + 1) % 5 == 0) {
                strline += value[i];
                newArr.push(strline);
                strline = "";
              }
              else {
                if (i == value.length - 1) {
                  strline += value[i];
                }
                else {
                  strline += value[i] + ',';
                }
              }
            }
            if (strline != "") {
              newArr.push(strline);
            }

            return newArr;
          }
          else {
            return value;
          }
        }

        if (null == ResultInfos || "" == ResultInfos || null == ResultInfos[0].traceroute || "" == ResultInfos[0].traceroute) {
          htmlline = '<td class="tabletextcenter">BUCPE.TraceRoute</td>';
          htmlline += '<td class="tabletextcenter" title="">--</td>';
          $("#TraceRouteResultContent").append(htmlline);
        }
        else {
          var TraceRouteResultContents = $.parseJSON(ResultInfos[0].traceroute);
          Contents = JSON.stringify(TraceRouteResultContents[1].Params.BUCPE.TraceRouteResult, null, 2);
          htmlline = '<td class="tabletextcenter">' + TraceRouteResultContents[1].ObjectPath + '</td>';
          htmlline += '<td><pre>' + Contents + '</pre></td>';
          $("#TraceRouteResultContent").append(htmlline);
        }

        if (null == ResultInfos || "" == ResultInfos || null == ResultInfos[0].speedtest || "" == ResultInfos[0].speedtest) {
          htmlline = '<td class="tabletextcenter">BUCPE.SiteSpeed</td>';
          htmlline += '<td class="tabletextcenter" title="">--</td>';
          $("#SpeedTestResultContent").append(htmlline);
        }
        else {
          var SpeedTestResultContents = $.parseJSON(ResultInfos[0].speedtest);
          Contents = JSON.stringify(SpeedTestResultContents[1].Params.BUCPE.SiteSpeedResult, replacer, 2);
          htmlline = '<td class="tabletextcenter">' + SpeedTestResultContents[1].ObjectPath + '</td>';

          htmlline += '<td><pre>' + Contents + '</pre></td>';
          $("#SpeedTestResultContent").append(htmlline);
        }
      </script>
    </table>
  </div>

  <div class="title_spread"></div>
  <div class="title_spread"></div>
  <div class="title_spread"></div>
  <script>
    ParseBindTextByTagName(GXBMonitorDes, "div", 1);
    ParseBindTextByTagName(GXBMonitorDes, "td", 1);
    ParseBindTextByTagName(GXBMonitorDes, "span", 1);
    ParseBindTextByTagName(GXBMonitorDes, "input", 2);
  </script>
</body>

</html>