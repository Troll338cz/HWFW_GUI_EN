<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>DHCP Configure</title>
<link rel="stylesheet"  href='/Cuscss/<%HW_WEB_CleanCache_Resource(gateway.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>

<style type="text/css">
	input.messageInput{
		display:inline-block;
		width:150px;
		color: #666666;
		padding:0px;
		text-align:center;
		background-color: inherit;
	}
	input[disabled]{
		color: #666666;
		background-color: inherit;
		border-width:0px;
	}
    .btn-default-orange-small{
        margin-top:0px;
        margin-bottom:0px;
        padding-top:0px;
        padding-bottom:0px;
        outline:none;
    }
    button[disabled].btn-default-orange-small,button[disabled].btn-default-orange-small span{
        background-color:#999999;
    }
	
	td {
		text-align: center;
	}
	#reservationList input {
        background-color: transparent;
        border:0 solid #e4e4e4;  
    }
	
</style>

<script language="JavaScript" type="text/javascript">

var RequestFile = 'html/bbsp/dhcpservercfg/dhcp2Tlf.asp';

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
		b.innerHTML = dhcp2_language[b.getAttribute("BindText")];
	}
}

function stLanHostInfo(domain,enable,ipaddr,subnetmask)
{
	this.domain = domain;
	this.enable = enable;
	this.ipaddr = ipaddr;
	this.subnetmask = subnetmask;
}

function dhcpmainst(domain,enable,startip,endip,leasetime,MainDNS,DNSServers)
{
	this.domain 	= domain;
	this.enable		= enable;
	this.startip	= startip;
	this.endip		= endip;
	this.leasetime  = leasetime;
	MainDNS = (MainDNS == "")?DNSServers:MainDNS;
	if(MainDNS == "")
	{
		this.MainPriDNS	= "";  
		this.MainSecDNS = "";
	}
	else
	{
		var MainDnss 	= MainDNS.split(',');
		this.MainPriDNS	= MainDnss[0];  
		this.MainSecDNS  = MainDnss[1];
		if (MainDnss.length <=1)
		{
		    this.MainSecDNS = "";
		}
	}
}

function stDhcp(domain,Enable,ipAddress,macAddress)
{
    this.domain = domain;
	this.Enable = Enable;
    this.ipAddress = ipAddress;
	this.macAddress = macAddress;
}

var AccessClass = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_AccessCtrl.AccessClass);%>';	

var LanHostInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,stLanHostInfo);%>;

var MainDhcpRange = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,DHCPServerEnable|MinAddress|MaxAddress|DHCPLeaseTime|X_HW_DNSList|DNSServers,dhcpmainst);%>; 

var Dhcps = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress.{i},Enable|Yiaddr|Chaddr,stDhcp);%>

var LanHostInfo = LanHostInfos[0];

	function LoadFrame()
	{
		loadlanguage();

		if (AccessClass.toUpperCase() == "SERVICE02"){

			$('#setDHCPMessage input').attr('disabled', true);
			setDisable('cancelBtn',1);
			setDisable('saveBtn',1);	
		}
		else{
			$('#routerIPAddress input').attr('disabled', true);
			$('#netMask input').attr('disabled', true);
			setDisable("leaseTime", 1);
		}		
		
		GetLanUserInfo(function(userDhcpInfo, userDevInfo)
		{
			getHostNameList(userDevInfo);
			getRelateMac();
			initReservationList(userDevInfo);		
			initLeaseTable(userDhcpInfo);
		});	
        setIPIntervelToTab('minAddress');
        setIPIntervelToTab('maxAddress');
        setIPIntervelToTab('primaryDNSServer');
        setIPIntervelToTab('secondaryDNSServer');
        setIPIntervelToTab('iPAddressID');
	}
	
	$(document).ready(function(){
	});

    function setIPIntervelToTab(id)
    {
        $('#'+id+' input.router').keypress(function(e){
            e = e||event;
            var curKey = e.keyCode||e.which||e.charCode;
            var value = String.fromCharCode(curKey);
            if(value == '.'){
                var inputs = $('#'+id+' input.router');
                var curindex = inputs.index(this);
                if(curindex == inputs.length-1){
                    inputs[0].focus();
                }else{
                    inputs[curindex+1].focus();
                }
                return false;
            }
        });
    }
	
	function setDHCP($this)
	{
		if ($this.id=='DHCP_enabled') {
				document.getElementById("DHCP_disabled").checked = false;
				document.getElementById("DHCP_enabled").checked = true
		}
		else if($this.id=='DHCP_disabled'){
				document.getElementById("DHCP_enabled").checked = false;
				document.getElementById("DHCP_disabled").checked = true
		}
	}
	
	function UpdateDNS($this)
	{  
		if ($this.id=='input_dns_enabled') {
				document.getElementById("tr_custom_dns_primary").style.display = "";
				document.getElementById("tr_custom_dns_secondary").style.display = "";
				document.getElementById("input_dns_disabled").checked = false;
				document.getElementById("input_dns_enabled").checked = true
		}
		else if($this.id=='input_dns_disabled'){
				document.getElementById("input_dns_enabled").checked = false;
				document.getElementById("input_dns_disabled").checked = true
				$('#tr_custom_dns_primary input').each(function(){
					$(this).val('');
				});
				$('#tr_custom_dns_secondary input').each(function(){
					$(this).val('');
				});
				document.getElementById("tr_custom_dns_primary").style.display = "none";
				document.getElementById("tr_custom_dns_secondary").style.display = "none";
		}
	} 
</script>

<script>	
	function ipConnectInput(id)
	{
		var str = '';
		$('#'+id).children('input').each(function(){
			str += ($(this).val()) ? $(this).val()+'.' : $(this).val();
		});
		str = str.substr(0,str.length-1);
		return str;
	}
	
	function CheckDhcpForm()
	{
		var mainstartipaddr = ipConnectInput('minAddress');
		var ethSubnetMask = ipConnectInput('netMask');
		var ethIpAddress = ipConnectInput('routerIPAddress');
		var mainendipaddr = ipConnectInput('maxAddress');
		var primaryDNSServer = '';
		var secondaryDNSServer = '';
		var primaryDNSServer = ipConnectInput('primaryDNSServer');
		var secondaryDNSServer = ipConnectInput('secondaryDNSServer');


        if (isValidIpAddress(mainstartipaddr) == false)
        {
            AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid']);
            return false;
        }

        if (isBroadcastIp(mainstartipaddr, LanHostInfo.subnetmask) == true)
        {
            AlertEx(dhcp2_language['bbsp_pridhcpstipinvalid']);
            return false;
        }

        if (false == isSameSubNet(mainstartipaddr,LanHostInfo.subnetmask,LanHostInfo.ipaddr,LanHostInfo.subnetmask))
        {
            AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost']);
            return false;
        }

        if (isValidIpAddress(mainendipaddr) == false) 
        {
            AlertEx(dhcp2_language['bbsp_dhcpendipinvalid']);
            return false;
        }

        if(isBroadcastIp(mainendipaddr, LanHostInfo.subnetmask) == true)
        {
            AlertEx(dhcp2_language['bbsp_dhcpendipinvalid']);
            return false;
        }

        if (false == isSameSubNet(mainendipaddr,LanHostInfo.subnetmask,LanHostInfo.ipaddr,LanHostInfo.subnetmask))
        {
            AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost']);
            return false;
        }

        if (!(isEndGTEStart(mainendipaddr, mainstartipaddr))) 
        {
            AlertEx(dhcp2_language['bbsp_priendipgeqstartip']);
            return false;
        }

		if ( primaryDNSServer != '' && (isValidIpAddress(primaryDNSServer) == false || isAbcIpAddress(primaryDNSServer) == false))
		{
		    AlertEx(dhcp2_language['bbsp_pripoolpridnsinvalid']);
		    return false;
		}

		if ( secondaryDNSServer != '' && (isValidIpAddress(secondaryDNSServer) == false || isAbcIpAddress(secondaryDNSServer) == false))
		{
			AlertEx(dhcp2_language['bbsp_pripoolsecdndinvalid']);
			return false;
		}


        if (false == isSameSubNet(mainstartipaddr,ethSubnetMask,ethIpAddress,ethSubnetMask)){
            AlertEx(dhcp2_language['bbsp_pridhcpstipmustsamesubhost']);
            return false;
        }

        if (false == isSameSubNet(mainendipaddr,ethSubnetMask,ethIpAddress,ethSubnetMask)){
            AlertEx(dhcp2_language['bbsp_pridhcpedipmustsamesubhost']);
            return false;
        }

        if (!(isEndGTEStart(mainendipaddr, mainstartipaddr))){
            AlertEx(dhcp2_language['bbsp_priendipgeqstartip']);
            return false;
        }

		return true;
	}
	
	function AddSubmitParam()
	{		
		if(!CheckDhcpForm())
		{
			return;
		}
		var dhcpServerEnable;
		if(document.getElementById("DHCP_disabled").checked==true){
			dhcpServerEnable = 0;
		}else if(document.getElementById("DHCP_enabled").checked==true){
			dhcpServerEnable = 1;
		}
		
		var minAddress = ipConnectInput('minAddress');
		var maxAddress = ipConnectInput('maxAddress');
		var primaryDNSServer = '';
		var secondaryDNSServer = '';
		if(document.getElementById("input_dns_enabled").checked == true){
			primaryDNSServer = ipConnectInput('primaryDNSServer');
			secondaryDNSServer = ipConnectInput('secondaryDNSServer');
		}

		setDisable('cancelBtn',1);
		setDisable('saveBtn',1);
		
		var DnsMStr = primaryDNSServer + ',' + secondaryDNSServer;
		if ( primaryDNSServer == ''){
			DnsMStr = secondaryDNSServer;
		}
		if ( secondaryDNSServer == ''){
			DnsMStr = primaryDNSServer;
		} 
		
		var ConfigParaList = new Array(new stSpecParaArray('x.MinAddress', minAddress, 0),
									  new stSpecParaArray('x.MaxAddress',maxAddress, 0),
									  new stSpecParaArray('x.DHCPServerEnable', dhcpServerEnable, 0),
									  new stSpecParaArray('x.X_HW_DNSList',DnsMStr, 0));

		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'set.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement'+'&RequestFile=' + RequestFile;			
		HWSetAction(null, ConfigUrl, Parameter, getValue('onttoken'));
	}
	
	function cancelConfig()
	{
		LoadFrame();
		initDhcpServerInfo();
	}
</script>

<script>
	$(document).ready(function(){
		initDhcpServerInfo();
	});
	function setIpMessage(obj,message){
		var list = message.split('.');
		obj.each(function(index){
			$(this).val(list[index]);
		});
	}	
	
	function initDhcpServerInfo()
	{
		if (1 == MainDhcpRange[0].enable){
			setDHCP($('#DHCP_enabled')[0]);
		}
		else{
			setDHCP($('#DHCP_disabled')[0]);
		}
		if ((MainDhcpRange[0].MainPriDNS == '') && (MainDhcpRange[0].MainSecDNS == '')){
			UpdateDNS($('#input_dns_disabled')[0]);
		}
		else{
			UpdateDNS($('#input_dns_enabled')[0]);
			setIpMessage($('#primaryDNSServer input'), MainDhcpRange[0].MainPriDNS);
			setIpMessage($('#secondaryDNSServer input'), MainDhcpRange[0].MainSecDNS);
		}
		setIpMessage($('#routerIPAddress input'), LanHostInfos[0].ipaddr);
		setIpMessage($('#netMask input'), LanHostInfos[0].subnetmask);
		setIpMessage($('#minAddress input'), MainDhcpRange[0].startip);
		setIpMessage($('#maxAddress input'), MainDhcpRange[0].endip);
		setText("leaseTime", parseInt(MainDhcpRange[0].leasetime)/60+'');
	}
	
	function inputSet(obj,key,value)
	{
		obj.each(function(){
			if(key=='disabled'){
				$(this).attr(key,value);
				if(value==true){
					$(this).css({'border-width':'0px'});
					
				}else{
					$(this).css({'border-width':'1.8px'});
				}
			}
		});	
	}
	
	var macReserveList = new Array();
	function getHostNameList(userDevices)
	{
		for(var i=0;i<userDevices.length - 1;i++){
			
			if ("ONLINE" == userDevices[i].DevStatus.toUpperCase()){
				continue;
			}
			$('#hostNameID').append('<option title ="' + htmlencode(userDevices[i].HostName)
				+'" value="'+userDevices[i].MacAddr+'">'+GetStringContent(htmlencode(userDevices[i].HostName),18)+'</option>');			
		}
	}

	function getRelateMac()
	{
		var macAddr = $('#hostNameID').val();
        if (macAddr == null)
        {
            macAddr = '';
        }
		setText("macAddressID", macAddr);
	}
	
	function checkReserverIP(macAddress, ipAddress)
	{		
		if (ipAddress == "...") 
		{
		    AlertEx(arp_language['bbsp_ipisreq']);
			return false;
		}    

		if (macAddress == "")
		{
		    AlertEx(arp_language['bbsp_macisreq']);
			return false;
		}

		if((isAbcIpAddress(ipAddress) == false) || (isDeIpAddress(ipAddress) == true) 
	       || (isBroadcastIpAddress(ipAddress) == true) || (isLoopIpAddress(ipAddress) == true) )
		{
		    AlertEx(arp_language['bbsp_ipaddr']+ ipAddress + arp_language['bbsp_invalid']);
			return false;
		}

		if(("1" == "<%HW_WEB_GetFeatureSupport(HW_FT_DHCP_CHECK_STATIC_ARP);%>")
			&& (true == PS_CheckReserveIP("checkDhcp", ipAddress, macAddress)))
		{            
			AlertEx(dhcpstatic_language['bbsp_ipconflict']);
			return false;
		}

		return true;
	}
	
	function reserveIPSubmit()
	{	
		var macAddress = getValue("macAddressID");
		var ipAddress;
		var str = '';
		
		$('#iPAddressID input').each(function(){
			str += $(this).val()+'.';
		});
		ipAddress = str.substr(0,str.length-1);

		if (Dhcps.length >= 16 )
		{
			AlertEx(dhcpstatic_language['bbsp_num']);
			return;
		}
		
		if(!checkReserverIP(macAddress, ipAddress)){
			return;
		}		

		var ConfigParaList = new Array(new stSpecParaArray("x.Yiaddr",ipAddress , 1),
								   	   new stSpecParaArray("x.Chaddr",macAddress, 1),
		                               new stSpecParaArray("x.Enable","1", 1));

		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'add.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress'+'&RequestFile=' + RequestFile;							  
		HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));	
	}
</script>

<script>	
	function getHostNameByMac(userDevices, macAddress)
	{
		for(var i = 0; i < userDevices.length - 1; i++){
			if (userDevices[i].MacAddr == macAddress){
				return userDevices[i].HostName;
			}
		}
		
		return '--';
	}

	function initReservationList(userDevices)
	{
		$('#reservationList tbody').html('');
		var reservationListTr = '';
		var actionDiv = '<div class="actions" align="center">'
							+'<a class="action edit"><img class="img-actions" src="../../../images/edit2.gif" onclick="editReservation(this)"></a> '
							+'<a class="action delete"><img class="img-actions" src="../../../images/trash.gif" onclick="deleteReservation(this)"></a>' 
						+'</div>';
		if (Dhcps.length <= 1){
			return;
		}
		
		for(var i=0;i< Dhcps.length - 1;i++){
			var hostname = htmlencode(getHostNameByMac(userDevices, Dhcps[i].macAddress));
			var tdclass = (i%2==0) ? "cinza" : "cinza2";
			reservationListTr += '<tr>'
								+'<td class="'+tdclass+'"><input class="messageInput" value="'+GetStringContent(hostname) +'" title="' +hostname +'"></td>'
								+'<td class="'+tdclass+'"><input class="messageInput edit" value="'+Dhcps[i].macAddress+'"></td>'
								+'<td class="'+tdclass+'"><input class="messageInput edit" value="'+Dhcps[i].ipAddress+'"></td>'
								+'<td class="'+tdclass+'">'+actionDiv+'</td>'
								+'</tr>';
		}
		$('#reservationList tbody').html(reservationListTr);
		inputSet($('#reservationList tbody input.messageInput'),'disabled',true);
	}
	
	function editReservation(obj)
	{
		var curRow = $(obj).parent().parent().parent().parent().children('td');		

		if($(curRow.children('input.messageInput.edit')[0]).attr('disabled')=='disabled'){
			$(obj).attr('src','../../../images/ok.gif');
			inputSet(curRow.children('input.messageInput.edit'),'disabled',false);
			curRow.children('input.messageInput.edit').css({"border":"1px solid rgb(168, 166, 166)", "background":"#fff"});
		}else{			
			
			var hostName = $(curRow.children('input.messageInput')[0]).val();
			var macAddress = $(curRow.children('input.messageInput')[1]).val();
			var ipAddress = $(curRow.children('input.messageInput')[2]).val();
			var index = $(obj).parent().parent().parent().parent().index();

			if(!checkReserverIP(macAddress, ipAddress)){
				return;
			}
			$(obj).attr('src','../../../images/edit2.gif');
			inputSet(curRow.children('input.messageInput.edit'),'disabled',true);
			curRow.children('input.messageInput.edit').css({"border":"0 solid #e4e4e4", "background-color":"transparent"});
			
			
			var ConfigParaList = new Array(new stSpecParaArray("x.Yiaddr",ipAddress , 0),
 										   new stSpecParaArray("x.Chaddr",macAddress, 0));

			var Parameter = {};	
			Parameter.OldValueList = null;
			Parameter.FormLiList = null;
			Parameter.UnUseForm = true;
			Parameter.asynflag = false;
			Parameter.SpecParaPair = ConfigParaList;
			var ConfigUrl = 'set.cgi?x=' + Dhcps[index].domain + '&RequestFile=' + RequestFile;							  
			HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));	
		}		
	}
	
	function deleteReservation(obj)
	{
		var curRow = $(obj).parent().parent().parent().parent();
		var index = $(obj).parent().parent().parent().parent().index();
		
		var ConfigParaList = [];
		ConfigParaList.push(new stSpecParaArray(Dhcps[index].domain,'' , 0));
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'del.cgi?x=' + 'InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPStaticAddress' +'&RequestFile=' + RequestFile;							  
		HWSetAction(null, ConfigUrl, Parameter, getValue("onttoken"));		
	}
</script>

<script>
	$(document).ready(function(){
		
	});

	function initLeaseTable(dhcpInfos)
	{
		$('#leaseTable tbody').html('');
		var leaseTable = '';
		if (dhcpInfos.length <= 1){
			return;
		}
		
		for(var i=0;i< dhcpInfos.length - 1;i++){
			if(0 == dhcpInfos[i].remaintime){
				continue;
			}
			
			var tdclass = (i%2==0) ? "cinza" : "cinza2";
			leaseTable += '<tr>'
			                +'<td title="'+htmlencode(dhcpInfos[i].name)+'"class="'+tdclass+'"><div align="center">'+GetStringContent(htmlencode(dhcpInfos[i].name),20)+'</div></td>'
 			  				+'<td class="'+tdclass+'"><div align="center">'+dhcpInfos[i].mac+'</div></td>'
							+'<td class="'+tdclass+'"><div align="center">'+dhcpInfos[i].ip+'</div></td>'
							+'<td class="'+tdclass+'"><div align="center">'+Math.floor(parseInt(dhcpInfos[i].remaintime, 10)/60)+' min'+'</div></td>'
						 +'</tr>';
		}
		$('#leaseTable tbody').html(leaseTable);
	}
</script>

</head>
<body onLoad="LoadFrame();" class="mainbody"> 
	<div id="tab-01" class="tab" style="display:block;">
					<table id="setDHCPMessage" class="setupWifiTable">
						<thead>
							<th colspan="2" BindText="bbsp_DHCP"></th>
						</thead>
						<tbody>
							<tr>
								<td colspan="2" ><span BindText="bbsp_configureIPinfo" ></span></td>
							</tr>
							<tr>
								<td><span BindText="bbsp_DHCPServer"></span></td>
								<td>
									<input type="radio" name="" id="DHCP_enabled"  value="0" onclick="setDHCP(this)"/><span BindText="bbsp_DHCP_enabled"></span>
									<input type="radio" name="" id="DHCP_disabled" value="1" onclick="setDHCP(this)"/> <span BindText="bbsp_DHCP_disabled" ></span>
								</td>
							</tr>
							<tr>
								<td><span BindText="bbsp_RouterIP"></span></td>
								<td id="routerIPAddress">
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</td>
							</tr>
							<tr>
								<td><span BindText="bbsp_netmask"></span></td>
								<td id="netMask">
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</td>
							</tr>
							<tr>
								<td rowspan="2"><span BindText="bbsp_addrrange"></span></td>
								<td id="minAddress">
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</td>
							</tr>
							<tr>
								<td id="maxAddress" class="second">
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</td>
							</tr>
							<tr id="tr_dns">
							<td><span BindText="bbsp_specificDNS"></span></td>
							<td>
								<input type="radio" name="input_dns_enabled" id="input_dns_enabled"  onclick="UpdateDNS(this)" /> <span BindText="bbsp_input_dns_enabled"></span>
								<input type="radio" name="input_dns_disabled" id="input_dns_disabled"  onclick="UpdateDNS(this)" /> <span BindText="bbsp_input_dns_disabled"></span>
							</td>
						</tr>
						<tr id="tr_custom_dns_primary">
								<td><span BindText="bbsp_primaryDNSServer"></span></td>
								<td id="primaryDNSServer">
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</td>
							</tr>
						<tr id="tr_custom_dns_secondary">
								<td BindText="bbsp_secondaryDNSServer"></td>
								<td id="secondaryDNSServer">
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</td>
							</tr>
							<tr>
								<td ><span BindText="bbsp_dhcpleasetime"></span></td>
								<td><input id="leaseTime" name="" class="router2" maxlength="9"/> <span BindText="bbsp_dhcpleasetimemin"></span></td>
							</tr>
							<tr>
								<td colspan="3" class="cinza">
									<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 	
									<input type="button" class="btn-default-orange-small right" id="cancelBtn" BindText="bbsp_cancelConfig" onclick="cancelConfig()"></input>
									<input type="button" class="btn-default-orange-small right" id="saveBtn" BindText="bbsp_AddSubmitParam"  onclick="AddSubmitParam()"></input>
								</td>
							</tr>
						</tbody>
					</table>				
					
					<table id="IPReservation" class="setupWifiTable">
						<thead>
							<tr>
								<th colspan="3" BindText="bbsp_createIPreservation"></th>
							</tr>
							<tr>
								<th BindText="createHostname"></th>
								<th BindText="createMAC"></th>
								<th BindText="createIP"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><select name="" id="hostNameID" onchange="getRelateMac()"></select></td>
								<td><div align="center"><input name="" type="text" id="macAddressID" maxlength="17" width="10px"></div></td>
								<td id="iPAddressID"><div align="center">
									<input name="" class="router" maxlength="3"/> .
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/> . 
									<input name="" class="router" maxlength="3"/>
								</div></td>						
							</tr>
							<tr>
								<td colspan="3">
								<a href="#" class="btn-default-orange-small right" onclick="reserveIPSubmit()" BindText="bbsp_reserveIPSubmit"></a>
								</td>
							</tr>
						</tbody>
					</table>
					
					<table id="reservationList" class="setupWifiTable">
						<thead>
							<tr>
								<th colspan="4" BindText="bbsp_reservationhostlist"></th>
							</tr>
							<tr>
								<th BindText="bbsp_reservationhostname"></th>
								<th BindText="bbsp_reservationMAC"></th>
								<th BindText="bbsp_reservationIP"></th>
								<th BindText="bbsp_reservationaction"></th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					
					<table id="leaseTable" class="setupWifiTable">
						<thead>
							<tr>
								<th colspan="4" BindText="bbsp_leaseTable"></th>
							</tr>
							<tr>
								<th BindText="bbsp_leaseHostname"></th>
								<th BindText="bbsp_leaseMAC"></th>
								<th BindText="bbsp_leaseIP"></th>
								<th BindText="bbsp_leasetimeremain"></th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
	<script>
		ParseBindTextByTagName(dhcp2_language, "a", 1);
		ParseBindTextByTagName(dhcp2_language, "td", 1);
		ParseBindTextByTagName(dhcp2_language, "th", 1);
		ParseBindTextByTagName(dhcp2_language, "span", 1);
		ParseBindTextByTagName(dhcp2_language, "input", 2);
	</script>
</body>
</html>
