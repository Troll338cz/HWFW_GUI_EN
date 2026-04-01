<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<title>Easy Setup</title>
<script language="JavaScript" type="text/javascript">

var url = "";
var MultiUser = 0;
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ShowOldPwd = 0;
var sptUserName;
var sptAdminName;
var UserNum = 0;
var CurUserBuf = new Array(); 
var CurUserInst = new Array();
var PwdType = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_PWDTYPE.UINT32);%>'
var PwdMinLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'
var viettelflag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_VIETTEL);%>';
var EditFlag = false;
var IsViettel8045A2Flag='<%HW_WEB_GetFeatureSupport(FT_SSMP_VIETTEL_8045MODE);%>';

function GetLanguageDesc(Name)
{
    return CfgguideLgeDes[Name];
}

var PortVlanInfoFromAsp='<%HW_WEB_GetTagSvrMap();%>';

function MainDHCP(domain, DHCPServerEnable)
{
	this.domain = domain;
	this.DHCPServerEnable = DHCPServerEnable;
}

function TagSvrInfo(domain, TagServiceMappingInfo)
{
	this.domain = domain;
	this.TagServiceMappingInfo = TagServiceMappingInfo;
}

function stLayer3Enable(domain, lay3enable)
{
	this.domain = domain;
	this.lay3enable = lay3enable;
}

function stLanbindInfo(domain,lan1enable,lan2enable,lan3enable,lan4enable)
{
	this.domain = domain;
	this.lan1enable = lan1enable;
	this.lan2enable = lan2enable;
	this.lan3enable = lan3enable;
	this.lan4enable = lan4enable;
}

function stPortTagPriInfo(vlan, pri)
{
	this.vlan = vlan;
	this.pri = pri;
}

function stSvrMapInfo(vlan, pri, info)
{
	this.vlan = vlan;
	this.pri = pri;
	this.info = info;
}

function TopoInfoClass(Domain, EthNum, SSIDNum)
{
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}
function stLayer3Info(l1,l2,l3,l4,l5)
{
    this.LAN1 = l1;
    this.LAN2 = l2;
    this.LAN3 = l3;
    this.LAN4 = l4;   
    this.LAN5 = l5;
}
var DualBandEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WIFIInfo.X_HW_WLANForOnlySaveCfg.DualBandUnified);%>';
var Lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 
var wanppplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i}.X_HW_LANBIND,Lan1Enable|Lan2Enable|Lan3Enable|Lan4Enable,stLanbindInfo);%>;
var waniplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_LANBIND,Lan1Enable|Lan2Enable|Lan3Enable|Lan4Enable,stLanbindInfo);%>;

var MainDhcpRangeInst = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,DHCPServerEnable,MainDHCP);%>;  
var MainDhcpRange = MainDhcpRangeInst[0];

var TagServiceMappingInfoInst = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_FeatureList.BBSPWebCustomization,TagServiceMappingInfo,TagSvrInfo);%>;  
var TagSvrMapInfo = ""; 
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfoClass);%>
var TopoInfo = TopoInfoList[0];
TopoInfo.EthNum = '<%GetLanPortNum();%>';
var LanNum = 8;
var SsidNum = 8;
var Layer3Info = new stLayer3Info();
for (var i = 1; i <= TopoInfo.EthNum; i++)
{
    if (Lay3Enables[i-1] != null)
    {
        Layer3Info["LAN"+i] = Lay3Enables[i-1].lay3enable;
    }
    else
    {
        Layer3Info["LAN"+i] = "0";
    }
}
if (1 < TagServiceMappingInfoInst.length)
{
    TagSvrMapInfo = TagServiceMappingInfoInst[0];
}

var wan = GetWanList();

function isL3port(PortId)
{
	if (PortId<1 || PortId>TopoInfo.EthNum)
		return false;
		
	if (Lay3Enables[PortId-1].lay3enable == "1")
	{
		return true;
	}
	else
	{
		return false;
	}
}

function GetBindWanDomain(PortId)
{
	var WanDomain = new Array();

	if (PortId<1 || PortId>TopoInfo.EthNum)
		return "";

	for (var i=0; i<wanppplanbind.length-1; i++)
	{
		if ((PortId == "1" && wanppplanbind[i].lan1enable == "1")
			|| (PortId == "2" && wanppplanbind[i].lan2enable == "1")
			|| (PortId == "3" && wanppplanbind[i].lan3enable == "1")
			|| (PortId == "4" && wanppplanbind[i].lan4enable == "1"))
		{
			WanDomain.push(wanppplanbind[i].domain.substring(0, wanppplanbind[i].domain.length-13)) ;
		}
	}
	
	for (var i=0; i<waniplanbind.length-1; i++)
	{
		if ((PortId == "1" && waniplanbind[i].lan1enable == "1")
			|| (PortId == "2" && waniplanbind[i].lan2enable == "1")
			|| (PortId == "3" && waniplanbind[i].lan3enable == "1")
			|| (PortId == "4" && waniplanbind[i].lan4enable == "1"))
		{
			WanDomain.push(waniplanbind[i].domain.substring(0, waniplanbind[i].domain.length-13)) ;
		}
	}

	return WanDomain;
}

function GetWanVlanPrinByDomain(domain)
{
	var VlanPri = new stPortTagPriInfo("","");
	
	for (var i=0; i<wan.length; i++)
	{
		if (domain == wan[i].domain)
		{
			VlanPri.vlan = wan[i].VlanId;
			if (wan[i].PriorityPolicy == "CopyFromIPPrecedence")
			{
				VlanPri.pri = "";
			}
			else
			{
				VlanPri.pri = wan[i].Priority;				
			}
		}
	}
	
	return VlanPri;
}

function ParseXmlInfo()
{
	var XmlSvrInfo = TagSvrMapInfo.TagServiceMappingInfo.split(';');
	var SvrMapInfo = new Array();
	
	for (var i=0; i<XmlSvrInfo.length-1; i++)
	{
		var SvrInfo = XmlSvrInfo[i].split("#");
		if (SvrInfo.length == 3)
		{
			if (SvrInfo[0] == ""&&SvrInfo[1] != "")
			{
				SvrInfo[0] = 0;
			}
			SvrMapInfo.push( new stSvrMapInfo(SvrInfo[0], SvrInfo[1], SvrInfo[2]));
		}
		else
		{
			return "";
		}
	}

	return SvrMapInfo;
}

function GetPortOrWanTagInfo(portId)
{
	var domainInfo = new Array();
	var WanVlan = new Array();
	var portVlanInfo = new Array();
	var portVlan = new Array();
	
	if (portId<"1" || portId>TopoInfo.EthNum)
		return "";
		
	if (isL3port(portId) == true)
	{
		domainInfo = GetBindWanDomain(portId);

		if (domainInfo != "")
		{
			for (var i=0; i<domainInfo.length; i++)
			{
				WanVlan.push(GetWanVlanPrinByDomain(domainInfo[i]));
			}
		}
		else
		{
			WanVlan.push(new stPortTagPriInfo("",""));
		}
	}
	else
	{
		portVlanInfo = PortVlanInfoFromAsp.split('*');

		for (var i=0; i<portVlanInfo.length-1; i++)
		{
			portVlan = portVlanInfo[i].split('#');
			
			if (portVlan[0] == "LAN"+portId)
			{
				for (var j=1; j<portVlan.length-1; j++)
				{
					WanVlan.push(new stPortTagPriInfo(portVlan[j].split('/')[0], portVlan[j].split('/')[1]));
				}
			}
		}
	}

	return WanVlan;
}

function findInfo(finalInfo, info)
{
	for (var i=0; i<finalInfo.length; i++)
	{
		if (finalInfo[i] == info)
		{
			return "";
		}
	}
	
	return info;
}

function InitPortServiceInfo()
{
	var EthNum = TopoInfo.EthNum;
	var i;
	var xmlInfo = ParseXmlInfo();
	var find = 0;

	for (i = 1; i <= EthNum; i++)
	{
		var tagInfo = GetPortOrWanTagInfo(i);
		var ServiceInfoFinal = new Array;
		find = 0;
				
		document.write('<td>');
		if (tagInfo.length != 0)
		{
			if (tagInfo[0].vlan == "" && tagInfo[0].pri == "")
			{
				for (var k=0; k<xmlInfo.length; k++)
				{
					if (xmlInfo[k].vlan == "" && xmlInfo[k].pri == "")
					{
						if (xmlInfo[k].info != "")
						{
							ServiceInfoFinal.push(xmlInfo[k].info);
							find = 1;
						}
					}
				}
			}
			else
			{
				for (var j=0; j<tagInfo.length; j++)
				{
					for (var k=0; k<xmlInfo.length; k++)
					{
						if (tagInfo[j].vlan == xmlInfo[k].vlan && tagInfo[j].pri == xmlInfo[k].pri)
						{
							if ("" != findInfo(ServiceInfoFinal, xmlInfo[k].info))
							{
								ServiceInfoFinal.push(xmlInfo[k].info);
							}
							find = 1;
						}
					}
				}
				
				if (find == 0)
				{
					for (var j=0; j<tagInfo.length; j++)
					{
						for (var k=0; k<xmlInfo.length; k++)
						{
							if (tagInfo[j].vlan == xmlInfo[k].vlan && "" == xmlInfo[k].pri )
							{
								if ("" != findInfo(ServiceInfoFinal, xmlInfo[k].info))
								{
									ServiceInfoFinal.push(xmlInfo[k].info);
								}
								find = 1;
							}
						}
					}
				}
			}
		}
		
		if (find == 0)
		{
			document.write('<div align="center">' + 'unknown' + '</div>');
		}
		else
		{
			for (var j=0; j<ServiceInfoFinal.length; j++)
			{
				document.write('<div align="center">' + ServiceInfoFinal[j] + '</div>');
			}
		}
		
		document.write('</td>');
	}
}

function SetDhcpData()
{
	setCheck('dhcpSrvEnable', MainDhcpRange.DHCPServerEnable);
}

var PPPwanInfo = new Array();

function GetFirstPPPoEWanByType(type)
{
	for(var i=0;i<wan.length;i++)
	{
		if ((wan[i].ServiceList == type) && (wan[i].EncapMode == "PPPoE")&&(wan[i].Mode == "IP_Routed") && ( 1 == wan[i].Enable ))
		{
			return wan[i];
		}
	}
	
	return "";
}

function InitServiceData()
{
	var internet = GetFirstPPPoEWanByType("INTERNET");
	var voip = GetFirstPPPoEWanByType("VOIP");

	if(internet != "")
	{
		PPPwanInfo.push(internet);
	}
	
	if(voip != "")
	{
		PPPwanInfo.push(voip);
	}
}

InitServiceData();

function replaceSpace(str)
{
	var str_encode = $('<div/>').text(str).html();
	
	if(str_encode.indexOf(" ") != -1)
	{
		str_encode = str_encode.replace(/ /g,"&nbsp;");
	}
	return str_encode;
}

function CheckInput()
{
	var i;

	for (i=0; i<PPPwanInfo.length; i++)
	{
		PPPwanInfo[i].UserName = getValue('username'+i);
		
		$('#cf_username'+i).html(replaceSpace(getValue('username'+i)));
		document.getElementById('cf_password'+i).innerHTML = "**********";
	}

	if (getCheckVal("dhcpSrvEnable")=="1")
	{
		document.getElementById('cf_dhcpSrvEnable').innerHTML = waninfo_language['bbsp_enable'];
	}
	else
	{
		document.getElementById('cf_dhcpSrvEnable').innerHTML = waninfo_language['bbsp_disable'];
	}
	
	return true;
}

function DrawNewWan()
{
    var internetpppoewan = GetFirstPPPoEWanByType("INTERNET");
    if (viettelflag == 0){
        return;
    }
    if (internetpppoewan !="")
    {
        return;
    }
    var htmlline = '<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_bg">';
    htmlline += '<tr class="head_title"><td class="align_left" colspan="2" width="100%" BindText="snewwan"></td>';
    htmlline += '<tr><td class="table_title width_per25" >' +CfgguideLgeDes['snewwan'] +'</td>';
    htmlline += '<td class="table_right width_per75">'+ '<input class="submit" type="button" maxLength="63" id="newwanbutton"  value="' + CfgguideLgeDes['snewbutton'] + '" onClick="CreatWan(this);"></td></tr>';
    htmlline += '<tr id="newwanname" style="display: none;"><td class="table_title width_per25" >' +Languages['IPv4UserName'] +'</td>';
    htmlline += '<td class="table_right width_per75">' + '<input type="text" maxLength="63" id="newusername" size="15" value=""></td></tr>';
    htmlline += '<tr id="newwanpassord" style="display: none;"><td class="table_title width_per25" >' +Languages['IPv4Password'] +'</td>';
    htmlline += '<td class="table_right_pwd  width_per75">' + '<input  type="password" maxLength="63" id="newuserpassword" size="15" value="" autocomplete="off">'+'</td></tr>';
    htmlline += '</table>';
    $("#id_config").append(htmlline);
}
function ShowNewWan()
{
    var internetpppoewan = GetFirstPPPoEWanByType("INTERNET");    
    if (viettelflag == 0){
        return;
    }
    if (internetpppoewan !="" && !EditFlag)
    {
        return;
    }
    document.write('<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_bg" id="shownewaninfo">');
    document.write('<tr class="head_title"><td class="align_left" colspan="2" width="100%" BindText="snewwan"></td>')
    document.write('<tr><td class="table_title width_per25" >' +Languages['IPv4UserName'] +'</td>');
    document.write('<td class="table_right width_per75" id="cf_newusername"></td></tr>');
    document.write('<tr><td class="table_title width_per25" >' +Languages['IPv4Password'] +'</td>');
    document.write('<td class="table_right width_per75" id="cf_newpassword"></td></tr>');    
    document.write('</table>');        
}
function CreatWan(obj)
{
    if (obj.value == CfgguideLgeDes['snewbutton'])
    {
        EditFlag = true;        
        document.getElementById("newwanbutton").value = CfgguideLgeDes['sdelbutton'];
        setDisplay("newwanname",1);
        setDisplay("newwanpassord",1);
    }
    else
    {
        EditFlag = false;    
        document.getElementById("newwanbutton").value = CfgguideLgeDes['snewbutton'];
        document.getElementById("newusername").value = "";
        document.getElementById("newuserpassword").value = "";
        setDisplay("newwanname",0);
        setDisplay("newwanpassord",0);    
    }
}
function WriteNewWan()
{
     if (viettelflag == 0){
        return;
    }
    if (!EditFlag)
    {
        setDisplay("shownewaninfo",0);
        return;
    }
    setDisplay("shownewaninfo",1);
    $("#cf_newusername").html(htmlencode(getValue("newusername")));
    $("#cf_newpassword").html(" **********");
}
function SubmitNewWan()
{
    if (viettelflag == 0){
        return;
    }
    if (!EditFlag)
    {
        return;
    }
    var  submitvalue = "GROUP_a_y.Enable=1&GROUP_a_y.X_HW_IPv4Enable=1&GROUP_a_y.X_HW_IPv6Enable=1&";
    submitvalue += "GROUP_a_y.X_HW_IPv6MultiCastVLAN=-1&GROUP_a_y.X_HW_SERVICELIST=INTERNET&GROUP_a_y.X_HW_ExServiceList=&";
    submitvalue += "GROUP_a_y.X_HW_VLAN=35&GROUP_a_y.X_HW_PRI=0&GROUP_a_y.X_HW_PriPolicy=Specified&GROUP_a_y.X_HW_DefaultPri=0&GROUP_a_y.ConnectionType=IP_Routed&GROUP_a_y.X_HW_MultiCastVLAN=4294967295&GROUP_a_y.NATEnabled=1&GROUP_a_y.X_HW_NatType=0&";
    submitvalue += "GROUP_a_y.X_HW_IPv6MultiCastVLAN=-1&GROUP_a_y.X_HW_SERVICELIST=INTERNET&GROUP_a_y.X_HW_ExServiceList=&GROUP_a_y.X_HW_VLAN=35&GROUP_a_y.X_HW_PRI=0&GROUP_a_y.X_HW_PriPolicy=Specified&";
    submitvalue += "GROUP_a_y.X_HW_DefaultPri=0&GROUP_a_y.ConnectionType=IP_Routed&GROUP_a_y.X_HW_MultiCastVLAN=4294967295&GROUP_a_y.NATEnabled=1&GROUP_a_y.X_HW_NatType=0&";
    submitvalue += "GROUP_a_y.Username=" +FormatUrlEncode(getValue("newusername")) +"&GROUP_a_y.Password=" + FormatUrlEncode(getValue("newuserpassword")) + "&GROUP_a_y.X_HW_LcpEchoReqCheck=0";
    submitvalue += "&GROUP_a_y.DNSEnabled=1&GROUP_a_y.MaxMRUSize=1492&GROUP_a_y.DNSOverrideAllowed=0&GROUP_a_y.DNSOverrideAllowed=0";
    submitvalue += "&GROUP_a_y.DNSServers=&GROUP_a_y.X_HW_BindPhyPortInfo=&m.Alias=&m.Origin=AutoConfigured&m.IPAddress=&m.ChildPrefixBits=&m.AddrMaskLen=64&m.DefaultGateway=&n.Alias=&n.Origin=PrefixDelegation&n.Prefix=";
    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : submitvalue + "&x.X_HW_Token=" + getValue('onttoken'),
         url : "addcfg.cgi?GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANPPPConnection&m=GROUP_a_y.X_HW_IPv6.IPv6Address&n=GROUP_a_y.X_HW_IPv6.IPv6Prefix&RequestFile=html/ssmp/cfgguide/setup.asp",
     success : function(data) {
     }});    
}
function DrawWanMenu(step)
{
	if (step != "config" && step != "confirm")
	{
		return false;
	}
	
	for (var i=0; i<PPPwanInfo.length; i++)
	{
		document.write('<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_bg">');
		document.write('<tr class="head_title">');
		if (PPPwanInfo[i].ServiceList == "INTERNET")
		{
			document.write('<td class="align_left" colspan="2" width="100%">Internet WAN: PPPoE</td>');
		}
		else if (PPPwanInfo[i].ServiceList == "VOIP")
		{
			document.write('<td class="align_left" colspan="2" width="100%">VoIP WAN: PPPoE</td>');
		}
		document.write('</tr>');

		document.write('<tr>');

		document.write('<td class="table_title width_per25" >' +Languages['IPv4UserName'] +'</td>');
		if (step == "config")
		{
            document.write('<td class=\"table_right width_per75\">'+ '<input name=\"username' + i + '\" type=\"TextBox\" maxLength=\"63\" id=\"username' + i + '\" size=\"15\" value=\"' + htmlencode(PPPwanInfo[i].UserName) + '\">'+'</td>' );
		}
		else if (step == "confirm")
		{
			document.write('<td class="table_right width_per75" id="cf_username'+i+'"></td>');
		}
		
		document.write('</tr>');
		document.write('<tr>');
		document.write('<td class="table_title width_per25" >' +Languages['IPv4Password'] +'</td>');
		if (step == "config")
		{
			document.write('<td class=\"table_right_pwd  width_per75\">' + '<input name=\"password'+i +'\" type=\"password\" maxLength=\"63\" autocomplete=\"off\" id=\"password' + i +'\" size=\"15\" value=\"' + PPPwanInfo[i].Password+'\">'+'</td>');
		}
		else if (step == "confirm")
		{
			document.write('<td class="table_right  width_per75" id="cf_password'+i+'"></td>');
		}
		document.write('</tr>');

        if (viettelflag == 0){
		document.write('</table>');
            return;
	}
         if (PPPwanInfo[i].ServiceList == "INTERNET")
         {
            if (step == "config"){
                document.write('<tr><td class=\"table_title  width_per25\" BindText=\"s2017b\"></td>');
                document.write('<td class=\"table_right  width_per75\" id=\"LanPort\"></td></tr>');
                document.write('<tr><td class=\"table_title  width_per25\" BindText=\"s2017l\"></td>');
                document.write('<td class=\"table_right  width_per75\" id=\"Bindoption\"></td></tr>');
            }
            else if (step == "confirm"){
                document.write('<tr><td class=\"table_title  width_per25\" BindText=\"s2017b\"></td>');
                document.write('<td class=\"table_right  width_per75\" id=\"cf_LanPort\"></td></tr>');
                document.write('<tr><td class=\"table_title  width_per25\" BindText=\"s2017l\"></td>');
                document.write('<td class=\"table_right  width_per75\" id=\"cf_Bindoption\"></td></tr>');
            }
            document.write('</table>');            
         }
    }
}

function GetAllCheckboxValue(str){
    var CheckBoxList = document.getElementsByName(str);
    var arr = [];
    for (var i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }
        arr.push(CheckBoxList[i].value);
    }
    return arr;
}
function WriteLanPort(){
    var EthNum = TopoInfo.EthNum;
    var htmlline = "";
    for (var i=1;i<=EthNum;i++){
        htmlline +='<span><input id=\"DhcpLan_'+i+'\" name=\"LanWorkPortname\"  type=\"checkbox\" value=\"LAN'+i+'\"  onClick=\"ChangePortWork(this)\"><span BindText = \"sLAN'+ i +'\"></span></span> ';
    }
    $("#LanPort").append(htmlline);
}
function WriteBindOption(){
    var htmlline = "";
    for (var i=1;i<=LanNum;i++){
        htmlline +='<span style=\"display:none\" id=\"DivIPv4BindLanList'+i+'\"><input id=\"IPv4BindLanList_'+i+'\" name=\"IPv4BindLanListname\"  type=\"checkbox\" value=\"LAN'+i+'\" onClick=\"ChangeLanWanBind(this)\"><span BindText = \"sLAN'+ i +'\"></span></span> ';
    }
    htmlline +="<br>";
    for (var k=1;k<=SsidNum;k++){
        htmlline +='<span style=\"display:none\" id=\"DivIPv4BindSSIDList'+k+'\"><input id=\"IPv4BindSSIDList'+k+'\" name=\"IPv4BindSSIDListname\"  type=\"checkbox\" value=\"SSID'+k+'\"><span BindText = \"sSSID'+ k +'\"></span></span> ';
    } 
    $("#Bindoption") .append(htmlline);
}
function ControlLanWanBind(){
    for (var i = 1; i <= parseInt(TopoInfo.EthNum); i++)
    {
        setDisplay("DivIPv4BindLanList"+i, 1);
    }
    for (var j = 1; j <= TopoInfo.SSIDNum; j++)
    {
        setDisplay("DivIPv4BindSSIDList"+j, 1);
    } 
}
function ChangePortWork(obj){
    var id = obj.id;
    var index = id.split("_")[1];
    var checkboxValue = getCheckVal(id);
    var disableValue = (checkboxValue ==1)?0:1;
    setDisable("IPv4BindLanList_"+index,disableValue);
    if (checkboxValue ==0){
        setCheck("IPv4BindLanList_"+index,checkboxValue);
    }
}
function ChangeLanWanBind(obj)
{
    var id = obj.id;
    var index = id.split("_")[1];
    var checkboxValue = getCheckVal(id);
    if (checkboxValue ==0){
        setDisable("DhcpLan_"+index,0);
    }
}
function WriteNextStepValue(){
    var internet = GetFirstPPPoEWanByType("INTERNET");
    if (internet == ""){
        return;
    }
    var lanportvalue = GetAllCheckboxValue("LanWorkPortname");
    var bindlanlist = GetAllCheckboxValue("IPv4BindLanListname");
    var bindssidlist = GetAllCheckboxValue("IPv4BindSSIDListname");
    var lanportlen = lanportvalue.length;
    var bindlanlen = bindlanlist.length;
    var bindssidlen = bindssidlist.length;
    var htmline = "";
    if (lanportlen){
        document.getElementById('cf_LanPort').innerHTML = lanportvalue.join(" ");
    }
    else{
        document.getElementById('cf_LanPort').innerHTML = "";
    }
    $("#cf_Bindoption").empty();
    if ((bindlanlen > 0) && (bindssidlen > 0)){
        htmline = '<span>'+bindlanlist.join(" ") +'</span><br><span>'+bindssidlist.join(" ") +'</span>';
    }
    else if((bindlanlen > 0) && (bindssidlen == 0)){
        htmline = '<span>'+bindlanlist.join(" ") +'</span>';   
    }
    else if ((bindlanlen == 0) && (bindssidlen > 0)){
        htmline = '<span>'+bindssidlist.join(" ") +'</span>';
    }
    else{
        htmline = '<span></span>';      
    }
    $("#cf_Bindoption").append(htmline);        
}
function SubmitLanWorkPort(){
    if (PPPwanInfo == ""){
        return;
    }
    if (viettelflag == 0){
        return;
    }
    var lanportvalue = GetAllCheckboxValue("LanWorkPortname");
    var bindlanlist = GetAllCheckboxValue("IPv4BindLanListname");
    var bindssidlist = GetAllCheckboxValue("IPv4BindSSIDListname");
    var lanportlen = lanportvalue.length;
    var bindlanlen = bindlanlist.length;
    var bindssidlen = bindssidlist.length;
    var BindListurl = "";
    var SubmitParaForm = "";
    for (var j=0; j<PPPwanInfo.length; j++)
    {
        BindListurl += '&x='+PPPwanInfo[j].domain;
    }     
    var SubmitParaFor = "";
    var domain ="";
    for (var j = 1; j <= TopoInfo.EthNum && Lay3Enables[j-1] != null; j++)
    {
        domain +=  '&LAN'+j+'='+ Lay3Enables[j-1].domain;
        SubmitParaForm += 'LAN'+j+'.X_HW_L3Enable='  + getCheckVal('DhcpLan_'+j+'') + '&';
    }
    domain = domain.substr(1,domain.length-1);
    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : SubmitParaForm + "x.X_HW_Token=" + getValue('onttoken'),
         url : 'set.cgi?' + domain + '&RequestFile=html/ssmp/cfgguide/setup.asp',
     success : function(data) {
        var arr = bindlanlist.concat(bindssidlist); 
        $.ajax({
             type : "POST",
             async : false,
             cache : false,
             data : "x.X_HW_BindPhyPortInfo="+arr.join(",") + "&x.X_HW_Token=" + getValue('onttoken'),
             url : "complex.cgi?" + BindListurl + '&RequestFile=html/ssmp/cfgguide/setup.asp',
         success : function(data) {
         }});
     }});
}
function IsBindLAN(obj){
    for (var i=0; i < obj.length -1;i++)
    {
        if (obj[i].lan1enable == "1"){
            setDisable("DhcpLan_1",1);
        }
        if (obj[i].lan2enable == "1"){
            setDisable("DhcpLan_2",1);
        }
        if (obj[i].lan3enable == "1"){
            setDisable("DhcpLan_3",1);
        }
        if (obj[i].lan4enable == "1"){
            setDisable("DhcpLan_4",1);
        }
    }
}
function LanWanBindInfo(){
    if (PPPwanInfo == ""){
        return;
    }
    var LanWanBindInfo = Instance_PolicyRoute.GetLanWanBindInfo(domainTowanname(PPPwanInfo[0].domain));
    if (LanWanBindInfo != null && LanWanBindInfo != undefined)
    {
        PPPwanInfo[0].IPv4BindLanList = LanWanBindInfo.PhyPortName.split(",");
    }   
}
function IsL3Mode(LanId)
{
    if (parseInt(LanId) >= Lay3Enables.length){
        return "null";
    }
    return Lay3Enables[parseInt(LanId)-1].lay3enable;
}
function InitLanPort(){  
    if (PPPwanInfo == ""){
        return;
    }
    LanWanBindInfo();
    var BindPortInfo = PPPwanInfo[0].IPv4BindLanList;
    if (BindPortInfo !=""){
        for (var i=0; i < BindPortInfo.length ;i++){
            if (BindPortInfo[i].toUpperCase().match("LAN")){
                var index = BindPortInfo[i].substr(3,1);
                setCheck("IPv4BindLanList_"+index,1);
            }
            if (BindPortInfo[i].toUpperCase().match("SSID")){
                var index = BindPortInfo[i].substr(4,1);
                setCheck("IPv4BindSSIDList"+index,1)               
            }
        }
    }
    for (var i = 1; i <= parseInt(TopoInfo.EthNum); i++)
    {
        if (IsL3Mode(i) != "1")
        {
            setDisable("IPv4BindLanList_"+i, 1);
        }
    }
    for (var i = 0; i < WlanList.length; i++)
    {
        var tid = parseInt(i+1);
        if (WlanList[i].bindenable == "0")
        {
            setDisable("IPv4BindSSIDList"+tid, 1);
        }
    }
    setCheck("DhcpLan_1",Layer3Info.LAN1);
    setCheck("DhcpLan_2",Layer3Info.LAN2);
    setCheck("DhcpLan_3",Layer3Info.LAN3);
    setCheck("DhcpLan_4",Layer3Info.LAN4);
    IsBindLAN(wanppplanbind);
    IsBindLAN(waniplanbind);
}
function SubmitWanMenu(Form)
{
	var i=0;

	for (i=0; i<PPPwanInfo.length; i++)
	{
		Form.addParameter('y'+i+'.Username', getValue('username'+i));
		
		if(PPPwanInfo[i].Password != getValue('password'+i) )
		{
			Form.addParameter('y'+i+'.Password', getValue('password'+i));
		}
	}
}

function Reboot()
{
	if(ConfirmEx(GetLanguageDesc("s0601"))) 
	{
		setDisable('btnReboot',1);
		
		var Form = new webSubmitForm();
				
		Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
								+ '&RequestFile=html/ssmp/reset/reset.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));						
		Form.submit();
	}
}

function stModifyUserInfo(domain,UserName,UserLevel,Enable)
{
    this.domain = domain;
 	this.UserName = UserName;
    this.UserLevel = UserLevel;
    this.Enable = Enable;
}

var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName|UserLevel|Enable, stModifyUserInfo);%>;  

for (var i = 0; i < stModifyUserInfos.length - 1; i++)
{
	if (stModifyUserInfos[i].UserLevel == 0)
	{
		sptAdminName = stModifyUserInfos[i].UserName;
	}
	
	if (stModifyUserInfos[i].Enable == 1) 	
	{
		if (0 == UserNum) 
		{
			if (stModifyUserInfos[i].UserLevel == 0)
			{
				ShowOldPwd = 1;
			}
			
			sptUserName = stModifyUserInfos[i].UserName;
		}
		
		CurUserInst[UserNum] = i;
		UserNum++;
	}
}

if (1 < UserNum)
{
	MultiUser = 1;
}

function setWebUserOption()
{
	var j = 0;
    if (stModifyUserInfos != 'null')
	{
		for (i = 0; i < stModifyUserInfos.length - 1; i++)
		{
			if (stModifyUserInfos[i].Enable == 1) 
			{
				document.write('<option value=' + (j+1) + '>' + htmlencode(stModifyUserInfos[i].UserName) + '</option>');
				CurUserBuf[j] = htmlencode(stModifyUserInfos[i].UserName); 
				j++;
			}	
		}
		return true;
	}
	else
	{
	    return false;
	}
}

function CheckPwdIsComplex(str)
{
	var i = 0;
    if (str.length < PwdMinLen)
	{
		return false;
	}
	
	if (!CompareString(str, sptUserName) )
	{
		return false;
	}
	
	if ( isLowercaseInString(str) )
	{
		i++;
	}
	
	if ( isUppercaseInString(str) )
	{
		i++;
	}
	
	if ( isDigitInString(str) )
	{
		i++;
	}
	
	if ( isSpecialCharacterNoSpace(str) )
	{
		i++;
	}
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function ShowOldArea(pwdlevel)
{
	if (pwdlevel == 0)
	{	
		return;
	}
	
	sptUserName = CurUserBuf[pwdlevel - 1];
	if (sptAdminName == sptUserName)
	{
		ShowOldPwd = 1;
		document.getElementById('TroldPassword').style.display  = ""; 
	}
	else
	{
		ShowOldPwd = 0;
		document.getElementById('TroldPassword').style.display  = "none"; 
	}
	CancelValue();
}

function CheckParaWeak()
{
	var newPassword = document.getElementById("newPassword").value;
	if (newPassword.length > 32)
	{
		AlertEx("The password must contain at most 32 characters.");
		return false;
	}
	
	if (newPassword.length < PwdMinLen)
	{
		AlertEx("The password must contain at least 6 characters.");
		return false;
	}
		
	if (newPassword.charAt(0) == " " || newPassword.charAt(newPassword.length-1) == " ")
	{
		AlertEx("The password must not include the space character at the beginning of the key or at the end.");
		return false;
	}
	
	for(var i = 0; i <= newPassword.length-2; i++)
	{
		if(newPassword.charAt(i) == " " && newPassword.charAt(i+1) == " ")
		{
		   AlertEx("The password can not have several consecutive spaces.");
 	       return false;		
		}
	}
	return true;
}

function CheckPwdIsComplexForViettel8045A2(str)
{
    if ( 8 >= str.length )
    {
        return false;
    }
    if ( !isLowercaseInString(str) )
    {
       return false;
    }
    if ( !isUppercaseInString(str) )
    {
        return false;
    }
    if ( !isDigitInString(str) )
    {
        return false;
    }
	
	if ( !isSpecialCharacterNoSpace(str) )
    {
         return false;
    }
	return true
}

function CheckPasswd()
{
    var newPassword = document.getElementById("newPassword");
    var cfmPassword = document.getElementById("cfmPassword");
	var oldPassword = document.getElementById("oldPassword");

	if(oldPassword.value == '' && newPassword.value == '' && cfmPassword.value == '')
	{
		document.getElementById('ispwdChange').innerHTML = "No";
		return true;
	}
	
	if (1 == ShowOldPwd)
	{	
		if (oldPassword.value == "")
		{	
			AlertEx(GetLanguageDesc("s0f0f")); 
			return false;
		}
	}
	
	var NormalPwdInfo = FormatUrlEncode(oldPassword.value);
    var CheckResult = 0;

	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : "../common/CheckAdminPwd.asp?&1=1",
	data :'NormalPwdInfo='+NormalPwdInfo, 
	success : function(data) {
		CheckResult=data;
		}
	});

	if (CheckResult != 1)
	{
		AlertEx(GetLanguageDesc("s0f11"));
		return false;
	}
	
	if (newPassword.value == "")
	{
		AlertEx(GetLanguageDesc("s0f02"));
		return false;
	}
	
	if(PwdType == 3)
	{
		var WeakRst = CheckParaWeak();
		if(WeakRst == false)
		{
			return false;
		}
	}
	
	if (newPassword.value.length > 127)
	{
		AlertEx(GetLanguageDesc("s1904"));
		return false;
	}

	if (isValidAscii(newPassword.value) != '')
	{
		if(PwdType == 3)
		{
			AlertEx(GetLanguageDesc("s0f04a"));
            document.getElementById('ispwdChange').innerHTML = "Yes";
			return true;
		}
		else
		{
			AlertEx(GetLanguageDesc("s0f04"));
			return false;
		}
	}

	if (cfmPassword.value != newPassword.value)
	{
		AlertEx(GetLanguageDesc("s0f06"));
		return false;
	}
	
	if (IsViettel8045A2Flag==1)
	{
		if (!CheckPwdIsComplexForViettel8045A2(newPassword.value))
		{
			var confirmVal = confirm("Weak password! Do you want to continue? \n(strong password must be more than 8 characters,using combination of uppercase and lower case and number and special characters)");
			if(confirmVal)
			{
				document.getElementById('ispwdChange').innerHTML = "Yes";
				return true;
			}
			else
			{
				return false;
			}			
		}
	}
	
	if(!CheckPwdIsComplex(newPassword.value)&&(IsViettel8045A2Flag!=1))
	{
		if(PwdType == 3)
		{
			var confirmVal = confirm(GetLanguageDesc("s1902a"));
			if(confirmVal){
				document.getElementById('ispwdChange').innerHTML = "Yes";
				return true;
			}
			else{
				return false;
			}			
		
		}
		else
		{
			AlertEx(GetLanguageDesc("s1902"));	
			return false;
			
		}
		
	}
	document.getElementById('ispwdChange').innerHTML = "Yes";
	return true;
}

function SubmitPwd(Form)
{
	var InstNo = 1;
	
	if (1 == MultiUser)	
	{
		InstNo = getValue('WebUserList');
	}
	
	InstNo = CurUserInst[InstNo - 1];
	if (1 == ShowOldPwd)			
	{
	    Form.addParameter('x.OldPassword', getValue('oldPassword'));	
	}	
    Form.addParameter('x.Password', getValue('newPassword'));	
	
    url +="&x="  + stModifyUserInfos[InstNo].domain;
}

function setTransmitPowerSug()
{
	var spanTransmitPower = getElementById('TransmitPowerspan');
	if (getSelectVal('TransmitPower') != 100 && ("PCCW3MAC" != CfgMode.toUpperCase()) )
	{
		spanTransmitPower.innerHTML = cfg_wlancfgadvance_language['amp_advance_transmit_power_sug'];
		spanTransmitPower.style.color = '#ff0000';
	}
	else 
	{
		spanTransmitPower.innerHTML = '';
	}
    
    var spanTransmitPower5 = getElementById('TransmitPowerspan5');
	if (getSelectVal('TransmitPower5') != 100 && ("PCCW3MAC" != CfgMode.toUpperCase()) )
	{
		spanTransmitPower5.innerHTML = cfg_wlancfgadvance_language['amp_advance_transmit_power_sug'];
		spanTransmitPower5.style.color = '#ff0000';
	}
	else 
	{
		spanTransmitPower5.innerHTML = '';
	}
}
function stWlan(domain,name,ssid,TransmitPower, BeaconType)
{
    this.domain = domain;
	this.name = name;
    this.ssid = ssid;
	this.TransmitPower = TransmitPower;
	this.BeaconType = BeaconType;
}

function stPsk(domain,psk)
{
    this.domain = domain;
    this.psk = psk;
}

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|SSID|TransmitPower|BeaconType, stWlan);%>;
var WlanWifiOne = WlanArr[0];
var PskArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey, stPsk);%>;
var wlan5gSSID = "";
var wlan5gpassword = "";
var wlan5gpower = 100;
var wlan5gauth  = '11i';

for (i = 0; i < WlanArr.length - 1; i++)
{
	if (getWlanInstFromDomain(WlanArr[i].domain) == "5") {
		wlan5gSSID = WlanArr[i].ssid;
		wlan5gpassword = PskArr[i].psk;
        wlan5gpower = WlanArr[i].TransmitPower;
		wlan5gauth = WlanArr[i].BeaconType;
	}
}

function CheckPsk(value)
{
	if (value == '')
	{
		AlertEx("The Wi-Fi Password cannot be empty.");
		return false;
	}

	if (isValidWPAPskKey(value) == false)
	{
		AlertEx("The Wi-Fi Password must be between 8 and 63 ASCII characters or 64 hexadecimal characters.");
		return false;
	}

	return true;
}

function wlanAddAuthMode(AuthMode,p,Form)
{
	if (AuthMode == 'WPA PreSharedKey') {
		Form.addParameter(p + '.BeaconType','WPA');
		Form.addParameter(p + '.WPAAuthenticationMode','PSKAuthentication');
		Form.addParameter(p + '.WPAEncryptionModes','TKIPEncryption');
	} else if (AuthMode == 'WPA2 PreSharedKey') {
		Form.addParameter(p + '.BeaconType','11i');
		Form.addParameter(p + '.IEEE11iAuthenticationMode','PSKAuthentication');
		Form.addParameter(p + '.IEEE11iEncryptionModes','AESEncryption');
	} else if (AuthMode == 'WPA/WPA2 PreSharedKey') {
		Form.addParameter(p + '.BeaconType','WPAand11i');
		Form.addParameter(p + '.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
		Form.addParameter(p + '.X_HW_WPAand11iEncryptionModes','TKIPandAESEncryption');
	} else if (AuthMode == 'Open') {
		Form.addParameter(p + '.BeaconType','Basic');
		Form.addParameter(p + '.BasicAuthenticationMode','None');
	}
}

function WlanAddFormPara(Form)
{
    Form.addParameter('p.SSID', ltrim(getValue('Wizard_text02_text')));
	Form.addParameter('p.TransmitPower', getSelectVal('TransmitPower')); 
	Form.addParameter('q.PreSharedKey', getValue('Wizard_password02_password'));
	
	var AuthMode =  getSelectVal('wlAuthMode');
	var AuthMode5G =  getSelectVal('5GwlAuthMode');
	
	wlanAddAuthMode(AuthMode, 'p', Form);
	
	if(1 == DoubleFreqFlag)
	{
		if(getCheckVal("splitSSIDinput")=="0")
		{
			Form.addParameter('r.SSID', ltrim(getValue('Wizard_text05_text')));		 
			Form.addParameter('s.PreSharedKey', getValue('Wizard_password05_password'));
            Form.addParameter('r.TransmitPower', getSelectVal('TransmitPower5'));
			wlanAddAuthMode(AuthMode5G, 'r', Form);

		}
		else
		{
			Form.addParameter('r.SSID', ltrim(getValue('Wizard_text02_text')));		 
			Form.addParameter('s.PreSharedKey', getValue('Wizard_password02_password'));
            Form.addParameter('r.TransmitPower', getSelectVal('TransmitPower'));
			Form.addParameter('t.BandSteeringPolicy', 1);
			
			wlanAddAuthMode(AuthMode, 'r', Form);

		}	
	}
}

function CheckSsidExist(ssid, WlanArr, freq) {
    for (var i = 0; i < WlanArr.length - 1; i++) {
        if ((getWlanPortNumber(WlanArr[i].name) > ssidEnd2G) && ((DoubleFreqFlag == 1) && (freq == '2G'))) {
            continue;
        }
        
        if ((getWlanPortNumber(WlanArr[i].name) <= ssidEnd2G) && ((DoubleFreqFlag == 1) && (freq == '5G'))) {
            continue;
        }
        
        if ((getWlanPortNumber(WlanArr[i].name) > ssidEnd2G) && ((DoubleFreqFlag != 1))) {
            continue;
        }

        if ((getWlanPortNumber(WlanArr[i].name) == ssidStart2G) || (getWlanPortNumber(WlanArr[i].name) == ssidStart5G)) {
            continue;
        }

        if (WlanArr[i].ssid == ssid) {
            AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
            return false;
        } else {
            continue;
        }
    }

    return true;
}

function WlanNext() {
    var ssid = ltrim(getValue('Wizard_text02_text'));
    var psk  = getValue('Wizard_password02_password');
    var ssid5g = ltrim(getValue('Wizard_text05_text'));
    var psk5g  = getValue('Wizard_password05_password');

    if (CheckSsid(ssid) == false) {
        return false;
    }
    
    if (CheckPsk(psk) == false) {
        return false;
    }

    if (DoubleFreqFlag == 1) {
        if (CheckSsidExist(ssid, WlanArr, '2G') == false) {
            return false;
        }

        if (CheckSsidExist(ssid5g, WlanArr, '5G') == false) {
            return false;
        }

        if (getCheckVal("splitSSIDinput") != 1) {
            if (CheckSsid(ssid5g) == false) {
                return false;
            }
            
            if (CheckPsk(psk5g) == false) {
                return false;
            }
        }
    } else {
        if (CheckSsidExist(ssid, WlanArr, '2G') == false) {
            return false;
        }
    }
    
    return true;
}

function CancelValue()
{
    setText('newPassword','');
    setText('cfmPassword','');
	setText('oldPassword','');
}

function HideAll()
{
	setDisplay('id_confirm', 0);
	setDisplay('id_config', 0);
}

function InitAuthMode()
{
	var authdb;
	var authdb5g;
	
	if (WlanArr[0].BeaconType == 'Basic') {
		authdb = 'Open';
	} else if (WlanArr[0].BeaconType == 'WPA') {
		authdb = 'WPA PreSharedKey';
	} else if ((WlanArr[0].BeaconType == '11i') || (WlanArr[0].BeaconType == 'WPA2')) {
		authdb = 'WPA2 PreSharedKey';
	} else if ((WlanArr[0].BeaconType == 'WPAand11i') || (WlanArr[0].BeaconType == 'WPA/WPA2')) {
		authdb = 'WPA/WPA2 PreSharedKey';
	}
	
	setSelect('wlAuthMode', authdb);
	
	if (wlan5gauth == 'Basic') {
		authdb5g = 'Open';
	} else if (wlan5gauth == 'WPA') {
		authdb5g = 'WPA PreSharedKey';
	} else if ((wlan5gauth == '11i') || (wlan5gauth == 'WPA2')) {
		authdb5g = 'WPA2 PreSharedKey';
	} else if ((wlan5gauth == 'WPAand11i') || (wlan5gauth == 'WPA/WPA2')) {
		authdb5g = 'WPA/WPA2 PreSharedKey';
	}
		
	setSelect('5GwlAuthMode', authdb5g);
}

function LoadFrame()
{

	HideAll();
	setDisplay('id_config', 1);

    if(IsWlanAvailable())
	{
		setDisplay('wizard2',1);
        setText('Wizard_text02_text', WlanArr[0].ssid);
        setText('Wizard_password02_password', PskArr[0].psk);
		setText('Wizard_text05_text', wlan5gSSID);
        setText('Wizard_password05_password', wlan5gpassword);
        setSelect('TransmitPower', WlanWifiOne.TransmitPower);
        setSelect('TransmitPower5', wlan5gpower);
        InitAuthMode();

	    setTransmitPowerSug();
	}

	SetDhcpData();
    if (viettelflag ==1){
    InitLanPort();
    }
	
	if(1 == DoubleFreqFlag)
	{
		setDisplay("splitSSID",1);
		setCheck('splitSSIDinput', DualBandEnable);
		splitInputCheck();
	}
}

function splitInputCheck()
{
	if(getCheckVal("splitSSIDinput")=="1")
	{
		setDisplay("5GSSIDname",0);
		setDisplay("5GAuthentication",0);
		setDisplay("5GSSIDpassword",0);
        setDisplay("5GTransmitPower", 0);
	}
	else
	{
		setDisplay("5GSSIDname",1);
		setDisplay("5GAuthentication",1);
		setDisplay("5GSSIDpassword",1);
        setDisplay("5GTransmitPower", 1);
	}
}

function CheckFormStep()
{
	if (IsWlanAvailable())
	{
		if(!WlanNext())
		{
			return false;
		}
	}

	if ((!CheckPasswd()) || (!CheckInput()))
	{
		return false;
	}

	return true;
}

function OnNextStep()
{
    WriteNewWan();
	if(false == CheckFormStep())
	{
		return false;
	}

	HideAll();
    WriteNextStepValue();    
	setDisplay('id_confirm',1);

    if (true == IsWlanAvailable())
	{
		setDisplay('wlaninfo', 1);
		$('#wlan_ssid').text(getValue('Wizard_text02_text'));
		document.getElementById('wlan_auth').innerHTML= getSelectVal('wlAuthMode');
        document.getElementById('wlan_psk').innerHTML= GetSSIDStringContent(getValue('Wizard_password02_password'),64);
		document.getElementById('wlan_txPower').innerHTML= getSelectVal('TransmitPower');
		if(1 == DoubleFreqFlag)
		{
			if(getCheckVal("splitSSIDinput")=="0")
			{
				setDisplay("wlaninfo5Gssid",1);
				setDisplay("wlaninfo5Gauth",1);
				setDisplay("wlaninfo5Gpsk",1);
                setDisplay("wlaninfo5Gpower", 1);
				$('#wlan_ssid_5g').text(getValue('Wizard_text05_text'));
				document.getElementById('wlan_auth_5g').innerHTML= getSelectVal('5GwlAuthMode');
				document.getElementById('wlan_psk_5g').innerHTML= GetSSIDStringContent(getValue('Wizard_password05_password'),64);
                document.getElementById('wlan_txPower_5g').innerHTML= getSelectVal('TransmitPower5');
			}
			else
			{
				setDisplay("wlaninfo5Gssid",0);
				setDisplay("wlaninfo5Gauth",0);
				setDisplay("wlaninfo5Gpsk",0);
                setDisplay("wlaninfo5Gpower", 0);
			}
		}
    }
	
}

function OnBackStep()
{
	HideAll();
    setDisplay('id_config',1);
}

function OnfinishStep()
{	
    setDisable('BackStep', 1);
    setDisable('FinishStep', 1);
	SubmitNewWan(); 
	SubmitLanWorkPort();   
    var Form = new webSubmitForm();
	SubmitWanMenu(Form);
		

    url = 'set.cgi?';

    if ((true == IsWlanAvailable()) && (null != WlanArr))
	{
		WlanAddFormPara(Form);
		if(1 == DoubleFreqFlag)
		{
			Form.addParameter('u.DualBandUnified', getCheckVal("splitSSIDinput"));
			if(getCheckVal("splitSSIDinput")=="0")
			{
				url += '&p=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1' + '&q=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1'
				+ '&r=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5' 
				+ '&s=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.PreSharedKey.1';
			}
			else
			{
				url += '&p=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1' + '&q=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1'
				+ '&r=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5' 
				+ '&s=InternetGatewayDevice.LANDevice.1.WLANConfiguration.5.PreSharedKey.1'
				+ '&t=InternetGatewayDevice.LANDevice.1.WiFi.X_HW_GlobalConfig';
			}	
			
			url += '&u=InternetGatewayDevice.X_HW_WIFIInfo.X_HW_WLANForOnlySaveCfg';		
		}
		else
		{
			url += '&p=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1' + '&q=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1';
		}
	}

	if("Yes" == document.getElementById('ispwdChange').innerHTML)
	{
		SubmitPwd(Form);
	}
	
	for (var j=0; j<PPPwanInfo.length; j++)
	{
		url += '&y'+j+'='+PPPwanInfo[j].domain;
	}
	
	if (getCheckVal("dhcpSrvEnable")==0)
	{
		Form.addParameter('n.DHCPEnable', 0);
		Form.addParameter('z.DHCPServerEnable',getCheckVal("dhcpSrvEnable"));
		url += '&n=InternetGatewayDevice.X_HW_DHCPSLVSERVER&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement';
	}
	else 
	{
		Form.addParameter('z.DHCPServerEnable',getCheckVal("dhcpSrvEnable"));
		url += '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement';
	}
	
	
    url += '&RequestFile=html/ssmp/cfgguide/setup.asp';
	Form.setAction(url);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function confirmresult()
{
	if( ( window.location.href.indexOf("set.cgi?") > 0) )
	{
		AlertEx(GetLanguageDesc("s030e"));
	}
	clearInterval(TimerHandle);	    
}

var TimerHandle = setInterval("confirmresult()", 50);
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<br>
<div id="id_config">

<script language="JavaScript" type="text/javascript">
    DrawNewWan();
	DrawWanMenu("config");
    if (viettelflag == 1){
    WriteLanPort();
    WriteBindOption();
    ControlLanWanBind();
    }
</script> 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
<tr class="head_title"> 
    <td class='align_left' colspan="2">Lan configuration</td> 
</tr> 
<tr> 
<script language="JavaScript" type="text/javascript">
	document.write('<td class="table_title width_per25">' +Languages['EnableLanDhcp'] +'</td>');		
</script> 	
	<td  class="table_right width_per75"> <input type='checkbox' value=0 id='dhcpSrvEnable' name='dhcpSrvEnable'> </td> 
</tr> 
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1"  class="tabal_bg">  
<tr  class="head_title">
<td  style="display:none" id = "LanId1" width="25%">LAN1</td> 
<td style="display:none"  id = "LanId2" width="25%">LAN2</td> 
<td style="display:none"  id = "LanId3" width="25%">LAN3</td> 
<td  style="display:none" id = "LanId4" width="25%">LAN4</td> 
 </tr>
<tr  class="head_title">
<td id="headerLogoImg1" style="background: url(../../../images/rj45.jpg) no-repeat center; height: 50px; width: 20px; display:none; background-color:rgb(230, 230, 230)"></td>
<td id="headerLogoImg2" style="background: url(../../../images/rj45.jpg) no-repeat center; height: 50px; width: 20px; display:none; background-color:rgb(230, 230, 230);"></td>
<td id="headerLogoImg3" style="background: url(../../../images/rj45.jpg) no-repeat center; height: 50px; width: 20px; display:none; background-color:rgb(230, 230, 230)"></td>
<td id="headerLogoImg4" style="background: url(../../../images/rj45.jpg) no-repeat center; height: 50px; width: 20px; display:none; background-color:rgb(230, 230, 230)"></td>
</tr> 
<script>
      var EthNum = TopoInfo.EthNum;
      var i;
      for (i = 1; i <= EthNum; i++)
      {
            setDisplay("LanId"+i, 1);
			setDisplay("headerLogoImg"+i, 1);
      }
</script>
<tr  class="table_title">

<script>
InitPortServiceInfo();

</script>
 </tr>
 
 

</table>

<div id="wizard2" style="display:none">
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_bg">
    <tr class="head_title">
        <td class='align_left' colspan="2">Wireless setting</td>
    </tr>
	<tr id="splitSSID" style="display:none;">
		<td class="table_title" width="25%" id="TransmitPowerColleft">Dual-band unified : </td>
		<td class="table_right" id="TransmitPowerCol" width="75%">
			<input type="checkbox" id="splitSSIDinput" name="splitSSIDinput" onClick="splitInputCheck();">
			<span class="gray">(When checked, 2.4 GHz and 5 GHz use the same SSID configuration.)</span>
		</td>
	</tr>
	<tr>
		<td class="table_title" id="2GSSIDname"  width="25%">SSID name</td>
		<td class="table_right" width="75%">
		<input type="text" name="Wizard_text02_text" id="Wizard_text02_text" size="15" maxlength="32">
			<span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></span>
		</td>
	</tr>
	<tr>
		<td class="table_title" width="25%">Authentication Mode</td>
		<td class="table_right" width="75%" id="TdAuth">
			<select id='wlAuthMode' name='wlAuthMode' size="1" class="width_180px">
				<script language="JavaScript" type="text/javascript">
					document.write("<option value='Open'>"+cfg_wlancfgdetail_language['amp_auth_open']+"</option>");
					document.write("<option value='WPA PreSharedKey'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
					document.write("<option value='WPA2 PreSharedKey' selected>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
					document.write("<option value='WPA/WPA2 PreSharedKey'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
					
				</script>
			</select><span class="gray"> </span>
		</td>
	</tr>
	<tr>
		<td class="table_title" id="2GSSIDpassword"  width="25%">Password</td>
		<td class="table_right" width="75%">
		<input type='password' autocomplete='off' id='Wizard_password02_password' name='Wizard_password02_password' size="15" maxlength='64'>
			<span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_easy_setup']);</script></span>
        </td>
    </tr>
    	<tr>
		<td class="table_title" width="25%" id="TransmitPowerColleft">WIFI Power:</td>
		<td class="table_right" id="TransmitPowerCol" width="75%">
			<select id="TransmitPower" class="StyleSelect" realtype="DropDownList" bindfield="y.TransmitPower" onchange="setTransmitPowerSug(this);">
				<option value="100">100%</option>
				<option value="80">80%</option>
				<option value="60">60%</option>
				<option value="40">40%</option>
				<option value="20">20%</option>
			</select><font color="red" id="TransmitPowerRequire"></font>
		<span class="gray" id="TransmitPowerspan"></span>
		</td>
	</tr>
	<tr id="5GSSIDname" style="display:none;">
		<td class="table_title"  width="25%">5G SSID name</td>
		<td class="table_right" width="75%">
		<input type="text" name="Wizard_text05_text" id="Wizard_text05_text" size="15" maxlength="32">
			<span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_linkname_note']);</script></span>
		</td>
	</tr>
	<tr id="5GAuthentication" style="display:none;">
		<td class="table_title" width="25%">5G Authentication Mode</td>
		<td class="table_right" width="75%" id="5GTdAuth">
			<select id='5GwlAuthMode' name='5GwlAuthMode' size="1" class="width_180px">
				<script language="JavaScript" type="text/javascript">
					document.write("<option value='Open'>"+cfg_wlancfgdetail_language['amp_auth_open']+"</option>");
					document.write("<option value='WPA PreSharedKey'>"+cfg_wlancfgdetail_language['amp_auth_wpapsk']+"</option>");
					document.write("<option value='WPA2 PreSharedKey' selected>"+cfg_wlancfgdetail_language['amp_auth_wpa2psk']+"</option>");
					document.write("<option value='WPA/WPA2 PreSharedKey'>"+cfg_wlancfgdetail_language['amp_auth_wpawpa2psk']+"</option>");
					
				</script>
			</select><span class="gray"> </span>
		</td>
	</tr>
	<tr id="5GSSIDpassword" style="display:none;">
		<td class="table_title"  width="25%">5G Password</td>
		<td class="table_right" width="75%">
		<input type='password' autocomplete='off' id='Wizard_password05_password' name='Wizard_password05_password' size="15" maxlength='64'>
			<span class="gray"><script>document.write(cfg_wlancfgdetail_language['amp_easy_setup']);</script></span>
        </td>
    </tr>
	<tr id="5GTransmitPower" style="display:none;">
		<td class="table_title" width="25%" id="TransmitPowerColleft5">5G WIFI Power:</td>
		<td class="table_right" id="TransmitPowerCol5" width="75%">
        
			<select id="TransmitPower5" class="StyleSelect" realtype="DropDownList" bindfield="" onchange="setTransmitPowerSug(this);">
				<option value="100">100%</option>
				<option value="80">80%</option>
				<option value="60">60%</option>
				<option value="40">40%</option>
				<option value="20">20%</option>
			</select><font color="red" id="TransmitPowerRequire5"></font>
		<span class="gray" id="TransmitPowerspan5"></span>
		</td>
	</tr>
</table>
</div>

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_bg">
<tr class="head_title"> 
<td class='align_left' colspan="3">Modify administrator password</td>
</tr>
<tr>
  <td class="table_title width_per25" BindText="s0f08"></td>
   	<script language="JavaScript" type="text/javascript">
	if (1 == MultiUser)	
	{
		document.write('<td class="table_right">'); 
		document.write('<select id="WebUserList" name="WebUserList" onchange="ShowOldArea(this.value)">'); 
		setWebUserOption();
		document.write('</select>'); 
		document.write('</td>');
	}
	else
	{
		document.write('<td class="table_right">');
		document.write(htmlencode(sptUserName));
		document.write('</td>');
	}

    if (PwdType == 3)
    {
        var innerhtml = '<td class="tabal_pwd_notice" rowspan="4" id="PwdNotice" BindText="s1116f"></td>';
    }
    else
    {
        var innerhtml = '<td class="tabal_pwd_notice" rowspan="4" id="PwdNotice" BindText="s1116b"></td>';
    }
    
    document.write(innerhtml);
    </script> 
</tr>

<tr name="TroldPassword" id="TroldPassword" style="display:none"> 
  <td class="table_title width_per25" BindText="s0f13"></td>
  <td class="table_right"><input name='oldPassword' type="password" autocomplete="off" id="oldPassword" size="15" autocomplete="off"></td>
    <script language="JavaScript" type="text/javascript">
	if (1 == ShowOldPwd)
	{
		document.getElementById('TroldPassword').style.display  = ""; 
	}	
	</script> 
</tr> 
<tr> 
  <td class="table_title width_per25" BindText="s0f09"></td>
  <td class="table_right"><input name='newPassword' type="password" autocomplete="off" id="newPassword" size="15" autocomplete="off"></td> 
</tr>
<tr> 
  <td class="table_title width_per25" BindText="s0f0b"></td>
  <td class="table_right"><input name='cfmPassword' type='password' id="cfmPassword" size="15" autocomplete="off"></td>
</tr>
  
  
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button" id="wizard1_table2"> 
  <tr><td class="table_submit width_per25" align="right"></td>
	<td class="table_submit">
	<input class="submit" id="config" type="button" onClick="OnNextStep();"  value="Next" style="width:70px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input  class="submit" name="btnReboot" id="btnReboot" type='button' onClick='Reboot()' value="RESET" style="width:70px;">
	</td>
  </tr>         
</table>
</div>
<div class="func_spread"></div>
<div id="id_confirm" style="display:none"> 
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_head">
<tr><td class="align_left" width="100%"><label id="Title_wizard3_lable">Confirm configuration</label></td></tr>
</table>

<script language="JavaScript" type="text/javascript">
ShowNewWan();
DrawWanMenu("confirm");
</script> 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
<tr class="head_title"> 
    <td class='align_left' colspan="2">Lan configuration</td> 
</tr> 
<tr> 
<script language="JavaScript" type="text/javascript">
	document.write('<td class="table_title width_per25" >' +Languages['EnableLanDhcp'] +'</td>');		
</script> 	
	<td  class="table_right width_per75" id='cf_dhcpSrvEnable'></td> 
</tr> 
</table>


<div id="wlaninfo" style="display:none">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr class="head_title">
        <td class='align_left' colspan="2">Wireless setting</td>
    </tr>
	<tr>
	    <td class="table_title" width="25%">SSID name</td>
	    <td class="table_right" width="75%" id="wlan_ssid"></td>
	</tr>
	<tr>
	    <td class="table_title" width="25%">Authentication Mode</td>
	    <td class="table_right" width="75%" id="wlan_auth"></td>
	</tr>
	<tr>
	    <td class="table_title" width="25%">Password</td>
	    <td class="table_right" width="75%" id="wlan_psk"></td>
	</tr>
    <tr>
        <td class="table_title" width="25%">WIFI Power</td>
        <td class="table_right" width="75%" id="wlan_txPower"></td>
    </tr>
	<tr id="wlaninfo5Gssid" style="display:none">
	    <td class="table_title" width="25%">5G SSID name</td>
	    <td class="table_right" width="75%" id="wlan_ssid_5g"></td>
	</tr>
	<tr id="wlaninfo5Gauth" style="display:none">
	    <td class="table_title" width="25%">5G Authentication Mode</td>
	    <td class="table_right" width="75%" id="wlan_auth_5g"></td>
	</tr>
	<tr id="wlaninfo5Gpsk" style="display:none">
	    <td class="table_title" width="25%">5G Password</td>
	    <td class="table_right" width="75%" id="wlan_psk_5g"></td>
	</tr>
	 <tr id="wlaninfo5Gpower" style="display:none">
        <td class="table_title" width="25%">5G WIFI Power</td>
        <td class="table_right" width="75%" id="wlan_txPower_5g"></td>
    </tr>
</table>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
<tr class="head_title"> 
<td class='align_left' colspan="2">Modify administrator password</td> 
</tr> 
	<tr> 
	<td class="table_title" width="25%">Modify administrator password</td>
	<td class="table_right" width="75%" id="ispwdChange"></td>
	</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="table_button">
  <tr> 
    <td class="table_submit" width="25%"></td> 
    <td class="table_submit">
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  <input  class="submit" name="BackStep" id="BackStep" type="button" onClick="OnBackStep();" value="Back" style="width:70px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input  class="submit" name="FinishStep" id="FinishStep" type="button" onClick="OnfinishStep();"  value="Finish" style="width:70px;"> 
	</td> 
  </tr> 
</table> 
</div>
<script>
    ParseBindTextByTagName(CfgguideLgeDes, "div",  1);
    ParseBindTextByTagName(CfgguideLgeDes, "td",  1);
    ParseBindTextByTagName(CfgguideLgeDes, "span",  1);

    ParseBindTextByTagName(CfgguideLgeDes, "input", 2);
    ParseBindTextByTagName(CfgguideLgeDes, "th", 1);
    ParseBindTextByTagName(CfgguideLgeDes, "h3", 1);
</script>

</body>
</html>
