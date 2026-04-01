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
#pwdPortalInput,#pwdPortalInput1{
	font-size:1.5em;
	font-family:"Î¢ÈíÑÅºÚ";
	font-weight: bold;
	outline:none;
	width: 100%;
	height: 3.5em;
	color: #555;
	padding-left: 3%;
	line-height: 3.5em;
}
input::-ms-clear{
display:none;
}
input::-ms-reveal{
display:none;
}

</style>
	<script>
		var radiuspassword = "";
		var portalAPType = '<%HW_WEB_GetApMode();%>';
		var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
		if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
		{
			window.location='/login.asp'; 
		}
		
		self.parent.FristLogin = 1;
		function CheckParameter()
		{
			var tempUsrName = getValue("UserPortalInput");
			var tempPwd = getValue("pwdPortalInput");
			if ((tempUsrName != '') && (isValidAscii(tempUsrName) != ''))        
			{  
				self.parent.AlertInfo(PortalguideDes['p0156']);          
				return false;       
			}

			if ((tempPwd != '') && (isValidAscii(tempPwd) != ''))         
			{  
				self.parent.AlertInfo(PortalguideDes['p0157']);         
				return false;       
			}
			
			return true;
		}
		
		function HwAjaxConfigPara(ObjPath, ParameterList)
		{
			var Result = null;
			  $.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : '/portalguideconfig.cgi?' + ObjPath + "&RequestFile=/portal/PortalBbspPwd.asp",
				data: getDataWithToken(ParameterList),
				success : function(data) {
					 Result  = data;      
				}
			});
			
			return Result;
		}
		
		function PPPoeWanSubForm()
		{
			var Username = getValue("UserPortalInput");
			var UserPwd = getValue("pwdPortalInput");
			if (self.parent.currPPPOEIndex == -1)
			{
				var add_wanpath = "InternetGatewayDevice.WANDevice.1.WANConnectionDevice";     
				var add_path = 'Add_x='+ add_wanpath + 
				'&Addconnect_z=' + add_wanpath + '.{i}.WANPPPConnection';

				var add_wanparalist = "Addconnect_z.Enable=1&Addconnect_z.X_HW_IPv4Enable=1&Addconnect_z.X_HW_IPv6Enable=0" + 
									"&Addconnect_z.X_HW_IPv6MultiCastVLAN=-1&Addconnect_z.X_HW_SERVICELIST=INTERNET&Addconnect_z.X_HW_ExServiceList=" + 
									"&Addconnect_z.X_HW_VLAN=0&Addconnect_z.X_HW_PRI=0&Addconnect_z.X_HW_PriPolicy=Specified&Addconnect_z.X_HW_DefaultPri=0" + 
									"&Addconnect_z.ConnectionType=IP_Routed&Addconnect_z.X_HW_MultiCastVLAN=4294967295&Addconnect_z.NATEnabled=1" + 
									"&Addconnect_z.X_HW_NatType=0&Addconnect_z.Username=" + Username + "&Addconnect_z.Password=" + UserPwd +
									"&Addconnect_z.X_HW_LcpEchoReqCheck=0&Addconnect_z.ConnectionTrigger=AlwaysOn&Addconnect_z.DNSEnabled=1" + 
									"&Addconnect_z.MaxMRUSize=1492&Addconnect_z.DNSOverrideAllowed=0&Addconnect_z.DNSServers=&Addconnect_z.X_HW_BindPhyPortInfo=";         

				HwAjaxConfigPara(add_path, add_wanparalist);
			}
			else
			{
				var path = "x=" + self.parent.WanPpp[self.parent.currPPPOEIndex].domain;
				var set_wanparalist = "x.Username=" + Username + "&x.Password=" + UserPwd;
				HwAjaxConfigPara(path, set_wanparalist);
			}
			
		}
		
		function InitValue()
		{
			if (self.parent.currPPPOEIndex == -1)
			{
				return;
			}
			
			setText("UserPortalInput", self.parent.WanPpp[self.parent.currPPPOEIndex].Username);
		}
		
		function showPassword()
		{
			var flag = $("#showPwd").attr("src");
			if (flag.indexOf("show") > -1)
			{
				$("#pwdPortalInput").css("display","none");
				$("#pwdPortalInput1").css("display","block");
				$("#showPwd").attr("src","/images/img_hide_pwd.jpg");
				document.getElementById("pwdPortalInput1").value = document.getElementById("pwdPortalInput").value;
			}
			else
			{
				$("#pwdPortalInput").css("display","block");
				$("#pwdPortalInput1").css("display","none");
				$("#showPwd").attr("src","/images/img_show_pwd.jpg");
				document.getElementById("pwdPortalInput").value = document.getElementById("pwdPortalInput1").value;
			}
		}
		
		function LoadFrame()
		{
			InitValue();
			parent.adjustIframeHeight();
			self.parent.curPageFlag = "PPPOEWANPage";
			self.parent.ControlPageShow();
			return;
		}
	</script>
</head>
<body onload="LoadFrame()" style="background-color: #f2f2f2;">
<div class="stepPortalContent container">
    <div class="stepPortalTip" style="line-height:6em;">
        <span class="stepPortalTipSpan" style="" BindText="p0117"></span>
    </div>

    <div>
        <input type="text" id="UserPortalInput" placeholder="">
    </div>
	
    <div class="stepPortalTip" style="line-height:6em;">
        <span class="stepPortalTipSpan" BindText="p0118"></span>
    </div>
    <div>		
		<input type='password' id='pwdPortalInput' name='pwdPortalInput'  class="NewPwdPortalInput" style="float:left" onchange="radiuspassword=getValue('pwdPortalInput');getElById('pwdPortalInput1').value=radiuspassword;" />
		<input type='text' id='pwdPortalInput1' name='pwdPortalInput1' class="NewPwdPortalInput" style="float:left;display:none;" onchange="radiuspassword=getValue('pwdPortalInput1');getElById('pwdPortalInput').value=radiuspassword;"/>
		
        <img id="showPwd" src="/images/img_show_pwd.jpg" onclick="showPassword()" />
    </div>

    <div class="pwdStrength">
        <span id="passsPortaltrength" class="stepPortalTipSpan"></span>
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
