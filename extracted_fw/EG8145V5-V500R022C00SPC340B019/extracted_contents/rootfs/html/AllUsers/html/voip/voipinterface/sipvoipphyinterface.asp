<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipinterface);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>VOIP Interface</title>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<style>
.interfacetextclass{
    width:300px;
    height:50px;
    color:black;
}
.interfacetextrosgameclass{
    width:300px;
    height:50px;
    color:white;
}

.TextBox
{
width:155px;
}

.lineclass
{
width:200px;
}

.wordclass
{
word-wrap:break-all;
word-break: break-all;
}

</style>

<script language="JavaScript" type="text/javascript"> 

var PortNum = '<%HW_WEB_GetPortNum();%>';
var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function stProfile(Domain, X_HW_PortName)
{
    this.Domain = Domain;
    this.X_HW_PortName = X_HW_PortName;
    var temp = Domain.split('.');
    this.key = '.' + temp[5] + '.';
    this.profileid = temp[5];
}

var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},X_HW_PortName,stProfile);%>;

function stLineSip(Domain, URI, AuthUserName)
{
    this.Domain = Domain;
    if (URI != null) {
        this.URI = URI.toString().replace(/&apos;/g,"\'");
    } else {
        this.URI = URI;
    }

    if (AuthUserName != null) {
        this.AuthUserName = AuthUserName.toString().replace(/&apos;/g,"\'");
    } else {
        this.AuthUserName = AuthUserName;
    }

    this.LineIns = parseInt(Domain.split(".")[7]);
}

function stLine(Domain, DirectoryNumber, PhyReferenceList, Status)
{
    this.Domain = Domain;
    if (DirectoryNumber != null) {
        this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'");
    } else {
        this.DirectoryNumber = DirectoryNumber;
    }

    this.Status = Status;
    this.PhyReferenceList = PhyReferenceList;
    this.LineIns = parseInt(Domain.split(".")[7]);
    this.pilot = "";
    for (var i = 0; i < AllLineSip.length - 1; i++) {
        if (this.LineIns == AllLineSip[i].LineIns) {
            var srcNum = "";
            if (AllLineSip[i].URI != "") {
                srcNum = AllLineSip[i].URI;
            } else if (this.DirectoryNumber != "") {
                srcNum = this.DirectoryNumber;
            } else {
                srcNum = AllLineSip[i].AuthUserName;
            }

            var k3 = "";
            if ((srcNum.indexOf(":") >= 0)) {
                var UserId = srcNum.split(':');
                var k1 = UserId[1];
                var k2 = k1.split('@');
                k3 = k2[0];
            } else {
                var UserId = srcNum.split('@');
                k3 = UserId[0];
            }
            this.pilot = k3;
            return;
        }
    }
}

function stAdditionalNumber(Domain, Number)
{
    this.Domain = Domain;
    this.Number = Number;
    this.LineIns = parseInt(Domain.split(".")[7]);
    for (var i = 0; i < AllLine.length - 1; i++) {
        if (this.LineIns == AllLine[i].LineIns) {
            this.status = AllLine[i].Status;
            this.PhyReferenceList = AllLine[i].PhyReferenceList;
            break;
        }
    }
    this.repeat = false;
    for (var i = 0; i < AllLine.length - 1; i++) {
        if (this.Number == AllLine[i].pilot && AllLine[i].Status == "Up") {
            this.repeat = true;
            return;
        }
    }
}

function stOutgoingNumber(Domain, X_HW_OutgoingNumber)
{
    this.Domain = Domain;
    this.X_HW_OutgoingNumber = X_HW_OutgoingNumber;
}

var AllLineSip = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,URI|AuthUserName,stLineSip);%>;
var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|PhyReferenceList|Status,stLine);%>;
var AllMsnNumber = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.X_HW_MSN.{i}, Number,stAdditionalNumber);%>;
var AllOutgoingNumber = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}, X_HW_OutgoingNumber,stOutgoingNumber);%>;

function init()
{
    if (AllProfile[0] == null) {
        return;
    }

    setText('X_HW_OutgoingNumber_1', AllOutgoingNumber[0].X_HW_OutgoingNumber);
    setText('X_HW_OutgoingNumber_2', AllOutgoingNumber[1].X_HW_OutgoingNumber);
}

function LoadFrame()
{
    init();

    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) {
        var b = all[i];
        if(b.getAttribute("BindText") == null) {
            continue;
        }
        b.innerHTML = sipinterface[b.getAttribute("BindText")];
    }
}

function SubmitBasicPara()
{
    var Form = new webSubmitForm();
    var sndOutboundServerPort;
    var OutboundServerPort;
    var ActionURL;
    var FreeLine;
    var strvar = getValue('AuthPassword');
    
    if (AllProfile[0] == null) {
        return false;
    }

    Form.addParameter('d.X_HW_OutgoingNumber', getValue('X_HW_OutgoingNumber_1'));
    Form.addParameter('e.X_HW_OutgoingNumber', getValue('X_HW_OutgoingNumber_2'));
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    ActionURL = 'set.cgi?' + '&d=' + AllOutgoingNumber[0].Domain + '&e=' + AllOutgoingNumber[1].Domain +
                '&RequestFile=html/voip/voipinterface/sipvoipphyinterface.asp';

    Form.setAction(ActionURL);                               
    setDisable('btnApplySipUser',1);
    setDisable('btnApplyVoipUser',1);
    setDisable('cancelValue',1);
    Form.submit();
}

function setControl(index)
{
}

function CancelUserConfig()
{
    LoadFrame();
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipInterface", GetDescFormArrayById(sipinterface, "v03"), GetDescFormArrayById(sipinterface, "v04"), false);
</script>

<div class="title_spread"></div>

<form id="voipbasic">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_phyinterface'></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">

<script>
for (var i = 0; i < PortNum; i++) {
    var potsId = "X_HW_OutgoingNumber_" + (i + 1);
    var descRef = "vspa_outgoingnumber" + (i + 1)
    document.write('<li id="' + potsId +'" RealType="DropDownList" DescRef="'+ descRef + '" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" Elementclass="restrict_dir_ltr"/>');
}

var VoipConfigFormList1 = HWGetLiIdListByForm("voipbasic", null);
HWParsePageControlByID("voipbasic", TableClass, sipinterface, null);
var VoipBasicParaSetArray = new Array();

for (var i = 1; i <= PortNum; ++i) {
    var Option = document.createElement("Option");
    Option.value = "";
    Option.innerText = "";
    Option.text = "select";
    getElById('X_HW_OutgoingNumber_' + i).appendChild(Option);
}

for (var i = 0; i < AllMsnNumber.length; ++i) {
    if (AllMsnNumber[i] == null) {
        break;
    }

    if (AllMsnNumber[i].status != 'Up') {
        continue;
    }

    var number = AllMsnNumber[i].Number;
    for (var j = 1; j <= PortNum; ++j) {
        var Option = document.createElement("Option");
        Option.value = number;
        Option.innerText = number;
        Option.text = number;
        getElById('X_HW_OutgoingNumber_' + j).appendChild(Option);
    }
}

HWSetTableByLiIdList(VoipConfigFormList1, VoipBasicParaSetArray, null);
</script>
</table>
</form>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
<tr >
<td class="table_submit width_per25"></td>
<td class="table_submit"> 
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<input name="btnApplyVoipUser" id="btnApplyVoipUser" type="button" class="ApplyButtoncss buttonwidth_100px" value="Apply" onClick="SubmitBasicPara();"/>
<script type="text/javascript">
document.getElementsByName('btnApplyVoipUser')[0].value = sipinterface['vspa_apply'];    
</script>
<input name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" value="Cancel" onClick="CancelUserConfig();"/>
<script>
document.getElementsByName('cancelValue')[0].value = sipinterface['vspa_cancel'];
</script>

</td>
</tr>
</table>
<br></br>
</body>
</html>
