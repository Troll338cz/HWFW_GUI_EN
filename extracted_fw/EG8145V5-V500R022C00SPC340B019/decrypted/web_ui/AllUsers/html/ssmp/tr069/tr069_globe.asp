<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>


<script language="JavaScript" type="text/javascript">

var Tr069ModeVar = '<%HW_WEB_GetTr069Mode();%>';

function LoadFrame()
{
	if(Tr069ModeVar == "stagmode")
	{
		document.getElementById("Tr069mode").options[1].selected=true;
	}
	else if (Tr069ModeVar == "prodmode")
	{
		document.getElementById("Tr069mode").options[0].selected=true;
	}
}

function OnChangeModeTR069()
{
	var sld;
	sld = document.getElementById("Tr069mode").value;
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	if (sld == 0)
	{
		Form.setAction('SetTr069ProductMd.cgi?' + 'RequestFile=html/ssmp/tr069/tr069_globe.asp');	
	}
	else if(sld == 1)
	{
		Form.setAction('SetTr069StagingMd.cgi?' + 'RequestFile=html/ssmp/tr069/tr069_globe.asp');
	}
	Form.submit();	

}
							
</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
	<div class="PageTitle_content">Set tr069. You can choose Production Setting mode or Staging Server Setting mode.</div>
	<div>
		<table border="0" cellpadding="0" cellspacing="1">
			<tr style="    height: 30px; position: absolute; margin-top: 10px;"> 
				<td class="table_title" style="width: 200px;">Preferred TR-069 Setting:</td>
				<td class="table_right" style="width: 450px; padding-left: 20px;"> 
					<select id="Tr069mode" size="1" style="width: 170px;" onChange="OnChangeModeTR069()">
							<option value="0" >Production Setting </option>
							<option value="1" >Staging Server Setting</option>
					 </select>
				 </td>
			</tr>
		</table>
	<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
	</div>
</body>
</html>
















