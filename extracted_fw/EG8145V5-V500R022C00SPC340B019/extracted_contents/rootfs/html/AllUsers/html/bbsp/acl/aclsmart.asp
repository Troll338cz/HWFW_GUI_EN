<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>ACL</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="JavaScript" type="text/javascript">
var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();
var SingleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SINGLE_WLAN);%>';
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var PortAclFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PORT_ACL);%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var TDEMode = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';

function stAclInfo(domain,TelnetLanEnable,HTTPWifiEnable,TELNETWifiEnable)
{
	this.domain = domain;
	this.HttpWifiEnable = HTTPWifiEnable;
	this.TelnetWifiEnable = TELNETWifiEnable;
	this.TelnetLanEnable = TelnetLanEnable;
}

function IsOSKNormalUser()
{
	if (GetCfgMode().OSK == "1" && curUserType != '0')
	{
		return true;
	}
	else
	{
		return false;
	}
}

var aclinfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecAclInfos, InternetGatewayDevice.X_HW_Security.AclServices,TELNETLanEnable|HTTPWifiEnable|TELNETWifiEnable,stAclInfo);%>;  
var AclInfo = aclinfos[0];

function LoadFrame()
{
	setCheck('httpwifi',AclInfo.HttpWifiEnable);
	setCheck('telnetlan',AclInfo.TelnetLanEnable);
	setCheck('telnetwifi',AclInfo.TelnetWifiEnable);
    
	if (PortAclFlag == 1)
	{	
		setDisplay("appendacltitle", 1);
	}
	
	if( AclInfo.TelnetLanEnable == 0)
	{
	    setDisable('telnetwifi' , 1);
	}   
	if(parseInt(AclInfo.HttpLanEnable,10) == 0)
	{
	    setDisable('httpwifi' , 1);  
	}

	if(FltsecLevel != 'CUSTOM')
	{                
		setDisable('httpwifi', 1);
		setDisable('telnetwifi', 1);
		setDisable('telnetlan' , 1);
		
		setDisable('bttnApply' , 1);
		setDisable('cancelValue' , 1);
	}    
	
	if((IsAdminUser() == false) || IsE8cFrame())     		
	{              
	    setDisplay('lan_table', 0);    	    
	    setDisplay('telnetwifiRow', 0); 
	}
	else
	{
		setDisplay('lan_table', 1);    	    
	    setDisplay('telnetwifiRow', 1); 
	}
	
	if (true == IsOSKNormalUser())
    {
	    setDisplay('lan_table', 1);    	    
	    setDisplay('telnetwifiRow', 1); 
    }

	if ('1' == TDEMode)
	{
		setDisplay('lan_table', 0);
		setDisplay('telnetwifiRow', 0);
	}
	
	if(SingleFreqFlag != 1 && DoubleFreqFlag != 1)
	{ 
		setDisplay('wifi_table', 0);   
	} 

	if (((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) && (FltsecLevel != 'CUSTOM')) {
        setDisable('telnetlanRow', 1);
        setDisable('httpwifiRow', 1);
        setDisable('telnetwifiRow' , 1);
        setDisable('bttnApply' , 1);
        setDisable('cancelValue' , 1);
    	document.getElementById("LanServiceTitle").style.color="#767676";
        document.getElementById("telnetlanColleft").style.color="#767676";
        document.getElementById("WlanServiceTitle").style.color="#767676";
        document.getElementById("httpwifiColleft").style.color="#767676";
        document.getElementById("telnetwifiColleft").style.color="#767676";
    } 
    if ((CfgModeWord == "TEDATA") || (CfgModeWord == "TEDATA2")) {
            setDisplay('telnetwifiRow', 0);
            setDisplay('lan_table', 0);
            setDisplay('telnetlanRow', 0);
            setDisplay('telnetwanRow', 0);
    }
}

function FormCheck()
{
	var WifiServiceFlag = 0;
	var LanServiceFlag = 0;

	if(((AclInfo.HttpWifiEnable != getCheckVal('httpwifi'))&&(0 == getCheckVal('httpwifi')))
		||((AclInfo.TelnetWifiEnable != getCheckVal('telnetwifi'))&&(0 == getCheckVal('telnetwifi'))))
	{
		WifiServiceFlag++;
	}
	
	if((AclInfo.TelnetLanEnable != getCheckVal('telnetlan'))&&(0 == getCheckVal('telnetlan')))
    {
		LanServiceFlag++;
    }
	
	var ServiceFlag = WifiServiceFlag + LanServiceFlag;
	
	if (ServiceFlag > 1)
	{
		if (false == ConfirmEx(acl_language['bbsp_service_prompt']))
		{
			setCheck('httpwifi',AclInfo.HttpWifiEnable);
			setCheck('telnetwifi',AclInfo.TelnetWifiEnable);
			setCheck('telnetlan',AclInfo.TelnetLanEnable);
            return false;
		}
	}

	else if (1 == WifiServiceFlag)
	{
        if(false == ConfirmEx(acl_language['bbsp_confirm_wifi']))
        {
			setCheck('httpwifi',AclInfo.HttpWifiEnable);
			setCheck('telnetwifi',AclInfo.TelnetWifiEnable);
            return false;
        }
	}
	
	else if (1 == LanServiceFlag)
	{
        if(false == ConfirmEx(acl_language['bbsp_confirm_lan']))
        {
			setCheck('telnetlan',AclInfo.TelnetLanEnable);
            return false;
        }
	}

	return true;
}

function SubmitForm()
{
	if(false == FormCheck())
    {
        return;
    }

	setDisable('btnApply', 1);
    setDisable('cancelValue', 1);

    var Form = new webSubmitForm();
    Form.usingPrefix('x');
	
	if(((IsAdminUser() == true) && !IsE8cFrame())
			|| (true == IsOSKNormalUser()))
	{
		Form.addParameter('TELNETLanEnable',getCheckVal('telnetlan'));
		Form.addParameter('HTTPWifiEnable',getCheckVal('httpwifi'));	
		Form.addParameter('TELNETWifiEnable',getCheckVal('telnetwifi'));
	}
	else
	{ 
		 Form.addParameter('HTTPWifiEnable',getCheckVal('httpwifi')); 
	}
    Form.endPrefix();		
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices&RequestFile=html/bbsp/acl/aclsmart.asp');	
	Form.submit();			
	setDisable('bttnApply',1);
    setDisable('cancelValue',1);  
}

function ChangeLevel(level)
{
	 
}

function CancelConfig()
{
    LoadFrame();
}

function TelnetLanEnable()
{
    if (CfgModeWord == "POLNETIA") {
        return;
    }
    var enabletelnet = getCheckVal('telnetlan');
    if (enabletelnet && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
        setCheck('telnetlan', 0);
        return;
    }
}

function TelnetWifiEnable()
{
    if (CfgModeWord == "POLNETIA") {
        return;
    }
    var enabletelnetwifi = getCheckVal('telnetwifi');
    if (enabletelnetwifi && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
        setCheck('telnetwifi', 0);
        return;
    }
}


</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
if (IsPTVDFFlag == 1) {
	HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt1"), false);
} else if ((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) {
    HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt_cnt"), false);
} else {
	HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt"), false);
}
</script>
<div class="title_spread"></div>

<form id="lan_table" style="display:none;"> 
	<div id="LanServiceTitle" class="func_title" BindText="bbsp_table_lan"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li   id="telnetlan"   RealType="CheckBox"  DescRef="bbsp_table_lantel"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.TELNETLanEnable"  InitValue="" ClickFuncApp="onclick=TelnetLanEnable"/>
	</table>
	<script>
		var TableClass = new stTableClass("per_35_52", "per_65_48", "ltr");
		var LanServiceFormList = new Array();
		LanServiceFormList = HWGetLiIdListByForm("lan_table",null);
		HWParsePageControlByID("lan_table",TableClass,acl_language,null);
	</script>
	<div class="func_spread"></div>
</form> 

<form id="wifi_table" style="display:block;"> 
	<div id="WlanServiceTitle" class="func_title" BindText="bbsp_table_wifi"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li   id="httpwifi"     RealType="CheckBox"  DescRef=""   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.HTTPWifiEnable"  InitValue="" />
		<li   id="telnetwifi"   RealType="CheckBox"  DescRef="bbsp_table_wifitelnet"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.TELNETWifiEnable"  InitValue="" ClickFuncApp="onclick=TelnetWifiEnable"/>
	</table>
	<script>
		var WlanServiceFormList = new Array();
		WlanServiceFormList = HWGetLiIdListByForm("wifi_table",null);
		HWParsePageControlByID("wifi_table",TableClass,acl_language,null);
		if (IsPTVDFFlag == 1)
		{
			setNoEncodeInnerHtmlValue("httpwifiColleft", acl_language['bbsp_table_wifihttp1']);
		}
		else
		{
			setNoEncodeInnerHtmlValue("httpwifiColleft", acl_language['bbsp_table_wifihttp']);
		}
	</script>
</form> 

<table class="table_button" width="100%"> 
  <tr>
	<td class='width_per35'></td> 
	<td class="table_submit width_per65">
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	 <button id="bttnApply" name="bttnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();" id="Button1"><script>document.write(acl_language['bbsp_app']);</script></button>
	  <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(acl_language['bbsp_cancel']);</script></button></td> 
  </tr> 
</table>
<div class="func_spread"></div>
<script>
	ParseBindTextByTagName(acl_language, "td",    1);
	ParseBindTextByTagName(acl_language, "div",   1);
</script>
</body>
</html>
