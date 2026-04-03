<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Pragma" content="no-cache">
  <title>Bundle Information</title>
  <script>
    var token = '<%HW_WEB_GetToken();%>';

    function AccRefreshSubmit() {
      window.location = "dbusplugin.asp";
    }

    function startFmkOp() {
      document.getElementById("Fmk_start").style.display = "none";
      document.getElementById("Fmk_stop").style.display = "block";
      var Form = new webSubmitForm();
      Form.addParameter('x.X_HW_Token', token);
      Form.setAction('SetFmkOpType.cgi?optype=start&RequestFile=html/ssmp/smartontinfo/dbusplugin.asp');
      //DisableAllButton();
      Form.submit();
    }

    function stopFmkOp() {
      document.getElementById("Fmk_start").style.display = "block";
      document.getElementById("Fmk_stop").style.display = "none";
      var Form = new webSubmitForm();
      Form.addParameter('x.X_HW_Token', token);
      Form.setAction('SetFmkOpType.cgi?optype=stop&stoptime=' + getSelectVal('selStopTime') + '&RequestFile=html/ssmp/smartontinfo/dbusplugin.asp');
      //DisableAllButton();
      Form.submit();
    }

    function recoverFmkOp() {
      var Form = new webSubmitForm();
      Form.addParameter('x.X_HW_Token', token);
      Form.setAction('SetFmkOpType.cgi?optype=recover&RequestFile=html/ssmp/smartontinfo/dbusplugin.asp');
      //DisableAllButton();
      Form.submit();
    }

    function upgradeFmkOp() {
      var uploadForm = document.getElementById("fr_upgradeImage");
      if ((window.navigator.userAgent.indexOf("MSIE 6.0") >= 1)
        || (window.navigator.userAgent.indexOf("MSIE 7.0") >= 1)
        || (window.navigator.userAgent.indexOf("MSIE 8.0") >= 1)) {
        var filePath = getPath(document.getElementById("t_file2"));
      }
      else {
        var tfile = document.getElementById("t_file2");
        var filePath = tfile.value;
      }
      uploadForm.action = "FmkUpgrade.cgi?optype=upgrade&RequestFile=html/ssmp/smartontinfo/dbusplugin.asp&file=" + filePath;
      //DisableAllButton();
      uploadForm.submit();
    }
    function fchange() {
      upgradeFmkOp();
    }

    function StartFileOpt() {
      XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    }

    function SetNullString(str) {
      if (str == "") {
        return "--"
      }
      else {
        return str;
      }
    }

    function stPlatInfo(bss_server, bss_status, main_server, main_status, dist_addr, dist_status) {
      this.bss_server = bss_server;   /* BSS平台地址 */
      this.bss_status = bss_status;   /* BSS平台连接状态 */
      this.main_server = main_server; /* 主能力平台地址 */
      this.main_status = main_status;  /* 主能力平台地址 */
      this.dist_addr = dist_addr;     /* 分发平台地址 */
      this.dist_status = dist_status; /* 分发平台状态 */
    }

    var plat = <%HW_WEB_GetDbusPlatformInfo(stPlatInfo);%>;
    var DbusPlat = plat[0];

    function CtrgInfo() {
      function stFmkInfo(middleVersion, safVersion, cloudVersion, activeNumber, backupNumber) {
        this.middleVersion = middleVersion;//中间件版本号
        this.safVersion = safVersion;//SAF版本号
        this.cloudVersion = cloudVersion;//云客户端版本号
        this.activeNumber = activeNumber;//活动分区号
        this.backupNumber = backupNumber;//备份分区号
      }

      var temp = <%HW_WEB_GetDbusFmkworkInfo(stFmkInfo);%>;
      var Fmkwork = temp[0];
      if (!Fmkwork) {
        Fmkwork = new stFmkInfo("", "", "", "", "");
      }

      document.write('<tr align="left"><td class="table_title width_per30" nowrap>SAF版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.safVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>中间件版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.middleVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>云客户端版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.cloudVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>备份区</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.backupNumber) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>活动区</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.activeNumber) + '</td></tr>');
    }

    function CucInfo() {
      function stFmkInfo(ufwmgVersion, ufwVersion, ufwBVersion, uappdVersion, backupMTD, activeMTD, ufwLogLevel) {
        this.ufwmgVersion = ufwmgVersion;//引导程序版本号
        this.ufwVersion = ufwVersion;//中间件版本号
        this.ufwBVersion = ufwBVersion;//中间件备份版本号
        this.uappdVersion = uappdVersion;//云客户端版本号
        this.backupMTD = backupMTD;//备份分区号
        this.activeMTD = activeMTD;//活动分区号
        this.ufwLogLevel = ufwLogLevel;
      }

      var temp = <%HW_WEB_GetDbusFmkworkInfo(stFmkInfo);%>;
      var Fmkwork = temp[0];
      if (!Fmkwork) {
        Fmkwork = new stFmkInfo("", "", "", "", "", "", "");
      }

      document.write('<tr align="left"><td class="table_title width_per30" nowrap>引导程序版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.ufwmgVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>中间件主版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.ufwVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>中间件备版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.ufwBVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>云客户端版本</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.uappdVersion) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>备份区</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.backupMTD) + '</td></tr>');
      document.write('<tr align="left"><td class="table_title width_per30" nowrap>活动区</td>');
      document.write('<td class="table_right" nowrap>' + htmlencode(Fmkwork.activeMTD) + '</td></tr>');
    }

    function PrintFmkInfo() {
      var IsCuc = '<%HW_WEB_GetFeatureSupport(FEATURE_CU_DBUS);%>';

      if (IsCuc == '1') {
        CucInfo();
      } else {
        CtrgInfo();
      }
    }

  </script>
</head>

<body class="mainbody">
  <!--平台连接情况-->
  <div>
    <div class="func_title"><label>平台连接情况：</label></div>
    <table class="tabal_bg width_100p" cellspacing="1" id="bundleid">
      <tr align="left">
        <td width="10%" class="table_title" rowspan="2">家庭网络设备分发管理子系统(主)</td>
        <td width="45%" class="table_title">平台地址</td>
        <td width="45%" class="table_title">连接状态</td>
      </tr>
      <tr align="left">
        <script language="JavaScript" type="text/javascript">
          DbusPlat.bss_server = SetNullString(DbusPlat.bss_server);
          document.write('<TD width="50%" class="table_right">' + htmlencode(DbusPlat.bss_server) + '</TD>');
          document.write('<TD width="50%" class="table_right">' + htmlencode(DbusPlat.bss_status) + '</TD>');
        </script>
      </tr>
      <tr align="left">
        <td width="10%" class="table_title" rowspan="2">家庭网络设备分发管理子系统(备)</td>
        <td width="45%" class="table_title">平台地址</td>
        <td width="45%" class="table_title">连接状态</td>
      </tr>
      <tr align="left">
        <script language="JavaScript" type="text/javascript">

          var linkStatus;
          if (DbusPlat.dist_status <= 1) {
            linkStatus = "未连接";
          } else if (DbusPlat.dist_status == 2) {
            linkStatus = "正在尝试连接家庭网络设备分发管理子系统(备)";
          } else if (DbusPlat.dist_status == 3) {
            linkStatus = "与家庭网络设备分发管理子系统(备)保持连接中";
          } else if (DbusPlat.dist_status == 4) {
            linkStatus = "与家庭网络设备分发管理子系统(备)连接结束";
          } else if (DbusPlat.dist_status == 5) {
            linkStatus = "尝试连接家庭网络设备分发管理子系统(备)失败";
          } else {
            linkStatus = "未连接";
          }

          DbusPlat.dist_addr = SetNullString(DbusPlat.dist_addr);
          document.write('<TD width="50%" class="table_right">' + htmlencode(DbusPlat.dist_addr) + '</TD>');
          document.write('<TD width="50%" class="table_right">' + htmlencode(linkStatus) + '</TD>');
        </script>
      </tr>
      <tr align="left">
        <td width="10%" class="table_title" rowspan="2">网关能力子系统</td>
        <td width="45%" class="table_title">平台地址</td>
        <td width="45%" class="table_title">连接状态</td>
      </tr>
      <tr align="left">
        <script language="JavaScript" type="text/javascript">
          DbusPlat.main_server = SetNullString(DbusPlat.main_server);
          document.write('<TD width="50%" class="table_right">' + htmlencode(DbusPlat.main_server) + '</TD>');
          document.write('<TD width="50%" class="table_right">' + htmlencode(DbusPlat.main_status) + '</TD>');
        </script>
      </tr>
    </table>
  </div>
  </br></br>
  <!--系統分区信息-->
  <div>
    <div class="func_title"><label id="Title_base_lable">系統分区信息：</label></div>
    <div style="width:100%;overflow-x:auto;">
      <table class="tabal_bg width_100p" cellspacing="1" id="bundleid">
        <script>
          PrintFmkInfo();
          document.write('<tr align="left"><td class="table_title width_per30" nowrap>暂停时间</td>');
          document.write('<td class="table_right">');
          document.write('<select id ="selStopTime"><option value="3">3分钟</option><option value="10">10分钟</option>');
          document.write('<option value="30">30分钟</option><option value="120">120分钟</option></select>');
          document.write('</td></tr>');

          document.write('<tr align="left"><td class="table_title width_per30" nowrap>暂停/开始</td>');
          document.write('<td class="table_right">');
          document.write('<input id="Fmk_stop" name="Fmk_stop" type="button" value="暂停" onClick="stopFmkOp();"/>');
          document.write('<input id="Fmk_start" name="Fmk_start" type="button" value="开始" onClick="startFmkOp();"/>');
          document.write('</td></tr>');

          document.write('<tr align="left"><td class="table_title width_per30" nowrap>恢复</td>');
          document.write('<td class="table_right"><input type="button" value="恢复" onClick="recoverFmkOp();"/></td></tr>');

          document.write('<tr align="left"><td class="table_title width_per30" nowrap>升级</td>');
          document.write('<td class="table_right">');
          document.write('<form method="post" enctype="multipart/form-data" name="fr_upgradeImage" id="fr_upgradeImage">');
          document.write('<input type="hidden" id="hwonttoken" name="onttoken" value="<%HW_WEB_GetToken();%>" />');
          document.write('<input type="file" name="browse" style="width:40px;" id="t_file2" title="选择文件" size="12" onblur="StartFileOpt();" onchange="fchange();" />');
          document.write('<input name="update" type="button" title="升级"  value="升级" onClick="upgradeFmkOp();" />');
          document.write('</form>');
          document.write('</td></tr>');

          var status = '<%HW_WEB_GetFmkStatus();%>';
          if (status == 'start') {
            document.getElementById("Fmk_start").style.display = "none";//隐藏开始按键
            document.getElementById("Fmk_stop").style.display = "block";//显示暂停按键
          } else {
            document.getElementById("Fmk_start").style.display = "block";//显示开始按键
            document.getElementById("Fmk_stop").style.display = "none";//隐藏暂停按键
          }
        </script>
      </table>
      </br>
    </div>
  </div>
  </br>
  <div>
    <div class="title_with_desc">插件信息：</div>
    <table width="70%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="SysLogInst">
        <tr class="head_title">
            <td class="width_70p" id="plug_1_1_table">
                <div class="align_center">插件名称</div>
            </td>
            <td class="width_30p" id="plug_1_2_table">
                <div class="align_center">状态</div>
            </td>
        </tr>
        <script language="JavaScript" type="text/javascript">
            var dbusPluginList = '<%HW_WEB_GetDbusPluginList();%>';
            if (dbusPluginList != '') {
                var pluginArray = dbusPluginList.split(",");
                var column = 1;
                for (var i = 0; i < pluginArray.length - 1; i++) {
                    var pluginInfo = pluginArray[i];
                    var onePlugin = pluginInfo.split("|");
                    var name = onePlugin[0];
                    var status = onePlugin[1];
                    var id_name = "log_2_" + (column++) + "_table";
                    var id_status = "log_2_" + (column++) + "_table";

                    document.write('<tr class="tabal_center01 ">');
                    document.write('<TD id="' + id_name + '">' + htmlencode(name) + '</TD>');
                    document.write('<TD id="' + id_status + '" title="' + htmlencode(status) + '">' + GetStringContent(htmlencode(status), 64) + '</TD>');
                    document.write('</tr>');
                }
            } else {
                document.write('<tr class="tabal_center01 ">');
                document.write('<TD>' + '-' + '</TD>');
                document.write('<TD>' + '-' + '</TD>');
                document.write('</tr>');
            }
        </script>
    </table>
</div>
</br></br>
  <!--日志-->
  <div>
    <div class="title_with_desc">插件配置下发记录：</div>
    <table width="70%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="SysLogInst">
      <tr class="head_title">
        <td class="width_30p" id="log_1_1_table">
          <div class="align_center">日期/时间</div>
        </td>
        <td class="width_70p" id="log_1_2_table">
          <div class="align_center">消息</div>
        </td>
      </tr>
      <script language="JavaScript" type="text/javascript">
        var DbusPluginLog = '<%HW_WEB_GetDbusPluginLog();%>';
        if (DbusPluginLog != null) {
          var ResultLog = DbusPluginLog.split("\n");
          var IDtable = 1;
          for (var i = 0; i < ResultLog.length - 1; i++) {
            var loginof = ResultLog[i];
            var logtime = loginof.substring(0, 19);
            var logalert = loginof.substring(19, loginof.length);
            var id_time = "log_2_" + (IDtable++) + "_table";
            var id_alert = "log_2_" + (IDtable++) + "_table";

            document.write('<tr class="tabal_center01 ">');
            document.write('<TD id="' + id_time + '">' + htmlencode(logtime) + '</TD>');
            document.write('<TD id="' + id_alert + '" title="' + htmlencode(logalert) + '">' + GetStringContent(htmlencode(logalert), 64) + '</TD>');
            document.write('</tr>');
          }
        } else {
          document.write('<tr class="tabal_center01 ">');
          document.write('<TD>' + '-' + '</TD>');
          document.write('<TD>' + '-' + '</TD>');
          document.write('</tr>');
        }
      </script>
    </table>
    <input class="submit" name="AccRefresh_button" id="AccRefresh_button" type="button" value="刷新"
      onClick="AccRefreshSubmit();">
  </div>
</body>

</html>