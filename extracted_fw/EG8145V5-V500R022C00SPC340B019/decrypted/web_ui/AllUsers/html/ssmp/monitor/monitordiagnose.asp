<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function stMonitorDiagnose(domain,Enable,ServerUrl)
{
		this.domain = domain;
		this.Enable = Enable;
		this.ServerUrl = ServerUrl;
}

function stQoeInfo(domain,Enable,TestDownloadUrl,Port,DownloadStatus,MonitorStatus)
{
	this.domain = domain;
	this.Enable = Enable;
	this.TestDownloadUrl = TestDownloadUrl;
	this.Port = Port;
	this.DownloadStatus = DownloadStatus;
	this.MonitorStatus = MonitorStatus;
}

var temp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_MonitorCollector, Enable|ServerUrl, stMonitorDiagnose);%>; 

var MonitorDiagnose = temp[0];
var BinWord ='<%HW_WEB_GetBinMode();%>';
var QoeTmp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_Qoe, Enable|TestDownloadUrl|Port|DownloadStatus|MonitorStatus, stQoeInfo);%>;
var QoeSupport = '<%HW_WEB_GetFeatureSupport("FT_E8C_QOE");%>';
var CDNSupport = '<%HW_WEB_GetFeatureSupport("HW_SSMP_FT_QOE_CDN");%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
if(1 == CDNSupport)
{
    QoeSupport = 0;
}

if(1 == QoeSupport && null != QoeTmp)
{
	var QoeInfo = QoeTmp[0];
	if (QoeInfo != null && null != QoeInfo.TestDownloadUrl)
	{
		QoeInfo.TestDownloadUrl = QoeInfo.TestDownloadUrl.split("/")[0].split(":")[0];
	}
}
else
{
	var QoeTmp = new Array(new stQoeInfo("InternetGatewayDevice.DeviceInfo.X_HW_Qoe","0","null","0","",""),null);
	var QoeInfo = QoeTmp[0];
}



function LoadQoeInfo()
{
	if ('0' == QoeSupport)
	{
		setDisplay('qoearea', 0);
	}
	else
	{
		setDisplay('qoearea', 1);
		
		if (QoeInfo.Enable == 1)
		{
			setCheck('QoeDisable',0);
		}
		else
		{
			setCheck('QoeDisable',1);
		}

		SetDivValue('TestDownloadUrl',QoeInfo.TestDownloadUrl);
		SetDivValue('Port',QoeInfo.Port);
		SetDivValue('DownloadStatus',QoeInfo.DownloadStatus);
		SetDivValue('MonitorStatus',QoeInfo.MonitorStatus);
	}
}

function LoadFrame()
{
    if ((CfgMode.toUpperCase() == 'SDCT') || (CfgMode.toUpperCase() == 'SAXCT')) {
        setDisplay('monitorarea', 0);
    } else {
        if (MonitorDiagnose.Enable == 1) {
            setCheck('MonitorEnable',0);
        } else {
            setCheck('MonitorEnable',1);
		}
		if (MonitorDiagnose.ServerUrl == "") {
				document.getElementById("ServerUrl").innerHTML = "--";
		} else {
			document.getElementById("ServerUrl").innerHTML = htmlencode(MonitorDiagnose.ServerUrl);
		}
    }

	LoadQoeInfo();
}

function CheckForm()
{
    return true; 
}

function CancelConfig()
{
	 LoadFrame();
}

function SubmitForm()
{
    var MonitorNochange = false;
	var QoeNochange = false;
	var QoeObj = '';
    var Form = new webSubmitForm();
	var MonitorValue = getCheckVal('MonitorEnable');
	var QoeValue = getCheckVal('QoeDisable');
	if ((CfgMode.toUpperCase() != 'SDCT') && (CfgMode.toUpperCase() != 'SAXCT')) {
		if (MonitorDiagnose.Enable == 1) {
			if (MonitorValue == 1) {
			    Form.addParameter('x.Enable',0);
			} else {
			    MonitorNochange = true;
		    }
	} else if (MonitorValue != MonitorDiagnose.Enable) {
		MonitorNochange = true;
	} else {
		AlertEx("监控已经禁用，不能再恢复！");
		LoadFrame();
		return false;
		}
	}
	
	if ('1' == QoeSupport)
	{
		if (QoeInfo.Enable == 1)
		{
			if (QoeValue == 1)
			{
				Form.addParameter('y.Enable',0);
				QoeObj = '&y=InternetGatewayDevice.DeviceInfo.X_HW_Qoe'
			}
			else
			{
				QoeNochange = true;
			}
		}
		else if (QoeInfo.Enable == 0 && QoeValue == 0)
		{
			AlertEx("Qoe已经禁用，不能再恢复！");
			LoadFrame();
			return false;
		}
		else
		{
			QoeNochange = true;
		}
	}
	if ('1' == QoeSupport && QoeNochange && MonitorNochange)
		return true;
	else if ('1' != QoeSupport && MonitorNochange)
		return true;

	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

	if ((CfgMode.toUpperCase() == 'SDCT') || (CfgMode.toUpperCase() == 'SAXCT')) {
		Form.setAction('set.cgi?y=InternetGatewayDevice.DeviceInfo.X_HW_Qoe&RequestFile=html/ssmp/monitor/monitordiagnose.asp');
	} else {
		Form.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_MonitorCollector' + QoeObj +
		               '&RequestFile=html/ssmp/monitor/monitordiagnose.asp');
	}

	setDisable('btnApply', 1);
	setDisable('cancelValue', 1);
	Form.submit();   
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <tr> 
      <td class="prompt">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">	  
          <tr> 
            <td class="title_01" id = "note_info" style="padding-left:10px;" width="100%"> <font face="Arial"> </font> </td> 
          </tr> 
          <script language="javascript">
              if (BinWord.toUpperCase() == 'A8C')
              {
                  document.getElementById('note_info').innerHTML = "在本页面，您可以禁用智能诊断，使政企网关不再向服务器上传状态信息文件。"
              }
              else
              {
                document.getElementById('note_info').innerHTML = "在本页面，您可以禁用智能诊断，使家庭网关不再向服务器上传状态信息文件。"
              }
         </script>
		</table>
      </td> 
    </tr> 
  </table> 
  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
  <div id="monitorarea">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr> 
      <td class="table_title" width="24%" align="left">当前状态:</td> 
			<td  class="table_right" width="76%" >
				<script language="javascript">
				if ((CfgMode.toUpperCase() != 'SDCT') && (CfgMode.toUpperCase() != 'SAXCT')) {
					if (MonitorDiagnose.Enable == 1) {
						document.write("已开启");
					} else {
						document.write('已禁用');
					}
				}
				</script>
			</td>

    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr > 
      <td class="table_title"  align="left" width="24%"> 服务器地址:</td> 
			<td class="table_right" width="76%"><span id="ServerUrl"></span></td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg"> 
    <tr > 
      <td class="table_title"  align="left" width="24%"> 监控禁用:</td> 
      <td class="table_right" width="76%"><input id="MonitorEnable" name="MonitorEnable" type="checkbox"></td> 
	      </tr>
  </table>
  </div>
 <div id="qoearea" style="display:none;">
  <div class="func_spread qoe"></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr> 
      <td class="table_title" width="24%" align="left"> Qoe当前状态:</td> 
		<td class="table_right" width="76%" >
			<script language="javascript">
			try{
			if (QoeInfo.Enable == 1)
			{
				document.write("已开启");
			}
			else
			{
				document.write('已禁用');
			}
			}catch(e){
			
			}
			</script>
		</td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr>
      <td class="table_title"  align="left" width="24%"> 下载服务器地址:</td> 
	  <td class="table_right" width="76%"><span id="TestDownloadUrl"></span></td> 
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr>
      <td class="table_title"  align="left" width="24%"> 下载服务器端口:</td> 
	  <td class="table_right" width="76%"><span id="Port"></span></td> 
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr>
      <td class="table_title"  align="left" width="24%"> 下载状态:</td> 
	  <td class="table_right" width="76%"><span id="DownloadStatus"></span></td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr>
      <td class="table_title"  align="left" width="24%"> 执行状态:</td> 
	  <td class="table_right" width="76%"><span id="MonitorStatus"></span></td> 
    </tr> 
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr>
      <td class="table_title"  align="left" width="24%"> Qoe禁用:</td> 
      <td class="table_right" width="76%"><input id="QoeDisable" name="QoeDisable" type="checkbox"></td> 
    </tr>
  </table>
  </div>
  </table> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button"> 
    <tr> 
      <td class="table_submit" width='25%'></td> 
      <td  class="table_submit" align="right">
	  	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	 	<input  class="submit" name="btnApply" id="btnApply" type="button" value="应用" onClick="SubmitForm();"> 
        <input class="submit" name="cancelValue" id="cancelValue" type="button" value="取消" onClick="CancelConfig();"> </td> 
    </tr> 
  </table> 
</body>
</html>
