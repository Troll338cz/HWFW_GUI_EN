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

  <script language="JavaScript" type="text/javascript">

    var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';

    document.title = ProductName;

    var pccwCondition = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Register.Condition);%>';

    var IpAddress = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress,stLanHostInfo);%>;
    var Br0IpAddr = IpAddress[0].ipaddr;

    if (pccwCondition == '0') {
      window.location.replace('/login.asp');

    }

    function stLanHostInfo(domain, ipaddr) {
      this.domain = domain;
      this.ipaddr = ipaddr;
    }

    function Submit(type) {
      if (CheckForm(type) == true) {
        var Form = new webSubmitForm();
        AddSubmitParam(Form, type);
        Form.submit();
      }
    }

    function LoadFrame() {
      document.getElementById('txt_Password').focus();
    }

    function SubmitPassword() {
      var Password = document.getElementById("txt_Password");
      if (Password.value.length > 10) {
        alert("The password length must be from 0 to 10 characters long.");
        return false;
      }
      var SubmitForm = new webSubmitForm();

      SubmitForm.addParameter('x.X_HW_PonPassword', getValue('txt_Password'));

      SubmitForm.addParameter("y.RegistrationID", getValue('txt_Password'));
      SubmitForm.addParameter("y.PreSharedKey", getValue('txt_Password'));

      SubmitForm.addParameter('x.X_HW_ForceSet', 1);
      SubmitForm.addParameter('x.X_HW_Token', getAuthToken());
      SubmitForm.setAction('PccwReg.cgi?' + 'x=InternetGatewayDevice.DeviceInfo&y=InternetGatewayDevice.X_HW_XgponDeviceInfo&RequestFile=PccwShowProc.asp');
      setDisable('button_cancel', 1);
      setDisable('button_submit', 1);
      SubmitForm.submit();
      return true;
    }

    function CleanPassword() {
      setText('txt_Password', '');
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

      <div style="float:right; ">
        <a id="toLogin" href="login.asp">
          <font color="#0000FF" style="font-size: 14px;">Return to login page</font>
        </a>
        <script>document.getElementById("toLogin").href = "http://" + Br0IpAddr + "/login.asp"</script>
      </div>

      <div class="labelBoxlogin" style="text-align:center;width:100%;margin-bottom:20px;margin-top: 200px;">
        Please enter password for service authentication.</div>

      <div class="labelBoxlogin"><span id="Password" BindText="frame002"></span></div>
      <div class="contenboxlogin"><input type="password" autocomplete="off" id="txt_Password" name="txt_Password"
          class="logininputcss" /></div>


      <div style="float: left;width:100%;margin-left: -8px;margin-top: 20px;">
        <input type="button" class="CancleButtonCss buttonwidth_100px" id="button_submit" onClick="SubmitPassword();"
          value="Submit" />
        <input type="button" class="CancleButtonCss buttonwidth_100px" id="button_cancel" onClick="CleanPassword();"
          value="Clear" />
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