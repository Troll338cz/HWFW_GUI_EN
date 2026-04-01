<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>Firewall Dos</title>
<script language="JavaScript" type="text/javascript">

var DosEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_DosEnable);%>';

function changechar(str)
{
	if(!str)
	{
		return "";
	}
	return str.substring(0,1).toUpperCase()+str.substring(1,10).toLowerCase();
}

function LoadFrame()
{
		setCheck("DosEnable_checkbox", DosEnable);
}

function OnCfgChanged()
{
        var dosEn = document.getElementById("DosEnable_checkbox").checked;
        var Form = new webSubmitForm();
		
		Form.addParameter('x.X_HW_DosEnable',((dosEn == true) ? 1 : 0));
		
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/firewalllevel/firewallcmccdos.asp');
        Form.submit();	
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<form id="ConfigForm"> 
  <table  width="100%" id="TableSmartFilter"> 
    <tr  width="100%" > 
      <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
          <tr> 
            <td width="100%"  class="title_01" style="padding-left:10px;">在本页面上，您可以配置DoS攻击保护开关。</td> 
          </tr> 
        </table></td> 
    </tr> 
  </table> 
  <div class="title_spread"></div>
  <table id="TableFilterContent"  width="100%" cellspacing="0"> 
    <tr> 
      <td class="table_title width_25p">DoS攻击保护</td> 
      <td class="table_right"><input type="checkbox" value="false" id="DosEnable_checkbox" onclick="OnCfgChanged()" /></td> 
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    </tr>
  </table> 
</form> 
</body>
</html>
