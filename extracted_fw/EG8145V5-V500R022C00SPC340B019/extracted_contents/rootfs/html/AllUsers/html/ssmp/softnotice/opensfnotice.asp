<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<script language="JavaScript" src="opensoftware.js"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>

<style type="text/css">

.copyrightinfo_title_bold {
  font-weight: bold;
}

</style>

<script language="JavaScript" type="text/javascript">
var ProductType = '<%HW_WEB_GetProductType();%>';
var jiuzhouFlag = '<%WEB_GetJiuZhouFlag();%>';
function GetSFLanguageDesc(Name)
{
    return opensoftwareinfo[Name];
}

function GetSFNumDesc()
{
    return opensoftwareNum["num"];
}

function GetCLNumDesc()
{
    return copyrightlicenseNum["num"];
}

function GetCLLanguageDesc(Name)
{
    return copyrightlicenseinfo[Name];
}

var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>'; 
var SingtelFlag = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>'; 
var frame = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_FRAME.STRING);%>';
var rosflag = '<%HW_WEB_GetFeatureSupport(FT_ROS_UNION);%>';

function LoadFrame()
{
	if ( "BELL" ==  CfgModeWord.toUpperCase()
		|| "TELUS" ==  CfgModeWord.toUpperCase()
		|| 1 == SonetFlag )
	{
		document.getElementById('returnfromnotice').style.display="";
	}
	
	if("QTEL" ==  CfgModeWord.toUpperCase())
	{
		document.getElementById('title_01').style.color = '#ed1c24';
		document.getElementById('title_02').style.color = '#ed1c24';
		document.getElementById('title_03').style.color = '#ed1c24';
		document.getElementById('title_04').style.color = '#ed1c24';
	}
	if (rosflag == 1) {
		setDisplay("func_title_01", 0);
		setDisplay("title_02", 0);
	}	
}

function Goback()
{
	window.location="/index.asp";
		if ( "BELL" ==  CfgModeWord.toUpperCase()
		|| "TELUS" ==  CfgModeWord.toUpperCase())
	{
		window.location="/index.asp";
	}
	else if( 1 == SonetFlag )
	{
		window.location="/html/ssmp/softnotice/sonetnotice.asp";
	}
	else
	{
		;
	}
}
$(document).ready(
	function(){
		if ("frame_itvdf" == frame){
		$(".func_title").eq(0).addClass("pageHeadInfo");
	}	
});
</script>
</head>
<body class="mainbody pageBg" onLoad="LoadFrame();"> 
	<div class="func_title" BindText="s2002"></div><!-- function 1: OPEN SOURCE SOFTWARE NOTICE -->
	<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
		<tr><td id="title_01" class="table_title width_per30" BindText="s2003"></td></tr> 
	</table> 
	
	<div class="func_spread"></div>
	<div class="func_title_01" BindText="s2004"></div><!-- function 2: Warranty Disclaimer -->
	<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
		<tr><td id="title_02" class="table_title width_per30 copyrightinfo_title_bold" BindText="s2005"></td></tr> 
	</table> 
	
	<div class="func_spread"></div>
	<div class="func_title" BindText="s2050"></div><!-- function 5: Copyright Notice and License Texts -->
	<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
		<tr>
		<script>
		if (ProductType != '2')
		{
			var indexclnum = GetCLNumDesc();			
		}
		var totalclnum = parseInt(indexclnum);
		var strcopyrightlicense = "";
		for(var i = 0; i < totalclnum; i++)
		{
			var copyrightlicenseIndex = 'cl' + i ;
			strcopyrightlicense += GetCLLanguageDesc(copyrightlicenseIndex + "01");
			strcopyrightlicense += GetCLLanguageDesc(copyrightlicenseIndex + "02");
		}
		
		document.write('<td id="title_04" class="table_title width_per30" dir="ltr">' + strcopyrightlicense + '</td>');
		</script>
		</tr> 
	</table> 
	
	<div class="func_spread"></div>
	<div class="func_title" BindText="s2006"></div><!-- function 3: Open Source Software Information -->
	<div id="OpenSFInfo"> 
		<table height="5" class="tabal_bg" cellpadding="1" cellspacing="1" width="100%" style="table-layout:fixed"> 
			<tr class="head_title" style="position:relative;" width="100%"> 
				<script>
					if (ProductType == '2') {
						document.write('<td style="word-break: break-all;" width="20%" class="table_right" BindText="s2007"></td>'); 
						document.write('<td style="word-break: break-all;" width="10%" class="table_right" BindText="s2008"></td>'); 
						document.write('<td style="word-break: break-all;" width="35%" class="table_right" BindText="s2009"></td>'); 
						document.write('<td style="word-break: break-all;" width="13%" class="table_right" BindText="s2010"></td>'); 
						document.write('<td style="word-break: break-all;" width="22%" class="table_right" BindText="s2011"></td>');					
					} else if (CfgModeWord.toUpperCase() == "TURKCELLAP") {
						document.write('<td style="word-wrap: break-word;" width="50%" class="table_right" BindText="s2007"></td>'); 
						document.write('<td style="word-wrap: break-word;" width="50%" class="table_right" BindText="s2010"></td>'); 
					} else {
						document.write('<td style="word-wrap: break-word;" width="30%" class="table_right" BindText="s2007"></td>'); 
						document.write('<td style="word-wrap: break-word;" width="50%" id="copy_right" class="table_right" BindText="s2009"></td>'); 
						document.write('<td style="word-wrap: break-word;" width="20%" class="table_right" BindText="s2010"></td>'); 
					}
				</script>
			</tr> 
			<script>
				var indexnum = GetSFNumDesc();
				var totalnum = parseInt(indexnum);
				for(var i = 0; i < totalnum; i++)
				{
					var InfoPreIndex = 'sw' + i ;
					if (-1 != GetSFLanguageDesc(InfoPreIndex + "01").indexOf("ipt_trigger"))
					{
						continue;
					}
					document.write('<tr width="100%" style="position:relative;">');
					if (ProductType == '2')
					{
						document.write('<td  class="table_right" dir="ltr" style="word-break: break-all;" width="20%">' + GetSFLanguageDesc(InfoPreIndex + "01") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-break: break-all;" width="10%">' + GetSFLanguageDesc(InfoPreIndex + "02") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-break: break-all;" width="35%">' + GetSFLanguageDesc(InfoPreIndex + "03") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-break: break-all;" width="13%">' + GetSFLanguageDesc(InfoPreIndex + "04") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-break: break-all;" width="22%">' + GetSFLanguageDesc(InfoPreIndex + "05") + '</td>');
					} else if (CfgModeWord.toUpperCase() == "TURKCELLAP") {
						document.write('<td  class="table_right" dir="ltr" style="word-wrap: break-word;" width="50%">' + GetSFLanguageDesc(InfoPreIndex + "01") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-wrap: break-word;" width="50%">' + GetSFLanguageDesc(InfoPreIndex + "03") + '</td>');
					} else {
						document.write('<td  class="table_right" dir="ltr" style="word-wrap: break-word;" width="30%">' + GetSFLanguageDesc(InfoPreIndex + "01") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-wrap: break-word;" width="50%">' + GetSFLanguageDesc(InfoPreIndex + "02") + '</td>');
						document.write('<td  class="table_right" dir="ltr" style="word-wrap: break-word;" width="20%">' + GetSFLanguageDesc(InfoPreIndex + "03") + '</td>');
					}

					document.write('</tr>');

				}
			</script>
		</table> 
	</div> 
	
	<div class="func_spread"></div>
	<div class="func_title" BindText="s2012"></div><!-- function 4: Written Offer -->
	<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
		<script>
            if (SingtelFlag == 1) {
                document.write('<tr><td id="title_03" class="table_title width_per30" BindText="s2049"></td></tr>');
            } else if(SonetFlag == 1) {
                document.write('<tr><td id="title_03" class="table_title width_per30" BindText="s2013a"></td></tr>');
            } else if (jiuzhouFlag == 1) {
				document.write('<tr><td id="title_03" class="table_title width_per30" BindText="s2013b"></td></tr>');
			} else {
                document.write('<tr><td id="title_03" class="table_title width_per30" BindText="s2013"></td></tr>');
            }
		</script>
	</table> 
	
	<div class="func_spread"></div>
	<div id="returnfromnotice" style="display:none;">
		<input type="button" name="MdyPwdApply" id="MdyPwdApply" class="CancleButtonCss buttonwidth_100px" onClick="Goback();" BindText="s2015" />
	</div>
	<div class="func_spread"></div>
	
	<script>
		ParseBindTextByTagName(SoftNoticeDes, "div",   1);
		ParseBindTextByTagName(SoftNoticeDes, "td",    1);
		ParseBindTextByTagName(SoftNoticeDes, "input", 2);
	</script>	
</body>
</html>
