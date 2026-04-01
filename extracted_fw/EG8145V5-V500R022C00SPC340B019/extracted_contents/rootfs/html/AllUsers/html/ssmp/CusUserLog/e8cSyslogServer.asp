<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stSyslogConfig(domain, LogServerEnable, ServerAddress) {
    this.domain = domain;
    this.LogServerEnable = LogServerEnable;
    this.ServerAddress = ServerAddress;
}

var temp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_SyslogConfig, LogServerEnable|ServerAddress,stSyslogConfig);%>; 
var SyslogCfg = temp[0];
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var BinMode = '<%HW_WEB_GetBinMode();%>';

function LoadFrame() {
    if ((SyslogCfg.LogServerEnable == 1) || (SyslogCfg.LogServerEnable == "1")) {
        setCheck('LogServerEnable_checkbox',1);
    } else {
        setCheck('LogServerEnable_checkbox',0);
    }
    setText('ServerAddress_text', SyslogCfg.ServerAddress);

    if ((CfgMode.toUpperCase() == 'SHCTA8C') || ((BinMode.toUpperCase() == 'A8C') && (CfgMode.toUpperCase() == 'SHCT'))) {
        setDisable('LogServerEnable_checkbox', 1);
        setDisable('ServerAddress_text', 1);
        setDisplay("Configbtnsave_button", 0);
    }
}

function CheckForm()
{
    var ServerAddress = getElById("ServerAddress_text").value;

    if ((isAbcIpAddress(ServerAddress) == false) || (isDeIpAddress(ServerAddress) == true) ||
        (isBroadcastIpAddress(ServerAddress) == true) || (isLoopIpAddress(ServerAddress) == true)) {
        AlertEx('服务器IP地址'+ ServerAddress + '无效');
        return false;
    }

    setDisable('Configbtnsave_button',1);
    return true; 
}

function AddSubmitParam(SubmitForm, type)
{
    var CheckValue = getCheckVal("LogServerEnable_checkbox");
    if (CheckValue == 1) {
        SubmitForm.addParameter('x.LogServerEnable',1);
    } else {
        SubmitForm.addParameter('x.LogServerEnable',0);
    }

    SubmitForm.addParameter('x.ServerAddress',getValue('ServerAddress_text'));

    SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_SyslogConfig' +
                         '&RequestFile=html/ssmp/CusUserLog/e8cSyslogServer.asp');

    setDisable('Configbtnsave_button',1);
}

function LogEnableApply() {
}
</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<div id="logconfig"> 
<table id="Title_config_log_lable" width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> 
    <td class="table_head" width="100%"><lable>Syslog服务器设置</lable> </td> 
</tr>
<tr> 
<td height="5"></td>
</tr>
<tr> 
    <td class="title_01"  style="padding-left:10px;" width="100%"><lable>本页面上，您可以启用日志上传功能，并配置服务器地址，如果启用日志上传，会将系统日志上传至服务器。<br>
</lable> </td> 
</tr> 
  </table> 
  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr> 
      <td class="table_title" id="Title_log_lable" width="18%"  align="left"><lable>启用日志上传:</lable></td> 
<td  class="table_right" width="82%" > <input id='LogServerEnable_checkbox' name='LogServerEnable_checkbox'  type='checkbox' onClick="LogEnableApply();"></td>

    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr > 
      <td class="table_title"  align="left" width="18%"> 服务器IP地址:</td> 
      <td class="table_right" width="82%">
        <input type="text" id="ServerAddress_text" name="ServerAddress_text" size="20" maxlength="32">
      </td>
    </tr>
    </table>
    </table>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
    <tr> 
      <td class="table_submit" width='25%'></td> 
      <td  class="table_submit" align="right">
      <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      <input  class="submit" name="Configbtnsave_button" id="Configbtnsave_button" type="button" value="保存/应用" onClick="Submit();"> </td> 
    </tr>
  </table>
</div> 
</body>
</html>
