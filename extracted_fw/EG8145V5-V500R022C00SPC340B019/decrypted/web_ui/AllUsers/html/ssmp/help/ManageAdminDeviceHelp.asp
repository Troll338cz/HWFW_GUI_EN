<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="javascript" src="../common/ProductCapInfo.asp"></script>
<title>设备信息帮助</title>
</head>
<body class="mainbody">
<blockquote>
<script language="javascript">
    	   var webForceFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CLOSEFORCESUPPORT);%>';
		   var stProductCapInfo = new stProductFlag("0", "0", "0", "0", "0", "0");
		   var ftfirmware = '<%HW_WEB_GetFeatureSupport(FT_FIRMWARE_UPGRADE_PAGE);%>'; 
		   var featurequickcfg = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_QUICKCFG);%>';
		   var featuregxb = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_GXBMONITOR);%>';
		   var featureacssupport = '<%HW_WEB_GetFeatureSupport(FT_SSMP_IACCESS_WEB_RESTORE);%>';
		   var ftForceSupport = '<%HW_WEB_GetFeatureSupport(FT_WEB_FORCESUPPORT);%>';
		   var cfgMode = '<%HW_WEB_GetCfgMode();%>';
		   stProductCapInfo = GetProductCapInfo();
		   document.write("<b>设备重启 </b>");
		   document.write("<p> 点击 “重启” 按钮使终端重新启动。</p>");
           if (stProductCapInfo.usb == 1)
		   {	
				if(featurequickcfg == 1)
				{
			        document.write("<br>");
					document.write("<b>USB备份设置</b>");
					document.write("<p>将USB设备连接到终端，选择合适的USB分区，点击“备份配置”按钮，");
					document.write("将当前终端的配置备份到所选USB设备中。</p>");
				}
				document.write("<br>");
				document.write("<b>恢复出厂设置</b>");
				document.write("<p>  点击 “恢复出厂设置” 按钮，使终端设备的配置恢复为出厂配置并保留关键参数（如语音、无线参数等）。</p>");
				document.write("<br>");
				if (cfgMode.toUpperCase() == 'SHXCT') {
					document.write("<b>完全恢复出厂设置 </b>");
					document.write("<p>  点击 “完全恢复出厂设置” 按钮，使终端设备完全恢复出厂设置。</p>");
				} else {
					document.write("<b>清空网关配置 </b>");
					document.write("<p>  点击 “清空网关配置” 按钮，使终端设备配置清空。</p>");
				}

		   }
		   else if(stProductCapInfo.usb == 0)
		   {
				document.write("<br>");
				document.write("<b>恢复出厂设置</b>");
				document.write("<p>  点击 “恢复出厂设置” 按钮，使终端设备的配置恢复为出厂配置并保留关键参数（如语音、无线参数等）。</p>");
				document.write("<br>");
				if (cfgMode.toUpperCase() == 'SHXCT') {
					document.write("<b>完全恢复出厂设置 </b>");
					document.write("<p>  点击 “完全恢复出厂设置” 按钮，使终端设备完全恢复出厂设置。</p>");
				} else {
					document.write("<b>清空网关配置 </b>");
					document.write("<p>  点击 “清空网关配置” 按钮，使终端设备配置清空。</p>");
				}
			}
			if (webForceFlag == 1) {
				document.write("<br>");
				document.write("<b>关闭RMS跳转</b>");
				document.write("<p>  点击 “关闭RMS跳转” 按钮，可以关闭RMS注册强制跳转功能。</p>");
			}
			if(1 == ftfirmware)
			{
				document.write("<br>");
				document.write("<b>固件升级 </b>");
				document.write("<p> 通过固件升级功能，选择加载运营商提供的合法固件，可以更新设备的软件版本。</p>");
			}
			
			
			if(1 == featuregxb && 1==featureacssupport)
			{
				document.write("<br>");
				document.write("<b>恢复开箱 </b>");
				document.write("<p> 点击 “恢复开箱” 按钮，使终端设备进行恢复开箱操作。</p>");
			}
			
			if (ftForceSupport == 1)
			{
				document.write("<br>");
				document.write("<b>关闭强推 </b>");
				document.write("<p>  点击 “关闭强推” 按钮，可以关闭终端的强制推送页面功能。</p>");
			}
		</script>
		

</blockquote>
</body>
</html>

