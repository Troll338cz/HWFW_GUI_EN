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
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="JavaScript" type="text/javascript">
var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();

var SingleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SINGLE_WLAN);%>';
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var LanHttpDisableFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_LANHTTP_EDIT_DISABLE);%>';
var PortAclFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PORT_ACL);%>';
var ApModeValue = '<%HW_WEB_GetAPChangeModeValue();%>';
var selctIndex = -1;
var wantelflag = '<%HW_WEB_GetRemoteTelnetAbility();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var securityAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_SECURITY_ACCESS);%>';
var isWanAccess = '<%HW_WEB_GetFeatureSupport(FT_WEB_WAN_ACCESS);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var TableName = "SIPWhiteListConfigList";

function TelnetLanEnable()
{   
    var enabletelnetwifi = getCheckVal('telnetlan');
    if (enabletelnetwifi && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
        setCheck('telnetlan', 0);
        return;
    }
    if (IsE8cFrame()) {
        setDisplay('telnetwifiRow', enabletelnetwifi);
        setDisable('telnetwifi', !enabletelnetwifi);        
    }
}

function TelnetWifiEnable()
{
    var enabletelnetwifi = getCheckVal('telnetwifi');
    if (enabletelnetwifi && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
        setCheck('telnetwifi', 0);
        return;
    }
}

function TelnetWanEnable()
{
    var enabletelnet = getCheckVal('telnetwan');
    if (enabletelnet && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
        setCheck('telnetwan', 0);
        return;
    }
}

function stAclInfo(domain,HttpWanEnable,TelnetLanEnable,TelnetWanEnable,HTTPWifiEnable,TELNETWifiEnable, SSHLanEnable, SSHWanEnable)
{
    this.domain = domain;
    this.HttpWifiEnable = HTTPWifiEnable;
    this.TelnetWifiEnable = TELNETWifiEnable;
    this.HttpWanEnable = HttpWanEnable;
    this.TelnetLanEnable = TelnetLanEnable;
    this.TelnetWanEnable = TelnetWanEnable;
    this.SSHLanEnable = SSHLanEnable;
    this.SSHWanEnable = SSHWanEnable;
}

var aclinfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecAclInfos, InternetGatewayDevice.X_HW_Security.AclServices,HTTPWanEnable|TELNETLanEnable|TELNETWanEnable|HTTPWifiEnable|TELNETWifiEnable|SSHLanEnable|SSHWanEnable,stAclInfo);%>;  
var AclInfo = aclinfos[0];

function SetCtrlConfigPanel(iDisable)
{
    setDisable('httpwifi', iDisable);
    setDisable('telnetwifi', iDisable);
    setDisable('telnetlan' , iDisable);
    setDisable('httpwan' , iDisable);
    setDisable('telnetwan' , iDisable);
    setDisable('bttnApply' , iDisable);
    setDisable('cancelValue' , iDisable);
    setDisable('sshlan' , iDisable);
    setDisable('sshwan' , iDisable);
}

function LoadFrame()
{    
    setCheck('httpwifi',AclInfo.HttpWifiEnable);
    setCheck('httpwan',AclInfo.HttpWanEnable);
    setCheck('telnetlan',AclInfo.TelnetLanEnable);
    setCheck('telnetwan',AclInfo.TelnetWanEnable);
    setCheck('telnetwifi',AclInfo.TelnetWifiEnable);
    setCheck('sshlan',AclInfo.SSHLanEnable);
    setCheck('sshwan',AclInfo.SSHWanEnable);
	
	if (PortAclFlag == 1)
	{	
		setDisplay("appendacltitle", 1);
	}
        
    if( AclInfo.TelnetLanEnable == 0 && PortAclFlag == 0 )
    {
        setDisable('telnetwifi' , 1);
    }   
    if(parseInt(AclInfo.HttpLanEnable,10) == 0 && PortAclFlag == 0 )
    {
        setDisable('httpwifi' , 1);  
    }

    if(FltsecLevel != 'CUSTOM')
    {
        SetCtrlConfigPanel(1);              
    }
    
    if(IsAdminUser() == false)          
    {              
        setDisplay('lan_table', 0);         
        setDisplay('telnetwifiRow', 0); 
        setDisplay('wan_table', 0);                     
        setDisplay('ListConfigPanel', 0);  
        setDisplay('ConfigPanel', 0);
        setDisplay('wifi_space', 0);
        setDisplay('wan_space', 0);
    }
    else if(IsE8cFrame())
    {
        setDisplay('lan_table', 1); 
        setDisplay('sshlanRow', 0);                 
        setDisplay('telnetwifiRow', getCheckVal('telnetlan')); 
        setDisplay('wan_table', 0);                     
        setDisplay('ListConfigPanel', 0);  
        setDisplay('ConfigPanel', 0);
        setDisplay('wifi_space', 0);
        setDisplay('wan_space', 0);
    }
    else
    {
        setDisplay('lan_table', 1);         
        setDisplay('telnetwifiRow', 1); 
        if ((securityAccessFlag != '1') && (isWanAccess == '1')) {
            setDisplay('wan_table', 1);
        }
        setDisplay('ListConfigPanel', 1);  
    }

    if('0' == wantelflag)
    {
        setDisable('telnetwan' , 1);
        setCheck('telnetwan', 0);
    }
    
    if(SingleFreqFlag != 1 && DoubleFreqFlag != 1)
    { 
        setDisplay('wifi_space', 0);
        setDisplay('wifi_table', 0);   
    } 

    if (1 == LanHttpDisableFlag)
    {
        setDisable('httplan', 1);
    }
}

function FormCheck()
{ 
	var WifiServiceFlag = 0;
	var LanServiceFlag = 0;
	var WanServiceFlag = 0;
	
    if(((AclInfo.HttpWifiEnable != getCheckVal('httpwifi'))&&(0 == getCheckVal('httpwifi')))
		|| ((AclInfo.TelnetWifiEnable != getCheckVal('telnetwifi'))&&(0 == getCheckVal('telnetwifi'))))
    {
		WifiServiceFlag++;
    }

    if(((AclInfo.HttpLanEnable != getCheckVal('httplan'))&&(0 == getCheckVal('httplan')))
		||((AclInfo.TelnetLanEnable != getCheckVal('telnetlan'))&&(0 == getCheckVal('telnetlan')))
		||((AclInfo.SSHLanEnable != getCheckVal('sshlan'))&&(0 == getCheckVal('sshlan'))))
    {
		LanServiceFlag++;
    }


        if(((AclInfo.HttpWanEnable != getCheckVal('httpwan'))&&(0 == getCheckVal('httpwan')))
			|| ((AclInfo.TelnetWanEnable != getCheckVal('telnetwan'))&&(0 == getCheckVal('telnetwan')))
			|| ((AclInfo.SSHWanEnable != getCheckVal('sshwan'))&&(0 == getCheckVal('sshwan'))))
        {
			WanServiceFlag++;
        }      

    
	var ServiceFlag = WifiServiceFlag + LanServiceFlag + WanServiceFlag;
	
	if (ServiceFlag > 1)
	{
		if (false == ConfirmEx(acl_language['bbsp_service_prompt']))
		{
			setCheck('httpwifi',AclInfo.HttpWifiEnable);
			setCheck('telnetwifi',AclInfo.TelnetWifiEnable);
			setCheck('httplan',AclInfo.HttpLanEnable);
			setCheck('telnetlan',AclInfo.TelnetLanEnable);
			setCheck('sshlan',AclInfo.SSHLanEnable);
			setCheck('httpwan',AclInfo.HttpWanEnable);
			setCheck('telnetwan',AclInfo.TelnetWanEnable);
			setCheck('sshwan',AclInfo.SSHWanEnable);

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
            setCheck('httplan',AclInfo.HttpLanEnable);
			setCheck('telnetlan',AclInfo.TelnetLanEnable);
			setCheck('sshlan',AclInfo.SSHLanEnable);
            return false;
        }
	}
	
	else if (1 == WanServiceFlag)
	{
	    if(false == ConfirmEx(acl_language['bbsp_confirm_wan']))
        {
            setCheck('httpwan',AclInfo.HttpWanEnable);
			setCheck('telnetwan',AclInfo.TelnetWanEnable);
			setCheck('sshwan',AclInfo.SSHWanEnable);
            return false;
        }
	}
	
    if('1'==PortAclFlag && '0' == curUserType )
    {
        if((false== getCheckVal('httplan'))&&(false == getCheckVal('httpwifi')))
        {
            if(false == ConfirmEx(acl_language['bbsp_alter_http']) ) 
            {
                if(AclInfo.HttpLanEnable == '1')
                {   
                    setCheck('httplan',1);
                }
                
                if(AclInfo.HttpWifiEnable == 1)
                {
                    setCheck('httpwifi',1);
                }
                return false;
            }
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
    
    if((IsAdminUser() == true) && !IsE8cFrame())
    {       
        Form.addParameter('HTTPWifiEnable',getCheckVal('httpwifi'));    
        Form.addParameter('TELNETWifiEnable',getCheckVal('telnetwifi'));
        Form.addParameter('TELNETLanEnable',getCheckVal('telnetlan'));
        Form.addParameter('SSHLanEnable',getCheckVal('sshlan'));
        if ((securityAccessFlag != '1') && (isWanAccess == '1')) {
            Form.addParameter('SSHWanEnable',getCheckVal('sshwan'));
            Form.addParameter('HTTPWanEnable',getCheckVal('httpwan'));
            Form.addParameter('TELNETWanEnable',getCheckVal('telnetwan'));
        }
    }
    else if((IsAdminUser() == true) && IsE8cFrame())
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
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices&RequestFile=html/bbsp/acl/aclsmartap.asp');  
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

function SIPWhiteListConfigListselectRemoveCnt(val)
{

}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt"), false);
</script>
<div class="title_spread"></div>

<form id="lan_table" style="display:none;"> 
    <div id="LanServiceTitle" class="func_title" BindText="bbsp_table_lan"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li   id="telnetlan"   RealType="CheckBox"  DescRef="bbsp_table_lantel"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.TELNETLanEnable"  InitValue="" ClickFuncApp="onclick=TelnetLanEnable" />
        <li   id="sshlan"   RealType="CheckBox"  DescRef="bbsp_table_lanssh"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SSHLanEnable"  InitValue="" />
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
        <li   id="telnetwifi"   RealType="CheckBox"  DescRef="bbsp_table_wifitelnet"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.TELNETWifiEnable"  InitValue="" ClickFuncApp="onclick=TelnetWifiEnable"/>/>
    </table>
    <script>
        var WlanServiceFormList = new Array();
        WlanServiceFormList = HWGetLiIdListByForm("wifi_table",null);
        HWParsePageControlByID("wifi_table",TableClass,acl_language,null);
        if (IsPTVDFFlag == 1)
        {
            document.getElementById("httpwifiColleft").innerHTML = acl_language['bbsp_table_wifihttp1'];
        }
        else
        {
            document.getElementById("httpwifiColleft").innerHTML = acl_language['bbsp_table_wifihttp'];
        }
    </script>
</form> 

<form id="wan_table" style="display:none;"> 
<div class="func_spread"></div>
    <div id="WanServiceTitle" class="func_title" BindText="bbsp_table_wan"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li   id="httpwan"   RealType="CheckBox"  DescRef="bbsp_table_wanhttp"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.HTTPLanEnable"  InitValue="" />
        <li   id="telnetwan"   RealType="CheckBox"  DescRef="bbsp_table_wantel"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.TELNETWanEnable"  InitValue="" ClickFuncApp="onclick=TelnetWanEnable"/>
        <li   id="sshwan"   RealType="CheckBox"  DescRef="bbsp_table_wanssh"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SSHWanEnable"  InitValue="" />
    </table>
    <script>
        var WanServiceFormList = new Array();
        WanServiceFormList = HWGetLiIdListByForm("wan_table",null);
        HWParsePageControlByID("wan_table",TableClass,acl_language,null);
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
