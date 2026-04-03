<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link type='text/css' rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link type='text/css' rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js, SmartOntdes);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function stexecutionUnit(domain, Name, Version, Status, ExecutionEnvRef) {
    this.domain = domain; 
    this.Name = Name; 
    this.Version = Version; 
    this.Status = Status;
    this.ExecutionEnvRef = ExecutionEnvRef;
}
var executionUnit = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.SoftwareModules.ExecutionUnit.{i}, Name|Version|Status|ExecutionEnvRef, stexecutionUnit);%>;

function disableBtn() {
    for (var i = 0; i < executionUnit.length - 1; i++) {
        var array = executionUnit[i].ExecutionEnvRef.split('.');
        if ((array.length > 3) && (array[3] == "3")) {
            continue;
        }
        setDisable("startplugin" + i, 1);
        setDisable("stopplugin" + i, 1);
    }
}

function configPlugin(str) {
    disableBtn();
    var domain = str.name;
    var controlId = str.id;
    var requestedState = "Idle";
    if (controlId.indexOf("startplugin") >= 0) {
        requestedState = "Active";
    }
    var Form = new webSubmitForm();
    Form.addParameter('x.RequestedState', requestedState);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x='+ domain + '&RequestFile=html/ssmp/smartontinfo/pluginmanage.asp');
    Form.submit();
}

</script>
</head>
<body class="mainbody">
    <script language="JavaScript" type="text/javascript">
        HWCreatePageHeadInfo("pluginmanage", GetDescFormArrayById(SmartOntdes, "s2100"), GetDescFormArrayById(SmartOntdes, "s2101"), false);
    </script>
    <div class="title_spread"></div>
    <form id="pluginform">
        <table width="100%" cellspacing="1" class="tabal_bg" id="plugintable">
            <tr class="head_title">
                <td><div class="align_center" BindText="s2102"></div></td>
                <td><div class="align_center" BindText="s2103"></div></td>
                <td><div class="align_center" BindText="s2104"></div></td>
                <td><div class="align_center" BindText="s2105"></div></td>
            </tr>
        <script language="JavaScript" type="text/javascript">
            if (executionUnit.length -1 == 0) {
                document.write('<tr id="record_no"' +' class="tabal_center01">');
                document.write('<td class="align_center">--</td>');
                document.write('<td class="align_center">--</td>');
                document.write('<td class="align_center">--</td>');
                document.write('<td class="align_center">--</td>');
                document.write('</tr>');
            } else {
                for (var i = 0; i < executionUnit.length - 1; i++) {
                    var array = executionUnit[i].ExecutionEnvRef.split('.');
                    if ((array.length > 3) && (array[3] == "3")) {
                        continue;
                    }

                    if (i%2 == 0) {
                        document.write('<tr id="record_' + i +'" class="tabal_01">');
                    } else {
                        document.write('<tr id="record_' + i  +'" class="tabal_02">');
                    }

                    document.write('<td class="align_center">' + htmlencode(executionUnit[i].Name) + '</td>');
                    document.write('<td class="align_center">' + htmlencode(executionUnit[i].Version) + '</td>');
                    document.write('<td class="align_center">' + htmlencode(executionUnit[i].Status) + '</td>');
                    document.write('<td class="align_center">');
                    document.write('<input id=\"startplugin' + i + '\"' + ' name=\"' + htmlencode(executionUnit[i].domain) + '\"' + 'type=\"button\" BindText=\"s2106\" onClick=\"configPlugin(this);\"/>');
                    document.write('&nbsp;&nbsp;&nbsp;&nbsp;');
                    document.write('<input id=\"stopplugin' + i + '\"' + ' name=\"' + htmlencode(executionUnit[i].domain) + '\"' + 'type=\"button\" BindText=\"s2107\" onClick=\"configPlugin(this);\"/>');
                    document.write('</td>');
                    document.write('</tr>');
                }
            }
        </script>
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        </table>
    </form>
<script>
    ParseBindTextByTagName(SmartOntdes, "div", 1);
    ParseBindTextByTagName(SmartOntdes, "input", 2);
</script>
</body>
</html>
