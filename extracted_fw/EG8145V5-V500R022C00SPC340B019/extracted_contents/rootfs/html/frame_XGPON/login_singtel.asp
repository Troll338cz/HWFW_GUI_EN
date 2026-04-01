<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<title></title>
<link href="/Cuscss/<%HW_WEB_GetCusSource(login.css);%>"  media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
<link rel="shortcut icon" href="../images/singtel.ico" />
<link rel="Bookmark" href="../images/singtel.ico" />
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
<script id="langResource" language="JavaScript" src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function GetRandCnt() { return '<%HW_WEB_GetRandCnt();%>'; }
function MD5(str) { return hex_md5(str); }
var FailStat ='<%HW_WEB_GetLoginFailStat();%>';
var LoginTimes = '<%HW_WEB_GetLoginFailCount();%>';
var ModeCheckTimes = '<%HW_WEB_GetModPwdFailCnt();%>';
var Var_DefaultLang = '<%HW_WEB_GetCurrentLanguage();%>';
var Language = Var_DefaultLang;
var LockLeftTime = '<%HW_WEB_GetLeftLockTime();%>';
var errloginlockNum = '<%HW_WEB_GetTryLoginTimes();%>';
var locklefttimerhandle;
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var Var_LastLoginLang = '<%HW_WEB_GetLoginRequestLangue();%>';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
var langDescList = new Array();
langDescList["chinese"] = "简体中文"; //or just '中文'?
langDescList["english"] = "English";
langDescList["japanese"] = "日本語";
langDescList["arabic"] = "العربية";
langDescList["portuguese"] = "Português";
langDescList["spanish"] = "Español";

var languageSet = new Array();

if ((typeof languageList == 'string') && (languageList != ''))
	languageSet = languageList.split("|");

if(Var_LastLoginLang == '')
{
	Language = Var_DefaultLang;
}
else
{
	Language = Var_LastLoginLang;
}

document.title = ProductName;

function genLanguageList()
{
	if (languageList == '')
		return false;

	var ChangeLanguage = '';

	if (languageSet.length > 1)
	{
		for (var lang in languageSet)
		{
			ChangeLanguage += '<td width="47%" nowrap><a id="' 
						   +  languageSet[lang] + '" href="#" name="' 
						   +  languageSet[lang] + '" onClick="onChangeLanguage(this.id);" class="changelanguage">[' 
						   +  langDescList[languageSet[lang]] + ']</a></td>';
		}
		document.getElementById('chooselagButton').innerHTML = ChangeLanguage;
		document.getElementById('chooselag').style.display = "block";
	}
}

function GetLoginDes(DesId)
{
	return framedesinfo[DesId];
}

function showlefttime()
{
	if (LockLeftTime <= 0)
	{
		window.location="/login_singtel.asp";
		return;
	}

	var html = GetLoginDes("frame011") +  LockLeftTime + GetLoginDes(LockLeftTime == 1 ? "frame012a" : "frame012");
	SetDivValue("DivErrPromt", html);

	LockLeftTime = LockLeftTime - 1;
}

function setErrorStatus()
{
	clearInterval(locklefttimerhandle);
	if (((LoginTimes != null) && (LoginTimes != '') && (LoginTimes > 0))
		||( "1" == FailStat) || (ModeCheckTimes >= errloginlockNum) )
	{
		document.getElementById('DivErrPage').style.display = 'block';
	}

	if('1' == FailStat)
	{
		if(ModeCheckTimes >= errloginlockNum)
		{
			SetDivValue("DivErrPromt", GetLoginDes("frame013a"));
		}
		else
		{
			SetDivValue("DivErrPromt", GetLoginDes("frame013"));
		}
		
		setDisable('txt_Username', 1);
		setDisable('txt_Password', 1);
		setDisable('loginbutton',  1);
	}
	else if(((LoginTimes >= errloginlockNum) || (ModeCheckTimes >= errloginlockNum)) && parseInt(LockLeftTime) > 0)
	{
		var desc = "frame012";
		if (parseInt(LockLeftTime) == 1)
			desc = "frame012a";

		var html = GetLoginDes("frame011") +  LockLeftTime + GetLoginDes(desc);
		SetDivValue("DivErrPromt", html);
		setDisable('txt_Username', 1);
		setDisable('txt_Password', 1);
		setDisable('loginbutton',  1);
		locklefttimerhandle = setInterval('showlefttime()', 1000);
	}
	else if (LoginTimes > 0 && LoginTimes < errloginlockNum)
	{
		SetDivValue("DivErrPromt",  GetLoginDes("frame014"));
	}
	else
	{
		document.getElementById('DivErrPage').style.display = 'none';
	}
}

function IsIEBrower(num) {
    var ua = navigator.userAgent.toLowerCase();
    var isIE = ua.indexOf("msie")>-1;
    var safariVersion;
    if(isIE){
        safariVersion =  ua.match(/msie ([\d.]+)/)[1];
        var sa = parseInt(safariVersion);
        if(safariVersion <= num ){
           alert("Your browser version is outdated (IE 6, IE 7, and IE 8 are not supported). You must upgrade your browser to IE 9 or later. ");
        }
    }
}

function LoadFrame()
{
	document.getElementById('txt_Username').focus();
	clearInterval(locklefttimerhandle);

	onChangeLanguage();

	init();
}

function SetCusLanguageInfo(language, activflag)
{
	var node = document.getElementById(language);

	if ((null == node) || (undefined == node))
		return;

	var color = (activflag ? "#9b0000" : "#FFFFFF");
	node.style.color = color;
}

function init() {
	if (document.addEventListener) {
		document.addEventListener("keypress", onHandleKeyDown, false);
	} else {
		document.onkeypress = onHandleKeyDown;
	}
}

function onHandleKeyDown(event) {
	var e = event || window.event;
	var code = e.charCode || e.keyCode;

	if (code == 13) {
		LoginSubmit("loginbutton");
	}
}

function LoginSubmit(val)
{
	var Username = document.getElementById('txt_Username');
	var Password = document.getElementById('txt_Password');
	var appName = navigator.appName;
	var version = navigator.appVersion;

	if (appName == "Microsoft Internet Explorer")
	{
		var versionNumber = version.split(" ")[3];
		if (parseInt(versionNumber.split(";")[0]) < 6)
		{
			alert(GetLoginDes('frame006'));
			return false;
		}
	}

	if (Username.value == "") {
		alert(GetLoginDes("frame007"));
		Username.focus();
		return false;
	}

	if (Password.value == "") {
		alert(GetLoginDes("frame009"));
		Password.focus();
		return false;
	}

	var cnt = GetRandCnt();
	var Form = new webSubmitForm();
	var cookie2 = "Cookie=body:" + "Language:" + Language + ":" + "id=-1;path=/";
	Form.addParameter('UserName', Username.value);
	Form.addParameter('PassWord', base64encode(Password.value));
	document.cookie = cookie2;
	Username.disabled = true;
	Password.disabled = true;
	Form.addParameter('x.X_HW_Token', cnt);
	Form.setAction('/login.cgi');
	Form.submit();
	return true;
}

function Refresh()
{
	window.location.href="/login_singtel.asp";
}

function onChangeLanguage(paralanguage)
{
	if (paralanguage != null)
	{
		if (Language == paralanguage) //same language, do nothing
			return;

		SetCusLanguageInfo(Language, false); //deactivate old language

		Language = paralanguage;
	}
	var langSrc = "/frameaspdes/" + Language + "/ssmpdes.js";
	loadLanguage("langResource", langSrc, onLanguageChanged);
}

function onLanguageChanged()
{
	ParseBindTextByTagName(framedesinfo, "span",  1);
	ParseBindTextByTagName(framedesinfo, "input", 2);

	SetCusLanguageInfo(Language, true);//activate new language

	setErrorStatus();
}

function loadLanguage(id, url, callback)
{
	var docHead = document.getElementsByTagName('head')[0];
	var langScript = document.getElementById(id);
	if (langScript != null) {
		docHead.removeChild(langScript);
	}

	try
	{
		langScript = document.createElement('script');
		langScript.setAttribute('type', 'text/javascript');
		langScript.setAttribute('src',  url);
		langScript.setAttribute('id',   id);
		if (callback != null) 
		{
			langScript.onload = langScript.onreadystatechange = function() 
			{
				if (langScript.ready) 
				{
					return false;
				}
				if (!langScript.readyState || langScript.readyState == "loaded" || langScript.readyState == 'complete') 
				{
					langScript.ready = true;
					callback();
				}
			};
		}
		docHead.appendChild(langScript);
	}
	catch(e)
	{}
}

setInterval("Refresh()", 6 * 60 * 1000);

</script>
</head>
<body onLoad="LoadFrame();">
	<div id="main_wrapper">
		<div id="loginarea">
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="brandlog_singtel" style="display:none;"></div>');				
			}
			else
			{
				document.write('<div id="brandlog" style="display:none;"></div>');
			}
			</script>		    
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="ProductName" style="text-align:right; height:41px; line-height:63px; margin-left:630px;">' + ProductName + '</div>');				
			}
			else
			{
				document.write('<div id="ProductName">' + ProductName + '</div>');
			}
			</script>
			<script>
			if(true == mngttype)
			{
				document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004SONET"></span></div>');
			}
			else if(true == logo_singtel)
			{
				document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004SINGTEL"></span></div>');
			}
			else
			{
				document.write('<div id="welcomtext"><span class="welcometitle" id ="spanwelcomtext" BindText="frame004"></span></div>');
			}
			</script>
			<div id="logininfo">
				<div id="chooselag" class="changelanguageline" style="display:none;">
					<div class="changelanguageleft"></div>
					<div id="chooselagButton" class="changelanguageright"></div>
				</div>

				<div id="loginuser" class="contentItemlogin">
					<div class="labelBoxlogin"><span id="account" BindText="frame001"></span></div>
					<div class="contenboxlogin"><input type="text" id="txt_Username" name="txt_Username" class="logininputcss" /></div>
				</div>

				<div id="loginpwd" class="contentItemlogin">
					<div class="labelBoxlogin"><span id="Password" BindText="frame002"></span></div>
					<div class="contenboxlogin"><input type="password" id="txt_Password" name="txt_Password" class="logininputcss" autocomplete="off" /></div>
				</div>

				<div id="loginbuttondiv" class="contentItemlogin">
					<div class="labelBoxlogin"></div>
					<div class="contenboxlogin"><input type="button"  class="whitebuttonBlueBgcss buttonwidth_237px" id="loginbutton" onClick="LoginSubmit(this.id);" value="" BindText="frame003" /></div>
				</div>
				<div id="DivErrPage" class="contentItemlogin">
					<div class="labelBoxlogin"></div>
					<div class="contenboxlogin"><div id="DivErrIcon"></div><div id="DivErrPromt"></div></div>
				</div>
			</div>
		</div>
		<div id="greenline"></div>
		<div id="copyright">
		<div id="copyrightspace"></div>
		<div id="copyrightlog" style="display:none;"></div>
		<script>
			document.write('<div id="copyrighttext"><span id="footer" BindText="frame015a"></span></div>');
		</script>
	</div>

	</div>
	<script>
		ParseBindTextByTagName(framedesinfo, "span",  1);
		ParseBindTextByTagName(framedesinfo, "input", 2);
		genLanguageList();
		if(true != mngttype)
		{
			if(true == logo_singtel)
			{
			    document.getElementById('brandlog_singtel').style.display = 'block';
			}
			else
			{
			    document.getElementById('brandlog').style.display = 'block';
			}						
			document.getElementById('copyrightlog').style.display = 'block';
		}
	</script>
</body>
</html>
