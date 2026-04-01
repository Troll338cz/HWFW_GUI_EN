<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
  <meta http-equiv="Pragma" content="no-cache" />
  <link href="/Cuscss/<%HW_WEB_CleanCache_Resource(login.css);%>" media="all" rel="stylesheet" />
  <link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" media="all" rel="stylesheet" />
  <link href='/Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' rel="stylesheet" type='text/css'>

  <script src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
  <script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
  <script id="langResource" language="JavaScript" src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
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

    .bssResProgBarHead {
      width: 9px;
      height: 19px;
      float: left;
      background: url(/images/bssbarhead.jpg) no-repeat center;
    }

    .bssResProgBarSpace {
      width: 7px;
      height: 19px;
      float: left;
      background: url(/images/bssbarperbg.jpg) no-repeat center;
    }

    .bssResProgBarTail {
      width: 9px;
      height: 19px;
      float: left;
      background: url(../../images/bssbartail.jpg) no-repeat center;
    }

    .bssResProgBarPer {
      width: 100%;
      height: 18px;
      float: left;
      background: url(/images/bssbarper.jpg) no-repeat center;
    }

    .bssResProgBarPerBg {
      width: 24px;
      height: 18px;
      float: left;
      background: url(/images/bssbarperbg.jpg) no-repeat center;
    }
  </style>
  <script language="JavaScript" type="text/javascript">

    function Registration(domain, Condition) {
      this.domain = domain;
      this.Condition = Condition;
    }

    function stLanHostInfo(domain, ipaddr) {
      this.domain = domain;
      this.ipaddr = ipaddr;
    }

    var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
    var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
    document.title = ProductName;
    var IpAddress = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress,stLanHostInfo);%>;
    var Br0IpAddr = IpAddress[0].ipaddr;

    var isOntOnline = 0;

    function getOntOnlineStatus() {
      $.ajax({
        type: "POST",
        async: false,
        cache: false,
        url: "/asp/ontOnlineStatus.asp",
        success: function (data) {
          isOntOnline = data;
        }
      });
    }

    var TimerHandle = null;
    var curPercent = 5;
    var pausePercent = 85;
    var maxWait = 5;
    var wait = 0;
    var step = 5;

    function setPrograss() {
      var percent = curPercent + step;
      var mleft = 8 + (curPercent / 5) * 24;

      if (percent > pausePercent) {
        percent -= step;
        wait++;
      }

      if (1 == isOntOnline) {
        document.getElementById("regResult").innerHTML = "Authenticated successfully.";
        $("#bssper_105").removeClass("displaynone");
        setDisplay("buttonTry", 0);

        clearInterval(TimerHandle);

        percent = 100;
        mleft += 24;
      }
      else {
        if (wait == maxWait) {
          clearInterval(TimerHandle);

          HiddenUnwantedRow();
          document.getElementById("regResult").innerHTML = "Registration timeout.Please check the password and try again.";
        }
        else {
          document.getElementById("regResult").innerHTML = "Registering,please wait...";
        }
      }

      while (curPercent < percent) {
        curPercent += 5;
        mleft += 24;
        $("#bssper_" + curPercent).removeClass("displaynone");
      }

      $("#bssResProgPer").css("margin-left", mleft + "px");
      document.getElementById('percent').innerHTML = curPercent + "%";
    }

    function HiddenUnwantedRow() {
      $("#bssResProg").css("display", 'none');
      $("#divSpace").css("margin-bottom", "260px");
    }

    function getNewStatus() {
      getOntOnlineStatus();
      setPrograss();
    }


    function LoadFrame() {
      document.getElementById('percent').innerHTML = curPercent + "%";

      TimerHandle = setInterval("getNewStatus()", 4500);
    }

    function JumpTo() {
      window.location = "/pccw";
    }

  </script>
</head>

<body onLoad="LoadFrame();">
  <div id="main_wrapper">

    <div id="loginarea">

      <div style="width:100%;">
        <div id="brandlog"></div>
        <div id="ProductName">
          <script>document.write(ProductName);</script>
        </div>
      </div>

      <div style="float:right;">
        <a id="toLogin" href="login.asp">
          <font color="#0000FF" style="font-size: 14px;">Return to login page</font>
        </a>
        <script>document.getElementById("toLogin").href = "http://" + Br0IpAddr + "/login.asp"</script>
      </div>

      <div id="divSpace" style="width:100%; margin-bottom: 200px;"></div>

      <div id="bssResProg">
        <div id="bssResProgPer" style="margin-left: 32px;"><span id="percent">0%</span></div>

        <div id="bssResProgBar">
          <div class="bssResProgBarHead"></div>
          <div class="bssResProgBarSpace"></div>
          <div id="bssResProgBarTotal">
            <div id="bssper_5" class="bssResProgBarPerBg">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_10" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_15" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_20" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_25" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_30" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_35" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_40" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_45" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_50" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_55" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_60" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_65" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_70" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_75" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_80" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_85" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_90" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_95" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_100" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
            <div id="bssper_105" class="bssResProgBarPerBg displaynone">
              <div class="bssResProgBarPer"></div>
            </div>
          </div>
          <div class="bssResProgBarSpace"></div>
          <div class="bssResProgBarTail"></div>
        </div>
      </div>

      <div id="bssPrompt" class="labelBoxlogin" style="width:100%; margin-left:0px; text-align:center;">
        <span id="regResult">Registering,please wait...</span>
      </div>

      <div style="float: left;width:100%;margin-top: 20px;">
        <input type="button" class="CancleButtonCss buttonwidth_100px" id="buttonTry" onClick="JumpTo();"
          value="Try again" />
      </div>

    </div>

    <div id="greenline"></div>
    <div id="copyright">
      <div id="copyrightspace"></div>
      <div id="copyrightlog"></div>
      <script>
        document.write('<div id="copyrighttext"><span id="footer" BindText="frame015a"></span></div>');
      </script>
    </div>

  </div>

  <script>
    ParseBindTextByTagName(framedesinfo, "span", 1);
  </script>

</body>

</html>