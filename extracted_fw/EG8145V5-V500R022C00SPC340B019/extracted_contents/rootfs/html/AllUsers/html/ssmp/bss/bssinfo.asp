<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/ssmp/bss/bssinfo.cus);%>"></script>
<script language="JavaScript" type="text/javascript">
var g_num_Device = 0;
var g_num_OLT = 0;
var g_num_ACS = 0;
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ontMatchOLTStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.ONT.MatchStatus);%>';
var opticStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptStaus.status);%>';
var IsLAN = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

function fresh()
{	
	window.location.replace("bssinfo.asp");
}

function disActurEmSAndACS(emsStat,acsStat)
{
	if ('0' == emsStat)
	{
		document.getElementById("td3_2").innerHTML = BssLgeDes['s130f'];	
	}
	else if ('1' == emsStat)
	{
		document.getElementById("td3_2").innerHTML = BssLgeDes['s130e'];
	}
	else if ('2' == emsStat)
	{
		document.getElementById("td3_2").innerHTML = BssLgeDes['s130d'];
	}
	else
	{
		document.getElementById("td3_2").innerHTML = BssLgeDes['s1310'];
	}	
	
	if ('0' == parseInt(acsStat,10))
	{
		document.getElementById("td4_2").innerHTML = BssLgeDes['s1314'];	
	}	
	else if ('1' == parseInt(acsStat,10))
	{	
		document.getElementById("td4_2").innerHTML = BssLgeDes['s1302'];	
	}
	else if ('2' == parseInt(acsStat,10))
	{
		if (true == var_singtel)
		{
			document.getElementById("td4_2").innerHTML = BssLgeDes['s1313a'];	
		}
		else
		{
			document.getElementById("td4_2").innerHTML = BssLgeDes['s1313'];
		}
	}
	else
	{
		document.getElementById("td4_2").innerHTML = BssLgeDes['s1315'];	
	}
	
	if ('1' != emsStat && '2' != parseInt(acsStat,10))
	{
		clearInterval(TimerHandle);
	}
}

function displayTipInfo_xd(acsStat)
{	
	g_num_ACS = g_num_ACS + 1;


	if( '0' == acsStat )
	{
		document.getElementById("td4_2").innerHTML = SmartOntdes["smart016"];
		clearInterval(TimerHandle);
		return;
	} 

	if((g_num_ACS-1)*10000 >= 2*60*1000)
	{	
		if( '1' == acsStat )
		{
			document.getElementById("td4_2").innerHTML = SmartOntdes["smart015"];
		} 
		else if( '2' == acsStat || '3' == acsStat )
		{
			document.getElementById("td4_2").innerHTML = SmartOntdes["smart017"];
		} 
		else
		{
			document.getElementById("td4_2").innerHTML = SmartOntdes["smart015"];
		}	

		clearInterval(TimerHandle);
	}

	return ;	
}

function displayTipInfo(deviceStat,oltStat,emsStat,acsStat)
{
	if (ProductType == '2')
	{
		g_num_ACS = g_num_ACS + 1;


		if( '0' == acsStat )
		{
			document.getElementById("td4_2").innerHTML = SmartOntdes["smart016"];
			clearInterval(TimerHandle);
			return;
		} 

		if((g_num_ACS-1)*10000 >= 2*60*1000)
		{	
			if( '1' == acsStat )
			{
				document.getElementById("td4_2").innerHTML = SmartOntdes["smart015"];
			} 
			else if( '2' == acsStat || '3' == acsStat )
			{
				document.getElementById("td4_2").innerHTML = SmartOntdes["smart017"];
			} 
			else
			{
				document.getElementById("td4_2").innerHTML = SmartOntdes["smart015"];
			}	

			clearInterval(TimerHandle);
		}

		return ;
	}
	else
	{
		if (ontMatchOLTStatus == '1')
		{
			if (true == var_singtel)
			{
				document.getElementById('td1_2').innerHTML = BssLgeDes['s1316a'];
			}
			else
			{
				document.getElementById('td1_2').innerHTML = BssLgeDes['s1316'];
			}
		}
		else
		{
			g_num_Device = g_num_Device + 1;
			if ((g_num_Device-1)*10000 >= 10*60*1000)
			{
				clearInterval(TimerHandle);
			}
			
			if ("0" != deviceStat)
			{	
				if (((g_num_Device-1)*10000 >= 2*60*1000) || (opticStatus == 1))
				{
					document.getElementById("td1_2").innerHTML = BssLgeDes['s1306'];	
					clearInterval(TimerHandle);		
				}
				else
				{
					document.getElementById("td1_2").innerHTML = BssLgeDes['s1317'];		
				}

				document.getElementById("td2_2").innerHTML = BssLgeDes['s1302'];	
				document.getElementById("td3_2").innerHTML = BssLgeDes['s1302'];	
				document.getElementById("td4_2").innerHTML = BssLgeDes['s1302'];		
				return;
			}
			
			g_num_OLT = g_num_OLT + 1;
			if ('0x0' != oltStat && '0xffffffff' != oltStat)
			{	
				if (true == var_singtel)
				{
					document.getElementById("td1_2").innerHTML = BssLgeDes['s1304a'];	
				}
				else
				{
					document.getElementById("td1_2").innerHTML = BssLgeDes['s1304'];	
				}
				document.getElementById("td2_2").innerHTML = BssLgeDes['s130a'];	
				document.getElementById("td3_2").innerHTML = BssLgeDes['s1302'];	
				document.getElementById("td4_2").innerHTML = BssLgeDes['s1302'];	
				clearInterval(TimerHandle);		
				return;
			}
			
			if ('0xffffffff' == oltStat)
			{
				if (true == var_singtel)
				{
					document.getElementById("td1_2").innerHTML = BssLgeDes['s1304a'];	
				}
				else
				{
				document.getElementById("td1_2").innerHTML = BssLgeDes['s1304'];	
				}			
				if ( (g_num_OLT -1)*10000 >= 2*60*1000)
				{		
					if ( ('2' == emsStat) && ('0' != acsStat) )
					{
						document.getElementById("td2_2").innerHTML = BssLgeDes['s130b'];	
					}	
					else
					{
						document.getElementById("td2_2").innerHTML = BssLgeDes['s1309'];
					}			
				}
				else
				{		
					document.getElementById("td2_2").innerHTML = BssLgeDes['s1308'];	
					document.getElementById("td3_2").innerHTML = BssLgeDes['s1302'];	
					document.getElementById("td4_2").innerHTML = BssLgeDes['s1302'];
					return	;			
				}
			}	
			
			if ('0x0' == oltStat)
			{	
				if (true == var_singtel)
				{
					document.getElementById("td1_2").innerHTML = BssLgeDes['s1304a'];	
				}
				else
				{
				document.getElementById("td1_2").innerHTML = BssLgeDes['s1304'];	
				}
				document.getElementById("td2_2").innerHTML = BssLgeDes['s1309'];	
			}
			
			g_num_ACS = g_num_ACS + 1;
			if ((g_num_ACS-1)*10000 >= 1*60*1000)
			{
				disActurEmSAndACS(emsStat,"else"); 
			}
			else
			{
				disActurEmSAndACS(emsStat,acsStat);
			}
		}
		return ;		
	}
	
}

function requestCgi(iFlag)
{
	var deviceState="";
	var OltState="";
	var emsState="";
	var acsState="";	

	$.ajax({
			type : "POST",
			async : true,
			cache : false,
			url : "../common/GetDeviceState.asp",
			success : function(data) {
				var b=data.split(",");
				deviceState=b[1];
				OltState=b[2];
				emsState=b[3];
				acsState=b[4];	
				acsState=parseInt(acsState,10);
			    displayTipInfo(deviceState,OltState,emsState,acsState);
			}
		});
}

function LoadFrame()
{ 
	if( 'NOS' != CfgMode.toUpperCase())
	{
		document.getElementById('td3_2Row').style.display="";
		document.getElementById('td4_2Row').style.display="";
	}
	if(1 == IsLAN)
	{
		document.getElementById('td1_2Row').style.display="none";
		document.getElementById('td2_2Row').style.display="none";
		document.getElementById('td3_2Row').style.display="none";
	}
	requestCgi('0');
	if (true == var_singtel)
	{
		document.getElementById('td2_2Row').style.display="none";
		document.getElementById('td3_2Row').style.display="none";
		document.getElementById('td4_2Row').style.display="none";
	}
}

function GetLanguageDesc(Name)
{
    return BssLgeDes[Name];
}
var TimerHandle = setInterval("requestCgi('1')", 10000);

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("bssinfo", GetDescFormArrayById(BssLgeDes, "s0100"), GetDescFormArrayById(BssLgeDes, "s1300"), false);
</script>
<div class="title_spread"></div>

<form id="bssInfoForm" name="bssInfoForm">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" id="bssInfoFormPanel" name="bssInfoFormPanel"> 
<li id="td1_2" RealType="HtmlText" DescRef="s1301" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td1_2" InitValue="Empty" />
<li id="td2_2" RealType="HtmlText" DescRef="s1307" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td2_2" InitValue="Empty" />
<li id="td3_2" RealType="HtmlText" DescRef="s130c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td3_2" InitValue="Empty" />
<li id="td4_2" RealType="HtmlText" DescRef="s1311" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="td4_2" InitValue="Empty" />
</table>
<script>
	var TableClass = new stTableClass("table_title width_per25", "table_right");
	var bssInfoFormList = new Array();
	bssInfoFormList = HWGetLiIdListByForm("bssInfoForm",null);
	if(typeof(BssinfoReload) == "undefined")
	{
		BssinfoReload = null;
	}
	HWParsePageControlByID("bssInfoForm",TableClass,BssLgeDes,BssinfoReload);
	var bssInfoArray = new Array();
	bssInfoArray["td1_2"] = BssLgeDes["s1317"];
	bssInfoArray["td2_2"] = BssLgeDes["s1302"];
	bssInfoArray["td3_2"] = BssLgeDes["s1302"];
	bssInfoArray["td4_2"] = BssLgeDes["s1302"];
	HWSetTableByLiIdList(bssInfoFormList,bssInfoArray,null);
</script>
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">  
<tr>
<td  class="table_submit">
<input  class="ApplyButtoncss buttonwidth_100px" name="btnApply" id= "btnFresh" type="button" BindText="s1305" onClick="fresh()"> 
</td> 
</tr> 
</table> 
</form>

<script>
if (rosunionGame == "1") {
	$("#btnFresh").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
}
ParseBindTextByTagName(BssLgeDes, "td", 1);
ParseBindTextByTagName(BssLgeDes, "input", 2);
</script>

</body>
</html>
