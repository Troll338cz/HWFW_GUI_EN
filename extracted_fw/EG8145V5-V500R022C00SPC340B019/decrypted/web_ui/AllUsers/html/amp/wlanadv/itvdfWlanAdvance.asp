<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, IT_VDF_wlan_advance_language, cfg_wlancfgadvance_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>Settings</title>
<script language="JavaScript" type="text/javascript">
var ZigBeeSupport = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IOT_ZIGBEE_EXIST);%>';
var ZigbeeSwitch = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IOT_ZIGBEE.Enable);%>';
var ZigBeeEnable = false;
if(('1' == ZigBeeSupport)&&(1 == ZigbeeSwitch))
{
    ZigBeeEnable = true;
}

var possibleChannels = "";

var countryIT = 'IT';

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

function stLanDevice(domain, WlanCfg)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
}

var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];

var enbl = LanDevice.WlanCfg;

function stWlan(domain,enable,name,ssid,BeaconType,BasicEncrypt,BasicAuth,WPAEncrypt,WPAAuth,IEEE11iEncrypt,IEEE11iAuth,WPAand11iEncrypt,WPAand11iAuth,Channel,LowerLayers, X_HW_Standard, RegulatoryDomain, X_HW_HT20, X_HW_ServiceEnable, wlHide)
{
    this.domain = domain;
    this.enable = enable;
    this.name = name;
    this.ssid = ssid;
    this.BeaconType = BeaconType;    
    this.BasicAuth = BasicAuth;
	this.BasicEncrypt = BasicEncrypt;    
    this.WPAAuth = WPAAuth;
	this.WPAEncrypt = WPAEncrypt;    
    this.IEEE11iAuth = IEEE11iAuth;
	this.IEEE11iEncrypt = IEEE11iEncrypt;
	this.WPAand11iAuth = WPAand11iAuth;
	this.WPAand11iEncrypt = WPAand11iEncrypt;
	this.Channel = Channel;	
	this.LowerLayers = LowerLayers;
    this.X_HW_Standard = X_HW_Standard;
    this.RegulatoryDomain = RegulatoryDomain;
    this.X_HW_HT20 = X_HW_HT20;
	this.X_HW_ServiceEnable = X_HW_ServiceEnable;
	this.wlHide = wlHide;
}

var WlanInfo = new Array();
WlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Enable|Name|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|Channel|LowerLayers|X_HW_Standard|RegulatoryDomain|X_HW_HT20|X_HW_ServiceEnable|SSIDAdvertisementEnabled,stWlan);%>;  

var WlanInfo2G;
var WlanInfo5G = '-1';
for(var i = 0; i < WlanInfo.length - 1; i++)
{
	if (1 == getWlanInstFromDomain(WlanInfo[i].domain))
	{
		WlanInfo2G = WlanInfo[i];
		continue;
	}
	else if (1 == DoubleFreqFlag && 5 == getWlanInstFromDomain(WlanInfo[i].domain))
	{
		WlanInfo5G = WlanInfo[i];
		continue;
	}
}

function stInitOption(value, innerText)
{
	this.value = value;
	this.innerText = innerText;
}

var HwStandardValArr = { '11a' : '802.11a', 
						 '11na' : '802.11a/n', 
	                     '11ac' : '802.11a/n/ac',
						 '11b' : '802.11b',
						 '11g' : '802.11g',
						 '11n' : '802.11n',
						 '11bg' : '802.11b/g',
						 '11bgn' : '802.11b/g/n'
	                   };	

var standardValArr =  { 
	                  '11b' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_b'], 
	                  '11g' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_g'], 
	                  '11n' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_n'], 
	                  '11bg' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_bg'], 
					  '11gn' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_gn'],
	                  '11bgn' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_bgn'], 
	                  '11ac' : IT_VDF_wlan_advance_language['amp_advance_wifi_mode_mix_ac']
	                };
					   
var wifiModeVal;
function setSelShow(obj)
{
	var text = obj.innerHTML;
	var dropdownShowId =  obj.offsetParent.firstChild.id;
	
	$('#'+dropdownShowId).html(text);
	SetClickFlag(false);
	$('#'+dropdownShowId).css("background-image","url('../../../images/arrow-down.png')");
}

function wifiModeSelValue(obj)
{
	setSelShow(obj);
	wifiModeVal = obj.getAttribute('dataValue');
	WifiModeChange();
}

function setWifiModeSel(valArray, defaultVal)
{
	var wifiModeArr = new Array();
	var wifiModeValArr = (valArray != null) ? valArray : HwStandardValArr;
	for (var key in wifiModeValArr)
	{
		wifiModeArr.push([wifiModeValArr[key],key]);
	}
	
	var DefaultValue = (defaultVal != null && wifiModeValArr[defaultVal] != null) ? [wifiModeValArr[defaultVal],defaultVal] : wifiModeArr[0];
	wifiModeVal = DefaultValue[1];
	createWlanDropdown("SelWifiMode", DefaultValue, "220px", wifiModeArr, "wifiModeSelValue(this);");
}

var allBandWidthArr = { '0' : IT_VDF_wlan_advance_language['amp_advance_width_auto2040'], 
						  '1' : IT_VDF_wlan_advance_language['amp_advance_width_20'],
						  '2' : IT_VDF_wlan_advance_language['amp_advance_width_40']
					    };	
							
var bandWidthVal;
function bandWidthSelValue(obj)
{
	setSelShow(obj);
	bandWidthVal = obj.getAttribute('dataValue');
	WifiModeChange();
}

function setBandWidthSel(valArray, defaultVal)
{
	var bandWidthArr = new Array();
	for (var key in valArray)
	{
		bandWidthArr.push([valArray[key],key]);
	}
	
	
	var DefaultValue = (defaultVal != null && valArray[defaultVal] != null) ? [valArray[defaultVal],defaultVal] : bandWidthArr[0];
	bandWidthVal = DefaultValue[1];
	createWlanDropdown("SelBandWidth", DefaultValue, "220px", bandWidthArr, "bandWidthSelValue(this);");
}

function getChannelText(channelVal)
{
	if ( 0 == channelVal)
	{
		return IT_VDF_wlan_advance_language['amp_advance_channel_wide_auto'];
	}
	
	return channelVal;
}
							
var selchannel2GVal;
function channel2GSelValue(obj)
{
	setSelShow(obj);
	selchannel2GVal = obj.getAttribute('dataValue');
}

function setChannel2GSel(valArray, defaultVal)
{
	var channel2GArr = new Array();
	for (var key in valArray)
	{
		channel2GArr.push([valArray[key],key]);
	}
	
	var DefaultValue = (defaultVal != null && valArray[defaultVal] != null) ? [valArray[defaultVal],defaultVal]: channel2GArr[0];
	selchannel2GVal = DefaultValue[1];
	createWlanDropdown("Selchannel2G", DefaultValue, "220px", channel2GArr, "channel2GSelValue(this);");
}

var selchannel5GVal;
function channel5GSelValue(obj)
{
	setSelShow(obj);
	selchannel5GVal = obj.getAttribute('dataValue');
}

function setChannel5GSel(valArray, defaultVal)
{
	var channel5GArr = new Array();
	for (var key in valArray)
	{
		channel5GArr.push([valArray[key],key]);
	}
	
	var DefaultValue = (defaultVal != null && valArray[defaultVal] != null) ? [valArray[defaultVal],defaultVal]: channel5GArr[0];
	selchannel5GVal = DefaultValue[1];
	createWlanDropdown("Selchannel5G", DefaultValue, "220px", channel5GArr, "channel5GSelValue(this);");
}

cap11n = parseInt(capInfo.charAt(5));
function InitSelWifiMode()
{
    var wlfiMode = wifiModeVal;
	var isshow11n = 0;    
	
    var BeaconType = WlanInfo2G.BeaconType;    
    var BasicEncryptionModes =  WlanInfo2G.BasicEncrypt;       
    var WPAEncryptionModes  = WlanInfo2G.WPAEncrypt;
    var IEEE11iEncryptionModes = WlanInfo2G.IEEE11iEncrypt;
    var X_HW_WPAand11iEncryptionModes = WlanInfo2G.WPAand11iEncrypt;
       
    if ((BeaconType == "Basic") && (BasicEncryptionModes == "WEPEncryption"))
    {
        isshow11n += 1;
    }
    else if ((BeaconType =="WPA" )
                   && ((WPAEncryptionModes == "TKIPEncryption")||(WPAEncryptionModes == "TKIPandAESEncryption")))
    {
		isshow11n += 1;
    }
    else if ( ((BeaconType =="11i" ) || (BeaconType =="WPA2") )
                   && ((IEEE11iEncryptionModes == "TKIPEncryption")||(IEEE11iEncryptionModes == "TKIPandAESEncryption")) )
    {
        isshow11n += 1;
    }
    else if ( ((BeaconType =="WPAand11i" ) || (BeaconType =="WPA/WPA2") )
                   && ((X_HW_WPAand11iEncryptionModes == "TKIPEncryption")||(X_HW_WPAand11iEncryptionModes == "TKIPandAESEncryption")))
    {
        isshow11n += 1;
    }
    
	isshow11n += (1 - cap11n);
    
    var standardArr = { 
	                  '11b' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_b'], 0], 
	                  '11g' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_g'], 0], 
	                  '11n' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_n'], 0], 
	                  '11bg' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_bg'], 0], 
					  '11gn' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_gn'], 0],
	                  '11bgn' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_bgn'], 0], 
	                  '11ac' : [IT_VDF_wlan_advance_language['amp_advance_wifi_mode_mix_ac'], 0]
	                };
					
	standardArr['11n'][1] = (0 == isshow11n);
	standardArr['11b'][1] = 1;
	standardArr['11g'][1] = 1;
    standardArr['11bg'][1] = 1;
    standardArr['11bgn'][1] = 1;
	standardArr['11bgn'][1] = 1;
	
	var standardValArrShow = new Object();
	for(var key in standardArr)
	{
		if((1 == standardArr[key].length) || (1 == standardArr[key][1]))
		{
			standardValArrShow[key] = standardArr[key][0];
		}
	}
	
	setWifiModeSel(standardValArrShow, wlfiMode);
}          

function InitDropDownList(id, ArrayOption)
{
    var Control = getElById(id);
    var i = 0;   

    for(i = 0; i < ArrayOption.length; i++)
    {
        var Option = document.createElement("Option");
        Option.value = ArrayOption[i].value;
        Option.innerText = ArrayOption[i].innerText;
        Option.text = ArrayOption[i].innerText;
        Control.appendChild(Option);
    }
}

function InitChannel()
{
	InitChannelList('Selchannel2G');
	if (1 == DoubleFreqFlag)
	{
		InitChannelList('Selchannel5G');
	}
}

function InitChannelList(id)
{
	 if((1 == DoubleFreqFlag) && ("Selchannel5G" == id))
	{
		var ArrayChannel = { '0' : IT_VDF_wlan_advance_language['amp_advance_channel_wide_auto'], 
							 '36' : 36, '40' : 40, '44' : 44, '48' : 48,
							 '52' : 52, '56' : 56, '60': 60, '64' : 64, 
							 '100' : 100, '104' : 104, '108' : 108, '112' : 112, 
							 '116' : 116, '120' : 120, '124' : 124, '128' : 128, 
							 '132' : 132, '136' : 136, '140' : 140, '144' : 144, 
							 '149' : 149, '153' : 153, '157' : 157, '161' : 161, 
							 '165' : 165
							};	
		setChannel5GSel(ArrayChannel);
	}
	else
	{
		var ArrayChannel = { '0' : IT_VDF_wlan_advance_language['amp_advance_channel_wide_auto'], 
							 '1' : 1, '2' : 2, '3' : 3, '4' : 4,
							 '5' : 5, '6' : 6, '7': 7, '8' : 8, 
							 '9' : 9, '10' : 10, '11' : 11, '12' : 12, 
							 '13' : 13, '14' : 14
							};	
		setChannel2GSel(ArrayChannel);
	}

}

function InitChannelWidthList(id)
{   
    if( ZigBeeEnable == true && 'SelBandWidth' == id)
	{
	    var channelWidthArray = { '0' : IT_VDF_wlan_advance_language['amp_advance_width_auto2040'], 
							      '1' : IT_VDF_wlan_advance_language['amp_advance_width_20']
							    };									 
	   
		setBandWidthSel(channelWidthArray);
	    return;
	}
	
    setBandWidthSel(allBandWidthArr);
}

function InitWlanBasicDropDownList()
{
	InitChannel();
	InitChannelWidthList("SelBandWidth");
	setWifiModeSel();
}

function InitSelValue()
{
	selchannel2GVal = WlanInfo2G.Channel;
	setDropdownSelVal('Selchannel2G', getChannelText(selchannel2GVal));
	if (1 == DoubleFreqFlag)
	{
		selchannel5GVal = WlanInfo5G.Channel;
		setDropdownSelVal('Selchannel5G', getChannelText(selchannel5GVal));
	}
	
	bandWidthVal = WlanInfo2G.X_HW_HT20;
	setDropdownSelVal('SelBandWidth', allBandWidthArr[bandWidthVal]);
	
	wifiModeVal = WlanInfo2G.X_HW_Standard;
	setDropdownSelVal('SelWifiMode', standardValArr[wifiModeVal]);
}

function WifiModeChange()
{
	var mode = wifiModeVal;
	var channelWidthRestore = bandWidthVal;
	var channel = selchannel2GVal;
    var country = countryIT;

    if ((14 == channel) && ("11b" != mode))
    {
		selchannel2GVal = '0';
		setDropdownSelVal('Selchannel2G', getChannelText(selchannel2GVal));
    }

	var selBandWidthArr = new Object();
    if ((mode == "11b") || (mode == "11g") || (mode == "11bg") || (mode == "11a"))
    {    
		selBandWidthArr[1] = IT_VDF_wlan_advance_language['amp_advance_width_20'];
		setBandWidthSel(selBandWidthArr);
    }
    else
    {
        if(ZigBeeEnable == true)
		{
			selBandWidthArr[0] = IT_VDF_wlan_advance_language['amp_advance_width_auto2040'];
			selBandWidthArr[1] = IT_VDF_wlan_advance_language['amp_advance_width_20'];
		}
        else
        {
			selBandWidthArr[0] = IT_VDF_wlan_advance_language['amp_advance_width_auto2040'];
			selBandWidthArr[1] = IT_VDF_wlan_advance_language['amp_advance_width_20'];
			selBandWidthArr[2] = IT_VDF_wlan_advance_language['amp_advance_width_40'];
        }
		
		setBandWidthSel(selBandWidthArr);
        
        if (3 != channelWidthRestore)
        {
			bandWidthVal = channelWidthRestore;
	        setDropdownSelVal('SelBandWidth', allBandWidthArr[bandWidthVal]);
        }
        else
        {
			bandWidthVal = '0';
	        setDropdownSelVal('SelBandWidth', allBandWidthArr[bandWidthVal]);
        }
    }

	var width = bandWidthVal;
	var freq = '2G';
	loadChannelListByFreq(freq, country, mode, width);
}

function loadChannelListByFreq(freq, country, mode, width)
{
    var index = 0;
    var i;
	var WebChannel = ('2G' == freq) ? selchannel2GVal : selchannel5GVal;
    var WebChannelValid = 0;
    var ShowChannels;    
		
	getPossibleChannels(freq, country, mode, width);
	ShowChannels = possibleChannels.split(',');

	var selChannelArrey = new Object();
	selChannelArrey[0] = IT_VDF_wlan_advance_language['amp_advance_channel_wide_auto'];
	    
    for (var j=1; j<=ShowChannels.length; j++)
    {
        if(j==ShowChannels.length && 5 != width)
        {
            for(i = 0; i < ShowChannels[ShowChannels.length-1].length;i++)
            {
                if((ShowChannels[ShowChannels.length-1].charCodeAt(i)< 0x30)||(ShowChannels[ShowChannels.length-1].charCodeAt(i) > 0x39))
                {
                    index = i;
                    break;
                    
                }
            }
            ShowChannels[j-1] = ShowChannels[ShowChannels.length-1].substring(0,index);
        }
        
        if (WebChannel == ShowChannels[j-1])
        {
            WebChannelValid = 1;
        }
        if("" != ShowChannels[j-1])
        {
			selChannelArrey[ShowChannels[j-1]] = ShowChannels[j-1];
        }
    }

	if ('2G' == freq)
	{
		setChannel2GSel(selChannelArrey);
	}
	else 
	{
		setChannel5GSel(selChannelArrey);
	}
	
    if (1 == WebChannelValid)
    {
		if ('2G' == freq)
		{
			selchannel2GVal = WebChannel;
			setDropdownSelVal('Selchannel2G', getChannelText(selchannel2GVal));
		}
		else
		{
			selchannel5GVal = WebChannel;
			setDropdownSelVal('Selchannel5G', getChannelText(selchannel5GVal));
		}
    }
    else
    {
		if ('2G' == freq)
		{
			selchannel2GVal = '0';
			setDropdownSelVal('Selchannel2G', getChannelText(selchannel2GVal));
		}
		else
		{
			selchannel5GVal = '0';
			setDropdownSelVal('Selchannel5G', getChannelText(selchannel5GVal));
		}
    }
}

function loadChannelList5G()
{
	var mode = '11ac';
	var width = '3';
	var freq = '5G';
	var country = countryIT;
	loadChannelListByFreq(freq, country, mode, width);
}

function LoadBtnBindText()
{
    var all = document.getElementsByTagName("input");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (IT_VDF_wlan_advance_language[b.getAttribute("BindText")]) 
        {
            b.value = IT_VDF_wlan_advance_language[b.getAttribute("BindText")];
        }
    }
}

function LoadConfig()
{
	LoadBtnBindText();
	if (1 != enbl)
	{
		setDisplay('Div2G', 0);
		setDisplay('Div5G', 0);
		setDisplay('DivApply', 0);
		return;
	}
	
	InitWlanBasicDropDownList();
	InitSelValue();
	
	InitSelWifiMode();
	WifiModeChange();
	
	if(1 == DoubleFreqFlag)
	{
		getElById('Div5G').style.display = '';
		loadChannelList5G();
	}
	
	setDisplay('content', 1);
}

function CancelConfig()
{
	LoadConfig();
}	

function LoadFrame()
{
	LoadConfig();
}

var processingState = 0;
function checkProcessingState() {
    getProcessingState();
    return processingState === '1';
}

function getProcessingState() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "getProcessState.asp",
        success : function(data) {
            processingState = data;
        }
    });
}

function CheckForm(type)
{
    if (checkProcessingState()) {
        AlertEx(cfg_wlancfgadvance_language['amp_config_busy']);
        return false;
    }

	if((selchannel2GVal == "") || (bandWidthVal == "")|| (wifiModeVal == ""))
    {
        AlertEx(IT_VDF_wlan_advance_language['amp_advance_empty']);
        return false;
    }
	else if ((1 == DoubleFreqFlag) && (selchannel5GVal == ""))
	{
		AlertEx(IT_VDF_wlan_advance_language['amp_advance_empty']);
        return false;
	}

	if((WlanInfo2G.Channel == selchannel2GVal) && (WlanInfo2G.X_HW_HT20 == bandWidthVal) 
		&& (WlanInfo2G.X_HW_Standard == wifiModeVal)
		&& ((1 == DoubleFreqFlag && WlanInfo5G.Channel == selchannel5GVal) || (1 != DoubleFreqFlag)))
	{
		return false;
	}
	
    return true;
}

function AddSubmitParam(Form,type)
{
	Form.addParameter('x.Channel',selchannel2GVal);
    if (selchannel2GVal == 0)
    {
        Form.addParameter('x.AutoChannelEnable',1); 
    }
    else
    {
		Form.addParameter('x.AutoChannelEnable',0);
    }

	Form.addParameter('x.X_HW_HT20', bandWidthVal);
	Form.addParameter('x.X_HW_Standard', wifiModeVal);
	
	if (1 == DoubleFreqFlag)
	{
		Form.addParameter('y.Channel', selchannel5GVal);
		if (selchannel5GVal == 0)
		{
			Form.addParameter('y.AutoChannelEnable',1); 
		}
		else
		{
			Form.addParameter('y.AutoChannelEnable',0);
		}
	}
	
	if (1 == DoubleFreqFlag)
    {
        Form.setAction('set.cgi?x=' + WlanInfo2G.domain
                       + '&y=' + WlanInfo5G.domain
                       + '&RequestFile=html/amp/wlanadv/itvdfWlanAdvance.asp');
	}
	else
	{
		 Form.setAction('set.cgi?x=' + WlanInfo2G.domain
                       + '&RequestFile=html/amp/wlanadv/itvdfWlanAdvance.asp');
	}
	
    setDisable('applyButton', 1);
    setDisable('cancelButton', 1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
}

</script>
<style type="text/css">
.btn-apply-color {
	background-color: #b141ad !important;
}

.row .left{
  float: none;
}

</style>

</head>
<body onLoad="LoadFrame();">
	<div>
		<h1 style="font-family:'Arial';">
			<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_title']);</script></span>
		</h1>
		<h2><span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_explain']);</script></span></h2>
		
		<div id="content" class="content-settings" style="display:none">
			<div id="Div2G">
			<h3><span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_2G']);</script></span></h3>
			<div class="h3-content">
				<div class="row">
					<div class="left">
						<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_wifi_mode']);</script></span> 
					</div>
					<div class="right" style="width: 500px; position: relative; height:50px;">
						<div class="iframeDropLog">
							<div id="SelWifiMode" class="IframeDropdown" style="left: 55.5%; top: 5px; z-index: 99;">
							</div>
						</div>
					</div>
				</div>
  
				<div class="row">
					<div class="left line">
						<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_bandwidth']);</script></span>   
					</div>
					<div class="right line" style="width: 500px; position: relative; height:50px;">
						<div class="iframeDropLog">
						<div id="SelBandWidth" class="IframeDropdown" style="left: 55.5%; top: 5px; z-index: 89;">
						</div>	
						</div>							
					</div>
				</div>
				<div class="row">
					<div class="left line">
						<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_channel']);</script></span>    
					</div>
					<div class="right line" style="width: 500px; position: relative; height:50px;">
						<div class="iframeDropLog">
						<div id="Selchannel2G" class="IframeDropdown" style="left: 55.5%; top: 5px; z-index: 79;">
						</div>	
						</div>
					</div>
				</div>
			</div>
			</div>

			<div id='Div5G' style="display:none;">
			<h3>
				<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_5G']);</script></span>
			</h3>
			<div class="h3-content">
				<div class="row">
					<div class="left">
						<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_wifi_mode']);</script></span>  
					</div>
					<div class="right">
						<span id='SpanWifiMode5G' value='11ac'>
							<script>document.write(IT_VDF_wlan_advance_language['amp_advance_wifi_mode_ac']);</script>
						</span>
					</div>
				</div>
				<div class="row">
					<div class="left line">
						<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_bandwidth']);</script></span>  
					</div>
					<div class="right line">
						<span id='SpanBandWidth5G' value='3'>
							<script>document.write(IT_VDF_wlan_advance_language['amp_advance_bandwidth_204080']);</script>
						</span>
					</div>
				</div>
				<div class="row">
					<div class="left line">
						<span><script>document.write(IT_VDF_wlan_advance_language['amp_advance_channel']);</script></span>  
					</div>
					<div class="right line" style="width: 500px; position: relative; height:50px;">
						<div class="iframeDropLog">
						<div id="Selchannel5G" class="IframeDropdown" style="left: 55.5%; top: 5px; z-index: 69;">
						</div>	
						</div>
					</div>
				</div>
			</div>
			</div>

			<div id='DivApply' class="clearfix apply-cancel">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
				<input id="cancelButton" class="button button-cancel" BindText="amp_btn_cancel" type="button" onclick='CancelConfig()'>
				<input id="applyButton" class="button button-apply btn-apply-color" BindText="amp_btn_apply" type="button" onClick="Submit()">		
			</div>
		
			<div id ='DivEmpty'></div>
		</div>
	</div>
</body>
</html>
