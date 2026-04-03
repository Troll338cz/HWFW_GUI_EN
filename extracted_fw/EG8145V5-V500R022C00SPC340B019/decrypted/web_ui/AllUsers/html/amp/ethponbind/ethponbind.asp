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
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
    
<script language="JavaScript" type="text/javascript">

var landhcpenable ='<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_UNI_CTL);%>';

function XHWLANEthernetPortConfig(domain,BindPonLinkEnable)
{
	this.domain	= domain;
	this.BindPonLinkEnable 	= BindPonLinkEnable; 
}

var XHWLANEthernetPortConfigs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_LANEthernetPortConfig.{i}, BindPonLinkEnable, XHWLANEthernetPortConfig);%>;


function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = ethponbind_language[b.getAttribute("BindText")];
	}
}

function LoadFrame() 
{
    for (var i = 1; i < XHWLANEthernetPortConfigs.length ; i++)
	{
		var cbLanid =  'cbLan' + i;
		
	    setCheck(cbLanid, XHWLANEthernetPortConfigs[i-1].BindPonLinkEnable);
    }
	
	loadlanguage();
}

function ChangeLanState()
{
    var Form = new webSubmitForm();
    var domain = "";
	var alertflag = 1;
	var checkval = 0;
  
    for (var i = 1; i <= XHWLANEthernetPortConfigs.length - 1; i++)
    {
        domain +=  '&LAN'+i+'='+ XHWLANEthernetPortConfigs[i-1].domain;
        Form.addParameter('LAN'+i+'.BindPonLinkEnable',getCheckVal('cbLan'+i+''));
		if (0 == getCheckVal('cbLan'+i+''))
		{
		    alertflag = 0;
		}		
    }
	if (1 == alertflag)
	{
	    if (false == ConfirmEx(ethponbind_language['amp_ethponbind_notify'])) 
        {
		    LoadFrame();
            return;
        }
	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    domain = domain.substr(1,domain.length-1);

    Form.setAction('set.cgi?' + domain
						 + '&RequestFile=html/amp/ethponbind/ethponbind.asp');
    Form.submit();
}

function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("amp_ethponbind_desc", 
	GetDescFormArrayById(ethponbind_language, "amp_ethponbind_head"), 
	GetDescFormArrayById(ethponbind_language, "amp_ethponbind_desc"), false);
</script>

<table> 
  <form action="" id="ConfigForm"> 
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1"> 
      <tr id="secUsername" class='align_left'>			
        <script type="text/javascript" language="javascript">			
		var lanid;
	    for(i=0; i < XHWLANEthernetPortConfigs.length - 1; i++)
	    {	
			lanid = i+1;
		    portid = "LAN" + lanid;
		    cbLanid = "cbLan"+  lanid;
			
		    document.write('<td>');
		    document.write('<input type="checkbox" id=' + cbLanid + ' name=' + cbLanid + ' value=' + portid + '>' + portid);
		    document.write('</td>');
        }
		</script>
      </tr> 
    </table> 
    <table width="100%" border="0"  cellpadding="0" cellspacing="0"> 
      <tr > 
	    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <td class='title_bright1'> <button id='Apply' name="button" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="ChangeLanState();" ><script>document.write(ethponbind_language['amp_ethponbind_apply']);</script></button> 
          <button id='Cancel' name="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(ethponbind_language['amp_ethponbind_cancel']);</script></button> </td> 
      </tr> 
    </table> 
  </form> 
</table>
</body>
</html>
