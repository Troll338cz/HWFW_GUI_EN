<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style>
.padstyle {
	*padding-left: 0px;
	*padding-right: 0px;
}
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>User Device Information</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, routeinfo_language, userdevinfo_language);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="JavaScript" type="text/javascript">
var MAX_DEV_TYPE=10;
var MAX_HOST_TYPE=10;
var MAX_IPV6_LEN = 9;
var appName = navigator.appName;
var DHCPLeaseTimes = new Array();
var UserDevices = new Array();
var UserDevicesTemp = new Array();
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsPTVDF2Flag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF2);%>';
var STBPort = '<%HW_WEB_GetSTBPort();%>';
var mngtTY40 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TIANYI_40);%>';
var isSupportIPv6Wan = "<% HW_WEB_GetFeatureSupport(BBSP_FT_IPV6_WANCFG);%>";
var isSupportNPTv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_NPTV6);%>';
var isRealmac = '<%HW_WEB_GetFeatureSupport(BBSP_FT_STA_REALMAC);%>';
'<%HW_WEB_UserDevSendArp();%>';

function SupportNPTv6Address()
{
    if (((mngtTY40 == '1') || (isSupportNPTv6 == '1')) &&(isSupportIPv6Wan == '1')) {
        return true;
    }

    return false;
}

function IsFreInSsidName()
{
	if(1 == IsPTVDFFlag)
	{
		return true;
	}
}

var ipaddress = "";
var macaddress = "";
var porttype = "";
var portid   = "";
var PccwFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PCCW);%>';
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var page;
var firstpage;
var lastpage;
var globuserinfo = "";

function stUserDevInfoPTVDF(HostName, DevType, IpAddr, MacAddr, DevStatus, Port, Time, Leasetion, Domain, RealMacAddr, TrafficRecvRate, TrafficSendRate)
{
    this.HostName = HostName;
    this.DevType = DevType;
    this.IpAddr = IpAddr;
    this.MacAddr = MacAddr;
    this.DevStatus = DevStatus;
    this.Port = Port;
    this.Time = Time;
    this.Leasetion = Leasetion;
    this.Domain = Domain;
    this.RealMacAddr = RealMacAddr;
    this.TrafficRecvRate = TrafficRecvRate;
    this.TrafficSendRate = TrafficSendRate;
}

function GetRemainLeaseTime(ipaddr, macaddr)
{
    for (var i = 0; i < DHCPLeaseTimes.length - 1; i++)
    {
        if ((ipaddr == DHCPLeaseTimes[i].ip) && (macaddr == DHCPLeaseTimes[i].mac))
        {
            return DHCPLeaseTimes[i].remaintime;
        }
    }
    return -1;
}

function ShowTimeDisplay(UserDevicesInfo)
{
    var h = parseInt(UserDevicesInfo[i].Time.split(":")[0],10);
    var m = parseInt(UserDevicesInfo[i].Time.split(":")[1],10);
    var allSec = h*3600 + m*60;
    var unit_day = (parseInt(allSec/86400,10) > 1) ? userdevinfo_language['bbsp_days'] : userdevinfo_language['bbsp_day'];
    var day = parseInt(allSec/86400,10);
    var hour = parseInt((allSec%86400)/3600,10);
    var minitute = parseInt((allSec%3600)/60,10);
    var sec = parseInt(allSec%60,10);
    var timestr = day + unit_day + ','  + hour + ':' + minitute + ':' + sec;
    return timestr;
}

function appendstr(str)
{
    return str;
}

function showlistcontrol(UserDevicesInfo)
{
    var outputlist = "";
    var RecordCount = UserDevicesInfo.length;
    var StartIndex = (page - 1) * GettListNum();
    var EndIndex = page * GettListNum() ;
    if( 0 == RecordCount )
    {
	
    if (isRealmac == 1) {
        outputlist = outputlist + appendstr("<tr class=\"tabal_01 align_center\">");
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr("</tr>");
    } else {
        outputlist = outputlist + appendstr("<tr class=\"tabal_01 align_center\">");
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr('<td >'+'--'+'</td>');
        outputlist = outputlist + appendstr("</tr>");
    }
    $("#devlist").append(outputlist);
    return;
}

	
    for(var i = StartIndex; i < RecordCount && i < EndIndex; i++)   
    {
        if (UserDevicesInfo[i].Port.toUpperCase().indexOf("SSID") >=0)
        {
            var ssidindex = UserDevicesInfo[i].Port;	
            ssidindex = ssidindex.charAt(ssidindex.length-1);
            if (1 == isSsidForIsp(ssidindex) || 1 == IsRDSGatewayUserSsid(ssidindex))
            {
                continue;
            }
        }
		
		if ('' == UserDevicesInfo[i].HostName)
        {
            UserDevicesInfo[i].HostName = '--';
        }

        var hostport = '';
        if( "LAN0" == UserDevicesInfo[i].Port.toUpperCase() || "SSID0" == UserDevicesInfo[i].Port.toUpperCase())
        {
            hostport = "--";
        }
        else
        {
            hostport = UserDevicesInfo[i].Port.toUpperCase();
			if(true == IsFreInSsidName())
			{
				var SL = GetSSIDList();
				var SLFre = GetSSIDFreList();
				for(var j = 0; j < SL.length; j++)
				{
					if(SL[j].name == UserDevicesInfo[i].Port.toUpperCase())
					{
						hostport = SLFre[j].name;
						break;
					}
				}
			}
			
			if(STBPort > 0)
			{
				var LanPort = "LAN" + STBPort;
				if(UserDevicesInfo[i].Port.toUpperCase() == LanPort)
				{
					hostport = userdevinfo_language['bbsp_lanstb'];
				}
			}
        }

        outputlist = outputlist + appendstr("<tr class=\"tabal_01 align_center\" >");
        outputlist = outputlist + '<td class="align_center">' + '<input name="rml" id="record_' + i+'" type="checkbox" value="' + UserDevicesInfo[i].Domain + '" onClick="OnSelectItem(this.value)"; nowrap></td>';
        if(('--' == UserDevicesInfo[i].HostName) && ("1" == GetCfgMode().TELMEX))
        {
            outputlist = outputlist + appendstr('<td class="width_per15" nowrap>'+ htmlencode(UserDevicesInfo[i].MacAddr) +'</td>');
        }
        else
        {
            outputlist = outputlist + appendstr('<td class="width_per15" title="' + htmlencode(UserDevicesInfo[i].HostName) + '" nowrap>'+GetStringContent(htmlencode(UserDevicesInfo[i].HostName), MAX_HOST_TYPE) +'</td>');
        }

        outputlist = outputlist + appendstr('<td class="width_per10" title="' + htmlencode(UserDevicesInfo[i].DevType) + '" nowrap>'+GetStringContent(htmlencode(UserDevicesInfo[i].DevType), MAX_DEV_TYPE) +'</td>');

        if (UserDevicesInfo[i].Domain.indexOf(".IPv6Address") >= 0 ) {
            if (isRealmac == 1) {
                outputlist = outputlist + appendstr('<td class="width_per10" title="' + htmlencode(UserDevicesInfo[i].IpAddr) + '" nowrap>'+GetStringContent(htmlencode(UserDevicesInfo[i].IpAddr), MAX_IPV6_LEN) +'</td>');	
            } else {
                outputlist = outputlist + appendstr('<td class="width_per15" title="' + htmlencode(UserDevicesInfo[i].IpAddr) + '" nowrap>'+GetStringContent(htmlencode(UserDevicesInfo[i].IpAddr), MAX_IPV6_LEN) +'</td>');			
            }
        } else {
            if (isRealmac == 1) {
                outputlist = outputlist + appendstr('<td class="width_per10" nowrap>'+htmlencode(UserDevicesInfo[i].IpAddr)+'</td>');
            } else {
                outputlist = outputlist + appendstr('<td class="width_per15" nowrap>'+htmlencode(UserDevicesInfo[i].IpAddr)+'</td>');
            }
        }

        outputlist = outputlist + appendstr('<td class="width_per15" nowrap>'+htmlencode(UserDevicesInfo[i].MacAddr)+'</td>');
        if (isRealmac == 1) {
            outputlist = outputlist + appendstr('<td class="width_per10" nowrap>'+htmlencode(UserDevicesInfo[i].RealMacAddr)+'</td>');
        } 
        outputlist = outputlist + appendstr('<td class="width_per5" nowrap>'+htmlencode(userdevinfo_language[UserDevicesInfo[i].DevStatus])  +'</td>');		
        outputlist = outputlist + appendstr('<td class="width_per5" nowrap>'+htmlencode(hostport)+'</td>');
		if (curCfgModeWord.toUpperCase() == "GLOBE2")
		{
			for (var j = 0;j < globuserinfo.length-1; j++)
			{
				if (globuserinfo[j].MacAddr == UserDevicesInfo[i].MacAddr)
				{
					UserDevicesInfo[i].Time = globuserinfo[j].Time;
					UserDevicesInfo[i].IpType = globuserinfo[j].IpType;
				}
			}
			var unit_h = (parseInt(UserDevicesInfo[i].Time.split(":")[0],10) > 1) ? userdevinfo_language['bbsp_hours'] : userdevinfo_language['bbsp_hour'];
			var unit_m = (parseInt(UserDevicesInfo[i].Time.split(":")[1],10) > 1) ? userdevinfo_language['bbsp_mins'] : userdevinfo_language['bbsp_min'];
			var time = '';
			if ('ONLINE' != UserDevicesInfo[i].DevStatus.toUpperCase())
			{
				time = '--';
			}
			else
			{
				time = UserDevicesInfo[i].Time.split(":")[0] + unit_h + UserDevicesInfo[i].Time.split(":")[1] + unit_m;
			}		
            if (isRealmac == 1) {
                outputlist = outputlist + appendstr('<td class="width_per10" nowrap>'+htmlencode(time) +'</td>');
            } else {
                outputlist = outputlist + appendstr('<td class="width_per20" nowrap>'+htmlencode(time) +'</td>');
            }
			
			var leasetime = '';
			if ('DHCP' == UserDevicesInfo[i].IpType)
			{
				var remainleasetime = GetRemainLeaseTime(UserDevicesInfo[i].IpAddr, UserDevicesInfo[i].MacAddr);
				if (remainleasetime > 0)
				{
					leasetime = remainleasetime + userdevinfo_language['bbsp_second'];
				}
				else
				{
					leasetime = '--';
				}
			}
			else
			{
				leasetime = '--';
			}				
			outputlist = outputlist + appendstr('<td class="width_per10" nowrap>'+htmlencode(leasetime)  +'</td>');			
		}
		else
		{
	        var unit_d = (parseInt(UserDevicesInfo[i].Time.split("Days")[0],10) > 1) ? userdevinfo_language['bbsp_days'] : userdevinfo_language['bbsp_day'];
	        var time = '';
	        if('ONLINE' != UserDevicesInfo[i].DevStatus.toUpperCase())
	        {
	        	time = '--';
	        }
			else
			{
	        	time = UserDevicesInfo[i].Time.split("Days")[0] + unit_d + UserDevicesInfo[i].Time.split("Days")[1];
			}
	        outputlist = outputlist + appendstr('<td class="width_per20" nowrap>'+time  +'</td>');

	        var leasetime = '';
	        if (UserDevicesInfo[i].Leasetion.indexOf("Days") >= 0 )
	        {
	            unit_d = (parseInt(UserDevicesInfo[i].Leasetion.split("Days")[0],10) > 1) ? userdevinfo_language['bbsp_days'] : userdevinfo_language['bbsp_day'];
	            leasetime = UserDevicesInfo[i].Leasetion.split("Days")[0] + unit_d + UserDevicesInfo[i].Leasetion.split("Days")[1];
	        }
	        else
	        {
	            leasetime = '--';
	        }
	        outputlist = outputlist + appendstr('<td class="width_per10" nowrap>'+leasetime  +'</td>');
		}
    }

    $("#devlist").append(outputlist);
}

function ButtonDisableAll()
{
    setDisable('detail',1);
    setDisable('delete',1);
    setDisable('ipfilter',1);
    setDisable('macfilter',1);
    setDisable('portmapping',1);
    setDisable('reserveip',1);
}

function IsSelectMulBox()
{
    var CheckBoxList = document.getElementsByName('rml');
    var Count = 0;
    
    for (var i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }

        Count++;
    }
    if (Count <= 1)
    {
        return false;
    }
    return true;
}

function getSelectIndex()
{
    var index = -1;
    var StartIndex = (page - 1) * GettListNum();
    var EndIndex = page * GettListNum() ;
    for(var  i = StartIndex; i < UserDevices.length && i < EndIndex ; i++)   
    {
        var CheckBox = document.getElementById('record_'+i);
        if (CheckBox.checked == true)
        {
            index = i;
            return index;
        }
    }
    
    return index;
}

function getSelectValue()
{
    var value = "NULL";
    var StartIndex = (page - 1) * GettListNum();
    var EndIndex = page * GettListNum() ;
    for(var i = StartIndex; i < UserDevices.length && i < EndIndex ; i++)   
    {
        var CheckBox = document.getElementById('record_'+i);
        if (CheckBox.checked == true)
        {
            value = UserDevices[i].Domain; 
            return value;
        }
    }
    
    return value;
}

function setDisableIPv6NoSupport(noSupport)
{
	setDisable('portmapping',noSupport);
}
function setDisableNormalUserNoSupport(IsselectIPv6)
{	
	if(curUserType != sysUserType)
	{
		setDisable('reserveip',IsselectIPv6);
	}
}


function GetIPv6ScopeByDomian(domainvalue)
{
	if(domainvalue.charAt(domainvalue.length - 1) == '.')
	{
		domainvalue = domainvalue.substr(0, domainvalue.length - 1);
	}
	
	var ParameterList = 'Scope&';
	var Url = '/getajax.cgi?x=' + domainvalue + "&RequestFile=nopage" ;
	var IPScopeTmp = HWGetAction(Url, ParameterList, getValue('onttoken'));
    var ipScope = IPScopeTmp.Scope ;
	
	return ipScope ;
}
function OnSelectItem()
{
	var IsNoSupoortIPv6 = false;
	var IsSelectIPv6 = false;
    var StartIndex = (page - 1) * GettListNum();
    var EndIndex = page * GettListNum() ;
    for(var i = StartIndex; i < UserDevices.length && i < EndIndex ; i++)   
    {
        var CheckBox = document.getElementById('record_'+i);
        if (CheckBox.checked == true)
        {
            if(CheckBox.value.indexOf("IPv6Address") >= 0) 
			{	
				IsSelectIPv6 = true;
				if('LLA'== GetIPv6ScopeByDomian(CheckBox.value))
				{
					IsNoSupoortIPv6 = true;
					break;
				}
			}	
        }
    }
	
	setDisableIPv6NoSupport(IsNoSupoortIPv6);
	
	setDisableNormalUserNoSupport(IsSelectIPv6);
}

function GetHpa(MainName)
{
    var menuItems = top.Frame.menuItems;	

    for(var i in menuItems)
    {
        if(MainName == menuItems[i].name)
        {
            return menuItems.length - i;
        }
    }

    return -1;
}

function GetZpa(MainName, SubItemName)
{
    var Hpa = GetHpa(MainName);
    if(Hpa == -1)
    {
        return -1;
    }

    var subItems = top.Frame.menuItems[top.Frame.menuItems.length - Hpa].subMenus;
    for(var i in subItems)
    {
        if(SubItemName == subItems[i].name)
        {
            return i;
        }
    }

    return -1;
}

function IsIPv6UserDev(index)
{
    if(UserDevices[index].Domain.indexOf("IPv6Address") >= 0)
    {
        return true;
    }
    
    return false;
}


function OnDetial()
{
    if (true == IsSelectMulBox())
    {
        AlertEx(userdevinfo_language['bbsp_selectonedev']);
        return;
    }
	
    var index = getSelectIndex();
    if (-1 == index)
    {
        AlertEx(userdevinfo_language['bbsp_selectdevice']);
        return;
    }

    window.location="userdetdevinfo.asp?" + UserDevices[index].Domain +  "?" + page;
}

function OnDelete()
{
    var FormIPv4 = new webSubmitForm();
    var FormIPv6 = new webSubmitForm();
    var CountIPv4 = 0;
    var CountIPv6 = 0;
    var StartIndex = (page - 1) * GettListNum();
    var EndIndex = page * GettListNum() ;
    for(var i = StartIndex; i < UserDevices.length && i < EndIndex ; i++)   
    {
        var CheckBox = document.getElementById('record_'+i);
        if (CheckBox.checked != true)
        {
            continue;
        }
        if ('ONLINE' == UserDevices[i].DevStatus.toUpperCase())
        {
            AlertEx(userdevinfo_language['bbsp_nodeletedev']);
            return false;
        }

       
        if(IsIPv6UserDev(i))
        {
            CountIPv6++;
            FormIPv6.addParameter(CheckBox.value,'');
        }
        else
        {
            CountIPv4++;
            FormIPv4.addParameter(CheckBox.value,'');
        }
       
    }
	
    if ((CountIPv6 <= 0)&&(CountIPv4 <= 0))
    {
        AlertEx(userdevinfo_language['bbsp_selectdevice']);
        return false;
    }
    if (false == ConfirmEx(userdevinfo_language['bbsp_devinfodelconfirm'])) 
    {
        return false;
    }

    ButtonDisableAll();
    if(CountIPv6)
    {
        FormIPv6.addParameter('x.X_HW_Token', getValue('onttoken'));
        FormIPv6.setAction('del.cgi?'+'x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i}.IPv6Address' + '&RequestFile=html/bbsp/userdevinfo/userdevinfo1.asp');
        FormIPv6.submit();
    }

    if(CountIPv4)
    {
        FormIPv4.addParameter('x.X_HW_Token', getValue('onttoken'));
        FormIPv4.setAction('del.cgi?' +'x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev' + '&RequestFile=html/bbsp/userdevinfo/userdevinfo1.asp');
        FormIPv4.submit();
    }
}

function OnIpFilter()
{
    if (true == IsSelectMulBox())
    {
        AlertEx(userdevinfo_language['bbsp_selectonedev']);
        return;
    }
    var index = getSelectIndex();
    if (-1 == index)
    {
        AlertEx(userdevinfo_language['bbsp_selectdevice']);
        return;
    }
    ipaddress = UserDevices[index].IpAddr;

    var MainName ;
    if(IsIPv6UserDev(index))
    {
        MainName= userdevinfo_language['bbsp_ipv6incoming_main_item'];
    }
    else
    {
        MainName= userdevinfo_language['bbsp_ipincoming_main_item'];
    }
       
    var SubItemName = userdevinfo_language['bbsp_ipincoming_sub_item'];

    if (IsPTVDF2Flag == 1)
    {
        var url ;
        if(IsIPv6UserDev(index))
        {
            url = '../../../html/bbsp/ipv6ipincoming/ipv6ipincoming.asp?' + ipaddress;
            window.parent.onMenuChange1("ipv6ipincoming",url);
        }
        else
        {
            url = '../../../html/bbsp/ipincoming/ipincoming.asp?' + ipaddress;
            window.parent.onMenuChange1("ipincoming",url);
        }
       
        return;
    }
	else if(curCfgModeWord.toUpperCase() == "GLOBE2")
	{
		url = '../../../html/bbsp/ipincoming/ipincoming.asp?' + ipaddress;
		window.parent.onMenuChange1("ipincoming",url);
        return;
    }

    var hpa = GetHpa(MainName);
    var zpa = GetZpa(MainName, SubItemName);

    if(hpa != -1 && zpa != -1)
    {
        top.Frame.showjump(hpa, zpa);
    }
    else
    {
        if(curUserType == sysUserType)
        {
            if(1 == PccwFlag)
            {
                top.Frame.showjump(5,0);
            }
            else
            {
                if (bin4board_nonvoice() == true)
                {
                    top.Frame.showjump(5,1);
                }
                else
                {
                    top.Frame.showjump(6,1);
                }
            }
        }
        else
        {
            if(1 == PccwFlag)
            {
                top.Frame.showjump(4,0);
            }
            else
            {
                top.Frame.showjump(4,1);
            }
        }
    }

    if(IsIPv6UserDev(index))
    {
        window.location='../../../html/bbsp/ipv6ipincoming/ipv6ipincoming.asp?' + ipaddress;
    }
    else
    {
        window.location='../../../html/bbsp/ipincoming/ipincoming.asp?' + ipaddress;
    }
    
}

function OnMacFilter()
{
    if (true == IsSelectMulBox())
    {
        AlertEx(userdevinfo_language['bbsp_selectonedev']);
        return;
    }
    var index = getSelectIndex();
    if (-1 == index)
    {
        AlertEx(userdevinfo_language['bbsp_selectdevice']);
        return;
    }
    macaddress = UserDevices[index].MacAddr;
	portid = UserDevices[index].Port;

    if(UserDevices[index].Port.indexOf("LAN") >=0 )
    {
        porttype = "ETH";
    }
    else
    {
        porttype = "WIFI";
    }

    if ("ETH" == porttype)
    {
        var MainName = userdevinfo_language['bbsp_macfilter_main_item'];
        var SubItemName = userdevinfo_language['bbsp_macfilter_sub_item'];
        if (IsPTVDF2Flag == 1  || curCfgModeWord.toUpperCase() == "GLOBE2")
        {
            var url = '../../../html/bbsp/macfilter/macfilter.asp?' + macaddress;
            window.parent.onMenuChange1("macfilter",url);
            return;
        }

        var hpa = GetHpa(MainName);
        var zpa = GetZpa(MainName, SubItemName);

        if(hpa != -1 && zpa != -1)
        {
            top.Frame.showjump(hpa, zpa);
        }
        else
        {
            if(curUserType == sysUserType)
            {
                if(1 == PccwFlag)
                {
                    top.Frame.showjump(5,1);
                }
                else
                {
                    if (bin4board_nonvoice() == true)
                    {
                        top.Frame.showjump(5,2);
                    }
                    else
                    {
                        top.Frame.showjump(6,2);
                    }
                }
            }
            else
            {
                if(1 == PccwFlag)
                {
                    top.Frame.showjump(4,1);
                }
                else if(curCfgModeWord.toUpperCase() == "RDSGATEWAY")
                {
                    top.Frame.showjump(4,0);
                }
                else
                {
                    top.Frame.showjump(4,2);
                }
            }
        }
        window.location='../../../html/bbsp/macfilter/macfilter.asp?' + macaddress;
    }
    else
    {
        var MainName = userdevinfo_language['bbsp_wlanmacfil_main_item'];
        var SubItemName = userdevinfo_language['bbsp_wlanmacfil_sub_item'];

        if (IsPTVDF2Flag == 1  || curCfgModeWord.toUpperCase() == "GLOBE2")
        {
            var url = '../../../html/bbsp/wlanmacfilter/wlanmacfilter.asp?' + macaddress + '?' + portid;
            window.parent.onMenuChange1("wlanmacfilter",url);
            return;
        }

        var hpa = GetHpa(MainName);
        var zpa = GetZpa(MainName, SubItemName);

        if(hpa != -1 && zpa != -1)
        {
            top.Frame.showjump(hpa, zpa);
        }
        else
        {
            if(curUserType == sysUserType)
            {
                if(1 == PccwFlag)
                {
                    top.Frame.showjump(5,2);
                }
                else
                {
                    if (bin4board_nonvoice() == true)
                    {
                        top.Frame.showjump(5,3);
                    }
                    else
                    {
                        top.Frame.showjump(6,3);
                    }
                }
            }
            else
            {
                if((1 == PccwFlag)||(curCfgModeWord.toUpperCase() == "RDSGATEWAY"))
                {
                    top.Frame.showjump(4,1);
                }
                else
                {
                    top.Frame.showjump(4,2);
                }
            }
        }
        window.location='../../../html/bbsp/wlanmacfilter/wlanmacfilter.asp?' + macaddress + '?' + portid;
    }
}

function OnPortMapping()
{
    if (true == IsSelectMulBox())
    {
        AlertEx(userdevinfo_language['bbsp_selectonedev']);
        return;
    }
    var index = getSelectIndex();
    if (-1 == index)
    {
        AlertEx(userdevinfo_language['bbsp_selectdevice']);
        return;
    }
    ipaddress = UserDevices[index].IpAddr;

    var MainName ;
    if(IsIPv6UserDev(index))
    {
        MainName= userdevinfo_language['bbsp_ipv6portmapping_main_item'];
    }
    else
    {
        MainName= userdevinfo_language['bbsp_portmapping_main_item'];
    }
  
    var SubItemName = userdevinfo_language['bbsp_portmapping_sub_item'];

    if (IsPTVDF2Flag == 1)
    {
        var url;
        if(IsIPv6UserDev(index))
        {
            url = '../../../html/bbsp/ipv6portmapping/ipv6portmapping.asp?' + ipaddress;
             window.parent.onMenuChange1("ipv6portmapping",url);
        }
        else
        {
            url = '../../../html/bbsp/portmapping/portmapping.asp?' + ipaddress;
            window.parent.onMenuChange1("portmapping",url);
        }
        
        return;
    }
	else if(curCfgModeWord.toUpperCase() == "GLOBE2")
	{
		url = '../../../html/bbsp/portmapping/portmapping.asp?' + ipaddress;
		window.parent.onMenuChange1("portmapping",url);
        return;
    }

    var hpa = GetHpa(MainName);
    var zpa = GetZpa(MainName, SubItemName);

    if(hpa != -1 && zpa != -1)
    {
        top.Frame.showjump(hpa, zpa);
    }
    else
    {
        if(curUserType == sysUserType)
        {
            if(1 == PccwFlag)
            {
                top.Frame.showjump(3,1);
            }
            else
            {
                if (bin4board_nonvoice() == true)
                {
                    top.Frame.showjump(3,1);
                }
                else
                {
                    top.Frame.showjump(4,1);
                }
            }
        }
        else
        {
            if(curCfgModeWord.toUpperCase() == "RDSGATEWAY")
            {
                top.Frame.showjump(3,0);
            }
            else
            {
                top.Frame.showjump(3,1);
            }
        }
    }

    if(IsIPv6UserDev(index))
    {
        window.location='../../../html/bbsp/ipv6portmapping/ipv6portmapping.asp?' + ipaddress;
    }
    else
    {
        window.location='../../../html/bbsp/portmapping/portmapping.asp?' + ipaddress;
    }
    
}

function OnReserveIp()
{
    if (true == IsSelectMulBox())
    {
        AlertEx(userdevinfo_language['bbsp_selectonedev']);
        return;
    }
    var index = getSelectIndex();
    if (-1 == index)
    {
        AlertEx(userdevinfo_language['bbsp_selectdevice']);
        return;
    }
    ipaddress = UserDevices[index].IpAddr;
    macaddress = UserDevices[index].MacAddr;

    var MainName ;
    var SubItemName;
    if(IsIPv6UserDev(index))
    {
        MainName= userdevinfo_language['bbsp_ipv6dhcp_static_main_item'];
        SubItemName = userdevinfo_language['bbsp_ipv6dhcp_static_sub_item']; 
    }
    else
    {
        MainName= userdevinfo_language['bbsp_dhcp_static_main_item'];
        SubItemName = userdevinfo_language['bbsp_dhcp_static_sub_item'];
    }
   

    if (IsPTVDF2Flag == 1)
    {
        if(IsIPv6UserDev(index))
        {
            var url = '../../../html/bbsp/dhcpstaticaddr/dhcpstaticaddress.asp?' + ipaddress + '?' + macaddress;
            window.parent.onMenuChange1("landhcpv6static",url);
        }
        else
        {
            var url = '../../../html/bbsp/dhcpstatic/dhcpstatic.asp?' + ipaddress + '?' + macaddress;
            window.parent.onMenuChange1("landhcpstatic",url);
        }
       
        return;
    }
	else if(curCfgModeWord.toUpperCase() == "GLOBE2")
	{
		var url = '../../../html/bbsp/dhcpstatic/dhcpstatic.asp?' + ipaddress + '?' + macaddress;
		window.parent.onMenuChange1("landhcpstatic",url);
        return;
    }

    var hpa = GetHpa(MainName);
    var zpa = GetZpa(MainName, SubItemName);
	
    if(hpa != -1 && zpa != -1)
    {
        top.Frame.showjump(hpa, zpa);
    }
    else
    {   
        if (curUserType == sysUserType)
        {
            if (("1" == "<% HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>") 
                && ("1" == "<% HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>"))
            {
                top.Frame.showjump(9,3);
            }
            else if (("1" != "<% HW_WEB_GetFeatureSupport(BBSP_FT_IPV6);%>") 
                && ("1" != "<% HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>"))
            {
                top.Frame.showjump(7,3);
            }
            else
            {
                top.Frame.showjump(8,3);
            }
         }
        else
        {
            top.Frame.showjump(6, 2);
        }
    }

    if(IsIPv6UserDev(index))
    {
         window.location = '../../../html/bbsp/dhcpstaticaddr/dhcpstaticaddress.asp?' + ipaddress + '?' + macaddress;
    }
    else
    {
        window.location = '../../../html/bbsp/dhcpstatic/dhcpstatic.asp?' + ipaddress + '?' + macaddress;
    }
              
    
}

function getHeight(id)
{
	var item = id;
	var height;
	if(item != null)
	{
		if(item.style.display == 'none')
		{
			return 0;
		}
		if(navigator.appName.indexOf("Internet Explorer") == -1)
		{	
			height = item.offsetHeight;
		}
		else 
		{
			height = item.scrollHeight;
		}
		
		if(typeof height == 'number')
		{
			return height;
		}
		return null;
	}
	return null;
}
function adjustParentHeight()
{
    var dh = getHeight(document.getElementById("divuserdevice"));
    var height = (dh > 0 ? dh : 0);
    var newHeight = '';

    if (appName == "Microsoft Internet Explorer")
    {
        newHeight = (height > 476) ? 476 : height;
    }
    else
    {
        newHeight = (height > 458) ? 458 : height;	
    }
    $("#divuserdevice").css("height", newHeight + "px");
}

function stUserDevFileState(domian,state)
{
    this.State = state;
    this.domain = domian;
}


function GettListNum()
{
    var listNum = 0;
    var appName = navigator.appName;
    if (appName == "Microsoft Internet Explorer")
    {
        listNum = 10;
    }
    else
    {
        listNum = 12;
    }
    return listNum;
}

function DisablePageBtn(CurPage)
{
    if ((firstpage == 0) && (lastpage == 0))
    {
        setDisable('jump',1);
    }
    else
    {
        setDisable('jump',0);
    }

    if(CurPage == firstpage)
    {
        setDisable('first',1);
        setDisable('prv',1);
    }
    else
    {
        setDisable('first',0);
        setDisable('prv',0);
    }
    
    if(CurPage == lastpage)
    {
        setDisable('next',1);
        setDisable('last',1);
    }
    else
    {
        setDisable('next',0);
        setDisable('last',0);
    }
}

function InitPageInfo(DataList)
{
    var DataInfoNr = DataList.length;

    if(DataInfoNr == 0)
    {
        firstpage = 0;
        lastpage = 0;
    }
    else
    {
        firstpage = 1;
        var listNum = GettListNum();
        lastpage = DataInfoNr/listNum;
        if(lastpage != parseInt(lastpage,10))
        {
            lastpage = parseInt(lastpage,10) + 1;
        }
    }

    if( window.location.href.indexOf("?") > 0)
    {
		if(IsValidPage(window.location.href.split("?")[1]) == true)
		{
			page = parseInt(window.location.href.split("?")[1],10); 
		}
		else
		{
			page = firstpage ;
		}
        
    }
    else 
    {
        page = firstpage;
    }
    
    DisablePageBtn(page);
    
    var str = parseInt(page,10) + "/" + lastpage;
    document.getElementById("pagenum").innerHTML = str;

    return page;
}

function IsValidPage(pagevalue)
{
	if ((true != isInteger(pagevalue)) || (parseInt(pagevalue,10) <= 0))
	{
		return false;
	}
	return true;
}

function submitfirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		return;
	}
	window.location="userdevinfo1.asp?" + parseInt(page,10);
}
function submitprv()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page--;
	window.location="userdevinfo1.asp?" + parseInt(page,10);
}
function submitnext()
{
	if (false == IsValidPage(page))
	{
		return;
	}
	page++;
	window.location="userdevinfo1.asp?" + parseInt(page,10);
}
function submitlast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		return;
	}
	window.location="userdevinfo1.asp?" + parseInt(page,10);
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
	setText('pagejump', '');
	
	window.location="userdevinfo1.asp?" + parseInt(jumppage,10);
}

function GetFileStat()
{
	var fileState="";
	var ParameterList = 'State&';
	var Url = '/getajax.cgi?x=InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.UserDevInfo&RequestFile=nopage' ;
	var fileStateTemp = HWGetAction(Url, ParameterList, getValue('onttoken'));
	fileState = fileStateTemp.State ;
	return fileState;
}  
function GetLanUserDevInfo()
{
    var FileState = GetFileStat() ;

    if(FileState == 'Completed')
    {
		
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "./getuserdevinfo.asp",
			success : function(data) {
				UserDevices  = dealDataWithStr(data);
			}
		});
		
        if(UserDevices == "NONE")
        {
			SetFileState("Creating");
            return ;
        }
       
        if(TimerHandle != undefined)
        {
            clearInterval(TimerHandle);
        }
	
        InitPageInfo(UserDevices);
		
        showlistcontrol(UserDevices);
		
        setDisplay('AppBtnList',1);
    }     
}

	


function LoadFrame()
{
    if (SupportNPTv6Address()) {
        setDisplay("ipfilter", 0);
        setDisplay("macfilter", 0);
        setDisplay("portmapping", 0);
        setDisplay("reserveip", 0);
    }
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("userdevinfotitle", GetDescFormArrayById(userdevinfo_language, "bbsp_mune"), GetDescFormArrayById(userdevinfo_language, "bbsp_userdevinfo_title1"), false);

</script> 
<div class="title_spread"></div>
<div  id="divuserdevice" style="overflow-x:auto; display:block">
<table width="100%" class='tabal_bg' border="0" align="center" cellpadding="0" cellspacing="1" id='devlist'>
<script>
    if (isRealmac == 1) {
        document.write('<tr class="head_title">');
        document.write("<td class='width_per5'></td>");
        document.write("<td class='width_per15' BindText='bbsp_hostname'></td>");
        document.write("<td class='width_per10' BindText='bbsp_devtype'></td>");
        document.write("<td class='width_per10' BindText='bbsp_ip'></td>");
        document.write("<td class='width_per15' BindText='bbsp_mac'></td>");
        document.write("<td class='width_per10' BindText='bbsp_realmac'></td>");
        document.write("<td class='width_per5' BindText='bbsp_devstate'></td>");
        document.write("<td class='width_per5' BindText='bbsp_interface'></td>");
        document.write("<td class='width_per10' BindText='bbsp_onlinetime'></td>");
        document.write("<td class='width_per10' BindText='bbsp_leasetime'></td>");
        document.write("</tr>");
    } else {
        document.write('<tr class="head_title">');
        document.write("<td class='width_per5'></td>");
        document.write("<td class='width_per15' BindText='bbsp_hostname'></td>");
        document.write("<td class='width_per10' BindText='bbsp_devtype'></td>");
        document.write("<td class='width_per15' BindText='bbsp_ip'></td>");
        document.write("<td class='width_per15' BindText='bbsp_mac'></td>");
        document.write("<td class='width_per5' BindText='bbsp_devstate'></td>");
        document.write("<td class='width_per5' BindText='bbsp_interface'></td>");
        document.write("<td class='width_per20' BindText='bbsp_onlinetime'></td>");
        document.write("<td class='width_per10' BindText='bbsp_leasetime'></td>");
        document.write("</tr>");
    }
</script>

</table>
<div style="height:10px;"></div>
</div>

<div style="height:10px;"></div>

<table class='width_per100' border="0" cellspacing="0" cellpadding="0" > 
    <tr > 
    <td class='width_per40'></td> 
    <td class='title_bright1' >
        <input name="first" id="first" class="PageNext jumppagejumplastbutton_wh_px" type="button" value="<<" onClick="submitfirst();"/> 
        <input name="prv" id="prv"  class="PageNext jumppagejumpbutton_wh_px" type="button" value="<" onClick="submitprv();"/> 
        <label id="pagenum"></label> 
        <input name="next"  id="next" class="PageNext jumppagejumpbutton_wh_px" type="button" value=">" onClick="submitnext();"/> 
        <input name="last"  id="last" class="PageNext jumppagejumplastbutton_wh_px" type="button" value=">>" onClick="submitlast();"/> 
    </td>
    <td class='width_per5'></td>
    <td  class='title_bright1'>
        <script> document.write(routeinfo_language['bbsp_goto']); </script> 
        <input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
        <script> document.write(routeinfo_language['bbsp_page']); </script>
    </td>
    <td class='title_bright1'>
        <button name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="submitjump();"> <script> document.write(routeinfo_language['bbsp_jump']); </script></button> 
    </td>
    </tr> 
</table> 

<div id="AppBtnList" style="display:none;"> 
    <div style="height:10px;"></div>
        <table cellpadding="0" cellspacing="0"  width="100%" class="width_per100"> 
        <tr > 
            <td class='title_bright1' nowrap>
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
            <input name="detail" id="detail" class="ApplyButtoncss buttonwidth_70px padstyle" type="button" onClick="OnDetial();" BindText="bbsp_detinfo"/> 
            <input name="delete" id="delete" class="ApplyButtoncss buttonwidth_70px padstyle" type="button" onClick="OnDelete();" BindText="bbsp_delete"/> 
            <input name="ipfilter" id="ipfilter"  class="ApplyButtoncss buttonwidth_99px padstyle" type="button" onClick="OnIpFilter();" BindText="bbsp_ipfilt"/> 
            <input name="macfilter"  id="macfilter" class="ApplyButtoncss buttonwidth_100px padstyle" type="button" onClick="OnMacFilter();" BindText="bbsp_macfilt"/> 
            <input name="portmapping"  id="portmapping" class="ApplyButtoncss buttonwidth_120px padstyle" type="button" onClick="OnPortMapping();" BindText="bbsp_poermap"/> 
            <input name="reserveip"  id="reserveip" class="ApplyButtoncss buttonwidth_99px padstyle" type="button" onClick="OnReserveIp();" BindText="bbsp_reserveip"/> 
            </td>
        </tr>   
        </table> 
</div>  
<div style="height:20px;"></div>
<script> 
    ParseBindTextByTagName(userdevinfo_language, "td",    1);
    ParseBindTextByTagName(userdevinfo_language, "div",   1);
    ParseBindTextByTagName(userdevinfo_language, "input", 2);
	
	function IsFromeWebPageJump()
	{
		if(IsValidPage(window.location.href.split("?")[1]) == true)
			return true;
		else 
			return false ;
	}
	function SetFileState(state)
	{
		var ParameterList = new Array(new stSpecParaArray("x.State",state, 0));
		var Parameter = {};
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false ;
		Parameter.SpecParaPair = ParameterList;
		var Url = 'setajax.cgi?x=InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.UserDevInfo&RequestFile=nopage' ;
		HWSetAction("ajax",Url,Parameter,getValue('onttoken'));
	}
	if(IsFromeWebPageJump()== false)
	{
		SetFileState("Creating");
	}
	GetLanUserInfo(function(para1, para2)
	{
		globuserinfo = para2;
		DHCPLeaseTimes = para1;
	});	
    var TimerHandle = setInterval("GetLanUserDevInfo()", 1000);
	
</script> 

</body>
</html>
