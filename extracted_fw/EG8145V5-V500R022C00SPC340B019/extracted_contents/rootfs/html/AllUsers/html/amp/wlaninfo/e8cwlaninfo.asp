<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, status_wlaninfo_language, cfg_wlaninfo_db_language, cfg_wlaninfo_detail_language);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>WLAN信息</title>
<script language="JavaScript" type="text/javascript">
var aWiFiCustFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_FEATURE_AWIFI);%>';
var aWiFiSSID2GInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AWiFi_SSID.SSID2GINST);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var currentBin = '<%HW_WEB_GetBinMode();%>';

var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';

function stWlan(domain,enable,name,ssid,BeaconType,BasicEncrypt,BasicAuth,WPAEncrypt,WPAAuth,IEEE11iEncrypt,IEEE11iAuth,WPAand11iEncrypt,WPAand11iAuth,Channel,LowerLayers)
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
}

function stPacketInfo(domain,totalBytesSent,totalPacketsSent,totalBytesReceived,totalPacketsReceived)
{
    this.domain = domain;
    this.totalBytesSent = totalBytesSent;
	this.totalPacketsSent = totalPacketsSent;
	this.totalBytesReceived = totalBytesReceived;
	this.totalPacketsReceived = totalPacketsReceived;
}

function stRadio(domain,OperatingFrequencyBand,Enable)
{
    this.domain = domain;
    this.OperatingFrequencyBand = OperatingFrequencyBand;
    this.Enable = Enable;
}


function stIndexMapping(index,portIndex)
{
    this.index = index;
    this.portIndex = portIndex;
}

var WlanInfo = new Array();
WlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Enable|Name|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|Channel|LowerLayers,stWlan);%>;  

var WlanChannel = '';

var PacketInfo = new Array();
PacketInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},TotalBytesSent|TotalPacketsSent|TotalBytesReceived|TotalPacketsReceived,stPacketInfo,STATUS);%>; 

var wlanEnbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';

var wlanArrLen = WlanInfo.length - 1;

var WlanMap = new Array();
var j = 0;
for (var i = 0; i < wlanArrLen; i++)
{
    var index = getWlanPortNumber(WlanInfo[i].name);
    var wlanInst = getWlanInstFromDomain(WlanInfo[i].domain);

    if (isSsidForIsp(wlanInst) == 1)
    {
     	continue;
    }
    else
    {
    	WlanMap[j] = new stIndexMapping(i, index);
    	j++;
    }
}

if (WlanMap.length >= 2)
{
    for (var i = 1; i < WlanMap.length; i++)
    {
        for( var j = i+1; j < WlanMap.length; j++)
        {
            if (WlanMap[i].portIndex > WlanMap[j].portIndex)
            {
                var middle = WlanMap[i];
                WlanMap[i] = WlanMap[j];
                WlanMap[j] = middle;
            }
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

function onClickMethod()
{   
    if ((1 == getRadioVal("WlanMethod")))
    {   
        top.changeWlanClick = 1;
    }
    else if (2 == getRadioVal("WlanMethod"))
    {   
        top.changeWlanClick = 2;
    }
	else
    {
        top.changeWlanClick = 1;	
    }

    window.location.reload();
}

function LoadFrame()
{
	if (1 == DoubleFreqFlag)
	{
		setDisplay("WlanDoubleChannel",1);
	}
	else
	{
		setDisplay("WlanDoubleChannel",0);
	}

	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}

		b.innerHTML = status_wlaninfo_language[b.getAttribute("BindText")];
	}
}
</script>

</head>
<body class="mainbody" onLoad="LoadFrame();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
        <label id="Title_wlan_satus_lable" class="title_common">在本页面上，您可以查询无线网络工作状态，以及SSID统计信息与配置信息。</label>
        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height15p"></td></tr>
</table>

<div id="WlanDoubleChannel" style="display:none">
<table id="DoubleChannel" width="100%" cellspacing="1" class="table_button">
    <tr>       	
    <td height = "30px"> <input name="WlanMethod" id="WlanMethod" type="radio" value="1" checked="checked" onclick="onClickMethod()"/>
    <script>document.write(cfg_wlaninfo_db_language['amp_wlan_display2g_info']);</script></td>
    <td height = "30px"> <input name="WlanMethod" id="WlanMethod" type="radio"  value="2"  onclick="onClickMethod()" />
    <script>document.write(cfg_wlaninfo_db_language['amp_wlan_display5g_info']); </script></td> 
    <script>
        var Method = top.changeMethod;
        if (1 ==top.changeWlanClick)
        {   
            setRadio("WlanMethod",1);
        }
        else if (2 == top.changeWlanClick)
        {
            setRadio("WlanMethod",2);
        }
        else
        {    
            setRadio("WlanMethod",1);
        }
    </script>
    </tr> 
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td height="15px"></td></tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    	<td id="Title_wlaninfo2_table" colspan="2" BindText='amp_wlaninfo_title'></td>
    </tr>
</table>

<table id="wlanlink_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr>
        <td id="Title_wlaninfo3_1_table" class="table_left width_per35" BindText='amp_wlanlink_status'></td>
        <td id="Title_wlaninfo3_2_table" class="table_right"> 
	        <script language="JavaScript" type="text/javascript">
				WlanInfoRefresh();

	            if (wlanEnbl == 1)
				{
					document.write('开启' + '&nbsp;&nbsp;');
				}
				else
				{
					document.write('关闭' + '&nbsp;&nbsp;');
				}
	        </script>
	    </td>
    </tr>
	
	<tr>	
		<td id="Title_wlaninfo4_1_table" class="table_left width_per35" BindText='amp_wlaninfo_channel'></td>
        <td id="Title_wlaninfo4_2_table" class="table_right">
			<script language="JavaScript" type="text/javascript">	
				document.write(WlanChannel);
			</script>
		</td>
    </tr>    
</table>

<table id="TrBeforeSSIDStats" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height15p"></td></tr>
</table>

<table id="TrSSIDStats" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="tabal_head"> 
    <td id="Table_wlanstat_table" colspan="10" BindText='amp_wlanstat_title'></td>
  </tr>
</table>

<div id="DivSSIDStats" style="overflow:auto;overflow-y:hidden">
<table id="wlan_pkts_statistic_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
  <tr class="table_title" align="center"> 
    <td id="Table_wlanstat_1_1_table" class="width_per10" rowspan="2" BindText='amp_wlanstat_id'></td>
    <td id="Table_wlanstat_1_2_table" class="width_per25" rowspan="2" BindText='amp_wlanstat_name'></td>
    <td id="Table_wlanstat_1_3_table" colspan="2" BindText='amp_wlanstat_rx'></td>
    <td id="Table_wlanstat_1_4_table" colspan="2" BindText='amp_wlanstat_tx'></td>
  </tr>
  <tr class="table_title" align="center"> 
    <td id="Table_wlanstat_2_3_table">字节数</td>
    <td id="Table_wlanstat_2_4_table">帧数</td>
    <td id="Table_wlanstat_2_5_table">字节数</td>
    <td id="Table_wlanstat_2_6_table">帧数</td>
  </tr>
    <script language="JavaScript" type="text/javascript">
    if (wlanEnbl != '')
    {
        if ((wlanEnbl == 1) && (WlanMap.length != 0))
        {
            for (i = 0; i < WlanMap.length; i++)
            {			
                var index = getIndexFromPort(WlanMap[i].portIndex);
                var wlanInst = getWlanInstFromDomain(WlanInfo[index].domain);
				if (wlanInst == aWiFiSSID2GInst && aWiFiCustFlag == '1' && curUserType != '0')
                {
                    continue;
                }
				
				if (0 == DoubleFreqFlag)
                {
                    if (WlanMap[i].portIndex > SsidPerBand-1)
                    {
                        continue;
                    }					
                }
                
				var id_inst = "Table_wlanstat_" + (3 + i) + "_1_table";
				var id_name = "Table_wlanstat_" + (3 + i) + "_2_table";
				var id_rxbyte = "Table_wlanstat_" + (3 + i) + "_3_table";
				var id_rxframe = "Table_wlanstat_" + (3 + i) + "_4_table";
				var id_txbyte = "Table_wlanstat_" + (3 + i) + "_5_table";
				var id_txframe = "Table_wlanstat_" + (3 + i) + "_6_table";

                if ((1 == DoubleFreqFlag) && (1 == top.changeWlanClick))
                {
                    if (WlanMap[i].portIndex > SsidPerBand-1)
                    {
                        continue;
                    }					
                }
					
                if ((1 == DoubleFreqFlag) && (2 == top.changeWlanClick))
                {
                    if (WlanMap[i].portIndex < SsidPerBand)
                    {
                        continue;
                    }					
                }

                if (PacketInfo[index] != null)
                {   
                    if (i%2 == 0)
                    {
                        document.writeln("<tr class='tabal_01'>");
                    }
                    else
                    {
                        document.writeln("<tr class='tabal_02'>");
                    }

                    document.writeln("<td id=" + id_inst + ">" + wlanInst + "</td>");
                    document.writeln("<td id=" + id_name + ">" + (htmlencode(WlanInfo[index].ssid)) + "</td>");
                    document.writeln("<td id=" + id_rxbyte + ">" + PacketInfo[index].totalBytesReceived + "&nbsp;</td>");
                    document.writeln("<td id=" + id_rxframe + ">" + PacketInfo[index].totalPacketsReceived + "&nbsp;</td>");
                    document.writeln("<td id=" + id_txbyte + ">" + PacketInfo[index].totalBytesSent + "&nbsp;</td>");
                    document.writeln("<td id=" + id_txframe + ">" + PacketInfo[index].totalPacketsSent + "&nbsp;</td>");
                    document.writeln("</tr>");
                }
            }
        }
        else
        {
            document.writeln("<tr class='tabal_01'>");
            document.writeln("<td id='Table_wlanstat_3_1_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanstat_3_2_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanstat_3_3_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanstat_3_4_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanstat_3_5_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanstat_3_6_table' class='align_center'>--</td>");
            document.writeln("</tr>");
        }
    }
    </script>
</table> 
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td height="15px"></td></tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    	<td id="Table_wlanssid_table" colspan="5" BindText='amp_ssidinfo_title'></td>
    </tr>
</table>

<table id="wlan_ssidinfo_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr class="table_title" align="center">
	    <td id="Table_wlanssid_1_1_table" class="width_per10" BindText='amp_wlanstat_id'></td>
	    <td id="Table_wlanssid_1_2_table" class="width_per25" BindText='amp_wlanstat_name'></td>
	    <td id="Table_wlanssid_1_3_table" BindText='amp_ssidinfo_secu'></td>
	    <td id="Table_wlanssid_1_4_table" BindText='amp_ssidinfo_auth'></td>
	    <td id="Table_wlanssid_1_5_table" BindText='amp_ssidinfo_encry'></td>
	</tr>
<script language="javascript">
    if (wlanEnbl != '')
    {
        if ((wlanEnbl == 1) && (WlanMap.length != 0))
        {
            var wlanlen = WlanMap.length;
		
            for (i = 0; i < wlanlen; i++)
            {
                var index = getIndexFromPort(WlanMap[i].portIndex);
                var wlanInst = getWlanInstFromDomain(WlanInfo[index].domain);
				
				var id_inst = "Table_wlanssid_" + (2 + i) + "_1_table";
				var id_name = "Table_wlanssid_" + (2 + i) + "_2_table";
				var id_security = "Table_wlanssid_" + (2 + i) + "_3_table";
				var id_Auth = "Table_wlanssid_" + (2 + i) + "_4_table";
				var id_Encrpt = "Table_wlanssid_" + (2 + i) + "_5_table";
				
				if ('' == WlanInfo[i].name)
				{
					continue;
				}
                if (wlanInst == aWiFiSSID2GInst && aWiFiCustFlag == '1' && curUserType != '0')
                {
                    continue;
                }
				
				if (0 == DoubleFreqFlag)
                {
                    if (WlanMap[i].portIndex > SsidPerBand-1)
                    {
                        continue;
                    }					
                }
				
                if ((1 == DoubleFreqFlag) && (1 == top.changeWlanClick))
                {
                    if (WlanMap[i].portIndex > SsidPerBand-1)
                    {
                        continue;
                    }					
                }
					
                if ((1 == DoubleFreqFlag) && (2 == top.changeWlanClick))
                {
                    if (WlanMap[i].portIndex < SsidPerBand)
                    {
                        continue;
                    }					
                }

                var auth_none = "NONE";
                var auth_wep = "WEP";
                var auth_wpa_psk = "WPA-PSK";
                var auth_wpa2_psk = "WPA2-PSK";
                var auth_wpawpa2_psk = "WPA-PSK/WPA2-PSK";
                var auth_wpa3_psk = "WPA3-SAE";
                var auth_wpa = cfg_wlaninfo_detail_language['amp_auth_wpa'];
                var auth_wpa2 = cfg_wlaninfo_detail_language['amp_auth_wpa2'];
                var auth_wpawpa2 = cfg_wlaninfo_detail_language['amp_auth_wpawpa2'];
                var auth_wpa3 = "WPA3 Enterprise";
                var auth_wpa2wpa3 = "WPA2/WPA3 Enterprise";
                if (currentBin.toUpperCase() == "E8C") {
                    var auth_wpa2wpa3_psk = "WPA3-SAE Transition";
                } else {
                    var auth_wpa2wpa3_psk = "WPA2-PSK/WPA3-SAE";
                }

                var encrypt_none = "NONE";
                var encrypt_open = "OPEN";
                var encrypt_share = "SHARE";
                var encrypt_both = "OPEN+SHARE";
                var encrypt_tkip = "TKIP";
                var encrypt_aes = "AES";
                var encrypt_tkipaes = "TKIP+AES";

				if (WlanInfo[index].BeaconType == 'None')
				{
					Auth = auth_none;
					Encrypt = encrypt_none;
				}
                else if (WlanInfo[index].BeaconType == 'Basic')
                {
                    Auth = WlanInfo[index].BasicAuth;
                    Encrypt = WlanInfo[index].BasicEncrypt;
					
					if (Encrypt == "None")
					{
						Auth = auth_none;
						Encrypt = encrypt_none;
					}
					else if (Encrypt == "WEPEncryption")
					{
						if ((Auth == "OpenSystem") || (Auth == "None"))
						{
							Encrypt = encrypt_open;
						}
						else if ((Auth == "SharedKey") || (Auth == "SharedAuthentication"))
						{
							Encrypt = encrypt_share;
						}
						else if (Auth == "Both")
						{
							Encrypt = encrypt_both;
						}

						Auth = auth_wep;						
					}
                }
                else if (WlanInfo[index].BeaconType == 'WPA')
                {
                    Auth = WlanInfo[index].WPAAuth;
                    Encrypt = WlanInfo[index].WPAEncrypt;
					
					if (Auth == "PSKAuthentication")
					{
						Auth = auth_wpa_psk;
					}
					else
					{
						Auth = auth_wpa;
					}
					
					if (Encrypt == "TKIPEncryption")
					{
						Encrypt = encrypt_tkip;
					}
					else if (Encrypt == "AESEncryption")
					{
						Encrypt = encrypt_aes;
					}
					else
					{
						Encrypt = encrypt_tkipaes;
					}
                }
                else if ( (WlanInfo[index].BeaconType == '11i') || (WlanInfo[index].BeaconType == 'WPA2') )
                {
                    Auth = WlanInfo[index].IEEE11iAuth;
                    Encrypt = WlanInfo[index].IEEE11iEncrypt;
					
					if (Auth == "PSKAuthentication")
					{
						Auth = auth_wpa2_psk;
					}
					else
					{
						Auth = auth_wpa2;
					}
					
					if (Encrypt == "TKIPEncryption")
					{
						Encrypt = encrypt_tkip;
					}
					else if (Encrypt == "AESEncryption")
					{
						Encrypt = encrypt_aes;
					}
					else
					{
						Encrypt = encrypt_tkipaes;
					}
                }
                else if ( (WlanInfo[index].BeaconType == 'WPAand11i') || (WlanInfo[index].BeaconType == 'WPA/WPA2'))
                {
                    Auth = WlanInfo[index].WPAand11iAuth;
                    Encrypt = WlanInfo[index].WPAand11iEncrypt;
					
					if (Auth == "PSKAuthentication")
					{
						Auth = auth_wpawpa2_psk;
					}
					else
					{
						Auth = auth_wpawpa2;
					}
					
					if (Encrypt == "TKIPEncryption")
					{
						Encrypt = encrypt_tkip;
					}
					else if (Encrypt == "AESEncryption")
					{
						Encrypt = encrypt_aes;
					}
					else
					{
						Encrypt = encrypt_tkipaes;
					}
                } else if (WlanInfo[index].BeaconType == 'WPA3') {
                    Auth = WlanInfo[index].WPAand11iAuth;
                    Encrypt = encrypt_aes;

                    if (Auth == "SAEAuthentication") {
                        Auth = auth_wpa3_psk;
                    } else {
                        Auth = auth_wpa3;
                    }
                } else if (WlanInfo[index].BeaconType == 'WPA2/WPA3') {
                    Auth = WlanInfo[index].WPAand11iAuth;
                    Encrypt = encrypt_aes;

                    if (Auth == "PSKandSAEAuthentication") {
                        Auth = auth_wpa2wpa3_psk;
                    } else {
                        Auth = auth_wpa2wpa3;
                    }
                }

                if (((WlanInfo[index].BeaconType == "None") || (WlanInfo[index].BeaconType == "Basic")) && (Encrypt == encrypt_none))
                {
                    wetherConfig = status_wlaninfo_language['amp_authencry_off'];
                }
                else
                {
                    wetherConfig = status_wlaninfo_language['amp_authencry_on'];
                }

                if (i%2 == 0)
				{
					document.writeln("<tr class='tabal_01'>");
				}
				else
				{
					document.writeln("<tr class='tabal_02'>");
				}
				
				document.writeln("<td id=" + id_inst + ">" + wlanInst + "</td>");
				document.writeln("<td id=" + id_name + ">" + (htmlencode(WlanInfo[index].ssid)) + "</td>");
				document.writeln("<td id=" + id_security + ">" + wetherConfig + "&nbsp;</td>");
				document.writeln("<td id=" + id_Auth + ">" + Auth + "&nbsp;</td>");
				document.writeln("<td id=" + id_Encrpt + ">" + Encrypt + "&nbsp;</td>");
				document.writeln("</tr>");
            }
        }
        else
        {
			document.writeln("<tr class='tabal_01'>");
            document.writeln("<td id='Table_wlanssid_2_1_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanssid_2_2_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanssid_2_3_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanssid_2_4_table' class='align_center'>--</td>");
            document.writeln("<td id='Table_wlanssid_2_5_table' class='align_center'>--</td>");
            document.writeln("</tr>");
        }
    }
</script>
</table>

</div>
<br> 
</body>
</html>
