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
    <title>Speed</title>
</head>
<style>
    #speedurl{
        width: 95%;
    }
    #chooeswan{
        width: 50%;
    }
</style>
<body onload="SpeedModel.LoadFrame()" class="mainbody">
    <script>
        var curBinWord = "<%HW_WEB_GetBinMode();%>";
        if (curBinWord == 'E8C') {
            document.write('<script language="javascript" src="../../bbsp/common/wan_list_info_e8c.asp"><\/script>')
            document.write('<script language="javascript" src="../../bbsp/common/wan_list_e8c.asp"><\/script>')
        } else {
            document.write('<script language="javascript" src="../../bbsp/common/wan_list_info.asp"><\/script>')
            document.write('<script language="javascript" src="../../bbsp/common/wan_list.asp"><\/script>')
        }
    </script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(errdes.html);%>"></script> 
<script language="JavaScript" type="text/javascript">
var nohometitle = '<%HW_WEB_GetFeatureSupport(FT_WEB_NOHOME_TITLE);%>';
if (nohometitle == '1') {
    HWCreatePageHeadInfo("testspeedtitle", GetDescFormArrayById(testspeed_language, "speed_menu2"), GetDescFormArrayById(testspeed_language, "speed_title2"), false);
} else {
    HWCreatePageHeadInfo("testspeedtitle", GetDescFormArrayById(testspeed_language, "speed_menu"), GetDescFormArrayById(testspeed_language, "speed_title"), false);
}
</script>
<div class="title_spread"></div>
<form id="speedform">
    <table>
        <li  id="speedurl"        RealType="TextBox"           DescRef="web_speedurl"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" />
        <li  id="chooeswan"       RealType="DropDownList"      DescRef="web_choosewan"      RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" ClickFuncApp="onclick=SpeedModel.changeWanName"/>
        <li  id="Advancedconfig"  RealType="ButtonArea"        DescRef="web_advanceconfig"  RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" ClickFuncApp="onclick=SpeedModel.ShowAdvanced"/>
        <li  id="account"         RealType="TextBox"           DescRef="web_account"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" />
        <li  id="accountpassword" RealType="TextBox"           DescRef="web_password"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty" />             
        <li  id="speedstatus"     RealType="DropDownList"      DescRef="web_Upload"         RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'web_upload',Value:'0'},{TextRef:'web_download',Value:'1'}]" ClickFuncApp="onchange=SpeedModel.ChangeMethon"/>
        <li  id="Threads"         RealType="DropDownList"      DescRef="web_threads"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'web_numb1',Value:'1'},{TextRef:'web_numb2',Value:'2'},{TextRef:'web_numb3',Value:'3'},{TextRef:'web_numb4',Value:'4'},{TextRef:'web_numb5',Value:'5'},{TextRef:'web_numb6',Value:'6'},{TextRef:'web_numb7',Value:'7'},{TextRef:'web_numb8',Value:'8'}]" />
        <li  id="speedtime"       RealType="DropDownList"      DescRef="web_speedtime"      RemarkRef="web_mark"              ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="[{TextRef:'web_time0',Value:'0'},{TextRef:'web_time10',Value:'10'},{TextRef:'web_time20',Value:'20'},{TextRef:'web_time30',Value:'30'},{TextRef:'web_time40',Value:'40'},{TextRef:'web_time50',Value:'50'},{TextRef:'web_time60',Value:'60'}]"/>                                                  
    </table>
    <script>
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        HWParsePageControlByID("speedform", TableClass, testspeed_language, null);
    </script>
    <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
        <tr>
            <td class="width_per30"></td>
            <td class="table_submit pad_left5p">
                <input id="ButtonApply"  type="button" class="ApplyButtoncss buttonwidth_100px" BindText="web_apply" onClick="SpeedModel.setData()">
                <input id="ButtonStop" type="button"  class="CancleButtonCss buttonwidth_100px" BindText="web_cancel" onClick="SpeedModel.stopSpeed()">               
            </td>
        </tr>
    </table>    
</form>
<div class="title_spread"></div>
<div class="func_title" BindText="web_speedresult"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed;word-break:break-all">
    <tr id="spedresult" class="head_title">
        <td BindText="web_Attributes" class="width_per45"></td>
        <td BindText="web_value" class="width_per55"></td>
    </tr>
</table>
<div class="title_spread"></div>
<div style="display:none" id="samplist">
    <div class="func_title" BindText="web_sampvaluetitle"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed;word-break:break-all" id="sampvalue">
    </table>
</div>  
<div class="title_spread"></div>
</body>
<script type="text/javascript">
    var SpeedModel = (function(){
        var cachedata = "",urlvalue = "",advanceflag = "",pppoeflag = 0,time,submitflag,EnterFirstTime = true;
        var wanlist = GetWanList();
        var speedResult = <%HW_WEB_GetSpeedMethod();%>;
        var DelayTimeValue = '<%HW_WEB_GetSPEC(SPEC_TR143_DELAYTIME.UINT32);%>';
        var samplvalue = '<%HW_WEB_GetFeatureSupport(FT_SAMPLE_SPEEDTEST);%>';
        var getstatus = speedResult.split(";");
        var statusflag = (getstatus[0] == 1 || getstatus[0] == "" )?1:0;

        return{
            HWGetToken:function()
            {
                var tokenstring="";
                $.ajax({
                    type  : "POST",
                    async : false,
                    cache : false,
                    url   : "/html/ssmp/common/GetRandToken.asp",
                    success : function(data) 
                    {
                        tokenstring = data;
                    }
                    });
                return tokenstring;
            },
            InitReslutData:function(obj)
            {
                var testreslut = (getSelectVal("speedstatus") == 1)? obj[0]:obj[1];
                
                var writeline = "";
                var textdescription = {
                    "downFullLoading": testspeed_language["web_testreceload"],
                    "downdiagresult" : testspeed_language["web_downdiagresult"],
                    "downdiagconnect": testspeed_language["web_downdiagconnect"],
                    "downloadsport"  : testspeed_language["web_downloadsport"],
                    "downspeeding"   : testspeed_language["web_downspeeding"],
                    "upFullLoading"  : testspeed_language["web_testsentload"],
                    "updiagresult"   : testspeed_language["web_uploaddiagresult"],
                    "uploadsport"    : testspeed_language["web_uploadsport"],
                    "updiagconnect"  : testspeed_language["web_uploaddiagconnect"],
                    "upspeeding"     : testspeed_language["web_upspeeding"]
                };
                var Prefix = (getSelectVal("speedstatus") == 1)?"down":"up";

                $("#spedresult").siblings('.reslutclass').remove();

                if (testreslut[0].Diagspeed.toLowerCase() == "none")
                {
                    setDisplay("samplist",0);

                    SpeedModel.setInoperable(0);

                    writeline = '<tr align="center" class="tabal_01 reslutclass"><td align="center" class="width_per45">--</td><td align="center" class="width_per65">--</td></tr>';
                }
                else if (testreslut[0].Diagspeed.toLowerCase() == "requested")
                {
                    setDisplay("samplist",0);

                    SpeedModel.setInoperable(1);

                    writeline = '<tr align="center" class="tabal_01 reslutclass"><td colspan="2">'+textdescription[Prefix + "speeding"]+'</td></tr>';
                    writeline += '<tr align="center" class="tabal_01 reslutclass"><td colspan="2"><img src="/html/ssmp/smblist/images/loadingAnimation.gif"></td></tr>';
                }
                else
                {
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_status"]+'</td><td align="left">'+testreslut[0].Diagspeed+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_romtime"]+'</td><td align="left">'+testreslut[0].ROMTime+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_bomtime"]+'</td><td align="left">'+testreslut[0].BOMTime+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_eomtime"]+'</td><td align="left">'+testreslut[0].EOMTime+'</td></tr>';
                    if (getSelectVal("speedstatus") == 1)
                    {
                        writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_testbytes"]+'</td><td align="left">'+testreslut[0].TestBytesReceived+'</td></tr>';
                    }
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_totalrecevied"]+'</td><td align="left">'+testreslut[0].TotalBytesReceived+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_tcpopenresq"]+'</td><td align="left">'+testreslut[0].TCPOpenRequestTime+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_tcpopenresp"]+'</td><td align="left">'+testreslut[0].TCPOpenResponseTime+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_totalsent"]+'</td><td align="left">'+testreslut[0].TotalBytesSent+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+textdescription[Prefix + "FullLoading"]+'</td><td align="left">'+testreslut[0].TestBytesReceivedUnderFullLoading+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_totalrece"]+'</td><td align="left">'+testreslut[0].TotalBytesReceivedUnderFullLoading+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_totalsentload"]+'</td><td align="left">'+testreslut[0].TotalBytesSentUnderFullLoading+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_perload"]+'</td><td align="left">'+testreslut[0].PeriodOfFullLoading+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_pernumber"]+'</td><td align="left">'+testreslut[0].PerConnectionResultNumberOfEntries+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left" id="downdiagresult">'+textdescription[Prefix + "diagresult"]+'</td><td align="left">'+testreslut[0].DiagnosticsMaxIncrementalResult+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+testspeed_language["web_ipaddused"]+'</td><td align="left">'+testreslut[0].IPAddressUsed+'</td></tr>';
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left">'+textdescription[Prefix + "loadsport"]+'</td><td align="left">'+testreslut[0].Transports+'</td></tr>';                    
                    writeline += '<tr align="left" class="tabal_01 reslutclass"><td class="width_per45" align="left" id="downdiagconnect">'+textdescription[Prefix + "diagconnect"]+'</td><td align="left">'+testreslut[0].DiagnosticMaxConnections+'</td></tr>';
                    if (samplvalue == "1")
                    {
                        setDisplay("samplist",1);

                        SpeedModel.InitSampl(testreslut[0].SampledValues);                        
                    }

                    setDisable("ButtonStop",1);
					
                    SpeedModel.setInoperable(0);

                }
                
                if(pppoeflag) setDisable("speedstatus",1);

                $("#spedresult").after(writeline);
            },
            SingleSampl:function(obj,num)
            {
                var sampllen = obj.length;
                var headline='<tr align="center" class="tabal_01">',footline = "</tr>";
                var timelline = "",samplline="",samplstr = "";
                for (var i = 1; i <= 10; i++)
                {
                    var temptime = num*10 + i * 1;
                    var tmpstr = (sampllen >= i)?temptime+'s':"";
                    if (obj[i-1] == undefined)obj[i-1] = "";
                    timelline += '<td align="center">'+tmpstr+'</td>';
                    samplline += '<td align="center">'+obj[i-1]+'</td>';
                }
                samplstr = headline + timelline + footline + headline + samplline + footline;
                return  samplstr;         
            },
            InitSampl:function(obj)
            {
                var samplsplit = obj.split("|");
                var sampllen = samplsplit.length;
                var sampline = "";
                $("#sampvalue").empty();
                for (var i = 0; i < Math.ceil(sampllen/10); i++)
                {
                    var temparr = samplsplit.slice((i*10),(10+i*10));
                    
                    if (!temparr.length)
                    {
                        continue;
                    }
                    sampline += SpeedModel.SingleSampl(temparr,i);
                }
                $("#sampvalue").append(sampline);
            },
            Init:function(marked)
            {
                var result = SpeedModel.getAjax();

                var diagstatus = "";
                
                if (marked !=undefined)
                {
                    statusflag = marked;
                }
                var testreslut = (statusflag == 1)? result[0]:result[1];

                if (getstatus[1] == undefined)
                {
                    advanceflag = 0;
                }
                else
                {
                    advanceflag = getstatus[1];
                }

                if (testreslut.length ==1)
                {
                    setSelect("Threads",1);

                    setSelect("speedtime",30);

                    setText("speedurl","");
                }
                else
                {
                    var temptime = (testreslut[0].TimeBasedTestDuration==0)?testreslut[0].TimeBasedTestDuration:testreslut[0].TimeBasedTestDuration*1-DelayTimeValue*1;

                    diagstatus = testreslut[0].Diagspeed.toLowerCase();

                    setSelect("Threads",testreslut[0].NumberOfConnections);

                    setSelect("speedtime",temptime);

                    setText("speedurl",testreslut[0].UrlDiagnosticsState);
                }

                setDisable("ButtonStop",1);

                if (diagstatus == "requested")
                {
                    setDisable("ButtonApply",1);
                    setDisable("ButtonStop",0);
                }
            },
            InitWanList:function()
            {
                $("#chooeswan").empty();

                var output = "",fristwan = new Array();

                var result = SpeedModel.getAjax();

                var testreslut = (statusflag == 1)? result[0]:result[1];

                for (var i = 0; i < wanlist.length; i++) 
                {
                    if (wanlist[i].ServiceList.indexOf("INTERNET") >=0)
                    {
                        fristwan.push(wanlist[i].domain);
                    }
                    output += '<option value=' + wanlist[i].domain + ' id="' + htmlencode(wanlist[i].Name) + '"  title="' + htmlencode(wanlist[i].Name) +'">' + htmlencode(wanlist[i].Name) + '</option>';
                }

                $("#chooeswan").append(output);

                if (testreslut[0].Interface =="" && fristwan != "")
                {
                    setSelect("chooeswan",fristwan[0]);
                }
                else
                {
                    setSelect("chooeswan",RemoveDomainPoint(testreslut[0].Interface));
                }
                
                setSelect("speedstatus",statusflag);

                SpeedModel.changeWanName();

                SpeedModel.ShowAdvanced();
            },           
            ChangeMethon:function()
            {
                var result = SpeedModel.getAjax();
                EnterFirstTime = false;
                SpeedModel.InitReslutData(result);
                SpeedModel.Init(getSelectVal("speedstatus"));
                SpeedModel.InitWanList();
            },
            changeWanName:function()
            {
                var  pppoename = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_PPPOE_EMLUATOR.Username);%>';
                for (var i = wanlist.length - 1; i >= 0; i--) 
                {
                    if (getSelectVal("chooeswan") == wanlist[i].domain)
                    {
                        if (wanlist[i].Mode.toLowerCase().indexOf("bridge") >=0 && wanlist[i].EncapMode.toLowerCase() == "pppoe")
                        {
                            pppoeflag = 1,advanceflag = 1;
                            if (pppoename != "")
                            {
                                setText("account",pppoename);
                                setText("accountpassword","********************************");
                            }
                            setSelect("speedstatus",1);
                            setDisable("speedstatus",1);
                            SpeedModel.showAdvance(1);
                        }
                        else
                        {
                            pppoeflag = 0;
                            setDisable("speedstatus",0);
                            SpeedModel.showAdvance(0);
                        }                        
                    }
                }                
            },
            setInoperable:function(flag)
            {
                setDisable("speedurl",flag);

                setDisable("chooeswan",flag);

                setDisable("Advancedconfig",flag);

                setDisable("account",flag);

                setDisable("accountpassword",flag);

                setDisable("speedstatus",flag);

                setDisable("Threads",flag);

                setDisable("speedtime",flag);
            },
            CheckParam:function(str)
            {
                var urlprotocol = str.split("://");
                if (urlprotocol[0].toLowerCase().indexOf("http") == -1 && urlprotocol[0].toLowerCase().indexOf("ftp") == -1)
                {
                    AlertEx(testspeed_language["web_errorurl"]);
                    return false;
                }

                if (urlprotocol[1] != undefined && urlprotocol[1].indexOf("/") == -1)
                {
                    AlertEx(testspeed_language["web_errorurl"]);
                    return false;
                }
                return true;
            },
            setPPPoEAccount:function()
            {
                var parainfo = "";
                if (getValue("account") == "" || getValue("accountpassword") == "")
                {
                    AlertEx(testspeed_language["web_erroraccount"]);

                    setDisable("ButtonApply",0);

                    return false;                
                }
                parainfo += "x.Username=" + FormatUrlEncode(getValue("account"));
                if (getValue("accountpassword") != "" && getValue("accountpassword") != "********************************")
                {
                    parainfo += "&x.Password=" + FormatUrlEncode(getValue("accountpassword"));
                }

                parainfo+='&x.X_HW_Token=' + SpeedModel.HWGetToken();
                $.ajax({
                    type  : "POST",
                    async : false,
                    cache : false,
                    data  : parainfo,
                    url   : "set.cgi?x=InternetGatewayDevice.X_HW_PPPOE_EMLUATOR&RequestFile=html/ssmp/testspeed/testspeed.asp",
                    success : function(data) {
                        SpeedModel.setRouteSpeed();
                    }
                });
            },
            setRouteSpeed:function()
            {
                var downloadurl = "setajax.cgi?x=InternetGatewayDevice.DownloadDiagnostics&RequestFile=html/ssmp/testspeed/testspeed.asp";

                var uploadurl ="setajax.cgi?x=InternetGatewayDevice.UploadDiagnostics&RequestFile=html/ssmp/testspeed/testspeed.asp";

                var statusurl = (getSelectVal("speedstatus") == 1)? downloadurl:uploadurl;
                
                var temp = DelayTimeValue * 1 + getSelectVal("speedtime") * 1;

                var submittime = (getSelectVal("speedtime") == 0)?getSelectVal("speedtime"):temp;

                var parainfo = "";

                if (getSelectVal("speedstatus") == 1)
                {
                    parainfo += "x.DownloadURL=" + getValue("speedurl");
                }
                else
                {
                    parainfo += "&x.UploadURL=" + getValue("speedurl");
                }
                parainfo += "&x.NumberOfConnections=" + getSelectVal("Threads");

                parainfo += "&x.Interface=" + getSelectVal("chooeswan");

                parainfo += "&x.TimeBasedTestDuration=" + submittime;

                parainfo += "&x.DiagnosticsState=Requested";

                parainfo += "&x.X_HW_Token=" + SpeedModel.HWGetToken();

                $.ajax({
                    type  : "POST",
                    async : false,
                    cache : false,
                    data  : parainfo,
                    url   : statusurl,
                    success : function(data) {
                        var ResultInfo = JSON.parse(hexDecode(data));
                        if (ResultInfo.result != 0)
                        {
                            AlertEx(errLanguage['s0xf7205001']);
                            setDisable("ButtonApply",0);
                            return false;
                        }
                        SpeedModel.getAjax();
                        SpeedModel.getData(); 
                    }
                });                 
            },
            setData:function()
            {
                if (!SpeedModel.CheckParam(getValue("speedurl")))
                {
                    return false;
                }            
                setDisable("ButtonApply",1);

                var parainfo = "";

                parainfo += "SpeedMode=" + getSelectVal("speedstatus");

                parainfo += "&SpeedAdv=" + submitflag;

                parainfo += "&SpeedStatus=None";

                parainfo+='&x.X_HW_Token=' + SpeedModel.HWGetToken();

                $.ajax({
                    type  : "POST",
                    async : false,
                    cache : false,
                    data  : parainfo,
                    url   : "stopspeed.cgi?&RequestFile=html/ssmp/testspeed/testspeed.asp",
                    success : function(data) {

                    }
                });                    

                if (!pppoeflag)
                {
                    SpeedModel.setRouteSpeed();
                }
                else
                {
                    SpeedModel.setPPPoEAccount();
                }            
            },
            getAjax:function()
            {
                var result = "";
                $.ajax({
                    type  : "POST",
                    async : false,
                    cache : false,
                    url   : "speedResult.asp",
                    success : function(data) {

                        result = dealDataWithFun(data);

                        var testreslut = (getSelectVal("speedstatus") == "1")? result[0]:result[1];

                        var diagstatus = testreslut[0].Diagspeed.toLowerCase();
                        
                        if (diagstatus != "requested")
                        {
                            setDisable("ButtonApply",0);
                            clearInterval(time);
                        }
                        else if(diagstatus == "requested")
                        {
                            setDisable("ButtonApply",1);
                            setDisable("ButtonStop",0); 
                        }

                        SpeedModel.InitReslutData(result);
                    }
                });
                return result;
            },
            getData:function()
            {
              if (time) {
                clearInterval(time);
              }
              time = setInterval("SpeedModel.getAjax()", 1000);
            },
            stopSpeed:function()
            {
                setDisable("ButtonApply",0);                
                setDisable("ButtonStop",1);

                var parainfo = "";
                parainfo += "SpeedMode=" + getSelectVal("speedstatus");
                parainfo += "&SpeedAdv=" + submitflag;
                parainfo += "&SpeedStatus=" + statusflag;
                parainfo += "&x.X_HW_Token=" + SpeedModel.HWGetToken();
                $.ajax({
                    type  : "POST",
                    async : true,
                    cache : false,
                    data  : parainfo,
                    url   : "stopspeed.cgi?&RequestFile=html/ssmp/testspeed/testspeed.asp",
                    success : function(data) {

                        var result = SpeedModel.getAjax();

                        SpeedModel.InitReslutData(result);       
                    }
                });                                
            },
            showAdvance:function(flag)
            {
                setDisplay("ThreadsRow",flag);

                setDisplay("speedtimeRow",flag);

                setDisplay("speedstatusRow",flag);

                setDisplay("accountRow",flag);

                setDisplay("accountpasswordRow",flag);
            },
            ShowAdvanced:function()
            {
                if (advanceflag == "1")
                {
                    SpeedModel.showAdvance(advanceflag);
                    advanceflag = 0;
                    submitflag = 1;
                }
                else
                {
                    SpeedModel.showAdvance(advanceflag);
                    advanceflag = 1; 
                    submitflag = 0;                   
                }

            },
            LoadFrame:function ()
            {
                SpeedModel.showAdvance(0);

                SpeedModel.Init();

                SpeedModel.InitWanList();

                SpeedModel.getData(); 
            } 
        };
    })();
    ParseBindTextByTagName(testspeed_language, "span", 1);
    ParseBindTextByTagName(testspeed_language, "input", 2);
    ParseBindTextByTagName(testspeed_language, "td", 1);
    ParseBindTextByTagName(testspeed_language, "div", 1);      
</script>
</html>