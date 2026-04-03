<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' rel="stylesheet"  type='text/css'>
<link rel="shortcut icon" href="../../../images/singtel.ico" />
<link rel="Bookmark" href="../../../images/singtel.ico" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="javascript" src="/html/bbsp/common/GetLanUserDevInfo.asp"></script>
<script language="javascript" src="/html/bbsp/common/lanuserinfo.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
</head>
<script language="javascript">
var ConnectDevIp = '<%HW_WEB_GetCurDeviceIP();%>';
var curDevConType = '';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
function onindexpage(val)
{
	if (true == logo_singtel)
	{
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=mainpage.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
			;
			}
		});
		window.top.location.href="/mainpage.asp";
	}
	else
	{
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data) {
			;
			}
		});
		window.top.location.href="/index.asp";
	}
}

function onlaststep(val)
{
	val.id= "guidesyscfg";
	val.name= "/html/ssmp/accoutcfg/guideaccountcfg.asp";
	window.parent.onchangestep(val);
}

function wifiConfig()
{
	Form = window.parent.wifiForm;
	Form.oForm.target = "id_iframe";
	Form.submit();
}

function getCurDeviceConnectType()
{
	var UserDevices = new Array();
	GetLanUserInfo(function(para1, para2)
	{
		UserDevices = para2;
		for (var i=0; UserDevices.length > 0 && i < UserDevices.length-1; i++)
		{
			if (ConnectDevIp == UserDevices[i].IpAddr)
			{
				curDevConType = UserDevices[i].PortType;
				break;
			}
		}
		
		if('WIFI' == curDevConType)
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2042']);
			setDisplay("id_wifi_notice", 1);
		}
		else
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2041']);
		}
		
		if('ETH' == curDevConType)
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2041']);
		}
		else
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2042']);
			setDisplay("id_wifi_notice", 1);
		}		
	});
}

function LoadFrame()
{
	if(1 == window.parent.IsSurportWlanCfg)
	{
		getCurDeviceConnectType();
		wifiConfig();
	}
	else
	{
		$('#id_connect_type').html(CfgguideLgeDes['s2041']);
	}
}

</script>
<body onLoad="LoadFrame();" style="background-color: rgb(255, 255, 255);">
	<form>
		<div align="center">
			
			<div style="font-size:16px;color:#666666;font-weight:bold; margin-top: 35px;">
				<div BindText="s2040"  style="display:inline;"></div>
				<div id="id_connect_type" style="display:inline;"></div>
			</div>
			
			<div id="id_wifi_notice" style="margin-top: 10px; display:none;font-size: 16px;font-family: 微软雅黑;color: #666666;" BindText="s2043"></div>
			
			<div style="margin-top: 10px;font-size: 16px; font-family: 微软雅黑;color: #666666;" BindText="s2044"></div>
			

			<div style="margin-top: 35px">
				<input type="button" id="guidesyscfg"  class="CancleButtonCss buttonwidth_120px_180px" onClick="onlaststep(this);"  value="" BindText="s2020" name="/html/ssmp/accoutcfg/guideaccountcfg.asp">
				<input type="button" id="nextpage" class="ApplyButtoncss buttonwidth_120px_180px" onClick="onindexpage(this);" value="" BindText="s2021">
			</div>
		</div>
	</form>
	<script>
		ParseBindTextByTagName(CfgguideLgeDes, "td", 1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "div", 1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "input", 2, mngttype);
	</script>
	<iframe id="id_iframe" name="id_iframe" style="display:none;"></iframe>
</body>
</html>
