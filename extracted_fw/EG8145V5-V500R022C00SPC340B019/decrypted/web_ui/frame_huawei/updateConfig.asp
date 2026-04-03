<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<title>New Version Available</title>
<link href="Cuscss/<%HW_WEB_CleanCache_Resource(login.css);%>"  media="all" rel="stylesheet" />
<link href="Cuscss/<%HW_WEB_CleanCache_Resource(frame.css);%>" type='text/css' rel="stylesheet">
<script language="JavaScript" src="/../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function UpgradeSubmit(upgradetype, submitUrl)
{
    setdisableall();
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url :  upgradetype + "?&RequestFile=" + submitUrl,
            data: getDataWithToken(),
            success : function(data) {
            }
        });

    window.location = "/" + submitUrl;
}

function LoadFrame() 
{

}

function setdisableall()
{	
	document.getElementById('btnApply1').disabled = true;
	document.getElementById('btnApply2').disabled = true;
	document.getElementById('btnApply3').disabled = true;
}

function submitbtn1()
{
    UpgradeSubmit("agreePopUpgrade.cgi", "updateNote.asp");
}

function submitbtn2()
{
    UpgradeSubmit("refusePopUpgrade.cgi", "updateNote.asp");
}
function submitbtn3()
{
    UpgradeSubmit("remindPopUpgrade.cgi", "updateNote.asp");
}

</script>
</head>
<body onLoad="LoadFrame();">
	
	<div >
	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	<button id="btnApply1" name="btnApply1" type="button" class="submit" onClick="submitbtn1();">Upgrade Now</script></button> 
	<button name="btnApply2" id="btnApply2" class="submit" type="button" onClick="submitbtn2();">Ignore</button> 
	<button name="btnApply3" id="btnApply3" class="submit" type="button" onClick="submitbtn3();">Upgrade Later</button> 
	</div>
		
	<!-- <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabTest">	
		<tr>温馨提醒：</tr>
		<tr>     升级：网关立即升级，升级期间请勿断电</tr>		
		<tr>  不升级：网关不升级，本次消息不再提醒</tr>		
		<tr>暂不升级：暂时不升级，稍后每周弹窗提醒</tr>
		<tr></tr>
	</table> -->

</body>
</html>
