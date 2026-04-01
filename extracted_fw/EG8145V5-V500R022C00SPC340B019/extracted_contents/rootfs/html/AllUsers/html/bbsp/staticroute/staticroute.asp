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
<title>Static Route</title>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var SingtelModeEX = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL_EX);%>';
var IPv4SRoutelistMaxNum = '<%HW_WEB_GetSPEC(BBSP_SPEC_IPV4_ROUTE_MAXNUM.UINT32);%>';
var currentFile='staticroute.asp';
var appName = navigator.appName;
var TableName = "Ipv4StaticRouteConfigList";
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var cfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var TDESME2Modeflg ='<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDESME2);%>';
var MngtSDcu ='<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SDCU);%>';
var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';
var srcIpRoutingFlag ='<%HW_WEB_GetFeatureSupport(FT_SRC_IP_ROUTING);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var exchangeWan = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_EXCHANGE_NAME_WAN);%>';
var isMegacableFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
var is5182H = "<%HW_WEB_GetFeatureSupport(BBSP_FT_DATAPATH_NP);%>";
var UnicomFlag = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>";
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var isUNICOMFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>';
function isGuangdongUNICOM(){
    return (CfgFtWordArea === '020' && isUNICOMFlag === '1');
}
function stVXLANConfig(domain, RemoteEndPoints, WANInterface, VNI, Enable, WorkMode, MaxMTUSize, IPAddress, SubnetMask, AddressingType, NATEnabled, DNSServers_Master, DNSServers_Slave, DefaultGateway, X_HW_VLANEnable, X_HW_VLAN, X_HW_LANInterface, OutWANInterface) {
    this.domain = domain;
    this.RemoteEndPoints = RemoteEndPoints;
    this.WANInterface = WANInterface;
    this.VNI = VNI;
    this.Enable = Enable;
    this.WorkMode = WorkMode;
    this.MaxMTUSize = MaxMTUSize;
    this.AddressingType = AddressingType;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;
    this.NATEnabled = NATEnabled;
    this.DNSServers_Master = DNSServers_Master;
    this.DNSServers_Slave = DNSServers_Slave;
    this.DefaultGateway = DefaultGateway;
    this.VlanEnable = X_HW_VLANEnable;
    this.X_HW_VLAN = X_HW_VLAN;
    this.X_HW_LANInterface = X_HW_LANInterface;
    this.OutWANInterface = OutWANInterface;
}

var VXLAN_VXLANConfig = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.VXLANMAP.VXLANView.{i},RemoteEndPoints|WANInterface|VNI|Enable|WorkMode|MaxMTUSize|IPAddress|SubnetMask|AddressingType|NATEnabled|DNSServers_Master|DNSServers_Slave|DefaultGateway|X_HW_VLANEnable|X_HW_VLAN|X_HW_LANInterface|OutWANInterface, stVXLANConfig);%>;

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
		setObjNoEncodeInnerHtmlValue(b, sroute_language[b.getAttribute("BindText")]);
	}
}

function stDftRoute(domain,autoenable,ip,wandomain)
{
	this.domain 	= domain;
	this.autoenable = autoenable;
	this.ip 		= ip;
	this.wandomain 	= wandomain;
}

function filterWan(WanItem)
{
    if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false))) {
        return false;
    }
    if (curCfgModeWord.toUpperCase() == "TRIPLETAP" || curCfgModeWord.toUpperCase() == "TRIPLETAPNOGM" || curCfgModeWord.toUpperCase() == "TRIPLETAP6" || curCfgModeWord.toUpperCase() == "TRIPLETAP6PAIR") {
        if (WanItem.domain.indexOf(8) > -1) {
            return false;
        }
    }
    return true;
}

var WanInfo = GetWanListByFilter(filterWan);
var AddFlag = true;
var routeIdx = -1;
var routeIdxSubmit = -1;

function getWanOfStaticRoute(val)
{
   for (var i = 0; i < WanInfo.length; i++)
   {
      if (WanInfo[i].domain == val)
	  {
	      return WanInfo[i];
	  }
   }
   return '&nbsp;';
}

function stStaticRoute(domain, StaticRouteDomain,DestIPAddress, Gateway, mask, Interface, SourceIPAddress)
{
    this.domain = domain;
    this.StaticRouteDomain = StaticRouteDomain;
    this.DestIPAddress = DestIPAddress;
    this.Gateway = Gateway;
    this.mask = mask;
    this.Interface = Interface;
    this.SourceIPAddress = SourceIPAddress;
    while ((this.Interface != null) && (this.Interface.substr(this.Interface.length-1,this.Interface.length)=="."))
    {
        this.Interface = this.Interface.substr(0,this.Interface.length-1);
    }
}
var AllWanInfoTemp = GetWanList();

var StaticRoutes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Layer3Forwarding.Forwarding.{i},X_HW_DomainName|DestIPAddress|GatewayIPAddress|DestSubnetMask|Interface|SourceIPAddress,stStaticRoute);%>;
var StaticRoute = new Array();
var listNum = 10;

function FindWanInfo(Item)
{
	if(Item.Interface.indexOf("WANDevice") == -1)
	{
		return true;
	}
	
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < AllWanInfoTemp.length; k++ )
	{            
		wandomain_len = AllWanInfoTemp[k].domain.length;
		temp_domain = Item.Interface;

		if (domainTowanname(temp_domain) == domainTowanname(AllWanInfoTemp[k].domain))
		{
		    if (SingtelModeEX == 1)
		    {
				if ((AllWanInfoTemp[k].ServiceList.toString().toUpperCase().indexOf("IPTV") >=0) || (AllWanInfoTemp[k].ServiceList.toString().toUpperCase().indexOf("VOIP") >=0))
				{
					return false;	
				}
		    }
			return true;
		}
	} 
	
	return false;
}

var Idx = 0;
for (var i = 0; i < StaticRoutes.length - 1; i++)
{
    if ((FindWanInfo(StaticRoutes[i]) == true) && ((srcIpRoutingFlag == 0) || (StaticRoutes[i].SourceIPAddress == ''))){
        StaticRoute[Idx] = StaticRoutes[i];
        Idx ++;
    }
}

var RouteInfoNr = Idx;

var firstpage = 1;
if(RouteInfoNr == 0)
{
	firstpage = 0;
}

var lastpage = RouteInfoNr/listNum;
if(lastpage != parseInt(lastpage,10))
{
	lastpage = parseInt(lastpage,10) + 1;	
}

var page = firstpage;

if( window.location.href.indexOf("del.cgi") == -1 && window.location.href.indexOf("add.cgi") == -1 && window.location.href.indexOf("set.cgi") == -1 && window.location.href.indexOf("?") > 0 )
{
	page = parseInt(window.location.href.split("?")[1],10); 
}

if(page < firstpage)
{
	page = firstpage;
}
else if( page > lastpage ) 
{
	page = lastpage;
}

function IsValidPage(pagevalue)
{
	if (true != isInteger(pagevalue))
	{
		return false;
	}
	return true;
}

function MakeInterfaceName(_interface)
{
	if (_interface.indexOf("WANDevice") > -1)
	{
		return MakeWanName(getWanOfStaticRoute(_interface));
	}
	else if(_interface.indexOf("LANDevice") > -1)
	{
		return "br0";
	}
	else if (_interface.indexOf("VXLANMAP") > -1)
	{
		return GetVxlanName(_interface);
	} else
	{
		return _interface;
	}
}

function showlist(startlist , endlist)
{
	var ColumnNum = 5;
	var ShowButtonFlag = false;
	var TableDataInfo = new Array();
	var Listlen = 0;
	var i = 0;
	
	if (GetCfgMode().BJUNICOM != "1")
	{
		ShowButtonFlag = true;
	}
	
	if( 0 == RouteInfoNr )
	{
		TableDataInfo[Listlen] = new stStaticRoute();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].Interface = '--';
		TableDataInfo[Listlen].DestIPAddress = '--';
		TableDataInfo[Listlen].GatewayIPAddress = '--';
		TableDataInfo[Listlen].DestSubnetMask = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, Ipv4StaticRouteConfiglistInfo, sroute_language, null);
		return;
	}

	for(i=startlist;i <= endlist - 1;i++)   
	{
		TableDataInfo[Listlen] = new stStaticRoute();
		TableDataInfo[Listlen].domain = StaticRoute[i].domain;
		TableDataInfo[Listlen].Interface = MakeInterfaceName(StaticRoute[i].Interface);
		if ("" != StaticRoute[i].DestIPAddress)
		{
			TableDataInfo[Listlen].DestIPAddress = StaticRoute[i].DestIPAddress;
		}
		else
		{
			TableDataInfo[Listlen].DestIPAddress = StaticRoute[i].StaticRouteDomain;
		}
		TableDataInfo[Listlen].GatewayIPAddress = StaticRoute[i].Gateway;
		TableDataInfo[Listlen].DestSubnetMask = StaticRoute[i].mask;
		Listlen++;		
	}
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, Ipv4StaticRouteConfiglistInfo, sroute_language, null);
}

function showlistcontrol()
{
	if(RouteInfoNr == 0)
	{
		showlist(0 , 0);
	}
	else if( RouteInfoNr >= listNum*parseInt(page,10) )
	{
		showlist((parseInt(page,10)-1)*listNum , parseInt(page,10)*listNum);
	}
	else
	{
		showlist((parseInt(page,10)-1)*listNum , RouteInfoNr);
	}
}

function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		return;
	}
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitprv()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page--;
	window.location = currentFile + "?" + parseInt(page,10);
}

function submitnext()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page++;
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		return;
	}
	
	window.location= currentFile + "?" + parseInt(page,10);
}

function submitjump()
{
	var jumppage = getValue('pagejump');
	if((jumppage == '') || (isInteger(jumppage) != true))
	{
		setText('pagejump', '');
		return;
	}
	
	jumppage = parseInt(jumppage, 10);
	if(jumppage < firstpage)
	{
		jumppage = firstpage;
	}
	if(jumppage > lastpage)
	{
		jumppage = lastpage;
	}
	window.location= currentFile + "?" + jumppage;
}

function LoadFrame()
{	
    if (GetCfgMode().BJUNICOM == "1")
    {
		setDisable("StaticRouteCfgMode1", 1);
		setDisable("StaticRouteCfgMode2", 1);
        setDisable("StaticRouteDomain", 1);
        setDisable("DestIPAddress", 1);
        setDisable("DestSubnetMask", 1);
        setDisable("GatewayIPAddress", 1);
        setDisable("Interface", 1);        
    }
    StaticRouteCfgIpOrDomain();

    if (cfgModeWord.toUpperCase() == "ROSUNION") {
        var BoxList = document.getElementsByName(TableName + 'rml');
        if (curUserType == "1") {
            for (var i = 0; i < BoxList.length; i++) {
                var number = "Ipv4StaticRouteConfigList_" + i + "_1";
                if ((document.getElementById(number).innerHTML.indexOf("VOIP") >= 0) || (document.getElementById(number).innerHTML.indexOf("TR069") >= 0)) {
                    var id = "Ipv4StaticRouteConfigList_rml"+i;
                    setDisable(id, 1);
                }
            }
        }
    }
	if (curUserType === '1' && isGuangdongUNICOM()) {
		pageDisable();
		setDisplay("Newbutton",0);
      	setDisplay("DeleteButton",0);
		setDisplay("btnApply_ex",0);
      	setDisplay("canelButton",0);
	}
}

function AddSubmitParam(SubmitForm,type)
{

}

function GetVxlanName(domain) {
    
    for (var i = 0; i < VXLAN_VXLANConfig.length; i++) {
        console.log(domain);
        console.log(VXLAN_VXLANConfig[i].domain);
        if (domain == VXLAN_VXLANConfig[i].domain) {
            break;
        }
    }

    var words = domain.split(".");
    var innerText = words[words.length - 1] + '_VXLAN_INTERFACE_VNI_' + VXLAN_VXLANConfig[i].VNI;
    return innerText;
}

var isRosunionRouteFilter = true;

function WriteOption()
{
	$("#Interface").empty();
	if (exchangeWan == "1") {
		$("#Interface").append('<option value="eRouter">' +
		"eRouter" + '</option>');
		$("#Interface").append('<option value="eMTA">' +
		"eMTA" + '</option>');
		$("#Interface").append('<option value="eSTB">' +
		"eSTB" + '</option>');
		$("#Interface").append('<option value="INTERNET">' +
		"INTERNET" + '</option>');
		$("#Interface").append('<option value="TR069_IPTV">' +
		"TR069_IPTV" + '</option>');
		$("#Interface").append('<option value="VoIP">' +
		"VoIP" + '</option>');
		$("#Interface").append('<option value="INTERNET_TR069_IPTV_VoIP">' +
		"INTERNET_TR069_IPTV_VoIP" + '</option>');
	} else {
		if (GetCfgMode().PCCWHK == "1") {
		$("#Interface").append('<option value=""></option>');
		}

		$("#Interface").append('<option value="InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1">'
						+ "br0" + '</option>');

		for (i = 0; i < WanInfo.length; i++) {
			if (cfgModeWord.toUpperCase() == "ROSUNION" && curUserType != '0' && (isClickAdd || isNeedFilter)) {
				if ((WanInfo[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >=0) || (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("VOIP") >=0) || (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("TR069") >=0)) {
					continue;
				}
			}
			if (SingtelModeEX == 1) {
				if ((WanInfo[i].ServiceList.toString().toUpperCase().indexOf("IPTV") >= 0) ||
					(WanInfo[i].ServiceList.toString().toUpperCase().indexOf("VOIP") >= 0)) {
					continue;
				}
			}
			if (viettelflag == 1) {
				if (WanInfo[i].ServiceList.toString().toUpperCase().indexOf("TR069") >= 0) {
					continue;
				}
			}

            if (UnicomFlag == 1) {
				var ServiceList = WanInfo[i].ServiceList.toString().toUpperCase();
				if ((ServiceList =="TR069") || (ServiceList == "VOIP") || (ServiceList =="TR069_VOIP")) {
					continue;
				}
            }

			if(MngtSDcu == 1) {
				if (WanInfo[i].IPv4Enable == '1') {
					$("#Interface").append('<option value=' + WanInfo[i].domain + ' id="wan_'
					+ i + '">' + MakeWanName1(WanInfo[i]) + '</option>');
				}
			} else {
				if (WanInfo[i].Mode == 'IP_Routed' && WanInfo[i].IPv4Enable == '1') {
					$("#Interface").append('<option value=' + WanInfo[i].domain + ' id="wan_'
					+ i + '">' + MakeWanName1(WanInfo[i]) + '</option>');
				}
			}
		}   
		if (is5182H) {
			for (i = 0; i < VXLAN_VXLANConfig.length; i++) {
				if (VXLAN_VXLANConfig[i]) {
					var Option = document.createElement("Option");
					var words = VXLAN_VXLANConfig[i].domain.split(".");
					Option.value = VXLAN_VXLANConfig[i].domain;  // 取最后一个值
					Option.innerText = GetVxlanName(VXLAN_VXLANConfig[i].domain);
					$("#Interface").append(Option);
				}
			}
    	}
	}
}

function StaticRouteCfgModeIsIpType()
{
    if ("DomainMode" == getRadioVal("StaticRouteCfgMode"))
    {
        return  false;
    }
    return  true;
}
function StaticRouteCfgIpOrDomain()
{
    if (false == StaticRouteCfgModeIsIpType())
    {  
        setDisplay("StaticRouteDomainRow", 1);
        setDisplay("DestIPAddressRow",0);
        setDisplay("DestSubnetMaskRow",0);
    }
    else
    {
        setDisplay("StaticRouteDomainRow", 0);
        setDisplay("DestIPAddressRow",1);
        setDisplay("DestSubnetMaskRow",1);
    }
}
function btnClear() 
{
   with ( document.forms[0] ) 
   {
		  setText('DestIPAddress','');
		  setText('DestSubnetMask','');
		  setText('GatewayIPAddress','');
   }
}

function setDefaultgateway()
{ 
	var selectObj = getElement('Interface');
	var index = parseInt(selectObj.selectedIndex);
	
	if("1" != GetCfgMode().PCCWHK)
	{
		setText('GatewayIPAddress','');
	}
}

function Ipv4StaticRouteConfigListselectRemoveCnt(val)
{

}

function OnDeleteButtonClick(TableID)
{      
    if ((StaticRoute.length) == 0)
	{	
	    return;
	}
	
	if (routeIdx == -1)
	{	
	    return;
	}
	var CheckBoxList = document.getElementsByName(TableName + 'rml');
	var Form = new webSubmitForm();
	var Count = 0;
	for (var i = 0; i < CheckBoxList.length; i++)
	{
		if (CheckBoxList[i].checked != true)
		{
			continue;
		}

        var numberId = "Ipv4StaticRouteConfigList_" + i + "_1";
        if (((curUserType == "1") && (cfgModeWord.toUpperCase() == "ROSUNION")) &&
            ((document.getElementById(numberId).innerHTML.indexOf("VOIP") >= 0) ||
            (document.getElementById(numberId).innerHTML.indexOf("TR069") >= 0))) {
            continue;
        }

		Count++;
		Form.addParameter(CheckBoxList[i].value,'');
	}
	if (Count <= 0)
	{
		return false;
	}
        
    setDisable('btnApply_ex',1);
    setDisable('canelButton',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('del.cgi?' +'x=InternetGatewayDevice.Layer3Forwarding.Forwarding' + '&RequestFile=html/bbsp/staticroute/staticroute.asp');
	Form.submit();
}

function CheckForm_DstIp()
{
    if (getValue('DestIPAddress') == '') {
        AlertEx(sroute_language['bbsp_alert_ipmaskuil']);
        return false;
    }

    return true;
}

function CheckForm_DstMask()
{
    if ((getValue('DestSubnetMask') == null) || (getValue('DestSubnetMask') == '')) {
        AlertEx(sroute_language['bbsp_alert_masknill']);
        return false;
    }

    if ((isValidSubnetMask(getValue('DestSubnetMask')) == false) &&
        (getValue('DestSubnetMask') != '255.255.255.255')) {
        AlertEx(sroute_language['bbsp_alert_mask'] + getValue('DestSubnetMask') + sroute_language['bbsp_alert_invail']);	
        return false;
    }
    return true;
}

function getMostRightPosOf1(str)
{
    for (i = str.length - 1; i >= 0; i--) {
        if (str.charAt(i) == '1') {
            break;
        }
    }
    return i;
}

function getBinaryString(str)
{
    var numArr = [128, 64, 32, 16, 8, 4, 2, 1];
    var addrParts = str.split('.');
    if (addrParts.length < 3) {
        return "00000000000000000000000000000000";
    }
    var binstr = '';
    for (i = 0; i < 4; i++) {
        var num = parseInt(addrParts[i])

        for (j = 0; j < numArr.length; j++) {
            if ((num & numArr[j]) != 0) {
                binstr += '1';
            } else {
                binstr += '0';
            }    
        }
    }
    return binstr;
}

function isMatchedIpAndMask(ip, mask)
{
    var locIp = getBinaryString(ip);
    var locMask = getBinaryString(mask);

    if (locIp.length != locMask.length) {
        return false;
    } 
    var most_right_pos_1 = getMostRightPosOf1(locMask);

    if (most_right_pos_1 == -1) {
        if (locIp == '00000000000000000000000000000000') {
            return true;
        } else {
            return false;
        }
    }

    for (var i = most_right_pos_1 + 1; i < locIp.length; i++) {
        if (locIp.charAt(i) != '0') {
            return false;
        }
    }
    return true;
}

function CheckForm(Form)
{
	if(('' == getSelectVal('Interface')) && ('' == getValue('GatewayIPAddress')))
	{
		AlertEx(sroute_language['bbsp_set_interface']);
		return false;
	}

    var forwardingMetricValue = 10;
    for (var i = 0; i < StaticRoute.length; i++)
    {
		if(routeIdxSubmit != i)
        {
            if (ProductType == '2') {
			    var wanType = MakeInterfaceName(getSelectVal('Interface'));
                if (((StaticRoute[i].DestIPAddress == getValue('DestIPAddress')) && (getValue('DestIPAddress') != "")) && 
                    ((StaticRoute[i].DestSubnetMask == getValue('DestSubnetMask')) && (getValue('DestSubnetMask') != ""))) {             
                    if (wanType.indexOf("ADSL") >= 0) {
                        forwardingMetricValue = 12;
                    } else if (wanType.indexOf("VDSL") >= 0) {
                        forwardingMetricValue = 11;
                    } else {
                        forwardingMetricValue = 10;
                    }					
                }
            } else {
                if (StaticRoute[i].StaticRouteDomain == getValue('DestIPAddress')&& ('' != getValue('DestIPAddress'))) {               
				    AlertEx(sroute_language['bbsp_alert_ipused']);	
                    return false;
                }
            }				
            if (StaticRoute[i].StaticRouteDomain == getValue('StaticRouteDomain')&& ('' != getValue('StaticRouteDomain')))
            {               
				AlertEx(sroute_language['bbsp_alert_domainused']);	
                return false;
            }
        }
        else
        {
            continue;
        }
    }

    with ( document.forms[0] )
    {
        if (true == StaticRouteCfgModeIsIpType()) {
            var ForwardingMetric = 0;
            Form.addParameter('x.X_HW_DomainName','');

            if ((getValue('DestIPAddress') == '') || (getValue('DestSubnetMask') == '')) {
                AlertEx(sroute_language['bbsp_alert_ipmaskuil']);
                return false;
            }

            if (((getValue('DestIPAddress') == '') || (getValue('DestIPAddress') == '0.0.0.0')) &&
                ((getValue('DestSubnetMask') == '') || (getValue('DestSubnetMask') == '0.0.0.0'))) {
                ForwardingMetric = 1;
            } else {
                if (CheckForm_DstIp() == false) {
                    return false;
                }

                if (CheckForm_DstMask() == false) {
                    return false;
                }

                if (isMatchedIpAndMask(getValue('DestIPAddress'), getValue('DestSubnetMask')) == false) {
                    AlertEx(sroute_language['bbsp_alert_ipaddr']  + getValue('DestIPAddress') + sroute_language['bbsp_alert_andmask'] + getValue('DestSubnetMask') + sroute_language['bbsp_alert_notmatch']);
                    return false;
                }

                ForwardingMetric = 10;
            }

            if (CfgModeWord.toUpperCase() == "ROSUNION") {
                if (getValue('DestIPAddress') == '') {
                    AlertEx(sroute_language['bbsp_ipnull']);
                    return false;
                }

                if (isAbcIpAddress(getValue('DestIPAddress')) == false) {
                    AlertEx(sroute_language['bbsp_alert_invalidipaddr']);
                    return false;
                }

                if (getValue('DestSubnetMask') == '') {
                    AlertEx(sroute_language['bbsp_alert_masknill']);
                    return false;
                }

                if (isValidSubnetMask(getValue('DestSubnetMask')) == false) {
                    AlertEx(sroute_language['SubMaskInvalid']);
                    return false;
                }
            }

            Form.addParameter('x.DestIPAddress', getValue('DestIPAddress'));
            Form.addParameter('x.DestSubnetMask', getValue('DestSubnetMask'));
            Form.addParameter('x.ForwardingMetric', ForwardingMetric);
        }
        else
        {
            Form.addParameter('x.DestIPAddress','');
            Form.addParameter('x.DestSubnetMask','');

            if ( '' == getValue('StaticRouteDomain') )
            {           
        		AlertEx(sroute_language['bbsp_alert_null_domain']);	
                return false;
            }

    		Form.addParameter('x.X_HW_DomainName',getSelectVal('StaticRouteDomain'));	
			Form.addParameter('x.ForwardingMetric','10');					
        }

        Form.addParameter('x.GatewayIPAddress',getValue('GatewayIPAddress'));  
        Form.addParameter('x.Interface',getSelectVal('Interface'));

    }

    return true;
}

function SubmitForm()
{   
    var Form = new webSubmitForm();
	
    if(AddFlag == false)
    {   
        if (CheckForm(Form) == false)
        {
            return;
        }

        var interfaceType = MakeInterfaceName(getSelectVal('Interface'));
        if (((curUserType == "1") && (cfgModeWord.toUpperCase() == "ROSUNION")) &&
            ((interfaceType.indexOf("VOIP") >= 0) || (interfaceType.indexOf("TR069") >= 0))) {
            return;
        }

		var routemain = StaticRoute[routeIdxSubmit].domain;
		
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('set.cgi?x=' + routemain 
    		  	        + '&RequestFile=html/bbsp/staticroute/staticroute.asp');
    }
    else
    {
		if (CheckForm(Form) == false)
    	{
    	     return;
    	}
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('add.cgi?x=InternetGatewayDevice.Layer3Forwarding.Forwarding'
    		  	              + '&RequestFile=html/bbsp/staticroute/staticroute.asp');  
    }

    setDisable('btnApply_ex',1);
    setDisable('canelButton',1);
    Form.submit();
	DisableRepeatSubmit();
}

function setCtlDisplay(record)
{
	setRadio("StaticRouteCfgMode",'IpMode');	

	if (record != null)
	{
    	setText('DestIPAddress',record.DestIPAddress);
		setText('GatewayIPAddress',record.Gateway);	
		setText('DestSubnetMask',record.mask);
		setText('StaticRouteDomain',record.StaticRouteDomain);
    	setSelect('Interface',record.Interface);
	
		if ((true != AddFlag) && ("" == record.DestIPAddress) && ("" != record.StaticRouteDomain)) 
		{
			setRadio("StaticRouteCfgMode",'DomainMode');				
		}

    	StaticRouteCfgIpOrDomain();
    }
    else
    {
        setText('StaticRouteDomain','');
        setText('DestIPAddress','');
    	setText('GatewayIPAddress','');		
    	setText('DestSubnetMask','');
    }

}

function setControl(index)
{
    var record;
	var selectObj = getElement('Interface');
    var i = parseInt(selectObj.selectedIndex);
    var staticRtList = "Ipv4StaticRouteConfigList_"+index+"_1";

    routeIdx = index;
	routeIdxSubmit=routeIdx + (parseInt(page,10) - 1)*listNum;		
    if (index == -1)
	{   
	    setDisable('Interface',0);
	    if (StaticRoute.length >= (parseInt(IPv4SRoutelistMaxNum,10)))
        {
            setDisplay('ConfigForm', 0);            
			AlertEx(sroute_language['bbsp_alert_sroutefull']);
            return;
        }
        else
        {
            setDisplay('ConfigForm', 1);
            AddFlag = true;
            if (i == -1)
	        {
	            record = new stStaticRoute('', '', '', '', '', '');
            }
            else
            {
                var idx = selectObj.options[i].id.split('_')[1];
                record = new stStaticRoute('', '', '', '', '', '');
            }
			setCtlDisplay(record);
		}
		if (isMegacableFlag == "1") {
			var x = document.getElementById("Interface");
			x.selectedIndex = -1;
		}
	} else if (index == -2) {
		setDisplay('ConfigForm', 0);
	} else {
		setDisplay('ConfigForm', 1);
		AddFlag = false;
		var index1 =  index + (parseInt(page,10) - 1)*listNum;
		record = StaticRoute[index1];
		setCtlDisplay(record);
	}

    if (GetCfgMode().BJUNICOM == "1")
    {
        setDisable('btnApply_ex',1);
        setDisable('canelButton',1);
    }
    else
    {
        setDisable('btnApply_ex',0);
        setDisable('canelButton',0);
    }

    if ((CfgModeWord.toUpperCase() == "ROSUNION") && (curUserType == "1") && (!isClickAdd)) {
        if ((document.getElementById(staticRtList).innerHTML.indexOf("VOIP") > 0) || (document.getElementById(staticRtList).innerHTML.indexOf("TR069") > 0)){
            setDisable('btnApply_ex',1);
            setDisable('canelButton',1);
            setDisable('Interface', 1);
        } else {
            setDisable('Interface', 0);
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
            selectLine(TableName + '_record_0');
        }
    }
    else
    {
        var record = StaticRoute[routeIdxSubmit];
		setCtlDisplay(record);
    }
}
if( '1' == TDESME2Modeflg )
{
    sroute_language['bbsp_td_wanname'] = sroute_language['bbsp_td_wanname_1'];
    sroute_language['bbsp_td_wanname2'] = sroute_language['bbsp_td_wanname2_1'];
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("ipv4staticroutetitle", GetDescFormArrayById(sroute_language, "bbsp_mune"), GetDescFormArrayById(sroute_language, "bbsp_title_prompt"), false);
</script> 
<div class="title_spread"></div>
  
<script language="JavaScript" type="text/javascript">
	var Ipv4StaticRouteConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),									
								new stTableTileInfo("bbsp_td_wanname","restrict_dir_ltr","Interface"),
								new stTableTileInfo("bbsp_td_ip","","DestIPAddress",false,15),
								new stTableTileInfo("bbsp_td_gw","","GatewayIPAddress"),
								new stTableTileInfo("bbsp_td_submask","","DestSubnetMask"),null);	
	showlistcontrol();
</script>
  
  <div id="ConfigForm2"> 
  <div class="list_table_spread"></div>
    <table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
		<tr > 
			<td class='width_per40'></td> 
			<td class='title_bright1' >
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
				<input name="first" id="first" class="PageNext jumppagejumplastbutton_wh_px" type="button" value="<<" onClick="submitfirst();"/> 
				<input name="prv" id="prv"  class="PageNext jumppagejumpbutton_wh_px" type="button" value="<" onClick="submitprv();"/> 
					<script>
						if (false == IsValidPage(page))
						{
							page = (0 == RouteInfoNr) ? 0:1;
						}
						document.write(parseInt(page,10) + "/" + lastpage);
					</script>
				<input name="next"  id="next" class="PageNext jumppagejumpbutton_wh_px" type="button" value=">" onClick="submitnext();"/> 
				<input name="last"  id="last" class="PageNext jumppagejumplastbutton_wh_px" type="button" value=">>" onClick="submitlast();"/> 
			</td>
			<td class='width_per5'></td>
			<td  class='title_bright1'>
				<script> document.write(sroute_language['bbsp_goto']); </script> 
					<input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
				<script> document.write(sroute_language['bbsp_page']); </script>
			</td>
			<td class='title_bright1'>
				<button name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="submitjump();"> <script> document.write(sroute_language['bbsp_jump']); </script></button> 
			</td>
		</tr> 	  
    </table> 
  </div>  
  
	<form id="ConfigForm" style="display:none"> 
		<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
			<li   id="StaticRouteCfgMode"                 RealType="RadioButtonList"    DescRef="bbsp_static_route_addr_format"                 RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"          InitValue="[{TextRef:'bbsp_cfg_type_ip',Value:'IpMode'},{TextRef:'bbsp_cfg_type_domain',Value:'DomainMode'}]" ClickFuncApp="onclick=StaticRouteCfgIpOrDomain"/>
			<li   id="StaticRouteDomain"       RealType="TextBox"          DescRef="bbsp_domain"         RemarkRef="bbsp_sroute_domaintips"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.X_HW_DomainName"   Elementclass="width_254px"  InitValue="Empty" MaxLength="255"/>
			<li   id="DestIPAddress"       RealType="TextBox"          DescRef="bbsp_td_ip2"         RemarkRef="bbsp_sroute_domaintips"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DestIPAddress"   Elementclass="width_254px"  InitValue="Empty" MaxLength="15"/>
			<li   id="DestSubnetMask"       RealType="TextBox"          DescRef="bbsp_td_submask2"         RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DestSubnetMask"   Elementclass="width_254px"  InitValue="Empty" MaxLength="15"/>
			<li   id="GatewayIPAddress"            RealType="TextBox"     DescRef="bbsp_td_gw2"      RemarkRef="bbsp_gw_blank"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.GatewayIPAddress"    Elementclass="width_254px"     InitValue="Empty" MaxLength="15"/>
			<script language="JavaScript" type="text/javascript">
				if(exchangeWan == "1"){
					document.write('<li   id="Interface"      RealType="DropDownList"  DescRef="bbsp_td_wanservices"          RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"  Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty" MaxLength="30" ClickFuncApp="onchange=setDefaultgateway"/>');
				}else{
					document.write('<li   id="Interface"      RealType="DropDownList"  DescRef="bbsp_td_wanname2"          RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Interface"  Elementclass="width_260px restrict_dir_ltr"  InitValue="Empty" MaxLength="30" ClickFuncApp="onchange=setDefaultgateway"/>');
				}
				var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
				var StaticRouteFormList = new Array();
				StaticRouteFormList = HWGetLiIdListByForm("ConfigForm", null);
				var formid_hide_id = null;
				HWParsePageControlByID("ConfigForm", TableClass, sroute_language, formid_hide_id);
				if("1" == GetCfgMode().PCCWHK)
				{
					setElementInnerHtml("Interfacespan", sroute_language['bbsp_interface_blank']);
				}
				WriteOption();
			</script>
		</table>
	<table class="table_button" cellspacing="1" id="cfg_table" width="100%"> 
      <tr> 
	    <td class='width_per25'>&nbsp;</td>
        <td class="table_submit width_per75"> 
		  <button id="btnApply_ex" name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();"><script>document.write(sroute_language['bbsp_app']);</script></button>
          <button id="canelButton" name="canelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();"><script>document.write(sroute_language['bbsp_cancel']);</script></button>  
		</td> 
      </tr>   
    </table>
  </form>  
  <script language="JavaScript" type="text/javascript">
	loadlanguage();
    if (GetCfgMode().BJUNICOM != "1")
	{
		writeTabTail();
	}
	
	if(page == firstpage)
	{
		setDisable('first',1);
		setDisable('prv',1);
	}
	if(page == lastpage)
	{
		setDisable('next',1);
		setDisable('last',1);
	}	
</script> 
</body>
</html>
