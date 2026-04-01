<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/ontstate.asp"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script> 
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list.asp);%>"></script>
<script language="javascript" src="../../amp/common/<%HW_WEB_DeepCleanCache_Resource(wlan_list.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">

var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';

function IsAdminUser()
{
    return (curUserType == sysUserType);
}

var wan = GetWanList();
var PPPwanInfo = new Array();

function GetFirstPPPoEWanByType(type)
{
	for(var i=0;i<wan.length;i++)
	{
		if ((wan[i].ServiceList.indexOf(type) >= 0 ) && (wan[i].EncapMode == "PPPoE")&&(wan[i].Mode == "IP_Routed") )
		{
			return wan[i];
		}
	}	
	return "";
}

function InitServiceData()
{
	var internet = GetFirstPPPoEWanByType("INTERNET");

	if(internet != "")
	{
		PPPwanInfo.push(internet);
	}
}

InitServiceData();


function DrawWanMenu()
{			
	if(PPPwanInfo.length == 0)
	{
		document.write('<table width=\"100%\" border=\"0\" cellspacing=\"10\" cellpadding=\"0\" class=\"tabal_bg\">');		
		document.write('<tr>');
		document.write('<td class=\"table_title width_per25\" >No PPPoE Internet WAN, please <a href=\"http://ftthportal.o3-telecom.com\" target=\"_blank\" style=\"color:blue;\">click here</a>. ');	
		document.write('</td>');				
		document.write('</tr>');
		document.write('</table>');
	}
	
	for (var i=0; i<PPPwanInfo.length; i++)
	{
		var viewusrnm = ParseUsernameForIraq(PPPwanInfo[i].UserName);
	
		document.write('<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_bg">');		
		document.write('<tr>');
		document.write('<td class="table_title width_per25" >' +Languages['IPv4UserName'] +'</td>');
		document.write('<td class=\"table_right\">'+ '<input name=\"username' + i + '\" type=\"text\" maxLength=\"63\" id=\"username' + i + '\" size=\"15\" value=\"' + viewusrnm + '\">');		
		if( false == IsAdminUser() )
		{
			document.write('<font class="gray">'+'@o3-telecom.com'+'</font>');
		}
		document.write('<font class="color_red">*</font>');
		document.write('</td>');				
		document.write('</tr>');
		document.write('<tr>');
		document.write('<td class="table_title width_per25" >' +Languages['IPv4Password'] +'</td>');
		document.write('<td class=\"table_right\">' + '<input name=\"password'+i +'\" type=\"password\" autocomplete=\"off\" maxLength=\"63\" id=\"password' + i +'\" size=\"15\" value=\"' + PPPwanInfo[i].Password+'\">'+'<font class="color_red">*</font>'+'</td>');
		document.write('</tr>');
		document.write('</table>');		
		document.write('<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="table_button"><tr> ');
		document.write('<td class="table_submit width_per25" width="25%"></td>');
		document.write('<td class="table_submit">');
		document.write('<input type="hidden" name="onttoken" id="hwonttoken" value="'+'<%HW_WEB_GetToken();%>'+'">');
		document.write('<button type="button" id="btnSubmit" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitPara();">Submit</button>');
		document.write('</td></tr></table>');	
	}
}

function SubmitWanMenu(Form)
{
	var i=0;
	for (i=0; i<PPPwanInfo.length; i++)
	{
		if( true != IsAdminUser())
		{
			Form.addParameter('y'+i+'.Username', getValue('username'+i)+'@o3-telecom.com');			
		}
		else
		{
			Form.addParameter('y'+i+'.Username', getValue('username'+i));
		}
		
		if(PPPwanInfo[i].Password != getValue('password'+i) )
		{
			Form.addParameter('y'+i+'.Password', getValue('password'+i));
		}
	}
}

function SubmitPara()
{	
    var Form = new webSubmitForm();
	SubmitWanMenu(Form);
		
	setDisable('btnSubmit', 1);

    url = 'complex.cgi?';
	
	for (var j=0; j<PPPwanInfo.length; j++)
	{
		url += '&y'+j+'='+PPPwanInfo[j].domain;
	}
			
    url += '&RequestFile=html/bbsp/wan/recharge.asp';
	Form.setAction(url);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

</script>
</head>

<body class="mainbody" onLoad="">
<br>

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_noborder_bg">
    <tr class="tabal_head">
        <td class='block_title' colspan="2">Please enter your card username and password</td>
    </tr>

</table>


<div id="id_config">

<script language="JavaScript" type="text/javascript">
	DrawWanMenu();
</script> 

</div>

</body>
</html>
