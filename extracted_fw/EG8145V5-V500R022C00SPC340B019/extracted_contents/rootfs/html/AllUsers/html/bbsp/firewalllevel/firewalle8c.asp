<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, firewalllevel_language);%>"></script>
<title>Firewall Level</title>
<script language="JavaScript" type="text/javascript">

var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallGeneralLevel);%>';
var FltsecLevelx = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>';
var FltsecLevelString = changechar(FltsecLevelx);
var DosEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_DosEnable);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';

function IsCmcc_rmsMode()
{
	var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
	if ('1' == Custom_cmcc_rms )
	{
		return true;
	}
	else
	{
		return false;
	}	
}

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
	if (CfgModeWord.toUpperCase() != 'JXCT')
	{
		setDisplay("JXCTDisplay",0);
	} else {
		document.getElementById("table_title_e8c").innerHTML = "启用防火墙";
		document.getElementById("table_title_dos").innerHTML = "启用DoS攻击保护";
	}
	if (IsCmcc_rmsMode())
	{
		setDisplay("table_title_e8c",0);
		setDisplay("FirewallEnable_checkbox",0);
		setSelect("SecurityLevel", FltsecLevelString);
		setCheck("DosEnable_checkbox", DosEnable);
	}
	else
	{
		setDisplay("SecurityLevel",0);
		setDisplay("table_title_cmcc",0);		
		if(1 == FltsecLevel){
        getElementById("FirewallEnable_checkbox").checked = false;
        getElementById("DosEnable_checkbox").checked = false;
        setDisable('DosEnable_checkbox',1);
		}else{
			getElementById("FirewallEnable_checkbox").checked = true;
			if(3 == FltsecLevel){
            getElementById("DosEnable_checkbox").checked = true;
			}
		}
	}
}

function OnCfgChanged()
{
        var fireWallEn = document.getElementById("FirewallEnable_checkbox").checked;
        var dosEn = document.getElementById("DosEnable_checkbox").checked;
        var Form = new webSubmitForm();
        if (IsCmcc_rmsMode()) {
            var firewallLevel = getValue('SecurityLevel');
            if(firewallLevel.toLowerCase() == "disable") {
                if(ConfirmEx(firewalllevel_language["bbsp_DisableFirewallLevel"]) == false) {
                    return;
                }
            }
            Form.addParameter('x.X_HW_FirewallLevel',getValue('SecurityLevel'));
            Form.addParameter('x.X_HW_DosEnable',((dosEn == true) ? 1 : 0));
        } else {
            if(fireWallEn == false) {
                if(ConfirmEx(firewalllevel_language["bbsp_DisableFirewallLevel"]) == false) {
                    getElementById("FirewallEnable_checkbox").checked = true;
                    return;
                }
                Form.addParameter('x.X_HW_FirewallGeneralLevel',1);
            } else {
                if(dosEn == false) {
                    Form.addParameter('x.X_HW_FirewallGeneralLevel',2);
                } else {
                    Form.addParameter('x.X_HW_FirewallGeneralLevel',3);
                }
            }
        }

		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/firewalllevel/firewalle8c.asp');
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
            <td width="100%"  class="title_01" style="padding-left:10px;">
			<script language="JavaScript" type="text/javascript">
			if (IsCmcc_rmsMode())
			{
				document.write("在本页面上，您可以配置防火墙等级和DoS攻击保护开关。");
			}
			else
			{
				document.write("在本页面上，您可以配置防火墙开关和DoS攻击保护开关。");
			}
			</script></td> 
          </tr> 
        </table></td> 
    </tr> 
  </table> 
  <table id="JXCTDisplay"  width="100%" cellspacing="0"> 
    <tr> 
      <td width="100%" class="table_title width_25p">注意：</td>
    </tr>
	<tr> 
      <td width="100%" class="table_title width_25p">防火墙、DoS攻击保护均关闭：允许ICMP重定向，允许ICMP Ping请求；</td>
    </tr>
    <tr> 
      <td width="100%" class="table_title width_25p">防火墙启用、DoS攻击保护关闭：禁止ICMP包攻击；</td>
    </tr>
    <tr> 
      <td width="100%" class="table_title width_25p">防火墙、DoS攻击保护均启用：禁止ICMP包攻击，防syn flooding攻击。</td>
    </tr>
  </table> 
  <div class="title_spread"></div>
  <table id="TableFilterContent"  width="100%" cellspacing="0"> 
    <tr> 
      <td class="table_title width_25p" id="table_title_e8c">启用</td>
      <td class="table_title width_25p" id="table_title_cmcc">防火墙等级</td>
      <td class="table_right">
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  <select name="SecurityLevel" id="SecurityLevel" onchange="OnCfgChanged()">
		<option value="Disable">禁用</option>
		<option value="High">高</option>
		<option value="Medium">中</option>
		<option value="Low">低</option>
		<option value="Custom">自定义</option>
	  </select>
	  <input type="checkbox" value="false" id="FirewallEnable_checkbox" onclick="OnCfgChanged()" /></td> 
    </tr>
    <tr> 
      <td class="table_title width_25p" id="table_title_dos">DoS攻击保护</td> 
      <td class="table_right"><input type="checkbox" value="false" id="DosEnable_checkbox" onclick="OnCfgChanged()" /></td> 
    </tr>
  </table> 
</form> 
</body>
</html>
