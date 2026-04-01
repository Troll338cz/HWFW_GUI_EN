<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' rel="stylesheet"  type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="javascript" src="/html/bbsp/common/GetLanUserDevInfo.asp"></script>
<script language="javascript" src="/html/bbsp/common/lanuserinfo.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
</head>
<script language="javascript">
var ConnectDevIp = '<%HW_WEB_GetCurDeviceIP();%>';
var curDevConType = '';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var IsSupportpon2lan = '<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>'; 
var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var curUserType = '<%HW_WEB_GetUserType();%>';
sysUserType = 0;
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var apwififeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_WIFI_ADAPT);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var E8CAPFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_E8CAP_SWITCH);%>';
var DirectGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_CHANGE_GUIDE_LEVEL);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var fVideoCoverEnable = '<%HW_WEB_GetVedioCoverEnable();%>';
var aprepeater = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var aprepEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.AutoSelectSlaveApUpPort);%>';
var VideoFlag = '<%HW_WEB_GetVideoChangeFlag();%>';
var autoadapt = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AUTO_ADAPT);%>';
var adaptResult = '<%HW_WEB_GetCModeAdaptValue();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var isSurportWlanCfg  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var isSupportOnulanCfg = "<%HW_WEB_GetFeatureSupport(FT_WEB_ONU_LAN_CFG);%>";
var modifyWebcodeLogout = '<%HW_WEB_GetFeatureSupport(FT_MODIFY_WEBCODE_GUIDE_LOGOUT);%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var isForceModifyPwd = window.parent.isForceModifyPwd;

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

function HwAjaxSetApPara(ObjPath, ParameterList)
{
	var Result = null;
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/complexajax.cgi?' + ObjPath + "&RequestFile=userguidecfgdone.asp",
		data: ParameterList,
		success : function(data) {
			 Result  = hexDecode(data);
		}
	});
	
	try{
		return JSON.parse(Result);
	}
	catch(e){
		return null;	
	}
}

function onindexpage(val)
{
	if ((curChangeMode == 2 || curChangeMode == 3 || GhnDevFlag == 1 || (curChangeMode == 4 && adaptResult != 1)) && (VideoFlag != 1))
	{
		var Path ='y=InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_WLANConfiguration';
		var ParaList = top.selectrepwlan;
		Path +='&z=InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_UpmodeConfig.1';
		
		if (ParaList !="")
		{
			ParaList += "&x.X_HW_Token=" + getValue("onttoken");
			HwAjaxSetApPara(Path, ParaList);
		}	
	}
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

function onlaststep(val)
{
	if (ProductType == '2')
	{
		val.id= "guidesyscfg";
		if (CfgMode == "DSLSTC2WIFI")
		{
			val.name= "/html/ssmp/accoutcfg/guideaccountcfg_xdstc.asp";
		}
		else
		{
			val.name= "/html/ssmp/accoutcfg/guideaccountcfg.asp";
		}

		if (IsTedata == 1) {
            val.id = "guidewlanconfig";
            val.name="/html/amp/wlanbasic/guidewificfg.asp";
        }

		if (isForceModifyPwd) {
			if (curUserType == sysUserType) {
				val.id= "guidewancfg";
				val.name= "/html/bbsp/wan/wan.asp?cfgguide=1";
			} else {
				val.id= "guideinternet";
				val.name= "../../html/bbsp/guideinternet/guideinternet.asp";
			}
		}
		window.parent.onchangestep(val);
	}
	else
	{
		if (curUserType == sysUserType)
		{
			if(1 == DirectGuideFlag)
			{
				val.id= "guidesyscfg";
				val.name= "/html/ssmp/accoutcfg/guideaccountcfgAP.asp";
			}
			else{
				if(1 == smartlanfeature || (3 == CurrentUpMode && 1 == IsSupportpon2lan))
				{
					if(1 == IsSmartDev)
					{
						if(2 == curChangeMode || 3 == curChangeMode || (4 == curChangeMode && 1 != adaptResult))
						{
							val.id= "guidecmodecfg";
							val.name= "/html/ssmp/modechange/modechange.asp?cfgguide=1";
						}else
						{
							val.id= "guidewancfg";
							val.name= "/html/bbsp/wan/wan.asp?cfgguide=1";
						}
					}
					else
					{
						if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
						{
							if(2 == curChangeMode || 3 == curChangeMode || (4 == curChangeMode && 1 != adaptResult))
							{
							var modechangeAsp = "/html/ssmp/modechange/modechange.asp?cfgguide=1";
							var wlanneighborAPAsp = "/html/amp/wlaninfo/wlanneighborAP.asp";
							var resultPage = (CfgMode == "VDFPTAP" || "TRUEAP" == CfgMode)?wlanneighborAPAsp:modechangeAsp;							
							val.id= "guidecmodecfg";
							val.name= resultPage;
							}
							
							if(1 == curChangeMode)
							{
								if (1 == E8CAPFlag)
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
						}
						else
						{
							val.id= "guidewancfg";
							val.name= "/html/bbsp/wan/wan.asp?cfgguide=1";	
						}
					}
				}
			}
            if ((IsTedata == 1) && (isSurportWlanCfg != 1)) {
                val.name= "/html/bbsp/guideinternet/guideinternet.asp";
                val.id = "guideinternet";
            }
        } else {
            val.id= "guidesyscfg";
            if (IsTedata == 1) {
                val.name= "/html/amp/wlanbasic/guidewificfg.asp";
                if (isSurportWlanCfg != 1) {
                    val.name= "/html/bbsp/guideinternet/guideinternet.asp";
                    val.id = "guideinternet";
                }
            } else {
                val.name= "/html/ssmp/accoutcfg/guideaccountcfg.asp";
            }
        }
        window.parent.onchangestep(val);
    }
}

function LogoutWithParaIE11()
{
    var token = GetToken();
    var url = 'logout.cgi?RequestFile=html/logout.html';

    var data = {'x.X_HW_Token': token};
    $.post(url, data);
    window.parent.location = "/GuideFinish.asp";
}

function wifiConfigBeforeLogout()
{
    Form = window.parent.wifiForm;
    var url = Form.oForm.action.replace("set", "setajax");
    var elements = Form.oForm.elements;
    var dataparam = '';
    for (var i = 0; i < elements.length; i++) {
		if (i != 0) {
			dataparam += "&";
		}
		dataparam += elements[i].name + '=' + elements[i].value;
    }

    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : dataparam,
        url :  url,
        success : function(data) {
            
        },
        error:function(XMLHttpRequest, textStatus, errorThrown) {
            if(XMLHttpRequest.status == 404) {
            }
        }
    });
}

function wifiConfig()
{
	Form = window.parent.wifiForm;
	Form.oForm.target = "id_iframe";
	Form.submit();
}

function getCurDeviceConnectType()
{
	var UserDevices = new Array();
	GetLanUserInfo(function(para1, para2)
	{
		UserDevices = para2;
		for (var i=0; UserDevices.length > 0 && i < UserDevices.length-1; i++)
		{
			if (ConnectDevIp == UserDevices[i].IpAddr)
			{
				curDevConType = UserDevices[i].PortType;
				break;
			}
		}
			
		if(curDevConType == "WIFI")
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2042']);
			setDisplay("id_wifi_notice", 1);
		}
		else
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2041']);
		}
		if((1 == apcmodefeature && 3 == curChangeMode) || (8 == aprepeater && 4 == curChangeMode && 3 == adaptResult))
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2042']);
		}
	});
}

function ModifyWebCodeProc()
{
    if(window.parent.IsSurportWlanCfg == 1) {
        wifiConfigBeforeLogout();
    }

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

    parent.UpgradeFlag = "1";
    var sUserAgent = navigator.userAgent;
    var isIELarge11 = (sUserAgent.indexOf("Trident") > -1 && sUserAgent.indexOf("rv") > -1);
    if (isIELarge11) {
        LogoutWithParaIE11();
    } else {
        LogoutWithPara("guideLogout", "", false, curUserType);
    }

}

function LoadFrame()
{
    if ((window.parent.modifyWebCode == '1') && (modifyWebcodeLogout == '1')) {
        ModifyWebCodeProc();
        return;
    }
	if(1 == window.parent.IsSurportWlanCfg)
	{
		getCurDeviceConnectType();
		wifiConfig();
	}
	else
	{
		$('#id_connect_type').html(CfgguideLgeDes['s2041']);
	}

	if (ProductType != '2')
	{
		if((1 == apcmodefeature && 3 == curChangeMode) || (8 == aprepeater && 4 == curChangeMode))
		{
			$('#id_connect_type').html(CfgguideLgeDes['s2042']);
		}
		
		if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
		{	
			document.getElementById('id_wifi_welcome').innerHTML = (CfgguideLgeDes['s2044ap']);
		}
		else if(1 == smartlanfeature || (3 == CurrentUpMode && 1 == IsSupportpon2lan))
		{
			if(1 == IsSmartDev)
			{
				document.getElementById('id_wifi_welcome').innerHTML = (CfgguideLgeDes['s2044lan']);
			}
			else
			{
				document.getElementById('id_wifi_welcome').innerHTML = (CfgguideLgeDes['s2044ap']);
			}
		}
	}
    if ((fttrFlag == '1') && ((isSupportOnulanCfg == '1') || (isBponFlag == 1))) {
        window.parent.setDisplay("framepageContent", 1);
    }
}

</script>
<body onLoad="LoadFrame();" style="background-color: rgb(255, 255, 255);">
	<form>
		<div align="center">
			
			<div style="font-size:16px;color:#666666;font-weight:bold; margin-top: 35px;">
				<div BindText="s2040"  style="display:inline;"></div>
				<div id="id_connect_type" style="display:inline;"></div>
			</div>
			
			<div id="id_wifi_notice" style="margin-top: 10px; display:none;font-size: 16px;color: #666666;" BindText="s2043"></div>
			<script>
				if (ProductType == '2')
				{
					document.write('<div id="id_wifi_welcome" style="margin-top: 10px;font-size: 16px; color: #666666;" BindText="s2044_xd"></div>');
				}
				else if (ProductType == '3')
				{
					document.write('<div id="id_wifi_welcome" style="margin-top: 10px;font-size: 16px; color: #666666;" BindText="s2044_cm"></div>');			
				}	
				else
				{
					document.write('<div id="id_wifi_welcome" style="margin-top: 10px;font-size: 16px; color: #666666;" BindText="s2044"></div>');			
				}			
			</script>

			<div style="margin-top: 35px">
				<script>
					if (ProductType != '2')
					{ 
						document.write('<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">');
					}
					if (IsTedata == 1) {
                        document.write('<input type="button" id="guidesyscfg"  class="CancleButtonCss buttonwidth_120px_180px" onClick="onlaststep(this);"  value="" BindText="s2020" name="/html/amp/wlanbasic/guidewificfg.asp">');
                    } else if ((ProductType == '2') && isForceModifyPwd) {
						if (curUserType == sysUserType) {
							document.write('<input type="button" id="guidewancfg"  class="CancleButtonCss buttonwidth_120px_180px" onClick="onlaststep(this);" value="" BindText="s2020" name="/html/bbsp/wan/wan.asp?cfgguide=1">');
						} else {
							document.write('<input type="button" id="guideinternet"  class="CancleButtonCss buttonwidth_120px_180px" onClick="onlaststep(this);" value="" BindText="s2020" name="../../html/bbsp/guideinternet/guideinternet.asp">');
						}
					} else {
                        document.write('<input type="button" id="guidesyscfg"  class="CancleButtonCss buttonwidth_120px_180px" onClick="onlaststep(this);"  value="" BindText="s2020" name="/html/ssmp/accoutcfg/guideaccountcfg.asp">');
                    }

					if (!isForceModifyPwd) {
						document.write('<input type="button" id="nextpage" class="ApplyButtoncss buttonwidth_120px_200px" onClick="onindexpage(this);" value="" BindText="s2021">');
					}
				</script>
			</div>
		</div>
	</form>
	<script>
		ParseBindTextByTagName(CfgguideLgeDes, "td", 1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "div", 1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "input", 2, mngttype);
	</script>
	<iframe id="id_iframe" name="id_iframe" style="display:none;"></iframe>
</body>
</html>
