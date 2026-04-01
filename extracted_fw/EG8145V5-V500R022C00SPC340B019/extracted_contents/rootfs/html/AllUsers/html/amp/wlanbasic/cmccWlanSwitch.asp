<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlancfgother_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="../../ssmp/common/refreshTime.asp"></script>
<title>wireless basic configure</title>
<script language="JavaScript" type="text/javascript">
var hilinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var hilinkStart = '<%HW_WEB_GetFeatureSupport(FEATURE_HILINK_START);%>';
if (hilinkStart == 0) {
    hilinkRoll = 0;
}

var enable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';
var url = 'set.cgi?';

function LoadFrame()
{       
   setCheck('WlanEnable_checkbox', enable);
}

function AddWifiCoverEnableCfg(Form, curEnable) {
    if ((hilinkRoll == 0) || (curEnable == enable)) {
        return;
    }

    Form.addParameter('y.FirstBandEnable', curEnable);
    Form.addParameter('y.SecondBandEnable', curEnable);
    Form.addParameter('y.RadioInst', 0);
    url += 'y=InternetGatewayDevice.X_HW_DEBUG.AMP.SetDualWifiCoverEnable&';
}

function EnableSubmit() {
    var Form = new webSubmitForm();
    var curEnable = getCheckVal('WlanEnable_checkbox');

    Form.addParameter('x.X_HW_WlanEnable', curEnable);
    AddWifiCoverEnableCfg(Form, curEnable);
    url += 'x=InternetGatewayDevice.LANDevice.1';

    url += '&RequestFile=html/amp/wlanbasic/cmccWlanSwitch.asp';
    Form.setAction(url);

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}


</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr> 
		<td class="table_head" width="100%">WLAN功能开关</td> 
	</tr>

	<tr> 
		<td height="5"></td> 
	</tr>

    <tr>
      <td class="prompt">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
			    <td class="title_common">
					<script language="JavaScript">
		            document.write("说明：可设置无线模块的开关功能。" );
                    </script>
					<label id="Title_wlan_common_set_lable" class="title_common">					
					</label>                    
				</td>
			</tr>		
    <tr> 
      <td class="title_common">  
	  <div>	
	  <table>
          <tr> 
            <td class='width_per15 align_left'><img style="margin-bottom:2px" src="../../../images/icon_01.gif" width="15" height="15" /></td> 
            <td class='width_per85 align_left'><script>document.write(cfg_wlancfgother_language['amp_wlan_note1']);</script></td> 
          </tr>
	 </table>
	 </div>
          <tr><td class="title_common"><script>document.write("1. " +  "WLAN功能开关的开启和关闭会针对2.4G和5G无线的所有SSID生效。");</script></td></tr>          
       </td> 
    </tr> 
        </table>
      </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table_space1">
    <tr ><td class="height15p"></td></tr>
</table>

<form id="ConfigForm" action="../network/set.cgi" >
 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr ><td> 

    <table cellspacing="0" cellpadding="0" width="100%" id="wlanOnOff">
      <tr>
        <td>
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <input type='checkbox' name='WlanEnable_checkbox' id='WlanEnable_checkbox' onClick='EnableSubmit();' value="ON">
          启用无线网络</input></td>
      </tr>
    </table>
  	</div>    
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height15p"></td></tr>
</table>

</td></tr>
</table>
</form>

<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
