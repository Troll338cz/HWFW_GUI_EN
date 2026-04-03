<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" rel="stylesheet" type="text/css" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(index.css);%>" rel="stylesheet" type="text/css" />
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<script src="/Cusjs/<%HW_WEB_CleanCache_Resource(frame.asp);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>

<script language="JavaScript" type="text/javascript">
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var guideIndex = '<%HW_WEB_GetGuideChl();%>';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var E8CAPFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_E8CAP_SWITCH);%>';
var DirectGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_CHANGE_GUIDE_LEVEL);%>';
guideIndex = guideIndex - 48;
var autoadapt = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AUTO_ADAPT);%>';
var adaptResult = '<%HW_WEB_GetCModeAdaptValue();%>';
var AdaptExist = '<%HW_WEB_IsSupportAd();%>';
var isRTOnlyMode='<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_MODE_ROUTER_ONLY);%>';
var aprepeater = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var aprepEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.AutoSelectSlaveApUpPort);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var IsSupportMesh = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MESH);%>";
var meshMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_Mesh.MeshMode);%>';  

//aprepEnable = 1;
//aprepeater = 3;
if(1 != curChangeMode && 1 == aprepEnable)
{
	if(3 == aprepeater)
	{
		curChangeMode = 2;
	}
	else if(8 == aprepeater)
	{
		curChangeMode = 3;
	}
}
if(autoadapt == 1)
{
	curChangeMode = 4;
}
function onfirstpage(val)
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
	window.top.location.href="/index.asp";
}
function ClickSkip(val)
{
	val.id = "guidecfgdone";
	window.parent.onchangestep(val);
}

function onlaststep(val)
{
	if (curUserType == sysUserType)
	{
		if(0 == DirectGuideFlag)
		{
			if((IsSupportMesh == 1) || 1 == GhnDevFlag)
			{
				if(aprepEnable == 0)
				{
					if (meshMode != 3)
					{
						if (E8CAPFlag ==1)
						{
							val.id= "guidewancfg";
							val.name= "/html/bbsp/wan/wane8c.asp?cfgguide=1";	
						}
						else
						{
							val.id= "guidewancfg";
							val.name= "/html/bbsp/wan/wan.asp?cfgguide=1";
						}
					}				
					else if (curChangeMode == 2)
					{
						val.id= "guidecfgdone";
						val.name= "/html/ssmp/cfgguide/userguidecfgdone.asp?cfgguide=1";
					}
					else if (curChangeMode == 3) 
					{
						val.id= "guidecmodecfg";
						val.name= "/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1";
					}
				}
				else if(aprepEnable == 1)
				{
					if (meshMode != 3)
					{
						if (E8CAPFlag ==1)
						{
							val.id= "guidewancfg";
							val.name= "/html/bbsp/wan/wane8c.asp?cfgguide=1";	
						}
						else
						{
							val.id= "guidewancfg";
							val.name= "/html/bbsp/wan/wan.asp?cfgguide=1";
						}
					}
					else
					{
						val.id= "guidecmodecfg";
						val.name= "/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1";
					}
				}
			}
		}
		else
		{
			if (curChangeMode == 3)
			{
				val.id= "guidecmodecfg";
				val.name= "/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1";			
			}
			else
			{
				if(aprepEnable == 0)
				{
					val.id= "guidesyscfg";
					val.name= "/html/ssmp/accoutcfg/guideaccountcfgAP.asp";
				}
				else if(aprepEnable == 1)
				{
					val.id= "guidecmodecfg";
					val.name= "/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1";			
				}
			}
		}
	}
	else
	{
		if(aprepEnable == 0)
		{
			if (curChangeMode == 3)
			{
				val.id= "guidecmodecfg";
				val.name= "/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1";			
			}
			else
			{
				val.id= "guidesyscfg";
				val.name= "/html/ssmp/accoutcfg/guideaccountcfg.asp";
			}
		}
		else if(aprepEnable == 1)
		{
			if (curChangeMode == 2 || curChangeMode == 3)
			{
				val.id= "guidecmodecfg";
				val.name= "/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1";			
			}
		}
	}
	window.parent.onchangestep(val);
}

function LoadFrame()
{
	document.getElementById("MdyPwdApply").disabled=true;	
	document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
	document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";
	
	if(apcmodefeature == 1 || E8CAPFlag == 0)
	{
		document.getElementById("aprepcontentguide").style.display="block";
		if(meshMode=='0')
		{
			document.getElementById("autoconsultguide").style.display="block";
			document.getElementById("ghengline1").style.display="block";

			
			document.getElementById("7").disabled=false;
			document.getElementById("7").checked=true;
			document.getElementById("gautopic5").src="../../../images/router2.png";
			document.getElementById("automodeguide").style.color="#57b6f0";
			document.getElementById("gcmexplainbridge").style.display="block";
		}        
        
		if(meshMode=='1')
		{
			document.getElementById("autoconsultguide").style.display="block";
			document.getElementById("ghengline1").style.display="block";

			
			document.getElementById("5").disabled=false;
			document.getElementById("5").checked=true;
			document.getElementById("grtpic5").src="../../../images/router2.png";
			document.getElementById("rtcontent").style.color="#57b6f0";
			document.getElementById("gcmexplainbridge").style.display="block";
		}
		if(meshMode=='2')
		{
			document.getElementById("autoconsultguide").style.display="block";
			document.getElementById("ghengline1").style.display="block";

			
			document.getElementById("8").disabled=false;
			document.getElementById("8").checked=true;
			document.getElementById("guntagrtpic5").src="../../../images/router2.png";
			document.getElementById("untagrtcontent").style.color="#57b6f0";
			document.getElementById("gcmexplainbridge").style.display="block";
		}
		if(meshMode=='3')
		{
			
			document.getElementById("autoconsultguide").style.display="block";
			document.getElementById("ghengline1").style.display="block";

			
			if(curChangeMode=='2')
			{
				document.getElementById("gcmexplainap").style.display="block";
				document.getElementById("gwifipic4").src="../../../images/apmode2.png";
			}
			if(curChangeMode=='3')
			{
				document.getElementById("gcmexplainrep").style.display="block";
				document.getElementById("gwifipic4").src="../../../images/Ranger2.png";
			}
			document.getElementById("4").disabled=false;
			document.getElementById("4").checked=true;
			document.getElementById("wificontent").style.color="#57b6f0";
		}
	}
	if(GhnDevFlag == 1)
	{
		document.getElementById("4").disabled=true;
		document.getElementById("5").disabled=true;
		document.getElementById("6").checked=true;
		document.getElementById("gwifipic4").src="../../../images/apmode2.png";
		document.getElementById("wificontent").style.color="#57b6f0";
	}

	if((0 == AdaptExist && isRTOnlyMode !=1) || (CfgMode.toUpperCase() == 'CTCTRIAP'))
	{
		document.getElementById('autoconsultguide').style.display = "none";
		document.getElementById('ghengline1').style.display = "none";
	}
    
    if (IsSupportMesh == 1)
    {
        document.getElementById('autoconsultguide').style.display = "none";
        document.getElementById('ghengline1').style.display = "none";
        if (curUserType != sysUserType)
        {
            document.getElementById('automodeguide').style.display = "none";
            document.getElementById('wifimodeguide').style.display = "none";
			document.getElementById('ghengline2').style.display = "none";
			document.getElementById('rtmodecontent').style.marginTop ="30px";
        }
    }    
    
}
</script>
</head>
<body style="width:950px;height:450px;overflow:hidden;margin-left:-100px;" onLoad="LoadFrame();">	
	<div id="aprepcontentguide" style="	margin-top:0%;margin-left:28.3%;text-align:left;">
	<!-- Auto Mode-->
		<div id="automodeguide" style="margin-top:20px;">
			<div id="autoradiodiv" style="margin-top:20px;float:left;"><input id="7" type="radio" name="CMode" value="route" /></div>
			<div id="cmimagediv" ><img id="gautopic5" src="../../../images/router1.png"></div>
			<div id="automodecontent" style="margin-top:0px;" >
				<h2 id="upmodenames" style=""><span id="autocontent" class="Smartinforight" BindText="mainpage051r"></span></h2>
				<div id="gcmexplain" style="margin-top:-5px; width:600px;" BindText="mainpage057"></div>
			</div>
			<p id="ghengline" style="width:83%;height:1px;background-color:#CCCCCC;float:left;"></p>
			<div class="clear"></div>
		</div>
	<!-- 路由模式-->
		<div id="rtmodeguide" style="margin-top:20px;display:none">
			<div id="rtradiodiv" style="margin-top:20px;float:left;"><input id="5" type="radio" name="CMode" value="route" /></div>
			<div id="cmimagediv" ><img id="grtpic5" src="../../../images/router1.png"></div>
			<div id="rtmodecontent" style="margin-top:0px;" >
				<h2 id="upmodenames" style=""><span id="rtcontent" class="Smartinforight" BindText="mainpage052"></span></h2>
				<div id="gcmexplain" style="margin-top:-5px; width:600px;" BindText="mainpage055"></div>
			</div>
			<p id="ghengline" style="width:83%;height:1px;background-color:#CCCCCC;float:left;"></p>
			<div class="clear"></div>
		</div>
	<!-- untagged路由模式-->
		<div id="untagrtmodeguide" style="display:none">
			<div id="untagrtradiodiv" style="margin-top:20px;float:left;"><input id="8" type="radio" name="CMode" value="route" /></div>
			<div id="cmimagediv" ><img id="guntagrtpic5" src="../../../images/router1.png"></div>
			<div id="untagrtmodecontent" style="margin-top:0px;" >
				<h2 id="upmodenames" style=""><span id="untagrtcontent" class="Smartinforight" BindText="mainpage053"></span></h2>
				<div id="gcmexplain" style="margin-top:-5px; width:600px;" BindText="mainpage056"></div>
			</div>
			<p id="ghengline2" style="width:83%;height:1px;background-color:#CCCCCC;float:left;"></p>
			<div class="clear"></div>
		</div>
	<!-- 桥接模式-->
		<div id="wifimodeguide" >
			<div id="wifiradiodiv" style="margin-top:20px;float:left;"><input id="4" type="radio" name="CMode" value="wifi" /></div>
			<div id="cmimagediv" ><img id="gwifipic4" src="../../../images/Ranger1.png"></div>
			<div id="wifimodecontent" style="margin-top:0px;">
				<h2 id="upmodenames" style=""><span id="wificontent" class="Smartinforight" BindText="mainpage054"></span></h2>
				<div id="gcmexplainrep" style="margin-top:-5px;display:none;" BindText="mainpage026"></div>
				<div id="gcmexplainap" style="margin-top:-5px;display:none;" BindText="mainpage025"></div>
				<div id="gcmexplainbridge" style="margin-top:-5px;width:600px;display:none;" BindText="mainpage042"></div>
			</div>
			
			<p id="ghengline1" style="width:83%;height:1px;background-color:#CCCCCC;float:left;display:none;"></p>
			
			<div class="clear"></div>
		</div>		
	<!-- 自适应模式-->
		<div id="autoconsultguide" style="display:none;">
			<div id="autoconsultradio" style="float:left;margin-top:12px;"><input id="6" type="radio" name="CMode" value="autoconsult" /></div>
			<div id="cmimagediv" ><img id="autoadaptpic5" src="../../../images/apmode1.png"></div>
			<div id="apaumodecontent" style="margin-top:-11px;margin-left: 72px;" >
				<h2 id="upmodenames" style=""><span id="autoconsultcontent" class="Smartinforight" BindText="mainpage043"></span></h2>
				<div id="autoconsultexplain" style="margin-top:-5px;width:600px;" BindText="mainpage044"></div>
			</div>

			<div class="clear"></div>
		</div>
	</div>
	<div id="guideap" style="margin-top:30px;margin-left:150px;">
		<input type="button" id="firstpage" class="CancleButtonCss buttonwidth_100px" onclick="onfirstpage(this);" BindText="mainpage036">
		<input type="button" id="guidesyscfg" class="ApplyButtoncss buttonwidth_100px" onclick="onlaststep(this);" BindText="mainpage033" name="/html/ssmp/accoutcfg/guideaccountcfg.asp">		
		<input type="button" id="MdyPwdApply" class="ApplyButtoncss buttonwidth_100px" BindText="mainpage024" onclick="showconfirm(this);">
		<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
	</div>
	
	<div class="alert_box" id="alert_box" style="display:none;width:46%;height:400px;margin-top:200px;margin-left:350px;">
		<div style="float:left;"><img id="reboot_img" src="../../../images/icon-thinking.gif" /></div>
		<div class="reboot_title_fir" style="float:left;margin-left:20px;" BindText="mainpage040"></div>
	</div>	

	<script type="text/javascript">

			$(function(){
			    if(isRTOnlyMode==1)
				{
				    document.getElementById("gcmexplainbridge").innerHTML="Only support router mode";
					document.getElementById("autoconsultexplain").innerHTML="Only support router mode";
				    $("input[name='CMode'][value='wifi']").attr("disabled",true);
					$("input[name='CMode'][value='autoconsult']").attr("disabled",true);
				}
				showwifimode();
				$("input[name=CMode]").click(function()
				{
					showwifimode();
					if(autoadapt == 1)
					{
						if(($("input[name=CMode]:checked").attr("id")) == '4')
						{
							if(curChangeMode=='1')
							{
								document.getElementById("MdyPwdApply").disabled=true;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							}
							else
							{
								document.getElementById("MdyPwdApply").disabled=false;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
								document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
							}
						}
						if(($("input[name=CMode]:checked").attr("id")) == '5')
						{
							if(curChangeMode=='2' || curChangeMode=='3')
							{
								document.getElementById("MdyPwdApply").disabled=true;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							}
							else
							{
								document.getElementById("MdyPwdApply").disabled=false;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
								document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
							}
						}
					}
					else
					{
						if(($("input[name=CMode]:checked").attr("id")) == '4')
						{
							if(meshMode != "3")
							{
								document.getElementById("MdyPwdApply").disabled=false;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
								document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
							}
							else
							{
								document.getElementById("MdyPwdApply").disabled=true;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							}
						}
						if(($("input[name=CMode]:checked").attr("id")) == '5')
						{
							if(meshMode != "1")
							{
								document.getElementById("MdyPwdApply").disabled=false;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
								document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
							}
							else
							{
								document.getElementById("MdyPwdApply").disabled=true;	
								document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
								document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							}
						}

					}
					if(($("input[name=CMode]:checked").attr("id")) == '6')
					{
						if(curChangeMode=='4')
						{
							document.getElementById("MdyPwdApply").disabled=true;	
							document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
							document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
						}
						else
						{
							document.getElementById("MdyPwdApply").disabled=false;	
							document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
							document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
						}
					}
					if(($("input[name=CMode]:checked").attr("id")) == '7')
					{
						if(meshMode=='0')
						{
							document.getElementById("MdyPwdApply").disabled=true;	
							document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
							document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
						}
						else
						{
							document.getElementById("MdyPwdApply").disabled=false;	
							document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
							document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
						}
					}
					if(($("input[name=CMode]:checked").attr("id")) == '8')
					{
						if(meshMode=='2')
						{
							document.getElementById("MdyPwdApply").disabled=true;	
							document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
							document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
						}
						else
						{
							document.getElementById("MdyPwdApply").disabled=false;	
							document.getElementById("MdyPwdApply").style.backgroundColor = "#56B2F8";
							document.getElementById("MdyPwdApply").style.borderColor = "#CCCCCC";
							document.getElementById("MdyPwdApply").style.Color = "#FFFFFF";
						}
					}
				});
			});
			function showwifimode()
			{
				switch($("input[name=CMode]:checked").attr("id")){
					case "4":
						document.getElementById("MdyPwdApply").disabled=false;
					break;
					case "5":
						document.getElementById("MdyPwdApply").disabled=false;
					break;	
					case "6":
						document.getElementById("MdyPwdApply").disabled=false;
					break;	
					case "7":
						document.getElementById("MdyPwdApply").disabled=false;
					break;
					case "8":
						document.getElementById("MdyPwdApply").disabled=false;
					break;					
					default:break;
				}
			}
			function showconfirm(val)
			{
				if(($("input[name=CMode]:checked").attr("id"))=='4' || ($("input[name=CMode]:checked").attr("id"))=='5' || ($("input[name=CMode]:checked").attr("id"))=='6' ||
                   ($("input[name=CMode]:checked").attr("id"))=='7' || ($("input[name=CMode]:checked").attr("id"))=='8')
				{
					var cmbln = window.confirm(framedesinfo["mainpage028"]);
					//var cmbln = window.confirm("模式切换需要重启生效。");
				}
				
				if (cmbln == true){					
					//document.getElementById('cmodecontentguide').style.display = "none";
					document.getElementById('aprepcontentguide').style.display = "none";

					document.getElementById('guideap').style.display = "none";
					document.getElementById('alert_box').style.display = "block";
					ModeChangeState();
					
					document.getElementById("MdyPwdApply").disabled=true;	
					document.getElementById("4").disabled=true;		
					document.getElementById("5").disabled=true;	
					document.getElementById("6").disabled=true;	
					document.getElementById("7").disabled=true;						
					document.getElementById("8").disabled=true;						
				}
				else
				{
					document.getElementById("4").disabled=false;
					document.getElementById("5").disabled=false;
					document.getElementById("6").disabled=false;
					document.getElementById("7").disabled=false;
					document.getElementById("8").disabled=false;
					document.getElementById("MdyPwdApply").disabled=true;
					document.getElementById("MdyPwdApply").style.backgroundColor = "#bbbbbb";
					document.getElementById("MdyPwdApply").style.borderColor = "#bbbbbb";

					if(meshMode=='1')
					{
						document.getElementById("5").checked=true;
						document.getElementById("5").disabled=false;
					}
					else if(meshMode=='3')
					{
						document.getElementById("4").checked=true;
						document.getElementById("4").disabled=false;
					}
					else if(meshMode=='0')
					{
						document.getElementById("7").checked=true;
						document.getElementById("7").disabled=false;
					}
					else if(meshMode=='2')
					{
						document.getElementById("8").checked=true;
						document.getElementById("8").disabled=false;
					}
					else if(curChangeMode=='4' )
					{
						document.getElementById("6").checked=true;
						document.getElementById("6").disabled=false;
					}
				}					
			}
			
			function ModeChangeState()
			{
                var Form = new webSubmitForm();
                
				if(($("input[name=CMode]:checked").attr("id"))=='5')
				{
					meshMode = '1';
				}
				else if(($("input[name=CMode]:checked").attr("id"))=='4')
				{
					meshMode = '3';
				}
				else if(($("input[name=CMode]:checked").attr("id"))=='7')
				{	
					meshMode = '0';
				}else if(($("input[name=CMode]:checked").attr("id"))=='8')
				{	
					meshMode = '2';
				}

	
                Form.addParameter('x.MeshMode', meshMode);
                Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1.X_HW_Mesh&RequestFile=html/ssmp/modechange/modechange_aisap.asp');
                Form.addParameter('x.X_HW_Token', getValue('onttoken'));
                Form.submit();
				
				document.getElementById("guidesyscfg").disabled=true;		
				document.getElementById("MdyPwdApply").disabled=true;		
				document.getElementById("firstpage").disabled=true;	
			}
			
	ParseBindTextByTagName(framedesinfo, "span", 1);
	ParseBindTextByTagName(framedesinfo, "td", 1);
	ParseBindTextByTagName(framedesinfo, "div", 1);
	ParseBindTextByTagName(framedesinfo, "input", 2);
			
</script>

</body>

</html>