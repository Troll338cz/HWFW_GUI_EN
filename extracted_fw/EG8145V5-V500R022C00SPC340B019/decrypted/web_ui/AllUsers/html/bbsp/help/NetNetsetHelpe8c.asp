<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var IsSupportVoice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
var AddSpecSrvType = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_SPECAIL_SERVICE);%>';
var mngtTY40 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TIANYI_40);%>';
function GetServLang(type)
{
	var serv =
	{
		internet_voip_tr069_en: 'TR069_VOICE_INTERNET',
		voip_tr069_en:    'TR069_VOICE',
		internet_voip_en:    'VOICE_INTERNET',
		voip_en:     'VOICE',
		other_en: 'OTHER',
		internet_en: 'INTERNET',
		tr069_en: 'TR069',
		internet_tr069_en:'TR069_INTERNET',
		ott_en: 'OTT',
		iptv_en: 'IPTV',
		iptv_voip_tr069_en: 'IPTV_VOIP_TR069',
		iptv_tr069_en: 'IPTV_TR069',
		iptv_voip_cn: 'IPTV_VOIP',
		vr_cn: 'VR业务',
		SPECIAL_SERVICE_1_en:  'SPECIAL_SERVICE_1',
		SPECIAL_SERVICE_2_en:  'SPECIAL_SERVICE_2',
		SPECIAL_SERVICE_3_en:  'SPECIAL_SERVICE_3',
		SPECIAL_SERVICE_4_en:  'SPECIAL_SERVICE_4',
		
		internet_voip_tr069_cn: '上网+语音+管理',
		voip_tr069_cn:    '语音+管理',
		internet_voip_cn:    '上网+语音',
		voip_cn:     '语音',
		other_cn: '其他',
		internet_cn: '上网',
		tr069_cn: '管理',
		internet_tr069_cn:'上网+管理',
		ott_cn: 'OTT',
		iptv_cn: 'IPTV',
		iptv_voip_tr069_cn: 'IPTV+语音+管理',
		iptv_tr069_cn: 'IPTV+管理',
		iptv_voip_cn: 'IPTV+语音',
		vr_cn: 'VR业务',
		SPECIAL_SERVICE_1_cn:  'SPECIAL_SERVICE_1',
		SPECIAL_SERVICE_2_cn:  'SPECIAL_SERVICE_2',
		SPECIAL_SERVICE_3_cn:  'SPECIAL_SERVICE_3',
		SPECIAL_SERVICE_4_cn:  'SPECIAL_SERVICE_4'
	};
	
	return serv[type + ((1 == '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_AHCT);%>')? "_en" : "_cn")]; 
}	

function LoadFrame()
{
   if (!IsCmcc_rmsMode())
   {
      setDisplay("iptv",0);
	  setDisplay("ott",0);
	  setDisplay("iptv_tr069",0);
   }
}

</script>
<title>宽带设置信息</title>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<blockquote>
<table border="0">
  <tr>
    <td width="80" ><strong>服务模式:</strong></td>
    <script language="JavaScript" type="text/javascript">
	document.write('<td width="160">' + GetServLang('tr069') + '</td>');
    </script>
    <td>专用于远程网管</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	document.write('<td>' + GetServLang('internet') + '</td>');
    </script>
    <td>专用于上网</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
    document.write('<td width="90">' + GetServLang('internet_tr069') + '</td>');
    </script>
    <td>同时用于上网和远程网管</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	document.write('<td>' + GetServLang('other') + '</td>');
    </script>
    <td>专用于IPTV</td>
  </tr>
  <tr id="iptv">
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	document.write('<td>' + GetServLang('iptv') + '</td>');
    </script>
    <td>专用于IPTV</td>
  </tr>
  <tr id="ott">
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	document.write('<td>' + GetServLang('ott') + '</td>');
    </script>
    <td>专用于互联网电视</td>
  </tr>
  <tr id="iptv_tr069">
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	document.write('<td>' + GetServLang('iptv_tr069') + '</td>');
    </script>
    <td>同时用于IPTV和远程网管</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(IsSupportVoice == '1')
	{
	    document.write('<td width="90">' + GetServLang('internet_voip_tr069') + '</td>');
		document.write('<td>' + '同时用于上网、宽带语音和远程网管' + '</td>');
	}
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(IsSupportVoice == '1')
	{
	    document.write('<td>' + GetServLang('voip_tr069') + '</td>');
		document.write('<td>' + '同时用于宽带语音和远程网管' + '</td>');
	}
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(IsSupportVoice == '1')
	{
	    document.write('<td>' + GetServLang('voip') + '</td>');
		document.write('<td>' + '专用于宽带语音' + '</td>');
	}    
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(IsSupportVoice == '1')
	{
     	document.write('<td>' + GetServLang('internet_voip') + '</td>');
		document.write('<td>' + '同时用于上网和宽带语音' + '</td>');
	}
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
if (mngtTY40 == '1') {
   document.write('<td>' + GetServLang('vr') + '</td>');
   document.write('<td>' + '专用于VR（虚拟现实）业务' + '</td>');
}
</script>
</tr>

  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(IsSupportVoice == '1' && IsCmcc_rmsMode())
	{
     	document.write('<td>' + GetServLang('iptv_voip_tr069') + '</td>');
		document.write('<td>' + '同时用于IPTV、宽带语音和远程管理' + '</td>');
	}
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(IsSupportVoice == '1' && IsCmcc_rmsMode())
	{
     	document.write('<td>' + GetServLang('iptv_voip') + '</td>');
		document.write('<td>' + '同时用于IPTV和宽带语音' + '</td>');
	}
    </script>
  </tr>
   <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
     if(AddSpecSrvType == '1')
	{	document.write('<td>' + GetServLang('SPECIAL_SERVICE_1') + '</td>');
		document.write('<td>' + '表示此连接仅用于新增特定应用（如某智慧家庭应用）' + '</td>');
	}
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(AddSpecSrvType == '1')
	{
     	document.write('<td>' + GetServLang('SPECIAL_SERVICE_2') + '</td>');
		document.write('<td>' + '表示此连接仅用于新增特定应用（如某智慧家庭应用）' + '</td>');
	}
    </script>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(AddSpecSrvType == '1')
	{
     	document.write('<td>' + GetServLang('SPECIAL_SERVICE_3') + '</td>');
		document.write('<td>' + '表示此连接仅用于新增特定应用（如某智慧家庭应用）' + '</td>');
	}
    </script>
  </tr>
<tr>
    <td>&nbsp;</td>
    <script language="JavaScript" type="text/javascript">
	if(AddSpecSrvType == '1')
	{
     	document.write('<td>' + GetServLang('SPECIAL_SERVICE_4') + '</td>');
		document.write('<td>' + '表示此连接仅用于新增特定应用（如某智慧家庭应用）' + '</td>');
	}
    </script>
  </tr>
</table>
</blockquote>

</body>
</html>
