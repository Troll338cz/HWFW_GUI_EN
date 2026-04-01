<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
    <link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
    <script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
    <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script> 
    <title>Section Speed</title>
<style>
.internetico{
	height:60px;
	width:60px;
	float:left;
	margin-top:25px;
	margin-right:5px;
    margin-bottom:30px;
	background:url(../../../images/interneticon.jpg)no-repeat;
}
.ontico{
	height:76px;
	width:80px;
    margin-top:20px;
	float:left;
	background:url(../../../images/ontgateway.png) no-repeat;	
}
.apico{
	height:64px;
	width:47px;
	float:left;
	margin-left:5px;
    margin-top:24px;
	background:url(../../../images/sectionap.png) no-repeat;
}
.sectionline{
	float:left;
	width:115px;
	height:14px;
	margin-top:50px;
	background:url(../../../images/sLine.jpg);
}
.topo{
    background:#ffffff;
    height:120px;
    color:#000000;
}
.sectionspeed{
    margin-left:20px;
}
.InternetAP{
    margin: 68px 0 0 10px;
}
.internetAp_japan {
    margin: 68px 0 0 -10px;
    width: 90px
}
.GW{
    margin: 74px 0 0 30px;
}
.gw_japan {
    margin: 74px 0 0 5px;
}
.gw_turkish {
    margin: 74px 0 0 15px;
}
.title50{
    font-weight:600; 
}
</style>
<script>
    var language = '<%HW_WEB_GetCurrentLanguage();%>';
</script>
</head>
<body onload="sectionSpeed.LoadFrame()" class="mainbody">
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(errdes.html);%>"></script> 
    <script>
        var nohometitle = '<%HW_WEB_GetFeatureSupport(FT_WEB_NOHOME_TITLE);%>';
if (nohometitle == '1') {
	HWCreatePageHeadInfo("sectionspeedtitle", GetDescFormArrayById(sectionsectionspeed_language, "section_menu"), GetDescFormArrayById(sectionsectionspeed_language, "section_title2"), false);
	} else {
	HWCreatePageHeadInfo("sectionspeedtitle", GetDescFormArrayById(sectionsectionspeed_language, "section_menu"), GetDescFormArrayById(sectionsectionspeed_language, "section_title"), false);
}       
    </script>
<div id="topo" class="topo">
    <div>
        <div class="sectionspeed">
<script>
    var type = 'InternetAP';
    if (language == 'japanese') {
        type = 'internetAp_japan';
    }
    document.write('<div class="internetico"><div class="' + type + '" BindText="section_internet"></div></div>');
</script>
            <div class="sectionline" id="loadingleft"></div>
<script>
    var type = 'GW';
    if (language == 'japanese') {
        type = 'gw_japan';
    } else if (language == 'turkish') {
        type = 'gw_turkish';
    }
    document.write('<div class="ontico"><div class="' + type + '" BindText="section_gateway"></div></div>');
</script>
            <div class="sectionline" id="loadingright"></div>
            <div class="apico"><div class="InternetAP" BindText="section_AP"></div></div>
            <div class="sectionline" id="loadingvertical"></div>
            <div class="apico"><div class="InternetAP" BindText="section_AP"></div></div>
        </div>
    </div>
</div>
<div class="title_spread"></div>
<form id="speedform" class="speedform">
    <table>
        <li  id="sectionspeedScenes"  RealType="DropDownList"      DescRef="section_scenes"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'section_ONT_Internet',Value:'IPERF_TEST_REQUEST_GW_TO_INTERNET'},{TextRef:'section_ONT_AP',Value:'IPERF_TEST_REQUEST_AP_TO_GW'},{TextRef:'section_AP_AP',Value:'IPERF_TEST_REQUEST_AP_TO_AP'},{TextRef:'section_AP_Internet',Value:'IPERF_TEST_REQUEST_AP_TO_INTERNET'}]" ClickFuncApp="onchange=sectionSpeed.refreshData"/>
        <script>
            var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
            if (isBponFlag == '1') {
                document.write('<li id="speedaddress" RealType="TextBox" DescRef="section_address_bpon" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" />');
            } else {
                document.write('<li id="speedaddress" RealType="TextBox" DescRef="section_address"      RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="Empty" />');
            }
        </script>
		<li  id="macadress1"          RealType="DropDownList"      DescRef="section_apmac"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" />
        <li  id="macadress2"          RealType="DropDownList"      DescRef="section_servermac"    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" />
		<li  id="sectionadvance"      RealType="CheckBox"          DescRef="section_advance"      RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" ClickFuncApp="onclick=sectionSpeed.ChangeaAdvance"/>
		<li  id="sectionstatus"       RealType="DropDownList"      DescRef="section_status"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'section_up',Value:'UPLOAD'},{TextRef:'section_down',Value:'DOWNLOAD'}]" />
        <li  id="sectionport"         RealType="TextBox"           DescRef="section_port"         RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" />
		<li  id="sectionspeedtime"    RealType="DropDownList"      DescRef="section_speedtime"    RemarkRef="section_mark1"           ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'section_time10',Value:'10'},{TextRef:'section_time20',Value:'20'},{TextRef:'section_time30',Value:'30'},{TextRef:'section_time40',Value:'40'},{TextRef:'section_time50',Value:'50'},{TextRef:'section_time60',Value:'60'}]"/>
        <li  id="listeningtime"       RealType="DropDownList"      DescRef="section_listenime"    RemarkRef="section_mark2"           ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'section_listentime0',Value:'60'},{TextRef:'section_listentime1',Value:'600'},{TextRef:'section_listentime2',Value:'1200'},{TextRef:'section_listentime3',Value:'1800'},{TextRef:'section_listentime4',Value:'2400'},{TextRef:'section_listentime5',Value:'3000'},{TextRef:'section_listentime6',Value:'3600'}]"/>
        <li  id="Threads"             RealType="DropDownList"      DescRef="section_parallel"     RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'section_numb1',Value:'1'},{TextRef:'section_numb2',Value:'2'},{TextRef:'section_numb3',Value:'3'},{TextRef:'section_numb4',Value:'4'}]" />
	</table>
	<script>
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        HWParsePageControlByID("speedform", TableClass, sectionsectionspeed_language, null);
    </script>
    <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
        <tr>
            <td class="width_per30"></td>
            <td class="table_submit pad_left5p">
                <input id="ButtonApply"  type="button" class="ApplyButtoncss buttonwidth_100px" BindText="section_apply" onClick="sectionSpeed.startSectionSpeed()"/>
                <input id="ButtonStop" type="button"  class="CancleButtonCss buttonwidth_100px" BindText="section_cancel" onClick="sectionSpeed.stopSectionSpeed()" disabled/>
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"/>               
            </td>
        </tr>
    </table>     
</form>
<div class="title_spread"></div>
<div class="func_title" BindText="section_speedresult"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed;word-break:break-all" id="sampvalue">
    <tr align="center" class="tabal_01"><td align="center">1s</td><td align="center">2s</td><td align="center">3s</td><td align="center">4s</td><td align="center">5s</td><td align="center">6s</td><td align="center">7s</td><td align="center">8s</td><td align="center">9s</td><td align="center">10s</td></tr><tr align="center" class="tabal_01"><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td></tr>
    <tr align="center" class="tabal_01"><td align="center" colspan="3" BindText="section_speedmin"></td><td align="center" colspan="3" BindText="section_speedmax"></td><td align="center" colspan="4" BindText="section_speedaverage"></td></tr>
    <tr align="center" class="tabal_01"><td align="center" colspan="3">--</td><td align="center" colspan="3">--</td><td align="center" colspan="4">--</td></tr>
</table>
<div class="title_spread"></div>
<div class="func_title" BindText="section_speedresultdetails"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed;word-break:break-all">
    <tr id="spedresult" class="head_title">
        <td BindText="section_Attributes" class="width_per50"></td>
        <td BindText="section_value" class="width_per50"></td>
    </tr>
</table> 
<div class="title_spread"></div>
<div class="title_spread"></div>	
</body>
<script type="text/javascript">
    var SelspeedMode = <%HW_WEB_GetSelSpeedMode();%>;
    var SectionSpeedMode = "1";
    var SectionadvanceMode = "0";
    var getfiletime;
    var ServerAddrtime;
    var dethmaxisap = '<%HW_WEB_GetFeatureSupport(FT_DETHMAXIS_APMODE);%>';
    function stApDeviceList(domain,ApOnlineFlag,APMacAddr)
    {
        this.domain = domain;
        this.ApOnlineFlag = ApOnlineFlag;
        this.APMacAddr = APMacAddr;
    }
    var ApDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i},ApOnlineFlag|APMacAddr,stApDeviceList);%>;
    
    if (0 != SelspeedMode)
    {
        SectionSpeedMode = SelspeedMode.split(";")[0];
        SectionadvanceMode = SelspeedMode.split(";")[1];
    }
    var SectionSpeed = function(){};
	
    var Form = new webSubmitForm(),time;
    SectionSpeed.prototype = {

        Init:function(){
            var topowidth = $("#topo").width();
            if (topowidth < 600)
            {
                $(".sectionline").css('width',"100px");
            }
            this.ChangeaAdvance(0);
			
			XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
            if ("1" == SectionSpeedMode)
            {
                getfiletime = setInterval("sectionSpeed.getFileResult(1)", 200);
            }else{
                getfiletime = setInterval("sectionSpeed.getFileResult()", 200);
            }
			
            time = setInterval("sectionSpeed.refreshData(0)", 2400);
        },
        GetApMacList:function(){
            for (var i = 0; i < ApDeviceList.length-1; i++)
            {
                if ("1" == ApDeviceList[i].ApOnlineFlag)
                {   
                    $("#macadress1").append("<option value =" + ApDeviceList[i].APMacAddr + ">" + ApDeviceList[i].APMacAddr + "</option>");
                    $("#macadress2").append("<option value =" + ApDeviceList[i].APMacAddr + ">" + ApDeviceList[i].APMacAddr + "</option>");  
                }        
            }
        },
        ChangeaAdvance:function(inPutClick){
			var click = (undefined == inPutClick || null == inPutClick || 0 == inPutClick)?0:1;
            if ("1" == click)
            {
                var isSelect = getCheckVal("sectionadvance");
                
            }
            else
            {
                var isSelect = SectionadvanceMode;
            }
            var scancesvalue = getSelectVal("sectionspeedScenes");
            if ("1" == isSelect){
                $("#sectionadvance").attr("checked", true);                
                if (scancesvalue == "IPERF_TEST_REQUEST_AP_TO_GW" || scancesvalue == "IPERF_TEST_REQUEST_AP_TO_AP"){
                    setDisplay("sectionstatusRow",1);
                    setDisplay("sectionportRow",1);
                    setDisplay("sectionspeedtimeRow",1);
                    setDisplay("ThreadsRow",1);
                    setDisplay("listeningtimeRow",1);                   
                }
                else{
                    setDisplay("sectionstatusRow",1);
                    setDisplay("sectionportRow",1);
                    setDisplay("sectionspeedtimeRow",1);
                    setDisplay("ThreadsRow",1);
                    setDisplay("listeningtimeRow",0);
                } 
	 			
            }
            else
            {
                setDisplay("sectionstatusRow",0);
                setDisplay("sectionportRow",0);
                setDisplay("sectionspeedtimeRow",0);
                setDisplay("ThreadsRow",0);
                setDisplay("listeningtimeRow",0);
            }
        },
        unChangeable:function(flag){
            var scancesvalue = getSelectVal("sectionspeedScenes");
            if (scancesvalue == "IPERF_TEST_REQUEST_AP_TO_GW" || scancesvalue == "IPERF_TEST_REQUEST_AP_TO_AP")
            {
                setDisable("speedaddress",1);
            }
            else{
                setDisable("speedaddress",flag); 
            }
            setDisable("sectionspeedScenes",flag);
            setDisable("macadress1",flag);
            setDisable("macadress2",flag);
            setDisable("sectionadvance",flag);
            setDisable("sectionstatus",flag);
            setDisable("sectionport",flag);
            setDisable("sectionspeedtime",flag);
            setDisable("listeningtime",flag);
            setDisable("Threads",flag);
        },
        setData:function(val)
        {
            var parainfo = "";
            parainfo += "Speedscenes=" + val;
            parainfo += "&Sectionstatus=" + getCheckVal("sectionadvance");
            parainfo += '&x.X_HW_Token=' + getValue('hwonttoken');
            $.ajax({
                type  : "POST",
                async : true,
                cache : false,
                data  : parainfo,
                url   : "setselspeedmode.cgi?&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp",
                success : function(data) {

                }
            });
        },
        submitGWtoInternet:function(){
            var Sectionstatus = getCheckVal("sectionadvance");
            var parainfo = "";
            var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfClient&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
            parainfo += "x.DiagnosticsState=requested";
            parainfo += "&x.ServerAddr=" + getValue('speedaddress');
            parainfo += "&x.DestMac=";
			parainfo += "&x.Bandwidth=0" ;
			
            
            if("1" == Sectionstatus)
            {
                parainfo += "&x.TestMode=" + getValue('sectionstatus');
                parainfo += "&x.Port=" + getValue('sectionport');
                parainfo += "&x.ProtocolType=TCP";
                parainfo += "&x.MaxTime=" + getValue('sectionspeedtime');
                parainfo += "&x.Parallel=" + getValue('Threads');
            }
            else
            {
                parainfo += "&x.TestMode=UPLOAD";
                parainfo += "&x.Port=5201";
                parainfo += "&x.ProtocolType=TCP";
                parainfo += "&x.MaxTime=10";
                parainfo += "&x.Parallel=1";
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
                        sectionSpeed.setData(1);
                    }else{
                        alert(errLanguage["s0xf7205001"]);
                    }                    
                    window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";                    
                }
            }); 
        },
        submitAPToGW:function(){
            if (getValue('macadress1') == "")
            {
                alert(sectionsectionspeed_language["section_macnull"]);
                window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";
            }
            else
            {
                var Sectionstatus = getCheckVal("sectionadvance");
                var parainfo = "";
                var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfServer&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
                parainfo += "x.DiagnosticsState=Requested";
                parainfo += "&x.DestMac=";
                if("1" == Sectionstatus)
                {
                    parainfo += "&x.Port=" + getValue('sectionport');
                    parainfo += "&x.MaxTime=" + getValue('listeningtime');
                }
                else
                {
                    parainfo += "&x.Port=5201";
                    parainfo += "&x.MaxTime=1800";
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
                            sectionSpeed.setData(2);                        
                            ServerAddrtime = setInterval("sectionSpeed.submitServerAddr()", 50);
                            setTimeout(function(){clearInterval(ServerAddrtime);}, 60000);
                        }else{
                            alert(errLanguage["s0xf7205001"]);
                        }                                       
                    }
                });
            }
        },
        submitServerAddr:function(){            
            var serverinfos = this.getServerParameters();
            if ("" != serverinfos.ErrorDescription)
            {
                clearInterval(ServerAddrtime);
                window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";
            }
            else if("" == serverinfos.ServerIP || "" == serverinfos.ServerPort)
            {
                return false;
            }
            else
            {
                clearInterval(ServerAddrtime);
                var Sectionstatus = getCheckVal("sectionadvance");
                var parainfo = "";
                var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfClient&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
                parainfo += "x.DiagnosticsState=Requested";
                parainfo += "&x.ServerAddr=" + serverinfos.ServerIP;
                parainfo += "&x.DestMac=" + getValue('macadress1');
                parainfo += "&x.Port=" + serverinfos.ServerPort;
				parainfo += "&x.Bandwidth=0" ;
	
                if("1" == Sectionstatus)
                {
                    parainfo += "&x.TestMode=" + getValue('sectionstatus');
                    parainfo += "&x.ProtocolType=TCP";
                    parainfo += "&x.MaxTime=" + getValue('sectionspeedtime');
                    parainfo += "&x.Parallel=" + getValue('Threads');
                }
                else
                {
                    parainfo += "&x.TestMode=UPLOAD";
                    parainfo += "&x.ProtocolType=TCP";
                    parainfo += "&x.MaxTime=10";
                    parainfo += "&x.Parallel=1";
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
                        if (0 != ResultInfo.result)
                        {
                            alert(errLanguage["s0xf7205001"]);
                        }
                        window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";
                    }
                }); 
            }           
        },        
        submitAPToAP:function(){
            if (getValue('macadress1') == "" || getValue('macadress2') == "")
            {
                alert(sectionsectionspeed_language["section_macnull"]);
                window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";
            }
            else if (getValue('macadress1') == getValue('macadress2'))
            {
                alert(sectionsectionspeed_language["section_thesame"]);
                window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";
            }
            else
            {
                var Sectionstatus = getCheckVal("sectionadvance");
                var parainfo = "";
                var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfServer&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
                parainfo += "x.DiagnosticsState=Requested";
                parainfo += "&x.DestMac=" + getValue('macadress2');
                if("1" == Sectionstatus)
                {
                    parainfo += "&x.Port=" + getValue('sectionport');
                    parainfo += "&x.MaxTime=" + getValue('listeningtime');
                }
                else
                {
                    parainfo += "&x.Port=5201";
                    parainfo += "&x.MaxTime=1800";
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
                            sectionSpeed.setData(3);
                            ServerAddrtime = setInterval("sectionSpeed.submitServerAddr()", 50);
                            setTimeout(function(){clearInterval(ServerAddrtime);}, 60000);
                        }else{
                            alert(errLanguage["s0xf7205001"]);
                        }
                    }
                });
            }            
        },
        submitAPToInternet:function(){
            if (getValue('macadress1') == "")
            {
                alert(sectionsectionspeed_language["section_macnull"]);
                window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";
            }
            else
            {
                var Sectionstatus = getCheckVal("sectionadvance");
                var parainfo = "";
                var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfClient&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
                parainfo += "x.DiagnosticsState=requested";
                parainfo += "&x.ServerAddr=" + getValue('speedaddress');
                parainfo += "&x.DestMac=" + getValue('macadress1');	
				parainfo += "&x.Bandwidth=0";	
                if("1" == Sectionstatus)
                {
                    parainfo += "&x.TestMode=" + getValue('sectionstatus');
                    parainfo += "&x.Port=" + getValue('sectionport');
                    parainfo += "&x.ProtocolType=TCP";
                    parainfo += "&x.MaxTime=" + getValue('sectionspeedtime');
                    parainfo += "&x.Parallel=" + getValue('Threads');
                }
                else
                {
                    parainfo += "&x.TestMode=UPLOAD";
                    parainfo += "&x.Port=5201";
                    parainfo += "&x.ProtocolType=TCP";
                    parainfo += "&x.MaxTime=10";
                    parainfo += "&x.Parallel=1";
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
                            sectionSpeed.setData(4);   
                        }else{
                            alert(errLanguage["s0xf7205001"]);
                        } 
                        window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp"; 
                    }
                }); 
            }
        },
        getFileResult:function(str){
            var fileresult;
            $.ajax({
                type  : "POST",
                async : true,
                cache : false,
                url   : "getfileResult.asp",
                success : function(data) {
                    fileresult = dealDataWithFun(data);
                    if ("1" == str)
                    {   if ("1" ==fileresult.split(";")[0])
                        {
                            setDisable("ButtonStop",0);
                            clearInterval(getfiletime); 
                        } 
                    }
                    else
                    {
                        if ("1" ==fileresult.split(";")[1])
                        {
                            setDisable("ButtonStop",0);
                            clearInterval(getfiletime);
                        }
                    } 
                }
            });

                       
        },       
        startSectionSpeed:function(){	
            var scancesvalue = getSelectVal("sectionspeedScenes");
            this.unChangeable(1);
            setDisable("ButtonApply",1);
            XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
            switch(scancesvalue)
            {
                case "IPERF_TEST_REQUEST_GW_TO_INTERNET":
                    getfiletime = setInterval("sectionSpeed.getFileResult(1)", 200);
                    this.submitGWtoInternet();
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_GW":
                    getfiletime = setInterval("sectionSpeed.getFileResult()", 200);
                    this.submitAPToGW();
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_AP": 
                    getfiletime = setInterval("sectionSpeed.getFileResult()", 200);                
                    this.submitAPToAP();
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_INTERNET":
                    getfiletime = setInterval("sectionSpeed.getFileResult()", 200);
                    this.submitAPToInternet();
                    break;
                default:
                    break;                
            }  
        },
        animationEffects:function(){
            var scancesvalue = getSelectVal("sectionspeedScenes");
            switch(scancesvalue)
            {
                case "IPERF_TEST_REQUEST_GW_TO_INTERNET":
                    $("#loadingleft").css({"background": "url(../../../images/loadspeed.gif)"});                    
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_GW":
                    $("#loadingright").css({"background": "url(../../../images/loadspeed.gif)"});                   
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_AP":
                    $("#loadingvertical").css({"background": "url(../../../images/loadspeed.gif)"});                 
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_INTERNET":
                    $("#loadingleft").css({"background": "url(../../../images/loadspeed.gif)"}); 
                    $("#loadingright").css({"background": "url(../../../images/loadspeed.gif)"}); 
                    break;
                default:
                    break;                
            }         
        },
        stopSectionSpeed:function(){
            var scancesvalue = getSelectVal("sectionspeedScenes");
            this.unChangeable(1);
            setDisable("ButtonStop",1);
            switch(scancesvalue)
            {
                case "IPERF_TEST_REQUEST_GW_TO_INTERNET":                    
                    this.stopSectionSpeed1();
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_GW":                   
                    this.stopSectionSpeed2();
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_AP":                   
                    this.stopSectionSpeed2();
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_INTERNET":
                    this.stopSectionSpeed1();
                    break;
                default:
                    break;                
            } 
        },
        stopSectionSpeed1:function(){
            var clientinfos = this.getClientParameters();
            var parainfo = "";
            var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfClient&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
            parainfo += "x.Port=" + clientinfos.Port;
            parainfo += "&x.X_HW_Token=" + getValue('hwonttoken');
            $.ajax({
                type  : "POST",
                async : true,
                cache : false,
                data  : parainfo,
                url   : statusurl,
                success : function(data) {
                    var ResultInfo = JSON.parse(hexDecode(data));
                    if (0 != ResultInfo.result)
                    {
                        alert(errLanguage["s0xf7205001"]);
                    } 
                    window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";                    
                }
            });
        },
        stopSectionSpeed2:function(){
            var serverinfos = this.getServerParameters();
            var parainfo = "";
            var statusurl = "setajax.cgi?x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfServer&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
            parainfo += "x.Port=" + serverinfos.Port;
            parainfo += "&x.X_HW_Token=" + getValue('hwonttoken');
            $.ajax({
                type  : "POST",
                async : true,
                cache : false,
                data  : parainfo,
                url   : statusurl,
                success : function(data) {
                    var ResultInfo = JSON.parse(hexDecode(data));
                    if (0 != ResultInfo.result)
                    {
                        alert(errLanguage["s0xf7205001"]);
                    }
                    window.location.href = "/html/ssmp/Sectionspeed/Sectionspeed.asp";                    
                }
            });
        },
        getClientParameters:function(){
            var clientPath = "x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfClient&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
            var ParaList = 'DiagnosticsState&DestMac&ServerAddr&TestMode&Port&MaxTime&ProtocolType&Parallel&Result&ErrorDescription&ReportTime&TestResult&Bandwidth&x.X_HW_Token=' + getValue('hwonttoken');

			var clientinfos = $.parseJSON(HwAjaxGetPara(clientPath, ParaList));
			if('0' == clientinfos.Bandwidth)
			{
				clientinfos.Bandwidth = 600;
			}
            var parameters = clientinfos;
            return parameters;
        },
        getServerParameters:function(){
            var servertPath = "x=InternetGatewayDevice.X_HW_DataModel.X_HW_IperfSpeedTest.IperfServer&RequestFile=html/ssmp/Sectionspeed/clientspeedResult.asp";
            var ParaList = 'DiagnosticsState&DestMac&Port&MaxTime&Result&ServerIP&ServerPort&ErrorDescription&ReportTime&TestResult&x.X_HW_Token=' + getValue('hwonttoken');
            var serverinfos = $.parseJSON(HwAjaxGetPara(servertPath, ParaList));
            var parameters = serverinfos;  
            return parameters;        
        },
        refreshData:function(inPutClick){
            var clientinfos = this.getClientParameters();
            var serverinfos = this.getServerParameters();
            var click = (undefined == inPutClick || inPutClick == null || 0 == inPutClick)?0:1;
            if("1" == click)
            {
                var scancesvalue = getSelectVal("sectionspeedScenes");
            }
            else
            {
                var scancesvalue;
                switch(SectionSpeedMode)
                {
                    case "1":
                        scancesvalue = "IPERF_TEST_REQUEST_GW_TO_INTERNET";
                        break;
                    case "2":
                        scancesvalue = "IPERF_TEST_REQUEST_AP_TO_GW";                                   
                        break;
                    case "3":
                        scancesvalue = "IPERF_TEST_REQUEST_AP_TO_AP";             
                        break;
                    case "4":
                        scancesvalue = "IPERF_TEST_REQUEST_AP_TO_INTERNET";            
                        break;
                    default:
                        break;
                }
                $("#sectionspeedScenes").val(scancesvalue);
            }
            
            switch(scancesvalue)
            {
                case "IPERF_TEST_REQUEST_GW_TO_INTERNET":
                    $("#loadingright").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingvertical").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingleft").css("background", "url(../../../images/BLine.jpg)");
                    setDisplay("macadress1Row",0);
                    setDisplay("macadress2Row",0);
                    setDisplay("listeningtimeRow",0);
                    setDisable("speedaddress",0);
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_GW":
                    $("#loadingvertical").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingleft").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingright").css("background", "url(../../../images/BLine.jpg)");
                    setDisplay("macadress1Row",1);
                    setDisplay("macadress2Row",0);
                    setDisable("speedaddress",1); 
                    $("#speedaddress").val("");
                    setDisplay("listeningtimeRow",1);
                    getElement("macadress1Colleft").innerHTML = sectionsectionspeed_language["section_apmac"];                                    
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_AP":
                    $("#loadingleft").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingright").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingvertical").css("background", "url(../../../images/BLine.jpg)");
                    setDisplay("macadress1Row",1);
                    setDisplay("macadress2Row",1);
                    setDisplay("listeningtimeRow",1);
                    setDisable("speedaddress",1); 
                    $("#speedaddress").val("");
                    getElement("macadress1Colleft").innerHTML = sectionsectionspeed_language["section_clientmac"];
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_INTERNET":
                    $("#loadingvertical").css("background", "url(../../../images/sLine.jpg)");
                    $("#loadingleft").css("background", "url(../../../images/BLine.jpg)");
                    $("#loadingright").css("background", "url(../../../images/BLine.jpg)");
                    setDisplay("macadress1Row",1);
                    setDisplay("macadress2Row",0);
                    setDisplay("listeningtimeRow",0);
                    setDisable("speedaddress",0);
                    getElement("macadress1Colleft").innerHTML = sectionsectionspeed_language["section_apmac"];              
                    break;
                default:
                    break;                
            }
            
            if("1" == click){
                this.ChangeaAdvance(1);
            }else{
                this.ChangeaAdvance(0);
            }

            switch(scancesvalue)
            {
                case "IPERF_TEST_REQUEST_GW_TO_INTERNET":
                    if("1" == click && SectionSpeedMode != "1"){
                        setText("speedaddress","")
                    }else{
                        setText("speedaddress",clientinfos.ServerAddr);
                    }
                    setSelect("sectionstatus",clientinfos.TestMode);
                    setText("sectionport",clientinfos.Port);
						
                    setSelect("sectionspeedtime",clientinfos.MaxTime);
                    setSelect("Threads",clientinfos.Parallel);
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_GW":
                    if("1" == click && SectionSpeedMode != "2"){
                        setText("speedaddress","");
                        setText("macadress1","");
                    }else{
                        setText("speedaddress",serverinfos.ServerIP);
                        setText("macadress1",clientinfos.DestMac);
                    }
                    setSelect("sectionstatus",clientinfos.TestMode);
                    setText("sectionport",serverinfos.Port);
                    setSelect("sectionspeedtime",clientinfos.MaxTime);
                    setSelect("listeningtime",serverinfos.MaxTime);
                    setSelect("Threads",clientinfos.Parallel);
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_AP": 
                    if("1" == click && SectionSpeedMode != "3"){
                        setText("speedaddress","");
                        setText("macadress1","");
                        setText("macadress2","");
                    }else{
                        setText("speedaddress",serverinfos.ServerIP);
                        setText("macadress1",clientinfos.DestMac);
                        setText("macadress2",serverinfos.DestMac);
                    }
                    setSelect("sectionstatus",clientinfos.TestMode);
                    setText("sectionport",serverinfos.Port);
                    setSelect("sectionspeedtime",clientinfos.MaxTime);
                    setSelect("listeningtime",serverinfos.MaxTime);
                    setSelect("Threads",clientinfos.Parallel);
                    break;
                case "IPERF_TEST_REQUEST_AP_TO_INTERNET":
                    if("1" == click && SectionSpeedMode != "4"){
                        setText("speedaddress","");
                        setText("macadress1","");
                    }else{
                        setText("speedaddress",clientinfos.ServerAddr);
                        setText("macadress1",clientinfos.DestMac);
                    }
                    setSelect("sectionstatus",clientinfos.TestMode);
                    setText("sectionport",clientinfos.Port);
                    setSelect("sectionspeedtime",clientinfos.MaxTime);
                    setSelect("Threads",clientinfos.Parallel);
                    break;
                default:
                    break;                
            }
	
            if ("IPERF_TEST_REQUEST_GW_TO_INTERNET" == scancesvalue || "IPERF_TEST_REQUEST_AP_TO_INTERNET" == scancesvalue)
            {
                this.getResults(clientinfos);
            }else{
                this.getResults(serverinfos);
            }
            
            if (clientinfos.ErrorDescription != "" && serverinfos.DiagnosticsState.toUpperCase() == "REQUESTED")
            {
                alert(sectionsectionspeed_language["section_clienterr"]);
                this.stopSectionSpeed2();
            }
        },
        getResults:function(result){
            var scancesvalue1 = getSelectVal("sectionspeedScenes");
            var scancesvalue2;
            switch(SectionSpeedMode)
            {
                case "1":
                    scancesvalue2 = "IPERF_TEST_REQUEST_GW_TO_INTERNET";
                    break;
                case "2":
                    scancesvalue2 = "IPERF_TEST_REQUEST_AP_TO_GW";                                   
                    break;
                case "3":
                    scancesvalue2 = "IPERF_TEST_REQUEST_AP_TO_AP";             
                    break;
                case "4":
                    scancesvalue2 = "IPERF_TEST_REQUEST_AP_TO_INTERNET";            
                    break;
                default:
                    break;
            }

            var showresult = "",htmlline = "", samphtmlline = "", sampresult = "", showsampresult = "", getResultsurl = "";

            if ("IPERF_TEST_REQUEST_GW_TO_INTERNET" == scancesvalue1 || "IPERF_TEST_REQUEST_AP_TO_INTERNET" == scancesvalue1 || "IPERF_TEST_REQUEST_AP_TO_GW" == scancesvalue1 || "IPERF_TEST_REQUEST_AP_TO_AP" == scancesvalue1)
            {
                getResultsurl = "clientspeedResult.asp";
            }
			else
			{
                getResultsurl = "serverspeedResult.asp"; 
            }

            $("#spedresult").siblings('.reslutclass').remove();
            $("#sampvalue").empty();
            this.unChangeable(1);
            if (result.DiagnosticsState.toUpperCase() != "REQUESTED")
            {
                this.unChangeable(0);
                clearInterval(time);
                var scancesvalue = getSelectVal("sectionspeedScenes");
                switch(scancesvalue)
                {
                    case "IPERF_TEST_REQUEST_GW_TO_INTERNET":
                        $("#loadingleft").css("background", "url(../../../images/BLine.jpg)");
                        break;
                    case "IPERF_TEST_REQUEST_AP_TO_GW":
                        $("#loadingright").css("background", "url(../../../images/BLine.jpg)");                                   
                        break;
                    case "IPERF_TEST_REQUEST_AP_TO_AP":
                        $("#loadingvertical").css("background", "url(../../../images/BLine.jpg)");
                        break;
                    case "IPERF_TEST_REQUEST_AP_TO_INTERNET":
                        $("#loadingleft").css("background", "url(../../../images/BLine.jpg)");
                        $("#loadingright").css("background", "url(../../../images/BLine.jpg)"); 
                        break;
                    default:
                        break;                
                }
            }
            
            if (result.DiagnosticsState.toUpperCase() != "REQUESTED")
            {
                $.ajax({
                    type  : "POST",
                    async : true,
                    cache : false,
                    url   : getResultsurl,
                    success : function(data) {
                        sampresult = dealDataWithFun(data);
                        if ("" == sampresult || scancesvalue1 != scancesvalue2)
                        {
                            samphtmlline = '<tr align="center" class="tabal_01"><td align="center">1s</td><td align="center">2s</td><td align="center">3s</td><td align="center">4s</td><td align="center">5s</td><td align="center">6s</td><td align="center">7s</td><td align="center">8s</td><td align="center">9s</td><td align="center">10s</td></tr><tr align="center" class="tabal_01"><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td></tr>';
                            samphtmlline += '<tr align="center" class="tabal_01"><td align="center" colspan="3">' + sectionsectionspeed_language["section_speedmin"] + '</td><td align="center" colspan="3">' + sectionsectionspeed_language["section_speedmax"] + '</td><td align="center" colspan="4">' + sectionsectionspeed_language["section_speedaverage"] + '</td></tr>';
                            samphtmlline += '<tr align="center" class="tabal_01"><td align="center" colspan="3">--</td><td align="center" colspan="3">--</td><td align="center" colspan="4">--</td></tr>';
                        }
                        else if (scancesvalue1 == scancesvalue2)
                        {
                            showsampresult =  $.parseJSON(sampresult);
                            var length = showsampresult.intervals.length;
                            var linehead = '<tr class="tabal_01">';
                            var linefoot = '</tr>';
                            var j = Math.floor(length/10);
                            var MaxValue = 0;
                            var MinValue = 0;
                            var TotalValue = 0;
                            var intervalValue = 0;
                            for(var z = 1; z < j+1; z++)
                            {    
                                var linecontitle1="";
                                var linecontent1="";
                                for (var i = 10*(z-1); i < 10*z; i++)
                                {
                                    for (key in showsampresult.intervals[i].sum)
                                    {
                                        if ("bits_per_second" == key)
                                        {
                                            intervalValue = Number((showsampresult.intervals[i].sum[key]/1000000).toFixed(2));
                                            TotalValue = TotalValue + Number(intervalValue);
                                            if (i == 0)
                                            {
                                                MaxValue = intervalValue;
                                                MinValue = intervalValue
                                            }
                                            else
                                            {
                                                if (parseFloat(MinValue) > parseFloat(intervalValue))
                                                {
                                                    MinValue = intervalValue;
                                                }
                                                if (parseFloat(MaxValue) < parseFloat(intervalValue))
                                                {
                                                    MaxValue = intervalValue;
                                                }
                                            }
                                            linecontitle1 += '<td align="center">'+(i+1)+"s"+'</td>';
                                            linecontent1 += '<td align="center">'+intervalValue+"Mbps"+'</td>';
                                            break;
                                        }
                                        
                                    }  
                                }
                                samphtmlline += linehead + linecontitle1 + linefoot + linehead + linecontent1 + linefoot;
                            }
                            samphtmlline += '<tr align="center" class="tabal_01"><td align="center" colspan="3">' + sectionsectionspeed_language["section_speedmin"] + '</td><td align="center" colspan="3">' + sectionsectionspeed_language["section_speedmax"] + '</td><td align="center" colspan="4">' + sectionsectionspeed_language["section_speedaverage"] + '</td></tr>';
                            samphtmlline += '<tr align="center" class="tabal_01"><td align="center" colspan="3">' + MinValue + 'Mbps</td><td align="center" colspan="3">' + MaxValue + 'Mbps</td><td align="center" colspan="4">' + (TotalValue/(j*10)).toFixed(2) + 'Mbps</td></tr>';
                        }
                        $("#sampvalue").append(samphtmlline);
                    }
                });
            }else{
                samphtmlline = '<tr align="center" class="tabal_01"><td align="center">1s</td><td align="center">2s</td><td align="center">3s</td><td align="center">4s</td><td align="center">5s</td><td align="center">6s</td><td align="center">7s</td><td align="center">8s</td><td align="center">9s</td><td align="center">10s</td></tr><tr align="center" class="tabal_01"><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td><td align="center">--</td></tr>';
                samphtmlline += '<tr align="center" class="tabal_01"><td align="center" colspan="3">' + sectionsectionspeed_language["section_speedmin"] + '</td><td align="center" colspan="3">' + sectionsectionspeed_language["section_speedmax"] + '</td><td align="center" colspan="4">' + sectionsectionspeed_language["section_speedaverage"] + '</td></tr>';
                samphtmlline += '<tr align="center" class="tabal_01"><td align="center" colspan="3">--</td><td align="center" colspan="3">--</td><td align="center" colspan="4">--</td></tr>';
                $("#sampvalue").append(samphtmlline);
            }
            
            if ((result.DiagnosticsState.toUpperCase() == "NONE") || (scancesvalue1 != scancesvalue2))
            {
                clearInterval(getfiletime);
                htmlline = '<tr align="center" class="tabal_01 reslutclass"><td align="center" class="width_per50">--</td><td align="center" class="width_per50">--</td></tr>';
            }
            else if (result.DiagnosticsState.toUpperCase() == "REQUESTED")
            {
                this.animationEffects();
                setDisable("ButtonApply",1);
                htmlline = '<tr align="center" class="tabal_01 reslutclass"><td colspan="2">'+sectionsectionspeed_language["section_speeding"]+'</td></tr>';
                htmlline += '<tr align="center" class="tabal_01 reslutclass"><td colspan="2"><img src="/html/ssmp/smblist/images/loadingAnimation.gif"></td></tr>';            
            }
            else if (scancesvalue1 == scancesvalue2 && result.DiagnosticsState.toUpperCase() == "COMPLETED")
            {
                setDisable("ButtonApply",0);
                setDisable("ButtonStop",1);
                clearInterval(getfiletime);
                if (result.Result == "2"){
                    showresult = result.ErrorDescription;
                    htmlline = '<tr align="left" class="tabal_01 reslutclass"><td colspan="2">'+showresult+'</td></tr>';                
                }else{
                    var clientinfos = this.getClientParameters();
                    showresult =  $.parseJSON(result.TestResult); 
                    if ("TCP" == clientinfos.ProtocolType)
                    {
                        htmlline = this.resultsTemplate(showresult.end.cpu_utilization_percent,"cpu_utilization_percent") 
                             + this.resultsTemplate(showresult.end.streams[0].sender,"streams_sender_1")
                             + this.resultsTemplate(showresult.end.streams[0].receiver,"streams_receiver_1");
                             if (showresult.end.streams.length >=2)
                             {
                                htmlline += this.resultsTemplate(showresult.end.streams[1].sender,"streams_sender_2")
                                + this.resultsTemplate(showresult.end.streams[1].receiver,"streams_receiver_2");
                             }
                             if (showresult.end.streams.length >=3)
                             {
                                htmlline += this.resultsTemplate(showresult.end.streams[2].sender,"streams_sender_3")
                                + this.resultsTemplate(showresult.end.streams[2].receiver,"streams_receiver_3");
                             }
                             if (showresult.end.streams.length >=4)
                             {
                                htmlline += this.resultsTemplate(showresult.end.streams[3].sender,"streams_sender_4")
                                + this.resultsTemplate(showresult.end.streams[3].receiver,"streams_receiver_4");
                             }
                             htmlline += this.resultsTemplate(showresult.end.sum_sent,"sum_sent")
                             + this.resultsTemplate(showresult.end.sum_received,"sum_received"); 
                    }
                    else
                    {
                        htmlline = this.resultsTemplate(showresult.end.cpu_utilization_percent,"cpu_utilization_percent") 
                             + this.resultsTemplate(showresult.end.streams[0].udp,"streams_udp_1");
                             if (showresult.end.streams.length >=2)
                             {
                                htmlline += this.resultsTemplate(showresult.end.streams[1].udp,"streams_udp_2");
                             }
                             if (showresult.end.streams.length >=3)
                             {
                                htmlline += this.resultsTemplate(showresult.end.streams[2].udp,"streams_udp_3");
                             }
                             if (showresult.end.streams.length >=4)
                             {
                                htmlline += this.resultsTemplate(showresult.end.streams[3].udp,"streams_udp_4");
                             }
                             htmlline += this.resultsTemplate(showresult.end.sum,"sum");
                    }
                                   
                    
                }               
            }
            $("#spedresult").after(htmlline);
        },
        resultsTemplate:function(result,str){
            var writeline = "";
            writeline += '<tr align="center" class="title50 tabal_01 reslutclass"><td colspan="2">'+str+'</td></tr>';            
                for (key in result){
                   if ("bits_per_second" == key)
                    { 
                        writeline += '<tr class="tabal_01 reslutclass"><td class="width_per50" align="left">'+key+'</td><td class="width_per50" align="left">'+result[key]+" ("+(result[key]/1000000).toFixed(2)+"Mbps)"+'</td></tr>';
                    }
                    else
                    {
                        writeline += '<tr class="tabal_01 reslutclass"><td class="width_per50" align="left">'+key+'</td><td class="width_per50" align="left">'+result[key]+'</td></tr>';
                    }
                }
            return  writeline;           
        },
        
        LoadFrame:function(){
            setDisplay("macadress1Row",0);
            setDisplay("macadress2Row",0);
            this.GetApMacList();
            this.Init();
            if (dethmaxisap == "1") {
                $("#sectionspeedScenes option[value=IPERF_TEST_REQUEST_GW_TO_INTERNET]").remove();
            }
        }
    };
    var sectionSpeed = new SectionSpeed();

    ParseBindTextByTagName(sectionsectionspeed_language, "span", 1);
    ParseBindTextByTagName(sectionsectionspeed_language, "input", 2);
    ParseBindTextByTagName(sectionsectionspeed_language, "td", 1);
    ParseBindTextByTagName(sectionsectionspeed_language, "div", 1);      
</script>
</html>