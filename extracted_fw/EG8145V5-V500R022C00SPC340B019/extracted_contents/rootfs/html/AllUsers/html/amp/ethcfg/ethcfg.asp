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
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>Eth Port Configration</title>
<script language="JavaScript" type="text/javascript">

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var isOpticUpMode = '<%HW_WEB_IsOpticUpMode();%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var isOpticOn = '<%HW_WEB_IsOpticExist();%>'; 
var acEthType = '<%HW_WEB_GetEthTypeList();%>'; 
var opticPN = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.VendorPN);%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var AisApRtFlag = '<%HW_WEB_GetFeatureSupport(AMP_FT_AISAP);%>';

var sleep = function(time) {
    var startTime = new Date().getTime() + parseInt(time, 10);
    while(new Date().getTime() < startTime) {}
};

function ExtPortInfo(domain,Enable,Mode,Speed)
{
	this.domain	= domain;
	this.Enable 	= Enable; 
	this.Mode 	= Mode;
	this.Speed 	= Speed; 
}

var ExtPortInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, Enable|DuplexMode|MaxBitRate,ExtPortInfo);%>;

function WanEthInfo(domain,Enable,Mode,Speed)
{
	this.domain	= domain;
	this.Enable 	= Enable; 
	this.Mode 	= Mode;
	this.Speed 	= Speed; 
}

var WanEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANEthernetInterfaceConfig, Enable|DuplexMode|MaxBitRate, WanEthInfo);%>;

var ontAccessMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';

function grayDisplayLastEnableEth()
{
	var loop = 0;
	var enablePortNum = 0;
	var lastLanId = 0;
	
	if (6 == ExtPortInfos.length)
	{
		if('0' == isOpticUpMode)
		{
			loop = 4;
		}
		else
		{
			loop = 5;
		}
	}
	else if ("ge" == ontAccessMode)
	{
		loop = ExtPortInfos.length - 2;
	}	
	else
	{
		loop = ExtPortInfos.length - 1;
	}
	
	for(var i = 0; i < loop; i++)
	{
		if('1' == ExtPortInfos[i].Enable)
		{
			enablePortNum++;
			lastLanId = i + 1;
		}
	}
	if(1 == enablePortNum)
	{
		var enblid =  'ethEnbl' + lastLanId;
		var duplexModeid = "duplexMode" + lastLanId;
		var portSpeedid = "portSpeed" + lastLanId
		
	
		setCheck(enblid, ExtPortInfos[lastLanId - 1].Enable);
		setSelect(duplexModeid,ExtPortInfos[lastLanId - 1].Mode);
		setSelect(portSpeedid,ExtPortInfos[lastLanId - 1].Speed);
			
		setDisable(enblid, 1);
		setDisable(duplexModeid, 1);
		setDisable(portSpeedid, 1);
	}
	
}

function displayWanConfig()
{
    if (AisApRtFlag == '1') {
        setDisplay("eth_cfg_wan", 0);
    }
}

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

		b.innerHTML = status_ethcfg_language[b.getAttribute("BindText")];
	}

	if (AisApRtFlag == '1' && ExtPortInfos.length < 5) {
		window.location.replace("ethcfg.asp");
		ExtPortInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, Enable|DuplexMode|MaxBitRate,ExtPortInfo);%>;
    }

    for (var i = 0; i < ExtPortInfos.length ; i++)
	{
		
		var lanid = i + 1;
		var enblid =  'ethEnbl' + lanid;
		var duplexModeid = "duplexMode" + lanid;
		var portSpeedid = "portSpeed" + lanid
	
        if ((lanid < ExtPortInfos.length) && (4 != i))
		{
			setCheck(enblid, ExtPortInfos[i].Enable);
    	    setSelect(duplexModeid,ExtPortInfos[i].Mode);
			setSelect(portSpeedid,ExtPortInfos[i].Speed);
		}

		if (6 == ExtPortInfos.length)
		{
			if (i == 4)
			{
				setCheck(enblid, ExtPortInfos[i].Enable);
	    	    setSelect(duplexModeid,ExtPortInfos[i].Mode);
				setSelect(portSpeedid,ExtPortInfos[i].Speed);
	            if ('0' == isOpticUpMode)
				{
					setDisable(enblid, 1);
					setDisable(duplexModeid, 1);
					setDisable(portSpeedid, 1);
					getElById('EnableNote5').className = "gray";
					getElById('ExtNote').className = "gray";
				}
			}
			
			if(i == 5)
			{
			    setCheck(enblid, WanEthInfos[0].Enable);
				setSelect(duplexModeid,WanEthInfos[0].Mode);
				setSelect(portSpeedid,WanEthInfos[0].Speed);
				if (('1' == isOpticUpMode) && ('0' == isOpticOn))
				{
					setDisable(enblid, 1);
					setDisable(duplexModeid, 1);
					setDisable(portSpeedid, 1);
					getElById('EnableNote6').className = "gray";
					getElById('WanNote').className = "gray";
				}
				if (opticPN.indexOf('HW-BOB') == 0)
				{
					setDisable(duplexModeid, 1);
					setDisable(portSpeedid, 1);
			    	}
			}
		}
		else
		{
			if ((lanid == ExtPortInfos.length - 1) && ("ge" == ontAccessMode))
			{
			    setCheck('ethEnbl6', WanEthInfos[0].Enable);
			    setSelect('duplexMode6',WanEthInfos[0].Mode);
			    setSelect('portSpeed6',WanEthInfos[0].Speed);
			    if (opticPN.indexOf('HW-BOB') == 0)
			    {
                    if (AisApRtFlag != '1') {
                        setSelect('duplexMode6','Auto');
                        setDisable('duplexMode6',1);
                        setSelect('portSpeed6','Auto');
                        setDisable('portSpeed6',1);
                    }
                }
            }
        }
    }


	grayDisplayLastEnableEth();
	if (6 == ExtPortInfos.length)
	{
		getElById("eth_cfg_ext1").style.display = "";
		getElById("eth_cfg_wan").style.display = "";
	}
	else if ("ge" == ontAccessMode)
	{
		getElById("eth_cfg_wan").style.display = "";
	}

    displayWanConfig();
}

function getLanInstById(id)
{
    if ('' != id)
    {
        return parseInt(id.charAt(id.length - 1));    
    }
}

function EnableSubmit(enableid)
{
    var Form = new webSubmitForm();
	var lanid = getLanInstById(enableid);
    var enable = getCheckVal(enableid);
    Form.addParameter('x.Enable',enable);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	if (lanid < ExtPortInfos.length)
	{
    Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.'
	                              + lanid
                                + '&RequestFile=html/amp/ethcfg/ethcfg.asp');
	}
	else
	{
	    Form.setAction('set.cgi?x=InternetGatewayDevice.WANDevice.1.WANEthernetInterfaceConfig'
                                + '&RequestFile=html/amp/ethcfg/ethcfg.asp');
	}
    Form.submit();
}

function DuplexModeChange(tagid)
{
    var Form = new webSubmitForm();
	var lanid = getLanInstById(tagid);
    var mode = getSelectVal(tagid);
	var speed = getSelectVal("portSpeed" + lanid);
    Form.addParameter('x.DuplexMode',mode);
	Form.addParameter('x.MaxBitRate',speed);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	if (lanid < ExtPortInfos.length)
	{
        Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.'
	                            + lanid
                                + '&RequestFile=html/amp/ethcfg/ethcfg.asp');
    }
	else
	{
	    Form.setAction('set.cgi?x=InternetGatewayDevice.WANDevice.1.WANEthernetInterfaceConfig'
                                + '&RequestFile=html/amp/ethcfg/ethcfg.asp');
	}
    Form.submit();
}


function PortSpeedChange(tagid)
{
    var Form = new webSubmitForm();
	var lanid = getLanInstById(tagid);
    var speed = getSelectVal(tagid);
    var tr181_speed = speed;
	var mode = getSelectVal("duplexMode" + lanid);

    if (speed == 'Auto')
    {
        tr181_speed = -1;
    }

    Form.addParameter('x.DuplexMode',mode);
    Form.addParameter('x.MaxBitRate',speed);
    if (AisApRtFlag != '1') {
        Form.addParameter('x.X_TR181_MaxBitRate',tr181_speed);
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	if (lanid < ExtPortInfos.length)
	{
        Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.'
	                            + lanid
                                + '&RequestFile=html/amp/ethcfg/ethcfg.asp');
	}
	else
	{
	    Form.setAction('set.cgi?x=InternetGatewayDevice.WANDevice.1.WANEthernetInterfaceConfig'
                                + '&RequestFile=html/amp/ethcfg/ethcfg.asp');
	}
    
    Form.submit();
}


</script>

</head>
<body onLoad="LoadFrame();" class="mainbody">
<div>
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("eth", GetDescFormArrayById(status_ethcfg_language, "amp_ethcfg_head"), GetDescFormArrayById(status_ethcfg_language, "amp_ethcfg_desc"), false);
</script> 
<div class="title_spread"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td></tr> </table>
<div style="overflow:auto;overflow-y:hidden"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_ethcfg_title'></td>
    </tr>
</table>
<table id="eth_cfg_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
	<tr class="head_title">
    <td BindText='amp_ethcfg_portnum'></td>
	<td BindText='amp_ethcfg_portenable'></td>
    <td BindText='amp_ethcfg_duplex'></td>
    <td BindText='amp_ethcfg_speed'></td>
	</tr>
                    
    <script type="text/javascript" language="javascript">
	if (AisApRtFlag == '1') {
		sleep(1000); // 延时函数，单位ms
		ExtPortInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, Enable|DuplexMode|MaxBitRate,ExtPortInfo);%>;
    }
	var lanid,duplexModeid,portSpeedid;

	for(i=0; i < ExtPortInfos.length - 1; i++)
	{
	    lanid = i+1;
		portid = "LAN" + lanid;
		enableid = "ethEnbl"+  lanid;
		duplexModeid = "duplexMode" + lanid;
		portSpeedid = "portSpeed" + lanid
			
		if((lanid >= ExtPortInfos.length - 1) && (5 != ExtPortInfos.length))
		{
		    break;
		}
		if (lanid == UpUserPortID)
        {
            break;
        }
        
		if(i%2 == 0)
		{
		    document.write("<tr class=\"tabal_01\" align=\"center\">");
		}
		else
		{
		    document.write("<tr class=\"tabal_02\" align=\"center\">");
		}
              if (stbport == lanid)
              {
        		document.write('<td>'+  status_ethinfo_language['amp_port_inner_stb']	+'</td>');
              }
              else
              {
        		document.write('<td>'+  portid	+'</td>');
              }
        document.write('<td>');
		document.write('<input type="checkbox" id=' + enableid + ' onClick="EnableSubmit(this.id)" value="ON">');
		document.write(status_ethcfg_language['amp_ethcfg_portenable']);
		document.write('</td>');
		

		document.write('<td>');
        document.write('<select id=' + duplexModeid + ' size="1" onChange="DuplexModeChange(this.id)" class="width_100px">');
	    document.write('<option value="Auto">' + status_ethcfg_language["amp_port_auto"] + '</option>');
		document.write('<option value="Full">' + status_ethcfg_language["amp_port_full"] + '</option>');
		document.write('<option value="Half">' + status_ethcfg_language["amp_port_half"] + '</option>'); 
	    document.write('</select></td>');

	    document.write('<td>');
        document.write('<select id=' + portSpeedid + ' size="1" onChange="PortSpeedChange(this.id)"  class="width_100px">');
	    document.write('<option value="Auto">' + status_ethcfg_language["amp_port_auto"] + '</option>');
		document.write('<option value="10">' + status_ethcfg_language["amp_port_10M"] + '</option>');
		document.write('<option value="100">' + status_ethcfg_language["amp_port_100M"] + '</option>');
		if ('1' != acEthType.charAt(lanid))
		{
		    document.write('<option value="1000">' + status_ethcfg_language["amp_port_1000M"] + '</option>'); 
		}
	    document.write('</select></td>');


		document.write("</tr>");
	   
	}
	</script>

	<tr class="tabal_01" align="center" id="eth_cfg_ext1" style="display:none">
	  <td id='ExtNote' BindText='amp_ethcfg_ext1'></td>  
	  <td><input type='checkbox' name='ethEnbl5' id='ethEnbl5' onClick='EnableSubmit(this.id)' value="ON">
	  <span id='EnableNote5'>
		<script>document.write(status_ethcfg_language['amp_ethcfg_portenable']);</script>
	  </span>
	  </input>
	  </td>
	  <td>
      <select id='duplexMode5' name='duplexMode5' size='1' onChange='DuplexModeChange(this.id)' class='width_100px'>
	  <option value="Auto"><script>document.write(status_ethcfg_language['amp_port_auto']);</script></option> 
      <option value="Full"><script>document.write(status_ethcfg_language['amp_port_full']);</script></option>
	  <option value="Half"><script>document.write(status_ethcfg_language['amp_port_half']);</script></option>
      </select>
	  </td> 
	  <td>
	  <select id='portSpeed5' name='portSpeed5' size='1' onChange='PortSpeedChange(this.id)' class='width_100px'>
	  <option value="Auto"><script>document.write(status_ethcfg_language['amp_port_auto']);</script></option>
	  <option value="10"><script>document.write(status_ethcfg_language['amp_port_10M']);</script></option>
      <option value="100"><script>document.write(status_ethcfg_language['amp_port_100M']);</script></option>
      <script>
        if((parseInt(acEthType.charAt(0)) >= 5 )
          && ('1' != acEthType.charAt(5)) )
        {
         	document.write('<option value="1000">' + status_ethcfg_language["amp_port_1000M"] + '</option>'); 
        }
       </script>
      </select>
	  </td>                    
    </tr>
	<tr class="tabal_02" align="center"  id="eth_cfg_wan" style="display:none">
	  <td id='WanNote' BindText='amp_ethcfg_wan'></td>  
	  <td><input type='checkbox' name='ethEnbl6' id='ethEnbl6' onClick='EnableSubmit(this.id)' value="ON">
	  <span id='EnableNote6'>
      <script>document.write(status_ethcfg_language['amp_ethcfg_portenable']);</script>
	  </span>
	  </input>
	  </td>
	  <td>
      <select id='duplexMode6' name='duplexMode6' size='1' onChange='DuplexModeChange(this.id)' class='width_100px'>
	  <option value="Auto"><script>document.write(status_ethcfg_language['amp_port_auto']);</script></option> 
      <option value="Full"><script>document.write(status_ethcfg_language['amp_port_full']);</script></option>
	  <option value="Half"><script>document.write(status_ethcfg_language['amp_port_half']);</script></option>
      </select>
	  </td> 
	  <td>
	  <select id='portSpeed6' name='portSpeed6' size='1' onChange='PortSpeedChange(this.id)' class='width_100px'>
	  <option value="Auto"><script>document.write(status_ethcfg_language['amp_port_auto']);</script></option>
	  <script>
		if ('1' != isOpticUpMode)
		{
		    document.write('<option value="10">' + status_ethcfg_language["amp_port_10M"] + '</option>'); 
		}
	  </script>
		<option value="100"><script>document.write(status_ethcfg_language['amp_port_100M']);</script></option>
	  <script>
		if (('1' != isOpticUpMode) && (6 == ExtPortInfos.length ))
		{
	        if((parseInt(acEthType.charAt(0)) >= 5 ) && ('1' != acEthType.charAt(5)))
	        {
	         	document.write('<option value="1000">' + status_ethcfg_language["amp_port_1000M"] + '</option>'); 
	        }
	    }
	    else
	    {
		    document.write('<option value="1000">' + status_ethcfg_language["amp_port_1000M"] + '</option>'); 
	    }
	  </script>

      </select>
	  </td>
	</tr>

</table>
</div>

<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr >
<td class="height_10p">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
</td>
</tr>
</table>
</body>

</html>
