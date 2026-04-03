<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>Bundle Information</title>
<script>

function ShowLogDetail(PluginLogInfo)
{
	var OptDataLog = PluginLogInfo.split("\n");
	var DataLength = OptDataLog.length ;
	var Loghtml='';
	
	if(-1 != PluginLogInfo.indexOf("error") && ( -1 == PluginLogInfo.indexOf("[") && -1 == PluginLogInfo.indexOf("]")))
	{
		Loghtml += '<tr height="20">';
		Loghtml += '<TD id="none_id" width="5%" align="center" style="background:#FFFFFF">--</TD>'; 	
		Loghtml += '<TD id="none_time" width="25%" align="center" style="background:#FFFFFF">--</TD>'; 	
		Loghtml += '<TD id="none_opt" width="20%" align="center" style="background:#FFFFFF">--</TD>'; 	
		Loghtml += '<TD id="none_cnt" width="50%" align="center" style="background:#FFFFFF">--</TD>'; 
		Loghtml += '</tr>';
	}
	else
	{
		for (var i = 0; i < DataLength - 1; i++ )
		{
			if (OptDataLog[i] != "\r\n" && OptDataLog[i] != "" &&  OptDataLog[i] != "\0" && (-1 != OptDataLog[i].indexOf("[") && -1 != OptDataLog[i].indexOf("]")))
			{
				var loginof =OptDataLog[i];
				var logtime = loginof.split("[");
				var Remain = logtime[1].split("]");
				var id = "index_" + i;	
				var id_time = "time_" + i;
				var id_opt = "opt_" + i;
				var id_inform= "inform_" + i;
				
				var IdNum = i + 1;
			
				if( null == logtime[0] || (-1 == logtime[0].indexOf("-")))
				{
					break;
				}
	
				Loghtml += '<tr height="20">';
				Loghtml += '<TD id="' + id +'" width="5%" align="center" style="background:#FFFFFF">' + htmlencode(IdNum) + '</TD>'; 
				Loghtml += '<TD id="' + id_time +'" width="25%" align="center" style="background:#FFFFFF">' + htmlencode(logtime[0]) + '</TD>'; 
				Loghtml += '<TD id="' + id_opt +'" width="20%" align="center" style="background:#FFFFFF">' + htmlencode(Remain[0]) + '</TD>';
				Loghtml += '<TD id="' + id_inform + '" title="'+htmlencode(Remain[1])+'" width="50%" align="left" style="background:#FFFFFF">'+GetStringContent(htmlencode(Remain[1]), 64)+'</TD>'; 
				Loghtml += '</tr>';					
			}
		}
	}

	return Loghtml;
}

</script>
</head>

<body class="mainbody">
<div id="Pluginlogviews" align="center" style="display:none"> 
  <textarea name="Plglogarea" id="Plglogarea" style="width:100%;height:330px;margin-bottom:20px;" wrap="off" >
</textarea> 
  <script type="text/javascript">
			document.getElementById("Plglogarea").value='<%HW_WEB_GetPgnLog();%>';
	 </script> 
</div>
<div class="func_title"><label id = "Title_base_lable">插件配置下发状态</label></div>
<div>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="SysLogInst">
<tr class="table_title" height="35">
<td width="5%" id="log_id_table" align="center"><div align="center">ID</div></td>
<td width="25%" id="log_time_table" align="center"><div align="center">配置时间</div></td>
<td width="20%" id="log_info_table" align="center"><div align="center">配置类型</div></td>
<td width="50%" id="log_info_table" align="center"><div align="center">插件名称</div></td>
</tr>
<script language="JavaScript" type="text/javascript">
var PluginTmpLogInfo = document.getElementById("Plglogarea").value;
document.write(ShowLogDetail(PluginTmpLogInfo));
</script>
</table>
</div>

</body>
</html>
