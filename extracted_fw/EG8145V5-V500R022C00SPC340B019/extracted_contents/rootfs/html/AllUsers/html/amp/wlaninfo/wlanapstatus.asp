<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlaninfo_detail_language, status_wlaninfo_language, cfg_wlanupmode_db_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<title>Wlan information</title>
<script type="text/javascript">
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>';
var devtype = '';
function stWlanTb(ssid, wetherConfig,status, auth, encrypt)
{
    this.ssid = ssid;
    this.wetherConfig = wetherConfig;
    this.status = status;
    this.auth = auth;
    this.encrypt = encrypt;
}
function stWlan(domain,enable,name,ssid,BeaconType,BasicEncrypt,BasicAuth,WPAEncrypt,WPAAuth,IEEE11iEncrypt,IEEE11iAuth,WPAand11iEncrypt,WPAand11iAuth,Channel,LowerLayers, X_HW_Standard, RegulatoryDomain, X_HW_HT20, TransmitPower, X_HW_ServiceEnable, wlHide, wmmEnable, DeviceNum)
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
    this.TransmitPower = TransmitPower;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.wlHide = wlHide;
    this.wmmEnable = wmmEnable;
    this.DeviceNum = DeviceNum;
}

var WlanInfo = new Array();
WlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Enable|Name|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|Channel|LowerLayers|X_HW_Standard|RegulatoryDomain|X_HW_HT20|TransmitPower|X_HW_ServiceEnable|SSIDAdvertisementEnabled|WMMEnable|X_HW_AssociateNum,stWlan,STATUS);%>;

var WlanMap = new Array();
var wlanselect = new Array();
var SSIDInfoArr = new Array();
var WlanMapIndex = 0;


    if (window.location.href.indexOf("type") != -1)
    {
        para = window.location.href.split("type")[1];
        devtype = para.split("=")[1];
    }

for (var i = 0; i < WlanInfo.length-1; i++)
{
    if (devtype == "2.4G")
    {
        if (WlanInfo[i].LowerLayers.indexOf(node5G) != 0)
        {
           wlanselect.push(WlanInfo[i]);
        }

    }
    else
    {
        if (WlanInfo[i].LowerLayers.indexOf(node2G) != 0)
        {
            wlanselect.push(WlanInfo[i]);
        }                   
    }

}                   


for (i = 0; i < wlanselect.length; i++)
    {

    if ('' == WlanInfo[i].name)
    {
            continue;
        }

    
    if ((wlanselect[i].BeaconType == 'Basic')|| (wlanselect[i].BeaconType == 'None'))
    {
        Auth = wlanselect[i].BasicAuth;
        Encrypt = wlanselect[i].BasicEncrypt;
    }
    else if (wlanselect[i].BeaconType == 'WPA')
    {
        Auth = wlanselect[i].WPAAuth;
        Encrypt = wlanselect[i].WPAEncrypt;
    }
    else if ( (wlanselect[i].BeaconType == '11i') || (wlanselect[i].BeaconType == 'WPA2') )
    {
        Auth = wlanselect[i].IEEE11iAuth;
        Encrypt = wlanselect[i].IEEE11iEncrypt;
    }
    else if ( (wlanselect[i].BeaconType == 'WPAand11i') || (wlanselect[i].BeaconType == 'WPA/WPA2'))
    {
        Auth = wlanselect[i].WPAand11iAuth;
        Encrypt = wlanselect[i].WPAand11iEncrypt;
    }
    else
    {
    }
                    
    if (Auth == 'None')
    {
        Auth = cfg_wlaninfo_detail_language['amp_auth_open'];
    }
    else if (Auth == 'SharedAuthentication')
    {
        Auth = cfg_wlaninfo_detail_language['amp_auth_shared'];
    }
    else if(Auth == 'PSKAuthentication')
    {
        if (wlanselect[i].BeaconType == 'WPA')
        {
            Auth = cfg_wlaninfo_detail_language['amp_auth_wpapsk'];
        }
        else if( (wlanselect[i].BeaconType == '11i') || (wlanselect[i].BeaconType == 'WPA2') )
        {
            Auth = cfg_wlaninfo_detail_language['amp_auth_wpa2psk'];
        }
        else if( (wlanselect[i].BeaconType == 'WPAand11i') || (wlanselect[i].BeaconType == 'WPA/WPA2') )
        {
            Auth = cfg_wlaninfo_detail_language['amp_auth_wpawpa2psk'];
        }
        else
        {
        }
    }
    else if(Auth == 'EAPAuthentication')
    {   
        if(wlanselect[i].BeaconType == 'WPA')
        {  
            Auth = cfg_wlaninfo_detail_language['amp_auth_wpa'];
        }
        else if( (wlanselect[i].BeaconType == '11i') || (wlanselect[i].BeaconType == 'WPA2') )
        { 
            Auth = cfg_wlaninfo_detail_language['amp_auth_wpa2'];
        }
        else if( (wlanselect[i].BeaconType == 'WPAand11i') || (wlanselect[i].BeaconType == 'WPA/WPA2') )
        { 
            Auth = cfg_wlaninfo_detail_language['amp_auth_wpawpa2'];
        }
    }
    
    if(Encrypt == 'NONE' || Encrypt == 'None')
    {  
        if (Auth == 'Both')
        {
            Encrypt = cfg_wlaninfo_detail_language['amp_encrypt_wep'];
        }
        else
        {
            Encrypt = cfg_wlaninfo_detail_language['amp_encrypt_none'];
        }
    }
    else if(Encrypt == 'WEPEncryption')
    {
        Encrypt = cfg_wlaninfo_detail_language['amp_encrypt_wep'];
    }
    else if(Encrypt == 'AESEncryption') 
    {
        Encrypt = cfg_wlaninfo_detail_language['amp_encrypt_aes'];
    }
    else if(Encrypt == 'TKIPEncryption')
    {
        Encrypt = cfg_wlaninfo_detail_language['amp_encrypt_tkip'];
    }
    else if(Encrypt == 'TKIPandAESEncryption')
    {
        Encrypt = cfg_wlaninfo_detail_language['amp_encrypt_tkipaes'];
    }

    if ((Auth == cfg_wlaninfo_detail_language['amp_auth_open'] || Auth =="OpenSystem") && 
            Encrypt == cfg_wlaninfo_detail_language['amp_encrypt_none'])
    {
        wetherConfig = status_wlaninfo_language['amp_authencry_off'];
    }
    else
    {
        wetherConfig = status_wlaninfo_language['amp_authencry_on'];
    }  

    if (1 == DTHungaryFlag)
    {
        if (Auth == cfg_wlaninfo_detail_language['amp_auth_open'])
        {
            Auth = 'WEP open';
        }
        else if (Auth == cfg_wlaninfo_detail_language['amp_auth_shared'])
        {
            Auth = 'WEP shared';
        }
    }

    if (wlanselect[i].enable ==1)
    {
        status = cfg_wlanupmode_db_language['amp_ssid_enable'];
    }
    else
    {
        status = cfg_wlanupmode_db_language['amp_ssid_disable'];
    }
    
    SSIDInfoArr.push(new stWlanTb(wlanselect[i].ssid, wetherConfig, status, Auth,Encrypt));
}

function selectLine(str)
{
    
}
function LoadFrame()
{
}
</script>
<body onload="LoadFrame();">

<div class="func_spread"></div>

<div id="divSSIDInfo" style="width: 94%;margin-left: 22px;">

<div class="func_title" style="background-color: #56B2F8;padding: 7px 0;">
    <SCRIPT>document.write(status_wlaninfo_language["amp_ssidinfo_title"]);</SCRIPT>
</div>

<div id="DivSSIDInfo_Table_Container" style="overflow:auto;overflow-y:hidden">
<script language="JavaScript" type="text/javascript">
    var SSIDConfiglistInfo = new Array(new stTableTileInfo("amp_wlanstat_name","align_center","ssid",false),
                new stTableTileInfo("amp_ssidinfo_secu","align_center","wetherConfig",false),
                new stTableTileInfo("amp_wlanlink_statusmh","align_center","status",false),
                new stTableTileInfo("amp_ssidinfo_auth","align_center","auth",false),
                new stTableTileInfo("amp_ssidinfo_encry","align_center","encrypt",false),null);                            
    var ColumnNum = SSIDConfiglistInfo.length-1;
    var ShowButtonFlag = false;
    var DhcpStaticTableConfigInfoList = new Array();
    var TableDataInfo = HWcloneObject(SSIDInfoArr, 1);
    TableDataInfo.push(null);
    HWShowTableListByType(1, "wlan_ssidinfo_table", ShowButtonFlag, ColumnNum, TableDataInfo, SSIDConfiglistInfo, status_wlaninfo_language, null);
</script>

</div>  
</body>
</html>
