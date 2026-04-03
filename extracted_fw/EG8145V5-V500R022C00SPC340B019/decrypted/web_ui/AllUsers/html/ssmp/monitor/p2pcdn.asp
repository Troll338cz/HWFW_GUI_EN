<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function stQoeInfo(domain,Enable,TestDownloadUrl,Port,DownloadStatus,MonitorStatus)
{
	this.domain = domain;
	this.Enable = Enable;
	this.TestDownloadUrl = TestDownloadUrl;
	this.Port = Port;
	this.DownloadStatus = DownloadStatus;
	this.MonitorStatus = MonitorStatus;
}

var QoeTmp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_Qoe, Enable|TestDownloadUrl|Port|DownloadStatus|MonitorStatus, stQoeInfo);%>;
var QoeSupport = '<%HW_WEB_GetFeatureSupport("HW_SSMP_FT_QOE_CDN");%>';

if(1 == QoeSupport && null != QoeTmp)
{
	var QoeInfo = QoeTmp[0];
	if (QoeInfo != null && null != QoeInfo.TestDownloadUrl)
	{
		var showAddr = QoeInfo.TestDownloadUrl.split("://")[1];
		if("" == showAddr || null == showAddr)
		{
			QoeInfo.TestDownloadUrl = QoeInfo.TestDownloadUrl.split("/")[0].split(":")[0];
		}
		else
		{
			QoeInfo.TestDownloadUrl = showAddr.split("/")[0].split(":")[0];
		}
	}
}
else
{
	var QoeTmp = new Array(new stQoeInfo("InternetGatewayDevice.DeviceInfo.X_HW_Qoe","0","null","0","",""),null);
	var QoeInfo = QoeTmp[0];
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
	var QoeNochange = false;
	var QoeObj = '';
    var Form = new webSubmitForm();

	var QoeValue = getCheckVal('QoeDisable');
	
	if ('1' == QoeSupport)
	{
		if (QoeInfo.Enable == 1)
		{
			if (QoeValue == 1)
			{
				Form.addParameter('x.Enable',0);
				QoeObj = 'x=InternetGatewayDevice.DeviceInfo.X_HW_Qoe'
			}
			else
			{
				QoeNochange = true;
			}
		}
		else if (QoeInfo.Enable == 0 && QoeValue == 0)
		{
			AlertEx("P2P CDN已经禁用，不能再恢复！");
			LoadFrame();
			return false;
		}
		else
		{
			QoeNochange = true;
		}
	}
	if ('1' == QoeSupport && QoeNochange)
		return true;
	else if ('1' != QoeSupport)
		return true;

	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	Form.setAction('set.cgi?' + QoeObj
	                      + '&RequestFile=html/ssmp/monitor/p2pcdn.asp');
	
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
            <td class="title_01"  style="padding-left:10px;" width="100%"> <font face="Arial"> 在本页面，您可以禁用第三方插件。</font> </td> 
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

 <div id="qoearea" style="display:none;">
  <div class="func_spread qoe"></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg qoe"> 
    <tr> 
      <td class="table_title" width="24%" align="left"> P2P CDN当前状态:</td> 
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
      <td class="table_title"  align="left" width="24%"> P2P CDN禁用:</td> 
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
