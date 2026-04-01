<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="Javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>

<title>Optic information</title>

<style>
.dragbar
{
    height:15px;
    background-Image:url("../../../images/scale.gif");
}

.draghandle
{
    height: 15px;
    width: 28px;
    border: 1px solid #444;
    overflow: hidden;
    background: #3d642d;
    top: 0px;
    left: 0px;
    z-index: 10;
    cursor: pointer;
    position: absolute;
}
</style>

<script language="JavaScript" type="text/javascript">
var ProductType = '<%HW_WEB_GetProductType();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var SfpExInfoFlag = '<%HW_WEB_GetFeatureSupport(AMP_FT_EXINFO_OPTIC);%>';
var FtXdPonSupport = '<%HW_WEB_GetFeatureSupport(FT_XD_PON_SURPPORTED);%>';

function stStats(domain,ErrorsSent,ErrorsReceived,DiscardPacketsReceived,BytesSent,BytesReceived,PacketsSent,PacketsReceived)
{
    this.domain = domain;
    this.ErrorsSent = ErrorsSent;
    this.ErrorsReceived = ErrorsReceived;
    this.DiscardPacketsReceived = DiscardPacketsReceived;
	this.BytesSent = BytesSent;
    this.BytesReceived = BytesReceived;
    this.PacketsSent = PacketsSent;
    this.PacketsReceived = PacketsReceived;
}
var Stats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.X_GponInterafceConfig.Stats,ErrorsSent|ErrorsReceived|DiscardPacketsReceived|BytesSent|BytesReceived|PacketsSent|PacketsReceived,stStats);%>;
var Stat = Stats[0];

if (ProductType == '2' && ontPonMode != 'gpon')
{
    function stOpticInfo(domain,LinkStatus,transOpticPower,revOpticPower,voltage,temperature,bias,rfRxPower,rfOutputPower,VendorName,VendorSN)
    {
        this.domain = domain;
        this.LinkStatus = LinkStatus;
        this.transOpticPower = transOpticPower;
        this.revOpticPower = revOpticPower;
        this.voltage = voltage;
        this.temperature = temperature;
        this.bias = bias;
        this.rfRxPower = rfRxPower;
        this.rfOutputPower = rfOutputPower;
        this.VendorName = VendorName;
        this.VendorSN = VendorSN;
    }
}
else
{
    function stOpticInfo(domain,LinkStatus,transOpticPower,revOpticPower,voltage,temperature,bias,rfRxPower,rfOutputPower, VendorName, VendorSN, DateCode, TxWaveLength, RxWaveLength, MaxTxDistance, LosStatus)
    {
        this.domain = domain;
        this.LinkStatus = LinkStatus;
        this.transOpticPower = transOpticPower;
        this.revOpticPower = revOpticPower;
        this.voltage = voltage;
        this.temperature = temperature;
        this.bias = bias;
        this.rfRxPower = rfRxPower;
        this.rfOutputPower = rfOutputPower;
        this.VendorName = VendorName;
        this.VendorSN = VendorSN;
        this.DateCode = DateCode;
        this.TxWaveLength = TxWaveLength;
        this.RxWaveLength = RxWaveLength;
        this.MaxTxDistance = MaxTxDistance;
        this.LosStatus = LosStatus;

    }
}

function stOLTOpticInfo(domain,BudgetClass,TxPower,PONIdentifier)
{
    this.domain = domain;
    this.BudgetClass = BudgetClass;
    this.TxPower = TxPower;
    this.PONIdentifier = PONIdentifier;
}


var OltOptics = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.OltOptic,BudgetClass|TxPower|PONIdentifier, stOLTOpticInfo);%>;
var OltOptic = OltOptics[0];
if(null == OltOptic)
{
    OltOptic = new stOLTOpticInfo('InternetGatewayDevice.X_HW_DEBUG.AMP.OltOptic', '--', '--', '');
}

var opticInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic,LinkStaus|TxPower|RxPower|Voltage|Temperature|Bias|RfRxPower|RfOutputPower|VendorName|VendorSN|DateCode|TxWaveLength|RxWaveLength|MaxTxDistance|LosStatus, stOpticInfo);%>;
var opticInfo = opticInfos[0];
var status = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptTxMode.TxMode);%>';
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var ontXGMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.XG_AccessMode);%>';
if ((ontPonMode == 'gpon') || (ontPonMode.indexOf("gpon")) > 0)
{
    ontPonMode = 'gpon';
}
else if ((ontPonMode == 'epon') || (ontPonMode.indexOf("epon")) > 0)
{
    ontPonMode = 'epon';
}
else
{
    ontPonMode = 'ge';
}

var ontPonRFNum = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.RF.RfPortNum);%>';
if ('' == ontPonRFNum)
{
    ontPonRFNum = '0';
}
var opticPower = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.SMP.APM.ChipStatus.Optical);%>';
var opticStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptStaus.status);%>';
var opticType = '<%HW_WEB_GetOpticType();%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var curWebFrame='<%HW_WEB_GetWEBFramePath();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';
var IPOnlyFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
var telmexSpan = false;
var RFAdjustFlag = false;
var ont2onrEnable = 0;
var onr = new Array('amp_optinfo_ontinfo');
var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';

if ((1 == '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>') && ('ENGLISH' == curLanguage.toUpperCase()))
{
    ont2onrEnable = 1;
}

function ont2onr(resourcename)
{
    var index = 0;
    var len = onr.length;

    if (0 == ont2onrEnable)
    {
        return resourcename;
    }

    for (index = 0; index < len; index++)
    {
        if (resourcename == onr[index])
        {
            return resourcename+'_onr';
        }
    }

    return resourcename;
}

function stCATVConfiguration(domain,Enable,RFOutputAdjustment)
{
    this.domain = domain;
    this.Enable = Enable;
    this.RFOutputAdjustment = RFOutputAdjustment;
}
var CATVConfiguration = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_CATVConfiguration, Enable|RFOutputAdjustment, stCATVConfiguration);%>;
var CATVConfigurationObj = CATVConfiguration[0];

if (ProductType == '2' && ontPonMode != 'gpon')
{
    if ((('TELMEX' == CfgMode.toUpperCase()) || ('TELMEX5G' == CfgMode.toUpperCase())) && 'SPANISH' == curLanguage.toUpperCase())
    {
        telmexSpan = true;
    }
}


if ('1' == TelMexFlag && 'SPANISH' == curLanguage.toUpperCase())
{
    telmexSpan = true;
}

if ((1 == '<%HW_WEB_GetFeatureSupport(AMP_FT_RF_ADJUST);%>') && ontPonRFNum != '0' && curUserType == '0')
{
    RFAdjustFlag = true;
}

function IsSonetSptUser()
{
    if(('<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>' == 1) && curUserType != '0')
    {
        return true;
    }
    else
    {
        return false;
    }
}
function GetLinkState()
{
    var State = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;

    if (State == 1 || State == "1")
    {
        return "已连接";
    }
    else
    {
        return "未连接";
    }
}

function GetLinkTime()
{
    var LinkTime = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.EPONLinkInfo.PONLinkTime);%>';
    var LinkDesc;

    LinkDesc = parseInt(LinkTime/3600) + "小时" + parseInt((LinkTime%3600)/60) + "分钟" + parseInt(((LinkTime%3600)%60)) + "秒";
    if (GetLinkState() == "未连接")
    {
        LinkDesc = "--";
    }

    return LinkDesc;
}

function GetPONTxPackets()
{
    var PONTxPackets = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.X_HW_PonInterface.Stats.PacketsSent);%>';
    var PONTxPacketsString = parseInt(PONTxPackets);
    return PONTxPacketsString;
}

function GetPONRxPackets()
{
    var PONTxPackets = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.X_HW_PonInterface.Stats.PacketsReceived);%>';
    var PONTxPacketsString = parseInt(PONTxPackets);
    return PONTxPacketsString;
}

function LoadOpticRef()
{
    if (!IsSonetSptUser())
    {

        if (ProductType != '2' || ontPonMode == 'gpon')
        {
            getElById("ref_head").style.display = "";
            getElById("ref_status").style.display = "";
            getElById("ref_rx").style.display = "";
            getElById("ref_tx").style.display = "";
            getElById("ref_vol").style.display = "";
            getElById("ref_cur").style.display = "";
            getElById("ref_temp").style.display = "";
            if ((ontPonMode == 'gpon' || ontPonMode == 'GPON' || ontPonMode == 'GE' || ontPonMode == 'ge') && (ontPonRFNum != '0') && (IPOnlyFlag != '1'))
            {
                getElById("ref_catvrx").style.display = "";
                getElById("ref_catvtx").style.display = "";
            }
        }
        else
        {
            if ((ontPonMode == 'gpon' || ontPonMode == 'GPON' || ontPonMode == 'GE' || ontPonMode == 'ge') && (ontPonRFNum != '0'))
            {
                getElById("ref_catvrx").style.display = "";
                getElById("ref_catvtx").style.display = "";
            }
        }

        if ('1' == IPOnlyFlag)
        {
            getElById("ref_txwavelen").style.display = "";
            getElById("ref_rxwavelen").style.display = "";
            getElById("ref_maxtxdis").style.display = "";
            getElById("ref_losstaus").style.display = "";
            getElById("ref_vendername").style.display = "";
            getElById("ref_vendersn").style.display = "";
            getElById("ref_datecode").style.display = "";
        }
        if ( !( ('1' == TelMexFlag) || ('GPON' != ontPonMode.toUpperCase()) ) )
        {
            getElById("ref_olt_head").style.display = "";
            getElById("ref_olt_optic_type").style.display = "";
            getElById("ref_olt_txpower").style.display = "";
            getElById("ref_olt_portid").style.display = "";
        }
        if (ProductType == '2' && ontPonMode != 'gpon')
        {
            if ( !((('TELMEX' == CfgMode.toUpperCase()) || ('TELMEX5G' == CfgMode.toUpperCase())) || ('GPON' != ontPonMode.toUpperCase())) )
            {
                getElById("ref_olt_head").style.display = "";
                getElById("ref_olt_optic_type").style.display = "";
                getElById("ref_olt_txpower").style.display = "";
                getElById("ref_olt_portid").style.display = "";
            }
        }

    }
}

function stSFPEnble(domain,Enable)
{
    this.domain = domain;
    this.Enable = Enable;
}
var Sfps = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.4.WANSFPInterfaceConfig,Enable,stSFPEnble);%>;

var SfpEnble = Sfps[0];
function displayFltsecLevel()
{
    document.getElementById("DefaultSFP1").style.display="none";
    setDisplay("DefaultSFP",0);
    setDisplay("OperatorPanel",0);    

    if (null == SfpEnble)
    {
        return;
    }
    if (typeof(SfpEnble) == 'undefined')
    {
        setCheck('dftIfStr',0);
    }
    else if (SfpEnble.Enable == '0')
    {
        setCheck('dftIfStr',0);
        
    }
    else
    {
        setCheck('dftIfStr',1);
    }
}

function ResetDMBoard()
{
    console.log("disableDSL......");    
    
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "resetBoard.cgi?&RequestFile=html/amp/opticinfo/opticinfo.asp",
        data :'&x.X_HW_Token=' + getValue('onttoken1'),
        success : function(data) {
            CheckResult=data;
        }
    });

}


function SubmitForm()
{
    if (ConfirmEx('Are you sure you want to change the configuration?')) 
    {
         var Form = new webSubmitForm();
         Form.addParameter('x.Enable',getCheckVal('dftIfStr'));
         Form.addParameter('x.X_HW_Token', getValue('onttoken1'));
         Form.setAction('set.cgi?x=InternetGatewayDevice.WANDevice.4.WANSFPInterfaceConfig' + '&RequestFile=html/amp/opticinfo/opticinfo.asp');
         Form.submit();
    }
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
        if (true == telmexSpan)
        {
        if (b.getAttribute("BindText") == 'amp_optinfo_title')
        {
           b.innerHTML = status_optinfo_language['amp_optinfo_title_telmex'];
           continue;
        }
        if (b.getAttribute("BindText") == 'amp_optic_voltage')
        {
           b.innerHTML = status_optinfo_language['amp_optic_voltage_telmex'];
           continue;
        }
        if (b.getAttribute("BindText") == 'amp_optic_temp')
        {
           b.innerHTML = status_optinfo_language['amp_optic_temp_telmex'];
           continue;
        }
        if (b.getAttribute("BindText") == 'amp_optic_status')
        {
           b.innerHTML = status_optinfo_language['amp_optic_status_telmex'];
           continue;
        }
       }
        b.innerHTML = status_optinfo_language[b.getAttribute("BindText")];
    }
	
	if('OI2' == CfgMode.toUpperCase())
	{
		setDisplay("DivPonInfo",1);
	}
	else
    {
        setDisplay("DivPonInfo",0);
    }
	
    if (SfpExInfoFlag == '1' && ontPonMode != 'gpon')
    {
        $("#TROpticLinkStaus").css("display","");
        $("#TROpticVendorSN").css("display","");
        $("#TROpticVendorName").css("display","");
    }
    else
    {
        $("#TROpticLinkStaus").css("display","none");
        $("#TROpticVendorSN").css("display","none");
        $("#TROpticVendorName").css("display","none");    
    }

    if ( ('1' == TelMexFlag) || ('GPON' != ontPonMode.toUpperCase()) )
    {
        setDisplay("DivOltInfo",0);
        setDisplay("ont_info_head",0);
    }
    else
    {
        setDisplay("DivOltInfo",1);
        setDisplay("ont_info_head",1);
    }

    if (curWebFrame != 'frame_UNICOM')
    {
        setDisplay("table_ani_linkup_time_info", 0);
        setDisplay("table_ani_linkup_time_content", 0);
    }
    if (curWebFrame == 'frame_UNICOM')
    {
        setDisplay("DivOltInfo", 0);
    }

    if (IsSonetSptUser())
    {
        setDisplay("DivOltInfo", 0);
    }

    if (ontPonMode == 'ge' || ontPonMode == 'GE')
    {
        setDisplay("optic_status_tr", 0);
        setDisplay("DivOltInfo", 0);
        setDisplay("table_ani_linkup_time_info", 0);
        setDisplay("table_ani_linkup_time_content", 0);
    }

    if ('1' == IPOnlyFlag)
    {
        setDisplay("optic_status_tr", 1);
    }

    LoadOpticRef();

    if (true == RFAdjustFlag && ontPonRFNum != '0')
    {
        $("#ref_catvtx").html("≥60 dBuV");
        if (opticInfo.rfOutputPower == "--")
        {
            $("#tr2_2").html(opticInfo.rfOutputPower + " dBuV(dBuV=dBmV+60)");
        }
        else
        {
      var rfOutputPower = parseInt(opticInfo.rfOutputPower) + 60;
            $("#tr2_2").html(rfOutputPower + " dBuV(dBuV=dBmV+60)");
        }
    }

    if (('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase()) && ontPonRFNum != '0')
    {
        $("#ref_catvtx").html("≥60 dBuV");
        if (opticInfo.rfOutputPower == "--")
        {
            $("#tr2_2").html(opticInfo.rfOutputPower + " dBuV(dBuV=dBmV+60)");
        }
        else
        {
     var rfOutputPower = parseInt(opticInfo.rfOutputPower) + 60;
            $("#tr2_2").html(rfOutputPower + " dBuV(dBuV=dBmV+60)");
        }
    }

    if (ProductType != '2')
    {
        if (RFAdjustFlag)
        {
            setDisplay("drag_bar", 1);
            LoadRFAdjust();
        }else
        {
            setDisplay("drag_bar", 0);
        }
    }

    displayFltsecLevel();

}

function CheckForm(type)
{
    with (getElement ("ConfigForm"))
    {

    }
    return true;
}


function DeleteAllZero(hexpasswd)
{
    var str;
    var len = hexpasswd.length ;
    var i = len/2;

    for (  i ; i >= 0 ; i-- )
    {
        if((hexpasswd.substring(i*2 - 1, i*2 ) != '0')||(hexpasswd.substring(i*2 - 2, i*2 - 1) != '0'))
        {
            str = hexpasswd.substring(0, i*2);
            break;
        }
    }

    return str;

}
function ChangeHextoAscii(hexpasswd)
{
    var str;
    var str2;
    var len = 0;

    len = hexpasswd.length;

    if (0 != len%2)
    {
        hexpasswd += "0";
    }

    str2 = DeleteAllZero(hexpasswd);

    str = str2.replace(/[a-f\d]{2}/ig, function(m){
    return String.fromCharCode(parseInt(m, 16));});

    return str;
}

function isValidAscii(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch < ' ' || ch > '~' )
        {
            return false;
        }
    }
    return true;
}

function conversionblankAscii(val)
{
    var str='';
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch == ' ')
        {
            str+="&nbsp;";
        }
        else
        {
            str+= ch;
        }
    }

    return str;
}

var g_rfAdjust = 0;
var g_prev_RFadjust = 0xff;
var RFAdjustActionTimer = null;
var RFAdjustActionTimer1 = null;

function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window) {
        return true;
    } else {
        return false;
    }
}

function rfAdjust2Left(rfAdjust_)
{
    var dragbar = $(".dragbar");
    var left_ = dragbar.offset().left + (rfAdjust_ + 127) * 2;
    if (isIE()) {
        return left_;
    } else {
        return left_ - 8;
    }
}


function Left2rfAdjust(left_)
{
    var dragbar = $(".dragbar");
    var rfadjust_ = (left_ - dragbar.offset().left) / 2 - 127;

    return parseInt(rfadjust_);
}

function throttle_RFAdjustAction()
{
    if(RFAdjustActionTimer)
    {
        clearTimeout(RFAdjustActionTimer)
    }

    RFAdjustActionTimer = setTimeout(RFAdjustAction, 1000);
}

function RFAdjustActiondisplay()
{
    $.ajax({
                type : "POST",
                async : true,
                cache : false,
                url : "../opticinfo/getOpticInfo.asp",
                success : function(data) {
                    var opticInfos1 = dealDataWithFun(data);
                    var OltOptic1 = opticInfos1[0];
                    if (OltOptic1.rfOutputPower == "--")
                    {
                        $("#tr2_2").html(OltOptic1.rfOutputPower + " dBuV(dBuV=dBmV+60)");
                    }
                    else
                    {
                        var rfOutputPower = parseInt(OltOptic1.rfOutputPower) + 60;
                        $("#tr2_2").html(rfOutputPower + " dBuV(dBuV=dBmV+60)");
                    }
                }
            });
}

function RFAdjustAction()
{
    // 防止重复设置
    if (parseInt(g_prev_RFadjust) == parseInt(g_rfAdjust))
    {
        return false;
    }
    g_prev_RFadjust = parseInt(g_rfAdjust);

    $.ajax({
        type : "POST",
        async : true,
        cache : false,
        url : "set.cgi?x=InternetGatewayDevice.X_CATVConfiguration&RequestFile=html/amp/opticinfo/getOpticInfo.asp",
        data :"x.RFOutputAdjustment=" + g_rfAdjust + "&x.X_HW_Token=" + getValue('onttoken'),
        success : function(data) {
                if(RFAdjustActionTimer1)
                {
                    clearTimeout(RFAdjustActionTimer1)
                }

                RFAdjustActionTimer1 = setTimeout(RFAdjustActiondisplay, 500);
        }
    });
}


function LoadRFAdjust()
{
    var handle = $(".draghandle");
    var dragbar = $(".dragbar");
    var rfAdjust = parseInt(CATVConfigurationObj.RFOutputAdjustment);
    $("#drag_bar_value").html(" " + rfAdjust/10 + " dB");

    var leftInit = rfAdjust2Left(rfAdjust);
    dragbar.css(
        "width","305px"
    );
    handle.css({
        "width" : "8px",
        "top" : dragbar.offset().top,
        "left" : leftInit
    });

    var maxlen = parseInt(dragbar.width()) - parseInt(handle.outerWidth());

    handle.bind("mousedown", function(e)
    {
        var x = e.pageX;
        var hx = parseInt(handle.offset().left) - dragbar.offset().left;


        $(document).bind("mousemove", function(e)
        {
            var bar_left = e.pageX - x + hx < 0 ? 0 : (e.pageX - x + hx >= maxlen ? maxlen : e.pageX - x + hx);
                bar_left = parseInt(bar_left + dragbar.offset().left);
            var rfAdjust = Left2rfAdjust(bar_left);
                g_rfAdjust = parseInt(rfAdjust);

            handle.css({
                left : bar_left,
                top : dragbar.offset().top
            });

            $("#drag_bar_value").html(" " + g_rfAdjust/10 + " dB");

            throttle_RFAdjustAction();

            return false;
        });


        $(document).bind("mouseup", function()
        {
            $(this).unbind("mousemove");

            throttle_RFAdjustAction();
        });
    });
}


function RFAdjust(op)
{
    var handle   = $(".draghandle");
    var dragbar  = $(".dragbar");
    var bar_left = parseInt(handle.offset().left);
    var maxlen   = parseInt(dragbar.width()) - parseInt(handle.outerWidth());

    if (op == 1)
    {
        bar_left = bar_left - 10 ;
        if (bar_left < dragbar.offset().left)
        {
            bar_left = dragbar.offset().left;
        }
    }
    else
    {
        bar_left = bar_left + 10 ;
        if (bar_left > parseInt(maxlen + dragbar.offset().left))
        {
           bar_left = parseInt(maxlen + dragbar.offset().left);
        }
    }

    g_rfAdjust = Left2rfAdjust(bar_left);

    handle.css({
        left : bar_left,
        top : dragbar.offset().top
    });

    $("#drag_bar_value").html(" " + g_rfAdjust/10 + " dB");

    throttle_RFAdjustAction();
}

function leftCountWithStyle(count)
{
    if (rosunionGame == "1") {
        return ' style="padding: 3px 0px;text-align: center;border-bottom: 1px solid #6d6060;position: relative;left: -' + count + 'px;"';
    } else {
        return '';
    }
}

function leftCountAdjust(count)
{
    if (rosunionGame == "1") {
        return ' style="padding: 3px 0px;text-align: center;border-bottom: 1px solid #6d6060;position: relative;left: -' + count + 'px;"';
    } else {
        return ' style="display:none"';
    }
}

</script>

</head>
<body class="mainbody" onLoad="LoadFrame();">

<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("amp_optinfo_title",
    GetDescFormArrayById(status_optinfo_language, "amp_optinfo_title_head"),
    GetDescFormArrayById(status_optinfo_language, "amp_optinfo_title"), false);    
</script>

<div class="title_spread"></div>

<div id="ont_info_head" class="func_title" style="display:none"> <script>document.write(status_optinfo_language[ont2onr("amp_optinfo_ontinfo")]);</script></div>

<table id="optic_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed; word-break:break-all">
    <tr>
        <script language="javascript" type="text/javascript">
            if (rosunionGame == "1") {
                var count = 0;
                document.write('<td class="table_title width_per35" ' + leftCountWithStyle(count++) + '>&nbsp;</td>');
                if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                    document.write('<td class="table_right" BindText="amp_optinfo_cur" colspan="2" ' + leftCountWithStyle(count++) + '></td>');
                } else {
                    document.write('<td class="table_right" BindText="amp_optinfo_cur" ' + leftCountWithStyle(count++) + '></td>');
                }
                document.write('<td id="ref_head" class="table_right" BindText="amp_optinfo_ref" ' + leftCountWithStyle(count++) + '></td>');
            } else {
                document.write('<td class="tableTopTitle width_per35">&nbsp;</td>');
                if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                    document.write('<td class="tableTopTitle" BindText="amp_optinfo_cur" colspan="2"></td>');
                } else {
                    document.write('<td class="tableTopTitle" BindText="amp_optinfo_cur"></td>');
                }
                document.write('<td id="ref_head" class="tableTopTitle" BindText="amp_optinfo_ref" style="display:none"></td>');
            }
        </script>
    </tr>
<tr id = "TROpticLinkStaus" style="display:none">
    <td class="width_per35 table_title" BindText='amp_optic_linkStatus'></td>
    <script language="javascript" type="text/javascript">
        if (ProductType == '2' && ontPonMode != 'gpon')
        {
            document.write('<td class="table_right" colspan="2">');
        }
        else
        {
            document.write('<td class="table_right">');
        }

        if(opticInfo == null)
        {
            document.write(status_optinfo_language['amp_optic_unknown']);
        }
        else
        {
            document.write(opticInfo.LinkStatus +'&nbsp;');
        }
    </script> </td>
    <td id="ref_linkstats" class="table_right" BindText='amp_optic_linkStatus' style="display:none"></td>
  </tr>  
<tr  id = "TROpticVendorName" style="display:none">
    <td class="width_per35 table_title" BindText='amp_optic_vnname'></td>
    <script language="javascript" type="text/javascript">
        if (ProductType == '2' && ontPonMode != 'gpon')
        {
            document.write('<td class="table_right" colspan="2">');
        }
        else
        {
            document.write('<td class="table_right">');
        }

        if(opticInfo == null)
        {
            document.write(status_optinfo_language['amp_optic_unknown']);
        }
        else
        {
            document.write(opticInfo.VendorName +'&nbsp;');
        }
    </script> </td>
    <td id="ref_name" class="table_right" BindText='amp_optic_vnname' style="display:none"></td>
  </tr>
<tr  id = "TROpticVendorSN" style="display:none">
    <td class="width_per35 table_title" BindText='amp_optic_vnsn'></td>
    <script language="javascript" type="text/javascript">
        if (ProductType == '2' && ontPonMode != 'gpon')
        {
            document.write('<td class="table_right" colspan="2">');
        }
        else
        {
            document.write('<td class="table_right">');
        }

        if(opticInfo == null)
        {
            document.write(status_optinfo_language['amp_optic_unknown']);
        }
        else
        {
            document.write(opticInfo.VendorSN +'&nbsp;');
        }
    </script> </td>
    <td id="ref_sn" class="table_right" BindText='amp_optic_vnsn' style="display:none"></td>
</tr>    
    <tr id="optic_status_tr">
        <script language="javascript" type="text/javascript">
            var count = 0;
            document.write('<td class="table_title width_per35" BindText="amp_optic_status" ' + leftCountWithStyle(count++) + '></td>');
            document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            if (status == '') {
                document.write(status_optinfo_language['amp_optic_unknown']);
            } else {
                if (opticStatus == 1) {
                    document.write(status_optinfo_language['amp_optic_none']);
                } else {
                    if (opticPower == 'OFF') {
                        document.write(status_optinfo_language['amp_optic_disable']);
                    } else {
                        if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                            if (status == 'enable') {
                                document.write(status_optinfo_language['amp_optic_fault']);
                            } else {
                                document.write(status_optinfo_language['amp_optic_auto']);
                            }
                        } else {
                            if ((status == 'enable') && (IPOnlyFlag != '1')) {
                                document.write(status_optinfo_language['amp_optic_fault']);
                            } else {
                                document.write(status_optinfo_language['amp_optic_auto']);
                            }
                        }
                    }
                }
            }
            document.write('</td>');
            document.write('<td id="ref_status" class="table_right" BindText="amp_optic_ref" ' + leftCountAdjust(count++) + '></td>');
        </script>
    </tr>
    <tr>
        <script language="javascript" type="text/javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_txpower" ' + leftCountWithStyle(count++) + '></td>');
            if ((ProductType =='2') && (ontPonMode != 'gpon')) {
                document.write('<td class="table_right" colspan="2" ' + leftCountWithStyle(count++) + '>');
            } else {
                document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            }
            if (opticInfo == null) {
                document.write(status_optinfo_language['amp_optic_unknown']);
            } else {
                if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                    document.write(opticInfo.transOpticPower+' dBm');
                } else {
                    document.write(opticInfo.transOpticPower+' '+status_optinfo_language['amp_optic_dBm']);
                }
            }
            document.write('</td>');
            document.write('<td id="ref_tx" class="table_right" ' + leftCountAdjust(count++) + '>');
            if (ontXGMode == '10g-gpon') {
                document.write(status_optinfo_language['amp_optic_txref_10g']);
            } else if (ontXGMode == 'Asymmetric 10g-epon') {
                document.write(status_optinfo_language['amp_optic_txref_10eas']);
            } else if (ontXGMode == 'Symmetric 10g-epon') {
                document.write(status_optinfo_language['amp_optic_txref_10es']);
            } else if (ontXGMode == 'ge') {
                document.write(status_optinfo_language['amp_optic_txref_ge']);
            } else if (ontXGMode == 'Symmetric 10g-gpon') {
                document.write(status_optinfo_language['amp_optic_txref_10es']);
            } else {
                if (((ontPonMode == 'gpon') || (ontPonMode == 'GPON')) && (opticType == 6)) {
                    document.write(status_optinfo_language['amp_optic_txref_classc_plus_plus']);
                } else {
                    document.write(status_optinfo_language['amp_optic_txref']);
                }
            }
            document.write('</td>');
        </script>
    </tr>
    <tr >
        <script language="javascript" type="text/javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_rxpower" ' + leftCountWithStyle(count++) + '></td>');
            if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                document.write('<td class="table_right" colspan="2" ' + leftCountWithStyle(count++) + '>');
            } else {
                document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            }
            if (opticInfo == null) {
                document.write(status_optinfo_language['amp_optic_unknown']);
            } else {
                document.write(opticInfo.revOpticPower+' '+status_optinfo_language['amp_optic_dBm']);
            }
            document.write('</td>');
            document.write('<td id="ref_rx" class="table_right" ' + leftCountAdjust(count++) + '>');
            if ((ontPonMode == 'gpon') || (ontPonMode == 'GPON')) {
                if (ontXGMode == 'gpon') {
                    if (opticType == 2) {
                        document.write(status_optinfo_language['amp_optic_classc_plus_rxrefg']);
                    } else if (opticType == 6) {
                        document.write(status_optinfo_language['amp_optic_classc_plus_plus_rxrefg']);
                    } else {
                        document.write(status_optinfo_language['amp_optic_rxrefg']);
                    }
                } else if (ontXGMode == 'Symmetric 10g-gpon') {
                    document.write(status_optinfo_language['amp_optic_rxref_10gs']);
                } else {
                    document.write(status_optinfo_language['amp_optic_rxref_10g']);
                }
            } else if ((ontPonMode == 'epon') || (ontPonMode == 'EPON')) {
                if (ontXGMode == 'epon') {
                    document.write(status_optinfo_language['amp_optic_rxrefe']);
                } else {
                    document.write(status_optinfo_language['amp_optic_rxref_10e']);
                }
            } else {
                document.write(status_optinfo_language['amp_optic_rxref_ge']);
            }
            document.write('</td>');
        </script>
    </tr>
    <tr >
        <script language="javascript" type="text/javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_voltage" ' + leftCountWithStyle(count++) + '></td>');
            if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                document.write('<td class="table_right" colspan="2" ' + leftCountWithStyle(count++) + '>');
            } else {
                document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            }
            if (opticInfo == null) {
                document.write(status_optinfo_language['amp_optic_unknown']);
            } else {
                if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                    document.write(opticInfo.voltage+' mV');
                } else {
                    document.write(opticInfo.voltage+' '+status_optinfo_language['amp_optic_mV']);
                }
            }
            document.write('</td>');
            document.write('<td id="ref_vol" class="table_right" BindText="amp_optic_volref" ' + leftCountAdjust(count++) + '></td>');
        </script>
    </tr>
    <tr >
        <script language="javascript" type="text/javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_current" ' + leftCountWithStyle(count++) + '></td>');
            if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                document.write('<td class="table_right" colspan="2" ' + leftCountWithStyle(count++) + '>');
            } else {
                document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            }
            if (opticInfo == null) {
                document.write(status_optinfo_language['amp_optic_unknown']);
            } else {
                if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                    document.write(opticInfo.bias +' mA');
                } else {
                    document.write(opticInfo.bias +' '+status_optinfo_language['amp_optic_mA']);
                }
            }
            document.write('</td>');
            document.write('<td id="ref_cur" class="table_right" BindText="amp_optic_curref" ' + leftCountAdjust(count++) + '></td>');
        </script>
    </tr>
    <tr >
        <script language="javascript" type="text/javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_temp" ' + leftCountWithStyle(count++) + '></td>');
            if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                document.write('<td class="table_right" colspan="2" ' + leftCountWithStyle(count++) + '>');
            } else {
                document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            }
            if (opticInfo == null) {
                document.write(status_optinfo_language['amp_optic_unknown']);
            } else {
                document.write(opticInfo.temperature+'&nbsp;'+'℃');
            }
            document.write('</td>');
            document.write('<td id="ref_temp" class="table_right" BindText="amp_optic_tempref" ' + leftCountAdjust(count++) + '></td>');
        </script>
    </tr>
    <script type="text/javascript" language="javascript">
        if ((ontPonMode == 'gpon' || ontPonMode == 'GPON' || ontPonMode == 'GE' || ontPonMode == 'ge') && (ontPonRFNum != '0') && (IPOnlyFlag != '1')) {
            var count = 0;
            document.write('<tr id="tr1" name="tr1">');
            document.write('<td  class="width_per35 table_title" id="tr1_1" name="tr1_1" ' + leftCountWithStyle(count++) + '>' + status_optinfo_language['amp_optic_catvrx'] + '</td>');

            if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                document.write('<td  class="table_right" id="tr1_2" name="tr1_2" ' + leftCountWithStyle(count++) + '>' + opticInfo.rfRxPower+' dBm' + '</td>');
            } else {
                document.write('<td  class="table_right" id="tr1_2" name="tr1_2" ' + leftCountWithStyle(count++) + '>' + opticInfo.rfRxPower+' '+status_optinfo_language['amp_optic_dBm'] + '</td>');
            }

            if (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_2F3W);%>') {
                document.write('<td  id="ref_catvrx" class="table_right" id="tr1_3" name="tr1_3" ' + leftCountAdjust(count++) + '>' + status_optinfo_language['amp_optic_catvrxref_2F3W'] + '</td>');
            } else {
                document.write('<td  id="ref_catvrx" class="table_right" id="tr1_3" name="tr1_3" ' + leftCountAdjust(count++) + '>' + status_optinfo_language['amp_optic_catvrxref'] + '</td>');
            }
            document.write('</tr>');

            document.write('<tr id="tr2" name="tr2">');
            count = 0;
            document.write('<td  class="width_per35 table_title" id="tr2_1" name="tr2_1" ' + leftCountWithStyle(count++) + '>' + status_optinfo_language['amp_optic_catvtx'] + '</td>');
            if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                document.write('<td  class="table_right" id="tr2_2" name="tr2_2" ' + leftCountWithStyle(count++) + '>' + opticInfo.rfOutputPower+' dBmV' + '</td>');
            } else {
                document.write('<td  class="table_right" id="tr2_2" name="tr2_2" ' + leftCountWithStyle(count++) + '>' + opticInfo.rfOutputPower+' '+status_optinfo_language['amp_optic_dBmV'] + '</td>');
            }

            if (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_2F3W);%>') {
                document.write('<td  id="ref_catvtx" class="table_right" id="tr2_3" name="tr2_3" ' + leftCountAdjust(count++) + '>' + status_optinfo_language['amp_optic_catvtxref_2F3W'] + '</td>');
            } else {
                if ('TURKSATEBG3' == CfgMode.toUpperCase()) {
                    document.write('<td  id="ref_catvtx" class="table_right" id="tr2_3" name="tr2_3" ' + leftCountAdjust(count++) + '>' + status_optinfo_language['amp_optic_catvtxrefturkey'] + '</td>');
                } else {
                    document.write('<td  id="ref_catvtx" class="table_right" id="tr2_3" name="tr2_3" ' + leftCountAdjust(count++) + '>' + status_optinfo_language['amp_optic_catvtxref'] + '</td>');
                }
            }
            document.write('</tr>');
        }

    if ('1' == IPOnlyFlag)
    {
        document.write('<tr id="tr3" name="tr3">');
        document.write('<td  class="width_per35 table_title" id="tr3_1" name="tr3_1">' + status_optinfo_language['amp_optic_txwavelen'] + '</td>');
        document.write('<td  class="table_right" id="tr3_2" name="tr3_2">' + opticInfo.TxWaveLength+' nm' + '</td>');
        document.write('<td  id="ref_txwavelen" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_txwavelenrf'] + '</td>');
        document.write('</tr>');

        document.write('<tr id="tr4" name="tr4">');
        document.write('<td  class="width_per35 table_title" id="tr4_1" name="tr4_1">' + status_optinfo_language['amp_optic_rxwavelen'] + '</td>');
        document.write('<td  class="table_right" id="tr4_2" name="tr4_2">' + opticInfo.RxWaveLength+' nm' + '</td>');
        document.write('<td  id="ref_rxwavelen" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_rxwavelenrf'] + '</td>');
        document.write('</tr>');

        document.write('<tr id="tr5" name="tr5">');
        document.write('<td  class="width_per35 table_title" id="tr5_1" name="tr5_1">' + status_optinfo_language['amp_optic_maxtxdis'] + '</td>');
        document.write('<td  class="table_right" id="tr5_2" name="tr5_2">' + opticInfo.MaxTxDistance+' km' + '</td>');
        document.write('<td  id="ref_maxtxdis" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_maxtxdisrf'] + '</td>');
        document.write('</tr>');

        document.write('<tr id="tr6" name="tr6">');
        document.write('<td  class="width_per35 table_title" id="tr6_1" name="tr6_1">' + status_optinfo_language['amp_optic_losstaus'] + '</td>');
        var losstatus_c = opticInfo.LosStatus == '1' ? 'Los On' : 'Los Off';
        document.write('<td  class="table_right" id="tr6_2" name="tr6_2">' + losstatus_c + '</td>');
        document.write('<td  id="ref_losstaus" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_losstausrf'] + '</td>');
        document.write('</tr>');

        document.write('<tr id="tr7" name="tr7">');
        document.write('<td  class="width_per35 table_title" id="tr4_1" name="tr4_1">' + status_optinfo_language['amp_optic_vendername'] + '</td>');
        document.write('<td  class="table_right" id="tr7_2" name="tr7_2">' + opticInfo.VendorName + '</td>');
        document.write('<td  id="ref_vendername" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_vendernamerf'] + '</td>');
        document.write('</tr>');

        document.write('<tr id="tr8" name="tr8">');
        document.write('<td  class="width_per35 table_title" id="tr8_1" name="tr8_1">' + status_optinfo_language['amp_optic_vendersn'] + '</td>');
        document.write('<td  class="table_right" id="tr8_2" name="tr8_2">' + opticInfo.VendorSN + '</td>');
        document.write('<td  id="ref_vendersn" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_vendersnrf'] + '</td>');
        document.write('</tr>');

        document.write('<tr id="tr9" name="tr9">');
        document.write('<td  class="width_per35 table_title" id="tr9_1" name="tr9_1">' + status_optinfo_language['amp_optic_datecode'] + '</td>');

        document.write('<td  class="table_right" id="tr9_2" name="tr9_2">' + opticInfo.DateCode + '</td>');
        document.write('<td  id="ref_datecode" class="table_right" style="display:none">' + status_optinfo_language['amp_optic_datecoderf'] + '</td>');
        document.write('</tr>');
    }
  </script>
</table>

<div id= "drag_bar" style="display:none">
<fieldset>
<table>
<tr>
    <td width = "268" >
    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    <label id = "drag_bar_label" style="font-size:14px;" >RF output amplitude adjust :</label>
    <label id='drag_bar_value' style="font-size:14px;" ></label>
    </td>

    <td width = "20" >
    <button id = "btnRFAdjustMinus" onclick = RFAdjust(1)  type="submit" > - </button>
    </td>

    <td>
    <div class="dragbar" >
        <div class="draghandle"> </div>
    </div>
    </td>

    <td width = "20" >
    <button id = "btnRFAdjustAdd" onclick = RFAdjust(0) type="submit" > + </button>
    </td>
</tr>
</table>

</fieldset>
</div>

<div class="func_spread"></div>

<div id="DivOltInfo">

<div class="func_title"><SCRIPT>document.write(status_optinfo_language["amp_optinfo_oltinfo"]);</SCRIPT></div>

<table id="olt_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed; word-break:break-all">
    <tr>
        <script type="text/javascript" language="javascript">
            if (rosunionGame == "1") {
                var count = 0;
                document.write('<td class="table_title width_per35" ' + leftCountWithStyle(count++) + '>&nbsp;</td>');
                document.write('<td class="table_right" BindText="amp_optinfo_cur" ' + leftCountWithStyle(count++) + '></td>');
                document.write('<td id="ref_olt_head" class="table_right" BindText="amp_optinfo_ref" ' + leftCountWithStyle(count++) + '></td>');
            } else {
                document.write('<td class="tableTopTitle width_per35">&nbsp;</td>');
                document.write('<td class="tableTopTitle" BindText="amp_optinfo_cur"></td>');
                document.write('<td id="ref_olt_head" class="tableTopTitle" BindText="amp_optinfo_ref" style="display:none"></td>');
            }
        </script>
    </tr>
    <tr>
        <script type="text/javascript" language="javascript">
            var count = 0;
            document.write('<td class="table_title width_per35" BindText="amp_optic_oltpower" ' + leftCountWithStyle(count++) + '></td>');
            document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>' + OltOptic.BudgetClass + '</td>');
            document.write('<td id="ref_olt_optic_type" class="table_right" ' + leftCountAdjust(count++) + '>--</td>');
        </script>
    </tr>
    <tr>
        <script type="text/javascript" language="javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_olttxpower" ' + leftCountWithStyle(count++) + '></td>');
            document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>' + OltOptic.TxPower+' '+status_optinfo_language['amp_optic_dBm'] + '</td>');
            document.write('<td id="ref_olt_txpower" class="table_right" ' + leftCountAdjust(count++) + '>');

            if ((opticInfo != null) && (opticInfo.revOpticPower == '--')) {
                document.write('--');
            } else if (OltOptic.BudgetClass.toUpperCase() == 'CLASS A') {
                document.write(status_optinfo_language['amp_optic_oltclass_a']);
            } else if (OltOptic.BudgetClass.toUpperCase() == 'CLASS B') {
                document.write(status_optinfo_language['amp_optic_oltclass_b']);
            } else if (OltOptic.BudgetClass.toUpperCase() == 'CLASS C') {
                document.write(status_optinfo_language['amp_optic_oltclass_c']);
            } else if (OltOptic.BudgetClass.toUpperCase() == 'CLASS B+') {
                document.write(status_optinfo_language['amp_optic_oltclass_bj']);
            } else if (OltOptic.BudgetClass.toUpperCase() == 'CLASS C+') {
                document.write(status_optinfo_language['amp_optic_oltclass_cj']);
            } else if (OltOptic.BudgetClass == 'N1') {
                document.write(status_optinfo_language['amp_optic_xgpon']);
            } else if (OltOptic.BudgetClass == 'N2a') {
                document.write(status_optinfo_language['amp_optic_xgpon']);
            } else if (OltOptic.BudgetClass == 'N2b') {
                document.write(status_optinfo_language['amp_optic_xgpon']);
            } else if (OltOptic.BudgetClass == 'E1') {
                document.write(status_optinfo_language['amp_optic_xgpon']);
            } else if (OltOptic.BudgetClass == 'E2a') {
                document.write(status_optinfo_language['amp_optic_xgpon']);
            } else if (OltOptic.BudgetClass == 'E2b') {
                document.write(status_optinfo_language['amp_optic_xgpon']);
            } else {
                document.write('--');
            }
            document.write('</td>');
        </script>
    </tr>
    <tr id="TrPasswordPon">
        <script type="text/javascript" language="javascript">
            var count = 0;
            document.write('<td class="width_per35 table_title" BindText="amp_optic_oltponid" ' + leftCountWithStyle(count++) + '></td>');
            document.write('<td class="table_right" ' + leftCountWithStyle(count++) + '>');
            if (OltOptic.PONIdentifier =='') {
                document.write('--');
            } else {
                if (isValidAscii(ChangeHextoAscii(OltOptic.PONIdentifier)) == true) {
                    document.write(conversionblankAscii(ChangeHextoAscii(OltOptic.PONIdentifier))+"&nbsp;"+'('+'0x'+OltOptic.PONIdentifier+')');
                } else {
                    document.write('('+'0x'+OltOptic.PONIdentifier+')');
                }
            }
            document.write('</td>');
            document.write('<td id="ref_olt_portid" class="table_right" ' + leftCountAdjust(count++) + '>--</td>');
        </script>
    </tr>
</table>

<div class="func_spread"></div>

</div>
<div id="DivPonInfo" style="display:none">

<div class="func_title"><SCRIPT>document.write(status_optinfo_language["amp_optinfo_statistics_oltinfo"]);</SCRIPT></div>

<table id="olt_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed; word-break:break-all">
  <tr >
    <td class="tableTopTitle width_per35">&nbsp;</td>
    <td class="tableTopTitle" BindText='amp_optinfo_bytes'></td>
    <td class="tableTopTitle" BindText='amp_optinfo_packets'></td>
	<td class="tableTopTitle" BindText='amp_optinfo_error'></td>
    <td class="tableTopTitle" BindText='amp_optinfo_discarded'></td>
  </tr >
  <tr >
    <td class="table_title width_per35" BindText='amp_optinfo_TX'></td>
    <td class="table_right"> <script language="javascript" type="text/javascript">
    document.write(Stat.BytesSent);
         </script> </td>
	 <td class="table_right"> <script language="javascript" type="text/javascript">
    document.write(Stat.PacketsSent);
         </script> </td>
    <td class="table_right"> <script language="javascript" type="text/javascript">
    document.write(Stat.ErrorsSent);
         </script> </td>
	 <td class="table_right"> <script language="javascript" type="text/javascript">
    document.write('0');
         </script> </td>
  </tr >
    <tr>
    <td class="width_per35 table_title" BindText='amp_optinfo_RX'></td>
    <td class="table_right"> <script language="javascript" type="text/javascript">

         document.write(Stat.BytesReceived);

    </script> </td>
	 <td class="table_right"> <script language="javascript" type="text/javascript">

         document.write(Stat.PacketsReceived);

    </script> </td>
	<td class="table_right"> <script language="javascript" type="text/javascript">

        document.write(Stat.ErrorsReceived);

    </script> </td>
   <td class="table_right"> <script language="javascript" type="text/javascript">

        document.write(Stat.DiscardPacketsReceived);

    </script> </td>
</table>

<div class="func_spread"></div>

</div>

<table id="table_ani_linkup_time_info">
    <tr>
        <td class="tabal_head" colspan="11" BindText='amp_optic_ANIinfo'></td>
    </tr>
</table>
<table id="table_ani_linkup_time_content" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed; word-break:break-all">
    <tr>
        <td class="table_title width_per35" BindText='amp_optic_ponlinktime'></td>
        <td class="table_right"><script type="text/javascript" language="javascript">document.write(GetLinkTime());</script></td>
      </tr>
    <tr>
        <td class="width_per35 table_title" BindText='amp_optic_ponTXpackets'></td>
        <td class="table_right"> <script language="javascript" type="text/javascript">document.write(GetPONTxPackets());</script></td>
    </tr>
    <tr>
        <td class="width_per35 table_title" BindText='amp_optic_ponRXpackets'></td>
        <td class="table_right"> <script language="javascript" type="text/javascript">document.write(GetPONRxPackets());</script></td>
    </tr>
</table>

<div class="title_spread"></div>
<div id="DefaultSFP1" class="PageTitle_content"></div>
<form id="DefaultSFP" name="DefaultSFP">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
    <li id="dftIfStr" RealType="CheckBox" DescRef="amp_optic_enable" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty" InitValue="Empty"/>    
    </table>
    <script>
        var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
        var DefaultSFPList = new Array();
        DefaultSFPList = HWGetLiIdListByForm("DefaultSFP",null);
        HWParsePageControlByID("DefaultSFP",TableClass,status_optinfo_language,null);
    </script>
</form>

<table id="OperatorPanel" class="table_button" style="width: 100%" cellpadding="0">
<tbody>
<tr>
  <td class="table_submit width_per1"></td>
  <td class="table_submit width_per99">
  <input type="hidden" name="onttoken1" id="onttoken1" value="<%HW_WEB_GetToken();%>">                
  <button name="btnApply" id="btnApply" type="button" onclick="SubmitForm();" class="ApplyButtoncss buttonwidth_150px_300px">
  <script>document.write(status_optinfo_language['amp_optic_apply']);</script>
  </button>
  </td>
</tr>
</tbody>
</table>
</div>
</body>
</html>

