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
var token = '<%HW_WEB_GetToken();%>';

function startPluginOp()
{
	var Form = new webSubmitForm();
    Form.addParameter('x.LinkappEnable', 1);
	Form.addParameter('x.X_HW_Token', token);
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_AppManage'
                        + '&RequestFile=html/ssmp/smartontinfo/pluginstatus.asp');
	Form.submit();
}

function stopPluginOp()
{
	var Form = new webSubmitForm();
    Form.addParameter('x.LinkappEnable', 0);
	Form.addParameter('x.X_HW_Token', token);
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_AppManage'
                        + '&RequestFile=html/ssmp/smartontinfo/pluginstatus.asp');
	Form.submit();
}
</script>
</head>

<body class="mainbody">
</br></br>
<!--系統分区信息-->
<div>
  <div class="func_title"><label id = "Title_base_lable">插件控制信息：</label></div>
  <div style="width:100%;overflow-x:auto;">
    <table class="tabal_bg width_100p" cellspacing="1" id="bundleid">  
      <tr align="center"> 
		<td class="table_title" nowrap>插件</td> 
		<td class="table_title" nowrap>状态</td> 
		<td class="table_title" nowrap>启动/停止</td>
	  </tr> 
	  <tr align="center"> 
		<script type="text/javascript" language="javascript">
            function stAppManage(domain,LinkappName,LinkappEnable,LinkappState)
            {
                this.domain = domain;
                this.LinkappName = LinkappName;
                this.LinkappEnable = LinkappEnable;
                this.LinkappState = LinkappState;
            }

            var stAppManages = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_AppManage,LinkappName|LinkappEnable|LinkappState,stAppManage);%>;
            var AppManage = stAppManages[0];
     
			document.write('<TD class="table_right" nowrap>' + htmlencode(AppManage.LinkappName) + '</TD>');
			document.write('<TD class="table_right" nowrap>' + htmlencode(AppManage.LinkappState) + '</TD>');

			document.write('<TD class="table_right">');
			document.write('<input id="plugin_stop" name="plugin_stop" type="button" value="暂停" onClick="stopPluginOp();"/>');
			document.write('<input id="plugin_start" name="plugin_start" type="button" value="开始" onClick="startPluginOp();"/>');
            document.write('</TD>');
            
            if (AppManage.LinkappState == "RUNNING"){
                document.getElementById("plugin_start").style.display = "none";
                document.getElementById("plugin_stop").style.display = "block";
            }else if (AppManage.LinkappState == "STOPPED"){
                document.getElementById("plugin_start").style.display = "block";
                document.getElementById("plugin_stop").style.display = "none";
            } else {
                document.getElementById("plugin_start").style.display = "none";
                document.getElementById("plugin_stop").style.display = "none";
            }
		</script> 
	  </tr> 
    </table> 
	</br>
  </div>
</div>
</br>
</div>
</body>
</html>
