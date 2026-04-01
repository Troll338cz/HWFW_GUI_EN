<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
    <link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
    <script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
    <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>  
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(errdes.html);%>"></script>  
    <title>wandns</title>
</head>

<body class="mainbody" onLoad="wanDns.init();">
    <script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info.asp);%>"></script>
    <script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list.asp);%>"></script>
    <script>
        var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
        if (IsPTVDFFlag == '1') {
            HWCreatePageHeadInfo("wandnstitle", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription_vdf"), false);
        } else {
            HWCreatePageHeadInfo("wandnstitle", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription"), false);
        }
    </script>
    <div class="title_spread"></div>
    <form id="DNSForm" name="DNSForm">
        <table>
            <li id="wandnsInfoBar" RealType="HorizonBar" DescRef="wan_dnstitle" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
            <li id="sourcemode" RealType="RadioButtonList" DescRef="wan_dnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="[{TextRef:'wan_dnscarrier',Value:'0'},{TextRef:'wan_dnscustom',Value:'1'}]" ClickFuncApp="onclick=wanDns.ChangeMode" />
            <li id="primarydns" RealType="TextBox" DescRef="wan_primdnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" />
            <li id="secondarydns" RealType="TextBox" DescRef="wan_seconddnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" />

            <li id="wandnsInfoBarIPv6" RealType="HorizonBar" DescRef="wan_dnstitleIPv6" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
            <li id="sourcemodeIPv6" RealType="RadioButtonList" DescRef="wan_dnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="[{TextRef:'wan_dnscarrier',Value:'0'},{TextRef:'wan_dnscustom',Value:'1'}]" ClickFuncApp="onclick=wanDns.ChangeModev6" />
            <li id="primarydnsIPv6" RealType="TextBox" DescRef="wan_primdnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" />
            <li id="secondarydnsIPv6" RealType="TextBox" DescRef="wan_seconddnssoucrce" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" />
        </table>
        <script>
            var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
            HWParsePageControlByID("DNSForm", TableClass, Languages, null);
        </script>
    </form>
    <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
        <tr>
            <td class='width_per20'></td>
            <td class="table_submit pad_left5p">
                <input id="ButtonApply"  type="button" onclick="wanDns.setData();" class="ApplyButtoncss buttonwidth_100px" BindText="Apply">
                <input id="ButtonCancel" type="button" onclick="wanDns.CancelConfig();" class="CancleButtonCss buttonwidth_100px" BindText="Cancel">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">                
            </td>
        </tr>
    </table>
</body>
<script>
function stIPv6DNSInfo(domain,X_HW_OverrideAllowed,DNSServer)
{
	this.domain 				= domain;
	this.X_HW_OverrideAllowed   = X_HW_OverrideAllowed;
	this.DNSServer 				= DNSServer;
}
var IPv6DNSInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DNS.Client.Server.{i},X_HW_OverrideAllowed|DNSServer,stIPv6DNSInfo);%>;
var ipv6arr = new Array();
var Ipv6AddFlag = true;
var IsDNSLockEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DNS.DNSLockEnable);%>'
if (IPv6DNSInfos.length == "1")
{
	Ipv6AddFlag = true;
	ipv6arr[0] = "0;";
}
else
{
	Ipv6AddFlag = false;
	ipv6arr[0] = IPv6DNSInfos[0].X_HW_OverrideAllowed+";"+IPv6DNSInfos[0].DNSServer;
}
    var config = ({
        isCarrier: true,
        isCustom: false,
        wanlist:GetWanList(),
        IPv4DNSOverrideSwitch:null,
        IPv4PrimaryDNS:"",
        IPv4SecondaryDNS:"", 
		
		IPv6DNSOverrideSwitch:null,
        IPv6PrimaryDNS:"",
        IPv6SecondaryDNS:"", 
		IPv6InternetInterface:"",
		
        wandomain:null,
		IPv6DNSdomain:null,
        data: null
    });
    var DnsModule = function DnsModule(){};

    DnsModule.prototype = {
        showPage:function(){
            setRadio("sourcemode",config.IPv4DNSOverrideSwitch);
            setText("primarydns",config.IPv4PrimaryDNS);
            setText("secondarydns",config.IPv4SecondaryDNS);
			
			setRadio("sourcemodeIPv6",config.IPv6DNSOverrideSwitch);
            setText("primarydnsIPv6",config.IPv6PrimaryDNS);
            setText("secondarydnsIPv6",config.IPv6SecondaryDNS);
			
            this.DisablePage();
        },
        setData:function(){
            setDisable("ButtonApply",1);
			var parainfo = "";
			var statusurl = "setajax.cgi?x=" + config.wandomain + "&RequestFile=html/bbsp/wan/wandns.asp";
			parainfo = "x.DNSOverrideAllowed=" + getRadioVal('sourcemode');
			if (getRadioVal("sourcemode") == "1")
			{
				parainfo += "&x.DNSServers=" + getValue('primarydns') +',' + getValue('secondarydns');
			}
			parainfo += "&x.X_HW_Token=" + getValue('hwonttoken');
			$.ajax({
				type  : "POST",
				async : true,
				cache : false,
				data  : parainfo,
				url   : statusurl,
				success : function(data) {
                    var ResultInfo = JSON.parse(hexDecode(data));
					if (0 == ResultInfo.result)
					{
						wanDns.setIPv6Data();
					}else{
						alert(errLanguage["s0xf7500065"]);
						setDisable("ButtonApply",0);
					} 
							
				}
			});
				
        },
		
		setIPv6Data:function(){
			var parainfo = "";
			if (Ipv6AddFlag == true)
			{
				var statusurl = "addajax.cgi?x=InternetGatewayDevice.X_HW_DNS.Client.Server&RequestFile=html/bbsp/wan/wandns.asp";
			}
			else
			{
				var statusurl = "setajax.cgi?x=" + config.IPv6DNSdomain + "&RequestFile=html/bbsp/wan/wandns.asp";
			}
			parainfo = "x.X_HW_OverrideAllowed=" + getRadioVal('sourcemodeIPv6');
			if (getRadioVal("sourcemodeIPv6") == "1")
			{
				if (getValue('primarydnsIPv6') == "" && getValue('secondarydnsIPv6') != "")
				{
					parainfo += "&x.DNSServer=" + getValue('secondarydnsIPv6');
				}
				else if (getValue('secondarydnsIPv6') == "" && getValue('primarydnsIPv6') != "")
				{
					parainfo += "&x.DNSServer=" + getValue('primarydnsIPv6');
				}
				else if (getValue('secondarydnsIPv6') == "" && getValue('primarydnsIPv6') == "")
				{
					parainfo += "&x.DNSServer=";
				}
				else
				{
					parainfo += "&x.DNSServer=" + getValue('primarydnsIPv6') +',' + getValue('secondarydnsIPv6');
				}
				parainfo += "&x.Interface=" + config.IPv6InternetInterface;
			}
			parainfo += "&x.X_HW_Token=" + getValue('hwonttoken');
			$.ajax({
				type  : "POST",
				async : true,
				cache : false,
				data  : parainfo,
				url   : statusurl,
				success : function(data) {
					var ResultInfo = JSON.parse(hexDecode(data));
					if (0 == ResultInfo.result)
					{
						window.location.href = "/html/bbsp/wan/wandns.asp";			
					}
					else
					{
						alert(errLanguage["s0xf7500066"]);
						setDisable("ButtonApply",0);
					}
					
								
				}
			});	
		},
		
        CancelConfig:function(){
            this.init();
        },
        ChangeMode:function(){
            var wanlistlen = config.wanlist.length;
			if (wanlistlen == '0')
			{
				config.IPv4DNSOverrideSwitch = '0';
			}
            for (var i = 0;i < wanlistlen; i++){
                if (config.wanlist[i].ServiceList.toUpperCase().indexOf("INTERNET") < 0){
                    setDisable("sourcemode1",0);
                    setDisable("sourcemode2",0);
                    setDisable("primarydns",0);
                    setDisable("secondarydns",0);
                }
                else{
                    config.wandomain = config.wanlist[i].domain;
                    config.IPv4DNSOverrideSwitch = config.wanlist[i].IPv4DNSOverrideSwitch;
                    if (config.IPv4DNSOverrideSwitch == "1")
                    {
                        config.IPv4PrimaryDNS = config.wanlist[i].IPv4PrimaryDNS;
                        config.IPv4SecondaryDNS = config.wanlist[i].IPv4SecondaryDNS;
                        setDisable("primarydns",1);
                        setDisable("secondarydns",1);
                        break;   
                    }                
                }
            }
            this.DisablePagev4();
        },
		
		ChangeModev6:function(){
            var wanlistlen = config.wanlist.length;
			if (wanlistlen == '0')
			{
				config.IPv6DNSOverrideSwitch = '0';
			}
            for (var i = 0;i < wanlistlen; i++){
                if (config.wanlist[i].ServiceList.toUpperCase().indexOf("INTERNET") < 0){
					setDisable("sourcemodeIPv61",0);
                    setDisable("sourcemodeIPv62",0);
                    setDisable("primarydnsIPv6",0);
                    setDisable("secondarydnsIPv6",0);
				}else{
                    config.IPv6DNSdomain = "InternetGatewayDevice.X_HW_DNS.Client.Server.1";

                    config.IPv6DNSOverrideSwitch = ipv6arr[0].split(";")[0];
				
				    if (config.wanlist[i].IPv6Enable == "1")
                    {
                        config.IPv6InternetInterface = domainTowanname(config.wanlist[i].domain);
                    }
					if (config.IPv6DNSOverrideSwitch == "1")
                    {
                        if (ipv6arr[0].split(";")[1] == '')
						{
							config.IPv6PrimaryDNS = "";
							config.IPv6SecondaryDNS = "";
						}
						else if (ipv6arr[0].split(";")[1].indexOf(",") < 0)
						{
							config.IPv6PrimaryDNS = ipv6arr[0].split(";")[1];
							config.IPv6SecondaryDNS = "";
						}
						else
						{
							config.IPv6PrimaryDNS = ipv6arr[0].split(";")[1].split(",")[0];
							config.IPv6SecondaryDNS = ipv6arr[0].split(";")[1].split(",")[1];
						}
                        setDisable("primarydnsIPv6",1);
                        setDisable("secondarydnsIPv6",1);
						
                        break;   
                    } 				
                }
			}
			this.DisablePagev6();
		},
		
        DisablePage:function()
        {
            if (getRadioVal("sourcemode") == "0"){
                setDisable("primarydns",1);
                setDisable("secondarydns",1);
                document.getElementById("primarydns").value = "";
                document.getElementById("secondarydns").value = "";          
            }
            else{
                setDisable("primarydns",0);
                setDisable("secondarydns",0);  
                setText("primarydns",config.IPv4PrimaryDNS);
                setText("secondarydns",config.IPv4SecondaryDNS);                        
            }
			
            if (getRadioVal("sourcemodeIPv6") == "0"){
                setDisable("primarydnsIPv6",1);
                setDisable("secondarydnsIPv6",1);
                document.getElementById("primarydnsIPv6").value = "";
                document.getElementById("secondarydnsIPv6").value = "";          
            }
            else{
                setDisable("primarydnsIPv6",0);
                setDisable("secondarydnsIPv6",0);  
                setText("primarydnsIPv6",config.IPv6PrimaryDNS);
                setText("secondarydnsIPv6",config.IPv6SecondaryDNS);                        
            }        
		},
		
		DisablePagev4:function()
        {
            if (getRadioVal("sourcemode") == "0"){
                setDisable("primarydns",1);
                setDisable("secondarydns",1);
                document.getElementById("primarydns").value = "";
                document.getElementById("secondarydns").value = "";          
            }
            else{
                setDisable("primarydns",0);
                setDisable("secondarydns",0);  
                setText("primarydns",config.IPv4PrimaryDNS);
                setText("secondarydns",config.IPv4SecondaryDNS);                        
            }       
		},
		
		DisablePagev6:function()
        {
			
            if (getRadioVal("sourcemodeIPv6") == "0"){
                setDisable("primarydnsIPv6",1);
                setDisable("secondarydnsIPv6",1);
                document.getElementById("primarydnsIPv6").value = "";
                document.getElementById("secondarydnsIPv6").value = "";          
            }
            else{
                setDisable("primarydnsIPv6",0);
                setDisable("secondarydnsIPv6",0);  
                setText("primarydnsIPv6",config.IPv6PrimaryDNS);
                setText("secondarydnsIPv6",config.IPv6SecondaryDNS);                        
            }        
		},
		
        init:function()
		{	setDisplay("wandnsInfoBarIPv6Panel",0);
			this.ChangeMode(); 
			this.ChangeModev6();
			this.showPage();
			if(IsPTVDFFlag == "1")
			{
				setDisplay("wandnsInfoBarIPv6Panel",1);
				if(IsDNSLockEnable == "1")
				{
					setDisable("primarydns",1);
					setDisable("secondarydns",1);
					setDisable("sourcemode1",1);
					setDisable("sourcemode2",1);
					
					setDisable("primarydnsIPv6",1);
					setDisable("secondarydnsIPv6",1);
					setDisable("sourcemodeIPv61",1);
					setDisable("sourcemodeIPv62",1);                       
				}
			}
        }
    }
    var wanDns = new DnsModule();
    
    ParseBindTextByTagName(Languages, "td",    1);
    ParseBindTextByTagName(Languages, "div",    1);
    ParseBindTextByTagName(Languages, "input", 2);    
</script>

</html>