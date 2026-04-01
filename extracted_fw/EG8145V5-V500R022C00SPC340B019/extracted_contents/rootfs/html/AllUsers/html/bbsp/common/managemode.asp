function stManageFlag(ManageFlag)
{
	this.ManageFlag = ManageFlag;
}

var stManageFlaginfo = new stManageFlag(0);
stManageFlaginfo.ManageFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CWMP_JSCT);%>";
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var CmccRegflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';

function stFtFlag(HLJCT, SHCT, AHCT, GDCT, JSCT, SZCT, PCCWHK, MOBILY, TELMEX, CQCT, BJCU,JXCT,GSCT,QHCT,GZCT,JLCT,SDCT,HUNCT,PTVDFB,PTVDF, BJUNICOM, CUVOICE, COMMON, DT_HUNGARY)
{
	this.HLJCT = HLJCT;
	this.SHCT = SHCT;
	this.AHCT = AHCT;
	this.GDCT = GDCT;
	this.JSCT = JSCT;
	this.SZCT = SZCT;
	this.PCCWHK = PCCWHK;
	this.MOBILY = MOBILY;
	this.TELMEX = TELMEX;
	this.CQCT = CQCT;
	this.BJCU = BJCU;
	this.JXCT = JXCT;
	this.GSCT = GSCT;
	this.QHCT = QHCT;
	this.GZCT = GZCT;
	this.JLCT = JLCT;
	this.SDCT = SDCT;
	this.HUNCT = HUNCT;
	this.PTVDFB = PTVDFB;
	this.PTVDF = PTVDF;
	this.BJUNICOM = BJUNICOM;
	this.CUVOICE = CUVOICE;
	this.COMMON = COMMON;
	this.DT_HUNGARY = DT_HUNGARY;
}

var ManageCfgWord = new stFtFlag("0", "0", "0", "0", "0", "0", "0", "0", "0", "0","0","0","0","0","0","0","0","0","0","0","0","0","0", "0");
ManageCfgWord.HLJCT = "<% HW_WEB_GetFeatureSupport(BBSP_FT_HLJCT);%>";
ManageCfgWord.HUNCT = "<% HW_WEB_GetFeatureSupport(BBSP_FT_HUNCT);%>";
ManageCfgWord.GDCT = "<% HW_WEB_GetFeatureSupport(BBSP_FT_GDCT);%>";
ManageCfgWord.SHCT = "<% HW_WEB_GetFeatureSupport(BBSP_FT_SHCT);%>";
ManageCfgWord.AHCT = "<% HW_WEB_GetFeatureSupport(BBSP_FT_AHCT);%>";
ManageCfgWord.JSCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_JSCT);%>";
ManageCfgWord.SZCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_SZCT);%>";
ManageCfgWord.PCCWHK = (['PCCWHK', 'PCCW3MAC', 'PCCW4MAC', 'PCCWSMART', 'PCCW2'].indexOf(CfgModeWord.toUpperCase()) >= 0) ? "1" : "0";
ManageCfgWord.MOBILY = "<%HW_WEB_GetFeatureSupport(BBSP_FT_MOBILY);%>";
ManageCfgWord.TELMEX = "<%HW_WEB_GetFeatureSupport(BBSP_FT_TELMEX);%>";
ManageCfgWord.CQCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_CQCT);%>";
ManageCfgWord.BJCU = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BJCU);%>"; 
ManageCfgWord.GSCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_GSCT);%>";
ManageCfgWord.QHCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_QHCT);%>";
ManageCfgWord.GZCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_GZCT);%>";
ManageCfgWord.JLCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_JLCT);%>";
ManageCfgWord.JXCT = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JXCT);%>"; 
ManageCfgWord.SDCT = "<%HW_WEB_GetFeatureSupport(BBSP_FT_SDCT);%>";
ManageCfgWord.PTVDFB = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDFB);%>";
ManageCfgWord.PTVDF = "<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>";
ManageCfgWord.BJUNICOM = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BJUNICOM);%>";
ManageCfgWord.CUVOICE = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
ManageCfgWord.COMMON = ('COMMON' == CfgModeWord.toUpperCase() || 'COMMON2' == CfgModeWord.toUpperCase())?"1" : "0";
ManageCfgWord.DT_HUNGARY = "<%HW_WEB_GetFeatureSupport(SSMP_FEATURE_MNGT_DT_HUNGARY);%>";
ManageCfgWord.TRUE = ('TRUE' == CfgModeWord.toUpperCase() || 'TRUEVIDEO' == CfgModeWord.toUpperCase() || 'TRUERG' == CfgModeWord.toUpperCase() || 'TRUEEPA' == CfgModeWord.toUpperCase())?"1" : "0";
ManageCfgWord.OSK = ('OSK' == CfgModeWord.toUpperCase() || 'OSK2' == CfgModeWord.toUpperCase())?"1" : "0";
ManageCfgWord.TELECENTRO = (CfgModeWord.toUpperCase() == "TELECENTRO")?"1" : "0";
ManageCfgWord.CABLEVISION = (CfgModeWord.toUpperCase() == "CABLEVISION2" || CfgModeWord.toUpperCase() == "CABLEVISION")?"1" : "0";

var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";

function GetManageFlag()
{
    if (ManageCfgWord.GDCT == "1") {
        stManageFlaginfo.ManageFlag = 1;
    }
    return stManageFlaginfo;
}

function GetCfgMode()
{
    return ManageCfgWord;
}

var RunningMode = "<% HW_WEB_GetFeatureSupport(BBSP_FT_CTC);%>";

function GetRunningMode()
{
	return RunningMode;
}

var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
function GetProductName()
{
    return ProductName;
}

var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var LanUpportFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>";

function GetCurrentBin()
{
	return CurrentBin;
}

function isE8cAndCMCC()
{
    if('E8C' == CurrentBin.toUpperCase() || 'CMCC' == CurrentBin.toUpperCase())
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsE8cFrame()
{
    if('E8C' == CurrentBin.toUpperCase())
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsCmcc_rmsMode()
{
	var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
	if ('1' == Custom_cmcc_rms )
	{
		return true;
	}
	else
	{
		return false;
	}	
}


function IsE8cFrameOrCMCC_RMS()
{

    if(('E8C' == CurrentBin.toUpperCase()) || (IsCmcc_rmsMode()))	
    {
        return true;
    }
	else
    {
        return false;
    }	
}

function IsLanUpport()
{
 	if('1' == LanUpportFlag)
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsLanUpCanOper()
{
    if ((IsAdminUser() == false) && (CfgModeWord.toUpperCase() == "RDSAP")) {
        return false;
    }

 	if(('1' == LanUpportFlag) && ("1" != ManageCfgWord.BJUNICOM) && apcmodefeature != "1")
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsLanBJUNICOM()
{
 	if(('1' == LanUpportFlag) && ("1" == ManageCfgWord.BJUNICOM))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsEnWebUserModifyWan() {
    if ((IsAdminUser() == false) && (CfgModeWord.toUpperCase() == "ROSUNION")) {
        return true;
    }

    return false;
}

function FeatureInfoClass(domain, RouteWanMulticastIPoE, RouteWanMulticastPPPoE, BridgeWanMulticast, WanMulticastProxy, LanSsidWanBind, IPv6, WanPriPolicy, dslite, LanPppWanBind, Wan, httpportmode, telportmode, dmzpri, WebCfgRgEnValid)
{
    this.domain = domain;
    this.RouteWanMulticastIPoE = RouteWanMulticastIPoE;
    this.RouteWanMulticastPPPoE = RouteWanMulticastPPPoE;
    this.BridgeWanMulticast = BridgeWanMulticast;
    this.WanMulticastProxy = WanMulticastProxy;
    this.LanSsidWanBind  = LanSsidWanBind;
    this.IPv6            = IPv6;
    this.WanPriPolicy    = WanPriPolicy;
    this.Dslite = dslite;
	this.LanPppWanBind  = LanPppWanBind;
	this.Wan  = Wan;
	this.httpportmode = httpportmode;
	this.telportmode  = telportmode;
	this.dmzpri       = dmzpri;
	this.WebCfgRgEnValid = WebCfgRgEnValid;
}

var MngtAhct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_AHCT);%>';
var RouteWanMax = '<%HW_WEB_GetSPEC(BBSP_SPEC_ROUTEWAN_MAXNUM.UINT32);%>';
var WanMax = '<%HW_WEB_GetSPEC(BBSP_SPEC_IFM_WANNUM.UINT32);%>';
var FeatureInfo = new FeatureInfoClass("", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1","1", "0", "0", "0", "0");
FeatureInfo.WanMulticastProxy = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULTICAST_WANPROXY);%>";
FeatureInfo.RouteWanMulticastIPoE = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULTICAST_ROUTEIP);%>";
FeatureInfo.RouteWanMulticastPPPoE = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULTICAST_ROUTEPPP);%>";
FeatureInfo.BridgeWanMulticast = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULTICAST_BRIDGE);%>";
FeatureInfo.LanSsidWanBind = "<% HW_WEB_GetFeatureSupport(BBSP_FT_LANBIND_IP);%>";
FeatureInfo.IPv6 = "<% HW_WEB_GetFeatureSupport(BBSP_FT_IPV6_WANCFG);%>";
FeatureInfo.WanPriPolicy = "<% HW_WEB_GetFeatureSupport(BBSP_FT_WANPRI_POLICY);%>";
FeatureInfo.Dslite = "<% HW_WEB_GetFeatureSupport(BBSP_FT_IPV6_DSLITE);%>";
FeatureInfo.LanPppWanBind = "<% HW_WEB_GetFeatureSupport(BBSP_FT_LANBIND_PPP);%>";
FeatureInfo.Wan = "<% HW_WEB_GetFeatureSupport(BBSP_FT_WAN);%>";
FeatureInfo.IPProtChk = "<% HW_WEB_GetFeatureSupport(BBSP_FT_IP_PROTOCOL_CFG_CHK);%>";
FeatureInfo.httpportmode = "<% HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_HTTP_PORT_MODE);%>";
FeatureInfo.telportmode  = "<% HW_WEB_GetFeatureSupport(BBSP_FT_TELNET_PORT_MODE);%>";
FeatureInfo.dmzpri       = "<% HW_WEB_GetFeatureSupport(BBSP_FT_DMZ_PRIORITY);%>";
FeatureInfo.WebCfgRgEnValid = "<% HW_WEB_GetFeatureSupport(BBSP_FT_WEB_CFG_RG_EN_VALID);%>";

function GetFeatureInfo()
{
    return FeatureInfo;
}

function IsFeatureSupport(FeatureName)
{
    return FeatureInfo[FeatureName];
}

function GetRouteWanMax()
{
	return RouteWanMax;
}

function GetWanMax()
{
    return WanMax;
}
