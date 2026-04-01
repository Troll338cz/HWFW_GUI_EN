<!DOCTYPE HTML>
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
#pwdPortalInput1,#pwdPortalInput3{
	font-size:1.5em;
	font-family:"微软雅黑";
	font-weight: bold;
	outline:none;
	width: 100%;
	height: 3.5em;
	color: #555;
	padding-left: 3%;
	line-height: 3.5em;
}

	#pwdPortalInput2,#pwdPortalInput4{
	font-size:1.5em;
	font-family:"微软雅黑";
	font-weight: bold;
	outline:none;
	width: 100%;
	height: 3.5em;
	color: #555;
	padding-left: 3%;
	line-height: 3.5em;
}		
	.stepPortalTiprule{
		line-height:4em;
		margin-left: 2%;
		text-align:left;
		margin-top: 8em;
	}	
	input::-ms-clear{
	display:none;
	}
	input::-ms-reveal{
	display:none;
	}
</style>
<script>
	var curUserInfo = self.parent.UserInfoList[0].UserName;
	var radiuspassword = "";
	var portalAPType = '<%HW_WEB_GetApMode();%>';
	var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
    var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
	if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
	{
		window.location='/login.asp'; 
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
		var i = 0;
		
        if (str.length < pwdLen)
		{
			return false;
		}

		if (!CompareString(str,curUserInfo) )
		{
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
	
    function WebPwdAjaxConfigPara(ObjPath, ParameterList)
	{
		var Result = null;
		  $.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : '/portalguideconfig.cgi?' + ObjPath + "&RequestFile=/portal/PortalWebPwd.asp",
			data: getDataWithToken(ParameterList),
			success : function(data) {
				 Result  = data;      
			}
		});

		return Result;
	}
		
	function ModifyWebPwd()
	{	
		var path = "x=" + self.parent.UserInfoList[0].domain;
		var newPassword="";
		var flag = $("#showPwd1").attr("src");
		if (flag.indexOf("show") > -1)
		{	
			newPassword = document.getElementById("pwdPortalInput1").value;
		}
		else
		{
			newPassword = document.getElementById("pwdPortalInput3").value;
		}
		var set_wanparalist ="x.Password=" + newPassword;
		WebPwdAjaxConfigPara(path, set_wanparalist);
	}
	
	function CheckParameter()
	{
		var newPassword1 = document.getElementById("pwdPortalInput1");
		var newPassword3 = document.getElementById("pwdPortalInput3");

		var cfmPassword = document.getElementById("pwdPortalInput2");

		if (newPassword1.value == "" || newPassword3.value == "")
		{
			self.parent.AlertInfo(PortalguideDes['p0170']);
			return false;
		}

		if (newPassword1.value.length > 127 || newPassword3.value.length > 127)
		{
			self.parent.AlertInfo(PortalguideDes['p0171']);
			return false;
		}

		if (!isValidAscii(newPassword1.value) || !isValidAscii(newPassword3.value))
		{
			self.parent.AlertInfo(PortalguideDes['p0172']);
			return false;
		}

		if (cfmPassword.value != newPassword1.value || cfmPassword.value != newPassword3.value)
		{
			self.parent.AlertInfo(PortalguideDes['p0173']);
			return false;
		}

		if(!CheckPwdIsComplex(newPassword1.value) || !CheckPwdIsComplex(newPassword3.value))
		{
			self.parent.AlertInfo(PortalguideDes['p0174']);
			return false;
		}
		
		return true;
	}

	function CheckPwdNotice()
	{
		var password1 = getElementById("pwdPortalInput1").value;
		var password3 = getElementById("pwdPortalInput3").value;
		
		if(password1.length == 0 || password3.length == 0){
			return;
		}
		
		if( !CheckPwdIsComplex(password1) || !CheckPwdIsComplex(password3) )
		{
			self.parent.AlertInfo(PortalguideDes['p0174']);
			return;
		}
		
		return;
	}
	
	function pwdStrengthcheck(obj)
	{
		var lengthmatch=0;
		var lowerCharmatch=0;
		var upCharmatch=0;
		var NumCharmatch=0;
		var specialCharmatch=0;
		var score = 0;
		var totalscore = 0;
		var password1 = getElementById(obj.id).value;
		if("pwdPortalInput1" == obj.id)
		{
			getElById('pwdPortalInput3').value=password1;
		}
		else
		{
			getElById('pwdPortalInput1').value=password1;
		}
		
		var password3 = password1;
		var DestPwdLen=6;
		
		if(password1.length >= DestPwdLen || password3.length >= DestPwdLen) {
			lengthmatch = 1;
			score++;
		}

		if(password1.match(/[a-z]/) || password3.match(/[a-z]/)) {
			lowerCharmatch = 1;
			score++;
		}
		
		if(password1.match(/[A-Z]/) || password3.match(/[A-Z]/)){
			upCharmatch = 1;
			score++;
		}
		
		if(password1.match(/[0-9]/) || password3.match(/[0-9]/)){
			NumCharmatch = 1;
			score++;
		}

		if(password1.match(/\d/) || password3.match(/\d/)) score++;

		if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) || password3.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) {
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

	function LoadFrame()
	{
		$("#pwdStreng").css("display","none");
		parent.adjustIframeHeight();
		self.parent.curPageFlag = "WEBPWDPage";
		self.parent.ControlPageShow();
	}

	function showPassword1()
	{	
		var flag = $("#showPwd1").attr("src");
		if (flag.indexOf("show") > -1)
		{
			$("#pwdPortalInput1").css("display","none");
			$("#pwdPortalInput3").css("display","block");
			$("#showPwd1").attr("src","/images/img_hide_pwd.jpg");
			document.getElementById("pwdPortalInput3").value = document.getElementById("pwdPortalInput1").value;
		}
		else
		{
			$("#pwdPortalInput1").css("display","block");
			$("#pwdPortalInput3").css("display","none");
			$("#showPwd1").attr("src","/images/img_show_pwd.jpg");
			document.getElementById("pwdPortalInput1").value = document.getElementById("pwdPortalInput3").value;
		}
	}
	function showPassword2()
	{
		var flag = $("#showPwd2").attr("src");
		if (flag.indexOf("show") > -1)
		{
			$("#pwdPortalInput2").css("display","none");
			$("#pwdPortalInput4").css("display","block");
			$("#showPwd2").attr("src","/images/img_hide_pwd.jpg");
			document.getElementById("pwdPortalInput4").value = document.getElementById("pwdPortalInput2").value;
		}
		else
		{
			$("#pwdPortalInput2").css("display","block");
			$("#pwdPortalInput4").css("display","none");
			$("#showPwd2").attr("src","/images/img_show_pwd.jpg");
			document.getElementById("pwdPortalInput2").value = document.getElementById("pwdPortalInput4").value;
		}
	}

	</script>
</head>
<body onload="LoadFrame()" style="background-color: #f2f2f2;">
<div class="stepPortalContent container">
	<div class="stepPortalTip" style="">
        <span class="PortalUserName" style="display:inline-block;" BindText="p0124"></span>
		<span class="stepPortalWebPwd" style="display:inline-block;"><script>document.write('<div id="PortalProductName">' + curUserInfo + '</div>');</script></span>
    </div>

    <div class="stepPortalTip" style="">
        <span class="stepPortalTipSpan" style="" BindText="p0125"></span>
    </div>

    <div>			
		<input type='password' id='pwdPortalInput1' name='pwdPortalInput1'  class="NewPwdPortalInput" style="float:left" onkeyup="pwdStrengthcheck(this)"/>
		<input type='text' id='pwdPortalInput3' name='pwdPortalInput3' class="NewPwdPortalInput" style="float:left;display:none;" onkeyup="pwdStrengthcheck(this)" />
		<img id="showPwd1" src="/images/img_show_pwd.jpg" onclick="showPassword1()" /> 
    </div>
	
    <div class="stepPortalTip" style="">
        <span class="stepPortalTipSpan" BindText="p0126"></span>
    </div>
    <div>
		<input type='password' id='pwdPortalInput2' name='pwdPortalInput2' style="float:left" onchange="radiuspassword=getValue('pwdPortalInput2');getElById('pwdPortalInput4').value=radiuspassword;" />
		<input type='text' id='pwdPortalInput4' name='pwdPortalInput4' style="float:left;display:none;"  onchange="radiuspassword=getValue('pwdPortalInput4');getElById('pwdPortalInput2').value=radiuspassword;"/>
        <img id="showPwd2" src="/images/img_show_pwd.jpg" onclick="showPassword2()" />
    </div>

	<div id="pwdStreng" style="display:none;">
        <span class="stepPortalTipSpan" BindText="p0127"></span>
    </div>

    <div class="pwdStrength">
        <span id="passsPortaltrength"></span>
    </div>
	
	<div>
		<span style="text-align:center;" class="language-string" id="pwdvalue" style="font-size:1.2em;"></span>
	</div>
	
    <div class="stepPortalTiprule">
        <span class="pwdnoticetitle" BindText="p0128"></span>
    </div>
	<div id="pwdnoticearea">
		<ol class="outside" id="PwdNotice">
            <div BindText="p0129"></div>
			<div BindText="p0130"></div>
			<div BindText="p0131"></div>
		</ol>
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
