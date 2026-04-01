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
<style>
#wlWpaPsk,#wlSsid,#wlWpaPsk1{
	font-size:1.5em;
	font-family:"Î¢ÈíÑÅºÚ";
	font-weight: bold;
	outline:none;
	width: 100%;
	height: 3.5em;
	color: #555;
	padding-left: 3%;
	line-height:3.5em;
}		
input::-ms-clear{
display:none;
}
input::-ms-reveal{
display:none;
}

</style>
<script> 
var trimssidFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NOT_TRIM_SSID);%>';

var capInfo = '<%HW_WEB_GetSupportAttrMask();%>';
var capNum = capInfo.length/2;
var capBandSteering2G = parseInt(capInfo.charAt(15));
var capBandSteering5G = parseInt(capInfo.charAt(15 + capNum));
var portalAPType = '<%HW_WEB_GetApMode();%>';
var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
{
	window.location='/login.asp'; 
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

function ltrim(str)
{ 
	 if(0 == trimssidFlag)
	 {
		return str.toString().replace(/(^\s*)/g,""); 
	 }
	 else
	 {
		return str.toString();
	 } 
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
	
function WifiEnableBtn()
{
	if(getElementById('wifienablecir').getAttribute('src') == "/images/checkon.jpg")
	{
		getElementById('wifienablecir').setAttribute('src', '/images/checkoff.jpg');
		setDisplay("ssid5g", 1);
	} 
	else
	{
		getElementById('wifienablecir').setAttribute('src', '/images/checkon.jpg');
		setDisplay("ssid5g", 0);
	}
	
	parent.adjustIframeHeight();
}

function pwdStrengthcheck(obj)
{
	$("#pwdvalue").css("display", "block");
	var wpapassword = "";
	if (obj.id == 'wlWpaPsk')
	{
		wpapassword=getValue('wlWpaPsk');
		getElById('wlWpaPsk1').value=wpapassword;
	}
	else 
	{
		wpapassword=getValue('wlWpaPsk1');
		getElById('wlWpaPsk').value=wpapassword;
	}
				
	var lengthmatch=0;
	var lowerCharmatch=0;
	var upCharmatch=0;
	var NumCharmatch=0;
	var specialCharmatch=0;
	var score = 0;
	var totalscore = 0;
	var DestPwdLen=6;
	var password1 = getElementById("wlWpaPsk").value;
	
	if(password1.length >= DestPwdLen) {
		lengthmatch = 1;
		score++;
	}

	if(password1.match(/[a-z]/)) {
		lowerCharmatch = 1;
		score++;
	}
	
	if(password1.match(/[A-Z]/)){
		upCharmatch = 1;
		score++;
	}
	
	if(password1.match(/[0-9]/)){
		NumCharmatch = 1;
		score++;
	}

	if(password1.match(/\d/)) score++;

	if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) {
		specialCharmatch=1;
		score++;
	}
	
	totalscore = lengthmatch + lowerCharmatch + upCharmatch + NumCharmatch + specialCharmatch;
	
	if(0 == lengthmatch || totalscore <=2 ){
		getElementById("pwdvalue").innerHTML=PortalguideDes['pwifi010'];
		getElementById("pwdvalue").style.width=18+"%";
		getElementById("pwdvalue").style.borderBottom="4px solid #FF0000";
		getElementById("pwdvalue").style.float="left";
		getElementById("pwdvalue").style.display="block";
		parent.adjustIframeHeight();
		return;
	}
	
	if(1 == lengthmatch && totalscore == 3){
		getElementById("pwdvalue").innerHTML=PortalguideDes['pwifi011'];
		getElementById("pwdvalue").style.width=49.8+"%";
		getElementById("pwdvalue").style.borderBottom="4px solid #FFA500";
		return;
	}
	
	if(1 == lengthmatch && totalscore > 3 ){
		getElementById("pwdvalue").innerHTML=PortalguideDes['pwifi012'];
		getElementById("pwdvalue").style.width=100+"%";
		getElementById("pwdvalue").style.borderBottom="4px solid #008000";
		return;
	}
}

function ShowOrHideText()
{
	var flag = $("#showPwd").attr("src");
    if (flag.indexOf("show") > -1)
    {
		$("#wlWpaPsk").css("display","none");
		$("#wlWpaPsk1").css("display","block");
        $("#showPwd").attr("src","/images/img_hide_pwd.jpg");
    }
    else
    {
		$("#wlWpaPsk").css("display","block");
		$("#wlWpaPsk1").css("display","none");
        $("#showPwd").attr("src","/images/img_show_pwd.jpg");
   }
}
 
function setcurInterStatus()
{
	if (0 == getCheckVal('wlpwdforWebEnbl'))
	{
		parent.curSamePWD = 0;
	}
	else
	{
		parent.curSamePWD = 1;
	}	

	if ((1 == getCheckVal('wlpwdforWebEnbl')) && (1 != self.parent.supportIPTVUPPortFlag))
	{
		parent.document.getElementById('NextpageBtnID').style.display = "none";
		parent.document.getElementById('EndBtnID').style.display = "";
	}
	else 
	{
		parent.document.getElementById('NextpageBtnID').style.display = "";
		parent.document.getElementById('EndBtnID').style.display = "none";
	}
}
 
function showSsid5g()
{
	var ssid = getValue('wlSsid');
	ssid = ltrim(ssid);
	getElementById("ssid5gSpan").innerHTML = GetSSIDStringContent(htmlencode(ssid,32)) + '-5G';
}
 
function isSupportBandsteering()
{
	if ((1 == capBandSteering2G) && (1 == capBandSteering5G))
	{
		return true;
	}
	else
	{
		return false;
	}
}
 
function checkSsid()
{
	var ssid = getValue('wlSsid');
    ssid = ltrim(ssid);
	var ssid5g = ssid + '-5G';
	
	if (isSupportBandsteering() && (getElementById('wifienablecir').getAttribute('src') == "/images/checkon.jpg"))
	{
		ssid5g = ssid;
	}
		
    if (ssid == '')
    {
		self.parent.AlertInfo(PortalguideDes['pwifi013']);
        return false;
    }

    if (ssid.length > 32)
    {
		self.parent.AlertInfo(PortalguideDes['pwifi014'] + ssid + PortalguideDes['pwifi015']);
        return false;
    }
	
	if (ssid5g.length > 32)
	{
		self.parent.AlertInfo(PortalguideDes['pwifi014'] + ssid5g + PortalguideDes['pwifi015']);
		return false;
	}
	
	if (isValidAscii(ssid) != '')
    {
		self.parent.AlertInfo(PortalguideDes['pwifi014'] + ssid + PortalguideDes['pwifi016'] + isValidAscii(ssid));
        return false;
    }
	
    for (i = 0; i < WlanList.length-1; i++)
    {
        if ((getWlanPortNumber(WlanList[i].name)<= 3) && index2g != i && WlanList[i].ssid == ssid)
        {
			self.parent.AlertInfo(PortalguideDes['pwifi017']);
			return false;
        }
        
		if ((getWlanPortNumber(WlanList[i].name) > 3) && index5g != i && WlanList[i].ssid == ssid5g)
		{
			self.parent.AlertInfo(PortalguideDes['pwifi017']);
			return false;
		}
    }
	
	parent.wifiSsid = ssid;
	parent.wifissid5g = ssid5g;
	
	return true;
}
 
function isValidWPAPskKey(val)
{
    var ret = false;
    var len = val.length;
    var maxSize = 64;
    var minSize = 8;
 
    if (isValidAscii(val) != '')
    {
       return false;
    }

    if ( len >= minSize && len < maxSize )
    {
    	ret = true;
    }
    else if ( len == maxSize )
    {
        for ( i = 0; i < maxSize; i++ )
            if ( isHexaDigit(val.charAt(i)) == false )
                break;
        if ( i == maxSize )
            ret = true;
    }
    else
    {
        ret = false;
    }
    
    return ret;
}
 
function checkWPAPskKey()
{
	var value = getValue('wlWpaPsk');
	if (value == '')
    {
		self.parent.AlertInfo(PortalguideDes['pwifi018']);
        return false;
    }
	
	if (value.length < 8)
	{
		self.parent.AlertInfo(PortalguideDes['pwifi021']);
		return false;
	}
	
	if (isValidWPAPskKey(value) == false)
    {
		self.parent.AlertInfo(PortalguideDes['pwifi019']);
        return false;
    }
	
	parent.wifiWPAPskKey = value;
	parent.wlanDomain2g =  WlanList[index2g].domain; 
	parent.wlanDomain5g =  WlanList[index5g].domain; 
	return true;
} 

function CheckParameter()
{
	if (parent.curPageFlag != 'WIFIPWDPage')
	{
		return true;
	}
		
	if (false == checkSsid())
	{
		return false;
	}
		
	if (false == checkWPAPskKey())
	{
		return false;
	}
		
	return true;
}
	
function LoadFrame()
{
	parent.wifiSsid = WlanList[index2g].ssid;
	setText('wlSsid', parent.wifiSsid);
	
	showSsid5g();
	if (!isSupportBandsteering())
	{
		setDisplay("allRatioLegend", 0);
		setDisplay("ssid5g", 1);
	}
	else
	{
		setDisplay("allRatioLegend", 1);
		setDisplay("ssid5g", 0);
	}
	
	self.parent.curPageFlag = "WIFIPWDPage";
	self.parent.ControlPageShow();
	setCheck('wlpwdforWebEnbl', 1);
	setcurInterStatus();
	parent.adjustIframeHeight();
}
</script>
</head>
<body class='stepPortalTipWifi' style="background-color: #f2f2f2;" onLoad="LoadFrame();">
<div  class = "stepPortalContent container" id="container">
    <div class="row">
	<div class="col-sm-12">
		<div id='allRatioLegend' class="paddingleft3" style="font-size:1.5em"><span BindText="p0144"></span>
			<div id="enablebtn">
				<form id="enablebtn1" class="form-inline">
		            <span class="h5" BindText="p0145">&nbsp;&nbsp;</span>
					<div id="wifienablebtn"style="width:33px; display:inline" onclick="WifiEnableBtn();">
				        <img id="wifienablecir"  src="/images/checkon.jpg">
				    </div>							 
		        </form>
            </div>
        </div>
		
		<div class="form-group">
            <span class="paddingleft3 h4" style="font-size:1.5em;" BindText="p0146"></span>
			<input type="text" id="wlSsid" class="form-control" value="test" maxlength="32">
            <div id="ssid5g" style="display:none;" class="h4 paddingleft3"><span BindText="p0147"></span><span id="ssid5gSpan"></span></div>
			<script>
			$('#wlSsid').on('keyup',function(){
				showSsid5g();
			});	
            </script>  
        </div>
        <div class="form-group">
			<span class="paddingleft3 h4" style="font-size:1.5em;" BindText="p0148"></span>
			<div>
				
		<input type='password' autocomplete='off' id='wlWpaPsk' name='wlWpaPsk'  class="form-control" style="float:left" maxlength="32" onkeyup="pwdStrengthcheck(this)"/>
		<input type='text' autocomplete='off' id='wlWpaPsk1' name='wlWpaPsk1' class="form-control" style="float:left;display:none;" maxlength="32" onkeyup="pwdStrengthcheck(this)"/>

		<img id="showPwd" src="/images/img_show_pwd.jpg" onclick="ShowOrHideText()" />
			</div>
            <span style="text-align:center;" class="language-string" id="pwdvalue"></span> 
        </div>
                
		<div class="form-group paddingleft3">
            <div style="margin-top:9em;"><span class="h5" BindText="p0149"></span><br/> 
            <input type='checkbox' name='wlEnbl' id='wlpwdforWebEnbl' checked onclick="setcurInterStatus();"><span class="h5" BindText="p0150"></span></input></div>  
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
