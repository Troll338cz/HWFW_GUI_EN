<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="./refreshTime.asp"></script>
<title>wireless basic configure</title>
<script language="JavaScript" type="text/javascript">
    
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var sptUserType ='1';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';

var addFlags = false;

function GetLanguageDesc(Name)
{
    return cfg_wlancfgdetail_language[Name];
}

var CfgMode ='<%HW_WEB_GetCfgMode();%>';

function ShowOrHideText(checkBoxId, passwordId, textId, value)
{
    if (1 == getCheckVal(checkBoxId))
    {
        setDisplay(passwordId, 1);
        setDisplay(textId, 0);
    }
    else
    {
        setDisplay(passwordId, 0);
        setDisplay(textId, 1);
    }
}

var SsidNum = '<%HW_WEB_GetSsidNum();%>';
var SsidNum2g = SsidNum.split(',')[0];

function stWlan(domain,ssid)
{
    this.domain = domain;
    this.ssid = ssid;
}
function gstwfdhcpst(domain,enable,ipstart,ipend,gateway,gatewaymask,dnss,dhcpleasetime,description)
{
	this.Domain 	= domain;
	this.Gateway 	    = gateway;
	this.Gatewaymask    = gatewaymask;
	this.DhcpStart 	= ipstart;
	this.DhcpEnd 	= ipend;
	this.LeaseTime 	= dhcpleasetime;
	this.Enable 	= enable;  
	if(dnss == "")
	{
		this.SlaPriDNS	= "";  
		this.SlaSecDNS  = "";
	}
	else
	{
		var SlaDnss 	= dnss.split(',');
		this.SlaPriDNS	= SlaDnss[0];  
		this.SlaSecDNS  = SlaDnss[1];
		
		if (SlaDnss.length <=1)
		{
		    this.SlaSecDNS = "";
		}
	}
	this.X_HW_Description = "guestwifi";
	this.PoolOrder = "1";
}
function stipaddr(domain,enable,ipaddr,subnetmask)
{
	this.domain		= domain;
	this.enable		= enable;
	this.ipaddr		= ipaddr;
	this.subnetmask	= subnetmask;	
}
function sldcinfo(domain,startIP,endIP,enable)
{
	this.domain		= domain;
	this.startIP    = startIP;
	this.endIP      = endIP;
	this.enable		= enable;
}
function madcinfo(domain,minaddress,maxaddress,enable)
{
	this.domain		= domain;
	this.minaddress = minaddress;
	this.maxaddress = maxaddress;
	this.enable		= enable;
}
var Wlan = new Array();

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},SSID,stWlan);%>;
var WfDhcpinstance = 0;
var GstWfDhcpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2., Enable|MinAddress|MaxAddress|IPRouters|SubnetMask|DNSServers|DHCPLeaseTime|X_HW_Description|PoolOrder,gstwfdhcpst);%>; 
WfDhcpinstance = GstWfDhcpInfos.length - 1;

var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,stipaddr);%>;
if (LanIpInfos[1] == null)
{
    LanIpInfos[1] = new stipaddr("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2", "", "", ""); 
}
var SlaveDhcpInfo= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.1.,MinAddress|MaxAddress|Enable,sldcinfo);%>;
var MainDhcpInfo= <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,MinAddress|MaxAddress|DHCPServerEnable,madcinfo);%>;
var WlanArrLen = WlanArr.length - 1;

for(i=0; i <WlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}

function stGuestWifi(domain,SSID_IDX,PortIsolation,UpRateLimit,DownRateLimit)
{
	this.domain = domain;
    this.SSID_IDX = SSID_IDX;
	this.PortIsolation = PortIsolation;
	this.UpRateLimit = UpRateLimit;
	this.DownRateLimit = DownRateLimit;
}

var GuestWifi = new Array();

var GuestWifiArr = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.{i},SSID_IDX|PortIsolation|UpRateLimit|DownRateLimit,stGuestWifi);%>;
var GuestWifiArrLen = GuestWifiArr.length - 1;

for(var i=0; i <GuestWifiArrLen; i++)
{
    GuestWifi[i] = new stGuestWifi();
    GuestWifi[i] = GuestWifiArr[i];
}

function showGuestWifiInfo()
{
	for(var i=0; i <GuestWifiArrLen; i++)
	{	
		setSelect('wlSSIDSelect', GuestWifi[0].SSID_IDX);						
		setText('wlUpRate', GuestWifi[i].UpRateLimit);
		setText('wlDownRate', GuestWifi[i].DownRateLimit);
		setCheck('wlIsolateEnable', GuestWifi[i].PortIsolation);
	}	
}

function InitGuestWifiInfo()
{
		setText('wlUpRate', 0);
		setText('wlDownRate', 0);
		setCheck('wlIsolateEnable', 0);
}

function LoadFrame()
{		
	var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }     
        if (cfg_wlancfgbasic_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgbasic_language[b.getAttribute("BindText")];
        } else if (cfg_wlancfgdetail_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgdetail_language[b.getAttribute("BindText")];    
        } else if (cfg_wlancfgadvance_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgadvance_language[b.getAttribute("BindText")];    
        } else if (cfg_wlancfgother_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlancfgother_language[b.getAttribute("BindText")];        
        } else if (cfg_wlanzone_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlanzone_language[b.getAttribute("BindText")];        
        }else if (cfg_wlanguestwifi_language[b.getAttribute("BindText")]) {
            b.innerHTML = cfg_wlanguestwifi_language[b.getAttribute("BindText")];        
        }		
    }
	
	addFlags = false;
	if(0 == GuestWifiArrLen)
	{
		setDisplay('GuestWifiDetail', 0);		
		setDisable('BtnAdd', 0);
		addFlags =  true;
        InitGuestWifiInfo();
        setDisplay("GstWfServerPool",0);	
	}
	else
	{
		setDisplay('GuestWifiDetail', 1);
		setDisable('BtnAdd', 1);
		addFlags = false;
		showGuestWifiInfo();
		setDisplay("GstWfServerPool",1);
		setControl();
		if(0 != WfDhcpinstance)
		{
			if((GstWfDhcpInfos[0].Gateway == LanIpInfos[1].ipaddr) && ((0 == SlaveDhcpInfo[0].enable) || (0 == LanIpInfos[1].enable))) //当前没有跟条件地址那块连动，产品特殊处理
			{
			   setCheck('GstWfEnable', 0);
			   setText('GstWfMask', LanIpInfos[0].subnetmask);
			   setText('GstWfEthStart', '');
		       setText('GstWfEthEnd', '');
			   setLease(14400);
			   setText('dnsGstPri', '');
		       setText('dnsGstScd', '');
			}
			else
			{
			   setCheck('GstWfEnable', GstWfDhcpInfos[0].Enable);
			   setSelect('GstWfIpAddr', GstWfDhcpInfos[0].Gateway);
		       setText('GstWfMask', GstWfDhcpInfos[0].Gatewaymask);
		       setText('GstWfEthStart', GstWfDhcpInfos[0].DhcpStart);
		       setText('GstWfEthEnd', GstWfDhcpInfos[0].DhcpEnd);
			   setLease(GstWfDhcpInfos[0].LeaseTime);
			   setText('dnsGstPri', GstWfDhcpInfos[0].SlaPriDNS);
		       setText('dnsGstScd', GstWfDhcpInfos[0].SlaSecDNS);
			}
		}
		else
		{
		    setLease(14400);
		}
		enbleDHCP();
	    setDisable("GstWfMask",1);	
	}	
}

function stIspSsid(domain, SSID_IDX)
{
    this.domain = domain;
    this.SSID_IDX = SSID_IDX;
}

var IspSsidList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_WLANForISP.{i}, SSID_IDX, stIspSsid);%>;

function IsIspSsid(wlanInst)
{
    for (var i = 0; i < IspSsidList.length - 1; i++)
    {
        if (wlanInst == IspSsidList[i].SSID_IDX)
        {
            return true;        
        }
    }
    return false;
}

function getInstIdByDomain(domain)
{
    if ('' != domain)
    {
        return parseInt(domain.charAt(domain.length - 1));    
    }
}

function CheckStreamRateValue()
{ 
    var UpstreamRate = getValue('wlUpRate');
    var DownstreamRate = getValue('wlDownRate');

    if(!isInteger(UpstreamRate))
    {
        AlertEx(cfg_wlanguestwifi_language['amp_uprate_int']);
        return false;
    }

    if( (parseInt(UpstreamRate,10) < 0) || (parseInt(UpstreamRate,10) > 4094) )
    {
        AlertEx(cfg_wlanguestwifi_language['amp_uprate_out_range']);
        return false;
    }

    if(!isInteger(DownstreamRate))
    {
        AlertEx(cfg_wlanguestwifi_language['amp_downrate_int']);
        return false;
    }

    if( (parseInt(DownstreamRate,10) < 0) || (parseInt(DownstreamRate,10) > 4094) )
    {
        AlertEx(cfg_wlanguestwifi_language['amp_downrate_out_range']);
        return false;
    }

    return true;
}

function selectRemoveCnt(curCheck)
{

}


function setControl()
{
	$("#GstWfIpAddr").append('<option value="' + htmlencode(LanIpInfos[0].ipaddr) + '" id="'
                + 0 + '">'
                + LanIpInfos[0].ipaddr + '</option>');
	if ((1 == SlaveDhcpInfo[0].enable) && (1 == LanIpInfos[1].enable) )
	{
	    $("#GstWfIpAddr").append('<option value="' + htmlencode(LanIpInfos[1].ipaddr) + '" id="'
                + 1 + '">'
                + LanIpInfos[1].ipaddr + '</option>');
	}
	for(var i = 0; i < LanIpInfos.length - 1; i++)
	{
		if((getValue("GstWfIpAddr") == LanIpInfos[i].ipaddr))
		{
		    setText('GstWfMask', LanIpInfos[i].subnetmask);
			break;
		}
	}
}

function addDeleteDomain(SubmitForm)
{    
    var rml = getElement('rml');    
    if (rml == null)        
        return;
    
    with (document.forms[0])
    {
        if (rml.length > 0)
        {
            for (var i = 0; i < rml.length; i++)
            {
                if (rml[i].checked == true)
                {
                    wlandomain = rml[i].value;
                    SubmitForm.addParameter(wlandomain, '');
                }
            }
        }
        else if (rml.checked == true)
        {
            wlandomain = rml.value;
            SubmitForm.addParameter(wlandomain, '');
        }        
    }
}

function btnRemoveGuestWifiCnt()
{
    if (addFlags == true)
    {
       AlertEx(cfg_wlanguestwifi_language['amp_guestwifi_del']);
       return;
    }
    var rml = getElement('rml');
    var noChooseFlag = true;    
    if ( rml.length > 0)
    {
        for (var i = 0; i < rml.length; i++)
        {
            if (rml[i].checked == true)
            {
                noChooseFlag = false;
            }
        }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
    }

    if ( noChooseFlag )
    {   
        AlertEx(cfg_wlanguestwifi_language['amp_guestwifi_select']);
        return ;
    }

    if (ConfirmEx(cfg_wlanguestwifi_language['amp_delguestwifi_confirm']) == false)
    {   
        document.getElementById("DeleteButton").disabled = false;
        return;
    }

    var Form = new webSubmitForm();    
    addDeleteDomain(Form);
	if (WfDhcpinstance > 0)
	{
	   Form.addParameter('InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2', '');
	}
    Form.setAction('del.cgi?RequestFile=html/amp/wlanbasic/WlanGuestWifi.asp');
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function clickRemove(tabTitle)
{
    btnRemoveGuestWifiCnt();
}

function onClickGuestWifiSSIDChange()
{

}

function onClickIsolateEnable()
{		
	
}

function SubmitForm()
{
    var Form = new webSubmitForm();   
    var ssid_idx = getSelectVal('wlSSIDSelect');
	var UpRate = parseInt(getValue('wlUpRate'), 10);
    var DownRate = parseInt(getValue('wlDownRate'), 10);
	var Isolation = getCheckVal('wlIsolateEnable');

    if (false == CheckStreamRateValue())
    {
        return;
    }
	
	Form.addParameter('y.SSID_IDX', ssid_idx);
    Form.addParameter('y.PortIsolation', Isolation);
    Form.addParameter('y.UpRateLimit', UpRate);
	Form.addParameter('y.DownRateLimit', DownRate);
	Form.setAction('set.cgi?y=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest.1'
                    + '&RequestFile=html/amp/wlanbasic/WlanGuestWifi.asp');  			
		
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function ApplySubmit1()
{
    var Form = new webSubmitForm();   
    var ssid_idx = getSelectVal('wlSSIDSelect');
	var UpRate = parseInt(getValue('wlUpRate'), 10);
    var DownRate = parseInt(getValue('wlDownRate'), 10);
	var Isolation = getCheckVal('wlIsolateEnable');
		
    if (false == CheckStreamRateValue())
    {
        return;
    }
	
	Form.addParameter('y.SSID_IDX', ssid_idx);
    Form.addParameter('y.PortIsolation', Isolation);
    Form.addParameter('y.UpRateLimit', UpRate);
	Form.addParameter('y.DownRateLimit', DownRate);
	Form.setAction('add.cgi?y=InternetGatewayDevice.LANDevice.1.X_HW_WLANForGuest'
                    + '&RequestFile=html/amp/wlanbasic/WlanGuestWifi.asp');     
    setDisable('btnApplySubmit',1);
    setDisable('cancel',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function ApplySubmit2()
{
    SubmitForm();
}

function ApplySubmit()
{
    if (addFlags == true)
    {
        ApplySubmit1();
    }
    else
    {       
        ApplySubmit2();
    }
}

function cancelValue()
{
	if(addFlags == true)
	{
		var tableRow = getElement("GuestWifiInfo");
		if (0 == GuestWifiArrLen)
		{
			setDisplay('GuestWifiDetail',0);
		}    
        tableRow.deleteRow(tableRow.rows.length-1);
		InitGuestWifiInfo();
	}
	else
	{
		showGuestWifiInfo();
	}
}


function setGuestWifiShow()
{
	setDisplay("GuestWifiDetail", 1);
}

function wlanWriteTabHeader(tabTitle, width, titleWidth, type)
{
    if (width == null)
        width = "70%";
        
    if (titleWidth == null)
       titleWidth = "120";
            
    var html = 
            "<table width=\"" + width + "\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
            + "<tr>"
            + "<td>"
            + "<table class=\"width_per100\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
            + "<tr class=\"tabal_head\">"
            + " <td class=\"width_per35\"><\/td>"
            + "<td class=\"align_right\">"
            + "<table class=\"width_per100\" border=\"0\" cellpadding=\"1\" cellspacing=\"0\">"
            + "<tr class=\"align_right\">";
			
        html +=  '<td></td><td class="align_right" width="40">'
                 + '<input name="BtnAdd" id="BtnAdd" type="button" class="submit" value="' + cfg_wlancfgother_language['amp_wlan_new'] + '" '
                 + 'onclick="setGuestWifiShow();clickAdd(\'' + tabTitle + '\');" />'     
                 + '</td><td class="align_right" width="42">'
                 + '<input name="DeleteButton" id="DeleteButton" type="button" class="submit" value="' + cfg_wlancfgother_language['amp_wlan_del'] + '" ' 
                 + 'onclick="OnDeleteButtonClick(\''
                 + tabTitle + '\');" />'
                 + '</td><td width="3"></td>';
    
	
        html += "<\/tr>"
                + "<\/table>"
                + "<\/td>"
                + "<\/tr>"
                + "<\/table>"
                + "<\/td>"
                + "<\/tr>"
                + "<tr>"
                + "<td id=\"" + tabTitle + "\">";
				
    document.write(html);
}

function wlanWriteTabCfgHeader(tabTitle, tabWidth,titleWidth)
{
    wlanWriteTabHeader(tabTitle,tabWidth,titleWidth,'cfg');
}

function wlanWriteTabTail()
{
    document.write("<\/td><\/tr><\/table>");
}

function SetStyleValue(Id, Value)
{
    try
    {
        var Div = document.getElementById(Id);
        Div.setAttribute("style", Value);
        Div.style.cssText = Value;
    }
    catch(ex)
    {
    }
}
function enbleDHCP()
{ 
	var bDisplay = getCheckVal('GstWfEnable');
	setDisplay('GstWfConfigForm', bDisplay);
}
function checkLease(fieldPrompt,LeaseTime,Frag,resourceLangDes)
{
       var errmsg="";
       var field="";
       
       field=resourceLangDes[fieldPrompt];
       errmsg=new Array("bbsp_lease_invalid","bbsp_lease_num","bbsp_lease_outrange");
       
       if (LeaseTime == '')
       {
           AlertEx(field+resourceLangDes[errmsg[0]]);
           return false;
       }
   
      	if(!isInteger(LeaseTime) )
  		{
    	   AlertEx(field+resourceLangDes[errmsg[1]]);
           return false;
        }
   
        var lease=LeaseTime*Frag;
        if(lease<=0)
      	{
            AlertEx(field+resourceLangDes[errmsg[1]]);
            return false;
        }
   
        if((lease>604800*10))
      	{
      	    AlertEx(field+resourceLangDes[errmsg[2]]);
            return false;
      	}
      
        return true;
}

function setLease(dhcpLease)
{
    var i = 0;
    var timeUnits = 604800;
    var infinite = ((dhcpLease == "-1") || (dhcpLease == "4294967295"));

    for(i = 0; i < 4; i++)
    {
        if (i == 0 )
        {
            timeUnits  = 604800;
        }
        else if (i == 1)
        {
            timeUnits  = 86400;
        }
        else if (i == 2)
        {
            timeUnits  = 3600;
        }
        else
        {
            timeUnits  = 60;                    
        } 
        if ( true == isInteger(dhcpLease / timeUnits) )
        {
            break; 
        }          
    }
	setSelect('dhcpLeasedTimeFrag', timeUnits);
	if(infinite)
	{		
		setText('GstWfLeasedTime', cfg_wlanguestwifi_language['bbsp_gstwfinfinitetime']);
	}
	else
	{
		setText('GstWfLeasedTime', dhcpLease /timeUnits);	
	}
}

function InitLeasedTime()
{
	var LeasedTimeIdArray = ["dhcpLeasedTimeFrag"];
	for(var i = 0; i < LeasedTimeIdArray.length; i++)
	{
		var LeasedTimeId = "#" + LeasedTimeIdArray[i];
		$(LeasedTimeId).append('<option value="60">'+ cfg_wlanguestwifi_language['bbsp_minute'] + '</option>');
		$(LeasedTimeId).append('<option value="3600">'+ cfg_wlanguestwifi_language['bbsp_hour'] + '</option>');	
		$(LeasedTimeId).append('<option value="86400">'+ cfg_wlanguestwifi_language['bbsp_day'] + '</option>');	
		$(LeasedTimeId).append('<option value="604800">'+ cfg_wlanguestwifi_language['bbsp_week'] + '</option>');
	}	
}
function IsLessThan(lip, rip)
{
	var ladress = lip.split('.');
	var radress = rip.split('.');
	var ladnum = 0;
	var radnum = 0;
	
	for(var i = 0; i < 4; i++)
	{
		ladnum = ladnum + parseInt(ladress[i], 10);
		radnum = radnum + parseInt(radress[i], 10);
	}

	if(ladnum <= radnum)
	{
	    return true;
	}
	return false;
}
function CheckStEdIp()
{
    var guestwifiroute = getValue("GstWfIpAddr");
    var guestwifiMask = getValue("GstWfMask");
	if ((0 == MainDhcpInfo[0].enable) && (1 == getCheckVal('GstWfEnable'))) 
    {
    	AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfcannotenable']);
       	return false;
    }
	if (isValidIpAddress(getValue("GstWfEthStart")) == false) 
       {
    	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
       	   return false;
       }

       if (isBroadcastIp(getValue("GstWfEthStart"), guestwifiMask) == true)
       {
    	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfstartipinvalid']);
    	   return false;
       }

       if (false == isSameSubNet(getValue("GstWfEthStart"),guestwifiMask,guestwifiroute,guestwifiMask))
       {
    	   if(guestwifiroute == LanIpInfos[0].ipaddr)
		   {
		       AlertEx(cfg_wlanguestwifi_language['bbsp_gststipinsamemahost']);
		   }
		   else
		   {
		       AlertEx(cfg_wlanguestwifi_language['bbsp_gststipinsamesehost']);
		   }		   
    	   return false;
       }

       if (isValidIpAddress(getValue("GstWfEthEnd")) == false) 
       {
    	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipinvalid']);
    	  return false;
       }

       if (isBroadcastIp(getValue("GstWfEthEnd"), guestwifiMask) == true)
       {
    	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipinvalid']);
    	   return false;
       }

       if (false == isSameSubNet(getValue("GstWfEthEnd"),guestwifiMask,guestwifiroute,guestwifiMask))
       {
    	   if(guestwifiroute == LanIpInfos[0].ipaddr)
		   {
		       AlertEx(cfg_wlanguestwifi_language['bbsp_gststipinsamemahost']);
		   }
		   else
		   {
		       AlertEx(cfg_wlanguestwifi_language['bbsp_gststipinsamesehost']);
		   }		   
    	   return false;
       }

       if (!(isEndGTEStart(getValue("GstWfEthEnd"), getValue("GstWfEthStart")))) 
       {
    	   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfendipgeqstartip']);
           return false;
       }
	   
	   if((guestwifiroute == LanIpInfos[0].ipaddr) && 
	      ((IsLessThan(MainDhcpInfo[0].minaddress, getValue("GstWfEthEnd")) && IsLessThan(getValue("GstWfEthStart"), MainDhcpInfo[0].minaddress)) || 
		   (IsLessThan(MainDhcpInfo[0].minaddress, getValue("GstWfEthStart")) && IsLessThan(getValue("GstWfEthStart"), MainDhcpInfo[0].maxaddress))))
	   {
		   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolinmianpool']);
    	   return false;
	   }
	   
	   if((guestwifiroute == LanIpInfos[1].ipaddr) && 
	       ((IsLessThan(SlaveDhcpInfo[0].startIP, getValue("GstWfEthEnd")) && IsLessThan(getValue("GstWfEthStart"), SlaveDhcpInfo[0].startIP)) || 
		   (IsLessThan(SlaveDhcpInfo[0].startIP, getValue("GstWfEthStart")) && IsLessThan(getValue("GstWfEthEnd"), SlaveDhcpInfo[0].endIP))))
	   {
	       AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolinslavepool']);
    	   return false;
	   }
	   return true;
}
function CheckParameter()
{
	if (getCheckVal("GstWfEnable") == 1)
	{
	   if(false == CheckStEdIp())
	   {
	       return false;
	   }
	   var timeLease = getValue('GstWfLeasedTime');
	   if (false == checkLease("bbsp_gstwfpool",timeLease,getSelectVal('dhcpLeasedTimeFrag'),cfg_wlanguestwifi_language))
	   {
		   return false;
	   }
	   if ( getValue('dnsGstPri') != '' && (isValidIpAddress(getValue('dnsGstPri')) == false || isAbcIpAddress(getValue('dnsGstPri')) == false))
	   {
		  AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolpridnsinvalid']);
		  return false;
	    }
		
	   if ( getValue('dnsGstScd') != '' && (isValidIpAddress(getValue('dnsGstScd')) == false || isAbcIpAddress(getValue('dnsGstScd')) == false))
	   {
		   AlertEx(cfg_wlanguestwifi_language['bbsp_gstwfpoolsecdnsinvalid']);
		   return false;
	   }
    }	
    return true;
}
function ShowIPAdress()
{
    ShowIPMask();
}
function ShowIPMask()
{
    if (LanIpInfos[0].ipaddr == getValue("GstWfIpAddr"))
	{
	    setText('GstWfMask', LanIpInfos[0].subnetmask);
	}
	else if(LanIpInfos[1].ipaddr == getValue("GstWfIpAddr"))
	{
	    setText('GstWfMask', LanIpInfos[1].subnetmask)
	}
}
function ApplyConfig()
{
    if (CheckParameter() == false)
	{
		return false;
	}
	 
	 var Form = new webSubmitForm();
	 with (document.forms[0])
     {  
		Form.addParameter('z.Enable',getCheckVal('GstWfEnable'));
	    if (getCheckVal("GstWfEnable") == 1) 
        {    	        	  
            var DnsSStr = getValue('dnsGstPri') + ',' + getValue('dnsGstScd');
            if ( getValue('dnsGstPri') == 0)
            {
                DnsSStr = getValue('dnsGstScd');
            }
            if ( getValue('dnsGstScd') == 0)
            {
                DnsSStr = getValue('dnsGstPri');
            }  
            Form.addParameter('z.DNSServers',DnsSStr);
        	   
		    Form.addParameter('z.IPRouters',getValue('GstWfIpAddr'));
		    Form.addParameter('z.SubnetMask',getValue('GstWfMask'));
            Form.addParameter('z.MinAddress',getValue('GstWfEthStart'));
            Form.addParameter('z.MaxAddress',getValue('GstWfEthEnd'));
            Form.addParameter('z.DHCPLeaseTime',getValue('GstWfLeasedTime')*getValue('dhcpLeasedTimeFrag'));
			Form.addParameter('z.X_HW_Description',"guestwifi");
			Form.addParameter('z.PoolOrder',"1");
			var SL = GetSSIDList();
			for(var i = 0; i < SL.length; i++)
			{
				if(GuestWifi[0].SSID_IDX == getWlanInstFromDomain(SL[i].domain))
				{
				    Form.addParameter('z.SourceInterface',SL[i].domain);
					break;
				}
			}        
        }     
    }	
	var url;	
	if (WfDhcpinstance == 0)
	{
		url = 'add.cgi?' + 'z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool'
	               + '&RequestFile=html/amp/wlanbasic/WlanGuestWifi.asp';
	}
	else
	{
	    url = 'set.cgi?' + 'z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2'
	               + '&RequestFile=html/amp/wlanbasic/WlanGuestWifi.asp';
	}		  
	Form.setAction(url);	 
	Form.addParameter('x.X_HW_Token', getValue('onttoken1'));
    setDisable('GstWfEnable',1);
	Form.submit();
}


</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
var GuestWifi_header = cfg_wlanguestwifi_language['amp_guestwifi_header']; 
var GuestWifiSummaryArray = new Array(new stSummaryInfo("text", GetDescFormArrayById(cfg_wlanguestwifi_language, "amp_guestwifi_tittle")),
                                    new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note1")),
                                    new stSummaryInfo("text","1. " + GetDescFormArrayById(cfg_wlanguestwifi_language, "amp_guestwifi_note1") + "<br>"),
									new stSummaryInfo("text","2. " + GetDescFormArrayById(cfg_wlanguestwifi_language, "amp_guestwifi_note2")),
                                    null);
HWCreatePageHeadInfo("GuestWifiSummary", GuestWifi_header, GuestWifiSummaryArray, true);
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr ><td class="height15p"></td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr ><td>
<form id="ConfigForm" action="../network/set.cgi">
<div id='GuestWifiCfg'>

<script language="JavaScript" type="text/javascript">
	wlanWriteTabCfgHeader('GusetWifi',"100%");
</script>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="GuestWifiInfo">
    <tr class="head_title">
        <td>&nbsp;</td>
          <td ><div class="align_left"><script>document.write(cfg_wlanguestwifi_language['amp_guestwifi_tittle_ssidname']);</script></div></td>
          <td ><div class="align_left"><script>document.write(cfg_wlanguestwifi_language['amp_guestwifi_tittle_upstreamrate']);</script></div></td>
          <td ><div class="align_left"><script>document.write(cfg_wlanguestwifi_language['amp_guestwifi_tittle_downstreamrate']);</script></div></td>
          <td ><div class="align_left"><script>document.write(cfg_wlanguestwifi_language['amp_guestwifi_tittle_isolateenable']);</script></div></td>
    </tr>
    <script language="JavaScript" type="text/javascript">
        for (var i = 0;i < GuestWifiArrLen; i++)
        {   
            document.write('<TD>' + '<input type="checkbox" name="rml" id="rml"'  + ' value="'+ GuestWifiArr[i].domain + '" onclick="selectRemoveCnt(i);" >' + '</TD>');
			for(var j =0; j < WlanArrLen; j++)
			{
				if(GuestWifiArr[i].SSID_IDX == getInstIdByDomain(WlanArr[j].domain))
				{
					document.write('<TD>' + htmlencode(WlanArr[j].ssid) + '</TD>');
				}
				else
				{
					continue;
				}
			}
            document.write('<TD>' + GuestWifiArr[i].UpRateLimit+ '</TD>');
			document.write('<TD>' + GuestWifiArr[i].DownRateLimit+ '</TD>');
			if(true == GuestWifiArr[i].PortIsolation)
			{
				document.write('<TD>' + cfg_wlanguestwifi_language['amp_guestwifi_status_enable'] + '</TD>');
			}
			else
			{
				document.write('<TD>' + cfg_wlanguestwifi_language['amp_guestwifi_status_disable'] + '</TD>');
			}
            document.write('</TR>');
        }
    </script>
</table>
<script language="JavaScript" type="text/javascript">
wlanWriteTabTail();
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height5p"></td></tr>
</table>
<div id="GuestWifiDetail" style="display:none;">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" id="GuestWifiDetail_table"> 
      <tr>
        <td colspan="6">			
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
					<td class="table_title width_per25" BindText='amp_guestwifi_ssidname'></td>
                    <td class="table_right" id="TdSSIDSelect">
                        <select id='wlSSIDSelect' name='wlSSIDSelect' size="1" onChange='onClickGuestWifiSSIDChange()' style = "width:180px">
						<script>
							for(var index = 0; index < WlanArrLen; index++)
							{
							    var wlanInst = getInstIdByDomain(WlanArr[index].domain);
								if(!IsIspSsid(wlanInst))	
								{
									document.write('<option value='+ wlanInst +'>' + WlanArr[index].ssid  + '</option>');
								}								
							}						
						</script>
                        </select><font class="color_red">*</font><span class="gray">
                      </span></td>
                </tr>
            </table>
			
            <table id = 'table_wlan_basic_config' width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
                <tr>
                  <td class="table_title width_per25" BindText='amp_guestwifi_upstreamrate'></td>
                  <td class="table_right" id="TdUpRate">
                      <script language="JavaScript" type="text/javascript">
                          {
                              document.write('<input type="text" name="wlUpRate" id="wlUpRate" >');                     
                          }
                      </script>            
                      <font class="color_red">*</font><span class="gray">
                      <script>document.write("Mbps");document.write(cfg_wlanguestwifi_language['amp_guestwifi_downstreamrate_notes']);</script></span> 
                 </td>
                </tr>
				
				 <tr>
                  <td class="table_title width_per25" BindText='amp_guestwifi_downstreamrate'></td>
                  <td class="table_right" id="TdDownRate">
                      <script language="JavaScript" type="text/javascript">
                          {
                              document.write('<input type="text" name="wlDownRate" id="wlDownRate" >');                     
                          }
                      </script>            
                      <font class="color_red">*</font><span class="gray">
                      <script>document.write("Mbps");document.write(cfg_wlanguestwifi_language['amp_guestwifi_downstreamrate_notes']);</script></span> 
                 </td>
                </tr>
				
                <tr>
                    <td class="table_title width_per25" BindText='amp_guestwifi_Isolateenable'></td>
                    <td class="table_right" id="TdIsolateEnable">
                        <input type='checkbox' id='wlIsolateEnable' name='wlIsolateEnable' value="1" onClick="onClickIsolateEnable();">
                        </span> </td>
                </tr>
            </table>
        </td> 
      </tr>
      </table>
               
        <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
        <tr><td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
              <tr id='applytr'>
                    <td class="table_submit width_per25"></td>
                    <td class="table_submit">
					    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                        <button id="btnApplySubmit" name="btnApplySubmit" type="button" class="submit" onClick="ApplySubmit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
                        <button id="cancel" name="cancel" type="button" class="submit" onClick="cancelValue();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
                    </td>
                  </tr>
            </table>
        </td> 
      </tr>
	</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr ><td class="width_10px"></td></tr>
	  </table> 
</div>
</div>  

</form>
</td></tr>
</table>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
<div id='GstWfServerPool' style="display:none">
<div class="func_spread"></div>

<form id = "GstWfPoolConfigForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title"> 
<tr>
<td id="GstWfPoolInfoBar">
<script>
document.write(cfg_wlanguestwifi_language['bbsp_gstwfpool']);
</script>
</td>
</tr></table>  

<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li   id="GstWfEnable"        		RealType="CheckBox"      	  DescRef="bbsp_enablegstwf"        RemarkRef="Empty"     			ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"  Elementclass="TextBox_2"  InitValue="Empty"  ClickFuncApp="onclick=enbleDHCP"/>
</table>
<script>
GstWfPoolConfigFormList = HWGetLiIdListByForm("GstWfPoolConfigForm", null);
var TableClass = new stTableClass("width_per30", "width_per70", "", "StyleSelect");
HWParsePageControlByID("GstWfPoolConfigForm", TableClass, cfg_wlanguestwifi_language, null);
</script>
</form>

<form id = "GstWfConfigForm" style="display:none">
<table border="0" cellpadding="0" cellspacing="1"  width="100%">
<li   id="GstWfIpAddr"        	  RealType="DropDownList"      	    DescRef="bbsp_ipmh"        		  RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="TRUE"     BindField="Empty"   InitValue="Empty"  ClickFuncApp="onchange=ShowIPAdress" MaxLength="15"/>
<li   id="GstWfMask"        	  RealType="TextBox"      	    DescRef="bbsp_maskmh"        	  RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="TRUE"     BindField="Empty"   InitValue="Empty"  MaxLength="15"/>
<li   id="GstWfEthStart"          RealType="TextBox"            DescRef="bbsp_startipmh"          RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="TRUE"     BindField="Empty"   InitValue="Empty"  MaxLength="15"/>
<li   id="GstWfEthEnd"            RealType="TextBox"            DescRef="bbsp_endipmh"            RemarkRef="Empty"     		ErrorMsgRef="Empty"    Require="TRUE"     BindField="Empty"   InitValue="Empty"  MaxLength="15"/>
<li   id="GstWfLeasedTime"        RealType="TextOtherBox"       DescRef="bbsp_leasedmh"           RemarkRef="Empty"    			ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   Elementclass="TextBox_2"    InitValue="[{Type:'select',Item:[{AttrName:'id',AttrValue:'dhcpLeasedTimeFrag'},{AttrName:'class',AttrValue:'Select_2'}]}]"/>
<li   id="dnsGstPri"             RealType="TextBox"            DescRef="bbsp_pridnsmh"            RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"        InitValue="Empty"  MaxLength="15"/>
<li   id="dnsGstScd"             RealType="TextBox"            DescRef="bbsp_secdnsmh"            RemarkRef="Empty"    ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"        InitValue="Empty"  MaxLength="15"/>
</table>
<script>
GstWfConfigFormList = HWGetLiIdListByForm("GstWfConfigForm", null);
HWParsePageControlByID("GstWfConfigForm", TableClass, cfg_wlanguestwifi_language, null);
</script>
</form>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_button"> 
<tr> 
  <td class='width_per25'></td> 
  <td class="table_submit" > 
   <input type="hidden" name="onttoken1" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
  <button id="btnApply" name="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="javascript:return ApplyConfig();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script> </button> 
	<button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script> </button>  
</tr> 
</table> 
</div>
<br>
<br>
<script language="JavaScript" type="text/javascript">
InitLeasedTime();
</script> 
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
