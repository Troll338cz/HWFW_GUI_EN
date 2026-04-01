<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(ahcode.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="Javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>

<style>
.width_per32 {
	width: 32%;
}
.width_per68 {
	width: 68%;
}
.tabal_noborder_bg {
	padding:0px 0px 10px 0px;
	background-color: #FAFAFA;
}
.Selectmacaddr{
	width: 160px;
}

.helpclass {
	font-size:14px;
	color: #005c8b;
	cursor:pointer;
	white-space:nowrap;
}

.helpclass:link {
	color: #005c8b;
	text-decoration: underline;
}

.helpclass:hover {
	color: #0193de;
	text-decoration: none;
}

</style>
<script language="JavaScript" type="text/javascript">

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var wlanpage;
if (location.href.indexOf("WlanTDE.asp?") > 0)
{
    wlanpage = location.href.split("?")[1]; 
    top.WlanBasicPage = wlanpage;
}

wlanpage = top.WlanBasicPage;

initWlanCap(wlanpage);

function stWlan(domain,name,enable,ssid,wlShow,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                WEPKeyIndex,WEPEncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,X_HW_ServiceEnable,mode,channel,Country,AutoChannelEnable,
                X_HW_HT20,wmmEnable,MACAddressControlEnabled)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.wlShow = wlShow;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.KeyIndex = WEPKeyIndex;
    this.WEPEncryptionLevel = WEPEncryptionLevel;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_WPAand11iAuthenticationMode = X_HW_WPAand11iAuthenticationMode;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.mode = mode;
    this.channel = parseInt(channel);
    this.RegulatoryDomain = Country;
    this.AutoChannelEnable = parseInt(AutoChannelEnable);
    this.X_HW_HT20 = X_HW_HT20;
    this.wmmEnable = wmmEnable;
    this.MACAddressControlEnabled = MACAddressControlEnabled;

    if(BeaconType == "None")
    {
        this.BeaconType = "Basic";
        this.BasicEncryptionModes = "None";
        this.BasicAuthenticationMode = "None";
    }
    else if(BeaconType == "WPA2")
    {
        this.BeaconType = "11i";
    }
    else if(BeaconType == "WPA/WPA2")
    {
        this.BeaconType = "WPAand11i";
    }
}

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stPreSharedKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stExtendedWLC(domain, SSIDIndex)
{
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
}

function ssidNullCheckAndSet()
{
    if(null == Wlan)
    {
        isSsidNull = true;
        Wlan = new stWlan("InternetGatewayDevice.LANDevice.1.WLANConfiguration.1","",0,"",0,"","","",1,"","","","","","","",0,"",0,"",0,"",0,0);
        pwdPsk = "";
        pwdWep = "";
    }
    else
    {
        pwdPsk = pwdPsk[0].value;
        pwdWep = pwdWep[Wlan.KeyIndex - 1].value;
    }
}

function GetWlanChannel()
{
    var ObjPath = "x=InternetGatewayDevice.LANDevice.1.WLANConfiguration." + ((wlanpage == "2G") ? "1" : "2") + "&RequestFile=/html/amp/wlanbasic/WlanTDE.asp";
    var ParaList = 'Channel&x.X_HW_Token=' + getValue('onttoken');
    var WlanChannel = HwAjaxGetPara(ObjPath, ParaList);
    WlanChannel = $.parseJSON(WlanChannel);
	ChanInfo = WlanChannel['Channel'];

	if(ChanInfo != "0")
	{
		$("#curChannel").html(htmlencode(ChanInfo));
		clearInterval(TimerHandle_GetChannel);
	}	
}

var Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1,Name|Enable|SSID|SSIDAdvertisementEnabled|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_ServiceEnable|X_HW_Standard|Channel|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|WMMEnable|MACAddressControlEnabled,stWlan);%>;

var pwdPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1,KeyPassphrase,stPreSharedKey);%>;

var pwdWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.WEPKey.{i},WEPKey,stWEPKey);%>;

var isSsidNull = false;

if(wlanpage == "5G")
{
    Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.2,Name|Enable|SSID|SSIDAdvertisementEnabled|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_ServiceEnable|X_HW_Standard|Channel|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|WMMEnable|MACAddressControlEnabled,stWlan);%>;
    
    pwdPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.PreSharedKey.1,KeyPassphrase,stPreSharedKey);%>;
    
    pwdWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.WEPKey.{i},WEPKey,stWEPKey);%>;
}
Wlan = Wlan[0];
ssidNullCheckAndSet();

var ChanInfo = '<%HW_WEB_GetChanInfo();%>';
var TimerHandle_GetChannel = 0;
var possibleChannels = '';
var urlNode = '';
var Form = null;
var pwdType = "-1";
var wlanInst = getWlanInstFromDomain(Wlan.domain);
var beaconType = Wlan.BeaconType;

var apExtendedWLC = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC, EXTEND);%>;

if(Wlan.BeaconType == "Basic" && Wlan.BasicAuthenticationMode == "SharedAuthentication")
{
    beaconType = "Shared";
}

if(wlanpage == "2G")
{
    ChanInfo = ChanInfo.split(',')[0];
}
else
{
    ChanInfo = ChanInfo.split(',')[1];
}

var enableFilter = Wlan.MACAddressControlEnabled;
var SSIDnum = 28;
var TopoInfo = GetTopoInfo();
var selctIndex = -1;
var PreIdx = -1;

var macAddress = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.AllowedMACAddresses);%>';
var MacFilter = new Array();
var MacFilterSrc = macAddress.split(",");
if (macAddress != "")
{
    MacFilterSrc = macAddress.split(",")
    for (var i = 0; i < MacFilterSrc.length; i++)
    {
        var j = new Object;
        j.domain = i;
        j.MACAddress = MacFilterSrc[i];
		MacFilter.push(j); 
    }
}
MacFilter.push(null);

var MacFilterNr = MacFilter.length - 1;

function setBtnDisable()
{
	setDisable('btnAdd',1);
    setDisable('EnableMacFilter',1);
	setDisable('applybtn',1);
    setDisable('delmaclistall',1);
}

function SetFilterEnable()
{
	var Enable = '';
	if (1 == enableFilter)
	{
	   Enable = 0;
	}
	else
	{
	   Enable = 1;
	}
	 $.ajax({
     type : "POST",
     async : false,
     cache : false,
     data : "x.MACAddressControlEnabled="+Enable +"&x.X_HW_Token="+getValue('onttoken'),
     url : (wlanpage == "2G" ? "set.cgi?x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1&RequestFile=html/not_find_file.asp" : "set.cgi?x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.2&RequestFile=html/not_find_file.asp"),
     success : function(data) {
     },
     complete: function (XHR, TS) {
        XHR=null;
     }
    });
	setBtnDisable();
	window.location='/html/amp/wlanbasic/WlanTDE.asp'; 
}

function isValidFormatMacAddress(address)
{
    var c = '';
    var j = 0;
    var addrParts;

    if (address.toLowerCase() == '00:00:00:00:00:00')
    {
       return false;
    }

    var addrParts = address.split(':');
    if (addrParts.length != 6) 
    {
        return false;
    }

    for (var i = 0; i < 6; i++) {
        if ((addrParts[i] == '') || (addrParts[i].length != 2)) {
            return false;
        }
      
        for ( j = 0; j < addrParts[i].length; j++ )
        {
            c = addrParts[i].toLowerCase().charAt(j);
            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f'))
            {
    			continue;
            }
            else
            {
    			return false;
            }
        }
    }
    return true;
}

function isValidValueMacAddress(address)
{
    var c = '';
    var addrParts;

    if (address.toLowerCase() == 'ff:ff:ff:ff:ff:ff')
    {
       return false;
    }

    addrParts = address.split(':');
    c = addrParts[0].toLowerCase().charAt(1);

    if ((c == '0') || (c == '2') || (c == '4') || (c == '6') || (c == '8') || (c == 'a') || (c == 'c') || (c == 'e'))
    {
        return true;
    }

    return false;
}

function CheckAddForm(macAddress)
{   
    var num=0;

    if (macAddress == '') 
    {
		AlertEx(wlanmacfil_language['bbsp_macfilterisreq']);
        return false;
    }
    if (isValidFormatMacAddress(macAddress) == false ) 
    {
		AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + wlanmacfil_language['bbsp_macisinvalid']);       
        return false;
    }
    if (isValidValueMacAddress(macAddress) == false) 
    { 
        AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + wlanmacfil_language['bbsp_macisinvalid']);         
        return false;
    }
	for (var i = 0; i < MacFilter.length-1; i++)
    {
		if (macAddress.toUpperCase() == MacFilter[i].MACAddress.toUpperCase())
		{
			AlertEx(macfilter_language['bbsp_themac'] + macAddress + macfilter_language['bbsp_macrepeat']);
			return false;
		}
        num++;
    }
    
    if (num >= 28)
    {
        AlertEx(wlanmacfil_language['bbsp_rulenum3']);
        return false;
    }

    return true;
}

function CheckEditForm(macfilterlist,flag)
{   
	var listLen = macfilterlist.length;

	for (var i = 0; i < listLen; i++)
	{
		var macAddress = macfilterlist[i];
		if (macAddress == '') 
		{
			AlertEx(wlanmacfil_language['bbsp_macfilterisreq']);
			return false;
		}
        
		if (isValidFormatMacAddress(macAddress) == false ) 
		{
			AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + wlanmacfil_language['bbsp_macisinvalid']);       
			return false;
		}
		if (isValidValueMacAddress(macAddress) == false) 
        {
            AlertEx(wlanmacfil_language['bbsp_themac'] + macAddress + wlanmacfil_language['bbsp_macisinvalid']);             
            return false;
        }
		for (var j = 0; j <listLen; j++)
		{
			if (j != i)
			{
				if ((macAddress.toUpperCase() == macfilterlist[j].toUpperCase()))
				{
					AlertEx(macfilter_language['bbsp_themac'] + macAddress + macfilter_language['bbsp_macrepeat']);
					return false;
				}
			}
		}
	}
   
    return true;
}

function AddMACList()
{
	var macAddress = getElement('SourceMACAddress').value;
	if (false == CheckAddForm(macAddress))
	{
		setText('SourceMACAddress','');
		return;
	}
	
    var stMacAddress = '';
    var WMacfilterList = new Array();
    var Parameter = {};
    
    for (var i = 0; i < MacFilter.length - 1; i++)
    {
    	stMacAddress += MacFilter[i].MACAddress;

        stMacAddress += ',';
    }
    stMacAddress += macAddress;
    
	 $.ajax({
     type : "POST",
     async : false,
     cache : false,
     data : "x.AllowedMACAddresses="+stMacAddress+"&x.X_HW_Token="+getValue('onttoken'),
     url : "set.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement&RequestFile=html/not_find_file.asp",
     success : function(data) {
     },
     complete: function (XHR, TS) {
        XHR=null;
     }
    });
	setBtnDisable();
	window.location='/html/amp/wlanbasic/WlanTDE.asp'; 
}

function GetNewMacfilter()
{
	var NewMacfilterList = new Array();
	for (var i=0;i <= MacFilterNr - 1;i++)   
	{	
		NewMacfilterList.push(getValue('maclist_'+i));
	}
	return NewMacfilterList;
}

function ApplyMACList()
{
	var NewMacfilterList = GetNewMacfilter();
	if (false == CheckEditForm(NewMacfilterList,'EDIT'))
	{
		updateMaclist();
		return;
	}

    var stMacAddress = "";

    for (var i = 0; i <= NewMacfilterList.length - 1; i++)
    {
    	stMacAddress += NewMacfilterList[i];

        stMacAddress += ',';
    }

    stMacAddress = stMacAddress.substring(0, stMacAddress.length-1);
        
	$.ajax({
     type : "POST",
     async : false,
     cache : false,
     data : "x.AllowedMACAddresses="+stMacAddress+"&x.X_HW_Token="+getValue('onttoken'),
     url : "set.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement&RequestFile=html/not_find_file.asp",
     success : function(data) {
     },
     complete: function (XHR, TS) {
        XHR=null;
     }
    });
	
    setBtnDisable();
	window.location='/html/amp/wlanbasic/WlanTDE.asp'; 
}

function DelMACList(DelId)
{
    var stMacAddress = "";
	var idx = DelId.split('_')[1];
	if (0 == MacFilterNr)
	{
		AlertEx(wlanmacfil_language['bbsp_nonerulealert']);
		return;
	}
	var NewMacfilterList = GetNewMacfilter();
	if (false == CheckEditForm(NewMacfilterList,'DEL'))
	{
		updateMaclist();
		return;
	}

    if ('delmaclistall' != DelId)
    {
        for (var i = 0; i < MacFilter.length - 1; i++)
		{
            if (MacFilter[i].MACAddress != MacFilter[idx].MACAddress)
            {
                stMacAddress += MacFilter[i].MACAddress;

                stMacAddress += ',';
			 }
		}

        stMacAddress = stMacAddress.substring(0, stMacAddress.length-1);
    }
        	
	$.ajax({
     type : "POST",
     async : false,
     cache : false,
     data : "x.AllowedMACAddresses="+stMacAddress+"&x.X_HW_Token="+getValue('onttoken'),
     url : "set.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement&RequestFile=html/not_find_file.asp",
     success : function(data) {
     },
     complete: function (XHR, TS) {
        XHR=null;
     }
    });
    
	setBtnDisable();
	window.location='/html/amp/wlanbasic/WlanTDE.asp'; 
}

function updateMaclist()
{
	if (0 == MacFilterNr)
	{
		return;
	}
	for (var i=0;i <= MacFilterNr - 1;i++)   
	{
		setText('maclist_'+i, MacFilter[i].MACAddress);
	}
}

function showlistcontrol()
{
	if (0 == MacFilterNr)
	{
		return;
	}
	
	for (var i=0;i <= MacFilterNr - 1;i++)   
	{
		document.write('<tr id="record_' + i + '" align = "left" class="tabal_01">');
		document.write('<td class="tablecfg_title width_per32"></td>');
		document.write('<td class="tablecfg_right width_per68">');
		document.write('<input id="maclist_' + i + '" type="text" maxlength="17" value="'+ htmlencode(MacFilter[i].MACAddress) +'" class="Selectmacaddr"/>');
		document.write('<img id="maclistimg_' + i + '" src="../../../images/cus_images/del.png" style="margin-left:5px;display:none" onClick="DelMACList(this.id);"/>');
		document.write('</td>');
		document.write('</tr>');
	}

	for (var i=0;i <= MacFilterNr - 1;i++)   
	{
		setDisable('maclist_' + i, 1);
	}	
}



function EditMACList()
{
	setDisplay('editbtn', 0);
	setDisplay('applybtn', 1);
	setDisplay('delmaclistall', 1);
	
	for (var i=0;i <= MacFilterNr - 1;i++)   
	{
		setDisable('maclist_' + i, 0);
		setDisplay('maclistimg_' + i, 1);
	}
}

function showBtnEdit()
{
	if (0 == MacFilterNr)
	{
		return;
	}

	document.write('<tr id="trEdit" align = "center" class="" style="display:block;"><td><div style="margin-left:-138px;">');
	document.write('<span id="editbtn" name="editbtn" class="helpclass" onClick="EditMACList();" style="text-decoration:none;">');
	document.write(wlanmacfil_language['bbsp_edit']);
	document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	document.write('</span>');
	document.write('<span id="applybtn" name="applybtn" class="helpclass" onClick="ApplyMACList();" style="text-decoration:none;display:none;">');
	document.write(wlanmacfil_language['bbsp_apply']);
	document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	document.write('</span>');
	document.write('<span id="delmaclistall" name="delmaclistall" class="helpclass" onClick="DelMACList(this.id);" style="text-decoration:none;display:none;">');
	document.write(wlanmacfil_language['bbsp_delall']);
	document.write('</div>');
	document.write('</td></div></tr>');
}

function ShowFilterEnable(enable)
{
	if(enable == 0)
	{
		$("#EnableMacFilter").attr("src", "../../../images/cus_images/btn_off.png");
	}
	else
	{
		$("#EnableMacFilter").attr("src", "../../../images/cus_images/btn_on.png");
	}
}

function GetFilterEnable()
{
	var FilterEnable = '';
	if (getElement('EnableMacFilter').getAttribute("src") == "../../../images/cus_images/btn_off.png")
	{
		FilterEnable = 0;
	}
	else
	{
		FilterEnable = 1;
	}
	return FilterEnable;
}

function authModeChange()
{
    var authMode = getSelectVal("wlAuthMode");
    var encryTypeArr = [["Basic", Wlan.BasicEncryptionModes], ["Shared", "WEPEncryption"], ["WPA", Wlan.WPAEncryptionModes], 
                ["11i", Wlan.IEEE11iEncryptionModes], ["WPAand11i", Wlan.X_HW_WPAand11iEncryptionModes]];
    
    $("#wlEncryption").empty();
    
    if(authMode == "Basic")
    {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_none'], "None");
        if(Wlan.mode!="11n" && Wlan.mode!="11ac" && wepCap)
        {
            document.forms[0].wlEncryption[1] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
        }
    }
    else if(authMode == "Shared")
    {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_wep'], "WEPEncryption");
    }
    else
    {
        document.forms[0].wlEncryption[0] = new Option(cfg_wlancfgdetail_language['amp_encrypt_aes'], "AESEncryption");
    }
    
    for(var i=0; i<encryTypeArr.length; i++)
    {
        if(authMode == encryTypeArr[i][0])
        {
            setSelect("wlEncryption", encryTypeArr[i][1]);
            encryTypeChange(getSelectVal("wlEncryption"));
            break;
        }
    }
}

function encryTypeChange(encry)
{
    var type = "psk";
    var pwd = pwdPsk;
    if(encry == "None")
    {
        type = "";
        pwd = "";
    }
    else if(encry == "WEPEncryption")
    {
        type = "wep";
        pwd = pwdWep;
    }

    setWiFiPwd(pwd, type);
}

function initAuthMode()
{
    setSelect("wlAuthMode", beaconType);
    
    authModeChange();
}

function setWiFiPwd(pwd, type)
{
    if(pwdType == type)
    {
        return;
    }

    setDisable("PSKssidPwdTxt", 0);

    if ("wep" == type)
    {
        setDisplay("PSKssidPwd", 0);
        setDisplay("PSKssidPwdTxt", 0);

        setText("WEPssidPwd", pwd);
        setText("WEPssidPwdTxt", pwd);
    }
    else if ("psk" == type)
    {
        setDisplay("WEPssidPwd", 0);
        setDisplay("WEPssidPwdTxt", 0);

        setText("PSKssidPwd", pwd);
        setText("PSKssidPwdTxt", pwd);		
    }
    else if ("" == type)
    {
        setDisable("PSKssidPwdTxt", 1);
        setText("PSKssidPwdTxt", "");
		
        setDisplay("PSKssidPwd", 0);
        setDisplay("PSKssidPwdTxt", 1);
        setDisplay("WEPssidPwd", 0);
        setDisplay("WEPssidPwdTxt", 0);
    }
    
    ssidPwdChkClick(type);
    pwdType = type;
    ssidPwdChange(pwdType);

}

function loadChannelListByFreq(freq, country, mode, width)
{
    var index = 0;
    var i;
    var WebChannel = Wlan.channel;
    var WebChannelValid = 0;    

    getPossibleChannels(freq, country, mode, width);
    var ShowChannels = possibleChannels.split(',');

    for (i = 0; i < document.forms[0].Channel.options.length; i++)
    {
        document.forms[0].Channel.remove(0);
    }

    document.forms[0].Channel[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");
    
    for (var j=1; j<=ShowChannels.length; j++)
    {
        if(j==ShowChannels.length)
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
        document.forms[0].Channel[j] = new Option(ShowChannels[j-1], ShowChannels[j-1]);
    }

    if ((WebChannelValid == 1) && (Wlan.AutoChannelEnable == "0"))
    {
        setSelect('Channel', WebChannel);
    }
    else
    {
        setSelect('Channel', 0);    
    }
}

function addBackSlash(str)
{
    var strNeedSlash = "\\'\".:,;";
    var strNew = "";
  
    for(var i=0; i<str.length; i++)
    {
        var c = str.charAt(i);
        for(var j=0; j<strNeedSlash.length; j++)
        {
            if(c == strNeedSlash.charAt(j))
            {
                strNew += "\\";
                break;
            }
        }
        strNew += c;
    }
    
    return strNew;
}

function createQRCode()
{
    var qrTxt = "WIFI:";
    var psk = "nopass";    
    var ssid = addBackSlash(Wlan.ssid);
    
    if(beaconType == "Basic")
    {
        if(Wlan.BasicEncryptionModes == "WEPEncryption")
        {
            qrTxt += "T:WEP";
            psk = addBackSlash(pwdWep);
        }
        else
        {
            qrTxt += "T:nopass";
        }
    }
    else if(beaconType == "Shared")
    {
        qrTxt += "T:WEP";
        psk = addBackSlash(pwdWep);
    }
    else
    {
        qrTxt += "T:WPA";
        psk = addBackSlash(pwdPsk);
    }
    
    qrTxt += ";S:" + ssid + ";P:" + psk + ";";
    
    qrTxt += (Wlan.wlShow == "1") ? "H:false;" : "H:true;";
    
    var qrcode = new QRCode(document.getElementById("QRCode"), {
        width : 100,
        height : 100
    });

    qrcode.makeCode(qrTxt);

    $("#QRCode").attr("title", "");
    $("#QRCode table").css({"width":"100px", "height":"100px", "margin":"0px"});
}

function loadNullSsid()
{
    if(isSsidNull)
    {
        $("#WiFiArea input").attr("disabled", "disabled");
        $("#WiFiArea select").empty();
        $("#WiFiArea select").attr("disabled", "disabled");
        
        return false;
    }

    return true;
}

function LoadFrame()
{
    if(!loadNullSsid())
    {
        return ;
    }
    
    setText("ssidName", Wlan.ssid);
    
    initAuthMode();

    setRadio("ssidHide", ("1" == Wlan.wlShow) ? "ssidShow" : "ssidHide");

    setRadio("radioEnable", ("1" == (wlanpage == "2G" ? enbl2G : enbl5G)) ? "ssidON" : "ssidOFF");
    
    loadChannelListByFreq(wlanpage, Wlan.RegulatoryDomain, Wlan.mode, Wlan.X_HW_HT20);

    createQRCode();
    ShowFilterEnable(enableFilter);

	if("0" == ChanInfo && ("1" == (wlanpage == "2G" ? enbl2G : enbl5G)))
	{
		ChanInfo = cfg_wlancfgbasic_tde_language['amp_wifitde_channel_scan'];
		TimerHandle_GetChannel = setInterval("GetWlanChannel()", 1000);
	}
    $("#curChannel").html(htmlencode(ChanInfo));
}

function ssidHideChange(flag)
{
    if(0 == flag)
    {
        AlertEx(cfg_wlancfgbasic_tde_language['amp_wifitde_ssidhide_alert']);
    }
    else
    {
        AlertEx(cfg_wlancfgbasic_tde_language['amp_wifitde_ssidshow_alert']);
    }
}

function checkWep(val)
{
    Form.addParameter('y.WEPEncryptionLevel', '104-bit');
    
    if ( val != '' && val != null)
    {
        if (isSpaceInKey(val))
        {
            AlertEx(val + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + cfg_wlancfgother_language['amp_wpa_space']);
            return false;
        }

       if (isValidKey(val, 13) == false )
       {
           AlertEx(cfg_wlancfgdetail_language['amp_key_check1'] + val + cfg_wlancfgdetail_language['amp_key_invalid1']);
           return false;
       }

       if (isValidStr(val) != '')
       {
           AlertEx(val + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + isValidStr(val));
           return false;
       }
    }
    else
    {
       AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_empty']);
       return false;
    }
    return true;
}

function CheckPwdStrength(val)
{
    var HaveDigit = 0;
    var HaveChar = 0;
    var HaveSpecialChar = 0;

    if(null == val || val.length == 0)
    {
        return "none";
    }

    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch <= '9' && ch >= '0' )
        {
            HaveDigit = 1;
        }
        else if((ch <= 'z' && ch >= 'a') || (ch <= 'Z' && ch >= 'A'))
        {
            HaveChar = 1;
        }
        else
        {
            HaveSpecialChar = 1;
        }
    }

    var Result = HaveDigit + HaveChar + HaveSpecialChar;

    if(pwdType == "wep")
    {
        if((val.length == 13) || checkHexNumWithLen(val, 26))
        {
            if(Result == 1)
            {
                return "simple";
            }
            else
            {
                return "medium";
            }
        }
        else
        {
            return "none";
        }
    }
    else if(pwdType == "psk")
    {
        if(val.length < 8)
        {
            return "none";
        }
        else if(val.length <= 10)
        {
            if(Result == 1)
            {
                return "simple";
            }
            else {
                return "medium";
            }
        }
        else if(val.length <= 63)
        {
            if(Result == 1)
            {
                return "simple";
            }
            else if(Result == 2)
            {
                return "medium";
            }
            else
            {
                return "strong";
            }
        }
        else {
            return "none";
        }
    }
    else
    {
        return "none";
    }
    
}

function ssidPwdChange(pwdType)
{
    var Strength = CheckPwdStrength(getValue('PSKssidPwd'));
    if ("wep" == pwdType)
    {
        Strength = CheckPwdStrength(getValue('WEPssidPwd'));
    }

    if ("simple" == Strength)
    {
        document.getElementById("masker").style.width = "133px";
    }
    else if ("medium" == Strength)
    {
        document.getElementById("masker").style.width = "66px";
    }
    else if ("strong" == Strength)
    {
        document.getElementById("masker").style.width = "0";
    }
    else
    {
        document.getElementById("masker").style.width = "200px";
    }
}

function checkSSIDForTDE(wlan)
{
	var ssid = wlan.ssid;
	
	if(checkSSIDExist(wlan, WlanInfo))
    {
    	return false;
    }

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

    if (true != checkSepcailStrValid(ssid))
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid']);
        return false;
    }
	
	if(getTDEStringActualLen(ssid) > 32)
	{
	    AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
        return false;
	}
    
    return true;
}

function checkAddPara()
{
    var ssid = getValue('ssidName');
    ssid = ltrim(ssid);
    Wlan.ssid = ssid;
    if(false == checkSSIDForTDE(Wlan))
    {
        return false;
    }
    Form.addParameter('y.SSID',ssid);

    var pwd = "";

    if(pwdType == "wep")
    {
        pwd = getValue("WEPssidPwd");
		if ((isFireFox4 == 1) && (pwd == ''))
		{
			pwd = getValue("WEPssidPwdTxt");
		}
		
        if(!checkWep(pwd))
            return false;
            
        var curAuthMode = getSelectVal("wlAuthMode");
        
        if( Wlan.WEPEncryptionLevel != '104-bit' )
        {
            for(var i = 1; i <= 4; i++)
            {
                var wepDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst + ".WEPKey." + i;        
                Form.addParameter('w' + i + '.WEPKey', pwd);
                urlNode += "w" + i + "=" + wepDomain + "&";
            }
        }
        else
        {
            var wepDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration."+wlanInst+".WEPKey." + Wlan.KeyIndex;        
            Form.addParameter('w.WEPKey', pwd);
            urlNode += "w=" + wepDomain + "&";
        }
    }
    else if(pwdType == "psk")
    {
    	pwd = getValue("PSKssidPwd");
		if ((isFireFox4 == 1) && (pwd == ''))
		{
			pwd = getValue("PSKssidPwdTxt");
		}
		
        if(false == isValidWPAPskSepcialKey(pwd))
		{
		    return false;
		}
		
        var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration."+wlanInst+".PreSharedKey.1";

        Form.addParameter('p.PreSharedKey', pwd);
        Form.addParameter('p.KeyPassphrase', pwd);
        
        urlNode += "p="+pskDomain+"&";                
    }
    
    return true;
}

function isWifiCoverSsid()
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

function addCoverPara()
{
    if(!isWifiCoverSsid())
        return true;

    var paraChanged = false;

    var ssidCoverParaArr = [["SsidInst", "", wlanInst], ["SSID", "", Wlan.ssid], ["Standard", "", Wlan.mode], ["BeaconType", "", Wlan.BeaconType], 
		    ["BasicEncryptionModes", "", Wlan.BasicEncryptionModes], ["BasicAuthenticationMode", "", Wlan.BasicAuthenticationMode], 
		    ["WPAEncryptionModes", "", Wlan.WPAEncryptionModes], ["WPAAuthenticationMode", "", Wlan.WPAAuthenticationMode], 
		    ["IEEE11iEncryptionModes", "", Wlan.IEEE11iEncryptionModes], ["IEEE11iAuthenticationMode", "", Wlan.IEEE11iAuthenticationMode], 
		    ["X_HW_WPAand11iEncryptionModes", "MixEncryptionModes", Wlan.X_HW_WPAand11iEncryptionModes], 
		    ["X_HW_WPAand11iAuthenticationMode", "MixAuthenticationMode", Wlan.X_HW_WPAand11iAuthenticationMode], 
		    ["WEPKey", "Key", pwdWep], ["PreSharedKey", "Key", pwdPsk]];
    
    var postForm = $("form[method='POST']");
    
    if(0 == postForm.find("input").length)
    {
        return true;
    }
    
    $.each(ssidCoverParaArr, function(idx, ssidCoverPara){
    
        var key = (ssidCoverPara[1] == "") ? ssidCoverPara[0] : ssidCoverPara[1];
        var value = ssidCoverPara[2];

        var inputPara = postForm.find("input[name$='." + ssidCoverPara[0] + "']");
        if(inputPara.length > 0)
        {
            value = inputPara[0].value;
            paraChanged = true;
        }
        
        Form.addParameter('c.'+key, value);
    });
    
    if(paraChanged)
    {
        urlNode += "c=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&";
        
        return ConfirmEx(cfg_wificover_basic_language['amp_wificover_ssid_change_notify']);
    }
    
    return true;
}

function addAuthPara()
{
    var curAuthMode = getSelectVal("wlAuthMode");
    var curEncryMode = getSelectVal("wlEncryption");
    var beaconEncryArr = 
               [["Basic", "BasicEncryptionModes", curEncryMode, 'BasicAuthenticationMode', 'None'], 
                ["Shared", "BasicEncryptionModes", curEncryMode, 'BasicAuthenticationMode', 'SharedAuthentication'], 
                ["11i", "IEEE11iEncryptionModes", curEncryMode, 'IEEE11iAuthenticationMode', 'PSKAuthentication'], 
                ["WPAand11i", "X_HW_WPAand11iEncryptionModes", curEncryMode, 'X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication']];

    Form.addParameter('y.BeaconType', curAuthMode);
    
    if(curAuthMode=="Basic")
    {
    }
    else if(curAuthMode=="Shared")
    {
        Form.addParameter('y.BeaconType', "Basic");
        pwdType = "wep";
    }
    else
    {
        pwdType = "psk";
    }
    
    for(var i=0; i < beaconEncryArr.length; i++)
    {
        if(curAuthMode == beaconEncryArr[i][0])
        {
            Form.addParameter('y.' + beaconEncryArr[i][1], beaconEncryArr[i][2]);
            Form.addParameter('y.' + beaconEncryArr[i][3], beaconEncryArr[i][4]);
            
            break;
        }
    }
}

function ssidPwdChkClick(pwdType)
{
    if ("wep" == pwdType)
	{
        if (1 == getCheckVal("ssidPwdChk"))
        {
            setDisplay("WEPssidPwd", 1);
            setDisplay("WEPssidPwdTxt", 0);
        }
        else
        {
            setDisplay("WEPssidPwd", 0);
            setDisplay("WEPssidPwdTxt", 1);
        }	
    }
    else if("psk" == pwdType)
    {
        if (1 == getCheckVal("ssidPwdChk"))
        {
            setDisplay("PSKssidPwd", 1);
            setDisplay("PSKssidPwdTxt", 0);
        }
        else
        {
            setDisplay("PSKssidPwd", 0);
            setDisplay("PSKssidPwdTxt", 1);
        }
    }
}

function ApplySubmit()
{    
    Form = new webSubmitForm();
    urlNode = "";
    
    var valid = true;
    var tmp = 0;

    var ssidShow = (getRadioVal("ssidHide") == "ssidHide") ? "0" : "1";
    if(Wlan.wlShow != ssidShow)
    {
        Form.addParameter('y.SSIDAdvertisementEnabled', ssidShow);
    }
    
    addAuthPara();
    
    var channel = parseInt(getSelectVal("Channel"));
    Form.addParameter('y.Channel', channel);
    Form.addParameter('y.AutoChannelEnable', (channel==0)?1:0);
    
    if(!checkAddPara() || !addCoverPara())
    {
        return;
    }

    urlNode += 'y=' + Wlan.domain + "&";
    
    var radioEnable = (getRadioVal("radioEnable") == "ssidON") ? "1" : "0";
    if((wlanpage == "2G" ? enbl2G : enbl5G) != radioEnable)
    {
        urlNode += 'r=InternetGatewayDevice.LANDevice.1.WiFi.Radio.' + (wlanpage == "2G" ? 1 : 2) + '&';
        Form.addParameter('r.Enable', radioEnable);
    }

    Form.setAction("set.cgi?" + urlNode
                        + 'RequestFile=html/amp/wlanbasic/WlanTDE.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    if(isSsidNull || !isWlanInitFinished(wlanpage, Wlan.mode, Wlan.X_HW_HT20))
    {
        return;
    }
    
    setDisable("apply", 1);
    setDisable("cancel", 1);

    Form.submit();
}

</script>

<style>
#progress {
height: 15px;
width: 200px;
border: 1px solid #CCCCCC;
background-image: url(../../../images/cus_images/strength.png);
background-repeat: repeat-y;
background-color: blue;
z-index: 10;
}
#masker {
float: right;
height: 15px;
width: 200px;
background-color: #FAFAFA;
z-index: 30;
}
#maskertext {
position: absolute;
float: left;
display: inline-block;
font-size: 12px;
z-index: 40;
background: transparent;
margin-top: -2px;
}
#maskertext span {
display: inline-block;
width: 66px;
text-align: center;
}
#PwdStrengthContainer {
float: left;
width: 100%;
vertical-align:middle;
position: relative;
margin-top: 0px;
}
#PwdStrengthIndicator {
height: 36px;
width: 200px;
text-align: center;
font-size: 14px;
}
#guidetitleinfo {
width: 100%;
height: 30px;
border-bottom: 1px solid #A6A6A6;
}
.spanguidetitleinfocss {
padding-left: 15px;
font-size: 14px;
font-family: "微软雅黑";
color: #266B94;
font-weight: bold;
line-height: 30px;
}
#tb1, #tb2{
width: 100%;
margin-left: 10px;
}
</style>

</head>
<body  class="iframebody" onLoad="LoadFrame();" style="text-align: left;">
<div class="title_spread"></div>

<form>

<div id="WiFiArea" class="FuctionPageAreaCss">

<div id="PcTitle" class="FunctionPageTitleCss">
<span id="PageTitleText" class="PageTitleTextCss">WiFi</span>
</div>

<div class="PageSumaryInfoCss" BindText="amp_wifitde_PageSumaryInfo"></div>

<table id="tb1" cellspacing="10">
<tr>
<td BindText="amp_wifitde_wifiname"></td>
<td><input id="ssidName" maxlength="32" style="width:200px;" /></td>
</tr>
<tr>
<td BindText="amp_wifitde_hidewifi"></td>
<td>
<input name="ssidHide" type="radio" id="ssidHide" value="ssidHide" onclick="ssidHideChange(0);"></input><span BindText="amp_wifitde_yes" style="font-size:14px;"></span>
<input name="ssidHide" type="radio" id="ssidHide" value="ssidShow" onclick="ssidHideChange(1);"></input><span BindText="amp_wifitde_no" style="font-size:14px;"></span>
</td>
</tr>
<tr>
<td style="vertical-align: top; padding-top: 6px;"  BindText="amp_wifitde_wifipwd"></td>
<td>
<div>
<div style="float:left">
<input id="PSKssidPwdTxt" type="text" autocomplete="off" style="width:200px;display:none;" onkeyup="setText('PSKssidPwd', this.value);ssidPwdChange(pwdType);" maxlength="63"/>
<input id="PSKssidPwd" type="password" autocomplete="off" style="width:200px;" onkeyup="setText('PSKssidPwdTxt', this.value);ssidPwdChange(pwdType);" maxlength="63"/>

<input id="WEPssidPwdTxt" type="text" autocomplete="off" style="width:200px;display:none;" onkeyup="setText('WEPssidPwd', this.value);ssidPwdChange(pwdType);" maxlength="26"/>
<input id="WEPssidPwd" type="password" autocomplete="off" style="width:200px;" onkeyup="setText('WEPssidPwdTxt', this.value);ssidPwdChange(pwdType);" maxlength="26"/>

<input id="ssidPwdChk" type="checkbox" checked onclick="ssidPwdChkClick(pwdType);" />
<span style="font-size:14px;"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
<div style="font-size: 12px;width: 280px;" BindText="amp_wifitde_pwdnote"></div>
</div>
<div id="PwdStrengthContainer" style="float:right; width:300px;">
  <div id="PwdStrengthIndicator" BindText="amp_wifitde_pwdstrength" style="height: 25px; width: 300px;"></div>
  <div id="progress" style="margin-left: 50px;">
      <div id="masker"></div>
      <div id="maskertext">
        <span BindText="amp_wifitde_pwdstrength_low"></span><span BindText="amp_wifitde_pwdstrength_medium"></span><span BindText="amp_wifitde_pwdstrength_high"></span>
      </div>
  </div>
</div>
</div>

</td>
</tr>
<tr>
<td BindText="amp_wifitde_wifistatus"></td>
<td>
<input name="radioEnable" type="radio" id="radioEnable" value="ssidON"></input><span BindText="amp_wifitde_on" style="font-size:14px;"></span>
<input name="radioEnable" type="radio" id="radioEnable" value="ssidOFF"></input><span BindText="amp_wifitde_off" style="font-size:14px;"></span>
</td>
</tr>
</table>

<div style="margin: 10px 0px 10px 0px;">
<img src="../../../images/cus_images/notice.png" style="margin-left: 50px; float:left;"></img>
<div style="margin:0px 30px 0px 152px; font-size:14px" BindText="amp_wifitde_encryption_note"></div>
</div>

<table id="tb2" cellspacing="10">
<tr>
<td BindText="amp_wifitde_auth_type"></td>
<td>
<select id="wlAuthMode" name="wlAuthMode" style="width:200px;" size="1" onchange="authModeChange()">
<script>
document.write('<option value="11i">' + cfg_wlancfgbasic_tde_language['amp_wifitde_auth_wpa2psk'] + '</option>');
if(wlanpage != "5G")
{
    document.write('<option value="WPAand11i">' + cfg_wlancfgbasic_tde_language['amp_wifitde_auth_wpawpa2psk'] + '</option>');
}
if(Wlan.mode!="11n" && Wlan.mode!="11ac" && wepCap)
{
    document.write('<option value="Shared">' + cfg_wlancfgbasic_tde_language['amp_wifitde_auth_shared'] + '</option>');
}
document.write('<option value="Basic">' + cfg_wlancfgbasic_tde_language['amp_wifitde_auth_open'] + '</option>');
</script>
</select>
</td>
</tr>
<tr>
<td BindText="amp_wifitde_encryption_type"></td>
<td>
<select id="wlEncryption" style="width:200px;" onChange="encryTypeChange(this.value);">
</select>
</td>
</tr>

<tr>
<td BindText="amp_wifitde_channel"></td>
<td>
<select id="Channel" style="width:200px;">
</select>
</td>
</tr>
<tr>
<td BindText="amp_wifitde_cur_channel" style="color:black;"></td>
<td><span id="curChannel" style="color:black;"></span></td>
</tr>
</table>

<div class="title_spread"></div>

<div style="overflow:hidden;zoom:1;">
<div id="QRCode" style="float:left;margin-left: 22px;"></div>
<div class="PageSumaryInfoCss" style="width: 600px;margin-left: 152px;" BindText="amp_wifitde_qrcode_note"></div>
</div>

<div class="ButtonListCss" style="margin-left: 22px;">
    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    <input id="apply" type="button" BindText="amp_wifitde_apply" class="BluebuttonGreenBgcss width_120px" onClick="ApplySubmit();" />
</div>

</div>

<div class="DivSpread_30PX"></div>

<div id="WPSArea" class="FuctionPageAreaCss">

<div id="PcTitle" class="FunctionPageTitleCss">
<span id="PageTitleText" class="PageTitleTextCss">WPS</span>
</div>

<div>
<div class="PageSumaryTitleCss" style="display:none;">WPS</div>
<div class="PageSumaryInfoCss">
<span BindText="amp_wifitde_wps_note"></span>
<a href="#" style="color: blue;">
	<span BindText="amp_wifitde_note_help" onClick="gotoHelp();"></span>
</a><span>.</span>
</div>
</div>

</div>

<div id="DivContent">
<div style="height:20px;"></div>
<div id="DivMacFilter" class="FuctionPageAreaCss">
	<div id="MacFilterTitle" class="FunctionPageTitleCss">
	<span id="MacFilterText" class="PageTitleTextCss"><script>document.write(wlanmacfil_language['bbsp_macfilter_title']);</script></span>
	</div>
	<div style="height:30px;"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<tr> 
			<td class="PageSumaryTitleCss tablecfg_title width_per32"><script>document.write(wlanmacfil_language['bbsp_inputmacaddr']);</script></td> 
			<td class="tablecfg_right width_per68">
			<div>
				<input type='text' name="SourceMACAddress" id="SourceMACAddress" maxlength='17' class="Selectmacaddr"/> 
				<span class="gray"><script>document.write(wlanmacfil_language['bbsp_maceg']);</script></span> 
				<span>&nbsp;&nbsp;</span>
				<button name="btnAdd" id="btnAdd" type="button" class="BluebuttonGreenBgcss buttonwidth_100px" onClick="AddMACList();"><script>document.write(wlanmacfil_language['bbsp_add']);</script></button>
			</div>
			</td> 
		</tr> 
	</table>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<tr>
			<td class="PageSumaryTitleCss tablecfg_title width_per70" nowrap><script>document.write(wlanmacfil_language['bbsp_filtertilte']);</script></td> 
			<td class="tablecfg_right width_per30">
			<div>
				<span><script>document.write(wlanmacfil_language['bbsp_filterenable1']);</script></span> 
				<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<img src="../../../images/cus_images/btn_on.png" id="EnableMacFilter" onClick='SetFilterEnable();'/>
			</div>
			</td> 
		</tr>
	</table>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<script language="JavaScript" type="text/javascript">
			showlistcontrol();
		</script> 
	</table>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<script language="JavaScript" type="text/javascript">
			showBtnEdit();
		</script> 
	</table>
	<div style="height:30px;"></div>
</div>
</div>



<script>
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "div",  1);
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "td",  1);
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "span",  1);
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "input", 2);

$("#tb1 td:nth-child(1)").addClass("PageSumaryTitleCss").css({"width":"30%"});
$("#tb2 td:nth-child(1)").addClass("PageSumaryTitleCss").css({"width":"30%"});

function stPageJump(id, NameStr, name)
{
this.id = id;
this.NameStr = NameStr;
this.name = name;
}

function gotoHelp()
{
    valinfo = new stPageJump("", cfg_wlancfgbasic_tde_language['amp_wifitde_note_help'], "CustomApp/helpinfo.asp");
    top.helpId = "WiFiHelp";
    window.parent.OnChangeIframeShowPage(valinfo); 
}
</script>



</form>

</body>

</html>
