<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<title>Eth Port Configration</title>
<script language="JavaScript" type="text/javascript">

var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var isOpticUpMode = '<%HW_WEB_IsOpticUpMode();%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var isOpticOn = '<%HW_WEB_IsOpticExist();%>'; 

function ExtPortInfo(domain,Enable,Mode,Speed)
{
	this.domain	= domain;
	this.Enable = Enable; 
	this.Mode 	= Mode;
	this.Speed 	= Speed; 
}

var ExtPortInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, Enable|DuplexMode|MaxBitRate,ExtPortInfo);%>;

function WanEthInfo(domain,Enable,Mode,Speed)
{
	this.domain	= domain;
	this.Enable = Enable; 
	this.Mode 	= Mode;
	this.Speed 	= Speed; 
}

var WanEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANEthernetInterfaceConfig, Enable|DuplexMode|MaxBitRate, WanEthInfo);%>;

function stUpPortInfo(domain, upPortMode, upPortId)
{
    this.domain = domain;
    this.upPortMode = upPortMode;    
    this.upPortId = upPortId;
}

var stUpPortInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, X_HW_UpPortMode|X_HW_UpPortID, stUpPortInfo);%>;

var stUpPortInfo = stUpPortInfos[0];

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
		var portSpeedid = "portSpeed" + lastLanId;
		
	
		setCheck(enblid, ExtPortInfos[lastLanId - 1].Enable);
		setSelect(duplexModeid,ExtPortInfos[lastLanId - 1].Mode);
		setSelect(portSpeedid,ExtPortInfos[lastLanId - 1].Speed);
			
		setDisable(enblid, 1);
		setDisable(duplexModeid, 1);
		setDisable(portSpeedid, 1);
	}
	
}

function selectVlueMap(ethid, portCfg)
{
	var selectValue = 1;
	if(portCfg=='Auto')
	{
		selectValue=1;
	}else if(portCfg=='10 MB Full')
	{
		selectValue=2;
	}else if(portCfg=='10 MB Half')
	{
		selectValue=3;
	}else if(portCfg=='100 MB Full')
	{
		selectValue=4;
	}else if(portCfg=='100 MB Half')
	{
		selectValue=5;
	}else if(portCfg=='1000 MB Full')
	{
		selectValue=6;
	}
	setSelectValue(ethid, selectValue);
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

    for (var i = 0; i < ExtPortInfos.length - 1; i++)
	{
		var lanid = i + 1;
		var duplexModeid = "duplexMode" + lanid;
		var ethid = "eth" + lanid;
		var mode = ExtPortInfos[i].Speed + ' MB ' + ExtPortInfos[i].Mode;
		
        if ((lanid < ExtPortInfos.length) && (4 != i))
        {
			setSelect(duplexModeid, mode);
			selectVlueMap(ethid, mode);
        }

        if (6 == ExtPortInfos.length)
        {
			if (i == 4)
			{
				setSelect(duplexModeid,ExtPortInfos[i].Mode);
				if ('0' == isOpticUpMode)
				{
					setDisable(duplexModeid, 1);
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
					setDisable(duplexModeid, 1);
					getElById('EnableNote6').className = "gray";
					getElById('WanNote').className = "gray";
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
			}
		}
		initSelectIndex();
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

	document.getElementById("speedtitle").parentElement.style.textAlign = "left";
}

function PortSpeedModeSendOther(portNum)
{
	var parainfo="";
	var portCfg = getSelectVal("duplexMode" + portNum);
	var speed='Auto';
	var mode='Auto';
	var tr181_speed='-1';

	if(portCfg=='Auto')
	{
		speed='Auto';
		mode='Auto';
		tr181_speed='-1';
	}else if(portCfg=='10 MB Full')
	{
		speed='10';
		mode='Full';
		tr181_speed='10';
	}else if(portCfg=='10 MB Half')
	{
		speed='10';
		mode='Half';
		tr181_speed='10';
	}else if(portCfg=='100 MB Full')
	{
		speed='100';
		mode='Full';
		tr181_speed='100';
	}else if(portCfg=='100 MB Half')
	{
		speed='100';
		mode='Half';
		tr181_speed='100';
	}else if(portCfg=='1000 MB Full')
	{
		speed='1000';
		mode='Full';
		tr181_speed='1000';
	}
	parainfo='x.DuplexMode='+ mode + "&";
	parainfo+='x.MaxBitRate='+ speed + "&";
	parainfo+='x.X_TR181_MaxBitRate='+ tr181_speed + "&";
	parainfo+='x.X_HW_Token=' + getValue('hwonttoken');
	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : parainfo,
		 url : "setajax.cgi?x=InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + portNum + "&RequestFile=/html/amp/ethcfg/newvdfethcfg.asp",
		 success : function(data) {
		 },
	});
}

function EthPortSpeedMode(portNum)
{
	var parainfo="";
	var speed='Auto';
	var mode='Auto';
	var tr181_speed='-1';
	var cfg = getSelectValue("eth" + portNum);

	if(cfg==1)
	{
		speed='Auto';
		mode='Auto';
		tr181_speed='-1';
	}else if(cfg==2)
	{
		speed='10';
		mode='Full';
		tr181_speed='10';
	}else if(cfg==3)
	{
		speed='10';
		mode='Half';
		tr181_speed='10';
	}else if(cfg==4)
	{
		speed='100';
		mode='Full';
		tr181_speed='100';
	}else if(cfg==5)
	{
		speed='100';
		mode='Half';
		tr181_speed='100';
	}else if(cfg==6)
	{
		speed='1000';
		mode='Full';
		tr181_speed='1000';
	}
	parainfo='x.DuplexMode='+ mode + "&";
	parainfo+='x.MaxBitRate='+ speed + "&";
	parainfo+='x.X_TR181_MaxBitRate='+ tr181_speed + "&";
	parainfo+='x.X_HW_Token=' + getValue('hwonttoken');
	$.ajax({
		 type : "POST",
		 async : false,
		 cache : false,
		 data : parainfo,
		 url : "setajax.cgi?x=InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + portNum + "&RequestFile=/html/amp/ethcfg/newvdfethcfg.asp",
		 success : function(data) {
		 },
	});
}

function PortSpeedModeSubmit()
{
	var lanid,duplexModeid,portSpeedid;
	var portcfg;

	for(var i = 0; i < ExtPortInfos.length - 1; i++)
	{
		lanid = i+1;
		if (lanid == stUpPortInfo.upPortId)
		{
			continue;
		}
		EthPortSpeedMode(lanid);
	}
	location.reload();
}

function PortSpeedModeCancel()
{
   $.ajax({
       type : "GET",
       async : true,
       cache : false,
       url : "newvdfethcfg.asp",
       success : function(data) {
			LoadFrame();
       }
    });
}


</script>

</head>
<body onLoad="LoadFrame();" class="mainbody" style="height: 780px">
<div>

	<h1>
		<script>document.write(status_ethcfg_language['amp_itvdf_ethcfg_title']);</script>
	</h1>
	<h2>&nbsp;</h2>

	<script>
	var ethline1 = ["eth1", "1", status_ethcfg_language["amp_port_auto"],
					"2", status_ethcfg_language["amp_itvdf_ethcfg_10MF"],
					"3", status_ethcfg_language["amp_itvdf_ethcfg_10MH"],
					"4", status_ethcfg_language["amp_itvdf_ethcfg_100MF"],
					"5", status_ethcfg_language["amp_itvdf_ethcfg_100MH"],
					"6", status_ethcfg_language["amp_itvdf_ethcfg_1000MF"]];
	var ethline2 = ["eth2", "1", status_ethcfg_language["amp_port_auto"],
					"2", status_ethcfg_language["amp_itvdf_ethcfg_10MF"],
					"3", status_ethcfg_language["amp_itvdf_ethcfg_10MH"],
					"4", status_ethcfg_language["amp_itvdf_ethcfg_100MF"],
					"5", status_ethcfg_language["amp_itvdf_ethcfg_100MH"],
					"6", status_ethcfg_language["amp_itvdf_ethcfg_1000MF"]];
	var ethline3 = ["eth3", "1", status_ethcfg_language["amp_port_auto"],
					"2", status_ethcfg_language["amp_itvdf_ethcfg_10MF"],
					"3", status_ethcfg_language["amp_itvdf_ethcfg_10MH"],
					"4", status_ethcfg_language["amp_itvdf_ethcfg_100MF"],
					"5", status_ethcfg_language["amp_itvdf_ethcfg_100MH"],
					"6", status_ethcfg_language["amp_itvdf_ethcfg_1000MF"]];
	var ethline4 = ["eth4", "1", status_ethcfg_language["amp_port_auto"],
					"2", status_ethcfg_language["amp_itvdf_ethcfg_10MF"],
					"3", status_ethcfg_language["amp_itvdf_ethcfg_10MH"],
					"4", status_ethcfg_language["amp_itvdf_ethcfg_100MF"],
					"5", status_ethcfg_language["amp_itvdf_ethcfg_100MH"],
					"6", status_ethcfg_language["amp_itvdf_ethcfg_1000MF"]];
    
	speedlineArr = new Array(new tableArrayInfo("span", status_ethcfg_language['amp_itvdf_ethcfg_eth'],
							"speedtitle", status_ethcfg_language['amp_itvdf_ethcfg_speed']),
							new tableArrayInfo("selectnotop", "Eth1", ethline1, ""),
							new tableArrayInfo("selectnotop", "Eth2", ethline2, ""),
							new tableArrayInfo("selectnotop", "Eth3", ethline3, ""),
							new tableArrayInfo("selectnotop", "Eth4", ethline4, ""));
	var tableID = "speedline";
	CreatSetInfoTable(status_ethcfg_language['amp_itvdf_ethcfg_head'], tableID, speedlineArr);
		</script>
	<div id="content">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<script>
			CreatApplyButton("PortSpeedModeSubmit()");
		</script>
	</div>
	
</div>
</body>

</html>
