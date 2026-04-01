<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>igmp</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" type="text/javascript">

var featureflag = "<% HW_WEB_GetFeatureSupport(BBSP_FT_SMART_QOS_EXT);%>";
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var CfgModeWord = '<%HW_WEB_GetCfgMode();%>';
var ROSTelecomFeature = '<%HW_WEB_GetFeatureSupport(FT_ROS_TELECOM_GLOBAL);%>';
var VIETTELFlag = "<% HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL_MVLAN_ACT);%>";
var IfVisual = "<% HW_WEB_IfVisualOltUser();%>";
var ProductType = '<%HW_WEB_GetProductType();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var dbaa1SuperSysUserType = '2';
var maxisLocalUserType = '1';

if (CfgModeWord.toUpperCase() == 'DNOVA2WIFI') {
    curUserType = sysUserType;
}

function IsAdminUser()
{
    if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
	}
	if ((CfgModeWord.toUpperCase() == "DETHMAXIS") && (curUserType == maxisLocalUserType)) {
        return true;
    }
    return curUserType == sysUserType;
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
		setObjNoEncodeInnerHtmlValue(b, igmp_language[b.getAttribute("BindText")]);
	}
}

function stIGMPInfo(domain,IGMPEnable,ProxyEnable,SnoopingEnable,IGMPVersion,Robustness,GenQueryInterval,GenResponseTime,SpQueryNumber,SpQueryInterval,SpResponseTime,RemarkIPPrecedence,RemarkPri,STBNumber,BridgeWanProxyEnable,PPPoEWanSnoopingMode,PPPoEWanProxyMode,StartUpQueryInterval,StartUpQueryCount,UnsolicitedReportInterval,RouterAlertEnable)
{
    this.domain = domain;
    this.IGMPEnable = IGMPEnable;
    this.ProxyEnable = ProxyEnable;
    this.SnoopingEnable = SnoopingEnable;
    this.IGMPVersion = IGMPVersion;
    this.Robustness = Robustness;
    this.GenQueryInterval = GenQueryInterval;
    this.GenResponseTime = GenResponseTime;
    this.SpQueryNumber = SpQueryNumber;
    this.SpQueryInterval = SpQueryInterval;
    this.SpResponseTime = SpResponseTime;
    this.RemarkIPPrecedence = RemarkIPPrecedence;
    this.RemarkPri = RemarkPri;
    this.STBNumber = STBNumber;
	this.BridgeWanProxyEnable = BridgeWanProxyEnable;
    this.PPPoEWanSnoopingMode = PPPoEWanSnoopingMode;
    this.PPPoEWanProxyMode = PPPoEWanProxyMode;
	this.StartUpQueryInterval = StartUpQueryInterval;
	this.StartUpQueryCount = StartUpQueryCount;
	this.UnsolicitedReportInterval = UnsolicitedReportInterval;
	this.RouterAlertEnable = RouterAlertEnable;
}

var WanMulticastProxy = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULTICAST_WANPROXY);%>";

function disableIgmpWorkModeByFeature()
{	
	if ( "0" == WanMulticastProxy )
    {
        setDisable("IGMPWorkMode", 1);
		setDisable("PROXYEnable", 1);
	}	
}

var IGMPInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_IPTVWhiteList, InternetGatewayDevice.Services.X_HW_IPTV, IGMPEnable|ProxyEnable|SnoopingEnable|IGMPVersion|Robustness|GenQueryInterval|GenResponseTime|SpQueryNumber|SpQueryInterval|SpResponseTime|RemarkIPPrecedence|RemarkPri|STBNumber|BridgeWanProxyEnable|PPPoEWanSnoopingMode|PPPoEWanProxyMode|StartUpQueryInterval|StartUpQueryCount|UnsolicitedReportInterval|RouterAlertEnable,stIGMPInfo);%>; 
var IGMPInfo = IGMPInfos[0];

function stVIETTELInfo(domain,MultiCastVlanAct,MultiCastVlan)
{
    this.domain = domain;
    this.MultiCastVlanAct = MultiCastVlanAct;
    this.MultiCastVlan = MultiCastVlan;
}
var VIETTELInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_IPTV_VIETTEL, MultiCastVlanAct|MultiCastVlan, stVIETTELInfo);%>;
var VIETTELInfo = VIETTELInfos[0];

function OnChooseDnMultiAction(Select)
{
   var Mode = getElementById("ChooseDnMultiAction").value;

   if (Mode == 1)
   {
       getElById("DnMultiVlanRow").style.display = "";     
   }
   else
   {
       getElById("DnMultiVlanRow").style.display = "none"; 
   }
    
}

if("1" == featureflag)
{
	IGMPInfo.IGMPEnable = '1';
	setSelect('IGMPEnable',"Enable");
}

function setDisableAllContent()
{
    setDisable("IGMPEnable",1);
	setDisable("BridgeWanProxyEnable",1);
	setDisable("PPPoEWanProxyMode",1);
	setDisable("PPPoEWanSnoopingMode",1);
    setDisable("IGMPWorkMode",1);
	setDisable("PROXYEnable",1);
	setDisable("SnoopingEnable",1);
    setDisable("IGMPProxyVersion",1);
    setDisable("Robustness",1);
    setDisable("GenQueryInterval",1);
    setDisable("GenResponseTime",1);
    setDisable("SpQueryNumber",1);
    setDisable("SpQueryInterval",1);
    setDisable("SpResponseTime",1);	
    setDisable("SpQueryInterval",1);
    setDisable("SpResponseTime",1);		
    setDisable("RemarkIPPrecedence",1);	
    setDisable("RemarkPri",1);	
    setDisable("btnApply",1);
    setDisable("cancelValue",1);
    setDisable("RouterAlertEnable",1);
	if("1" == featureflag)
	{
		setDisable("IGMPSNOOPINGEnable",1);
		setDisable("IGMPPROXYEnable",1);	
	}
	setDisable("StartupQueryInterval",1);
	setDisable("StartupQueryCount",1);
	setDisable("UnsolicitedReportInterval",1);
}

function LoadFrame()
{
	if ( null != IGMPInfo )
	{
		setSelect('IGMPProxyVersion',IGMPInfo.IGMPVersion);
		setText('Robustness',IGMPInfo.Robustness);
		setText('GenQueryInterval',IGMPInfo.GenQueryInterval);
		setText('GenResponseTime',IGMPInfo.GenResponseTime);
		setText('SpQueryNumber',IGMPInfo.SpQueryNumber);
		setText('SpQueryInterval',IGMPInfo.SpQueryInterval);
		setText('SpResponseTime',IGMPInfo.SpResponseTime);
		setSelect('BridgeWanProxyEnable',(IGMPInfo.BridgeWanProxyEnable == 1)?"Enable":"Disable");
		setSelect('PPPoEWanProxyMode',IGMPInfo.PPPoEWanProxyMode);
		setSelect('PPPoEWanSnoopingMode',IGMPInfo.PPPoEWanSnoopingMode);
		setCheck('SnoopingEnable', IGMPInfo.SnoopingEnable);
		setText('StartupQueryInterval',IGMPInfo.StartUpQueryInterval);
		setText('StartupQueryCount',IGMPInfo.StartUpQueryCount);
		setText('UnsolicitedReportInterval',IGMPInfo.UnsolicitedReportInterval);
		setSelect('RouterAlertEnable',IGMPInfo.RouterAlertEnable);

		if(parseInt(IGMPInfo.RemarkIPPrecedence,10)<0)
		{
			setText('RemarkIPPrecedence',"");
		}
		else
		{
			setText('RemarkIPPrecedence',IGMPInfo.RemarkIPPrecedence);
		}

		if(parseInt(IGMPInfo.RemarkPri,10)<0)
		{
			setText('RemarkPri',"");
		}
		else
		{
			setText('RemarkPri',IGMPInfo.RemarkPri);
		}
		
		if("1" == featureflag)
		{
			    if(((IsAdminUser() == false) && ((CfgModeWord.toUpperCase() != 'HT') && (CfgModeWord.toUpperCase() != 'OTE'))) || (IGMPInfo.IGMPEnable == '0'))
				{
					setDisableAllContent();				
				}
				else
				{
					if('0' == IGMPInfo.SnoopingEnable)
					{
						setSelect('IGMPSNOOPINGEnable',"Disable");
					}
					else
					{
						setSelect('IGMPSNOOPINGEnable',"Enable");
					}
					if('0' == IGMPInfo.ProxyEnable)
					{
						setSelect('IGMPPROXYEnable',"Disable");
						setDisable("IGMPProxyVersion",1);
						setDisable("RouterAlertEnable",1);
						setDisable("Robustness",1);
						setDisable("GenQueryInterval",1);
						setDisable("GenResponseTime",1);
						setDisable("SpQueryNumber",1);
						setDisable("SpQueryInterval",1);
						setDisable("SpResponseTime",1);	
						setDisable("BridgeWanProxyEnable",1);
						setDisable("PPPoEWanProxyMode",1);
					    setDisable("PPPoEWanSnoopingMode",0);
						setDisable("StartupQueryInterval",1);
						setDisable("StartupQueryCount",1);
						setDisable("UnsolicitedReportInterval",1);						
					}
					else
					{
						setSelect('IGMPPROXYEnable',"Enable");
						setDisable("IGMPProxyVersion",0);
						setDisable("RouterAlertEnable",0);
						setDisable("Robustness",0);
						setDisable("GenQueryInterval",0);
						setDisable("GenResponseTime",0);
						setDisable("SpQueryNumber",0);
						setDisable("SpQueryInterval",0);
						setDisable("SpResponseTime",0);	
						setDisable("BridgeWanProxyEnable",0);	
						setDisable("PPPoEWanProxyMode",0);
						setDisable("PPPoEWanSnoopingMode",1);
						setDisable("StartupQueryInterval",0);
						setDisable("StartupQueryCount",0);
						setDisable("UnsolicitedReportInterval",0);			
					}
					if('0' == IGMPInfo.IGMPEnable)
					{
						setDisable("RemarkIPPrecedence",1);	
						setDisable("RemarkPri",1);
						setDisable("BridgeWanProxyEnableRow",1);
						setDisable("PPPoEWanProxyMode",1);
						setDisable("PPPoEWanSnoopingMode",1);
					}
					else
					{
						setDisable("RemarkIPPrecedence",0);	
						setDisable("RemarkPri",0);
					}
				}
		}  
		else
		{
			if('0' == IGMPInfo.ProxyEnable)
			{
				setSelect('IGMPWorkMode',"Snooping");
				setCheck('PROXYEnable',0);
			}
			else
			{
				setSelect('IGMPWorkMode',"Proxy");
				setCheck('PROXYEnable',1);
			}
	
			if ('0' == IGMPInfo.IGMPEnable)
			{
				setSelect('IGMPEnable',"Disable");
				setDisplay('HomeGatewayInfo',1);
				setSelect('IGMPWorkMode',"Snooping");
				setDisable("IGMPWorkMode",1);
				setDisable("PROXYEnable",1);
				setDisable("SnoopingEnable",1);
				setDisable("IGMPProxyVersion",1);
				setDisable("Robustness",1);
				setDisable("GenQueryInterval",1);
				setDisable("GenResponseTime",1);
				setDisable("SpQueryNumber",1);
				setDisable("SpQueryInterval",1);
				setDisable("SpResponseTime",1);	
				setDisable("RemarkIPPrecedence",1);	
				setDisable("RemarkPri",1);
				setDisable("BridgeWanProxyEnable",1);
				setDisable("PPPoEWanProxyMode",1);
				setDisable("PPPoEWanSnoopingMode",1);
				setDisable("RouterAlertEnable",1);
				if((IsAdminUser() == false) && ((CfgModeWord.toUpperCase() != 'HT') && (CfgModeWord.toUpperCase() != 'OTE')))
				{
					setDisableAllContent();				
				}
				setDisable("StartupQueryInterval",1);
				setDisable("StartupQueryCount",1);
				setDisable("UnsolicitedReportInterval",1);	
			}
			else
			{
				setSelect('IGMPEnable',"Enable");
				setDisplay('HomeGatewayInfo',1);		
				setDisable("IGMPWorkMode",0);
				setDisable("PROXYEnable",0);
				setDisable("SnoopingEnable",0);
				if((IsAdminUser() == false) && ((CfgModeWord.toUpperCase() != 'HT') && (CfgModeWord.toUpperCase() != 'OTE')))
				{
					setDisableAllContent();			
				}
				else
				{
					if ('0' == IGMPInfo.ProxyEnable)
					{
						setDisable("IGMPProxyVersion",1);
						setDisable("RouterAlertEnable",1);
						setDisable("Robustness",1);
						setDisable("GenQueryInterval",1);
						setDisable("GenResponseTime",1);
						setDisable("SpQueryNumber",1);
						setDisable("SpQueryInterval",1);
						setDisable("SpResponseTime",1);		
						setDisable("BridgeWanProxyEnable",1);
						setDisable("PPPoEWanProxyMode",1);
						setDisable("PPPoEWanSnoopingMode",0);
						setDisable("StartupQueryInterval",1);
						setDisable("StartupQueryCount",1);
						setDisable("UnsolicitedReportInterval",1);							
					}
					else
					{
						setDisable("IGMPProxyVersion",0);
						setDisable("RouterAlertEnable",0);
						setDisable("Robustness",0);
						setDisable("GenQueryInterval",0);
						setDisable("GenResponseTime",0);
						setDisable("SpQueryNumber",0);
						setDisable("SpQueryInterval",0);
						setDisable("SpResponseTime",0);	
						setDisable("BridgeWanProxyEnable",0);
						setDisable("PPPoEWanProxyMode",0);
						setDisable("PPPoEWanSnoopingMode",1);
						setDisable("StartupQueryInterval",0);
						setDisable("StartupQueryCount",0);
						setDisable("UnsolicitedReportInterval",0);	
					}
				}
			}
		}
	}
	
	if("1" == featureflag)
	{
		setDisplay("IGMPEnableRow",0);
		setDisplay("IGMPWorkModeRow",0);
		setDisplay("IGMPSNOOPINGEnableRow",1);
		setDisplay("SpaceOption",1);
		setDisplay("IGMPPROXYEnableRow",1);
	}
	else
	{
		setDisplay("IGMPSNOOPINGEnableRow",0);
		setDisplay("SpaceOption",0);
		setDisplay("IGMPPROXYEnableRow",0);
		setDisplay("IGMPEnableRow",1);
		setDisplay("IGMPWorkModeRow",1);
	}


	if(CfgModeWord.toUpperCase()  == 'TDE2')
	{
		setDisplay("IGMPWorkModeRow",0);
		setDisplay("PROXYEnableRow",1);
		setDisplay("SnoopingEnableRow", 1);
		setDisplay("BridgeWanProxyEnableRow",0);
		setDisplay("PPPoEWanProxyModeRow",0);
		setDisplay("PPPoEWanSnoopingModeRow",0);		
	}
	else
	{
		setDisplay("PROXYEnableRow",0);
		setDisplay("SnoopingEnableRow", 0);		
	}
	
	disableIgmpWorkModeByFeature();
	if(productName == 'HG8240')
	{
		setDisable("IGMPWorkMode",1);
		if("1" == featureflag)
		{
			setDisable("IGMPPROXYEnable",1);
			setDisable("IGMPSNOOPINGEnable",1);
			setDisable("IGMPProxyVersion",1);
			setDisable("RouterAlertEnable",1);
			setDisable("Robustness",1);
			setDisable("GenQueryInterval",1);
			setDisable("GenResponseTime",1);
			setDisable("SpQueryNumber",1);
			setDisable("SpQueryInterval",1);
			setDisable("SpResponseTime",1);	
			setDisable("StartupQueryInterval",1);
			setDisable("StartupQueryCount",1);
			setDisable("UnsolicitedReportInterval",1);
		}
	}
	if(1 == ROSTelecomFeature)
	{
		setDisplay("IGMPEnableRow",0);
		setDisplay("IGMPWorkModeRow",0);
		setDisplay("BridgeWanProxyEnableRow",0);
	}
	if(VIETTELFlag == 1)
	{
		setSelect('ChooseDnMultiAction',VIETTELInfo.MultiCastVlanAct);
		setText('DnMultiVlan',VIETTELInfo.MultiCastVlan);

		getElById("ChooseDnMultiActionRow").style.display = "";

		OnChooseDnMultiAction();

		if ('1' == IGMPInfo.IGMPEnable)
		{
			getElById("ChooseDnMultiActionRow").style.display = "none";
			getElById("DnMultiVlanRow").style.display = "none";
		}
	}
	else
	{
		getElById("ChooseDnMultiActionRow").style.display = "none";
		getElById("DnMultiVlanRow").style.display = "none";
	}
	if(IfVisual == 1)
	{
	   pageDisable();
	   setDisable("btnApply",1);
	   setDisable("cancelValue",1);
	}

	if('2'==ProductType)
	{
		setDisplay("BridgeWanProxyEnableRow",0);
		setDisplay("PPPoEWanProxyModeRow",0);
		setDisplay("PPPoEWanSnoopingModeRow",0);
	}

	loadlanguage();
}

function CheckVauleRange()
{
	with (getElement ("ConfigForm"))
	{ 
		Robustness.value = removeSpaceTrim(Robustness.value);
		if (false == CheckNumber(Robustness.value, 1, 10))
		{
			AlertEx(igmp_language['bbsp_robustnessinvalid']);
			return false;
		}  

		GenQueryInterval.value = removeSpaceTrim(GenQueryInterval.value);
		if (false == CheckNumber(GenQueryInterval.value, 1, 5000))
		{
			AlertEx(igmp_language['bbsp_intervalinvalid']);
			return false;
		}

		GenResponseTime.value = removeSpaceTrim(GenResponseTime.value);
		if (false == CheckNumber(GenResponseTime.value, 1, 255))
		{
			AlertEx(igmp_language['bbsp_timeinvalid']);
			return false;
		}

		SpQueryNumber.value = removeSpaceTrim(SpQueryNumber.value);
		if (false == CheckNumber(SpQueryNumber.value, 1, 10))
		{
			AlertEx(igmp_language['bbsp_snuminvalid']);
			return false;
		}

		SpQueryInterval.value = removeSpaceTrim(SpQueryInterval.value);
		if (false == CheckNumber(SpQueryInterval.value, 1, 5000))
		{
			AlertEx(igmp_language['bbsp_sintervalinvalid']);
			return false;
		}

		SpResponseTime.value = removeSpaceTrim(SpResponseTime.value);	
		if (false == CheckNumber(SpResponseTime.value, 1, 255))
		{
			AlertEx(igmp_language['bbsp_stimeinvalid']);
			return false;
		}

		StartupQueryInterval.value = removeSpaceTrim(StartupQueryInterval.value);
		if (false == CheckNumber(StartupQueryInterval.value, 0, 5000))
		{
			AlertEx(igmp_language['bbsp_stupqininvalid']);
			return false;
		}

		StartupQueryCount.value = removeSpaceTrim(StartupQueryCount.value);	
		if (false == CheckNumber(StartupQueryCount.value, 1, 10))
		{
			AlertEx(igmp_language['bbsp_stupqcountinvalid']);
			return false;
		}

		UnsolicitedReportInterval.value = removeSpaceTrim(UnsolicitedReportInterval.value);	
		if (false == CheckNumber(UnsolicitedReportInterval.value, 1, 5000))
		{
			AlertEx(igmp_language['bbsp_unsreportininvalid']);
			return false;
		}	
	}	
	return true;
}

function CheckForm(type)
{  
     var info = 0;
	 var str = "";
	with (getElement ("ConfigForm"))
	{   
		if("1" == featureflag)
		{
			if ('1' == IGMPInfo.IGMPEnable)
			{
				RemarkIPPrecedence.value = removeSpaceTrim(RemarkIPPrecedence.value);	
				if(RemarkIPPrecedence.value != "")
				{
					if (false == CheckNumber(RemarkIPPrecedence.value, 0, 7))
					{
						AlertEx(igmp_language['bbsp_iptosinvalid']);
						return false;
					} 
				}
	
				RemarkPri.value = removeSpaceTrim(RemarkPri.value);	
				if(RemarkPri.value != "")
				{
					if (false == CheckNumber(RemarkPri.value, 0, 7))
					{
						AlertEx(igmp_language['bbsp_802invalid']);
						return false;
					} 
				}                    	    	     	 	
			}
		}
		else
		{
			if (getSelectVal('IGMPEnable') == "Enable")
			{
				RemarkIPPrecedence.value = removeSpaceTrim(RemarkIPPrecedence.value);	
				if(RemarkIPPrecedence.value != "")
				{
					if (false == CheckNumber(RemarkIPPrecedence.value, 0, 7))
					{
						AlertEx(igmp_language['bbsp_iptosinvalid']);
						return false;
					} 
				}
	
				RemarkPri.value = removeSpaceTrim(RemarkPri.value);	
				if(RemarkPri.value != "")
				{
					if (false == CheckNumber(RemarkPri.value, 0, 7))
					{
						AlertEx(igmp_language['bbsp_802invalid']);
						return false;
					} 
				}                    	    	     	 	
			}
		}
		if("1" == featureflag)
		{
			if ('1' == IGMPInfo.IGMPEnable && getSelectVal('IGMPPROXYEnable') == "Enable")
			{
				if (true != CheckVauleRange())
				{
					return false;
				}
			}
			
		}
		else
		{
			if (getSelectVal('IGMPEnable') == "Enable")
			{	
				var workmode = getSelectVal('IGMPWorkMode');
				if('TDE2' == CfgModeWord.toUpperCase())
				{
					if(getCheckVal('PROXYEnable') == "1")
					{
						workmode = "Proxy";
					}
					else
					{
						workmode = "Snooping";
					}
				}
				
				if (workmode == "Proxy")
				{
					if (true != CheckVauleRange())
					{
						return false;
					}										
				}		
			}               
		}  
		
		if(VIETTELFlag == 1)
		{
			var MultiAction = getSelectVal('ChooseDnMultiAction');
			var Multivlan = getValue('DnMultiVlan');
		    if (MultiAction == 1)
		    {
		        if (false == CheckNumber(Multivlan, 1, 4094))
		        {
		            AlertEx(igmp_language['bbsp_igmp_multivlan_invalid']);
		            return false;
		        }
			}
		}
	}
    return true;   
}

function IGMPSNOOPINGEnableChange()
{
    var igmpenable = getSelectVal('IGMPSNOOPINGEnable');
		if (igmpenable == "Enable")
		{
    		setSelect('IGMPEnable',"Enable");
			setSelect('IGMPWorkMode',"Snooping");
		}
		else
		{
	        setSelect('IGMPEnable',"Disable");
			setSelect('IGMPWorkMode',"Snooping");
		}
	
}

function IGMPPROXYEnableChange()
{
    var igmpenable = getSelectVal('IGMPPROXYEnable');
    if (igmpenable == "Enable")
    {
		setSelect('IGMPEnable',"Enable");
		setSelect('IGMPWorkMode',"Proxy");
		setDisable("IGMPProxyVersion",0);
		setDisable("RouterAlertEnable",0);
		setDisable("Robustness",0);
		setDisable("GenQueryInterval",0);
		setDisable("GenResponseTime",0);
		setDisable("SpQueryNumber",0);
		setDisable("SpQueryInterval",0);
		setDisable("SpResponseTime",0);
		setDisable("BridgeWanProxyEnable",0);
		setDisable("PPPoEWanProxyMode",0);
		setDisable("StartupQueryInterval",0);
		setDisable("StartupQueryCount",0);
		setDisable("UnsolicitedReportInterval",0);			
	}
	else
	{
		setSelect('IGMPEnable',"Enable");
		setSelect('IGMPWorkMode',"Proxy");
		setDisable("IGMPProxyVersion",1);
		setDisable("RouterAlertEnable",1);
		setDisable("Robustness",1);
		setDisable("GenQueryInterval",1);
		setDisable("GenResponseTime",1);
		setDisable("SpQueryNumber",1);
		setDisable("SpQueryInterval",1);
		setDisable("SpResponseTime",1);	
		setDisable("BridgeWanProxyEnable",1);
		setDisable("PPPoEWanProxyMode",1);
		setDisable("StartupQueryInterval",1);
		setDisable("StartupQueryCount",1);
		setDisable("UnsolicitedReportInterval",1);
	}
	
		setDisable("IGMPPROXYEnable",(productName == 'HG8240') ? 1 : 0);	
}

function IGMPEnableChange(obj)
{
    var igmpenable = getSelectVal('IGMPEnable');
    if (igmpenable == "Enable")
    {
        setDisplay('HomeGatewayInfo',1);		
        setDisable("IGMPWorkMode",0);
		setDisable("PROXYEnable",0);
		setDisable("SnoopingEnable",0);
        disableIgmpWorkModeByFeature();
    
        var igmpworkmode = getSelectVal('IGMPWorkMode');
		
		if ('TDE2' == CfgModeWord.toUpperCase())
		{
			if(getCheckVal('PROXYEnable') == "1")
			{
				igmpworkmode = "Proxy";
			}
			else
			{
				igmpworkmode = "Snooping";
			}	
		}

        if (igmpworkmode == "Proxy")
        {
			setDisable("IGMPProxyVersion",0);
			setDisable("RouterAlertEnable",0);
			setDisable("Robustness",0);
			setDisable("GenQueryInterval",0);
			setDisable("GenResponseTime",0);
			setDisable("SpQueryNumber",0);
			setDisable("SpQueryInterval",0);
			setDisable("SpResponseTime",0);		
			setDisable("BridgeWanProxyEnable",0);
			setDisable("PPPoEWanProxyMode",0);
			setDisable("PPPoEWanSnoopingMode",1);
			setDisable("StartupQueryInterval",0);
			setDisable("StartupQueryCount",0);
			setDisable("UnsolicitedReportInterval",0);				   
        }
        else
        {
			setDisable("IGMPProxyVersion",1);
			setDisable("RouterAlertEnable",1);
			setDisable("Robustness",1);
			setDisable("GenQueryInterval",1);
			setDisable("GenResponseTime",1);
			setDisable("SpQueryNumber",1);
			setDisable("SpQueryInterval",1);
			setDisable("SpResponseTime",1);	
			setDisable("BridgeWanProxyEnable",1);
			setDisable("PPPoEWanProxyMode",1);
			setDisable("PPPoEWanSnoopingMode",0);
			setDisable("StartupQueryInterval",1);
			setDisable("StartupQueryCount",1);
			setDisable("UnsolicitedReportInterval",1);				   
        }
        setDisable("RemarkIPPrecedence",0);	
        setDisable("RemarkPri",0);
		getElById("ChooseDnMultiActionRow").style.display = "none";
		getElById("DnMultiVlanRow").style.display = "none";

    }
    else
    {
        setDisplay('HomeGatewayInfo',1);	
        setDisable("IGMPWorkMode",1);
		setDisable("PROXYEnable",1);
		setDisable("SnoopingEnable",1);
        setDisable("IGMPProxyVersion",1);
        setDisable("Robustness",1);
        setDisable("GenQueryInterval",1);
        setDisable("GenResponseTime",1);
        setDisable("SpQueryNumber",1);
        setDisable("SpQueryInterval",1);
        setDisable("SpResponseTime",1);		
        setDisable("RemarkIPPrecedence",1);	
        setDisable("RemarkPri",1);	
		setDisable("BridgeWanProxyEnable",1);
		setDisable("PPPoEWanProxyMode",1);
		setDisable("PPPoEWanSnoopingMode",1);
		setDisable("StartupQueryInterval",1);
		setDisable("StartupQueryCount",1);
		setDisable("UnsolicitedReportInterval",1);
		setDisable("RouterAlertEnable", 1);
		
		if(VIETTELFlag == 1)
		{
			getElById("ChooseDnMultiActionRow").style.display = "";
			
			OnChooseDnMultiAction();
		}
    }
    
    if(productName == 'HG8240')
    {
        setDisable("IGMPWorkMode",1);
    }
	if(IfVisual == 1)
	{
	   pageDisable();
	   setDisable(obj.id,0);
	}
	
}

function ShowDetailPara(IgmpEnable, IgmpWorkMode)
{
    var igmpenable = IgmpEnable;
    var igmpworkmode = IgmpWorkMode;

    if (igmpworkmode == "Proxy") {
        if (igmpenable == "Enable") {
            setDisable("IGMPProxyVersion",0);
            setDisable("Robustness",0);
            setDisable("GenQueryInterval",0);
            setDisable("GenResponseTime",0);
            setDisable("SpQueryNumber",0);
            setDisable("SpQueryInterval",0);
            setDisable("SpResponseTime",0);
            setDisable("BridgeWanProxyEnable",0);
            setDisable("PPPoEWanProxyMode",0);
            setDisable("PPPoEWanSnoopingMode",1);
            setDisable("StartupQueryInterval",0);
            setDisable("StartupQueryCount",0);
            setDisable("UnsolicitedReportInterval",0)
            setDisable("RouterAlertEnable", 0);
        } else {
            setDisable("IGMPProxyVersion",1);
            setDisable("Robustness",1);
            setDisable("GenQueryInterval",1);
            setDisable("GenResponseTime",1);
            setDisable("SpQueryNumber",1);
            setDisable("SpQueryInterval",1);
            setDisable("SpResponseTime",1);	
            setDisable("BridgeWanProxyEnable",1);
            setDisable("PPPoEWanProxyMode",1);
            setDisable("PPPoEWanSnoopingMode",1);
            setDisable("StartupQueryInterval",1);
            setDisable("StartupQueryCount",1);
            setDisable("UnsolicitedReportInterval",1);
            setDisable("RouterAlertEnable", 1);
        }
    } else {
        setDisable("IGMPProxyVersion",1);
        setDisable("RouterAlertEnable",1);
        setDisable("Robustness",1);
        setDisable("GenQueryInterval",1);
        setDisable("GenResponseTime",1);
        setDisable("SpQueryNumber",1);
        setDisable("SpQueryInterval",1);
        setDisable("SpResponseTime",1);
        setDisable("BridgeWanProxyEnable",1);
        setDisable("PPPoEWanProxyMode",1);
        if (igmpenable == "Enable") {
            setDisable("PPPoEWanSnoopingMode",0);
        } else {
            setDisable("PPPoEWanSnoopingMode",1);
        }
        setDisable("StartupQueryInterval",1);
        setDisable("StartupQueryCount",1);
        setDisable("UnsolicitedReportInterval",1);
    }

    if (igmpenable == "Enable") {
        setDisable("RemarkIPPrecedence",0);
        setDisable("RemarkPri",0);
    } else {
        setDisable("RemarkIPPrecedence",1);
        setDisable("RemarkPri",1);
    } 
}

function IGMPWorkModeChange(obj)
{    
	var igmpenable = getSelectVal('IGMPEnable');
	var igmpworkmode = getSelectVal('IGMPWorkMode');
	ShowDetailPara(igmpenable, igmpworkmode); 
	if(IfVisual == 1)
	{
	   pageDisable();
	   setDisable(obj.id,0);
	}
}

function ProxyEnableChange(obj)
{    
	var igmpenable = getSelectVal('IGMPEnable');
	var igmpworkmode;
	var proxyenable = getCheckVal('PROXYEnable');
	if(proxyenable == "1")
	{
		igmpworkmode = "Proxy";
	}
	else
	{
		igmpworkmode = "Snooping";
	}
	ShowDetailPara(igmpenable, igmpworkmode); 
	if(IfVisual == 1)
	{
	   pageDisable();
	   setDisable(obj.id,0);
	}
}
function IGMPProxyVersionChange()
{    
	var igmpproxyversion = getSelectVal('IGMPProxyVersion');
}

function AddSubmitParam(SubmitForm,type)
{
	var value = getSelectVal('IGMPEnable');
	var snoopingvalue = getSelectVal('IGMPSNOOPINGEnable');
	var proxyvalue = getSelectVal('IGMPPROXYEnable');
	
	if("1" == featureflag)
	{	
		if('1' == IGMPInfo.IGMPEnable)
		{
			SubmitForm.addParameter('x.IGMPEnable',1);	
			if(snoopingvalue == "Enable")
			{
				SubmitForm.addParameter('x.SnoopingEnable',1);
			}
			else
			{
				SubmitForm.addParameter('x.SnoopingEnable',0);
			}
			if(proxyvalue == "Enable")
			{
				SubmitForm.addParameter('x.ProxyEnable',1);
				SubmitForm.addParameter('x.IGMPVersion',getSelectVal('IGMPProxyVersion'));
				SubmitForm.addParameter('x.Robustness',getValue('Robustness'));
				SubmitForm.addParameter('x.GenQueryInterval',getValue('GenQueryInterval'));
				SubmitForm.addParameter('x.GenResponseTime',getValue('GenResponseTime'));
				SubmitForm.addParameter('x.SpQueryNumber',getValue('SpQueryNumber'));
				SubmitForm.addParameter('x.SpQueryInterval',getValue('SpQueryInterval'));
				SubmitForm.addParameter('x.SpResponseTime',getValue('SpResponseTime'));
				SubmitForm.addParameter('x.BridgeWanProxyEnable',getSelectVal('BridgeWanProxyEnable'));
                SubmitForm.addParameter('x.PPPoEWanProxyMode',getSelectVal('PPPoEWanProxyMode'));
				SubmitForm.addParameter('x.StartUpQueryInterval',getValue('StartupQueryInterval'));
				SubmitForm.addParameter('x.StartUpQueryCount',getValue('StartupQueryCount'));
				SubmitForm.addParameter('x.UnsolicitedReportInterval',getValue('UnsolicitedReportInterval'));
				SubmitForm.addParameter('x.RouterAlertEnable', getValue('RouterAlertEnable'));
			}
			else
			{
				SubmitForm.addParameter('x.ProxyEnable',0);
				SubmitForm.addParameter('x.PPPoEWanSnoopingMode',getSelectVal('PPPoEWanSnoopingMode'));	
			}
			SubmitForm.addParameter('x.RemarkIPPrecedence',(getValue('RemarkIPPrecedence')=="")?(-1):(parseInt(getValue('RemarkIPPrecedence'))));
			SubmitForm.addParameter('x.RemarkPri',(getValue('RemarkPri')=="")?(-1):(parseInt(getValue('RemarkPri'))));
		}
		else
		{
			SubmitForm.addParameter('x.IGMPEnable',0);
		}
	}
	else
	{
		if (value == "Enable")
		{
			if( 0 == ROSTelecomFeature)
			{
        		SubmitForm.addParameter('x.IGMPEnable',1);	
			}
			value = getSelectVal('IGMPWorkMode');
			if(CfgModeWord.toUpperCase() == 'TDE2')
			{
				if(getCheckVal('PROXYEnable') == "1")
				{
					value = "Proxy";
				}
				else
				{
					value = "Snooping";
				}
				
				SubmitForm.addParameter('x.SnoopingEnable', getCheckVal('SnoopingEnable'));	
			}
			else if( 0 == ROSTelecomFeature)
			{
				SubmitForm.addParameter('x.SnoopingEnable',1);
			}
			
			
        	if (value == "Proxy")
        	{
        		if( 0 == ROSTelecomFeature)
        		{
					SubmitForm.addParameter('x.ProxyEnable',1);		
        		}
				SubmitForm.addParameter('x.IGMPVersion',getSelectVal('IGMPProxyVersion'));
				SubmitForm.addParameter('x.Robustness',getValue('Robustness'));
				SubmitForm.addParameter('x.GenQueryInterval',getValue('GenQueryInterval'));
				SubmitForm.addParameter('x.GenResponseTime',getValue('GenResponseTime'));
				SubmitForm.addParameter('x.SpQueryNumber',getValue('SpQueryNumber'));
				SubmitForm.addParameter('x.SpQueryInterval',getValue('SpQueryInterval'));
				SubmitForm.addParameter('x.SpResponseTime',getValue('SpResponseTime'));				
                SubmitForm.addParameter('x.StartUpQueryInterval',getValue('StartupQueryInterval'));
				SubmitForm.addParameter('x.StartUpQueryCount',getValue('StartupQueryCount'));
				SubmitForm.addParameter('x.UnsolicitedReportInterval',getValue('UnsolicitedReportInterval'));
				SubmitForm.addParameter('x.RouterAlertEnable', getValue('RouterAlertEnable'));
				if(CfgModeWord.toUpperCase() != 'TDE2')
				{
					if( 0 == ROSTelecomFeature)
					{
						var wanProxyEnable = ((getSelectVal('BridgeWanProxyEnable') == "Enable") ? 1 :0);
				    	SubmitForm.addParameter('x.BridgeWanProxyEnable',wanProxyEnable);
					}
					SubmitForm.addParameter('x.PPPoEWanProxyMode',getSelectVal('PPPoEWanProxyMode'));
				}	
        	}
			else 
			{
				if( 0 == ROSTelecomFeature)
        		{
					SubmitForm.addParameter('x.ProxyEnable',0);
				}
				if('TDE2' != CfgModeWord.toUpperCase())
				{
					SubmitForm.addParameter('x.PPPoEWanSnoopingMode',getSelectVal('PPPoEWanSnoopingMode'));
				}
			}	
        	SubmitForm.addParameter('x.RemarkIPPrecedence',(getValue('RemarkIPPrecedence')=="")?(-1):(parseInt(getValue('RemarkIPPrecedence'))));
       		SubmitForm.addParameter('x.RemarkPri',(getValue('RemarkPri')=="")?(-1):(parseInt(getValue('RemarkPri'))));
   		}
   		else
    	{
       		 SubmitForm.addParameter('x.IGMPEnable',0);	
    	}
	}
	

	
    if(VIETTELFlag == 1)
    {
		var MultiAction = getSelectVal('ChooseDnMultiAction');
		var DnMultiVlanValue = getValue('DnMultiVlan');
		SubmitForm.addParameter('y.MultiCastVlanAct',MultiAction);
		if(MultiAction == 1)
		{
			SubmitForm.addParameter('y.MultiCastVlan',DnMultiVlanValue);
		}

		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		
		SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.Services.X_HW_IPTV' + '&y=InternetGatewayDevice.Services.X_HW_IPTV_VIETTEL'
								+ '&RequestFile=html/bbsp/igmp/igmp.asp');
    }
	else
	{
		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		
    	SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.Services.X_HW_IPTV'
								+ '&RequestFile=html/bbsp/igmp/igmp.asp');
	}

    setDisable('btnApply',1);
    setDisable('cancelValue',1);
}

if(GetCfgMode().OSK == "1")
{
	igmp_language['bbsp_enableigmpmh'] = igmp_language['bbsp_enableigmpmh_Multicast'];
	igmp_language['bbsp_enable_Gateway'] = igmp_language['bbsp_enable_GatewayMode'];
	igmp_language['bbsp_disable_Bridge'] = igmp_language['bbsp_disable_BridgeMode'];
}

function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("igmptitle", GetDescFormArrayById(igmp_language, "bbsp_mune"), GetDescFormArrayById(igmp_language, "bbsp_igmp_title"), false);
</script>
<div class="title_spread"></div>

<form id="ConfigForm">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="IGMPEnable"                RealType="DropDownList"       DescRef="bbsp_enableigmpmh"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.IGMPEnable"     Elementclass="width_135px"     InitValue="[{TextRef:'bbsp_disable_Bridge',Value:'Disable'},{TextRef:'bbsp_enable_Gateway',Value:'Enable'}]" ClickFuncApp="onChange=IGMPEnableChange"/>
		<li   id="PROXYEnable"               RealType="CheckBox"           DescRef="bbsp_proxyenablemh"               RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.ProxyEnable"    InitValue="Empty"      ClickFuncApp="onclick=ProxyEnableChange"/>
		<li   id="SnoopingEnable"            RealType="CheckBox"           DescRef="bbsp_snoopingenablemh"            RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SnoopingEnable"    InitValue="Empty"   />
		<li   id="IGMPSNOOPINGEnable"        RealType="DropDownList"       DescRef="bbsp_enableigmpsnoopingmh"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SnoopingEnable"     Elementclass="width_135px"      InitValue="[{TextRef:'bbsp_disable',Value:'Disable'},{TextRef:'bbsp_enable',Value:'Enable'}]" ClickFuncApp="onchange=IGMPSNOOPINGEnableChange"/>
		<div  id="SpaceOption" class="height5p"></div>
		<li   id="IGMPPROXYEnable"           RealType="DropDownList"       DescRef="bbsp_enableigmpproxymh"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.ProxyEnable"     Elementclass="width_135px"      InitValue="[{TextRef:'bbsp_disable',Value:'Disable'},{TextRef:'bbsp_enable',Value:'Enable'}]" ClickFuncApp="onchange=IGMPPROXYEnableChange"/>
		<tbody id='HomeGatewayInfo'>  
		<li   id="IGMPWorkMode"              RealType="DropDownList"       DescRef="bbsp_igmpmodemh"                  RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"     Elementclass="width_135px"      InitValue="[{TextRef:'bbsp_Snooping',Value:'Snooping'},{TextRef:'bbsp_Proxy',Value:'Proxy'}]" ClickFuncApp="onchange=IGMPWorkModeChange"/>
		<li   id="BridgeWanProxyEnable"      RealType="DropDownList"       DescRef="bbsp_enableBridgeWanProxymh"      RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.BridgeWanProxyEnable"     Elementclass="width_135px"     InitValue="[{TextRef:'bbsp_disable',Value:'Disable'},{TextRef:'bbsp_enable',Value:'Enable'}]"/>
		<li   id="PPPoEWanProxyMode"         RealType="DropDownList"       DescRef="bbsp_PPPoEWanProxyModemh"         RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.PPPoEWanProxyMode"     Elementclass="width_135px"     InitValue="[{TextRef:'bbsp_IPoEAndPPPoERos',Value:'IPoEAndPPPoE'},{TextRef:'bbsp_IPoERos',Value:'IPoE'},{TextRef:'bbsp_PPPoERos',Value:'PPPoE'}]"/>
		<li   id="PPPoEWanSnoopingMode"      RealType="DropDownList"       DescRef="bbsp_PPPoEWanSnoopingModemh"      RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.PPPoEWanSnoopingMode"     Elementclass="width_135px"     InitValue="[{TextRef:'bbsp_IPoEAndPPPoERos',Value:'IPoEAndPPPoE'},{TextRef:'bbsp_IPoERos',Value:'IPoE'},{TextRef:'bbsp_PPPoERos',Value:'PPPoE'}]"/>
		<li   id="IGMPProxyVersion"          RealType="DropDownList"       DescRef="bbsp_proxyversionmh"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.IGMPVersion"     Elementclass="width_135px"      InitValue="[{TextRef:'bbsp_v2',Value:'2'},{TextRef:'bbsp_v3',Value:'3'}]" ClickFuncApp="onchange=IGMPProxyVersionChange"/>
		<li   id="RemarkIPPrecedence"        RealType="TextBox"            DescRef="bbsp_iptosmh"                     RemarkRef="bbsp_numrange"      ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.RemarkIPPrecedence"    InitValue="Empty"  MaxLength="19"/>
		</tbody> 
		<li   id="RemarkPri"                 RealType="TextBox"            DescRef="bbsp_802mh"                       RemarkRef="bbsp_numrange"      ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.RemarkPri"    InitValue="Empty"  MaxLength="19"/>
		<li   id="Robustness"                RealType="TextBox"            DescRef="bbsp_robustnessmh"                RemarkRef="bbsp_span1"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Robustness"    InitValue="Empty"  MaxLength="19"/>
		<li   id="GenQueryInterval"          RealType="TextBox"            DescRef="bbsp_intervalmh"                  RemarkRef="bbsp_span2"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.GenQueryInterval"    InitValue="Empty"  MaxLength="19"/>
		<li   id="GenResponseTime"           RealType="TextBox"            DescRef="bbsp_timemh"                      RemarkRef="bbsp_span3"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.GenResponseTime"    InitValue="Empty"  MaxLength="19"/>
		<li   id="SpQueryNumber"             RealType="TextBox"            DescRef="bbsp_snummh"                      RemarkRef="bbsp_span4"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.SpQueryNumber"    InitValue="Empty"  MaxLength="19"/>
		<li   id="SpQueryInterval"           RealType="TextBox"            DescRef="bbsp_sintervalmh"                 RemarkRef="bbsp_span5"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.SpQueryInterval"    InitValue="Empty"  MaxLength="19"/>
		<li   id="SpResponseTime"            RealType="TextBox"            DescRef="bbsp_stimemh"                     RemarkRef="bbsp_span6"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.SpResponseTime"    InitValue="Empty"  MaxLength="19"/>
		<li   id="StartupQueryInterval"      RealType="TextBox"            DescRef="bbsp_stupqinmh"                   RemarkRef="bbsp_span7"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.StartUpQueryInterval"    		InitValue="Empty"  MaxLength="19"/>
		<li   id="StartupQueryCount"         RealType="TextBox"            DescRef="bbsp_stupqcountmh"                RemarkRef="bbsp_span8"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.StartUpQueryCount"    			InitValue="Empty"  MaxLength="19"/>
		<li   id="UnsolicitedReportInterval" RealType="TextBox"            DescRef="bbsp_unsreportinmh"               RemarkRef="bbsp_span9"         ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.UnsolicitedReportInterval"    	InitValue="Empty"  MaxLength="19"/>
		<li   id="ChooseDnMultiAction"       RealType="DropDownList"       DescRef="bbsp_igmp_multiaction"     		  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty" 
		InitValue="[{TextRef:'bbsp_igmp_stripping',Value:'2'},{TextRef:'bbsp_igmp_specified',Value:'1'}]" ClickFuncApp="onchange=OnChooseDnMultiAction"/>                                                                   
        <li   id="DnMultiVlan"           RealType="TextBox"          DescRef="bbsp_igmp_multivlan"         RemarkRef="bbsp_igmp_multivlan_range"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="Empty"  Maxlength="255" InitValue="Empty"/>
        <li   id="RouterAlertEnable" RealType="DropDownList" DescRef="bbsp_RouterAlertEnable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.RouterAlertEnable" Elementclass="width_135px" InitValue="[{TextRef:'bbsp_disable_Bridge',Value:'0'},{TextRef:'bbsp_enable_Gateway',Value:'1'}]" />
		<script>
			var TableClass = new stTableClass("width_per40", "width_per60", "ltr");
			var IgmpConfigFormList = new Array();
			IgmpConfigFormList = HWGetLiIdListByForm("ConfigForm", null);
			var formid_hide_id = null;
			HWParsePageControlByID("ConfigForm", TableClass, igmp_language, formid_hide_id);
		</script>
	</table>
	<table cellpadding="0" cellspacing="1" width="100%" class="table_button">
	     <tr>
		    <td class="width_per25"></td>
            <td class="table_submit">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                <button id="btnApply" name="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit();"><script>document.write(igmp_language['bbsp_app']);</script></button>
                <button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px"  type="button" onClick="CancelConfig();"><script>document.write(igmp_language['bbsp_cancel']);</script></button>
            </td>
            
        </tr>        
    </table>
</form>
<div style="height:10px;"></div>

</body>
</html>
