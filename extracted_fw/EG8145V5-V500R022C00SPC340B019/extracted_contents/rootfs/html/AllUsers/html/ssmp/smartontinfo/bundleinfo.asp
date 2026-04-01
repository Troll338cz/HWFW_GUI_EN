<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
  <script language="JavaScript"
    src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
  <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>



  <title>Bundle Information</title>
  <style>
    .noMaginLeft {
      margin: 0;
      font-size: 12px;
    }
  </style>
  <script>
    function stBundleInfo(domain, bundleid, bundleStatus, bundlename, bundleversion) {
      this.domain = domain;
      this.bundleid = bundleid;
      this.bundleStatus = bundleStatus;
      this.bundlename = bundlename;
      this.bundleversion = bundleversion;
    }

    function GetLanguageDesc(Name) {
      return SmartOntdes[Name];
    }

    var token = '<%HW_WEB_GetToken();%>';
    var BundleInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_Bundle.{i},bundleid|bundleState|name|version,stBundleInfo);%>;
    var BundleLen = BundleInfo.length - 1;

    function DisableAllButton() {
      if (0 == BundleLen) {
        return;
      }

      for (var index = 0; index < BundleLen; index++) {
        setDisable('t_file_' + index, 1);
        setDisable('update_' + index, 1);
        setDisable('start_' + index, 1);
        setDisable('stop_' + index, 1);
        setDisable('del_' + index, 1);
      }

      return;
    }

    function DisableAllSetButton() {
      if (0 == BundleLen) {
        return;
      }

      for (var index = 0; index < BundleLen; index++) {
        setDisable('update_' + index, 1);
        setDisable('start_' + index, 1);
        setDisable('stop_' + index, 1);
        setDisable('del_' + index, 1);
      }

      return;
    }

    function StartBundle(index) {
      var Form = new webSubmitForm();
      Form.addParameter('x.bundleopt', 4);
      Form.addParameter('x.X_HW_Token', token);
      Form.setAction('set.cgi?x=' + BundleInfo[index].domain + '&RequestFile=html/ssmp/smartontinfo/bundleinfo.asp');
      DisableAllButton();
      Form.submit();
    }

    function StopBundle(index) {
      var Form = new webSubmitForm();
      Form.addParameter('x.bundleopt', 5);
      Form.addParameter('x.X_HW_Token', token);
      Form.setAction('set.cgi?x=' + BundleInfo[index].domain + '&RequestFile=html/ssmp/smartontinfo/bundleinfo.asp');
      DisableAllButton();
      Form.submit();
    }

    function DelBundle(index) {
      var Form = new webSubmitForm();
      Form.addParameter(BundleInfo[index].domain, "");
      Form.addParameter('x.X_HW_Token', token);
      Form.setAction('del.cgi?RequestFile=html/ssmp/smartontinfo/bundleinfo.asp');
      DisableAllButton();
      Form.submit();
    }

    function Check_SWM_Status() {
      var xmlHttp = null;

      if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
      } else if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }

      xmlHttp.open("GET", "/html/get_swm_status.asp", false);
      xmlHttp.send(null);

      var swm_status = xmlHttp.responseText;
      if (swm_status.substr(1, 1) == "0") {
        return true;
      } else {
        return false;
      }
    }

    function VerifyFile(FileName) {
      var File = document.getElementsByName(FileName)[0].value;
      if (File.length == 0) {
        AlertEx(GetLanguageDesc("s0702"));
        return false;
      }
      if (File.length > 128) {
        AlertEx(GetLanguageDesc("s0703"));
        return false;
      }

      try {
        if (window.ActiveXObject) {
          fso = new ActiveXObject("Scripting.FileSystemObject");
          try {
            var FileSize = fso.GetFile(File).Size;
            var MaxImageFileSize = (1024) * (1024) * (15);
            if (FileSize > MaxImageFileSize) {
              AlertEx(GetLanguageDesc("s1118"));
              return false;
            }
          }
          catch (e) {
            AlertEx('"' + File + '"' + GetLanguageDesc("s1119"));
            return false;
          }
        }
      }
      catch (e) {
      }

      return true;
    }

    function UpdateBundle(index) {
      var uploadForm = document.getElementById("fr_upgradeImage_" + index);

      if (Check_SWM_Status() == false) {
        AlertEx(GetLanguageDesc("s0905"));
        return;
      }

      if (VerifyFile('browse_' + index) == false) {
        return;
      }

      if ((window.navigator.userAgent.indexOf("MSIE 6.0") >= 1)
        || (window.navigator.userAgent.indexOf("MSIE 7.0") >= 1)
        || (window.navigator.userAgent.indexOf("MSIE 8.0") >= 1)) {
        var filePath = getPath(document.getElementById("t_file_" + index));
      }
      else {
        var tfile = document.getElementById("t_file_" + index);
        var filePath = tfile.value;
      }
      DisableAllSetButton();
      var strArray = BundleInfo[index].domain.split(".");
      var len = strArray.length;

      uploadForm.action = "bundleupload.cgi?RequestFile=html/ssmp/reset/reset.asp&FileType=bundle&OptType=UPDATE&Inst=" + strArray[len - 1] + "&FileName=" + filePath;
      uploadForm.submit();
      top.UpgradeFlag = 1;
    }

    function fchange(index) {
      return;
    }

    function StartFileOpt() {
      XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    }

  </script>
</head>

<body class="mainbody">
  <script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("boundlestatusasp", GetDescFormArrayById(SmartOntdes, "smart034lan"), GetDescFormArrayById(SmartOntdes, "smart034"), false);
  </script>
  <div class="title_spread"></div>
  <table class="tabal_bg width_100p" cellspacing="1" id="bundleid" width="660px;">
    <tr class="head_title">
      <td BindText='smart036'></td>
      <td BindText='smart037'></td>
      <td BindText='smart038'></td>
      <td BindText='smart039'></td>
      <td BindText='smart041'></td>
      <td width=BindText='smart042'></td>
      <td BindText='smart043'></td>
      <td BindText='smart040'></td>
    </tr>
    <script type="text/javascript" language="javascript">

      for (var i = 0; i < BundleLen; i++) {
        document.write('<TR id="record_' + i + '" class="tabal_01">');
        document.write('<TD>' + htmlencode(BundleInfo[i].bundleid) + '</TD>');
        document.write('<TD style="font-size:12px;">' + htmlencode(BundleInfo[i].bundleStatus) + '</TD>');
        document.write('<TD style="width:210px;font-size:12px;word-wrap:break-word;word-break:break-all;">' + htmlencode(BundleInfo[i].bundlename) + '</TD>');
        document.write('<TD style="font-size:12px;">' + htmlencode(BundleInfo[i].bundleversion) + '</TD>');
        document.write('<TD><input name="start_' + i + '" id="start_' + i + '" type="button" BindText="smart041"  value="' + SmartOntdes['smart041'] + '" class="ApplyButtoncss noMaginLeft" onClick="StartBundle(' + i + ');" </TD>');
        document.write('<TD><input name="stop_' + i + '" id="stop_' + i + '" type="button" BindText="smart042"  value="' + SmartOntdes['smart042'] + '" class="ApplyButtoncss noMaginLeft" onClick="StopBundle(' + i + ');" </TD>');
        document.write('<TD><input name="del_' + i + '" id="del_' + i + '" type="button" BindText="smart043" value="' + SmartOntdes['smart043'] + '" class="ApplyButtoncss noMaginLeft" onClick="DelBundle(' + i + ');" </TD>');
        document.write('<TD>');
        document.write('<form method="post" enctype="multipart/form-data" name="fr_upgradeImage_' + i + '" id="fr_upgradeImage_' + i + '">');
        document.write('<input type="hidden" name="onttoken" value="' + token + '" />');
        document.write('<input style="font-size:11px;width:150px;" type="file" name="browse_' + i + '" id="t_file_' + i + '" size="12" onblur="StartFileOpt();" onchange="fchange(' + i + ');" />');
        document.write('<input name="update_' + i + '" type="button" BindText="smart040"  value="' + SmartOntdes['smart040'] + '" class="ApplyButtoncss noMaginLeft" onClick="UpdateBundle(' + i + ');" />');
        document.write('</form>');
        document.write('</TD>');
        document.write('</TR>');
      }

      if (0 == BundleLen) {
        document.write("<tr class= \"tabal_center01\">");
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write('<td >' + '--' + '</td>');
        document.write("</tr>");
      }
    </script>
  </table>
  <div class="func_spread"></div>
  <div class="func_spread"></div>
  <script>
    ParseBindTextByTagName(SmartOntdes, "span", 1);
    ParseBindTextByTagName(SmartOntdes, "td", 1);
    ParseBindTextByTagName(SmartOntdes, "div", 1);
  </script>

</body>

</html>