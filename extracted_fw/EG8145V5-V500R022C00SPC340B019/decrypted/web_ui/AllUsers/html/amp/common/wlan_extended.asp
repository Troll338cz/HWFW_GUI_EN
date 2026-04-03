
var url_new = "";


function stWlan(domain, ssid, name, Enable, X_HW_ServiceEnable, SSIDAdvertisementEnabled, BeaconType, BasicEncryptionModes, KeyIndex, WEPEncryptionLevel, X_HW_WPAand11iEncryptionModes, X_HW_Standard, X_HW_HT20, Channel, ChannelPlus, AutoChannelEnable, X_HW_AutoChannelScope, RegulatoryDomain, BasicAuthenticationMode, WPAEncryptionModes, WPAAuthenticationMode, IEEE11iEncryptionModes, IEEE11iAuthenticationMode, X_HW_WPAand11iAuthenticationMode, IsolationEnable, X_HW_AssociateNum, WMMEnable) {
    this.domain = domain;
    this.ssid = ssid;
    this.name = name;
    this.Enable = Enable;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.SSIDAdvertisementEnabled = SSIDAdvertisementEnabled;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.KeyIndex = KeyIndex;
    this.WEPEncryptionLevel = WEPEncryptionLevel;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_Standard = X_HW_Standard;
    this.X_HW_HT20 = X_HW_HT20;
    this.Channel = Channel;
    this.ChannelPlus = ChannelPlus;
    this.AutoChannelEnable = AutoChannelEnable;
    this.X_HW_AutoChannelScope = X_HW_AutoChannelScope;
    this.RegulatoryDomain = RegulatoryDomain;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.X_HW_WPAand11iAuthenticationMode = X_HW_WPAand11iAuthenticationMode;
    this.X_HW_AssociateNum = X_HW_AssociateNum;
    this.IsolationEnable = IsolationEnable;
    this.WMMEnable = WMMEnable;

    this.InstId = getWlanInstFromDomain(domain);
}

var allWlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},SSID|Name|Enable|X_HW_ServiceEnable|SSIDAdvertisementEnabled|BeaconType|BasicEncryptionModes|WEPKeyIndex|WEPEncryptionLevel|X_HW_WPAand11iEncryptionModes|X_HW_Standard|X_HW_HT20|Channel|ChannelPlus|AutoChannelEnable|X_HW_AutoChannelScope|RegulatoryDomain|BasicAuthenticationMode|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iAuthenticationMode|IsolationEnable|X_HW_AssociateNum|WMMEnable,stWlan);%>;

function stWifiCoverSetWlanBasic(SsidInst, SSID, Enable, Standard, BeaconType, BasicEncryptionModes, BasicAuthenticationMode, WPAEncryptionModes, WPAAuthenticationMode, IEEE11iEncryptionModes, IEEE11iAuthenticationMode, MixEncryptionModes, MixAuthenticationMode, WEPEncryptionLevel, WEPKeyIndex, Key,MaxAssociateNum,SSIDAdvertisementEnabled,STAIsolation,WMMEnable)
{   
    this.SsidInst = SsidInst;
    this.SSID = SSID;
    this.Enable = Enable;
    this.Standard = Standard;
	this.BeaconType = BeaconType;
	this.BasicEncryptionModes = BasicEncryptionModes;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.MixEncryptionModes = MixEncryptionModes;
    this.MixAuthenticationMode = MixAuthenticationMode;
    
	this.WEPEncryptionLevel = WEPEncryptionLevel;
    this.WEPKeyIndex = WEPKeyIndex;
    this.Key = Key;
	this.MaxAssociateNum = MaxAssociateNum;
	this.SSIDAdvertisementEnabled = SSIDAdvertisementEnabled;
	this.STAIsolation = STAIsolation;
	this.WMMEnable = WMMEnable;
}

var guiCoverSsidNotifyFlag = 0;
var gstWifiCoverSetWlanBasic = new stWifiCoverSetWlanBasic("","","","","", "","","","","","","","", "","","","","","","");

var ENUM_SsidInst = 1;
var ENUM_SSID = 2;
var ENUM_Enable = 3;
var ENUM_Standard = 4;
var ENUM_BeaconType = 5;
var ENUM_BasicEncryptionModes = 6;
var ENUM_BasicAuthenticationMode = 7;
var ENUM_WPAEncryptionModes = 8;
var ENUM_WPAAuthenticationMode = 9;
var ENUM_IEEE11iEncryptionModes = 10;
var ENUM_IEEE11iAuthenticationMode = 11;
var ENUM_MixEncryptionModes = 12;
var ENUM_MixAuthenticationMode = 13;
var ENUM_WEPEncryptionLevel = 14;
var ENUM_WEPKeyIndex = 15;
var ENUM_Key = 16;
var ENUM_MaxAssociateNum = 17;
var ENUM_SSIDAdvertisementEnabled = 18;
var ENUM_STAIsolation = 19;
var ENUM_WMMEnable = 20;

function setCoverSsidNotifyFlag(DBvalue, WebValue, ParaNo)
{
    if (DBvalue == WebValue)
    {
		return;
    }

	if (ENUM_SsidInst == ParaNo) {
     	gstWifiCoverSetWlanBasic.SsidInst = WebValue;
	} else if (ENUM_SSID == ParaNo)	{
	    gstWifiCoverSetWlanBasic.SSID = WebValue;
	} else if (ENUM_Enable == ParaNo) {
		gstWifiCoverSetWlanBasic.Enable = WebValue;
	} else if (ENUM_Standard == ParaNo)	{
		gstWifiCoverSetWlanBasic.Standard = WebValue;
	} else if (ENUM_BeaconType == ParaNo) {
		gstWifiCoverSetWlanBasic.BeaconType = WebValue;
	} else if (ENUM_BasicEncryptionModes == ParaNo)	{
		gstWifiCoverSetWlanBasic.BasicEncryptionModes = WebValue;
	} else if (ENUM_WEPEncryptionLevel == ParaNo) {
		gstWifiCoverSetWlanBasic.WEPEncryptionLevel = WebValue;
	} else if (ENUM_WEPKeyIndex == ParaNo) {
	    gstWifiCoverSetWlanBasic.WEPKeyIndex = WebValue;
	} else if (ENUM_MixEncryptionModes == ParaNo) {
	    gstWifiCoverSetWlanBasic.MixEncryptionModes = WebValue;
	} else if (ENUM_BasicAuthenticationMode == ParaNo) {
	    gstWifiCoverSetWlanBasic.BasicAuthenticationMode = WebValue;
	} else if (ENUM_WPAEncryptionModes == ParaNo) {
	    gstWifiCoverSetWlanBasic.WPAEncryptionModes = WebValue;
	} else if (ENUM_WPAAuthenticationMode == ParaNo) {
	    gstWifiCoverSetWlanBasic.WPAAuthenticationMode = WebValue;
	} else if (ENUM_IEEE11iEncryptionModes == ParaNo){
	    gstWifiCoverSetWlanBasic.IEEE11iEncryptionModes = WebValue;
	} else if (ENUM_IEEE11iAuthenticationMode == ParaNo) {
	    gstWifiCoverSetWlanBasic.IEEE11iAuthenticationMode = WebValue;
	} else if (ENUM_MixAuthenticationMode == ParaNo) {
	    gstWifiCoverSetWlanBasic.MixAuthenticationMode = WebValue;
	} else if (ENUM_Key == ParaNo) {
		gstWifiCoverSetWlanBasic.Key = WebValue;
	} else if (ENUM_MaxAssociateNum == ParaNo) {
		gstWifiCoverSetWlanBasic.MaxAssociateNum = WebValue;
	} else if (ENUM_SSIDAdvertisementEnabled == ParaNo) {
		gstWifiCoverSetWlanBasic.SSIDAdvertisementEnabled = WebValue;
	} else if (ENUM_STAIsolation == ParaNo) {
		gstWifiCoverSetWlanBasic.STAIsolation = WebValue;
	} else if (ENUM_WMMEnable == ParaNo) {
		gstWifiCoverSetWlanBasic.WMMEnable = WebValue;
	} else {
		return;
	}

    guiCoverSsidNotifyFlag++;
}

function stExtendedWLC(domain, SSIDIndex)
{
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
}

var apExtendedWLC = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC);%>;

function isWifiCoverSsid(wlanInst)
{
    for (var j = 0; j < apExtendedWLC.length - 1; j++)
    {
        if (wlanInst == apExtendedWLC[j].SSIDIndex)
        {
			return true;
        }
    }

    return false
}

function isWifiCoverSsidNotify()
{    
    if (guiCoverSsidNotifyFlag > 0)
    {
        return true;
    }
    return false;
}

function WifiCoverParaDefault(wlaninfo, wlanInst)
{
	guiCoverSsidNotifyFlag = 0;

    gstWifiCoverSetWlanBasic.SsidInst = wlanInst;
    gstWifiCoverSetWlanBasic.SSID = wlaninfo.ssid;
    gstWifiCoverSetWlanBasic.Enable = wlaninfo.Enable;
    gstWifiCoverSetWlanBasic.Standard = wlaninfo.X_HW_Standard;
	gstWifiCoverSetWlanBasic.BeaconType = wlaninfo.BeaconType;
    
	gstWifiCoverSetWlanBasic.BasicEncryptionModes = wlaninfo.BasicEncryptionModes;
	gstWifiCoverSetWlanBasic.WEPEncryptionLevel = wlaninfo.WEPEncryptionLevel;
    gstWifiCoverSetWlanBasic.WEPKeyIndex = wlaninfo.KeyIndex;
    gstWifiCoverSetWlanBasic.MixEncryptionModes = wlaninfo.X_HW_WPAand11iEncryptionModes;
		
    gstWifiCoverSetWlanBasic.BasicAuthenticationMode = wlaninfo.BasicAuthenticationMode;
    gstWifiCoverSetWlanBasic.WPAEncryptionModes = wlaninfo.WPAEncryptionModes;
    gstWifiCoverSetWlanBasic.WPAAuthenticationMode = wlaninfo.WPAAuthenticationMode;
    gstWifiCoverSetWlanBasic.IEEE11iEncryptionModes = wlaninfo.IEEE11iEncryptionModes;
    gstWifiCoverSetWlanBasic.IEEE11iAuthenticationMode = wlaninfo.IEEE11iAuthenticationMode;
    gstWifiCoverSetWlanBasic.MixAuthenticationMode = wlaninfo.X_HW_WPAand11iAuthenticationMode;
	gstWifiCoverSetWlanBasic.MaxAssociateNum = wlaninfo.X_HW_AssociateNum;
	gstWifiCoverSetWlanBasic.SSIDAdvertisementEnabled = wlaninfo.SSIDAdvertisementEnabled;
	gstWifiCoverSetWlanBasic.STAIsolation = wlaninfo.IsolationEnable;
	gstWifiCoverSetWlanBasic.WMMEnable = wlaninfo.WMMEnable;

    // gstWifiCoverSetWlanBasic.Key

}

function SubmitWIfiCoverSsid(Form, wlaninfo, wlanInst)
{
	if (true != isWifiCoverSsid(wlanInst))
	{
		return;
	}

	if (true != isWifiCoverSsidNotify(wlanInst))
	{
		return;
	}

    Form.addParameter('ToAp'+ wlanInst +'.SsidInst' , gstWifiCoverSetWlanBasic.SsidInst);
    Form.addParameter('ToAp'+ wlanInst +'.SSID' , gstWifiCoverSetWlanBasic.SSID);
    Form.addParameter('ToAp'+ wlanInst +'.Enable' , gstWifiCoverSetWlanBasic.Enable);
    Form.addParameter('ToAp'+ wlanInst +'.Standard' , gstWifiCoverSetWlanBasic.Standard);
	Form.addParameter('ToAp'+ wlanInst +'.BeaconType' , gstWifiCoverSetWlanBasic.BeaconType);
	Form.addParameter('ToAp'+ wlanInst +'.BasicEncryptionModes' , gstWifiCoverSetWlanBasic.BasicEncryptionModes);
    Form.addParameter('ToAp'+ wlanInst +'.BasicAuthenticationMode' , gstWifiCoverSetWlanBasic.BasicAuthenticationMode);
    Form.addParameter('ToAp'+ wlanInst +'.WPAEncryptionModes' , gstWifiCoverSetWlanBasic.WPAEncryptionModes);
    Form.addParameter('ToAp'+ wlanInst +'.WPAAuthenticationMode' , gstWifiCoverSetWlanBasic.WPAAuthenticationMode);
    Form.addParameter('ToAp'+ wlanInst +'.IEEE11iEncryptionModes' , gstWifiCoverSetWlanBasic.IEEE11iEncryptionModes);
    Form.addParameter('ToAp'+ wlanInst +'.IEEE11iAuthenticationMode' , gstWifiCoverSetWlanBasic.IEEE11iAuthenticationMode);
    Form.addParameter('ToAp'+ wlanInst +'.MixEncryptionModes' , gstWifiCoverSetWlanBasic.MixEncryptionModes);
    Form.addParameter('ToAp'+ wlanInst +'.MixAuthenticationMode' , gstWifiCoverSetWlanBasic.MixAuthenticationMode);
    
	Form.addParameter('ToAp'+ wlanInst +'.WEPEncryptionLevel' , gstWifiCoverSetWlanBasic.WEPEncryptionLevel);
    Form.addParameter('ToAp'+ wlanInst +'.WEPKeyIndex' , gstWifiCoverSetWlanBasic.WEPKeyIndex);
    Form.addParameter('ToAp'+ wlanInst +'.Key' , gstWifiCoverSetWlanBasic.Key);
	Form.addParameter('ToAp'+ wlanInst +'.SSIDAdvertisementEnabled' , gstWifiCoverSetWlanBasic.SSIDAdvertisementEnabled);
	Form.addParameter('ToAp'+ wlanInst +'.STAIsolation' , gstWifiCoverSetWlanBasic.STAIsolation);
	Form.addParameter('ToAp'+ wlanInst +'.MaxAssociateNum' , gstWifiCoverSetWlanBasic.MaxAssociateNum);
	Form.addParameter('ToAp'+ wlanInst +'.WMMEnable' , gstWifiCoverSetWlanBasic.WMMEnable);

	url_new += 'ToAp'+ wlanInst +'=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&';

	return;
}
