<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Chinese -- AWIFI LAN Config</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>

<style type="text/css">

    .TextBox
    {
        width:130px;  
    }
    .CheckBoxList
	{
		width:63px;  
	}
	
</style>

<script language="JavaScript" type="text/javascript">


function FLOW_CTROL(type)
{
	this.__tableAction = "none";
	this.__selectIndex = -1;

	if(type == "single")
	{
		this.__tableAction = "Set";
		this.__selectIndex = 0;
	}
	
	function null_function(){}

	this.GetItemInfo        = null_function;
	this.GetInputCfgItem    = null_function; 

	this.setCfgItem         = null_function;
	this.onSetSubmit        = null_function;
	this.CheckCurrentItemInfo  = null_function;
	this.CheckRepeatedItemInfo = null_function;

	this.__SetSubmitProcess = function(index, item)
	{
		if(this.CheckCurrentItemInfo(item) && this.CheckRepeatedItemInfo(this.GetItemInfo(index), item))
		{
			this.onSetSubmit(index, this.GetItemInfo(index), item);
		}
	}
	
	this.onClickProcess = function(index) 
	{
		var item = this.GetItemInfo(index);

		this.setCfgItem(item);
	}

	this.onSubmitProcess = function()
	{
		var item = this.GetInputCfgItem();
		
		return this["__" + this.__tableAction + "SubmitProcess"](this.__selectIndex, item);
	}
	
}

var flowCtrol = new FLOW_CTROL("single");
var awifiTableClass;
var requestFile = "html/bbsp/lancertification/lancertification.asp";
var timeUnitNum = 4;
var lanPortNum = 8;
var ssidPortNum = 8;

function awifiLanPortSwitch(domain, LanPortSwitch)
{
    this.domain				    = domain;
	this.LanPortSwitch	= LanPortSwitch;
}

function AwifiIpAddr(domain, IPInterfaceIPAddress, IPInterfaceSubnetMask)
{
	this.domain			        = domain;
	this.IPInterfaceIPAddress   = IPInterfaceIPAddress;
	this.IPInterfaceSubnetMask	= IPInterfaceSubnetMask;	
}

function AwifiDhcpAddrpool(domain, MinAddress, MaxAddress, DHCPLeaseTime)
{
	this.domain 			= domain;
	this.DhcpStartAddress 	= MinAddress;
	this.DhcpEndAddress 	= MaxAddress;
	this.DhcpLeaseTime      = DHCPLeaseTime;
}

function AwifiBindPortItem(domain, PhyPortName)
{
	this.domain      = domain;
	this.PhyPortName = PhyPortName;
}

function AwifiTopoInfoClass(Domain, EthNum, SSIDNum)
{   
    this.Domain  = Domain;
    this.EthNum  = EthNum;
    this.SSIDNum = SSIDNum;
}

function AwifiLayer3Enable(domain, lay3enable)
{
	this.domain   = domain;
	this.L3Enable = lay3enable;
}

function AwifiISPSSID(domain, SSID)
{
    this.domain = domain;
    this.SSID   = SSID;
}

var awifiLanPortSwitchEnable = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_AWIFIService, LanPortSwitch, awifiLanPortSwitch);%>;  
var awifiBindPortList   = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_AWIFIService.BindPort, PhyPortName, AwifiBindPortItem);%>; 
var awifiIpAddress 		= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i}, IPInterfaceIPAddress|IPInterfaceSubnetMask, AwifiIpAddr);%>;
var awifiDhcpAddrPool 	= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1, MinAddress|MaxAddress|DHCPLeaseTime, AwifiDhcpAddrpool);%>;
 
var awifiTopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo, X_HW_EthNum|X_HW_SsidNum, AwifiTopoInfoClass);%>
var awifiLanModeList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,AwifiLayer3Enable);%>; 
var awifiISPSSIDList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForISP.{i}, SSID_IDX, AwifiISPSSID);%>;

var MainDhcpRangeEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPServerEnable);%>';


var AwifiPorts = <%HW_WEB_GetAwifiBindPorts();%>;
var IptvPortList = <%HW_WEB_GetIptvPortList();%>;
var stbport = '<%HW_WEB_GetSTBPort();%>';
var aWiFiSSID2GInst = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AWiFi_SSID.SSID2GINST);%>';
var aWiFiInst = parseInt(aWiFiSSID2GInst, 10);
var AWIFIFlagfeature = '<%HW_WEB_GetFeatureSupport(FT_BBSP_AWIFI_SWITCH);%>';

if (awifiIpAddress[1] == null)
{
    awifiIpAddress[1] = new AwifiDhcpAddrpool("", "", ""); 
}

if (awifiDhcpAddrPool[0] == null)
{
    awifiDhcpAddrPool[0] = new AwifiDhcpAddrpool("", "", "", ""); 
}

var awifiTopoInfo = awifiTopoInfoList[0];
if('<%GetLanPortNum();%>' != "" && '<%GetLanPortNum();%>' != null)
{
	awifiTopoInfo.EthNum = '<%GetLanPortNum();%>';
}

function AwifiParaList(LanPortSwitch, IPInterface, DHCPConditionalServingPool, BindPort)
{
    this.awifiPortdomain			= LanPortSwitch.domain;
	this.LanPortSwitch		        = LanPortSwitch.LanPortSwitch;
	this.awifiIpdomain				= IPInterface.domain;
	this.IPInterfaceIPAddress   	= IPInterface.IPInterfaceIPAddress;
	this.IPInterfaceSubnetMask		= IPInterface.IPInterfaceSubnetMask;	
	this.awifiDhcpdomain 			= DHCPConditionalServingPool.domain;
	this.DhcpStartAddress 			= DHCPConditionalServingPool.DhcpStartAddress;
	this.DhcpEndAddress 			= DHCPConditionalServingPool.DhcpEndAddress;
	this.DhcpLeaseTime 				= DHCPConditionalServingPool.DhcpLeaseTime;
	this.awifiBindPortdomain 		= BindPort.domain;
	this.PhyPortName				= BindPort.PhyPortName;
}

var paraList = new AwifiParaList(awifiLanPortSwitchEnable[0], awifiIpAddress[1], awifiDhcpAddrPool[0], awifiBindPortList[0]);

function CheckCurrentItemInfo(item)
{
	var awifiroute = getValue("AwifiLanIPAddr");
    var aiwifiMask = getValue("AwifiLanSubmask");
	
	if( '0' == MainDhcpRangeEnable &&  "" != item.PhyPortName)
	{
		AlertEx(lan_certification['bbsp_lanctf_maindisable']);
		return false;
	}
	
	if ( isMaskOf24BitOrMore(aiwifiMask) == false ) 
    {
        AlertEx(dhcp_language['bbsp_subnetmaskp'] + aiwifiMask + dhcp_language['bbsp_isinvalidp'] + dhcp_language['bbsp_maskerrorinfo']);
        return false;
    }
	
	if (isValidIpAddress(awifiroute) == false) 
    {
    	AlertEx(lan_certification['bbsp_lanctf_rouipinvalid']);
       	return false;
    }	
	if (isValidSubnetMask(aiwifiMask) == false) 
    {
    	AlertEx(lan_certification['bbsp_lanctf_roumsinvalid']);
       	return false;
    }
    if (isBroadcastIp(awifiroute, aiwifiMask) == true)
    {
    	AlertEx(lan_certification['bbsp_lanctf_rouipinvalid']);
    	return false;
    }
	if(awifiroute == awifiIpAddress[0].IPInterfaceIPAddress)
	{
		AlertEx(lan_certification['bbsp_lanctf_repeatconf']);		
		return false;
	}
	if(true == isSameSubNet(awifiroute, aiwifiMask,awifiIpAddress[0].IPInterfaceIPAddress,awifiIpAddress[0].IPInterfaceSubnetMask))
	{
		AlertEx(lan_certification['bbsp_lanctf_repeatconf1']);		
		return false;
	}
			  
	if (isValidIpAddress(getValue("AwifiLanStartAddr")) == false) 
    {
    	AlertEx(lan_certification['bbsp_lanctf_stipinvalid']);
       	return false;
    }
    if (isBroadcastIp(getValue("AwifiLanStartAddr"), aiwifiMask) == true)
    {
    	AlertEx(lan_certification['bbsp_lanctf_stipinvalid']);
    	return false;
    }
    if (false == isSameSubNet(getValue("AwifiLanStartAddr"),aiwifiMask,awifiroute,aiwifiMask))
    {
    	  
		AlertEx(lan_certification['bbsp_lanctf_stipsmhost']);
		return false;
    }

    if (isValidIpAddress(getValue("AwifiLanEndAdd")) == false) 
    {
        AlertEx(lan_certification['bbsp_lanctf_edipinvalid']);
    	return false;
    }
    if (isBroadcastIp(getValue("AwifiLanEndAdd"), aiwifiMask) == true)
    {
    	AlertEx(lan_certification['bbsp_lanctf_edipinvalid']);
    	return false;
    }
    if (false == isSameSubNet(getValue("AwifiLanEndAdd"),aiwifiMask,awifiroute,aiwifiMask))
    {
    	AlertEx(lan_certification['bbsp_lanctf_edipsmhost']);
    	return false;
    }

    if (!(isEndGTEStart(getValue("AwifiLanEndAdd"), getValue("AwifiLanStartAddr")))) 
    {
    	AlertEx(lan_certification['bbsp_lanctf_edbigthanst']);
        return false;
    }
	
	if (AWIFIFlagfeature == 1)
	{
		var IpStartNew = getValue('AwifiLanStartAddr').split('.');
		var IpEndNew = getValue('AwifiLanEndAdd').split('.');
		var NumStartNew = parseInt(IpStartNew[3]);
		var NumEndNew = parseInt(IpEndNew[3]);	
	
		var IpStartOld = awifiDhcpAddrPool[0].DhcpStartAddress.split('.');
		var IpEndOld = awifiDhcpAddrPool[0].DhcpEndAddress.split('.');	
		var NumStartOld = parseInt(IpStartOld[3]);
		var NumEndOld = parseInt(IpEndOld[3]);

		if (NumStartOld == 51 && NumEndOld == 250)
		{
			if (NumStartNew != 51 || NumEndNew != 250)
			{
				AlertEx(lan_certification['bbsp_awifidhcpip']);
				return false;
			}
		}
	}	
		 
	return  true;
}

function CheckRepeatedItemInfo(oldItem, item)
{	
    return  true;
}

function GetItemInfo(index)
{
	return paraList;
}

function GetCurrentItemInfo()
{
	var awifiPortItem = new awifiLanPortSwitch("", getCheckVal("AwifiLanPortEn"));
	var awifiIpAddressItem = new AwifiIpAddr("", getValue("AwifiLanIPAddr"), getValue("AwifiLanSubmask"));
	var awifiDhcpAddressPoolItem = new AwifiDhcpAddrpool("", getValue("AwifiLanStartAddr"), getValue("AwifiLanEndAdd"), getValue("AwifiLanLeaseTime"));
	var awifiBindItem = new AwifiBindPortItem("", getLanSSidValue());

    return new AwifiParaList(awifiPortItem, awifiIpAddressItem,
		awifiDhcpAddressPoolItem, awifiBindItem);
}

		
function setViewTable()
{
	var bDisable = getCheckVal("AwifiLanPortEn");
    var iptvlen = IptvPortList.split(",").length;
    var iptvport = "";
	if(bDisable)
	{
		for (var portIndex = 1; portIndex <= parseInt(awifiTopoInfo.EthNum); portIndex++)
		{
			if((IsL3Mode(portIndex) == "1") && (portIndex != parseInt(stbport)) )
			{
				setCheck("AwifiEthPortList"+portIndex, 1);
				setDisable("AwifiEthPortList"+portIndex,1);
			}
            for(var i =0;i<iptvlen;i++)
            {
                if (IptvPortList.split(",")[i].toUpperCase() == ("LAN"+portIndex))
                {
                    setCheck("AwifiEthPortList"+portIndex, 0);
                    setDisable("AwifiEthPortList"+portIndex,1);
                }
            }
		}		
		GetBindPort();
	}
    else
    {
		if (awifiLanPortSwitchEnable[0].LanPortSwitch == 1 && AwifiPorts != "")
		{
			awifiBindPortList[0].PhyPortName = AwifiPorts;
		}
        setLanSSidValue();
    }	
}

function GetBindPort()
{
        var IsLanChecked = 0;
		var IsWifiChecked = 0;
        for (var portIndex = 1; portIndex <= parseInt(awifiTopoInfo.EthNum); portIndex++)
    	{
			IsLanChecked = getCheckVal("AwifiEthPortList"+portIndex);
			if( 1 == IsLanChecked)
			{
			  break;
			}	
    	}
		for (var ssidIndex = 1; ssidIndex <= parseInt(awifiTopoInfo.SSIDNum); ssidIndex++)
        {
			var ssidCheckIndex = ssidIndex + lanPortNum;
			IsWifiChecked = getCheckVal("AwifiEthPortList"+ssidCheckIndex);		
			if(1 == IsWifiChecked)
			{
			   break;		
			}		
        }
			
		if( 1 == IsLanChecked || 1 == IsWifiChecked)
		{
			setDisable("AwifiLanIPAddr", 0);
			setDisable("AwifiLanSubmask",0);
		}
		else
		{
			setDisable("AwifiLanIPAddr", 1);
			setDisable("AwifiLanSubmask",1);
		} 
}

function SetCurrentItemInfo(item)
{
    setCheck("AwifiLanPortEn", item.LanPortSwitch);
    setText("AwifiLanIPAddr", item.IPInterfaceIPAddress);
	setText("AwifiLanSubmask", item.IPInterfaceSubnetMask);
	setText("AwifiLanStartAddr", item.DhcpStartAddress);
	setText("AwifiLanEndAdd", item.DhcpEndAddress);
	setLeaseTime(item.DhcpLeaseTime);
	setLanSSidValue();	
} 

function setLeaseTime(dhcpLeasetime)
{
    var timeUnits = 1800;

    for(var index = 0; index < timeUnitNum; index++)
    {
        if (index == 0 )
        {
            timeUnits  = 86400;
        }
        else if (index == 1)
        {
            timeUnits  = 43200;
        }
        else if (index == 2)
        {
            timeUnits  = 3600;
        }
        else
        {
            timeUnits  = 1800;                    
        }
        
        if ( true == isInteger(dhcpLeasetime / timeUnits) )
        {
            break; 
        }          
    }
	
	setSelect('AwifiLanLeaseTime', timeUnits);

}

function getLanSSidValue()
{
	var portList = "";

	$("#AwifiEthPortListCol :checkbox:checked").each(function() {
			portList += $(this).val() + ",";	

		});

	if(portList.length > 0)
	{
		portList = portList.substring(0,[portList.length - 1]);
	}		
	return portList;
}

function setLanSSidValue()
{
	ControlLanSSidBind();
	var IsBindPort = false;
    var iptvlen = IptvPortList.split(",").length;
    var iptvport = "";
	if(awifiBindPortList[0] != null)
    {
		for (var portIndex = 1; portIndex <= parseInt(awifiTopoInfo.EthNum); portIndex++)
    	{
			var ethPos = awifiBindPortList[0].PhyPortName.toUpperCase().indexOf('LAN'+portIndex);          
			if(ethPos >= 0 && IsL3Mode(portIndex) == "1")
        	{
				setCheck("AwifiEthPortList"+portIndex, 1);
				IsBindPort = true;
        	}
			else
			{
				setCheck("AwifiEthPortList"+portIndex, 0);
			}
            for(var i =0;i<iptvlen;i++)
            {
                if (IptvPortList.split(",")[i].toUpperCase() == ("LAN"+portIndex))
                {
                    setCheck("AwifiEthPortList"+portIndex, 0);
                    setDisable("AwifiEthPortList"+portIndex,1);
                }
            }
    	}
		for (var ssidIndex = 1; ssidIndex <= parseInt(awifiTopoInfo.SSIDNum); ssidIndex++)
        {
		    var ssidPos = awifiBindPortList[0].PhyPortName.toUpperCase().indexOf('SSID'+ssidIndex);
            var ssidCheckIndex = ssidIndex + lanPortNum;
		    if(ssidPos >= 0)
            {
			    setCheck("AwifiEthPortList"+ssidCheckIndex, 1);
				IsBindPort = true;
				if (aWiFiInst == ssidIndex)
				{
					setDisable("AwifiEthPortList"+ssidCheckIndex,1);
				}
            }
			else
			{
				 setCheck("AwifiEthPortList"+ssidCheckIndex, 0);
			}
            for(var i =0;i<iptvlen;i++)
            {
                if (IptvPortList.split(",")[i].toUpperCase() == ("SSID"+ssidIndex))
                {
                    setCheck("AwifiEthPortList"+ssidCheckIndex, 0);
                    setDisable("AwifiEthPortList"+ssidCheckIndex,1);
                }
            }

        }
		
		if(false ==  IsBindPort)
		{
			setDisable("AwifiLanIPAddr", 1);
			setDisable("AwifiLanSubmask",1);
		}
	}
}

function IsL3Mode(LanId)
{
    if (parseInt(LanId) >= awifiLanModeList.length){
    	return "null";
    }
    return awifiLanModeList[parseInt(LanId)-1].L3Enable;
}

function GetISPSSIDList()
{
    var ISPPortList = new Array();
    var ISPSsidIndex = '0';

    for(var ISPIndex = 0; ISPIndex < awifiISPSSIDList.length - 1; ISPIndex++)
    {
        ISPSsidIndex = awifiISPSSIDList[ISPIndex].SSID;
        ISPPortList.push('SSID' + ISPSsidIndex);

    }   
    return ISPPortList;
}


function ControlLanSSidBind()
{
	for (var ethHideIndex = parseInt(awifiTopoInfo.EthNum)+1; ethHideIndex <= lanPortNum; ethHideIndex++)
    {
        setDisplay("DivAwifiEthPortList"+ethHideIndex, 0);
    }
    var iptvlen = IptvPortList.split(",").length;
    var iptvport = "";

	for (var ethDisableIndex = 1; ethDisableIndex <= parseInt(awifiTopoInfo.EthNum); ethDisableIndex++)
    {
		if (ethDisableIndex == parseInt(stbport)) 
		{
			setDisplay("DivAwifiEthPortList"+ethDisableIndex, 0);
		}
        if (IsL3Mode(ethDisableIndex) != "1")
        {
            setDisable("AwifiEthPortList"+ethDisableIndex, 1);
        }
		else
		{
			setDisable("AwifiEthPortList"+ethDisableIndex, 0);
		}
        for(var i =0;i<iptvlen;i++)
        {
        if (iptvport.toUpperCase() == ("LAN"+ethDisableIndex))
        {
            setDisable("AwifiEthPortList"+ethDisableIndex, 0);
            }
        }
    }

	for (var ssidHideIndex = lanPortNum + ssidPortNum; ssidHideIndex > parseInt(awifiTopoInfo.SSIDNum)+lanPortNum; ssidHideIndex--)
    {
		setDisplay("DivAwifiEthPortList"+ssidHideIndex, 0);
    }

	for (var listIndex = 0; listIndex < WlanList.length; listIndex++)
	{
		var tid = parseInt(listIndex+lanPortNum + 1);
		if (WlanList[listIndex].bindenable == "0")
		{  
			setDisable("AwifiEthPortList"+tid, 1);
		}
		else
		{
			setDisable("AwifiEthPortList"+tid, 0);
		}
        for(var i =0;i<iptvlen;i++)
        {
        if (iptvport.toUpperCase() == ("SSID"+listIndex))
        {
            setDisable("AwifiEthPortList"+ethDisableIndex, 0);
            }
        }        
	}

	var ISPPortList = GetISPSSIDList();
	if(ISPPortList.length > 0)
    {
        for (var ISPPortIndex = 1; ISPPortIndex <= parseInt(awifiTopoInfo.SSIDNum); ISPPortIndex++)
        {
            var pos = ArrayIndexOf(ISPPortList, 'SSID'+ISPPortIndex);
			if(pos >= 0)
            {
                var DivID = ISPPortIndex + lanPortNum;
                setDisplay("DivAwifiEthPortList"+DivID, 0);
            }
        }
	}
}

function getSourceInterface(PhyPortName)
{
    var  BindPort = '';
	if(PhyPortName.length == 0)
	{
	    return BindPort;
	}
	for (var index1 = 1; index1 <= parseInt(awifiTopoInfo.EthNum); index1++)
    {
		var ethPos = PhyPortName.toUpperCase().indexOf('LAN'+index1);
		if(ethPos >= 0)
        {
			BindPort = BindPort+'InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.' + index1 + ',';				
        }
    }
	for (var index2 = 1; index2 <= parseInt(awifiTopoInfo.SSIDNum); index2++)
    {
		var ssidPos = PhyPortName.toUpperCase().indexOf('SSID'+index2);
		if(ssidPos >= 0)
        {
        	BindPort = BindPort+'InternetGatewayDevice.LANDevice.1.WLANConfiguration.' + index2 + ',';		               
        }
	}
	return BindPort.substring(0,BindPort.length-1);
}

function onSetSubmit(index, oldItem, item)
{	
	var Path = "";
	var portList = "";
	var Form = new webSubmitForm();
	Form.addParameter('x.LanPortSwitch', item.LanPortSwitch);
	Form.addParameter('x.PortCertificateEnable', 1);

	if(item.PhyPortName == "")
	{
		Form.addParameter('y.Enable', 0);
		Form.addParameter('w.Enable', 0);
	}
	else
	{
		Form.addParameter('y.Enable', 1);
		Form.addParameter('w.Enable', 1);
	}

	
	if(parseInt(item.LanPortSwitch) == "1" && parseInt(item.LanPortSwitch) != awifiLanPortSwitchEnable[0].LanPortSwitch)
	{
		portList = awifiBindPortList[0].PhyPortName;
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : 'AwifiBindPorts=' + portList+'&x.X_HW_Token=' + getValue('onttoken'),
            url : 'setawifibindports.cgi?&RequestFile=html/ipv6/not_find_file.asp',
            success : function(data) {
        	}
        });		
	}
	else if(parseInt(item.LanPortSwitch) == "0")
    {
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : 'AwifiBindPorts='+item.PhyPortName+'&x.X_HW_Token='+getValue('onttoken'),
            url : 'setawifibindports.cgi?&RequestFile=html/ipv6/not_find_file.asp',
            success : function(data) {
            }
        });
    }

	
	var BindPorts = getSourceInterface(item.PhyPortName);
	Form.addParameter('y.IPInterfaceIPAddress', item.IPInterfaceIPAddress);
	Form.addParameter('y.IPInterfaceSubnetMask', item.IPInterfaceSubnetMask);
	
	Form.addParameter('w.MinAddress', item.DhcpStartAddress);
	Form.addParameter('w.MaxAddress', item.DhcpEndAddress);
	Form.addParameter('w.DHCPLeaseTime', item.DhcpLeaseTime);

	Form.addParameter('w.SourceInterface', BindPorts);
	
	Form.addParameter('z.PhyPortName', item.PhyPortName);

	Path = 'x=InternetGatewayDevice.X_HW_AWIFIService'
					  + '&y=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
					  + '&w=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1'
					  + '&z=InternetGatewayDevice.X_HW_AWIFIService.BindPort'
					  +	'&RequestFile=';

	urlpara = 'set.cgi?' + Path + requestFile;
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction(urlpara);
	Form.submit();
	setDisable('SaveAwifiConfigButton',1);

	return true;
}

function onSaveButtonClick()
{
	if(flowCtrol.onSubmitProcess)
	{
		return flowCtrol.onSubmitProcess();
	}    
}

function initLeasedTime()
{
	$("#AwifiLanLeaseTime").append('<option value="1800">'+ lan_certification['bbsp_lanctf_half_hour'] + '</option>');
	$("#AwifiLanLeaseTime").append('<option value="3600">'+ lan_certification['bbsp_lanctf_one_hour'] + '</option>');	
	$("#AwifiLanLeaseTime").append('<option value="43200">'+ lan_certification['bbsp_lanctf_half_day'] + '</option>');	
	$("#AwifiLanLeaseTime").append('<option value="86400">'+ lan_certification['bbsp_lanctf_one_day'] + '</option>');
}

function OnPageLoad()
{
	flowCtrol.GetItemInfo        = GetItemInfo;
	flowCtrol.GetInputCfgItem    = GetCurrentItemInfo;
	flowCtrol.setCfgItem         = SetCurrentItemInfo;
	flowCtrol.onSetSubmit        = onSetSubmit;
	flowCtrol.CheckCurrentItemInfo  = CheckCurrentItemInfo;
	flowCtrol.CheckRepeatedItemInfo  = CheckRepeatedItemInfo;

	flowCtrol.onClickProcess(0);

    setViewTable();
    
    return true; 
}

if( stbport > 0)
{
	lan_certification['bbsp_lanctf_lan'+ stbport] = lan_certification['bbsp_lanctf_stb'];
}
</script>
</head>

<body onLoad="OnPageLoad();" class="mainbody"> 
<form id="AwifiConfigInfo"> 
  <div id="AwifiLanConfigPanel"> 
  	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<li   id='AwifiLanPortEn'     		    RealType='CheckBox'           	DescRef='bbsp_lanctf_enable' 	  		RemarkRef="Empty"   				ErrorMsgRef="Empty"	   Require="FALSE"    BindField="Empty"    InitValue="Empty"    ClickFuncApp="onclick=setViewTable"/>
		<li   id='AwifiLanIPAddr'  		        RealType='TextBox'           	DescRef='bbsp_lanctf_IP' 			    RemarkRef="Empty"   				ErrorMsgRef="Empty"	   Require="TRUE"     BindField="Empty"    InitValue="Empty"    MaxLength="15"/>
		<li   id='AwifiLanSubmask'     	     	RealType='TextBox'           	DescRef='bbsp_lanctf_Mask' 			    RemarkRef="Empty"   				ErrorMsgRef="Empty"	   Require="TRUE"     BindField="Empty"    InitValue="Empty"	MaxLength="15"/>
		<li   id='AwifiLanStartAddr'            RealType='TextBox'           	DescRef='bbsp_lanctf_start_IP' 		    RemarkRef="Empty"   				ErrorMsgRef="Empty"	   Require="TRUE"     BindField="Empty"    InitValue="Empty"	MaxLength="15"/>
		<li   id='AwifiLanEndAdd'           	RealType='TextBox'           	DescRef='bbsp_lanctf_end_IP' 			RemarkRef="Empty"   				ErrorMsgRef="Empty"	   Require="TRUE"     BindField="Empty"    InitValue="Empty"	MaxLength="15"/>
		<li   id='AwifiLanLeaseTime'            RealType='DropDownList'         DescRef='bbsp_lanctf_leaseTime' 		RemarkRef="Empty"   				ErrorMsgRef="Empty"	   Require="FALSE"    BindField="Empty"    InitValue="Empty"/>
		<li   id='AwifiEthPortList'   			RealType='CheckBoxList'    		DescRef='bbsp_lanctf_bindport'			RemarkRef="Empty"    				ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    InitValue="[{TextRef:'bbsp_lanctf_lan1',Value:'LAN1', ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan2',Value:'LAN2', ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan3',Value:'LAN3',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan4',Value:'LAN4',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan5',Value:'LAN5',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan6',Value:'LAN6',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan7',Value:'LAN7',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_lan8',Value:'LAN8',ClickStr:'onclick=GetBindPort'},
		{TextRef:'bbsp_lanctf_ssid1',Value:'SSID1',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid2',Value:'SSID2',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid3',Value:'SSID3',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid4',Value:'SSID4',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid5',Value:'SSID5',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid6',Value:'SSID6',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid7',Value:'SSID7',ClickStr:'onclick=GetBindPort'},{TextRef:'bbsp_lanctf_ssid8',Value:'SSID8',ClickStr:'onclick=GetBindPort'}]" />

		<script language="JavaScript" type="text/javascript">
			awifiTableClass = new stTableClass("width_per25", "width_per75", "ltr");
			HWParsePageControlByID("AwifiConfigInfo", awifiTableClass, lan_certification, null);

			initLeasedTime();
		</script>
		
	</table>
	<div class="func_spread"></div>
 </div> 
 <table width="100%" border="0"  class="tableButton"> 
    <tr>
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      <td width="25%"><button id="SaveAwifiConfigButton" type="button" class="submitButton" onClick="javascript:return onSaveButtonClick();"><script>document.write(lan_certification['bbsp_lanctf_save']);</script></button></td> 
    </tr> 
 </table> 
</form> 
</body>
</html>

