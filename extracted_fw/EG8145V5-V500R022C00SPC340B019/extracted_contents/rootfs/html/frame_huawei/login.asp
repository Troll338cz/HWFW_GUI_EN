<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<title></title>
<link href="Cuscss/<%HW_WEB_GetCusSource(login.css);%>"  media="all" rel="stylesheet" />
<style type="text/css">
#first{
	background-color:white;
	height:25px;
	text-align: center;
	color: red;
	position:absolute;
	width: 380px;
	top: 312px;
}


#pwd_modify{
	border:1px solid #CCCCCC;
	width:650px;
	margin-left:150px;
	margin-top:140px;
	position:absolute;
	z-index:10;
	height: 600px;
	background:#FFFFFF;
	display:none;
}

#base_mask {
	width:100%;
	height:100%;
	position:absolute;
	left:0px;
	right:0px;
	z-index:2;	
	filter: alpha(opacity=60);
	-moz-opacity: 0.6;
	-khtml-opacity: 0.6;
	opacity: 0.8;
	background-color:#eeeeee;
	display:none;
}


</style>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function MD5(str) { return hex_md5(str); }
function dealDataWithFun(str) {
  if (typeof str === 'string' && str.indexOf('function') === 0) {
    return Function('"use strict";return (' + str + ')')()();
  }
  return str;
}

function dealDataWithStr(str, repStr) {
  var funStr = '';
  if(repStr) {
    var newRepStr = 'return ' +  repStr;
    funStr = str.replace(repStr, newRepStr);
  } else {
    funStr = 'return ' + str + ';';
  }
  str = 'function() {' + funStr + '}';
  return dealDataWithFun(str);
}
var APPVersion = '<%HW_WEB_GetAppVersion();%>';
var FailStat ='<%HW_WEB_GetLoginFailStat();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var LoginTimes = '<%HW_WEB_GetLoginFailCount();%>';
var ModeCheckTimes = '<%HW_WEB_GetModPwdFailCnt();%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var Var_DefaultLang = '<%HW_WEB_GetCurrentLanguage();%>';
var Var_LastLoginLang = '<%HW_WEB_GetLoginRequestLangue();%>';
var LockLeftTime = '<%HW_WEB_GetLeftLockTime();%>';
var errloginlockNum = '<%HW_WEB_GetTryLoginTimes();%>';
var errVerificationCode = '<%HW_WEB_GetCheckCodeResult();%>';
var Language = '';
var locklefttimerhandle;
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>'; 
var SonetSGP100BFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_SONETSGP100B);%>';
var IsPTVDF = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>';
var IsTURKSATEBG = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TURKSATEBG);%>';
var RegPageFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_OVERSEA_REGIST_PAGE);%>";
var Ssid1 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.SSID);FT=HW_FT_FEATURE_PLDT%>';
var Ssid2 = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.SSID);FT=HW_FT_FEATURE_PLDT%>';
var IsSingleWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SINGLE_WLAN);FT=HW_FT_FEATURE_PLDT%>';
var IsDoubleWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);FT=HW_FT_FEATURE_PLDT%>';
var trimssidFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_NOT_TRIM_SSID);FT=HW_FT_FEATURE_PLDT%>';
var WlanInfoList = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|SSID|X_HW_ServiceEnable|Enable,stWlanInfo);FT=HW_FT_FEATURE_PLDT%>';
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
if(WlanInfoList !== '') {
   var WlanInfo = dealDataWithStr(WlanInfoList);
} else {
  var WlanInfo = new Array();
}
var SsidPerBand = '<%HW_WEB_GetSPEC(AMP_SPEC_SSID_NUM_MAX_BAND.UINT32);%>';

var ssidEnd2G = SsidPerBand - 1;
var ssidStart5G = SsidPerBand;

var Userlevel = 0;
var preflag = 0;

if ((CfgMode.toUpperCase() == 'PLDT') || (CfgMode.toUpperCase() == 'PLDT2')) {
    preflag = 1;
}

function stWlanInfo(domain,name,ssid,X_HW_ServiceEnable,enable) {
    this.domain = domain;
    this.name = name;
    this.ssid = ssid;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.enable = enable;
}

if(Var_LastLoginLang == '')
{
	Language = Var_DefaultLang;
}
else
{
	Language = Var_LastLoginLang;
}

if ('ORO' == CfgMode.toUpperCase())
{
	ProductName = "Internet Box 1000";
}
document.title = ProductName;

function getValue(sId)
{
	var item = getElement(sId);
	if (item == null) {
		debug(sId + " is not existed" );
		return -1;
	}
	return item.value;
}

function JumpToReg()
{
	window.location="/register.asp";
}

function showlefttime()
{
	if(LockLeftTime <= 0)
	{
		window.location="/login.asp";
		return;
	}

	if(LockLeftTime == 1)
	{
		if(Language == 'portuguese')
		{
			if(1 == IsPTVDF)
			{
				var errhtml = 'Demasiadas tentativas, volte a tentar daqui a ' +  LockLeftTime + ' segundo';
			}
			else
			{
				var errhtml = 'Demasiadas tentativas, tente ' +  LockLeftTime + ' segundos mais tarde';
			}
		}
		else if(Language == 'japanese')
		{
			var errhtml = '再試行回数が多すぎます。' +  LockLeftTime + '秒後に再試行してください。';
		}
		else if(Language == 'spanish')
		{
			var errhtml = 'Ha intentado muchas veces. Vuelva a intentarlo dentro de ' +  LockLeftTime + ' segundo/s.';
		}
		else if(Language == 'russian')
		{
			var errhtml = 'Слишком много попыток. Попробуйте снова через ' +  LockLeftTime + ' с.';
		}
		else if(Language == "chinese")
		{
			var errhtml = '您登录失败的次数已超出限制，请' +  LockLeftTime + '秒后重试！';
		}
		else if(Language == "turkish")
		{
			var errhtml = 'Çok fazla sayıda deneme, lütfen yeniden deneyin ' +  LockLeftTime + ' saniye.';
		}
		else
		{
			if(1 == IsPTVDF)
			{
				var errhtml = 'Too many retries, please retry in ' +  LockLeftTime + ' second.';
			}
			else
			{
				var errhtml = 'Too many retrials, please retry ' +  LockLeftTime + ' second later.';
			}
		}
	}
	else
	{
		if(Language == 'portuguese')
		{
			if(1 == IsPTVDF)
			{
				var errhtml = 'Demasiadas tentativas, volte a tentar daqui a ' +  LockLeftTime + ' segundos';
			}
			else
			{
				var errhtml = 'Demasiadas tentativas, tente ' +  LockLeftTime + ' segundos mais tarde.';
			}
		}
		else if(Language == 'japanese')
		{
			var errhtml = '再試行回数が多すぎます。' +  LockLeftTime + '秒後に再試行してください。';
		}
		else if(Language == 'spanish')
		{
			var errhtml = 'Ha intentado muchas veces. Vuelva a intentarlo dentro de ' +  LockLeftTime + ' segundos.';
		}
		else if(Language == 'russian')
		{
			var errhtml = 'Слишком много попыток. Попробуйте снова через ' +  LockLeftTime + ' с.';
		}
		else if(Language == "chinese")
		{
			var errhtml = '您登录失败的次数已超出限制，请' +  LockLeftTime + '秒后重试！';
		}
		else if(Language == "turkish")
		{
			var errhtml = 'Çok fazla sayıda deneme, lütfen yeniden deneyin ' +  LockLeftTime + ' saniye sonra.';
		}
		else
		{
			if(1 == IsPTVDF)
			{
				var errhtml = 'Too many retries, please retry in ' +  LockLeftTime + ' seconds.';
			}
			else
			{
				var errhtml = 'Too many retrials, please retry ' +  LockLeftTime + ' seconds later.';
			}
		}
	}

	SetDivValue("DivErrPage", errhtml);
	LockLeftTime = LockLeftTime - 1;
}

function setErrorStatus()
{
	clearInterval(locklefttimerhandle);
	if('1' == FailStat)
	{

		if(Language == 'portuguese')
		{
			var errhtml = "Demasiadas tentativas.";
		}
		else if(Language == 'japanese')
		{
			var errhtml = "再試行回数が多すぎます。";
		}
		else if(Language == 'spanish')
		{
			var errhtml = "Ha intentado muchas veces.";
		}
		else if(Language == 'russian')
		{
			var errhtml = 'Слишком много попыток.';
		}
		else if(Language == "chinese")
		{
			var errhtml = '您尝试的次数已超出限制。';
		}
        else if(Language == "turkish")
		{
			var errhtml = 'Çok fazla sayıda deneme.';
		}
		else
		{
			var errhtml = 'Too many retrials.';
		}
		SetDivValue("DivErrPage", errhtml);
		setDisable('txt_Username',1);
		setDisable('txt_Password',1);
		if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRUE' ==CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
		{
			setDisable('VerificationCode',1);
			setDisable('tripletbtn',1);
		}
		setDisable('button',1);
	}
	else if('2' == FailStat)
    {
        var errhtml = 'You IP address cannot be used for a login.';
		SetDivValue("DivErrPage", errhtml);
    }
	else if(((LoginTimes >= errloginlockNum) || (ModeCheckTimes >= errloginlockNum)) && parseInt(LockLeftTime) > 0)
	{
		if(Language == 'portuguese')
		{
			if(1 == IsPTVDF)
			{
				var errhtml = 'Demasiadas tentativas, volte a tentar daqui a ' +  LockLeftTime + ' segundos';
			}
			else
			{
				var errhtml = 'Demasiadas tentativas, tente ' +  LockLeftTime + ' segundos mais tarde.';
			}
		}
		else if(Language == 'japanese')
		{
			var errhtml = '再試行回数が多すぎます。' +  LockLeftTime + ' 秒後に再試行してください。';
		}
		else if(Language == 'spanish')
		{
			var errhtml = 'Ha intentado muchas veces. Vuelva a intentarlo dentro de ' +  LockLeftTime + ' segundos.';
		}
		else if(Language == 'russian')
		{
			var errhtml = 'Слишком много попыток. Попробуйте снова через ' +  LockLeftTime + ' с.';
		}
		else if(Language == "chinese")
		{
			var errhtml = '您登录失败的次数已超出限制，请' +  LockLeftTime + '秒后重试！';
		}
        else if(Language == "turkish")
		{
			var errhtml = 'Çok fazla sayıda deneme, lütfen yeniden deneyin ' +  LockLeftTime + ' saniye sonra.';
		}
		else
		{
			if(1 == IsPTVDF)
			{
				var errhtml = 'Too many retries, please retry in ' +  LockLeftTime + ' seconds.';
			}
			else
			{
				var errhtml = 'Too many retrials, please retry ' +  LockLeftTime + ' seconds later.';
			}
		}

		SetDivValue("DivErrPage", errhtml);
		setDisable('txt_Username',1);
		setDisable('txt_Password',1);
		if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRUE' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
		{
			setDisable('VerificationCode',1);
			setDisable('tripletbtn',1);
		}
		setDisable('button',1);
		locklefttimerhandle = setInterval('showlefttime()', 1000);
	}
	else if( 1== errVerificationCode)
	{
		SetDivValue("DivErrPage", "Incorrect validate code.");
	}
	else if( 2== errVerificationCode)
	{
		SetDivValue("DivErrPage", "Login failure.");
	}
	else if((LoginTimes > 0) && (LoginTimes < errloginlockNum))
	{
		if(Language == 'portuguese')
		{
			var errhtml = "Nome de conta ou palavra-passe inválidos. Tente novamente.";
		}
		else if(Language == 'japanese')
		{
			var errhtml = "アカウントとパスワードの組み合わせが不正確です。 もう一度やり直してください。";
		}
		else if(Language == 'spanish')
		{
			var errhtml = "La combinación de la usuario/contraseña es incorrecta. Favor de volver a intentarlo.";
		}
		else if(Language == 'russian')
		{
			var errhtml = 'Неверное имя аккаунта или пароль. Повторите попытку.';
		}
		else if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
		{
			var errhtml = 'Login failure.';
		}
		else if(Language == "chinese")
		{
			var errhtml = '用户名或密码错误，请重新登录。';
		}
        else if(Language == "turkish")
		{
			var errhtml = 'Hatalı Kullanıcı Adı/şifre kombinasyonu. Lütfen tekrar deneyin.';
		}
		else
		{
			var errhtml = 'Incorrect account/password combination. Please try again.';
		}

		SetDivValue("DivErrPage", errhtml);
	}
	else
	{
		document.getElementById('loginfail').style.display = 'none';
	}
}

function BandSteeringEnable()
{
    var enable = document.getElementById('steering_box').checked
    if (enable) {
        document.getElementById('pwd_modify').style.height = '380px';
        document.getElementById('update').style.top = '40px';
        document.getElementById('ssid1_name_lebel').innerHTML = 'WiFi SSID:';
        document.getElementById('modify_pwd_ssid2').style.display = 'none';
    } else {
        document.getElementById('modify_pwd_ssid2').style.display = 'block';
        document.getElementById('pwd_modify').style.height = '450px';
        document.getElementById('update').style.top = '120px';
        document.getElementById('ssid1_name_lebel').innerHTML = '2.4G WiFi SSID:';
        getElById('ssid2_name').value = getValue('ssid1_name') + "_5G";
    }
}

function BandSteeringState()
{
    document.getElementById('pwd_modify').style.height = '380px';
    document.getElementById('update').style.top = '40px';
    document.getElementById('ssid1_name_lebel').innerHTML = 'WiFi SSID:';
    document.getElementById('modify_pwd_ssid2').style.display = 'none';
    document.getElementById('band_steering_box').style.display = 'none';
    getElById('ssid1_name').value = Ssid1;
    getElById('ssid2_name').value = Ssid2;
    getElementById("steering_box").checked = true;
}

function DisplayWifiPldt2()
{
    document.getElementById('modify_pwd_ssid1').style.display = 'block';
    document.getElementById('modify_pwd_ssid2').style.display = 'block';
    document.getElementById('modify_pwd_label').style.display = 'block';
    BandSteeringState();
    return;
}

function DisplayWifiPldt() {
    document.getElementById('base_mask').style.display = 'block';
    document.getElementById('pwd_modify').style.display = 'block';
    document.getElementById('old_password').focus();
    if (IsSingleWifi == 1) {
        document.getElementById('modify_pwd_ssid1').style.display = 'block';
        document.getElementById('modify_pwd_ssid2').style.display = 'none';
        document.getElementById('modify_pwd_label').style.display = 'block';
        document.getElementById('pwd_modify').style.height = '295px';
        document.getElementById('update').style.top = '90px';
        getElById('ssid1_name').value = Ssid1;
        document.getElementById('ssid1_name_lebel').innerHTML = 'WiFi SSID:';   
    } else if (IsDoubleWifi == 1) {
        DisplayWifiPldt2();
    } else {
        document.getElementById('modify_pwd_ssid1').style.display = 'none';
        document.getElementById('modify_pwd_ssid2').style.display = 'none';
        document.getElementById('modify_pwd_label').style.display = 'none';
        document.getElementById('pwd_modify').style.height = '200px';
        document.getElementById('update').style.top = '15px';
    }
}

function SubmitForm() {
	var Username = document.getElementById('txt_Username');
	var Password = document.getElementById('txt_Password');
	var appName = navigator.appName;
	var version = navigator.appVersion;
    var CheckResult = 0;

	if(Language == "portuguese")
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("Versões IE inferiores a 6.0 não são compatíveis.");
				return false;
			}
		}

		if (Username.value == "") {
			alert("Conta não pode ficar em branco.");
			Username.focus();
			return false;
		}

		if (Password.value == "") {
			alert("Palavra-passe não pode ficar em branco.");
			Password.focus();
			return false;
		}

	}
	else if(Language == "japanese")
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("6.0以前のIEバージョンには対応していません。");
				return false;
			}
		}

		if (Username.value == "") {
			alert("アカウントは必須項目です。");
			Username.focus();
			return false;
		}

		if (Password.value == "") {
			alert("パスワードは必須項目です。");
			Password.focus();
			return false;
		}

	}
	else if(Language == "spanish")
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("No se puede soportar la versión de IE inferior a la 6.0.");
				return false;
			}
		}

		if (Username.value == "") {
			alert("La usuario es un campo obligatorio.");
			Username.focus();
			return false;
		}

		if (Password.value == "")
		{
			alert("La contraseña es un campo requerido.");
			Password.focus();
			return false;
		}
	}
	else if(Language == "russian")
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("Версии браузера IE меньше 6.0 не поддерживаются.");
				return false;
			}
		}
		
		if (Username.value == "") {
			alert("Введите имя аккаунта.");
			Username.focus();
        	return false;
		}
		
	
		if (Password.value == "") {
			alert("Введите пароль.");
			Password.focus();
        	return false;
		}
	}
	else if(Language == "chinese")
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("不支持IE6.0以下版本。");
				return false;
			}
		}
		if (Username.value == "") {
			alert("用户名不能为空。");
			Username.focus();
			return false;
		}
		if (Password.value == "") {
			alert("密码不能为空。");
			Password.focus();
			return false;
		}
	}
    else if(Language == "turkish")
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("6.0'dan düşük IE sürümünü destekleyemiyoruz.");
				return false;
			}
		}

		if (Username.value == "") {
			if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase())
			{
				alert("Kullanıcı Adı gerekli bir alandır.");
			}
			else
			{
				alert("Kullanıcı Adı gerekli bir alandır.");
			}
			Username.focus();
			return false;
		}

		if (Password.value == "") {
			alert("Şifre gerekli bir alandır.");
			Password.focus();
			return false;
		}
	}
	else
	{
		if (appName == "Microsoft Internet Explorer")
		{
			var versionNumber = version.split(" ")[3];
			if (parseInt(versionNumber.split(";")[0]) < 6)
			{
				alert("We cannot support the IE version which is lower than 6.0.");
				return false;
			}
		}

		if (Username.value == "") {
			if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
			{
				alert("User Name is a required field.");
			}
			else
			{
				alert("Account is a required field.");
			}
			Username.focus();
			return false;
		}

		if (Password.value == "") {
			alert("Password is a required field.");
			Password.focus();
			return false;
		}

	}

    if (preflag == 1) {
        CheckResult = CheckPassword(Password.value);
        Userlevel = CheckResult;
        if ((CheckResult == 1) || (CheckResult == 2)) {
            DisplayWifiPldt();
            return false;
        }
    }

	var cnt;

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/asp/GetRandCount.asp',
		success : function(data) {
			cnt = data;
		}
		});

	var Form = new webSubmitForm();
	if('DT' == CfgMode.toUpperCase())
	{
		var cookie2 = "Cookie=" + "rid=" + RndSecurityFormat("" + cnt) + RndSecurityFormat(Username.value + cnt ) + RndSecurityFormat(RndSecurityFormat(MD5(Password.value)) + cnt) + ":" + "Language:" + Language + ":" +"id=-1;path=/";
	}
	else
	{
		var cookie2 = "Cookie=body:" + "Language:" + Language + ":" + "id=-1;path=/";
		Form.addParameter('UserName', Username.value);
		Form.addParameter('PassWord', base64encode(Password.value));
		Form.addParameter('Language', Language);
	}
	
	document.cookie = cookie2;
	Username.disabled = true;
	Password.disabled = true;

	if('TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase()|| 'TRUE' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
	{
		Form.addParameter('CheckCode', getValue('VerificationCode'));
		Form.setAction('login.cgi?' +'&CheckCodeErrFile=login.asp');
	}
	else
	{
		Form.setAction('/login.cgi');
	}
	Form.addParameter('x.X_HW_Token', cnt);
	Form.submit();
	return true;
}

function Lanuageswitch()
{
	var promptlanguage = "";
	switch(Language)
	{
		case "portuguese":
			promptlanguage = "A versão do seu navegador está desatualizada (IE 6, IE 7 e IE 8 são incompatíveis). É preciso atualizar o navegador para a versão IE 9 ou superior. ";
			break;
		case "japanese":
			promptlanguage = "ブラウザのバージョンが古いです(IE 6、IE 7、IE 8はサポートされていません)。ブラウザをIE 9以上に更新する必要があります。";
			break;
		case "spanish":
			promptlanguage = "La versión de su navegador está desactualizada (no se soportan IE 6, IE 7 ni IE 8). Debe actualizar el navegador con IE 9 o una versión posterior. ";
			break;
		case "russian":
			promptlanguage = "Версия Вашего браузера устарела (браузеры Internet Explorer 6, Internet Explorer 7 и Internet Explorer 8 не поддерживаются). Обновите браузер до версии Internet Explorer 9 или более поздней версии.";
			break;
		default:
			promptlanguage = "Your browser version is outdated (IE 6, IE 7, and IE 8 are not supported). You must upgrade your browser to IE 9 or later. ";
			break;		
	}
	return promptlanguage;
}

function IsIEBrower(num) {
    var ua = navigator.userAgent.toLowerCase();
    var isIE = ua.indexOf("msie")>-1;
    var safariVersion;
    if(isIE){
        safariVersion =  ua.match(/msie ([\d.]+)/)[1];
        var sa = parseInt(safariVersion);
        if(safariVersion <= num ){
           alert(Lanuageswitch());
        }
    }
}
function LoadFrame() 
{

	document.getElementById('txt_Username').focus();
	clearInterval(locklefttimerhandle);

	var UserLeveladmin = '<%HW_WEB_CheckUserInfo();%>';

	if(Language == "portuguese")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Conta';
		document.getElementById('Password').innerHTML = 'Palavra-passe';
		document.getElementById('button').innerHTML = 'Iniciar sessão';
		document.getElementById('footer').innerHTML = 'Copyright © 2024 Huawei Technologies Co., Ltd. Todos os direitos reservados.';
	}
	else if(Language == "japanese")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'アカウント';
		document.getElementById('Password').innerHTML = 'パスワード';
		document.getElementById('button').innerHTML = 'ログイン';
		document.getElementById('footer').innerHTML = 'All rights reserved.';
        
        document.getElementById('Copyrightfooter').style.margin = '0 0 0 152px';
	}
	else if(Language == "spanish")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Usuario';
		document.getElementById('Password').innerHTML = 'Contraseña';
		document.getElementById('button').innerHTML = 'Iniciar sesión';
		document.getElementById('footer').innerHTML = 'Copyright © 2024 Tecnologias Huawei Co., Ltd. Todos los derechos reservados.';
	}
	else if(Language == "russian")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
        document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Аккаунт';
		document.getElementById('Password').innerHTML = 'Пароль';
		document.getElementById('button').innerHTML = 'Вход';
		document.getElementById('footer').innerHTML = 'Copyright © 2024 Huawei Technologies Co., Ltd. Все права защищены.';
    }	
	else if(Language == "chinese")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = '用户名';
		document.getElementById('Password').innerHTML = '密  码';
		document.getElementById('button').innerHTML = '登录';
		document.getElementById('footer').innerHTML = '版权所有 © 2024 华为技术有限公司。保留一切权利。';
		document.getElementById('footer').style.position = 'relative';
		document.getElementById('footer').style.left = '30px';
	}	
    else if (Language == "turkish") 
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Kullanıcı Adı';
		document.getElementById('Password').innerHTML = 'Şifre';
		document.getElementById('button').innerHTML = 'Giriş';
		document.getElementById('footer').innerHTML = 'Telif Hakkı © Huawei Technologies Co., Ltd. 2024. Tüm hakları saklıdır.';
		document.getElementById('footer').style.position = 'relative';
		document.getElementById('footer').style.left = '30px';
	}
	else
	{
		document.getElementById('Specical_language').style.color = '#434343';
		document.getElementById('English').style.color = '#9b0000';
		if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
		{
			document.getElementById('account').innerHTML = 'User Name';
		}
		else
		{
			document.getElementById('account').innerHTML = 'Account';
		}
		document.getElementById('Password').innerHTML = 'Password';
		document.getElementById('button').innerHTML = 'Login';
		document.getElementById('buttonReg').innerHTML = 'Register';

        if (SonetFlag == 1) {
            document.getElementById('footer').innerHTML = 'All rights reserved.';
            document.getElementById('Copyrightfooter').style.margin = '0 0 0 152px';
        } else {
            document.getElementById('footer').innerHTML = 'Copyright © 2024 Huawei Technologies Co., Ltd. All rights reserved';
            document.getElementById('Copyrightfooter').style.margin = '0 0 0 20px';
        }
    }

		
	if ((LoginTimes != null) && (LoginTimes != '') && (LoginTimes > 0)) {
		document.getElementById('loginfail').style.display = '';
		setErrorStatus();
	}
	if( "1" == FailStat || (ModeCheckTimes >= errloginlockNum))
	{
		document.getElementById('loginfail').style.display = '';
		setErrorStatus();
	}
	init();
	
	if('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
	{
		var tiphtml = 'Tên truy nhập và mật khẩu của quý khách được in ở mặt đáy thiết bị ONT';
		SetDivValue("DivTipPage", tiphtml);
		document.getElementById('tipText').style.display = '';
	}
	
	if((UserLeveladmin == '0'))
	{
		if(Language == "portuguese")
		{
			alert("O administrador não tem autorização para abrir esta página de Internet.");
			return false;
		}
		else if(Language == "japanese")
		{
			alert("管理者はこのウェブページの閲覧を許可されていません。");
			return false;
		}
		else if (Language == "spanish")
		{
			alert("El administrador no puede abrir esta página.");
			return false;
		}
		else if (Language == "russian")
		{
			alert("У текущего пользователя нет права входа.");
			return false;
		}
		else if(Language == "chinese")
		{
			alert("当前用户不允许登录。");
			return false;
		}
        else if(Language == "turkish")
		{
			alert("Mevcut kullanıcının giriş yapma izni yok.");
			return false;
		}
		else
		{
			alert("The current user is not allowed to log in.");
			return false;
		}
	}
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
		SubmitForm();
	}
}
function onChangeLanguage(language) {
	Language = language;
	if(language == "portuguese")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Conta';
		document.getElementById('Password').innerHTML = 'Palavra-passe';
		document.getElementById('button').innerHTML = 'Iniciar sessão';
		document.getElementById('footer').innerHTML = 'Copyright © 2024 Huawei Technologies Co., Ltd. Todos os direitos reservados.';
	}
	else if(language == "japanese")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'アカウント';
		document.getElementById('Password').innerHTML = 'パスワード';
		document.getElementById('button').innerHTML = 'ログイン';
		document.getElementById('footer').innerHTML = 'All rights reserved.';

        document.getElementById('Copyrightfooter').style.margin = '0 0 0 152px';
	}
	else if (language == "spanish")
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Usuario';
		document.getElementById('Password').innerHTML = 'Contraseña';
		document.getElementById('button').innerHTML = 'Iniciar sesión';
		document.getElementById('footer').innerHTML = 'Copyright © 2024 Tecnologias Huawei Co., Ltd. Todos los derechos reservados.';
    }
	else if (language == "russian") 
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
        document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Аккаунт';
		document.getElementById('Password').innerHTML = 'Пароль';
		document.getElementById('button').innerHTML = 'Вход';
		document.getElementById('footer').innerHTML = 'Copyright © 2024 Huawei Technologies Co., Ltd. Все права защищены.';
    }
	else if (language == "chinese") 
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = '用户名';
		document.getElementById('Password').innerHTML = '密  码';
		document.getElementById('button').innerHTML = '登录';
		document.getElementById('footer').innerHTML = '版权所有 © 2024 华为技术有限公司。保留一切权利。';
		document.getElementById('footer').style.position = 'relative';
		document.getElementById('footer').style.left = '30px';
	}
    else if (language == "turkish") 
	{
		document.getElementById('Specical_language').style.color = '#9b0000';
		document.getElementById('English').style.color = '#434343';
		document.getElementById('account').innerHTML = 'Kullanıcı Adı';
		document.getElementById('Password').innerHTML = 'Şifre';
		document.getElementById('button').innerHTML = 'Giriş';
		document.getElementById('footer').innerHTML = 'Telif Hakkı © Huawei Technologies Co., Ltd. 2024. Tüm hakları saklıdır.';
		document.getElementById('footer').style.position = 'relative';
		document.getElementById('footer').style.left = '30px';
	}
	else 
	{
		document.getElementById('Specical_language').style.color = '#434343';
		document.getElementById('English').style.color = '#9b0000';
		document.getElementById('account').innerHTML = 'Account';
		document.getElementById('Password').innerHTML = 'Password';
		document.getElementById('button').innerHTML = 'Login';
		document.getElementById('buttonReg').innerHTML = 'Register';

        if (SonetFlag == 1) {
            document.getElementById('footer').innerHTML = 'All rights reserved';
            document.getElementById('Copyrightfooter').style.margin = '0 0 0 152px';
        } else {
            document.getElementById('footer').innerHTML = 'Copyright © 2024 Huawei Technologies Co., Ltd. All rights reserved';
            document.getElementById('Copyrightfooter').style.margin = '0 0 0 20px';
        }
    }

	if (((LoginTimes != null) && (LoginTimes != '') && (LoginTimes > 0))
	   ||( "1" == FailStat) || (ModeCheckTimes >= errloginlockNum) )
	{
		document.getElementById('loginfail').style.display = '';
		setErrorStatus();
	}
}

function BthRefresh()
{
	document.getElementById("imgcode").src = 'getCheckCode.cgi?&rand=' + new Date().getTime();
}


function isValidAscii(val)
{
	for ( var i = 0 ; i < val.length ; i++ )
	{
		var ch = val.charAt(i);
		if ( ch <= ' ' || ch > '~' )
		{
			return false;
		}
	}
	return true;
}

function isLowercaseInString(str)
{
		var lower_reg = /^.*([a-z])+.*$/;
		var MyReg = new RegExp(lower_reg);
		if ( MyReg.test(str) )
		{
			return true;
		}
		return false;
}

function isUppercaseInString(str)
{
		var upper_reg = /^.*([A-Z])+.*$/;
		var MyReg = new RegExp(upper_reg);
		if ( MyReg.test(str) )
		{
			return true;
		}
		return false;
}

function isDigitInString(str)
{
	var digit_reg = /^.*([0-9])+.*$/;
	var MyReg = new RegExp(digit_reg);
	if ( MyReg.test(str) )
	{
		return true;
	}
	return false;
}

function isSpecialCharacterNoSpace(str)
{
	var specia_Reg =/^.*[`~!@#\$%\^&\*\(\)_\+\-=\[\]\{\}\'\;\,\./:\"\?><\\\|]{1,}.*$/;
	var MyReg = new RegExp(specia_Reg);
	if ( MyReg.test(str) )
	{
		return true;
	}
	return false;
}

function CompareString(srcstr,deststr)
{
	var reverestr=(srcstr.split("").reverse().join(""));
	if ( srcstr == deststr )
	{
		return false;
	}

	if (reverestr == deststr )
	{
		return false;
	}
	return true;
}

function CheckPwdIsComplex(str)
{
	var Username = document.getElementById('txt_Username');
	var i = 0;
	
    if (str.length < pwdLen)
	{
		return false;
	}

	if (!CompareString(str, Username.value)) {
        return false;
    }

	if ( isLowercaseInString(str) )
	{
		i++;
	}

	if ( isUppercaseInString(str) )
	{
		i++;
	}

	if ( isDigitInString(str) )
	{
		i++;
	}

	if ( isSpecialCharacterNoSpace(str) )
	{
		i++;
	}
	
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function CheckPwdIsComplexForPldt(str) {
    var Username = document.getElementById('txt_Username');
    var complexValue = 0;

    if (str.length < 8) {
        return false;
    }

    if (isLowercaseInString(str)) {
        complexValue++;
    }

    if (isUppercaseInString(str)) {
        complexValue++;
    }

    if (isDigitInString(str)) {
        complexValue++;
    }

    if (isSpecialCharacterNoSpace(str)) {
        complexValue++;
    }

    if (!CompareString(str, Username.value)) {
        return false;
    }

    if (complexValue < 3) {
        return false;
    }

    return true;
}

function IsValidPskKey_pldt(id)
{
    if ((IsSingleWifi != 1) && (IsDoubleWifi !=1 )) {
        return true;
    }
    var score = 0;
    var password1 = getElementById(id).value;

    if (password1.length < 8) {
        return false;
    } else if (password1.length >= 15) {
        return true;
    }

    if (isLowercaseInString(password1)) {
        score++;
    }

    if (isUppercaseInString(password1)) {
        score++;
    }

    if (isDigitInString(password1)) {
        score++;
    }

    if (isSpecialCharacterNoSpace(password1)) {
        score++;
    }

    if (score < 3) {
        return false;
    }

    return true;
}

function CheckPassword(PwdForCheck) {
	var Username = document.getElementById('txt_Username');
	var NormalPwdInfo = FormatUrlEncode(PwdForCheck);
	var CheckResult = 0;
	var url_check_pwd = 0;
	
	var ParaArrayList = "UserNameInfo=" + Username.value;
    ParaArrayList += "&NormalPwdInfo=" + NormalPwdInfo;
    url_check_pwd = '/asp/CheckPwdNotLogin.asp?&1=1';
	
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : url_check_pwd,
        data : ParaArrayList,
		success : function(data) {
		CheckResult=data;
		}
	});
	return CheckResult;
}

function isHexaDigit(digit) {
    var hexVals = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                            "A", "B", "C", "D", "E", "F", "a", "b", "c", "d", "e", "f");
    for (var i = 0; i < hexVals.length; i++) {
        if (digit == hexVals[i]) {
            return true;
        }
    }

   return false;
}

function isValidWPAPskKey(val)
{
    var ret = false;
    var len = val.length;
    var maxSize = 64;
    var minSize = 8;
    if (!isValidAscii(val))
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

function CheckPasswordSsid(id) {
    if (Userlevel == 2) {
        if (!preflag) {
            return true;
        }
    }

    if (!isValidWPAPskKey(getValue(id))) {
        return false;
    }

    return true;
}

function ltrim(str) { 
    if(trimssidFlag == 0) {
        return str.toString().replace(/(^\s*)/g,""); 
    } else {
        return str.toString();
    }
}


function CheckSsid(ssid)
{
    if (ssid == '') {
        alert('The SSID cannot be empty.');
        return false;
    }

    if (ssid.length > 32) {
        alert('The SSID ' + ssid + ' can contain a maximum of 32 characters.');
        return false;
    }

    if (!isValidAscii(ssid)) {
        alert('The SSID contains invalid characters.');
        return false;
    }

    return true;
}

function getWlanPortNumber(name) {
    if (name != '') {
        if(name.length > 4) {
            return parseInt(name.charAt(name.length - 2) + name.charAt(name.length - 1));    
        } else {
            return parseInt(name.charAt(name.length - 1)); 
        }
    }
}


function CheckWlanSsid(id) {
    var ssid = ltrim(getValue(id));
    if (!CheckSsid(ssid)) {
        return false;
    }

    var freq = (id == 'ssid1_name') ? '2G' : '5G';
    var index = (id == 'ssid1_name') ? 0 : ssidStart5G;

    for (var i = 0; i < WlanInfo.length - 1; i++) {
        if ((getWlanPortNumber(WlanInfo[i].name) > ssidEnd2G) && ((IsDoubleWifi == 1) && (freq == '2G'))) {
            continue;
        }
        
        if ((getWlanPortNumber(WlanInfo[i].name) <= ssidEnd2G) && ((IsDoubleWifi == 1) && (freq == '5G'))) {
            continue;
        }

        if ((getWlanPortNumber(WlanInfo[i].name) > ssidEnd2G) && ((IsDoubleWifi != 1))) {
            continue;
        }

        if (getWlanPortNumber(WlanInfo[i].name) != index) {
            if (WlanInfo[i].ssid == ssid) {
                alert('Duplicate SSID.');
                return false;
            }
        }
    }

    return true;
}

function CheckWiFiParameter() {
    if ((IsSingleWifi != 1) && (IsDoubleWifi != 1)) {
        return true;
    }

    if (!CheckWlanSsid('ssid1_name')) {
        return false;
    }

    if (!CheckPasswordSsid("ssid1_password")) {
        alert("The wifi password of " + getElById('ssid1_name').value + " must be between 8 and 63 characters or 64 hexadecimal characters.");
        return false;
    }

    if (preflag != 1) {
        if (IsDoubleWifi == 1) {
            if (!CheckPasswordSsid('ssid2_password')) {
                alert("The wifi password of "+ getElById('ssid2_name').value +" must be between 8 and 63 characters or 64 hexadecimal characters.");
                return false;
            }
        }

        if (IsDoubleWifi == 1) {
            if (!CheckWlanSsid('ssid2_name')) {
            return false;
            }
        }
    } else {
        if (!IsValidPskKey_pldt('ssid1_password')) {
            alert("The wifi password of "+ getElById('ssid1_name').value +" must be at least 8 characters long and must contain three the following: uppercase characters, lowercase characters, digits (0-9), special characters or length contains 15 characters.");
            return false;
        }

        var password1 = getElementById("ssid1_password").value
        var confirmPassword1 = getElementById("ssid1_confirm_password").value
        if (password1 != confirmPassword1) {
            alert("The confirm password of " + getElById('ssid1_name').value + " is different from the WiFi password.");
                return false;
            }
        var enable = document.getElementById('steering_box').checked
        if (!enable) {
            if (!CheckWlanSsid('ssid2_name')) {
                return false;
            }
            if (!CheckPasswordSsid('ssid2_password')) {
                alert("The wifi password of "+ getElById('ssid2_name').value +" must be between 8 and 63 characters or 64 hexadecimal characters.");
                return false;
            }

            if (!IsValidPskKey_pldt('ssid2_password')) {
                alert("The wifi password of "+ getElById('ssid2_name').value +" must be at least 8 characters long and must contain three the following: uppercase characters, lowercase characters, digits (0-9), special characters or length contains 15 characters.");
                return false;
            }

            var password2 = getElementById("ssid2_password").value
            var confirmPassword2 = getElementById("ssid2_confirm_password").value
            if (password2 != confirmPassword2) {
                alert("The confirm password of " + getElById('ssid2_name').value + "  is different from the WiFi password.");
                return false;
            }
        }
    }

    if (!CheckWlanSsid('ssid1_name')) {
        return false;
    }

    if (IsDoubleWifi == 1) {
        if (!CheckWlanSsid('ssid2_name')) {
            return false;
        }
    }

    return true;
}

function CheckParameter()
{
	var oldPassword = document.getElementById("old_password");
	var newPassword = document.getElementById("new_password");
	var cfmPassword = document.getElementById("confirm_password");
	var CheckResult = 0;
	
	if (oldPassword.value == "")
	{
		alert("The old password cannot be left blank.");
		return false;
	}

	if (newPassword.value == "")
	{
		alert("The new password cannot be left blank.");
		return false;
	}

	if (newPassword.value.length > 127)
	{
		alert("The password must consist of 1 to 127 characters.");
		return false;
	}

	if (!isValidAscii(newPassword.value))
	{
		alert("The new password contains invalid characters. Enter a valid one.");
		return false;
	}

	if (cfmPassword.value != newPassword.value)
	{
		alert("The login confirmation password is different from the new password.");
		return false;
	}

    CheckResult = CheckPassword(oldPassword.value);
    if ((CheckResult != 1) && (CheckResult != 2)) {
        alert("Incorrect old password. Please retry.");
        return false;
    }

    if (preflag == 1) {
        if (!CheckPwdIsComplexForPldt(newPassword.value)) {
            alert("The password strength is too weak. Configure it again.");
            return false
        }
    } else {
        if (!CheckPwdIsComplex(newPassword.value)) {
            alert("The password strength is too weak. Configure it again.");
            return false;
        }
    }

    if (!CheckWiFiParameter()) {
        return false;
    }

    return true;
}

function SubmitUpdate() {
    if (!CheckParameter()) {
        return false;
    }

    var Form = new webSubmitForm();
    var url = 'MdfPwdNormalNoLg.cgi';
    var webUserDomin = 'InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1';
    if (Userlevel == 2) {
        url = 'MdfPwdAdminNoLg.cgi';
        webUserDomin = 'InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.2';
    }

    if (IsSingleWifi == 1) {
        Form.addParameter('x.PreSharedKey', getValue('ssid1_password'));
        Form.addParameter('y.SSID', getValue('ssid1_name'));
        Form.addParameter('z.Password', getValue('new_password'));
        Form.addParameter('x.X_HW_Token', getAuthToken());
        Form.setAction(url +'?x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1&y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1&z=' + webUserDomin + '&RequestFile=login.asp');
    } else if (IsDoubleWifi == 1) {
        if (preflag == 1) {
            var enable = document.getElementById('steering_box').checked
            Form.addParameter('z.Password', getValue('new_password'));
            if (enable) {
                Form.addParameter('x.PreSharedKey', getValue('ssid1_password'));
                Form.addParameter('y.PreSharedKey', getValue('ssid1_password'));
                Form.addParameter('m.SSID', getValue('ssid1_name'));
                Form.addParameter('n.SSID', getValue('ssid1_name'));
            } else {
                Form.addParameter('x.PreSharedKey', getValue('ssid1_password'));
                Form.addParameter('y.PreSharedKey', getValue('ssid2_password'));
                Form.addParameter('m.SSID', getValue('ssid1_name'));
                Form.addParameter('n.SSID', getValue('ssid2_name'));
            }
            Form.addParameter('x.X_HW_Token', getAuthToken());
            Form.setAction(url +'?x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1&y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.PreSharedKey.1&m=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1&n=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5&z=' + webUserDomin +'&RequestFile=login.asp');
        } else {
            Form.addParameter('x.PreSharedKey', getValue('ssid1_password'));
            Form.addParameter('y.PreSharedKey', getValue('ssid2_password'));
            Form.addParameter('m.SSID', getValue('ssid1_name'));
            Form.addParameter('n.SSID', getValue('ssid2_name'));
            Form.addParameter('z.Password', getValue('new_password'));
            Form.addParameter('x.X_HW_Token', getAuthToken());
            Form.setAction(url +'?x=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1&y=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.PreSharedKey.1&m=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1&n=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5&z=' + webUserDomin +'&RequestFile=login.asp');
        }
    } else {
        Form.addParameter('z.Password', getValue('new_password'));
        Form.addParameter('x.X_HW_Token', getAuthToken());
        Form.setAction(url + '?z=' + webUserDomin + '&RequestFile=login.asp');
    }

    Form.submit();

}

</script>
</head>
<body onLoad="LoadFrame();">
<div id="base_mask" style=""></div>
<div id="main_wrapper">
<script language="JavaScript" type="text/javascript">
if ('ORO' == CfgMode.toUpperCase())
{
	document.write('<div style="position:absolute;margin-left:30px;top:30px;height:50px;width:50px;background: url(images/logo_Oro.gif);"></div>');
}

</script>
<div  id="pwd_modify" style="display:none;">
    <div id="modify_pwd_login_label">
		<li style="position: relative;top:10px; width: 500px;left: 100px; list-style-type: none; color: red; font-weight: bold; font-size: 14px;"><div>The login password is the default one. Change it immediately.</div></li>
	</div>
	
    <div id="modify_pwd_login">
	<ul style="position:absolute; clear:both; list-style-type: none; top:30px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
		<li style="position: relative; top: 0px; width: 130px;" ><div align="right">Old Password:</div></li>
			<li style="position: relative; top: 10px; width: 130px;" ><div align="right">New Password:</div></li>
			<li style="position: relative; top: 20px; width: 130px;" ><div align="right">Confirm Password:</div></li>
	</ul>

	<ul style="color:#FFFFFF; position:absolute; top:30px; left:94px; height:15px; list-style-type:none; line-height:30px;">
		<li ><input name="old_password" id="old_password"    type="password" size="20" style="position: absolute; top: 5px; font-size:13px; width:180px;" /></li>
			<li ><input name="new_password" id="new_password"  type="password" size="20" style="position: absolute; top: 45px; font-size: 13px; width:180px; " /></li>
			<li ><input name="confirm_password" id="confirm_password" type="password" size="20" style="position: absolute; top: 85px; font-size:13px; width:180px;" /></li>		
	</ul>
	
		<ul style="position:absolute; clear:both; list-style-type: none; top:30px; left:290px; height:15px; line-height:16px; font-size: 12px;">
			<li style="position: relative; top: 0px; width: 280px;" ><div align="left">
				<script language="JavaScript" type="text/javascript">
					if ((CfgMode.toUpperCase() == 'PLDT') || (CfgMode.toUpperCase() == 'PLDT2'))
					{
						var innerhtml = '1. The password must contain at least 8 characters.<br/>2. The password must contain at least three of the following combinations: <br/>&nbsp;&nbsp;&nbsp;digits, uppercase letters, lowercase letters <br/>&nbsp;&nbsp;&nbsp; and special characters. Special characters can be the following: ` ~ ! @ # $ % ^ & * ( ) - _ = + \\ | [ { } ] ; : \' \" < , . > / ?.<br/>3. The password cannot be any user name or user name in reverse order.';
					}
					else
					{
						var innerhtml = '1. The password must contain at least 8 characters.<br/>2. The password must contain at least two of the following combinations: <br/>&nbsp;&nbsp;&nbsp;digits, uppercase letters, lowercase letters <br/>&nbsp;&nbsp;&nbsp; and special characters. Special characters can be the following: ` ~ ! @ # $ % ^ & * ( ) - _ = + \\ | [ { } ] ; : \' \" < , . > / ?.<br/>3. The password cannot be any user name or user name in reverse order.';
					}
					document.write(innerhtml);
				</script>
			</div></li>
		</ul>
	</div>
	<div id="modify_pwd_label" >
		<li style="position: relative;top:150px; width: 500px;left: 100px; list-style-type: none; color: red; font-weight: bold; font-size: 14px;"><div>Modify the wifi password</div></li>
	</div>

    <div id="band_steering_box" >
        <ul style="position:absolute; clear:both; list-style-type: none; top:175px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
            <li style="position: relative; top: 0px; width: 130px;" ><div id="bandSteer_lebel" align="right"></div></li>
            <li style="position: relative; top: 0px; width: 130px;" ><div align="right">Band steering:</div></li>
        </ul>
        <ul style="position:absolute; clear:both; list-style-type: none; top:175px; left:10px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
            <li ><input name="steering_box" id="steering_box" type="checkbox" size="20" onClick="BandSteeringEnable();" style="position: absolute; top: 5px; font-size:13px; left:120px;" /></li>
        </ul>
    </div>

	<div id="modify_pwd_ssid1" >
		<ul style="position:absolute; clear:both; list-style-type: none; top:210px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
			<li style="position: relative; top: 0px; width: 130px;" ><div id="ssid1_name_lebel" align="right"></div></li>
			<li style="position: relative; top: 0px; width: 130px;" ><div align="right">WiFi Password:</div></li>
            <li style="position: relative; top: 0px; width: 130px;" ><div align="right">Confirm Password:</div></li>
		</ul>
		<ul style="color:#FFFFFF; position:absolute; top:210px; left:94px; height:15px; list-style-type:none; line-height:30px;">
			<li ><input id="ssid1_name" type="txt" size="20" style="position: absolute; top: 5px; font-size:13px; width:180px;" /></li>
			<li ><input name="ssid1_password" id="ssid1_password" type="password" size="20" style="position: absolute; top: 35px; font-size:13px; width:180px;" /></li>	
            <li ><input name="ssid1_confirm_password" id="ssid1_confirm_password" type="password" size="20" style="position: absolute; top: 65px; font-size:13px; width:180px;" /></li>
		</ul>
		<ul style="position:absolute; clear:both; list-style-type: none; top:210px; left:290px; height:15px; line-height:20px; font-size: 12px;">
			<li style="position: relative; top: 35px; width: 280px;" >
                <div align="left">
                <script>
					if (preflag == 1) {
						document.write('1.The Wi-Fi password must contain at least 8 characters.<br/> 2.The Wi-Fi password must contain at least three of the following characters: uppercase letters, lowercase letters, digits, and special characters or contain at least 15 characters.');
					} else {
						document.write('(8-63 characters or 64 hexadecimal characters)');
					}
                </script>
                </div>
             </li>
		</ul>
		
	</div>
	<div id="modify_pwd_ssid2" >
		<ul style="position:absolute; clear:both; list-style-type: none; top:300px; left:-38px; height:15px; line-height:30px; font-weight: bold; font-size: 12px;">
			<li style="position: relative; top: 0px; width: 130px;" ><div align="right">5G WiFi SSID:</div></li>
			<li style="position: relative; top: 0px; width: 130px;" ><div align="right">WiFi Password:</div></li>
            <li style="position: relative; top: 0px; width: 130px;" ><div align="right">Confirm Password:</div></li>
	</ul>
    <ul style="color:#FFFFFF; position:absolute; top:300px; left:94px; height:15px; list-style-type:none; line-height:30px;">
			<li ><input id="ssid2_name" type="txt" size="20" style="position: absolute; top: 5px; font-size:13px; width:180px;" /></li>
			<li ><input name="ssid2_password" id="ssid2_password" type="password" size="20" style="position: absolute; top: 35px; font-size:13px; width:180px;" /></li>
            <li ><input name="ssid2_confirm_password" id="ssid2_confirm_password" type="password" size="20" style="position: absolute; top: 65px; font-size:13px; width:180px;" /></li>
		</ul>
		<ul style="position:absolute; clear:both; list-style-type: none; top:300px; left:290px; height:15px; line-height:20px; font-size: 12px;">
			<li style="position: relative; top: 35px; width: 280px;" >
                <div align="left">
                <script>
                if (preflag != 1) {
                    document.write('(8-63 characters or 64 hexadecimal characters)');
                }
                </script>
                </div>
            </li>
		</ul>		
	</div>
	
	<div id="update" style="position: relative;">
		<div style="float: left; margin-top: 250px; margin-left: 180px;">
			<button id="button_update" style="width: 80px; height: 23px;" onclick="SubmitUpdate();" >Update</button>
			<div >&nbsp;</div> </div>
	</div>
	
</div>

<div style="position:absolute; top:300px;margin-left:250px;height:300px; width:490px;background: url('images/pic.jpg') no-repeat center;">
<table id="tablecheckcode" border="0" cellpadding="0" cellspacing="0" width="100%" style="display: none">
	<tr>
	<td height="8"></td>
	</tr>
	<tr>
		<td>
			<img id="imgcode" style="margin-left:111px;height:30px;width:100px;" onClick="BthRefresh();">
			<input type="button" id="changecode" style="margin-left:20px;width:58px;" class="submit" value="Refresh" onClick="BthRefresh();"/>
		</td>
	</tr>

	<tr>
		<td height="8"></td>
	</tr>
	<tr align="center">
	<td>
	 <button style="font-size:12px;font-family:Tahoma,Arial;margin-left:-70px;" id="tripletbtn" class="submit" name="tripletbtn" onClick="SubmitForm();" type="button">Login</button>
	</td>
  </tr>
	  <tr>
		<script language="JavaScript" type="text/javascript">
		document.write('<td class="info_text" height="25" id="tipletfooter"><span style="margin-left:-55px;">Copyright © 2024 Huawei Technologies Co., Ltd. All rights reserved.</span></td>');
		</script>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr id="Copyrightfooter" style="position:absolute; margin-left:20px;top:-25px;display: none;color:#9d9d9d;">
	<td height="25" id="footer" style="font-size:11px;"></td>
	</tr>
	<tr>
	<td valign="top" style="padding-top: 20px;"> 
		<div id="tipText" style="display: none">
			<table border="0" cellpadding="0" cellspacing="5" height="33" width="99%"> 
				<tr> <td align="center" bgcolor="#FFFFFF" height="21"> <span style="color:red;font-size:12px;font-family:Arial;">
						<div id="DivTipPage"></div> 
						</span> 
					</td> </tr> </table> 
		</div>
	</td>
	</tr>
	<tr>
	<td valign="top" style="padding-top: 20px;"> <div id="loginfail" style="display: none">
		<table border="0" cellpadding="0" cellspacing="5" height="33" width="99%">
		  <tr>
			<td align="center" bgcolor="#FFFFFF" height="21"> <span style="color:red;font-size:12px;font-family:Arial;">
			  <div id="DivErrPage"></div>
			  </span> </td>
		  </tr> </table> </div>
	  </td> </tr>
</table>
</div> <table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<script language="JavaScript" type="text/javascript">
			if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'ORO' == CfgMode.toUpperCase() || 'TRIPLETSINGLE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
			{
				document.write('<td align="center" height="210" valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="44%"> ');
			}
			else if ( 'VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
			{
				document.write('<td align="center" height="210" valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="38%"> ');								
			}
			else
			{
				document.write('<td align="center" height="210" valign="bottom"> <table border="0" cellpadding="0" cellspacing="0" width="36%"> ');
			}
		</script>
		<tr>
			<script language="JavaScript" type="text/javascript">
				if ('DIGICEL' == CfgMode.toUpperCase() || 'DIGICEL2' == CfgMode.toUpperCase())
				{
					document.write('<td align="center" width="81%"> ');
				}
				else
				{
					document.write('<td align="center" width="29%"> ');
				}

				if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLETSINGLE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase()) {
					document.write('<img height="70" src="images/logo3bb.gif" width="144" alt="">');
				} else if (CfgMode.toUpperCase() == 'TRIPLET2WIFI6') {
					document.write('<img height="70" src="images/logo3bbwifi6.gif" width="144" alt="">');
				} else if (CfgMode.toUpperCase() == 'ORANGEMT') {
					document.write('<img height="118" src="images/logo_MA.gif" width="118" alt="">');
				}
				else if ('ORO' == CfgMode.toUpperCase())
				{
					document.write('');
				}
				else if('NOS' == CfgMode.toUpperCase())
				{
					document.write('<img height="72" src="images/logo_nos.gif" width="136" alt="">');
				}
				else if('ANTEL' == CfgMode.toUpperCase()||'ANTEL2' == CfgMode.toUpperCase())
				{
					document.write('<img height="36" src="images/logo_antel.gif" width="100" alt="">');
				}
				else if (1 == SonetFlag)
				{
					document.write('<img height="0" src="images/logo.gif" width="0" alt="">');
				}
				else if('DIGICEL' == CfgMode.toUpperCase() || 'DIGICEL2' == CfgMode.toUpperCase())
				{
					document.write('<img height="56" src="images/logo_digicel.jpg" width="180" alt="">');
				}
				else if ('PLDT' == CfgMode.toUpperCase() || 'PLDT2' == CfgMode.toUpperCase())
				{
					document.write('<img height="72" src="images/logo_pldt.gif" width="144" alt="">');
				}
				else if ('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
				{
					document.write('<img height="72" src="images/logo_viettel.jpg" width="136" alt="">');
				}
				else if ('SINGTEL' == CfgMode.toUpperCase() || 'SINGTEL2' == CfgMode.toUpperCase())
				{
					document.write('<img height="75" src="images/logo_singtel.gif" width="137" alt="">');
				}
				else if ('TS' == CfgMode.toUpperCase() || 'TS2' == CfgMode.toUpperCase())
				{
					document.write('<img height="75" src="images/logo_ts.jpg" width="148" alt="">');
				}
				else if ('CNT' == CfgMode.toUpperCase() || 'CNT2' == CfgMode.toUpperCase() )
				{
					document.write('<img height="75" src="images/logo_cnt.gif" width="75" alt="">');
				}
				else if ('TM' == CfgMode.toUpperCase() )
				{
					document.write('<img height="120" src="images/logo_tm.gif" width="120" alt="" style="position: absolute; margin-top: -140px; margin-left: 63px;">');
				}
				else if ('OMANONT' == CfgMode.toUpperCase() || 'OMANONT2' == CfgMode.toUpperCase())
				{
					document.write('<img height="87" src="images/logo_oman.gif" width="141" alt="">');
				}
				else if('CLARODR' == CfgMode.toUpperCase() || 'CLARO' == CfgMode.toUpperCase())
				{
					document.write('<img height="75" src="images/logo_clar.gif" width="75" alt="">');
				}
				else
				{
					document.write('<img height="75" src="images/logo.gif" width="70" alt="">');
				}
			</script>
			</td>
			<script language="JavaScript" type="text/javascript">
				if('DIGICEL' == CfgMode.toUpperCase() || 'DIGICEL2' == CfgMode.toUpperCase())
				{
					document.write('<td class="hg_logo" width="11%" id="hg_logo" nowrap></td>');
					document.write('<td valign="bottom" width="8%">');
				}
				else
				{
					document.write('<td class="hg_logo" width="21%" id="hg_logo" nowrap>');
					document.write(ProductName);
					document.write('</td>');
					document.write('<td valign="bottom" width="50%">');
				}
			</script>
			<table border="0" cellpadding="0" cellspacing="0" class="text_copyright" width="100%">
				<tr>
				  <script language="JavaScript" type="text/javascript">
					if (SonetFlag == 1) {
                        if (SonetSGP100BFlag == 1) {
                            document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" style="font-size:12px;font-family:Arial;"></a> </td>');
                            document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language"  style="font-size:12px;font-family:Arial;"></a> </td>');
                        } else {
                            document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" onClick="onChangeLanguage(' + "'english'" + ');" style="font-size:12px;font-family:Arial;">[English]</a> </td>');
                            document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language" onClick="onChangeLanguage(' + "'japanese'" + ');" style="font-size:12px;font-family:Arial;">[日本語]</a> </td>');
                        }
                    }
					else if ((1 == IsPTVDF)  || ('RDSGATEWAY' == CfgMode.toUpperCase()))
					{
						document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" onClick="onChangeLanguage(' + "'english'" + ');" style="font-size:12px;font-family:Arial;">[English]</a> </td>');
						document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language" onClick="onChangeLanguage(' + "'portuguese'" + ');" style="font-size:12px;font-family:Arial;">[Portuguese]</a> </td>');
					}
					else if ('ANTEL' == CfgMode.toUpperCase())
					{
						document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" onClick="onChangeLanguage(' + "'english'" + ');" style="font-size:12px;font-family:Arial;">[English]</a> </td>');
						document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language" onClick="onChangeLanguage(' + "'spanish'" + ');" style="font-size:12px;font-family:Arial;">[Spanish]</a> </td>');
                  	}
					else if ('UZBEKISTAN' == CfgMode.toUpperCase() || 'ROSTELECOM' == CfgMode.toUpperCase() || 'ROSTELECOM2' == CfgMode.toUpperCase()
							  || 'ROSCNT' == CfgMode.toUpperCase() || 'NWT' == CfgMode.toUpperCase() || 'ROSCNT2' == CfgMode.toUpperCase()
							  || 'ROSUNION' == CfgMode.toUpperCase() || 'KAZAKHSTAN' == CfgMode.toUpperCase())
                  	{
                  		document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" onClick="onChangeLanguage(' + "'english'" + ');" style="font-size:12px;font-family:Arial;">[English]</a> </td>');
                  		document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language" onClick="onChangeLanguage(' + "'russian'" + ');" style="font-size:12px;font-family:Arial;">[Русский]</a> </td>');	
					}
					else if ('CTM' == CfgMode.toUpperCase())
					{
						document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" onClick="onChangeLanguage(' + "'english'" + ');" style="font-size:12px;font-family:Arial;">[English]</a> </td>');
						document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language" onClick="onChangeLanguage(' + "'chinese'" + ');" style="font-size:12px;font-family:Arial;">[中文]</a> </td>');
					}
                    else if (1 == IsTURKSATEBG)
					{
						document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" onClick="onChangeLanguage(' + "'english'" + ');" style="font-size:12px;font-family:Arial;">[English]</a> </td>');
						document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language" onClick="onChangeLanguage(' + "'turkish'" + ');" style="font-size:12px;font-family:Arial;">[Türkçe]</a> </td>');
					}
					else
					{
						document.write('<td width="47%" nowrap> <a id="English" href="#" name="English" style="font-size:12px;font-family:Arial;"></a> </td>');
						document.write('<td width="53%" nowrap> <a id="Specical_language" href="#" name="Specical_language"  style="font-size:12px;font-family:Arial;"></a> </td>');
					}
				  </script>
				</tr>
			  </table></td> </tr>
		</table></td>
	</tr>
	<tr>
      <td id="login_for_common" align="center" height="65"> <table border="0" cellpadding="0" cellspacing="0" class="tblcalss" height="65" width="45%" style="font-size:16px;"> 
		  <tr>
			<td class="whitebold" height="37" align="right" width="20%" id="account"></td>
			<td class="whitebold" height="37" align="center" width="2%">:</td>
			<td width="78%" style="text-align: left;"> <input style="font-size:12px;font-family:Tahoma,Arial;" id="txt_Username" class="input_login" name="txt_Username" type="text" maxlength="32"> </td>
		  </tr>
		  <tr>
			<td class="whitebold" height="28" align="right" id="Password"></td>
			<td class="whitebold" height="28" align="center" >:</td>
			<td style="text-align: left;"> <input style="font-size:12px;font-family:Tahoma,Arial;" id="txt_Password" class="input_login" name="txt_Password" type="password" autocomplete="off" maxlength="127">
&nbsp;
			<button style="font-size:12px;font-family:Tahoma,Arial;display: none;" id="button" class="submit" name="Submit" onClick="SubmitForm();" type="button"></button>
&nbsp;
			<button style="font-size:12px;font-family:Tahoma,Arial;display: none;" id="buttonReg" class="submit" name="Submit" onClick="JumpToReg();" type="button"></button>			
			</td>
		</tr>

		<tr id="txtVerificationCode" style="display: none">
			<td class="whitebold" height="28" align="right" id="Validate">Validate Code</td>
			<td class="whitebold" height="32" align="center" >:</td>
			<td>
			<input style="font-size:12px;font-family:Tahoma,Arial;height:21px;" id="VerificationCode" class="input_login" name="VerificationCode" type="text" maxlength="127"></td>
		</tr></table></td>
	</tr>
	</table>
</div>
	<script language="JavaScript" type="text/javascript">
		if ( 'TRIPLET' == CfgMode.toUpperCase() || 'TRIPLETVOICE' == CfgMode.toUpperCase() || 'TRIPLET2' == CfgMode.toUpperCase() || 'TRUE' == CfgMode.toUpperCase() || 'TRIPLET2WIFI6' == CfgMode.toUpperCase())
		{
			document.getElementById('tablecheckcode').style.display = '';
			document.getElementById('txtVerificationCode').style.display = '';
			document.getElementById("imgcode").src = 'getCheckCode.cgi?&rand=' + new Date().getTime();
		}
		else
		{
			document.getElementById('Copyrightfooter').style.display = '';
			document.getElementById('button').style.display = '';
			if ("1" == RegPageFlag)
			{
				document.getElementById('buttonReg').style.display = '';
			}
		}
	</script>
</body>
</html>
