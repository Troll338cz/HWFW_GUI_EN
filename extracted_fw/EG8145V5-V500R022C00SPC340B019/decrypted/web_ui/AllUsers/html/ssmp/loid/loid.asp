<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Pragma" content="no-cache" />
  <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
  <script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
  <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
  <script language="JavaScript" type="text/javascript">
    function stAuthGetLoidPwd(domain, Loid, Password) {
      this.domain = domain;
      this.Loid = Loid;
      this.Password = Password;
    }

    function stResultInfo(domain, Result, Status) {
      this.domain = domain;
      this.Result = Result;
      this.Status = Status;
    }
    var MngtGdct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GDCT);%>';
    var MngtYnct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_YNCT);%>';
    var MngtAhct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_AHCT);%>';
    var IsTianYiDev = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CTRG );%>';
    var IsYueMeDev = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_YUEME);%>';
    var MngtFjct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_FJCT);%>';
    var MngtScct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>';
    var isHuncncatv = '<%HW_WEB_GetFeatureSupport(FT_HUNCN_CATV_NAME);%>';
    var NotSupportJump = '<%HW_WEB_GetFeatureSupport(FT_SSMP_NOT_SUPPORT_LOIDJUMP);%>';

    var AuthInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo,UserName|UserId, stAuthGetLoidPwd);%>;

    var simcardstatus = '<%webAspGetSimRegStatus();%>';

    var LoidPwdInfo = AuthInfo[0];
    var sysUserType = '0';
    var curUserType = '<%HW_WEB_GetUserType();%>';

    var CfgFtWordArea = '<%GetConfigAreaInfo();%>';

    var stResultInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo,Result|Status, stResultInfo);%>;
    var Infos = stResultInfos[0];

    var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
    var CfgMode = '<%HW_WEB_GetCfgMode();%>';
    var BinWord = '<%HW_WEB_GetBinMode();%>';

    var iPwdLen = 12;
    if (1 == MngtFjct) {
      iPwdLen = 24;
    }



    function loidconfig() {


      var StepStatus = getCookie('StepStatus');
      if (StepStatus == null || StepStatus == "" || (StepStatus < '0' || StepStatus > '7')) {
        var PrevTime = new Date();
        setCookie("lStartTime", PrevTime);
        setCookie("StepStatus", "0");
        setCookie("CheckOnline", "0");
        setCookie("lastPercent", "0");
      }

      window.location = "/loidresult.asp";
      return;
    }
    function LoadFrame() {
      if (1 == simcardstatus) {
        document.getElementById("DivAuthentication").style.display = "none";
        document.getElementById("DivSimcard").style.display = "";
      }
      else {
        if (CfgFtWordArea.toUpperCase() != 'NOCHOOSE' && CfgFtWordArea.toUpperCase() != 'CHOOSE') {
          document.getElementById("DivAuthentication").style.display = "";
        }
        else if (CfgFtWordArea.toUpperCase() == 'NOCHOOSE') {
          document.getElementById("DivAuthentication").style.display = "";
        }
        else if ((BinWord.toUpperCase() == 'A8C') && (CfgMode.toUpperCase() == 'A8C')) {
          document.getElementById("DivAuthentication").style.display = "";
        }
        else {
          window.parent.document.location.href = "/loidreg.asp";
          return;
        }

        if (MngtYnct == 1) {
          setDisable("LoidId_text", 1);
          setDisable("Pwd_password", 1);
          setDisable("setbutton", 1);
          setText("Pwd_password", "********");
        }
        else if (1 == MngtAhct) {
          if (((parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 1)) || (parseInt(Infos.Status) == 5)
            || (curUserType != sysUserType)) {
            setDisable("LoidId_text", 1);
            setDisable("Pwd_password", 1);
            setDisable("setbutton", 1);
          }
        }

        else {
          if (curUserType != sysUserType) {
            setDisable("LoidId_text", 1);
            setDisable("Pwd_password", 1);
            setDisable("setbutton", 1);
          }
        }

        setText("LoidId_text", LoidPwdInfo.Loid);
        if (MngtGdct != 1 && MngtYnct != 1) {
          setText("Pwd_password", LoidPwdInfo.Password);
        }

        if (LoidPwdInfo.Password != "") {
          setCheck('Loidpwd_checkbox', 1);
          setDisplay('Trshowloidpassword', 1);
        }
        else {
          setCheck('Loidpwd_checkbox', 0);
          setDisplay('Trshowloidpassword', 0);
        }

      }

    }

    function CheckForm() {
      var username = document.getElementById("LoidId_text");
      var userid = document.getElementById("Pwd_password");
      var inLen = 0;

      if (username.value == "") {
        AlertEx("宽带识别码（LOID）不能为空。");
        return false;
      }

      if (isValidAscii(username.value) != '') {
        AlertEx("宽带识别码（LOID）包含非ASCII字符，请输入正确的LOID。");
        return false;
      }

      if (username.value.length > 24) {
        AlertEx("宽带识别码（LOID）的长度必须在1~24个字符之间。");
        return false;
      }

      inLen = username.value.length;
      if (inLen != 0) {
        if ((username.value.charAt(0) == ' ') || (username.value.charAt(inLen - 1) == ' ')) {
          if (false == confirm('您输入的宽带识别码（LOID）开始或结尾有空格，是否确认？')) {
            return false;
          }
        }
      }

      if (userid.value != "") {
        if (isValidAscii(userid.value) != '') {
          AlertEx("Password包含非ASCII字符，请输入正确的Password。");
          return false;
        }

        if (userid.value.length > iPwdLen) {
          AlertEx("Password的长度必须在1~" + iPwdLen + "个字符之间。");
          return false;
        }

        inLen = userid.value.length;
        if (inLen != 0) {
          if ((userid.value.charAt(0) == ' ') || (userid.value.charAt(inLen - 1) == ' ')) {
            if (false == confirm('您输入的Password开始或结尾有空格，是否确认？')) {
              return false;
            }
          }
        }
      }

      setDisable('setbutton', 1);
      return true;
    }

    function SaveStartRegTime() {
      var StartTime = new Date().getTime() / 1000;
      var ParaArrayList = "RegisterStartTime=" + StartTime;
      ParaArrayList += "&StepStatus=" + 0;
      ParaArrayList += "&ActiveBssStep=" + 0;
      ParaArrayList += "&StepStartTime=0";
      ParaArrayList += "&EsureRegisterStep=" + "RPON";
      ParaArrayList += "&StepPercent=" + "undefined";
      ParaArrayList += "&IsNeedStartTimer=" + 0;
      ParaArrayList += "&RefreshCtrlStep=" + "0;99;99";

      if (null != ParaArrayList && undefined != ParaArrayList) {
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          url: "UpgradeRegInfo.cgi?&RequestFile=loid.asp",
          data: getDataWithToken(ParaArrayList),
          success: function (data) {

          }
        });
      }

      return;
    }

    function LoidRegisterDone(reginfo) {
      if ((parseInt(reginfo.Result) == 1 && parseInt(reginfo.Status) == 0)
        || (parseInt(reginfo.Result) == 1 && parseInt(reginfo.Status) == 99)
        || parseInt(reginfo.Status) == 5) {
        return true;
      }
      return false;
    }

    function NoNeedRedirectToRegisterPage() {
      if (MngtGdct == '1' || MngtScct == '1' || NotSupportJump == '1' || MngtFjct == '1') {
        return true;
      }

      if (isHuncncatv == "1") {
        return false;
      }

      if (IsTianYiDev == '1' || IsYueMeDev == '1') {
        return false;
      }

      if (parseInt(IsTianYiDev) == 0 && (LoidRegisterDone(Infos) || parseInt(IsYueMeDev) == 0)) {
        return true;
      }
    }

    function AddSubmitParam(SubmitForm, type) {
      SaveStartRegTime();

      /* 集采要求输入LOID之后进入设备注册进度条提示页面,广东不进入进度条页面 */
      if (NoNeedRedirectToRegisterPage()) {
        SubmitForm.addParameter('x.UserName', getValue('LoidId_text'));
        SubmitForm.addParameter('x.UserId', getValue('Pwd_password'));

        if (1 == MngtFjct) {
          $.ajax({
            type: "POST",
            async: false,
            cache: false,
            data: "",
            url: "/asp/SetLoidNoBind.asp",
            success: function (data) {
              SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.X_HW_UserInfo'
                + '&RequestFile=html/ssmp/loid/loid.asp');
            }
          });
        }
        else {
          SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.X_HW_UserInfo'
            + '&RequestFile=html/ssmp/loid/loid.asp');
        }
      }
    }

    function OnClickSubmit() {
      var ProgressPage = "";
      var jumpToAsp = "/loidresult.asp";

      if (isHuncncatv == "1") {
        jumpToAsp = "/shxloidresult.asp"
        ProgressPage = "?ProgressPage=true";
      }

      if ((IsTianYiDev == '1') || (IsYueMeDev == '1')) {
        ProgressPage = "?ProgressPage=true";
      }
      var PrevTime = new Date();
      setCookie("lStartTime", PrevTime);
      setCookie("StepStatus", "0");
      setCookie("CheckOnline", "0");
      setCookie("lastPercent", "0");
      setCookie("GdTR069WanStatus", "0");
      setCookie("GdDispStatus", "0");
      setCookie("GdTR096WanIp", "0");
      setCookie("StepAfterReg", "0");
      setCookie("RegisterStep", "RPON");
      setCookie("SRStepInfo", "0;99;99");

      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        data: "x.UserName=" + FormatUrlEncode(getValue('LoidId_text')) + "&x.UserId=" + FormatUrlEncode(getValue('Pwd_password')) + "&x.X_HW_Token=" + getValue('onttoken'),
        url: "setajax.cgi?x=InternetGatewayDevice.X_HW_UserInfo&RequestFile=html/ssmp/loid/loid.asp",
        success: function (data) {
          parent.UpgradeFlag = "1";
          var urlPost = 'logout.cgi?RequestFile=html/logout.html';
          var token = GetToken();
          var data = {'x.X_HW_Token': token};
          $.post(urlPost, data);
          window.parent.document.location.href = jumpToAsp + ProgressPage;
        },
        complete: function (XHR, TS) {
          XHR = null;
        }
      });
    }

    function ClickLoidpwdEnable() {
      if (getCheckVal("Loidpwd_checkbox") == 1) {
        setDisplay('Trshowloidpassword', 1);
      }
      else {
        setDisplay('Trshowloidpassword', 0);
      }
    }

    function CancelValue() {
      setText("LoidId_text", LoidPwdInfo.Loid);

      if (MngtGdct != 1) {
        setText("Pwd_password", LoidPwdInfo.Password);
      }
      else {
        setText("Pwd_password", "");
      }
    }

  </script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <div id="DivSimcard" style="display:none">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="prompt">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="title_01" id="text_tips" style="padding-left:10px;" width="100%">在本页面上，您可以通过点击 “业务配置”
                按钮查看设备注册状态。</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td></td>
      </tr>
    </table>
    <table width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td align="right"> <input class="submit" name="btnloidconfig" id="btnloidconfig" type='button'
            onClick='loidconfig()' value="业务配置">
        </td>
      </tr>
    </table>
  </div>
  <div name="DivAuthentication" id="DivAuthentication" style="display:none">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <label id="Loid_lableL">
        <tr>
          <td class="table_head" width="100%">宽带识别码（LOID）设置 </td>
        </tr>
        <tr>
          <td height="5"></td>
        </tr>
        <tr>
          <td class="title_01" style="padding-left:10px;" width="100%">
            <lable>宽带识别码（LOID）功能用于新设备的注册及下发，请不要更改，如果修改宽带识别码（LOID）导致业务不正常，请重启网关。</lable>
          </td>
        </tr>
      </label>
    </table>

    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td></td>
      </tr>
    </table>
    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="title_01" align="left" width='25%'>宽带识别码（LOID）认证是否使用密码</td>
        <td class="table_right" align="left" colspan="6" width='75%'>
          <input id='Loidpwd_checkbox' name='Loidpwd_checkbox' type='checkbox' onclick='ClickLoidpwdEnable()'>
        </td>
      </tr>
    </table>
    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td></td>
      </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_bg">
      <tr id="TroldPassword">
        <td class="table_title" align="left" width='25%'>宽带识别码（LOID）:</td>
        <td class="table_right" align="left" colspan="6" width='75%'>
          <input name='LoidId_text' type="text" id="LoidId_text" maxlength="24">
          <strong style="color:#FF0033">*</strong>
          <span class="gray">
            <script>document.write("(字符串最多包含24个英文字符或数字)");</script>
          </span>
        </td>
      </tr>
    </table>
    <div id="Trshowloidpassword" style="display:none">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_bg">
        <tr>
          <td class="table_title" align="left" width='25%'>密码:</td>
          <td class="table_right" align="left" colspan="6" width='75%'>
            <input name='Pwd_password' type="text" id="Pwd_password">
            <span class="gray">
              <script>document.write("(字符串最多包含" + iPwdLen + "个英文字符或数字)");</script>
            </span>
          </td>
        </tr>
      </table>
    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button">
      <tr>
        <td class="table_submit" width='25%'></td>
        <td class="table_submit" align="right">
          <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
          <script>
            if (NoNeedRedirectToRegisterPage()) {
              document.write("<input  class=\"submit\" name=\"setbutton\" id=\"Apply_button\" type=\"button\" onClick=\"Submit();\" value=\"保存/应用\"> ");
            } else {
              document.write("<input  class=\"submit\" name=\"setbutton\" id=\"Apply_button\" type=\"button\" onClick=\"OnClickSubmit();\" value=\"保存/应用\"> ");
            }
          </script>
      </tr>
    </table>
    <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td></td>
      </tr>
    </table>
  </div>
</body>

</html>