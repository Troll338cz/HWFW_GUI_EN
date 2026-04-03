<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>CATV Port Configration</title>
<script language="JavaScript" type="text/javascript">

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var isRfOn = '<%HW_WEB_IsRfExist();%>'; 

function LoadFrame() 
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}

		b.innerHTML = status_catvcfg_language[b.getAttribute("BindText")];
	}
    
    if ('0' == isRfOn )
	{
		setDisable('enableid', 1);
		getElById('EnableNote').className = "gray";
	}
	else
	{
	    setCheck('enableid', RfPortInfos[0].Enable);
	}	

}




function RfPortInfo(domain,Enable)
{
	this.domain	= domain;
	this.Enable 	= Enable; 
}

var RfPortInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_CATVConfiguration, Enable, RfPortInfo);%>;


function EnableSubmit()
{
    var Form = new webSubmitForm();
    var enable = getCheckVal('enableid');
    Form.addParameter('x.Enable',enable);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_CATVConfiguration'
                                + '&RequestFile=html/amp/catvcfg/catvcfg.asp');

    Form.submit();
}



</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>                   
          <td class="title_common" BindText='amp_catvcfg_desc'></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td></tr>
	<tr><td>
	<input type="checkbox" id="enableid"  onClick="EnableSubmit()" value="ON">
	<span id='EnableNote'>
    <script>document.write(status_catvcfg_language['amp_catvcfg_portenable']);</script>
	</span>
    </input>
    </td></tr>
</table>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr >
<td class="height_10p">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
</td>
</tr>
</table>
</body>

</html>
