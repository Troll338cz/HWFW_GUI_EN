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


  <title>Bundle</title>
  <style type="text/css">
    div.filewrap {
      margin: 0;
      padding: 0;
    }

    div.fileupload {
      top: 0px;
      left: 0px;
      margin: 0;
      padding: 0;
      width: 250px;
      height: 22px;
      position: relative;
      white-space: nowrap;
    }

    #f_file {
      left: 0;
      margin: 0;
      padding: 0;
      z-index: 3;
      width: 182px;
      height: 19px;
      line-height: 18px;
      color: #777777;
      position: absolute;
      text-align: left;
      font-size: 11px;
      font-family: Arial;
      white-space: nowrap;
      vertical-align: middle;
      border: 1px solid #B5B8C8;
      background-color: #FFFFFF;
    }

    #t_file {
      right: 0;
      margin: 0;
      padding: 0;
      height: 22px;
      opacity: 0;
      width: 80px;
      filter: alpha(opacity=0);
      position: absolute;
      text-align: left;
      white-space: nowrap;
      z-index: 2;
      cursor: pointer;
    }

    #btnBrowse {
      right: 0;
      z-index: 1;
      width: 65px;
      text-align: center;
      position: absolute;
      white-space: nowrap;
      text-align: left;
      cursor: pointer;
    }
  </style>
  <script language="JavaScript" type="text/javascript">


    function GetLanguageDesc(Name) {
      return SmartOntdes[Name];
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

    function LoadFrame() {
      top.UpgradeFlag = 0;
    }

    function CheckForm(type) {
      with (document.getElementById("ConfigForm")) {
      }
      return true;
    }

    function AddSubmitParam(SubmitForm, type) {
    }

    function VerifyFile(FileName) {
      var File = document.getElementsByName(FileName)[0].value;
      if (File.length == 0) {
        AlertEx(GetLanguageDesc("s0702"));
        return false;
      }
      if (File.length >= 128) {
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

    function uploadImage() {
      var uploadForm = document.getElementById("fr_uploadImage");
      var ffile = document.getElementById("f_file");

      if (Check_SWM_Status() == false) {
        AlertEx(GetLanguageDesc("s0905"));
        return;
      }

      if (VerifyFile('browse') == false) {
        return;
      }

      setDisable('btnSubmit', 1);
      uploadForm.action = "bundleupload.cgi?RequestFile=html/ssmp/reset/reset.asp&FileType=bundle&OptType=add&FileName=" + ffile.value;
      uploadForm.submit();
      top.UpgradeFlag = 1;
    }

  </script>
  <script language="JavaScript" type="text/javascript">
    function fchange() {
      var ffile = document.getElementById("f_file");
      if ((window.navigator.userAgent.indexOf("MSIE 6.0") >= 1)
        || (window.navigator.userAgent.indexOf("MSIE 7.0") >= 1)
        || (window.navigator.userAgent.indexOf("MSIE 8.0") >= 1)) {
        var tfile = getPath(document.getElementById("t_file"));
        ffile.value = tfile;
        return;
      }

      var tfile = document.getElementById("t_file");
      ffile.value = tfile.value;
      return;
    }

    function StartFileOpt() {
      XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    }
  </script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <form method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
    <script language="JavaScript" type="text/javascript">
      HWCreatePageHeadInfo("boundlestatusasp", GetDescFormArrayById(SmartOntdes, "smart030lan"), GetDescFormArrayById(SmartOntdes, "smart030"), false);
    </script>
    <div class="title_spread"></div>
    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td BindText="smart031"></td>
        <td>
          <div class="filewrap">
            <div class="fileupload">
              <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>" />
              <input type="text" id="f_file" autocomplete="off" readonly="readonly" />
              <input type="file" name="browse" id="t_file" size="1" onblur="StartFileOpt();" onchange="fchange();" />
              <input id="btnBrowse" type="button" class="submit" BindText="smart032" />
            </div>
          </div>
        </td>
        <td> <input class="submit" name="btnSubmit" id="btnSubmit" type='button' onclick='uploadImage();'
            BindText="smart033" /> </td>
      </tr>
    </table>
  </form>
  <div class="func_spread"></div>
  <script>
    ParseBindTextByTagName(SmartOntdes, "span", 1);
    ParseBindTextByTagName(SmartOntdes, "td", 1);
    ParseBindTextByTagName(SmartOntdes, "div", 1);
    ParseBindTextByTagName(SmartOntdes, "input", 2);
  </script>

</body>

</html>