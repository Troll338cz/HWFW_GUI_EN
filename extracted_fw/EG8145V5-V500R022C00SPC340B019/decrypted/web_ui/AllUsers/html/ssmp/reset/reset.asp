<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">

var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

function GetLanguageDesc(Name)
{
    return ResetLgeDes[Name];
}

function LoadFrame()
{ 

}
function Reboot()
{
	if(ConfirmEx(GetLanguageDesc("s0601"))) 
	{
		setDisable('btnReboot',1);
		
		var Form = new webSubmitForm();
				
		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
								+ '&RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));						
		Form.submit();
	}
}

</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<div>
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("reset", GetDescFormArrayById(ResetLgeDes, "s0603"), GetDescFormArrayById(ResetLgeDes, "s0602"), false);
</script> 
<div class="title_spread"></div>
  <table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td> <input  class="ApplyButtoncss buttonwidth_150px" name="btnReboot" id="btnReboot" type='button' onClick='Reboot()' BindText="s0603">
          <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">	  
	  </td> 
    </tr> 
  </table> 
</div> 
</body>

<script>
	if (rosunionGame == "1") {
		$("#btnReboot").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
	}
	ParseBindTextByTagName(ResetLgeDes, "td",     1);
	ParseBindTextByTagName(ResetLgeDes, "input",  2);
</script>

</html>
