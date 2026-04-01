<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/dhcpinfo.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(Itvdfinterface.js);%>"></script>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/dhcpservercfg/dhcp2.cus);%>"></script>
<script language="javascript" src="/html/bbsp/common/GetLanUserDevInfo.asp"></script>
<style type="text/css" media="screen">
.ipv6firewall .select {
		width: 0px;
		top: 0;
		left: 0;
		cursor: pointer;
}
#showlist{
    font-weight:normal;
}
</style>
<script type="text/javascript">
function stLanHostInfo(domain,ipaddr,subnetmask)
{
	this.domain = domain;
	this.ipaddr = ipaddr;
	this.subnetmask = subnetmask;
}
function dhcpmainst(domain,startip,endip,leasetime)
{
	this.domain 	= domain;
	this.startip	= startip;
	this.endip		= endip;
	this.leasetime  = leasetime;
}

function stDhcp(domain,ipAddress,macAddress)
{
    this.domain = domain;
    this.ipAddress = ipAddress;
	this.macAddress = macAddress;
}

function stipaddr(domain,ipaddr,subnetmask)
{
    this.domain     = domain;
    this.ipaddr     = ipaddr;
    this.subnetmask = subnetmask;
}

var LanHostInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress|IPInterfaceSubnetMask,stLanHostInfo);%>;
var LanHostInfo = LanHostInfos[0];

var MainDhcpRange = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,MinAddress|MaxAddress|DHCPLeaseTime,dhcpmainst);%>;

var DhcpStaticInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress.{i},Yiaddr|Chaddr,stDhcp);%>
var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress|IPInterfaceSubnetMask,stipaddr);%>;

DhcpStaticInfo.pop();
var UserDevInfo = GetUserDevInfoList();
UserDevInfo.pop();

var AddFlag = false;

function WriteHtml(id,obj)
{
	var htmlLines = '';
    var emptyValue = "--";
	if (obj.length >0)
	{
        setDisplay("ipv4dhcpnorules",0);
		for (var i = 0; i < obj.length; i++)
        {
            DeviceName = dhcp2_language['bbsp_NewDevice'];
            for(var j = 0; j < UserDevInfo.length; j++)
            {
                if(UserDevInfo[j].MacAddr == obj[i].macAddress)
                {
                    DeviceName = UserDevInfo[j].HostName;
                    break;
                }
            }
            if(obj[i].macAddress == "")
            {
                obj[i].macAddress = emptyValue;
            }
            if (obj[i].ipAddress == "")
            {
                obj[i].ipAddress = emptyValue;
            };
			htmlLines += "<tr class=\"showmaclist\"><td><div class=\"select\"><div id=\"ProtocolShow\" title =\""+htmlencode(DeviceName)+"\" class=\"select_default\">" + GetStringContentForTitle(htmlencode(DeviceName),18) + "</div></div></td>";
			htmlLines += "<td class =\"macaddr-td\">"+ htmlencode(obj[i].macAddress)+"</td>";
			htmlLines += "<td class=\"staticIP-tr\">" + htmlencode(obj[i].ipAddress)+ "</td>"
			htmlLines +="<td><img src=\"../../../images/button-delete-desktop.png\" class=\"imgbutton\" id = \"MacFiltering_"+ i +"\"  onclick = \"DeleteStaticDhcp(this.id)\"></td></tr>";
		}
        if ($('.showmaclist').length == 0)
        {
            $('#' + id).append(htmlLines);
        };

	}
    else
    {
        setDisplay("ipv4dhcpnorules",1);
    }
}
function changeUserName(obj)
{
    var text = obj.innerHTML;
    var dropdownShowId = "SelectUserdevice" + "show";
    $("#"+dropdownShowId).html(GetStringContentForTitle(text,15));
    var idvalue = obj.id;
    var temp = idvalue.split('_')[1];
    if( temp == 'a')
    {
        setAdrssStr('addmac',null,":",6);
        setAdrssStr('addip',null,".",4);
    }
    else
    {
        setAdrssStr('addmac',UserDevInfo[temp].MacAddr,":");
        if (UserDevInfo[temp].IpAddr != "")
        {
            setAdrssStr('addip',UserDevInfo[temp].IpAddr,".");
        }
        else
        {
            setAdrssStr('addip',null,".",4);
        }
    }
}


function changeLessTime(obj)
{
    var text = obj.innerHTML;
    var dropdownShowId = "maindhcpLeasedTimeFrag" + "show";
    $("#"+dropdownShowId).html(text);
}

function AddStaticIP()
{
	AddFlag = true;
	setDisplay('StaticDhcp',1);
    setDisplay('addStaticIP',0);
    setDisplay("ipv4dhcpnorules",0);
}

function DeleteStaticDhcp(id)
{
    var temp = id.split('_')[1];
    var Form = new webSubmitForm();
    Form.addParameter(DhcpStaticInfo[temp].domain,'');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('del.cgi?RequestFile=html/bbsp/dhcpservercfg/dhcp2Itvdf.asp');
    Form.submit();
}

function DisplayStaticDhcp()
{
	AddFlag = false;
	setDisplay('StaticDhcp',0);
	setDisplay('addStaticIP',1);
    $(".max2").val("");
    SetDivValue("SelectUserdeviceshow",dhcp2_language['bbsp_NewDevice']);
    if(DhcpStaticInfo.length == 0)
    {
        setDisplay("ipv4dhcpnorules",1);
    }
}
function SubmitIPV4()
{
    if (false == CheckFrom())
    {
        return false;
    }
    var Form = new webSubmitForm();
    var url = '';
    Form.addParameter('x.IPInterfaceIPAddress',ContentString(4,'LanHostInfoipaddr_',"."));
    Form.addParameter('z.MinAddress',ContentString(4,'startip_',"."));
    Form.addParameter('z.MaxAddress',ContentString(4,'endip_',"."));
    Form.addParameter('z.DHCPLeaseTime',getValue('MainLeasedTime')*getLease(getElement('maindhcpLeasedTimeFragshow').innerHTML));
    if(AddFlag == true)
    {
        Form.addParameter('Add_y.Yiaddr',ContentString(4,"addip","."));
        Form.addParameter('Add_y.Chaddr',ContentString(6,"addmac",":"));
        url = 'complex.cgi?'+ 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1'
                    + '&Add_y=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress'
                    + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                    + '&RequestFile=html/bbsp/dhcpservercfg/dhcp2Itvdf.asp';
    }
    else
    {
        url = 'complex.cgi?'+ 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1'
                    + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'
                    + '&RequestFile=html/bbsp/dhcpservercfg/dhcp2Itvdf.asp';
    }


	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction(url);
	Form.submit();
}

function CheckFrom()
{
	if (isValidIpAddress(ContentString(4,'LanHostInfoipaddr_',".")) == false)
	{
        AlertEx(dhcp2_language['bbsp_ipmhaddrp'] + ContentString(4,'LanHostInfoipaddr_',".") + dhcp2_language['bbsp_isinvalidp']);
		return false;
	}
	if (isValidIpAddress(ContentString(4,'startip_',".")) == false)
	{
		AlertEx(dhcp2_language['bbsp_secdhcpstartipinvalid']);
		return false;
	}
	if (isValidIpAddress(ContentString(4,'endip_',".")) == false)
	{
		AlertEx(dhcp2_language['bbsp_secdhcpendipinvalid']);
		return false;
	}
    if(!(isEndGTEStart(ContentString(4,'endip_',"."), ContentString(4,'startip_',"."))))
    {
        AlertEx(dhcp2_language['bbsp_priendipgeqstartip']);
        return false;
    }
}

function getLease(timestring)
{
    var timenum = "";
    if (dhcp2_language['bbsp_minute'] == timestring)
    {
        timenum = 60;
    }
    else if(dhcp2_language['bbsp_hour'] == timestring )
    {
        timenum = 3600;
    }
    else if(dhcp2_language['bbsp_day'] == timestring )
    {
        timenum = 86400;
    }
    else if (dhcp2_language['bbsp_week'] == timestring)
    {
        timenum = 604800;
    }
    else
    {
        return;
    }
    return  timenum;
}

function setLease(dhcpLease)
{
    var i = 0;
    var timeUnits = [604800,86400,3600,60];
    var timesarr = [dhcp2_language['bbsp_week'],dhcp2_language['bbsp_day'],dhcp2_language['bbsp_hour'],dhcp2_language['bbsp_minute']];
    var infinite = ((dhcpLease == "-1") || (dhcpLease == "4294967295"));
    var timeUstr = 60;
    var timestr = dhcp2_language['bbsp_minute'];
    for(i = 0; i < 4; i++)
    {
        if ( true == isInteger(dhcpLease / timeUnits[i]) )
        {
            timeUstr = timeUnits[i];
            timestr = timesarr[i];   
            break;
        }
    }

    SetDivValue('maindhcpLeasedTimeFragshow', timestr);
    if(infinite)
    {
        setText('MainLeasedTime', dhcp2_language['bbsp_infinitetime']);
    }
    else
    {
        setText('MainLeasedTime', dhcpLease / timeUstr);
    }
}

function LoadFrame()
{
    setAdrssStr('LanHostInfoipaddr_',LanHostInfo.ipaddr,".");
    setAdrssStr('startip_',MainDhcpRange[0].startip,".");
    setAdrssStr('endip_',MainDhcpRange[0].endip,".");
    SetDivValue('IPSubnetMask',LanHostInfo.subnetmask);
    setLease(MainDhcpRange[0].leasetime);
    InputSkip(2,editmac);
    InputSkip(3,editip);
    InputSkip(3,LanhostIP);
    WriteHtml("showlist",DhcpStaticInfo);
    IputChangeValue();
}
function CancelConfig()
{
	LoadFrame();
    AddFlag = false;
    setDisplay('StaticDhcp',0);
    setDisplay('addStaticIP',1);
    $(".max2").val("");
    SetDivValue("SelectUserdeviceshow",dhcp2_language['bbsp_NewDevice']);
}
function IputChangeValue()
{
    $('#LanHostInfoipaddr_0').bind('input propertychange',function()
    {
        var InputValue = getValue('LanHostInfoipaddr_0');
        setText('startip_0',InputValue);
        setText('endip_0',InputValue);
    });
    $('#LanHostInfoipaddr_1').bind('input propertychange',function()
    {
        var InputValue = getValue('LanHostInfoipaddr_1');
        setText('startip_1',InputValue);
        setText('endip_1',InputValue);
    });
    $('#LanHostInfoipaddr_2').bind('input propertychange',function()
    {
        var InputValue = getValue('LanHostInfoipaddr_2');
        setText('startip_2',InputValue);
        setText('endip_2',InputValue);
    });

}
</script>
</head>
<body onLoad="LoadFrame();" class="ipv4class">
<div id="ConfigForm" class="IPV4">
	<div>
        <h1>
            <script>document.write(dhcp2_language['bbsp_ITVDF_IPV4']);</script>
        </h1>
	    <h2>
	        <span BindText="bbsp_ITVDF_subtilte"></span>
	    </h2>
	    <div class="IPV4-div">
			<div>
			    <h3 BindText="bbsp_ITVDF_Network"></h3>
			    <div class="row row-title">
			    	<span BindText="bbsp_ITVDF_Nethome"></span>
			    </div>
			    <div class="row">
			    	<div class="row-border">
				    	<div>
				    		<span class="ipv4span" BindText="bbsp_ITVDF_IPAddress"></span>
				    	</div>
				    	<div id="LanhostIP">
				    		<input type="text" value="" size="3" tabindex="1" maxlength="3" class="max3" id="LanHostInfoipaddr_0">.
				    		<input type="text" value="" size="3" tabindex="2" maxlength="3" class="max3" id="LanHostInfoipaddr_1">.
				    		<input type="text" value="" size="3" tabindex="3" maxlength="3" class="max3" id="LanHostInfoipaddr_2">.
				    		<input type="text" value="" size="3" tabindex="4" maxlength="3" class="max3" id="LanHostInfoipaddr_3">
				    	</div>
			    	</div>
			    </div>
			    <div class="row row-title row-border" style="padding-left:10px">
			    	<span class="ipv4span" BindText="bbsp_ITVDF_IPSubnetMask"></span>
			    	<div id="IPSubnetMask" style="padding-left:0">

			    	</div>
			    </div>
		    </div>
		    <div>
		    	<h3 BindText="bbsp_ITVDF_DHCPSParmeters"></h3>
			    <div class="row row-title">
			    	<span BindText="bbsp_ITVDF_Nethome"></span>
			    </div>
			    <div class="row">
			    	<div class="row-border">
				    	<div>
				    		<span class="ipv4span" BindText="bbsp_ITVDF_Addressstart"></span>
				    	</div>
				    	<div id="editstartip">
				    		<input type="text" size="3" tabindex="1" maxlength="3" value="" class="max3" readonly="readonly" id="startip_0">.
				    		<input type="text" size="3" tabindex="2" maxlength="3" value="" class="max3" readonly="readonly" id="startip_1">.
				    		<input type="text" size="3" tabindex="3" maxlength="3" value="" class="max3" readonly="readonly" id="startip_2">.
				    		<input type="text" size="3" tabindex="4" maxlength="3" value="" class="max3" id="startip_3">
				    	</div>
			    	</div>
			    </div>
			    <div class="row">
			    	<div class="row-border">
				    	<div>
				    		<span class="ipv4span" BindText="bbsp_ITVDF_AddressEnd"></span>
				    	</div>
				    	<div id="editendip">
				    		<input type="text" size="3" tabindex="1" maxlength="3" value="" class="max3" readonly="readonly" id="endip_0">.
				    		<input type="text" size="3" tabindex="2" maxlength="3" value="" class="max3" readonly="readonly" id="endip_1">.
				    		<input type="text" size="3" tabindex="3" maxlength="3" value="" class="max3" readonly="readonly" id="endip_2">.
				    		<input type="text" size="3" tabindex="4" maxlength="3" value="" class="max3" id="endip_3">
				    	</div>
			    	</div>
			    </div>
			    <div class="row row-border">
			    	<div>
				    	<span class="ipv4span" BindText="bbsp_ITVDF_LeaseTime"></span>
				    	<table>
				    		<tr>
				    			<td>
					    			<div class="select" style="float:left;">
					    				<input type="text" id="MainLeasedTime">
					    			</div>
								    <div class="ipv4dropdownSelect" id="selectLeasedTime" style="float: left;margin-left:10px">
                                        <script type="text/javascript">
                                            $('#selectLeasedTime').css("position","relative");
                                            $('#selectLeasedTime').html('<div id="maindhcpLeasedTimeFrag" class="IframeDropdown"></div>');
                                            var Timearr = [dhcp2_language['bbsp_minute'],dhcp2_language['bbsp_hour'],dhcp2_language['bbsp_day'],dhcp2_language['bbsp_week']];
                                            var DefaultValue = dhcp2_language['bbsp_minute'];
                                            BbspCreateDropdown("maindhcpLeasedTimeFrag", DefaultValue, "178px", Timearr, "changeLessTime(this);",false,20);
                                        </script>

								    </div>
				    			</td>
				    		</tr>
				    	</table>
			    	</div>
			    </div>
		    </div>
		    <div>
		    	<h3 BindText="bbsp_ITVDF_StaticDHCP"></h3>
		    	<table border="0" id='showlist' style="margin-left:10px;">
					<tr class="ipv4span" style="border-bottom: 1px solid #e6e6e6;">
						<td class="ipv6-font-size" style="width:184px" BindText='bbsp_hostname'></td>
						<td class="ipv6-font-size" style="width:259px" BindText='bbsp_macaddress'></td>
						<td class="ipv6-font-size" style="width:180px" BindText='bbsp_ip'></td>
						<td class="ipv6-font-size" style="width:47px"></td>
				    </tr>
                    <tr id="ipv4dhcpnorules">
                        <td></td>
                        <td BindText='bbsp_no_devices' style="font-style:italic;font-weight:normal"></td>
                        <td></td>
                        <td></td>
                    </tr>
		    	</table>
		    	<table style="margin-left:10px">
					<tr id="StaticDhcp" style="display:none">
						<td style="width:184px" id="droplist">
                            <script type="text/javascript">
                                $('#droplist').css("position","relative");
                                $('#droplist').html('<div class="iframeDropLog"><div id="SelectUserdevice" class="IframeDropdown"></div></div>');
                                var arr = new Array();
                                for (var i = 0; i < UserDevInfo.length; i++)
                                {
                                    var temparr = htmlencode(UserDevInfo[i].HostName);
                                    arr.push(temparr);
                                };
                                var DefaultValue = dhcp2_language['bbsp_NewDevice'];
                                BbspCreateDropdown("SelectUserdevice", DefaultValue, "184px", arr, "changeUserName(this);",true,15);
                            </script>
						</td>
						<td class="macaddr-td" style="width:259px" id="editmac">
							<input type="text" class="max2" name="mac1" value="" id="addmac0" maxlength="2">:<input type="text" class="max2" value="" name="mac2" id="addmac1" maxlength="2">:<input type="text" name="mac3" class="max2" value="" id="addmac2" maxlength="2">:<input type="text" class="max2" value="" name="mac4" id="addmac3" maxlength="2">:<input type="text" class="max2" name="mac5" value="" id="addmac4" maxlength="2">:<input type="text" class="max2" id="addmac5" name="mac6" value="" maxlength="2">
						</td>
						<td class="staticIP-tr" style="width:180px" id="editip">
							<input type="text" class="max2" name="mac1" value="" id="addip0" maxlength="3" >.<input type="text" class="max2" value="" name="mac2" id="addip1" maxlength="3">.<input type="text" name="mac3" class="max2" value="" id="addip2" maxlength="3">.<input type="text" class="max2" value="" name="mac4" id="addip3" maxlength="3">
						</td>
						<td style="width:47px">
							<img src="../../../images/button-delete-desktop.png" class="imgbutton" id="MacFiltering_0" onclick="DisplayStaticDhcp()">
						</td>
					</tr>
		    	</table>
		    	<table>
		    		<tr>
		    			<td style="width:680px"></td>
		    			<td>
		    				<img src="../../../images/button-add-desktop.png" id="addStaticIP" class="imgbutton" value="" type="button" onclick="AddStaticIP();">
		    			</td>
		    		</tr>
		    	</table>
		    </div>
	    </div>
    </div>
    <div style="text-align:right;height:50px;">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <button id="cancelButton" class="button button-cancel ButtonApply" onclick="CancelConfig()">
            <script>document.write(dhcp2_language['bbsp_cancel']);</script>
        </button>
        <button id="btnApplydlna" class="button button-apply saveButton ButtonCancel"  onClick="SubmitIPV4()">
            <script>document.write(dhcp2_language['bbsp_app']);</script>
        </button>
	</div>
    <div id="showhight"></div>
</div>
<script type="text/javascript">
    ParseBindTextByTagName(dhcp2_language, "div",  1);
    ParseBindTextByTagName(dhcp2_language, "td",  1);
    ParseBindTextByTagName(dhcp2_language, "span",  1);
    ParseBindTextByTagName(dhcp2_language, "input", 2);
    ParseBindTextByTagName(dhcp2_language, "th", 1);
    ParseBindTextByTagName(dhcp2_language, "h3", 1);
</script>
</body>
</html>
