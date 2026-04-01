<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' rel="stylesheet" type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript"></script>
<script src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>" type="text/javascript"></script>
</head>
<script language="javascript">
var srvprovisionflag = 0;
var g_num_Device = 0;
var g_num_OLT = 0;
var g_num_ACS = 0;

var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var TimerHandle = null;
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var RedirtIndex = '<%HW_WEB_GetGuideChl();%>';
var fttrmainflag = "<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>";
RedirtIndex = RedirtIndex-48;
var curPercent = 5;

function setPrograss(hasTimeout, percent, promptTxt)
{
	var mleft = 8 + ((curPercent - 5) / 5) * 24;
	if (percent > 100)
		percent = 100;
	if (hasTimeout || percent == 100)
		clearInterval(TimerHandle);

	if (hasTimeout)
	{
		HiddenUnwantedRow();
	}

	for (var i = curPercent; i <= percent; i += 5)
	{
		$("#bssper_" + i).removeClass("displaynone");
		mleft += 24;
	}

	if (percent == 100)
	{
		$("#bssper_105").removeClass("displaynone");
		mleft += 24;
		srvprovisionflag = 1;
	}

	curPercent = percent;
	$("#bssResProgPer").css("margin-left", mleft + "px");
	document.getElementById('percent').innerHTML   = htmlencode(curPercent) + "%";
	document.getElementById("regResult").innerHTML = (TranslateStrBySonetFlag(BssLgeDes[promptTxt], mngttype));
}

function StartRegStatus()
{
	if (true == var_singtel)
	{
		setPrograss(false, 20, 's2002a');
	}
	else
	{
		setPrograss(false, 20, 's2002');
	}
}

function disActurEmSAndACS(emsStat, acsStat)
{
	if ( 2 == RedirtIndex)
	{
		if ('0' == emsStat)
		{
			setPrograss(false, 100, 's2003');
		}
		else if ('1' == emsStat)
		{
			setPrograss(false, 70,  's2004');
		}
		else if ('2' == emsStat)
		{
			setPrograss(false, 70, 's2004');
		}
		else
		{
			setPrograss(true, 100, 's2005');
		}
	}
	else
	{
		if ('0' == parseInt(acsStat, 10))
		{
			setPrograss(false, 100, 's2006');
		}
		else if ('1' == parseInt(acsStat, 10))
		{
			if (true == var_singtel)
			{
				setPrograss(false, 80, 's2007a');
			}
			else
			{
				setPrograss(false, 80, 's2007');
			}
		}
		else if ('2' == parseInt(acsStat, 10))
		{
			if (true == var_singtel)
			{
				setPrograss(false, 80, 's2007a');
			}
			else
			{
				setPrograss(false, 80, 's2007');
			}
		}
		else
		{
			if (true == var_singtel)
			{
				setPrograss(true, 100, 's2008a');
			}
			else
			{
				setPrograss(true, 100, 's2008');
			}
		}
	}
}

function displayTipInfo(deviceStat, oltStat, emsStat, acsStat)
{
	g_num_Device = g_num_Device + 1;
	if ((g_num_Device) * 10000 >= 5 * 60 * 1000)
	{
		clearInterval(TimerHandle);
	}

	if ("0" != deviceStat) 
	{
		if ((g_num_Device) * 10000 >= 1 * 60 * 1000)
		{
			if (true == var_singtel)
			{
				setPrograss(true, 100, 's2009a');
			}
			else
			{
				setPrograss(true, 100, 's2009');
			}
		}
		else
		{
			if (true == var_singtel)
			{
				setPrograss(false, 20, 's2002a');
			}
			else
			{
				setPrograss(false, 20, 's2002');
			}
		}
		return;
	}

	if( 1 == RedirtIndex) 
	{
		g_num_OLT = g_num_OLT + 1;
		if ('0x0' != oltStat && '0xffffffff' != oltStat)
		{
			if ( (g_num_OLT) * 10000 >= 1 * 60 * 1000)
			{
				setPrograss(true, 100, 's2010');
			}
			else
			{
				setPrograss(false, 40, 's2011');
			}
			return;
		}

		if ('0xffffffff' == oltStat)
		{
			if ( (g_num_OLT) * 10000 >= 1 * 60 * 1000)
			{
				if ( ('2' == emsStat) && ('0' != acsStat) )
				{
					setPrograss(true, 100, 's2012');
				}
				else
				{
					setPrograss(false, 100, 's2003');
				}
			}
			else
			{
				setPrograss(false, 40, 's2011');
				return;
			}
		}

		if ('0x0' == oltStat)
		{
			setPrograss(false, 100, 's2003');
		}
	}

	if( 2 == RedirtIndex || 3 == RedirtIndex) 
	{
		g_num_ACS = g_num_ACS + 1;
		if ((g_num_ACS) * 10000 >= 1 * 60 * 1000)
		{
			disActurEmSAndACS("else", "else");
		}
		else
		{
			disActurEmSAndACS(emsStat, acsStat);
		}
	}

	if(4 == RedirtIndex) 
	{
		setPrograss(false, 100, 's2003');
	}

	return;
}

function requestCgi()
{
	var deviceState = "";
	var OltState    = "";
	var emsState    = "";
	var acsState    = "";

	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : "/html/ssmp/common/GetDeviceState.asp",
		success : function(data) {
			var b = data.split(",");
			deviceState = b[1];
			OltState    = b[2];
			emsState    = b[3];
			acsState    = b[4];
			acsState    = parseInt(acsState, 10);

			displayTipInfo(deviceState, OltState, emsState, acsState);
		}
	});
}

function LoadFrame()
{
	TimerHandle = setInterval("requestCgi()", 10000);
	StartRegStatus();
	if (fttrmainflag == 1) {		
		window.parent.setDisplay("framepageContent", 1);
	}
}

function onindexpage(val)
{
	if (true == var_singtel)
	{	
		if(TypeWord_com == "COMMON")
		{
			window.top.location = "/index.asp";
		}
		else
		{
			window.top.location = "/mainpage.asp";
		}
		
	}
	else
	{
		window.top.location = "/index.asp";
	}
}

function HiddenUnwantedRow()
{
	($("#bssResProg")).css("display",'none');	
}

function confirmenterindex()
{
	var tips = BssLgeDes['s2013'];
	var result = ((srvprovisionflag == 0) ? ConfirmEx(tips) : true);
	if(true == result)
	{
		onindexpage(this);
	}
}
</script>
<body onLoad="LoadFrame();">
	<div id="bssResult">
		<div id="bssResTitle">
			<span class="bssResultTitle" BindText="s2000"></span>
		</div>
		<div id="bssResProg">
			<div id="bssResProgPer" style="margin-left:8px;"><span id="percent">0%</span></div>
			<div id="bssResProgBar">
				<div class="bssResProgBarHead"></div>
				<div class="bssResProgBarSpace"></div>
				<div id="bssResProgBarTotal">
					<div id="bssper_5"   class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_10"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_15"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_20"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_25"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_30"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_35"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_40"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_45"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_50"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_55"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_60"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_65"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_70"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_75"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_80"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_85"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_90"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_95"  class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_100" class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
					<div id="bssper_105" class="bssResProgBarPerBg displaynone"><div class="bssResProgBarPer"></div></div>
				</div>
				<div class="bssResProgBarSpace"></div>
				<div class="bssResProgBarTail"></div>
			</div>
		</div>
		<div id="bssPrompt">
			<span id="regResult"></span>
		</div>
	</div>
	<div id="btnguide" style="margin-top:20px;">
		<input type="button" id="nextpage" class="ApplyButtoncss buttonwidth_120px_180px"  onClick="confirmenterindex();" value="" BindText="s2001">
	</div>

	<script>
		ParseBindTextByTagName(BssLgeDes, "span",  1);
		ParseBindTextByTagName(BssLgeDes, "input", 2);
	</script>
</body>
</html>
