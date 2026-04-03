<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>DDNS</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<style>
.SelectDdns{
    width: 260px;
}
.SelectWanName{
    width: 260px;
    direction:ltr;
}
.InputDdns{
    width: 254px;
}
.Title_triplet{
    font-weight:bold;
}
</style>
<script language="JavaScript" type="text/javascript">
var phoneddnslist = [<%HW_WEB_GetAppDDnsResult();%>];
var phoneDdns = new Array();
if (phoneddnslist !="NONE")
{
    for (var i=0;i<phoneddnslist.length;i++)
    {
        phoneddnslist[i].ddnsStatus = StatusTransform(phoneddnslist[i].ddnsStatus)
        phoneDdns.push(phoneddnslist[i]);
    }    
}
else{
    phoneddnslist = new Array();
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
        setObjNoEncodeInnerHtmlValue(b, ddns_language[b.getAttribute("BindText")]);
    }
}

function StatusTransform(obj)
{
    var status = "";
    switch (obj)
    {
        case "NormaleRunning":
            status = "正常运行";
            break;
        case "Unused":
            status = "配置未启用"
            break;
        case "InvalidConfig" :
            status = "参数配置不全"
            break;
        case "ConnectionFail":
            status = "连接DDNS服务器失败"
            break;
        case "AuthFail":
            status = "账号鉴权失败"
            break;
        case "OtherError":
            status = "其他错误"
            break;
        default:
            break;                                             
    }
    return status;
}

function LoadFrame()
{
    loadlanguage();
}

function setCtlDisplay(record)
{   
    setText("phoneddnsUsername",record.Username);
    setText("phoneddnsPassword","******");
    setText("phoneddnsDomainName",record.DDNSDomainName);
    setText("phoneddnsServicePort",record.ServicePort);
    setText("phoneddnsHostName",record.DDNSHostName);
    setText("phoneddnsProvider",record.DDNSProvider);
    setText("phoneddnsStatus",record.ddnsStatus);
}


function setControl(index)
{
    var record;

    if (index == -1)
    {
        setText("phoneddnsUsername","--");
        setText("phoneddnsPassword","******");
        setText("phoneddnsDomainName","--");
        setText("phoneddnsServicePort","--");
        setText("phoneddnsHostName","--");
        setText("phoneddnsProvider","--");
        setText("phoneddnsStatus","--");
        setDisplay('TableConfigInfo', 1);
    }
    else if (index == -2)
    {
        setDisplay('TableConfigInfo', 0);
    }
    else
    {
        record = phoneDdns[index];
        setDisplay('TableConfigInfo', 1);
        setCtlDisplay(record);
    }
    SetAllDisable();
}

function DdnsConfigListselectRemoveCnt()
{

}

function SetAllDisable()
{
    setDisable("phoneddnsUsername",1);
    setDisable("phoneddnsPassword",1);
    setDisable("phoneddnsDomainName",1);
    setDisable("phoneddnsServicePort",1);
    setDisable("phoneddnsHostName",1);
    setDisable("phoneddnsProvider",1);
    setDisable("phoneddnsStatus",1);
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("ddns", GetDescFormArrayById(ddns_language, "bbsp_mune"), GetDescFormArrayById(ddns_language, "bbsp_ddns_title_normal"), false);
</script>
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
    var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
    var DdnsConfiglistInfo = new Array();
    DdnsConfiglistInfo.push(new stTableTileInfo("Empty","align_center width_per5","DomainBox"));
    DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_phoneprovidermh","align_center width_per20","DDNSProvider")); 
    DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_phonedomainmh","align_center width_per20","DDNSDomainName", false, 32));       
    DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_phonehostmh_normal","align_center width_per20 restrict_dir_ltr","DDNSHostName"));
    DdnsConfiglistInfo.push(new stTableTileInfo("bbsp_state","align_center width_per20","ddnsStatus"));
    DdnsConfiglistInfo.push(new stTableTileInfo(null));

    var ColumnNum = 5;
    var ShowButtonFlag = false;
    var phoneddnsFormList = new Array();
    var TableDataInfo =  HWcloneObject(phoneDdns, 1);
    TableDataInfo.push(null);
    HWShowTableListByType(1, "DdnsConfigList", ShowButtonFlag, ColumnNum, TableDataInfo, DdnsConfiglistInfo, ddns_language, null);
</script>

 <form id="TableConfigInfo" style="display:none">
 <div class="list_table_spread"></div>
     <table border="0" cellpadding="0" cellspacing="1"  width="100%">  
         <li   id="phoneddnsProvider"       RealType="TextBox"     DescRef="bbsp_phoneprovidermh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField=""     Elementclass="SelectDdns" /> 
        <li   id="phoneddnsServicePort"    RealType="TextBox"          DescRef="bbsp_phoneportmh"         RemarkRef="bbsp_note2"     ErrorMsgRef="Empty"    Require="TRUE"     BindField=""   Elementclass="InputDdns"   InitValue="Empty" MaxLength="5"/>         
        <li   id="phoneddnsUsername"       RealType="TextBox"          DescRef="bbsp_phoneusermh"         RemarkRef="bbsp_note4"     ErrorMsgRef="Empty"    Require="TRUE"     BindField=""   Elementclass="InputDdns"  InitValue="Empty" MaxLength="31"/>
        <li   id="phoneddnsPassword"       RealType="TextBox"          DescRef="bbsp_phonepswmh"          RemarkRef="bbsp_note3"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="phoneddnsPassword"  Elementclass="InputDdns"   InitValue="Empty" MaxLength="31"/>  
        <li   id="phoneddnsDomainName"     RealType="TextBox"          DescRef="bbsp_phonedomainmh"       RemarkRef="bbsp_note1"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="" Elementclass="InputDdns"  InitValue="Empty" MaxLength="255"/>        
        <li   id="phoneddnsHostName"       RealType="TextBox"          DescRef="bbsp_phonehostmh_normal"         RemarkRef="bbsp_note1"     ErrorMsgRef="Empty"    Require="TRUE"     BindField=""   Elementclass="InputDdns"  InitValue="Empty" MaxLength="255"/>
        <li   id="phoneddnsStatus"        RealType="TextBox"          DescRef="bbsp_phonestatusmh"      RemarkRef="Empty"          ErrorMsgRef="Empty"    Require="FALSE"    BindField=""  Elementclass="InputDdns"  InitValue="Empty" MaxLength="255"/>
        <script language="JavaScript" type="text/javascript">
            phoneddnsFormList = HWGetLiIdListByForm("TableConfigInfo", null);
            HWParsePageControlByID("TableConfigInfo", TableClass, ddns_language, null);
        </script>
      </table>
  </form>
</body>
</html>
