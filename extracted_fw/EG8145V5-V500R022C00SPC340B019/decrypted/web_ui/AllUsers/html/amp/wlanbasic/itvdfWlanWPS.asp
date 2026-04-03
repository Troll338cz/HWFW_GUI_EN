<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, IT_VDF_wlan_wps_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>WPS</title>
<script language="JavaScript" type="text/javascript">
function stWlan(domain,enable,name,ssid,BeaconType,BasicEncrypt,BasicAuth,WPAEncrypt,WPAAuth,IEEE11iEncrypt,IEEE11iAuth,WPAand11iEncrypt,WPAand11iAuth,wlHide)
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
	this.wlHide = wlHide;
}

function stWpsPin(domain, Enable)
{
    this.domain = domain;
    this.Enable = Enable;
}

var WlanInfo = new Array();
WlanInfo = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Enable|Name|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|SSIDAdvertisementEnabled,stWlan,STATUS);%>; 
var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,Enable,stWpsPin,STATUS);%>;

var WlanInfo2G;
var WlanInfo5G = '-1';
var WlanInfoArray = new Array();
for(var i = 0; i < WlanInfo.length - 1; i++)
{
	if (1 == getWlanInstFromDomain(WlanInfo[i].domain))
	{
		WlanInfo2G = WlanInfo[i];
		if (1 == WlanInfo2G.enable)
		{
			WlanInfoArray.push(WlanInfo2G);
		}
		
		continue;
	}
	else if (1 == DoubleFreqFlag && 5 == getWlanInstFromDomain(WlanInfo[i].domain))
	{
		WlanInfo5G = WlanInfo[i];
		if (1 == WlanInfo5G.enable)
		{
			WlanInfoArray.push(WlanInfo5G);
		}
		
		continue;
	}
}

var wpsPinNum2G;
var wpsPinNum5G = '-1';
var wpsPinNumArray = new Array();
for(var i = 0; i < wpsPinNum.length - 1; i++)
{
	if (1 == getWlanInstFromDomain(wpsPinNum[i].domain))
	{
		wpsPinNum2G = wpsPinNum[i];
		if (1 == WlanInfo2G.enable)
		{
			wpsPinNumArray.push(wpsPinNum2G);
		}
		continue;
	}
	else if (1 == DoubleFreqFlag && 5 == getWlanInstFromDomain(wpsPinNum[i].domain))
	{
		wpsPinNum5G = wpsPinNum[i];
		if (1 == WlanInfo5G.enable)
		{
			wpsPinNumArray.push(wpsPinNum5G);
		}
		continue;
	}
}

var wps1Cap2G = parseInt(capInfo.charAt(3));
var wps1Cap5G = parseInt(capInfo.charAt(3 + capInfo.length/2));

function stLanDevice(domain, WlanCfg, Wps2)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
    this.Wps2 = Wps2;
}

var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable|X_HW_Wps2Enable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];

var enbl = LanDevice.WlanCfg;
var Wps2 = LanDevice.Wps2;

var WlanCus = '<%HW_WEB_GetWlanCus();%>';
var WpsCapa = WlanCus.split(',')[0];
				
var auth = '';
var encrypt = '';
function getEncrypt()
{	
	var wlanInfo = WlanInfoArray[0];
	if ((wlanInfo.BeaconType == 'Basic')|| (wlanInfo.BeaconType == 'None'))
    {
		auth = wlanInfo.BasicAuth;
        encrypt = wlanInfo.BasicEncrypt;
    }
    else if (wlanInfo.BeaconType == 'WPA')
    {
        auth = wlanInfo.WPAAuth;
        encrypt = wlanInfo.WPAEncrypt;
    }
    else if ( (wlanInfo.BeaconType == '11i') || (wlanInfo.BeaconType == 'WPA2') )
	{
        auth = wlanInfo.IEEE11iAuth;
        encrypt = wlanInfo.IEEE11iEncrypt;
    }
    else if ( (wlanInfo.BeaconType == 'WPAand11i') || (wlanInfo.BeaconType == 'WPA/WPA2'))
    {
        auth = wlanInfo.WPAand11iAuth;
        encrypt = wlanInfo.WPAand11iEncrypt;
    }
}

function IsAuthModePsk(AuthMode)
{
    if ((('WPA' == WlanInfoArray[0].BeaconType) || ('WPA2' == WlanInfoArray[0].BeaconType) || ('11i' == WlanInfoArray[0].BeaconType)
		|| ('WPAand11i' == WlanInfoArray[0].BeaconType) ||('WPA/WPA2' == WlanInfoArray[0].BeaconType))
		&& AuthMode == 'PSKAuthentication')
    {
        return true;
    }
    else
    {
        return false;
    }
}

function IsWpsConfigDisplay()
{
	getEncrypt();
	var beanconType = WlanInfoArray[0].BeaconType;
    if ('1' == '<%HW_WEB_GetFeatureSupport(FT_WLAN_MULTI_WPS_METHOD);%>')
    {
	    return false;
    }

    if (IsAuthModePsk(auth))
    {
        if (((Wps2 == 1) && (encrypt == 'TKIPEncryption')) || (WpsCapa == 0))
        {
        	return false;
        }
		
		if (((Wps2 == 1) && (beanconType == 'WPA')) || (WpsCapa == 0))
        {
        	return false;
        }
		
        if(0 == wps1Cap2G)
        {
            if((('WPA2' == beanconType || '11i' == beanconType || 'WPAand11i' == beanconType || 'WPAandWAP2' == beanconType)) 
				&& (auth == 'PSKAuthentication') && ((encrypt == 'AESEncryption')||(encrypt == 'TKIPandAESEncryption')))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        return true;
    }

    return false;
}

function WpsPBCSubmit()
{
    var wpsEnable = getValue('DivWPSEnable');
    if (wpsEnable == 0)
    {
        AlertEx(IT_VDF_wlan_wps_language['amp_wps_enable_note']);
        return;
    }

    if (ConfirmEx(IT_VDF_wlan_wps_language['amp_wps_start'])) 
    {
        var Form = new webSubmitForm();
        setDisable('btnWpsPBC', 1);
        
		if (1 == wpsPinNumArray.length)
		{
			if (1 == getWlanInstFromDomain(wpsPinNumArray[0].domain))
			{
				Form.setAction('WpsPBC.cgi?freq=2G' + '&RequestFile=html/amp/wlanbasic/itvdfWlanWPS.asp');
			}
			else if (1 == DoubleFreqFlag && 5 == getWlanInstFromDomain(wpsPinNumArray[0].domain))
			{
				Form.setAction('WpsPBC.cgi?freq=5G' + '&RequestFile=html/amp/wlanbasic/itvdfWlanWPS.asp');
			}
		}
		else if (2 == wpsPinNumArray.length)
		{
			Form.setAction('WpsPBC.cgi?freq=BOTH' + '&RequestFile=html/amp/wlanbasic/itvdfWlanWPS.asp');
		}
        
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

var intTime = 0;
var WpsTimeHandle;
function getPairTime()
{
	intTime--;
	var SpanTimerCount = getElementById('timerCount');
	SpanTimerCount.innerHTML = '';
	SpanTimerCount.innerHTML = intTime;
	
	if (intTime == 0)
	{
		if(WpsTimeHandle != undefined)
		{
			clearInterval(WpsTimeHandle);
		}
	}
}

function startPair()
{
	if (1 != WlanInfoArray[0].wlHide)
	{
		alert(IT_VDF_wlan_wps_language['amp_wps_on_help']);
		return;
	}
	
	WpsPBCSubmit();
}	

function successPair()
{
	getElementById('DivAttempt').style.display = 'none';
	getElementById("DivSuccess").style.display = '';
	getElementById("DivFail").style.display = 'none';
}

function failPair()
{
	getElementById('DivAttempt').style.display = 'none';
}

function SetImgValue(Buttonid, ButtonValue)
{
	var Btnelement = getElementById(Buttonid);
	if(null == Btnelement)
	{
		return;
	}

	if(1 == ButtonValue)
	{
		Btnelement.src="../../../images/checkon.gif";
		Btnelement.value = 1;
	}
	else
	{
		Btnelement.src="../../../images/checkoff.gif";
		Btnelement.value = 0;
	}	
}

function changeImg(element)
{
	if (element.src.match("checkon"))
	{
		element.src="../../../images/checkoff.gif";
		element.value = 0;
	}
	else
	{
		element.src="../../../images/checkon.gif";
		element.value = 1;
	}
}

function wlanWPSEnable()
{
	if (WlanInfoArray.length < 1)
	{
		return;
	}
		
	if (1 != enbl)
	{
		alert(IT_VDF_wlan_wps_language['amp_wps_wlan_enable_sug']);
		return;
	}
	
	if(!IsWpsConfigDisplay())
	{
		alert(IT_VDF_wlan_wps_language['amp_wps_auth_sug']);
		return;
	}
	
	var wpsEnable = getElementById('DivWPSEnable');
	changeImg(wpsEnable);
	var enable = wpsEnable.value;
	setDisplay('DivWps', enable);
	
	var Form = new webSubmitForm();
	Form.addParameter('y.Enable',enable);
	var wlandomain = wpsPinNumArray[0].domain;
	var url_pin = '';
	if (1 == wpsPinNumArray.length)
	{
		url_pin = 'set.cgi?y=' + wlandomain + '&RequestFile=html/amp/wlanbasic/itvdfWlanWPS.asp';
	}
	else if (2 == wpsPinNumArray.length) 
	{
		Form.addParameter('z.Enable',enable);
		var wlandomain1 = wpsPinNumArray[1].domain;
		url_pin = 'set.cgi?y=' + wlandomain  
				  + '&z=' + wlandomain1 + '&RequestFile=html/amp/wlanbasic/itvdfWlanWPS.asp';
	}
	
	Form.setAction(url_pin);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function LoadBindText()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (IT_VDF_wlan_wps_language[b.getAttribute("BindText")]) 
        {
            b.innerHTML = IT_VDF_wlan_wps_language[b.getAttribute("BindText")];
        }
    }
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

        if (IT_VDF_wlan_wps_language[b.getAttribute("BindText")]) 
        {
            b.value = IT_VDF_wlan_wps_language[b.getAttribute("BindText")];
        }
    }
}

function LoadFrame()
{		
	LoadBindText();
	LoadBtnBindText();
	
	var wpsEnable = 1;
	for (var i = 0; i < wpsPinNumArray.length; i++)
	{
	
		if(0 == wpsPinNumArray[i].Enable)
		{
			wpsEnable = 0;
			break;
		}
	}
	
	if (WlanInfoArray.length < 1)
	{
		return;
	}
	
	if (1 != enbl || !IsWpsConfigDisplay())
	{
		wpsEnable = 0;
	}
	
	SetImgValue('DivWPSEnable', wpsEnable);
	setDisplay('DivWps', wpsEnable);
	getElementById('divButton').style.display = '';
	
	if (intTime != 0)
	{
		getElementById('DivAttempt').style.display = '';
	}
	
	setDisplay('content', 1);
}

</script>

<style type="text/css">
#DivAttempt {
width:100%;
margin:0px auto;
background-color:#f0f0f2;
}

.row .left{
  float: none;
}

.img_btn img{
width:60px;
height:30px;
}
</style>

</head>
<body onLoad="LoadFrame();">
	<div>
		<div id="content" class="content-wps" style="display:none">
			<h1 style="font-family:'Arial';">
				<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_title']);</script></span>
			</h1>
			<h2><span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_explain']);</script></span></h2>
			
			<div id="divButton" class="h3-content" style="display:none">
				<div class="row">
					<div class="left">
						<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_function']);</script></span>        
					</div>
					<div class="right img_btn">
						<img id="DivWPSEnable" onclick="wlanWPSEnable();"/>
					</div>
				</div>
			</div>
			
			<div id="DivAttempt" class="popup tL try-to-pair-popup" style="display:none;
					position:absolute;">
				<div class="row">
					<div id="progress-bar-thinking-box">                
						<img src="../../../images/icon-thinking.gif" alt="Loading..."> 
					</div>
				</div>

				<p class="title"><span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_attempt_to_pair']);</script></span></p>

				<div class="row">
					<div class="left">
						<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_attempting']);</script></span>            
					</div>
				</div>
				<div class="row">
					<div class="left">
						<span><span id="timerCount" style="font-weight: bold;"></span>
							<script>document.write(IT_VDF_wlan_wps_language['amp_wps_timerCount']);</script>
						</span>			
					</div>
				</div>

				<div class="apply-cancel clearfix">
					<input class="button button-cancel" type="button" BindText="amp_btn_cancel" onclick="failPair()">
				</div>		
			</div>

			<div class="level-3 wpsOnOff shadowProblem" id="DivWps">
				<h3><span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc']);</script></span></h3>
				<div class="h3-content">
					<div class="row description">
						<div class="left" style="font-weight:normal;">
							<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc_info']);</script></span>            
						</div>
					</div>
				</div>
    
				<div class="h3-content" style="border-top: solid 1px #e6e6e6;">
					<div class="row">
						<div class="left">
							<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc_pair']);</script></span>            
						</div>
						<div class="right">
							<input id="btnWpsPBC" class="button button-blank" type="button"  BindText="amp_wps_btn_pair" onclick="startPair()">
						</div>
					</div>
				</div>
			</div>
			
			<div id='DivApply' class="clearfix apply-cancel" style="display:none">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			</div>
			
			<div id='DivFail' class="popup tL timeout-pair-popup" style="display:none;">
				<p class="title"><span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc_pair_timeout']);</script></span></p>
					<div class="row">
						<div class="left">
							<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc_pair_timeout_info']);</script></span>            
						</div>
					</div>
					
					<div class="row"></div>
					<div class="row">
						<div class="apply-cancel">
							<input type="button" class="button button-cancel successful-pair-popup" BindText="amp_btn_ok" onclick="successPair()">
						</div>
					</div>		
			</div>
			<div id='DivSuccess' class="popup tL successful-pair-popup" style="display:none;">
				<p class="title"><span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc_pair_success']);</script></span></p>
					<div class="row">
						<div class="left">
							<span><script>document.write(IT_VDF_wlan_wps_language['amp_wps_pbc_pair_success_info']);</script></span>            
						</div>
					</div>
					<div class="row"></div>
					<div class="apply-cancel">
						<input type="button" class="button button-cancel" BindText="amp_btn_ok">
					</div>
	
			</div>
			<div class="blackBackground" style="display:none">&nbsp;</div>
		</div>
	</div>
</body>
</html>
