<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href="../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<title></title>
</head>
<script>
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var RedirtIndex = 0;
var UpgradeFlag = 0;
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';

var guideIndex = '<%HW_WEB_GetGuideChl();%>';
guideIndex = guideIndex - 48;
document.title = ProductName;

function loadframe()
{
    if (CfgMode.toUpperCase() == 'BRAZCLARO') {
        $("#mainguidebg").css("background-color", "rgb(218,41,28)");
        $("#mainguidebg").css("background-image", "url()");
    }
}


function onbtncfgnext(val)
{
    $.ajax({
        type : "POST",
        async : true,
        cache : false,
        url : 'showPrivacyStatement.cgi?&RequestFile=/index.asp',
        data:'showflag=0&x.X_HW_Token=' + getValue("onttoken"),
        success : function(data) {
            ;
        }
    });
    window.location="/index.asp";
}

</script>
<body onload="loadframe();">
    <div id="mainguidebg">
        <div id="mainguidetop">
            <script>
            if (logo_singtel == true) {
                document.write('<div id="brandlog_singtel" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'TELECENTRO') {
                document.write('<div id="brandlog_telecentro" style="display:none;"></div>');
            } else if ((CfgMode.toUpperCase() == 'PLDT2') || (CfgMode.toUpperCase() == 'PLDT')) {
                document.write('<div id="brandlog_pldt" style="display:none;"></div>');
            } else if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
                document.write('<div id="brandlog_antel" style="display:none;"></div>');
            } else if ((CfgMode.toUpperCase() == 'OMANONT') || (CfgMode.toUpperCase() == 'OMANONT2')) {
                    document.write('<div id="brandlog_oman" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'MAROCTELECOM') {
                document.write('<div id="brandlog_maroctelecom" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'ORANGEMT') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_orangemt" src="../../../images/hwlogo_orangemt.gif" width="48px"></img>' + '<div  id="ProductNameOrg">' + ProductName + '</div>'+'</div>');
            } else if (CfgMode.toUpperCase() == 'PARAGUAYPSN') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<div style="margin-left:50px"><img id="brandlog_paraguaypsn" src="../../../images/hwlogo_paraguaypsn.gif" width="92px"></img></div>' + '<div id="ProductNamePar">' + ProductName + '</div>'+'</div>');
            } else if (CfgMode.toUpperCase() == 'CLARODR') {
                document.write('<div id="brandlog_clarodr" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == "BRAZCLARO") {
                document.write('<div id="brandlog_claro" style="display:none;"></div>');
            } else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
                document.write('<div id="brandlog_deskctap" style="display:none;"></div>');
            } else {
                document.write('<div id="brandlog" style="display:none;"></div>');
            }
            </script>
            <script>
            if (logo_singtel == true) {
                document.write('<div id="ProductName" style="text-align:right; height:41px; line-height:63px; margin-left:630px;">' + ProductName + '</div>');				
            } else if ((CfgMode.toUpperCase() !== 'ORANGEMT') && (CfgMode.toUpperCase() !== 'PARAGUAYPSN')) {
                document.write('<div id="ProductName">' + htmlencode(ProductName) + '</div>');
            }
            </script>

            <div id="privacy" class="check_title" style="margin-top:120px">
                <span BindText="s2032"></span><a href="/html/ssmp/cfgguide/privacystatement.asp" BindText="s2033" style="Color:#666666"></a><span BindText="s2034"></span>
            </div>
            
            <div class="guidespace"></div>
            <div id="guideline5" class="guideline" style="margin-top:150px">
                <input type="button" id="btncfgnext" class="CancleButtonBlueBgCss buttonwidth_150px_250px" onClick="onbtncfgnext(this);" value="" BindText="s2030">
                <input type="button" id="btnexit"  class="CancleButtonBlueBgCss buttonwidth_150px_250px" style="margin-left:100px" onClick="logoutfunc();"  value="" BindText="s2031">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            </div>
        </div>
    </div>
    <div id="greenline"></div>
    <div id="copyright">
        <div id="copyrightspace"></div>
        <div id="copyrightlog" style="display:none;"></div>
        <div id="copyrighttext"><span id="footer" BindText="s2011"></span></div>
    </div>

    <div style="display:none;">
        <iframe frameborder="0" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="/refresh.asp" width="100%"></iframe>
    </div>

    <script>
        ParseBindTextByTagName(CfgguideLgeDes, "span",  1, mngttype, logo_singtel);
        ParseBindTextByTagName(CfgguideLgeDes, "input", 2);
        ParseBindTextByTagName(CfgguideLgeDes, "a", 1);
        if (parseInt(mngttype, 10) != 1) {
            if (parseInt(logo_singtel, 10) == 1) {
                if (TypeWord_com == "COMMON") {
                    $("#brandlog_singtel").css("background-image", "url()");
                }
                $("#brandlog_singtel").css("display", "block");
            } else {
                if (CfgMode.toUpperCase() == 'TELECENTRO') {
                    $("#brandlog_telecentro").css("display", "block");
                } else if ((CfgMode.toUpperCase() == 'PLDT2') || (CfgMode.toUpperCase() == 'PLDT')) {
                    $("#brandlog_pldt").css("display", "block");
                } else if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
                    $("#brandlog_antel").css("display", "block");
                    $("#brandlog_antel").css("width", "92PX");
                    $("#ProductName").css("line-height", "60PX");
                } else if ((CfgMode.toUpperCase() == 'OMANONT') || (CfgMode.toUpperCase() == 'OMANONT2')) {
                        $("#brandlog_oman").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'MAROCTELECOM') {
                    $("#brandlog_maroctelecom").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'ORANGEMT') {
                    $("#brandlog_orangemt").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'PARAGUAYPSN') {
                    $("#brandlog_paraguaypsn").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'CLARODR') {
                    $("#brandlog_clarodr").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
                    $("#brandlog_claro").css("display", "block");
                } else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
                    $("#brandlog_deskctap").css("background", "url('/images/logo_pon_login_deskctap.jpg') no-repeat center");
                    $("#brandlog_deskctap").css("display", "block");
                    $("#brandlog_deskctap").css("width", "172px");
                    $("#brandlog_deskctap").css("height", "60px");
                    $("#brandlog_deskctap").css("float", "left");
                    $("#copyrightlog").css("background-image", "url('')");
                } else {
                    $("#brandlog").css("display", "block");
                }
            }
            
            if ((parseInt(logo_singtel, 10) == 1) && (TypeWord_com == "COMMON")) {
                $("#copyrightlog").css("display", "none");
            } else {
                $("#copyrightlog").css("display", "block");	
            }
            if ((CfgMode.toUpperCase() == 'TS2') || (CfgMode.toUpperCase() == 'TS') || (CfgMode.toUpperCase() == 'TS2WIFI')) {
                $("#brandlog").css("background", "url(../../../images/logo_ts.jpg) no-repeat center");
                $("#brandlog").css("background-size", "80%");
                $("#brandlog").css("width", "155px");
                $("#brandlog").css("height", "70px");
                $("#ProductName").css("line-height", "95px");
            }
        }
    </script>

</body>
</html>
