<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
  <!-IE7 mode->
    <meta http-equiv="Pragma" content="no-cache" />
    <title></title>
    <link href="/Cuscss/<%HW_WEB_GetCusSource(login.css);%>" media="all" rel="stylesheet" />
    <link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" media="all" rel="stylesheet" />
    <script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
    <script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
    <style type="text/css">
      #first {
        background-color: white;
        height: 25px;
        text-align: center;
        color: red;
        position: absolute;
        width: 380px;
        top: 312px;
      }


      #pwd_modify {
        border: 1px solid #CCCCCC;
        width: 650px;
        margin-left: 600px;
        margin-top: 140px;
        position: absolute;
        z-index: 10;
        background: #FFFFFF;
        display: none;
      }

      #base_mask {
        width: 100%;
        height: 100%;
        position: absolute;
        left: 0px;
        right: 0px;
        z-index: 2;
        filter: alpha(opacity=60);
        -moz-opacity: 0.6;
        -khtml-opacity: 0.6;
        opacity: 0.8;
        background-color: #eeeeee;
        display: none;
      }
    </style>
    <script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
    <script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
    <script type="text/javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
    <script id="langResource" language="JavaScript" src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
    <script language="JavaScript" type="text/javascript">
      var useChallengeCode = '<%HW_WEB_GetFeatureSupport(FT_SSMP_PWD_CHALLENGE);%>';
      var randcode = '<%WEB_GetChallengeRandCode();%>';
      function MD5(str) { return hex_md5(str); }
      var FailStat = '<%HW_WEB_GetLoginFailStat();%>';
      var LoginTimes = '<%HW_WEB_GetLoginFailCount();%>';
      var ModeCheckTimes = '<%HW_WEB_GetModPwdFailCnt();%>';
      var Var_DefaultLang = '<%HW_WEB_GetCurrentLanguage();%>';
      var Language = Var_DefaultLang;
      var LockLeftTime = '<%HW_WEB_GetLeftLockTime();%>';
      var errloginlockNum = '<%HW_WEB_GetTryLoginTimes();%>';
      var locklefttimerhandle;
      var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
      var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
      var DBAA1 = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>';
      var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
      var Var_LastLoginLang = '<%HW_WEB_GetLoginRequestLangue();%>';
      var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
      var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
      var telmexwififeature = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
      var talktalkfeature = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
      var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
      var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
      var APPVersion = '<%HW_WEB_GetAppVersion();%>';
      var IsPTVDF = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>';
      var langDescList = new Array();
      var apghnfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
      var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>';
      var CfgMode = '<%HW_WEB_GetCfgMode();%>';
      var ProductType = '<%HW_WEB_GetProductType();%>';
      var Ssid1 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.SSID);FT=HW_FT_FEATURE_PLDT%>';
      var Ssid2 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.SSID);FT=HW_FT_FEATURE_PLDT%>';
      var IsSingleWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SINGLE_WLAN);FT=HW_FT_FEATURE_PLDT%>';
      var IsDoubleWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);FT=HW_FT_FEATURE_PLDT%>';
      var DAUMLOGO = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_Web.X_WebLogo);%>';
      var DAUMFEATURE = "<%HW_WEB_GetFeatureSupport(FT_PRODUCT_DAUM);%>";
      var isLanAccess = '<%HW_WEB_IsNeedToInfoPage();%>';
      var tedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
      var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
      var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
      var Userlevel = 0;
      var isTruergT3 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>';
      var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
      var defaultUsername = '<%HW_WEB_GetSPEC(SPEC_DEFAULT_USERNAME.STRING);%>';
      var defaultPassword = '<%HW_WEB_GetSPEC(SPEC_DEFAULT_PASSWORD.STRING);%>';

      var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
      if(isBponFlag == '1') {
            var bponAPFttrDesc = 'Edge ONU';
            var isBPON866F = '<%HW_WEB_GetFeatureSupport(AMP_FT_IS_866F);%>';
            var isBponMainOnt = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
            if(isBponMainOnt != '1') {
                bponAPFttrDesc = 'AP';
            } else if (isBPON866F != '1') {
                bponAPFttrDesc = Var_DefaultLang == 'chinese' ? '从FTTR' : 'slaveFTTR';
            }
            sessionStorage.bponAPDescCache = bponAPFttrDesc;
      }

      langDescList["chinese"] = "简体中文"; //or just '中文'?
      langDescList["english"] = "English";
      langDescList["japanese"] = "日本語";
      langDescList["arabic"] = "العربية";
      langDescList["portuguese"] = "Português";
      langDescList["spanish"] = "Español";
      langDescList["turkish"] = "Türkçe";
      langDescList["brasil"] = "Brasil";
      langDescList["german"] = "German";
      langDescList["russian"] = "Русский";

      if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
        document.write('<script language="javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(crypto-js.js);%>"><\/script>');
      }

      if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
        document.write('<link rel="shortcut icon" href="/images/Dvodacom.ico" />');
        document.write('<link rel="Bookmark" href="/images/Dvodacom.ico" />');
      }

      if (DAUMFEATURE == 1) {
        document.write('<link rel="shortcut icon" href="/images/hwlogo.ico" />');
        document.write('<link rel="Bookmark" href="/images/hwlogo.ico" />');
      }

      var languageSet = new Array();

      if ((typeof languageList == 'string') && (languageList != ''))
        languageSet = languageList.split("|");

      if (Var_LastLoginLang == '') {
        Language = Var_DefaultLang;
      }
      else {
        Language = Var_LastLoginLang;
      }

      document.title = ProductName;

      if (DBAA1 == '1') {
        document.write('<link rel="shortcut icon" href="/images/A1_favicon.ico" />');
        document.write('<link rel="Bookmark" href="/images/A1_favicon.ico" />');
        document.title = GetLoginDes("frame023");
      }

      function genLanguageList() {
        if (languageList == '')
          return false;

        var ChangeLanguage = '';

        if (languageSet.length > 1) {
          for (var lang in languageSet) {
            ChangeLanguage += '<td width="47%" nowrap><a id="'
              + languageSet[lang] + '" href="#" name="'
              + languageSet[lang] + '" onClick="onChangeLanguage(this.id);" class="changelanguage">['
              + langDescList[languageSet[lang]] + ']</a></td>';
          }
          document.getElementById('chooselagButton').innerHTML = ChangeLanguage;
          document.getElementById('chooselag').style.display = "block";
        }
      }

      function GetLoginDes(DesId) {
        return framedesinfo[DesId];
      }

      function showlefttime() {
        if (LockLeftTime <= 0) {
          window.location = "/login.asp";
          return;
        }

        if (1 == IsPTVDF) {
          var html = GetLoginDes("frame011a") + LockLeftTime + GetLoginDes(LockLeftTime == 1 ? "frame012c" : "frame012d");
        }
        else if (1 == talktalkfeature) {
          $("#DivErrPagePlace").css({
            width: "19%",
          })
          $("#DivErrIconPlace").css({
            width: "81%",
          })
          var html = GetLoginDes("frame011TALKTALK") + LockLeftTime + GetLoginDes(LockLeftTime == 1 ? "frame012a" : "frame012");
        }
        else {
          var html = GetLoginDes("frame011") + LockLeftTime + GetLoginDes(LockLeftTime == 1 ? "frame012a" : "frame012");
        }

        SetDivValue("DivErrPromt", html);

        LockLeftTime = LockLeftTime - 1;
      }

      function setErrorStatus() {
        clearInterval(locklefttimerhandle);
        if (((LoginTimes != null) && (LoginTimes != '') && (LoginTimes > 0))
          || ("1" == FailStat) || (ModeCheckTimes >= errloginlockNum)) {
          document.getElementById('DivErrPage').style.display = 'block';
        }

        if ((CfgMode.toUpperCase() == 'TTNET2') && (FailStat == '2')) {
          document.getElementById('DivErrPage').style.display = 'block';
          SetDivValue("DivErrPromt", GetLoginDes("frame013b"));
          return;
        }

        if ('1' == FailStat) {
          if (ModeCheckTimes >= errloginlockNum) {
            SetDivValue("DivErrPromt", GetLoginDes("frame013a"));
          }
          else {
            SetDivValue("DivErrPromt", GetLoginDes("frame013"));
          }

          setDisable('txt_Username', 1);
          setDisable('txt_Password', 1);
          setDisable('loginbutton', 1);
        }
        else if (((parseInt(LoginTimes) >= parseInt(errloginlockNum)) || (parseInt(ModeCheckTimes) >= parseInt(errloginlockNum))) &&
          (parseInt(LockLeftTime) > 0)) {
          if (1 == IsPTVDF) {
            var desc = "frame012d";
            if (parseInt(LockLeftTime) == 1)
              desc = "frame012c";

            var html = GetLoginDes("frame011a") + LockLeftTime + GetLoginDes(desc);
          }
          else if (1 == talktalkfeature) {
            $("#DivErrPagePlace").css({
              width: "19%",
            })
            $("#DivErrIconPlace").css({
              width: "81%",
            })
            var html = GetLoginDes("frame011TALKTALK") + LockLeftTime + GetLoginDes(desc);
          }
          else {
            var desc = "frame012";
            if (parseInt(LockLeftTime) == 1)
              desc = "frame012a";

            var html = GetLoginDes("frame011") + LockLeftTime + GetLoginDes(desc);
          }

          SetDivValue("DivErrPromt", html);
          setDisable('txt_Username', 1);
          setDisable('txt_Password', 1);
          setDisable('loginbutton', 1);
          locklefttimerhandle = setInterval('showlefttime()', 1000);
        } else if ((parseInt(LoginTimes) > 0) && (parseInt(LoginTimes) < parseInt(errloginlockNum))) {
            if (talktalkfeature == 1) {
                $("#DivErrPagePlace").css({
                    width: "15%",
                })
                $("#DivErrIconPlace").css({
                    width: "85%",
                })
                SetDivValue("DivErrPromt", GetLoginDes("frame014TALKTALK"));
             } else if ((CfgMode.toUpperCase() == 'THAILANDNT2') || (CfgMode.toUpperCase() == 'TOT')) {
                 SetDivValue("DivErrPromt",  GetLoginDes("frame014Validate"));
             } else {
                SetDivValue("DivErrPromt", GetLoginDes("frame014"));
             }
        } else {
            document.getElementById('DivErrPage').style.display = 'none';
        }
      }

      function IsIEBrower(num) {
        var ua = navigator.userAgent.toLowerCase();
        var isIE = ua.indexOf("msie") > -1;
        var safariVersion;
        if (isIE) {
          safariVersion = ua.match(/msie ([\d.]+)/)[1];
          var sa = parseInt(safariVersion);
          if (safariVersion <= num) {
            alert(framedesinfo["frame016"]);
          }
        }
      }

      function LoadFrame() {
        if(useChallengeCode == 1) {
          document.getElementById('logincheckcode').style.display = "block";
          document.getElementById('txt_checkcode').innerHTML = randcode;
        }
        document.getElementById('txt_Username').focus();
        clearInterval(locklefttimerhandle);
        if (telmexwififeature == "1") {
          $("#accordion_help").css("display", "block");
          $("#logininfo").css({
            marginTop: "30px",
          })
          $(".contenboxlogin").css({
            height: "40px",
          })
        }
        else {
          $("#accordion_help").css("display", "none");
        }
        onChangeLanguage();
        if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
          $("#txt_Username").val(defaultUsername);
          $("#txt_Password").val(defaultPassword);
        }

        if (CfgMode.toUpperCase() == 'BRAZCLARO') {
          $("#main_wrapper").css("background-image", "url()");
          $("#main_wrapper").css("background-color", "rgb(218,41,28)");
          $("#DivErrPage").css("color", "#f8f8f8");
        }

        if (CfgMode.toUpperCase() == 'DICELANDVDF') {
          $("#main_wrapper").css("background-image", "url()");
          $("#main_wrapper").css("background", "#E60000");
          $("#DivErrPage").css("color", "#f8f8f8");
        }
                
        if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord_com == 'BRIDGE')) {
          document.getElementById('cmhkbridgeinfo').style.display = "";
        }

        init();

        if (CfgMode.toUpperCase() == 'COCLAROEBG4') {
          $("#attention").css("display", "");
        }
      }

      function SetCusLanguageInfo(language, activflag) {
        var node = document.getElementById(language);

        if ((null == node) || (undefined == node))
          return;

          if (CfgMode.toUpperCase() == 'AOUNITEL') {
		        node.style.color = (activflag ? "#9b0000" : "#000000");
	        } else {
		        node.style.color = (activflag ? "#9b0000" : "#FFFFFF");
	        }
        }

      function init() {
        if (document.addEventListener) {
          document.addEventListener("keypress", onHandleKeyDown, false);
        } else {
          document.onkeypress = onHandleKeyDown;
        }

        if (DBAA1 == "1") {
          document.getElementById('txt_Username').value = "admin";
        }
      }

      function onHandleKeyDown(event) {
        var e = event || window.event;
        var code = e.charCode || e.keyCode;

        if (code == 13) {
          LoginSubmit("loginbutton");
        }
      }

      function dealDataWithFun(str) {
        if (typeof str === 'string' && str.indexOf('function') === 0) {
          return Function('"use strict";return (' + str + ')')()();
        }
        return str;
      }

      function loginWithSha256(Username, Password) {
        var Form = new webSubmitForm();
        var infos;
        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          url: '/asp/GetRandInfo.asp?&1=1',
          data :'Username='+Username.value,
          success: function (data) {
            infos = dealDataWithFun(data);
          }
        });
        var pwdPbkf2 = CryptoJS.PBKDF2(Password.value, infos[1], {
          keySize: 8,
          hasher: CryptoJS.algo.SHA256,
          iterations: parseInt(infos[2])
        });
        var pwdSha256 = CryptoJS.SHA256(pwdPbkf2.toString());
        var cookie2 = "Cookie=body:" + "Language:" + Language + ":" + "id=-1;path=/";
        Form.addParameter('UserName', Username.value);
        var words = CryptoJS.enc.Utf8.parse(pwdSha256);
        var pwdBase64 = CryptoJS.enc.Base64.stringify(words);
        Form.addParameter('PassWord', pwdBase64);
        Form.addParameter('Language', Language);
        document.cookie = cookie2;
        Username.disabled = true;
        Password.disabled = true;
        Form.addParameter('x.X_HW_Token', infos[0]);
        Form.setAction('/login.cgi');
        Form.submit();
        return true;
      }

      function LoginSubmit(val) {
        var Username = document.getElementById('txt_Username');
        var Password = document.getElementById('txt_Password');
        var appName = navigator.appName;
        var version = navigator.appVersion;
        var CheckResult = 0;

        if (appName == "Microsoft Internet Explorer") {
          var versionNumber = version.split(" ")[3];
          if (parseInt(versionNumber.split(";")[0]) < 6) {
            alert(GetLoginDes('frame006'));
            return false;
          }
        }

        if (Username.value == "") {
          alert(GetLoginDes("frame007"));
          Username.focus();
          return false;
        }

        if ((DBAA1 != '1') && (Password.value == "")) {
          alert(GetLoginDes("frame009"));
          Password.focus();
          return false;
        }

        var cookie = document.cookie;
        if ("" != cookie) {
          var date = new Date();
          date.setTime(date.getTime() - 10000);
          var cookie22 = cookie + ";expires=" + date.toGMTString();
          document.cookie = cookie22;
        }

        if (CfgMode.toUpperCase() == 'PLDT' || CfgMode.toUpperCase() == 'PLDT2') {
          CheckResult = CheckPassword(Password.value);
          Userlevel = CheckResult;
          if (CheckResult == 1) {
            document.getElementById('base_mask').style.display = 'block';
            document.getElementById('pwd_modify').style.display = 'block';
            document.getElementById('old_password').focus();
            if (1 == IsSingleWifi) {
              document.getElementById('modify_pwd_ssid1').style.display = 'block';
              document.getElementById('modify_pwd_ssid2').style.display = 'none';
              document.getElementById('modify_pwd_label').style.display = 'block';
              document.getElementById('pwd_modify').style.height = '295px';
              document.getElementById('update').style.top = '90px';
              document.getElementById('ssid1_name').innerHTML = htmlencode(Ssid1);
              document.getElementById('ssid1_name_lebel').innerHTML = 'WiFi SSID:';
            } else if (1 == IsDoubleWifi) {
              document.getElementById('modify_pwd_ssid1').style.display = 'block';
              document.getElementById('modify_pwd_ssid2').style.display = 'block';
              document.getElementById('modify_pwd_label').style.display = 'block';
              document.getElementById('pwd_modify').style.height = '355px';
              document.getElementById('update').style.top = '150px';
              document.getElementById('ssid1_name').innerHTML = htmlencode(Ssid1);
              document.getElementById('ssid2_name').innerHTML = htmlencode(Ssid2);
              document.getElementById('ssid1_name_lebel').innerHTML = '2.4G WiFi SSID:';
            } else {
              document.getElementById('modify_pwd_ssid1').style.display = 'none';
              document.getElementById('modify_pwd_ssid2').style.display = 'none';
              document.getElementById('modify_pwd_label').style.display = 'none';
              document.getElementById('pwd_modify').style.height = '200px';
              document.getElementById('update').style.top = '15px';
            }
            return false;
          } else if (CheckResult == 2) {
            document.getElementById('base_mask').style.display = 'block';
            document.getElementById('pwd_modify').style.display = 'block';
            document.getElementById('old_password').focus();
            document.getElementById('modify_pwd_ssid1').style.display = 'none';
            document.getElementById('modify_pwd_ssid2').style.display = 'none';
            document.getElementById('modify_pwd_label').style.display = 'none';
            document.getElementById('pwd_modify').style.height = '200px';
            document.getElementById('update').style.top = '15px';
            return false;
          }
        }

        if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
          return loginWithSha256(Username, Password);
        }

        var cnt;
        var Form = new webSubmitForm();

        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          url: '/asp/GetRandCount.asp',
          success: function (data) {
            cnt = data;
          }
        });
        var Form = new webSubmitForm();
        var cookie2 = "Cookie=body:" + "Language:" + Language + ":" + "id=-1;path=/";
        Form.addParameter('UserName', Username.value);
        Form.addParameter('PassWord', base64encode(Password.value));
        Form.addParameter('Language', Language);
        document.cookie = cookie2;
        Username.disabled = true;
        Password.disabled = true;

        if ((CfgMode.toUpperCase() == 'TOT') || (CfgMode.toUpperCase() == 'THAILANDNT2')) {
          Form.addParameter('CheckCode', getValue('VerificationCode'));
          Form.setAction('login.cgi?' + '&CheckCodeErrFile=login.asp');
        } else {
          Form.setAction('/login.cgi');
        }

        Form.addParameter('x.X_HW_Token', cnt);
        Form.submit();
        return true;
      }

      function Refresh() {
        window.location.href = "/login.asp";
      }

      function onChangeLanguage(paralanguage) {
        if (paralanguage != null) {
          if (Language == paralanguage) //same language, do nothing
            return;

          SetCusLanguageInfo(Language, false); //deactivate old language

          Language = paralanguage;
        }
        var langSrc = "/frameaspdes/" + Language + "/ssmpdes.js";
        loadLanguage("langResource", langSrc, onLanguageChanged);
      }

      function onLanguageChanged() {
        ParseBindTextByTagName(framedesinfo, "span", 1);
        ParseBindTextByTagName(framedesinfo, "div", 1);
        ParseBindTextByTagName(framedesinfo, "input", 2);

        SetCusLanguageInfo(Language, true);//activate new language

        setErrorStatus();
      }

      function loadLanguage(id, url, callback) {
        var docHead = document.getElementsByTagName('head')[0];
        var langScript = document.getElementById(id);
        if (langScript != null) {
          docHead.removeChild(langScript);
        }

        try {
          langScript = document.createElement('script');
          langScript.setAttribute('type', 'text/javascript');
          langScript.setAttribute('src', url);
          langScript.setAttribute('id', id);
          if (callback != null) {
            langScript.onload = langScript.onreadystatechange = function () {
              if (langScript.ready) {
                return false;
              }
              if (!langScript.readyState || langScript.readyState == "loaded" || langScript.readyState == 'complete') {
                langScript.ready = true;
                callback();
              }
            };
          }
          docHead.appendChild(langScript);
        }
        catch (e) { }
      }


      function isValidAscii(val) {
        for (var i = 0; i < val.length; i++) {
          var ch = val.charAt(i);
          if (ch <= ' ' || ch > '~') {
            return false;
          }
        }
        return true;
      }

      function isLowercaseInString(str) {
        var lower_reg = /^.*([a-z])+.*$/;
        var MyReg = new RegExp(lower_reg);
        if (MyReg.test(str)) {
          return true;
        }
        return false;
      }

      function isUppercaseInString(str) {
        var upper_reg = /^.*([A-Z])+.*$/;
        var MyReg = new RegExp(upper_reg);
        if (MyReg.test(str)) {
          return true;
        }
        return false;
      }

      function isDigitInString(str) {
        var digit_reg = /^.*([0-9])+.*$/;
        var MyReg = new RegExp(digit_reg);
        if (MyReg.test(str)) {
          return true;
        }
        return false;
      }

      function isSpecialCharacterNoSpace(str) {
        var specia_Reg = /^.*[`~!@#\$%\^&\*\(\)_\+\-=\[\]\{\}\'\;\,\./:\"\?><\\\|]{1,}.*$/;
        var MyReg = new RegExp(specia_Reg);
        if (MyReg.test(str)) {
          return true;
        }
        return false;
      }

      function CompareString(srcstr, deststr) {
        var reverestr = (srcstr.split("").reverse().join(""));
        if (srcstr == deststr) {
          return false;
        }

        if (reverestr == deststr) {
          return false;
        }
        return true;
      }

      function CheckPwdIsComplex(str) {
        var Username = document.getElementById('txt_Username');
        var i = 0;

        if (str.length < pwdLen) {
          return false;
        }

        if (!CompareString(str, Username.value)) {
          return false;
        }

        if (isLowercaseInString(str)) {
          i++;
        }

        if (isUppercaseInString(str)) {
          i++;
        }

        if (isDigitInString(str)) {
          i++;
        }

        if (isSpecialCharacterNoSpace(str)) {
          i++;
        }

        if (i >= 2) {
          return true;
        }
        return false;
      }

      function CheckPassword(PwdForCheck) {
        var Username = document.getElementById('txt_Username');
        var NormalPwdInfo = FormatUrlEncode(PwdForCheck);
        var CheckResult = 0;
        var url_check_pwd = 0;

        var ParaArrayList = "UserNameInfo=" + Username.value;
        ParaArrayList += "&NormalPwdInfo=" + NormalPwdInfo;

        url_check_pwd = '/asp/CheckPwdNotLogin.asp?&1=1';

        $.ajax({
          type: "POST",
          async: false,
          cache: false,
          url: url_check_pwd,
          data: ParaArrayList,
          success: function (data) {
            CheckResult = data;
          }
        });
        return CheckResult;
      }

      function isHexaDigit(digit) {
        var hexValues = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "a", "b",
          "c", "d", "e", "f");
        var len = hexValues.length;
        for (var i = 0; i < len; i++) {
          if (digit == hexValues[i]) {
            return true;
          }
        }

        return false;
      }

      function isValidWPAPskKey(val) {
        var len = val.length;
        var maxSize = 64;
        var minSize = 8;

        if (isValidAscii(val) != '') {
          return false;
        }

        if ((len >= minSize) && (len < maxSize)) {
          return true;
        }

        if (len == maxSize) {
          for (i = 0; i < maxSize; i++) {
            if (isHexaDigit(val.charAt(i)) == false) {
              return false;
            }
          }
          return true;
        }

        return false;
      }

      function CheckPasswordSsid1() {
        /* 管理员账户不强制修改WiFi，当然也不需要去校验修改的WiFi，直接返回true */
        if (Userlevel == 2) {
          return true;
        }
        /* 没有WiFi不校验修改的WiFi，直接返回true */
        if ((IsSingleWifi != 1) && (IsDoubleWifi != 1)) {
          return true;
        }
        if (isValidWPAPskKey(getValue('ssid1_password')) == false) {
          return false;
        }
        return true;
      }
      function CheckPasswordSsid2() {
        if (Userlevel == 2) {
          return true;
        }

        if ((IsSingleWifi != 1) && (IsDoubleWifi != 1)) {
          return true;
        }

        if (IsSingleWifi == 1) {
          return true;
        }
        if (isValidWPAPskKey(getValue('ssid2_password')) == false) {
          return false;
        }
        return true;
      }

      function getValue(sId) {
        var item;
        if (null == (item = getElement(sId))) {
          debug(sId + " is not existed");
          return -1;
        }

        return item.value;
      }

      function CheckParameter() {
        var oldPassword = document.getElementById("old_password");
        var newPassword = document.getElementById("new_password");
        var cfmPassword = document.getElementById("confirm_password");
        var CheckResult = 0;
        var CheckResultPwdSsid1 = 0;
        var CheckResultPwdSsid2 = 0;

        if (oldPassword.value == "") {
          alert("The old password cannot be left blank.");
          return false;
        }

        if (newPassword.value == "") {
          alert("The new password cannot be left blank.");
          return false;
        }

        if (newPassword.value.length > 127) {
          alert("The password must consist of 1 to 127 characters.");
          return false;
        }

        if (!isValidAscii(newPassword.value)) {
          alert("The new password contains invalid characters. Enter a valid one.");
          return false;
        }

        if (cfmPassword.value != newPassword.value) {
          alert("The confirm password is different from the new password.");
          return false;
        }

        CheckResultPwdSsid1 = CheckPasswordSsid1();
        if (CheckResultPwdSsid1 != 1) {
          alert("The wifi password of " + Ssid1 + " must be between 8 and 63 characters or 64 hexadecimal characters.");
          return false;
        }
        CheckResultPwdSsid2 = CheckPasswordSsid2();
        if (CheckResultPwdSsid2 != 1) {
          alert("The wifi password of " + Ssid2 + " must be between 8 and 63 characters or 64 hexadecimal characters.");
          return false;
        }
        CheckResult = CheckPassword(oldPassword.value);

        if (CheckResult != 1) {
          alert("Incorrect old password. Please retry.");
          return false;
        }

        if (!CheckPwdIsComplex(newPassword.value)) {
          alert("The password strength is too weak. Configure it again.");
          return false;
        }

        return true;
      }

      function SubmitUpdate() {
        var Username = document.getElementById('txt_Username');

        if (!CheckParameter()) {
          return false;
        }

        var Form = new webSubmitForm();



        if (Userlevel == 1) {
          if (1 == IsSingleWifi) {
            Form.addParameter('x.PreSharedKey', getValue('ssid1_password'));
            Form.addParameter('z.Password', getValue('new_password'));
            Form.addParameter('x.X_HW_Token', getAuthToken());
            Form.setAction('MdfPwdNormalNoLg.cgi?&x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1&z=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1&RequestFile=login.asp');
          }
          else if (1 == IsDoubleWifi) {
            Form.addParameter('x.PreSharedKey', getValue('ssid1_password'));
            Form.addParameter('y.PreSharedKey', getValue('ssid2_password'));
            Form.addParameter('z.Password', getValue('new_password'));
            Form.addParameter('x.X_HW_Token', getAuthToken());
            Form.setAction('MdfPwdNormalNoLg.cgi?&x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1&y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.PreSharedKey.1&z=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1&RequestFile=login.asp');
          }
          else {
            Form.addParameter('z.Password', getValue('new_password'));
            Form.addParameter('x.X_HW_Token', getAuthToken());
            Form.setAction('MdfPwdNormalNoLg.cgi?&z=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1&RequestFile=login.asp');
          }
        }
        else if (Userlevel == 2) {
          Form.addParameter('z.Password', getValue('new_password'));
          Form.addParameter('x.X_HW_Token', getAuthToken());
          Form.setAction('MdfPwdAdminNoLg.cgi?&z=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.2&RequestFile=login.asp');
        }

        Form.submit();
      }

      function BthRefresh() {
        document.getElementById("imgcode").src = 'getCheckCode.cgi?&rand=' + new Date().getTime();
      }

      function TotBthRefresh() {
        document.getElementById("totimgcode").src = 'getCheckCode.cgi?&rand=' + new Date().getTime();
      }

      function GetRandomNum(min, max) {
        return Math.floor(Math.random() * (max - min) + min);
      }

      function CanvasDrawRandomLineAndPoint(canvasId, linesCount, maxLineLength, pointsCount) {
        var canvasImgCode = document.getElementById(canvasId);
        var width = canvasImgCode.width;
        var height = canvasImgCode.height;

        var canvasContext = canvasImgCode.getContext("2d");
        canvasContext.clearRect(0, 0, width, height);

        var arrayLineColor = new Array("#9ccc65", "#ffee58", "#d4e157", "#ffca28", "#ffab91", "#ffb74d", "#f48fb1", "#e1bee7");
        var lineColorCount = arrayLineColor.length;
        var arrayPointColor = new Array("#738ffe", "#9ccc65", "#ffee58", "#d4e157", "#ffca28", "#ffab91", "#ffb74d", "#673ab7", "#3f5165", "#9c27b0", "#e91e63");
        var pointColorCount = arrayPointColor.length;

        for (var i = 0; i < linesCount; i++) {
          var x1 = GetRandomNum(0, width);
          var y1 = GetRandomNum(0, height);
          var x2 = GetRandomNum(0, width);
          var y2 = GetRandomNum(0, height);

          if ((x2 - x1) > maxLineLength) {
            x2 = x1 + maxLineLength;
          } else if ((x2 - x1) < (-maxLineLength)) {
            x2 = x1 - maxLineLength;
          }

          canvasContext.beginPath();
          canvasContext.moveTo(x1, y1);
          canvasContext.lineTo(x2, y2);
          canvasContext.closePath();

          var grdl = canvasContext.createLinearGradient(x1, y1, x2, y2);
          grdl.addColorStop(0, arrayLineColor[GetRandomNum(0, lineColorCount - 1)]);
          grdl.addColorStop(Math.random(), arrayLineColor[GetRandomNum(0, lineColorCount - 2)]);
          grdl.addColorStop(1, arrayLineColor[GetRandomNum(0, lineColorCount - 2)]);

          canvasContext.lineWidth = 1;
          canvasContext.strokeStyle = grdl;
          canvasContext.stroke();
        }

        for (var i = 0; i < pointsCount; i++) {
          canvasContext.fillStyle = arrayPointColor[i % (pointColorCount - 1)];
          canvasContext.beginPath();
          canvasContext.arc(GetRandomNum(0, width), GetRandomNum(0, height), Math.random() + 1, 0, Math.PI * 2, true);
          canvasContext.closePath();
          canvasContext.fill();
        }
      }

    </script>
</head>

<body onLoad="LoadFrame();">
  <div id="base_mask" style=""></div>
  <div id="pwd_modify" style="display:none;">
    <div>
      <li
        style="position: relative;top:10px; width: 500px;left: 100px; list-style-type: none; color: red; font-weight: bold; font-size: 14px;">
        <div>The login password is the default one. Change it immediately.</div>
      </li>
    </div>

    <div>
      <ul
        style="position:absolute; clear:both; list-style-type: none; top:30px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
        <li style="position: relative; top: 0px; width: 130px;">
          <div align="right">Old Password:</div>
        </li>
        <li style="position: relative; top: 10px; width: 130px;">
          <div align="right">New Password:</div>
        </li>
        <li style="position: relative; top: 20px; width: 130px;">
          <div align="right">Confirm Password:</div>
        </li>
      </ul>

      <ul
        style="color:#FFFFFF; position:absolute; top:30px; left:94px; height:15px; list-style-type:none; line-height:30px;">
        <li><input name="old_password" id="old_password" type="password" autocomplete="off" size="20"
            style="position: absolute; top: 5px; font-size:13px; width:180px;" /></li>
        <li><input name="new_password" id="new_password" type="password" autocomplete="off" size="20"
            style="position: absolute; top: 45px; font-size: 13px; width:180px; " /></li>
        <li><input name="confirm_password" id="confirm_password" type="password" autocomplete="off" size="20"
            style="position: absolute; top: 85px; font-size:13px; width:180px;" /></li>
      </ul>

      <ul
        style="position:absolute; clear:both; list-style-type: none; top:30px; left:290px; height:15px; line-height:16px; font-size: 12px;">
        <li style="position: relative; top: 0px; width: 280px;">
          <div align="left">1.The password must contain at least 8 characters.<br />2.The password must contain at least
            two of the following combinations:Digit, uppercase letter, lowercase letter, Special characters (` ~ ! @ # $
            % ^ & * ( ) - _ = + \\ | [ { } ] ; : ' \" < , .> / ?).<br />3.The password cannot be any user name or user
              name in reverse order.</div>
        </li>
      </ul>
    </div>
    <div id="modify_pwd_label">
      <li
        style="position: relative;top:150px; width: 500px; list-style-type: none; color: red; font-weight: bold; font-size: 14px;">
        <div>Modify the wifi password</div>
      </li>
    </div>
    <div id="modify_pwd_ssid1">
      <ul
        style="position:absolute; clear:both; list-style-type: none; top:175px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
        <li style="position: relative; top: 0px; width: 130px;">
          <div id="ssid1_name_lebel" align="right"></div>
        </li>
        <li style="position: relative; top: 0px; width: 130px;">
          <div align="right">WiFi Password:</div>
        </li>
      </ul>
      <ul
        style="color:#FFFFFF; position:absolute; top:175px; left:94px; height:15px; list-style-type:none; line-height:30px;">
        <li id="ssid1_name" style="position: absolute; top: 0px; font-size: 13px; width:180px; color: #000000; "></li>
        <li><input name="ssid1_password" id="ssid1_password" type="password" autocomplete="off" size="20"
            style="position: absolute; top: 35px; font-size:13px; width:180px;" /></li>
      </ul>
      <ul
        style="position:absolute; clear:both; list-style-type: none; top:175px; left:290px; height:15px; line-height:20px; font-size: 12px;">
        <li style="position: relative; top: 35px; width: 280px;">
          <div align="left">(8-63 characters or 64 hexadecimal characters)</div>
        </li>
      </ul>

    </div>
    <div id="modify_pwd_ssid2">
      <ul
        style="position:absolute; clear:both; list-style-type: none; top:235px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
        <li style="position: relative; top: 0px; width: 130px;">
          <div align="right">5G WiFi SSID:</div>
        </li>
        <li style="position: relative; top: 0px; width: 130px;">
          <div align="right">WiFi Password:</div>
        </li>
      </ul>
      <ul
        style="color:#FFFFFF; position:absolute; top:235px; left:94px; height:15px; list-style-type:none; line-height:30px;">
        <li id="ssid2_name" style="position: absolute; top: 0px; font-size: 13px; width:180px; color: #000000; "></li>
        <li><input name="ssid2_password" id="ssid2_password" type="password" autocomplete="off" size="20"
            style="position: absolute; top: 35px; font-size:13px; width:180px;" /></li>
      </ul>
      <ul
        style="position:absolute; clear:both; list-style-type: none; top:235px; left:290px; height:15px; line-height:20px; font-size: 12px;">
        <li style="position: relative; top: 35px; width: 280px;">
          <div align="left">(8-63 characters or 64 hexadecimal characters)</div>
        </li>
      </ul>
    </div>

    <div id="update" style="position: relative;">
      <div style="float: left; margin-top: 135px; margin-left: 180px;">
        <button id="button_update" style="width: 80px; height: 23px;" onclick="SubmitUpdate();">Update</button>
        <div>&nbsp;</div>
      </div>
    </div>

  </div>

  <div id="main_wrapper">
    <div id="loginarea">
      <script>
        if (true == logo_singtel) {
          document.write('<div id="brandlog_singtel" style="display:none;"></div>');
        }
        else if ('TELECENTRO' == CfgMode.toUpperCase()) {
          document.write('<div id="brandlog_telecentro" style="display:none;"></div>');
        }
        else if (CfgMode.toUpperCase() == 'CLARODR') {
          document.write('<div id="brandlog_clarodr" style="display:none;"></div>');
        }
        else if ('PLDT2' == CfgMode.toUpperCase() || 'PLDT' == CfgMode.toUpperCase()) {
          document.write('<div id="brandlog_pldt" style="display:none;"></div>');
        }
        else if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
          document.write('<div id="brandlog_antel" style="display:none;"></div>');
        }
        else if ('MAROCTELECOM' == CfgMode.toUpperCase()) {
          document.write('<div id="brandlog_maroctelecom" style="display:none;"></div>');
        }
        else if ('ORANGEMT' == CfgMode.toUpperCase()) {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>' + '<img id="brandlog_orangemt" src="images/hwlogo_orangemt.gif" width="48px"></img>' + '<div  id="ProductNameOrg">' + ProductName + '</div>' + '</div>');
        }
        else if (CfgMode.toUpperCase() == 'PARAGUAYPSN') {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>' + '<img id="brandlog_paraguaypsn" src="images/hwlogo_paraguaypsn.gif" width="140px"></img>' + '<div  id="ProductNamePar">' + ProductName + '</div>' + '</div>');
        } else if (CfgMode.toUpperCase() == 'MYTIME') {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 12px"></div>' + '<img id="brandlog_mytime" src="images/hwlogo_mytime.gif" width="140px"></img>' + '<div  id="ProductNamePar">' + ProductName + '</div>' + '</div>');
        } else if (isTruergT3 == 1) {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>' + '<img id="brandlog_truerg" src="images/hwlogo_truergpwdsn.gif" width="48px"></img>' + '<div  id="ProductNameTruergPwdsn">' + ProductName + '</div>' + '</div>');
        }
        else if ((DAUMFEATURE == 1) && (DAUMLOGO == 1)) {
          document.write('<div id="brandlog_daum_iprimus" style="display:none;"></div>');
        }
        else if ((DAUMFEATURE == 1) && (DAUMLOGO == 2)) {
          document.write('<div id="brandlog_daum_dodo" style="display:none;"></div>');
        }
        else if ((DAUMFEATURE == 1) && (DAUMLOGO == 3)) {
          document.write('<div id="brandlog_daum_commander" style="display:none;"></div>');
        }
        else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase()) {
          document.write('<div id="brandlog_dnztelecom" style="display:none;"></div>');
        }
        else if ('TM' == CfgMode.toUpperCase()) {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 40px"></div>' + '<img id="brandlog_tm" src="images/hwlogo_tm.gif" width="100px"></img>' + '<div id="ProductNameTm">' + ProductName + '</div>' + '</div>');
        }
        else if ('OMANONT' == CfgMode.toUpperCase() || 'OMANONT2' == CfgMode.toUpperCase()) {
          document.write('<div id="brandlog_oman" style="display:none;"></div>');
        } else if (CfgMode.toUpperCase() == "BRAZCLARO") {
          document.write('<div id="brandlog_claro" style="display:none;"></div>');
        } else if (DBAA1 == '1') {
          document.write('<div id="brandlog_dbaa1"></div>');
        } else if (tedataGuide == 1) {
          if (TypeWord_com == "ACUD") {
            document.write('<div id="brandlog" style="display:none;"></div>');
            $("#brandlog").css("background", "url(images/tedate_acud.jpg) no-repeat center");
            $("#brandlog").css("width", "60PX");
            $("#brandlog").css("marginRight", "10PX");
          } else {
            document.write('<div id="brandlog" style="display:none;"></div>');
            $("#brandlog").css("background", "url(images/yptlogo.jpg) no-repeat center");
            $("#brandlog").css("width", "60PX");
          }
        } else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>' + '<img id="brandlog_dethmaxis" src="images/hwlogo_dethmaxis.gif" width="65px"></img>' + '<div id="ProductNameDethmaxis">' + ProductName + '</div>' + '</div>');
        } else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
          document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>' + '<img id="brandlog_cypruscyta" src="images/hwlogo_cyta.jpg" width="140px"></img>' + '<div id="ProductNameCypruscyta">' + ProductName + '</div>' + '</div>');
        } else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
                document.write('<div id="brandlog_commonrmhw" style="display:none;"></div>');
        } else if (htFlag == 1) {
          document.write('<div id="brandlog_ht" style="display:none;"></div>');
        } else if (oteFlag == 1) {
          document.write('<div id="brandlog_ote" style="display:none;"></div>');
        } else if (CfgMode.toUpperCase() == 'AWASR') {
        	document.write('<div id="brandlog_awasr" style="display:none;"></div>');
        } else if (CfgMode.toUpperCase() == 'AOUNITEL') {
                document.write('<div id="brandlog_aounitel" style="display:none;"></div>');
        } else {
          document.write('<div id="brandlog" style="display:none;"></div>');
        }
      </script>
      <script>
        if (logo_singtel == true) {
          document.write('<div id="ProductName" style="text-align:right; margin-left:630px;">' + ProductName + '</div>');
        } else if (DBAA1 == '1') {
          document.write('<div id="ProductName" bindText="frame024"></div>');
        } else if (('TM' !== CfgMode.toUpperCase()) && ('ORANGEMT' !== CfgMode.toUpperCase())
          && ('PARAGUAYPSN' !== CfgMode.toUpperCase()) && (isTruergT3 != 1) && (CfgMode.toUpperCase() !== 'MYTIME')
          && (CfgMode.toUpperCase() != 'DETHMAXIS') && (CfgMode.toUpperCase() != 'CYPRUSCYTA')) {
          if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
            document.write('<div id="ProductName" style="float:left;">' + ProductName + '</div>');
            document.write('<div style="clear:both;">' + '</div>');
          } else if(CfgMode.toUpperCase() == 'AOUNITEL') {
                        document.write('<div id="ProductName"></div>');
          } else {
            document.write('<div id="ProductName">' + ProductName + '</div>');
          }
        }
      </script>
      <script>
        if (true == mngttype) {
          document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004SONET"></span></div>');
        }
        else if (true == logo_singtel) {
          if (TypeWord_com == "COMMON") {
            document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004SINGTELHS"></span></div>');
          }
          else {
            document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004SINGTEL"></span></div>');
          }

        }

        else {
          if (smartlanfeature == 1) {
            if ("" != curChangeMode && 0 != curChangeMode || apghnfeature == 1) {
              document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame005lan"></span></div>');
            }
            else if (1 == IsSmartDev) {
              if (CfgMode.toUpperCase() != 'TURKCELL2') {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004lan"></span></div>');
              }
            } else {
              if (CfgMode.toUpperCase() != 'TURKCELL2') {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame005lan"></span></div>');
              }
            }
          }
          else {
            if (ProductType == '2') {
              if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
                document.write('<div id="welcomtext"><span class="welcometitle_dvodacom" id ="spanwelcomtext" BindText="frame004telmex"></span></div>');
              } else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004MAXIS"></span></div>');
              } else if (CfgMode.toUpperCase() == 'DBAA1') {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004dbaa1"></span></div>');
              } else if (CfgMode.toUpperCase() == 'DCORIOLIS2WIFI') {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004coriolis"></span></div>');
              } else {
                if (CfgMode.toUpperCase() != 'TURKCELL2') {
                  document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004telmex"></span></div>');
                }
              }
            }
            else {
              if (isTruergT3 == 1) {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004SONET"></span></div>');
              } else if (tedataGuide == 1) {
                document.write('<div id="welcomtext" style="margin-top:0;"><span class="welcometitle" id ="spanwelcomtext" BindText=""></span></div>');
              } else if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004AOUNITEL"></span></div>');
						  } else if (CfgMode.toUpperCase() != 'TURKCELL2') {
                document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004"></span></div>');
              }
            }
          }
        }
      </script>
      <div id="cmhkbridgeinfo" style="display:none;"><span style="font-size:16px;color:#FF0033;" BindText="frame030"></span></div>
      <div id="logininfo">
        <div id="chooselag" class="changelanguageline" style="display:none;">
          <div class="changelanguageleft"></div>
          <div id="chooselagButton" class="changelanguageright"></div>
        </div>

        <div id="loginuser" class="contentItemlogin">
          <div class="labelBoxlogin"><span id="account" BindText="frame001"></span></div>
          <div class="contenboxlogin"><input type="text" id="txt_Username" name="txt_Username" class="logininputcss" />
          </div>
        </div>

        <div id="loginpwd" class="contentItemlogin">
          <div class="labelBoxlogin"><span id="Password" BindText="frame002"></span></div>
          <div class="contenboxlogin"><input type="password" autocomplete="off" id="txt_Password" name="txt_Password"
              class="logininputcss" autocomplete="off" /></div>
        </div>
        <div id="logincheckcode" class="contentItemlogin" style="display:none;">
          <div class="labelBoxlogin">
            <span id="Password" BindText="frame002MEGACABLE" />
          </div>
          <div class="contenboxlogin">
            <span class="labelBoxlogin" style="text-align:left;" id="txt_checkcode" name="txt_checkcode"/>
          </div>
        </div>
        <table id="tablecheckcode" border="0" cellpadding="0" cellspacing="0" width="100%" style="display: none">
          <tr>
            <td height="8"></td>
          </tr>
          <tr>
            <td>
              <div class="labelBoxlogin"><span id="Validate" BindText="frameValidate1"></span></div>
              <div id="imgCheckCode">
                <img id="imgcode">
                <canvas id="canvasDrawImgcode" width="150" height="35"></canvas>
              </div>
            </td>
          </tr>
        </table>
        <script language="JavaScript" type="text/javascript">
          if ('TRUERG' == CfgMode.toUpperCase()) {
            if ("1" == isLanAccess) {
              document.getElementById('tablecheckcode').style.display = '';
              document.getElementById("imgcode").src = 'getCheckCode.cgi?&rand=' + new Date().getTime();
              CanvasDrawRandomLineAndPoint("canvasDrawImgcode", GetRandomNum(3, 5), 70, GetRandomNum(20, 30));
              var browser = navigator.appName
              var b_version = navigator.appVersion
              var version = b_version.split(";");
              var trim_Version = version[1].replace(/[ ]/g, "");
              if (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE8.0") {
                document.getElementById('imgcode').style.marginLeft = '0'
              }
              else if (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE9.0") {
                document.getElementById('imgcode').style.marginLeft = '0'
              }
            }
          }
        </script>
        <div class="accordion" id="accordion_help">
          <div id="user_find" class="ember-view accordion-group">
            <div class="accordion-heading marginright_35">
              <div id="collapseinfo_1"
                class="text_center paddingright_15 index_page_font_color accordion-toggle text_underline">
                <span id="i18n-0" BindText="frame0161"></span>
              </div>
            </div>

            <div id="collapse_1" class="hide">
              <div class="accordion-inner">
                <div class="rounddiv getaccount_part">
                  <div class="bodydiv rounddiv paddingtop_8 getaccount_part_body index_page_font_color" align="center">
                    &nbsp;&nbsp;&nbsp;
                    <span id="i18n-1" BindText="frame017"></span>
                  </div>
                  <div class="bodydiv rounddiv getaccount_info paddingbottom_20" align="center">
                    <div class="index_page_font_color text_left">
                      <span id="i18n-2" BindText="frame018"></span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div id="user_restore" class="ember-view accordion-group margintop_15">
            <div class="accordion-heading marginright_35">
              <div id="collapseinfo_2"
                class="text_center paddingright_15 index_page_font_color accordion-toggle text_underline">
                <span id="i18n-3" BindText="frame019"></span>
              </div>
            </div>
            <div id="collapse_2" class="hide">
              <div class="accordion-inner">
                <div class="rounddiv getaccount_part">
                  <div class="bodydiv rounddiv paddingtop_8 getaccount_part_body index_page_font_color">
                    &nbsp;&nbsp;&nbsp;
                    <span id="i18n-4" BindText="frame020"></span>
                  </div>
                  <div class="getaccount_info rounddiv">
                    <div class="bodydiv rounddiv">
                      <div class="text_left index_page_font_color" BindText="frame021">

                      </div>
                      <div class="text_left">
                        <font color="#FF0000">
                          <span id="i18n-5" BindText="frame022"></span>
                        </font>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>


        <div id="loginbuttondiv" class="contentItemlogin">
          <div id="tottablecheckcode" border="0" cellpadding="0" cellspacing="0" width="100%" style="display: none">
            <div class="labelBoxlogin">
              <span class="whitebold" height="28" align="right" id="Validate">Validate Code :&nbsp;</span>
            </div>
            <div class="contenboxlogin"><input class="logininputcss" id="VerificationCode" name="VerificationCode"
                type="text"></div>
            <div class="contenboxlogin" style="margin-top:5px;">
              <img id="totimgcode" style="height:30px;width:100px;" align="left" onClick="TotBthRefresh();">
              <span>&nbsp;</span>
              <input type="button" id="changecode" style="width:58px;margin-top:5px;" align="left" class="submit"
                value="Refresh" onClick="TotBthRefresh();" />
            </div>
            <div class="contenboxlogin"><input type="button" class="whitebuttonBlueBgcss buttonwidth_237px"
                id="loginbutton" onClick="LoginSubmit(this.id);" value="" BindText="frame003" /></div>
          </div>
          <script type="text/javascript">
            if (CfgMode.toUpperCase() == 'DNZTELECOM2WIFI') {
              document.write('<div class="contenboxlogin"><input type="button"  class="greenbuttonBlueBgcss buttonwidth_237px" id="loginbutton" onClick="LoginSubmit(this.id);" value="" BindText="frame003" /></div>');
            } else if ((CfgMode.toUpperCase() == 'TOT') || (CfgMode.toUpperCase() == 'THAILANDNT2')) {
              document.getElementById('tottablecheckcode').style.display = 'block';
              document.getElementById("totimgcode").src = 'getCheckCode.cgi?&rand=' + new Date().getTime();
            } else {
              document.write('<div class="contenboxlogin"><input type="button"  class="whitebuttonBlueBgcss buttonwidth_237px" id="loginbutton" onClick="LoginSubmit(this.id);" value="" BindText="frame003" /></div>');
            }
          </script>
        </div>
        <div id="DivErrPage" class="contentItemlogin">
          <div id="DivErrPagePlace" class="labelBoxlogin"></div>
          <div id="DivErrIconPlace" class="contenboxlogin">
            <div id="DivErrIcon"></div>
            <div id="DivErrPromt"></div>
          </div>
        </div>
        <div id="attention"
          style="text-align:left;margin-top:30px;width:680px;margin-left:650px;color:ffffff;font-size:12px;display:none">
          <script type="text/javascript">
            if (CfgMode.toUpperCase() == 'COCLAROEBG4') {
              document.write('<span>ATENCION:</br>Este equipo es propiedad de:</br>CLARO COLOMBIA - SOLUCIONES FIJAS</br>El uso no autorizado esta estrictamente prohibido.</br>Todos los usuarios son legalmente responsables de sus acciones sobre el sistema y toda actividad sera registrada.</span>');
            }
          </script>
        </div>
      </div>
    </div>
    <div id="greenline"></div>
    <div id="copyright">
      <div id="copyrightspace"></div>
      <div id="copyrightlog" style="display:none;"></div>
      <script type="text/javascript">
        if (CfgMode.toUpperCase() == 'SONETSGP300B') {
          document.write('<div id="copyrighttext"><span id="footer" BindText="frame015b"></span></div>');
        } else {
          document.write('<div id="copyrighttext"><span id="footer" BindText="frame015a"></span></div>');
        }
      </script>
    </div>

  </div>
  <script type="text/javascript">
    $(document).ready(function () {
      $('#i18n-0').click(function () {
        $('#collapse_2').css("display", "none");
        $('#collapse_1').toggle('fast', function () {
        });
      });
      $('#i18n-3').click(function () {
        $('#collapse_1').css("display", "none");
        $('#collapse_2').toggle('fast');
      });

    })
  </script>

  <script>
    ParseBindTextByTagName(framedesinfo, "span", 1);
    ParseBindTextByTagName(framedesinfo, "input", 2);
    genLanguageList();
    if (true != mngttype) {
      if (true == logo_singtel) {
        if (TypeWord_com == "COMMON") {
          document.getElementById('brandlog_singtel').style.display = 'none';
        }
        else {
          document.getElementById('brandlog_singtel').style.display = 'block';
        }
      }
      else if (telmexwififeature == 1) {
        $("#main_wrapper").css("background-image", "url(../images/loginbg_telmex.jpg)");
        $("#brandlog_telmex").css("width", "187px");
        $("#brandlog_telmex").css("height", "63px");
        $("#ProductName").css("line-height", "54px");
        document.getElementById('brandlog_telmex').style.display = 'block';
      }
      else if ('TELECENTRO' == CfgMode.toUpperCase()) {
        document.getElementById('brandlog_telecentro').style.display = 'block';
      }
      else if (CfgMode.toUpperCase() == 'CLARODR') {
        document.getElementById('brandlog_clarodr').style.display = 'block';
      }
      else if ('PLDT2' == CfgMode.toUpperCase() || 'PLDT' == CfgMode.toUpperCase()) {
        document.getElementById('brandlog_pldt').style.display = 'block';
      }
      else if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
        document.getElementById('brandlog_antel').style.display = 'block';
        $("#brandlog_antel").css("width", "92PX");
        $("#ProductName").css("line-height", "60PX");
      }
      else if ('MAROCTELECOM' == CfgMode.toUpperCase()) {
        document.getElementById('brandlog_maroctelecom').style.display = 'block';
      }
      else if ('ORANGEMT' == CfgMode.toUpperCase()) {
        document.getElementById('brandlog_orangemt').style.display = 'block';
      }
      else if (CfgMode.toUpperCase() == 'PARAGUAYPSN') {
        document.getElementById('brandlog_paraguaypsn').style.display = 'block';
      } else if (CfgMode.toUpperCase() == 'MYTIME') {
        document.getElementById('brandlog_mytime').style.display = 'block';
      } else if (isTruergT3 == 1) {
        document.getElementById('brandlog_truerg').style.display = 'block';
      } else if ('DETHMAXIS' == CfgMode.toUpperCase()) {
        document.getElementById('brandlog_dethmaxis').style.display = 'block';
      } else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
        document.getElementById('brandlog_cypruscyta').style.display = 'block';
      } else if ((DAUMFEATURE == 1) && (DAUMLOGO == 1)) {
        document.getElementById('brandlog_daum_iprimus').style.display = 'block';
      }
      else if ((DAUMFEATURE == 1) && (DAUMLOGO == 2)) {
        document.getElementById('brandlog_daum_dodo').style.display = 'block';
      }
      else if ((DAUMFEATURE == 1) && (DAUMLOGO == 3)) {
        document.getElementById('brandlog_daum_commander').style.display = 'block';
      }
      else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase()) {
        $("#main_wrapper").css("background-image", "url()");
        $("#main_wrapper").css("background-color", "#ffffff");
        $("#ProductName").css("color", "#00ad65");
        $("#ProductName").css("line-height", "70px");
        $("#spanwelcomtext").css("color", "#666666");
        $("#account").css("color", "#666666");
        $("#Password").css("color", "#666666");
        document.getElementById('brandlog_dnztelecom').style.display = 'block';
        $("#txt_Username").css("color", "#666666");
        $("#txt_Username").css("border-color", "#666666");
        $("#txt_Password").css("color", "#666666");
        $("#txt_Password").css("border-color", "#666666");
      }
      else if ('TM' == CfgMode.toUpperCase()) {
        document.getElementById('logininfo').style.marginTop = '70px';
      }
      else if ('OMANONT' == CfgMode.toUpperCase() || 'OMANONT2' == CfgMode.toUpperCase()) {
        document.getElementById('brandlog_oman').style.display = 'block';
      } else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
        document.getElementById('brandlog_claro').style.display = 'block';
      } else if (DBAA1 == '1') {
        document.getElementById('brandlog_dbaa1').style.display = 'block';
      } else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
        $("#main_wrapper").css("background-image", "url()");
        $("#ProductName").css("font-size", "22px");
        $("#ProductName").css("line-height", "73px");
        $("#ProductName").css("color", "#FFFFFF");
        $("#ProductName").css("margin-left", "162px");
        $("#copyrightlog").css("background-image", "url()");
        document.getElementById('brandlog_commonrmhw').style.display = 'block';
      } else if (htFlag == 1) {
        document.getElementById('brandlog_ht').style.display = 'block';
      } else if (oteFlag == 1) {
        document.getElementById('brandlog_ote').style.display = 'block';
      } else if (CfgMode.toUpperCase() == 'AWASR') {
        document.getElementById('brandlog_awasr').style.display = 'block';
      } else if (CfgMode.toUpperCase() == 'AOUNITEL') {
                document.getElementById('brandlog_aounitel').style.display = 'block';
      } else {
        document.getElementById('brandlog').style.display = 'block';
      }

      if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
        $("#brandlog").css("background", "url(../images/logo_pon_login_deskctap.jpg) no-repeat center");
        $("#brandlog").css("width", "195px");
        $("#brandlog").css("height", "26px");
        $("#copyrightlog").css("background-image", "url()");
      }

      if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
        $("#main_wrapper").css("background-image", "url()");
        $("#main_wrapper").css("background-color", "#ffffff");
        $("#brandlog").css("background", "url(../images/hwlog_dvodacom.jpg) no-repeat center");
        $("#brandlog").css("width", "195px");
        $("#brandlog").css("height", "26px");
        $("#ProductName").css("width", "345px");
        $("#ProductName").css("color", "red");
        $("#account").css("color", "#333333");
        $("#Password").css("color", "#333333");
        $("#txt_Username").removeClass('logininputcss');
        $("#txt_Username").addClass('logininputcss_vodacom');
        $("#txt_Password").removeClass('logininputcss');
        $("#txt_Password").addClass('logininputcss_vodacom');
        $("#greenline").css("background-image", "url()");
        $("#greenline").css("background-color", "red");
      }

      if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
        $("#brandlog").css("background", "url(../images/hwlog_dzain.jpg) no-repeat center");
      }

      if (CfgMode.toUpperCase() == "UMNIAHPAIR") {
        $("#brandlog").css("background", "url(../images/headerlogo_umniah.gif) no-repeat center");
        $("#copyrightlog").css("background-image", "url()");
      }
      if (CfgMode.toUpperCase() == 'MOINWI2'|| CfgMode.toUpperCase() == 'MOINWI') {
                $("#brandlog").css("background", "url(../../../images/logo_moinwi2wifi.gif) no-repeat center");
                $("#brandlog").css("background-repeat", "no-repeat");
                $("#brandlog").css("background-size", "100%");
                $("#brandlog").css("width", "140PX");
                $("#brandlog").css("margin-right", "10px");
      }
      if (["TELESUREBG4","TELESUR2"].indexOf(CfgMode.toUpperCase()) >= 0) {
          $("#brandlog").css("float", "right"); 
          $("#brandlog").css("background", "url(../images/telesur-colored.png) no-repeat center");
          $("#brandlog").css("width", "105px"); 
          $("#brandlog").css("height", "45px"); 
          $("#brandlog").css("background-size", "contain");
          $("#brandlog").css("background-position", "center center");  
      }
      if (true == logo_singtel && TypeWord_com == "COMMON") {
        document.getElementById('copyrightlog').style.display = 'none';
      }
      else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase()) {
        document.getElementById('copyrightlog').style.display = 'none';
      } else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
        document.getElementById('copyrightlog').style.display = 'none';
      }
      else if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
        document.getElementById('copyrightlog').style.display = 'none';
      } else if (CfgMode.toUpperCase() == 'DBAA1') {
        document.getElementById('copyrightlog').style.display = 'none';
      } else if (isTruergT3 == 1) {
        document.getElementById('copyrightlog').style.display = 'none';
      } else if ('DETHMAXIS' == CfgMode.toUpperCase()) {
        document.getElementById('copyrightlog').style.display = 'none';
      } else if ('TELESUREBG4' == CfgMode.toUpperCase()) {
        document.getElementById('copyrightlog').style.display = 'none';
      } else if (CfgMode.toUpperCase() == 'TM2') {
        $("#brandlog").css({"background-image":"url('/images/hwlogo_tm.gif')", "background-size":"40px 40px"});
      } else {
        document.getElementById('copyrightlog').style.display = 'block';
      }
      if ((CfgMode.toUpperCase() == 'TS2') || (CfgMode.toUpperCase() == 'TS') || (CfgMode.toUpperCase() == 'TS2WIFI')) {
        $("#brandlog").css("background", "url(../images/logo_ts.jpg) no-repeat center");
        $("#brandlog").css("background-size", "80%");
        $("#brandlog").css("width", "155px");
        $("#brandlog").css("height", "70px");
        $("#ProductName").css("line-height", "95px");
      }
      if (CfgMode.toUpperCase() == "CMHK") {
        $("#brandlog").css("background", "url(../images/CMHKlogo.jpg) no-repeat center");
        $("#brandlog").css("background-size", "100%");
        $("#brandlog").css("width", "200px");
        $("#brandlog").css("height", "66px");
        $("#brandlog").css("margin-top", "-16px");
        $("#ProductName").css("margin-left", "228px");
        $("#ProductName").css("padding-top", "2px");
      }
    }
  </script>
</body>

</html>
