<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href="../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../../../images/singtel.ico" />
<link rel="Bookmark" href="../../../images/singtel.ico" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<title></title>
</head>
<script>
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var RedirtIndex = 0;
var UpgradeFlag = 0;
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var guideIndex = '<%HW_WEB_GetGuideChl();%>';
guideIndex = guideIndex - 48;
document.title = ProductName;

function loadframe()
{
	if ( (0 < guideIndex) && (5 > guideIndex))
	{
		RedirtIndex = guideIndex;
		document.getElementById("img" + guideIndex).src = "../../../images/guidecheck.jpg";
	}
	else
		document.getElementById("btncfgnext").disabled = "disabled";
}

function onchangeimg(id)
{
	var selectpng = document.getElementById(id).src.split("/");
	selectpng = selectpng[selectpng.length - 1];

	if(selectpng == "guidenocheck.jpg")
	{
		document.getElementById(id).src = "../../../images/guidecheck.jpg";
		RedirtIndex = id.substr(id.length - 1, 1);
		for(var i = 1; i < 5; i++)
		{
			if (RedirtIndex != i)
			{
				document.getElementById("img" + i).src = "../../../images/guidenocheck.jpg";
			}
		}
		document.getElementById("btncfgnext").disabled = "";
	}
	else
	{
		document.getElementById(id).src = "../../../images/guidenocheck.jpg";
		RedirtIndex = 0;
		document.getElementById("btncfgnext").disabled = "disabled";
	}
}

function onbtncfgnext(val)
{
	if (true == logo_singtel)
	{
		if (0 < RedirtIndex && 5 > RedirtIndex)
		{
			$.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : '/smartguide.cgi?1=1&RequestFile=CustomApp/adminguideframe_singtel.asp',
				data: getDataWithToken('Parainfo=' + RedirtIndex, true),
				success : function(data) {
					;
				}
			});
			window.location="/CustomApp/adminguideframe_singtel.asp";
		}
	}
	else
	{
		if (0 < RedirtIndex && 5 > RedirtIndex)
		{
			$.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : '/smartguide.cgi?1=1&RequestFile=CustomApp/adminguideframe.asp',
				data: getDataWithToken('Parainfo=' + RedirtIndex, true),
				success : function(data) {
					;
				}
			});
			window.location="/CustomApp/adminguideframe.asp";
		}
	}
}

function onfirstpage(val)
{
	if (true == logo_singtel)
	{
		if (-48 == guideIndex)
		{
			$.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : '/smartguide.cgi?1=1&RequestFile=mainpage.asp',
				data: getDataWithToken('Parainfo=0', true),
				success : function(data) {
					;
				}
			});
		}
		window.location="/mainpage.asp";
	}
	else
	{
		if (-48 == guideIndex)
		{
			$.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : '/smartguide.cgi?1=1&RequestFile=index.asp',
				data: getDataWithToken('Parainfo=0', true),
				success : function(data) {
					;
				}
			});
		}
		window.location="/index.asp";
	}
}
</script>
<body onload="loadframe();">
	<div id="mainguidebg">
		<div id="mainguidetop">
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="brandlog_singtel" style="display:none;"></div>');				
			}
			else
			{
				document.write('<div id="brandlog" style="display:none;"></div>');
			}
			</script>	
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="ProductName" style="text-align:right; height:41px; line-height:63px; margin-left:630px;">' + htmlencode(ProductName) + '</div>');				
			}
			else
			{
				document.write('<div id="ProductName">' + htmlencode(ProductName) + '</div>');
			}
			</script>

			<!--check line 0: head-->
			<div id="guidindexhead" class="guideline">
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_title"><span BindText="s2000"></span></div></div>
			</div>
			<div class="guideheadspace"></div>
			<!--check line 1: olt cfg-->
			<div id="guideline1" class="guideline">
				<div class="guidecheckbox"><img id="img1" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="oltcfg" BindText="s2001"></span></div></div>
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_content"><span id="oltcfginfo" BindText="s2002"></span></div></div>
			</div>
			<div class="guidespace"></div>
			<!--check line 2: ems cfg-->
			<div id="guideline2" class="guideline">
				<div class="guidecheckbox"><img id="img2" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="emscfg" BindText="s2003"></span></div></div>
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_content"><span id="emscfginfo" BindText="s2004"></span></div></div>
			</div>
			<div class="guidespace"></div>
			<!--check line 3: acs cfg-->
			<div id="guideline3" class="guideline">
				<div class="guidecheckbox"><img id="img3" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="acscfg" BindText="s2005"></span></div></div>
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_content"><span id="acscfginfo" BindText="s2006"></span></div></div>
			</div>
			<div class="guidespace"></div>
			<!--check line 4: web cfg-->
			<div id="guideline4" class="guideline">
				<div class="guidecheckbox"><img id="img4" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="webcfg" BindText="s2007"></span></div></div>
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_content"><span id="webcfginfo" BindText="s2008"></span></div></div>
			</div>
			<div class="guidespace"></div>
			<!--check line 5: butttons-->
			<div id="guideline5" class="guideline">
				<div class="guidecheckbox"></div>
				<div class="guidecontent">
					<input type="button" id="firstpage"  class="CancleButtonBlueBgCss buttonwidth_100px" onClick="onfirstpage(this);"  value="" BindText="s2009">
					<input type="button" id="btncfgnext" class="CancleButtonBlueBgCss buttonwidth_100px" onClick="onbtncfgnext(this);" value="" BindText="s2010">
				</div>
			</div>
		</div>
	</div>
	<div id="greenline"></div>
	<div id="copyright">
		<div id="copyrightspace"></div>
		<div id="copyrightlog" style="display:none;"></div>
		<div id="copyrighttext"><span id="footer" BindText="s2011"></span></div>
	</div>

	<div style="display:none;">
		<iframe frameborder="0" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="/refresh.asp" width="100%"></iframe>
	</div>

	<script>
		ParseBindTextByTagName(CfgguideLgeDes, "span",  1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "input", 2);
		if (parseInt(mngttype, 10) != 1)
		{						
			if(parseInt(logo_singtel, 10) == 1)
			{
				if(TypeWord_com == "COMMON")
				{
					$("#brandlog_singtel").css("background-image", "url()");
				}
			    $("#brandlog_singtel").css("display", "block");
			}
			else
			{
			    $("#brandlog").css("display", "block");
			}
			
			if((parseInt(logo_singtel, 10) == 1) && TypeWord_com == "COMMON")
			{
				$("#copyrightlog").css("display", "none");
			}
			else
			{
				$("#copyrightlog").css("display", "block");	
			}				
		}
	</script>

</body>
</html>
