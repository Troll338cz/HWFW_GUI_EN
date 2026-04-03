<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>DosFilter</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" src="<%HW_WEB_GetReloadCus(html/bbsp/Dos/Dos.cus);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var curUserType='<%HW_WEB_GetUserType();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var COMMONV5FirewallFT = '<%HW_WEB_GetFeatureSupport(BBSP_FT_FIREWALL_COMMONV5);%>';
var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();
var isMegacableFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
var PortScanEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.PortScanEnable);%>';

function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
}

function IsSonetAndMobily()
{
    if((SonetFlag == '1' || "1" == GetCfgMode().MOBILY)
        && curUserType != '0')
    {
        return true;
    }
    else
    {
        return false;
    }
}

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
        setObjNoEncodeInnerHtmlValue(b, dos_language[b.getAttribute("BindText")]);
    }
}

function stDos(domain,SynFloodEn,IcmpEchoReplyEn,IcmpRedirectEn,LandEn,SmurfEn,WinnukeEn,PingSweepEn,FragmentFloodEn)
{
    this.domain = domain;
    this.SynFloodEn = SynFloodEn;
    this.IcmpEchoReplyEn = IcmpEchoReplyEn;
    this.IcmpRedirectEn = IcmpRedirectEn;
    this.LandEn = LandEn;    
    this.SmurfEn = SmurfEn;    
    this.WinnukeEn = WinnukeEn;    
    this.PingSweepEn = PingSweepEn;    
    this.FloodProtectEn = IcmpEchoReplyEn && PingSweepEn;
    this.FragmentFloodEn = FragmentFloodEn;
}

var DosFilters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Dosfilter,SynFloodEn|IcmpEchoReplyEn|IcmpRedirectEn|LandEn|SmurfEn|WinnukeEn|PingSweepEn|FragmentFloodEn,stDos);%>

var DosFilter = DosFilters[0];

function LoadFrame()
{    
    with (document.getElementById("TableConfigInfo"))
    {
        if (DosFilter != null)
        {
            setCheck('synFlooding',DosFilter.SynFloodEn);
            if (ProductType != '2')
            {
                setCheck('icmpEcho',DosFilter.IcmpEchoReplyEn);
            }
            setCheck('icmpRedirect',DosFilter.IcmpRedirectEn);
            setCheck('land',DosFilter.LandEn);
            setCheck('smurf',DosFilter.SmurfEn);
            setCheck('winnuke',DosFilter.WinnukeEn);            
            if (ProductType == '2')
            {
                setCheck('floodprotect', DosFilter.FloodProtectEn);
            }
            else
            {
                setCheck('pingsweep', DosFilter.PingSweepEn); 
            }
            if (CfgModeWord == "EGVDF2") {
                setCheck('portscan', PortScanEnable);
                setCheck('fragmentflood', DosFilter.FragmentFloodEn);
            }
        }
    }
    
    if("undefined" != typeof(CusLoadFrame))
    {
		if(1 != COMMONV5FirewallFT)
		{
			CusLoadFrame();
		}
    }

    if (((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) && (FltsecLevel != 'CUSTOM')) {
        initCntDisable();
    }

    if (isMegacableFlag == "1") {
        setDisable('synFlooding',1);
        setDisable('icmpEcho',1);
        setDisable('icmpRedirect',1);
        setDisable('land',1);
        setDisable('smurf',1);
        setDisable('winnuke',1);
        setDisable('pingsweep',1);
    }

    loadlanguage();   
}

function CheckForm(type)
{
    return true;
}

function AddSubmitParaScanEn()
{
    var PortScanEnable = (getElement('portscan').checked == true) ? 1 : 0;
    var RequestFile = '&RequestFile=html/bbsp/Dos/Dos.asp';
    var parainfo = "&x.PortScanEnable=" + PortScanEnable;
    parainfo += '&x.X_HW_Token=' + getValue('onttoken');
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        data : parainfo,
        url : 'set.cgi?x=InternetGatewayDevice.X_HW_Security' + RequestFile,
        success : function(data) {
        }
    });
}

function AddSubmitParam()
{

    var IcmpEchoReplyEn = 0;
    var PingSweepEn = 0;
    if (ProductType == '2')
    {
        var FloodProtectEn = (getElement('floodprotect').checked == true) ? 1 : 0;
        IcmpEchoReplyEn = FloodProtectEn;
        PingSweepEn = FloodProtectEn;
    }
    else
    {
        IcmpEchoReplyEn = (getElement('icmpEcho').checked == true) ? 1 : 0;
        PingSweepEn = (getElement('pingsweep').checked == true) ? 1 : 0;
    }
    
    var SynFloodEn = (getElement('synFlooding').checked == true) ? 1 : 0;
    var IcmpRedirectEn = (getElement('icmpRedirect').checked == true) ? 1 : 0;
    var LandEn = (getElement('land').checked == true) ? 1 : 0;
    var SmurfEn = (getElement('smurf').checked == true) ? 1 : 0;
    var WinnukeEn = (getElement('winnuke').checked == true) ? 1 : 0;    
    
    var DosSpecCfgParaList = new Array(new stSpecParaArray("x.SynFloodEn",SynFloodEn, 1),
                                    new stSpecParaArray("x.IcmpEchoReplyEn",IcmpEchoReplyEn, 1),
                                    new stSpecParaArray("x.IcmpRedirectEn",IcmpRedirectEn, 1),
                                    new stSpecParaArray("x.LandEn",LandEn, 1),
                                    new stSpecParaArray("x.SmurfEn",SmurfEn, 1),
                                    new stSpecParaArray("x.WinnukeEn",WinnukeEn, 1),
                                    new stSpecParaArray("x.PingSweepEn",PingSweepEn, 1));
	if (CfgModeWord == "EGVDF2") {
        AddSubmitParaScanEn();
        var FragmentFloodEn = (getElement('fragmentflood').checked == true) ? 1 : 0;
        DosSpecCfgParaList = new Array(new stSpecParaArray("x.SynFloodEn",SynFloodEn, 1),
                                    new stSpecParaArray("x.IcmpEchoReplyEn",IcmpEchoReplyEn, 1),
                                    new stSpecParaArray("x.IcmpRedirectEn",IcmpRedirectEn, 1),
                                    new stSpecParaArray("x.LandEn",LandEn, 1),
                                    new stSpecParaArray("x.SmurfEn",SmurfEn, 1),
                                    new stSpecParaArray("x.WinnukeEn",WinnukeEn, 1),
                                    new stSpecParaArray("x.FragmentFloodEn",FragmentFloodEn, 1),
                                    new stSpecParaArray("x.PingSweepEn",PingSweepEn, 1));
    }
    var Parameter = {};
    Parameter.asynflag = null;
    Parameter.FormLiList = DosConfigFormList;
    Parameter.OldValueList = null;
    Parameter.SpecParaPair = DosSpecCfgParaList;
    var url = 'set.cgi?x=InternetGatewayDevice.X_HW_Security.Dosfilter'
                   + '&RequestFile=html/bbsp/Dos/Dos.asp';
    var tokenvalue = getValue('onttoken');
    HWSetAction(null, url, Parameter, tokenvalue);
    setDisable('btnApply_ex',1);
    setDisable('cancelValue',1);
}

function showInfo(id)
{        
    if (id == 0)
    {
        setDisplay('synId',0);
        setDisplay('icmpEchoId',0);
        setDisplay('icmpRedId',0);
        setDisplay('landId',0);
        setDisplay('smurfId',0);
        setDisplay('winnukeId',0);        
    }
    else if (id == 1)
    {
        setDisplay('synId',1);
        setDisplay('icmpEchoId',0);
        setDisplay('icmpRedId',0);
        setDisplay('landId',0);
        setDisplay('smurfId',0);
        setDisplay('winnukeId',0);           
    }
    else if (id == 2)
    {
        setDisplay('synId',0);
        setDisplay('icmpEchoId',1);
        setDisplay('icmpRedId',0);
        setDisplay('landId',0);
        setDisplay('smurfId',0);
        setDisplay('winnukeId',0);           
    }
    else if (id == 3)
    {
        setDisplay('synId',0);
        setDisplay('icmpEchoId',0);
        setDisplay('icmpRedId',1);
        setDisplay('landId',0);
        setDisplay('smurfId',0);
        setDisplay('winnukeId',0);           
    }
    else if (id == 4)
    {
        setDisplay('synId',0);
        setDisplay('icmpEchoId',0);
        setDisplay('icmpRedId',0);
        setDisplay('landId',1);
        setDisplay('smurfId',0);
        setDisplay('winnukeId',0);           
    }
    else if (id == 5)
    {
        setDisplay('synId',0);
        setDisplay('icmpEchoId',0);
        setDisplay('icmpRedId',0);
        setDisplay('landId',0);
        setDisplay('smurfId',1);
        setDisplay('winnukeId',0);           
    } 
    else if (id == 6)
    {
        setDisplay('synId',0);
        setDisplay('icmpEchoId',0);
        setDisplay('icmpRedId',0);
        setDisplay('landId',0);
        setDisplay('smurfId',0);
        setDisplay('winnukeId',1);           
    }           
}

function initCntDisable() {
    setDisable('btnApply_exRow',1);
    setDisable('cancelValueRow',1);
    document.getElementById("synFloodingColleft").style.color="#767676";
    document.getElementById("icmpEchoColleft").style.color="#767676";
    document.getElementById("icmpRedirectColleft").style.color="#767676";
    document.getElementById("landColleft").style.color="#767676";
    document.getElementById("smurfColleft").style.color="#767676";
    document.getElementById("winnukeColleft").style.color="#767676";
    document.getElementById("pingsweepColleft").style.color="#767676";
    if (CfgModeWord == "EGVDF2") {
        document.getElementById("portscanColleft").style.color="#767676";
        document.getElementById("fragmentfloodColleft").style.color="#767676";
    }
}
function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
if ((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) {
    HWCreatePageHeadInfo("dos", GetDescFormArrayById(dos_language, "bbsp_mune"), GetDescFormArrayById(dos_language, "bbsp_dos_title_cnt"), false);
} else {
    HWCreatePageHeadInfo("dos", GetDescFormArrayById(dos_language, "bbsp_mune"), GetDescFormArrayById(dos_language, "bbsp_dos_title"), false);
}
if (IsNeedAddSafeDesForBelTelecom() == true) {
    document.getElementById("dos_content").innerHTML = dos_language['bbsp_dos_title'] + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>";
}
</script>
<div class="title_spread"></div>
<form id="TableConfigInfo" style="display:block;"> 
    <table border="0" cellpadding="0" cellspacing="1"  width="100%"> 
        <li   id="synFlooding"           RealType="CheckBox"           DescRef="bbsp_dossynmh"            RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SynFloodEn"         InitValue="1" />
        <script language="JavaScript" type="text/javascript">
            if(ProductType != '2')
            {
                document.write("\<li   id=\"icmpEcho\"               RealType=\"CheckBox\"         DescRef=\"bbsp_dosigmp1mh\"               RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"x.IcmpEchoReplyEn\"              InitValue=\"1\"\/\> ");
            }
        </script>
        <li   id="icmpRedirect"          RealType="CheckBox"           DescRef="bbsp_dosigmp2mh"          RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.IcmpRedirectEn"     InitValue="1" />
        <li   id="land"                  RealType="CheckBox"           DescRef="bbsp_doslandmh"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.LandEn"             InitValue="1" />
        <li   id="smurf"                 RealType="CheckBox"           DescRef="bbsp_dossmurfmh"          RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.SmurfEn"            InitValue="1" />
        <li   id="winnuke"               RealType="CheckBox"           DescRef="bbsp_doswinnukemh"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.WinnukeEn"          InitValue="1" />
        <script language="JavaScript" type="text/javascript">
            if(ProductType == '2')
            {
                document.write("\<li   id=\"floodprotect\"               RealType=\"CheckBox\"         DescRef=\"bbsp_dosfloodprotmh\"               RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"              InitValue=\"1\"\/\> ");
            }
            else
            {
                document.write("\<li   id=\"pingsweep\"               RealType=\"CheckBox\"         DescRef=\"bbsp_dospingmh\"               RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"x.PingSweepEn\"              InitValue=\"1\"\/\> ");
            }
        </script>
        <script language="JavaScript" type="text/javascript">
            if (CfgModeWord == "EGVDF2") {
                document.write("\<li   id=\"portscan\"               RealType=\"CheckBox\"         DescRef=\"bbsp_dosportscan\"               RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"              InitValue=\"1\"\/\> ");
                document.write("\<li   id=\"fragmentflood\"           RealType=\"CheckBox\"         DescRef=\"bbsp_dosfragmentflood\"          RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"\"              InitValue=\"1\"\/\> ");
            }
        </script>
    </table>
    <script language="JavaScript" type="text/javascript">
        var TableClass = new stTableClass("width_per40", "table_right width_per60", "ltr");
        DosConfigFormList = HWGetLiIdListByForm("TableConfigInfo", DosReload);
        HWParsePageControlByID("TableConfigInfo", TableClass, dos_language, DosReload);
          
        getElById("synFlooding").title     = dos_language['bbsp_syntitle'];
        if(ProductType != '2')
        {
            getElById("icmpEcho").title     = dos_language['bbsp_igmp1title'];
        }
        getElById("icmpRedirect").title = dos_language['bbsp_igmp2title'];
        getElById("land").title         = dos_language['bbsp_landtitle'];
        getElById("smurf").title        = dos_language['bbsp_smurftitle'];
        getElById("winnuke").title        = dos_language['bbsp_winnuketitle'];
        if(ProductType == '2')
        {
            getElById("floodprotect").title = dos_language['bbsp_pingtitle'];
        }
        else
        {
            getElById("pingsweep").title     = dos_language['bbsp_pingtitle'];
        }
        
    </script>
    <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="table_button"> 
        <tr> 
            <td class='width_per25'></td> 
            <td class="table_submit"> 
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id='btnApply_ex' name="btnApply_ex" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="AddSubmitParam();"><script>document.write(dos_language['bbsp_app']);</script></button> 
            <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(dos_language['bbsp_cancel']);</script></button> </td> 
        </tr> 
    </table> 
</form>
</body>
</html>
