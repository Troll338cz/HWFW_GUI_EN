<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
    <script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
 	<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
	<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
    <script language="javascript" src="../../bbsp/common/userinfo.asp"></script>
    <script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>
    <script language="javascript" src="../../bbsp/common/managemode.asp"></script>
	<script language="javascript" src="../../bbsp/common/wan_list_info_e8c.asp"></script>
    <script language="javascript" src="../../bbsp/common/wan_list_e8c.asp"></script>
    <script language="javascript" src="../../bbsp/common/lanmodelist.asp"></script>
    <script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
    <script language="javascript" src="../../bbsp/common/<%HW_WEB_CleanCache_Resource(wan_check.asp);%>"></script>
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, route_language, vlan_ctc_language);%>"></script>
    <script language="javascript" src="../../amp/common/wlan_list.asp"></script>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
    <script>
	
	var MaxVlanPairsPerPort = 4;
	var MaxVlanPairs = 8;
	var SelectIndex = -1;
	var wans = GetWanList();
	var TopoInfo = GetTopoInfo();
	var stbport = '<%HW_WEB_GetSTBPort();%>';
	var CfgMode ='<%HW_WEB_GetCfgMode();%>';
	var TianYiFlag = '<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>';
	var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
	var E8CRONGHEFlag = '<%HW_WEB_GetFeatureSupport(FT_SHMP_RONGHE);%>';
    var CMCCFTTO = '<%HW_WEB_GetFeatureSupport(FT_CMCC_FTTO);%>';
	
	function isPortInAttrName()
	{
		if((1 == TianYiFlag) && ('E8C' == CurrentBin.toUpperCase()))
		{
			return true;
		}
		return false;
	}
    if(isPortInAttrName())
    {	
		var portNum = parseInt(GetTopoInfo().EthNum,10);
	
		if(portNum > 0)
		{
			for(var i=1;i<=portNum;i++)
			{
				if(i != 2)
				{
					vlan_ctc_language['bbsp_lan'+ i] = getTianYilandesc(i);
				}
			}
		}
	}
	
	if((parseInt(TopoInfo.EthNum,10) <= 2) || (false == IsE8cFrame()))
	{	
		vlan_ctc_language['bbsp_lan2'] = vlan_ctc_language['bbsp_lan2_ex'];
	}
	
	if( stbport > 0)
	{
		vlan_ctc_language['bbsp_lan'+ stbport] = vlan_ctc_language['bbsp_stb'];
		vlan_ctc_language['bbsp_lan2'] = vlan_ctc_language['bbsp_lan2_ex'];
	}

	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
	var LANPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.MultiSrvPortList.PhyPortName);%>'.toUpperCase();

	function ControlMultiSrvPort()
	{
		if (supportIPTVPort != 1)
		{
			return;
		}
		
		var tempLANPortValue = "";
		var tempLANPortInfo = "";
		var tempLANPortList = LANPortInfo.split(",");
		for (var i = 0; i < tempLANPortList.length; i++)
		{	
			if (tempLANPortList[i].indexOf(LANPath.toUpperCase()) != -1)
			{
				tempLANPortValue = tempLANPortList[i].substr(LANPath.length);
				var tempLANPortInfoList = tempLANPortValue.split(".");
				tempLANPortInfo = tempLANPortInfoList[0];
			}
			else
			{
				tempLANPortValue = tempLANPortList[i].substr(SSIDPath.length);
				var tempLANPortInfoList = tempLANPortValue.split(".");
				tempLANPortInfo = parseInt(tempLANPortInfoList[0]) + 8;
			}

			setDisable("Vlan_Port_checkbox" + tempLANPortInfo, 1);
		}
		
	}
	
	
	function IsLanPortType(BindInfo)
	{
		if(BindInfo.domain.indexOf("LANEthernetInterfaceConfig") >= 0)
			return true;
		else
			return false;
	}
	

	function BindInfoClass(domain, Mode, Vlan)
	{
		this.domain = domain;
		this.Mode = Mode;
		if(Mode == 1)
			this.Vlan = Vlan.replace(/;/g, ",");
		else
			this.Vlan = "";
		this.PortName = '';
	}
	
	var LanArray = new Array();
	var __LanArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i},X_HW_Mode|X_HW_VLAN,BindInfoClass);%>;
	var __SSIDArray = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},X_HW_Mode|X_HW_VLAN,BindInfoClass);%>;

	var wlanstate = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>'; 

	var _LanPortNum = ((__LanArray.length - 1) > GetTopoInfo().EthNum) ? GetTopoInfo().EthNum : (__LanArray.length - 1);
	
	for(var i = 0; i < _LanPortNum; i++)
	{
		__LanArray[i].PortName = 'LAN' + __LanArray[i].domain.charAt(__LanArray[i].domain.length-1)
		LanArray.push(__LanArray[i]);
	}
	
	for(var j = 0, SL = GetSSIDList(); (TopoInfo.SSIDNum != 0) && (j < SL.length) ; j++)
	{		
		for(var i = 0; i < __SSIDArray.length - 1; i++)
		{
			if(__SSIDArray[i].domain == SL[j].domain)
			{
				__SSIDArray[i].PortName = "SSID" + getWlanInstFromDomain(SL[j].domain);
				LanArray.push(__SSIDArray[i]);
				
				break;
			}
		}
	}

	function ControlLanWanBind()
	{
		var ISPPortList = Instance_IspWlan.GetISPPortList();
		var FeatureInfo = GetFeatureInfo(); 
		
		for (var i = 1; i <= parseInt(TopoInfo.EthNum); i++)
		{
			if (IsL3Mode(i) == "0")
			{
				setDisable("Vlan_Port_checkbox"+i, 1);
			}
			
			if(stbport == i && E8CRONGHEFlag == 1)
			{
				setDisplay("DivVlan_Port_checkbox" + i, 0);
			}
		}
		
		for (var i = parseInt(TopoInfo.EthNum)+1; i <= 8; i++)
		{
			setDisplay("DivVlan_Port_checkbox"+i, 0);
		}
	
		var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';      
	
		if (1 != DoubleFreqFlag)
		{
			for (var i = parseInt(TopoInfo.SSIDNum)+9; i <= 16; i++)
				{
					setDisplay("DivVlan_Port_checkbox"+i, 0);
				}
		}
		
		if(ISPPortList.length > 0)
		{
			for (var i = 1; i <= parseInt(TopoInfo.SSIDNum); i++)
			{
				var pos = ArrayIndexOf(ISPPortList, 'SSID'+i);
				if(pos >= 0)
				{
					var DivID = i + 8;
					setDisplay("DivVlan_Port_checkbox"+DivID, 0);
				}
			}
		}
		
	
		if(1 == DoubleFreqFlag)
		{
			for (var i = 0; i < WlanList.length; i++)
			{
				var tid = parseInt(i+9);
				if (WlanList[i].bindenable == "0")
				{  
					setDisable("Vlan_Port_checkbox"+tid, 1);
				}
	
				if((WlanList[i].bindenable == "1")&&(enbl5G != 1))
				{			
					if(tid > 12)
					{
						setDisable("Vlan_Port_checkbox"+tid, 1);
					}
				}
				
				if((WlanList[i].bindenable == "1")&&(enbl2G != 1))
				{
					if(tid < 13)
					{
						setDisable("Vlan_Port_checkbox"+tid, 1);
					}
				}
			}
		}
		else
		{
			for (var i = 0; i < WlanList.length; i++)
			{
				var tid = parseInt(i+1+4+4);
				if (WlanList[i].bindenable == "0")
				{  
					setDisable("Vlan_Port_checkbox"+tid, 1);
				}
			}
		}
	}
		
    function OnPageLoad()
    {
        ControlLanWanBind();
        ControlMultiSrvPort();
        if (((CfgMode.toUpperCase() == 'BJCMCC_RMS') || (CfgMode.toUpperCase() == 'CMCC_RMS')) && (CMCCFTTO == 1)) {
            setDisplay("DivVlan_Port_checkbox12", 0);
            setDisplay("DivVlan_Port_checkbox16", 0);
        }
        return true; 
    }

    function IsBindBindVlanValid(BindVlan)
    {   
	var LanVlanWanVlanList = BindVlan.split(",");
	var LanVlan0;
	var WanVlan;
	var TempList;
	var vlanpairnum = 0;
		
	for (var i = 0; i < LanVlanWanVlanList.length; i++)
	{
		TempList = LanVlanWanVlanList[i].split("/");
			
		if (TempList.length != 2)
		{
			AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_vlanpainvalid1']);
			return false;
		}
			
		if ((!isNum(TempList[0])) || (!isNum(TempList[1])))
		{
			AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_vlanpainvalid1']);
			return false;				
		}
			
		if (!(parseInt(TempList[0],10) >= 1 && parseInt(TempList[0],10) <= 4094))
		{
			AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_invlan']+vlan_ctc_language['bbsp_vlanpainvalid1']);
			return false;
		}
			
		if (!(parseInt(TempList[1],10) >= 1 && parseInt(TempList[1],10) <= 4094))
		{
			AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_wan_vlan']+vlan_ctc_language['bbsp_vlanpainvalid1']);
			return false;
		}	
		
		vlanpairnum++;
		
		if (vlanpairnum > MaxVlanPairsPerPort)
		{
			AlertEx(vlan_ctc_language['bbsp_vp_per_port_overflow']);
			return false;
		}
	}

	for(var i in LanArray)
	{
		if((LanArray[i].Vlan.length != 0) && ((SelectIndex - 1) != i))
		{
			vlanpairnum += LanArray[i].Vlan.split(",").length;
		}
	}
	
	if (vlanpairnum > MaxVlanPairs)
	{
		AlertEx(vlan_ctc_language['bbsp_vlanpairs_overflow']);
		return false;
	}		
	
	return true;		        
		        
    }
	
    function getSelectUserPort()
	{
		var UserPortStr = "";
		var UserPortId = "";
		for (var i = 1; i <= 16; i++)
		{
			UserPortId = 'Vlan_Port_checkbox' + i;
			if (true == getElement(UserPortId).checked)
			{
				if (i <= 8)
				{
					UserPortStr += "/LAN" + i;
				}
				else
				{
					UserPortStr += "/SSID" + (i - 8);
				}
			}
		}
		UserPortStr = UserPortStr.substring(1,UserPortStr.length);
		return UserPortStr;
	}
	
	function CheckVlanValid(VlanID,filedDesc)
	{
		var errmsg="";
		errmsg=checkVlanID(VlanID,""); 
		if("" != errmsg)
		{
			AlertEx(filedDesc+errmsg);
			return false;
		}
	  return true;
	}

    function CheckParameter(BindVlan, Mode)
    {
		var UserPortList = getSelectUserPort().split('/'); 
	
		if ((Mode == "vlanbinding") && (0 == BindVlan.length) )
		{
			AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_vlanisreq']);
			return false;
		}

	   if (Mode == "vlanbinding")
	   {
		   if (IsBindBindVlanValid(BindVlan) == false)
		  {
			  return false;
		  }
	   }

	   for (var i = 0;i < UserPortList.length; i++)
	   {
		   if((UserPortList[i].indexOf("SSID") >= 0) && (1 != wlanstate))
		   {
				AlertEx(vlan_ctc_language['bbsp_vlan_wifi_invalid']);
				return false;
		   }
	   }
	   
	   return true;
    }
    
	function getNewBindVlanInfo()
	{
		var UserVlan = getValue('Vlan_text');
		var wanDomain = getSelectVal('Vlan_WanConnect_select');
		var WanVlan = getWanVlanByDomain(wanDomain);
		var CurBindVlan = UserVlan + '/' + WanVlan;
		var OldBindVlan = "";
		var NewLanArray = new Array();
		var Idx = 0;

		var UserPortList = getSelectUserPort().split('/'); 
		for (var i = 0; i < UserPortList.length; i++) 
		{
			OldBindVlan = "";
			if((UserPortList[i].indexOf("LAN") >= 0)||(UserPortList[i].indexOf("SSID") >= 0))
			{
				for (var j = 0; j < LanArray.length; j++)
				{
					if (UserPortList[i] == LanArray[j].PortName)
					{
						OldBindVlan = LanArray[j].Vlan;
						break;
					}
				}
				if ('' == OldBindVlan)
				{
					NewLanArray[Idx] = new BindInfoClass(LanArray[j].domain,1,CurBindVlan);
				}
				else
				{
					NewLanArray[Idx] = new BindInfoClass(LanArray[j].domain,1,OldBindVlan + ',' + CurBindVlan);
				}
				NewLanArray[Idx].PortName = LanArray[j].PortName;
				Idx++;
			}
		}
		return NewLanArray;
	}
	
	function getWanVlanByDomain(domain)
	{
		var vlan = "";
		for (var i = 0; i < wans.length; i++)
		{
			if (domain == wans[i].domain)
			{
				vlan = wans[i].VlanId;
			}
		}
		return vlan;
	}
	function checkRepeateCfg(userVlan,wanVlan,portList)
	{
		var strVlan = userVlan+"/"+wanVlan;
		for(var i = 0; i < portList.length; i++){
    	    for (var j = 0; j < LanArray.length; j++){
                if (portList[i] == LanArray[j].PortName){
					var LanArrayVlan = LanArray[j].Vlan.split(','); 
					for(var m = 0; m < LanArrayVlan.length; m++)
					{
						if (strVlan == LanArrayVlan[m])
						{
							 AlertEx(vlan_ctc_language['bbsp_vlanBindcfgrepeat']);
							 return false;
						} 
					}
    		    }
    	    }
	    }
	    return true;
	}
	function checkForm()
	{
		var UserVlan = getValue('Vlan_text');
		var UserPortList = getSelectUserPort().split('/'); 
		var wanDomain = getSelectVal('Vlan_WanConnect_select');

		if ('' == getSelectUserPort())
		{
			AlertEx(vlan_ctc_language['bbsp_SelectUserPort']);
			return false;
		}
		if (''== UserVlan)	
		{
			AlertEx(vlan_ctc_language['bbsp_UserVlanReq']);
			return false;
		}
		if(('' != UserVlan)&&(CheckVlanValid(UserVlan,"") == false))
		{
			return false;
		}
		if ('' == wanDomain)
		{
			AlertEx(route_language['bbsp_alert_wan']);
			return false;
		}
		for (var i = 0;i < UserPortList.length; i++)
		{
		   if((UserPortList[i].indexOf("SSID") >= 0) && (1 != wlanstate))
		   {
				AlertEx(vlan_ctc_language['bbsp_vlan_wifi_invalid']);
				return false;
		   }
		}
		var WanVlan = getWanVlanByDomain(wanDomain);
		if(false == checkRepeateCfg(UserVlan,WanVlan,UserPortList))
		{
			return false;
		}

		return true;
	}
    function FillPerBindInfo(Form,newLanArray,prefix)
    {
		var BindVlan = newLanArray.Vlan;
		var vlanpairnum = BindVlan.split(',').length;
		
		if (vlanpairnum > MaxVlanPairsPerPort)
		{
			AlertEx(vlan_ctc_language['bbsp_vp_per_port_overflow']);
			return false;
		}
		Form.addParameter(prefix + '.X_HW_Mode', 1);
        Form.addParameter(prefix + '.X_HW_VLAN', BindVlan);
        return true;
    }

    function OnApplyButtonClick()
    {
		if (false == checkForm())
		{
			return false;
		}
		var NewLanArray = getNewBindVlanInfo();
		var url = "";
		var prefix = "";
		var oldvlanpairnum = 0;
		var addvlanpairnum = NewLanArray.length;
		var newvlanpairnum = 0;
		var Form = new webSubmitForm();
		
		for (var i = 0; i < NewLanArray.length; i++) 
		{
			if ((NewLanArray[i].PortName.indexOf("LAN") >= 0) || (NewLanArray[i].PortName.indexOf("SSID") >= 0))
			{
				url += '&x' + i + '=' + NewLanArray[i].domain;
			}
			prefix = 'x' + i;
			if (FillPerBindInfo(Form, NewLanArray[i],prefix) == false)
			{
				return false;
			}
		}
		
		for (var j = 0; j < LanArray.length; j++) 
		{
			if((LanArray[j].Vlan.length != 0))
			{
				oldvlanpairnum += LanArray[j].Vlan.split(",").length;
			}
		}
		newvlanpairnum = oldvlanpairnum + addvlanpairnum;
		if (newvlanpairnum > MaxVlanPairs)
		{
			AlertEx(vlan_ctc_language['bbsp_vlanpairs_overflow']);
			return false;
		}		
		
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('complex.cgi?' +url+ '&RequestFile=html/bbsp/vlanctc/vlanctce8c.asp');   
        Form.submit();
        return false;
    }

    function OnCancelButtonClick()
    {
        document.getElementById("TableUrlInfo").style.display = "none";
        return false;

    } 
 
    function OnChooseDeviceType(Select)
    {
       var Mode = getElementById("ChooseDeviceType").value;
    
       if (Mode == "lanwanbinding")
       {
           getElById("BindVlanRow").style.display = "none";        
       }
       else if (Mode == "vlanbinding")
       {
           getElById("BindVlanRow").style.display = "";
       }
        
    }

	function onClickDel(id)
	{
		var CommonLanArray = getCommonLanListInfo();
		var rmId = id.charAt(id.length-1);
		var vlanPairList = "";
		var BindVlan = "";
		
		for (var i = 0; i < CommonLanArray.length; i++)
		{
			if (rmId != i)
			{
				if (CommonLanArray[rmId].PortName == CommonLanArray[i].PortName)
				{
					vlanPairList += ',' + CommonLanArray[i].Vlan;
				}
			}
		}
		
		BindVlan =  vlanPairList.substring(1,vlanPairList.length);
		var Form = new webSubmitForm();
		Form.addParameter('x.X_HW_Mode', CommonLanArray[rmId].Mode);
        Form.addParameter('x.X_HW_VLAN', BindVlan);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('set.cgi?x=' + CommonLanArray[rmId].domain + '&RequestFile=html/bbsp/vlanctc/vlanctce8c.asp');
		Form.submit();
	}
	function getCommonLanListInfo()
	{
		var Idx = 0;
		var CommonLanArray = new Array();
		for (var i = 0; i < LanArray.length; i++)
		{  
		  var UserVlan = "";
		  var WanVlan = "";
		  var vlanPairList = "";
		  var vlanPairNum = 0;

		  if(!((LanArray[i].Vlan == "") || (LanArray[i].Mode == 0)))
		  {
			 vlanPairList = LanArray[i].Vlan.split(',');
			 vlanPairNum = vlanPairList.length;
			 for (var j = 0; j < vlanPairNum; j++)
			 {
				UserVlan = (vlanPairList[j]).split('/')[0];
				WanVlan = (vlanPairList[j]).split('/')[1];
				CommonLanArray[Idx] = new BindInfoClass(LanArray[i].domain,LanArray[i].Mode,UserVlan + '/' + WanVlan);
				CommonLanArray[Idx].PortName = LanArray[i].PortName;
				Idx++;
			 }
		  }
	  }
	  return CommonLanArray;
	}
	
	function showPortName(name)
	{
		var PortName = "";
		switch(name)
		{
			case "LAN1":
				PortName = vlan_ctc_language['bbsp_lan1'];
				break;
			case "LAN2":
				if (CfgMode.toUpperCase() == 'GZGD')
				{
					PortName = vlan_ctc_language['bbsp_lan2_ex'];
				}
				else
				{
					PortName = vlan_ctc_language['bbsp_lan2'];
				}
				break;
			case "LAN3":
				PortName = vlan_ctc_language['bbsp_lan3'];
				break;
			case "LAN4":
				PortName = vlan_ctc_language['bbsp_lan4'];
				break;
			case "LAN5":
				PortName = vlan_ctc_language['bbsp_lan5'];
				break;
			case "LAN6":
				PortName = vlan_ctc_language['bbsp_lan6'];
				break;
			case "LAN7":
				PortName = vlan_ctc_language['bbsp_lan7'];
				break;
			case "LAN8":
				PortName = vlan_ctc_language['bbsp_lan8'];
				break;
			default:
			    PortName = name;
				break;
		}
		return PortName;
	}
	
	function CreateLanList()
	{
		var CommonLanArray = getCommonLanListInfo();
		var HtmlCode = ""; 
		var UserVlan = "";
		var WanVlan = "";
		if (0 == CommonLanArray.length)
		{
			HtmlCode += '<tr id= "record_no" align = "center" class="tabal_01">';
			HtmlCode += '<td >' + '--'+ '</td>';
			HtmlCode += '<td >' + '--'+ '</td>';
			HtmlCode += '<td >' + '--'+ '</td>';
			HtmlCode += '<td >' + '--'+ '</td>';
			HtmlCode += '</tr>'; 
		}
		else
		{
			for (var i = 0; i < CommonLanArray.length; i++)
			{
				if (E8CRONGHEFlag == 1 && CommonLanArray[i].PortName == "LAN" + stbport)
				{
					continue;
				}
				
				HtmlCode += '<tr id= "record_' + i +'" align = "center" class="tabal_01">';
				HtmlCode += '<td >' + showPortName(CommonLanArray[i].PortName) + '</td>';
				if ('' != CommonLanArray[i].Vlan)
				{
					UserVlan = CommonLanArray[i].Vlan.split('/')[0];
					WanVlan = CommonLanArray[i].Vlan.split('/')[1];
					HtmlCode += '<td>' + UserVlan+ '</td>'; 
					HtmlCode += '<td>' + WanVlan+ '</td>';
				}
				else
				{
					HtmlCode += '<td>' + '--'+ '</td>'; 
					HtmlCode += '<td>' + '--'+ '</td>';
				}
				HtmlCode += '<td>' + '<input name="rm" type="button" id="rm' + i +'" onClick="onClickDel(this.id);" value="' + vlan_ctc_language['bbsp_del'] + '"/>'+'</td>';
				HtmlCode += '</tr>'; 
			}
		}
		return HtmlCode;
	}
	
	function setControl(index) 
	{ 
	}

	function WriteOption()
	{
		for (var k = 0; k < wans.length; k++)
		{
            if (wans[k].X_HW_VXLAN_Enable == 1)
			{
                continue;
            }
		   if ((wans[k].VlanId != 0)&&((wans[k].ServiceList.match("INTERNET"))||(wans[k].ServiceList.match("OTHER"))||(wans[k].ServiceList.match("IPTV")) || (wans[k].ServiceList.match('SPECIAL_SERVICE'))))
		   {
			   document.write('<option value="' + wans[k].domain + '">' 
							+ MakeWanName1(wans[k]) + '</option>');	 					
		   }	   	 					
		}	
	}
	
    </script>
    <title>LAN VLAN Bind Configuration</title>

</head>
<body  class="mainbody" onload="OnPageLoad();">
<form id="ConfigForm">
<div id="PromptPanel">
	<div class="title_with_desc" BindText='bbsp_vlan_ctc_title1'></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="title_common" BindText='bbsp_vlan_ctc_title2'>
			</td>
		</tr>
    </table>
	<div class="title_spread"></div>
</div>

  <table class="tabal_bg" id="tabinfo" border="0" cellspacing="1"  width="100%">
    <tr  class="head_title">
        <td BindText='bbsp_UserPort'></td>
		<td BindText='bbsp_UserVlan'></td>
		<td BindText='bbsp_WanVlan'></td>
        <td BindText='bbsp_del'></td>
     </tr>    
    <script>
   document.write(CreateLanList());              
   </script>  
 </table>
 
 <div class="func_spread"></div>

  <div id="TableUrlInfo" style="display:block">
  <table cellspacing="0" cellpadding="0" border="0" width="100%">
	  <tr class="trTabConfigure" id="BindLanListRow"> 
	 	<td  class="table_title width_per25" BindText='bbsp_UserPort'></td> 
		<td  class="table_right width_per75">
		<span id="DivVlan_Port_checkbox1" ><input id="Vlan_Port_checkbox1" name="Vlan_Port_checkbox1" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan1']);</script> &nbsp;</span>
		<span id="DivVlan_Port_checkbox2" ><input id="Vlan_Port_checkbox2" name="Vlan_Port_checkbox2" type="checkbox" value="True">
		<script>
		if (CfgMode.toUpperCase() == 'GZGD')
		{
			document.write(vlan_ctc_language['bbsp_lan2_ex']);
		}
		else
		{
			document.write(vlan_ctc_language['bbsp_lan2']);
		}
		</script> &nbsp;</span>
		<span id="DivVlan_Port_checkbox3" ><input id="Vlan_Port_checkbox3" name="Vlan_Port_checkbox3" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan3']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox4" ><input id="Vlan_Port_checkbox4" name="Vlan_Port_checkbox4" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan4']);</script> &nbsp;</span>
		</br>
		<span id="DivVlan_Port_checkbox5" ><input id="Vlan_Port_checkbox5" name="Vlan_Port_checkbox5" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan5']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox6" ><input id="Vlan_Port_checkbox6" name="Vlan_Port_checkbox6" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan6']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox7" ><input id="Vlan_Port_checkbox7" name="Vlan_Port_checkbox7" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan7']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox8" ><input id="Vlan_Port_checkbox8" name="Vlan_Port_checkbox8" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_lan8']);</script> &nbsp;</span>
		</br>
		<span id="DivVlan_Port_checkbox9" ><input  id="Vlan_Port_checkbox9" name="Vlan_Port_checkbox9" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid1']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox10" ><input id="Vlan_Port_checkbox10" name="Vlan_Port_checkbox10" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid2']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox11" ><input id="Vlan_Port_checkbox11" name="Vlan_Port_checkbox11" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid3']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox12" ><input id="Vlan_Port_checkbox12" name="Vlan_Port_checkbox12" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid4']);</script> &nbsp;</span>
		</br>
		<span id="DivVlan_Port_checkbox13" ><input id="Vlan_Port_checkbox13" name="Vlan_Port_checkbox13" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid5']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox14" ><input id="Vlan_Port_checkbox14" name="Vlan_Port_checkbox14" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid6']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox15" ><input id="Vlan_Port_checkbox15" name="Vlan_Port_checkbox15" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid7']);</script> &nbsp;</span>
        <span id="DivVlan_Port_checkbox16" ><input id="Vlan_Port_checkbox16" name="Vlan_Port_checkbox16" type="checkbox" value="True"><script>document.write(vlan_ctc_language['bbsp_ssid8']);</script> &nbsp;</span>
		</td> 
	  </tr>
    <tr class="trTabConfigure">
    	<td  class="table_title width_per25 align_left" BindText='bbsp_UserVlan'></td>
		<td  class="table_right"><input name="Vlan_text" type="text" id="Vlan_text" maxlength="4" size="4"><font color="red">*</font><span class="gray"><script>document.write(vlan_ctc_language['bbsp_mvlanidrange']);</script></span> </td> 
    </tr>
    <tr > 
	  <td  class="table_title" BindText='bbsp_BindWanName'></td> 
	  <td  class="table_right"> <select name='Vlan_WanConnect_select'  id="Vlan_WanConnect_select" maxlength="30" size="1"> 
		  <script language="javascript">
			   WriteOption();
			</script> 
		</select> </td> 
	</tr> 
  </table>
  <div class="button_spread"></div>
	<table class="table_button" cellspacing="1" id="cfg_table" width="100%"> 
      <tr align="right">
	    <td class="width_per20"></td>
        <td> 
		  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		  <button id="addButton" name="addButton" type="button" class="submit" onClick="javascript:return OnApplyButtonClick();"><script>document.write(vlan_ctc_language['bbsp_app']);</script></button>
		</td> 
      </tr>   
    </table>
</div>

</form>
<script>
ParseBindTextByTagName(vlan_ctc_language, "td", 1);
ParseBindTextByTagName(vlan_ctc_language, "div", 1);
</script>
<div class="subWanListPolicyRoute subWanListIPVersion subIspWlan subDSLite subV6RDTunnel subRadioWan subWanStats subWANAccessType">
    <script type="text/javascript">
        function RenderPage(event) {
            if (event.type == "evtIspWlan") {
                ControlLanWanBind();
                ControlMultiSrvPort();
            }
        }
        LazyLoad();
    </script>
</div>
</body>
</html>


