<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet" href='net_access_label/HYCuSong.css' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="/html/bbsp/common/wanipv6state.asp"></script>
<script language="Javascript" src="net_access_label/netaccesssign.js"></script>
<style type="text/css">
.width_66per {
    width: 66%;
}
</style>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/ssmp/deviceinfo/deviceinfo.cus);%>"></script>
<script language="JavaScript" type="text/javascript">

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var webPACertificateStatus='<%WEB_GetWebPACertificate();%>';
var DBAA1 = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>';
var showMonitorData = '<%HW_WEB_GetFeatureSupport(FT_SHOW_MONITOR_DATA);%>';
var isRTL = '<%HW_WEB_GetFeatureSupport(FT_IS_RTL_BOARD);%>';
var webSecureInfo = '<%HW_WEB_GetSecureInfo();%>';
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';

function stDeviceInfo(domain,SerialNumber,HardwareVersion,SoftwareVersion,ModelName,VendorID,ReleaseTime,Mac,Description,ManufactureInfo,DeviceAlias)
{
    this.domain                = domain;
    this.SerialNumber          = SerialNumber;
    this.HardwareVersion       = HardwareVersion;
    this.SoftwareVersion       = SoftwareVersion;
    this.ModelName             = ModelName;
    this.VendorID              = VendorID;
    this.ReleaseTime           = ReleaseTime;
    this.Mac                   = Mac;
    this.Description           = Description;
    this.ManufactureInfo       = ManufactureInfo;
    this.DeviceAlias           = DeviceAlias;
}

function gdgdDeviceInfo(domain,SerialNumber,HardwareVersion,SoftwareVersion,ModelName,VendorID,ReleaseTime,Mac,Description,ManufactureInfo,DeviceAlias,specsn)
{
    this.domain                = domain;
    this.SerialNumber          = SerialNumber;
    this.HardwareVersion       = HardwareVersion;
    this.SoftwareVersion       = SoftwareVersion;
    this.ModelName             = ModelName;
    this.VendorID              = VendorID;
    this.ReleaseTime           = ReleaseTime;
    this.Mac                   = Mac;
    this.Description           = Description;
    this.ManufactureInfo       = ManufactureInfo;
    this.DeviceAlias           = DeviceAlias;
    this.specsn                = specsn;
}

function aisApDeviceInfo(domain,SerialNumber,HardwareVersion,SoftwareVersion,ModelName,VendorID,ReleaseTime,Mac,
    Description,ManufactureInfo,DeviceAlias, reuseCycles, reuseStatus)
{
    this.domain                = domain;
    this.SerialNumber          = SerialNumber;
    this.HardwareVersion       = HardwareVersion;
    this.SoftwareVersion       = SoftwareVersion;
    this.ModelName             = ModelName;
    this.VendorID              = VendorID;
    this.ReleaseTime           = ReleaseTime;
    this.Mac                   = Mac;
    this.Description           = Description;
    this.ManufactureInfo       = ManufactureInfo;
    this.DeviceAlias           = DeviceAlias;
    this.reuseCycles           = reuseCycles;
    this.reuseStatus           = reuseStatus;
}

function ONTInfo(domain,ONTID,Status)
{
    this.domain = domain;
    this.ONTID  = ONTID;
    this.Status = Status;
}

function MonitorData(cpuUsedRate, ioWait, processNum, avgCpuLoad, totalMem, freeMem) {
    this.cpuUsedRate = cpuUsedRate;
    this.ioWait = ioWait;
    this.processNum = processNum;
    this.avgCpuLoad = avgCpuLoad;
    this.totalMem = totalMem;
    this.freeMem = freeMem;
}

function isFirst8VisibleChar(sn)
{
    if (
        ((sn.charAt(0) >= '2')&&(sn.charAt(0) <= '7'))
        &&((sn.charAt(2) >= '2')&&(sn.charAt(2) <= '7'))
        &&((sn.charAt(4) >= '2')&&(sn.charAt(4) <= '7'))
        &&((sn.charAt(6) >= '2')&&(sn.charAt(6) <= '7'))
       )
    {
        if (
            ((sn.charAt(0) == '7')&&(sn.charAt(1) == 'F'))
            ||((sn.charAt(2) == '7')&&(sn.charAt(3) == 'F'))
            ||((sn.charAt(4) == '7')&&(sn.charAt(5) == 'F'))
            ||((sn.charAt(6) == '7')&&(sn.charAt(7) == 'F'))
           )
        {
            return false;
        }
        return true;
    }
    return false;
}

function getMinus(a)
{
    if ( a > '9' )
    {
        if ( (a >= 'A') && (a <= 'F') )
        {
            return 55;
        }
        else
        {
            return 87;
        }
    }
    else
    {
        return 48;
    }
}

function conv16to12Sn(SerialNum)
{
    var charVid = "";
    var hexVid = "";
    var vssd = "";
    var i;

    hexVid = SerialNum.substr(0,8);
    vssd = SerialNum.substr(8,12);

    for(i=0; i<8; i+=2)
    {
        charVid += String.fromCharCode("0x"+hexVid.substr(i, 2));
    }

    return charVid+vssd;
}

var ontMatchOLTStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.ONT.MatchStatus);%>';
var ONTUserServices =  '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserServiceInfo.ServiceDescription);FT=HW_SSMP_FEATURE_MNGT_PCCW&USER=3%>';
var ontInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT,Ontid|State,ONTInfo);%>;
var ontEPONInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT,Ontid|State,ONTInfo);%>;
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var deviceInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|HardwareVersion|SoftwareVersion|ModelName|X_HW_VendorId|X_HW_ReleaseTime|X_HW_LanMac|Description|ManufactureInfo|X_HW_DeviceAlias, stDeviceInfo);%>;
if (CfgMode.toUpperCase() == 'GDGD2') {
	deviceInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|HardwareVersion|SoftwareVersion|ModelName|X_HW_VendorId|X_HW_ReleaseTime|X_HW_LanMac|Description|ManufactureInfo|X_HW_DeviceAlias|X_HW_SpecSn, gdgdDeviceInfo);%>;
}

if (CfgMode.toUpperCase() == 'AISAP') {
    var deviceInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|HardwareVersion|SoftwareVersion|ModelName|X_HW_VendorId|X_HW_ReleaseTime|X_HW_LanMac|Description|ManufactureInfo|X_HW_DeviceAlias|X_AIS_reuseCPE_cycles|X_AIS_reuseCPE_status, aisApDeviceInfo);%>;
}

var ontInfo = ontInfos[0];
var ontEPONInfo = ontEPONInfos[0];
var deviceInfo = deviceInfos[0];
var monitorDataArray = <%WEB_GetMonitorData();%>;
var monitorData = monitorDataArray[0];
var showCPUnMemUsed = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_SHOWCPUMEM);%>';
var cpuUsed = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_CpuUsed);FT=HW_SSMP_FEATURE_SHOWCPUMEM&USER=15%>%';
var memUsed = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_MemUsed);FT=HW_SSMP_FEATURE_SHOWCPUMEM&USER=15%>%';
var MngtPccw = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_PCCW);%>';
var MngtTelmex = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TELMEX);%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var IsDefaultPwd = '<%IsDefaultPwd();FT=HW_SSMP_FEATURE_WEBADMIN_EXIST&USER=2%>';
var IsModifiedPwd = '<%HW_WEB_GetWebUserMdFlag();%>';
var customizeDes = '<%HW_WEB_GetCustomizeDesc();%>';
var SN = deviceInfo.SerialNumber;
var sn = deviceInfo.SerialNumber;
var devAlias = deviceInfo.DeviceAlias;
var deviceTag = "<%HW_WEB_GetDeviceTag();%>";
var minus = 0;
var temp1 = 0;
var temp2 = 0;
var ParentalFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PARENTAL_CONTROL);%>';
var systemdsttime = '<%HW_WEB_GetSystemTime();%>';
var opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>'; 
var ontPonpwd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_PonHexPassword);%>'; 
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var TalkTalkFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var BaseInstFacKeyChgF = '<%HW_WEB_GetBaseInstFacKeyChgF();%>';
var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var IsPtVdfAP = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_VDFPTAP);%>";
var IsPtVdfb = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDFB);%>";
var isDeskCmap = '<%HW_WEB_GetFeatureSupport(FT_DESKCMCCAP_SUPPORT);%>';
var BaseInstFacKeyChgF2g = BaseInstFacKeyChgF.split(',')[0];
var BaseInstFacKeyChgF5g = BaseInstFacKeyChgF.split(',')[1];
var APwebGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_BRIDGE_WEB);%>';
var anteltype = '<%HW_WEB_GetFeatureSupport(FT_NORMAL_USER_NOGUIGE);%>';
var sonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>'; 
var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
var isNewMegacable = 0;

var APType ='<%HW_WEB_GetApMode();%>'; 
var Is8011_21V5 = "<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>";
var megacable = '<%HW_WEB_GetFeatureSupport(FT_SSMP_PWD_CHALLENGE);%>';
if (ProductType == '2') {
    var dev_uptime = '<%HW_WEB_GetOsUpTime();%>';
} else if (CfgMode.toUpperCase() == 'TELECENTRO') {
    var dev_uptime = '<%HW_WEB_GetOsUpTime();%>';
} else if(CfgMode.toUpperCase() == 'DU') {
    var dev_uptime = '<%HW_WEB_GetOsUpTime();%>';
} else {
    var dev_uptime = '<%HW_WEB_GetOsUpTime();FT=HW_SSMP_FEATURE_MNGT_TELMEX&USER=3%>';
}

var NatSessionInfo = '<%HW_WEB_GetNATSessionNum();%>';
var isDteDataFlag = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>";

if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI'))
{
    document.write('<link rel="shortcut icon" href="/images/Dzain.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dzain.ico" />');
}

function IsDTedata()
{
    if ((ProductType == '2') && (isDteDataFlag == 1)) {
        return true;
    }
    return false;
}

function IsOpticalNomal()
{
    return opticInfo != "--";
}

function ParseSystemTime(SystemTime)
{
    if(SystemTime == "")
    {
      SystemTime = "1970-01-01 01:01";
    }
    document.getElementById('td14_2').innerHTML = htmlencode(SystemTime);
}

if (isFirst8VisibleChar(sn) == true && (CfgMode.toUpperCase() != 'GDGD2') && !IsDTedata()) {
    SN = deviceInfo.SerialNumber + ' ' + '(' + conv16to12Sn(deviceInfo.SerialNumber) + ')';
}

if (CfgMode.toUpperCase() == 'GDGD2' && deviceInfo.specsn !='') {
    SN = deviceInfo.specsn;
}

if (((CfgMode.toUpperCase() == 'MEGACABLE') || (CfgMode.toUpperCase() == 'MEGACABLE2')) && (curUserType != 0)) {
    isNewMegacable = 1;
}
function SetUptime()
{

    dev_uptime++;
    var second = parseInt(dev_uptime);
    var dd = parseInt(second/(3600*24));
    var hh = parseInt((second%(3600*24))/3600);
    var mm = parseInt((second%3600)/60);
    var ss = parseInt(second%60);
    var strtime = "";

    if (dd <= 1)
    {
        strtime += dd + GetLanguageDesc("s020f");
    }
    else
    {
        strtime += dd + GetLanguageDesc("s0213");
    }

    if (hh <= 1)
    {
        strtime += hh + GetLanguageDesc("s0210");
    }
    else
    {
        strtime += hh + GetLanguageDesc("s0214");
    }

    if (mm <= 1)
    {
        strtime += mm + GetLanguageDesc("s0211");
    }
    else
    {
        strtime += mm + GetLanguageDesc("s0215");
    }

    if (ss <= 1)
    {
        strtime += ss + GetLanguageDesc("s0212");
    }
    else
    {
        strtime += ss + GetLanguageDesc("s0216");
    }
    getElById("ShowTime").innerHTML = htmlencode(strtime);
}

function shouldShowMonitorData()
{
    return (showMonitorData == '1') && (monitorData != null);
}

function HideDevicelias()
{
    if ((IsPtVdf == 1) || (IsPtVdfAP == 1) || (IsPtVdfb == 1) || (APwebGuideFlag == 1) ||
        ((APType == 1) && (Is8011_21V5 == 1) && (['VIETTELAP'].indexOf(CfgMode.toUpperCase()) == -1)) ||
        ((anteltype == 1) && (curUserType != 0))) {
        return true;
    }
    return false;
}

function LoadFrame()
{
    if (ProductType == '2')
    {
        document.getElementById('td6_2Row').style.display="none";
        document.getElementById('td8_2Row').style.display="none";
        document.getElementById('td14_2Row').style.display="none";

        if ((showCPUnMemUsed != 1) || shouldShowMonitorData())
        {
            document.getElementById('td9_2Row').style.display="none";
            document.getElementById('td10_2Row').style.display="none";
        }

        document.getElementById('td11_2Row').style.display="none";

        SetUptime();
        setInterval("SetUptime();", 1000);

        if((MngtTelmex != 1)||(curUserType == sysUserType))
        {
            if(IsModifiedPwd == 0 && curLanguage.toUpperCase() != 'CHINESE')
            {
                document.getElementById('DefaultNotice').style.display="";
            }
        }    
    }
    else
    {
        if (ontPonMode.toUpperCase() == 'WIFI' || ontPonMode.toUpperCase() == 'GE' || CfgMode.toUpperCase() == 'IPONLY' 
            || CfgMode.toUpperCase() == 'FORANET' || CfgMode.toUpperCase() == 'TDC' || CfgMode.toUpperCase() == 'TELIA')
        {

            document.getElementById('td7_2Row').style.display="none";
            document.getElementById('td8_2Row').style.display="none";
        }
    
        if ((CfgMode.toUpperCase() == 'TELMEXVULA') ||
            (CfgMode.toUpperCase() == 'TELMEXACCESS') ||
            (CfgMode.toUpperCase() == 'TELMEXACCESSNV') ||
            (CfgMode.toUpperCase() == 'TELMEXRESALE') ||
            (CfgMode.toUpperCase() == 'IPONLY') ||
            (CfgMode.toUpperCase() == 'FORANET')  ||
            (CfgMode.toUpperCase() == 'TDC') ||
            (CfgMode.toUpperCase() == 'TELIA')) {
            document.getElementById('td13_2Row').style.display="none";
        }
    
        if ( showCPUnMemUsed != 1
            || (MngtPccw == 1) )
        {
            document.getElementById('td9_2Row').style.display="none";
            document.getElementById('td10_2Row').style.display="none";
        }

        if ( MngtPccw != 1 )
        {
            document.getElementById('td11_2Row').style.display="none";
        }

        if(ontPonMode.toUpperCase() == 'EPON')
        {
            document.getElementById('td8_2Row').style.display="none";
        }

        if ((MngtTelmex != 1) && (CfgMode.toUpperCase() != 'TELECENTRO'))
        {
            document.getElementById('ShowTimeRow').style.display="none";
        }
        else
        {
            SetUptime();
            document.getElementById('td3_2').innerHTML=htmlencode(conv16to12Sn(deviceInfo.SerialNumber).toUpperCase());
            setInterval("SetUptime();", 1000);
        }
        if(IsDefaultPwd == 1 && curLanguage.toUpperCase() != 'CHINESE')
        {
            if ((CfgMode.toUpperCase() != 'TDE') && (CfgMode.toUpperCase() != 'TDEVRGW') && 
                (var_singtel == false) && (sonetFlag != 1)) {
                document.getElementById('DefaultNotice').style.display="";
            }
        }

        if (IsDefaultPwd == 1 && ('CTM' == CfgMode.toUpperCase()))
        {
            document.getElementById('DefaultNotice').style.display="";
        }
        if (CfgMode.toUpperCase()  == 'BJUNICOM')
        {
            //±±¾©jͨтѨȳ£¬ДʾCPU¡¢Ś´瑅Ϣ¡¢ՋӪʌхϢ
            //document.getElementById('td9_2Row').style.display="none";
            //document.getElementById('td10_2Row').style.display="none";
            document.getElementById('td16_2').innerHTML = DevInfoDes['s0228'];
        }
        else
        {
            document.getElementById('td15_2Row').style.display="none";
            document.getElementById('td16_2Row').style.display="none";
        }
		
		if (APwebGuideFlag == 1)
		{
		   document.getElementById('td6_2Row').style.display="none";
		   document.getElementById('td9_2Row').style.display="none";
           document.getElementById('td10_2Row').style.display="none";
		   document.getElementById('td13_2Row').style.display="none";
		}
    }
    
    var all = document.getElementsByTagName("td");
    for (var i = 0; i < all.length; i++)
    {
        var b = all[i];
        var c = b.getAttribute("BindText");
        if(c == null)
        {
            continue;
        }
        b.innerHTML = DevInfoDes[c];
    }

    if (ParentalFlag==1)
    {
        document.getElementById('td14_2Row').style.display="";
    }
    else
    {
        document.getElementById('td14_2Row').style.display="none";
    }
    if (TalkTalkFlag == 1)
    {
        var systime,splitdata,splittime,detildate,detiltime;
        systime = systemdsttime.split(" ");
        detildate = systime[0];
        detiltime = systime[1];
        splitdata = detildate.split("-");
        splittime = detiltime.split("+");
        systemdsttime = splittime[0] + " " + splitdata[2] + "/" + splitdata[1] + "/" + splitdata[0];
    }
    ParseSystemTime(systemdsttime);
    if ((CfgMode.toUpperCase() == "NOS2") || (CfgMode.toUpperCase() == "NOS")) {
        GetCertificateStatus();
    }
    setText("DevAlias", devAlias);
    if (CfgMode.toUpperCase()=="TALKTALK2WIFI" || IsDTedata() || (CfgMode.toUpperCase() == 'DICELANDVDF'))
    {
        document.getElementById('DefaultNotice').style.display="none";
    }
    if (1 == MngtTelmex && top.countNum == 0 )
    {
        var timeout = 500;    
        var TimerHandle = setTimeout("Alertwlancfg()", timeout);
    }
    if (HideDevicelias())
	{
	   document.getElementById('devicealias').style.display="none";
	}
	if (((CfgMode.toUpperCase()=="TELECOM2") || (CfgMode.toUpperCase()=="TELECOM")) && (curUserType != sysUserType))
	{
		document.getElementById('DevAlias').disabled=true;
		document.getElementById('apply').style.display="none";
	}
    if (CfgMode.toUpperCase() == 'DU') {
        SetUptime();
        setInterval("SetUptime();", 1000);
        document.getElementById('td14_2Row').style.display="";
        document.getElementById('ShowTimeRow').style.display="";
    }
    if (CfgMode.toUpperCase() == 'DMASMOVIL2WIFI') {
        setDisplay("dmasmovil-refresh", 1);
    } else {
        setDisplay("dmasmovil-refresh", 0);
    }
    if (shouldShowMonitorData()) {
        setDisplay("cpuinfo", 1);
        setDisplay("cpuinfo_spread", 1);
    }

    if (isSupportLte == 1) {
        getLteInfo();
        showLteInfo();
    }

    if (isNewMegacable == 1) {
        document.getElementById('td5_2Row').style.display="none";
    }

    if (isDeskCmap == "1") {
        setDeskCmccIPinfo();
    }

    if ((isRTL === '1') || (CfgMode.toUpperCase() === "BJUNICOM") || (CfgMode.toUpperCase() == "AISAP")) {
        setDisplay('ccsaInfo', 0);
    }

    if ((CfgMode.toUpperCase() == "TT2") && (curUserType != sysUserType)) {
        setDisplay('ccsaInfo', 0);
    }
}
function Alertwlancfg()
{
    top.countNum = 1;
    if (1 == DoubleFreqFlag)
    {
        if ((0 == BaseInstFacKeyChgF2g) && (0 == BaseInstFacKeyChgF5g))
        {
            AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change']);
        }
        else if ((0 == BaseInstFacKeyChgF2g) && (1 == BaseInstFacKeyChgF5g))
        {
            AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change_2G']); 
        }
        else if ((1 == BaseInstFacKeyChgF2g) && (0 == BaseInstFacKeyChgF5g))
        {
              AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change_5G']); 
        }
    }
    else
    {
        if (0 == BaseInstFacKeyChgF2g)
        {
              AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change']);   
        }    
    }
}

function GetLanguageDesc(Name)
{
    return DevInfoDes[Name];
}

function GetONTRegisterStatus()
{
    if (ontMatchOLTStatus == '1' && IsOpticalNomal())
    {
        if (true == var_singtel)
        {
            document.getElementById('td7_2').innerHTML = DevInfoDes['s1321a'];
        }
        else if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
		{
            document.getElementById('td7_2').innerHTML = DevInfoDes['s1321_xd'];
		}
		else
		{
            document.getElementById('td7_2').innerHTML = DevInfoDes['s1321'];
		}
    }
    else
    {
        if (ontPonMode.toUpperCase() == 'GPON')
        {
            if (ontInfo.Status == 'o1' || ontInfo.Status == 'O1')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1322'];
            }
            else if (ontInfo.Status == 'o2' || ontInfo.Status == 'O2')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1323'];
            }
            else if (ontInfo.Status == 'o3' || ontInfo.Status == 'O3')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1324'];
            }
            else if (ontInfo.Status == 'o4' || ontInfo.Status == 'O4')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1325'];
            }
            else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1326'];
            }
            else if (ontInfo.Status == 'o6' || ontInfo.Status == 'O6')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1327'];
            }
            else if (ontInfo.Status == 'o7' || ontInfo.Status == 'O7')
            {
                document.getElementById('td7_2').innerHTML = htmlencode(ontInfo.Status) + DevInfoDes['s1328'];
            }
        }
        else if (ontPonMode.toUpperCase() == 'EPON')
        {
            if (ontEPONInfo != null)
            {
                if(curLanguage.toUpperCase() == 'CHINESE')
                {
                    if ( "OFFLINE" == ontEPONInfo.Status)
                    {
                        document.getElementById('td7_2').innerHTML = GetLanguageDesc("s020b");
                    }
                    else if("ONLINE" == ontEPONInfo.Status)
                    {
                        document.getElementById('td7_2').innerHTML = GetLanguageDesc("s020c");
                    }
                    else
                    {
                        document.getElementById('td7_2').innerHTML = GetLanguageDesc("s020d");
                    }
                }
                else
                {
                    document.getElementById('td7_2').innerHTML = htmlencode(ontEPONInfo.Status);
                }

            }
            else
            {
                document.getElementById('td7_2').innerHTML = '';
            }
        }
        else
        {
            document.getElementById('td7_2').innerHTML = '';
        }
    }
}

function GetIMEI()
{
    if(CfgMode.toUpperCase()  == 'BYTEL')
    {
        document.getElementById('td17_2Colleft').innerHTML = DevInfoDes['s1613'];
        var strtmp = "00000000000000000000"+ontPonpwd;
        var IMEI = strtmp.substr(strtmp.length -15, strtmp.length -1);
        document.getElementById('td17_2').innerHTML = htmlencode(IMEI);
    }
    else
    {
        document.getElementById('td17_2Row').style.display="none";
    }
}

function GetSnOrMacInfo()
{
    if (ontPonMode.toUpperCase() == 'GPON')
    {
        document.getElementById('td3_2Colleft').innerHTML = DevInfoDes['s1611'];
    }
    else if (ontPonMode.toUpperCase() == 'EPON' || ontPonMode.toUpperCase() == 'GE' || ontPonMode.toUpperCase() == 'WIFI')
    {
        if (notSupportPON == 1) {
            document.getElementById('td3_2Colleft').innerHTML = DevInfoDes['s1611'];
        } else {
            document.getElementById('td3_2Colleft').innerHTML = DevInfoDes['s1612'];
        }

    }
    var  var_deviceMac = "";
    if (ontPonMode.toUpperCase() == 'GPON')
    {
        document.getElementById('td3_2').innerHTML = htmlencode(SN);
    }
    else if (ontPonMode.toUpperCase() == 'EPON' || ontPonMode.toUpperCase() == 'GE' || ontPonMode.toUpperCase() == 'WIFI')
    {
       if (CfgMode.toUpperCase()  == 'BJUNICOM')
       {
            var_deviceMac = deviceInfo.Mac.replace(/\:/g,"-");
            document.getElementById('td3_2').innerHTML = htmlencode(var_deviceMac);
       }
       else
       {
            if (notSupportPON == 1) {
                document.getElementById('td3_2').innerHTML = htmlencode(SN);
            } else {
                document.getElementById('td3_2').innerHTML = htmlencode(deviceInfo.Mac);
            }
       }
    }
}
function GetOntId()
{
    if (ontInfo != null)
    {
        document.getElementById('td8_2').innerHTML = htmlencode(ontInfo.ONTID);
    }
    else
    {
        document.getElementById('td8_2').innerHTML = '';
    }
}
function GetCpuUsed()
{
    if (cpuUsed != null)
    {
        document.getElementById('td9_2').innerHTML = htmlencode(cpuUsed);
    }
    else
    {
        document.getElementById('td9_2').innerHTML = '';
    }
}

function getManufactureInfo()
{
    if (deviceInfo.ManufactureInfo.length > 20)
    {
        return deviceInfo.ManufactureInfo.substring(0, 20);
    }
    return deviceInfo.ManufactureInfo;
}

function GetMemUsed()
{
    if (memUsed != null)
    {
        document.getElementById('td10_2').innerHTML = htmlencode(memUsed);
    }
    else
    {
        document.getElementById('td10_2').innerHTML = '';
    }
}

function GetNatSessionInfo() {
    if (NatSessionInfo != null) {
        document.getElementById('NatSessionNum').innerHTML = htmlencode(NatSessionInfo) + " ( Current / Maximum )";
    } else {
        document.getElementById('NatSessionNum').innerHTML = '';
    }
}

function GetCustomizeInfo()
{
    if (customizeDes != null)
    {
        document.getElementById('td13_2').innerHTML = htmlencode(customizeDes);
    }
    else
    {
        document.getElementById('td13_2').innerHTML = '';
    }
}
function GoToUserConfig()
{
    window.parent.onMenuChange("userconfig");
}
function OnApply()
{
	if (IsPtVdf == 1 || IsPtVdfAP == 1 || IsPtVdfb == 1)
	{
		return;
	}
	if (((CfgMode.toUpperCase()=="TELECOM2") || (CfgMode.toUpperCase()=="TELECOM")) && (curUserType != sysUserType))
	{
		return;
	}
    var alias = getValue("DevAlias");
    var Form = new webSubmitForm();
    var RequestFile = "html/ssmp/deviceinfo/deviceinfo.asp";
    Form.addParameter('x.X_HW_DeviceAlias', alias);
    url = 'set.cgi?x=InternetGatewayDevice.DeviceInfo'
        + '&RequestFile=' + RequestFile;
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    setDisable('apply',1);
    Form.setAction(url);
    Form.submit();
}

function OnRefresh() {
    window.location = "/html/ssmp/deviceinfo/deviceinfo.asp";
}

function GetCertificateStatus() {
    if (webPACertificateStatus == "0") {
        document.getElementById('td19_2').innerHTML = htmlencode(DevInfoDes['ss1318']);
    } else {
        document.getElementById('td19_2').innerHTML = htmlencode(DevInfoDes['ss1317']);
    }

}

function getInfoOfNull(srcInfo){
    var retInfo = ""
    if (srcInfo != null) {
        retInfo = srcInfo;
    }
    return retInfo;
}

var lteResult = '';

function getLteInfo() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "lteInfo.asp",
        success : function(data) {
            lteResult = dealDataWithFun(data);
        }
    });
}

function showLteInfo()
{
    if (lteResult[0] == null) {
        return;
    }

    document.getElementById('td18_2').innerHTML = htmlencode(lteResult[0].SoftVersion);
    document.getElementById('td20_2').innerHTML = htmlencode(lteResult[0].IMEI);
}

function GetIpv6AddrByMacId(macid) {
    var ipv6AddrList = GetIPv6AddressList(macid);
    var addr = "";
    for (var m = 0; m < ipv6AddrList.length; m++) {
        if (ipv6AddrList[m].Origin.toUpperCase() != "LINKLOCAL") {
            return ipv6AddrList[m].IPAddress;
        }
    }
    return "";
}

function setIPaddressInfo(wanInfo) {
    var wanIPstr = "";
    var ipv4addr = "";
    var ipv6addr = "";
    for (i = 0;i < wanInfo.length;i++) {
        if((wanInfo[i].ConnectionType == "IP_Routed") && (wanInfo[i].X_HW_SERVICELIST.indexOf("INTERNET") != -1)) {
            if ((wanInfo[i].ConnectionStatus=="Connected") && (wanInfo[i].IPv4Enable == "1")) {
                if (wanInfo[i].ExternalIPAddress != "") {
                    ipv4addr = wanInfo[i].ExternalIPAddress;
                }
            }

            if (wanInfo[i].IPv6Enable == "1") {
                var ipv6Wan = GetIPv6WanInfo(wanInfo[i].MacId);
                if (ipv6Wan.ConnectionStatus == "Connected") {
                    ipv6Addr = GetIpv6AddrByMacId(wanInfo[i].MacId);
                }
            }

            break;
        }
    }
    if ((ipv4addr != "") && (ipv6addr != "")) {
        wanIPstr = ipv4addr + "<br>" + ipv6addr;
    } else if (ipv4addr != "") {
        wanIPstr = ipv4addr;
    } else if (ipv6addr != "") {
        wanIPstr = ipv6addr;
    } else {
        wanIPstr = DevInfoDes["s0241"]
    }

    document.getElementById('td22_2').innerHTML = wanIPstr;
    var LanHostIPaddr = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.IPInterfaceIPAddress);%>';
    document.getElementById('td23_2').innerHTML = LanHostIPaddr;
}

function setDeskCmccIPinfo() {
    var wanInfo = new Array();

    $.ajax({
        context : this,
        type : "GET",
        async : true,
        cache : false,
        timeout : 5000,
        url : "/html/bbsp/common/get_wan_info_ap.asp",
        success : function(data) {
            wanInfo = dealDataWithFun(data);
            setIPaddressInfo(wanInfo);
        }
    });
}

function DownloadSecureInfo() {
    XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    Form.addParameter('logtype', "opt");
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('ccsadown.cgi?FileType=aplog&RequestFile=html/ssmp/deviceinfo/deviceinfo.asp');
    Form.submit();
}

</script>
</head>
<body  class="mainbody pageBg" onLoad="LoadFrame();">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("deviceinfoasp", GetDescFormArrayById(DevInfoDes, "s0200"), GetDescFormArrayById(DevInfoDes, "s0201"), false);
</script>
<div class="title_spread"></div>
<div BindText="s1619" class="func_title"></div>
<form id="deviceInfoForm" name="deviceInfoForm">
<table id="deviceInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<script>
    if (ProductType != '2')
    {
        document.write('<li id="td16_2" RealType="HtmlText" DescRef="s0227" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td16_2" InitValue="Empty" />');
    }
</script>
<li id="td1_2" RealType="HtmlText" DescRef="s0202" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td1_2" InitValue="Empty" />
<li id="td2_2" RealType="HtmlText" DescRef="s0203" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td2_2" InitValue="Empty" />
<script>
    if (ProductType == '2')
    {
        document.write('<li id="td3_2" RealType="HtmlText" DescRef="s1611" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td3_2" InitValue="Empty" />');
    }
    else
    {
        document.write('<li id="td3_2" RealType="HtmlText" DescRef="Empty" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td3_2" InitValue="Empty" />');
    }
    if (ProductType != '2')
    {
        document.write('<li id="td17_2" RealType="HtmlText" DescRef="Empty" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td17_2" InitValue="Empty" />');
    }
</script>
<li id="td4_2" RealType="HtmlText" DescRef="s0204" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td4_2" InitValue="Empty" />
<li id="td5_2" RealType="HtmlText" DescRef="s0205" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td5_2" InitValue="Empty" />
<script>
    if (CfgMode.toUpperCase() == 'AISAP') {
        document.write('<li id="td22_2" RealType="HtmlText" DescRef="s02051" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td22_2" InitValue="Empty" />');
    }

    if (CfgMode.toUpperCase() == 'ROSUNION') {
        document.write('<li id="td6_2" RealType="HtmlText" DescRef="s0217r" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td6_2" InitValue="Empty" />');
    } else {
        document.write('<li id="td6_2" RealType="HtmlText" DescRef="s0217" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td6_2" InitValue="Empty" />');
    }
    
    if (ProductType == '2')
    {
        document.write('<li id="td7_2" RealType="HtmlText" DescRef="s1612" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td7_2" InitValue="Empty" />');
    }
    else
    {
        document.write('<li id="td7_2" RealType="HtmlText" DescRef="s0206" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td7_2" InitValue="Empty" />');    
    }

	if((ProductType == '2') && (curLanguage.toUpperCase() == 'ARABIC'))
	{
		document.write('<li id="td8_2" RealType="HtmlText" DescRef="s0207_xd" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td8_2" InitValue="Empty" />');
	}
	else
	{
		document.write('<li id="td8_2" RealType="HtmlText" DescRef="s0207" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td8_2" InitValue="Empty" />'); 
	}
</script>
<script>
    if (isSupportLte == 1) {
        document.write('<li id="td18_2" RealType="HtmlText" DescRef="s0237" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td18_2" InitValue="Empty" />');
        document.write('<li id="td20_2" RealType="HtmlText" DescRef="s0238" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td20_2" InitValue="Empty" />');
    }
</script>
<li id="td9_2" RealType="HtmlText" DescRef="s0208" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td9_2" InitValue="Empty" />
<li id="td10_2" RealType="HtmlText" DescRef="s0209" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td10_2" InitValue="Empty" />
<script language="JavaScript" type="text/javascript">
    if (CfgMode.toUpperCase() == 'DMASMOVIL2WIFI') {
        document.write('<li id="NatSessionNum" RealType="HtmlText" DescRef="mu209_dmasmovil" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="NatSessionNum" InitValue="Empty" />');
    }
</script>
<li id="td11_2" RealType="HtmlText" DescRef="s020a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td11_2" InitValue="Empty" />
<script language="JavaScript" type="text/javascript">
    if (CfgMode.toUpperCase() == 'TELECENTRO') {
        document.write('<li id="ShowTime" RealType="HtmlText" DescRef="s021a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ShowTime" InitValue="Empty" />');
    } else if(CfgMode.toUpperCase() == 'DU') {
        document.write('<li id="ShowTime" RealType="HtmlText" DescRef="s021a" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ShowTime" InitValue="Empty" />');
	} else {
        document.write('<li id="ShowTime" RealType="HtmlText" DescRef="s020e" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ShowTime" InitValue="Empty" />');
    }
</script>
<li id="td13_2" RealType="HtmlText" DescRef="s0225" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td13_2" InitValue="Empty" />
<li id="td14_2" RealType="HtmlText" DescRef="s0226" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td14_2" InitValue="Empty" />
<script>
    if (ProductType != '2')
    {
        document.write('<li id="td15_2" RealType="HtmlText" DescRef="s1615" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td15_2" InitValue="Empty" />');
    }
    if (DBAA1 == '1') {
        document.write('<li id="td21_2" RealType="HtmlText" DescRef="ss1319" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td21_2" InitValue="Empty" />');
    }
</script>
<script>
    if ((CfgMode.toUpperCase() == "NOS2") || (CfgMode.toUpperCase() == "NOS")) {
        document.write('<li id="td19_2" RealType="HtmlText" DescRef="ss1316" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ss1316" InitValue="Empty" />');
    } 
    if (isDeskCmap == "1") {
        document.write('<li id="td22_2" RealType="HtmlText" DescRef="s0239" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td22_2" InitValue="Empty" />');
        document.write('<li id="td23_2" RealType="HtmlText" DescRef="s0240" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td23_2" InitValue="Empty" />');
    }
</script>
</table>
<script>
var TableClass = new stTableClass("width_per25", "table_right align_left","ltr");
var deviceInfoFormList = new Array();
deviceInfoFormList = HWGetLiIdListByForm("deviceInfoForm",null);
if(typeof(DeviceinfoReload) == "undefined")
{
    DeviceinfoReload = null;
}
HWParsePageControlByID("deviceInfoForm",TableClass,DevInfoDes,DeviceinfoReload);
var netAccessSign = "<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.SMP.NASN.Id);%>".split(",");
var permissionIdentifier = netAccessSign[0];
if (curLanguage.toUpperCase() == 'CHINESE' && CfgMode.toUpperCase() != 'AMCTMDESKAP' && permissionIdentifier != 0 && typeof(getPathImage) != "undefined") {
    var deviceModel = netAccessSign[1];
    var digitalEncoding = netAccessSign[2];
    var pathImage = getPathImage(permissionIdentifier);
    var pathImageStr = '<img src=net_access_label/' + pathImage + '.png>';
    var deviceModelStr = '<p class=' + getDeviceModel(deviceModel.length) + '>' + deviceModel + '</p>';
    var digitalEncodingStr = '<p class="digital-encoding">' + digitalEncoding + '</p>';
    var netaccesssignstr = document.createElement('tr');
    netaccesssignstr.style.height="0px";
    netaccesssignstr.innerHTML =
            '<td>' +
            '<div style="position:absolute; right:0px; bottom:11px; padding-right:20px">' +
            pathImageStr +
            "<div>" +
            deviceModelStr +
            "</div>" +
            "<div>" +
            digitalEncodingStr +
            "</div>" +
            "</div>" +
            "</td>"
    var table_netaccesssign = document.getElementById("TabledeviceInfoForm").firstChild;
    table_netaccesssign.append(netaccesssignstr);
    document.getElementById("TabledeviceInfoForm").style.position='relative';
}

if (CfgMode.toUpperCase() == 'AOUNITEL') {
    document.getElementById('td1_2').innerHTML = 'ONT UNITEL NET CASA';
    document.getElementById('td2_2').innerHTML = 'ONT & HOME GATEWAY (' + htmlencode(deviceInfo.ModelName) + ')';
} else {
    document.getElementById('td1_2').innerHTML = htmlencode(deviceInfo.ModelName);
    document.getElementById('td2_2').innerHTML = htmlencode(deviceInfo.Description);
}
if (CfgMode.toUpperCase() == 'AISAP') {
    document.getElementById('td22_2').innerHTML = htmlencode(deviceInfo.reuseCycles + '.' + deviceInfo.reuseStatus);
}

if (CfgMode.toUpperCase() == 'DSTCOACCESS') {
    setDisplay('td2_2Row', 0);
}

if (ProductType == '2')
{
    if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
        document.getElementById('td3_2Colleft').innerHTML = DevInfoDes['s1611_dzain'];
        document.getElementById('td3_2').innerHTML = htmlencode(getManufactureInfo());
    } else {
        document.getElementById('td3_2').innerHTML = htmlencode(SN);
    }
}
if (DBAA1 == '1') {
    document.getElementById('td21_2').innerHTML = htmlencode('<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.CurProfile.BondingProfile);%>');
}
if (ProductType != '2')
{
    GetSnOrMacInfo();
    GetIMEI();
}
document.getElementById('td4_2').innerHTML = htmlencode(deviceInfo.HardwareVersion);
document.getElementById('td5_2').innerHTML = htmlencode(deviceInfo.SoftwareVersion);
if (CfgMode.toUpperCase() == 'ROSUNION') {
	document.getElementById('td6_2').innerHTML = DevInfoDes['s1611'];
}
else
{
	document.getElementById('td6_2').innerHTML = htmlencode(deviceInfo.ManufactureInfo);
}
if (ProductType == '2')
{
    document.getElementById('td7_2').innerHTML = htmlencode(deviceInfo.Mac.toUpperCase());
}
else
{
    GetONTRegisterStatus();
    GetOntId();
}
GetCpuUsed();
GetMemUsed();

if (CfgMode.toUpperCase() == 'DMASMOVIL2WIFI') {
    GetNatSessionInfo();
}

if(CfgMode.toUpperCase() != 'SINGTEL' && CfgMode.toUpperCase() != 'SINGTEL2')
{
    GetCustomizeInfo();
}

if (ProductType != '2')
{
    document.getElementById('td11_2').innerHTML = htmlencode(ONTUserServices);
    document.getElementById('td15_2').innerHTML = htmlencode(deviceTag);
}
</script>
</form>
<div id="dmasmovil-refresh" style="display:none;">
    <table width="100%" height="30"> 
        <tr>
            <td class='title_bright1'>
                <button id="refresh" BindText="s1618_dmasmovil" class="ApplyButtoncss" type="button" onClick="OnRefresh();" enable=true  ></button>
            </td>
        </tr>
    </table> 
</div>
<div id="cpuinfo_spread" class="func_spread" style="display:none"></div>
<div id="cpuinfo" style="display:none;">
    <div class="func_title" bindText="s0236"></div>
    <form id="cpuInfoForm" name="cpuInfoForm">
        <table id="cpuInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
            <li id="cputd_1" RealType="HtmlText" DescRef="s0208" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_1" InitValue="Empty" />
            <li id="cputd_2" RealType="HtmlText" DescRef="s0231" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_2" InitValue="Empty" />
            <li id="cputd_3" RealType="HtmlText" DescRef="s0232" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_3" InitValue="Empty" />
            <li id="cputd_4" RealType="HtmlText" DescRef="s0233" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_4" InitValue="Empty" />
            <li id="cputd_5" RealType="HtmlText" DescRef="s0209" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_5" InitValue="Empty" />
            <li id="cputd_6" RealType="HtmlText" DescRef="s0234" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_6" InitValue="Empty" />
            <li id="cputd_7" RealType="HtmlText" DescRef="s0235" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="cputd_7" InitValue="Empty" />
        </table>
        <script>
            function getCpuRate(monitorData)
            {
                var cpuRateRaw = getInfoOfNull(monitorData.cpuUsedRate);
                if (cpuRateRaw != "") {
                    return cpuRateRaw + "%";
                }
                return "-";
            }
            function getIoWait(monitorData) {
                var ioWaitRaw = getInfoOfNull(monitorData.ioWait);
                if (ioWaitRaw != "") {
                    return Math.floor(ioWaitRaw * 100) + "%";
                }
                return "-";
            }
            function getTotalMemory(monitorData)
            {
                var totalMemoryRaw = getInfoOfNull(monitorData.totalMem);
                if (totalMemoryRaw != "") {
                    return Math.floor(totalMemoryRaw / 1024) + " KB";
                }
                return "-";
            }
            function getFreeMemory(monitorData)
            {
                var freeMemoryRaw = getInfoOfNull(monitorData.freeMem);
                if (freeMemoryRaw != "") {
                    return Math.floor(freeMemoryRaw / 1024) + " KB";
                }
                return "-";
            }
            HWParsePageControlByID("cpuInfoForm", TableClass, DevInfoDes, null);
            if (shouldShowMonitorData()) {
                setElementInnerHtmlById("cputd_1", getCpuRate(monitorData));
                setElementInnerHtmlById("cputd_2", getIoWait(monitorData));
                setElementInnerHtmlById("cputd_3", getInfoOfNull(monitorData.processNum));
                setElementInnerHtmlById("cputd_4", getInfoOfNull(monitorData.avgCpuLoad));
                setElementInnerHtmlById("cputd_5", getInfoOfNull(memUsed));
                setElementInnerHtmlById("cputd_6", getTotalMemory(monitorData));
                setElementInnerHtmlById("cputd_7", getFreeMemory(monitorData));
            }
        </script>
    </form>
</div>
<div id="ccsaInfo">
    <div class="func_spread"></div>
    <div class="func_title">
        <script>document.write(DevInfoDes['s3001'])</script>
    </div>
    <div>
        <table width="100%" cellpadding="0" cellspacing="0" class="tabal_noborder_bg">
            <tbody>
                <tr border="1">
                    <td class="table_title" style="width:160px;" id=""><script>document.write(DevInfoDes['s3002'])</script></td>
                    <td id="ccsaEnable" class="table_right align_left" style="width:500px;"></td>
                </tr>
                <tr border="1">
                    <td class="table_title" style="width:160px;" id=""><script>document.write(DevInfoDes['s3003'])</script></td>
                    <td class="table_right align_left" id="ccsaFirHash" style="width:500px;"></td>
                </tr>
                <tr border="1">
                    <td class="table_title" style="width:160px;" id=""><script>document.write(DevInfoDes['s3004'])</script></td>
                    <td class="table_right align_left" id="ccsaSecHash" style="width:500px;"></td>
                </tr>
                <tr border="1">
                    <td class="table_title" style="width:160px;" id=""><script>document.write(DevInfoDes['s3005'])</script></td>
                    <td id="td1_2" class="table_right align_left" style="width:500px;">
                        <button class="width_per25" id="" onclick="DownloadSecureInfo()"><script>document.write(DevInfoDes['s3006'])</script></button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<script>
    if ((isRTL !== '1') && (CfgMode.toUpperCase() !== "BJUNICOM")) {
        webSecureInfo = webSecureInfo.split(",");
        getElementById("ccsaEnable").innerHTML = (webSecureInfo[0] == 0) ? DevInfoDes['s3008'] : DevInfoDes['s3007'];
        var html = "";
        for (var i = 0; i < webSecureInfo[1].length; i++) {
            html += "<div style='width:7.5px;float:left;'>" + webSecureInfo[1][i] + "</div>";
        }
        getElementById("ccsaFirHash").innerHTML = html;

        if (webSecureInfo[2] == "") {
            getElementById("ccsaSecHash").innerHTML = "NA";
        } else {
            html = "";
            for (var i = 0; i < webSecureInfo[2].length; i++) {
                html += "<div style='width:7.5px;float:left;'>" + webSecureInfo[2][i] + "</div>";
            }
            getElementById("ccsaSecHash").innerHTML = html;
        }
    }
</script>

<div class="func_spread"></div>
<div id=devicealias>
<div BindText="s1616" class="func_title"></div>
<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
        <tr>
            <td BindText="s1617" class="table_title width_per25"></td>
            <td class="table_right width_per75">
                <input class="width_per60" type="text" id="DevAlias" value = "">
            </td>            
        </tr>        
    </table>
    <table width="100%" height="30"> 
        <tr>
            <td class='title_bright1'>
                <button id="apply" BindText="s1618" class="ApplyButtoncss" type="button" onClick="OnApply();" enable=true  ></button>
            </td>
        </tr>
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    </table> 
</div>
</div>
<script>
        ParseBindTextByTagName(DevInfoDes, "div", 1);
        ParseBindTextByTagName(DevInfoDes, "button", 1);
        ParseBindTextByTagName(DevInfoDes, "input", 2);
</script>
<div class="func_spread"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
<tr id="DefaultNotice" style="display:none">
<script language="JavaScript" type="text/javascript">
    if (CfgMode.toUpperCase() == 'ZAIN') {
        document.write('<td class="table_title" id="td13_1" BindText="s2016" style="color: #e0218a; background-color: #ffffff;"></td>');
    } else if ((CfgMode.toUpperCase() == "COMMONEBG2WIFI") || (deviceInfo.ModelName.substr(0,2) == "EG") ||
               (CfgMode.toUpperCase() == "DBAHNHOF2WIFI")) {
        document.write('<td class="table_title" id="td13_1" BindText="s2016_ebg" style="color:#FF0000"></td>');
    } else if (sonetFlag == 1) {
        document.write('<td class="table_title" id="td13_1" BindText="s2016_a" style="color:#FF0000"></td>');
    } else if (megacable == 1) {
        document.write('<td class="table_title" id="td13_1" BindText="s2016_megacable" style="color:#FF0000"></td>');
    } else {
        document.write('<td class="table_title" id="td13_1" BindText="s2016" style="color:#FF0000"></td>');
    }
</script>
</tr>
</table>
<div style="height:20px"></div>
</body>
</html>
