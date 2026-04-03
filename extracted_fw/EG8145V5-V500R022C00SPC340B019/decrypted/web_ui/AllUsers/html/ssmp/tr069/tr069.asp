<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="/html/ssmp/tr069/<%HW_WEB_GetReloadCus(tr069.cus);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<style>
form{padding:0;margin:0}
</style>
<script language="JavaScript" type="text/javascript">
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var UnicomFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>";
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var apstunfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_TR111_P2);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var CuOSGIMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CU_OSGI_MODE);%>';
var log_stc = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_DSL_STC);%>';
var UnSupportIpv6 = '<%HW_WEB_GetFeatureSupport(FT_CWMP_SUPPORT_IPV6);%>';
var reqFile = "html/ssmp/tr069/tr069.asp";
var maxisLocalUserType = '1';
var curUserType = '<%HW_WEB_GetUserType();%>';
var apportmapping = '<%HW_WEB_GetFeatureSupport(FT_AP_TR069_PORTMAPPING);%>';
var isSpecialFlag = '<%HW_WEB_GetFeatureSupport(FT_SONET_WEB_PWD_LENGTH);%>';
var ispwdLength = '<%HW_WEB_GetFeatureSupport(FT_WEB_PWD_LENGTH_CHECK);%>';
var pwdComplexFt = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';
var PwdMinLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
var Ftmodifyowner =  '<%HW_WEB_GetFeatureSupport(FT_WEB_MODIFY_OWNER_PWD);%>';
var sptUserName = null;
var secondLoginFialFlag ='<%WEB_GetSecondLoginFailFlag();%>';
var apShowConfig = '<%HW_WEB_GetFeatureSupport(FT_WEB_AP_SHOWTR069);%>';
var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName|UserLevel|Enable|ModifyPasswordFlag, stModifyUserInfo);%>;
function stModifyUserInfo(domain,UserName,UserLevel,Enable,modifyFlag) {
    this.domain = domain;
    this.UserName = UserName;
    this.UserLevel = UserLevel;
    this.Enable = Enable;
    this.modifyFlag = modifyFlag;
}

if (((CfgModeWord == "TELMEXACCESS") || (CfgModeWord == "TELMEXACCESSNV")) && secondLoginFialFlag == 1) {
    window.location = '/login.asp'
}

var mongoFlag = 0;
if ((CfgMode == "MONGOLIA") || (CfgMode == "MONGOLIA2") || (CfgMode == "DMNUNIVI2")) {
    mongoFlag = 1;
}

if (CfgMode.toUpperCase() == "TURKCELL2") {
    reqFile = "remote/tr069.html";
}

if (CfgMode.toUpperCase() == "DESKAPFPT") {
    var AcsReload = 
    [
        {ReloadId:"PeriodicInformEnable", ReloadValue:[{disabled:1}]},
        {ReloadId:"PeriodicInformTime", ReloadValue:[{disabled:1}]},
        {ReloadId:"URL", ReloadValue:[{disabled:1}]},
        {ReloadId:"Username", ReloadValue:[{disabled:1}]},
        {ReloadId:"Password", ReloadValue:[{disabled:1}]},
        {ReloadId:"ConnectionRequestUsername", ReloadValue:[{disabled:1}]},
        {ReloadId:"ConnectionRequestPassword", ReloadValue:[{disabled:1}]},
        {ReloadId:"PeriodicInformInterval", ReloadValue:[{disabled:1}]},
    ]
}

function title_show(input)
{
    var div=document.getElementById("title_show");

	if(1 == log_stc){
		return;
	}
    if ("ARABIC" == LoginRequestLanguage.toUpperCase())
    {
        div.style.right = (input.offsetLeft+50)+"px";
    }
    else if (1 == UnicomFlag)
    {
        div.style.width ="250px";
        div.style.left = (input.offsetLeft+320)+"px";
    }
    else if (CfgModeWord == "TELMEX2WIFI")
    {
        div.style.left = (input.offsetLeft+790)+"px";
    }
    else
    {
        div.style.left = (input.offsetLeft+390)+"px";
    }

    div.innerHTML = Tr069LgeDes['s1116'];
    
    div.style.display = '';
    if ( 'ZAIN' == CfgMode.toUpperCase() || CuOSGIMode == "1")
    {
        div.style.color = '#000000';
    }
}
function title_back(input)
{
    var div=document.getElementById("title_show");
    div.style.display = "none";
}

function IsForceCheckConnectInfo(){
	if(1 == log_stc)
	{
		return false;
	}
	
	return true;
}

function stCWMP(domain,EnableCWMP,PeriodicInformEnable,PeriodicInformInterval,PeriodicInformTime,URL,Username,ConnectionRequestUsername,X_HW_EnableCertificate,X_HW_DSCP,X_HW_CheckPasswordComplex,STUNEnable,STUNMinimumKeepAlivePeriod,STUNMaximumKeepAlivePeriod,STUNServerAddress,STUNServerPort,STUNUsername,STUNPassword,EnableGWNat,ConnectionRequestURL)
{
    this.domain = domain;
    this.EnableCWMP = EnableCWMP;
    this.PeriodicInformEnable = PeriodicInformEnable;
    this.PeriodicInformInterval = PeriodicInformInterval;
    this.PeriodicInformTime = PeriodicInformTime;
    this.URL = URL;
    this.Username = Username;
    this.Password = "********************************";
    this.ConnectionRequestUsername = ConnectionRequestUsername;
    this.ConnectionRequestPassword = "********************************";
    this.X_HW_EnableCertificate  = X_HW_EnableCertificate ;
    this.X_HW_DSCP  = X_HW_DSCP;
    this.X_HW_CheckPasswordComplex = X_HW_CheckPasswordComplex;
    this.STUNEnable = STUNEnable;
    this.STUNMinimumKeepAlivePeriod = STUNMinimumKeepAlivePeriod;
    this.STUNMaximumKeepAlivePeriod = STUNMaximumKeepAlivePeriod;
    this.STUNServerAddress = STUNServerAddress;
    this.STUNServerPort = STUNServerPort;
    this.STUNUsername = STUNUsername;
    this.STUNPassword = STUNPassword;
    this.EnableGWNat = EnableGWNat;
    this.ConnectionRequestURL = ConnectionRequestURL;
}

function stManageFlag(ManageFlag)
{
    this.ManageFlag = ManageFlag;
}

function maxisLocalUserAshesTR069()
{
    if (CfgMode.toUpperCase() != "DETHMAXIS") {
        return;
    }

    if (curUserType != maxisLocalUserType) {
        return;
    }

    setDisable('EnableCWMP',1);
    setDisable('PeriodicInformEnable',1);
    setDisable('PeriodicInformInterval',1);
    setDisable('PeriodicInformTime',1);
    setDisable('URL',1);
    setDisable('Username',1);
    setDisable('Password',1);
    setDisable('ConnectionRequestUsername',1);
    setDisable('ConnectionRequestPassword',1);
    setDisable('X_HW_DSCP',1);
    setDisable('ACSbtnApply',1);
    setDisable('ACScancelValue',1);
    setDisable('CertificateEnable',1);
    setDisable('X_HW_CertPassword',1);
    setDisable('CfmPassword',1);
    setDisable('PWDbtnApply',1);
    setDisable('PWDcancelValue',1);
    setDisable('f_file',1);
    setDisable('t_file',1);
    setDisable('ImportCertification',1);

    setDisable('STUNEnable',1);
    setDisable('STUNMinimumKeepAlivePeriod',1);
    setDisable('STUNMaximumKeepAlivePeriod',1);
    setDisable('STUNServerAddress',1);
    setDisable('STUNServerPort',1);
    setDisable('STUNUsername',1);
    setDisable('STUNPassword1',1);
    setDisable('StunbtnApply',1);
    setDisable('StuncancelValue',1);
}

var UnChangeURL = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGEURL);%>'
var UnChangeUser = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGEUSER);%>'
var UnChangePeriod = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGEPERIOD);%>'
var DisableACSApply = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_DISABLEACSAPPLY);%>'
var UnchangeTimePeriod = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGETIME);%>'

var stCWMPs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.ManagementServer,EnableCWMP|PeriodicInformEnable|PeriodicInformInterval|PeriodicInformTime|URL|Username|ConnectionRequestUsername|X_HW_EnableCertificate|X_HW_DSCP|X_HW_CheckPasswordComplex|STUNEnable|STUNMinimumKeepAlivePeriod|STUNMaximumKeepAlivePeriod|STUNServerAddress|STUNServerPort|STUNUsername|STUNPassword|EnableGWNat|ConnectionRequestURL,stCWMP);%>;
var cwmp = stCWMPs[0];
var MngtMgts = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_MGTS);%>';
var AcsConfigFormList = new Array();
var SSLAcsConfigFormList = new Array();
var STUNConfigFormList = new Array();
var PortMappingFormList = new Array();
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';

function DisableTR069Page()
{
    setDisable('EnableCWMP',1);
    setDisable('PeriodicInformEnable',1);
    setDisable('PeriodicInformInterval',1);
    setDisable('PeriodicInformTime',1);
    setDisable('URL',1);
    setDisable('Username',1);
    setDisable('Password',1);
    setDisable('ConnectionRequestUsername',1);
    setDisable('ConnectionRequestPassword',1);
    setDisable('X_HW_DSCP',1);
    setDisable('ACSbtnApply',1);
    setDisable('ACScancelValue',1);
    setDisable('CertificateEnable',1);
    setDisable('X_HW_CertPassword',1);
    setDisable('CfmPassword',1);
    setDisable('PWDbtnApply',1);
    setDisable('PWDcancelValue',1);
    setDisable('f_file',1);
    setDisable('t_file',1);
    setDisable('btnBrowse', 1);
    setDisable('ImportCertification',1);
    document.getElementById("f_file").style.backgroundColor="rgb(235,235,228)";
    
    setDisable('STUNEnable',1);
    setDisable('STUNMinimumKeepAlivePeriod',1);
    setDisable('STUNMaximumKeepAlivePeriod',1);
    setDisable('STUNServerAddress',1);
    setDisable('STUNServerPort',1);
    setDisable('STUNUsername',1);
    setDisable('STUNPassword1',1);
    setDisable('StunbtnApply',1);
    setDisable('StuncancelValue',1);

    setDisable('EnableGWNat',1);
    setDisable('btnApply',1);
    setDisable('cancelValue',1);
}

function maxisDisplayStun() 
{
    if (CfgMode.toUpperCase() != "DETHMAXIS") {
        return;
    }

    if (apstunfeature != 1) {
        return;
    }

    document.getElementById("stunap").style.display = "block";
    document.getElementById("STUNConfigForm").style.display = "block";
        
    $("#checkinfo1Row").css("display", "none");
    var pwdcheck1 = document.getElementById('checkinfo1');    
    pwdcheck1.innerHTML ='<div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;">'
                             + '<div class="left" style="float:left; width: 126px;">'
                                  + '<span style="text-align:center;padding:0px 15px; display:block;line-height:40px;" class="language-string" id="pwdvalue1" BindText="s1448">'
                                  + '</span>'
                             + '</div>' 
                        + '</div>';
}

function LoadFrame()
{
	if(false == IsForceCheckConnectInfo())
	{
		document.getElementById("ConnectionRequestUsernameRequire").style.display="none";
		document.getElementById("ConnectionRequestPasswordRequire").style.display="none";
	}

    if("undefined" != typeof(CusLoadFrame))
    {
        CusLoadFrame();
    }

    if( ( window.location.href.indexOf("complex.cgi?") > 0) )
    {
        AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d14"));
    }

    if (CfgMode.toUpperCase() == "NETLIFE2") {
        setDisable('EnableCWMP', 1);
        setDisable('PeriodicInformEnable', 1);
    }
    
    if (1 == UnChangeURL)
    {
        setDisable('URL',1);
    }
    if (1 == UnChangeUser)
    {
        setDisable('Username',1);
        setDisable('Password',1);
        setDisable('ConnectionRequestUsername',1);
        setDisable('ConnectionRequestPassword',1);
    }
    if (1 == UnChangePeriod)
    {
        setDisable('PeriodicInformEnable',1);
        setDisable('PeriodicInformInterval',1);
    }
    if (1 == DisableACSApply)
    {
        setDisable('EnableCWMP',1);
        setDisable('X_HW_DSCP',1);
        setDisable('ACSbtnApply',1);
        setDisable('ACScancelValue',1);
    }
    if (1 == UnchangeTimePeriod)
    {
        setDisable('PeriodicInformTime',1);
    }
    
    if (ProductType != '2')
    {
        if (CfgMode.toUpperCase() != "DESKAPFPT") {
            $("#checkinfo1Row").css("display", "none");
        }
        if(apstunfeature == 1)
        {
            if((curChangeMode == 1)||(curChangeMode == 2) || (curChangeMode == 3)||(GhnDevFlag == 1))
            {
                document.getElementById("stunap").style.display = "block";
                document.getElementById("STUNConfigForm").style.display = "block";

                if (CfgMode.toUpperCase() != "DESKAPFPT") {
                    $("#checkinfo1Row").css("display", "none");
                }

                var pwdcheck1 = document.getElementById('checkinfo1');    
                pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="float:left; width: 126px;"><span style="text-align:center;padding:0px 15px; display:block;line-height:40px;" class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
            }
        }
    }

    if ((CfgModeWord.toUpperCase() == 'MALAYTIMEAP') || (CfgModeWord.toUpperCase() == 'MALAYTIMEAP6')) {
        setDisable('STUNEnable', 1);
        setDisable('STUNMinimumKeepAlivePeriod', 1);
        setDisable('STUNMaximumKeepAlivePeriod', 1);
        setDisable('STUNServerAddress', 1);
        setDisable('STUNServerPort', 1);
        setDisable('STUNUsername', 1);
        setDisable('STUNPassword1', 1);
        setDisable('StunbtnApply', 1);
        setDisable('StuncancelValue', 1);
        setDisable('CertificateEnable', 1);
        setDisable('X_HW_CertPassword', 1);
        setDisable('CfmPassword', 1);
        setDisable('PWDbtnApply', 1);
        setDisable('PWDcancelValue', 1);
        setDisable('btnBrowse', 1);
        setDisable('t_file', 1);
        setDisable('ImportCertification', 1);
    }

    if (CfgModeWord.toUpperCase() == 'ROSUNION') {
        setDisplay("sslcfgtitle", 0);
        setDisplay("TR069SSLCfg", 0);
        setDisplay("certtitle", 0);
        setDisplay("fr_uploadImage", 0);
    }

    if ((CfgMode.toUpperCase() == "DESKAPFPT") || (CfgMode.toUpperCase() == "LINKNET2") ||
        (CfgMode.toUpperCase() == "DESKAPINDTKM")) {
        DisableTR069Page();
    }

    if (mongoFlag == 1) {
        setDisable("URL",1);
    }

    if (apportmapping == '1') {
        document.getElementById("AutoPortMapping").style.display = "block";
        document.getElementById("PortMappingCfg").style.display = "block";
    }

    if (apShowConfig == '1') {

        if (["CHILEENTELAP","PONAP","IDXLAP6"].indexOf(CfgMode.toUpperCase()) >= 0) {
            setDisable('EnableCWMP',1);
            setDisable('PeriodicInformEnable',1);
            setDisable('PeriodicInformInterval',1);
            setDisable('PeriodicInformTime',1);
            setDisable('URL',1);
            setDisable('Username',1);
            setDisable('Password',1);
            setDisable('ConnectionRequestUsername',1);
            setDisable('ConnectionRequestPassword',1);
            setDisable('X_HW_DSCP',1);
            setDisable('ACSbtnApply',1);
            setDisable('ACScancelValue',1);
            setDisable('EnableGWNat',1);
            setDisable('btnApply',1);
            setDisable('cancelValue',1);
        }

        setDisable("STUNEnable", 1);
        setDisable("STUNMinimumKeepAlivePeriod", 1);
        setDisable("STUNMaximumKeepAlivePeriod", 1);
        setDisable("STUNServerAddress", 1);
        setDisable("STUNServerPort", 1);
        setDisable("STUNUsername", 1);
        setDisable("STUNPassword1", 1);
        setDisable("StunbtnApply", 1);
        setDisable("StuncancelValue", 1);
        setDisable("CertificateEnable", 1);
        setDisable("X_HW_CertPassword", 1);
        setDisable("CfmPassword", 1);
        setDisable("PWDbtnApply", 1);
        setDisable("PWDcancelValue", 1);
        setDisable("btnBrowse", 1);
        setDisable("t_file", 1);
        setDisable("ImportCertification", 1);
        document.getElementById("f_file").style.backgroundColor="rgb(235,235,228)";
    }

    maxisDisplayStun();
    maxisLocalUserAshesTR069();
}

function IsDigitStr(str)
{
    var i = 0;
    if (0 == str.length)
    {
        return false;
    }
    for (i = 0; i < str.length; i++)
    {
        if (str[i] >= '0' && str[i] <= '9')
        {
            continue;
        }
        else
        {
            return false;
        }
    }

    return true;
}

function PreprocforTime(str_date)
{
    var date_time_tmp = "";
    var time_zone = '';
    var dotindex = str_date.lastIndexOf('.');
    var commaindex = str_date.lastIndexOf(',');

    if ((-1 == dotindex && -1 == commaindex) || (-1 != dotindex && -1 != commaindex))
    {
        return str_date;
    }

    if (-1 != dotindex)
    {
        date_time_tmp = str_date.split(".");
    }
    else
    {
        date_time_tmp = str_date.split(",");
    }

    if (2 != date_time_tmp.length)
    {
        return str_date;
    }
    
    if (-1 != str_date.indexOf("0001-01-01T00:00:00")
        || -1 != str_date.indexOf("0001-01-01T00:00:00Z"))
    {
        return str_date;
    }

    var index = date_time_tmp[1].lastIndexOf('Z');
    if (-1 == index)
    {
        index = date_time_tmp[1].lastIndexOf('+');
        if (-1 == index)
        {
            index = date_time_tmp[1].lastIndexOf('-');
        }
    }

    if (-1 == index)
    {
        if (date_time_tmp[1].length > 5 || false == IsDigitStr(date_time_tmp[1]))
        {
            return str_date;
        }
    }
    else
    {
        var time_ms = date_time_tmp[1].substring(0, index);
        if (time_ms.length > 5 || false == IsDigitStr(time_ms))
        {
            return str_date;
        }
        else
        {
            time_zone = date_time_tmp[1].substr(index);
        }
    }
    return date_time_tmp[0] + time_zone;
}

function CheckTime(str_date)
{
    var date_reg = new RegExp("^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$");

    var time_reg = new RegExp("^((0[0-9])|(1[0-9])|(2[0-3])):([0-5][0-9]):([0-5][0-9])(Z?|(([+-](0[0-9]|1[0-2]):00)|([+]13:00))?)$");
    
    var date_reg2 = new RegExp("^(?:(?!0000)[0-9]{4}(?:(?:0[1-9]|1[0-2])(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])(?:29|30)|(?:0[13578]|1[02])31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)0229)$");
    var time_reg2 = new RegExp("^((0[0-9])|(1[0-9])|(2[0-3]))([0-5][0-9])([0-5][0-9])((([+-](0[0-9]|1[0-2])(00)?)|([+]13(00)?))?)$");

    var str_date_tmp = PreprocforTime(str_date);
    date_time = str_date_tmp.split("T");

    if (date_time.length != 2)
    {
        return false;
    }

    date_time_type = false;
    date_time_type2 = false;

    if ((date_reg.test(date_time[0])) && (time_reg.test(date_time[1])))
    {
        date_time_type = true;
    }

    if ((date_reg2.test(date_time[0])) && (time_reg2.test(date_time[1])))
    {
        date_time_type2 = true;
    }

    if ((date_time_type == false) && (date_time_type2 == false))
    {
        return false;
    }


    return true;
}

function checkUrlPort(urlinfo)
{
    var url_values = urlinfo.split("://");

    if (url_values.length <= 1)
    {
        var port_value = urlinfo.split(":");

        if (port_value.length <= 1)
        {
            return true;
        }
        else
        {
            var othervalue = port_value[port_value.length-1].split("/");

            if (othervalue.length == 0)
            {
                return true;
            }

            if(true == isNull(othervalue[0]))
            {
                return false;
            }

            if(false == isNum(othervalue[0]))
            {
                return false;
            }

            var port = parseInt(othervalue[0], 10);
            if ((port >= 65536) || ( port < 1))
            {
                return false;
            }
            return true;
        }
    }
    else
    {
        var port_value = url_values[url_values.length-1].split(":");
        if (port_value.length <= 1)
        {
            return true;
        }

        var othervalue = port_value[port_value.length-1].split("/");
        if (othervalue.length == 0)
        {
            return true;
        }

        if(true == isNull(othervalue[0]))
        {
            return false;
        }

        if(false == isNum(othervalue[0]))
        {
            return false;
        }

        var port = parseInt(othervalue[0], 10);
        if ((port >= 65536) || ( port < 1))
        {
            return false;
        }
    }

    return true;
}

function isSafeCharSN(val)
{
    if ( ( val == '<' )
      || ( val == '>' )
      || ( val == '\'' )
      || ( val == '\"' )
      || ( val == ' ' )
      || ( val == '%' )
      || ( val == '#' )
      || ( val == '{' )
      || ( val == '}' )
      || ( val == '\\' )
      || ( val == '|' )
      || ( val == '^' )
      || ( ( val == '[' ) && (0 == UnSupportIpv6) )
      || ( ( val == ']' ) && (0 == UnSupportIpv6) ) )
	{
	    return false;
	}
	
    return true;
}

function isSafeStringSN(val)
{
	if ( val == "" )
	{
		return false;
	}

	for ( var j = 0 ; j < val.length ; j++ )
	{
		if ( !isSafeCharSN(val.charAt(j)) )
		{
			return false;
		}
	}

	return true;
}


function CheckForm(type)
{
    with(document.getElementById("AcsConfigForm"))
    {
        if (URL.value == '')
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d01"));
            URL.focus();
            return false;
        }
		
        if (!isSafeStringSN(URL.value))
        {
			if (0 == UnSupportIpv6)
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d02"));
            }
            else
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d02Ex"));
            }
            
            URL.focus();
            return false;
        }

        if (!checkUrlPort(URL.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d2d"));
            URL.focus();
            return false;
        }

        if ('' != isValidAscii(URL.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d2e"));
            URL.focus();
            return false;
        }

        if (getCheckVal("PeriodicInformEnable") == 1)
        {
            if ((PeriodicInformInterval.value == '') || (isPlusInteger(PeriodicInformInterval.value) == false))
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d03"));
                PeriodicInformInterval.focus();
                return false;
            }

            var info = parseInt(PeriodicInformInterval.value,10);
            if (info < 1 || info > 2147483647)
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d03"));
                PeriodicInformInterval.focus();
                return false;
            }

            if (getValue('PeriodicInformTime') != '' && CheckTime(getValue('PeriodicInformTime')) == false)
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d04"));
                return false;
            }
        }

        if (isValidString(Username.value) == false )
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d06"));
            Username.focus();
            return false;
        }

        if ('' != isValidAscii(Password.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d08"));
            Password.focus();
            return false;
        }

        if (MngtMgts == 0)
        {
			if(true == IsForceCheckConnectInfo()){
				if (isValidString(ConnectionRequestUsername.value) == false )
				{
					AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d0a"));
					ConnectionRequestUsername.focus();
					return false;
				}

				if ('' != isValidAscii(ConnectionRequestPassword.value))
				{
					AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d0c"));
					ConnectionRequestPassword.focus();
					return false;
				}
            }
        }

        var info = parseInt(X_HW_DSCP.value,10);
        
        if (ProductType != '2')
        {
            if (info < 0 || info > 63)
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d0d"));
                X_HW_DSCP.focus();
                return false;
            }
        }
        
        if(X_HW_DSCP.value == "0")
        {
        }
        else
        {
            var r = new RegExp("^[1-9]{1}\\d*$");
            if(r.test(X_HW_DSCP.value) && (info >= 0  && info <= 63))
            {
            }
            else
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d0d"));
                X_HW_DSCP.focus();
                return false;
            }
        }
    }
    return true;
}

function CheckStunPort(port)
{
    if(true == isNull(port))
    {
        return false;
    }

    if(false == isNum(port))
    {
        return false;
    }

    if ((port >= 65536) || ( port < 1))
    {
        return false;
    }
    
    return true;
}

function StunCheckForm(type)
{
    with(document.getElementById("STUNConfigForm"))
    {
        if ((STUNMinimumKeepAlivePeriod.value == '') || (isPlusInteger(STUNMinimumKeepAlivePeriod.value) == false))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d62"));
            STUNMinimumKeepAlivePeriod.focus();
            return false;
        }
        var info1 = parseInt(STUNMinimumKeepAlivePeriod.value,10);
        var info2 = parseInt(STUNMaximumKeepAlivePeriod.value,10);

        if ((info2 < '-1' || info2 > '160'))
        {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d64"));
                STUNMaximumKeepAlivePeriod.focus();
                return false;
        }

        if ((STUNMaximumKeepAlivePeriod.value == ''))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d63"));
            STUNMaximumKeepAlivePeriod.focus();
            return false;
        }

        if (info2 >= 0)
        {
            if(info1 > info2)
            {
                AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d54"));
                STUNMaximumKeepAlivePeriod.focus();
                return false;
            }
        }
        
        if (STUNServerAddress.value == '')
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d49"));
            STUNServerAddress.focus();
            return false;
        }

        if (!isSafeStringSN(STUNServerAddress.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d60"));
            STUNServerAddress.focus();
            return false;
        }

        if ('' != isValidAscii(STUNServerAddress.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d61"));
            STUNServerAddress.focus();
            return false;
        }
        
        if (!CheckStunPort(STUNServerPort.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d59"));
            STUNServerPort.focus();
            return false;
        }

        if (STUNUsername.value == '')
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d55"));
            STUNUsername.focus();
            return false;
        }
        if (isValidString(STUNUsername.value) == false )
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d56"));
            STUNUsername.focus();
            return false;
        }

        if (STUNPassword1.value == '')
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d52"));
            STUNPassword1.focus();
            return false;
        }
        if ('' != isValidAscii(STUNPassword1.value))
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d58"));
            STUNPassword1.focus();
            return false;
        }
    }
    return true;
}

function VerifyFile(FileName)
{
    var File = document.getElementsByName(FileName)[0].value;
    if (File.length == 0)
    {
        AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d10"));
        return false;
    }
    if (File.length > 128)
    {
        AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d11"));
        return false;
    }

    return true;
}

function uploadCert()
{
    if ((CfgModeWord.toUpperCase() == 'MALAYTIMEAP') || (CfgModeWord.toUpperCase() == 'MALAYTIMEAP6') || (apShowConfig == '1')) {
        return;
    }
    var uploadForm = document.getElementById("fr_uploadImage");
    if (VerifyFile('browse') == false)
    {
       return;
    }
    top.previousPage = '/html/ssmp/reset/reset.asp';
    setDisable('btnSubmit',1);
    uploadForm.submit();
    setDisable('browse',1);
    setDisable('btnBrowse',1);
}

function CheckPwdIsComplexWithSpace(str) {
    var i = 0;
    if (str.length < PwdMinLen) {
        return false;
    }

    if (!CompareString(str, sptUserName)) {
        return false;
    }

    if (isLowercaseInString(str)) {
        i++;
    }

    if (isUppercaseInString(str)) {
        i++;
    }

    if (isDigitInString(str)) {
        i++;
    }

    if (isSpecialCharacterInString(str)) {
        i++;
    }
    if (i >= 2) {
        return true;
    }
    return false;
}

function CheckFormPassword(type)
{
    with(document.getElementById("TR069SSLCfg"))
    {
        if(X_HW_CertPassword.value.length > 32)
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d0e"));
            setText('X_HW_CertPassword', '');
            setText("CfmPassword", "");
            return false;
        }

        if (X_HW_CertPassword.value == '')
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s1430"));
            return false;
        }

        if(X_HW_CertPassword.value != CfmPassword.value)
        {
            AlertEx(GetDescFormArrayById(Tr069LgeDes, "s0d0f"));
            setText("X_HW_CertPassword", "");
            setText("CfmPassword", "");
            return false;
        }

        if(CheckPwdIsComplexWithSpace(X_HW_CertPassword.value) == false) {
            AlertEx(GetLanguageDesc("s1902"));
            return false;
        }
    }
    return true;
}

function AddSubmitImportcert()
{
    if (CheckFormPassword() == false)
    {
        return ;
    }

    if (apShowConfig == '1') {
        return;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_CertPassword',getValue('X_HW_CertPassword'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('complex.cgi?x=InternetGatewayDevice.ManagementServer'
                         + '&RequestFile=' + reqFile);
    setDisable('PWDbtnApply',1);
    setDisable('PWDcancelValue',1);
    Form.submit();

}

function SetCertificateInfo()
{
    var Form = new webSubmitForm();
    var Value = getCheckVal('CertificateEnable');
    Form.addParameter('x.X_HW_EnableCertificate', Value);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.ManagementServer&RequestFile=' + reqFile);
    Form.submit();
}

function SubmitEnableGWNat()
{
    if (ConfirmEx(GetDescFormArrayById(Tr069LgeDes, "s0e08"))) {
        var Form = new webSubmitForm();
        var Value = getCheckVal('EnableGWNat');
        Form.addParameter('x.EnableGWNat', Value);
        Form.setAction('set.cgi?x=InternetGatewayDevice.ManagementServer&y=InternetGatewayDevice.X_HW_DEBUG.SSP.DBSave&z=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard&RequestFile=' + reqFile);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}
function CancelConfig()
{
    InitEnableGWNatBox();
}

function CancelConfigPwd()
{
    if ( null != cwmp )
    {
        setCheck('CertificateEnable', cwmp.X_HW_EnableCertificate);
    }

    setText("X_HW_CertPassword", "");
    setText("CfmPassword", "");
}

function StartFileOpt()
{
    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
}

function EnableAcsInformFunc()
{
    var itemPeriodicInformEnable = document.getElementById("PeriodicInformEnable");
    var itemPeriodicInformInterval = document.getElementById("PeriodicInformInterval");
    var itemPeriodicInformTime = document.getElementById("PeriodicInformTime");
    if (true == itemPeriodicInformEnable.checked) {
        itemPeriodicInformInterval.disabled = false;
        itemPeriodicInformTime.disabled = false;
    } else {
        itemPeriodicInformInterval.disabled = true;
        itemPeriodicInformTime.disabled = true;
    }
}
function EnableStunInformFunc()
{
    var apStunEnable = document.getElementById("STUNEnable");
    var apSTUNMinimumKeepAlivePeriod = document.getElementById("STUNMinimumKeepAlivePeriod");
    var apSTUNMaximumKeepAlivePeriod = document.getElementById("STUNMaximumKeepAlivePeriod");
    //var apSTUNServerAddress = document.getElementById("STUNServerAddress");
    //var apSTUNServerPort = document.getElementById("STUNServerPort");
    //var apSTUNUsername = document.getElementById("STUNUsername");
    //var apSTUNPassword1 = document.getElementById("STUNPassword1");
    //var apStunbtnApply = document.getElementById("StunbtnApply");
    //var apStuncancelValue = document.getElementById("StuncancelValue");
    if (true == apStunEnable.checked) {
        //apSTUNMinimumKeepAlivePeriod.disabled = false;
        //apSTUNMaximumKeepAlivePeriod.disabled = false;
        
    } else {
        //apSTUNMinimumKeepAlivePeriod.disabled = true;
        //apSTUNMaximumKeepAlivePeriod.disabled = true;

    }
}

function SubmitAcsConfig()
{
    if(false == CheckForm())
    {
        return;
    }

    var BaseData = HWcloneObject(cwmp, 1);
    var Parameter = {};
    if (mongoFlag == 1) {
        urlIndex = AcsConfigFormList.indexOf("URL");
        AcsConfigFormList.splice(urlIndex, 1);
    }

    Parameter.OldValueList = BaseData;

    if (CfgMode.toUpperCase() == "NETLIFE2") {
        Parameter.FormLiList = new Array();
        for (var i = 0; i < AcsConfigFormList.length; i++) {
            var temp = AcsConfigFormList[i];
            if (["EnableCWMP", "PeriodicInformEnable", "URL"].indexOf(temp) >= 0) {
                continue;
            }
            Parameter.FormLiList.push(temp);
        }

        delete BaseData["EnableCWMP"];
        delete BaseData["PeriodicInformEnable"];
        delete BaseData["URL"];
    } else {
        Parameter.FormLiList = AcsConfigFormList;
        BaseData["URL"] = "";
    }

    Parameter.SpecParaPair = null;
    var ConfigUrl = 'set.cgi?x=InternetGatewayDevice.ManagementServer&RequestFile=' + reqFile;
    var tokenvalue = getValue('onttoken');
    Parameter.asynflag = null;
    var result = HWSetAction(null, ConfigUrl, Parameter, tokenvalue);
    if(result)
    {
        setDisable('ACSbtnApply',1);
        setDisable('ACScancelValue',1);
    }
}

function SubmitStunConfig()
{
    if (apShowConfig == '1') {
        return;
    }

    if(false == StunCheckForm())
    {
        return;
    }

    var BaseData = HWcloneObject(cwmp, 1);
    var Parameter = {};
    Parameter.FormLiList = STUNConfigFormList;
    Parameter.OldValueList = BaseData;
    BaseData["URL"] = "";
    Parameter.SpecParaPair = null;
    var ConfigUrl = 'set.cgi?x=InternetGatewayDevice.ManagementServer&RequestFile=' + reqFile;
    var tokenvalue = getValue('onttoken');
    Parameter.asynflag = null;
    var result = HWSetAction(null, ConfigUrl, Parameter, tokenvalue);
    if(result)
    {
        setDisable('StunbtnApply',1);
        setDisable('StuncancelValue',1);
    }
}
function InitAcsTableList()
{
    var FillData = HWcloneObject(cwmp, 1);
	
	// 厄瓜多尔定制 informing Time 默认值显示为空
	if (('NETLIFE' == CfgMode.toUpperCase() || 'NETLIFE2' == CfgMode.toUpperCase()) && FillData.PeriodicInformTime == '0001-01-01T00:00:00Z') {
	   FillData.PeriodicInformTime = '';
	}
	
    HWSetTableByLiIdList(AcsConfigFormList, FillData, EnableAcsInformFunc);
}

function InitStunTableList()
{
    var FillData = HWcloneObject(cwmp, 1);
    HWSetTableByLiIdList(STUNConfigFormList, FillData, EnableStunInformFunc);
    if (CfgMode.toUpperCase() != "DESKAPFPT") {
        document.getElementById("checkinfo1Row").style.display ='none';
    }
}

function InitSslAcsCfgBox()
{
    setCheck('CertificateEnable', cwmp.X_HW_EnableCertificate);
}

function getUrlPort(urlinfo)
{
    if (urlinfo == "") {
        return "--";
    }

    var url_values = urlinfo.split("://");
    var port_value = url_values[url_values.length-1].split(":");
    if (port_value.length <= 1) {
        return "--";
    }

    var port = port_value[port_value.length-1].split("/");
    if (port.length == 0) {
        return "--";
    }

    if (port[0] == "0") {
        return "--";
    }
    return port[0];
}

function InitEnableGWNatBox()
{
    setCheck('EnableGWNat', cwmp.EnableGWNat);
    if (cwmp.EnableGWNat == "1") {
        document.getElementById('ExternalPort').innerHTML = getUrlPort(cwmp.ConnectionRequestURL);
    } else {
        document.getElementById('ExternalPort').innerHTML = "--";
    }
}

function fchange() {
    if ((CfgModeWord.toUpperCase() == 'MALAYTIMEAP') || (CfgModeWord.toUpperCase() == 'MALAYTIMEAP6')) {
        return;
    }
    var ffile = document.getElementById("f_file");
    var tfile = document.getElementById("t_file");
    ffile.value = tfile.value;

    var buttonstart = document.getElementById('ImportCertification');
    buttonstart.focus();
}
function psdStrength()
{
    var score = 0;
    var password1 = getElementById("STUNPassword1").value;
    if(password1.length > 8) score++;

    if(password1.match(/[a-z]/) && password1.match(/[A-Z]/)) score++;

    if(password1.match(/\d/)) score++;

    if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;

    if (password1.length > 12) score++;


    if(0 == score)
    {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1448');
        getElementById("pwdvalue1").style.width=16.6+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FF0000";
    }

    if(1 == score)
    {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1448');
        getElementById("pwdvalue1").style.width=33.2+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FF0000";
    }
    if(2 == score)
    {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1449');
        getElementById("pwdvalue1").style.width=49.8+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FFA500";
    }
    if(3 == score)
    {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1449');
        getElementById("pwdvalue1").style.width=66.4+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FFA500";
    }
    if(4 == score)
    {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1450');
        getElementById("pwdvalue1").style.width=83+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #008000";
    }
    if(5 == score)
    {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1450');
        getElementById("pwdvalue1").style.width=100+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #008000";
    }
}

function cert_key_password_show(input) {
    var div = document.getElementById("cert_key_password_show");

    if ("ARABIC" == LoginRequestLanguage.toUpperCase()) {
        div.style.right = (input.offsetLeft+50)+"px";
    } else {
        div.style.left = (input.offsetLeft+375)+"px";
    }

    if (isSpecialFlag == "1") {
        div.innerHTML = WebcertmgntLgeDes['s1116sonet'];
    } else if (ispwdLength == "1") {
        div.innerHTML = WebcertmgntLgeDes['ss1116d']; 
    }else {
        div.innerHTML = WebcertmgntLgeDes['s1116'];
    }

    var webCertTips = (pwdComplexFt == 1) ? 's1116_sec' : 's1116';
    div.innerHTML = WebcertmgntLgeDes[webCertTips];
    div.style.display = '';
    if ('ZAIN' == CfgMode.toUpperCase()) {
        div.style.color = '#000000';
    }
    if (CfgModeWord.toUpperCase() == "ROSUNION") {
        div.style.background = 'rgb(39, 58, 100)';
        div.style.color = '#fff';
        div.style.border = 'none';
        div.style.padding = '5px';
    }
}

function cert_key_password_back(input){
    var div=document.getElementById("cert_key_password_show");
    div.style.display = "none";
}

function CheckNoticeForSSL() {
    var password1 = getElementById("X_HW_CertPassword").value;

    if(password1.length == 0){
        return;
    }

    if(CheckPwdIsComplexWithSpace(password1) == false)
    {
        AlertEx(GetLanguageDesc("s1902"));
        return false;
    }

    return true;
}

if (Ftmodifyowner == 1) {
    for (var i = 0; i < stModifyUserInfos.length - 1; i++) {
        if (stModifyUserInfos[i].UserLevel == 0) {
            sptAdminName = stModifyUserInfos[i].UserName;
            sptUserName = stModifyUserInfos[i].UserName;
            adminUsrName = stModifyUserInfos[i].UserName;
            ShowOldPwd = 1;			
            UserNum = 1; 
            CurUserInst[0]= i;
            pwdModifyFlag = stModifyUserInfos[i].modifyFlag;
            break;
        }
    }
}

function GetLanguageDesc(Name)
{
    return Tr069LgeDes[Name];
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
    <script language="JavaScript" type="text/javascript">
    if (apportmapping == '1') {
        HWCreatePageHeadInfo("TR069", GetDescFormArrayById(Tr069LgeDes, "s0101"), GetDescFormArrayById(Tr069LgeDes, "s0100_ap"), false);
    } else {
        HWCreatePageHeadInfo("TR069", GetDescFormArrayById(Tr069LgeDes, "s0101"), GetDescFormArrayById(Tr069LgeDes, "s0100"), false);
    }
    </script>
    <div class="title_spread"></div>
    <div class="func_title" BindText="s0d15"></div>
    <form id="AcsConfigForm"  name="AcsConfigForm">
        <table id="AcsConfigFormPanel" width="100%" cellspacing="1" cellpadding="0">
            <script>
                if (ProductType != '2')
                {             
                    document.write('<li id="EnableCWMP"      RealType="CheckBox"   DescRef="s0d36" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.EnableCWMP" InitValue="Empty" />');
                }
                else
                {
                    document.write('<li id="EnableCWMP"      RealType="CheckBox"   DescRef="s1703" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.EnableCWMP" InitValue="Empty" />');
                }            
            </script>
            <li id="PeriodicInformEnable"      RealType="CheckBox"   DescRef="s0d17" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.PeriodicInformEnable"
                InitValue="Empty" ClickFuncApp="onClick=EnableAcsInformFunc"/>
            <li id="PeriodicInformInterval"    RealType="TextBox"    DescRef="s0d18" RemarkRef="s0d34" ErrorMsgRef="Empty" Require="TRUE"  BindField="x.PeriodicInformInterval"    InitValue="Empty"/>
            <li id="PeriodicInformTime"        RealType="TextBox"    DescRef="s0d19" RemarkRef="s0d1a" ErrorMsgRef="Empty" Require="FALSE" BindField="x.PeriodicInformTime"        InitValue="Empty"/>
            <li id="URL"                       RealType="TextDivbox" DescRef="s0d2f" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE"  BindField="x.URL"
                InitValue="[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:280px; border:solid 1px #999999; background:#edeef0;'}]}]"/>
            <li id="Username"                  RealType="TextBox"    DescRef="s0d1b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="x.Username"                  InitValue="Empty"/>
            <script>
                document.write('<li id="Password"  RealType="TextBox"    DescRef="s0d1c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="x.Password" InitValue="Empty"');

                document.write(" />");
            </script>            
            <li id="ConnectionRequestUsername" RealType="TextBox"    DescRef="s0d1e" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="x.ConnectionRequestUsername" InitValue="Empty"/>
            <script>
                document.write('<li id="ConnectionRequestPassword" RealType="TextBox"    DescRef="s0d1f" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="x.ConnectionRequestPassword" InitValue="Empty"')

                document.write(" />");
            </script>
            <li id="X_HW_DSCP"                 RealType="TextBox"    DescRef="s0d30" RemarkRef="s0d35" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_DSCP"                 InitValue="Empty"/>
        </table>
        <script>
            AcsConfigFormList = HWGetLiIdListByForm("AcsConfigForm", null);
            var TableClass = new stTableClass("width_per30", "width_per70", "");
            var ReloadCusInfo=null;
            if("undefined" != typeof(AcsReload))
            {
                ReloadCusInfo = AcsReload;
            }
            HWParsePageControlByID("AcsConfigForm", TableClass, Tr069LgeDes, ReloadCusInfo);
            InitAcsTableList();
			if(false == IsForceCheckConnectInfo())
			{
				document.getElementById("ConnectionRequestUsernameRequire").style.display="none";
				document.getElementById("ConnectionRequestPasswordRequire").style.display="none";
			}
        </script>
        <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
            <tr>
                <td class="width_per30"></td>
                <td class="table_submit">
                    <input type="button" id="ACSbtnApply"    value="" BindText="s0d21" class="ApplyButtoncss  buttonwidth_100px" onclick="SubmitAcsConfig();" />
                    <input type="button" id="ACScancelValue" value="" BindText="s0d22" class="CancleButtonCss buttonwidth_100px" onclick="InitAcsTableList();" />
                </td>
            </tr>
        </table>
    </form>

    <div class="func_spread"></div>
    <div class="func_title" BindText="s0e05" id="AutoPortMapping" style="display:none;"></div>
    <form id="PortMappingCfg" style="display:none;">
        <table id="GWNatFormPanel" width="100%" cellspacing="1" cellpadding="0">
            <li id="EnableGWNat" RealType="CheckBox" DescRef="s0e06" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.EnableGWNat"  InitValue="Empty"/>
            <li id="ExternalPort" RealType="HtmlText"  DescRef="s0e07" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty"/>
        </table>
        <script>
            PortMappingFormList = HWGetLiIdListByForm("PortMappingCfg", null);
            var TableClass = new stTableClass("width_per30", "width_per70", "");
            HWParsePageControlByID("PortMappingCfg", TableClass, Tr069LgeDes, null);
            InitEnableGWNatBox();
        </script>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
            <tr>
                <td class="width_per30"></td>
                <td class="table_submit">
                    <input type="button" id="btnApply" class="ApplyButtoncss  buttonwidth_100px" BindText="s0d21" onClick="SubmitEnableGWNat();">
                    <input type="button" id="cancelValue" class="CancleButtonCss buttonwidth_100px" BindText="s0d22" onClick="CancelConfig();">
                </td>
            </tr>
        </table>
    </form>

    <!--STUN -->
    <div class="func_spread"></div>
    <div class="func_title" BindText="s0d37" id="stunap" style="display:none;"></div>
    <form id="STUNConfigForm"  name="STUNConfigForm" style="display:none;">
        <table id="STUNConfigFormPanel" width="100%" cellspacing="1" cellpadding="0">
            <li id="STUNEnable" RealType="CheckBox" DescRef="s0d38" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.STUNEnable" InitValue="Empty" ClickFuncApp="onClick=EnableStunInformFunc" />
            <li id="STUNMinimumKeepAlivePeriod" RealType="TextBox" DescRef="s0d39" RemarkRef="s0d47" ErrorMsgRef="Empty" Require="TRUE" BindField="x.STUNMinimumKeepAlivePeriod" InitValue="Empty" />
            <li id="STUNMaximumKeepAlivePeriod" RealType="TextBox" DescRef="s0d40" RemarkRef="s0d47" ErrorMsgRef="Empty" Require="TRUE" BindField="x.STUNMaximumKeepAlivePeriod" InitValue="Empty" />
            <li id="STUNServerAddress" RealType="TextBox" DescRef="s0d41" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.STUNServerAddress" InitValue="Empty" />
            <li id="STUNServerPort" RealType="TextBox" DescRef="s0d42" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.STUNServerPort" InitValue="Empty" />
            <li id="STUNUsername" RealType="TextBox" DescRef="s0d43" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.STUNUsername" InitValue="Empty" />
            <li id="STUNPassword1" RealType="TextBox" DescRef="s0d44" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.STUNPassword" InitValue="Empty" onKeyUp="psdStrength()" />
            <li id="checkinfo1" RealType="HtmlText"  DescRef="s0d48" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" />
        </table>
        <script>
            STUNConfigFormList = HWGetLiIdListByForm("STUNConfigForm", null);
            var TableClass = new stTableClass("width_per30", "width_per70", "");
            HWParsePageControlByID("STUNConfigForm", TableClass, Tr069LgeDes, AcsReload);
            InitStunTableList();

            if (CfgMode.toUpperCase() != "DESKAPFPT") {
                $('#STUNPassword1').bind('keyup',function(){
                    if (apstunfeature == 1) {
                        if((curChangeMode == 1)||(curChangeMode == 2) || (curChangeMode == 3)||(GhnDevFlag == 1)) {
                            $("#checkinfo1Row").css("display", "");
                            $("#psd_checkpwd").css("display", "block");
                            psdStrength();
                        }
                    }
                });
            }
        </script>
        <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
            <tr>
                <td class="width_per30"></td>
                <td class="table_submit">
                    <input type="button" id="StunbtnApply"    value="" BindText="s0d21" class="ApplyButtoncss  buttonwidth_100px" onclick="SubmitStunConfig();" />
                    <input type="button" id="StuncancelValue" value="" BindText="s0d22" class="CancleButtonCss buttonwidth_100px" onclick="InitStunTableList();" />
                </td>
            </tr>
        </table>
    </form>
    <!--STUN-->
    
    <div class="func_spread"></div>
    <div class="func_title" id="sslcfgtitle" BindText="s0d23"></div>
    <form id="TR069SSLCfg">
        <table id="SslAcsConfigFormPanel" width="100%" cellspacing="1" cellpadding="0">
            <li   id="CertificateEnable"   RealType="CheckDivBox"   DescRef="s0d25"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.PeriodicInformEnable"
                InitValue="[{Item:[{AttrName:'id', AttrValue:'cert_key_password_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:310px; border:solid 1px #999999; background:#edeef0;'}]}]" ClickFuncApp="onClick=SetCertificateInfo"/>
            <li id="X_HW_CertPassword" RealType="TextBox"  DescRef="s0d26" RemarkRef="s0d27" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_CertPassword" ClickFuncApp="onmouseover=cert_key_password_show;onmouseout=cert_key_password_back"/>/>
            <li id="CfmPassword"       RealType="TextBox"  DescRef="s0d28" RemarkRef="s0d27" ErrorMsgRef="Empty" Require="FALSE" BindField="CfmPassword"  InitValue="Empty"/>
        </table>
        <script>
            SSLAcsConfigFormList = HWGetLiIdListByForm("TR069SSLCfg", null);
            var TableClass = new stTableClass("width_per30", "width_per70", "");
            HWParsePageControlByID("TR069SSLCfg", TableClass, Tr069LgeDes, null);
            InitSslAcsCfgBox();
        </script>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
            <tr>
                <td class="width_per30"></td>
                <td class="table_submit">
                    <input type="button" name="PWDbtnApply"    id="PWDbtnApply"    class="ApplyButtoncss  buttonwidth_100px" BindText="s0d21" onClick="AddSubmitImportcert();">
                    <input type="button" name="PWDcancelValue" id="PWDcancelValue" class="CancleButtonCss buttonwidth_100px" BindText="s0d22" onClick="CancelConfigPwd();">
                </td>
            </tr>
        </table>
    </form>

    <div class="func_spread"></div>
    <div class="func_title" id="certtitle" BindText="s0d29"></div>
    <form action="certification.cgi?RequestFile=html/ssmp/reset/reset.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
        <div>
            <table>
                <tr>
                    <td class="filetitle" BindText="s0d2a"></td>
                    <td>
                        <div class="filewrap">
                            <div class="fileupload">
                                <input type="hidden" id="onttoken"  name="onttoken"    value="<%HW_WEB_GetToken();%>" />
                                <input type="text"   id="f_file"    autocomplete="off" readonly="readonly" />
                                <input type="file"   id="t_file"    name="browse"      size="1"  onblur="StartFileOpt();" onchange="fchange();" />
                                <input type="button" id="btnBrowse" class="CancleButtonCss filebuttonwidth_100px" BindText="s0d2b" />
                                <script>
                                    if (CfgMode.toUpperCase() == "DINFOTEK2") {
                                        document.getElementById("btnBrowse").style.backgroundColor = "#0cb433";
                                    }
                                </script>
                            </div>
                        </div>
                    </td>
                    <td>
                        <script>
                            if (CfgMode == "DICELANDVDF") {
                                document.write('<input class="ApplyButtoncss  filebuttonwidth_100px" id="ImportCertification" name="btnSubmit" type="button" onclick="uploadCert();"" BindText="s0d2c" />')
                            } else {
                                document.write('<input class="CancleButtonCss filebuttonwidth_100px" id="ImportCertification" name="btnSubmit" type="button" onclick="uploadCert();"" BindText="s0d2c" />')
                            }
                        </script>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <div class="func_spread"></div>
    <script>
        ParseBindTextByTagName(Tr069LgeDes, "div",   1);
        ParseBindTextByTagName(Tr069LgeDes, "td",    1);
        ParseBindTextByTagName(Tr069LgeDes, "input", 2);
    </script>
    <script>
        $('#X_HW_CertPassword').blur(function() {
            CheckNoticeForSSL();
        });
    </script>
<br>
</body>
</html>
