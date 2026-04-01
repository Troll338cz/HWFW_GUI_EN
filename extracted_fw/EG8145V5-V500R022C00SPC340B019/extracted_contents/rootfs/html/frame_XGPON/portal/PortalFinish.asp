<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title></title>
<link href="/Cuscss/<%HW_WEB_GetCusSource(bootstrap.min.css);%>"  media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(portal.css);%>"  media="all" rel="stylesheet" />
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(bootstrap.min.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>  
<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>

<script>
var kppUsedFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_PWD_KPP_USED);%>';
var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
var portalAPType = '<%HW_WEB_GetApMode();%>';
var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
var WanIpList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i}, X_HW_BindPhyPortInfo,stWANIP);%>;
var WanPppList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},X_HW_BindPhyPortInfo,stWANPPP);%>;

function stWANIP(domain, X_HW_BindPhyPortInfo)
{
	this.domain 	  = domain;
	this.BindPhyPort  = X_HW_BindPhyPortInfo;
}

function stWANPPP(domain, X_HW_BindPhyPortInfo)
{
	this.domain 	  = domain;
	this.BindPhyPort  = X_HW_BindPhyPortInfo;
}
	
function stWlan(domain, Name, ssid)
{
	this.domain = domain;
	this.name = Name;
	this.ssid = ssid;
}
var WlanList = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, Name|SSID, stWlan);%>;

function getWlanPortNumber(name)
{
    var length = name.length;
    var str = parseInt(name.charAt(length-1));
    return str;
}

var index2g = 0;
var index5g = 0;
for (var i = 0; i < WlanList.length-1; i++)
{
   if (0 == getWlanPortNumber(WlanList[i].name))
   {
		index2g = i;
   }
   else if (4 == getWlanPortNumber(WlanList[i].name))
   {
		index5g = i;
   }
}

if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
{
	window.location='/login.asp'; 
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

function showSsid()
{
	if (parent.isConfigWiFi != 1)
	{
		var ssidDefault = GetSSIDStringContent(htmlencode(WlanList[index2g].ssid),32); 
		if (WlanList[index2g].ssid != WlanList[index5g].ssid)
		{
			ssidDefault = ssidDefault + PortalguideDes['pwifi020'] + GetSSIDStringContent(htmlencode(WlanList[index5g].ssid),32);
		}
	
		getElementById("ssidSpan").innerHTML = ssidDefault;
		return;
	}
	
	var ssid = GetSSIDStringContent(htmlencode(parent.wifiSsid),32); 
	if (parent.wifiSsid != parent.wifissid5g)
	{
		ssid = ssid + PortalguideDes['pwifi020'] + GetSSIDStringContent(htmlencode(parent.wifissid5g),32);
	}
	
	getElementById("ssidSpan").innerHTML = ssid;
}

function HwAjaxConfigPara(ObjPath, ParameterList)
{
    var Result = null;
      $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/portalguideconfig.cgi?' + ObjPath + "&RequestFile=/portal/PortalFinish.asp",
        data: getDataWithToken(ParameterList),
        success : function(data) {
             Result  = data;
        }
    });
    
    return Result;
}

function HwResetAjaxConfigPara(ObjPath, ParameterList)
{
    var Result = null;
      $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/portalguideconfig.cgi?' + ObjPath + "&RequestFile=/reset.asp",
        data: getDataWithToken(ParameterList),
        success : function(data) {
             Result  = data;
        }
    });
    
    return Result;
}


function GetLANPortPathValue()
{
	var tempPath = "";
	var LANPortRes = "";
	for(var i = 0; i < self.parent.CurrentLANPortList.length; i++)
	{
		if (self.parent.CurrentLANPortList[i].indexOf("LAN") != -1)
		{
			tempPath = self.parent.CurrentLANPortList[i].replace("LAN", LANPath);
		}
		else
		{
			tempPath = self.parent.CurrentLANPortList[i].replace("SSID", SSIDPath);
		}
		
		if (i == 0)
		{
			LANPortRes = tempPath;
		}
		else
		{
			LANPortRes = LANPortRes + "," + tempPath;
		}
	}
	
	return LANPortRes;
}

function FormatUrlEncode(val)
{
	if(null != val)
	{
		var formatstr = escape(val);
		formatstr=formatstr.replace(new RegExp(/(\+)/g),"%2B");
		formatstr = formatstr.replace(new RegExp(/(\/)/g), "%2F");
		return formatstr
	}
	return null;
}

function ModifyWebPwd()
{	
	if (self.parent.curSamePWD != 1 || parent.isConfigWiFi != 1)
	{
		return;
	}
	
	var path = "x=" + self.parent.UserInfoList[0].domain;
	var set_wanparalist ="x.Password=" + FormatUrlEncode(parent.wifiWPAPskKey);
	HwAjaxConfigPara(path, set_wanparalist);
}


function IGMPandVenderSubForm()
{
	if (self.parent.supportIPTVUPPortFlag != 1)
	{
		return;
	}
	
	var IGMPEnable_Value = 1;
	var ConfigUrl = "x=InternetGatewayDevice.Services.X_HW_IPTV";
	var SummitData = "&x.IGMPEnable=" + IGMPEnable_Value;
	
	var VenderClassId_Value = "HWAP";
	ConfigUrl += "&y=InternetGatewayDevice.X_HW_APService";
	SummitData += "&y.VenderClassId=" + VenderClassId_Value;
	HwAjaxConfigPara(ConfigUrl, SummitData);
	return;
}

function WANPhyPort(WANInfo)
{
	var i = 0;
	var j = 0;
	var isFindPort = 0;
	var BindPhyPortList = WANInfo.BindPhyPort.split(",");
	var path = "x=" + WANInfo.domain;
	var set_wanparalist = "x.X_HW_BindPhyPortInfo=";
	var ResWanPhyPort = "";
	
	for (i = 0; i < BindPhyPortList.length; i++)
	{
		isFindPort = 0;
		for (j = 0; j < self.parent.CurrentLANPortList.length; j++)
		{
			if (BindPhyPortList[i] == self.parent.CurrentLANPortList[j])
			{
				isFindPort = 1;
				break;
			}
		}
		
		if (isFindPort == 0)
		{
			if (ResWanPhyPort == "")
			{
				ResWanPhyPort = BindPhyPortList[i];
			}
			else
			{
				ResWanPhyPort = ResWanPhyPort + "," + BindPhyPortList[i];
			}
		}
	}

	if (ResWanPhyPort != "" || (ResWanPhyPort == "" && BindPhyPortList.length != 0))
	{
		set_wanparalist = set_wanparalist + ResWanPhyPort;
		HwAjaxConfigPara(path, set_wanparalist);
	}
}

function WANListPhyPortSubForm()
{
	var i = 0;

	for (i = 0; i < WanIpList.length - 1; i++)
	{
		WANPhyPort(WanIpList[i]);
	}

	for (i = 0; i < WanPppList.length - 1; i++)
	{
		WANPhyPort(WanPppList[i]);
	}
}

function DelaySubForm()
{
	var ConfigUrl = "a=InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl";
	var SummitData = "a.PortalGuideSupport=0";
	
	if (self.parent.EnableUPPort == "on" && self.parent.supportIPTVUPPortFlag == 1 && self.parent.IsIPTVNeedConfig == 1)
	{
		WANListPhyPortSubForm();
		var PhyPortName_Value = GetLANPortPathValue(); 
		ConfigUrl += "&b=InternetGatewayDevice.X_HW_APService.MultiSrvPortList";
		SummitData += "&b.PhyPortName=" + PhyPortName_Value;
		
		var IPTVUpPort_Value = self.parent.CurrentIPTVUpInfo.replace("LAN", LANPath); 
		ConfigUrl += "&c=InternetGatewayDevice.X_HW_APService";
		SummitData += "&c.IPTVUpPort=" + IPTVUpPort_Value;
	}

	if (parent.isConfigWiFi == 1)
	{
		var path2g = 'x=' + parent.wlanDomain2g;
		var path5g = 'y=' + parent.wlanDomain5g;
		var path2gPwd = 'm=' + parent.wlanDomain2g + '.PreSharedKey.1';
		var path5gPwd = 'n=' + parent.wlanDomain5g + '.PreSharedKey.1';
		var path = path2g + '&' + path5g + '&' + path2gPwd + '&' + path5gPwd;
			
		var pskPath = 'PreSharedKey';
		if('1' == kppUsedFlag)
		{
			pskPath = 'KeyPassphrase';
		}
			
		var set_wanparalist = 'x.SSID=' + parent.wifiSsid 
		+ '&x.BeaconType=WPAand11i&x.X_HW_WPAand11iAuthenticationMode=PSKAuthentication&x.X_HW_WPAand11iEncryptionModes=TKIPandAESEncryption'
		+ '&y.SSID=' + parent.wifissid5g 
		+ '&y.BeaconType=WPAand11i&y.X_HW_WPAand11iAuthenticationMode=PSKAuthentication&y.X_HW_WPAand11iEncryptionModes=TKIPandAESEncryption'
		+ '&m.' + pskPath + '=' + parent.wifiWPAPskKey
		+ '&n.' + pskPath + '=' + parent.wifiWPAPskKey;	
		ConfigUrl += "&" + path;
		SummitData += "&" + set_wanparalist;
	}

	if (self.parent.EnableUPPort == "on"  && self.parent.supportIPTVUPPortFlag == 1 && self.parent.IsIPTVNeedConfig == 1)
	{
		HwResetAjaxConfigPara(ConfigUrl, SummitData);
	}
	else
	{
		HwAjaxConfigPara(ConfigUrl, SummitData);
	}	
}

function SubmitConfig()
{
	IGMPandVenderSubForm();
	ModifyWebPwd();
	DelaySubForm();
}

function showHtml()
{
	if (self.parent.EnableUPPort == "on" && self.parent.IsIPTVNeedConfig == 1)
	{
		getElementById('confFinishDiv').innerHTML = '<div><span>' + PortalguideDes['p0151'] + '</div>'
											  + '<div><span>' + PortalguideDes['p0152'] + '</span><span id="ssidSpan"></span>'
											  + '<span>' + PortalguideDes['p0153'] + '</span></div>';							  
		showSsid();	 
	}
	else
	{
		getElementById('confFinishDiv').innerHTML = '<div><span>' + PortalguideDes['p0155'] + '</div>'
											  + '<div><span>' + PortalguideDes['p0152'] + '</span><span id="ssidSpan"></span>'
											  + '<span>' + PortalguideDes['p0153'] + '</span></div>';		
		showSsid();
	}
} 

function LoadFrame()
{
	showHtml();
	parent.adjustIframeHeight();
	setTimeout("SubmitConfig()",2000);
	self.parent.curPageFlag = "EndStatusPage";
	self.parent.ControlPageShow();
}

</script>
</head>
<body onload="LoadFrame()" style="background-color: #f2f2f2;">
<div class="stepPortalContent container">
  <div class="row">
    <div class="col-sm-12">
	    <div id="wifienablebtn" style="text-align:center">
	        <img id="wifienablecir"  style="width:200px; height: 200px; margin-top: 50px;" src="/images/btncyclewifi.jpg">
		</div>							 
    </div>
  </div>
  <br/>
  <div class="row">
    <div class="col-sm-12">
       <div id="confFinishDiv" class="portalFinishSpan">
       </div>	
    </div>
  </div>
  
</div>
	<script>
	ParseBindTextByTagName(PortalguideDes, "span", 1);
	ParseBindTextByTagName(PortalguideDes, "td", 1);
	ParseBindTextByTagName(PortalguideDes, "div", 1);
	ParseBindTextByTagName(PortalguideDes, "input", 2);
	</script>
</body>
</html>
