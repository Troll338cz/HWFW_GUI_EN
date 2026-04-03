
function stTopoSsid(Domain, SsidNum)
{   
    this.Domain = Domain;
    this.SsidNum = SsidNum;
}

function stReguDomain(CountryCode, RegCode)
{
	this.CountryCode = CountryCode;
	this.RegCode = RegCode;
}

var TotalRegDomain = new Array(
    new stReguDomain("AL", "CE"),
    new stReguDomain("AO", "CE"),
    new stReguDomain("DZ", "CE"),
    new stReguDomain("AD", "CE"),
    new stReguDomain("AR", "CE"),
    new stReguDomain("AU", "CE"),
    new stReguDomain("AT", "CE"),
    new stReguDomain("AZ", "CE"),
    new stReguDomain("BH", "CE"),
    new stReguDomain("BY", "CE"),
    new stReguDomain("BE", "CE"),
    new stReguDomain("BA", "CE"),
    new stReguDomain("BR", "CE"),
    new stReguDomain("BN", "CE"),
    new stReguDomain("BG", "CE"),
    new stReguDomain("BF", "CE"),
    new stReguDomain("BO", "CE"),
    new stReguDomain("CA", "FCC"),
    new stReguDomain("CB", "CE"),
    new stReguDomain("CL", "CE"),
    new stReguDomain("CN", "CCC"),
    new stReguDomain("CO", "FCC"),
    new stReguDomain("CR", "CE"),
    new stReguDomain("CI", "CE"),
    new stReguDomain("HR", "CE"),
    new stReguDomain("CY", "CE"),
    new stReguDomain("CZ", "CE"),
    new stReguDomain("DK", "CE"),
    new stReguDomain("DO", "FCC"),
    new stReguDomain("EC", "CE"),
    new stReguDomain("EG", "CE"),
    new stReguDomain("SV", "CE"),
    new stReguDomain("EE", "CE"),
    new stReguDomain("FK", "CE"),
    new stReguDomain("FI", "CE"),
    new stReguDomain("FR", "CE"),
    new stReguDomain("GE", "CE"),
    new stReguDomain("DE", "CE"),
    new stReguDomain("GH", "CE"),
    new stReguDomain("GR", "CE"),
    new stReguDomain("GT", "FCC"),
    new stReguDomain("HN", "CE"),
    new stReguDomain("HK", "FCC"),
    new stReguDomain("HU", "CE"),
    new stReguDomain("IS", "CE"),
    new stReguDomain("IN", "CE"),
    new stReguDomain("ID", "CE"),
    new stReguDomain("IR", "CE"),
    new stReguDomain("IE", "CE"),
    new stReguDomain("IL", "CE"),
    new stReguDomain("IT", "CE"),
    new stReguDomain("JM", "FCC"),
    new stReguDomain("JP", "MKK"),
    new stReguDomain("JO", "CE"),
    new stReguDomain("KZ", "CE"),
    new stReguDomain("KE", "CE"),
    new stReguDomain("KW", "CE"),
    new stReguDomain("LA", "CE"),
    new stReguDomain("LV", "CE"),
    new stReguDomain("LB", "CE"),
    new stReguDomain("LR", "CE"),
    new stReguDomain("LI", "CE"),
    new stReguDomain("LT", "CE"),
    new stReguDomain("LU", "CE"),
    new stReguDomain("MO", "CE"),
    new stReguDomain("MK", "CE"),
    new stReguDomain("MU", "CE"),
    new stReguDomain("MY", "CE"),
    new stReguDomain("MT", "CE"),
    new stReguDomain("MX", "FCC"),
    new stReguDomain("MC", "CE"),
    new stReguDomain("MA", "CE"),
    new stReguDomain("MD", "CE"),
    new stReguDomain("NP", "CE"),
    new stReguDomain("NL", "CE"),
    new stReguDomain("AN", "CE"),
    new stReguDomain("NZ", "CE"),
    new stReguDomain("NI", "CE"),
    new stReguDomain("NO", "CE"),
    new stReguDomain("NG", "CE"),
    new stReguDomain("OM", "CE"),
    new stReguDomain("PK", "CE"),
    new stReguDomain("PA", "FCC"),
    new stReguDomain("PG", "CE"),
    new stReguDomain("PY", "FCC"),
    new stReguDomain("PE", "CE"),
    new stReguDomain("PH", "CE"),
    new stReguDomain("PL", "CE"),
    new stReguDomain("PT", "CE"),
    new stReguDomain("PR", "FCC"),
    new stReguDomain("QA", "CE"),
    new stReguDomain("RO", "CE"),
    new stReguDomain("RS", "CE"),
    new stReguDomain("RU", "CE"),
    new stReguDomain("SA", "CE"),
    new stReguDomain("SG", "CE"),
    new stReguDomain("SK", "CE"),
    new stReguDomain("SI", "CE"),
    new stReguDomain("SR", "CE"),
    new stReguDomain("ZA", "CE"),
    new stReguDomain("ES", "CE"),
    new stReguDomain("LK", "CE"),
    new stReguDomain("SE", "CE"),
    new stReguDomain("CH", "CE"),
    new stReguDomain("SY", "CE"),
    new stReguDomain("TW", "FCC"),
    new stReguDomain("TH", "FCC"),
    new stReguDomain("TT", "CE"),
    new stReguDomain("TN", "CE"),
    new stReguDomain("TR", "CE"),
    new stReguDomain("UA", "CE"),
    new stReguDomain("AE", "CE"),
    new stReguDomain("GB", "CE"),
    new stReguDomain("US", "FCC"),
    new stReguDomain("UY", "CE"),
    new stReguDomain("VE", "CE"),
    new stReguDomain("VN", "CE"),
    new stReguDomain("ZW", "CE")
);


function isDfsArea(country)
{
    if ('<%HW_WEB_GetFeatureSupport(FT_WLAN_NOT_NOTIFY_RADAR_CHANNEL);%>' == 1) {
        return 0;
    }

    var reguDomain = 0;
    for (var i = 0; i < TotalRegDomain.length; i++) {
        if (TotalRegDomain[i].CountryCode == country) {
            reguDomain = TotalRegDomain[i].RegCode;
            break;
        }
    }

    if ((reguDomain != 'CE') && (reguDomain != 'FCC') && (reguDomain != 'MKK')) {
        return 0;
    }

    return 1;
}

function checkDfsChannels(Channel, ChannelPlus, ChannelWidth)
{
	if (ChannelWidth == 5)
	{      
		if (((Channel >= 52) && (112 >= Channel)) || ((Channel >= 132) && (144 >= Channel))
			|| ((ChannelPlus >= 52) && (112 >= ChannelPlus)) || ((ChannelPlus >= 132) && (144 >= ChannelPlus))
			|| ((Channel >= 116) && (128 >= Channel)) || ((ChannelPlus >= 116) && (128 >= ChannelPlus)))
		{
			return true;
		}
	}
	else if (ChannelWidth == 4)
	{
		if (((Channel >= 100) && (128 >= Channel))
			|| ((Channel >= 52) && (64 >= Channel)) 
			|| ((Channel >= 132) && (144 >= Channel)))
		{
			return true;
		}
	}
	else
	{
		if ((52 <= Channel) && (144 >= Channel))
		{
			return true;
		}
	}
	return false;
}

function getChannelWithOutDfs(Channels, ChannelWidth)
{
	var ChannelArray = Channels.split(',');
	var ChannelWithOutDfs = new Array();
	var ChannelWithOutDfsChar;
	var Channel = '';
	var ChannelPlus = '';
	var curChannelArr;
	for (var i = 0; i < ChannelArray.length; i++)
	{
		Channel = ChannelArray[i];
		if (ChannelWidth == 5)
		{
			curChannelArr = ChannelArray[i].split('+');
            Channel = curChannelArr[0];
            ChannelPlus = curChannelArr[1];
		}
		if (!checkDfsChannels(Channel, ChannelPlus, ChannelWidth))
		{
			ChannelWithOutDfs.push(ChannelArray[i]);
		}
	}
	ChannelWithOutDfsChar = ChannelWithOutDfs.join(',');
	return ChannelWithOutDfsChar;
}

function getDfsKeepTime(channel, channelPlus, country, channelWidth)
{
    var reguDomain = 0;

    for (var i = 0; i < TotalRegDomain.length; i++) {
        if (TotalRegDomain[i].CountryCode == country) {
            reguDomain = TotalRegDomain[i].RegCode;
            break;
        }
    }

    var channelGroup = 0;

    if ((reguDomain != 'CE') && (reguDomain != 'FCC') && (reguDomain != 'MKK')) {
        return channelGroup = 0;
    }

    if (channelWidth == 5) {
        if (((channel >= 52) && (channel <= 112)) || ((channel >= 132) && (channel <= 144))) {
            channelGroup = 1;
        }

        if (((channelPlus >= 52) && (channelPlus <= 112)) || ((channelPlus >= 132) && (channelPlus <= 144))) {
            channelGroup = 1;
        }

        if (((channel >= 116) && (channel <= 128)) || ((channelPlus >= 116) && (channelPlus <= 128))) {
            channelGroup = 2;
        }
    } else if (channelWidth == 4) {
        if ((channel >= 100) && (channel <= 128)) {
            channelGroup = 2;
        } else if (((channel >= 52) && (channel <= 64)) || ((channel >= 132) && (channel <= 144))) {
            channelGroup = 1;
        }
    } else if (channelWidth == 1) {
        if ((channel >= 52) && (channel <= 144)) {
            if ((channel >= 120) && (channel <= 128)) {
                channelGroup = 2;
            } else {
                channelGroup = 1;
            }
        }
    } else {
        if ((channel >= 52) && (channel <= 144)) {
            if ((channel >= 116) && (channel <= 128)){
                channelGroup = 2;
            } else {
                channelGroup = 1;
            }
        }
    }

    if (((reguDomain == 'FCC') || (reguDomain == 'MKK')) && (channelGroup == 2)) {
        channelGroup = 1;
    }

    return channelGroup;
}

var ssidNum = '<%WEB_GetSsidNum();%>';
var TopoSsidInfo = new stTopoSsid('InternetGatewayDevice.X_HW_Topo', parseInt(ssidNum));
var PccwFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PCCW);%>'; 
var kppUsedFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_PWD_KPP_USED);%>';
var isShowHomeNetWork = '<%HW_WEB_GetFeatureSupport(FT_WLAN_UPNP_EXPAND);%>';
var PTVDFFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>';
var needChangePwdFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_ALERT_PWD_NEED_CHANGE);%>';
var isEnableWlanMacFilter = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WLANMACFILER);%>';
var isSupportWlanMacFilter = (isShowHomeNetWork == 1) || (isEnableWlanMacFilter == 1);

var SsidPerBand = '<%HW_WEB_GetSPEC(AMP_SPEC_SSID_NUM_MAX_BAND.UINT32);%>';
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';

var aisAp = '<%HW_WEB_GetFeatureSupport(FT_WLAN_AISAP);%>';
var meshMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_Mesh.MeshMode);%>';  
if ((aisAp == 1) && (meshMode == 0)){
    SsidPerBand = 4;
}

var ssidStart2G = 0;
var ssidEnd2G = SsidPerBand - 1;
var ssidStart5G = SsidPerBand;
var ssidEnd5G = 2 * SsidPerBand -1;
var TriBandHighBandEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WIFIInfo.X_HW_HighBandSupported.HighBandEnable);%>';

if ((1 == isShowHomeNetWork) && (TopoSsidInfo.SsidNum < 8))
{
	TopoSsidInfo.SsidNum = 8;
}

var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var curUserType = '<%HW_WEB_GetUserType();%>';
var language = '<%HW_WEB_GetCurrentLanguage();%>';
var turkcellFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TURKCELL);%>';

var preflag = 0;
if ((CfgModeWord.toUpperCase() === 'PLDT') || (CfgModeWord.toUpperCase() === 'PLDT2')) {
    preflag = 1;
}

function IsSonetSptUser()
{
    if(('<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>' == 1) && curUserType != '0')
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsCaribbeanReg()
{
	if('<%HW_WEB_GetFeatureSupport(HW_AMP_CARIBBEAN_COUNTRY);%>' == 1)  
    {
    	return true;
    }
	else
    {
    	return false;
    }
}

function IsPTVDFSptUser()
{
	if(('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>' == 1) && curUserType != '0')
    {
    	return true;
    }
	else
    {
    	return false;
    }
}

function isSpaceInKey(keyString)
{
    var length = keyString.length;
    for (i = 0; i < length; i++)
    {
      if (keyString.charAt(i) == ' ') 
        {
         return true;
        }
    }
       return false;
}

function IsRDSGatewayUserSsid(index)
{
	if ('RDSGATEWAY' == CfgModeWord.toUpperCase() && curUserType != '0' && index > 1)
    {
    	return true;
    }
	else
    {
    	return false;
    }
}

function stWlanInfo(domain,name,ssid,X_HW_ServiceEnable,enable,X_HW_RFBand,bindenable)
{
    this.domain = domain;
    this.name = name;
    this.ssid = ssid;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.enable = enable;
	this.X_HW_RFBand = X_HW_RFBand;
    this.bindenable = bindenable;
}

function stWlanEnable(domain,enable)
{
    this.domain = domain;
    this.enable = enable;
}

var WlanEnable = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable,stWlanEnable,EXTEND);%>

var WlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|SSID|X_HW_ServiceEnable|Enable|X_HW_RFBand,stWlanInfo);%>


var WlanList = new Array();

var totalnum = 16;

for ( i = 0 ; i < totalnum ; i++ )
{
    var tid = parseInt(i+1);
    WlanList[i] = new stWlanInfo('domain','SSID'+tid,'','0','1','','0');
}

for ( i = 0 ; i < WlanInfo.length - 1 ; i++ )
{
    var length = WlanInfo[i].name.length;

    if ('' == WlanInfo[i].name)
    {
        continue;
    }

    var wlanInst = getWlanInstFromDomain(WlanInfo[i].domain);
    wlanInst = wlanInst-1; 
    if(1 == PccwFlag)
    {
        WlanList[wlanInst].bindenable = 1;
    }
    else
    {
        if ( (1 == WlanInfo[i].enable) && (1 == WlanEnable[0].enable) &&  (1 == WlanInfo[i].X_HW_ServiceEnable) )
        {
            WlanList[wlanInst].bindenable = 1;
        }
        else
        {
            WlanList[wlanInst].bindenable = 0;
        }
    }
}    


function GetWlanList()
{
    return WlanList;
}



var DTHungaryFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DT_HUNGARY);%>';

var TwoSsidCustomizeGroup = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GZCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_NXCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_HUNCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GSCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SZCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_QHCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_HLJCT);%>' 
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JXCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_XJCT);%>'
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JLCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_HAINCT);%>'
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_YNCT);%>'
                             | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_CQCT);%>' | '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TJCT);%>'

if ('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SHOW_ISPSSID);%>')
{
	TwoSsidCustomizeGroup = 1;
}

function FormatSSIDEncode(val)
{
	if(null != val)
	{
		var formatstr = encodeURIComponent(val);
		formatstr=formatstr.replace(new RegExp(/(\+)/g),"%2B");
		formatstr = formatstr.replace(new RegExp(/(\/)/g), "%2F");
		return formatstr
	}
	return null;
}

function GetSSIDStringContent(str, Length)
{
    if(null != str)
    {
    	str = str.toString().replace(/&nbsp;/g," ");
    	str = str.toString().replace(/&quot;/g,"\"");
    	str = str.toString().replace(/&gt;/g,">");
    	str = str.toString().replace(/&lt;/g,"<");
    	str = str.toString().replace(/&#39;/g, "\'");
    	str = str.toString().replace(/&#40;/g, "\(");
    	str = str.toString().replace(/&#41;/g, "\)");
    	str = str.toString().replace(/&amp;/g,"&");
    }

	if (str.length > Length)
    {
        str=str.substr(0, Length) + "......";
    }

	if(null != str)
    {
	str = str.toString().replace(/&/g,"&amp;");
       str = str.toString().replace(/ /g,"&nbsp;");
    	str = str.toString().replace(/\"/g,"&quot;");
    	str = str.toString().replace(/>/g,"&gt;");
    	str = str.toString().replace(/</g,"&lt;");
    	str = str.toString().replace(/\'/g, "&#39;");
    	str = str.toString().replace(/\(/g, "&#40;");
    	str = str.toString().replace(/\)/g, "&#41;");
    	str = str.toString().replace(/\"/g,"&quot;");
		str = str.toString().replace(/\'/g,"&#39;");
    }

    return str;
}

function GetStringContent(str, Length)
{
	if (str.length > Length)
    {
        	str = str.toString().replace(/&nbsp;/g," ");
        	str = str.toString().replace(/&quot;/g,"\"");
        	str = str.toString().replace(/&gt;/g,">");
        	str = str.toString().replace(/&lt;/g,"<");
        	str = str.toString().replace(/&#39;/g, "\'");
        	str = str.toString().replace(/&#40;/g, "\(");
        	str = str.toString().replace(/&#41;/g, "\)");
        	str = str.toString().replace(/&amp;/g,"&");

        	var strNewLength = str.length;
        	if(strNewLength > Length )
            {
            	str=str.substr(0, Length) + "......";
            }
        	else
            {
            	str=str.substr(0, Length);
            }
        	str = str.toString().replace(/&/g,"&amp;");
        	str = str.toString().replace(/>/g,"&gt;");
        	str = str.toString().replace(/</g,"&lt;");
        	str = str.toString().replace(/ /g,"&nbsp;");
            str = str.toString().replace(/\"/g,"&quot;");
			str = str.toString().replace(/\'/g,"&#39;");
        	return str;
    }
	str = str.toString().replace(/ /g,"&nbsp;");
	return str;
}

function stIspWlan(domain, SSID_IDX)
{
    this.domain = domain;
    this.SSID_IDX = SSID_IDX;
}

var IspWlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.X_HW_WLANForISP.{i}, SSID_IDX, stIspWlan, EXTEND);%>;

function getWlanInstFromDomain(domain)
{
    if ('' != domain)
    {
        var array = domain.split('.');
        var str = array[4];
        
        return (parseInt(str));
    }
}

function isSsidForIsp(index)
{
    if (IspWlanInfo == null)
    {
        return 0;
    }
    for (var i = 0; i < (IspWlanInfo.length - 1); i++)
    {
        if (IspWlanInfo[i].SSID_IDX == index)
        {
            return 1;
        }
    }
    
    return 0;
}

function stRadio(domain,OperatingFrequencyBand,Enable)
{
    this.domain = domain;
    this.OperatingFrequencyBand = OperatingFrequencyBand;
    this.Enable = Enable;
}

function WlanInfoRefresh()
{
    var ChanInfo = '<%HW_WEB_GetChanInfo();%>';

	if ((1 == DoubleFreqFlag) && (2 == top.changeWlanClick))
    {
    	WlanChannel = ChanInfo.split(',')[1];
    }
    else
    {
        WlanChannel = ChanInfo.split(',')[0];
    }

	if (1 == DoubleFreqFlag)
    {
    	var Radio  = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.{i},OperatingFrequencyBand|Enable,stRadio,EXTEND);%>;
    	try{
        	if ((1 == wlanEnbl) && (1 == Radio[top.changeWlanClick - 1].Enable))
            {
            	wlanEnbl = 1;
            }
        	else
            {
            	wlanEnbl = 0;
            }
        }catch(e){ wlanEnbl = 0; }
    }
}

var SingleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SINGLE_WLAN);%>';
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var enbl2G = 0;
var enbl5G = 0;
var node2G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
var node5G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.2';

var Radio  = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.{i},OperatingFrequencyBand|Enable,stRadio,EXTEND);%>;
if(Radio.length <= 1)
{
}
else if(Radio.length == 2)
{
    enbl2G = Radio[0].Enable;   
    enbl5G = Radio[0].Enable;   
    node2G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
    node5G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.2';
}
else if ('2.4GHz' == Radio[0].OperatingFrequencyBand)
{
    enbl2G = Radio[0].Enable;   
    enbl5G = Radio[1].Enable;   
    node2G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
    node5G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.2';
}
else if ('5GHz' == Radio[0].OperatingFrequencyBand)
{
    enbl2G = Radio[1].Enable;   
    enbl5G = Radio[0].Enable;   
    node2G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.2';
    node5G = 'InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
}
else
{
}

function isWlanInitFinished(freq, mode, width)
{
    return true;
}

function stSSIDInfo(domain, name, enable, freq, ssid)
{
    this.domain = domain;
    this.name   = name;
    this.enable = enable;
    this.freq = freq;
    this.ssid = ssid;
}

var SSIDList = new Array();
var SSIDFreList = new Array();
for ( var i = 0 ; i < WlanInfo.length - 1 ; i++ )
{
    var length = WlanInfo[i].name.length;

    var wlanInst = getWlanInstFromDomain(WlanInfo[i].domain);
    
    if ( (0 == WlanInfo[i].X_HW_ServiceEnable) || (1 == isSsidForIsp(wlanInst)) )
    {
        continue;
    }
    else if ((IsRDSGatewayUserSsid(wlanInst) == true) && (DoubleFreqFlag != 1))
    {
        continue;
    }
    else
    {
		var SSIDFre = WlanInfo[i].X_HW_RFBand;
		var SSIDFre2 = SSIDFre.substr(0,SSIDFre.length - 2);
		SSIDList.push(new stSSIDInfo(WlanInfo[i].domain, 'SSID' + wlanInst, WlanInfo[i].enable, WlanInfo[i].X_HW_RFBand, WlanInfo[i].ssid));
		SSIDFreList.push(new stSSIDInfo(WlanInfo[i].domain, 'WiFi ' + SSIDFre2 + '-' + 'SSID' + wlanInst, WlanInfo[i].enable, WlanInfo[i].X_HW_RFBand));
    }
}

SSIDList.sort(function(s1, s2)
    {
        return parseInt(s1.name.charAt(s1.name.length - 1), 10) - parseInt(s2.name.charAt(s2.name.length - 1), 10);
    }
);

SSIDFreList.sort(function(s1, s2)
    {
        return parseInt(s1.name.charAt(s1.name.length - 1), 10) - parseInt(s2.name.charAt(s2.name.length - 1), 10);
    }
);

function GetSSIDList()
{
    return SSIDList;
}

function GetRealSSIDList()
{
	if ((1 != IsSupportWlanFlag) && (!isSupportWlanMacFilter))
	{
		return new Array();
	}
	
	var AllSSIDNameList = GetSSIDList();
	var SSIDNameList = AllSSIDNameList;
	if (1 != DoubleFreqFlag)
	{
		SSIDNameList = new Array();
		for (var i = 0 ; i< AllSSIDNameList.length ; i++)
		{
			if (AllSSIDNameList[i].freq == "2.4GHz")
			{
				SSIDNameList.push(AllSSIDNameList[i]);
			} 
            else if (isSupportWlanMacFilter && AllSSIDNameList[i].freq == "5GHz" && CfgModeWord.toUpperCase() != 'CNT')
            {
                SSIDNameList.push(AllSSIDNameList[i]);
            }
		}
	}
	
	return SSIDNameList;
}

function GetSSIDFreList()
{
    return SSIDFreList;
}

function GetSSIDNameByDomain(domain)
{
    var SL = GetSSIDList();        
    for(var i in SL)
    {
        if(SL[i].domain == domain)
            return SL[i].name;
    }        
    return '';
}

function GetSSIDDomainByName(name)
{
    var SL = GetSSIDList();        
    for(var i in SL)
    {
        if(SL[i].name == name)
            return SL[i].domain;
    }        
    return '';
}

function GetSSIDStatusByName(name)
{
    var SL = GetSSIDList();        
    for(var i in SL)
    {
        if(SL[i].name == name)
            return SL[i].enable;
    }        
    return '';
}


function GetSSIDFreByName(name)
{
    var SL = GetSSIDList();        
    for(var i in SL)
    {
        if(SL[i].name == name)
            return SL[i].freq;
    }        
    return '';
}

function IsVisibleSSID(name)
{
    var SL = GetSSIDList();        
    
    for(var i in SL)
    {        
        if(SL[i].name == name)
            return true;
    }        
    return false;
}


function fixIETableScroll(id_div, id_tb)
{
	try{
	if(navigator.appName.indexOf("Internet Explorer") != -1)
    {
    	var divv = $('#' + id_div);
    	var tbb = $('#' + id_tb);
        
    	if(tbb.width() > divv.width())
        {
        	divv.css("padding-bottom", "17px");
        }
    }}catch(e){}
}

function getFirstSSIDPccw(radioId, info)
{
	var wlanInst = (radioId==1)?1:5;
    
	if (1 == isSsidForIsp(wlanInst))
    {
        return null;
    }

    for( var i = 0; i < info.length; i++)
    {
        if (wlanInst != getWlanInstFromDomain(info[i].domain))
        {
            continue;
        }
        
    	if(0 == info[i].X_HW_ServiceEnable)
        	return null;
            
    	info[i].InstId = wlanInst;
        return info[i];
    }

	return null;
}

function getFirstSSIDInst(radioId, info)
{
	if( (radioId < 1) || (radioId > 2) ||
            ((0 == DoubleFreqFlag) && (2 == radioId)))
    {
    	return null;
    }

	try{
    
	if(1 == PccwFlag)
    {
    	return getFirstSSIDPccw(radioId, info);
    }
    
	for( var i = 0; i < info.length; i++)
    {
    	var ssid = info[i].name;
    	if('' == ssid)
        {
        	continue;
        }

    	ssid = parseInt(ssid.charAt(ssid.length - 1), 10);
        
    	if((ssid>ssidEnd2G && radioId==1) || (ssid<=ssidEnd2G && radioId==2))
        {
        	continue;
        }
        
    	var wlanInst = getWlanInstFromDomain(info[i].domain);
    
        if (1 == isSsidForIsp(wlanInst))
        {
            continue;
        }
        
    	info[i].InstId = wlanInst;
        
        return info[i];
        
    }

    }catch(e){ return null; }
    
	return null;
}

function convStdAuthMode(wlan)
{
    if(wlan.BeaconType == "None")
    {
        wlan.BeaconType = "Basic";
        wlan.BasicEncryptionModes = "None";
        wlan.BasicAuthenticationMode = "None";
    }
    else if(wlan.BeaconType == "WPA2")
    {
        wlan.BeaconType = "11i";
    }
    else if(wlan.BeaconType == "WPA/WPA2")
    {
        wlan.BeaconType = "WPAand11i";
    }
}

function getPsk(wlanInst, info)
{
	try{
	for( var i = 0; i < info.length-1; i++)
    {
    	if(wlanInst == parseInt(info[i].domain.charAt(52), 10))
        {
        	return info[i].value;
        }
        
    }}catch(e){ return ""; }
    
	return "";    
}


function getWep(wlanInst, wepKeyInst, info)
{
	try{
	for( var i = 0; i < info.length-1; i++)
    {
    	if((wlanInst == parseInt(info[i].domain.charAt(52), 10)) &&
            (wepKeyInst == parseInt(info[i].domain.charAt(61), 10)))
        {
        	return info[i].value;
        }
        
    }}catch(e){ return ""; }
    
	return "";    
}

function checkSSIDExist(wlan, info)
{
	try{
	var radioId = 0;
	var cur_ssid = parseInt(wlan.name.charAt(wlan.name.length - 1), 10);
    
	radioId = cur_ssid<4?1:2;

	for( var i = 0; i < info.length-1; i++)
    {
    	var ssid = info[i].name;
    	if('' == ssid)
        {
        	continue;
        }

    	ssid = parseInt(ssid.charAt(ssid.length - 1), 10);

    	if((ssid>3 && radioId==1) || (ssid<=3 && radioId==2))
        {
        	continue;
        }
    
    	if((cur_ssid != ssid) && (info[i].ssid == wlan.ssid))
        {
        	AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
        	return true;
        }
        
    }}catch(e){ return false; }
    
	return false;    
}

function isValidStr(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if (ch == '$' || ch == ',' || ch == '\"' || ch == '\\' || ch == '&' || ch == '|' || ch == ';' || ch == '`')
        {
            return ch;
        }
    }
    return '';
}

function CheckSsid(ssid)
{
    if (ssid == '')
    {
        AlertEx(cfg_wlancfgother_language['amp_empty_ssid']);
        return false;
    }

    if (ssid.length > 32)
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
        return false;
    }

    if ((CfgModeWord.toUpperCase() != "TTNET2") && (CfgModeWord.toUpperCase() != "DINFOTEK2")) {
        if (isValidAscii(ssid) != '') {
            AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid'] + isValidAscii(ssid));
            return false;
        }
    }

	return true;
}

function CheckPsk(value)
{	
	if (value == '')
	{
		alert(cfg_wlancfgother_language['amp_empty_para']);
		return false;
	}
	
	if (isValidWPAPskKey(value) == false)
	{
        if (megacablePwd == 1) {
            alert(cfg_wlancfgdetail_language['amp_wpskey_invalid_telmex']);
        } else {
            alert(cfg_wlancfgdetail_language['amp_wpskey_invalid']);
        }
		return false;
	}

	if (isValidStr(value) != '')
	{
		alert(cfg_wlancfgdetail_language['amp_wpa_psk'] + " "+ value + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + isValidStr(value));
		return false;
	}

    if (CfgModeWord.toUpperCase() == 'EGVDF2') {
        if (CheckPwdIsComplex(value) == false) {
            AlertEx(cfg_wlancfgdetail_language['amp_pwd_egvdf_weak_warning']);
            return false;
        }
    }

	return true;
}

function CheckSsidExist(ssid, WlanArr)
{
    for (i = 1; i < WlanArr.length - 1; i++)
    {
        if (WlanArr[i].ssid == ssid)
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
			return false;
		}
        else
        {
            continue;
        }
    }

    return true;
}

function stIndexMapping(index,portIndex)
{
    this.index = index;
    this.portIndex = portIndex;
}

function  stAssociatedDevice(domain,AssociatedDeviceMACAddress,X_HW_Uptime,X_HW_RxRate,X_HW_TxRate,X_HW_RSSI,X_HW_Noise,X_HW_SNR,X_HW_SingalQuality,X_HW_WorkingMode,X_HW_WMMStatus,X_HW_PSMode)
{
	this.domain = domain;
	this.AssociatedDeviceMACAddress = AssociatedDeviceMACAddress;
    this.X_HW_Uptime = X_HW_Uptime;
    this.X_HW_RxRate = X_HW_RxRate;
    this.X_HW_TxRate = X_HW_TxRate;
    this.X_HW_RSSI   = X_HW_RSSI;
    this.X_HW_Noise  = X_HW_Noise;
    this.X_HW_SNR    = X_HW_SNR;
    this.X_HW_SingalQuality  = X_HW_SingalQuality;
    this.X_HW_WorkingMode  = X_HW_WorkingMode;
    this.X_HW_WMMStatus  = X_HW_WMMStatus;
    this.X_HW_PSMode  = X_HW_PSMode;
    this.ssidname = 0;
}

function getInstIdByDomain(domain)
{
    if ((domain != undefined) && (domain != '')) {
        return parseInt(domain.substr(domain.lastIndexOf('.') + 1));
    }
}

function getWlanPortNumber(name)
{
    if ('' != name)
    {
		if(name.length > 4)
		{
			return parseInt(name.charAt(name.length - 2) + name.charAt(name.length - 1));    
		}
		else
		{
			return parseInt(name.charAt(name.length - 1)); 
		}
    }
}

function getIndexFromPort(index)
{
    for (var i = 0; i < WlanMap.length; i++)
    {
        if (index == WlanMap[i].portIndex)
        {
            return WlanMap[i].index;
        }
    }
}

function getPortFromIndex(index)
{
    for (var i = 0; i < WlanMap.length; i++)
    {
        if (index == WlanMap[i].index)
        {
            return WlanMap[i].portIndex;
        }
    }
}

var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';
var megacablePwd = '<%HW_WEB_GetFeatureSupport(FT_WLAN_MEGACABLEPWD);%>';

function isValidWPAPskKey(val)
{
    var len = val.length;
    var maxSize = 64;
    var minSize = 8;
	
	if ((TelMexFlag == 1) || (megacablePwd == 1)) {
		minSize = 10;
	}

    if ((isValidAscii(val) != '') && (CfgModeWord.toUpperCase() != "TTNET2")) {
       return false;
    }

    if ((len >= minSize) && (len < maxSize)) {
    	return true;
    } else if (len == maxSize) {
        for (i = 0; i < maxSize; i++) {
            if (isHexaDigit(val.charAt(i)) == false) {
                return false;
            }
        }
        return true;
    }
    
    return false;
}

var L2WifiFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_L2WIFI);%>';
var isStaWorkingModeShow = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>';
var IsSupportWlanFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';

function IsWlanAvailable()
{
	if(1 == IsSupportWlanFlag)
	{
		return true;
	}
	else
	{
		return false;
	}
}

var capInfo = '<%HW_WEB_GetSupportAttrMask();%>';

var wepCap = 1;
var fragCap = 1;
var radiusCap = 1;
var wps1Cap = 1;
var wapiCap = 1;
var cap11n = 1;
var cap11a = 1;
var capTkip = 1;
var capWPAPSK = 1;
var capWPAEAP = 1;
var capWPAWPA2PSK = 1;
var capWPAWPA2EAP = 1;
var capHT160 = 1;
var capHT80_80 = 1;
var capBandSteering = 1;
var capTXBF = 1;
var capAntiInterferenceMode = 1;
var capStaPinUnreboot = 0;
var capAirtimeFairness = 0;
var capMU_MIMO = 0;
var capApPinRefresh = 0;
var capWpa3 = 0;
var cap11ax = 0;
var capBcnInerval = 0;

function initWlanCap(freq)
{
    if(null == capInfo || '' == capInfo || capInfo.length < capNum*2)
    {
        return ;
    }

    var capNum = capInfo.length/2;

    var baseIdx = capNum * ((freq=="5G") ? 1 : 0);

    wepCap = parseInt(capInfo.charAt(0 + baseIdx));
    fragCap = parseInt(capInfo.charAt(1 + baseIdx));
    radiusCap = parseInt(capInfo.charAt(2 + baseIdx));
    wps1Cap = parseInt(capInfo.charAt(3 + baseIdx));
    wapiCap = parseInt(capInfo.charAt(4 + baseIdx));
    cap11n = parseInt(capInfo.charAt(5 + baseIdx));
    cap11a = parseInt(capInfo.charAt(6 + baseIdx));
    capTkip = parseInt(capInfo.charAt(7 + baseIdx));
    capWPAPSK = parseInt(capInfo.charAt(8 + baseIdx));
    capWPAEAP = parseInt(capInfo.charAt(9 + baseIdx));
    capWPAWPA2PSK = parseInt(capInfo.charAt(10 + baseIdx));
    capWPAWPA2EAP = parseInt(capInfo.charAt(11 + baseIdx));
	capHT160 = parseInt(capInfo.charAt(13 + baseIdx));
	capHT80_80 = parseInt(capInfo.charAt(14 + baseIdx));
	capBandSteering = parseInt(capInfo.charAt(15 + baseIdx));
	capTXBF = parseInt(capInfo.charAt(16 + baseIdx));
	capAntiInterferenceMode = parseInt(capInfo.charAt(23 + baseIdx));
	capStaPinUnreboot = parseInt(capInfo.charAt(25 + baseIdx));
	capMU_MIMO = parseInt(capInfo.charAt(28 + baseIdx));
	capApPinRefresh = parseInt(capInfo.charAt(33 + baseIdx));
	cap11ax = parseInt(capInfo.charAt(34 + baseIdx));
	capWpa3 = parseInt(capInfo.charAt(35 + baseIdx));
    capBcnInerval = parseInt(capInfo.charAt(43 + baseIdx));
    capAirtimeFairness = parseInt(capInfo.charAt(27 + baseIdx));
    if (CfgModeWord.toUpperCase() ==  "AISAP") {
        capAirtimeFairness = 0;
    }

}

var stapinlock = '<%HW_WEB_GetStaPinLock();%>';

function getPossibleChannels(freq, country, mode, width)
{
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "../common/WlanChannel.asp?&1=1",
            data :"freq="+freq+"&country="+country+"&standard="+mode + "&width="+width,
            success : function(data) {
                possibleChannels = data;
            }
        });
}

function isValidKey(val, size)
{
    var len = val.length;
    var dbSize = size * 2;
 
    if (isValidAscii(val) != '') { 
        return false;
    }

    if (len == size) {
        return true;
    } else if (len == dbSize) {
       for (i = 0; i < dbSize; i++) {
            if (isHexaDigit(val.charAt(i)) == false) {
                return false;
            }
       }

        return true;
    }

    return false;
}

function ltrim(str)
{ 
    return str.toString().replace(/(^\s*)/g,""); 
}

function InitDropDownListWithSelected(id, valueTextPair, selected)
{
	var obj = $('#' + id);
	if(0==obj.length || null==valueTextPair)
	{
		return ;
	}

	var isSelectedValid = false;

	obj.empty();
	
	for(var key in valueTextPair)
	{
		if((1 == valueTextPair[key].length) || (1 == valueTextPair[key][1]))
		{
			obj.append("<option value='" + key + "'>" + valueTextPair[key][0] + "</option>");
			
			if(!isSelectedValid && selected==key)
	        {
	        	isSelectedValid = true;
	        	setSelect(id, selected);
	        }
		}
	}
}


var tdeSpecailChar = ['Á','á','À','à','É','é','Í','í','Ó','ó',
                      'Ú','ú','Â','â','Ê','ê','Î','î','ö','Û',
					  'û','Ü','ü','Ç','ç','Ã','ã','Õ','õ','Ñ',
					  'ñ','€','´','·','¸','Ò','ò','Ù','ù','È',
					  'è','Ì','ì','Ï','ï','ª','¿','º'];
 

function checkSepcailStrValid(val)
{
    var findVar = 0;
	
    for ( var i = 0 ; i < val.length ; i++ )
	{
		var ch = val.charAt(i);
		if (ch >= ' ' && ch <=  '~')
		{
		    continue;
		}		
		else
		{
		    findVar = 0;
		    for (var j = 0; j < tdeSpecailChar.length; j++)
	        {
		        if(ch == tdeSpecailChar[j])
		        {
			        findVar = 1;
			        break;
		        }
	        }
			
			if (1 != findVar)
			{
			    return false;
			}
	        
		}
	}
	return true;
}

function getTDEStringActualLen(val)
{
    var actualLen = 0;
	for( var i = 0; i < val.length; i++ )
	{
	    var ch = val.charAt(i);
		if (ch >= ' ' && ch <=  '~')
		{
		    actualLen = actualLen + 1;
		}
        else
        {
		     if('€' == ch || '•' == ch)
			 {
			     actualLen = actualLen + 3;
			 }
			 else
			 {
			     actualLen = actualLen + 2;
			 }
		} 		
	}
	
	return actualLen;
}

function isValidWPAPskSepcialKey(value)
{
    var len = value.length;
    var maxSize = 63;
    var minSize = 8;
	var i = 0;
	var actualLen = 0;
	var spaceNum = 0;
	
    if (value == '')
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_invalid']);
        return false;
    }
	
	if ( len < minSize ||  len > maxSize )
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_invalid']);
    	return false;
    }

    if(value.charAt(0)==' ' || value.charAt(len-1)==' ')
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_space_invalid']);
    	return false;
    }

    for(i=0, spaceNum=0; (i < value.length) && (spaceNum != 2); i++)
    {
        if(value.charAt(i) == ' ')
        {
            spaceNum++;
        }
        else
        {
            spaceNum = 0;
        }
    }

    if(i != value.length)
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_space_invalid']);
    	return false;
    }
	
	if (true != checkSepcailStrValid(value))
    {
        AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_invalid']);
        return false;
    }
	
	actualLen = getTDEStringActualLen(value);
	if( actualLen < minSize  || actualLen > maxSize )
	{
	    AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_invalid']);
	    return false;
	}
	
    return true;
}

function checkHexNumWithLen(val, len)
{
    if(null == val || len != val.length)
        return false;

    for(var i=0; i<len; i++)
    {
        if (isHexaDigit(val.charAt(i)) == false)
        {
            return false;
        }
    }
    
    return true;
}

function isValidRaiusKey(val)
{
   if (isValidAscii(val) != '')
   { 
      return false;
   }
    
   return true;
}

function isValidDecimalNum(inputNum)
{
	var int1 = parseInt(inputNum, 10).toString(10);
	var int2 = inputNum.toString(10);
	if(!(int1 == int2))
	{
		return false;
	}
	else
	{
		return true;
	}
}

function isValidRadiusPort(wlRadiusPort)
{
    var port = parseInt(wlRadiusPort,10);

    if (!isInteger(wlRadiusPort) || port < 0 || port > 65535 
	|| isValidDecimalNum(wlRadiusPort) == false )
    {
        return false;
    }

    return true;
}

function isValidAssoc(deviceNum)
{
    if(128 == '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_STA_NUM.UINT32);%>')
    {
        if (isPlusInteger(deviceNum) == false 
		|| isValidDecimalNum(deviceNum) == false
        || parseInt(deviceNum,10) < 1
        || parseInt(deviceNum,10) > 128)
        {
            AlertEx(cfg_wlancfgother_language['amp_dev_num_128']);
            return false;
        }
    }
    else if('64' == '<%HW_WEB_GetSPEC(AMP_SPEC_MAX_STA_NUM.UINT32);%>')
    {
        if (isPlusInteger(deviceNum) == false
		|| isValidDecimalNum(deviceNum) == false
        || parseInt(deviceNum,10) < 1
        || parseInt(deviceNum,10) > 64)
        {
            AlertEx(cfg_wlancfgother_language['amp_dev_num_64']);
            return false;
        }
    } else if('<%HW_WEB_GetSPEC(AMP_SPEC_MAX_STA_NUM.UINT32);%>' == '40') {
        if ((isPlusInteger(deviceNum) == false) || (isValidDecimalNum(deviceNum) == false) ||
            (parseInt(deviceNum,10) < 1) || (parseInt(deviceNum,10) > 40)) {
            AlertEx(cfg_wlancfgother_language['amp_dev_num_40']);
            return false;
        }
    } else {
        if (isPlusInteger(deviceNum) == false
		|| isValidDecimalNum(deviceNum) == false
        || parseInt(deviceNum,10) < 1
        || parseInt(deviceNum,10) > 32)
        {
            AlertEx(cfg_wlancfgother_language['amp_dev_num']);
            return false;
        }
    }
}

function GetRandomNum(length) {
    var numArr = new Array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
    var num = '';
    for (var i = 0; i < length; i++) {
        num += numArr[Math.floor(Math.random() * 16)];
    }

    return num;
}

var XHWGlobalConfigArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_GlobalConfig, BandSteeringPolicy, StXHWGlobalConfig, EXTEND);%>;
var XHWGlobalConfig = XHWGlobalConfigArr[0];
if (XHWGlobalConfig == null) {
    XHWGlobalConfig = new StXHWGlobalConfig("InternetGatewayDevice.LANDevice.1.WiFi.X_HW_GlobalConfig", "0");
}

function StXHWGlobalConfig(domain, BandSteeringPolicy) {
    this.domain = domain;
    this.BandSteeringPolicy = BandSteeringPolicy;
}

function IsShowBSD() {
    if ((capBandSteering == 1) && (DoubleFreqFlag == 1) && (turkcellFlag == 1) ) {
        return true;
    }

    return false;
}

function GetChineseNumLength(val){
    var strlen = 0;
    for (var i = 0; i < val.length; i++) {
        if(val.charCodeAt(i) > 255) {
            strlen += 3;
        } else {
            strlen++;
        }
    }

    return strlen;
}

function IsPskKeyValid_PLDT(value) {
    var complexValue = 0;

    if (value.length < 8) {
        return false;
    } else if (value.length >= 15) {
        return true;
    }

    if (isLowercaseInString(value)) {
        complexValue++;
    }

    if (isUppercaseInString(value)) {
        complexValue++;
    }

    if (isDigitInString(value)) {
        complexValue++;
    }

    if (isSpecialCharacterNoSpace(value)) {
        complexValue++;
    }
    
    if (complexValue < 3) {
        return false;
    }
    
    return true;
}

function egvdfPwdStrengthcheck(id, pwdid)
{
    var score = 0;
    var password = getElementById(id).value;

    if (password.match(/[a-z]/)) {
        score++;
    }

    if (password.match(/[A-Z]/)) {
        score++;
    }

    if (password.match(/\d/)) {
        score++;
    }

    if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) {
        score++;
    }

    if (password.length < 8) {
        score = 1;
    }

    if (score < 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=23+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FF0000";
    } else if (score === 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=60+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FFA500";
    } else if (score >= 3) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=100+"%";
        getElementById(pwdid).style.borderBottom="10px solid #008000";
    }
}

function pwdStrengthcheck(id, pwdid)
{
    if (CfgModeWord.toUpperCase() == "EGVDF2") {
        egvdfPwdStrengthcheck(id,pwdid);
        return;
    }
    var score = 0;
    var password1 = getElementById(id).value;
    if (password1.length > 8) {
        score++;
    }

    if (password1.match(/[a-z]/)) {
        score++;
    }

    if (password1.match(/[A-Z]/)) {
        score++;
    }

    if (password1.match(/\d/)) {
        score++;
    }

    if (password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) {
        score++;
    }

    if (password1.length > 12) {
        score++;
    }

    if ((score === 0) || (score === 1)) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=16.6+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FF0000";
    } else if (score === 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=33.2+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FF0000";
    } else if (score === 3) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=49.8+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FFA500";
    } else if (score === 4) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=66.4+"%";
        getElementById(pwdid).style.borderBottom="4px solid #FFA500";
    } else if (score === 5) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=83+"%";
        getElementById(pwdid).style.borderBottom="4px solid #008000";
    } else if (score >= 6) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=100+"%";
        getElementById(pwdid).style.borderBottom="4px solid #008000";
    }
}

function HidewlWpaPskDisplayBaseValue(mode, authenticationMode, element)
{
    if (((mode === 'WPA3') || (mode === 'WPA2/WPA3')) && (authenticationMode !== 'EAPAuthentication')) {
        document.getElementById(element).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
        if (megacablePwd == 1) {
            document.getElementById(element).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63_telmex'];
        }
    } else if (megacablePwd == 1) {
        document.getElementById(element).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_telmex'];
    } else {
        document.getElementById(element).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote' + ('1' == kppUsedFlag ? '_63' : '')];
    }

    if (preflag == 1) {
        document.getElementById(element).innerHTML  = cfg_wlancfgdetail_language['amp_wpa_psknote_pldt'];
    }

    if (CfgModeWord.toUpperCase() === "EGVDF2") {
        document.getElementById(element).innerHTML = "(The password must be at least 8 characters long and must contain all of the following: uppercase characters, lowercase characters, digits (0-9), special characters.)"
    }
}

function HidewlWpaPskDisplayBaseAuthMode(authMode, element)
{
    if ((authMode === "wpa3-psk") || (authMode === "wpa2/wpa3-psk")) {
        document.getElementById(element).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
    } else {
        document.getElementById(element).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote' + ('1' == kppUsedFlag ? '_63' : '')];
    }
    
    if (megacablePwd == 1) {
        var wpaPskNote = cfg_wlancfgdetail_language['amp_wpa_psknote_telmex'];
        if ((authMode == "wpa3-psk") || (authMode == "wpa2/wpa3-psk") || (kppUsedFlag == 1)) {
            wpaPskNote = cfg_wlancfgdetail_language['amp_wpa_psknote_63_telmex']; 
        }
        document.getElementById(element).innerHTML = wpaPskNote;
    }

    if (preflag == 1) {
        document.getElementById(element).innerHTML  = cfg_wlancfgdetail_language['amp_wpa_psknote_pldt'];
    }

    if (CfgModeWord.toUpperCase() === "EGVDF2") {
        document.getElementById(element).innerHTML = "(The password must be at least 8 characters long and must contain all of the following: uppercase characters, lowercase characters, digits (0-9), special characters.)"
    }
}

function checkPasswordStrength(id)
{
    var score = 0;
    var passWord = document.getElementById(id).value;
    if (passWord.length < 8) {
        return 0;
    }
    if (isLowercaseInString(passWord)) {
        score++;
    }
    if (isUppercaseInString(passWord)) {
        score++;
    }
    if (isDigitInString(passWord)) {
        score++;
    }
    if (isSpecialCharacterNoSpace(passWord)) {
        score++;
    }
    return score;
}

function AlertSsidNeedCfg() {
    if (needChangePwdFlag != 1) {
        return;
    }
    var baseInstFacKeyChgF = ajaxGetAspData('./getBaseInstFacKey.asp');
    var baseInstFacKeyChgF2g = baseInstFacKeyChgF.split(',')[0];
    var baseInstFacKeyChgF5g = baseInstFacKeyChgF.split(',')[1];
    if (DoubleFreqFlag == 1) {
        if ((baseInstFacKeyChgF2g == 0) && (baseInstFacKeyChgF5g == 0)) {
            AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change']);
        } else if ((baseInstFacKeyChgF2g == 0) && (baseInstFacKeyChgF5g == 1)) {
            AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change_2G']);
        } else if ((baseInstFacKeyChgF2g == 1) && (baseInstFacKeyChgF5g == 0)) {
            AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change_5G']);
        }
    } else {
        if (baseInstFacKeyChgF2g == 0) {
            AlertEx(cfg_wlancfgbasic_language['amp_wlan_pwd_need_change']);
        }
      }
  }

function CheckPwdComponet(str, caseFlag, digitFlag, specialCharacterFlag, score) {
    var i = 0;

    if (caseFlag) {
        if (isLowercaseInString(str)) {
            i++;
        }

        if (isUppercaseInString(str)) {
            i++;
        }
    } else {
        if (isUppercaseInString(str) || isLowercaseInString(str)) {
            i++;
        }
    }

    if ((digitFlag) && (isDigitInString(str))) {
        i++;
    }

    if ((specialCharacterFlag) && (isSpecialCharacterNoSpace(str))) {
        i++;
    }

    if (i >= score) {
        return true;
    }

    return false;
}

function CheckPwdIsComplex(str) {
    var caseFlag = true;
    var digitFlag = true;
    var specialCharacterFlag = true;
    var score = 4;

    if (str.length < pwdLen) {
        return false;
    }

    return CheckPwdComponet(str, caseFlag, digitFlag, specialCharacterFlag, score);
}
