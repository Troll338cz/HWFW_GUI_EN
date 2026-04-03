<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var upUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';

function loadlanguage()
{
    var all = document.getElementsByTagName("button");
    for (var i = 0; i < all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = portisolate_language[b.getAttribute("BindText")];
    }
}

function stLayer3Enable(domain, lay3enable)
{
    this.domain = domain;
    this.lay3enable = lay3enable;
}

function topoArrayInfo(domain, ethNum, ssidNum)
{
    this.domain = domain;
    this.ethNum = ethNum;
    this.ssidNum = ssidNum;
}

var lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>;
var topoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo, X_HW_EthNum|X_HW_SsidNum, topoArrayInfo);%>;
var topoInfo = topoInfoList[0];

function ethIsolateCfgArray(domain, Isolate)
{
    this.domain = domain;
    this.Isolate = Isolate;
}

var ethIsolateCfg = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.EthIsolateCfg.{i}, Isolate, ethIsolateCfgArray);%>;

function getEthIsolateID(domainName)
{
    var tempDomainArray= domainName.split(".");
    return tempDomainArray[tempDomainArray.length-1];
}

function LoadFrame()
{
    for(var i = 0 ; i < ethIsolateCfg.length - 1 ; i++) {
        var lanInstId = getEthIsolateID(ethIsolateCfg[i].domain);
        setCheck('laninst' + lanInstId, ethIsolateCfg[i].Isolate);
    }

    loadlanguage();
}

function ChangeLanState()
{
    var Form = new webSubmitForm();
    var domain = "";

    for (var i = 1; i <= topoInfo.ethNum; i++) {
        if ((upUserPortID == i) || (lay3Enables[i-1].lay3enable == 1)) {
            continue;
        } else {
            domain +=  '&LAN'+ i + '=InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.EthIsolateCfg.' + i;
            Form.addParameter('LAN' + i + '.Isolate', getCheckVal('laninst' + i));
        }
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    domain = domain.substr(1, domain.length - 1);
    Form.setAction('set.cgi?' + domain + '&RequestFile=html/bbsp/portinfo/portisolate.asp');
    setDisable('btnapply', 1);
    setDisable('btncancel', 1);
    Form.submit();
}

function CancelConfig()
{
    window.location.href = "/html/bbsp/portinfo/portisolate.asp";
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<div id="ethportcfg">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("portisolate", GetDescFormArrayById(portisolate_language, "portisolate_title"), GetDescFormArrayById(portisolate_language, "portisolate_tips"), false);
</script> 
<div class="title_spread"></div>
<table> 
    <form action="" id="ConfigForm">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
            <tr id="portisolation" class='align_left'>
            <script>
            for (var i = 1; i <= topoInfo.ethNum; i++) {
                document.write('<td class=\"LanBg\" id=\"div_lan' + i + '\"><div><input id=\"laninst' + i + '\" type=\"checkbox\" value=\"LAN' + i + '\"><span id=\"lantype' + i + '\"></span></div></td>');
                document.getElementById('lantype' + i).innerHTML = "LAN" + i;
                if ((upUserPortID == i) || (lay3Enables[i-1].lay3enable == 1)) {
                    setDisable("laninst" + i, 1);
                }
            }
            </script>
            </tr>
        </table>
        <table width="100%" border="0"  cellpadding="0" cellspacing="0">
            <tr>
                <td class='title_bright1'>
                    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                    <button id='btnapply' name="btnapply" BindText="portisolate_apply" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="ChangeLanState();"></button>
                    <button id='btncancel' name="btncancel" BindText="portisolate_cancel" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"></button>
                </td>
            </tr>
        </table>
    </form>
</table>
</div>
</body>
</html>
