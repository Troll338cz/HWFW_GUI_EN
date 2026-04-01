<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title></title>
	<link href="/Cuscss/<%HW_WEB_GetCusSource(bootstrap.min.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(portal.css);%>"  media="all" rel="stylesheet" />
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(bootstrap.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
	<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<style>
input::-ms-clear{
display:none;
}
input::-ms-reveal{
display:none;
}

</style>

	<script>
		self.parent.FristLogin = 1;
		var IPInfo = "";
		var MaskInfo = "";
		var IPv4Gateway = "";
		var DNSAIPInfo = "";
		var DNSSIPInfo = "";
		var DNSInfo = "";
		var DomainInfo = "";

		var portalAPType = '<%HW_WEB_GetApMode();%>';
		var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
		if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
		{
			window.location='/login.asp'; 
		}
		
		function CheckParameter()
		{
			IPInfo = getValue("IPPortalInput");
			MaskInfo = getValue("MaskPortalInput");
			IPv4Gateway = getValue("OntIPPortalInput");
			DNSAIPInfo = getValue("DNSAPortalInput");
			DNSSIPInfo = getValue("DNSSPortalInput");
			
			if(MaskInfo == '')
			{
				self.parent.AlertInfo(PortalguideDes['p0159']);
				return false;
			}
			
			if (isValidIpAddress(IPInfo) == false || isAbcIpAddress(IPInfo) == false)
			{
				self.parent.AlertInfo(PortalguideDes['p0160']);
				return false;
			}
			
			if (isValidSubnetMask(MaskInfo) == false)
			{
				self.parent.AlertInfo(PortalguideDes['p0161']);
				return false;
			}
			
			if (DNSAIPInfo != '' && (isValidIpAddress(DNSAIPInfo) == false || isAbcIpAddress(DNSAIPInfo) == false))
			{
				self.parent.AlertInfo(PortalguideDes['p0162']);
				return false;
			}
			
			if (DNSSIPInfo != '' && (isValidIpAddress(DNSSIPInfo) == false || isAbcIpAddress(DNSSIPInfo) == false))
			{
				self.parent.AlertInfo(PortalguideDes['p0163']);
				return false;     
			}
			
			if (IPv4Gateway != '' && (isValidIpAddress(IPv4Gateway) == false || isAbcIpAddress(IPv4Gateway) == false))
			{
				self.parent.AlertInfo(PortalguideDes['p0164']);
				return false;
			}
			
			if (IPv4Gateway != '' && (IPv4Gateway == IPInfo))
			{
				self.parent.AlertInfo(PortalguideDes['p0165']);
				return false;
			}
			
			if(IPv4Gateway != '' && false == isSameSubNet(IPInfo, MaskInfo, IPv4Gateway, MaskInfo))
			{
				self.parent.AlertInfo(PortalguideDes['p0166']);
				return false;
			}
			
			var addr = IpAddress2DecNum(IPInfo);
            var mask = SubnetAddress2DecNum(MaskInfo);
            
            if ( (addr & (~mask)) == (~mask) )
            {
                self.parent.AlertInfo(PortalguideDes['p0167']);
                return false;
            }
			
            if ( (addr & (~mask)) == 0 )
            {
                self.parent.AlertInfo(PortalguideDes['p0167']);
                return false;
            }
			
            if(IPv4Gateway != '')
            {
                var gwaddr = IpAddress2DecNum(IPv4Gateway);
                if ( (gwaddr & (~mask)) == (~mask) )
                {
                    self.parent.AlertInfo(PortalguideDes['p0168']);
                    return false;
                }
				
                if ( (gwaddr & (~mask)) == 0 )
                {
					self.parent.AlertInfo(PortalguideDes['p0168']);
					return false;
                }
            }
			
			var i = 0;
			for (i = 0; i < self.parent.WanIp.length - 1; i++)
			{
				if (self.parent.WanIp[i].domain != DomainInfo && self.parent.WanIp[i].ExternalIPAddress == IPInfo)
				{
					self.parent.AlertInfo(PortalguideDes['p0169']);
					return false;
				}
			}

			for (i = 0; i < self.parent.WanPpp.length - 1; i++)
			{
				if (self.parent.WanPpp[i].domain != DomainInfo && self.parent.WanPpp[i].ExternalIPAddress == IPInfo)
				{
					self.parent.AlertInfo(PortalguideDes['p0169']);
					return false;
				}
			}
						
			return true;
		}
		
		function HwAjaxConfigPara(ObjPath, ParameterList)
		{
			var Result = null;
			  $.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : '/portalguideconfig.cgi?' + ObjPath + "&RequestFile=/portal/PortalStaticIP.asp",
				data: getDataWithToken(ParameterList),
				success : function(data) {
					 Result  = data;      
				}
			});
			
			return Result;
		}
	
		function StaticWanSubForm()
		{
			IPInfo = getValue("IPPortalInput");
			MaskInfo = getValue("MaskPortalInput");
			IPv4Gateway = getValue("OntIPPortalInput");
			DNSAIPInfo = getValue("DNSAPortalInput");
			DNSSIPInfo = getValue("DNSSPortalInput");
			DNSInfo = "";
			
			if (DNSAIPInfo != "")
			{
				DNSInfo = DNSAIPInfo;
			}
			
			if (DNSSIPInfo != "")
			{
				if (DNSInfo != "")
				{
					DNSInfo = DNSAIPInfo + "," + DNSSIPInfo;
				}
				else
				{
					DNSInfo = DNSSIPInfo;
				}
			}
			
			if (self.parent.currStaticIndex == -1)
			{
				var add_wanpath = "InternetGatewayDevice.WANDevice.1.WANConnectionDevice";     
				var add_path = 'Add_x='+ add_wanpath + 
				'&Addconnect_z=' + add_wanpath + '.{i}.WANIPConnection';

				var add_wanparalist = "Addconnect_z.Enable=1&Addconnect_z.X_HW_IPv4Enable=1&Addconnect_z.X_HW_IPv6Enable=0" + 
										"&Addconnect_z.X_HW_IPv6MultiCastVLAN=-1&Addconnect_z.X_HW_SERVICELIST=INTERNET&Addconnect_z.X_HW_ExServiceList=" + 
										"&Addconnect_z.X_HW_VLAN=0&Addconnect_z.X_HW_PRI=0&Addconnect_z.X_HW_PriPolicy=Specified&Addconnect_z.X_HW_DefaultPri=0" + 
										"&Addconnect_z.ConnectionType=IP_Routed&Addconnect_z.X_HW_MultiCastVLAN=4294967295&Addconnect_z.NATEnabled=1" + 
										"&Addconnect_z.X_HW_NatType=0&Addconnect_z.DNSEnabled=1&Addconnect_z.MaxMTUSize=1500&Addconnect_z.AddressingType=Static" + 
										"&Addconnect_z.ExternalIPAddress=" + IPInfo + "&Addconnect_z.SubnetMask=" + MaskInfo + "&Addconnect_z.DefaultGateway=" + IPv4Gateway +
										"&Addconnect_z.DNSServers=" + DNSInfo + "&Addconnect_z.X_HW_BindPhyPortInfo=";        

				HwAjaxConfigPara(add_path, add_wanparalist);
			}
			else
			{
				var path = "x=" + self.parent.WanIp[self.parent.currStaticIndex].domain;
				var set_wanparalist = "x.AddressingType=Static" +
									  "&x.ExternalIPAddress=" + IPInfo + 
									  "&x.SubnetMask=" + MaskInfo +
									  "&x.DefaultGateway=" + IPv4Gateway +
									  "&x.DNSServers=" + DNSInfo;
				HwAjaxConfigPara(path, set_wanparalist);
			}
		}
		
		function InitValue()
		{
			if (self.parent.currStaticIndex == -1)
			{
				return;
			}
			
			DomainInfo = self.parent.WanIp[self.parent.currStaticIndex].domain;
			
			setText("IPPortalInput", self.parent.WanIp[self.parent.currStaticIndex].ExternalIPAddress);
			setText("MaskPortalInput", self.parent.WanIp[self.parent.currStaticIndex].SubnetMask);
			setText("OntIPPortalInput", self.parent.WanIp[self.parent.currStaticIndex].DefaultGateway);
			setText("DNSAPortalInput", self.parent.WanIp[self.parent.currStaticIndex].DNSAServers);
			setText("DNSSPortalInput", self.parent.WanIp[self.parent.currStaticIndex].DNSSServers);
		}
		
		function getPageMaxHeight(dom)
		{
			var D = dom;
			var pageMaxHeight = Math.max(
				Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
				Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
				Math.max(D.body.clientHeight, D.documentElement.clientHeight)
			);
			return pageMaxHeight;
		}

		function resizePageHeight()
		{
			document.getElementsByTagName("body")[0].style.height = getPageMaxHeight(document) + "px";
		}
		
		function LoadFrame()
		{
			InitValue();
			parent.adjustIframeHeight();
			self.parent.curPageFlag = "StaticWANPage";
			self.parent.ControlPageShow();
			return;
		}
	</script>
</head>
<body onload="LoadFrame()" style="background-color: #f2f2f2;">
<div class="stepPortalContent container">
    <div class="stepPortalTip" style="">
        <span class="stepPortalTipSpan" style="" BindText="p0119"></span>
    </div>

    <div>
        <input type="text" id="IPPortalInput" class="PortalInput" placeholder="" style="">
    </div>
	
    <div class="stepPortalTip" style="">
        <span class="stepPortalTipSpan" BindText="p0120"></span>
    </div>
    <div>
        <input type="text" id="MaskPortalInput" class="PortalInput" placeholder="" style="">
    </div>

    <div class="stepPortalTip" style="">
        <span class="stepPortalTipSpan" BindText="p0121"></span>
    </div>
    <div>
        <input type="text" id="OntIPPortalInput" class="PortalInput" placeholder="" style="">
    </div>
    <div class="stepPortalTip" style="line-height:6em;">
        <span class="stepPortalTipSpan" BindText="p0122"></span>
    </div>
    <div>
        <input type="text" id="DNSAPortalInput" class="PortalInput" placeholder="" style="">
    </div>
	    <div class="stepPortalTip" style="">
        <span class="stepPortalTipSpan" BindText="p0123"></span>
    </div>
    <div>
        <input type="text" id="DNSSPortalInput" class="PortalInput" placeholder="" style="">
    </div>
</div>
	<script>
	ParseBindTextByTagName(PortalguideDes, "span", 1);
	ParseBindTextByTagName(PortalguideDes, "td", 1);
	ParseBindTextByTagName(PortalguideDes, "div", 1);
	ParseBindTextByTagName(PortalguideDes, "input", 2);
	</script>
</body>
</html>
