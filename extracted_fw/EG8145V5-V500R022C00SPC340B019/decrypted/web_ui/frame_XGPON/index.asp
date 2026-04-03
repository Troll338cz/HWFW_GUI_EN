<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" rel="stylesheet" type="text/css" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(index.css);%>" rel="stylesheet" type="text/css" />
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<script src="/Cusjs/<%HW_WEB_CleanCache_Resource(frame.asp);%>" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
window.wanCacheObj = { wanListCacheObj:{}, wanIpv6StateCacheObj:{}, wanOptType: 0, curWanState: '0', wanMonitorTimer: null };
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var xdPonSupport = "<%HW_WEB_GetFeatureSupport(FT_XD_PON_SURPPORTED);%>";
var IsSupportWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var UserName = '<%HW_WEB_GetCurUserName();%>';
var ConfigFlag = '<%HW_WEB_GetGuideFlag();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var sysUserType = '0';
var dbaa1SuperSysUserType = '2';
var IsModifiedPwd = '<%HW_WEB_GetWebUserMdFlag();%>';
var flagTips = true;
var timeout = null;
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var telmexwififeature = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var mngtpccwtype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_PCCW);%>';
var MenuModeVDF = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var anteltype = '<%HW_WEB_GetFeatureSupport(FT_NORMAL_USER_NOGUIGE);%>';
document.title = ProductName;
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var apghnfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var videomodefeature = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_VIDEO_MODE);%>';
var fVideoCoverEnable = '<%HW_WEB_GetVedioCoverEnable();%>';
var DirectGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_CHANGE_GUIDE_LEVEL);%>';
var UnSupportGuide = '<%HW_WEB_GetFeatureSupport(FT_UDO_XGPON_AGUIDE);%>';
var menuJsonData;
var UpgradeFlag = 0;  //0--normal, 1--updating, 2--diagnosing
var upgradeStatusobj = {upgradeStatus:0};
var ajaxInfo = null;
var E8CAPFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_E8CAP_SWITCH);%>';
var VideoFlag = '<%HW_WEB_GetVideoChangeFlag();%>';
var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
var IsSupportpon2lan = '<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>'; 
var autoadapt = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AUTO_ADAPT);%>';
var adaptResult = '<%HW_WEB_GetCModeAdaptValue();%>';
var appUrl = '<%HW_WEB_GetSPEC(SPEC_STC_APP_URL.STRING);%>';

var aprepeater = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var aprepEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.AutoSelectSlaveApUpPort);%>';
var IsSmartBord = '<%HW_WEB_GetFeatureSupport(FT_SMART_BOARD);%>';
var COMMONV5CMODE = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_COMMONV5);%>';
var AdaptExist = '<%HW_WEB_IsSupportAd();%>';
var DAUMLOGO = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_Web.X_WebLogo);%>';
var DAUMFEATURE = "<%HW_WEB_GetFeatureSupport(FT_PRODUCT_DAUM);%>";
var IsSupportPortal = "<%HW_WEB_GetFeatureSupport(FT_WEB_REDIRECT_PORTALWIZARD);%>";
var portalAPType ='<%HW_WEB_GetApMode();%>';
var trueAdapt = '<%HW_WEB_GetFeatureSupport(FT_TRUE_ADAPT);%>';
var HostingQRcodeEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AppRemoteManage.HostingQRcodeEnable);%>';  
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var isRTOnlyMode='<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_MODE_ROUTER_ONLY);%>';
var userdevinfonum = "";
var IsSupportBridgeWan = "<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>";
var isRomdt = "<%HW_WEB_GetFeatureSupport(SSMP_FT_REMOVE_USERGUIDE);%>";
var TedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
var normalUserType = '1';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var isPageTurn = '<%HW_WEB_GetPageTurnStatus();%>';
var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
var lteStatusTimer;
var isTruergT3 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>';
var maxisNormalUserType = '2';
var maxisLocalUserType = '1';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var guidewizardflag = '<%HW_WEB_GetFeatureSupport(FT_NO_GUIDE_WIZARD);%>';
var supportPrivacyStatement = "<%HW_WEB_GetFeatureSupport(FT_SHOW_PRIVACY_STATEMENT);%>";
var showPrivacyStatement = '<%WEB_GetShowPrivacyStatement();%>';
var curUserInfoStatus = '<%WEB_GetUserInfoStatus();%>';
var cfgFtWordArea = '<%GetConfigAreaInfo();%>';
var ProvinceArray = '<%GetChoiceProvinceInfo();%>';
var defaultLang = '<%HW_WEB_GetCurrentLanguage();%>';
var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
var supportChangeLang = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_INDEX_CHANGE_LANG);%>';
var isNotSupportGuide = '<%HW_WEB_GetFeatureSupport(FT_WEB_NOGUIDE);%>';
var pwdChangeNoticeFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_PWD_CHANGE_NOTICE);%>';

function goToTop(){
    document.body.scrollIntoView();
}

if ((supportPrivacyStatement == '1') && (showPrivacyStatement == '1')) {
    window.location="/html/ssmp/cfgguide/guideprivacy.asp";
}

function stNormalUserInfo(UserName, ModifyPasswordFlag)
{
    this.UserName = UserName;
    this.ModifyPasswordFlag = ModifyPasswordFlag;
}
var UserInfo = <%HW_WEB_GetNormalUserInfo(stNormalUserInfo);%>;
var pwdModifyFlag = UserInfo[0].ModifyPasswordFlag;

if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI'))
{
    document.write('<link rel="shortcut icon" href="/images/Dzain.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dzain.ico" />');
}

if (DBAA1 == '1') {
    document.write('<link rel="shortcut icon" href="/images/A1_favicon.ico" />');
    document.write('<link rel="Bookmark" href="/images/A1_favicon.ico" />');
    document.title = framedesinfo["frame023"];
}

function dbaa1AllowGotoGuidePage()
{
    return curUserType == normalUserType;
}

function IsAdminUser()
{
    if (DBAA1 == "1") {
        return (curUserType == dbaa1SuperSysUserType) || (curUserType == sysUserType);
    }
    return curUserType == sysUserType;
}

if ('DVODACOM2WIFI' == CfgMode.toUpperCase())
{
    document.write('<link rel="shortcut icon" href="/images/Dvodacom.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dvodacom.ico" />');
}

if (DAUMFEATURE == 1) {
	document.write('<link rel="shortcut icon" href="/images/hwlogo.ico" />');
	document.write('<link rel="Bookmark" href="/images/hwlogo.ico" />');
}

if(1 != curChangeMode && 1 == aprepEnable)
{
    if(3 == aprepeater)
    {
        curChangeMode = 2;
    }
    else if(8 == aprepeater)
    {
        curChangeMode = 3;
    }
}
if(autoadapt == 1)
{
	curChangeMode = 4;
}

$.ajax({
    type : "POST",
    async : false,
    cache : false,
    url : "asp/getMenuArray.asp",
    success : function(data) {
         menuJsonData  = dealDataWithFun(data);
    }
});

var gotoIndexPage = 0;
if (CfgMode.toUpperCase() == 'DNZVDF2WIFI') {
    if ((parseInt(ConfigFlag.split("#")[0], 10)) || (parseInt(ConfigFlag.split("#")[1], 10))) {
        gotoIndexPage = 1;
    }
}

function gotoMaxisGuidePage() {
    if ((curUserType == maxisNormalUserType) && (!parseInt(ConfigFlag.split("#")[2], 10))) {
        window.location="CustomApp/userguideframe.asp";
    } else if ((curUserType == normalUserType) && (!parseInt(ConfigFlag.split("#")[1], 10))){
        window.location="/CustomApp/adminguideframe.asp";
    } else if ((curUserType == '0') && (!parseInt(ConfigFlag.split("#")[0], 10))) {
        window.location="/CustomApp/adminguideframe.asp";
    }
}

function gotoGuidePage() {

    if ((CfgMode.toUpperCase() == 'PERUCLARO') && (curUserType != sysUserType)) {
        return;
    }

    if (isNotSupportGuide === '1') {
        return;
    }

    if (gotoIndexPage == 1) {
        return;
    }

    if (guidewizardflag == 1) {
        return;
    }

    if (CfgMode.toUpperCase() == 'DETHMAXIS') {
        gotoMaxisGuidePage();
        return;
    }
    if (CfgMode.toUpperCase() == 'POLNETIA') {
        return;
    }
    if ((supportPrivacyStatement == '1') && (showPrivacyStatement == '1')) {
        return;
    }
    if (DBAA1 == "1") {
        if (dbaa1AllowGotoGuidePage() == false) {
            return;
        }
    }

    if ((CfgMode.toUpperCase() == 'TURKCELL2') && ((IsAdminUser()) || (pwdModifyFlag != 0))) {
        return;
    }
    
    if ((CfgMode.toUpperCase() == 'ANTEL2') ||
        (CfgMode.toUpperCase() == 'ANTEL') ||
        (CfgMode.toUpperCase() == 'DMASMOVIL2WIFI') ||
        (CfgMode.toUpperCase() == 'PTVDF2') ||
        (CfgMode.toUpperCase() == 'PTVDF2WIFI_PWD') ||
        (CfgMode.toUpperCase() == 'DHRINGDU2WIFI') ||
        !((IsSupportPortal != 1) || ((IsSupportPortal == 1) && (portalAPType == 1))) ||
        (IsSupportBridgeWan != 0)) {
            return;
    }

    if(1 == DirectGuideFlag && !parseInt(ConfigFlag.split("#")[0], 10))
    {
        if ((GhnDevFlag != '1') && (isRomdt != '1')) {
            window.location="CustomApp/userguideframe.asp";
        }
    }
    
    if(((curUserType == sysUserType && 0 == DirectGuideFlag) && !parseInt(ConfigFlag.split("#")[0], 10)) ||
       ((curUserType == sptUserType) && (!parseInt(ConfigFlag.split("#")[1], 10)) && (CfgMode.toUpperCase() == 'DNZVDF2WIFI')))
    {
        if(1 == smartlanfeature || apcmodefeature == 1 || (3 == CurrentUpMode && 1 == IsSupportpon2lan) || (CfgMode.toUpperCase() == 'DNZVDF2WIFI'))
        {   
            if((apcmodefeature == 0 && curChangeMode == 2) || (apcmodefeature == 0 && curChangeMode == 3) || GhnDevFlag == 1 || 1 == UnSupportGuide || (parseInt(anteltype, 10) == 1))
            {
                ;
            } else if (fttrFlag == 1) {
                window.location="/CustomApp/adminguideframe_fttr.asp";
            } else {
                window.location="/CustomApp/adminguideframe.asp";
            }
        }
        else
        {
            if((apcmodefeature == 0 && curChangeMode == 2) || (apcmodefeature == 0 && curChangeMode == 3) || GhnDevFlag == 1)
            {
                ;
            }else
            {
                if ((ProductType == '2') || (TedataGuide == 1))
                {
                    window.location = "/CustomApp/adminguideframe.asp";
                } else if (fttrFlag == 1) {
                    window.location="/CustomApp/adminguideframe_fttr.asp";
                } else {
                    window.location="/html/ssmp/cfgguide/guideindex.asp";
                }
            }
        }
    }
    else if((curUserType == sptUserType) && (!parseInt(ConfigFlag.split("#")[1], 10)) &&
            (parseInt(mngtpccwtype, 10) != 1 ) && (parseInt(anteltype, 10) != 1) && (TedataGuide == 0))
    {   
        if (fttrFlag == 1) {
            window.location="/CustomApp/adminguideframe_fttr.asp";
        } else if((GhnDevFlag != '1') && (isRomdt != '1')) {
            window.location="CustomApp/userguideframe.asp";
        }
    }
}

gotoGuidePage();

function showCmodePage() 
{   
    if (isRTOnlyMode == 1) {
		 $("input[name='CMode'][value='wifi']").attr("disabled",true);
		 $("input[name='CMode'][value='autoconsult']").attr("disabled",true);
	 }
    document.getElementById("zhezhao").style.display ="block";
    document.getElementById("showcmode").style.display ="none";
    document.getElementById("showcmode1").style.display ="block";   
}
function hideCmodePage() 
{
    document.getElementById("zhezhao").style.display ='none';
    document.getElementById("showcmode").style.display ='none';
    document.getElementById("showcmode1").style.display ='none';
    document.getElementById("1").disabled=false;
    document.getElementById("2").disabled=false;
    document.getElementById("3").disabled=false;
    document.getElementById("4").disabled=false;
    document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
    document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";
	document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
    document.getElementById("MdyPwdApply1").style.borderColor = "#bbbbbb";
	document.getElementById("MdyPwdApply1").disabled=true;
    if(curChangeMode=='1')
    {
        document.getElementById("5").checked=true;                  
    }
    if(curChangeMode=='2' || curChangeMode=='3')
    {
        document.getElementById("4").checked=true;
    }
	if(curChangeMode=='4')
    {
        document.getElementById("6").checked=true;
    }
}

function GetIdByUrl(Type, BaseUrl)
{   
    var NewId = Type+"_";
    var MarkEnd="";
    try{
        var lastindex = BaseUrl.lastIndexOf('/');
        if( lastindex > -1 )
        {
            NewId += BaseUrl.substring(lastindex+1, BaseUrl.length);
        }
        else
        {
            NewId += BaseUrl;
        }
        
        if(NewId.indexOf("?") > -1)
        {
            MarkEnd = NewId.split("?")[1];
        }
        
        NewId = NewId.split(".")[0]+MarkEnd;
        
    }catch(e){
        NewId += Math.round(Math.random() * 10000);
    }
    return NewId;
}

function DisplayDownAPP()
{
    if (HostingQRcodeEnable == "1")
    {
        $("#guidespacethree").css('display', 'block');
        $("#AppDiv").css('display', 'block');
    }
    else
    {
        $("#guidespacethree").css('display', 'none');
        $("#AppDiv").css('display', 'none');
    }
}

function IsModifedFun(){

	if(IsModifiedPwd == 0 && curUserType != sysUserType)
	{
		$("#modifyPwdBox").fadeIn(300);	
	} 
}

function onVendorChange(optionList) {
	if (optionList[optionList.selectedIndex].value == cfgFtWordArea) {
		return;
	}
	
	if (ConfirmEx(framedesinfo["mainpage052"])) {
		var areaInfo= getSelectVal("vendorselect");
		var Form = new webSubmitForm();	
		Form.addParameter('AreaInfo', areaInfo);
        Form.addParameter('x.X_HW_Token', HWGetToken());
		Form.setAction('UneedaChooseArea.cgi?RequestFile=html/main/restore_success.html');
		Form.submit();
	}
}

function IsHiddenGuide()
{
    if ((parseInt(mngttype, 10) == 1) || (parseInt(mngtpccwtype, 10) == 1) || (parseInt(TedataGuide, 10) == 1) ||
        (CfgMode.toUpperCase() == "PERUCLARO")) {
        return true;
    }

    return false;
}

function loadframe()
{
    if((IsModifiedPwd == 0) && (CfgMode == "GLOBE_FTTO")) {
        alert(framedesinfo["frame025"]);
    }
     if (isRTOnlyMode == 1) {
	     document.getElementById("gcmexplainbridge").innerHTML="Only support router mode";
		 document.getElementById("autoconsultexplain").innerHTML="Only support router mode";
	 }
	if ("1" == HostingQRcodeEnable)
    {
        $("#AppDiv").css("display", "block");
        $("#guidespacetwo").css("display", "block");
    }
	else
	{
		$("#AppDiv").css("display", "none");
		$("#guidespacetwo").css("display", "none");
	}	
    
	if (IsSupportBridgeWan == 0)
	{
        if (IsHiddenGuide() && (curUserType != sysUserType)) {
            $("#configguide").css("display", "none");
            $("#guidespaceone").css("display", "none");
        } else {
            $("#configguide").css("display", "block");
            $("#guidespaceone").css("display", "block");
        }

        if (parseInt(anteltype, 10) == 1) {
            $("#configguide").css("display", "none");
            $("#guidespaceone").css("display", "none");
        }
	}

    if ((CfgMode == "COMTECOEBG4") && (curUserType == "2")) {
        $("#configguide").css("display", "none");
        $("#guidespaceone").css("display", "none"); 
    }

    if(parseInt(mngttype, 10) != 1)
    {
        if(parseInt(logo_singtel, 10) != 1)
        {
            if (isSupportLte == 1) {
                    $("#username").css("color","#57B7F3");
                    $("#configguidetext").css("color","#57B7F3");
                    $("#headerLogoutText").css("color","#57B7F3");
                    $("#networkName").css("color","#57B7F3");
            }
            
            if ('TELECENTRO' == CfgMode.toUpperCase())
			{
				$("#headerbrandlog_tel").css("display", "block"); 
			}
			else if ('PLDT2' == CfgMode.toUpperCase() || 'PLDT' == CfgMode.toUpperCase())
			{
				$("#headerbrandlog_pldt").css("display", "block"); 
			}
			else if ('OMANONT' == CfgMode.toUpperCase() || 'OMANONT2' == CfgMode.toUpperCase())
			{
				$("#headerbrandlog_oman").css("display", "block");
            } else if (CfgMode.toUpperCase() == 'MAROCTELECOM') {
				$("#headerbrandlog_maroctelecom").css("display", "block");
			}
			else if ('ORANGEMT' == CfgMode.toUpperCase())
			{
				$("#headerbrandlog_orangemt").css("display", "block");
			}
			else if (CfgMode.toUpperCase() == 'PARAGUAYPSN')
			{
				$("#brandlog_paraguaypsn").css("display", "block");
            } else if (CfgMode.toUpperCase() == 'MYTIME') {
                $("#brandlog_mytime").css("display", "block");
            } else if (isTruergT3 == 1) {
                $("#brandlog_truerg").css("display", "block");
            } else if ('DETHMAXIS' == CfgMode.toUpperCase()) {
				$("#brandlog_dethmaxis").css("display", "block");
			} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
				$("#brandlog_cypruscyta").css("display", "block");
            } else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
				$("#headerbrandlog_commonrmhw").css("display", "block");
				$("#HeaderRightMenu").css("margin-top","-48px");
			}
			else if((DAUMFEATURE == 1) && (DAUMLOGO == 1))
			{
				$("#headerbrandlog_daum_iprimus").css("display", "block");
			}
			else if((DAUMFEATURE == 1) && (DAUMLOGO == 2))
			{
				$("#headerbrandlog_daum_dodo").css("display", "block");
			}
			else if((DAUMFEATURE == 1) && (DAUMLOGO == 3))
			{
				$("#headerbrandlog_daum_commander").css("display", "block");
			}
			else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase())
			{
				$("#headerbrandlog_dnztelecom").css("display", "block");
				$("#headerbg").css("background-image", "url()");
				$("#headerProductName").css("color","#00ad65");	
				$("#username").css("color","#666666");
				$("#configguidetext").css("color","#666666");
				$("#headerLogoutText").css("color","#666666");
			} else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
			    $("#headerbg").css("background-image", "url()");
			    $("#headerbg").css("background-color", "rgb(218,41,28)");
			    $("#headerbrandlog_claro").css("display", "block");	
			} else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
			    $("#headerbrandlog_deskctap_pon").css("display", "block");
			    $("#headerbrandlog_deskctap_pon").css("background-image", "url(../../../images/logo_pon_index_deskctap.jpg) no-repeat center");
			    $("#headerbrandlog_deskctap_pon").css("display", "block");
			} else if (htFlag == 1) {
                $("#headerbrandlog_ht").css("display", "block");
            } else if (oteFlag == 1) {
                $("#headerbrandlog_ote").css("display", "block");
            } else {
                $("#headerbrandlog").css("display", "block");
            }
			if ('DVODACOM2WIFI' == CfgMode.toUpperCase())
			{
				$("#headerbrandlog").css("background", "url(../../../images/HeaderLog_dvodacom.jpg) no-repeat center");
				$("#headerbrandlog").css("width", "200px");
				$("#headerbrandlog").css("height", "50px");
				$("#headerbrandlog").css("padding-right", "10px");
				$("#headerProductName").css("width", "340px");
				$("#headerProductName").css("color", "#333333");
			}
			if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
				$("#headerbrandlog").css("background", "url(../../../images/HeaderLog_antel.jpg) no-repeat center");
				$("#headerbrandlog").css("width", "111PX");
			}

            if (CfgMode.toUpperCase() == 'CLARODR') {
                $("#headerbrandlog").css("background", "url(../../../images/logo_clarodr.gif) no-repeat center");
                $("#headerbrandlog").css("width", "60PX");
            }
            if (TedataGuide == 1) {
                if (TypeWord_com == "ACUD") {
                    $("#headerbrandlog").css("background", "url(images/tedate_acud.jpg) no-repeat center");
                    $("#headerbrandlog").css("width", "80PX");
                    $("#headerbrandlog").css("marginRight", "10PX");
                } else {
                    $("#headerbrandlog").css("background", "url(images/yptlogo.jpg) no-repeat center");
                    $("#headerbrandlog").css("width", "60PX");
                }
            }
            if (CfgMode.toUpperCase() == 'AWASR') {
                $("#headerbrandlog").css("background", "url(../../../images/awasr_english_logo_rgb.jpg) no-repeat center");
                $("#headerbrandlog").css("width", "120px");
                $("#headerbrandlog").css("height", "50px");
            }
            if (CfgMode.toUpperCase() == 'UMNIAHPAIR') {
                $("#headerbrandlog").css("background", "url(../../../images/headerlogo_umniah.gif) no-repeat center");
                $("#headerbrandlog").css("width", "60PX");
            }
            if (CfgMode.toUpperCase() == 'MOINWI2'|| CfgMode.toUpperCase() == 'MOINWI') {
                $("#headerbrandlog").css("background", "url(../../../images/logo_moinwi2wifi.gif) no-repeat center");
                $("#headerbrandlog").css("background-repeat", "no-repeat");
                $("#headerbrandlog").css("background-size", "100%");
                $("#headerbrandlog").css("width", "140PX");
                $("#headerbrandlog").css("margin-right", "10px");
            }
            if (["TELESUREBG4","TELESUR2"].indexOf(CfgMode.toUpperCase()) >= 0) { 
                $("#headerbrandlog").css("background", "url(../../images/telesur-colored.png) no-repeat center");
                $("#headerbrandlog").css("width", "105px"); 
                $("#headerbrandlog").css("height", "45px"); 
                $("#headerbrandlog").css("background-size", "contain");
                $("#headerbrandlog").css("background-position", "center center"); 
                $("#headerbrandlog").css("marginRight", "10PX"); 
            }             

            if (CfgMode.toUpperCase() == "CMHK") {
                $("#headerProductName").css("width", "330px");
                $("#headerbrandlog").css("background", "url(../../../images/CMHKlogo.jpg) no-repeat center");
                $("#headerbrandlog").css("background-size", "100%");
                $("#headerbrandlog").css("width", "200px");
                $("#headerbrandlog").css("height", "66px");
                $("#headerbrandlog").css("margin-top", "-10px");
            }
            if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
                $("#headerbrandlog").css("background", "url(../../../images/HeaderLog_dzain.jpg) no-repeat center");
            }

            if (CfgMode.toUpperCase() == 'AOUNITEL') {
                $("#headerbrandlog").css("background", "url(../../../images/LogoNovo_UNITEL-NETCASA_RGB-01.png) no-repeat center");
                $("#headerbrandlog").css("width", "186px");
                $("#headerbrandlog").css("height", "56px");
            }
        }
        else
        {   
            if(TypeWord_com == "COMMON")
            {
                 $("#headerbrandlogSingtel").css("background-image", "url()");
            } 
            $("#headerbrandlogSingtel").css("display", "block");
        }       
    }

	if('DTURKCELL2WIFI' == CfgMode.toUpperCase()){
		if(flagTips)
		{
			IsModifedFun();
			flagTips = false;
		}
		
	}
	
	if (telmexwififeature == 1)
	{
		$("#headerbg").css("background-image", "url()");
		$("#headerbrandlog").css("width", "187px");
		$("#HeaderRightMenu").css("color","#56b2f8");
		$("#headerProductName").css("width", "324px");
		$("#username").css("color","#56b2f8");
		$("#configguidetext").css("color","#56b2f8");
		$("#headerLogoutText").css("color","#56b2f8");
	}

	if ((CfgMode.toUpperCase() == "MYTIME") || (CfgMode.toUpperCase() == "CYPRUSCYTA")) {
		$("#HeaderRightMenu").css("margin-top","-44px");
	}

	if((1 == videomodefeature) || (1 == VideoFlag))
	{
    	$("#VideoMode").css("display", "block");
        $("#guidevideospace").css("display", "block");
		setCheck('ckVideoSwitch', fVideoCoverEnable);
	}
	else
	{
		$("#VideoMode").css("display", "none");
        $("#guidevideospace").css("display", "none");
	}
    if(apghnfeature == 1)
    {
        document.getElementById("MdyPwdApply").disabled=true;
        document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
        document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";       
        $("#AppDiv").css("display", "none");
        $("#cmodeLogout").css("display", "none");
        $("#bssinfo").css("display", "none");
        $("#guidespacetwo").css("display", "none");
        document.getElementById("1").disabled=true;
        document.getElementById("3").disabled=true;
        $("#configguide").css("display", "none");
        $("#guidespaceone").css("display", "none");
        return;
    }
    
    if("" != curChangeMode && 0 != curChangeMode)
    {
        document.getElementById("MdyPwdApply").disabled=true;
        document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
        document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";
        document.getElementById("MdyPwdApply1").disabled=true;
        document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
        document.getElementById("MdyPwdApply1").style.borderColor = "#bbbbbb";
        $("#AppDiv").css("display", "none");
        $("#bssinfo").css("display", "none");
        
        if(apcmodefeature == 1)
        {       
            document.getElementById("cmodecontent").style.display="none";
            document.getElementById("aprepcontent").style.display="block";
            $("#cmodeLogout").css("display", "block");
            $("#guidespacetwo").css("display", "block");
            
            if(curChangeMode=='1')
            {
                DisplayDownAPP();
                document.getElementById("5").disabled=false;
                document.getElementById("5").checked=true;
                document.getElementById("rtpic5").src="../images/router2.png";
                document.getElementById("rtcontent").style.color="#57b6f0";
                document.getElementById("gcmexplainbridge").style.display="block";
            }
        
            if(curChangeMode=='2' || curChangeMode=='3')
            {
                if(curChangeMode=='2')
                {
                    document.getElementById("gcmexplainap").style.display="block";
                    document.getElementById("wifipic4").src="../images/apmode2.png";
                }
                if(curChangeMode=='3')
                {
                    document.getElementById("cmexplainrep").style.display="block";
                    document.getElementById("wifipic4").src="../images/Ranger2.png";
                }
                document.getElementById("4").disabled=false;
                document.getElementById("4").checked=true;
                document.getElementById("wificontent").style.color="#57b6f0";
            }
			
			if(curChangeMode=='4')
			{
				document.getElementById("autoconsultguide").style.display="block";
				document.getElementById("6").disabled=false;
				document.getElementById("6").checked=true;
				document.getElementById("autoadaptpic5").src="../../../images/apmode2.png";
				document.getElementById("autoconsultcontent").style.color="#57b6f0";
				document.getElementById("autoconsultexplain").style.display="block";
				document.getElementById("gcmexplainbridge").style.display="block";

			}
        }
        else
        {
            $("#cmodeLogout").css("display", "none");
            $("#guidespacetwo").css("display", "none");
            if(curChangeMode=='2' || curChangeMode=='3'){
                if(curUserType == sysUserType)
                {
                    if(0 == DirectGuideFlag)
                    {
                        $("#configguide").css("display", "none");
                        $("#guidespaceone").css("display", "none");
                    }
                }
            }
        }
    }
	
	if(("VDFPTAP"==CfgMode) || (CfgMode.toUpperCase() == "TRUEAP") || ('SONET_HN8255Ws' == CfgMode) || ('JAPAN_HN8255Ws' == CfgMode))
	{
		$("#cmodeLogout").css("display", "none");
		$("#guidespacetwo").css("display", "none");
	}
	if((AdaptExist == 0 && isRTOnlyMode != 1) || (CfgMode.toUpperCase() == 'CTCTRIAP'))
	{
		document.getElementById('autoconsultguide').style.display = "none";
		document.getElementById('hengline1').style.display = "none";
		$("#showcmode1").css("height", "380px");
	}

	if(trueAdapt == 1)
	{
		$("#cmodeLogout").css("display", "block");
		$("#guidespacetwo").css("display", "block");
	}
	
	if ((CfgMode.toUpperCase() == "UNE2") || (CfgMode.toUpperCase() == "EDATEL2")) {
		$("#vendorSel").css("display", "block");
		$("#guidespacetwo").css("display", "block");
		if ("CHOOSE" != cfgFtWordArea) {
			setSelect("vendorselect", cfgFtWordArea);
		}
	}

    if (((isRomdt == '1') && (curUserType == sptUserType)) || hideClaroFastsetting()) {
        setDisplay("configguide", 0);
        setDisplay("guidespaceone", 0);
    }

    if (isSupportLte == 1) {
        updateNetwork();
        lteStatusTimer = setInterval(updateNetwork, 20 * 1000);
    }

    if (fttrFlag == '1') {
        setDisplay("configguide", 0);
        setDisplay("guidespaceone", 0);
    }

    if (supportChangeLang == '1') {
        $("#guidespacethree").css("display", "block");
        $("#configlangue").css("display", "block");
        SetCusLanguageInfo(defaultLang, true);
    }
}

function hideClaroFastsetting()
{
    if ((CfgMode.toUpperCase() == "PERUCLARO") && (curUserType != sysUserType)) {
        return true;
    }
    return false;
}

function goToGuidePage()
{
    if (isNotSupportGuide === '1') {
        return;
    }

    if (!ifCanChangeMenu())
    {
        return ;
    }
    
    if(1 == DirectGuideFlag)
    {
        window.location="/CustomApp/userguideframe.asp";
        return;
    }

    var isAdmin = IsAdminUser();

    if (isAdmin && ((1 == smartlanfeature) || (3 == CurrentUpMode && 1 == IsSupportpon2lan)))
    {
        window.location="/CustomApp/adminguideframe.asp";
    }
    else if (isAdmin || ((isAdmin == 0) && (CfgMode.toUpperCase() == 'DNZVDF2WIFI')))
    {
        if(1 == apcmodefeature)
        {
            window.location="/CustomApp/adminguideframe.asp";
        }
        else
        {
            if ((ProductType == '2') || (TedataGuide == 1))
            {
                window.location = "/CustomApp/adminguideframe.asp";
            }
            else
            {
                window.location="/html/ssmp/cfgguide/guideindex.asp";
            }
        }
    }
    else
    {
        if ((CfgMode.toUpperCase() == 'DETHMAXIS') && (curUserType == maxisLocalUserType)) {
            window.location="/CustomApp/adminguideframe.asp";
        } else {
        window.location="/CustomApp/userguideframe.asp";
        }
    }
}

function closePwdTips(){
	$("#modifyPwdBox").fadeOut(500);
}

function jumpModifyPwd(){
	var accountUrl = "/html/ssmp/accoutcfg/account.asp"
	closePwdTips();
	onMenuChange1("userconfig",accountUrl);
	
}

function ifCanChangeMenu()
{
    if (UpgradeFlag == 1)
    {
        if(confirm(framedesinfo["mainpage016"]))
        {
            UpgradeFlag = 0;
            return true;
        }
        else
        {
            return false;
        }
    }
    else if (UpgradeFlag == 2)
    {
        if(confirm(framedesinfo["mainpage017"]))
        {
            UpgradeFlag = 0;
            return true;
        }
        else
        {
            return false;
        }
    }

    return true;
}

function toggleQRCodeDisplay(flag)
{
    var Type = flag;
    if (flag == 'auto')
    {
        var displayflag = document.getElementById("D2CodeDivInfo").style.display;
        Type = "block" == displayflag ? "none" : "block";
    }
    $('#D2CodeDivInfo').css("display", Type);
}

function adjustParentHeight()
{
    var menuBar = $("#SecondMenuInfo");
    adjustFrameHeight("maincenter", "menuIframe", 280, (menuBar != null ? menuBar.innerHeight() + 100 : null));
}

var mobileResult = '';

function getMobileInterfaceInfo() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "mobileInterfaceInfo.asp",
        success : function(data) {
            mobileResult = dealDataWithFun(data);
        }
    });
}
function state_show(id, info) {
    document.getElementById(id).onmouseover = function() {
        var currentposition = $('#'+id).offset();
        $("#statusWord").css("left",currentposition.left);
        $("#statusWord").css("top",currentposition.top + 35);
        $("#statusWord").css("background-color", '#D8E1EC');
        document.getElementById("statusWord").innerHTML = info;
        $("#statusWord").css("display", "block");
        $("#statusWord").css("color","#57B7F3");
    };

    document.getElementById(id).onmouseout = function() {
        document.getElementById("statusWord").innerHTML = "";
        $("#statusWord").css("display", "none");
    };
}

function showStatus(id, path, info) {
    $("#"+id).attr("src", path);
    $("#"+id).css("display", "inline-block");
    state_show(id, info);
}

function updateSignalStatus() {
    var signal = "0";
    var simStatus = mobileResult[0].simStatus;
    var systemMode = mobileResult[0].systemMode;
    var signalQuality = mobileResult[0].signalQuality;
    var serviceStatus = mobileResult[0].serviceStatus;
    var serviceDomain = mobileResult[0].serviceDomain;
    var pinStates = mobileResult[0].simState;

    if(signalQuality == 0) {
        signal = 0;
    } else if ((signalQuality == 1) || (signalQuality == 2)) {
        signal = 1;
    } else if (signalQuality == 3) {
        signal = 2;
    } else if ((signalQuality == 4) || (signalQuality == 5)) {
        signal = 3;
    } else {
        signal = 0;
    }

    var signalInfo = [mobile_simcard_status_language['mobile_no_signal'], mobile_simcard_status_language['mobile_signal_weak'], mobile_simcard_status_language['mobile_signal_strong'],mobile_simcard_status_language['mobile_signal_excellent']];

    if ((serviceStatus != "AvailableService") || (systemMode == "NO SERVICE") || (serviceDomain == "NO SERVICE")) {
        signal = 0;
    }

    if(simStatus == "Valid" || simStatus == "CS_Invalid" || simStatus == "PS_Invalid" || simStatus == "PS_CS_Invalid") {
        showStatus("signal", "/images/signal_"+ signal +".gif", signalInfo[signal]);
    } else if(simStatus == "NoCard") {
        showStatus("signal", "/images/sim_disable.gif", mobile_simcard_status_language['mobile_no_simcard']);
    } else {
        if (pinStates == 4) {
            showStatus("signal", "/images/sim_lock.gif", mobile_simcard_status_language['mobile_puk_required']);
        } else if (pinStates == 3) {
            showStatus("signal", "/images/sim_lock.gif", mobile_simcard_status_language['mobile_pin_required']);
        } else if (pinStates == 5) {
            showStatus("signal", "/images/sim_lock.gif", mobile_simcard_status_language['mobile_simcard_locked']);
        } else if (pinStates == 0) {
            showStatus("signal", "/images/sim_lock.gif", mobile_simcard_status_language['mobile_no_simcard']);
        } else {
            showStatus("signal", "/images/sim_disable.gif", mobile_simcard_status_language['mobile_simcard_invalid']);
        }
    }
}

function updateRatStatus() {
    var simStatus = mobileResult[0].simStatus;
    var serviceStatus = mobileResult[0].serviceStatus;
    var systemMode = mobileResult[0].systemMode;
    var sysSubMode = mobileResult[0].sysSubMode;
    var lteBand = mobileResult[0].lteBand;

    if (systemMode == "LTE") {
        var lteBandArray = new Array();
        lteBandArray = lteBand.split("B");
        sysSubMode = "FDD";

        for(var i = 33; i < 45; i++) {	
            if (lteBandArray[lteBandArray.length -1] == i) {
                sysSubMode = "TDD";
                break;
            }
        }
    }

    if ((serviceStatus == "AvailableService") && ((simStatus == "Valid") || (simStatus == "CS_Invalid")) && (sysSubMode != "NO SERVICE")) {
        switch (sysSubMode) {
            case "GSM":
            case "GPRS":
            case "EDGE":
                showStatus("rat", "/images/rat_2.gif", mobile_simcard_status_language['mobile_2G']);
                break;
            case "WCDMA":
            case "HSDPA":
            case "HSUPA":
            case "HSPA":
            case "HSPA+":
            case "19":
            case "21":
            case "22":
            case "23":
            case "24":
                showStatus("rat", "/images/rat_3.gif", mobile_simcard_status_language['mobile_3G']);
                break;
            case "LTE":
            case "FDD":
                showStatus("rat", "/images/rat_4.gif", mobile_simcard_status_language['mobile_FDD']);
                break;
            case "TDD":
                showStatus("rat", "/images/rat_4.gif", mobile_simcard_status_language['mobile_TDD']);
                break;
            default:
                break;
        }
    } else {
        $("#rat").css("display", "none");
    }
}

function updateNetworkStatus() {
    if (mobileResult[0] == null) {
        return;
    }

    var networkName = mobileResult[0].regitstedNetwork;
    var roamStatus = mobileResult[0].roamStatus;
    var wanState = mobileResult[0].wanState;

    $("#mobileinfo").css("display", "block");

    if (networkName != "") {
        document.getElementById("networkName").innerHTML = htmlencode(networkName);
        $("#networkName").css("display", "inline-block");
        state_show("networkName", networkName);
    } else {
        document.getElementById("networkName").innerHTML = "";
        $("#networkName").css("display", "none");
    }

    if (roamStatus == "Roam") {
        showStatus("roamstatus", "/images/roaming.gif", mobile_simcard_status_language['mobile_roam']);
    } else {
        $("#roamstatus").css("display", "none");
    }

    updateSignalStatus();
    updateRatStatus();

    if (wanState == 1) {
        showStatus("wanStatus", "/images/wan_1.gif", mobile_simcard_status_language['mobile_wan_connect']);
    } else {
        showStatus("wanStatus", "/images/wan_0.gif", mobile_simcard_status_language['mobile_wan_disconnect']);
    }
}

function updateNetwork() {
    if (UpgradeFlag == 1) {
        clearInterval(lteStatusTimer);
        return;
    }

    getMobileInterfaceInfo();
    updateNetworkStatus();
}

function onChangeLanguage(language)
{
    if (language == null) {
        return; 
    }
    if (defaultLang == language) {
        return;
    }

    var Form = new webSubmitForm();
    Form.addParameter('language', language);
    Form.addParameter('x.X_HW_Token', getAuthToken(true));
    Form.setAction('setlanguage.cgi?'+'&RequestFile=index.asp');
    Form.submit();
}

var langDescList = new Array();
langDescList["chinese"] = "简体中文";
langDescList["english"] = "English";
langDescList["japanese"] = "日本語";
langDescList["arabic"] = "العربية";
langDescList["portuguese"] = "Português";
langDescList["spanish"] = "Español";
langDescList["turkish"] = "Türkçe";
langDescList["brasil"] = "Brasil";
langDescList["german"] = "German";
langDescList["russian"] = "Русский";

var languageSet = new Array();
if ((typeof languageList == 'string') && (languageList != '')) {
    languageSet = languageList.split("|");
}

function genLanguageList()
{
    if (languageList == '')
        return false;

    var ChangeLanguage = '';
    if (languageSet.length > 1) {
        for (var lang in languageSet) {
            ChangeLanguage += '<td width="47%" nowrap><a id="'
                           + languageSet[lang] + '" href="#" name="'
                           + languageSet[lang] + '" onClick="onChangeLanguage(this.id);" class="changelanguage">['
                           + langDescList[languageSet[lang]] + ']</a></td>';
        }
        document.getElementById('chooselagButton').innerHTML = ChangeLanguage;
    }
}

function SetCusLanguageInfo(language)
{
    var node = document.getElementById(language);
    if ((node == null) || (node == undefined)) {
        return;
    }

    node.style.color = "#9b0000";
}

</script>
</head>
<body onload="loadframe();">
<div id="modifyPwdBox" style="display:none;">
	<div id="passwordTips" class="passwordTips">
		<div id="pwdCloseBtn" class="pwdCloseBtn">
			<a onclick="closePwdTips();"></a>
		</div>
		<div id="pwdContainer" class="pwdContainer">
			<h2>Notice</h2>
			<p>You are currently using the default login password. Please change this password to improve the network security.</p>
		</div>
		<div id="pwdBtn" class="pwdBtn">
			<a onclick="jumpModifyPwd();">Modify Login Password</a>
			<a style="margin-left: 40px;" onclick="closePwdTips();">Missing transition:UserLogin.Skip</a>
		</div>
	</div>
</div>
<div id="indexpage">
<script>
if ((telmexwififeature == 1 ) || (isSupportLte == 1 ))
{
	document.write('<div id="headertelmexbg">');
}
else
{
	document.write('<div id="headerbg">');
}
</script>  
        <div id="header">

        <script>
            if (logo_singtel == true) {
                document.write('<div id="headerbrandlogSingtel"></div>');               
            } else if (CfgMode.toUpperCase() == 'TELECENTRO') {
                document.write('<div id="headerbrandlog_tel"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if ((CfgMode.toUpperCase() == 'PLDT2') || (CfgMode.toUpperCase() == 'PLDT')) {
                document.write('<div id="headerbrandlog_pldt"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if (CfgMode.toUpperCase() == 'MAROCTELECOM') {
                document.write('<div id="headerbrandlog_maroctelecom"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if (CfgMode.toUpperCase() == 'ORANGEMT') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_orangemt" src="images/hwlogo_orangemt.gif" width="53px"></img>' + '<div  id="headerProductNameOrg">' + ProductName + '</div>'+'</div>');
            } else if (CfgMode.toUpperCase() == 'PARAGUAYPSN') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_paraguaypsn" src="images/hwlogo_paraguaypsn.gif" width="92px"></img>' + '<div  id="headerProductNamePar">' + ProductName + '</div>'+'</div>');
            } else if (CfgMode.toUpperCase() == 'MYTIME') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 12px"></div>'+'<img id="brandlog_mytime" src="images/hwlogo_mytime.gif" width="92px"></img>' + '<div  id="headerProductNamePar" style="margin-top: -37px">' + ProductName + '</div>'+'</div>');
            } else if (isTruergT3 == 1) {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_truerg" src="images/hwlogo_truergpwdsn.gif" width="48px"></img>' + '<div  id="headerProductNameTruergPwdsn">' + ProductName + '</div>'+'</div>');
            } else if ((DAUMFEATURE == 1) && (DAUMLOGO == 1)) {
                document.write('<div id="headerbrandlog_daum_iprimus"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if ((DAUMFEATURE == 1) && (DAUMLOGO == 2)) {
                document.write('<div id="headerbrandlog_daum_dodo"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if ((DAUMFEATURE == 1) && (DAUMLOGO == 3)) {
                document.write('<div id="headerbrandlog_daum_commander"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if (CfgMode.toUpperCase() == 'DNZTELECOM2WIFI') {
                document.write('<div id="headerbrandlog_dnztelecom"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if ((CfgMode.toUpperCase() == 'TM') || (CfgMode.toUpperCase() == 'TM2')) {
                document.write('<img id="headerbrandlog_tm" src="images/hwlogo_tm.gif"></img>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if ((CfgMode.toUpperCase() == 'OMANONT') || (CfgMode.toUpperCase() == 'OMANONT2')) {
                document.write('<div id="headerbrandlog_oman"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
                document.write('<div id="headerbrandlog"></div>');
                document.write('<div id="headerProductName" style="float:left;">' + ProductName + '</div>');
                document.write('<div style="clear:both;">' + '</div>');
            } else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
                document.write('<div id="headerbrandlog_claro"></div>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
            } else if (CfgMode.toUpperCase() == "AOUNITEL") {
                document.write('<div id="headerbrandlog"></div>');
                document.write('<div id="headerProductName"></div>');
            } else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
				document.write('<img id="headerbrandlog_deskctap_pon" src="images/logo_pon_index_deskctap.jpg" style="width:160px;height:56px;float:left;margin-right:20px;"></img>');
                document.write('<div id="headerProductName">' + ProductName + '</div>');
			} else if (DBAA1 == '1') {
                document.write('<div id="headerbrandlog_dbaa1"></div>');
                document.write('<div id="headerProductNameLte">' + framedesinfo["frame024"] + '</div>');
            } else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<img id="brandlog_dethmaxis" src="images/hwlogo_dethmaxis.gif" width="65px"></img>' + '<div  id="headerProductNameDethmaxis">' + ProductName + '</div>'+'</div>');
            } else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<img id="brandlog_cypruscyta" src="images/hwlogo_cyta.jpg" width="92px"></img>' + '<div  id="headerProductNameCypruscyta">' + ProductName + '</div>'+'</div>');
            } else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
                document.write('<div style="margin: 0 auto">' + '<div style="height: 11px"></div>'+'<img id="headerbrandlog_commonrmhw" src="images/logo_commonrmhw.gif" width="155px"></img>' + '<div  id="headerProductNameCommonrmhw">' + ProductName + '</div>'+'</div>');
            } else if (htFlag == 1) {
                document.write('<div id="headerbrandlog_ht"></div>');
                document.write('<div id="headerProductNameLte">' + ProductName + '</div>');
            } else if (oteFlag == 1) {
                document.write('<div id="headerbrandlog_ote"></div>');
                document.write('<div id="headerProductNameLte">' + ProductName + '</div>');
            } else if (CfgMode.toUpperCase() == 'TS2WIFI') {
                document.write('<div id="headerbrandlog_ts"></div>');
                document.write('<div id="headerProductNameLte">' + ProductName + '</div>');
            } else {
                if (isSupportLte == 1) {
                    document.write('<div id="headerbrandlog_lte"></div>');
                    document.write('<div id="headerProductNameLte">' + ProductName + '</div>');
                } else {
                    document.write('<div id="headerbrandlog"></div>');
                    document.write('<div id="headerProductName">' + ProductName + '</div>');
                }
            }
        </script>
            <div id="HeaderRightMenu">
                <div id="headerLogout">
                    <span id="headerLogoutText" class="HeaderSpanTextGuide" onclick="logoutfunc();"  BindText="mainpage009"></span>

                </div>
                <div id="headeruser">
                    <span id="username" class="HeaderSpanTextGuide" ></span>
                </div>

				<script>
                    function shouldCreateCfgGuideBtn() {
                        if (isNotSupportGuide === '1') {
                            return false;
                        }
                        if ((CfgMode.toUpperCase() == 'TURKCELL2') && IsAdminUser()) {
                            return false;
                        }
                        if ((TedataGuide == 1) && (IsAdminUser() == false)) {
                            return false;
                        }
                        if (CfgMode.toUpperCase() == 'DHRINGDU2WIFI') {
                            return false;
                        }
                        if (guidewizardflag == 1) {
                            return false;
                        }
                        return true;;
                    }
                    if (shouldCreateCfgGuideBtn()) {
						document.write('<div id="guidespaceone" class="guidespace"><div class="guidespacebar"></div></div>' +
							'<div id="configguide"><span id="configguidetext" class="HeaderSpanTextGuide" onclick="goToGuidePage();" BindText="mainpage008"></span></div>');
					}
				</script>
                <script>
                    if (isSupportLte == 1) {
                        document.write('<div id="statusWord" class="HeaderSpanTextGuide" style="position:absolute;z-index:1000;display:none"></div>');
                        document.write('<div id="mobileinfo">');
                        document.write('<span id="networkName" class="HeaderSpanTextGuideMobile" ></span>');
                        document.write('<span>&nbsp;&nbsp;</span>');
                        document.write('<img id="roamstatus" src="" class="HeaderImg" />');
                        document.write('<img id="signal" src="" class="HeaderImg" />');
                        document.write('<img id="rat" src="" class="HeaderImg" />');
                        document.write('<img id="wanStatus" src="" class="HeaderImg" />');
                        document.write('</div>');
                    }
                </script>

                <div id="guidespacetwo" class="guidespace">
                    <div class="guidespacebar"></div>               
                </div>
                <div id="cmodeLogout" >
                    <span id="modechangeText" class="HeaderSpanTextGuide" onclick="showCmodePage();"  BindText="mainpage019"></span>
                </div>
                <div id="vendorSel" style="display:none;">
                    <span id="vendorSelText" class="HeaderSpanTextGuide" BindText="mainpage019une2"></span>
                    <select name="vendorselect" id="vendorselect" onchange="onVendorChange(this);">
                        <option value="UNE2">UNE</option>
                        <option value="EDATEL2">EDATEL</option>
                    </select>
                </div>
				<div id="guidevideospace" style="display:none;" class="guidespace"><div class="guidespacebar"></div></div>
				<script language="JavaScript" type="text/javascript">
				function setVideoSwitch()
				{
					var isVideo = getCheckVal('ckVideoSwitch');
	
    				if(ConfirmEx("设置模式切换，需重启，是否执行？"))
					{
                         $.ajax({
                            type : "POST",
                            async : true,
                            cache : false,
                            data : "w.VideoCoverEnable=" + isVideo + "&x.X_HW_Token=" + getValue('onttoken'),
                            url : 'set.cgi?w=InternetGatewayDevice.X_HW_VideoCoverService',
            				success : function(data) {

                                 }
                         });
                     }
                     else
                     {
					 	var lastvideo = (isVideo == 0)? 1:0;
                        setCheck('ckVideoSwitch', lastvideo);
                     }
                 }

				</script>

			<div id="VideoMode" title="视频通模式，可解决家庭无网线开IPTV业务场景，可设置为普通模式" style="display:none;float:left;margin-top:16px;margin-right:5px;"><input type="checkbox" name="ckVideoSwitch" id="ckVideoSwitch" style="line-height:30px;vertical-align:middle;" onClick='setVideoSwitch();' ><span class="HeaderSpanTextGuide" >视频通</span></input></div>
			<div><input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"></div>
                <div id="cmodeLogout" >
                    <span id="modechangeText" class="HeaderSpanTextGuide" onclick="showCmodePage();"  BindText="mainpage019"></span>
                </div>
                <div id="guidespacethree" class="guidespace" style="display: none">
                    <div class="guidespacebar"></div>               
                </div>
                <div id="AppDiv" >
                    <div id="MaPoniterText" >
                        <span class="HeaderSpanTextGuide" BindText="mainpage013"></span>
                    </div>
                    <div id="MaPoniterIcon" ></div>
                    <div id="D2CodeDivInfo">
                        <div id="FirstLineIcon">
                            <div id="phoneicon"><img src="images/D2CodePhone.jpg"></div>
                            <div id="phonetext"><span BindText="mainpage007"></span></div>
                        </div>
                        <div id="D2CodeTop">
                            <div class="D2CodeCornerLeft"></div>
                            <div class="D2CodeCornerRigth"></div>
                        </div>
                        <div id="D2CodeIcon"></div>
                        <div id="D2CodeBottom">
                            <div class="D2CodeCornerLeft"></div>
                            <div class="D2CodeCornerRigth"></div>
                        </div>
                    </div>
                </div>
                <script>
                    if(true == logo_singtel)
                    {
                        document.write('<div id="headerRightProductName"><span class="HeaderSpanProduct">' + ProductName + '</span></div>');
                    }
                </script>

                <div id="guidespacethree" class="guidespace" style="display:none;">
                    <div class="guidespacebar"></div>
                </div>

                <div id="configlangue" style="display:none;">
                    <div id="chooselagButton" class="HeaderSpanTextGuide"></div>
                </div>
                <script>
                    genLanguageList();
                </script>
            </div>
        </div>
    </div>
    <div id="maincenter">
        <div id="MenuInfo"></div>
        <div id="SecondMenuInfo" class="Menuhide"></div>
        <div id="content">
            <iframe id="menuIframe" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" class="AspWidth" scrolling="no" overflow="hidden" style="z-index:301;position: relative;min-height:700px"></iframe>
        </div> 
    </div>

    <div id="fresh">
        <iframe frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="refresh.asp"></iframe>
    </div>
</div>
<div id="zhezhao"></div>
<div id="showcmode" style="display:none;">
    <h2 id="cmodetitle" > 
        <div id="cmtitlecontent"  BindText="mainpage019"></div>
        <div id="cmodeclose" ><img id="cmimageclose" src="../images/xx.png" onclick="hideCmodePage();"></div>
    </h2>
    
    <div id="cmodecontent" style="display:none;">

        <div id="apmode">
            <div id="apradiodiv" ><input id="2" type="radio" name="CMode" value="lan" /></div>
            <div id="cmimagediv" ><img id="appic" src="../images/apmode1.png"></div>
            <div id="apmodecontent" >
                <h2 id="upmodenames"><span id="apcontent" class="Smartinforight"  BindText="mainpage021" ></span></h2>
                <div id="cmexplain" BindText="mainpage025"></div>
            </div>
            <p id="hengline" ></p>
            <div class="clear"></div>
        </div>

        <div id="wifimode" >
            <div id="wifiradiodiv"><input id="3" type="radio" name="CMode" value="wifi" /></div>
            <div id="cmimagediv"><img id="wifipic" src="../images/Ranger1.png"></div>
            <div id="wifimodecontent">
                <h2 id="upmodenames"><span id="wificontent1" class="Smartinforight" BindText="mainpage022"></span></h2>
                <div id="cmexplain" BindText="mainpage026"></div>
            </div>
            <p id="hengline"></p>
            <div class="clear"></div>
        </div>

        <div id="rtmode" >
            <div id="rtradiodiv"><input id="1" type="radio" name="CMode" value="route" /></div>
            <div id="cmimagediv" class="cmpicdiv1" ><img id="rtpic" src="../images/router1.png"></div>
            <div id="rtmodecontent">
                <h2 id="upmodenames"><span id="rtcontent1" class="Smartinforight" BindText="mainpage020"></span></h2>
                <div id="cmexplain" BindText="mainpage027"></div>
            </div>
            <div class="clear"></div>
        </div>      
    </div>  
    <br>
    <div id="cmbutton" >
        <input type="button" id="MdyPwdcancel" class="CancleButtonCss buttonwidth_100px" onclick="hideCmodePage();" BindText="mainpage023" />
        <input type="button" id="MdyPwdApply" class="ApplyButtoncss buttonwidth_100px" onclick="showconfirm();" BindText="mainpage024" />   
        
    </div>
    
    <div class="alert_box" id="alert_box" style="display:none;">
        <div style="float:left;"><img id="reboot_img" src="../../../images/icon-thinking.gif" /></div>
        <div class="reboot_title_fir" style="float:left;margin-left:10px;" BindText="mainpage040"></div>
    </div>  
</div>

<div id="showcmode1" style="display:none;position:flex;top:50%;height:480px;margin-top:-190px;width:700px;left:50%;margin-left:-230px;background-color:white; z-index:1002;">
    <h2 id="cmodetitle1" style="width:100%;height:35px;background-color:#C4C8CC;margin-top:0px;font-size:16px;font-family: 微软雅黑;"> 
        <div id="cmtitlecontent"  BindText="mainpage019"></div>
        <div id="cmodeclose" ><img id="cmimageclose" src="../images/xx.png" onclick="hideCmodePage();"></div>
    </h2>
    <div id="aprepcontent" style="margin-top:4%;margin-left:2.5%;text-align:left;display:none;">
        <!-- 路由模式 -->
        <div id="rtmode" >
            <div id="rtradiodiv"><input id="5" type="radio" name="CMode" value="route" /></div>
            <div id="cmimagediv" class="cmpicdiv1" ><img id="rtpic5" src="../images/router1.png"></div>
            <div id="rtmodecontent">
                <h2 id="upmodenames"><span id="rtcontent" class="Smartinforight" BindText="mainpage020"></span></h2>
                <div id="cmexplain" BindText="mainpage027"></div>
            </div>
            <p id="hengline"></p>
            <div class="clear"></div>
        </div>
		<!-- 桥接模式 -->
        <div id="wifimode" >
            <div id="wifiradiodiv"><input id="4" type="radio" name="CMode" value="wifi" /></div>
            <div id="cmimagediv"><img id="wifipic4" src="../images/Ranger1.png"></div>
            <div id="wifimodecontent">
                <h2 id="upmodenames"><span id="wificontent" class="Smartinforight" BindText="mainpage041"></span></h2>
                <div id="cmexplainrep" style="display:none;margin-top:5px;" BindText="mainpage026"></div>
                <div id="gcmexplainap" style="display:none;margin-top:5px;" BindText="mainpage025"></div>
                <div id="gcmexplainbridge" style="margin-top:-5px;width:600px;display:none;" BindText="mainpage042"></div>
            </div>
			<p id="hengline1" style="width:98%;height:1px;background-color:#CCCCCC;margin-top:20px;float:left;" ></p>
            <div class="clear"></div>
        </div>
		<!-- 自适应模式 -->
		<div id="autoconsultguide" style="margin-top:30px;">
			<div id="autoconsultradio" style="float:left;margin-top:12px;"><input id="6" type="radio" name="CMode" value="autoconsult" /></div>
			<div id="cmimagediv" ><img id="autoadaptpic5" src="../../../images/apmode1.png"></div>
			<div id="apaumodecontent" style="margin-top:-11px;margin-left:72px;" >
				<h2 id="upmodenames" style=""><span id="autoconsultcontent" class="Smartinforight" BindText="mainpage043"></span></h2>
				<div id="autoconsultexplain" style="margin-top:-5px;width:600px;" BindText="mainpage044"></div>
			</div>
			<div class="clear"></div>
		</div>
		
    </div>
    
    <br>
    <div id="cmbutton1" style="margin-top:10px;">
        <input type="button" id="MdyPwdcancel" class="CancleButtonCss buttonwidth_100px" onclick="hideCmodePage();" BindText="mainpage023" />
        <input type="button" id="MdyPwdApply1" class="ApplyButtoncss buttonwidth_100px" onclick="showconfirm();" BindText="mainpage024" />       
    </div>
    
    <div class="alert_box1" id="alert_box1">
        <div style="float:left;"><img id="reboot_img" src="../../../images/icon-thinking.gif" /></div>
        <div class="reboot_title_fir" style="float:left;margin-left:10px;" BindText="mainpage040"></div>
    </div>  
</div>

<script type="text/javascript">
        function HWGetToken()
        {
            var tokenstring="";
            $.ajax(
            {
                type : "POST",
                async : false,
                cache : false,
                url : "/html/ssmp/common/GetRandToken.asp",
                success : function(data) 
                {
                    tokenstring = data;
                }
            });
            return tokenstring;
        }

	$(function(){
		showwifimode();
		$("input[name=CMode]").click(function(){
			showwifimode();
			if(autoadapt == 1)
			{
				if(($("input[name=CMode]:checked").attr("id")) == '4')
				{
					if(curChangeMode=='1')
					{
						document.getElementById("MdyPwdApply1").disabled=true;  
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
					}
					else
					{
						document.getElementById("MdyPwdApply1").disabled=false; 
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#56B2F8";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
						document.getElementById("MdyPwdApply1").style.Color = "#FFFFFF";
					}

				}
				if(($("input[name=CMode]:checked").attr("id")) == '5')
				{
					if(curChangeMode=='2' || curChangeMode=='3')
					{
						document.getElementById("MdyPwdApply1").disabled=true;  
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
					}
					else
					{
						document.getElementById("MdyPwdApply1").disabled=false; 
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#56B2F8";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
						document.getElementById("MdyPwdApply1").style.Color = "#FFFFFF";
					}
				}

			}
			else
			{
				if(($("input[name=CMode]:checked").attr("id")) == '4')
				{
					if(curChangeMode=='1' ||　(curChangeMode=='4' && adaptResult=='1'))
					{
						document.getElementById("MdyPwdApply1").disabled=false; 
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#56B2F8";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
						document.getElementById("MdyPwdApply1").style.Color = "#FFFFFF";
					}
					else
					{
						document.getElementById("MdyPwdApply1").disabled=true;  
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
					}

				}
				if(($("input[name=CMode]:checked").attr("id")) == '5')
				{
					if(curChangeMode=='2' || curChangeMode=='3' || (curChangeMode=='4' && adaptResult=='1'))
					{
						document.getElementById("MdyPwdApply1").disabled=false; 
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#56B2F8";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
						document.getElementById("MdyPwdApply1").style.Color = "#FFFFFF";
					}
					else
					{
						document.getElementById("MdyPwdApply1").disabled=true;  
						document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
						document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
					}
				}
			}
			if(($("input[name=CMode]:checked").attr("id")) == '6')
			{
				if(curChangeMode=='4')
				{
					document.getElementById("MdyPwdApply1").disabled=true;	
					document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
					document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
				}
				else
				{
					document.getElementById("MdyPwdApply1").disabled=false;	
					document.getElementById("MdyPwdApply1").style.backgroundColor = "#56B2F8";
					document.getElementById("MdyPwdApply1").style.borderColor = "#CCCCCC";
					document.getElementById("MdyPwdApply1").style.Color = "#FFFFFF";
				}
			}
		});
	});
	function showwifimode(){
		switch($("input[name=CMode]:checked").attr("id")){
			case "1":
			document.getElementById("MdyPwdApply").disabled=false;
			break;
			case "2":
			document.getElementById("MdyPwdApply").disabled=false;
			break;
			case "3":
			document.getElementById("MdyPwdApply").disabled=false;
			break;
			case "4":
			document.getElementById("MdyPwdApply1").disabled=false;					
			break;  
			case "5":
			document.getElementById("MdyPwdApply1").disabled=false;
			break;  
			case "6":
			document.getElementById("MdyPwdApply1").disabled=false;
			break;                                  
			default:break;
		}
	}
	
	function showconfirm()
	{
		if(($("input[name=CMode]:checked").attr("id"))=='1' || ($("input[name=CMode]:checked").attr("id"))=='2' || ($("input[name=CMode]:checked").attr("id"))=='3' || ($("input[name=CMode]:checked").attr("id"))=='4' || ($("input[name=CMode]:checked").attr("id"))=='5' || ($("input[name=CMode]:checked").attr("id"))=='6')
		{
			var cmbln = window.confirm(framedesinfo["mainpage028"]);
		}
		if (cmbln == true)
		{
			document.getElementById('alert_box').style.display = "block";
			document.getElementById('alert_box1').style.display = "block";

			document.getElementById('cmodetitle').style.display = "none";
			document.getElementById('cmodetitle1').style.display = "none";
			document.getElementById('cmodecontent').style.display = "none";
			document.getElementById('cmbutton').style.display = "none";
			document.getElementById('cmbutton1').style.display = "none";
			document.getElementById('aprepcontent').style.display = "none";
			if(AdaptExist == 0)
			{
				$("#alert_box1").css("margin-top", "150px");
			}
			ModeChangeState();
			document.getElementById("MdyPwdApply").disabled=true;
			document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
			document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";
			document.getElementById("cmimageclose").disabled=true;
			document.getElementById("MdyPwdcancel").disabled=true;  
			document.getElementById("1").disabled=true; 
			document.getElementById("2").disabled=true; 
			document.getElementById("3").disabled=true; 
			document.getElementById("4").disabled=true;
			document.getElementById("5").disabled=true;
			document.getElementById("6").disabled=true;
		}
		else
		{   
			document.getElementById("MdyPwdApply").disabled=true;
			document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
			document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";
			
			document.getElementById("MdyPwdApply1").disabled=true;
			document.getElementById("MdyPwdApply1").style.backgroundColor = "#bbbbbb";
			document.getElementById("MdyPwdApply1").style.borderColor = "#bbbbbb";
			document.getElementById("6").disabled=false;
			document.getElementById("5").disabled=false;
			document.getElementById("4").disabled=false;
			if(curChangeMode=='1')
			{
				document.getElementById("5").checked=true;
				document.getElementById("5").disabled=false;
			}
			else if(curChangeMode=='2' || curChangeMode=='3')
			{
				document.getElementById("4").checked=true;
				document.getElementById("4").disabled=false;
			}
			else if(curChangeMode=='4' )
			{
				document.getElementById("6").checked=true;
				document.getElementById("6").disabled=false;
			}
		}
	}
	function ModeChangeState()
	{
		if(($("input[name=CMode]:checked").attr("id"))=='1' || ($("input[name=CMode]:checked").attr("id"))=='5')
		{   
			curChangeMode = '1';
		}
		else if(($("input[name=CMode]:checked").attr("id"))=='2')
		{   
			curChangeMode = '2';
		}
		else if(($("input[name=CMode]:checked").attr("id"))=='3')
		{   
			curChangeMode = '3';
		}
		else if(($("input[name=CMode]:checked").attr("id"))=='4')
		{
			var PrevChangeMode = curChangeMode;
			if(3 == aprepeater)
			{
				curChangeMode = '2';
			}
			else if(8 == aprepeater)
			{
				curChangeMode = '3';
			}
			if(1 == aprepEnable && 4 == PrevChangeMode)
			{
				curChangeMode = '3';
			}
		}
		else if(($("input[name=CMode]:checked").attr("id"))=='6')
		{	
			curChangeMode = '4';
		}
		DiagnoseToken = HWGetToken();
		
		$.ajax({
                type : "POST",
                async : true,
                cache : false,
				data : "cmode=" + curChangeMode + "&x.X_HW_Token=" + DiagnoseToken,
				url : "apmodechange.cgi?&RequestFile=index.asp",
            	success : function(data) {			
                }
                });
	}   
	
	ParseBindTextByTagName(framedesinfo, "span", 1);
	ParseBindTextByTagName(framedesinfo, "td", 1);
	ParseBindTextByTagName(framedesinfo, "div", 1);
	ParseBindTextByTagName(framedesinfo, "input", 2);

</script>

    <div class="blackBackgroundBlock" id="indexblackBackground" style="display:none;"></div>
    <div class="blackBackgroundBlock" id="alertblackBackground" style="z-index:301;display:none;">
        <div id="alertFrom" class="alertpopupegvdf">
            <div class="alerttext"><span id="alertspan"></span></div>
            <div class="alertpop"><input id="alertbtn" type="button" value="OK" onclick="doOk('alertblackBackground')" class="button button-apply W100"/></div>
        </div>
    </div>
    <div class="blackBackgroundBlock" id="confirmblackBackground" style="z-index:301;display:none;">
        <div id="confirmFrom" class="alertpopupegvdf">
            <p class="title"><span id="confirmtitle"></span></p>
            <div class="alerttext"><span id="confirmspan"></span></div>
            <div class="confirmpop">
                <input id="confirmokbtn" type="button" value="Apply" onclick="" class="button button-apply W100"/>
                <input id="confirmnobtn" type="button" value="Cancel" onclick="doOk('confirmblackBackground')" class="button button-cancel W100"/>
            </div>
        </div>
    </div>
    <div class="blackBackgroundBlock" id="staticprogressblackBackground" style="z-index:301;display:none;">
        <div id="staticprogressFrom" class="alertpopupegvdf">
            <p class="title"><span id="staticprogresstitle"></span></p>
            <div class="alerttext"><span id="staticprogressspan"></span></div>
            <div class="row"></div>
        </div>
    </div>
    <script language="javascript" src="/html/bbsp/common/getWanDynamicData.asp"></script>
</body>
<script type="text/javascript"> 
function sucessSub(){
    doOk("confirmblackBackground");
    document.getElementById("menuIframe").contentWindow.sucessSub();
}

function sucessNext() {
    doOk("confirmblackBackground");
    document.getElementById("menuIframe").contentWindow.sucessNext();
}

function doOk(id) {
    document.getElementById(id).style.display = "none";
}      

var Firststr = '<div id="MenuFirstLineSpace"><div id="MenuFirstLineIcon"></div><div id="MenuFirstLineMid"></div><div id="MenuFirstLineSpaceborder"></div></div>';

var menulist = [];
var activeMenuId = null;

function stMenuData(id, path, level, defico, clickico, url, defchild)
{
    this.id         = id;
    this.path       = ((path == '') ? '' : (path + '.')) + id;
    this.level      = level;
    this.defico     = defico;
    this.clickico   = clickico;
    this.url        = url;
    this.defchild   = defchild;
    this.hasChild   = false;
}

function setLv1MenuStyle(id, flag, ifOnlyChangeStyle)
{
    var menu = menulist[id];

    if (flag)
    {
        //change menu style
        $("#"         + id).addClass("menuContentActive");
        $("#name_"    + id).addClass("menuContTitleActive");
        $("#pointer_" + id).addClass("menuContPointerActive");
        $("#icon_"    + id).css("background", "url( " + menu.clickico + ") no-repeat center");

        if ((ifOnlyChangeStyle != null) && (ifOnlyChangeStyle == "onlyshow"))
            return menu;

        //show default sub-menu
        if ((menu.defchild != menu.id) //default menu is not menu its self, activate sub-menu
            && menu.hasChild)
        {
            return setLv2MenuStyle(menu.defchild, flag); //activate default sub-menu;
        }
    }
    else
    {
        //change menu style
        $("#"         + id).removeClass("menuContentActive");
        $("#name_"    + id).removeClass("menuContTitleActive");
        $("#pointer_" + id).removeClass("menuContPointerActive");
        $("#icon_"    + id).css("background", "url( " + menu.defico + ") no-repeat center");
    }
    return menu;
}

function setLv2MenuStyle(id, flag, ifOnlyChangeStyle)
{
    var menu = menulist[id];
    var parentId = menu.path.split('.')[0];

    if (flag)
    {
        //change parent menu style
        setLv1MenuStyle(parentId, flag, "onlyshow");
        //change menu style of itself
        if (!menu.hasChild) $("#name_" + id).addClass("SecondMenuTitleActive");

        if ((ifOnlyChangeStyle != null) && (ifOnlyChangeStyle == "onlyshow"))
            return menu;

        //show default sub-menu
        if ((menu.defchild != menu.id) //default menu is not menu its self, activate sub-menu
            && menu.hasChild)
        {
            //change menu pointer style
            $("#pointer_" + id).removeClass("SecondMenuPointer");
            $("#pointer_" + id).addClass("SecondMenuPointerBlock");
            return setLv3MenuStyle(menu.defchild, flag); //activate default sub-menu;
        }
        else
        {
            //change menu pointer style
            $("#pointer_" + id).removeClass("SecondMenuPointerBlock");
            if (menu.hasChild)
                $("#pointer_" + id).addClass("SecondMenuPointer");
            else
                $("#pointer_" + id).addClass("SecondMenuNullPointer");
        }
    }
    else
    {
        //change menu style
        $("#name_" + id).removeClass("SecondMenuTitleActive");
        //change menu pointer style
        $("#pointer_" + id).removeClass("SecondMenuPointerBlock");
        if (menu.hasChild)
            $("#pointer_" + id).addClass("SecondMenuPointer");
        else
            $("#pointer_" + id).addClass("SecondMenuNullPointer");
    }
    return menu;
}

function setLv3MenuStyle(id, flag)
{
    var menu = menulist[id];

    if (id == "")
    {
        id="menuid_3";
    }

    if (flag)
    {
        var parentId = menu.path.split('.')[1];
        //change parent menu style
        setLv2MenuStyle(parentId, flag, "onlyshow");
        //change menu style
        $("#"+id).addClass("ThirdMenuTitleActive")
    }
    else
    {
        //change menu style
        $("#"+id).removeClass("ThirdMenuTitleActive")
    }
    return menu;
}

function activeMenuStyle(id)
{
    var menu = menulist[id];

    if (menu == null)
        return null;

    var ids = menu.path.split('.');
    switch(menu.level)
    {
        case 3:
            menu = setLv3MenuStyle(ids[2], true); //set style of lv3 menu and parent lv2 & lv1 menu
            break;
        case 2:
            menu = setLv2MenuStyle(ids[1], true); //set style of lv2 menu and parent lv1 menu, active default lv3 menu
            break;
        default:
            menu = setLv1MenuStyle(ids[0], true); //set style of lv1 menu style, active default lv2 or lv3 menu
            break;
    }
    return menu;
}

function deactiveMenuStyle(id)
{
    var menu = menulist[id];

    if (menu == null)
        return ;

    var ids = menu.path.split('.');
    switch(menu.level)
    {
        case 3:
            setLv3MenuStyle(ids[2], false); //reset lv3 menu style
        case 2:
            setLv2MenuStyle(ids[1], false); //reset lv2 menu style
        default:
            setLv1MenuStyle(ids[0], false); //reset lv1 menu style
    }
}

function changeCrossLvMenuStyle(oldId, newId)
{
    if ((curUserType == '1') && (CfgMode.toUpperCase() == 'COCLAROEBG4')) {
        expandFirstMenuTitle(false);
    }
    var oldMenu = menulist[oldId];
    var newMenu = menulist[newId];

    if ((TedataGuide == 1) && (curUserType != '0') && (activeMenuId == null) && (oldMenu == null)) {
        oldMenu = new stMenuData("", "", 1, "", "", "", "");
    }

    if ((oldMenu == null) || (newMenu == null)) { //page loaded for the first time
        if ((curUserType == '1') && (CfgMode.toUpperCase() == 'COCLAROEBG4')) {
            $("#SecondMenuInfo").removeClass("Menuhide");
            $("#Systeminfo_subMenus").removeClass("Menuhide");
        }
        return;
    }

    if (oldMenu.level == newMenu.level) //check whether its parent menu is the same or not
    {
        switch(oldMenu.level)
        {
            case 3:
                var lv2id_o = oldMenu.path.split('.')[1];
                var lv2id_n = newMenu.path.split('.')[1];
                if (lv2id_o != lv2id_n) //different parent, change lv3 menu list
                {
                    $("#" + lv2id_o + "_menu").addClass("Menuhide");
                    $("#" + lv2id_n + "_menu").removeClass("Menuhide");
                }
                else //same parent, change lv2 parent pointer style, because it has been deactivated
                {
                    $("#pointer_" + lv2id_n).removeClass("SecondMenuPointer");
                    $("#pointer_" + lv2id_n).addClass("SecondMenuPointerBlock");
                }
            case 2:
                var lv1id_o = oldMenu.path.split('.')[0];
                var lv1id_n = newMenu.path.split('.')[0];
                if (lv1id_o != lv1id_n)
                {
                    $("#" + lv1id_o + "_subMenus").addClass("Menuhide");
                    $("#" + lv1id_n + "_subMenus").removeClass("Menuhide");
                }
            default:
                break;
        }
    }
    else if (oldMenu.level < newMenu.level)
    {
        //change from upper level to lower level
        var lv1id_n = newMenu.path.split('.')[0];
        var lv1id_o = oldMenu.path.split('.')[0];

        //show lv2 menu list
        if (lv1id_o != lv1id_n)
            $("#" + lv1id_o + "_subMenus").addClass("Menuhide");
        $("#" + lv1id_n + "_subMenus").removeClass("Menuhide");
        $("#SecondMenuInfo").removeClass("Menuhide");
        $("#SecondMenuInfo").addClass("Menushow");
        if (newMenu.level > 2)
        {
            var lv2id = newMenu.path.split('.')[1];
            //show lv3 menu list
            $("#" + lv2id + "_menu").removeClass("Menuhide");
        }
        if (oldMenu.level < 2)
        {
            //collapse lv1 menu list
            expandFirstMenuTitle(false);
        }
    }
    else
    {
        //change from lower level to upper level
        if (oldMenu.level > 2)
        {
            var lv2id = oldMenu.path.split('.')[1];
            //hide lv3 menu list
            $("#"+lv2id+"_menu").addClass("Menuhide");
        }

        if (newMenu.level < 2)
        {
            var lv1id = oldMenu.path.split('.')[0];
            //hide lv2 menu list
            $("#" + lv1id + "_subMenus").addClass("Menuhide");
            $("#SecondMenuInfo").removeClass("Menushow");
            $("#SecondMenuInfo").addClass("Menuhide");
            //expand lv1 menu list
            expandFirstMenuTitle(true);
        }
        else
        {
            var lv1id_o = oldMenu.path.split('.')[0];
            var lv1id_n = newMenu.path.split('.')[0];
            if (lv1id_o != lv1id_n)
            {
                $("#" + lv1id_o + "_subMenus").addClass("Menuhide");
                $("#" + lv1id_n + "_subMenus").removeClass("Menuhide");
            }
        }
    }
}
function onMenuChange1(id,url)
{

    toggleQRCodeDisplay('none');

    if (!ifCanChangeMenu())
    {
        return;
    } else {
        if (ajaxInfo) {
		    ajaxInfo.abort()
	    }
    }

    if (activeMenuId != null)
    {
        deactiveMenuStyle(activeMenuId);
    }

    var menu = activeMenuStyle(id);

    changeCrossLvMenuStyle(activeMenuId, menu.id);

    if (menu != null)
        $("iframe#menuIframe").attr("src", url);

    activeMenuId = menu.id;
}

function onMenuChange(id)
{
    toggleQRCodeDisplay('none');

    if (!ifCanChangeMenu())
    {
        return;
    } else {
        if (ajaxInfo) {
		    ajaxInfo.abort()
	    }
    }

    if (activeMenuId != null)
    {
        deactiveMenuStyle(activeMenuId);
    }

    var menu = activeMenuStyle(id);

    changeCrossLvMenuStyle(activeMenuId, menu.id);

    if (menu != null)
        $("iframe#menuIframe").attr("src", menu.url);

    activeMenuId = menu.id;
}

function setParentDefchild(parentId, id)
{
    var menu = menulist[parentId];
    if ((menu != null)
        /*&& (menu.url == null)*/
        && (menu.defchild == parentId))
    {
        menu.defchild = id;
    }
}

/*create level-3 menus*/
function CreateThirdMenu(htmlTagId, parentId, parentPath, subMenus)
{
    var m3contain = document.getElementById(htmlTagId);

    for (var i in subMenus)
    {
        var id = subMenus[i].id;
        if (xdPonSupport == 1 && menuNeedHideOrNot(subMenus[i].name)) {
            continue;
        }
        if ((CfgMode.toUpperCase() == 'COCLAROEBG4') && (curUserInfoStatus == "2") && (subMenus[i].name == "Account Management")) {
            continue;
        }
        menulist[id] = new stMenuData(id, parentPath, 3,
                                      subMenus[i].deficon,
                                      subMenus[i].clickicon,
                                      subMenus[i].url, id);
        
        var m3namesr = GetIdByUrl("m3div",subMenus[i].url);
        var m3title = document.createElement("div");
        m3title.id = id;
        //m3title.name = m3namesr;
        m3title.setAttribute('name',m3namesr);
        var Menu3NameStrValue = subMenus[i].name;

        m3title.className = "ThirdMenuTitle";

        
        m3title.onclick   = function(){ onMenuChange(this.id); }
        GetMenuTitle(subMenus[i].name, "third", m3title);
        var str = GetMenuStr(subMenus[i].name, "second");
        var txt = document.createTextNode(str.replace(/&nbsp;/g," "));
        m3title.appendChild(txt);
        m3contain.appendChild(m3title);

        if (i == 0)
        {
            setParentDefchild(parentId, id);
        }
    }
}

/*create level-2 menus*/
function CreateSecondMenu(parentId, parentPath, subMenus)
{
    var m2list = document.getElementById("SecondMenuInfo");
    var m2contain = document.createElement("div");
    
    m2contain.id = parentId + "_subMenus";
    m2contain.className = "Menuhide";
    m2list.appendChild(m2contain);

    for (var i in subMenus)
    {
        var id = subMenus[i].id;
        if (xdPonSupport == 1 && menuNeedHideOrNot(subMenus[i].name)) {
            continue;
        }
        menulist[id] = new stMenuData(id, parentPath, 2,
                                      subMenus[i].deficon,
                                      subMenus[i].clickicon,
                                      subMenus[i].url, id);

        var m2namesr = GetIdByUrl("m2div",subMenus[i].url);
        var m2menu = document.createElement("div");
        //m2menu.name = m2namesr;
        m2menu.setAttribute('name',m2namesr); 
        m2menu.id = id;
        m2menu.className = "SecondmenuContent";
        m2menu.onclick   = function() { onMenuChange(this.id); }
        m2contain.appendChild(m2menu);
        var m2title = document.createElement("div");
        m2title.id = "name_"+id;
        var MenuNameStrValue = subMenus[i].name;
        if(1 == MenuModeVDF)
        {
            if(MenuNameStrValue.length > 22)
            {
                m2title.className = "SecondMenuTitleChangeLine";
            }
            else if(MenuNameStrValue.length > 20
                    && subMenus[i].subMenus != undefined)
            {
                m2title.className = "SecondMenuTitleChangeLine";
            }
            else
            {
                m2title.className = "SecondMenuTitle";
            }
        }
        else
        {
            m2title.className = "SecondMenuTitle";
        }
        
        GetMenuTitle(subMenus[i].name, "second", m2title);
        var str = GetMenuStr(subMenus[i].name, "second");
        if (CfgMode.toUpperCase() == 'TTNET2') {
            str = str.replace(/&amp;/g, "&");
        }
        var txt = document.createTextNode(str.replace(/&nbsp;/g," "));
        m2title.appendChild(txt);
        m2menu.appendChild(m2title);
        var m2pointer = document.createElement("div");
        m2menu.appendChild(m2pointer);
        m2pointer.id = "pointer_" + id;

        if (subMenus[i].subMenus != undefined)
        {
            m2pointer.className = "SecondMenuPointer";
            m2children = document.createElement("div");
            m2children.id = id + "_menu";
            m2children.className = "Menuhide";
            m2contain.appendChild(m2children);
            CreateThirdMenu(m2children.id, id, menulist[id].path, subMenus[i].subMenus);
            menulist[id].hasChild = true;
        }
        else
        {
            m2pointer.className = "SecondMenuNullPointer";
        }

        if (i == 0)
        {
            setParentDefchild(parentId, id);
        }
    }
}
function menuNeedHideOrNot(menuName) {
    var xdUpHideMenus = ["ONT Authentication"];
    var ponUpHideMenus;
    if (CfgMode.toUpperCase() == 'DAUM2WIFI') {
        ponUpHideMenus = ["DSL Information", "Configure Data Card", "IPv6 Firewall Configuration", "IPv6 Address Filtering"];
    } else {
        ponUpHideMenus = ["DSL", "Mobile", "IPv6 Firewall", "IPv6 Filtering"];
    }

    if (CurrentUpMode == 1) {
        for (var i = 0; i < ponUpHideMenus.length; i++) {
            if (ponUpHideMenus[i]==menuName) {
                return true;
            }
        }
    } else {
        for (var i = 0; i < xdUpHideMenus.length; i++) {
            if (xdUpHideMenus[i]==menuName) {
                return true;
            }
        }
    }
}

/*create level-1 menus*/
for(var FirstMenuindex in menuJsonData)
{
    var m1namesr = GetIdByUrl("m1div",menuJsonData[FirstMenuindex].url);
    var id = menuJsonData[FirstMenuindex].id;
    Firststr += '<div class="menuContent" id=' + id + ' onclick="onMenuChange(this.id);">';

    Firststr +='<div class="FirstMenuIcon" id="icon_' + id + '" style="background: url(' + menuJsonData[FirstMenuindex].deficon + ') no-repeat center"></div>';
    Firststr +='<div class="menuContTitle" id="name_' + id + '" name="' + m1namesr + '"'+ GetMenuTitle(menuJsonData[FirstMenuindex].name, "first") + '>'
             + GetMenuStr(menuJsonData[FirstMenuindex].name, "first")
             + '</div>';
    Firststr +='<div class="menuContPointer menuContPointerdef" id="pointer_' + id + '"></div>';
    Firststr +='</div>';
    menulist[id] = new stMenuData(id, '', 1,
                                  menuJsonData[FirstMenuindex].deficon,
                                  menuJsonData[FirstMenuindex].clickicon,
                                  menuJsonData[FirstMenuindex].url, id);

    if(undefined != menuJsonData[FirstMenuindex].subMenus)
    {
        CreateSecondMenu(id, menulist[id].path, menuJsonData[FirstMenuindex].subMenus);
        menulist[id].hasChild = true;
    }
}
Firststr += '<div id="MenuBottomLineSpace"><div id="MenuBottomLineIcon"></div><div id="MenuBottomLineMid"></div><div id="MenuBottomLineSpaceborder"></div></div>';
$("#MenuInfo").append(Firststr);

ParseBindTextByTagName(framedesinfo, "span", 1);
ParseBindTextByTagName(framedesinfo, "div",  1);
document.getElementById('username').appendChild(document.createTextNode(UserName));

var UpgradeHeigthHandle = setInterval("adjustParentHeight();", 200);

var firstClickExpansion = "";
if (TedataGuide == 1 && isPageTurn == '1') {
    var tokenValue = HWGetToken();
    $.ajax({
        type : "POST",
        async : true,
        cache : false,
        data: "pageTurn=" + "0" + "&x.X_HW_Token=" + tokenValue,
        url : "SetPageTurnStatus.cgi?1=1&RequestFile=index.asp",
        success : function() {
        }
    });

    firstClickExpansion = menuJsonData[3].id;
    activeMenuId = "MainPage";
} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
    firstClickExpansion = menuJsonData[2].id;
    activeMenuId = menuJsonData[0].id;
} else {
    firstClickExpansion = menuJsonData[0].id;
}

$("#" + firstClickExpansion).trigger("click");

if (((CfgMode.toUpperCase() == 'TTNET2') || (pwdChangeNoticeFlag == 1)) && (IsModifiedPwd == 0) && (flagTips)) {
        flagTips = false;
        var accountUrl = "/html/ssmp/accoutcfg/account.asp"
        if (curUserType == sysUserType) {
            accountUrl = "/html/ssmp/accoutcfg/accountadmin.asp";
        }
        onMenuChange1("userconfig",accountUrl);
}
$("#AppDiv").click(function() {
    toggleQRCodeDisplay('auto');
});

$("#D2CodeIcon").click(function() {
    window.open(appUrl, "newwindow");
});

function getMenuStrDefLen(level)
{
    var length = 0;

    if (curLanguage.toUpperCase() == "CHINESE")
    {
        length = 8;
    }
    else if(curLanguage.toUpperCase() == "JAPANESE")
    {
        if (level == "first" )
        {
            length = 12;
        }
        else
        {
            length = 8;
        }
    }
    else
    {
        if (level == "first" )
        {
            length = 22;
        }
        else
        {
            length = 18;
        }
    }

    return length;
}

function GetMenuStr(datastr, level)
{
    if(1 == MenuModeVDF)
    {
        return datastr;
    }
    else
    {
        var length = getMenuStrDefLen(level);
        var MenuName = GetStringContentForTitle(datastr, length);
        return MenuName;
    }

}

function GetMenuTitle(datastr, level, element)
{
    if(1 == MenuModeVDF)
    {
        return;
    }
    
    var length = getMenuStrDefLen(level);
    var titlestr = "";
    if (datastr.length > length)
    {
        titlestr = ' title="' + datastr + '" ';
        if (element != null)
            element.setAttribute("title", datastr);
    }
    return titlestr;
}

function expandFirstMenuTitle(flag)
{
    var id;
    var action = ((flag == true) ? "block" : "none");

    $('#MenuFirstLineMid').css("display", action);
    $('#MenuBottomLineMid').css("display", action);

    for(var tmp in menulist)
    {
        if (menulist[tmp].level != 1) continue;
        id = "name_" + menulist[tmp].id;
        $('#' + id).css("display", action);
    }
}
</script>
</html>
