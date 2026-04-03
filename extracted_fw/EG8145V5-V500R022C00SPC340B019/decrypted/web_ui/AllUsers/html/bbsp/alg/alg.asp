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
<title>ALG</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, alg_language);%>"></script>
<script language="JavaScript" type="text/javascript">
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var dbaa1SuperSysUserType = '2';
var maxisLocalUserType = '1';

function IsAdminUser()
{
    if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
    }
    return curUserType == sysUserType;
}

function IsMaxisLocalUser()
{
	if ((CfgModeWord.toUpperCase() == 'DETHMAXIS') && (curUserType == maxisLocalUserType)) {
		return true;
	}

	return false;
}

function IsPtvdfSuperUser()
{
	if ((IsPTVDFFlag == 1) && IsAdminUser())
    {
    	return true;
    }
	else
	{
		return false;
	}
}

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
		b.innerHTML = alg_language[b.getAttribute("BindText")];
	}
}

function stAlg(domain,FTPEnable,TFTPEnable,H323Enable,PptpEnable,L2TPForward,IPSecForward,SipEnable,RTSPEnable,RTCPEnable,RTCPPort)
{
	this.domain = domain;	
	this.FTPEnable = FTPEnable;
	this.TFTPEnable = TFTPEnable;
	this.H323Enable = H323Enable;
	this.PptpEnable = PptpEnable;
	this.L2TPForward = L2TPForward;	
	this.IPSecForward = IPSecForward;
	this.SipEnable  = SipEnable;
	this.RTSPEnable = RTSPEnable;			
	this.RTCPEnable = RTCPEnable;
	this.RTCPPort = RTCPPort;
} 
var algArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_ALG,FtpEnable|TftpEnable|H323Enable|PptpEnable|L2TPForward|IPSecForward|SipEnable|RTSPEnable|RTCPEnable|RTCPPort,stAlg);%>;  
var alg = algArray[0];

function stAlgInfo(domain,ALGType,IPPortocolVersion,Portocol,PortRange)
{
	this.domain = domain;	
	this.ALGType = ALGType;
	this.IPPortocolVersion = (IPPortocolVersion.length == 0)?"--":IPPortocolVersion;
	this.Portocol = (Portocol.length == 0)?"--":Portocol;
	this.PortRange = (PortRange.length == 0)?"--":PortRange;
} 

var algInfoArray = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_GeALGInfo,InternetGatewayDevice.X_HW_ALG.ALGInfo.{i},ALGType|IPProtocolVersion|Protocol|PortRange,stAlgInfo);%>;  
if(null == algInfoArray)
{
	algInfoArray = new stAlgInfo("", "", "", "", "");
}

function IsSonetUser()
{
    if ((SonetFlag == '1') && (IsAdminUser() == false)) {
        return true;
    } else {
        if (CfgModeWord.toUpperCase() == 'BJUNICOM') {
            return true;
        }
        return false;
    }
}

function IsTelmexOpenAccess()
{
    return ((CfgModeWord.toUpperCase() == 'TELMEXVULA') ||
            (CfgModeWord.toUpperCase() == 'TELMEXACCESS') ||
            (CfgModeWord.toUpperCase() == 'TELMEXACCESSNV') ||
            (CfgModeWord.toUpperCase() == 'TELMEXRESALE')) ? true : false;
}

function rtspEnableClick()
{
	var bEnable = getCheckVal('RTSPEnable');
	setDisplay('rtcptable_div', bEnable);
}

function SetCtrlPanelEnable(iDisable)
{
	setDisable("FTPEnable", iDisable);
	setDisable("TFTPEnable", iDisable);			
	setDisable("H323Enable", iDisable);
	setDisable("PptpEnable", iDisable);
	setDisable("L2TPForward", iDisable);
	setDisable("IPSecForward", iDisable);
	setDisable("SipEnable", iDisable);
	setDisable("RTSPEnable", iDisable);
	setDisable("RTCPEnable", iDisable);
	setDisable("RTCPPort", iDisable);
	setDisable("btnApply", iDisable);
	setDisable("cancelValue", iDisable);
}

function LoadFrame()
{
	with (getElement('ConfigForm'))
	{
	    if (alg != null)
		{
    		setCheck('FTPEnable',alg.FTPEnable);
    		setCheck('TFTPEnable',alg.TFTPEnable);
    		setCheck('H323Enable',alg.H323Enable);
			setCheck('PptpEnable',alg.PptpEnable);
			setCheck('L2TPForward',alg.L2TPForward);
			setCheck('IPSecForward',alg.IPSecForward);

			setCheck('SipEnable',alg.SipEnable);
			setCheck('RTSPEnable',alg.RTSPEnable);						
			setCheck('RTCPEnable',alg.RTCPEnable);
			setText('RTCPPort', alg.RTCPPort)
			rtspEnableClick();
        }
	} 
	
	if(IsAdminUser() == false)
	{
		if ((IsSonetUser() == false) &&
			(['PERUCLARO', 'DGRWIND', 'DMASMOVIL2WIFI', 'DAUM2WIFI', 'ROSUNION', 'HT', 'DNOVA2WIFI'].indexOf(CfgModeWord.toUpperCase()) < 0)) {
			SetCtrlPanelEnable(1);
		}
	}

	if (CfgModeWord.toUpperCase() == 'TS2WIFI') {
		SetCtrlPanelEnable(0);
	}
	
	if(IsTelmexOpenAccess())
	{
		SetCtrlPanelEnable(1);
	}
	if (IsMaxisLocalUser()) {
		SetCtrlPanelEnable(0);
	}
	loadlanguage(); 
}

function ApplySubmit(type)
{
	if(IsTelmexOpenAccess())
	{
		return false;
	}
	
	if (CheckForm(type) == true)
	{
		var Form = new webSubmitForm();
		AddSubmitParam(Form,type);
		Form.submit();
	}
}

function AddSubmitParam(SubmitForm,type)
{
	var RTCPPort = getValue("RTCPPort");
	RTCPPort = removeSpaceTrim(RTCPPort);
	
	SubmitForm.addParameter('x.FtpEnable',getCheckVal('FTPEnable'));
	SubmitForm.addParameter('x.TftpEnable',getCheckVal('TFTPEnable'));
	SubmitForm.addParameter('x.H323Enable',getCheckVal('H323Enable'));
	SubmitForm.addParameter('x.SipEnable',getCheckVal('SipEnable'));
	SubmitForm.addParameter('x.RTSPEnable',getCheckVal('RTSPEnable'));
	SubmitForm.addParameter('x.PptpEnable',getCheckVal('PptpEnable'));
	SubmitForm.addParameter('x.L2TPForward',getCheckVal('L2TPForward'));
	SubmitForm.addParameter('x.IPSecForward',getCheckVal('IPSecForward'));
	SubmitForm.addParameter('x.RTCPEnable',getCheckVal('RTCPEnable'));
	SubmitForm.addParameter('x.RTCPPort',RTCPPort);
	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));

	SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.X_HW_ALG'
		                     + '&RequestFile=html/bbsp/alg/alg.asp');
    setDisable('btnApply',1);
    setDisable('cancelValue',1);
}

function CheckForm(type)
{
	var RTCPPort = getValue("RTCPPort");
	RTCPPort = removeSpaceTrim(RTCPPort);
	if(RTCPPort!="")
	{
       if ( false == CheckNumber(RTCPPort, 0, 65535) )
       {
         AlertEx(alg_language['bbsp_portranginvalid']);
         return false;
       }
    }
    else
    {
  	   RTCPPort = 0;
    }
    return true;
}

function ChangeLevel(level)
{		

}

function CancelConfig()
{
    LoadFrame();
}

function GetAlgIndex(MODE)
{
    for (var i = 0; i <algInfoArray.length-1 ; i++) 
	{
		if(algInfoArray[i].ALGType.toUpperCase() == MODE.toUpperCase())
		{
			return i;
		}
	}
	
	return -1;
}

function GetIpVersion(IpIndx)
{
	var IPPVesion ="";
	
	switch (IpIndx)
	{
		case "1":
			IPPVesion = "IPv4";
			break;
		case "2":
			IPPVesion = "IPv4/IPv6";
			break;
		default:
			break;
	}
	
	return IPPVesion;
}

function ShowInfo(MODE)
{
	var Index = GetAlgIndex (MODE);
	if(-1 == Index)
	{
		document.write("<td class='table_right width_per20'>");
		document.write(" -- " + '</td>');
		document.write("<td class='table_right width_per25'>");
		document.write(" -- " + '</td>');
		document.write("<td class='table_right width_per15'>");
		document.write(" -- " + '</td>');
	}
	else
	{
		var IPVesion =GetIpVersion(algInfoArray[Index].IPPortocolVersion);
		document.write("<td class='table_right width_per20'>");
		document.write(IPVesion+ '</td>');
		document.write("<td class='table_right width_per25'>");
		document.write(htmlencode(algInfoArray[Index].Portocol) + '</td>');
		document.write("<td class='table_right width_per15'>");
		document.write(htmlencode(algInfoArray[Index].PortRange) + '</td>');
		
	}	
}

</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
<form id="ConfigForm" action="">
	<script language="JavaScript" type="text/javascript">
		HWCreatePageHeadInfo("algtitle", GetDescFormArrayById(alg_language, "bbsp_mune"), GetDescFormArrayById(alg_language, "bbsp_alg_title"), false);
	</script>
	<div class="title_spread"></div>
  
    <table class="tabal_bg" width="100%" cellpadding="0" cellspacing="1">
	    <script type="text/javascript" language="javascript">

	    if( true == IsPtvdfSuperUser() )
		{
			document.write("<tr class='head_title' style='text-align: left'>");
			document.write('<td>' + alg_language['bbsp_algname'] + '</td>');       
	        document.write('<td>' + alg_language['bbsp_algenable'] + '</td>');       
	        document.write('<td>' + alg_language['bbsp_ipprotocol'] + '</td>');        
	        document.write('<td>' + alg_language['bbsp_transprotocol'] + '</td>');
			document.write('<td>' + alg_language['bbsp_portnumber'] + '</td>');
			document.write("</tr>");
		}
		</script>

        <tr class="tabal_01">
            <td class="table_title width_per25" width="25%" BindText='bbsp_enableftpmh'></td>
            <td class="table_right"> 
                <input type='checkbox'  id='FTPEnable' name='FTPEnable' />
            </td>

            <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{				
				ShowInfo("FTP");
			}
			</script>
        </tr>

        <tr class="tabal_01">
            <td class="table_title" BindText='bbsp_enabletftpmh'></td>
            <td class="table_right"> 
                <input type='checkbox'  id='TFTPEnable' name='TFTPEnable' />
            </td>
             <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{
				ShowInfo("TFTP");
			}
			</script>
        </tr>
        
        <tr class="tabal_01">
            <td class="table_title" BindText='bbsp_enableh323mh'></td>
            <td class="table_right"> 
                <input type='checkbox'  id='H323Enable' name='H323Enable' />
            </td>
             <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{
				ShowInfo("H323");
			}
			</script>
        </tr>     
        <tr class="tabal_01">
            <td class="table_title" BindText='bbsp_enablesipmh'></td>
            <td class="table_right"> 
                <input type='checkbox'  id='SipEnable' name='SipEnable' />
            </td>

			<script type="text/javascript" language="javascript">	
		    if( true == IsPtvdfSuperUser() )
			{
				ShowInfo("SIP");
			}
			</script>
        </tr> 
        
        <tr class="tabal_01">
            <td class="table_title" BindText='bbsp_enablertspmh'></td>
            <td class="table_right"> 
                <input type='checkbox' id='RTSPEnable' name='RTSPEnable'  onclick='rtspEnableClick();'/>
            </td>
             <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{
				ShowInfo("RTSP");
			}
			</script>
        </tr> 
	</table>
	<div id="rtcptable_div">
		<table class="tabal_bg" width="100%" cellpadding="0" cellspacing="1">
        <tr class="tabal_01">
            <td class="table_title width_per25" BindText='bbsp_enablertcpmh'></td>
            <td class="table_right"> 
  				<input type='checkbox' id='RTCPEnable' name='RTCPEnable' /> 
		    
			<script type="text/javascript" language="javascript">	
		    if( false == IsPtvdfSuperUser() )
			{	
				document.write('<LABEL>'+alg_language['bbsp_nport']+'</LABEL>');
				document.write('<input type="text" id="RTCPPort" name="RTCPPort" maxlength="5" class="width_per25" />');
	    	}
			document.write("</td>");	
		    if( true == IsPtvdfSuperUser() )
			{
				var Index = GetAlgIndex ("RTCP");
				var IPVesion = GetIpVersion(algInfoArray[Index].IPPortocolVersion);
				document.write("<td class='table_right width_per20'>");
				document.write(IPVesion+ '</td>');
		        document.write("<td class='table_right width_per25'>");
				document.write(htmlencode(algInfoArray[Index].Portocol)+ '</td>');	
				document.write("<td class='table_right width_per15'>");
				document.write('<input type="text" id="RTCPPort" name="RTCPPort" maxlength="5" class="width_per90" />');
				document.write("</td>");
			}
			</script>
        </tr>                     
      </table>
	</div>
	<table class="tabal_bg" width="100%" cellpadding="0" cellspacing="1">
        <tr class="tabal_01">
            <td class="table_title width_per25" BindText='bbsp_enablepptpmh'></td>
            <td class="table_right"> 
                <input type='checkbox' id='PptpEnable' name='PptpEnable' />
            </td>
             <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{
		     	ShowInfo("Pptp");
			}
			</script>
        </tr> 
		
	    <tr class="tabal_01">
            <td class="table_title width_per25" BindText='bbsp_enablel2tpmh'></td>
            <td class="table_right"> 
                <input type='checkbox' id='L2TPForward' name='L2TPForward' />
            </td>
             <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{
				ShowInfo("L2TP");
			}
			</script>
        </tr> 

        <tr class="tabal_01">
            <td class="table_title width_per25" BindText='bbsp_enableipsecmh'></td>
            <td class="table_right"> 
                <input type='checkbox' id='IPSecForward' name='IPSecForward' />
            </td>
             <script type="text/javascript" language="javascript">
	
		    if( true == IsPtvdfSuperUser() )
			{
				ShowInfo("IpSec");
			}
			</script>
        </tr> 	
		<script>
			getElById('FTPEnable').title = alg_language['bbsp_ftptitle'];
			getElById('TFTPEnable').title = alg_language['bbsp_tftptitle'];
			getElById('H323Enable').title = alg_language['bbsp_h323title'];
			getElById('SipEnable').title = alg_language['bbsp_siptitle'];
			getElById('RTSPEnable').title = alg_language['bbsp_rtsptitle'];
			getElById('RTCPEnable').title = alg_language['bbsp_rtcptitle'];
			getElById('RTCPPort').title = alg_language['bbsp_rtctitle'];
			getElById('PptpEnable').title = alg_language['bbsp_pptptitle'];
			getElById('L2TPForward').title = alg_language['bbsp_l2tptitle'];
			getElById('IPSecForward').title = alg_language['bbsp_ipsectitle'];
		</script>

    </table>
   <table cellpadding="0" cellspacing="1" width="100%" class="table_button">
     <tr >
	       <td class='width_per25'></td>
            <td class="table_submit">
			    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <button id="btnApply" name="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="ApplySubmit(1);"><script>document.write(alg_language['bbsp_app']);</script></button>
                <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(alg_language['bbsp_cancel']);</script></button>
            </td>
           
        </tr>
        <tr> 
        	<td  style="display:none"> <input type='text'> </td> 
        </tr>
   </table>
</form>
</body>
</html>
