<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<link href="Cuscss/<%HW_WEB_GetCusSource(index.css);%>" rel="stylesheet" type="text/css" />
<script src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="frame.asp"></script>
<script language="JavaScript" type="text/javascript">
window.wanCacheObj = { wanListCacheObj:{}, wanIpv6StateCacheObj:{}, wanOptType: 0, curWanState: '0', wanMonitorTimer: null };
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curWebMode = '<%HW_WEB_GetWebMode();%>'; 
var wlanFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var tdeModeFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_TDE_CHANGE_MODE);%>';
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>'; 
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var IsPTVDF = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>';
var IsSmartLanDev = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>";
var RosFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROS);%>';
var HostingQRcodeEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AppRemoteManage.HostingQRcodeEnable);%>';  
var userdevinfonum = "";
var firstStartFlag = '<%HW_WEB_GetFirstStartFlag();%>'
var appUrl = '<%HW_WEB_GetSPEC(SPEC_STC_APP_URL.STRING);%>';
var upgradeStatusobj = {upgradeStatus:0};
var ConfigFlag = '<%HW_WEB_GetGuideFlag();%>';
if (CfgMode.toUpperCase() == 'PLDT2') {
    if (curUserType == 1) {
        if (!parseInt(ConfigFlag.split("#")[1], 10)) {
            window.location="/html/amp/wlanbasic/guidepldtwificfg.asp";
        }
    } else if (curUserType == 0) {
        if ((!parseInt(ConfigFlag.split("#")[0], 10))) {
            window.location="/html/amp/wlanbasic/guidepldtwificfg.asp";
        }
    }
}

if (firstStartFlag == 0 && CfgMode.toUpperCase() == 'ROSUNION') {
    window.location.href="./rosunion_setup_wizard.asp";
}

if (('CNT' == CfgMode.toUpperCase()) || ('CNT2' == CfgMode.toUpperCase()))
{
	if ((curUserType != '1') && (!parseInt(ConfigFlag.split("#")[0], 10)) && (!parseInt(ConfigFlag.split("#")[1], 10)) && (!parseInt(ConfigFlag.split("#")[2], 10)))
	{
		window.location="/html/ssmp/cfgguide/cnt_cfgwizard.asp";	
	}
}

function changeMode()
{
	if(curWebMode == '0')
	{
		curWebMode = '1';
	}
	else
	{
		curWebMode = '0';
	}
	var Form = new webSubmitForm();
	Form.addParameter('mode', curWebMode);
	Form.setAction('changeMenu.cgi?'+'&RequestFile=index.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit(); 
}
</script>
<title>HUAWEI</title>
</head>
<body> 
<div id="main"> 
  <div id="header"> 
<script language="JavaScript" type="text/javascript">
if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLETSINGLE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase()) {
	document.write('<div id="headerLogoImg" style="background: url(../images/logobanner3bb.gif) no-repeat center; height: 70px; width: 144px;"></div>');
} else if (CfgMode.toUpperCase() == 'TRIPLET2WIFI6') {
	document.write('<div id="headerLogoImg" style="background: url(../images/logobanner3bbwifi6.gif) no-repeat center; height: 70px; width: 144px;"></div>');
} else if (SonetFlag == 1)
{
    document.write('<div id="headerLogoImg" style="background: url(../images/banner_bg.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('ORANGEMT' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_MA.gif) repeat-x center; height: 70px; width: 144px;"></div>');
} 
else if ('NOS' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_nos.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('ANTEL' == CfgMode.toUpperCase()||'ANTEL2' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_antel.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('DIGICEL' == CfgMode.toUpperCase() || 'DIGICEL2' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_digicel.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('PLDT' == CfgMode.toUpperCase() || 'PLDT2' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_pldt.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('GLOBE' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_globe.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_viettel.jpg) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('TS' == CfgMode.toUpperCase() || 'TS2' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_ts.jpg) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('CNT' == CfgMode.toUpperCase() || 'CNT2' == CfgMode.toUpperCase() )
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_logo_cnt.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('TM' == CfgMode.toUpperCase() )
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_logo_tm.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if ('OMANONT' == CfgMode.toUpperCase() || 'OMANONT2' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_logo_oman.gif) repeat-x center; height: 70px; width: 144px;"></div>');
}
else if('CLARODR' == CfgMode.toUpperCase() || 'CLARO' == CfgMode.toUpperCase())
{
	document.write('<div id="headerLogoImg" style="background: url(../images/banner_clarodr.gif) ; height: 68px; width: 144px;"></div>');
}
else
{
	document.write('<div id="headerLogoImg"></div>');
}	
</script>
    <div id="headerContent"> 
      <div id="headerInfo"> 
        <div id="headerTitle"></div> 
        <div id="headerLogout">
		<script language="JavaScript" type="text/javascript">
		if ( (tdeModeFlag == 1) && (curUserType == sysUserType))
		{
			document.write('<input style="position:relative;width:100px;height:25px;margin-right:20px;" id="Cmbutton" name="Cmbutton" onClick="changeMode();" type="button" value="Change Mode">'); 
			document.write('<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">');
		}
		else if( ('SLT' == CfgMode.toUpperCase()) && (curUserType != sysUserType))
		{
			var ButtonValue = curWebMode == 0 ? "Detail Setup" : "Quick Setup";
			var html = '<input style="position:relative;width:100px;height:25px;margin-right:20px;" id="Cmbutton" name="Cmbutton" onClick="changeMode();" type="button" value="';
			    html += ButtonValue + '">';
			document.write(html); 
			document.write('<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">');
		}
		else if( ('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase()) && (curUserType == sysUserType))
		{
			var ButtonValue = curWebMode == 0 ? "Advanced Setup" : "Easy Setup";
			var html = '<input style="position:relative;width:120px;height:25px;margin-right:20px;" id="Cmbutton" name="Cmbutton" onClick="changeMode();" type="button" value="';
			    html += ButtonValue + '">';
			document.write(html); 
			document.write('<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">');
		}
		</script>
		<span id="headerLogoutText"></span> </div> 
      </div> 
      <div id="headerTab"> 
        <ul> </ul> 
      </div> 
    </div> 
    <div id="headerSpace">&nbsp;</div> 
  </div> 
  <div id="center"> 
    <script language="JavaScript" type="text/javascript">
		if ( 'ORANGEMT' == CfgMode.toUpperCase())
		{	
			document.write('<div id="nav" class="orangement"> <ul> </ul> </div>'); 
		}
		else
		{
			document.write('<div id="nav" class="others"> <ul> </ul> </div>');
		}
		</script> 	
    <div id="content"> 
      <div id="topNav"> <span id="topNavMainMenu"></span>&nbsp;&gt;&nbsp;<span id="topNavSubMenu"></span> </div> 
      <div id="frameWarpContent"> 
        <iframe id="frameContent" frameborder="0" height="100%" marginheight="0" marginwidth="0" scrolling="no" width="100%"></iframe> 
      </div> 
    </div> 
  </div> 
  <div id="footer"> 
    <table border="0" cellpadding="0" cellspacing="0" width="100%"> 
      <tr> 
		<script language="JavaScript" type="text/javascript">

			  if ( 'BELL' == CfgMode.toUpperCase()
			   || 'TELUS' == CfgMode.toUpperCase()) 
			   {
					document.write('<td align="center" width="220px" nowrap><a href="/html/ssmp/softnotice/opensfnotice.asp">Open Source Software Notice</a></td>');
			   }
			   else
			   {
					if("1" == HostingQRcodeEnable)
					{

							document.write('<td width="200px">\
											<table border="0" cellpadding="0" cellspacing="0">\
												<tr><td height="5px"></td></tr>\
												<tr>\
													<td>\
														<a href="' + appUrl + '" target="_blank">\
															<img id="footer2DCode" src="/images/hw_2dcode.gif" border="0" />\
														</a>\
													</td>\
												</tr>\
												<tr><td id="appdes"></td></tr>\
											</table>\
										</td>');
						
					}
			   }
			</script>

		  
		  <td  valign="bottom" height="100%">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr><td height='100%' valign='top'></td></tr>
				<tr>
					<script language="JavaScript" type="text/javascript">        
					if (1 != SonetFlag)
					{
						document.write('<td id="footerLogo" width="5%"></td>');
					}
					</script>
					<td id="footerText" nowrap></td>
				</tr>
			</table>
		</td>
      </tr> 
    </table> 
  </div> 
  <div id="fresh"> 
    <iframe frameborder="0" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="refresh.asp" width="100%"></iframe> 
  </div> 
</div>
<script>
if (CfgMode.toUpperCase() == "ROSUNION") {
    ParseBindTextByTagName(RosWizardDes, "div", 1);
    ParseBindTextByTagName(RosWizardDes, "input", 2);
}
</script>
<script language="javascript" src="/html/bbsp/common/getWanDynamicData.asp"></script>
</body>
</html>
