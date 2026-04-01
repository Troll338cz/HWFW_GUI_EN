<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="Javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wandns.asp"></script>
<script language="javascript" src="../common/wan_control.asp"></script>
<title>Dynamic Route</title>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">



var currentFile="dynamicroute.asp";

var appName = navigator.appName;
var TableName = "Ipv4DynamicRouteConfigList";
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var isMegacablePWD = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
		
function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i < all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		setObjNoEncodeInnerHtmlValue(b, droute_language[b.getAttribute("BindText")]);
	}
}

function filterWan(WanItem)
{
    if (!(WanItem.Tr069Flag == "0" && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))) {
        return false;
    }
    if (curCfgModeWord.toUpperCase() == "TRIPLETAP" || curCfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || curCfgModeWord.toUpperCase() == "TRIPLETAP6" || curCfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
        if (WanItem.domain.indexOf(8) > -1) {
            return false;
        }
    }
    return true;
}

function RouterInfoLanItem(_Domain, _RouterProtocol, _RouterProtocolMode)
{
	this.domain = _Domain;
	this.Protocol = _RouterProtocol;
	this.Mode = _RouterProtocolMode;
	this.Interface = "br" + ((parseInt(_Domain.split(".")[5]) - 1) > 0 ? "0:0":"0");
}
var LANRouter = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1, X_HW_RouteProtocolRx|X_HW_RouteProtocolRxMode,RouterInfoLanItem);%>;

var WanInfo = GetWanListByFilter(filterWan);

var AddFlag = true;
var routeIdx = -1;


function getWanOfDynamicRoute(val)
{
   for (var i = 0; i < WanInfo.length; i++)
   {
      if (WanInfo[i].domain == val)
	  {
	      return WanInfo[i];
	  }
   }
   return "&nbsp;";
}

function GetRouterMode(Interface,SendRA,ReceiveRA)
{
	var  RouteMode = "";
	if( IsWanByFilter(Interface,null) == true)
	{
		
		if (IsWanByFilter(Interface,filterInternetOrIPTVWan) == true)
		{
			RouteMode = "Passive";
		}
		else
		{
			if((SendRA == "1") && (ReceiveRA == "1"))
			{
				RouteMode = "Active";
			}
			else if ((SendRA == "0") && (ReceiveRA == "1"))
			{
				RouteMode = "Passive";
			}
		}
		
	}
	else
	{
		if((SendRA == "1") && (ReceiveRA == "1"))
		{
			RouteMode = "Active";
		}
		else if ((SendRA == "0") && (ReceiveRA == "1"))
		{
			RouteMode = "Passive";
		}
	}
	return RouteMode;
}


function stDynamicRoute(domain, Enable, Interface, Protocol, SendRA, ReceiveRA, AuthMode)
{
    this.domain = domain;
    this.Enable = Enable;
	this.Interface = Interface;
	this.Protocol = Protocol;
	this.Mode = GetRouterMode(Interface,SendRA,ReceiveRA);  
	this.AuthMode = AuthMode;
	this.AuthKey = "********" ;
}      


var AllWanInfoTemp = GetWanList();
var DynamicRoutes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_RIP.InterfaceSetting.{i},Enable|Interface|Protocol|SendRA|ReceiveRA|AuthMode,stDynamicRoute);%>;  

var DynamicRoute = new Array();
var listNum = 10;

function IsWanByFilter(Interface,filterFunction)
{
	
	var wandomain_len = 0;
	var temp_domain = null;
	for(var k = 0; k < AllWanInfoTemp.length; k++ )
	{            
		wandomain_len = AllWanInfoTemp[k].domain.length;
		temp_domain = Interface;
		if (domainTowanname(temp_domain) == domainTowanname(AllWanInfoTemp[k].domain))
		{	
			if (filterFunction != null && filterFunction != undefined)
			{
				return filterFunction(AllWanInfoTemp[k]);	
			}
			return  true ;
		}
	} 
	return false; 
}

function filterIPv4RouteWan(WanItem)
{
	if(WanItem.Mode == "IP_Routed" && WanItem.IPv4Enable == "1")
		return true;
	return false;
}


function filterInternetOrIPTVWan(WanItem)
{
	
	 if((-1 != WanItem.ServiceList.toUpperCase().indexOf("INTERNET"))
			||(-1 != WanItem.ServiceList.toUpperCase().indexOf("OTHER"))
			||(-1 != WanItem.ServiceList.toUpperCase().indexOf("IPTV")))
	{
		return false ;
		
	}
	
	return true;
}


function IsLAN(Interface)
{
	for(var k = 0; k < LANRouter.length-1; k++ )
	{            
		if (LANRouter[k].domain == Interface)
		{	
			return  true ;
		}
	} 
	return false;
}
var Idx = 0;
for (var i = 0; i < DynamicRoutes.length-1; i++)
{
	
	if (IsWanByFilter(DynamicRoutes[i].Interface,null)== true )
	{
		if( IsWanByFilter(DynamicRoutes[i].Interface,filterIPv4RouteWan) == true)
		{
			DynamicRoute[Idx] = DynamicRoutes[i];
			Idx ++;
		}
		continue ;
	}
	if(IsLAN(DynamicRoutes[i].Interface) == true)
	{
		DynamicRoute[Idx] = DynamicRoutes[i];
		Idx ++;
	}
}


var RouteInfoNr = Idx;

function Ipv4DynamicRouteConfigListselectRemoveCnt(val)
{

}

function showlistcontrol()
{
	var ColumnNum = 7;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	var i = 0;
	
	if( 0 == RouteInfoNr )
	{		
		TableDataInfo[Listlen] = new stDynamicRoute();
		TableDataInfo[Listlen].domain = "--";
		TableDataInfo[Listlen].Interface = "--";
		TableDataInfo[Listlen].Enable = "--";
		TableDataInfo[Listlen].Protocol = "--";
		TableDataInfo[Listlen].Mode = "--";
		TableDataInfo[Listlen].AuthMode = "--";
		TableDataInfo[Listlen].AuthKey = "--";
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, Ipv4DynamicRouteConfiglistInfo, droute_language, null);
		return ;
	}

	for(i = 0; i < RouteInfoNr; i++)   
	{
	    if ((DynamicRoute[i].Interface) != "")
        {
			TableDataInfo[Listlen] = new stDynamicRoute();
			TableDataInfo[Listlen].domain = DynamicRoute[i].domain;
			if (IsWanByFilter(DynamicRoute[i].Interface,null) == true)
			{
				TableDataInfo[Listlen].Interface = MakeWanName(getWanOfDynamicRoute(DynamicRoute[i].Interface));
			}
			else
			{
				TableDataInfo[Listlen].Interface = "br" + ((parseInt(DynamicRoute[i].Interface.split(".")[5]) - 1)>0?"0:0":"0");
			}
			TableDataInfo[Listlen].Enable = DynamicRoute[i].Enable == 1 ? porttrigger_language["bbsp_porttrigger_enable"] : porttrigger_language["bbsp_porttrigger_disable"];
			TableDataInfo[Listlen].Protocol = DynamicRoute[i].Protocol;
			if("Passive" == DynamicRoute[i].Mode)
			{
				TableDataInfo[Listlen].Mode = droute_language["bbsp_mode_passive"];
			}
			else if("Active" == DynamicRoute[i].Mode)
			{
				TableDataInfo[Listlen].Mode = droute_language["bbsp_mode_active"];
			}
			
			if("ClearText" == DynamicRoute[i].AuthMode)
			{
				TableDataInfo[Listlen].AuthMode =  droute_language["bbsp_authmode_cleartext"];
			}
			else if("Off" == DynamicRoute[i].AuthMode)
			{
				TableDataInfo[Listlen].AuthMode =  droute_language["bbsp_authmode_off"];
			}
			else
				TableDataInfo[Listlen].AuthMode = DynamicRoute[i].AuthMode;
			TableDataInfo[Listlen].AuthKey = DynamicRoute[i].AuthKey;
			Listlen++;
	    }
	}
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, Ipv4DynamicRouteConfiglistInfo, droute_language, null);
}


function LoadFrame()
{
    if ((curCfgModeWord.toUpperCase() != "ROSUNION") || ((curCfgModeWord.toUpperCase() == "ROSUNION") &&
	    (curUserType != "1"))) {
        return;
    }
    var BoxList = document.getElementsByName(TableName + 'rml');
    for (var i = 0; i < BoxList.length; i++) {
        var number = "Ipv4DynamicRouteConfigList_" + i + "_1";
        if ((document.getElementById(number).innerHTML.indexOf("VOIP") >= 0) ||
            (document.getElementById(number).innerHTML.indexOf("TR069") >= 0)) {
            var id = "Ipv4DynamicRouteConfigList_rml" + i;
            setDisable(id, 1);
        }
    }
}

var isRosunionRouteFilter = true;

function WriteOption()
{
	$("#Interface").empty();
	var i;
	for (i = 0; i < WanInfo.length; i++)
    {
	    if ((curCfgModeWord.toUpperCase() == "ROSUNION") && (curUserType != '0') && (isClickAdd || isNeedFilter)) {
			if ((WanInfo[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >=0) || (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("VOIP") >=0) || (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("TR069") >=0)) {
				continue;
			}
		}

	   if (viettelflag ==1)
       {
            if (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("TR069") >=0)
            {
                continue;
            }         
       }
		
   	   if (WanInfo[i].Mode == "IP_Routed" && WanInfo[i].IPv4Enable == "1")
   	   {
			 $("#Interface").append('<option value=' + WanInfo[i].domain + ' id="wan_'
                        + i + '">'
                        + MakeWanName1(WanInfo[i]) + '</option>');
   	   }
    }      
	for(i = 0 ; i < LANRouter.length-1 ; i++)
	{
		
		$("#Interface").append('<option value=' + LANRouter[i].domain + ' id="lan_'
                        + i + '">'
                        + LANRouter[i].Interface + '</option>');
	}
}


function OnDeleteButtonClick(TableID)
{      
    if ((DynamicRoute.length) == 0)
	{	
	    return;
	}
	
	if (routeIdx == -1)
	{	
	    return;
	}
	var CheckBoxList = document.getElementsByName(TableName + "rml");
	var Form = new webSubmitForm();
	var Count = 0;
	for (var i = 0; i < CheckBoxList.length; i++)
	{
		if (CheckBoxList[i].checked != true)
		{
			continue;
		}

        var numberId = "Ipv4DynamicRouteConfigList_" + i + "_1";
        if (((curUserType == "1") && (curCfgModeWord.toUpperCase() == "ROSUNION")) &&
            ((document.getElementById(numberId).innerHTML.indexOf("VOIP") >= 0) ||
            (document.getElementById(numberId).innerHTML.indexOf("TR069") >= 0))) {
            continue;
        }

		Count++;
		Form.addParameter(CheckBoxList[i].value,"");
	}
	if (Count <= 0)
	{
		return false;
	}
        
    setDisable("btnApply_ex",1);
    setDisable("canelButton",1);
	Form.addParameter("x.X_HW_Token", getValue("onttoken"));
	Form.setAction("del.cgi?" +"x=InternetGatewayDevice.X_HW_RIP.InterfaceSetting" + "&RequestFile=html/bbsp/dynamicroute/dynamicroute.asp");
	Form.submit();
}

function CheckForm_Interface(Interface)
{
	if (Interface.length == 0  )
    {
		AlertEx(droute_language["bbsp_alert_setinterface"]);	
        return false;
    }
    return true;
}

function CheckForm_AuthKey(AuthMode , AuthKey)
{
	if("Off" == AuthMode )
		return true ;
		
	if(AuthKey.length == 0)
	{
		AlertEx(droute_language["bbsp_password_null"]);
		return false;
	}
	if( "MD5" == AuthMode || "ClearText"== AuthMode)
	{
		if(AuthKey.length >16)
		{
			AlertEx(droute_language["bbsp_password_md5_cleartext_len"]);
			return false;
		}
	}
	else if ("HMAC-SHA256" == AuthMode)
	{
		if(AuthKey.length >32)
		{
			AlertEx(droute_language["bbsp_password_hmac_sha256_len"]);
			return false;
		}
	}
	
	for (var iTemp = 0; iTemp < AuthKey.length; iTemp ++)
	{
		if (AuthKey.charCodeAt(iTemp) <= 0x20 || AuthKey.charCodeAt(iTemp) >= 0x7f)
		{	
			AlertEx(droute_language["bbsp_password_ilchar"]);
			return false;
		}
	}
	return true ;
}


function onSumbitCheck(DynamicRouteInfo)
{
	if (false == CheckForm_Interface(DynamicRouteInfo.Interface))
	{
		return false ;
	}
	
	if (false == CheckForm_AuthKey(DynamicRouteInfo.AuthMode, getValue("DynamicroutePassword")))
	{
		return false ;
	}
	return true ;
}
function IsRepeateConfig(DynamicRouteInfo)
{
	var i = 0;
    for (i = 0; i < DynamicRoute.length; i++)
    {
        if (DynamicRouteInfo.Interface == DynamicRoute[i].Interface)
        {
            return true;
        } 
    }
    return false;
}

function checkRipWan(DynamicRouteInfo)
{
	if ((1 == DynamicRouteInfo.Enable) && ('ACTIVE' == DynamicRouteInfo.Mode.toUpperCase()) && (DynamicRouteInfo.Interface.toUpperCase().indexOf("WANDEVICE") >= 0) )
	{
		if (false == ConfirmEx(droute_language["bbsp_ripwan_info"]))
		{
			return false;
		}
	}
	return true;
}

function CheckAddForm(Form)
{   
	var DynamicRouteInfo = GetInputDynamicRouteInfo();
   
	if(false == onSumbitCheck(DynamicRouteInfo))
    {
    	return false;
    }
    
    if (true == IsRepeateConfig(DynamicRouteInfo))
    {
        AlertEx(droute_language["bbsp_interfaceexist"]);
        return false;
    }
	
	if (false == checkRipWan(DynamicRouteInfo))
	{
		return false;
	}

	Form.addParameter("x.Protocol",DynamicRouteInfo.Protocol);
	Form.addParameter("x.SendRA",GetModeSendRA(getSelectVal("DynamicRouteMode")));
	Form.addParameter("x.ReceiveRA",GetModeReceiveRA(getSelectVal("DynamicRouteMode")));
    Form.addParameter("x.AuthMode",DynamicRouteInfo.AuthMode);
	Form.addParameter("x.Enable",DynamicRouteInfo.Enable);
	if("Off" == DynamicRouteInfo.AuthMode)
	{
		Form.addParameter("x.AuthKey","");	
	}
	else
	{
		Form.addParameter("x.AuthKey",getValue("DynamicroutePassword"));	
	}
	
	Form.addParameter("x.Interface",getSelectVal("Interface"));
    return true;
}
function CheckModifyForm(Form)
{   
	var DynamicRouteInfo = GetInputDynamicRouteInfo();
   
	if(false == onSumbitCheck(DynamicRouteInfo))
    {
    	return false;
    }
    
	if (false == checkRipWan(DynamicRouteInfo))
	{
		return false;
	}
	
	Form.addParameter("x.Protocol",DynamicRouteInfo.Protocol);
	Form.addParameter("x.SendRA",GetModeSendRA(getSelectVal("DynamicRouteMode")));
	Form.addParameter("x.ReceiveRA",GetModeReceiveRA(getSelectVal("DynamicRouteMode")));
    Form.addParameter("x.AuthMode",DynamicRouteInfo.AuthMode);
	Form.addParameter("x.Enable",DynamicRouteInfo.Enable);
	if("Off" == DynamicRouteInfo.AuthMode)
	{
		Form.addParameter("x.AuthKey","");
	}
	else
	{
		if((getValue("DynamicroutePassword") != DynamicRouteInfo.AuthKey) || ("Off" == DynamicRoute[routeIdx].AuthMode)) 
		{	
			Form.addParameter("x.AuthKey",getValue("DynamicroutePassword"));
		}
	}
	Form.addParameter("x.Interface",getSelectVal("Interface"));
    return true;
}


function GetModeSendRA(DynamicRouteMode)
{
	var SendRA = "0";
	if( "Passive" == DynamicRouteMode)
	{
		SendRA = "0";
	}
	else if( "Active" == DynamicRouteMode)
	{
		SendRA = "1";
	}
	return SendRA ;
}
function GetModeReceiveRA(DynamicRouteMode)
{
	var ReceiveRA = "0";
	if(("Passive" == DynamicRouteMode) || ("Active"== DynamicRouteMode))
		ReceiveRA = "1";
	return ReceiveRA ;
}

function GetInputDynamicRouteInfo()
{
	return new stDynamicRoute("",getCheckVal("DynamicRouteEnable"), getSelectVal("Interface"), getSelectVal("DynamicRouteProtocolType"),GetModeSendRA(getSelectVal("DynamicRouteMode")), GetModeReceiveRA(getSelectVal("DynamicRouteMode")), getSelectVal("DynamicRouteAuthMode"));
}

function MakeInterfaceName(interfaceType)
{
    if (interfaceType.indexOf("WANDevice") > -1) {
        return MakeWanName(getWanOfStaticRoute(interfaceType));
    } else if (interfaceType.indexOf("LANDevice") > -1) {
        return "br0";
    }

    return interfaceType;
}

function getWanOfStaticRoute(val)
{
    for (var i = 0; i < WanInfo.length; i++) {
        if (WanInfo[i].domain == val) {
            return WanInfo[i];
        }
    }
    return '&nbsp;';
}

function SubmitForm()
{   
    var Form = new webSubmitForm();
    if(AddFlag == false)
    {   
		
        if (CheckModifyForm(Form) == false)
        {
            return;
        }

        var interfaceType = MakeInterfaceName(getSelectVal('Interface'));
        if (((curUserType == "1") && (curCfgModeWord.toUpperCase() == "ROSUNION")) &&
            ((interfaceType.indexOf("VOIP") >= 0) || (interfaceType.indexOf("TR069") >= 0))) {
            return;
        }

		var routemain = DynamicRoute[routeIdx].domain;
		Form.addParameter("x.X_HW_Token", getValue("onttoken"));
		Form.setAction("set.cgi?x=" + routemain 
    		  	        + "&RequestFile=html/bbsp/dynamicroute/dynamicroute.asp");
		
    }
    else
    {
		if (CheckAddForm(Form) == false)
    	{
    	     return;
    	}
		Form.addParameter("x.X_HW_Token", getValue("onttoken"));
        Form.setAction("add.cgi?x=InternetGatewayDevice.X_HW_RIP.InterfaceSetting&RequestFile=html/bbsp/dynamicroute/dynamicroute.asp");  
    }

    setDisable("btnApply_ex",1);
    setDisable("canelButton",1);
    Form.submit();
	DisableRepeatSubmit();
}

function setCtlDisplay(record, WanIndex)
{
    if (record != null)
	{		
		setText("DynamicroutePassword","********");
		setCheck("DynamicRouteEnable", record.Enable);
    	setSelect("DynamicRouteAuthMode",record.AuthMode);
		setSelect("DynamicRouteMode",record.Mode);
		setSelect("DynamicRouteProtocolType",record.Protocol);
    	setSelect("Interface",record.Interface);
    }
    else
    {
		setText("DynamicroutePassword","********");
		setCheck("DynamicRouteEnable", "");
    	setSelect("DynamicRouteAuthMode","");
		setSelect("DynamicRouteMode","");
		setSelect("DynamicRouteProtocolType","");
    	setSelect("Interface","");
    }
	OnChangeInterface();
	OnChangeProtocol();
}

function setControl(index)
{
    var record;
    routeIdx = index;
    var dynamicRouteList = "Ipv4DynamicRouteConfigList_"+index+"_1";
    if (index == -1) {
        setDisable("Interface", 0);
        setDisable('btnApply_ex', 0);
        setDisable('canelButton', 0);
        setDisplay("ConfigForm", 1);
        AddFlag = true;
        if (isMegacablePWD === '1') {
            record = new stDynamicRoute("", "0", getSelectVal("Interface"), "RIPv2", "0", "1", "HMAC-SHA256");
        } else {
            record = new stDynamicRoute("", "1", getSelectVal("Interface"), "RIPv2", "0", "1", "HMAC-SHA256");
        }

        setCtlDisplay(record);
    } else if (index == -2) {
        setDisplay("ConfigForm", 0);
    } else {
        setDisplay("ConfigForm", 1);
        setDisable("Interface", 1);
        AddFlag = false;
        record = DynamicRoute[index];
        setCtlDisplay(record);
    }

    if ((curCfgModeWord.toUpperCase() == "ROSUNION") && (curUserType == "1") && (!isClickAdd)) {
        if ((document.getElementById(dynamicRouteList).innerHTML.indexOf("VOIP") >= 0) ||
            (document.getElementById(dynamicRouteList).innerHTML.indexOf("TR069") >= 0)) {
            setDisable('btnApply_ex', 1);
            setDisable('canelButton', 1);
        } else {
            setDisable('btnApply_ex', 0);
            setDisable('canelButton', 0);
        }
    }
}

function CancelValue()
{
    setDisplay("ConfigForm", 0);
	if (routeIdx == -1)
    {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length == 1)
        {
			
        }
        else if (tableRow.rows.length == 2)
        {
			
        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + "_record_0");
        }
    }
    else
    {
        var record = DynamicRoute[routeIdx];
		setCtlDisplay(record);
    }
}


function OnChangeAuthMode()
{
	var AuthMode = getValue("DynamicRouteAuthMode")	;
	var PasswordRemarkStr = "";
	if("Off" == AuthMode)
	{
		setDisable("DynamicroutePassword", 1);
	}
	else 
	{
		if("MD5" == AuthMode || "ClearText" == AuthMode)
		{
			PasswordRemarkStr = droute_language["bbsp_password_md5_cleartext_desc"]; 
		}
		else
		{
			PasswordRemarkStr = droute_language["bbsp_password_hmac_sha256_desc"]; 
		}
		setDisable("DynamicroutePassword", 0);
	}
	setElementInnerHtmlById("DynamicroutePasswordRemark", PasswordRemarkStr);
}

function OnChangeInterface()
{
	var RouteItem = new stDynamicRoute("","", getSelectVal("Interface"), "","", "", "");
	if(IsWanByFilter(RouteItem.Interface,filterInternetOrIPTVWan)== true)
	{
		setSelect("DynamicRouteMode", "Passive");
		setDisable("DynamicRouteMode", 1);
	}	   
	else
	{
		setDisable("DynamicRouteMode", 0);
	}
}
function OnChangeProtocol()
{
	
	var ProtocalType = getSelectVal("DynamicRouteProtocolType")	;

	if("RIPv1" == ProtocalType)
	{
		setSelect("DynamicRouteAuthMode","Off");
		setDisable("DynamicRouteAuthMode", 1);
	}
	else 
	{
		setDisable("DynamicRouteAuthMode", 0);
	}
	OnChangeAuthMode();
}


</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("ipv4dynamicroutetitle", GetDescFormArrayById(droute_language, "bbsp_mune"), GetDescFormArrayById(droute_language, "bbsp_title_prompt"), false);
</script> 
<div class="title_spread"></div>
	<script language="JavaScript" type="text/javascript">
	var Ipv4DynamicRouteConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center","DomainBox"),									
									new stTableTileInfo("bbsp_td_interfacename","align_center restrict_dir_ltr","Interface"),
									new stTableTileInfo("bbsp_td_ripstatus","align_center ","Enable"),
									new stTableTileInfo("bbsp_td_protocoltype","align_center","Protocol"),
									new stTableTileInfo("bbsp_td_mode","align_center","Mode"),
									new stTableTileInfo("bbsp_td_authmode","align_center","AuthMode"),
									new stTableTileInfo("bbsp_td_passwrod","align_center","AuthKey"),null);	
									
	showlistcontrol();
	</script>

	<form id="ConfigForm" style="display:none"> 
		<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
			<li   id="DynamicRouteEnable"				RealType="CheckBox"    		DescRef="bbsp_td_enablerip"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"		InitValue="Empty" />
			<li   id="DynamicRouteProtocolType"    		RealType="DropDownList"		DescRef="bbsp_td_protocoltype"         		RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.Protocol"   	Elementclass="width_260px "  				InitValue="[{TextRef:'bbsp_protocol_ripv1',Value:'RIPv1'},{TextRef:'bbsp_protocol_ripv2',Value:'RIPv2'},{TextRef:'bbsp_protocol_ripv1_v2',Value:'RIPv1_v2'}]"  ClickFuncApp="onChange=OnChangeProtocol"/>
			<li   id="DynamicRouteMode"      			RealType="DropDownList"		DescRef="bbsp_td_mode"         					RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="Empty"   		Elementclass="width_260px " 				InitValue="[{TextRef:'bbsp_mode_active',Value:'Active'},{TextRef:'bbsp_mode_passive',Value:'Passive'}]" />
			<li   id="DynamicRouteAuthMode"     	  	RealType="DropDownList"		DescRef="bbsp_td_authmode"        				RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.AuthMode"  	Elementclass="width_260px "  				InitValue="[{TextRef:'bbsp_authmode_off',Value:'Off'},{TextRef:'bbsp_authmode_md5',Value:'MD5'},{TextRef:'bbsp_authmode_hmac_sha256',Value:'HMAC-SHA256'},{TextRef:'bbsp_authmode_cleartext',Value:'ClearText'}]"  ClickFuncApp="onChange=OnChangeAuthMode"/>
			<li   id="DynamicroutePassword"          	RealType="TextBox"  		DescRef="bbsp_td_passwrod"      				RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.AuthKey"    	Elementclass="width_254px"     				InitValue="Empty" />
			<li   id="Interface"      					RealType="DropDownList"  	DescRef="bbsp_td_interfacename"          			RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"  	Elementclass="width_260px restrict_dir_ltr" InitValue="Empty"  ClickFuncApp="onchange=OnChangeInterface"/>                                                                   
			<script language="JavaScript" type="text/javascript">
				var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
				var DynamicRouteFormList = new Array();
				DynamicRouteFormList = HWGetLiIdListByForm("ConfigForm", null);
				var formid_hide_id = null;
				HWParsePageControlByID("ConfigForm", TableClass, droute_language, formid_hide_id);
				WriteOption();
			</script>
		</table>
		<table class="table_button" cellspacing="1" id="cfg_table" width="100%"> 
		  <tr> 
			<td class='width_per25'>&nbsp;</td>
			<td class="table_submit width_per75"> 
			  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			  <button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();"><script>document.write(droute_language['bbsp_app']);</script></button>
			  <button id="canelButton" name="canelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();"><script>document.write(droute_language['bbsp_cancel']);</script></button>  
			</td> 
		  </tr>   
		</table>
  </form>  
</body>
</html>

