<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
function stautomatic(domain,Enable,CpuLoadThreshold,MemoryLoadThreshold)
{
    this.domain = domain;
    this.Enable = Enable;
    this.CpuLoadThreshold = CpuLoadThreshold;
    this.MemoryLoadThreshold = MemoryLoadThreshold;
}
var automaticallinfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.AutoRebootTerminalManagement, Enable|CpuLoadThreshold|MemoryLoadThreshold, stautomatic);%>;

function LoadFrame()
{ 
    if (automaticallinfo != null)
    {
        setCheck("enable",automaticallinfo[0].Enable);
        setText("CPUthreshold",automaticallinfo[0].CpuLoadThreshold);
        setText("RAMthreshold",automaticallinfo[0].MemoryLoadThreshold);
    }
}

function CheckFrom(str)
{
    if (isNaN(str))
    {
        AlertEx("请输入数字");
        return false;
    }
    if (str > 100)
    {
        AlertEx("门限值范围：60~100");
        return false;
    }
    return true;
}

function subimt()
{
    var enable = getCheckVal("enable");
    var cpuinfo  = getValue("CPUthreshold");
    var mermoryinfo = getValue("RAMthreshold");

    if (!CheckFrom(cpuinfo) || !CheckFrom(mermoryinfo))
    {
        return false;
    }
    if (cpuinfo < 60)
    {
        cpuinfo = 60;
    }
    if (mermoryinfo < 60)
    {
        mermoryinfo = 60;
    }    
    var Form = new webSubmitForm();
    
    Form.addParameter('x.Enable',enable);

    Form.addParameter('x.CpuLoadThreshold',cpuinfo);

    Form.addParameter('x.MemoryLoadThreshold', mermoryinfo);

    Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.DeviceInfo.AutoRebootTerminalManagement'
                            + '&RequestFile=html/ssmp/reset/restartautomatically.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));                        
    Form.submit();
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<div>
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("restartautomatically", GetDescFormArrayById(ResetLgeDes, "s0604"), GetDescFormArrayById(ResetLgeDes, "S0605"), false);
</script> 
<form id="automaticallyform" name="">
    <table id="ConfigPanel"  width="100%" cellspacing="1" cellpadding="0">
        <li   id="enable"              RealType="CheckBox"            DescRef="s0606"                  RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"       InitValue="Empty" />
        <li   id="CPUthreshold"              RealType="TextBox"            DescRef="s0607"                  RemarkRef="s0609"              ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.CpuLoadThreshold"       InitValue="Empty"   MaxLength="256"/>
        <li   id="RAMthreshold"              RealType="TextBox"            DescRef="s0608"                  RemarkRef="s0609"              ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.MeroryLoadThreshold"       InitValue="Empty"   MaxLength="256"/>
    </table>
  <script type="text/javascript">
        var TableClass = new stTableClass("width_per25", "width_per75", "", "Select");
        WanConfigFormList = HWGetLiIdListByForm("automaticallyform");
        HWParsePageControlByID("automaticallyform", TableClass, ResetLgeDes);
  </script>
</form>
<div class="title_spread"></div>
    <table width="100%" cellpadding="0" cellspacing="0" style="text-align:right;"> 
        <tr> 
            <td> 
                <input  class="ApplyButtoncss buttonwidth_150px" name="btnReboot" id="btnsave" type='button' onClick='subimt()' BindText="s0610">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">    
            </td> 
        </tr> 
    </table>  
</body>
<script>
    ParseBindTextByTagName(ResetLgeDes, "td",     1);
    ParseBindTextByTagName(ResetLgeDes, "input",  2);
</script>
</html>
