<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">

var onlineState = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;
onlineState = (onlineState == 1 || onlineState == "1"); 

function stDevInfo(domain, serialnumber, devtype, loid, eponpwd, hexpassword)
{
    this.domain = domain;
    this.serialnumber = serialnumber;    
    this.devtype = devtype;
    this.hexpassword = hexpassword;
	this.loid = loid;
    this.eponpwd = eponpwd;
}

var stDevinfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GetOntAuthInfo, InternetGatewayDevice.DeviceInfo, SerialNumber|X_HW_UpPortMode|X_HW_Loid|X_HW_EponPwd|X_HW_PonHexPassword, stDevInfo);%>;
stDevinfo = stDevinfo[0];

function isHexaNumber(number)
{
    for (var index = 0; index < number.length; index++)
    {
        if (isHexaDigit(number.charAt(index)) == false)
        {
            return false;
        }
    }
    return true;
}

function CheckHexPassWord()
{
    var hexpassword = getValue('ontidtext');
    
    var len = hexpassword.length;
    
    if( ( (14 != len) && (20 != len) ) || (isHexaNumber(hexpassword) == false) )
    {
        AlertEx(cfg_ontauth_language['amp_hexpaswd_tde2']);
        return false;
    }

    return true;
}

function ChangeHextoAscii(hexpasswd)
{
    var str;
	var len = 0;
	
	len = hexpasswd.length;

	if (0 != len%2)
	{
	    hexpasswd += "0";
	}
	
    str = hexpasswd.replace(/[a-f\d]{2}/ig, function(m){
    return String.fromCharCode(parseInt(m, 16));});

    return str;
}

function ConfigSubmit()
{
    if(onlineState)
        return;
        
    var Form = new webSubmitForm();
    var url = "";
    var hexpassword = getValue('ontidtext');
    var SummitData = "";
    var ConfigUrl = "";
    
    if(!CheckHexPassWord())
    {
        return ;
    }

    setDisable("ontidSubmit", 1);

    SummitData += "&x.X_HW_PonHexPassword=" + hexpassword;

    ConfigUrl += "x=InternetGatewayDevice.DeviceInfo";

    if ('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_10GPON);%>' == '1')
    {
        var strPwd = ChangeHextoAscii(hexpassword);
        
        SummitData += "&y.RegistrationID=" + strPwd;
        SummitData += "&y.PreSharedKey=" + strPwd;

        ConfigUrl += "&y=InternetGatewayDevice.X_HW_XgponDeviceInfo";
    }

    SummitData += "&x.X_HW_Token=" + getValue('onttoken');
    
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/setajax.cgi?'+ConfigUrl+'&RequestFile=html/amp/ontauth/password_tde.asp',
        data: SummitData,
        success : function(data) {
            setDisable("ontidSubmit", 0);
        }
    });
    
    logoutfunc();
    
}

function LoadFrame()
{
    var hexpwd = stDevinfo.hexpassword;
    
    for(var i = 0; (i < 10) && (hexpwd.length < 20); i++)
    {
        hexpwd += "00";
    }
    
    setText("ontidtext", hexpwd);
    setDisable("ontidtext", onlineState);
    setDisable("ontidSubmit", onlineState);
}

</script>
</head>
<body  class="iframebody" onLoad="LoadFrame();">
<div class="title_spread"></div>
<div id="FuctionPageArea" class="FuctionPageAreaCss">
<div id="FunctionPageTitle" class="FunctionPageTitleCss">
<span id="PageTitleText" class="PageTitleTextCss" BindText="amp_auth_ont_id"></span>
</div>

<div id="FuctionPageContent" class="FuctionPageContentCss">
<div id="PageSumaryInfo" class="PageSumaryInfoCss" BindText="amp_auth_note_1"></div>
</div>

<div class="title_spread"></div>

<div id="ONTIdConfigArea">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<div id="ontidtextdiv"><input type="text" id="ontidtext" maxlength="20" name="ontidtext" class="Defaultinputcss CusInputWidth_350px"/></div>
<div id="ontidSubmitdiv"><input type="button"  class="BluebuttonGreenBgcss width_120px" id="ontidSubmit" onClick="ConfigSubmit();" value="" BindText="amp_auth_ok"/></div>
</div>

<div id="OntIdActionInfo">
<div id="ActionLog"></div>
<div id="ActionTextInfo">
<div id="ActionTextTitle" class="PageSumaryTitleCss" BindText="amp_auth_attention"></div>
<div id="ActionText" class="PageSumaryInfoCss_2" BindText="amp_auth_attention_content"></div>
</div>
</div>
</div>
</body>
<script>
ParseBindTextByTagName(cfg_ontauth_language, "div",  1);
ParseBindTextByTagName(cfg_ontauth_language, "span",  1);
ParseBindTextByTagName(cfg_ontauth_language, "input", 2);
</script>
</html>
