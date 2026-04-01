<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="JavaScript" type="text/javascript">

function stTimeInfo(domain,Enable,ntp1,ntp2,ZoneName,SynInterval,WanName,ExportCfgMode, ExportType, DstUsed,StartDate,EndDate,StartDate_EX,EndDate_EX)
{
    this.domain = domain;
    this.Enable = Enable;
    this.ntp1 = ntp1;
    this.ntp2 = ntp2;
    this.ZoneName = ZoneName;    
    this.SynInterval = SynInterval;
    this.WanName = WanName;
    this.DstUsed = DstUsed;
    this.StartDate = StartDate;
    this.EndDate = EndDate;
    this.StartDate_EX = StartDate_EX;
    this.EndDate_EX = EndDate_EX;    
    this.ExportCfgMode = ExportCfgMode;
    this.ExportType = ExportType;
}

var TimeInfos  = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Time,Enable|NTPServer1|NTPServer2|LocalTimeZoneName|X_HW_SynInterval|X_HW_WanName|X_HW_ExportCfgMode|X_HW_ExportType|DaylightSavingsUsed|DaylightSavingsStart|DaylightSavingsEnd|X_HW_DaylightSavingsStartDate|X_HW_DaylightSavingsEndDate,stTimeInfo);%>;
var TimeInfo = TimeInfos[0];
var sntpSysTime = '<%HW_WEB_GetSystemTime();%>';

function hideNtpConfig(hide) 
{
  var status = 'block';

  if(hide)
    status = 'none';
 	
  if( document.getElementById('ntpConfig') )
  {
    document.getElementById('ntpConfig').style.display = status;
  }
  else if(!document.layers)
  {
      document.all.ntpConfig.style.display = status;
  }
}

function ntpEnblChange() 
{
	var ntpEnabled = document.getElementById('NtpEnable_checkbox');
    try
    {
        if( ntpEnabled.checked )
        {
		    hideNtpConfig(0);
		}
        else
        {
		    hideNtpConfig(1);
		}
    }
    catch(ex)
    {}
}

function LoadFrame()
{
  var ntp_enabled = TimeInfo.Enable;
  
  setText("NtpInterval_text", TimeInfo.SynInterval);
  setSelect("NtpType_select", TimeInfo.ExportType);
   
  with (document.forms[0])
  {
     setCheck('NtpEnable_checkbox',ntp_enabled);
	 setDisplay('ntpConfig',ntp_enabled);
 
    ntpEnblChange();
  }
  
  setDisable("NtpType_select", 1);
  setDisable("NtpInterval_text", 1);
  setDisable("NtpEnable_checkbox", 1);
}

function ShowNtpConfig(obj)
{
	if (obj.checked)
	{
		setDisplay('ntpConfig', 1);
	}
	else
	{
		setDisplay('ntpConfig', 0);
	}
}

</script>

</head>
<body onLoad="LoadFrame();"  class="mainbody">
<table width="100%"  border="0" cellpadding="0" cellspacing="0" id="tabTest">
    <tr>
       <td class="prompt">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%" class="title_01" style="padding-left:10px;">在本页面，您可以查询时间同步相关配置。</td>
          </tr>
        </table>
       </td>
    </tr>
	<tr><td height="5px"></td></tr>
	 <tr align="left">
            <td>
                <input type='checkbox' name='NtpEnable_checkbox' id='NtpEnable_checkbox' onClick='ShowNtpConfig(this);' checked = false>
                自动同步网络时间 </td>
        </tr>
 </table>
 <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 
<form id="ConfigForm" action="">
<div id="ntpConfig" name="ntpConfig" class="" style="z-index:2" >
    <table class="tabal_bg"  cellpadding="0" cellspacing="0" width="100%">
	<tr class="trTabConfigure" align="left">
          <td width="25%" id="dsWanName" class="table_title">时间同步通道:</td>
          <td class="table_right">
		  <select name="NtpType_select" id="NtpType_select" maxlength="20" style="width:165px;">
			<option value="2">TR069通道</option>
		 </select>
          </td>
      </tr>
	  <tr class="trTabConfigure" align="left">
          <td width="25%" class="table_title">同步间隔（单位：秒）:</td>
          <td width="75%" class="table_right">
             <input type='text' style="width:158px;" name='NtpInterval_text' id='NtpInterval_text' size=20 maxLength=9>
          </td>
      </tr>
    </table>
  
  </div>
</form>
</body>
</html>

